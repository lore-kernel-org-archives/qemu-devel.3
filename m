Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0430EC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpHW-0001CY-9n; Tue, 13 Feb 2024 04:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHS-0001B5-8B
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:40:46 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHQ-0000Df-3v
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:40:45 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-411c3b299caso1992195e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817242; x=1708422042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OMHh8GGh8vwtiEG6gdakeI1gV4koMSCEXADRE/Fw5g=;
 b=eovAERRD/jRvQYdHC80D8MNEEeM7S/omJM9Lg9Eu4iSrp113B7m0qA458B8Ju53IBd
 uTfds5k5CxzJeREqjnl8xgipkgB1NXYWsY/GLtFb6xZxS10Y2BLh2JkO8Jy9OFbSCtoC
 RF4gJEIKkirrtntDE327DEAVanksZSn/kVu/VbSJJ8yokDOLXbHzzV2IiyF+SpZHm04Q
 9odoRQSZ7AFEyNnLSslRw3GaW61Np8njOc3W2YGkkBQGBdH+1YW8wJ06aNStcvYC6U03
 Zepckxg+Ydv4IWILr9b9AevlLBOJZ7MRl5KkhC9S2nA4H8ziJyYSsbwoMcIWlmGGkffm
 VDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817242; x=1708422042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OMHh8GGh8vwtiEG6gdakeI1gV4koMSCEXADRE/Fw5g=;
 b=EEPRkidUrWA3z0/v3E0HdstarwDBH0ooeoQxSGfJBufAMJMskah7flmUhXyCVG2Jt+
 xE2qjybEuyip60JWVqO0tXhJI4BirZWERXDKbgEnmm5/01ONTh/EQ8mIhcN6XlfIzdyX
 Ae1krW2z9QG60ZtN09k8/RE9OSKeN2EQ7/nN3NFqBB4H83DXZKjlvXNL82cALCH8QDAL
 HDBrm2IXl81tqLU40DZwmOy3ko13RIfxsBhtyhEOirMAOSGKMFUGdLuCUZ6cRXskQ9KF
 TOMswcZsv+O22LLeDxLz04EFSgCrqp6ZQrL33KNvO0+VWf2Bzw3lc4XO9CwQBDVgn08g
 3AHQ==
X-Gm-Message-State: AOJu0Yz2MRBOQwRact8nyhGSFQVhgrqZsZjmRXiUHIjPhtj40pXmn8Rk
 vmwFJgZgeBTIQPGrcjeCyPHGPiw0YIo4fdUvR/0ZbgPz+YOa3Wm/v1F47CNOtVB54sYa7xDRtLV
 y
X-Google-Smtp-Source: AGHT+IHtyVbNm1aNDBJ5/i0rlklFnJVmnI1v8ENqCYdlS0OTC3GMYKjPUvWPfUw0TsDzyD4G4GF6Ow==
X-Received: by 2002:adf:f9cb:0:b0:33b:28e0:e09c with SMTP id
 w11-20020adff9cb000000b0033b28e0e09cmr7232263wrr.61.1707817241998; 
 Tue, 13 Feb 2024 01:40:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXyswyAOchhje/+6uLfozCOJTI63q5ETnDHLLsSAtOTOtZv4Ss9YJf/3uLRN5eSDFT8HOuqnKtWANj21Hcg4DJMRRfx+G7dBenGq7FM+qA/x4nd1NEKw6N6cEkF8/Jfb8ctFYYa5WRWOg54L5g9FN+KUwsGfVcieUiCizxLN2QABwS/TmZOs6/D8r4CebmE7Uq0pYiLEhhSVTM2PWqN741Qbt5SLvp6xU2cvOv5y5ChBFP9IoP1MTwRqvQTJ+P/5cZkpqSbdMV0nj5FGGpnXXS18TaaUkOSshw62qVaXVPRdTbhw+V+Wl5E4NirXyvNrZ4sAzSmXJfP6ysv5LEozqf4WSQNOQ==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:40:41 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 03/18] plugins: fix order of init/idle/resume callback
Date: Tue, 13 Feb 2024 13:39:53 +0400
Message-ID: <20240213094009.150349-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We found that vcpu_init_hook was called *after* idle callback.
vcpu_init is called from cpu_realize_fn, while idle/resume cb are called
from qemu_wait_io_event (in vcpu thread).

This change ensures we only call idle and resume cb only once a plugin
was init for a given vcpu.

Next change in the series will run vcpu_init asynchronously, which will
make it run *after* resume callback as well. So we fix this now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/plugins/core.c b/plugins/core.c
index 9e64820ad02..609d9d5c184 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -392,12 +392,17 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
 
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
-    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
+    /* idle and resume cb may be called before init, ignore in this case */
+    if (cpu->cpu_index < plugin.num_vcpus) {
+        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
+    }
 }
 
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
-    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
+    if (cpu->cpu_index < plugin.num_vcpus) {
+        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
+    }
 }
 
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
-- 
2.43.0


