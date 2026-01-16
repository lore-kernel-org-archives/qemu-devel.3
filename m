Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C77CD47CD6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghss-00037I-Ct; Fri, 16 Jan 2026 06:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsL-0002DS-5Z
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsE-0006rP-VW
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:18 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801d98cf39so6299185e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562410; x=1769167210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jlctq5vKHYkeEDFI7uZ1fcRMPddROuIgRymQ+Ihf0vE=;
 b=oaydNj8mDedOdtlViYk2w4PEdgPBPd+OP3Owsms+/bpV1DB5Ek5TAsSrGtHlQltNTO
 0vm9BWzTdnQ62wy/4d8/k8+QdCDgyYxCyFKfmaAaEnFCUaQF9hNs+33RLF30oEAuyuWW
 wsII68Y3l0Rtu3xleYoGK2bR4CBYct88BHf8X5OBpxcOU2uF/Ed29oGVKwK3y/C+18xm
 8n+4I8LmzKP5feDGCsghkiBoG+Dxi+7LMx32dH1PFvMQp0G+yZI8hQCDBvlmh+qqDhfx
 g90UDYqjhAY5L5vltlQL/hhPnIKCouUdxQgzv/4pqsAOeYuGZIvTNA5vczsbWlnZx5X1
 IxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562410; x=1769167210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jlctq5vKHYkeEDFI7uZ1fcRMPddROuIgRymQ+Ihf0vE=;
 b=wGFrXzh2NH3DJvsVgQUGleFJ4CuPFhZqdXiEcqY4KQSHqYZNP6Di5OV57CTTRCzL/a
 sLBFM2ujRnAb7h4ARvUOt2z6EnofR43+SQARcPVE8T/QYKHvqgL1odSdEdafoFN8PxXd
 XU2wXTcRqZMKqsNQs0yVj0tSuaGPPVP2dJdnqY0Yamqb2oF3ryUsrsGAyYikct8utH1T
 gems5zBNw0adW4xLOrXOXGqqEcKM+TvgYCclOVXrZOqA/nh5MFYN3ARArwxjJTL0h+Va
 CyHhfPeLGPU3WnYwxFz7L72YWmTXfdgTNNo/Crq2kVT1zi6yGZnAri4+QmEmAuKp8URa
 mJKw==
X-Gm-Message-State: AOJu0YzDhJOKt1yTm6q2cVl0V6T9N/77YpOwgTYzmE25LXc7EGKsCW8k
 D3nlKX3alFYhjjilDz1lwVjJNHQK9BsKeyWKtp66/FQTZcdhOxlqSGR51vu5jk4o5KQR2O9dvkb
 R959RlME=
X-Gm-Gg: AY/fxX66hiiaNPNBuO5qnEb2SJEcgB5ZO8KXm5ZWAggbTxBaoifb+gmdZq5IZCFd6zg
 S7qVb7/tZyQ3MhogWSkufpjI8FbnvJWimykf5I3AxOGHnUrNWZ3rRLE+jVQGBNphROk4rVYIErw
 AvwxyMC76HXdPYZ+QaggZTmUnxmctK1ULkdMPk2m/ibwKNfxAu3zf4Ui+/I4uWB4ENdfd3A2Fp4
 W19/BdpVlio8qN8o8PUXnxZTlEkbj60Qfc4yKP0FVsn5jiJ0GR4pg7ukrDv8eylHhnsJwabUUGU
 Bnk49drzGyn6ykD4MMWc+T1ve4w9469cbcDn+9VNNXAIyFMu3kvwzsj7c+oQMn4PtpzUdZR5FWX
 ljxAmKvZb5RYalF3JdFyBE/2ECuoGh/mj87JTp6DXHjVUWJC0B1ZisGKBt587y14ia6JquEucMc
 tHLre85ni7dzrsXmrkhrV0JDS0y1Bz/1L5zDHGxETaf/X3OQynH6BUf+Aya1+2
X-Received: by 2002:a05:600c:4fc6:b0:47a:7fd0:9f01 with SMTP id
 5b1f17b1804b1-4801eacf142mr29859025e9.16.1768562410413; 
 Fri, 16 Jan 2026 03:20:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe67780sm13781605e9.16.2026.01.16.03.20.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:20:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/30] target/arm/hvf: Implement dirty page tracking
Date: Fri, 16 Jan 2026 12:17:55 +0100
Message-ID: <20260116111807.36053-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Notice writes to pages which are being monitored.  Mark the page dirty,
re-enable writes, and retry the instruction without emulation.

Assert the fault is not from a stage1 page table walk.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260112103034.65310-12-philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 52 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fa26f63a61a..af28b8e8825 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1869,9 +1869,10 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         uint32_t srt = (syndrome >> 16) & 0x1f;
         uint32_t cm = (syndrome >> 8) & 0x1;
         uint64_t val = 0;
+        uint64_t ipa = excp->physical_address;
+        AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
 
-        trace_hvf_data_abort(excp->virtual_address,
-                             excp->physical_address, isv,
+        trace_hvf_data_abort(excp->virtual_address, ipa, isv,
                              iswrite, s1ptw, len, srt);
 
         if (cm) {
@@ -1880,23 +1881,56 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
             break;
         }
 
+        /* Handle dirty page logging for ram. */
+        if (iswrite) {
+            hwaddr xlat;
+            MemoryRegion *mr = address_space_translate(as, ipa, &xlat,
+                                                       NULL, true,
+                                                       MEMTXATTRS_UNSPECIFIED);
+            if (memory_region_is_ram(mr)) {
+                uintptr_t page_size = qemu_real_host_page_size();
+                intptr_t page_mask = -(intptr_t)page_size;
+                uint64_t ipa_page = ipa & page_mask;
+
+                /* TODO: Inject exception to the guest. */
+                assert(!mr->readonly);
+
+                if (memory_region_get_dirty_log_mask(mr)) {
+                    memory_region_set_dirty(mr, ipa_page + xlat, page_size);
+                    hvf_unprotect_dirty_range(ipa_page, page_size);
+                }
+
+                /* Retry with page writes enabled. */
+                break;
+            }
+        }
+
+        /*
+         * TODO: If s1ptw, this is an error in the guest os page tables.
+         * Inject the exception into the guest.
+         */
+        assert(!s1ptw);
+
+        /*
+         * TODO: ISV will be 0 for SIMD or SVE accesses.
+         * Inject the exception into the guest.
+         */
         assert(isv);
 
+        /*
+         * Emulate MMIO.
+         * TODO: Inject faults for errors.
+         */
         if (iswrite) {
             val = hvf_get_reg(cpu, srt);
-            address_space_write(&address_space_memory,
-                                excp->physical_address,
-                                MEMTXATTRS_UNSPECIFIED, &val, len);
+            address_space_write(as, ipa, MEMTXATTRS_UNSPECIFIED, &val, len);
         } else {
-            address_space_read(&address_space_memory,
-                               excp->physical_address,
-                               MEMTXATTRS_UNSPECIFIED, &val, len);
+            address_space_read(as, ipa, MEMTXATTRS_UNSPECIFIED, &val, len);
             if (sse) {
                 val = sextract64(val, 0, len * 8);
             }
             hvf_set_reg(cpu, srt, val);
         }
-
         advance_pc = true;
         break;
     }
-- 
2.52.0


