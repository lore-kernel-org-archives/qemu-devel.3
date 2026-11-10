Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92405606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=YWqWG/Ge;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=nTvp/jtJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQZWi-0005RX-KH; Mon, 09 Nov 2026 19:15:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=767f8a997=Alistair.Francis@wdc.com>)
 id 1xQZWf-0005Qu-TS; Mon, 09 Nov 2026 19:15:50 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=767f8a997=Alistair.Francis@wdc.com>)
 id 1xQZWd-0005iz-I9; Mon, 09 Nov 2026 19:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794269747; x=1825805747;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ksc4VdPwSfA783NGTIo7fq52VnYuVjzPoxdocg76J7M=;
 b=YWqWG/GekdCvuaJD8FW0zJnCfHkjfftdSnxGLoaYWPHsYp0v6OtQy2bb
 R/nhsuoxzPX5OSbC65DGgwk0qPfMoTf+NqBlH2QthuyEaUBw1GKKaBv7h
 7FV0mMG68H8hF6ubza1geGanOMuk7dP51QE7ziMDInHTf3xY5jNvKR6iU
 U2AK4bl/VKQ3mxgBprudQD3ChP6UZBUAii+UU9pSe5lnPoTxR/mq6xegR
 Jm74ht7aIDMjE7Lyxhp2YCipGwUpQBkU3mlhwYD3zpc8EXyBA7YOygjnd
 CmmYuaJkb5kaNrKJqcgmAK3MN84xdM2DtZN3/OL96ywiSVDIf04pRZG/s A==;
