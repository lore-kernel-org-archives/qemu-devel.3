Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4193FC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQxL-0006zP-BS; Wed, 25 Jun 2025 10:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxJ-0006y6-85; Wed, 25 Jun 2025 10:18:29 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxE-00048d-Bk; Wed, 25 Jun 2025 10:18:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ciar3P5a2RIBivlStiydFM+K5NJahS6zUx6Y0GvBhrvS+jbI3yomygzl4DEpTG4k7cWXkOCSpCro0ewy4LtRHadNHyNhFAA1z5DntKXHrMLOwVxMrx8bZlUapTFg5szaWK1Lt0Ed9eSMx6+pW6TeOVADowoSczko3O5vxb/iXX4ITaZETrEn+TPDkf5Zce2Jr1B5yRXMUs5e3UVi8lhYsEmVPEdvsExYJhXCTnE+oXRhwonMehALGYOtR/FB0NJaeFwtIwI4LwWxxEjcL61xTzVWCQ53OYKM/RRaFer8KbniAn/5OIV0VCEQ1RkNLQBubKDpUFUSqERZSSouVbD/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRVgwUAc3F9c0yyEBrx802kJv+j5LhX+cSHhOggl8fE=;
 b=uzEGORoYsik7JC6TqUqEZDdG2ZeGxEwpr7SUSzX3vuliVR39Y0Ru4xOFFA2VlmpB1/4fEMxKA+j5TFEHAEaqi1ypw1WNBXjVU0FevkrRAsx6CWxqf//qG9z67Wq1rF5eW4gjieGO/lEatr5qsF2u2sWaSXVuANZMna9NhjAaNNutd3GjQgD7cdrsaVHqq81lECkIJ1LYLkm+w7vNtzl8EnPFLYJV9HH0BiVBLoumP8Ychp5yo2ZbKqVGBNU2TVWkSkfSchtvA7Lg3daJ0zPSr1alz6OtnzPW/N593yoYJ1WyWCAwBPLn/3OzwVeQKs44k3D5Ap/5ASOmXBmpyLy0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRVgwUAc3F9c0yyEBrx802kJv+j5LhX+cSHhOggl8fE=;
 b=mNjevVkH1OXquv7Y7sslSKOUSdIjLWgmm3X1wh/o4u9gLA7IPHq/hP9Ptziy8G791sW7VLJDAWlLF5lXQagXWrNrK6tUM6AYuYRU8Ps2q1cOV1Up0eKEcl2TPxuGLQghkEKu8fS9Ff2XAgJhxwQjp4PfJHow0TdjMbCg49ZrTGRWaXua6z4tpsqkqnXYPy5HEOwintJGNtJpKZospo4+US2K7xxDe2cNVuTrGRJpoGf0q3t+VZggXhgC3U5F+H0K1ZvCkhgx9Mc5wcWQSgl4Naaltk9K2P+PG92ZOU0fRVrGZ9zdFHhAmi5DYwrZsZDNLQMBjPBrZkaLp2AvBdThfQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3665.eurprd09.prod.outlook.com (2603:10a6:208:182::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 14:18:17 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:18:17 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 00/11] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v4 00/11] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHb5dv+SS7Pb1C4iUyP8hnr9zEuvQ==
