Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A6FE6816B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 13:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsKlk-0003y5-3y; Tue, 17 Feb 2026 08:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vsKlg-0003x1-Cq
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 08:05:32 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vsKle-0002BX-7m
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 08:05:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hs2aSLem1rqEaEncVSKK14FpEVDcGbsgQYKseuZCm/AWGA0uCzPLjCUZMBDk15pKfdoh94ooeSLbS+kYg1pycCDhSQv2zjo1kliGrN46l86deQSfLAjYeqcLH69MwJSUSVNUbRoGOlTpSpATiTCdtN5wk5R2dkL2RmifJXn/2c0yi5Y88gY2gMwemp9e03++QKqZVfJZro070Z88fX2kVK5gGX2M4A1P0g3xDkT92kETqOKUkar/ToTTa2c9W6Bo+nOQZYT/1jOrX1z/12sRoJYxnasXp46lJL2fS+lFu/ldwtQxSVqn2h0km26itzG+V1pu2njpQNV6EdN1sbgPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdE1As6m/8OhIo7e26FR83oU3Uc9NtVYUb/n1gxb/ss=;
 b=exHsu1RRx198p0d8UpgPRGfPM7tMgFrPqNkZZj6cF8wgB1hREDKy4PTwtUacGU5+3mJhT7zzQiU7yXSVWILoiZpzReJu3eDPsXxj1aKvu6NTSBhpKCdKMQ5Rk40zoTvzW2HYGsGl8+y9FBNwkoBVUXLVLBXo09/0p0K5yXuDWerDt+vkYWXq9kJUAhGBwdLJlPsx7fOYafCegQlu4m53BjO3JTmwHFaAICMUR2pmUgRBRZMHll1N1GpxcMofdzzwrFmCh75UIsQusGrHndjAGM+/j3Tnwxw4ScUPdZXocWg4bZNuNLJY9ANmrciNDxJJ9InzffsE23atuqkrOXl38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdE1As6m/8OhIo7e26FR83oU3Uc9NtVYUb/n1gxb/ss=;
 b=YvbS36+szKyApZLDfeRJJrazOKe5JCBwPakeatJj3+TlnloiyQfTryYsFXtGrGkKiy6XhdetZm0MoJhoUa5bM1UB0JPuCLNy7fy5A/5ORsrbFBJA0T4mQycTHsq79YKxFtS/SrOoH3hNztb4kiVLomqA6copCUKGuh/h4y8aw7lKa5SrI4DXsgT3iWJ6IFPdPyG0VapuRtSVXSpSlxWDdnss43uXEDQfXXMFnoCgOVCQpu2FoyAbOff9bacgCQP3SmYViNH/nvKwUi2LACg4FziepIsb5pY1KlfFqW94Cn10PRss595h/8sxCSQ6edoswWXAvvzlrUEilpW9E2CW+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 13:05:22 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 13:05:22 +0000
