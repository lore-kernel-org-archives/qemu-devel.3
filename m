Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6B9CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 01:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ZEt-00079i-6M; Thu, 16 Oct 2025 21:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v9ZEl-00079R-UN; Thu, 16 Oct 2025 21:26:32 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v9ZEi-0006in-Bj; Thu, 16 Oct 2025 21:26:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWx5M/Y+6YFh22X4kEPbb8/k3x5seFnGsk2yKFlG5zXJyTRTuogzEjhBr48et3kZjCqZyeeZ+Dth8+2x/zWClTSMzwzO2t2ftAZpF3ElaGUNwRKD/KZP3WQv4okJUI+7sE1F1s+FDpPyQhqfZXhRFO/ur8FjmkzU17f3IHqFWCL9jfKMbmfGwztuwse4Ja3adxNq/eIwmdqTx5SKftx5kTUWH4QvyUQcWMVR2wyrbROxXvsxX/eVVVf/xFtvokZU2yH4dNX6z0X4sMbzh8om8HvHQZs8XPY4wQcS7ZDYFPpbSDY1Jgr0RtWA8zM/HyQr3Bb/AgYH1IvpEsOvTs9mww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoUn9BrJvXJzixdSgpvzzHcmSSx2tLPuWTx8mbOKIe4=;
 b=nDg+/72bCOA3BP33HVWMQKCZvLBzUlrPTYenitHkkyef1LwrjYHt+dCPAGVmD3tb3/g35ZM8+Cdx0Dub2XLIRqwsgMt0OXbsEChq7Z/HPQj9hvj3sNUTUAH7wshMf+7b0DULDMMuY+YbjDV3IKbja2Oz2Fk/mYulKEXIRQlGAba+PTSeYmranPZxkRB6qdcfUPTeCKReIb3QuJMwIAMfwp1qdc/Y9CjPv0FDdust0Q7nRpd/zRNbYawGv0Ao80sFJRZrvA7QhvBLWadPZxWKhv77MOwGFXRJUv+CBcZG5U+x3NfbPWgZb/d5hlPjhQrsSXzfG0h6dwqyhS6jhknpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoUn9BrJvXJzixdSgpvzzHcmSSx2tLPuWTx8mbOKIe4=;
 b=E+XieJQ6ZezscYWbaQMRXpmgI2WIvyVd+BESzPEPGOS1Xtfc0FD+BlKcFDkkeopFLzvmF6zb3/lh8oVPlz9Adymmz9v+YnARpI+8iqL/lu7jt4ZObHcbvMCb/iXLc7Qmfr4alC8vXF0cOJhVPY7dgrW/NBYd4R4rLroNxbWGGw0sRuFvnOCuXTBbCFBPoHS11yVpotWibZN2IFzO0w5hTWpSfcCstZ2CMuwViGJ2s7IOPEWupoOhD8LURFdWgcWjTIjyXRnkVR8Nj9BPxzp1aYIQ5v8Z72ufcSUJtqYcfTnCqvTrwDDv6X23iXG6/HFtuh+iKV7StZWDhQpeXhRpYg==
