Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C48C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuOrt-0001TY-L6; Thu, 13 Aug 2026 02:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuOrU-00014v-J3; Thu, 13 Aug 2026 02:24:21 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuOrR-0003Ho-Ix; Thu, 13 Aug 2026 02:24:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqJCHM/jgtqv4b4t1RV7GgoVTGiSok7EZ1tTSg8dUGnQPqbH13ffoZdsImUvVB0rHWbbj0hCeL1m44zni2gSjOtsH0qZmT0AjwwXp4AAHA/arYzaGL9nMeW/WGgUdRz6HqHVxdFrUgM7FdB/FK4elwkwZGagLQ1H+JkDqJQOX0Av/r0CWAj/KH2LRz4nnIH1NtDqZOCydUEbv+S1vdl8rz1bKJm1driTY8VmLCA/wxnUOP4bxoJ/nz/AlNWBD2z09qTxPXW2/DoY8/Q8UzqM/azqgYzTliDHZ9swGA35OO8ezg/qzvWibAVxgMTb8jQhM4U1aAWqnZl8tVAcZVhjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zr2Xo9iGxU9SAVkzciuI2jZwC8ZxJSHMWnSV1iOqJxY=;
 b=wqX7Iuv7OEqRTjwAyhsG+4iB+VBWdw4xRBvUx1kz9c9BS++eXHZBoE+rXLya4XGrn2KORqdIlz3PbgA0+p29O6yYkqWkYM4zJFdODudHl2SfnmkVcTejMZC5A3Q8fNg5BlC0bkwsdLrmMr045pqds3bGt6tNoGQtE2X3q5anI4sjMXeorRtZnvpeOfr0wL96eFxLLAKAGs+ddH1KSO7zh3ckqdRNE0Qe7hJ9tumvvvab3fVV7ikX5I/OXZnkUntugLIVWwe5O+YLLhpfAoGUXYJLFrFkNDbm+SUPEy4YqY6cm3x+yi7R5lCm7tef83vFOD/50zBQlxYyjcNvwra57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zr2Xo9iGxU9SAVkzciuI2jZwC8ZxJSHMWnSV1iOqJxY=;
 b=LFHUUxMll35pyhPuoQnmXvChvVLzjbuKIYY8HFj3oNlNMnHLdFZt/oJ51f98muhUt7oSqOdIDhHB4IwGNkSslW1PZKw7+6LVAbA2CPyb41+1iSOI3SvWrToNID13VmxTKuL4v/amJ6xqeiDiSXI1Md0E4HwYm1P+6W7f8z8Hx2yM4UUqzPtCPZ7trBdX+nsK1/f/cUISXfz0Vje/fyytOzQ3lddT6rndwDETQnGUZwjvduYYzIaEFNgyxdokUm32eyeM45QCGmAHHheFn8fTBpOGmzNs049bj5POEpnLnyI3K3Uu8HUNpuwWv+8DUj7rzk/CINWhj2OEjkJaGdxhKQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU2PPF56FB370CE.apcprd06.prod.outlook.com (2603:1096:d18::496)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 06:24:03 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 06:24:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 1/5] hw/misc/aspeed_acry: Add ASPEED ACRY model
