<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Hard_Threshold_Email_Notification</fullName>
        <description>Hard Threshold Email Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>HardThreshold</recipient>
            <type>group</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Hard_Limit_Breach_Notification</template>
    </alerts>
    <alerts>
        <fullName>Hard_Threshold_Email_Org</fullName>
        <description>Hard Threshold Email - Org</description>
        <protected>false</protected>
        <recipients>
            <recipient>HardThreshold</recipient>
            <type>group</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Hard_Limit_Breach_Notification_OrgLimit</template>
    </alerts>
    <alerts>
        <fullName>Soft_Threshold_Email</fullName>
        <description>Soft Threshold Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>SoftThreshold</recipient>
            <type>group</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Soft_Limit_Breach_Notification</template>
    </alerts>
    <alerts>
        <fullName>Soft_Threshold_Email_Org</fullName>
        <description>Soft Threshold Email - Org</description>
        <protected>false</protected>
        <recipients>
            <recipient>SoftThreshold</recipient>
            <type>group</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Soft_Limit_Breach_Notification_OrgLimit</template>
    </alerts>
    <rules>
        <fullName>Send Hard Limit Breach Notification_Org</fullName>
        <actions>
            <name>Hard_Threshold_Email_Org</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Limits_Notification__c.Priority__c</field>
            <operation>equals</operation>
            <value>Red</value>
        </criteriaItems>
        <criteriaItems>
            <field>Limits_Notification__c.Send_Hard_Threshold_Notification__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Limits_Notification__c.Limit_Type__c</field>
            <operation>notEqual</operation>
            <value>Runtime Limit</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Hard Limit Breach Notification_RunTime</fullName>
        <actions>
            <name>Hard_Threshold_Email_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Limits_Notification__c.Priority__c</field>
            <operation>equals</operation>
            <value>Red</value>
        </criteriaItems>
        <criteriaItems>
            <field>Limits_Notification__c.Send_Hard_Threshold_Notification__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Limits_Notification__c.Limit_Type__c</field>
            <operation>equals</operation>
            <value>Runtime Limit</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Soft Limit Breach Notification_Org</fullName>
        <actions>
            <name>Soft_Threshold_Email_Org</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Limits_Notification__c.Priority__c</field>
            <operation>equals</operation>
            <value>Yellow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Limits_Notification__c.Send_Soft_Threshold_Notification__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Limits_Notification__c.Limit_Type__c</field>
            <operation>notEqual</operation>
            <value>Runtime Limit</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Soft Limit Breach Notification_RunTime</fullName>
        <actions>
            <name>Soft_Threshold_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Limits_Notification__c.Priority__c</field>
            <operation>equals</operation>
            <value>Yellow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Limits_Notification__c.Send_Soft_Threshold_Notification__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Limits_Notification__c.Limit_Type__c</field>
            <operation>equals</operation>
            <value>Runtime Limit</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
