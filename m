Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C0BC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbXf-0004mJ-1G; Thu, 27 Feb 2025 05:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXd-0004iX-82
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:57 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXb-0005rq-4U
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653695; x=1772189695;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KHmNcLQuspPA0tQxBlqqLb1prhzBBBLWPp+69jOVVMM=;
 b=UjFGuU8LJ1Y9KHBm07nluGQyrav1IbpKAUsfYSw8v28aZqOwIZuaERCw
 b2+MtVKm/l/Hus9aYylZ/CkmhanW9V6Gn8zKapTZHRgaJf+JKM0mjY/zO
 CNkfKL6+POqJkO6Dew5GklKPwb5AhFN55Uc6S6A2MlEb4KSG3i/4ZuVZs
 JxXCvLYlHFnzZa7koYglZpZH2tiR49UPDDmHGR5T7NKUFXtQw7Z81ak8c
 ow9BhYRRkhxQzzj+qCbuVegcb20WQE80jUPdgjwbsK42xnBWYufJPxka3
 WzYIIFR1Yj54hvGozRrRjhM/6mZ59MM+7vgNyAr2LrqNAZMBAc+WzZYKf A==;
X-CSE-ConnectionGUID: 9fP/aPLHQ3y/OITZPFK8JQ==
X-CSE-MsgGUID: Ia/ARBOwRM2fDGF3i3vmfg==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="31820749"
X-MGA-submission: =?us-ascii?q?MDFG9YMZ0PlWcFzStPSwpeJKlKgk8JyYgsdZel?=
 =?us-ascii?q?hmbQFARAoYHi5HAgZvqS67daMCPb53KLpHo4IOUQYkWPi7Bx/8HE1o4o?=
 =?us-ascii?q?HTQV2TsKvcsgGH4NsOurAC/yGhOewaYcA00HVs4t7R/eECDvMBNQeEIk?=
 =?us-ascii?q?xFlcWvb9TEscyfOZ8rfuZ96g=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:52 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3jKhOnU5ZC2NZChiwvk9KlO049r8raKuOavU0K2uLNSwDQSfRgKYG+imSObZqQaJFc8pBnuKTXWAWc5al6RyKwh4qkQYF3ztTwrBKtO9fsvNdWxcAjrFzYz5aj3Gdh9EFGJyJzARTC14qvCl9OXljs4uppM7otnxzralO89mPdR6zFrBU8r0EyiBriHgYTodfR0TQBTKqocZcSHApS/8lEqAcYV0lgPfE+K20IeI1aawnM25FLiDpoveKodEefsNWQD2owhopzj3kJlQ56NbzI1sKdJsj49akqIXUaDxlgrg48vnhx5YTqixA2Z1tAiMyeXlEi9Rsn3QKYEVVhuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+ubVhNTRgk5dT7AxWnjpgCltzcIrfiIgdWhE8OQaus=;
 b=KhNpIjYazJNHHJdpWDHqhmkG4Ywz4o+WpIt0aGdNVMO3H1u8cYXbRwYPqtwH06rM5riKzBjFGAH0gZaqi0nYnyGcXoDhMshVFdn4vQq5rwRLQAjefWt7dt9tAtjb9Gwkxj6L2yaC5tka0LCmzlADBxCu26t3emnZ5PDM05vX4C9EohDq926jgDOfWY4MohR2vFpD+6dfpuI3SLU1xFDW9RHUTGkuttYZ8k93FOrgI0gItdk5/I+xc4WgcqIaRIYgkMx6k7gM+Z2fj6TkxTGTRDatDi5AgmNG4LS4B+8/N8mBuJZuPWh8118AbDqfZDLGrzWAl4JRThdpnEYrdA0VlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+ubVhNTRgk5dT7AxWnjpgCltzcIrfiIgdWhE8OQaus=;
 b=V43zOU/6R5KaDRaltIO/8BYQLAgZ3NgGq4HB8zDifN2xmS4+Tft5KHosWUjFPuqPEzDpXpRO2vSWiJt0XsziqyN6AZv8WoJRv9Ox284la26vHiIwQGQ8twDRxJ4s95zO62se+0d1Iz95Wif1k4URtH/Zf9gyUXEukMHQCWkELvjTHZca4AZpWfkJFy9ItBv3D7KEteqE1qWA/0xvq5ivPEbNjyfm6+oElIHJcW8RkbZEMWMZPBEfKIyVudd1mCXGMuA5GXkm4IK4DkkAYZCi666AI3Ty3kXqw4gLrEHnl2EDyKV++JeW1F43PDEB+6meP3WFHLJDSBvTYshcdCFnKg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9097.eurprd07.prod.outlook.com (2603:10a6:20b:558::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:51 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:51 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 19/19] intel_iommu: Add support for ATS
