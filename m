Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F125606A329
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jnmP5mg8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzIE-0005oV-VT; Fri, 27 Nov 2026 11:59:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWzIC-0005oD-Uy
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:59:24 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWzIA-0001p9-9C
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:59:23 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-675617e81f9so9490799d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 08:59:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795798761; cv=none;
 d=google.com; s=arc-20260327;
 b=p9/yD4NxM3+Ob21ljaAFnv0ob65Gc1mSZO5KuagfGvz+aXkmnsTtK8qjmB+cllZJBv
 fj3y74Badnr68SDg48sMi+mLP0KQu/uyssCwy2ANjttXc5xFXhgyqwPYa+vwK8QAJWch
 y1BxDHALJjbyT5WjmL5b2lFTaC0wx/rqitGEU8gBRUsxLER/BrxfEPBUo9fkiBB75ANr
 33ycnOI8oeAjfwMOrGuUFMRFcQtSpPuJkoXM85Sj9wNLK4ifiB+bAKZ8QrPzNCFn27W4
 9pAchtzfWU6Tv8rJHSegbCxk48No2ysUsnye/Xm5JpCNJ1tKDtHFjXCB10M6nmPsvmY6
 OEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GeFLhbqwzoVWy/zuAQkq6ufr7qnIgWRpiaAOFkp4eqs=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=i8eEhek4sNu14KnFYzNeA3m6Ew/CzvNd9qEZ9BIWzRKdgD1px36IBtOoo/bASk5u+2
 Pe1u3PttYuR8iWOO5GjojxuGLTsWE2Xv/LsXbJTZ3QN8SDKIP8p1FNLGBuG0P0eeFXbC
 R3DZy949DtIUeupuVx7erq/UBKKoVIwW2hh/pV9M8eJllAjA97xvISoajBapSc0lJh3k
 e2SR8MSNYEZPBhyKdgfySMIS1vDhr+WQeDQCZqXYt7IutAi1AXw4ncFSfcN4lS4h71KY
 ylSCA8YiEOBFywFH44MIlj+4DfaThi3J/v6LzaOUDIPE+PVwUWX/fvU82Ayb+a5iTakF
 MxjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795798761; x=1796403561; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GeFLhbqwzoVWy/zuAQkq6ufr7qnIgWRpiaAOFkp4eqs=;
 b=jnmP5mg8tdDeGhnMj1br2J0IAtPAg/bwQUmrELIR+fzRZ1FvA8iN8NYdIWqqQwKZ5o
 G/6m0mUwfEr/Cn8SetCrzGmcdvHyORgDMMZVK0zRb1Pj3EAMMyiShMXids9V28Ibe4r4
 LzUJdcjGQPDAY+SdMVVnSKya3tD7M0D/Nz6PVZ2H6Mkk/ABFwlBlft0KAA85CupVu5YD
 KM1n7/SKXLwNMMlgt3XTfr3xhkOp8PsdWYs/6pSPqWu+iU1ZcBtYpBk4QdJyha9NYzdl
 WhvXv+3TVR2NB7E6zL+FQ1dX/q76H9D2sXz9xaWodM+Avr4unwQJZjB6wXsl6H0TixT9
 sxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795798761; x=1796403561;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GeFLhbqwzoVWy/zuAQkq6ufr7qnIgWRpiaAOFkp4eqs=;
 b=wEohgQ+2smygSx5zXwB2mkfmtcqEpXqec2uqqxACUotPtkOIxMqA0ayTDLzKJncm28
 wFy/pV0ZlnI2ImhHVDyRpCwZ+LyOw1rbS6rYPhQgAiz2A7TgHXVZmZg8Nek9AN9kB03g
 3aMLftY+HtN/0+1CYtxXaVmhKemLWfWQuywSVYaH19kYwa6Lv6VVK/x7gRoTKgvafg8n
 1vZXrKZNa5NIAjO9YCCpeoLDpPwQftTKAjm7GTCXoo/8LM2ouOgzpWvxP5rb+pMMjVI2
 ZDXlKHUauqBQIOWcz1mHDQ0DlWdmdNCOB8DCm9zyZiXorrtxpcXxxqSM2+syzCCJheZA
 f//w==
X-Gm-Message-State: APuU4Z8A7NdRKDADb8k7eGXwrBTO8pIBESlPSCd0Bkigf0Tc7eFtPs6b
 zxtM7+yEpHArNziuX/BILbl+9+KrzGcrsrfDpOKpzCemG5lNPlAcubC/VETyncXJoKqG5fJDuQP
 yQi7/wtJNauV3f9y76GCD4fVbhAG9nYpLAixxvzuDaQ==
X-Gm-Gg: AZFdTZc7Sox3w89uwBQl0Y1+AxURfJAjiiU23PsNU1pd60in7LRiw4kFfdXyYbY+FeZ
 KAEM5lt0IVHCUmn9Orgb1OwfvEbuivdc3beFqFoRWYbiHOWt3u9DTy/z0lQpK8VvInGlyXZjyRA
 FmDWl5yBTHdLKJzYdOQVDy82QmcSjrt8iwWtfhKco8y9akiGwGw9scGhz1/oiloBnKk/Hp4VssG
 sNyWwn8w8/U0VGQysT44bNXgFQ3VCrCp1VQbfMtphQNbL0uHG7M50Fuceu/L07Y6MdG8/lYLvsr
 qgMNyjxZ7gIsFOFAtlPjdqzxFY9AxhgrVt5XQJAzNA28kG/eDQG82bK7n/GROzi16aG/L/UUiQM
 ZqPoupJWD/NPxDWz3/LTyK3R9OmgFT+h9aRHG8B0kUiZoojHS5RAQAt3FQTWxtL/nCFbgCngtza
 xrK31qRBMA4y9c4mfei8Lu
X-Received: by 2002:a05:690e:bca:b0:67c:2b1:dd40 with SMTP id
 956f58d0204a3-67df4464afcmr9958304d50.85.1795798760874; Fri, 27 Nov 2026
 08:59:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030194318.319310-1-richard.henderson@linaro.org>
 <20261030194318.319310-9-richard.henderson@linaro.org>
In-Reply-To: <20261030194318.319310-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 16:59:09 +0000
X-Gm-Features: Aa3M54o2Aeodkzqcb9opwOqCo4DeMdZ_tkg1aQvdSp6N8FPLdjUI1G5nw63PLOA
Message-ID: <CAFEAcA8FjMNokA_9dKeR=qKR7YFOrsrEPmjL7368tfjyTzhMGQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] target/arm: Rework gen_goto_tb to gen_direct_branch
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 19:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The only remaining uses are true direct branches, or
> simple chaining from one TB to the next via fallthru.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

