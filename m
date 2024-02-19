Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7A2C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6kS-0005Bl-Rt; Mon, 19 Feb 2024 11:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6kM-0005B1-O7
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:44:04 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6kK-0003xR-1a
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:44:01 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so4358404a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708361038; x=1708965838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HoOwFA01d1oaTXxGVdRi4h2xMn4Onl1GnuoBnHC95UA=;
 b=TvjT3jUhMJVWeODu/rNA1pq+NqVklBv7NYGwv+2B6KAp2oPYim97wKCQew5s9x5ze6
 49ChzPkbjbZ7BKhDsn7yKzQ2RLfYq0FyLmZ/YE9M/CgxBlCvm0JoAkyaRqNCsHpbTuIv
 wk5J/9Tsaa1O1EEVdwJvGz/ke2FFMyjg2RrOt6c3PIeeTGvQ8Mm1vX53BgZ0G4EFTLGQ
 vFT7f6cWqUVHR5WiLF2UAytrUvfsyCdL/PGqujIL4TJ3401NcFap7ULRS3O2Kec7gL5K
 nszOYc+PnGCP5S/+gh8uPFOzw6dBUwvhBIGueRKg0XAfQYRXEhzFtgyKtCHLLdvP+M39
 trWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708361038; x=1708965838;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HoOwFA01d1oaTXxGVdRi4h2xMn4Onl1GnuoBnHC95UA=;
 b=jjKVR2ZY04T7RFTokl97FtIj8/F5vbaU0R2CZVxFKdECn5AHPB1CoBLb5F7nudU71b
 UkKdXXHu9EaJ/ijBLU9AsTsuzxDuhQ+SkIrFro3t+bR1RmE8dCSiv6wxCkFaKsp5f/DE
 NB6cuEkJsp85JkNWJtTxRIsm4V4RkT6ErlBElvSy9DNMFLQzZNipto2lnrDk2dgHnexB
 GNVFKsqG4JdwewG1F4csSWZiXeyRiu1uFWM9ULEJykhqIfbiAFnTvyxetF5NJQRl0q0l
 k/z5wggCnnQfNq6AdM2lVYnfOf7uEHIffkyGIlMs43xBksKcYLADb5+EE2t/eoMdK4hV
 5S4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbj6yW47xdCt2aplW6jD7+aYXUiXb7igcdN2rAgf2mKOHMqH9AdmMLS6EBQxsV47ASFg8/GnkTBtX027wZmYxgrGwrQgE=
X-Gm-Message-State: AOJu0YxaF0Id4VbVyEu9gbfblSQ+At+g0Qddje/Jl9t1vYPFeFBfj+1+
 VTw94buCe5phH258zTkMMJV+/VqPgoFkKtaOuRu1iamGdKe8lBct8gyDM2XyEmU=
X-Google-Smtp-Source: AGHT+IE0qm9istRnCjMA8+y6rFFLWbWkP0Hv1wrqs71OB/mUJlx5ph/Y8/qrN4Yegw7O+xwyuEDwQQ==
X-Received: by 2002:a17:906:fc05:b0:a3e:c245:9a6d with SMTP id
 ov5-20020a170906fc0500b00a3ec2459a6dmr1616630ejb.46.1708361038302; 
 Mon, 19 Feb 2024 08:43:58 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 vw15-20020a170907a70f00b00a3cf7711d40sm3126886ejc.131.2024.02.19.08.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 08:43:57 -0800 (PST)
Message-ID: <6960207f-eaaa-4cfd-a4e3-3118da697ef7@linaro.org>
Date: Mon, 19 Feb 2024 17:43:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: fix ACPI MCFG table
Content-Language: en-US
To: X512 <danger_mail@list.ru>, qemu-devel@nongnu.org
References: <180d236d-c8e4-411a-b4d2-632eb82092fa@list.ru>
Cc: qemu-riscv <qemu-riscv@nongnu.org>, Sunil V L <sunilvl@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <180d236d-c8e4-411a-b4d2-632eb82092fa@list.ru>
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

On 19/2/24 17:09, X512 via wrote:
> MCFG segments should point to PCI configuration range, not BAR MMIO.
> 

Fixes: 55ecd83b36 ("hw/riscv/virt-acpi-build.c: Add IO controllers and 
devices")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Ilya Chugin <danger_mail@list.ru>
> ---
>   hw/riscv/virt-acpi-build.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index fb8baf64f6..fe01b626ea 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -558,8 +558,8 @@ static void virt_acpi_build(RISCVVirtState *s, 
> AcpiBuildTables *tables)
>       acpi_add_table(table_offsets, tables_blob);
>       {
>           AcpiMcfgInfo mcfg = {
> -           .base = s->memmap[VIRT_PCIE_MMIO].base,
> -           .size = s->memmap[VIRT_PCIE_MMIO].size,
> +           .base = s->memmap[VIRT_PCIE_ECAM].base,
> +           .size = s->memmap[VIRT_PCIE_ECAM].size,
>           };
>           build_mcfg(tables_blob, tables->linker, &mcfg, s->oem_id,
>                      s->oem_table_id);


