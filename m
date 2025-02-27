Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA02EC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXY-0004XL-Ce; Thu, 27 Feb 2025 05:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXW-0004RL-Aq
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:50 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXU-0005pC-DW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653688; x=1772189688;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZMxFNyn4oXeMGzshPyBmqXxSzbY8yZSu5H9uG1CqPCs=;
 b=SSqLOCd/gHXzF9fdFCEpjmwJNTXk8Ss202Kr0R95+Iw3k53F2eJZWDnI
 HPvTD0MPG/G9MUlsxVguUHIcM8Oi53VWS3o1CgwPWDB/S3TRBnBPhGdES
 xuzTopGf7z13JkfzvI6aeodFWioHN+IuzeowTIiXkVVETOhjbHrc+WWpD
 LYG1VyiI0VMm/qzlPUBluZrDTujBbqc1OjVjK5kxnoIcsWBV9PcdNSWp5
 6YRppkPXW5ObWDBRgGwpimHFio1DdIOd7zeIHM01BjQ/sMzVJKh0/pn81
 57dKJ3IxxK1QwCjp/io0nDlAxyVyV12BysvyUoNYlucBLjQ1Z/iorK/EE A==;
X-CSE-ConnectionGUID: Fc6bzjGZTs+zE9vGfET5lw==
X-CSE-MsgGUID: TOvAJdLiRNarXPC16qrP0Q==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331826"
X-MGA-submission: =?us-ascii?q?MDGrNni8qNpt8wvcHSa7MBnd3RKq4o4UNFkj6M?=
 =?us-ascii?q?JCX5SBqWo3DyKDWM4ApTN+DK0mMzg8HK7tWjSwno2xIg0/vMDbnCNoqT?=
 =?us-ascii?q?KXN97kKInSbDUiChVivpJUYw02wwHwyBTcWxSZLtl0f6Zp28xrlpOaZk?=
 =?us-ascii?q?QgZuQ5bX41H69LA6OeLZv5hw=3D=3D?=
Received: from mail-db5eur02lp2107.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.107])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:42 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZLBzZbBYskwJDpt45sm+80mcZXZU5xGCFKciBFqziIk+JwrrWLs2YWfGmn+VZmgHuRfpS9KYopNt0cOZzVv0uLOACXmC8+jtxhYjKfwhMMKLdTznilR7FTWxcZT9MwcarZTAKLaxRDYOgn7ujnGPF26feq1bMM0fNwpAhzEnKgBCPm0zKH0a885zjpC8jxhnj+YjSaCeHR+c3I3scAdJm6IKO2iyD6SDEVDeZz/5JYhFY38GIgu0UB5bLs7+SG8Wz7om0YLZPIPJ6MgAYFQZ2HfdlqOjbb2kuBx33fpOnvQTMMhZMm9wP+B2T4UIbm413pHjUQaRiiw2sESpRmd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoZrbtGYuHsZPQVh6qQr/BjRYamm9IIebfREKOYlZWw=;
 b=HgUgZHnAEAP+ATH15t+MiQ29jOZbyKT0heOMNsR4bPkPNWbWi8T2CoCi7/IGgf1A0kSzXUMbY59Dss9w7kvATX/dubRoFy35W9Q0QX78d1dZN9c37+0ZlszOKKFbBEEPmsprQlT0Ei9UuniHFj4WxFmzBB5J3TA7jpdHOOtnk6PlI8nyw+dnSELEQaK5+9E5QF6QljFOPWHCZtG5/WjBgLizD47rs1a+Dljth3n+PIusqtTrMhNkqLRtqQk3zUQAOZL7XHZ8rZiJZtcDdc7b2lwRavcZu7qfK3ddJsU8itrpupRqcpEcwIKtNckHCKsUOOAWPM4s5uViZkaGSjXfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoZrbtGYuHsZPQVh6qQr/BjRYamm9IIebfREKOYlZWw=;
 b=gG++oukmySyi0s9DUgb5OQsvbKibrdHPVh7ccb1ggmPH9NwLoGzTW5YrhCbW4BMAwzqNgNZr7R0VX8TeamF4vDqD1egXJ7SGXU/YhcBi4P4dwfJXJLGnURNWEK507tn4Y+xXrUMC5ELYvxbq52tB42E4At8Me6PDthCaBj/N1PZTYo1LgDQB8QthHW+9JXwHNhZUfsZ7moQaX6p/h2umO2puk2Cxv/O5dKnwlvk1OGBFI4Gz7CqcTCGM37UWYCHjJiQ0munkgzZJ+UcATtQRyDpw4U755EKKm2ZgxO+Sn1gYd08DlP9TMLKdAPGxhc+7P1Pep+j5tjVUJNlWOSmAlw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB9421.eurprd07.prod.outlook.com (2603:10a6:800:1c0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:40 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:40 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 04/19] intel_iommu: Fill the PASID field when creating an
 IOMMUTLBEntry
