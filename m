Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B83FC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMoet-0005i5-M0; Thu, 27 Jun 2024 08:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMoeq-0005gy-Td
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:55:25 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMoep-0002mb-3d
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:55:24 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52cdd03d6aaso5895162e87.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719492921; x=1720097721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5ZGOJcjQQnv11O06YDrcBPhgE2TlHoTxhTZZZdd1L2E=;
 b=cLAPHhHsTkdmK4qwp8I0spDRmAL/xl1ngJqq4iDpVHsai2LHDc+nJFpTnoi7QacIgY
 Svgq+kKBcpJnb8bUo5lCAJ4+kiA0V4QDG9xcBj5QURXn44dSBrNX8O9S0Wb9b4BPaESg
 5Pcwl5jdOrv3ZntwZAG3hIpsIKMvI/srxmSR2FrnyjuYRz9nIVjiI1RbJxeXFunbnZWI
 vSrwoq70CBufabF48D2woAmO+oyY5YdNCIcvkmJQCPhec7X3IeYgw4lpW0LsdNHv+Pos
 /LOOijijHKH4ncVUoyp8/eQldgt2ZE9kaaHisDnyzz+o3xQg/Gi+8xBz2NZA0eu6Xa5H
 zHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719492921; x=1720097721;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ZGOJcjQQnv11O06YDrcBPhgE2TlHoTxhTZZZdd1L2E=;
 b=apKOVIN/qsBkQMhV6WIgq/kmUN7s2Y74uis7kD9J8lSXM6TOUMa9xU6XbjF+wx8L74
 iXtTci2VN4Ggdwwp5rZJxZQFhVEmSJOwrGUn87WvWLqNSxkZ7GouTZGnZkIwaBqsmEe/
 yGvWWuqT5kDvmHI7cUpO5sVfgpEqZIbbOhN/6mh/U3SoT1yiIsziFzvnEna1UYDTo5M7
 u55sgJBMyIG09ufqtyha0Sz3AEgJNxpuFoFAl6j7u75lVhIR+wPi9rSHeVPr+X8AEYbu
 f1CpkTN7FyVqo/dsVsnWJZWeEzxxqjm8dAhliC0JW+NqD/lC3uPWr1sZnOdimMR9QFLB
 qSQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfy8csThfccwEwPYiiWR3BRngtcSGBoltayynffFMBZNSo9ybbpItscFr8bbSgCTgrlqBrBDc0kjMLlFmou8oBBmYdipk=
X-Gm-Message-State: AOJu0YwXVAbEyR0nSf/Nmljt/5LCiZvhj8cOcak4gsLExigZLH+bn5cW
 4gNgFZ1LVoh5kZf/eL6ssYCazZGGQM5EtyOfi6/PBR8V/rjcj52Klf+H+os84VfaIWH2FX11prG
 Y7bw=
X-Google-Smtp-Source: AGHT+IGU0wLJYwq+FfC9Ypm/h2xIulYPEpYZ01lsF7JXwBGHRbcAGyqvAaYRgduWUmOYjUNFc+UNBg==
X-Received: by 2002:a05:6512:3a8f:b0:52c:dfe0:9b1d with SMTP id
 2adb3069b0e04-52ce06734bbmr11445792e87.45.1719492920733; 
 Thu, 27 Jun 2024 05:55:20 -0700 (PDT)
Received: from [192.168.23.175] (72.red-95-127-32.staticip.rima-tde.net.
 [95.127.32.72]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8424554sm64737655e9.37.2024.06.27.05.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 05:55:20 -0700 (PDT)
Message-ID: <c90d62bc-7a48-4cd5-b8fa-42257327eff4@linaro.org>
Date: Thu, 27 Jun 2024 14:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/intc/loongson_ipi: Fix for LoongArch
To: gaosong <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, maobibo <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240627-ipi-fixes-v1-0-9b061dc28a3a@flygoat.com>
 <acc08621-19c1-4ec3-9fc9-acb0eec79121@linaro.org>
 <0e42f372-26b8-b94a-80bb-6403062d2f1a@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0e42f372-26b8-b94a-80bb-6403062d2f1a@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

On 27/6/24 14:13, gaosong wrote:
> 
> 
> 在 2024/6/27 下午2:38, Philippe Mathieu-Daudé 写道:
>> On 27/6/24 06:13, Jiaxun Yang wrote:
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>> Jiaxun Yang (2):
>>>        hw/intc/loongson_ipi: Gate MMIO regions creation with property
>>>        MAINTAINERS: Add myself as a reviewer of LoongArch virt machine
>>
>> Maybe s/has-mmio/use-mmio/? Otherwise series:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> Hi,
> 
> If we had done a simple test, we should have found the following 
> problem, but obviously we didn't .
> 
> root@loongson-KVM:~/work/code/clean/github/qemu# . /kernel.sh
> Unexpected error in object_property_find_err() at . /qom/object.c:1357.
> qemu-system-loongarch64: Property 'loongson_ipi.unnamed-gpio-out[0]' not 
> found
> . /kernel.sh: line 16: 117708 Aborted (core dumped) . 
> /build/qemu-system-loongarch64 -machine virt -m 8G -cpu la464 -smp 8 
> -kernel ~/vmlinux -initrd ramdisk -serial stdio -monitor 
> telnet:localhost. 4418,server,nowait -net nic -net user -device 
> virtio-gpu-pci -device nec-usb-xhci,id=xhci,addr=0x1b -device 
> usb-tablet,id=tablet,bus=xhci.0, port=1 -device 
> usb-tablet,id=tablet,bus=xhci.0, -device usb-tablet,id=tablet,bus=xhci. 
> port=1 -device usb-kbd,id=keyboard,bus=xhci.0,port=2 -append 
> "root=/dev/ram rdinit=/sbin/init console=ttyS0,115200 
> earlycon=uart,mmio. 0x1fe001e0" --nographic

Works for me squashing:

-- >8 --
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 6e92a50349..ce845aecda 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -305,18 +305,18 @@ static void loongson_ipi_realize(DeviceState *dev, 
Error **errp)
          return;
      }

-    if (s->has_mmio) {
-        for (i = 0; i < s->num_cpu; i++) {
-            s->cpu[i].ipi = s;
+    for (i = 0; i < s->num_cpu; i++) {
+        s->cpu[i].ipi = s;
+        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
+
+        if (s->has_mmio) {
+            g_autofree char *name = 
g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
              s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
-            g_autofree char *name =
-                        g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
              memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
                                    &loongson_ipi_core_ops, &s->cpu[i],
                                    name, 0x48);
              sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);

-            qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
          }
      }
  }
---

