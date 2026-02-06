Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6585EE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTh4-0001hb-FE; Fri, 06 Feb 2026 16:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfI-0006tZ-Q8
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:02 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfH-0002jt-8K
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:00 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-481188b7760so18854765e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414417; x=1771019217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVgFJOhS1I2J9+yXL0ZvkiFeEqlWKf+HWm9fxkPrcD4=;
 b=aFmqGIOi7op99qdNFP7PFAK7/YYUZ38Q/cbJioeGRInriKZ7bFfS0hZmHatXOUbE2k
 GhympdEV1gDp26vli+417ZlWewIxSUigF+zKOm1nhm8qGgrEOAlJZ2N55WJQz+VcFzXT
 utk1AZMld+tI2bUcnAGGz8FWI2JYfXOqKKTc8Uzijiwnd+VnwAamDnKUm92oCn++0zzp
 8BBgNlBreU+UxyxrsNXqB9YNJFyCFqo/hONf8pRZj96UImo99MUHZo4niBT3kZbrFX6w
 W+if+Jut4+0ud0k/uaPAJniVSqxACKt2xTXVttK1CHWhgXHdDT9QOhl5h6eKmBuOrLxP
 CxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414417; x=1771019217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FVgFJOhS1I2J9+yXL0ZvkiFeEqlWKf+HWm9fxkPrcD4=;
 b=LCnyOQk+VKs8Yq0DjVnfAz+N1GfuO3agAzTMYjM3eyWEm5FJQ3uU3fU6QYwYYjovvf
 heOZTxF0VgnccCuC7HfhFbBdJ6GIQSpx+iBts2nwKMWEF5GIF5NVSCGyIajd2lrntfMr
 08hIGwC9c5eEXvmNohWI/6ZhYXZkQiQ53PsibvLlWF9rQ9AiKb87Z/KbSURI/VwuIhFl
 1Nwkq1YEwUgrLV0puDxGzSDzHhTdUJUB8ljFiJk0+uA9KRfMP9j+lB5p+AFZGvVqpIWb
 uRyC4ZkEkbzpgYEyQubUpsa1sTI+BUIeb7J7BaogVywJQnjomzLPDYLA9Fb67sFV6fw8
 4V+g==
X-Gm-Message-State: AOJu0YzU1XAE08a6AUlRa4efCACsofx70/238Ded2QbtNUREBWzHiMjJ
 fqes2dQPVfZaNapw47U/+LoN6UUVl6zYZ6ORkjJCiu0YiRELxrsNG9K8uaZc8h2WZvFtL9SN4e6
 OjseYOUA=
X-Gm-Gg: AZuq6aJLsm9zrjABAfT6XmX0MS8/TaRrGt1NzRZ2/sSzu2mXwpgdS7F/Rn29z+7iu0O
 JZj1FaEH3h3kkvlFT29nWFrWQyUiLXRwlZZf7zGoiCrQIYRc8g3131f58xNT3BefdvK12Lj6fGs
 u2tUoA0DEr/vilw3W++Vvs8h01Dm25esd4FG8PSmbn+cIerRQbCoNFPPgOwYJ4L/DSnBh5SWlE/
 fqqlrqP+E11P1kFUydPbedLGbvcRpyQ200YGhrF4kjbvmhgnOMhsF+/p5vHY5t1zG1UVpRbPRTZ
 Lq9nbWqpO0HQ7BTDcrg+sJFRwOLe5OZ9OZWUnCEOL2VQ+TOHr3Uqhm2NJRS12G7wBejdyMtDtxm
 uz0BTostTm/SjzywDNT6E5VTMmOGCDeoUEiXhw6/00qd4EKHO/YgvD5tG6+VeePkcZ7Onth51G8
 3BX6FccApJp/Ax1/dOvC69A5wcKKcT745O5gxk05iiRjyjMcldIjvvTI5Xgpqw
X-Received: by 2002:a05:600c:3492:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-483209339d2mr50883615e9.14.1770414417301; 
 Fri, 06 Feb 2026 13:46:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320736953sm73150645e9.15.2026.02.06.13.46.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:46:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 19/30] hw/intc: Mark x86-specific [IO]APIC peripherals as
 little-endian
Date: Fri,  6 Feb 2026 22:44:37 +0100
Message-ID: <20260206214448.22008-20-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These devices are only used by the x86 targets, which are
only built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
using DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260204204103.46343-3-philmd@linaro.org>
---
 hw/intc/apic.c   | 2 +-
 hw/intc/ioapic.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index dd8c77f8180..8766ed00b92 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -1108,7 +1108,7 @@ static const MemoryRegionOps apic_io_ops = {
     .impl.max_access_size = 4,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void apic_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 98de6ca8108..87ca1af5421 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -429,7 +429,7 @@ ioapic_mem_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps ioapic_io_ops = {
     .read = ioapic_mem_read,
     .write = ioapic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void ioapic_machine_done_notify(Notifier *notifier, void *data)
-- 
2.52.0


