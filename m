Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F84C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfht4-0007w2-QT; Thu, 29 Feb 2024 09:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfht3-0007vX-12
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:59:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfht0-0006PN-Vz
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:59:52 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41TEfxaM005489; Thu, 29 Feb 2024 14:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+eZaO75APS0HAJxwkZb3tkC5zVudfvT/pTMmnzVDwww=;
 b=Iq/++VWyL31PQDASThF04CyGWBXBbMPgdqbVCOfCHJE5iYpi8VGocFTPCLoyIzwvplCN
 Lg/R/rIaL8xgM21NS8CfOJJNJTmAR0Bg7/9guBcyh2/g6eY+YdWsigyaUwDn012yJ7xm
 frm2AtEtJezbZWkZF8HWqlSZqpflkjLXDse/RhaJEMpkkgHrJ901hXCwxoifx4j94vLU
 f3x3P4W0Oh0Vd31bcIvbL5uYfCInNFNc7cgTUj719zuLEFIoud+uKdoRJXriX1c3dYRT
 oM3SuCm1368jBhYnDv7E5IM1DLN+I9+b2rklLd5jbRCmY8qz+QgPfhTv8c+Oyl9nwljE KQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90vdv0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 14:59:48 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41TENXVo005787; Thu, 29 Feb 2024 14:59:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wjrrahgbn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 14:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgqmI45PbdNf+sBZg8jOA+cwx7ZtlWgNmOiIVraDmVWx64YlBLL1t42HOFgkj+tqbdd+zBDexRAR8W6ht4HM3eToaUrWvSpRhhCv4LeNaFAj7tXw4MI23CPox2g8IyxWv29aEIvlC32K8/efykwDy5Bl/hiaxu90gRA/9RuZcVMB/Nvh46zFg+cZr7pb+ZBGhhe5a9UvFLxsP0IWnAmYccgk4c3K/2qIdyaMGwsLLlc1NxZd9DcsxzZ97dwbxasdIi1Wy4NBsqmIvkUxLWKgnfk17LXPt/TMMxw0TCi4YVThur8tJohHJIyXykud8306P2AIrSe/jpTo6iftSK2b0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eZaO75APS0HAJxwkZb3tkC5zVudfvT/pTMmnzVDwww=;
 b=E5W6dTk7kGLI5p/SrKV6VbjCLDEr1PMitO/gDYkN/aNTdn5/TnCLk/gHk+13WswAoXk5zjsVWQB2COvCOSnZgv+pOOodivlcji8gz2b1ccpxGNXF/eNB7ukwv+TevedQptVKdwIcxNlxfNm18LYD8ju3XMzGGx3fOlz/vXh+OYBGxtZYA7uGCHuPMcU0uVkNHmtxQ5Fp9ehvX9n2swRWFcrUcupaNviGS5Zaj5SH71ZSWHGv8DeZWBs3KjLZxvvMlgct2PxN4CTm2VocT2TLV6ze1/BF5Xjm/hz+xTSJw8Jo0tZPEb6Ijo+G2nrKTFmhWokY7KbfvYoble0D+816/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eZaO75APS0HAJxwkZb3tkC5zVudfvT/pTMmnzVDwww=;
 b=RyzWX5nJDnC1C6fI9/vBq+r1bC8ncxBF0B5CeeNB+bgWLVkG8ihV86pD8ttT6VZNeAab9ThOc8ZZH5qf/IGZezss6hzUpbCt1/KUTrl8VCFEtiioqH9slTTN37IxkgjQsW67H3BSTMepFuTtWIOocsKv2MNlZml2Hnf2DMrrh0c=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CH0PR10MB4985.namprd10.prod.outlook.com (2603:10b6:610:de::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 14:59:45 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 14:59:44 +0000
Message-ID: <2ae70d13-baba-4ab3-9a1d-aef8250ac620@oracle.com>
Date: Thu, 29 Feb 2024 09:59:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 14/14] migration: options incompatible with cpr
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-15-git-send-email-steven.sistare@oracle.com>
 <87cysh3vg0.fsf@pond.sub.org>
 <d54495fa-063d-4cb0-9e6a-4a57a312237d@oracle.com>
 <87il28vajw.fsf@pond.sub.org>
 <2089875c-17fd-4148-ba3b-6a0283d4ea3f@oracle.com>
 <87il27u98x.fsf@pond.sub.org> <ZeAYvLZDyL4jPHVU@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZeAYvLZDyL4jPHVU@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::22) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CH0PR10MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: 13255bb6-92ab-408b-cdab-08dc393710d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pCSMBeYJnE9l7HfAVIZJl6joG+weccjaHBVt82HxaZz0+YpIPpEkob0Cv/50IMMQ6rQRNkgjIuVQR09UpJD+ulzmkPYMK581saKuIy8knAGbHgyjDan1BAatHSFglVfcZ6PQXJE1k8s6XQTYTowt8ttqHB+7hSEBSrLjEtzc07aVmoeqewO+lCF9LrvJglblX4gDvD0q/y6MnxADzFY8gyb1eGd9Gqf5dIBsien4wOrxVHSqzGKhLefQpXy2pWCJhhixFRTgWyAXSBNfgj8XzX+v1ZW0dSCnL69Fm60nEzxHNTWo1nr3cM9PgZRzUTnObeHqlEgcYswLHKBwIqfsFR2kqBS5SGkQlz6aWQFuFGfIHlSI0pKhooojGbDzkgUIsHcdrUV9mSHozG94kH3o00J5S/xrB+W9fy3888eHArPaB+hKGfzCPbBDh7gAsS/B8bF4hm7OL0qmV6RgJ9Ch8ea6EBWq1G97Vf9iP3YiiqPJQ5YEbxJJdg4Ebla3AmPznvarMJ6+Nws5cD+wnC22oBOoBKmfrR+cDf5sw9oPxTadrl8WJWjTyYMMtkjIyCtOQo08m4CTgQOti7JfC2bIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emxSc1VRMkZjanMxbHduSVVyZGxzK3ZwaWJoU1p2c3JabEwvYWlSWjFUVjcw?=
 =?utf-8?B?RGxFOGN5Ukh3ZS9wd0x6RUVKcDB2d0Eyak1lNkhBNGI1UE9KdVBEQXFwZjlw?=
 =?utf-8?B?YXd0VVV4VWdrNytCTXd0czVtU09OSE5GaENZUTB2cHJCVWlLVitpa3VVT3VR?=
 =?utf-8?B?R2NUeURMNWRZWXJVWDFPNjRJbHlrbFdXa2MyVmZoaHkxeHhlcHJlcmtRRkY3?=
 =?utf-8?B?VmJmZ09ER2dzaHpCWXZvS3R6MUZuZ3FXSE5RRWNGSFBkZjQ4NEtuVkFxQWdo?=
 =?utf-8?B?Mnh4VE5icDJPT1pidjZMUmE5VklEdzA3aTdpRkU3cnk2OEFvemhIb2Z1WGll?=
 =?utf-8?B?N2ZmMWNyMSszZ1NJa0RJVGFFcUNhcmZpQ3FWb1FCRmlzUU1OSTZXQytNUU1x?=
 =?utf-8?B?c2hNRkJEMFVQbDVYZ09BWUlqZE5ha3l2MUxzb1h3dU5CSitlS3JCcnVCcFlG?=
 =?utf-8?B?Q29heVpHNlA3dWl3Qk9PdmJOMkg4VUtxVHdDMTkxdnpycUVGaDhRYS9JM2FC?=
 =?utf-8?B?aWgwaTd3ZER1aFJKMVdjWUsxUlBCNnJMZms2VlRtZDRBRG1XaXNERS94K09V?=
 =?utf-8?B?Y2pyako0V0hiZDJCMW0wV2ZPR2wrb01IMUxReWFGL2ppdVk4VDJoTEdUVzNZ?=
 =?utf-8?B?R0Q4UllrcE95QlF1L3hIQThFZWc1a2c3bjBhU1pSMVFQU1BvVTJqZGdWSlpD?=
 =?utf-8?B?dEo4aStkdi9VbTkveSswR0VhS2hHcThNclF5aTRzMzdkYThGeUFaV2RoWGRT?=
 =?utf-8?B?MmYrU0l3czJxdXUzWitvQ252ZEtOaUpQcTg1Ni94UXBRRkJLR3hreHZYSDFu?=
 =?utf-8?B?MXE1eHIxZjhSMHBmU2p6bnJreGtwY2N6cHZaUkNvUEJDNkJ3QjZQakJHcUF4?=
 =?utf-8?B?aWxqdnpSeXc2VndXdHRyLzdMV3ppWGY0Wkc0MUFVemorNDRDdFdicHVyenFs?=
 =?utf-8?B?MjdpU3pmTzFLOEkyQlpkSFFwOTVCajE3eGVmbllBcGZyelA2czljMlpnZGQw?=
 =?utf-8?B?TCtzWDJhcUxOMXVDdDJuVUtHd3IzcE13ZVMvSXZyUDQvS1liQkhoVlJwUVNC?=
 =?utf-8?B?MlpOQWdWU1hEVW9vcFBKZzJxYWNOZHZMaXk0b296d05STUxKVlpIbHR2aDJB?=
 =?utf-8?B?TTREbG5pK3JvMEFQcHpGTkhnRGMwZkJlQlovQXFRZHNMV0ExVkVRV2haVU9t?=
 =?utf-8?B?Nk41bS85ZmIwSzFZb2p6eVlFVURjRFNxZWVlR0x2NGlteFFUZTZUQVZZM3hn?=
 =?utf-8?B?TFhFYTRzeHlrMHNwbVd6a3ljVmtMN05kSXFLQkVGaHVrMEpJVG9sbWd4QkdN?=
 =?utf-8?B?Z1RhSEJCSndjbng0NEpOM1l5cW1CaDdkajJWOVZZSFl1SWdEVHhMT1l5eHFw?=
 =?utf-8?B?d0tMckhXUUlGbTBobTlUYXl2OEFwdjMxNlY4TFJyV1pQZGNqdVczVThUTUR0?=
 =?utf-8?B?bVgvMlJpODRWbFRPRlJPUmp6VzVYbS9lcnE2RHVySkRXeFNveXp2emZwakUy?=
 =?utf-8?B?T1k1aTQvV1EvYTZVa3BZVi90RDI3UUdneFRsMkFBckJIVlVpaDRET0xGK0o2?=
 =?utf-8?B?NVVPWkRvMmh0TS9MZmlpSU1LM0xsd3dhc21HUitkSzBlR0RHZ1VxWURoTWd0?=
 =?utf-8?B?ZHE3Nyt3b3hUNVNBbGllT2VqMWRFeTRIdCszcG4xOGJYUFREaWswRGRXaG5k?=
 =?utf-8?B?eTJEZ084Q094d3hHVEY4WEFGUGd4MGdBbU1xLzJXU1FtV2VyODdIV1ZrMHg4?=
 =?utf-8?B?TGNPdTJFMFBqbWQwS1oxR0NaSW1DRnVqUlhwK2txYUowbjYyY3BQbit6TWhZ?=
 =?utf-8?B?TFFTbTU1TWVrdjJOcTNDTzlEclM5dk1TdG5wYXE4NnJDV2daMjFDaHRmYlhS?=
 =?utf-8?B?WDJ5TzB2Wk5xRjB4Y01oWENIVFZBQzkxaTVmZ29ZeG9UaTJwUEFkNGFKL1h4?=
 =?utf-8?B?Zkk1MXlaMU9RR1h3SjFjR0E2QUZzanVGdHdGRnJVN1loNC80Ym1ONkthMnJt?=
 =?utf-8?B?eHJTUU9iYnU1eXhWaGYrTGNleGw2bnNub0dwcXZyVHljSGFJcmw1YTdiQSsy?=
 =?utf-8?B?YWhmWW5HcnlJREpCZFFObjUxVm5FK0h4YzFzTEpXM0o1M0VDRHB4MTc0MC9G?=
 =?utf-8?B?NUxQTEpDZzVGc2ExUnpKejVWV09MWFRSOTdnQjVJTGx3N2NKL0RRVEdHbVB2?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gl5SArjyBUBfaLzjnN485LM4WgPgZdar8kGCgTQfLXdA7KgkSdlrSKpjFONOC+MnqtTIlS53/wIKV3FGxNFKTqtKjIbWjazR+4uL6AKMF8n8OEhw3i0bp6uS84DlWM/FHE/EP8jiH0Bn0EZqbtVsUdTa6hYQgrdr0xkrYmG4SnTs/Y9hr+SWygx8ZkLdGix4W4+dwfm/VbjVO7XDU11bDqvlXr6s9LXfJ8Wwd2CpcjVnWomeP8aw1vXI4RMxWg27Qu3cJGrTsNXZAIxzxM1vlUIi4KqTp+yFOrB53MWwmuIHVw8S2JkF9Dzhy3hcV20M7jGJBVhIZjMoBkTwMQwYoiocD+P/Ya/lVOEAQMrg4kDnihvaYDCg5s52vj2iPKJJLBU2ssUmJ+DOEiXjPcDBlc3tzlNKnI2wSIOUvvuxCQ7qSsfwjD+KvBVfZp+NQuI1xKSstWmPcNlASDSZqy3UE9LFhdFL9TDscsg5A76tjNOofrqNJ3r2dP1rFmMNfwVWwxvT9Xnzeuom2uRdzQx6qdAfgj7CD9lTUUoVGCrHriFILZZ6+lfWWeBuSTuBEojNB+X21ZbcBnzMD5WA+W667JYZl70wgFo5MwKHjPw+W0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13255bb6-92ab-408b-cdab-08dc393710d2
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 14:59:44.9500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sy0hWlCCsly+98/4nNTO4R3ycJPf9DZa7JDol2bizFHlNZvP4P9+qI1tLfHZphoJuCWclHzyIb2H0V7lTbXjFnEoIUgBjtLMzFHC8hNja08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290114
X-Proofpoint-GUID: tOyn-Qd71C2n_gshQC1d9yISFIPB0Rnp
X-Proofpoint-ORIG-GUID: tOyn-Qd71C2n_gshQC1d9yISFIPB0Rnp
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2/29/2024 12:40 AM, Peter Xu wrote:
> On Thu, Feb 29, 2024 at 06:31:26AM +0100, Markus Armbruster wrote:
>> Hmm, perhaps Peter can still squash in the corrections before posting
>> his PR.  Peter?
> 
> The PR was sent yesterday, it's already in PeterM's -staging.  I worry it's
> a bit late to call a stop now.
> 
> https://lore.kernel.org/qemu-devel/20240228051315.400759-23-peterx@redhat.com
> 
> Steve, could you provide a standalone patch for the update?  Then I'll do
> the best accordingly (e.g. if the PR failed to apply I'll squash when
> resend v2; or I'll pick it up for the next).

I sent the patch.  I also re-wrapped all cpr-reboot paragraphs to 70 columns
and addressed Markus' other comments on "migration: update cpr-reboot description".

Peter, if you squash it, the last sentence "cpr-reboot may not be used ..." 
squashes into
   migration: options incompatible with cpr
and everything else squashes into
   migration: update cpr-reboot description

- Steve

