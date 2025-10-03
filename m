Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC17ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dJt-0003qf-Fo; Fri, 03 Oct 2025 06:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dJe-0003pL-7V; Fri, 03 Oct 2025 06:47:11 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dJP-0007P0-Pg; Fri, 03 Oct 2025 06:47:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJqSppW0lYsJxxQEYC8I6HUUTBSHJ1ztSbikJyEspymkvPvcNURLwMi5Ytprn46mSa+MUva9WHt4/eGgKgZtfMGG/c2LWh4sdcd6830YoVMFnkH/fMHSG5zcF5BZqIcBO1IbrG1LXTTiKZEdV/UKZtdm/59jOJX9pA0MuXQ0IqbZZnJ56YaPgAJ4Uj/Ab6iGEmnhGXj4aepY9oktNT+XFr/5ZLfwmNAqJqp0qTtiEY4RuOgKVKtE/lO1dacLisDsjkxvbNkTtNI4Z649PBMcCxSRFn1zQ90pp11zOGXD6IEqCTWUvB0JlOlcTmXBeA3otPxCleKt6rjDenl+lfRVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvWSndUPaVYQQkHsmo+vl8oRxpG9eJoh0LxPt4lJ8ik=;
 b=xTF8J+cFRhK1gX3ikFHMqH94SSt7sRAqC28SK+gVUDX//Phj8wBt+kk7zaBiR7ufWZB6WoL5ELSGhZH8USomSNHGOLPLMc/kHMdbIFvhkv0V/iC7SHk8lGtbxfLWFjObl6YviBILn2B5jVcemB53I0sJyDh+TVkU352gdKHaVMlbFnPKSMium1U18FoIki6LlNc/TM9MUbt08aHH75fpNE8n8mnDY2nnaExymhFBylwaCvkz3KCs3HPbDp4r+CjIGkr9JjvObdeGZBaYmSy8dl7fTZSAKuOhEdwNMytnICRPcvocjrn0yBtvVC772896lOMovG3SsdD5XfTlloXFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvWSndUPaVYQQkHsmo+vl8oRxpG9eJoh0LxPt4lJ8ik=;
 b=SKxCbmwAupR/8Vk3sBeThlE79DfCfSw3ItGyQjob0e1Bb1uwLI78c+0BmD6+/LGydLtqVs6YInTzTfvLetRvAtfjuAVJRF87bDOH4wuhNLcNCY6KirEpadF+Foi70nI/Y3QWpEnDsSQaqp3yN/+mgn11/J1BStFqgxjqWIihWEos/ZSsNqvtuTvYQCDvNYbATPbrXuYxnVxg7wOt8HyLuKXqBUx7Qjrs9WwAJyJGOBZPTsNV4HO18WZvNw14iccxqEcT20VMrtVhKzw6s5e5OR54GtTNRidXDz0XTCzibxPLWpUqw24PjSKUH2vypYzTBrTnVh7EEwxQ3TvYKvXlcg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA2PR09MB7850.eurprd09.prod.outlook.com (2603:10a6:102:418::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 10:45:23 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 10:45:22 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 09/13] hw/misc: Add RISC-V CPC device implementation
