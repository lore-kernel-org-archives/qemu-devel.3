Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C405CEA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlt-0001TS-5c; Tue, 10 Feb 2026 04:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlp-0001JG-8P; Tue, 10 Feb 2026 04:10:57 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlm-0004kR-Ep; Tue, 10 Feb 2026 04:10:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKbLdjWbWxRMKD1c4MpR17iblJAS5rl74O+3NRZDVKW4rRsW9DVX54Qfe7wFAhuDlHN0ehXzdxNNkNJt7qMxh+wdiv5hoDzGTuuf0ETQ9SOWhYo1GPe+993pAt5bUovvO1z7MfRkT2HD9jXC63FVHLSpfCGd7hoCks1d5LOIVZkcNAiIwovCwdHG+BzoB4HX3KWnU/koDABXY7V16LM6mfibefFFfaAgilGAtwKyxQDyTFMOEpObgruHz9XB7+heK5+fMnGAQ/PODN5d/Z6siLEfdt5pP0rCUTB1vHonW0VoF1ohJ+CC1NXHlSfAcKR2UgDtGOs+JCMF5IpZPwZ0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8T4CbWyBuPs18YbU2Li2vnvCWPChLJuktsjf2Wjv/s=;
 b=dNbSs0pE6+U3KPMcin2HsBHbE+y6kpbFtlUXVAIZLuwYKMGPoK7PwggijzIOQRkpLSF1MqCnCRZV6+trazjP/9pE3tGwlZmtaN6dbF3Q6qKsjgfxcCTUiFCpbmpleRfi3VLdY6ZovBZGyn4LJmLOtBrtt2KrKIXFdiOrw2JP7yxJz0dd3bOihLRGzTHHh4273W822Bm0smfDwpDosXDsUdrsghg9Da5oz5Mtp8WCBKmWDN5OL92WHJn3KIrunIh5vkLNi/9HVwJ3ZpjAnxn6VmG+cgpb1gdlYAaJHumJp40kgMZrt7+DH2hBpvvHPhKeSqoPJm4aktQgxzdQ04PpgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8T4CbWyBuPs18YbU2Li2vnvCWPChLJuktsjf2Wjv/s=;
 b=Qdg2CY7tHhGw4koLrDfRRjeNqtalmnuoOZxpBn/ncjx+qViu1UmlPwj8QOz1IMe96/bJURYBHHkyaoSay9rPiYtKOPvYys9f3UA03kIXiqw03vWsX1XVDodRSFfUuFsfzCmrX6TcZeunnP9Cdg5P17duUbtutroJeIufZ6ra0lPkyrgXUx2+/3UlvR+CxbC/1MIGxO8DolrMHQsvLRoLErW+DCr55kQAndsmI/XkDsieYxhLaiY5/ydJYkmKDJ5J3UqUQjrVCZhPqiIcnR2xv6kaWIVag5C1SIphRqQPQCK4WuRrKlGAVelZbuV7eO0QEMJTYqboY0trjmh5Kqo/3Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>, Hao Wu <wuhaotsh@google.com>
