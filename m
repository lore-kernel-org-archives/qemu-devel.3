Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F389C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUiau-0001bw-Rh; Tue, 30 Jan 2024 02:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUiaq-0001bT-HI
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:31:40 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUian-0001e3-9n
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:31:39 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so44378695e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706599895; x=1707204695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgLnLMEq9BFcqtf5TI/hMLCzDzOSMt8AP/+aiQsKg/o=;
 b=OoMWvkr9toayhbaEr2F7MUCb75qlJysVRM4mHe6vxoyKlbeS4lxLfleCyciOCgHfEq
 lc6U077Ij8LjpdA52IsBndhq/z/dnRhq4f79TklcWlPqYYwZYYM77Tm9jhAcrscvxXe0
 OuTNOFHA2T+KXyjnGT/fnfewzmfW7+nzuE6M0+rA4FRSFS6J1lj3nFi9mRzDRYLYKMAG
 5puGCdZl9iVpvXGljyIQbG3xwNiEvGl9NoEKQJqaQ1TAY7FocvawUk8Cz3F3VdUNHj5g
 SiUx8NZJTuNaUva+zPMxeECNj1H1UeFX5Ynr5qb91MmzEDyBIoraMe3k1EzX3QAO2t0s
 QktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706599895; x=1707204695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgLnLMEq9BFcqtf5TI/hMLCzDzOSMt8AP/+aiQsKg/o=;
 b=b+G+HfscPzEMuN+jX7teF5vg/yzbrznWDeLE8DeS92Q9jZmo/0WsvRan0gMuYxXfBZ
 BZmHc6azGa2nver0ygzHJbVNuNsT20FI/D9sUVueiJ2ntoIE867RCTwZhDaXHsm1Hrsj
 8jK+fh0glFE7/fi1fN/UlIH7gzc6GH4n9MouhL4qgmeSPrf3a1CRbHD6n7VI4YQQtvmb
 bpoCmgdYpi0HEqXjBrErVr0vxrdhNM/IRPENu3V/tvxXWmkrCUSCm4zW/nWR9OWVAQQe
 dUGa5HZV+ztCiWexWrpOenPUuvpoW3ukO5Nu7HtXWhgSMDBOb47BLi9AuvdQOeK0fCPp
 58Bg==
X-Gm-Message-State: AOJu0YxLXErNpnwTwf8nqjI+xp06v9mQ+a+H6nm0aOBhAwOErKOjZGH5
 TwKnL1gihWZ/lVZkHG7pD4bvzWCjDrW73Yp6oDzugw5YGnSDw8P8dDyjosy/fQ2kLdZRrcbfcM9
 H8cQ=
X-Google-Smtp-Source: AGHT+IFu00wcFIgTDRF3eEPpqgUDrT7NfWMf2WKqCZExcDbTxN49OpVjnuP25AgPpy2OXZho/Vj7Rg==
X-Received: by 2002:a05:600c:4c11:b0:40e:d4d1:2e0b with SMTP id
 d17-20020a05600c4c1100b0040ed4d12e0bmr7168103wmp.19.1706599895296; 
 Mon, 29 Jan 2024 23:31:35 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 bj26-20020a0560001e1a00b0033ae6530969sm7174070wrb.85.2024.01.29.23.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 23:31:35 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 1/2] hw/core/qdev.c: add qdev_get_human_name()
Date: Tue, 30 Jan 2024 09:30:31 +0200
Message-Id: <8b566bfced98ae44be1fcc1f8e7215f0c3393aa1.1706598705.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706598705.git.manos.pitsidianakis@linaro.org>
References: <cover.1706598705.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
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

Add a simple method to return some kind of human readable identifier for
use in error messages.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/qdev-core.h | 14 ++++++++++++++
 hw/core/qdev.c         |  8 ++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 151d968238..66338f479f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -993,6 +993,20 @@ const char *qdev_fw_name(DeviceState *dev);
 void qdev_assert_realized_properly(void);
 Object *qdev_get_machine(void);
 
+/**
+ * qdev_get_human_name() - Return a human-readable name for a device
+ * @dev: The device. Must be a valid and non-NULL pointer.
+ *
+ * .. note::
+ *    This function is intended for user friendly error messages.
+ *
+ * Returns: A newly allocated string containing the device id if not null,
+ * else the object canonical path.
+ *
+ * Use g_free() to free it.
+ */
+char *qdev_get_human_name(DeviceState *dev);
+
 /* FIXME: make this a link<> */
 bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 43d863b0c5..c68d0f7c51 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -879,6 +879,14 @@ Object *qdev_get_machine(void)
     return dev;
 }
 
+char *qdev_get_human_name(DeviceState *dev)
+{
+    g_assert(dev != NULL);
+
+    return dev->id ?
+           g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
+}
+
 static MachineInitPhase machine_phase;
 
 bool phase_check(MachineInitPhase phase)
-- 
γαῖα πυρί μιχθήτω


