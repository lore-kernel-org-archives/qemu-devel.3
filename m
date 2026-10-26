Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525E606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=hz8cKlUf;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=M332aVa+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLUT3-00055u-LJ; Mon, 26 Oct 2026 19:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLUSo-00054V-2u; Mon, 26 Oct 2026 19:50:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLUSm-0003I0-AV; Mon, 26 Oct 2026 19:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793058648; x=1824594648;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ClDuAk5wGaahFJEY+Cpgc3YkTdyTe5JauCLKmlr7vyc=;
 b=hz8cKlUf1OGedqGPhgM96M3oedvd/hjN0UZYrrWtNLqNJc1G9sdhZfuq
 5WvcU1ZPPfLpZ55tjvyl6ah0cBbj5IOUjtoARJxInBbX4SukRAtadKWw2
 S9AmLz75nFOKwHQwqCEVS8EtiftpMbw0Ogjawev4pxN6LC69ryTkHRONl
 ufaefTWOuvwzjVeOk9hWIb6sSJzty9Ld+cg05lwXL2El5JYvADbNvxa9x
 Bxky6nOWwIhYXh+TP/07z4ShdG7PqeUzWIAjKlhq9NtASu12Htsf6thQq
 5lP2oEne231enVgxxQNBWh9pneacRlhW4KvEZSkpCsXc6mT5a1bSUlYLf Q==;
