Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C361606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=VShBDG1F;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=m9KInRNC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVMXY-0007Fb-CF; Mon, 23 Nov 2026 00:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVMXW-0007FO-RD; Mon, 23 Nov 2026 00:24:30 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVMXU-0002s5-QW; Mon, 23 Nov 2026 00:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795411468; x=1826947468;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=oveBz82IyVMWu7TTrZSz4mmnQeO+MLPV9mndWxbtL+g=;
 b=VShBDG1FQkI4lPFo4cu3UUPyJcUGs4poKWh9I2hXeIh+84s4YjaK/5Sw
 LHC1a8UGkyf0xfrkACLm7SOLTwiq+XzQXS9lpEFc+xkDXkzefoFecUEmP
 LoyHkPcoqyAJ+16wURjiKm9UVBZ9jN2KvUqArbHcapncbdhD8lt2WiAhc
 rg5N3Zr76MT9V7w49OlekcdN9OReZpEU1gM0fzBOMJWXpc9q6R1ANDS3x
 cgWquk7dXylNUssMEbup+MKO9lg2SBYmvzqS5WNExy6H8sbJthNVzDJt8
 EAhaLtb+epcnheejZqKNlaT6beN49uYSlOzjK8M9uwg41ZVzkCjl4ubyN Q==;
X-CSE-ConnectionGUID: rwkXuCUAS5C2wD2ysdyFBQ==
X-CSE-MsgGUID: anjjKxxGT4OnQtgSOTr1JQ==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="161461170"
Received: from mail-eastusazon11011068.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.68])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 13:24:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPjxnzgIkQwo6OhlTdv/d5Q0iBAiwp1QSr/cYzq1B99GNDgmVbQwqPhAbPJZEW+2szm3SQ1UhzazQVaz1n3FbLP4ml2NMx0ul9x+wVH+V0mQucUwCBhzWai56siqkwzrW/3wAq2RNhH3ZXkNQeNrWI7w8VZmWXlXLfv3jFuiXhpMDAzrKdrAm3EYveqMiS2frFmX5PeBkvFjg4l0UG6ITp6r+aRXepBTCKNog/ShGn4Uv3Q2qz6KABjeJIJzE26mgO8AkYygNmxdBPRk8OeCQyHbn3D4LQ4OVhsjF/aqA4Yq38DoqJwljvF5h0OceXCPCjAoA5+ooXdGf2PbtsY2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oveBz82IyVMWu7TTrZSz4mmnQeO+MLPV9mndWxbtL+g=;
 b=r+uElLaWsCX5VVWYIGKu4Sf3j5VD1l4GWoBRJahu++6nc2AAraFh/6KAuBx6jsvF6/+/FhKjdlF48uIcOcQ4CJ6ibbw8Iv8HZVDBwLN/qa7iZFLEKWjsH0v0txLCwZ3KcgQAT+ofNc3VH2h23HYpLXlPiv7CZ/Kp3LNNgczgG8SEVv84tdwIr2/+dajDkjPOJaH0UFrgdS4iNxPgGVxaXKGHxLmDmXoQziCHpki+XnoKF9YwrCaDyjckD/7kxHR8tZocCjYRHR/R30mH3DOL/io1mNE0UwOmY1WeJSPLZW4zvhft3z4kE4hWQJGnC+5AWkZV26KmLFUc5KUt2yS2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oveBz82IyVMWu7TTrZSz4mmnQeO+MLPV9mndWxbtL+g=;
 b=m9KInRNCCHLmPZKWKmZeYlr9LT+Jj8uZK88+j3O9wo9gg6x7oUZcj+hpUKIQzskoHzgtnMtFdBmd4HKqBxYPYkbksQoUryzbZQQzOr/VYbCLFc9lc3qBSdL2ZQT+BM7ZjBh9uQ1B34F4gtmj+RHGVfVKewsAMnWTy71rU3WBxh0=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY5PR04MB7026.namprd04.prod.outlook.com (2603:10b6:a03:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 05:24:21 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 05:24:19 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "bin.meng@processmission.com" <bin.meng@processmission.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "sebastian.huber@embedded-brains.de" <sebastian.huber@embedded-brains.de>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "conor@kernel.org"
 <conor@kernel.org>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH v5 20/26] hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
