Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79378CCF9F7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3mc-0007UE-Ub; Wed, 29 Oct 2025 06:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mX-0007TM-IV
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:51:59 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mT-00020W-6O
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1761735113; x=1793271113;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=421LnlL86KWuR8YBIWU8Rxgx7bgDM82bS0Zd/Q81F8c=;
 b=URi60jF/SFbj8TjjV1mffnDYE/X9vtLSMs3VPK29nWLyvWQPRedXAIRP
 tt0vLWCQRxgzytDrTFrqKHO3r1kamfxI5iCsezeiXKbjOF4F8SJsI95U4
 tD8H05g8z9JVkfFffSTq0/3jHFx8d26vemnzdz/+MOPaa4mFowJCft1tQ
 axJoqa3Ss+WOxvcZBgp5BMVRHdcI9k37DqFLmIjGWnW6whDLwi1dwIUg6
 H4g3snuSc5DZOSmidyr7TAYxSNRTcd9ZCuylrIgePpx/tY+PtJB4ua388
 L45B9r0yP6HbguY03WRxrQ4N+zBWwPQyzicXf7ol3BB9xZ5jzFveEf0ic w==;
X-CSE-ConnectionGUID: WB+Rkw5ORrymFj+NsdFm4Q==
X-CSE-MsgGUID: QI+QpfNNQ8SyWQIa9Djayg==
X-IronPort-AV: E=Sophos;i="6.19,263,1754949600"; d="scan'208";a="44178951"
X-MGA-submission: =?us-ascii?q?MDGG8MW8YNhOUFzjs9Eegig9wIJlrkn4afdSmm?=
 =?us-ascii?q?DoZOrIID0r5XHfE2VYhZwT0khgVam0cpR+F7sbinBVPKpEgJ/ssYU4xc?=
 =?us-ascii?q?pP6RWL4HRhCcxMXx4nOR/OSxATRBSkY9odBNDaiUvyA++i9Q1yD4P/5M?=
 =?us-ascii?q?yt2dygU1CADKjCEj9yvfKqdg=3D=3D?=
Received: from mail-northeuropeazon11011056.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.56])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 29 Oct 2025 11:51:45 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lts/yym4e9px9tBR51pQ8lEefajkX4fw/Pg/uZyxagJNo+x8y1btavd/dDLsbXWacQ8hSmHrUAHzr1uDxHNTyDvv9OR93S6WF6I3pdsVV1aHP4syHFnZIHZQ87mk4mO//pK44I3Fz4N881NT3X+bmpeLHZvxj8zL7L1yl+ZlCo4/sCTJnVDdUuBx2wpAwjmQ3j4LkhdX1jC0IwcXcyGxvlfcI5m2nykpSy0E42V/FdPwCgtiiiuD0a9bUAOAQ90B0om6+HqXa2rPaOjIk5CAPlxOj7fcuYBi3jxfgDc9j4Pf15yed/qTsXiDEQGgiJ5Y8Fr/gK/D7fo1RCta/Sm05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0pTj72upwMUheJmbUy8NBLVJwJYMVQ1YNAc0UOK1Cw=;
 b=cuz+5AJky5JufbFwmfgRO4TUroQD7nkWwVawO3zHpBSjucH1tJPlw/p3bwB0VQM3a7cILk/RX7weoBPqFBh5TNpXperTjpcNwF/si7pAz3Uk/K/9SP5BqaWXGEQEQmZzHXcH5w0BXDlNjXpw7R8IKzmzZHDpZqT/IfIO8WsaS46c8r+22SJFIYLlTQVO7AuoPmmbnlBRgNYYoebv4G6TQg13ZoBCWYbDtiM38nvGqhwGso0XaUu8/pN/1zL28O0p6FKONJSu7C5wG4b3Yzj/eae+QwcIpB9Y2+sCcyGS2f99mP60ZfkRR1OWA8Uyv/u4LpJAz0zY7wENgs3eLtSRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0pTj72upwMUheJmbUy8NBLVJwJYMVQ1YNAc0UOK1Cw=;
 b=da+wEG+NokmT+LNy7YW5/14Nf04UDB61Le2lWUXK4Od8SWaFzMybPX2RUMYmnSy0PUp4VJ+XrjesdcZoxE+X3S9i/4qtjiYwDwR1XJKq3JulPd+dRgAJKKk//8ZmgCeZyWArwYnWm+CqTWlMD6HKO0MNeyz66J+y6hIslyJ1BSfoAVIyfXk1EH62397nnDptnCkxIr/7J6ynVIGV47TBKk5BpG+JtguRWuUWu1GX2/bnbtbsVlEBmi8AhsL62zmJrRq8P+1WrsZhQk162yJSPH/6Tt+zNyqWjAyXjgni6kNp1MGXiM+a3b3/EouedZEKin46ZJmp81f1UmXQOeGn/A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI0PR07MB10962.eurprd07.prod.outlook.com (2603:10a6:800:2d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:51:43 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9228.010; Wed, 29 Oct 2025
 10:51:43 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 3/7] pcie: Add a function to check if pasid privileged mode is
 enabled
