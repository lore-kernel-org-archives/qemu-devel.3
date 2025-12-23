Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90163E6F079
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 09:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXyzz-0001Ys-9r; Tue, 23 Dec 2025 04:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzv-0001XI-U9; Tue, 23 Dec 2025 04:48:08 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzt-00026J-QL; Tue, 23 Dec 2025 04:48:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVLQpb2XoqsCHDQlBh6fnW8nlhUCotVfZ1mFY7FlJffEKf6ToVsQVJQDYqqkgBATyjmusyRMh904OlW9PYQb0BEoVgzApHw0AHClWlc11MRp0wUtyP8kZ3lsZVJBcK/eZBrOpFa3hx5kE6RDi1TtoY7nf8SQCHq5KrlNHpFVJ8+pBTL9UXnhcmx5na8qmgD2PTCdOHhKcMQ+rIXpdEFQMSgJfSQyBUMVA2bu6CD+OpPFxnRaSR5dbtoWVYVLQUOwhMgfr+IXUtzhbrvnFEPtfZzDCTA0LJZ4lU4Vlk7lc1fWJ5IUDZGkFRpCHsW82Q7IAebvmXIbZO5urK7IjGMtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws8uPhVI4gOrYkEewpC0WtmVHoKQCjWl2pnr0hQb6eA=;
 b=gmbIikG8B1JQFWAl8bxDoHwLHgfPDARf+bNcnJna4MsbfHy3RCsqVrWIgHZY5453ieTlIoUx4kz06P5Bg04ZB5pGNl6ev+cz9rtfchpBrDy7zRe/tofyjhmWA+tjeZyWhIu45zAeyLGHJ2saBOlgPqumiafo4BfK7zKrO8FUfxZFZol1xPT2R7tz6TkOaIY8GqoVnko9xY3WvQfsMfQf81fuyh6I3KI74XO0w5VXoRmHLmrXCgkGikHJDFTnCsg9xTvIewtF55DZMKKVzyca7h4J69kLhq1Xfn6D7698tVntxfe6frGgpb8J08wiRuAF5pKRjXpb2C2rxIhAEk/JHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws8uPhVI4gOrYkEewpC0WtmVHoKQCjWl2pnr0hQb6eA=;
 b=b+aL2c4OX3CW/PxZm+5jCYe8uhL2MXoghgezhpisJQsCqEFqi7u6DIeZoy++MV4xm8OfUbsT0ItI+PUmvO7cO35RNWMIi9Kq3NCIxRZQFPbdXv/rWdreoObPFEYWobVHUKTkZROGmX0IY76J/MUnWaGAia0DzeFjYGnhneuKw+PTgSR6fj/AvmoYg2zE5idVr2XvR4v/UI0gJDyp92EsBMHLV7cx4/PTasaOxtUXKujeo3iwYazSbzmL0l9M7z9Izhcg01TFDplfxtfWTjAOnkWzTNo1zGpNjopp24gOkD6TNzQZEBhvTfoU1HOp64JYZwupJBij+5aXjiJL76MuNw==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AS8PR09MB5758.eurprd09.prod.outlook.com (2603:10a6:20b:539::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 09:47:57 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 09:47:57 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v15 07/12] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v15 07/12] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHcc/E2cSn8OgjgCESEjhwI8KcWuQ==
