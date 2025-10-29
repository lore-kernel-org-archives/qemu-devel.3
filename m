Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE364CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3md-0007Tw-1z; Wed, 29 Oct 2025 06:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mY-0007TR-4N
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:51:59 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mT-00020O-6M
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1761735113; x=1793271113;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HFE61P1OFfDFiIpHPDMpJrt0NO1TiaMw1ZPv4MIKBEQ=;
 b=sm1FLBu/SusvvA9bKQDpI8ytha///7E18g8mrFTcf4w9toYclVAsEJKI
 /lK2oLp9S9vKn018XaYh+CmgWet34cD3Qqh8FyYyBJTKRqTL2IQDqUcyq
 G/GFE2a8Shfv7X6EID24A0zMLWSLU+VSA1VCmzpLrzh21vlS/RZquE5/U
 JoNKAd4djYleeaFYicIP46EhC3BtZoeQHJB8NOQAfJBbOwQNdgbGeI8fS
 VOfHBc/l0a7DtY/yEhiYLWtJqkK89k5qVgUNlSGywHBOCVXbpM8g9CBJn
 ADPqZzTX6zedNbm5CdRYKSkU3x8OMIk4zrQcHIO782KMJnMemosiutq6f w==;
X-CSE-ConnectionGUID: efSW2KrfR1eWnCmQgXfw7A==
X-CSE-MsgGUID: 6IaV9S5fS4mpDZDLoPcMwA==
X-IronPort-AV: E=Sophos;i="6.19,263,1754949600"; d="scan'208";a="44178950"
X-MGA-submission: =?us-ascii?q?MDG6FKAj0Gt0v/DXB6N638J4/CVv6uklR48JzO?=
 =?us-ascii?q?drR4XfT6nAhbof7z0EYNuTbEvcV6DgmuQV+PAvvvi4EeIf8IpsaT6O2q?=
 =?us-ascii?q?IVtV5x9RthLzKBHUuh6Vz+LpLocmUwMhrhCrXhRPAUpggqLLhtdOaCYN?=
 =?us-ascii?q?iNTAvuUf6vsvx910nFwtG4Sg=3D=3D?=
Received: from mail-northeuropeazon11011056.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.56])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 29 Oct 2025 11:51:45 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7T+qF2g/vL08cs7WIJIj3DAax5puYo/AS/q14yTMStG4fu0Uw55ac8B5Xl8gjmYpbxcr1AX4Uka7brXIPrnfWkbjO+7N8Nu+I9kmRexemUrkgCshXkbnfZl2DcvkZFkCeeGpe+d809tQlM2jQoQrh2it9CVxBr4XqqSrRz9ZvJZRgYnS8Y/kWhmjJNck+1mZNPTiccijhxmdOQE4feCpL2UrkU50s4wPqXWe+UvnUUAaC1kKpDjxuRerzzG/SQAq2dj6o5JgE72krqJKrcMLiX19Fg3iwPptWcdCDGZqxV/eS9VetZ0O9v6V0GI1+fredkvumO1ditjuY8Ye+qzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xTZVX8JkDpSMb2ssZAqHMXi+NOdnR7rSw4AuizWaMA=;
 b=WqA1kr7Hj21yX0yE7lXv36JBYgtQ+f/7RiSmZleWiinPcnqgTkZr7KUx0OsJUtUAL4VQYtvyEHrZY789vxOiYk+Yl19S6E6YpzYvUbeU28m5tlrOXRVs+vheS5Bw97YxwSDGQgsetdSDKJ0/mSvJ1A9OA8OSY9LP/LoG2kWF0ECrX/+lezrcjfozvFZpFEW/AKITIPOCo+YciGtjAC9R9VPv+4z5W9XQRiynaiXXbNe3LaZN0kDP6o6DOlPfk3wU0S49YBVDegkr1pCsbqXwUFtnDt6PGm5nZqJ/LPpDiM691V8Y3CAEnF3oq2c09Xqk8cU3O04goUmymxXIRueedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xTZVX8JkDpSMb2ssZAqHMXi+NOdnR7rSw4AuizWaMA=;
 b=QOKe8Wbfte+grJnaB7bYgCypEnGuz+vXjwDoH6qWjrsSDuvwqlifd1zEm1vGhlCnldERFaGPJBdAxC9o1N4Vjz1ZtgAM1H3KxhnBfeA3MMaBJNThyhoL779LGvWEue3YXMw3P0UDC2uWM5mynDRSkq3w0we/Onp34EzukArgAjsEiM5Oxl37zxQgMk0LMlyPL+21NnO34zjllv+NH80sLKZEwIyAIN7CGecn0k+l0LTc2oADiTGMMFQT20ejtZckMH+omU5HGQFINaFI4eCSrLgOxRmlPdeZeRFYUKQgkxyWRQgbrXSEJVoatq/p/D1l6G1mklKKfvi4WFYgnH+BSg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI0PR07MB10962.eurprd07.prod.outlook.com (2603:10a6:800:2d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:51:42 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9228.010; Wed, 29 Oct 2025
 10:51:42 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 2/7] intel_iommu: Support memory operations with
 pre-translated addresses
