Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B08606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 04:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=pKGQNiy5;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=SoinBin6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVLIC-0000wy-IU; Sun, 22 Nov 2026 23:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVLIA-0000wi-AF; Sun, 22 Nov 2026 23:04:34 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVLI8-0001vS-MB; Sun, 22 Nov 2026 23:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795406672; x=1826942672;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gBnMZxJ9IHbv1Yd6+GR/wXM8tC78Z2b+1q0u8Y8OjPI=;
 b=pKGQNiy5VjAddpcn9EHgl7MfinCneK/fdCf/Lwp2is1JBXrFtQkjKGRI
 XQOtHIdy3147JcBeMVY+juO0dn1Z0onmOUDoQGig6TJjco+v/r5aRSbaQ
 RK6zG9YMyIRrxTLd5K06C6cuxwtv3LJzF3jFAtw05C6LqGCZzuAL9Ah+v
 gEwjepCogm7PaxdUlQhuDntdaLQwK/AWxHepgfxktTf7HJjry8EReF5xF
 fJ9usPiQciAhXijFu7Oisxwq24Uf17AQr7IBcyTlAbIX3fJmTuJ5GM/vo
 /h4sKFfCCgpjbyPgI6lxdh/uJNjY1NCYKo08xYKzeD+FHv+I55ZmvojIW w==;
X-CSE-ConnectionGUID: 11kjOwc2QHmKW9F3XzhNWg==
X-CSE-MsgGUID: jMlGOGkaSpmG8cPUwan16Q==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="160556880"
Received: from mail-westus3azon11011061.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.61])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 12:04:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfWgZNCrAMGDzoMpbzn1XXcbddf2nUjTEDNblz263RETqWSEhLAih8ZaCymt6jKGStEcXXvLYsrutBD/9BqG/8s4siFxrBo1rguBQgs+LN2XkZQ8Tb/kADS6XgqzdDC8OyA2TvYgjaPWugRPcNx8Hm0ZHsAjqCcuzNOAcS7qE//0+EAAvIBFdhEMW5pYh579A6s23jDsz9BnNlEv8vufTz3YR//4Dh2m+1IpvvZdnk1oUhvioiylxOP+HmTGnGqLMVv7RADdFHdyAzZQ4KDC6H+GfLhIsxmJ9blGvp78jrHllEFKmr+Q6hHK5HguW0QDh/oQimGvTJlErcfE4XilgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBnMZxJ9IHbv1Yd6+GR/wXM8tC78Z2b+1q0u8Y8OjPI=;
 b=h8b3rv9fvUPZLw6L04R2blPj2kFTSO4QvnEO8wJ4LKASubH0mEb7/sxW80earan8F4f23LNEsbtwbpLoqjkjbAc/NNMYxy6RP3VaXM9s2f0Z/Gw4mHON5r2GQglmLNzemBnLoFxcNkBTBf5rryUgOtBqn3gSenoedhiIgxRZGZ8WQNtV5w5zXzRXRaoiJsmw6owY2y4k7z4xuywgSjAOqPgdMyK4KdnFqolupdDinzecU+BjwMhZBBhjMtDObuLRLzI+YNMvvspGbX3pML37mGa1wy8dKzT33putpgky40jJUpr9LpVNx2OFsrYFVgc+vYZF/qVxQLMiROsLaP84ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBnMZxJ9IHbv1Yd6+GR/wXM8tC78Z2b+1q0u8Y8OjPI=;
 b=SoinBin6whRQKvf/d2sy4ct9tPUXnKrfUD86dWOwn6zzuTNOREKBe79P0WhswOTLLz5nq8EPNpjANEi0JiVOrZ3DGn1vx1g3SY0dRx50Lp0zWKmytmN2n3PjW7djGrx/tNvtRul3yjA3V0iQ83F7zegKxhO9l/dy/k1e9WdnO98=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DS0PR04MB10122.namprd04.prod.outlook.com (2603:10b6:8:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 04:04:27 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 04:04:27 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH 0/2] tcg-tests: detect redundant exe_name/test_name
