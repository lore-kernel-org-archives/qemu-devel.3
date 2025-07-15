Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13014C83F2D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgu9-0006Na-0I; Tue, 15 Jul 2025 10:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgDx-0000Hj-83
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:01:37 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgDq-0004Uk-UT
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:01:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso3643816f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752588087; x=1753192887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYT/ZnvlqheKAHbfOkGEl0z5kGQlPV+Jp/lOOZeieHE=;
 b=TChvmjVMb/1MsB8Qicp08aanf1xCkxJkKcA8w/807ojI2ef0Sz+eGuqBc9fLWbFINY
 MI5IiifiK3C7cVuI6ktnsBaFA2qhBoeXIzHxf0Un2taE7Sp/lHIVrzC//VNfMBxqTmqk
 yV8N3iKDdt6nKuoRaHUfTJoHCg2wh/o/kfQy0h7pgyu2zUG4d9fs3MfCeHbqu14Yxawa
 8xA8+jnT4aAMoKc6zFjpho5Ogde0eWJzkwvT48ao/mnoCQE75FGLXcjoafckhDYK7lRT
 XN/xCXT+11/Z8C04XydWZ925epa3zSN67tfXsFD7Z08xGBrHLgFSlhasaBLm8GIQKM4T
 1Upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752588087; x=1753192887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYT/ZnvlqheKAHbfOkGEl0z5kGQlPV+Jp/lOOZeieHE=;
 b=fpVrGQd1SYSRmatyI9syWnrjlGD7e8wF14kl1iouhW6sS1lhpNjBD8QbSsNzcwLL6E
 Zvr5Vek5RCXYzXNF4qkZAAL+2+SfBBQ+piYNfU4Zj625gTA0pL8UkQmI0L5w064Ry4dK
 88ID35Olz/fh6yxvJRvvEXilpfzyAGHWtamxW27xHUDTcVDAUg1eMSWBgEosPId7uSzU
 jVmpwGSh5oCJlLYcWKZ/LmZpRQY9OkMOCRPl/n35S/ffbtQ3HRW3P+OrjAhdKftqzThx
 pKqQjzj4YtNolilgEiYPbynYufsSo4FmEBbfbNk0avAHKNdmJQLy8d3EBIFC0s0hKEMF
 sdEQ==
X-Gm-Message-State: AOJu0YzqAj4mYuny61oMX8K5V2WxW2OOLISMoJUNoSlW/Xnb3DFkjifA
 4P/+a8iHKUv1Wn36BupyPT+GRFxwWicADMeCeDoYgCgaOy/lUqRQ1k0q8HPUzDU9unzMtvhC117
 q+WuO
X-Gm-Gg: ASbGncvhsV8VnnWM24biYcpRFo/IaKylk7tisu7mG0vLCVOtK0fAkMA3vvCYYylhpWb
 49v2G8eGx3MYZ7WkE96lg/G7ZIiP0HrIPZVpG52uMUb5zFWocNrvL4qMyIY3oubOzlQhjGosqf2
 iw+RKEMNvOc/SHsQcNEuE079a5dpQA5gHWlv5hHCPa9z1P6iZ5trPrFq8RyCGQ2OoOeQxE7Zx0R
 XBFVvmaxx/XuaAFJyaN9wQano1lqVZ3PoU6ibZMdu3nMxcGflPh+tQaPon9RmxU+jd4vrkZsRyH
 J/PL+IniEPb0MOrjLgEHeR5Ayp0MCmWD0+RNAu0+AwOPrnyovfJV/hkPTRbSMTPJSPTxeqfftcO
 0R+ewnXgV62nrVu69RbBjzhEJs+kwy5pqtdHQy6LzswD0lWCst+qI8w2PcFt4bnon316wCe8rw9
 7yNYXZUYo5PXo/
X-Google-Smtp-Source: AGHT+IFR33pWXiHrXRbjchlyYqC2l9AdhZC63xifsKwQh2t5NdPoIAYjLF3ao96WJR4G4z53c4Rb/g==
X-Received: by 2002:a05:6000:2dc7:b0:3a6:e6c3:6d95 with SMTP id
 ffacd0b85a97d-3b5f2e30860mr11781766f8f.41.1752588086382; 
 Tue, 15 Jul 2025 07:01:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1776sm15442302f8f.12.2025.07.15.07.01.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 07:01:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH-for-10.1 v6 6/8] accel/tcg: Implement AccelClass::get_stats()
 handler
Date: Tue, 15 Jul 2025 16:00:46 +0200
Message-ID: <20250715140048.84942-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715140048.84942-1-philmd@linaro.org>
References: <20250715140048.84942-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Factor tcg_get_stats() out of tcg_dump_stats(),
passing the current accelerator argument to match
the AccelClass::get_stats() prototype.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 2 ++
 accel/tcg/tcg-all.c         | 1 +
 accel/tcg/tcg-stats.c       | 9 +++++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 1dbc45dd955..6adfeefe131 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -139,4 +139,6 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
+void tcg_get_stats(AccelState *accel, GString *buf);
+
 #endif
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index eaeb465dfd5..5125e1a4e27 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -243,6 +243,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = tcg_init_machine;
     ac->cpu_common_realize = tcg_exec_realizefn;
     ac->cpu_common_unrealize = tcg_exec_unrealizefn;
+    ac->get_stats = tcg_get_stats;
     ac->allowed = &tcg_allowed;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
 
diff --git a/accel/tcg/tcg-stats.c b/accel/tcg/tcg-stats.c
index e1a1c4cf4ac..ced5dec0c4f 100644
--- a/accel/tcg/tcg-stats.c
+++ b/accel/tcg/tcg-stats.c
@@ -206,9 +206,14 @@ static void dump_exec_info(GString *buf)
     tcg_dump_flush_info(buf);
 }
 
-void tcg_dump_stats(GString *buf)
+void tcg_get_stats(AccelState *accel, GString *buf)
 {
-    dump_accel_info(current_accel(), buf);
+    dump_accel_info(accel, buf);
     dump_exec_info(buf);
     dump_drift_info(buf);
 }
+
+void tcg_dump_stats(GString *buf)
+{
+    tcg_get_stats(current_accel(), buf);
+}
-- 
2.49.0


