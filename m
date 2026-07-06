Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92FEC44502
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 23:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgsJF-0001PT-2T; Mon, 06 Jul 2026 19:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rDNMagYKCp0QFQRPODLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--titusr.bounces.google.com>)
 id 1wgsJD-0001Op-Nm
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:03 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rDNMagYKCp0QFQRPODLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--titusr.bounces.google.com>)
 id 1wgsJC-00073H-Ah
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 19:01:03 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c894391f000so8880887a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 16:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783378861; x=1783983661; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J+qpsqU8VhBrKTgqKD73tYWfvmDVFPfz1aysCbRxf74=;
 b=IRDA5c2saCCeTkgQ3qS8lb8oZmmy1LAwCV9YaZF8tqZB5wF/IgfKaVmGwwv/DlJOpW
 Y2O9siG0iJtAs0VYLux2/cDHMH2GXwwqZ8RMxCyQ2MStfIPRzZ+KLP2RlGzkDFtwC0XT
 XP9u9sGm0F2g2pcpAg29BqJOuD3n8bacgSC9efPBYxbpz7Qqd8sq3Oj4rWooE7mtCtTx
 G8QMQr23eND2CvNs6T8FtgRJtkATMKbi4A86JzmVRutUGs+goLB8yP3m/tVC/gCS3SpX
 LyAOAW52NAXcgXViHo4VwQcReofJRt80DEjMYGb/La8ZOVUp1qZNJJZu2j9pVbVtndpP
 ra8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783378861; x=1783983661;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J+qpsqU8VhBrKTgqKD73tYWfvmDVFPfz1aysCbRxf74=;
 b=lG+iy9+l2wQhoYNqY7/gvl4xjssu7bzrWrRqG1I3HnvKkXFhNCY6UcWhAtwKqrqOgi
 ISqHj9pKgBTJbZ74eIP+FADXdhaZ585wURh0bTmnyU2l072ZFirbbOSjCBvj2r9o3c51
 MLQ2ZvXV/iOlsM9Xq5TEzhiZtA4+xfsIkKnqDj0sGrwU4oBA6PyTszloVy4vn89QEA95
 ed9m6mXwcrldsVt8J+HW8/p7j8fZ7OVletgDAcD1MLZ3BsVKEqYg7SkXGlicIuHHE0nn
 4q0Vh+RJAZayO/L708NJH6p8+Gzt0dQz/JWZvvH/EyimaVG7J6VQXV7sHlOw1X2m57qw
 shnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCf3LAeNm7jythiQuUYztwL62Bzq3nnt3XiVAMRpO6h91ta5N6bppQFZ1c1X3C3o3XoHVTcAsbQTwb@nongnu.org
X-Gm-Message-State: AOJu0YxEK3axooJ19xDjArR8W7/QHJMzgsnYUC57PPWPcVp8+sdOZOG+
 vmVRBuM0DAwzCqU0AqTI+MBdg1IEATNqkVjMeT5gO+3USpy/qTtdCK/cGktNytPQ7YWcAC6Q+8h
 yV9hIMA==
X-Received: from dlbqy20.prod.google.com
 ([2002:a05:7022:ef14:b0:139:ad69:296f])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:684:b0:3b5:6b5a:4f29
 with SMTP id adf61e73a8af0-3c08ee38980mr2865681637.30.1783378860644; Mon, 06
 Jul 2026 16:01:00 -0700 (PDT)
Date: Mon,  6 Jul 2026 23:00:50 +0000
In-Reply-To: <20260706230056.1888992-1-titusr@google.com>
Mime-Version: 1.0
References: <20260706230056.1888992-1-titusr@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260706230056.1888992-2-titusr@google.com>
Subject: [PATCH 1/5] osdep: add DIV_ROUND_CLOSEST
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3rDNMagYKCp0QFQRPODLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--titusr.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is taken from linux/include/uapi/linux/const.h to match the driver
behaviour when reading sensor values.

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 include/qemu/osdep.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1ec5b42230..a6a40ab8df 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -522,6 +522,20 @@ void QEMU_ERROR("code path is reachable")
 #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #endif
 
+#ifndef DIV_ROUND_CLOSEST
+#define DIV_ROUND_CLOSEST(n, d) \
+({ \
+    typeof(n) __n = n; \
+    typeof(d) __d = d; \
+    (((typeof(n))-1) > 0 || \
+     ((typeof(d))-1) > 0 || \
+     (((__n) > 0) == ((__d) > 0))) ? \
+        (((__n) + ((__d) / 2)) / (__d)) : \
+        (((__n) - ((__d) / 2)) / (__d)); \
+})
+#endif
+
+
 /*
  * &(x)[0] is always a pointer - if it's same type as x then the argument is a
  * pointer, not an array.
-- 
2.55.0.rc2.803.g1fd1e6609c-goog


