Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24366606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bull.com header.i=@bull.com header.a=rsa-sha256 header.s=mail header.b=fwuFPhDt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJPwk-0005y0-Kj; Wed, 21 Oct 2026 02:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xJPwi-0005xV-4P
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:37:08 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xJPwf-0004vS-0W
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1792564625; x=1824100625;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=uINc3aZp4ot6FuBNFwrNB7srKLSj4qAaBnIGf+6aloo=;
 b=fwuFPhDtCxQhUOYfLVY8gWdRecxj9Knhm29sAoFBeh6cutd4Mfxcw8vc
 lR7S+lhegCy/nlr3TDeuuH5DgYkezPXnz+cvajsK256e9q6gf7HNVSzn4
 LA1Ydf3xyfUKrjf+yJWMrlKjDtnrgnk9S1oMRRMdL7jwWzaxuoNBtqrYA
 giugt8YlB+Gpk2kdF/H6H8OqiBHhn7L0Guh4CGmpiBx5Hpue4DuqgBsC9
 IdYVENu4KF+1GwoIIfM5Cq+gbd5a9OFNUkLIQ87d2+7J0DnlgX6u6zkbr
 ZIzKV9FE9WnPDTuEqRy0AE5h+D2tckJbDlUNstzH7HFUyRQR8HwKcLcAO Q==;
X-CSE-ConnectionGUID: B51aCMt8TJu/v4VwYuZZLg==
X-CSE-MsgGUID: XLt5+sYHR16JGi+tK+dhOg==
IronPort-SDR: 6ad85d8a_SdGg/u3PVPZ9huCYnqy6Zget7c6wDvULKi3wUJIoshvN34C
 meSCo22QjG2UQ6/SmcezCEszHdjO0JhZQ56eSOA==
X-IronPort-AV: E=Sophos;i="6.27,169,1787004000"; d="scan'208";a="51098298"
X-MGA-submission: =?us-ascii?q?MDHaylWu1r21qYA8oQ5yIVlcl/WYK/GrOVLW7R?=
 =?us-ascii?q?QDzbn2j+bNgDdG93IWWb/TOHTXVCPfiegQC3S9C60f+WASr7qsG2nRUt?=
 =?us-ascii?q?DOAQrmKDL8sjFPKV2QTuQW/LL6a6nflCMADhNH1OgfzI/bxpPWhi6mrg?=
 =?us-ascii?q?Ukiv2MWAFPtIMtYuGE/JzEYw=3D=3D?=
Received: from mail-northeuropeazon11010014.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.14])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Oct 2026 08:36:58 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7prs9HxFooN77otcgAZJR6MeQ+m5/26cWQqnGHcfczfykRRvlWWpJZBqzHgayZQSAzTUFEHTE39IRQK+INHSXxkasRoww7qpGY65tRgbKicbnESkosqxUhuvpAjMw5HyyPqXd9lGIpfbAoubJXIAx3YvU9AbubnN1/Vk/ohOpDwIDGHVtxPRkpf6bn6Hs7XLmByYNEoVIuV3CO1NiUQCK3vw4KwVGeOCALX8/c/YVl0lP66riBrnf5lK2otAoWpp87Upo0W6qtW7uMWsKFDZ8CHKdp+PjCw2tCw+PkgbVMQIF2RZPMovU3Oi9j3httqXc5V31W3wpYjQqzwLV9E5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uINc3aZp4ot6FuBNFwrNB7srKLSj4qAaBnIGf+6aloo=;
 b=Q5SJjgaP/BTKu57PtJ3YSh4Qtl700fKfx+seLMB6dUa8hmbymp/kGKRWjfPaqJj2IsyF+am48P2pnLvaSAf9Rh/G+y54rOyVw35ersybtpk0ARd0fAC6bL3GVqx1zmZT1wn8sSqXpgCYZJ20au1V5jVgoQJP64wL7/txz03nJz9QMu4FbZPQa10h/ygU9dmSQct459in5zA09dcCTAG35LK+JGNe322vCBi/kb+i7O2SV4ARgQ/WhGCGwZrVNFqISTSf8HKtkZ7oK3j99+HYJpDCx/sZfqDfYeJY7bTTCxzsgkTivfPjWfZUutTKq3k6Bg6z5uJkH+QeUfXXuwzk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7205.eurprd07.prod.outlook.com (2603:10a6:20b:254::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:36:55 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 06:36:55 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v9 6/6] intel_iommu_accel: Teardown FAULTQ resources in
 bottom half
