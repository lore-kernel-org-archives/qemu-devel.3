Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C60D1CDC9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 09:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BCk-0007su-Jf; Tue, 22 Oct 2024 05:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3BCg-0007rl-S6; Tue, 22 Oct 2024 05:29:27 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3BCd-0007eu-Np; Tue, 22 Oct 2024 05:29:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRhLseipy911B8nezVvR4W9coit2NaqYKKHPkKVnwYrsOpIlmpH7hqzHLNpKWg0glbvhKhm3xyqVZ4YsLT9cOur6jj83vtPE8dP8Haz0fmgWEh6+Yyu1plrtzuW+jQ7en2z4iYjgr+u9SFzmfcdx46vb/yM//u44R+MNaSjd1NSMENaR4Q2xUdBVq2p/BeonN93Sptwf28Tmu+6hw5JKvS1RzwoOWILKuzqRSawLeqxy47il8OmFob5CUwOiMjn1KaxLySRBxAiVQIqjDJA5aBnt62QYS5+KUzrEQSCcxXeESj5Z4DrcNvnpbMnKTFx/Y5X/e86VkqN/+q5YE3rMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9LArQzR0uFtoPNl96E1rhmSqqEt4vNeqO2Nh3G2OFA=;
 b=rjx55BSXVr+hEH5Z3ayHf1Jfx5e7E7CMJIyngCQKuYCWupj+FUmB64eGTivV23jlrt6f/nHxo97d9jUaJflMwf3Zpv4lGZZRpTVhFkWoaF22ycKnW0exzMy7IBQzHVn5sJgDsVlJArnK0AojywHPzPpn4fj7VFjIeY6jEKIT1M2hu19v3+G7Agxwc2IUashShMkWCsTyQ6HQgaFpydSyGxgikbRt374dvGF8AuL7Z0zrGJpe3bmKO6299bOfXbH8+VIuEIRlG3wwAqZ7N0YluApqa9YvGohpkHJ0S7cPKlrqqIWwjcbnkCfKDxDpEEtdrwICfse11BViRcslT9rLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9LArQzR0uFtoPNl96E1rhmSqqEt4vNeqO2Nh3G2OFA=;
 b=bpfB+226wa0ujfnB4uH/HysJoZD/2z0ZXLMeYc0OVDUGwTS1EFUwWM2jVuNa0957Gxq40RNp4tzskMEAuOGsYJZc69icECvzKmIbx2LB+w4GWJ6lJz36QVaKmDwFukSLEvt/dApADvN7owVtH5nvEzeTCWk5x6BB8djBYRrm6oHL9EvV9uySozukQ9C7RX0OBjcYt2Q4a65a4ks6hZuSYkJZ0CttAr73UGmjqTDwGTcdYaouIapn5AqBOvbvCnGTutMbJIf1MBpe0W/SY3Ph2u8I/Etd2Q8aHdoW/rfNKWRwJ+9v2jYiVlS+ILLARjP+LB7IobJhZk/mN4EojIx8cg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6914.apcprd06.prod.outlook.com (2603:1096:405:41::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14; Tue, 22 Oct 2024 09:29:15 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8093.013; Tue, 22 Oct 2024
 09:29:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 01/16] aspeed/smc: Fix write incorrect data into
 flash in user mode
Thread-Topic: [SPAM] [PATCH v1 01/16] aspeed/smc: Fix write incorrect data
 into flash in user mode
Thread-Index: AQHbIR72cAUzWi7YlEuc5foBrb6SxbKSSpmAgAA618A=
Date: Tue, 22 Oct 2024 09:29:14 +0000
Message-ID: <SI2PR06MB5041EE717DADE3155F4C9097FC4C2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
 <20241018053112.1886173-2-jamin_lin@aspeedtech.com>
 <eb69d07f-8114-41e2-bea0-06f0d67a0d6f@kaod.org>