Thread-Topic: [PATCH v1 1/5] hw/misc/aspeed_acry: Add ASPEED ACRY model
Thread-Index: AQHdKuxVQHXfHVUN1k2e0Iz8ybst6g==
Date: Thu, 13 Aug 2026 06:24:02 +0000
Message-ID: <20260813062359.425268-2-jamin_lin@aspeedtech.com>
References: <20260813062359.425268-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260813062359.425268-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU2PPF56FB370CE:EE_
x-ms-office365-filtering-correlation-id: 46a6577a-17c7-4baf-f79a-08def9037828
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|3023799007|56012099006|10067099003|6133799003|921020|18002099003|22082099003;
x-microsoft-antispam-message-info: M2PsIRaZ5bSm4M6EKMc8YFQkrR8Wr9s/a7chl1lAFx3z7WHlNYxtX/Tx3XapJq+7C5Y6dWhpeYcm++DKYHkSzOjdHQJUXH67HKxV9H1GuYzYIrSEQOL3yDZdhz0xU8cOzarW4DJK76lPe4mzRC8I6C5jwV4EAg4VEivT0oF9iKJKdxrtxIkY1XHP0ySxZpdDHA2iYui3W4H8RrFvXi7OnTU2SO5l8DquznNushpDw1mtoYzH8YTzh057nOUPtJaq9nbst56jVJ3WXRypvoe1+9w6pMRO1UapgiO0JUsQFIZluEZo+nUduu0X5EaeLLZC6lZi0lbrC76vsWOuNjrJyifGIyw6QGPHv3r7VPBG4neBjYUmMMhfTcHmrT3GCzyDlbtj+4DE+cyBFrq4aqH3CK+ZiGl49W8rhxQXWwNItmDn/wX3d8oqtbdnmoF6niXLqgrx2l5B0XHk6iUqDo4PSqmNVtMA4lZ7F8nDYM/+UaSe5QCNXLuVptkCLvYZm9sOCxXfzOgVL+eOC0DL7ZV1sICExSlSR4CgeAsB6IEs6SIx6B5p07krC8d/MLIMAjgTEFEc7IwQTzsIjsy89ZWCyzvjJpqJVrEnCXNY848iiisujrZnKMVqs+ukfasA9okhspBbTyHa/auVX3nqvgzxTNJ1Yk1owx/QiWi3jo4/04f9uhRktMcblwysdIWN6j63L5ulnyEU6Hz5xhG80sm2CMi8ooyXvKDXi1LMbIs0/QQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(3023799007)(56012099006)(10067099003)(6133799003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V8YBg70b+LO49bgFfe1V1dV7zGud+LWAFtH/l5IXYOfa1EDqkGkZQMak1c?=
 =?iso-8859-1?Q?KVvo/2/7bhC+pdrWl0AeGQ0me/+6UZyxfQtfGEJ6KiGhyecDz+2nvH2kyG?=
 =?iso-8859-1?Q?dT92Ydi/gyyJhwDW94nd5tKSUaEY1O22YujXrihw55puxenvd1Af2yr2oU?=
 =?iso-8859-1?Q?DPk00KfWPDiFbohc2z3223Osj4YBZWrQrY7T0sfpouqo1JAuC1ZaXqiccR?=
 =?iso-8859-1?Q?OETJGruE8ZXi5aY6dxdLprcL68lgqUspRUEPRBMXUfZlTfbWg7QWjVM6SQ?=
 =?iso-8859-1?Q?hfX7oJ75Xjpsh/HWCU0On75ezpxiKT24nmKM31uU8Ni+oyHiNzr3IfPVMo?=
 =?iso-8859-1?Q?8dpEAnBC83SQAVWCff1TVG2VtThhotKL0UT9iJ9EVkPU98cbBHJ54pbRdl?=
 =?iso-8859-1?Q?ba+gc51NJisOGAVWCQkpdGVKeeAwSWrOlAQw/AHLuQAraGcJHnKeOCjBr0?=
 =?iso-8859-1?Q?geECkm1VHazkKrzNZrnWFvndaQCQ1ZPtGPq5lsa+pJt30QvC+zZwWVgnWz?=
 =?iso-8859-1?Q?G+tn9hkkyIxermqUzwYi9rfqjc8KeUuMTycGg/r7stUcPR/r2eBQ5djDed?=
 =?iso-8859-1?Q?77wHZLS4zxrXOggG5U4KzjE6grAYYFa4eZIyknG+BAG8A6ayesMFu03ncL?=
 =?iso-8859-1?Q?57FH1gHT8M29pY6370S+vD8zz9TCMt8CCQZlLd7XD0qQ39KWM34GshuMA7?=
 =?iso-8859-1?Q?J0ZzJz4fY1Y/rEOHj8aOJGlLLKUiSCysLoKnowKFDsJWoCCE2Fz7928Iiw?=
 =?iso-8859-1?Q?tiqY87dnCGOua4JNkKd8K0Tt9OD30wx9coAUQ1HquYrDae+lk2bc1Mu2Rn?=
 =?iso-8859-1?Q?MCTAU0sfp/gspt55sxBlT4HG3hnzv/Tn1BSwHH555Odfe7im4gu79iMNm0?=
 =?iso-8859-1?Q?ZXLH8h+d7xnWq8UTJva0+5ZGq3rQJ/5CV//6LuQvnf0LPu0mwUon1M33Fg?=
 =?iso-8859-1?Q?FJ8qQlRYrIUNXjpN48kg05UNN86lobyDnXkuuAbmXgp4ChlurmO9EvCNEE?=
 =?iso-8859-1?Q?jr6DY+nv99JSOGeJrhPMYmUFbB0Eod/Adi6gry9F4dcpBAT4pqGZKT/aSa?=
 =?iso-8859-1?Q?WoZUAix4WMjWEW3nzYu/Ohn9Rm9WqUmhzRBjw/RXQZ3qidSYsb7xIdXo7S?=
 =?iso-8859-1?Q?Rdp3DdmdJOEcuNG8ekhEiU+ebSA9jPh92zMbFMDpQPsBphtHsrExI9qrtF?=
 =?iso-8859-1?Q?p6zqdSzTxSo67qwAhqeCB14tRPGmp3SrCcwKY9/cZtW/knGngkPKHodKn3?=
 =?iso-8859-1?Q?76dIbkMiLO7uf9kowkP4XelU1q6XJTBWSMONXtfQ117CqVbvYbK/bscNVP?=
 =?iso-8859-1?Q?ew3BHREyrkrDDDAUwYRbsIIDmKO9AZzoi4PHIFBPSszbRA3p28cNf2XZeT?=
 =?iso-8859-1?Q?oAml4pU/wdADgQpUQr0I5u1WxP56pCa/NIKhPIZDdhHP3d5R3lNjrcj5+4?=
 =?iso-8859-1?Q?Sn8vVECicMiYinVE/HneJi3Vn4DupNwpnDo6/KxTD6ZAoC842LafOnV6ej?=
 =?iso-8859-1?Q?fV9L7T7//q63i0RD9gLu52vjUzi6AS5/GgYGteKBMhoEseNJQBnPRaGhsY?=
 =?iso-8859-1?Q?0kXVtnsljKZHpx3Ge7MwH+mLiAuuFwgsrwMyBX+I9ygsbCCKyHe/ws5B4A?=
 =?iso-8859-1?Q?wm1zQS32HPtlIbHx2i17rKzXQb7DkW7r0DScrkdmVRlnA4VtPgebLy/ELQ?=
 =?iso-8859-1?Q?TjOBMVIR7sq17I6dImi++wBzaaZuA5N9bLtVHT28wtn9LUL4IsmFXqbXgw?=
 =?iso-8859-1?Q?f9ouqMT/g6YJ3cT8k+YuYKdDrwv5jkS1AwTWR6bj7mQU2P4ntE2fLpuoiD?=
 =?iso-8859-1?Q?9dEKUirTuA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GqJYGalsBiykA4BxsPoXhLHMRBfpCN8dXqLDw6MiMYkglbJ96Jjd6+aUO5Gd424shAS89W/AYmtVlA+GqrJ21zwV+JT9wCYuCSLxbGA0vRc4kvdA1l4pKmI/ZnYKRui+D6Vq4hefVQ4vi67rGrltlt5+FAVA5Vh/kS2nzqVA4v3k/MCqMyrBIyVr5XTJBnuPsjU0kAIrv4WOR3jtZCVU/YBuN2NOlvBHHmcD7TNHw4a9SDCXdmGhlpA0DI7D2GH1uZ9ul6TNiwsbbIhXQdP/Hs5ofGWcsc8NiSw8Eouv3hikrVrKB031gsI+wJ0yxjm+OL3ibO/c/1XDAgdmmA2hnQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a6577a-17c7-4baf-f79a-08def9037828
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 06:24:02.3120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kCN6usf0PSw0y+fsvrSh1LIseETrwKbkkMl2SZgTOgYFzuBjnDWyiNM9325ek0An805OK6YxY6ZosohMwq1hwuoyIAg2yB6fW6TiwmsNs+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF56FB370CE
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce a ASPEED ACRY model, which performs RSA modular=0A=
exponentiation. The datasheet documents the engine as=0A=
supporting both RSA and ECDSA, but ECDSA is broken on this=0A=
hardware, so only RSA is modelled.=0A=
=0A=
The engine DMAs its operands (data, exponent, modulus) from a guest=0A=
DRAM buffer and writes the result back into a memory-mapped SRAM=0A=
region. Both regions share the same interleaved byte/dword layout:=0A=
repeating 12-dword blocks of [4 dwords exponent][4 dwords modulus][4=0A=
dwords data], index 0 holding the least-significant word/byte of each=0A=
value.=0A=
=0A=
The engine accesses DRAM by relative offset, so the CPU-visible=0A=
address written to the DMA source register has its top (base) bit=0A=
masked off.=0A=
=0A=
The modular exponentiation itself is delegated to QEMU's generic=0A=
akcipher crypto API (crypto/akcipher.c) using raw (unpadded) RSA,=0A=
matching what the real hardware performs - PKCS1 padding is handled=0A=
by the guest's software crypto stack, not by this engine.=0A=
=0A=
The RSA public-key operand DER encoding needed by that API is built with=0A=
crypto/der.h's generic encoder. Raw (unpadded) RSA is only implemented=0A=
by that API's libgcrypt backend (its nettle backend rejects raw=0A=
padding), so this device needs QEMU built with --enable-gcrypt.=0A=
=0A=
When that support is missing, the engine still completes and raises its=0A=
completion IRQ as real hardware would, but produces an all-zero result=0A=
so that whatever signature check the guest performs on it fails cleanly=0A=
instead of the guest hanging forever waiting for an interrupt that=0A=
would otherwise never come.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_acry.h |  50 ++++=0A=
 hw/misc/aspeed_acry.c         | 447 ++++++++++++++++++++++++++++++++++=0A=
 hw/misc/meson.build           |   1 +=0A=
 hw/misc/trace-events          |   6 +=0A=
 4 files changed, 504 insertions(+)=0A=
 create mode 100644 include/hw/misc/aspeed_acry.h=0A=
 create mode 100644 hw/misc/aspeed_acry.c=0A=