Thread-Topic: [PATCH v4 04/19] intel_iommu: Fill the PASID field when creating
 an IOMMUTLBEntry
Thread-Index: AQHbiQYAJAMnrNAMAkyZSDpfP8PREQ==
Date: Thu, 27 Feb 2025 10:54:40 +0000
Message-ID: <20250227105339.388598-5-clement.mathieu--drif@eviden.com>
References: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB9421:EE_
x-ms-office365-filtering-correlation-id: d580c19c-2da4-4bbd-3f5f-08dd571d22cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/ZuGm98GWlmnd5zVvuRuodRYTkHkd2FN/cEfO+uciMJJfyIK1sdwVrn9d8?=
 =?iso-8859-1?Q?sF6Se93mmyWwnZ47JUJ0EkMQwiNlv8znU5kKUSXYuD02/xq9Xm6Fh5mch1?=
 =?iso-8859-1?Q?o4bjopCeatYoZYHBH21VW6C5nMUkotM8luJ5tmFM6tnGYqbQys7y5JBLhu?=
 =?iso-8859-1?Q?g8x3v70zniCsYIUfMOqipKfsO4NK4Tiw/JPVkZODRx9zXl1Y0RP9I+2D9+?=
 =?iso-8859-1?Q?XZblVvZoz92ebu++n5O5G+r6WxS6rxROtS5NIStpSUtE5F13hGwTUgSn0j?=
 =?iso-8859-1?Q?QkZaQOryjeHzN59xK+cOHCubuXc75YkSfwLAxhYJjtl1Eknz28EBXgtvd+?=
 =?iso-8859-1?Q?IRKEwUlSXQTLKf6p2eX3U8j+QnhDJT1H41FTNj7A55PLthB2AGtPytO+tU?=
 =?iso-8859-1?Q?noVuWm0dZPKMuflUDFpGf4k7INuAWx2zluL6vhBuxzzoxXYf4Wrs08HAuZ?=
 =?iso-8859-1?Q?vm8Pk5+aT+a7JoMEWvHyjZ7MA2OlnSnP1OeKvKOMJfCJTBPtBkP1Jmta61?=
 =?iso-8859-1?Q?eWe6qeJ1QdAncVY+lE8/qkDEakorBhd/CL+cKkDp0syzadTPHCi/fRpBTw?=
 =?iso-8859-1?Q?E/kg++pgrZ6p5UtxWJ8svZeuVe3Gxyn7uD+1KSt/uj/bcGxtZgtPit10+B?=
 =?iso-8859-1?Q?5K7o1VYjNVrCaUMVfcQOitHCcqbRctrgfJtksa7Y0H4HIHgu5WKE/ggB8K?=
 =?iso-8859-1?Q?J92tk+XZbi0buq1Muy+s14yP0DoIWEuRtx20eMyA7R3Q5EadkFfkrmMD0e?=
 =?iso-8859-1?Q?OnVlf5JMbyZASH4x3D3lIS0qQA/qu4/Yz4faIyqOnMGqmuqmB0CHn5Kv2l?=
 =?iso-8859-1?Q?yAHYhKgfI0AifE80eJMmvkkpfV2lygNuMoFrYyC+eAxTOlQ+8krn5kD1/2?=
 =?iso-8859-1?Q?Sc1MlK/GaaHeKrWXZTeYAk+cVCwHvzKq2Hz6eNKdSiqy3EHA57XU9DRIex?=
 =?iso-8859-1?Q?uCYba6hGs0cz1edw35MVSNPsx2v4NTvNGAIIIRo+WwONkw5E0KMV1rJgVb?=
 =?iso-8859-1?Q?RBoEhlh/UOpqJ7BKegzQpdyVFRBpH3bXF7hZBQkj4B+rOUkbhxEAJrGBCa?=
 =?iso-8859-1?Q?6BabSTkMVlo5WChmoNEdL9ehuP889YbO9/xDLrYEeP5VaFdvEBjw0y7XAx?=
 =?iso-8859-1?Q?7DviB0ykAwFRqo6PlUmRR5HNm3HiLBIhVEEO+af2Lsa8Hii7PT5JrujQ45?=
 =?iso-8859-1?Q?m59BDV9EwAtfVeyQz/iNG+jOlLaFxRoZzVbQxoJiG9O69sHWGlYLaTp4gX?=
 =?iso-8859-1?Q?JHoLygVNSfic9YVEPDViGEcrzy+Td7gOdIhtpufI5b9iKbT92PTc+YIJ+1?=
 =?iso-8859-1?Q?L2mVMV8UMgxS1CAhf2Wt5oM/AbZ2U3w3Az0Qqe4AdY2O/KLiUcFNifZ/g+?=
 =?iso-8859-1?Q?EBMIkkr0o3hOX4PJvJU6liwzlUMWEZwxfUVyY2xl5kmsbHOtFbbyG4XXkQ?=
 =?iso-8859-1?Q?+vsFh8xQN1ljDbG6eLp+8O5hI4QM0FkMakGopzbi5pStDGqlsWaJo9KG4T?=
 =?iso-8859-1?Q?SsyI/vPA+/6LlDmcfKmLn2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dZgzYV07Hlg4VxgRe++MU5B5e92N9/a4pok5Y7M662ZTXRNTSXW8UUGzZe?=
 =?iso-8859-1?Q?e8Zcgzs7DwYdTg2YoINFcPscoQc1eCUWtWd9TreQLSgEID+80DdQxEw8oW?=
 =?iso-8859-1?Q?Yo36+Hp++v1depPMoT0J9dITXUvIIQYFEOae5RQKXoqdMfjfWRe+7T20i/?=
 =?iso-8859-1?Q?YM25OYO2msBDPZsllfQdnJlCTsCMmtoM4j4l+ZDmQgMqr9UxsKGsP6AiB6?=
 =?iso-8859-1?Q?yITCf6DHR3PvceivwVpZIWY5dTA02at4mnh0Og4XzLE7qMT0gYkBSbDBuF?=
 =?iso-8859-1?Q?E/OY4zeMIGkobo7BCxejONqVNjKe9u05WZyP2rEk7oyo7FdJ+h+m4HEGTR?=
 =?iso-8859-1?Q?i/gpObR+LT+oD0P1hcvWSGINZvh4jzTUOlGr/3xYm3Ay5j3JKUjrrN2wkW?=
 =?iso-8859-1?Q?qxaMqPSRPYNpKOw97zd25+vYHtkhRAWv9n5sc3v8h/+CMreA+fgIidjZJ5?=
 =?iso-8859-1?Q?VONx+nza71Q2j0ZAEqBKXiclL3kh7nUavazpA3rxQBd8WlKnV66Tp5NnaE?=
 =?iso-8859-1?Q?V8fe0kSGfJkDtljTiBJJGEemPxOjjcrpHqZyppid37E+uYl5adq/eiq9pT?=
 =?iso-8859-1?Q?oYQXTBdsHW4Dkx6OIpvqeziAKNAxcsI4ji+6fR0cp2ezSbRp5HXS4BJDBo?=
 =?iso-8859-1?Q?EJ0jiEDrbWg0j5qCSMAfMx8KGi8r65RL9pmMEm60my5F3wJuTXMr5F1pR1?=
 =?iso-8859-1?Q?Wwq5WikWUUmfQd1ZQvQvOa15OvQ55ZbKSPwsOqqJuh3KoD9H5WLQb72EfR?=
 =?iso-8859-1?Q?+QCD1qFXZX16RLEnnuyvNHGw3rSAzkobD7usWaSs8RabwLqc7XV3ucdaR9?=
 =?iso-8859-1?Q?0qO+EFKyK+hb/tow6WzwRba49cd4Qbos+zW8K/IkBqswsirZXRFng/nEoj?=
 =?iso-8859-1?Q?jpddRT6n8ZH58nsFyZdt5MLjnI3Q/kcq9qUZ4CGGNxDcsTFgpcfcGI67Xt?=
 =?iso-8859-1?Q?NEW7W78GjvZ70kSkgXnzTRDTMQAyyXGQF5lUSPYqL6GbWFT4ooCQc6j35H?=
 =?iso-8859-1?Q?mFpp34aZJFEQLaEiam9KcJbfFecvP3+G9SPFDVNHHqhtiUiAyz4eOutf1i?=
 =?iso-8859-1?Q?oNk6RDvOXzOkz9IGXerYuA7lsGTtaiVOrYOX+5lo5Zgnoa0XE54nb5HcB5?=
 =?iso-8859-1?Q?42OLUb+obestTyxtM3eqlKYimRD+9zMgQO68Fw4RU+HdQLnjdASbTonKPP?=
 =?iso-8859-1?Q?S069NTrkxMGBm/wx9sfAHOX5dAcKflYkuRqOhsYKaTjecYHbicqTvlR1sW?=
 =?iso-8859-1?Q?i0z0XPpzEcyW7C8ogwlriQ3P5JIqGr94Z4VpDeXawAWChPWXkjSt8CqvnH?=
 =?iso-8859-1?Q?/nazBHLyKlPRIEfzvVgtQJb4feqHcp0h8i4tJ5xdshujrLq9dGn9NipeVK?=
 =?iso-8859-1?Q?neVLP8p6+T0DpEYabm5MWe9upUGHRfz/X/9xcHt1mq5WJhKRb6RddtvGSi?=
 =?iso-8859-1?Q?dgqBIra7A9+4UHnOhVmEcxTd9U/YCqqEWOIFkcb08JI2ACarKSEqfYBSDh?=
 =?iso-8859-1?Q?V37tJKIy8i/k7aVDPXeWaPDyayzdsy9k+8Jx60DO9jF2GCfxxQqEBy4Fhq?=
 =?iso-8859-1?Q?piqaFclF9JQ6VyAmxIblxe/IWvGORrtfL3WTBHgns/Hm4rcgu6FIH16vrh?=
 =?iso-8859-1?Q?kQ90MgXvs31kngVD/j+aRZn8eVzoUmxOGszv7QnhmALrmp47fMSgzc7GlO?=
 =?iso-8859-1?Q?hwZNx/WO//EVtLIYirc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d580c19c-2da4-4bbd-3f5f-08dd571d22cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:40.5935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+7LlPP6/n5jDTVYzdArfwZtpAaAE3PfYBvLxP95RU1QScw3Fi4UHGVoP/0l9KiVdHNaNA7ZXvfFTrikKY5CzvcETryo8zmDb5jOaekfgElhWno2mrR+uqs0m6lZyoSh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9421
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

PASID value must be used by devices as a key (or part of a key)
when populating their ATC with the IOTLB entries returned by the IOMMU.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1b4aaffedc..a360119fbe 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2511,6 +2511,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOM=
MUState *s,
                         .translated_addr =3D 0,
                         .addr_mask =3D size - 1,
                         .perm =3D IOMMU_NONE,
+                        .pasid =3D vtd_as->pasid,
                     },
                 };
                 memory_region_notify_iommu(&vtd_as->iommu, 0, event);
@@ -3098,6 +3099,7 @@ static void do_invalidate_device_tlb(VTDAddressSpace =
*vtd_dev_as,
     event.entry.iova =3D addr;
     event.entry.perm =3D IOMMU_NONE;
     event.entry.translated_addr =3D 0;
+    event.entry.pasid =3D vtd_dev_as->pasid;
     memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
 }
=20
@@ -3680,6 +3682,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryR=
egion *iommu, hwaddr addr,
     IOMMUTLBEntry iotlb =3D {
         /* We'll fill in the rest later. */
         .target_as =3D &address_space_memory,
+        .pasid =3D vtd_as->pasid,
     };
     bool success;
=20
--=20
2.48.1

