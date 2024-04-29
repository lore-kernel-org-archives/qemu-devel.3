Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8FBC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OKv-0000Rb-1Z; Mon, 29 Apr 2024 06:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OKt-0000RC-Rv
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:34:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OKs-0001fO-6k
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:34:15 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41c7ac71996so1059475e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 03:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714386852; x=1714991652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7JSlJwEKVj/fFizETPHLtfULWxyauPdwoD3BnkgEVUM=;
 b=tzFLorYQ5fg14u7TJdS2bwAhsTJivupKinsKPfrW0q0yo5ou9XGsRRDCIGZ8xES4d8
 6g63yCVdWzccLuZQDH7BAVgFDGzMfH97BdW3z+e7w5zEQahhDAO0V876YWIPOHlaPLGH
 rNhC9IHyalTzO9gFfmgtKcIL2fzBOEvDBD9GgFsUs/xaRwVdByZ9N5qxV7xeLFamKR0C
 +SVrFjTdh07K5Sc8BNqfKpTRKVKdDKvk74plJMHur5VjhBWW+fw1nqISzWNYtSXWhFRy
 RBiJKdlqxat02dnXLulvXJBhilQBU3jDjno2m6o0z028uysf1ShWNxR8kvJP05PRuenL
 AGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714386852; x=1714991652;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7JSlJwEKVj/fFizETPHLtfULWxyauPdwoD3BnkgEVUM=;
 b=n7CnQaOJTSdgKcMOF/r0TnFivx/5jssfkGslVlfOoZj7hrwb4sJ8rXr4q8tuwL0CVa
 NJqZp0dg+rqKKF5Z307hFbdDlY8OHO7Pb2XAegB+JSeqmvyueAfDo67iPLbuthPlVB23
 n7kCqTbYEXp6AWkfF46XsNmCJAydznEX0Mdj80Bb+KcBsnJUTL5PozKrClDJQZdrKw8Y
 vvBpgU3O7Svlz3osXzg3FWXQF+wqNrBGP5T/kUlJNJ66Mdl2DoJ6JT7tcdSP+rTxHP9Y
 y0lAswYVjXTdIU5+83miRZ/YzAb3r4wp6EhPRRjsmbfwOsxTXDFwREjHliNUVjy6FprT
 Fcfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBiQGantBcSA31l7lq6kWzm2cksbepujZ6sizGFqJwDiORUj2iw3/yMX0QJilcnpnRb95tf7iDGkROLlOeH/RaS7c1jzI=
X-Gm-Message-State: AOJu0Yw64VzIv50/LsmyembgtN7s3CL4skmNzwMHZoDxFChmYThXCbnE
 P9o3wr4qhZw3NHz57AHnWXc21m7TB3Kqk51Kq0xerELsOsyfH63PMp/8tOMHe6LAmNmD3NZ36h7
 9mUk=
X-Google-Smtp-Source: AGHT+IGspHc04wvX4FZFfwUnmKKpvLU6eTbo5MUV8BeXGfRzcHzBpE5RJWH4sQffJ2VeGRCUdOiy9Q==
X-Received: by 2002:adf:a4c4:0:b0:34a:e73a:51be with SMTP id
 h4-20020adfa4c4000000b0034ae73a51bemr7329189wrb.31.1714386852296; 
 Mon, 29 Apr 2024 03:34:12 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 e3-20020adf9bc3000000b0034c75d07bbdsm7469734wrc.79.2024.04.29.03.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 03:34:11 -0700 (PDT)
Message-ID: <23e1ba1c-cc9c-46b2-a74e-d85734f8c12e@linaro.org>
Date: Mon, 29 Apr 2024 12:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/33] accel/tcg: Record mmio bytes during translation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:
> This will be able to replace plugin_insn_append, and will
> be usable for disassembly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h | 12 ++++++++++++
>   accel/tcg/translator.c    | 41 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 53 insertions(+)
> 
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index 83fe66cba0..974cc4f9c4 100644
> --- a/include/exec/translator.h
> +++ b/include/exec/translator.h
> @@ -90,6 +90,18 @@ typedef struct DisasContextBase {
>       bool plugin_enabled;
>       struct TCGOp *insn_start;
>       void *host_addr[2];
> +
> +    /*
> +     * Record insn data that we cannot read directly from host memory.
> +     * There are only two reasons we cannot use host memory:
> +     * (1) We are executing from I/O,
> +     * (2) We are executing a synthetic instruction (s390x EX).
> +     * In both cases we need record exactly one instruction,
> +     * and thus the maximum amount of data we record is limited.
> +     */
> +    int record_start;
> +    int record_len;
> +    uint8_t record[32];

Alternatively (matter of style):

        struct {
            unsigned start;
            unsigned len;
            uint8_t data[32];
        }

>   } DisasContextBase;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


