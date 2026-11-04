Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42273606A324
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=f4KhFtLu;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=YtRi/88S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOOi5-0005WF-4X; Tue, 03 Nov 2026 19:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=761a35039=Alistair.Francis@wdc.com>)
 id 1xOOi1-0005Vz-5n
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 19:18:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=761a35039=Alistair.Francis@wdc.com>)
 id 1xOOhz-0002qC-Bu
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 19:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793751511; x=1825287511;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4gHFybrt2IoldAhszlb5ny3ac+XiAGFumlDZ2YRf1sk=;
 b=f4KhFtLuravIcM6DzYLHdCnJeCbrXK3Z56V2PM6Z/l4Agirdg+rduZUf
 OO2bAWp6xHMQOPfWo+lqqUwkhMnoMaD/NgPX4syt8vOW1mQupyl0roPUt
 uK8optMrdlydIImnUHJJs7V0BcRaugmMj6vzFzTPq8WMzmsfuWJbfsv6H
 On6cV0gCQHp1OzrICu8nU4xKM9oAV+znZ/SEb8n7cP5Km3t4XHyHQsD+r
 474MYV9uw458YJhsd+puN3vYfCgCEgfnS5wu0ihHMKpeTD3nIh55WXBKM
 VcvAcTBqoZVcHyJG2v6SNvnDBp6e2+9XMm9/wq2vir3OyyhfIUvzdBPeu w==;
X-CSE-ConnectionGUID: rQ3DqO2eRqurvmmmjipq3A==
X-CSE-MsgGUID: h/n/eZRJSTuK3/xsm9tHag==
X-IronPort-AV: E=Sophos;i="6.27,194,1786982400"; d="scan'208";a="160717340"
Received: from mail-southcentralusazon11012026.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.26])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 04 Nov 2026 08:18:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2UA3/ShNmqhX1pIKDPDUXhMZ6u+ed4+gadz5o+yVyHYhRc2JMev/dX95CCG0A+o/DJA9I2SWPY4UY0ok9r/nBpUj12Pzg38XJV2V3ImObcA6K6Euxo4OcT/4gKkwAylGNHpe0CcnAXFdApyqxS43FX9nmQ0/kVZxYtFGa1VpAk9+e+GaDCBFXvPnQmQ8j/+y6xUW+1nIKts4Yv1ySUtUAjswusB1tAI5V/g/3MeHjClp3sP8pUaT/FB7iTUE0gNhmx3EXOk9VDtrpSi5c2+KOJ73IZYdJQcqi8UX9iE7L/R845tmGYKcdC8XbAFA9B10cVawUnNCq3H6DWOhuvVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gHFybrt2IoldAhszlb5ny3ac+XiAGFumlDZ2YRf1sk=;
 b=KrzwNsByoHPRMnoRDXHmPOF1gZ8G3zAmSza01LOaAw2zEkZiRJfrKZbB8SL4RLLG/X2IQ7o7pDxugcTyFo0low/i4EZS1zDF8yj7JYXWqRvxnsnXL4Ut7UPK6XnjnnD4lWnkM//+4TBGyphzgEgVVVs/9l98VQC8ijJc7QwFT2XDxmlvSm8oJUZuH2GUjKf7YeUNnhHPO1a40Pho4vRg8y4DY+xqPVRK+OFcgit/maPjupDwfu6fC+Tu+2dxfi/ac5RLyxc/etihStT/qSQAoRCVjsBgfuBQbR8VHGrWOXK6X2PT61ccIcmcvM+ZQSWSFmoJml9vy0cToHzAdln0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gHFybrt2IoldAhszlb5ny3ac+XiAGFumlDZ2YRf1sk=;
 b=YtRi/88SWpTcWU8bl2MLbPxrN/v9ZEIoaVtf3qzLiO3nsf5/0rnA+kGbCg5yKTxb/IgLjtLvviBySz1n6BoC2dxN2xS7A6OHRhyMJmigQTJqtPR181gWvKKkVuopcL1Xb+sWaQQxUQPG5bD6RuoblxawYzcf/mlkcFvJo1oWCb4=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CY5PR04MB994116.namprd04.prod.outlook.com (2603:10b6:930:128::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 00:18:26 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 00:18:26 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PULL v2 00/50] riscv-to-apply queue
