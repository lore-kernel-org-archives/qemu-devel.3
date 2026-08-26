Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A764C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzFwg-0006nV-AZ; Wed, 26 Aug 2026 11:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wzFwd-0006mJ-Ql; Wed, 26 Aug 2026 11:53:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wzFwa-0003Ia-LK; Wed, 26 Aug 2026 11:53:43 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QEu0OR2499174; Wed, 26 Aug 2026 15:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=0/A8DnCCc2jsDsg4wlS1MABE/w+iLY/vkVsrq6r0xZg=; b=
 P/FWLtnKtspXnOW6qk96r87GbEMtn6dvZUOO1x0PtJ2SSDW0xNoRD5ar4v9+Ow3g
 +9BySTNemn/dp6O7UQwY7Gm+qBaLA1ZPtmK6s5KJTfHY0HbgEA4ORXXKRMBl2w+O
 3i/JJrUu43o/iLKfA1fFX9wlhPLhrx009xLWDN5mq4eC0H1pB5Q0jsF67s/APRs5
 7okd76sHK9M5DxL9whSEhHwng9V7ags+cJTchuYsZCRbUT7ptAKKv5PpgyE63X0c
 gTYqVElzLt+gb8JfPcZaLOGF5cnoZjJRLmdfZUGcIeSB3uRSAKgK9Q6MYmes2vaw
 9mPKZwMEfD5q9iRXsWk85Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g73n7e9gh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 15:53:15 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67QFofLG012609; Wed, 26 Aug 2026 15:53:14 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4g86hgfwvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Aug 2026 15:53:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3r8NXvVuFK0YBTC9/ItgoR7by8AS6FGi4Prd3ukxwrcj9fKWa0zQ/G0ljzxvnWkMb9SHdFOVBRnPPO3dUwp43GDSAqpqy5NsuWZBpcs/Dhogwm63Bxfn9NsKXPU1yvlVFmEZw8PWnGtP9xogkcwazFwdnN78b1p16kPJNKwwNiBoLCXkDmaFivEz+Zi/YKtlKWiNgIJ8n9jZxzajWLJJS2JpX5Yng0xUJBH7tNAw9cSutMezGtbcPHBqC+Xqk54CyGWgQZHIk+wjFCLYor73OptyKn2sStN3AozW0HM6EPD6nKWcfQfCYnMsVd/bDRhYUC2ZM+Ut7LC9stUW8pKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/A8DnCCc2jsDsg4wlS1MABE/w+iLY/vkVsrq6r0xZg=;
 b=LmDmZJj/aIqMPZnnd5JV343uQ65lN7NadfqYIUngQELZL5PGr3gYpvG5abUIOA6b3gllDD4IltS+b8naebHQgDHDnMUtRPP8esMv1zc2khM1PYtA9HYhv25iYZB8yBHVKVqfs9ZUSi7z/Rwp5MouFjLc1sqdLTdOJw2bzH6YYTQUuNHW6FHcMwc8n7azr+MNCO5ok3CfwD9mSY748V9uyaDQW3OZXTguUwXFZW4x/DvCLjUzuYMTTqAD2K6ggncRY3dNZlIyfrEoaoMz9W3Z4n2766uB++lpOhQxJOIcMXc11pOuImTA+ATbVge47GdgY5ZugYJl03Dn1k538eyQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/A8DnCCc2jsDsg4wlS1MABE/w+iLY/vkVsrq6r0xZg=;
 b=Nv6WgxDMkD/bVyqAU+dgfAd1lf2FV49mm53jIpkSyyqr9qo3oPBCSJHQAvo/GMLMzHTeT+vskdOa47kJ0/cPmMG0xu1ToVrkpcSvwzfCLyHu3+bXca0BhzLFQL+c3Qu8VvlauYc3i9qNWxMfNk1GFUPd1iddx2Ivi9IuBsO2nNg=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by IA1PR10MB6123.namprd10.prod.outlook.com (2603:10b6:208:3a9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 15:53:09 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0382.005; Wed, 26 Aug 2026
 15:53:08 +0000
Message-ID: <e9630f86-0c9c-4846-b3a5-237f7a052be8@oracle.com>
Date: Wed, 26 Aug 2026 08:53:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] qdev: Support forced device_del in QMP and HMP
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, dave@treblig.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com,
 akrowiak@linux.ibm.com, jjherne@linux.ibm.com, sstabellini@kernel.org,
 anthony@xenproject.org, edgar.iglesias@gmail.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, joe.jin@oracle.com
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
 <20260824011420.752806-4-dongli.zhang@oracle.com>
 <aoxYTO8UkzzXvKOc@redhat.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <aoxYTO8UkzzXvKOc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::11) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|IA1PR10MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: da192af0-9b7a-46ae-2258-08df038a1f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|13003099007|6133799003|3023799007|4133799003|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: n6dpMtwxManI56moXK6lRuHKxv2iO3Og9rM8eRvAbrbssK5rTZFx4DhVkaJDuXma7nCiwyMvXZUZYmxjaFYS4Ada5Y/YvP7+V0n/AuBiSWCzOxsjQIsvYMOVuKUJpeRBgYx72v+ItaFv+CqYuVXgzZ2bwsnhBtsqenLpkzO7wWEkXRL5nPuYU9c8lwW71LytiKvAhb/VSY2kETJKkTyFw8uGVoY/YxyeXGx+JglckQoPG9NJo2BjXGPiWEsqJXJoO7slc3dxbZwXdEnvYARxxdTMLuChouCRiFZzj6axFHjw7GJMTymQF4z6GRCRzelOG3mibBZq7ko9MLZxMzNDhia+O3xA1WhBolO3SqHs/5NGQD/lpRWIPtMXRLH3pFpyku+EZAYjXt8eCgZFLnUw5qhzAXVGfcZvZmJTN9QTlepXr1+NcSPU6EsP7OE79wt5hpf49Zkq1XA7nuBVWZfJ6czXP2jFIyedDXLXTFIrAuhcTvyJmFB/o31hKeHeB1SVUJHNyhwTS9ocXp5NOZyk9rzPmbjmNUBCaI5kxnh/mfP5kkCybUx3EjfIpGhMKlm9tWoKVqGDFC9Hh4pbmQmnNrrvVNvSdyDx342wENSYfG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(13003099007)(6133799003)(3023799007)(4133799003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmZCdk5KWHhSTDhGZ0dpRElXdFFYZEhNZ0FtM3k2N2hnemZWSWMyQjQ1Smta?=
 =?utf-8?B?R05rb3hKYTgzQmE1T3NJYnNTUnozWVQ2SmNEaUh2dU9RQ3lRYUV4RC9scTN6?=
 =?utf-8?B?ekxhSmU2SnJUMklEM0M4Q0lDakxhbXFtN2IwM2FtbUtiQTlidHJBR1hKUGpN?=
 =?utf-8?B?cnd2bmo3Mm5hU0hONVpscVg5TGtndUdFcjlrTmlkM0tjUTJ1T1RTSUs3UVZE?=
 =?utf-8?B?djJkQ1JURVBvNVBucElYRE8zN0hFVm9mWTBJNzNKcDJNeGs2bTB2MHZ4V2dx?=
 =?utf-8?B?aHdTazdGUzFqQVNVQ0swbWdIQ0lrczVTTXdxZHdxN2RLL0o2bVQyMHVDUlEw?=
 =?utf-8?B?d3hGeWlybCtXc2Q0cmFqQ1E0WXJRQXpISm1iSWN5dDdQM3A3RWlYNlh2eUJs?=
 =?utf-8?B?U1pXTllxSm9wT3cwUHg4N1FiZnpMY3Bod0paYi9sUE8wZ2F0VnFxdU54VllS?=
 =?utf-8?B?bkwweHhrcjBJWEo1RGxRcmdPRTdLN0FsUmllZEp5MjZnckc2dXVRS0xkeVUw?=
 =?utf-8?B?WU5ZbWFYZHU1WHQvR0VRNWxwcmYrS0gyRWFHWER6NHdIdHB0cVdrdG5xdWU1?=
 =?utf-8?B?SG9aeGs2RFBiYWRxYTFYbmtjZkhmWkJYdHZCdW5laUNvYjZsL2pBWEt1ZzRT?=
 =?utf-8?B?NVZFNzBxVUFVU3E2aWVlY29QR2JjMjVkeXZXS1lLZEFrNWFJWVUvTTVLazdx?=
 =?utf-8?B?MEVvdFFKbUNaeGN4Y292Y05VekdKd1lwdVZOTUV4M2haNlpZVHpiRWx2WVMw?=
 =?utf-8?B?Sk5FNUNDL01LT21QQWlGdEd1anFveUlhcWQ0cXVTK3RaclVta3BSWjZDV3VI?=
 =?utf-8?B?QUZkd3FLK3FFTERKak0yNWs5RC96UlFEM3llK0p3VlV0QXBlMWxkakl5R1JN?=
 =?utf-8?B?anNWQS9PZDNRSUswMW12R0JlcXFRdU9KUjI5ZVRFanY4SlU3V2lLVjZ3UTFS?=
 =?utf-8?B?dHhJN3c4ZCt6N1NSNmd6SjBUdzU1b2x6ak1xMmxLQjJyRzNMVGQydFB3NmJ0?=
 =?utf-8?B?MGF0RjBuUG42NXpncGJMbXhJeHpNbStDNGJETXhZZkVFc1c0dWcxc3NBRlZp?=
 =?utf-8?B?M2c5SlFFOHdnQTdHOEFEeGJmQVZxOFl0MmhXUTFuUlVremo3Q3p5NGVrSGkv?=
 =?utf-8?B?OGx3dEZkUFNCU21ZRVJHVlRWUWFrZCs3VENadW8rZUFXS0tBSUo5RWhFc3dx?=
 =?utf-8?B?eTNuZEF3a2pjdWpxR2pIQmhhdHU1NlRsUjVDN0R3WmIxUWtCdEtHUHJUSitU?=
 =?utf-8?B?NVhMdW9KZVR1RW5ZbGVvb3ZTQ3RpdENYYmtNbC9HUGdnV2hOT0d5NzcyclJK?=
 =?utf-8?B?WGsxU3NkWGdxQ0k0QjZjcWU1eHRMcFltMHVtWTg5eWs0d1VkZmVXT2VrR3Bm?=
 =?utf-8?B?YUxlYmNnU3V0SWNSZzdvMnhJeDA3aC8xaWlwb0hhU0J1NFBGUG1TZlVyWUlC?=
 =?utf-8?B?NXlSaXVYTm1xL1pQUEthVzJOS1JReDZ0MnV0VUIrN3UxcXZMcjNMU0x5aDlI?=
 =?utf-8?B?Mk1xczRrSjdxR2FtMG9LeGtoYXJCUzJyR05hdmJ6LzdKaE5QMVVWUU9WdXAr?=
 =?utf-8?B?WkFBdE5GalZTZDVKM1kwZzF3ZU14NFpSRjBlMHFSREppUitKdThVSVF2VGtM?=
 =?utf-8?B?bnduajZGa3g1alhLVU1PQ0lGaXR6aVdHdUJBVForYVpMY1JHSit4TllFZ1pT?=
 =?utf-8?B?VDdLZWRCZysxbEhHZHlxdXA2YVVHejgvajZIajBMM0pIU2tQcFBsMm8rcXRD?=
 =?utf-8?B?ai9JdFFiNFMzc1Y0eWl1Tzc2aU85K3ZmNExJZFJHL0xlKzJVazFBcU8wTjB2?=
 =?utf-8?B?c3U2eHRuNTZzTmE3SlJSNmEwRWxERlFFWEFYN21vOGhxZVYrVncyZFRZSEQx?=
 =?utf-8?B?V0laUVVNS2JKVVJkR05uMFZ3SU1MV2xHMTRZOUxTL0hHNTFBenRiSnVmWmhT?=
 =?utf-8?B?NDV4MEg1OVRBQ1NIM00yNnR6NTR0aEJ5WFNLb3NNSlBvSHBGaEo3ZEdmUXR1?=
 =?utf-8?B?dVR6TEdTaEs1R1ZhbXI5eUM0MEozdGpLWUNUeDNnOWRFY2hSRDNTRmQ5N0dE?=
 =?utf-8?B?SmZ2RUk0eXQ2Tnh2enFVVWc5eCtYQlBEcFVsSytQNlJVYmJUTWNFeFlaSW5U?=
 =?utf-8?B?MnhqdWdyS2NWVVdlS2lyelp0a2VsRW1JcW5Jd25VRk1tQ2VqbE5SM1ljdTZG?=
 =?utf-8?B?MkFiSWk4SHlUc0hVc1lId200ZXBTN281Q0ZHKzZPb05TOGd3SE4yRzg5RGdU?=
 =?utf-8?B?TXl4Mkt2Q1A2LzZ2RXM0RHlmWU5JRW5sZ2dmWUkyMkxrZHhtZjEwOTlpK2dH?=
 =?utf-8?B?TXBpeHIyWndhcXIrWFN0NXVBVStZRzhKVFNYVXpwb1QzRlQ4K2NsSXVpaXhE?=
 =?utf-8?Q?dQLt0PlwnU9Med78=3D?=
X-Exchange-RoutingPolicyChecked: ZgEw9wfzFBcUbQJKXLVBbyYIDMnjyNBlGaqL+fe4lputLJOhztHMMMhEIlSulEyCOsl9OaNdRQsBQv3LhrKmI4J22ZS+N5b84khWZAYMkpkG0/EfSFeHvZCz6PKPZwHa57FCSSEQnfz4HOzHSuM0ylYaFLZ8dwfAeda8j0+6GHKEan0LuKY9lbAXOTEZph7opKSoFMuIaTIVJNQikN2cqBcsrsmFVuXskcV2a7ZBWMUs9z7WT5emonJZ2q1Zs24Fum+/RWN9SKPOyE1UHlig438sIRTlG26CONcls7tdSOgXbFHMBo0Xo5hH3z/1iCnuf8vTCJM8ImiBPY0bl4306A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AmIadBCqhWRJihZTJytSnpDvpq1Ydgdi8xKOCVewR1hcy850HDhDMrcgaFKvIREJm3jhXjlF+dtDmNCkIMmER494kN+6QQdibevDM/0lt5HbKSLgoHzygL6LZqyFSaWpZnDwLKjkiPLOUjEfda0vYPafCSvV8oA5qykXKmVoWMxvNN25Sy+3eO28v+9bXoQ2n6P+CamyD0BFJTDXGpf29nPT1ARxRrUXwK+F9bLeK9E4VZbq4jdcKIBMgYqkyg76Iu8ks6GXqVMYyIGSGkrqjqQD1jnYAiv/2lttRS31SmEq64gLMnTULlTa5WAO1D5SS2LGHYo8e0PN8oYVKNpBwB9WZ8nJLr1+lyrzYXJa3yN1XBp2WWPRSqliWog5d0wkEkoULrweAkfn/3g9myxLErkiC/O+G8AG0paum0sXzZHlHe0A2mK80YSgJGe5RYwiHCloGTBqqFZq46enO5tZdFc2sojEyAMNeUE1DGJA2Q3R11sn/o//qVhuJ3VbRrx9VzSqt1nuB2rdVGgbuJ9pEvUgPQIgXotxwHlpHN/ED+62rDR+AXvZgxpbwiQCmEhcdeS7MHYeYVUPd66KScDurnM32fjkjvaLkHI+fdULbHc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da192af0-9b7a-46ae-2258-08df038a1f89
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 15:53:08.0471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eteGN+dqsPn5lDJ3RlWR1GfKcGuqvOXHvZsEgHC/el7DKDh9VP3BWMnErufIbqd1kjHHQf5PeU2fSOpPrXk3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608260132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEzMiBTYWx0ZWRfX982KFWchEVd1
 QdVlvAfAajimDoItsBsVigGulod/KY/nf8XTnziquEzjjGAPwPSi6r7bMkzAsxie6DfL9QiWe/Z
 Vsb9ReKSVCKY2u2HOSFZwbfMf83thrfa+V3m2gVTxWoO073U3TudI0VRkujcex7zWzQZ4gOPrge
 Z2CXw8LGiMBiWs23I+hh3Vy0mry4FCcYKWiXw/Wg5gaOWYtJR4kTgbFQNCg2T84Px/orsmYiUOU
 RG4hFYAQ4lgUbz3h/iY4CYYrb55ugsBXANMgenG3vtC5tiaaJKjOtMBg9mtIGiGa7jpQPSpVx6k
 VeVmyYAQ50lYfvDPFo7WpFD/1rLhYVrqkKU3vD7B7gU3TusjFJELI/XgAl6Sl/jKmQK5MwP66i3
 pum2ocJjgns16vm7rOzhsLXWLUD0NN7CudpPQirAZ8JqUf0isZJjYXAywra8CQeABmSglVfR/tl
 dk9R8/X7EeUm14sdlM8PgHa66MhVMmwW2s2kvgPc=
X-Proofpoint-ORIG-GUID: mg_XTCcmfTT-G7pHZie8u_HufaPVrwV5
X-Authority-Analysis: v=2.4 cv=Os9/DS/t c=1 sm=1 tr=0 ts=6a8f0beb b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=uherdBYGAAAA:8
 a=E2OFlpCjAAAA:8 a=vqL-DJG3AAAA:8 a=SqMvC5kiAAAA:8 a=J7Vs0gARAAAA:8
 a=iXcLlBOuAAAA:8 a=j9CL5N7RkkbU71RAcT8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=l0t8tTNIJzRGstKQVvrs:22 a=N5whb6oI2XAsh5LpMrx1:22 a=_o8VnCo6Hb5Oqlm6Mk7M:22
 a=GK7RtA2AnwkbbjW1WRsD:22 a=U82d2PgYpd_3u6iqMSvn:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEzMiBTYWx0ZWRfX4YgsYxj7b7pQ
 GsPe+mSN4P07W++R4pGolCXlGbXIDkK1CeO/FXfvDH8BygBJ0FvjND/zHEpT9Dw71644MFcrU+l
 DvTuigbirq7BD10gjAaJ5wVgtulUjtK1tTXY9vIGz3khahSTYOaI
X-Proofpoint-GUID: mg_XTCcmfTT-G7pHZie8u_HufaPVrwV5
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On Mon, Aug 24, 2026 7:42:20AM -0700, Daniel P. Berrangé wrote:
> On Sun, Aug 23, 2026 at 06:13:33PM -0700, Dongli Zhang wrote:
>> Add an optional force argument to the QMP device_del command and expose it
>> in HMP as "device_del -f".
>> 
>> When force is requested, qdev_unplug() bypasses the pending deletion guard
>> and asks the selected hotplug controller to complete removal through its
>> force_unplug callback. Controllers that do not implement the callback
>> reject the operation.
>> 
>> Forced removal bypasses guest cooperation.
> 
> This sentence is rather missing the punchline....
> 
>   Force removal bypasses guest cooperation and may result in guest
>   errors, I/O failures, or guest panics. The guest OS cannot be
>   trusted after force removal until a full power cycle has been
>   performed.
> 
> I'm rather on the fence as to whether it is a good idea to enable
> this feature or not. If it is used by a cloud admin without knowledge
> of the guest owner, its use is liable to lead to hard-to-debug/diagnose
> problems in the guest OS.
> 
> If a guest OS is not honouring an unplug request and the host owner needs
> to force reclaim a resource, power off is always there as the failsafe.

Developers with knowledge of PCI/PCIe/ACPI and system kernels (Linux, Windows,
and BSD) know that the guest VM needs to follow the appropriate protocol to
power off or eject the device from the VM side so that QEMU can safely remove
the device and send the QMP DEVICE_DELETED event to the cloud administrator.

Assume two scenarios:

1. Due to an issue with the guest VM or QEMU, the device is never detected or
used by the guest VM. Especially for ACPI-based hotplug, allowing a forced
detach enables the user or administrator to avoid having an un-detected device
stuck in the VM.

This is safe as device is never used by guest VM kernel.

2. The VM owner may expect QEMU to unplug the device even when the guest VM is
not cooperating. This provides an option with a clear warning: yes, we can
forcibly detach the PCI device, but doing so carries risks.

Thank you very much!

Dongli Zhang

> 
>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>> index 974cf9c583..cb5b5ad1db 100644
>> --- a/qapi/qdev.json
>> +++ b/qapi/qdev.json
>> @@ -90,6 +90,11 @@
>>  #
>>  # @id: the device's ID or QOM path
>>  #
>> +# @force: if true, remove the device without waiting for guest
>> +#     cooperation.  The guest may still be using the device.  This can
>> +#     cause guest-visible errors, I/O failures, or guest crashes.
> 
> I'd want to be warning in a stronger way.
> 
> 
>  This is a dangerous operation that can cause guest-visible errors,
>  I/O failures, or guest crashes. The guest OS state should not be
>  trusted after a forced device removal, until a full power cycle has
>  been performed.
> 
> 
>> +#     (since 11.2)
>> +#
>>  # Errors:
>>  #     - If @id is not a valid device, DeviceNotFound
>>  #
>> @@ -101,7 +106,9 @@
>>  #    will automatically complete removal for all devices.  If a
>>  #    guest-side error in the hot removal process is detected, the
>>  #    device will not be removed and a `DEVICE_UNPLUG_GUEST_ERROR`
>> -#    event is sent.  Some errors cannot be detected.
>> +#    event is sent.  Some errors cannot be detected.  If @force is
>> +#    true, guest cooperation is bypassed, but backend cleanup is still
>> +#    performed through the device's normal unrealize path.
>>  #
>>  # Since: 0.14
>>  #
>> @@ -117,7 +124,7 @@
>>  #          "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
>>  #     <- { "return": {} }
>>  ##
>> -{ 'command': 'device_del', 'data': {'id': 'str'} }
>> +{ 'command': 'device_del', 'data': {'id': 'str', '*force': 'bool'} }
>>  
>>  ##
>>  # @DEVICE_DELETED:
>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>> index fa3cae246b..ca10a25c46 100644
>> --- a/system/qdev-monitor.c
>> +++ b/system/qdev-monitor.c
>> @@ -956,11 +956,13 @@ void qdev_unplug(DeviceState *dev, bool force, Error **errp)
>>      error_propagate(errp, local_err);
>>  }
> 
> With regards,
> Daniel
> -- 
> |: https://urldefense.com/v3/__https://berrange.com__;!!ACWV5N9M2RV99hQ!
> Np_bt2bKAVenBs32tlW80kBTAEEBD9uY3zjXBII-WZ6Yj3TRV1O5I7WsA70hJm0q3YdPBwu-
> DL2qAJ3UvkOW$ <https://urldefense.com/v3/__https://berrange.com__;!!ACWV5N9M2RV99hQ!Np_bt2bKAVenBs32tlW80kBTAEEBD9uY3zjXBII-WZ6Yj3TRV1O5I7WsA70hJm0q3YdPBwu-DL2qAJ3UvkOW$>       ~~        https://urldefense.com/v3/__https://hachyderm.io/@berrange__;!!ACWV5N9M2RV99hQ!
> Np_bt2bKAVenBs32tlW80kBTAEEBD9uY3zjXBII-WZ6Yj3TRV1O5I7WsA70hJm0q3YdPBwu-
> DL2qADJDqpwa$ <https://urldefense.com/v3/__https://hachyderm.io/@berrange__;!!ACWV5N9M2RV99hQ!Np_bt2bKAVenBs32tlW80kBTAEEBD9uY3zjXBII-WZ6Yj3TRV1O5I7WsA70hJm0q3YdPBwu-DL2qADJDqpwa$> :|
> |: https://urldefense.com/v3/__https://libvirt.org__;!!ACWV5N9M2RV99hQ!
> Np_bt2bKAVenBs32tlW80kBTAEEBD9uY3zjXBII-WZ6Yj3TRV1O5I7WsA70hJm0q3YdPBwu-
> DL2qAPWCfpLe$ <https://urldefense.com/v3/__https://libvirt.org__;!!ACWV5N9M2RV99hQ!Np_bt2bKAVenBs32tlW80kBTAEEBD9uY3zjXBII-WZ6Yj3TRV1O5I7WsA70hJm0q3YdPBwu-DL2qAPWCfpLe$>          ~~          https://urldefense.com/v3/__https://entangle-photo.org__;!!ACWV5N9M2RV99hQ!
> Np_bt2bKAVenBs32tlW80kBTAEEBD9uY3zjXBII-WZ6Yj3TRV1O5I7WsA70hJm0q3YdPBwu-
> DL2qAN7fX7fq$ <https://urldefense.com/v3/__https://entangle-photo.org__;!!ACWV5N9M2RV99hQ!Np_bt2bKAVenBs32tlW80kBTAEEBD9uY3zjXBII-WZ6Yj3TRV1O5I7WsA70hJm0q3YdPBwu-DL2qAN7fX7fq$> :|
> |: https://urldefense.com/v3/__https://pixelfed.art/berrange__;!!ACWV5N9M2RV99hQ!
> Np_bt2bKAVenBs32tlW80kBTAEEBD9uY3zjXBII-WZ6Yj3TRV1O5I7WsA70hJm0q3YdPBwu-
> DL2qAH19vj8f$ <https://urldefense.com/v3/__https://pixelfed.art/berrange__;!!ACWV5N9M2RV99hQ!Np_bt2bKAVenBs32tlW80kBTAEEBD9uY3zjXBII-WZ6Yj3TRV1O5I7WsA70hJm0q3YdPBwu-DL2qAH19vj8f$>   ~~    https://urldefense.com/v3/__https://fstop138.berrange.com__;!!ACWV5N9M2RV99hQ!
> Np_bt2bKAVenBs32tlW80kBTAEEBD9uY3zjXBII-WZ6Yj3TRV1O5I7WsA70hJm0q3YdPBwu-
> DL2qAJz0R0XI$ <https://urldefense.com/v3/__https://fstop138.berrange.com__;!!ACWV5N9M2RV99hQ!Np_bt2bKAVenBs32tlW80kBTAEEBD9uY3zjXBII-WZ6Yj3TRV1O5I7WsA70hJm0q3YdPBwu-DL2qAJz0R0XI$> :|
> 