Thread-Topic: [PATCH 2/7] intel_iommu: Support memory operations with
 pre-translated addresses
Thread-Index: AQHcSMIDdwzMO10C60iYsdMIEMCpfg==
Date: Wed, 29 Oct 2025 10:51:42 +0000
Message-ID: <20251029105137.1097933-3-clement.mathieu--drif@eviden.com>
References: <20251029105137.1097933-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20251029105137.1097933-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI0PR07MB10962:EE_
x-ms-office365-filtering-correlation-id: 12503583-188e-453b-af8d-08de16d92596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?g/JCYrDUqwbGuYVqhJ6AUBTUbnZSdUtmLXphWDOQ1Ok3jCq4YBuu6De7Pg?=
 =?iso-8859-1?Q?ryW+ZcKVTu7crGDKZUrQ+tOcAVPO9HYuPerXCsddM8r0x20zuCzgl/E8Hm?=
 =?iso-8859-1?Q?iygew0NO1t87xEvAd/CjSe9ScC7OE9b2XNieaV1kpXSmGRx3gy4blXM4hg?=
 =?iso-8859-1?Q?VF3lCMZyiDkdxrEXQ3OBP4GbpFYQAZcswfxi607V+5Hvplm06ute8j+15K?=
 =?iso-8859-1?Q?0qXGQLIZ5gxAsupGwXHSnA18tFpO993qE9lHwyzKKUaTTrxxbWDyp6n6V2?=
 =?iso-8859-1?Q?+zNKC7uimtdyPcwjgrw3U3ZYjqEaUKaWRPxr//9CgmrIJ0aR0tmAlUgpsk?=
 =?iso-8859-1?Q?Znmb8lqEOgO2Buc5phtR6D8w8DBEgmQMYfwGAJwmNbit5HU3HMQyxNCzz1?=
 =?iso-8859-1?Q?7N3BfIUAibN0C+fO+cm9J6IEEKmf5IbzdwIE5IYh8my0L+AdfsBAXCOApX?=
 =?iso-8859-1?Q?eAWSrCorCTWmJQG6L7cUQzes31zqXSMZPaHNEgV+9M6bI53WBVXClU4cBb?=
 =?iso-8859-1?Q?pl+zD13Mie4713I2a1I8BYW18sIdsNSdUCllh9Y8OebjkvqzUyBOtP3aJ9?=
 =?iso-8859-1?Q?vsgoEucVbe+mTzcu4mRpUSEXBgSNVwD0eXz5LFuiQbfCyb77eaAtoSKytd?=
 =?iso-8859-1?Q?bKR4Qs/vUtpjO+yxNoWAIjK0ZwsSGhBvjygXev3d1C7sADj7ahvEF6H/L0?=
 =?iso-8859-1?Q?/eo5siQHdODP+Wmj91bO63BkMDRwKEmiyiXHMJBa+GTxsBLH5O7oTA3xZV?=
 =?iso-8859-1?Q?rvn6gPvLn80XbMkYTFVUEImkm5XM2zxi4KZNyKNSj8vh2+u5XX7CrPbsLz?=
 =?iso-8859-1?Q?1bF0KPHHN3RNyiHkUaMeRQ89v5zA3EIVsn8iOUb+zHMihcSoe6d3sCiNLr?=
 =?iso-8859-1?Q?ESf6PAETBzXi2mDoWwiwHgGYcqaZeldxzLHZoRIHgPQl8hl+xuWH7I/p2O?=
 =?iso-8859-1?Q?NytMD5PfRJ9n7+nSmVkoMWkyIqCYhuWpEi8bPd/AzYbkJLSsOwXY2Cwuak?=
 =?iso-8859-1?Q?ChPSviIqfVUv8iA2J5qCTJhqIFxpQumi4fiw1ju71R+C4qLaJ6+yisc2Dt?=
 =?iso-8859-1?Q?G5I38ulhj2xMD1cjTcCQiZuDOMy5FBDCF6oqgrqkyoeC8nNUaTkOKfaK3n?=
 =?iso-8859-1?Q?jeiTe5FD5/B1sCID6s9nN2ziGb0wlY8UkNumJxukp36kruX9zQRdlkLUgf?=
 =?iso-8859-1?Q?6mJwXk2WWuGWlk7dBTFOthNy/mU26BRo3IfsMsCdo2WbctUBSO6onmLy4l?=
 =?iso-8859-1?Q?rjun0Yzq1CaRS899z1Z3Lixh9+2EyfD7l0BZhzVjPfdv/4gjE1kVL6dE7Q?=
 =?iso-8859-1?Q?4YSABn2Fv6xQlqmpWJh2FGkMrVvDFB4LKb5kbTMSr4F9kZLaVmSXeCqdEw?=
 =?iso-8859-1?Q?3kLy4C9uns+ylF+ObmCRclDCs/w/bu/hzhUSU1z01rSwKn3Ge6xJFTx3Un?=
 =?iso-8859-1?Q?Ek4e60+Bl2iobEjavb+29CgFwFmjo+Zmv+rNqnYNcoTvmqq1LjO5CyIOYK?=
 =?iso-8859-1?Q?WWGI6+y8DkDUWDcWFBrLmd/sDSincbckhszBbYCoUFPCNx3IEIpQ+woynI?=
 =?iso-8859-1?Q?PYcDYSlaouKABxW1VdaCPzoeXYpM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oKf/wDSnqPAKgznKgya0/y2PLzD5kYqETQbk8APasCVxkmdnHcJ2e5JXyG?=
 =?iso-8859-1?Q?kmoHBhE7nPWz+Vm0tlnzmQpxuGATNPVDfi57/y6FCHibhoHupWHlNoNOIM?=
 =?iso-8859-1?Q?OqCE81/NsK3e7Sd1+XpPy5wcjVZtdOxmMUwDuBJwGxz/XHnd72PYt+6lvG?=
 =?iso-8859-1?Q?0JQo6W3E2XTRz3jrt7FT5PG+NmLl5c217Zff9o9WcLdJI2nFgCM76tnGc1?=
 =?iso-8859-1?Q?qpkRJ2oeP2rwwGTmBHgIb7qYN0jG3vCum9iG6I21tE3Mc2WfPNQOHYIxAG?=
 =?iso-8859-1?Q?v/DiqFj2+Nr9AARIvJMHQ2gwlN3sVcw6CWXDiT73TRyoii2h59SBdH0bH+?=
 =?iso-8859-1?Q?0lvjYXQHC1tR3iHklPh1pWYaSZtzyOZP3CzAt88H6GSCVEbtFH+GDN5zNC?=
 =?iso-8859-1?Q?Ho6y+94clt0wy28DUvOf4oq7jj0nAX5t/Jc1FH2CK/wHxliNbZZQPz9oau?=
 =?iso-8859-1?Q?8W8oUy9VD6CfKIEylOsdxhVg4fgh0fZpoFCXpwLMaIbnwqqVdtSQ92beXx?=
 =?iso-8859-1?Q?o8Z6dLgdQ/x/VZXxEVQkLOR+CdsYWAzuwT10P2BEalikolJGOhWDY8TSxJ?=
 =?iso-8859-1?Q?zt9/vUEofGXE2rHKESW9k9rhEZjYOdHnrKeTJgMbpED/sdP90jClrsLIbI?=
 =?iso-8859-1?Q?lOGYGgBoUkLLBC/F3ahkES0zTMquQqnFIyebmliBdUBhbtf6RRWNpV+hXa?=
 =?iso-8859-1?Q?Vf0qQK9bWVPdb0PFGX1L6lpnJb47icHXbykvlXhIpj77ZelKDCk61Plugg?=
 =?iso-8859-1?Q?BaxWZ8G1UU3L2mzjkT/e4NZlKv8FPZiKvRDJKvTtKg7IAW/lFluI0QWUnt?=
 =?iso-8859-1?Q?akQuMhy/PEC+mct0IonJwMNyThSN8goIr75tggK0vd2OzTTVXvN9RM+6fQ?=
 =?iso-8859-1?Q?C5iMp514haFs0Ez0umfzsPl25oZdFk2Ypqg4qjpxqKWIQYxR9u4mOB+oK2?=
 =?iso-8859-1?Q?3yvAKCnUZ5mt6hzl+1xNZZv6g4oVd76k81L04SltvGdwvYKn1czIU5dULu?=
 =?iso-8859-1?Q?+a85iOY3HYOpVf9hJnyzq+T6k6YUG6AfU9XaQVKGvqoViKGxXaVMPVyYZa?=
 =?iso-8859-1?Q?PYwvK4kkq0eT/Tyw4xixcq25ryQLfiFhESYaTnKtOCC8+ZHEf44QxRpMyU?=
 =?iso-8859-1?Q?F9mqJfahmgxOW870PL6+oFhCXCmWcGrbb01or4Vj1DQHaIKWqUvQAywrP7?=
 =?iso-8859-1?Q?TFWQbr76ql9ukb72kl+5hcyTUgH1FMLA1Mj2cD649J1uRJk8ipXKA/KB03?=
 =?iso-8859-1?Q?2YwzWA3xJ3NCMjvLQhYdl4E0ZuFh0YLmGv5Awqh/RpMuQNsz3Y0Z+JkuDo?=
 =?iso-8859-1?Q?j7deJ3VBKBxtSJdmC6HanaBQN7Ublagf7Ogh/szMsUPhBJ5ftazLHVJxeQ?=
 =?iso-8859-1?Q?PDV3bo2S/Xryg0MKlMWCeTEJVuRlHUemBjm6wyzcqeEvFrskGsBba0nkaN?=
 =?iso-8859-1?Q?lmGLKyv1ED3BYxUhbu9LMxyipLijbUeZ5QNWE5W9WWJ2Lj81rcw82Y9Ruj?=
 =?iso-8859-1?Q?Wf022C4B3ZMglEMAe8rmwLs3fqV238Psi53Lcal/syPcFNttUwzrOr6X9s?=
 =?iso-8859-1?Q?E8vG400xK4/GJ38XUAw1QcBsI+qmW0waEck9jU9lFvThUOgaCdXSUUone1?=
 =?iso-8859-1?Q?FWZw08Mc1m+yXB/LvhvtsQIP5NLVYzo+hurkYBmtrGdL5DVnuAjJGx7LtX?=
 =?iso-8859-1?Q?LuJb2AxtZOHZj2NQ9Zo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12503583-188e-453b-af8d-08de16d92596
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 10:51:42.6650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62LvGeYnqIKXRg6wUFjVUWmNitEwc4oIJ9YwHc9DuTfrGupQUv0sYwzl5UDB8iOzjGkgDEPC9txsZZ2YTcVDRgMR8YfL+Z3Tq8Oj5MsTLe9SL6/Vn2ZUMEbToQ3lk0Es
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10962
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 118 +++++++++++++++++++++++++++++-------------
 1 file changed, 81 insertions(+), 37 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8dbc4ea508..9753f4bb75 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3779,6 +3779,25 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
     }
 }
