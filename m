Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C96606A32E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Phakbze2;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=Hwi/mKkR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRMgf-00084j-MB; Wed, 11 Nov 2026 23:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMgZ-000841-R3; Wed, 11 Nov 2026 23:45:20 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMgX-0003gJ-O3; Wed, 11 Nov 2026 23:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794458717; x=1825994717;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=NOgk+XWSzLbo1XKce35pxFVTvItZ/UJRDqXMwhlMMC4=;
 b=Phakbze2+XPrp9BNaf0+Utv+6rP+imz3s+bifJVxZURH44x0E3NeObZD
 bdL5kTFehdWR1om4YdsORjfBgpblCqs2el9d/z98ay+JrP7YIMmsMIY+K
 vZ0NKgg76CFs5UROW5HM08CjA6d87EHKUZhS95h/tJFhLVBEfxmBvvPE/
 tjdbzOzFZypcDXYH4lrdsgOKn71KZVx48kZHR2aW85v/PSvOJJ/8ZD/Po
 nlxsJ100QhR1rSSIv52ljM89AG2MMGOVT8llmzXfBVp9jaUIKP+2886ms
 HaoxDMdU1wTPhnCL+q2PNMSCYSiWJ6b+RXFNtYqeKhPqcHvQT04tetlrM w==;
X-CSE-ConnectionGUID: LZUT4oPCSk2R1Gj8yx20hg==
X-CSE-MsgGUID: cVfH6KfaSdGt8CJwSS8A6A==
X-IronPort-AV: E=Sophos;i="6.27,209,1786982400"; d="scan'208";a="161674763"
Received: from mail-eastus2azon11011061.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.61])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 12:45:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPUrpmevI0U+3qPT8FdtUsuZku6+HEPeYTSiFNJof3nFQXW2DJUYe2MwstcCZqFSwAD+HZgRdOcUegW5kwtinltipy7+Ib7jU3dkObc/d7rTB/kXVhhhPWtnQ5uPIXyFrCxrV7Huow5PO2aCzAyCt4Imyxo5OhK85zwiMHMfqOODw93cY3hYeDJgNOALvXst8QfvFLKqpYa8rJaYWXwDWbs1YRl347DN60ryAnF36nDmzU7pbRka7D9n36OxwRAaT1TsOjpZeLKaw79aweG/ce65PnxS8g+xX2kZ8HPyLtKl7WRua5Ibv6y8i5g5qKDQ3cCbOHm2nYcOp+nNqGricQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOgk+XWSzLbo1XKce35pxFVTvItZ/UJRDqXMwhlMMC4=;
 b=noRwMdYjcZAi7CPirKpcMC3RMkFCiNWg46wm4oMhSZ2+QYTUgZ5pQ/02u4KtK1iMBntwcwHhjToFX2kxi8laH3beGKefxjcoWJfJf2Jlq4C3ykoEpACCq1DFTBEXE02tH15pMdUajDzj4w7r0UmGcsdwe+bYXYOsP16xVGJV7Vds7/keWphTLx9xu6Jcu4SjQcgxYDZCinPm+h1nTAdiTqFUa19rsQkRHfU8FtXkR04/26sQXEHlpRDl8GeakdaBEDn6t/IWOg7meHH9EljSrjcxknE9wQDbPgqzbOmEj8awEZPgntcwPd6kDxA38Vovxrrz+m/otTXx2udMGVyxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOgk+XWSzLbo1XKce35pxFVTvItZ/UJRDqXMwhlMMC4=;
 b=Hwi/mKkRGEf745Na9ORuNzXjg4lgUFZ43ZV2HRQtQB9Dx+WltUyHzbDE78KO3H27w2Y0eHKwkiQMxus+eWZNzogEQVCw9IQGA1fPwFLc3TYY6hoWnGFByO/edR7K4PWk9w7z5e4KE+WpZ9pO1X5lzspkb6IsJiH3gj4cANLXlu8=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by SJ0PR04MB7616.namprd04.prod.outlook.com (2603:10b6:a03:31a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 04:45:12 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 04:45:12 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "rishab@rispop.dev"
 <rishab@rispop.dev>
CC: "tarun.patanjali@utexas.edu" <tarun.patanjali@utexas.edu>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "christopher.elwood2024@gmail.com"
 <christopher.elwood2024@gmail.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH v2 2/2] target/riscv: Apply pointer masking to
 SSPUSH/SSPOPCHK addresses
