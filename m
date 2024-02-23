Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D8FC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rda9u-0005lw-D0; Fri, 23 Feb 2024 13:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdZuu-0004zg-LB
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:05:07 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdZun-0008BV-Hr
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:04:57 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41NG44cm032269; Fri, 23 Feb 2024 18:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0AeAVaiAvDXVgj2oHB86QlC74+x+0OGZTenr1Xx+r20=;
 b=VVBLI81/peCnVnb/PA2fzKLpd/26GacXzbvx0DMGPhzPZfZRkIjWOVcJ44nT8ZX/nTaH
 kw+Z2MDF5typPjm6tixWdG+9DjJ9uTEADODenXlY54+VHIdnjHCJh6986yITfvBdK6to
 7wext6OowwHNH1YBdI9tSDM4L9u5j2gmIw8N4Qijn0c9rVbyrrJz2/dcGH2pFsANsIt7
 pApGiFKnOiAGClBfiYGtSw5WmpQXXvWyH417/YC+AlnbL1JDPVXnsDI5JvJ/Qs2fwqFx
 F0ZQ0s2LK3BC2R9CcBQwcbnmMLY4rs5LeVUznQOtsFj6qFFbYxFIPYvL/atXUW8fAAWs ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd4knyymw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Feb 2024 18:04:47 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41NHEY14019154; Fri, 23 Feb 2024 18:04:46 GMT
