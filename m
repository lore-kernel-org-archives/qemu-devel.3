Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1067CCCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91Eh-0003Rq-HY; Wed, 15 Oct 2025 09:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91Ee-0003RX-M9; Wed, 15 Oct 2025 09:08:09 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91EX-0000mp-BV; Wed, 15 Oct 2025 09:08:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ar5WbOGFzib5H67Z7uMu9Rza6deImBY9T+UiP1KGH7WoYeryIYQB5ZXCKWuJ1TEjeL4RWo6/ZBs0KrLEE8mUFoyXdEFv3fKEh3YiI8+c1iNvuOyfgEbiUUmAtpKLFVvawUBm06I78r8S69y1gooEOSzs1BOOlj6Y9mQYWu8JB61nDqKBPH2DZXaLDxdiXUucc92zmbwvo6/WJ/op1MMltrPY9zajjhPNZfRey0b5HMu1TUK7bltyOJfNiX7JBVjRPvKZ/wM08xms1zhWQnktFtF4zL6SNYOQ1dKKvimZ0RMGfZKiUaEsYdf4LKls93Bd+hgxjIn/9yBnQzvYa/iuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93u9ZMO+xPhifUZg4HHnOJdOmexHuJgemN684sgRPKU=;
 b=lqycV8Ww1/C1sCyeWYiBbGAKlYPHX2wf70Ybwbyx8I+7zrF6qCL1FDvRtsFcaqCC4HP2V0q5pD7fICLPpPUwr0sfLEmBx2fExyC2Dav47spZfh3XU+ybnwcj7KRrl74ktNhmhddhw3PqIPXnPna/meNxJBuIBJqGHnz0S53PMFpS4JqdJK9DL2HB/jE+aNuWipsg6BIw3sfnzrPtw4w/nebjy2jzdLXrktwoERJ5QmMaWwGja0VP7XRBc+UfHMz2kOxghkMazoDlw548W18y8f/mjDMHBVt+2Ezr5ylpOrvBX6HcjOyOpq5junOPJUQKkvXZpjFGk0H6XExV0EeZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93u9ZMO+xPhifUZg4HHnOJdOmexHuJgemN684sgRPKU=;
 b=QtS9Ez00eupermjVQh2U53fr9OFolAE3zigBjKHUiRVbMRaK3qo80IyBJkFmRPyPeCv5weZbZGOZWKVzIGRF7BXkazfZV1lxJVO6WFT0TuaJ0KiIKU6s8+hyh5Yvg4aNdoF3ZEwEev1EBB/DDWuH2rEtVjnWvgtLhzrpD+lj5C3U2ZhdJoJFUxmKGEoA8XqCEgqWwcLbnWmZFwA7wMDNf+vyaEc9dmHZQf6FhdmDfyqF2zhc7w1HIfs5FEW7Bn3pNTgZ/p041jpjjJxhfNPtvji+KYT2aOgyfZ8TXGbx6IE46cwn5WR6w89vhl/8aSoIpjPwY/8qhfWjpa2s5BaHFQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB6057.eurprd09.prod.outlook.com (2603:10a6:10:3da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:07:08 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:07:08 +0000
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
Subject: [PATCH v12 13/13] test/functional: Add test for boston-aia board
Thread-Topic: [PATCH v12 13/13] test/functional: Add test for boston-aia board
Thread-Index: AQHcPdScbqbpj2MbCEOeGBZC7hkiYw==
Date: Wed, 15 Oct 2025 13:07:08 +0000
Message-ID: <20251015130657.571756-14-djordje.todorovic@htecgroup.com>
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB6057:EE_
x-ms-office365-filtering-correlation-id: 628bab87-8000-4b2d-f138-08de0bebbf1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?G7eq3s4k/lbI6wHcQ+g2U4j0vfTbtU91Tktv9KhYtIrsSgJTA1jqi4dN5M?=
 =?iso-8859-1?Q?Jv8DXKJdng5kPDw1qMxT0u2zo630BxCARWNQQirI8LxhfzjY/h7vudgdjp?=
 =?iso-8859-1?Q?0XRN5eWZHR3spM0bJp/PBTPpMzR2ejmOa7LmnPHwE1t7V829/jkAFMoc1v?=
 =?iso-8859-1?Q?9tUMqj0v+jYHJeWEL2q/UwdGzYdHDP6A5aBlfVuWaDXfVbU4KFk47ci8f9?=
 =?iso-8859-1?Q?lMYh43sqS8f6/W1xMxmjsnJriuczVRmpC17P8gpQAOy6L+jMp+vj8Fjc8H?=
 =?iso-8859-1?Q?FeH4K/dSnRuG3s9z8b55qXKYj/YUqUiCeFnS0d9AF19IJCOaw/Fh4ttRPN?=
 =?iso-8859-1?Q?r20cyZnvBhzm+44WatJggubY0x0TEOZbUnCAuSSIuY/BQ4TADNjdZ1qVai?=
 =?iso-8859-1?Q?nzRDGLc9B71I78ku+A4P6usGXpifTRNNzI1Fu55FYexx7t/StvB2yzBhlK?=
 =?iso-8859-1?Q?gzVrR99J4LLJsacyS3xqtnCGDdhOck+dUdaCWKMzFkVq9IrlRSplbTLM19?=
 =?iso-8859-1?Q?1ZjCgVYlnCi1NjMCtrU6CD04eUBL5k9qKDrYgXPt2A/4LYofqq9WBXrOnQ?=
 =?iso-8859-1?Q?amP6hiPtcnfGwKzz4c0YR7ajQi+CBQUh+7QCVXvCA/R9hNCEF4JPHZJ7RN?=
 =?iso-8859-1?Q?WTAZ7AjFyMHTpKfQObynXiOqnlH0q1DsnR2ORPq7JvS+uRk2/5XbKm0C0U?=
 =?iso-8859-1?Q?urvMRvayqU/HNyJD4PF+7qiGbphgul0jVBcoY13+lbcmVDA3xTUHTmRHS+?=
 =?iso-8859-1?Q?kiU+QR21PRTGJLNidQ0jbeHJ1xAkrUBjMCEyNYc1yrRLc+GasT2TSKKPGx?=
 =?iso-8859-1?Q?CSX8yjnpkpHCBhM/qF83r0UT/c/yuR7gAeAg+BT8dO1DFzZ7Uexk5dB3uJ?=
 =?iso-8859-1?Q?7gchI16KflBpQB7fvZQYeQNK2WWOoChiTD7uJptC0uaArkhybbX7VWxnNx?=
 =?iso-8859-1?Q?IXNkfue/BnS7iGfWgX35ND1BcW1fHzPgHnAOgCK8Q5OvrcbE0A4uVlUhhK?=
 =?iso-8859-1?Q?kKoqxalLrO2UtJIt/3VK3HGRV6Ux19IcFjDMt0sVsPtT7Twutd1LMTL4ms?=
 =?iso-8859-1?Q?s7ZKmwBWV8ok/v8gU2iK2NBE2Tan8xcigSqiOHs3kbHtWDWpD1qECd0S2V?=
 =?iso-8859-1?Q?9/EjkFL5ZeRanTNPEJ41ZvFNmhBA+3gJ/pj20w5TnAY4xGSCW6QW4YsjKV?=
 =?iso-8859-1?Q?mClepTf6bnh6jUXoTXUPV+lz7FHpsKgzJ8dEVS5IDWWWVUQ4wRqrQ0J5sS?=
 =?iso-8859-1?Q?JqCPpD3ImYDl7xT3MYnUgk8RHyQbs3a9G7E2erta97WeC1ZfNsipawPkXt?=
 =?iso-8859-1?Q?2PMz3J+XThTd/e2nC80Ag+FcvqxRJjUkOBnHSBxbXVPdBt9riTA8wnyCW1?=
 =?iso-8859-1?Q?ASBwa8e+0tHP3sFbi/4fJrC77CXiuDv+ypRwaAdMSyOXZhMS70XP/uPi5z?=
 =?iso-8859-1?Q?+Aqlw874TxNV/XfUH7CvZNJ1NcPqONfno9DQrcztHBR8QkqJFl2ZFxT/Ri?=
 =?iso-8859-1?Q?3morTP9ekhYO+kWJ8y/rkPnh5URjkS5kvb3gG5ZPBPOGkIT/9DwSkozQGi?=
 =?iso-8859-1?Q?TEanm36lV4I12ncd+wgaRwk8qJIb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?htY2YaLS7iRgQeaWQc27+K/fGfS99DAZWlyAV14EJvvPtEsX9uQpG+isaA?=
 =?iso-8859-1?Q?zrA86M7WHC25vEuohnAcZswFrrzjsemgTPMTZZGNBLwTqYtCuPSp30xyAe?=
 =?iso-8859-1?Q?DTciIno5l3Gc9e6touG15TJex8/fJ0o16gMULsEcmfqN2/MHJhxuaLDUuM?=
 =?iso-8859-1?Q?PPiA/NXhKH7CcSV2V38WTVQFjEx/PifcSPt2/Cpydx+Pvkv3+CcE7CoXC4?=
 =?iso-8859-1?Q?5NLBhh9kSeYnbpvRssfv9FDHILS/GhYFDWlJ0bl7mk7b+nwq+iM35jrkWl?=
 =?iso-8859-1?Q?I8J5rL4gN8yNzo2M3xn32OKeekEh4vpTCs0XMaaRuU6HtPXuAHuONfD2EA?=
 =?iso-8859-1?Q?YKnGl5MScde2HDF6YMUguIXuJc600y79+/MvBKU0njOGe/HgcbWm2dfApJ?=
 =?iso-8859-1?Q?poeOyJQ3zL8phpAP2xkSih4J9F834fpsZkhv6gNpf7kvDUTq5g1kGToPLY?=
 =?iso-8859-1?Q?wjOak3rOdckiXsPOTD/mIhbW9u1UIT7POv/Hhej7GBbdWsgyGfX76fdluB?=
 =?iso-8859-1?Q?Awzrtd0JEcdjx6k3z98gCwh73OlmAlzQPAZGwG2p3mFQQ5MaEp9s+hfm4g?=
 =?iso-8859-1?Q?MMe7yu6xaFxFysD1hqos7BKD7JHfIQ4UnQ/pLCcRlAAGYwgZ3Zbgwc3LL3?=
 =?iso-8859-1?Q?oFtH8PEEDbZNZpseJLD+/mww4KLAOo9MURcXSPZzN9T+S3aUto5z+CmwSL?=
 =?iso-8859-1?Q?oaBlbvvSsLpUeTPWSiJAreho0oG+E3LsG5nuOVpoLGmJ8pJkbUa1wvKDCy?=
 =?iso-8859-1?Q?wi7VkrNGi+Ppp1Lr3IcAJy34lSKGq3sO7h83+sOBuwQd/+cG/lnRiNQHmN?=
 =?iso-8859-1?Q?bVVATzdmXXVJ7Rhy/bF/iYyQXuqUotJbAeEIa+fzKTDCE+aPab7h4ldhDE?=
 =?iso-8859-1?Q?fmVMAB6f00AH3tXUqld4QJ6edhaEodltnZmAYng6Rt2O6j8qKM4HSsTlmG?=
 =?iso-8859-1?Q?HYS2t/NKjV2EddGT9I7f7Mveept3NXJLp0k/jltS5t+eajZUjjs2HQnOt5?=
 =?iso-8859-1?Q?gc2JSHyIbXfj8ASAwxLU/mfekd0iOeJ9l12P4Sge/rPWGilRjqeAqL2bVL?=
 =?iso-8859-1?Q?u1rLFKzxJcN6LLakW8R0zTaLDQCVW3Rxm1pmUqHmgzCJzYkNaHaZxhYWM7?=
 =?iso-8859-1?Q?sjtTp7zRLmlDMq+k/6XfpgpXdDjg15lFsn/LTyClr3sXZUi0qiWq/ZBYlo?=
 =?iso-8859-1?Q?4j8uJ9TPltiIllKRc9FHtz73fRGkcjc7wDepB1SfQXCLVzXKBwGjL0rMgM?=
 =?iso-8859-1?Q?WEAJVdYFWpey1rK5WKEoGE11edSoM1ck666xCmzPqnv9Ggq7IvdHBjJAZ3?=
 =?iso-8859-1?Q?IPewAT5E23vY4u7VB5rr4ikQh73REBIK0XqCKmQurp/cyu/NQ3ZTCYphdP?=
 =?iso-8859-1?Q?EymmZBI8Czbv8r+ZG9Y8xqRNVZ/ysmZCSmB9jKDZpmXMTeYW8mshranQPf?=
 =?iso-8859-1?Q?fu+nwAmhMXkuN7JWXByhrt+riH77LhwNenfGTzM0qZSazo9QtHqiNedRUU?=
 =?iso-8859-1?Q?OqTqSIlFu8118UlLVG/mdrs/bJnR6oiWut2XJfIT6UDBJFnb9UxKTX6fUP?=
 =?iso-8859-1?Q?PHI7cgp3ve+DQK6feaCKR7J0vdORp3v1maTIZbIDKSjUPojzzpOqmRVUAL?=
 =?iso-8859-1?Q?l7hD6Z4AxMQ1Xoe8uRPD6KaQVVJhrykHRoHxYNd/ZxtIRUmu4pRx0D8R38?=
 =?iso-8859-1?Q?ZzPOJfNWsRllCH4tY7I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628bab87-8000-4b2d-f138-08de0bebbf1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:07:08.4307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /AHXTG+EhN4l6c5s8XaK+j7V0vUSZxymDgrjazz0eL4wlLVKhhFKyR4LODQLsb4uxizUOPpO5wO+O4iWA9wTdHBQGGcAo2/Fk6w5Ib0cEk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6057
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

Add functional test for Boston AIA board. The P8700 RISC-V based
CPU by MIPS supports it at the moment.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/riscv64/meson.build    |   2 +
 tests/functional/riscv64/test_boston.py | 123 ++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100755 tests/functional/riscv64/test_boston.py

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
diff --git a/tests/functional/riscv64/test_boston.py b/tests/functional/ris=
cv64/test_boston.py
new file mode 100755
index 0000000000..385de6a61d
--- /dev/null
+++ b/tests/functional/riscv64/test_boston.py
@@ -0,0 +1,123 @@
+#!/usr/bin/env python3
+#
+# Boston board test for RISC-V P8700 processor by MIPS
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+
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

