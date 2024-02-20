Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231CEC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 21:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcXOo-0003xj-BA; Tue, 20 Feb 2024 16:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fxXVZQcKCjQaecbeTYWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--komlodi.bounces.google.com>)
 id 1rcXOl-0003vD-97
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:11:31 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fxXVZQcKCjQaecbeTYWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--komlodi.bounces.google.com>)
 id 1rcXOj-0008QC-SR
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:11:31 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-60802b0afd2so39888157b3.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 13:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708463487; x=1709068287; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=8wwc0g2kzl5Lc5KX2u5/DCKV1h4w5LnDzJMObYTiZgU=;
 b=Jmb5/g7bPuBJti77TiXaU/u/zffv7uQiobBGTGqdXV9q86cZP6TXnGC2CtncOupWRo
 aDL3Tdyqy7vOimIjBs2dBidHelDzqeoSlwtvfgV4JgFBJ46envgRIpy9Uuvg9aXF89p9
 GFnpJgjKb7G41AtZKbynLex9zhT/nZXTm/HM5edMnDyQmdRf77kpc0JnglWl9PSOh5Pg
 ycCCKLjVGGyJeIsuySMETdgnAHizdHgOMjVTcW3S+gBahNrHhTQrOYgz0YrJLBu/BHxT
 H9kKWHHlQaLms2MufZYpIg9EIowqaYD/BMg+bcknh8anN2XrHOpbTYE7h9/FcLPhA5D/
 PELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708463487; x=1709068287;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8wwc0g2kzl5Lc5KX2u5/DCKV1h4w5LnDzJMObYTiZgU=;
 b=rV3cC2q+qQlZI2AmHJ13YkniC5ewlZEDJqIYeU8Prytgux72NhpVtDLAfqRK81FWoz
 YWfcN4hxVkDOLsIW//SSWIreYzDKuwcOT3vmCl3STp9SAHHdMuItrHUuoDaAWZODgJqK
 LUTU7ta2vVYeX7B1hW5ziHh/trtHCVLvDIBExfOqpq5XtWIssIEAHQNxT5FJKyW5JFDf
 1Pz+l1d+TkaNZlEbY7VCXEagjzHO1rRrMwn7BmQUqgTwtNlUj3fZbpbHodoCRN3oY0X4
 QAKvhzJjSnUdH/c37P1kw0PmD8q3AqLUKCED2AO3fcbayEnTJErQlsyDfZA7Rsyk4fbv
 3hbg==
X-Gm-Message-State: AOJu0YwJanO8rY9QCeY8anRTe8uH7d026c0mZI8rjXxUQab3YNKgiW4m
 8D1Y1wYL0VQ8bxrIM0f3k0pTCET9hK6wcyJA+tZawQH8aaZRXxaGU25bD/BsP4Up26K4Jxyi1ou
 8gfwPLzwXBwOfXxxPOGsvZZR48IHbVY+J9KWR8v4o3sqjvhZHGHXpQZA3/Wa3FCsGRd0Bbw02eW
 /f8CBztolehWg8KKFJweZjEORYpEIiaN4caTLc
X-Google-Smtp-Source: AGHT+IFzTnHujQ/EqNFe9ptLqdFqdJxZhWd0kXmpcI+CaGfZ675rAdINE4TdmESUz/twsLY3yGaX7vQoauvF
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a05:690c:2f86:b0:608:6b9:bf09 with SMTP id
 ew6-20020a05690c2f8600b0060806b9bf09mr2037416ywb.1.1708463487655; Tue, 20 Feb
 2024 13:11:27 -0800 (PST)
Date: Tue, 20 Feb 2024 21:11:21 +0000
In-Reply-To: <20240220211123.2664977-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240220211123.2664977-1-komlodi@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220211123.2664977-2-komlodi@google.com>
Subject: [PATCH v4 1/3] hw/i2c: core: Add reset
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: komlodi@google.com, venture@google.com, minyard@acm.org, 
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3fxXVZQcKCjQaecbeTYWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--komlodi.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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
 hw/i2c/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

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
-- 
2.44.0.rc0.258.g7320e95886-goog


