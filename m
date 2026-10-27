Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B99606A334
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K+sDw7Bc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLkEW-0003F3-5h; Tue, 27 Oct 2026 12:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLkER-0003E7-VK
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 12:41:04 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLkEQ-0002Eb-BW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 12:41:03 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-70b875f6f1fso93853eaf.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793119261; x=1793724061; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+guIYYDRS/5zsb4RRB+2rSWJv00ktMPAuxxxz4g/XS4=;
 b=K+sDw7Bc83xtmZ1LUzmZezX26/CTbFtB6c/djnn530ELTWfJSXY5HgjoDQwAB2KE+g
 eO5jXTQKCsSAVtXjNjnvOZ73VWu+d23vJcS16bmwoh/hpd0INbzKDH1MEtrA0WDer6tC
 O6OXmOUsGZJfRyGbAlaenMp+BvyUxCaibm+yPCdFsJtPIOUZXNW9NYCrG/zf3mAiloBS
 3bUmrCZhqYVxtpf3RNObQNPfMH4Mk+EbuCwHHo9kpgF4dn9qkl7Sat9SDZaONrAaxWns
 d3WLcwksJ3485gbIO+sixOkRNqVNd3DtRM4Abq8H6W0mX3tq1yHgPhGVJ0K1k5FHzquI
 7yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793119261; x=1793724061;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+guIYYDRS/5zsb4RRB+2rSWJv00ktMPAuxxxz4g/XS4=;
 b=MEepGl5y/jJegQywwGQq9uDK7ggUXVYGIeIWfqasPBbkJd/Xhs3UcnhXHeCg+iiTrx
 3QYrVS2b1v2qxu6FQ352M9yMESgxAhfTy4ihgM/a/4GYXB7serwrOJYHtYi8VWIyLMDU
 8YNu2HkcPj5Y5LMwtYrzmFNCw0cWDpwNYjFs/5NgeduvXzwxs70OS8A8WthnCe3xQ58p
 Lu6IRuM0jS4ceSrUBgGR3s48uKmp+Bfm5aWRbx88nqoQRPiQu5z3YpCv3O+tseYKreA/
 twOyY3uhFBZA2kQ/SBPgwy2A/Yh3+NCaMKJBUxdwP8Rb94acLGAIvPFdWKDJyxRksq9W
 5n6g==
X-Gm-Message-State: AFq9FYIJFRY/eZreQqgYa/g0freKews+1404GfHRzkvonzDf3Gf1AAzq
 /qyFXOV1Iw3UKwCBu+8vyLN0QwrbVB5PsRKIbHY/tu+v9Lzvg/q40IHIsH5hYob6NayJDWWWYZC
 UCF6T
X-Gm-Gg: AYBFou1cRxlD0fx8GjKos1D2OjbggLSEy3BYPKtEked0NI26eOQbKLZo8FuQtbZwfTm
 C+G8DIz/RHJFW3dHpdeHlAQX9W2EnzIlKCA4NeAewLDC74D1CJO3sS5YTaYzqJNAPeh9MNtCltx
 H8qQ8eOJFbE+MkK28RINsM8SOJqKsBCQ2QEpMovBlZKlqdYyV0nYywO4pNnb6M/RAdoQPYP42VP
 ZQ8JbgibiGLmPT84VS73V6cblyEDejNzjqJF4ZGE8BBGksXO5NdkMCVGWHjE8WX3DKyGTKOa28w
 ycCb9nLGIJzvILEq/36+zCDOlthu4mvZBCqCtpANqbeNRESU33txl3kzTvRyoNfhpCB/jZyFKaJ
 ZZ/5W7gEbn14NB8EsaVJezSJ8+sDPDGBiNSUQ3LiBvbzSWONf++mcL2JrlhNpfyB8BIQQX8REy7
 tn/j3XMDdt3kGSyaP9m2UKgGqWixwCtWyfa85KGjCiIsre9jpc6t7T+10J/7PDkW66nR6tyZ0jJ
 2Z1ttHT4hDoZNhvjmeEGKzCgeZiiXapfMnSwFUA9dikLCFmXRDywflk+nbSaOIdluU55BY=
X-Received: by 2002:a05:6820:4488:b0:6f8:2346:cd8e with SMTP id
 006d021491bc7-70ba0f88425mr5371206eaf.80.1793119260577; 
 Tue, 27 Oct 2026 09:41:00 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9e2cd81bsm9697932eaf.14.2026.10.27.09.41.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 09:41:00 -0700 (PDT)
Message-ID: <962cbd51-d15c-4a95-ae22-153cb63885b9@linaro.org>
Date: Tue, 27 Oct 2026 11:40:58 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 000/100] tcg patch queue 20261025
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/25/26 02:17, Richard Henderson wrote:
> The following changes since commit d73149283205645625bfa9fe029cfb68e4c4a9ae:
> 
>    Merge tag 'samuel-thibault' ofhttps://people.debian.org/~sthibault/qemu into staging (2026-10-24 16:09:37 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20261025
> 
> for you to fetch changes up to 0509b1a38002d99c28e24ba96a89c75ac08d9da7:
> 
>    tcg: Annontate functions in tcg-op-common.h with QEMU_*_NONNULL (2026-10-24 17:14:50 +0200)
> 
> ----------------------------------------------------------------
> tcg: Generic expansion of integer opcodes.
> tcg: Annontate functions with QEMU_*_NONNULL

Applied, thanks.

r~

