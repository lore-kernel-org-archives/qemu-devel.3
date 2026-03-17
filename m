Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB956FD8752
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2TDa-0003Q4-53; Tue, 17 Mar 2026 08:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2TB9-0001XL-Vi
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:05:46 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2TB1-0001zZ-Ea
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:05:40 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso3969492f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773749133; x=1774353933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/8H5f9V1b4EuZBVKlgbOgqbu+Z/LMVrj1yIhPrbxncQ=;
 b=xqnljpV1w5hnWTLNt0d0dY4xe8ykYcQKnFZsuu2ulflzzG7nDE8EYD8oT2g/dEkRRV
 SdmeJTNroLV7vgwUpxF36SuRzDuzFwh2YLESBzg3tAnhAcs9ZQXYtDeEYCMISdDcfUCG
 GxgYRSLL3NPcH0PiG4ZBRZDKuZvtdFpo8GvuxvQN0A/Nb3pIJzSr6dmaK/YFc36m9Eu/
 RAh1lkhvjBES++C6KCcQtNbh93pfnwjJk68gA5r5zjgmcxr5c7AkWSf7NyGFwaCfwAzo
 dTczcMFngmGOuxqNgotdHHhG9lc56m260W2ieKrAjmhhXKvdxIN3xxP4WQZdnAeF5iDk
 WHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773749133; x=1774353933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/8H5f9V1b4EuZBVKlgbOgqbu+Z/LMVrj1yIhPrbxncQ=;
 b=o+cwz7fdhOaeVKEO1fiHqPdMQHKThdVEiogQXSFxscWAqf9zgbF37T9wRo62jg7gWE
 YwQ8kGN69hjP48QZMgCirWHgCJtvvn5pZsoJOhJLeOHmKgHw5eqvd6J0u+vU5+u8tjeP
 4qyJHwukL3UN6KXpUBuGOncTQzpuYPLhbQ6K1LF7RMsBqz2GW2S88lVY4xpQZ5j2NmCQ
 Hu4LOx4zhY7vu79pa4JaRf/9bsGVdrOHzSYItbgnzCY1Vm0JqordK5yorWAZY29hkjLy
 Jsvo+6uKn/ciIYMCdQ08VTxhq3cH845CjATOXf0Y8+3+bPJhIIG5vE/vojIJp0lymsfz
 pMeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwBSC/YEa8aidyxnNGNs23ncAIjIS9bQADDOrlEYpTE5ufWoMJ2sVz6qeR2TRbSuuT0OvpX1yCYweX@nongnu.org
X-Gm-Message-State: AOJu0Yz2WfRE4FkcefF84BjIv61tLrot6GXnLMjoH/EdaMRn1jrT7iEM
 MI2gXqQ2LmrAf+PtGtdWBeriUqTpJa1NmAhscN78jChogJ+SscRu+WTVnzTQ4ybMnwI=
X-Gm-Gg: ATEYQzyyk96cOMVFqnGj0jucSvixwfgXThxExdGapanUxenmZt6c8PlTaOlU5ieJNTf
 yBwhHyyxC+AGC1aZJf7eZLPUrUGTTuMh5uF+CpqfcFkMdPqRx7CspRFB2fxDf2knWsIcMRoB+lj
 qIyVrdIrMUJVu7w5T7kK5RdBtSpheJDwiH2+9n3MopnQU4YQLyZg8Qf7fRapa5rrM0L6/hy3wXy
 PpAUNVXPLlQriCNBl2y1aIjbPYggEzMTdObR+ZjNDCYnfPczpDyTx034RW7fKocJjyS73l84f4o
 10DOwv1yEJ9I54SFYvexcb4+mHLQkIpaZtDmq6vUpm2gmDQjodqpk56JYMS10VGj3CrfkFPeW2X
 bmIuMOua3+JYFzcqlULdMXbZtosGYDF/Hmax5angMslFD+VtM0z4emKIyOEB6LKhyfDwzOCGzqv
 LRwNQ2o+svwVCtHY89ejhmSRZ+2iSKeEEcmrgh8uNTnftfIiYIYsItMutn3RUQGxC8EQ==
X-Received: by 2002:a05:6000:26d3:b0:439:c550:d933 with SMTP id
 ffacd0b85a97d-43a04dc3108mr31548451f8f.41.1773749133108; 
 Tue, 17 Mar 2026 05:05:33 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20c473sm53032062f8f.24.2026.03.17.05.05.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 05:05:32 -0700 (PDT)
Message-ID: <596137df-e936-48e8-aca2-b0a10d98d2f2@linaro.org>
Date: Tue, 17 Mar 2026 13:05:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: Remove unused variable default_cflags
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260317120215.2075164-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317120215.2075164-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/3/26 13:02, Peter Maydell wrote:
> configure has a variable default_cflags, which was originally added
> in commit bafe78ad3bc4c ("contrib/plugins: use an independent
> makefile") as part of it setting up the build environment for
> contrib/plugins, which at the time used make.  However, we now build
> the plugins with meson, and in commit 55c84a72aba4 ("contrib/plugins:
> remove Makefile for contrib/plugins") we dropped the logic from
> configure that does that makefile setup, leaving default_cflags
> as an unused variable.
> 
> shellcheck helpfully reports this:
>        default_cflags='-O0 -g'
>        ^------------^ SC2034 (warning): default_cflags appears unused. Verify use (or export if used externally).
> 
> Remove the unused variable.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   configure | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/configure b/configure
> index cd1dadd8bb..42c45fe47a 100755
> --- a/configure
> +++ b/configure
> @@ -248,7 +248,6 @@ for opt do
>     esac
>   done
>   
> -default_cflags='-O2 -g'
>   git_submodules_action="update"
>   docs="auto"
>   EXESUF=""
> @@ -707,7 +706,6 @@ for opt do
>         meson_option_parse --enable-debug-graph-lock ""
>         meson_option_parse --enable-debug-mutex ""
>         meson_option_add -Doptimization=0
> -      default_cflags='-O0 -g'
>     ;;
>     --disable-tcg) tcg="disabled"
>     ;;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


