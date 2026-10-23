Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC283606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 05:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=EeWoyX3X;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=DVE1i21o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK7cX-0007ME-Bs; Fri, 23 Oct 2026 01:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK7cS-0007Kn-Qz; Fri, 23 Oct 2026 01:15:09 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK7cP-0005vy-Ew; Fri, 23 Oct 2026 01:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792732511; x=1824268511;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=Ho6B1jhIMvGuovAYG3yOHMP+dqCrh0XZ3y52vMpEEwI=;
 b=EeWoyX3XnuKgTe7fCOISyheCjUwN1nZJquD6Uj1dGFP9R2s0N6l+55e/
 928JPeg6APCNdeO93GA64r2/DT3R6iKYSgszdK2v98lbe/RWS2MFK0k4B
 2K9QeET0tPDL3hSD7TjHl9MricXsICNobAoJRUa+KKNeqfYJP4FIdhW3s
 IIp0DtAD12UwAvWLsND0qBBrLJbjI6NkTGMEMTg4g+Gg2uApw25+reuhg
 C4yI7HvqMBMg+Lx7Tam6WgttmD9ULf5fxSEBtjJnk4W+RG9HaiWYWCWpn
 Zw7j1BURXdwcI9f1q5zikmF57KrcNP5QhPIcD5b83eEOVrHos1n9eJ3GZ w==;
