Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469DBC25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 17:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s970b-0000BP-Ce; Mon, 20 May 2024 13:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s970Q-0000AB-8X
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:41:05 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s970N-0002Lo-7z
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:41:01 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1eb0e08bfd2so86264245ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716226857; x=1716831657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6IvwskBX+e6jBez0GdmP0Yi1G6CHZiMmTF7vZgk08YA=;
 b=T4sNjZ4JHtc7wySxlqOpxnkr0INWSE31y9qbEIDA03BcvQGEzxnc/GwTmDBw47mumg
 t+2ojnVlqy45fPq2yv1hvWLkDMsZBoy5rVICNyQqCwj21TfXV7Etlj3W7aKCr3jmJHec
 hKpobO9gITGIMqAyS6n4EuXiJiMGveLJz+eCKRBTj5Dgjb8Og7DVa/sEptVsVesruoii
 luaONYzGgFmZ0CmbCGachcsncbWUGnkGMTePVph+kuf3C/4VepuODLLjRAg4u2Hq/59B
 UJRGaW1egNVWWpSoodf1SSBQFx/Kx0rADZovbWdG7DhRf+XyE4RDOQxhxbJSOR8u17Kp
 aJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716226857; x=1716831657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6IvwskBX+e6jBez0GdmP0Yi1G6CHZiMmTF7vZgk08YA=;
 b=s4BIRgsNTJE9nc+pY+AYYGUVHxurGc2RQTh2hXYSF5+CKYSR2fFS5E0aDCDXllmnG6
 dqgcd0olHrtaLJFj92JRT6Wi3xrdUusRaosdbBnV9Ig3DJmksUOr2NsEZl0wRv0pReOG
 /g35EQTJphEi7mxMrzWcjoofu4TS12vV1VkWzblf/v0ovJgWBr92yR3ErymKNer8sZuX
 IkQ1YFa3NcAnHv9MfpTROjwZNpVEyeQtyvC12Gad2ino8PCstJ9gTHDVkVcc+NYhYKsC
 0zQ2AvbSBVPEm1KV2iIXmk6JZ5ZAN6yp8dffTq4a2+XnKvaVJCYd8ukiyhohAVStDddo
 DX1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8Bu5OLCC7jPAiWDtc0mB72MRy0uOCWsCZeN8XIgxj670ZcPT33/7sogkKtgcnWw9UXmUShK8BQ6TKQy9IYmwgUZ1i0cs=
X-Gm-Message-State: AOJu0YwO1R8AIRC3SnSVQRtD5dMYsNknlYAg7p4cB42CAEceZgV1Bu6H
 uh40Y/eg7Qo781SVuSKZT+J6B0Z0EpyDl39qi3sKn4JAyN9hTXnZA/KX1Um0rLI=
X-Google-Smtp-Source: AGHT+IHx1pfRtQPNy8xDMSGdSN+fiID9Bu0RbJTSXQHruG2Zn/8gspgXpjpKTYlBAbmxlELfodmNMA==
X-Received: by 2002:a05:6a20:9f4a:b0:1b0:278e:34a6 with SMTP id
 adf61e73a8af0-1b0278e367dmr11716242637.49.1716226857340; 
 Mon, 20 May 2024 10:40:57 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.57])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-66f9b625815sm1012799a12.50.2024.05.20.10.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 10:40:57 -0700 (PDT)
Message-ID: <0c7b0674-4ba9-4c87-a130-0277ca0d7a9b@ventanamicro.com>
Date: Mon, 20 May 2024 14:40:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] pci: allocate a PCI ID for RISC-V IOMMU
To: Frank Chang <frank.chang@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, kraxel@redhat.com
References: <20240503124244.8804-1-dbarboza@ventanamicro.com>
 <CAFEAcA_gu40QoTXUPP2f=8vGvEOTbGWKtqR3b-e7YYhbFG0aiw@mail.gmail.com>
 <d8fcb94e-86cf-4497-b450-1a32e4606512@ventanamicro.com>
 <CANzO1D1VmQhETKY7zFC7PTu-QntOnZVmXcYor3m2B+6RVcC5mQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CANzO1D1VmQhETKY7zFC7PTu-QntOnZVmXcYor3m2B+6RVcC5mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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



On 5/10/24 07:47, Frank Chang wrote:
> Hi Daniel,
> 
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> 於 2024年5月8日 週三 下午8:42寫道：
>>
>>
>>
>> On 5/7/24 12:44, Peter Maydell wrote:
>>> On Fri, 3 May 2024 at 13:43, Daniel Henrique Barboza
>>> <dbarboza@ventanamicro.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> In this RFC I want to check with Gerd and others if it's ok to add a PCI
>>>> id for the RISC-V IOMMU device. It's currently under review in [1]. The
>>>> idea is to fold this patch into the RISC-V IOMMU series if we're all ok
>>>> with this change.
>>>
>>> My question here would be "why is this risc-v specific?" (and more
>>> generally "what is this for?" -- the cover letter and patch and
>>> documentation page provide almost no information about what this
>>> device is and why it needs to exist rather than using either
>>> virtio-iommu or else a model of a real hardware IOMMU.)
>>
>> The RISC-V IOMMU device emulation under review ([1]) is a reference implementation of
>> the riscv-iommu spec [2]. AFAIK it is similar to what we already have with aarch64 'smmuv3'
>> 'virt' bus, i.e. an impl of ARM's SMMUv3 that isn't tied to a specific vendor.
>>
>> The difference here is that the riscv-iommu spec, ratified by RISC-V International (RVI),
>> predicts that the device could be implemented as a PCIe device. But RVI didn't bother
>> assigning a PCI ID for their reference IOMMU. The existing implementation in [1] is using
>> a Rivos PCI ID that we're treating as a placeholder only. We need an ID that reflects that
>> this is a device that adheres to the riscv-iommu spec, not to an IOMMU of any particular
>> vendor.
>>
>> Since RVI doesn't provide a PCI ID for it we went to Red Hat, and they were kind enough
>> to give us a PCI ID for the RISC-V IOMMU reference device.
> 
> That's great. Thanks to Red Hat.
> I'm wondering do we have the plan to document the new PCI ID to the IOMMU spec
> or somewhere else that's publicly accessible?

It will be documented in QEMU, as you've already seen in this patch. I'm sure
that this info will be cascaded for other databases but I'm not sure how or when.
I think Gerd can give us more info about it.

I guess we'll end up using this same generic ID from QEMU in the kernel side too.
As of now the kernel IOMMU support is using a Rivos ID ([1], patch 3). Assuming that
[1] stays this way (I'm not sure if the kernel driver is a Rivos implementation or a
canonical implementation like we're doing here), we'll need to add a generic kernel
support that uses the generic ID too.


Thanks,

Daniel

[1] https://lore.kernel.org/linux-riscv/cover.1715708679.git.tjeznach@rivosinc.com/



> 
> Regards,
> Frank Chang
> 
>>
>> I'll do a proper job this time and add all this context in the commit msg. Including a
>> proper shout-out to Gerd and Red Hat.
>>
>>
>>
>> Thanks,
>>
>>
>> Daniel
>>
>>
>> [1] https://lore.kernel.org/qemu-riscv/20240307160319.675044-1-dbarboza@ventanamicro.com/
>> [2] https://github.com/riscv-non-isa/riscv-iommu/releases/tag/v1.0.0
>>
>>>
>>> thanks
>>> -- PMM
>>

