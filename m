Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C3606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 00:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=aRSrMyZO;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=faMJRugd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRISy-00007p-Gb; Wed, 11 Nov 2026 19:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRISw-0008WT-HG; Wed, 11 Nov 2026 19:14:58 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRISu-0002Jn-AN; Wed, 11 Nov 2026 19:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794442496; x=1825978496;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Y7jxrdtVbR3RECu+L4opBmS3N7d1TIY0JXLEvInBCzo=;
 b=aRSrMyZOY+aydj2EXzgjbjdaJAf/3laxtA1AGPZsOlOFWh45ZUYAAqD4
 Ll3Luv7S2gB8jezwKZdmq6/K9Iq5oSu8v6WQPEtOSBGBXEutn5fb9L8r5
 rArhjU6TEGTmLEZ1u4Z4dqgrOY8nAPaI31Q+1FLY1TjK0D/TSQo+rcVOb
 HeeL3PkeBlXguwxSOZvyGjnwhw1UHM6cYu4dbAKEYClW7cWVXjYiACZEX
 3sN+uf8e9Rtm0O6ycljwtFZjSJu44q9nyR/pTY3FKAlLkvH7Nb2VOB4ge
 YgpeFLmD69aqkXh/ITY6exV3x2szUx4b4IIaWkjO0xzn3hCByMO+KbMrb Q==;
X-CSE-ConnectionGUID: eknZmoF1SVuS6Wp9F++SzA==
X-CSE-MsgGUID: 9zIMmq7GSvygWJu4RaE6Gw==
X-IronPort-AV: E=Sophos;i="6.27,208,1786982400"; d="scan'208";a="161653232"
Received: from mail-southcentralusazon11013050.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.50])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 08:14:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPIxilAIezVi43ex+F0Nc0sZldau1OxTYR8IUQNzVaZJfjlLUkdyXX7xeQ59EleYb5S8lQEKmAk1SLua7HLyBasSaBvp/JJwpp57wmfaUZ9Q+J1bWPfugnkbjqfGclVq/8RJfhiiu80YsJNbj/goQbyC6L2C4f2koVmdf7XSUlX7ea0wj0cJj0XRGdgzFFZ9+4ZAQW3KPqNQweGxCbKTGj25omSkCiL0kxGwHYiZKQfNbLsMbrmA9n3p5wt+h9bbPgvTsTfFhGlpzh3vNmzdXUpNUC9NkVjlp5J+J5qHSGZfQ2NypSupg+fUW0pU63AY2H1eBwaa7xi3/9LB9RDMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7jxrdtVbR3RECu+L4opBmS3N7d1TIY0JXLEvInBCzo=;
 b=opWS+ID07NXE7xa/hLf678GnvHedxCv3iZMgoOUWHXJ34PyV6aLAcFC17rLbZNhsRPCF2jY46uCUHtTSeOLmXC1ucZrBjoGoxxIS8y/OEUV47mfesdYkO/aJqlZgLuTVh9H+DH/d0yBtwPsPXdsItQTsW8Xrg4TUSjTKJB2RvfJ6tzA1X0XGGqU5dqNSiT1UIytVXRKXp12HVDGwFkjg7c93TftxeK9E6lhIwmGtg4L/84bvUmcorl/qSWj72cPz3N05vQr0QH8GFvfO2rhdJBc6XOE1+jwIZzogkkYevXu8+Mp53oBP1KmXBTb8WmtCkyYLmxnlfyyDzlG5zmCUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7jxrdtVbR3RECu+L4opBmS3N7d1TIY0JXLEvInBCzo=;
 b=faMJRugdQsu6bE6x9RL+vMz256NTdr3z6B73bj+OUrtz1Zw/Acf8xcjzIoB+mnjaas9dZTN9eoaMvnhxkLbh5MgvGFnC6R/RfaS/VBNYTNosy1E2ckyTgKz0rv9jCRkwn8JDeyK/PQ6VVaAu5jdUOW/ru1/LrQEJNC+QLvO3lPw=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by CYYPR04MB8907.namprd04.prod.outlook.com (2603:10b6:930:b8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 00:14:51 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 00:14:50 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "bin.meng@processmission.com"
 <bin.meng@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 2/2] docs/system/riscv: simplify the K230 U-Boot boot flow
