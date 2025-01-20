Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD408C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmj-0004rx-Qg; Mon, 20 Jan 2025 12:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmf-0004hI-25
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:57 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmc-0000ZN-E6
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394914; x=1768930914;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iLlXujx6dEU2/AOLGEZhZjJQizzoRYB0ZTIDZP91pKE=;
 b=jtnbkVT9TnuuG7Ynd4xkFg1hchPxbNaD6PCNqvJ4A8rmtOhZmMwHJDbM
 yzHgfrtcvCar1pR9qNxkpssLZN3l6AD6kpojrmCdCoGwneB4MVxQ/XBsW
 F0UTdhwOFq7XSCp4UfcYWqKBUfKgL6ImFqJ4tJxt7sleA1Cb++b8f/Ziz
 jhNkhg2aaSfme56/al9lkOuFB4gXswnOUT20hrXmmoav1KLs/G3OPi80b
 XX0B+UkJ1vqwDi7W/VX9OfQJmyB3VwblsYveyl7Rvrei8a7zN5/E7L3pI
 cJIRBxLvE8ymmdrGuj/tZ4XIdh0aaVu+Ok9Cc3XzmqtPnKPwDecWIF7qa w==;
X-CSE-ConnectionGUID: G/6jYN5STwSyS2lJUDvbQQ==
X-CSE-MsgGUID: Afik9JLdSW+ORjQCjEsTKg==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="29133402"
X-MGA-submission: =?us-ascii?q?MDFpWsZcjXj9M2pdSgdHocGPS2TxOwRToOK/nm?=
 =?us-ascii?q?13cI6Mk4EzgmgNHaH+ePhsBt0Cv/zddz4mya2chrckG0bQMEN3unwRzL?=
 =?us-ascii?q?C8ZAovyFWy0LvcvBdE3kcHzzuGSc0CFesmAm9X+ULqFlRTvtukCLarLs?=
 =?us-ascii?q?TSy3X4VEv1y0HuNDTlSRrJbA=3D=3D?=
Received: from mail-am6eur05lp2112.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.112])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:53 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAqRe7eTbQWg2P62Iig5AAqr3qS0jRNUO66YygjGFh0Wl6OyfTF7zvN7iKwUKZE3LUzOr6AGJBHNExD0yu13sJcArzuN9wks2pHI/JnjQPLj2avg6cJgb4YZxKWt5cj5HKU9pUc3H8lUyCL93bYOd1IORZAaQg1J3YJuEa400XHbWNPXwNusnhcdzKFyUp6WN/iqVQ1yBRV+UR3+PnSXvZfaZ+DRd4Kc0ylBZpbUGPvVGQOBU5mWGNcG8DOikbrxAMk3lcMNGbwkxbdBByhCeFqKANn1pyzI/gxTiEAlRiP91IqCkLtFLjVi0ExBu8FbnmG/MkYdjBuTGaAnsUAxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkpzHx7jPGLa8EZn0sfsAfpjrZGuiQXVmGadzefMMB4=;
 b=wG/sYJQn0sHFrSe0MGmsilUDfhglZIrLaGwNJiw0xbIH9H/grUeI9894K/84N5YrGWxFU7xZ0Duyu3IDyZ9slR7IWOdtl7Au/A1nCIqOkboZJ2f/oOsYcJB0HOPVxr4K1Jz+Ttmw4wGyFo9vZU2qQ4b8X61t+WABKOejqKi4jpKc0KEQ4G0CcWpksm9TuWIMm9dtllGJDq/iHV4AvMoAJyfUGMQZG9of+lFvnC1mtlu/DMUVPt73eZeCHeX3HALdGYWfan1owEKeCfz6W5jQwXu4aOZlLG6s2b8v/+U2spiBQ+ZYiRQSCy4m1gj0SKu/kbjzcQDzx+7EKVm/rGnz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkpzHx7jPGLa8EZn0sfsAfpjrZGuiQXVmGadzefMMB4=;
 b=VRoPSmVO3PLrUCbnAiYgk0HA7TQQ8TzcdW45NBmkRkqxIdjJ4QMN47Ciq/aBaTNLLJhB55Vx/e0ruWfXZ4NCUcKAA8ZkYAdJydKkHe+mQR+AprX9du6ogSCXV0pyZEImFFGMNVDVHI74LzqNHT6Hbr9Cu1snhSv82vW2V2dnpoiHldDf3EYEk1XU8rbfuB3IQpwUDhGd1rjIGkeANGevj9vVYStVlps9bAJTlUOsMqR64IY6GDcXpANzeVbrs4Q4OrHXtqFvJAwSJ+gh9Pl5BI77Eze7mnJ82Btui5e84JNg1UVJ+2T+ZmbhrtmWSD8AST0l8BKuIiz6zA/0LC0dVA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 13/19] atc: Generic ATC that can be used by PCIe devices
 that support SVM
