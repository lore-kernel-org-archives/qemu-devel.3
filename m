Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF81BC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 17:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubjp3-0000Z3-Pc; Tue, 15 Jul 2025 13:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubjJR-0008JJ-0k
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 13:19:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubjJO-0006iz-0U
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 13:19:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-455fddfa2c3so34750185e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752599962; x=1753204762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N5Hldz+trtqUVFJQo4frUHTEqf3gyCDz7YBHkr0vpqY=;
 b=Gq8JPbW8Y2bON/VXOfhVn+wnzL+qSaqaEAmhlemVyZ5Mn+FwGqjhrtQ/vcXIy+sVDe
 OV9maDIW0Lu89ZxsCF6wqmSLmynR8bzWoe9DFq8uadSMhY9TmOrsqOh99Y1p88e0dUG1
 5U7Nsf/AMCOWLfmTJ4w1PV5Qks2p3yPpKYdfKM9qEFp4y0zR0fdNsCTS3lvqp3FUN10D
 il98QFIa6Mlwoy1MmUvuIepNRNiEdYqqLr46WV6E7X6mL61+nT7RsushKWn0ir4uSnbv
 Gaul6tIG76X1ZrCaAW3sygmZ206h5i+d3JhF3QRMKv0LvINVs4USPX4xvkrDtiz/zell
 jcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752599962; x=1753204762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N5Hldz+trtqUVFJQo4frUHTEqf3gyCDz7YBHkr0vpqY=;
 b=iNQawOhiwF/b9igUGQtEISw0Tr/qQt+cDyu8CRHXFTDeaz83fVEUzIovcjZpDcSHv0
 DFHgs1818zyYW67iAUWUNaHqIce+W7JOC5y2t5Y7jIs1UqdD7DKlV6TFe2/B8AI17bc4
 r4NtROdyRKQJ+7u3E3firIlx9/EG7EE6XYKyLQNhVSeQrtKJ6jGabcN1LqmqxO6XUk8O
 IiwFxysmtNKC036tM8DxNM1qo1+JbccB0jMZnXxQ4P8X5UDTt+V31/Rh7619oWCSM8qS
 ZeyRhEgv7ppQA+3SrkRklYJhkkQ9gQbiPSs3S8SXuG15GgbPjD3gRVJFxfGVF+sHFUr5
 OjLA==
X-Gm-Message-State: AOJu0Yxu7o6r80b/FWEtdlvkgqYtH0yHFE0OhKfM5CJhAAg1haeiyKrD
 LuVEBfFeSgndIVEv3uUhmkICqTDK6hdRzjLWR7tbbzu2OH0ENhLLhg3aGl/RNjMQwP8oDiVIuoq
 vfWTg
X-Gm-Gg: ASbGncsLdysfBWuJBHCdtPlm0YVMRc/Q6QoK6Bsi+rKj1NIDegLoJTmfHxBLPd5OzM3
 Cw5o+GIiCtAiukkqyZwMpdfdfOAmwHmdkwrBZYdJVsUYk/dZ/P/vLLzxxi+eyY4+87A3yXAeqOw
 KZ1WwXAi4CDLt+a0pqAx1O+t1p9n1ZISrIJTEgfovRA1xx+JS0SHP9I3aCaFY/N5Kpf5Igyungs
 hr/7AJkMDtUFSjvQYTIH4WQfqsoZI40FIECSnNtK2LS94Kq7bHOAVfFCESYoDcOkuVziykLwvn1
 n61ReDpoINauIqtsmM7mIb2eo7d80E9gduMzznOZ7TrxFwbde4SN9+81GH+k5VWHXWmNb3ifFBk
 5ZssmBGT0oIE20NeEHOP4XcfizUKIQYoUHIFhOKgFiKYw9Kst+ERql4m3HzQBbv6cCkGR+lhf
