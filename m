Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2A3C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ofF-0004j5-5m; Tue, 29 Apr 2025 13:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9ofD-0004iQ-PL
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:22:35 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9ofB-0001KE-Qg
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:22:35 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-af91fc1fa90so5741487a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745947352; x=1746552152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4BeayRdy8f+d84Zr3P3Mb2B8s9ew7tWGYQe0O7v8iaA=;
 b=dHSbxnlrEnizuvL7DKwb12UAYJ5DYukegKTkPSeK2ns2/GHQ2Bn+jiXep6kDmbm/xQ
 0lbYYuRsIFJF57izcyfeMJ/nfjPlH0Xq3qMrE6pK0wKFOz25QT1XkvdVAJIDNBc/HYn1
 GgdAWX6enk9xdk5Rq8+amZC/hPaLeqguyYQMEdAUdaM0C3y9HTivkEOXf8Qjzn2O0K4D
 iODhjoMp9km8YknIH9ntmKzOeNHbw9ql5PF/d3xYHq9Wa3z3t8dmAYmjfOrYRSJdeyNk
 xtVMlywDZqRW0CyPXXVlD9/ARZ+6fS4w1BcBegftwjrqVPGAMQMpcwdwnyXBpXNulCZ6
 BDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745947352; x=1746552152;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4BeayRdy8f+d84Zr3P3Mb2B8s9ew7tWGYQe0O7v8iaA=;
 b=Is3Dn+ZO7H2sbB6u/f0pDxEez0rEwGUhp+bJgfBQpoD8se7L8iuUvWiqg2a1ye4XQx
 ZfvL86JyVxdbuM/YCo9XqTwTR9CCA1E8yt13iuJ12YFfe9/8M2PL1Qgke18nNdtZAzZi
 pYPFBhNh26O6pHgzM6Xqh3nirR8dA5s5gw/jpH+EFlibb8K+QgzYylDiFznO/V+w2JNb
 NJYh6FpLoOeGX4jB7huAPbdxKq/8UKDHJeNuprN/+yqN4cQNIBK2f2+sYSKD48v7dRux
 au0D4T01KQ+AF7KzoXk3HBuxp3zjJUvDnUKtQPBYnfhuXxlcb90urZvqR6h6uLaTB5v2
 EC2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUWRD8WaGiW+6KcUJAkRFopY3ksP3QK2k16l0+vK+SFaAuAhAQSBbJ8QJXchJent03W8v+Ox+Mevr7@nongnu.org
X-Gm-Message-State: AOJu0YzHxmGW0Ug3p9jMmwU4pqYAJikHe9L/kd01NSGNJfMc9eZ1F+2s
 Dp8W9Juu8rcorVyA0MRPmFChpPCvWxrNzqh+DhoiGHErNiHdzRwji+WKn8v0d5OTJobK4YQxRgb
 a
X-Gm-Gg: ASbGncuD3RAR5o2znvFwx7NZcSOl2wwPgex1NP/38YhYt4QnYcvBSID6rGifdZ6zMBv
 rUMJgskwCDB1a32qnxX1MlUGYMv26TER/AQF5G5FlQZNA1va/kii8TRt1vC3VYukWbOqxL+svBq
 lGzl+A/hqziUdvsfD2/zPjr6tRaCSk8MlaGsv82skW8nsy8G9toxvVHVBsDMcn5k8t6zrhr+w5t
 rvBgcaBIhjgIB4V7zqKuPhQHDGkYMhFWDoKHtoxyj5trkIHiJ5Sv9bIYX+jOWl1SEL1D8M0iMaI
 1eihtNjG/oO7Sdxjc1S2lgPvxKGy4zf71BKBobn8zSHJxLp5BX8PIjs=
X-Google-Smtp-Source: AGHT+IFWNztMObwvxYqKP8GRwRFcs0Hep1NBmEpEwwof0XhMFBCjazunO+5OtWTBuaQw8BzooGkGaA==
X-Received: by 2002:a05:6a20:748b:b0:1f5:80eb:8481 with SMTP id
 adf61e73a8af0-209592a1787mr5896546637.13.1745947352451; 
 Tue, 29 Apr 2025 10:22:32 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f582csm9336272a12.4.2025.04.29.10.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 10:22:32 -0700 (PDT)
Message-ID: <4ad97cc5-ae49-46dd-a084-17e13f308aa0@ventanamicro.com>
Date: Tue, 29 Apr 2025 14:22:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] hw/riscv/virt: Use setprop_sized_cells for memory
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250429061223.1457166-1-joel@jms.id.au>
 <20250429061223.1457166-5-joel@jms.id.au>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250429061223.1457166-5-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52f.google.com
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
> Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
> and lower 32 bits across cells.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/virt.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 873d41d10c70..ed28bc06114a 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -311,8 +311,7 @@ static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
>       size = riscv_socket_mem_size(ms, socket);
>       mem_name = g_strdup_printf("/memory@%"PRIx64, addr);
>       qemu_fdt_add_subnode(ms->fdt, mem_name);
> -    qemu_fdt_setprop_cells(ms->fdt, mem_name, "reg",
> -        addr >> 32, addr, size >> 32, size);
> +    qemu_fdt_setprop_sized_cells(ms->fdt, mem_name, "reg", 2, addr, 2, size);
>       qemu_fdt_setprop_string(ms->fdt, mem_name, "device_type", "memory");
>       riscv_socket_fdt_write_id(ms, mem_name, socket);
>   }


