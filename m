Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF716C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1recGv-0007er-ID; Mon, 26 Feb 2024 09:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1recGu-0007eX-8g
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:48:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1recGs-0000oK-CK
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:48:00 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41QDL48N025836; Mon, 26 Feb 2024 14:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=FpKE41IItV4igqwixQ6zH/NdaRb7lfCUWXVdeYXUb6g=;
 b=a/HsxtbtynKYhcA6n4PpXGKV5Q3M5hsHNR0SEFpvtuUF/dvEqHYslqNLceo+ZEsUM7Ci
 +3wtaMme7K6k8f4hsntfeAAgJGOrQrpiquxm0sk7PlkcDwM0W20atR1XAXpolbDrKj5T
 ALcoyoL0C9NrAfN2/xWR+BajbCGM16fllT1d/FaBxBNI9g3qmDdLywf/bsl4nE6RkDLH
 lsiXgYbQXC3QJH6apAfagNSPZ/edKOjrvbUlUpJDE8rzTccHydj4n9J64E7hmTk+Fm8e
 50hororVTMMGpuMjuufEsT/CkWkvlpeet/RVXTAVdBkeY7v27a7z4nPApiaBzThdriCW dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7cccqnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 14:47:52 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41QETuRh015303; Mon, 26 Feb 2024 14:47:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6w5vqx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 14:47:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/KOtH5zpdgg6eoQcwymMU7NQX9AYCPgOT/ZJPi9RNpHeSiqxwqBScvvl9TbFZAi/LGtO3PHyp4aoqJrVy1NipGjpvXhHS+j9L6/+PF/22HSRvJrxSB9Nlj5amJhbdfEIYuiTyoRFWX+4aNfblrqw1Hg3q/RDt9B/QuTN3m9S0N3ZZK4BLU4cAIp2/T8dO298eInjJqlVmKEk2p3BfctRp1JyNMcoeTV8cHLbh1xOEh64JL4oF7SsdbAibWSR3c36jIXmfDe5Gp9agHKlg0dJhSHnbdF/TFYz6jWOUNnPjDP+Nm2NTofRLTrkduNFoxsvTwsf16e4mAXS8PqaHqCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpKE41IItV4igqwixQ6zH/NdaRb7lfCUWXVdeYXUb6g=;
 b=haiS7uxQu8VRysVVufhXUI4/divJZ1SK84WIPzxh4VhY7DQr67iC27zXNEgPNOPm15NPM9tAnLdOblomv1jc8Ymxavlpvs6+qvfmAqlfrJnMx39a5L8SURazmaF1V6gwRLFUThNF9sj95C/u1X1oLSjl7lfx5amiVFoZksZ/OX4FUYin37+xLs6sFBK6mtN+FPphnaOG+CXiFyUwLFujVtTqJD9TfBDkPcPQ5ORptsn8y5w7KLkMUeajB3Fn4UtWYKmSCRCx0A183a47DNWoMei301gGzpuFQEE2XyXVN9h6EEqoF1iQFe/Ggz66YdX1TZiDUeCIsi0qRvWGo6WyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpKE41IItV4igqwixQ6zH/NdaRb7lfCUWXVdeYXUb6g=;
 b=VGDgUarVx+KLz/qN690y39Tnihsj9rvGmWwuZyAIiW7MWsy57PARaVzwOgylmEESVw4G+OnXgeCjMqgTrcBN/XcM7kN/IFwKx+EH/aZe9cvLT4hRmbFvpcQEODKmqdsOpVkUxyyjV8IVyUprspFtthVIc7BYYMlyEwdgSYVtJWE=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH8PR10MB6359.namprd10.prod.outlook.com (2603:10b6:510:1be::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 14:47:49 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 14:47:49 +0000
Message-ID: <d2ebb808-caf0-4f71-ae38-aed03dcd2d8f@oracle.com>
Date: Mon, 26 Feb 2024 09:47:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] string list functions
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240226141108.73664-1-philmd@linaro.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240226141108.73664-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH8PR10MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c37d189-24eb-42c6-0d53-08dc36d9e6f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8LJCjxkbbAtQIUNmFmhWuPBvXUaH5++2lpNBbJIAaHFWemHYyrvk/9eofi67Y9ErVNXsUxokyFdh+8XAULsf70V3NvNHIRhjVtoheLlk5Iiv7oJKw7yydUbnNWN6EyOAEIDp0SdGc874zjG2PnO/Qgw+HQIs66ryWgpkxnuo/TuXbZgQsuVqkIKe1rzbr93zBNrdmBHX5VOxquwEoiW8XDXclFN3XsPtkoXIXsc+UFew9zef1fGHYjhF/SrHc308qI8QIFHP3qa+Bp+YKrHu5sP6FoB8p2cguAW+4eXPGdyhJic8iehl+G3Nb+M1HXD95ehL0DFqxbycZ85I1zO0JwhuA34cOmvwRXDijEnQNa3Jg7GR/5vARLkBYR9A9AOh9n4BKZRRkFiRgy/UpsxdajCfAkxxliqyA0cVBQCpep9Y5vVf5d+7ZWutAE5oyLw3irBtqLkpjO1EHKQzqbzF7c3w/ePzt+H86FYp3iVuULR9G816hzNgVvB/oDXRQ2DMg2+aTLL8E9z83xL5MOmD4Hlj7yijqafrbXN91XR48f6k1G1SDTtWLSQgHpYn+Lm2yNSQ8HEgQJxBV8GBe8DNGemx+09zQp5lYGjnWtd+JM/X6dJtSOmxZh5nUDZHwl0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2JXRldkdmIyRUhqZzRmSTg4dFU3Z1pLTXo0bTZYckREWlFmRUs1NzluTUFl?=
 =?utf-8?B?alpjTUJFK3ZNZWltckZRWTlCSmJDQ3ZrNitaZExvbmtCdmdldUJ6UWFWc2wy?=
 =?utf-8?B?eDNEUGdxUTYvUlYzMjRtTkFUZ2xERUh3bVcwYmN0cXp0Vzk1MUR6RGtmYS8v?=
 =?utf-8?B?N2RoVC8vYjYwUEhocXB5Zk1UdDN1RGZWdTY4WEt5NDlTV3dIcitTcG5HUmFv?=
 =?utf-8?B?RG9lYmZaUERBTnViaXpmaWNlZEU2eHVkZnJlNDNGTy9rclU0R2I3UHBaYlJU?=
 =?utf-8?B?THNKQk9zYjJUenNROTBMU1F6TFJacTR5SlVocW1Uc1U3cjdYc3grVDF0bFlC?=
 =?utf-8?B?aFFOTE5oN2J2cEI5cE9YWW9sZERRTG80UVg2aFdRSzFXczRtUUt2TUF3cEVk?=
 =?utf-8?B?a1dyem1ZMGhWV0QvdzNtTk51RHhTY080WFNCcFZueXRTaFkrU3pYZDBsTzB1?=
 =?utf-8?B?Szh3c2h0cDg1UkY2VEhuR3VIQWUwRkpNNlRHSnFXcEFhS2psTGVGNDZMMFcx?=
 =?utf-8?B?SklRaTJqZHY1dVFMeDVVUW9xMW5OWll0cUJqZFRtWlRlRWM0RVhNSzVEMm94?=
 =?utf-8?B?clpMLzZzeUtKLzZoNGdGT1MrMnppRkE2U3FOUE9QTWN2cHJvYVVEOWt2anYw?=
 =?utf-8?B?L3NkVk5VUkdmUWYyd2I0WTRxYSthcm1FSk1LK09QRHV1eGRQdDRRUDJzbnJr?=
 =?utf-8?B?TDhWR0IzUFk3S0g3V0xlemdONlY2OW1WZCtXRll1dGZ6V0d2VlVNRkdnRWda?=
 =?utf-8?B?T09iWUlaODNkY01lS05CN3B2RlhjVThwUWxsYUZNZzQ1eXlWK3Y4RkRHT3lv?=
 =?utf-8?B?QTI3ek9QczhxT3ZJOTFuc05LelUzMGM2eFo2VUdlRVZwbXV5STdQY3BNZ0dD?=
 =?utf-8?B?UzdVNi9qM2pPdTRvM05aWDAvMWt1VmpldGRYanM0VDZGcVRoNUNEdVNkLzY4?=
 =?utf-8?B?Vk9YelUraVFkYVJObU12ZHFYZFdvUExQUWg4R1JmcTU4RVozekRVak16L1du?=
 =?utf-8?B?R1VkeHp3YlJxOVNMNGtXZW5UNlcyQmt6QzRhOXdvR0UzRkJLOWZQLzBTbStZ?=
 =?utf-8?B?MUJxUWhraTlMbHN1Z3pZaDJBYkVxMWYzU0h2VHRubUYvc2FKU0JrWkNZaTBD?=
 =?utf-8?B?Z3E2UW1EM2pqa2htUWhGZXJTdy9wN1NNaU00Z1VuaFdrd2VSYit5TTlSa2J4?=
 =?utf-8?B?ZzhLOCtjUk5lVVczYlJIWlVGbExhc3Nid2ZzNTlsOGlyRGlYT0Q5UlQ2K3kx?=
 =?utf-8?B?MDVMUGEyRHdnaXR6UjhQRWJGR3RQY0ZzdjYxSnNvM1BzbldKMERXRFp5VVBu?=
 =?utf-8?B?UmkwclIrZEh1ZEpVaFM3Mkd0Vk8vOGJtTTYzTGdrcG5UbllyYVl5MVBPMk9R?=
 =?utf-8?B?NXpqVUc0NERlQVpSN1J0L3VHVnVFSVBPZ2RYSWt3V01Uc1I1V2F5YllwdTBH?=
 =?utf-8?B?U3RrdXlybzBhcHNIVXhsMys2MVBlS011blZiSEpGNDUxRzBvNXhxNm1TeGN6?=
 =?utf-8?B?QXlLbFZnV0dIOGord3F2YXd1OThnWG5wSUxDQzVkS1lVT0RUNDllNDdvZzBC?=
 =?utf-8?B?VTJXWENDM1dOL1I0TnA2NWZVYUoxcEVheEZyK3l5TVlkazZyZjgrQUJ1cGVi?=
 =?utf-8?B?WUpzbnp3U245dDhXQzdHczVJSTZMb1B4WmxhNHRkVTZTSWJRa0RoU0ErSDJi?=
 =?utf-8?B?QUtpTWcxTGZMNUk2U0JUdzB4Y1ZuKzlXbWlVSmF1dVBwWHUyektrWTYzU2tF?=
 =?utf-8?B?ZGtxT0cveVh0TFRaTXhVdEYzSm11d0V5dDJkaVUvTzlJblJZVGM2QmlZbDB0?=
 =?utf-8?B?U0p3dkFuZW13bTZyUk1PSnR5K2Zqd3N3dVQ1bGNicVRWWWVlRVRBQUFxNi9p?=
 =?utf-8?B?WTJHcGorZ0JQbnowenNOc0hXUDhKU0t1bnAvSHJwR3NZVWFPVUFHV1VHWENY?=
 =?utf-8?B?N3RHQ0NCWlNmSkU0NS80Rm1GL1dJNmhPU0hiZXNBNTdLVUtFOS9ESVNQWThJ?=
 =?utf-8?B?VVFLRGRVRXJlWEM1am5FRjlxenFVNkprZVNzOGxURjg3M0ZzTTBxV2tGNGR4?=
 =?utf-8?B?RTBnZkMxNitHSUhTUWpHSTNOODJXWEtmTUhydFQxbHlaQzN6L0JDMTZFSmto?=
 =?utf-8?B?ckZOVm9IRU1mcmI4WXZjVkFraDcwM2RvK3RGdWhFWk03bDM4US96R3Nuc1Zl?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FBAolnVc/hYGYkeE4YPlz7F1mYzTDfAiydrCmzF/9942THFbbBbItIiPVJRragQwWmxUZTddpablHYIVvpCufMHp8PNMadM8xo3tAgZv9q3d5/pv0guWdpty8MtO9ROoFmpKy2zr/dSQigtMftXbQXF0qA58iJQqGBSkkWLwOvl9ONB52bKlkd87PGsnqFQO32zUz08bYZX84I2tsAR6rq98NiwGpaVEtAIyW0y0gHwoRnjq9JFWyV6Il9+CO0IF/waXBIiJiAO8RMMZB5wdqsvmFg3/mZzrI7lsyY+ACDOfF+kp1b6P6iiZFNXsr/KWlGa3BiQWR7VNGDoKeZskfM5VWlbvVxptOwaf9MPy5zfzdPipwpFYpSFFzuGl1g1zz5Ec9I8CBijlFgrtrwxKRCqzwbol5F5K1T5XQqzjxOCdSYP9gI2T7v82VpL8a20pLPBpyPKtVofvZT8Zc5M1OwfvXqQXK84y+4yo/a8QBaM0XvAcM6lZJEji+9lqJspWG0StPgDh+R7/2qwxKpsk2NiO+Bodysp8KWRGP8A8LM4tWGfQcVUj8INwlm+ii4fvwHRlV7wysNZknGnCzC18YP4OPj2woQTHW4g6dk1ovqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c37d189-24eb-42c6-0d53-08dc36d9e6f0
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 14:47:49.1240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnDqOUCioq2LWDW3OnDlliBDItewIS1NYT9Ei2nBn5Ak8ZrpolRu4h2mLbtU1CDNj48yQaDpsu4qwPOJ+E5StG7MqXTBfosalISl9V6Egqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_10,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260111
X-Proofpoint-ORIG-GUID: ob0LfnoZIzuLVmYYWdF0lugOjA1pXpnx
X-Proofpoint-GUID: ob0LfnoZIzuLVmYYWdF0lugOjA1pXpnx
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

