Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD21C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNT0M-0007jv-Ru; Fri, 06 Jun 2025 05:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNT0E-0007jS-LU
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:04:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNT0A-0005VD-5C
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:04:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-452f9735424so935975e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 02:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749200676; x=1749805476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6hhGXg+T7BYRALCHwSeXr/D+ieUg7pS/EFy6Sw/FrVo=;
 b=FyWmtQU0oE4kgyLRFaxAXseZmAVHIrMhCGXduBY5fRgVvbtuXavUTvGS8hsERrV8Dn
 Z0edIpaattKrekygbTKoc42yBqHNSocCngvLWayll1dlZQgRaQ/Myy9YBmilhp4gyLRk
 4oK3OC3pT7hBIgdKHGO30uClZCS0UpYSTNHp6YWGI1lQk4J3KifrqAXUbs7POkjRAtky
 OKJfRtvL7W79lbkcH5ViNR5kd91BNr27SLJL029Qh7RR5nrGshATbFYdOqWcO1lAIF5A
 RFmKRjhFHIuNfCRdAEvpWXuV0JQEMDZOe4sA6cm1VMM0H6TwnOXMCaC/oj/Yu0D66wN9
 3KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749200676; x=1749805476;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6hhGXg+T7BYRALCHwSeXr/D+ieUg7pS/EFy6Sw/FrVo=;
 b=hBJ5vbxZ+kUi2SCkNNAfGKfGVc6nfu7Y5HO4KRmmuBiauxOJCU6fozOXvCDTliAu39
 s4KiFHbBLKPveQQIZfoT0DuY6khNjh38chz1QzzJKt255RNxr25UgwHy5SgS3QhjRaTh
 2GywwZ5wh+uDcoG6+jj6dAW4ozk13ZhkEkEcLSj/8sTmS4SsY3kOz5zZAL+Jz6VGNi8y
 kzpWR76Xo2jKDo89DWWT9oQPZhjKIpom2tW0Q8W6dR6zcWynB50TZSjdIYlSbjJNClmq
 mZ1cnG0ZoY1WJWqhaXqAs9VPCkQDmSvLocbclE0A3WYFrzUyYRJnn1ruYgNKFLkfocU9
 BAvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlgrgtfBSrTp//K3oOwtZVGegl+UilSdcU9vqCGOTFyWuXXCQLZsqasnQpV4JWWcan9l6EtpZ4o/LY@nongnu.org
X-Gm-Message-State: AOJu0YwtQibQR/XXt//Z0/lRdoG/5nk26dKt5Dguv62OyDLlYkbWkaKa
 xg6cB/ib3LKLwZCngwFdynoZC82uIAQC5/OlSGYcDz0oAxi9cidhIl3TzpO5TdtYEDM=
X-Gm-Gg: ASbGnctJ7T06zIKvKjl177STMk6rJvE09U3EN8Uq+FZAO9js1AM2CzKFNSEfFsB0xK1
 MyI3Om5Cej1onMFSRIRWURHCyIKhQCF/xKU53ew3+v0ctNxaHv2C1IaiFcjmIWWWdy8yT8FTFz7
 4CYW/bkmhwPElxawi3OjUdKV5ndP5LQBk+shcADOncMaO76fYrXl+eiRyI5/Bs1ACl9UUHhThJp
 McJJx+IzWAFLQ18J/eG474FZY+6QXWEVLvodPaBPZcr2Mt23JPd7NSsMvo7seL51svC4no6o4kt
 JLSv57pbBiwPOCT7sSQY2EYolcXFXgZHlnQK6SHh3BM8MgbyBwcev+vgbvKpxdRcmo0uIJvR7Vn
 PT9gh8cXE3YGqY8FZ160=
X-Google-Smtp-Source: AGHT+IHhz+60kOnFZ2a3NoO7q1a7W2ujCclp5x4Ov5AWzTXaDV1pDHSwz43uHE16s4va6AQJfzjiXw==
X-Received: by 2002:a05:6000:1a8f:b0:3a4:cfbf:51a0 with SMTP id
 ffacd0b85a97d-3a53189bc76mr2501402f8f.21.1749200675779; 
 Fri, 06 Jun 2025 02:04:35 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f8f12e16sm30616305e9.1.2025.06.06.02.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 02:04:35 -0700 (PDT)
