Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6220C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4Z-0004ZT-EQ; Fri, 21 Feb 2025 03:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4U-0004Ww-3o
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:42 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4S-0005j1-74
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125260; x=1771661260;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4q+FNgT9HVsk5swidj6jJeI6FoYQL+sITZhOOFRxzsg=;
 b=mx1ZRS586zUMbJqHZZ/iP2z/CpcVhKZRF1Nw9z5/KbqP+JD0kgl0GX5s
 FD4MQyPasCH/9rbl5STJ83SLpCX48ejrH2K14sQiNHHlTYSoBeO3ek9aI
 XMSzx4j2fxFrBVBqoN7GZ2W+JGD/XCaAsRNh8w4XYF16/SYER9toWC5qC
 Qw2wwPoHF5a2vfJVSGOGFRx80rdWtU1H4n9ai/Qjb1QTxZag6g/UMl4oM
 02grqmXn9lcPEb93th1TWFOjx55QLywtXlp/17Pf+YQaJrSy9tZ1cCkac
 3GcDxmUE86QUv3OJV+tHkv5T+ys5YSflcsCnF1vjjMyFvZiDnzAA/j0JQ Q==;
X-CSE-ConnectionGUID: YLsvwXuZRmq83KijIZl2Ug==
X-CSE-MsgGUID: Hjw5MI5bT4GRZGLQ9inNjw==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="31394134"
X-MGA-submission: =?us-ascii?q?MDEbh+Jbs1DblYRiT1T26lelfA5oOsJSLTpXCL?=
 =?us-ascii?q?TgpSkxQL7FV/AKy3dlfmzMR1LdtHQNh2/hWkzUeoqsslFgyAv+hGlpD6?=
 =?us-ascii?q?pCm4xj+bNxU4+c0ZHvVwxnYsdpAAOPEOPcrp3D3wbNsvNx0o7j6W8R+W?=
 =?us-ascii?q?Qaj9hqSOqtTwx4PRRImZ0z0A=3D=3D?=
Received: from mail-db8eur05lp2111.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.111])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:39 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxRH4jIoK2v3R/Iz5KNywhx3P1NF42TF+X82CphmJ+lJpTlw+3ewen8DHxVulGwQUMVCoy2LQl40rqgR8a4WoP350n34wpqzDglZ6pao3RC7jhvsnfIbVA4f18WSQ/0igK4qgLjoSJB3A8IrCJYJ+J8/sSOdlq7nA6NQEC0zkDvG15cbrqGiAtZ2UUGXUMBNVFlTMr/2zozm3MDAR0+qsT4/8osc/SC7J3qqao6i09ThF/lRrsBncDpfqkD3jJ9ROgLRgdeLArOOzRGYHFHBYV6nsWDvb4H7mr6F/L0DgVJ9PjNaGqnnZWnWhohgIm2dn7/pahbQOs5icCTy5v0AZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEmwoWOY7veZvqndImfbubbycqeBF+qn+7KqkGGtMWw=;
 b=bLh10glC8Z4+/FwAPaa5ZlDUZhMFUpR4Ofh06jR9Y++IZuJPjY7bs6N3a9962xM1elz7Wl6dA0ScPzRikDTtjZbdiUVpl+4AiimUUFmwtJbOlODS8/p0SjPoOrup3kODJOC0KLt9Qqvs1fKiW6n1Bw02fz7pJEaGeHtaFkHLZvAD0gEP9LJWjlN7NOL8jXUy8gvad68IuLOshOjK09f02OSmG9n1qPsK/La+2K7EL7rzLbnoC8fEgJt+XM820V0zYLtc49i1NBTIwuhTwIaxoFthn7ui7R/ncp9cEY82nDOTRcyFVXwygYaCs3q3JQbh73L7yn6Q0zfHApxGlIXGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEmwoWOY7veZvqndImfbubbycqeBF+qn+7KqkGGtMWw=;
 b=YMFSVcXAGAv5CjEtLO/flfWEOGfWxJkojL4Epk+jW2QL8t+Jzd8+W/mT1Rxjm9YZj3pSwcO2FaLIDKRfkE5V/qppE0Hw1yvEyNhFfTwPiDNYs2Nd4jMFm43ZIjOxWB/2V/bnGYH/CvAn4osAY9pz54zEkec2vs72UxpK9fGDMGWBFPjV0rkFz+C8AyWgadXsgpPmsb5LXdUn0c6Ctqxa7CHmbcf+gTxQWfB4j/BOD14CxtmZkxeSkrZAlxxq1rNcKRAyOP+ZFIpUTzFh1tYSZuJfEyCXdlFn7RsuwUkXg0u6tbJsFS4nrg6Tce47B+aj5YobjRkIetT4cUN8AgWMUA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB8162.eurprd07.prod.outlook.com (2603:10a6:102:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:07:37 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:36 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 08/19] pci: Cache the bus mastering status in the device
