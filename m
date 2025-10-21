Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A09DCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7XP-0006zX-S5; Tue, 21 Oct 2025 04:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vB7XO-0006zF-7q; Tue, 21 Oct 2025 04:16:10 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vB7XC-0005Yh-Kk; Tue, 21 Oct 2025 04:16:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFTvdmneJwCYQQ5TmlyCBKp7muj0aByJdMX1+yZo+aYkPVsp1W7uwzHeK38mZ7zhjdbhU74rblEF6c/fRD++4uTU/uphH2S8TAYI/tKQ8w7jSpuQEflOZXLT3XU6BDW4GAv9Yq6lR9MCT+S8dq0Yj/ZVIIfVe3XBNfCxXhhQoGaTt5ns4FtjByDSQ135vLW9kFIM7WnmQGDwSumEP65NeKCM8phCoSfAK5hTpnlLZqPyoQIOUo2x2yh+p67MtO8dGm7nAc71V/7ZQHZ8i7iqSl4/ytI21R6Yt6gZ/fLlSvIdvCjQKd5K1+3xUdQPRLQ0DXpH5PiHRbLSo/k4UzE3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3zfv9OKopZ+8Tiuj6E3tlKcm7vJdMIDDX7Eg1oK5kc=;
 b=mFoIMP4SzzNb68p1JQMsjO8HGSgYXKCmAiCEfiyuTOpcRbeLEEf/6GdwIko3lwH4VI5EVCrNSgoB7g+vmc3HiyHnsn2lBfahGz7pQdse+kerwUk617GWolq04gC2vG1THrOL+lucOmF0EeOi6yUdFOfsHtK+hP2KAvM18OaEIw2Lco1fbFSel/hKEupRjBNz4L5il6/2zszlztFYFtBQFLwxetDi/Pd/nw3gIDWb0rcE5MM+Z1Z0YQUIw9tYZCcAhGF2Pm32a/z5uUSALOBeEB46wsAOybI34xcq3csbNi+4w0FP6LQQVb7S/k9w95OnTxJsJ2r9j0I68z89S7Cuwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3zfv9OKopZ+8Tiuj6E3tlKcm7vJdMIDDX7Eg1oK5kc=;
 b=Vk5PvowF0MET1qBLvvf/fPpWnpaSkYhHnrvJfa5/1sLgDne0XlTxFeG7qlEVvMvZR7PGltyJKAYS3fhsYUvLXVi9m/f1tyzRHeJuntRFun79QbDASZ9nWnFxAq/vQ8xpk4kP5X6LTbxO8vXpxR3WQTypY0XODYZHHTxAn3NrAKAX+lZMKZphi7p/d98grbVMVplMUP1fp2aNZpis4GfIrgeRhKtCn3APPFMp/lwSmRV0GaZUQ6D1HYghF8FpA7Nswb35t4o1rauUJ58+qnZg/A6lUw1INSu2Se721MvjpW35LXkM34BD9gOMZzu7W7P9iKKad+ODUA8uHoT/VUAOIg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 08:15:51 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 08:15:50 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 12/27] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Thread-Topic: [PATCH v4 12/27] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Thread-Index: AQHcQeC4Dn2h9razOUuZ2JXnwOkMU7TMNDaw
Date: Tue, 21 Oct 2025 08:15:48 +0000
Message-ID: <CH3PR12MB754810AE8D308630041F9AFEABF2A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-13-skolothumtho@nvidia.com>
 <8ce5574e-3e31-456c-9579-0fbf8526651f@redhat.com>
