Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E4DCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Ll-0008Hs-4q; Mon, 01 Sep 2025 09:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut2XW-0004LR-Sp
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:34 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut2XT-0004mn-75
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1756725451; x=1788261451;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QLbZveL5tR2lUE+q2IUmv659j1pVgSwc+BLIXjEPXtE=;
 b=gft2k2DyWaGHHyzUTmii1HlME79Slp8QwrlnD8BOQf3oFXT3dD7eDmnS
 x6/BA0kBDvWDW9y864JeT00stz17gVsjsxpJtvM3PkzckgjMSqzK57v7N
 gGL5CFTQ4EANxx79KF9Mc5+FyGx9kWk2cS5NrOgrv4dzD9zSnO85rQYJs
 oDZjQtzgSNwtqWDc/q5DoOJhXYc/gyv/j9n8pEwnZhy45UhALJpRRZBLC
 +E/p67Mv4aDbkxUqQ8emfLbfjEkUQibFyyNmm7/qqk+FrF+Op1uZzjfU2
 eLepuke7LjoThGFbB0rOrk57VZSHVileEnfnWzUmjOjtIJHjPAPtikLml Q==;
X-CSE-ConnectionGUID: ZeilBGHxRPK2Ue6XNfbs7A==
X-CSE-MsgGUID: S7hyr95oRGa0l4qgmMgiUA==
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; d="scan'208";a="42537904"
X-MGA-submission: =?us-ascii?q?MDEvOiaSgzsxrWGBNNw5IVb8KkbJY6ByIGBGp0?=
 =?us-ascii?q?LaMFzKw4x2ZmFKyx0QVTxtMOQg9PgpQ6F+prWFkHJcAtZ+EyYQKS9tNf?=
 =?us-ascii?q?YiNwZ5cEHDMj75Ym4o8uCWAUmb35P9NB5C8Z5IjEE6OE/iYY4prBx7+R?=
 =?us-ascii?q?CuQp3/gQ+OXnkmfY9il46gTg=3D=3D?=
Received: from mail-westeuropeazon11013070.outbound.protection.outlook.com
 (HELO AM0PR02CU008.outbound.protection.outlook.com) ([52.101.72.70])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 01 Sep 2025 13:17:27 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xidqM5dUj5ha8dwMWzaYI6DfjX2IBdyT8fAxQJbmLszEXGedAvz/7UlkX9IskdOnHQYgXoJKVGH+Rd51tZZaPPkP1ejtss3UfQJOVFLqrSaoxe3cRvNqA+HKb1cSkkJBwmfDkt4Hklekm/bpZHiRS0VhM1W8ZNlGnyqDsRAtJA3qW3Pf7CFhCM43qS63SIpzrZjQbLHIxued7Q2KOlrrFtMAvjuwEHW2tJCguAcp/Q2VwlRBDe4S5nIWKSan429VAd2t368bV5/IIr29yA0mrpIhn9VdUH9030209ELpO2Q79dN19RRiNLWmI2+nuQFTMPAXUsT1kCAaDVJXc0MK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nEKqgCMR9XJgI6KHDHIt1/lPAqf787DpiW4HvPJeOA=;
 b=EYvUasectYbqRvbbemaz86nMv3+12lvPw9QEEodPh+RwyNPKS29OiKmf7EXgA613d3kOoqhqlKL0S8hk0EziXpLqECvliAE52+PmxjGuAuQxxKkqwkyKfEQoui0BjmSZfF9WJny+KGB8PR+APZ1dSXlRzabjf6kVXafTwEiSYkwXqbRletG7PTBiMurrnSKSS3G7JAtdX38bwfsQDD8e2d3MPmR7C+JRUCIP9od9BQZfUdj1fF4zXolKDx78nQ7+tsixDlLFQ4B8VxzZiXFMlZhO7aWI2OjqlZWpGVD4Gd2Ksw6Y/Mz2ZRT+9yWu+gK8hGtEQTX9WKYghRT0vLaaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nEKqgCMR9XJgI6KHDHIt1/lPAqf787DpiW4HvPJeOA=;
 b=s6SuMisgnNA5q/nwT6LB+ckC/VuVnlXpdc4Kg7sR2VT+yhitGF5T9qUcSbxjUbFu7jnbWainyCLzd++/MVfRFwPKlTpM0hBvhSphFBbrHOWOwMWxy6gO3Uu8bTC7sYF6rvFP3KKs8IjGg0Ob9dWu3ix7tdtFtw5beKX/FHVqJoFcVp4SbwWtYBN3YSDrNi/O3AG5uN6rjueucsaA9+wGKBABQP92xpPugu6KovpqsYtOSesgANvtBQ5R1LkmSLJsJE3jTRL0ZbpMWbSVDBkzm95rJRyK+NP1/n4Xpp6utV38e8aCVfgetSnrsHxsEhgiDCK+f3mWYrOQyG95KEZIxQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB7614.eurprd07.prod.outlook.com (2603:10a6:102:c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 11:17:24 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 11:17:24 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 5/5] intel_iommu: Add PRI operations support