Thread-Topic: [PATCH v2 13/19] atc: Generic ATC that can be used by PCIe
 devices that support SVM
Thread-Index: AQHba2KWd1rFzxwaZUqmUmxBzA/gEw==
Date: Mon, 20 Jan 2025 17:41:52 +0000
Message-ID: <20250120174033.308518-14-clement.mathieu--drif@eviden.com>
References: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7548:EE_
x-ms-office365-filtering-correlation-id: a2a09b4e-2131-4a37-1214-08dd3979b972
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?g+T2wJU3KUQJL4Zr3zFH5TlAmOO5+vAKxlyvOU29aYrirHRgFiUtJV7CkH?=
 =?iso-8859-1?Q?b2BUUQKXNUal0K5TQRzr0oYEbphmPsMc+FsOe3xdspJTIAS/D4+esH+pGo?=
 =?iso-8859-1?Q?VWu02vt0two6kiBBxhm5RlPAOUZryLRB47KnsMK6U7Viz5nhPINXCnVVKv?=
 =?iso-8859-1?Q?OFJgDxm8nlbvJ+FpkSxK/b7QpVkNOblXoj4IzkyaBlZjhkIl+d1zWxKymS?=
 =?iso-8859-1?Q?x1qKrR+v1fQlsBFwypRCmbnVwBgwF5usTiulaMRv/SfiYcf/f8fLP1RLW3?=
 =?iso-8859-1?Q?sfMni7miBw6rFfNLPvzJbSPs/S/ZrXTNUzTwc5LaSpfpiAc2+q99/10ZjL?=
 =?iso-8859-1?Q?E3k/M/R4rjOsIwpW/qTiJA3CsglceMyslEAKs6J9FybAlSY5MJil4G617D?=
 =?iso-8859-1?Q?+gGRZM2IZPdQKemH9Fba+K37LUHRdgDk6JB757BPyI9KuTmteB6f0CjpHZ?=
 =?iso-8859-1?Q?4sp7OAtlAz5/LqYwBq/EuJ/ucgp0VEp22jzLhOoR71KLP2PoLdFyQ6rLEW?=
 =?iso-8859-1?Q?xXFGC5eKj/BOnqDmwgYA5MiC2WfRPpwZjKCsW1TxFD6u5slHwyYlgXIxbQ?=
 =?iso-8859-1?Q?htWDuezLuYbiHHKkPwi7e9Cs8uT/T6948ljiRad1lQeig3oXNn8YT/h4Pw?=
 =?iso-8859-1?Q?ixWoH/94L/p8wZ1Zuxt6Ne3VaXKhXeBjCqjySnyFjMmKx5CS4qxwMhU8lp?=
 =?iso-8859-1?Q?D7kuUnFt0kBVIHKBuEQBIAXDTMlkMZsP6Z79IEKmU6L6gi3sIAC3UnUUdo?=
 =?iso-8859-1?Q?xiwRZIExFVjXGIeooRCQ1DjJCFe/0C+i3FVedbN0X+ln5mq/6uH35GHqLa?=
 =?iso-8859-1?Q?lAJ/gMTi7LVW63djk26RoJ9mIcAA7cTknoJg278co99eFCcEFBPiCFVFoE?=
 =?iso-8859-1?Q?QJIku7FlDqi5QVCw+dRmcDvQSXlwVdxKzZ8H3Aric+7mR2P0IvgcpUpi1J?=
 =?iso-8859-1?Q?PabTaSWvjjJ69VdkI6prdWta9DfXvETVb275cZNrgY31x7cI5qfoVQuwpN?=
 =?iso-8859-1?Q?1BnaJYpoOU7pABbG32Up9pv22bZ91ZwZiUlm+d62goyJA4vtmQIB0HYfB8?=
 =?iso-8859-1?Q?FV+777Pp2jJSk8Kwf/fpuikDy5CnU00BU3dqNmOpOe2uFdg4nsGl/C5IXW?=
 =?iso-8859-1?Q?BVyEXuAZDdRY2yIyZAfSLSModMmDD4T8Hw11zy072Xm/Xj7PJ2ljyPsaKs?=
 =?iso-8859-1?Q?3wtKk/3pSiRoFuuFlq4Npc5wHN+or6Gox/OOJhiywy6mAGGa7Bhq1hH5zd?=
 =?iso-8859-1?Q?+i1cO6q5zx9cFU2KrZaKcd8liZ2zX0IvTTQmAQ3h/XSloLf0226TVCoedO?=
 =?iso-8859-1?Q?aYmYruSvd/ZPeHP3m5W0Kr3UPivDD2MKslDYfqw8I72bmgSNnamp+yGqbt?=
 =?iso-8859-1?Q?G77gnt27uTFyRitwG/N1rQQriaNqxtHZxPY3fkBunt2ez1cSKAEA/7toNj?=
 =?iso-8859-1?Q?usEefpnGWnBch9j3GENGcNuqmDgIIUTVEZsP7A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E+GzxzzfyDSLFBf+SHcewOWd6AWmVOs8t5kqeXYnkWKJ2eO3u/e6L9sYb8?=
 =?iso-8859-1?Q?RCLKZC+5tHQGnnqcmwWu1BM9kB06h5c1PUGOIiVfMhi5k2c2p17ho3CAcd?=
 =?iso-8859-1?Q?GqUjeePUL2zgqpsO6ah3o+Y4a5MAKnf0WkV5QP93TqpMxXP+mpilNS+CaD?=
 =?iso-8859-1?Q?XLb1CjfJDgauilzNtc6C8X5COOCcGnSKOXd7W5A6u2jlRWDySMkGDjei1u?=
 =?iso-8859-1?Q?/O9MZIDKmW3E4P3QQIYmOGd0dN7OhHuVlqctmwESa92tKau592P9GEAMqt?=
 =?iso-8859-1?Q?gzV8oZlACQCoc8vtFBLpJn5ym+VKJrE/hYEvlrs45OocBPpcFkZqIUakgP?=
 =?iso-8859-1?Q?88Z+iwunN3AY9uC66mqygnV2OqjNIVvPCLbwge31iUKFlN5Gy3F9vJ2r8R?=
 =?iso-8859-1?Q?voyRpOTc00nbh9Jp3ljqQBEpL/pR+wNoB0bALZGfZ+skVqYvvXyqrGGFBY?=
 =?iso-8859-1?Q?0Lrre+v8MTQPxHdZ45+iNFnVBtqF++9E0xXcOU2/2/TysJ+9UgJkZ0ioah?=
 =?iso-8859-1?Q?XXIuAsLX2RC1NOdku4MSJUerNFpdavOh9m0uQKXX5HAF1BJANLHn+er0Aq?=
 =?iso-8859-1?Q?JRhpAdyIUb/4aeqjSHb6ddWcbBd/Lt/VqWTVIMelvIb2gA5oD7SOVoB4pO?=
 =?iso-8859-1?Q?TZn8uljzOi9fwEpzqSFoPOzUFyZVj9H/yqJkDpUJ+Ky0OL2PT15juC2TEu?=
 =?iso-8859-1?Q?Lmcy7DAlR3MikO2Pnwy7YTLSwyPKa6U4R+6tYCH6ThxMfuKNF8JJFO58rW?=
 =?iso-8859-1?Q?eyUe6Ul8KPYG9rcYzRMbnsT2Kxg1YcTdWwR267FFk0iIT14aOUqyTRW1w9?=
 =?iso-8859-1?Q?jWTQ10C+BdT5WWEeGnWhyHQBkOKjxJgYNAmZvrYt7F+RfcV7ZpeoozgUNH?=
 =?iso-8859-1?Q?kzpGD46iAo5LTvBULMa72nhmhNVamMUCMd8rEpy2OPesac1h5wxHx1nn6z?=
 =?iso-8859-1?Q?5MdKGL+Yk/1zbTFCORAa25EKVaLP/ltQarJC5g16c1x+tY31WijS74YNr+?=
 =?iso-8859-1?Q?Ctu8MqG9L/lvFASSeaBqTKHNZcIGcGi85tyToQLXNDjPzp3gHngEQWeCHN?=
 =?iso-8859-1?Q?fLwgaZIA3pOQZJulFNNhiDZFALYCXkkoJ02ZxnDRKd8kwPGazs6xP2gDjm?=
 =?iso-8859-1?Q?q2xdsg0iVklX9zqEWk6ESnqZPfhItpa3EaNYFDEAnS71tDwYTmsiUlpFsh?=
 =?iso-8859-1?Q?qWqKYYeAjyyuySxL4LX4n9Nqq1A3wVgUK0EpyKIVIEm1BzBnfgL0NeIGQn?=
 =?iso-8859-1?Q?4nex0XmJW5qYhBs0g9p50m0KN/OXoK9hx6HFBBAZHuj7KU+wpLDrFTiqhM?=
 =?iso-8859-1?Q?zu5WEriKW+CvdudQwwZuPxPZqqmqIg3waVZtfkrB87AZ1r7J9iPGDVKQQW?=
 =?iso-8859-1?Q?ISOT+oSOUcWm3bOgFUlT6PRYeXA0Yi/aHsqGQ41zjbleQD4wKriTELTWyV?=
 =?iso-8859-1?Q?CnSmMBMmhp8CrqPeM23s1GZQGoiJ50KAI3rHKWN3MIPmUSE3uZAwzZmqP2?=
 =?iso-8859-1?Q?A4Bcue7luKKrkw02kfp3twTXnIeoeyRl3ZGuU7I6H3FnVTWjiV72/PzFPi?=
 =?iso-8859-1?Q?594ldsi1vbXm3weebQxdzka5a84hwmKPAQUYG93S66apv9L9/EDKgEUEme?=
 =?iso-8859-1?Q?xAqr7px+0zItQG5NlVbrvhQFO+0YDgFQddnixcZCzijlGFcXbfx6UCimfp?=
 =?iso-8859-1?Q?n7+OqMXXQGAkIzGrQaw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a09b4e-2131-4a37-1214-08dd3979b972
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:52.1033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEZZzQ5tbEx0RTEohH2IjlMmiP3HuvJ64M1WNUgan/v1Nj11iw+QWK4AkSW20lkVhUi+Jlqy21TOjokvOq9GEU7org9qyVr9h6wgXHB2GtLRqKASHaRpMKbHalcy0/2e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.036, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