In-Reply-To: <8ce5574e-3e31-456c-9579-0fbf8526651f@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH0PR12MB8005:EE_
x-ms-office365-filtering-correlation-id: 61ede685-2bae-4377-3a03-08de107a0af9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Sjgxc2dwMURRRmFJUGx5Z3IwZHF6L3dsRWU2T3ZtQkVidVB6dFB6K2xhV2lp?=
 =?utf-8?B?RlR2NzFwUG9ua0VpVU40TFoxazJSbmMxWVV0Unl6R0tEaVJXSisvK2E1Kzk1?=
 =?utf-8?B?ZENZc2Y2RzNjaVQ3ZVFwUjhnUmJ2TXhRam1vUXZsQ3ZROXF6NnhiZjV2Smpt?=
 =?utf-8?B?d3RaeDJKUmFSQlUvOGpsb0Q2WklodldBNlEyWUdJRFo0QkJkNEpYa1l6eXBW?=
 =?utf-8?B?a0JkMUFndXNDa0Q1V0wyMjBQcHNnZzV2a1VlMzdURmJpQ1QvZEcyMm56a2ZN?=
 =?utf-8?B?V2FMUlYwQmV3N0Y0bGQ5c0NyQXgxeWpHRzF3ZDBwa21HUzJLUmpHbFZVV1ZJ?=
 =?utf-8?B?MVFMNkpxMlBYMjFqbFdsdmE0bFhIMmYvSTVRTnY1cGxCYVNMQTF6UG9uQjlt?=
 =?utf-8?B?QU5vLzIrOWQ2M0t6czhoSjJaWnhQS2RLK3ROaFVlalZnMmtaK2xMR1c3c1Jk?=
 =?utf-8?B?WXdRcFBUNzBEOHpQVWNScHNNYkZTOERzaVV1bUNSZ3pSRHVObEFFaVBoYUdX?=
 =?utf-8?B?bGNWZ282bTZRWU4xOU1iSDJpUU1MRjhNbUFXc2VXemR2VGlHcnBFdzZSYVI1?=
 =?utf-8?B?MUhlT1BSL3JPYUVGSVFRbDN3NktmbUh0ckdwVm1XMXJnSGU2SlRnTG8xRWNS?=
 =?utf-8?B?VFY3L3FrVlhaTXNvSDN3VGpkRW9PdTNmQlNqWVpxUkxWc1FFWDRqTGxFdnVO?=
 =?utf-8?B?M3BVcHF5MUFTUE02bkdjNVZwTnlxVVArWnRnSCsxTE5EeUhXdWFxUmRoalh6?=
 =?utf-8?B?aG5PZ005RnlseXdOZnlDcG9OTVVBQVYvSytjdWRiWU5YMllIT2tzVDQ1bWwz?=
 =?utf-8?B?R3JsbWQvZnlRRnpCbDNjaUs1c0ZnYW1CNE1XdjJhZHI5MFN6azZZZWprZHYv?=
 =?utf-8?B?WkRIeDJBVjlTTkFrVXZHczFLdmtXaW1pRzA2TXVacnlNeHliUS9JUDlXa1R4?=
 =?utf-8?B?d243OWxVUFdzeWE2RnpQQ1lkcHB6UUphclU3NWIrais3SlA4emNoRXY5YVBZ?=
 =?utf-8?B?S2Z3SnJWYXllMUZxL1R6L3RVUDA5MzNzODNMT1VWL1Rya3VqTUFVelY5YVZs?=
 =?utf-8?B?a3FLalRtcjVVVGpJQ0F6T3Qvd1NYQTloU1FlNTUvbXY1N2E5cGxHTi96WnNw?=
 =?utf-8?B?emp6UUxNSHI0cTVlOEx5eUQxUDFRZk1CRkFVSTd2SzU0blZZWXp4aWpjYVdh?=
 =?utf-8?B?MEZ0bksrYjZ6a1FSWUQybEdiNkprVUo2TTZBd0RUYzZiMGlXODB4WURsVGoz?=
 =?utf-8?B?RjgzNGVVczlnbmhVM1NySFl0M3BNTEZYMXd2NHdpZjRDMXhMRWQzb3RndEhR?=
 =?utf-8?B?a3JhNUUyaXF0VUFrZlh4QzRXS2p4cXVsWDZhbTJSVGplVm1tN1ZITWl1bVdE?=
 =?utf-8?B?ZlM3b2hqVnRNL3QzM3lyT1dIdzlITW05QmR5cFFXQ2wyeEpQSVlJamRMK0JQ?=
 =?utf-8?B?ekRhNmdQMnlPNlp4blNiNEVFcGkyZkw0NGJOcnRIdVdrNDU0SC9UZ3h6cElU?=
 =?utf-8?B?dGdxR3diMW5IL2sxTU9XL3o0L051U3FyYTZQT0UvY0tsOUIzbUNSQTJhMTVs?=
 =?utf-8?B?WnpMUmNKWFVic3BNQ3BJcG1GWnhnRWdIcDJnTTF4cjhrRFFNNko5SlBNWjV3?=
 =?utf-8?B?bE5pTy9WK3VTSjJjUDNRRndYWHdkbUJvaWdrM1dCOEk3d29pSnBlSW9yNUtQ?=
 =?utf-8?B?S3dHZEZ4d1grYjFYVVNWV3Z4dCtuVGFNSmJDRnJxRndWTlFReG9mWXNtNmgz?=
 =?utf-8?B?RXpGZnp0SHZPTlA1OFVZUmVHdVBpYWNiMmlHQlFjbnFRV0dBZXdTMEF4VGhv?=
 =?utf-8?B?QnRWcjdlaEptMFVMY1FtVlIrMHI0N0ZXVmtxMXVSZ1BwWVdnR0JJeCtpY1V1?=
 =?utf-8?B?VWVEa2ZzcXJ2ejlVUzVuZ0FmMGFNcDRZcTlxTDN5VlgxNG94K1cwTksxWVo1?=
 =?utf-8?B?VGlmWkdaazdEeFNvWTFJVW1MSlBqcmc3Q01LQ3doeUtEVHFEampwOUJPeTB5?=
 =?utf-8?B?QzU5NVZuc2xiNmZudzFrelNMZGtkZTBZbE1URzEyUGc2cm5QVFU1Uktudkxj?=
 =?utf-8?Q?Q0bS+w?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXdTMkRUdFF0ZnIzbythSXFTOUxOSWFtNFZUQWVqeFE3enBsZTVNRkU1T2NK?=
 =?utf-8?B?R0c5TEwyTVZwYnBtVFFIMFNibnQ1dHJGRDNDSGFhTjIxRGxsdm9GbzFGeGtl?=
 =?utf-8?B?R3hKVW9pb3ZUTDV6NVRqdFM0NDJIQ1JuMDM1U3M0NmNsV1hoVEw3ZXNZZll0?=
 =?utf-8?B?aEZPbi9jMnlTM0R3Q1BDOE1VU2sxc3gxR0d5djJNd09xOUFJcjBuTEFGN0Vw?=
 =?utf-8?B?MFRUK1VCL1FRaTlzYUJUTEt6d3RFNW1aQXZRdERqVlNrRmIrWDVLd1RPVkcy?=
 =?utf-8?B?WmlQVkVRVmdscVJoWlliM3Ryd0RicVZxL0JNcGxsTlJ2ZWUrby9MOGVlLzBt?=
 =?utf-8?B?Z21BTFVweDNrTjZ3RjZVYzVpYlZ3dmpEa2QvRUFjbjU5UkxxdnZPL2NXb1A1?=
 =?utf-8?B?dXNjekplR0ZTeUlCbWxTZ2tBN3Z6VzFPMENzQUc2aU9yYXl2VHlvN3AwWGpp?=
 =?utf-8?B?d0JVZG1lbldGZklmRVlaWnVja05iZGxITVBlc0cvMFhMOGdjWmIrQU1oWldN?=
 =?utf-8?B?RUFGVms1dSsxZ3hVdmovQU1MSnZvTTNBdTlGSXBMZ2d1eWhVa3ZOSzljZ0Vo?=
 =?utf-8?B?U3oxU3NXWjlFMU9RLzRUMERrc2dxL1NpaDBjbGZGWEZQZjFUTTNyQmJVWHdp?=
 =?utf-8?B?WG5GbVNENE5FYUcrbUMyRlM5VjRFWUdySE1YMHFoYnVtWERxNXRhYlpnR3JZ?=
 =?utf-8?B?NS92ZkUvTnBPQ0dqdWtVM2FOUkFCZWNFY1hBN1FBanNnbkEyU3lEbWZjbklF?=
 =?utf-8?B?Z2l2VGNoZVM4Z2Y4bEdXQlk5Q1Y3dXc0d0FPYnBvcTJSK2xPa2Z4ZFhSTlpT?=
 =?utf-8?B?NGVQSUZVbWgvcGpwd01kTWdmM0MyQnUyZGEvV3hWR2VsREhuYU5vdUUwUDZv?=
 =?utf-8?B?d1p4d25oZkpyTzU4RERCUFhBbnUvRmpnb2tVNVZRUk43Z25lbzQyRWh6cGov?=
 =?utf-8?B?T3pyVFhJbWJ5ZTZoUXB6TmpUREY0MkMrVGsydEM2d2d6cTVlQ21ocFRKYnJL?=
 =?utf-8?B?NTVXMXIzQnQ0UElZb0RrMjRoTHZwcGNJV0lqM1JreHFsOU42UDJtN2gyVXBu?=
 =?utf-8?B?WlF1VnE4MVlNTEFyUk41cFdQaGg4WjRBVjNPQkxQSU96ZE9hOXE1WW1lNkU2?=
 =?utf-8?B?VUNtSzIxam5qUk1nLzE1M1FEbHAxY2JteEN5dnQxTDFxN2M4SVQxai91ZEJZ?=
 =?utf-8?B?TE5TUS9VWjMwS1BXWDNOWjB5NzNwaDN1NTZ2a0p1Mlk0V0hvVnQ2WWxRUWgr?=
 =?utf-8?B?aUxYcHF1b3E4cXpEU3FpVXFsUjFBcTlKd3Z1d0FvaEN5aDIwMm4rSjNQeTh3?=
 =?utf-8?B?NGU1bEVCcForMDhXdVlOcXY2MStnWWtvWGxGQjMxc0s0dWtEWnBsOEVTZTNy?=
 =?utf-8?B?SHdqZjFNdFljMXRaYUFjdkdpaTRDdWROd1hFbGxLTFUvM1hpNi9zeHorSVF6?=
 =?utf-8?B?ZkNsV0ZTSzJNb0hBcm9XL2I4WUhDd3lxQS9uUDVOSXMxenY2c1VuRU0vdm9O?=
 =?utf-8?B?eThpZ2E3SERMMnh6QU8yVTY3U2xreTM3Z1NmRXQ2ZmVJODl0T0RuNjB3NEFs?=
 =?utf-8?B?T0QwcnI2UGkvdnVjSWFTckZnNlpSWnM5a1VCZXJSY0hxMVdULzQ1M3Vnd3hC?=
 =?utf-8?B?ZTdUQ1k3NXdiT20rSjlFU1VHZVZzSFlrRVErSlpZTmJvei8xRnBRNkVPeXA3?=
 =?utf-8?B?MXdTOWMzMzVpcTFyYTU1bDRSanRZT25nM2xzb3JnSVFkbmUwRFhJRlp2UTN6?=
 =?utf-8?B?NkxKU20xRjNvTmdwQVNVbXFRM3lLTjV3dlVGek5KNDdEa2tBbm1kVnpHOFZ0?=
 =?utf-8?B?cm9Qc21UVGcydVV4WDRocHZ3V3VKRnRONWJsd2FKN1hkV3VjTWdIVFp3OGlR?=
 =?utf-8?B?SW9BMkR5TzNhOTRCWWpLODBndWtURjlCL0RkSlpkNU1lOWVTdHM0eCtZS1h6?=
 =?utf-8?B?eUFXbXN0MjBvd2hzTnZLSUg2WnEzdlBWb3lOeGZGZnVuMU5IQ2V5QnhnY01H?=
 =?utf-8?B?NXlqQm5ZNXJlRFRWejlJNkJER0tKbi81TkxsOEZBUjgvVTdSWHFUSWVBTzhS?=
 =?utf-8?B?ejRVWS92Z0t6Nm8yTEdVV0hzUENWcytlOWZ4em50TmhLaTVCTGdqR1VYVmZM?=
 =?utf-8?Q?jdV8Ii3JsHTvMrqHpDH1ut57D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ede685-2bae-4377-3a03-08de107a0af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 08:15:48.8005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7P4a6Qo0KPOgyAB3G81splaBRAJAFt2yBx6XPXjCIqdPqonZhGf41ImaoqJtFfGBoOhBDxTzUUs/zTg2PTLDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQpIaSBFcmljLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEVyaWMg
QXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4gU2VudDogMjAgT2N0b2JlciAyMDI1IDE3
OjQ0DQo+IFRvOiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFl
bXUtDQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZzsgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IE5p
Y29saW4NCj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IGRkdXRpbGVAcmVkaGF0LmNvbTsg
YmVycmFuZ2VAcmVkaGF0LmNvbTsNCj4gTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47
IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IHdh
bmd6aG91MUBoaXNpbGljb24uY29tOw0KPiBqaWFuZ2t1bmt1bkBodWF3ZWkuY29tOyBqb25hdGhh
bi5jYW1lcm9uQGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOyB6aGVuemhv
bmcuZHVhbkBpbnRlbC5jb207IHlpLmwubGl1QGludGVsLmNvbTsNCj4gc2hhbWVlcmtvbG90aHVt
QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEyLzI3XSBody9hcm0vc21tdXYz
LWFjY2VsOiBNYWtlIHVzZSBvZg0KPiBnZXRfbXNpX2FkZHJlc3Nfc3BhY2UoKSBjYWxsYmFjaw0K
PiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMNCj4gDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gOS8yOS8yNSAzOjM2IFBNLCBT
aGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEhlcmUgd2UgcmV0dXJuIHRoZSBJT01NVSBhZGRy
ZXNzIHNwYWNlIGlmIHRoZSBkZXZpY2UgaGFzIFMxIHRyYW5zbGF0aW9uDQo+ID4gZW5hYmxlZCBi
eSBHdWVzdC4gT3RoZXJ3aXNlIHJldHVybiBzeXN0ZW0gYWRkcmVzcyBzcGFjZS4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0NCj4gPHNoYW1lZXJhbGkua29sb3RodW0u
dGhvZGlAaHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxz
a29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvYXJtL3NtbXV2My1hY2Nl
bC5jIHwgMjEgKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3NtbXV2My1hY2NlbC5j
IGIvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+ID4gaW5kZXggNzkwODg3YWMzMS4uZjRlMDFmYmE2
ZCAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vc21tdXYzLWFjY2VsLmMNCj4gPiArKysgYi9ody9h
cm0vc21tdXYzLWFjY2VsLmMNCj4gPiBAQCAtMzg3LDYgKzM4NywyNiBAQCBzdGF0aWMgdm9pZA0K
PiBzbW11djNfYWNjZWxfdW5zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFx
dWUsDQo+ID4gICAgICB9DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgQWRkcmVzc1NwYWNlICpz
bW11djNfYWNjZWxfZmluZF9tc2lfYXMoUENJQnVzICpidXMsIHZvaWQNCj4gKm9wYXF1ZSwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBkZXZm
bikNCj4gPiArew0KPiA+ICsgICAgU01NVVN0YXRlICpicyA9IG9wYXF1ZTsNCj4gPiArICAgIFNN
TVVQY2lCdXMgKnNidXMgPSBzbW11X2dldF9zYnVzKGJzLCBidXMpOw0KPiA+ICsgICAgU01NVXYz
QWNjZWxEZXZpY2UgKmFjY2VsX2RldiA9IHNtbXV2M19hY2NlbF9nZXRfZGV2KGJzLCBzYnVzLA0K
PiBidXMsIGRldmZuKTsNCj4gPiArICAgIFNNTVVEZXZpY2UgKnNkZXYgPSAmYWNjZWxfZGV2LT5z
ZGV2Ow0KPiA+ICsNCj4gPiArICAgIC8qDQo+ID4gKyAgICAgKiBJZiB0aGUgYXNzaWduZWQgdmZp
by1wY2kgZGV2IGhhcyBTMSB0cmFuc2xhdGlvbiBlbmFibGVkIGJ5DQo+ID4gKyAgICAgKiBHdWVz
dCwgcmV0dXJuIElPTU1VIGFkZHJlc3Mgc3BhY2UgZm9yIE1TSSB0cmFuc2xhdGlvbi4NCj4gPiAr
ICAgICAqIE90aGVyd2lzZSwgcmV0dXJuIHN5c3RlbSBhZGRyZXNzIHNwYWNlLg0KPiA+ICsgICAg
ICovDQo+ID4gKyAgICBpZiAoYWNjZWxfZGV2LT5zMV9od3B0KSB7DQo+ID4gKyAgICAgICAgcmV0
dXJuICZzZGV2LT5hczsNCj4gPiArICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgcmV0dXJuICZh
ZGRyZXNzX3NwYWNlX21lbW9yeTsNCj4gPiArICAgIH0NCj4gQXQgdGhlIG1vbWVudCBJIGRvbid0
IHVuZGVyc3RhbmQgdGhpcyBjb2RlIGVpdGhlci4gSW4gY2FzZSBvZiBlbXVsYXRlZA0KPiBkZXZp
Y2UgaXQgdGhlbiByZXR1cm5zIGFkZHJlc3Nfc3BhY2VfbWVtb3J5IHdoZXJlYXMgSSB3b3VsZCBo
YXZlDQo+IGV4cGVjdGVkIHRoZSBvcHBvc2l0ZS4gSSBkZWZpbml0aXZlbHkgbmVlZCB0byB0cmFj
ZSB0aGluZ3MgOy0pDQoNCldlIGhhdmUsDQpbVklSVF9HSUNfSVRTXSA9ICAgICAgICAgICAgeyAw
eDA4MDgwMDAwLCAweDAwMDIwMDAwIH0sDQoNCkkgYWRkZWQgYSBmZXcgcHJpbnRzIGluIGt2bV9h
cmNoX2ZpeHVwX21zaV9yb3V0ZSgpIHNvIHRoYXQgaXQgbWF5IGhlbHANCnRvIHVuZGVyc3RhbmQg
aG93IHRoZSB0cmFuc2xhdGlvbiBvZiBNU0kgZG9vcmJlbGwgaXMgcGVyZm9ybWVkIGhlcmUuDQoN
CklmIHdlIHJldHVybiBJT01NVSBhZGRyIHNwYWNlKCZzZGV2LT5hcykgaGVyZSwNCg0Ka3ZtX2Fy
Y2hfZml4dXBfbXNpX3JvdXRlOiBNU0kgSU9WQT0weGZmYmYwMDQwIG1zaV9hZGRyX2xvPTB4ZmZi
ZjAwNDAgbXNpX2FkZHJfaGk9MHgwDQprdm1fYXJjaF9maXh1cF9tc2lfcm91dGU6IFRyYW5zbGF0
ZWQgZG9vcmJlbGxfZ3BhPSAweDgwOTAwNDANCmt2bV9hcmNoX2ZpeHVwX21zaV9yb3V0ZTogcmV0
Ok1TSSBJT1ZBPTB4ZmZiZjAwNDAgdHJhbnNsYXRlZDogbXNpX2FkZHJfbG89MHg4MDkwMDQwIG1z
aV9hZGRyX2hpPTB4MA0KDQpJdCBnZXRzIHRoZSBjb3JyZWN0IHZJVFMgZ3BBIGFkZHJlc3MgYWZ0
ZXIgdGhlIHRyYW5zbGF0aW9uIHRocm91Z2ggYWRkcmVzc19zcGFjZV90cmFuc2xhdGUoKS4NCg0K
U2luY2UgaG9zdCB1c2VzIHRoZSAoTVNJX0lPVkFfQkFTRSwgTVNJX0lPVkFfTEVOR1RIKSBmb3Ig
SVRTIGRvb3JiZWxsIG1hcHBpbmcgDQphbmQgdXNpbmcgSU9SVCBSTVIgd2UgbWFrZSBzdXJlIHRo
ZXJlIGlzIGFuIGlkZW50aXR5IG1hcHBpbmcgZm9yIHRoYXQgcmFuZ2UsIGl0IGFsbA0Kd29ya3Mg
ZmluZS4NCg0KTm93LCBzdXBwb3NlIGlmIHdlIHJldHVybiBzeXN0ZW0gYWRkciBzcGFjZSgmYWRk
cmVzc19zcGFjZV9tZW1vcnkpOg0KDQprdm1fYXJjaF9maXh1cF9tc2lfcm91dGU6IE1TSSBJT1ZB
PTB4ZmZiZjAwNDAgbXNpX2FkZHJfbG8gMHhmZmJmMDA0MCBtc2lfYWRkcl9oaSAweDANCmt2bV9h
cmNoX2ZpeHVwX21zaV9yb3V0ZTogIGFkZHJlc3Nfc3BhY2VfbWVtb3J5LCBub3RoaW5nIHRvIGRv
LCByZXR1cm4NCg0KQW5kIHRoZSBkZXZpY2UgZG9vcmJlbGwgZ2V0cyBjb25maWd1cmVkIHdpdGgg
Z0lPVkEgMHhmZmJmMDA0MCBpbnN0ZWFkIG9mIHRoZSB2SVRTIGdQQQ0KYXMgTmljb2xpbiBleHBs
YWluZWQgaW4gdGhlIG90aGVyIHRocmVhZC4NCg0KSG9wZSB0aGlzIGhlbHBzLg0KDQpUaGFua3Ms
DQpTaGFtZWVyDQoNCg==

