Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8E4CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3mq-0007XI-8m; Wed, 29 Oct 2025 06:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3ml-0007Vq-Tk
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:52:11 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mi-00020W-2M
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1761735128; x=1793271128;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1G8QrJLCOH+2/XXKvnyodvCjtpRGEPutuSPOnVJuzXk=;
 b=Atxaa+E8rPEdXc373a1fM3URPrKAXRhOX+drVga4CAQd0dopIVSTu8J9
 yjeguy5PLIrSr9ZeJ9lU/JLR77Qli9mOqrCVMLSy4/EsYk/igujQzD4r0
 SOlWqKEd+pIMKrZVaFeqsQEFm/2834oc/C+zUyXVYV5c+iNr7tLTzkaQP
 rmvLcZGdwOvf5ne3fZJiTYPcaMSq1+NcVXLA+xkgFkpG9BnkMYhR2CvOk
 DfQhL74XzmuRvKxaoktvUQ7oSgW0GxZiFbq1qNWdbRD+KsNXp9WbRuTn2
 2TyjGks8sAZmY1KG9cvyhpHiSyL5uuMYxjY2WYt01aFc7ER13v9yU8wRT A==;
X-CSE-ConnectionGUID: 9+FnvmtDToqh0jTXQULCJQ==
X-CSE-MsgGUID: YkQmiBzETNOGqKQ7E1VDbg==
X-IronPort-AV: E=Sophos;i="6.19,263,1754949600"; d="scan'208";a="44178955"
X-MGA-submission: =?us-ascii?q?MDHRTrw9Nj8Lr2QD2kziIEd8Iyl+ajhbULdfa4?=
 =?us-ascii?q?x7Sx7DmZYWYQ+PyZbMntsObycy1ULoTIonpYODm03qWTn+YbslE2GmPe?=
 =?us-ascii?q?r2eLN5TCDVqYeEI8gyvVr4CuQY3KokXuxC4243vmh1JDYMQg50ACtsjZ?=
 =?us-ascii?q?qSU4vo1dGb/SAflJX3Pp202Q=3D=3D?=
Received: from mail-northeuropeazon11010065.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.65])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 29 Oct 2025 11:51:49 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwGimDaGp/csCYoFlxOl24Wkuq8R7b/TL/242WGeLshUKm4/xa6Ui50r50T4WpT8oew+Twsmx8wfpsh0RElpv0TXj7X5jdTLL5PW/t2gyAs7WkzJ6t1PYlSMgz40XJtCw1beu1hw25cPqktzYBkWEl+K5Iym4Pk2Twgp9tbO15tV6vNilX71LsFQkcWVNZwGQih+Nb7TmohfXQUTsO3LJb/kjVXndipj1OqIHe9n1VtbzYc4yZeoERSsHJNj6RitlVAuo7pRFzznu6fdHNDnKpirQbo/4nbN3xAb7M06UwpDnvT9eHen3VMH2nSAgrBaNZA73l8S7LQ0dZ94tS5pvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLBGXehqWufSmuLCLhaXHzMVNKSdvC8IavksEqkJHRA=;
 b=utU+R4ZyQ1hZTTxQEHPmcVbfAdtn3JONCxYhYwp4wZgkAkylWCDutka0ne038dmEptuBNDsrK8O+ffmMLkAtvSvqmWSC5bYApanigvyaZ9Q3NkagorApsrKJuQKUhU22dXm78lv5rnRT0mksScWoRNEm+m/B64hNDFEtz4Hl9XMjHCFSQyMGIB7kBMU64QzeILvWU7Adj/2yaIA+2fbkKV46g5G1DML7KygTDr0Dwf0QPhXdDO0D+wzvNZB5BcsNLDt9pZeFLBNR0vfrDzs8QN8iY8T/ogVedAgELJVYG6vNZbJ0ZiFO4/DOjLLjFwT9AVH5XO8C5HyRiJtCmhFP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLBGXehqWufSmuLCLhaXHzMVNKSdvC8IavksEqkJHRA=;
 b=bbh3Co8JG3rWFi6cpL8I3FQSLFyondf3f3k/4kUFCKIeRut6N8oZFFfqvUaYK4Bv3Ny12VdaOqTgvk4/BQFQ4II72crsxWtaYHcrhM2GAYbMIj/D9RpDrutaz9ZQa7pLUW/Q0tpDBpj2Y+GBT/GnsN2p06L8t1boEzq4wHpdK6UGQ1pDo49ysclFZWILEKOjw+qKTvs4wj9zWGFyqejHuce+P91a108QQ6cOcO6IL6sGLMmdMicW98V60P/59MM9twMMJYpUHzvyUyIU+idISOfUMjG9OMrKDgY3ot/6+r6KDTPxvggzMHkKt2UqMcTS3g57ZE5kO+OzUNBZesHx7w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI0PR07MB10962.eurprd07.prod.outlook.com (2603:10a6:800:2d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:51:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9228.010; Wed, 29 Oct 2025
 10:51:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 7/7] intel_iommu: Add a CLI option to enable SVM
