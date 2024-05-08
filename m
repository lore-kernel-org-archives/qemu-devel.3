Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1724AC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 11:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4fJE-0002B4-4w; Wed, 08 May 2024 07:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s4fJB-00027S-QV
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:18:01 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s4fJ7-0002on-Hh
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:18:01 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f4551f2725so3943265b3a.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715167076; x=1715771876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FzbFZ848C1oqpRza7e1G94ke40qvIa5a1ppZr3kpiI4=;
 b=jY8+cj78ohN5CIzdIL8/dSctO14nHmNOmAevowjjaUanTfihmPimOLxEoYUMtq5Z5O
 b0nI5fzhC7By59VbBaYnJUGiGAXgC3H7WKk2A5rCIUxziQYjdzldboRjsm+pL5y+AfRV
 tN6pHgf6lZU6VEknu43hoF84F8K+fXeP9Fw9uSTrY/jdK5/HIvbUPNbG/oKFQJ+o3edu
 pbvCm750GSC1EOTzEg/csgrbx9swbFqkXyUZ2zmbJI4rolCaSEXTMJQlJT7UmQAVEoD0
 i+0uWBN9HyO5eNLxhdMjbN43DwtazjdMhW0f0mZEimXOTaAxnYk4hwbjfMfLFdX6fmYq
 Ws0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715167076; x=1715771876;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FzbFZ848C1oqpRza7e1G94ke40qvIa5a1ppZr3kpiI4=;
 b=hyKl2bjxeEUrwudmnetS9V6+zLWE9qkye8FKzbxTvkD2a9AS/R04FZox9O16/IVaSL
 CxgT1XoU8HO8DA49mP5wyAdcFxaxQUhpNyO8ZkwlvT/ODROmfVLbSuHG4hQL+nOyw7Ed
 wf3ZWZ9xF3O9L8suCbBCe9zYFYrIUk69kGRousEKmNMCI0jhgPyXuP3sAqpucP3T91Zh
 3c/RkSsva1wleWUXXV/j+JUn2P5rKNObGbnDJ/M34jSKOuenp1nh2xzk8+6tG9nxROZy
 cFEsAFf8BV47eoT5qgf3GzwYMu/rN+2vE50GjAUchdmRt0oArg+9lUlta3frFHc7cz+2
 azdA==
X-Gm-Message-State: AOJu0Yw4EwPO4Zh2DFVNbSn8VlA2KJN+rFHbXkqBAPQcIUO8r3UezNAV
 bAjjMh1rb1u1eoVKpF//9JCEfqzqaccA8vPAEqjXmz58j68DMqqgDaFVssTH6mE=
X-Google-Smtp-Source: AGHT+IEJFKY8fppVu3gVbnTmnkmYfjYIHA5njeKKjKRkz9A0Cf5XqA316wC3AtuKb1JGUDcZtwsWqg==
X-Received: by 2002:a05:6a00:6985:b0:6ed:1c7:8c5d with SMTP id
 d2e1a72fcca58-6f49c21ef15mr2408921b3a.12.1715167074548; 
 Wed, 08 May 2024 04:17:54 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a635601000000b005fd88b393b4sm10815591pgb.59.2024.05.08.04.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 04:17:54 -0700 (PDT)
Message-ID: <6ae9601d-2e98-4163-b3e5-17cb69b6995e@ventanamicro.com>
Date: Wed, 8 May 2024 08:17:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] pci: allocate a PCI ID for RISC-V IOMMU
To: Frank Chang <frank.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com, kraxel@redhat.com
References: <20240503124244.8804-1-dbarboza@ventanamicro.com>
 <CANzO1D0g=AoPkyFS_5d5mJwmwDX8hpaj0fjeFy9xt4xi70fh1A@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CANzO1D0g=AoPkyFS_5d5mJwmwDX8hpaj0fjeFy9xt4xi70fh1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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



On 5/7/24 12:37, Frank Chang wrote:
> Hi Daniel,
> 
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> 於 2024年5月3日 週五 下午8:43寫道：
>>
>> Hi,
>>
>> In this RFC I want to check with Gerd and others if it's ok to add a PCI
>> id for the RISC-V IOMMU device. It's currently under review in [1]. The
> 
> Is the link [1] missing?

Ooops. Here's the link:


[1] https://lore.kernel.org/qemu-riscv/20240307160319.675044-1-dbarboza@ventanamicro.com/


Thanks,

Daniel

> 
> Regards,
> Frank Chang
> 
>> idea is to fold this patch into the RISC-V IOMMU series if we're all ok
>> with this change.
>>
>> Gerd, we picked the ID right after the PCI UFS device. Let me know if
>> you want another ID instead.
>>
>>
>> Daniel Henrique Barboza (1):
>>    pci-ids.rst: add Red Hat pci-id for generic IOMMU device
>>
>>   docs/specs/pci-ids.rst | 2 ++
>>   include/hw/pci/pci.h   | 1 +
>>   2 files changed, 3 insertions(+)
>>
>> --
>> 2.44.0
>>
>>

