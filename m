Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEE5CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDo-0006mD-0N; Tue, 19 May 2026 12:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDi-0006iq-PY
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:03 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDh-0000mW-5W
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:02 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4042fe53946so1434897fac.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207780; x=1779812580; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FO0azwR+GpNVaHd0K7Iv0la3bhCKm2knHJslFgvy2m8=;
 b=bFpvYmHMeEE6WhF8fSnlQ8RjG91jXwAe3qrosXNIhe2r2/5d4DgwB6fOh6L5/hbI5T
 lCkJcBBiKjNpdaiZFpXym7IvAC+rZfAbA1JDx5Hb/cRm/2zRd/NatYMNlOZgM4gp3oOC
 m0MwuFDngWa6lrNG1Ak1G8n/J/4ynv/HxfaO+6PyFhf3CmlS7h+G0/yNtiR6W1Sy5yxw
 z+lf3+7L9/2aboZHWxJX3F0bnXpon9JUl7g7i34ztJ9ogFUVv17GOMLsrtddLMmFglHJ
 A1D1Q66aAJA3aQjUF7ryXBSEvESP5/h6wxn3ro8Z5M88j7/Pne6u0Ebz/vvfwCL1TYVW
 G3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207780; x=1779812580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FO0azwR+GpNVaHd0K7Iv0la3bhCKm2knHJslFgvy2m8=;
 b=VctaoZCicUlIRcIV9vLrfPwRjju5DOkiTEw40GQcjwm+bbJMgWK+Y8kKmAkqCYyzbW
 NkWHPe7nWKZI8L6dtnRGh5FGTFIBBOkG5F+5Jowx1jxaJLpgpQ0ahjAltA8ESgibX2ry
 PRb9QyKdXIsJoh6qfdjdivuMSWjPaxBzAZc4d6vL0mNSMNcs0khPhlEUy7IngJk7rpNf
 GkKC4g0Rk1X86CteQsc3hbJX/H6BFP53Cury8961eURlOj24qIpAAjubp3l0H4eMgKNH
 zyLLOvzUvyFdsQDwmMlM2VYyPtMGCCQmgzB3qrXNK+Xqvs76G4qqTIfpZI3KNID3+oR8
 lmoA==
X-Gm-Message-State: AOJu0YyFYgT3/OWS01HJhC8OZpvxF3w7HIoLlJ1zonBqXgTl94Bi02/H
 6dUANPF7sHNIAgf+RZHV6slrdElvlzJ0S1wvctKUNv88b1O+is6UnkTQ
X-Gm-Gg: Acq92OGc7r5BjA7uWFGKtIVbt1qq/MJn3UUUHqeaCKBpXPylBoCtmqRqj7U8Yba9/kU
 rVfa/bcpvYHHr2uJOqSp44bHgki7RsyK3sdrMGcE6/NYatXGneqpc9IeaaRJbyNRUYHxCdBoXOE
 hQnYlLvSzvPC8O37ffQqrPDSa4PbhSVvS68yOUbKxTg61qFHGdxbbxs7vnQjPmnfs/3sRLejyAq
 qxmYfNtic/dEeKP2pEmLc/9fU/LL6zUwJlEeLI0ZJAbhrVyGBRlrimsdCHTJ4qLpRQ8g8nl0g4u
 oo4COlukKZ60oA7Mu4rBKMy/0IwfM2vdNHcaIRMgB2gvUET6lAY/XQYoBA0/p16tqgI2kLddfCv
 EyzjmxLEPOGaNgaZJbVrDEBgH1c4XaBsKpKweqOSvEcJkuj55iVlroEIR2PRiY5LVjyR2IHFRBD
 w9tI7+fe3lNcOWCQ2O4asrnoLPlbZayyvU4uos94EwHRiXxiqkX2j5UsSvsoB/uyajSyV1AEY9+
 Bh2obXbDRjekeKbO5lniK4tQH43+z7rX2xodoE2Ar9Vpg1CJ0kYMNACu7ht0sZ7TJzVve67giJf
 NyQ=
X-Received: by 2002:a05:6870:c233:b0:42c:711:a235 with SMTP id
 586e51a60fabf-43a2de6d4e8mr12687717fac.35.1779207779960; 
 Tue, 19 May 2026 09:22:59 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:59 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:27 -0600
Subject: [PATCH v9 25/40] target/mips: add Octeon COP2 crypto helper plumbing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-25-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add the Octeon COP2 crypto helper source file and build it with the MIPS
TCG target. The initial file contains the shared selector-window helper
constants and mode setter used by later COP2 engine patches.

Keep these selector constants local to the helper implementation. The
instruction dispatch itself remains fully decoded by decodetree, and
later operation selectors call per-operation helpers rather than a common
selector-dispatch helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split helper plumbing out of the former monolithic COP2 helper patch.
  - Keep shared-window selector arithmetic local to octeon_crypto.c.
---
 target/mips/tcg/meson.build     |  1 +
 target/mips/tcg/octeon_crypto.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index fff9cd6c7f..4ee359874a 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -18,6 +18,7 @@ mips_ss.add(files(
   'lmmi_helper.c',
   'msa_helper.c',
   'msa_translate.c',
+  'octeon_crypto.c',
   'op_helper.c',
   'rel6_translate.c',
   'translate.c',
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
new file mode 100644
index 0000000000..f9b54f7017
--- /dev/null
+++ b/target/mips/tcg/octeon_crypto.c
@@ -0,0 +1,37 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * MIPS Octeon crypto emulation helpers.
+ *
+ * Copyright (c) 2026 James Hilliard
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internal.h"
+#include "exec/helper-proto.h"
+#include "crypto/aes.h"
+#include "crypto/clmul.h"
+#include "crypto/sm4.h"
+#include "qemu/bitops.h"
+#include "qemu/host-utils.h"
+
+/*
+ * The shared HSH/SHA3/SNOW3G/ZUC register window needs selector-position
+ * arithmetic.  Instruction dispatch itself is still fully decoded by
+ * decodetree and calls per-operation helpers.
+ */
+#define OCTEON_HSH_DATW(N)          (0x0240u + (N))
+#define OCTEON_HSH_IVW(N)           (0x0250u + (N))
+#define OCTEON_SHA3_DAT24_SEL       0x0050u
+#define OCTEON_SHA3_DAT15_MT_SEL    0x0051u
+#define OCTEON_SHA3_DAT15_MF_SEL    OCTEON_HSH_DATW(15)
+#define OCTEON_SNOW3G_LFSR(N)       OCTEON_HSH_DATW(N)
+#define OCTEON_SNOW3G_RESULT_SEL    OCTEON_HSH_IVW(0)
+#define OCTEON_SNOW3G_FSM(N)        OCTEON_HSH_IVW(1 + (N))
+
+static inline void octeon_set_shared_mode(MIPSOcteonCryptoState *crypto,
+                                          MIPSOcteonSharedMode mode)
+{
+    crypto->shared_mode = mode;
+}

-- 
2.54.0