X-CSE-ConnectionGUID: kD3hZsW7QzS0rK52/AjV4A==
X-CSE-MsgGUID: cyDw6QdGQJGQZqu1b+XYXQ==
X-IronPort-AV: E=Sophos;i="6.27,204,1786982400"; d="scan'208";a="159495911"
Received: from mail-westusazon11012037.outbound.protection.outlook.com (HELO
 SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.37])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 10 Nov 2026 08:15:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVKhMxMnZmBDySvTH60pcPPcOyw+pGqH+H9FC+iy7iuu36nbvQZ/BWaALuPlPv7Dzig0OEf8y1Tm10KfHzQitxblWsjegr0TA6vgG158C1KQv1rUXQiAHjIgRy5qo7fk4M+N9HB8hyZHy8bRQclGKsp3dnZnxni3Hm39gop2HYjA5Dq5zFLS2JCotSdLXBZk16mXqfkf23IoTw+/mU2RQFn6uQzsOguoSkTzI5oNyZras7mLDpreNaev99r2jF0fyQYpSYFFfohZ7996kXM4uC9gwGh3BPUbb6h5Hc7LkG1jlfH7TC398lKnRIpC06FLX5y7cYAPdWqZ0+C73e4v9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksc4VdPwSfA783NGTIo7fq52VnYuVjzPoxdocg76J7M=;
 b=W90kONRypvR/aQXYGoyVuP97183XVXPZxua9Z1iunGi4uGohSoznJBv54sVlimRkqzQkF9962VSAb/EVpBERrJMKmDvOZ6ybbeMNi0DqJrasv7FLnPSD3/WBrqAVOtTQs0/wv5F9vofiwojoeiQxPqTx/Dwn+VRF52q3+Fms+JpQvjNAXrV1OPFYmUshN7pg+AfwV+Jcr9AG/HKiKa57tDrUO5x2bs+NU0tGUGDE1NN752T+Hnyug2aWYIk3pcgOzD3ixAClPAW1cJ6Tcgo2j161VmGFvGTsgELpsRTz9XmFSokmF8D8CyI/DO9qx0BFV9Axq/eIigt1OzH3afEbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksc4VdPwSfA783NGTIo7fq52VnYuVjzPoxdocg76J7M=;
 b=nTvp/jtJc+wiaxAXKdONs6UctjDXmC53TJg6bFbTY86pKQAO4fRZIR55ldlnPOELQ+BzNjXKoHvcSHFcE5ee5lD1WO4+omQcsoCTtzTdxfrkdtuyNkcxz6a5t2weiTpOB43LybdQ0MeMO4RYr59zJaVCmMlMvXReWFSAu6iC0sw=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by IA0PR04MB8890.namprd04.prod.outlook.com (2603:10b6:208:481::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 10 Nov
 2026 00:15:42 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 00:15:42 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "domestos48@mail.ru" <domestos48@mail.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: fix WPRI handling in mhpmevent CSRs
Thread-Topic: [PATCH] target/riscv: fix WPRI handling in mhpmevent CSRs
Thread-Index: AQHdb8zo0yx0MOanhEOfpvSZ470ewLcmcaIA
Date: Tue, 10 Nov 2026 00:15:42 +0000
Message-ID: <6fd7d380382eab3587c46af84a78a4caa018741e.camel@wdc.com>
References: <20261108220232.385393-1-domestos48@mail.ru>
In-Reply-To: <20261108220232.385393-1-domestos48@mail.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|IA0PR04MB8890:EE_
x-ms-office365-filtering-correlation-id: f77779c0-16a8-47aa-d949-08df3ebfc1d7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|23010399003|1800799024|19092799006|38070700021|11063799006|261021123027099003|261021121427099003|56012099006|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: s4hdkca68/PCRW4sw3yTqdrsqjmKxq1tMf66yKy3Wnro4YGC3d0KO+kYy9Rh6723qWfGMLWUAZdJ5ErgIkDeat7CKiDQcab5MzWHfma6PuMpgi+TNeag9neqLmU6eiakymJTSTnRU2eS22FiuVXJi56o9Tqc5Bu3CRsqGa3GijZccJaEO6b+JMKrB84Y9khhH1/x43NAnNiSt+hO7RK7CnYvGl6O2k2091kWvy2i3RIScxVDDEqVJ8mNkK0n3CjI6NEBnosjYX0IWy+MNMByUK3Zix7+MRc+NxCzB8m+oGlmd4OFb8inC6s/AlbdlqFXU4HzlTXb4OuGrdUIF22qEwSWjPWtl1FMA2Lku6mdTQAFByjMf305e+/m3alfRXr6N/XmBXtTiMHWRKVq6dPrV6JYSHC0qyn1OF8TnS1+0y792x8QoHP6WKZDPkKSggbLABdUiIqEoTmH18kGCYM/lucsYlNIpJaOIrBO6Re9EOip4t5pl9WH1WiulQY/SiXoV+cjeV5SV0O5mRL5dSSSDSs8CqMfxoTOF5SLZDEkZ+q7JbxNdTlnIzxR4lbQYDDMZDvEuENNxnpgp2gSkAxood9NM4OG6X4GDuZr69yZMnZldAll/yKCh2AcqLKmHhlWRGUME1slsHEDhD3G0lCTKfbwSTOXuX7eXCPUH72cjvQG+SdIHZ3ApOB2xhgK0qLyB1TxhGu3LIaBAT0PIfPdDzR61ea+h21sB++rwYlMD/E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(23010399003)(1800799024)(19092799006)(38070700021)(11063799006)(261021123027099003)(261021121427099003)(56012099006)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3dRUlVHLzNKajFuMUJPSlFybGdsYWZZdjdoTHc1UjJMdmpLdTRjTUhsek9v?=
 =?utf-8?B?NW9LYmxmVk82aVEwMGFRWitIQ2tuSm03djVlejI5dndUVFhEM0RPREJTK0Vp?=
 =?utf-8?B?UzJ2RUFiUGszTWp6TG0yMlRjVS92R0R4VitiYkJsazN1b3Q5V1hvSTlYZThG?=
 =?utf-8?B?aDFBUlhIanh3M0Q2eEhmWGs4b2JzeE5OcUg3RW1uUFpkWDBHNmtYZUEwV0Vl?=
 =?utf-8?B?SkRmeVlRdmpOdlVGYzZvYVpBWG5nWjFneU5ZRTZQdm45aGVVSW5udEJkbTVQ?=
 =?utf-8?B?VHAxQnY4QzN5SU10Z24yd1VQY2JISEh0U01mSE43ejRQK0xYU2dsZVcvOGFm?=
 =?utf-8?B?ZkJENWpLUjFJamlLbUl4MzJqZTA1eFhEZGpHTUYvU0c1bVFiY2VuY1NIZkRy?=
 =?utf-8?B?VnhQdUZiUHQzL1pyYnRpNEJTc3ZqNS9SbDBsZlUvb1ovRFQyb0Q4QlhNeDBz?=
 =?utf-8?B?MUFGZTN2SjNoa3JWaVZpVzlhL2t2QmxrS3lIL25yS1ROQ1d2b0VXWTB3R2RF?=
 =?utf-8?B?UHE2dk1adVo4RDZvMzlLdERUcHdNS2QweVNFdk9NL3NQUEt0Mmc3djlFM2pr?=
 =?utf-8?B?OWtxS2dhZlNLYzM4cWpmYjNOS2hmMU5mODJSK1A0Z2NkTWhtZU44SHVKR0d3?=
 =?utf-8?B?amJheDRDNzQwZjRLV01IR0RnbzJxMDRrQ2dkdityTEQrN0IrZDd0UzdHbFBh?=
 =?utf-8?B?eURGVlh6cjFMT2pLNWtuVW1TWnVHOWNqaDlwRm5PZ2hHS3M1RUFhMlJEeXpj?=
 =?utf-8?B?TzNvSVltWmVkZDhLUUlxeENwL3J6L2ZBSGx5QU52K254RkdEL3p0dytKZWUv?=
 =?utf-8?B?YUU2M1hua2dxRHRSQVR5bzZjOEdmRjZrZ0V2SkdOcDNQejhRVmEreWxUK1Mw?=
 =?utf-8?B?cXprbGlUSHA3L1I2Y1lPVW5ESFFZY3JibkdCY3F2ZEdFMWxVbk1MdXBYRmdS?=
 =?utf-8?B?dVFqQ3QvTVFRT2d1MlJwb1hZNXduV3RXMlBkeGk3aVA4M0l6M0ZiSldyTGdx?=
 =?utf-8?B?Z21IV2p1aU54YTlqMkRnempDUk1EeWpTUTNjc21XU05KMTZXVFo4RWQ2dHYr?=
 =?utf-8?B?YkVnSnp2MWZMUWRJTXFrakZUdGhTeThoS0JGVGZwWFFJa1BPMllNOWVsejB5?=
 =?utf-8?B?TkdaYWxWRFZnS3ZiVmxvbjRMaysveG9uQXRSMlBSRnRZN3RZSVBQYVJ6anJN?=
 =?utf-8?B?MUtyeTFmODErTGt3MU5jdys2ektUNy9Wa2ZUR0JqQzFtUTFCako2YUtrK0N1?=
 =?utf-8?B?ejN2TW1aaVdxdno2aFhJemtIRm82VFZkdW11d3Vqa2xXTlRRMmFVZEFYUlFN?=
 =?utf-8?B?L3FSMUpzbC9RVElkVFR5cko4UVZUVi8wYjZSMjR4NGZyT0VOSGFZbnNncWZU?=
 =?utf-8?B?dC9LYS9QbkZnQi8yY3BReTBLNVdZRHlodmtMd2JXbzdNbDk3MTZ2ZlM4Tmdq?=
 =?utf-8?B?L2h6M1Z2cnBBWDRKcmtpNE51alYxVXNwWDdQZlVHT0RDME15a29zZTVjbXVP?=
 =?utf-8?B?VHU1ZW56V2ZlS2xUYU1EV05mOHV2d2RCWFkreGRBVWsrVC9QYUgwOCtxR0ZC?=
 =?utf-8?B?Nm11MTNiMFdVZVdueWhmdmczNEN1eHl5YXJkL1ZLTGs4cEo2K01NT0hYWE9x?=
 =?utf-8?B?TjNjQnRRNkZKTkFuTUxqeDRPQUlQeXl4WldJU1BwYm44T1YxdGZHTnlROWRK?=
 =?utf-8?B?dmlVeHY4SllWRHhjdXlqQzZGUmRUYVdYYS9lWldESGFzL2tSV1JORm9LWlY3?=
 =?utf-8?B?d1d6K2RQZXBzL1hzWEhFUXJVRUh5eVhwaE8zdzhUcjl0aVZwUFBNK0FsOWhR?=
 =?utf-8?B?S0lOTmJnd1ZJaFYyNEdQZURxR0NuTEpQdFd3VVUwZXJYbkF0ZTlqeHV2NVI0?=
 =?utf-8?B?K0svKzJxZ1I0ZzRmdGFzMU9YWTExa0ZwdmdWdWF6a3B3My85MkNFSnVEYm9H?=
 =?utf-8?B?NHl3NGM0QkFla2JhTFJ0amNNc2hONUlMYmtFRGFGeU1TbWtzUm93MEJDZWth?=
 =?utf-8?B?V2VtVTZMdU5sQTRXZlVvUUN3VFhDbHJnT01NSFkwdWhWOHljQ3A1dGtFR2h2?=
 =?utf-8?B?cFNLamgzUlZ0TUp5QTBEbWpKenBjeEtKRyt5YUpvZFVocXdyZ2VoN3hrZkJt?=
 =?utf-8?B?OEUyRmpoWnJ5SEFNTm5XMXZrM1lub0dwSWIwa3FONlgxdTFzeUdBQTdQejBn?=
 =?utf-8?B?WFRRTWtjVVIzVTJKczBCWmsxNzd4VEJ0OGxhUENaNkdqek1BaXc3N20rRUJq?=
 =?utf-8?B?MVJLOG9xdFN6TzFBYXk0TE9zV3JFYVVNTWVQaHEwQlhvbWJVbGhrejFORjQ2?=
 =?utf-8?B?cUtKa25vNlFBMm9lNUt3MkpOa3lMbnJpQlhDSXpaNXUwbnVTSURnbWVPK1Fa?=
 =?utf-8?Q?ouPCxtBB/OTSn0GlewKLMq64YxJnQppEAbTZcs6lV6oCG?=
x-ms-exchange-antispam-messagedata-1: zjpnR1HTOfg/5l064185ZR7n4p42zonIYXY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70527566AA786946A33AE7427B5EF057@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gD2ABkkzHbrotrByMyEn8aEzEFAxlJO0mQdzS5Pbmlsb3CZUOjCl56yyD40EMAq1H8M82/wCZD26fFZluyaohI7rdp/VwtaqgDB7WUuExpyddypizY6866NyK24evH+of3RbHMdRfxedPKyqh45ESBXTaas2laWpB///ccarHkvbrWU2LQUN/jgUIltZiPjSVSod2k9ay1/b+76wEH/jdhDda3BeL19U77krVJ1GxQaDA3gr/oyhG6a+H0VYaFGwLA5zYLwOlJ7mtU1mlLjs27K2XpTHOJWyDYOq6S1cBBrH80QaZ0nCAeI93C2oxRHe08xPQu6cFBG4iBDXGDXTIw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WKihxExFth22P8ULO6WvgIhj3rxZVYL9nt2Fxo9uTLqU2pEoD8EohmyGg1IMQ+iTwNQDld7do1u6f5hgvO82tVTSXFO5iQOHcxlVLCe5oLA5nutJOAETIEJveGP/QMwINpVZPGQ7O43rdruNlAYUssXfaBIFq2qHwdZdXyOxst9bru7zGMAfBrY7hgo3vmfigJAsbtPh+70pdnfvq5+URWgua3wR2oBPO2/mRqZUtyrvRAA1XA/UgEbsFIx5QkiojALp9QZ6dYG7wzFNaxdDBFADyrq7kN+5577pC5+apgG61bqlE9x8Mf/WrqiMsvg+aObSCiBnU/tmpkO2WfJRogUHnDWg7FTX+lO3i7nfa32h9ViuxB0vZ9eiTODRp64iQh9//mnhCAk4sYUNgVskbdCsp2v2fLL4R4ce4fYzuIJZYyQcR7sbhMPkNwVDyFBC2WJt2Fpe2mf/jknz9Qv+ryfXjRB1qCK2MRytg7GC4Oh0xVEftC3KZ8jQb0gLMcKGBiXye5HczCpqxwgQ4tSq0/4NUCGsSBrAFZiI26wWdjRMjHlFfyyNQFmLWHDHIgfasc06HtnvFhph9lB1kdJNdQohS8Wa9iNcP0VntdISkOXsk44VrwUVqFkpZJGTY2w7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77779c0-16a8-47aa-d949-08df3ebfc1d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 00:15:42.1638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgB9DLdrKsSpEj1yXimlfMIHzsiCUcDhf+Hpi0XfWgLsAKNc4LzLI4hohPF6AV/3ihIV3EVp7lRb7Io53DVXP+CZ2PoXrE0FaopVH1AUQGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8890
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=767f8a997=Alistair.Francis@wdc.com;
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTExLTA5IGF0IDAxOjAyICswMzAwLCBEbWl0cnkgS29rb3JldiB2aWEgcWVt
dSBkZXZlbG9wbWVudAp3cm90ZToKPiBXcml0ZXMgdG8gdGhlIG1ocG1ldmVudCBDU1JzIGNhbiBj
dXJyZW50bHkgbW9kaWZ5IHRoZQo+IHJlc2VydmVkIFdQUkkgYml0cyA1Nzo1Ni4gRml4IHRoaXMg
YnkgcmV0YWluaW5nIHRoZQo+IHByZXZpb3VzIHZhbHVlcyBvZiB0aGVzZSBiaXRzIHdoZW4gd3Jp
dGluZyB0byB0aGUgbWhwbWV2ZW50Cj4gQ1NScyB0aHJvdWdoIGJvdGggZGlyZWN0IGFuZCBpbmRp
cmVjdCBDU1IgYWNjZXNzIHBhdGhzLgoKV2h5IGJvdGhlciBrZWVwaW5nIHRoZSBleGlzdGluZyB2
YWx1ZXM/IFdoZW4gdGhlc2UgYXJlIHVzZWQgaW4gdGhlCmZ1dHVyZSB3ZSB3aWxsIHdhbnQgdG8g
dXBkYXRlIHRoZSBtYXNrcyBhbnl3YXksIEkgdGhpbmsgd2UgY2FuIGp1c3QKaWdub3JlIHRoZSBi
aXRzIGVudGlyZWx5CgpBbGlzdGFpcgoKPiAKPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgS29rb3Jl
diA8ZG9tZXN0b3M0OEBtYWlsLnJ1Pgo+IC0tLQo+IMKgdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgg
fMKgIDIgKysKPiDCoHRhcmdldC9yaXNjdi90Y2cvY3NyLmPCoCB8IDIxICsrKysrKysrKysrKysr
KystLS0tLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQo+IAo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaCBiL3RhcmdldC9y
aXNjdi9jcHVfYml0cy5oCj4gaW5kZXggMzU3OTc4OWExZi4uM2RmOWVhNGVjMyAxMDA2NDQKPiAt
LS0gYS90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaAo+ICsrKyBiL3RhcmdldC9yaXNjdi9jcHVfYml0
cy5oCj4gQEAgLTExNjEsNiArMTE2MSw4IEBAIHR5cGVkZWYgZW51bSBDVFJUeXBlIHsKPiDCoCNk
ZWZpbmUgTUhQTUVWRU5USF9CSVRfVlNJTkjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJ
VCgyNykKPiDCoCNkZWZpbmUgTUhQTUVWRU5UX0JJVF9WVUlOSMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBCSVRfVUxMKDU4KQo+IMKgI2RlZmluZSBNSFBNRVZFTlRIX0JJVF9WVUlOSMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKDI2KQo+ICsjZGVmaW5lIE1IUE1FVkVOVF9X
UFJJwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoQklUX1VMTCg1Nykg
fAo+IEJJVF9VTEwoNTYpKQo+ICsjZGVmaW5lIE1IUE1FVkVOVEhfV1BSScKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChCSVQoMjUpIHwgQklUKDI0KSkKPiDCoAo+IMKgI2Rl
ZmluZSBNSFBNRVZFTlRfRklMVEVSX01BU0vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoTUhQ
TUVWRU5UX0JJVF9NSU5IwqAgfCBcCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBN
SFBNRVZFTlRfQklUX1NJTkjCoCB8IFwKPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9j
c3IuYyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMKPiBpbmRleCBhZjQ0NGUzZTZmLi5iYzQyMmMw
MDE0IDEwMDY0NAo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMKPiArKysgYi90YXJnZXQv
cmlzY3YvdGNnL2Nzci5jCj4gQEAgLTEyMzAsMTQgKzEyMzAsMTcgQEAgc3RhdGljIFJJU0NWRXhj
ZXB0aW9uCj4gd3JpdGVfbWhwbWV2ZW50KENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5vLAo+
IMKgwqDCoMKgIGlmIChyaXNjdl9jcHVfbXhsKGVudikgPT0gTVhMX1JWMzIpIHsKPiDCoMKgwqDC
oMKgwqDCoMKgIG1ocG1ldnRfdmFsID0gZGVwb3NpdDY0KGVudi0+bWhwbWV2ZW50X3ZhbFtldnRf
aW5kZXhdLCAwLAo+IDMyLCB2YWwpOwo+IMKgwqDCoMKgIH0gZWxzZSB7Cj4gLcKgwqDCoMKgwqDC
oMKgIGluaF9hdmFpbF9tYXNrID0gfk1IUE1FVkVOVF9GSUxURVJfTUFTSyB8Cj4gTUhQTUVWRU5U
X0JJVF9NSU5IOwo+ICvCoMKgwqDCoMKgwqDCoCBpbmhfYXZhaWxfbWFzayA9ICh+TUhQTUVWRU5U
X0ZJTFRFUl9NQVNLIHwKPiBNSFBNRVZFTlRfQklUX01JTkgpICYKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH5NSFBNRVZFTlRfV1BSSTsKPiDCoMKg
wqDCoMKgwqDCoMKgIGluaF9hdmFpbF9tYXNrIHw9IHJpc2N2X2hhc19leHQoZW52LCBSVlUpID8K
PiBNSFBNRVZFTlRfQklUX1VJTkggOiAwOwo+IMKgwqDCoMKgwqDCoMKgwqAgaW5oX2F2YWlsX21h
c2sgfD0gcmlzY3ZfaGFzX2V4dChlbnYsIFJWUykgPwo+IE1IUE1FVkVOVF9CSVRfU0lOSCA6IDA7
Cj4gwqDCoMKgwqDCoMKgwqDCoCBpbmhfYXZhaWxfbWFzayB8PSAocmlzY3ZfaGFzX2V4dChlbnYs
IFJWSCkgJiYKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmlzY3ZfaGFzX2V4dChlbnYsIFJWVSkpID8KPiBNSFBNRVZFTlRfQklUX1ZVSU5I
IDogMDsKPiDCoMKgwqDCoMKgwqDCoMKgIGluaF9hdmFpbF9tYXNrIHw9IChyaXNjdl9oYXNfZXh0
KGVudiwgUlZIKSAmJgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByaXNjdl9oYXNfZXh0KGVudiwgUlZTKSkgPwo+IE1IUE1FVkVOVF9CSVRf
VlNJTkggOiAwOwo+IC3CoMKgwqDCoMKgwqDCoCBtaHBtZXZ0X3ZhbCA9IHZhbCAmIGluaF9hdmFp
bF9tYXNrOwo+ICsKPiArwqDCoMKgwqDCoMKgwqAgbWhwbWV2dF92YWwgPSAodmFsICYgaW5oX2F2
YWlsX21hc2spIHwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IChlbnYtPm1ocG1ldmVudF92YWxbZXZ0X2luZGV4XSAmCj4gTUhQTUVWRU5UX1dQUkkpOwo+IMKg
wqDCoMKgIH0KPiDCoAo+IMKgwqDCoMKgIGVudi0+bWhwbWV2ZW50X3ZhbFtldnRfaW5kZXhdID0g
bWhwbWV2dF92YWw7Cj4gQEAgLTEyNjIsNyArMTI2NSwxMCBAQCBzdGF0aWMgUklTQ1ZFeGNlcHRp
b24KPiB3cml0ZV9taHBtZXZlbnRoKENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5vLAo+IMKg
wqDCoMKgIGludCBldnRfaW5kZXggPSBjc3JubyAtIENTUl9NSFBNRVZFTlQzSCArIDM7Cj4gwqDC
oMKgwqAgdGFyZ2V0X3Vsb25nIGluaF9hdmFpbF9tYXNrID0KPiAodGFyZ2V0X3Vsb25nKSh+TUhQ
TUVWRU5USF9GSUxURVJfTUFTSyB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoAo+IE1IUE1FVkVOVEhfQklUX01JTkgpOwo+ICvCoMKgwqAgdGFyZ2V0X3Vsb25n
IG9sZF93cHJpX2JpdHM7Cj4gK8KgwqDCoCB0YXJnZXRfdWxvbmcgbmV3X2hpZ2g7Cj4gwqAKPiAr
wqDCoMKgIGluaF9hdmFpbF9tYXNrICY9IH5NSFBNRVZFTlRIX1dQUkk7Cj4gwqDCoMKgwqAgaW5o
X2F2YWlsX21hc2sgfD0gcmlzY3ZfaGFzX2V4dChlbnYsIFJWVSkgPyBNSFBNRVZFTlRIX0JJVF9V
SU5ICj4gOiAwOwo+IMKgwqDCoMKgIGluaF9hdmFpbF9tYXNrIHw9IHJpc2N2X2hhc19leHQoZW52
LCBSVlMpID8gTUhQTUVWRU5USF9CSVRfU0lOSAo+IDogMDsKPiDCoMKgwqDCoCBpbmhfYXZhaWxf
bWFzayB8PSAocmlzY3ZfaGFzX2V4dChlbnYsIFJWSCkgJiYKPiBAQCAtMTI3MCw4ICsxMjc2LDEz
IEBAIHN0YXRpYyBSSVNDVkV4Y2VwdGlvbgo+IHdyaXRlX21ocG1ldmVudGgoQ1BVUklTQ1ZTdGF0
ZSAqZW52LCBpbnQgY3Nybm8sCj4gwqDCoMKgwqAgaW5oX2F2YWlsX21hc2sgfD0gKHJpc2N2X2hh
c19leHQoZW52LCBSVkgpICYmCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByaXNjdl9oYXNfZXh0KGVudiwgUlZTKSkgPwo+IE1IUE1FVkVOVEhfQklUX1ZT
SU5IIDogMDsKPiDCoAo+ICvCoMKgwqAgb2xkX3dwcmlfYml0cyA9IGV4dHJhY3Q2NChlbnYtPm1o
cG1ldmVudF92YWxbZXZ0X2luZGV4XSwgMzIsIDMyKQo+ICYKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgTUhQTUVWRU5USF9XUFJJOwo+ICsKPiArwqDCoMKgIG5ld19o
aWdoID0gKHZhbCAmIGluaF9hdmFpbF9tYXNrKSB8IG9sZF93cHJpX2JpdHM7Cj4gKwo+IMKgwqDC
oMKgIGVudi0+bWhwbWV2ZW50X3ZhbFtldnRfaW5kZXhdID0gZGVwb3NpdDY0KGVudi0KPiA+bWhw
bWV2ZW50X3ZhbFtldnRfaW5kZXhdLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgMzIsIDMyLCB2YWwgJgo+IGluaF9hdmFpbF9tYXNrKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDMyLCAzMiwgbmV3X2hpZ2gpOwo+IMKgCj4gwqDCoMKgwqAgcmlzY3Zf
cG11X3VwZGF0ZV9ldmVudF9tYXAoZW52LCBlbnYtPm1ocG1ldmVudF92YWxbZXZ0X2luZGV4XSwK
PiBldnRfaW5kZXgpOwo+IMKgCj4gQEAgLTE1MzEsNyArMTU0Miw3IEBAIHN0YXRpYyBpbnQgcm13
X2NkX21ocG1ldmVudChDUFVSSVNDVlN0YXRlICplbnYsCj4gaW50IGV2dF9pbmRleCwKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKnZhbCAmPSB+TUhQTUVWRU5UX0JJVF9NSU5IOwo+IMKgwqDC
oMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKgIH0gZWxzZSBpZiAod3JfbWFzaykgewo+IC3CoMKgwqDC
oMKgwqDCoCB3cl9tYXNrICY9IH5NSFBNRVZFTlRfQklUX01JTkg7Cj4gK8KgwqDCoMKgwqDCoMKg
IHdyX21hc2sgJj0gfihNSFBNRVZFTlRfQklUX01JTkggfCBNSFBNRVZFTlRfV1BSSSk7Cj4gwqDC
oMKgwqDCoMKgwqDCoCAvKiB3cl9tYXNrIGlzIDY0LWJpdCBzbyB1cHBlciAzMiBiaXRzIG9mIG1o
cG1ldnRfdmFsIGFyZQo+IHJldGFpbmVkICovCj4gwqDCoMKgwqDCoMKgwqDCoCBtaHBtZXZ0X3Zh
bCA9IChuZXdfdmFsICYgd3JfbWFzaykgfCAobWhwbWV2dF92YWwgJgo+IH53cl9tYXNrKTsKPiDC
oMKgwqDCoMKgwqDCoMKgIGVudi0+bWhwbWV2ZW50X3ZhbFtldnRfaW5kZXhdID0gbWhwbWV2dF92
YWw7Cj4gQEAgLTE1NjAsNyArMTU3MSw3IEBAIHN0YXRpYyBpbnQgcm13X2NkX21ocG1ldmVudGgo
Q1BVUklTQ1ZTdGF0ZQo+ICplbnYsIGludCBldnRfaW5kZXgsCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICp2YWwgJj0gfk1IUE1FVkVOVEhfQklUX01JTkg7Cj4gwqDCoMKgwqDCoMKgwqDCoCB9
Cj4gwqDCoMKgwqAgfSBlbHNlIGlmICh3cl9tYXNrKSB7Cj4gLcKgwqDCoMKgwqDCoMKgIHdyX21h
c2sgJj0gfk1IUE1FVkVOVEhfQklUX01JTkg7Cj4gK8KgwqDCoMKgwqDCoMKgIHdyX21hc2sgJj0g
fihNSFBNRVZFTlRIX0JJVF9NSU5IIHwgTUhQTUVWRU5USF9XUFJJKTsKPiDCoMKgwqDCoMKgwqDC
oMKgIG1ocG1ldnRoX3ZhbCA9IChuZXdfdmFsICYgd3JfbWFzaykgfCAobWhwbWV2dGhfdmFsICYK
PiB+d3JfbWFzayk7Cj4gwqDCoMKgwqDCoMKgwqDCoCBtaHBtZXZ0X3ZhbCA9IGRlcG9zaXQ2NCht
aHBtZXZ0X3ZhbCwgMzIsIDMyLCBtaHBtZXZ0aF92YWwpOwo+IMKgwqDCoMKgwqDCoMKgwqAgZW52
LT5taHBtZXZlbnRfdmFsW2V2dF9pbmRleF0gPSBtaHBtZXZ0X3ZhbDsK

