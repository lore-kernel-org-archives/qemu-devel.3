Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69D606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=TU3p6doc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGD-0007Uu-Gy; Mon, 02 Nov 2026 04:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFH-0007KX-AJ; Mon, 02 Nov 2026 04:22:27 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFF-0000WQ-UU; Mon, 02 Nov 2026 04:22:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaXAf7byDsPUOmdZWdkdQj+RO7fWIEq874T3LNFm9YrqtOu63KzSJHTvKA1HOK6dLeh2bE5az9EcKPjmwm4/6LZzipFFVldqodVwJMdvzdMpi2sPsTD2NIGRRbgzNJKeAbKTEQvq7zAObRwR0/EBnupDw4fE9TFp3htQ4sufF5frufcMi9On9QGGRZSGX3PLM7syGFSOyCKOk6mtnoJY4Okhs4HPlE6Zr3As0te/Pts59bmgqoudeKnzZozrccTEs1JIzjZSCLHVf3VxdCnGDcLxrzbrqxy/I2ZuvHqAi4msVX737RwNgZ4C/iSefUYaQMNG22+3kneLYeA0zkX7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5O7c2hHvr9knQUvjgOqepxhL8k2phC9xq7QoLc+YJY=;
 b=W89o1F97X6g1wRjWuwBQzcRSEnGibYdpr21obQ5YDMpHE1WTyzoLYBJkf+/6rWJWD9ZOmT7uwhmfIChOlnSaPaMKZQ5S/nZG9wNg+oIqo64b/bdBwAXh1QryLplbqBE5U4xFg/IOj1N8UDrRIEdjFkHdzlpDMu4JFosqd9vXoqHujWVOoZZ7FlW9vCblNo+w2EBqjeLBrL0lc/P5GefNE1B88DffFbqvDUvyIv4I6T40iOSumQWYmJVHJXLGdwF0G2F8gwJQJxUmwtxCuv9HSxGIFu/a9WWp7LHfarYXjimVjnvBtUsIQzcUmuQoDhFZ4fZccQXZvQw2r1Q5qMxGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5O7c2hHvr9knQUvjgOqepxhL8k2phC9xq7QoLc+YJY=;
 b=TU3p6docx9luHhWsoLCYyleFlNX6C/nT3kYiYYGJvwArUCe4lJpc0LKMrR3Iw8MJN/Fd05tUnk6Mv7FUxpKSGFGDVoffNofpa9LZWDyx2RBF2aSP2/3ZTU0BTzsXI5gmODFhyCpVlFn9Jh3RmGUvP8B7PdZJJfo9fBxN5yKQ11OLqRKC1+BGZcihWUf1Z+C6RpAbzD5Hx423znplt+xMFDrCa9H21c091wjFDHqG9R+3NmvkWAlrCI96opofbmjPVx3NLNLzJUX8e4Akb3+CvbCoDF9qkL/wC40lvk987+3s3mHKJ02cGWBJgsfjQVT1Gf70lD/OuhT2h/9Hlt/Tmw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6832.apcprd06.prod.outlook.com (2603:1096:101:1b2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:17 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:17 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "clg@kaod.org" <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v8 10/18] docs/system/devices/usb: Note the automatic hub
 change
Thread-Topic: [PATCH v8 10/18] docs/system/devices/usb: Note the automatic hub
 change
