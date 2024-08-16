Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12EFC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seznX-0000Wz-HG; Fri, 16 Aug 2024 12:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seznV-0000Vi-WB
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:27:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seznU-0000ye-7g
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:27:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4281c164408so15238315e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723825646; x=1724430446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=skBSPA/ZhyUrrNrdMIuVsq3xBpnnQO1MIdt/qjUunNU=;
 b=KW+J06pvnOWdk6cZAtCX5DwGktX95Kanck7/7tZUFpLIdpVd6qzq+EETHxGe2UFg+e
 OG/7CLBz0YKvm+5VgJswGM3oPJxJjRU9/00WkXyN1iFGyE8ePLZGsiIZjf2Qdn7eq1XI
 ym9fN39zVFMDMNVh+nYCN8TFtax4WqrNW8kWoTgO4HYolV4qQwS4TMeTyW3SBPubPrnz
 if+Iy2OcTu3li6fIGrTQ4y7touxBaMby3EajF9mvrRtryXFxJx3swMlJ4jm2HKLyTRtn
 Yxceo5ssmcKhexaCZoUl16Iqrh2Wsjxev/BTrzPPu7EsfEzY/ykIjUactan0TvcOT6Sy
 JjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723825646; x=1724430446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=skBSPA/ZhyUrrNrdMIuVsq3xBpnnQO1MIdt/qjUunNU=;
 b=KX2rGyxq1QDeEngZ9gMF9uqet1RSKixmiEIQJrINj3d2X8St2M+aVrYmK5VjY3dEMV
 C3lnMh77O72wzGHDH5/KnckfjIDTWpSl776c8DgM5EEeMA2dCVTfwESYZZ6Oe2MFsRbh
 1ibRQj82jA0RSBA4icZX6pMrZzseeqLeFuCTaAH3teCzYQHeiNXJUQ0eC/+wGx9QZ48H
 Q1947ZVKETHQmO0Y6Jn4orsit1pKkTXCFqp1USbYnugFwofcP++VX1PNfwUKE6xgF0RI
 SnlW0V3no+u1GO+DMqmGkepqIT2HaXeaL7DH7MLT0Fn0iMAqgPkgoOOBi3rS/hv6FNdg
 fG/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq1TG/USw4WFj9J4nLc+/GoRqAH77o/XnG3ekRQ6nMS//iU7IRdXkw+NJTIplW7AEYpny+5gxB/5T5AUj0+ynxkyX5mcg=
X-Gm-Message-State: AOJu0Yx2KYGR5LxS4DKJHkyEyeL9ohAUD8Wz5hNZ9XGz4DhNmE3pDKCd
 wW94B1GmtIR4C22LGYroxxgBquYvIbiRH4MKf4Pwp/nt9peavzIJETXLu0Zl6/g=
X-Google-Smtp-Source: AGHT+IHjvy0iZctszxg/TgqSlYmvOcJShuM98EXWQv1g+2TKcANZe9k/ZlUwy43jTj5xteV3zlFSoA==
X-Received: by 2002:a5d:408a:0:b0:371:8e77:92f with SMTP id
 ffacd0b85a97d-371946dc42emr1879625f8f.61.1723825645991; 
 Fri, 16 Aug 2024 09:27:25 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net.
 [88.28.5.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189849933sm3979824f8f.36.2024.08.16.09.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 09:27:25 -0700 (PDT)
Message-ID: <40c7abce-8d1d-4591-ab09-bbfebf1e1657@linaro.org>
Date: Fri, 16 Aug 2024 18:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 1/2] Revert "hw/riscv/virt.c: imsics DT: add
 '#msi-cells'"
To: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Conor Dooley <conor@kernel.org>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 dbarboza@ventanamicro.com, Anup Patel <apatel@ventanamicro.com>
References: <20240816160743.220374-4-ajones@ventanamicro.com>
 <20240816160743.220374-5-ajones@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240816160743.220374-5-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 16/8/24 18:07, Andrew Jones wrote:
> This reverts commit f42cdf2ea5b3a1dc369792d7acbf9cd3e5c90815.
> 
> Linux does not properly handle '#msi-cells=<0>' when searching for
> MSI controllers for PCI devices which results in the devices being
> unable to use MSIs. A patch for Linux has been sent[1] but until it,
> or something like it, is merged and in distro kernels we should stop
> adding the property. It's harmless to stop adding it since the
> absence of the property and a value of zero for the property mean
> the same thing according to the DT binding definition.
> 

This reverts commit f42cdf2ea5b3a1dc369792d7acbf9cd3e5c90815.

> Link: https://lore.kernel.org/all/20240816124957.130017-2-ajones@ventanamicro.com/ # 1
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   hw/riscv/virt.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 9981e0f6c9b9..cef41c150aaf 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -552,7 +552,6 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
>                             FDT_IMSIC_INT_CELLS);
>       qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
>       qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
> -    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#msi-cells", 0);
>       qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
>                        imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
>       qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,


