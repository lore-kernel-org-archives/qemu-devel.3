Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10405E78D6F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNO0-0004dK-Ro; Mon, 09 Feb 2026 04:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNy-0004bu-GE; Mon, 09 Feb 2026 04:16:50 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNx-0007IQ-03; Mon, 09 Feb 2026 04:16:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiVRfqYvlZuiKYhGoDx8k2PGkm5AGsuv4ZeqvMXaddETPwHJumH+LOVLIETlMNEL86kTT0ooxqVuSdDhtAIXP9G5sinhdePn/OYey8CmCaT4nvGjriMvpLd7LZ4B6BfddZRgfIsg6/yo6cXsqjOzBMjp0bpZOXeBhU079PqQiv5WOzVpbl1YPUvcPnD19AFxC+DxXjSwwdqXM1JaU10IZT8LLodV+uU9GcN3CBKDFASW3omKKuLF1sIqYnJl4jzJtT7Bbj7fiLHKKKAu5z5SbHrtfPSypWELmZneYCLS9YBPShSUc/DbuKN/ITBimMV+9PhQlDsytpmawKM97RSMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFNpvQmJgU/MNNVFYDwowDj/6XW8Tcab75KtfEOSnsI=;
 b=ybhEzgRD3C5QFCsVgBI+/fybYi1uQArlUj71CIQ+n1kOqRQtWK+eGvUkQXMlaYciVmhr6CXf20dbpBKkvhB7rFvHEkewr3kbWuD2Mp3rZkjnXdlWvimPTwf8klRdJvPjIVELHZT+ksVGUIBBgUsZS7A9qqSj52OkGAFeTPxWolfXjUcr3kMUzdEBM0FHTdd6I/1NFB8xKHA15iBAqMoADyVZwy/VAUPyU+4aRgyYlHmIOVUTN8A8xzpC3rEU8USwDp6cBicg2JAEEjz82bof7BfUMSGPyPSP/9oAJiL28c/1+AE+YXUzjmR+Jcd44G72f1JGGiR6vtSZ5xmR/1UqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFNpvQmJgU/MNNVFYDwowDj/6XW8Tcab75KtfEOSnsI=;
 b=bBgW2KFrn0LvAhc6TeblH040p9Wo4W/n73vVDvzdoN9sFzSM2AcGIer/bE4xLLNjDluWW17t5s1jOX57STIog/enSmRcnnesErr0uOqB7cai+ZyHJ9+neuJM0rlb5dmyQE2EeISZt03J8BWyW1Qd7ICHzw6ASL/D+J9aLxTm8wXhmr4SzpM+bfY2zzuWFvLMXMrw/8gNiq0wz+C2afG9cn6tW+FDOBTm3o6KPVJjGAV4GgMbYzTwc/1zsFOWodvXwWAKKmzJyqLvB0g5KIyj35lnUyLD3U0OtTR3IOgbCInGHtrI4V4XSCl0fDrtsRSu6ONFwJrmYNvfcFpWWafyZA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5784.apcprd06.prod.outlook.com (2603:1096:400:268::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:38 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>
Subject: [PATCH v4 05/20] hw/i3c/aspeed_i3c: Add more register fields
Thread-Topic: [PATCH v4 05/20] hw/i3c/aspeed_i3c: Add more register fields
Thread-Index: AQHcmaTLSpvWPHH24Ue9OLghP8E5cQ==
Date: Mon, 9 Feb 2026 09:16:37 +0000
Message-ID: <20260209091629.823457-6-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5784:EE_
x-ms-office365-filtering-correlation-id: da754df4-9621-428d-7c10-08de67bbeda1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?C+1N3mImFEGnhciPBXPntPX4Lv+LYs/1HtU4JDo/tjCd9fIvl5lqfNXSn2?=
 =?iso-8859-1?Q?jtGQlgRW6RljXxOjmOaC2suS/ghkcEEgTvZZ6i+igBy7+j32Y0UNJwyjax?=
 =?iso-8859-1?Q?vAN92gNP4hrZhe9cn3P9xHqojOxvTH9txOf4pAC7W5CPuwqmwm/aucebV+?=
 =?iso-8859-1?Q?xDUC6ajS2txitsn8zijlhq+5yKMnwdQLu3gQ3CXeaf9S7NTY0zwJ2U2jtj?=
 =?iso-8859-1?Q?Rhmbu1zgGMGdNRiHkauf1Cjz6oDCN0Xe2y5pKLjoHVyBHfKQbCCoZRIpXi?=
 =?iso-8859-1?Q?X9+z+T+Nijnw8mKvzhRLqui5bhvqqX0Fwvwy0jWBff85Z+5fkxmO8jddbJ?=
 =?iso-8859-1?Q?ejfXLIfOIzNwCBdowum9zg4OXKx3NDW3t7HLMGfuDcQP4fkK7aHUTIWR4q?=
 =?iso-8859-1?Q?SV53ZKQ/ZCdHk4vZ0OpVZTe2adyFMDl+dpG26wiVbyfW4ftTWXrau5Usuz?=
 =?iso-8859-1?Q?bxQ4KK4/xvcvNNdPbYjARRqH8MGDkLMwaB0ByDV6H+EcCboureezLSo3jb?=
 =?iso-8859-1?Q?zbrFs+4XOOThIiIclTJsaqUf0HYczLlh9bbabn5y0esGvlgHHj10Aq/ysa?=
 =?iso-8859-1?Q?Bq3oFduEm4pwe4qOLbu+9HQdN+rRclsJSPRWnmtLxYBorVoJ/PMXVXL+H3?=
 =?iso-8859-1?Q?YZVVcy40gjbZ4UyItaJFErLiMn4H7Ie/d4jb8Rwm7q81/Qx4LjKyx94t9o?=
 =?iso-8859-1?Q?9Os3wHjBMNGwVk2K9FoGayovgeoONvD0x/8sIjuKRpUAM3NmS/ifyZ35Ui?=
 =?iso-8859-1?Q?cSw6tLeL9kke54QyHVy6yVHjIAnW2sAR3edmG52sHXOs/HFbo6kSoHf/Qh?=
 =?iso-8859-1?Q?Rt3ZtPrX/w3ZVZNceU6XFq4iPm6UlMcMRjW/w13GoPQcMgPHsyhR/Ogcvm?=
 =?iso-8859-1?Q?tnMGiyoeDd3Mf7JLQ41IeLg/vu76+vnVa3owBTpf9/CF2ImSgVqIp48Mfn?=
 =?iso-8859-1?Q?hCSh1sfPbt5YdsOY9ygkaHdTnCo72Agyqy+lHl/Z6vFpEMbkok7kD0OZWn?=
 =?iso-8859-1?Q?QasTj+EhMwX9QEhx9ar0xAWtHDaHiRLxf+wyF6ny/jAiirBSIprqwwXCzd?=
 =?iso-8859-1?Q?TRFliga1ezhiGSrnlsI+/pZ0EJ/T/jbTjhFs/VufL0s2wpTEpA+JmaSTbm?=
 =?iso-8859-1?Q?qkHVfGooZvql9NIYKHDgmn1u0UzGRfkFG1h1vUGYpKaLhZQcPKIVQI7aOL?=
 =?iso-8859-1?Q?jQuF7PVYj+1elZX9qpdqG1GGTH4QSLLaXk7FH16IFwC/W5DDSVFuURXBmV?=
 =?iso-8859-1?Q?N52cq8cEJDqEjyzmwg2RwBeAnx8CeyyeNN4LgCwr8+hLTe7lkxRIqO+p0x?=
 =?iso-8859-1?Q?VsTXjwIIaanCloFYbrcJWMC2APrjNIrtPzboJmzeTbb2OPOnjFcab45SA3?=
 =?iso-8859-1?Q?kkEqA4ITs/S5buKz2noJVcAxIxT46YzXIhgHn6eUc1QNy2PhjSvIIGNj/g?=
 =?iso-8859-1?Q?X9FrjeavSjqDQwZJLl6J9kmeMoi6p8LQlCxdbWNQ6a/B1FGEs1OtiXIznm?=
 =?iso-8859-1?Q?/PILq04fT5Yifk51Jj8noRqitI5sadvAX2XSprj3YJyPvvr9EgZxqVaA48?=
 =?iso-8859-1?Q?tBtOV0B5nfF/W56qSkAXDbHipBiiwWw0y/XpUfwwTg/MP0g95znKCxZz8Z?=
 =?iso-8859-1?Q?Iu99zdYvWHDEpWUUBsx6p4DwphF/TWUnk9oUwxj3TH3Q/hW05tnmhfT4uT?=
 =?iso-8859-1?Q?3PjOdh2iqfTaC/LNeEYNwrYu6SzIqq8eEp4DXu6x?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d/bk3ZxfZHdvFtp9OqhQSFT9W+b/rGXnL9g97s6XK2z6qrWNk3dWWeUJtY?=
 =?iso-8859-1?Q?DaHqiKI25qalw280Or7kqCOIHYRJj0pJ84DcVijU2dbjzStQPP3cDx3/Ty?=
 =?iso-8859-1?Q?JmXIADn+H4dFVY9A9ZAadNneWHYDjpYEqPTWKMl/ctytCWotl7/hZXm99a?=
 =?iso-8859-1?Q?cM6beVufUv7MUgVCb2zqj2pd6SQWufDSf48pHS5i7f+1MKmpF86r1HJgFb?=
 =?iso-8859-1?Q?CK/J3VxIZFLWq2twVFgT0XQGuj+fIzXJeCA+Afo66dc0VPH9+CgCMJiA8L?=
 =?iso-8859-1?Q?TibocMPsVCIT9pvNhDf9b5fmGQm7IilRqMNImHVrR0o5j1ixZ887GOb8Z3?=
 =?iso-8859-1?Q?n/pVMS8pMMiJuSz4OE2JkRg+5bgm7AkzWkejuKdQaEk2oAufwIqSb9ebKM?=
 =?iso-8859-1?Q?u1DncKVCQECEWgp+1G4i5amg67VYe+rBQ4ObdwmvWDxdeHHrilocbt9K/u?=
 =?iso-8859-1?Q?QUrlKmv+CzD3F+JJGgtvA94mnLZqGoL9YND0jqSoWHR0orjQJwXruZNnK6?=
 =?iso-8859-1?Q?Z6OtbV8T0dB9gm8QeI9PvKsZpenX3Zs/fdYsZX4WVs661ScGVHEhJOO/J2?=
 =?iso-8859-1?Q?iAsvC2Iic7yyVp/ifDs1Dao5xRjhzRl9vw9MVfjbNGJVYijm67+/GYjEtn?=
 =?iso-8859-1?Q?VngxQA4HiwSwRrwPHJMEFTDwbxlf8yGqvv2L6u+JD+8SifbEAHdZN5jqST?=
 =?iso-8859-1?Q?h8WnLdrCQl4b/gO6oHPETktVxSS9orQPQ6eoT0/gvXBjmnvV1klS27yRZk?=
 =?iso-8859-1?Q?dxDwUXIehIRTY7BjFmf1BJTDTUGFW2PLiyPdx2SI2KllLVWgZj1eGakCjj?=
 =?iso-8859-1?Q?c6gNTdWWx8lda2Wb2AEIO5lN+QU0Hh23Bd+ThSrGGAdF1OfKJikNKJgn9t?=
 =?iso-8859-1?Q?qLUcIML3/ulORjq5ob5PWuAKlrG3F6VZusesYdGs+0de5gcuvw7fG7zhLJ?=
 =?iso-8859-1?Q?gRXdDYo1BNROGVjdxxfJFuP2T5CTdNMQe9WeZ7zA2lUXkP5Y1dcRUSZuXf?=
 =?iso-8859-1?Q?g13WUi6UJVx3+WM0F2GfbeYYX8SmTMDPjNAEYmF3eWukMh6VUYDjWfWbiZ?=
 =?iso-8859-1?Q?P4H4suaXhORDYbIIjFrSxrRaK3TVuCrx72bT8piLuV5Pe366afYD5tUxCB?=
 =?iso-8859-1?Q?BE9SESSwmPpPQHr/1rWUNEG0hvk4XLvJhcIm1KIv9cth87AOM2j0DBJnok?=
 =?iso-8859-1?Q?MbUxwBBeWpi+/8lhpnVIxszWm7Beot+N4elYnPbn64abzzkxm+x8HEwA77?=
 =?iso-8859-1?Q?nTvonMKgfA/X0PY7HgcC6TVfVIBzzu+7mkHevbRJMHWY8bykDt53VPJMgH?=
 =?iso-8859-1?Q?ft/cFq2RupADRLX5ba1kKi3HBgQYxSAcDXPGS5HBWj1z4MPnYqrq5kLBy8?=
 =?iso-8859-1?Q?2IHycuT/hvIFdrj7/qb2kEcS/2u+gj43DB17KOXghkkoI7qBSXEzXW5iDT?=
 =?iso-8859-1?Q?QamXlJv1b+8sZJxKrz+/nqyWMHEeIXsx0cnTW9eoWramr6vEPWR32PzShW?=
 =?iso-8859-1?Q?oE+KVNJGN4MlaQrcZkJ8+syXK+XkzFufL9EWFJ7f4K7MQRVz+4v+dM4xDf?=
 =?iso-8859-1?Q?ZbmRIFG8uMhvPn/PRPbYcVxrJvQjY99xSD5LuD2/RdtkfDSaq1IofCBW0Z?=
 =?iso-8859-1?Q?R4dVqgkXCH6kZFFRqeXBCeqzXN38FoEx/Rix96SsJUwOMHHpCwqkX9opz8?=
 =?iso-8859-1?Q?RgahQbC5rzZDLQ9UhOrs+RwYO12lAbZ+pESV4ScTu+oaZ8GlZ1H8fL96BQ?=
 =?iso-8859-1?Q?LAPY8KKqv/BkeOAfqdpPqoU+EtI2Wokc9gPhMP0SZXiLPX0GMYKoeK9D8y?=
 =?iso-8859-1?Q?VdoE61K5MA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da754df4-9621-428d-7c10-08de67bbeda1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:37.6147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdIk0faIYbRC+rUlp698ezoXLQFIS4IB8yuy7s2LrN+/gyUq4petC8m4XW9IchVwg4uQtXnzzgl0jksD+ZWq6IipWyKdvdojtIC9y62wCI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5784
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Adds the rest of the Aspeed I3C controller register fields.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/aspeed_i3c.c | 54 +++++++++++++++++++++++++++++++++++----------=0A=
 1 file changed, 42 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index b0844d4da2..f0352aaca0 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -21,28 +21,58 @@=0A=
 /* I3C Controller Registers */=0A=
 REG32(I3C1_REG0, 0x10)=0A=
 REG32(I3C1_REG1, 0x14)=0A=
-    FIELD(I3C1_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C1_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C1_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C1_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C1_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C1_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C1_REG1, SA,            8,  7)=0A=
+    FIELD(I3C1_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C1_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C2_REG0, 0x20)=0A=
 REG32(I3C2_REG1, 0x24)=0A=
-    FIELD(I3C2_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C2_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C2_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C2_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C2_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C2_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C2_REG1, SA,            8,  7)=0A=
+    FIELD(I3C2_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C2_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C3_REG0, 0x30)=0A=
 REG32(I3C3_REG1, 0x34)=0A=
-    FIELD(I3C3_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C3_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C3_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C3_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C3_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C3_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C3_REG1, SA,            8,  7)=0A=
+    FIELD(I3C3_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C3_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C4_REG0, 0x40)=0A=
 REG32(I3C4_REG1, 0x44)=0A=
-    FIELD(I3C4_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C4_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C4_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C4_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C4_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C4_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C4_REG1, SA,            8,  7)=0A=
+    FIELD(I3C4_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C4_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C5_REG0, 0x50)=0A=
 REG32(I3C5_REG1, 0x54)=0A=
-    FIELD(I3C5_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C5_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C5_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C5_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C5_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C5_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C5_REG1, SA,            8,  7)=0A=
+    FIELD(I3C5_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C5_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C6_REG0, 0x60)=0A=
 REG32(I3C6_REG1, 0x64)=0A=
-    FIELD(I3C6_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C6_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C6_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C6_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C6_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C6_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C6_REG1, SA,            8,  7)=0A=
+    FIELD(I3C6_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C6_REG1, INST_ID,       16, 4)=0A=
 =0A=
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
-- =0A=
2.43.0=0A=

