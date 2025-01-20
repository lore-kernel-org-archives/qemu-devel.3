Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BBBC02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvme-0004f3-Ja; Mon, 20 Jan 2025 12:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmX-0004Wv-KH
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:51 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmT-0000YG-Nv
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394905; x=1768930905;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SCmChwFr652hQ1WXAdzdeZEqcWdhe6cyhklzf5ejZUg=;
 b=ouhZhzWxEdZl4KGhggeVTTB9PMglI0ske+GVm6PC9CAYZv48mbsr/tx8
 SirDAPTL3TA+whnySB8qLekoMA4jD87sJOpc9Gck/FTnZn/g63afH2jkf
 DIzaFNcLliyOoBaAHJeXXxMdNlafFHVNes+YkKm5iwjnmHFdA2liLxNRz
 a4Mg/0J21Bd+2lukjoWhizP8O3cjqDINN+KdSbMol1ujCecmCtAK/5dKj
 jTXVXpf0J/uKa5QGgsfZLUlOSGcfVUvtyMDPdRP3ZEyV4gAnlP1/llpDs
 tQ4AMsMr4tAPGnvlTsBD6RIjsmQyM6+PbAsnuYdaho4TDKWVOqS1h0xcn g==;
X-CSE-ConnectionGUID: 9pnGLJgsTV+PK67oV6bxCA==
X-CSE-MsgGUID: uQWYnGzhSdGZDF6sMMEI3w==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="29125394"
X-MGA-submission: =?us-ascii?q?MDFokaHJggJzYoAu1CA7H5E2Ip7Ta3KC/vNCO4?=
 =?us-ascii?q?/MzMCKXhA/QK60TRK9V/8Ufxv9+NgaUKniRWkSpCwK5bh4Z5E2gYH5+F?=
 =?us-ascii?q?95xJsCVQ8xAUUkkwL5WOI7Lt4JcUt9QIBudEu0k30CsHDe5an90Il3+L?=
 =?us-ascii?q?pJj/gjolzMoiBE5mCJ8kNz3w=3D=3D?=
Received: from mail-db8eur05lp2112.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.112])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:44 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0dg+zBdhANzNkhVOEJvxnuEEdi3pJi0SWUEKvveS3YN34N5H2Z9SHQn43E4nkP0eRINLPa99GWLsXoWq7lBO64GqrQfIZ60k+SUV0TrW9i7XfwrcuDsB7c9O/bJy+3fsC+vCFeC1L3ObDQJWwnHeT4K7VhTC6WWPefbfCxAahJK3ibrZtXxHlmxbYfZP77nltqH7AIPkgDkLrFJPE/KJr/DKu2N3fFLtiTkqY741+hcF+258waLrxEP9KZ4BF3xgmIn+6QeMJnOZ+XbmAZz/SgQvj45NilFT96ieuC2ti04po2OOQNSrX/pbvO9peZBSv9DSR/qgqxvW7Kh0S2iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuG5OjThV8VBS1EM6QJlXXrLyzON/GBiTeb4xCqjQlk=;
 b=AgUwgoAttcr56oMjrWuAGrr3Kc/pJx2ogYbO/pHMpuq6WSIPUy9woBotro2ATfK/DZn8zc9ZfOObdeeeicWk4s21TKG4Q6OLCeU5SN8VDFT8wB4R8v1Mg+xqiqA7LvKwa2Nlvbqm0t21KteI9qgI0tPU8Rx9UZqeO6epjP1PntAxOyzfwoSWPDqRBqYw7l2kaNbGsbkIaDt0QQ7t0lR9YUmtLlO5kLPib4atINJQetWdS9I+8sVrFNjtXP8J9iAlVF6NPJAHXuulklgCrjSGMF6E8wCy5oif9xhHyqvNiutD2hKITcV4GQUchrBw/sBBwU8uJjRcfRV8UaKCSuRa+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuG5OjThV8VBS1EM6QJlXXrLyzON/GBiTeb4xCqjQlk=;
 b=pH5U9nniRnPOLTwBTo3FQfyk9JFhAKL4hqmdugskAeyrJGpirM3Y9ajvMY1jfDQIljnoVQDRnjJ5by6hc+YThaAVJFx0YrG1gVaveiWO8B9oQAtFXkvi9BpoUSjVGzeUpryJ/ZTV+x6AckSCUepoH3I5EkTatzf+RadyiAHL57d9MR/kvFetXG4RBqTVK6lM94Qsc8QXUSYZyrVG8zpMFN+XIErM8NpTheEFvylFYFUSlovSVSEycRwU/sUrXQwxcUPt+z0yB0bO/F51uamQuugX6lbqpZflpFV3pPGIP28DC3uq/BY9nhDk3ifdG3yuZTDWIgbu36zfZdLlc76OWg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:43 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:43 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 05/19] pcie: Add helper to declare PASID capability for a
 pcie device