Thread-Topic: [PATCH 0/2] tcg-tests: detect redundant exe_name/test_name
Thread-Index: AQHddiFKfpIU/RcKKEKPqMa1BEEWJbc7EzIA
Date: Mon, 23 Nov 2026 04:04:27 +0000
Message-ID: <f7a4f976a041c53ddf192ce3411c8fdc72ae5335.camel@wdc.com>
References: <20261116232140.2758664-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261116232140.2758664-1-pierrick.bouvier@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DS0PR04MB10122:EE_
x-ms-office365-filtering-correlation-id: 35ff967e-b5d8-44df-89d9-08df4916de00
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|19092799006|376014|38070700021|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: YT4Xq/M6A9GPmea/RHQ5rb24ymA6GfcoswIOnW8Kn3oQAOVSAEuwz/U8PbKoDmlCTnRftuup8NihLN7dOkpM2Do2utPrYZ11TjkaECxOb2B5Y5ItsMzJR7LAo/kNigTkhhQGaMLOgNOnWAmTtRUtxI3MBXsYF1NB+HDVLSMHG70gLP5pmlAlatojRoMh674wW/4oiFqu6IwSGdDHYwwiNhfIFeehv+EpfFurkyr3MFE7tsWvVO0gGqgL8GD2DVd8fis43pqc7O7VkVhf00mTKD0j1LuE+JdPEkHAj1osBn20WPBqwLwn+PdANMVaKMqwW8iFxWyYyIvkUNO51mb31sqaGV/vMjuVzEOZ/kBz0wCcORxgqHDVKhPOgFN1WdRAdqPkdghr2t0TH//K+HObokLOjoEZJwZQgdb6+cmgYY3e0V/I+5J5ts3Cck8C9znECtzISFjyzlMvRK20YRow6H+j/mvDFuJlmCZhGfeRIsF+gt6C2KzKMtuuJTNTw5qTL1xV3uX5+i2GYEyRTdP98CMcvFdQqyktUhbfQMqzy645LYMjz9eqnbEWcn70WX7abuczsECH3V0s/RgNxA5Y1QtSC9fKsk4fDm+rgOPSr7+ISZlb2J3ChEXvLTuwtP2Fn+AwEp3wLRz9biqAOmwhz93HDRWBqxD8PW6CGZ+weWoDyCk4LnaOOvSKY5VCy/dbPx29OFrDeqw+CUHJep8hAqppv6Nm4elvWp7prhU3iu8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(19092799006)(376014)(38070700021)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1FWaWFnSEFtZWdmRm1UQXp2cVZVY0hKSlN4dGJMcUF5K3RtQTQzSFBPajFM?=
 =?utf-8?B?U2EzNFI4NnRPcWsyb2x0d1BkWGZDUFBoQTdZU1hwbVg2R2NXM0hmTXg5SDF4?=
 =?utf-8?B?dFJlR0pwSlk3UFRobzcvY2NHVm5qYjhuYnVQZVpxTlY4OUJzRUwvd2d4Tzds?=
 =?utf-8?B?cG52VVMyQ05QaWRaRGI0djNEa2xmd3pTM05mS1JkRVFkY1U4REN3T2dmcG5i?=
 =?utf-8?B?TzdVZ3J1VGMwSGlLeDRmaTBCYk95NWFmdDFoaFFSUkdNeldMUHJjNU5ZSEdI?=
 =?utf-8?B?eThMRld3V2dCeXF0NnM0MmpLS2dWZFVKOGplT0ZtN0h4U2lzYTJnYm5UeC96?=
 =?utf-8?B?U2ZMV2ptZU1xZEs1SzkyWkg0ZHhrODh3blF3ZEFrSXpidUJwQ2JrdjlxTjIv?=
 =?utf-8?B?NlE0Y2NzdklJSWIrYVNRR2F1cVZoSTVyMU9hOUxwbVE4cUxhOFgyYnVFU1A2?=
 =?utf-8?B?QU5kdGxGdG4zaThXVTFHaHdTTEl6VXBoZEUyc2JpZ3A4cGhGM0pEbm03YnFR?=
 =?utf-8?B?MjBBT09tblNDMEJ6WEFDVi9mVVNnQ2U4c25OQUZZMkN0OXRtNGVBbWNNVGhH?=
 =?utf-8?B?RnlOWVdJM2RyM1dET3lPRWNxOW93cGxYQXNkZTFYWHNTbElTU2N0WmZ4blRT?=
 =?utf-8?B?REdUY09qRC81UDJLSzN6UTVXLzQ4R3VaRnZoT0l5TnpTL1dDUjZvenN0SzNF?=
 =?utf-8?B?ZEE4bXZoNHdnZVpMeld2dEhCTlBKTTdYM1ppR2kzMTcweHFlMHhoMVY0VHI2?=
 =?utf-8?B?QzNGbjJwT1lOR1VlV3l1M0I3S09DOXZuVDZ1OFkyTTdmQ1RCV3E2QkVNZFp6?=
 =?utf-8?B?UWtVb1g5aXlQc2MvYy9SanhFVUs4dGZEZko5WjhLT002RlowWUNwMlFrZFBm?=
 =?utf-8?B?K2pacjJDYVB0aDVHM3hFR1ZCaStqY1hZVytRQU1oTUdrY3lPaCtWQnhmcGtk?=
 =?utf-8?B?YlNqQWcvcThLYWFxTHFEc2NwYW9qSWhWRkw2VHZhS2VsQUpYVHY4eEhCNytu?=
 =?utf-8?B?Tk1FZlpxUUNhWjhXU1FIOFcvaUkxVjV6K2p1OVhDdklWMlFuak9pRkRwdTQ3?=
 =?utf-8?B?em9sOWYzelZHRjJqYmhNNjJxNTFHb21mSGgxRGU2QVo4Z3hEVThHU3RtWVcv?=
 =?utf-8?B?dDFnR0JHTHRlaWpVcHYxdTNKYmxGZG81M2pPcHZZRGtEQWJjZUZ1S2hXU2Jn?=
 =?utf-8?B?d2d0dmdRWVRDNGp2OTFhRDNKTlhwSm9kNmVZc1JGcWxsdk1pNWdoZTBlYVNC?=
 =?utf-8?B?bklhK3luZlRDYnllYlplOUZ1WnNiLzdTbFdmK29qTTFteWVGTnBVdE92Z1pQ?=
 =?utf-8?B?NDlBTzJQY2FzSUVqNVkyMlBGOWJtTnlCTno3UUJIdDg2b1oyRGxBZnhzWkl3?=
 =?utf-8?B?OWx1bm1HRmNjd2Q1MU5Ja2dvRmFMZUdtZTVOdWdwTTYvSDlVMFZHVG4yN01y?=
 =?utf-8?B?azl0dDd0K1d4d3FiZGQ2b1RXNmMxdzJ6OFV1Wk1McmtQdndZazA0K3gySXlK?=
 =?utf-8?B?R2ljNGtTazVoczJrM0dKeVZBVmg3R0d2czRwbjZNQ0Nhd21FVUtKVkpncGRO?=
 =?utf-8?B?ZnkyVXlFT2lzMHQwMExpclhSU2NNSXc4NW9SUnNhdkloY3JvZWVzeEk1RjNZ?=
 =?utf-8?B?a1NXd3EvSEF5U2Q5SEJMVStRZ0xnM2RaVjEzVDNYM3VYbWlvNGZjTElIVlJn?=
 =?utf-8?B?MHNBOGs5SXF6cmcvc2xVRGl0MUNhMnhVYm4wdXlla2Q3aEFMWWJXT0gvV1Nv?=
 =?utf-8?B?WmxNWk9qZGk3bzVaVVluM3V6NUhNNHhYaWR4K2tiZTU0WVI4dFFjUm9iRnFp?=
 =?utf-8?B?bVM0OTltSHJZSWxZdkl2ajRPVGM3QXhuMlo5aUsyRkxLVGRneCs3RE5VQ1lK?=
 =?utf-8?B?dndOU3o1K1JSRXhqYWRydmpCem1yTUdvbHRHTlRjcTFITUtWNTJNZUNPUEcv?=
 =?utf-8?B?UjhMNFh3dW4yK3REMVFXVzhlc04xRENiRHdWUDZKYmpLUnNnVlhlNTVOS21M?=
 =?utf-8?B?WVRaSGlRWDFpNjBXUjczYmI4S0ZaQ1lSMFRTL0pOdkhHUWN5c05BbmsvbkVY?=
 =?utf-8?B?SjIxNkJkWGhQeGtsYi9raDVieUJ3WENxZmpvaVJZNGNqcTVWMEJuYk03bDdX?=
 =?utf-8?B?ekhzRW9sRE5vK3JNRnFXL3Jmc29xVTFIQm9abTdhRW03MGJmM3ZrYVQxQ3BW?=
 =?utf-8?B?dVBtQ0R5Y0RhWDhxdE8vT0hQVGJCSlA5TDdMY1pEQS9DZ2Q3YWRQbFVHb2JQ?=
 =?utf-8?B?VVc0VDBuVDhwOXYvZVRKU1BKMkNPMklSakZXT3JNQ0J3SXlNcUFwcnV1dkxk?=
 =?utf-8?B?N1hQUHY3SlpaQVZZOXAyc291NzJ5OERWS2JBc1lNZTZBTkt3Y25ZVEdXbjFq?=
 =?utf-8?Q?CdutwTrJUxljLhsbtc2gtFWySED0okyrwwHFGMdqSyeI5?=
