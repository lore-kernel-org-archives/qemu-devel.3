Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413E8C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ofP-0004oJ-Jy; Tue, 29 Apr 2025 13:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9ofN-0004nT-IP
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:22:45 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9ofL-0001MQ-Qr
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:22:45 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22c33677183so66336275ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745947362; x=1746552162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GnXY9CbRtdAp+7s2SYIpcQecLgU9yEiXMb2vzkjrC0I=;
 b=L7vcxJctxYkp5RRqKa3hYjvObPxr9yo9SV9blHCr69Mfm6oE/0FlK5jqnGZIWWtTeJ
 M0LdenhNdvNb3CWUQrDU9p96JJtLFQE+OXIyN9e/C7K3tcMGEAhvqh+qsIQoMoYWCFlo
 0jMT/gidq+4a7/f2hxa2SrdpHgWkZZY8pDsZ8tDP/VVz5fUgi8zM04AH9E8EakHXZTLN
 OHmYQrJksqFQSXuEhek4sZ+O7ubF7Sa3WTaEwyXf6vdNHhpDwEPKAxNX/0y+XZqBQicQ
 Rg+g5bGNzbOqC1GfW+DT5RTXGL/grRgXtrPcipzslPYE3fhS1tk7wj0IwqbsX4MbYdA/
 6mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745947362; x=1746552162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GnXY9CbRtdAp+7s2SYIpcQecLgU9yEiXMb2vzkjrC0I=;
 b=CSSKDFdYZ0oVSGc2hMr3/5s3tQ4qZfeViDbF/lvXDPrBT+wbb4515R9mEozBNvvY40
 ecnGQx6/Yjt0BllDROWx6PVaZCPeEsFSDVvUMCv3nx9xuXCXLgHpbBUwGlofRNJVTNfl
 TgjXykmM/RSPxeEb3R8Ah5VnYjbHlUi6Dai68ojJhKjm3qkrGE6FrqgmQxPeuiUbOkOu
 AlI/wASo2Reopz2OQdRLi7KyfqmbSfsYZxUVLWe3V4SVzZGvrDd4919adgKymJKMc56l
 gNIdUvVjuqa4GRpXL0D7m4HHXLJWyKhAXnSedxNUVzcchpqcGg4opHEFbKJYil7NJREt
 WMoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXISvfabTLf4iwGMGGSG0SzhYJC4nnjXsj6qq0IqPSBBt3lqi4f7glsPswl39VIfN0Ae9z/iJG7MyGm@nongnu.org
X-Gm-Message-State: AOJu0YyQGDOzjHy7kE8M+ff2TE2XFpG26ikPDd1AUIBTdWt/5FrhxmRe
 xp+4q6lugD0JCA8Narp7IHVEA5zvsSvS+IZvMwxcHITpLpOSGycVn5L1IVnvZ/riwnuyf9ehx0k
 L
X-Gm-Gg: ASbGncs7qfGO8p6K3ZRygdg1+m72YwIM1jVri/GqsAXh2K23UShN2Ja3mxaxH7tRJJu
 UEW1ip/mqaVxdPdNS5Ooq8+hqRtxFAByfrqiirvumSM3OZrX1Ek14Cl0C8ZmT7Xi2XnKwlcvgKV
 orvlWTFdM15afHObYjJmYykssHdpwZh9fi8TT7NzqMBc4EvLw+tbC1D9Qb2SKEh3yb6OeO0MkZN
 UZP637FXdEbq2WEygyLAFaezBanEURLEltG4dsFveKlkS/30/v6ZvIZVYpV1a6iRfIKkEjvInR5
 xfIKLtcH4uZs5VhRx7ZA/RHUacwSbgzX4PD4UWhB+fjPfnfzJHzPdF0=
X-Google-Smtp-Source: AGHT+IF4e7ikRoBNQvZ6RBDAtnYRjKGpjK17duAxcQnRZYu0QCaItH0jfY074gk4q29mz1T4MxRAfg==
X-Received: by 2002:a17:902:dac8:b0:224:194c:694c with SMTP id
 d9443c01a7336-22df357cc4dmr2908145ad.28.1745947362469; 
 Tue, 29 Apr 2025 10:22:42 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76e0bsm105722355ad.43.2025.04.29.10.22.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 10:22:42 -0700 (PDT)
Message-ID: <52882128-39c5-4fdf-bf68-92e531e8c7e9@ventanamicro.com>
Date: Tue, 29 Apr 2025 14:22:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] hw/riscv/virt: Use setprop_sized_cells for aplic
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250429061223.1457166-1-joel@jms.id.au>
 <20250429061223.1457166-6-joel@jms.id.au>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250429061223.1457166-6-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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



On 4/29/25 3:12 AM, Joel Stanley wrote:
> The current device tree property uses two cells for the address (and for
> the size), but assumes the they are less than 32 bits by hard coding the
> high cell to zero.
> 
> Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
> and lower 32 bits across cells.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/virt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ed28bc06114a..62200ea39d07 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -655,8 +655,8 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
>           qemu_fdt_setprop_cell(ms->fdt, aplic_name, "msi-parent", msi_phandle);
>       }
>   
> -    qemu_fdt_setprop_cells(ms->fdt, aplic_name, "reg",
> -                           0x0, aplic_addr, 0x0, aplic_size);
> +    qemu_fdt_setprop_sized_cells(ms->fdt, aplic_name, "reg",
> +                                 2, aplic_addr, 2, aplic_size);
>       qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,num-sources",
>                             VIRT_IRQCHIP_NUM_SOURCES);
>   