X-CSE-ConnectionGUID: 224dzpxeSUyij7oseRqrvg==
X-CSE-MsgGUID: aRQMqAT6SqmZjKloe4DnYw==
X-IronPort-AV: E=Sophos;i="6.27,180,1786982400"; d="scan'208";a="158095139"
Received: from mail-westcentralusazon11010033.outbound.protection.outlook.com
 (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.33])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Oct 2026 07:50:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUrjoOrQa5NITXyG4l1C9jeDpJwB4yvupXz/ruRe/uSbj1KThcqkQ7r/prG13UKJcvqw3hqdTYGaWd19uEVRFY8xOhza7Ha2a3jXLT+JadmZy2/1gqWyeulvSLRV3zQnhBnfySdp3q3jsF238bKRJeFAm4Txfq9ZV/XAd2g4HMZCsTb6+zaI/mauMdS4aYZA68jVuLwiD0pavumvb1iZljOOtNeJd+0XjGKcOXEp3N+tN1ml24TMKiCKNPzp4Y8H3jrnlPvGcuT/K04kACPkXDN1XxXGIpwaI8ly+VRhEFJfjmLnP3v4N0X3eIazhaM2L2/4Zx2YQFwYHpSNd6+o+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClDuAk5wGaahFJEY+Cpgc3YkTdyTe5JauCLKmlr7vyc=;
 b=HZb8ribEv5Ni/wYTGbJgGAZa7yrljtoshgUX725FFrYtSgHF60YII4KMeGOJjm9Op97tfGbWfdXvAVwdf41kq9WAp1JpZfEmH7y5XNHF0keLht7rQ3kbHcTKRHz4KNDI5MMHtrpL6IUkbVawGiFg/uWzIXBfdhCrbukzXsDrKQh1AdLj6JyOMeT1KPnL9yjaJSNKulVRHleREmuJzeN/YH0+WDrf0bP+CBHFzOTBgNMTr20RTlxTWZmeoZSk5TCjxFcl8O4odrrlJc51/GQmRwUGEZcL+ADmUjjX4XLxZw6pbYoUdEx9eLfzeFC+7QAZl6Ldu0txoNSbp0gWyiJl8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClDuAk5wGaahFJEY+Cpgc3YkTdyTe5JauCLKmlr7vyc=;
 b=M332aVa+ZQnqlbi/zzpH5raagGE/EWpN0bsoYRtzmiBCrxNefqy2Jqls44B/qLE+ekPJ7pKHaHNljCEpbuPqmG2H1Q+D4exaO6EyZUMlIwuUYpc3nAukj3BED+WoU1gGhBUoTSLmkchJk2seL4Dvgw9HjH11HJFxjihTBJUT88c=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DM6PR04MB6428.namprd04.prod.outlook.com (2603:10b6:5:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:50:43 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 23:50:43 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "palmer@dabbelt.com" <palmer@dabbelt.com>, "wang.yechao255@zte.com.cn"
 <wang.yechao255@zte.com.cn>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: Remove unused MMU_USER_IDX macro
Thread-Topic: [PATCH v2] target/riscv: Remove unused MMU_USER_IDX macro
Thread-Index: AQHdZPgCL2dCZtEmR0+ZRKog0GBNTLcQf7CA
Date: Mon, 26 Oct 2026 23:50:43 +0000
Message-ID: <b1d39714d65dcce3ebfce391874227c9b32258e7.camel@wdc.com>
References: <20261026031144.631964-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20261026031144.631964-1-wang.yechao255@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DM6PR04MB6428:EE_
x-ms-office365-filtering-correlation-id: b4f04fb7-41d1-46f2-a5d5-08df33bbf2ff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|19092799006|23010399003|1800799024|261026140227099003|38070700021|11063799006|56012099006|261021123027099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 322BcbLN7kE3eKD1qgIYajAhsS1qg9oRZCH2+YEokvye444ZzwHAUq5SCXC0WOqaOUB20julwcM7m7h+kUOZ/bZ06lQth1KW6M+tksy2FvJB3Rj/D2wmBwYwj0c/Ig2PIl3CGnL1QgtBUVSVSgP7ETo/sbO90lVR5zO3d0ua5Syz/HQ6nlxcCzEyQTKxgd73ZpiN/ZdEPgJam0BrgNuR9tZ9DNmHr2WfI/2gsQnoHQu9jvxYn9OYqIOBM13I5v+N+gWGB93WT1kNxVBQiwi0+Um01CbUBtl8CNMHGNDRQF/+ExHUx+TtFYNCW6ELgMxOPVNoOEX3Dk5VJNK4oNuBStcmRI1v5UObY6PmQep9IXw18KXeBRFBLDU3m+/XxSCLcf8Bg4OEA0+maRmd2B8FPIx+kkPZbB5MllmtGmxqn1QqbihvNAIK2l3RivXYVUlqr3frlaxWkDi73hikRC7eUEmx5A0rcxtoczGgn2lQnw+XWtIpovyjrFTr6rz5Aj25lsDkqna8qqdl6AH72CQ+F7a0UFZJv8jN9+C8grKm04mffk7H5urs0QAWFAwqgqmfzAtfmHr3E7Yi1XzR177MMtu3+B7aBVRAho4IrO58Y0SEdrguCwi3vl2xPh6zZF8KYcwSHMJ2H3ljGq1QW3p5/c4fZb0HYS8Bhxe55K8+qIY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(19092799006)(23010399003)(1800799024)(261026140227099003)(38070700021)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmMvemJKWm9rMlNjM3ZKcVRyWmJoNjU1VkVvak10Rjl0WjRnSXkrN2xYaWdq?=
 =?utf-8?B?SEljWDJ0c2VNb2xWUW5PdlA4VG1zQlZQKzRzZ2ZLejUwcGVWeDYwZ2trT2p2?=
 =?utf-8?B?VzUvWGorYnJ0WXo1Q0lNd1RwM28vS0REOWkwL1hSOU9kY3EwWWR6Y2c0ZStH?=
 =?utf-8?B?aXBYa0syNkc1OEFDTGloN0VTTTRoWDR0d0c2c0x2SHkrR2IzTkxoSGZQb25P?=
 =?utf-8?B?R0tNOW5mQStBalAyK1ZPWGlURVFjbm15YURYRENKSGhETmJJV05RcVNYdkdO?=
 =?utf-8?B?S2lsRTJxc3o5YVJsTjdBbkdzTTBrSURubVp6ZTNuVnpYYTFaZmY0bVBZS3FW?=
 =?utf-8?B?VTV2cVVjVzk4WVBDVEJqVlZhS2JOMk9hcW1xK1JqNnRkeVQ0aGZnN0tveXFV?=
 =?utf-8?B?c0xRUmpxeHc2QWg1eXVhM0p2V3JxeVdJeW9JNjk5cW1PZ3BuM3ZwTFI0b2VF?=
 =?utf-8?B?anZvNzVhUEtuMHJ6d2gxV2R1eDRLajlWQVNNQUZNTGYwY2V1VkdSUW83aVZM?=
 =?utf-8?B?bFZtSi8yMWNYM1hzOGxnN0cvZ0FJREFobEViV1p2dFBNUW8xdDdxUE5FdWZp?=
 =?utf-8?B?QXBraDdYczAySTBXdHg4dERPN0NhcHBVU1FrVUUwOGhqckRVTkJFUDRNdjF1?=
 =?utf-8?B?VWtjTzhMV0MrOTdmSmY2VTZ2SXA1dnhtSm55SVVpVzlVU0x6NEZPTGlRNFdU?=
 =?utf-8?B?MFQ1R3NKalk3NXVXQUFGWWNQdnlGWWNGZFhUT3FzVWFQRytNMFFxWnNVeWFJ?=
 =?utf-8?B?d2RQL1dlWDluWG9PWXlBOUI4eDMyNkYxZFR5TUw3RU5iaTJTNXQ5QUlFNzho?=
 =?utf-8?B?MGlXSHJwclVpbUtpT1dlV1BKaUpHRzZBclN1dWcvRStoVHFvMUpZZElqUHJp?=
 =?utf-8?B?MGNpZlYzTnRNTWJVZ2o5YjRkT3gyTUh1VWpsb2hXYmFOUCtNaENXNVVlakNX?=
 =?utf-8?B?TmtZMVQvTWN0bkQwQWVicGhwM1Q4ZGJMRUM1cTFaOFRMcnkwNjByandJcjBw?=
 =?utf-8?B?cFlCRWdFMUF2dmJnSU9BQ0xpZ1ZMUlljem96VXFTd1hKS2NhQzZrbDRyQ1BB?=
 =?utf-8?B?VlBTaytNb0Vid1IyWmhXdWhTN0U5dEEwemdINUx2RlRNdXhWK1QyaDB2cmh6?=
 =?utf-8?B?ZWZaMmhpNTY2NG9LY1Q3aStHY0F1M3FZVU1KOHJXenlQVklRai9KSWNuV2cw?=
 =?utf-8?B?L0NicTlsTVRsU2JndEJzK1FxaDhPcGxERi9DWnVrYjJJSC9kdkhQejZMTW9F?=
 =?utf-8?B?aGI5b1kvQkVLM3Z4RWxOajhiQlhKR1J4WmlPenQrZVRNVGZsK3VYYzlrK3VU?=
 =?utf-8?B?ejMxYml1M1djY1lOUldoQnk4dm1xSmtEWWptRXhRMWdNNS91SlgyNjNra3F2?=
 =?utf-8?B?QzJIOWdsU1RYbmFvRUkzM1JDWUZtQTF6WnVvNHRWTmhYZXVMTnYwLy94dnR0?=
 =?utf-8?B?MUZZaDZnR0dZWTRyTnVkZTZpU0lzVWVzZDF3bjIyaWhaSWFMQWsxNEZtTS9k?=
 =?utf-8?B?cEphcGZrQVhWT2VTLzhrTDFYemJZMkRubEQ1REdqQ1VSVGs4NlpZNE5qQUdD?=
 =?utf-8?B?SEV5V3plSDZOY0lSRTlBZTlqS2h5V2RBcjkyNEFTZUs5cXdsYVhZQ2RkYTdD?=
 =?utf-8?B?WXdhUzhTbDJPeU5udFRPZW56VjZoK3M4bVFQbnJaRG5yU3BZRHVqb2UzZktT?=
 =?utf-8?B?TXI2Z1hXNmFQcnExSit2RWlFSTNkalN5OXpCYjhnWThjZWpzZ1dGUW81eEgw?=
 =?utf-8?B?SXFVMU5RTWZQR2VvZFBtdk5DWGd3SU1GN2p6QmRwNHFsSmYxK3FkU1NjTXZV?=
 =?utf-8?B?ZStPS0dLRmFCWVFEZzR1ZnpOK0YxYTV5TU5oY1JQOHF2TUtmQXl4MFVVZnN2?=
 =?utf-8?B?TEQyVGV3bXRjTC95T0MzTU9TUVZaa1F3dmFkRjVGMUdXTElWeEZUcUZlVlhN?=
 =?utf-8?B?dkc2eU1DcUxSckpUL0YwRUFQUkpOZ0QrN2tpYmVKSitVejA0N2tkMW5lNFhD?=
 =?utf-8?B?b0llQ2p6QVZSbHRhMUtiUXp3c0NDTjhuaTFkeGs1WGFxN3Q5RlB0anYxWTBG?=
 =?utf-8?B?NWFrc2wxZmpPOUpGbGswQmI0d1hEaGhQbjdFQVhIVmxEend2Y1FyNDEyejB1?=
 =?utf-8?B?bWRad0pIYW1XbFk1UDFlbFpobXhvemdXK0pFc0lWaW5QNXlsOGxTbkZ3NThM?=
 =?utf-8?B?TzRkMmJHanJVQmxGZXljNFRwczZPRG1SelRLZUF0WGk3WVNjZTA0L2Z4RzM0?=
 =?utf-8?B?dksxVDhlenB6UVlLTTlkNEJydkllME5nK2tTMllucmVubEZHbzJNOXI5S3d3?=
 =?utf-8?B?d2k1Z2pBT1BFVlNaei9qY1ZqeUlacURyclJubHJVSVhEUG5Oek16ajk4SzRz?=
 =?utf-8?Q?qJnNE2ryxVjAEvSvas8fxyneecHnC+7GMw9DfTP1Mz0Sd?=
x-ms-exchange-antispam-messagedata-1: yG6/TZc+qX/XWdJRPu7oZYYpfpyOYqi5SJQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEF67AE55047BD44833A6DDDA06FF4E0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zeT+UjS/i8tSfYf6TZs0PVlZl7Q9sAmkRKJAn+lPAs07I378SbaHsMS2Nu0CqoS6xdWFP9Vz2eRFRq1AI/QJlOWDnN9Resn5KGPeXLyvvcJj6ectFekvOtkPzWl53rolQmHgr36J/7rBm+qPMQ0PiHEdUY+Uoz95tb+xS29PgDNMlNJnYvBZ3elHLFXff5T9sIzQOhMRPoaSORoi/pNmDsStu8hTOT8NPypsCFLlIGLoGxCMMKkc5x2OMiI731ykolDc1p6IzuOl6vGIdRaMlH5vYXuAUGhDArkxAV/RSGlATq+EedJjZCAb3BdhG/FK4UcqmbT+AYoXYG/w2mDF7g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4xYtXP2wlYYqYesDiAgzTDioU8bXuONDMKr/KnrRPCLn2MvmITrxsK3SokJ442PTpiSqL3nFmK6lkaDVrGEwubZEUeHVqdi8RCfklrcuGrMsUs+zdTSx1dRQKYxBTOvtJ8BT2QtbLY65XIgNTGcqSAdrJ2kXBnbEpZZtJcPrIZDPB9zjdFM4DTsHbnWn5uVsyrdudHLqPEBEbuB5P/7VovUFVOwcpRE+oRyoIY6UYj9SC57L4yXMSOvJd+inrGY/nkPQzn6UntOM1r2pIwH/WoWIs6tlQBwJRnu98R3osWyTTAWBNzTpXEpuGkT8xGLB0S90WiTfuoixir6VqPdPpw9MtAJwGSl4J7y+gmfXVD7B3vvHQvvDtaA4D9wv8MnhdBQ0UTDOnaCGy0KHd+cVuNbS6woNfaoDgHyFkk/YqahWXZ1b7IVlO/rU4+jY+q7/RUqCi2JG6evPVJPna0+JUrK4adtadRlWIfZaRc+51j5qWHoNPEYpeqnY+CnqzVlkFJCQsDhoD7qbR7o6hsTFXDQlnJMMEawVgfvGH6fTdsApHGCrtKl46dn3XOMQC/8Jij4aMzPcVP1+hZaNXAMh1QJKPQyq3dX78Fr424yH3NJ8X0LVew2swC59E+Hi25yM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f04fb7-41d1-46f2-a5d5-08df33bbf2ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 23:50:43.8466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJTZU5vqOcfhFT3kXxIz0DTzkmPFmf4Mh7bEFyaTqMjMoOuk9IDsuxISmB/jpeSVwVgH6a9Ur1CLGRgjdo76ILyZiAp0gnHk5XI8CV/Y3rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6428
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=752564754=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDExOjExICswODAwLCBXYW5nIFllY2hhbyB3cm90ZToNCj4g
TU1VX1VTRVJfSURYIGlzIG5vdCB1c2VkIGFueXdoZXJlIGluIHRoZSB0cmVlLiBJdHMgdmFsdWUg
aXMgYWxzbw0KPiBpbmNvcnJlY3Q6IGl0IGlzIGRlZmluZWQgYXMgMywgd2hpbGUgdGhlIHVzZXIt
bW9kZSBNTVUgaW5kZXggaXMNCj4gTU1VSWR4X1UoMCksIGFzIGRlZmluZWQgaW4gdGFyZ2V0L3Jp
c2N2L2ludGVybmFscy5oLg0KPiANCj4gU2luY2UgdGhlIG1hY3JvIGlzIGJvdGggdW51c2VkIGFu
ZCB3cm9uZywgcmVtb3ZlIGl0IHJhdGhlciB0aGFuDQo+IGZpeCBpdHMgdmFsdWUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiB5ZWNoYW8tdyA8d2FuZy55ZWNoYW8yNTVAenRlLmNvbS5jbj4NCj4gUmV2
aWV3ZWQtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3Mu
cXVhbGNvbW0uY29tPg0KDQpUaGFua3MhDQoNCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4
dA0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEFkanVzdCB0aGUg
cGF0Y2ggZGVzY3JpcHRpb25zIGFuZCByZWJhc2VkIG9uIHJpc2N2LXRvLWFwcGx5Lm5leHQuDQo+
IC0gTGluayB0byB2MToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2
MDEwNzE2MTMzNjEwOFJidmdJRUoxcHd3X2ZLWnRNcmVGcEB6dGUuY29tLmNuLw0KPiANCj4gwqB0
YXJnZXQvcmlzY3YvY3B1LmggfCAyIC0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdS5oIGIvdGFyZ2V0L3Jpc2N2
L2NwdS5oDQo+IGluZGV4IGI2NWQ2MzE5OTQuLmRmNzQ3N2ZjNWYgMTAwNjQ0DQo+IC0tLSBhL3Rh
cmdldC9yaXNjdi9jcHUuaA0KPiArKysgYi90YXJnZXQvcmlzY3YvY3B1LmgNCj4gQEAgLTE4MCw4
ICsxODAsNiBAQCBleHRlcm4gUklTQ1ZDUFVJbXBsaWVkRXh0c1J1bGUNCj4gKnJpc2N2X211bHRp
X2V4dF9pbXBsaWVkX3J1bGVzW107DQo+IMKgDQo+IMKgI2RlZmluZSBSSVNDVl9JTVBMSUVEX0VY
VFNfUlVMRV9FTkQgLTENCj4gwqANCj4gLSNkZWZpbmUgTU1VX1VTRVJfSURYIDMNCj4gLQ0KPiDC
oCNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQ0KPiDCoCNpbmNsdWRlICJ0Y2cvcG1wLmgi
DQo+IMKgI2VuZGlmDQo=

