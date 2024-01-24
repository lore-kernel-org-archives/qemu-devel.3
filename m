Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CFBC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 12:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rScqd-0005cI-FY; Wed, 24 Jan 2024 07:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rScqT-0005bi-O0
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:59:11 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rScqO-0001YA-Qr
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 07:59:07 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55a539d205aso6039956a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 04:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706101142; x=1706705942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ky1aJaUJNEhbMbR/ZG8KyIEcpQ/buonMXMlpQ6PnNp0=;
 b=JuVSSpD0USzfQ6OW4/sctX2+XrmxYrwR5o4XJtxE4IVKD++bN/HCjlMYiG09GyrBeI
 VMkfSRfjgT3JvDidKBx0C68tFXT9Q4c7zmTtsblVk/nVbGDCO7kYrIe41GEs/BooB3Kd
 7fIUCO6TCu4fkXHSC8SmB89vPLA7V26b+Su0qdjD4auKyGPUGbM/ev+cedWGsdPEBeko
 actsHKYvyx3m/Om4vHsOKLRpcxg5Yx+5MxyGzPQJOa0Nn8T2hn4VdCPQj3HdImlqS2wL
 STKFSwBV9L6io83+xGso3zU7ehlxyg9ujLV71NWa+gYiiFxIlNDAInqGq7n5SJOLIRa+
 aLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706101142; x=1706705942;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ky1aJaUJNEhbMbR/ZG8KyIEcpQ/buonMXMlpQ6PnNp0=;
 b=qF7TgqyrSmhyDYYTG37Zm4/XthAftqnfTc6JSE/MxU107w4u7Db5fn4Q639M5nghbF
 M9tpj+mgN+RSTSZda7r0HBZR5bmzhuf303/YzCVMaaIxXyaIoflLSPku/3QhtKRJ8D2T
 O1naqLOka2n62+VHw68oEw9yxG0/SRD6PrgNH0aHfVOQzdsbVosC0h+l4Cg1W/MV8Xhh
 ccnXp2S0LueMIBYSc2TJXn+grQAE1vuC7vqo6Vua4CjOPCjq06e1szNXNYPQH6dKmYy9
 uDm8VYKWYnd8F2cvOKaMYnULWbE+TfKOV1ftem+aDoz6BKc9QG4avQ0IZj5U7WSSeOf1
 Dd1w==
X-Gm-Message-State: AOJu0Yz8YKNBDb67XAn5Dh9IYllaHZ0XchbcfKwERNHzrk6uDoDY66eC
 3GHb00fmv4iuqZNL3XNS5Bp25ZCCn9QG/4POlieJG2xvXxmeI2CjYYLX7L4WXvI=
X-Google-Smtp-Source: AGHT+IG1viI62uufaXLqJkT6SePAsqjZzR1K2zWHOakNlB9ZarnziwRMRETTiwe0PhOfdgDUXLn3YQ==
X-Received: by 2002:aa7:c3c7:0:b0:559:f5a7:1688 with SMTP id
 l7-20020aa7c3c7000000b00559f5a71688mr1696227edr.72.1706101142157; 
 Wed, 24 Jan 2024 04:59:02 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 d6-20020a056402000600b0055c5ee666b3sm2632114edu.92.2024.01.24.04.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 04:59:01 -0800 (PST)
Message-ID: <7982b791-3333-473a-b42b-fbcf21f153cb@linaro.org>
Date: Wed, 24 Jan 2024 13:58:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/i386/host-cpu: Use iommu phys_bits with VFIO
 assigned devices on Intel h/w
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Yanghang Liu <yanghliu@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
References: <20240118192049.1796763-1-vivek.kasireddy@intel.com>
 <9462383d-3e42-460e-b721-8371d35e29a6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9462383d-3e42-460e-b721-8371d35e29a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 24/1/24 12:53, Cédric Le Goater wrote:
> On 1/18/24 20:20, Vivek Kasireddy wrote:
>> Recent updates in OVMF and Seabios have resulted in MMIO regions
>> being placed at the upper end of the physical address space. As a
>> result, when a Host device is assigned to the Guest via VFIO, the
>> following mapping failures occur when VFIO tries to map the MMIO
>> regions of the device:
>> VFIO_MAP_DMA failed: Invalid argument
>> vfio_dma_map(0x557b2f2736d0, 0x380000000000, 0x1000000, 
>> 0x7f98ac400000) = -22 (Invalid argument)
>>
>> The above failures are mainly seen on some Intel platforms where
>> the physical address width is larger than the Host's IOMMU
>> address width. In these cases, VFIO fails to map the MMIO regions
>> because the IOVAs would be larger than the IOMMU aperture regions.
>>
>> Therefore, one way to solve this problem would be to ensure that
>> cpu->phys_bits = <IOMMU phys_bits>
>> This can be done by parsing the IOMMU caps value from sysfs and
>> extracting the address width and using it to override the
>> phys_bits value as shown in this patch.
>>
>> Previous attempt at solving this issue in OVMF:
>> https://edk2.groups.io/g/devel/topic/102359124
>>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Cédric Le Goater <clg@redhat.com>
>> Cc: Laszlo Ersek <lersek@redhat.com>
>> Cc: Dongwon Kim <dongwon.kim@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> Tested-by: Yanghang Liu <yanghliu@redhat.com>
>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>
>> ---
>> v2:
>> - Replace the term passthrough with assigned (Laszlo)
>> - Update the commit message to note that both OVMF and Seabios
>>    guests are affected (Cédric)
>> - Update the subject to indicate what is done in the patch
>> ---
>>   target/i386/host-cpu.c | 61 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 60 insertions(+), 1 deletion(-)


>> +static int intel_iommu_check(void *opaque, QemuOpts *opts, Error **errp)
>> +{
>> +    g_autofree char *dev_path = NULL, *iommu_path = NULL, *caps = NULL;
>> +    const char *driver = qemu_opt_get(opts, "driver");
>> +    const char *device = qemu_opt_get(opts, "host");
>> +    uint32_t *iommu_phys_bits = opaque;
>> +    struct stat st;
>> +    uint64_t iommu_caps;
>> +
>> +    /*
>> +     * Check if the user requested VFIO device assignment. We don't have
>> +     * to limit phys_bits if there are no valid assigned devices.
>> +     */
>> +    if (g_strcmp0(driver, "vfio-pci") || !device) {
>> +        return 0;
>> +    }
>> +
>> +    dev_path = g_strdup_printf("/sys/bus/pci/devices/%s", device);
>> +    if (stat(dev_path, &st) < 0) {
>> +        return 0;
>> +    }
>> +
>> +    iommu_path = g_strdup_printf("%s/iommu/intel-iommu/cap", dev_path);
>> +    if (stat(iommu_path, &st) < 0) {
>> +        return 0;
>> +    }
>> +
>> +    if (g_file_get_contents(iommu_path, &caps, NULL, NULL)) {
>> +        if (sscanf(caps, "%lx", &iommu_caps) != 1) {
> 
> nit. This should use a PRIx64 define.
> 
>> +            return 0;
>> +        }
>> +        *iommu_phys_bits = ((iommu_caps >> 16) & 0x3f) + 1;
> 
> Please use 0x3fULL

or:

            *iommu_phys_bits = 1 + extract32(iommu_caps, 16, 6);

> and this could be a macro in 
> include/hw/i386/intel_iommu.h
> 
> Thanks,
> 
> C.


