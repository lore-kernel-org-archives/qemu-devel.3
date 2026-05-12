Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6E1CD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 00:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMal4-0002mB-8u; Mon, 11 May 2026 20:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wMal1-0002la-1I; Mon, 11 May 2026 20:13:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wMakx-00043a-TF; Mon, 11 May 2026 20:13:54 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6lTT2046635; Tue, 12 May 2026 00:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=+Xor4k0AH/GvUkXMDxOzT5sFA2LK6tE1UUnB3VZ7C+w=; b=
 kGA3isro0LCU2KDYNN9LlF/VYe/gyAjbgzjW7Sdj7/O3KSW9bf8c0XTzr56NkaxR
 u+I9zN2nk4kHiDZqV3tJ2BmWQ4HeK0xoJzhyn8oOh9G9/jYmDwj5aiXFoUKJmT5I
 hLLeJYgG1Z5mMzetn8tcuObaS052//4GyM4mW+iXDShs5LxA+K1weOyLzR05O1c/
 PBpX2T2pO+tlUh0vDWDZ9Fm4PBSR+cujpDE4Dr9vIo5eBZ6+XC/PndxP0ZnKBQlV
 qSaNKQTHhqEr7WOroyOgpTZjaYbQAt0uS+XOebNi/L/+Ag9QhsZ18jFJi7b/2ip3
 g78yJGI88ThX8VBMUpZbTw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e3nv288uk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 00:13:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 64C06ogN025836; Tue, 12 May 2026 00:13:41 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4e3ne8recx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 00:13:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voRfiVshoy1H2nd5rqSvb6NtnFx/AK/FhzbtAGMYy7YdnZS6Mu15FwoM74oOetvBZblHCiLvvh5xnblZWvKv0w8FgE8MPPM9FTaMAFRIRRmRYb3hmVQTaRBvCDyCSbbG8A0EyYBa7LviTgCIxq9NG866rkQvrBm//Racdpoq7Zv9xHqQS0zf8X3jCUk29w12i9ZwAjO4XzooTwJIoSqx6WpIRvCnhi1zwG7Fh8MxiYp3Ld1rbB3RDsheMK3xc3/p6s05vg6u5HwHGqyy8ghkCsG5t/k4r718jKgDq3r8yRNBJ8v1vQByCeP5eSYEMfHcf4ty8poyP/Nkxxt5Ae1JiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Xor4k0AH/GvUkXMDxOzT5sFA2LK6tE1UUnB3VZ7C+w=;
 b=Ke7LN6zr9GN7PrmUJIbnTRbB578dRd+RUv8NPig9Qm77oSzgalSR4zVoI8+/LhMOulCBGWtUimQoDO8/G+kLfB52aYyju7l1EZWXEKI2Tie6M4UBt5FqNBMDKK/YOLhY4pcuOj3hKni1oMCuSo3IZDyzIXFee+1E9Ue4RSuzwzNjASd4Ao2QIVzc76BkZ3UlZ/jXMOFzUOPMzRQ0fe3I5g8EhVqAkj/t3GvDfZrX+PuzfioI9Qwq4SY9farWDxW5eQPuYKK7YQmhzHhzCGn70+Yu+SNCOcV/56vFgObjrOhRwMSkb9LYSrPkW4rWU9IKmRhlurA0zXMnkPJKvIe7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Xor4k0AH/GvUkXMDxOzT5sFA2LK6tE1UUnB3VZ7C+w=;
 b=RbJr73x0Mv2FXO2WO0SxgV8sPmAvybQfBeoHUmAApN7YrbAlgTjTjwBGve/RPoJQLRR4V13LvcrjwVE0ctTvzGO9fvQLMn07UGmqBSYoX6I0UjDEgRrcBTPx7Yn8NAAJMrb1NR73gsH3KDDAk2kEKTvpRokluEqNxsKUgr2DBUs=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by MW4PR10MB6463.namprd10.prod.outlook.com (2603:10b6:303:220::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:13:36 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:13:35 +0000
Message-ID: <57a965e5-5cbc-45c0-91ae-3c4c4e5a521f@oracle.com>
Date: Mon, 11 May 2026 20:13:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd_iommu: fix infinite loop
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, Yunhe Wang <yunhewwww@163.com>, qemu-stable@nongnu.org,
 "Arun Kodilkar, Sairaj" <sarunkod@amd.com>
References: <20260511113923.2478812-1-pbonzini@redhat.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260511113923.2478812-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:610:4c::16) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|MW4PR10MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ac3711-75ec-400c-6cfc-08deafbb4f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: zzQ3Rv5zYyC2GUqtTdbJkqoMcApIUWJl7RuSXjfjxIKs+nCRifj1J+FUq6DhU4/pBJI3AYUrYTaeOBwwFrqjd2IaV9/YL9wuENAvegScf45zd+HscG8mgTiZBGK00S/KDd8eWdhK9s1Q9071ks2qDvrhhQMsNZIfA0vTSbfNb9eORPs3I9HG5Pbr67eh7f2l9XdE+9ocP9QB/DzJIb4PE7lGP8fEXPNH/Id8VBVgdeO75fdanzKpnhCwtr6AhpKH6xkbbvRkeav95acaycMsgTgp732Fg/8a2qJfy9DmGCUmNMj2pXtUDIcj898dawvnG5aeLe4onW8cvXK5kFdjpdmY1dge2dPU6DALv97fPKNF4U/5X5tyze5/jK4IvNpMw5uN07TmGrPF6J6YSswQIXsevRVz53ldaYJD8q+cKs2z7T/udzxCrdAyUpZhQNJsCPv8jVBHwKpXBg5sRrc+ha6P3N/uPeU/rM9KAbmDO15/UWWJWjP3cnMwvaIU2+ZOL57igKRuFoR4FLYLE3jXUQLj3H1VHWFGOPSck/iF8qZBmTrGWGkYjrFTOyovVEJOcFIm2hbrQg2jil4xpRfaPuQxOAwIRV4U6uLwMYyXwPsnTrXoghnmj93QW5Vad5kVBSC2CKn3OWK/kmjJiM5y8cKf1SWQBM1iVKkutYYQT5lSC69G/4G4p01h3SSgCjOy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUJCdmo4a0VlVVV5V05WTnhuTU9NY2UrVkpYQzcvemtZWmVZNEd3QXhaU2xx?=
 =?utf-8?B?dlkwU1RPbzF4YWdsREJhaXFob3lUSkpyWHpYekRBNnVTN0wrMlc3amIxMGVP?=
 =?utf-8?B?a0hYUWMrOThWbGVyMGR0L0I0S3ZQZzlkZ002U3JLVkxyQUJQdlFHZ2g2akg1?=
 =?utf-8?B?V0hvQ1ZvY294eU5UL1NWUXIxWlVGZG93R3hGbVdyOGxoZlIvd2xXYXlFTlY0?=
 =?utf-8?B?RW5yWmNxdUxwRGRZRFlrNVRPNi91UlRuWGdoS1E0MFE2bGQ5MUZMOVp0dWtZ?=
 =?utf-8?B?eWJBeXdSQUF6NmtXalhrZGlUd09TQVN2Ykp1QVJZQXk4YithWjQxUDFveGYw?=
 =?utf-8?B?MkN1eUdMNDM3NzdPejFXT1RZOFI3SW5OTzdWeGVnZXFtVmZkU1V0QTVHdWsz?=
 =?utf-8?B?TUdTNWxweldXYXpIK2lSNmtzMEE3QmpjL0t3RGFVUjVjbjdGUGZZUDd6SkFG?=
 =?utf-8?B?YXdCejdIQVRaS2ZBUit0aTlDVzR6bTA4MG40d2s4bUtCQmtwSlg1VFkrSnJx?=
 =?utf-8?B?WS9yQVJNRGJDT01IY1hEY2RydjFXai9rSEYyQjFHeHZkWlJ3VSt4Y2xsU0Y2?=
 =?utf-8?B?TEJTak9SNk03NVM2KzRMK0cvbDBaN011UUwwWDZoZnFhaHdzczFiemVOQ3RG?=
 =?utf-8?B?QXhkVHBxVjcxWFlveldrVXV0WUJLWDc3TmVuSEJCYTBDTGkxU09KSTN5bEds?=
 =?utf-8?B?Q3NiUTcwY2lrU3REUG5sSUhRRzBzcG15RmZTY1JKajRBTlRQMEhKWW9EWlA3?=
 =?utf-8?B?QkZXS0IvVzlyWFlFTXhXMERHV2NRanVseUpVOUZ1ZnV2dkpLZHBhaHZLSGhP?=
 =?utf-8?B?dGtjL1VianhkN1lGQ3NBNStvNjF3M1lqRnBPMXp0M0ZiNUVVaXVrYUtBdldN?=
 =?utf-8?B?UFpzbDZDazRkMUYwK21iV0xJaWVhbkpjL2IxUUZDcWxkOVZJMytDVjl6dzJm?=
 =?utf-8?B?UzI5M2x1Rm1ObUVHR3FTV3dNMVNKZHlUNmJxMHFtTDVzVFE1dGo1RldsSG5a?=
 =?utf-8?B?VWU3YXh4UkF5SUZjK0Q1bGdOZzVnYXFQemFyODhHWWxZekpXY1JYMGtWZGtT?=
 =?utf-8?B?OWdnUVNTaUNwNTNvazNySWtLbm8zbzBXYi9HdDkxbGlubDFoVEJmd3hwMndB?=
 =?utf-8?B?VUhnQkhTVUUzYmY1Z25PWWdiWm8xQ09WVTJmUDc2ZzVkRGd1NDZwdGFDZGpQ?=
 =?utf-8?B?OW96NGVmb3B6SUw5dHJuekZiWWhCdVZNR0ova1NoaUhqWHF1UnhTTGpyemd5?=
 =?utf-8?B?T3JSaWtadzhKU2RtMnRuN0xDUVVGcCtSREJKV3NsaW5nWG1UTUdQaWNZdElj?=
 =?utf-8?B?ZE1ZUzl2WFU2ZklrWnA3WnM1MDNOcE1iemkzL3VOM1pXZjg4TGNNOWtKK1dR?=
 =?utf-8?B?OGwxbDFsZDZjNmdmU1kxZnhoYXk0MHVvVlRqUkFzcFd5M2s0aURiTTkwcUpk?=
 =?utf-8?B?NGp0NHIwOVFzcERiSXhTWFUzcVF5QXZ2OXgrRzVOOGxvNFRxU09tVkRMeVk3?=
 =?utf-8?B?T2pSU3k4UFFEOVBnc3hUZ0xjaGZlL1JNSzN3MTZJVkhPVEhFZ1JyVmNjdVhM?=
 =?utf-8?B?Ny9EK0EydnFyUlk3Zjc3SWVwNTlGa1Rkb0FKc2NnaGxxZWdnRkdZYnNyM25D?=
 =?utf-8?B?NFRPZE4yYVF3R1lUM011UEczZUtPNXRMeXZuazAzZmVuUC91Q2d4aC9GYW4w?=
 =?utf-8?B?UElNNloybU92c3lSSmJoelJtaTFoRk9BaTd5T2pYNUVDQ2c3bGlkVU5TdGVW?=
 =?utf-8?B?UmZmUVBZd0NsS1Q5VUZQUTdXYzB6Z0dZNE5kZHd3WVQvWHlMTTNPazdqUGla?=
 =?utf-8?B?UTBpRHRJT0pDbkF5OEtzRWl2dlhuZHdsNWs2MlRqWVAyN1NWY1RUUXFMVTA4?=
 =?utf-8?B?OW0xZnhORVlIUEIyeURQTnlROXc3c2U1aVR1eWo0Y2ZEWlF2M0JOdURFdzl4?=
 =?utf-8?B?WEdMclk1TlhaU1dpSmZLNk8wZnM1WVNwRjNwSjNkQUw1c00wU2ZPa054aUJo?=
 =?utf-8?B?eW1pOVMvN3YzVjZ0bWtvMUo5TTQxdTRaaTgwNXVkYXBTOUJhY2t2KzFjdU9n?=
 =?utf-8?B?ZkFwQUJFckR6U1d0NWVmRDl6bmdoVzhoTUhyWjBQSmpTandYMDlGQkVsZEJ4?=
 =?utf-8?B?OGw0cVBzcUcxQ1JPUG1HRzNlb2pEOFhDVkNwbzZZa3JzK3BIbzhsSU5EVGRN?=
 =?utf-8?B?VGVXNUpTU2JadGNuaFErd0V3ZWNOaVdhSCtWUElVY0F0TEdyUnZwNkF4cHpO?=
 =?utf-8?B?eUNmeDV0WmxJTWVVWVpSNkhycy9GRGpseWJxV2xUTzhxNVBtbFh4bnNlNm92?=
 =?utf-8?B?RENpTzR1ZGhBbksxaXgxdjJaSjNDR2Z2bGM1NkIxOElvemtUTU9pQTI5Ykhs?=
 =?utf-8?Q?hTvnMuZ9YkkvT19ZkyZNT0ZMhXjYXFIYNrTKr?=