Thread-Topic: [PATCH v4 19/19] intel_iommu: Add support for ATS
Thread-Index: AQHbiQYGlwF8m46GsE2rkhzmNVJnWQ==
Date: Thu, 27 Feb 2025 10:54:51 +0000
Message-ID: <20250227105339.388598-20-clement.mathieu--drif@eviden.com>
References: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS2PR07MB9097:EE_
x-ms-office365-filtering-correlation-id: 86c24931-688c-45c3-454b-08dd571d2907
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?yfyrVtlDwDrhWrslpUs+e5EmxkumRpF+9ow03ekQ3XldeJYo6l7Fnksn1D?=
 =?iso-8859-1?Q?Rgoxp0Qk2MfN9fNXqwj8iSEGGBMDSyO4WVdkTPYrVDgpbJ2K1yJjxp0Asv?=
 =?iso-8859-1?Q?XK62Ebeg5PDE/Wne+qcCAvuuDdK3O5Yl/s6rba4j0QskkfQvL5+auCfNHn?=
 =?iso-8859-1?Q?ar3up49HQI7vWJZJrwjMuhGofjeElmRcdQumr4gJXV36mM3By5eCJoovlw?=
 =?iso-8859-1?Q?1lbWxwnyiQcFrPyNuX9CsbSBitaftsBgEZnFFwsYsOeLcG/klzvORhHRTj?=
 =?iso-8859-1?Q?yFjQBwUc3iaRQc4h37XNOsYFbQ6iZfZ+y2XuzKDa4SWSn4flOVOjaL6+45?=
 =?iso-8859-1?Q?PH+ZQDFBRuqtoA7TiWxsUtQ896fakIBG/qO4nh5LDP8YcKx/5/5B5BPLMs?=
 =?iso-8859-1?Q?N5MKL4tyzra77CuIUTrjzD3Q3U+3tPLF+m861uqjmP/s4Vw96pIjY+64iK?=
 =?iso-8859-1?Q?C31vD5rK19RW2KPqkZOeLri4rFlahsUMHpwVMYBswXWk99sb9u7fC+ldLU?=
 =?iso-8859-1?Q?qEtDZWos2iuX0ig0rzhi7p2WEDd1Y1uwgp7MlTbF5q+bYKQwHERz8mHc5P?=
 =?iso-8859-1?Q?uA3A0tPMmmzDGhtTVUznptkVUJlDusZ4ikmTUSujttSkUuH3TVrWD9fVdL?=
 =?iso-8859-1?Q?ptZjjfbB8dSSXm8JZLkfDpwDJ1fdox/MaSaosOBxTS+x6nTpIuFmj377+W?=
 =?iso-8859-1?Q?5ZCLAdpra1gZUPbzfiYubUhrHd72NgQgzAYzwHLPvvZc9VyJ/w35tZtjnK?=
 =?iso-8859-1?Q?XM7g8XOXhp9QJTw5RVCQXzHCZASCVpfU+mMEM0LPCo/f98pMOsz1lZLTdL?=
 =?iso-8859-1?Q?Sbxpz6L4kGdZbSMWOmx8ECa7d42kmHOnCmOoVkPfSLl9TVDz98QV0El2+3?=
 =?iso-8859-1?Q?lbYHpgN1dY252vJJS+puMoIllIghR2J7zzafJLwzHEtVAVivYO9vU2zVvT?=
 =?iso-8859-1?Q?KjSxVhF5JYAJxsz81ZLnr4au/DZlGKdMD5UJ5axSJO+4OuVTcmENCX3+oz?=
 =?iso-8859-1?Q?/HNpiBX6nOS6FHFcVceClaQJzcUF7Tg7W9FDgZUKNVQUIxGew5BmOQoGyQ?=
 =?iso-8859-1?Q?I5fmM4eMVgmGbPS0Kip2RDDO6s9o+0dbvbGfnkQnOJX9qFRrAWgebYWrix?=
 =?iso-8859-1?Q?8UKz+8fSeaKNqnwuCEgvRJRWlyCzdJiQPNqyjAFleMV1oSLSghIgo3Zu/+?=
 =?iso-8859-1?Q?Ol1RV6mQ98/YFOYEWA9yH/uK6AiKWhg/8cSncx1lYyyG7RuVcBoA4dl8y2?=
 =?iso-8859-1?Q?UxtcuIVZqbCmXITYvApKwTjNsfyEvhBkwEKy01joeevpqAn1fSJc+oneXx?=
 =?iso-8859-1?Q?wjXMLvmGNWf16AForvchBzQ+8PBvwqkpP+Qw+v4o+f4rd5AHqQ96LdEHq5?=
 =?iso-8859-1?Q?/Cigy3MptSjPl4Q1t4CZ4QJZys4PR75ilmoNUpfX3Gc7/ua9Ik8VYzwWt4?=
 =?iso-8859-1?Q?vsgWFVLP4J/xjqvyVlDS/FFhAxes/6T1qX5tzAF/hnwfhZIaFp+BGuOTTx?=
 =?iso-8859-1?Q?+fc+rj1C+2gIzW0gmKkhUo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?buKAJ3kmIgF95C8VS/ZsbzyfI8sJEht+7q4IWZV7x36FP4zPDGdfrmlW5d?=
 =?iso-8859-1?Q?G7BEIog6L+97trftIwQE0FGvCyIbEJT0MUIYvbkz71aPDk5RK3kPpSaqbr?=
 =?iso-8859-1?Q?pzmYnB4L/aAuugW8np8l88Ti0aizyYHmP2fiTVjrKbWQN1+q/nyB+AmraI?=
 =?iso-8859-1?Q?CaYSygGeEMU+oqWiT4lby8UG2dPp5jD7ttNY6jmubTOdpDzNmT/GumqJNi?=
 =?iso-8859-1?Q?9zuWdGKt3ejQ1WIBGIiSwFmYj2nJ7T3dbghd+Z1/MwH0QXYCfrORKn+hFT?=
 =?iso-8859-1?Q?qNRLC365dHknZkTQ86E6B2JZ6nccaMLGaVyrw+EAbG2GKgf2f0Yy/z1+qf?=
 =?iso-8859-1?Q?MukOyQMmKPWwh9rbESlKqf3VEIn6RkDLbnO9/zG1t5E36zop8ds+hxYlyn?=
 =?iso-8859-1?Q?PJTiwZj7FqI4kSgOV3l9C/CcL9btht/34vUE6BJlnPuwZejOfdLvy4VwZ1?=
 =?iso-8859-1?Q?GaCblOXAzwH9ZaBz/Uwgi5vUoiQKRN3gv5+Y3Pizu+bH8j90v5V75brzq6?=
 =?iso-8859-1?Q?m+WJpKnDodmdg0B1IQ5t9h0ivjJKmUsbH7YpHR1aE5MZEU2i6VI+W3JVuy?=
 =?iso-8859-1?Q?6HDavyEQCqBug1NbTn38eo5vbaT1MDQgyv+DtVo0OY+MTYjrRssYlimXJr?=
 =?iso-8859-1?Q?4l09/neEEzSj0Ohpxy70i2iWB/MCHJnDPeHmkNUA1px8dIzT9nR+V7QK1K?=
 =?iso-8859-1?Q?vZCruFtrM8tkH0z/0xpwwav9hkLZPlV7YzLddLr+t0o7R8q91WNt8ETBEF?=
 =?iso-8859-1?Q?jqZjXRZWQ8RAtjusAEW5hGQ1XPlrSanjO6nJzHXjPlq+OD1JRiWtxkMyTe?=
 =?iso-8859-1?Q?cJHWHjqa0zMrHoUvWiX/Yzi/T1xOjkZ+9YgE5pi6BC9H+8ZEjmjHMqyJsr?=
 =?iso-8859-1?Q?w2bkS/DhAzbsVQ8EMU2HgCebw6OA4wC3Ht37xKdYOVGn4PmA6iVVPysKYN?=
 =?iso-8859-1?Q?IJHbqHr0/hQbYf3DqdYAo55iqadHjGi/iGEuoAjRGWefuU5LGiHWr5gK81?=
 =?iso-8859-1?Q?7RC6ti63BPgFGHQWIb/CE6pPwest1m+OTUhLnEFRsoxzZ+Dmf+Phd8OrRO?=
 =?iso-8859-1?Q?ZKJMDLcQaDHkBcWRnQNdpJ+VGT5EhFddETV2EQpZWvVqzUFT836uYW0pPW?=
 =?iso-8859-1?Q?kq2BOzHVdVj9LNmv27lO8RQ4wcrVWTfmCs0hUY+rvj5xmwKKskkM7e/Xuk?=
 =?iso-8859-1?Q?hUJSrjzAWWWRRNIk6E2OgSghD6RmtHnZRNzdg2E8aPtiLyA9EEpdVQbQFg?=
 =?iso-8859-1?Q?0PbUoWU9QzI08W5fwMh/p2KGInTJhHndFbrHTu9vVDhRC3/6e4dcgYZQg9?=
 =?iso-8859-1?Q?wSkG9pSuJUBm7JFiAWo2760F6vQ+jgTHQdmqDwkW65+z5gsEtXN1pAdDQB?=
 =?iso-8859-1?Q?YB5xEHl886jJ9KWugGkZhr3GbIG+Tu6D3zLL7GQv0yxBVrsDF7/khewrLW?=
 =?iso-8859-1?Q?oe1KJZor6CRFowLAUFZNscUi2/YYuliUhOLccjp9N6vCJ6lB6Yd3X/WTE+?=
 =?iso-8859-1?Q?FuSZg1Dp4xzCElCFJB2SC11P/23TMjTilfHTWcMdG0jrgxd2ZRY8Bl58zy?=
 =?iso-8859-1?Q?qMm1qQvvi0UdJdCiiuYvIXGRfj7Y904mWA/RhjgLU0Ih/0cksPXe1Tx5L8?=
 =?iso-8859-1?Q?dcYOYagiZDjElMAkry0YYo+Xz0fQM4lLZ21BQT5kEEGrJoGroBDsHSEEiP?=
 =?iso-8859-1?Q?gFIxqUH+eHWcTLzI0bE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c24931-688c-45c3-454b-08dd571d2907
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:51.0219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wlvWaqbnWqhY+OCKvCxBtn6gJv3cq5vV8oDXgvUCT41yd5brajUKGJRJXBr/QNRfvowJ1a2U/giCMCdDjLlZgqGSBqF8boBgW0gHNq8ET2D0g2j31XjF/wPzsnHxYoXz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9097
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c          | 74 ++++++++++++++++++++++++++++++++--
 hw/i386/intel_iommu_internal.h |  1 +
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9daf8025cc..2b1c733d86 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4159,12 +4159,10 @@ static void vtd_report_ir_illegal_access(VTDAddress=
Space *vtd_as,
     bool is_fpd_set =3D false;
     VTDContextEntry ce;
=20
-    assert(vtd_as->pasid !=3D PCI_NO_PASID);
-
     /* Try out best to fetch FPD, we can't do anything more */
     if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) =3D=3D 0) {
         is_fpd_set =3D ce.lo & VTD_CONTEXT_ENTRY_FPD;
-        if (!is_fpd_set && s->root_scalable) {
+        if (!is_fpd_set && s->root_scalable && vtd_as->pasid !=3D PCI_NO_P=
ASID) {
             vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
         }
     }
@@ -4738,6 +4736,74 @@ static IOMMUMemoryRegion *vtd_get_memory_region_pasi=
d(PCIBus *bus,
     return &vtd_as->iommu;
 }
=20
+static IOMMUTLBEntry vtd_iommu_ats_do_translate(IOMMUMemoryRegion *iommu,
+                                                hwaddr addr,
+                                                IOMMUAccessFlags flags,
+                                                int iommu_idx)
+{
+    IOMMUTLBEntry entry;
+    VTDAddressSpace *vtd_as =3D container_of(iommu, VTDAddressSpace, iommu=
);
+
+    if (vtd_is_interrupt_addr(addr)) {
+        vtd_report_ir_illegal_access(vtd_as, addr, flags & IOMMU_WO);
+        entry.target_as =3D &address_space_memory;
+        entry.iova =3D 0;
+        entry.translated_addr =3D 0;
+        entry.addr_mask =3D ~VTD_PAGE_MASK_4K;
+        entry.perm =3D IOMMU_NONE;
+        entry.pasid =3D PCI_NO_PASID;
+    } else {
+        entry =3D vtd_iommu_translate(iommu, addr, flags, iommu_idx);
+    }
+
+    return entry;
+}
+
+static ssize_t vtd_iommu_ats_request_translation(IOMMUMemoryRegion *iommu,
+                                                 bool priv_req, bool exec_=
req,
+                                                 hwaddr addr, size_t lengt=
h,
+                                                 bool no_write,
+                                                 IOMMUTLBEntry *result,
+                                                 size_t result_length,
+                                                 uint32_t *err_count)
+{
+    IOMMUAccessFlags flags =3D IOMMU_ACCESS_FLAG_FULL(true, !no_write, exe=
c_req,
+                                                    priv_req, false, false=
);
+    ssize_t res_index =3D 0;
+    hwaddr target_address =3D addr + length;
+    IOMMUTLBEntry entry;
+
+    *err_count =3D 0;
+
+    while ((addr < target_address) && (res_index < result_length)) {
+        entry =3D vtd_iommu_ats_do_translate(iommu, addr, flags, 0);
+        if (!IOMMU_TLB_ENTRY_TRANSLATION_ERROR(&entry)) { /* Translation d=
one */
+            /*
+             * 4.1.2 : Global Mapping (G) : Remapping hardware provides a =
value
+             * of 0 in this field
+             */
+            entry.perm &=3D ~IOMMU_GLOBAL;
+        } else {
+            *err_count +=3D 1;
+        }
+        result[res_index] =3D entry;
+        res_index +=3D 1;
+        addr =3D (addr & (~entry.addr_mask)) + (entry.addr_mask + 1);
+    }
+
+    /* Buffer too small */
+    if (addr < target_address) {
+        return -ENOMEM;
+    }
+
+    return res_index;
+}
+
+static uint64_t vtd_get_min_page_size(IOMMUMemoryRegion *iommu)
+{
+    return VTD_PAGE_SIZE;
+}
+
 static PCIIOMMUOps vtd_iommu_ops =3D {
     .get_address_space =3D vtd_host_dma_iommu,
     .get_memory_region_pasid =3D vtd_get_memory_region_pasid,
@@ -4913,6 +4979,8 @@ static void vtd_iommu_memory_region_class_init(Object=
Class *klass,
     imrc->translate =3D vtd_iommu_translate;
     imrc->notify_flag_changed =3D vtd_iommu_notify_flag_changed;
     imrc->replay =3D vtd_iommu_replay;
+    imrc->iommu_ats_request_translation =3D vtd_iommu_ats_request_translat=
ion;
+    imrc->get_min_page_size =3D vtd_get_min_page_size;
 }
=20
 static const TypeInfo vtd_iommu_memory_region_info =3D {
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index 238f1f443f..7e2071cd4d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -192,6 +192,7 @@
 #define VTD_ECAP_SC                 (1ULL << 7)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
+#define VTD_ECAP_NWFS               (1ULL << 33)
 #define VTD_ECAP_PSS                (19ULL << 35)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
--=20
2.48.1

