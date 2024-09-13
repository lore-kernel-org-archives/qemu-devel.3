Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AB3FA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp806-0001pM-9F; Fri, 13 Sep 2024 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp802-0001ee-MR
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:18 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp800-0007lT-N4
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so21173515e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240455; x=1726845255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x+L6IQ+Q7ldy91T7HLv/CH8gFnEYSNt707sBQNeOJj8=;
 b=FrfvI5E0m4Vev26ffpuPmoZXX1j8Xo1XdtxecIJw3lDe14DpOXDHMw7Lu3Bs2RlihT
 DVKF3m29dgbV8ri7wpCGcA4fiOTgFPo503ah0ZjhPNWdup6smf9PlsYVRPNLYiCe3Tvb
 cbaMiQsfLMB1zeMXUPwp1v35pzKaAzgL6n5rv5o+jYrpjvCudDJS7lZGZaPTcElYhyKe
 /9b1zLdVmGi+PCKGHchFpsAjTpYMWRCUtyM1aX7nGDOciU21WbsPsPZeiCc2AlAXkTch
 jre8iF6Vy7BMnBwEUIoD8J9i2lfw53zGQpPqxvvd+fQaxzZ3eMdoSnDV0cOEhIT5qLFW
 hbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240455; x=1726845255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+L6IQ+Q7ldy91T7HLv/CH8gFnEYSNt707sBQNeOJj8=;
 b=CLQ8eZpCCHsi+yVaPd6yXLiVKSz5lyc5nftLShGU+/tGzD3YOOgixnTWsokR0pu97u
 BUCh768f/RfCjiV7ax4Ua8CfzbT/K1nEonzToVoQBDG8q5TsGtyY5w2SVT5mhuUJTnHp
 ZE7axP7fkg5ta8stZP0bjYbaCsBRicCi3ugUsKB57chnvpwtSO+b1vPUW5XVPUurkgii
 z1o++XfgnDixk1hvGM0HuyJ7TSZZrQPmVOzPCFxlcIOPzpBqvqN+3NtDQftrgI3W3iS8
 2AmuStjNjzw85KOuC4Mz7PwbQb/TFhrzOjPc+t90veonOrmHlausYvqzWv2qZHUb1MEk
 jJdg==
X-Gm-Message-State: AOJu0YwdNNTTTH2y0pqoEGIONxYh3inVe0Sd6bM4Q2chHmGH5BQCAo+B
 FVObVib+c44//dMsc+tdnLfA9nh5a90BfPp6NlgZKHf7TatesOI3o82Q5SCjIj/tSriXzs9Z3kB
 L
X-Google-Smtp-Source: AGHT+IGGUMFvkb8h33R3c8wNQ33MUnVM74aXK5Oi4h3RPlBkWHc8V+by3VYQ/+r5NYAhBova+Dvtgw==
X-Received: by 2002:adf:f94f:0:b0:371:8e0d:c1d9 with SMTP id
 ffacd0b85a97d-378c2d07281mr4151089f8f.19.1726240454951; 
 Fri, 13 Sep 2024 08:14:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/27] hw: Remove device_class_set_parent_reset()
Date: Fri, 13 Sep 2024 16:13:48 +0100
Message-Id: <20240913151411.2167922-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

There are no callers of device_class_set_parent_reset() left in the tree,
as they've all been converted to use three-phase reset and the
corresponding resettable_class_set_parent_phases() function.
Remove device_class_set_parent_reset().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240830145812.1967042-5-peter.maydell@linaro.org
---
 include/hw/qdev-core.h | 16 ----------------
 hw/core/qdev.c         |  8 --------
 2 files changed, 24 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 77bfcbdf732..18c7845ce9b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -937,22 +937,6 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
  */
 void device_class_set_props(DeviceClass *dc, Property *props);
 
-/**
- * device_class_set_parent_reset() - legacy set device reset handlers
- * @dc: device class
- * @dev_reset: function pointer to reset handler
- * @parent_reset: function pointer to parents reset handler
- *
- * Modern code should use the ResettableClass interface to
- * implement a multi-phase reset instead.
- *
- * TODO: remove the function when DeviceClass's reset method
- * is not used anymore.
- */
-void device_class_set_parent_reset(DeviceClass *dc,
-                                   DeviceReset dev_reset,
-                                   DeviceReset *parent_reset);
-
 /**
  * device_class_set_parent_realize() - set up for chaining realize fns
  * @dc: The device class
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f3a996f57de..cf811580621 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -844,14 +844,6 @@ static void device_class_init(ObjectClass *class, void *data)
                                    offsetof(DeviceState, parent_bus), NULL, 0);
 }
 
-void device_class_set_parent_reset(DeviceClass *dc,
-                                   DeviceReset dev_reset,
-                                   DeviceReset *parent_reset)
-{
-    *parent_reset = dc->reset;
-    dc->reset = dev_reset;
-}
-
 void device_class_set_parent_realize(DeviceClass *dc,
                                      DeviceRealize dev_realize,
                                      DeviceRealize *parent_realize)
-- 
2.34.1