x-ms-exchange-antispam-messagedata-1: kARyhNQOf3qfov0551JmFWBG23wDCMQAgGA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <744212D4BCC9EC4783D2C58EAB688748@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UkvpGpmrPilD3OGs0tlRfayKXdCyIznn12XqsALmzL+OLcfCDIcvuMgoD7pqRvaarn9A8iWJPV5ihToeWlBs8hReTlkk1e4aVlONHhFqjg+rIohqayhhq0mBq24G0pMzbfwPYCkD40Sr1q+ifDMeODqDs+9XfHEAVCJ0OLbsT5NhaMmuCQE2k7Z7fxGhqVyI2R1Wwg54NCVpG/Di+39s6WGhg2BNfNf4cp+3DtFBIPmAJH3QSLQ3Oef69b9/YCcBemxdk+RqW87mexflbtcdJ+3q3DobaOLl8izciUiS4X4MgmgmW/RaUpg3VipMlK34PVs6qBl76jiXZ8znVRwbtw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0+ErZWVEWsLEG/QS3/BD1eARD7mL8M4533ZI9x5DTUuPdyDzJjcVZ51DOQK9+Nlx1IZhR2IyVfFUI7aEduqPMXQ1G+RsZfprRThUwBq05Gt/pyuU7COO5Ozabf/60aN4hDHKrCnbyvBX/yZ02UpNYrQfCGJM7N8+MDiU05SBI57KKQg0JyYv5LM6H30uNwsSwML1a1167fAC4DBELSHS2crNFaHk6J/60XyLwX+Mqe781i9YDxnUxEXXtCxhHTicpl/3THiYun+dSiwEIbpWMlqWHaWwpPWloC7tOJb17poqJstuWq6o6c0XrtOEnOW2FQh2/aW+izMUTJuO4tcfOQXWV8yt3YnLsj41x5xWhiFbmtQa5Vj2VRk950O3iq5AVuiFsvcgcw+KAQE4cbR8qrjVqJ/Cmt5iamumU/I/aaTB2n9jt/+1m/kQpe+wApi74bhoDRcRDldetuQyXgPEzTEJuibXhp6QLnaVS9Fb3hix/GFZFrEep5XdkKc5jXpHqVZY/eLoD8K2+U+Vncf5xHUYjCDiLjO8w2ZEwB0qtfQOeqS+7vsRp8NRv2rgd0G/ymUCyhNY/6syuoZ/hCUdTyX7MRoauV7gctiIBuEa3QvSSZbJNNAQ+AnfY8BkUl+J
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ff967e-b5d8-44df-89d9-08df4916de00
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 04:04:27.2493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wNeLlglouNKaFTomF3BS1w4zQEHwFrs36XJa8yfFBNpzO18jnTrUEcrroz4aNkXeaBzqlZbBS1vj1poRPN6j8/4MhszA+t46/8Nuf+bFBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB10122
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTExLTE2IGF0IDE2OjIxIC0wNzAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiBEZXRlY3QgYW5kIHJlcG9ydCBhbiBlcnJvciBpZiBzZXQgZXhlX25hbWUvdGVzdF9uYW1l
IG1hdGNoZXMgdGhlDQo+IGRlZmF1bHQgb25lLA0KPiB0aHVzIGV4cGxhaW5pbmcgdG8gZGV2ZWxv
cGVyIGl0J3Mgbm90IG5lZWRlZCB0byBzZXQgaXQuDQo+IA0KPiBQaWVycmljayBCb3V2aWVyICgy
KToNCj4gwqAgdGVzdHMvdGNnL3Jpc2N2NjQvc3lzdGVtOiByZW1vdmUgZXhlX25hbWUgYXMgaXQn
cyBhbHJlYWR5IHRoZQ0KPiBkZWZhdWx0DQo+IMKgwqDCoCBvbmUNCj4gwqAgdGVzdHMvdGNnOiBk
ZXRlY3QgcmVkdW5kYW50IGV4ZV9uYW1lL3Rlc3RfbmFtZQ0KDQpSZXZpZXdlZC1ieTogQWxpc3Rh
aXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IA0K
PiDCoHRlc3RzL3RjZy9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDggKysrKysrKysNCj4gwqB0ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQgfCAx
IC0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K

