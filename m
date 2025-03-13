Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4EDC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 14:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsjTL-0003bX-BO; Thu, 13 Mar 2025 10:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1tsjTI-0003bD-KW
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 10:23:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1tsjTG-0000Os-5z
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 10:23:40 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DDnhlJ008086;
 Thu, 13 Mar 2025 14:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Ub2tvuLH30ahfKhUZ/sIylYpJ++ArAgjcAGfzqqIQiM=; b=
 XM/Ttg+bUeY67tFHN/t5GhszjbpxcoFyZ/guq/E04ou3Y+H2n+utn6frQDmN4jlO
 0do5huOfv5cVkCxQjbnBWR2mSiw/u70orb9l4AMXlNe1ssagPTjNYXoH/RUCq+EU
 NYph7EUUSyxiWD863L4dQL4c9mkvt6IVXHSrRQT9SI6eNK7S0MgkHqjKhIy6LlGL
 7hs9DfoqnQQuUxxtkCu5rjvRUaTlDy1Nr+7uzD+ZC73kHuMD1g8b5iIsWuV+wWSZ
 zWXSxStI9JqSGzlUGzULjPrsw0rcCTXNf3GWjsQhNJwvlVOiEwgfHIn480PR6uha
 ecepwda0dBNgdyP1F7aJlA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4cv8fb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 14:23:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52DDElKC004035; Thu, 13 Mar 2025 14:23:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45atn26r56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 14:23:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKRmr1eu5DHdjc4d8ECy7kokVy/F67d/ymfNoAGbDfarvmN92HR41PkSmRjXundJLKOlPbiDjC8C5lyT49mpXpdoM40hslpWN8GawKiP6nG1etBORvXKhyoJPeU7p8owpWMNIvStmbmj370l3lTnp9PhVzRM6aQ2UCAQ9JULjZnHh8wt+HWxkrAmIEnvBLTQQUfw6RgLRk7m6RXxa15xftvU/5IDHzO76ifI/rlnr0FI/KbTZtQIaKI4r/TZwoaTdDJlQNQAbJTUXBKZWulWcu+87yJkUgrCIkixx0iHTz5X75/6pxAqywBKdC2ejh4nOHdRJVzhjsPRklIsNcb/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ub2tvuLH30ahfKhUZ/sIylYpJ++ArAgjcAGfzqqIQiM=;
 b=vikvsxiCFTlk+BNZykaXK5sbLmNW2/ZQUUAJ+6QqAKu4gVZzp6p0lu5oBEODw20nYcZ/j1m8xUjynab6eepQxOk5miyLkorP9WEqwJ/WwGHfMAEpgNkIyRyAs0Jlq6ZXOQeRjL3W5ScD054aWQ9otXVzg58dLBfo4VkZ/Efwr7poTTWZ4uzyYGTjYmmoSCtawOClVZonfLbAWs8WSoDoyTynLN5T2tm07Kko+xPkhawOyh3twBLS8BS3uHm+gYwSvxLG+41OBak6YAqsu4sIhWty3GU+8FekN8bBlaeK2fVtRz80scfO+uQa7U2QshXT9hXyH8UOJcFsr42V915Jjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub2tvuLH30ahfKhUZ/sIylYpJ++ArAgjcAGfzqqIQiM=;
 b=Ms8TtLpsrDYMHnSP+plajFBdbgJ6XIvn11hfzVI8k2ioAHslYPGkFDI3rc+9amepcnabClP0OFTixsA5RIxjfWXkYvkf1UmQ9xFLXLzlsBeEhhlSaqn4vhlKbdPlP1/mMEnSYkxs/30m5hTIds4IDAgub3/BxwbgPtjHowHKkUU=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 IA1PR10MB7515.namprd10.prod.outlook.com (2603:10b6:208:450::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 14:23:22 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 14:23:21 +0000
Message-ID: <0e4993c5-33d8-4dfc-8089-0efa50881f8e@oracle.com>
Date: Thu, 13 Mar 2025 10:23:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] amd_iommu: Update bitmasks representing DTE reserved
 fields
