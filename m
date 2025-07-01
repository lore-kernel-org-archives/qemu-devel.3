Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA46C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcCM-00019I-IO; Tue, 01 Jul 2025 10:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCG-0000Zl-QW
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCD-00072B-R2
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-453643020bdso50231025e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380967; x=1751985767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zyDwPMt6YxbjjGXo86a69tBngv13ZljrHl0yFXEhOMk=;
 b=Bice8yNjNA0P4hVy6bU9ibOdz8WUuJWprvVCyyXwG8d1jCwdYRU/MKObiOCbEIPkf7
 cxTzag03sarjVAuG2vkwiIpANQqzEg6KxUg/T42zDTrVPqpCFjUEU8bmfFvwYXmWQNxm
 ZIm8aRmYLsM8YXPuagNrwXPL9eRTWRLvNqaNykUdOYVhIYPhXtCSkxV5xlLpUdUryleS
 mWh6ndBrAoFFth3UbJbdP9L0TCsjYZ6OQKZ5cjS0IozBpwDAJyg1vqa6kLc736QcKWk7
 lxnL3exKObjM11RudlAmS1irzvld+viLhtUcDm6cbTe19gzhI4+rTTn6Rk8xkm/I9uJf
 bttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380967; x=1751985767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zyDwPMt6YxbjjGXo86a69tBngv13ZljrHl0yFXEhOMk=;
 b=VA0Il7OYMKuS3hcRbNNLEmT2jP6FoUHgNs075vk5LfA7WZ+Dol+nVlzzntA1dcorJt
 +jZUg8jwXJZVruYNhGju1vGSs6513wrDiA11vj2W1qIKRnk5wCpieT5Bx7yRPqEF2QyU
 ZXk0QfkO7RPFUvgXCv6cXZptprqh0ht7rGbOBH0rDWyc46sU+oOMCfOxHm7mqNYLSM35
 OXP2WcUjvAi5Vf6XD0EAS0/jNR1qrqCNk8liXCKYRVNh1OJc0bxsgpB6gAv0YXLOWVcq
 RFPonaMGBYIj8tZGRk3PXENbJDjTUMefyB2rQA/yrr3q3NpBJWYmdUSCZa3Su/DSt234
 Yj1w==
X-Gm-Message-State: AOJu0Yw73Rwgx7yrCWwEHofKLsX4NhAtv5nw03Q+I4lD4l5wjQSN3+AR
 dwWQGIIiiPWr37HE7ZCe6fSnl3Cpzq8Tn/uJqBt6qhtjASFmLiNsNglCOsCm+3rysKCGibZZIX0
 cHNBZ
X-Gm-Gg: ASbGncs7Zi21nLpTaxi1LgXCjiggttOEzMn/lGwpmQRNPybQNHIPl6rldiWVkS1eN6o
 VoNH+xV1rr8KFCodHZC9pO45r7ND0Pr0sR6kZTUAjKbzqTHdb6yBf1TIrpn0xa29SvlKsQ1EnvF
 SUj+5PCLweE3Mz3y1cxODqWsIJFbzPjCmrnEHF9fYQJkXJcNPj+zI+f84lyz223bV7Ho2/Pt7Kj
 ol3KXJdgQkJ9UUydLjygQW7VYjojipZyb7tBATdiAY8n8AyngIvKV7YN/6uRJ+4kuvLwyrMkZaK
 LLOlWlxFuxaBpe/KawZgxz00FNSZQJk42ZUwRJjjl+gIAugwZ/X9EYHzt93ldU4zMMTOgdzB6uv
 /dlDd8etEgCh6xt+Sg2/rK6OkM6OW92/VHjNx
X-Google-Smtp-Source: AGHT+IF/ghJgw3V/Yrak0VimZ4GXm36KLrzWsMS4M8xrB1+yTav3Atw7uZoCQh/ykgIuo1C4UiYwaQ==
X-Received: by 2002:a05:600c:1547:b0:453:cd0:903c with SMTP id
 5b1f17b1804b1-453a8fc441emr30712075e9.2.1751380966625; 
 Tue, 01 Jul 2025 07:42:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c8013b3sm13451048f8f.39.2025.07.01.07.42.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:42:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 27/68] accel/hvf: Implement get_vcpu_stats()
Date: Tue,  1 Jul 2025 16:39:35 +0200
Message-ID: <20250701144017.43487-28-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index a2e0f890463..ca85922356b 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -352,6 +352,12 @@ static inline int hvf_gdbstub_sstep_flags(AccelState *as)
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
@@ -577,6 +583,16 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
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
@@ -595,7 +611,10 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
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


