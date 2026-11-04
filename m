Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3268D606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=D8+tSlOO;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=k/E3wM8k
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTBn-00042g-P5; Wed, 04 Nov 2026 00:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=761a35039=Alistair.Francis@wdc.com>)
 id 1xOTBi-000422-Ay; Wed, 04 Nov 2026 00:05:30 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=761a35039=Alistair.Francis@wdc.com>)
 id 1xOTBg-0002A0-J0; Wed, 04 Nov 2026 00:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793768728; x=1825304728;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZtMyABmySkzrJPlBarTLpjWhLk55D0dpdrXq2yHPG9A=;
 b=D8+tSlOOPzMUJNxRdttxRc7VU6QeyBnfRQEApviEDplb8a5GhXZ7cXY5
 s0reX1GOE40+OfjFNhD6ZM0Z8z5ovdOuEjl1Uo0zQSCQmUTX6jNCYvV7l
 EjapE4QtbzK73kKYNT3JPQdIon01LpJTymjrddE/IT1mgFRd+JRY3KVBr
 tFS0h+ell6wIYVhdslGZsZUvSlu2T5sYaLOu5V/6fzMZP2txju2EOUJQ0
 X4qqraQp0jLLPueuMh2KgklvhW1R03N4Tnt5SA+TpZ0P/ojtGInHktT34
 xxu2kkmdoDOI2l8SQZ1u2lpVtULa5C53nabTS2u5601yYcuAXJTuBDMyf A==;
X-CSE-ConnectionGUID: 5rQo9mrGQROqI+zRYBGsbg==
X-CSE-MsgGUID: 5AHh+sPBRg6dtcmIy8q3ug==
X-IronPort-AV: E=Sophos;i="6.27,194,1786982400"; d="scan'208";a="160738182"
Received: from mail-westcentralusazon11013069.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.69])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 04 Nov 2026 13:05:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQmGlWD8JLRJWsBBhwfZ1sAhKwHE5/2RSBPLIFXKfi4zKyTdC0aiWHgGpJ7RuKUlW+nMtTECQDhnbrGpzi/F72Ox8dqdeslTquhlA8NiQcO2i1HZzrxLcpr7aAKe4IuaQyiZygCtGyOMJPfaVCK6g8O8P5Th2lnVZRhTpri/utSrMxaL1BCTgvkoaIV9oHKn2t4hR1q2jxqCVQPtxTn4/xQUWM34MRhg83KQRg4qoYvGyicnrzvOnkvjtS4twUS7uT2vcfEvsh3HETIcn0P+GWGIGfNkm5vFj5456G4EV7xOmVes/xtl6eOHVriRBFsQPAqseAwKGDzSMzhjVzAaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtMyABmySkzrJPlBarTLpjWhLk55D0dpdrXq2yHPG9A=;
 b=md64l4lWCnk3CBONCrvwQYmpr4v1whHFo3RAuXSplkqnbd1+xsEA8C3xQLr8svoRXp28h/puyBVpYxp1e6rxYd6QawWEFeZpBELwT9x7XQ8mG8dXuuORMkCCRHGC5I93Y+43MrM37yvS1xKoOaZ85To2Y4qMnHqvREdcGUoQWWTF1jLNVLXuoqbljTOCZtOKz2ugEVW7iL8jrVVGEzl7SLC8r0stJgFGSYE7GpF7ZVZZtV1vMMKF6FI8+tnSljaLVbxNH/vx36Qkof6VTi++h680zSJb2veHwcLJOaY+3sTmCtZiiCej7wiTqzISL2JTon71RocYboSzYEoHo23n0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtMyABmySkzrJPlBarTLpjWhLk55D0dpdrXq2yHPG9A=;
 b=k/E3wM8kMoHDvIUGnsIH1ykZYKMPMD7fXUVZRLVaJVdXOcNsDVBPEi4Q+sAr7NkEX+fFEJZbAyspVGbCTJayc5fCLL3MTC855cgbOhM0v9mF/PZjrwIj/V+NCWVrT4nG8hORxCADPSFrziziDhMbLlxho7zXEkMiPC8x30ckN7Q=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BN0PR04MB7952.namprd04.prod.outlook.com (2603:10b6:408:157::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 05:05:21 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 05:05:21 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "tanchi25@mails.ucas.ac.cn" <tanchi25@mails.ucas.ac.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 2/5] hw/riscv: Build device-common only for its users
