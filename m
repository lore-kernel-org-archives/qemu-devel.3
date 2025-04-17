Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D9BC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UJw-000358-4D; Thu, 17 Apr 2025 14:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UJv-00034O-Bs
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:50:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UJs-0005br-TW
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:50:42 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGN5cf024301;
 Thu, 17 Apr 2025 18:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=w7GuugqZ7yPzCuOUfBpvjrcd+WmV9Q0Lh++ANypZCyE=; b=
 bYgD6JKIpBEoH5i1faPZgHTdO142pvEHK5JGIXphuq/WCIOwGJE2AwpXtubp38vh
 R8C8G6W7Bp7D6kn/DoKyQbUorh7IUMnDYmEe/lMH/ZMk0K30MB99fb/PPkQoFz75
 GtZgMs3MXhrb//rdDi7A+2K8vEmrZ4LGo6mX2Rt/YL+WNUgpJEkrCr5o3gOm4b8g
 g7QfObKXQx3M8agsEFTDIXWP8LbXU7zI6BJlAh9Do7fVxpxvwz82nXDP0jE7F+FA
 4ygt1uEyt9HhUHQ+bKVKHfWcRBBw6sBqBzaawCe/apd3ug+C8Wo0jCRxooyc9rOQ
 RiFgF2KOotil7C15T4IwDQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4619446xhn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:50:31 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53HH62JU009166; Thu, 17 Apr 2025 18:50:30 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013076.outbound.protection.outlook.com [40.93.1.76])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3nndbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:50:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltVMaAUUoUH1Iog/Bu1e6Tk86pTfPNJGneS+ydDQ77mOYfIt7iAFdJu4mwFI9w46uLdrIM4n4G7g+PBqcBhHAK1KfjFwMf1tdk4YGjxNewkCJwuEHiN809/BdzK9IumW3lo/C9NE+O42GY6HygX8a780G3wDAMheer0SYtVSvyAuMAOtpsoZjE27roVJCy4d79b1UyB9bd1IkL1bHU+RkUaq90+S9r+lc1BgcKUNVFjsRThXzBAFcaJa5QMWam8/fx7SY9MHstxaAbNCq2L7YutunPNoMnzN6l77JTajpCJ5sjUyXqt2IsCL9Zf/8/K5xpZEyrICdYeUJHq+J8j5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7GuugqZ7yPzCuOUfBpvjrcd+WmV9Q0Lh++ANypZCyE=;
 b=ExdpzswaGNRcINAiE06qRXa29s3Utof9mOG6vMRcW8rHTtcINCJVte9LI2pIqibbaOaFBM/FOMIPM/aW35fRbJwI/c6V1RCMZnKAT2sFcb/fnfkNRz4dkohEWZypH2UUIEJrrN+XDvML0uxVis3m/uvKHMQl/G5khlJY5FyID24TRrIMCfItksmDXOMbzVZRrAiTWukY1RjS4PPnzLkftnvVHnR1PqNCzWN25VvLWBEfD0EJS1z+INIh+DTEkIA5apOr5yLfdXxCbTjgrNNl6VArE+RUhBIu2xzz6yZ3sikyaLRuCLHhzI3+ssDuw/qhqr2zXCH2ACZx6XkDYVasRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7GuugqZ7yPzCuOUfBpvjrcd+WmV9Q0Lh++ANypZCyE=;
 b=kXtixTAOK6jSGKifus6Wi046v8Ako0kgJqqzlpoRj0HBfOXKAVVT42oITcP36kX2pLsnWD7d04UkuQirtUhJc7C7ir+sZ67Lak4i+K2cHdMtr+r9d6lYPxvVq4lDShi+KwO+ITcfpFP9mhGqZfp5R4haNmpYyb8Ur0zNBfv4P2o=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by DS7PR10MB4927.namprd10.prod.outlook.com (2603:10b6:5:3a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Thu, 17 Apr
 2025 18:50:28 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 18:50:27 +0000
Message-ID: <ed88a2ff-6302-4e73-b6c2-9f6160c16162@oracle.com>
Date: Thu, 17 Apr 2025 14:50:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 10/13] tests/qtest/bios-table-tests: Update ACPI
 table binaries for microvm
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204402.3010-1-annie.li@oracle.com>
 <78a52486-d86b-41b1-88b7-727371f17ecf@linaro.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <78a52486-d86b-41b1-88b7-727371f17ecf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:23a::6) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|DS7PR10MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: ad318a0d-1cee-4523-2818-08dd7de0b854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: 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
 =?utf-8?Q?C6nEcpcsUxE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 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
 =?utf-8?Q?ef3yNaBmbcAdaFEPyt2jk9WUT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dofAflOTVOUUnh3jbDNOy6HjcCSdniJ4WIbicro42MGWDrOBimHyRSErVoXMaPTn+3bLL6Is2PHYXhwU1sOkTxgz6FuKat5CJNb1btkDyki+wXrQpTlwUwqBa8KyzTfuvNWCdX0Bqd0rhzTKv8GIPqVtKgOpOpxlZbn91/c4ojmtqMnDOWxMkGA0NjzKWhrNAQlATaofYW5KmPDk+ymdpAaKpGtXVG+lPrxgE9ZeASxcWgf2mg3GL02Mm2eu2UVsx/7XnBYTrC4Kx7kghRGYtWGXDX8WyvjKnWVf9WxVBxiudi5+GuTOCe1CzARD3BBoC7rs/q4vEfcofOtlkmHlmbPqkKzWOZhAzKBBJzruLivioes0MQ3gWnOKVzDmvpmTN+fFBjr8fx+rFbUnDgvoAAMe8AxHe+RqavCKW5vaz3ol31KV1rXAvkliemqBrHwHa58Wi8RlwB1pnix5DvZMZSyLZTqowZsB1ViW3MFXNuI/lDWTD588i3mYxz0XCmiLyQuVjVgBrWF1aSEr9lmqyWrEeMGjpSkKsBo+CSIyv3/2HRl1+ouAeruyQxjKAe97y4/mq4FdSZZH+Q5X71YTPerY1kcaopzpG+OLDEcuJQM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad318a0d-1cee-4523-2818-08dd7de0b854
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 18:50:27.8247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+D3DlY0FgFWPHYWP9skE8HVUYEf04n1N9ejR80UINDXEW89gmiVEIrnPG/bl7Kx/4mEYKntQLTw+Qe35dkVyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504170138
X-Proofpoint-GUID: gzpzUIgjqmQs5drIGru4MGtbzoHMRJWq
X-Proofpoint-ORIG-GUID: gzpzUIgjqmQs5drIGru4MGtbzoHMRJWq
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 4/17/2025 1:36 PM, Gustavo Romero wrote:
> Hi Annie,
>
> On 4/11/25 17:44, Annie Li wrote:
>> Following is the diff generated by the step 5 and 6 in
>> tests/qtest/bios-tables-test.c
>>
>> Diff from iasl to show changes in DSDT table:
>>
>> --- /tmp/asl-2F0N42.dsl 2025-04-11 12:50:02.892883467 +0000
>> +++ /tmp/asl-C81N42.dsl 2025-04-11 12:50:02.890883378 +0000
>> @@ -1,30 +1,30 @@
>>   /*
>>    * Intel ACPI Component Architecture
>>    * AML/ASL+ Disassembler version 20210604 (64-bit version)
>>    * Copyright (c) 2000 - 2021 Intel Corporation
>>    *
>>    * Disassembling to symbolic ASL+ operators
>>    *
>> - * Disassembly of tests/data/acpi/x86/microvm/DSDT, Fri Apr 11 
>> 12:50:02 2025
>> + * Disassembly of /tmp/aml-481N42, Fri Apr 11 12:50:02 2025
>
> Same comment from 4/13 regarding diff confusing git am and b4 and 
> about the filename.

Nod, will fix it.

Thanks

Annie

>
> Otherwise:
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>
>
> Cheers,
> Gustavo
>
>>    *
>>    * Original Table Header:
>>    *     Signature        "DSDT"
>> - *     Length           0x0000016D (365)
>> + *     Length           0x000001BA (442)
>>    *     Revision         0x02
>> - *     Checksum         0x11
>> + *     Checksum         0xD5
>>    *     OEM ID           "BOCHS "
>>    *     OEM Table ID     "BXPC    "
>>    *     OEM Revision     0x00000001 (1)
>>    *     Compiler ID      "BXPC"
>>    *     Compiler Version 0x00000001 (1)
>>    */
>>   DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
>>   {
>>       Scope (_SB)
>>       {
>>           Device (FWCF)
>>           {
>>               Name (_HID, "QEMU0002")  // _HID: Hardware ID
>>               Name (_STA, 0x0B)  // _STA: Status
>>               Name (_CRS, ResourceTemplate ()  // _CRS: Current 
>> Resource Settings
>>               {
>> @@ -66,56 +66,82 @@
>>                       0x00000009,
>>                   }
>>               })
>>               OperationRegion (EREG, SystemMemory, 0xFEA00000, 0x04)
>>               Field (EREG, DWordAcc, NoLock, WriteAsZeros)
>>               {
>>                   ESEL,   32
>>               }
>>
>>               Method (_EVT, 1, Serialized)  // _EVT: Event
>>               {
>>                   Local0 = ESEL /* \_SB_.GED_.ESEL */
>>                   If (((Local0 & 0x02) == 0x02))
>>                   {
>>                       Notify (PWRB, 0x80) // Status Change
>>                   }
>> +
>> +                If (((Local0 & 0x10) == 0x10))
>> +                {
>> +                    Notify (SLPB, 0x80) // Status Change
>> +                }
>>               }
>>           }
>>
>>           Device (PWRB)
>>           {
>>               Name (_HID, "PNP0C0C" /* Power Button Device */) // 
>> _HID: Hardware ID
>>               Name (_UID, Zero)  // _UID: Unique ID
>>           }
>>
>> +        Device (SLPB)
>> +        {
>> +            Name (_HID, EisaId ("PNP0C0E") /* Sleep Button Device 
>> */)  // _HID: Hardware ID
>> +            OperationRegion (\SLP, SystemIO, 0x0201, One)
>> +            Field (\SLP, ByteAcc, NoLock, WriteAsZeros)
>> +            {
>> +                SBP,    1
>> +            }
>> +        }
>> +
>>           Device (VR07)
>>           {
>>               Name (_HID, "LNRO0005")  // _HID: Hardware ID
>>               Name (_UID, 0x07)  // _UID: Unique ID
>>               Name (_CCA, One)  // _CCA: Cache Coherency Attribute
>>               Name (_CRS, ResourceTemplate ()  // _CRS: Current 
>> Resource Settings
>>               {
>>                   Memory32Fixed (ReadWrite,
>>                       0xFEB00E00,         // Address Base
>>                       0x00000200,         // Address Length
>>                       )
>>                   Interrupt (ResourceConsumer, Level, ActiveHigh, 
>> Exclusive, ,, )
>>                   {
>>                       0x00000017,
>>                   }
>>               })
>>           }
>>       }
>>
>>       Scope (\)
>>       {
>> +        Name (_S3, Package (0x04)  // _S3_: S3 System State
>> +        {
>> +            0x03,
>> +            Zero,
>> +            Zero,
>> +            Zero
>> +        })
>> +    }
>> +
>> +    Scope (\)
>> +    {
>>           Name (_S5, Package (0x04)  // _S5_: S5 System State
>>           {
>>               0x05,
>>               Zero,
>>               Zero,
>>               Zero
>>           })
>>       }
>>   }
>>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   tests/data/acpi/x86/microvm/DSDT            | Bin 365 -> 442 bytes
>>   tests/data/acpi/x86/microvm/DSDT.ioapic2    | Bin 365 -> 442 bytes
>>   tests/data/acpi/x86/microvm/DSDT.pcie       | Bin 3023 -> 3100 bytes
>>   tests/data/acpi/x86/microvm/DSDT.rtc        | Bin 404 -> 481 bytes
>>   tests/data/acpi/x86/microvm/DSDT.usb        | Bin 414 -> 491 bytes
>>   tests/qtest/bios-tables-test-allowed-diff.h |   5 -----
>>   6 files changed, 5 deletions(-)
>>
>> diff --git a/tests/data/acpi/x86/microvm/DSDT 
>> b/tests/data/acpi/x86/microvm/DSDT
>> index 
>> f477668f2ee80241e47b340ad4a30f5480df2049..ee199a4fb65ab1a2d811f37d9b5bc67bccd34939 
>> 100644
>> GIT binary patch
>> delta 127
>> zcmaFMw2PU`CD<io7b61$)76Pw(oD|c6V<breAy>X_GQ$Y_)vy#fxzVI1TFyvE`hdS
>> zpMZ(K6f`w~v=c|Xho=jV;{_hR=!O`eKs+NiBNJnEBM+G480-WTnJmHREo~ex#LmLS
>> V%)r1PAP~dA5g%*{7GMPm005{09v1)r
>>
>> delta 54
>> zcmdnR{FaH!CD<h-myv;iNpK>UG?TmVMD;8tAGV2;eHmpZK9rfv$0$2FjM0<JG+v0E
>> Kg^QJefdK$+3k%2q
>>
>> diff --git a/tests/data/acpi/x86/microvm/DSDT.ioapic2 
>> b/tests/data/acpi/x86/microvm/DSDT.ioapic2
>> index 
>> e5924a49962e0cff4228bcfc77ebcf48cb4a2219..7512d1527cf222d6f75a92f051f9eda402e28376 
>> 100644
>> GIT binary patch
>> delta 127
>> zcmaFMw2PU`CD<io7b61$Q~yLRX(ng!iRxKQzU&hx`!ecHd?>@WKwxrp0+#>-mq1&v
>> zPr$@q3YwZg+KD6H!_$Sw@d6KDbVCeKAfAz%k%=+7kq69i40ZyFOqO8umNt$TVrSuE
>> UW?*0t5Qt&mhz~Xe3$OwO0ErwO(EtDd
>>
>> delta 54
>> zcmdnR{FaH!CD<h-myv;i>GVV{X(o5!iRxKQK5P>w`!dQ-d?+)Sk5P7V7^5ebX}l0S
>> K3l}Q`0|Nky8w`Q~
>>
>> diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie 
>> b/tests/data/acpi/x86/microvm/DSDT.pcie
>> index 
>> 8eacd21d6ecdf9a3cd3e4f03cf1b40748dcbf53e..5e3f80cbf82cab52fe310160c88d0a11ff069bf5 
>> 100644
>> GIT binary patch
>> delta 128
>> zcmX>vK1YJfCD<iIhKGTHiDM#{G?VMziRxKQzU&hx`!ecHd?>@WKwxrp0+#>-mq1&v
>> zPr$@q3YwZg+KD6H!_$Sw@d6KDbVCeKAfAz%k%=+7kq69i40ZyFY?feL%O!0bFT~Em
>> W#mvCKARrLKz!4v83Kn1m3IG6dDjnGX
>>
>> delta 55
>> zcmbOuabBFuCD<k8JU0Ualj}q-X(rE|6V<breAp&V_GOfv_)umtAEWH%FvitfT&D3t
>> L>?~ZY3=9kauQ3gZ
>>
>> diff --git a/tests/data/acpi/x86/microvm/DSDT.rtc 
>> b/tests/data/acpi/x86/microvm/DSDT.rtc
>> index 
>> e375473b5f033d374dd2a64a9f814fd16c3e262f..11258908703b64a835bd14307490c62c5ef7301f 
>> 100644
>> GIT binary patch
>> delta 129
>> zcmbQj{E(T;CD<k8AtM6=)8dI-(o9~G6V)d&`La*k<;$oynS)V=Z-Kz%>I5zU1}=fN
>> zV4r}=ii`@Hnm~pVN4$rp3y<Rk9=_;?7@$BrBR3-xV{{`AnBy4i1QeNU&*&{}952Mq
>> X!o|$Mz#t$H!@v<AYzh`&1quKFJNg{0
>>
>> delta 79
>> zcmaFJJcXIdCD<io3L^sp)BTBD(oBA$6V)d&`LIpg<;y5LnS)VAI=V?RAUw#4Bi_T)
>> jg*U)2z`)tSnSmod)YFAway6qjmub8ZI|~;p0|Ns9En5;N
>>
>> diff --git a/tests/data/acpi/x86/microvm/DSDT.usb 
>> b/tests/data/acpi/x86/microvm/DSDT.usb
>> index 
>> d63fd84620a2689120b32262f964e6a098d71632..7250d9f8ad45fca91afeda1089090eee11cd6594 
>> 100644
>> GIT binary patch
>> delta 127
>> zcmbQo{F<4|CD<k8H6sH9)6<Du(o8N=6V<breAy>X_GQ$Y_)vy#fxzVI1TFyvE`hdS
>> zpMZ(K6f`w~v=c|Xho=jV;{_hR=!O`eKs+NiBNJnEBM+G480-WTnJmFrBW)Zn#LmLS
>> V%)r1PAP~dA5g%*{7GMPm006!m9&i8v
>>
>> delta 54
>> zcmaFOJdc^nCD<io9wP$-lj1}!X(kV`iRxKQK5P>w`!dQ-d?+)Sk5P7V7-JQeX}l0S
>> K3l}Q`0|NkddJG`|
>>
>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h 
>> b/tests/qtest/bios-tables-test-allowed-diff.h
>> index bb028db137..dfb8523c8b 100644
>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> @@ -1,6 +1 @@
>>   /* List of comma-separated changed AML files to ignore */
>> -"tests/data/acpi/x86/microvm/DSDT",
>> -"tests/data/acpi/x86/microvm/DSDT.ioapic2",
>> -"tests/data/acpi/x86/microvm/DSDT.pcie",
>> -"tests/data/acpi/x86/microvm/DSDT.rtc",
>> -"tests/data/acpi/x86/microvm/DSDT.usb",
>

