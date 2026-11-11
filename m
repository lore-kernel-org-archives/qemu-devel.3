Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0579A606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=i1Pe9RLk;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=ULp3zarn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzP3-0003MA-Li; Tue, 10 Nov 2026 22:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQzOx-0003Dz-4L; Tue, 10 Nov 2026 22:53:35 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xQzOu-0007S0-Qw; Tue, 10 Nov 2026 22:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794369212; x=1825905212;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kdIjFQt6ed0K7auLXHBFEoyCkwojo2PTlUDXXDftdyE=;
 b=i1Pe9RLkF63/hN1r4flPhE2gKSxCUbO4pNauQmGorwEe73PZVrE3ye2X
 a8H1Zeng+ErPPQJc1KSzCDP1NpuGepxiNhczJTZdTtLEo6IdkWS33cOjP
 SQCR+ulOI4wqZp2wCXrdqC/nk9SjKySuL2sTcTw45P6SqlntkI9foYHrV
 1WgEbABd3EXpFQZGlcbQenr62zB9UILy/d9TSLlUkBNPuYSL5NQ4G1Aqf
 SbC1yJ3NL+eZAghwhxiU8tNQyZIoFpCInCk15czVHaFplxVeoeLGIrrGj
 os3BlUfbm5r1cwOx+4MGCnJK+jqce8gBG762oCLnMM+jmnA/gj/rfHMQD g==;
X-CSE-ConnectionGUID: xEqUN+1XQkyM7b8xwzyodQ==
X-CSE-MsgGUID: UafTSm6aQbSgOHvp2aRVAQ==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="156363676"
Received: from mail-westus3azon11011007.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.7])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 11:53:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyHnWwLGO2wX3Gz8H0hRYZ5RJSxed9eUJuLbQGFGd/O3sU02bwyRehhu+NPisuNvCtssDS0bWi1qJe+zDiHvaWnMSV03jxYmFFnsDOFKI11Lc0K8DgE9yIzbQ1ALqrNrQvxMd5ebKIHFEXxaIsOUEVHOKzGs5G4+Q0+bSyVLpErJbYA+hwz91mUv/1oR1OMBXamBynFz8oq+S4Ttajm6rhv+/1UNlTBjCziXmGDHsbRTPqSoaAgtP6RkYwJRfynqAUYsE5cM3/45+zV/ZB5nG6xieaVo8+sjAiHueYba1N4vO9m35y7pT0OKXB2zDF2UONmXFRJyvjzAk5QFpqB88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdIjFQt6ed0K7auLXHBFEoyCkwojo2PTlUDXXDftdyE=;
 b=OmEgkbr2qBYa8O1+etfeL7Dk/AQ2a0EXnFW6hqP7U+sTauj5x/fM+Vtx7hiBOsmkMeQe6/rhJ5+7B9naD6jbCbFy4SgNv4fqnmsgrRl/CiIqe8d6b2h4hxeL2b2vNCVdMFsePq19nW/yP1o+KekV5IYFE/T3PTJWP+ZDoW/chjV3B3yH2HotUVsIcJd7i5naLGO8bs1uXbyy/aLeRRZ32Tz/iRDyjOZVWW3iry9V4jYzT5K2m0/TaDhkvQgvv2byKk3CS7odIxgWMQtGnm9Lo1eWbj+KCBmsSQfiHcLCO0hD/gWgWthA5TqnLEzF7zwnknYkV9PB2hkvWSFinu+Pqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdIjFQt6ed0K7auLXHBFEoyCkwojo2PTlUDXXDftdyE=;
 b=ULp3zarnJ/7Pk19nmkMEdw+6AWNOcmTxv62m5Wm2xsJpsMlDHN+qONwHxnh6FXW6rs7s0Xk+rDPT0a09QkHDJWjeDdRADcpi72hAcKIRbtaGzmYeRCwInSp3SBlqlDbKKsS0x+c+P2A9RNAHeL85JNMCXunCo/6m8NgMSttEWp8=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by DM6PR04MB6473.namprd04.prod.outlook.com (2603:10b6:5:1ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 03:53:25 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 03:53:24 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "antikostya2@gmail.com" <antikostya2@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 00/18] hw/riscv, target/riscv: initial e-trace support