Thread-Topic: [PULL v2 00/50] riscv-to-apply queue
Thread-Index: AQHdXQoR4LFvw70qNkuPbugMpHMJGLcapTOAgAKEvIA=
Date: Wed, 4 Nov 2026 00:18:26 +0000
Message-ID: <170bc1e13e7abe45c34b0ddab66841bc85a79ef9.camel@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
 <20261102095049.31551-1-fritchleybohrer@gmail.com>
In-Reply-To: <20261102095049.31551-1-fritchleybohrer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CY5PR04MB994116:EE_
x-ms-office365-filtering-correlation-id: 18c3df1b-0afd-4c7e-840c-08df3a09251d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|10070799003|19092799006|1800799024|261028144727099003|261026140227099003|261102123227099003|261021121427099003|261022105027099003|261022075727099003|11063799006|4143699003|56012099006|3023799007|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: JDrGoAhARhoYmICwRv/i8GM73uFIom2mM4e6MbGgi9sKlldF443NMcoEs5JAZ0CKIErRJt/h+xlLLUZdPhOoCAXppll73wgWq00JS9i9THQOSWuTS23YG180fzk0ukHq0j8ej0SOSBvA63bBuYDFprSEi7SYRw9Gr1Wn5ScHmJwyKqvq83og9GTkoL/V/VbKKZz+t6IcHGU/bG/lduncwxuJNcH0XOX2k1abx1ES2cXpW0tpqy8zpVYXtU+w1iIULHgo6JrZMAuFF/dBOQH9oPibBE8bn3xRPP+RXrckYPav1PnvJKT2MjlyMC0tU5xIZnSQxxfhhC2AOTr/IsdnUf/p8bi5IRGXYYrL+3URpBKsp7ID1/0sGIglWD0n15r+N35QUdfjooowftzJULO0iXDUYTBzHXLlVI7dXZq9wWc7UNjkUvbpgZnP/gmdQatOFOCPFimxUlm2mTKUemiJoP195BWofVpjOIFI2Uz27NZkH76q817UJPEWfgdk5blGTJi9n66vufNX7CcQnRU2TcHo0olKqyOjh26uYxz4PaE8g67wCLE9jPNRU+xdlTJUeDjfWHX+aGyDhGsDauqiWj77oHurYxJiI+s0z30QPprStmJqsgPaPmfiQ0vfflHA5Ydtmjy61sfUBUvSQrwapBn+iJrFj5sch9UeVDkSLqJilCU9J7ZfkL43k61tW9uIyeIQ0Gidh0tTtpNoeP9PuxIMC23IRL8v/xfCwlBOrjs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(10070799003)(19092799006)(1800799024)(261028144727099003)(261026140227099003)(261102123227099003)(261021121427099003)(261022105027099003)(261022075727099003)(11063799006)(4143699003)(56012099006)(3023799007)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1NwTURMRm9MY01ZVC9jUFhBT2NPTVprWXB3d0hDZXRsSU5iZnhRd2poc1c3?=
 =?utf-8?B?S0dnQUtiMEtQWk9RQmJVTXN1UmJUK1U0UUJpSHFJSFFCbUF2NVcxTFgyK1BP?=
 =?utf-8?B?Rm5lZU1RK1RpRWpmOG92TkM2QksrZGw3Z3BwV2IyeTVsakFkbXBrTlRJNFVu?=
 =?utf-8?B?ci9KK240SStJUDAxVFFpQjI4RmVwdlRLS3g1dEQ5Mkx1dUxZdHFiOXRwMFUx?=
 =?utf-8?B?V2xlaVZLUkpMNHNTbFBxWGJkUTB5MGtLdnVVaU53Y1lxd0xoK0xsMUlZblFp?=
 =?utf-8?B?UlAvbXhQUkdvMXAyL0huUVY5aVUwMEw0cEFURk12bWpka245OUgxZHBNU2RN?=
 =?utf-8?B?dzhYTzBabjdBdzliakZ3SE96bndaUHZQMkdXVHVETytWNnM0aXVWSHBVajVG?=
 =?utf-8?B?cDYyWUVSNHBmODloRXEzZU5HV1JiTUJqclFQd1RtRjRHbGVOclFKYUJqTDFE?=
 =?utf-8?B?elZhVmZFT1hPMzBIK2RXREpBNDNGTXhuTzZ2eDUycGlHMUxKT25GNWFLb243?=
 =?utf-8?B?bG9zN2FOd3hkejc1QlNLelV2MWJjZUxTOHpHVENQd2dNZDRpT3ZVN1RDbmRV?=
 =?utf-8?B?REwxVjRTQjA1aUdSbDJsNFJsN2JvTTU4cnF3QzJJdmVSM2hyZjk5cHRTOUxH?=
 =?utf-8?B?R1FRVGJienRLaHk5aktQeGpwdlFBWWZGY202RzdhZGxraXFKUlFZdmdFUDhl?=
 =?utf-8?B?RlY5eWc3V05yRE5kd1g4c1J6ZGNJeTZJK3E4RzNlTTNPc0U3UlV4OE55UGw4?=
 =?utf-8?B?SDFMajFIOTYxN1NxdzdDZ0RwZGRzeDlsVzdxMVhaTW5UQlVDenR2QmI1QTJx?=
 =?utf-8?B?amd2eitvRWdXK1VWWFV5ZnlTRlVnNjljVFE2Qk9HTENvZ3pDQnBQTnlxclhY?=
 =?utf-8?B?dEc4QXBYMmEwcndMeVhrU2pWZWxad2N2cjdrTFVqajQrak1xRkd2WFFGY0l0?=
 =?utf-8?B?M0wxd3RIL1dmRDEreUV0SkhUejA3eW10SlBVeEIrQ1lzWVVnWVhqS25ZZU5t?=
 =?utf-8?B?VGZKQmM2WGI1c0g5cVh5SGoxK0I5VmpIZEE0RDJWVSs3QldITXhGdWlRUDJ5?=
 =?utf-8?B?UllFWGswaUxRQWFZbE5oTkZvT0MvWWJwSitoRUdHd3JtQU5qM2xGOHRwdk5N?=
 =?utf-8?B?NGFqazF3Qk9NQVdKSFRwaXhaTmkvRm43bFk4ZTdwa3FNSy9saUJJZUxURHNm?=
 =?utf-8?B?NEUwMWN0SU1KbEdFNFU0cDNGVDYxVzJmZ2ZkODRsR0Z0R1NwN1VDdUE5MEQ3?=
 =?utf-8?B?MVNpUUZrN1pVbGJKTnNzUm9kb29TZ290UGwwSE9IRFRyN0Qybnp4QVRvWE5x?=
 =?utf-8?B?SHFlcXNJRjBHNVBkYkxXeGV6enROaUhXbnUxYkhTZnNJMW16Z0pITUQ3Z2l4?=
 =?utf-8?B?Q3p3WTBPQmxTMnJoM3RjNEVsYnlXYjlWaFdlaEdtclpkazNkaVBWVnluRkJl?=
 =?utf-8?B?ZUpveUZkRFIvY3kyU0s0TlJpSlRHSVB5RmRsQWNyK2VSL3VYVGFraTdwa1U2?=
 =?utf-8?B?ZTI0YlBaTURoMVFRTTI0SzRBMGgzcjRacDk5TEt6Rk9INFhzOHBXYWxLbnk4?=
 =?utf-8?B?b2l0aDhDSFBEYjB4UFhoQmRPL0kzQVVYeWQ1Q1FCaUxNWTlkR09DZUpRME5V?=
 =?utf-8?B?K08yYWlabEFOWllYc0d0VkRsZEJBUDQ0UHhqNEN0d1czUUlnallnYzFPQmpl?=
 =?utf-8?B?cVdCSWF1UC85L1lwZlp4Z1lUR1JZUDR3SEpaM3Bva05Hc3JwUWZWVm1JYVlF?=
 =?utf-8?B?UTl0ZEp3R2w4RFJWdkE0Z214ZzJQaG9kWHprcGd4VWY1NWNhTnErMnlkRUp4?=
 =?utf-8?B?Wm1WeDdpbEhEZ2Voa25rbkY3VHZ3NnkzcDBMajRxbnN0T012K2tLVmRqUGYw?=
 =?utf-8?B?UlJYOWMxbU5vZXcybTJIbElTR0lsVUFUUitvUE1tRExjUEJwbDJSQTNyQ2FC?=
 =?utf-8?B?VGl6dkFyMmV4Ull5bXlEa2E5dlJBdDVKVUhkV3dwVEVvMWZNNGpic24vWnpF?=
 =?utf-8?B?UWFnbExJU1VKOEpxbTRpZ2F4VE13UHdIMTJvUy81YUFzWVJmVzBoU2V5ZXpY?=
 =?utf-8?B?dXZTZmpRUTd0YTJTbU10eHZqK1JSaS9MQUVLK1hmdHNjRlI4dFEyczNVQy9y?=
 =?utf-8?B?NTBZV0o2bXZ0UmZneWhjaXVreXBseXNBb1pWRlFBZGFQRkVFYUhsRGl3Znhv?=
 =?utf-8?B?a21QZDhxNDJoYVBwSnJnSzl3WGRWVU1xK2FMN1pSRjhDQ29xY3Z5aWxRMW1S?=
 =?utf-8?B?WUp4TlJGSHR1MlVta3VXVHdRZVVCa3NxdWRRSXd2MzZ3OHoxMysvRTR0aVND?=
 =?utf-8?B?RWxxZW5qVnEzQW9iK3ovQkR6a05KRUtkWTZKUXJyTlBkL2F4TnRPMXQrNW40?=
 =?utf-8?Q?d1PxZfuPPD3nbT+EbTidyBBJLvOfL8CU5aQpbj7mkTCE4?=
