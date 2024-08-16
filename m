Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FF6C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 11:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sevIW-0002Gb-8W; Fri, 16 Aug 2024 07:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sevIR-0002FC-FC
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 07:39:08 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sevIP-0007O6-Jo
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 07:39:07 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2d3c08541cdso1378736a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1723808343; x=1724413143; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YrXmJP0T5PuESmfzLa5Jje7GuulXuQ6qTfUpaeTPhEw=;
 b=OyYZ8hdO8kQJN3ioN6kst0x3P5xKi7KV1b4y+KLvOzO+LhVaRtH0rq0ok792Iwfkmx
 6qJczN0aUtwEmwlHkwGu5hVpm85oXFI0HWtt6aZ07R6hYvprFSeb8pQiYDtsGkZBc1BB
 NHvuzYBkMyPxJ1xd+wk8PP82Wq0E2YZ72Q0dPpr9HTD/INqr+tjNi1nQHc9wEtA9Y+ra
 9xDcRWOivSKpyDw5pf/bGz+jrB2G3j7frUPvXr0UEATW8IlJP2jIxiF8IuEE3QEtwRKN
 pmA8wXqpgK/XLFtNZdLrTX1SL+HkHv8LYoj7Z9BThRFViEHUOe7oIdeWjakFbFfD+ZXB
 0VcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723808343; x=1724413143;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YrXmJP0T5PuESmfzLa5Jje7GuulXuQ6qTfUpaeTPhEw=;
 b=wVekdsjxdT6l11i72nHx7/+Rhvn0GV1Mqs8mntaoqqT8LrOOcGZdpm8TKH5G5cZzmY
 9vZSdrc6z48m7KHDtIYAg+tG9Xe3w50ZnZZ807PHlAy2mSUkbCMaG9VkXDph9ItyK0Hl
 sSOrkxjTbZPxtl45WDMvxnSs3dX/B8Gct2B9Sg0irtaLwdPu8No33ukg9kHF6GrPuYoE
 0euLEKMNq0djCT1JNIucMx2Knoue6Gs45vIyl775yAVlHHyGvweq7j83mw+HTFw1GgoL
 eb7++QWXtakZ37hGa2NIZjLTgfLBSC+LctFx69yydkP1VNXyyrKhyT6L1xI2SwDPRR1f
 zfow==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8NcwtXa3a0YgXpTz8EuDsgCV+u/GtGieiW7U/2YPCaNzKR/cQ4DGRV9hC9MoMEwpDylnRFlvDBsOgmWWp6fkM6OvHfmo=
X-Gm-Message-State: AOJu0YzSJLRAnsZr4rQsXNUWObik9bfrJjDwp4K3QYCkb8kVwu7p3s3N
 9h0ENUiH5atHT11ZM6FMSeLLm7h8KaBu4vuNpD4yLKhhwK80fnxHcPDTD2Wrr/A=
X-Google-Smtp-Source: AGHT+IGoEWFbK4DaiR5SLzSvh6BYAuT554CckHIIY7IeAqQZp7JNcMDbLahsTYmbzRXCtW4exqiNvQ==
X-Received: by 2002:a17:90b:802:b0:2c7:ab00:f605 with SMTP id
 98e67ed59e1d1-2d3dfc7d183mr2799374a91.20.1723808343513; 
 Fri, 16 Aug 2024 04:39:03 -0700 (PDT)
Received: from [192.168.68.110] ([179.133.97.250])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7f2276sm5416711a91.29.2024.08.16.04.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 04:39:03 -0700 (PDT)
Message-ID: <986253df-1102-4625-9fa5-264f3a4e0c6b@ventanamicro.com>
Date: Fri, 16 Aug 2024 08:38:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/char: riscv_htif: Use blocking
 qemu_chr_fe_write_all
To: Alistair Francis <alistair23@gmail.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: palmer@dabbelt.com, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com,
 Bin Meng <bmeng.cn@gmail.com>, liwei1518@gmail.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240815015410.369925-1-alistair.francis@wdc.com>
 <20240815015410.369925-2-alistair.francis@wdc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240815015410.369925-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1035.google.com
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



On 8/14/24 10:54 PM, Alistair Francis wrote:
> The current approach of using qemu_chr_fe_write() and ignoring the
> return values results in dropped charecters [1]. Ideally we want to
> report FIFO status to the guest, but the HTIF isn't a real UART, so we
> don't really have a way to do that.
> 
> Instead let's just use qemu_chr_fe_write_all() so at least we don't drop
> charecters.
> 
> 1: https://gitlab.com/qemu-project/qemu/-/issues/2114
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/char/riscv_htif.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index 9bef60def1..d40b542948 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -218,7 +218,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
>                       tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
>                       uint8_t ch;
>                       cpu_physical_memory_read(tswap64(syscall[2]), &ch, 1);
> -                    qemu_chr_fe_write(&s->chr, &ch, 1);
> +                    /*
> +                     * XXX this blocks entire thread. Rewrite to use
> +                     * qemu_chr_fe_write and background I/O callbacks
> +                     */
> +                    qemu_chr_fe_write_all(&s->chr, &ch, 1);
>                       resp = 0x100 | (uint8_t)payload;
>                   } else {
>                       qemu_log_mask(LOG_UNIMP,
> @@ -237,7 +241,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
>               return;
>           } else if (cmd == HTIF_CONSOLE_CMD_PUTC) {
>               uint8_t ch = (uint8_t)payload;
> -            qemu_chr_fe_write(&s->chr, &ch, 1);
> +            /*
> +             * XXX this blocks entire thread. Rewrite to use
> +             * qemu_chr_fe_write and background I/O callbacks
> +             */
> +            qemu_chr_fe_write_all(&s->chr, &ch, 1);
>               resp = 0x100 | (uint8_t)payload;
>           } else {
>               qemu_log("HTIF device %d: unknown command\n", device);

