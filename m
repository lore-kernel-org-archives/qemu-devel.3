Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B7DCCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v909g-0007bI-OV; Wed, 15 Oct 2025 07:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909b-0007YV-Dd; Wed, 15 Oct 2025 07:58:52 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909T-0007oF-Oj; Wed, 15 Oct 2025 07:58:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WW9WAZ47rYRV/FsWmHsaISqw9IS0ucC/DVI2MjVK9F2rQcelk/ds+zNrV9aA2Vd0BT2fJLmZDQuA02CGBhPvjCZao/9qrLlPwCWddtOjSVpoBRNZxL5mNZ7bVZ3DK7gPcDHzPCgFSCWRtZBVz8rRpcWgkjXpq7reYGE9/3lTsPBFOItOPwVdnJCnIEF6QjlZwR1y4eFCDCNM9SXPYdXyLg65dqf083WF0joTo6oal6J+xmKiRKKHUXknjiPyLC5+88jlogiV8FQh+bCOPBMwt+8SZuU6y6RR7P5aPGMOf9w5NsIDEsnlcsKJu//3INsVXU0/M0wGdoR0u8MCK6egdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCBkk5kcGhxQgtDJvSLEYFEgBQI0+IkklN9Uwuj2/lI=;
 b=fAwoZ3JOMuMNUZBZIUIQbsfneO6diUzSm5hmQ9y0bALOmYTEK8mmhlMa63rV+eonja8GN36pU0wd9I2BkJxIwjw435NK35IRsJO6a3tpkMtdoq9a7xC8d7BhVNhglOf5MWgt7UsuwugeW88/GwYSjjYqAgAzfukFcPZ5ItJ6SIu4d2zjfij6q25FGu/18yZtl6Z9REgE1fwk3Wm6t8rs//elw50nb6piS/rfIPWxo9VJrBqhbZ+mGD0/9V4NWBmwbzO5vwEHAX5h1aJk24S+c8ZuHdUHs6YZkrjeyV/fcoJT8/u5KFY0S3s5+2IiyAJfU6RzMHxphGwz+ehE0ITZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCBkk5kcGhxQgtDJvSLEYFEgBQI0+IkklN9Uwuj2/lI=;
 b=knOt7xfq6svEgvwpeC6D8U3hJRoj5t4lWWyrM7PwYtYr1v7cXi0C94RO/2k9Fd9W8lcq0qSZ51EEr2Svru1iCDJVzxmOgbawq/V2CH+w1DNfKxlQW4qe/wpsE57QXoG4CSD8YxROd0AYZ1VmXWlrKia8x+rMk3s3wub9ytQXd+ARO5ntMNhFMNKI0909LqPAHyN2mIt2mZzyBq2/c3B51MDTlzfOjNj9L/2icoRMBIjbvpvYwp3rewzXY07JJOyv2KEoupYCrjeKan0tl4cgs7iTnF6eX2uamnjXtAvFlbzlfgJfMIei37MgESjlPTqHltQoLkQzzAXHkUqWbWTOhg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GVXPR09MB6780.eurprd09.prod.outlook.com (2603:10a6:150:119::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 11:58:22 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:22 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v11 13/13] test/functional: Add test for boston-aia board
