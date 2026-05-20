Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF8FCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgW-00014g-6C; Wed, 20 May 2026 00:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgR-00013R-16
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:27 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgM-0003lz-FB
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:26 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so4966897a34.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251840; x=1779856640; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dHHO0+eLtIM55QW60taazGzRUaV2VP4TeBWDtHdLRxw=;
 b=oZyK3SndKZJXyLLj7YYNxQBfycS97kFBbFW2eoSsTYOQpKq0SyuYUyuhMZNnCwYS0Z
 jTR1oE6X20gGUV43FNLI+CYUnqs35Jz0jnvaEI3bNzg94c8FxqvwK3jdFI3c87yzCvRe
 GFjFnKO/wnjTi3xKWPZwiXHufTUinEHPpc83OycOQalqNSNXM4bPuRU2iK5CZHPDytEQ
 q3My8PFwtf4HpLfft4Nvoo7t/nKfcklK+NVjuXSQA49EbFbzKbqA3wcwuwoHc2rE0Fc3
 b4PvtXVqXn98AWUOi1la45a0Ff189szOqeD+pzg4tRMYFWUVl+Z2SrmbcuLVNPNNraJ3
 RnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251840; x=1779856640;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dHHO0+eLtIM55QW60taazGzRUaV2VP4TeBWDtHdLRxw=;
 b=owPfHWeImNMuK0mnnUSbeWVHmSDq+76K5cjoogHIgBwffViTxHiNVyvC2k6KeoFIeI
 NXjQVxtNPZ/KOLsF8wsrzFGqzf5A+hpV+TDxiq1mtaBNj7C3JNJNqzSUDDxU+UqRyOxl
 Bz94VrH/qKvdUF6x1rn/0Nf4C9VuRYZRTsluwQC827MuG3fhvap9V2PAsr0uQpHTo07x
 yxRrbxfZxTcuURqFServwTAVHvCObe9PZMCySm8tjbRIyNv6755iNLsaNzNxTU6vITk0
 nIoyCdCn0EK4GNRgwZ/sDzaAcq3gT4XQSAChm7wopg497nYDvXH2ONHMLiZbX7PTtq1v
 ZRiA==
X-Gm-Message-State: AOJu0Yz8tLvDcAmFbZ+33JMZdo6BbEBBceuB7jKRwKJzhZ7MS4ErOAXT
 IrzwDtsZ5WDJ0B5HNvfT8sUHbdzawNmul9e+9llBpCmk33EjoXWpcVnx
X-Gm-Gg: Acq92OHs89dzHC5QVbzDQD916hBWLdCqEGjKva/hqejkgi6FV8yupTExZ9Egp7jtSkm
 A+aNQ+VHnYFPldRitxu8lmOEkr9XBCwL9KG1XmKIBQFOlGq+J4ZdMcflFMaILDszG1vmjhRFOta
 T6r+aBW55LI77P9I7jQcqzQkdFYuixu/4JjuRiO0s8r0sBH+cukRw6nK0zsgl7Q9t8HFit5Mm1u
 0Zbzct13nR1ZhRIFN7dnCLxDuE/cLvXHE34aQ0wlhVVKfM+HKkT4JBoHHB6nOVGZjmngyzQeTkb
 a1dNkdaED/P5Z3s7BgjV/j8SyDlyAg6XRPiiChHplueI/cKQmjMaZYDx3as/mZJBbAbJIwLcneh
 TzkXVFkUXd6282kxrHjXVwgmMFe4bKQVhmSkvOFNuZyyv4IuAAo38wJquBA/dUyCK2e+W6M783i
 NJ09SS5jqgVvlw8Ojxe/VaKAjNTROID02rEIafCQDRQQ4vAUVWbVy8Oq+bw30mLYN5+xNeFgpCh
 74vFQV9kWQI8cROlTlYG8ziLRU0FppY78Ll43F6qQ6qJkfgvpL6zgLxV1zbA8XN9b/O
X-Received: by 2002:a05:6830:8290:b0:7d7:fd71:f2d4 with SMTP id
 46e09a7af769-7e49a889f33mr13595703a34.3.1779251840607; 
 Tue, 19 May 2026 21:37:20 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:19 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:36:59 -0600
Subject: [PATCH v10 05/45] target/mips: drop Octeon zero-register fast
 paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-5-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32e.google.com
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

EXTS, CINS, and POP route their destination writes through
gen_store_gpr(), which already discards writes to $zero. Remove the
remaining translator fast paths for destination $zero so these Octeon
instructions follow the same shape as BADDU/DMUL and the generic MIPS
translator helpers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Remove the remaining destination $zero fast paths and let
    gen_store_gpr() discard writes to $zero.  (suggested by Richard
    Henderson)
---
 target/mips/tcg/octeon_translate.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 4dd7626835..b7531653e5 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -74,11 +74,6 @@ static bool trans_EXTS(DisasContext *ctx, arg_EXTS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_sextract_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -90,11 +85,6 @@ static bool trans_CINS(DisasContext *ctx, arg_CINS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_deposit_z_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -106,11 +96,6 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
 {
     TCGv_i64 t0;
 
-    if (a->rd == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     if (!a->dw) {

-- 
2.54.0


