Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4027C4829A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHhE-0004fE-D0; Tue, 06 Feb 2024 04:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhD-0004f3-Kj
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:24:51 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhC-0004lm-5B
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:24:51 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40efcb37373so5295055e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211488; x=1707816288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URZi/NmqB9fEf7SSooAoQ9VbUa1hGL9MClMwYN/jkYI=;
 b=BAobvPOrSVLCqzZs9YIojdLcNYEo4qrpzC+1ku9rr5vEv/VyPztINsnBqwzPE2hnDl
 7JBoltfa6MYoD2hOiGruNUFVFPGl1bdNPQVpcaMdmBKS61nCGo4FeDLDzUGIH9PBxr6x
 CnY47modg9aYM0+KRKbFfIw+ywp3/NdK/v13tO8GV8Twsk7lVhrOcMxLdvlzCbDsILQa
 EK65ZuOu/bsw9qaXi5amyPVc0sOsDtbXyHyt5pIH43GbofN8jzTl7IrLOjT0e2oQoBul
 Ji6oBJJsuW4i8ZpZ/HBuHZISUWQgPBqjUyC76YYvB1ib/m3Q9yFyQArfQFpqhye0V/zt
 V3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211488; x=1707816288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=URZi/NmqB9fEf7SSooAoQ9VbUa1hGL9MClMwYN/jkYI=;
 b=icJAvQkU3ZMNzZXC7Beu/dojVJbjkg1PXTSvtP3DMEk3EglMkRurjLk/6A5uLKi5tJ
 FSfhro5u26yDvpQ49ywtDXccdKjO4vCLH3Ga6VoYZMXQsUTWG2YR8HBfW3ljlgHc+Eli
 CLNljiBxY/QKRXyxPi8PQfoHHqjcqURAHbahoT4l0VbHEM5BPD4kNFxNXAFeMn5TeCIm
 UPNLl7B+2RuLDaF9MGfpY0DwVW/ELZI9haitcuKLkzB0KY/rYauTD810iBLQc8cRwwdc
 Em4Qj3ijHHaHR6qlJyqsr4Vo1o1KuQ5eoX6UbvaQt9jEOIeCFvmjK/PX39ViFnSJkiaf
 72qw==
X-Gm-Message-State: AOJu0YznanoPqxRNE6jNrK5iFBPr0fTNHTwWjqsJ5NOELAXWqWz8QkE8
 vPvY+LQKg9MyRfeOARXoQwKOTaIquM957WFVblh0yTTHWvL9Sj6btTx4adpMpS22LaWo4P1TqFv
 yysI=
X-Google-Smtp-Source: AGHT+IHdjdiPX7gRlYvdxF1WKacSlhjLJVto4VvtFlbgY9e7fwAqAZqWRGdDTiYXghBnPqay50mHaA==
X-Received: by 2002:a05:600c:3581:b0:40f:de6a:2a27 with SMTP id
 p1-20020a05600c358100b0040fde6a2a27mr1649274wmq.40.1707211488060; 
 Tue, 06 Feb 2024 01:24:48 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWBDcU1Ik2599Slt5Dh5fJWg9XnNYFiseY8sQ7UJfX+CKhPEA6t1dMS5F/7D4DTVDxSf+6dqhEOhmqHfu9BzZMD7pJMmmSjop9BAll3gYvMTd03XlgRoYvzLo2nqfTZpF73AYfO8lwlCRSdNSfDq3thmlqyQCXukMRWuHjbp6QDZxbQNd56sJGKm0YP/ciD2Z48VqOdmfRWHClC3Z5BJVfpvbR3+XeURcRFHKXG8SL3Xj8A3r8KadR8TqlIXV7sH3AcPb0g51DCfVx+BiL6zSjNEZlndvTjC1VVey5WtTlnyhIkjCM5Hj+O61liJl8t13rYDbcZJbXYwqictDEy2GNvWaJeKbZIJQ==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:24:47 -0800 (PST)
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
Subject: [PATCH v3 04/17] cpu: call plugin init hook asynchronously
Date: Tue,  6 Feb 2024 13:24:09 +0400
Message-ID: <20240206092423.3005995-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32a.google.com
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

This ensures we run during a cpu_exec, which allows to call start/end
exclusive from this init hook (needed for new scoreboard API introduced
later).

async work is run before any tb is translated/executed, so we can
guarantee plugin init will be called before any other hook.

The previous change made sure that any idle/resume cb call will not be
done before initializing plugin for a given vcpu.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/core/cpu-common.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index fe16d0d9df8..68786360ea5 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -194,6 +194,11 @@ static void cpu_common_parse_features(const char *typename, char *features,
     }
 }
 
+static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
+{
+    qemu_plugin_vcpu_init_hook(cpu);
+}
+
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
@@ -217,9 +222,9 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
         cpu_resume(cpu);
     }
 
-    /* Plugin initialization must wait until the cpu is fully realized. */
+    /* Plugin initialization must wait until the cpu start executing code */
     if (tcg_enabled()) {
-        qemu_plugin_vcpu_init_hook(cpu);
+        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
     }
 
     /* NOTE: latest generic point where the cpu is fully realized */
-- 
2.43.0