Date: Wed, 25 Jun 2025 14:18:17 +0000
Message-ID: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3665:EE_
x-ms-office365-filtering-correlation-id: 5b9bfb0a-153c-42f3-c39b-08ddb3f3212a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SZrWwpSkxBfkAVYYviyMH7cYX34uzB8IW095IwS1nWKrOI60cDou5UNlxB?=
 =?iso-8859-1?Q?E892hcWSP1XcpmD0oUXrEEVgWugcydfFzGzbej4kxcbwvX0nsEEVDOFTVS?=
 =?iso-8859-1?Q?jI784ejWuyAIHkAoXesx3vcLzK2HVEFWKkzYmxLS7ifSzGIuC3qoZzd9n3?=
 =?iso-8859-1?Q?g6JYykNbdFA0JzLDjzxPjoQCNmsPsuXItOGUZiFNwAzsE8JZ/0wmuN4M5l?=
 =?iso-8859-1?Q?lEt4e6IPWAJ9k9mMTBMAxcJbaNDZxx7Yuxyag3q2pvAgSbXAqhasYKNE45?=
 =?iso-8859-1?Q?6rcxjOdvryk90AHtYYJ2rUoz92cedForRJ3uF6FWl9lwaCwBwQ2vZz7Zk4?=
 =?iso-8859-1?Q?CGeYhLSlXqDpforFahXafNyM8qXJhFVvsOPA3TcOalqQGdoKPL7Wkqcz/4?=
 =?iso-8859-1?Q?NfJOH9flz2QHJ6iLygZDVwKDvT7aA67mWuiC0RyV4rjWC3lSksKb3NsQqY?=
 =?iso-8859-1?Q?Gz82HS4siRijneGU6kELG3U0yaFP2wfQS9rs/Q5q/PdFrJ/IJjl47q/o3+?=
 =?iso-8859-1?Q?Da7iWXh/ZrYuPyeQ7rfnzAEi+7Y2qbkoe2OTt+8zPCh39a0ev+ATShvCA+?=
 =?iso-8859-1?Q?Gg2UBITsIpMSMvwe4kyoN8muHE1P2GPlJFJB3R8DeZerSBaDNpyBen8v6u?=
 =?iso-8859-1?Q?h1S28J1gKqiE801eUc/RNcSyCcXwzxo3EOaoYqg8gW7X+l4RQB8HBi217Z?=
 =?iso-8859-1?Q?O7nbgkUYi7kTvyQ0G35ENp/Q0+RHPOC3LrKnWheV903aBDhbzUy2edZTzl?=
 =?iso-8859-1?Q?gflerWCrHUw18XLMzi5QnWveKaM32Nm69EoVtdkfM/cKAf7h0ppzOjqBk6?=
 =?iso-8859-1?Q?wd11i3duFlcfapkxm3m+xjCVDhVgu66vwZF5VFqym6Jiaq8WGI45Fr1xwx?=
 =?iso-8859-1?Q?mY9rD1thCFnlB1eWeGOzo5wiI5RIjPB2B4VTwpWsm2Yehi6+Zh8NRKbv2x?=
 =?iso-8859-1?Q?0zJOIl7zmHMEuGYcu8o13s+ERY87OpFY1irL8qGAKRy0AldilcbweymWWb?=
 =?iso-8859-1?Q?LDu78D/Mt85XQgVdIlzSbPwZYwtHviWsuLaD/hfh1KQcxAuhAsMYZyJABQ?=
 =?iso-8859-1?Q?HwPP/ukLW+b7Wgq5EoKTGvH/4leo6I63xxj+AWeoBA/1oG4/Ssr7utk9/A?=
 =?iso-8859-1?Q?c5zFMMT3Ihpwkh0+dFL4fJoclePg2Sxwflcn8aa371+UKtErPgRAwS6yoE?=
 =?iso-8859-1?Q?xPVFwzRgqSVAin0vhKVmKdxIuf9MIR70r86WwFPXf5zKchKE8yQhWhIFfy?=
 =?iso-8859-1?Q?+Cu9ChCyGtzyRYwa1WGfy/YDmvUjtxnOsjsRG4HmAuKmmX6ocqI1dHsjHd?=
 =?iso-8859-1?Q?TGoyFqE0rmnUrAiNZgZvO35bUl35BVusdxsLKhl0PDLlUARjBVnDdv+QJ2?=
 =?iso-8859-1?Q?FWmdG1F2h6fktlGeM0DUMf6c+e7Ygy9RWMW3BgKQCIKhm7WWU9wNpyS7de?=
 =?iso-8859-1?Q?fiy0APiFLsdL+/VE+BOtMq+zy+ajcjMhcB8hNe28XBUwTtadFPgmKAg7tU?=
 =?iso-8859-1?Q?7yniS6/5XqFLWk3WELSMO/kdlyzixvigyyZ3j5dFmkGg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ONpT5qYtWy2pzZdj/k0aEcewtoXTBwk7+uN7/1sohNWhbIQ8uXTJaeoZO2?=
 =?iso-8859-1?Q?5o9jSA/gphA5si9+LbZ2Af6mkq+rIPF0NnyxptVXp8U8dMQ5GAhDuTXJy7?=
 =?iso-8859-1?Q?87cav1EUXkV1k+bm/02xjz9Nd0fiYYt/UTQScAQEqet53+68ZBaR5iY1Nz?=
 =?iso-8859-1?Q?X4w6j4Ph/mzkzfVBV8IYvpYgVSU2WX0msEvC6IkV8UEhR0Q3us+0J0sADq?=
 =?iso-8859-1?Q?gPoMmXvm/gSKLu5qxTaD6tFVvPesq7pSYAwA2LIJZXMAyxHYNkSCFmUYCn?=
 =?iso-8859-1?Q?t2V+7YkRM5YfxRvW6QnApE/Z5dpYACurgBjmGEVjR2ltHWi0A4b3rX5Wn5?=
 =?iso-8859-1?Q?OtYHAPtdT3nFCLli3iA+TCjMxflA7Ijodbu5FfguyueFZOzilnplTvO14U?=
 =?iso-8859-1?Q?dA8+SWtT6O5M3EXR8EuucA22XTW4ZFZ2Rt+5NiWeFRBoqQH6/BylL7ygWd?=
 =?iso-8859-1?Q?8JO3SC/R0wWAw3wWGlEk9RlzOAkyA/66Rwlx9dibfWccV4e5/IzgKmIM7c?=
 =?iso-8859-1?Q?gjCDTuBz5sxxC3yOJb869F6XbbHhPl64gK/UM/S4rXx6mtZj1APTsqi5fz?=
 =?iso-8859-1?Q?vtU817BuDbvuSiFe4X7cm/6NWMY+IR5ft/XWg81VdD3eg5tA/0EmF9PJur?=
 =?iso-8859-1?Q?aAQXrR2lPF/Rx9eLTWio/wEQFNPZORpfDAueyaFg/gk6GAHxDZ6lwawafl?=
 =?iso-8859-1?Q?umdIQ8z5fzU/c0uqF2ql/XuXH+fqxU/7eovonJm7JzotFCDr7g/EbicMBa?=
 =?iso-8859-1?Q?2eQNrXINJ+cEawB8aGaZRfAN/0Np9LPlZ6gDylG+R03gHZpOme+jJQE4A4?=
 =?iso-8859-1?Q?8vXUHDU25fV7GCcKffKNjZdBtbv2CDHbVWin2j8sCicqh+MHAsPxpntrco?=
 =?iso-8859-1?Q?Mv+uEnpeY8X8wGTQyKzbOcTTGZOwk7mtt4i0MpP1AL5IB7h+uGkNW+NVKj?=
 =?iso-8859-1?Q?qfZAQeTa6tSuqs6b9TUbs768k4qcfKek9ImhKNEiGLvsRgiSL4viWDzymn?=
 =?iso-8859-1?Q?RN0J3MvZLHuuaV20U0+IEw1tcLJrvrkP+8B34W1uZFUXmXik/vP0QV+Wiz?=
 =?iso-8859-1?Q?P6nGTZkqYyXnFBqk2lQ01AJIzVGikuniwRbirnexvDKZLg1e4t2nA6ZIlg?=
 =?iso-8859-1?Q?l/rDUgwpVgRau5Y0TkQsOBqLUrdc/qYgvDfsm+cl8xpZ3ttL3Ap79b4EXl?=
 =?iso-8859-1?Q?lvzlR3wtgR51ZrfAVMWrI7azIsJxSeM0O7NwkoS7rg4tXvd21PqQFy5apo?=
 =?iso-8859-1?Q?ZsGaIV/LqPY8PEth9lTRffUmwvqnYW+tkOisHjPRL20DZnaMzj6BgKU/eN?=
 =?iso-8859-1?Q?0YhYNqrFlrdkTiwuIrRr/JVLFt++MYHSsJqFR92BIpXK0ynjobEIKH+2hs?=
 =?iso-8859-1?Q?tjWctn96zRTG/XX6jJQ5PCx7VBTT6KtclPQh5kmBlPy58srJC+KS3NW2gv?=
 =?iso-8859-1?Q?UkD1pf7u2dWoMltomcBCqPzn7kVWAuYN6xLrItojmJOLUGZJy+0L5mFUjw?=
 =?iso-8859-1?Q?FNQ0K+5fDQ5RUQ/ghNXJgdeW34kjKZhmc10nfqsWUbUjRZC8kjNJCCYqj0?=
 =?iso-8859-1?Q?HnF3rX3K++MQOQSWeBFQQxcJQPzioaZrWMN7Gl7ePyLaStSjH37oSCyXkH?=
 =?iso-8859-1?Q?fhvdPoxdhXQjel7B7iccOK61CXyP5LYAQOCPEdcbYDp998KuS150PT3QxV?=
 =?iso-8859-1?Q?kLWau+UrkkAN4Pd1RvE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9bfb0a-153c-42f3-c39b-08ddb3f3212a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 14:18:17.1240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gW2Mg2ZdAZ+WcKeafnlMtpZVL4hoiIJ+cK310CYZYpNNJf5ZVRAMPsyPCVRewcuT/5+imj68GgNw5U9zhCpz34WjwiiP1rts9zySN77Pv+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3665
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

