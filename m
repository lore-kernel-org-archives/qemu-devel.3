Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B5FCA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Li-0008HO-V6; Mon, 01 Sep 2025 09:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut2XU-0004KN-Sg
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:32 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut2XR-0004mQ-Gs
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1756725449; x=1788261449;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IRsktZ0RdbI0LklzhNw+41UVbOM4kCGPRGQw+LPafhw=;
 b=Ni7uXO9gohTOUsG7bGkjkoOfpTF7qw21mZvgTrY9aq8dIkg1Z6sP5Yl1
 dFT5qQ1vi4M9hJCvIvXfOA1cMbrBVG/4xk5PVtLWpbhyb/DbpkS9fe+mO
 UzuWDlwxREiCUDUaq3uYvdxiMT6b73QnZdUzMPd3Z6qTxHgd0LOuVWzsS
 iIXLgqC0jWPpzfK6zTUCct92DxZ3SXm9UjpoTIM2wbJHaoHw3ex7rK9US
 m+Ql81JsqAzqNR3EOu4SVt8JFU3sOTPfeaXi0a33iiYz6mZ7+QHodpx/k
 Bndvy71bwyaSNjkVeN+Emezr7Udb7kD9AYKcOLUoT+IZG2wZ5HPZfuyyp w==;
X-CSE-ConnectionGUID: 9cMGRzkCSPy+N14XnZ923Q==
X-CSE-MsgGUID: wpPxyo2oTYqYxu4SgDeSHQ==
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; d="scan'208";a="42537903"
X-MGA-submission: =?us-ascii?q?MDFB8pKe7WWdoQKv8l1rKoenGRzcsjc4gFf2kJ?=
 =?us-ascii?q?jgFQkNHk85853xegyxXNOFn/+DopUvNNnbQrzhBhyaiBHT/I7ANXCXcz?=
 =?us-ascii?q?UAAOtMHM2UwnPDxWRrcAXHli1Hr40EsSGgI644tpDntgJSQfpEG4XX29?=
 =?us-ascii?q?g+O9cS+Nu6xaZzbxmgAx5tWw=3D=3D?=
Received: from mail-norwayeastazon11013057.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.107.159.57])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 01 Sep 2025 13:17:26 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEg7a/4X5VMFaFukDatwftPzJl7wfzFg++9PieHT9LUCn9Vk6lVaWeHYznZ83BStQcqSkCiEuFhmS5YeXk5K2g6jNO3aAJVzp99hHh1GGmuy156rSRV47l5TPIjM1YRHXKbsMSxziM05VVlpNxhp7Xu1+NwxdhCSEx8yKX3jnmcH/EKHfRZi4x4NX6EHe0Y2c3qanC5vpicytWA+vh50n2Rm4lwbR9/J9+dkTRn6yPDIhBUW9hItWp9nBsaGfMSKEEcmDJzE+psF7NjoPVvvGpfdvPcDm9XKzvytf8bsLtu57RFqW4Yf94oEMUvhCykTKem2WCRm+s95cLFkb9Xz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7lra8Qws3rc1vggr8/JFdSGUSsRr6tA/GJCNAvJl60=;
 b=tpVsWNbqnTDN5c7NT+/q7gjONlxGtLF9SecsSWPiXidUFZ22JPEGZol1zSLgTkWoMxeoYfvxFhtf+/XfqxQnzpBaauEBUC4BNN5Bedjbxv2OCCltyncY8Ed8XR9mxZdpVwgvjjnJT1oYg3IUOolIibAH9N7v98mHKg1nvzViWWkZ1w8UCOjLuuRMzqOS8MTxoEpskvF1lwTIPSUmZevW2L3UUCcYgUWHOw6FaWYQB9N0GwPN+LL4ULHt3lmkek84ZNxa+EIWxN52Drg5rwS/ttyvOjCsIszwmESmGRf14yVuUM3FPsUTQGkAA1T+1DRvs7Vkk3BBcFdz+mAun4vlpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7lra8Qws3rc1vggr8/JFdSGUSsRr6tA/GJCNAvJl60=;
 b=RjdXKV9GQ8yR6LMes5Usmrn+l1nPDZ4Mrwy5VHCJIVtjJOQv61zgBhHTJLM1HA/Bwvuxuo75lIwI+/wJyIjveISu3+CKMsX8Q+RoP2N7Q0YfyEUP32xN+Oa8CptdbTf23nGJsPzpDogoPdgM6E9xmA3cjWF1IYM/rklKVHFr/OfUD9C+yFrmGkDuOEbeAKVXPwTku2zncnZxMahtrvTyizWD8e4EagtByIW0WqVCargC/j8IGzFW+Zo32joeVFnRsjVBFHTCzsW3nkA74YqavzaG9528+5P/65XZrM1ApihntJDnYL48TCfMP/tl+q6BFnxQNS8B8gMVQLz18vqJKQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB7614.eurprd07.prod.outlook.com (2603:10a6:102:c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 11:17:23 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 11:17:23 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 4/5] intel_iommu: Declare registers for PRI