Thread-Topic: [PATCH v10 09/13] hw/misc: Add RISC-V CPC device implementation
Thread-Index: AQHcNFLRKSi80ovsGkOL0tndmBoQ4g==
Date: Fri, 3 Oct 2025 10:45:22 +0000
Message-ID: <20251003104443.51501-10-djordje.todorovic@htecgroup.com>
References: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA2PR09MB7850:EE_
x-ms-office365-filtering-correlation-id: e0437d7d-a4cc-40db-2907-08de0269f46a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?UsfucVeerMM8SvmsAHha2Cv6etXeCsEwvVxeh3BmVs6p/tGAWqvTBZr3Zb?=
 =?iso-8859-1?Q?4lShfPXuo8tYLFONEOXhzHLiGa7boJHm28bWRuiBirlfOe3udoIG9Z9VzW?=
 =?iso-8859-1?Q?FIMLNLwD2AE3AwgT0gB94HsLerHzQU67L2n5xeRSskJRmLUioOYXDsM+d5?=
 =?iso-8859-1?Q?RQqDBkiWxkZwT6Gj7/vLFrWPb60uJ/gPQyA8iEB+RF4jkdKs0J1w9qMacR?=
 =?iso-8859-1?Q?fIczBgI4EY87JJ26poCjxbpUuN4ZgWfPcUWarHD9H9+NNAPLw3aHcW6aHy?=
 =?iso-8859-1?Q?Kl60ptEGpW1HiXhs8Z1mtbjz6sU7F8zbNdYZuOthw7qJ3lWcT1I5+VcTrX?=
 =?iso-8859-1?Q?IAgydFfA6k3hOMxBnmxAyoJ+lzLXU/vadE4NrSoAFfmku7U27+4MvpgirU?=
 =?iso-8859-1?Q?G3mZ1R+8pQyLSS1AcDK/wPtcWPNfRvBVWKitCikIvEpOodYh6XjZ5BEK4J?=
 =?iso-8859-1?Q?jY9hTWjP9nsmBW/y++W3uQ9r8WTianEeafn/OUpbazzYue8/IXZjUlvqWn?=
 =?iso-8859-1?Q?4dtTkTVL+EqM1L/QWKbwwYLagggxrbMAsozv3+tkydzaePOi9gY2Bscx9y?=
 =?iso-8859-1?Q?xNDvO4yagdFQAtbZkvBkamMDNFACxOHKkUKed1akj04vS0siD1yneIQ2wu?=
 =?iso-8859-1?Q?M9DXR/Nvln/eQU6BxJ3lYs7WVwEzLHysIjPUkTP8gQa5iaoSMxlFW7NJgn?=
 =?iso-8859-1?Q?dPiyD9aVJs4GKX3zD4Tr8cdugUL3pPKUkjfpbyzKJweqvsGPyBoxjQobLP?=
 =?iso-8859-1?Q?lgJieS3gherhWT1wZKNHJwC94kj4LYRRZ7+BLZAIlxfAa1ORZsA58UP652?=
 =?iso-8859-1?Q?Syn7E6nfUkY0oltK/AyM+GHKtMXL0VZE9mCX0fLt9JsGJcQ/+nVMRrIMJd?=
 =?iso-8859-1?Q?0FETZg1S7eQ0emgWMxwVhkyu0OzZ7Q4wLHA7V820GdM69MS0mYwL/6UXUz?=
 =?iso-8859-1?Q?ojcfdGNyvcRejTezuTUlUtfe6zt0fsQcqd9gOR1zFTCP08I8jiGbiJIvNh?=
 =?iso-8859-1?Q?2QHTMwcAAccqtjf2qko/bG/5OnKhHN4Csmh7eO8hiVEZ7QvlWMPHkRly+a?=
 =?iso-8859-1?Q?EaMBR20VlAn83zm5odRGi1LDDfil0QQ83wq9PumxI17kzeoyGclStL/m5e?=
 =?iso-8859-1?Q?KdUhVP1kHwZn2W5U6rntiLyuq14SMQBxevx+WXhfeFRX1wVksXjY28HDTl?=
 =?iso-8859-1?Q?tWd7/vTsyMdbqB4mANokE84RBQFAsFOrbcaGfB9GL2A8CJVYe7DsK/nHaK?=
 =?iso-8859-1?Q?Z+URz9Ua4nWBny1pdZiJ+uc/yptvmqtxYT1/8u03ZxUOnpbKkfF0yAi5ZL?=
 =?iso-8859-1?Q?lo7zsUWrZx7450TfuzA4PFfVEAEgG8T3ob6Sjj5eOK237A/Sv1OfijfB+O?=
 =?iso-8859-1?Q?4VCdN/Sj3hUZYAAPI3QPVhhdpDrXBFGbSb7bCNkrqakvP4I1VoiCOAaLzw?=
 =?iso-8859-1?Q?x7dl1s+J4rf2fphVnQDcPTTbeg8E6BxbQnswy0Zcgf8bBY0o8ogDLTC4ci?=
 =?iso-8859-1?Q?H7Im8cz4xKYjMLFOi0LtcB9y699yFgF/0NJKta6uGsrQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qeY2gEhmhjiRB148XecoTG2rly0G3KHGeOdGZJ9A0zrr8I7lyWzeDnWHGP?=
 =?iso-8859-1?Q?UeohLM4H+eciNi9qJMC/+6vmBJRG1u8iK2uyDCT1jFk8Vk3Q6Xo0uXIHDL?=
 =?iso-8859-1?Q?0Z5lNfcFTVM25LjrZaSYdigzwuSCFVuJg6PXMIe9PdF9HdripVPs2dmha+?=
 =?iso-8859-1?Q?7L3+tVxaWi2hvKkVQTp1jTmU9EthUTCNTeNdT3yMkZPeyX4S0ono4lz8kK?=
 =?iso-8859-1?Q?gvdn7WTAwVhCw/lIcmjggo+WJ9f6EXkDfrDtb8Gg39PqDLcRdEmFLGtRUu?=
 =?iso-8859-1?Q?kDgWcrsecmWQ9VjNhkVGx418gtxrN3wzf3MPgfoSAtyNG3pDlXnAHpEjI9?=
 =?iso-8859-1?Q?xB0m60uKBmeQWeOwIHfdgFx8Smbq0E33odco8ZgY31dIyeIKKxv3qo2QKN?=
 =?iso-8859-1?Q?somDCOQQWedcVjhddP794yEmdTAqBKBIDFSLM22E5A1mivDrImPteiOkeh?=
 =?iso-8859-1?Q?TkMz6nPfH9FlsiMJF1VSFlFulLPn8vvffjUtpzhzHWzbT1cs+vevBDXWbv?=
 =?iso-8859-1?Q?tZgwfp03MdZvP+4FvHGZ+NLxiOtxWN1vqxpE3hpXacflCl+B18q2atk1mi?=
 =?iso-8859-1?Q?Cqt0WtQs04/bf5u7qTUQ5qpVLVu2Cexydk+E8pCJFDYYVjMc/bqD0jcdHp?=
 =?iso-8859-1?Q?aL0yGnF3uHU/wvbpvatVibADaDXcK0eU0XKns++W9oFQ263vMDczhH52fq?=
 =?iso-8859-1?Q?RvHWq8FA3gwktkz3w86upS1cfQ2FCoHuv2vskVQ4kunHgmMYOS6Bic/mIl?=
 =?iso-8859-1?Q?07dwdAKDlJ6gQR9VQdyRb5W6Eej8dpvEEKPJFki4nD38xZ2FIoEWqKA6ta?=
 =?iso-8859-1?Q?J6T+0AZRzbmg1Oa6lbMbm4RzrjbmVX2ft2IERnpTULG+WKBzfbUtzbifCX?=
 =?iso-8859-1?Q?zkPPW2nXnUJDEiPLEzcuUJ34flYO/phc+VEjIrxtVEo5Lg2sJHIGRGIUhZ?=
 =?iso-8859-1?Q?DzclBmW8+TFag5/OUbTXJiLnHxOQaopPDQQjG7pO1cyGcqtwTKdvJkWDYS?=
 =?iso-8859-1?Q?2lGtfcpkGsyxYzLJ0DALesobAUN2mCOVW7rVOt2xLizUfH3k47xAArn5DZ?=
 =?iso-8859-1?Q?xpm+sUMjMMhlmYG94DRTGIrHrqCmqGsld9Woagn6hkFcZmBAZGwq2atQhu?=
 =?iso-8859-1?Q?Ymh4gjHiJ50Kwcoh11PYjm0HXKZGzKin8EJW/1B9jFJPLOO7X8fseNA8gK?=
 =?iso-8859-1?Q?QRj+LKpJHQTe2iZwtvfjt/vxnotbGkYHtkQY17RiSlWmHpFH2DdlT0n/FM?=
 =?iso-8859-1?Q?mp2nCW+oD5+2N6LUTofUd/URKKkEniIoMKanroIx83m67JVmShUuHQQ+n5?=
 =?iso-8859-1?Q?/t64B4Celyu/W+FcHodzVbsd/Xi5sZgtuKSfX/TGqc5flv1yi4KZgxHh6Z?=
 =?iso-8859-1?Q?dZDPtckdpHNLQFUF1snNtHrCKBE9R7nZWss7GcReBD8UCs0SaY3AJVpqhr?=
 =?iso-8859-1?Q?LmK7/dUpvDOsQQz9vdcmo7PURrJcF+yzdt3PytX6sXGIogmlhC5SOSt4It?=
 =?iso-8859-1?Q?BOrYi94CdcqEMWoClCPyP5bbncPGshwD+6dl6AiRLQjZ+HkZflny8ITCip?=
 =?iso-8859-1?Q?KuB76Wlv2DGhR0ZDU4X2LM4qJwljSct+ER8Nvmr1C9u7pciyuVQG70l47O?=
 =?iso-8859-1?Q?GMQSndW8kCCd8iiRplGIFI1qni7Xvqt9BhZclC5KB955q4dbPBF8Vv3YdS?=
 =?iso-8859-1?Q?oy+OKmAYzGPHZerq/Yk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0437d7d-a4cc-40db-2907-08de0269f46a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:45:22.8402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4q4oCIylvV4qK8fsfuJjm2h3XbS5qSvw7/aF6cq2aYFoNHrZ47DNQbnmUzTKqiXwwR/eR3eavR9tDjQ6IfIkCjZdcxApKBeXRQew43t3jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7850
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

