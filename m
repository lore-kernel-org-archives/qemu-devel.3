Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0EBC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 11:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKFtN-0006xV-SU; Thu, 20 Jun 2024 07:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKFtM-0006wv-3S
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 07:23:48 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKFtK-0004uV-HP
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 07:23:47 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6c4926bf9baso644234a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 04:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718882624; x=1719487424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PffmIAzCfizTnSqvwd0PPPz8oOtTnNclwU72GqQbAIY=;
 b=M4qiVnQq+uNRZKuGk3U1CLEsDux2F7FQvdzopq3CXp7SgT1UenkzKK4NOpDTon/1Pj
 mxwbmteTsB0wlZlQBk96Rvg6sfFEGLcaHyIARGQ4m/uuVCafkAevxrzVxykfHGYOg2HY
 N2wd5uKTwBB5j3i5b0ikLmhInnoekfea3HhLXyw8W1/fQta2vFLYA4dMRPcMtdztod9T
 dJN6iaDWaOxmD2MHQ+qXLYYmJOuYZx9jcy3I08Db5GvCDZxekxhJsY3c3d4NBPicAwFH
 +erUFbng0ZnahI8xMxO4D2z+V02rELx2QBeYaJzebWtQy/bVUWjq1GZm66wa0X1KI3g7
 xn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718882624; x=1719487424;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PffmIAzCfizTnSqvwd0PPPz8oOtTnNclwU72GqQbAIY=;
 b=ruVKGgjvvnZcoqxqN4lzZP/wWCMp/g0EyFLIOGSTUikjOVxdLKUnBfO+BTkR3SPW3S
 RnshT9jDhWlpF6uOPMXTX3+HqgQo77bfYsjROtAq4yGDneHiUK9lzD1W+KBgqrW3Ox6U
 mmWXyALir4FCBt7e+nKnSUww1xn5ydRyEISAEfrFh+fsKJOTTdVe0GViye1iZ70T+nCl
 8fC2MJQaN6uppnm4jjdyZhHGg7sMjC1AvGsFyFmiyoScCJLVyLcKPKJqPVa3V5IdO86M
 iG6kafPbNqDOOq2YOUD4cfHRyhoivpw3kfDMq5gX0L0yIbq+zWvhNMHI4Da9w+cfUvsB
 UOQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCkHAdkHKADeJclBFSSb9UdhqRLQgoZXDf/QE0XCTlsiN5t84j0LVuFQnH9vubsNY04e2J+V3smtcCJJ6n5XP9EZrotCU=
X-Gm-Message-State: AOJu0Yz3BwvBMwSmpMFCoBEA0MnnSUtx6w+TwhiUPStn+SNL7rj2v3Qy
 MpzHXi1e8WJb+O5erY8FGsQJ7KksZ94ibN81ShUfb1hKIYQNcRlIIbWotTjoEh8=
X-Google-Smtp-Source: AGHT+IFLmFxE3wAEhf8AesfMZiEct1sqmIxzI4VLO4GLgyGBwLCvlWyhOJIdsyqvhU+bBVJ6XBQxkQ==
X-Received: by 2002:a05:6a21:78a3:b0:1bc:ba80:3438 with SMTP id
 adf61e73a8af0-1bcbb63fed0mr6601545637.60.1718882624435; 
 Thu, 20 Jun 2024 04:23:44 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.144])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6fee39bb90dsm9279563a12.77.2024.06.20.04.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 04:23:44 -0700 (PDT)
Message-ID: <e62a7af4-f622-4888-a9f3-0232a002c5d3@ventanamicro.com>
Date: Thu, 20 Jun 2024 08:23:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/virt.c: Make block devices default to virtio
To: Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anup Patel <apatel@ventanamicro.com>, Andrew Jones
 <ajones@ventanamicro.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240620064718.275427-1-sunilvl@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240620064718.275427-1-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x531.google.com
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



On 6/20/24 3:47 AM, Sunil V L wrote:
> RISC-V virt is currently missing default type for block devices. Without
> this being set, proper backend is not created when option like -cdrom
> is used. So, make the virt board's default block device type be
> IF_VIRTIO similar to other architectures.
> 
> We also need to set no_cdrom to avoid getting a default cdrom device.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/virt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 8675c3a7d1..b0871b7f81 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1764,6 +1764,8 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>       mc->init = virt_machine_init;
>       mc->max_cpus = VIRT_CPUS_MAX;
>       mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
> +    mc->block_default_type = IF_VIRTIO;
> +    mc->no_cdrom = 1;
>       mc->pci_allow_0_address = true;
>       mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>       mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;