X-Exchange-RoutingPolicyChecked: TMaSUZzqjV4EYi9zDqVULBpasAnwJlV3gwRodWYfnzsiK0iwcTrCQ4VljRBceaAqXvaulCcjz4rzdWSwHPxsa//FeUg2l+3hqAsfwzred1h01OZrQWk/vEn9buNKgvYyjV5nvNTS3kRduxDeNlkzu/fwXtcXDgW8pimryBT45l1X0PFui9Lv2lvme1pBtU5fTZn6lAL9ACepEmVRKBIEVRYGv+S72TNbpVNdOZp6A0TKi8F3qad8Lx2lh/iHSlRrl8GpcX7lEg2p71FvhMiGvhapGxa+96k+KKGm3OsSom9GowgWKuog/7MJQOi7bU5GYRRwpA4kQ+0T4cr/nzWxWA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: peaRxWoFoYoEdIGLV7NYYHx7vJzbZemnUm1+o0dKEpkdpEKqu3o6rtya4+ttG15R3RU/0/92tBXPfVabQODnDD9y0AC8XADNF/SoFAhQHO0ZOWut2lhg3GIFz8TI0JLifoqJUSJEnbp2xNGbfJwtOkJRrMNneiRqc4TTD97vijBE1CeaVcHyftcQziCaFKRJOybt86x4CUDhmMRAkJqxuVxEEwxFWUbGu5oqKoc8sQD9c/XIxVkG3J4XWoMK6EQReqPzXRFljRjt6jOzQwWuG3jfirMpKrJN3tFFYbsaIGLkl+7NHJMhMP15iHDrOUchU9aqU45ZUOvIYxdQL8epDpxBwQXnQy9/K06hNbGV2NG3rAgONFyeWr8kl+DY0Bc+PneYn1yBXLQSXVxxMhg9DK8u83r6uI8KV+w2zdN5Vvsfqncm15YysXGceyTorXM9/ycTmjRhWmtH1SlRQWxY3h80dtc0H6QgpxJhMstm0Wcxc1afDPplR1+H0guFPsKyrLWWfAu1AU8L7n7P4W/mVicx5Njq5ovzEOwHRhcE1FHM/3gZ2L0asNx5VieBcFQ/mKEdhxFwyNu5ieGQYEeJlHvSQ8a3JXYUb9+X5iHLw4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ac3711-75ec-400c-6cfc-08deafbb4f3e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:13:35.8273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqRQMVNtbhhmZBJDG6JS+sFJJ8MzihKh09cnbcbaXj96F6FK5dJVJ/0/JidiqkAJTGhorjONYqaLDNk2kFgi0pnl+LHO7RrdqS02mB1K0+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6463
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605110254
X-Proofpoint-GUID: U1xUJq0Yb1Jkxh2E9xqpsUn5vuFqNA4S
X-Authority-Analysis: v=2.4 cv=ed0NubEH c=1 sm=1 tr=0 ts=6a0270b6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=Byx-y9mGAAAA:8
 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=E20wtFWET9oys8LK35kA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: U1xUJq0Yb1Jkxh2E9xqpsUn5vuFqNA4S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDI1NCBTYWx0ZWRfX2YB7wf0hNIqX
 8DP4J75js+/0yG884ea5REg+UOX62rhTMsubIgsUutFQLFnMxl7OCuI8DVSgwhH8rfz/JG3pwxL
 BuWCVZkM4eDW23Sakaznr29MvXWZxABLZPlUAmQDMyaP6roWyUrdFnwDLxooqx/EqLvsDOgHBBo
 l+vZ4NlAzqTDgxqn/ZDm0sSo4pFCTbqJRxTIl+KCry6gYzcZpovMhLmuyFvJtf6DTI6IczrtG3d
 DBagtNFhneiMrQ1cYf0cgjODpQCCBGmzf2KJgraLaCETjqwznHBRoqbCbBuhjqY+vMvG/9s77tm
 KppslHapujPQHt4XQI8Bhxq6CAZb5ScAb90By60SdfN8YBdRaRPD8s7kEKyOGjrmeMXw+taC9ol
 pMqZDwl8IRbPVEA2Ba6so0z/AnNt9iNXM7usMFbJ60EqJgTUKhKirTN/UB+2gXVEercPmcC6gwh
 iWfKrIXWWOEL4uU7svw==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Paolo,

