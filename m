Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F53CA0FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 14:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk34y-00054T-Fz; Fri, 30 Aug 2024 10:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34w-0004xp-Iu
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34t-0004aa-Ic
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:22 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42bac9469e8so16185725e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725029898; x=1725634698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1u3oGoUOnf0MQZHYBn8kE+8RhfN7fOzLKX/E3Ds8pFw=;
 b=Anjs6aFsckNNFqIRhlB5MJR2jmDUdcu9yseJGe8udNL9y9R+nRuElNL+OrgeJIoeTV
 5LZbqEzfoS6vNCmOPmL77rjoqBaJdy1ntJ8IW3UkDPrple2UaE3lvEZLauui9TOx0UER
 9pFkZRMNUvSwy4GT5ADkdRNWFzQ/8RlYludG2W5nD9lkMzg7S0VLcUudm735gM31aRFw
 d3tnuWjT1H0kA+ksB5y2yT2shYrz/VNeFRkohZV0iSkp7+9SPCB5QWcGmw8eRrZpM1jX
 uO6mxje2fg4VDy8mH79FgJJ3uCHvVj0Lbwla6s0T8s7kwX/Lxl7Y3ZPewNosdwNNB1dZ
 zGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725029898; x=1725634698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1u3oGoUOnf0MQZHYBn8kE+8RhfN7fOzLKX/E3Ds8pFw=;
 b=bz97Ucf3w6LlEk1PlmMGOYzYbvvdAHFLm01mvdhwFKeeGQrxPvfLA0BxQ44sJVQbkH
 7DkFR3+5SLffReWTqURyL5LGMi9LAJC74YXwK4fb/fI5Finvhh/Dy0xKyjQFD03gv01e
 t/FGX9Mmdm5TUG5MdceNWIxy4MXxD53KHz3QVghya6pv4g+z6RXB3D61tPzzjwge0N08
 xJiEsJmZXl3N6DPFeqtD0f0jT3NbkjUJEYde+MW9BU+TB+R83yebtpU3b6QU+raxEzPD
 cLMympfPR5lY7z+s5UsfvmL6+iUmJJl8O/uvffCb1jQqSTmCI9+6Q+nIg3zZUqaRm1fH
 0SiQ==
X-Gm-Message-State: AOJu0Yy6IuNXbCqBPdbdLK6Bkk3lrUJUAdBRYe3xnrboHnGI41bhXHQk
 ANXPNOFXzr7D8zlaewdF/ZTynzaKpZWg+q4N7Ng8Mc7xwC/0l6WgwGxp4DgR+4zCfoOc1xVM+5H
 +
X-Google-Smtp-Source: AGHT+IEnoLdNFK8dIsNUJV2KqwiVuq7Go+4aHFEpwZXT7tZ0sKZV7S/LZxrkxmntMtJkQaIE1aK7cw==
X-Received: by 2002:a05:600c:5110:b0:426:6696:9e50 with SMTP id
 5b1f17b1804b1-42bb02591d1mr42575885e9.14.1725029897963; 
 Fri, 30 Aug 2024 07:58:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6da24bbsm49022345e9.0.2024.08.30.07.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 07:58:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 06/11] hw: Define new device_class_set_legacy_reset()
Date: Fri, 30 Aug 2024 15:58:07 +0100
Message-Id: <20240830145812.1967042-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830145812.1967042-1-peter.maydell@linaro.org>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Define a device_class_set_legacy_reset() function which
sets the DeviceClass::reset field. This serves two purposes:
 * it makes it clearer to the person writing code that
   DeviceClass::reset is now legacy and they should look for
   the new alternative (which is Resettable)
 * it makes it easier to rename the reset field (which in turn
   makes it easier to find places that call it)

The Coccinelle script can be used to automatically convert code that
was doing an open-coded assignment to DeviceClass::reset to call
device_class_set_legacy_reset() instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/coccinelle/device-reset.cocci | 30 +++++++++++++++++++++++++++
 include/hw/qdev-core.h                | 13 ++++++++++++
 hw/core/qdev.c                        |  5 +++++
 3 files changed, 48 insertions(+)
 create mode 100644 scripts/coccinelle/device-reset.cocci

diff --git a/scripts/coccinelle/device-reset.cocci b/scripts/coccinelle/device-reset.cocci
new file mode 100644
index 00000000000..510042afcca
--- /dev/null
+++ b/scripts/coccinelle/device-reset.cocci
@@ -0,0 +1,30 @@
+// Convert opencoded DeviceClass::reset assignments to calls to
+// device_class_set_legacy_reset()
+//
+// Copyright Linaro Ltd 2024
+// This work is licensed under the terms of the GNU GPLv2 or later.
+//
+// spatch --macro-file scripts/cocci-macro-file.h \
+//        --sp-file scripts/coccinelle/device-reset.cocci \
+//        --keep-comments --smpl-spacing --in-place --include-headers --dir hw
+//
+// For simplicity we assume some things about the code we're modifying
+// that happen to be true for all our targets:
+//  * all cpu_class_set_parent_reset() callsites have a 'DeviceClass *dc' local
+//  * the parent reset field in the target CPU class is 'parent_reset'
+//  * no reset function already has a 'dev' local
+
+@@
+identifier dc, resetfn;
+@@
+  DeviceClass *dc;
+  ...
+- dc->reset = resetfn;
++ device_class_set_legacy_reset(dc, resetfn);
+@@
+identifier dc, resetfn;
+@@
+  DeviceClass *dc;
+  ...
+- dc->reset = &resetfn;
++ device_class_set_legacy_reset(dc, resetfn);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 18c7845ce9b..ade85c31e05 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -953,6 +953,19 @@ void device_class_set_parent_realize(DeviceClass *dc,
                                      DeviceRealize dev_realize,
                                      DeviceRealize *parent_realize);
 
+/**
+ * device_class_set_legacy_reset(): set the DeviceClass::reset method
+ * @dc: The device class
+ * @dev_reset: the reset function
+ *
+ * This function sets the DeviceClass::reset method. This is widely
+ * used in existing code, but new code should prefer to use the
+ * Resettable API as documented in docs/devel/reset.rst.
+ * In addition, devices which need to chain to their parent class's
+ * reset methods or which need to be subclassed must use Resettable.
+ */
+void device_class_set_legacy_reset(DeviceClass *dc,
+                                   DeviceReset dev_reset);
 
 /**
  * device_class_set_parent_unrealize() - set up for chaining unrealize fns
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index cf811580621..51827858ce7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -844,6 +844,11 @@ static void device_class_init(ObjectClass *class, void *data)
                                    offsetof(DeviceState, parent_bus), NULL, 0);
 }
 
+void device_class_set_legacy_reset(DeviceClass *dc, DeviceReset dev_reset)
+{
+    dc->reset = dev_reset;
+}
+
 void device_class_set_parent_realize(DeviceClass *dc,
                                      DeviceRealize dev_realize,
                                      DeviceRealize *parent_realize)
-- 
2.34.1