Thread-Topic: [PATCH 3/7] pcie: Add a function to check if pasid privileged
 mode is enabled
Thread-Index: AQHcSMIDTUkbUJlsT0mX59cFkniixQ==
Date: Wed, 29 Oct 2025 10:51:43 +0000
Message-ID: <20251029105137.1097933-4-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 9531348a-3ee5-46a9-dab3-08de16d9260a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?FWEfJY7q5pC4ZIGtFWYWNaQhNtkBbYMF6uNR9iXdFkmKBNXfuzAd9pMRdp?=
 =?iso-8859-1?Q?t3SxozOdd11p5g5KiZGUP5OBEg1OmZKPK9nkuFZGSyXvTqrtn+AEZW4jnY?=
 =?iso-8859-1?Q?LXecSZFYZofCGTCd2XSQl7CfurinUD67d5wFRwPNYwPGvwfy+y2HvBAcQ2?=
 =?iso-8859-1?Q?asZKyjWAdfZTuVVnVUaXpyX38ol7RvfX9ihWGvwysvSNkEqKb3Wely8gPQ?=
 =?iso-8859-1?Q?d/F8oPryeYEEWKprAuUaJaQrOmZPNcSzAM5NC9ZxsBue2Ac639EZdyZpzp?=
 =?iso-8859-1?Q?HmoNmBxa6j3SVfWA3fDCnb3qKDgRPMna77G4yUeHJ+x9SJ17BTgAkrCq7N?=
 =?iso-8859-1?Q?ARfYOBFloEWLyCkZnGYTXeixOaa7e+TnM/r2yB6nZLodbuy8MRAGAg3MZl?=
 =?iso-8859-1?Q?KpnuK5W/gTMRevPJmKO9EnM6QbwBQ5R7npBUwWWylWGg7Yn5tCaxy+fgzE?=
 =?iso-8859-1?Q?m2D9Uujfj6L1NkSIP2luTgt25PJa8xYVIaWKIFdWieigUlPUzPxGnh4IU8?=
 =?iso-8859-1?Q?YRlJ4P5kuX2XXzLf25d/g2KZZVWN2KHtlWjQkgTpyrzYYEOg8UF0BKl3xF?=
 =?iso-8859-1?Q?ONLvoGFPGUllLVhUgGIeH7Ro/1PnJ3XmM//7ddAAWJ3AVWFevhQu7Z2Cbj?=
 =?iso-8859-1?Q?Y5q2B7OHQT5vMJutXMKBcpPykWKkW1ezdaVs3xmtOaG5WP3oVI+SeaSH5z?=
 =?iso-8859-1?Q?WY847wMKO9kHbH1C+Fp1kKivTf5PIN/m0TnRAgVKNcADdsuM5p94Ivvhe9?=
 =?iso-8859-1?Q?Uwuc+zjT3Gw/eLmQJM38/vsojhgMbOH4QxaJIGUAS9EOTvZtqobLqCyJQ+?=
 =?iso-8859-1?Q?rGXH/lfZ8MMVMeZ0p5FUie0CHkH2vrkeDb9J5l7taZj7ZMXwMnQ/phLXwy?=
 =?iso-8859-1?Q?28EoWSctn/RxxWwCPqfV9L8NmkKpUv+kP0WbTxiBsZ9yYVmWjF/5RmmLKP?=
 =?iso-8859-1?Q?0R0+fC3n5hl1sfumctphEqj0yPrSuoVyuOgP2B50b4lNq+3iU2TuZWQfmL?=
 =?iso-8859-1?Q?c4j4bbqMVznQNlioCTZ+uD1nK7RUBsTCKI10LFbJFmTQcMXM6J4wHqB2HD?=
 =?iso-8859-1?Q?kC4dCxxlgV7k2Ez6tYIrpqO0O3VonwHOj/dTszckVWMJRrb2/nxmZZo1Cc?=
 =?iso-8859-1?Q?BGXh0GdxhSCziRCeucZ+qDdX77u93xOHL3SBgR4xvyJ7+fv1ypd/Mj0lz9?=
 =?iso-8859-1?Q?/hcWAkCCaZWieZu/DtkD+YxLKWOop20qZcdwmavIROHjyrV4NyC/hP+7Im?=
 =?iso-8859-1?Q?XKIDp5MZFiG7f9kdWfNciD8AHOQWsKHEH256KxbA7GOmLGDk5JJnEdxLcS?=
 =?iso-8859-1?Q?JsgvIUYWZhftyGN4Z9iXKFcw/BK9Hm8J7Srskocn4RHGbspsDDH70klchs?=
 =?iso-8859-1?Q?hi1+ds19qaWDHptv469CUtLZdCv2Jz1S7hC038lwh+57BcuNbC+/mHZ2WN?=
 =?iso-8859-1?Q?UCAEtlJWxErRGBa1vnXtAj3+sWWRhWfrcGs7NCrm4jRrLHX2V6d8K5K9eC?=
 =?iso-8859-1?Q?R2HUhf0rrTBnqTD7Ue38ludHpb8m2oJIi/8MJz6ucfgAP31Jx/Cp28W3nZ?=
 =?iso-8859-1?Q?K+p2O+FPvd2+QbYg12GX4ovyGjZI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mKUdF6dLLu7ENf956YuGWS6ygT2U7DmRdISucOGBb3kvrdP3uFHnpzMYJw?=
 =?iso-8859-1?Q?WzvUsvBwk48LJ4JYFw1k6cPJHez5MgtldgTQoc0lMTpYbnpgp4d2/9pWQE?=
 =?iso-8859-1?Q?taHv7QulsQcOyh9LHdrswZ5uk8ZuCLD5C21i1zhrg7sIHPql+Vn7cUa97V?=
 =?iso-8859-1?Q?h6KyK7iukpkW/rX+GNz0pBd9tcFCTmDqE/62zS7h5rNDfDM/FKbuJctJI8?=
 =?iso-8859-1?Q?pUNMjlhhZMQaITYzbRzaLphlIaUIeNoFpB9GKgKBZh63KcmuYaDXwYSFuB?=
 =?iso-8859-1?Q?XJXJ/hzlUqhYspV4Lr5yI006KJiBByv4mWfNvqMem0OY/036AfXEXjAgem?=
 =?iso-8859-1?Q?bTmO3DJmNybp3IWlLHjM3AnSnjQvDJ0UenwXr1IZoNcFtPNxgCJWAspTn/?=
 =?iso-8859-1?Q?xpHIpcYfDshvKHSxZpTS3LxAWkaqRkWHLZDzxfPTaLxyBX1u6ZNgvIASNb?=
 =?iso-8859-1?Q?XsBtXdgfJNqH+YIvK8iHKIao3QVKmxvRTJOrAqX0RsxT91H0Fjp9FSQKL3?=
 =?iso-8859-1?Q?eRL/Bkj1beKNlg7yF3g1G1WnK9B1nsNLkkY/qc70eho83jjaNDSCUhtGNL?=
 =?iso-8859-1?Q?5EezNg4Jv8mkI8xF8LltUvKUXMqMGPpNo4j8qyVeTKJrgCKRRc0jvMLFWW?=
 =?iso-8859-1?Q?qW6rTXkhDBEOKI5KPAu+EKRuhxQtTc1Ts5IcqRaFYcN11uL2fkLE78Sbm9?=
 =?iso-8859-1?Q?VWXkdjtOT7V1kNuzDgGVglp2AEyaGXZ2lZO8MfgCgVHKXa21MOOljp8DYO?=
 =?iso-8859-1?Q?fgF3s2A2qIhqFXyGk5oTeVCgR/+CMdzJAiCkqxrIhUjwWUeDdD93v8MyrJ?=
 =?iso-8859-1?Q?g80D7HiGIE6qNur6EIBWBs/C3vmT8BC6/QnGPL6ZY3RGd/2RjfngqCBXen?=
 =?iso-8859-1?Q?KoTzNmola4LwWPnAf8t2tXupqntPOWJCuAwVwy6uweFnbUUIXKwDMwLbVu?=
 =?iso-8859-1?Q?VPIqyqsiOtq7/wPLzGeqf1rgkpKdPnDOLckM9oLIFZXX2kF3Rv7ejUohvf?=
 =?iso-8859-1?Q?MG8K3YgRgIi+3WwfewwWuk5blt9MrSiu/bw36wlDqPejh2tTimtnSND1Ax?=
 =?iso-8859-1?Q?PyaFYuyJwPAp3h992Fa1isl2kCSY0AeYy16O+PKQkvUd+I5NVOw+FcMU6Q?=
 =?iso-8859-1?Q?Uvto/66fohv0ghRfkcRj8dLgAqm31+9CUhlSwRmCEeAsLIVsquv819vHEM?=
 =?iso-8859-1?Q?RmkIPLvGo2eI0hOmg2+TN+f5lbn3yIdy0b7ihjnnxpXK9s5OHoBAHLfm5P?=
 =?iso-8859-1?Q?uL+kCmsIkvEsNUPs/VcR/mkVHEyvLVBkuPABB/z0EfWT6/sxkigOYOLGvA?=
 =?iso-8859-1?Q?7H32H9Mg1vQkVNgryhr+e2NSPY3Ctu7md89XIADcNBRfLtDSwiKQmurEQf?=
 =?iso-8859-1?Q?k3LQPL2uM/yZepPOcOa/z6f281gBhIM5GfpnjiP8o5VXD8qo+rGMlOOZTC?=
 =?iso-8859-1?Q?FaPgEEoG9KjHVZJMUkrnJJyj3kCc6coxGZ40LOgnH2CGJJkeCM1/N9BMlj?=
 =?iso-8859-1?Q?MJOQmNvD95snqWWn49RZRNx6lNq4qkQAdJEYi1FmHGnt+hxMkEgBNXIidp?=
 =?iso-8859-1?Q?Oskh1jzT53FqRdbkxY/SC+gROu4rEbLxMvIkE1wP6Bl+hJOKYes2PFvhZY?=
 =?iso-8859-1?Q?+13vW4RcRLowLrCyDXzWa2v2153EkGQlxU/yTHibafGRzT/uR1G5Ihc1pE?=
 =?iso-8859-1?Q?9P5moJpDK/MbnDTjftg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9531348a-3ee5-46a9-dab3-08de16d9260a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 10:51:43.5107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m67hM7rqOaCfOyN/36dL3gbRdYZRlSv/jz0mKJpnETIbsI4E+h/VugQYhi/2bGFUZucVSvhqQS9LM54vT1uz0S0QlNACm1PLc0GVDfhBs1VCj1LJJIKLEXiMfy7UmE3j
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
 hw/pci/pcie.c         | 21 ++++++++++++++++-----
 include/hw/pci/pcie.h |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b302de6419..2afcd413cd 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1266,6 +1266,16 @@ void pcie_pri_init(PCIDevice *dev, uint16_t offset, =
uint32_t outstanding_pr_cap,
     dev->exp.pri_cap =3D offset;
 }
