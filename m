Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62693C54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 00:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhJ2b-0000i8-SG; Mon, 04 Mar 2024 19:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rhJ2D-0000dx-1Q
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 19:52:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rhJ2A-0005Oq-Lc
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 19:51:56 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 424IxgPU014934; Tue, 5 Mar 2024 00:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : references : from : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=59OQmDxL2ZZi9QKesdGUxw/hmlukCTTLTkYn3TaENxY=;
 b=b+AgF8iCfdTP5ExjMc1hXpt2cGjzA1k1LS9nH0lkXR81tXvBHBY3ckaHChcFNjr8GKrq
 3C/vBBSylGAbJ9fmy9Qo18XUXqa93LkifxR2/OBWTjkPbJ9gIPbz9LKTjccs2Y1aXhgO
 9z0KNxHhBJgIX0Aa6MPgGd3LCS6YBp7ZIoxzoqEJWmnaRiQrquCFHX8yBHLHXqiBshuj
 eXB821a4AuAlUrUHpY9ZXZ30nRmDsOxcldoUN1708yubf4XkEiTog9V23aLHwlrDiQ3j
 MfchmMuqtu2Aw/9LPJvRO/NgzdtoHD1q58fXfSR9ISHCMvcmpgAIFWYJaku+PramPo1n Sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq251p8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Mar 2024 00:51:50 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42502FrQ015220; Tue, 5 Mar 2024 00:51:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wktj6xke5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Mar 2024 00:51:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSHZX2yc5rqCpnWpENDP5sTIdEN0NC3R8F0C70OYAFGcDxI1AfOWJJ7xHe1j2im8gQ/bI9eDrReZwb/t+cjaoDJCUkgrRRmhY8KCROhgJZmK8kiG1NP8FKKxEIABPLfRp83dBpMfYZSJiBdcmsGE8WulIJvd2SbwAohwIDha+8uR4d9zXgdroUESvkcDa0Su04RQB6Z5MN4Dk8sxsv3/4wuXdw2itxcyG9cbCVIVs2eT0TCClHdmeX2G46MjasBJmZb7MC/ie+EywDAclvg8Pet5E5ISpSxoJnBzFV733Da/iG+D1ez8R7cPM3MgJ+3Zzgg+fjhdRQ/taDPUJZ4JTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59OQmDxL2ZZi9QKesdGUxw/hmlukCTTLTkYn3TaENxY=;
 b=OeCph/cxEjIVcAaOkJJ89zi1yoik2hWaS70RCGJw+kmVqs5gekF2LLY35J6p5KypuTal0Q23mgr/w7JG7eIgJG1AiCwpHV7j2iEk13Cq+xNBU/iGG78S8ywtWqaWgPU+va9Iy5fdX45Ij6JxD2Ms424JktPKxBT9kHMg3ZG4bE/MeL8eNs7NcOdQB14QgPkzZVXIsTXHV1ocGCuxw1xWqVqSCw/54py7yYIeI3EZZeANy+vfv449ZgiNfnDPw/dnToHe9Yl1H/WEehL1D0ppJ3DsEbqb5bCVURTxYxLcp/s8ozP5yLhylurPEVAOLsg7+RBSS6y9ptTh7rRUznDJWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59OQmDxL2ZZi9QKesdGUxw/hmlukCTTLTkYn3TaENxY=;
 b=mJ2ljNHST1hhW4q1TWlDv1iRTBz5fu2bKZXFXknpAPFIKwnVXVt5YSOJG/Y80xM16GoHdUDc/OQMzt1PsCGVqETGzlhf8Vseo0/kHCDD7ek1j3NbCOUW366u6VzjTfjPeah60U2D9K/xZnvAzbudEgiPMPHSqui+WYVunlvuJKQ=
Received: from SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16)
 by MW4PR10MB6440.namprd10.prod.outlook.com (2603:10b6:303:218::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 00:51:47 +0000
Received: from SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::b084:65b1:3637:7e48]) by SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::b084:65b1:3637:7e48%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 00:51:47 +0000
Content-Type: multipart/alternative;
 boundary="------------jnNnNmEja0RoGGD61T6GlbNx"