Thread-Topic: [PATCH v3 08/19] pci: Cache the bus mastering status in the
 device
Thread-Index: AQHbhDeryfK2GuqB9kmdnlUzetIV/A==
Date: Fri, 21 Feb 2025 08:07:36 +0000
Message-ID: <20250221080331.186285-9-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB8162:EE_
x-ms-office365-filtering-correlation-id: d4ce08e2-ebb6-4e8a-90da-08dd524ecd7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bCdK67h27PZpBMcLGTP82WKhFjvrgku4fWh61P5k3OyZZOFMjqcjpZISaR?=
 =?iso-8859-1?Q?75wByER6Zgg12i3AtQJUYdxGNAi/Rba2a38dpnBdtcy7/RECdLO4HlFrf1?=
 =?iso-8859-1?Q?Iw1JIJLUhdMbITvz6++ur8blc5vWXfJ/G9p8KfQuPBe99x7o5ZykV4J0P+?=
 =?iso-8859-1?Q?1KCSo+lLotddmUUuhaaDqXQLCrzKPUEMMdCd1GFnnoU8Ki3V8YJF+/DE6U?=
 =?iso-8859-1?Q?Lb4iwDKyPPApIf4ysIlbD1GSfQuQsyHFZ+a9nFMFNHanJI7KIyBLRHaDDF?=
 =?iso-8859-1?Q?B9Jy+T4ypHxI7L+kvIi/cWPcPXfHAyM0CTyj8Nw3FLpYDoJ9do7nUFlY4M?=
 =?iso-8859-1?Q?7fWUWLkLFcsLlAtZc6ljrFaR20PljhaHFcKGmHuNx9coXZwNDN5u9Em8zC?=
 =?iso-8859-1?Q?ALYK5cgpah1bKvimCJEF7ffwv4eqMCzoZPTwfAJcvNRQ+xWaJdfBQBEtxy?=
 =?iso-8859-1?Q?yTiNg4W3tWZK7AEGOmbiSTrryoWz98FtdHriNnQkxfHzUsKwVKZA5v/f/q?=
 =?iso-8859-1?Q?PK20DJPn9SZq0yxrQjmhEdY3xihnyaRym4Mww9xoy8ayY8svbHwLQ4wuFo?=
 =?iso-8859-1?Q?jv4Psr9gzbwbdrxzwjLbJmMGK97MxwyaG5hxO5SnKvLYFgj/ypcmEMh00R?=
 =?iso-8859-1?Q?Y3N86dfOuKHMyKJTRNLcOZz205jEXwmW0IbYDx01z7N/14Pzi8AkDSTqEb?=
 =?iso-8859-1?Q?/Kba2FpceIf4naKq4mNROQ591AqmzIzAFK7aKMxS0hT/Jb11glJuawefEE?=
 =?iso-8859-1?Q?BfIanWAQRl9+3xVdEJFIV6CDW7f4VJZT0WVd4RXuzpWi0C5zle3/mS/dOb?=
 =?iso-8859-1?Q?r3eQ/dfqS+Z3KCxsH4z2rZeH0Io8EC8W+EwmLnjYu6ptPH23/i3bsjT8z7?=
 =?iso-8859-1?Q?t7qp5LBNh/vnSozjZzgGTVKmcSD9+VSFEWktTXYHrlEqYoVR9ZKagcqZwJ?=
 =?iso-8859-1?Q?Q12TkHLdenBw1lRLGTzMydBYqbtMvM/xKgcllgya7+Mja9n0sAIbA+uGCk?=
 =?iso-8859-1?Q?/LyiY/ehkfQFFDKNueHJ96ZTvrmBBgYBZ9hpOuIpF8eV1p3CSHMZTSvRUi?=
 =?iso-8859-1?Q?v71BS1u3jzuhLOPDQftLec85rKrH8tujmVabSHmwsXQgpSOs1Sq0y6iS31?=
 =?iso-8859-1?Q?eRJpxxcJFzcYQHuzXOf6gcn8y7jxZSXy44rNO1BCOFyMR/MA2Hl1vgdkOK?=
 =?iso-8859-1?Q?9jc24USYdGPAAfHJG0tXOHWhl+pLqNhSdYVP2Uh8o+46LZJzLui7MXk83T?=
 =?iso-8859-1?Q?i2GlBqWcH2GTJZliIgcfktjBd68w5C3KZUKmqYo6FN9IhscbMLm7g7TeJe?=
 =?iso-8859-1?Q?WOUdUjmN+/oF/q5c+mlYRPHzf9TTZgeZaeov+RWisUpjbxiOq22LQttXsv?=
 =?iso-8859-1?Q?+IyK5r2pRGxg+0Rg+FWr9Vwaw2PesZwFPEi9zVcOuYDzwESjNXzPzLErDW?=
 =?iso-8859-1?Q?2dIQHygdhskTqCdGs705XiMQRqpm9672oeJnsC716pJARi1f8GlJgsPeHx?=
 =?iso-8859-1?Q?sTFoCxZUmlaNszjoJbII8n?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hPnis01xy6wuuWtsRqU2pR/6XH2oK3OmuooQc3Dq1qYmbuyoSrOz+V9vmg?=
 =?iso-8859-1?Q?LoHDjrwrW6Z83Q/mPgDxzMRbm2ZPKzIr/fExsSzXGZ7oNMM2E1nERL1dnZ?=
 =?iso-8859-1?Q?JMFxIHGnyS0DW71Nohz44OBTRsBFLmpkFYAeanbqtqrS+iY53EymoEBnZL?=
 =?iso-8859-1?Q?K0ZVUeDQRUYnH+t3TANo22yLzS8QPtqFEMEVf0TPXzcOYG7U2NNySP5ycY?=
 =?iso-8859-1?Q?sv7+5ivDHTtz5f2W3jtG6S/AQW9NOdZ69i1jEZ8Dccr+ZCOXC1P/qVxDeO?=
 =?iso-8859-1?Q?sv1idV2iuV5EIMs5goFK6YYKbZXAMYxxtirpGrwXLk6MSai3e6CL4cOSyG?=
 =?iso-8859-1?Q?aQzE+f1bCjIJpTKVa7qS2RiMeD4Hhu7jSaU3j6HMZTYg5g8MRDpOIEdQ7K?=
 =?iso-8859-1?Q?C8p+bxxByeMkfneB3o3PgtHPfwxR9XGiZAADtQLMk9G8/1RTroTlmDla50?=
 =?iso-8859-1?Q?aOAQp0/uMdNvvKodKVrMIb9ZINdsBJLGQuf0JfOah7Uc1zxfsJnZiZHCAo?=
 =?iso-8859-1?Q?/PqRqj9sJqC64Gbtm+9WITUF73KcN5iiKnGE/PqxEpnXyu8LVmpVubETsl?=
 =?iso-8859-1?Q?3hYRdaQPiDKp9KAeNUslaE1h5bj7HtZeQRJwADUUoGBl8ASvVyNIA0t+Ul?=
 =?iso-8859-1?Q?3cP/7lJKb2zfyCGb9AEhISb/BrNxHfTgVjalEou7tRwgz8oM98m+zRCiL1?=
 =?iso-8859-1?Q?OYSPdCe57ClmO6WtCTkyrlfbqc40HrMQOSloUYefw12n4VNRfDGu0YL1ea?=
 =?iso-8859-1?Q?L0LIHzZCCv2z3pIftyEn9mvlATrI/FOqscoLHPwMx2bCoq278mLI0Xe+9M?=
 =?iso-8859-1?Q?Cfnl65ipzc6RWMcMnWK92wBN8e4NGouNGxfWa2t65z/E7fyfmT6XKxNn4i?=
 =?iso-8859-1?Q?Xo8tjATHAtexPeHFxY0Z1NTCZ/CSUOJvMsGRFmWxORsmg35ln4SyDW2Dvl?=
 =?iso-8859-1?Q?JQ2amR8+4pwN5G7NEB/xG9QSgMJnaOZLHLMfi1VSxf3g2OruuKjcCoUprB?=
 =?iso-8859-1?Q?si5SFsCOcmigwydwgJtHQ9MmnRfizHwtJCtFpiI6Mr+pZdjvlesJMx6W0z?=
 =?iso-8859-1?Q?/6KI+yJyXbKOv9nZ32Tz7ODl+uZYbgN7wYAdKThax37FUB+fucyHHj/itp?=
 =?iso-8859-1?Q?oeRvnUt3x6d4erENEBQ9s/bcSbfWxbVa9/vsHGJ/yGB1uw+jwgG9Ch61hw?=
 =?iso-8859-1?Q?xI5Af/wzIAY1whBCBzFigkm9tVOeB6BjuVpDveVPt00cXSEYCigRMA5WL/?=
 =?iso-8859-1?Q?nqzr7AVIMiS8+H0byfNZqxFEP1E53p9AxSlSExpPUY7X1Q5JVyLxyoLQv5?=
 =?iso-8859-1?Q?a0+YOKMMDMz2EHiQiSDeVDLp7Cy/8hR0RZGdiyvzALkp039x3TZvXCuzWn?=
 =?iso-8859-1?Q?jZBcLNBvUBHJnZhCq0HOFecQmtHRP516d4byLxlVw2SH4C0j9jdW6XcgVl?=
 =?iso-8859-1?Q?JdyGcj6oLc2t6eMXpv3RIngU6gsP5Km84CdEJbQFNS6ksEdJ/fGyFWRMy2?=
 =?iso-8859-1?Q?hjvIapaIsztOnMFx4BOcayBg0QYnJuOc1JcLt46kyKsyu+a16Eaq4Kt0sQ?=
 =?iso-8859-1?Q?QuhcwcLlKXFig5wxo550az2rJFix7QSIv4m3rj+rBhKUTbsWM2+wrAoQdE?=
 =?iso-8859-1?Q?ppyZNXPSw0/0Ur2pW1R6ghFbiV7bn/f7Ra88cL3+G6ZpLFFUege0IKkgsK?=
 =?iso-8859-1?Q?VJVv5/84kpvQEQufVZ0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ce08e2-ebb6-4e8a-90da-08dd524ecd7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:36.4768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lh5VYBDJ308vhF8eyADQZgGuOfYN82FNrmbHOZogN4PtwfHVRYtchQNP/PZ4YoRvtv9vSJjpayocRD1ZGZrUwvSeDY4MEVty8BQuFv0qdUmB7undgASO3F7rW8I/QnUz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8162
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

