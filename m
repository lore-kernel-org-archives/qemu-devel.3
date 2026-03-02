Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986EAEB3624
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 17:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7PV-0008Od-5M; Mon, 02 Mar 2026 12:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vx7PS-0008OH-6t
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:50:22 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vx7PP-0004JE-VY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:50:21 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82728e5680cso2559197b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772473815; x=1773078615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=66ro48Zzfj8FQGYBcZHELoDQEEWrI/qZ/UDSu0apV4k=;
 b=YHt835RRQMiwQYLmv43gnJF6DdtL/ILt1qOKTlGRnUBDx7wwtZN099ToGfTgxsvbPf
 Arf/AZilF28G0VoHlc0hTPDD4OAmJZVnAzxsnDmSXU4nMOVmJSGvk/2BoXi0/2CJ/PMN
 +/OXcmdYEp6zaw2ktjzt55QWG6TU9Jklo6HjG6ygVBsGMljpIwL4X8RxZoLws10FAgsL
 blkwP5glRhRBBBaFVmOXChZMmZcFYxMAv6ebCL/xXyl6/cUj2ZrOJZVqxhOkUO3zvToE
 cPJTqi4A2XaEUuYKQbZRf7/ffKCKvOE1W1BdVTyTlUAdLj1BXQ2E1POGU9xiaoqznL/9
 c9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772473815; x=1773078615;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=66ro48Zzfj8FQGYBcZHELoDQEEWrI/qZ/UDSu0apV4k=;
 b=ZE53brCc0lVkRIHom5Ra0UuUafRntUJVo7X115/9JlZezN0W8+RJkP2keILVgZdasD
 cVTfkS+aOHM6qmxXmGkf4CKl4iH9Dccy6FpTvgQDDF+au98AFyFLI7UsUKnhzhTtn+lS
 3NVN0rg/EFhtHuqfkr62fmiGixY6CjE2QssVc+skKgsSDKQNsCLnCHO+ztDONxgCo/AR
 xDSdXr8vXae0gRTXO1uixWcV55jytIkq0aQMqHah1p0BRSnFB4le/d5H1qKPa0oRKfyF
 AXcLJl5GwaBoWNXaJ7RFyduPOOT7+9jeGPWzrNHWg40tUgO08+23Vef65rtweJHjDN0F
 t3tQ==
X-Gm-Message-State: AOJu0YwMiu6aSKbfVuI+yhWqzr22n45MVnrHL3YnJe6OGkP7BDpFwOY5
 Zfrntg/I+9a146eBhlXQ/Ii1t1Tq6fFiHprI0Fe7DDGcSWzRctZPwkBUsOnZDX2JlVc=
X-Gm-Gg: ATEYQzyYrNj/kiOnmEUjNFgTJuuO9v0BWc0ozd7I++3l066eJGgLvWX5jjexwL4xTXB
 ny9Tt+lwqW+yuL3TvHIHohfYIJ+9zVxGgr7ODZhRLWJzasKL+Tn5mzzQS5nUzs6BbT6Fz4Fi0i6
 o/MZ3jinUNe091e6b100eF9M8ufIXLn3i+bJJkFSLNi/WZGIqF15brMnisBB2UBfMad8dRjJgNA
 W4K3xaV+Sb3V69r8KsJsq6Jd39OrP8vinZuXsrH7sBt2Q3VPArwBkigmz3tiTlaFTQuRWB5VVqG
 A/2qTcb6lxKNA+3slz7gWBUnHytYnQFDMYjNByXVdkldkeLS6nfWsNMB500T0YXFGPh2wWm3KN4
 wNTSz6K7eNvpduYy5N7ia2XCy/CS0oB9NcPYljAt6JCGDTgj7c8LUfMofd3YcLmDMBQ3G5eLAXP
 hv6z4+7fsILivhd5xeE4b8raFnVbGsc+uCwhDUI62V3ZpoqJrJb9qyp8H9Ka65eKj6MU41
X-Received: by 2002:a05:6a00:339a:b0:7e8:4398:b34f with SMTP id
 d2e1a72fcca58-8274d9ebde0mr11380142b3a.34.1772473815424; 
 Mon, 02 Mar 2026 09:50:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d49423sm13799693b3a.4.2026.03.02.09.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:50:15 -0800 (PST)
Message-ID: <535bf813-7926-40d4-b0de-3cd181dbcfa5@linaro.org>
Date: Mon, 2 Mar 2026 09:50:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] linux-user: make syscall emulation interruptible
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, berrange@redhat.com
References: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
 <b280d4ad-522d-4d28-b203-b87f114d0d81@epfl.ch>
 <CANCZdfqML5j5TLOQn2vCNAgxF9iWrL=92x_+oL4_NOUUJqt+-Q@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CANCZdfqML5j5TLOQn2vCNAgxF9iWrL=92x_+oL4_NOUUJqt+-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/2/26 7:15 AM, Warner Losh wrote:
> 
> 
> On Mon, Mar 2, 2026 at 7:03 AM Florian Hofhammer 
> <florian.hofhammer@epfl.ch <mailto:florian.hofhammer@epfl.ch>> wrote:
> 
>     The syscall emulation code previously wasn't interruptible via
>     cpu_loop_exit(), as this construct relies on a longjmp target that
>     is not
>     live anymore in the syscall handling code. Consequently, longjmp() would
>     operate on a (potentially overwritten) stale jump buffer. This patch
>     adds an additional
>     setjmp and the necessary handling around it to make longjmp() (and by
>     proxy cpu_loop_exit() safe to call even within a syscall context.
> 
>     Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch
>     <mailto:florian.hofhammer@epfl.ch>>
>     ---
> 
> 
> So bsd-user would need something similar, I'd think. But it still uses 
> the older-style
> TARGET_EJUSTRETURN. With half of the archs still out of tree, I'm not 
> entirely
> sure the best way to approach this.
> 
> The code does what you say, which is good, but there may be some subtle
> reason to do something else.
> 
> Reviewed-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>
> 

At the moment, syscall filtering is not available for bsd-user, it's 
(sadly) only implemented for linux-user. Which implies that current 
changes are not needed for bsd-user neither, since they can't be tested 
anyway.

Regards,
Pierrick