To: "Arun Kodilkar, Sairaj" <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 Wei.Huang2@amd.com, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-4-alejandro.j.jimenez@oracle.com>
 <0be5765e-2ade-4743-a089-0846f60943dd@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <0be5765e-2ade-4743-a089-0846f60943dd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::28) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|IA1PR10MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 9621c66b-73ab-48b3-a5a8-08dd623a9bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RW1jc21wQkJtd3phQmJFTHNjUFF1SzhqaTFrSlZ0cXA5QmlBMllBcEFmajZz?=
 =?utf-8?B?WHgvSlhBN0JEWitxenhOU3hGdGtCZ09oZzE0NWc3UVc4dmNjN2s2aXR5OE5M?=
 =?utf-8?B?QjBpdk8yTDBmdjgveUxva1NvMFpWS0xtUnlZYm52VkZZcGgzRk5ROGV3eXly?=
 =?utf-8?B?bWJ3SUZlcUp2TDE2N3dTa0xYazQ5WVBmQ2pFM3EveDBvdkFnS2gvY1dnUUMx?=
 =?utf-8?B?SXp0dW5NQjBLdWFubVkzVnV0WlBjQXNLWEZMQjNydmg2YVVHSmRIME51RVpJ?=
 =?utf-8?B?UU9XMFZWMS9lb0lBRmthanNaUUlTZVEvY2NTVGMzSjlpc1hZQlBuZDBlQ1hV?=
 =?utf-8?B?Y1VxMWEzOENJRjJlSTlaeXFvdTJNTFl6ci9RV2lDL3VGU3AxZjFGR3dSSXZZ?=
 =?utf-8?B?ZmgwZGhtcFduaWNCb2huQVYyUEF3a0ZyQXlKR3ZiZGpMZWI2N01aUmhpd3F1?=
 =?utf-8?B?akFNL1g3dFJqOE02aklwc3N2Y0k1My9zR3pIeDZmY3ZHRnBYZHVJWDM3b1Bp?=
 =?utf-8?B?SWx2bmk2bzZ6T1ZXS25YTE5mOGoxTG9CUHQzVEk2MzdCWU5uR0xBSjR4ZzhQ?=
 =?utf-8?B?Sm90YnJYRE1sZVM1WS81RGtBbFJkYit1VnVFMXBSTlhoTzN1OWc5NW9sTzEz?=
 =?utf-8?B?cGY1NThkZDQ0aW9ZWUoyMzhjTk9mVFVQNTRsL2F5QUdWU3owMnBpWngyQUIw?=
 =?utf-8?B?aGpsaURtbW5YSGpzcGcwM3EydHo0SWhDR3E2TlJwcnBxUXFLTHJCeGNrbk9k?=
 =?utf-8?B?UUM0N1NyL1R5MnNmOXVjeVdWa1F2Um5CTXpZZlhwM21aZm8xam5sRGNSdSsr?=
 =?utf-8?B?eUw2ZklVNzBoK3gvMmxabzUwZm1vaUNFN2o5ZFJHV0NEK01rOUZ0ZDdoOXRh?=
 =?utf-8?B?TDZoODd4dVFDSDhtN1dSVzJ0Zi9aVk03cGdUOUFiMm5nY0c2UDYxWkkzeXBs?=
 =?utf-8?B?L1M0TE8xSjd3dUpUc2NRaXo3R0RmeEpJNUZPUHpPc24yNytudU9iYWpRaEZM?=
 =?utf-8?B?OFFGYkhSb2pnb0Zmbng2bXd6TklWTHBqdDBRV29ITTdTWEkvalBObkZyUVM1?=
 =?utf-8?B?ZUxwT1o1RFpaV0F5cVAzNG9qMi9HdGJQa0hVN3R2b1BPNHI2NExLNDg5b2hj?=
 =?utf-8?B?aUozUjZhUS9TL05XdXQrZHdWRjRydEx1ZXNUcDY5OGJLVm0xVUhkRXBQakVI?=
 =?utf-8?B?cGRqWDFnUDJqOEREd3RLazd0RkhCblFvcjlJR1lkU3RNYXltYWd3cGI3cU9T?=
 =?utf-8?B?VGxnWEZsdHZBcUE1WExQS2ovZGxWcTZJUGg5MHlGZ2RzL05sbFRiVXh6ZjMw?=
 =?utf-8?B?K3A3OW1vcnlmekd5eHJGL1Y2NkxPckQ1cTZRYWREOTZuTGdqOFIxVTZORnFF?=
 =?utf-8?B?YTI0NVZWM0M4Q1FyQmx5LzQwQjhXRUE4OEYxTllqRUhoWU8wbjdaTWF1bitY?=
 =?utf-8?B?a2RvalFKYVppRzUyaGNUZjcyU0h1ZXNVbFhCbXgzL2pHTjFENjUxbnR4SDlR?=
 =?utf-8?B?YWFEbFgyQ05pS0xYM1BFd1dSanFjYnhtVHIzaXJ2eWpMVkZxODBUbEJON0NU?=
 =?utf-8?B?dTY0YktZSzZDWUxoblp1ODhmYVBZQTcwbEdtb2NuM0tWdVM2VlZDak5qb3ll?=
 =?utf-8?B?L1VWNkpWRjdkbVFLQ213U1ZGZ1B0ZDVYSS9aMG8xaC9TWU1ZSk5udzZGcDNz?=
 =?utf-8?B?TDNTR2Fka3EvMjlOSjAxNk5jaVBrMElZY1NDcVIrdm9nQ2xkeCs2RVB5VUZX?=
 =?utf-8?B?OUhmSXpZS1drWXpzSWszcS9lZmU0SDVpYXoyTW9YZjlvaGxsWXlGT1p5S2VP?=
 =?utf-8?B?ZnV0ZTlrNTdkRlJyMFhuU0VHa1lORE43cnRlSVBXeGFLZzlyS2NDRG1HNDlV?=
 =?utf-8?Q?/4dPkn1hOfOgB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjdBYmRxRU9NeERZaWdTaDR5UE9TSFhMZTFJWjB2MU9xMlE0ZVRRQ1lkTW1u?=
 =?utf-8?B?Y2NMeHFjQjJVa2NDaGJBU3hpd3dQSXRVTXdlbGk1ZzhJRUZac2RjMlFqd0hC?=
 =?utf-8?B?S2loeU5zUkdSd0ZQSi9xSE90dE5UeXplb2VRNDAyMXVHeWNxaC8zUDdtKzhK?=
 =?utf-8?B?Y0I2S3ZVcmFGa1FHUEFobGRXMXM2WlNnNFdKRkpYcm1TdytUZ0QydUV2ZkJv?=
 =?utf-8?B?QStLM2U1NkhvUnphWVRjUTY1RUpaZU42UDdSaUJ5ZTV4TlR1SWUzL2FzYjRH?=
 =?utf-8?B?czBTOFBRQkE2ZEJKSGRwRnZNSGlaMXhhNkNVLzNKenc4Ri9MaWZOTGF5V2pv?=
 =?utf-8?B?dkxXRUZvUmZkN2JZZXQ3TXZEQ3VCbmIyWjR3amxoQjU1UlQ5L1o5WkF6TzhW?=
 =?utf-8?B?Y0lISWtBWElNdFc1TVZkdVdESE5RcDArY2ZxQktMYW14WC9Fd2ZwT2hTY2VR?=
 =?utf-8?B?WnhhVVl4MnA5SUtPQ1FGdU5IbUwrdkNGMnI0ZjIrNEQ0V0F6bDJpWWVsVkpt?=
 =?utf-8?B?VnBYOS9OdUM3YXdXTUdxdmFNcVpNYlM1RlQ3UlkwcTRjTTlqaGRYc08yM2NX?=
 =?utf-8?B?TnpPWVYwWmpXYjQvSDNUbWFvQS9xbjI4cGw3U2NsQnZ0Nzc0d2x3eldtczdH?=
 =?utf-8?B?L0hmUVNLdnpoTGdRdzR0di94eTlJREdrSkExSVlYUFNWUlJ2MHJFL0FwRjBL?=
 =?utf-8?B?cmJCSFo5eGZ3RHduZXIzOU04eXVSU3FwemxvS3pDa25tQW1Gc0pYUWh3QmM0?=
 =?utf-8?B?R3BkQTcxTm9rT3JLdFFxNkk3VUVJeFFHMFRTa2E1ZjM0TE9POGhVaVBkeEdX?=
 =?utf-8?B?ajZUWXVlOVZMSFpKSWQyTkcyMmZiOERHbGdkdFhncHpGem14a3YvTktzWWlH?=
 =?utf-8?B?dVgxakhlRVR3MnNsSzRTc2p2eitVSjVPVnNycHJNelQ1bTMzSmRGK2xXOTg5?=
 =?utf-8?B?SUdZMldVRUx5OVRydHVaOHJQZFhiT1pMam0yMUJzTi9vUnIvTmlUWjFmeXBB?=
 =?utf-8?B?UWVzSXhqYzFKVk12aGRDNnp3YnRoc05GK3FFMTBiUXdkT2ZheDV0a2QrRUZv?=
 =?utf-8?B?dUlIdGZrZ2lRRytlWkEvTHNZMk45UjJRVHlxU3pWTm5rNmVWOUhkNDl3WFEv?=
 =?utf-8?B?VllYcnIzUDdpT2pwc1BEQ3VGY2xqeUZlT0dxeStOL1c1ZG5vZmN6NmNDK0VU?=
 =?utf-8?B?ais5THlvKzRQbHo2U0lYR3hUOGIzTENqakg0blRPdkhIQzRPRzdCSlplSXhQ?=
 =?utf-8?B?YlFqa1Z3dXdJUldIOWJKaSs0cU5iRDRpZ0R3bU9Gejl3ZENKL25qMllmcUZa?=
 =?utf-8?B?QnRhNzhQL0NTTXczU09GK2RpaTdvNjJmckU2TTgyNnpkY1gyQSsxdmVETHU5?=
 =?utf-8?B?TWhTaW1yV0Q5U3ZvR2NhRVE0VjF5VG9HL1lsaFY0Ri9EWFg0VlJOUkhjcWdR?=
 =?utf-8?B?aURQN3NhUllBb25pakxjMFpzbGFqY1EwMzl5LzFSbnZqclpKVXY2Zk55N3VH?=
 =?utf-8?B?RUxNMmFkVERiaVJqTVVrMG9Zc3NQUVdSeW9Va0ZnRjVUYUR4VG45Q29xRk5C?=
 =?utf-8?B?alhPZ2pTaW1rWER2am1MQThPYUt5SFR1eHBENy9WK05LT29qdTNaR09oa1pt?=
 =?utf-8?B?R3RqWFliTDcwb1ZJUkJWajVtZG1JSVRZSTBtYmc2U3BhYUZJZEdza2lSa3JR?=
 =?utf-8?B?MlFtLzcrOEN0dS9FS0dKcW1nOWlGbVYwOVFiK2luMlpaYVEzY01HT01GZVlt?=
 =?utf-8?B?Y2x2azdzR1VHQS9DY1VkdUtKeVVLWERmdkJ0czAvSXk5bW5xQ0wvdEVuUm9a?=
 =?utf-8?B?MHV3RHczQUJuSEM4dWswSnBQTGVRUURUQWx3VHpuQ3JUakQ5UGg5a1kvdWti?=
 =?utf-8?B?bUp5OENKc0VHSmxBRldwM3ZHM0t4SWVNaW9kWHBMWE1LTUgvNVFlQUZwMFN5?=
 =?utf-8?B?VE8wekpJU3Q0MVVNNm1qUk9jVlowMnpFN1ZaZDlVVU1tUG53WUk2SzdoRGZQ?=
 =?utf-8?B?bnNIZkJZYjRCSmJId0FnVEtSMjFsRXBSb0dvZ3B4RWlOS0NKVTk0TU1SNnRn?=
 =?utf-8?B?SkpxNVd4Y2ZROW55bXFCSXpDcG4zZHdNaW9VSHVlbzRoRzN3QkFKVjM0RTQw?=
 =?utf-8?B?WDRKcHdjNHh5M1NUTHJ5aE4vaktmVG5RU3MwanVaUWlhQnZ1Nnp5NFFPemZx?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ONOF1QTbySp3OiPHeeduqNWgkzS/qrRiSG8DrHViETOVqbc8N11vEYgex32S9sscSW+XqXN/+eANsxpeT2AgtZqpnQhf6L0YN3YTsj24tyAtN6zCZNz2YJIYLDdR5R3EA4CVIdpHJ5XbmL6otGZwzM1/ZbaDMQcVDHpwWLk3IZ61gwMcWZ24EUowUlcXYBeIhpxTkHNNQqKHijfQAZnuXg7bNLmwD/kjRBkjjx4/+u/0R1Zp3ddSO4U5JMT3w4qTGyeuKBQnV03bNTnnLfNTNf8RfhoL9RbT9PoPhX+dCMLeBxqkAMm58w2aw6I8P/amgD1hBxBChGWIuLsjAVtdfmppSYHcHxvDrdQYF8my87SzbosbsqRn3E5E2+F7E3ZK4woJ9eg/iJs4SoHJfRtyixURBtaZIu8DBZ7GWe/JfArudBqfSmcokP66RSgrG4wZi3t6LP0TDzHqbaxmbBv3srVi8/KtFfiWiUa6LoPBIz1BS2tZ7oDKK0PZCc+c+QbhU4aNk163pgtQOv141PoirZJTAy4uwgMCr9vIzSrS3TwNluived81FYs3hfHHlAAT+yZ196GRNfB14y/kn3hV9Avu6sebD6hoYmd7HOp4Ksw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9621c66b-73ab-48b3-a5a8-08dd623a9bb6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:23:21.8678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izX6l9dBP4F1shV2EAEL1fIpqmev/UJNEXAWz46ESzcWlUoAo20xmGlgCjXSm8trYL6sc9JeMzLgM/2bROYOxgHYPRxnpZ1zJPdlGqkGDOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 mlxlogscore=916 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130112
