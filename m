Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723B6CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3ml-0007Vo-Ge; Wed, 29 Oct 2025 06:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mi-0007Uz-00
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:52:08 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mY-00020O-JV
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1761735118; x=1793271118;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ApG7ak+vlrCQbDluYNPUCkXVIWilYJoaypLrM7BbS70=;
 b=iGpDqZFfcXsuOeaQL/9BGuMV89PE9YSNuYkpXiz80KMQKw081cUBXW9R
 lYVeBZLr/hP9YIjuX+cPda9S4woe2wPmWmMVlN9Xad17vNwgTSpaXp8Od
 zc4PrRfpT2sS3YW+PP3SfEUeV47bDcMK5RUp0gCNcFlgqH9sY8W4sRTtj
 LneFQ8Y4Pm+Zql2F/4rp1rpFMQxt4BItv4Mi9ku2y5e+KVNrXHo4wYa37
 hg5U0OfzBMvph+UwfqAFcQUH6ek973px1PLf5yEHgLsznlVUiYC9weNDE
 JYypXuXp5QMn4ZJBrQK9oNDMWuGj/C/24IoPCH0ExQkBNhHSRQT2kW5HN Q==;
X-CSE-ConnectionGUID: 5IOkg+SDQkmmzdOm1//YUw==
X-CSE-MsgGUID: 4mvAUlnPTHG/ztV+rdeTNg==
X-IronPort-AV: E=Sophos;i="6.19,263,1754949600"; d="scan'208";a="44178953"
X-MGA-submission: =?us-ascii?q?MDHR6Y8wtrUJK7L+WaGt/MRa/StONBAZIh3Oye?=
 =?us-ascii?q?5bbopA0EykgJwNElxHMn2xCJU8lsVc8rEHiotLZfzNyLcxkrwnZ8WQrz?=
 =?us-ascii?q?daQv8m14+t4C6I1rHaQCoEW/EweOUlsyWDHlooTCnUdyHo+Fm+6y5HIw?=
 =?us-ascii?q?zBugf07wxcob+6SHi2tiuKnw=3D=3D?=
Received: from mail-northeuropeazon11010065.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.65])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 29 Oct 2025 11:51:47 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDCDWniahYSvOVI2N3PlNVNUaUrXxZiIj6vWruj357y6kC7ONiVE5guSCNa/8w/kibkqvHSc60Wug9n6ypaH1mXnu8cV/LxU8qHdDywqy9PxT6j0Xh6EXh3s8s/919rlhgPw4vI13rQaLoc5EPUtJZ00RJwqhbJmPrY87aSKYBtTnLlM8bnUYYpOGaxuzZ44iH0CGUrM+896i33xI/GFsAm/gY0D2lZdSguNJLBaDocW2mUJ+evChoY8+ZV+u0PBFcP9wtb1T/Vv6W0sHAJrhpbOzPTdptCPOgkl+P+0VfMiSD6Oa1W9pf5NS8Y7r3wUu/zATm+IGZZHH32GyuwU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vM0DRkhbXsPzBYaVTpzFzGu5iiH8dibExnqcggTgVDA=;
 b=bQWfhMPzfF+2jijYqBrRMHVER2R3WgKDdN94IGPWz5HM+lJXJd5VH7oPexTD5ftNUBZeXdgTxdifqRbIITEfhBzI7/5t2LkcENDNV9f7p0aRjCiTQ7e8C9QCVOgjrNe0zgQgpCvJ/FzJJBi68WIe2BewZSKEkZQmea+1U7OdixNMvqU/6n4DiG4n2XAGOxrwyGgO2/vuTAZL5sGVzkX08JpaJJzA6iXS0+RRLUm5rPdCJliRguK9FVYrgbK8jvlJfb8N7z1iTaWwov5oxf0U7XssbNKB5WUxC5A+ikqxxfzMflFA7VprMiglUaKAJcw3clOoT2iC3E6T/1+5+W902w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vM0DRkhbXsPzBYaVTpzFzGu5iiH8dibExnqcggTgVDA=;
 b=hziM88pk2W4+zEkH8oSmWcYMeeNZxvdUJi6YpeUN3nNRqyYvjUp2DOmiLKH4RQZ5hRtGNecIr3HF/BCVp/FoyLHPePlPlFNOW9JPt8UQ0POquhZoOoGJY8Le+CXwdbg+ncE6v8JWnCJl6optvx6rBSo4TM2kca/cJnDLwI4F8mmYCIS7Yip/2Ek69KahzoW7im8I2071FeY8w1EAxXsl7Q0CwjOiqi5UnnK/pRSsx4rIAIw39+FXjI4uSQByEYt6cQHPD+tJe+TXRdT484EPPHgd/Ba70yUtghoQPcGXpmfYKfI17Geyhh3noysi/aHmdkVu9utTKyk3nNS2rkPXKw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI0PR07MB10962.eurprd07.prod.outlook.com (2603:10a6:800:2d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:51:45 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9228.010; Wed, 29 Oct 2025
 10:51:45 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 5/7] intel_iommu: Handle insufficient permissions during
 translation requests
