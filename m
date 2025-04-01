Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18CEC3601A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWiB-0007RE-Qn; Tue, 01 Apr 2025 04:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhs-00071E-Ip
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhq-0005yb-7M
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so33782275e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495044; x=1744099844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPB58+FTxXSO7a6ABgKbjWcxmkemD1i3O76geVQ4vzw=;
 b=QzvYr6bINhXzOuec6SVvKoZLNjtVGd83cw3TvEDY7voq3lqk+Aj8KtKIF+SNPUS62H
 I14JK1mjln/AuoOp3My9jv9AcUjR65CtNW2ADzGC7kY0ofocxcSckqkYKtXkK6bj0c35
 pXEeGn143KVCbRwpa0CHx2yAZJ9IG2PfluHTBfgapBnnRnBOXlsoUdZFf9elZknUo/7G
 UpxPyIFyYSImzFzxV367XeoHLuUA98XanCnYif2wC/sk7m/Qmu1IIg1TAADe7nyxEwmT
 5rJNlPL5HGFdJ0YwX6GRIhMB3BUezCQataMk6sumic06BkcwINC0YG40fqE2XygTEYAj
 BXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495044; x=1744099844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPB58+FTxXSO7a6ABgKbjWcxmkemD1i3O76geVQ4vzw=;
 b=OygLYcMJq0j6cI8ULFIAIi9ThMEfb/onIiMg0vmarh73FB3hubsMtyA9pV1K5OCC5l
 bygSLy+EV8XW30LxXt/7dt+/CKimccz0KtPo/e6Hy1T8/597mGAeJb2sOJ1CT0U7mKbA
 S0kt8ecaY6f1IOvJ1otefbXRjFVBhEeomLhkZPnj2jW8xYpl/SEqpKnITtRJ2CNvCd7k
 QDuz1mhcEup4QypI4HmmgmkPN2zcpIy32vQLxd+/iO8NnaDxACrzZiMHKeDP6tZpgRS/
 FBdk30m3XTPPeLkVtTyJMy80bPRp6cYQwptDUm20W6TfRsHj5Qjn6k75tZxVT3UBIdia
 /Rww==
X-Gm-Message-State: AOJu0YwwReK3Un0DX7Bn3KdkKETiKDcwhppUdi4dr3TdoP8gjVHfTo7k
 mp7lmcztNv2Iot3X6tBv5v+xRaY97y2o1raQ7U3gAmIw9lYfRQMyOK5MRg5uYQqZ9xn3vc8jTMC
 9
X-Gm-Gg: ASbGncukdVvB2vQA70LOqib+Cp8JtnTcuvzXHGEIfp/t8TWi6fM6tD37kSuTtpHe7aM
 jpeEig/J/cAfGOOS1D7NATNcle8/kiAyoAip0Fi849oyi0W0Z5/YK8kFkVs3EeB6u4ohDn15j7S
 EVC73mnkBUsEEmbDxhZEirEOdPcPi5d9iHVbRcQIJyGjSuUrc+OFxAcnjds1wP7fAaw2xifvpBQ
 rSrJL93ot9mxcrd96rHDHXVOCoUPUrPgK6/DAm+8iE0SXtdkcToVSCObBZ/HTdQ+qPhqz0WRCia
 Vt0RW+jU0u9EC02hZ/YtR38UmYHb5e3cfyAAz6mnV+VBR6xGPLfVT90cWYQ169pHAR8/DzzGm6P
 mpUt7NwdKNavvJzU1if8=
X-Google-Smtp-Source: AGHT+IHrUihJpNMZzlRAmfIkNLbPYF/hT34Rp/pJF4Uv+67icyAVsv3NkskfLOXREzj0KJAHC60a6Q==
X-Received: by 2002:a05:600c:34ce:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-43dabe235b5mr125467395e9.0.1743495044270; 
 Tue, 01 Apr 2025 01:10:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d90000a09sm146854675e9.35.2025.04.01.01.10.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:10:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 13/24] target/mips: Restrict SoftMMU mmu_index() to
 TCG
Date: Tue,  1 Apr 2025 10:09:26 +0200
Message-ID: <20250401080938.32278-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
 target/mips/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 47df563e123..269d3d69bd5 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -554,6 +554,7 @@ static const TCGCPUOps mips_tcg_ops = {
     .translate_code = mips_translate_code,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
+    .mmu_index = mips_cpu_mmu_index,
 
 #if !defined(CONFIG_USER_ONLY)
     .tlb_fill = mips_cpu_tlb_fill,
@@ -581,7 +582,6 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mips_cpu_class_by_name;
-    cc->mmu_index = mips_cpu_mmu_index;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
     cc->get_pc = mips_cpu_get_pc;
-- 
2.47.1


