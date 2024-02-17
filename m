Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DEAC48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 20:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbRQ1-0008AC-52; Sat, 17 Feb 2024 15:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRPz-00089p-RH
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:36:15 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRPw-0007tQ-93
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:36:14 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e332bc65b3so271571b3a.3
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 12:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708202170; x=1708806970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pJTvzsGrc/Vbf0dgeWtVFwf4GTgJWf6tBNmw4161f7s=;
 b=HHk5lCUKb4hJ6XL9Ei6OhjfUYWHYCisygmNILkXqHlSVRFZP+cbMXIH9LXVT9VArd0
 tajLlMv6dTGUgtUzDpCD7lH2Tee+2wbREFJQl+8hyHQb4uoYY+FRSb7kAJtD91RgEPO6
 u6V0jBdvq7qjvVjbcqSc5FLlEscL6o3AeCMqPKe6FfbeRWGKelpKg9RZHbVmIr1E8Osh
 VmzB3XRAx0nWqZUeiQB44Gd3OuKu4EtsyUDCEG2zd2VrugKnpGhXJB3iAEKITQ2W/epE
 TS20qOezBGr4cD3h+qx+FnQ0qTyq6GG6DPtb860Cr2qi5/L0Rrmg0nQNG4UDPOeBBIUl
 2ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708202170; x=1708806970;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pJTvzsGrc/Vbf0dgeWtVFwf4GTgJWf6tBNmw4161f7s=;
 b=I31v/YBwzWd2dwwzFZ+07hfCG9OJNBJeYzcQeBegGEfz4Cp9Umg2xcfQggsmqTgBit
 Dd2pBXyNCluOFqsgx6a+YO5TKI4fA+5bePRHFJ0XSAJbwMe/3uabMEe/xGBVAegtoApO
 aTsv5CGwPSJPcrtTA4+0GqGLR63Y9BPoqI0aTdCfSdCcDDALr7NdDJqyIFiWQ92WzDEt
 HsOM157ShvCwG7rtWxJgX26B8ojaI+MseGaDUSwYZoXrmxTcHaFJR6E24WxCy80hDqNX
 L/QgqX0p7buMmGRiVPuh1asXDhdGb/rYisHHLOtO4KoSCKBcsDVJ71zVma+6UGfITXOc
 tUGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW80LhfICz9pBlhngJY1orvkXTxxHB6MsqNpiW3ztEjPxVWZyHhRFXsbYz9CjanRUEAENrO/gyGKA9QqAquQk/DXYkgqk=
X-Gm-Message-State: AOJu0YykCqh4quPkKkFEm0HiE7+0OgF6oH6cj9s+PAEeQrn1AvFobdOQ
 MzWGDijPsO3HeEPjWqJK/X75044t+pqKWg2DRUKFdATlowItseEUW4ypolJqfP4=
X-Google-Smtp-Source: AGHT+IGiefz9/QNH80pRwcuuuGAcBbsx4U38MPVf4Izqd3TjsjtkUOVHGPtN+FUjme3LaK5fb5ELXg==
X-Received: by 2002:aa7:8c10:0:b0:6e0:6bc7:15ec with SMTP id
 c16-20020aa78c10000000b006e06bc715ecmr7896261pfd.30.1708202170006; 
 Sat, 17 Feb 2024 12:36:10 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 x10-20020aa784ca000000b006e3a69eb6c4sm824734pfn.219.2024.02.17.12.36.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 12:36:09 -0800 (PST)
Message-ID: <5d2d958b-d8bb-4b79-b382-f6a2f3e45bd3@linaro.org>
Date: Sat, 17 Feb 2024 10:36:05 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] gdbstub: Introduce
 gdb_handle_query_supported_user()
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240216130817.369377-1-iii@linux.ibm.com>
 <20240216130817.369377-8-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216130817.369377-8-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 2/16/24 03:05, Ilya Leoshkevich wrote:
> The upcoming follow-fork-mode child support requires advertising the
> fork-events feature, which is user-specific. Introduce a user-specific
> hook for this.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   gdbstub/gdbstub.c   | 12 +++++++++---
>   gdbstub/internals.h |  1 +
>   gdbstub/user.c      |  4 ++++
>   3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 7e73e916bdc..43d79dfdd59 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1599,6 +1599,7 @@ static void handle_query_thread_extra(GArray *params, void *user_ctx)
>   
>   static void handle_query_supported(GArray *params, void *user_ctx)
>   {
> +    const char *gdb_supported;
>       CPUClass *cc;
>   
>       g_string_printf(gdbserver_state.str_buf, "PacketSize=%x", MAX_PACKET_LENGTH);
> @@ -1622,9 +1623,14 @@ static void handle_query_supported(GArray *params, void *user_ctx)
>       g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
>   #endif
>   
> -    if (params->len &&
> -        strstr(get_param(params, 0)->data, "multiprocess+")) {
> -        gdbserver_state.multiprocess = true;
> +    if (params->len) {
> +        gdb_supported = get_param(params, 0)->data;

Declare here.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

