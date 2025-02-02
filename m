Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFD5C0218F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 16:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ted6h-000353-FX; Sun, 02 Feb 2025 11:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ted6c-00034E-5u
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 11:45:59 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ted6a-0006dV-0E
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 11:45:57 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee51f8c47dso4657735a91.1
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 08:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738514752; x=1739119552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XfHHlLw1lpSPF8Q+orKd2CO3mpKAu4DWmOdWt3iov3k=;
 b=SXeq/lJPukXYElrxLjQJIwBPyQZoZm3KrrjUicRQQjQyT/yPcIssJAkk+uZV5K72ew
 TPIooFYo3risiBA8XNozWiPvST/5quHgikbVLwffEdKgGeNZiDu/q76eLWYPKYqeVkUX
 1fLB87nUnZs8SyuqieD+lAKay4avV3xUdLG+YRxSW0DqA845dAU7R5sHv8DS09JkOMyg
 tEdntWDqcwdGJeCjZ5BH5dhtTc1UhfaLuRU+X36mD+pEbX7mxVrIG/np2zl5rRqRdSc2
 CX4R0n7VWaepHtTfvFXoB+BPEkWraetROX3V1z6d4BHXRkbDcoecA7Tmx5DYCu1SMAFD
 rDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738514752; x=1739119552;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XfHHlLw1lpSPF8Q+orKd2CO3mpKAu4DWmOdWt3iov3k=;
 b=Usq0BZQKhNtFz+M9Bgbzto+p7mqmAD2mgSk3uyRAEef0Jl/SVXuyhTRfML8ewVu3vb
 3oiFTJhIHblK6yKRMJzn+whqF8529x+8QpKtpv9uTuot3xSm/M2AqHC77SwIPt8fIgor
 uK58e1miuV5h0wfq6zGlrNlsHDa9Akp64OFlbGsj7M13guTPrDzxRqUsk2gbspleKf1I
 FmXM+wRBJJN/DAEKrFqsRgWVstQJvrITimYtb8e/X0BbBIwGDdQcztZMRit6+FxYSqXQ
 g8g0rZskGTIgK2angcxgzRKUQ4rqi7/kgajgj9eo45LztrAmzgxv2dwEOk2RIiopwmf6
 J6ng==
X-Gm-Message-State: AOJu0YxEgp7rV4GyC/xYp0V+zJgYGojRUUPZcspzbkLTpHL9g0tXPdRC
 AoKBW0UFRyNpyl92I75Iq9aHgDwndg0PQWzjyK9czerHlaiHNwIUWhyInj7pOCT4JEXXRpe/9Ni
 2
X-Gm-Gg: ASbGncuW4CFcO4dXmKhcU5DAzXsaNa64vRGwITg/0pM94b/PY4gA6Uhxuf0Y/Iw/Jg4
 Zhz0OJoYEsqAW2xXO1kg51NQcMMwDSWJ6+MNro/ER2A1DATXb56GeaWq8SXD6S9a4yRrHviFNDa
 JeY8jHw4fNhzvZz+kTcvO0Hzzv4pZS7CzFBY6MUftd2ANfEJzcWaC73CE252hurdwOKkU9pnGAF
 Dy7Zsuku8EVzMgm2TNoMSpmcMfA3KqtdHrqabH6uez97JlqU9IJA0uRC5toYs/NHhSH83b0SBwd
 ZivVN/PYFnYjhPMJBws0B8jIFNl+4rYdJRA7Xdh3XESCLep6TQm3JBM=
X-Google-Smtp-Source: AGHT+IHBvG3zCW6NqL5y/RhH6AR5BgsKC1TxfYrAnWRNoo4as5CwZzOXuNxGny0/vdVRdGRq4w7rbQ==
X-Received: by 2002:a17:90b:37c3:b0:2ee:b6c5:1def with SMTP id
 98e67ed59e1d1-2f83abda2a3mr26965706a91.8.1738514752190; 
 Sun, 02 Feb 2025 08:45:52 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f83bcd1605sm9720517a91.18.2025.02.02.08.45.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 08:45:51 -0800 (PST)
Message-ID: <4b075c5f-628c-4d8b-a605-c6febd3cc941@linaro.org>
Date: Sun, 2 Feb 2025 08:45:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/69] fpu: Implement float_flag_input_denormal_used
To: qemu-devel@nongnu.org
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
 <20250201164012.1660228-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250201164012.1660228-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/1/25 08:39, Peter Maydell wrote:
> For the x86 and the Arm FEAT_AFP semantics, we need to be able to
> tell the target code that the FPU operation has used an input
> denormal.  Implement this; when it happens we set the new
> float_flag_denormal_input_used.
> 
> Note that we only set this when an input denormal is actually used by
> the operation: if the operation results in Invalid Operation or
> Divide By Zero or the result is a NaN because some other input was a
> NaN then we never needed to look at the input denormal and do not set
> denormal_input_used.
> 
> We mostly do not need to adjust the hardfloat codepaths to deal with
> this flag, because almost all hardfloat operations are already gated
> on the input not being a denormal, and will fall back to softfloat
> for a denormal input.  The only exception is the comparison
> operations, where we need to add the check for input denormals, which
> must now fall back to softfloat where they did not before.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> v2: drop the now-unnecessary float*_input_flush2() calls in
> the float*_hs_compare() functions
> ---
>   include/fpu/softfloat-types.h |  7 ++++
>   fpu/softfloat.c               | 38 +++++++++++++++++---
>   fpu/softfloat-parts.c.inc     | 68 ++++++++++++++++++++++++++++++++++-
>   3 files changed, 107 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