Thread-Topic: [PATCH v2 05/19] pcie: Add helper to declare PASID capability
 for a pcie device
Thread-Index: AQHba2KRuVRpVIdPc0iwYyvwuc4RKQ==
Date: Mon, 20 Jan 2025 17:41:43 +0000
Message-ID: <20250120174033.308518-6-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: e977585a-bb12-478a-3a03-08dd3979b463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?5UBJbyqHUTuKB/blzUELk9TRgVtVsC+A6sLXLpYKrJdo9LYXK4ljhsGhg/?=
 =?iso-8859-1?Q?etz6FbDwC9np81ZYaCkrCnoH9RE1Yo5ZZgd9DyKEiMUBag0c8vUGKUr5z9?=
 =?iso-8859-1?Q?FgTEBKuZ/6Teq+VHXGkh68BCLxuwLQOoiCCmx5iud3Fra3LKKqWAuYa7iD?=
 =?iso-8859-1?Q?ufI84QH68xqMC2wvKL0o9vxnu0VJO8c7NaHOynLRotueIBSN0L4Py61zfi?=
 =?iso-8859-1?Q?F5rSVXPBTi25iB2ZMz/n0HHm/0suBbx4Ss1XVdpXHqFFRHmm4hmlloxkve?=
 =?iso-8859-1?Q?yYkTT2HaMryDwFVm92x+MnWa9laKfrhiK2opMvyh1FspEHC19tnRCBuJyW?=
 =?iso-8859-1?Q?3IL1eUv1pMEb2uTatXH9oFjXZzE9/fF/bp+gNAP7n6N9JWhyh+XkJ38HhU?=
 =?iso-8859-1?Q?zCMA0if+pChbuUCHb0yxh1GqZxHnqexCaLkcAW8FTR8LNH9GYfrwxkA5GH?=
 =?iso-8859-1?Q?iBaH6qKVYeghDyv9mjyLuSLJfJsOhB+2k5xs6k32s//fpjzW0i2CvN/Yi6?=
 =?iso-8859-1?Q?QYOel2LddOze3PnfaVHN6sCE7HK3Vo2cmJwXZZIasUqzEg0pu/KH4P4ly+?=
 =?iso-8859-1?Q?iP/j2+7ybvmRMsOn0EEcAeZ3uwNJTSma/ba7RJ7vqOa/u86FuqGicVhzKR?=
 =?iso-8859-1?Q?oSnK3CktPfhzuuago7z4FdtBvZwpi1XG2n9gd3UPSud4jvb7EyHXd/JRAs?=
 =?iso-8859-1?Q?jpFqJTUrxYqoRJ7xEX5a3pqLi690Kk4jBTh0WbRDAzB1IPlNKbb3sNPC4G?=
 =?iso-8859-1?Q?Mheimp1oGIDHWcJiAh8blMXr4dtXCigOw0NUdtZt5ZlqXcKTJs4CSOLC4S?=
 =?iso-8859-1?Q?YpZCCForK2Ak3tWp0QFsJzBSCeLQp2jKcTnAyAuNrVpRVhc++U8FTBDJD5?=
 =?iso-8859-1?Q?8RLgjdvAO3ljhLy5DriMKBO/VMEDiv7FBo3g2jguDdbHzJzA6/xy0+FUVR?=
 =?iso-8859-1?Q?H2SqYQMoh2V24yNTSlWbxJn4LBHIPWnBXCIKlt0vgo3Tb3jO6kXukEN1H/?=
 =?iso-8859-1?Q?YN5xpUK1portTZFEJqQaYBVwz3L0Uzw/pH13UoNO1mcnSw2y2bPEO65UX4?=
 =?iso-8859-1?Q?AC14DkJPjrmccY4fW2dmrPjMjtEc3/qT/Dn2SYem/O0X0vZ7y88/ggNWyL?=
 =?iso-8859-1?Q?79OP9rZfXIT2ocGlifw2jlEKL7ZUqObgeg7bMfcEVs1IjVuzgXgnmR7a4I?=
 =?iso-8859-1?Q?CObSsGUXFGWXUYsshF7FM61VlaLMiznlLqdkvaNb2j0+pWwVkRCxtCMmRE?=
 =?iso-8859-1?Q?BofKJSqCer1LkbplGkfKUVPBreJcRj5ATsbofqCioSL83my84++BxFkwtb?=
 =?iso-8859-1?Q?NOUAWRm0SGo7lykxmk8CHQg4KMlORZdRBcxHpDvLz/7NlruVy3HAvxSr2c?=
 =?iso-8859-1?Q?mXd2KWqulTf/C1GiMDor3AOpLmYu4c5N2i9wKeGyQJsOWqvQbgCoG3ASFL?=
 =?iso-8859-1?Q?uDLVAwfzE3jCRmRiV7dH17ECUFatJCzJaQyhzkSM6b2SvwKrCWF+7+8h8D?=
 =?iso-8859-1?Q?ijwDqW4g8Dx33cm7zjmmdS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?reMbc6pHt5V3Hl2XyFnEfXpuSv3iO0CMiBd2Eli7jAhG4GikZ9loN/gGf8?=
 =?iso-8859-1?Q?S4l8egBna3okfPnrYw34H0uYUtG3uKJK7kvgfGx9cVcA8LQ+DYroPCc+H0?=
 =?iso-8859-1?Q?DO7Dupdezwbs7B3BBLGNdpJT05tkx/eYefnFj54X5AJAhgcewBFo4Bw/Ko?=
 =?iso-8859-1?Q?dkoQkq3/wryUydg86p5JpvlQjbABGVkRuctMwDzmnuV56EMOrezJbsUXXD?=
 =?iso-8859-1?Q?l/v31wcHzggbHHiqjgGpp+njTWJicoIsSIYUAXQPU4CtuC44OW4B7hgRMl?=
 =?iso-8859-1?Q?6NQl2wr3A9W4cNvCSOm0oAt3gsVGuvbzHfj1A2VMCBvurklaOn3ZLquIoQ?=
 =?iso-8859-1?Q?InYoD28cRaf5O5H6DP2Dm9t0WyTz/9XDFhOllRZmzUULBbYFdKit4CYBSI?=
 =?iso-8859-1?Q?k8UuzGIe5hGhFOtYrKGXxn5b851+4LazCTTxBO1Qa6S3ai9yUjaKhWu0X+?=
 =?iso-8859-1?Q?LiSnFvyW3klk/8LNptmanBhymQJCiyjcmWw85+LaNnE+xjPxON315KaiDs?=
 =?iso-8859-1?Q?qjuONb2wSdkRHoamf7J3byYn5RcK0NbwkK3syeGhBPS7Ia/XS0D4r+WoU7?=
 =?iso-8859-1?Q?I6V3Fzw3TgKmlKSuelBVHMK8APHhRpPOIggonkcEoq8tDv+vz1I0+tPutd?=
 =?iso-8859-1?Q?cL+4ZzLaSRSx0NfPfK3BTA4rkwOESF8pYs8jDlLGNX/F3s6ui8ADlIEPpa?=
 =?iso-8859-1?Q?dcRXpW4kOcnk1uhteRzQH6A5DFLFhWyj7lw7XDV4QlOWL5zv9U7fMHm0LC?=
 =?iso-8859-1?Q?1iB8YX0nesiiANhr0+tuVGw6jxgiqFccD6aNt53u7nACU2I7qQtyeUEOQ1?=
 =?iso-8859-1?Q?uHs/9+x0hXmSb14mi+PtZH0tU6PAT33MVv7MpbyNCiXJWvsg4TVjloI5qL?=
 =?iso-8859-1?Q?YHZkgAaR66XP/brb9xjAZgLPaIGvWnMfZsdtqqJWW5XwVqe7PvsN/ZusgT?=
 =?iso-8859-1?Q?xRdbfwpoVpEccv/RzGS7+1xvLYlDbj12IqctmyufLk3GIz3U4G6DTiQDXk?=
 =?iso-8859-1?Q?jSTKhWR7chk8POveN5/40q1CKepMCDRjwgfkjqPlYTaXcRws2C+uhE2INL?=
 =?iso-8859-1?Q?r9+tAPv2kZWZ/v6ffdfMTmndVY9UAmFT7c9YQy3qIJqe4cl6IYdu4MwLfr?=
 =?iso-8859-1?Q?MDrTXNbP3a0tXBzYrrxuNGv5qN7sI0lYoB5p6/FNEwqADIyU5PEEUAadOs?=
 =?iso-8859-1?Q?x74jyZ5X0Mg2AqSoT3UgYiS2GRE1ZDgeu28z6un1xojgMtJ/xwo+7YX9ey?=
 =?iso-8859-1?Q?7V3AVtuIGqRFg3ZFqxQB3nHGvSZkfRWBZ2NP9H3zN8SkRgJT1njx7Tr5oa?=
 =?iso-8859-1?Q?4l5PT0KuaA3ex8gUhoXPV4Ua5zb4PqJUHDJBXzkXSKEqIhUOm2fhqkoi6J?=
 =?iso-8859-1?Q?UCpXAc+ozRWN83XPNiTwePGG8wY6w44zO5O7Km2EyGLOwc+GC7GjX5aqXv?=
 =?iso-8859-1?Q?EXYpP7oqm09KjDY2Ur8B2oarGcr9kmN0CN0rBPVPa5nGQo9Bhc50oyPNWT?=
 =?iso-8859-1?Q?piTMDZPxfZlRP0ejoQJOWrkohauyguzgZcWVrG6nOWJq46RLBqlGnbW3PJ?=
 =?iso-8859-1?Q?yJmtnWzzLwDRdiW3Nr+o46zCoAsrTDueR0hC/KFrqYMQCPzWKrxSBeZVbD?=
 =?iso-8859-1?Q?FYybqr/+qtmCrLuvSpGTV1tvmi/1rXhkRiDMEV20pz2p4cDCX2JxoQc3Im?=
 =?iso-8859-1?Q?pJPMXrJzkoVjwmKAkgs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e977585a-bb12-478a-3a03-08dd3979b463
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:43.6195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6IohCsCXJ7wWiS0QWpwk48F/mbYj59j7kBc/Tmin+EZVZ72ZD/Jh8X+thNCHX9Gwkta+iL5ac4PctPBUl5yXEYneYYr2qZ55CqRm41FUkinTeKlVxSbOppUBcqZ/D3OZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c              | 24 ++++++++++++++++++++++++
 include/hw/pci/pcie.h      |  6 +++++-
 include/hw/pci/pcie_regs.h |  5 +++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 1b12db6fa2..f42a256f15 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1214,3 +1214,27 @@ void pcie_acs_reset(PCIDevice *dev)
         pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
     }
 }
