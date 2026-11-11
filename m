Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314D2606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=FsA++OZ8;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=Dr4q1KgD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR04Z-0006bl-W2; Tue, 10 Nov 2026 23:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR04W-0006bZ-6B; Tue, 10 Nov 2026 23:36:32 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR04U-0002SJ-4M; Tue, 10 Nov 2026 23:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794371790; x=1825907790;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=jxL3ZVbo5j1nSbonIN3P6U49j+IhW7J18UaAaTiMVbg=;
 b=FsA++OZ8RJiyQPTxCurP1Ph+0D3uNXLIZPvNSjMoJbISbLmE8zqIWZpw
 EIBaMNs4mXTbMfFXGhOgcDGqaY2KNjHlYJvLk8v8bmdOPUQ2wbs5ys+VB
 hzc0c4vvLttluthqNP8n1PPZ6WT+JFgib8mwtBsKj2P0udrCrdNq4PwXQ
 wzfh41oCdlam/Ppib/ukQolpRwV0dVCepHZrRiO7u0F3kRXSe/8wrWmUj
 Neb61jRNBYIT63fuiIeLVDVLMK0lanKNYcJhA8WZYs94Wfg2edH8u/LpQ
 kBYoPyI8We1Y0yCSMEj8VWY50qEqC5sLS4p9jPzu2pgGz7JFYj+ehgqC9 A==;
X-CSE-ConnectionGUID: 9C3v7yB1SXKEj3s7JkrttQ==
X-CSE-MsgGUID: sQAew37EQTWyxyCcKyPKqA==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="161575864"
Received: from mail-westus2azon11010048.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.48])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 12:36:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jjt+UDRFWigk2kyNKXcWYwhsJoRgbEeJR2eXXj7UYMoWZ5ZbwCf+HF/Qc+IJhCn5BaWu1PYF52UXbygXBd8BUoE1fPGPrXQtZe5ykoJhFNkEkSFQHBlRYaW6BB0qOH3XncLrHqvMp8JaCV53kfnohjlZiqmJnIWNTSyw99e3dlBi4wT3LnFjjB+1tp6s7Aa4SQyimk7/T2MmFos4Mj2dDZjvgtvG6kju5mquwBjq/glpTLoKZboptydd4dfGsESfPsRqwjxs7B+6kkNWHlnLXtv2VAqFIVoPxq9ie6emQnAujp0a1EGW+h9BZEoTLODlyXiU1vJ2pf1SJH5U6XNtdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxL3ZVbo5j1nSbonIN3P6U49j+IhW7J18UaAaTiMVbg=;
 b=MN1tmhM1g9mYeaNA2Mrj+j2tnaoMO8Dpq6xxzWdUhHjaqFDEEcOCOXjNbgM17bpKZaLnbKIpR2k9hHBj6Ztlm24kpMe8njEKLzlwF0wtqTP+OOBbnhJ4xaN+LKBpDubUmoCNGRnIQvyMX7A4AmL1/KKf0qtYfgTE3D7M1vioMXiqp2bgeakTNF1UuJyR8aOIGeVFJ50houhiZoNt9gd98CBN7MTgpw5oeVWwXdbS7DPM6BdCWM80OUOw+oqgnap5ZIhJ1LUcwWiGr8ZFH2D6W7fzzeSRRUqHpvFsNY/t+TJOVqpLgLZ4AiGkbO7ObdlfunJBAiXViGlZQeeYcSYAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxL3ZVbo5j1nSbonIN3P6U49j+IhW7J18UaAaTiMVbg=;
 b=Dr4q1KgD1WBIdiJqB743/x0Bqzu66fpxEdn8of3tM6iQ+Ff5/wv7X9xArRSnDBeEGmzoLUm6uce+PGTxArjv/VWNmRwBkuIPrnpEq/NfJYVr+z63c7fEMkwyPJgqImpK7VGRh6ugudDNVQoSjczEyOl3cpiW9d9EK36f8xH3Ffs=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by CH2PR04MB6776.namprd04.prod.outlook.com (2603:10b6:610:93::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 11 Nov
 2026 04:36:17 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 04:36:17 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "ralf@vmexit.de" <ralf@vmexit.de>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "ralf.ramsauer@oth-regensburg.de"
 <ralf.ramsauer@oth-regensburg.de>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>, 
 "lukas.landgraf@st.oth-regensburg.de" <lukas.landgraf@st.oth-regensburg.de>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH v3 2/4] hw/riscv/virt: only describe PLIC contexts that
 exist