Thread-Topic: [PATCH 7/7] intel_iommu: Add a CLI option to enable SVM
Thread-Index: AQHcSMIFYWC2/jijTUmbnvXqbpZ/Ew==
Date: Wed, 29 Oct 2025 10:51:46 +0000
Message-ID: <20251029105137.1097933-8-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 0fe63d12-dfae-4dcb-c16a-08de16d9281b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hJwlOYZ8u7aWH6FitRIzs+RDFkcqHgDgcSiF+7F4ktgVxQfxZyrdEc2U4/?=
 =?iso-8859-1?Q?sVgzUEnODX74J7O3YQLK33JBTCnrv3DkIT7ijWt/+CFA7LWNIijNeU8NB0?=
 =?iso-8859-1?Q?73zGj2HPv/3mWYWgY3xTr268umeypViBYj0Ntys9RXJ9BUJeVpazB6D8Po?=
 =?iso-8859-1?Q?WIgaJ5n4kOyInfsxjpYw8YxpaVUkiU3E+ZRFpFzTlRmaNe3pzrkyoq5QTB?=
 =?iso-8859-1?Q?Zd3QiTjPFuxrOtY9tcogz1W1BUuxTaiVwrMX4YPlO/tUmmVy9g4K2hXzJp?=
 =?iso-8859-1?Q?oaWrIvE0WhQJm3Z5/meWYub4ktUc3x4XX5/qfqRpM2c3LKCMW4/fyTGrUm?=
 =?iso-8859-1?Q?ZaxIIcYGbtNNp97j9ZSbtC9pbUKxoQNQrBsIOy2aOdXyZSNfrEBnahwKVL?=
 =?iso-8859-1?Q?L6HaeaooPaLmj1mwx16SFpETibzAHuNxZf+pYzX5uZfCfAAYDcwcRsYIvd?=
 =?iso-8859-1?Q?OW8AxORB91I1D+3Mbn07YAKv9kRf6ouVxAuXvi7mvFpuHfrKLSVH4lbcxa?=
 =?iso-8859-1?Q?N5HMfSgCF1lHFvMV1ji1fxHKQVeJJNzBuNNcZ6j7PHIV4YzNHmzZUtfxMs?=
 =?iso-8859-1?Q?DmB63lG3uQNR46R67MIFzAMIvyvPjJpozh52ETIsTMY6FYcBjAwsCVUglp?=
 =?iso-8859-1?Q?qmOedLDMP7nG4V9sEJWub+UYBymI/hFRV4KU0p3jKHc5e85koL5rL5rBBu?=
 =?iso-8859-1?Q?bvNKjLWTkM+iS8u9i6ZYkNPfjuaW3bRAZkDQS846pYu/dhJ6ljQNgrp31f?=
 =?iso-8859-1?Q?t7heGiqczrDuRG5PhtFNiaDR9i0fmY0JyHcmbFlOvXKoVHfmn2BOZ+olmg?=
 =?iso-8859-1?Q?I/E9M6S1rNyl5pU2pKgwRqcBj7xN5A2EbN+kKlB45wpVULePX8zX1RCDWQ?=
 =?iso-8859-1?Q?D1SYSE6xzIK0Gt/Fu/ZVdyN+cXZxtx6mZPzyQ6PY/Z7fRf2koWZ4CvOkDZ?=
 =?iso-8859-1?Q?yhQjN0FonwgdVGvP34AQySnqa8v8D4KamxNIt/pxbUQJnEp1l5DnmHUOCe?=
 =?iso-8859-1?Q?o6qpTlJt4Wv7JcQWV876nX5hR32sSj9alE3ePbu0GMCXBJJaMTgKPBC/le?=
 =?iso-8859-1?Q?KArdq+ROkMlFhiPDzqPxy9X/VuAJpHWTtSyqInzNxiw0KTBTRQyS4VDNvW?=
 =?iso-8859-1?Q?LPC80LVreHHzClAgsceIpB6RWhoHKi3wi4NlqQ6xSOJbBdCLTmB3I1j1cI?=
 =?iso-8859-1?Q?vD+DnDaui2kfTbxsMVNT+q2LvI+HuyfeZbpavJTdAVto6dofGYh+lAwFWf?=
 =?iso-8859-1?Q?HpVSHtoJnJggHWboIwiXgXdpuozNgeP/gpGs0YHo+vBcIeSHVzVIfk0aOf?=
 =?iso-8859-1?Q?XWEkcmUnWo+yfRNZopReGs2/AOAcnTVJAJr1FimqGfH87ktMT8frX7JGHm?=
 =?iso-8859-1?Q?X7NW70HCd06jfso2pPDwP2BF7b+7Qhh7z6/6wn4BhjjP2nwfRwaR5AejSA?=
 =?iso-8859-1?Q?0yAH1IM7yOQugxNbyQBbwi9opbE3Tcg2rIuvg6Ix7lh9RSg65syzvIW3AN?=
 =?iso-8859-1?Q?FY7GrbRSWU7wto9Pxq5O4ilysKn/zs9Wi+kwKzJOg1rFXfdjohIZvE+LIF?=
 =?iso-8859-1?Q?LjcMTsThyr0/Iyo+Ozv2y/OZXpd9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U+3OYphdB367XTAP67dtpqi0cLrYBx6gRostmd4pYiZJTtm5LpxezDV/Hp?=
 =?iso-8859-1?Q?XKvznPpzZQHJvK3kPpO42JqwMRxOYh+Kj/M+oa6logvMdS1KX2Mod7Nysq?=
 =?iso-8859-1?Q?Jz9BCfbPDSPxdfAuPlo2NvghQwjbqwzgfa1ZbGkrbjbyIIYy2HlV+ZdN40?=
 =?iso-8859-1?Q?3KSnaOKLdnFSOl0MV4EhuKH5cHAt2ZkS4LzZmzAX+BmynuAmfv7sw2ZDi2?=
 =?iso-8859-1?Q?X7SqqLvaZ9JdENV/zJX8VUdlOpR8q9Wc4j8jKFYCHsWla2+KNYkTOxHAmx?=
 =?iso-8859-1?Q?VGxEyFYmMijMn4aO/jcuJx+o1UIafiAp/G7lVyALJcPBuOWPMWYdTcOKU1?=
 =?iso-8859-1?Q?g80dKow5wVSasoWLZbsG7VeOicrKBWmPGXM0gcDpsJtBJi9dP99tcBU7b4?=
 =?iso-8859-1?Q?2HweQ31Uj1JxY2wxZ9WPtdoGmjza8q32cnGoqSUWlGDKmQM+H2AXPgneJ4?=
 =?iso-8859-1?Q?Wq2iCMJ6I4h3a+yQAbp87UcJ/tGQLE19AfuKTByHPlBp/Af+CYbX+mAsrf?=
 =?iso-8859-1?Q?3/JljRhf9io6EUutRYCvwVjF8LhvxUxTg5381MMBfdu0VngGTlZBJU2p45?=
 =?iso-8859-1?Q?xiK0B9lmflLYm+34ygA8HxdzIMuEv98KQrV7RuKmnzmAB51M4+VptVNCij?=
 =?iso-8859-1?Q?tVVGMqTU4pIMtfy5YvT/G8NQAzDZEBYsSx4a77YZVgBY6scGPibu+2l+xC?=
 =?iso-8859-1?Q?ZJ21TiixJiJkbx5gX+SNY9jmRsLncKpDYD7dJ04w5TUDtl9VLpkRF5xsmd?=
 =?iso-8859-1?Q?rOjZ4mKK/eyA0OJYw9pJRNJZjKrmuOtzJgMQUoETXL2SiVekqhJ6+tXNEL?=
 =?iso-8859-1?Q?nvwoqomE9PH4AFYZR3sdsEjcJsT6QY2HM6ovReHrTqJz41B9ahESmPOmxc?=
 =?iso-8859-1?Q?wajmwkiE+RjoRlTIvXv4IPP047lgY/yC0NKlmiHZknrnn1D9WtJQcqXcbU?=
 =?iso-8859-1?Q?cJ8sQ0YL21uZ+Z53O3Z7xud836qgny6gr/XwcgdBtTtnInGinspsr/qupN?=
 =?iso-8859-1?Q?6b2pcJG8xekFlhwu3Yo+Wekd9GQyBXI8Is06Emk1udJ1Cu9nUpPiP8dED6?=
 =?iso-8859-1?Q?gfMdk4msGHC8qWiWEtd4ULlmt0v5JpPZ4fCfwn1gmTfEkySx8PJixq6cfp?=
 =?iso-8859-1?Q?/0dYSMVQtP80yAp5e5nPDWEAtkNw4DNs2Eqlwnkq5+NUxht1IxW+WsHUAp?=
 =?iso-8859-1?Q?YWFr+H5kD1jxkvh4MIotAMZXOu6B6GFY/VbqhA+p8xVCEFiIdYNivq+aha?=
 =?iso-8859-1?Q?ArN/xdv4Xou6hhFtMNq+VwyLAOneqXPFBO/ykcSTsXjkvNE3RmszWIq8yn?=
 =?iso-8859-1?Q?MoAMeQLHuAcbbI99AYReoTsSu1IeV/1e6mYgTqXsWBKGRU3b+emzJcmiKF?=
 =?iso-8859-1?Q?BRTwR3oUalIA+JG7APvPGckkMMbb6kqocusuJ3+62cy3kB2w4RJVZrdlcQ?=
 =?iso-8859-1?Q?kSe/P0K/sKXVTSa+V/K6YwxYLfcNOCE/6patn3WsztpNEr4jk/wHppmMIA?=
 =?iso-8859-1?Q?ygcNvREXh+z5tTZzDQ7FTpbb1mGWDk4kb1bcRL1kBvL77/DeWuNs8G7nmm?=
 =?iso-8859-1?Q?KLPRU9QUWr94bhtci8IJzl/JvfUXsR9X1gAVSQKfsWrDeKVQoERqTdM5g1?=
 =?iso-8859-1?Q?YN9K1kYaU0GYj7AfqD9smnTqJJONr/O3YX06o2FNxux+9bEm/uGMnLWlIS?=
 =?iso-8859-1?Q?+HmKGTssXW0Oz/iwe8o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe63d12-dfae-4dcb-c16a-08de16d9281b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 10:51:46.9195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gACJ8mQOsVZ4KS1NhUfLwSd9zu490yCFTh5SaiTwf7Li3tjVPo0vyagWlFg7S/5J8lUyWEMitS/KevT61X1ezw48abtwXlWIUCNz4FWWG5zCw1yuOrB1TmmJIV5tEJ+E
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
 hw/i386/intel_iommu.c          | 45 ++++++++++++++++++++++++----------
 hw/i386/intel_iommu_internal.h |  6 ++++-
 include/hw/i386/intel_iommu.h  |  1 +
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 38a9c87da5..7b76a8c3e6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2824,8 +2824,10 @@ static bool vtd_inv_desc_reserved_check(IntelIOMMUSt=
ate *s,
=20
 static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc=
)
 {
-    uint64_t mask[4] =3D {VTD_INV_DESC_WAIT_RSVD_LO, VTD_INV_DESC_WAIT_RSV=
D_HI,
-                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+    uint64_t mask[4] =3D {
+        VTD_INV_DESC_WAIT_RSVD_LO(s->ecap), VTD_INV_DESC_WAIT_RSVD_HI,
+        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE
+    };
     bool ret =3D true;
=20
     if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
@@ -3973,6 +3975,7 @@ static const Property vtd_properties[] =3D {
     DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, flts, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, fals=
e),
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
+    DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
     DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
@@ -4823,6 +4826,10 @@ static void vtd_init(IntelIOMMUState *s)
         vtd_spte_rsvd_large[3] &=3D ~VTD_SPTE_SNP;
     }
=20
+    if (s->svm) {
+        s->ecap |=3D VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS;
+    }
+
     vtd_reset_caches(s);
=20
     /* Define registers with default values and bit semantics */
@@ -5300,6 +5307,29 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)
         return false;
     }