Message-ID: <9b083ae2-3afb-43f4-8929-fc693b581a0d@linaro.org>
Date: Fri, 6 Jun 2025 11:04:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ramfb: Add property to control if load the romfile
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250606070234.2063451-1-shahuang@redhat.com>
 <aEKeNSc8mAZ8vhGj@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aEKeNSc8mAZ8vhGj@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 6/6/25 09:52, Daniel P. Berrangé wrote:
> On Fri, Jun 06, 2025 at 03:02:34AM -0400, Shaoqin Huang wrote:
>> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
>> the x86 need the vgabios-ramfb.bin, this can cause that when use the
>> release package on arm64 it can't find the vgabios-ramfb.bin.
>>
>> Because only seabios will use the vgabios-ramfb.bin, load the rom logic
>> is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
>> for ramfb, so they don't need to load the romfile.
>>
>> So add a new property use_legacy_x86_rom in both ramfb and vfio_pci
>> device, because the vfio display also use the ramfb_setup() to load
>> the vgabios-ramfb.bin file.
>>
>> After have this property, the machine type can set the compatibility to
>> not load the vgabios-ramfb.bin if the arch doesn't need it.
> 
> Can you make this a series, with an additional patch that updates the
> current in-dev machine types to use this new property, so we're clear
> about the proposed usage.
> 
>>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
>>   hw/display/ramfb-standalone.c | 4 +++-
>>   hw/display/ramfb-stubs.c      | 2 +-
>>   hw/display/ramfb.c            | 6 ++++--
>>   hw/vfio/display.c             | 4 ++--
>>   hw/vfio/pci.c                 | 1 +
>>   hw/vfio/pci.h                 | 1 +
>>   include/hw/display/ramfb.h    | 2 +-
>>   7 files changed, 13 insertions(+), 7 deletions(-)


>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 7f1532fbed..4e4759c954 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3564,6 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>>   
>>   static const Property vfio_pci_dev_nohotplug_properties[] = {
>>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>> +    DEFINE_PROP_BOOL("use_legacy_x86_rom", VFIOPCIDevice, use_legacy_x86_rom, true),
>>       DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>>                               ON_OFF_AUTO_AUTO),
>>   };

Alternatively with target-info API:

-- >8 --
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 8c0f907673d..689f10625f8 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -12,6 +12,7 @@
   */

  #include "qemu/osdep.h"
+#include "qemu/target-info.h"
  #include "qapi/error.h"
  #include "hw/loader.h"
  #include "hw/display/ramfb.h"
@@ -147,7 +148,15 @@ RAMFBState *ramfb_setup(Error **errp)

      s = g_new0(RAMFBState, 1);

-    rom_add_vga("vgabios-ramfb.bin");
+    switch (target_system_arch()) {
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        rom_add_vga("vgabios-ramfb.bin");
+        break;
+    default:
+        break;
+    }
+
      fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
                               NULL, ramfb_fw_cfg_write, s,
                               &s->cfg, sizeof(s->cfg), false);
---

Recent work event introduces target_base_FOO() so that'd be:

-- >8 --
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 8c0f907673d..2aa3b309010 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -12,6 +12,7 @@
   */

  #include "qemu/osdep.h"
+#include "qemu/target-info.h"
  #include "qapi/error.h"
  #include "hw/loader.h"
  #include "hw/display/ramfb.h"
@@ -147,7 +148,10 @@ RAMFBState *ramfb_setup(Error **errp)

      s = g_new0(RAMFBState, 1);

-    rom_add_vga("vgabios-ramfb.bin");
+    if (target_base_x86()) {
+        rom_add_vga("vgabios-ramfb.bin");
+    }
+
      fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
                               NULL, ramfb_fw_cfg_write, s,
                               &s->cfg, sizeof(s->cfg), false);
---

Unfortunately I had to focus on more urgent stuff so this isn't
merged yet (besides I hurt a finger yesterday and am now typing
slower). I hope I'd be able to respin that next week.

