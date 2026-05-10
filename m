Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EA7CD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAxA-0005EC-Ng; Sun, 10 May 2026 16:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAx7-0005C3-Sb
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:41 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAx6-00049A-E6
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:41 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-479e4835e26so2198599b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445639; x=1779050439; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hJekX8dH52yMvYykB5HOFELCbhNNSoNRaiTZ7e0Y8tM=;
 b=AvbdQlXTOx/UPawMnEamGnYWmZ8cPxCefEAPIPSwugKtHjjRaiyEkIs9Pxa68Awt1k
 EtQLeMYsQkKd+6s6LTfevjjgDNMcvoJE5QzDZGKZVM+BMQOr7QXCLRnUv+E2LF4jeEIz
 vmVGRocaJVoN65xBKAMWVIisI3sznsuJ8yTnqM0yIocXOQKIBJZhxvFyG6KWVyC5eApK
 7FBL+gB58TLqFuXhKsJMGxJnmAUcm3hoyrZctFfnEGTRg/BEINuNVUXGXfkPGqFkezoN
 kFdLCRsUtzHXDQ8ZqGZZ/iDeAZ+rp1AsUxT2B9K7Xg1/Vfr/eRMCjXMMzQKDYNpAiKlC
 sNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445639; x=1779050439;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hJekX8dH52yMvYykB5HOFELCbhNNSoNRaiTZ7e0Y8tM=;
 b=NEDGfH5Y+6PgkHjyLthGndrNb2t+7rM6J4op07Y/zDjg4FffChqmQ0dlZM0Q+HqiUd
 KnW/7VBp2DZmnDfuMbRJe6bIS+4RvA+75jRTbR6/I0LOTsTyWEAXqWshpakzc9hVOusV
 Y4wddscywPsNWlF91qShkYPTEH0pZxcgZEoV5MhnV9JsO6mDOP2d4zTHWMUT7/a4dNFb
 a8aWjtdUlr/YYpelN0cmVsNPafkUEkQoZydCsV13o3M5sfj14ZBTt3s/WySrxdoj/jDP
 UhTDZDF4rn7uwos8C5vmJcMsEpI50U0afVJP/xqZmUoz2F0YdPvgU4VBGOX2OXgqS5ji
 RJKA==
X-Gm-Message-State: AOJu0YyioL/Vor1YGAb6prOke0raoHiV+NOMYUZlcKHb2yH2hu6K76xs
 7Gsp4IQdZ+u4Jw6yjSukk9IIcjVtwSfbQAp0VBu9RlJut9ZrY3qPFDyw
X-Gm-Gg: Acq92OHsvq0DlklSrk2IihJ7rfbQvpfmeksXd69au87rZ8D9ZjJG4jlZbAFiHWDOR0c
 YsHso/ni5G2QGOJjCG4/YWr9SyriKLQS/9Fi4rhDAfjXZMoOi/tPtOaETv+kVhegsvEywAjvl9E
 3x0AHx+XeCvTmde70PWk2yNo9tnhfDcQ4DyfgDkO4Vr7aMMfLR7hbekVP7o5s+edI5Xvz5NRUuX
 kuxuaejfhqGacyy4nTvw7MmslpmBpjgDc2oK8kYhtQjLwMtaQ2ktVoueSbvH1M85DqQO/HQjbp7
 F2+MAnCduf5796tkFicvMWkyDldzGBidsse+WjPLFCrkRoQ0p/NWnDLaBjbeTcIkHonFLGPTzDP
 HkFhkkXHTO+wFlkC/PIwRgsKxYE3kVkqYC6acKZQKmkbfOa/RjabqwhHWO4qpL4PcxxJVxgoJyN
 a5WJJgey9G45LRUsjY43qjhFF5qGTcTr1mlUFmD9q/wECrWsdP33iqFEJfL8CNDwvuRcCWFGxRj
 SxZV6sMn7yRuUdqTCC9HOmnwtelx5Dlb8tA0j4xI8o=
X-Received: by 2002:a05:6808:d52:b0:467:9ca:4b8a with SMTP id
 5614622812f47-4804221828cmr13378633b6e.11.1778445639362; 
 Sun, 10 May 2026 13:40:39 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:40:02 -0600
Subject: [PATCH v5 32/32] target/mips: expose Octeon68XX floating-point support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-32-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x236.google.com
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