Thread-Topic: [PATCH 2/2] docs/system/riscv: simplify the K230 U-Boot boot flow
Thread-Index: AQHdaQ0jE5b4KLIkL0GqoDeJxHwcvrcpo46A
Date: Thu, 12 Nov 2026 00:14:50 +0000
Message-ID: <85e252a42c329f68f5c64fa153b25f0bc18ac8de.camel@wdc.com>
References: <cover.1793433265.git.chao.liu@processmission.com>
 <be072504dde1626cc88a489805be5a988580bff3.1793433265.git.chao.liu@processmission.com>
In-Reply-To: <be072504dde1626cc88a489805be5a988580bff3.1793433265.git.chao.liu@processmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|CYYPR04MB8907:EE_
x-ms-office365-filtering-correlation-id: 88756474-77ab-466e-111e-08df4051f819
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|366016|10070799003|23010399003|261028144727099003|38070700021|10067099003|11063799006|56012099006|4143699003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223327099003|261009223027099003|261009220027099003|261009221227099003|261009221727099003|261026121527099003|261026140227099003|261022115727099003|261102123227099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: t455abtA6dmOZLBRAWLU4FROEkFUWnTPfMPUAwtQWjdH2W5pIt6LBuS0dXgR91ZItKq+JBuJ47RfShJuvlEJi6GLQPhKYYMqWuaZ7QM+rWFwGv7CbwihG9rKAsNl0lop0VzlGvLNyp4tj/hVI2SOYVRXiYtWeKp0IwCtvSB4FdqbBOonHKcWR+WPWV66T25Zzc8gDhM54dHBBkxkP8OEwzzLukSRH2tB6E0g5tSLv6bYJ3mNc06ThIG8mf91VaPa3cVI6FiU9ovtKygyMoWy/NeNSOflFqRzH+g88Co14NZU8xyn/37uhGuyX9WmnJmrPejNKwJXNjfzGRk5cjTq7UR/PPaiNoJVgQT8UN5hK78KWRgsePRH60imHitlx/t7TQBaYxllkEB5Qhd4zMx4CRKn/NpAmzesd7Rpj+pWL8ttQi2MsG2hikDjwYq2hEM+ZlhmKZ2fMPInyffbrF4RgCAabZ5IOHk3vkQNQC2SeAtQ4yGna15/KkJGTj1iz/1s5uoY0HRlZdYu7IpoUNCBwdffM+9jZXc/U4ixBfbb0uI+UUZSyoYb4QKAXJ354WUvaV3cpWLuUClOox8mxphq2+uNgyX0GK0ZnoiXFyaPvE72nl6zkSKpIcO+W5kt87Cx5p6wnPXtC2h4XJO1+F9NeoSSp+zbalSqNyHhiF3i0MShgHZf05F3W7fY+iNo99oVcPb9vHWHpPv8VWQcDSxHTeOD5jYcGZtFiLUNeajObAk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(10070799003)(23010399003)(261028144727099003)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221227099003)(261009221727099003)(261026121527099003)(261026140227099003)(261022115727099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXYvTHZJUVQ3RFlkZWg5ZHppMUZodW0zc0NSNWVCMHR1UXhOVk1aR1dqSmVa?=
 =?utf-8?B?VnR4NWpJQkJZWkFkS1E4ZFl2YWZSTTJqV3VzajRPRjc0a0ZNNGE0R0lHb09s?=
 =?utf-8?B?WVRTTDJhaUxFV2NDS1lBdnNGT3RLcjl4RWpTeXhrNXlleEVac2ozNGx0S21i?=
 =?utf-8?B?QVdpUGs5REtGYTgremduUWZUWjd1ODN1cmtMTHVzYmZnaWZJOS9naCs4NSth?=
 =?utf-8?B?ekNjc3Bkcjc0ZDQxN1h3VVBNMjhSSlBqUWJsV2NMVldTYXhFWGJtMWwveTds?=
 =?utf-8?B?UG5pL1hLWVQ5VzE1QVA0d0xiRUhuV1pyeThFRVova3ozY1FEY2I4R1hZOTd1?=
 =?utf-8?B?Q2xKMUZ3VktsdUdVMXprTGJ5S2s2amkwTVlaUXdJN2JkUFQraTNSTDE5UkQ5?=
 =?utf-8?B?WGdTc3JsUENMdzZlOHFHTzhGd25NQlBDTWFiVUp5dU03QklTelcyM0NlRno0?=
 =?utf-8?B?OTRoVHZjUStjYTRKRFpJTVEyY1N6V3pjWC9MTmpkU1J0RkdrQi9BbmMzdjBE?=
 =?utf-8?B?ZnhWUHcwQlNDN2ZsejFXb3R6UVRHWEVQNDV6dzNBdExnT2V5TTdWNFR1aUxu?=
 =?utf-8?B?YXplSHBFTVpjeG9tbThVdEZ6WGNKTitMY2VkZ3N0SUFuOVpQaVArNmxsTUQ5?=
 =?utf-8?B?ZTlLSU1oYjNLRDVyY0ZYeklia0ZBMkJ1LzlYUXlFVkRRWEJuOVRsd3gySlg2?=
 =?utf-8?B?VkMxNW95MnpNUlhiMDJVM0NjM1NZdldzRHJpblR1NVdSSUFDclU2MUQ4TVda?=
 =?utf-8?B?a2gya2Q3TmJaV2NKR0ZVa3BaVTJYNjk1RGZQSGxRTndaUDlYc2M3cjFUa2VB?=
 =?utf-8?B?UW9EQ1lIS21iL3JWdURla3NXVUhacFFwejNTVjZkYnp4cmQ5dFovQ0dwcmxa?=
 =?utf-8?B?YzRUcUQwRnlBWEpXZ3ZobFkzb05MUFRGL2ttczZlZERLQnN3VkRsajNPOFU2?=
 =?utf-8?B?aXBSWVpHdTdsdm9sWFp6bkNWRzZsV2QyMXA0TXREb1JXUERQandBTnlTcU5L?=
 =?utf-8?B?bjdxa1ByeDVweitHMTlCdFRoVVVxWW1GY3gzcmRkRmd2RDF1QU1YL053NEh0?=
 =?utf-8?B?QUdESWgzSUVPWFI5cFhrUmNWaDFRdnUrbGt3N2RLbDlrbjc2S0lGSG95eE9K?=
 =?utf-8?B?NFVpYWtyMnI3Zk5KR1Y1RnJIQWYzM09ZMm5Jd0VMSkMvOFN5b0ZQVCs1Y1I0?=
 =?utf-8?B?Sjd5UlBCWVM5NlMzOUxxRXZwZ1ZBbXBGK3BIQ25JeEE1YkZDNmtRVGgvdzB6?=
 =?utf-8?B?OUw3N09rZVViczY0a2ZrLzdmb0dhazAyZjhROHpyR25FcXo3V3VCT001YjZk?=
 =?utf-8?B?OU1MQ0MzU2s0dXRzWHJTZWtLaVl0Q1FtTFlNREJjSXhzMGloU3d4cHRwVnh6?=
 =?utf-8?B?ZG0wY1R4c2dKYnliMVhaZU0rR1NOek1uTFI5OGZZZW1OUlpOTDdCY0RwZkZ2?=
 =?utf-8?B?NU4rVVVIc0hYRWlnN2dVcExNZ3JYS0diSEkrNVFuSTJWY0pBd2I2NFpkUlNB?=
 =?utf-8?B?cVVvMVZoVUtIRTZFQkhkVmZPWEdlNVpUMTJGSWVRb2RneFFHdkR4bU1yK0dx?=
 =?utf-8?B?UnpBSHMvbGZzS1pZZy90RXhMVFJqRkpvSEx1aVl5L3AzYmEyVzJEbVErajdQ?=
 =?utf-8?B?cjI4dzAvZ0V0ZjR4Z0M3ZFhkeWNZSGdORU9OSHFVZFBiKytMVVVXNVpnV0RJ?=
 =?utf-8?B?MHRybEZoby9wNlhucGJZOWVKYzBjU3pBZGRmSkFmcEVab1dpbS9YbWJ0dytt?=
 =?utf-8?B?ckRuek5SenVXOHZLaEN1cENaVzlEUTkwVkt3YkF6dG5iQWlmWEIwM2hHZVA5?=
 =?utf-8?B?YUlsNm83Y1RXSGwyOWFGZTZRVHUwMEhhZG5KMzdCN2d6Q0VLNDZtRERFNDFo?=
 =?utf-8?B?bmJyM1REVHdlSzU4LzNrK25Bb1lTS2pnQitKMjZRNjJTQ0I1VHgrLy9BM2hx?=
 =?utf-8?B?d2E2dW02VGZVM3hCaDZCNWpsWHBuOU4yOTBPVk9OOFlpVWpnWTJjQ1gyT1pJ?=
 =?utf-8?B?aFQvcGk1M29YOFFjQVBLbnJ0ZjhBTHJyWkUyTmF5TzIvZjZBWjFkcXFaNEZQ?=
 =?utf-8?B?WVBldlpoL0JxQml0YWkrcXpGREdKSWRjakEzanJaTHJwRWYxb09qRFBUTDd6?=
 =?utf-8?B?VldPM2JGdGtIcTBuQWIvdWhFM1NoWXd0blBJbnlma2VZVngxUlNNQmVtSEZr?=
 =?utf-8?B?R2I2OTlkY29xZVlxMWtHUWpFNUQyTFFxK2pzWFY1eEhNWlc1Y3RsREgrVHJJ?=
 =?utf-8?B?dTZmQVFycFRnVElxUm0xZXBnNmlGUzloNklweU5nQnEwR1R5K2JaT2ZjTE5M?=
 =?utf-8?B?aUpndDlxaWtvT3N1QUIrNG1vNGlRNHBVOExqTk1OZSt5MGhIWUxLV0lmMlNQ?=
 =?utf-8?Q?YNX4eFZ1IRjGJk8T05jUgjCP2o3SAVXpmoMbrSedeMEbQ?=
x-ms-exchange-antispam-messagedata-1: szSRtr5Tgvql5s3uYK5s2tlDJIGK1WVcsVM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3117587A4DD6FE4F8B45E2878EDE4B92@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RtL2BQV9+XGQV089ihZJR/ZMHc/XzsaGnAFjTw+NdgNAAy3bN7rJ9jpbW8VUYyofbRG2yIWTP4ooNgMCYU0L2N6k9Xqkpcbztmgir0r11KOdFBEswNen95Mjg22IT43z4/CLvEPC2Bp0+EE47/VWvPwvy4ZXOZUmZ7slubqZfy6xOzpz2+yw1/4HnEtcHkvtSfBnG/MHt/T4mWR8GkB9DZZLGJsQGo0r7tEfcWkq3mgnZCkIjsG3JbRunT2VDdcnyhA6EE/NEOUGMmNP47mGtEg9+GDsuW6g6dFSAJrElVhmqeGv0nTx2p63rjE0bfWeDY2/Ubojyvh+a2dnorUCJg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D5nhTcB1vFrQW1x+e99fdyLqh6sZzl9Wn3dRDn5dM4Ks9UuuXyKr1SQfr6XqMuVOiWXEiRP4TuCiJ17UpbvKBNW/vfnJDTXQYoZ7U1gklBB9YzuXZX69G/YhevvJNZRPy/Lu7QzVu2SEu3hSYGD3db6wlkvxS6F4fhqYplxSVSeugStEq63Z0QvE/GufHWUjJ+MZjCMenQYN//nLOjPZ499nYyWEfhBMmnRzn19UzaAQj6yZ4YsAt3gXgJnOYRnb59u9lP1LudaNUJR+9UloE2I+dcHbnXKFmIP5AcMD/J3+U9MKjD759FEvb03V6n04gVGoX4lp5hQleEehkoJuUuSTmqWhViPxLsCObwyHe/+oBANwLWtpZ4yO15NvsqVKXT6D0trmMUlQ26bJd62rMgY5TbztSZW7orIgT+gc5cw6TU2nWbPI4YMBTGC7v7iWA6HzZgZatTQJqhzUODT57/3TLQjva+bmeUm7/PhL3PksfvCD80fn+vZ7am1YyGsIQKT9avZ/vUhIYtHgynLXdWY0cIzWJKcosPLN2cTiWBBHq5Urp9Il0LSOeScnVOeaPgvq0oqSBIXt4NmfpR4za7REg4UFwy6B3sv/h3WaETG/H74lM1sTZAKoxTg1imt0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88756474-77ab-466e-111e-08df4051f819
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 00:14:50.7596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7ZU0tj1ZR85BgCVrdkiDT6eGksDwxX0oPkF0A7yAzp/EPejySUpvJhpx03KM/FbsYNc9TlRrwcB9WXnOSuKQZU6VRvXj9wWvAPmj28TVek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8907
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=769f446c1=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU2F0LCAyMDI2LTEwLTMxIGF0IDE1OjU0ICswODAwLCBDaGFvIExpdSB3cm90ZToNCj4gVXBk
YXRlIHRoZSBmaXJtd2FyZSBib290aW5nIGRlc2NyaXB0aW9uIGluIHRoZSBkb2N1bWVudGF0aW9u
LCBhbmQgYWRkDQo+IHRoZSBRRU1VIGJvb3QgYXJndW1lbnRzIGZvciB0aGUgSzIzMCBpbWFnZXMg
YnVpbHQgd2l0aCBCdWlsZHJvb3QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIExpdSA8Y2hh
by5saXVAcHJvY2Vzc21pc3Npb24uY29tPg0KDQpBY2tlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8
YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGRvY3Mv
c3lzdGVtL3Jpc2N2L2syMzAucnN0IHwgNjAgKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+IC0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDQ2IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL3Jpc2N2L2syMzAucnN0
IGIvZG9jcy9zeXN0ZW0vcmlzY3YvazIzMC5yc3QNCj4gaW5kZXggMjM3NjExZWRkZi4uYTY1Y2Yw
MjkzMiAxMDA2NDQNCj4gLS0tIGEvZG9jcy9zeXN0ZW0vcmlzY3YvazIzMC5yc3QNCj4gKysrIGIv
ZG9jcy9zeXN0ZW0vcmlzY3YvazIzMC5yc3QNCj4gQEAgLTI2LDggKzI2LDggQEAgVGhlIGBgazIz
MGBgIG1hY2hpbmUgc3VwcG9ydHMgdGhlIGZvbGxvd2luZw0KPiBkZXZpY2VzOg0KPiDCoA0KPiDC
oEJvb3Qgb3B0aW9ucw0KPiDCoC0tLS0tLS0tLS0tLQ0KPiAtVGhlIGBgazIzMGBgIG1hY2hpbmUg
c3VwcG9ydHMgSzIzMCBTREsgYm9vdCB0aHJvdWdoIE0tbW9kZSBVLUJvb3QsDQo+IHdoaWNoIHRo
ZW4NCj4gLXN0YXJ0cyBPcGVuU0JJL0xpbnV4IHdpdGggYGBib290bWBgLiBJdCBhbHNvIHN1cHBv
cnRzIGRpcmVjdCBMaW51eA0KPiBib290Lg0KPiArVGhlIGBgazIzMGBgIG1hY2hpbmUgYm9vdHMg
dGhlIEJ1aWxkcm9vdCBiYXNlZCBLMjMwIFNESyBMaW51eCBpbWFnZXMNCj4gdGhyb3VnaA0KPiAr
TS1tb2RlIFUtQm9vdC4gSXQgYWxzbyBzdXBwb3J0cyBkaXJlY3QgTGludXggYm9vdC4NCj4gwqAN
Cj4gwqBUaGUgRERSQyBDRkcgYW5kIEREUiBQSFkgbW9kZWxzIGFsbG93IHRoZSBLMjMwIFNESyBV
LUJvb3QgU1BMIHRvDQo+IGNvbXBsZXRlIEREUg0KPiDCoGluaXRpYWxpemF0aW9uIGJlZm9yZSBs
b2FkaW5nIHRoZSBuZXh0IGJvb3Qgc3RhZ2UuDQo+IEBAIC02Nyw1MyArNjcsMjEgQEAgbm90IGVt
dWxhdGVkIGJ5IHRoaXMgbWFjaGluZS4NCj4gwqBVLUJvb3QgYm9vdA0KPiDCoH5+fn5+fn5+fn5+
DQo+IMKgDQo+IC1UaGlzIGZsb3cgc3RhcnRzIFNESyBVLUJvb3QgaW4gTS1tb2RlIHdpdGggYGAt
Ymlvc2BgLiBVbnRpbCB0aGUgU0RLDQo+IHN0b3JhZ2UNCj4gLXBhdGggaXMgbW9kZWxlZCwgcGxh
Y2UgT3BlblNCSSwgTGludXgsIGluaXRyZCwgYW5kIERUQiBpbiBSQU0gd2l0aA0KPiBsb2FkZXIN
Cj4gLWRldmljZXMgYW5kIHJ1biBgYGJvb3RtYGAgbWFudWFsbHkuIFRoZSBMaW51eCBJbWFnZSBt
dXN0IGJlIHJlYnVpbHQNCj4gd2l0aA0KPiAtc3RhbmRhcmQgUklTQy1WIFBURSBiaXRzIGJlZm9y
ZSBydW5uaW5nIHVuZGVyIFFFTVUuDQo+ICtUaGUgSzIzMCBTREsgYnVpbGQgaXMgYmFzZWQgb24g
QnVpbGRyb290IGFuZCBwcm92aWRlcyB0aGUgWHVhbnRpZQ0KPiB0b29sY2hhaW4NCj4gK3RoYXQg
YnVpbGRzIExpbnV4IGZvciB0aGlzIG1hY2hpbmUuIFRoZSBpbWFnZXMgY2FuIGFsc28gYmUgYnVp
bHQNCj4gd2l0aCB0aGUNCj4gK3N0YW5kYXJkIEJ1aWxkcm9vdCBmbG93IHdoaWxlIHJldXNpbmcg
dGhhdCB0b29sY2hhaW4uIFRoZSBtYWNoaW5lDQo+IGJvb3RzIGJvdGgNCj4gK3RoZSBpbWFnZXMg
cHJvZHVjZWQgYnkgdGhlIEsyMzAgU0RLIGJ1aWxkIGFuZCB0aGUgaW1hZ2VzIHByb2R1Y2VkIGJ5
DQo+IHRoZQ0KPiArQnVpbGRyb290IGJ1aWxkLg0KPiArDQo+ICtTdGFydCBTREsgVS1Cb290IGlu
IE0tbW9kZSB3aXRoIGBgLWJpb3NgYCBhbmQgcHJlbG9hZCB0aGUgT3BlblNCSQ0KPiBhbmQgTGlu
dXgNCj4gK0ZJVCBpbWFnZSB3aXRoIGEgbG9hZGVyIGRldmljZToNCj4gwqANCj4gwqAuLiBjb2Rl
LWJsb2NrOjogYmFzaA0KPiDCoA0KPiAtwqDCoCAkIFNESz1rMjMwX3Nkay9vdXRwdXQvazIzMF9j
YW5tdl9kZWZjb25maWcNCj4gLcKgwqAgJCBJTUFHRT0kU0RLL2ltYWdlcy9saXR0bGUtY29yZS9J
bWFnZQ0KPiAtwqDCoCAkIElOSVRSRD0kU0RLL2ltYWdlcy9saXR0bGUtY29yZS9yb290ZnMuY3Bp
by5neg0KPiAtwqDCoCAkIERUQj0kU0RLL2ltYWdlcy9saXR0bGUtY29yZS9rMjMwLmR0Yg0KPiAt
wqDCoCAkIEZXSlVNUF9VSU1BR0U9L3RtcC9rMjMwLWZ3LWp1bXAudUltYWdlDQo+IC3CoMKgICQg
SU5JVFJEX0VORD0kKHByaW50ZiAiMHgleCIgJCgoMHgwYTEwMDAwMCArICQoc3RhdCAtYyAlcw0K
PiAiJElOSVRSRCIpKSkpDQo+IC3CoMKgICQgIiRTREsvbGl0dGxlL2J1aWxkcm9vdC1leHQvaG9z
dC9iaW4vbWtpbWFnZSIgXA0KPiAtwqDCoMKgwqDCoCAtQSByaXNjdiAtTyBsaW51eCAtVCBrZXJu
ZWwgLUMgbm9uZSBcDQo+IC3CoMKgwqDCoMKgIC1hIDB4ODAwMDAwMCAtZSAweDgwMDAwMDAgLW4g
b3BlbnNiaSBcDQo+IC3CoMKgwqDCoMKgIC1kICIkU0RLL2ltYWdlcy9saXR0bGUtY29yZS9md19q
dW1wLmJpbiIgIiRGV0pVTVBfVUlNQUdFIg0KPiDCoMKgwqAgJCBxZW11LXN5c3RlbS1yaXNjdjY0
IC1tYWNoaW5lIGsyMzAgXA0KPiAtwqDCoMKgwqDCoCAtYmlvcyAiJFNESy9saXR0bGUvdWJvb3Qv
dS1ib290IiBcDQo+IC3CoMKgwqDCoMKgIC1kZXZpY2UgbG9hZGVyLGZpbGU9IiRGV0pVTVBfVUlN
QUdFIixhZGRyPTB4YzEwMDAwMCxmb3JjZS0NCj4gcmF3PW9uIFwNCj4gLcKgwqDCoMKgwqAgLWRl
dmljZSBsb2FkZXIsZmlsZT0iJElNQUdFIixhZGRyPTB4ODIwMDAwMCxmb3JjZS1yYXc9b24gXA0K
PiAtwqDCoMKgwqDCoCAtZGV2aWNlIGxvYWRlcixmaWxlPSIkSU5JVFJEIixhZGRyPTB4YTEwMDAw
MCxmb3JjZS1yYXc9b24gXA0KPiAtwqDCoMKgwqDCoCAtZGV2aWNlIGxvYWRlcixmaWxlPSIkRFRC
IixhZGRyPTB4YTAwMDAwMCxmb3JjZS1yYXc9b24gXA0KPiArwqDCoMKgwqDCoCAtYmlvcyB1LWJv
b3QgXA0KPiArwqDCoMKgwqDCoCAtZGV2aWNlIGxvYWRlcixmaWxlPWJvb3QuaXRiLGFkZHI9MHhj
MTAwMDAwLGZvcmNlLXJhdz1vbiBcDQo+IMKgwqDCoMKgwqDCoCAtbm9ncmFwaGljDQo+IMKgDQo+
IC1UaGUgbG9hZGVyIGFkZHJlc3NlcyBtaXJyb3IgdGhlIFNESyBgYGsyMzBfY2FubXZfZGVmY29u
ZmlnYGAgb3V0cHV0Lg0KPiBSZWFkIHRoZQ0KPiAtVS1Cb290IGFkZHJlc3NlcyBmcm9tIHRoZSBn
ZW5lcmF0ZWQgZW52aXJvbm1lbnQsIGFuZCByZWFkIHRoZSBMaW51eA0KPiBSQU0gYmFzZQ0KPiAt
ZnJvbSB0aGUgZ2VuZXJhdGVkIGBgaHcvazIzMC5kdHMudHh0YGAuIFRoaXMgcmVwbGFjZXMgdGhl
IFNESw0KPiBzdG9yYWdlIGFuZA0KPiAtZGVjb21wcmVzc2lvbiBzdGVwcy4NCj4gLQ0KPiAtUHJl
c3MgRW50ZXIgdG8gc3RvcCBhdXRvYm9vdC4gQXQgdGhlIFUtQm9vdCBwcm9tcHQsIHJ1biB0aGVz
ZQ0KPiBjb21tYW5kczoNCj4gLQ0KPiAtLi4gY29kZS1ibG9jazo6IGJhc2gNCj4gLQ0KPiAtwqDC
oCBLMjMwIyBzZXRlbnYgYm9vdGFyZ3MgY29uc29sZT10dHlTMCwxMTUyMDAgZWFybHljb249c2Jp
IGNtYT0wDQo+IC3CoMKgIEsyMzAjIGZkdCBhZGRyIDB4YTAwMDAwMA0KPiAtwqDCoCBLMjMwIyBm
ZHQgcmVzaXplIDgxOTINCj4gLcKgwqAgSzIzMCMgZmR0IHNldCAvY2hvc2VuIGxpbnV4LGluaXRy
ZC1zdGFydCA8MHgwIDB4YTEwMDAwMD4NCj4gLcKgwqAgSzIzMCMgZmR0IHNldCAvY2hvc2VuIGxp
bnV4LGluaXRyZC1lbmQgPDB4MCAke0lOSVRSRF9FTkR9Pg0KPiAtwqDCoCBLMjMwIyBmZHQgc2V0
IC9zb2Mvc2RoY2kwQDkxNTgwMDAwIHN0YXR1cyBkaXNhYmxlZA0KPiAtwqDCoCBLMjMwIyBmZHQg
c2V0IC9zb2Mvc2RoY2kxQDkxNTgxMDAwIHN0YXR1cyBkaXNhYmxlZA0KPiAtwqDCoCBLMjMwIyBi
b290bSAweGMxMDAwMDAgLSAweGEwMDAwMDANCj4gLQ0KPiAtVXNlIGBgc2V0ZW52YGAgc28gYGBi
b290bWBgIHdyaXRlcyB0aGUga2VybmVsIGNvbW1hbmQgbGluZSBpbnRvDQo+IC1gYC9jaG9zZW4v
Ym9vdGFyZ3NgYC4gVGhlIGBgZmR0YGAgY29tbWFuZHMgc2VsZWN0IHRoZSBsb2FkZWQgRFRCLA0K
PiBhZGQgc3BhY2UgZm9yDQo+IC1lZGl0cywgZGVzY3JpYmUgdGhlIGluaXRyZCByYW5nZSBpbiBg
YC9jaG9zZW5gYCwgYW5kIGRpc2FibGUgU0RIQ0kNCj4gbm9kZXMgYmVjYXVzZQ0KPiAtdGhpcyBt
YWNoaW5lIGRvZXMgbm90IGVtdWxhdGUgdGhvc2UgY29udHJvbGxlcnMgeWV0LiBSZXBsYWNlDQo+
IGBgJHtJTklUUkRfRU5EfWBgDQo+IC13aXRoIHRoZSBob3N0LWNhbGN1bGF0ZWQgdmFsdWUgYWJv
dmUgd2hlbiB0eXBpbmcgdGhlIGNvbW1hbmQuDQo+IGBgY21hPTBgYCBhdm9pZHMNCj4gLXRoZSBT
REsga2VybmVsIHJlc2VydmluZyB0b28gbXVjaCBvZiB0aGUgbGl0dGxlLWNvcmUgbWVtb3J5IHdp
bmRvdw0KPiBmb3IgaW5pdHJhbWZzDQo+IC1ib290Lg0KPiArVGhlIEZJVCBpbWFnZSBjYXJyaWVz
IE9wZW5TQkksIExpbnV4LCB0aGUgZGV2aWNlIHRyZWUsIGFuZCB0aGUNCj4gaW5pdHJhbWZzLCBz
bw0KPiArYGAtZHRiYGAgYW5kIGBgLWFwcGVuZGBgIGNhbm5vdCBiZSB1c2VkIHdpdGggdGhpcyBm
bG93Lg0K

