Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F7FC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 20:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublsj-0007lm-TE; Tue, 15 Jul 2025 16:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublby-0003ww-Ox
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbw-0002mW-Pu
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so53841265e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608803; x=1753213603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C5pXkzQHaUuU2g6dRUjmsncT3yyVU5ukELcU+QSiw3k=;
 b=BWCSM74mYAN8XYGtyNneakN3zLRuYFLmIm3It3oj4/4tpufeMHujXTZydcGEpKf71s
 Mpw13mOmlFwoclpcWBxbNga9j9FF3CWjq/JOdd1B70oCL09ciYf/VU+9nUGTohIVzM42
 FhJOwHeqUJ3eeLBwAWNEarHbSkj3PcrUsYuyGut1a55+A77WVCbVLCSwPRLXB2tNHsTv
 I09EWK3WyxJNSupwk1c293DlpBZI1gg5Ic8ugzg7u7j6zmuS376fFcYqEEwfXnEK72KR
 jdP+bGAuEndHxdZYPRot5v3BcS3cQ9wFw1nn4VdSo5OBuwZWdRr/vZvkmdjH6C64nRT+
 LDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608803; x=1753213603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5pXkzQHaUuU2g6dRUjmsncT3yyVU5ukELcU+QSiw3k=;
 b=px9yhrfhPf71RnYsWuEOEjztQyuYhTkZMjDLuLb0w3oiU3YbDriAg9ukF0ewOGxk3B
 8elIa6YPtIAoyNK/VYLqtmSGTj9gsjzGOn/YsiWT8TCS2K3Ay17bYEFdFSHWO81Jkspm
 qZqKwfwc4RnKzlAMlOCUWEzUp6Ty6XLRuhiGOljZ5eR7giQc3wyfs6IRluWd/OYvruhs
 jPdp3PQakoDEQ/9IKuyIix6l87i1Ani/ql7krjeOi2vkishutXxY1yiSiJZjezXHH7Po
 MSlsqbOAs0mb2c8Lo3WyBT4MQJqVFMxpYpNb1RW25M7rIpaAhKW0Tsac/rKdr6kHOCMk
 m29A==
X-Gm-Message-State: AOJu0YysG2jxfRab+0gr5d8fwffg00iHGZiVXbNNk4MtX93cXIbjZXh4
 csL5U5q62aGryR7cPF3/JegY6J6tA9X9I7nCqwVPh52y8xe/MH1Sz0Ee2bAtFmcjfQBxx1wjngu
 ZCQ9X
X-Gm-Gg: ASbGncs86WVP5kBCHUxl9hoI0za9pYGRH3XbrsdVv0tiWP1DLfnRjMv8bUQ0XCEm8vG
 4ylEo0qDrGFJU/Puq2r1ieycysIzqo+P+/SCuYs6TQuTxugTMRFtTjZ/gSOZWgtQtR09kMnHTeM
 5bShZ6b4XfT93rFN+Gcm0mtE049yczzFkTadigc4YrvcT4KIzWOnHjSS3qAaWD3PF8CXURFUNXR
 u8Wm6GdeJj3R+jYkOxfitLUexfPIBOwOfKhnBnP7UAJUtcjD7lj47UAqWaFAfmtNW9JvIvyJeTI
 LAIlR4mA3NvPZJieQXuzy+DDVHspmrPv9WxjTKFkf8ABhRKuXhAB3AUoVfsMJrRiKmemelZWjM8
 Fh3FJCRcty050TUsMy73l2vL5WFXptHMR3p8fuPBUNJEsFGClMfy7vO0aF48rLCYI3dv4z8bswa
 vrLnHEbrv5A0Nt
X-Google-Smtp-Source: AGHT+IEzq0cOnWr0UxxgkyKNJkYe/svL/RMx+afWzf7BVsfoFfYal8xnNGhJB0t/7gCdogh0F7AfbQ==
X-Received: by 2002:a05:600c:310a:b0:456:1e5a:8880 with SMTP id
 5b1f17b1804b1-4562e38a0b9mr593335e9.13.1752608802750; 
 Tue, 15 Jul 2025 12:46:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45617dc1fccsm79628225e9.5.2025.07.15.12.46.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:46:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/17] system/runstate: Document
 qemu_add_vm_change_state_handler_prio* in hdr
Date: Tue, 15 Jul 2025 21:45:16 +0200
Message-ID: <20250715194516.91722-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20250715171920.89670-1-philmd@linaro.org>
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


