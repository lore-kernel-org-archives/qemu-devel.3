Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07614C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWIC-0007V4-32; Tue, 18 Jun 2024 06:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWIA-0007Rt-PS
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:42:22 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWI8-00089t-RS
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:42:22 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57d044aa5beso145150a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718707339; x=1719312139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ujKr1R8LxYoII1Jt5CJPHmcW2p2NDcARd+2KGuNl+Ws=;
 b=eXqEjNe5h6CFpMrk6wnC5DdeMOFENS3qRkdAuK3puXEfLNssmI9A/BzqSo09eMNjlZ
 iM5Fm8in7/seemP3I97jckpsf5WOPTZu+M7tmQDZqV/wobMaQrUlRNJSH8a3Lhw07+oA
 NtrH1Mmmp1Xf7o0w9w1Vbn0UwL845Gp8cTFI4xkcL/WBHGZVuWiUyuNpaPGSVFTJRnYn
 KMX3PO3uaKuZE7EjZZWRI10HDFa3P6JAcuDfCQ9AJzVTRgMZ4rdX9pmYZls86UBU/kdw
 7Kpov8kMbB5XUrNA3D6wTYL0HbliTNIqZmImCqCTyoeh/w0CNX98FXDhfw4vDo8OHap6
 2E7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718707339; x=1719312139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ujKr1R8LxYoII1Jt5CJPHmcW2p2NDcARd+2KGuNl+Ws=;
 b=tpLRmNgaM5ZPrlj/nORsm59JtQnixNy51qsPapCvEC1kQB+jvbOpDumCmfFW3xMqBH
 d1sBQxY3oFvfMfvMWOstRxjRQZ4RjMY3O3tT0SKtq48ctKdlK68recpBepOhdB9RjpZm
 CieWW3ns/7z0M8GUhWUJRcyZxwXjzEScZsaVB4pTIwOJaFApeQHJ4CmBQp2XweyP+DFP
 werh2k4BC1wYva+6fjTo/LW6pDYaAFDFAxFJaM/rppGZUmOXq5a5DnknZNJkor6+t7f3
 p1FFnNVzIGRscKmZL5RQ19ZERM/QThtomKDwaxtMRiQ66CPUXHw5hQW8ssivoFFqTw0m
 Jjeg==
X-Gm-Message-State: AOJu0Yw1NPcZ85w3SVxCJVIoUJIEshyD5XDYMHJet09jFztba8pjmCeS
 kVaVfLJDCH1pRfQD9p6ftns7/3PTT+INyMhbpPCfhTdiVMotfswd63scusUBf7/s4DbPefgMFWD
 EQqk=
X-Google-Smtp-Source: AGHT+IEbA3F0Z3oXJ8eGNdsqadfYGaIlgzxT9dab3jW88G3JD+llfbpq1ok3IZ8+z43RrjMS6Xx7IA==
X-Received: by 2002:a50:8ac5:0:b0:57c:6adf:1035 with SMTP id
 4fb4d7f45d1cf-57cbd6a591emr7282130a12.27.1718707338855; 
 Tue, 18 Jun 2024 03:42:18 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72da6d0sm7508379a12.26.2024.06.18.03.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 03:42:18 -0700 (PDT)
Message-ID: <d8d090d3-a729-4257-9e92-2839f3c6e456@linaro.org>
Date: Tue, 18 Jun 2024 12:42:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/23] hw/i386: Remove deprecated pc-i440fx-2.0 -> 2.3
 machines
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240617071118.60464-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 17/6/24 09:10, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (23):
>    hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx machines
>    hw/i386/pc: Remove deprecated pc-i440fx-2.0 machine
>    hw/usb/hcd-xhci: Remove XHCI_FLAG_FORCE_PCIE_ENDCAP flag
>    hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST flag
>    hw/i386/acpi: Remove PCMachineClass::legacy_acpi_table_size
>    hw/acpi/ich9: Remove 'memory-hotplug-support' property
>    hw/acpi/ich9: Remove dead code related to 'acpi_memory_hotplug'
>    hw/i386/pc: Remove deprecated pc-i440fx-2.1 machine
>    target/i386/kvm: Remove x86_cpu_change_kvm_default() and 'kvm-cpu.h'
>    hw/i386/pc: Remove PCMachineClass::smbios_uuid_encoded
>    hw/smbios: Remove 'uuid_encoded' argument from smbios_set_defaults()
>    hw/smbios: Remove 'smbios_uuid_encoded', simplify smbios_encode_uuid()
>    hw/i386/pc: Remove PCMachineClass::enforce_aligned_dimm
>    hw/mem/pc-dimm: Remove legacy_align argument from pc_dimm_pre_plug()
>    hw/mem/memory-device: Remove legacy_align from
>      memory_device_pre_plug()
>    hw/i386/pc: Remove deprecated pc-i440fx-2.2 machine
>    hw/i386/pc: Remove PCMachineClass::resizable_acpi_blob
>    hw/i386/pc: Remove PCMachineClass::rsdp_in_ram
>    hw/i386/acpi: Remove AcpiBuildState::rsdp field
>    hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine
>    hw/i386/pc: Simplify DEFINE_I440FX_MACHINE() macro
>    target/i386: Remove X86CPU::kvm_no_smi_migration field
>    hw/i386/pc: Replace PCMachineClass::acpi_data_size by
>      PC_ACPI_DATA_SIZE

Series queued.