X-Proofpoint-ORIG-GUID: xHbDSs8w0xnp3tgoY-3Qa0e8AK1GpWRW
X-Proofpoint-GUID: xHbDSs8w0xnp3tgoY-3Qa0e8AK1GpWRW
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 3/12/25 12:12 AM, Arun Kodilkar, Sairaj wrote:
> Hi Alejandro,
> 
> On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:

[...]

>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -25,6 +25,8 @@
>>   #include "hw/i386/x86-iommu.h"
>>   #include "qom/object.h"
>> +#define GENMASK64(h, l)  (((~0ULL) >> (63 - (h) + (l))) << (l))
>> +
> 
> qemu provides the similar macro 'MAKE_64BIT_MASK' in file
> 'include/qemu/bitops.h', you can use this existing macro
> instead of redefining.

Hi Sairaj,

I became aware of MAKE_64BIT_MASK() because you used it in your recent 
patch, but as you mentioned they are similar but not the same. I 
personally find that using bit indexes is less prone to errors since 
that is the same format the spec uses to define the fields.
So translating a RSVD[6:2] field from the spec becomes:

GENMASK64(6, 2);
vs
MAKE_64BIT_MASK(6, 5);

The latter is more prone to off-by-one errors in my opinion, specially 
when you are defining lots of masks. Perhaps more importantly, I'd like 
to progressively convert the amd_iommu definitions to use GENMASK() and 
the code that retrieves bit fields to use FIELD_GET().