Message-ID: <68820edc-9527-4c8f-8651-64ea75db8380@nvidia.com>
Date: Tue, 17 Feb 2026 15:05:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260202173406.13979-1-avihaih@nvidia.com>
 <24ea8ccb-d904-49e4-bd27-5378aac4a56a@redhat.com> <aYIqDAdld4a41VDy@x1.local>
 <87cadb65-af45-4bb3-8090-8301a1e67103@nvidia.com>
 <a0dbd63d-30b9-4c83-851d-abaf50d4c9fc@nvidia.com>
 <aa18ad15-580e-483d-8e29-20c7e6ebb6fc@redhat.com>
 <1260f024-b22a-439b-a70a-ef5429162b3e@nvidia.com>
 <57489f93-0439-402d-b9d5-a9d2a0a30a25@redhat.com>
 <28ce755d-c562-404d-a096-09b5f32f0945@nvidia.com>
 <7701d5d2-bf51-4c2a-bf4a-e371264d5874@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <7701d5d2-bf51-4c2a-bf4a-e371264d5874@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::12) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 576b0946-cb7f-4f49-7201-08de6e25356a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGFoUHNoVk1yZUd5aTNaRHFuQU1TRVdVOE1GMlpjVVUyS3liemMySXgxaE8w?=
 =?utf-8?B?blNNbnQwZ0l0dmJiTWZJZ1g0eHlOK3U5QmZEOHdBbWhLQk5QSnFDaE5ZdWdC?=
 =?utf-8?B?MUM4dlk2dUhRODFRbTJ3TXgvQS9MWlpwejQydW1yWWhqNjRsM2xFYUhBOHJh?=
 =?utf-8?B?ZnNrREY3b1BGNUlRRzBPRllmazVuVmFwS05xeUtSU0RvSno0Y2MwMXltR0dw?=
 =?utf-8?B?Nk93RHBZem1nbG96dVp4dDkrQzRTSndTVThlQWtZUTlFUWdGaUh6Ym96ZWFr?=
 =?utf-8?B?bmdtVE1OR3doWXRCdTVCZU5ML2YrL2NRaEg2ejR6Vm8ra3ZqM1AraEFKTyt3?=
 =?utf-8?B?VmxTSTlLd2tyVHR1VUFzL0dWREpoWFBDZFB1RDlBVkZSdUh2VncycGxwWHdV?=
 =?utf-8?B?bk1ETkowUXNENzczSW1sZEpxQTRnSVM4cWlRTldLeVpRTVhEZ0l3SDRiMEhN?=
 =?utf-8?B?TzZWd0UzV2hPVCtsYWhjNTl6Zk9NR3VlQ1JkYzhxcWNDZk9oVFRhaW8wQnVw?=
 =?utf-8?B?QjNhWVhNZjE3MEhSQ0xLdjJRUHhYWGlmMFRzMGpSbEFldGszdE5wc0xDUU1s?=
 =?utf-8?B?ZUo5NjRqRThsWkVoeERxeFFOUHY4cFZiRllncjkrZHc2MnRxYkRxL25FNkdL?=
 =?utf-8?B?cHNLcHdSK0RQaU56UWI3bVFxcGdCM1BRdnhXUVVBUGdUY2ZhVFFMd0owTGEz?=
 =?utf-8?B?OWRsTE15bHpTSDBBR2VqK1luOUwrb0VDVmZ1OWc2Vy9weHowK3pMU3ViWTUr?=
 =?utf-8?B?R1lXY0k2Yk53K2psQnlKOVQxMWlhN2w3bmg0OWFNdGtnNXNsZkI4dDVScEhi?=
 =?utf-8?B?V3F4NnpnbmkrWnY2eDJOLzRDd00xT0hmRER3QjBBVklqUEZIdFNUdFlkbzBi?=
 =?utf-8?B?V1R5WFE1ZHdMS1FMMVAvbVl0RlF5MmhaWTRhQUFqekY0Q2F2ZUVpcUI5UThy?=
 =?utf-8?B?R2FFQXZCNjczSTd5eFNKdXk0bnVPS1FqMnU4MyttZ2U3ZDFqSnFQcFUyU3Ex?=
 =?utf-8?B?YWw3VDJhMGxQR2phZ2xsMVplS2RZU3JCSUg3cFNWU1pTckU0VmVPeXh0WTlp?=
 =?utf-8?B?eDZxZjJaMHowRVl0QlJjTjlrckgzZm1nK1ZwczV0MFFoS2tydnZkR1d0cERq?=
 =?utf-8?B?Q2l3czNKRXdIaC9qUXVRZnVWcE80ZXFsQ1hMYmxwK21Nc2tNVmcxL0JZRC9y?=
 =?utf-8?B?NG4zb2pxM05ZWkdwVkptU3JKK2RzV0QybHNCNFhJK1NxZXlVNCtpaVY4Vk9Z?=
 =?utf-8?B?RGZKeHRBQ2pRM2V3UHE1emJzcXBtRGhBZjJ1N1RzWTN0UXplc01GSVdLZThO?=
 =?utf-8?B?dExETjM5aDZmN3lxWnIyVHQyUEVDa05qVnQyYm0wVXF2TnVzb3JZUVNCQ1Iz?=
 =?utf-8?B?b1VlT2wxckZhOEZYelF3emlrRlJUU1Z0S2tRZ2tWK01lWXNUcmFUbSs1YjVD?=
 =?utf-8?B?VTBsNVY5Umd3ekhwLzlOTmZpN213UzNCVkxsZnJ5Qy85eVBMV3U0a2c5MGwv?=
 =?utf-8?B?Z0tiSGg1V0JqRXhPeGFveGo0MjZpZ2J5WmZxY2V5dzhoVnFHbllMYXlUdklt?=
 =?utf-8?B?QW9jYjdyNEkwRVJFOUFqbDdYOGVhdzlPRXF1aWlFUmVYL0dWRVUvMmY3MThy?=
 =?utf-8?B?UjJmS050ZVBrRWFGdHpnNXhvMFdKcjRhVmVtMW0xYmJMZGxBQ0hqVTExMThi?=
 =?utf-8?B?RG10czJmeWpSYlZLSkZ2OUw1K1RRT09STmZ1azAwNmE5MDZwTktIQnllZnZl?=
 =?utf-8?B?WXMvTGM0Qjl0eFlTTUc1RmhzZmFzOEMxTmNYeGJpakphZTRMbjd5RVZ1WTc4?=
 =?utf-8?B?TzlSTE83b3l1WUtwN0dCQkNFUmdLQ21EanhwbzdpYk5lTUp2aTM0YXg3Nklr?=
 =?utf-8?B?STZObzBpL2hUZnN0NjRldHB3ekVpR2NrT2FNNVFxcWRhUjNaTDJqQU9adnNi?=
 =?utf-8?B?ZmkraVBDNUN5VS8vVyszSDFyc2o5azhMeGxlT3dqUVBBeWxWSllsUTVXUnBq?=
 =?utf-8?B?Qmg0VEhNNmR4bWdodGFvNWRSY2FTaVZZVnFJWklIelNLd1BnK1JpMkhCRFpK?=
 =?utf-8?B?RmRzRDVRWUg5UFRTM0lWcG8vTExLaXRSKzVKN2kzTVQ0UmJ5eGhIdkVJTTAz?=
 =?utf-8?Q?/mT0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW9heVZXTElkOVNTZ092MjlRTUQwYmZHUWRWV2RDdjVLVy9Xdi9GQVNwKytt?=
 =?utf-8?B?czlPYTJjc1JQOEVSRGp2QWRkallmUDA1eTl3TUQ5aDFUL211MUlhZHNaM2xk?=
 =?utf-8?B?VFRsY2EwaGpYUTZKRVZtZVlVSzkrcll5SUt4am80V3FFVEJJZ2RuNDBhdTd6?=
 =?utf-8?B?cTZtUzRrclRkdk9KWDFnajhGQ0YxUGo5a2ZGV2FTZFJpak5ONmxoV2lKVWpm?=
 =?utf-8?B?SnBuRXQ5Y1ZTelNmeElnUzVpakhvS0Fxa0phZVNNTXgrS2FybXkvNW5VZ1h1?=
 =?utf-8?B?eEhNdi9ZbEZoN3dWQ21RZVFlQ0phOEJLTjNDZ1VpeitodUNPZVRFc2c2Yzk2?=
 =?utf-8?B?T0ZiL2dNZ1hZVXY5KzhxWlZBRWJtVWJrQ1NVeG1CNyt4dnBpbXIrcmVPbmFC?=
 =?utf-8?B?cy8weElKTW9SVi9ManhqbmxVOU5JaU5ISzYydkFRZktoaWNsZTBYaTV6dHg2?=
 =?utf-8?B?eWVIUmo1M2hjTFpiY3pFYllSQUtwOFkwWXQ5ZmhqZysyaExOM1daNlBXYzNI?=
 =?utf-8?B?c0M5Wk81cmFpa1lWYktaZnZ5cms2RGNrZ1NweDFUSzBuZHAwM1c4UWhpQk5r?=
 =?utf-8?B?Y3pkNFJEMmVlajVKeDFsWDZlc1h0RkIwaE40YlhwUjFlQ3dNSWliYWlleVN3?=
 =?utf-8?B?Mzl2UTBqRzF1aVN3UkNKdzFPVTNWeWFYTmttWm40RGpaUWRXT21GNWNKQjdF?=
 =?utf-8?B?MlJkaUQ3dlVWOUVnemhkL3BGMFdmdDg0SVpqcXBoa0dBY0hPRDNQVUZPMnJs?=
 =?utf-8?B?cHl3TUp2SHRFWEhZd3RMaVVXQk9LNGV1L2tORzZiL2Rxb2pBWDVKanpEeG45?=
 =?utf-8?B?VG1Ud1o5ZWF6VjBZY1Zrd1BVcHN1SmY2cGJBWEQvcWFzbVlyd2ljTkJwWnhE?=
 =?utf-8?B?OFB2VXBHNGFJME9BbXZFODg4YjBMemtzTTMrOEt2M3Y2alNqN2NSNVREQXJm?=
 =?utf-8?B?emJlTXdNM0FOMnBPclU3OTVMSERBaWZraXBrbVZjQVpRcjBsM09jMzJuMEFW?=
 =?utf-8?B?WGkwZlhBYURKZ0YxZ09qTUJZbGxwUE00eER4SWhtQ2pEeWRVSTQzNDQyU3Nr?=
 =?utf-8?B?M0d2QXZhWWJCV0NvWThNMDRjbGh3NUNoMmFxMDRkNU9XQjRLRk5ubWZtbmY4?=
 =?utf-8?B?WUhxM2tnM0FuZVg2bzU3TzRjZDVKY3ZXV3Vvbld5Ly9xNklaQThxWkVzSnBR?=
 =?utf-8?B?eUc0Q0JKcUp4U2taNWRkeGFJd3plV1hLcGQzeGY0NHp3ME1WZERFRWpnWnN2?=
 =?utf-8?B?RE1BaXRtTmxLNkJxRmtxQ3JYamc4cy9JU1gvR0I1SWhrUUtnMmQrRStlbjVU?=
 =?utf-8?B?YlRrTklUVDNkajY1Z2VUWHdGUEZsQllzWjBIcE1rQk0wVU1zNGVJVGV6TmJk?=
 =?utf-8?B?MGFySFllazJxTWVoaVg0Y0ZaOXhxMnVzaG1aYytZbDVHU1RIb3IrWFB5R2gw?=
 =?utf-8?B?YzcrY05nWUdtSmNTMlBsQU1FYTc5QVdSbURvZ2dzN1Z1dW9rU3JUbFp0ZFVi?=
 =?utf-8?B?SEZHRXhOU0dBeDM5d3pnQzIyT1J2WVhjZkJtaXZUWll3TEoxOEp2eUIzcVdZ?=
 =?utf-8?B?V254L25xTFp1UmtpRnNETjdlRUp6eW54Zy9odkc5OVJESXRhcTdtYTlPTzlj?=
 =?utf-8?B?NFdyTjhmdkJlRUE5VlZnVmFLMVhzeU10cWVDTzNKb29YNE1uUW52cmRveG5v?=
 =?utf-8?B?bER1bm90S09IMzlnSU9tYnN5b1lQYW1qbDR0dTh6TnJiYUErYjMxUCt5MEFz?=
 =?utf-8?B?aTgveXNRMWZmU1RKUjhiLzhoSHJHYlE2TUZiVzRkTEtHbFZlOTB4Wi94VFFq?=
 =?utf-8?B?cXlhc09mcURCM3FnaGMzM1ZwRjNpdHpiMjBoSUNCQ3hZaG02ZGthZjlYTjdP?=
 =?utf-8?B?b3czekFTMldYRG9DOCs0QWt6d0djaStDTGhjNkdHM2tQT201cTVBK3pvNlpn?=
 =?utf-8?B?MVMwSUVxS01jN3BYaWNkNFFFQWpmL0V2QmE2VzJlbHoreDZ4ZTZEcy81NDdJ?=
 =?utf-8?B?NUd0ODVsdllkNjVMVS9CYUVEN1d2U2Urc0laQUpyNHAyU2dRQzM2V3ZlNWVZ?=
 =?utf-8?B?QzVwWEVaWElLUng0Qlh3OUo0YVhKblJUM1dJK3FlU3hmRDBodkhpYlJEZTl0?=
 =?utf-8?B?VkxpZmx1OWRadEdyc0RDa3VNTExFb1pieVRYbTlVcnpudU9pUGlHZ0tOajBG?=
 =?utf-8?B?MHkzbGY2cG81NGhJSmdyZHJNd21WdXJ2MzBtZUgzY2dmT1M1QTF4bEh3Rnlw?=
 =?utf-8?B?ZWVjOWZFNnozbmJReVlkaGxPUFhDN1RJWW9TdGR1N1hINzA4WHhZeHU3NVlV?=
 =?utf-8?B?VzlyaFZwYUtSR0M4aUhsTnB1TUt1bkVFcVRjclNoM0lqQ3pBZ3RNQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576b0946-cb7f-4f49-7201-08de6e25356a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 13:05:22.4590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBCFDuSkpJOjvcdEFONcPdr0exWHoQsVpLLkxY/2bf7mZV9lzNFaIKsQFT4K3qqLL/ejAyRdI+vNONItOVbhcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=avihaih@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 2/16/2026 7:40 PM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 2/16/26 14:25, Avihai Horon wrote:
