Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4CDC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtij-0007bV-8a; Wed, 19 Aug 2026 23:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtid-0007MT-SV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:31 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtib-0003u5-To
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:31 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so1955211a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197528; x=1787802328; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1lmUdEov6FqZsd0VDIKqfsQZY33RKDRt1qK6/MBemXQ=;
 b=MGKwClNbMnv35bO2buxo6/Y/duwDczhdEfP9hQRNkWs8lc8D09iu6oZwtc+KX/zYq3
 HVutP4OKZfjQhrl8aRE+dNmFvKIrVQH3r234sFzUGcRYccOwS+vcaRL1QEVCJ2/FZ8Iq
 lFAaKujtXu1z1fMT0C330XbdpHyWht4rYl+3goflbSz1bhpAN/YNHanRjuBZylUaFTZN
 Fon0FGuMNWffwHAOEOefRxuoElRdQCg73WoSRZto6iMyzsk0MaHoHCbje6ISUVBspZw4
 qCcIyc+5lOVTwC7wSENSJ5RNi7MjsWYlHSG8CTJeWC7V6FcfKPZ8RIEJCsEclKFCJmCH
 fobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197528; x=1787802328;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1lmUdEov6FqZsd0VDIKqfsQZY33RKDRt1qK6/MBemXQ=;
 b=U5BK66tQigE+iVr/pD/UwXUdQgtQoEPbZXOmD6FNYzK/Z/Lmh3l8tWrFETzFXIIevS
 NMocDbdSFmp5N6wmqQeoEfQjtpRmFn6CjMZFpb6njg/Yz5O3oFP+Kxm/QZedvCJoWYwj
 qbqJU4/LKvqgcR2N5fzlWdi/yGy7HVx2VfCoTxt0SpKmRvQSwII6ptH0DpiHVUTLk5O+
 aygQwQXDzrAuch9sSeHjWEtBS6V+cAqNxFwBqSdWscC/gPT6vMUoHWo0PNmRkb3chcVe
 oz4BVmYnpXTBFa69IcpoGkX7EN9VFo5+x8vzqhCY5HzTOXIii6SVKkStCaTz7OmsoFx2
 ATLg==
X-Gm-Message-State: AFuF++nIj9dlcZVoauoSRwfZmnoGWqGMSHovm9gLoYePHZEwffcTAh1+
 K6Q+07ZqSOOK3JhjT/YNBjyus2PQ/M18nnvRkIAx8V0s3dNbVmveRYpROQvegA==
X-Gm-Gg: AR+sD13vxCZKcSrdvDEZ2tktiIRG/sXsC6PiwMovYyi61f2miq3BPRDqZ/OI8lkc+Nt
 O9EvnVnpS/6unW1RgnuLzuWddHcByN2d2sSw2SrDH17onyGWwNNxtk+u9fhQVJC7y2wOlIVQLsi
 zrNDH4aAPVUDbyaq2YCxRc4W1gSLG8cW+A+VDQROXm2+mLXFaRqCqJpC8yKIlfiSspSIqlL84q6
 DzR/EH8uD8SD2kIBQTUE0/NkRR3XA5eTWFJh5ofDxq42XLndDy4x4TX6zrLmv3FTrH3Ndoq13l4
 XsKk3SQJxBucbib40O6HH1Hs5Z0Of9UWq0LhEgXyLA6pMJIbQLELj+j9bH9wmqorR6YXaWFeiYZ
 Nlx5XkKtrQmE3pdqb0AowIaTVgr8ko5vNwDNfpHIsMEfpDjdk5whBb8oCCh3E/BuT1ADdVX4tf8
 bOOgYacVaeBVxFApizdsGpLPAUwyqFd58PQnSvLJqnYwfS3iTMzn/aK4YgnDRCtq8bn7g2/l0vW
 Eo9Dw==
X-Received: by 2002:a17:90b:524e:b0:37f:be6c:f3f2 with SMTP id
 98e67ed59e1d1-39580ecefcbmr16497113a91.2.1787197528352; 
 Wed, 19 Aug 2026 20:45:28 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:45:27 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zeng Chi <zengchi@kylinos.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/93] target/riscv: Fix memory leak in
 riscv_trigger_unrealize()
Date: Thu, 20 Aug 2026 13:43:12 +1000
Message-ID: <20260820034430.1186695-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Zeng Chi <zengchi@kylinos.cn>

In riscv_trigger_unrealize(), the per-trigger QEMUTimer objects are
created in riscv_trigger_realize() using timer_new_ns().  However,
unrealize only calls timer_del() to cancel them, but never frees the
timer objects themselves. This results in a memory leak every time a
CPU instance is unrealized (e.g., during hot-unplug or machine teardown).

Fix it by replacing timer_del() with timer_free(), which internally
cancels the timer and frees its memory.  The separate timer_del() call
is no longer needed.

Fixes: 820552a92e32 ("target/riscv: dynamic alloc of debug trigger arrays")
Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260724063927.3360599-1-zeng_chi911@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 3c0fe70101..5ab29f6945 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -1080,7 +1080,7 @@ void riscv_trigger_unrealize(CPURISCVState *env)
     g_free(env->cpu_watchpoint);
 
     for (int i = 0; i < env->num_triggers; i++) {
-        timer_del(env->itrigger_timer[i]);
+        timer_free(env->itrigger_timer[i]);
     }
     g_free(env->itrigger_timer);
 }
-- 
2.54.0