Thread-Topic: [PATCH 5/7] intel_iommu: Handle insufficient permissions during
 translation requests
Thread-Index: AQHcSMIEFGk3vJOU6ECADz08qcJwIw==
Date: Wed, 29 Oct 2025 10:51:45 +0000
Message-ID: <20251029105137.1097933-6-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: cd1eed65-300a-4460-f991-08de16d926fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fc/xNxDI/TX/HPp7Icnwc58MFpOBBDMuAXlEFVo1ygKeF8PWa38DlThQXl?=
 =?iso-8859-1?Q?I3vC+24jAlMdnxeczqhqGi3rv7jMc0K1p1bP+ulBVZuH+i390UjaXYHF/h?=
 =?iso-8859-1?Q?/gBjr7h54AWyQypKdiKtTcw4ciXWUhOZOcEk7sSe2ffW5kMxwT4eysibOA?=
 =?iso-8859-1?Q?gxYtxLDASKgWkDnxxJsx1YC4KlCNckkMAGmbqMknkjgyAFZfRBoXjYXF+J?=
 =?iso-8859-1?Q?dVKzGVZm49aklgt0rBvbXxBQkbAKVKNMGkxI0siJclSM3WMAg/mrb3xcyP?=
 =?iso-8859-1?Q?v0VcW80aGS2rG3RWlOBTjTAy+F1Ogfq1x8ZvejJKIA7hmVq5PAZrmK2DVC?=
 =?iso-8859-1?Q?zsPgaepTK5tQF4cPuq1/H293v9kRvEI0vPu3PZQuJ35ht7QXCWNdoVOYls?=
 =?iso-8859-1?Q?XbNgTr8IkXgsWPOXcb0ZyhX/14/SuLc2dO57YXxt1Mndtj4USWcF6Z//TD?=
 =?iso-8859-1?Q?mzpUNxZEMjcgfKkGuPK+YbyMB1h9miUpGwBAkTnDe7n7sg7lPJWampZV+e?=
 =?iso-8859-1?Q?DjahGbvpTpYphja1tfuWpYoUYX0pI3G1lKss37VxzJK//eQLc1hvV6MDdj?=
 =?iso-8859-1?Q?7ii3feLwD1N1986cwJqqXlf6IlEGggEmaBOBBzVagaI3dS5eaXyIMGWVss?=
 =?iso-8859-1?Q?qwrRFjATDvHgMRufzAQ9NkdF12T1hHjUPaBe5+oKizmVFtUXzTslp13bK8?=
 =?iso-8859-1?Q?lfM7M+WOtFSXAei2ZqZ9U4zrb6X1MCSB601TdXYJwrRFfKuYTMNQmBVW8y?=
 =?iso-8859-1?Q?vFSVCpZZCMk+ZJ998kw2B80doKwoDY4aefCyaLpMMcC1Afj6F3KrzpWROf?=
 =?iso-8859-1?Q?71w+c5aYjrKimsk+P4ZZZF+pTKrnFnrAhSYR1qKXOpO3Q9cDHEz/fO2awq?=
 =?iso-8859-1?Q?mI7eGRtr22xBo/wMkCD/deKkzARNsRlIOiSlaNFpO3xkMdqMBFBUu460E/?=
 =?iso-8859-1?Q?Hu6xBCKsDCJRMfKjqiKiiE+1ZLObmPKMxfC1e9JYHXfaBfrRO96PPz7hy5?=
 =?iso-8859-1?Q?7DpQLFKlBcgqNYGrX6t0O9fvCbNhL9ZQcenVnAGmYIb8tNLiKYtyq64r7H?=
 =?iso-8859-1?Q?BVkJbwjj4aX+acmlgT5SRIkPKCREQYCMW3cErjpa60j6eECib/Ne2lT1FZ?=
 =?iso-8859-1?Q?tKY5jZUx0LotXomM/SY0r0Mbch+6BpNekvpHishWvLKvNCuYl9vK+lcH8c?=
 =?iso-8859-1?Q?jpeyTknmGggxWz8BtBoyY0+OY8X5XL7Mj6RrAgjeBvlypNgI/C2MjVewU6?=
 =?iso-8859-1?Q?C1M39nWODq8mTGTQD8drDMDWgbLIQ2hdZiEZ9W7rDs+1TuYYDVvvHpsaqw?=
 =?iso-8859-1?Q?H0aJbhQljqIvehzP1cCheNYz8dAG8O0W3ORJYezevmyj/YMf9FJHwyfsaq?=
 =?iso-8859-1?Q?dnCv7VJO2OJV0C8ErdtYJcDGlVDaC9lTFndzH7GyMVszMwzT57cttYeZev?=
 =?iso-8859-1?Q?CTa3tE2tffF1Y6SjCrlD4QPC26nMbkBXzxB8qv3lxgi+gcewu/c5X2eOdX?=
 =?iso-8859-1?Q?XUr66HBsjRYMjnZ6vBAt3B4a3NTz4pXhicR0ousxldqVhPHSRbiEOBZZ0O?=
 =?iso-8859-1?Q?YXqSp0iNR1qHRwt9IJRcFMkpJple?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rD6HO4A0CxoVayEgUIw9eMv4GOsULeRdEJ0Fdc0uhbJtnKTj17z1gmldov?=
 =?iso-8859-1?Q?rYIjC28CxpHkWmAPbHNyGIJhyfL5N4R2nkP3FLLF4YFCBZ8xjTXaib0HEE?=
 =?iso-8859-1?Q?VoZXRhmZYLbAF5ZTa6LVWY3X3GgIBix8AYTTLo/YdgyFxjao9nKXUAHFVj?=
 =?iso-8859-1?Q?sg3fPV3MZ3ZeNeRGNu97SF81AE5jlWLm08ifgIg0MLRgESxfh0RuVb2ItC?=
 =?iso-8859-1?Q?64TWv5smyu6ZAnJaihJcSdf61gWv4c+Yy1HMqPCRpDMPIaFgriHZC9JhwR?=
 =?iso-8859-1?Q?HWdJW6NX9fJnOq8nLVZfHDYOXkXPveIWcMdXxtU9UsQ9ITrmmlk6rWgDP1?=
 =?iso-8859-1?Q?MRGaY7zIRK0loug9RYrWyJhiw3mKBJGj7rNUuv222NKN83M8r0XbvJ14iu?=
 =?iso-8859-1?Q?t/IU0dxbpd9vzn3DQMDiL2wCsPgLliZ5jFWMWUsgSXoXkvMKfH7NDk110M?=
 =?iso-8859-1?Q?0dwIjrdUqMkPBT8wdKX8diL5HswTCAASKp7xa7NsWclFE8hT0a9x/9dTr2?=
 =?iso-8859-1?Q?tcxUB6rcYZgi/JmXQvEEWKE66NTEPE1JQcFVfFVms8XybydUFne5DZRO64?=
 =?iso-8859-1?Q?13MH4m55g+TOG0luN9eoRgjCAZzQ7KHftaARmexrxMV50+yUui6ABY+Y3h?=
 =?iso-8859-1?Q?zgqb9FUNbAfPIZO8dSxF2etVvFNdepcOB6vdwOJhk5IFAVuDBWPekvvPBz?=
 =?iso-8859-1?Q?AAr74RG5qRrm/8iaG5dqNA0ogBLW7aAYAKcj0bzCDhelpEGr8G/8IZ1c/z?=
 =?iso-8859-1?Q?lSwwqrlktJPk7CuZODne261HpgtTtK0PRV9vOb9BVpnp+ZZk16ACO/AE5q?=
 =?iso-8859-1?Q?KYQjKhXcwKQDP0u0JTxH5+MRLUIq9Ws+VuE7xP3gnzgRJj8VcsO0KXuBP+?=
 =?iso-8859-1?Q?a9CmP4om6sNcecpZ8Fh9ZNI6bMH7YONLB8ZXmXWRjQQOC468cHhWrw5A43?=
 =?iso-8859-1?Q?7HlhO/vBgVS89U4C63nQk0vckbt3570I8t66n9mo6G8gLJFPP9farysOxv?=
 =?iso-8859-1?Q?ZIWzJRgwOjjwRfbMd5e12w5oEdOmJn2mDiZffgvLEBPp5mLtIVEnBO6OtT?=
 =?iso-8859-1?Q?59oqVb4MJFOHgzj/PfqpAyaOO8cYNaenkEISRCaL33eGPXXt3AfMDh9Rj2?=
 =?iso-8859-1?Q?QVaLgtroKNLxLlXx2k+LqdE+8a8hIFVKGhIUqXwGa1zuSBlvv/MtS1j0XO?=
 =?iso-8859-1?Q?WZ7cJRNQf0kr5cI6LNjmsC2WZdB/ekp2C7NkQzjLITyIj7gVIlPN9SLYp4?=
 =?iso-8859-1?Q?wFz8GbrCF0DF+dqAGWK8cNdv9dQ0og1lZIntKiDN0R298w0U5QFRDli14+?=
 =?iso-8859-1?Q?9e45sQzRqp9Fzjiu6bm6zSTq4b5YG55SgDt1KpwS6IBYXa1uh219jsK2Sp?=
 =?iso-8859-1?Q?zD5j8D3ZDYP4KRuV1kGFrjz6MyIsMGBgpTZc9C9hbb+TerMAnrwxfcVEWT?=
 =?iso-8859-1?Q?UM3+NGtMKiINHatgO5ETRUQGeiQl4MNDHB/bhPDISzdEXbyeAHp16srL/Y?=
 =?iso-8859-1?Q?ht802luyIAtxpQ4CcM0NQ4dDrpT3adiky9oAkVif8sqh594mhrstkEAw7K?=
 =?iso-8859-1?Q?yQuOi2OVskkH5cPOcjkTix9fePftmucnbTmkBD+RxiQU/P3FfMSZHICyrG?=
 =?iso-8859-1?Q?Pyy8WjrfipCpBP7j0heftbcnj3jZTansjfJvS/nALNa/J//e8BdS13EvoY?=
 =?iso-8859-1?Q?C3pPnzVngnb9QN8Xb0w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1eed65-300a-4460-f991-08de16d926fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 10:51:45.0495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NO4MYwAc8QuW/UvwvhL8lfirkYqSe84/iY9wE+c1ixyPA0/QWsppLtDI6Xr7xpQAYflvTgcDqasU51f6UBjMM5+mX47pm6oZZS7oloDnQSi4++gpnwBMUVGshR8czwca
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