As the SVM-capable devices will need to cache translations, we provide
an first implementation.

This cache uses a two-level design based on hash tables.
The first level is indexed by a PASID and the second by a virtual addresse.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 util/atc.c       | 211 +++++++++++++++++++++++++++++++++++++++++++++++
 util/atc.h       | 117 ++++++++++++++++++++++++++
 util/meson.build |   1 +
 3 files changed, 329 insertions(+)
 create mode 100644 util/atc.c
 create mode 100644 util/atc.h

diff --git a/util/atc.c b/util/atc.c
new file mode 100644
index 0000000000..584ce045db
--- /dev/null
+++ b/util/atc.c
@@ -0,0 +1,211 @@
+/*
+ * QEMU emulation of an ATC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "util/atc.h"
+
+
+#define PAGE_TABLE_ENTRY_SIZE 8
+
+/* a pasid is hashed using the identity function */
+static guint atc_pasid_key_hash(gconstpointer v)
+{
+    return (guint)(uintptr_t)v; /* pasid */
+}
+
+/* pasid equality */
+static gboolean atc_pasid_key_equal(gconstpointer v1, gconstpointer v2)
+{
+    return v1 =3D=3D v2;
+}
+
+/* Hash function for IOTLB entries */
+static guint atc_addr_key_hash(gconstpointer v)
+{
+    hwaddr addr =3D (hwaddr)v;
+    return (guint)((addr >> 32) ^ (addr & 0xffffffffU));
+}
+
+/* Equality test for IOTLB entries */
+static gboolean atc_addr_key_equal(gconstpointer v1, gconstpointer v2)
+{
+    return (hwaddr)v1 =3D=3D (hwaddr)v2;
+}
+
+static void atc_address_space_free(void *as)
+{
+    g_hash_table_unref(as);
+}
+
+/* return log2(val), or UINT8_MAX if val is not a power of 2 */
+static uint8_t ilog2(uint64_t val)
+{
+    uint8_t result =3D 0;
+    while (val !=3D 1) {
+        if (val & 1) {
+            return UINT8_MAX;
+        }
+
+        val >>=3D 1;
+        result +=3D 1;
+    }
+    return result;
+}
+
+ATC *atc_new(uint64_t page_size, uint8_t address_width)
+{
+    ATC *atc;
+    uint8_t log_page_size =3D ilog2(page_size);
+    /* number of bits each used to store all the intermediate indexes */
+    uint64_t addr_lookup_indexes_size;
+
+    if (log_page_size =3D=3D UINT8_MAX) {
+        return NULL;
+    }
+    /*
+     * We only support page table entries of 8 (PAGE_TABLE_ENTRY_SIZE) byt=
es
+     * log2(page_size / 8) =3D log2(page_size) - 3
+     * is the level offset
+     */
+    if (log_page_size <=3D 3) {
+        return NULL;
+    }
+
+    atc =3D g_new0(ATC, 1);
+    atc->address_spaces =3D g_hash_table_new_full(atc_pasid_key_hash,
+                                                atc_pasid_key_equal,
+                                                NULL, atc_address_space_fr=
ee);
+    atc->level_offset =3D log_page_size - 3;
+    /* at this point, we know that page_size is a power of 2 */
+    atc->min_addr_mask =3D page_size - 1;
+    addr_lookup_indexes_size =3D address_width - log_page_size;
+    if ((addr_lookup_indexes_size % atc->level_offset) !=3D 0) {
+        goto error;
+    }
+    atc->levels =3D addr_lookup_indexes_size / atc->level_offset;
+    atc->page_size =3D page_size;
+    return atc;
+
+error:
+    g_free(atc);
+    return NULL;
+}
+
+static inline GHashTable *atc_get_address_space_cache(ATC *atc, uint32_t p=
asid)
+{
+    return g_hash_table_lookup(atc->address_spaces,
+                               (gconstpointer)(uintptr_t)pasid);
+}
+
+void atc_create_address_space_cache(ATC *atc, uint32_t pasid)
+{
+    GHashTable *as_cache;
+
+    as_cache =3D atc_get_address_space_cache(atc, pasid);
+    if (!as_cache) {
+        as_cache =3D g_hash_table_new_full(atc_addr_key_hash,
+                                         atc_addr_key_equal,
+                                         NULL, g_free);
+        g_hash_table_replace(atc->address_spaces,
+                             (gpointer)(uintptr_t)pasid, as_cache);
+    }
+}
+
+void atc_delete_address_space_cache(ATC *atc, uint32_t pasid)
+{
+    g_hash_table_remove(atc->address_spaces, (gpointer)(uintptr_t)pasid);
+}
+
+int atc_update(ATC *atc, IOMMUTLBEntry *entry)
+{
+    IOMMUTLBEntry *value;
+    GHashTable *as_cache =3D atc_get_address_space_cache(atc, entry->pasid=
);
+    if (!as_cache) {
+        return -ENODEV;
+    }
+    value =3D g_memdup2(entry, sizeof(*value));
+    g_hash_table_replace(as_cache, (gpointer)(entry->iova), value);
+    return 0;
+}
+
+IOMMUTLBEntry *atc_lookup(ATC *atc, uint32_t pasid, hwaddr addr)
+{
+    IOMMUTLBEntry *entry;
+    hwaddr mask =3D atc->min_addr_mask;
+    hwaddr key =3D addr & (~mask);
+    GHashTable *as_cache =3D atc_get_address_space_cache(atc, pasid);
+
+    if (!as_cache) {
+        return NULL;
+    }
+
+    /*
+     * Iterate over the possible page sizes and try to find a hit
+     */
+    for (uint8_t level =3D 0; level < atc->levels; ++level) {
+        entry =3D g_hash_table_lookup(as_cache, (gconstpointer)key);
+        if (entry && (mask =3D=3D entry->addr_mask)) {
+            return entry;
+        }
+        mask =3D (mask << atc->level_offset) | ((1 << atc->level_offset) -=
 1);
+        key =3D addr & (~mask);
+    }
+
+    return NULL;
+}
+
+static gboolean atc_invalidate_entry_predicate(gpointer key, gpointer valu=
e,
+                                               gpointer user_data)
+{
+    IOMMUTLBEntry *entry =3D (IOMMUTLBEntry *)value;
+    IOMMUTLBEntry *target =3D (IOMMUTLBEntry *)user_data;
+    hwaddr target_mask =3D ~target->addr_mask;
+    hwaddr entry_mask =3D ~entry->addr_mask;
+    return ((target->iova & target_mask) =3D=3D (entry->iova & target_mask=
)) ||
+           ((target->iova & entry_mask) =3D=3D (entry->iova & entry_mask))=
;
+}
+
+void atc_invalidate(ATC *atc, IOMMUTLBEntry *entry)
+{
+    GHashTable *as_cache =3D atc_get_address_space_cache(atc, entry->pasid=
);
+    if (!as_cache) {
+        return;
+    }
+    g_hash_table_foreach_remove(as_cache,
+                                atc_invalidate_entry_predicate,
+                                entry);
+}
+
+void atc_destroy(ATC *atc)
+{
+    g_hash_table_unref(atc->address_spaces);
+}
+
+size_t atc_get_max_number_of_pages(ATC *atc, hwaddr addr, size_t length)
+{
+    hwaddr page_mask =3D ~(atc->min_addr_mask);
+    size_t result =3D (length / atc->page_size);
+    if ((((addr & page_mask) + length - 1) & page_mask) !=3D
+        ((addr + length - 1) & page_mask)) {
+        result +=3D 1;
+    }
+    return result + (length % atc->page_size !=3D 0 ? 1 : 0);
+}
+
+void atc_reset(ATC *atc)
+{
+    g_hash_table_remove_all(atc->address_spaces);
+}
diff --git a/util/atc.h b/util/atc.h
new file mode 100644
index 0000000000..8be95f5cca
--- /dev/null
+++ b/util/atc.h
@@ -0,0 +1,117 @@
+/*
+ * QEMU emulation of an ATC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef UTIL_ATC_H
+#define UTIL_ATC_H
+
+#include "qemu/osdep.h"
+#include "exec/memory.h"
+
+typedef struct ATC {
+    GHashTable *address_spaces; /* Key : pasid, value : GHashTable */
+    hwaddr min_addr_mask;
+    uint64_t page_size;
+    uint8_t levels;
+    uint8_t level_offset;
+} ATC;
+
+/*
+ * atc_new: Create an ATC.
+ *
+ * Return an ATC or NULL if the creation failed
+ *
+ * @page_size: #PCIDevice doing the memory access
+ * @address_width: width of the virtual addresses used by the IOMMU (in bi=
ts)
+ */
+ATC *atc_new(uint64_t page_size, uint8_t address_width);
+
+/*
+ * atc_update: Insert or update an entry in the cache
+ *
+ * Return 0 if the operation succeeds, a negative error code otherwise
+ *
+ * The insertion will fail if the address space associated with this pasid
+ * has not been created with atc_create_address_space_cache
+ *
+ * @atc: the ATC to update
+ * @entry: the tlb entry to insert into the cache
+ */
+int atc_update(ATC *atc, IOMMUTLBEntry *entry);
+
+/*
+ * atc_create_address_space_cache: delare a new address space
+ * identified by a PASID
+ *
+ * @atc: the ATC to update
+ * @pasid: the pasid of the address space to be created
+ */
+void atc_create_address_space_cache(ATC *atc, uint32_t pasid);
+
+/*
+ * atc_delete_address_space_cache: delete an address space
+ * identified by a PASID
+ *
+ * @atc: the ATC to update
+ * @pasid: the pasid of the address space to be deleted
+ */
+void atc_delete_address_space_cache(ATC *atc, uint32_t pasid);
+
+/*
+ * atc_lookup: query the cache in a given address space
+ *
+ * @atc: the ATC to query
+ * @pasid: the pasid of the address space to query
+ * @addr: the virtual address to translate
+ */
+IOMMUTLBEntry *atc_lookup(ATC *atc, uint32_t pasid, hwaddr addr);
+
+/*
+ * atc_invalidate: invalidate an entry in the cache
+ *
+ * @atc: the ATC to update
+ * @entry: the entry to invalidate
+ */
+void atc_invalidate(ATC *atc, IOMMUTLBEntry *entry);
+
+/*
+ * atc_destroy: delete an ATC
+ *
+ * @atc: the cache to be deleted
+ */
+void atc_destroy(ATC *atc);
+
+/*
+ * atc_get_max_number_of_pages: get the number of pages a memory operation
+ * will access if all the pages concerned have the minimum size.
+ *
+ * This function can be used to determine the size of the result array to =
be
+ * allocated when issuing an ATS request.
+ *
+ * @atc: the cache
+ * @addr: start address
+ * @length: number of bytes accessed from addr
+ */
+size_t atc_get_max_number_of_pages(ATC *atc, hwaddr addr, size_t length);
+
+/*
+ * atc_reset: invalidates all the entries stored in the ATC
+ *
+ * @atc: the cache
+ */
+void atc_reset(ATC *atc);
+
+#endif
diff --git a/util/meson.build b/util/meson.build
index 5d8bef9891..f2dec01300 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -93,6 +93,7 @@ if have_block
   util_ss.add(files('hbitmap.c'))
   util_ss.add(files('hexdump.c'))
   util_ss.add(files('iova-tree.c'))
+  util_ss.add(files('atc.c'))
   util_ss.add(files('iov.c'))
   util_ss.add(files('nvdimm-utils.c'))
   util_ss.add(files('block-helpers.c'))
--=20
2.47.1