X-CSE-ConnectionGUID: XXToTME4Tiap529NpprHDA==
X-CSE-MsgGUID: qwvR+qF3QGy1ePJjDi+adg==
X-IronPort-AV: E=Sophos;i="6.27,173,1786982400"; d="scan'208";a="158705359"
Received: from mail-eastus2azon11011053.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.53])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Oct 2026 13:15:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0mhvHq/M1UAOE51ZfsOTPVJ0mKe98bl/5cY/+u8KOfITxUD83n9IN+MpmwGaPBT/dKTPZgaoxyLmAthlyFxguxjkSQBKCXTaYyKeU989u4XsgMyhCpp6BI/9ExC1CWK9BLGy0EyVWgEmZZd22o5FaT79PvbEzZci9wnL5LJTXX94Q+xiKdVZ9G04cGT5Udv1AyXdhQwTlbWbKtV2ytijxaCbMOr2wjCUkwz9pYDn9vNHUXujzzqn/jgXipJebmlttmZyrUBY3w49IIeEEFSvxG9dB+aOT+Pbu8vf+4pfefcPkmJTbuhFrD4bBKRA58wjVlezDKDg7vaZ4SFz4qiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho6B1jhIMvGuovAYG3yOHMP+dqCrh0XZ3y52vMpEEwI=;
 b=GRZRDS2tJK0blzzqqoaU7Wqb0iul6hCcuJ42qmAN9+e4V5W7LDuKITq7d2UjkxZJo9+x6WVe9FMdn8/J3O9PyOSfIvUZEJWREf0hQqdUO9QBEJa0mbHpgFjJw0Hjx0egfMn7B476C8NegRnD+ujUULlqukV2vtcKW/ExKi3JmeEgNo88g+taU90EBETdvwbvewyyjndOtbIspn8ZXFQuMj1+2Sw3+qU0Z9RYov3a2CQ+6Z7XiIY96Ohpp0iQMlw5FGl7guyjmTimPuFrJMez0KJgJXG3TCauLLQD5bE9yjbPoPUw1MhkIGY+s0Klu8slL4tjIiil+pH3epCqaBn3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho6B1jhIMvGuovAYG3yOHMP+dqCrh0XZ3y52vMpEEwI=;
 b=DVE1i21on13JJOBHGGJLMiCWFkHNm+3Vd7HvhSTa/kMfHh5K0V8/0mUhBYXIonhod69Jv7zCVl1uqlnE7m16oGFCSdCBYYZuZqU4NIh1BPricfRajFoRvjuLv2X8izS3XOhRQcAe6x70k7uwYPkRKp0YCO1hbxCNgVMKRvkCEcc=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SADPR04MB946953.namprd04.prod.outlook.com (2603:10b6:802:101::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 05:14:59 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 05:14:59 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "frederic.petrot@univ-grenoble-alpes.fr"
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: Re: [PATCH v2 2/2] target/riscv: fix riscv_cpu_do_interrupt sanitize
 error for x-rv128
Thread-Topic: [PATCH v2 2/2] target/riscv: fix riscv_cpu_do_interrupt sanitize
 error for x-rv128
Thread-Index: AQHdYheO2YV0YHxXcEOr52fwCTS2NLcKlraA
Date: Fri, 23 Oct 2026 05:14:59 +0000
Message-ID: <31c4f71a924f57f20b2427bf4c49e8e4fb4b10bc.camel@wdc.com>
References: <20261022112145.356726-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20261022112145.356726-3-frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <20261022112145.356726-3-frederic.petrot@univ-grenoble-alpes.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SADPR04MB946953:EE_
x-ms-office365-filtering-correlation-id: b1f975ff-cfeb-4d14-9912-08df30c49607
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|19092799006|23010399003|38070700021|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: lL7qTPako06dX5z0R/hJGuq7/15ZQm9jV/Uz4UKmvlEQj4BDN51hL+JOfMQYLTr3hUQbw29JcU6FLMO6Ki4/7gcXa2xwOjDE8Z9qj1kxxr4vSBq96j+rGu2RKYQcGPyYXuKlagJoTTWSdtsRlcK/MUGDFePuDffBZWOOWxoZJRpGoNeHyzt9oqu/gTrrMArNvMr1rq/XQ02IfRCtWlHSImapxMs62GPwTNL29RCpkmbIGhcAougz/v+4UmXmrpt9+wq30HM5gVVSKnZFHddfpGnE5dza7DcNrP2zetHVSbatbaQA5kgihp37PB7pcz4mQXC4AfxLwp8V7thH0eQnzlauGjBeY/YGzOhRv6NNGwO4WvimJ3wyWvf8880x8vqDHOeUknr9AEB7mL6PmuFuihZ5qCatQlu7K6uKUdgLxw+5ffgd+bOm5RMdQ/D0KfTdx4HpgG5IWr3HgEu2rI1r3ChRGKO3uylwyOykULDJr9mOtPTLaE/j2cyvWtldxEN5m7wrQiobBp1u3ZUp0+z1ZGSazeKU03lg+wMSO4kPjjpoAUuH/k+g+MKdaV8j8TD0NL1gqggATiFSHilVN3ZwblVUVYakNnONR27YGI86MWEier++ypIgh2TuiipOzbqU4hjTJ57edaG7oBTZTeFuOEohAABQJzc6ZMxWd2wFu9VNU8VWwJHhOAflds7NNaN5It4cJJJKrMJTLmQnnkJsyipE0ve71cK/5BIFbY2/g6g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(19092799006)(23010399003)(38070700021)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Snloa3JKVnE5S3FqVEFXWElLU0t0ZVFxa3IzREM1MkxRSlkxYVU0c0NXS1pV?=
 =?utf-8?B?NzRwWVZOaEtNZGJ6b1pPOE5WenoxMlpFajJYV0tHQUtTenVOV1RSK0pLT3lv?=
 =?utf-8?B?NityT2tvUk9mQzgzalJHODZzYVM0VGJyR29OMFliME9QV1R5c20vejgxMHZs?=
 =?utf-8?B?U2l0T2NUOGlrdXpjdlZORGhQeVFlMGk0TVZodkV5TU15Vy9rT2F0TGxMUFRH?=
 =?utf-8?B?UDFicmV0NXliU3U4b2tXUHJuZWZGL0R4QmlBSGZpTUhaY09wYWxxUkhrbkhL?=
 =?utf-8?B?YWhRZWxyb01aS1planU1UU5tckU1QVBEaHlPV0d2VFkrMFRmU1QwT0FNL2to?=
 =?utf-8?B?dHhaYTZkL0ttdTkxQUNFN1ZxTW1vdjQvbVljYktXeWdOcnYraEJuelhNSmJt?=
 =?utf-8?B?RU51M1dnbVJZNjBNOEVkaWVLMSthY0lSdzhrVVBFU2Rkd0M3bTV1dEkyV1Ju?=
 =?utf-8?B?bnFXcUhlUWo3dUxqTmIxNWpIdzQ2N25xZVUxLzZiSmhCY3JjOUtoaDd3eVZE?=
 =?utf-8?B?MEVERUZsa1REaU9MMFVNVzdtMStLek8wV1BmbTV6a2R2S0ZZdmd4dkVTZkxj?=
 =?utf-8?B?VDBqbG0wZ2dmWWo4cnlxZ1NBcS9qTHVvMllHSzNZbU9BMTVncEhCbExxNzBs?=
 =?utf-8?B?WXltTVgxYUVuTjJGSkxnS0ZWTTVaNUxjZW9VQlpkVjFmcnZZdTFySUkyczE1?=
 =?utf-8?B?ejJybC9pczVOQVNUWWE2KzdxOWw0NzhxaDQzWmNGYUp6Mmh5WEZ1b1dUZFJP?=
 =?utf-8?B?YS9KNFNWQnhZaEFrZnpsVDZaN1JzbEJ4Q3JKTHJFZUQ4T3FuZmc5YVVTaW9v?=
 =?utf-8?B?VENXVDlIb1oxMDdBOEo1d0dFaERXQlhLamM1QmQ0TWRzV0U2T3VmTUVsN0Np?=
 =?utf-8?B?cUFoVFdvZDZSTUlmcHlLRTRNUWJCeVZtdmlGRDRaSis2N013cGljTmp5ZlN3?=
 =?utf-8?B?VkRURFdYdzFFU282cStpN1M3MW9rNWk3ZXpoWGVIQnF6NmZYM3E4SGZXLzAv?=
 =?utf-8?B?RU9URnZRMVZMcWFnVk05UU5zNmNYR1luOGhiR09PU3liSjc2Q3RrUEdrVVFH?=
 =?utf-8?B?QTdIVUxoVEVvTXBxSld4UGgxVDNNa1l3T1k1UldDMzVWOTJuTnZqNjh0ak5j?=
 =?utf-8?B?bTFkNnBOeloyTy9BTVpIUW1BSC9kOExOdTVxL0gvVjBLaFVXU1lrNG5QV2hs?=
 =?utf-8?B?d08xUWxQMkg4aTBLT1NpeThPODh3NEh5YXJyWTdsRWgzZmxBTjhCSDA0aUJt?=
 =?utf-8?B?bmZXSXdxY0tJeW9SaE1KNCtnZElERUxqYk1QT1RJT3A5OUo5UHpoZVlSUi9o?=
 =?utf-8?B?WDZvUE0yOUpxOFZZNGtNZE1GN0pVdTFFbHZXQlpkWHFGMVM1QWgyQnVWajNI?=
 =?utf-8?B?VU9ZMzhrclhSQTBSeFpvelFRTUlSN0oxRjRnTERsY2NKZUgvVFlmcTc2ZUo0?=
 =?utf-8?B?b0ExWVc3ZGk5QWRUK1p5UFBjc05KRmozSm5NQ09wNG9ETFQ2ZXhLd2diU1g0?=
 =?utf-8?B?cmZ6bkdPeDZuNXhFdytuSGZEOEJWOE1qVlU1dk04dE1qRER5cWdORCsyeCs2?=
 =?utf-8?B?bGtsSGhseEU4T2JTdDJIclpPWjhjekdOQ1lYSi9BUVAvM2tIaGFiSnBPeXhK?=
 =?utf-8?B?RFlrb0dheUpTeElTb0RqZFhOZ05EdE5zT1dWUFlpakF2OEdFc2owSExmb1VG?=
 =?utf-8?B?bkxCaHc2NzE2SnlFdUVhYkpvWFdGbUdIamlIYUJNamk1VzRWK3pzV0Z6azUv?=
 =?utf-8?B?dldGMVFRTDNWS2J6blltRllEOTRQRmJtWkdwa0FTVFFadkU1bE9udWVxVmFV?=
 =?utf-8?B?c3NkbklCS0E0QUxSc0l6aitUZ2xWNGpld2t2enkyais4aUdQU1o2THhEKzIx?=
 =?utf-8?B?cjM2Ukd3dFFqbVo5QmNjeldSOFI5TmZQUk5XdnNuYjM5V2JERzZlWklEbjVm?=
 =?utf-8?B?WjhmTG9jbjVZTE9mYzhLMmZqZXlBSVlhNDFKbzdtL0lqSXE3N3ZoNVVlTzZS?=
 =?utf-8?B?Um9lempZTzNHTUNObXBocG84U0d3Rk5hT1JnR3YrTW5odUsxN0FLeFdJamFB?=
 =?utf-8?B?bC80S0RFTTMwY0VZVi9WeThhNzJkVGRpVEorR3haSzNCdERGK0hCd3BtYXVh?=
 =?utf-8?B?dFQ1UVFnbjUwWmZDTXdud3BwcktFSEhjTlBNak92Z2k4Q3d3MGV0Nk9XQ3pD?=
 =?utf-8?B?d2g0YmtzU3JBZWozRUlPeUQrVjhpSFFkd3FJeWdPdzd4eER4TEcwUjQyNEpz?=
 =?utf-8?B?T0NJdUhhWEZEcVN0RlZ3MmJWY0NxU0ZiRXZZZFJVY00yMlpjam0rTGZSbE5U?=
 =?utf-8?B?YkNQaHkzbnBzUzR1S1hXMy96UUZhMlhoMGJxMzVDc1lUbEczZlpQdG4yeXVC?=
 =?utf-8?Q?m+q0JaR0iEia3KLsKebqiir3Va+6u9rp1QRFIReCF7y32?=
x-ms-exchange-antispam-messagedata-1: zq3G6ukdrrxZAbWKGLujIdL1WGZy/M9c8h4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB4F5FCABEC4624D860E28F4BA84AB87@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h0BRuLFbn5pJMTn8hoNm8btPGE14cAcQHXI//EnBVI9/4gHsPwnAsNUUvAEQm6aRevxunsS0AtgT4yAM7nNKh0Y1xZwS10RkLy+RB+u1woKnwbBFb25x84HeLijQOHnD9ZMGI25o9+HCz2dLfYKh5NRz+Q0E5t4dGS/5V6g7AP3+lUhU49UxzUOoeexXvEl5j4IW1JMYSCkSU+vKsBPbM4AtNnlto5/QzUygv8lOJdE2hjLWlBVeip+QJTnNvP2TFqazruPvEjDm+quSk74a9r/DZEQBU1VHInygl8HNkDD0F5H+7vyCAKhFa4DkZIkTSPmbOY6K/bR5Rph291LwKA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kUaRbmIdvL7p2hfzbYmPjvZX5F9xEMk5QG1baRLY1jL0Hpp/Jd7CkuE22fTDze5GUIurHIsVaUBxRkKkzH2u6U0c5Ue4dRtDRjpsM9LiEzlo25j3OB3dN1a8fvRdMWKOclfWpUysFknR4Hb5KjDTCBhPOmAaQ8pXiyKTLXlcrvc4R9DBeUzvTUaFSNcS7fuTIgHQ0QTt+lKIFwehU8KNyIk/CCBcZcEoveHUqcFCVN0gxi+R620f2Iot7o8xoovKlQrjhNP2jED4w40X6vDZUldLqN7eLzey+PWEcS4+2QZ97QhzcHTh8sslncEMNn5S1mdTbG4WxGoFVXEnBBJ/z6zSXFqUX5ig46/nj/Vq2sXx0/3gVn4ZJzZ9APFjNnrPKdb3dRkCzTsZDh0DcXRiyKXye1OFBLTUMNkLVmQvclHfOltq14RmTSpgDEq6IAHBWl3dGEV/zIOS517YIrXGnSXwEA5B8wGSciPLbqZrg57jwpsxCAbaQ3BSvqe4gBDS3+FrV/7baS6OiSC3YGy/fiqlQnRA9ChCYukAffmXb4SFGLTgDm/8gnSJkQgGTqSPzIj9f03j4aCm77VSIgJQTcXipA+jop2jZAS1GVX3Wuc2LnEktsT7ZfRgKofwYmED
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f975ff-cfeb-4d14-9912-08df30c49607
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 05:14:59.8059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zDDbvOcvalzQp/Y2M6wsYiZpKriQGiA35FfJ6QvaKMKdLTw7Hsa0Bo2hJy5UxuC8LuIwKHpig6OyPxup1LlR2Z3AUpGiMOBpeHtIZdmVPgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SADPR04MB946953
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=749f58b73=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
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

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDEzOjIxICswMjAwLApmcmVkZXJpYy5wZXRyb3RAdW5pdi1n
cmVub2JsZS1hbHBlcy5mciB3cm90ZToKPiBGcm9tOiBGcsOpZMOpcmljIFDDqXRyb3QgPGZyZWRl
cmljLnBldHJvdEB1bml2LWdyZW5vYmxlLWFscGVzLmZyPgo+IAo+IFVuZGVmaW5lZEJlaGF2aW9y
U2FuaXRpemVyIHJlcG9ydHMgYW4gdW5kZWZpbmVkIGJlaGF2aW9yIHdoZW4gc2V0dGluZwo+IHRo
ZSBJbnRlcnJ1cHQgZmxhZyAobXNiKSBpbiB0aGUgW21zXWNhdXNlIHJlZ2lzdGVycyBkdWUgdG8g
YW4gb3V0IG9mCj4gYm91bmRzIHNoaWZ0Lgo+IFdlIHNwZWNpZmljYWxseSBjb3JyZWN0IHRoZXNl
IGNhc2VzLCBsZWF2aW5nIHRoZSBvbmVzIGRlcGVuZGluZyBvbgo+IHNwZWNpZmljIGV4dGVuc2lv
bnMgdW50b3VjaGVkLgo+IAo+IFJlcG9ydGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc+Cj4gU2lnbmVkLW9mZi1ieTogRnLDqWTDqXJpYyBQw6l0cm90Cj4gPGZy
ZWRlcmljLnBldHJvdEB1bml2LWdyZW5vYmxlLWFscGVzLmZyPgo+IC0tLQo+IMKgdGFyZ2V0L3Jp
c2N2L2NwdS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArKwo+IMKgdGFyZ2V0L3Jpc2N2
L3RjZy9jcHVfaGVscGVyLmMgfCAxNCArKysrKysrKysrKystLQo+IMKgMiBmaWxlcyBjaGFuZ2Vk
LCAxNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90YXJn
ZXQvcmlzY3YvY3B1LmggYi90YXJnZXQvcmlzY3YvY3B1LmgKPiBpbmRleCBiNjVkNjMxOTk0Li4x
N2JmY2YzOGMwIDEwMDY0NAo+IC0tLSBhL3RhcmdldC9yaXNjdi9jcHUuaAo+ICsrKyBiL3Rhcmdl
dC9yaXNjdi9jcHUuaAo+IEBAIC0zNTQsMTAgKzM1NCwxMiBAQCBzdHJ1Y3QgQ1BVQXJjaFN0YXRl
IHsKPiDCoMKgwqDCoCB1aW50NjRfdCBzdHZlYzsKPiDCoMKgwqDCoCB1aW50NjRfdCBzZXBjOwo+
IMKgwqDCoMKgIHVpbnQ2NF90IHNjYXVzZTsKPiArwqDCoMKgIHVpbnQ2NF90IHNjYXVzZWg7Cj4g
wqAKPiDCoMKgwqDCoCB1aW50NjRfdCBtdHZlYzsKPiDCoMKgwqDCoCB1aW50NjRfdCBtZXBjOwo+
IMKgwqDCoMKgIHVpbnQ2NF90IG1jYXVzZTsKPiArwqDCoMKgIHVpbnQ2NF90IG1jYXVzZWg7CgpU
aGlzIGlzbid0IGNvcnJlY3QgdGhvdWdoLCB0aGVyZSBpcyBubyBtY2F1c2VoIENTUiBpbiBSSVND
LVYKCkkgZG8gdGhpbmsgdGhpcyBpcyBnZXR0aW5nIGhhcmQgdG8ganVzdGlmeSBhcyB3ZSBhcmUg
YWRkaW5nIENTUnMgYW5kCkNQVSBzdGF0ZSB0aGF0IGRvZXNuJ3QgYWN0dWFsbHkgZXhpc3QgYW5k
IHRoZXJlIGFwcGVhcnMgdG8gYmUgbm8gZWZmb3J0CnRvd2FyZHMgbWFraW5nIGl0IGV4aXN0IChm
cm9tIGEgUklWIHBlcnNwZWN0aXZlKS4KCkl0J3Mgbm90IGNsZWFyIGlmIHRoZXNlIHNob3VsZCBq
dXN0IGJlIDY0LWJpdCBDU1JzCgo+IMKgwqDCoMKgIHVpbnQ2NF90IG10dmFsO8KgIC8qIHNpbmNl
OiBwcml2LTEuMTAuMCAqLwo+IMKgCj4gwqDCoMKgwqAgdWludDY0X3QgbWN0cmN0bDsKPiBkaWZm
IC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9jcHVfaGVscGVyLmMKPiBiL3RhcmdldC9yaXNjdi90
Y2cvY3B1X2hlbHBlci5jCj4gaW5kZXggNThlOThlOTc1Yy4uYjM1YjYxZGMwMSAxMDA2NDQKPiAt
LS0gYS90YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYwo+ICsrKyBiL3RhcmdldC9yaXNjdi90
Y2cvY3B1X2hlbHBlci5jCj4gQEAgLTIzNzUsNyArMjM3NSwxMiBAQCB2b2lkIHJpc2N2X2NwdV9k
b19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNzKQo+IMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKg
wqDCoMKgwqAgZW52LT5tc3RhdHVzID0gczsKPiDCoMKgwqDCoMKgwqDCoMKgIHN4bGVuID0gMTYg
PDwgcmlzY3ZfY3B1X3N4bChlbnYpOwo+IC3CoMKgwqDCoMKgwqDCoCBlbnYtPnNjYXVzZSA9IGNh
dXNlIHwgKCh0YXJnZXRfdWxvbmcpYXN5bmMgPDwgKHN4bGVuIC0gMSkpOwo+ICvCoMKgwqDCoMKg
wqDCoCBpZiAocmlzY3ZfY3B1X3N4bChlbnYpICE9IE1YTF9SVjEyOCkgewo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGVudi0+c2NhdXNlID0gY2F1c2UgfCAoKHRhcmdldF91bG9uZylhc3luYyA8
PCAoc3hsZW4gLQo+IDEpKTsKPiArwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlbnYtPnNjYXVzZSA9IGNhdXNlOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGVudi0+c2NhdXNlaCA9ICh0YXJnZXRfdWxvbmcpYXN5bmMgPDwgNjM7Cj4gK8KgwqDCoMKg
wqDCoMKgIH0KPiDCoMKgwqDCoMKgwqDCoMKgIGVudi0+c2VwYyA9IGVudi0+cGM7Cj4gwqDCoMKg
wqDCoMKgwqDCoCBlbnYtPnN0dmFsID0gdHZhbDsKPiDCoMKgwqDCoMKgwqDCoMKgIGVudi0+aHR2
YWwgPSBodHZhbDsKPiBAQCAtMjQ0Nyw3ICsyNDUyLDEyIEBAIHZvaWQgcmlzY3ZfY3B1X2RvX2lu
dGVycnVwdChDUFVTdGF0ZSAqY3MpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMgPSBzZXRf
ZmllbGQocywgTVNUQVRVU19NRFQsIDEpOwo+IMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKg
wqDCoMKgwqAgZW52LT5tc3RhdHVzID0gczsKPiAtwqDCoMKgwqDCoMKgwqAgZW52LT5tY2F1c2Ug
PSBjYXVzZSB8ICgodGFyZ2V0X3Vsb25nKWFzeW5jIDw8IChteGxlbiAtIDEpKTsKPiArwqDCoMKg
wqDCoMKgwqAgaWYgKHJpc2N2X2NwdV9teGwoZW52KSAhPSBNWExfUlYxMjgpIHsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBlbnYtPm1jYXVzZSA9IGNhdXNlIHwgKCh0YXJnZXRfdWxvbmcpYXN5
bmMgPDwgKG14bGVuIC0KPiAxKSk7Cj4gK8KgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZW52LT5tY2F1c2UgPSBjYXVzZTsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBlbnYtPm1jYXVzZWggPSAodGFyZ2V0X3Vsb25nKWFzeW5jIDw8IDYzOwo+ICvCoMKg
wqDCoMKgwqDCoCB9CgpJdCdzIGdyZWF0IHlvdSBzZXQgdGhlc2UsIGJ1dCB0aGV5IGFyZSBuZXZl
ciByZWFkIG9yIHVzZWQgYW55d2hlcmUKCkFsaXN0YWlyCgo+IMKgwqDCoMKgwqDCoMKgwqAgaWYg
KHNtb2RlX2RvdWJsZV90cmFwKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudi0+bXR2
YWwyID0gZW52LT5tY2F1c2U7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudi0+bWNhdXNl
ID0gUklTQ1ZfRVhDUF9ET1VCTEVfVFJBUDsK