I am planning on later porting the generic GENMASK* definitions (from 
the kernel into "qemu/bitops.h", since the RISC-V IOMMU is also a 
consumer of GENMASK, but I am trying to keep the focus on the AMD vIOMMU 
for this series.

Thank you,
Alejandro

> 
>>   /* Capability registers */
>>   #define AMDVI_CAPAB_BAR_LOW           0x04
>>   #define AMDVI_CAPAB_BAR_HIGH          0x08
>> @@ -162,9 +164,10 @@
>>   #define AMDVI_FEATURE_PC                  (1ULL << 9) /* Perf 
>> counters       */
>>   /* reserved DTE bits */
>> -#define AMDVI_DTE_LOWER_QUAD_RESERVED  0x80300000000000fc
>> -#define AMDVI_DTE_MIDDLE_QUAD_RESERVED 0x0000000000000100
>> -#define AMDVI_DTE_UPPER_QUAD_RESERVED  0x08f0000000000000
>> +#define AMDVI_DTE_QUAD0_RESERVED        (GENMASK64(6, 2) | 
>> GENMASK64(63, 63))
>> +#define AMDVI_DTE_QUAD1_RESERVED        0
>> +#define AMDVI_DTE_QUAD2_RESERVED        GENMASK64(53, 52)
>> +#define AMDVI_DTE_QUAD3_RESERVED        (GENMASK64(14, 0) | 
>> GENMASK64(53, 48))
>>   /* AMDVI paging mode */
>>   #define AMDVI_GATS_MODE                 (2ULL <<  12)
> 
> Regards
> Sairaj Kodilkar