The cached is_master value is necessary to know if a device is
allowed to issue ATS requests or not.
This behavior is implemented in an upcoming patch.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c                | 25 +++++++++++++++----------
 include/hw/pci/pci_device.h |  1 +
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2afa423925..164bb22e05 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -134,6 +134,12 @@ static GSequence *pci_acpi_index_list(void)
     return used_acpi_index_list;
 }
=20
+static void pci_set_master(PCIDevice *d, bool enable)
+{
+    memory_region_set_enabled(&d->bus_master_enable_region, enable);
+    d->is_master =3D enable; /* cache the status */
+}
+
 static void pci_init_bus_master(PCIDevice *pci_dev)
 {
     AddressSpace *dma_as =3D pci_device_iommu_address_space(pci_dev);
@@ -141,7 +147,7 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
     memory_region_init_alias(&pci_dev->bus_master_enable_region,
                              OBJECT(pci_dev), "bus master",
                              dma_as->root, 0, memory_region_size(dma_as->r=
oot));
-    memory_region_set_enabled(&pci_dev->bus_master_enable_region, false);
+    pci_set_master(pci_dev, false);
     memory_region_add_subregion(&pci_dev->bus_master_container_region, 0,
                                 &pci_dev->bus_master_enable_region);
 }
@@ -727,9 +733,8 @@ static int get_pci_config_device(QEMUFile *f, void *pv,=
 size_t size,
         pci_bridge_update_mappings(PCI_BRIDGE(s));
     }
