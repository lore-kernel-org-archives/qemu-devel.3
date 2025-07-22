Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDB4C83F34
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 16:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueFXP-0007AL-SV; Tue, 22 Jul 2025 12:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueEpZ-00044e-U8
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:23:03 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueEpX-0005Sr-MX
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:23:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so6397463b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753197777; x=1753802577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cctN2IBS9aWc+VrtsUUrfpAgejvCoMDY10mjOOms5ZA=;
 b=CnVsU8MtZPPsQL6vuh9DcBJ+PeR3kjX+AvtAu3frto+/a8Xr9ouuIN3FygAux2MnWS
 NZAJkyoakqHSllXovkm5whheGd5j7ETwmPS8eX14UIEbTbtPKBx9h505qlD4DV6OsW4x
 GKV9FJCIrKaKPHV5/oYNWG/JL2q0eV6EqAcPoCPFd2r5cNKtFsaGPN6cdtZtm9HQoiGH
 t/DYU43t/1UA08RdVG+17U3K8OXCNaK2Sk3nMixV85ksVmyvnx+Mi00aog89WtCje8DX
 Ca0kOuvwoQRR7eLDU1xW8/e5WFBYYKqrx8dYpbTPxK7hcYhWw6+bdFjT3uWl0sE+tVyk
 zyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753197777; x=1753802577;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cctN2IBS9aWc+VrtsUUrfpAgejvCoMDY10mjOOms5ZA=;
 b=akBkxlhzvuwLM5Rhle88E3NfnPl7F4eBze36A4DZ0KxmhWCoRtnj9s+qeRxuOB2/nD
 ZIzuGrrKtutnCUxB1eHnDxXyNS93hdvIF1QZfavHzm22VbRV1Wbzgi0yEj1/vJpBt8eo
 KtR2bYv3yCZts9dOlQ9TQTM4Bo/Jv/QMWNW61DU40yBfxtfFJh9OZfWd8aWdTgKvdGTO
 DzgvBaFE5DAiBQS8iCkrP0Y7Y+iY+uBBWvLm3xDG8C8yHcgaHxS99mKGUcjVa5qkeILJ
 U/9h31u4rAayooY7tMWhVlOG5FJPPHB+LCOnBeo5KkWuc94Z5PNIm9hHTAQgplRKybBK
 /YcQ==
X-Gm-Message-State: AOJu0YxS32zp8pIs+Q2K4mc5EyvWy0Jl6kp4Ji3sUP7ivT5hzdrQDvrV
 8aUQZJOvPqDYyIURxctCfILvv4X9Y4xhSjlCSg2yrAviTwP8La02xV0h368SFN5sUWGWxBjD7c0
 2DvUM
X-Gm-Gg: ASbGncv2zNi0tE2iAkFyysGJl18oh8WMki918SVy3IfHLs/kXbzCSggKBE2LpmsuexG
 qVWfbF3xcsie+89OR15IJVOrilZzkGsOrZRUE0ajVAUJLDzc+ezRMzJSD3PjxndTvSzDZ4C5///
 JY4U9A+vK3PFU4ggihvAyygK2Dv6afzoP3qWt11G3e9/6w0YVxph8ARkOXucbaQ7eVWnCZ9BbtU
 4p//hpx4iRFheo+n/lcxyilhiNVV9y+CIrF8dFknS8lAmIqXZ2mJHXUTXYsh4Hd/O2DURbO1FFZ
 VoxutaY55gsmM90tZy1fWbGPbsiPNACx9J/Re4XzpbeQSQ+9j5fCYLRBTcG/BUE16rx19s5Vf7v
 ho9RW+/NxSXBATNFMGiiuWqR5qKbfO7Nxb74GHVBG7R//eQU=
X-Google-Smtp-Source: AGHT+IHshpyoOxWotJsBeh5/xm7lcXxTxLJp9Wyfirn6pA9KE+pKsMK6gYdwh1gIM6MAxSVgTxIj6g==
X-Received: by 2002:a05:6a21:3a85:b0:1f5:931d:ca6d with SMTP id
 adf61e73a8af0-23810d55310mr38146262637.1.1753197776911; 
 Tue, 22 Jul 2025 08:22:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f2fe69c80sm7197611a12.12.2025.07.22.08.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 08:22:56 -0700 (PDT)
Message-ID: <17ec4193-0382-4bec-9357-9a5a9f84387f@linaro.org>
Date: Tue, 22 Jul 2025 08:22:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/1] tcg/optimize: Don't fold INDEX_op_and_vec to extract
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250722142358.253998-1-richard.henderson@linaro.org>
 <20250722142358.253998-3-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250722142358.253998-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 7/22/25 07:23, Richard Henderson wrote:
> There is no such thing as vector extract.
> 
> Fixes: 932522a9ddc1 ("tcg/optimize: Fold and to extract during optimize")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3036
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 62a128bc9b..3638ab9fea 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1454,7 +1454,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
>       a_mask = t1->z_mask & ~t2->o_mask;
>   
>       if (!fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, a_mask)) {
> -        if (ti_is_const(t2)) {
> +        if (op->opc == INDEX_op_and && ti_is_const(t2)) {
>               /*
>                * Canonicalize on extract, if valid.  This aids x86 with its
>                * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode

Bah.  Sorry, failed to empty the mail queue.


r~

