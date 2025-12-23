Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284E3E6F07B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 09:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXyzy-0001Y2-1P; Tue, 23 Dec 2025 04:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzu-0001WE-MS; Tue, 23 Dec 2025 04:48:06 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzs-00025T-JQ; Tue, 23 Dec 2025 04:48:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObVHqP7lv32itXZ46dqMaDq+MsazvrQW7jj96XNT9Qg5LRsTXEu6Fc0/uRLLrWjWZ3NHYUKfaz6056KvR78edvCScjhzI/NEi7upeze89mDZCXLEI7syAw0qiFfvRUozlA2Q651PA9HeyEbrL6v4XXvj7K8o/zr9P1DjYlYSSxC4oNLFhT+7gn/6BrzPkT3JPduwFV6sebZnMfYcxLq7i5Pb7Z1VeLOwj+5vKne0YqyUBorLZRKTwnNV+9lkN4SJ7V3A0yPOXWoyOgFv4IlWTOr8Ltd9igiack4tdC78V7ojehgSSRld+0ypAAlrI9HYWVYgF6QiqYzCmTBSWkoYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMm4r0PaKiUFkoyYrBQVKQVTj3zF7wb29Z+I9KrtWgw=;
 b=Mwa4Q/ooMHWUPIa/nMnM4ptsr5/EeEtJy1dHQ9mwCGhOaoS3A0SSQ9qBc4OWNazfvO82JYLf5soYQkG+JcAP0gtzpdGvMy3ygx46xvy+6zfiNF8j1x/JfpeASvwgSetNnQKeWM9gFORuWvPm9y5WWq2xuKEWUcu7JTc+m8dGSzInCk0KnpOZ9ZbPiR8Uk03zykFatne98ub70eN2IJd+6WAN3Nry8mH/RhpfAStUwqPpyQ5fWXyriXYmsRwTsES3Gn5h/wHd7LbFZfZMWiAqFnUtqNGpsDVYhGhkCWZieqiU6CLIrj4+XR61aiLwxm18I+nPyhMFlxzV9aqI8dXrqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMm4r0PaKiUFkoyYrBQVKQVTj3zF7wb29Z+I9KrtWgw=;
 b=F3wEhCFUbVrwNV1PZIxpHeLSBEX9F29nEOZrAjcpbz0giZkFGvIn9RfBJQzdmVPSpc4jMRTIPwuvOHLDYHM52ggu6ca+vqT4GBMfcyEfT2VjpPqStrACKh2CkEzshcJPklrbF08oKEYj/HA/yfd7uikvOAnOJqYgnrw0hCaGlenLzWYgvWpnf67ymJMgx1kqSZgeQvjLEDPQq1dBCkRJ9lOPal1QlSzl/eApvrF2TrcKptgB6pSI/A93wXLX063nmK6sYUadP3b1CsUic2G+tMH2HYx7ZgytB17LiUtVJIGACMxe2WdnhmDuaOobycaQKv9l1RV6Ea0VfdLlNV79UA==
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
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v15 06/12] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v15 06/12] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHcc/E2XLLeCl4JoEyoOVMfnLdvAw==
Date: Tue, 23 Dec 2025 09:47:54 +0000
Message-ID: <20251223094739.1983381-7-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: ad7eafc1-c8ba-4df6-90d0-08de42085a51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?f9IOzHwIX4j0VC00wZ1Y6p2ElqhNv31EMU95MWRb+0dvkaLnythWiAMM20?=
 =?iso-8859-1?Q?pH1hNGcoq3dsBObyucdJhhTUr0ZPo7j5nI2e7xdD6dgxGtfRPAJveDQpVm?=
 =?iso-8859-1?Q?yDz1SuyYtJ96fVFdESKlRK0UD2swcHnF79qZkE/Z7DDqa/9QAxlrWYbi8j?=
 =?iso-8859-1?Q?9HDvU30bf27GKtAaTAXEsEf1Mu4hx4a/c1fXNNooVUO7uK6wC7T84WaQol?=
 =?iso-8859-1?Q?tREAtyPgZczDab9Z8aDt/gzU7Xx1VTdxoMZRYvFUOXmz2dCUIyC+JY9X9+?=
 =?iso-8859-1?Q?vscVdPjrYSKI5ywbX/tOvh6zpyeAllYbMvLEKfm3s59YF7cRvc6v6leV+R?=
 =?iso-8859-1?Q?Owae6qbG4SEGKRxZqhXqddDKLcRlINSyplO+YE+PswNIH2tsqwT2NK1Pfx?=
 =?iso-8859-1?Q?WwgI3RXMc1eo4doGxQyv+X9bpNARBWchjgqVuAPIuFV1D+rwxgDbVb0osR?=
 =?iso-8859-1?Q?LlSdq80VY4m5Ym7jnpImQmG1yem92xXlwtR2V6sj9Rr1d+ldQ8SHVNMB7z?=
 =?iso-8859-1?Q?A4Tl4sbkVZ88c+gvLXyGqK9v8nD0QEvSV9h2W1B7cVoVy1jwjWYwgoeOk1?=
 =?iso-8859-1?Q?8aYyCVavngj41cEgxYPFpdopn9+wpriQ9vB5Hv1PRucVB5nmPsd/iSTOrT?=
 =?iso-8859-1?Q?aLwJR0x7zfOLyAxvW0gkrZRxcE6K2Wt4eBhihhf0IX8H7W4PvVxfef1Nz3?=
 =?iso-8859-1?Q?WPmrZIanbUCjKE67vL7EmzO0VQKHTTHzay0EP4eDSQDqNJjz9I8pwYmOUH?=
 =?iso-8859-1?Q?watMSBdbN4O4CgFbl9Xxks7mgDhU3ueLMV/IXTbqJ4y8IVVNapyEqsGWbX?=
 =?iso-8859-1?Q?G9nKmhY+RTYUZEHTvj68ru7ZPRUEF22QRORiGOrBahHi7NEH+RwEdlT6P2?=
 =?iso-8859-1?Q?JtijJTV0KBZy3y45SLhiMuBxLzfF56C7NyJTwvFhskoVXcPGXuKGQT5IR0?=
 =?iso-8859-1?Q?xQQsk/Qb+hgbvPgfyqp47H/F8gb5Kc5Nd9e6nbj00UOyN4pFrXsNxzTYcZ?=
 =?iso-8859-1?Q?uFNOeyvOBmf7DHNWBiSs8hi9MANM1QZt92P+4oaW4LbqqBuN6g+YSk2GPG?=
 =?iso-8859-1?Q?yEgFcXjSr8geGCSKxw2lMsaLwTJy95lZ5zZ14vJfzBJlnv8QsYZo5KunrV?=
 =?iso-8859-1?Q?UTGWG43WXOW5kjppaPQe8oqkdkGm/z54Vn/HMfmAgPk5rPQTbiUWgNnjLt?=
 =?iso-8859-1?Q?qiC6m5BzsDACNksSe40LnXrJrFqdWjfWiKquZHfXzk/HVgM1LQaNwK3v2n?=
 =?iso-8859-1?Q?TIeXcQRPx0jljyP84iEjPuwIXPUaOs6U964eUiIIMySa5R3zkCK+BBqRuQ?=
 =?iso-8859-1?Q?UDFm8BGCzuRal7q+LEyj7RFm6pU8eHMzZU5Ejw0xcx+MIGr0dhJA64rsus?=
 =?iso-8859-1?Q?uytbIfrOzngYqb/QkZ68sW5zI3XFZdTZS9hCMh+lzZqxyk/u0WUO+/nYkY?=
 =?iso-8859-1?Q?GPOFGZf7LJ+oVdun/R9g42FTlJGKObqMEjW4823nBsMm9Ac9E2M6P45ha8?=
 =?iso-8859-1?Q?DKe8e1vqd/OgXNrxwicPlYzJ6FvmpZPDiRmTwnKUy1i1I3wVnuvIO/90Ow?=
 =?iso-8859-1?Q?Ws9C0osJ8amdkivPaWeCbhjSdRss?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M9x2oFZad7USx2NQ2Rsgdps34AO0/sui8Pb37fOpoRcHKinhfGoMYriX+0?=
 =?iso-8859-1?Q?3rgujk6CxgNBOc2MJ/+25X6R0XDLT02JsXV6JlSnUjkLN9lrHI/ETg2l8f?=
 =?iso-8859-1?Q?+yl6RYDW8rwi/Lx7w+oOe0sD3I2mZLWinFxXwo0x7jc+aiKhUVLa6ZYQTb?=
 =?iso-8859-1?Q?t8KcbL8J1bsPdLSgk4J+nJkT9grHcqgyb9DjmjaauvDAw7mcAbc0guf3fi?=
 =?iso-8859-1?Q?oNPvop6A7DD+Ne/ugQBuz6RlZElR8WgKhGH9SLu7BaV/sRwHCkSPYFtrjw?=
 =?iso-8859-1?Q?D+6JcG7OZ1vUgg1uQHm2xK5LZelxTUa7BnxK4CIpnGk1UmjW1yCDuqVLzl?=
 =?iso-8859-1?Q?rNGSyiiYJLuwuLHMD9f5QsMfn2NPFACI7/rMGNgPGOM6NY/OXPiqxUyqCc?=
 =?iso-8859-1?Q?bSZL3N0ficSU+HSuCUGGyKqIEkohnQVrSryPjU3j7P1dg3dRtpCfKZ0s/Z?=
 =?iso-8859-1?Q?46HTbdzYcTPd0UXnrjc8RXl8rDPuNYNp6Lpi7qRf9KUPgIZSCCT3Hpkj88?=
 =?iso-8859-1?Q?cPp96kbBIVBpM7gybHkbNXW7V2Lnlli/psbUWBGzbDZG+iwF3SXaCU5xCl?=
 =?iso-8859-1?Q?Vs8IcgDa+YS79hfff0X/48toT8fi9xiXHkTTPUZzSWNkXONVyVC1BtBtf/?=
 =?iso-8859-1?Q?rAXpBUrlrzaFjG/tIVEN3rr9fG5PEejNO/MQq8xPYbjwTnToVrxUwfR7Hw?=
 =?iso-8859-1?Q?hCvO3951obGE7DqKlZuBsVJOD0N7jw+fnw/qmYObpCTHWgM7p/rpiMfHmb?=
 =?iso-8859-1?Q?UDXmaZ+lBuv/fTKJqkLcQmhASc1xYxslmgRbdxh4J7lHm2dFERruyllwtE?=
 =?iso-8859-1?Q?ER3KwR7cDUiraVVVKoJwPq6X93SDCA6jbTSdc0zu120cm9HRAGkiASgccm?=
 =?iso-8859-1?Q?rcNGirHfosv/0u8v6xn+IYOqsgm4xD4P2xYogFjp6lHHW6vnz9PF62dkOO?=
 =?iso-8859-1?Q?0mZq/QQI/+2HGb7llXgarHxDkVrwczTiepi+3dKfj5JfLdQB0LnB9LGBg5?=
 =?iso-8859-1?Q?9JSJKnnEtGslcx9ORtfFozCeCF7ua+qa4Lv0+i+FUDqe7EfI48IJirNGM2?=
 =?iso-8859-1?Q?cUhhrpHNfiJZicua2riHFJ9Qm/aL/gv8HGi3cyw0TWUTHlZSgnzHlZXFaw?=
 =?iso-8859-1?Q?Bhcgr0KH8m9/UJu76KdbIaIdpEhRdS5omQzD9AMQhEILgqdWB9SX29Mh98?=
 =?iso-8859-1?Q?nac6GC8CqQZFOckaQTHCP/yuNaO5JXO8Dz/79adcGcsP54A8/O2URpr+Fs?=
 =?iso-8859-1?Q?wGO90pY9ymjs826jtc8p/GF12xBUUdZU2l7GNBaG1nMb9Y9Eitd5yG/QBM?=
 =?iso-8859-1?Q?8ZSaN0kf7qrBnmqjCXMjbzHxeMu1dUi5jHZ2W1RlcYtE/e1xYegAWLrfUK?=
 =?iso-8859-1?Q?iIQ0brvCLDJyAZLaAzeWsBtSdjQJmh4jikr0Llrk33PzdFzUVuBnuAG7XL?=
 =?iso-8859-1?Q?bbD71ErwB8U0oe7+NImFA1dYrEmBBDZQ39JBCCi4TzNejk9LCPj4Ien8fz?=
 =?iso-8859-1?Q?W7QyurFJwk5buDg5kK0nb7ZyMBJFAq64PLhC9SbfE3vCJFyQNsbapVwiLj?=
 =?iso-8859-1?Q?fKi7A65zOOMHUX4Jmd3rQbGnNmQg8TJBIF+oOYeWk20TbHrsnE3whUgava?=
 =?iso-8859-1?Q?U6Km0A1csNXykigtzmoShqQRfJMUajL3Wki0FBB0vnrD7vZtn2l/eBpnNU?=
 =?iso-8859-1?Q?0IfbEMWHwHQljgpZDg9V6trJGSTp0R8xRt7y6iCDVPP8SW6CkRpxU70zg3?=
 =?iso-8859-1?Q?2sCxIWnIo08NPim2WiZkYS/WCZ8GSEQJn325gYDBYsSxbzk/4heVAOT0KB?=
 =?iso-8859-1?Q?H0qyOEyl8kOoTWr9sK3WES35WK80cXvFv4qNwPugDI0rc5H1Hf1C?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7eafc1-c8ba-4df6-90d0-08de42085a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 09:47:54.6653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PzLVRLyNsIrEyu6GEBUZU/CM/0EytykNTzXa6b4Xdk0kUYnpPB0fA/82P5sBmUgv2hqy34V+YGgjn/I0eSB1e6+6pRv9tx3mQafBw+oozY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5758
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

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 88 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 ++++++
 5 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08d6f69ae5..5f63494d07 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -251,6 +251,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1386,6 +1387,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3338,6 +3340,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipslsp =3D true,
         .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e4d5039c49..cd1cba797c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 7dab84fc07..7729fef3a8 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -149,6 +149,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index bfe9046153..9a72f3392f 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -21,6 +21,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 /* Conditional move by MIPS. */
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
@@ -38,6 +44,88 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+/* Load Doubleword Pair. */
+static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_y);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+/* Load Word Pair. */
+static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_x);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+/* Store Doubleword Pair. */
+static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_w);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+
+    return true;
+}
+
+/* Store Word Pair. */
+static bool trans_swp(DisasContext *ctx, arg_swp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_v);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+
+    return true;
+}
+
 /* Move data from memory into cache. */
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 4215813b32..3174f17aa4 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -8,5 +8,28 @@
 # Reference: MIPS P8700 instructions
 #            (https://mips.com/products/hardware/p8700/)
=20
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
+%imm_v     25:2 9:3               !function=3Dex_shift_2
+%imm_w     25:2 10:2              !function=3Dex_shift_3
+%imm_x     22:5                   !function=3Dex_shift_2
+%imm_y     23:4                   !function=3Dex_shift_3
+
+# Formats
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
+
+# *** RV64 MIPS Extension ***
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
 pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
--=20
2.34.1

