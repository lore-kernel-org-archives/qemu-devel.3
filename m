Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9536CED606
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 11:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLJs6-0002yx-35; Tue, 18 Nov 2025 06:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLJs3-0002yb-WB
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 06:27:40 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLJs2-0005h3-Gp
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 06:27:39 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-429ce7e79f8so3902520f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 03:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763465257; x=1764070057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GwlHLOObjnzvG8oBGahyYHjpKdXO3X7YoAL4S2ocP5E=;
 b=D0MPwD07rwR5qsgdk/AG08DHOt6DJ4VstYm+oATCviIsunbPHCdhZWHvjJaUrRekit
 EtvWcrsLDdQIKz1IE0EorYlbZI9yZLeatZC1l3D/lrWviIsRIq2HSyMvsEdzfbmeRTH5
 QDPTOxcdTGnRoA6tdoNObJ7RzBHR9x9t880ipzdKiKPAlZpAaUtFbATIvAjty1PNyDo/
 XXmFY1/3/t193Vnq/YaVoOBq0+P7Qh5QYWRnZJr3TfC8v5YUILIcALYCoW+Z0VECNxYd
 P5diShjyxvf7BwqtPUhQcuVpAonCJs8kzEy0B5vLQVnzTS/wazYQB7fSHanCyQjiPJzD
 rQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763465257; x=1764070057;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GwlHLOObjnzvG8oBGahyYHjpKdXO3X7YoAL4S2ocP5E=;
 b=pFNX+f7zCCIg0/iOtFZDordRdpLdZnce16zf4HDmUWqxbtL3IKV/1dH3oYK4TcJfXD
 bsK6xqT7wtVNQiMMiRhBY59LYsR/NponQ3D5sXEBvwpl5/8NfQx4fW426Dx2zjHxvglm
 NsYuzG0uNOaSrHAEOx3mRFlnUwpvovWhIu2HfAdpPD0HsEv18nkzfa7MtKh6QLS9tg4u
 BiFtBc1iIstCGgoxpGfjA2OAeeschTqpRZceItQxm1+ITiuL7Wbxn8ZP+q0sKruTXPMb
 BOeC31/VE97SkoBuQiA7e+l9QbNwWcwI7HfBIzpvhSJiKc1RvlWHCdQxQJHI5zM8ffij
 JPlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVziftKb4oHJyOsCOMEoAnZHxptHtYJb2juaj13z3WFLOA9C9K2snIsI31AqJg0X9GgjfuNc5lcC59x@nongnu.org
X-Gm-Message-State: AOJu0YzL1EmL+4mYIEDylsDvLSjeXSvKtdoqDSYgR2xgkU6o491xCJOm
 bBWe7JS9MjG2a2rJCV7z4XUULVr9GBpcizfmp1DFSLlfRDShXNVHd7D1Qr2V8SRyHEhnBs2AcDF
 NGE9tGv/6Pg==
X-Gm-Gg: ASbGncv3djd1Ygj6b6ttutQPGVYANb0wCTCO9Z2s05ukj4HxeyrdeTlBaWwK4D8LiQ/
 Ot8qLuiY1CFQyLO0ZaAaxkhUPplonEwbX6PidlnWR9AAdvPV9ETyLa7BhRh+FbLJ5HTSIMXuWSv
 0rIqoolRpw7Ja0KekRGtM1H9teR/4la0do0A7Md66GoiCErMK+uMoeRY4fE0qEPvrJOVpXxN7jg
 Zm4WDx7n1o+V9WnstSt8x9zWvOvadlrurTaJy/2PvTju+KcFBm/K+wO+SKCYH+zZUAFM4d5Flbh
 g7U2F5TU8fuTXNcCwjm7lfbLpxq20NncHyHziyWcNFGeFfwTA9byFIkXvQ6KqpaqjwnJM3RcGkK
 mytgtwfHy8GkR7Kwfv9HMtRWHDPyD5w8JC7cmOhZhEF4jHmZJSOIU2RWPY4CXSw2V/fiHfFBY/c
 fkajT3s1UfJ/ixKnWy0M+uz9jO29hYr9GCndJpENl/2c4c5koQ1Pna3A==
X-Google-Smtp-Source: AGHT+IEJfyBihYuOr2QSoNEhiYZZ0yDFRPHpySE+qXo6pHp4g/2fUFEw2lCi0VSHqp35OxUZHp7AGQ==
X-Received: by 2002:a05:6000:3104:b0:429:c709:7b58 with SMTP id
 ffacd0b85a97d-42b59390ef4mr15873765f8f.50.1763465256640; 
 Tue, 18 Nov 2025 03:27:36 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b5ce849ddsm25131180f8f.14.2025.11.18.03.27.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 03:27:36 -0800 (PST)
Message-ID: <4b153b0e-0a97-49ae-a951-0322aa9ab32c@linaro.org>
Date: Tue, 18 Nov 2025 12:27:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/ioapic: Fix ACCEL_KERNEL_GSI_IRQFD_POSSIBLE typo
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Magnus Kulke <magnuskulke@linux.microsoft.com>
References: <20251106105148.737093-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251106105148.737093-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 6/11/25 11:51, Cédric Le Goater wrote:
> Commit 638ac1c78457 introduced a regression in interrupt remapping
> when running a VM configured with an intel-iommu device and an
> assigned PCI VF. During boot, Linux reports repeated messages :
> 
>   [   15.416794] __common_interrupt: 2.37 No irq handler for vector
>   [   15.417266] __common_interrupt: 2.37 No irq handler for vector
>   [   15.417733] __common_interrupt: 2.37 No irq handler for vector
>   [   15.418202] __common_interrupt: 2.37 No irq handler for vector
>   [   15.418670] __common_interrupt: 2.37 No irq handler for vector
> 
> and may eventually hang.
> 
> The issue is caused by the incorrect use of the macro
> ACCEL_KERNEL_GSI_IRQFD_POSSIBLE, which should instead be
> ACCEL_GSI_IRQFD_POSSIBLE.
> 
> Fixes: 638ac1c78457 ("hw/intc: Generalize APIC helper names from kvm_* to accel_*")
> Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/intc/ioapic.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


