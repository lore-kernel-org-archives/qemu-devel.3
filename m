Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0E606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Ufyso+Ow;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=dGssj+Gm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJRh-0006nK-Ew; Sun, 22 Nov 2026 21:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJRd-0006hA-8q; Sun, 22 Nov 2026 21:06:14 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJRb-0005fF-JU; Sun, 22 Nov 2026 21:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795399571; x=1826935571;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=ZP7NCcAWV+q8UgMhhTG166CgyK3M3tA4R8JPuc5UOG4=;
 b=Ufyso+OwAIjGOv6hxW4M9gGE+H8PXgVYfXn5AjkStBvFYKhK7srHGE5+
 W8j42nVGp8wGXvaGAL6YdPmvAkTf18z/Xrwo2sEIfHiM7YrOKwTpoEw8H
 UpMrqwXVWBM01X49yPV8anzAlNcYpDALCUEH2gL0qWw5f1JCsvWVuUes4
 nzR2AW8mIw7tKIIOCr/U8+D2v+8ETTTSBBcm6oEPToO7WyxIp0G74zNgZ
 iaDJohaG3cbGO8jz9HnrUy9bZV+bn9/SDrsu0EFbKPBsIcWcLpxoLCY5B
 59PRZJF84jtH77St/nrh+4u9tzzR4WERXlYhoflna1GEjXb4GYS54ZyIs A==;
X-CSE-ConnectionGUID: JPLI5PxaRUGMYX6TPlgD9Q==
X-CSE-MsgGUID: wbL48jU/SsasddC2dcuhpA==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="161449271"
Received: from mail-eastus2azon11011071.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.71])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 10:06:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4ypiGuAIrwcukV2YGf+YO4Ds+u2hC9A/KzGi3r/xNdwvtUHztd/X3A685kJivS+nwYw+xsVjbnR3iAli7cTqLILP6O2BgLUUcavfXoj+M9GJn502DrFzuovnIdbNyOwE0fJ931BAxc5+YnQhgN/izHl9z5Jg0OIgvazFYsRLqtxSsjdZqYCX4Lmjx05kxy72LlCHmBhzCDfLjOOIW6ehxCp7UCguFHpAEJHjytI19GvP9eCC2ELdQ5l9Q4GMCM4oxVUCMgOl7g/c/YYWOy6FEBOLqKA9FYjJq5IBAdD6nud1PM6DspDzQdcIcrYKYIXAtxrVP0KuyBIiY9prs+gzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP7NCcAWV+q8UgMhhTG166CgyK3M3tA4R8JPuc5UOG4=;
 b=gALuDGUwGN7p+VRCVqgSwVxHt4xNh90FsOYhVmn8qknHKUuQrjpOeCQyEPtsi8VEhVbPfYmx4p9qXi4D8Y+tf+VWjdlAhiRLFQYPZMieEgKxh2dLpn8vJuv3KSNMjLQtOC8bMJTC7wdfWg2X4jGY7q4GNWr5aulZS5YDI1CCxFr8Q8iJWs9+9MTDaFKqAswi5MX/v6EtEEjJgz21vnt4WeG2cxhu3CbmZ9ItRe93KRTu6WsUkVeXqEuBN7Yiw8pmYcXBrlPl/Utr0V+yt8OUywjiGYVuoo6F7vzuNRIbnFWdTmCyNXtNAu3JqmD1aEXJP+T96vAmcCYjzzKhnRSAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP7NCcAWV+q8UgMhhTG166CgyK3M3tA4R8JPuc5UOG4=;
 b=dGssj+Gmwym5o4/BuYyRrCefBzNBQJWI1iKZ96rViob8eMFqAQW2gyecdTYR8jFKr5kwP/1J+wW0unbGe3+ClstiTCj70PpmdsX55k8Yt3jOUQShKn5B4qzjSVJs84HUPD0Js+Aa1LhGFCxJL/uduq2XX6I0c0KGBPlvnPQ+P1E=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SJ0PR04MB7485.namprd04.prod.outlook.com (2603:10b6:a03:328::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 02:06:06 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 02:06:06 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "christianslima@proton.me" <christianslima@proton.me>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH 0/2] Change mstatus bits to read-only based on modes