Thread-Topic: [PATCH 2/5] hw/riscv: Build device-common only for its users
Thread-Index: AQHdaa9Y7jeawamehEWNyQW+wISE7bcdYM8A
Date: Wed, 4 Nov 2026 05:05:21 +0000
Message-ID: <9a9b4e6178096da72426244e82fc0ee67e78a0fe.camel@wdc.com>
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
 <20261101031547.125591-3-tanchi25@mails.ucas.ac.cn>
In-Reply-To: <20261101031547.125591-3-tanchi25@mails.ucas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BN0PR04MB7952:EE_
x-ms-office365-filtering-correlation-id: 100a6ece-2e7d-4db0-1743-08df3a313a64
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|10070799003|1800799024|23010399003|376014|10067099003|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006|261022105027099003|261009223027099003|261022075727099003|261028144727099003|261021123027099003|261026140227099003|261021121427099003|261102123227099003;
x-microsoft-antispam-message-info: pkgotCN72Xg9VswHqQnpLbv+nG6C+6Wid89G7i7rG1jmIaaBjW5WOkt/DrejUK381tJGy68IxTBSHOSxQeWI9KwetcUPrmodQt9oAow9E1shuOFnWEZLFvSkjCnXeQ1xfDZa61xWfhvqodI1Wcoxfp2CCx9q2LkaC6Z5ZdyZgzZxEP4KV1LhSi1B+KaIZ5OglSkuwIxLtLk/6ZC4VYw0S7KK5RFvyDWXRgJgOQvhvp+qxoxMzZ/1169hPekhahCfoW4ktgm96Mdslhgx2cRJ+daksFS5Dwg6YT7LOlu+JFpRUUOqZrNYQQ1HfbSYJGIT+APfPyWhsKaPISnf09OCT834uORska9K/9UZMoP00VIki4Bldgwau9Frvgn84Tm6godUhByfUgzgBmbXZgJ5Y8ULmvG7R6WtcDil/fF/Gtmg1s22UAd+IaiXyd66JdI5Zbqou9MGl6uHsVnMOSpme/7RxAaqbX2aaWhts2FymOVN2PWwVjYhCB+8fMsc+VKvTyUZoPmf9ZntAU1d4Tol5lrOwneDVn2o+ap5MNl27aF9IkZXAxOHIZ9Mwac65Qc8LUBH0k+V2s/59P6UQzQiwq6X/ZgLlv/B/USnMVpmzlSk3aHzr/culFgvFHt8Bo9qC3/B8Xg80oia7ZEyArY1pG6sbfEIgNI9TzcS61G2+EMapRgTRUz2cpgayxNI4rtup76C3v4qRLIRDLWC/47rmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(10070799003)(1800799024)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006)(261022105027099003)(261009223027099003)(261022075727099003)(261028144727099003)(261021123027099003)(261026140227099003)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3NaZXVyQk0rZzB6R1dSbkVXNWd6ZkY3emtxVWNwQWdhNnpOVkJSN1BSNGJo?=
 =?utf-8?B?Q2UvTlhxa3NVSTZzdk9Za0tISGZrMVVwL3lGNklyeGl6VFVrSDBjQ2gzNnEx?=
 =?utf-8?B?anplQUZIYkc5UWJhM0tRMlphQi9ZRm9Cd0UzWnBybm9MTDlGV2lNU210SXR1?=
 =?utf-8?B?cEVEVVFpUGI0L05Yb1VqQnRFYStsTEllS2MrMWhOaXJ6ajhYL2F0RGFyNXpE?=
 =?utf-8?B?N0ZZU1dUWG82Wmhtejk5THd0ZnRncGlmc0hPbFNEOWRNMlkxQWNhWXBZY2hi?=
 =?utf-8?B?K2ZhOE95cUh6MDA3cnN0dUNwa2RBTTZoQVF5Mk1lbzViS3pRYUFSNytwYkFT?=
 =?utf-8?B?aXZSVnVrTVhONjVxUHkvVUdiL3VCakxYWHpNQ3ByZURBcTV4bUZGaE9JL1Ri?=
 =?utf-8?B?R3hJSVBhdFpyc2kxNFYwaDNVNFp1WFFJaUdvM3plM2djdEY0N2FtZWFzbkhI?=
 =?utf-8?B?cmE2dXNiSUtmejRDMWRHSk1ubG5pSjhtVUJxMldZK0dHR2hhdjFFUElGVFlD?=
 =?utf-8?B?MmlydTFpVW4xcWUwRzJ2S0c5czB2VUQ2aVJ5elNsbEgvM3U0dW0wQlp3N1pu?=
 =?utf-8?B?VXNqSzNTWC9FV0FiclR5MkZnUThETVBmZFNyS0tHWXRQSU1PSDl2UXdwVVll?=
 =?utf-8?B?T2NzY3IwNEdrWHJkOFF3MzBhMi9rWW9QVWJjYkJCTENoemdUUUt1WmtRNWMx?=
 =?utf-8?B?WVU0OGFBTTF0djVHOW1EZjFwVWxGS09HR3A0NDVZK1FSRVoybXFZTllkTmxM?=
 =?utf-8?B?SXRCU0RxU1ZuUVdRSUt2RFBOaUJnRjVmMG44cEs2ZjdtTUFIMkFZRE5IbEx5?=
 =?utf-8?B?cUtJWmhXWFY5dzF6K1JkYUFac2FManFOTjlZQ1lvOHVBalBWM2htSkpjc2R5?=
 =?utf-8?B?YTJPT2hNdm5FNDVjT0VSTmZlbWNVZUc5eFJ2TS8wWk9PWDZlWitDZy9uMVIw?=
 =?utf-8?B?NVJ2VEdkNTBwNGJhMFZlK1hWUGFRV3E2dFRRSWMvOTdtdHdzUENmemZJVG5G?=
 =?utf-8?B?VFp4WWdrUnRpUldsNUhabXVhWWdtenNHcCtJa0o3bGJZdmJvc0owNERJQmY4?=
 =?utf-8?B?QXBDRlVMOXNEaUFOS2N3c2t1SFNSNTJZbGhOS0Ywc0I1azFERG11ZnRvSGpx?=
 =?utf-8?B?MGpQUmRVa3BYQzUyQlJ2WUtVUDBsdVZ6K0JLemZaMU1maXBBTTQ3RFZjV3lF?=
 =?utf-8?B?WEEyNGtVNFFRM0NvM0tRZTc5dGZzblcydUhHVHlzc3dUaG13TFZ4ODFRb2h3?=
 =?utf-8?B?eDErcnRsZlFmM0tob21xcE55TUNTSnRHN00vYlBNV005bUJWUWpUYkVRN1Zu?=
 =?utf-8?B?SGJXdHl4aHVrOElzK0t0cDlPZThGcFVMSmtQNGdYUDlVQnE4amxpbm54eE1t?=
 =?utf-8?B?SjFlQ1V4ZzltazA3SlgxakZjY2lLWmY0amtUaEdybXlzWWp5Vy92UGY4UVph?=
 =?utf-8?B?WTdRWWdkN01OZkdsMXJDdkw2UjB6aXpDZWltVDlmQmE1ZDYrWU9TUUFhRWJH?=
 =?utf-8?B?UFVkOGhuWXd5VlBQRnZHL2tITVluSW91d3JYZjQ2SWgxOU0yMW9XNC8rYnRG?=
 =?utf-8?B?bmxuSkE4U2VsNStRUDc4L2JzbU5SRXg5RWNaVlNUcXpmbitsR0ZCdTFERXVq?=
 =?utf-8?B?dmpNc0dwWFpMY0t6dUl4U0JoOFRRVTN6U2UyMHVpNGtneWJxTitqNTV0b1lE?=
 =?utf-8?B?QTFmcUJvb1dJQ2FPdjVoUEppRStiMGpseUFxS3hpbDA4ODI4ZG9LRnlLWG5S?=
 =?utf-8?B?aFI1OUVjNkxCVEtFalhCOXFLQmFWMU4xcFFwdTFxbS9ad2ZtZzkwNmlhNFdY?=
 =?utf-8?B?TzFwVTJ0dWVpNXlDd0t6SHdSakxtdjc3S0Y1aG1JQXhXdWRuQm5VaHVsMDIx?=
 =?utf-8?B?MXRNNXVJV3ozVE5SRHhibXc2Y1RFNXUrT1N1Qm1Gd29razFUb05lU2ZyZjJC?=
 =?utf-8?B?Z3R4YTNMd05qaXVqU0lvQVZjVlY2QUFxZkE1cTM1WGNrTTU4dTlhWU0wbG9P?=
 =?utf-8?B?N2R5SVdZeVEyU0t3N2c5SmFFLzl1dFNKRk5xUitzbWpxSXIwbzVCVm1xZ21E?=
 =?utf-8?B?NFhXQWdSUmUwRjY5K0w5L2tJQ1hEOFNORm1lMUxObUdBN3Z4YnY0ZEYwbnUr?=
 =?utf-8?B?TjlSNHdqTnhIVG8xbFovSXhYRXBYckRKQVBjdVNzNCtrQ2dCdVBCYkd5MUZs?=
 =?utf-8?B?emI2WXo3ZzFlQzdYdDcwWU5JSlFXL01rQnFyVFJvWWVFOS9FWHlZcDdNQ1Fo?=
 =?utf-8?B?L2dHcVJBZlBxU0NnRUcrY1diYzhZZEQxSmQvSlpTaFBKWkR2QmhMZFhLSGE4?=
 =?utf-8?B?RkppNUttVDR4MFRjM2NvLy9sMFVBYm9oY1ZDQkgvczJRbU1ENkVRM3ZsWGZC?=
 =?utf-8?Q?Z2jsXwD7s/waUACE3GNVoiBwp8HR4lVnQ/2/PhWUuyHPo?=
