Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2414CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa1y-0001Zx-2F; Thu, 14 May 2026 13:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa18-0000tL-MV
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:41 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa11-0004Au-08
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:36 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e36bb16a92so3543406a34.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780309; x=1779385109; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hJekX8dH52yMvYykB5HOFELCbhNNSoNRaiTZ7e0Y8tM=;
 b=kD5BoSfThzy2rE+hNwSevywrZjCYwU1U4B6WYgAlG3/ZChqMOv9jEZQm1Svnev3J3I
 CaGRO+zoEEuc3nf/kuX8xzxsXbYfykVPozFc/kjlYn110n21gFsUZ5WHXXlOhR+nMb7c
 4xOwR6qrhUnxkNsFDf08Osn8fbyr7iugJVzy37TI0vOVUNkVulmGBEOGKvbOwSwE/OAV
 MvjVkmxW/XXOjKN4ITnQ+CzWCz63ZIr0yVmLOjy9norRIk4NvQr9PQopRyE80/J2ar+v
 iuJVPLp9qArbcNScxj9H4b4Mg+FLQ1VK9Lx/CNlOXeFYDvRE6SkJdLohHeTvFVHHf33b
 ji6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780309; x=1779385109;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hJekX8dH52yMvYykB5HOFELCbhNNSoNRaiTZ7e0Y8tM=;
 b=pnu1Gqu/WB4+ncRVucgyA/wEthJ/QdxlWxJWcr9hkF+km26gkPeRJf++SglZGo+AV7
 ooSTsIqQWMSVQjuwZjT4vBfsfhuqndEw8advvU78xYxmn6T7E5ieS+pTuQ3jiXs99Iqo
 lTGzAjTB87Bg9dwz2h6T01Ze8L3knIqUUo3q6cUoWkxx3AgIOxSk6IXV+sHgrnHMSjaN
 I5IEQqk/snlrfBS/rx+GezX9pMhanZL5mIGXVRi2AFC1uWaRTE3sb2QGBOz57lwbUuKj
 6YbZ5ke3TORgqoIuiUnq9ShwzctcYD3gKNZT3hJ3katePsH4+1vGIfzk86Wha76bO3wN
 1BWg==
X-Gm-Message-State: AOJu0YxeCpe9tyycvM7h/yuPw45zv5WTpCGtam2kKKSGvn5xNMbt+DP2
 OiytYSkys/5yvbE2c8q/QuSZwi7vKlA5nxrRYjFBI4pCONVWlivU/olL
X-Gm-Gg: Acq92OHNEcCuXfjPRW+ldQFOQXZVKVdgHPnzufB2iPBgkg+sWth3I65eyfB+cucjmWX
 ksg0FZ4dX5lNZCQ9XvXdQY9W3rc4/UFl5YioIc9ZNaeIo2eWiQvThVgivMFyXb0RZjL9q/QKhzh
 WyJVzCBoVCW7+GYZ3v3qJSj4duOqelshbV2r/NE3hDqEiKMk77Y1qLlVyvRKvfyp0IBkmTdELM+
 o1rOjLry55MAeHaod53opFF0YyBhLW0o53OXscNl1I4gYdaP5+heMyc9wqNhlLBtkhZyml38Jz6
 Pi9331uPvi4eqixWHgJ5dPg9SXJfhZlK98F9T1k1v6uwW6h2qXtv5Atd9Maqna/e0S83KjlSSo2
 DLsPcG6wF65DSEKsA+QZjpdOWrddXMpADn6CSOggdMyERB51I2WOUgl9DY7MjV9CIsn8FJiAIK6
 1yazEAPw/xT86s+ygHie+1FhjN8HcCy63H1ddOfOxG6A0WAmPLhS4hCHc68eJaYmUSMxTGp+qQ9
 yLpCkbYIqIZEF2VTP9z3QdGEUVmEcRRckDmM4Vvn8JhsM3GSMRfezp9Cwd22SVGW/s1
X-Received: by 2002:a4a:e90b:0:b0:696:8c3f:d7f0 with SMTP id
 006d021491bc7-69c94367ae2mr261291eaf.28.1778780309586; 
 Thu, 14 May 2026 10:38:29 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:24 -0600
Subject: [PATCH v7 35/35] target/mips: expose Octeon68XX floating-point support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-35-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index faefab0473..cc1916232f 100644
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
2.54.0