In v4 I am addressing review comments.

Djordje Todorovic (11):
  hw/intc: Allow gaps in hartids for aclint and aplic
  target/riscv: Add cpu_set_exception_base
  target/riscv: Add MIPS P8700 CPU
  target/riscv: Add MIPS P8700 CSRs
  target/riscv: Add mips.ccmov instruction
  target/riscv: Add mips.pref instruction
  target/riscv: Add Xmipslsp instructions
  hw/misc: Add support for MIPS Boston-aia board model
  hw/riscv: Add support for MIPS Boston-aia board model
  hw/pci: Allow explicit function numbers in pci
  riscv/boston-aia: Add an e1000e NIC in slot 0 func 1

 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/mips.rst                  |  25 +
 docs/system/target-riscv.rst                |   1 +
 hw/intc/riscv_aclint.c                      |  21 +-
 hw/intc/riscv_aplic.c                       |  10 +-
 hw/misc/Kconfig                             |   5 +
 hw/misc/meson.build                         |   1 +
 hw/misc/riscv_cmgcr.c                       | 206 +++++++++
 hw/misc/riscv_cpc.c                         | 225 +++++++++
 hw/pci/pci.c                                |  15 +-
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/boston-aia.c                       | 489 ++++++++++++++++++++
 hw/riscv/cps.c                              | 187 ++++++++
 hw/riscv/meson.build                        |   1 +
 include/hw/misc/riscv_cmgcr.h               |  77 +++
 include/hw/misc/riscv_cpc.h                 |  69 +++
 include/hw/riscv/cps.h                      |  75 +++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  27 ++
 target/riscv/cpu.h                          |   7 +
 target/riscv/cpu_cfg.h                      |   5 +
 target/riscv/cpu_cfg_fields.h.inc           |   3 +
 target/riscv/cpu_vendorid.h                 |   1 +
 target/riscv/insn_trans/trans_xmips.c.inc   | 140 ++++++
 target/riscv/meson.build                    |   2 +
 target/riscv/mips_csr.c                     | 226 +++++++++
 target/riscv/translate.c                    |  11 +
 target/riscv/xmips.decode                   |  35 ++
 28 files changed, 1861 insertions(+), 11 deletions(-)
 create mode 100644 docs/system/riscv/mips.rst
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 hw/riscv/boston-aia.c
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h
 create mode 100644 include/hw/riscv/cps.h
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/mips_csr.c
 create mode 100644 target/riscv/xmips.decode

--=20
2.34.1