A couple of comments/questions..

I'd suggest replacing the "fix infinite loop" commit subject with something
a bit more informative e.g.
"restrict command buffer head/tail ranges to ring size"

On 5/11/26 7:39 AM, Paolo Bonzini wrote:
> The AMD IOMMU command buffer is a ring buffer of cmdbuf_len (a power
> of two) entries.  Each entries is 16 bytes and the head pointer cycles
> through the set:
> 
Not sure if the ":" above meant the intention was to give an example here
with a series of offsets e.g.:
[0, 16, 32, ..., (cmdbuf_len - 1) * AMDVI_COMMAND_SIZE]

or just end the sentence there. I can fix it either way.

> The tail pointer is written by the guest through the COMMAND_TAIL MMIO
> register (offset 0x2008); the while loop in amdvi_cmdbuf_run() only
> terminates when head == tail.  If tail is set to a value higher than
> cmdbuf_len * 16, head will cycle through all the elements of the ring
> buffer indefinitely, without ever matching tail.  Fix this by further
> masking tail (and head, for consistency) against the size of the
> ring buffer.
> 
> Reported-by: Yunhe Wang <yunhewwww@163.com>

Was this reported in a public thread? I have not been able to find an
earlier discussion. I will send a follow up change patching an issue with
the head pointer handling in amdvi_cmdbuf_run(), so I'd like to check if I
missed any other similar issues.

