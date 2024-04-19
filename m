Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6609C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqeq-0001KZ-RZ; Fri, 19 Apr 2024 12:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqec-00018D-4H
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:59 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeY-00016b-RY
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-419d320b8a8so1162785e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542392; x=1714147192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQHElS3YY06JrxJsFkVRbTnlkqXQPEN2MqSOomU202A=;
 b=uebCtMPY64ObuYJC64zRLxHf0tDf+WRnqHZ6/XxRW7yXOg5nez+RDc685Pu3wrJiaH
 SpLx4sqe7JlCcmYXiK3ezHfr2tQCRgKOyf0sXXnqZxZFUbmcn6kLfXG+SulDvIf7Oqsr
 oPCbSt5eNtc+1CzN0mnv2sFBojdRnoySLMUHJ7fVq6bzO6na56JmhFBqFN8MbKOv9HHK
 +IpsSkwuZaGuRDJnYaHAIIiPRyygIR2qnNZw6/uFgye53jgcKrCpQiCkkT4yFjglPpuq
 sIeOVModxe0hGr//5NsjeR7LUxmG7/IF6/wqHpHo6urXFZbq3Hj1KoSuKndf+yo4cj6b
 jVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542392; x=1714147192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQHElS3YY06JrxJsFkVRbTnlkqXQPEN2MqSOomU202A=;
 b=AieZLTbjGQ4U7HsOclg4nlKjdWt/rk/vcWvgHEJj2oaoheEpfh8veQ2gxbEtZ+XoEj
 jSv8KjTDalc8BjK3G9MiYxY5J740OgPx17c8DjCGu9+s+gM3r2ZH8Ab5EwzENijDNS9H
 4NthGexG65fsUU+aONkJm0Xhx6RFeQIWboCPZrnKDPGbKATXn6T4dpT3m91cQPO0r4B8
 p5EarCBn9Yzc5P6Lyjm9/rPB25zNFw+TKOJ2HYq2dfbmUGjy2n7dt5lO1vhWMRx6TX3v
 WFXJ8Nd2Ji1cKVJlpjgHcvrtXh2z2H3E17Ijk34GEjAH52/tGT29X3oRrIXUxWKEeTHa
 k7pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaJ/odh3EK7AforNhVEiZpeUxxx/dJoo+pldki6JY8ggYrftiBQ5iKIRT6B5ElzS6754ylPmidYGcxQEtF+9LK0C4pG24=
X-Gm-Message-State: AOJu0YyKYUA/6dq+u1ZsW3O3rZqj4+0BdS07mV+YBknH+5L+hc5dn9xt
 2YDxpU/mpOgzB83xNTJ/aG4pdSti12q8O/C4MLVftiQY2CuMTayKs+YqdVJ2aV48PAZ7bB74rGk
 P
X-Google-Smtp-Source: AGHT+IHmfre/WtSkx5TiRXN2ShYLuSNHji6jc90xBDmEWEXfCMjkEhDoIkS0aPXwd0+4HswaKGSxuA==
X-Received: by 2002:adf:e4c6:0:b0:34a:6f8b:1237 with SMTP id
 v6-20020adfe4c6000000b0034a6f8b1237mr1184972wrm.41.1713542392299; 
 Fri, 19 Apr 2024 08:59:52 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:52 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 08/22] target/arm/kvm: Split kvm_arch_get/put_registers
Date: Fri, 19 Apr 2024 16:56:56 +0100
Message-ID: <20240419155709.318866-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x336.google.com
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

The confidential guest support in KVM limits the number of registers
that we can read and write. Split the get/put_registers function to
prepare for it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/kvm.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b00077c1a5..3504276822 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2056,7 +2056,7 @@ static int kvm_arch_put_sve(CPUState *cs)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, int level)
+static int kvm_arm_put_core_regs(CPUState *cs, int level)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2159,6 +2159,19 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
+    return 0;
+}
+
+int kvm_arch_put_registers(CPUState *cs, int level)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_put_core_regs(cs, level);
+    if (ret) {
+        return ret;
+    }
+
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
@@ -2240,7 +2253,7 @@ static int kvm_arch_get_sve(CPUState *cs)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs)
+static int kvm_arm_get_core_regs(CPUState *cs)
 {
     uint64_t val;
     unsigned int el;
@@ -2343,6 +2356,19 @@ int kvm_arch_get_registers(CPUState *cs)
     }
     vfp_set_fpcr(env, fpr);
 
+    return 0;
+}
+
+int kvm_arch_get_registers(CPUState *cs)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_get_core_regs(cs);
+    if (ret) {
+        return ret;
+    }
+
     ret = kvm_get_vcpu_events(cpu);
     if (ret) {
         return ret;
-- 
2.44.0


