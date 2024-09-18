Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3E1CAC5B7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 03:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqlp7-0000lB-FN; Tue, 17 Sep 2024 23:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sqlp6-0000jg-7K; Tue, 17 Sep 2024 23:57:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sqlp4-0004Ws-5b; Tue, 17 Sep 2024 23:57:47 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HLg2Xr018058;
 Wed, 18 Sep 2024 03:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=2PsH6THcUn+6ekk1q/k/beSFtzGnDJio+FByjJNeHTQ=; b=
 XBemwO6O5Z5KZ2F3kgrME9H8IGL4BHDo6D5+f2P7eK+WE8s526plGxQjvaLY3sI0
 WrdRrAZqKzkYYc98R9+fDlaqJItmlYYKJ7eTI8xYvoPI89UWhmIgLPQOTWUSskKR
 btgPek1wdHgNKVsHlp24jhFOLNwJ/7vN5ZOiUoPGy5WcFE3BbeQw1be+z6WBQnTl
 NaB4jcY7tK2l6l+9LPXO+3vPat3+oJwAoW7nwiQ4RTYmDiub8LiGQYhr54oKK710
 AXp6tp2JUnxI9Bz18Esg863TVCkeQssnmUnS1RZdR5v8dz/VMMlhoxQZ+wVHMP65
 LYq2iyLfpEDKhRe1IIrWBA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3pdqmsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Sep 2024 03:57:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48I25E9S010473; Wed, 18 Sep 2024 03:57:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41nyb7pb31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Sep 2024 03:57:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDIwzIBjvDWsgx2rNYRv5lcv3O6uQGJkRjwwk+faGF3w67wroa/4zE0aE3YFUtmMkzUJ9d+fBZIgN49BvkDUzFzujD80PAe0+NsYcyAjgNLAa5OsJYmiQdBAUrY+3K2S09yBd7OCavgcvaR1wvdgXNoMZIzY+90+bwsGqD7wGRRhzWhyz33Ao7WRF/trtq4rD3HPNztu5E6tX/WmaEp0lEhGBSjpuSZVP74l+OCF9+YcMEewvWlgh1Im35SXD6OJHz3JPPVnp88y919IzBgVAhYswvaB//Vth7h5ChqiXiJdlW52rl2wqqXLDK3jB9W6M+H+k3G+RM2rpoaHb0evnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PsH6THcUn+6ekk1q/k/beSFtzGnDJio+FByjJNeHTQ=;
 b=CAUyeCkQlB5r6tHGvKx8bw3XPsB8s1pzAe3eRXKqhdX5SCVAbSJjaQD+Wg2AGoTGch5CJiMpvBQSSmZ7kBzuekH3Jud2bIF/ZNg+Dj3UysBEoFn1QV7ShgvNiBkL9MEOHVOWb0d1bvDchCYvagOs+8AfwERouiD4pbJKLNkabcPsF111JYwcnXxaAK9VMNjONZg76P3cCM+dw7AkYamvMLurKqHLs4n1xvP6C4TqsuXqLyj2DBrGT44hYPKdzhec3k6bgfquKkzxlFEqtDXllUc67fMNhHe+chnHJ1EhAFfExRwpEWvrTvuLMquB0D5SGdpBwiDbaUk/Mqa/F2CxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PsH6THcUn+6ekk1q/k/beSFtzGnDJio+FByjJNeHTQ=;
 b=T6C6zPe/oKCOL3De6JMck1jLfLbSvrv9AeSbfPoAwGSjcUoxYKTSP5K4/1xxikmfkMfqHvjpy/AOnj6RlpUA95QsJSa68Ia0NoDTLEIQpqOelVIINpPdobF8fe+bbj4hnxP+zAvvkWDUcbFJvR8DtnAlJgvEKxfsug7x+ci11uI=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 03:57:38 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%5]) with mapi id 15.20.7982.011; Wed, 18 Sep 2024
 03:57:38 +0000
