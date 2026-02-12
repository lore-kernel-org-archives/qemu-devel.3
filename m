Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B99EEA845
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqbqD-00068z-Ck; Thu, 12 Feb 2026 13:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqbqA-0005lH-0a; Thu, 12 Feb 2026 13:55:02 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqbq6-0004Kk-Nq; Thu, 12 Feb 2026 13:55:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEXvMdkc5l3zh+9A6vqS6dI2Q9i+RXrQB3ZKqL7lRo7MKhlJB2jiT5aC92a96rMSDFDUq9sFQqJIt6k6fDarEBzJx2XyZo7Ez0UOyPnwKiC0FtmukPNa6SC9LbiVbXSi7zu2hsWDDX+9X9pqhPZL33MdzleeXPH35Xh1NxNUePVQ/VZylkHaF4qo8mZIjzVoJITXuYQ5gveMrK0Ov65GhxrbCa8PlLsA3ozm1mvHZUw8V5IX2QRM/KBrAYgnP87WSfTiff6Aa4qtTTvQ/H/gUqOWRzmk5AbHxMq7WP5N/HxfNAdFDQP1mDdnMtYgGHnTIsavPwAcysKdR6uQA4edJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znYPXB/WhlBG89bfIDttCKCjz3M6tsSRtyUe7dD3h8c=;
 b=V1yQlKp8emxy3wHbn/dEGmqz2G7LumN8+CdUjRxk0s2JhV2Wmg2yh8UxgwUFUmQVcTjSQajmVchb1xsUo1mtBvIpV/SLf8DOQi9Z60Vbdn//18l4bEGx7Z1w74RH3vEgB0BUUSOjLF5VrxhQwO6QYGMyiKBwCXo5ty5fAhOV/MT3ydGOJG305EsUN93La69Yp6v+2yp+8Te7sqv8z/NxdQ6c9Kesz+D+ljp0PkJGumiyY7+MoL20KspeXRVrknXytjVhE3sADSJkjp65ss7dv7vTRHqGsd/TpZKbJFJWjLnVi5bTDdGVpFQES01XmTXEtufXAckcPZTD4h8l/AxK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znYPXB/WhlBG89bfIDttCKCjz3M6tsSRtyUe7dD3h8c=;
 b=jQ3GwnS60SGXhnCLtOGapUkYT6qH7kUnpAMOIDyY2GrtE/XBBcUimnQmPdubec0wLCopw4N086Jgc6/yNU3PO7fk62ac7+SjebqD3R6Ly58dgFx2zXB4QolLssUqJC8hLUmlLP1kXRWWHP3ROTE7ECIUBNc2N9gNg/xtuc1R6neZo4NssAAuyGCY9HgCX+kswosdLlHSZ0Kt6bnj1avVttdpFgkzoKNDthi5kSB+78tFPTfOu481iWra+hW3DLFXawJFrDSfC23nrTjjozzP2A8BVIDlPdKHWGumKxamU8weAjTUYpgHBAt9KxO6sO9ECIzK6cox7q/HAgZUqcgnlQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 18:54:48 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 18:54:48 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v2 22/24] hw/arm/smmuv3: Add per-device identifier
 poroperty
Thread-Topic: [PATCH v2 22/24] hw/arm/smmuv3: Add per-device identifier
 poroperty
Thread-Index: AQHcl3gEXhkB/SyYnEO7X7d7vTeZ+bV/cZcAgAABULA=
Date: Thu, 12 Feb 2026 18:54:48 +0000
Message-ID: <CH3PR12MB75484282A621455C91FC7A84AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-23-skolothumtho@nvidia.com>
 <e4589c56-6628-4aa2-811a-c03ce17b5cf5@redhat.com>
