Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C95C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gc0-0005wg-QK; Wed, 08 May 2024 08:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s4gbw-0005v1-R5
 for qemu-devel@nongnu.org; Wed, 08 May 2024 08:41:29 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s4gbu-00064g-LD
 for qemu-devel@nongnu.org; Wed, 08 May 2024 08:41:28 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f450f43971so3393104b3a.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715172083; x=1715776883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+rlAW1ekL9rCpFLaN3Hr4fOoUor3667dgRxwCKd5zXw=;
 b=eLNNpO8d/YiLSUYpplLegm2W8Q3rXoWITF0zYdHrw0KK/M3EiCUm0pTqeo9oRWnqSR
 R8qiEz+Do2NHnHPiyIxr05Iz1UG0nYi8UjP20fCbNYBxpnasqkC7vjBDGWtIIpVFQU63
 OTVKca1CIwiXvoEOSfkFYDBia4Hs56ek2MIt5CPTMElG3j0MsK50fRCebOElrFSRIA+U
 2y+OagfZT/GG03up04/i2zu6rmcnS9sENGS1DUjVDjwfeKZxbY6CcK7FW17I1hUgiXgk
 7NiPYFGCg9CsM2/AaekpyXeiUvi4WgeeALujIiNnCNeeIdBAhlAtuaFGOBi3+uao9/YJ
 S8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715172083; x=1715776883;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+rlAW1ekL9rCpFLaN3Hr4fOoUor3667dgRxwCKd5zXw=;
 b=QzstBS2Xy3VI7kD98Otf47iKCxVVh6H+VBzatBoB05mu95Xi7yetgq/GC8bDjP8Fgm
 iEjmvOdRjGMNLP9q7hZpeG/FElC7mr05bVBHLANjBKnR9XzR17R8DtY+I0+ikCyH/kaD
 mODlmW94PORM1DoCNkTVl+J9WLU5IkX+NsX4xfX1VHDWYg+RQvg/x/qmQjokbweBu3W5
 wp+g8wScbRbW96X6Izg61tAPQO58pOhugzlqK2P+EIf5zCm+BvdFjqbbmFlG4Se5XBA+
 OeAiSla8Kva5B8xRIHY+zPqxBC4mh/r2rFH+HU6S2VlQ3kyw5WCEtvvBqJ327tdMBxjk
 ammw==
X-Gm-Message-State: AOJu0YziNpNyOi8imd7/o/GFkDHN4Ddt8mKuhyBwx09uiVOj+BuX+CWz
 6Cc7bGe7gnH8ezHr9Vn1PRwvfmGkOn4h9m4VlzWfp1n9FrrDztn8Xm3VWtXRZ4EgCcj/xnmu4qt
 Y
X-Google-Smtp-Source: AGHT+IGxepVqlf7Hhu77rpJgoOQ5AAW11AgU4gjDDvSfWZFqB+v4zVyO/23RAzAQkHSht3XCdVRyVQ==
X-Received: by 2002:a62:bd17:0:b0:6ed:60a4:777b with SMTP id
 d2e1a72fcca58-6f49c1fd756mr2314575b3a.8.1715172082977; 
 Wed, 08 May 2024 05:41:22 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.168])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a62f20d000000b006f45831ac05sm7715561pfh.0.2024.05.08.05.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:41:22 -0700 (PDT)
Message-ID: <d8fcb94e-86cf-4497-b450-1a32e4606512@ventanamicro.com>
Date: Wed, 8 May 2024 09:41:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] pci: allocate a PCI ID for RISC-V IOMMU
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com, kraxel@redhat.com
References: <20240503124244.8804-1-dbarboza@ventanamicro.com>
 <CAFEAcA_gu40QoTXUPP2f=8vGvEOTbGWKtqR3b-e7YYhbFG0aiw@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAFEAcA_gu40QoTXUPP2f=8vGvEOTbGWKtqR3b-e7YYhbFG0aiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42c.google.com
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



On 5/7/24 12:44, Peter Maydell wrote:
> On Fri, 3 May 2024 at 13:43, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> Hi,
>>
>> In this RFC I want to check with Gerd and others if it's ok to add a PCI
>> id for the RISC-V IOMMU device. It's currently under review in [1]. The
>> idea is to fold this patch into the RISC-V IOMMU series if we're all ok
>> with this change.
> 
> My question here would be "why is this risc-v specific?" (and more
> generally "what is this for?" -- the cover letter and patch and
> documentation page provide almost no information about what this
> device is and why it needs to exist rather than using either
> virtio-iommu or else a model of a real hardware IOMMU.)

The RISC-V IOMMU device emulation under review ([1]) is a reference implementation of
the riscv-iommu spec [2]. AFAIK it is similar to what we already have with aarch64 'smmuv3'
'virt' bus, i.e. an impl of ARM's SMMUv3 that isn't tied to a specific vendor.

The difference here is that the riscv-iommu spec, ratified by RISC-V International (RVI),
predicts that the device could be implemented as a PCIe device. But RVI didn't bother
assigning a PCI ID for their reference IOMMU. The existing implementation in [1] is using
a Rivos PCI ID that we're treating as a placeholder only. We need an ID that reflects that
this is a device that adheres to the riscv-iommu spec, not to an IOMMU of any particular
vendor.

Since RVI doesn't provide a PCI ID for it we went to Red Hat, and they were kind enough
to give us a PCI ID for the RISC-V IOMMU reference device.

I'll do a proper job this time and add all this context in the commit msg. Including a
proper shout-out to Gerd and Red Hat.



Thanks,


Daniel


[1] https://lore.kernel.org/qemu-riscv/20240307160319.675044-1-dbarboza@ventanamicro.com/
[2] https://github.com/riscv-non-isa/riscv-iommu/releases/tag/v1.0.0

> 
> thanks
> -- PMM

