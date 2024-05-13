Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F54AC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6VZK-00071N-1K; Mon, 13 May 2024 09:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6VZI-0006yu-0t
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:18:16 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6VZF-0003oj-J1
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:18:15 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51f4d2676d1so4680896e87.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715606289; x=1716211089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kPjgYgq2OJKi2+MpSVcM8/6vIKwKmBz6OcIcuKES9D4=;
 b=ZJHkzp4RF/3RUGXTNrZBTFfexpMK16s0T/VD3RYtRXNdyp9XRzxpHacE19+sdRRYpO
 3TF250/OyJ/EOM3ecMSwRujqZJoE6915o7mVgVgMtI1LgKSMeR8M32D0c7fydWKdMw8P
 LFHgaVXTMpfurqAubeynrLX4Ng2K+64lAzbXhCyK4P97DQiZxOVnBd5aJY0lBATQj8eW
 p9Jw0ZVLrWcPFrNem2A/P3Nalxcl4wiaGtctU0mfHIjnEVabk6MAhXe2Cmyv3Zyag071
 Y90TLTgAPa/Ji+mNsyMJ+y8FaWByM5QUAS86BrBgukuZF+rLWKQ39i9niM3apHXoF6YT
 tKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715606289; x=1716211089;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kPjgYgq2OJKi2+MpSVcM8/6vIKwKmBz6OcIcuKES9D4=;
 b=K6+aSpDyZ7bM6gVKGM7ImkAkG5VJXIufmqwS+X9KlMCh1r8BESt3VjF3gFs1eyZ6zv
 qCdFD/uk7IBiJJSermNjtsmwJjFPjgRnA2SAxhcKEyT79WWopM5dWj/4kdAqyDWH+CUM
 jhRt1TboIrrnOC1C0C2o0BbX3xsvCAZl4oe4kiQiTLIxYbaTD7G5sCPvZLiDTpx+WOGM
 y/nyqQIFFzj04eAU5OWjeRpyCd7VXM/6hqs3PIbbQm/IAxA5yv+rnvOXvNjiD4UIYCiI
 Q/y3yy+R4eRYjGTSMkhSNesg+kXMFXALJjI6GhMYQLw/TVJIKjrWTcMenaQR1x5HMeb/
 civA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe+l6tf+TAluOK8GHX0xZyRA12XxDuboF7nMUfeZ3Bn8r/0dN/QRhtwi6IWJs6xN9iDhLs6sPsyOXTMRylaotG6bNRlJE=
X-Gm-Message-State: AOJu0YzCl4vlEYuOhohp5US00mbR/jKWFh9PE0aGjBfGGZlEA2dI8VtA
 BOrW2GIvZSs9sU0MujlMg4CmNTluW3Rfu7pMb4c8ZShuDQpE05pDtL1AS8u1cfY=
X-Google-Smtp-Source: AGHT+IEmbQJ/GCAcDR+7HrtDxBpzEwKlvqLnJY7pc3yj/c4s2dlJM/qy/szuRs/tWG/axCagE+LYLQ==
X-Received: by 2002:ac2:4309:0:b0:518:bc7c:413a with SMTP id
 2adb3069b0e04-52210276505mr5149644e87.69.1715606289265; 
 Mon, 13 May 2024 06:18:09 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-522403ed95asm937750e87.57.2024.05.13.06.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 06:18:08 -0700 (PDT)
Message-ID: <96c088de-8144-4f37-81e5-f3b51d6c29be@linaro.org>
Date: Mon, 13 May 2024 15:18:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/22] hw/i386: Remove deprecated pc-i440fx-2.0 -> 2.3
 machines
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org
References: <20240416185939.37984-1-philmd@linaro.org>
 <6de106f2-1061-483e-97db-96b09e5b40ad@linaro.org>
Content-Language: en-US
In-Reply-To: <6de106f2-1061-483e-97db-96b09e5b40ad@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

ping^2

On 6/5/24 16:29, Philippe Mathieu-Daudé wrote:
> On 16/4/24 20:59, Philippe Mathieu-Daudé wrote:
>> Series fully reviewed.
> 
> Ping, is there some issue holding this series?
> 
>> Philippe Mathieu-Daudé (22):
>>    hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx machines
>>    hw/i386/pc: Remove deprecated pc-i440fx-2.0 machine
>>    hw/usb/hcd-xhci: Remove XHCI_FLAG_FORCE_PCIE_ENDCAP flag
>>    hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST flag
>>    hw/i386/acpi: Remove PCMachineClass::legacy_acpi_table_size
>>    hw/acpi/ich9: Remove 'memory-hotplug-support' property
>>    hw/acpi/ich9: Remove dead code related to 'acpi_memory_hotplug'
>>    hw/i386/pc: Remove deprecated pc-i440fx-2.1 machine
>>    target/i386/kvm: Remove x86_cpu_change_kvm_default() and 'kvm-cpu.h'
>>    hw/i386/pc: Remove PCMachineClass::smbios_uuid_encoded
>>    hw/smbios: Remove 'uuid_encoded' argument from smbios_set_defaults()
>>    hw/smbios: Remove 'smbios_uuid_encoded', simplify smbios_encode_uuid()
>>    hw/i386/pc: Remove PCMachineClass::enforce_aligned_dimm
>>    hw/mem/pc-dimm: Remove legacy_align argument from pc_dimm_pre_plug()
>>    hw/mem/memory-device: Remove legacy_align from
>>      memory_device_pre_plug()
>>    hw/i386/pc: Remove deprecated pc-i440fx-2.2 machine
>>    hw/i386/pc: Remove PCMachineClass::resizable_acpi_blob
>>    hw/i386/pc: Remove PCMachineClass::rsdp_in_ram
>>    hw/i386/acpi: Remove AcpiBuildState::rsdp field
>>    hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine
>>    target/i386: Remove X86CPU::kvm_no_smi_migration field
>>    hw/i386/pc: Replace PCMachineClass::acpi_data_size by
>>      PC_ACPI_DATA_SIZE


