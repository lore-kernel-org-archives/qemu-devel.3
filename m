Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4EFC2A072
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 07:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcf3A-00025t-IP; Mon, 05 Jan 2026 02:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcf39-000223-3h; Mon, 05 Jan 2026 02:30:47 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcf36-0006Tv-Ms; Mon, 05 Jan 2026 02:30:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3dPUAjldC79SRdMGmWeeLOtB5V5SDROE51DOwOv9eirRwz4EZ/aR7FfiWQqQ5ZkfBuGEceXB99jk6Ct//7rlf/K5782Qh1zbpzMEHv1jb0tfJvIbOhbKy8xXXgy/hO1bPP0/9FkWrW4XS4sLCKI9Cn6HQV2f3nTmc2Ps+t5y0ZVGnGDkdU8EkVui0Ll86jPpehYntwZxnR0ITcUCUWep+VTvowAoV/McllGe4BRWvqbZj7OeIpwrvxL0Lk5Q7XUvLh+WtGZOa6snc3YTmm9AXtQhXOt0AY4qztJYgyFiOHooJPkyJQe2TzDh2g2QXJOSdBAE2K96nanB3Es8cLfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6bzl029KeuUMkyBTVClZFCGIC1iRY7RoBA/LCEKsbQ=;
 b=SQr3mMsa5NR+rZGWkh4jazxkgfaHpa+x23zz0j8XVkUsHMAv82+eG+DIJ6sgENT8st6lm0M6d3RDhE6KrXy9Y1QB5wWcWsHJC/baDJPAAjhNgRRPR3POEU424xfQi0vvo7tkDtrUllw6v51t6hgKuUJxLZ7ad94GbktqkrgeBLGggCc9fkB04/1CMgx4WgIsVK9V+hcJNMS39GIKsxdn32rNhKrnUmM3qDqN9F33QdraDp+abUlNJ5d+ErBcA0mV+x2qq8FlsZHBZEEftlbj+y2IKidl40FFnN3IaXcPT6vyCeEgLj6O4JGo02q9lWD/SBxZp1NHncXwbH/muOCM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6bzl029KeuUMkyBTVClZFCGIC1iRY7RoBA/LCEKsbQ=;
 b=bMm2ReWhf8QA4lHd+XKvqgDNPU+OL+1+uAYMEqMzznFWYaLCuvF4c5psgLKIduwF1JGOTczciMjX7q3ori4SUQPbr52hxWkbbp+G+MwLemjNI2wf0Pnj3zl+pbL0nXYG1Fs/srrMY3cTX4Ezwc3ykzeAUUywAA5zZQMcZXiI2NKMuNToT7aeGFx6cl/8DuDT6t1z6CB1XksBH0MQ6+Sz4750bEg1NzOa/eUTcEMYyfMa1MPL1lJddeoFPOmz6CbhV/V4zuAjv56r/vtf9eAeteDb2UJqziiDuR9BmdchTSXlBsoBpG527+el2xq3cI/tfOo/iqs0YeHikRgPVyziDg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5626.apcprd06.prod.outlook.com (2603:1096:400:31f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 07:30:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 07:30:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 09/19] hw/i3c/dw-i3c: Treat more registers as read-as-zero