=20
+static void vtd_prepare_identity_entry(hwaddr addr, IOMMUAccessFlags perm,
+                                         uint32_t pasid, IOMMUTLBEntry *io=
tlb)
+{
+    iotlb->iova =3D addr & VTD_PAGE_MASK_4K;
+    iotlb->translated_addr =3D addr & VTD_PAGE_MASK_4K;
+    iotlb->addr_mask =3D ~VTD_PAGE_MASK_4K;
+    iotlb->perm =3D perm;
+    iotlb->pasid =3D pasid;
+}
+
+static inline void vtd_prepare_error_entry(IOMMUTLBEntry *entry)
+{
+    entry->iova =3D 0;
+    entry->translated_addr =3D 0;
+    entry->addr_mask =3D ~VTD_PAGE_MASK_4K;
+    entry->perm =3D IOMMU_NONE;
+    entry->pasid =3D PCI_NO_PASID;
+}
+
 static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr =
addr,
                                          IOMMUAccessFlags flag, int iommu_=
idx)
 {
@@ -3790,16 +3809,29 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemor=
yRegion *iommu, hwaddr addr,
         .pasid =3D vtd_as->pasid,
     };
     bool success;
+    bool is_write =3D flag & IOMMU_WO;
=20
     if (likely(s->dmar_enabled)) {
-        success =3D vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->de=
vfn,
-                                         addr, flag & IOMMU_WO, &iotlb);
+        /* Only support translated requests in scalable mode */
+        if (iommu_idx =3D=3D VTD_IDX_TRANSLATED && s->root_scalable) {
+            if (vtd_as->pasid =3D=3D PCI_NO_PASID) {
+                vtd_prepare_identity_entry(addr, IOMMU_RW, PCI_NO_PASID,
+                                           &iotlb);
+                success =3D true;
+            } else {
+                vtd_prepare_error_entry(&iotlb);
+                error_report_once("%s: translated request with PASID not "
+                                  "allowed (pasid=3D0x%" PRIx32 ")", __fun=
c__,
+                                  vtd_as->pasid);
+                success =3D false;
+            }
+        } else {
+            success =3D vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as=
->devfn,
+                                            addr, is_write, &iotlb);
+        }
     } else {
         /* DMAR disabled, passthrough, use 4k-page*/
-        iotlb.iova =3D addr & VTD_PAGE_MASK_4K;
-        iotlb.translated_addr =3D addr & VTD_PAGE_MASK_4K;
-        iotlb.addr_mask =3D ~VTD_PAGE_MASK_4K;
-        iotlb.perm =3D IOMMU_RW;
+        vtd_prepare_identity_entry(addr, IOMMU_RW, vtd_as->pasid, &iotlb);
         success =3D true;
     }