=0A=
diff --git a/include/hw/misc/aspeed_acry.h b/include/hw/misc/aspeed_acry.h=
=0A=
new file mode 100644=0A=
index 0000000000..5af2296830=0A=
--- /dev/null=0A=
+++ b/include/hw/misc/aspeed_acry.h=0A=
@@ -0,0 +1,50 @@=0A=
+/*=0A=
+ * ASPEED ACRY Engine=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef ASPEED_ACRY_H=0A=
+#define ASPEED_ACRY_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+#include "system/memory.h"=0A=
+=0A=
+#define TYPE_ASPEED_ACRY "aspeed.acry"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedACRYState, ASPEED_ACRY)=0A=
+=0A=
+#define ASPEED_ACRY_NR_REGS     (0x400 >> 2)=0A=
+/* Max size of the "data" (message) field within the SRAM buffer. */=0A=
+#define ASPEED_ACRY_DATA_MAX_LEN 0x800=0A=
+#define ASPEED_ACRY_MAX_BITS     4096=0A=
+/* Max exponent/modulus size for a 4096-bit RSA key, in bytes. */=0A=
+#define ASPEED_ACRY_MAX_BYTES    (ASPEED_ACRY_MAX_BITS / 8)=0A=
+=0A=
+struct AspeedACRYState {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    MemoryRegion iomem;=0A=
+    qemu_irq irq;=0A=
+=0A=
+    uint32_t regs[ASPEED_ACRY_NR_REGS];=0A=
+=0A=
+    /*=0A=
+     * Byte-position lookup tables: exp_map[k] / mod_map[k] / data_map[k]=
=0A=
+     * give the offset in the scattered buffer of byte k (k =3D 0 =3D=0A=
+     * least significant) of the exponent / modulus / data.=0A=
+     */=0A=
+    uint32_t exp_map[ASPEED_ACRY_MAX_BYTES];=0A=
+    uint32_t mod_map[ASPEED_ACRY_MAX_BYTES];=0A=
+    uint32_t data_map[ASPEED_ACRY_DATA_MAX_LEN];=0A=
+=0A=
+    MemoryRegion *dram_mr;=0A=
+    AddressSpace dram_as;=0A=
+=0A=
+    MemoryRegion *sram_mr;=0A=
+    AddressSpace sram_as;=0A=
+    uint64_t sram_base;=0A=
+};=0A=
+=0A=
+#endif /* ASPEED_ACRY_H */=0A=
diff --git a/hw/misc/aspeed_acry.c b/hw/misc/aspeed_acry.c=0A=
new file mode 100644=0A=
index 0000000000..53ef68d284=0A=
--- /dev/null=0A=
+++ b/hw/misc/aspeed_acry.c=0A=
@@ -0,0 +1,447 @@=0A=
+/*=0A=
+ * ASPEED ACRY Engine=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * The datasheet documents the ACRY engine as supporting both RSA and=0A=
+ * ECDSA, but ECDSA is broken on this hardware, so only RSA is modelled=0A=
+ * here.=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/cutils.h"=0A=
+#include "qemu/log.h"=0A=
+#include "hw/misc/aspeed_acry.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/irq.h"=0A=
+#include "hw/core/registerfields.h"=0A=
+#include "qapi/error.h"=0A=
+#include "crypto/akcipher.h"=0A=
+#include "crypto/der.h"=0A=
+#include "trace.h"=0A=
+=0A=
+REG32(ACRY_TRIGGER, 0x000)=0A=
+    FIELD(ACRY_TRIGGER, RSA_DMA_DATA, 1, 1)=0A=
+    FIELD(ACRY_TRIGGER, RSA_START, 0, 1)=0A=
+REG32(ACRY_DMA_CMD, 0x048)=0A=
+REG32(ACRY_DMA_SRC, 0x04C)=0A=
+REG32(ACRY_DMA_LEN, 0x050)=0A=
+REG32(ACRY_RSA_KEY_LEN, 0x058)=0A=
+REG32(ACRY_INT_MASK, 0x3F8)=0A=
+    FIELD(ACRY_INT_MASK, RSA_DMA_MASK, 2, 1)=0A=
+    FIELD(ACRY_INT_MASK, RSA_ENG_MASK, 1, 1)=0A=
+REG32(ACRY_STATUS, 0x3FC)=0A=
+    FIELD(ACRY_STATUS, RSA_DMA_DONE, 2, 1)=0A=
+    FIELD(ACRY_STATUS, RSA_ENG_DONE, 1, 1)=0A=
+=0A=
+/*=0A=
+ * Total size of the interleaved SRAM buffer. Data is 4 of every 12=0A=
+ * dwords of a block (see aspeed_acry_init_mapping()), i.e. one third of=
=0A=
+ * the buffer, so the whole buffer is 3x the data region.=0A=
+ */=0A=
+#define ASPEED_ACRY_SRAM_SIZE   (3 * ASPEED_ACRY_DATA_MAX_LEN)=0A=
+=0A=
+static void aspeed_acry_hexdump(const char *desc, const uint8_t *buf,=0A=
+                                size_t size)=0A=
+{=0A=
+    g_autoptr(GString) str =3D g_string_sized_new(64);=0A=
+    size_t len;=0A=
+    size_t i;=0A=
+=0A=
+    for (i =3D 0; i < size; i +=3D len) {=0A=
+        len =3D MIN(16, size - i);=0A=
+        g_string_truncate(str, 0);=0A=
+        qemu_hexdump_line(str, buf + i, len, 1, 4);=0A=
+        trace_aspeed_acry_hexdump(desc, i, str->str);=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The SRAM buffer is a series of 12-dword blocks, each split into=0A=
+ * three 4-dword regions - exp, mod, data:=0A=
+ *=0A=
+ *   dword in block:  0    1    2    3    4    5    6    7    8    9   10 =
  11=0A=
+ *   region:          \---- exp ----/    \---- mod ----/    \---- data ---=
-/=0A=
+ *   lane:            0    1    2    3    0    1    2    3    0    1    2 =
   3=0A=
+ *=0A=
+ * Successive blocks hold the next 4 dwords of each operand, so operand=0A=
+ * dword d is in block (d / 4), lane (d % 4). Dwords are little-endian, so=
=0A=
+ * byte b of the dword at SRAM dword D is at byte D * 4 + b.=0A=
+ *=0A=
+ * exp_map[op_byte] / mod_map[op_byte] / data_map[op_byte] give the buffer=
=0A=
+ * offset of operand byte op_byte (op_byte =3D 0 =3D least significant).=
=0A=
+ */=0A=
+static void aspeed_acry_init_mapping(AspeedACRYState *s)=0A=
+{=0A=
+    int byte_in_dword;=0A=
+    int block_base;=0A=
+    int op_dword;=0A=
+    int op_byte;=0A=
+    int block;=0A=
+    int lane;=0A=
+=0A=
+    for (op_byte =3D 0; op_byte < ASPEED_ACRY_DATA_MAX_LEN; op_byte++) {=
=0A=
+        op_dword =3D op_byte / 4;=0A=
+        byte_in_dword =3D op_byte % 4;=0A=
+        block =3D op_dword / 4;=0A=
+        lane =3D op_dword % 4;=0A=
+        block_base =3D block * 12;=0A=
+=0A=
+        /* exp starts each block; mod is +4 dwords, data +8 dwords. */=0A=
+        s->data_map[op_byte] =3D (block_base + 8 + lane) * 4 + byte_in_dwo=
rd;=0A=
+        if (op_byte < ASPEED_ACRY_MAX_BYTES) {=0A=
+            s->exp_map[op_byte] =3D (block_base + 0 + lane) * 4 + byte_in_=
dword;=0A=
+            s->mod_map[op_byte] =3D (block_base + 4 + lane) * 4 + byte_in_=
dword;=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Read one operand out of the buffer as a big-endian magnitude.=0A=
+ *=0A=
+ * The operand's bytes are scattered through buf: buf[map[k]] is the byte=
=0A=
+ * at significance level k (k =3D 0 is the least significant). Walk from t=
he=0A=
+ * top down, drop leading zero bytes, and write the result most significan=
t=0A=
+ * byte first into out[]. Returns the number of bytes written (the value 0=
=0A=
+ * yields a single 0x00 byte, so always >=3D 1).=0A=
+ */=0A=
+static int aspeed_acry_extract_be(const uint8_t *buf, const uint32_t *map,=
=0A=
+                                  int max_bytes, uint8_t *out)=0A=
+{=0A=
+    int msb;=0A=
+    int len;=0A=
+    int k;=0A=
+=0A=
+    /* Highest significance level holding a non-zero byte (skip leading 0s=
). */=0A=
+    msb =3D max_bytes - 1;=0A=
+    while (msb >=3D 0 && buf[map[msb]] =3D=3D 0) {=0A=
+        msb--;=0A=
+    }=0A=
+=0A=
+    /* All bytes zero: the value is 0. */=0A=
+    if (msb < 0) {=0A=
+        out[0] =3D 0;=0A=
+        return 1;=0A=
+    }=0A=
+=0A=
+    /* Copy most significant byte first: level msb down to level 0. */=0A=
+    len =3D 0;=0A=
+    for (k =3D msb; k >=3D 0; k--) {=0A=
+        out[len++] =3D buf[map[k]];=0A=
+    }=0A=
+=0A=
+    return len;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Return a DER INTEGER body for the unsigned big-endian magnitude 'be'.=
=0A=
+ *=0A=
+ * DER INTEGERs are signed, so if the top byte has bit 7 set the value=0A=
+ * would decode as negative; prepend a 0x00 guard byte in that case.=0A=
+ *=0A=
+ * The padded copy is written into 'pad_buf' (caller-owned, sized len + 1)=
=0A=
+ * rather than a local, because qcrypto_der_encode_int() only stores the=
=0A=
+ * pointer we hand it - the bytes are not copied until=0A=
+ * qcrypto_der_encode_ctx_flush_and_free() - so the body must stay valid=
=0A=
+ * until then. Returns a pointer into 'be' or 'pad_buf' as appropriate,=0A=
+ * with the body length in *body_len.=0A=
+ */=0A=
+static const uint8_t *aspeed_acry_der_uint_body(const uint8_t *be, size_t =
len,=0A=
+                                                uint8_t *pad_buf,=0A=
+                                                size_t *body_len)=0A=
+{=0A=
+    if (be[0] & 0x80) {=0A=
+        pad_buf[0] =3D 0x00;=0A=
+        memcpy(pad_buf + 1, be, len);=0A=
+        *body_len =3D len + 1;=0A=
+        return pad_buf;=0A=
+    }=0A=
+=0A=
+    *body_len =3D len;=0A=
+    return be;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * DER-encode a "RsaPubKey ::=3D SEQUENCE { n INTEGER, e INTEGER }" (see=
=0A=
+ * crypto/rsakey.h), the format expected by qcrypto_akcipher_new(). n and =
e=0A=
+ * are minimal big-endian magnitudes (as produced by=0A=
+ * aspeed_acry_extract_be()); the engine does a raw modexp, so the guest's=
=0A=
+ * exponent is always encoded here as the public 'e'.=0A=
+ */=0A=
+static uint8_t *aspeed_acry_der_encode_pubkey(const uint8_t *n, size_t n_l=
en,=0A=
+                                              const uint8_t *e, size_t e_l=
en,=0A=
+                                              size_t *out_len)=0A=
+{=0A=
+    QCryptoEncodeContext *ctx =3D qcrypto_der_encode_ctx_new();=0A=
+    uint8_t n_pad[ASPEED_ACRY_MAX_BYTES + 1];=0A=
+    uint8_t e_pad[ASPEED_ACRY_MAX_BYTES + 1];=0A=
+    const uint8_t *n_body;=0A=
+    const uint8_t *e_body;=0A=
+    size_t n_body_len;=0A=
+    size_t e_body_len;=0A=
+    uint8_t *buf;=0A=
+=0A=
+    n_body =3D aspeed_acry_der_uint_body(n, n_len, n_pad, &n_body_len);=0A=
+    e_body =3D aspeed_acry_der_uint_body(e, e_len, e_pad, &e_body_len);=0A=
+=0A=
+    qcrypto_der_encode_seq_begin(ctx);=0A=
+    qcrypto_der_encode_int(ctx, n_body, n_body_len);=0A=
+    qcrypto_der_encode_int(ctx, e_body, e_body_len);=0A=
+    qcrypto_der_encode_seq_end(ctx);=0A=
+=0A=
+    *out_len =3D qcrypto_der_encode_ctx_buffer_len(ctx);=0A=
+    buf =3D g_malloc(*out_len);=0A=
+    qcrypto_der_encode_ctx_flush_and_free(ctx, buf);=0A=
+=0A=
+    return buf;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Store the RSA result into the output SRAM, scattered through the data=
=0A=
+ * region via data_map[] (result_be is big-endian; the region above the=0A=
+ * result is zeroed).=0A=
+ *=0A=
+ * data_map[] holds SRAM-relative offsets, but sram_as is an AddressSpace=
=0A=
+ * over the SoC memory, where the SRAM is mapped at sram_base - so the=0A=
+ * absolute address is sram_base + data_map[k].=0A=
+ */=0A=
+static void aspeed_acry_store_result(AspeedACRYState *s,=0A=
+                                     const uint8_t *result_be, int result_=
len)=0A=
+{=0A=
+    uint8_t value;=0A=
+    int src;=0A=
+    int k;=0A=
+=0A=
+    /* result_be is MSB-first, so its last byte is the least significant. =
*/=0A=
+    src =3D result_len - 1;=0A=
+    for (k =3D 0; k < ASPEED_ACRY_DATA_MAX_LEN; k++) {=0A=
+        value =3D 0;=0A=
+        if (src >=3D 0) {=0A=
+            value =3D result_be[src--];=0A=
+        }=0A=
+        address_space_write(&s->sram_as, s->sram_base + s->data_map[k],=0A=
+                            MEMTXATTRS_UNSPECIFIED, &value, 1);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void aspeed_acry_do_rsa(AspeedACRYState *s)=0A=
+{=0A=
+    QCryptoAkCipherOptions opts =3D {=0A=
+        .alg =3D QCRYPTO_AK_CIPHER_ALGO_RSA,=0A=
+        .u.rsa =3D {=0A=
+            .padding_alg =3D QCRYPTO_RSA_PADDING_ALGO_RAW,=0A=
+        },=0A=
+    };=0A=
+    uint8_t result[ASPEED_ACRY_MAX_BYTES] =3D { 0 };=0A=
+    uint64_t src_addr =3D s->regs[R_ACRY_DMA_SRC];=0A=
+    uint8_t buf[ASPEED_ACRY_SRAM_SIZE] =3D { 0 };=0A=
+    uint8_t data[ASPEED_ACRY_DATA_MAX_LEN];=0A=
+    uint32_t len =3D s->regs[R_ACRY_DMA_LEN];=0A=
+    g_autofree uint8_t *der_key =3D NULL;=0A=
+    uint8_t n[ASPEED_ACRY_MAX_BYTES];=0A=
+    uint8_t e[ASPEED_ACRY_MAX_BYTES];=0A=
+    QCryptoAkCipher *cipher =3D NULL;=0A=
+    Error *local_err =3D NULL;=0A=
+    int result_len =3D 0;=0A=
+    size_t der_len;=0A=
+    int data_len;=0A=
+    int n_len;=0A=
+    int e_len;=0A=
+=0A=
+    if (len =3D=3D 0 || len > ASPEED_ACRY_SRAM_SIZE) {=0A=
+        len =3D ASPEED_ACRY_SRAM_SIZE;=0A=
+    }=0A=
+=0A=
+    trace_aspeed_acry_rsa_trigger(src_addr, len);=0A=
+=0A=
+    if (address_space_read(&s->dram_as, src_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
+                           buf, len) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                     "%s: failed to read DMA buffer at 0x%" PRIx64 "\n",=
=0A=
+                     __func__, src_addr);=0A=
+    }=0A=
+=0A=
+    n_len =3D aspeed_acry_extract_be(buf, s->mod_map, ASPEED_ACRY_MAX_BYTE=
S, n);=0A=
+    e_len =3D aspeed_acry_extract_be(buf, s->exp_map, ASPEED_ACRY_MAX_BYTE=
S, e);=0A=
+    data_len =3D aspeed_acry_extract_be(buf, s->data_map,=0A=
+                                      ASPEED_ACRY_DATA_MAX_LEN, data);=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_ACRY_HEXDUMP)) {=0A=
+        aspeed_acry_hexdump("buf", buf, len);=0A=
+        aspeed_acry_hexdump("n", n, n_len);=0A=
+        aspeed_acry_hexdump("e", e, e_len);=0A=
+        aspeed_acry_hexdump("data", data, data_len);=0A=
+    }=0A=
+=0A=
+    if (!qcrypto_akcipher_supports(&opts)) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                     "%s: RSA ModExp not supported by the crypto backend; =
"=0A=
+                     "completing with an invalid result\n", __func__);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    der_key =3D aspeed_acry_der_encode_pubkey(n, n_len, e, e_len, &der_len=
);=0A=
+    cipher =3D qcrypto_akcipher_new(&opts, QCRYPTO_AK_CIPHER_KEY_TYPE_PUBL=
IC,=0A=
+                                  der_key, der_len, &local_err);=0A=
+    if (!cipher) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                     "%s: failed to create RSA cipher: %s\n",=0A=
+                     __func__, error_get_pretty(local_err));=0A=
+        error_free(local_err);=0A=
+    } else {=0A=
+        result_len =3D qcrypto_akcipher_encrypt(cipher, data, data_len,=0A=
+                                              result, sizeof(result),=0A=
+                                              &local_err);=0A=
+        if (result_len < 0) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: RSA modexp failed: %s\n",=
=0A=
+                         __func__, error_get_pretty(local_err));=0A=
+            error_free(local_err);=0A=
+            result_len =3D 0;=0A=
+        }=0A=
+=0A=
+        qcrypto_akcipher_free(cipher);=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_ACRY_HEXDUMP)) {=0A=
+        aspeed_acry_hexdump("result", result, result_len);=0A=
+    }=0A=
+=0A=
+    aspeed_acry_store_result(s, result, result_len);=0A=
+}=0A=
+=0A=
+static uint64_t aspeed_acry_read(void *opaque, hwaddr addr, unsigned int s=
ize)=0A=
+{=0A=
+    AspeedACRYState *s =3D ASPEED_ACRY(opaque);=0A=
+=0A=
+    addr >>=3D 2;=0A=
+=0A=
+    trace_aspeed_acry_read(addr << 2, s->regs[addr]);=0A=
+=0A=
+    return s->regs[addr];=0A=
+}=0A=
+=0A=
+static void aspeed_acry_write(void *opaque, hwaddr addr, uint64_t data,=0A=
+                              unsigned int size)=0A=
+{=0A=
+    AspeedACRYState *s =3D ASPEED_ACRY(opaque);=0A=
+=0A=
+    addr >>=3D 2;=0A=
+=0A=
+    trace_aspeed_acry_write(addr << 2, data);=0A=
+=0A=
+    switch (addr) {=0A=
+    case R_ACRY_DMA_SRC:=0A=
+        /*=0A=
+         * The DMA source register holds a CPU-visible DRAM address (e.g.=
=0A=
+         * 0x8xxxxxxx on AST2600); the engine addresses DRAM from offset 0=
,=0A=
+         * so mask off the top bit to get the DRAM-relative offset.=0A=
+         */=0A=
+        data &=3D 0x7FFFFFFF;=0A=
+        break;=0A=
+    case R_ACRY_STATUS:=0A=
+        data =3D s->regs[R_ACRY_STATUS] & ~data;=0A=
+        if (!(data & (R_ACRY_STATUS_RSA_ENG_DONE_MASK |=0A=
+                      R_ACRY_STATUS_RSA_DMA_DONE_MASK))) {=0A=
+            qemu_irq_lower(s->irq);=0A=
+        }=0A=
+        break;=0A=
+    case R_ACRY_TRIGGER:=0A=
+        if (FIELD_EX32(data, ACRY_TRIGGER, RSA_START)) {=0A=
+            aspeed_acry_do_rsa(s);=0A=
+=0A=
+            s->regs[R_ACRY_STATUS] |=3D R_ACRY_STATUS_RSA_ENG_DONE_MASK |=
=0A=
+                                      R_ACRY_STATUS_RSA_DMA_DONE_MASK;=0A=
+            if (s->regs[R_ACRY_INT_MASK] &=0A=
+                (R_ACRY_INT_MASK_RSA_ENG_MASK_MASK |=0A=
+                 R_ACRY_INT_MASK_RSA_DMA_MASK_MASK)) {=0A=
+                qemu_irq_raise(s->irq);=0A=
+            }=0A=
+        }=0A=
+        break;=0A=
+    default:=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    s->regs[addr] =3D data;=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_acry_ops =3D {=0A=
+    .read =3D aspeed_acry_read,=0A=
+    .write =3D aspeed_acry_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
+static void aspeed_acry_reset_hold(Object *obj, ResetType type)=0A=
+{=0A=
+    AspeedACRYState *s =3D ASPEED_ACRY(obj);=0A=
+=0A=
+    memset(s->regs, 0, sizeof(s->regs));=0A=
+}=0A=
+=0A=
+static void aspeed_acry_instance_init(Object *obj)=0A=
+{=0A=
+    AspeedACRYState *s =3D ASPEED_ACRY(obj);=0A=
+=0A=
+    aspeed_acry_init_mapping(s);=0A=
+}=0A=
+=0A=
+static void aspeed_acry_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
+    AspeedACRYState *s =3D ASPEED_ACRY(dev);=0A=
+=0A=
+    sysbus_init_irq(sbd, &s->irq);=0A=
+=0A=
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_acry_ops, s,=0A=
+                          TYPE_ASPEED_ACRY, ASPEED_ACRY_NR_REGS << 2);=0A=
+    sysbus_init_mmio(sbd, &s->iomem);=0A=
+=0A=
+    if (!s->dram_mr) {=0A=
+        error_setg(errp, TYPE_ASPEED_ACRY ": 'dram' link not set");=0A=
+        return;=0A=
+    }=0A=
+    address_space_init(&s->dram_as, s->dram_mr, "dram");=0A=
+=0A=
+    if (!s->sram_mr) {=0A=
+        error_setg(errp, TYPE_ASPEED_ACRY ": 'sram' link not set");=0A=
+        return;=0A=
+    }=0A=
+    address_space_init(&s->sram_as, s->sram_mr, "sram");=0A=
+}=0A=
+=0A=
+static const Property aspeed_acry_properties[] =3D {=0A=
+    DEFINE_PROP_LINK("dram", AspeedACRYState, dram_mr,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
+    DEFINE_PROP_LINK("sram", AspeedACRYState, sram_mr,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
+    DEFINE_PROP_UINT64("sram-base", AspeedACRYState, sram_base, 0),=0A=
+};=0A=
+=0A=
+static void aspeed_acry_class_init(ObjectClass *klass, const void *data)=
=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED ACRY Engine";=0A=
+    dc->realize =3D aspeed_acry_realize;=0A=
+    rc->phases.hold =3D aspeed_acry_reset_hold;=0A=
+    device_class_set_props(dc, aspeed_acry_properties);=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_acry_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_ACRY,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedACRYState),=0A=
+        .instance_init =3D aspeed_acry_instance_init,=0A=
+        .class_init =3D aspeed_acry_class_init,=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(aspeed_acry_types)=0A=
diff --git a/hw/misc/meson.build b/hw/misc/meson.build=0A=
index e86d9ad6b3..3912dc2bce 100644=0A=
--- a/hw/misc/meson.build=0A=
+++ b/hw/misc/meson.build=0A=
@@ -137,6 +137,7 @@ system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: file=
s('pvpanic-pci.c'))=0A=
 system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'=
))=0A=
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))=0A=
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
+  'aspeed_acry.c',=0A=
   'aspeed_hace.c',=0A=
   'aspeed_lpc.c',=0A=
   'aspeed_ltpi.c',=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index c9a868b3ef..bbec0d2178 100644=0A=