Thread-Topic: [PATCH v11 13/13] test/functional: Add test for boston-aia board
Thread-Index: AQHcPcr/V884dcgMMUSrxyaIyX0U7g==
Date: Wed, 15 Oct 2025 11:58:19 +0000
Message-ID: <20251015115743.487361-14-djordje.todorovic@htecgroup.com>
References: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GVXPR09MB6780:EE_
x-ms-office365-filtering-correlation-id: 5bc09ed8-3ce3-416a-84ee-08de0be223db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?yNgMph0PW32z0xD/aWKWemA6AWiSq24TSg+b6mFtIbTE+65UL/o4ndaIlG?=
 =?iso-8859-1?Q?HCj1KtaiAlGUBlFbmOuBfGm8X5EzXZhgJe0nEgNgwh3NzTypvkVSfFzY78?=
 =?iso-8859-1?Q?OVMKbFKW+PCxthRxbGsr2tZVT++d4c2BVFseaTYv8jLdcC/hgWtCKz6ctE?=
 =?iso-8859-1?Q?FLB4R9P+ptwROOqFW5KnH+wqDkPKDZCukVuPsb2w/lYnnbeSOa9McR9Zn4?=
 =?iso-8859-1?Q?9yQTGXt9fRIc3zN6CMrif4eWFbEmsjx2ACTduLdt+vlUdjSk8XeMkZ4cx8?=
 =?iso-8859-1?Q?XgH0BI4Kt7omN3kMNGz5wnZiyRQGui1h7qyLKjZ3ZdviJGV2riWuQuUHCJ?=
 =?iso-8859-1?Q?8cKRWQWJOlBc/aZNW5Y72QAssIUZ6K4V9BJaMq4imyD80oyJLoaB9BDyKU?=
 =?iso-8859-1?Q?RujR8zPqiSJtyvTjFeBTiXOjZJFp+kZcTBfirxLjPqaCpNa5Kh371opF9U?=
 =?iso-8859-1?Q?PtTrLIZe8Z56mivBsYGRZB3B4bE/Crlmu10u/tvDvb4NcxvpHxoKr0VRw7?=
 =?iso-8859-1?Q?J0tbys8gFH3/VJZY6S7l/osSgtvh3qD3VmLC+cnpyq+68V4SY2rrr/XtPM?=
 =?iso-8859-1?Q?QLanM+WqACIBoyLFdLQtIR3wzfy4AucCniMFXa0LsMw+Hm2h80qEcdTpSE?=
 =?iso-8859-1?Q?Vmt27nKQybKHq/dlaPdXBKTPl1Rr/IysBAH2B7mHc9eKxYbxKIDj+T5XlH?=
 =?iso-8859-1?Q?004KSpk0XO6ho0ZMfD6umIDMbFflSLJ6YMB7IXorAGkAqSrReKnhpKsWyi?=
 =?iso-8859-1?Q?xqZ1+tBJ2uqsooSgI27iij5xH6CxSGCYYL0FU+HZxZbhC2JEu+L/RlxgWY?=
 =?iso-8859-1?Q?7YoR4FDXuu8+DX3wJyIUgDkab4uzkCCVoCmEP97d66oDLRsJC6tmYRFdcT?=
 =?iso-8859-1?Q?goS3iqzdvvArtShLq41HI1ydTkCjtsQIZV6CI3dLubqIA78ZL+aaUGY4S0?=
 =?iso-8859-1?Q?SXvxrx3XGc4SJKYyQcGFOLo0z8SZymBjR7pr9Sq56L9klUMXxGAweBWJW+?=
 =?iso-8859-1?Q?omD7s6REMFKyAxwDhI9MeitYJOT9YMjidE+glZ2Y/dhHrPqiFVx8lGFEmp?=
 =?iso-8859-1?Q?21b4yd/5gReKnPUbdvMbBYNTaJTtauIH3HiWeC4ebrgJpTnXoO1/XsQgIl?=
 =?iso-8859-1?Q?iWia0u7gre0GD2H9t9sqzJiWXOCI1yfL0S2VANNdK3/OZQ1Pw+C5PiUJyA?=
 =?iso-8859-1?Q?hBBFlHyYKZUoDcLMQk0/nIRD0fL5VqslaBIbLsyCmHqzieNFVg3bSIT7zI?=
 =?iso-8859-1?Q?IPBBjH6Yr3CLLPI69VcGnnYLmVxnMKBVvAE+QEqC1YZ2jkG+Ot3CErf9AG?=
 =?iso-8859-1?Q?GSnyw5sABUJi3l4MnOh3Xzax2HNz6ilu9LO3jIYUn8L9R7wYjR6yXhk/9k?=
 =?iso-8859-1?Q?TKJHjGsNaKLEfEpsEc/6kwLyxiLoZ1N7l1urXsv61j69cy1y1pDoao34Iy?=
 =?iso-8859-1?Q?yu2StqZOE0r5Nk0PTHPstzVqaCH4iTls5Ff+eWqlpSqCH1nrhr9Z/9xVCC?=
 =?iso-8859-1?Q?MYzsFh6Vkm0M0T8eOWLEbhfq8dP99yTJ1SS3MNa2JvT1wle54bKm79nsnb?=
 =?iso-8859-1?Q?DpBEuEoF2Gzb+4BBkpHclB9M5xah?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DdrZoSfpv9JV7Z8KAGGHSH8t4Z1+L0lHqspDxp3mzaRGkZgCECsSpQtgY5?=
 =?iso-8859-1?Q?Be2hqOr3tPvSmQbg29SdUmiRutDzgLm+IwXsBC/y0IJOlDQagy746NTlwK?=
 =?iso-8859-1?Q?WN6SLP1iYHactsiWM3609QcWRXD8R7UfGqyt/CzY9ebQHe/MusQPklw4AD?=
 =?iso-8859-1?Q?sQLYr52GR+mbRG3kb+2XCyN7PtMF8PEZfJ+ZrsFc25PgFCngz+2iuvdbhG?=
 =?iso-8859-1?Q?SZDt6dTZigzjUH9JEYLN4t9I6ysopNtVGhwGHrACQejfjebBvg6u/Wu8kM?=
 =?iso-8859-1?Q?ICgDQr9bODXBptPH0NO5bvcbYfzrUjPZzVXSSNRG91nNsbSaS3Y72Jboak?=
 =?iso-8859-1?Q?0u+gEZVSZZ4jcyM5uTJBHD+FgPQpBJ2VcSrsqB7nAKwv/QmG75U6zMzAcP?=
 =?iso-8859-1?Q?sZz/Gxw+ueqw8ZrpZlnwXLeKXi6+1xau2ukHcfpzIhVm3sNfrsUwQpRV1i?=
 =?iso-8859-1?Q?15PinEHEDBneuqCS02HBjoStQfI41FUc/DiWJlgkSMKdl2ypFcX1tP/5uE?=
 =?iso-8859-1?Q?NLCESP70n92tNOnplCIjoM9HK5tZU/6/OpSOc6qCgQL+c8o5a82CIAYU9m?=
 =?iso-8859-1?Q?x8u9rWszWbyXl25vjN5q+br1bFJKSOhEVbzlMHE71/PWnnOrOI15VG7pX5?=
 =?iso-8859-1?Q?23MS9jDjIyNv7xC8skaFX9u3Q+3H3MtvsFybPXmx290lHU7UlSvTJm1KQ3?=
 =?iso-8859-1?Q?HNYgjz/CcFUH4l7t4Vh3FT8QqcwIUX3TNQY3Sf34Bjsw559EiglKf/YLMa?=
 =?iso-8859-1?Q?2Cy3GQJjaiXWtPcVirMv8Rf8hYd3Ng/cdx9hFThFi1557hpl64YF3sS7u4?=
 =?iso-8859-1?Q?l/lDBHJdrcrxsxBBnBoObyJ0djaAk6eC5XThdHakhX0hnjvBinqNT7YDFD?=
 =?iso-8859-1?Q?hw3c/uIIfTFRg+/8vXQj602U51IPAn/F/ed6tNgGDp6QBE9I95JIAbU9zs?=
 =?iso-8859-1?Q?xn3IegcsTRPqhxSu5CkCKV4yOQt424vqiNJwfSwCb2vD2M62vc9iQ4Td3Z?=
 =?iso-8859-1?Q?kZU1Wi+y1hO3q51zFmPGjlkdl97bbbSz/9PGkPYcIvOBvx6GNz6L/P3/58?=
 =?iso-8859-1?Q?9s+xzu5HudrnLIfQ0CXj3PuqLgN+jRxZ+ErYkVPyHphNgpCTueAeileq+h?=
 =?iso-8859-1?Q?L7t7/SrNJiFX5iYYLM+7lzgZyMk2xIShsBLqlULXjuVNsyIuvAjzHgSDyS?=
 =?iso-8859-1?Q?v4bj8T5MR+euuWKpw4NudBJJ5e3+cZUq6z7/eitETaCIA9IvuTdEIbpRVC?=
 =?iso-8859-1?Q?kc6djLtsAGGe12JNJ+rxG5sfDr/jl4YxZaJtPmVh4/9Hq+kjoKH33uhbkp?=
 =?iso-8859-1?Q?KS4DrYjdyBNYmyB4kxsEMvI0JiaUJccRxtUYmCbuFuZV/t7/YSBMVL+p2p?=
 =?iso-8859-1?Q?WgRiWY9LhwMlj5kQUHJwCq59v/Gq6s6Y3SRKTMkwwE4qKlboI8G4dFssLj?=
 =?iso-8859-1?Q?GxbmViWdeO4VOR1rJdaWIcVHIFYYeQB9XUVj1bfif6r2WjGgbwGuhXYgkM?=
 =?iso-8859-1?Q?D7Mz0Jm9i/b9UsL7oO+WMLmEF811tQzIds96xOBFJJB2MFvKdlvIcBh1Vx?=
 =?iso-8859-1?Q?Pjyaa+CYvkbjql71bT8pXnYKNj+PQTe471kjajWLhWVPkVhUWOQxHvP2vJ?=
 =?iso-8859-1?Q?A7e9la1Tm1bNfd1yDuuGoeDsM0cBiDfVx7aWpG1NJz3JDaUK5CouPkYKNQ?=
 =?iso-8859-1?Q?0mAAPC6B1YYGnWGXibQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc09ed8-3ce3-416a-84ee-08de0be223db
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:19.7874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: doWuRgrDZFTQSKeA94v85595hkG0k5BMLws67KRxQQYwMjPmU6XwWOtcEzT4EZtlyb0DU6qJ1QYSeVtRUi+zGAOF60A3dd5yvxkEpQizEIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6780
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

