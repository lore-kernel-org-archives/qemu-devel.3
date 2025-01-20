Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2836C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmi-0004mC-3d; Mon, 20 Jan 2025 12:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmg-0004it-98
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:58 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmd-0000aZ-E2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394915; x=1768930915;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cfjC/wqFYSpLXoJOJ3oLFuGzwUlEFdalwLBOR1vc6bY=;
 b=tEqX6gUs21zeSZNcF+6vnFRVeXnBmr/xDbnz305JWH1FynQGV48R1g9i
 sKjWVR58RIDm9pLhxqgC+R1zX14tY8Erc7/YKjWPguDX2Mf6vZljX3zuS
 YEkjquNj8JZdlj18pyfmd8IW46PJEHUDD3ZBhAQRdzi8msrQyCEOmqbai
 uL6mXbVy9gMw6CsFpbMsfG6vi3BtPPS3+6quOGUuIz5dQD4me6WtTW3GA
 oqWuheydcojjcdESFy/MUfuabXL44NikyuxRhozYNgcRygTs+2RR7uDLq
 hzVAsmf/qV7sQVi8EMkuhcc6jsLvGGkgUfE9rjoOgJlElUxzhPvpVIqTU w==;
X-CSE-ConnectionGUID: 5nRQC8sYRDSaF0bIaATAmw==
X-CSE-MsgGUID: /C4lwRNYT8CuTWkNdgJIsA==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="29133403"
X-MGA-submission: =?us-ascii?q?MDH6TmX8E4XUuBXgITKzvDkz7UUUuG7OGXDYzi?=
 =?us-ascii?q?7xRXLIsUT7D+m7D7sPQucnOLkmqG3TzNbY/7+xTuXZx7r1x01NOl8JPc?=
 =?us-ascii?q?2wJqf7nCB+l+7dHsCUmhXJS5Q8eo/YrFwidHLoFCOAgdxCIjdusGFGb1?=
 =?us-ascii?q?B+hkxoMPeUrsxGh665EkYNcg=3D=3D?=
Received: from mail-am6eur05lp2113.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.113])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:54 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaIXhkgCKsswHvL/TQLRee7x7ZAN0RP8FyGB5INaHjksk7V2m8TafXGgqQJgc879zpeoHTW/4r98g9nTP8heY9I7muUK1wtZ+hkDdh4Djc0/z/Tsure7lW0m2QfmVKAEcMJVszl8/jtzzt10eXb5TsnenlipZvL/n7cI0U4fLoNj9HBOzEI25XyzvIh8vmli+oNKbB9KflK6tSYyaL9XyMAagqQ4vaPw7RTjeNl4pkdAxRFBL7xMO1w+E4bMCQRQL0FJWclNC+NsF3FAgyTYtuNW8gfEazGCaweBlFhZKBC0oRAdoYX45z2JHNwVIYH8doikNCEmoXVbPNxIMQBPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRYAqsK3djNecieuq9gZMJbKslo9CcsSie6ejP5sSps=;
 b=M1f6z6hx+CBqc6DtDOfv0zdP172tk+L5ugpWUBu4921DqAB4frInLEDMbgn4XmiwTNQBr98K30vqxqeG0Z7zAe4xwunj5J5H+ThCd5Ka+3iauuSPlHsx7CVCssbCCr3v5SzT7wa7XBd4JkKi98BsLzUDAGP/2c5+UFcCXjHYk6sZv3JMNI632ExteqPf3zycp/siadJK6n145ndXRu8hHL447y3c0HYIWpM1wnqnvlfySZ7+KdtbpdzfXQ+IpbTaNrQ92zZjmoFkQYG2oWBr/pZ/JRAW9w0es22fIejcPqEX2dFzdQmwVV7fM7KfJzblnxV1sX8e+C6u5O5WLS7iXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRYAqsK3djNecieuq9gZMJbKslo9CcsSie6ejP5sSps=;
 b=QZnlB8XO471mpRzeujeuPV+9tSuSxMx92CUtGr7uff1MYYYCpHbDJSWNhpd73OAwd4uAw+lMwsYp9joTDxeoHiO7GGs5MIzwzhSz1xFX2Z4nTmwuFDmZZKBN+LuoXQJ0U6+PEm0WOeQwP5h0+J2GZiVmQrJbqy9imPw2blCzBC3Xlh97s5t9sJt+NkzQuzysTMC6sKvJfEXZucEubiCifYg0FL1OogLdM/p0GH9ZifGiZUWTFMdNe0VnKa9+PNFwwmcTYm06vKcjKBe2z4p9jHEtxoGPL0RTvWgA99i8g3DDpG6xvY+1RkJKbgK9531LF9BzfZkBumD/hFbO5/neew==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:53 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:53 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 14/19] atc: Add unit tests