Message-ID: <e3d8e5eb-39af-4cfd-85c6-96f49441f757@oracle.com>
Date: Tue, 17 Sep 2024 20:57:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net: move backend cleanup to NIC cleanup
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: dtatulea@nvidia.com, mcoqueli@redhat.com, mst@redhat.com,
 qemu-stable@nongnu.org, leiyang@redhat.com, Ani Sinha <anisinha@redhat.com>
References: <20240912165408.234447-1-eperezma@redhat.com>
 <20240912165408.234447-3-eperezma@redhat.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240912165408.234447-3-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DM6PR10MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ef658d-5548-4f6e-87ca-08dcd7960938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDBHajJQTXBNUDhnaGQ2L243bXpCd0JaelZvUXEvL1ZvVDEwL3JFMStwaiti?=
 =?utf-8?B?bTNjcmEwU3lvSXJ6b0owdHh0bW50NEFTV09INEQ0dkxtdUZjYloyVDBJSUtX?=
 =?utf-8?B?YXl3aTN2Y3JKUXVYOUU1NXFYdGZrMXFsZEdRNmJCWGswQTZpdmY1L093U001?=
 =?utf-8?B?NGRrOFNvUlMzdEJuYVhiM3A3MFQzNVJsREFBUjVCczJSRGtETU5PNEliTElt?=
 =?utf-8?B?MEVrcDA0U3M5dTJLVlB4TGUyYjNiMXp2TDcySEkrRUxldVJSTlA2YWlwaHRO?=
 =?utf-8?B?WDkvVnIxTlJyWEw1eE0zNkxBSXV1aksrK2dERUJkbWZqalVQZFN3YU8vT3Rq?=
 =?utf-8?B?ZmZYMnNVWUJ4QUhpS1kya2JUODRtZGg2MitGZnVXc2FHTnMvaHVXTzl1Z3Zv?=
 =?utf-8?B?VlgzT1FCaThBS3BTV2NOejJXSWRSejdiWmZYTEJCVEdOWHBrSnlkNk5hbW1P?=
 =?utf-8?B?dEYzbnlGR3o4QndpTXBBRzdQNGxKMHoxMzI3QjlXMGRsd2cra0FlOTJLWmFS?=
 =?utf-8?B?bUxLSlovOEpvMnJNdzdJem9yMkdid3dRYlJITHlMcE5XL2FMeVVFVTNqeTNi?=
 =?utf-8?B?U0JKMDdHUzVqN1FYNVdTemJqQmZHV3lUOG5KWFJ6TSt6RTdJaURGK0czbmpT?=
 =?utf-8?B?OWNoRmFhYWZOWHJkSkxoamJnTkV4WEE1RGNsZGVTc0I5dTIyRGhMVlZ5ZlJx?=
 =?utf-8?B?bVlNeEE1RUFNbDhqaU9rckxsMm8rTXV2OEhFcHlpV0ZaMHhIbUVIWHVoN3po?=
 =?utf-8?B?SW5DZGVTaXVHUHNtajgwdmZYKzhNQXpCVVBVUUZDNjhYUE5WTjFYRzQxNStm?=
 =?utf-8?B?NjhJSzUySk8wdE5VVGxhS2VEN042UlhDZTJSTjcrTVkzeFFlV3ZpMFQxNGVI?=
 =?utf-8?B?ZTg3a1ArMUJEVTVHN0lvZEtDTElqQ2s5TGlLTzJrQ0NUc05HRXZSZFdXeU13?=
 =?utf-8?B?S2VNK0d0NUxLK1BuSjlJVGU4Mmw3VlQ4VG5aeEpvU0RRVHRsOHJQeUFWc3J2?=
 =?utf-8?B?bm9GMW5ZbklmdEE5WVkrTEhLK21JWWxybXptUmZ6OHU1NzUyeHpvemVFWW9u?=
 =?utf-8?B?Wmo0RzY1V2VXcjI0aUk3ckJkTXF3RmpabDh6MkR0V0QvVERSK1VUVnI3R0N2?=
 =?utf-8?B?V3grT1RlZVlpUDU1M3hudGlFbDFDOVc2OElWTlo1eldBeG9Pc1hXUlNpMkRx?=
 =?utf-8?B?aFVmMHcwd01BNGtXdXEwZUFFQ0d6RitpaGRQaVoxN3h3NjdDTUI3VzEwWGZh?=
 =?utf-8?B?ZkhQS29CankwUk85KzExbWV1eWtkejAwMk4vY01UNDRzWS84UVhqaHBJS1FI?=
 =?utf-8?B?eDJJK0JWNEE3bk1xSjh4MTdONkd1bWZiMFRZV0hWSE5sejNoL0MwSFZBYXNz?=
 =?utf-8?B?Ym9xNUJkQWF6ZGtaenNSdE5OdkxlM2Yvb3Q2ZUxXWHJueTZ4TDByMldZQTZG?=
 =?utf-8?B?UFo4YjJ3VDUyRjNJZVc2SHZhQXBEcC9qSFZ4V2c0L3JydW5oVDk1SGlOMnpH?=
 =?utf-8?B?ajhvSTgzRUpaZUVPcFFVK3JRay9hMDZDZzljM2pmOExwYksxZnFwZXJERldG?=
 =?utf-8?B?MW1WMnFEREpHYWxGSlJSWVJQZThzdzVBY1RYUVhUc3B3TnF5V2o5VDZrY0RS?=
 =?utf-8?B?djBJNXJuYmFSOThsSGxWOEtnSU1HMkNOS2lKSWJoZCtTUEl0bDJjNG9aa3hD?=
 =?utf-8?B?RG50UHFvZW1GZnBwRzZZVnZBY3htaTdJY1F5dithR2ZYdXNIbjJ1OERoaFRp?=
 =?utf-8?B?YkcvWm9OL3dGcEQ1Uk5aQmd2UFFrdzVScW1iR2orWjMzTzVLR3hkS3gxc2tr?=
 =?utf-8?B?N29jbmkyRjlMRDRHQWRBQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUxaYlRrRWJINXBDTVQydlZ5akpxdEUyM05XcEc3SDZ6NStoMGlPRTNDY2pZ?=
 =?utf-8?B?QWpObFZkbzFlQWUrcit2OHQ5WjhqSktRMFVnUlc3QnAzUnBDeWZrZUJ2dDBT?=
 =?utf-8?B?dmJ0Q2hNT1p3RVplcjAzd05TbVpRTFYxY0REZ2xjZ1YxNUxCQ3M4WTQ0bVNo?=
 =?utf-8?B?Q3V6UnBjaEdwamJqdEdscGg4SmlFMjhZb0RGQ0o3WFErYVNqR2dEQzNCRm9U?=
 =?utf-8?B?dnRReWM0NklVVys0Q0I5NjMzR2w2cnUyckwwWlZZWlJnbXdKcEV5UlhLZi9Z?=
 =?utf-8?B?VkVtdEdlTXVuZXJOTUxjbTFMbWpZWlBNS2lIcEhXaXRYRGx1Z2E2b0xwNkRS?=
 =?utf-8?B?L3dHZ09ReGxVaXdnaDZPNFMrYm1mK2d6OUR6WUNiUzlQdjFpSy96ajY4eDZi?=
 =?utf-8?B?cFVaK2Q4aHI5QlZ3QVZueFE5L2xQS1FvK1FmZ01JQTc0czkvWEE0SVNWaXdq?=
 =?utf-8?B?K1pnMGkwZzlUMTFHNCsybGI3MG9aSGE5WGs3Vml3RXRSRUlNQ3hKTzBaancr?=
 =?utf-8?B?K1VwNGV1UmNlbWhBVldVQjRiTnBXYjBQRy9taU1lSHd5THhRMHBOK1NoTEx1?=
 =?utf-8?B?K1BST0Ztd1dMejFHcHhqNS9CNGozNGkwYUxDOWZoS1Zkbnh0THZNT3VteFBB?=
 =?utf-8?B?U0daOU9UbFlhVWdQd2xIckQ3Zyt3SVd6Snc0V1M2dDQ5dCt0Tk04aW9IZzZ5?=
 =?utf-8?B?MDMvSzhyT3VmNWh1MXZsK29neXpwUVJRVnpuVEZNRTc0YjI1RERJZE1OaXVT?=
 =?utf-8?B?QWgvbXpXSGQwblJ4VGk1MDNBSkFqcVFBa216V01mU3d1M0FPdyt6dE9rblNh?=
 =?utf-8?B?b1BmQ09ZOXFKcm5rNUFRdXhuUi90MTE3V3NkVGhmZ2RzdGZuaTc3YXJXQmlq?=
 =?utf-8?B?UmFDYVdaVGpiS3llUkhrZXNMVjBDdG00NjVkdjJ0ZGZjb2JScy95Sk4vV0lw?=
 =?utf-8?B?VGY4WEdPUllHSGdxWUlTVWdGSWtkR2MveGRqMUIzU1RkNUlHbm5YaFRoRGNh?=
 =?utf-8?B?RnVQN09JemwwNW54WlRSYXBOeHZPRHZsMTJqYzJwMUhIcG10VEdjcEVBNXh0?=
 =?utf-8?B?NHJhTDVBUmdwQmkrSUFoSzRzT1U3UG50MFRRZlg4MlF2UU5MWEVwTnlGdWow?=
 =?utf-8?B?MGtST3VrV3pqbHFKYyt4a2Y4MStRUExHRTJyVTVrRkh0ekVpaktpUGl3L1lN?=
 =?utf-8?B?WUdPZlRuOVFid1J5b0RYbGs0MzltOTViQ2diM0FSRTNNeG5PSTRCZUZtM2d6?=
 =?utf-8?B?WmFKa2FSK2ZkRWhtTDNuQk5ubURwaThhRW10cCtaUHkwbGNvQ2hzeE5WTTgw?=
 =?utf-8?B?NFZmMm5YUE5uTG4rWXZNcXRFWWtIU2xmdGl5OEZIS1A3di9VRWZSYVpKRGJE?=
 =?utf-8?B?ME91V08zbFp5NDRjOEp0UjZYeDZmanVGN1NMMkREWmh4SXBUTlhCL3ZCY1Bj?=
 =?utf-8?B?RlhJVGhscnBwbnZMRDFRTGRaZkd4NTM0SWE0Z21MejlMU3YwWElYU3Z1b1hJ?=
 =?utf-8?B?ZWgwNFVVMmpJanBhZmhzZWxlbDNXamxsM0tzVlBNSFhXenhPaVcrMk1xR1Y0?=
 =?utf-8?B?ZHRrQjBXK2FYdXBsNHZLT1F0enVVa0JtaUw3MHp2aWN1YWFiTUwrdHRBcmpN?=
 =?utf-8?B?SUc4ZVZwemFoT3VUM1Zzb2lscmY0ais4WEN0ejNTbzlzaEJWYXUvQjI4bERH?=
 =?utf-8?B?K1hjd29xT0p4ZXpmOVhRRkZCSUZCejhCcEFRQnVBMlQrYnc2cUZYM3A4bjN3?=
 =?utf-8?B?ZlpZdndvM0FHQi9KQmZIMHlGUWlkZWlieTVPUmF4VUxzU3FmdjlGeVNhSWZF?=
 =?utf-8?B?QWlHTkxybEMrcVp4TGEzSktxcnp4WXMxdmVxSUlDTVFPSnN1cnFMeldtczZn?=
 =?utf-8?B?QXNaQisxVmM4N2Q3TkVOaUY0U1RkcDNTUkEyYlN2b25jQmR2K0VUN0NxNmV4?=
 =?utf-8?B?Qm1OVXRGMk4xVGxNclFTTXZaVVB3SVl0K2Q4bEdxaU1UdUZQb3l1czNPK2ZE?=
 =?utf-8?B?TUpEV3RKTUluUFpWK25Ec1VGOVdpSDVjelAzNGpnTUhWVSt3STBvQVc3Q2V6?=
 =?utf-8?B?MFBrMEtMN3VJMWVZWVY0Ynh3eXVVV0c5cWVXdFVUM2dCZXNPcGNMRjNTaFAx?=
 =?utf-8?Q?0aSUDIm8w8nRHjoRuonEcX7/j?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f1srmKAuZ/RYhthPCprdgDIQlHNpXPdgUT5A7Vk4kIwTrvQatob5PcSaJeZcCAZignsrU3AFxoQHC0QNn+y+0fJSXlIYS0aqQR9VXxZnpxHtjAbsHcemHJ9N5BNr3cTiSLq/xOPuw3pbMkkt+uP18mEkShg2VHexZ81Aeu4H0+X+feylXcFM+Am8rEPgk4hOJ/a/QNbg/FTXxfrAHNNDpxI1HJoKtcfzwMwZVz1uiRy65NStUimo3V6s7SSqm7weNO622koyEHbLIbl7xhiB4qckitMwmqFOzCaoF4i7qrf6oT7CKWzArw3oHAgCNAZDZPgT9pfPOgUbH4g0fwNUUKeUq9OKl++D1mtmXAY4+6zPtSWN6bJGBoVtkc5pGtkbQ+0OaVrI6J2moPE09RvQl/y2Fkdig0d/UglvMaEFfQwCxJ8PBGZHk9DOyGckGat1HtfcSnlfTiv9CpB5tYggg9z8SHv0gB/wTdeko3avRXIZABiT7TJgJ61fvs4punOwpfAFIWePOJ7kXnTp1Bw8Sor9sRAwrjhndBP8ZS7gOyJ3FZX8ISs/G0cgW878MLj8FqqmDcJzeSExtlzghlbXjKcbBqGmR5LuknbhoJg7fGo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ef658d-5548-4f6e-87ca-08dcd7960938
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 03:57:38.1666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76ZzxFMVzjTsjy7dPSfDjGxsqXirVsSHG9wso2W5xg/V4Ez/vDpkALxFozEiB82tp88V7jSETI2vhRQjkysTfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409180021
X-Proofpoint-GUID: X3p5wteGHfFxJnAjTvKUYqD9k3LpNg17
X-Proofpoint-ORIG-GUID: X3p5wteGHfFxJnAjTvKUYqD9k3LpNg17
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 9/12/2024 9:54 AM, Eugenio Pérez wrote:
> Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
> structures if peer nic is present") effectively delayed the backend
> cleanup, allowing the frontend or the guest to access it resources as
> long as the frontend is still visible to the guest.
>
> However it does not clean up the resources until the qemu process is
> over.  This causes an effective leak if the device is deleted with
> device_del, as there is no way to close the vdpa device.  This makes
> impossible to re-add that device to this or other QEMU instances until
> the first instance of QEMU is finished.
>
> Move the cleanup from qemu_cleanup to the NIC deletion and to
> net_cleanup.
>
> Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is present")
> Reported-by: Lei Yang <leiyang@redhat.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
> v2: Remove NIC peer also at net_cleanup. vhost-user trust all the
> backends are clean before qemu removes char devices.
>
> This is not a requisite introduced by this commit as
> system/runstate.c:qemu_cleanup shows.
> ---
>   net/net.c        | 33 +++++++++++++++++++++++++++------
>   net/vhost-vdpa.c |  8 --------
>   2 files changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/net/net.c b/net/net.c
> index 9f96509b2a..d097ac3e74 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -428,7 +428,13 @@ void qemu_del_net_client(NetClientState *nc)
>           object_unparent(OBJECT(nf));
>       }
>
> -    /* If there is a peer NIC, delete and cleanup client, but do not free. */
> +    /*
> +     * If there is a peer NIC, transfer ownership to it.  Delete the client
> +     * from net_client list but do not cleanup nor free.  This way NIC can
> +     * still access to members of the backend.
> +     *
> +     * The cleanup and free will be done when the NIC is free.
> +     */
>       if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_NIC) {
>           NICState *nic = qemu_get_nic(nc->peer);
>           if (nic->peer_deleted) {
> @@ -438,16 +444,13 @@ void qemu_del_net_client(NetClientState *nc)
>
>           for (i = 0; i < queues; i++) {
>               ncs[i]->peer->link_down = true;
> +            QTAILQ_REMOVE(&net_clients, ncs[i], next);
>           }
>
>           if (nc->peer->info->link_status_changed) {
>               nc->peer->info->link_status_changed(nc->peer);
>           }
>
> -        for (i = 0; i < queues; i++) {
> -            qemu_cleanup_net_client(ncs[i], true);
> -        }
> -
>           return;
>       }
>
> @@ -465,8 +468,12 @@ void qemu_del_nic(NICState *nic)
>
>       for (i = 0; i < queues; i++) {
>           NetClientState *nc = qemu_get_subqueue(nic, i);
> -        /* If this is a peer NIC and peer has already been deleted, free it now. */
> +        /*
> +         * If this is a peer NIC and peer has already been deleted, clean it up
> +         * and free it now.
> +         */
>           if (nic->peer_deleted) {
> +            qemu_cleanup_net_client(nc->peer, false);
>               qemu_free_net_client(nc->peer);
>           } else if (nc->peer) {
>               /* if there are RX packets pending, complete them */
> @@ -1686,6 +1693,9 @@ void net_cleanup(void)
>        * of the latest NET_CLIENT_DRIVER_NIC, and operate on *p as we walk
>        * the list.
>        *
> +     * However, the NIC may have peers that trust to be clean beyond this
> +     * point.  For example, if they have been removed with device_del.
> +     *
>        * The 'nc' variable isn't part of the list traversal; it's purely
>        * for convenience as too much '(*p)->' has a tendency to make the
>        * readers' eyes bleed.
> @@ -1693,6 +1703,17 @@ void net_cleanup(void)
>       while (*p) {
>           nc = *p;
>           if (nc->info->type == NET_CLIENT_DRIVER_NIC) {
> +            NICState *nic = qemu_get_nic(nc);
> +
> +            if (nic->peer_deleted) {
> +                int queues = MAX(nic->conf->peers.queues, 1);
> +
> +                for (int i = 0; i < queues; i++) {
> +                    NetClientState *nc = qemu_get_subqueue(nic, i);
> +                    qemu_cleanup_net_client(nc->peer, false);
> +                }
> +            }
> +
>               /* Skip NET_CLIENT_DRIVER_NIC entries */
>               p = &QTAILQ_NEXT(nc, next);
>           } else {
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 46b02c50be..e1a1c91e48 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -224,14 +224,6 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
>   {
>       VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
>
> -    /*
> -     * If a peer NIC is attached, do not cleanup anything.
> -     * Cleanup will happen as a part of qemu_cleanup() -> net_cleanup()
> -     * when the guest is shutting down.
> -     */
> -    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_NIC) {
> -        return;
> -    }
>       munmap(s->cvq_cmd_out_buffer, vhost_vdpa_net_cvq_cmd_page_len());
>       munmap(s->status, vhost_vdpa_net_cvq_cmd_page_len());
>       if (s->vhost_net) {
> --
> 2.46.0
>