Date: Tue, 23 Dec 2025 09:47:54 +0000
Message-ID: <20251223094739.1983381-8-djordje.todorovic@htecgroup.com>
References: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AS8PR09MB5758:EE_
x-ms-office365-filtering-correlation-id: c75657e3-a84c-46da-6c65-08de42085a7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+WvKAb6Zo6/BQf0bYNyaJe1wnS4qEWt8ScU0/EIQ5GNurS7N0Df0p64IuN?=
 =?iso-8859-1?Q?7Qt6qdlIM9sEj2AtKysgF3sxloXol0CWJVPFvfpUPwNzVNCeq0n9OjvK6L?=
 =?iso-8859-1?Q?fUHe1s0tHoCttPrzbdEbZcbxS7XyDnvaZx/Q/JI6xfILJ038nfug7X8sNr?=
 =?iso-8859-1?Q?uBxRwl0F0B94fsLSX4lorSJBf2ohZoRwndz9y/w9JSu5oSnHWd9lFlrJ4Y?=
 =?iso-8859-1?Q?RdVUl9uX5qmLB4ofm8ZTsdj98eDDscAXxOae9Q9ywG35P2WXtmSznbdFMf?=
 =?iso-8859-1?Q?4Xf2nE/6c7R95veyh6eEer9s2/7ac7mW5Gag4fL4RNERl5j5PLH/kZ8NAz?=
 =?iso-8859-1?Q?Ufmf6WFLA8jUjAhUE+wxEaDWfdcnZY1hXx43K2JnY3eIbdm2gAOS+WSUzD?=
 =?iso-8859-1?Q?yNGKxlvEp3moSDvQ+5dTh55HnAi+uybs+TqYdSs/AMJgl/qQ2D1R8+wF1A?=
 =?iso-8859-1?Q?IUwbyMdu/MxDNJPKoMhlvG1TAYZZnQTWZvtRyaBAz56lnPEtz7Gyokw18i?=
 =?iso-8859-1?Q?H8MgRglVdi8A9psQFwukGTB5roIg1dIKuJve1VPwFy3LCQQL+NS5MzS/Z+?=
 =?iso-8859-1?Q?U/ljtOzGkeKlqEf0+ViTL/iMhuNnmMAHHbKGAAsdySrr8UzpoQD4zyBV2V?=
 =?iso-8859-1?Q?XrYpK0SqvVWAs7gX5MNObFGS+NuIja83uv3Qy0EL65OrUcq4c+seQmBhuC?=
 =?iso-8859-1?Q?nwuouXr15qFRcgk2TC0errSf+NJjtkQNSfrkoigDM/OYUgC2u3nsf+kOMP?=
 =?iso-8859-1?Q?jazrdTsY0C21FJh7o4lDeda2ZtfkGEQ5drL7MCTQEMI9vbIGBEzyjlp73Z?=
 =?iso-8859-1?Q?SPxBZnhjImp3lwFOJopLMw6aJ7d5mJ+r/WA9FsbHvrsQFjH+OyiMRVzbMU?=
 =?iso-8859-1?Q?w1xb8skPGSo8nWeLIAL8TA4STYEQ/Jo2VIzvsqUutE65Ec8wkw3EKCduNC?=
 =?iso-8859-1?Q?HNEwVNuNYG+fjR2j0ok98lhOcITvcnHAaTBbnzJpCG0XDP8jAIrCkYXcVq?=
 =?iso-8859-1?Q?5aYvGAOc6d47g/e0x1lbmpGb27rBXHuqx4oqOAkv56/T1r3wlp4hHwh1aq?=
 =?iso-8859-1?Q?k/tvWikSlpjnX2KYcHFB24kn6msM81/I6xi19nvkSFC9YNuJYbT4BeKmul?=
 =?iso-8859-1?Q?ZzYLG/cQVxfOZSSLvdzosVAaeOl1+oJkSCTZlp+9/+HkLlu0QB/e25ajmQ?=
 =?iso-8859-1?Q?VQZMs7X+rlcgeQqjaTqB4wG6zXFb1DrByUECP08081h9+Nv6W78z2NC1To?=
 =?iso-8859-1?Q?Ndlw+PSrnHmCPPRQuNirdUa2WJEOfvWyE0ruOk9b3fA1fUQMjDzpYLVaZ/?=
 =?iso-8859-1?Q?SuW1fVK27mLJ19WsT7aUnMkNcGJ4v9K9RQ2WjNn9CDqJiuv/0nLR2nK2MW?=
 =?iso-8859-1?Q?XW7KEq+YTRsZz4UJUXn0Y0X5vifRIAL0k/B3W7jpYX9M/QV7J0V2rJSxWF?=
 =?iso-8859-1?Q?zxp+jeRF9DKyzEh2h5sZsQIafQ4EZVlJmJGnATvBxb5D9+Ly0LQxPXNq3O?=
 =?iso-8859-1?Q?ZwLWY/z5jxINSyak2PG4n2DPcchuTnF4isgRKBcNG/yD78tSY1HRV9UFV5?=
 =?iso-8859-1?Q?kh8Eg8aqakafs74AXm1UTcbEdA55?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b1hRgSsi4SmqMFiulGzy1GZ0CPgM9rop5nN4L2f8ySBXa0zdP/ONS+4KGh?=
 =?iso-8859-1?Q?kEsJebfsD9kmb68i1goUO61WiYIz38OSqpN1GwRyZrcd2K/SRy+pWfxI9k?=
 =?iso-8859-1?Q?jJWZ+7tsB1731SJHmfuypANW/RmpcH5Z+g8O1wmU69FZ8xlZZDkaAVO/k1?=
 =?iso-8859-1?Q?5hQ0bG+lM/yQPuprHi7v4DkbVczAqxu0XmL93zrkX4Vao+i5t0zFUsbP1v?=
 =?iso-8859-1?Q?UtyyAyYFPIb5h1uYE5AZz8ymQHVu/CL9MbmAmurOt7Q/xEGlVvM0mhvYbu?=
 =?iso-8859-1?Q?Piilmt7XChVoqSff+4U99dbfIKtLre+dtCdCgow/m2E15Izp17lOFtpdHS?=
 =?iso-8859-1?Q?RJpw6e4ZrPj+sCrx3LDER87Mwa4fqXzUQXkP7hkYMzfNK6GEKQhE0IuDmO?=
 =?iso-8859-1?Q?vF4ToKbhc5a3LWg1ex4owBdvF7DWYrEpGfXqKd/DXSpHLp+bmiJCVX0Cro?=
 =?iso-8859-1?Q?XPL7JIh7dDCpvXSDGK5SXCrc3AW33j1UfdiB3VTjkYcaNY0igu39Nfd+JU?=
 =?iso-8859-1?Q?leeye/ojI7DupvNfQQUNCRUB0kzuirA0uuQZZcF6PUrFs0ww5JFr9YSErQ?=
 =?iso-8859-1?Q?T/aw29pMR/w7NuR0IffKnpGNoeo8BCN6ctF8fOlCuOvLb4oshLcw0BSs66?=
 =?iso-8859-1?Q?/yf63V09qG+qKYs5Nb/lPPSGw5/dA8VNRGdJlhhiw9oQku1AdZjbswUWfG?=
 =?iso-8859-1?Q?zDOZrTbUaffC5wkU+mtTO662bT6Ib8p9+sXaqJOAHmsVgEFv7ihZP8vjM/?=
 =?iso-8859-1?Q?fHpaHsBS0wdgZAatnNTCJ11sTafIYRxRB5YNl4LgjAjnPvAEgpb9HE0eCe?=
 =?iso-8859-1?Q?if5LZR9pF/WPYJPmgXNXCEFUHmR62AZoKYCDskdrU/+mm7lgecPR4Tx4Ci?=
 =?iso-8859-1?Q?L0wTXe4OexgydeBRWwlIcAQxEoM0L/qkMGSX7IKvOzCN3AOlh0ykCB01xJ?=
 =?iso-8859-1?Q?6ZVfsdaJtAvpJ7MmLWwXVE/Qla402jC/+fuSINuPXCHQ1naaD2EDR2MTtq?=
 =?iso-8859-1?Q?NRxTJDsz8qcXisy8dISl6/0BmSE2udCS2BWssikt85VjrmIVuclwNXNMZw?=
 =?iso-8859-1?Q?jfULkBmmVxmjaYbURfyTN/h08vBa7mmJVcbrfVcSbbP1YVTE4v8+h8BNv9?=
 =?iso-8859-1?Q?B030oxnAxD0HxpwXKBNrB3Dt5WmJwX8d8D94/FbNtt/Q8z99SMaumA7/kv?=
 =?iso-8859-1?Q?7b/QQ1l4b9EcGbh3OWkk8W1K206AIT1+xjrLAxOpMLQEYxAeBwjGZD9jco?=
 =?iso-8859-1?Q?TGWICZrFAZ5ihD9I0PNxAPL0YCRNovJab5bOmiq+ZEqyN2sAvW6fXmx8W7?=
 =?iso-8859-1?Q?908VjZV0kNA5XNSrANieIpe6sVXd1Lx25xbDnShcRoKqlVi12rszueviHq?=
 =?iso-8859-1?Q?E2FgqkH12gLdfqp0eoZ/t1WHMr2JfsAVBSwOIS581HVs5wrHgxfe8cv9RF?=
 =?iso-8859-1?Q?QL9Y0mV1ZX9csI1pQScCNJx4yKvVfOCO3rxj+z5bL8f/1hs7ONU6M5+lwL?=
 =?iso-8859-1?Q?3RfSAmP1Eybd4PfG9EsM1TEF8Sxj5N4plL/9krZG/hbXfaCjANLzpTzd/g?=
 =?iso-8859-1?Q?SBQwmsj5ghk+7cVnybp+WdSEs1GOKjr6VfjCf37ezFkeGR5mvNljxcmSpd?=
 =?iso-8859-1?Q?tBghKdW7CuYsL+o6IGvA21Ml8pw2yNp4BDTqleLkD7SZA/g/kF/KUjkcIJ?=
 =?iso-8859-1?Q?xj8TfFyRnnl16DkABTMWCK7sKd3216ZWVKLDvbbQP7ZgCSF+vEVFoGuw91?=
 =?iso-8859-1?Q?rX38ExtjLqLcejtNfST7IZX8hrzkkF6S8Ld/XpVeThJmY6Okj2cuSBRqIB?=
 =?iso-8859-1?Q?GVOMmgA7Qjw0sKK/OaXmNWfClC6pID22YtpJb/lmf6MSyHWrBS1N?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75657e3-a84c-46da-6c65-08de42085a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 09:47:55.0069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNkDaM3AccKZDoeCk6JhZoU/oy8m5yoFXJVHXr5VLNHF+ReiRFeNuIAQgzDjOB8KPsntOfnuH49S41VDOnZ2ZFTDruRfDP6/Q6bH1YuJjzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5758
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add RISC-V implementation of the Coherent Manager Global Control
Register (CMGCR) device. It is based on the existing MIPS CMGCR
implementation but adapted for RISC-V systems.

