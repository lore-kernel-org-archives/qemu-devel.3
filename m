Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6D1C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfLU-0002Sq-S4; Fri, 20 Jun 2025 13:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKd-0001Vk-MZ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:20 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKb-0004TX-VJ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:15 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so1954148f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439712; x=1751044512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8g3SAyDwaT1EwDV5s2zbr9B0oT21Z4aa77jAxEnb4OU=;
 b=f5bNpV/+60wPY1b0nDdn5udsBo86fq63SQVi6yhSp7bCCSeLbAmGRKAcAv4re76yDU
 C/BeuRPxHyuZQmW7s4gDHyghRp991HbgNyKuFu7SRsGWZtPhcSgqNkO/Z90dFKrlYHei
 PuYxNF5+UJ+Qm7fUAmJbf8M+JPttA1xkPVYO/6GNdVVyX7pCCmYxPc9X58VMs9Yk5Wr9
 4ND+H0cn8pwAaGAVGXuM0Rnd4zgZEew+5mqAoWgqrVqpTxAH1zINMTzj1b6cersA2dYb
 +eQnAZelzAV2s3OoBMn3ZCK1KBITGAWx+yudRBfUzyncrTrOyWpJnhyEA9FCjH+y4hBR
 3/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439712; x=1751044512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8g3SAyDwaT1EwDV5s2zbr9B0oT21Z4aa77jAxEnb4OU=;
 b=Re6Rg9D4EyGbWI8kIUq2btW6Ed+4Bu2LmShac4Z+0NFm0wq2IznKQEr7S1BKCtl+R3
 248fGpH+6RKN8jEW1N2rMuU3sY3WmhscIATbsltKCsAuiv+Leso8s8c1Gqogmgzmq5/l
 MrxCyaXEj4camGPcyVJXnXQSB+1tgZQKtpLLgvviAqqonR3vD5Q7OJiW6b53zayo4T4W
 u3KOnieAeSxum+nnbiRCnULcCmedXBkvD8mhvu6a/fLKEmKeLqqyBcIeearn5Eln5rpi
 PpMqkLjXGncKqYNw9O6M6buIV6w1iGvuPAYrxqXQKW1v2XviDi7CXmxadw2xXmMMhsZx
 jYSg==
X-Gm-Message-State: AOJu0YwbIs01zHx4t9Jyv3mf/qTrEO4iyZ4mry8YrNfn4OgwkX0sIrMH
 ijW95nyxG7p1zsc786qYPnIC+DzJZebCQFo4Lr0CI5/z//SDMs3L5mCnlGVIuvRadWIs9f6Qeet
 t1am7o5U=
X-Gm-Gg: ASbGncvDwQacy68yNOYq7pQALQtU8ppR6nE3nofekYqKL6WsEXcXDT3Rve9pu1cjluV
 ZaeEzT2dfgoJnm8sydwP2wI9Wb+NuO/MfMVN2OFwHqkNI4+60oTAzbcWGwc9Zfriq6DK3AwLu03
 qK6YwoDVYi9w1Qv2i+xqLJ4j9/B/y8v4TaRa9oRzkVKk8XyL0PEu0CL1HOYtAvcbegmF/HLvcRH
 HFixV8TWBtdhs263cwPDh6xgY2GzEk6X/aRsSDx5iHaHcwVRgbuSGb9wXBlxuRy++4K+/+AFPjF
 Kek4smxR7FojqaiFUZjnNkR524mShyr41Gc77Ghg34joZpey9U7NfWMtruT6zzQ/LhhJL/k8/I7
 JgMfTOEVzsqjI+mvOj5OcZpOsXl8C2B22yNRN
X-Google-Smtp-Source: AGHT+IHRa6uttUrX26Nx6rgKcLPuxl1hLSRTXVGAIMLxbgRQB4X2qajp39R7c3wgJzKETL/DPTcuWQ==
X-Received: by 2002:a05:6000:1447:b0:3a4:f430:2547 with SMTP id
 ffacd0b85a97d-3a6d12bb41cmr3142916f8f.6.1750439711867; 
 Fri, 20 Jun 2025 10:15:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d118a1f2sm2507970f8f.83.2025.06.20.10.15.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:15:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 18/48] accel/hvf: Implement get_vcpu_stats()
Date: Fri, 20 Jun 2025 19:13:11 +0200
Message-ID: <20250620171342.92678-19-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
 accel/hvf/hvf-accel-ops.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 45dd4baa321..bfdfef7c397 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -358,6 +358,12 @@ static inline int hvf_gdbstub_sstep_flags(AccelState *as)
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
 
+static void do_hvf_get_vcpu_exec_time(CPUState *cpu, run_on_cpu_data arg)
+{
+    int r = hv_vcpu_get_exec_time(cpu->accel->fd, arg.host_ptr);
+    assert_hvf_ok(r);
+}
+
 static void hvf_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -583,6 +589,16 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
     }
 }
 
+static void hvf_get_vcpu_stats(CPUState *cpu, GString *buf)
+{
+    uint64_t time_us; /* units of mach_absolute_time() */
+
+    run_on_cpu(cpu, do_hvf_get_vcpu_exec_time, RUN_ON_CPU_HOST_PTR(&time_us));
+
+    g_string_append_printf(buf, "HVF cumulative execution time: %llu.%.3llus\n",
+                                time_us / 1000000, (time_us % 1000000) / 1000);
+}
+
 static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
@@ -601,7 +617,10 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->remove_breakpoint = hvf_remove_breakpoint;
     ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
     ops->update_guest_debug = hvf_update_guest_debug;
+
+    ops->get_vcpu_stats = hvf_get_vcpu_stats;
 };
+
 static const TypeInfo hvf_accel_ops_type = {
     .name = ACCEL_OPS_NAME("hvf"),
 
-- 
2.49.0


