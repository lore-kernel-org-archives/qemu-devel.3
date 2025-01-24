Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6D5C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 19:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbPJF-0006dP-89; Fri, 24 Jan 2025 14:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbPJA-0006cp-Py
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:25:36 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbPJ9-0000oi-1E
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:25:36 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-216401de828so45246975ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 11:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737746732; x=1738351532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Efp/hPVSZRE0vEoa10cngIHoSiF6tGCC3iy86fCUHm8=;
 b=DR6lBBcQy5y5twHFF7/qsgkuPzbj3iFGo4pwI9wwV+E+gPLCpfdR2OeQvCq67LVpSM
 2uYIPogs+X3OKhAat0X++8Qe7MTXzFNaSXYn3SrjBuesXg4fFIkGkW/FIk0/wP2TIdx7
 M8/+HBizviTh0LMvf3AVNTDt+zVMKL475lih6KJSYW1wCPCoLWWDHpyClxhHsgKBdiwC
 hDYDLb3VlILpcU2xTG5rV26eOML/j+kAPo3spIvrgTQyl+q19IArpfxD0czoqjY3cTsK
 eImiENg4Zjn7aCAR8XWTQMLqqodyDx9IRlZyuCN8ddhGH3MEHIIs6wxNBbIe+9b/ubBg
 gLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737746732; x=1738351532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Efp/hPVSZRE0vEoa10cngIHoSiF6tGCC3iy86fCUHm8=;
 b=K/U+IDjsZ4xdFqvtnXuGs6eiBlFFgq4EdQ8NyyHLuDRY3aLgdxSBcftf1v9ileO830
 rVgcNXRDRb3O0Jbgwht8x6yqejfwG0tB6uPOsQG55cw1Ww6fiRh6akkRaU01MgCG+4Pd
 yryY+wcIlAuyr5S2CLRX2zEVTraxgcTNligZjJPv55YGTamQuoJEnAScA/PiG1sXMvmm
 Y1mRkI5KeyksPa/VwswBFeS9OGbnwVc8ehO+BsawpakZxsC4ci9wsuGovenleRvJbBFB
 Nnq+2DKjpTQjHN8B5pJIMY0wT9B4j9CIV5jvL5p29bqvuNh870sL4yThhf5q0XwNFr81
 CcaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGx6EOPSX858eRKxxfuFL/I9Vi25lariWUVMerksOoRTRVdOaudf2q98a9FzGv4wa6FmqugBA74xGt@nongnu.org
X-Gm-Message-State: AOJu0Yxr8RbTmEW76UdA+r4fD+/9wRzFFqrdY2CQiBHHw4EC4zsNTzeL
 7uyz41sEWbovAffaHkgwasZP7fj5PLcQtFKbj2aYdPMQ27BHBlN0+jcWo1Ta7/Q=
X-Gm-Gg: ASbGncuJO6KvP2caGxiCos4bp5Fb6wF4Z7W4jLq4GK9u4FtgevQeSJZgqAMdlNM6Usi
 6Tf3LelLaLupzJRb9Yhef5U3ZoIJPdkKpUdlKfZ8ZKu1Jk2zLOTHJavrJDlB0JCv1u2pAstmGDb
 5hVEVDZrLprd8HYqPz376j9W/iM6qX7/2bFJLV9c3B0dGK6fHbeWFYdUZXG+X6JFU8A4eviQPkT
 jUNfMyfFmI5xL8nWWSnWcLBtvILevGqyYeS0NvLd5Mx2hkcJhvPv3LQcswqtuX0CLdLo9AQxcQE
 T3Ek/MbzwPLnsGOUyEBEia9a
X-Google-Smtp-Source: AGHT+IHhfy3WqRkecYQHj7p5NldQGRlOnTtbYjD1R5ZbFJSIDt8K2ohO4QyumQAuDceW6pX3jPENeQ==
X-Received: by 2002:a17:902:ec81:b0:216:5448:22a4 with SMTP id
 d9443c01a7336-21c351bcc64mr512873895ad.10.1737746732119; 
 Fri, 24 Jan 2025 11:25:32 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414e022sm19708205ad.198.2025.01.24.11.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 11:25:31 -0800 (PST)
Message-ID: <b985ddf4-cc3e-4b89-8e69-7b71dad73d28@linaro.org>
Date: Fri, 24 Jan 2025 11:25:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] hw/core/generic-loader: Do not open-code
 cpu_set_pc()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250122093028.52416-1-philmd@linaro.org>
 <20250122093028.52416-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250122093028.52416-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 1/22/25 01:30, Philippe Mathieu-Daudé wrote:
> Directly call cpu_set_pc() instead of open-coding it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/core/generic-loader.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index fb354693aff..1b9ab600c9c 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -48,11 +48,8 @@ static void generic_loader_reset(void *opaque)
>       GenericLoaderState *s = GENERIC_LOADER(opaque);
>   
>       if (s->set_pc) {
> -        CPUClass *cc = CPU_GET_CLASS(s->cpu);
>           cpu_reset(s->cpu);
> -        if (cc) {
> -            cc->set_pc(s->cpu, s->addr);
> -        }
> +        cpu_set_pc(s->cpu, s->addr);
>       }
>   
>       if (s->data_len) {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