Thread-Topic: [PATCH v4 00/18] hw/riscv, target/riscv: initial e-trace support
Thread-Index: AQHdYbHe5UOXFXPAGkK9JsPhCqzkSrcoXQGA
Date: Wed, 11 Nov 2026 03:53:24 +0000
Message-ID: <e9fc8f95af8b496179b449b5551db0128d0b312a.camel@wdc.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|DM6PR04MB6473:EE_
x-ms-office365-filtering-correlation-id: 4329f89c-aa8d-44a8-68bc-08df3fa7563a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|23010399003|1800799024|366016|19092799006|6133799003|261009223027099003|10067099003|3023799007|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|56012099006|38070700021|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: LmYW6zSvfo3IALpFlSrJhjnQqpckckH1P55PcMpn54yd5xaWEipCcMZZvQRBYksqcBqIxrWofHkp1hS1BVtdHok44OOmojQnwUjkEob/KRSHDO73xGqRh3EIpgmLu0+zr9rElxOcRNAlNw8MnDunMqE7fwdiX0Vb43zXp/PEd1MTJ8X3t/IGrJI9j0FuLeuw2g5VUbcMc6kwewqP6b60BddPRxBBw3O90t5Bw0kR1h3whZxW/5csj+CJ0Npnb3eMmomRiYWYlfTWG0GlgFZOACDrL5MQ0Cla2Z86vgR+7TdFUj1wsL8MhHYcOawKAZ1SjrhA9IX/ykViM6D1GZGeOrpLMmytWDP6aufls7R4XhdmJuL0mHcQjaRUO0dLFo67N7nqCY1sLtu50R4pYmbz8i0pN/YqlDYWFnf2J4H/CNwEdCkQfuz00lYwyFIfR58HKLdeWZWR/QmU6jEmczjJ26Og/rBN6lKrizGxmL6qGcFqKOCnl5o212cVN7yTcX7VVJOmrBQOxNlq2X0rLo5JRuQecXXVLt3SJp/RyL5QhRHUhO+EjSaXGxcc/ZaCfHaS1jvoYYnHP4P3ZWZU9weVRVH9pMW/IXu+w6e3U3t6OmNQVIAPsDVxMtVPLGF6Zerm4XqTKFYeWR01HVZAomEGPOrOAdDDlprC7Mp1pAxgork=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(23010399003)(1800799024)(366016)(19092799006)(6133799003)(261009223027099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(56012099006)(38070700021)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0pUdytENG9hSHJuUGkvT21lKyt6QlJ1UkJVemluY2JkNkRWazlYY0lqNWc1?=
 =?utf-8?B?bEV2dDZ3d2h1cFZLaTBSaWtZSVVvOXJxTllaa3M0NUhwVWFBNnNqdDdkZzlX?=
 =?utf-8?B?MzZjM3lYbW5BMzZBRktqSVVQeiszcFVQUnpzTGdkTjdKQmkwSTI0TTFWL3BV?=
 =?utf-8?B?OUNFN3B3aXFKcEJsMjRaMHMrQ0lRR3JFTTB6NnlYdkpMWFhIWlBTVWpiZ0ZN?=
 =?utf-8?B?a2EwL1dZSzA3V2FoNG9JZFV5cXhQeEJheUNRVDhIQlU1clE5STI4cWZDdjhw?=
 =?utf-8?B?Um5rNHdPaG1YcUpTZzRna0VjdUoyNU00SCtoUkJRT2dLL1pSN21Mc3FzckM0?=
 =?utf-8?B?M3F5cEQrcE1MMmZPYW4zQXplcXNsaUY1cjc2cWtCenZ3bVhEbUNubnBkWGd3?=
 =?utf-8?B?c1NTZ2FmU0V1TlVlWERTQXpNcGN6bHRXVXp0UlVyNVpyaURpVUVHc29YMG1I?=
 =?utf-8?B?SmpIVGk0Y3JWS0ptRzZJaDhxVkJ5b0R2QkNYUTd0MUx2UTdCOWljRHZaNUU2?=
 =?utf-8?B?KzJKRWRVS0NZVmx6V3BsREdkN1B1c2FWNXVaUDJkZ3V5RHlvSWg3dUxRQldX?=
 =?utf-8?B?RG1Xc21pQlZEUUhjOG1INkRiamVuSFNzcitZSmcrZXpWWUtBN0JjcmgwN0sy?=
 =?utf-8?B?ZnhTNk1xMjhKcC9EaGpRMnA0YnNPMHNaREJDRkhiY3FkcGdtcEVCUjFxaVor?=
 =?utf-8?B?ZFpRb1VYWVZmYkM3Z3l2b1RkbkY0QmZDRG5YN3Y0a0lYRUp5NC9COGZkZXpI?=
 =?utf-8?B?MFlOOTNKOGd5amVJaGwyaFViN3AyWEZ5K1E3anFQc1VXWXhKek5OVEJBYk5Y?=
 =?utf-8?B?TVJQbW0wVU9iRldWSUNDcGV5aTYzWnBtZkZVMmlBeG5wRXhQOTg4ZzJpZG81?=
 =?utf-8?B?SWQwTkw4TDg3aEEyTHpzZ05ONnpDVTRuZE8yZXM3SG9EaFdVZmhpenZLM2p3?=
 =?utf-8?B?Q2V1TU1IVGhZS0xWRk5WQ0VxS3BuM2Y1QUFvbjZqSmUxdDJkVExoOXZSVzk4?=
 =?utf-8?B?NEl4b3RRWnZDa3V0cDY1TGtERGhqOFpKSkovd25XWVVVVjljNk52OEJhZ25C?=
 =?utf-8?B?eUNjaU52eEYvVkh4M0tRU2hmbGJQbGRGT0ZNUlhQdmJ4U3ByV2ZQT1lxV3Bv?=
 =?utf-8?B?b1V0UDBnOFRWaTNubHhpRkx6MDc3UCtqVjk0S3htcXF1L1R5QnlCWXVVYlM2?=
 =?utf-8?B?N1BPV3NVSWcyRURjNWdWZ0NFdkZIamhwZ1U3WkY0SHZ3OG1oOWRxVE0zVkNO?=
 =?utf-8?B?Q2J3RjBmZXJPVE4vcUxKRTRJMy9uVnA0Wmgrdkh6dmpYVWhib0daY2JlalV2?=
 =?utf-8?B?SWQ4ZktqZGZPR1JZMXZvSy9NRVgxU0trSWtLUWc4YWpQRTVEaHFYd0lYQmdj?=
 =?utf-8?B?VTZGY0ViQUJsbmVsSTd4c0wzOEJ4MEJQTEt0M2djTXYwSUkvTzNQczg4ZEgr?=
 =?utf-8?B?dXRadmxPVGRBbGlmUTJhc1g0dko0YWJpdUdJdlJZbTZnYkFxNk5FL2xRdERv?=
 =?utf-8?B?cmdWWWNLWXBURFEwS01TUGkzWWZPWWpCRlp4TUVkRnlaeGp5NkZLcVhmbG1G?=
 =?utf-8?B?dkgyWFJ3bkJEMTRKMFI1UythWlo4RmswcUJYNzJQZVIrK1pWdFI1VmFTWlFW?=
 =?utf-8?B?WHo3L1kxcEV1dDNUTFZ1cDNHekc3SWJxZU9pOEhFRHFGdFJZL1ZkTVYwU1pQ?=
 =?utf-8?B?Qk8yMmwybHJ5NjVZWVVSSXMwWGxmUjNmSWtxY3VOK1g0V2RscGNueGt5djQv?=
 =?utf-8?B?cElUKzVUUGNaK1FpS0pyS096eExRMnBmekhtNXlITkJjYTd0bDlxZUdwdVdx?=
 =?utf-8?B?aXFMdmF5Y1ZRYzJ1bEN5RFB4cCtIKzQ5TXVEQ2ltMUZ6c1ZnNG1EWGNDRjBs?=
 =?utf-8?B?ak1vK2c1RktRY1ZKYW9xSnNjOHZ4Ky9Cd1RvSG9DVmRIQSs2VEVxZld1SHo3?=
 =?utf-8?B?ak5JeWNiZjRGcllhdlRiL3lnZnhyT3QxelpBMGJoVDBFcU84RzhodW9LL1Uw?=
 =?utf-8?B?Z0VaUmFjbzVMczNLWEh2Z3RCUGtOOTFlM2swOW01YTNFVG56cVhUSHE4cWpQ?=
 =?utf-8?B?YU40WmZyRHMyTytHM1JYMmEyYkZkc0NNVkIyWHM5Z2cwOERLUE5kajBhWEwz?=
 =?utf-8?B?TnRkblVxc0pVUlRUa2Q2b3hqaGhGdTJ2T09nQXJzMHAzUzc1ZEtFTmxoSjRm?=
 =?utf-8?B?NkdTZkJwOHRFLzBKYk5GNURLS0dmY3ROdGxJb0Z2eWZiU3ZsRE5heDBlV1lO?=
 =?utf-8?B?TkVicjhQbkxhSFA2U2RLa1c3NmRpZDNGRVBuR2ZBSEhPQTNlc1FTWS9lNFM4?=
 =?utf-8?B?dkpZRUxjY2E2UTY2SU0zdFZFL2tpdkIvSFAwVndJaHUyUUZwaTI4Q1JpS09H?=
 =?utf-8?Q?5OX0kKnDt3zSrVr+ceRJ2DqJpx+w4FHe59AWDzM7ZtE4V?=
x-ms-exchange-antispam-messagedata-1: BqzuQlJ5NP8eDRv/8roateLRoZYdQ67d3FY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C1E090E59669A43975E4F17F567ED15@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Hh8wuW5xMmRzrWQU1xpVOuOfEfCZ53ySausj+NekoEWsrPao92tjm4JjcRKYSI0jZqraJbTj6ZYrFbMkgV089x8Lerbv70ty7wH7VJq+mKoi4h4YJ/KrFhsgJdJrMwHpr3yV+H2T7GuSKN8H5ayTVMYwVJZnmTbmzvD0VrwUuP3JgnBYEIXhHBeBF+bC/qfpU/1M0l4WkExveKuFUanHpcGaRw+RnwM6FXQkZUH9zB8/aeiAwsB3XxiSMP/0fR7OlvezypSfNShfkENW6bIpNMjqEfsTQvuxLXjp09IlCkQ/RgDehjZ9tano26+IOFFhSA9PF82kNtOOete5wd0e+w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ed7TRDGXgGrKcoQSGz7AWw0Q+DxI5eMnOJzyasUWejGfdBWdseTDx2IduXxJSRyOmuv1nngOedvlQ+TlVo34iDDVJNqm8BL9067IdlsRRkJatd5nRSeCkCpcKrVaQCBMMrPJB9vVuqcCXvYVnzGol5atU9gwZwz35bXBq/eTHgzFKfUk0SjTQXkmhIyF7G8y/2lTFikTnSjakOKbAoJPkdXFQfTPjE7ckoE73CFQJzGkXfGCCo+FPyAkEJhGPSqPwFJxUzL2ebc6jxiw+AVAnBu4xx7KhqMHCp6lHd3xDj571GOhIhvh5Om2tdMkzPrRil2KiGvfbbPGCZLYhXtBWkTnmLT7epSY88i3JfIJ1Sh4M87wT+xVThzsoDxvZBDSQbG0CNrqYw749BVKVQePTufPOugL1LzqcgHYwKM8Wc47xQvLcCUrbVOcrsZdW+z/4bzVLO45oeL56IwIB6yZjPEIYihNeVp4IkiS1hNUmJ7Fr86LSfB499vm92pRyrEL+GOH/1Rp2FsgXyRteJhJURt1eFIBd1UPon1PzWCjt0/9F6k7VzHzpWOQoRSUgSyAUdY+6UMk4H+Bwz+j4CxUaIDoSKwcaGILPXz5U8UHzDu2n0vmSzqmDsBKC3vyOiQt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4329f89c-aa8d-44a8-68bc-08df3fa7563a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 03:53:24.8225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2R4/yiRdVd+VXAKd4az954TvkqSG6lOiXj6ePx6aQ5bOA5CjfE6949KE9qc0iXI4wPwlJOWgHgrGKvx4Q+CYm2T43SRSW49tlMx3vqsmY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6473
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTEwLTIxIGF0IDIwOjEzIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBIaSwKPiAKPiBJdCdzIHRpbWUgZm9yIGEgcmVmcmVzaGVyIG9mIHRoZSBod3Ry
YWNlL2UtdHJhY2Ugc3VwcG9ydCBmb3IgUklTQy1WLsKgCj4gSXQKPiBoYXMgYmVlbiBhd2hpbGUg
c2luY2UgdjMgYW5kIHdlIGhhdmUgS29uc3RhbnRpbiBwb3N0aW5nIHBhdGNoZXMgdG8KPiBpbXBs
ZW1lbnQgTi10cmFjZSBvbiB0b3Agb2YgaXQuCj4gCj4gRm9yIHRoaXMgbmV3IHZlcnNpb24gYSBj
b3VwbGUgb2YgZGVzaWduIGNoYW5nZXMgd2VyZSBtYWRlLCBtb3N0Cj4gbm90YWJseQo+IHRoZSBG
RFQgZnVuY3Rpb25zIGFyZSBub3cgaG9zdGVkIGluIGZkdC1jb21tb24uYyBhbmQgd2UncmUgdXNp
bmcgYW4KPiBFWFRfVEJfRkxBRyB0byBlbmFibGUvZGlzYWJsZSB0aGUgdHJhY2Ugc2Vzc2lvbiBp
bnN0ZWFkIG9mIHVzaW5nIGEKPiBUQ0cKPiBnbG9iYWwuCj4gCj4gQSBuZXcgcGF0Y2ggd2FzIGFs
c28gYWRkZWQgdG8gZGVzY3JpYmUgd2hhdCB3ZSdyZSBpbXBsZW1lbnRpbmcgYW5kCj4gc29tZQo+
IGRlc2lnbiBkZWNpc2lvbnMgbWFkZSB3LnIudCBUQ0cgaW5zdHJ1bWVudGF0aW9uIGFuZCBlbmNv
ZGVyCj4gcGFyYW1ldGVycy4KPiAKPiBUaGlzIGVtdWxhdGlvbiBpcyBiZWluZyB1c2VkIHRvIHN1
cHBvcnQgdGhlIGRldmVsb3BtZW50IG9mIHRoZSBMaW51eAo+IFJJU0MtVgo+IGUtdHJhY2UgZHJp
dmVyIGZyYW1ld29yay7CoCBOZXdlc3QgdmVyc2lvbiBjYW4gYmUgZm91bmQgaGVyZToKCkNhbiB5
b3UgbGluayBkbyB0aGUgZG9jdW1lbnRhdGlvbj8KCklzIHRoaXMgYmFzZWQgb24KaHR0cHM6Ly9n
aXRodWIuY29tL3Jpc2N2LW5vbi1pc2EvcmlzY3YtdHJhY2Utc3BlYy9yZWxlYXNlcy90YWcvdjIu
MSA/CgpBbGlzdGFpcgoKPiAKPiAoIltQQVRDSCB2NiAwMC8xNF0gTGludXggUklTQy1WIHRyYWNl
IGZyYW1ld29yayBhbmQgZHJpdmVycyIpCj4gaHR0cHM6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3Bp
cGVybWFpbC9saW51eC1yaXNjdi8yMDI2LVNlcHRlbWJlci8xMDA0NTYuaHRtbAo+IAo+IFBhdGNo
ZXMgYmFzZWQgb24gYWxpc3RhaXIvcmlzY3YtdG8tYXBwbHkubmV4dC4KPiAKPiBDaGFuZ2VzIGZy
b20gdjM6Cj4gLSBwYXRjaCA1Ogo+IMKgIC0gbW92ZSBGRFQgY3JlYXRpb24gY29kZSB0byBmZHQt
Y29tbW9uLmMKPiAtIHBhdGNoIDc6Cj4gwqAgLSBtb3ZlIHRyYWNlX2hlbHBlci5jIHRvIHRjZyBz
dWJkaXIKPiDCoCAtIHVzZSAiQ1BVX1RSQUNFX1JVTk5JTkciIEVYVF9UQl9GTEFHIGFuZCBjdHgt
PmNwdV90cmFjZV9ydW5uaW5nCj4gZm9yIGluc24gaW5zdHJ1bWVudGF0aW9uCj4gwqDCoMKgIGlu
c3RlYWQgb2YgdXNpbmcgYSBUQ0cgZ2xvYmFsCj4gLSBwYXRjaCAxNDoKPiDCoCAtIHVzZSBjdHgt
PmNwdV90cmFjZV9ydW5uaW5nIGluIGdlbl90cmFjZV9icmFuY2goKQo+IC0gcGF0Y2ggMTY6Cj4g
wqAgLSB1c2UgY3R4LT5jcHVfdHJhY2VfcnVubmluZyBpbiBnZW5fdHJhY2VfYnJhbmNoKCkKPiAt
IHBhdGNoIDE4IChuZXcpOgo+IMKgIC0gYWRkIGRvY3VtZW50YXRpb24KPiAtIHYzIGxpbms6Cj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MTIyOTE4NDY1Ni4yMjI0MzY5
LTEtZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbS8KPiAKPiBEYW5pZWwgSGVucmlxdWUg
QmFyYm96YSAoMTgpOgo+IMKgIGh3L3Jpc2N2OiBUcmFjZSBFbmNvZGVyIGluaXRpYWwgaW1wbAo+
IMKgIGh3L3Jpc2N2OiBUcmFjZSBSQU0gU2luayBpbml0aWFsIGltcGwKPiDCoCBody9yaXNjdi90
cmFjZS1lbmNvZGVyOiBhZGQgdHJhY2Ugc3RhcnQvc3RvcCBsb2dpYwo+IMKgIGh3L3Jpc2N2L3Zp
cnQuYzogYWRkIHRyYWNlIGVuY29kZXJzIGFuZCB0cmFjZSByYW0gc2lua3MKPiDCoCBody9yaXNj
di92aXJ0LmMgYWRkIHRyYWNlIGVuY29kZXIgYW5kIHJhbXNpbmsgZmR0IG5vZGVzCj4gwqAgaHcv
cmlzY3Y6IGFkZCBlLXRyYWNlIG1lc3NhZ2UgaGVscGVycwo+IMKgIHRhcmdldC9yaXNjdjogYWRk
IGluaXRpYWwgdHJhY2UgaW5zdHJ1bWVudGF0aW9uCj4gwqAgaHcvcmlzY3YvdHJhY2UtZW5jb2Rl
cjogd3JpdGUgZS10cmFjZSBwYWNrZXRzIHRvIFJBTSBzaW5rCj4gwqAgdGVzdC9xdGVzdDogYWRk
IHJpc2N2LXRyYWNlLXRlc3QuYwo+IMKgIGh3L3Jpc2N2L3J2LXRyYWNlLW1lc3NhZ2VzLmM6IGFk
ZCBlbmNvZGVkIHRyYXAgbWVzc2FnZQo+IMKgIGh3L3Jpc2N2LCB0YXJnZXQvcmlzY3Y6IHNlbmQg
dHJhY2UgdHJhcCBtZXNzYWdlcwo+IMKgIHRhcmdldC9yaXNjdiwgaHcvcmlzY3Y6IHNlbmQgdHJh
Y2UgcHBjY2QgcGFja2V0cwo+IMKgIGh3L3Jpc2N2L3RyYWNlOiBhZGQgZm9ybWF0MiBtc2cgaGVs
cGVyCj4gwqAgaHcvcmlzY3YsIHRhcmdldC9yaXNjdjogc2VuZCByZXN5bmMgdXBkaXNjb24gdHJh
Y2UgcGFja2V0cwo+IMKgIGh3L3Jpc2N2L3J2LXRyYWNlLW1lc3NhZ2VzOiBhZGQgZm9ybWF0IDEg
bXNncyB3aXRoIGJyYW5jaCBpbmZvCj4gwqAgaHcvcmlzY3YvdHJhY2UtZW5jb2Rlcjogc2VuZCBi
cmFuY2hlcyBpbmZvCj4gwqAgaHcvcmlzY3YvdHJhY2U6IHVwZGF0ZSBicmFuY2ggYml0IGluIHN5
bmMgbWVzc2FnZXMKPiDCoCBkb2NzL3NwZWNzOiBkb2N1bWVudCBSSVNDLVYgaHd0cmFjZSAoZS10
cmFjZSkgc3VwcG9ydAo+IAo+IMKgZG9jcy9zcGVjcy9pbmRleC5yc3TCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsKPiDCoGRvY3Mvc3Bl
Y3MvcmlzY3YtaHd0cmFjZS5yc3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCA5NiArKysKPiDCoGh3L3Jpc2N2L0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDUgKwo+IMKgaHcvcmlzY3YvZmR0
LWNvbW1vbi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCA3MCArKwo+IMKgaHcvcmlzY3YvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICstCj4gwqBody9yaXNjdi9ydi10
cmFjZS1tZXNzYWdlcy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDM3MyAr
KysrKysrKysrKwo+IMKgaHcvcmlzY3YvcnYtdHJhY2UtbWVzc2FnZXMuaMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQwICsrCj4gwqBody9yaXNjdi90cmFjZS1lbmNvZGVy
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA2MTAKPiArKysr
KysrKysrKysrKysrKysKPiDCoGh3L3Jpc2N2L3RyYWNlLWVuY29kZXIuaMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNjIgKysKPiDCoGh3L3Jpc2N2L3RyYWNl
LWV2ZW50c8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoCA5ICsKPiDCoGh3L3Jpc2N2L3RyYWNlLXJhbS1zaW5rLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjYzICsrKysrKysrCj4gwqBody9yaXNjdi90cmFjZS1y
YW0tc2luay5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgODMg
KysrCj4gwqBody9yaXNjdi92aXJ0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMjggKysrKwo+IMKgaW5jbHVkZS9ody9yaXNj
di9mZHQtY29tbW9uLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA0ICsK
PiDCoGluY2x1ZGUvaHcvcmlzY3YvdmlydC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArCj4gwqB0YXJnZXQvcmlzY3YvY3B1LmjCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEyICsKPiDC
oHRhcmdldC9yaXNjdi9oZWxwZXIuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqDCoCA2ICsKPiDCoHRhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI2ICstCj4gwqAuLi4vdGNnL2lu
c25fdHJhbnMvdHJhbnNfcHJpdmlsZWdlZC5jLmluY8KgwqDCoMKgIHzCoCAxMSArCj4gwqB0YXJn
ZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZpLmMuaW5jwqDCoCB8wqAgMTMgKwo+IMKg
dGFyZ2V0L3Jpc2N2L3RjZy9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgNiArCj4gwqB0YXJnZXQvcmlzY3YvdGNnL3RjZy1jcHUuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDkgKwo+IMKgdGFyZ2V0L3Jpc2N2L3Rj
Zy90cmFjZV9oZWxwZXIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDYyICsrCj4g
wqB0YXJnZXQvcmlzY3YvdGNnL3RyYW5zbGF0ZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgMTYgKwo+IMKgdGVzdHMvcXRlc3QvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICstCj4gwqB0ZXN0cy9xdGVz
dC9yaXNjdi10cmFjZS10ZXN0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMjAg
KysrKwo+IMKgMjYgZmlsZXMgY2hhbmdlZCwgMjAyOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRvY3Mvc3BlY3MvcmlzY3YtaHd0cmFjZS5yc3QK
PiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBody9yaXNjdi9ydi10cmFjZS1tZXNzYWdlcy5jCj4gwqBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvcmlzY3YvcnYtdHJhY2UtbWVzc2FnZXMuaAo+IMKgY3JlYXRl
IG1vZGUgMTAwNjQ0IGh3L3Jpc2N2L3RyYWNlLWVuY29kZXIuYwo+IMKgY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L3Jpc2N2L3RyYWNlLWVuY29kZXIuaAo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3Jp
c2N2L3RyYWNlLXJhbS1zaW5rLmMKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBody9yaXNjdi90cmFj
ZS1yYW0tc2luay5oCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L3Jpc2N2L3RjZy90cmFj
ZV9oZWxwZXIuYwo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L3Jpc2N2LXRyYWNl
LXRlc3QuYwo=

