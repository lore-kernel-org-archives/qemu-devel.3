Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE5EE98FDC
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAlsi-0001Wp-CO; Thu, 09 Apr 2026 05:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAlsg-0001WA-SR
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:40:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAlse-0001dI-Cf
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:40:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso7089365e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775727654; x=1776332454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4s4U4hC2ghdczoWrVYARbsjOeBNZlC8PGpb2hWgnoWc=;
 b=XqXezwIwGgxY2ve+iwiy3//W1KTY7KaAlGDquBSxQ7C4oGL1ZSDWgxcYDQZzl7soAV
 AAu5IBojThJuntmT3xqWHdZ0viLzNCnd1SBcT42IDFP9q81JpRj6OLUmpk0dhxGgFJAP
 IRKVnhRt8lqJtnx2jeehQhb73rogHZu1DrBc+UyU/F97BztX1ev/bfMsyFoWprWjqA1n
 tFDopaHZN473+fIwe7AZBy7oMqnU7/7mlKDLxykH/4xdwuTD/IsLRJimzPlXcA70octQ
 R0TQWhRL5AwZELdNUH88SS0MiraU/dV7bwIwos3noPH0KWhEiNEyw70LCHgEuo2tCAzx
 e27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775727654; x=1776332454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4s4U4hC2ghdczoWrVYARbsjOeBNZlC8PGpb2hWgnoWc=;
 b=RpEkQ6RuEaXeoDdu229ll5vYVuQj8jSTegy0SHsBUJdKqbgVGdEYiRxnYa17Wa7GHO
 zNQyutTnmUnubOVph6IeA93CMfk3zGoQQtzp9vybGv8Wg6rr+klzwKIYhNX1h8edf9sp
 RkjzRnVQbjZt6xd5/LwhGFGL87Xet//7m4JNGL3f7BjU/LIzy8yG2FbRpSHZLKhAyRFf
 iJSOZUFVSKDpOcnh10ZMojJMG4JupLVp8PKVuO2k/tgp3QIT0wveyqTvuFgUPm8LyUgA
 XLjg08g+xk4Bb4ObEBYsFOSkuvddeL2/tSes7DM3hlcBZuf4P/055Dw2RXd1O4xpLUB2
 JRHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAoVjSfmaP03TNw1Q+EzOhMRGbLG+wBsiFCWbWBc61wiMtDDF/o5tq8hwZ7gnLx4eqmi6AM5V/V8g7@nongnu.org
X-Gm-Message-State: AOJu0Yx8k5gZ0GEdCvRV2ViTbPb5B59Ev0loLfK9XiF25Ucsc6xd7MeE
 2UYd3quiZnfKH2d3heLgOQdDN5ZEcBwjJAT68atx1KX2EEebIqjxzHSPeixWTTmvpF8=
X-Gm-Gg: AeBDievp/nkRjCiafDXOCRKIrLncFp6cYJAVozS/0Pm9Fm9OlpWGruI3y4Uw41r/5qz
 eEvjIdM5MkLOo/Mf13qm1ck16YEufxj6CnrMXsF9wb8ZoNxt48m7u/1NUdh7dzCbUEbkcgjnboo
 35sgtmilPMiHGRttBMA3kh2F70ExQ4T2i0cr2mh8DWqGSvriCuynx4l/4Mmwvg/FrO/EY6X3t12
 Unf9L6OEYdyfuzNsiAzCLug9Wgm8Q001n7SLLtszysLfKaw+2qRRU6R0IQsLsOn+ttyMYHrDfhn
 MmNavSh/NykNTDbiWtm8xQEJLyI5KyfRJ8LDU6OqxKlpCXRbquAvyJVT4jljh/5EntJUD80GBt+
 sx/vzConP0BoAOiG78/E8veXZljJFLmUGOH2Mo9c9Ak7Ui2LglBPBepxsAVtB97X4oYH33vghSw
 lFMpwxLDqCuiF17vw2sejWWgA0rrdOXMk58tGpDVuJfZqgP3HPUNbTFdA7Jttf/IejBQ==
X-Received: by 2002:a05:600c:c081:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-488ccfd947emr28902825e9.17.1775727654307; 
 Thu, 09 Apr 2026 02:40:54 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd0cb7b7sm20685215e9.3.2026.04.09.02.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 02:40:53 -0700 (PDT)
Message-ID: <7f7f6217-4432-449c-a3fe-83d97265a9d7@linaro.org>
Date: Thu, 9 Apr 2026 11:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/loongarch: Use hex unit addresses in FDT CPU nodes
Content-Language: en-US
To: Vivian Wang <wangruikang@iscas.ac.cn>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jia Liu <proljc@gmail.com>,
 Stafford Horne <shorne@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
References: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
 <20260409-fix-unit-address-v1-2-946840930af2@iscas.ac.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260409-fix-unit-address-v1-2-946840930af2@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/4/26 08:40, Vivian Wang wrote:
> These unit addresses should have been in hex, not decimal, as per de
> facto convention [1]. Fix them.
> 
> Link: https://lore.kernel.org/devicetree-spec/CAL_JsqJFv3+UJ-bjLGk0i7Wc+spsowCrqQZ_s3P4gN8r1W-Q-w@mail.gmail.com/ # [1]
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
>   hw/loongarch/virt-fdt-build.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
> index 6c06b36fca..5875c6d9ae 100644
> --- a/hw/loongarch/virt-fdt-build.c
> +++ b/hw/loongarch/virt-fdt-build.c
> @@ -66,7 +66,7 @@ static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
>               continue;
>           }
>   
> -        nodename = g_strdup_printf("/cpus/cpu@%d", num);
> +        nodename = g_strdup_printf("/cpus/cpu@%x", (unsigned)num);

No need to cast to unsigned explicitly, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