--- a/hw/misc/trace-events=0A=
+++ b/hw/misc/trace-events=0A=
@@ -331,6 +331,12 @@ aspeed_peci_read(uint64_t offset, uint64_t data) "offs=
et 0x%" PRIx64 " data 0x%"=0A=
 aspeed_peci_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " da=
ta 0x%" PRIx64=0A=
 aspeed_peci_raise_interrupt(uint32_t ctrl, uint32_t status) "ctrl 0x%" PRI=
x32 " status 0x%" PRIx32=0A=
 =0A=
+# aspeed_acry.c=0A=
+aspeed_acry_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " dat=
a 0x%" PRIx64=0A=
+aspeed_acry_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " da=
ta 0x%" PRIx64=0A=
+aspeed_acry_rsa_trigger(uint64_t src_addr, uint32_t len) "src_addr 0x%" PR=
Ix64 " len 0x%" PRIx32=0A=
+aspeed_acry_hexdump(const char *desc, uint32_t offset, const char *s) "%s:=
 0x%08x: %s"=0A=
+=0A=
 # aspeed_hace.c=0A=
 aspeed_hace_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " dat=
a 0x%" PRIx64=0A=
 aspeed_hace_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " da=
ta 0x%" PRIx64=0A=
-- =0A=
2.43.0=0A=

