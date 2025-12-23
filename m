Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE28AE6F07B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 09:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXyzv-0001Wk-LT; Tue, 23 Dec 2025 04:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzt-0001VD-6v; Tue, 23 Dec 2025 04:48:05 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzr-00026J-9M; Tue, 23 Dec 2025 04:48:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSgrBinOt6f2N/A3wuoJ947gfqsCoO6hgxI1EE9JZnka4C8meLG+wVan6W4RkPr+LfyKtXU8naS6BQg6FIbCknIDD/DjsM7R8Ev4K2Je4hNMbuOReJnMYKlUn+4LwG0R42csXK5LlLnKAt/8zhC0E1LM9SkzwhcEDKEIsXdngcuXKFiZbtiKJ6EbHgAO7/PdFTkIsc1ByqBgmSKDiZYRm4U78TeAI8gLvTaZpbzsGaGG4txUmojmBuxqKLbUN8xH4CradZfYjKc1qGS4M0CkKZ6mVHut/JmHlcv1ogGrXW6GMtiBTsXdrIqKu9J1mUrM3oBmzp/+mVRja5otjNybig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Zu0jOr273zMXUBglERN1RnNHnwSnPKkCc2IDkMc+Qk=;
 b=ylpAuvkBUBZK7EVdlUFvRbYRq10QFger5eQdWwaKX8VWUT3sHH+trt8ZiJ/iEZYbdqhjLLSUqLnQcHqWTdgtNtlTdjxQiO0B5J5zLrFxt7DREcO/Bc5mSX2XnZx+haXnc8dUIfSWhdVxAXM8pNu/N1ldSJUTJcQ/KHK62n3evsSr7A9h2mkhenqt89e9XjUMKCwMPfER1xlmNP7Xt3y4fkRvJstxI2ECg1W3SIyrrG9NC/1Sagk/fYcV8MMClWPMiihY7D9Hnlzg3nz9cfIHtfpPdxR7SbI3M06HLxAFAiv+50mEe0o9BlReYSld+ICW6q15L/ZdvN0vskPpfAhsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Zu0jOr273zMXUBglERN1RnNHnwSnPKkCc2IDkMc+Qk=;
 b=Tnd/vHC4BLvtmuXxwNbk72DfTR147SvOfzzaDNXrd39dtYJ4CYWamsufmBXzoLbBQ8TRNZRdf+cAFNJXWGEDJqUX+Y0JsdkfrSQeM9cZqk+7EDRX3ucOMRz+ByrmCe72OTwqBIDLjo8DsuQC6DTTdNM5DCT6vVeHTtmKmGUIcIT4Ka3guA+GXaTIQc05rA1nuzzaz/GZCO5Bbd9Stb27C+ss/AAKMZ++Y2BP1Ajhmr0pt+Rz8AbgG9q5yUiBKBtvVTo4TMYo5AFQysqdFUfaAswZI5lJGPlLtx68U+nKL+MLxogTnTnZhPQhAMjD/PJRtzCIkIbqr/hfoVOibECvew==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AS8PR09MB5758.eurprd09.prod.outlook.com (2603:10a6:20b:539::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 09:47:56 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 09:47:56 +0000
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
Subject: [PATCH v15 04/12] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v15 04/12] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHcc/E1ze9DrH+hHEaGT0TcjIpIdQ==
Date: Tue, 23 Dec 2025 09:47:53 +0000
Message-ID: <20251223094739.1983381-5-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: e5012ca3-56b9-4ca6-1fae-08de420859ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Ic31ZrtUCGqgynQ+qhrQ6MUYFrcNQQ/VqmOg3HTWZeujSw/1j/JRVXXe63?=
 =?iso-8859-1?Q?hXRLI/USeuIScyriNEa0EeFTjzR8c25Y1wO1/vn7TM989/3eeLc1B0NfO+?=
 =?iso-8859-1?Q?EY+uN67iD1MsXEwvkt1vm81zLKHZl2eXYx6rGXFJ0Ee6k2gN80FPBx/b/u?=
 =?iso-8859-1?Q?i6Y22MlYZjp4t6u7BXntI0ByYd/0K5AjjdHeEmwHSd/4mqpXHhb10TQNGI?=
 =?iso-8859-1?Q?++NB+VE+6bS+Xtm+MUMbSLOmAg/YfpeiRws6js0zSXDWKpspt/RZRaSU3D?=
 =?iso-8859-1?Q?bntR/LF/D43Gu+58YQ5XwtuUBev0ktyVoM1nikrd4j4ma6aOzK60IXi5pu?=
 =?iso-8859-1?Q?UTmsiuBieVBjjKuqkLUoSimQBSu7/3jtOIuFC/GR7VoC+rhygBYBV6NTr0?=
 =?iso-8859-1?Q?vl0U+06jGmsU0g2RJ1JR8kIa6ZtWLUmkxwsrjy+EJt2/rlzbatGjV5ns28?=
 =?iso-8859-1?Q?u6Ynufemp2WPEQ7BJA+rfg9J/yH6YSXBxLzwsk6s0E2AMHNydANQfpoYef?=
 =?iso-8859-1?Q?HQxeA3u45kPJh4nEK/bM3FnHJphE0/DBxR3kdxNLSQpRc17LZ24HT/BjZ0?=
 =?iso-8859-1?Q?Hca1OmtyMlUQWW6y6NX6XYIEbT5eA8OzAjoCHa+mtgzAuVWtdFG7/P1S5Y?=
 =?iso-8859-1?Q?aSs7yto/FxOsJD7VrAh/BMtJ2HAH4E4gg+oRCHVtbmelHfCNzTCY9hYbxy?=
 =?iso-8859-1?Q?SnG3Vp/rp/RWT5idwwH6y8HKFgkeku90F5CoPk/ywFHIcX1KGmcHWcu+/A?=
 =?iso-8859-1?Q?kBlLZaDeot8//E4dQkNGw1TF7EkhxCo22HNZppTB2qQliHLhgI/47OKmjA?=
 =?iso-8859-1?Q?GGwSkVB7kgSy+16M8oInOUo2UQpKT5kEORhA4K5pMhCKUW4OMxoa2ctmu+?=
 =?iso-8859-1?Q?7ilaRmT6AJ0Pc97LNB6lVkxiTfwgR0lG/8dYbdbMYCfbwlwDKqFV+T8XqR?=
 =?iso-8859-1?Q?JyuVut/Uz5NpSkZ8BPhIXjZmnCFGOHdX62Xgi2PGn3uR8tO2xpJ7C+2had?=
 =?iso-8859-1?Q?VQ3NYYsMsNpK0cHq3Ze/IpftRC6EoBupvmitTVexDe+IQRfR/MrR9mwwOe?=
 =?iso-8859-1?Q?N2rcKKF5ZKKoncVXa4AeKfMJ4/HgUDqiyOpXBb7HiDwJdyF+b+WVvUIJ4m?=
 =?iso-8859-1?Q?ohuA/5Tv2PNx8tNlT6sMcOeZwG5HW/cTf5qMV3AJlXBNS+wuWEewT6UzDl?=
 =?iso-8859-1?Q?c8yHQDxmXyXAyUSWr/MOs3iTMf687hXSE5OUj2CUXEvKUNU7/GeEzHGzVk?=
 =?iso-8859-1?Q?BpA6pmGPdhRhoXk6UBvniEZUyNYZK6yr4hWTedyH5RdtcDUFLBPsMPm9jv?=
 =?iso-8859-1?Q?sB5q7yAHxiLHR3L0FQSdS/SQoLEuyLEaSGjMYKzVG6wOWIjQZu1Q9LzEC1?=
 =?iso-8859-1?Q?o7gcdH7uBZi16flbNacPPwLHwYcVG3hfPsYQuvDuuBjQh+IdTgSHEh9N3P?=
 =?iso-8859-1?Q?gI7buIUcz4JVOdFSyk+lNkLNQ4/RhAIq0gnv356QDm/210XPbeEuwwS25V?=
 =?iso-8859-1?Q?l0PWvPic+wMfkPjkji3qVGhqwZc2D0gV6d+SbXxgWb/+avPtl2e9pw8BL0?=
 =?iso-8859-1?Q?Lt7wBpmed914dphoAgz/55owvR3B?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NSkXNdSqovAZb8iWwHePqgI8vraRHmczsvg0FkbYqpT6W2ucDrq9dj3OsH?=
 =?iso-8859-1?Q?Cxt+oBR6udZexNeiByoWkX7b147TNmTbPIKugp/EgivqJt2rOOzLLInhTY?=
 =?iso-8859-1?Q?7nisqz8+91sHnN90Lm86IVYl0HwYSElXaNu4Q7c7zqstmlBiV0ZCgs7zsa?=
 =?iso-8859-1?Q?ePP6XFeuzvfCzx5dTioOfsdbtt/Lvz44w3cJiJ6TJfDVVaUvP0lUQ5mBAa?=
 =?iso-8859-1?Q?FfLhBUi/vIJugvZNv0skkRcF15LwhbsqvSdvPyQHzJqxooLBTujCR19waY?=
 =?iso-8859-1?Q?vA7SBEh7wwtEPe3PrGdoijmmL8gCD4sKs+3xnFbH4vgMeqpmBzCekySd00?=
 =?iso-8859-1?Q?ml99tyWmfxVAWHy3+KBCHBfCiksqVZoZbCwazTL825ZA81rihZBZjNZ/SC?=
 =?iso-8859-1?Q?CosQcg1VqV5LMLjIa2ChBDVKrQtTG3h569E0mQ5SVeSkGMLfWW99mhuLHW?=
 =?iso-8859-1?Q?LEIYrxvbvm+3xjc43Mu/4pSeYwBPee7RN5bRQLBBx73HSJ+FPFwSHi4ygi?=
 =?iso-8859-1?Q?PKw+9nI73/kkGjfxaFxv9x9ve28ayN4KY5qVQgFbgGeRtFDsZQ6C/k9SLr?=
 =?iso-8859-1?Q?87I0zuKTYHRJHnrRDiqUfsSzhMDOQWdT9k4WUVwYdMYSuXigrerK8Qcfte?=
 =?iso-8859-1?Q?wsV4jYN6i+fgswPgigG58Nuy0I6HTkUTeFfNztxQhQFnK9cmMwgU7XjTAh?=
 =?iso-8859-1?Q?2a48rYCjALF5SqDk9+mCCEr5LsfsCW9qtT/37ym4rQzL192vjrHQpeclqq?=
 =?iso-8859-1?Q?xW6F3u+7TGP6mL16SGQpzkpEAx2gSctTyQQfUqwjS/RF0ctxln6EmZIU+e?=
 =?iso-8859-1?Q?D8YKQ5kj5+/eppV5Xbu11MWTCWMLxu25bqkTojd0BTV6vCL3wfwFmZqzeX?=
 =?iso-8859-1?Q?KIqatyuws9ZoWPlH0g1ur3Da/fUxdsiH+DQniJ65zsWfqtTukYy9KnmIp1?=
 =?iso-8859-1?Q?fHK7OwpTZrdCc8oJyVZVY/AjSollGabIeE8OrYDz8fmKEJt2zOWVGhe1tF?=
 =?iso-8859-1?Q?4VabpoaflJ23n2IcoJtNYgQJ2+PFJDWd1It99rOMazdmr6FGfodZ5JBcxM?=
 =?iso-8859-1?Q?lsK/Mn6YpIhucl6JNHv+B2Z8Ojrt6Yp0n26J9d2VD+hv72jaVl75zWVrlX?=
 =?iso-8859-1?Q?L69SZuUhkOFA9//LfuefclFsW1bzV1U6B18lxn25z2Uk4TcnmEXbak0FDM?=
 =?iso-8859-1?Q?SCo9niY3611XHoBIW6reyfJsq2/8otkwV9x2uavrGt5npfU6mx1yPhgbSW?=
 =?iso-8859-1?Q?SISpDe6TN4Y68RGll2T9lvTFTWUo4fw3/oMImTWuQx0d/oBk09Oh3Rp/zo?=
 =?iso-8859-1?Q?qMQnbDhXGvSrtYcdJSAfXNvr13/HiU2c0ZqEjC3oAIxKAf2aOx7/jkwNYs?=
 =?iso-8859-1?Q?/s+USvbr6IdjfpkZ4Xff8vMhaLplSl/RKF7lsCJJjAsRE9Q1Hu6EIX5Yzj?=
 =?iso-8859-1?Q?b2f/vAhMbV4rKVwt9uSp9y2BKjwwhCdvr7PAY49O1sR0rsgg7GETgi930O?=
 =?iso-8859-1?Q?psTvh976qtyn5i1wTeaF/95dY59X5v2KD41Kzs/p4spdmyluO2JDfY8IIN?=
 =?iso-8859-1?Q?HdtQCeyiEoEu/IvLkuDlzZR2tv3/XcdZgdyTW0+tY3VjgMDeR3RBjYgFDG?=
 =?iso-8859-1?Q?rJdMDkZ7IE0wHMEK2aojJuksy10AFG4kn5WykFaYmhzw7in1EHVe35pf1r?=
 =?iso-8859-1?Q?/csJSMdNy40WxsLN47K8jqAridgCwGuM4jR+ndJ5VkkBOqgNxQYJ0ytq6p?=
 =?iso-8859-1?Q?psr53iTUXjsaCkbWCGyygLBKDXCvpl9EdIskc5gDH+/NRbIJuNx+N4s+54?=
 =?iso-8859-1?Q?9Nyh9SEZ4Te9TOWUGmoMmKFwv5KNHcl+gOutfi45Rr4fKmeL01DT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5012ca3-56b9-4ca6-1fae-08de420859ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 09:47:53.7501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVBVO+O03lbqp9xIypcjA/3tOCXHfKZQfoaMldfNLXRq/Lzp+so8dUBR7qnTgeTJ8hkZkglYu2XN1YjzdeGJjTNYe5szi6aT3QpLA0RF77I=
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  5 ++++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 33 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 +++
 target/riscv/xmips.decode                 | 11 ++++++++
 7 files changed, 57 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0c3b8d4f83..7a2170eb02 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -249,6 +249,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1382,6 +1383,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3334,6 +3336,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *c=
fg __attribute__((__unus
     return true;
 }
=20
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index a154ecdc79..e842d46805 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..3202fd9cc0
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,33 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 instructions
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+/* Conditional move by MIPS. */
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero =3D tcg_constant_tl(0);
+    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 25d59ef9f9..3842c7c1a8 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen =3D [
   decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddecod=
e_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddecod=
e_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decod=
e=3Ddecode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddecode=
_xmips'),
 ]
=20
 riscv_ss =3D ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e1f4dc5ffd..53ce86d583 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1210,8 +1210,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
=20
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1227,6 +1229,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)
=20
 const RISCVDecoder decoder_table[] =3D {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..fadcb78470
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
--=20
2.34.1