Thread-Topic: [PATCH 5/5] intel_iommu: Add PRI operations support
Thread-Index: AQHcGzH9nLem0fnInkK2eQ9NyJbFxg==
Date: Mon, 1 Sep 2025 11:17:24 +0000
Message-ID: <20250901111630.1018573-6-clement.mathieu--drif@eviden.com>
References: <20250901111630.1018573-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250901111630.1018573-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB7614:EE_
x-ms-office365-filtering-correlation-id: 0708f22f-424b-4626-adaa-08dde949207d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?UrQR2ciwKOhIAPHRNxfljZJ727CbUOsG9nGzqpTs1kMUc9d1KTQZdPtSi4?=
 =?iso-8859-1?Q?XWNVplBM/dMeOp5gVWVTao4G51vVrH5EO7u/wEL7I4WNo/WXcsFg3oky8W?=
 =?iso-8859-1?Q?feid23DQozaSFvtRoso+GsXzdhc180DQNUuftceDA3u2D/FG1x2wxJB/f2?=
 =?iso-8859-1?Q?p2TBst4hTUvltJ6MlQ88ExWjwMvhqSXCyuzZFYyd+FRgr3nUxY5sdpzFn3?=
 =?iso-8859-1?Q?0lS7L6lQ2Jk/DpaWzyW+QJNkyesCZ5yToThJKTFiHi69n5EWEqiJNizFSD?=
 =?iso-8859-1?Q?Nn6yI2z3kqz7sjeD26R3UWLvfhLsDeYeV08p1xORujYMwXtoh2rQuvEMDW?=
 =?iso-8859-1?Q?kI4HH/0AU+St8mPklTJrTz8Bqef7BezpgU0a1ZiuoG9wsYkkKcLDkHbEU8?=
 =?iso-8859-1?Q?xcMp2V8QBV1ofc/s5zTC9d0BXD2hmNSr3ROZZMRnCCJrfnfvPDXc1J0tKl?=
 =?iso-8859-1?Q?8Rbznlc1g7WgJyDfGqj1Uo0mM5/DBcD1JIpyauutGx4WQFq6uHe+PyTtir?=
 =?iso-8859-1?Q?As7fi29Cm/LpBLf0UN2e80dAvenW7a+DIldsbmwgTgqRPSl2bLXR0nLemw?=
 =?iso-8859-1?Q?3F5hSbRLc9OtSp/Xjxg8ysuOghFLb8UKtexfovivCVS3rX9sRNni3o+Vva?=
 =?iso-8859-1?Q?VO07PPg9Pb/TgryO/aV8a8Of7qyb8Cgzr1XmFpLPWVml6/0fn+QBhvY4cX?=
 =?iso-8859-1?Q?vtmnNOLOKVUchR3v2HlwrwiMz/OsM3fSLR7fsWlCfOPww0BomK50DpF4jV?=
 =?iso-8859-1?Q?LL2P8Z/ad6UKmhZpv6h2R+eGhPfvPxmdkG/hhxXJCrHOc4B2GSCJ/S9Tz6?=
 =?iso-8859-1?Q?RK5sagapWhVP/9rlSbppkl0bZzCR3YRkdFtn4dSlg6ZF4EOKDXbnciGteX?=
 =?iso-8859-1?Q?wBfCrE9hZekG+5YPS4wN12bSvjpHS+ZrVUkIJrKdLDHFsuqfkTs+b+58RA?=
 =?iso-8859-1?Q?3MY/xVlaGPg6JeZp6C0p9lmWBRSWhYT1COaeCGVI04THuafaMqVrRrvuJw?=
 =?iso-8859-1?Q?viWn5RtgJS5DhMAwCeRC+G3MJ8DnwOTqFxszurzb8cdBTdXTVk9JK5CJ7t?=
 =?iso-8859-1?Q?yvyCeDa6JJ8Tq62c/j8M560nm9DoyS8rZbSToGTWSGPLWN55aN1POz7pVK?=
 =?iso-8859-1?Q?0CSipcHD3VyF9MP0mNE+zeIGH7NrowdOVrypQBJlx7sHPlik2/AOmIF9gd?=
 =?iso-8859-1?Q?RO+j3OTbRl6p9sQv0lEiCknFBFcbYo9sVFlu36YolxCc+cdkIxDRKXHFB7?=
 =?iso-8859-1?Q?ouqmyKVcnRMYI+SkzVtEQJvVgtQ3Z+gQV258HkI+wpa79QGd8um8GakzFr?=
 =?iso-8859-1?Q?WPIptf/j1uvgT3CRh2JXlaZMln1KL3LGrOfh991ROJCVikJmDWF1okj3NR?=
 =?iso-8859-1?Q?aLySFTHNexNIhefgfqeVyPHsRb4V8NkePW5IfgGYbUWi4fhLpNFGeon490?=
 =?iso-8859-1?Q?Ml2Yj/4Y6NfVkjmObyiZo+hpBRlnMz9X0r2IfBM8JLTUMphyBKLKTIensF?=
 =?iso-8859-1?Q?Q2XcEFhO6le1a/U50ljHaU0tHHD8xevC/FaHsLhhP5Ug=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?koKMYdlyrPDcwJNwLIqC756620hRS/2+q3L2aYaujkHLYeSvHsZZiFeWRm?=
 =?iso-8859-1?Q?Jv/jxHlFU/4kkle7bvRI7gtB15i0IISLLFXgG3398dan7rxzhOklVVDZlg?=
 =?iso-8859-1?Q?nqclaasSLoWd1VsIzTelDP70tg+vUMrez7sCSqnFjcu9ozvDLEF6JUaaTL?=
 =?iso-8859-1?Q?ILxtfae1ueIKh+i+MreHpjTg36h/P3ezfG+pfo3IAi+SlwUXfePgeND43V?=
 =?iso-8859-1?Q?5tl2pKkyBBXuaWKboDZG3vlBA0IUQCuHWDARcBkjlS4WPBj908ixAF0qs5?=
 =?iso-8859-1?Q?5W+mFHpuSb6eU5RfRf9fSQr6iwbif6pL5LC5ycSF/zptBNtfULQpAH6A2K?=
 =?iso-8859-1?Q?PUO8kD1oBJPi53iOHonAQbI2zFRGw++dFSpnWwWXYszeKbytmyQs+MMVIX?=
 =?iso-8859-1?Q?3wupj78aVHXUyDY07yeNw3/bkwsgPoxXWSexCd//iGybMGmf6wU9FCLUXS?=
 =?iso-8859-1?Q?xVp3uoUacb9mCw+gB94233+oqvBCJddsLHNK9Tc2kAXKX30SvfTav2/xX0?=
 =?iso-8859-1?Q?mAw0h/AMq6M0+2lAg87zQy3EkOEMJx+iRKeAs/WQfNBlbNr13xsI2LKGNf?=
 =?iso-8859-1?Q?FJyu6cqL6dq43w30m51OYLY4L3RWVK0b1GtPeqZsOW2uZ2kaWiNOB+qXsC?=
 =?iso-8859-1?Q?WVN9bVTY4Sae8upD0I/bB4s80zRsltu54NX4pW5K3WShyeRWoRO7BHNlBB?=
 =?iso-8859-1?Q?TVu0x7u1mg0rJEAxtP6/Z2vEyPucZmNusWllq0UxqVu9so+uLvrkhRgw5d?=
 =?iso-8859-1?Q?cxz0Jm5LWfpx8Cp0b1w59/ELImznAqzxmfFcsGhg6w6fVhrwcSraHoEdhl?=
 =?iso-8859-1?Q?ePo68/6V3NeA2v10GblK/zoVwnZV0PXJdebqw50JsGNZYnzCwYDoTztF4Z?=
 =?iso-8859-1?Q?erqrqIPq0Cd0XFQ05nNMguuhLdB4uxy62NIJ/4SrzVnJoLNXkv+tMCSsEa?=
 =?iso-8859-1?Q?iYE38ZHRbs6cDpHORrhD5CHyj19AmHocxTzfSegj4PB/7lCaKmtuugYgZ4?=
 =?iso-8859-1?Q?/5aBt8qtr/XIc1NOsLDBxppj9ARetYR6U8JgCu6+yb1dprN1MlqeKee6U+?=
 =?iso-8859-1?Q?h+WS6RNUcinvMImQgbhB3HnBEEWoOp5qMMF9yEo5EcsEUa3gC4ICifNXKn?=
 =?iso-8859-1?Q?THF5FoIdCSWe/+JV1GK72Up+dPTPG7MrFJQ4mjKwIJE01Wmhkwqu41MYpX?=
 =?iso-8859-1?Q?ov2VwM8/g47yQUOjyX5IlGDw1oOZSvJu8zQSnvUKaD3kjKDs/y7c1itfMW?=
 =?iso-8859-1?Q?cc1v+MiFUCZhxNZsxipBVx1GdqJKWxnRQ4w+GuBI3UKGJLsopotHfRDKyJ?=
 =?iso-8859-1?Q?FK9U1EwOwDgXGhd1zGebSplnilGa2ynrBNmlbGKrCe6WP8iDCf8JgpkcvO?=
 =?iso-8859-1?Q?cQx1iY7LcYOB9/CBsO7oQTfLYRyCkrT266kuyZLt5PFHGoHItYz2asfML1?=
 =?iso-8859-1?Q?jTMkXD7PEkhxEUBHN2pRiwb133VmVF+SCCw37dDR42SABwnM3rK8Ujp8GT?=
 =?iso-8859-1?Q?IjG4hpwA4m3cCmASMFBcwWaWYoJrqWmB30bRWqHPSav//uuOkLsiJvIYH4?=
 =?iso-8859-1?Q?eXWQVbEj0J9lUlupbuvoxkeA+2X7iRHF9FvO5OKFeUew1coWdDTevedmL9?=
 =?iso-8859-1?Q?pZNB++OZvukRe15R0rzO0I8rFUA9Rx8TB/ERfTLS3Kn2kMqraE+kpwDCL2?=
 =?iso-8859-1?Q?e+tQTri8ElCr2/ZmxTg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0708f22f-424b-4626-adaa-08dde949207d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 11:17:24.2863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUv5N1SQj8tPoxsVLdpzYTXH22CTrS41fhkaiAfK9kFkwzyFkehZebC65NPfhyT+iaesaa++d00WlnHtWJ4JdyA3b9nwAd9i88HF+ysDgedDq1CHrvGXLT4qLb64AJcm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7614
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 01 Sep 2025 09:13:16 -0400
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

