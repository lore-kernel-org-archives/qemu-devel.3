Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA3AC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpHY-0001D5-9J; Tue, 13 Feb 2024 04:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHV-0001CU-OJ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:40:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHU-0000Dq-82
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:40:49 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40fd72f7125so33217345e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817245; x=1708422045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhKqsf2G7q2jxsX13Ny5Px+xNhV9GwuKJNdrlayG7WQ=;
 b=BjI9h8l1lIDg6gdy7/quqtvVBW4iQvYZAsdI/48HrvLwjsIGEQvEn1rzF5MBlNC30i
 /WoX2VgPb+gn1X1+l5TjybvpjACu/WfM+ktH8GaLZWidBZbj09aZMf6j98bmgloe+Q8d
 kYktYnVX+3UV8kluIbszq584SZr4BbrYeWS6whFw/G9smjKiwGQ24YlyDBahiPmgqkg1
 LUeEl2sqtKS3JWBRY5y11XJmgMDlU8qybTsCkIRldC4SPpUMkleGmoJAOv6j+IF6Q/Ow
 PWAbDryanXomwMwmbfYh3Sy4YyNiFBcvqQC624oDYUaZUls7HWWcQrpd1ysr4j1mg+KW
 BQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817245; x=1708422045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhKqsf2G7q2jxsX13Ny5Px+xNhV9GwuKJNdrlayG7WQ=;
 b=oC9NdVQPZsvEo3F9TuQoRTwfmaQEBeWTMe+baOkn2LEtrycX49Nvhr5nwSCViRXyjz
 7xrnPRF2Y3kVIX/vPYdMSp3fve5wxIgU2PEjNlWbLP9hawzavlRT3kjJXM5w7KXwIrGp
 AXP565I8wMBSva1FHM+QcGHSD+627wVjMiSgkAtS6BMNd5nhGOkwM/Hhghtq+hkdCps2
 bd/agmSSj3oN73WsRoxM5J1Ei0CMDMMaBlXK1LWSVHfd/2jYbavT/HTAyu1HZyYgshZC
 A7nEpRoMts3I2P4nlMcETFWinKneI66ESAB5mUlio2WyPhlboTCCQsofu//pJzDn+cOt
 8lbA==
X-Gm-Message-State: AOJu0YwhGwsITl6X9ggbWP+pO1cOzPTWObC1I9HMZW4WeW2SYOZtBpob
 yUReczsBSWxjfPre5YjEbZJ4mzAT31kxP0YWYEj5EpgzcC04A1MyJQHSyvEJQKfoiHVKAB0IdYC
 d
X-Google-Smtp-Source: AGHT+IGBrnSlcUI7JKL9BZjv3uzjH1i6XkNsXnkOO6o5m4tG26QaSDOf01k6bbbEHVDYT9pifWec1w==
X-Received: by 2002:a5d:4537:0:b0:33b:4d7b:a736 with SMTP id
 j23-20020a5d4537000000b0033b4d7ba736mr6070659wra.19.1707817245440; 
 Tue, 13 Feb 2024 01:40:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWVn+w6XiSx+v+B30oVHCbHeKj+uUIl//XmMnOo5Wcz6B6PvSRA5TpPvZldRS4sPD8geXwmk9rRGkqmxLwfGLKmT5SHqxL+gR86Hb+51xfrMWiU645mFW20JClXKVmHWv/2zyStSsdlHHSrY7DxGnBA+/NezAJ+fbcNNWwVg/U8wE3+Q4AZvDbqn6Ariia0pExUWiavabCpAxxQC2aeGMAvae3UM3pH8ZX0rJXBKS5vaNh1GywwYpWEritqon/mWXPB5a7PSdw8eFmr7nEl7j6/VnvypEe6Znn2vfsm8GoAA69hw13wC3+4FWQbA91IlHNM+t7oH1+wYrKXNL38qmvNP5zxAw==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:40:45 -0800 (PST)
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
Subject: [PATCH v4 04/18] cpu: call plugin init hook asynchronously
Date: Tue, 13 Feb 2024 13:39:54 +0400
Message-ID: <20240213094009.150349-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x330.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