Thread-Topic: [PATCH v5 20/26] hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2
 GiB
Thread-Index: AQHdbHMxRfkeNo4o7kmKr+/tKy/pm7c7PN8A
Date: Mon, 23 Nov 2026 05:24:19 +0000
Message-ID: <b91048513c8040740834629266b2a12e90d77d06.camel@wdc.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
 <20261104154207.641511-21-bin.meng@processmission.com>
In-Reply-To: <20261104154207.641511-21-bin.meng@processmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY5PR04MB7026:EE_
x-ms-office365-filtering-correlation-id: 24d309ea-9b83-4c4c-c43e-08df49220665
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|10070799003|261009223027099003|261009223327099003|261009221227099003|261009220027099003|261009221727099003|6133799003|22082099003|18002099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|261026121527099003|261026140227099003|261028144727099003|56012099006|4143699003|10067099003|38070700021|261102123227099003|11063799006;
x-microsoft-antispam-message-info: +eZ3DMEND6AEZf7N+D8wEklxLEE/64fXMXgrDzXT4R5EiCwPDkNfCS4i7ZnuDNYkBZ7+/ALAGkSmTxjb+25XfC89O7BcvmwZnyQwxDiukFI0jNEozpPS964JhGctcFJjNodMUsJYCUETH1E+4B3AeiX1JBPXL65uzlwe6VWZi+GzlqnBEs8jWM5CntFGycVfXkKLiQtMG7i36Em+W0SIAwgwffhm2RaPaMV/KbQ5P08Vii7ilPLwGMZi6iYrEW2AD5p8aM2Qxwh5LWqKfExCyFLv42kwYRl0i/1+9OJN/tPtUN3xnqARdM+5pcgVDYQ9VG6BlK3kvngAS5ViCSvGu9FYeUyad147d25IZq5nL9YxGob1fVJ+xcLnedaMz2vkDNUC5oRTlYbrWHE5aBcO4qgy4ZwZo54oCqNInG7IBvbi+YMWP9XraT+FtQsSnLp6FmbsTb8Ek44/N6FBCceVa4QJS0NyMvjSU9GEYRzovNAH2zbEoBx9dxdZk3ARyZ3y/OWMvVXEG7v2X72uzUzB9uSSefK9HpKhAc36SapSFCTvPlYK+kWArGhlKA2a7ia+RuVFZBj5N9jxR4wmeNmiWPv8aROkwfdszobdeY5nSXu0nW/x88Yxt0jTeU5DKVLO1/vu+igbwdLOL/i/1Bna6tgcIAAA4qQGA51DF12VPOI4WYIO3vlBTCv8W6ZgpiA+aOH2xvCoYHA/leooI+T6Pw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(10070799003)(261009223027099003)(261009223327099003)(261009221227099003)(261009220027099003)(261009221727099003)(6133799003)(22082099003)(18002099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(38070700021)(261102123227099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGJ1Tm93SnFFWWF3UytXWVBwUysrMjFkR2ZNUFJZbU1SNDVWKysyT1Y2YUcz?=
 =?utf-8?B?RDdSZEt1RGt0Z2EzbXVyYm44QUhENUdPM3BWNlpBRXBDN25BMGtNMzdPVmNB?=
 =?utf-8?B?YVhlSmtXZm4rMXNxVDRrVzJDaEhuUzRLZkNJdnFpMnpjN3pyNmxoWDg0NXph?=
 =?utf-8?B?cTJHdDBEcm5nNnhwL2lvZGJlQy83VTRNcUhHdEg0cWNrbXNZSnRUMGNPUTRQ?=
 =?utf-8?B?dnlkTW05WEhzL0QrSzFGeXRXajdQUU90SjhQRGdGUzlDRTNjWDlzTFRtSzdM?=
 =?utf-8?B?ZXUrUk1MWUIwRmI0UmcwRk5tTk5aWFFPMjA0eHlyZGgzOXhqeFdURVlBVFI0?=
 =?utf-8?B?Qmkwb3ZmMUV3cG1scE5WVDNWSUVYRjdESnBrYmRhbDZKWlFFT2NpU2E2M3Vl?=
 =?utf-8?B?aHV1SHJicE5ZMlVLTS9tZVpFeUFUYThhMEt6SzlZZGhYb0pDS0w4ZGhFS1Vh?=
 =?utf-8?B?THNiQWNEL0taZ3FnS0FvMzJTT0pMVnMvNFVPWjcwcUMxcnVwcGZFb3Y0RTg4?=
 =?utf-8?B?SldhMm9ocmIxcjFrZmthQ3lMcm9XcUFMeW5YZlNSQnd3L3ZpV29yK2tIUDRv?=
 =?utf-8?B?QUZHdjhKbUdTcHNaSnVsTkU2OGFmSE91RVY0YVZ3bVhXYnR6cWpralFySkJ5?=
 =?utf-8?B?MysxZFZpQ244Y3VhMGVjamlubFdpUDVhbjFLQVNZTE9tQlhUUTVoTGZqVHVU?=
 =?utf-8?B?SE0ySWN6a0t2WFExZlZhZGQ0WDE2S1ZpV0tXYlVZNGdmcGtkS0txNVYyTVpq?=
 =?utf-8?B?NEI5WnAydDk3SzhkU0cyR1hqK1IySDN2QjhiMU83NEtSVitGdS9tVjlQbG52?=
 =?utf-8?B?YmtiaXRXTXlkRlZ2Mkt0TDhaMmljWk1SRlZDSytRVlowYTRpUnA5dVlhUW45?=
 =?utf-8?B?V0JaMHhZSy9nd1p3Q291c2J6RUJ3THRFVnZUOVBJMmlzUktUbG9INWw3VXdt?=
 =?utf-8?B?bElKSFFSUE5KaDZFMjBUMHVHampZSTBRYWVkMFJMYUpiUFNmWTJNMlIyQXZT?=
 =?utf-8?B?VTJmL1pINTkxQWdJUEVUUllyUlpQejNSTmFDZEVEYml2dDR6dHBIdlNZVUF6?=
 =?utf-8?B?bmd5ay9QekNoOUIybXVCWStDalpIWUtjSWdETEY4Z255YUZ2QWRlcURUYWJX?=
 =?utf-8?B?QVR5aFZNejlGc2ltZm8wSzN0V3p4aEV6Q0tXTkFIWTVaRm90Qzk4UTZGSmNY?=
 =?utf-8?B?SllkN1ZnN2U3WmNsSklIdXZjZHcxbHpRRDBlZGZaTzlFMEwrMC9KUXBjSFp2?=
 =?utf-8?B?OEhKMzRQRmhXNHo3TGM5cDc2NUJRMWJiSzRpMEdtZkxsRmRzNXFybEpZcm1h?=
 =?utf-8?B?WkJHM3RDSkoyb0FvRDNvdnVZQTBLNmxYMDFBVitaZ2Q2L3p1UG83TCtYaGZH?=
 =?utf-8?B?TzMrWVVrMHNJZWNHdmlsSHFLbzMwTDY1Z2JSQmdGZmkyeFAzbFAyUXlPNERZ?=
 =?utf-8?B?RTQwNGg3YUx1cjN0dFV2TEtzbzIyWStUWEorMTlPV2pJTEI5ODg2emxNYTA4?=
 =?utf-8?B?aXAzVFo4RHM0amU2ZURLT2VBWjF6bCtuNjBlMFVUN0VtOE5SM0czR0tnd2Vr?=
 =?utf-8?B?TlJnc2lnWmJjbE43a2lwRmFNTHFxdUJ3d21qNCszRERoeUFZeWFFNUt3Rkx1?=
 =?utf-8?B?ZVI4Y0JQM0pWREJyUkxuM0Y4VnFyekN1Tkh0UzV3TDRUWnB6N0cxKytUR3Ro?=
 =?utf-8?B?UWtkT2JLQWh3V3RDcHVtcUh4c0lqa3Z2bU0zdXplSm52NG8yQy9uMWoxUEw3?=
 =?utf-8?B?L1YwWG1RM2szMHBZdE5jWTJNSDRoV3lja2VsWHVsdmFEQ1ZZMXMwVjBRcUw5?=
 =?utf-8?B?K0I1MlEzU2JIS3FaN1F4ZCtIZkFQQllmR0dpN3ZGdnlQdFZjOHRPZjZzL2ZL?=
 =?utf-8?B?SjE3REk0UUhzenR4LzB2T2FMZ0tQR0MvMCs2RVZ6Nis1NXA3cmRla0xiaGEy?=
 =?utf-8?B?NStxaG9BRlNUQ2pEV0twL0xDRWZoSHpJK0JSNnRrb0tKWXhWMy9hV0QrZ0tu?=
 =?utf-8?B?TzR3alpLdGcyRS9oU0tnNHRLWGMzRndBUzU3ZXpuc1lMVkxGbkpmRkVqZlF5?=
 =?utf-8?B?Ykk1RHp3Um9lcFpLMHNzNGtPWHl1ZzhaRXFUNWFhRXIzS2tzSzd2T3hES3lP?=
 =?utf-8?B?YXhnYU9OclJ1QllZclBaOXhtdGIzS3EzczcvRDFwbi8zL25RL1V1Vm0wWGNN?=
 =?utf-8?B?ai9IWisyNUtCMWF4MGxIbHA4YnFtVlQ0aDhrTnd2STVSbDE2SmhZS1paOURi?=
 =?utf-8?B?a2d4TnVvTEgrR2c2SzdaMk1OKzUySldROEhDV0hQZ3pqdmFsb3FxUWo5eVFu?=
 =?utf-8?B?dHRZTTFoZ0N1Snc0QXZKbFVNU2Nad1U4M3orbm43QmtpQWNZMllZeWZveEVH?=
 =?utf-8?Q?+J0OPNmK9p3T5erCSvgTfNnW3pyG4dED7B61ihS/RN+sP?=
x-ms-exchange-antispam-messagedata-1: OBS+UCyhSz/EDYxrMBsbpyS/aVQSRN2fRcc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F079AA06EE9D0F46BD0D26F2D0D5818D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HX5yE7iGFK0TCzb82C80QXoTWCCOiV7QDML9ezcXAsoh6JkOz1BTEZB06wwcP2aYkhBgLeqQp/xGiqCfrdHBC71rsMSUGSOAgmYGMvsu3NckUvXpySZGzebrL1n0zz0MJRQBaWKq2Lqnpz6OHpNoSoo9EFEZfSjzB3G5lIYRx19n9dME5EPicGO9a8vMSiweVGElruI2oOGF4+RFiujP/4OaKemSRVVsijn+au0eH8DZmdvtH1ebolIi+HsTYnY/QW6pLlkTYlbc/HM0Pwgz4OqtUSy5CifP8pwkWxfEPkp/KQ+u+xcK4OMKqbA6DW0MdyiPHR3l2yQpgyJdn1MuBA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DIMvoGA80dyYKU69YbkqRnciWCuuu3F/KEF6Q80UPhOux9cB7eEe8iVy/sl9gFWYGy9mMkffWgFVjLxCCETmvNRlDKwa9Lg9OtOBhxGFNPBAkAzhWlWsYnBIsQJ9bCmTPuOCtJ5bhRJJLn7MIWs/hXWvpGxbnyKmMeSiPgeifYQtaouHnp8tzv18T4YfeaH8VlbU+QIacQdK5CSbayqNbB7+Q5E8sIBMqKIJRoY0y7Ul/kQM+YPoO/jTvali0YAQuhqwB712ggTxqX0LxyuqfzYbHH4a5eRoNeFCp3Jav/Rc9vqUPY+uEnKCn83OxfAT1PsQheJwE+g96fSE2WNMT7wdXwrAkwVBx1QCuaZqOGV04LrQXMNafUO8PBkafyjk6oyODiPBi2wqNSUEjnHQX0ClgExQ2tSLoUiSXivFfhB3JG5dxINHXEOwJuFAaWhIy6Pp5IzQsVVg/WrwfCd8SEvtSc6Bnz4EljrKPgmqo5P2GNtZlkwrH7sQp7jjC8LwJQK6+7ThuGAmyMyoiCpHAnntJdq8cEX1c5tEl67xx3y2IdCxY+hsjNBquaeSHn1Q6I+of/1ms9W2D5eMWbZZB3e0jzV+DrAaGHy1HtIJBxplfZs1V61A1Zs5P8Npzbo3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d309ea-9b83-4c4c-c43e-08df49220665
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 05:24:19.4313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xhu54HtSiEvMvOTt7hSX0F2VQnvYAkFFlq0cjLukHY8BT/Yn094Ha2Ug7AB9ndRYi5+VHUpK7bwcQNYpT00lOlQyWrS29AwIaTws13eGFQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7026
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gV2VkLCAyMDI2LTExLTA0IGF0IDIzOjQxICswODAwLCBCaW4gTWVuZyB3cm90ZToNCj4gVGhl
IEljaWNsZSBLaXQgaGFzIDIgR2lCIG9mIFJBTSwgYW5kIGl0cyBmaXJtd2FyZSBkZXZpY2UgdHJl
ZQ0KPiBkZXNjcmliZXMgdGhhdCBmaXhlZCBjYXBhY2l0eS4gVGhlIG1vZGVsIGN1cnJlbnRseSBk
ZWZhdWx0cyB0bw0KPiAxNTM3IE1pQiBhbmQgYWNjZXB0cyBhbnkgbGFyZ2VyIHNpemUsIGFsbG93
aW5nIGNvbmZpZ3VyYXRpb25zDQo+IHRoYXQgZG8gbm90IG1hdGNoIHRoZSBib2FyZC4NCj4gDQo+
IFNldCB0aGUgZGVmYXVsdCB0byAyIEdpQiBhbmQgcmVqZWN0IGV2ZXJ5IG90aGVyIHNpemUuIFVw
ZGF0ZSB0aGUNCj4gZG9jdW1lbnRhdGlvbiBhbmQgTDJDQyBxdGVzdCBjb21tYW5kIGxpbmUgYWNj
b3JkaW5nbHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaW4gTWVuZyA8YmluLm1lbmdAcHJvY2Vz
c21pc3Npb24uY29tPg0KPiBSZXZpZXdlZC1ieTogQ2hhbyBMaXUgPGNoYW8ubGl1QHByb2Nlc3Nt
aXNzaW9uLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1p
Y3JvY2hpcC5jb20+DQo+IFRlc3RlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWlj
cm9jaGlwLmNvbT4NCg0KQWNrZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5j
aXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gDQo+IChubyBjaGFuZ2VzIHNpbmNl
IHYxKQ0KPiANCj4gwqBkb2NzL3N5c3RlbS9yaXNjdi9taWNyb2NoaXAtaWNpY2xlLWtpdC5yc3Qg
fMKgIDQgKy0tLQ0KPiDCoGh3L3Jpc2N2L21pY3JvY2hpcF9wZnNvYy5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCAxNSArKysrLS0tLS0tLS0tLS0NCj4gwqAyIGZpbGVzIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZG9jcy9zeXN0ZW0vcmlzY3YvbWljcm9jaGlwLWljaWNsZS1raXQucnN0DQo+IGIvZG9jcy9zeXN0
ZW0vcmlzY3YvbWljcm9jaGlwLWljaWNsZS1raXQucnN0DQo+IGluZGV4IDdmZGI5NjYwMWEuLmIw
YWQyNGYxNzQgMTAwNjQ0DQo+IC0tLSBhL2RvY3Mvc3lzdGVtL3Jpc2N2L21pY3JvY2hpcC1pY2lj
bGUta2l0LnJzdA0KPiArKysgYi9kb2NzL3N5c3RlbS9yaXNjdi9taWNyb2NoaXAtaWNpY2xlLWtp
dC5yc3QNCj4gQEAgLTI2LDkgKzI2LDcgQEAgVGhlIGBgbWljcm9jaGlwLWljaWNsZS1raXRgYCBt
YWNoaW5lIHN1cHBvcnRzIHRoZQ0KPiBmb2xsb3dpbmcgZGV2aWNlczoNCj4gwqAqIDIgR0VNIEV0
aGVybmV0IGNvbnRyb2xsZXJzDQo+IMKgKiAxIFNESEMgc3RvcmFnZSBjb250cm9sbGVyDQo+IMKg
DQo+IC1UaGUgbWVtb3J5IGlzIHNldCB0byAxNTM3IE1pQiBieSBkZWZhdWx0LsKgIEEgc2FuaXR5
IGNoZWNrIG9uIFJBTQ0KPiBzaXplIGlzDQo+IC1wZXJmb3JtZWQgaW4gdGhlIG1hY2hpbmUgaW5p
dCByb3V0aW5lIHRvIHByb21wdCB1c2VyIHRvIGluY3JlYXNlIHRoZQ0KPiBSQU0gc2l6ZQ0KPiAt
dG8gPiAxNTM3IE1pQiB3aGVuIGxlc3MgdGhhbiAxNTM3IE1pQiBSQU0gaXMgZGV0ZWN0ZWQuDQo+
ICtUaGUgbWFjaGluZSBoYXMgYSBmaXhlZCAyIEdpQiBvZiBSQU0uIE90aGVyIG1lbW9yeSBzaXpl
cyBhcmUNCj4gcmVqZWN0ZWQuDQo+IMKgDQo+IMKgQm9vdCBvcHRpb25zDQo+IMKgLS0tLS0tLS0t
LS0tDQo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuYyBiL2h3L3Jpc2N2
L21pY3JvY2hpcF9wZnNvYy5jDQo+IGluZGV4IDU1Y2UxYWM3ZGEuLmYyYTgzOGJlMTMgMTAwNjQ0
DQo+IC0tLSBhL2h3L3Jpc2N2L21pY3JvY2hpcF9wZnNvYy5jDQo+ICsrKyBiL2h3L3Jpc2N2L21p
Y3JvY2hpcF9wZnNvYy5jDQo+IEBAIC01NDIsMTAgKzU0MiwxMCBAQCBzdGF0aWMgdm9pZA0KPiBt
aWNyb2NoaXBfaWNpY2xlX2tpdF9tYWNoaW5lX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQ0K
PiDCoMKgwqDCoCBEcml2ZUluZm8gKmRpbmZvID0gZHJpdmVfZ2V0KElGX1NELCAwLCAwKTsNCj4g
wqDCoMKgwqAgUklTQ1ZCb290SW5mbyBib290X2luZm87DQo+IMKgDQo+IC3CoMKgwqAgLyogU2Fu
aXR5IGNoZWNrIG9uIFJBTSBzaXplICovDQo+IC3CoMKgwqAgaWYgKG1hY2hpbmUtPnJhbV9zaXpl
IDwgbWMtPmRlZmF1bHRfcmFtX3NpemUpIHsNCj4gK8KgwqDCoCAvKiBUaGUgYm9hcmQgaGFzIGEg
Zml4ZWQgUkFNIHNpemUgKi8NCj4gK8KgwqDCoCBpZiAobWFjaGluZS0+cmFtX3NpemUgIT0gbWMt
PmRlZmF1bHRfcmFtX3NpemUpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoCBjaGFyICpzeiA9IHNpemVf
dG9fc3RyKG1jLT5kZWZhdWx0X3JhbV9zaXplKTsNCj4gLcKgwqDCoMKgwqDCoMKgIGVycm9yX3Jl
cG9ydCgiSW52YWxpZCBSQU0gc2l6ZSwgc2hvdWxkIGJlIGJpZ2dlciB0aGFuICVzIiwNCj4gc3op
Ow0KPiArwqDCoMKgwqDCoMKgwqAgZXJyb3JfcmVwb3J0KCJJbnZhbGlkIFJBTSBzaXplLCBzaG91
bGQgYmUgJXMiLCBzeik7DQo+IMKgwqDCoMKgwqDCoMKgwqAgZ19mcmVlKHN6KTsNCj4gwqDCoMKg
wqDCoMKgwqDCoCBleGl0KEVYSVRfRkFJTFVSRSk7DQo+IMKgwqDCoMKgIH0NCj4gQEAgLTc1Nywx
NCArNzU3LDcgQEAgc3RhdGljIHZvaWQNCj4gbWljcm9jaGlwX2ljaWNsZV9raXRfbWFjaGluZV9j
bGFzc19pbml0KE9iamVjdENsYXNzICpvYywNCj4gwqDCoMKgwqAgbWMtPmRlZmF1bHRfcmFtX2lk
ID0gIm1pY3JvY2hpcC5pY2ljbGUua2l0LnJhbSI7DQo+IMKgwqDCoMKgIG1jLT5hdXRvX2NyZWF0
ZV9zZGNhcmQgPSB0cnVlOw0KPiDCoA0KPiAtwqDCoMKgIC8qDQo+IC3CoMKgwqDCoCAqIE1hcCA1
MTMgTWlCIGhpZ2ggbWVtb3J5LCB0aGUgbWluaW11bSByZXF1aXJlZCBoaWdoIG1lbW9yeQ0KPiBz
aXplLCBiZWNhdXNlDQo+IC3CoMKgwqDCoCAqIEhTUyB3aWxsIGRvIG1lbW9yeSB0ZXN0IGFnYWlu
c3QgdGhlIGhpZ2ggbWVtb3J5IGFkZHJlc3MgcmFuZ2UNCj4gcmVnYXJkbGVzcw0KPiAtwqDCoMKg
wqAgKiBvZiBwaHlzaWNhbCBtZW1vcnkgaW5zdGFsbGVkLg0KPiAtwqDCoMKgwqAgKg0KPiAtwqDC
oMKgwqAgKiBTZWUgbWVtb3J5X3Rlc3RzKCkgaW4gbXNzX2Rkci5jIGluIHRoZSBIU1Mgc291cmNl
IGNvZGUuDQo+IC3CoMKgwqDCoCAqLw0KPiAtwqDCoMKgIG1jLT5kZWZhdWx0X3JhbV9zaXplID0g
MTUzNyAqIE1pQjsNCj4gK8KgwqDCoCBtYy0+ZGVmYXVsdF9yYW1fc2l6ZSA9IDIgKiBHaUI7DQo+
IMKgDQo+IMKgwqDCoMKgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9hZGQob2MsICJjbGludC10aW1l
YmFzZS1mcmVxdWVuY3kiLA0KPiAidWludDMyX3QiLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnVpbnQzMl90eXBlX2luZm8s
DQo=