>>
>> On 2/16/2026 2:22 PM, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Peter, Avihai,
>>>
>>>>> As for enabling the VFIO migration events by default, I guess we
>>>>> all agree it could be done. We simply need a stakeholder to change
>>>>> the default behavior.
>>>>
>>>> Ack.
>>>
>>>
>>> There could be value for the sysmgmt layers to receive a VFIO
>>> migration event reporting progress. For example, an event could
>>> be sent from vfio_save_iterate() including relevant size metrics
>>> to indicate progress (or not).
>>>
>>> Any opinions ?
>>
>> Amm, I am not sure an event is the right way to report VFIO stats, as 
>> it's not some change that mgmt needs to be notified about promptly.
>>
>> Mgmt layer can query migration stats when needed using the QMP 
>> 'query-migrate' command that returns, among other info, a VfioStats 
>> struct with the total amount of VFIO devices data transferred. If 
>> needed, this can be extended with more info about remaining data 
>> size, etc.
>>
>> Makes sense?
> so you would opt to extend migration_populate_vfio_info() with more
> info on the VFIO devices. Fine. mgmt should poll then. My knowledge
> on these layers is limited.
>
> The extra info would be "precopy initial" and "precopy dirty" sizes
> I suppose. Per device (more complex) or overall ?

I think per device would be more helpful.

Extending migration_populate_vfio_info() could be a nice add, but I am 
not sure how is this related to this patch I sent?
Or we're discussing this because you initially thought that this could 
be a reason to enable vfio events by default?

Thanks.