Thread-Topic: [PATCH v9 6/6] intel_iommu_accel: Teardown FAULTQ resources in
 bottom half
Thread-Index: AQHdYHRFzHaVPwrKQkeo1gWYbW4mqbcHjDiA
Date: Wed, 21 Oct 2026 06:36:55 +0000
Message-ID: <3a2e7492862b46efa34986e9fcccf6fd2dc65496.camel@bull.com>
References: <20261020091955.1607161-1-zhenzhong.duan@intel.com>
 <20261020091955.1607161-7-zhenzhong.duan@intel.com>
In-Reply-To: <20261020091955.1607161-7-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7205:EE_
x-ms-office365-filtering-correlation-id: 36be2f45-abbc-4a8c-3b0f-08df2f3db342
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|4143699003|38070700021|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: NrmSE5Rfik7gEjW+WmADc3DJ1bAoMltZ2zePMhwfC3yH6wGWPndvmdX2n4dWoMjQBMLJ0g73Du6FxiL7ZDvccyN93uU8Zum6GNOk8mqUn7J5P5nFP1BqABylQKZ0TN5G6jQW7bPk41c1t2+mx+bXz6g+d8ih2N/W5MDGzMs98tMJLYhe8a5yk9nuTHdNoMqDIbD0hqSgcl3J2WQLvJ0PTLGev0VtxakF9wwS/ZfZ89j1krXT5758pI8DWwd/Usl2SXuoaDzYzvsn7tUe3icvx43ZxF+DEzNpCd2h4xxY/HQiQetSiWpN8VrH1fYMgHF6PlCy7zY0IoZSaM1a8XKqHZKih/oqOUYr/D2w+T3uqrl1b6ITss8EB7zM/L+UF+E22QNHUNLRB9Tb1GzFwtiKHO8N1byd/EeHm44OuIunZlTYpfyJ1yJqaEz9pXzhK4ZbUreWP4riv/rDH7YNbVMy/HhmUQ+pltlCMf8/jQ9ouVyPsDg+Iqx3SAB9lm6m5h/Gb/xpNtdXCRLPTIQZeSzyJ51zWSsIFfmauIXHJ5DL/YbsNPhmB7m2Tdg5A8RE3vXLiVzJnov074he6D1bTXVKTCTne4KzTXXUcoPX9aS4B0u4gvKKOk5Qxy4aW8vKfEL/wlIyzXkx1GeADWU48Q/RnEZ5F9ZpBC9IrYv4RGVlIV8r8soOCxODPQweSYYZlM0jymVguZWqllJeLifKVxmK5cf7aU0C3re338CwZDT/PcY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(4143699003)(38070700021)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ei9KcVlDSHhKVFQrT0lDTWRqZE8xeHFzYllWWVNEU3JpeU5vVllXaWcxR2dx?=
 =?utf-8?B?UDJhbjUvbzZhRkJTVWF6aEZTcGpYRXp1U2lPVlBqNlc1d25WOHZncWlqS05E?=
 =?utf-8?B?Y0trYW4wSUEwM053OFZiQTJYRFF5U1ZyYTFrTDRQbnMxL3E0bER5TDBYMTRT?=
 =?utf-8?B?bmFuSlJPejlwWWpmTkpyU3gvbHdlZTE0V3FPZDErb0F0RTIrTFY3aW01cWtI?=
 =?utf-8?B?eFdCVTdiZFRnYng0cjRrOEhGU29uM2RoTG9WbHk4MHpnVjFyMDhQYWFrUUxh?=
 =?utf-8?B?VTVQc0pxeXNiUTNWQUFTZXkyYUxGTHZQRTBHaStRckJLQmxJRkdqYVRpVUx4?=
 =?utf-8?B?Q3FjcGQ0bE5Ma3pIVFQyK1c4VDhQNmJ4TmloUStHdFBKMHg5VDFXMFBGaUYx?=
 =?utf-8?B?SGtMazdHS21FaTM5T29lb2JWK0JESUtqVHdycmM1aVlIdWs1WHA5MTVjeitt?=
 =?utf-8?B?L21icG9odnBBcEpXNTg2QTVva29aS21NM3IvS0Vyc1I5OHBqb3Btc2ZrVEQx?=
 =?utf-8?B?aHAwMDZZYjdpRmFlMU45Q3ZsWnF5ci9ydk5jemN2NUtHOG55cHV2YktaZ2Uv?=
 =?utf-8?B?WlZ6UmdGWDkwaDFINEViakVRbU1welVzdGF1VlRqOWR6VUhpTEZvYi9WYk5k?=
 =?utf-8?B?TXM1VjFqR09hQnk4TWV1a2VGckVKTnByVXdxRElMaUU3b1F3VTAvMDROdERB?=
 =?utf-8?B?TGd2K0JKUnlPb0MyVlIzZlJmK0luTW1wS1ZZak1YS0N5L0JmdzdTaEx1Q0JM?=
 =?utf-8?B?N3ZHZnNIR281ZXVTWENOMWpPL1ZVVEVxclhkbUxVWlJjZmxPdm0vd0ZBd25N?=
 =?utf-8?B?bVFuR1hDNU4zSWVrZjdLczZpQUgxK293ckgrUW1tTGlKemVuSElMOFZTN2NW?=
 =?utf-8?B?TEN6TklOU0R2aWZOMVZQMDdvSncrM3d2VTIzbzB5Y3Z4Wmp3Z2QrUXdUbnBG?=
 =?utf-8?B?MkNUYlp3Z2RBWTNseFpHT1FTdHVvbGlTNUxmTlJPMTRxS2JWT2FHeEVpT0FU?=
 =?utf-8?B?UTFuSEZieW90UjNWWEI1YncwUVZHckdSNk1senltbHF3TnNYeTdrdG9rRE91?=
 =?utf-8?B?a0ttOUIvemZUWlNzQ0pISTZsNEJwYU53RXYvUlJsTXNaTmRoOEpaaEdzQ1Zu?=
 =?utf-8?B?YXhVbzlzS3NQZ3dLSytFcWc4QmtvWExnSkFJblhTRnhkV2lJaWtJTGFxTTkv?=
 =?utf-8?B?V1htSG41bVFzeldHRkV6VXRFcWFYTWd0UXNUWkUxbVZCaDByNGJzSXBlWld2?=
 =?utf-8?B?SlNmTGkyTzl0VDdmU1hTMjJVWXovVzd1b29qVDRVTDUzbFp3VFo5UERsOWxo?=
 =?utf-8?B?U2x1cXRFQzZMOGw2cnZBUlFzclUvQk50ZHlRLzhoSXJOOXRmdEFGUGZ3akZY?=
 =?utf-8?B?QUVKTVlaaUpvRWI1bHczaW0yMHZlYkVnVzhxUUNNa2RTMFFVWHhBUEV1TFN3?=
 =?utf-8?B?QmdyYnVzQWNmekpCYU10ZW0rc2pHaHdqellGdGorRmMzNEJmSW5XdjlBV2d4?=
 =?utf-8?B?OWZXUmVFU3czWTh2SVljSFExUlRrYStHQk1udURBTkEyNGtpZTE5ME5DUTBI?=
 =?utf-8?B?ek5UVjdmaEZydlF1LzBqaGg1d3ptRWZtc1FYeVNpUzNlcEdMaUtHbW0yOWR0?=
 =?utf-8?B?QlEwT1lDOVBGUTJRTXY5Sm1lYVdEd2hYZXd5N1pPeFVWS0h6YWhiSTFYbnVV?=
 =?utf-8?B?VUlVVnNMQ0RVV0UySDc4R1kremIwdFBpbVREWEw3WXZod0dTTVQvWXZUUHB1?=
 =?utf-8?B?MnFUbERhdmN3TG5ZMzRTcFNhemxWR1VaWUJ0NGRjQk9iWWJHdUQzVDNVajVK?=
 =?utf-8?B?NHBSUDg2M3NZait0Q0phVTY2UmtRbktudUxOdGt5OEVPMmx3MFk2OVVCTTNs?=
 =?utf-8?B?YTZYRk15bDJWOVBaZStGZjV2bFJkV1BYY1pJMUM2K2t4dkxucTl4c0hZNGl6?=
 =?utf-8?B?VHVuZVhCNitrd0srOFZzNnF3dFQwa2RGczFzSzBkR3dxTjBuV0Z3b0NHMWlQ?=
 =?utf-8?B?d1cwQ3F4VSt6S1kyZHNNdld6bGZkZ3BkUEE1L1VRd3hBa2JUOUlxb1hHaENt?=
 =?utf-8?B?emVRSXRjbXAxaUdGbWMrZzBMamxaait2TkI2aWJtREVIK1UvMmxIbUdXK2ha?=
 =?utf-8?B?Q2IvL3ovaDRxZHdwTk1rZUZpT3JxYjVCeFA1Q1Y4NEFxc0xCc24rL1pNQm9U?=
 =?utf-8?B?VWZ1eDdDakZpTUkvb2paS2huVHhKNGlaOEdhaXFaSTVGVFpxdFNPbkl5UGFx?=
 =?utf-8?B?RVBiQnNFQjFmNmZ0L2FjRWtHMlNxWk1lN2RuOVJVOWhpUHNjamRDQlEydmlZ?=
 =?utf-8?B?Q0JhL1cyd1Zqc3VhaWFaNWNWM3M0ZWIwTXk4aTJkYTdWNWNCVHEwYkFiUEVp?=
 =?utf-8?Q?cYhBFcwnMUyr66JI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FA14F593EA4834E99248517F6003E39@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cF8hpCdfl9RYZqvWJIwkvGoQCN7aBtcGfq/qjeULQiGCT+E/NdhHYDBwV7dMBTa8YuZLvauzi9KFW8fnGDIHyMcP/O7KZA/PXSGTMvU/i9rmGAPSCEiSi4+xHYCW75HKK0hLNgsQk/DfELv8XDZ47275YKb+1vJQCqZ6xj+xrSoaPm5H+de+pYOQLGPrTgJxB771wnj9heU8qv7vJhHlUOoxD8FAU8QwiCyYHfqyZ+FiyQy/tgfaSGdFrtPgxTt/Y+EEv5Mg3pLiJeJEK2pfHJmvcfxPjfFZ991WimJddlO5LPw7WXDlG+p7SF4x/8oivZaNb7eThseDDBd9wik9mQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36be2f45-abbc-4a8c-3b0f-08df2f3db342
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 06:36:55.6360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yrP7xSOhJwIHhpP+um9gCs9QYDdx6gg5fQxfV3QAxai3/tkrKF4UdDupxSWPwauw1XZ44ydAwBT7jzFwVfxuN/ESiDUw8pS3Wj/ittpQX6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7205
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UmV2aWV3ZWQtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGJ1bGwuY29tPg0KDQpMZXQncyB3YWl0IGZvciBZaSdzIHJldmlldy4gIA0KVGhhbmtzIGZvciB5
b3VyIGVmZm9ydHMsIFpoZW56aG9uZyENCg0KY21kDQoNCk9uIFR1ZSwgMjAyNi0xMC0yMCBhdCAx
NzoxOSArMDgwMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVt
YWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMg
ZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZS4NCj4gDQo+IA0KPiBXaGVuIGEgUEFTSUQgZW50cnkgYmVjb21lcyBpbnZhbGlkLCBh
bGwgcmVzb3VyY2VzIGFsbG9jYXRlZCBmb3IgdGhhdCBlbnRyeSwgIA0KPiBpbmNsdWRpbmcgdGhl
IEZBVUxUUSBvYmplY3QgYW5kIGZhdWx0X2ZkLCBtdXN0IGJlIHJlbGVhc2VkLg0KPiANCj4gQ2Fs
bGluZyBxZW11X3NldF9mZF9oYW5kbGVyKCkgZGV0YWNoZXMgdGhlIGZhdWx0X2ZkIEkvTyByZWFk
IGhhbmRsZXIgYW5kICANCj4gd2FrZXMgdXAgdGhlIG1haW4gbG9vcCB0aHJlYWQgZnJvbSBwb2xs
KCkuIEhvd2V2ZXIsIGEgcmFjZSB3aW5kb3cgZXhpc3RzICANCj4gd2hlcmUgaW9tbXVmZF9iYWNr
ZW5kX2ZyZWVfaWQoZmF1bHRfaWQpIGNhbiBiZSBpbnZva2VkIGJlZm9yZSBwb2xsKCkgZXhpdHMg
IA0KPiBhbmQgcmVsZWFzZXMgaXRzIHJlZmVyZW5jZSB0byB0aGUgZmF1bHRfZmQgZmlsZS4gSW4g
dGhpcyBzY2VuYXJpbywgZnJlZWluZyAgDQo+IHRoZSBGQVVMVFEgb2JqZWN0IHJldHVybnMgLUVC
VVNZIGJlY2F1c2UgdGhlIG9wZW5lZCBmYXVsdF9mZCBmaWxlIHN0aWxsICANCj4gaG9sZHMgYW4g
YWN0aXZlIHJlZmVyZW5jZSB0byB0aGUgRkFVTFRRIG9iamVjdC4NCj4gDQo+IERlZmVyIEZBVUxU
USByZXNvdXJjZSB0ZWFyZG93biB0byBhIGJvdHRvbSBoYWxmLiBUaGlzIGVuc3VyZXMgcG9sbCgp
IGhhcyAgDQo+IGZ1bGx5IGV4aXRlZCBhbmQgZHJvcHBlZCB0aGUgZmlsZSByZWZlcmVuY2UgYmVm
b3JlIHRoZSBmYXVsdF9mZCBpcyBjbG9zZWQgIA0KPiBhbmQgdGhlIEZBVUxUUSBvYmplY3QgSUQg
aXMgZnJlZWQuIEFkZGl0aW9uYWxseSwga2VlcCB0aGUgSU9NTVVGRCBiYWNrZW5kICANCj4gRkQg
b3BlbiB2aWEgaW9tbXVmZF9iYWNrZW5kX2Nvbm5lY3QoKSBhY3Jvc3MgdGhlIGFzeW5jaHJvbm91
cyBib3R0b20gaGFsZiAgDQo+IGV4ZWN1dGlvbiB0byBlbnN1cmUgRkFVTFRRIG9iamVjdCBmcmVl
ZCBzdWNjZXNzZnVsbHkuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFNoYW1lZXIgS29sb3RodW0gPFtz
a29sb3RodW10aG9AbnZpZGlhLmNvbV0obWFpbHRvOnNrb2xvdGh1bXRob0BudmlkaWEuY29tKT4g
IA0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8W3poZW56aG9uZy5kdWFuQGludGVs
LmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVsLmNvbSk+ICANCj4gUmV2aWV3ZWQtYnk6
IFlpIExpdSA8W3lpLmwubGl1QGludGVsLmNvbV0obWFpbHRvOnlpLmwubGl1QGludGVsLmNvbSk+
ICANCj4gVGVzdGVkLWJ5OiBYdWRvbmcgSGFvIDxbeHVkb25nLmhhb0BpbnRlbC5jb21dKG1haWx0
bzp4dWRvbmcuaGFvQGludGVsLmNvbSk+ICANCj4gLS0tICANCj4gwqBody9pMzg2L2ludGVsX2lv
bW11X2FjY2VsLmMgfCA1OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tICAN
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgYi9ody9pMzg2L2lu
dGVsX2lvbW11X2FjY2VsLmMgIA0KPiBpbmRleCAyNDM1MDFmMTM3Li43ZGI4MzE5YWQ0IDEwMDY0
NCAgDQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyAgDQo+ICsrKyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXVfYWNjZWwuYyAgDQo+IEBAIC0yNzEsMTcgKzI3MSw3MCBAQCBmcmVlX2Zh
dWx0cTogIA0KPiDCoMKgwqDCoCByZXR1cm4gZmFsc2U7ICANCj4gwqB9DQo+IA0KPiArdHlwZWRl
ZiBzdHJ1Y3QgSU9NTVVGYXVsdFF1ZXVlIHsgIA0KPiArwqDCoMKgIElPTU1VRkRCYWNrZW5kICpp
b21tdWZkOyAgDQo+ICvCoMKgwqAgdWludDMyX3QgaWQ7ICANCj4gK8KgwqDCoCBpbnQgZmQ7ICAN
Cj4gK8KgwqDCoCBRTElTVF9IRUFEKCwgVlREUFJRRW50cnkpIHZ0ZF9wcnFfbGlzdDsgIA0KPiAr
fSBJT01NVUZhdWx0UXVldWU7ICANCj4gKyAgDQo+ICtzdGF0aWMgdm9pZCBmYXVsdHFfdGVhcmRv
d25fYmgodm9pZCAqb3BhcXVlKSAgDQo+ICt7ICANCj4gK8KgwqDCoCBJT01NVUZhdWx0UXVldWUg
KmZxID0gb3BhcXVlOyAgDQo+ICvCoMKgwqAgVlREUFJRRW50cnkgKnBycWUsICpuZXh0OyAgDQo+
ICsgIA0KPiArwqDCoMKgIFFMSVNUX0ZPUkVBQ0hfU0FGRShwcnFlLCAmZnEtPnZ0ZF9wcnFfbGlz
dCwgbmV4dCwgbmV4dCkgeyAgDQo+ICvCoMKgwqDCoMKgwqDCoCBRTElTVF9SRU1PVkUocHJxZSwg
bmV4dCk7ICANCj4gK8KgwqDCoMKgwqDCoMKgIGdfZnJlZShwcnFlKTsgIA0KPiArwqDCoMKgIH0g
IA0KPiArICANCj4gK8KgwqDCoCBxZW11X3NldF9mZF9oYW5kbGVyKGZxLT5mZCwgTlVMTCwgTlVM
TCwgTlVMTCk7ICANCj4gK8KgwqDCoCBjbG9zZShmcS0+ZmQpOyAgDQo+ICvCoMKgwqAgaW9tbXVm
ZF9iYWNrZW5kX2ZyZWVfaWQoZnEtPmlvbW11ZmQsIGZxLT5pZCk7ICANCj4gK8KgwqDCoCBpb21t
dWZkX2JhY2tlbmRfZGlzY29ubmVjdChmcS0+aW9tbXVmZCk7ICANCj4gKyAgDQo+ICvCoMKgwqAg
Z19mcmVlKGZxKTsgIA0KPiArfSAgDQo+ICsgIA0KPiDCoHN0YXRpYyB2b2lkIHZ0ZF9kZXN0cm95
X29sZF9mc19mYXVsdHEoVlREQWNjZWxQQVNJRENhY2hlRW50cnkgKnZ0ZF9wY2UpICANCj4gwqB7
ICANCj4gK8KgwqDCoCBIb3N0SU9NTVVEZXZpY2VJT01NVUZEICppZGV2ID0gIA0KPiArwqDCoMKg
wqDCoMKgwqAgSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRCh2dGRfcGNlLT52dGRfaGlvZC0+aGlv
ZCk7ICANCj4gK8KgwqDCoCBJT01NVUZhdWx0UXVldWUgKmZxOyAgDQo+ICsgIA0KPiDCoMKgwqDC
oCBpZiAodnRkX3BjZS0+ZmF1bHRfZmQgPCAwKSB7ICANCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm47ICANCj4gwqDCoMKgwqAgfQ0KPiANCj4gLcKgwqDCoCBxZW11X3NldF9mZF9oYW5kbGVyKHZ0
ZF9wY2UtPmZhdWx0X2ZkLCBOVUxMLCBOVUxMLCBOVUxMKTsgIA0KPiAtwqDCoMKgIHZ0ZF9kZXN0
cm95X2ZzX2ZhdWx0cSh2dGRfcGNlLT52dGRfaGlvZCwgdnRkX3BjZS0+ZmF1bHRfaWQsICANCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZ0ZF9w
Y2UtPmZhdWx0X2ZkKTsgIA0KPiArwqDCoMKgIGZxID0gZ19tYWxsb2Moc2l6ZW9mKCpmcSkpOyAg
DQo+ICvCoMKgwqAgZnEtPmlvbW11ZmQgPSBpZGV2LT5pb21tdWZkOyAgDQo+ICvCoMKgwqAgZnEt
PmZkID0gdnRkX3BjZS0+ZmF1bHRfZmQ7ICANCj4gK8KgwqDCoCBmcS0+aWQgPSB2dGRfcGNlLT5m
YXVsdF9pZDsgIA0KPiDCoMKgwqDCoCB2dGRfcGNlLT5mYXVsdF9pZCA9IDA7ICANCj4gwqDCoMKg
wqAgdnRkX3BjZS0+ZmF1bHRfZmQgPSAtMTsgIA0KPiArwqDCoMKgIGZxLT52dGRfcHJxX2xpc3Qu
bGhfZmlyc3QgPSB2dGRfcGNlLT52dGRfcHJxX2xpc3QubGhfZmlyc3Q7ICANCj4gK8KgwqDCoCBR
TElTVF9JTklUKCZ2dGRfcGNlLT52dGRfcHJxX2xpc3QpOyAgDQo+ICsgIA0KPiArwqDCoMKgIC8q
ICANCj4gK8KgwqDCoMKgICogRHVyaW5nIGEgVkZJTyBkZXZpY2UgaG90LXVucGx1ZywgaWYgdGhp
cyBpcyB0aGUgbGFzdCBkZXZpY2UgY29ubmVjdGVkICANCj4gK8KgwqDCoMKgICogdG8gdGhlIElP
TU1VRkRCYWNrZW5kLCB0aGUgYmFja2VuZCB1c2VyIGNvdW50IChpb21tdWZkLT51c2Vycykgd2ls
bCAgDQo+ICvCoMKgwqDCoCAqIGRyb3AgdG8gemVybywgdHJpZ2dlcmluZyBpb21tdWZkX2JhY2tl
bmRfZGlzY29ubmVjdCgpIHdoaWNoIGNsb3NlcyAgDQo+ICvCoMKgwqDCoCAqIHRoZSBiYWNrZW5k
J3Mgb3BlbmVkIGNvbnRhaW5lciBGRC4gIA0KPiArwqDCoMKgwqAgKiAgDQo+ICvCoMKgwqDCoCAq
IFNpbmNlIHRoZSB0ZWFyZG93biBvZiB0aGlzIGZhdWx0IHF1ZXVlIChmYXVsdHFfdGVhcmRvd25f
YmgpIGlzICANCj4gK8KgwqDCoMKgICogc2NoZWR1bGVkIGFzeW5jaHJvbm91c2x5IGFzIGEgYm90
dG9tIGhhbGYsIHdlIG11c3QgdGVtcG9yYXJpbHkgIA0KPiArwqDCoMKgwqAgKiBpbmNyZW1lbnQg
dGhlIGNvbm5lY3Rpb24gdXNlciBjb3VudCBvZiB0aGUgaW9tbXVmZCBiYWNrZW5kIGhlcmUuICAN
Cj4gK8KgwqDCoMKgICogVGhpcyBndWFyYW50ZWVzIHRoZSBiYWNrZW5kIGNvbm5lY3Rpb24gcmVt
YWlucyBvcGVuIGFuZCBpdHMgb3BlbmVkICANCj4gK8KgwqDCoMKgICogRkQgcmVtYWlucyBhY3Rp
dmUgdW50aWwgdGhlIGFzeW5jIEJIIGNvbXBsZXRlcy4gIA0KPiArwqDCoMKgwqAgKiAgDQo+ICvC
oMKgwqDCoCAqIEluY3JlbWVudGluZyB0aGUgdXNlciBjb3VudCBpcyBndWFyYW50ZWVkIHRvIHN1
Y2NlZWQgaGVyZSBiZWNhdXNlIHRoZSAgDQo+ICvCoMKgwqDCoCAqIFZGSU8gZGV2aWNlIGlzIHN0
aWxsIHJlZ2lzdGVyZWQgYXMgYW4gYWN0aXZlIHVzZXIgb2YgdGhlIGJhY2tlbmQgYXQgIA0KPiAr
wqDCoMKgwqAgKiB0aGlzIHBvaW50IGluIHRoZSB0ZWFyZG93biBzZXF1ZW5jZS4gIA0KPiArwqDC
oMKgwqAgKi8gIA0KPiArwqDCoMKgIGlvbW11ZmRfYmFja2VuZF9jb25uZWN0KGZxLT5pb21tdWZk
LCAmZXJyb3JfYWJvcnQpOyAgDQo+ICsgIA0KPiArwqDCoMKgIGFpb19iaF9zY2hlZHVsZV9vbmVz
aG90KGlvaGFuZGxlcl9nZXRfYWlvX2NvbnRleHQoKSwgIA0KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhdWx0cV90ZWFyZG93bl9iaCwg
ZnEpOyAgDQo+IMKgfQ0KPiANCj4gwqBzdGF0aWMgdm9pZCB2dGRfc2V0dXBfZnNfZmF1bHRxKFZU
REFjY2VsUEFTSURDYWNoZUVudHJ5ICp2dGRfcGNlLCAgDQo+IC0tICANCj4gMi41Mi4wDQo+IA==