=20
+static inline bool pcie_pasid_check_ctrl_bit_enabled(const PCIDevice *dev,
+                                                     uint16_t mask)
+{
+    if (!pci_is_express(dev) || !dev->exp.pasid_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL=
) &
+                mask) !=3D 0;
+}
+
 uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev)
 {
     if (!pcie_pri_enabled(dev)) {
@@ -1285,11 +1295,12 @@ bool pcie_pri_enabled(const PCIDevice *dev)
=20
 bool pcie_pasid_enabled(const PCIDevice *dev)
 {
-    if (!pci_is_express(dev) || !dev->exp.pasid_cap) {
-        return false;
-    }
-    return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL=
) &
-                PCI_PASID_CTRL_ENABLE) !=3D 0;
+    return pcie_pasid_check_ctrl_bit_enabled(dev, PCI_PASID_CTRL_ENABLE);
+}
+
+bool pcie_pasid_priv_enabled(PCIDevice *dev)
+{
+    return pcie_pasid_check_ctrl_bit_enabled(dev, PCI_PASID_CTRL_PRIV);
 }
=20
 bool pcie_ats_enabled(const PCIDevice *dev)
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 42cebcd033..5e75c75110 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -161,5 +161,6 @@ void pcie_pri_init(PCIDevice *dev, uint16_t offset, uin=
t32_t outstanding_pr_cap,
 uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev);
 bool pcie_pri_enabled(const PCIDevice *dev);
 bool pcie_pasid_enabled(const PCIDevice *dev);
+bool pcie_pasid_priv_enabled(PCIDevice *dev);
 bool pcie_ats_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
--=20
2.51.0