Implement the PRI callbacks in vtd_iommu_ops.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c          | 274 +++++++++++++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h |   2 +
 include/hw/i386/intel_iommu.h  |   1 +
 3 files changed, 277 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d952ec1428..2cc9bd5e45 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -45,6 +45,8 @@
     ((ce)->val[1] & VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK)
 #define VTD_CE_GET_PASID_DIR_TABLE(ce) \
     ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
+#define VTD_CE_GET_PRE(ce) \
+    ((ce)->val[0] & VTD_SM_CONTEXT_ENTRY_PRE)
=20
 /* pe operations */
 #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
@@ -1838,6 +1840,7 @@ static const bool vtd_qualified_faults[] =3D {
     [VTD_FR_FS_NON_CANONICAL] =3D true,
     [VTD_FR_FS_PAGING_ENTRY_US] =3D true,
     [VTD_FR_SM_WRITE] =3D true,
+    [VTD_FR_SM_PRE_ABS] =3D true,
     [VTD_FR_SM_INTERRUPT_ADDR] =3D true,
     [VTD_FR_FS_BIT_UPDATE_FAILED] =3D true,
     [VTD_FR_MAX] =3D false,
@@ -3152,6 +3155,59 @@ static bool vtd_process_device_piotlb_desc(IntelIOMM=
UState *s,
     return true;
 }
=20
+static bool vtd_process_page_group_response_desc(IntelIOMMUState *s,
+                                                 VTDInvDesc *inv_desc)
+{
+    VTDAddressSpace *vtd_dev_as;
+    bool pasid_present;
+    uint8_t response_code;
+    uint16_t rid;
+    uint32_t pasid;
+    uint16_t prgi;
+    IOMMUPRIResponse response;
+
+    if ((inv_desc->lo & VTD_INV_DESC_PGRESP_RSVD_LO) ||
+        (inv_desc->hi & VTD_INV_DESC_PGRESP_RSVD_HI)) {
+        error_report_once("%s: invalid page group response desc: hi=3D%"PR=
Ix64
+                            ", lo=3D%"PRIx64" (reserved nonzero)", __func_=
_,
+                            inv_desc->hi, inv_desc->lo);
+        return false;
+    }
+
+    pasid_present =3D VTD_INV_DESC_PGRESP_PP(inv_desc->lo);
+    response_code =3D VTD_INV_DESC_PGRESP_RC(inv_desc->lo);
+    rid =3D VTD_INV_DESC_PGRESP_RID(inv_desc->lo);
+    pasid =3D VTD_INV_DESC_PGRESP_PASID(inv_desc->lo);
+    prgi =3D VTD_INV_DESC_PGRESP_PRGI(inv_desc->hi);
+
+    if (!pasid_present) {
+        error_report_once("Page group response without PASID is"
+                          "not supported yet");
+        return false;
+    }
+
+    vtd_dev_as =3D vtd_get_as_by_sid_and_pasid(s, rid, pasid);
+    if (!vtd_dev_as) {
+        return true;
+    }
+
+    response.prgi =3D prgi;
+
+    if (response_code =3D=3D 0x0u) {
+        response.response_code =3D IOMMU_PRI_RESP_SUCCESS;
+    } else if (response_code =3D=3D 0x1u) {
+        response.response_code =3D IOMMU_PRI_RESP_INVALID_REQUEST;
+    } else {
+        response.response_code =3D IOMMU_PRI_RESP_FAILURE;
+    }
+
+    if (vtd_dev_as->pri_notifier) {
+        vtd_dev_as->pri_notifier->notify(vtd_dev_as->pri_notifier, &respon=
se);
+    }
+
+    return true;
+}
+
 static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
                                           VTDInvDesc *inv_desc)
 {
@@ -3252,6 +3308,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
=20
+    case VTD_INV_DESC_PGRESP:
+        trace_vtd_inv_desc("page group response", inv_desc.hi, inv_desc.lo=
);
+        if (!vtd_process_page_group_response_desc(s, &inv_desc)) {
+            return false;
+        }
+        break;
+
     /*
      * TODO: the entity of below two cases will be implemented in future s=
eries.
      * To make guest (which integrates scalable mode support patch set in
@@ -4864,6 +4927,194 @@ static ssize_t vtd_ats_request_translation(PCIBus *=
bus, void *opaque,
     return res_index;
 }
=20
+/* 11.4.11.3 : The number of entries in the page request queue is 2^(PQS +=
 7) */
+static inline uint64_t vtd_prq_size(IntelIOMMUState *s)
+{
+    return 1ULL << ((vtd_get_quad(s, DMAR_PQA_REG) & VTD_PQA_SIZE) + 7);
+}
+
+/**
+ * Return true if the bit is accessible and correctly set, false otherwise
+ */
+static bool vtd_check_pre_bit(VTDAddressSpace *vtd_as, hwaddr addr,
+                              uint16_t sid, bool is_write)
+{
+    int ret;
+    IntelIOMMUState *s =3D vtd_as->iommu_state;
+    uint8_t bus_n =3D pci_bus_num(vtd_as->bus);
+    VTDContextEntry ce;
+    bool is_fpd_set =3D false;
+
+    ret =3D vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce);
+
+    if (ret) {
+        goto error_report;
+    }
+
+    if (!VTD_CE_GET_PRE(&ce)) {
+        ret =3D -VTD_FR_SM_PRE_ABS;
+        goto error_get_fpd_and_report;
+    }
+
+    return true;
+
+error_get_fpd_and_report:
+    /* Try to get fpd (may not work but we are already on an error path) *=
/
+    is_fpd_set =3D ce.lo & VTD_CONTEXT_ENTRY_FPD;
+    vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
+error_report:
+    vtd_report_fault(s, -ret, is_fpd_set, sid, addr, is_write,
+                     vtd_as->pasid !=3D PCI_NO_PASID, vtd_as->pasid);
+    return false;
+}
+
+/* Logic described in section 7.5 */
+static void vtd_generate_page_request_event(IntelIOMMUState *s,
+                                            uint32_t old_pr_status)
+{
+    uint32_t current_pectl =3D vtd_get_long(s, DMAR_PECTL_REG);
+    /*
+     * Hardware evaluates PPR and PRO fields in the Page Request Status Re=
gister
+     * and if any of them is set, Page Request Event is not generated
+     */
+    if (old_pr_status & (VTD_PR_STATUS_PRO | VTD_PR_STATUS_PPR)) {
+        return;
+    }
+
+    vtd_set_clear_mask_long(s, DMAR_PECTL_REG, 0, VTD_PR_PECTL_IP);
+    if (!(current_pectl & VTD_PR_PECTL_IM)) {
+        vtd_set_clear_mask_long(s, DMAR_PECTL_REG, VTD_PR_PECTL_IP, 0);
+        vtd_generate_interrupt(s, DMAR_PEADDR_REG, DMAR_PEDATA_REG);
+    }
+}
+
+/* When calling this function, we known that we are in scalable mode */
+static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
+                                                 hwaddr addr)
+{
+    IntelIOMMUState *s =3D vtd_as->iommu_state;
+    VTDContextEntry ce;
+    VTDPASIDEntry pe;
+    uint16_t pgtt;
+    uint16_t domain_id;
+    int ret =3D vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                       vtd_as->devfn, &ce);
+    if (ret) {
+        return -EINVAL;
+    }
+    ret =3D vtd_ce_get_rid2pasid_entry(s, &ce, &pe, vtd_as->pasid);
+    if (ret) {
+        return -EINVAL;
+    }
+    pgtt =3D VTD_PE_GET_TYPE(&pe);
+    domain_id =3D VTD_SM_PASID_ENTRY_DID(pe.val[1]);
+    ret =3D 0;
+    switch (pgtt) {
+    case VTD_SM_PASID_ENTRY_FLT:
+        vtd_piotlb_page_invalidate(s, domain_id, vtd_as->pasid, addr, 0);
+        break;
+    /* Room for other pgtt values */
+    default:
+        error_report_once("Translation type not supported yet : %d", pgtt)=
;
+        ret =3D -EINVAL;
+        break;
+    }
+
+    return ret;
+}
+
+/* Page Request Descriptor : 7.4.1.1 */
+static int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn,
+                                uint32_t pasid, bool priv_req, bool exec_r=
eq,
+                                hwaddr addr, bool lpig, uint16_t prgi,
+                                bool is_read, bool is_write)
+{
+    IntelIOMMUState *s =3D opaque;
+    VTDAddressSpace *vtd_as;
+
+    vtd_as =3D vtd_find_add_as(s, bus, devfn, pasid);
+
+    uint64_t queue_addr_reg =3D vtd_get_quad(s, DMAR_PQA_REG);
+    uint64_t queue_tail_offset_reg =3D vtd_get_quad(s, DMAR_PQT_REG);
+    uint64_t new_queue_tail_offset =3D (
+                                (queue_tail_offset_reg + VTD_PQA_ENTRY_SIZ=
E) %
+                                (vtd_prq_size(s) * VTD_PQA_ENTRY_SIZE));
+    uint64_t queue_head_offset_reg =3D vtd_get_quad(s, DMAR_PQH_REG);
+    hwaddr queue_tail =3D (queue_addr_reg & VTD_PQA_ADDR) + queue_tail_off=
set_reg;
+    uint32_t old_pr_status =3D vtd_get_long(s, DMAR_PRS_REG);
+    uint16_t sid =3D PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn=
);
+    VTDPRDesc desc;
+
+    if (!(s->ecap & VTD_ECAP_PRS)) {
+        return -EPERM;
+    }
+
+    /*
+     * No need to check if scalable mode is enabled as we already known th=
at
+     * VTD_ECAP_PRS is set (see vtd_decide_config)
+     */
+
+    /* We do not support PRI without PASID */
+    if (vtd_as->pasid =3D=3D PCI_NO_PASID) {
+        return -EPERM;
+    }
+    if (exec_req && !is_read) {
+        return -EINVAL;
+    }
+
+    /* Check PRE bit in the scalable mode context entry */
+    if (!vtd_check_pre_bit(vtd_as, addr, sid, is_write)) {
+        return -EPERM;
+    }
+
+    if (old_pr_status & VTD_PR_STATUS_PRO) {
+        /*
+         * No action is taken by hardware to report a fault
+         * or generate an event
+         */
+        return -ENOSPC;
+    }
+
+    /* Check for overflow */
+    if (new_queue_tail_offset =3D=3D queue_head_offset_reg) {
+        vtd_set_clear_mask_long(s, DMAR_PRS_REG, 0, VTD_PR_STATUS_PRO);
+        vtd_generate_page_request_event(s, old_pr_status);
+        return -ENOSPC;
+    }
+
+    if (vtd_pri_perform_implicit_invalidation(vtd_as, addr)) {
+        return -EINVAL;
+    }
+
+    desc.lo =3D VTD_PRD_TYPE | VTD_PRD_PP(true) | VTD_PRD_RID(sid) |
+              VTD_PRD_PASID(vtd_as->pasid) | VTD_PRD_PMR(priv_req);
+    desc.hi =3D VTD_PRD_RDR(is_read) | VTD_PRD_WRR(is_write) |
+              VTD_PRD_LPIG(lpig) | VTD_PRD_PRGI(prgi) | VTD_PRD_ADDR(addr)=
;
+
+    desc.lo =3D cpu_to_le64(desc.lo);
+    desc.hi =3D cpu_to_le64(desc.hi);
+    if (dma_memory_write(&address_space_memory, queue_tail, &desc, sizeof(=
desc),
+                         MEMTXATTRS_UNSPECIFIED)) {
+        error_report_once("IO error, the PQ tail cannot be updated");
+        return -EIO;
+    }
+
+    /* increment the tail register and set the pending request bit */
+    vtd_set_quad(s, DMAR_PQT_REG, new_queue_tail_offset);
+    /*
+     * read status again so that the kernel does not miss a request.
+     * in some cases, we can trigger an unecessary interrupt but this stra=
tegy
+     * drastically improves performance as we don't need to take a lock.
+     */
+    old_pr_status =3D vtd_get_long(s, DMAR_PRS_REG);
+    if (!(old_pr_status & VTD_PR_STATUS_PPR)) {
+        vtd_set_clear_mask_long(s, DMAR_PRS_REG, 0, VTD_PR_STATUS_PPR);
+        vtd_generate_page_request_event(s, old_pr_status);
+    }
+
+    return 0;
+}
+
 static void vtd_init_iotlb_notifier(PCIBus *bus, void *opaque, int devfn,
                                     IOMMUNotifier *n, IOMMUNotify fn,
                                     void *user_opaque)
