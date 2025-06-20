Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280E1C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk3c-0000Zz-O2; Fri, 20 Jun 2025 18:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfZt-0007jV-QX
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfZr-0006LT-Si
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d54214adso15790405e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440656; x=1751045456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38zLvQPP5yhI2jJbGMdvWy+zXIo7sTfPVQQWeGTPlg8=;
 b=F8QrcujVVY+zUCqw48vSlJBu4NSRQzvL7pSq6ojJ3K45EowGBYs+DRO0/BdZW6mpc8
 VYn4w82tg+1oRbphev58vROyHn0cMuQ1OkbIjy0s5KCD6HiCczl7SL+ojMjjlXwl67Ao
 Kwt24p8/Zhbj68jGJluBmhQ/xuRCliWznoknhdW9j7d0Z1+TPg9OAkFJO13Ei4OkByW7
 e0kVADamqvoby1ykZd6umpPQXavChUgNaRkJ1SJvl5rZE3JxM1FIoEih4K+UOTCROlL5
 Vb6mj12K8vtNMVDeLuCcab1V1wCJGXn22L942vMMqUCmTMyd9pO01G8l/9r+H6mlurSX
 u4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440656; x=1751045456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38zLvQPP5yhI2jJbGMdvWy+zXIo7sTfPVQQWeGTPlg8=;
 b=P/pdqczsVCTNbO6NIWZqzlYx/QRYC5VFbSDV+cDTDZiX3KK9fYCscZAYOYdY1BKGqc
 XdmMkFWxyysG8s32vpZxRoUnapHQhndE9DgzUGVZy2S76xFEo9Jv8S5+8M4XSJ9sjDkv
 fs/s43WSYVlrAQPRgl5ZwuFekczpY3o19D+yDK89NMACDgZs+Ut5isWcvIHB1o71lFp6
 vfHsExFxDY4/n2P7HXcEClMdtTzz4yFBhADVPeL/08ApEkxX53tuUy7TkQ6ypSU0kX5X
 y1YEy1awBtxL7SEBzou4oRzN2BHQ8bnpB+d/xJkqkXFDaiqNE+Z6t0PQ9+ywuEa4UO7F
 jqnw==
X-Gm-Message-State: AOJu0YyjMkOQlJdn+wr131e7ZxtYHF1KXn13cDh7BbURbaZpMwV+LiPh
 Abvdh8R5AzgURgUdkUmoBMbos2OMI5421isPF+iM1gihxoKG1xF1xVLtWPAXAxmO0Vd/6ulrdqe
 fqEtXElzC+Q==
X-Gm-Gg: ASbGncsb5vlr8540g9xkNxa5uRdTHAqS4pSvb8cw1BKls7xNR18n/RejIeNhk16Cz8p
 9nNjGeFRdxMODuhCxn7SFzfmSEyOfyXQrAOZSWKraohOp3sX+6at0muY75YUOesDuYhGrTVE4i8
 ykjn1U1mxqbpG2VQ7k1AxF+rJyRZI+0b15h4MPoBfjP3rkRpPiQQrmWP0GPZQ2lqqc/L1/aE0j4
 +UVLvgIXxdbzFfIP3ciAWP8v4Ft5575KoIvniRvj+egvsqSTIQfyhQY4MkXC5RxXnSQvgiLThsR
 031OBBhIkL9hokWeH9Q2ctjw63T3HVv4KLvq2SbPGoPm2LYYZxsdqBKS9u6Bn1ExjekU2ELbJ+K
 F3ejjmUksil60ZApUCUFV7+BKpRYL+vrqwl9I1VdkyKen2EoSk9GOBnzc
X-Google-Smtp-Source: AGHT+IEgq1g6KBrHPcr0O8Uw3+rAJ3Q/ygqIRf5ndyuX9fCerZXQ2GdWikmNReQiciY6iuQbE5KjWQ==
X-Received: by 2002:a05:600c:3112:b0:450:6b55:cf91 with SMTP id
 5b1f17b1804b1-453659be4a1mr34436845e9.6.1750440656256; 
 Fri, 20 Jun 2025 10:30:56 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f10411sm2545242f8f.1.2025.06.20.10.30.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:30:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 20/42] accel/split: Implement cpu_common_realize()
Date: Fri, 20 Jun 2025 19:27:28 +0200
Message-ID: <20250620172751.94231-21-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 63b6217f3fa..3278e01f18a 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -15,6 +15,7 @@
 #include "system/cpus.h"
 #include "split-accel.h"
 
+#include "accel/accel-internal.h"
 #include "accel/tcg/tcg-accel-ops-mttcg.h"
 
 static void *split_cpu_thread_routine(void *arg)
@@ -112,7 +113,14 @@ static void split_ops_init(AccelClass *ac)
 
 static bool split_cpu_common_realize(CPUState *cpu, Error **errp)
 {
-    g_assert_not_reached();
+    AccelState *as = current_accel();
+    SplitAccelState *sas = SPLIT_ACCEL(as);
+    bool success = false;
+
+    success |= accel_cpu_realize(sas->sw, cpu, errp);
+    success |= accel_cpu_realize(sas->hw, cpu, errp);
+
+    return success;
 }
 
 static void split_cpu_common_unrealize(CPUState *cpu)
-- 
2.49.0