Subject: [PATCH v5 12/21] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Thread-Topic: [PATCH v5 12/21] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Thread-Index: AQHcmm0eCuC0tZVS9E+dtfi3Dh3drA==
Date: Tue, 10 Feb 2026 09:10:36 +0000
Message-ID: <20260210091018.1553489-13-jamin_lin@aspeedtech.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8268:EE_
x-ms-office365-filtering-correlation-id: 58ad769b-fdfc-4896-124d-08de688440fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8C5jwcX1ycgiSb/8Yo/7IVNbafoRvxLiyaXt/xSZZtPoSmipIPWHDe7FDU?=
 =?iso-8859-1?Q?05OVpYsK//o29FAy2naBq71p9IQbnNvrsj8xKBtqVbkm+Mfnqm6b7IytBt?=
 =?iso-8859-1?Q?qu4R2iTmfoFYaQYPVYS9AHmzFu/kRhOIMJfDeZc6uHc0DqWlc1y4gPpJiU?=
 =?iso-8859-1?Q?apsKSdGrgEUYNVx94hzcG4t0HUwCt/cQ//rm4p54bcRsOXpiJbtdSFf9H2?=
 =?iso-8859-1?Q?hESO5Va96x+6WcYm9SEivgy8QhmpQOnp8HBTna89A3UB8ZZYiw53oIwq9i?=
 =?iso-8859-1?Q?af542AWwrCoF2lgG3Yg6ArWMMxNZmtnJXR2p5ovpOQ4RWetAD2RHudEG7c?=
 =?iso-8859-1?Q?wUTk7QqW6rRDThEy1hw7kn9pCbjm9theL5+L9V0aylVIo3f534jH0j9Lg0?=
 =?iso-8859-1?Q?efolWQpZhjoRHtpRvRNFTX9hkSxn2+Ee3WxZzqMYdq/cvRA6q0wgnIrJ/X?=
 =?iso-8859-1?Q?fP1Vw3XRxncIARWFH169gtC9+oON0oL6RoSKEyxQD75tXArjc1sRQPEg7p?=
 =?iso-8859-1?Q?PIYb+FvprqlvpSAPKjFDR/XkHRE2DBBDRXByzRoVLzexE0iCJ45R17/MmI?=
 =?iso-8859-1?Q?x91YOFbEYicQorm7sqDyU81roNrflawib/AlojGu+aB9pHtUtRJuHiZLOJ?=
 =?iso-8859-1?Q?GNd38Zg3AYnJHASb/iRcWwQGOfM/IBU4ozezyAOVKSnqxdN03LhFNBq466?=
 =?iso-8859-1?Q?BfNnZfHgdi/DsIxzNWDACNy/SP1TDVkIYeNhpUdQtwxHHYDaigVZcnu4mG?=
 =?iso-8859-1?Q?56W05JIbhvTNlPoBlyQ/mvBd8YMkiHC+USjROo69t+m+UaFcrFSexFTvu8?=
 =?iso-8859-1?Q?csMaiPQ6glyKKzB5Itqk/ikWeko0Yh6+DsGTsi0D/qEMO/SQ/ODhatepNb?=
 =?iso-8859-1?Q?knBy6495BTLgEvXGHG6zadvikk7tl5QjOxhbqGf31ZnkrnfQawICG9EErs?=
 =?iso-8859-1?Q?esq+8BP2y6eFcyRC8Mj8aEWYzF2bM55J9IPlrqHhg1K4mYUuNtOOxOLyCD?=
 =?iso-8859-1?Q?dpyQmybJ4uFZcFLuDVH1lZaMlTyvpb1d9nfXKLipOAglhi2l1Orh03CnPR?=
 =?iso-8859-1?Q?m/VWm+anGR/fvTDzz2VK0hJag908IVLxjyv6mvphPK7jHwzJIb0FbI9uEL?=
 =?iso-8859-1?Q?/JBWZtg88e/xM3DbDMZ5bl8jW5YVWwnMyKhyZ2pfHf+uWcRPt0kqRC/dou?=
 =?iso-8859-1?Q?Lu+lGgh7U2ReQWNGJpmJXYrHWK9b4OP+IO87dv4nnMpqLooF3csoYyE9cX?=
 =?iso-8859-1?Q?GnQM4cLXK+K77OeJUmSJcxNQIftztNhGip4JJkiZqJu5hOnRM2vL9MdhkI?=
 =?iso-8859-1?Q?2bhn0t9CG4hT9fp58lazGhLboG/eSYEXIVOIDYRC6jPyXE3HWpdw7L09Z5?=
 =?iso-8859-1?Q?l+AgmoD0fO/WqqZlFQNJt/qw4q0KkoKgCzpjzeY6r4YeIqnp7e1aF/Vgn6?=
 =?iso-8859-1?Q?sUsFEQySLvEtju7WgYjMyCBx6TiWH5jQd6p4I1FXg8EF9e2G4TRrk/tEzB?=
 =?iso-8859-1?Q?Lk1wdsTI50GKTcyIpPYHPMxbDuQu9ohgsbMNjQvvi2XRu2OTwqBE+/vIAO?=
 =?iso-8859-1?Q?TD8r/iHF4BJY1ov33LDVIgj1eISJpImgOletO5tejKBxLjNeXYzo70xGOm?=
 =?iso-8859-1?Q?zd61jAMUAJgE4v+1x71cmFDw8NAgVE5t4EqeqdOWJoKgJaOURC0cg8COON?=
 =?iso-8859-1?Q?Lc3CIny7s0JSUIr+R/pgfXQtrbFhqkE32TTlgfLd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qsxW7cYOm7FHc5YmgjRxU0aqMUZZtKX2DlDtcpctg+t6iIOe0uSiWbG/WJ?=
 =?iso-8859-1?Q?g6tWzltZ//sV+TSaDCa5BcQ7rHKd5ihvRI7BKi4YGmU3YLfk2pk7+jdb/R?=
 =?iso-8859-1?Q?tP2mx5BkMPc1Hb1RKm0qYa3Lu5vbNEvPcLf0qr/0iv4FaXI7j9juzpJQYF?=
 =?iso-8859-1?Q?k+q3UB4ZhBIgNPom4OkaRRoD8Y1sCUqrcUrGwyrGn1vZ3pMoTRTubAkBjk?=
 =?iso-8859-1?Q?rxPNlPRNoVKsRl+ACW0u9V++5k3hOxBK5NlqTHJDLKobm9vKNIVHhcxfi3?=
 =?iso-8859-1?Q?Y/DwS9bLp5vR4KFxCthFQEk32XWJa0nhQuKeJwdgMJq/ffbUMn6mK6YT2Z?=
 =?iso-8859-1?Q?0UlVa8dBzs+486HBWpRPVUbAuCyfkLT9VQYo5lQbX85oZWFDJFunS1lBOL?=
 =?iso-8859-1?Q?S2/1AAivI5XcQKywlRnK554w+mkgKnZHy7diO2eDhnm1Mu1k0aahmfbi8W?=
 =?iso-8859-1?Q?uMRyjApRGSJXjKJyMAJ80qsYnnaIkjp3KIEIAY6R4+cu1mNCOxT658uySu?=
 =?iso-8859-1?Q?qjy70hJe7XK+/4sb2yTMBsU1FrmF83pWrIXM6rFXwYlMJW6BImEV2NDeAq?=
 =?iso-8859-1?Q?47iFtF51vCbe8uCNtS3Lo5Pm5vxl+Iq/v3Kq5Pw13NjFe4Tguszww5aYQq?=
 =?iso-8859-1?Q?wabAJSqLOAqN9FOeprBs4+vWQoe0z1ClsGoNEJDLY4UA1Zjz0ld29eHJ9K?=
 =?iso-8859-1?Q?rdqBvsOawGU11dUlM6q80xXah/e9Cz1nlgirZEMsljV6UodxxQ8S1GYsJd?=
 =?iso-8859-1?Q?VauXhGk3Yz3AMrcluTyEQ37AkR4h+ZtssXOUQfBM3zuAluHu46mcxiiRbg?=
 =?iso-8859-1?Q?6XTlbyUxRarCSiOZu4/8ORu2H/jv6m/BRQe2sFPBCL4qGOjMy/ZJD301Rz?=
 =?iso-8859-1?Q?nWrc0XpVcbPGdK2Wsr4fjywf9gWX8f+TtI+6ICvOD951B7xA8WwBCno3xu?=
 =?iso-8859-1?Q?P2lkzKYm565Yx/SOwhG3YAymZoAEZNpORa8os5hLbkvMtiFkrH2YQhQqRX?=
 =?iso-8859-1?Q?lsU9jcjAUTzCwBTrcInmkPs0FRtC5GvR90jmTyxPfBWseLEopX1KpxNiqJ?=
 =?iso-8859-1?Q?o16oCFphIJcKnunNs+ZoHSqvcH2dOHlKkY0/8pboicvJGl3qxTJ2wWQhwU?=
 =?iso-8859-1?Q?rNCU2SseG3l+nVvi5jQJrsKdV5HEBaaOOVtbgjTHWIXWDV1/+eQJIwvuna?=
 =?iso-8859-1?Q?KKxP8ATPMUET+vQkNyPrpXFeRrdVw56rxjAipQZqdl8L8SFXHlSiMjorz5?=
 =?iso-8859-1?Q?wSYBNpJkQOMGZOrlyzwhudMIeWGrTNM1StdwLXdUNV6Qzq8emiEGOMiB+1?=
 =?iso-8859-1?Q?5gP6H0tZSJQPGdxJuCgiyZtTPg7G3RUjudv6bjTiazrTB1xUuc3iSGKRiL?=
 =?iso-8859-1?Q?EuJDNgymIHvoeDpE/t14VAN8jZjE6j75Zyjx9qmQaUspuUtXEnTYnalnTO?=
 =?iso-8859-1?Q?9Lrxm091xkxkvO/2/5rSKetx96VjGDO/sOF3arQ0njTX4cQVCjnfmERwAg?=
 =?iso-8859-1?Q?tVa5dp7eu9vjpWRRAQZdx1Amm9CpkxzYml5Be5G9g9ml5SVIDppIxpi7dj?=
 =?iso-8859-1?Q?RekpPU5mqjgJoXz6Ecoc9LNgTDLYEcFlsMrFtL9sbB31v/qUoS6cawVJAq?=
 =?iso-8859-1?Q?JsukIfdxaoRSswoZSqyTUF77PzD/Ba8+Xvu39JQfJQgoaKq8yUDvCVsuTM?=
 =?iso-8859-1?Q?Syq+jS9rzlN/6fBdNL09hzcDWQsPOctza4Q28/PST3lCMB12caeDv7ZG4F?=
 =?iso-8859-1?Q?L+vrS+IlnkN9HYTKmtXcmi+UMU0DX5TNCBUrzl0mzxYYLmZFyeA7V5gkJW?=
 =?iso-8859-1?Q?A6z5HfGgCg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ad769b-fdfc-4896-124d-08de688440fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:36.8401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tyj/rlofUahwDi4Aq8ogQjDuNEN3w+rkuSaoFe2Vk7X8amSsNvgoPQbrzPxQ6M6kmiFe0lVGrdw1cmukPaLYM4tnhXzqpYx9vpaBYb+QCZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8268
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Hao Wu <wuhaotsh@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 56 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 7ca99fb87e..0b99c7edfb 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -17,6 +17,7 @@=0A=
 #include "qapi/error.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "trace.h"=0A=
