Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1844CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tTN-0004at-Ul; Wed, 01 Oct 2025 05:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tT3-0004RI-KA; Wed, 01 Oct 2025 05:49:49 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tSt-0004vh-8h; Wed, 01 Oct 2025 05:49:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdzgDwB3UGUaKXwa6i/HsXO65p+JeZKQZ3KPVrg0jpTrkvE2Rrqi5MG5yAgSZrmOZvZWbNDonELw//OHbZBl1RUEOxnX0IlI7z48wdwKIh3w2CIGwddsF0aDpkuvyvJ9GxLFSPSl9fsYMhWmU5TiXa6H1d3zzUOn+6pzR9fPp/7ZINGjY2FCjgtS5U7NYjCsg/cTCh210kfes1zDaMyJnv9Vno/seGAvQMQK5S04JdUUuWUhKqabxEdlSH5A+OBlysew+r2/iTOwPPMgNm9USweal0moWL3uMJ11bSGYd54f2n0yX/btcGpocmXxUGJhfivJHtGahCq+fvI4COcqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvWSndUPaVYQQkHsmo+vl8oRxpG9eJoh0LxPt4lJ8ik=;
 b=FXk16kNg/hhr+V4k5EMzcVTUkYFNbttLaJhlOQUuzYj//s+IytdDcbN2Je+dNZxbG0zja6daZYSvg2ksUbzA7+VG5B3OL5/NgMV3mB13Wdd7rrM1bunuaYm72Y10Mk7VsbAJwgI4fgb7Ghi3vlLMbVYb1Gwq/jvJwjiGYxr2BXSxdxsbI66m4D6xWhoSUo4gpekkX/LypVlZ3mk6l2iCOcJmeAjRrFj1Lcc0CiiRFoJsbw1xdijfRAUIqNYr0Zf/rIXuAhCooUhLyNM1sCH1tJQZl+hRjXFT+C+eCE+TZtnliS1M/SV1pSmnE0J8aKOv1ON1gCGht5OujHqpP2xOyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvWSndUPaVYQQkHsmo+vl8oRxpG9eJoh0LxPt4lJ8ik=;
 b=uLYc0yBMJyAvolmKWYKCLl+G2uqk++t5ev+JCVjhry4ZPe39NRcaeiMg48txRvC+sOin6RhImUcReMyd2g5jgQrlZbGNeWR4cNVNQnVO1LEjvXM+02u9UfSeC18fM43UKxk/yrM04WTwq138fjlw4AhFJhrzTXK/lQb0uAFZSTIDIZtD/bwQnoWF4SQyrCsLwtSlVtUNjekuu8wmLN3mgZ4BQVEGufYL9Pzj/noOBTjRzlwmXXDUiYncjJOXEh1LgK++sgC4gJa+pP/GrLe9kuHA45Q1lQD121xNdhNq+sg1OkIF/y6LTzwZCf2+oLsMGzpaBfeJ/+vd/f6o1KQd+w==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA1PR09MB7820.eurprd09.prod.outlook.com (2603:10a6:102:44a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:49:13 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:49:13 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>, Djordje
 Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 09/13] hw/misc: Add RISC-V CPC device implementation