Thread-Topic: [PATCH v2 14/19] atc: Add unit tests
Thread-Index: AQHba2KXke9thKhyt0qrO3dDNNVJOw==
Date: Mon, 20 Jan 2025 17:41:53 +0000
Message-ID: <20250120174033.308518-15-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: ae6fac31-a220-4d1c-2d76-08dd3979ba08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?JU/CI/WiorAYeRzEnpBm9xh/w9F21L1lTFwvs6/KZEca8hBlkokcY/tD4B?=
 =?iso-8859-1?Q?IVgIWWO56uEXQpmhOOFXSbP6DAKFi+H5tjHJdwqqC3LXKNLyu2Jn5cuejZ?=
 =?iso-8859-1?Q?42T9u7aSqt2usT40lL3wewvgzG7Q3b4PL37lycCkm/b7PW7lB9lo8N5mYF?=
 =?iso-8859-1?Q?6fDjDFb8GNKEYv2+lgoLPPuxJpIrqyom0hpOg83P4qZDVlY4Enk/t8iSq3?=
 =?iso-8859-1?Q?MS/hiEIhRu7cND+KMr5tgxX59TrTzlTjfIx5XpUWJir4+JOWlbEwCL1U4y?=
 =?iso-8859-1?Q?iR70gSpEwOmujUX9nB9dc1HxJ6fTxv54ypLAmBpPwKLcInNkPwNFr59jrh?=
 =?iso-8859-1?Q?gCS6Z3UTZIsqeJgpg8TV2vavllahHFs+wTlaaKyWdEk5/DaxH0BNhe0zKN?=
 =?iso-8859-1?Q?Zw2hZtaUWqvpMhSKaFMsiFWZMiHstasMEPChZqvnax0wuVe92gV8shDoWA?=
 =?iso-8859-1?Q?leOjq7PwiDDumFYqCjf6hOhRvYRhPQtpDo5HzPf4/aDFuaGbggBvUVRfJr?=
 =?iso-8859-1?Q?WoCegbx1vFWuKC+fBhz5iW7ncvfUcH3ectYus7VFpPbCwNIuFeoHIHE30B?=
 =?iso-8859-1?Q?sHpF8h1c2muBwR4mI3MrsDnd4E//yJFV9btxDBusLYoCx+eM0l3Rc3Mp3g?=
 =?iso-8859-1?Q?xA2QiAZniwOZAtb1gAI7IobDM1JaggFFdeRDQyjazRPibMz707zrpbJDfZ?=
 =?iso-8859-1?Q?Tym9ifk1vI5+w+swTHGp+FEf7mpfPFv7OMWjjB+mH58X8+8Wu/gQiqbByR?=
 =?iso-8859-1?Q?QZvdiNnKF7Xeis2YQarR95ExhWIgIUvnDitCHrswEb1TOsQo/uVZtPtDWd?=
 =?iso-8859-1?Q?/fZz3JGdG/DELEUqWcdgNMsOWaMMpBn2ul+4C6Ld2uI0bz2DSEqrMRNeaU?=
 =?iso-8859-1?Q?SDgXGC39RA00RGtAz21lqa0GxYYi04ZSHuL5RBtDR8/zsqWQZnB2HtBu8v?=
 =?iso-8859-1?Q?Ma/wnktjrZ+SiCl0D42PxO3w+/VuL99eoJiBhw/YfYZl5T6qTRKka2QmTF?=
 =?iso-8859-1?Q?Bi4h2ZPUj3XfjHCqkBbNv53Y4rN8PyNvFTo/m71RJGDFhFXf5Npkz0ZXzO?=
 =?iso-8859-1?Q?S/wxfE84ef3NAn1uqhEufV6Dk0mlyxOBSkiiN4S7KDbS/P/WWQxC/9rns6?=
 =?iso-8859-1?Q?2MUBJA3dP6jxtrC/QvmdPBT/LAiGgfPQZUPvcaRxMB7TrTPb0skepuYoM9?=
 =?iso-8859-1?Q?rTKF8BbRNDtbypEUN/IrDxfRgqXPp58MXl+fB7RK4K90J8jOFM/gEF1uMn?=
 =?iso-8859-1?Q?765e7bhp07Sq/TQUFqsCjmEBBVzT9ZwJRFEiKMamvLROlLkTWsdMkRYxZq?=
 =?iso-8859-1?Q?/Ye/kLHMLM59Kr0piRqfLLCpEzfv/DrVIWHNF1m+PPcw3sZ7+lc1sV1Jc/?=
 =?iso-8859-1?Q?ajPiOob4ZCcKVU+oDVgLEC//ttBeu4rKc45wHPvtnyS6H7UTPQhDkikmoC?=
 =?iso-8859-1?Q?33MvS8E6l6269GgO1CQHYDfVsrVKgeTLfqf1SA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LamExWdQz8VFP/n5v6tw/4km96bVd2tD5UVh0evAbT/GBDPpHs8xBtKfrq?=
 =?iso-8859-1?Q?grgxRz7DB7s+ceLtveXDjzHULJVcRfWdlO5uo9bCoJR1jhjENaDrq1hFXT?=
 =?iso-8859-1?Q?6uEjtqECyGOMUsIP5VrGvu71gO7FWrS9Ngir9muiiD5NVIxuzUS85ZZR0l?=
 =?iso-8859-1?Q?HHOzyAh/waV9sh41P0InqY3bR9ecidkG7uk08tk6bA9cmJRG0WPRBNcsQQ?=
 =?iso-8859-1?Q?Iedv9+0LBm/MezEo7bJQB2VeQYSFpMA3PrDZQF/WbFoGOdDET+/CX2RZS0?=
 =?iso-8859-1?Q?LIlhfzFK9N/Ur9nIRGYrttrmm4wQB7sz5oPiUlpCPyzZ3X85b54dP6oc12?=
 =?iso-8859-1?Q?NFz163n73+8k+3xWdIsW9STIuvQjzM2gBeMKhrRLVQ5Sj9r67LKyadLhju?=
 =?iso-8859-1?Q?s8VAtkyedhOaVdDPjFOz+Wave4haunq+VlaF5o0QgMMdgfDNw3inamGCVh?=
 =?iso-8859-1?Q?5g2V3OwoZcaYxoi/yx4Lwf8ualU/iKD2RIWgD08ArBI4JPknZ7Puu17drb?=
 =?iso-8859-1?Q?l4m7YpZ7fblIlt0ooKrLpr1qf0BxsBFbF4SqFmOp8HmFD43TwhtOrHCI5x?=
 =?iso-8859-1?Q?Z1PNgRb3BL4Wg82UnFBtLM7t2hUN/Vs7glT5Z52Hd7F9QooopvT6d1zEgC?=
 =?iso-8859-1?Q?2S+iqsr8QKTXh/z+ZXTXEiBoCkPTqA5MVlrc5gR7LUPSX80yreChMAwW0p?=
 =?iso-8859-1?Q?Xey0zoKf0IWTEpHQsc46DLCPcJ/jvx98P/tAG2+/eFSU8nkEWRD26mnKFa?=
 =?iso-8859-1?Q?Ng6EnI1PoaN1Nz4TeTZagYDa80r54rbcXXwr7ZyxUtBkK5DUl07QSk8Rpq?=
 =?iso-8859-1?Q?4NHiK+eIhDEyGXvuhMTX5ASP8Z5ZUw3yaZ0OPITr89oxsdFIkhabSVy9Ix?=
 =?iso-8859-1?Q?X2rZ+EOvwW73t4Ir7UYb/yzC2I0JbHOsXQd0kRObCm2v9CwAZXesAgYmyW?=
 =?iso-8859-1?Q?P1V4CmG+3iiGqr/XpMpUIbP10oMRcMbKUjPkwk9mA/bTQoCm/0YzjSro7o?=
 =?iso-8859-1?Q?QTl5NoZCuhzjEwbKSlahecOR2Sc3thAI0SVQp5TOYFOX9YlG5pS7JZJJAn?=
 =?iso-8859-1?Q?WNaJj/BNbnaN6A0GNO2LoE56gAbZxsTy0dKpqFzKvWjXYtjpCjRZ6X8HH/?=
 =?iso-8859-1?Q?lq9d1XiBP4mdC8Vnbb/b20OFIN8Sp3WI+s/WBBb0aLy7G95Z6se8D4bs6n?=
 =?iso-8859-1?Q?u7CNLDBeLDEylXrR796jIgzr1CG8lYdsDinfzGIPu/LSXAtiCxnVCLa+fK?=
 =?iso-8859-1?Q?XbW7oDulf2vdIgl7XPVP/BV+mkRPaG+9NFWT6PBMDcjyyWmfJXJuKqalhN?=
 =?iso-8859-1?Q?I/LUZi8im3Nh+w4itaBhW7Ih8mu1gXYQ4dlhoQmVP6f1uTZ8mfEx9o5RrE?=
 =?iso-8859-1?Q?JEykIS5ote1OH5nSnm6bhgErPa8ziMa5/7SjTETyZ43L0NC11nE/4V0gIk?=
 =?iso-8859-1?Q?EVqKnnaf/z/c4b5RESFkwE99BWTUQRDhfpipKumzZMTQRRZ3wUaDt84iQS?=
 =?iso-8859-1?Q?1nAnqJi4Zm2p+RJ4TN9Y81UmYq25kFS21l5eZ6ZUSXD7eLu25jPkvq8Jml?=
 =?iso-8859-1?Q?Bx09o8HTiiwYkewxby5bqjFphhZQ90Ir16OMP39qqMM6OAO+SkdN8EVJWJ?=
 =?iso-8859-1?Q?um3tCTillW4usGy6aQydaVWs1Jw/bWD9ngHlyS7awcqRaxRxt3sjiQy3Ff?=
 =?iso-8859-1?Q?0tC2P2NwgSCzuiXYmsk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6fac31-a220-4d1c-2d76-08dd3979ba08
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:53.1283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Swpn8dlzyWwHC1V0Wa7Ikcl2Xw4NOPWk8V0tCP7Atb+TI1WBjTFhgSBgKlnjyxA/mUBizDSkDdQg7pzpkCjQJGLIz8pK9bIhr6s+/kQGJu0N5Iq9IRVJTNV2XGiiS1y
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 tests/unit/meson.build |   1 +
 tests/unit/test-atc.c  | 527 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 528 insertions(+)
 create mode 100644 tests/unit/test-atc.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d5248ae51d..810197d5e1 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -48,6 +48,7 @@ tests =3D {
   'test-qapi-util': [],
   'test-interval-tree': [],
   'test-fifo': [],
+  'test-atc': [],
 }
