Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C269C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD66s-0005Zv-Rg; Fri, 31 May 2024 13:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sD66r-0005Zg-BT
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:32:09 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sD66p-00054e-H4
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:32:09 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c1ef9b95acso364626a91.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717176726; x=1717781526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+6f6GvMnB2qAkO4+j5v1FVvXuiEe1pDvYAn9Sm1TJoA=;
 b=KRh/rFM/J2ZLYFi0VRkGSlLpm25ZkklmIEi4Wzihj1WGzKasqJBD+h4IIlnpUVzbcZ
 kAqAkm9RN78FtM3cNYXYEwjnf8L+npiVY16JmQCjGCkp/If/lHQlQXqGgld/BEAFnm4w
 /W80IsK1pk0PiRUUFHRB5BzRJeA/LkxFmvR9ECJFYmgT3szmWZi1WF0Nxi2HMXHkCkRy
 GULdLZxQJRvlnxsDUwi+h1WgNHwhYOQNrBbn+pHt8Hz1ayNGd9icenH/OpgQW5E6to2e
 3rftgootpU1Ux8dNClM0IsJWBlEwtin5H0xb0AB5P33kAQ9Sv6SVGbJOUrkEInc2eSiU
 6RAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717176726; x=1717781526;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+6f6GvMnB2qAkO4+j5v1FVvXuiEe1pDvYAn9Sm1TJoA=;
 b=S/j6bbzb2CrDGpLq+Q/KBDXAhcY1FTeFmv9TnGTLDro1gkeZNGRPPik7dKIH7cUktB
 3zmSPdaXrUeVEbptP7gANZj31j4/hQqQ4pcqoojlcpEB13A79HV81nzWDil1KbtRzv0a
 EVRP4xWkjDX5pK5t0XlTdIZND/MEYyhX6Yi/hg0n2MHCphtTXUm+ODGNWh2mwvIlJNRi
 whxDac30ymns1/tq9cHy8uR4rjQhoytQyK4gVkCd0VNyPsrW/7yymnaB4CVGzFtwQgL2
 krdCPN2O9WXfd6Pb6lznujmvbgaEqCeFLcf7tz2rvYn9L0gDkuAtQMNg1H7tCs9WTJ+H
 r8qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYkZya4lJAho+4KBBTo44l8uCn1/Lm9j6dZhWGSF5IZXuKp/Je24KEm/LWeedVvt012m5PqVGLlf8fsQ2ZAS1ZJ+Hu75w=
X-Gm-Message-State: AOJu0YzGGp92PwfZtxzxYanAGJm94XvhgM2c4sgIHqLlmQn0/n26ODVk
 bHT61qlz3IXgL7wXud3R/fFJWMxHj46yd4j+a4r7xItnh6UUJEY0o18dtxumnYrbM6cmKJ/lcmq
 n
X-Google-Smtp-Source: AGHT+IHb1MiJQVTHdwSdXsDNUc/hcMM5XjUpLBbGUCobmznBvUxpRvtlNtOWDYfConhHqrJ28Bvj9A==
X-Received: by 2002:a17:90a:7786:b0:2bf:7cf1:f55f with SMTP id
 98e67ed59e1d1-2c1acc91493mr7999393a91.15.1717176725802; 
 Fri, 31 May 2024 10:32:05 -0700 (PDT)
Received: from ?IPV6:2607:fb90:8f63:c378:2227:4860:1a85:f40c?
 ([2607:fb90:8f63:c378:2227:4860:1a85:f40c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a77ae97bsm3720918a91.35.2024.05.31.10.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 10:32:05 -0700 (PDT)
Message-ID: <044af09d-4856-40f0-ae27-df6522e4dbb4@linaro.org>
Date: Fri, 31 May 2024 10:32:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: nochain should disable goto_ptr
To: NiuGenen <niugen@loongson.cn>, qemu-devel@nongnu.org
References: <20240531101744.1683192-1-niugen@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240531101744.1683192-1-niugen@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 5/31/24 03:17, NiuGenen wrote:
> Signed-off-by: NiuGenen <niugen@loongson.cn>
> ---
>   accel/tcg/cpu-exec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 2972f75b96..084fa645c7 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -173,7 +173,7 @@ uint32_t curr_cflags(CPUState *cpu)
>       } else if (qatomic_read(&one_insn_per_tb)) {
>           cflags |= CF_NO_GOTO_TB | 1;
>       } else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
> -        cflags |= CF_NO_GOTO_TB;
> +        cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR;
>       }
>   
>       return cflags;

Why?

The original intent of nochain was so that -d exec would log all blocks, which requires 
excluding goto_tb.  There is exec logging in helper_lookup_goto_ptr, so there is no need 
to avoid goto_ptr.

You must provide a rationale, at minimum.


r~