Thread-Topic: [PATCH 4/5] intel_iommu: Declare registers for PRI
Thread-Index: AQHcGzH94De6bQrsNkmdssOEdWfIiw==
Date: Mon, 1 Sep 2025 11:17:23 +0000
Message-ID: <20250901111630.1018573-5-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: c03ab540-e663-4877-7a2f-08dde9491ff0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?P2UzomyJIRfIG+Z//hayP6XMPnqA3xU6j7FS0CjpbZUzmdOgj0a12yL7b9?=
 =?iso-8859-1?Q?81lTFBMBe5paZRFtM6br0Z5M12hvGpHETZCXB/Fqh3cQN224zKpW0+u1xh?=
 =?iso-8859-1?Q?x4qLtXXfyJxs0yrFkoIH+SBXNDExJr20TMU3qUu/0A58zFBWUpW2SKkX1j?=
 =?iso-8859-1?Q?uneFZKkZ8ZBSVKEhZHLFlbxk3GS1gNlPmOhvci9Zljh8dG90u85t24GG10?=
 =?iso-8859-1?Q?wOgcLL1hDkhpaU2nq0Vh/Y5nrV/x+lYXw02u8FIze80fetf0SAXqgNTcMd?=
 =?iso-8859-1?Q?xX2/Wp7WosPNclEVLSzzmX5pF0r27H72fPFJMxBPkfj7hbZ3jrcYyW6LKp?=
 =?iso-8859-1?Q?RNNJM+QBCBOuJ9QRdOR1PxH/nuRF9jIT0Qai9GSyj4O02x32nwipY0fA9i?=
 =?iso-8859-1?Q?zq4SndK5kMG7RxFxyNCVxLDLlhDMdZkMCLKoO/HPoAPCTgux00vFHSumDA?=
 =?iso-8859-1?Q?n/CSxFYseyvFziMzEArLwXQrs08opEtIi0ZwjdlBnvTzoS4qeu7zgG6Kyy?=
 =?iso-8859-1?Q?Cg/P25ZANwDegG8zNzYS4zaFNrO1gdIwhQ3i+ccjK1882IKb/iefcjuwve?=
 =?iso-8859-1?Q?9tU1QjiBuAAf1Sf6jiEiKBeFdP4Z+sMEygvytsuJOWk3s/kiqC8KZEbPN9?=
 =?iso-8859-1?Q?8ZDPdNatTqKMttR7+bx7lzqlnisny7kWdVaJv6Z/IB0XG79wzH7oYvQ6As?=
 =?iso-8859-1?Q?y6KItO92T+0n36BYIG88eLJaqjjkxiYiPqxXuij+HB4w74QGAKqVFz1cdZ?=
 =?iso-8859-1?Q?chY2TXEqrBa9NCauiMrDPXk/pDAeT+U8daxY6jnAv7bcvdc8pV55OhCWZs?=
 =?iso-8859-1?Q?9aDeSKSyT0TxmsSupiRANu5JJj1SFbaEO5iRJ2peHaVwYUMf7/mggfHsx2?=
 =?iso-8859-1?Q?v/29j7y5llUYJYe+Dh29jo0Vms0wrB3QurMy8YyrEZJBDJ23uVGR6ivIhN?=
 =?iso-8859-1?Q?ochmR2s0Y70C9/56M52SADf5eCV9Zu18O5grXBWlSuFgf3JQO2PecT/RW3?=
 =?iso-8859-1?Q?rseDIQ1nvE9fS6I2tsqR9+K/w066DHv+2fyLXKCshLla2443JHTNcz1+Ly?=
 =?iso-8859-1?Q?WXEdNkdwI84NnWA13DjpCAUxpBCKd2h+YjC2G11lXk3kZr0LLi5IGYZRVJ?=
 =?iso-8859-1?Q?6l0Zb9mQWtZxAHqOxnf+de6sB4oXJ8H667f70SmG7rWhh5Mc7yoplYLwBh?=
 =?iso-8859-1?Q?zFBI84ID9dzYSCkF3z+M7LSnp3brdUwW+LuzX4AaQO1IurJcmD81iIxjvk?=
 =?iso-8859-1?Q?/2tchEOXUcaDhAS/suNi5LrFPAVjxe/LxdM9ibQ+qSqbS9OevkU2p3fVWa?=
 =?iso-8859-1?Q?intQK7lPz1rcDuISIi2WFaLvrFegqHXu1D2r4mgCH8tLtja2XZi32+LfUk?=
 =?iso-8859-1?Q?YO4vfzkiK8eOR6K8JKuYaatkxneq77xddWpPn/lJTYFVCkMdv0jfat6tOJ?=
 =?iso-8859-1?Q?COyjXEsvbDlEXDE/tJGbRD/SIOyHzsDuZ17rvmmvzlymFilfuBjnyyXEyx?=
 =?iso-8859-1?Q?LMWhjosmqgV3dHfcMpD5nWwMEuy5SqLNkxPRzopOmY0A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g6EDH1ExG4kA0HKOQa7hh4Mqg01qnBFC+EkApDphADhIH0tAaA8Mj2HAnh?=
 =?iso-8859-1?Q?tpfCt5lfSSK6c1X03+l7HNIpdFlEhFPcNCTK2yFwxEzUV2tVshxeaiaCFp?=
 =?iso-8859-1?Q?XUJObyuBv+pHqrAhZngz1cSyXuUnrDWYxI4A8jkqWscXG4WxVigD7fy6r8?=
 =?iso-8859-1?Q?6KAci6PJM38mszYuOCoH+ZMbL6Ssibpyq5bpQ+aP8RUnynl92j8SQTrkTE?=
 =?iso-8859-1?Q?gVG2LjSBnR7hqy40Xf5/iwNKwEj4TUo2hIK6CUynD4aA4I367jnvgjE3E3?=
 =?iso-8859-1?Q?JgcNYAru2/IniwPWch0QDuBu09YKdJuAIR2ooRzF/fBJIIOxmwuuNZLaUV?=
 =?iso-8859-1?Q?UMJ/eE4VZWrTZohEKUFEiggFOOZGEYs+VH5e4eivzlJwNFOYipETZYutoG?=
 =?iso-8859-1?Q?Md+tYm7kBkVT36zozwKQm3MNOPQpTzqFwgQqXBx9gf0pea+3KkcT/+bXZ7?=
 =?iso-8859-1?Q?7rDljnIPL5R6FiQTwkWjSfdRDN3bx4k53bUL9XyxeJVk256sh9858gDzWe?=
 =?iso-8859-1?Q?U+YafOHrMBD5Z5PairivL8rTsdjmok4GG8CxiVrHHC/2+I/sMFZeAQhc1B?=
 =?iso-8859-1?Q?8oB+pHC1OtvPlMcbGfq0w69rxJoAuv6WRrNqtsc1vGotB+OxCMPbsF6zeR?=
 =?iso-8859-1?Q?S4msWtSJ/v0uIsztvnLpvilZIF5mrl/cVmkDHAni4b79cOMfdtWwAdhu5c?=
 =?iso-8859-1?Q?X4BOUNy7v/N0C1qxsqyoqsOa4rZX7F+mqo5G3cd8KF+PEVBVf2lTBbqt/j?=
 =?iso-8859-1?Q?dP3D9GcT/7Dq6A4TC+TWLxOzU6rnRwnzeysqJeDn6Y1w0pREC0/iNiHV5C?=
 =?iso-8859-1?Q?kKEU4urCtIISCCWei8+1/5NjdMpl6F+3pIBOk4Ct8d17f+0OUTcDMR4tlr?=
 =?iso-8859-1?Q?23FLMCuGFTxbCTJt3+26N4LmHQtYG6viVzS+GLzXgdxQCMbdRD6yUCHVwG?=
 =?iso-8859-1?Q?MAftjI3MxPeLuvLnY+I5DNUL2dz6iHStj0j6bEqhjHM9smXJIrcWLtZgtV?=
 =?iso-8859-1?Q?GyyX08r9rk+vXmOhlN7nw3YaFqgQdegAdq66Fcq7eZ5FUF6xQVKkyZmeKe?=
 =?iso-8859-1?Q?pj1wwG+CfPkiQjt9Rp2yIGmM0ZD4mSZzt5klVQWL1+oyQcdV3MzvzhXCwL?=
 =?iso-8859-1?Q?aKeHryzPHsDCvkEtQvhvCilPI0KsiMHXdFP5lkuaOfbY5TjHDGhqxIurzp?=
 =?iso-8859-1?Q?btbh11Dis+Zc7M6ESFrZHc5/RCRoir1N0mBO7xr43kQjck4bKNcG3cINyS?=
 =?iso-8859-1?Q?SPlS/mrIbRewJjxJdB0jxBUXNTVCK2a9scMjO3XMgUNqJYns0gESKzdmn5?=
 =?iso-8859-1?Q?bQbezudzJl+IFJEihPzvAsBF3laCMi97uRJJ+xRqgsMIEbudxdyoAUhkTg?=
 =?iso-8859-1?Q?mBwP4xXYhArtPRveaqqGE1q1KUAgB1vNwl43nVU5O9mSJMwPIfkOJIww91?=
 =?iso-8859-1?Q?0fKLaKUYn1GXe2C9CM5A27xgJfeohwgirf4ExX7rg6jHR1onjstzPl0wSv?=
 =?iso-8859-1?Q?3lCuVDDnQo1OWMvOvCEAmRinvLxiNgB+x3sIcS2utNUuvMbGEIhvzZB4Oh?=
 =?iso-8859-1?Q?hN1922+vwhIF4oXFDD+dHihmlMsBIfjgkb11QA7vMSTbYf5vVNa/hwO7Ld?=
 =?iso-8859-1?Q?XPqnYgyT6yHn+4Zus6X3wZtnboIE2Uotc9U0VZaq3kQ9CxBegZturMEG8q?=
 =?iso-8859-1?Q?Ws2THr1cel1JdvugjrU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03ab540-e663-4877-7a2f-08dde9491ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 11:17:23.1233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmz0z03rnV2PTr/GHS2rwPtNVIGj1yZf7/8QMLeDykkBTHefM7Gkeqd9s8mE5U0ZFg19paipaPGSW85nl7vqVHa+YSN5HdVx0JXLMHAfTGad5//v4RCS0RAfm3QS0c8Y
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
X-Mailman-Approved-At: Mon, 01 Sep 2025 09:13:15 -0400
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4e7ad3a290..d952ec1428 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3386,6 +3386,27 @@ static void vtd_handle_iectl_write(IntelIOMMUState *=
s)
     }
 }
