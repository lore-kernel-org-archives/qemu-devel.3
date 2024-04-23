Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAF8C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 18:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzKdU-0002Rs-Uh; Tue, 23 Apr 2024 14:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzKdT-0002Rf-Sv
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:12:55 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzKdR-0002XB-Gq
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:12:55 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-343e46ec237so5034334f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713895971; x=1714500771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j/1cY8OlY4Bv89987vSEJnH2sc0a0D0Nwvmdu8UpNwo=;
 b=hDQ1ANXZQU1yJCzTp6XHrXewcL9OlkRCiBue/jDRq1j81BZr/MJQ+t2NRgRMjTiSqL
 atlG1ICYiZfeIVTnGdLkyyp+BxOg1YtN9TrUdpNfMag25OJ9an1st3iNlC4DI2+QGf/b
 PHVuWKa9O3657c7By516ilzj97jexOrvNvCf+5YN/mX68Zj/ScP95CuEjErffSu4HO8Z
 8TeCPoKBr+rxEYXmUcuANSSPn0oKhEdJC0FcvMicEUF7V2HNrhNCMUz7pQhViGqTtyKW
 hEiN75x8hZt8/4Ja+rEw6Bjx7chy9JRf6g+7HTY2e8xx7Spr6r1mmsnbzaWKptjftHl8
 wm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713895971; x=1714500771;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j/1cY8OlY4Bv89987vSEJnH2sc0a0D0Nwvmdu8UpNwo=;
 b=najj1NLZcnucMAKxyc+av6HvIvtZOYdKIbPDWwfbSS3uGd+nTgpRTpIWVAJ/YSh5eK
 wlQEFyzTdvpOSXIF+d10b/MfBp3W9zDB9d5Y9C1g7aMTdL6aKwFktrlrT6Wlf2gL8QXN
 SzaRWU5gySZ+uSY3Wu6B5esfEbXclWHYklSSZRKA4MI5eDOodlZjKVOrc91yWc+AMrUE
 33nqpDwM+Rq46Twwb/EME727p3+HIzDfJioMoZmlcNvFb6U3dcW0nZGhIE+Yi2FoH7KB
 9Xo5+GutPSXxi5yDbFAD5rROB3V4C4nYiibTKtWPPdVYqyaUpo46h5miilAdIC93ABaz
 C0tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkDZHOQqX7hYvFsHFbBPsiFRuSjQxHlJsy3hbkV8oDuy+Wo76q0TUMhpg1R7CIAJskWe8BV1pkoOLDPy3pmsXiSqDVEqU=
X-Gm-Message-State: AOJu0YxI2UOD47CZzE2pLX0P5PzVuNAg8vM2dsbJCl2cM5JAjKx5yNir
 UQOiuowo+b9mdrKcVseCIu7IJ1hs5hc2WyS8HAEAZyfrQjUG1IoHvkV7fKItdk/FlNPOQ4vt4+D
 HxOw=
X-Google-Smtp-Source: AGHT+IHWbkjZf6qNNTx5eoxzsAJFBasfagnY8SJCMYeFsRa8gCKyxYv3uYqIV/hJs9SMfmLDjavI1A==
X-Received: by 2002:adf:ef88:0:b0:343:dc46:bb4b with SMTP id
 d8-20020adfef88000000b00343dc46bb4bmr9571946wro.59.1713895971408; 
 Tue, 23 Apr 2024 11:12:51 -0700 (PDT)
Received: from [192.168.1.102] (pas38-h02-176-184-5-107.dsl.sta.abo.bbox.fr.
 [176.184.5.107]) by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c511400b0041a49b10a13sm8763736wms.11.2024.04.23.11.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 11:12:50 -0700 (PDT)
Message-ID: <f37f5b29-256b-4549-90d0-0f41da7788d0@linaro.org>
Date: Tue, 23 Apr 2024 20:12:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] arm: switch boards to "default y"
To: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-4-pbonzini@redhat.com> <87mspkhs8d.fsf@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87mspkhs8d.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi Fabiano,

On 23/4/24 20:02, Fabiano Rosas wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> For ARM targets, boards that require TCG are already using "default y".
>> Switch ARM_VIRT to the same selection mechanism.
>>
>> No changes to generated config-devices.mak file.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   configs/devices/arm-softmmu/default.mak | 3 ++-
>>   hw/arm/Kconfig                          | 2 ++
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
>> index c1cfb3bcf75..31f77c20269 100644
>> --- a/configs/devices/arm-softmmu/default.mak
>> +++ b/configs/devices/arm-softmmu/default.mak
>> @@ -5,7 +5,8 @@
>>   # CONFIG_PCI_DEVICES=n
>>   # CONFIG_TEST_DEVICES=n
>>   
>> -CONFIG_ARM_VIRT=y
>> +# Boards are selected by default, uncomment to keep out of the build.
>> +# CONFIG_ARM_VIRT=n
>>   
>>   # These are selected by default when TCG is enabled, uncomment them to
>>   # keep out of the build.
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 893a7bff66b..1e7cd01087f 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -1,5 +1,7 @@
>>   config ARM_VIRT
>>       bool
>> +    default y
>> +    depends on ARM
>>       imply PCI_DEVICES
> 
> We lose pci.c when building --without-default-devices:
> 
> $ arch
> aarch64
> $ ../configure --target-list=aarch64-softmmu,arm-softmmu
> --disable-linux-user --without-default-devices
> $ make
> ...
> libqemu-aarch64-softmmu.fa.p/target_arm_kvm.c.o: in function `kvm_arch_fixup_msi_route':
> ../target/arm/kvm.c:1548: undefined reference to `pci_device_iommu_address_space'

IIRC QEMU isn't yet ready to be built with --without-default-devices
but without any machine, you need to explicit at least one. For
example you can use --with-devices-aarch64=minimal, or define a
config with only the Virt machine.

Regards,

Phil.

