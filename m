Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B4DC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgvq-000856-2q; Tue, 15 Jul 2025 10:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgE2-0000MZ-Rc
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:01:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgDv-0004VE-Sh
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:01:42 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so22380765e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752588092; x=1753192892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBxxvAKWvDXoU3BMlwQqtGjDUKV/shCGTJ2G1DYo+uQ=;
 b=AEmxUS6hMyzjb1pVd9bd7/byKj+lZaG1xHy/vECOZ4jRJcdd726OaW1xfl4SI5HLTV
 5jG/jrEHARgAYq+vJ3Nrc5KXxqpcbXl/3wSllwazZByjEMYiaZHRXtWnlB81qSfKF2xF
 QERbvIaFikGJmZSohseqiDV4iA/3SmGBrlQGJjGnKcNqaG+bO3CkgOQZfMnAE3WjuIzj
 WllG3RofS0LsBLKqXOQaRO7rwv7zdWwwYi4f7x3fRJpphDzpXgguVeBBvTyKJYBEwmK5
 rN5xGIrrwBi+tZBT0P2PBZNhvnGz2mxEaKSKceN12YKA6MGJZeavGRvEKUhz3sIXiRJQ
 URyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752588092; x=1753192892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBxxvAKWvDXoU3BMlwQqtGjDUKV/shCGTJ2G1DYo+uQ=;
 b=cSF40rhWWF1fJbHqvIB5JZ0Pndwhbcsk8MdQRJcQvyuLoUdbsjGumiOw6vscb4BeBY
 YiSnqVfxTfXUCWiFZNtj/c6aiKiUL+7pxSS8ISDoDZ8Fs07Zz6iJbNxazUfBtYdwZ0GN
 bEPmrds8IbETDpePvQuidUbY2SLonRNIt/U6shzYa41wLBBSGnUE32yBldINdvOGuiNT
 zAp7KX0rXGWlCS0SAOqVA4ETgBpSsAMmewWnpkeUFEE3LeSvQ1OvBCK38WUv8cQ1qzUg
 wPaF6SEUZgbB5RncpmzJcYDxXZ/V6Qvgf4SF+nVghy8JOgrFaFrM4VeeBUZwMQDr1u/q
 gmQQ==
X-Gm-Message-State: AOJu0YwaUHdp5Co9COkfBgAwKZR3oZNxDPAjDtt4HzXemSezlLhUV2/S
 9LYebsbwavE9q5ztWD+nnxZAzCXcyn4ihXE3ncH4vzT9mVIXs6Iq/luvulsApQ1kdRCfYZ8/ByO
 b7Ra8
X-Gm-Gg: ASbGncu5E6ozfD5Pr297qrgs05sMS0IBj8P1knw+4m6+R60d3b8/y2a3S3hDSdhwps5
 8GYbi47SXUiLq89YL33HRmjZK0sbPAj0SH9j5KVsMzlyQr/j/VVXUS6ctpA2Ayqs3QJ3VCP91p3
 CX0QK3FhbPpaPFWXWF1OSlW9PkGbdHEpG+kJTu2SBsoId/Mh7CEXfVC0BOzT3lve2N4D+9sNvp3
 7qqqmIdA2buz2bSTFAHOKEKob3uuIji5/dPpC5tFfBoBKhIrSPemwecZf8obmCuvwJ3pJcsJ+Q8
 nVPH9Hnwq2F55DN2QbSI2Jj/AXCd8n2LSY0gvN6Lo8T3JzmwwxnhmICQPtT+1HTcBcRgZZhMrxA
 MUxcjeL67Lt0y6kifUt7/rXUTk0DFax71UDScmhrKMHRNx4x03FzntFk2pLV9wZt8sBPRj+Tdc8
 Iu5A==
X-Google-Smtp-Source: AGHT+IEeEI7cZI8PqFXh8cQfjoJcctNrMOuz2OXXR2e2Na0uQ1B4xgEJcvDRn/zouslbEURQUEMCXA==
X-Received: by 2002:a05:600c:354b:b0:456:1a87:a6ba with SMTP id
 5b1f17b1804b1-4561a87af02mr60631425e9.33.1752588091640; 
 Tue, 15 Jul 2025 07:01:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc23cfsm15492280f8f.37.2025.07.15.07.01.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 07:01:31 -0700 (PDT)
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
Subject: [PATCH-for-10.1 v6 7/8] accel/hvf: Implement
 AccelClass::get_vcpu_stats()
Date: Tue, 15 Jul 2025 16:00:47 +0200
Message-ID: <20250715140048.84942-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715140048.84942-1-philmd@linaro.org>
References: <20250715140048.84942-1-philmd@linaro.org>
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

Co-developed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 214454bd0b4..94a5bffb44e 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -58,6 +58,7 @@
 #include "system/cpus.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
+#include <mach/mach_time.h>
 
 HVFState *hvf_state;
 
@@ -118,6 +119,12 @@ static void dummy_signal(int sig)
 {
 }
 
+static void do_hvf_get_vcpu_exec_time(CPUState *cpu, run_on_cpu_data arg)
+{
+    int r = hv_vcpu_get_exec_time(cpu->accel->fd, arg.host_ptr);
+    assert_hvf_ok(r);
+}
+
 static void hvf_vcpu_destroy(CPUState *cpu)
 {
     hv_return_t ret = hv_vcpu_destroy(cpu->accel->fd);
@@ -347,6 +354,20 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
     }
 }
 
+static void hvf_get_vcpu_stats(CPUState *cpu, GString *buf)
+{
+    uint64_t time_mach; /* units of mach_absolute_time() */
+
+    run_on_cpu(cpu, do_hvf_get_vcpu_exec_time, RUN_ON_CPU_HOST_PTR(&time_mach));
+
+    mach_timebase_info_data_t timebase;
+    mach_timebase_info(&timebase);
+    uint64_t time_ns = time_mach * timebase.numer / timebase.denom;
+
+    g_string_append_printf(buf, "HVF cumulative execution time: %llu.%.3llus\n",
+                                time_ns / 1000000000, (time_ns % 1000000000) / 1000000);
+}
+
 static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
@@ -365,7 +386,10 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
     ops->update_guest_debug = hvf_update_guest_debug;
     ops->supports_guest_debug = hvf_arch_supports_guest_debug;
+
+    ops->get_vcpu_stats = hvf_get_vcpu_stats;
 };
+
 static const TypeInfo hvf_accel_ops_type = {
     .name = ACCEL_OPS_NAME("hvf"),
 
-- 
2.49.0