X-Google-Smtp-Source: AGHT+IE2Q4FpA7t5UEQGz5UStpLY0TjNXcqD8zBh1qUYp/ujKXFeepElsFMqzn63Q1L0mPVKen6bNA==
X-Received: by 2002:a05:600c:19c7:b0:455:ed0f:e8d4 with SMTP id
 5b1f17b1804b1-456272e0dcdmr42779655e9.10.1752599962275; 
 Tue, 15 Jul 2025 10:19:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456030270f8sm110292265e9.22.2025.07.15.10.19.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 10:19:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH-for-10.1] system/runstate: Document
 qemu_add_vm_change_state_handler_prio* in hdr
Date: Tue, 15 Jul 2025 19:19:20 +0200
Message-ID: <20250715171920.89670-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Generally APIs to the rest of QEMU should be documented in the headers.
Comments on individual functions or internal details are fine to live
in the C files. Make qemu_add_vm_change_state_handler_prio[_full]()
docstrings consistent by moving them from source to header.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20250703173248.44995-4-philmd@linaro.org>
---
 include/system/runstate.h | 30 ++++++++++++++++++++++++++++++
 system/runstate.c         | 30 ------------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/system/runstate.h b/include/system/runstate.h
index b6e8d6beab7..b8d1bc3d273 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -26,9 +26,39 @@ typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, RunState sta
  */
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque);
+/**
+ * qemu_add_vm_change_state_handler_prio:
+ * @cb: the callback to invoke
+ * @opaque: user data passed to the callback
+ * @priority: low priorities execute first when the vm runs and the reverse is
+ *            true when the vm stops
+ *
+ * Register a callback function that is invoked when the vm starts or stops
+ * running.
+ *
+ * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
+ */
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
         VMChangeStateHandler *cb, void *opaque, int priority);
 VMChangeStateEntry *
+/**
+ * qemu_add_vm_change_state_handler_prio_full:
+ * @cb: the main callback to invoke
+ * @prepare_cb: a callback to invoke before the main callback
+ * @cb_ret: the main callback to invoke with return value
+ * @opaque: user data passed to the callbacks
+ * @priority: low priorities execute first when the vm runs and the reverse is
+ *            true when the vm stops
+ *
+ * Register a main callback function and an optional prepare callback function
+ * that are invoked when the vm starts or stops running. The main callback and
+ * the prepare callback are called in two separate phases: First all prepare
+ * callbacks are called and only then all main callbacks are called. As its
+ * name suggests, the prepare callback can be used to do some preparatory work
+ * before invoking the main callback.
+ *
+ * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
+ */
 qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
                                            VMChangeStateHandler *prepare_cb,
                                            VMChangeStateHandlerWithRet *cb_ret,
diff --git a/system/runstate.c b/system/runstate.c
index 38900c935a3..fa32aa47958 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -306,18 +306,6 @@ struct VMChangeStateEntry {
 static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
     QTAILQ_HEAD_INITIALIZER(vm_change_state_head);
 
-/**
- * qemu_add_vm_change_state_handler_prio:
- * @cb: the callback to invoke
- * @opaque: user data passed to the callback
- * @priority: low priorities execute first when the vm runs and the reverse is
- *            true when the vm stops
- *
- * Register a callback function that is invoked when the vm starts or stops
- * running.
- *
- * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
- */
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
         VMChangeStateHandler *cb, void *opaque, int priority)
 {
@@ -325,24 +313,6 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
                                                       opaque, priority);
 }
 
-/**
- * qemu_add_vm_change_state_handler_prio_full:
- * @cb: the main callback to invoke
- * @prepare_cb: a callback to invoke before the main callback
- * @cb_ret: the main callback to invoke with return value
- * @opaque: user data passed to the callbacks
- * @priority: low priorities execute first when the vm runs and the reverse is
- *            true when the vm stops
- *
- * Register a main callback function and an optional prepare callback function
- * that are invoked when the vm starts or stops running. The main callback and
- * the prepare callback are called in two separate phases: First all prepare
- * callbacks are called and only then all main callbacks are called. As its
- * name suggests, the prepare callback can be used to do some preparatory work
- * before invoking the main callback.
- *
- * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
- */
 VMChangeStateEntry *
 qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
                                            VMChangeStateHandler *prepare_cb,
-- 
2.49.0