Add functional test for Boston AIA board. The P8700 RISC-V based
CPU by MIPS supports it at the moment.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/functional/riscv64/meson.build          |   2 +
 .../functional/riscv64/test_riscv64_boston.py | 124 ++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100755 tests/functional/riscv64/test_riscv64_boston.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv6=
4/meson.build
index c1704d9275..58d541f8c2 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -1,12 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
=20
 test_riscv64_timeouts =3D {
+  'riscv64_boston' : 120,
   'tuxrun' : 120,
 }
=20
 tests_riscv64_system_quick =3D [
   'migration',
   'opensbi',
+  'riscv64_boston',
 ]
=20
 tests_riscv64_system_thorough =3D [
diff --git a/tests/functional/riscv64/test_riscv64_boston.py b/tests/functi=
onal/riscv64/test_riscv64_boston.py
new file mode 100755
index 0000000000..d450f7eaf5
--- /dev/null
+++ b/tests/functional/riscv64/test_riscv64_boston.py
@@ -0,0 +1,124 @@
+#!/usr/bin/env python3
+#
+# Boston board test for RISC-V P8700 processor by MIPS
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+import os
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class RiscvBostonTest(QemuSystemTest):
+    """
+    Test the boston-aia board with P8700 processor
+    """
+
+    ASSET_FW_PAYLOAD =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/fw_pa=
yload.bin',
+        'd6f4ae14d0c178c1d0bb38ddf64557536ca8602a588b220729a8aa17caa383aa'=
)
+
+    ASSET_ROOTFS =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/rootf=
s.ext2',
+        'f937e21b588f0d1d17d10a063053979686897bbbbc5e9617a5582f7c1f48e565'=
)
+
+    def _boot_linux_test(self, smp_count):
+        """Common setup and boot test for Linux on Boston board
+
+        Args:
+            smp_count: Number of CPUs to use for SMP
+        """
+        self.set_machine('boston-aia')
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self.ASSET_ROOTFS.fetch()
+
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-smp', str(smp_count))
+        self.vm.add_args('-kernel', fw_payload_path)
+        self.vm.add_args('-drive', f'file=3D{rootfs_path},format=3Draw,sna=
pshot=3Don')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boston_boot_linux_min_cpus(self):
+        """
+        Test Linux kernel boot with minimum CPU count (2)
+        """
+        self._boot_linux_test(smp_count=3D2)
+
+    def test_boston_boot_linux_7_cpus(self):
+        """
+        Test Linux kernel boot with 7 CPUs
+
+        7 CPUs is a special configuration that tests odd CPU count
+        handling and ensures proper core distribution across clusters.
+        """
+        self._boot_linux_test(smp_count=3D7)
+
+    def test_boston_boot_linux_35_cpus(self):
+        """
+        Test Linux kernel boot with 35 CPUs
+
+        35 CPUs is a special configuration that tests a non-power-of-2
+        CPU count above 32, validating proper handling of larger
+        asymmetric SMP configurations.
+        """
+        self._boot_linux_test(smp_count=3D35)
+
+    def test_boston_boot_linux_max_cpus(self):
+        """
+        Test Linux kernel boot with maximum supported CPU count (64)
+        """
+        self._boot_linux_test(smp_count=3D64)
+
+    def test_boston_invalid_cpu_count(self):
+        """
+        Test that 65 CPUs is rejected as invalid (negative test case)
+        """
+        from subprocess import run, PIPE
+
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self.ASSET_ROOTFS.fetch()
+
+        cmd =3D [
+            self.qemu_bin,
+            '-M', 'boston-aia',
+            '-cpu', 'mips-p8700',
+            '-m', '2G',
+            '-smp', '65',
+            '-kernel', fw_payload_path,
+            '-drive', f'file=3D{rootfs_path},format=3Draw,snapshot=3Don',
+            '-nographic'
+        ]
+
+        # Run QEMU and expect it to fail immediately.
+        result =3D run(cmd, capture_output=3DTrue, text=3DTrue, timeout=3D=
5)
+
+        # Check that QEMU exited with error code 1
+        self.assertEqual(result.returncode, 1,
+                         "QEMU should exit with code 1 for invalid SMP cou=
nt")
+
+        # Check error message
+        self.assertIn('Invalid SMP CPUs 65', result.stderr,
+                      "Error message should indicate invalid SMP CPU count=
")
+
+if __name__ =3D=3D '__main__':
+    QemuSystemTest.main()
--=20
2.34.1