Thread-Topic: [PATCH 09/19] hw/i3c/dw-i3c: Treat more registers as read-as-zero
Thread-Index: AQHb2/a8SuIl9/yLS06y3i/Ko1i6WbVEcmAg
Date: Mon, 5 Jan 2026 07:30:37 +0000
Message-ID: <TYPPR06MB8206E8EF582C96C30A09C3CAFC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-10-komlodi@google.com>
In-Reply-To: <20250613000411.1516521-10-komlodi@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5626:EE_
x-ms-office365-filtering-correlation-id: e01f02cc-d79b-4486-4604-08de4c2c5242
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZFphOExFaUZZVUNyb2hYcTBFa0JKc3BpUVptYnJ3Sk9CZTlsVnNkMnpVWkM1?=
 =?utf-8?B?QlAzK0xpTzhlcDFMMlIwcEwyWUpTUTV0My9ZRlpyZ01iSS9ZUzY1Yyt5clNK?=
 =?utf-8?B?Y05yRGlaSDlzZnFoWUp3NDZYWUFMcUl4RHY5Tm12aUhrUktzZGpyRFN3b1lu?=
 =?utf-8?B?L3FINm9vV2swaUx3Z1NCMzJJdGhXcERKNk9OLzVtTlQzYjl0QlhTNytyZGY2?=
 =?utf-8?B?Si9BazI3aFpPdzJhbDhIY21tYi84MkU0UHZPeHBrS3NHMzNuRUNiNGlsT3ND?=
 =?utf-8?B?dUpxc1YrblFiVHBTbThCM1dvQU9BNnRvcW5VMjJoR3ptQ2lLUjNzZGtET3h0?=
 =?utf-8?B?WG44UHFIZzNQNk5PMkZCOVhHVzRWUitpQmhGTk5vSTVyaUdXbkM4bmptbGM4?=
 =?utf-8?B?KzNpYlZwaTZxQU1TQXNTcEtoclk3Z1lMd0p1Szdjdmx3bTVyaVU4ZzF6RUU2?=
 =?utf-8?B?ci94enJjZWlXRlF2c2p2WStpY0xnaDJFK1dDR2w4dW9vNHQrVENyQkJub2Z1?=
 =?utf-8?B?bnJHc0t4cW9kQUVucDZlamYyVitXUVdPeVdURHJxcXlQazB4eC9QSFR2d0Np?=
 =?utf-8?B?L3VVdUM4bHJzbENPWHZtMzhkY3oybS9jWXhzRWQ0N0VnYWRKR3BUYXl3Ulpk?=
 =?utf-8?B?alA5T1ZxNWt2WUNjeXlscjJnK2JQZ0pjWEd2QnVEdXFOQWNCTUZNTCt1VlNu?=
 =?utf-8?B?MThUdkhyVXh6aWtBZ3cwYkdnbDRNbitvTmh3ZEkxR3d1cjBUcUxqRXo2eUpF?=
 =?utf-8?B?UElYU3ZWN2VvTWtQRnhCV3dWZldYNXFBMXlCKzZ2Nko5eG1kM2FsWDFrdkta?=
 =?utf-8?B?OCtPaTcyc05PUFdvTnBoR3dVTmZLd2Z1dDMwbkErNVBtSkFkRWNqbWJHUWFn?=
 =?utf-8?B?YWZEWlQvVkdGbE9CTzNnYnpqZ1NZZDdwdSswTjB6V0svMDcwT0tvU2JqMXYz?=
 =?utf-8?B?aTJjUW0wR2U0MVcyUUJaR1dFZy9WZWY5MGxVc3ZPZ3FGUDRsbDNMdlNjbHRy?=
 =?utf-8?B?d3BvOXpmaGR6bUpBdDR0UGsxbUZnOXR1WmdDTEVONU94WEFjclV3QUowM1JZ?=
 =?utf-8?B?TWRVOFNqMDg4OFAvTThrOWo3MWxYRytHZDMvWk9wcHhmOHczTnA2eDc5aGNx?=
 =?utf-8?B?djBuNFZpLzgzNm9MQktJdEpZM01teXlQWFM5Yks3THJWSlZ4ZW95dlUwVUZw?=
 =?utf-8?B?VDZOTWJudHZTNjBGWndJYTJRbGlLdG9EdnZwOVBTN2FUYW5HZVVxWkRlZmhw?=
 =?utf-8?B?UUVIcGxveCt2djh1dTBBbFk5UlhzWG90NC8vMEFHU0tPLzhYK0htaUplVDR5?=
 =?utf-8?B?dGdEdUpDT1Q2SnprcVlXZ2RXK0tMeWZIZm1XalcwM3A2eHE1WStPMmVaK2tP?=
 =?utf-8?B?YnJxVUE4clJGWnl1R0E3cnlVdld5UnhWVEhlcFU0Rzk4WHY2U1BKRmlXSSsr?=
 =?utf-8?B?QW5FR0VlWHR2L2xaajhOaTA3aGFxS3c2VndUa2s3MFJjMkx3cFlWN1NxZUQy?=
 =?utf-8?B?NWw1VWpDckVyNnVIMzdWQ2U5ZXpJZFJVaGZseWxubmxWeFpUVzJsbmRjWU1a?=
 =?utf-8?B?N3NNMGFiYnc0MTZONjZDbHRaZGMxMlJoZU9peFlFdUlMNzR1ZElKYld3MjAw?=
 =?utf-8?B?Q25QQjdJdWkvak9tV2NLQ0lvdXJTclo1LzdvT2IwU0lpS25ScEtpS2pXVCtO?=
 =?utf-8?B?eVRpenRFL0lSMzFWcVFFNUIzL0VBcDdnZTBRYmNTU1VDd1h1aVdvVFdweGN2?=
 =?utf-8?B?cnc3ZHdXUS9IUklKNDRvU0hWbitCbUJrZS9hYnh0RUNIUmZHYXpnYk42ajJD?=
 =?utf-8?B?cUNtc0lmTkNIcFRlR25UMEY5ZC9lR3NKMU9zWE11cEludzZ6cmk4ZnFic0lQ?=
 =?utf-8?B?UkFURjJNMmp2OTdpZzIzUDV2SUFNUHk0Q2h0Zlp0MXkxMEI2MjhDdWxreTFv?=
 =?utf-8?B?M1BIRGJxSTVzZzg0R3UyNnFSaHRsLzJSeTJsZ2pBSkIrY1RVSGtPWHdiWG1L?=
 =?utf-8?B?QU02Qi9YaUFoZnJ4bUovc3l2c25FVFQwM1BTSDNRZ0J5TVpiS0NuRUxFS2Vm?=
 =?utf-8?Q?aOPjkz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjcwdFl4eTB5cXFFZXFLM0lVZVMwd2FyNEREbGVnZzZLSHR1SVE0ZWZOeWxl?=
 =?utf-8?B?M3Buem1tTk9iY2J1ckpobDZhR0dQN24rNnpYU2ZjN3ZrRm94dEExMzJyaDdZ?=
 =?utf-8?B?UDltUWpxRGc3eE9VT2ZwdGdINUZTOW9iYXF5cmZHcTVLWXhOdGV6NjRRS09x?=
 =?utf-8?B?dUpZa28xRTBvMzdRRHJ3aXl4ZkprMTdrcDJ4Zy81REMxT2R6RlFSUjh6VWp0?=
 =?utf-8?B?Z1M5bTZaeG05ek5PcDJMaWgvWkxYZE1sTERIZFFJRTMxMW9YeDY3NFVUajgr?=
 =?utf-8?B?UHFTWndpMUNneHVXa0FYQ1VjeW5VYlE5YXlqOXJwaWtqQW12dHlNbG9iMFFh?=
 =?utf-8?B?cW9SSkVXREZCaFNJQTc2ZTFpZjNMSzU1WmoxMXFyNGdZN21QMGhXblY2c2gz?=
 =?utf-8?B?cW5TRms3MTQ2MkhnTzVJUjgyaERQc2ZEak82eGNZOTNWNkRyZ3l4a2ROZ204?=
 =?utf-8?B?Z2gzeTlpVjNseFVGdnBXTlB4ME9oZlp1cHhXVGxHTlpCN1orNUNLYnVtTksx?=
 =?utf-8?B?c3dSdVI4ZE84Y2I0TUIzSDdXSkpaZU9oeEh2dUFtb3RxTjZJSll3Q2dtU25O?=
 =?utf-8?B?KzM2VkFZd0NXU0JiUU4rclVQUitMeEFBcnEwOHdMSis3NC9zcVlGRUs4TGRr?=
 =?utf-8?B?N1l6RUtpWXppallMNGJGeDV6MFBaNU1lMy9ORVV1dXdhTzIvVlZNeWFUbjZ5?=
 =?utf-8?B?TVpjREdmUXduRmY2SzhVYzNMWE9YUW0zYVB3aG9kbG1HUy9iNWVoWituNFcr?=
 =?utf-8?B?OHlvL0RpUmNXaG1Tc1R2eWsvUjg5ekRqUVBqSk80TEpNUy9tU0Q3ZTBWZWU5?=
 =?utf-8?B?SW5DeVpwRUZpSmNoV1N5bDF4SDR1MVdzS0xrZU1ueDllTFRaVVV6UzRZcXJQ?=
 =?utf-8?B?c0xqMU1OZG1jZGRyTWxBcUozb3FyNVVtanRQREZacHdZQzl6aTl3MEpUTHln?=
 =?utf-8?B?VUtvSFVrZG8wM1p4ZzNHMzlIUU5oeXpyd2ZlbzNmd211N2RZek5yK2lmVDQ0?=
 =?utf-8?B?VTllZHp1NHZnWjNLdmJWSVpXaVlxdVJLL0dDZmVVL3RvR2JOakdObkc1VzRZ?=
 =?utf-8?B?S1F6Y1N2bVZPVmZsbnorY3JtUEF1ejd2dDNMQXJVYXFzWUFRTThsYzdvZFhl?=
 =?utf-8?B?UzZVcFhsNjZ1SGY5TlJkdWpOVnhveU45QmFLTmh0eTlEWWhNUTMvcVp1eHJE?=
 =?utf-8?B?YUtQekNWNkdTT2NRWmpFZEZCUWRaUHVKTm1EVE8zUU5kK0Mrd0xQcWZVWVVa?=
 =?utf-8?B?VTRFZ1ZGZEY0cjZEbTdoSEhqUkdqVStLL3ovMW9meVZFNWg1dVptN2Iwc2Js?=
 =?utf-8?B?NHFjUGRiMUd5UGtDTkE4STRSenY5OTRyUFUyb2Yrb0ZvaG5PeWNVRGYvS0xh?=
 =?utf-8?B?cVpGUVBjdFFvc0hUbWt2WWlkZ3lpYmpTRWpTMit2Z0hpcVBIbmt2MkZYOEFW?=
 =?utf-8?B?YW5wWWhLQWJDQ242b0k0YzNVdDFuMDJCN1EyY3VhYkJwOXNKRjZWVE9OUW52?=
 =?utf-8?B?czBidU9wV1YwcXJOVHN5MVdWbk9uZEgrNWU2RzQ3elJwYzZ1RGwwRXR1VkxH?=
 =?utf-8?B?Mm12bDV1ZktPVExKQlFENk1PSSt1UExJL1VHYU5qdENEZGlRODlhVVJxNzBv?=
 =?utf-8?B?REVLd0NBWDIrT2xjdHJhMVJyK0Rhd0FBNHE2N0FNM0hxZFZEdXZsRUdka1JQ?=
 =?utf-8?B?NUI2LytqdHhORk5PV1JzN1J1VzdMcWd2YS9OaUVLTFZxMXM0ZWdkSTQxK3Zz?=
 =?utf-8?B?d1RjcGZVS2NNOVhCQlB4UXpZRWFRbDdraFBxL0hDemFRMlVCSEpUVVQzTlcv?=
 =?utf-8?B?cUk1RTVEZ2FuMzJELys1Z2ozVmE3UVJleHJMY1ZiNFVFZ1VrWm1pRmdGUk9q?=
 =?utf-8?B?NHU1cnlUWFBnUXkzVnVPL3k4a2JaVmtnM0tLbVNtSXRFS3N0Z0NkTDRBSkFi?=
 =?utf-8?B?L01ZSVExSlluak9GQ1YyNWdRRXduOFVPVThlY1JjV0lPc09qS3NINFM0QmZj?=
 =?utf-8?B?UC9DL25tZUNFS3AxMFZkUmtVVmNaQ0JlVzMrL2w1ckNRek1IWlF6UE1Zd084?=
 =?utf-8?B?ekxqOHpiYXN6aGZnVlBlc2NEcEhsOEdyVTJ3NFZJcWFyL1NpV0t4Y1k1YVZ4?=
 =?utf-8?B?RXNUWVlwZEJQSTkyVXMvTUMxdDNSQ3pxMStDenJ5RFpZVHlvMHY4dDFINGJp?=
 =?utf-8?B?dmpRakpJb3lxVXloWklrSUNHYjRjZ3BsTXJ4cjB2eW8wM0JMby9vUHMzb0NQ?=
 =?utf-8?B?OEpyTFBMNWpYUG1xcmx1UXhET2xMQzlIYi9QamNYOTJRUHZuRU1qS3FHMERQ?=
 =?utf-8?B?Q2s0c2E1NDIydDhJUFc0NHQzeEVZS01wTzR6SUFxRXBiWFhXWUFEdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01f02cc-d79b-4486-4604-08de4c2c5242
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 07:30:37.5370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08gLXCntYgsjIF68UUdEFHpqGq1zvAOAt+sHJ9wAXyyylPTu7w0hRHXpv3JLXI+KgZwB8fdfXv3y65Ei75diwMIqHLuoVmT7NcVRRqvxMn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5626
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

