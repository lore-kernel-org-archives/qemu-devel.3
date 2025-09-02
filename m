Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F046CCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQpl-0007g0-7y; Tue, 02 Sep 2025 09:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQpC-0007IW-NJ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQp7-0004mW-EK
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b9a856dc2so3420885e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818794; x=1757423594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JgIF6lWD9SRkfbI3l9bP2fZjIYaJ7QJ0dnxofnv7srk=;
 b=eey1Bxzx4c12DhxcqYUm8caRF7qmGM/qcI+bF+NWczk0W5fFeTCLXFHmAi5sY33/TI
 9uQdwE3aDVr4mmH8nDWvfCTqnYYGMWS4NHJ1xPScIljRb27NA/pDwPwqHiuvF7E3Zsv1
 v1scJqJw8rMQ8i1FVi1JxUlt23gumAWTfPH+VvBTdbzBowqTpWtmVXDu3mFxBjFtey52
 JFBbRGGv7L16mYzbXSCmtuSYyl6ZYOr4JITLgFQfZfq3bvk0jaz/yQ/ga2Mimtyi7jjw
 Zc9X+28JXfnJAtZ1hTGo7+28qf8izG1ud0Oz9W3Hf0RCWVjwX4GYx5d3fuGo06ndTqCX
 Poxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818794; x=1757423594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JgIF6lWD9SRkfbI3l9bP2fZjIYaJ7QJ0dnxofnv7srk=;
 b=c+YHgdzvwPh3HFxnCq2x2KZ/WPLHAbclgGfc5Z5fEC3V3vXamkGxlnlA8IVjiF9GE/
 J57kUJZEMfdVmvH1i2+mYD6ZU3X5nZRcUSwOQU8j+p0h2qYACe+UUMY0HlkJXkRt1lvs
 2pu2mYDofFSxxHqIEwrp/k//VQz19egNIhU8PVAgGKkMMC4njUafsP4X+DtWLsMR/hMC
 WFU0Q5ZiqQm+3YtiQ+9pOyxxWGrWVZLFpNJCfgqJE6eY1i1yxUKrfFy+8oRVXQ3eHnHr
 4FhraMCTNhx7WA9KkudgDBYIaeNcxXCpTLZnkp4yBFglP/vYNn0eD+t2DatcaH97FTwO
 1W1g==
X-Gm-Message-State: AOJu0YyUuXoRp+ssohU5IcbldY5DCZPgYpA6tV+y9nat92yNXnRvewuL
 raomZ40cKZcMZqSji7D+qBTcczQw773n7FpiPxbqNiwdh+ZEIYRI6x8br0gCICVo7hirb0yQU2s
 qFnC6
X-Gm-Gg: ASbGncuzSN9VEn08MtJG8j1AtHC1DNTp+pbDXEhoD3rjSDU/IsEumCnyCN0Nti5wsp1
 dVyAwTDNiy8CecZpmYKVKFTBiLG2F/1ruwddl0OLpSzh2TG46noMIfKx3fu35vto3FwoB3q1vbG
 bR34wJ+yncWOUAR1IeYbYGhBPqDDm/vYm4VygHTmURA1Wda3x1lNCOV9wuif2WF5aG2JE21VAyG
 9yXFJLYxDor8YjqBLaVG94X287iNsLkZrbxeYjclqGyVP6T60S6ilMlz1pmjur2cqijSJSLvDXf
 zeS+RfQ2W7E94Vi744lDUnSfYwwy/eSqEOMUuzYNg9ZVarfaN9ObaEUacYHEfHHZ4etdovavBqj
 TleBL0THEQUgOstDddy0FEaUGzMVzQP0gl2WiKQFxAZZVMnsLZ5LuTN4irED3LIyCL+F+rmYq
X-Google-Smtp-Source: AGHT+IEKcsERGuHhYgXzaMD6vVpzEucACECBhl8bu0ckF9aGvTBIpvjxzRe/4tV7DLd2iiH6vvJSLA==
X-Received: by 2002:a05:600c:4fcd:b0:459:e025:8c40 with SMTP id
 5b1f17b1804b1-45b85533712mr103587935e9.10.1756818793570; 
 Tue, 02 Sep 2025 06:13:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d60cf93cb2sm10701682f8f.12.2025.09.02.06.13.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:13:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/39] hw/arm/boot: Correctly free the MemoryDeviceInfoList
Date: Tue,  2 Sep 2025 15:10:15 +0200
Message-ID: <20250902131016.84968-39-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

When running the bios-tables-test under ASAN we see leaks like this:

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x5bc58579b00d in calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x250400d) (BuildId: 2e27b63dc9ac45f522ced40a17c2a60cc32f1d38)
    #1 0x7b4ad90337b1 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x637b1) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x5bc5861826db in qmp_memory_device_list /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/mem/memory-device.c:307:34
    #3 0x5bc587a9edb6 in arm_load_dtb /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/boot.c:656:15

Indirect leak of 28 byte(s) in 2 object(s) allocated from:
    #0 0x5bc58579ae23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x2503e23) (BuildId: 2e27b63dc9ac45f522ced40a17c2a60cc32f1d38)
    #1 0x7b4ad6c8f947 in __vasprintf_internal libio/vasprintf.c:116:16
    #2 0x7b4ad9080a52 in g_vasprintf (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xb0a52) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #3 0x7b4ad90515e4 in g_strdup_vprintf (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x815e4) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #4 0x7b4ad9051940 in g_strdup_printf (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x81940) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #5 0x5bc5885eb739 in object_get_canonical_path /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:2123:19
    #6 0x5bc58618dca8 in pc_dimm_md_fill_device_info /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/mem/pc-dimm.c:268:18
    #7 0x5bc586182792 in qmp_memory_device_list /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/mem/memory-device.c:310:9

This happens because we declared the MemoryDeviceInfoList *md_list
with g_autofree, which will free the direct memory with g_free() but
doesn't free all the other data structures referenced by it.  Instead
what we want is to declare the pointer with g_autoptr(), which will
automatically call the qapi_free_MemoryDeviceInfoList() cleanup
function when the variable goes out of scope.

Fixes: 36bc78aca83cfd ("hw/arm: add static NVDIMMs in device tree")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250901102214.3748011-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1e57c4ab9ee..d0840308f5a 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -549,7 +549,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     unsigned int i;
     hwaddr mem_base, mem_len;
     char **node_path;
-    g_autofree MemoryDeviceInfoList *md_list = NULL;
+    g_autoptr(MemoryDeviceInfoList) md_list = NULL;
     Error *err = NULL;
 
     if (binfo->dtb_filename) {
-- 
2.51.0