In-Reply-To: <eb69d07f-8114-41e2-bea0-06f0d67a0d6f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6914:EE_
x-ms-office365-filtering-correlation-id: af6b5389-9ba2-402b-acda-08dcf27bfecc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?NnVQeVljRGIxYmdPUllNSE5sMTJuUkV4c0Z0cGdoQXhTOFNFSjlYbUhuQWcx?=
 =?utf-8?B?SHpoVW1jNzlGZG1yQmVaWG1PdFhVdGFwdnVBdDhzQ3hRL2txck1tdnU1RFZ3?=
 =?utf-8?B?WGJWYnpDcGZQK2tGMDdCb0JYcGIwUUFCRHg1S0xYYVpCT0JWaWlPejZNZXl2?=
 =?utf-8?B?bmtsR2R1YWFCbXZtVkoxei81d1piTzd4ZkZ6MS83cnl6VFRidGhscFpodEpw?=
 =?utf-8?B?Q1lWTW1rTFNLYU5jMUxtYVh0MUpPYXBGWnVQQ3lyVDV5c3ZmQ1UyRnVpdlpV?=
 =?utf-8?B?ZDVvbjFqMnFDQTNiWmQzTzgzTmdST2FwbmdDZm9WNUNzbVJXbHRRaTFnelN3?=
 =?utf-8?B?NUxnR3U0eTgwS2RjU2t4Y0E3bjdOMFB3QUdLM0dYUVBxcjFnZEdOaThJVGt3?=
 =?utf-8?B?cXhORzlucUVBNDNvVHA4OVN4Ym9JS3kraWFiV3RkbGh6MWlVNzk1OHBCaXRx?=
 =?utf-8?B?VVM1d1c4UkxKUTE1dUFabzRsRHVpSUs4TjdINXpDSzQvYkJGUkZ3R3lYcXhY?=
 =?utf-8?B?cmNJaXVsTGpZWFF0RjNWNEtkaHB4L0RhNWVMRnNGQ2hDUnNMUkpZL0VDSmlC?=
 =?utf-8?B?dTVuUHhnaXdWRzgvWWJjOE9ib2dEK2t0UW9uaFl5b3NuOC84Vnh4aEVIZWl6?=
 =?utf-8?B?cHc2akkyekRBdDNCYWRwT0YvOE5xVTR1MGNBMmVUN0NWWFZlcGNNN1B3V1dE?=
 =?utf-8?B?VnlJcnJ0aWk0Wm55TGx2MWk3a09ENWpmeDBKWU14MmVMRzNVbHkxcWRKQzdY?=
 =?utf-8?B?MmRNaWtwNDVJenRuWURxbVNabWV1SmRyUmNpSnhEcjFLWUZFSG1veklBUkY1?=
 =?utf-8?B?YXBYa3duaWZtNndEOGlRMGxQTExTZ1h5ajhmVjl5eTR5M3N0NTA1ZXJqS3V5?=
 =?utf-8?B?bnM5bXhGTnl6RmRPUXdPZTQzUWIvd1I5ZWIyTHNJSE9mR3RVK1NHTzA3SmY3?=
 =?utf-8?B?aVBOaW1yYTFhM2RxbjlpaHVzajRPeXM3RXIrUWlNdkJ4UmdDRzdybTY1SFh5?=
 =?utf-8?B?TDh0WFJHRGZlNVJkUGNLMlVyZXlaLzN3c1p5S25TVUtxbm1OR1UvakpUZllm?=
 =?utf-8?B?R2lDenlmQzBueGZadlJ1SlBSRUpGOGg0SUIyeVZuSmJFMEJjL0VQdlZOMUI4?=
 =?utf-8?B?OEtWUzFzd3BJbDhjOXV3N2dJS0hPR0dydzAyQm1qcjVYa3o4MTZOajZ5dGxr?=
 =?utf-8?B?UDl2MWtjSjhoU3JRREVFTnRjenBUTGhWMHdFcGo5R1NyNzJuempnZHlZdCtE?=
 =?utf-8?B?SzU4VVRYUkQzQVJCWUtRd0N5SmZsTzdyZk0wYVRQaVI3dS9tUmVXTyt2bFA0?=
 =?utf-8?B?TEp0TE5YdUxNVHZaU2VkYllINGMyOUQvLzZ4aW5LTFZkNVZmYTNabXFiZGI4?=
 =?utf-8?B?TU5PL0pkZklZOTVIK3FoU1RPQXNTcWhCMGxxUXMxVGVCcXR1N0dDclVFbFF0?=
 =?utf-8?B?aTdXZVU4UklnbERXZDJESFA3ZWhROEN0aXJ0RWlyT3YyTldJVVVHMmF1N3RS?=
 =?utf-8?B?M3k3Ly9BM0RrSzZGT3BySGNxK1pWTGZGQklWdEhFSmZHaUQzR3M5TElzcjQz?=
 =?utf-8?B?dkpXeW90Q25BWUovaHhlSit5bXFHRVAyQTIyc2JkOWZZZS9vdTlVSXVTekhK?=
 =?utf-8?B?dlJkSjc2RDlNWXVZM3VpTnQ1aGcyQWhYKzR1amlaL0x5dkNTRGdiR2ZLb1Bh?=
 =?utf-8?B?OENjSmZLeVZlMzhlLzZtR2RBYkRoaHQwNkNKWGErL0Zhd09IaEdFSTY3SHJL?=
 =?utf-8?B?M2hFbEtRT24zU0lnMWFaRG82cG5rbGJjVTEyZGxzVGVDNjBVVUN4OVBhd0tB?=
 =?utf-8?B?ekhuVXVheFRmS0VDcXBRcElhbUdUd2k5cVFnZWZLRVFxWlR0N0NBWVRxN1ZS?=
 =?utf-8?B?U3ZOVDZkYjZrWmtNbFAwNmFyczdUU2p2QkpqdysxZ2xFQ3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU5yemhUMWlocW5CTldsbENuSzZsQ0U2aEY3emhsSnNKU2dDRUFxNy96eTBh?=
 =?utf-8?B?L1hCdHhIZFNmamZuUUNBSzl5Znc0OFZkRGpId0FhTWJnNHQvajdvb1VXelM5?=
 =?utf-8?B?M1dPNlhHWnRvdUdUK1hmcXdib2V1ZVRnQ0lRaVVmZkNSbEdVZStvZi8yMU5K?=
 =?utf-8?B?MklYcTdEbVl3anZvNVlHbWo4YUR6anp3dTFkQnJvbzJnV3NJQzliVHIvNjla?=
 =?utf-8?B?aTdCZUpjMEN6QTRXQ2hna0I0VlRwUGVFQXA1M0R1ajRNSTU3QTBuenh1cm1C?=
 =?utf-8?B?ejV4a1RvU281cVEyS3FwTzk5VjgvRnFodVFRV0VNQ2F2YmxkUXdRYU1DbnJQ?=
 =?utf-8?B?bi9BYWdBcWpDa2tUK0dpUlJ1OEk2bFRZbEtCSG1yK0tLTEUwVUNvaStqZHJZ?=
 =?utf-8?B?VnRPS25QSDVJd2dCUmRBaDVhd2R5cjBCSWtTVVdHZVVyeURvb1EwbEprQ252?=
 =?utf-8?B?QWNGMFNXeWpwelR5RVN5SUNXKzJUdm9ESkFreEU2bGExTHNYL0VDc3Z5L0pP?=
 =?utf-8?B?Qm52dUtCbGp1dDJtMlN1K0tJVnBKSkQ4TVRjWFgrTGh4SkxBbUZGMHFHWFZs?=
 =?utf-8?B?aWJSNStaRTFEWmV2Vkx5NWNJUG44b2ViV0JqQklkdUNuS20vQ2g3Z2RWcENz?=
 =?utf-8?B?dnVVcER0SnRocDBsYlNLdE01T2hHcGxXRzZIdS9FWnluT3UrR1F0bGpJZ0Ru?=
 =?utf-8?B?b2xLSUNtcWNka3d3WWZWRk9xb1diakg2UTBGOHRqdjFMZHdyZ3E1TVdrNTVC?=
 =?utf-8?B?TkU5RExvOW9RU3ZoQmRkdjEwU0kvMTN1MmE3Vm1pMFZvdTNDTlViY3diYzZO?=
 =?utf-8?B?R2tYLzJvaE8ySXVqcCtsTVYwUGNOaXhVVFE0SFVSRjNDVmNLR2NyYWlOMHVx?=
 =?utf-8?B?NmVmcE1BcUcvaFBKajlUMmlWaXJCUm13U3FqQ25ybUdwWmNrMXkvK3p6bVVE?=
 =?utf-8?B?bHY3VUZjTWxYQU5Zd0JRb3ZYemhCNk9BTlRUVEl1QzUyV1AvT3NrVDdTeHY5?=
 =?utf-8?B?TnJTeHNtZ0dQVnAvWmo3N0c2U0hPV0NsSklMN2d2Y3ZhSWV2RG5Peng4d2Ra?=
 =?utf-8?B?MjBRM05qbXR5MWg5ZWlFL3gva2Z6SHh5ZkhoZ0pwTGxaR25CQkV6R0FCN0Iy?=
 =?utf-8?B?amRGR2xiMitTMzFuZ2NOYlRuSSt4NXJWcFBGcG1KTEdPMGVQakt1Q2pBd291?=
 =?utf-8?B?OGxmeHdwbWFyWjV1Z3VmVldVdUZHcVJ2TEhKdkhwK2JUNmtWdHRpL21vR0RC?=
 =?utf-8?B?dmxlZUcvVDdhMU4zN0VlUEJtZjEvY3ZkenVlV1JCTTNzUkFYbjgzT3Q4LzJr?=
 =?utf-8?B?WG5DRFhhSVJ4VDd0VjFLa3Bta2JidTc2OEJuVGp0ViszY25EckJXQ204QXVE?=
 =?utf-8?B?blFjU3RHMXhIczA1bHJGc0Z3UEhmTGxQZjEyaVkvVFVJUGxFVTZOUGlsc29C?=
 =?utf-8?B?U1hHMmEzVnpaRmlaRzRnUU1oMDFhb3NJRjdiMEZ4NG1MamxlVzVKWUR4VFJU?=
 =?utf-8?B?cnpyUkwvTUkvNFFaWE1UL2hXLzVDSWhXV1VkbkRjbmlEaEtpRjFPZURBM1gy?=
 =?utf-8?B?b25jQmFSbVpoNzFOU0NRT3B2VnpTSWJ1LzhFQVptaks2TDl1Z1hMelRtZUZC?=
 =?utf-8?B?NDdrMWZnQ2wwTldzZUdwamRPdG1Cc1J2NTBDR2t6Ukd6ZnVINldlL0JSU2xZ?=
 =?utf-8?B?ejR5VVpKelFIaXU3b2VYRjBUUCtBaHVqd2xrSUcvUXFocldKc2xTbHBpRTh0?=
 =?utf-8?B?aUZwa3NLYXFIeklvTjNJaTNkbDBrcmJEcG1xYzdBZitRS0RVdXpVR3FXMHBM?=
 =?utf-8?B?Tit1RUgrZTlDeVJld2FhdDdBbDJZWEpNVkxGUXU4c05HQ0RLSGtCeERnNFlM?=
 =?utf-8?B?aEJpRVcrTHdFWmZlT3JWeFpaTlJDWE5ZalFXVnh6Rk15ckpSbXJtQmcwcUpP?=
 =?utf-8?B?QjlwVFo2NkJmcjJqZGNlcWYrb2hyb3ZmUGpJc2JRT3JpMjZYUUZhWjlLMlFL?=
 =?utf-8?B?V0x3cllnYWkwU3hRaVMyamNqZlVCakJqMzdDejFyWWZxcHo3cnVaVk14Yk5m?=
 =?utf-8?B?VFhrMGJ3QVB0dVc3bHh6MGlaZlY0clV0UmZkMG1iNDFGb0p2NW00Nk1jOXY5?=
 =?utf-8?Q?9JaA7Gu30vohR6fWZH2A1pW8/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6b5389-9ba2-402b-acda-08dcf27bfecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 09:29:14.8962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSLjOI81GL6uJSwsfEKm+IyVLxJv2uzhj7MFlWmzCiTsXHKrudFG78/dkPyeJm1KwfN9JWU+CozUwB/2EtNZDdrTPzh1kv1z9vEQ74/1QOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6914
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+
IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjIsIDIwMjQgMTo1MSBQTQ0KPiBUbzogSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsg
VHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bj
b2RlY29uc3RydWN0LmNvbS5hdT47DQo+IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBB
bGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpckBhbGlzdGFpcjIzLm1lPjsgS2V2aW4NCj4gV29sZiA8
a3dvbGZAcmVkaGF0LmNvbT47IEhhbm5hIFJlaXR6IDxocmVpdHpAcmVkaGF0LmNvbT47IFRob21h
cyBIdXRoDQo+IDx0aHV0aEByZWRoYXQuY29tPjsgTGF1cmVudCBWaXZpZXIgPGx2aXZpZXJAcmVk
aGF0LmNvbT47IFBhb2xvIEJvbnppbmkNCj4gPHBib256aW5pQHJlZGhhdC5jb20+OyBvcGVuIGxp
c3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+Ow0KPiBvcGVuIGxpc3Q6QWxsIHBh
dGNoZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgb3BlbiBsaXN0OkJsb2NrIGxh
eWVyDQo+IGNvcmUgPHFlbXUtYmxvY2tAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95
X2xlZUBhc3BlZWR0ZWNoLmNvbT47IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0
ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtTUEFNXSBbUEFUQ0ggdjEgMDEvMTZdIGFzcGVlZC9z
bWM6IEZpeCB3cml0ZSBpbmNvcnJlY3QgZGF0YSBpbnRvDQo+IGZsYXNoIGluIHVzZXIgbW9kZQ0K
PiANCj4gSGVsbG8gSmFtaW4sDQo+IA0KPiBPbiAxMC8xOC8yNCAwNzozMCwgSmFtaW4gTGluIHdy
b3RlOg0KPiA+IEFjY29yZGluZyB0byB0aGUgZGVzaWduIG9mIEFTUEVFRCBTUEkgY29udHJvbGxl
cnMgdXNlciBtb2RlLCB1c2Vycw0KPiA+IHdyaXRlIHRoZSBkYXRhIHRvIGZsYXNoLCB0aGUgU1BJ
IGRyaXZlcnMgc2V0IHRoZSBDb250cm9sDQo+ID4gUmVnaXN0ZXIoMHgxMCkgYml0IDAgYW5kIDEg
ZW50ZXIgdXNlciBtb2RlLiBUaGVuLCBTUEkgZHJpdmVycyBzZW5kIGZsYXNoDQo+IGNvbW1hbmRz
IGZvciB3cml0aW5nIGRhdGEuDQo+ID4gRmluYWxseSwgU1BJIGRyaXZlcnMgc2V0IHRoZSBDb250
cm9sIFJlZ2lzdGVyICgweDEwKSBiaXQgMiB0byBzdG9wDQo+ID4gYWN0aXZlIGNvbnRyb2wgYW5k
IHJlc3RvcmUgYml0IDAgYW5kIDEuDQo+ID4NCj4gPiBBY2NvcmRpbmcgdG8gdGhlIGRlc2lnbiBv
ZiBBU1BFRUQgU01DIG1vZGVsLCBmaXJtd2FyZSB3cml0ZXMgdGhlDQo+ID4gQ29udHJvbCBSZWdp
c3RlciBhbmQgdGhlICJhc3BlZWRfc21jX2ZsYXNoX3VwZGF0ZV9jdHJsIiBmdW5jdGlvbiBpcyBj
YWxsZWQuDQo+ID4gVGhlbiwgdGhpcyBmdW5jdGlvbiB2ZXJpZnkgQ29udHJvbCBSZWdpc3Rlcigw
eDEwKSBiaXQgMCBhbmQgMS4gSWYgaXQNCj4gPiBzZXQgdXNlciBtb2RlLCB0aGUgdmFsdWUgb2Yg
cy0+c25vb3BfaW5kZXggaXMgU05PT1BfU1RBUlQgZWxzZQ0KPiBTTk9PUF9PRkYuDQo+ID4gSWYg
cy0+c25vb3BfaW5kZXggaXMgU05PT1BfU1RBUlQsIHRoZSAiYXNwZWVkX3NtY19kb19zbm9vcCIg
ZnVuY3Rpb24NCj4gPiB2ZXJpZnkgdGhlIGZpcnN0IGluY29tbWluZyBkYXRhIGlzIGEgbmV3IGZs
YXNoIGNvbW1hbmQgYW5kIHdyaXRlcyB0aGUNCj4gPiBjb3JyZXNwb25kaW5nIGR1bW15IGJ5dGVz
IGlmIG5lZWQuDQo+ID4NCj4gPiBIb3dldmVyLCBpdCBkaWQgbm90IGNoZWNrIHRoZSBjdXJyZW50
IHVuc2VsZWN0IHN0YXR1cy4gSWYgY3VycmVudA0KPiA+IHVuc2VsZWN0IHN0YXR1cyBpcyAiZmFs
c2UiIGFuZCBmaXJtd2FyZSBzZXQgdGhlIElPIE1PREUgYnkgQ29udHJvbA0KPiA+IFJlZ2lzdGVy
IGJpdCAzMToyOCwgdGhlIHZhbHVlIG9mIHMtPnNub29wX2luZGV4IHdpbGwgYmUgY2hhbmdlZCB0
bw0KPiA+IFNOT09QX1NUQVJUIGFnYWluIGFuZCAiYXNwZWVkX3NtY19kb19zbm9vcCIgbWlzdW5k
ZXJzdGFuZCB0aGF0IHRoZQ0KPiA+IGluY29tbWluZyBkYXRhIGlzIHRoZSBuZXcgZmxhc2ggY29t
bWFuZCBhbmQgaXQgY2F1c2VzIHdyaXRpbmcgdW5leHBlY3RlZA0KPiBkYXRhIGludG8gZmxhc2gu
DQo+ID4NCj4gPiBFeGFtcGxlOg0KPiA+IDEuIEZpcm13YXJlIHNldCB1c2VyIG1vZGUgYnkgQ29u
dHJvbCBSZWdpc3RlciBiaXQgMCBhbmQgMSgweDAzKSAyLiBTTUMNCj4gPiBtb2RlbCBzZXQgcy0+
c25vb3AgU05PT1BfU1RBUlQgMy4gRmlybXdhcmUgc2V0IFF1YWQgUGFnZSBQcm9ncmFtIHdpdGgN
Cj4gPiA0LUJ5dGUgQWRkcmVzcyBjb21tYW5kICgweDM0KSA0LiBTTUMgbW9kZWwgdmVyaWZ5IHRo
aXMgZmxhc2ggY29tbWFuZA0KPiA+IGFuZCBpdCBuZWVkcyA0IGR1bW15IGJ5dGVzLg0KPiA+IDUu
IEZpcm13YXJlIHNlbmQgNCBieXRlcyBhZGRyZXNzLg0KPiA+IDYuIFNNQyBtb2RlbCByZWNlaXZl
cyA0IGJ5dGVzIGFkZHJlc3MNCj4gPiA3LiBGaXJtd2FyZSBzZXQgUVBJIElPIE1PREUgYnkgQ29u
dHJvbCBSZWdpc3RlciBiaXQgMzEuICgweDgwMDAwMDAzKQ0KPiA+IDguIFNNQyBtb2RlbCB2ZXJp
ZnkgbmV3IHVzZXIgbW9kZSBieSBDb250cm9sIFJlZ2lzdGVyIGJpdCAwIGFuZCAxLg0KPiA+ICAg
ICBUaGVuLCBzZXQgcy0+c25vb3AgU05PT1BfU1RBUlQgYWdhaW4uIChJdCBpcyB0aGUgd3Jvbmcg
YmVoYXZpb3IuKQ0KPiA+IDkuIEZpcm13YXJlIHNlbmQgMHhlYmQ4YzEzNCBkYXRhIGFuZCBpdCBz
aG91bGQgYmUgd3JpdHRlbiBpbnRvIGZsYXNoLg0KPiA+ICAgICBIb3dldmVyLCBTTUMgbW9kZWwg
bWlzdW5kZXJzdGFuZCB0aGF0IHRoZSBmaXJzdCBpbmNvbWluZyBkYXRhLCAweDM0LA0KPiA+ICAg
ICBpcyB0aGUgbmV3IGNvbW1hbmQgYmVjYXVzZSB0aGUgdmFsdWUgb2Ygcy0+c25vb3AgaXMgY2hh
bmdlZCB0bw0KPiBTTk9PUF9TVEFSVC4NCj4gPiAgICAgRmluYWxseSwgU01DIHNuZWQgdGhlIGlu
Y29ycmVjdCBkYXRhIHRvIGZsYXNoIG1vZGVsLg0KPiA+DQo+ID4gSW50cm9kdWNlIGEgbmV3IHVu
c2VsZWN0IGF0dHJpYnV0ZSBpbiBBc3BlZWRTTUNTdGF0ZSB0byBzYXZlIHRoZQ0KPiA+IGN1cnJl
bnQgdW5zZWxlY3Qgc3RhdHVzIGZvciB1c2VyIG1vZGUgYW5kIHNldCBpdCAidHJ1ZSIgYnkgZGVm
YXVsdC4NCj4gPiBVcGRhdGUgImFzcGVlZF9zbWNfZmxhc2hfdXBkYXRlX2N0cmwiIGZ1bmN0aW9u
IHRvIGNoZWNrIHRoZSBwcmV2aW91cw0KPiA+IHVuc2VsZWN0IHN0YXR1cy4gSWYgYm90aCBuZXcg
dW5zZWxlY3Qgc3RhdHVzIGFuZCBwcmV2aW91cyB1bnNlbGVjdA0KPiA+IHN0YXR1cyBpcyBkaWZm
ZXJlbnQsIHVwZGF0ZSBzLT5zbm9vcF9pbmRleCB2YWx1ZSBhbmQgY2FsbA0KPiAiYXNwZWVkX3Nt
Y19mbGFzaF9kb19zZWxlY3QiLg0KPiANCj4gSXQncyB2ZXJ5IGRpZmZpY3VsdCBhbmQgdGltZSBj
b25zdW1pbmcgdG8gZGVidWcgc3VjaCBpc3N1ZXMuIFRoYW5rcyBmb3IgdGhlDQo+IGVmZm9ydCAh
DQo+IA0KPiA+IEluY3JlYXNlIFZNU3RhdGVEZXNjcmlwdGlvbiB2ZXJzaW9uIDEuDQo+IA0KPiAi
SW5jcmVhc2UgVk1TdGF0ZURlc2NyaXB0aW9uIHZlcnNpb24iIGlzIHN1ZmZpY2llbnQuDQo+IA0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5j
b20+DQo+ID4gLS0tDQo+ID4gICBody9zc2kvYXNwZWVkX3NtYy5jICAgICAgICAgfCAzOQ0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gICBpbmNsdWRlL2h3L3Nz
aS9hc3BlZWRfc21jLmggfCAgMSArDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlv
bnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3NzaS9hc3Bl
ZWRfc21jLmMgYi9ody9zc2kvYXNwZWVkX3NtYy5jIGluZGV4DQo+ID4gZTNmZGM2NmNiMi4uOGE2
MTQ1YWZlOSAxMDA2NDQNCj4gPiAtLS0gYS9ody9zc2kvYXNwZWVkX3NtYy5jDQo+ID4gKysrIGIv
aHcvc3NpL2FzcGVlZF9zbWMuYw0KPiA+IEBAIC00MTcsNyArNDE3LDcgQEAgc3RhdGljIHZvaWQN
Cj4gYXNwZWVkX3NtY19mbGFzaF9kb19zZWxlY3QoQXNwZWVkU01DRmxhc2ggKmZsLCBib29sIHVu
c2VsZWN0KQ0KPiA+ICAgICAgIEFzcGVlZFNNQ1N0YXRlICpzID0gZmwtPmNvbnRyb2xsZXI7DQo+
ID4NCj4gPiAgICAgICB0cmFjZV9hc3BlZWRfc21jX2ZsYXNoX3NlbGVjdChmbC0+Y3MsIHVuc2Vs
ZWN0ID8gInVuIiA6ICIiKTsNCj4gPiAtDQo+ID4gKyAgICBzLT51bnNlbGVjdCA9IHVuc2VsZWN0
Ow0KPiA+ICAgICAgIHFlbXVfc2V0X2lycShzLT5jc19saW5lc1tmbC0+Y3NdLCB1bnNlbGVjdCk7
DQo+ID4gICB9DQo+ID4NCj4gPiBAQCAtNjc3LDIyICs2NzcsMzUgQEAgc3RhdGljIGNvbnN0IE1l
bW9yeVJlZ2lvbk9wcw0KPiA+IGFzcGVlZF9zbWNfZmxhc2hfb3BzID0gew0KPiANCj4gSSB3b3Vs
ZCBsaWtlIHRvIGFkZCBzb21lIGRvY3VtZW50YXRpb24gdG8gdGhpcyByb3V0aW5lLiBMaXN0aW5n
IHRoZSBkaWZmZXJlbnQNCg0KVGhhbmtzIGZvciBzdWdnZXN0aW9uLg0KQ291bGQgeW91IHBsZWFz
ZSBicmllZmx5IHRlbGwgbWUgYWRkaW5nIGRvY3VtZW50YXRpb24gaW4gd2hlcmUgYW5kIHdoYXQg
Y29udGVudHMgc2hvdWxkIGJlIGFkZGVkIGludG8gZG9jdW1lbnRhdGlvbj8NCkkgd2lsbCBzZW5k
IHRoZSBwYXRjaCB0byBhZGQgdGhlbSBpbiB0aGUgZnV0dXJlLg0KIA0KPiBjb250cm9sbGVyIHN0
YXRlIGNoYW5nZXMgc2VlbXMgaW1wb3J0YW50IHRvIG1lIHRvIHVuZGVyc3RhbmQgaG93IHRoZXkg
YXJlDQo+IGhhbmRsZWQuIEluIGEgZnV0dXJlIHBhdGNoLCBubyBuZWVkIG5vdy4gRml4aW5nIHRo
ZSBpc3N1ZSBpcyBhbHJlYWR5IGdyZWF0ICENCj4gDQo+IA0KPiANCj4gPiAgIHN0YXRpYyB2b2lk
IGFzcGVlZF9zbWNfZmxhc2hfdXBkYXRlX2N0cmwoQXNwZWVkU01DRmxhc2ggKmZsLCB1aW50MzJf
dA0KPiB2YWx1ZSkNCj4gPiAgIHsNCj4gPiAgICAgICBBc3BlZWRTTUNTdGF0ZSAqcyA9IGZsLT5j
b250cm9sbGVyOw0KPiA+IC0gICAgYm9vbCB1bnNlbGVjdDsNCj4gPiArICAgIGJvb2wgdW5zZWxl
Y3QgPSBmYWxzZTsNCj4gPiArICAgIHVpbnQzMl90IG9sZF9tb2RlOw0KPiA+ICsgICAgdWludDMy
X3QgbmV3X21vZGU7DQo+ID4gKw0KPiA+ICsgICAgb2xkX21vZGUgPSBzLT5yZWdzW3MtPnJfY3Ry
bDAgKyBmbC0+Y3NdICYgQ1RSTF9DTURfTU9ERV9NQVNLOw0KPiA+ICsgICAgbmV3X21vZGUgPSB2
YWx1ZSAmIENUUkxfQ01EX01PREVfTUFTSzsNCj4gPg0KPiA+IC0gICAgLyogVXNlciBtb2RlIHNl
bGVjdHMgdGhlIENTLCBvdGhlciBtb2RlcyB1bnNlbGVjdCAqLw0KPiA+IC0gICAgdW5zZWxlY3Qg
PSAodmFsdWUgJiBDVFJMX0NNRF9NT0RFX01BU0spICE9IENUUkxfVVNFUk1PREU7DQo+ID4gKyAg
ICBpZiAob2xkX21vZGUgPT0gQ1RSTF9VU0VSTU9ERSkgew0KPiA+ICsgICAgICAgIGlmIChuZXdf
bW9kZSAhPSBDVFJMX1VTRVJNT0RFKSB7DQo+ID4gKyAgICAgICAgICAgIHVuc2VsZWN0ID0gdHJ1
ZTsNCj4gPiArICAgICAgICB9DQo+ID4NCj4gPiAtICAgIC8qIEEgY2hhbmdlIG9mIENUUkxfQ0Vf
U1RPUF9BQ1RJVkUgZnJvbSAwIHRvIDEsIHVuc2VsZWN0cyB0aGUgQ1MgKi8NCj4gPiAtICAgIGlm
ICghKHMtPnJlZ3Nbcy0+cl9jdHJsMCArIGZsLT5jc10gJiBDVFJMX0NFX1NUT1BfQUNUSVZFKSAm
Jg0KPiA+IC0gICAgICAgIHZhbHVlICYgQ1RSTF9DRV9TVE9QX0FDVElWRSkgew0KPiA+IC0gICAg
ICAgIHVuc2VsZWN0ID0gdHJ1ZTsNCj4gPiArICAgICAgICAvKiBBIGNoYW5nZSBvZiBDVFJMX0NF
X1NUT1BfQUNUSVZFIGZyb20gMCB0byAxLCB1bnNlbGVjdHMgdGhlDQo+IENTICovDQo+ID4gKyAg
ICAgICAgaWYgKCEocy0+cmVnc1tzLT5yX2N0cmwwICsgZmwtPmNzXSAmIENUUkxfQ0VfU1RPUF9B
Q1RJVkUpICYmDQo+ID4gKyAgICAgICAgICAgIHZhbHVlICYgQ1RSTF9DRV9TVE9QX0FDVElWRSkg
ew0KPiA+ICsgICAgICAgICAgICB1bnNlbGVjdCA9IHRydWU7DQo+ID4gKyAgICAgICAgfQ0KPiA+
ICsgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICBpZiAobmV3X21vZGUgIT0gQ1RSTF9VU0VSTU9E
RSkgew0KPiA+ICsgICAgICAgICAgICB1bnNlbGVjdCA9IHRydWU7DQo+ID4gKyAgICAgICAgfQ0K
PiA+ICAgICAgIH0NCj4gPg0KPiA+ICAgICAgIHMtPnJlZ3Nbcy0+cl9jdHJsMCArIGZsLT5jc10g
PSB2YWx1ZTsNCj4gPg0KPiA+IC0gICAgcy0+c25vb3BfaW5kZXggPSB1bnNlbGVjdCA/IFNOT09Q
X09GRiA6IFNOT09QX1NUQVJUOw0KPiA+IC0NCj4gPiAtICAgIGFzcGVlZF9zbWNfZmxhc2hfZG9f
c2VsZWN0KGZsLCB1bnNlbGVjdCk7DQo+ID4gKyAgICBpZiAodW5zZWxlY3QgIT0gcy0+dW5zZWxl
Y3QpIHs+ICsgICAgICAgIHMtPnNub29wX2luZGV4ID0gdW5zZWxlY3QgPw0KPiBTTk9PUF9PRkYg
OiBTTk9PUF9TVEFSVDsNCj4gPiArICAgICAgICBhc3BlZWRfc21jX2ZsYXNoX2RvX3NlbGVjdChm
bCwgdW5zZWxlY3QpOw0KPiA+ICsgICAgfQ0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgdm9p
ZCBhc3BlZWRfc21jX3Jlc2V0KERldmljZVN0YXRlICpkKSBAQCAtNzM3LDYgKzc1MCw3IEBADQo+
ID4gc3RhdGljIHZvaWQgYXNwZWVkX3NtY19yZXNldChEZXZpY2VTdGF0ZSAqZCkNCj4gPg0KPiA+
ICAgICAgIHMtPnNub29wX2luZGV4ID0gU05PT1BfT0ZGOw0KPiA+ICAgICAgIHMtPnNub29wX2R1
bW1pZXMgPSAwOw0KPiA+ICsgICAgcy0+dW5zZWxlY3QgPSB0cnVlOw0KPiANCj4gUGxlYXNlIG1v
dmUgdGhpcyBhc3NpZ25tZW50IGJlbG93IHRoZSAiLyogVW5zZWxlY3QgYWxsIHBlcmlwaGVyYWxz
ICovIg0KPiBzZWN0aW9uLg0KPiANCj4gDQpUaGFua3MgZm9yIHJldmlldyBhbmQgc3VnZ2VzdGlv
bi4NCldpbGwgdXBkYXRlIGl0Lg0KDQpUaGFua3MtSmFtaW4NCj4gVGhhbmtzLA0KPiANCj4gQy4N
Cj4gDQo+IA0KPiANCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIHVpbnQ2NF90IGFzcGVlZF9z
bWNfcmVhZCh2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1bnNpZ25lZA0KPiA+IGludCBzaXpl
KSBAQCAtMTI2MSwxMiArMTI3NSwxMyBAQCBzdGF0aWMgdm9pZA0KPiA+IGFzcGVlZF9zbWNfcmVh
bGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4NCj4gPiAgIHN0YXRpYyBj
b25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9hc3BlZWRfc21jID0gew0KPiA+ICAgICAg
IC5uYW1lID0gImFzcGVlZC5zbWMiLA0KPiA+IC0gICAgLnZlcnNpb25faWQgPSAyLA0KPiA+ICsg
ICAgLnZlcnNpb25faWQgPSAzLA0KPiA+ICAgICAgIC5taW5pbXVtX3ZlcnNpb25faWQgPSAyLA0K
PiA+ICAgICAgIC5maWVsZHMgPSAoY29uc3QgVk1TdGF0ZUZpZWxkW10pIHsNCj4gPiAgICAgICAg
ICAgVk1TVEFURV9VSU5UMzJfQVJSQVkocmVncywgQXNwZWVkU01DU3RhdGUsDQo+IEFTUEVFRF9T
TUNfUl9NQVgpLA0KPiA+ICAgICAgICAgICBWTVNUQVRFX1VJTlQ4KHNub29wX2luZGV4LCBBc3Bl
ZWRTTUNTdGF0ZSksDQo+ID4gICAgICAgICAgIFZNU1RBVEVfVUlOVDgoc25vb3BfZHVtbWllcywg
QXNwZWVkU01DU3RhdGUpLA0KPiA+ICsgICAgICAgIFZNU1RBVEVfQk9PTCh1bnNlbGVjdCwgQXNw
ZWVkU01DU3RhdGUpLA0KPiA+ICAgICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCkNCj4gPiAg
ICAgICB9DQo+ID4gICB9Ow0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3NzaS9hc3BlZWRf
c21jLmggYi9pbmNsdWRlL2h3L3NzaS9hc3BlZWRfc21jLmgNCj4gPiBpbmRleCAyMzRkY2EzMmIw
Li4yNWI5NWU3NDA2IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvc3NpL2FzcGVlZF9zbWMu
aA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvc3NpL2FzcGVlZF9zbWMuaA0KPiA+IEBAIC04Miw2ICs4
Miw3IEBAIHN0cnVjdCBBc3BlZWRTTUNTdGF0ZSB7DQo+ID4NCj4gPiAgICAgICB1aW50OF90IHNu
b29wX2luZGV4Ow0KPiA+ICAgICAgIHVpbnQ4X3Qgc25vb3BfZHVtbWllczsNCj4gPiArICAgIGJv
b2wgdW5zZWxlY3Q7DQo+ID4gICB9Ow0KPiA+DQo+ID4gICB0eXBlZGVmIHN0cnVjdCBBc3BlZWRT
ZWdtZW50cyB7DQoNCg==

