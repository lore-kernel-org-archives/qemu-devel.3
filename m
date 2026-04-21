Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37120F8FA9E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFEtN-0003uW-8m; Tue, 21 Apr 2026 13:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEtC-0003nd-0u
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:28:01 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEt7-0006il-3W
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:57 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45f053b7b90so2575349b6e.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776792471; x=1777397271; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+e7gZVu3bd1B1TAOHHGq3QFvnnISVO6cYOLHr5lct+Q=;
 b=rRB1NNKX7y4SWJopLWqEdefBDzfKR+biOyj3j/GAHEF3ygsjwgsJx25t7ijFqDI5u4
 FlhMFQ/1lqtAZXmSCrhws8Ul5yfy3Bs3Q4J5siTq+xNd3rXFOZSHTx6HLm+tSGi5tbet
 uYTu/qyFB5TJqXmNlVZ31pkBR2q6qHkXy1FJu7JIVsH8U5x3VL3QISevCUvJTxFpPdB+
 fTpiL/n/JhxyzvLqTUeOam2fu1SJlWnWA1MgEzqR921rRLcqYcaS+BPHNaEmE3SBGBen
 gcbOsWCO7Oup/+eVGCNfK6p1/FiGGX0I7Zyj9RrrJYqN5wKR+BhTSBw0X89zlzr9gTqr
 pPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776792471; x=1777397271;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+e7gZVu3bd1B1TAOHHGq3QFvnnISVO6cYOLHr5lct+Q=;
 b=CNgmlBjYcSgwAsXYqxX+rsDT6cmBF0kZi1zENAhYTLn1uzHW69WEYLJy3XbWVeBwNx
 frLwa0FGdCnu8tX1N6rFnqlTmANQwcez1C6JFzmibKA8Tt+kNXBbXjlZKO+O8lMpgtGy
 kRyoYHmqIG5VLiZGoW+X3Qo8jGiILo1K54IS7isKFg30P3pwJ9MkjIURyV3vQNPx83gl
 q3xWLlPkvUWQMS/1o4el0FvMW/By96Lg6wO4ChHiUyi1FTvrF+aOHBKW9ENl4E5ZqwZX
 JmtDGDVw0F54ziWb0liSg9Fr3gadwkJyuMAmaU7VqrOakRPDcQ1RQX4KI5wXevwMFq6G
 8h1Q==
X-Gm-Message-State: AOJu0YzK/bsFlQ82vAVzfJ8GGWdswtO52J/Us0XfVawYntY/OfJZohPB
 IEafWn1KN1g2X2C/CN857yJnhGb5bFh/hh31NvGU6fJHW9abD6IW7kf1
X-Gm-Gg: AeBDies3O9Gmi2cc3GaqegW4agVMN9TdinynyOxnk7iBGKWhAYo+F1tq4dhfxKMcstQ
 15xxJL8LLHS20VSyNF6pFzmi/DXAAB8I0x4YS4DmB1iwVQPvEQBaX5iZyrp67w68J8Y82kQoR1X
 vcY9IYIvuA5HAR5sTDK+bEH2E63AR1wVK7hXpQgfN0jtX/qPh0m8IrfuAViL9DZJUj709ss+B4N
 l6xaNHHvHOqDaWyFR/VL78xjlqZcDzp51PLC5tFwlNEGYkHRuhj4S1YCDAzAalw9AcGjvVhLXJ2
 AGGSFzzc8MzVRRdLfBt5Yf85iIAZSa3LqzKoFBbKitLjn806shz1yrCXR9QQFAOcs58VRa2zgeg
 Oy8Vpoibw+FlgH5XmGKcWrE2o3E8usqOSuEmG9PN7u6uEJHqDv0Cc1Pb2O+JQkko4oG0To5Xfbh
 uHuZhTP6azU6sFmoiqO6qatLq3ptbjsrGeKuVMN1+snntdi6ysglv26x3GQVVF4lpC+O14hgc3i
 OGA2JLDkZZLEJggwvbE5j/TQC3wRWLNxvXaM8UWSeR8OqzbeZy7sMVhKpwDJ0eNsSkjQsO9l6KZ
 3bOBrw33nu9TQbS5
X-Received: by 2002:a05:6808:1441:b0:474:28c1:4877 with SMTP id
 5614622812f47-4799cae8b90mr10299646b6e.39.1776792471480; 
 Tue, 21 Apr 2026 10:27:51 -0700 (PDT)
Received: from mac.localdomain (97-118-149-104.hlrn.qwest.net.
 [97.118.149.104]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b8fe2c52bsm12209290fac.0.2026.04.21.10.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:27:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 21 Apr 2026 11:27:40 -0600
Subject: [PATCH v2 13/13] target/mips: expose Octeon68XX floating-point support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-mips-octeon-missing-insns-v2-v2-13-a0791df188c9@gmail.com>
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x230.google.com
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

Octeon68XX cores implement CP1. Advertise that in the CPU definition by
setting Config1.FP, enabling the writable Status bits, and providing the
FCR0/FCR31 defaults used by this CPU model.

This lets guests observe the expected floating-point feature bits and
use CP1 with -cpu Octeon68XX.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v1 -> v2:
  - Move this CPU-model correction into a separate final patch.
    (suggested by Philippe Mathieu-Daudé)
---
 target/mips/cpu-defs.c.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index d93b9d341a..6c084fcaea 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -997,7 +997,8 @@ const mips_def_t mips_defs[] =
         .CP0_PRid = 0x000D9100,
         .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
                        (MMU_TYPE_R4000 << CP0C0_MT),
-        .CP0_Config1 = MIPS_CONFIG1 | (0x3F << CP0C1_MMU) |
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) |
+                       (0x3F << CP0C1_MMU) |
                        (1 << CP0C1_IS) | (4 << CP0C1_IL) | (1 << CP0C1_IA) |
                        (1 << CP0C1_DS) | (4 << CP0C1_DL) | (1 << CP0C1_DA) |
                        (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
@@ -1011,7 +1012,12 @@ const mips_def_t mips_defs[] =
         .CP0_PageGrain = (1 << CP0PG_ELPA),
         .SYNCI_Step = 32,
         .CCRes = 2,
-        .CP0_Status_rw_bitmask = 0x12F8FFFF,
+        .CP0_Status_rw_bitmask = 0x36F8FFFF,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_3D) | (1 << FCR0_PS) |
+                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
+                    (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 42,
         .PABITS = 49,
         .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,

-- 
2.53.0