In-Reply-To: <e4589c56-6628-4aa2-811a-c03ce17b5cf5@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA5PPF8BD1FB094:EE_
x-ms-office365-filtering-correlation-id: c6185278-d08d-49e3-63e7-08de6a68326a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Nno3emZkSk1NSXljR29PRndpSmZqbFFQRFUzNngyQy8zZ2RnSE0yVzhpSS9l?=
 =?utf-8?B?L0hlVHE0NmxXUUMwSGJHSnRCaWxLVTNRVmxxaTdhQ0NFQjNuaUgxUEg0eTF3?=
 =?utf-8?B?Ly82K2crWG9xTHFBV0dVcTIwQVgrS0M5RCtaY3RuUlZxNGVvNi9CVWRqeTBW?=
 =?utf-8?B?VW5OUjI4UHJkMUxiVmlIUEI4Z0NYb3lTTy9PMWFmY1dVaXROQnlsMUtCVWFX?=
 =?utf-8?B?Wjk5N3R1UC9yK3FwUDlEcXhzM3czZ0V6Wm5JUTREcE5JWnY3SElHQTdld2d4?=
 =?utf-8?B?ZGozOXdrK0JIM0lEOVVKdmVaeVFjZGVhYVdwMDZIZExMNDlQN0lmUlZHektG?=
 =?utf-8?B?MitjdDhEa2hNbVkzM0ZPVWd4SGlDUDNreXZNNnFkMU5zWGhYWDAyTWJsbFZO?=
 =?utf-8?B?Sm8xYjFJQmY2UkZLY0JpUGw4V3NibmdmN21tR3lCejFkQjNtREdadExIV3A5?=
 =?utf-8?B?WWpKY3l6WGk1dDhqMzUzQzhHVUlIbnF0ampVUmpxQmg3Q2hzNzFjTHpEM05K?=
 =?utf-8?B?VzJzWENKOWxVMW9iZ21TcmVuWTdMc0llWXJrQVZkMld5U2pxS09aSWtyM1h0?=
 =?utf-8?B?UmppUmIyNE5SbklRRGd0cjZ3VUlkSm5UNmhpL2dveVFTbUE0LytPaHQ0bDc1?=
 =?utf-8?B?eTVEYS80QW5jTVMzZ0d6dXd2MnBsLzlpR1NVQS9JeVYxZWtTek94cDc4cU9v?=
 =?utf-8?B?dWNKbUpDMGFkc3JpdmpDeFFoYTdHZGRWMVZ2ZDRmUnptV0h0QzJyL2owMG1s?=
 =?utf-8?B?VjdFa0s4VThBVVFmSk1WMXAzWHZDaytXbGlUZGMvSy9DSkh0SGYrTGdydFZi?=
 =?utf-8?B?UThZdkFIeTNNRzBKZGptSnlBbHkySEk0dDRsVUM5N2hvS1RiSEpLRVJZaVhm?=
 =?utf-8?B?ZGVzdlkwV3F4OG5EODBLbW54eGpYN2hmS0wzdENpNUMxV2g1cVBUZDBhbjVl?=
 =?utf-8?B?R0R4VXdMNTVzZHBia1JTSCtHOGVtWStKZFpBRVdFbUp0Q3VHMUFvS2twSWNS?=
 =?utf-8?B?T1dWWittQWdTalFqODJIWklER0RoSXJVSm1yRjdLVnhVWloxa1dIUHY1bVg1?=
 =?utf-8?B?ZE1EVW11VzNSQjAyUGFDdHptbEd5a0JHWVhPTUsyc0dlZWpCN3VaaFVNT3FD?=
 =?utf-8?B?U3R4UnhsbVIvbkp5VEI2SXZoWlpHV3kzcmdwa0hPOGRHanljS1pIUEdicFV6?=
 =?utf-8?B?a2RqM0R2Qm02eUw1NTM5bVJFV05oOVlJaXZjNXBKVWJOcXV6WS9SSVVVN2Ev?=
 =?utf-8?B?TFk0dEo4RjlKTTA2VHNMaHpoODh2MWk2NURTVjNRbWlEd2lTY1hjcStQQXl6?=
 =?utf-8?B?Q0wza0VoSm1zQWJRK3VxQm54NFdKSW1mQ0FFdDAycWhjRGVCZ1pGcm02bVJH?=
 =?utf-8?B?aG5Lb3JDSzRwTXR6Ujhudjg5ZUhrWEtqeE54dUpjR0RCQjdMdEU2M1F5Y29I?=
 =?utf-8?B?VXgxUjRkRTlxdE1aNzNPUDA5dFNtVTF4dnV0UzkrTEVsWXZQcHJNTGlqYTI4?=
 =?utf-8?B?alJWUisremszR1dpMFlFNzYyVG9CYjlCQVJJaUNRVnBJOFhOTzdDcGh1Tk4z?=
 =?utf-8?B?RWxiLzNocnpDZjNKdkkrL09QSG1XakhTRjhyTmZyWFROeWt6TFhhMXhrbFBN?=
 =?utf-8?B?ZUNBd1FxL3Z6dHpmc1JGZTBxaEUyNWpMUUM4bGNMTzVtcFZLMEl0UjlxTm8v?=
 =?utf-8?B?TzVqV2tnV0NXZWRIeGUwSzFkWENGK0g1K1llZWFWSC95dkw5alh3MmRzWEpk?=
 =?utf-8?B?OTVBWmZ4MDVESDlNbUtKRFgzMGlHM29xMTU4MHJZWDVwSE5CclNHRzFrd05T?=
 =?utf-8?B?QTZ1N0Q2SnpaNGJKeDdYV2xFVisycjJCYmpnUHdIY0gxcGtVSHVueWc2NDNV?=
 =?utf-8?B?RkpHbW0yY3FLR3ZWNnBMUUt3bmZGUnlyK25Ib1FQbHh4enRveDNYenR4YzlK?=
 =?utf-8?B?eGNGUUZzUGUwTDFwRjV1M2xTK3RWby9JcVNmMkMzeHJlNkwrR25TRW1HOHds?=
 =?utf-8?B?L2E3c0NOdUtFTm1RWFlXQXVGR2tEcWZFOHFxRXZUVTBhSHVPbTloNWsrWktj?=
 =?utf-8?B?Nk5WZytRZmtvMGN5SEFDWUtZeFd6VkYwYXdzWTV4c2htb2ZzMTJwSUZzbnBN?=
 =?utf-8?B?TFFFaEhVcjJnZ1lucTdyeUlINWV0ajh4bVZWWVJYQnRMemxack00NHpldEV3?=
 =?utf-8?Q?dhDAp2AX/TD/ReTtkJBXv6w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjF1TnNvZGkyYzFPeVd6SklIMGdRTGxpSFRxUXFlb01EWUFkMU9wQ0NrdzFo?=
 =?utf-8?B?d0VuTWtIZGQrc1BIK1NhRWxVbnE0aFRrRUhlSEVEQUxNdEx2dU5PL0JEUGZL?=
 =?utf-8?B?R0luOVJoQUZ4dDRLWlBnK0JEb05ZYmVYdm9Wb2VxNzAyVmxoK2NiUUlWUEtx?=
 =?utf-8?B?aXhTTmxlU1JTSi9zYXlXM240eWJZd0pLc1QrRTBnQUIzNzV0WlcvV2U1VENp?=
 =?utf-8?B?d0RNTVBxdGE3QW5QaUl2YmU5M3ltaWovdlpBY3U0R0lKNDZqWEJESmNvMFY1?=
 =?utf-8?B?RVkxOUdwNzFJNFNvZC9NdUpTVmpVSG1UNENxbk1yU1kvM0dRVnNQclhuOXZi?=
 =?utf-8?B?UGFrcXViSy9WT3IvRS83bko5anMvbEdoRzJaMkttKzRiM1hoVWoybXl6VHIz?=
 =?utf-8?B?RWYzcXpOTlhza21IcmI3bmRqVSs5VFRJUEhSelN2eUNHNFBDcFFEN3RJZGRI?=
 =?utf-8?B?cGlYbFhmL245V0lwVVA4V0lJK0NtU3BpTklCdEF5TWNTS0JhWmZzd1M1Qmcx?=
 =?utf-8?B?TkZob0p4V2VueHIrZ2EyaFE0QVNoOHBITkx4ejVXbWFNNFZyTHRLRkpwdHJB?=
 =?utf-8?B?R2podDRuVzdqMThvY2tnTTN1MUNEYU11UjRQRlpYMzRSdDAvLzlkajVmWGFR?=
 =?utf-8?B?Y1laWEVXcldOLzJQQUdSYTBXY2wwajZTemFvMzhCbmJLTXN4azZ5cllIZ01C?=
 =?utf-8?B?SHJGbnhzdmJTWmVUNmZ6aFZhMm1zdC9rT3M3c2M2aDE3SHpTTEl5L0hKVE9r?=
 =?utf-8?B?V0dPdnhwVi9MOUJjc3pZZ3hpbU9oNFUzcStYem9yenZlanNjcFVoMUhhQzlt?=
 =?utf-8?B?ZlVYbW1XWUlnRG5uR2hYYmZ5QmVqbmtJTGNxbmNWRUNyUHlZdjQ3Mk80enlU?=
 =?utf-8?B?Z3dIYW54U2pTamMxVXdWMkV1NHpQR1M3ekV5eVlKRXBsTC9PUUVReWhHYXYr?=
 =?utf-8?B?VEZ0VkRxT3c4UDVodEhvbVB6VVZkMEtTUzQ2MEFRZnlOeTArV3l6TFdZZEI0?=
 =?utf-8?B?MXhzc0w0VmRRT2pudnBCc0tRTUtSMmZNSWFJVTRZRng0Ti9KZmcvOVkyOVBa?=
 =?utf-8?B?YXV0T1lOSC82VWFXQjRieWdtV3EvMTlXY213QVBnVVZZUnZ0Z3c4WkFnVjZ3?=
 =?utf-8?B?YUtZUUx4cWRJL2VPY1krdllQL1ZPV3JTWHZveXd3NTBDdUlzVWsrMXZ4VUda?=
 =?utf-8?B?MUQzMTIzUWJaN2k3eUVKdjVlWnFLVnJIWEFySFVQV3JoNVZ4MW5FZmJBUy9U?=
 =?utf-8?B?eUZzTEFqTFVxYVpuNDZadlNWY28wbjlDY3l2VnZudzFxbFM3QWdpQmJ2QTRI?=
 =?utf-8?B?cHJnMWRtanloQmxEcTM3TnA5aEJtVk41RzhrUzJKbWJ0MVhTcHJCUTZKQVYv?=
 =?utf-8?B?TWNGT2FmTDUzeHRhRFdxM0VSWDRZV2xMV3NOcnVMTWVIRVhSUmhrekYvcHhv?=
 =?utf-8?B?Ym45V0s0RVE5a20wSHRVam05QndlOUVXNEQ5aXU5NEx0MTBFV3RYM3pxSUkz?=
 =?utf-8?B?N1Eva0pmNWNOVEcvUVdpY0l5bi9TbjZKZEhURHVZZ1BMUTU1aWdQZ0VPNFdX?=
 =?utf-8?B?TnZVbGxoNEtTMENaTUZSWmRqOGw1alFocUtrMUxJUTF4YU5Dd3U4bVpjSTNM?=
 =?utf-8?B?eW9jMjJScEFmWHpJYk5XWWhpc20xeW95UmM5b3JCRnVuVC9YcEd2bGx4NC96?=
 =?utf-8?B?NHhqeWlaM2dSVXZZVkJTWW1VNmNmTHF5UjEwOWdXRmJvcWpsWUpPSWRrRHI3?=
 =?utf-8?B?K0d6Rk1VdERIdTlheHJLMkMvcmxYUkNzYk9uMWtDa1JIQWNORTliVGkvQ0pS?=
 =?utf-8?B?UmpGK1AvcmJTampjUVBqRHNEeGpwV2NPdEpHUktGdTZmVFVWRUN6Q2pvMDd2?=
 =?utf-8?B?U2tQcTVGMU51d0NqSXFFSjJta1BzMjc4R0N2R1AxU0FKTXdiOXVjRHMvQ1Jx?=
 =?utf-8?B?b3RLZktOajdaejdMNnowSERlTjVwelFNNHJaUGsyZ3EzaW83K1dxMnN5Zk03?=
 =?utf-8?B?RW9SdUdEV3hoVVJYQmtVSUdlVVEwVXZnU1BHQUY4eXl5OHVBUlJzZnB3Zkk5?=
 =?utf-8?B?VmpEUC9na1ZOcDd5emxKRUhrUys2QXpkaEFNY2FMVCtsTEFVWFE3TTc5LytM?=
 =?utf-8?B?Mlp5eGY5TkdWMWJDRGpMVTNxWFl0bjNYRDNPNmRoM0toR2JFL3g1cmZrSTJB?=
 =?utf-8?B?MHNwSGkxdDVnY3JCdmZNekR6YmVBbUpyNWMzbCt5WlNWS0FaTCtROGQrN2FI?=
 =?utf-8?B?aHBiRGV1VmVCa1MzbzB5Z01Fd0doOSswVEY4VHA1TFBCT093K1VuRkZBRllu?=
 =?utf-8?B?UzNmNXkwVU43TllLb1RHZUhXc1RuZTEycE9MWk1PMkZYTmRpV0h1Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6185278-d08d-49e3-63e7-08de6a68326a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 18:54:48.7585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pRgsZVGOQQnY79ws+shayN0gesKr4/F/6BG5Ib5U2fJFXvmfc0RMl9/n1Ca+05XDj6RJcOlki5pYeuda8TdnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMiBGZWJydWFyeSAyMDI2IDE4OjQ5DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUt
DQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5pY29s
aW4NCj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52
aWRpYS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4gPGph
bkBudmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0
aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyMi8yNF0gaHcvYXJtL3NtbXV2MzogQWRkIHBl
ci1kZXZpY2UgaWRlbnRpZmllcg0KPiBwb3JvcGVydHkNCg0KPiA+ICAgICAgICAgIGJ1aWxkX2Fw
cGVuZF9pbnRfbm9wcmVmaXgodGFibGVfZGF0YSwgNCwgMSk7IC8qIFJldmlzaW9uICovDQo+ID4g
LSAgICAgICAgYnVpbGRfYXBwZW5kX2ludF9ub3ByZWZpeCh0YWJsZV9kYXRhLCBpZCsrLCA0KTsg
LyogSWRlbnRpZmllciAqLw0KPiA+ICsgICAgICAgIGJ1aWxkX2FwcGVuZF9pbnRfbm9wcmVmaXgo
dGFibGVfZGF0YSwgc2Rldi0+aWQsIDQpOyAvKg0KPiA+ICsgSWRlbnRpZmllciAqLw0KPiBXb3Vs
ZCB0aGF0IGtlZXAgdGhlIHNhbWUgb3JkZXJpbmcgZm9yIGV4aXN0aW5nIHF0ZXN0cz8NCg0KSG1t
Li4gSSBuZWVkIHRvIGNoZWNrIHRoYXQuDQoNClRoYW5rcywNClNoYW1lZXINCg==