ATS translations should not fail when the write permission is not set.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c          | 14 ++++++++------
 hw/i386/intel_iommu_internal.h |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9753f4bb75..e89f31da02 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1980,7 +1980,7 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDC=
ontextEntry *ce,
                              uint64_t iova, bool is_write,
                              uint64_t *flptep, uint32_t *flpte_level,
                              bool *reads, bool *writes, uint8_t aw_bits,
-                             uint32_t pasid)
+                             uint32_t pasid, int iommu_idx)
 {
     dma_addr_t addr =3D vtd_get_iova_pgtbl_base(s, ce, pasid);
     uint32_t offset;
@@ -2021,7 +2021,8 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDC=
ontextEntry *ce,
=20
         *reads =3D true;
         *writes =3D (*writes) && (flpte & VTD_FL_RW);
-        if (is_write && !(flpte & VTD_FL_RW)) {
+        /* ATS should not fail when the write permission is not set */
+        if (is_write && !(flpte & VTD_FL_RW) && iommu_idx !=3D VTD_IDX_ATS=
) {
             return -VTD_FR_SM_WRITE;
         }
         if (vtd_flpte_nonzero_rsvd(flpte, *flpte_level)) {
@@ -2080,7 +2081,7 @@ static void vtd_report_fault(IntelIOMMUState *s,
  */
 static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
                                    uint8_t devfn, hwaddr addr, bool is_wri=
te,
-                                   IOMMUTLBEntry *entry)
+                                   IOMMUTLBEntry *entry, int iommu_idx)
 {
     IntelIOMMUState *s =3D vtd_as->iommu_state;
     VTDContextEntry ce;
@@ -2202,7 +2203,8 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *v=
td_as, PCIBus *bus,
=20
     if (s->flts && s->root_scalable) {
         ret_fr =3D vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
-                                   &reads, &writes, s->aw_bits, pasid);
+                                   &reads, &writes, s->aw_bits, pasid,
+                                   iommu_idx);
         pgtt =3D VTD_SM_PASID_ENTRY_FLT;
     } else {
         ret_fr =3D vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
@@ -3827,7 +3829,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryR=
egion *iommu, hwaddr addr,
             }
         } else {
             success =3D vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as=
->devfn,
-                                            addr, is_write, &iotlb);
+                                            addr, is_write, &iotlb, iommu_=
idx);
         }
     } else {
         /* DMAR disabled, passthrough, use 4k-page*/
@@ -4923,7 +4925,7 @@ static IOMMUTLBEntry vtd_iommu_ats_do_translate(IOMMU=
MemoryRegion *iommu,
         vtd_prepare_error_entry(&entry);
         entry.target_as =3D &address_space_memory;
     } else {
-        entry =3D vtd_iommu_translate(iommu, addr, flags, VTD_IDX_UNTRANSL=
ATED);
+        entry =3D vtd_iommu_translate(iommu, addr, flags, VTD_IDX_ATS);
     }
=20
     return entry;
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index 3a1f7a1d99..10a452c0dd 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -664,7 +664,8 @@ typedef struct VTDRootEntry VTDRootEntry;
 typedef enum VTDIOMMUIndex {
     VTD_IDX_UNTRANSLATED =3D 0, /* Default */
     VTD_IDX_TRANSLATED =3D 1,
-    VTD_IDX_COUNT =3D 2, /* Number of supported indexes */
+    VTD_IDX_ATS =3D 2,
+    VTD_IDX_COUNT =3D 3, /* Number of supported indexes */
 } VTDIOMMUIndex;
=20
 #endif
--=20
2.51.0