Message-ID: <aa09fe92-e241-4eea-8e3e-6e2ed62495ab@oracle.com>
Date: Mon, 4 Mar 2024 18:51:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] oslib-posix: fix memory leak in touch_all_pages
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240304224857.268503-1-pbonzini@redhat.com>
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <20240304224857.268503-1-pbonzini@redhat.com>
X-ClientProxiedBy: BL1P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::22) To SA1PR10MB5841.namprd10.prod.outlook.com
 (2603:10b6:806:22b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5841:EE_|MW4PR10MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e0aa43-602e-41be-d1c6-08dc3cae6f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlOCmXc+3FIFTNYWRua2ZZ2BszeiJUbi8aItB9JG274eWd9zIBbQ/WT8+FsN0XoBL4vfA/+XmwTnXxgDsijo39qX1F278n2GohZXdi7gP6HR/77JBPM1Vo24PMFCVD1vi2Qd3XTMUKmOYHBtWUn1jai2UYqSCQEEb4/4/UbvTrCPiaZVBofPACh42BdJ4p8D5pFP1mU6/Fb8LwHHuQ+XPASuML3dn2POtxVBvKTfvJeO+c2yBnBoX/b8+W2SRDptgHlpWWgKS+2sWbh/1ew/pFJZ2udcWUH9ytCE8TMVjV5edMdoNZNJKwor7RqBSE0roZtczrDnDSOf4sdilHPIglBDbhXBkVWGc+1jg1IY3/NG5CbbV2AzOzBv8MdpuwHgw7p6l/BykRif5cSIzQg/TZH5J4A5sc76F2bD+TpHnYK+RzXlW66rOqwVQz7YI43BP13vqzQBiq1yB4TVNt46s0pZdvupu+4/iQMia4uiGDjg3xQ8pRNcV/6XIUbqgrrXZc+TJEk2q2cyRFrigYTRtd2wh7urgR0zz6FEr41HeiGuojWxY8a/uZ9EekyjwWpcdl+ajMvQzWzVdb4odPj2sv+wni6ThaPec6kBPwgjvtR3AWUhp1kJdECiRTHrVh/JiwG6dgvOnYjWd+nKCwhxQ5UDMDkBpi3+xt2vXtWeFMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5841.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0FzdFFIZHdoNTBMK2QyVng3UldSY2ozT05ydzVwcXVuSHRhOHNXM3ZKeENL?=
 =?utf-8?B?REl6aVh3SDNGWG43blI4MU83TE00U0NVZktXZEJqSEhkNWEzLzhlbjdjczJy?=
 =?utf-8?B?VlBjVjdGd1NPTGJpcU5pUWpXMi9NMHRTU0R1S2JXUUVON21kcEE2Unhucng5?=
 =?utf-8?B?aVBudVlreTM2UEV6VXUrNW8vTHlReHZMSnZyNU1HU1dmZVRkbGU2dW5jcUpZ?=
 =?utf-8?B?WWNvVWsyb1g4L3RlWm8zZGpoQXJ4VUFOOFVvUFVpVE8zcTRlRElhWVg3ME9G?=
 =?utf-8?B?Mms2Nk1zVDlheDBZNzJGbnZUdUluSFQ3ZXBZZ2U5WXVuaEdLUWF1THNOOU9h?=
 =?utf-8?B?SkZMMWFtaEVETDdBYXJESGFNNFdOeEZrd2RKVHVESzJTREhKYkR1RVI1Y0ts?=
 =?utf-8?B?cURHWGdQZ0F5a09EdFZMdmZwTnBzUEMwdEVSd3lyWVFwR3JvWnBlZGUvM3JJ?=
 =?utf-8?B?TjFMMDloRHNxTGVwNGJ2MlVuT0xXM2kvUU9hZmFEMm41MHFCK0d2bVZvWjZu?=
 =?utf-8?B?Zm1XaTlMVmFBUWFHZnp0Z3l6M3NDWmdSU1NKdGozM1FHQU1HNExXa2hEUVFs?=
 =?utf-8?B?ZG12c0JGT3htSG11ck92SnBqZnRPRGNPQXhXenYyUGIwVDNOMml6M3V0ZjJw?=
 =?utf-8?B?dHdPR2lhd0NlamdlMFhGKzNvL1V4TkgvYmp3RXUyck1oR3hBZmFCQy9LbzBx?=
 =?utf-8?B?K0Z0WGR6cjNHMzhrbnZRYmVwYmVWNTFlUnVRM3dRcklMTVlZdU80Y0Q3aTZS?=
 =?utf-8?B?Z2NXMkYyU3daT0FxLzdnYmtybXRvbHUvd2Vlc0YvczQ5UUhVRi85NnFRZmJx?=
 =?utf-8?B?R24wWG9VbVZTWGVaL3lzVzU2YW5qbVVwZWhaaVFzNXljejRlUmJLNFZHa0Ft?=
 =?utf-8?B?NVFiMFRhREgyd0E5QnphRldVaTRyN3R3clc5OERJTnVYaVJOWXRHNDRrUzJx?=
 =?utf-8?B?K2p2UFZvVmVubU13MHQrbmYyK1dKSDNnV1dXNEJqOVJBUnZodmFKc0NhbzRa?=
 =?utf-8?B?citQWGVNR0RKY1JVWmErL2t5anF3UHhOcFp2MlRXWEUyZCtaSlBFL3ZpRHlD?=
 =?utf-8?B?MGNlaDczREtDU2hUNFI5R0JaYlFoN1c1Z2VaVzBISksyRXpydmozK2RuOFVY?=
 =?utf-8?B?QjE3aUJ1QVRrVXJpWjkrSGxvV0I5aVhlZldicjMvNmZ1VVRKZ2M4Sm9qSzZL?=
 =?utf-8?B?VkFlaytqb00rZHlkelZDaUFqdTNZSWNsZTBFaktBS0hYN0ZCQjh0SytkYzVP?=
 =?utf-8?B?ZEFvTnF3WnZYTHFISW5qRjVlTWFrRU1MS1U0ZCtBQTdWSDBxLzU5VVdyVGo4?=
 =?utf-8?B?VWNqbHl4MmFHelgyOVNDT3ZPL2Z5di9DWHpRdVV1Wkd3WElMSXY2Y2dqZHFK?=
 =?utf-8?B?Q2dZd1ArK2g2cVplMURLK1hadzVHeG1oY0ZwcTc1NzN4MTJGK2psQWdEZm5F?=
 =?utf-8?B?UEIwbDR5bjBmVmdqMTFVSWtFaHErdS9JUDE5NC95OXVmUmJqdkJveHV3OFFJ?=
 =?utf-8?B?dFRQWDNjKzhCTml5Y3BOTEthc0pxQVEyOEp2QkFKN1hnd3RITElRWTFpaGt3?=
 =?utf-8?B?NjZ2ejQ5aXRzbm9oeTVvZGJodUhsVTVpSFA0d0VZWXF4Zks0WUU1WUdqNlkx?=
 =?utf-8?B?d3psVU5xcTBxYm9zbzhaeG5RbmhzL0JVYjg5QVhFRmI5TWtMS252YS95bzBo?=
 =?utf-8?B?L3RVVXJsQ2phcVV2S0oxOUNTcFM0MlAxT1Rka3E4d282emhPSm1zbTIvNWh3?=
 =?utf-8?B?TmlvWDdQYTJsajg5a2hIc01IcU9wM1EzdXZZR1U4b3dvazVWR0JDS3NxME9Y?=
 =?utf-8?B?bU1UOVVSSW1PZHFHREljaTBmaU5xa3lCaEZldHZMNk9ZR2JyRXBLQnVKeUxa?=
 =?utf-8?B?OU1mb1JCZWtwSFRDSEJ5RW4rWVdhOTFpUDY5OFhvTUdUa2VXcUdndHZzSTBl?=
 =?utf-8?B?c0hTL0w4S0FpaFZZS0RXNk9wMFJ2TlhDN3NkQzlFV2laRDdBRWVUYXNhSG1X?=
 =?utf-8?B?U09rUk11QnQ2eDJ1ZlZvRUlLUlQvWXppYmVXVnV0L280UUhHWjFLQXVEd2dk?=
 =?utf-8?B?a3hMajl5am15RCthL0pXSjAyNEVIa1NkUng0bHRFcEQzNjJVU1Bkc3doYVJp?=
 =?utf-8?Q?CPZUVkYeLFIHymIdH/8yPWNLw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AhQsQEn3RWSI1y7uS+fQdXkbfnES+/A82ryLfHy4x5zYpnHdcxUVSDE4krYY1L14BUU3bLxK9RM/1/owy2FDU3L833TE3+iJcG86wyBD2JaTaqbrkEumAWRqEy4vIH7p2tc9vEPEhWF/dWF+DAlkAWF3eKBHXpHqV8+KZgliaACZTa72vXLsydMNVffPdB6t2rRf+IiZ0kDS8kFu0uf9lR1VDC3ViB5zTLfvJiM1vplB6i3iBOnej32SrME2f+nFRKXg05NZZxFwRJv74OPj2HEZPMJEzBL4e2RzABTffOQut+Sf0X2/brGjGK54JQxLf6vVW5kj3HbGcZiQc8Rxta6/7MKMNJFC4u3wEotblAsmX5fPtuX6UfVgATe7cqDkwiBWhIg50vV79htHM63lLWop9AKCpsUNmEFXHFq22jlVKIj1BuX3hlssIbYnpWQR7UamR9TxJPwJIrgg/sHMA8uNZoN9pvTTYmJZa1LEZ8Zb7w5N8w0s0MLCMFlb4SQiRxe4CO3zJW/nIidcp03EDY2oDPXbWumHvUctxAPNwJ9WJcAx3v/j5XT546hG8JAjkDZOzKfMDwdEyBK7zrnKAG9bg7/sV4doG2hzGNfEOao=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e0aa43-602e-41be-d1c6-08dc3cae6f8c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5841.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 00:51:47.4971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BM6S+SlnhmKi/92pP5f6oppZdtlDSq8PBFXERF3fuT4TtSub0rosNOhheeFx6kwUt2YJ0zO9PO7AkffrZVK1TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_19,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050004
X-Proofpoint-GUID: tTcrMR3r8iqZX3TkgJlBr0PNUOp7p4zv
X-Proofpoint-ORIG-GUID: tTcrMR3r8iqZX3TkgJlBr0PNUOp7p4zv
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--------------jnNnNmEja0RoGGD61T6GlbNx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 4:48 PM, Paolo Bonzini wrote:
> touch_all_pages() can return early, before creating threads.  In this case,
> however, it leaks the MemsetContext that it has allocated at the
> beginning of the function.
>
> Reported by Coverity as CID 1534922.
>
> Fixes: 04accf43df8 ("oslib-posix: initialize backend memory objects in parallel", 2024-02-06)
> Cc: Mark Kanda<mark.kanda@oracle.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>

Thanks/regards,
-Mark
> ---
>   util/oslib-posix.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 3c379f96c26..e76441695bd 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -467,11 +467,13 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>            * preallocating synchronously.
>            */
>           if (context->num_threads == 1 && !async) {
> +            ret = 0;
>               if (qemu_madvise(area, hpagesize * numpages,
>                                QEMU_MADV_POPULATE_WRITE)) {
> -                return -errno;
> +                ret = -errno;
>               }
> -            return 0;
> +            g_free(context);
> +            return ret;
>           }
>           touch_fn = do_madv_populate_write_pages;
>       } else {

--------------jnNnNmEja0RoGGD61T6GlbNx
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    On 3/4/24 4:48 PM, Paolo Bonzini wrote:<br>
    <blockquote type="cite" cite="mid:20240304224857.268503-1-pbonzini@redhat.com">
      <pre class="moz-quote-pre" wrap="">touch_all_pages() can return early, before creating threads.  In this case,
however, it leaks the MemsetContext that it has allocated at the
beginning of the function.

Reported by Coverity as CID 1534922.

Fixes: 04accf43df8 (&quot;oslib-posix: initialize backend memory objects in parallel&quot;, 2024-02-06)
Cc: Mark Kanda <a class="moz-txt-link-rfc2396E" href="mailto:mark.kanda@oracle.com">&lt;mark.kanda@oracle.com&gt;</a>
Signed-off-by: Paolo Bonzini <a class="moz-txt-link-rfc2396E" href="mailto:pbonzini@redhat.com">&lt;pbonzini@redhat.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Mark Kanda <a class="moz-txt-link-rfc2396E" href="mailto:mark.kanda@oracle.com">&lt;mark.kanda@oracle.com&gt;</a><br>
    <br>
    Thanks/regards,<br>
    -Mark<br>
    <blockquote type="cite" cite="mid:20240304224857.268503-1-pbonzini@redhat.com">
      <pre class="moz-quote-pre" wrap="">
---
 util/oslib-posix.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 3c379f96c26..e76441695bd 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -467,11 +467,13 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
          * preallocating synchronously.
          */
         if (context-&gt;num_threads == 1 &amp;&amp; !async) {
+            ret = 0;
             if (qemu_madvise(area, hpagesize * numpages,
                              QEMU_MADV_POPULATE_WRITE)) {
-                return -errno;
+                ret = -errno;
             }
-            return 0;
+            g_free(context);
+            return ret;
         }
         touch_fn = do_madv_populate_write_pages;
     } else {
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------jnNnNmEja0RoGGD61T6GlbNx--