Thread-Topic: [PATCH v3 2/4] hw/riscv/virt: only describe PLIC contexts that
 exist
Thread-Index: AQHdYmMQWF8qK27EFUewF7OQc/za3bcoZ5mA
Date: Wed, 11 Nov 2026 04:36:17 +0000
Message-ID: <c4b796f8569b99aa577be265b8e63f447589cd63.camel@wdc.com>
References: <cover.1792700406.git.ralf@vmexit.de>
 <299b4ab6843fb4655355b449359eb38f717af445.1792700406.git.ralf@vmexit.de>
In-Reply-To: <299b4ab6843fb4655355b449359eb38f717af445.1792700406.git.ralf@vmexit.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|CH2PR04MB6776:EE_
x-ms-office365-filtering-correlation-id: 68d383b0-b8f0-4a08-b4c0-08df3fad5372
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|19092799006|23010399003|366016|7416014|10070799003|6133799003|22082099003|18002099003|10067099003|38070700021|261102123227099003|56012099006|261009223027099003|261022075727099003|261021123027099003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021121427099003|4143699003;
x-microsoft-antispam-message-info: CgpvqHLTb/osBGmdFZnzZaw6vSlc47dqhq/6TnU23SJXtVLmTKMJZ/4MEBBg1UY2IN++x331j01rxD1lkg6vORM3XDUbALDhLtQa1apQS29htkkcUPVQs4HssmmZ7pzHw0sgtm6laIJXpbVorKzGzqtMIkMhXRqKVWUFPlWkLA+RcGsSWfQEbXvfdkeBcfA4GmchFG0oeBJtQPZKebPLbBllwlwYWyJ1LC9xC1cf4FvAnWnB01YsXhERgZ92btP4kHbKmYnUbGgJugSFRa4+YL1vjDbYNn7DLylgDF6FuXY2ebkdz6Yb8Vg5/vizYseQXya8ZYPg7TBlw/g4tyld3CwofjxJ1ArCVRuWtr4sU5jIwozvOPeyUtzoQfMST7Faw23YH4IyGKbmWmke/F4Dv4L68hbgzg5qp2Xrl5NA4GPiE5FUrVDgcqjGh6eqH7Ge9B8F434NJPgPT13ZE1+C9R0ca3095oM3i/YHYo7aGopAIdGT+cpuzHX0VYf+Dgc9to57ykE2+roE0iMDlNhd1B9iQNc9Astql01S+TLyzWORQJoQAGnmKj4kdbfiK+EBl4HlolFrU3iTH3iXuMKEU+aThW8+BEvxpGD2yNGQ2R+wshHP0C1RJRvWDh7ZwaQ/VGYYnM2dwwOY8L3AHPw9X93oxmKr3MajZcH/bNfu6AzhCzK9J6l/fqim/BeQT9rFT6WXkvGNak9r9RdT0yhi1w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(19092799006)(23010399003)(366016)(7416014)(10070799003)(6133799003)(22082099003)(18002099003)(10067099003)(38070700021)(261102123227099003)(56012099006)(261009223027099003)(261022075727099003)(261021123027099003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXhYM3NQT3duRk0vdEJpTmtVRDdKL1lnMzBxTkFWRFRYZENLS1dSQng3bi9D?=
 =?utf-8?B?RWEzRlpNRFFGTFQ3YSs5TXY5b09lNFQvNkhFMGRsSVFCUHI5SnBDdzEvSTUx?=
 =?utf-8?B?V1AwNzIrWnZUMktwY0FCNkdHRzVVd2ZMbjk2ajZaRXd4SDhwTGF2akk4MWd2?=
 =?utf-8?B?ZFVDUXFSa2FXZlpaMXhTTTJzUEpXMHJHNHYzcDdGNHY0NU96MHJML2pZK0tD?=
 =?utf-8?B?dTlnMDI5cWlIa1hvQkVBL0RKVUJ1Y0UycjBmWG5uZDlySEthRmRPR2xFSXNp?=
 =?utf-8?B?SzBjRmVyUnIvZm8xbm9Wc1pYS1VJVnNpMHllbEkwTmFxN0pVZGpJOE84ajgr?=
 =?utf-8?B?QWZxT1cvbkxhWWF5ZXFybXdnazUzMWQ2NnQ2MktLbU1XUzFIUTB4Tk1seU13?=
 =?utf-8?B?OXdsZ2VzdE82YjB5KytBMXo2aEVBSG5WTnpIOTRveWlKK0lmaUkxNXpqV09r?=
 =?utf-8?B?azJrSjVvUkUycXcxOG1oMloySTNQYmFndFI5Y3FyNURBaEs3Q245MW9yRE82?=
 =?utf-8?B?UmRpNVdBSHhVQ1FxLzg4RHE2ZFpEQjVNdlUyZnI2WXFZWnlLMGczSVRESW5P?=
 =?utf-8?B?WWQzaWtnb2VBaFJOa2xvR3FBMGJDSm5qSndjMUE1ckIxM1MwWTlzYkQyeExC?=
 =?utf-8?B?RVRLenNFN01aYU1kbUwwYW9uc2FOUXh4NDFwUkVVY3laUU5oY2dNbWRmNE5k?=
 =?utf-8?B?dU9IZWphNHBGTG5PL3VuRFFUb1ZFVm1PcWxEYWxYVzlOR3hSOFJzS1NoVzU3?=
 =?utf-8?B?alBhMHp4Q1lBZ0g0bFRXMDVQbXgrc2Y3QlNEUnhJT1NXeEtPQ05TWkxuVG5v?=
 =?utf-8?B?N2xkQ3k4N0s4alZNQnRoY3dITE52cVJ6RFNNQTlzbnFXUjhaTVRuYUJoUThz?=
 =?utf-8?B?dnNnMTM5Q3ZqMDYwZCtDWVFxMkhKTFRidEgxSE91TlpFdFo5ZUFNSTVDblE4?=
 =?utf-8?B?b1U3anlKZzRTRGJqbG1JY21wa2V1dWgvMFlRUHdOT0RvZkFXWitKNDlXN3hj?=
 =?utf-8?B?cEovZTZlYllkRzFOZnFtVnZ6R0FsREczRXZQY1g0T09xZ0NWSXN6d2FMdXdJ?=
 =?utf-8?B?cTR0Zm5wN1VmaTJVVHJuMERMRjlnQkZCNzd4OGtSWnlUdWZ1OHVDemNDdFRO?=
 =?utf-8?B?bUZnSWFwL1Z4Y0xmZ3lRZmpwa2ExaVhWbmVTSkY3SHYwMEFOVzBidFNEUXk3?=
 =?utf-8?B?eEJoYmhVVVBMNVRmVVZ5SDcyRFZIdDlRekdPT2VwVWtLSjNqekNSZy9PMEpM?=
 =?utf-8?B?enRoTVVmRzdWM2MyTWtWNHVnT1lWNnhXOGVpbVIzbW5UaG1YaERVK29RU3BR?=
 =?utf-8?B?eU1FSlA3TWRueTVlb01uNWJESTVvRTJtYnpnNzFBSTlwR3VnOTFNVExYeDU5?=
 =?utf-8?B?ZVlCZjF4U1BWSUZ3L0xMVGllUzNLNWtJeGtIVUlrTmRJUVdlYU51ZTFDRmxW?=
 =?utf-8?B?SHFuRTNrd0plenJ1bU1CS2dIR211R1RIT1FOdHBYYjB1TzJzYjlUTnk1ZFF6?=
 =?utf-8?B?dExsMXRKdVNSeWVyWHZISjRyNlJ3bkZFditQS2piZSt4ZnZ6OWx3ZkthTzV0?=
 =?utf-8?B?YjJJY3JvcCtRN1E0NkFPakVXTnI1RTl6aFNTRGJDQWYxWmE4RkEwR2hPY3ZF?=
 =?utf-8?B?TkhlZG1IdU9vUnYybUZoUHZrZmo5S2UrODZKcGV4c20veTU3SmVya0FUaGtF?=
 =?utf-8?B?SHNQanp6UzJDVEVNbnNTUDJLdnRidDEva1NEaEhNR3pTSE9YaTV4WmllQ1RP?=
 =?utf-8?B?Um1WYm0zV29CcEMwSS9PUW8yMlZPVVhCZ2ZZalVISUptdDhsa2hPWVN1R2RV?=
 =?utf-8?B?Z0JMUDA0U0ZNcWIrUHBvOVEranloZk12U21Tend3SUVvTDNUYk5iOFprOWRo?=
 =?utf-8?B?TEFJdWJ3YURrNzVlak5URllaMmJuOGE3SXFNbStodnRJZlVuYUVJSWNWSjNk?=
 =?utf-8?B?QjdldmJGYzMyY1I2Z3ovOGVOL1MyZU05QkJRdS9aMVlYbkFzMEtKdHlrL2tU?=
 =?utf-8?B?VGlxZmx0Nnd4aTBFdStOeU15cEUvQTFGUlV6azRmMjNITHUrdEgwVDNmcWhC?=
 =?utf-8?B?dHJyb1RObVpLbmZmMVlyVGozaWR0UHZqK2VDYzFtZ2EwdkNJWkFLZ090Y2Zn?=
 =?utf-8?B?YjRqek9SeTg5dTZPU25YK3NpaFRPRTBIM091SUtQdmFjUXUyeDUwWjMxc3g0?=
 =?utf-8?B?cjcrV3dVa2NYQ1lCZHZXQXJ5RDdtMnNBejh1RVVTNm93bm1uZHhLMkJCcXlZ?=
 =?utf-8?B?b1FCRWlOdjlRK1h6bVdEbkd4c2tkbXBmZDNqci9id3IrRE55V1pOV3ZUWWJG?=
 =?utf-8?B?cXI3Q3Q2YWRNeE03M01lVU1qeExFandrYk0yWUttT2tnNWhFbW84QTFjdXdt?=
 =?utf-8?Q?YltgW6Y5fmmT7/Uy+IgzgBjeRlAVmVjz2NwEP840psYLB?=
x-ms-exchange-antispam-messagedata-1: oMbICou7YmJmpk3VRk/j5hx4Y41qWkRTC74=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8653AA8B6BE17449E79B42D4F503D59@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: on4qyi/29tBJclIQY+gyOGvmisBmAhNNlS3RNS8qzUzXE8lGHVEonx/4qpoe+4NbNY2ITxtjXv91TN0SRvP9JTxVCXRzUgbmVgk8WmhtIKAldkUjStBbEkGc0OtVl1J+WXPDWtn6xkPrivdRBIAwIIDKgzUBtN2GF2BoUe8DhHXXK1hH+DCJBHSKVE4XCc95dPpkSgRQjVbgVcoddKKXfRxZLebvb9d1I+0jOMniJ+HXfj7Ua+S626pGuKVP2SVpPNoRw+NSejybv4xjkOpuQnaojhKg2LEBEXxHlKxXV/lwAEPAqlSviyan0OCCAjFjf0ulha5f1KZKQ+nAXqVu2g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3Xn5Pn45PHjXAuRicmZwYDbErPfCv5KkX1+MiCqI0BLu9Zpazdrco8zg4C2kefnOZu/tiFWMWHkpG4HfKvXalk+FtY4pGWRwNo/VM21B+0RmqU/Ri9J9KFrQmVz9SHtwwOvW3J2zj9r1HPNI6vdegTZQrfH5hDayyawGJJIuOfudfqE+IdQCk9mu5QM/weemMYypsPAcuHRMasxdW5370pC2lhjyCmuvU2CrCM/yKxQ36jmp7qt3FDV3Zh6ou68oRSnzDOYwzXfFunXzE+76I1jT4GxWHperHmno2q6HRuAs9jufvnjdiytZ/XbGiXhT+mONd0iLZqAEZefXsAYNW6wn7B/O9vGTcz0nbFMYNNM7B8Vg0/S8t19E6g71TU3CzQBJ0HaUluW0nCyW5n0H6fGgFzMb0Q8mMshzdY7C5awaINxPpt67TPf9JMP6wNXmwYDyWBdPHxqS9aq6YAMwCRpefSJzJx08BG1RvA23KRWvV1mkToMY+w5gxCUgJoK8m7mr0cx0a+3piEpKYkM+Fdqb3VBgh+UzNIeOumexyB8T4hkudUFIyKd01hAegXTaL2KaeXAA0/yDjrzpFJHLY59zZWWjoNK7nkGIFhFjXUIvAOkWvJRzQaVmW2W6G7lu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d383b0-b8f0-4a08-b4c0-08df3fad5372
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 04:36:17.0987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4BnG5/AcshMPZMjf/7+OhJKflJa/dbeH+kD1XvwagFf0cnnlY/mrV4/02r5C9EdgmmWY36BNEdW8uc3GD8tlLj/6wgyaMtSEdarpz70Ikg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6776
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
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

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDIyOjIyICswMjAwLCBSYWxmIFJhbXNhdWVyIHdyb3RlOg0K
PiBGcm9tOiBSYWxmIFJhbXNhdWVyIDxyYWxmLnJhbXNhdWVyQG90aC1yZWdlbnNidXJnLmRlPg0K
PiANCj4gVGhlIFBMSUMgZGV2aWNlIGlzIGNyZWF0ZWQgZnJvbSB0aGUgdG9wb2xvZ3kgc3RyaW5n
IGJ1aWx0IGJ5DQo+IHJpc2N2X3BsaWNfaGFydF9jb25maWdfc3RyaW5nKCksIHdoaWNoIGdpdmVz
IGEgaGFydCBhIHN1cGVydmlzb3INCj4gY29udGV4dA0KPiBvbmx5IGlmIHRoYXQgaGFydCBhY3R1
YWxseSBoYXMgc3VwZXJ2aXNvciBtb2RlLsKgIFRoZSBkZXZpY2UgdHJlZSwgaW4NCj4gY29udHJh
c3QsIGxpc3RzIGEgbWFjaGluZSBhbmQgYSBzdXBlcnZpc29yIGNvbnRleHQgZm9yIGV2ZXJ5IGhh
cnQsDQo+IHVuY29uZGl0aW9uYWxseS4NCj4gDQo+IFRoZSB0d28gaGF2ZSBkaXNhZ3JlZWQgc2lu
Y2UgY29tbWl0IDdkMTBmZjhhNGQgKCJody9yaXNjdjogdmlydDogVXNlDQo+IHRoZQ0KPiBQTElD
IGNvbmZpZyBoZWxwZXIgZnVuY3Rpb24iKSB0YXVnaHQgdGhlIGRldmljZSBhYm91dCBoYXJ0cyB3
aXRob3V0DQo+IFMtbW9kZSBhbmQgbGVmdCB0aGUgZGV2aWNlIHRyZWUgYmVoaW5kLsKgIEJvb3Qg
d2l0aA0KPiANCj4gwqDCoMKgIC1jcHUgcnY2NCxzPWZhbHNlLHU9ZmFsc2UgLXNtcCA0DQo+IA0K
PiBhbmQgdGhlIFBMSUMgaW1wbGVtZW50cyBmb3VyIGNvbnRleHRzIHdoaWxlIHRoZSBkZXZpY2Ug
dHJlZQ0KPiBhZHZlcnRpc2VzDQo+IGVpZ2h0LsKgIENvbnRleHRzIGFyZSBudW1iZXJlZCBieSB0
aGVpciBwb3NpdGlvbiBpbiAnaW50ZXJydXB0cy0NCj4gZXh0ZW5kZWQnLA0KPiBzbyBhIGd1ZXN0
IHRoYXQgdGFrZXMgaXRzIGNvbnRleHQgbnVtYmVyIGZyb20gdGhlIHByb3BlcnR5IGdldHMgaXQN
Cj4gd3JvbmcNCj4gZm9yIGV2ZXJ5IGhhcnQgYnV0IHRoZSBmaXJzdDogaGFydCAxIGRyaXZlcyB0
aGUgY29udGV4dCBvZiBoYXJ0IDIsDQo+IGFuZA0KPiB0aGUgdXBwZXIgaGFydHMgYWRkcmVzcyBj
b250ZXh0cyB0aGUgUExJQyBuZXZlciBjcmVhdGVkLsKgIFRoaXMgaXMNCj4gd2hhdCBhbg0KPiBN
LW1vZGUga2VybmVsIG9uIHRoZSB2aXJ0IG1hY2hpbmUgcnVucyBpbnRvLg0KPiANCj4gRW1pdCB0
aGUgc3VwZXJ2aXNvciBlbnRyeSBvbmx5IGZvciB0aGUgaGFydHMgdGhhdCBoYXZlIHN1cGVydmlz
b3INCj4gbW9kZS4NCj4gVGhlIEtWTSBjYXNlIHRoZW4gYmVjb21lcyB0aGUgc2FtZSBydWxlLCBu
b3QgYSBzZXBhcmF0ZSBvbmU6IGl0cw0KPiBoYXJ0cw0KPiBoYXZlIG5vIE0tbW9kZSBhbmQgYWx3
YXlzIGhhdmUgc3VwZXJ2aXNvciBtb2RlLCBzbyB0aGUgY29tbW9uIGxvb3ANCj4gZGVzY3JpYmVz
IHRoZSBzaW5nbGUgc3VwZXJ2aXNvciBjb250ZXh0IHBlciBoYXJ0IHRoYXQgaXQgdXNlZCB0bw0K
PiBzcGVsbA0KPiBvdXQgb24gaXRzIG93bi4NCj4gDQo+IEZpeGVzOiA3ZDEwZmY4YTRkZTcgKCJo
dy9yaXNjdjogdmlydDogVXNlIHRoZSBQTElDIGNvbmZpZyBoZWxwZXINCj4gZnVuY3Rpb24iKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBSYWxmIFJhbXNhdWVyIDxyYWxmLnJhbXNhdWVyQG90aC1yZWdlbnNi
dXJnLmRlPg0KPiBSZXZpZXdlZC1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmll
bC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFu
Y2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKg
aHcvcmlzY3YvdmlydC5jIHwgMjggKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9ody9yaXNjdi92aXJ0LmMgYi9ody9yaXNjdi92aXJ0LmMNCj4gaW5kZXggZDRi
NTAxODAyZi4uYTI4NTFiNTA2ZCAxMDA2NDQNCj4gLS0tIGEvaHcvcmlzY3YvdmlydC5jDQo+ICsr
KyBiL2h3L3Jpc2N2L3ZpcnQuYw0KPiBAQCAtMTU2LDIzICsxNTYsMTkgQEAgc3RhdGljIHZvaWQN
Cj4gY3JlYXRlX2ZkdF9zb2NrZXRfcGxpYyhSSVNDVlZpcnRTdGF0ZSAqcywNCj4gwqANCj4gwqDC
oMKgwqAgcGxpY19uYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIvc29jL2ludGVycnVwdC1jb250cm9s
bGVyQCVseCIsDQo+IHBsaWNfYWRkcik7DQo+IMKgDQo+IC3CoMKgwqAgaWYgKGt2bV9lbmFibGVk
KCkpIHsNCj4gLcKgwqDCoMKgwqDCoMKgIGNlbGxzX2xlbmd0aCA9IHMtPnNvY1tzb2NrZXRdLm51
bV9oYXJ0cyAqIDI7DQo+IC3CoMKgwqDCoMKgwqDCoCBwbGljX2NlbGxzID0gZ19uZXcwKHVpbnQz
Ml90LCBjZWxsc19sZW5ndGgpOw0KPiAtDQo+IC3CoMKgwqDCoMKgwqDCoCBmb3IgKGNwdSA9IDA7
IGNwdSA8IHMtPnNvY1tzb2NrZXRdLm51bV9oYXJ0czsgY3B1KyspIHsNCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcGxpY19jZWxsc1tjcHUgKiAyICsgMF0gPQ0KPiBjcHVfdG9fYmUzMihpbnRj
X3BoYW5kbGVzW2NwdV0pOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwbGljX2NlbGxzW2Nw
dSAqIDIgKyAxXSA9IGNwdV90b19iZTMyKElSUV9TX0VYVCk7DQo+ICvCoMKgwqAgcGxpY19jZWxs
cyA9IGdfbmV3MCh1aW50MzJfdCwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcy0+c29jW3NvY2tldF0ubnVtX2hhcnRzICogKGt2bV9lbmFibGVkKCkg
Pw0KPiAyIDogNCkpOw0KPiArwqDCoMKgIGNlbGxzX2xlbmd0aCA9IDA7DQo+ICsNCj4gK8KgwqDC
oCBmb3IgKGNwdSA9IDA7IGNwdSA8IHMtPnNvY1tzb2NrZXRdLm51bV9oYXJ0czsgY3B1KyspIHsN
Cj4gK8KgwqDCoMKgwqDCoMKgIGlmICgha3ZtX2VuYWJsZWQoKSkgew0KPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwbGljX2NlbGxzW2NlbGxzX2xlbmd0aCsrXSA9DQo+IGNwdV90b19iZTMyKGlu
dGNfcGhhbmRsZXNbY3B1XSk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBsaWNfY2VsbHNb
Y2VsbHNfbGVuZ3RoKytdID0gY3B1X3RvX2JlMzIoSVJRX01fRVhUKTsNCj4gwqDCoMKgwqDCoMKg
wqDCoCB9DQo+IC3CoMKgIH0gZWxzZSB7DQo+IC3CoMKgwqDCoMKgwqDCoCBjZWxsc19sZW5ndGgg
PSBzLT5zb2Nbc29ja2V0XS5udW1faGFydHMgKiA0Ow0KPiAtwqDCoMKgwqDCoMKgwqAgcGxpY19j
ZWxscyA9IGdfbmV3MCh1aW50MzJfdCwgY2VsbHNfbGVuZ3RoKTsNCj4gLQ0KPiAtwqDCoMKgwqDC
oMKgwqAgZm9yIChjcHUgPSAwOyBjcHUgPCBzLT5zb2Nbc29ja2V0XS5udW1faGFydHM7IGNwdSsr
KSB7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBsaWNfY2VsbHNbY3B1ICogNCArIDBdID0N
Cj4gY3B1X3RvX2JlMzIoaW50Y19waGFuZGxlc1tjcHVdKTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcGxpY19jZWxsc1tjcHUgKiA0ICsgMV0gPSBjcHVfdG9fYmUzMihJUlFfTV9FWFQpOw0K
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwbGljX2NlbGxzW2NwdSAqIDQgKyAyXSA9DQo+IGNw
dV90b19iZTMyKGludGNfcGhhbmRsZXNbY3B1XSk7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHBsaWNfY2VsbHNbY3B1ICogNCArIDNdID0gY3B1X3RvX2JlMzIoSVJRX1NfRVhUKTsNCj4gKw0K
PiArwqDCoMKgwqDCoMKgwqAgaWYgKHJpc2N2X2NwdV9oYXNfc3VwZXJ2aXNvcl9tb2RlKCZzLQ0K
PiA+c29jW3NvY2tldF0uaGFydHNbY3B1XSkpIHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cGxpY19jZWxsc1tjZWxsc19sZW5ndGgrK10gPQ0KPiBjcHVfdG9fYmUzMihpbnRjX3BoYW5kbGVz
W2NwdV0pOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwbGljX2NlbGxzW2NlbGxzX2xlbmd0
aCsrXSA9IGNwdV90b19iZTMyKElSUV9TX0VYVCk7DQo+IMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiDC
oMKgwqDCoCB9DQo+IMKgDQo=