+#include "hw/core/irq.h"=0A=
 =0A=
 REG32(DEVICE_CTRL,                  0x00)=0A=
     FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)=0A=
@@ -335,6 +336,46 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=
=0A=
     [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
 };=0A=
 =0A=
+static void dw_i3c_update_irq(DWI3C *s)=0A=
+{=0A=
+    bool level =3D !!(s->regs[R_INTR_SIGNAL_EN] & s->regs[R_INTR_STATUS]);=
=0A=
+    qemu_set_irq(s->irq, level);=0A=
+}=0A=
+=0A=
+static uint32_t dw_i3c_intr_status_r(DWI3C *s)=0A=
+{=0A=
+    /* Only return the status whose corresponding EN bits are set. */=0A=
+    return s->regs[R_INTR_STATUS] & s->regs[R_INTR_STATUS_EN];=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_status_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /* INTR_STATUS[13:5] is w1c, other bits are RO. */=0A=
+    val &=3D 0x3fe0;=0A=
+    s->regs[R_INTR_STATUS] &=3D ~val;=0A=
+=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_status_en_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    s->regs[R_INTR_STATUS_EN] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_signal_en_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    s->regs[R_INTR_SIGNAL_EN] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_force_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /* INTR_FORCE is WO, just set the corresponding INTR_STATUS bits. */=
=0A=
+    s->regs[R_INTR_STATUS] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
@@ -348,6 +389,9 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset=
, unsigned size)=0A=
     case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
+    case R_INTR_STATUS:=0A=
+        value =3D dw_i3c_intr_status_r(s);=0A=
+        break;=0A=
     default:=0A=
         value =3D s->regs[addr];=0A=
         break;=0A=
@@ -392,6 +436,18 @@ static void dw_i3c_write(void *opaque, hwaddr offset, =
uint64_t value,=0A=
         break;=0A=
     case R_RESET_CTRL:=0A=
         break;=0A=
+    case R_INTR_STATUS:=0A=
+        dw_i3c_intr_status_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_STATUS_EN:=0A=
+        dw_i3c_intr_status_en_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_SIGNAL_EN:=0A=
+        dw_i3c_intr_signal_en_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_FORCE:=0A=
+        dw_i3c_intr_force_w(s, val32);=0A=
+        break;=0A=
     default:=0A=
         s->regs[addr] =3D val32;=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