PiBTdWJqZWN0OiBbUEFUQ0ggMDkvMTldIGh3L2kzYy9kdy1pM2M6IFRyZWF0IG1vcmUgcmVnaXN0
ZXJzIGFzIHJlYWQtYXMtemVybw0KPiANCj4gUkVTRVRfQ1RSTCBhbmQgSU5UUl9GT1JDRSBhcmUg
d3JpdGUtb25seS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvZSBLb21sb2RpIDxrb21sb2RpQGdv
b2dsZS5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogUGF0cmljayBWZW50dXJlIDx2ZW50dXJlQGdv
b2dsZS5jb20+DQo+IC0tLQ0KPiAgaHcvaTNjL2R3LWkzYy5jIHwgMyArKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9pM2MvZHctaTNj
LmMgYi9ody9pM2MvZHctaTNjLmMgaW5kZXggNGY0MGY5OTlmNC4uYmY1MWMwMDkzNQ0KPiAxMDA2
NDQNCj4gLS0tIGEvaHcvaTNjL2R3LWkzYy5jDQo+ICsrKyBiL2h3L2kzYy9kdy1pM2MuYw0KPiBA
QCAtMzU5LDcgKzM1OSwxMCBAQCBzdGF0aWMgdWludDY0X3QgZHdfaTNjX3JlYWQodm9pZCAqb3Bh
cXVlLCBod2FkZHINCj4gb2Zmc2V0LCB1bnNpZ25lZCBzaXplKQ0KPiAgICAgIHVpbnQ2NF90IHZh
bHVlOw0KPiANCj4gICAgICBzd2l0Y2ggKGFkZHIpIHsNCj4gKyAgICAvKiBSQVogKi8NCj4gICAg
ICBjYXNlIFJfQ09NTUFORF9RVUVVRV9QT1JUOg0KPiArICAgIGNhc2UgUl9SRVNFVF9DVFJMOg0K
PiArICAgIGNhc2UgUl9JTlRSX0ZPUkNFOg0KPiAgICAgICAgICB2YWx1ZSA9IDA7DQo+ICAgICAg
ICAgIGJyZWFrOw0KPiAgICAgIGRlZmF1bHQ6DQo+IC0tDQo+IDIuNTAuMC5yYzEuNTkxLmc5Yzk1
ZjE3ZjY0LWdvb2cNCg0KDQpSZXZpZXdlZC1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVk
dGVjaC5jb20+DQoNClRoYW5rcywNCkphbWluDQo=