The CMGCR device provides global system control for multi-core
configurations in RISC-V systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig               |   9 ++
 hw/misc/meson.build           |   2 +
 hw/misc/riscv_cmgcr.c         | 243 ++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cmgcr.h |  48 +++++++
 4 files changed, 302 insertions(+)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fccd735c24..404500979c 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -121,6 +121,15 @@ config MIPS_ITU
     bool
     depends on TCG
=20
+config RISCV_MIPS_CMGCR
+    bool
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_MIPS_CMGCR
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..489f0f3319 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -157,6 +157,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files(=
'mac_via.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'm=
ips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmg=
cr.c'))
+
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
 # HPPA devices
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..63a6027418
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,243 @@
+/*
+ * Coherent Manager Global Control Register
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/qdev-properties.h"
+
+#include "cpu.h"
+
+#define CM_RESET_VEC 0x1FC00000
+#define GCR_ADDRSPACE_SZ        0x8000
+
+/* Offsets to register blocks */
+#define RISCV_GCB_OFS        0x0000 /* Global Control Block */
+#define RISCV_CLCB_OFS       0x2000 /* Core Control Block */
+#define RISCV_CORE_REG_STRIDE 0x100 /* Stride between core-specific regist=
ers */
+
+/* Global Control Block Register Map */
+#define GCR_CONFIG_OFS      0x0000
+#define GCR_BASE_OFS        0x0008
+#define GCR_REV_OFS         0x0030
+#define GCR_CPC_STATUS_OFS  0x00F0
+#define GCR_L2_CONFIG_OFS   0x0130
+
+/* GCR_L2_CONFIG register fields */
+#define GCR_L2_CONFIG_BYPASS_SHF    20
+#define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SHF)
+
+/* GCR_BASE register fields */
+#define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
+
+/* GCR_CPC_BASE register fields */
+#define GCR_CPC_BASE_CPCEN_MSK   1
+#define GCR_CPC_BASE_CPCBASE_MSK 0xFFFFFFFF8000ULL
+#define GCR_CPC_BASE_MSK (GCR_CPC_BASE_CPCEN_MSK | GCR_CPC_BASE_CPCBASE_MS=
K)
+
+/* GCR_CL_RESETBASE_OFS register fields */
+#define GCR_CL_RESET_BASE_RESETBASE_MSK 0xFFFFFFFFFFFFF000U
+#define GCR_CL_RESET_BASE_MSK GCR_CL_RESET_BASE_RESETBASE_MSK
+
+static inline bool is_cpc_connected(RISCVGCRState *s)
+{
+    return s->cpc_mr !=3D NULL;
+}
+
+static inline void update_cpc_base(RISCVGCRState *gcr, uint64_t val)
+{
+    if (is_cpc_connected(gcr)) {
+        gcr->cpc_base =3D val & GCR_CPC_BASE_MSK;
+        memory_region_transaction_begin();
+        memory_region_set_address(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCBASE_MSK=
);
+        memory_region_set_enabled(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCEN_MSK);
+        memory_region_transaction_commit();
+    }
+}
+
+static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
+{
+    gcr->gcr_base =3D val & GCR_BASE_GCRBASE_MSK;
+    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
+
+    /*
+     * For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
+     * cpc automatically.
+     */
+    update_cpc_base(gcr, val + 0x8001);
+}
+
+/* Read GCR registers */
+static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *) opaque;
+
+    switch (addr) {
+    /* Global Control Block Register */
+    case GCR_CONFIG_OFS:
+        /* Set PCORES to 0 */
+        return 0;
+    case GCR_BASE_OFS:
+        return gcr->gcr_base;
+    case GCR_REV_OFS:
+        return gcr->gcr_rev;
+    case GCR_CPC_STATUS_OFS:
+        return is_cpc_connected(gcr);
+    case GCR_L2_CONFIG_OFS:
+        /* L2 BYPASS */
+        return GCR_L2_CONFIG_BYPASS_MSK;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADDR_=
PRIx
+                      "\n", size, addr);
+    }
+    return 0;
+}
+
+static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
+{
+    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
+}
+
+/* Write GCR registers */
+static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned s=
ize)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *)opaque;
+    RISCVGCRVPState *current_vps;
+    int cpu_index, c, h;
+
+    for (c =3D 0; c < gcr->num_core; c++) {
+        for (h =3D 0; h < gcr->num_hart; h++) {
+            if (addr =3D=3D RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE + h=
 * 8) {
+                cpu_index =3D c * gcr->num_hart + h;
+                current_vps =3D &gcr->vps[cpu_index];
+                current_vps->reset_base =3D data & GCR_CL_RESET_BASE_MSK;
+                cpu_set_exception_base(cpu_index + gcr->cluster_id *
+                                       gcr->num_core * gcr->num_hart,
+                                       get_exception_base(current_vps));
+                return;
+            }
+        }
+    }
+
+    switch (addr) {
+    case GCR_BASE_OFS:
+        update_gcr_base(gcr, data);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWADDR=
_PRIx
+                      " 0x%" PRIx64 "\n", size, addr, data);
+        break;
+    }
+}
+
+static const MemoryRegionOps gcr_ops =3D {
+    .read =3D gcr_read,
+    .write =3D gcr_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 8,
+    },
+};
+
+static void riscv_gcr_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVGCRState *s =3D RISCV_GCR(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
+                          "riscv-gcr", GCR_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void riscv_gcr_reset(DeviceState *dev)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+    int i;
+
+    /* Update cpc_base to gcr_base + 0x8001 to enable cpc automatically. *=
/
+    update_cpc_base(s, s->gcr_base + 0x8001);
+
+    for (i =3D 0; i < s->num_vps; i++) {
+        s->vps[i].reset_base =3D CM_RESET_VEC & GCR_CL_RESET_BASE_MSK;
+        cpu_set_exception_base(i, get_exception_base(&s->vps[i]));
+    }
+}
+
+static const VMStateDescription vmstate_riscv_gcr =3D {
+    .name =3D "riscv-gcr",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(cpc_base, RISCVGCRState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_gcr_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVGCRState, cluster_id, 0),
+    DEFINE_PROP_UINT32("num-vp", RISCVGCRState, num_vps, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVGCRState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVGCRState, num_core, 1),
+    DEFINE_PROP_INT32("gcr-rev", RISCVGCRState, gcr_rev, 0xa00),
+    DEFINE_PROP_UINT64("gcr-base", RISCVGCRState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_LINK("cpc", RISCVGCRState, cpc_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static void riscv_gcr_realize(DeviceState *dev, Error **errp)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+
+    /* Validate num_vps */
+    if (s->num_vps =3D=3D 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vps > GCR_MAX_VPS) {
+        error_setg(errp, "num-vp cannot exceed %d", GCR_MAX_VPS);
+        return;
+    }
+
+    /* Create local set of registers for each VP */
+    s->vps =3D g_new(RISCVGCRVPState, s->num_vps);
+}
+
+static void riscv_gcr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    device_class_set_props(dc, riscv_gcr_properties);
+    dc->vmsd =3D &vmstate_riscv_gcr;
+    device_class_set_legacy_reset(dc, riscv_gcr_reset);
+    dc->realize =3D riscv_gcr_realize;
+}
+
+static const TypeInfo riscv_gcr_info =3D {
+    .name          =3D TYPE_RISCV_GCR,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVGCRState),
+    .instance_init =3D riscv_gcr_init,
+    .class_init    =3D riscv_gcr_class_init,
+};
+
+static void riscv_gcr_register_types(void)
+{
+    type_register_static(&riscv_gcr_info);
+}
+
+type_init(riscv_gcr_register_types)
diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
new file mode 100644
index 0000000000..06e3b2e5ee
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,48 @@
+/*
+ * Coherent Manager Global Control Register
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CMGCR_H
+#define RISCV_CMGCR_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_GCR "riscv-gcr"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVGCRState, RISCV_GCR)
+
+#define GCR_BASE_ADDR           0x1fb80000ULL
+#define GCR_MAX_VPS             256
+
+typedef struct RISCVGCRVPState RISCVGCRVPState;
+struct RISCVGCRVPState {
+    uint64_t reset_base;
+};
+
+typedef struct RISCVGCRState RISCVGCRState;
+struct RISCVGCRState {
+    SysBusDevice parent_obj;
+
+    int32_t gcr_rev;
+    uint32_t cluster_id;
+    uint32_t num_vps;
+    uint32_t num_hart;
+    uint32_t num_core;
+    hwaddr gcr_base;
+    MemoryRegion iomem;
+    MemoryRegion *cpc_mr;
+
+    uint64_t cpc_base;
+
+    /* VP Local/Other Registers */
+    RISCVGCRVPState *vps;
+};
+
+#endif /* RISCV_CMGCR_H */
--=20
2.34.1