=20
 if have_system or have_tools
diff --git a/tests/unit/test-atc.c b/tests/unit/test-atc.c
new file mode 100644
index 0000000000..0d1c1b7ca7
--- /dev/null
+++ b/tests/unit/test-atc.c
@@ -0,0 +1,527 @@
+/*
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
+static inline bool tlb_entry_equal(IOMMUTLBEntry *e1, IOMMUTLBEntry *e2)
+{
+    if (!e1 || !e2) {
+        return !e1 && !e2;
+    }
+    return e1->iova =3D=3D e2->iova &&
+            e1->addr_mask =3D=3D e2->addr_mask &&
+            e1->pasid =3D=3D e2->pasid &&
+            e1->perm =3D=3D e2->perm &&
+            e1->target_as =3D=3D e2->target_as &&
+            e1->translated_addr =3D=3D e2->translated_addr;
+}
+
+static void assert_lookup_equals(ATC *atc, IOMMUTLBEntry *target,
+                                 uint32_t pasid, hwaddr iova)
+{
+    IOMMUTLBEntry *result;
+    result =3D atc_lookup(atc, pasid, iova);
+    g_assert(tlb_entry_equal(result, target));
+}
+
+static void check_creation(uint64_t page_size, uint8_t address_width,
+                           uint8_t levels, uint8_t level_offset,
+                           bool should_work) {
+    ATC *atc =3D atc_new(page_size, address_width);
+    if (atc) {
+        g_assert(atc->levels =3D=3D levels);
+        g_assert(atc->level_offset =3D=3D level_offset);
+
+        atc_destroy(atc);
+        g_assert(should_work);
+    } else {
+        g_assert(!should_work);
+    }
+}
+
+static void test_creation_parameters(void)
+{
+    check_creation(8, 39, 3, 9, false);
+    check_creation(4095, 39, 3, 9, false);
+    check_creation(4097, 39, 3, 9, false);
+    check_creation(8192, 48, 0, 0, false);
+
+    check_creation(4096, 38, 0, 0, false);
+    check_creation(4096, 39, 3, 9, true);
+    check_creation(4096, 40, 0, 0, false);
+    check_creation(4096, 47, 0, 0, false);
+    check_creation(4096, 48, 4, 9, true);
+    check_creation(4096, 49, 0, 0, false);
+    check_creation(4096, 56, 0, 0, false);
+    check_creation(4096, 57, 5, 9, true);
+    check_creation(4096, 58, 0, 0, false);
+
+    check_creation(16384, 35, 0, 0, false);
+    check_creation(16384, 36, 2, 11, true);
+    check_creation(16384, 37, 0, 0, false);
+    check_creation(16384, 46, 0, 0, false);
+    check_creation(16384, 47, 3, 11, true);
+    check_creation(16384, 48, 0, 0, false);
+    check_creation(16384, 57, 0, 0, false);
+    check_creation(16384, 58, 4, 11, true);
+    check_creation(16384, 59, 0, 0, false);
+}
+
+static void test_single_entry(void)
+{
+    IOMMUTLBEntry entry =3D {
+        .iova =3D 0x123456789000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 5,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+
+    ATC *atc =3D atc_new(4096, 48);
+    g_assert(atc);
+
+    assert_lookup_equals(atc, NULL, entry.pasid,
+                         entry.iova + (entry.addr_mask / 2));
+
+    atc_create_address_space_cache(atc, entry.pasid);
+    g_assert(atc_update(atc, &entry) =3D=3D 0);
+
+    assert_lookup_equals(atc, NULL, entry.pasid + 1,
+                         entry.iova + (entry.addr_mask / 2));
+    assert_lookup_equals(atc, &entry, entry.pasid,
+                         entry.iova + (entry.addr_mask / 2));
+
+    atc_destroy(atc);
+}
+
+static void test_single_entry_2(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xabcdef200000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eedULL,
+    };
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_update(atc, &e1);
+
+    assert_lookup_equals(atc, NULL, e1.pasid, 0xabcdef201000ULL);
+
+    atc_destroy(atc);
+}
+
+static void test_page_boundaries(void)
+{
+    static const uint32_t pasid =3D 5;
+    static const hwaddr page_size =3D 4096;
+
+    /* 2 consecutive entries */
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0x123456789000ULL,
+        .addr_mask =3D page_size - 1,
+        .pasid =3D pasid,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D e1.iova + page_size,
+        .addr_mask =3D page_size - 1,
+        .pasid =3D pasid,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x900df00dULL,
+    };
+
+    ATC *atc =3D atc_new(page_size, 48);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    /* creating the address space twice should not be a problem */
+    atc_create_address_space_cache(atc, e1.pasid);
+
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova - 1);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova + e1.addr_mask);
+    g_assert((e1.iova + e1.addr_mask + 1) =3D=3D e2.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova + e2.addr_mask);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova + e2.addr_mask + 1);
+
+    assert_lookup_equals(atc, NULL, e1.pasid + 10, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid + 10, e2.iova);
+    atc_destroy(atc);
+}
+
+static void test_huge_page(void)
+{
+    static const uint32_t pasid =3D 5;
+    static const hwaddr page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0x123456600000ULL,
+        .addr_mask =3D 0x1fffffULL,
+        .pasid =3D pasid,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+    hwaddr addr;
+
+    ATC *atc =3D atc_new(page_size, 48);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_update(atc, &e1);
+
+    for (addr =3D e1.iova; addr <=3D e1.iova + e1.addr_mask; addr +=3D pag=
e_size) {
+        assert_lookup_equals(atc, &e1, e1.pasid, addr);
+    }
+    /* addr is now out of the huge page */
+    assert_lookup_equals(atc, NULL, e1.pasid, addr);
+    atc_destroy(atc);
+}
+
+static void test_pasid(void)
+{
+    hwaddr addr =3D 0xaaaaaaaaa000ULL;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D addr,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 8,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D addr,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 2,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xb001ULL,
+    };
+    uint16_t i;
+
+    ATC *atc =3D atc_new(4096, 48);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_create_address_space_cache(atc, e2.pasid);
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+
+    for (i =3D 0; i <=3D MAX(e1.pasid, e2.pasid) + 1; ++i) {
+        if (i =3D=3D e1.pasid || i =3D=3D e2.pasid) {
+            continue;
+        }
+        assert_lookup_equals(atc, NULL, i, addr);
+    }
+    assert_lookup_equals(atc, &e1, e1.pasid, addr);
+    assert_lookup_equals(atc, &e1, e1.pasid, addr);
+    atc_destroy(atc);
+}
+
+static void test_large_address(void)
+{
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaaaaaaaaa000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 8,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D 0x1f00baaaaabf000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D e1.pasid,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xdeadbeefULL,
+    };
+
+    ATC *atc =3D atc_new(4096, 57);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    atc_destroy(atc);
+}
+
+static void test_bigger_page(void)
+{
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaabbccdde000ULL,
+        .addr_mask =3D 0x1fffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+    hwaddr i;
+
+    ATC *atc =3D atc_new(8192, 43);
+
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_update(atc, &e1);
+
+    i =3D e1.iova & (~e1.addr_mask);
+    assert_lookup_equals(atc, NULL, e1.pasid, i - 1);
+    while (i <=3D e1.iova + e1.addr_mask) {
+        assert_lookup_equals(atc, &e1, e1.pasid, i);
+        ++i;
+    }
+    assert_lookup_equals(atc, NULL, e1.pasid, i);
+    atc_destroy(atc);
+}
+
+static void test_unknown_pasid(void)
+{
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaabbccfff000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+
+    ATC *atc =3D atc_new(4096, 48);
+    g_assert(atc_update(atc, &e1) !=3D 0);
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+    atc_destroy(atc);
+}
+
+static void test_invalidation(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaabbccddf000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D 0xffe00000ULL,
+        .addr_mask =3D 0x1fffffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xb000001ULL,
+    };
+    IOMMUTLBEntry e3;
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+
+    atc_update(atc, &e1);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    atc_invalidate(atc, &e1);
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    atc_invalidate(atc, &e2);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+
+    /* invalidate a huge page by invalidating a small region */
+    for (hwaddr addr =3D e2.iova; addr <=3D (e2.iova + e2.addr_mask);
+         addr +=3D page_size) {
+        atc_update(atc, &e2);
+        assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+        e3 =3D (IOMMUTLBEntry){
+            .iova =3D addr,
+            .addr_mask =3D page_size - 1,
+            .pasid =3D e2.pasid,
+            .perm =3D IOMMU_RW,
+            .translated_addr =3D 0,
+        };
+        atc_invalidate(atc, &e3);
+        assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+    }
+    atc_destroy(atc);
+}
+
+static void test_delete_address_space_cache(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0xaabbccddf000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D e1.iova,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 2,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eeeeeedULL,
+    };
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+
+    atc_update(atc, &e1);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    atc_invalidate(atc, &e2); /* unkown pasid : is a nop*/
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+
+    atc_create_address_space_cache(atc, e2.pasid);
+    atc_update(atc, &e2);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    atc_invalidate(atc, &e1);
+    /* e1 has been removed but e2 is still there */
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+
+    atc_update(atc, &e1);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+
+    atc_delete_address_space_cache(atc, e2.pasid);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+    atc_destroy(atc);
+}
+
+static void test_invalidate_entire_address_space(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0x1000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D 0xfffffffff000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xbeefULL,
+    };
+    IOMMUTLBEntry e3 =3D {
+        .iova =3D 0,
+        .addr_mask =3D 0xffffffffffffffffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0,
+    };
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+    atc_invalidate(atc, &e3);
+    /* e1 has been removed but e2 is still there */
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+
+    atc_destroy(atc);
+}
+
+static void test_reset(void)
+{
+    static uint64_t page_size =3D 4096;
+    IOMMUTLBEntry e1 =3D {
+        .iova =3D 0x1000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 1,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0x5eedULL,
+    };
+    IOMMUTLBEntry e2 =3D {
+        .iova =3D 0xfffffffff000ULL,
+        .addr_mask =3D 0xfffULL,
+        .pasid =3D 2,
+        .perm =3D IOMMU_RW,
+        .translated_addr =3D 0xbeefULL,
+    };
+
+    ATC *atc =3D atc_new(page_size , 48);
+    atc_create_address_space_cache(atc, e1.pasid);
+    atc_create_address_space_cache(atc, e2.pasid);
+    atc_update(atc, &e1);
+    atc_update(atc, &e2);
+
+    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
+
+    atc_reset(atc);
+
+    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
+    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
+    atc_destroy(atc);
+}
+
+static void test_get_max_number_of_pages(void)
+{
+    static uint64_t page_size =3D 4096;
+    hwaddr base =3D 0xc0fee000; /* aligned */
+    ATC *atc =3D atc_new(page_size , 48);
+    g_assert(atc_get_max_number_of_pages(atc, base, page_size / 2) =3D=3D =
1);
+    g_assert(atc_get_max_number_of_pages(atc, base, page_size) =3D=3D 1);
+    g_assert(atc_get_max_number_of_pages(atc, base, page_size + 1) =3D=3D =
2);
+
+    g_assert(atc_get_max_number_of_pages(atc, base + 10, 1) =3D=3D 1);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10, page_size - 10) =
=3D=3D 1);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10,
+                                         page_size - 10 + 1) =3D=3D 2);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10,
+                                         page_size - 10 + 2) =3D=3D 2);
+
+    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 1) =3D=
=3D 1);
+    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 2) =3D=
=3D 2);
+    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 3) =3D=
=3D 2);
+
+    g_assert(atc_get_max_number_of_pages(atc, base + 10, page_size * 20) =
=3D=3D 21);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10,
+                                         (page_size * 20) + (page_size - 1=
0))
+                                          =3D=3D 21);
+    g_assert(atc_get_max_number_of_pages(atc, base + 10,
+                                         (page_size * 20) +
+                                         (page_size - 10 + 1)) =3D=3D 22);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/atc/test_creation_parameters", test_creation_paramet=
ers);
+    g_test_add_func("/atc/test_single_entry", test_single_entry);
+    g_test_add_func("/atc/test_single_entry_2", test_single_entry_2);
+    g_test_add_func("/atc/test_page_boundaries", test_page_boundaries);
+    g_test_add_func("/atc/test_huge_page", test_huge_page);
+    g_test_add_func("/atc/test_pasid", test_pasid);
+    g_test_add_func("/atc/test_large_address", test_large_address);
+    g_test_add_func("/atc/test_bigger_page", test_bigger_page);
+    g_test_add_func("/atc/test_unknown_pasid", test_unknown_pasid);
+    g_test_add_func("/atc/test_invalidation", test_invalidation);
+    g_test_add_func("/atc/test_delete_address_space_cache",
+                    test_delete_address_space_cache);
+    g_test_add_func("/atc/test_invalidate_entire_address_space",
+                    test_invalidate_entire_address_space);
+    g_test_add_func("/atc/test_reset", test_reset);
+    g_test_add_func("/atc/test_get_max_number_of_pages",
+                    test_get_max_number_of_pages);
+    return g_test_run();
+}
--=20
2.47.1

