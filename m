Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1A1CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJH3-0005a4-Qu; Tue, 21 Oct 2025 16:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJH2-0005VC-Fg
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:04 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGz-00017t-JM
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso1514965e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079679; x=1761684479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mcuDkGb+DgMEBmqhUyNSjRYCplIAiUNB//076H3m6Is=;
 b=utkCs6iBSxr38NYA+TtsscuJzPyQpZ5KBXBWjxLpWE/faXmBPDA/8E0e6MwO9L2+9X
 jibx2d/n6Lt4c2Y+GPZwp2sFh+M4+XhvtqNVfldk5lDDtN+4aQoZ9zYBrEBpwJBtJKdi
 GDtYthPNT74socMMSrCdHT62/fZHxGwLQ0V3VlhfVObxuFhB2MDWfSvibF81Kspu3fuV
 RlfbnosXodSgNDEd+fFn+G6g8MpWg/t17C5W2X8OLbQOHPq8Au7AjTTKa0zW9LjJ2TTI
 U1mZTKMEC9ZyFyTW160y71lsVzMTuq9zUupFjCVdyel5iIMOlbZoeofDYSpF6yq4q6Ps
 gyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079679; x=1761684479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcuDkGb+DgMEBmqhUyNSjRYCplIAiUNB//076H3m6Is=;
 b=Kp/BgM2KSsahzwpNs2j0LH7TIu/SBsvM5Z/8gCh86AbOPt9FcC8BaGL2fZwDPbj2nu
 7XRZMfp8fcA5h2N1FfI0hCsH2A8h32HINYsKnSdec6x3pVXKn3vBhHxZHCn2lxbiJyUO
 tjR5EUfUWD7ywpkOws2f/GMIm2+Vu6RUjdnIXHBgar+2i3nFHleaPfQTZPnIelKQ+ugr
 /V4mHYI4hksoJrpqpKuVXo9D7qcfFo2C43B1tGPdgnLCF/KsBZ/0powrL8wp5qN7E79y
 UTGQJGU5k0IKhRg8VSZbWlaTimhsCXy5zLhllWSBUi0iFIpgd2DWPdg0N2tHSV4sg8P1
 HhPg==
X-Gm-Message-State: AOJu0Yxi+f2Tk9pQQHkKkDPlv3CtGCALN/voWsO6uTy3GztOyyfhmahJ
 wkFqSaw6Ni2i+U2ECqFiOWxVnG4j31ytqLGsIIKzWvuaGNt+Y8+tsUS0Yd0O4MwGIQwIbw1WUiu
 jlGfQnw4=
X-Gm-Gg: ASbGncueqArjBjaT5qZ7E6wSjPaPcYBVNXk+ZsU1fYFUu32PbV75aeaMAKTmIwLx8LK
 juV7RTU7Nj3he/kXfXtVX8TThNcKqYMPaVpyDkCagiW/f+grFNsnYMZchD+jvodEG1pE+qXvi0s
 w+itRhrksP6I60/XJeCVot3K93KqJCJ6aRYAXhNxSGjsFXOcqYd11UCvUWTjvz1dCAjYD2U+bow
 5exE0X0sJrbdHZfefUlcGcTmP44bhDSq8F2bpEJZBddBcCdcTyv1WfYVGNWkpVHcxZgYugFnvz0
 OYj1cXIBBnVpNoDYIeVSwQaJsYZ1lqg1DhDFrHqVkN4pvhXU1gtw9uszXDazFg9122o2yBPG2rF
 Z/9H4s+BN0fA3uv+VruZYxIY4eJg9wemhzMAQFbWFvawlP2uvIO8VHx+eQhr/VAXW+YIc/s91wp
 rqm+y+LProldYVkVsQt4mvfI2W0H9XyXu9VFBGIAuXKGeeJ+6qWFmnFVFvIe8Y
X-Google-Smtp-Source: AGHT+IEjkErrE+kPg3hjMHbcHkpHTqI9PntpyQzrtdsjGjJe7kdxGr4P8NB3DBde98XnsHOTDWNwSQ==
X-Received: by 2002:a05:600c:34d2:b0:46f:b42e:e38f with SMTP id
 5b1f17b1804b1-475c4004b2emr8490165e9.19.1761079679191; 
 Tue, 21 Oct 2025 13:47:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c41ca845sm10439055e9.0.2025.10.21.13.47.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:47:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/45] hw/boards: Introduce
 DEFINE_MACHINE_WITH_INTERFACE_ARRAY() macro
Date: Tue, 21 Oct 2025 22:46:26 +0200
Message-ID: <20251021204700.56072-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
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

DEFINE_MACHINE_WITH_INTERFACE_ARRAY() is similar to
DEFINE_MACHINE_WITH_INTERFACES() but allows to pass
an InterfaceInfo[] pointer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20251020220941.65269-5-philmd@linaro.org>
---
 include/hw/boards.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index b2964cf0556..a48ed4f86a3 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -507,7 +507,7 @@ struct MachineState {
  */
 
 #define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
-                                machine_initfn, ABSTRACT, ...) \
+                                machine_initfn, ABSTRACT, ifaces...) \
     static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
@@ -519,7 +519,7 @@ struct MachineState {
         .class_init = machine_initfn##_class_init, \
         .instance_size = sizeof(InstanceName), \
         .abstract = ABSTRACT, \
-        .interfaces = (const InterfaceInfo[]) { __VA_ARGS__ }, \
+        .interfaces = ifaces, \
     }; \
     static void machine_initfn##_register_types(void) \
     { \
@@ -529,11 +529,15 @@ struct MachineState {
 
 #define DEFINE_MACHINE(namestr, machine_initfn) \
     DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
-                            false, { })
+                            false, NULL)
+
+#define DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, ifaces...)\
+    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
+                            false, ifaces)
 
 #define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
-    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
-                            false, __VA_ARGS__)
+    DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                        (const InterfaceInfo[]) { __VA_ARGS__ })
 
 /*
  * Helper for dispatching different macros based on how
-- 
2.51.0


