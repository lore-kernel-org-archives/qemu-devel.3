Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4427EC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVtjM-0002zy-8p; Mon, 22 Jul 2024 10:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVtjJ-0002r2-Ph
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:09:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVtjG-0001Af-Gw
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:09:33 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MCVdDi016442;
 Mon, 22 Jul 2024 14:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=62S3YST8tG4sx0r21uUP1PbsCdlVJnuNTl8yaWIhi0c=; b=
 as++MAqwW7r/6zLSIEUzD85OHPYMxrD6SfBaeDr5GbHHSMRF+P6voN5BXe8cSHZW
 yCXvXjfi+MHedyIIqfs39JYbCvwsp7TH2aPu9zGgQFwcVKkTatDWhvOWS8g5b2qH
 1l8b1YzzMn8654xwsfL95a24KR6ojpAtNSYSSrUBnLovZ9YdzuPK41JA7vh2FsTL
 HYcoAvycy0D0QwyEn/jo/5iJA3AbGw79HWieo8GiEQ1TGlIt+Y962v82AP5Ym4Zc
 Nps21cX8XlEEjVJtnRSzaaOEGlxFymgW+T1gKyJwY8fvruEzGnHqUCKeVkWx52Xo
 4OVYtJlx7fM03Sf83Bn/cg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hg10sws4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 14:09:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46MCkb2I010996; Mon, 22 Jul 2024 14:09:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h29prgn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 14:09:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYAxAs4zARYhpWnyISTdB0VXiHp3WyRtE0lm9cGl16ce+y959GBvaM8tjHo2PU3N2AjJQg96tggCwSL8kTpMUqBlQ59MzMQABCVUVOQv90qT9SH8EWVXsSuCKyVfdE/mCot2v5aTWbm1cL5DQue4uS2ywAefrCxXaF1SLwpmOSwgYdfIsWQFv4Kr/DZ7UKu6E2BMFlOcsuFS7lY7QohGiLdKgyA7tzDilgbYQ/Y4TFxoSR6iUAVFdYtoPGpkiEl9bv3g5FDB3da23+ZfS1nYffAbSA6Sf0RMBFVnXGDCIRPM0nsUKEsXLo0WPsvjTpgC9nvCbQANAmvpd7QAovOUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62S3YST8tG4sx0r21uUP1PbsCdlVJnuNTl8yaWIhi0c=;
 b=UV3VnMJI7hhe/OkOG5APpnpiLMpFmHtbq8N/n/au9drVeZO+GRV7P+dDFuTclsB4BJYegHqDD2Wa324iGD28PzLngV0am9HuwgD0EglxOtsFr6FuuGTMCYCFFmIgAEsTefOS76If0barC4bRhVYz50RL+Z6UT+p1ePAEr+TdY9LZNapFgIByAhAXpfwSnxGONKesHXPwLoHVwWqirT96seItWDvMXKKb1Vp8hOUxJis+hyF4flZ6p6TuY4S8aUWYfvn9XD/Q9g8RqKyfPF3b/mXFBK9UpwvNGQxKQm5XiL+XISEpLE2JRBznT1Cc/QwW6Mw2B2zC4tLdrrFvYSTrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62S3YST8tG4sx0r21uUP1PbsCdlVJnuNTl8yaWIhi0c=;
 b=Zw0d0bQiQ6g0Fc6KKAB5t3fQLcqmEXCpi9YtHOqCRUJFPihSfEvIR/HzZAqQ0lPuiibMIk7iynE/rEp7bj5aDQmMnIHdJzqPeNf+6y6wICrj0qKWh5LikZZwWwzKJUGCuVdHb3y7kHfW4EERH1QKquEiPV0jSx2ZPh1Mbt+7D6o=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DM4PR10MB7508.namprd10.prod.outlook.com (2603:10b6:8:17d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Mon, 22 Jul
 2024 14:09:24 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 14:09:24 +0000
Message-ID: <0ba48105-c129-4221-bfe3-f2c714bc12b2@oracle.com>
Date: Mon, 22 Jul 2024 15:09:14 +0100
Subject: Re: [PATCH v5 09/13] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
From: Joao Martins <joao.m.martins@oracle.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-10-joao.m.martins@oracle.com>
 <SJ0PR11MB67446F1658661C5F1542D00C92A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <be585d48-00d3-4a43-b242-fa7dd188e392@oracle.com>
Content-Language: en-US
In-Reply-To: <be585d48-00d3-4a43-b242-fa7dd188e392@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::13) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DM4PR10MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad8e91a-9694-4376-4741-08dcaa57e399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGlMcW9LUzJlbnpRL0tMdDMwRjNRc25qb2dsMU5IZGEvaldMWmxvdVhFc1Rx?=
 =?utf-8?B?MVR4bXRyd24yczZ0RGNXUVJML0g2a214TkVXUjYwWHRTZWNzZG56OU80cEpn?=
 =?utf-8?B?N3RnUVl0WW1Bc2FiM0d4QjY5UTBhSGthak1ERktmcUpzSy9na2N3a2hJTVpm?=
 =?utf-8?B?OEZpTDNSV2dhZDR6Q0lCa2tWbmJxK3VwdFZCMFVBdlEzMS9TYmZ4TkNMbFRs?=
 =?utf-8?B?cmwwak1UTW1HdTZvdmZ6T1B5Y29jMVdrbmRIeEpjS2Zad2laNThMWHdaRmQw?=
 =?utf-8?B?bi9kR3JMRVlTeU1BUTZhSW1OSzcvQWc2NE1xSDU1ZVVHamhXNUNVWEZvMG5k?=
 =?utf-8?B?QmhESFZab1drRkZTT3ZlUzJMS3RSZXEycjdtK2ltc1VaOEVEMlRhWXN1bi9J?=
 =?utf-8?B?eHU4VzNGRGJJS3hWS01xR0Qyblh4MzZrS2U2SFl6VHNTVldRejI0NVk4ZGIy?=
 =?utf-8?B?THIzcHlxTlhwQUY5bmMvd3k4YUo3Q1dZajZkYXY0MEwrYTNNeHVXeDdOTTY2?=
 =?utf-8?B?aEZ5WHlNWEt0ZXFxTzBqTkhSeVd0VHhGZXpmUGFjNHVqM2h4Y3FQRktRbTJV?=
 =?utf-8?B?RkFIeWVNaXZSdUc3S1pKVzRYWnhiejJpSGt4Z2t3MDFrR2hhbXFQWkdQem02?=
 =?utf-8?B?ZzgwUTNMSy9iQms3bTFPWE5hbVRRRFdaL1hsY2t3dC9rMVM2QVdvUmJTbzVX?=
 =?utf-8?B?ZFhzOW1hWEM5QVBGb3BRYlJDS2VPeGFtR2MzNE14QUlkUDJoTjc2OXRyZ3pS?=
 =?utf-8?B?M2MwM0lmUGRkOGtRWkNzczdGZ1VZazg2QWV2SU1vRWhkcHU0OTVPMzBlY3FG?=
 =?utf-8?B?UzllSkZ0RjNnbVpDY2lCNHRPNHVvaTVjTVpzOFdOeithdm5EM2cxam14ZStF?=
 =?utf-8?B?ODJEZEpMTEdLZE1tQUFCT2d6M1c0Z3JLOHJ5Y0RGd0hnRGlxVHhUZ3M5bFhW?=
 =?utf-8?B?UnFaUUQyajljZlh0WExaNnZ0OXZoNDh2dU51YW5NTnp5V2xSZDJFUFlKUmV2?=
 =?utf-8?B?MThlS2Y3azkybE1aN2ZlVDVaZDlmRnhVejI2TFV4OGZCT0RTRkhTMGRSU1ZT?=
 =?utf-8?B?RlpxdlAySUVWL3ErMjRJbG5PNVpIYnhNSEdnV3JDNnhNa1UyYnFLak1FMHBI?=
 =?utf-8?B?WCtHRkxIOG9SRDh2S1g0Q0dkVHhsU3ZvRU5wSXZiTnNDN3YrMDZZd05weStH?=
 =?utf-8?B?bDIzQ09vdmdGMlB4MUZOWGgySHZiUnhLWUxTNWRPWVBBQ0RMdDV2N1JDWm5P?=
 =?utf-8?B?NkVqVlBvcHJGSUtIazNzaG9XLzhiSjBFdjFvQ0t6K3QxU2V2elByUDNHYmZi?=
 =?utf-8?B?NlRBQ1dPcGVLdTM0YmlQTEN2L0VoeVZGcnplbWZDa0htNDZ4RkpqVDF4QU9s?=
 =?utf-8?B?T3IwdUZ5VjVWSWJLV3hpUkRnZUt4SFdZa0xJRnA4d1ZpOFl4VzNiTDJVdXlK?=
 =?utf-8?B?eFd2aW9iZ2dQVnpGWklRZXZaNVNxbUtTMHRxWkNYaVN0bGxXTU0vS2NTSzlv?=
 =?utf-8?B?aEJXSmRpOGpJVktZbTgvcmtXOXlhS1BGbDJiVzl2RWUreERzdHBKSVNMS2p3?=
 =?utf-8?B?K09KUGFmaCtQemZGcVJZTjBIQW9TdDh2dzhPVm9iSFJBanZUeWNMTHVIVURz?=
 =?utf-8?B?a1YxaVZDNExDelBvOFBSS0pubHFFeGV5UjJVRk0wK0phUE5uWW9zZFNsTi90?=
 =?utf-8?B?WkFoR0FlMzgrd09pTDMrblBzYnhlNGt0bXlWZlpYWTI0WW1naUtnY0RQMnBz?=
 =?utf-8?B?MVF5NXVKQUxnVnF6T3dOWmFwOGtJVGdOdXJJSXpPZHhhV3ZSLy9uRHh6Q29h?=
 =?utf-8?B?K01ndzJMWW8zb1cyTi9NZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0tlWVhTVk1abmliMmZyVzFtb1EwTDFpemVadTcyT1UydnQ3REFaMjZ5MTd2?=
 =?utf-8?B?aHRlY1o5THg1SDBVaDdUbHl2UHBGbXlQbDIrdUxDRHNQYkYvZ3VrYU1ONlF2?=
 =?utf-8?B?TkZydTZFYTJPV3UrdzZoVTBkbXZDeGNZdTlhUStPdEcwY2VMY2ducTNiaHVj?=
 =?utf-8?B?Qm9qNjFMQXJRYmpzTEZDdERmNnNzempkNUpnUm56MUZTK2ZxbzAyT2trQlpX?=
 =?utf-8?B?VXEwVDdVOVRzUlRFZENFNE9BQnNCN3dDUUJnRE1paHdRU0dKcGFleGRRQmdN?=
 =?utf-8?B?dzN0cFNXRGVsTUVEakhhdGpYZEZGdUtQYUZnb2hFOE9CL2dpQU82c25Ib0tr?=
 =?utf-8?B?aHIrQ0I4ZldNRkdSNkswY2ovV2Vmc0FKTDNtdlV2U0xYbkhQUWZwLzlCYUZC?=
 =?utf-8?B?dFhYd3R3TEdWVXJrNW9YTFAvL0NqbGEyWjJyRWpkcURkWkNHa2pLQ0NJMUN1?=
 =?utf-8?B?ZGxmYU1lditEc2lSODZRanhod3NqU2h4TG1lVU5CWDNvMUhDUnpNSC94Uk5q?=
 =?utf-8?B?UjFLWHF4eE1lbzUwMFhKR1hYTUxZcjZhaWNDM1NxWUlRSkxmS25naENYSHlG?=
 =?utf-8?B?TW1JZ2FuSE1FcVFOdDJMb1lzTkhCYWEzQlhFUEtzdHc5bWJ3UEZIYzlySnNo?=
 =?utf-8?B?bGtxdVZ5Y0Y3RUtrNEo2bXpXMlZHaXpMSGZqSmJZWlpuSGZGRTFaS1ZBdGtM?=
 =?utf-8?B?VEUzTFVuU1dwTU1xZDcrYXZWejJXemVsRW9kQW9pYXg2eEk3aU91OG1PU2Vk?=
 =?utf-8?B?RzdCdEt1UTdUbE9YMTZBN3hZN0VBREJqNkkwc1owa2pBN1ZSNWRvc0JCZ3NP?=
 =?utf-8?B?d3BGQko0U0xvY3JGL25TLzdMcmxSNzRsUWdReEs0bFc0ZVc3My84YU1HM0Rx?=
 =?utf-8?B?MW9BVzlxeG9MTUROdndkbTdFZmhKTGRYM0gvNXJCL09RRUxwMWFTVGZKWmIv?=
 =?utf-8?B?S2ZlMEcxMzFKaXBzZlpFcnZCL0Y1K1d0cVl4NXhmaXZHdGF3YmVpK3pNemg3?=
 =?utf-8?B?aVVaYTl3Unk0V2R4S2pOWThybUpjUkxtczMwMEljTnFLb2NaUFhrWnMzay9w?=
 =?utf-8?B?V2dMZmpmOElTNTgzSkZwejF3Yko0WUxxOHZjeGM0eUJ0bXBHVzVoUWZqUEV1?=
 =?utf-8?B?NzFUMk10Z01nczI1ME5qbVZmNmwwVzdhY0lIVXJ0ODhZTjd0MVJGSFNHNFZK?=
 =?utf-8?B?VFdWaCtJUkhsazlTWEZwTGdSMGtjYi9QcTU5WVltOFpqbmtBSVZZREpqZUFD?=
 =?utf-8?B?a3paK3p5NjJzbnVkRWZJdjBzclJhK3d4NjAxMzBBQXhCSmpCbEN5T2o1aGsz?=
 =?utf-8?B?L2E2RW9LSEJRdm50d3BoUVVVQ3dKTmlpTkxBcDZ4TTNRaGdtNUdyZ2ZxbjBI?=
 =?utf-8?B?WCtiaE1Pcmw0V293UDYxcjRPN3htQVA5R0tpWGJuSTFMU0Y1QkpQaVJaNmpN?=
 =?utf-8?B?azUrQk9nYXphOEZnSFlRaURrM1RodmowRm5XOVREU2lvUUVPZGpFZnE3Tmp1?=
 =?utf-8?B?dVhqMERLbVdDRXNFbkNSQnNvZHBBWjZwd2xDQXhHRTNuODdlT2Q5SXkxSjQ5?=
 =?utf-8?B?QjVqUlpuV0JBU0w4RkJlOExkWEF0NldVWE5icEtJWVM5OHFGeHNOSW5zQ2hy?=
 =?utf-8?B?VGxhL25Ebk1hNmF5dkxpanFNY25xZVlBOCtIZXRaU09nUmY3Y2x3Y3NrMEpZ?=
 =?utf-8?B?bEdDNlZIRmQ0T3lxL05RNWRaZTArRFlsamZhRDdOQndsT1NsdkV1MEZ0cHUy?=
 =?utf-8?B?SnVhMnZqYnhwSzBHNWwrdXVBZ2YxZEV4YkNJN1o0K0NuWlVoK3Rud05hY042?=
 =?utf-8?B?WFcxOEhtOWVrcXNhclVqMDdsR0RCZGNnT0ZnRlJEdWZUdk9KSjI5RThPTnpP?=
 =?utf-8?B?dVNoZ1ZWZ2NsZzhPeVR3d2ZQbzRmNTFzeXRPTUNKc3Q2WVZhbi9wd3JVbHBq?=
 =?utf-8?B?QVR3bHg3NnNId0RWZk96Wk56S28zaEloeFVCRndVM0taZDQzZmxtVlNOaEs4?=
 =?utf-8?B?ZW1JNTRRZHZWZXVla0x6ajNZbWwxM25MTWJQNlB1Uk5FSEsvUitsWmpSWWdw?=
 =?utf-8?B?Vm9Iall1UTlCbzkrZXdwL2h3K1RDUjVXa0JaYzBJVmhtMytUQmdmOUF6RGpv?=
 =?utf-8?B?UU9DeHVCWGVMWlhuRldiNkh0TFMxVDZsMDhVZGkwRmk1QU5ZUUlDczc3YXho?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f7iUFTreepPzG05wznVzgCVwaOssKKjy1I1GimPnNs6Ozu3lSSotZIp4z12nN7++oqNuDN0lHc54xYVDuiSJn6TjC9+70v9MP2YdhNadEnNzgK0KJ5/mQLx+AkREED5zV6iXPjPRqtd2S+63uO8iJioCmXDU0HnKJQnPcAv2TgtQ5wvIEKmbpr71xXJByzcKYgIs1Sx3ZMEoRFPRYyY+5mAuNgaLAILN9Z394aD3muKW5Rza4hGskUnTJy3OCbkaTULZPVr0uSVgDEC55oeZep7goMozunr+wfDsbh2X2kVqd1BQDvMTCf3AucbGSfAnRB2a8OAuLrYi5it4FjHDafbwgk7H4YjyyX4GeKvWaQ1c/+cKNiwIwMSZeWfqvU2HqsZFqyeiKOx4s9WT44Efc4yOWGSLm18DB842iIkR5Ut/iUCMl+DqodonUvjY4ZVhIVwJ5bJ7EyjEpUG18agLgSC1Dd2ZZinfeKr0FZCiF8jNYtRnd4GcYicnZq0aVDCuo5nuOOX/yu/OY/Vtvo+mrdX9vNLLUnwFqSuskIVUcPyPpXqt8tqsd10uEhs0WjWdPnwtgoCxA42Qe+CavGZQLqTYB+iEHv+cDuODPb2lUHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad8e91a-9694-4376-4741-08dcaa57e399
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 14:09:23.9806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeNrh0AWO00pvJRhEU7HdcP7jKA3s5XFnZMRIjuPawcZy/72q8MryejWMN/yI/YUeYXHYdAE+l4CDNELMwqhM51vRymsKVhbkL9J80mpdlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220106
X-Proofpoint-ORIG-GUID: I7Zsi5uHlZ9E9U5RMIP7jV1G85s3mkpO
X-Proofpoint-GUID: I7Zsi5uHlZ9E9U5RMIP7jV1G85s3mkpO
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 22/07/2024 09:58, Joao Martins wrote:
> On 22/07/2024 07:05, Duan, Zhenzhong wrote:
>>
>>
>>> -----Original Message-----
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Subject: [PATCH v5 09/13] vfio/iommufd: Probe and request hwpt dirty
>>> tracking capability
>>>
>>> In preparation to using the dirty tracking UAPI, probe whether the IOMMU
>>> supports dirty tracking. This is done via the data stored in
>>> hiod::caps::hw_caps initialized from GET_HW_INFO.
>>>
>>> Qemu doesn't know if VF dirty tracking is supported when allocating
>>> hardware pagetable in iommufd_cdev_autodomains_get(). This is because
>>> VFIODevice migration state hasn't been initialized *yet* hence it can't pick
>>> between VF dirty tracking vs IOMMU dirty tracking. So, if IOMMU supports
>>> dirty tracking it always creates HWPTs with
>>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING
>>> even if later on VFIOMigration decides to use VF dirty tracking instead.
>>
>> I thought there is no overhead for HWPT with IOMMU_HWPT_ALLOC_DIRTY_TRACKING vs. HWPT without IOMMU_HWPT_ALLOC_DIRTY_TRACKING if we don't enable dirty tracking. Right?
>>
> 
> Correct.
> 
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>> include/hw/vfio/vfio-common.h |  1 +
>>> hw/vfio/iommufd.c             | 19 +++++++++++++++++++
>>> 2 files changed, 20 insertions(+)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>>> common.h
>>> index 4e44b26d3c45..7e530c7869dc 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>>>
>>> typedef struct VFIOIOASHwpt {
>>>     uint32_t hwpt_id;
>>> +    uint32_t hwpt_flags;
>>>     QLIST_HEAD(, VFIODevice) device_list;
>>>     QLIST_ENTRY(VFIOIOASHwpt) next;
>>> } VFIOIOASHwpt;
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index bb44d948c735..2e5c207bbca0 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -110,6 +110,11 @@ static void
>>> iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>>>     iommufd_backend_disconnect(vbasedev->iommufd);
>>> }
>>>
>>> +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>> +{
>>> +    return hwpt && hwpt->hwpt_flags &
>>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>> +}
>>> +
>>> static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>>> {
>>>     ERRP_GUARD();
>>> @@ -246,6 +251,17 @@ static bool
>>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>         }
>>>     }
>>>
>>> +    /*
>>> +     * This is quite early and VFIO Migration state isn't yet fully
>>> +     * initialized, thus rely only on IOMMU hardware capabilities as to
>>> +     * whether IOMMU dirty tracking is going to be requested. Later
>>> +     * vfio_migration_realize() may decide to use VF dirty tracking
>>> +     * instead.
>>> +     */
>>> +    if (vbasedev->hiod->caps.hw_caps &
>>> IOMMU_HW_CAP_DIRTY_TRACKING) {
>>
>> Looks there is still reference to hw_caps, then would suggest to bring back the NEW CAP.
>>
> Ah, but below helper is checking for GET_HW_INFO stuff, and not hwpt flags
> gioven that we haven't allocated a hwpt yet.
> 
> While I could place this check into a helper it would only have an user. I will
> need below helper iommufd_hwpt_dirty_tracking() in another patch, so this is a
> bit of a one off check only (unless we want a new helper for cosmetic purposes)
> 
>>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>> +    }
>>> +
>>>     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>>                                     container->ioas_id, flags,
>>>                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
>>> @@ -255,6 +271,7 @@ static bool
>>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>
>>>     hwpt = g_malloc0(sizeof(*hwpt));
>>>     hwpt->hwpt_id = hwpt_id;
>>> +    hwpt->hwpt_flags = flags;
>>>     QLIST_INIT(&hwpt->device_list);
>>>
>>>     ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>>> @@ -267,6 +284,8 @@ static bool
>>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>     vbasedev->hwpt = hwpt;
>>>     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>>     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>> +    container->bcontainer.dirty_pages_supported |=
>>> +                              iommufd_hwpt_dirty_tracking(hwpt);
>>
>> If there is at least one hwpt without dirty tracking, shouldn't we make bcontainer.dirty_pages_supported false?
>>

Missed this comment. We could set to false but the generic container abstraction
is utilizing this to let the ioctls() of the individual backend to go through to
the defined callback, and that's why I set to true.

At that is really the only effect of this patch. By the time we reach to patch
12 (which is what really enables live migration with IOMMU automatically), the
IOMMUFD dirty tracking is only called 1) when not one of the VF doesn't support
device dirty tracking [only if you're using IOMMUFD backend], and finally 2)
that no VF/mdev has added the migration blocker which essentially looks at the
HWPT flags (as opposed to the container attribute).

	Joao