+
+/* PASID */
+void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
+                     bool exec_perm, bool priv_mod)
+{
+    assert(pasid_width <=3D PCI_EXT_CAP_PASID_MAX_WIDTH);
+    static const uint16_t control_reg_rw_mask =3D 0x07;
+    uint16_t capability_reg =3D pasid_width;
+
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
+                        PCI_EXT_CAP_PASID_SIZEOF);
+
+    capability_reg <<=3D PCI_PASID_CAP_WIDTH_SHIFT;
+    capability_reg |=3D exec_perm ? PCI_PASID_CAP_EXEC : 0;
+    capability_reg |=3D priv_mod  ? PCI_PASID_CAP_PRIV : 0;
+    pci_set_word(dev->config + offset + PCI_PASID_CAP, capability_reg);
+
+    /* Everything is disabled by default */
+    pci_set_word(dev->config + offset + PCI_PASID_CTRL, 0);
+
+    pci_set_word(dev->wmask + offset + PCI_PASID_CTRL, control_reg_rw_mask=
);
+
+    dev->exp.pasid_cap =3D offset;
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index b8d59732bc..aa040c3e97 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -72,8 +72,9 @@ struct PCIExpressDevice {
     uint16_t aer_cap;
     PCIEAERLog aer_log;
=20
-    /* Offset of ATS capability in config space */
+    /* Offset of ATS and PASID capabilities in config space */
     uint16_t ats_cap;
+    uint16_t pasid_cap;
=20
     /* ACS */
     uint16_t acs_cap;
@@ -152,4 +153,7 @@ void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_de=
v, DeviceState *dev,
                              Error **errp);
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp);
+
+void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
+                     bool exec_perm, bool priv_mod);
 #endif /* QEMU_PCIE_H */
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 9d3b6868dc..4d9cf4a29c 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -86,6 +86,11 @@ typedef enum PCIExpLinkWidth {
 #define PCI_ARI_VER                     1
 #define PCI_ARI_SIZEOF                  8
=20
+/* PASID */
+#define PCI_PASID_VER                   1
+#define PCI_EXT_CAP_PASID_MAX_WIDTH     20
+#define PCI_PASID_CAP_WIDTH_SHIFT       8
+
 /* AER */
 #define PCI_ERR_VER                     2
 #define PCI_ERR_SIZEOF                  0x48
--=20
2.47.1