=20
+static void vtd_handle_prs_write(IntelIOMMUState *s)
+{
+    uint32_t prs =3D vtd_get_long_raw(s, DMAR_PRS_REG);
+    if (!(prs & VTD_PR_STATUS_PPR) && !(prs & VTD_PR_STATUS_PRO)) {
+        vtd_set_clear_mask_long(s, DMAR_PECTL_REG, VTD_PR_PECTL_IP, 0);
+    }
+}
+
+static void vtd_handle_pectl_write(IntelIOMMUState *s)
+{
+    uint32_t pectl =3D vtd_get_long_raw(s, DMAR_PECTL_REG);
+    if ((pectl & VTD_PR_PECTL_IP) && !(pectl & VTD_PR_PECTL_IM)) {
+        /*
+         * If IP field was 1 when software clears the IM field,
+         * the  interrupt is generated along with clearing the IP field.
+         */
+        vtd_set_clear_mask_long(s, DMAR_PECTL_REG, VTD_PR_PECTL_IP, 0);
+        vtd_generate_interrupt(s, DMAR_PEADDR_REG, DMAR_PEDATA_REG);
+    }
+}
+
 static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
 {
     IntelIOMMUState *s =3D opaque;
@@ -3428,6 +3449,11 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr ad=
dr, unsigned size)
         val =3D s->iq >> 32;
         break;