Thanks for trying a V6 Philippe.  I'll take it from here.  It helps to know
that someone besides me thinks these functions are worth having.

- Steve

On 2/26/2024 9:11 AM, Philippe Mathieu-Daudé wrote:
> Hi Markus,
> 
> Here are the patches I queued until you told me you'd
> object to the CamelCase filename strList.[ch].
> 
> Steve, please take over ;)
> 
> Since v5:
> - Cover files in MAINTAINERS
> - Complete @docstring mentioning g_auto.
> 
> v5: https://lore.kernel.org/qemu-devel/1708638470-114846-3-git-send-email-steven.sistare@oracle.com/
> 
> Steve Sistare (5):
>   util: str_split
>   qapi: QAPI_LIST_LENGTH
>   util: strv_from_strList
>   util: strList unit tests
>   migration: simplify exec migration functions
> 
>  MAINTAINERS               |  2 +
>  include/monitor/hmp.h     |  1 -
>  include/qapi/util.h       | 13 +++++++
>  include/qemu/strList.h    | 33 ++++++++++++++++
>  migration/exec.c          | 57 ++++------------------------
>  monitor/hmp-cmds.c        | 19 ----------
>  net/net-hmp-cmds.c        |  3 +-
>  stats/stats-hmp-cmds.c    |  3 +-
>  tests/unit/test-strList.c | 80 +++++++++++++++++++++++++++++++++++++++
>  util/strList.c            | 38 +++++++++++++++++++
>  tests/unit/meson.build    |  1 +
>  util/meson.build          |  1 +
>  12 files changed, 180 insertions(+), 71 deletions(-)
>  create mode 100644 include/qemu/strList.h
>  create mode 100644 tests/unit/test-strList.c
>  create mode 100644 util/strList.c
> 