Received: from KL1PR0601MB4196.apcprd06.prod.outlook.com (2603:1096:820:30::6)
 by PUZPR06MB5601.apcprd06.prod.outlook.com (2603:1096:301:ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Fri, 17 Oct
 2025 01:26:15 +0000
Received: from KL1PR0601MB4196.apcprd06.prod.outlook.com
 ([fe80::13a8:12fc:7753:8156]) by KL1PR0601MB4196.apcprd06.prod.outlook.com
 ([fe80::13a8:12fc:7753:8156%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 01:26:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: RE: [PATCH] hw/arm/aspeed: ast2600-evb: Use w25q512jv flash model
Thread-Topic: [PATCH] hw/arm/aspeed: ast2600-evb: Use w25q512jv flash model
Thread-Index: AQHcPuNQanTYZ8AE3Ue6lXGDud3ILbTFi9vw
Date: Fri, 17 Oct 2025 01:26:15 +0000
Message-ID: <KL1PR0601MB419630D8CEA29D2B0E0FAF44FCF6A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
References: <20251016212437.1046135-1-clg@redhat.com>
In-Reply-To: <20251016212437.1046135-1-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4196:EE_|PUZPR06MB5601:EE_
x-ms-office365-filtering-correlation-id: 2ff065e1-4f3f-44a0-343e-08de0d1c2a62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZzVqTUE4azlUcjN2RFBCUjBET1NFV05kYU1iL2RtOEp5Mk5EelIxS3F4Z0d4?=
 =?utf-8?B?cHo5VlJUNmxURk9kcWc2ZC9XaVZKUUJoUjBCY2V6R1U5TGxrangrZElnWU5y?=
 =?utf-8?B?RHdHTlhnaFdqNzJIRnM2RFNlZW5uZTFxK3JVTXVaR1BlMys4Qi9ZWDdiSlo5?=
 =?utf-8?B?OGVMb292VU83MDdqU3VkQnZZTXJGNWJISkVNdllVdmFOU2pBM2w4RHR5dkRL?=
 =?utf-8?B?aEFhWnRmNndUTkNrQ3l0dkRPTHc5R0p1WXI4ZXZmdE9DMHBsOTFNOUd0ZkU1?=
 =?utf-8?B?UmgrTFpybHdUN21ZYkg0TU0vT1R0dHFTYkh0dHNVejhnRFB3QkNieFg0OE5S?=
 =?utf-8?B?MTFOTXV6M3B4Zm05Ynd3RnBZK0QxNjFoTlQwNG4yVE9YV09hUGQ3aTh0c0lM?=
 =?utf-8?B?ZVJZUVN4MXo2cjQyeS91YlFIcWVrQVByS2xaTldjdEJHQjIrMXJVRFFqcVUy?=
 =?utf-8?B?MHlTUEthanJ3MHIyVkhkMWdBZWtjVFlGYmlFdHQ2VGNId005K3g3MDNUZWVT?=
 =?utf-8?B?b2VEYnljWU51V25MNUVGS01PM09DRXFyL1lTN2o2T3ZtQ3hISDBVaU9RMHhl?=
 =?utf-8?B?ZlVROVFMeHlHMkdwWExhQ24yeThnNG56TmdtOWtManQ1M09wWFFhZzVLVGd2?=
 =?utf-8?B?Y0kwVGZoOXJMWUtjOGhXNC82YUtXUmwyaVZRdGVXUW04djdxcVNkNHZMQXZx?=
 =?utf-8?B?d0RRSCtmK3F4a1V0SUR1QUtkYzVvN1k0ekZQUEpocEJrbFkyRU1KUU04SVJn?=
 =?utf-8?B?dEVvSnJlTmFhNEtKS2FoajNoajdIeE9PemhSY0lLTncvWU1mYy92V2N3OGJ4?=
 =?utf-8?B?eEZuSytQcU4vaGNSeVY1MjI1VXl4bGpRdnFsbVlDekpsWXk2SWsvRTdQUDZr?=
 =?utf-8?B?aVNVUkdYMzVJelFvMXphZWd0aktXeGdUSiswNVl1QUxTYm5hb0s3djd1aEp2?=
 =?utf-8?B?WDZ2ZlV5TUdZSGtFdjB4K2NweVZQeDJBZUJDVTlaRmYwZEtPUUVicFlXZDN4?=
 =?utf-8?B?UXpRc2Z1anRTQ05kekx6VUdnK3R3UGQ5Vm1aM0NwbnoxaGl6bExnNTI2bDNT?=
 =?utf-8?B?ZklMZm5XQzF2OXF4aFF5d0lZQnZ1dnliMGpRdXd4YXZLM0NUZHptMGQyeS9W?=
 =?utf-8?B?eTFrcGlabjhiRUY2a2hoOUVyTUFnT2dvUEJnZTE5NExMeHJzSUx4Y1hLWUNo?=
 =?utf-8?B?WE13M0NoMXZ5Sjh6bStLOGhmdktUVlkrK1ZFZHhxUGpFL1NMeTlUT3E2N0Ux?=
 =?utf-8?B?NWZOKzRlTk5KOU56RTk3cWZvM1plWGc3cTFjUGdVVzNGWWpkUFg0WUJxRUJ5?=
 =?utf-8?B?Z3RrQk1EN2tDOW1pRFcyODRic1lndTNWNDZON3VDU1hUY3ZlUEt3V2t4dW5J?=
 =?utf-8?B?NXJudUJrREEzV1FTMzkxSDRUQWZjZjExNS9yS1MrWUZEMGN1eHp3eGpwTUsw?=
 =?utf-8?B?eXY2cEpxUnAyY1BtaE02anVWUmpUM2Z0bnQ4Q0Y3QUczYUlNQ0syUkZneU9Z?=
 =?utf-8?B?V0pVVnVJK0VGRGEvZlFxSS93MWVOanhpSm1EOU9ZdktSekdMRCtaOGducmor?=
 =?utf-8?B?TSs1WmhVM3hGcnBhU01iOFVNNEJ0aGxNV2VCZEZJMnFlTkM2RFF2Yy94elVN?=
 =?utf-8?B?RFhISlMySFlDS1Q3am44akZIdXhZY3JDSytTYVJPR1p3TlNBeDNOSmFIV2Rq?=
 =?utf-8?B?Ny9jWkdtcllUbFVGcVh1Q0JnMDl6c3BOcmlUUUFraTg1U2pwZGxDZGRjU3FX?=
 =?utf-8?B?RGs0aFVCTS85TEllZlZVUjRIRDMySFFHRkxRY3NuNGhPWnE5MWw1MFJUWWZL?=
 =?utf-8?B?TmRuLytYdzlBamN3d214RzhxM1lsY1hMdWI3RzBwVDM4MlJwUFo2OVdmWDdT?=
 =?utf-8?B?L0IvQTVQaVZCa0VydThOVEpGVjg5NDdETG5JMm5IWFkreDBvYk1yZVQ1cTgy?=
 =?utf-8?B?bkhhNUJPMUZkQWJvb3JrUXdrbVpOTlgwMEIzWFlWZGdHWGFWTUJTVVFtZzZk?=
 =?utf-8?B?T2RSbUtyR1hjc2NwanNUcTM1MFMzTWJQM0dVekRJT01wdVd0bnNpZGZKbDZa?=
 =?utf-8?Q?w1Czjn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4196.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU02YStzakptdVROWm1XRjJ0eVpLZnVaV010UVhzb1VvQ2FkV3F3RmFpTlZ2?=
 =?utf-8?B?VkxJams2eWFrNUFUTXdPR09mb1lWaE0ySFo5NDBicVRONzRnT2lFbEdFL0Z0?=
 =?utf-8?B?bTRLdHIwUGp2MFZZQ1g2cFRFMndFL3BvU0loQ1hEUU1Ieko3R3JHeG1hNFBv?=
 =?utf-8?B?UHFiS0hLVG5jV0Z1T2djcElXUlhjSXVTRmduK2Mwd08xNGJJMFVGMURnYmMz?=
 =?utf-8?B?Yi85UjVLcTljQVdPSDc2eHZPUnRDUHVqK3A2YlU5OGZQZnljbENsZnp6eWh0?=
 =?utf-8?B?YlYxMnlUUVZ4bFY2cFI0NWh6SHhKa2tLTHZhT1VHMVJNbUdjZXlacC9wdkZF?=
 =?utf-8?B?ajhFdENoQmYrYlVVcHJJWHN4MWMyaTBRZC8yMnFYY0Jiai9CWjhWSk1ybCtK?=
 =?utf-8?B?YWZBaTZWSnhoaWoxd0pTb1QrOTRKMStkb1pJMDhENng4cC9URWdLQ05JR1B6?=
 =?utf-8?B?bEx4WHdhREpVM1BOdkp5Ykp3L2JLRk1nMVZsMnBVN1YvbTROZ3NyNHloVkxt?=
 =?utf-8?B?YUxEZElmajQ2ZXpLR1EyTmFwZzRZMXhKMUF3OUcwVktXM25jSlVGTVdDbGto?=
 =?utf-8?B?M3BuUXljN0tjdks3a0UvUTNyMjdXdHY0RUhVc3UyMXM3WG5OMjBUNmY0SGhE?=
 =?utf-8?B?QzhHc3QyZW11SnlJSW04Z2VERDg1alV4MG1BZGhMMmRIWFl6bFh5T1BOckx5?=
 =?utf-8?B?OEJ0UUFMSVFiTC9hZHNpQzFPcXhVZGNObmZzUENkd1IxTGNnQW1CTHlkNTRJ?=
 =?utf-8?B?TkhwY0lkSHNmNWpGMTZXSDk2TWVmSnd5bldnMGxRNTBzT2FnUXpFN1o1VGVj?=
 =?utf-8?B?dUZKVnNIRGw3V044VXM4UlBmU2htb0pYQXV5M3ljWXllKzVWcUdjMGVTTmRB?=
 =?utf-8?B?OS9iMU9JMDYwS1F0Z0Y4YWp3dDdJb2E4YU81Rk45SHlDaFROWGpEM2FpdU9D?=
 =?utf-8?B?OVNGZytMTTRhYS9EWXNjTWR5V3RUOUw5ZThYZ2dwSHI0MzllOWxYb2VHOGIr?=
 =?utf-8?B?MlRzWEVsNlNiWno3Zk9LbUl6d2V4U055QkZYSGFTSk96dFVaaWNXK3J4emll?=
 =?utf-8?B?c0N0R3dKd3FYeVloS1dYbldhRmF2S2V5VUFveEdPUTlmNTBNcUUrdXZtMVEx?=
 =?utf-8?B?YjhJZzN1c21oSFViSndUTitwemphTGExU1V1d2R6amJLcENWSXZPZWhBczZl?=
 =?utf-8?B?THFIUlBFaStJUzJhYXdQTHNlSlE0S1lmTmdkelpBRjRXNFUvd2drcC9UWXo0?=
 =?utf-8?B?dC9McWZoMFJad08vcFQxekxsYUxXU3J3OWd5RlVDazJ1cGFPRHJrMjIwaUV3?=
 =?utf-8?B?ZWUxVXRxWC9oL3BIekRvbWNsUjkxVHVTT3p4bDV5bmtLRkRKL0xZZUlKNUEx?=
 =?utf-8?B?bE9leEZBUWNoMTJxWDBhR3VCckpYR1dnSXJJVDVpM3BFeVhES1lLaDJuUElO?=
 =?utf-8?B?QjJVd1JMUFRid1lYcHNDYUs3NlVZenVBWUFiRU81cTRoQkJQOGVKeFdsdUtX?=
 =?utf-8?B?S3NlVFVROExieWtkSTVxMHBDdHU2MzJlL3BOa1c2U2hZNTNsQ3RCNE9DVkla?=
 =?utf-8?B?VzRETk1NQUhlUnRYQTF3WnlLdmlGdDUwQUpuOGFBTWw1L2U0UWdOcnczNHdL?=
 =?utf-8?B?djk3MnBDaFhMRFZQcVBDVWxIZGVsRHJTTkY4MHh6bjJVVUNZaTVFOWtZYXl5?=
 =?utf-8?B?Y0EvbGZCSlNoSEl1Wm1UbjlvaGdCdzArZXJEOWllNDJoaFBTTVRtM0lPZVhJ?=
 =?utf-8?B?R09iTnIxVjBMNmdFYUhRRGpzNHUzMGlLMm5scFBWR2JRVmdtRk4yUCtxM3Nu?=
 =?utf-8?B?cDZwelVDdU9uL3E3YXJpQ2ZCRTZ0bjNVYkZtWUpJbE5mN2ZQTkRDUFVZa3o2?=
 =?utf-8?B?Ukw3WG9TZEdma2k2dUJ4K2NtRS9qZGVKV0dNQUZBWk1qTWw0T2puYzVQVTBI?=
 =?utf-8?B?L0pDdThJMjQ2LzIzUGZ0Q2RXMUxRNUZNcUlBbEZvVXEwbFdITGE1R3FWaVp0?=
 =?utf-8?B?OSs0UlMrSENoV2IwVkZta09qWG9uRlNpVWxjZmg3OHV5RDZOTmUwTVNHWTJv?=
 =?utf-8?B?MmxaMU4xRGtscW5sclQ0WndRUnVCQjJ5YUVqZE9FSFVnNGNNUzNHclE4K2gv?=
 =?utf-8?Q?AfXUG3WEqa4q9oZOsxQzTd87U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4196.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff065e1-4f3f-44a0-343e-08de0d1c2a62
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 01:26:15.3573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wpFTr4+z57Fc8+SXNIu7XtMMb4dbWDjdpo+YfDJaCdXK0SP7jiV8nAKe8x51LEidainfx3NAJgOH8OuP/uA2m5ZsovZJ846wTkcZB98A8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5601
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PiBTdWJqZWN0OiBbUEFUQ0hdIGh3L2FybS9hc3BlZWQ6IGFzdDI2MDAtZXZiOiBVc2UgdzI1cTUx
Mmp2IGZsYXNoIG1vZGVsDQo+IA0KPiBUaGUgYXN0MjYwMC1ldmIgbWFjaGluZSBtb2RlbCBpcyB1
c2luZyB0aGUgIm14NjZ1NTEyMzVmIiBmbGFzaCBtb2RlbCwNCj4gd2hpY2ggaGFzIGlzc3VlcyB3
aXRoIHJlY2VudCBMaW51eCBrZXJuZWxzICg2LjE1Kykgd2hlbiByZWFkaW5nIFNGRFAgZGF0YS4N
Cj4gDQo+IENoYW5nZSB0aGUgZmxhc2ggbW9kZWwgdG8gIncyNXE1MTJqdiIsIHdoaWNoIGlzIHRo
ZSBtb2RlbCBwcmVzZW50IG9uIHNvbWUNCj4gYXN0MjYwMGEzIEVWQiBib2FyZCBhbmQgaXMga25v
d24gdG8gd29yayBjb3JyZWN0bHkgd2l0aCByZWNlbnQga2VybmVscy4NCj4gQWRqdXN0IHRoZSBj
b3JyZXNwb25kaW5nIHF0ZXN0IHRvIHJlZmxlY3QgdGhlIG5ldyBKRURFQyBJRCBvZiB0aGUgdzI1
cTUxMmp2DQo+IGZsYXNoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIg
PGNsZ0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGh3L2FybS9hc3BlZWQuYyAgICAgICAgICAgICAg
IHwgNCArKy0tDQo+ICB0ZXN0cy9xdGVzdC9hc3BlZWRfc21jLXRlc3QuYyB8IDQgKystLQ0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZC5jIGIvaHcvYXJtL2FzcGVlZC5jIGluZGV4DQo+IDJl
NDM4OThkNjQwMy4uYzI5YmJkNTQwNTlkIDEwMDY0NA0KPiAtLS0gYS9ody9hcm0vYXNwZWVkLmMN
Cj4gKysrIGIvaHcvYXJtL2FzcGVlZC5jDQo+IEBAIC0xNjEwLDggKzE2MTAsOCBAQCBzdGF0aWMg
dm9pZA0KPiBhc3BlZWRfbWFjaGluZV9hc3QyNjAwX2V2Yl9jbGFzc19pbml0KE9iamVjdENsYXNz
ICpvYywNCj4gICAgICBhbWMtPnNvY19uYW1lICA9ICJhc3QyNjAwLWEzIjsNCj4gICAgICBhbWMt
Pmh3X3N0cmFwMSA9IEFTVDI2MDBfRVZCX0hXX1NUUkFQMTsNCj4gICAgICBhbWMtPmh3X3N0cmFw
MiA9IEFTVDI2MDBfRVZCX0hXX1NUUkFQMjsNCj4gLSAgICBhbWMtPmZtY19tb2RlbCA9ICJteDY2
dTUxMjM1ZiI7DQo+IC0gICAgYW1jLT5zcGlfbW9kZWwgPSAibXg2NnU1MTIzNWYiOw0KPiArICAg
IGFtYy0+Zm1jX21vZGVsID0gIncyNXE1MTJqdiI7DQo+ICsgICAgYW1jLT5zcGlfbW9kZWwgPSAi
dzI1cTUxMmp2IjsNCj4gICAgICBhbWMtPm51bV9jcyAgICA9IDE7DQo+ICAgICAgYW1jLT5tYWNz
X21hc2sgPSBBU1BFRURfTUFDMF9PTiB8IEFTUEVFRF9NQUMxX09OIHwNCj4gQVNQRUVEX01BQzJf
T04gfA0KPiAgICAgICAgICAgICAgICAgICAgICAgQVNQRUVEX01BQzNfT047DQo+IGRpZmYgLS1n
aXQgYS90ZXN0cy9xdGVzdC9hc3BlZWRfc21jLXRlc3QuYyBiL3Rlc3RzL3F0ZXN0L2FzcGVlZF9z
bWMtdGVzdC5jDQo+IGluZGV4IDUyYTAwZTZmMGE3ZS4uNTBhODdlNjI1MDAxIDEwMDY0NA0KPiAt
LS0gYS90ZXN0cy9xdGVzdC9hc3BlZWRfc21jLXRlc3QuYw0KPiArKysgYi90ZXN0cy9xdGVzdC9h
c3BlZWRfc21jLXRlc3QuYw0KPiBAQCAtMTM0LDEwICsxMzQsMTAgQEAgc3RhdGljIHZvaWQgdGVz
dF9hc3QyNjAwX2V2YihBc3BlZWRTTUNUZXN0RGF0YQ0KPiAqZGF0YSkNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIi1kcml2ZSBmaWxlPSVzLGZvcm1hdD1yYXcsaWY9bXRkIiwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZGF0YS0+dG1wX3BhdGgpOw0KPiANCj4gLSAgICAvKiBm
bWMgY3MwIHdpdGggbXg2NnU1MTIzNWYgZmxhc2ggKi8NCj4gKyAgICAvKiBmbWMgY3MwIHdpdGgg
dzI1cTUxMmp2IGZsYXNoICovDQo+ICAgICAgZGF0YS0+Zmxhc2hfYmFzZSA9IDB4MjAwMDAwMDA7
DQo+ICAgICAgZGF0YS0+c3BpX2Jhc2UgPSAweDFFNjIwMDAwOw0KPiAtICAgIGRhdGEtPmplZGVj
X2lkID0gMHhjMjI1M2E7DQo+ICsgICAgZGF0YS0+amVkZWNfaWQgPSAweGVmNDAyMDsNCj4gICAg
ICBkYXRhLT5jcyA9IDA7DQo+ICAgICAgZGF0YS0+bm9kZSA9ICIvbWFjaGluZS9zb2MvZm1jL3Nz
aS4wL2NoaWxkWzBdIjsNCj4gICAgICAvKiBiZXlvbmQgMTZNQiAqLw0KPiAtLQ0KPiAyLjUxLjAN
Cg0KUmV2aWV3ZWQtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KDQpU
aGFua3MsDQpKYW1pbg0KDQo=