x-ms-exchange-antispam-messagedata-1: mYlvgf1bdRToApDdmPXPkH6GOPIXnn3Fdqk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68615CBBE9FCC94F828138F41DDBFBB8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pb3hzDx1n9vdYeLghD/s5knLF7VBmVZlSl3SeKbTzijk6f1eQzvnbIYALze291O0ZazqHEfJQerX4ovbcYxWRpun0ZDj4YyIw4jANtWTrYP98NdyRLNy10pDZQBRzlEslJQimVlhenArlvPUJS5sZdETdFn2C03pqapsmV+c7Qvt1lW5Y0OSdzoG4mzs0MOn3gmiulh6Zg8FT82PvBQ1J5k0+qichgjxLBho5HhFnunye6OIOS2P78hPBeL8Z2Tj1Yc0XZ4ihWyrzEJC/4+y1fZDlFphaRXGC4OA2dFlhCNkIwweV5MQOe3hhEVC6WsUf8hT5NNGqx5SyZu68wG5bw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kpgXvtk/lcRTKfxX8R+xNOBC1WIFntJx7nvDEDscuthBtp01tG2ucJ09zHJm9Nu6Zz6yui6jheCw40ErBwjNbQrgk79piDJ3M3TFYtKskEiRgUDKWqMTaSLOxw3Rwig/i31St7VxMvprwRjNVRspgIwvbYqFlyWUcYklczQHBaAuhxN7TEht1VAVmus8PgXoBkOBN5s3m+M2OMw/Cf7Z6xQztRdAJbZSWNqrrMKTJpWSksuH5FTAZzCD9BEgxpfmi5ZiUCtEnAJqg3mdqL/1zjgicZRcU1yJ6GUcg8Hg/cBGZpOmMoyjw8GDAX+x5b90g0+7qjYN0sW+G5gurBdsy1b4cJ8QQxB2A4T1MqwJYJ1z9sbvMo7shCfRVSpfOIeT/Jjgn5Zq2MX2V7kmj5RMaDTArP46ZAUGwVKv6yoJ5bGUmhBZJv922lm6qwr8CepcXrElPdOh6p7ap09a/3nRcWEWCMtSFAATiE9thO+Hsl+8MRCcgZziDpB11d7FcyCcIJ/JcSbgaE0jpv7bwUCc9ObT3dY3auePQhFJii162wAEfJgVy6MJ5b/+NbXGdkxjEXT8n6jdlwyLQtzcnVrv7fslOQC6ffCudNMomwcGwiUyOQt0jmCUPNQ68Lem8qp9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100a6ece-2e7d-4db0-1743-08df3a313a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 05:05:21.6718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0+csFeJF3PzjmO6kFDGw1oBEAeqbmk0dK2aMeU6cFK7jFp3uLPUtzrBeQ046Dc0UbvK6i3kfOtV7iXb189DCfbmEc9QuKxYXkqOBxEhp84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7952
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=761a35039=Alistair.Francis@wdc.com;
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

