Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5067CC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpyq-00082C-Rt; Wed, 21 Feb 2024 12:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcpyb-0007ZI-SH
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:01:55 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcpyV-0003G3-OY
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:01:45 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41LDjdLa018205; Wed, 21 Feb 2024 17:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Td/rfNIfOVCwgOVT/mh2i5lun8ag6BoPDqO5GOB/KBM=;
 b=Dc5v+IazK3qhSTeaNJnsN55ZR4HTyc6+qqCGS1EXoYHCQ3HTCdY3+mM+kxiZM0gEhYnj
 raDxbzcioH0sOWpG2hG3n3fhTo1yi25PktU4+kx9IhfZs3S0BKuwapSRobyEBUWbfq91
 ocVhDO0SBWU9tQG2X8gikW/YYUf8sSK6+6px/nXikBBh10pFPib+Wje+todoh8BITzqj
 DFjUn9++weqnkKwA2NoWCyCG8R1niWL6xv5B502KRAWI6Y8RFf2ApmHgG+qwmqU3mKAX
 Nm/4SukwoyKNmG4i6JysHbrLF6UO2u5XR3o4bb2w4nhQOYaWd0xeapjYqxokjxoHLhzC jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvj6n8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 17:01:35 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41LGBlsV032844; Wed, 21 Feb 2024 17:01:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak89af72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 17:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQC6cRwnogao79KD26CyFpWIhm4CIT0464z3EdIppG5AqrymejOj22WTAWM2tpGpKf9PyAhCMVytzO6BYltoguDY8nBmm79M7EAlNOINaINIBn8FMlIuLCRcvfQ/4mvxcDH40QKWjkCU1XcuBLESLUCzBtWJznU3WICMUX1AQ3/afhNzSOfHXPwgV7Pnw5yGhPMa67v0VMcHVSlGaLZkWaAoha6+BH9HXJKemsA8v0/tgKj5rwd1RP5F7i/N262Dq3kK6G2mpPS1UJMnDWyHOd6PPxaPzK/MCDsmFkJ/F3E2L7xV2h5zl9h4ls4GB/btpqUSlArSH9178cvf6FqtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td/rfNIfOVCwgOVT/mh2i5lun8ag6BoPDqO5GOB/KBM=;
 b=jbSVCP9fk/CsMYBmrDWEsvCbuKXrjrXVEpeg6hxrayp9hnsrsV2MPRhD+/OK37x5P6Ce3FiY01edvZMJ6WstZBOy7T3YIU9P9O/wCFl3GERc3Kg6BOZ0qJibegX2KqiZH14SdZMAtxoX26RlVWtrwxLYvh/+F/Z67ec9R9tbAWVSZ5EQDQvbDEDGatoxdqdpw5GUTPin2lKp5KHe1TZYc2GjgrwTsjoAyfDdAyWC2DhlkZSrV3zA8FhYXm8wvKDZvlHP1ib1xkEbYQ7V3PXPOk7Cx+FEXPP/0DaftBl1hbjvSeHU0RwgER8uAb+AlCPexrWADD67Tz7B2hm5d/xDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Td/rfNIfOVCwgOVT/mh2i5lun8ag6BoPDqO5GOB/KBM=;
 b=uNH0T8xCucyOTqNi1s3hJzz28xoD6vJook6teIWScC8pFCoGNQp989eLC1Uj6ZngmPCJvG/b1U0G1FABQ0ImHYXLkV/D3ZrzklK8/d+GKBbBfaQ8bTpuF2A0K8otSfzi56dmgRm8ZTqu7TJELBCUWbQe2Jr0+MMMwRJlTUHLQzY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB5860.namprd10.prod.outlook.com (2603:10b6:a03:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Wed, 21 Feb
 2024 17:01:31 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 17:01:31 +0000
Message-ID: <3ef2abf3-4b2b-47ae-95cc-0fe1b94d6ec3@oracle.com>
Date: Wed, 21 Feb 2024 12:01:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/5] qapi: QAPI_LIST_LENGTH
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
 <1705099758-211963-3-git-send-email-steven.sistare@oracle.com>
 <877ciy3pzz.fsf@pond.sub.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <877ciy3pzz.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: cf718fa2-9bd9-4ea9-a90b-08dc32fec050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/I31kCat44HF7rVRF072UTZPZh543Ryy+YUD3B1DT0wgvepM3M+DwVIeSSNLjQm8Kub/RPlZvd08jAp5J/SzX3uUt2daBJt0Xg4Z0KvrSS+gOgHI1TFSYtjuBD/EfzqJcx9vUC/3GftGi7EjiiYSaV/vyuGwUdkL5tEQxrq5meLInX7IaSDtHdb0y1zRzHPIj3ZoQENy2ODSbz6MHy8qakUXdrBA0OL9PC0MsLWN6jkijyuctvWnvnE7j/+wQclHz+yO0k4/0I/Itcs+55YH644C/FBvHIfvBvz1zvuakUMGnvUi9vAUgoN6AfYezQelXIgbWGkzVuEwwfKmzYAd8h7DHc51V6uepi/Ig2GeGEjrHSPHQ719l6uPEbm0DvioK+evUUXA2sbIJYCYbynpp2bfXddOJ78bP8inWefPMeIy0ZLV51CNmu7jPldteeUDAkDdr/NoitE9WFTgroHuecEVuixRhDKJWG3/ygYBZ6159zIojePAhHiaMKtWgzrEox+l14zaO+YtWm+GjVdCrhU1qMx49HgIUmigzW9nZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3RHUGt2UEg3UzYvMHRqejFQNVd3WW1GNXF4ZmV2Vm94SlEyYWxBUmZYb1R1?=
 =?utf-8?B?TWVXZUhId0tuTjA2N1Y4eERtbXhYSG9qdkVteG00dFJnblp0L040NmRiZkoz?=
 =?utf-8?B?VFNLeWxyK25HUkNDZ0tqQTFNUUpMdW1KNDBVb2h3Snp2MWdDOElvZ0R2Y2xK?=
 =?utf-8?B?Tm1kWFNzSzZKM1V1a1l2d3d1ZjZVdVl6ZjRubTFUSjRiSUVFcU4yTXoyWERN?=
 =?utf-8?B?YW5TUk13bExpa0d1b1lLRU1EOUxTdGROVGVOTlJ1Zis2U1A1SXhlTjdHQWNv?=
 =?utf-8?B?ZVR6aVdZZU1kc1Zad2hETEdVSGRMZGwzYUpiUzlMKzA2aXkvTmhRamNwTENB?=
 =?utf-8?B?US9vL3MxZEp3VFIyNFdGYUtzTWo0MWJybVErSzlwem5aMnovYmJvT1pvQURC?=
 =?utf-8?B?OGErUHlmMlZicklDRzdUZG96UmxmeWlXZk9VdmwvZ0gwTVg4LzZtRFA3cFE5?=
 =?utf-8?B?SEtMbGxvSTRRbGVYSi84cGdUTDUzamdETTZMM3NCMFJ1d3dXcFd3UzhXUDdT?=
 =?utf-8?B?M3JFYjAyZ0Y0OXhmT2dET042ZzhRTWhEUjRIUGhBc01DWGVkcDRHam1oTDh6?=
 =?utf-8?B?V3F2TjFoNktCaUFTTlpKemxsVFpvc0I1bmJDVFJmTjdRdmU3a1VQckJFYkFJ?=
 =?utf-8?B?eUQ2cjNGckgwYjR2RDlkdXVJSUNDZmZBVUVDT1dXZUhWNCtWbHI2Zmdla0Zo?=
 =?utf-8?B?aDkyQjZ2VHhNc3JNaDA0RWFrSEV6dzd2SmVUUXh1VHVBSVlYbS9QbzNhcEtr?=
 =?utf-8?B?SmRxYWQzNFZMeCtwQkY5UUdSWXV2Z29XWHkwb2dSdGozdGtmVlN2MCtzajFB?=
 =?utf-8?B?bnh0Wlk4SWxBZVVueDRZVm1vTENneldSdElzODliMUhGMmVRV3pPNmM4eTZ4?=
 =?utf-8?B?am1SUUUzNWdaT3I1eW85VTJFY1dhWjYzbmlwVmhtcFY5YmVKRUpDMDRZSnQw?=
 =?utf-8?B?S1dqOHQ3ZUt0MXArblE1VEJIbldWMEQvdWpuUTEyczZEcmVFL3M0WnE0aHFF?=
 =?utf-8?B?by9uMkFpb2FPbnlHampPTFkrN1Zod2tXMktkVVB1NFA5UW1kUGN2UE9PSUVl?=
 =?utf-8?B?dFFtY0dMQUpWS0UyWkNMYTlNeWttcXN1UE5oR3dmYlR3ZnJOb3hLangxaEZR?=
 =?utf-8?B?RjUzZzhCYWVVVGVLajJDVDhqSlFNWmZYRk1ZTjdWV1YrejMvYTl4QTJTK3U1?=
 =?utf-8?B?amRUOUxobmJlcTl6a3pXcXRBMHBwWmkyd2E1cDhsQjFsNnhvOFlTalAzRHZV?=
 =?utf-8?B?ckptMk4wci9vNVdrd1Q2MmpuU2duNk5ML05kS3lhMDUvUlN2em1NamlDWk5y?=
 =?utf-8?B?cjBuNTJkamRVbU91d3ptSUpiaWhoelB4Ni9VUTU5aWlVcmpPZlN4bmdxa1E4?=
 =?utf-8?B?aE51UlBCR3RYUVAxWEMwN0UxRkljNEtPTVZiTTNiK3pQc3c1V0U3YnBncDNl?=
 =?utf-8?B?ajJlQlcySFZ3V3gzSndvVGpWVXdxcVI5NStDdHozcjltM3dPclJyT3IzR3dq?=
 =?utf-8?B?WXNtOW5vVjR2SmdCbmxxWGI2by94WlkzMHJuRDhIbTQ5ZnhxQklzT2NXT0pj?=
 =?utf-8?B?QXVEZXRBT0pnVEplaEtYOVNBUlRLU2hLWjZoSUoyQzBmT2c4dDJEa2QvQTY5?=
 =?utf-8?B?dDZsWHAyd05jZ3crN1lIMHNub2Jjc205RjF5L2VieHpRdlFyU2NtdlBoZmQr?=
 =?utf-8?B?UlMzSy9pdXB0NE1JTU1KSndCVXFpVVNtbG90MUZLbDR5WVo3elZwUHF1cEJC?=
 =?utf-8?B?QXIvN0pRQjZENndicUpqTm44dWV0SEJ4S3BkMzQ1eHpiemJKOWVrWjluY29u?=
 =?utf-8?B?T0RpVC81c3pzdlRrQVRJVHdWbDBTRmtkVy9WczB5SWxaaFZ1ZHNkbWs5aGo5?=
 =?utf-8?B?N3dIOUZyb0xmZ0RTeGZrSjArMUc4cnB6RXBOeDBjSlBQWVFRU0VhK280QU1p?=
 =?utf-8?B?RG1xdXNiS05JajRHN3Jvckh3L0ZydXVEMnpSSVJjM0pHMEZVbXhteTRUa1N0?=
 =?utf-8?B?eEljVUw1OGhYR1BlY2tIUUJJaGRaY2Y4bmpxYjIxZWM4UDJJYTBWTlpXdFFW?=
 =?utf-8?B?VDdxK1BvQy9oaDF3R3N5VEpPK2xPa01zTzRCR1lNZldiRUV0MDk1RDNIcUJM?=
 =?utf-8?B?WG96dUZjUG42N2p1cVppVXFhWjFxaWM0VjRmWmFhWE1nZ1BhUlVjKzN6OFZS?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0lXQ3Fg5Qgz68arTcZ71ASRUJ8o4sYJG8WQFMDRWzkC1JK8VD7/XlCkboEh3tmlzK1X1j9Gk3NKpbcJZmedKXY7k9wxf1nFkggzlrPYCwoq/4Tw1hrRGtk5yuNOZVdOaNCozzx78CjYZvXJ+IgGBvAbhoP+lBtW113WcVlS+SeD9L2GLzVvVy3wI+KXVvjEiez0k2K1nLBhBMqUFb0LK1IY4EI/J+W3R0js461E84TBSxrxLCYJ7jXCyoq3Wng69mImYdFHZ7/hC06uiIhiRrdNrrTqO2ku7ji3wYMoaGe5BX9QwoNRcuFy2ucUMRwYnfabHeY199C83rMPyudJRLzVymsRX6sqTRWOIC1m3U38R1593FYXA3Ju/QxC7/1Kcm5y3hlDiv54WwGjzDDs3GvL7krKP2jHLThFvAZNTEYsJwXDmhGf9D/++bDemyQxKhcrA1PT/KsoC0WGXrTG+HvNQePExfiE4FTDluwyrNOiCzD0a90bRCcIc/OA7CequmGEbaGR8O6pDPftYQZgT+7vJN/8tLn6qou//yu9cQ5AmAEUpD6kGYj+u8Sun3dqzIQFiD6aevQpSNcDuJWNUK0iXuml/N38qg57lqJ7FwKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf718fa2-9bd9-4ea9-a90b-08dc32fec050
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:01:31.0447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S796HaCfaKjAruSoijszIPndEFTTPBBciMas7twgqSN6P1q3Qf3EDPOyd4BnDFZUkcq4GApJ238Ae+AIIqXIsHLCSPW6rBP20SjESHJK1cY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_04,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402210132
X-Proofpoint-GUID: H2xo1LMTA9nFgBGNnjkBqQutB9HbC10I
X-Proofpoint-ORIG-GUID: H2xo1LMTA9nFgBGNnjkBqQutB9HbC10I
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/21/2024 8:29 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/qapi/util.h | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/include/qapi/util.h b/include/qapi/util.h
>> index 81a2b13..e1b8b1d 100644
>> --- a/include/qapi/util.h
>> +++ b/include/qapi/util.h
>> @@ -56,4 +56,17 @@ int parse_qapi_name(const char *name, bool complete);
>>      (tail) = &(*(tail))->next; \
>>  } while (0)
>>  
>> +/*
>> + * For any GenericList @list, return its length.
>> + */
>> +#define QAPI_LIST_LENGTH(list) \
>> +    ({ \
>> +        int len = 0; \
> 
> size_t

ok.

>> +        typeof(list) elem; \
> 
> Name this @tail, please.

ok.

>> +        for (elem = list; elem != NULL; elem = elem->next) { \
>> +            len++; \
>> +        } \
>> +        len; \
>> +    })
>> +
>>  #endif
> 
> This is a macro instead of a function so users don't have to cast their
> FooList * to GenericList *.
> 
> The only user outside tests is strv_from_strList().  I'd be tempted to
> open-code it there and call it a day.  Or do you have more users in
> mind?

That's the only use.  If I make it private, I would still define it as
a static subroutine in util/strList.c, because it simplifies strv_from_strList.
IMO providing a public list length function or macro is pretty basic, but
I am not wedded to it.  Your call.

- Steve

> If we keep the macro, please align the backslashes like this:
> 
>    #define QAPI_LIST_LENGTH(list)                                  \
>        ({                                                          \
>            int len = 0;                                            \
>            typeof(list) elem;                                      \
>            for (elem = list; elem != NULL; elem = elem->next) {    \
>                len++;                                              \
>            }                                                       \
>            len;                                                    \
>        })
> 

