Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267F4C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 12:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYQ3e-0007kC-Gx; Fri, 09 Feb 2024 07:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ3c-0007ix-H5
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:32:40 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ3Z-0001pS-BW
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:32:40 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5116b017503so1145525e87.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 04:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707481955; x=1708086755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/EF0ukeLn1gu/zaqcDjARqMaoRLvmGATkelLRoHEzw=;
 b=wT9dB7Rhhr4feEQsUkJWsAoMzDnk41S7aB+GfGEB3NbzKbD0wHCMFP13HKpJbtgAA0
 ghkiupFWJVmKDTUiONufcOStB4jeLiq1EWrXTS2j55bKa7+ZLHxk9U/dz5WYTVCuX/Uv
 lYu1BAj2L/Paw9V27JHKe5cGTMCDsr9dE3wKpwTF16RcyzAxOX01yBOWmcNnJAWxP5pZ
 em4qyLDBvRLHEGUzft2q2lrBXGebRz1T4+WpI1SyOvc+pDkN6sCoQrYeuFfl2TVR62bF
 fQyc5TV+vgHtOi4trnfnU53dGldDnTCbKkc8EQlUCc3WN2O6yzYb1QTdUjBgIL1E/SGb
 x7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707481955; x=1708086755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/EF0ukeLn1gu/zaqcDjARqMaoRLvmGATkelLRoHEzw=;
 b=rxI7jjhf2aLhuNCaS7fIfe4QLD5fqEkWXm+vtERA7DeoS7PyNcA3iplubWxjmnweEv
 yYjXxNX9MLsQe0e1/2bxGt8BEoDIWmStFbxE/Vi4trjY8ENejrc+kCNLEzohUxHxilCu
 zx8K8nSOyW2NjEZC9kvZqL4DckC2gHBQINie26Bn5P0yIC6RHySEgo9tJz7+Rfh5o0yM
 vDbnWDUTtZEZJrrX0C4ZkN3KZGCiXkPhWK4asFbZCL+XPGjo22QqkdDVG/NcCNSRD76E
 YnF3j4+UntQbAms3xXuCAWN94E+1DguEespzXGstSn6/mDTnsj0PtBFn1rtlxlLLG93A
 lpSQ==
X-Gm-Message-State: AOJu0YxvwrLVjbckowGudeApXBBQrjqaXHlM43omR/ef0DiIUf823lay
 Y8uMTLGGKJ9tpqa62wBZpi4efXwzO5on3/yv7p0ppK6XGnJrIC6BaOFnocAUTDtV4rKpQ5hxPQ3
 A
X-Google-Smtp-Source: AGHT+IFzNlLJIV6KFJNI6HMcsm4k41Q4sAMQPIqNmxYPKb1MoiNw7vxYC8cczpLfscF0PI7UTQ8IrQ==
X-Received: by 2002:ac2:5213:0:b0:511:78bb:a9da with SMTP id
 a19-20020ac25213000000b0051178bba9damr1050764lfl.39.1707481955364; 
 Fri, 09 Feb 2024 04:32:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWOxnzVCCy/U/2x4P2+0KM350C3xhqnQsKdrTEyWhR73+BTmRLGIr6ib1IOOGp8wKrXY3m5Ew8fI8vgpaeHbL58EZ67MtBtC8SAyviYbCiAEUENUfRQfJ/P6+oCFZ/SDCVW+jowkVVQpahRotlAHzlXntDPh+V4kyIcFvk2fn9NtyDKRB1tfyPkL2iUgnumUkj0dmzIw9NHNuupSJoQnAW9MvqNWNXQVEAvkvRqi7Pp17CIMioFku4/J5iKUM/eOpuP6FHQIxOdTXf7szYJBcdmc9CU4p+y1aFO6F22dVzl7X07kreNMoNiJs/pN42aV3jh7DXLWNuh3FE=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 7-20020a05600c248700b0040fddaf9ff4sm482987wms.40.2024.02.09.04.32.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 04:32:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH 1/7] hw/qdev: Introduce DeviceClass::[un]wire() handlers
Date: Fri,  9 Feb 2024 13:32:19 +0100
Message-ID: <20240209123226.32576-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209123226.32576-1-philmd@linaro.org>
References: <20240209123226.32576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 include/hw/qdev-core.h |  8 +++++++-
 hw/core/qdev.c         | 21 ++++++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index d47536eadb..2ca33aea3b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -101,8 +101,12 @@ typedef void (*BusUnrealize)(BusState *bus);
  * @props: Properties accessing state fields.
  * @realize: Callback function invoked when the #DeviceState:realized
  * property is changed to %true.
+ * @wire: Callback function called after @realize to connect IRQs,
+ * clocks and map memories. Can not fail.
+ * @unwire: Callback function to undo @wire. Called before @unrealize.
+ * Can not fail.
  * @unrealize: Callback function invoked when the #DeviceState:realized
- * property is changed to %false.
+ * property is changed to %false. Can not fail.
  * @hotpluggable: indicates if #DeviceClass is hotpluggable, available
  * as readonly "hotpluggable" property of #DeviceState instance
  *
@@ -161,6 +165,8 @@ struct DeviceClass {
      */
     DeviceReset reset;
     DeviceRealize realize;
+    void (*wire)(DeviceState *dev);
+    void (*unwire)(DeviceState *dev);
     DeviceUnrealize unrealize;
 
     /**
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index c68d0f7c51..1d399aae71 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -303,6 +303,16 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
 
 void qdev_unrealize(DeviceState *dev)
 {
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+
+    if (dc->unwire) {
+        if (!dc->wire) {
+            error_report("disconnect() without connect() for type '%s'",
+                         object_get_typename(OBJECT(dev)));
+            abort();
+        }
+        dc->unwire(dev);
+    }
     object_property_set_bool(OBJECT(dev), "realized", false, &error_abort);
 }
 
@@ -601,8 +611,17 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         dev->pending_deleted_event = true;
         DEVICE_LISTENER_CALL(unrealize, Reverse, dev);
     }
-
     assert(local_err == NULL);
+
+    if (dc->wire) {
+        if (!dc->unwire) {
+            warn_report_once("wire() without unwire() for type '%s'",
+                             object_get_typename(OBJECT(dev)));
+        }
+        dc->wire(dev);
+    }
+
+    /* At this point the device is "guest visible". */
     return;
 
 child_realize_fail:
-- 
2.41.0