Thread-Topic: [PATCH v9 09/13] hw/misc: Add RISC-V CPC device implementation
Thread-Index: AQHcMrikbfKgay3dIk20SPHqlTCWsg==
Date: Wed, 1 Oct 2025 09:49:12 +0000
Message-ID: <20251001094859.2030290-10-djordje.todorovic@htecgroup.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA1PR09MB7820:EE_
x-ms-office365-filtering-correlation-id: 58e30368-5442-41c4-e844-08de00cfc6fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WDWZr9EZLLzyAbU9j+wonrT6naX+376wKpVY6qpO43UMJM6Se1z5eAV7hw?=
 =?iso-8859-1?Q?0TpYZFEhJLF7+7rkwxwh3veyD86SxC69iNERESjBsZdLp0SMXIzvGyUDra?=
 =?iso-8859-1?Q?JuXxTcn2YpiJFTdhnVLDbCyES8YI2Y60Ood823UnthLjWGBvpn42yvUQNd?=
 =?iso-8859-1?Q?a30E0QuO/l2GRl7hQEX0A9tqysAKBfSk0XPdku8iN40N5Fgxolh+iS67bx?=
 =?iso-8859-1?Q?Fu/IEhsV8RL8Sldiwat7hkrmX7+PBxo16lMPK/hMKi0BwJGHCEXXLLb+dw?=
 =?iso-8859-1?Q?ds0N73pHfrRtAihQbpFb/W7SqqMwXxXFXvDcyegH5GviMyTndViXdtEUAA?=
 =?iso-8859-1?Q?YSy16S11Bb+s8SVNs0knv8sFAeHPBEs3fVATfl+98eWLxNaI2txRE/AOtd?=
 =?iso-8859-1?Q?hAvdlIpdT5nsHY2pjtN8iRlszZ+XqMY5jSi5I1kIe02q3YSfUAMrrIYbtO?=
 =?iso-8859-1?Q?YGq/JuRUNFHWC6NYsjYOeuNBFsbkqHTXTf1+eyLGC36tAt0dnk6GUKzsLP?=
 =?iso-8859-1?Q?ziBKqRrUzvlYhwGzPzk0W0IfeWvdeOF9AfCkMiLtqZ9iv6Kj+RIv0kwzIS?=
 =?iso-8859-1?Q?36KWq2PlUcoxZKTHm2LoZ7d/SWVxeZVW53s2inrzBcTcTGmYziz9EYD8sA?=
 =?iso-8859-1?Q?lcRIJiStxayYzYLwzeVz9EEb0UDpjp/+NVY2zeCPoJeCFrYLekRom1wub8?=
 =?iso-8859-1?Q?t9UjTHaeigaFRi8ELZDgdy6QixZqNo+z6r1oYKjOXn9krDno5msz1LQ12m?=
 =?iso-8859-1?Q?smpcAfN0NyJ7pN9SJ2IUjKFtxySVpQKc64OPo2OJu0saCFBhA0Md//eHz7?=
 =?iso-8859-1?Q?N6fIH+/Np6eVRmx6kdPP2DzND07LS0ajth0GnGGPFvzdk4jJMpMBvj1kak?=
 =?iso-8859-1?Q?uyGLPz/LGqAQZ8I/catuPu1gW8Il3t0jJWn5KfbkrvKzHyl+bapadFRmxx?=
 =?iso-8859-1?Q?77Vbg/pYJV04EUt5R4lu2DqUg9a1kFoT2fK8XYb71+tM1EKNb7gkN0rcnC?=
 =?iso-8859-1?Q?SysLINuqVUJuH9I42m+0E403W7onrsCeoTVOcluA1r8tVGwJulSPNsag0j?=
 =?iso-8859-1?Q?tdi77rYZNTLNxxVWupZWGNCUjYRBprXwzKCz0sksDPZSUjK+UnkvJpHMnT?=
 =?iso-8859-1?Q?pw6mdPoAWEfn0e7oA827aT8rEewN+MiJdvHXmCiLsjxQepVMF4Uz588ckv?=
 =?iso-8859-1?Q?zBfd7PPjD5DYE3FlaXFStpHlX+rxDqTc7t9zemFH9HpajgI/4jidE6oJAw?=
 =?iso-8859-1?Q?i69OlJqitFlGBFOxAyb0keSDJcHHnnaLRZ03Srn6JOZK7GSYopS8oWK8m7?=
 =?iso-8859-1?Q?63kpDxdYdogkQL2Kpp8mDQ8S6AHXw+FympQK7NSRJ//gQyK87cRLvzgE4Z?=
 =?iso-8859-1?Q?FggVBUPu+/+5+ZYcepdS6J59T/QCBxX6fWxJzHWiNo2+4hq97TxgBmVoXS?=
 =?iso-8859-1?Q?RvM/1NQJFS7FBXGoc3b1BUNp/OaOq0zp0CMwdhNJ5hmBGEj2+niV2i+1XW?=
 =?iso-8859-1?Q?i6WCrtDGCd35gH/V5yE9XjxSl8A/fkaiLkKs5i3rF5kQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oUGXWKrUP6/IEq9KZ+MvOTwBgk8zkl1xtmNeBvZYzp/8XFLBxpNuYCIWnK?=
 =?iso-8859-1?Q?cHX0g6Cp3XQ6GHqXE7rdPIEUlXS7maEVOLK3CsAq7ek82nmgjautqzdoeW?=
 =?iso-8859-1?Q?KGKPf6buf/DdFgod79s9Hg16LnKcFAP6wMMKi2zgN/EcrJx+qaj87RNTPN?=
 =?iso-8859-1?Q?JRlS0Sw6HkvblUZrkFgfezTvFpPJFsQtRe4mG8mzTmEVzsHvxSb+8gvGM7?=
 =?iso-8859-1?Q?PHwGRfDhwffKITpSwl/c3RmYJ/JId2Imd0lVhxR8beKn5tJCvHyMDjDSRb?=
 =?iso-8859-1?Q?yvKtSs8bvgtdeXNwEDvyywWYDFgsUWL+i/PYw+v5y6Yd2SEnCH7l+75vni?=
 =?iso-8859-1?Q?HQsyNQJAzRFKbk751xQzeT1407epZPYaCpiWHPH4NaqI9xk57FmORYiXSK?=
 =?iso-8859-1?Q?MwPiodRImdJkn7k0ZQ9WFxhS5dvvBMeu6emwsru1bAgJF8t6ppVZPrpXz2?=
 =?iso-8859-1?Q?0QvwxVdG8uxI5uPDmA1KpaMWnLlyrS2AK2HftYrKn1TeE8GaVB7W4AzDeK?=
 =?iso-8859-1?Q?EHC2exdfIz+Jb9KLHx6O/SQzWbL6W0otYgyuwX0GEb4BhaDYyAIxg4v3YM?=
 =?iso-8859-1?Q?fNa3hcRoO3EgZhpg8Te9/0XTbqOIEYKHjdpxW93OCJWIr2cF9/UxUFs9lo?=
 =?iso-8859-1?Q?ZVXTGovYKP0Wu5orCKFxqz7/Qg99WMExeS9w+L0Y8sWSunwC52wGpsXR1B?=
 =?iso-8859-1?Q?I5/LbIXSxgOs1QIhyeVt55OuD6qdj3njivTwJ+TvYgaLMZFSdhHe8nX2wT?=
 =?iso-8859-1?Q?c6BVJFEq7IvXAg8QhDkDthCHgqQaB50ReWDT8rW7RRNwhD6s1085pZWTBS?=
 =?iso-8859-1?Q?PkpDRo9gzdDHumIzwcM6er4tnzLXnVtdBnLhYhBy/xfYOzgPVm4pi0SAit?=
 =?iso-8859-1?Q?7PQ/ppmMXC6NhBV7WUtP1UHq9dMIdqGE058Ulk6b3N7VhXNqbzxsZ2zfpz?=
 =?iso-8859-1?Q?DOa/cWWe+PDM9Qa5m7JuaaUmpV/jwYwvFAaTpg+Jtbf+YEfvWxuKB9dyUO?=
 =?iso-8859-1?Q?I1fJlqzMh5lRBQnO/k4opFByn3IIJqWjvGTcqoV6OkuImxMt5n+MHuRbc4?=
 =?iso-8859-1?Q?tOL3/hOtvN7nxlAE45KOzf41Ue8MDS2cxswM+q6z8VxGUsMPoiJkC1+XdJ?=
 =?iso-8859-1?Q?8A/C4PRiAPJvBwFSdviQGzSwk9SirDFskTlW/Rj3gPngXvBUdqiDDG+iQC?=
 =?iso-8859-1?Q?cRBEF47fE0Qh4b8LIfmLeQqHwd3qu9+G8uFHJSQizqosfIY9DyIbK20u5L?=
 =?iso-8859-1?Q?z8h+B7jY19cRWvr74R9sSaecOh3wBzm8rcubfQeg5L3pReLDParjC+O8ds?=
 =?iso-8859-1?Q?TqQe6tBJU2I7Yp2AMsVIB2pu0R7AeO+edQN3bChBv63JqW4453KUadkHOE?=
 =?iso-8859-1?Q?C5I5LsWWqH9h10koP+lep6F+jVj6sLNu/xlKOI3cj0RTJ5wLCpW4Vsm0Pn?=
 =?iso-8859-1?Q?JcF0xGMrFLMO3pqGnL32AgN8LF31byOGpIg7lUT2lv/T2aRJCvXG83MBPv?=
 =?iso-8859-1?Q?45kGX7jZe1nO5vt6Mpy5J4hcAjMlhcpMuHAPhCYBcd+wNfeaAq+qlCecw3?=
 =?iso-8859-1?Q?HLjzF7R/RafE46y77ZVBn75Lti176miGYUQ2+ZNxKPL0BzBGXM5Tph+xMf?=
 =?iso-8859-1?Q?MigQe4Jfph3to7r5HrdE3VR2kkJo3ZAvku2dQfneiQop++SxBpSq68nNJE?=
 =?iso-8859-1?Q?LfiXQ1TzSZryJmXSXf0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e30368-5442-41c4-e844-08de00cfc6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:49:12.7453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7IwB8+yN6uH1bUmjJhke0yWsLGyIEnAoRSQG0ZP1ML+/CEJ5Mu/dqMXp0VMvygae6tBgoeu1KcBJH9GXHTm0YGMr+NdTIaSb+nXffbuH5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7820
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Add RISC-V implementation of the Cluster Power Controller (CPC) device.
It is based on the existing MIPS CPC implementations but adapted for
RISC-V systems.