Received: from outbound.mail.protection.outlook.com
 (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8cemk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Feb 2024 18:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBujIAIKUp/pw0Q1qRm84CK0Ygm7Dwks6+MBS7mo3bb16r5oxI//ehajuzlhs61NzDoZYarMUMs6LnwPf4+K2X2/rU7qfjIbpQGSXt+PaWiCYUVC87kEXknIdy3EHxMHLAknLh8R5i9cZgZYteVhVRhEztq38hIEwWgvgMxOWRB/nyo2K06oJMQjCoY3M4mLLcdhEJOu7ZHbu2TNeZI5t6GNjfMXHxKBtSXB1hFSr1FdeoLZA/CtHauNo3ikCEL58tHuFa0D4QtO0yINwP63BaHVTEOFDx1GJJdLtLXFuSA4d8egYySKxDDbtvlAgpq4LOPkUjkHjxUSjGEMEql3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AeAVaiAvDXVgj2oHB86QlC74+x+0OGZTenr1Xx+r20=;
 b=UTsPNBvuV4tMxDOE6StliKR9gt+1PCdByUDji9PAYtHCHI8Wb9JkmSYr+npv1+jim2PRr+mOGvhIuRPAh+7txKyEKFoWnArxuKTi8rcPO9DGAfH2pW2o5feRh2V00esYu3DoI8Pxe5A9uKMgussbXMeiMacYw1n0VAIQd611vGmP7J+MgtuXyNF40ncd7lLsFolkHOGv6QRXPpyocRP2HDqpCAtMeZVctW65k4GDu3FEQVrDpSkiBQOdScBIgfXSl8IYIFx2zpmCA1vrVD47MOh4gRV5RoT+2Amza4atZs42rntQZd0F+ELW0eKF4NTqa+O1iFXHB7h+/d9xBJJ/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AeAVaiAvDXVgj2oHB86QlC74+x+0OGZTenr1Xx+r20=;
 b=Mk5Q6aDCyNTnJvQ+301eDhDILD6aTkZbFcf7nFShRMBN9E6vIxcdTrjX2Ml5x00XHM0Mt4YkLL9UjWdkaTKNW63OtJ0gXdFWXSdqhBIprJcCZyN0r8M9VIWQUMx5NLf5fvEFDUFVBfHZF7ZTQ5Pk5X0wdK7L8TrgStpASyPTmf8=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA1PR10MB5784.namprd10.prod.outlook.com (2603:10b6:806:22a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 18:04:43 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 18:04:43 +0000
Message-ID: <d126c937-c705-476f-baa5-d5e258780cc0@oracle.com>
Date: Fri, 23 Feb 2024 13:04:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/5] util: str_split
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <1708638470-114846-1-git-send-email-steven.sistare@oracle.com>
 <1708638470-114846-2-git-send-email-steven.sistare@oracle.com>
 <ac4a19b6-9290-4c97-bc7d-eabfef079895@linaro.org>
 <34d846ab-64e9-4fd4-8d99-62315a7c0f3b@oracle.com>
 <ed0f8248-81d0-41a7-a8a5-05fe0575e2c4@linaro.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ed0f8248-81d0-41a7-a8a5-05fe0575e2c4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA1PR10MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 8369d9e9-9ded-4690-85b9-08dc3499e9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDPYDAUJD74otUuIsJ20oUsfTTqP9cBhS/HYKrbUQH6owhab06vHadM9JAe819HrFBd3qC3/Pi5XMGVM9fAZundjo5E8MdjsuuBsI1f+YoCToKqD08snMwAalzzi7HdGpEMOB0l2hGungQ9QkUyQBFxGUREpGozSBDW7OBlBBxeUqW5UIqS6isqI5RE/vIhZ76IIiFCTOmBpjPOvFYospXTyGH/xMMD3ZMcUQsYUoKdf7idoBCiQaf1dao03eKQECzXJmNONNfgn5kjol9h6jm6Xxoj8lLKSL6AVB/K0j/kQpK1CZ/43aN5nYTPPN4l3aiWCHu8BBIrI5qGC6pK4+DdQZgyEPF5Kg7weEfVuno3OvUufMWY8KrgGehZQ4MF3mZDVZFtJHsM95oKj5PMk0ppBAEGsP2ubfCPWe9ZJTgpNViaz3b8/Tpy66wK9M3oC3VU2kjoHjQ099AidJ2VADZobS8C9O95UdSxCcDJ8p4io/e0gO93FiDVtJwVCSrQtnE6c7+izjUIYW+lFHvn/MfnjI3IpttmZ3OZ5u9qtKWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDNwSGZGdytzTHRhd0oreldUZlBjT1VVVy9pNGUvTlh5d0hqeFJReS9Ra0RF?=
 =?utf-8?B?ZEtGNHJRWm8wRDRGWStLbExNK0JORldXVVNuYTVoYnhxL1d0Y1RCcjU5TG1K?=
 =?utf-8?B?VTBkU1hmemZSR09xLzM4UmxWSUg3RnJad0dzM2xqQmYxS2lvQ0tsS0xQb0p4?=
 =?utf-8?B?ZW1YVzFEZ014NFpUMkRNRGdCUjFBWnNheDI5M1VPQnZrRFRkRVo2NkpXVlRG?=
 =?utf-8?B?d2h6dDRvbVJNT2dXMDhUYURTYzdPb090ejhHSDM2cjVqdWdJUFp5NGN0KzN4?=
 =?utf-8?B?MndidWZmUDJqN3VyQUdzaXkzdjBNWm9XUkNLdW5UQUVXSWNrb3lpTjN2MU5p?=
 =?utf-8?B?MGE4c0VvdDZHcDBuTkRiYjBnWkpTZFhnWDU1SXJKS21sdHdWRXNlZVJzK1di?=
 =?utf-8?B?VU9NdmFLT3R5ZlRWRldyTkUvaHdkTWJaRDllUTd3QmtqelQrR2w3VDdtblpP?=
 =?utf-8?B?a3loQ09zTVFVSHFzQUtRTWYyL094OXArWlJBZnI4ZFo3UVFJWUdoU1dKWE1y?=
 =?utf-8?B?UDhpWDFObkNMNUZRQ0d6b3M0UW9haGlMZFFySXdlYlNNQitVTUlPL29BeXh5?=
 =?utf-8?B?RENNWGRub2t0WkFVejlKbmorY0NHdS8xTEtwUHpobUZBanFDRmU0WFkrQ1JK?=
 =?utf-8?B?ZExHWWFNVHdwcXJ4NVIxY2YzZlo3WU1sV0U5dGRySWpUbExDSFZVcWhZRHox?=
 =?utf-8?B?K3pMZzJKeWZsZ1NmZ3UwMUsxR3VOS1V5alZTbitaYVJORFJrS2VuMEZRZEp0?=
 =?utf-8?B?T3dCRHhUakNneFpRRm0xeDRFMEk1dHltdFBxWjZSRHVqU1VvV0Z0N25WMzNI?=
 =?utf-8?B?Sm1DOWZhWDJkejJLTm04dFp4NmorVTBRTHlCU3QyaEVKUUJuRmZtTE5iUjFU?=
 =?utf-8?B?eEVqblpoRVJ0bkg1Rm1DWTlHVC9xMElCbi9naVpremYvdkgxOFZqWWNXamIr?=
 =?utf-8?B?bCtTQ08wNkkyMkNDcUo2TG1Lb1E4THV0dnkrOWxldHhwSURwaVloZjNRaVdh?=
 =?utf-8?B?YndENjNBYTRaTVdhU2gvdjV4VzJLRXNkZzYyZ29UbVVtdDM0K1J6emVTTGxi?=
 =?utf-8?B?UXkydkxueVlOY3dHZXVhWHFndXhnVDRWVXZ3TU8vaS9BSVVqMUFaVTNHTDBB?=
 =?utf-8?B?dS9QU2dlcUhZaEthSGcrQUZjbmQ2bkpVaFRwVDY5R1JwOUhPbjJEZHVUeTJD?=
 =?utf-8?B?eXpXekVIWXFCSGZmVEZkaEgzajg3YjZMOTQ3V1B3bzhTTW4zTm9aK0dTSFhr?=
 =?utf-8?B?amQ4RjdOcEh2MG15dENDMUI0ay9XTUNSSnF2M3J4Rk5tSC9uT2VxMkVHMlJB?=
 =?utf-8?B?M0pQZk1oNVU4RmxVV1NlZmxtdUMwZ2dLSnlkTTZSV3ZLN3VTR0E1UjhLMDgx?=
 =?utf-8?B?Wm5YRzJtUXV1R1IxMWMvaTk0NTAvazhKR29zUTRvZEdsY0xOSkhseHl1OFVX?=
 =?utf-8?B?MXlOSlhoczgrSHRFbGJTNXBENFZCbFp0SEhHQ05SeDFla3pWUlM2cXhWVUF1?=
 =?utf-8?B?bVZDN05yd2h2T1FFTUlxdDV3dklKTDBwSTZIK1V5cktiMVhoTjlyUTZNZVlX?=
 =?utf-8?B?TS8xMHZRcVdWZ1U5SDZ0b2cvMy8zNVdGZmhuc3RsQkhjWElDTi82RVRUaVdo?=
 =?utf-8?B?VEVnZkxVK3JIcWgwQytOajNZV2I1UFlPTmlVcXd2K21KcjR4OWJESWVyU00v?=
 =?utf-8?B?VmF5Z1NRcm4yZDFPaWgwTVBRUWNPTTh1TWFzaDdpcnJsdk5odzhkMUd0RE5P?=
 =?utf-8?B?N3cveSt6S09uSUpwV09oeXMwaVdDVWIvRHg0ak15NHlRK3YydHZiNkhGMyt5?=
 =?utf-8?B?R3lsZWYrMlVrUXR3eWdZZDJ5SXV3czhEMmhvcDRYUk5zcjhpUS9VcE94Wk5Q?=
 =?utf-8?B?Rk5GSGRNcVIrWStMME5lTWE2aG5kVHAxZ1ZYcnJDNURTV0FUb3FzNnZaZTF3?=
 =?utf-8?B?QW8zOEdJTWQ3RWhZaVlnMHFyaTdoWThmQlRZdjEwUzNMU2gzK1laRjN3VEJm?=
 =?utf-8?B?NEFXRk1HaGVwVEVlazBPeDNMZXpaL0VtZVhFZFB0T1FoVjIrVFRtNkdrQ2VS?=
 =?utf-8?B?TXp3eFR2cUd4MjdwZ1o1Yk8wT2NuakplYzNiakx3ZTcwYlFWNEhHemNFNVhn?=
 =?utf-8?B?R0l0QlNMUU1zZkJrWnNKcER5OXEwcmNQQW1VWGxibklwZUozeFR0Yk5SNW1Q?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e+FpyUZfle0FwB+o+HZr3m+eYuv2jl1xViwPH/Iv+x90MJXnRZOV/VySs3MqQwrdfzPsV2HO2GBnKyiPSOeYgnYRVj5dgiZ++VoW/qT17+pDMKBNQr1O7IcEzsRlixKLfqoy9zT16sHeVU76OCM0EiEr6HKdusOUuwOjr+mmUQlX6vfuNnW0HPo/3RPE1sb62I7Q4hdCgg+ebv8IZRGsQi8oX5zIZszV6EHFQ5Q/hhTQ+Ua5iX9md7yvoLUt43cbFiQG9Rzmj4ruCVaqgAebISUDRgEPd+2gxQRRsgkls7jY2bt+IOkpS6wLns2Yk3M24q7iQ7ET2JPK8GwN/CLGi1GvjD/4+CUHrasrlL/KGkMz2FcJ01BeegG42VkhRHmJmL6ZnW7Coj60EuX68nqmhjutyMlLwbRgVs5JteVrX8ra7NIr4evzdMLZ2mZkU2JLjzWbR2IuECu4+ooiNlXBV3bdWzo1+xCtpzJI7GjyIMZfT7Hofn/s1fA3ZSen6jmfvizDZiEnjwW2NlDID6Uo1nFAfVNO7CRRoA5TURxlTYy/+C55mj2OnTFcFptzrgQasf/P5sC8J4ZbBXYktz+8vsCNjRqJEl2DAbzVno4yOR0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8369d9e9-9ded-4690-85b9-08dc3499e9d4
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 18:04:43.8890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dA8a3koMzdvGvQiLyGrHPOlgnA4yuOeC0ZEHe0Q4FSXo06iNNfOYVtTbPeM5cta+6N8mrmKxnYWihaYRjjYpqkLlIjRAQpWv5mg1IwClh0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_04,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230133
X-Proofpoint-ORIG-GUID: EmcqdZ3Bv2y74nW-vtd5uEmU8oIdL3au
X-Proofpoint-GUID: EmcqdZ3Bv2y74nW-vtd5uEmU8oIdL3au
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/23/2024 12:41 PM, Philippe Mathieu-Daudé wrote:
> On 23/2/24 15:01, Steven Sistare wrote:
>> On 2/23/2024 1:01 AM, Philippe Mathieu-Daudé wrote:
>>> On 22/2/24 22:47, Steve Sistare wrote:
>>>> Generalize hmp_split_at_comma() to take any delimiter string, rename
>>>> as str_split(), and move it to util/strList.c.
>>>>
>>>> No functional change.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    include/monitor/hmp.h  |  1 -
>>>>    include/qemu/strList.h | 24 ++++++++++++++++++++++++
>>>>    monitor/hmp-cmds.c     | 19 -------------------
>>>>    net/net-hmp-cmds.c     |  3 ++-
>>>>    stats/stats-hmp-cmds.c |  3 ++-
>>>>    util/meson.build       |  1 +
>>>>    util/strList.c         | 24 ++++++++++++++++++++++++
>>>>    7 files changed, 53 insertions(+), 22 deletions(-)
>>>>    create mode 100644 include/qemu/strList.h
>>>>    create mode 100644 util/strList.c
>>>
>>>
>>>> +#include "qapi/qapi-builtin-types.h"
>>>> +
>>>> +/*
>>>> + * Split @str into a strList using the delimiter string @delim.
>>>> + * The delimiter is not included in the result.
>>>> + * Return NULL if @str is NULL or an empty string.
>>>> + * A leading, trailing, or consecutive delimiter produces an
>>>> + * empty string at that position in the output.
>>>> + * All strings are g_strdup'd, and the result can be freed
>>>> + * using qapi_free_strList.
>>>
>>> Note "qapi/qapi-builtin-types.h" defines:
>>>
>>>    G_DEFINE_AUTOPTR_CLEANUP_FUNC(strList, qapi_free_strList)
>>>
>>> Maybe mention we can also use:
>>>
>>>    g_autoptr(strList)
>>
>> Thanks Philippe.  If we get to V6 for this series, I will mention this,
>> and also mention g_autoptr(GStrv) in the header comment for strv_from_strlist.
> 
> If there is no need for v6, do you mind sharing here what would be
> the resulting comment? Maybe Markus can update it directly...
> (assuming he takes your series).

Sure - steve

--------------------
diff --git a/include/qemu/strList.h b/include/qemu/strList.h
index c1eb1dd..b13bd53 100644
--- a/include/qemu/strList.h
+++ b/include/qemu/strList.h
@@ -17,13 +17,16 @@
  * A leading, trailing, or consecutive delimiter produces an
  * empty string at that position in the output.
  * All strings are g_strdup'd, and the result can be freed
- * using qapi_free_strList.
+ * using qapi_free_strList, or by declaring a local variable
+ * with g_autoptr(strList).
  */
 strList *str_split(const char *str, const char *delim);

 /*
  * Produce and return a NULL-terminated array of strings from @list.
- * The result is g_malloc'd and all strings are g_strdup'd.
+ * The result is g_malloc'd and all strings are g_strdup'd.  The result
+ * can be freed using g_strfreev, or by declaring a local variable with
+ * g_auto(GStrv).
  */
 char **strv_from_strList(const strList *list);

--------------------

