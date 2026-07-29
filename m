Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0171CC54FCD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDT2-0007CW-2i; Wed, 29 Jul 2026 19:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HolqagYKCjUkZkljiXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--titusr.bounces.google.com>)
 id 1wpDT0-0007Aj-7o
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:38 -0400
Received: from mail-pj1-x1047.google.com ([2607:f8b0:4864:20::1047])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HolqagYKCjUkZkljiXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--titusr.bounces.google.com>)
 id 1wpDSy-0007J5-Pt
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:37 -0400
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so2520428a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785366815; x=1785971615; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JVD11tqubf/ZoFd0+u8pfU9HDmID5aXBVmA5l13Z7RI=;
 b=HsBunJsYifMjzgbuPZoYXslbsRwsdswRy5m6V6TPzbtVU/xZJNz9t10rbz9G7X2Yqo
 RLKauQN6cIkMUbHsBPgqe9z8OalvKE3W2MLjqF/Accuxv0zWqXoRnaae+q6JqkE7c+gs
 h/Dkm02GqKB2SdtpJOqCFQnRA4EzZ/JVyCrHZFRtGbR3g6pCFE/hQy+bnl5K8oiivHBr
 ZYxYqBol4Y2AyC7vOmhjPsfUFYpDz9C6wJJfic7SJharcUdntom8YD7NNi3dXuIbsFV+
 TkgJzQImr3XwR02HxDD2K0R8g64pL3xfPENsMPoESESC5tmKQcANvphYQxplzcdsAzAc
 q8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785366815; x=1785971615;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JVD11tqubf/ZoFd0+u8pfU9HDmID5aXBVmA5l13Z7RI=;
 b=REZkiX8RLKfxk0dz4OOZ9sQ4qNwPwmI0kcXqq/kvL7VgIT3r3NcLzyhR+Ezu4dy5fy
 5pXUI4NVPfHthZSPktv7JepuX+YqW/BzJ4zJGJJK+WLMH4I0Vu2JvST/63YYDsFva2xw
 m9teX7IAObHspgES4+5AU+6P73Jwb5G1woEx9vkNZYMbFqoOtKPiVbGG+xORR7TP+8Z5
 Fiw4PRQANu4fPfyosIGXNvvn0LYuZBDeJEdYa4y9OLsaqu1TE+ji8TMpyzKYyrUGF7HQ
 gtw8bXShdRA0jDqC2HGEEkfIfNF7EpeDFaQ/uHxUfLRQoONeiKP+OYiBnkNqtz84D2Mk
 ZLlw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPlEi7dLeoP5oio++NuV7HGi01cUw82T7kT2W0PzGU6xmns1RtnglSZTGGoXOzUJHx4IfpjTaYWKC7@nongnu.org
X-Gm-Message-State: AOJu0YzPSYFSuP7LkUaJ7xV+oIw/j4ZG2lzp0o1bmuY+Frl99ZvaJ7lY
 iCWvTUzmX2wd/zPNhLeuTGxAxoFo9Y5D1zrqxoG1iXnLxp/Tx4JdA+OGUc/35wFIndBqWFhpd09
 uQ7721A==
X-Received: from dybih50.prod.google.com
 ([2002:a05:7301:30b2:b0:314:3eac:8ca1])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b84:b0:38f:5801:dc0e
 with SMTP id 98e67ed59e1d1-38f9bd8723dmr202745a91.15.1785366814582; Wed, 29
 Jul 2026 16:13:34 -0700 (PDT)
Date: Wed, 29 Jul 2026 23:13:21 +0000
In-Reply-To: <20260729231325.3808993-1-titusr@google.com>
Mime-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260729231325.3808993-7-titusr@google.com>
Subject: [PATCH 6/8] hw/i2c: fix VOUT_MODE representation on little-endian
 machines
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1047;
 envelope-from=3HolqagYKCjUkZkljiXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--titusr.bounces.google.com;
 helo=mail-pj1-x1047.google.com
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

From: Jason Fan <fanjason@google.com>

Even though VOUT_MODE is only one byte, bitfields are allocated in the
order specific to the host's endianness.

Signed-off-by: Titus Rwantare <titusr@google.com>
Signed-off-by: Jason Fan <fanjason@google.com>
---
 include/hw/i2c/pmbus_device.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/i2c/pmbus_device.h b/include/hw/i2c/pmbus_device.h
index 9f3569e997..03b2c21c19 100644
--- a/include/hw/i2c/pmbus_device.h
+++ b/include/hw/i2c/pmbus_device.h
@@ -449,10 +449,17 @@ typedef struct PMBusCoefficients {
 /**
  * VOUT_Mode bit fields
  */
+#if HOST_BIG_ENDIAN
 typedef struct PMBusVoutMode {
     uint8_t  mode:3;
     int8_t   exp:5;
 } PMBusVoutMode;
+# else
+typedef struct PMBusVoutMode {
+    int8_t   exp:5;
+    uint8_t  mode:3;
+} PMBusVoutMode;
+#endif
 
 /**
  * Convert sensor values to direct mode format
-- 
2.55.0.508.g3f0d502094-goog


