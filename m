Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0D4CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 23:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcXBL-0004oA-Ou; Wed, 24 Jun 2026 19:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wcXBI-0004nz-HR
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 19:38:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wcXBF-0007qi-Hs
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 19:38:56 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEUxcI2701409; Wed, 24 Jun 2026 23:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=dR+YxHR0toD6rofhwyJk/QkUx0j1QMsDcJ9kTr/s1sE=; b=
 KtaAAA66Y70UjUjGYg5i+LQ/ZpXcmTKbv7N2bFPQkJlqC8VloIrIbwmeHXJ7Dgff
 Kyf0TQWzmKB46h6ulBvfq5iPoRigOtOcJ/tgahyNYq2oAH09cZEthSkbnJHRiOsT
 /YjqbQ/IQtehZc3XtQgRgH9VHA0zCETFfWuXdJRg812zbFtld36HMK/Vj5aPaDqs
 E7WnqqwNlPI4mPrwe+pi641EWbE3DmFM9IAeElfkrm7gd+rG6CyCXx9Qg2pjMgv4
 HtrRvtQ9y1Tn/m/ixVg6+b0XGVBFWTZQN49Hu9+pSG1oqFyyGZLcSBe1Y474d+Ly
 QsbZd1cBFvS9ZU9XiRYOLw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjwced5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 23:38:48 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65ONXnfM015514; Wed, 24 Jun 2026 23:38:47 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhas8g33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 23:38:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AW+xSS1oVjqKBHZDopPJhWiXQGfIrbXTiBsJU+bO3x7po0Bwue1FTIQ4+m4bRKWC2osLlOA9tS8KrCuu3RWyJc7j/HiWuseTTAjD1rjSe0lA8CFbvuQnZ40cekBQWLRE//ibTf/grPNSX50rzBRkvaCNgcVMD1sBgxqSfq4iyaupE5H9/R7SN4Pes6PGA1WaOEP7+lK7Wj+8rOI0ICutKrU08catAWhlhS9xa8n4YBudH7+8FOXM3MWEFyQ5P7NEnaP/h9Y7YN8fCBtJu50ALYVJch1V53WWTmjGs8lCPhVTBubYHHdCM3OmbUpC4Dqh0CdpPumf9qwmXgqIJzsyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR+YxHR0toD6rofhwyJk/QkUx0j1QMsDcJ9kTr/s1sE=;
 b=FfoB0gcbppQukH7d4eiyZhMq+y64RhCaVg4t0S9M24TyuJwSjNDHH5i/eiCJhR7voSqDou1z3eSl3zstF9STdj6FNayf2+Qf7+aU/iS9/dGinit4aEhSuvCzCy0z8wss4Sg65gWWqnOqqVagBDrutsUSknWDfVfSlG/tPLHRfcdCJ7RXUMiX+w6c++T38UnvDqOggtBvc/ipVnAJeICmZhbO1yByaQigfmr7vnfs8iumaIG9I4TaXkjTBV4MA4xFoapgf1O9ACdGhAlEZ5xw1JF0VOQ9DFqkt0FUjZauKsjQ4lfstLlYI4wiBW6tXlVwXqlwCbkyHqIuX+kdytlHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR+YxHR0toD6rofhwyJk/QkUx0j1QMsDcJ9kTr/s1sE=;
 b=Wa5f27Ku7kSkc7Sz45ItCeCG66A/rfCSy0zO7Vz7tumF+apa/QOVNhzStbhs2xsA6BR3Ojrcn7f/zdYAUyevKt84Lhftyvl5kVVEhRq+MceAMvNcbJO8mcMQyu5oc7T8S6obMmySZCwez1Df0R+O649TdAcjIj+ZOUUF5p48RbE=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by IA0PR10MB7643.namprd10.prod.outlook.com (2603:10b6:208:48a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 23:38:43 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0159.014; Wed, 24 Jun 2026
 23:38:43 +0000
Message-ID: <0c78c4f9-6a83-4e1b-92c2-ca7af9f595ec@oracle.com>
Date: Wed, 24 Jun 2026 16:38:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] migration/cpr: support vhost-vsock devices
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org
References: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:a03:114::30) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|IA0PR10MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ad93a7-4f2e-44d5-d95e-08ded249ba39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|23010399003|376014|366016|22082099003|18002099003|6133799003|4133799003|56012099006;
X-Microsoft-Antispam-Message-Info: TNJDKIDmtkCibC8/SZj31jZTFLYNRRCot1gcLpJ1FaHgO+8mXwFV3NoRDNjO/uZh8p7olmKPqS4ksCzckP8FCUMxHi3DWt5yQoFWoauzTDuuqF3kJ9TLF8TLhgXiDUESlWNiICElgJ2PXp0zrYGvGniCAx9bOaa3WUEKjjFQjfv2HGkM79HCjG3rNdQw4z8mP99xDLKIhcz6j7eeSt4/m7RWiGSs1Kkz6dWyIHksRhEDOKwUKAgdJ4bizwNix4rsroAfJ9jSi/dHCFvIdkXp3ykUAHgzmpTLavIsNYOKovweRKu5lKsmAzjzyF531biyMWUqj3tGzahewrlHytwkKF4wScM1dwkmzRz0nome73e7ig6a0U0+GSpqXaCcrTmWdm1fN3QIwO6PdKtD6yzQOTUjlYfuc898x8/mJ+iwz7A8Ze/0D1pyjGNMDX6my8jaABKc96cr8oZzDPxSS0yyhy7gHdU0mPxu6hOF9ULYeUYy+oJoCy59L68EHbJ8AH8mLMoMHsHtgEl3QH4Ch15u5gR+9evCurArM3qIhv6pVQzzG5E5CbfCJo1taw82NS0bWOjw+Nsyo29n5qc2iUmlMs5swqLKqNmXv2sLrbZXxXpxWPe7dNwQtTWGBUPHgKW86BBiDHUS+M+5SDYsk8Nlf2gbOu+8njwUtotznqDS8jU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5109.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(6133799003)(4133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTJGQWJLMFRka05BekFFdzdUdzlWcmN6eWNoUUs0OWYxQlI2VmZDUEwzeGlQ?=
 =?utf-8?B?V0RlRGNEVllqcU5Ia25GWEswdDdoS0M2cEhJcVE2RkhKckhva3Rub1R3THph?=
 =?utf-8?B?VlJRVzFCdUMvWHNQaG1PcU91cE8xUU5SRE10MTNXK05vR3NGMXhHbklqV2k4?=
 =?utf-8?B?Zm9nV3UxQ3FUMU5oQ3FjVVQwWlBPZmZxenJJTVlsRHVLMXBhaEhBWm50eEk2?=
 =?utf-8?B?MkJxY0JObnh5eEp4V2Q0VmRZRDNQQ21FcGs4QzNNQ3puRmtIZ05Eb3lYSzlr?=
 =?utf-8?B?OGdmcy9zdkFXelhGU3RQZzgwdWU3QSthdEo2YjNCNDZCUUQ2UzNjQVIvb1hX?=
 =?utf-8?B?aFd0dEdaYTJTZldHYm5EVHkvdkxWY2FqNGl6NS9nRFF3bmJ3ZXN0RUtaR0x2?=
 =?utf-8?B?RE1MUG5uQjd1K1VCZ1ZpOXYyMkdad3BueEptNEs4QlVRSkVoLzh1OUZ6amI1?=
 =?utf-8?B?YnNFQUI0TlY3TFdxeHhSclViSWloUGYwNDBHMStJVVFaYXRmV3RkY29xNkFN?=
 =?utf-8?B?ZmtQN21hblhRZkpNQlpTZ01XalJPMGR0VTNYNmk0WjI5QlNoRmJhQitxdzh6?=
 =?utf-8?B?WjhuRHZzZ3ZZNmNON2hoaGl1cmd3MGRaSjUvNEJYb3d4a24zcGdIOHNqWDBD?=
 =?utf-8?B?Z2U2c2k5aU5xbnd5aGxaT3R4VVZjQ0xGTDI4UGtRTjZ0RDI3MU45VDRqczhY?=
 =?utf-8?B?eThWM0JZS2FtVlN3Nkp1bURHeHFXdlJKSlc1ejlrZk4rSkNqN280T0ZFNno0?=
 =?utf-8?B?SFdDejIwY0UwQWJhUXhlS1ZFcTkzekFsc3lrYVJ3ZUFNbmJDSThrWXd1L0h4?=
 =?utf-8?B?QkpCcWowVUEweTJ5L29TbmUzQ0JaR1ZQeCt4M1BaRk8rMzVlSWdwakxlQXJR?=
 =?utf-8?B?eGtqczB0QTJMbURmUzNLT3RUM3ZRWVpxNjFybllkbGRiU1FNMWVyZGNNS3hS?=
 =?utf-8?B?RXoybnQvcmdQdElUYWg0QlpsL3lCWjB4Ti9CUks0VDZNTGlaT01PcjNPR3g5?=
 =?utf-8?B?T0laWG5HM0d1d0JMaVlhbFNYR0dCeWxwZDVISWNpTStoUXFCTkNJcFBCSlRt?=
 =?utf-8?B?NkE4NGpKVmw3eEtMRTNLU3UzU1VzZ2g4dXB3Sks3eWVpZlVrSXJxdkVrVXM4?=
 =?utf-8?B?Y1EzQXJ3YTlQSkhBc1lXWmdJc0FFa3E3WlJpWWFVWmlXZ2VMVEhzZUdETWxH?=
 =?utf-8?B?Tm5iWHVwUGd6eWVMUTdBenA3RGl3UFVMUmtnOHh3QTh0YXpVaTJOdDMwbDFM?=
 =?utf-8?B?Wm1hZE5uOUxYQkhMUjMzdlZnZTRxZDZDMTZVNmpiWDBFcXlHWk1UY2Z1YTh4?=
 =?utf-8?B?czZwbEF6SUZoSkdYSlE1R3lMSmRiR0NDckdyeVpXNE1FdWxkUG5UZ0R2b3p2?=
 =?utf-8?B?TCtMdTJGZ1UwMS90R0xRZ21nZVc4dXh2S2V1cStwVjM0SFJEVHErQ3plRVcr?=
 =?utf-8?B?TmdKMXZaWmNxTlRmamR6YStnY0tGb251ZVoyd3cyY1dnamVSZ1d6MGVTQ0VU?=
 =?utf-8?B?NTZPTmhmYjhvQ2g2aXNpV1J4WG4zS3FTQzROMjU1Y1NndVYrc2h6T0hyZ2xk?=
 =?utf-8?B?S1BwRnJMOUIvOW9hZmJTeUVBeWxqbXFvdTJ6OXI1V2JlRzZWNzBBQ2xMem1N?=
 =?utf-8?B?YUxVL2hBeHRDVUZoZFc2WHdDVVV4UVRIMW8yZ2lBYStFemFDQ28vMHp4Zi9L?=
 =?utf-8?B?TnpsUEJRM1VIWlZFaWswaDNDejNqM3BoVCtWUFd4dzZNcE4xZ2pNZGJkMmwx?=
 =?utf-8?B?VmFGa1E1eDI2MS91UGZYTHJ3ZUlVb042R3N6T0pDYVUwNmdxOWt1WjR0bkRl?=
 =?utf-8?B?R2FrakhQL2Y5QU5TM1lEUmtXb1hkNk5ZMEpiMWxQLzVxUmw0WFRFUGdPQlVr?=
 =?utf-8?B?My83OTdTZzhjYUIzNXFaM2E4dzFndEpqbysvazJlMzZ1QjZRWktrZ280YStF?=
 =?utf-8?B?djlDWGExT3luR2Q0T3JJdkF5SUZzNHJuS3J6Qi9uVDZkQ0pueVptZW1XRkJV?=
 =?utf-8?B?NVEwSGdndVpnNE91cUo2OUZPQTkzbUNvQllaSzZheWU4N3J1azFpV0R1ZnJs?=
 =?utf-8?B?MWlZTUdHY3hocDRidlg2SkVudmR6ZVlld2pqeEx5WDVDR0ZyR2NQZGEwcHNY?=
 =?utf-8?B?TnhQSGZZeFVDN1JpTDNwOTdpSmV5dkdZS0hZdjJnTFJuWXM1QytKZFJDc3Zh?=
 =?utf-8?B?NUhJU2dibmorZkhZb3lMVnJya20vVkorakU1dGwyWVhWY2o4THVCekFialhS?=
 =?utf-8?B?U1dMVHByRkdHc2dhdVpYRS9wMU1kZFBseENhckpVZXlsdjRHbVlZZjArL2t5?=
 =?utf-8?B?VnFIckNpcCszaS8yZW1SKzQrWUJoc2tna2M0YkhjM2g0dEkyVzgxWE5FYmM5?=
 =?utf-8?Q?WDiYaoo6RxNmFcQbsEWd+NpJxYtcXmKDpJqyE?=
X-Exchange-RoutingPolicyChecked: gI11s0JOoR+7SaXUCu7/KbycOPA3JsvVPUJvuTWYTMDSZfP2i0cqhRy1eXuUZuy8/tK0kSGhlF/k0dJ3YZhVY3J8A0TbpIQXlahpF4PVPzwmkhUcFXnVn9H+5fBh6IvAgLcZGe1bwENzVzsu6WP9wlAmGDzX5S4NkOqCwsy0vWPLnSMAx1rwnNZt2k5ECvjR20qcPnSS5jERuZtt1KIy+AWmRvZ8hlc6bCMSOxj3eMkkoeDFJ/liPRo6HgiYsrJjgXDnO/RKZXhJea/OrbWaj8t5iDA0zw2FJ+5zl622NpuPB08buRalOQfzpo0C497oSl62RsW45zpJc2OruBE9nw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oXEHWt9us3weCtgrpOAdT588De0UqPfa9Wu3PRn2jB1lzW+a4RJkdUtmoS7QnqxMbonwMDRRrET2/9cF1KzSKTf1D1UanQxi3M3MEHO9WQ5IUave8/hRtspIhvmcxFbsucq2g8qCZ8o3TGUneUhzDdHPYOCIkBAPgxDuBVNQBnFPlmgoghTI/uNO5tV9k2nOTilVslo6q5T7XWd66gWf2kr4bsfUw8ACFhw4690B78Qylwic+Ga3BvbBNLuv1ULNFgvp7mF9XJaDnJEi8omn/7syhSuUwz3ag9HS7cjZJrrXryrGWqlXjWc0iBmAU4/cdrWN7Rzt+tgLsGFaVwkUJO1faxAPtX6gWH07502nxMSqE5mgEurmmWLTxlN56E9jpfScJl+ZNjipxRR86RUNDXciJCAR5EPHmG9Ao8GrfZRB8Mr5iNJkN9XHiFkY8sh6jGsjlu9cToQFwcF5bf6XhiA5JL3Z5GVErxTMcTsn47Tyzvy+Pb+Yhdc2G2RTeWkAI6+gqgX2Y01uHx5YUh6Px9mtjsiosWnH6b/6xNGjEhU9W1tS66WabOz7xVy57bXDTHtMjTV4gnlZdCxgZOvrkBdIUkr7DNxQK8EiSaxJvuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ad93a7-4f2e-44d5-d95e-08ded249ba39
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 23:38:43.5322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+3INbgOiDKwVa0NeRSf7zB0r1eebwS6ey3XsV14xz3FkJXIB6t4M+BbHMXuoR3y9LNX6TZxMvV8l8PspgOg5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606240198
X-Authority-Analysis: v=2.4 cv=eJAjSnp1 c=1 sm=1 tr=0 ts=6a3c6a88 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=TYBLyS7eAAAA:8 a=1B82pEELQZWq7MQ8RFwA:9 a=QEXdDO2ut3YA:10
 a=zvYvwCWiE4KgVXXeO06c:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12312
X-Proofpoint-ORIG-GUID: 94sGjs5tmsrB4UG1yzma4eAI_CYTK0ZR
X-Proofpoint-GUID: 94sGjs5tmsrB4UG1yzma4eAI_CYTK0ZR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE5OCBTYWx0ZWRfXzPFGOpLY+aOo
 tRO19fv99NHk2ncBc67Zs4d7oOv8tNDTGdgXLtNJoFJhpIblzlfBHYKMGuCCo1j/c9t0AcC8AV3
 FPP7u2/zI+fIm7QVBHsqW8ku3vOXV1macMTqpzNg326ycjBgD8rXx7Ja2jcvhJ0gmrkAQbXpTsw
 L4lw23jPkWLqZdCSHNHga0AgVXxamGGYPLALdPUUB1tmPI0icKgIkRb6ygbGWWXq3Mkfc1fHaAb
 DLth+Bj17KvsI1SML2kpyvHVz4xF20v6GberLurZ0zRu24xPwWhhjPHsgindRV6xq/1LCXf9AmU
 RBLQGmVnzA6DfuCILkso5Pw8IBa3aveajt1X9ojSk2S5yTYZEAOamedqVUB2sbrGbK6tU0DzwVR
 H8WLdGXFzMzCGplUBH4nVgvGio5HXkr1BGMs6jPojmP//+x98tVPSXOLDLFu/Zs3Q1cTe7zE4Yf
 tN/K5SlLSoIxt0UDzl/jlhwu7CvKL9wZfs5ge91Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE5OCBTYWx0ZWRfX6k/m3E5+cGJ+
 qT24j+92asNV9L4Jd6IGI38euJUKeSxYfedX9fwUJx17ZI8TDE4dqDCU9v7fiNjNVgMvhPq5ZDU
 KFLmPdLtgXMwi8qRR6IGS5h9wJEjTWheYfR7MRGJmxOWpHWZ12ud
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
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

I was trying to understand the error paths and why these calls need to move here
and there. I think I now see where most of the complications come from :)

