Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2804AC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 20:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYAlS-00009N-U2; Thu, 08 Feb 2024 15:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYAlS-00009F-25
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:12:54 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYAlQ-0003BL-Ho
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:12:53 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d94323d547so1805475ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 12:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707423169; x=1708027969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+GaW7JBSEEdKnTRNC03TMkZWyuAWeIJVcwofp5H/kbk=;
 b=xdG0S6zn8fFmvl5cBk54Nx4wNkPEv9cTUAZlJPK112OYHTDUUKbvxMeM9dKrTuLlT0
 x0nxTZXmhIDYDZpoAj0qenc/nEgcHOdIH9bGMQgCmwL71FoYRFAZyEPXuuowXsUB2qVk
 zZl+xiOGBxJ7hQ6OeXNkPdrFgI2lA55c9hIR3TZ/I7F5KgCQAbZwxRR5pBKlaBK+oCfY
 wEa+mWSWpnertyEpZbDrbyjJQCP4386groEKBDxLCBCWCLLPJPty+QqMgpgg+9AInEaX
 dJtIQExu8KEKCJB2WUKhiee+ML84K9o61PHVuFsXvz3j/2iJocYe9ohaVTAOSrR5BNav
 CIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707423169; x=1708027969;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+GaW7JBSEEdKnTRNC03TMkZWyuAWeIJVcwofp5H/kbk=;
 b=Y7pQlXvah1fLgHIw4L5iy6+/agWq87TsGoCmW/iQzz0p4f8ev2h/nVvI1pJ+gxz8lj
 fgQL4AkgN05YgO0Rb0SDbAys7AoTixr8+KJbi0YxFpiNcBtGEFJsj5ouQGzxwHAA3kwK
 7j/cl2K/X4qXVnx+PwJQZYnjdyudIEvtz56c638d0T6cO0u10MMKIfYcRb7KOTc/CKT3
 +x908racNJqLZYwapi5oTfLcKUbnTWavo6GSQee93o6wtWCn3MC6AMl8U6JBn2t7xp1Y
 Qt9Zoj21DQgTqK5xVIBAGDcCU2ubXPI9jfISoOr23k9lmB7GT+fXPG9oZnyHi7nRBHlM
 Np4A==
X-Gm-Message-State: AOJu0Yy88YDQyTxT3LYE8zblq/VVkY/rwI5+2ZtYacH2+ba1ydAArih1
 nqLOulQId6KS4bHqveyRTElHxJGd0eofCNezSM3Q/hVNXq97/C0PxVWsPfjrnjo=
X-Google-Smtp-Source: AGHT+IGkVBfuq/LWSlL10T0fxHj8d8c5mhRb74udui1WapraDL9bvK8+Cv1xxUFuJVz6N2i6JlT/PQ==
X-Received: by 2002:a17:902:64d7:b0:1d9:c1a9:29d3 with SMTP id
 y23-20020a17090264d700b001d9c1a929d3mr259284pli.25.1707423152076; 
 Thu, 08 Feb 2024 12:12:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVOgYy4mJ7O6KIlTFkObtARpOVt1SS9Nmql2/Ls06Ta4Uf2H5KhF8LA2MtES7b0K+VWBBl1LeMKyNT/i/ObgQAWoRqohV0=
Received: from [192.168.4.112] (066-027-223-101.inf.spectrum.com.
 [66.27.223.101]) by smtp.gmail.com with ESMTPSA id
 d4-20020a170903230400b001d9469967e8sm151736plh.122.2024.02.08.12.12.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 12:12:31 -0800 (PST)
Message-ID: <559cb196-6bbe-481f-9499-de89ea73b535@linaro.org>
Date: Thu, 8 Feb 2024 10:12:28 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] disas/hppa: Add disassembly for qemu specific
 instructions
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240207182023.36316-1-deller@kernel.org>
 <20240207182023.36316-2-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240207182023.36316-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/7/24 08:20, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Add disassembly of opcodes for "HALT QEMU", "RESET QEMU" and
> "RESTORE SHR" (restore shadow registers).
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   disas/hppa.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/disas/hppa.c b/disas/hppa.c
> index cce4f4aa37..22dce9b41b 100644
> --- a/disas/hppa.c
> +++ b/disas/hppa.c
> @@ -1609,6 +1609,10 @@ static const struct pa_opcode pa_opcodes[] =
>   { "call",	0xe800a000, 0xffe0e000, "nW", pa10, FLAG_STRICT},
>   { "ret",	0xe840d000, 0xfffffffd, "n", pa20, FLAG_STRICT},
>   
> +/* Opcodes assigned to QEMU, used by SeaBIOS firmware and Linux kernel */
> +{ "HALT QEMU",	0xfffdead0, 0xfffffffd, "n", pa10, FLAG_STRICT},
> +{ "RESET QEMU",	0xfffdead1, 0xfffffffd, "n", pa10, FLAG_STRICT},
> +{ "RESTORE SHR",0xfffdead2, 0xfffffffd, "n", pa10, FLAG_STRICT},
>   };
>   
>   #define NUMOPCODES ((sizeof pa_opcodes)/(sizeof pa_opcodes[0]))


