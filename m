Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808C7C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 20:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW0T2-0000xV-9I; Fri, 02 Feb 2024 15:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3M1W9ZQcKCggswutwlqowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--komlodi.bounces.google.com>)
 id 1rW0T0-0000vH-LC
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:48:54 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3M1W9ZQcKCggswutwlqowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--komlodi.bounces.google.com>)
 id 1rW0Sz-000082-8k
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:48:54 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2963a56416dso879436a91.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 12:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706906931; x=1707511731; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=8WeuC7JvPagfraa2WTEH94EGGshXGZXY2HdGa0YFfR8=;
 b=QSRl9x/UrbNLoO3ZDwQn+8PxwnMxykfB2RbfPwBZjQV6AgqeWYKCybqHzHL7GrEq4O
 b6lFb/7QAF62xZPdaOprbjOGqRC1KFI9T7vQDErhPazj0TeVJkZb/beImVaUhumWPbar
 g28JpaIXL9dBJ6ntdmvsdUYhRokuvUtacVb2LfZZnpXSNc7B6AZt62cwkYAT+9NpcXAU
 o7H0v3JxrilG+sQovjC5mhthV5HEXwB7/aDlPo2P+kl5/gbwQx87mk6RLhUMaywxtEKE
 t7JJy6W5lPy+MnFmiUWOZGxYh+b5LSCSd6lr8Y8U/Wxt1a3NyFclwLaUnxPpFHdEwECa
 VwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706906931; x=1707511731;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8WeuC7JvPagfraa2WTEH94EGGshXGZXY2HdGa0YFfR8=;
 b=ASOkCQxD6qN2VTZ0K7FvyeTBktgsNUooc2gI2uDLv6aQp0z3Z9xfQoZnAU37dBfcOT
 xNUP13ABmeyniLgKrvtFz927A5azfaCi1kAqdZYl07QybBZTZhemBlY7hHNi0tN+li4i
 hWgiKLAQy4U07McdTRhTakPFHa1FDzbDpxo4BCYoPPrUots1KKQbBnLa3W+EHzCbWOf8
 5YnlVNth53KnEwTA/L9wiUk88RfBDwWl/ub5cJzkOpQIcgZavwMkEGiXUdhHH7ZUm4jp
 aJ4vrV8QilHT/YYBMLjLV5/P8LvsBrKyTF1nyCbnZ/ovauLEdYtBlKACn43vL1maFxvZ
 ZsiA==
X-Gm-Message-State: AOJu0Yx6HX2KfeMHUj9ay4lmg8rr3Oh0ltaNmi2octV1ZZ+cNbXuocuo
 4ggurOV7QIWN1VEBXd+DPJ3e4zxDTOPUiGhdGHzlGTT6BUt1kCdSFxsQiYR9pI8Etve/eFS1Jqa
 XUVSraL9D8rfmte1NZJ0FyA0sKPqKHgz8uEMx+4uaJplt5K+YWx8k+rt8VMxPyACsfIBSMnHtpP
 5Vnjg2u5kUJCkFyT6XNoJvq1z5Npifib7p6PUD
X-Google-Smtp-Source: AGHT+IHoGumHwsKdV+lrp3vsfV2sl9AUx2eObHzrlz/abfSdNG6E1LA1YfQ+64UGCGepIFTMHOSLeh+EN+9U
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a17:90b:2e8b:b0:296:3718:2dcd with SMTP id
 sn11-20020a17090b2e8b00b0029637182dcdmr21731pjb.0.1706906931234; Fri, 02 Feb
 2024 12:48:51 -0800 (PST)
Date: Fri,  2 Feb 2024 20:48:45 +0000
In-Reply-To: <20240202204847.2062798-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240202204847.2062798-1-komlodi@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202204847.2062798-2-komlodi@google.com>
Subject: [PATCH v3 1/3] hw/i2c: core: Add reset
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, minyard@acm.org, 
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3M1W9ZQcKCggswutwlqowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--komlodi.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

It's possible for a reset to come in the middle of a transaction, which
causes the bus to be in an old state when a new transaction comes in.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/i2c/core.c        | 19 +++++++++++++++++++
 include/hw/i2c/i2c.h |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 4cf30b2c86..3128067bba 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -23,10 +23,29 @@ static Property i2c_props[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void i2c_bus_hold_reset(Object *obj)
+{
+    I2CBus *bus = I2C_BUS(obj);
+    I2CNode *node, *next;
+
+    bus->broadcast = false;
+    QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
+        QLIST_REMOVE(node, next);
+        g_free(node);
+    }
+}
+
+static void i2c_bus_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    rc->phases.hold = i2c_bus_hold_reset;
+}
+
 static const TypeInfo i2c_bus_info = {
     .name = TYPE_I2C_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(I2CBus),
+    .class_init = i2c_bus_class_init,
 };
 
 static int i2c_bus_pre_save(void *opaque)
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 2a3abacd1b..49580e30e2 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -64,7 +64,7 @@ struct I2CSlave {
 };
 
 #define TYPE_I2C_BUS "i2c-bus"
-OBJECT_DECLARE_SIMPLE_TYPE(I2CBus, I2C_BUS)
+OBJECT_DECLARE_TYPE(I2CBus, I2CBusClass, I2C_BUS)
 
 typedef struct I2CNode I2CNode;
 
-- 
2.43.0.594.gd9cf4e227d-goog