=20
@@ -4201,6 +4233,37 @@ static int vtd_int_remap(X86IOMMUState *iommu, MSIMe=
ssage *src,
                                    src, dst, sid, false);
 }
=20
+static void vtd_report_sid_ir_illegal_access(IntelIOMMUState *s, uint16_t =
sid,
+                                             uint32_t pasid, hwaddr addr,
+                                             bool is_write)
+{
+    uint8_t bus_n =3D VTD_SID_TO_BUS(sid);
+    uint8_t devfn =3D VTD_SID_TO_DEVFN(sid);
+    bool is_fpd_set =3D false;
+    VTDContextEntry ce;
+
+    /* Try out best to fetch FPD, we can't do anything more */
+    if (vtd_dev_to_context_entry(s, bus_n, devfn, &ce) =3D=3D 0) {
+        is_fpd_set =3D ce.lo & VTD_CONTEXT_ENTRY_FPD;
+        if (!is_fpd_set && s->root_scalable) {
+            vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, pasid);
+        }
+    }
+
+    vtd_report_fault(s, VTD_FR_SM_INTERRUPT_ADDR, is_fpd_set, sid, addr,
+                     is_write, pasid !=3D PCI_NO_PASID, pasid);
+}
+
+static void vtd_report_ir_illegal_access(VTDAddressSpace *vtd_as,
+                                         hwaddr addr, bool is_write)
+{
+    uint8_t bus_n =3D pci_bus_num(vtd_as->bus);
+    uint16_t sid =3D PCI_BUILD_BDF(bus_n, vtd_as->devfn);
+
+    vtd_report_sid_ir_illegal_access(vtd_as->iommu_state, sid, vtd_as->pas=
id,
+                                     addr, is_write);
+}
+
 static MemTxResult vtd_mem_ir_read(void *opaque, hwaddr addr,
                                    uint64_t *data, unsigned size,
                                    MemTxAttrs attrs)