T24gU3VuLCAyMDI2LTExLTAxIGF0IDExOjE1ICswODAwLCBUYW4gQ2hpIHdyb3RlOg0KPiBody9y
aXNjdi9kZXZpY2UtY29tbW9uLmMgaXMgYnVpbHQgdW5jb25kaXRpb25hbGx5LCBhbHRob3VnaCBp
dHMNCj4gaGVscGVycyBhcmUgb25seSB1c2VkIGJ5IHRoZSB2aXJ0IGFuZCBzZXJ2ZXIgcmVmZXJl
bmNlIG1hY2hpbmVzLg0KPiANCj4gSW4gbWluaW1hbCBidWlsZHMgd2l0aG91dCB0aGVzZSBtYWNo
aW5lcywgZGV2aWNlLWNvbW1vbi5jIGNhbg0KPiByZWZlcmVuY2UgZGV2aWNlIGltcGxlbWVudGF0
aW9ucyB0aGF0IGFyZSBub3QgYnVpbHQsIHJlc3VsdGluZw0KPiBpbiBhbiB1bmRlZmluZWQgcmVm
ZXJlbmNlIHRvIGdwZXhfc2V0X2lycV9udW0oKS4NCj4gDQo+IEludHJvZHVjZSBDT05GSUdfUklT
Q1ZfREVWSUNFX0NPTU1PTiBhbmQgc2VsZWN0IGl0IGZyb20gdGhlIHR3bw0KPiBtYWNoaW5lcyB0
aGF0IHVzZSB0aGVzZSBoZWxwZXJzLiBCdWlsZCBkZXZpY2UtY29tbW9uLmMgb25seQ0KPiB3aGVu
IHRoaXMgb3B0aW9uIGlzIGVuYWJsZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUYW4gQ2hpIDx0
YW5jaGkyNUBtYWlscy51Y2FzLmFjLmNuPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNp
cyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGh3
L3Jpc2N2L0tjb25maWfCoMKgwqDCoCB8IDUgKysrKysNCj4gwqBody9yaXNjdi9tZXNvbi5idWls
ZCB8IDIgKy0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L0tjb25maWcgYi9ody9yaXNjdi9LY29u
ZmlnDQo+IGluZGV4IGZiMDUwMzEyMjguLjI3ZjAzYjY4N2MgMTAwNjQ0DQo+IC0tLSBhL2h3L3Jp
c2N2L0tjb25maWcNCj4gKysrIGIvaHcvcmlzY3YvS2NvbmZpZw0KPiBAQCAtNyw2ICs3LDkgQEAg
Y29uZmlnIFJJU0NWX05VTUENCj4gwqBjb25maWcgSUJFWA0KPiDCoMKgwqDCoCBib29sDQo+IMKg
DQo+ICtjb25maWcgUklTQ1ZfREVWSUNFX0NPTU1PTg0KPiArwqDCoMKgIGJvb2wNCj4gKw0KPiDC
oCMgUklTQy1WIG1hY2hpbmVzIGluIGFscGhhYmV0aWNhbCBvcmRlcg0KPiDCoA0KPiDCoGNvbmZp
ZyBNSUNST0NISVBfUEZTT0MNCj4gQEAgLTY4LDYgKzcxLDcgQEAgY29uZmlnIFJJU0NWX1ZJUlQN
Cj4gwqDCoMKgwqAgc2VsZWN0IFBMQVRGT1JNX0JVUw0KPiDCoMKgwqDCoCBzZWxlY3QgQUNQSQ0K
PiDCoMKgwqDCoCBzZWxlY3QgQUNQSV9QQ0kNCj4gK8KgwqDCoCBzZWxlY3QgUklTQ1ZfREVWSUNF
X0NPTU1PTg0KPiDCoA0KPiDCoGNvbmZpZyBSSVNDVl9TRVJWRVJfUExBVEZPUk1fUkVGDQo+IMKg
wqDCoMKgIGJvb2wNCj4gQEAgLTg1LDYgKzg5LDcgQEAgY29uZmlnIFJJU0NWX1NFUlZFUl9QTEFU
Rk9STV9SRUYNCj4gwqDCoMKgwqAgc2VsZWN0IFJJU0NWX0lPTU1VDQo+IMKgwqDCoMKgIHNlbGVj
dCBSSVNDVl9OVU1BDQo+IMKgwqDCoMKgIHNlbGVjdCBTRVJJQUxfTU0NCj4gK8KgwqDCoCBzZWxl
Y3QgUklTQ1ZfREVWSUNFX0NPTU1PTg0KPiDCoA0KPiDCoGNvbmZpZyBTSEFLVElfQw0KPiDCoMKg
wqDCoCBib29sDQo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9tZXNvbi5idWlsZCBiL2h3L3Jpc2N2
L21lc29uLmJ1aWxkDQo+IGluZGV4IDk1NzAzMWMwN2QuLmI2MDEwODc4N2QgMTAwNjQ0DQo+IC0t
LSBhL2h3L3Jpc2N2L21lc29uLmJ1aWxkDQo+ICsrKyBiL2h3L3Jpc2N2L21lc29uLmJ1aWxkDQo+
IEBAIC0yLDcgKzIsNyBAQCByaXNjdl9zcyA9IHNzLnNvdXJjZV9zZXQoKQ0KPiDCoHJpc2N2X3Nz
LmFkZCh3aGVuOiBbJ0NPTkZJR19SSVNDVl9BUExJQycsICdDT05GSUdfUklTQ1ZfSU1TSUMnXSwN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWZfdHJ1ZTogZmlsZXMoJ2FpYS5jJykpDQo+
IMKgcmlzY3Zfc3MuYWRkKGZpbGVzKCdib290LmMnKSkNCj4gLXJpc2N2X3NzLmFkZChmaWxlcygn
ZGV2aWNlLWNvbW1vbi5jJykpDQo+ICtyaXNjdl9zcy5hZGQod2hlbjogJ0NPTkZJR19SSVNDVl9E
RVZJQ0VfQ09NTU9OJywgaWZfdHJ1ZToNCj4gZmlsZXMoJ2RldmljZS1jb21tb24uYycpKQ0KPiDC
oHJpc2N2X3NzLmFkZChmaWxlcygnZmR0LWNvbW1vbi5jJykpDQo+IMKgcmlzY3Zfc3MuYWRkKHdo
ZW46ICdDT05GSUdfUklTQ1ZfTlVNQScsIGlmX3RydWU6IGZpbGVzKCdudW1hLmMnKSkNCj4gwqBy
aXNjdl9zcy5hZGQoZmlsZXMoJ3Jpc2N2X2hhcnQuYycpKQ0K

