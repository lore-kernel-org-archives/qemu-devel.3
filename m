Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3FBFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUM-0006wF-AG; Mon, 27 Apr 2026 08:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLOA-0008Hg-KO
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO8-0005nU-Nh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:38 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so51142245e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294114; x=1777898914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YYQbiZSahbTQPAFgyLEs1FpETFb2M0uP0kJrECbl7E0=;
 b=nqXbbEEhXAM14WOCh1eS7nANNn24J0Enhi1hjZTxHeXxejFcVmPmWwflx0irCx4Gpi
 wQwDd/7QRwEed9nIuNI2va2fT39i96w6n1O6TR4ZcWA9EmtxC+w8D8Sl5eiwXIK5SYmc
 uWudhuiawZT/uyaYGUvcBi7l2EWNW44gXy1FPKU+C7pWxQCOnCGPbub/O6YpO8D/035h
 a6AChsV9pyuzzuwCxCQ+caFyaRSUlJpbumw8CS+Og4kxNSy/44zbrxmsbicZGgiamHL/
 LhC1v3dEDh8lKFJshRaEyaFX6VRmuT8DwiSRY1NIBp+ET6hnlSCsezjXg7shmv56i3Cx
 4Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294114; x=1777898914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YYQbiZSahbTQPAFgyLEs1FpETFb2M0uP0kJrECbl7E0=;
 b=PMWyMFs74SfL2PMdBii72slkNh/u52q1mjGIbu8uXYDNLj7mEzyXf6zeSlND2RbEem
 EmFkMQrMUfeRyZyS6ToqFJ4qj3EeXyFA3k7TE4//G8Z0YQ3xCZtg+VT9IkvhD941L6fA
 +kq9qqmmIbEies00m1TdU5lMe1BXfSZxLeJWZHfuJOgsmWfkLDTjt4ZxW5f+cDAnw9nI
 PGI2syXB7QhDEbCh5envR6eVOvXhG/AVWqrIRTyl+lX5qpwCL4mDqz9GY8mBSBNIY7y9
 Qv0SCvHtjmOTj9JTurz4ROuQW6lZXpZItpl4qGDyc7lm8qJnakHqnU/yYPLI7OGI+Nhg
 mjWw==
X-Gm-Message-State: AOJu0YxXwX4u4UHTVJyXRcSZegOrbXn7Lf7EC6iPvwojyZpbLhXh1rpG
 hdOVBfGFi2czG2SmmOihqptx8qP2fnSzusvVzyWXPSxyl1sq4CTj96FjJeN9ny9n9hdmHC72Rj+
 6oODA
X-Gm-Gg: AeBDiet8/F5IrL0bSK+ZJLhWhTCjBGUs5QAd6Nn8q+WdrWTjafTWr3QleYT+yL2SQX3
 ToUE0JSWwzOKCmwQ0xGt6J6HV3YTiSxdT/3bjvJfQF90uLIA/rBygLHby8tNrZ6Jap4sScqWcLG
 iL12HM3NYloFLhq1iIGEf19EbgnDbIVI+d9fa8EksASq8XqJQBYe7G2bkFP3THXfgXXWzxs1gwY
 riCmhjqS6IOip1g5pvArH+EomNvjReXqSmOvEMiMar0YWrppUMGNNtGDcFGG3368hrIzzs5teEt
 mpQOxvt3/hpTMQRrYxxNqkSxHJiJay9nbdxz1rPg1S5APMxIYdgB1ckgpENxxJ28qLj/8lVMrqF
 7lJ1QxOLPjuGg/TLC8DDR5dV8z7KT7/Nf6bfHpyNTalGoRt2bTEo8nRIDoGgKkXfGOCK+//rChT
 gPxm5ufkS0r7cosVsxBMpN4j5JPR/qXyMQiAa1D/b6aoo3GDhOZn8xYV+ldvTXDFeLnaPPzOoVe
 UgfcQb6+Bf4BEeH1eoNLayzu6Q80laCtOcomq8Xhw==
X-Received: by 2002:a05:600c:19d3:b0:48a:55ec:c007 with SMTP id
 5b1f17b1804b1-48a55ecc113mr364536255e9.15.1777294114502; 
 Mon, 27 Apr 2026 05:48:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/63] target/arm: use syndrome helpers in merge_syn_data_abort
Date: Mon, 27 Apr 2026 13:47:34 +0100
Message-ID: <20260427124738.966578-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Alex Bennée <alex.bennee@linaro.org>

One more step to removing the old defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-21-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 565954269f..c74d8e785a 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -56,7 +56,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
          */
         assert(!fi->stage2);
         syn = syn_data_abort_vncr(fi->ea, is_write, fsc);
-    } else if (!(template_syn & ARM_EL_ISV) || target_el != 2
+    } else if (!FIELD_EX32(template_syn, DABORT_ISS, ISV) || target_el != 2
         || fi->s1ptw || !fi->stage2) {
         syn = syn_data_abort_no_iss(same_el, 0,
                                     fi->ea, 0, fi->s1ptw, is_write, fsc);
-- 
2.43.0