@@ -4212,9 +4275,11 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hw=
addr addr,
                                     uint64_t value, unsigned size,
                                     MemTxAttrs attrs)
 {
+    IntelIOMMUState *s =3D opaque;
     int ret =3D 0;
     MSIMessage from =3D {}, to =3D {};
     uint16_t sid =3D X86_IOMMU_SID_INVALID;
+    uint32_t pasid;
=20
     from.address =3D (uint64_t) addr + VTD_INTERRUPT_ADDR_FIRST;
     from.data =3D (uint32_t) value;
@@ -4222,9 +4287,16 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hw=
addr addr,
     if (!attrs.unspecified) {
         /* We have explicit Source ID */
         sid =3D attrs.requester_id;
+        pasid =3D attrs.pid !=3D 0 ? attrs.pid : PCI_NO_PASID;
+
+        if (attrs.address_type =3D=3D PCI_AT_TRANSLATED &&
+            sid !=3D X86_IOMMU_SID_INVALID) {
+            vtd_report_sid_ir_illegal_access(s, sid, pasid, from.address, =
true);
+            return MEMTX_ERROR;
+        }
     }
=20
-    ret =3D vtd_interrupt_remap_msi(opaque, &from, &to, sid, true);
+    ret =3D vtd_interrupt_remap_msi(s, &from, &to, sid, true);
     if (ret) {
         /* Drop this interrupt */
         return MEMTX_ERROR;
@@ -4249,30 +4321,6 @@ static const MemoryRegionOps vtd_mem_ir_ops =3D {
     },
 };
=20
-static void vtd_report_ir_illegal_access(VTDAddressSpace *vtd_as,
-                                         hwaddr addr, bool is_write)
-{
-    IntelIOMMUState *s =3D vtd_as->iommu_state;
-    uint8_t bus_n =3D pci_bus_num(vtd_as->bus);
-    uint16_t sid =3D PCI_BUILD_BDF(bus_n, vtd_as->devfn);
-    bool is_fpd_set =3D false;
-    VTDContextEntry ce;
-
-    assert(vtd_as->pasid !=3D PCI_NO_PASID);
-
-    /* Try out best to fetch FPD, we can't do anything more */
-    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) =3D=3D 0) {
-        is_fpd_set =3D ce.lo & VTD_CONTEXT_ENTRY_FPD;
-        if (!is_fpd_set && s->root_scalable) {
-            vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
-        }
-    }
-
-    vtd_report_fault(s, VTD_FR_SM_INTERRUPT_ADDR,
-                     is_fpd_set, sid, addr, is_write,
-                     true, vtd_as->pasid);
-}
-
 static MemTxResult vtd_mem_ir_fault_read(void *opaque, hwaddr addr,
                                          uint64_t *data, unsigned size,
                                          MemTxAttrs attrs)
@@ -4872,14 +4920,10 @@ static IOMMUTLBEntry vtd_iommu_ats_do_translate(IOM=
MUMemoryRegion *iommu,
=20
     if (vtd_is_interrupt_addr(addr)) {
         vtd_report_ir_illegal_access(vtd_as, addr, flags & IOMMU_WO);
+        vtd_prepare_error_entry(&entry);
         entry.target_as =3D &address_space_memory;
-        entry.iova =3D 0;
-        entry.translated_addr =3D 0;
-        entry.addr_mask =3D ~VTD_PAGE_MASK_4K;
-        entry.perm =3D IOMMU_NONE;
-        entry.pasid =3D PCI_NO_PASID;
     } else {
-        entry =3D vtd_iommu_translate(iommu, addr, flags, 0);
+        entry =3D vtd_iommu_translate(iommu, addr, flags, VTD_IDX_UNTRANSL=
ATED);
     }
=20
     return entry;
--=20
2.51.0