=20
+    case DMAR_PEUADDR_REG:
+        assert(size =3D=3D 4);
+        val =3D vtd_get_long_raw(s, DMAR_PEUADDR_REG);
+        break;
+
     default:
         if (size =3D=3D 4) {
             val =3D vtd_get_long(s, addr);
@@ -3491,6 +3517,11 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         vtd_handle_iotlb_write(s);
         break;
=20
+    case DMAR_PEUADDR_REG:
+        assert(size =3D=3D 4);
+        vtd_set_long(s, addr, val);
+        break;
+
     /* Invalidate Address Register, 64-bit */
     case DMAR_IVA_REG:
         if (size =3D=3D 4) {
@@ -3671,6 +3702,18 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         vtd_set_long(s, addr, val);
         break;
=20
+    case DMAR_PRS_REG:
+        assert(size =3D=3D 4);
+        vtd_set_long(s, addr, val);
+        vtd_handle_prs_write(s);
+        break;
+
+    case DMAR_PECTL_REG:
+        assert(size =3D=3D 4);
+        vtd_set_long(s, addr, val);
+        vtd_handle_pectl_write(s);
+        break;
+
     default:
         if (size =3D=3D 4) {
             vtd_set_long(s, addr, val);
@@ -4722,6 +4765,18 @@ static void vtd_init(IntelIOMMUState *s)
      * Interrupt remapping registers.
      */
     vtd_define_quad(s, DMAR_IRTA_REG, 0, 0xfffffffffffff80fULL, 0);
+
+    /* Page request registers */
+    if (s->ecap & VTD_ECAP_PRS) {
+        vtd_define_quad(s, DMAR_PQH_REG, 0, 0x7ffe0ULL, 0);
+        vtd_define_quad(s, DMAR_PQT_REG, 0, 0x7ffe0ULL, 0);
+        vtd_define_quad(s, DMAR_PQA_REG, 0, 0xfffffffffffff007ULL, 0);
+        vtd_define_long(s, DMAR_PRS_REG, 0, 0, 0x3UL);
+        vtd_define_long(s, DMAR_PECTL_REG, 0, 0x80000000UL, 0);
+        vtd_define_long(s, DMAR_PEDATA_REG, 0, 0xffffUL, 0);
+        vtd_define_long(s, DMAR_PEADDR_REG, 0, 0xfffffffcUL, 0);
+        vtd_define_long(s, DMAR_PEUADDR_REG, 0, 0xffffffffUL, 0);
+    }
 }
=20
 /* Should not reset address_spaces when reset because devices will still u=
se
--=20
2.51.0