My understanding is that the current design relies *very heavily on
vhost_cpr_notifier()* as the mechanism for releasing vhost ownership before the
CPR fd handoff.  Since the target may receive the vhost fd from cpr_state_save()
and call VHOST_SET_OWNER before the main migration thread is started,
MIG_EVENT_SETUP is moved before cpr_state_save(). Once SETUP performs
RESET_OWNER, migration_stop_vm() also has to move before SETUP. Otherwise the
source VM could keep running after the vhost owner has been released.

This is reason to make the fix migration(cpr)-wide rather than
vhost-vsock-local: it changes the SETUP/stop timing for all CPR notifiers, which
may affect other devices such as VFIO.

How about to borrow the idea from VFIO? That said, transfer the fd early, but
defer the ownership handoff until the source is stopped and the target is
loading the final device state?

1. cpr_state_save() transfers only the CPR fd state.
2. The target receives the fd in cpr_state_load().
3. During target realize, vhost-vsock restores the fd and initializes only the
parts that do not require VHOST_SET_OWNER.
4. After the source VM is stopped, source vhost-vsock releases ownership from
pre_save with VHOST_RESET_OWNER.
5. During target post_load, vhost-vsock completes the handoff with
VHOST_SET_OWNER and the owner-dependent initialization.

Of course, the decision is left to the maintainers :)

