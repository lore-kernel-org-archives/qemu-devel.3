Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8454DC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHhB-0004ee-S1; Tue, 06 Feb 2024 04:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhA-0004eO-9y
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:24:48 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHh8-0004lR-OT
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:24:48 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51117bfd452so9043676e87.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211484; x=1707816284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOjCHa75MANot4L1VfuMEJ5mVel7QNiDk7VkpGP0Ccw=;
 b=SGmSTl5sB4hQSkBo/ODYgfltAy6KXXmSjomiI6meGAY/rFT9fRs0vu1jzUEDIKgQVp
 5SxbFBvaXFqTJuGymzZzDdM4JqrNtKIcUHhJSx++nyKDVmLCkdkEyjfTV744f2sTRPSJ
 hRCjZTCjDZ11987CnZ1E9/1/l/kRGDWuKBJJvHDYFiZWxZhX+0Aua8SIFgV7zz0Oe3Iy
 zUa+wAksjqZq8eb0hInyB5881AH4o2T49Z0ZQqG48qIkpjcyigFNwgz4gBDP0tCHlF84
 +QeC4/kyINnU7SDYTixq4LvXD3aeJJa89PaBGpVbBYTtHdAxC8uTo+cxud1fQsMkmJUH
 3A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211484; x=1707816284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOjCHa75MANot4L1VfuMEJ5mVel7QNiDk7VkpGP0Ccw=;
 b=TsYQHak5XOUjh9X3ET+Ui3I+Sl+Bo2nFRlL7B55JwgHqdYZo9Oqbzo937o4EOvUOdo
 cLIVbQX9ZhY7Q6011wwKjoVHvPdCSVvX03xQ549Cil4rh3BcUiZrpa0PKiwCppZ9D+za
 BIQLBsieYYKPVHxYf47lbX4CC8hDeF/z6xfS4UM/2bhK6a9WJai2J6jvV1pQupmFQms1
 Q4Q+TWmcz7ypfOkpHuCU69m/RXgLvwgpRgGSpk4195qgVN+KF7/mDyzkcHR7bmauHZC3
 yQ6WOAqUgxAQN6onnfZCsF7vInnZbzaXzWe/Aoh1/zXzS5iBudLxhbWk7WyPHyOjca8C
 0AMQ==
X-Gm-Message-State: AOJu0YywUTJqq6IbZkvCQHL6SdFzZjE/Y25BgApzkAEe12wSWOEZTdiX
 b/OuhzTXBkllZyBcOa1P/0ogyBnN+nr3DRte8xPT36tDqJDqBEUjEM2Whe6tkL0KIFvMfArnYD0
 DJI4=
X-Google-Smtp-Source: AGHT+IHRrhFmOoj49bMXFAIhNiIXp5ARXqz3iC+RVRJquV6suAi1RrylVGRv6hdTSHnjCneekJfmXw==
X-Received: by 2002:a05:6512:2354:b0:511:5e6c:c021 with SMTP id
 p20-20020a056512235400b005115e6cc021mr934899lfu.36.1707211484482; 
 Tue, 06 Feb 2024 01:24:44 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVZ8XsdngNyJzoHXkiKTJsXFuDTeOcZ8IzLx+j3Yq4L7E7SYmOfiEy+7Ea9tR+kBft088hsB3P2KfpUgjO4doJjwVnhrBlrqUWudJwOmbMrBeAz9pTZc0u4Anfs4zj3PyR36uXBMH4RluO2J1vG0RfKwaXdA96L/NcUir7O5U3S2UjkY7Zcxfp6zfuTtRmr6jlZGNcFGzGVUszXJ1rm8nRmGy6y6+bcaSHuA9mYnrzqQqfusvQ8KmgaB8Lo47Hm1rVQncJ9yb26Ob4dKZtYZbAQCgPjK8cofei/rkQf+Yry2v0+iKOCpwX+TSgHUKttRvXeEf6zSQ6LChDcSrh6fN5OU/S5VmN5Lg==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:24:44 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/17] plugins: fix order of init/idle/resume callback
Date: Tue,  6 Feb 2024 13:24:08 +0400
Message-ID: <20240206092423.3005995-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x133.google.com
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


