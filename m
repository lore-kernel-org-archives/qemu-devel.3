Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFB6CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6Yr-0002H4-MO; Tue, 26 Mar 2024 09:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp6Yo-0002GM-9x
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:09:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp6Yl-00076V-Cb
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:09:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41400a9844aso37200735e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711458584; x=1712063384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0LSC2LbQn66/CrjDJXLYir/DE+1vSCS6UQ5hjybI1Vg=;
 b=B5Doez2sxvf8LGvczasT5bfBguzavX1hT7wAAo+3ZYsZ3vF6h8JUlX1XF5fj+TvAC8
 AQxwrrX9Jq05vGjxl5gnsE5QLYIUppsSVfoB0x1JHHgrUXKh4M+KZo67VaLaEBVwVsOu
 UL7gKxjc+uXqFz2eCc/NKq1nNcRQW8XWwMHJZf+aTAhfMcrvM5XEC1x33dx9qX0uX+nl
 G0/zMDZuoUudSuiRiRRNEfjWoiQWnb9G7Vz2/GTlPk9F5KMXFSHgSfd9opEwA3z+b8fT
 /qUDbtK97z4FdeAQ87Q9VcLpyiaXyXKDSNnN80kdfPoRpRKAoNj/g+zE1ohs4h7OW7bV
 FUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711458584; x=1712063384;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0LSC2LbQn66/CrjDJXLYir/DE+1vSCS6UQ5hjybI1Vg=;
 b=uMtS8Pg4+VEooSKPIqaJlcwRiZvh+Az/XqbRvF+O9Dwf755geMuQ3VXaJO/hbtiNjs
 vVbfC/iO2yK1Bd1x3jWFU04l02D0l4zL5rNXSaJw3zHYSF4hcKtm557RU3sxMR9vah5U
 XaAFItXNO9r65Dvn2mUc0CwfIFekZ2Kess+/hozoKf+Crr7C6naPotP1ax/cnENbt4wn
 Z9V5QRw0oCG2vg/xs+nfXjCelbR4cMpWKmKiJLibnk4lYORgLZQTaIqTNmnbcLQP5Lk1
 I+Vw3HsBmC020LQuYctlCn7iajQQx3y8lGwLYz9sjPxkmr6t17oll6j1Pm8UpA2tNG4r
 Z4Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRTUUThZdr889fvKXNBtyXG7CjYtH4ko0KH+P/yMnUB5utTxwomXOSi6K8p1yYXn8eAVJw0BHW9ZaUBajtnnbI43Wya4E=
X-Gm-Message-State: AOJu0YyYsSKz+W9Bjice7G16iZshHXTlIDkDqDMsfFwsGl4GGlr/hdKw
 KrtEEeDNEPzjehyKVsnechYcO/V5UaPR6NP9W8lrOTL+N+S5dpgajIJlHASwp5o=
X-Google-Smtp-Source: AGHT+IHb/1iI5LxGQfN25P6NFALfXzEQbEqhKJSWMBdkEn5aIXMTUeOQFlh9Fnzk/pAzrACvvG+D7A==
X-Received: by 2002:a05:600c:3217:b0:414:6467:d8e9 with SMTP id
 r23-20020a05600c321700b004146467d8e9mr1341526wmp.17.1711458584531; 
 Tue, 26 Mar 2024 06:09:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 d37-20020a05600c4c2500b004140a6d52e9sm648578wmp.1.2024.03.26.06.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 06:09:44 -0700 (PDT)
Message-ID: <403a8e6f-b6ba-45e1-a406-0642b8d1eb93@linaro.org>
Date: Tue, 26 Mar 2024 14:09:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial for-9.0] smbios: add stub for
 smbios_get_table_legacy()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: anisinha@redhat.com, mst@redhat.com, laurent@vivier.eu,
 qemu-trivial@nongnu.org
References: <20240326122630.85989-1-imammedo@redhat.com>
 <2b158752-9a6d-4013-a9d1-bb380b31cbda@linaro.org>
In-Reply-To: <2b158752-9a6d-4013-a9d1-bb380b31cbda@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 26/3/24 13:44, Philippe Mathieu-Daudé wrote:
> On 26/3/24 13:26, Igor Mammedov wrote:
>> QEMU build fails with
>>    hw/i386/fw_cfg.c:74: undefined reference to `smbios_get_table_legacy'
>> when it's built with only 'microvm' enabled i.e. with config patch
>>     +++ b/configs/devices/i386-softmmu/default.mak
>>     @@ -26,7 +26,7 @@
>>
>>     # Boards:
>>     #
>>     -CONFIG_ISAPC=y
>>     -CONFIG_I440FX=y
>>     -CONFIG_Q35=y
>>     +CONFIG_ISAPC=n
>>     +CONFIG_I440FX=n
>>     +CONFIG_Q35=n
>>
>> it happens because I've fogotten/lost smbios_get_table_legacy() stub.
>>
>> Fix it by adding missing stub as Philippe suggested.
>>
>> Fixes: b42b0e4daaa5 "smbios: build legacy mode code only for 'pc' 
>> machine"
>> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
>> Singned-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>> Compile tested only.
>>
>> While it's fixing bug for off-tree usecase with non-upstream config,
>> it's trivial enough to go into 9.0 if time frame allows.
>> Benefit of it going into 9.0 is that folks who play with minimal builds
>> won't have to carry the patch in their tree.
>>
>>
>>   hw/smbios/smbios_legacy_stub.c | 5 +++++
>>   1 file changed, 5 insertions(+)
> 
> Thanks, patch queued.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

BTW I tested using the following patch:

-- >8 --
commit 8be7b26b430d3ab192a2d22215ee512072bd88fb
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Tue Mar 26 13:52:17 2024 +0100

     hw/i386: Add a config to only build the microvm machine

     Add a config file to build a binary only containing the
     microvm machine.

     As suggested in commit d1d5e9eefd ("configure: allow the
     selection of alternate config in the build"), it can be
     built using:

       $ ../configure --without-default-features \
                      --target-list=x86_64-softmmu \
                      --with-devices-x86_64=microvm

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/configs/devices/x86_64-softmmu/microvm.mak 
b/configs/devices/x86_64-softmmu/microvm.mak
new file mode 100644
index 0000000000..fe48b5b4a7
--- /dev/null
+++ b/configs/devices/x86_64-softmmu/microvm.mak
@@ -0,0 +1,20 @@
+# SPDX-FileCopyrightText: 2024 Linaro Ltd.
+#
+# Config that only supports the 64-bit microvm machine.
+# This avoids bringing in any of numerous legacy features from
+# the legacy machines or the 32bit platform.
+#
+
+CONFIG_MICROVM=y
+CONFIG_PCI_DEVICES=n
+CONFIG_SMBIOS=y
+CONFIG_SMBIOS_LEGACY=n
+CONFIG_VIRTIO_BALLOON=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_VIRTIO_CRYPTO=y
+CONFIG_VIRTIO_GPU=y
+CONFIG_VIRTIO_INPUT=y
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_RNG=y
+CONFIG_VIRTIO_SCSI=y
+CONFIG_VIRTIO_SERIAL=y
---

Before:

Undefined symbols for architecture arm64:
   "_smbios_get_table_legacy", referenced from:
       _fw_cfg_build_smbios in hw_i386_fw_cfg.c.o
ld: symbol(s) not found for architecture arm64

After:

$ ./qemu-system-x86_64 -S -monitor stdio -M microvm
QEMU 8.2.90 monitor - type 'help' for more information
(qemu) info qom-tree
/machine (microvm-machine)
...