Thread-Topic: [PATCH v2 2/2] target/riscv: Apply pointer masking to
 SSPUSH/SSPOPCHK addresses
Thread-Index: AQHdb00LOHcW6ZDtikG1oislxQpzdrclKNuAgAS5voA=
Date: Thu, 12 Nov 2026 04:45:11 +0000
Message-ID: <0c9cfc2bd51740b57fb5ef060a9e99ee2cf2ef2a.camel@wdc.com>
References: <20261108064641.179764-3-rishab@rispop.dev>
 <20261109043521.15730-1-rishab@rispop.dev>
In-Reply-To: <20261109043521.15730-1-rishab@rispop.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|SJ0PR04MB7616:EE_
x-ms-office365-filtering-correlation-id: 0ac54891-384a-42e6-5394-08df4077bca5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|19092799006|10070799003|23010399003|6133799003|22082099003|18002099003|3023799007|261022075727099003|261022105027099003|261021121427099003|261102123227099003|261028144727099003|261026140227099003|56012099006|10067099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: eLh2IuTx++cahzTHOVe/WwaHwF5SrkUv9AKpgfgGIeTcBDqndIC+wy2jm34LwhIRc9LcYbqtk275DjWHa6ehCif+gALI4l0yPSA9gPzA4g72ivpO4dcp8nLuc4ssUI2xK+YdvofF/WKtyz6GIlEFE1q8/9EZuIq0Ft22Vv/vq4bK3W7yTtolMitOe+/xqiYiY6DSxCx6oY75idr0Z6P2ApGmQOaetE8+1LwSxQRbmjRGy8Gk4Y5tvF0kpkWnRE5lQTYy3eqwV5CQ3K8s51UActNXwdqx6YEmlXIxcIdgElR+FCJEqYA3tInInA5AF6eIGYRK43LZC6ZoFIHMo2tFdZbSSwljwbb1BhYnjhJXvxhH5aB/3dueef/O9K32XpiRSD5p1t2cxQR+R/OiIkaWEoivuRyoLXHXVKQP9qFuj73de0kdK2AO0yQ+TtVeCMI0T6GmThdVQahPuISD67pI/EJUHr61tvJP5vfwqBkwBfGcja7MhFS9xb9zOX6ZQDZ4Bv1SjcQTUjMoyhew6BLnpAudzowcnW97EE+cJGyu48Hs/saa1t+0Ag4xVZ2ihR9ZmyCYwo7vs1CaIPhT3qrxIBYZGBiNJGs0a8SYROHnYxefLKGXGzYz3N3ojwGJZOQ+C86f09rsfP7UH7NVw/tHVMCRNMU13gqVR0onACZnkUwpKDjEQFa5X7b/+4ZnJij4MSt9BKTyBWoWJW4pszyxPgsAGKPSIewl+Fj+TwE0O50=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(10070799003)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(261022075727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(56012099006)(10067099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTJiQllxWm1FMzRVdTdNRFVLcm1WWGxwL2Q4NTlsRi9rc3FUbE1yWkhwWmxK?=
 =?utf-8?B?b0k0NTQ0SnhiTlhzbUVoR0EyaElYcGJzemRJNVpMNXMrNURWaDJFS29pRW9T?=
 =?utf-8?B?MlpDcTFlaDNITUJzWlp6QWY3U0xiby9xZVJid21CQjZDVjlwa1A1YUlUTXhB?=
 =?utf-8?B?Q2U3dFp5WDJEOUU5WDNMYVhmdlB0c1k5VWtCc21RRDM2eTRWSFE4OW9JbE9l?=
 =?utf-8?B?WG14elVUVm03MWltRWFmT1N3UTVPR1MxUW5mQ1pPNVdRU3FRMkpHeVVWclNi?=
 =?utf-8?B?YzB0UERwTW15dDlRY1AwaVVPSkEvNmw5SERlZTBIVnRFQTJkNFVNcVRLNnl0?=
 =?utf-8?B?Zk53Q3ovMklGVzUzVjlmMjh0TGF6R2kvZ3R3NERuWHFNRDBsRGhyL3NKM0Fh?=
 =?utf-8?B?YVNDaDVHbFNkOWtrSGl4TjltTGZuWTI2aFNleS9KZ3RwdHJRdHVkSTc0MXN0?=
 =?utf-8?B?U2hsZDJOWjJkQWdIQlFwZml1azRSMG9QMnFlVFp2Nm1rQWZueUhjdmhTWnZ5?=
 =?utf-8?B?K1o5d2lzM3FyVnlta0kzQXd5N242TmV2M29nTXRpUERiOVUzb3Y0T1l3NnFC?=
 =?utf-8?B?bVhXbm1xK1V6NWhWRVZ2bmRveFVhbmg4Rm9zUUhkdVZQYWhiNnd2U1lTNHFV?=
 =?utf-8?B?QlhSK01LODk3bEc3bGMxSVZjREptZDhtY2JDN2JHaEJNL2duNnRueHdpOWtm?=
 =?utf-8?B?cGVVTTUvbHNWWU4weUd3KzF5VnNrNzlrbFErRi9YajAwMUo0ZFVjajdadWlq?=
 =?utf-8?B?YW0vZU5EOTgvOFdBRjVtS0JxNWY5MVB1QjUzc0psU1ZuWWRhZHpTMjl3NC91?=
 =?utf-8?B?ZnVtYlV6eUVEaGFqeDRVblcvekRwR2hqR3VEaEJUNDIza2dCVm5oSWZpNm0y?=
 =?utf-8?B?TlYzSWJXWmVsdDJDZ0cxMG55TUVZTGp6T0gvM1BwUnhrUUU1VTFPZmkvME5q?=
 =?utf-8?B?U0YySXNybnFRM3dMYzhwK012VVJrajBKclhpQTBKUmVQZFFlNDEyRUtEeGcy?=
 =?utf-8?B?YkVzbklIWVZncm1EUm5obkJ1dGozdjJBcnErTnlqenoyaCtOQXBOVldSSzkv?=
 =?utf-8?B?WC9JTnh1UHUyUmNPRFRxdWZ4Zm13R3N2ZDk4UVdtSnpqT1BJd1NUSmYwTVZj?=
 =?utf-8?B?Y3R1OERMOWJkRWhVWkRWRlluMjFoL3RTNlh2WEJEY2wxZWFUVXdQZllRMHRM?=
 =?utf-8?B?c2JXTFovQy9QT2R1ZDRWQjlKbzMvZDVpV3dZWkdTQ3ZQSHhQN1E4SXFTc0ov?=
 =?utf-8?B?YkVZN3hSUmZzcFVCNWJpMnpodU1ldlNZZnhUQjRiY3c1LzI3VkVpWlU1Z2Z3?=
 =?utf-8?B?VWs4NVE3Mm5MaGNhV1NDenJEMC9sN3FFWSt5N1YxUEhWVmFZaUZubWJuekZX?=
 =?utf-8?B?dlhBUkplZ2V3UjR2OXMxSmdaK2NQcUFqaTlGdDBFTUdUWk5PcTFkYlhQL1N6?=
 =?utf-8?B?Ni9LajFYUElRY2RDUXp5Vy9waTdCQWRwekI3Z3NJZGJmd3Q4amIrUHhVTmZ1?=
 =?utf-8?B?Y09hM0NmUk03cU1tbTRGNm9BWmdZMWFDMW5DRVF2TnZ5eTNUa2FMaCtsTEVP?=
 =?utf-8?B?djZEK1lVVE56eXdTV2ZzUjVQR21qcVMyajJCSnpHc01nN3JsQ0VSd3pJN3Vj?=
 =?utf-8?B?WVVpb2ZzVW9kL24wa2FrQjlaYmVnN2pxZ3llVmZ4bVZ3dktBRjYwUDhLT3ZO?=
 =?utf-8?B?QjVGYytUTGwyaWNRc1c5VXFJdjNWdWxwT0tuTGU2cUkrVHpIMEo3ck55NGE4?=
 =?utf-8?B?TzBnWUxsQUtFSE94RXJYN29CUGV2WHd2L0RFRnNiczFZdTM4VHdzaWtsMEs3?=
 =?utf-8?B?UENYZHRmSTNaVktLODZFcTRjWTJQeG85L0N2UE1tNkg3d3RWMy9nc3B1N0dV?=
 =?utf-8?B?aG56MVFBY0VMOU9GenlBdUErckM0aEtVK081MTBSa1FxU0gyZ2RoL2VoRG5V?=
 =?utf-8?B?aVZTSllVQmZISEZjdjhrNzJDZ0p0R0puU3dDVzBZam54VnRweVNNUUY0bnZ3?=
 =?utf-8?B?VW9mZzFvSW1lMytjcjl1cnBmZlBZRGVNWnhZQ0lDeEtpTGl1UXNZczduOTgx?=
 =?utf-8?B?Vldqd1VSUG1uN3F5RHFxREFxNnp3dyt5TmlKZld1Rk9NbXhMNDA1U0FNQ1Bp?=
 =?utf-8?B?V1M2Y2ZIMldmSHZoSlNDeEJPSmVFNmM3cVd3Znl5emJZMjVDRS8wLzJRVkU3?=
 =?utf-8?B?emd0Mk0rdzZrZjBMSGp4RFE5VW0xVU5wRURjUTlESWdQS1ZvRzYxUWs1L2wy?=
 =?utf-8?B?OE4ycDM0REFHSU1yWjB6N3RFMWRzbUhyeXhLeFJTS1NubW5VV0d1RmJ3ZzRV?=
 =?utf-8?B?aUlFckFvemZsaE85M3JhL2NuVkNGNGEyalVwRU1UQ2pFYnBYT3g4V2E4WUsy?=
 =?utf-8?Q?MsXXABhC2iuv2xp585ouvcUKMYBH6ercd30SnzhdNUfgV?=
x-ms-exchange-antispam-messagedata-1: iKNRzP8NVP4GzM8H7KiA1ti6P76IzNToB2U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA7C6CB1171ECA4BB7B10AF02F81CFE8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2mAMAdrCJrgA/DxXJyouroHWsA6QfQIUweNYDwaI3//6BcaGH4EzlTdvI7L8hpuZE4YFqyK0ARmBdiR6L9XYiPqx6Uo/4PV/GSIju+pZSUXc1wqs4Uc0DRRrZmd5sFFCG3ic7qQzK81wnHCgakWv4tqhLU9joR1K8I2m/jbWxk+E3p9dWp6eoM+wqa6oMpNaWSyyeRg9IcaIJIrholaEmEoNy+JW4bf3nB/epRYnRsu6K5Gnf0YpqbavF2AiF8Kiu5jKVozTwwztbShdXNtIWe9c2IXrxe7RTkKU9eVAjAUVsvoMnyhluHhjGHKIgBgN9odWFFZi+Fz2QR4Z2TUDJQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OYwcqwPGeLGcC5lT3ZUDkkU1VnZhXh7Wc8EeLerI0eB2LvU51AxS4HQPf9LKnb4H+aeI1C/otAEtCCmd8+6AgCQG04cNokfNytkhB6+Ufv+LuW2dyZkg9Yl/EDx0ICcY5mc9nc4dx4y0nH5d0VsB5eKC9m/za7BDufrJVw9CoYJTn3Djq4oHmf1A0hBfqsqQ97jSoRDyW2YDRPnN4pVgR5r4SS0NgeFBJ3VkereudEJi9GMKL1XlLBcWtq55ed6my0+8a0F4nnECyrPc5dAvd4j1XSoRBj1LvMsNX14oJkv+52HBRd7QpF4XsO64a1Edw2Vld8G6zVxujVAoRWmvWlcpLq0aAqtRkUtp2ry+srKfsYux23f72b+wK/Im2y9qQsLk9g6LCkYolkVzpB9aTmyehJROc1LnJX8F1j5dWuqFe+SNug3XIoyRQsfpVo7IwXbbDU1V0KYXZrgBuLTEeIfZeEKCMf89gx6S/zO44wYxxBwiM45CFtp4SdkwApSm8Ij4vTzJ8yGaAOdcWTpuLQZ2vrSZIwdDPojcmmQ34W0d190CRUmKUyu0vGFV5nBaiTHwR2qdqjiwj7+amnE7X3HlCHEc0An6heX3BisSY/A10+/uZs1gjnJ0lUpgXJbt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac54891-384a-42e6-5394-08df4077bca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 04:45:11.7699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ng6z+lNX0CPNgXciUIb7W4A2uuHfvhdfK/4F/OYMtk+G7qni2jJddn+XQtQvjkiz9lxyNoflhvC1TtjGlKD+yHP3mmyFduM8VNXz9p06zY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7616
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU3VuLCAyMDI2LTExLTA4IGF0IDIyOjM1IC0wNjAwLCBSaXNoYWIgUHJhZGVlcCB3cm90ZToN
Cj4gU2FzaGlrbyBzdWdnZXN0ZWQgYSBGaXhlcyB0YWcgcG9pbnRpbmcgYXQgZjA2YmZlM2RjMzhj
DQo+ICgidGFyZ2V0L3Jpc2N2Og0KPiBpbXBsZW1lbnQgemljZmlzcyBpbnN0cnVjdGlvbnMiKS4g
SSBhZ3JlZSB0aGlzIG5lZWRzIGEgRml4ZXMgdGFnLCBidXQNCj4gSSB0aGluayB0aGUgcmlnaHQg
dGFyZ2V0IGlzIHRoZSBwb2ludGVyLW1hc2tpbmcgY29tbWl0IHJhdGhlciB0aGFuDQo+IHRoZQ0K
PiB6aWNmaXNzIG9uZS4gWmljZmlzcyBwcmVkYXRlcyBpdCwgYW5kIGl0cyBzc3AgYWNjZXNzZXMg
d2VyZSBjb3JyZWN0DQo+IHVudGlsIGdldF9hZGRyZXNzKCkgc3RhcnRlZCBhcHBseWluZyB0aGUg
aWdub3JlIHRyYW5zZm9ybWF0aW9uDQo+IHdpdGhvdXQNCj4gY292ZXJpbmcgc3NwOg0KPiANCj4g
Rml4ZXM6IDRkNTAxYTdhN2ZiNCAoInRhcmdldC9yaXNjdjogVXBkYXRlIGFkZHJlc3MgbW9kaWZ5
IGZ1bmN0aW9ucw0KPiB0byB0YWtlIGludG8gYWNjb3VudCBwb2ludGVyIG1hc2tpbmciKQ0KPiAN
Cj4gQWxpc3RhaXIsIGNvdWxkIHlvdSBhZGQgdGhpcyB3aGVuIGFwcGx5aW5nLCBvciB3b3VsZCB5
b3UgcHJlZmVyIGEgdjM/DQoNCkkgY2FuIGFkZCBpdA0KDQpUaGFua3MhDQoNCkFwcGxpZWQgdG8g
cmlzY3YtdG8tYXBwbHkubmV4dA0KDQpBbGlzdGFpcg0KDQo+IA0KPiBUaGFua3MsDQo+IFJpc2hh
Yg0K