x-ms-exchange-antispam-messagedata-1: zYWl6R3CRbOGBuZLrECNc59B1wWcVZH0JyQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4493F6F92F8EC24999DDECB4FE3ABB20@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0ku0IrMWBETaYcDc/nwG7gxdcRsVI8x6G3emjQF8q92i4gSq1qg+pB5HCAugLmXDa/7sbqtkchHI4FYC0iHOjZ9G04Hz16R8yB19ZRk1rR1snSCU7OGKnBZMKzsQLUs/TTv38d+kXLfmWtM2CARunbTF/leBkmGS1QSCQ8xeLw+0bnSi7tiP6RmvY5/Q6I2yHrx6P1vOw7px7tdDeUcS9VfObDCCABxA7xhRK8FGndDB5tCrO8nEQiMaXjr+QdLwLFGYdLnWK/gsJ6WM9yLJFlVC5iwdMvPVtUaHzoEzh9SoxxcS3+2+AxharkoEn9j9NjavCUFlftWpBaVDPAX5UA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eq9x5wrGyTZwKjIRK0HwVZkZvTIl9rIFTfgngEMAlwzylicQadMHNeDHrZbSB7hkdawUIKfxj1aJ2BRUosusn9w6s7B94HhSOFDMtOS0ydNsYM0a0kQqiFznxJfBDHvZWldTttBcA7z+TVjH5iPerZt4ux7yHsc7rk7eUbWOHcZo2k5ETtg0149DoE/955LQLUO/nAlLoqbDofTMWyBvjGAjEdvoS2QK8X4lfDV9khmjP1SXh3KoB8BV53Lb4J7dqA55mUEFD1qREmpMVTI1Aow06EgFO5QYoi2zRTIaL8sp+Ir364LI9d7OOw4ZzrQRj+YJ2qLjxTMxj7d3j1Pv9soz3yLLDoprHEgQwBiQq+q0qOfYpu/mkASpvWQlzV84XSP0s5wL9S3+oedpSrOVfcWp0y8NETG174pbdqNPl59p6AquMGzeNgXW0TIwSU702s26uFwgpL+7N3F56yCyg5csfKtGQoaIQlnOYSx/Ecy8RdKxROQPRY2sjQg2pTOuzjqJpNJEsZ96ph5CGJ0/C8CsmL7gBYTmRW4SfTX0XKmEM6yyKvRrd2/7f2rVopglA6+i8FPaoE2RyetFKpjuHXkiiXXzD0gBCYj6JEE/vTgZyURoe5rgxLNIGuchlUh9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c3df1b-0afd-4c7e-840c-08df3a09251d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 00:18:26.1397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmD9Kc2h38dG/S6LipmiKBbc5Pe7kzUKbNEi78i0rwC8xr0bBu30s6XwoGG3pRIN/DtMdpXVT0879vzOz0Era7gHdoWK6T152E7h2fUkLb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR04MB994116
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTExLTAyIGF0IDE3OjUwICswODAwLCBmcml0Y2hsZXlib2hyZXJAZ21haWwu
Y29tIHdyb3RlOg0KPiBGcm9tOiBaZXBoeXIgTGkgPGZyaXRjaGxleWJvaHJlckBnbWFpbC5jb20+
DQo+IA0KPiBIaSBBbGlzdGFpciwNCj4gDQo+IEkgbm90aWNlZCB0aGF0IG15IGZvbGxvd2luZyB0
d28gcGF0Y2hlcyB3ZXJlIGluY2x1ZGVkIGluIHRoZQ0KPiBvcmlnaW5hbCBSSVNDLVYgcHVsbCBy
ZXF1ZXN0IGJ1dCBkcm9wcGVkIGZyb20gdjI6DQo+IA0KPiAtIHRhcmdldC9yaXNjdjogcmVwb3J0
IFdSUy5OVE8gb3Bjb2RlIGluIHR2YWwgb24gaWxsZWdhbCBpbnN0cnVjdGlvbg0KPiAtIHRhcmdl
dC9yaXNjdjogc2F2ZSBFTFAgaW4gTVBFTFAgZm9yIE5NSUU9MCBleGNlcHRpb25zDQo+IA0KPiBX
ZXJlIHRoZXNlIHBhdGNoZXMgZGVmZXJyZWQgdG8gYSBsYXRlciBwdWxsIHJlcXVlc3QsIG9yIGlz
IHRoZXJlDQo+IGFueXRoaW5nIEkgbmVlZCB0byBhZGRyZXNzPw0KDQpIbW0uLi4uIEkgdGhvdWdo
dCBJIHdvdWxkIGhhdmUgcmVwbGllZCB0byB0aGUgcGF0Y2hlcyB3aXRoIHRoZSBpc3N1ZS4NCg0K
RnJvbSBtZW1vcnkgSSB0aGluayB0aGV5IGNhdXNlZCBidWlsZCBmYWlsdXJlcyBzbyB0aGV5IGdv
dCByZW1vdmVkIGZyb20NCnRoZSBwYXRjaCBzZXJpZXMNCg0KQWxpc3RhaXINCg0KPiANCj4gVGhh
bmtzLA0KPiBaZXBoeXINCg==

