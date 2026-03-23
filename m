Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919A2F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iX2-00032O-6r; Mon, 23 Mar 2026 12:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWy-0002VD-EQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWv-0000XO-ET
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:32 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43b4915161fso2979225f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284807; x=1774889607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H+01kDL8vwOFCafIr+GaEdpav1kILk0/awwutlUldoo=;
 b=wrsd/ANCL5eQialOG3c8bChxjy9pdSZCwoG5DkL8GjDnWM8Nrx5/y/cIj6k7yMVc6V
 Lef1i9Scwndlp40LTcIJz/Yx5xtybsyG7+X5xVSqYypWmucuPdtP8Zu5XDaXU9e6o5WK
 XXeev8SG705ZV+8xdJKA/Bq4T8uajCqoX47DfDxSA7a2pCoQHuiSEihuElwr6/wcaA/V
 qNYxU4gVgIGifUWmMaHI4AvzTJXCR2rXYiBvbZK0GU33XZsF1rV/R9qOPsoLwAtNH29I
 u4ywBKc0dNaEn2LeC6bVQyfFdIW0pGEnb8pgOl1KX4dkz0dZcszBtQOa1vwCVWr0nxiG
 WKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284807; x=1774889607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H+01kDL8vwOFCafIr+GaEdpav1kILk0/awwutlUldoo=;
 b=HeLAohHKF6JM/ddEuuetwISEGR3s1rHBeF9a8iKKZe9eshY4THZjoiWDdq650PjvqX
 0QOas1ihzefMuLg+wjVy0mAx9vgq9bZ8C1lvBnfXE8Jq2Z/YclxaYJtGdPAKfXJoMjKV
 Se0508pkEAw5XS99uPMEfHF54e+LaljXnTWNR1WaYCVEIZn6BW4u6PYEb6I9/DTOZAHN
 THPuw3o5yFf2qQjcA9LDKFFUgp9/QYJDdi/WBIra7QeXJls3atqM/uwRcqdL8y/7cY6j
 Adpsjw+EGFY2DdXJ3f7s6rsVBXPb0gsycHfpDctMYnz7FqQeLsXhObFNNMpggZvTXI+7
 8y/Q==
X-Gm-Message-State: AOJu0YyP/NNyaP+/E/apxr+wKaFfIs6xdSlk7IIcYGfmPfPVzNvrdX9p
 y3ydxuyUdqGnACu28sgxVdqN4CUXxJNNXQ1v+JRQhkviCK2G9/wGA4SYXJTiE0Ar3rYG23pxpVj
 tYnWvq48=
X-Gm-Gg: ATEYQzxifrO9o3RrkAgHE3kAeHxBWpztb81ufoSGtZOkA0A8NtgbEsxy4tWOyJO8Znd
 03z6uIq8S+TwRCTEm4VGiWh9bLdWhO2OwZt3dBzFEODHkiraHeSuMAfHeP0YmzlkeWI9TmOUdPV
 CwlnMdEQgYeKLD2jVnubvZQ/vBHJxkDet3rA6QoO3B91KL4xO8OYwvS+3u6UvZs4hLDMaPu88jk
 jyQHE8C6fyvgzO/VypkU7oBRJ7AXEdEPHBvwSWQAjxMn7E0yPaJjgFPErksm5b6MQGVdqhl3K2/
 oxcG2W7BLlGS/ALTTjK1OkRVyW/N9ekxVgWTjsQABP6yab30aQOv40TSBobeBvXgif5S2E8AK+W
 68RfQMyWNVt8WuLxaBv73XF9OdrIffwI21lV7+Vh7mvF+3USWo6iyyb4UpCjlVwyDjymZ/3pgyR
 YISI+fMa0D6C7Z5mqn0HpiXjrzsuEuapl5wp+ybEC9zUjn1+JKGXmukDgmycFT1lIRujpayD3K
X-Received: by 2002:a05:6000:601:b0:439:c5cf:fc73 with SMTP id
 ffacd0b85a97d-43b6423b842mr20341597f8f.12.1774284807231; 
 Mon, 23 Mar 2026 09:53:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae37dsm31031247f8f.2.2026.03.23.09.53.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:53:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/27] hw/i386/hyperv: add stubs for synic enablement
Date: Mon, 23 Mar 2026 17:52:01 +0100
Message-ID: <20260323165218.96607-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
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

From: Ani Sinha <anisinha@redhat.com>

Add a new call hyperv_enable_synic() that can be called whether or not
CONFIG_HYPERV is enabled. This way genetic code in i396/kvm.c can call this
function to enable synic for hyperv. For non-hyperv cases, the stub will
be a noop.

Reported-by: Michale Tokarev <mjt@tls.msk.ru>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20260319122137.142178-3-anisinha@redhat.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/kvm/hyperv.h      |  1 +
 target/i386/kvm/hyperv-stub.c |  5 +++++
 target/i386/kvm/hyperv.c      |  9 +++++++++
 target/i386/kvm/kvm.c         | 12 +++++-------
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/target/i386/kvm/hyperv.h b/target/i386/kvm/hyperv.h
index e45a4512fe9..a393a5d4283 100644
--- a/target/i386/kvm/hyperv.h
+++ b/target/i386/kvm/hyperv.h
@@ -23,6 +23,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
 #endif
 
 int hyperv_x86_synic_add(X86CPU *cpu);
+int hyperv_enable_synic(X86CPU *cpu);
 void hyperv_x86_synic_reset(X86CPU *cpu);
 void hyperv_x86_synic_update(X86CPU *cpu);
 
diff --git a/target/i386/kvm/hyperv-stub.c b/target/i386/kvm/hyperv-stub.c
index 5836f53c23b..767a4c7e1a1 100644
--- a/target/i386/kvm/hyperv-stub.c
+++ b/target/i386/kvm/hyperv-stub.c
@@ -61,3 +61,8 @@ uint64_t hyperv_syndbg_query_options(void)
 {
     return 0;
 }
+
+int hyperv_enable_synic(X86CPU *cpu)
+{
+    return 0;
+}
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index f7a81bd2700..bd3c26d02b5 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -24,6 +24,15 @@ int hyperv_x86_synic_add(X86CPU *cpu)
     return 0;
 }
 
+int hyperv_enable_synic(X86CPU *cpu)
+{
+    int ret = 0;
+    if (!hyperv_is_synic_enabled()) {
+        ret = hyperv_x86_synic_add(cpu);
+    }
+    return ret;
+}
+
 /*
  * All devices possibly using SynIC have to be reset before calling this to let
  * them remove their SINT routes first.
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a29f757c168..9e352882c8c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1754,13 +1754,11 @@ static int hyperv_init_vcpu(X86CPU *cpu)
             return ret;
         }
 
-        if (!hyperv_is_synic_enabled()) {
-            ret = hyperv_x86_synic_add(cpu);
-            if (ret < 0) {
-                error_report("failed to create HyperV SynIC: %s",
-                             strerror(-ret));
-                return ret;
-            }
+        ret = hyperv_enable_synic(cpu);
+        if (ret < 0) {
+            error_report("failed to create HyperV SynIC: %s",
+                         strerror(-ret));
+            return ret;
         }
     }
 
-- 
2.53.0


