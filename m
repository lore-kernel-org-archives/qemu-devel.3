Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41F8C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSdc-00026k-G0; Tue, 20 Feb 2024 11:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdb-00024v-5N
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:31 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdZ-0005F5-8c
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:30 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d247c31e1aso11086971fa.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708445187; x=1709049987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6eEhRf5RLTQy0GPZo/ROl5SoGHEpglCPsB5KIAdpHko=;
 b=iUJQQq00zo4oqxdp9VrlBNa2jQvbD0wkbfzIXNUCYCqLre5TuGcdM15+cPBoUMUmuY
 A8gYeMyc2bixHOD4CjttYCEhdA/OIEhXqqacWD3hR4y7IqhGz3LGnXBHY/cdVUtgXZ0R
 U0OVCSB7edOQP82oZEzhkGVW/JNyz5OjWq60xbGf3/wcgHv3G4HUeDH5mv8YfaCdHtkE
 jPv/Ja82Sb07dTHSwcqS158nVA7nma10kIx4FbHmNvrRpfHB2DEGvOdoU2XzcaGP9MIz
 ZS/AK91oUMDdjzqRBD5i5xiW0arVknT/MBXZsIBiRUHEygX41npUG8N0a+XatlW7AshJ
 9BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708445187; x=1709049987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6eEhRf5RLTQy0GPZo/ROl5SoGHEpglCPsB5KIAdpHko=;
 b=iQoPBCYGU8V8f7Y88qBj4pDbz1qKZqoWDKzi0HtIROiBPXUpT+CFX3a9nstZ5DjWU6
 jdQvC+xnIRA0lD4Xb4Op5m6bU943SO0u6klneQhjUtobNymKIuj3Wof5xSKKp75w4yhF
 qaw+L/Jv9CnzNJ/CObrS9R9TO9PRwCrQl+DEh4qo3P2V9LMsT+6/eK8XcEV0rUDyXmvx
 ElTdkEfQoN9OinYnOmnC2nUbpRdpJGsegdhH8DNNPHW/wU8B27GD20EhY8R4YtiWz4aj
 zvtB48gGy1brjXXQXD2nA2AfjDjKPC/u4LC3FqCMqbRU2hwQt9vC8WL+1NMYP/I5mDmt
 /5Rg==
X-Gm-Message-State: AOJu0YxRKzkzwS6dar3O2/ENstQljRSoEKmDNU0Gd53rbcKdC/eElfwh
 xdNmVkXWZeq37fp97ASKQjGppdt9FNAtV9YzuppNB6dMRYob2YgsLQLLz4hUSX/aEpTvJynI2de
 M
X-Google-Smtp-Source: AGHT+IHwbQ9Hn11Sq+J07tdJD8fw914RMFtsVXd5msWZGyp8lT7DUIy6GIm0djo5y9A6PIT6m5j+EQ==
X-Received: by 2002:a2e:b165:0:b0:2d2:3ec0:29dd with SMTP id
 a5-20020a2eb165000000b002d23ec029ddmr3254741ljm.39.1708445187580; 
 Tue, 20 Feb 2024 08:06:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c4e8800b0040f0219c371sm15299927wmq.19.2024.02.20.08.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 08:06:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH 05/10] hw/core: Add documentation and license comments to
 reset.h
Date: Tue, 20 Feb 2024 16:06:17 +0000
Message-Id: <20240220160622.114437-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160622.114437-1-peter.maydell@linaro.org>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

Add the usual boilerplate license/copyright comment to reset.h (using
the text from reset.c), and document the existing functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/sysemu/reset.h | 79 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
index 609e4d50c26..6aa11846a69 100644
--- a/include/sysemu/reset.h
+++ b/include/sysemu/reset.h
@@ -1,3 +1,29 @@
+/*
+ *  Reset handlers.
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2016 Red Hat, Inc.
+ * Copyright (c) 2024 Linaro, Ltd.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
 #ifndef QEMU_SYSEMU_RESET_H
 #define QEMU_SYSEMU_RESET_H
 
@@ -5,9 +31,62 @@
 
 typedef void QEMUResetHandler(void *opaque);
 
+/**
+ * qemu_register_reset: Register a callback for system reset
+ * @func: function to call
+ * @opaque: opaque data to pass to @func
+ *
+ * Register @func on the list of functions which are called when the
+ * entire system is reset. The functions are called in the order in
+ * which they are registered.
+ *
+ * In general this function should not be used in new code where possible;
+ * for instance device model reset is better accomplished using the
+ * methods on DeviceState.
+ *
+ * It is not permitted to register or unregister reset functions from
+ * within the @func callback.
+ *
+ * We assume that the caller holds the BQL.
+ */
 void qemu_register_reset(QEMUResetHandler *func, void *opaque);
+
+/**
+ * qemu_register_reset_nosnapshotload: Register a callback for system reset
+ * @func: function to call
+ * @opaque: opaque data to pass to @func
+ *
+ * This is the same as qemu_register_reset(), except that @func is
+ * not called if the reason that the system is being reset is to
+ * put it into a clean state prior to loading a snapshot (i.e. for
+ * SHUTDOWN_CAUSE_SNAPSHOT_LOAD).
+ */
 void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque);
+
+/**
+ * qemu_unregister_reset: Unregister a system reset callback
+ * @func: function registered with qemu_register_reset()
+ * @opaque: the same opaque data that was passed to qemu_register_reset()
+ *
+ * Undo the effects of a qemu_register_reset(). The @func and @opaque
+ * must both match the arguments originally used with qemu_register_reset().
+ *
+ * We assume that the caller holds the BQL.
+ */
 void qemu_unregister_reset(QEMUResetHandler *func, void *opaque);
+
+/**
+ * qemu_devices_reset: Perform a complete system reset
+ * @reason: reason for the reset
+ *
+ * This function performs the low-level work needed to do a complete reset
+ * of the system (calling all the callbacks registered with
+ * qemu_register_reset()). It should only be called by the code in a
+ * MachineClass reset method.
+ *
+ * If you want to trigger a system reset from, for instance, a device
+ * model, don't use this function. Use qemu_system_reset_request().
+ */
 void qemu_devices_reset(ShutdownCause reason);
 
 #endif
-- 
2.34.1