=20
-    memory_region_set_enabled(&s->bus_master_enable_region,
-                              pci_get_word(s->config + PCI_COMMAND)
-                              & PCI_COMMAND_MASTER);
+    pci_set_master(s, pci_get_word(s->config + PCI_COMMAND)
+                      & PCI_COMMAND_MASTER);
=20
     g_free(config);
     return 0;
@@ -1684,9 +1689,10 @@ void pci_default_write_config(PCIDevice *d, uint32_t=
 addr, uint32_t val_in, int
=20
     if (ranges_overlap(addr, l, PCI_COMMAND, 2)) {
         pci_update_irq_disabled(d, was_irq_disabled);
-        memory_region_set_enabled(&d->bus_master_enable_region,
-                                  (pci_get_word(d->config + PCI_COMMAND)
-                                   & PCI_COMMAND_MASTER) && d->enabled);
+        pci_set_master(d,
+                       (pci_get_word(d->config + PCI_COMMAND) &
+                        PCI_COMMAND_MASTER) &&
+                           d->enabled);
     }
=20
     msi_write_config(d, addr, val_in, l);
@@ -2974,9 +2980,8 @@ void pci_set_enabled(PCIDevice *d, bool state)
=20
     d->enabled =3D state;
     pci_update_mappings(d);
-    memory_region_set_enabled(&d->bus_master_enable_region,
-                              (pci_get_word(d->config + PCI_COMMAND)
-                               & PCI_COMMAND_MASTER) && d->enabled);
+    pci_set_master(d, (pci_get_word(d->config + PCI_COMMAND)
+                      & PCI_COMMAND_MASTER) && d->enabled);
     if (!d->enabled) {
         pci_device_reset(d);
     }
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index add208edfa..40606baa5d 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -88,6 +88,7 @@ struct PCIDevice {
     char name[64];
     PCIIORegion io_regions[PCI_NUM_REGIONS];
     AddressSpace bus_master_as;
+    bool is_master;
     MemoryRegion bus_master_container_region;
     MemoryRegion bus_master_enable_region;
=20
--=20
2.48.1