Thank you,
Alejandro

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/amd_iommu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 789e09d6f2b..197e452e3c3 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1578,7 +1578,8 @@ static inline void amdvi_handle_devtab_write(AMDVIState *s)
>  static inline void amdvi_handle_cmdhead_write(AMDVIState *s)
>  {
>      s->cmdbuf_head = amdvi_readq(s, AMDVI_MMIO_COMMAND_HEAD)
> -                     & AMDVI_MMIO_CMDBUF_HEAD_MASK;
> +                     & AMDVI_MMIO_CMDBUF_HEAD_MASK
> +                     & (s->cmdbuf_len * AMDVI_COMMAND_SIZE - 1);
>      amdvi_cmdbuf_run(s);
>  }
>  
> @@ -1594,7 +1595,8 @@ static inline void amdvi_handle_cmdbase_write(AMDVIState *s)
>  static inline void amdvi_handle_cmdtail_write(AMDVIState *s)
>  {
>      s->cmdbuf_tail = amdvi_readq(s, AMDVI_MMIO_COMMAND_TAIL)
> -                     & AMDVI_MMIO_CMDBUF_TAIL_MASK;
> +                     & AMDVI_MMIO_CMDBUF_TAIL_MASK
> +                     & (s->cmdbuf_len * AMDVI_COMMAND_SIZE - 1);
>      amdvi_cmdbuf_run(s);
>  }
>  