Thread-Index: AQHdaqunzKBY01X8UU66zw8KbkYNag==
Date: Mon, 2 Nov 2026 09:22:17 +0000
Message-ID: <20261102092201.1729245-11-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6832:EE_
x-ms-office365-filtering-correlation-id: 8666b692-074e-4874-741d-08df38c2c9eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|921020|38070700021|261021123027099003|56012099006|261009223027099003|261028144727099003|261021121427099003|261026121527099003|261022105027099003|261026140227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: kPZ8BSzqxVH2Kki+N77S+H9K/0ql6Ww7MkjWLV5R6iTi6RT5XyguoMjgyMx1Sx/atGZ7dTpxk1BRYvadhdK0TxqPw9FHLyLBZ1XW9CyT7fu7kHlDlW1S+6fhNaIscms4HfC59lrgpGdkfO5oaUz+/ofq0qVdm4Vc9pxMoP9xmGnb0imMU7oT1CbkxPXZ+DiYBCsqx4PsCs1DFB0nMdKvHpdBHHDZ3AV8so54C6+xGskE9UQHJRPGGt9UHSwvIsSvff8+Hf63xvUGaFuy2mS0obpm9GMlHc2wL0dzDt98iLjB7+g3APkcNE/jOgapOIuQhqpR0klnSLp7PMkQY/FXid35Kb+8tRfYavgeSpCxG/gvUDIHia/FsjByrazfb8wnqyvO94F+riHGsUqrtVE6T6Yw3nwq1ttRWS0G4ztZS0MbeM9cziGD+yMQJfyLow5RIiIKJlLvB2oi1aP8aIpEr6qYYWjOxrZXH5XyCOTH/vZyXb/p7y72uYPmyCIqcJzowJPKBZ4uUhWucpfLYoixdUKS5nLa5O/M185qluQMdIKYGFIVBkcYis2ChQ0uGbjcKImk+GXEXtwvcpgTLP4o9Vd9D5Sc5P4tLWVSUeHJLBCDZ/wJn3KjhUW1fyHkMJV818vSzvzhOAwUpbjl4dnEW2DArZr40apQQnJ4GEGbpAabUANh3KO7lvptH6junKwGavO6ZD3yqYapAMR8GsjJzbRrLyklqM2JtOz9fGF/FHseIanB54hoAyvyLly872xi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(921020)(38070700021)(261021123027099003)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HcbjBbV4MQX9Pn7PxGvFStOGkK+etnRR7SB31FCzJblP5jHcRxEenYIOcZ?=
 =?iso-8859-1?Q?VefGs6Q4O9sG7RqnPbsJpMGGzxvCgGvDAhOqc4/ye6YVOeu37LPYf5jjjB?=
 =?iso-8859-1?Q?m7aUfaMcMjNuqG1wjoV5WJg2nSxwRzuWI1K+65YvN4vazf2l7+ccc+3gi7?=
 =?iso-8859-1?Q?+Bc8CaEy5OPOJsoX+MOTzKzBxPJW5fr2rGiBtFjZ2Vs93NCR3Q3qzBwYdz?=
 =?iso-8859-1?Q?2M4Zt/aqyUSLYzGZImCtHnVzRZ/l4NEDQCv6LS9GRr6zEh1Iaf6M9n64s6?=
 =?iso-8859-1?Q?bFPM9tGRXmIozVkBZMHHUQe8n17YpRHbjEKwtwhIm+uu2v9yLsqZIn+wJy?=
 =?iso-8859-1?Q?0mwA8ZhKEE4tua0/vjBLtFQioMi2lLjSoB1ye/JHSuEClq1nUK9QOYkJyf?=
 =?iso-8859-1?Q?A0Zno6M0ouHKtyWZ9kZptS2RxpyOlWEYUFkPTIw+OPl+QtlzwQ7NDwgf5r?=
 =?iso-8859-1?Q?9yVGhAzu+ktbAYbcks3Tkj2PNA6p8pr2xQMQ06HyuJP79hW9uRW58Xvp19?=
 =?iso-8859-1?Q?uaGhxd7wFXBymRomkbSFFw1uAQXpisAWjMivjaSyfPYttf83IYeQBdRuuI?=
 =?iso-8859-1?Q?3TXNKqVT/eizSuAeA+xxgm2HvEo2Mxxxg9XOGUlAtais4tbqUedor+Iikt?=
 =?iso-8859-1?Q?6KMfYxBPYJcSlx2twCvGDYoD2znrd5LG4ecJSCNk4QG/CkAhuLeWUBBykC?=
 =?iso-8859-1?Q?+9fcBEhRbCJWv1Jg8JxFlCobqo1GQVI4fJIEBkA0TIcnXoGrNXfzBHsJWP?=
 =?iso-8859-1?Q?T7h+asmvLpeFMuJr/WkmAwxi0k7phqo6uTpaHepPdG442sZl5gH1emEAto?=
 =?iso-8859-1?Q?5NnMcA3khVFqolbWqCH/07Po7u4dog1Zb8WKsircmPlrFJFlG6lHgL4gsv?=
 =?iso-8859-1?Q?vn7e+i1ToSYAs/8Nrb2+2Ww9HNqdVQ3Dv0ybXTTxnPNOI8A9okpbXAY4Xt?=
 =?iso-8859-1?Q?kV7RoG0We0fe/wNezvTmYqK+Q8xYR3c93dIjNNAD4ZqN2c8j6i0Mv1D+jI?=
 =?iso-8859-1?Q?YWgqzYCWnUrOzegt8TWez2Y3dSfejdaq1PPUgUirdjvs2IGRaTfwke61xM?=
 =?iso-8859-1?Q?giB3X3TCIHBHLJIpzZhC9WEszI6E4ZQpVLX7DLqZCx2HjDDmhUljM4A5Lz?=
 =?iso-8859-1?Q?MKJO8SGzfClcBgTxmfe+CY1orToCSoHo3j0VVfd0WL+mWjivGIC6JIC4tG?=
 =?iso-8859-1?Q?8TOB7cQQB7pcUABWhzM39qrOns8jjP3krwCYNgxgQuMynSdEh/Jh9GLL9X?=
 =?iso-8859-1?Q?r/AJMmBHjkVvCXHw4kJ5LXUTb9J79SswURCk1fH0jbUu3YQAOBgmfwvExg?=
 =?iso-8859-1?Q?JX4PKlSaluxwJBJQxIE97z4lQHN/d+27i1n/ojVf6UE5Vx554JTUvTB+Um?=
 =?iso-8859-1?Q?roXU44lfAh/GXAAlT7dsuW9VjO38BWOGoYeWMzCaogdvDlF+dIt4zWqmAD?=
 =?iso-8859-1?Q?rj0hhOizNF1hJhGmZdDxfXRYmOG5z3MmoD7zIc0fvY5MpHgl1kDb5IDumz?=
 =?iso-8859-1?Q?8aNCg2NhEtCmU7xCf9YcfGBBNrnSLDQdCn5Gazt0YGURN7MUFkac9ksZWu?=
 =?iso-8859-1?Q?CM6DFbST35k06xJOcoIevRN72EClYZRfCmu0L5jiTGb/xLpG3hDdW+uHo5?=
 =?iso-8859-1?Q?0OxQyzeqcd8By3BnJLvgieZm3CJybK3i9lYaoIEucIMQtlHrZ7Bjnxn1oH?=
 =?iso-8859-1?Q?s5RhtYVLKWTFDL3tuObk3rKEu6Z3Jnd/iYPiseinf9+fDRH00ERfuRDzAG?=
 =?iso-8859-1?Q?v/0pt24YLFT8XnOvMgelCcC5sUTHGTjY3xKZCK+9Pgb5uPyz0yJ7RtnITc?=
 =?iso-8859-1?Q?998w8GFKCw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UWqRvB87Agax5xkqPn6DxYVPe9+mNC58k4IhbUx5/NazMmFulgMSw/MWg7GbiP0HyPZDDVxj/x5jA/wHRwafPJKRShatlkpFSh2h0BSS7IZiLcL0KyZDwW8I5Wpeqk5I7bJHdrfSWu8UXR9C2df5nV4XANMAcfK4pREXpdjhT10BC2J3Lh06FWCA1AwRBrmHHz3FaISOKUALSbWgU/Ud/rp4RSGjjBSiem8u5yeSgjXCeyv4L60r2r8NxRm7Ev02as1GQaGgHsKj73uBbiEXSsja4hPgyQTvvPiR+1Ux0zc+pN3YN0/tWtb1L/99sJEyQCBS89PYpucU/aTNGbrf8Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8666b692-074e-4874-741d-08df38c2c9eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:17.2022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwsN2Wq0eKznDsaNi5z4wWKwq10XahOxVf0ETQ7X+aqjRGHkU9ltLdzAlXIHBr0/wPqluqc3ESuIjthdjWGMXPasoKT4QZxmiXgGzec1JXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6832
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

The automatic hub is now off for a new machine type.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 docs/system/devices/usb.rst | 7 +++++--=0A=
 1 file changed, 5 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/docs/system/devices/usb.rst b/docs/system/devices/usb.rst=0A=
index dc694d23c2..24e8ccf96e 100644=0A=
--- a/docs/system/devices/usb.rst=0A=
+++ b/docs/system/devices/usb.rst=0A=
@@ -3,8 +3,11 @@ USB emulation=0A=
 =0A=
 QEMU can emulate a PCI UHCI, OHCI, EHCI or XHCI USB controller. You can=0A=
 plug virtual USB devices or real host USB devices (only works with=0A=
-certain host operating systems). QEMU will automatically create and=0A=
-connect virtual USB hubs as necessary to connect multiple USB devices.=0A=
+certain host operating systems).=0A=
+=0A=
+A machine type older than 11.2 plugs a virtual USB hub into the last=0A=
+free port, so that more devices fit. A newer one does not, and a=0A=
+device that finds no free port fails.=0A=
 =0A=
 USB controllers=0A=
 ~~~~~~~~~~~~~~~=0A=
-- =0A=
2.43.0=0A=

