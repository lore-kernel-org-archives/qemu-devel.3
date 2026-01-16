Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CAFD47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghsl-0002dW-2Z; Fri, 16 Jan 2026 06:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghs1-0001r2-VR
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:07 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghrz-0006Vi-U3
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:01 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso1019465f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562396; x=1769167196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6M8GN4jcvnEKDk7kfeY+4HZK5PQay3DeaiQ4uNbj1FU=;
 b=sWH3RDC4GcaWpAsADzUWlg5WbsxpvwNg+Jkm6mDApA+XS75Eawfkr/+/+eP7bbEnk5
 cLxNUUhJZ2q5dJL6qxIuqLh9UimduviSvVj9EouYKiUmaXIKOxZ61Nv79d6uIJSBjsLm
 Kqu5X8FYkyLvid9+GORS13y5bQpxdcg9W9aikc0+fZqWUuxfmXejfXuzAWbof7w+0Juw
 KdZ1C/I4WZO7y27oA3gukbN6exZfrBb9SZJ9Qi73gXLflTJ+rPqQULzHsW/tphjohpBx
 +SRhLxv4rN4tFVAYf1rf2U2EDPIP3EYJZ0zbGPFJttoSeIcSN5R2QNvZ1X0TdxTc/QMk
 N7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562396; x=1769167196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6M8GN4jcvnEKDk7kfeY+4HZK5PQay3DeaiQ4uNbj1FU=;
 b=Xya/exIaoiHi1wyOTC68AuxW2MlTqueIDvOHJ6DwtASASLpYCqS7/klGpXaJShbBF2
 Mv6acYzhbqZVkueZ2sz157/C9ISjQjLDlSpBPCFpIXpdidxp/w1Hym4xyJHMXBESTo8k
 jHVgJDQUipicIktS06Yeunrb0DXt48mUwf+TI99RpOlpwilB8flLDbRj8pWIDrAMYQTv
 g+0WJMXZY8KO494FikkBpu5cSl1C/FH+4u1JprpgYGVdxH6sC1k2eUZd/RMTvFziIj5A
 4X1BKXMNuov29QeWbqos9muNB0tLcIyeiqx1LW1hkb/iWX/mqcHI63IlenkBUyndWW/w
 O/yQ==
X-Gm-Message-State: AOJu0YyDYjRJ3HcM8c+E0H6/64ztHIJWCVRXio+ETNcZHzDpe+7NjAao
 j2Ijc5ZEbDXdNc9VLSNcCqOjFLmlBJ1JEMOB5n+W8hfAuBhwkiKVGmnK261ixDRMBoQywYOokK6
 xH09bs3U=
X-Gm-Gg: AY/fxX4jk2Bo6Pa8oaTymUtJggRoCK41yn38EfhunWP1VDhc4n2Sr9jllwdJpHqJy2l
 7J1+JeoBpSVDNgPj/Miz1AI4CbB/+B5T0k7M0nRxu+mJziLEjxZCZMtj+0wFEDu5eQ4lVY37Giz
 HWQNdw30Ui4PRnhEhCf/6XsGyK4lq5X9u40PZLw/RCFISgL5pjuvPZT0/Axs46hLBN2dsu61fuR
 vpIVQY/pC7sMLRfvM6xkKVZaGciUU+RsHFp9l/d+VB6mRn8FSNiYgLSgweEJN/MnxkNbjz+Xj8s
 iulCH/bTkoUhqKsHnDrJissAjLbwUxzgT20mi4ZPJ9M8mhpgSLQ2TvgCaWDSsYdBmFm2IMqNrqb
 lilDAn+ACV83DDMQ1CDnqQF+IR7swMxYKqG+WE7n8SZ+rLyAfxq3m+Su+XbWXkRFhjDSgwkxhwM
 Ineftj+ctAgwrMuTniJ6zemXWEMPCrYqfVEojPz3xiD0OgXlxWAumtaCKR//gMqM6gA2XyGDE=
X-Received: by 2002:a5d:67d0:0:b0:432:852d:5276 with SMTP id
 ffacd0b85a97d-435699787a4mr2494819f8f.12.1768562396044; 
 Fri, 16 Jan 2026 03:19:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm4755786f8f.19.2026.01.16.03.19.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:19:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/30] accel/hvf: Drop hvf_slot and hvf_find_overlap_slot
Date: Fri, 16 Jan 2026 12:17:53 +0100
Message-ID: <20260116111807.36053-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

These are now unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260112103034.65310-10-philmd@linaro.org>
---
 include/system/hvf_int.h  | 13 -------------
 accel/hvf/hvf-accel-ops.c | 14 --------------
 2 files changed, 27 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index ee7ab689f45..d842d4b2b99 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -24,15 +24,6 @@ typedef hv_vcpu_t hvf_vcpuid;
 typedef hv_vcpuid_t hvf_vcpuid;
 #endif
 
-typedef struct hvf_slot {
-    uint64_t start;
-    uint64_t size;
-    uint8_t *mem;
-    int slot_id;
-    uint32_t flags;
-    MemoryRegion *region;
-} hvf_slot;
-
 typedef struct hvf_vcpu_caps {
     uint64_t vmx_cap_pinbased;
     uint64_t vmx_cap_procbased;
@@ -45,9 +36,6 @@ typedef struct hvf_vcpu_caps {
 struct HVFState {
     AccelState parent_obj;
 
-    hvf_slot slots[32];
-    int num_slots;
-
     hvf_vcpu_caps *hvf_caps;
     uint64_t vtimer_offset;
     QTAILQ_HEAD(, hvf_sw_breakpoint) hvf_sw_breakpoints;
@@ -70,7 +58,6 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
-hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
 /* Must be called by the owning thread */
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index e4c62522e10..d931412975c 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -64,20 +64,6 @@ HVFState *hvf_state;
 
 /* Memory slots */
 
-hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
-{
-    hvf_slot *slot;
-    int x;
-    for (x = 0; x < hvf_state->num_slots; ++x) {
-        slot = &hvf_state->slots[x];
-        if (slot->size && start < (slot->start + slot->size) &&
-            (start + size) > slot->start) {
-            return slot;
-        }
-    }
-    return NULL;
-}
-
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
-- 
2.52.0