=20
+    if (s->svm) {
+        if (!x86_iommu->dt_supported) {
+            error_setg(errp, "Need to set device IOTLB for svm");
+            return false;
+        }
+
+        if (!s->flts) {
+            error_setg(errp, "Need to set flts for svm");
+            return false;
+        }
+
+        if (!x86_iommu->dma_translation) {
+            error_setg(errp, "Need to set dma-translation for svm");
+            return false;
+        }
+
+        if (!s->pasid) {
+            error_setg(errp, "Need to set PASID support for svm");
+            return false;
+        }
+    }
+
+
     return true;
 }
=20
@@ -5310,17 +5340,6 @@ static void vtd_realize(DeviceState *dev, Error **er=
rp)
     X86MachineState *x86ms =3D X86_MACHINE(ms);
     PCIBus *bus =3D pcms->pcibus;
     IntelIOMMUState *s =3D INTEL_IOMMU_DEVICE(dev);
-    X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(s);
-
-    if (s->pasid && x86_iommu->dt_supported) {
-        /*
-         * PASID-based-Device-TLB Invalidate Descriptor is not
-         * implemented and it requires support from vhost layer which
-         * needs to be implemented in the future.
-         */
-        error_setg(errp, "PASID based device IOTLB is not supported");
-        return;
-    }
=20
     if (!vtd_decide_config(s, errp)) {
         return;
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index 10a452c0dd..79212787ae 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -193,8 +193,10 @@
 #define VTD_ECAP_PRS                (1ULL << 29)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
+#define VTD_ECAP_NWFS               (1ULL << 33)
 #define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid=
 */
 #define VTD_ECAP_PASID              (1ULL << 40)
+#define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SLTS               (1ULL << 46)
 #define VTD_ECAP_FLTS               (1ULL << 47)
@@ -413,7 +415,9 @@ typedef union VTDPRDesc VTDPRDesc;
 #define VTD_INV_DESC_WAIT_IF            (1ULL << 4)
 #define VTD_INV_DESC_WAIT_FN            (1ULL << 6)
 #define VTD_INV_DESC_WAIT_DATA_SHIFT    32
-#define VTD_INV_DESC_WAIT_RSVD_LO       0Xfffff180ULL
+#define VTD_INV_DESC_WAIT_RSVD_LO(ecap) (0Xfffff100ULL | \
+                                        (((ecap) & VTD_ECAP_PDS) \
+                                            ? 0 : (1 << 7)))
 #define VTD_INV_DESC_WAIT_RSVD_HI       3ULL
=20
 /* Masks for Context-cache Invalidation Descriptor */
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index b2f1ef9595..9da612b671 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -267,6 +267,7 @@ struct IntelIOMMUState {
     bool scalable_mode;             /* RO - is Scalable Mode supported? */
     bool flts;                      /* RO - is stage-1 translation support=
ed? */
     bool snoop_control;             /* RO - is SNP filed supported? */
+    bool svm;                       /* RO - is SVA/SVM supported? */
=20
     dma_addr_t root;                /* Current root table pointer */
     bool root_scalable;             /* Type of root table (scalable or not=
) */
--=20
2.51.0

