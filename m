Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B615CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYhg-0001yt-OX; Wed, 20 May 2026 00:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYh8-0001K8-5v
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:10 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYh6-0003wW-Ix
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:09 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e55b95ba13so2466929a34.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251887; x=1779856687; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dVH+cwAztnQhZ2QPkS1VR9KOSmfSsS3tCbNpT0hcXEY=;
 b=p3zAxxKTJJAEe2oNmu+pTMF0HNoQjg3Wu30YAMZ0KZzZyXCzI7iDoS9BrY8jBfbaQ4
 u/YMykDUDs1LAUZyHc+td7wdFWgj3zMDCcd31qY41cRg9EhSIUXmDqomJDMzjTYEjlcy
 H6vgMoq+qx3LyIldpgxZeaEB21eyoO6FDaLiu1UDImtAntLWiMZfec3zoFio8Hptvbkt
 uw0aERqms3R4Cizmr//bn/5AZmdU3J1VwNQO3qwv3vLEFwDy1rur9hEn7F6FgjsL6+AF
 4smBJTkevkENt0/ELGETOQhpfZLZWnOnuGgi5Ctxy3VvIT/VfcHlsVUkRtgP56m67X/T
 Ag/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251887; x=1779856687;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dVH+cwAztnQhZ2QPkS1VR9KOSmfSsS3tCbNpT0hcXEY=;
 b=l7JF0J1LOD+q4mKx9zXTlLCuJ+BUjHtyVb2do+2v/6VWUF3HaSw4HK5xWYVZ11afhY
 vLaWeV6iprP3vKUtTxD/kRJgq03jLp2XF8VAjXS3D3I+Yn40zMVitleuX3AGxemS9Ou/
 3xF/6VkdJy5K4ef4W6CYXGY8j77a7RWl8+M6cbYinQCePQNv3lS3p9Nmp4jcPToglJEK
 yN6thuIHJYGmLHc6TTn0HmVFHBHAxRDijlimej8thxo4m7/2559i+qrbLPOBPRW7cXzT
 bfvfzMjTJSs5q8l1PmXCd4l7GAi9wr1scjbCKlpmSLC5DLVRTH05lvFSHhi+MX35LX5l
 Ldow==
X-Gm-Message-State: AOJu0YxCDMLzR5fo0DFiixAePbREpyFpj5wV86/yUVLcVhcKJJifwUlw
 U0eSqtpHDa7DVxPHBMlDtMylBblDqBp7UKGYZfl97b9byra6goqzb2EL
X-Gm-Gg: Acq92OFvT8Ikcd9HG0mwANxPndi6SDoJBwm2i+GojZieldUPNZdGGtB9unLSbbHPydx
 vDdEMZqdk5IFQm09K19NYpk/7OvibuDodvACo+LCWRI21qcyF3sPbxsXkmtugf20E8XXjGQwbx0
 6ggwIeCPj7ClB23f3KPu3m/X3t/5E5Jpfebxvf0CyjFQ5QePBQ1G77TASxz2ZKPn3MlyA8d+RN0
 I4BZ5I0CT9J8eboKpRM0UcusX9zpCL3fYqQum7SgieConOu3gOkcMkUkZfAN0AZ9cV+lnpqKX5F
 CxfLjpYX07dxsQztf+I2QWLIQhAAbgwqJeyKLkfh97Op5hhDz6daOg9C0lDBWpiv/FIJTPb9ETN
 ue/3UgMKYI8GWctFsUhnER4aI+7Isai7pBpvJwPUUj1c1SMq4LE4hmQ5WWYD9V2Beo9QTaJRh9j
 oeTvML/oc/Dbkr/UORlQ6Tygo5QC9wN6FGNfCjU9K88eYl+wGbMoGouywwIOjU22FxXsmimJZi2
 ltkT3Nc59OzcYniQNucTYUTpcV8KfV2+IvcVbqwp4koCveZc5EFzpOrBN7qF/aa7W9H
X-Received: by 2002:a05:6830:6995:b0:7d7:419a:7ac8 with SMTP id
 46e09a7af769-7e4f2b8bdd6mr15174356a34.15.1779251887481; 
 Tue, 19 May 2026 21:38:07 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:38:07 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:39 -0600
Subject: [PATCH v10 45/45] target/mips: expose Octeon68XX floating-point
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-45-306f9edfe15b@gmail.com>
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

Octeon68XX cores implement CP1. Advertise that in the CPU definition by
setting Config1.FP, enabling the writable Status bits, and providing the
FCR0/FCR31 defaults used by this CPU model.

This lets guests observe the expected floating-point feature bits and use
CP1 with -cpu Octeon68XX.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