Thread-Topic: [PATCH 0/2] Change mstatus bits to read-only based on modes
Thread-Index: AQHdc7jTbGS2qsnvIUudUerW2o3a0bc69vKA
Date: Mon, 23 Nov 2026 02:06:06 +0000
Message-ID: <8292beeabdf604a0c125c10d68b1c5a720c275d2.camel@wdc.com>
References: <20261113214854.40425-1-christianslima@proton.me>
In-Reply-To: <20261113214854.40425-1-christianslima@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SJ0PR04MB7485:EE_
x-ms-office365-filtering-correlation-id: 6f2a4e8f-9a68-4110-51a3-08df49065590
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|19092799006|10070799003|18002099003|22082099003|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261028144727099003|56012099006|10067099003|261102123227099003|38070700021|11063799006;
x-microsoft-antispam-message-info: rNcjJc7cJPItorBkx0IFcya2dZ2kRFMk6L/cfUFHlsuCT/fDwrdkqCYO07SRvavYwksP/+i9+OYxhRhbttqu7mYJfDbqtjnGQoEeV4wMHBLwlEdAd6AA5yVxFchnffNce6qocSFMWnFZxcxtrBcv7ijurVBlTPOElnl1Go90mMzyF3KkE/Y7w3QJ7EVncn7fdM3GcsGTFl1esC6RB/dBnFKpt5y4wbUp0RRr5LhF8HLH7iHMw26AbCkXMvPfSYtFT+pPbWwc6Bpv6kVjbSrmHN1lyaq/VxXWzo9MV49Pv1j0LmLwyzhedygOQYOL4yj8ZVJPea8oNHFOzB+CCNdMQDOErlmM/pX8cPHCHVyuAs40dtA84bXdy2tE89b5nb3xLG3/fbk3xdgPaNsuhNEIVWYo7xvGSIfhHkWdPWBuKDwv8ZFJYsbOyZguVeEUfdmxZzxfiu+EyidrkYal7Hk7gDaOhlt+Dm+kh+48vJYFpibzZ/967c7X/ggb8R+5r0qOQc6CMV8iTIt1AS6AKysrI9QAc12ftD0yozOg6XMoUz7kNeMtBqQJ8/1fWPPy2uCW6OajJOVOFT/EEOUAI+rEnZSx3mZIR/owvJwCnheC9vnxWEA5WYb3GTxwaETvqX2hm4dJVDJrJ+pbVmYkr5S8H4ttWsgYi2CrqOwv+dPbJTItlBQM8qllgW+jRErF045opdRF8Q5WzSzNM6oaeOtmFgdaQOyOFj8SBife5jLIAvY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(10070799003)(18002099003)(22082099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261028144727099003)(56012099006)(10067099003)(261102123227099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUpEeUtnUlQyZ2ZmUWZJOWwveGJ3ODJKcFQ5a3RKQy9KOEVObXFvL0liRlp0?=
 =?utf-8?B?aW5tZmN5ZmV5OCtxSHFiVXdiYkhuRzg1UHk4eXNGSlIvTU8xa0NwbDVzWldO?=
 =?utf-8?B?eGk4enIwOGk3WHRyZjdkT2pqZkFlS09lcjVQK3RPNDRrREhjVmI1UDhYR1VO?=
 =?utf-8?B?azdKQW1vaFYwNVZWaU9ackdrVnFJVEx0N0pIdEc2LzhnVVA4WWpCUWFBU0or?=
 =?utf-8?B?LzhuTk9sSmxqMFd3Ym1DejFSZ3hiYjQ4Tzh6ZlpPYUdCN04wWjBaSzY5U2NO?=
 =?utf-8?B?NHRxZlFRZGtRWUMyOXgwd0tPR0dGZkcrUlVCSW1RKzIrbzRZYzVsRlhrYXdi?=
 =?utf-8?B?bG5oNnB0QXFaVXQ2czR4YW9zM1ltSUxzdHlQTjRWaVR3N0RTNm16SW1XNVg0?=
 =?utf-8?B?VVFtMlQ2Rmd3bFowUS9wblptQTBLSTBaZUdRRkRZOFlhV1k3Z1dBc0ZGSzZq?=
 =?utf-8?B?ZmphUFN1YW5ZUzJES2xQNEkwSnE4NGE1WjdyMHhRTjlYOU9QbFFYM3dUc0JB?=
 =?utf-8?B?T3ROWVhTeWFxT1Q4aUZhdGMyVGs0ME4vYmRCTFlCbW1LWW5BUWZyUGMxK1RT?=
 =?utf-8?B?aXV6WWpSOGt2SXoxL0l1OTBPZW45NzFBZXNUbnF4UFA0dlNBWTNKb3hPTE1v?=
 =?utf-8?B?TE1zN3luYjEwKzJWSjU2SWdpcDVLTllqRUlFWnlKTHJPYWNDQVBtRU95UTJW?=
 =?utf-8?B?d01mTGdTRDNlSkVzR0IyOFJyUEZLMkcycTBJZWNIaWNhUC9zWVpsNWN1bkl5?=
 =?utf-8?B?TjhldG9DcGVtMjU1Yzg1VXZ1djJxRW1DSG9GQVdOVEpCWUx0dFBxbnExWnh0?=
 =?utf-8?B?QUtnUCtVNDVlRmtCYy90N0dRajhkU3V1dXZUYUE2b2c0MTdQaFJ0Q2NpcHY4?=
 =?utf-8?B?cnRvbk1WaHRiOFdqYjR5YUlFemRSS1A4L2ZXbVQyejE4U3d1N0JGY3c5azMz?=
 =?utf-8?B?S2pldXIwcUJjeGh3VzREOTlpeDhnYThmUmxHZnl2QWtldlVzRm1SRWtUVU1R?=
 =?utf-8?B?eCtWd0RHcHJ1bEVCMkR0YzFocDNSQWhoVlB6Zno0d3BsT092UWczQjVlZHUx?=
 =?utf-8?B?ZUJOelY3dGh0Wkh2K3BLMVJ2YXpRZVZ6NDRHM1NTMm1pQVJZek9Wei80WE1U?=
 =?utf-8?B?YU9EQm9mVm8wc0xlb0RQOGppQWszbnZ2cVFkcWk0dk9WYzdrcStUMVc4aVNG?=
 =?utf-8?B?Q0YrRlBSV3JHN2pkMFFJZDdrMDNiTDVaTXQrcjFFcTFLSmJGMW5VQWM1UUt1?=
 =?utf-8?B?TURGNkw3MFRrYmZCM3lGaDFQTUl4L01DNWFRc1kvTW9jMWZQQXkvZDVFd29q?=
 =?utf-8?B?L2dwQ1VtVnVMU1ZjZDlOZ29KV255S2dkTEJGRWRTcllwaDBWSVM0WDNwR2ZD?=
 =?utf-8?B?MUJQVk5Ib0M3eXYzNnE2MzhGQ1F5c0o1TkNiRzNuekRXT0JZWjJ1djNxcVBh?=
 =?utf-8?B?bUhHbkpSdEh4MmZZVXVEdFIwbjVSbzY1eno1U2Y0MEJVY3FBRkJVQnVTVlhX?=
 =?utf-8?B?emdieXZZSlkzblNvSVNzdkIwWHBCNXZVdFhDSkJHbmNEZWZlaUpVSkZoMUFa?=
 =?utf-8?B?RGswcHdIQnl1bFdudWlGZzZUNjJldFE2c3ZFU0ZDeDBLeVh2RWNUUW4xMTh4?=
 =?utf-8?B?ZFVzdGFYY2Q0YXdkRXJ4U3dlbGlSWUNiQzJLQTA1Q3kzditmcXo5ZXJJcTNp?=
 =?utf-8?B?ZXdWRjJJTmd6LzdHL3dPaVZKRFJzRTRvY01tWEpRbm55S0QzUHlYYjAweHls?=
 =?utf-8?B?d1ZWU1JGY3NSeHRsSnk4NDNYUzViWnVEeWpvRkJFR2w2M25ZVWluSnJyU3JK?=
 =?utf-8?B?WVpRalBlTFhTekd6aUowL1NiTXhibE9ZeE14Qkl0RlpHa0pwT054M1cvek1j?=
 =?utf-8?B?bEtFMm1iK3dWdVUwMHVVb0dVMWIrNUEralZBdmlCaGljQUdQMlVTbHBpc0tz?=
 =?utf-8?B?NVJESWczejBHaFJiejVDSzVXOXppWEpWYnREaG55aUFkdmNkMk9BMCs0eCtp?=
 =?utf-8?B?RnJIU2tNZVhPb0ZtQW1pNmE0UEdLZy9wb3NRbnhQUjZXc1RkVlNjeE1aZFZz?=
 =?utf-8?B?REJoV1JpUFl6dHBNUy9tQzFaT1Q1V3VCZXFpLzRnN0w5U1E0aytuNUQzSU1x?=
 =?utf-8?B?NUVpUFgwVUdIaGw5Z1lldkhUNkl2MzJiSmRRcno0TlRoTTVnWkErc29kQldk?=
 =?utf-8?B?Y013Y2MzamJvQTdiWjNlN25RRDdVY29BMkZkV1lPK2NYODhQaDMyRngxam5W?=
 =?utf-8?B?UFdyL2pGSXB4UGdlRkorVFpwRmZrTVcvZXh3VkJDODdwTUk0cHhCVWY1b1ln?=
 =?utf-8?B?SUl2NW9CMWxURjFRZVlCSWJRclVhQmdCTEl4czRGckJWL1hlOEFXdFZsTVR1?=
 =?utf-8?Q?H6LOz3rOXZ8ou3Z4Bfj22kLkHcwNKSivlu80I6kvps7OJ?=
x-ms-exchange-antispam-messagedata-1: WInJ8+yz6it9MKOzAzSKXx3Qu7/SflE+nA0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B5396415726E247981409CC4CC6DFCF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KhIsSsTawyDcx3zb6s9mDacLJNWdiwBD91QuQVhEM2fIjLxHkUoZcVSWUtYK9P1gsQDGTJ23DFsbcqP8rLwJh9gcB2kHYs91xVIcuFV1RdWsyLmtDawDKsnOfhyKVlb1DusxvSyrk7km0InJE+u8plyaddRW4aCL1cbJNmeLDrWh6tggy9hC4av9BNgReYs801WqGKwWXnporLtoY9YKMVb1z5TbJN/CyYATBS9mQajf2nqaGbCtJbDVhKFlhAfBzNfcf91dsNJt8tpcT6E8FsyrUrAwkNtzz/+n5jE+x3HDChC5fD3meHkDXDyi36HMMAPOyeXNu+8HPPrGVQALbA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kbsd1DX/SnHOCt0EfwidWNLMtiyd3dPP5zoyeDiL/Nd98qe4F6Fz0nGVrCQUzT+pu4Vwu5VbgBDI7oyRYHHJSPHkZGgTK5m4+IJ+JLm8NYWU1LHumQj5hIuyOntlnws0QWsvDHAnQaJqrnl4w/aZGLA02pVk0+AbttCMWULzMzuTB2FpgCxZNyFTBOyA9toKkuH9h5Je3Bar7h+0qwZhyZ/2RGFAnDC4J63oJC6l05J/G5zldtQ4ltPBPACGnX6bBRUCj+hDdltL6jXMS5WCFx9EJ8UU6U/K5s7X5xOieNMsVMBwxDIia2n/af8HLJlHBmp44ep4poQ3z32OH0pu+jnj/lXsaPiNDMdnWE+i0MBl4mtML6YvPLR65jfU4kd1AZV2LAGxTui6IKvBzRnVeGg9Ue8LHR2ynIfgWn5P2AEc+YJJAnl1SvU6VpCqLWx78ofqvMr4ZZMc/bOBycJEDcLT/xFBz/P3bwfee0rkeDda3n6RlO/fdZCyOPEasHKKWrP5g5945g65u6+qHzDG1MPsYxYW+z8ZR4IB59vRXWuSq9NaIae7li3Wvvb+2NpExy3qX++WNcaMYMs5yRBryKln9svcv78UXI6mfDfnfYCOotsMFYbwDBs1XOWCYRme
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2a4e8f-9a68-4110-51a3-08df49065590
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 02:06:06.3770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NX23v4gSN9kiIGJ6jL400sczAdMhP3HAI/8hwIVM/TASFXD2TCT1jwjhHtgcOWTGzu7gT8akaUTZh0S5/YBjM1bOHBbPST6ghNliIr9e1f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7485
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTExLTEzIGF0IDIxOjQ4ICswMDAwLCBDaHJpc3RpYW4gUy4gTGltYSB3cm90
ZToNCj4gSGksDQo+IA0KPiBUaGlzIHNlcmllcyBjaGFuZ2UgbXN0YXR1cyBiaXRzIGJhc2VkIGlm
IFMgbW9kZSBvciBVIG1vZGUgaXMgcHJlc2VudC4NCj4gDQo+IEluaXRpYWxseSwgSSBzZW50IHR3
byBzZXBhcmF0ZSBwYXRjaGVzLCBidXQgdG8gYXZvaWQgcHJvYmxlbXMgYnkNCj4gY2xvc2luZyB0
aGUgcmVmZXJlbmNlZCBpc3N1ZSBpbiBHaXRsYWIgYW5kIGJvdGggcGF0Y2hlcyBjaGFuZ2UgYQ0K
PiBzaW1pbGFyIGZpbGUsIHRoZXkncmUgYSBwYXRjaCBzZXJpZXMgbm93LiANCj4gDQo+IA0KPiBD
aHJpc3RpYW4gUy4gTGltYSAoMik6DQo+IMKgIHRhcmdldC9yaXNjdjogY2hhbmdlIG1zdGF0dXMg
Yml0cyBmb3IgcmVhZC1vbmx5IGlmIFMgb3IgVQ0KPiB1bnN1cHBvcnRlZA0KPiDCoCB0YXJnZXQv
cmlzY3Y6IG1ha2UgbXN0YXR1cy5TUEVMUCByZWFkLW9ubHkgd2hlbiBTLW1vZGUgaXMgbm90DQo+
IHByZXNlbnQNCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQNCg0K
QWxpc3RhaXINCg0KPiANCj4gwqB0YXJnZXQvcmlzY3YvY3B1LmPCoMKgwqDCoCB8IDEyICsrKysr
KysrKystLQ0KPiDCoHRhcmdldC9yaXNjdi90Y2cvY3NyLmMgfCAyMiArKysrKysrKysrKysrKysr
LS0tLS0tDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQ0K