The CPC device manages power control for CPU clusters in RISC-V
systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig             |   4 +
 hw/misc/meson.build         |   1 +
 hw/misc/riscv_cpc.c         | 265 ++++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cpc.h |  64 +++++++++
 4 files changed, 334 insertions(+)
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 include/hw/misc/riscv_cpc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 222efb12fb..2b308ec9b0 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -124,11 +124,15 @@ config MIPS_ITU
 config RISCV_MIPS_CMGCR
     bool
=20
+config RISCV_MIPS_CPC
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_MIPS_CMGCR
+    select RISCV_MIPS_CPC
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 489f0f3319..32b878e035 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -158,6 +158,7 @@ specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files=
('mips_cmgcr.c', 'mips_cp
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmg=
cr.c'))
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CPC', if_true: files('riscv_cpc.c=
'))
=20
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
new file mode 100644
index 0000000000..344f855847
--- /dev/null
+++ b/hw/misc/riscv_cpc.c
@@ -0,0 +1,265 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/resettable.h"
+
+static inline uint64_t cpc_vp_run_mask(RISCVCPCState *cpc)
+{
+    return MAKE_64BIT_MASK(0, cpc->num_vp);
+}
+
+static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    RISCVCPCState *cpc =3D (RISCVCPCState *) data.host_ptr;
+    int i;
+
+    cpu_reset(cs);
+    cs->halted =3D 0;
+
+    /* Find this CPU's index in the CPC's CPU array */
+    for (i =3D 0; i < cpc->num_vp; i++) {
+        if (cpc->cpus[i] =3D=3D cs) {
+            cpc->vps_running_mask |=3D BIT_ULL(i);
+            break;
+        }
+    }
+}
+
+static void cpc_run_vp(RISCVCPCState *cpc, uint64_t vps_run_mask)
+{
+    int vp;
+
+    for (vp =3D 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs =3D cpc->cpus[vp];
+
+        if (!extract64(vps_run_mask, vp, 1)) {
+            continue;
+        }
+
+        if (extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        /*
+         * To avoid racing with a CPU we are just kicking off.
+         * We do the final bit of preparation for the work in
+         * the target CPUs context.
+         */
+        async_safe_run_on_cpu(cs, riscv_cpu_reset_async_work,
+                              RUN_ON_CPU_HOST_PTR(cpc));
+    }
+}
+
+static void cpc_stop_vp(RISCVCPCState *cpc, uint64_t vps_stop_mask)
+{
+    int vp;
+
+    for (vp =3D 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs =3D cpc->cpus[vp];
+
+        if (!extract64(vps_stop_mask, vp, 1)) {
+            continue;
+        }
+
+        if (!extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+        cpc->vps_running_mask &=3D ~BIT_ULL(vp);
+    }
+}
+
+static void cpc_write(void *opaque, hwaddr offset, uint64_t data,
+                      unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int cpu_index, c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        cpu_index =3D c * s->num_hart +
+                    s->cluster_id * s->num_core * s->num_hart;
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_VP_RUN_OFS + c * CPC_CORE_REG_STRIDE) {
+            cpc_run_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_VP_STOP_OFS + c * CPC_CORE_REG_STRIDE) {
+            cpc_stop_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+    }
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        break;
+    }
+
+    return;
+}
+
+static uint64_t cpc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_STAT_CONF_OFS + c * CPC_CORE_REG_STRIDE)=
 {
+            /* Return the state as U6. */
+            return CPC_Cx_STAT_CONF_SEQ_STATE_U6;
+        }
+    }
+
+    switch (offset) {
+    case CPC_CM_STAT_CONF_OFS:
+        return CPC_Cx_STAT_CONF_SEQ_STATE_U5;
+    case CPC_MTIME_REG_OFS:
+        return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
+                        NANOSECONDS_PER_SECOND);
+        return 0;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        return 0;
+    }
+}
+
+static const MemoryRegionOps cpc_ops =3D {
+    .read =3D cpc_read,
+    .write =3D cpc_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 8,
+    },
+};
+
+static void riscv_cpc_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+    int i;
+
+    memory_region_init_io(&s->mr, OBJECT(s), &cpc_ops, s, "xmips-cpc",
+                          CPC_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->mr);
+
+    /* Allocate CPU array */
+    s->cpus =3D g_new0(CPUState *, CPC_MAX_VPS);
+
+    /* Create link properties for each possible CPU slot */
+    for (i =3D 0; i < CPC_MAX_VPS; i++) {
+        char *propname =3D g_strdup_printf("cpu[%d]", i);
+        object_property_add_link(obj, propname, TYPE_CPU,
+                                 (Object **)&s->cpus[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+        g_free(propname);
+    }
+}
+
+static void riscv_cpc_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPCState *s =3D RISCV_CPC(dev);
+    int i;
+
+    if (s->vps_start_running_mask & ~cpc_vp_run_mask(s)) {
+        error_setg(errp,
+                   "incorrect vps-start-running-mask 0x%" PRIx64
+                   " for num_vp =3D %d",
+                   s->vps_start_running_mask, s->num_vp);
+        return;
+    }
+
+    /* Verify that required CPUs have been linked */
+    for (i =3D 0; i < s->num_vp; i++) {
+        if (!s->cpus[i]) {
+            error_setg(errp, "CPU %d has not been linked", i);
+            return;
+        }
+    }
+}
+
+static void riscv_cpc_reset_hold(Object *obj, ResetType type)
+{
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+
+    /* Reflect the fact that all VPs are halted on reset */
+    s->vps_running_mask =3D 0;
+
+    /* Put selected VPs into run state */
+    cpc_run_vp(s, s->vps_start_running_mask);
+}
+
+static const VMStateDescription vmstate_riscv_cpc =3D {
+    .name =3D "xmips-cpc",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(vps_running_mask, RISCVCPCState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_cpc_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVCPCState, cluster_id, 0x0),
+    DEFINE_PROP_UINT32("num-vp", RISCVCPCState, num_vp, 0x1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPCState, num_hart, 0x1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPCState, num_core, 0x1),
+    DEFINE_PROP_UINT64("vps-start-running-mask", RISCVCPCState,
+                       vps_start_running_mask, 0x1),
+};
+
+static void riscv_cpc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    dc->realize =3D riscv_cpc_realize;
+    rc->phases.hold =3D riscv_cpc_reset_hold;
+    dc->vmsd =3D &vmstate_riscv_cpc;
+    device_class_set_props(dc, riscv_cpc_properties);
+    dc->user_creatable =3D false;
+}
+
+static const TypeInfo riscv_cpc_info =3D {
+    .name          =3D TYPE_RISCV_CPC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPCState),
+    .instance_init =3D riscv_cpc_init,
+    .class_init    =3D riscv_cpc_class_init,
+};
+
+static void riscv_cpc_register_types(void)
+{
+    type_register_static(&riscv_cpc_info);
+}
+
+type_init(riscv_cpc_register_types)
diff --git a/include/hw/misc/riscv_cpc.h b/include/hw/misc/riscv_cpc.h
new file mode 100644
index 0000000000..713455eb83
--- /dev/null
+++ b/include/hw/misc/riscv_cpc.h
@@ -0,0 +1,64 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CPC_H
+#define RISCV_CPC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define CPC_ADDRSPACE_SZ    0x6000
+
+/* CPC global register offsets relative to base address */
+#define CPC_MTIME_REG_OFS   0x50
+
+#define CPC_CM_STAT_CONF_OFS   0x1008
+
+/* CPC blocks offsets relative to base address */
+#define CPC_CL_BASE_OFS     0x2000
+#define CPC_CORE_REG_STRIDE 0x100 /* Stride between core-specific register=
s */
+
+/* CPC register offsets relative to block offsets */
+#define CPC_STAT_CONF_OFS   0x08
+#define CPC_VP_STOP_OFS     0x20
+#define CPC_VP_RUN_OFS      0x28
+#define CPC_VP_RUNNING_OFS  0x30
+
+#define SEQ_STATE_BIT       19
+#define SEQ_STATE_U5        0x6
+#define SEQ_STATE_U6        0x7
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U5      (SEQ_STATE_U5 << SEQ_STATE_BIT)
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U6      (SEQ_STATE_U6 << SEQ_STATE_BIT)
+
+#define TYPE_RISCV_CPC "xmips-cpc"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPCState, RISCV_CPC)
+
+typedef struct RISCVCPCState {
+    SysBusDevice parent_obj;
+
+    uint32_t cluster_id;
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    /* VPs running from restart mask */
+    uint64_t vps_start_running_mask;
+
+    MemoryRegion mr;
+    /* Indicates which VPs are in the run state mask */
+    uint64_t vps_running_mask;
+
+    /* Array of CPUs managed by this CPC */
+    CPUState **cpus;
+} RISCVCPCState;
+
+#define CPC_MAX_VPS 64  /* Maximum number of VPs supported */
+
+#endif /* RISCV_CPC_H */
--=20
2.34.1

