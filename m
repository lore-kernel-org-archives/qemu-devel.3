Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14251EB1076
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzPj-0003B6-OF; Tue, 10 Mar 2026 11:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPF-0002ru-Qv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPC-0006Wt-TZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so24731235e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773158033; x=1773762833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dqz9NVzSufOWty8PPCEysvgoqR4/ll2kzgD0WQ2e/uc=;
 b=IzMmkb9LJJdwn70PmjXsvNWcQgAACShV7ivv+RhFdOgnZrOpRmMtme2edfSFjxu5kd
 oNzJQD6maB1C08TA1d33gIhzicT3OiBNEa3OnWM4K93yN3/NxyIgWRc8IkA0iS2IBJlS
 3zNtUceiAa/t7m1kS6KkW44WH+Bnejz7AFg1RGDEIjStB5qnRxRObXw0EYz5yQMT2tJD
 BCP7yhukevDC+ocZG0jI6LjJ0yjD8HbKhuwvN75lDTQbdwBId9T2WXQOkkt6Qqa+ggzd
 CfMOFbGwOv4XgrXp6iHLX+ZErtcfRGwb7BoJM+uYz4qxMzgk5odEAzsdzgZrqdw1maLr
 73hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158033; x=1773762833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dqz9NVzSufOWty8PPCEysvgoqR4/ll2kzgD0WQ2e/uc=;
 b=dQyk8l7GVJcC1b5JWF2709cjB4sB7UQoEp1umaBjHHN6zllpzRuXl38QCUh089DpNU
 gF10k+okfSwDhpxJxdgCdretkxB+8ddQBaWPglv/PFlmvyVsvdI+cXpujdzBrXPw3Sow
 SPwAwKXa1iYS1B8FraUH+ovREuH/Xr0flKWAtFeWUuBcQBAnZtxL6py/a9Swjcz39T0A
 XaGlGeakGsuGKA2yd4fiFjmPVfP5YE3OcQ03mFU9MohYlXydeotcqaxnV9VIHbqMZlMT
 vkmSJwq2kGEGFbR7cbJl60il4ueYtGGP1cXNlM7Fse77I3xgLGJD+Hi9AbzVMaXSP06o
 rsYg==
X-Gm-Message-State: AOJu0YxRXLVRtKFHcrtrBzgm+2isZEwsngFylQGeSpJq/433I13eSVYF
 a/wHOmUGBCTX1VY+xVD1X5SIXOk1tVM+OV49TIGPMGUZsEgs5xvqqsqPQAea72tyi2u+W5SyRoC
 jfNuFL5s=
X-Gm-Gg: ATEYQzye9FZSd7iKyR+B4Rt2STRgxPpiQttS4lTGiFzm23JKzprwJRDUkvnJh2FmQty
 SOJIkA8S3nDoQ9Smd24FySsyLbGflTINHsnGpjPz+ZF+jHidtZHofduZe564UyJpfc6SSMbJtQN
 UFxtuxmoPNk1ojI9AS+3+1IhrrocC/MyzqbaALkXiVIairm0KrYYHE/at1b+HRweyEczttqdfpX
 bK6/e/6KI9crwHSWRrXFTcOflxnoF51i+9URwPc00V41RU0qc0dcQxRTyWz2zgAovbqLfUwEgje
 jiSgn47CJrA9cjcGyzKSGSnBgsoci9smVw5JGtavtEjmtxttE8uRhTgoe4X26CDMSisVL2aGFUE
 0hn2vY2Sup0DRWLYPYrSN55fcspNFV1lEkuLYAoi+spZz7i1hH7vhjUEbCK2kr9/d1CZUHIDdxN
 ju/QStTleibBPHF3pes6YHewDodZQrUX6jtSNLkqJ3xGRoFO44tlFEyzFZJn0xBvgxR1r8USlmN
 EF4zE0LUBU=
X-Received: by 2002:a05:600c:1c0d:b0:485:39d4:2dd9 with SMTP id
 5b1f17b1804b1-48539d42ea2mr161159745e9.33.1773158032897; 
 Tue, 10 Mar 2026 08:53:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853a797dbasm86444845e9.7.2026.03.10.08.53.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 08:53:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH v2 03/13] gdbstub: Simplify gdb_init_cpu() logic
Date: Tue, 10 Mar 2026 16:53:19 +0100
Message-ID: <20260310155329.48772-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310155329.48772-1-philmd@linaro.org>
References: <20260310155329.48772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Ensure we either set gdb_num_core_regs or have a XML file.
We shouldn't modify CPUClass content, so mark it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/gdbstub.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 90f4b95135b..139301b485d 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -582,22 +582,21 @@ static const char *gdb_get_core_xml_file(CPUState *cpu)
 
 void gdb_init_cpu(CPUState *cpu)
 {
-    CPUClass *cc = cpu->cc;
+    const CPUClass *cc = cpu->cc;
     const GDBFeature *feature;
     const char *xmlfile = gdb_get_core_xml_file(cpu);
 
     cpu->gdb_regs = g_array_new(false, false, sizeof(GDBRegisterState));
 
     if (xmlfile) {
+        assert(!cc->gdb_num_core_regs);
         feature = gdb_find_static_feature(xmlfile);
         gdb_register_feature(cpu, 0,
                              cc->gdb_read_register, cc->gdb_write_register,
                              feature);
-        assert(!cc->gdb_num_core_regs);
         cpu->gdb_num_regs = cpu->gdb_num_g_regs = feature->num_regs;
-    }
-
-    if (cc->gdb_num_core_regs) {
+    } else {
+        assert(cc->gdb_num_core_regs);
         cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
     }
 }
-- 
2.53.0


