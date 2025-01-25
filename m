Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54155C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbi2s-0002UF-8x; Sat, 25 Jan 2025 10:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi2o-0002Tz-F8
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:25:58 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi2m-00043Y-SB
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:25:58 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2165448243fso66316795ad.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818755; x=1738423555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NdliMJlQsnCjgAbOnz0GlQZkBcSsWF6LtOzJg0lNGQs=;
 b=fkSK9W5JtKsI4vwygxYexTDXOM9rtPqKV+LIwvn4JchSUxzdJpC6a59YsMSDPCSGXC
 ZAOoal0NPgMdGUN/JaUr9UMBF6nnLBI2h4b6BdB2I9kwEA5Hxr07UY/HILgTCqTdQR21
 xM9cYoEHoRN4ONy/l0o9EnU0LdXGrgdIohrjRB083maLZAvBRZGLDo7Zzb3/imAviphx
 yTRF/9e4KzP9QqmTxIFkwVyHFn3LITlCnDon6XZqg+3Yu1Xtoy4WT9XkooHokLpD3dxa
 NdmQ38z7csBygFLg38QR/v9sGuyjg0aF0Cz783rljxj5yUmFZQZ8q6v3DjqQSI10Jgx4
 dMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818755; x=1738423555;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NdliMJlQsnCjgAbOnz0GlQZkBcSsWF6LtOzJg0lNGQs=;
 b=qgyvBiqwRSHqhsIzx8fefJcfRK3Jl1xDHxWDIB3AtA839+M9rpgZD8I+92w2pAqT4X
 39pQrUr1b1u5zWGgtXWI2ATJ5JGPg3L76Lz2VefLuyUJtJn5lzrNlRBtJhQdvG22hi74
 YyRdQ9ejnzctiZSdKbJQdNR4jq/0xCpx8oYysMxa5er9NOTTKLg1aNVVU+/JbcJVTh4Q
 nV/XPg7CwoELaNSe1GVGibD3SYYP7l/oGfKRR2JhhlYtwBnFPJZv7R3D+9NYlSlmfjwn
 /c848AAMqFaW9ydSK/5MtIG51ugxya3W3Czau2KJJea3IrZeCNzJtQqzoUBgQgNoR0bq
 ZHUQ==
X-Gm-Message-State: AOJu0Yxr9hBViQDQjQ6vNDQlgjiBQv+9BUmZaTAfatJAIQTaG9BmOwD2
 QID8MBTfpn5WbHV4XQhSAryGJb8ejXsDja8lg/ncWDo6wdxbw54ndD7MKhRNElNUZCaTJDd8nv+
 k
X-Gm-Gg: ASbGncuxJeLVAP3J7wNHUSAJ1HxW8qYuAePifysJDXecVi1Qn9unjVT9b7/H/1Ipc2B
 PuV12U1HQMT91y87Goj5RDLIt1cB6XKhYlLwQDC3aJ/g5/3faTpu4fO2JXHfWjAXU6vy+qoCq2E
 NoawCxjueJJssmwRB9YsAeD2wFR8JOVoiHMsRVdrsnpqooXx4i7EVy9k6np+GUhXJu7raw3w1+Y
 AGx2T1XWo1nUhZdlzKW8qhkprTILeHHH1rw8x26qr/HtncpeIwz56yOsw4omY0wmFSUgg9X38R8
 6RCCdFnPUOxJzLA629ZWog==
X-Google-Smtp-Source: AGHT+IFgPOQDjtwDI82AM/Ku6ehjdR7gb33NCRSoyoalq1hYfX49FNMzRb06aHqCd5vveYfyltAJkw==
X-Received: by 2002:a17:902:ecce:b0:215:3a42:dc17 with SMTP id
 d9443c01a7336-21c353eec4fmr460035485ad.7.1737818755312; 
 Sat, 25 Jan 2025 07:25:55 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac48fc6aa8asm3450984a12.30.2025.01.25.07.25.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:25:54 -0800 (PST)
Message-ID: <4fa4e219-35f0-445d-9315-278240f49de2@linaro.org>
Date: Sat, 25 Jan 2025 07:25:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/76] fpu: Rename float_flag_input_denormal to
 float_flag_input_denormal_flushed
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-20-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> Our float_flag_input_denormal exception flag is set when the fpu code
> flushes an input denormal to zero.  This is what many guest
> architectures (eg classic Arm behaviour) require, but it is not the
> only donarmal-related reason we might want to set an exception flag.
> The x86 behaviour (which we do not currently model correctly) wants
> to see an exception flag when a denormal input is*not* flushed to
> zero and is actually used in an arithmetic operation. Arm's FEAT_AFP
> also wants these semantics.
> 
> Rename float_flag_input_denormal to float_flag_input_denormal_flushed
> to make it clearer when it is set and to allow us to add a new
> float_flag_input_denormal_used next to it for the x86/FEAT_AFP
> semantics.
> 
> Commit created with
>   for f in `git grep -l float_flag_input_denormal`; do sed -i -e 's/float_flag_input_denormal/float_flag_input_denormal_flushed/' $f; done
> 
> and manual editing of softfloat-types.h and softfloat.c to clean
> up the indentation afterwards and to fix a comment which wasn't
> using the full name of the flag.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-types.h |  5 +++--
>   fpu/softfloat.c               |  4 ++--
>   target/arm/tcg/sve_helper.c   |  6 +++---
>   target/arm/vfp_helper.c       | 10 +++++-----
>   target/i386/tcg/fpu_helper.c  |  6 +++---
>   target/mips/tcg/msa_helper.c  |  2 +-
>   target/rx/op_helper.c         |  2 +-
>   fpu/softfloat-parts.c.inc     |  2 +-
>   8 files changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