Thank you very much!

Dongli Zhang

On 2026-06-19 3:55 AM, Andrey Drobyshev wrote:
> v1 -> v2:
> 
> Adjustments on the issues pointed out by Dongli:
> 
>   * Patch 1: avoid emitting SETUP event in resume (postcopy recovery) case;
>   * Patch 2:
>     - gate vm_resume() op by checking that block graph is activated already;
>     - reword commit message;
>     - adjust the comment.
> 
> Also:
> 
>   * Patch 4: use more generic proxy object qdev_get_parent_bus()->parent
>     instead of container_of(struct VHostVSockPCI)
> 
> v1: https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20260612165110.431376-1-andrey.drobyshev@virtuozzo.com/__;!!ACWV5N9M2RV99hQ!LRVJYpDrzTKttLBQmMWczpaOwMB-ftzvLd8PYJRzKs_s5bvmx0kTjHl6pR0yA5Mb0Nv6YSoWkXTzmwMbLepUOy0bHXFGVenJ7Q$ 
> 
> Andrey Drobyshev (5):
>   migration: emit SETUP notification before CPR
>   migration: stop VM earlier for CPR
>   vhost: reset vhost devices for CPR
>   vhost-vsock: preserve vhost FD during CPR
>   vhost-vsock: don't reset connections during CPR
> 
>  hw/virtio/vhost-kernel.c          |  6 ++
>  hw/virtio/vhost-vsock.c           | 40 +++++++++++--
>  hw/virtio/vhost.c                 | 33 +++++++++++
>  include/hw/virtio/vhost-backend.h |  1 +
>  include/hw/virtio/vhost.h         |  1 +
>  migration/migration.c             | 98 ++++++++++++++++++++++++-------
>  6 files changed, 152 insertions(+), 27 deletions(-)
> 
> --
> 2.47.1
> 