@@ -4905,6 +5156,26 @@ static void vtd_unregister_iotlb_notifier(PCIBus *bu=
s, void *opaque,
     memory_region_unregister_iommu_notifier(MEMORY_REGION(&vtd_as->iommu),=
 n);
 }
=20
+static void vtd_pri_register_notifier(PCIBus *bus, void *opaque, int devfn=
,
+                               uint32_t pasid, IOMMUPRINotifier *notifier)
+{
+    IntelIOMMUState *s =3D opaque;
+    VTDAddressSpace *vtd_as;
+
+    vtd_as =3D vtd_find_add_as(s, bus, devfn, pasid);
+    vtd_as->pri_notifier =3D notifier;
+}
+
+static void vtd_pri_unregister_notifier(PCIBus *bus, void *opaque,
+                                        int devfn, uint32_t pasid)
+{
+    IntelIOMMUState *s =3D opaque;
+    VTDAddressSpace *vtd_as;
+
+    vtd_as =3D vtd_find_add_as(s, bus, devfn, pasid);
+    vtd_as->pri_notifier =3D NULL;
+}
+
 static PCIIOMMUOps vtd_iommu_ops =3D {
     .get_address_space =3D vtd_host_dma_iommu,
     .set_iommu_device =3D vtd_dev_set_iommu_device,
@@ -4914,6 +5185,9 @@ static PCIIOMMUOps vtd_iommu_ops =3D {
     .register_iotlb_notifier =3D vtd_register_iotlb_notifier,
     .unregister_iotlb_notifier =3D vtd_unregister_iotlb_notifier,
     .ats_request_translation =3D vtd_ats_request_translation,
+    .pri_register_notifier =3D vtd_pri_register_notifier,
+    .pri_unregister_notifier =3D vtd_pri_unregister_notifier,
+    .pri_request_page =3D vtd_pri_request_page,
 };
=20
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index 04a8d4c769..0d0069a612 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -315,6 +315,8 @@ typedef enum VTDFaultReason {
                                   * request while disabled */
     VTD_FR_IR_SID_ERR =3D 0x26,   /* Invalid Source-ID */
=20
+    VTD_FR_SM_PRE_ABS =3D 0x47,   /* SCT.8 : PRE bit in a present SM CE is=
 0 */
+
     /* PASID directory entry access failure */
     VTD_FR_PASID_DIR_ACCESS_ERR =3D 0x50,
     /* The Present(P) field of pasid directory entry is 0 */
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index e95477e855..47730ac3c7 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -110,6 +110,7 @@ struct VTDAddressSpace {
     QLIST_ENTRY(VTDAddressSpace) next;
     /* Superset of notifier flags that this address space has */
     IOMMUNotifierFlag notifier_flags;
+    IOMMUPRINotifier *pri_notifier;
     /*
      * @iova_tree traces mapped IOVA ranges.
      *
--=20
2.51.0

