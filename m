Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCF6CCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHXi-0008BE-A1; Tue, 18 Nov 2025 03:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXg-0008Aj-Js; Tue, 18 Nov 2025 03:58:28 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXe-0003Vy-3L; Tue, 18 Nov 2025 03:58:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0KxO9yH6uq32xqXlNR2HgdK10t2Kg1e9jm00VsDW+5dI4sPs9+Vg5qQw/b8QvBzzKln6aTnmQNzy2+P9IsNpiPzX60iaQ70Zsuq1PBwWkyNDtZPLymle2G3tJ7n33+fPjDwsws5d+Flxsmwqtrgx+xNQYKxuW75OXWxO68dtuXffHr/zGhKKjYC5bMG2Eli95iSuwh6xX6dAvu0kM+/AnfIOFvR7JSh+rtem0KmyLp5PsTXCLQNb77YdvKdBkqONCAudkCgtUmgC2blBRfRmzMhtpuYE6JJ2D4tduDRamYtIgGqQ2wjIqaTTZ8dFAkkkCdV0JR3jQlTZ4mX35x9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuK15SE6DqkiPV7aQXBdIcbo9oWKbpFOu6+W7ryCZRw=;
 b=kUvA/1tusWBif0xAkqJ3ES6Gn3dvl4NrmeAGAVzr4V1fAQpksxn/jKG3mrAXj1dyIGvA2K25lCfMyXK18D8cbpqDQiURktRTwPQP3eKZzi63XTqVAzG/jcZtq2DO5r4HAJV/Je4gFarxiJbrMupgsTkCADzjGQLXHCs6oOr0AiowjP16feBRju83EH+FwZh8SxqnQ1iF78DXyn+5Q+CL4MvnnqX//NxwyHnJ4gzZuXdJ9yAA2sTMpfQw+5F9raW0XGDelCewbL2In7N1HBT+VQ9HP+4n9Lu5s4+R22ENGAdvmbM2XBh3qvGm0tqm76AMUBGYimHyKL09vLkRv7uxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuK15SE6DqkiPV7aQXBdIcbo9oWKbpFOu6+W7ryCZRw=;
 b=tHxDbrV8SnXU0bMRO1bRXllRtXFJUUwBmnHEb6J2e9bdYrcc1ZqHNtv4sX6uuy+j0E/giESXr4f3iZVJw/OctwYMBnS7ftlh8KI1kAQf/Mth7YKfx1shdoh/H8OAYZ9fJcy1zqmjWmmQzWrSY1PER4LsDFVoWG0rUE1/HY65apjw7vO4gmC7u/oJ5+yQKMYews/jsqJLTZrLX0OWCCJo0vvDQdYyK5kIyH0ilS683F/wzp+GcmWMT4BnjR8KgBbN6DFte4bnxJZEdSDEjz4RQNfHcP3PxB9Vh3InHY/CTHI1sNBJSpGiMZhxhRneB8vM3dA3mKZQcK50z52HWbbdVw==
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com (2603:10a6:10:303::20)
 by DB8PR09MB3612.eurprd09.prod.outlook.com (2603:10a6:10:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 08:58:08 +0000
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2]) by DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:58:08 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v14 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v14 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHcWGl1yWO2iS22QkiktVKhdHDnEw==
Date: Tue, 18 Nov 2025 08:58:08 +0000
Message-ID: <20251118085758.3996513-9-djordje.todorovic@htecgroup.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6506:EE_|DB8PR09MB3612:EE_
x-ms-office365-filtering-correlation-id: a815c130-a0cd-4f6e-44e3-08de26809841
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7RQ2haIjNblRIkoDbANfbWRVP6B6fjF9G7AryNv9TKbyDx1Be6VIwW1Bzz?=
 =?iso-8859-1?Q?Jo1I/yZno7rtRyHoObp1Lpk3ZsIwxBUxpdONggrIhSkHn0OnjukgJKxWQw?=
 =?iso-8859-1?Q?AVLKfXShoM+8E2Mn961LtZFQ7jfHzx9d206zc3wuZrDA0dQm/OWjVM5+Lz?=
 =?iso-8859-1?Q?sZnoHXWz3olMwXjngwTHLZ1Q4W3ErwEQjOf037hlhsXpU23mfXa3cPuU3f?=
 =?iso-8859-1?Q?xwim0rUDT7srrtj4uRxYczx1j4b62rDoTZwglgCRgy5E1FG8+biDoKBIdN?=
 =?iso-8859-1?Q?Qif9o6QQBQ2WrK9UMjGLJPeELGHBwvCIXiEzOlZrNRp1FYKCEJtfP8RC7d?=
 =?iso-8859-1?Q?MvJ7gdCLhLFmO4G52kL3D7INGT6IEfBXM6nGgo5cwKfsdjWRHJ3AILLHJK?=
 =?iso-8859-1?Q?8HKX4tO7Yzkq0nRxP05kSYvJUQiWTZDTds/dk4bX3C7xmKMk6/RpHkH2eV?=
 =?iso-8859-1?Q?jwiBh1KDUEkDw4OJm9ZO0fph5XeyofSc9CcO3B3vJzbehAeXpoabR2gq8T?=
 =?iso-8859-1?Q?2lngh5ONQMC313jWH8Bwi+s36nPBcGvOv6aa5x8fR551eFZQtaKYYVIXIg?=
 =?iso-8859-1?Q?G2KRF2fk+VuhFaT3hGIT7ftiX6t85e/0bOonNjm0ICGpnQ7OpmgXAhgTch?=
 =?iso-8859-1?Q?dihCBPRUI+znuTpzy19IgQVgD8PROkYR1maofcVTazOaNLQtiH1ZL/EiVK?=
 =?iso-8859-1?Q?YV/5tFApxwZ7wP0aTOgz1+glkJcwzu/TVhwxQz2rkbVWk4xWHOT6iJ+kvX?=
 =?iso-8859-1?Q?QB7u9Ihq+RADE0PrMpl0dZDqxe6rydgXJX/EqOWbX9Iqj+MAYUfGw5tOlE?=
 =?iso-8859-1?Q?49QmlYJqlg0Z3tke1R3WaZCfikCZ7EsqS63373gUydlSqGXd9OLR6IubJ9?=
 =?iso-8859-1?Q?MF+A/7bqIZD/E5l5VXFq0QLOQNITh0QWy3UZ9ogABxhMXiHuz3DouLBPC8?=
 =?iso-8859-1?Q?8lJlW8EK9gI7sie8VX4yCewqEd0g41WwKgmeNAqfudvg5FFY1wbPOnczf+?=
 =?iso-8859-1?Q?kG+kEh4nOCXMQZJohMPQvijJ7YIpPpSy8w2J0cpL1iGZZna3y+zRDlehMw?=
 =?iso-8859-1?Q?P5F2b6OHnt+5FoEx0QJIcXNGDL3qu/+sAODJ2mi/4u8AM8YUtpiukZaO8J?=
 =?iso-8859-1?Q?5GC0GEApG1vMwTcLAEiFQc4o+vj+Ih8NEaTlUhwFgGPZITenuPG9iZvfsf?=
 =?iso-8859-1?Q?K9XWEc+X2pGsLS5wpVI5TcM81UZLNhVR7SRAGw0SSGA0QbZSno4qWAfwrN?=
 =?iso-8859-1?Q?/sVKlbsCTsGWzMrzSO1Ed1i4spOheDd0bIg9Qcsv+CRIfhKb1GinlWkVdx?=
 =?iso-8859-1?Q?LGs4ENOGFfBXNupsCu2J7OkjQIpBUFBy2if7iHP1CTmTnFnL7wUX5Tw3do?=
 =?iso-8859-1?Q?prehb3g51MfZDRwMe4A3n0pwHBwU9iYj3c20WsTuHl8307z4NQyiW/xVyb?=
 =?iso-8859-1?Q?USmdTb83giFvgXh23CO7SpryRSK+a6KdSOaIcDWEXTPB4kzyh36EGRQYLV?=
 =?iso-8859-1?Q?w9dOVD6UWICJsYOph/YhcJeRsslNvFFfGC6p4f1YdsHDkmoh/SQcqYJi88?=
 =?iso-8859-1?Q?RyyAV3G+hG1CaXDsjoip3ubbefqU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB6506.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IstZ/jEW4R1yZKHwE79UiDJ4NGc2Y9Jj17Q8DggWcMPFIN21yeKDdl4Vtv?=
 =?iso-8859-1?Q?k2993D3Wg+mhWGGQIPlkD2ensany/aQ6mj01BOhmYcSb8/RCBgCmfGezyO?=
 =?iso-8859-1?Q?3FGu6K5OJGmLZavcAoikCX1KTfxp20W+hxo4w6xwpFJx7wj3z7Wrmi6Mxh?=
 =?iso-8859-1?Q?dqhP9TCJTwHcRjs8KS1hDWeC3qrkkiII8iiyL+gnAutedqAx97GIDyKqjU?=
 =?iso-8859-1?Q?WlcwK0jTvDiIwy9g+WTuRQvE4KnwkRBg6PMZdmOJ3+N5q7nEGtPbuTGPKb?=
 =?iso-8859-1?Q?mKns1esBpVzbflwMDiF/GNiRX4gmxymDZA2+Sfq5BGM44m+8CPx8sLcqRa?=
 =?iso-8859-1?Q?i1b2tsv6U16bFJEQ1oRpFLwZeGowdV5Sf6o1BNFZzfuD3meoz5E09G13w/?=
 =?iso-8859-1?Q?lexclovi/qrO9TTvQJRKPRriY04ksxOzy20unO5COY06f3ClkVgT3hoyTk?=
 =?iso-8859-1?Q?oFEHZbWj0fg0R5ok/MO9nan/vN4Iwgz5tUPaHcGJDOB2cwYuVBVL4ZBA1b?=
 =?iso-8859-1?Q?0PpiMxZ5LOCe9Wt1yMRam7k6LLvxxIy+M7iCmPW8YtBOu+SAI0aE5FboS8?=
 =?iso-8859-1?Q?k2lr5LGz41HlyeqwnRVpPjijkKEpiCbK/3+jHKj5OHCs2/apGs2awsfIFn?=
 =?iso-8859-1?Q?YxoJVeDr2dkgr1ev4u7/TIZjhIUlpBO6W6a1qQ818pwvJyQnXFLZWFgSPJ?=
 =?iso-8859-1?Q?Rn4PZOOn7WNDi7dMB2s3JDuxO7ltbTsTZQz6rOkTT7NcnBgb7rTwPss3BC?=
 =?iso-8859-1?Q?SfDgBOqTU0UmpOXQ1vhooiGwi4gDIgjvqz5bp18hsTpPHFk0UFGWEEPEzv?=
 =?iso-8859-1?Q?pdD1vzjhz0oLu2fBRzaPwFRAMdhSnw8Bezh/bIjb7SxKWc0pb5EyrTVi7z?=
 =?iso-8859-1?Q?OIcXGUY9uLU+o4QzLEdmnT+p6Xk5nm0LgZG5Ke0YVA3DQ1cOX0HkJk8bkZ?=
 =?iso-8859-1?Q?THlU/ICAR+myMo7XSg/9wFud5IrW4JYbxfz8Hj4Ld5+EWMp3T1lLaV/4Ch?=
 =?iso-8859-1?Q?BnCr2wabImzv+gLVnKMNLp3XQLjeUVIEEjTfI/XAkSFKZY+5LyZxCUbH3t?=
 =?iso-8859-1?Q?qmrd3Q3JuCVU2wAEZ2al24ASqm98uZVcgxoKaeGsg49LrSa7I9fAh0OanZ?=
 =?iso-8859-1?Q?cW3sf1oeeXfMWzuxoqS4Ou4zKe/fngCA91iJDsOjd5XGN2cWIpdfPzExI/?=
 =?iso-8859-1?Q?nOEpGtq2e5TmXuZpHRNgk9sheyDI1h6uhnT+Nf8huhCnc6KzjG93HdQ06G?=
 =?iso-8859-1?Q?5Te7jdkOMUeA4vusdSuYCTJ/bKjo0RwVynQfL09jJHsRGPwXbJLUSFuJOo?=
 =?iso-8859-1?Q?eBN9p1ylzZiK+9Ouiarx7oEaUKfYv9t25pDLlmiaMHVbVuJs9WtPFp5dT3?=
 =?iso-8859-1?Q?4yK5Npv0rvWI+c4p5ZtYKwxRRoKFNzS3vobvG88180l5LnHTKESTghbL4u?=
 =?iso-8859-1?Q?8CST0QZA0+GwvJdYCYrzxpPzwc3Q9qy5eZnLGt3Rs7lPON4tbb6jq7pf7b?=
 =?iso-8859-1?Q?OefHDhuH2ib+4OVT4gFm19fAIpW7svQXipKR/fxXuF22aLDK/b9Iiyid72?=
 =?iso-8859-1?Q?ztRGLgpzDUe0MQKcZfVI+Z9XjoP5SOQ7jloCES6EopfFJfJ/NGek2SiDo3?=
 =?iso-8859-1?Q?/FHzX/uPWpcgQkQ2a1gRv8EwSQyV25dvXZhqMn3tHxJSDxCAfZ1MoIB1+7?=
 =?iso-8859-1?Q?dVW2Bg+ppFvaqwaS30U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a815c130-a0cd-4f6e-44e3-08de26809841
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:58:08.4851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJg6O+i7LL9Du/8mhgvcPGfk4y0mlI46PlJSiDSp+CCgJM0Arz7L91LVCRTQEP7RiYQlHhuAvZ+zaU3Asc/7Bsv0WvxGiyzBPsqHywP5VkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3612
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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
index 4e35657468..222efb12fb 100644
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

