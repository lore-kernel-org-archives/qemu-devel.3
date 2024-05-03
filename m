Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E96C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 13:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2sWU-0005Nh-AG; Fri, 03 May 2024 09:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2sWP-0005NH-HN
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:00:18 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2sWM-0007oH-Ro
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:00:17 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-23d175cea45so2037626fac.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714741210; x=1715346010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KSYRKl6qnCPQGEGDoHXB2IT55HLFPg7YrtUx+Y+iDIM=;
 b=l+0k6QkR/aQKnNAmYPQFhHpLmv0GDu0/2M7g3XL+OBhwuTdojRjopoz4jAS0bI0Hq2
 Jp/O47zWs0AMv+1CxHZnCnZxR8hfZG1P4v7tz3s7UC6B2426EVeziMUSe1+lOEvHz0F9
 /xBWDP26iLTRNXQwcKufGmGc/3xrNjGfQ8OiPZ9glyits2ayWJYPqg1BJDhPEQDwixBL
 87XJ0CCdXAsVfh7svxVTn25mZMJRkbenSq27tt+gs6BNBgziPIxdkF/SaNQ8rWs/JQRh
 58Syza23OvxmMrA8n8dNByYPmHPqjEGWXjnsJ4NijzQJTYTKBaeymIjKvgvfUcfsS6Gs
 dOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714741210; x=1715346010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KSYRKl6qnCPQGEGDoHXB2IT55HLFPg7YrtUx+Y+iDIM=;
 b=BPL0zaF6M3Yi2yNCxYdc3/jtVqFG9RbLhMvxEvAnKz/nIM+9xeoXyA3zIKmlWxJcMW
 EFmkSe74QIcVfgVWTblM50G8jvD0ugruNph1pPMZc1aYAhArQoxsb5tzDxInZprP83lQ
 0I1uG+DlCxpBH6HUHjqST5YfwIygVBVci2FFQoMoIavNcfaFgkHuTeKay9RAsK9UDGww
 3DS48oYORC3Tc/ApNSPZ8vng/oBU7Zhbt1w5ossBWkETRsdxv3dhMo3rojpEz3uejKC3
 xIPSbVpJjm5gJqGHJXQklV7njvttnu6BNwBBVIbGGfNw0oqwG7rQ1EeKdEaXERutHOz8
 dEKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJC2+SFMuYt7AilWDWtWc58LO4N+mAuCgDlGzOJYeZmKV6Xezu2Lvxo/fCT7UQJaWUzboOzHg+Hqo2iD8Xpmzxx9gTy6Y=
X-Gm-Message-State: AOJu0YxxGKnXklD0C7ZQzcExpHK5GaUiBeJgmaHyrocTfNWVgVAgPTvB
 xnhiU/EbL90khavljIeUUfq0DiVP8buut/MSMx8G2ZOxOuAfCs7YmjqfyOyW4sA=
X-Google-Smtp-Source: AGHT+IEu6HbfXJFeU6MDVpIG3PLmiUlf78qUz4g98EK/hZ9jBLC/IEUCItS98RScfjMVb1l/5IdgSw==
X-Received: by 2002:a05:6870:a918:b0:23c:ca14:bdd with SMTP id
 eq24-20020a056870a91800b0023cca140bddmr3162204oab.47.1714741210011; 
 Fri, 03 May 2024 06:00:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p27-20020a637f5b000000b0061da540631csm1147494pgn.33.2024.05.03.06.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 06:00:09 -0700 (PDT)
Message-ID: <a2cdbdbe-b4f9-455b-af5a-90f907ffed97@linaro.org>
Date: Fri, 3 May 2024 06:00:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec/user: Move 'abitypes.h' from 'exec/user' to 'user'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Riku Voipio <riku.voipio@iki.fi>, Kyle Evans <kevans@freebsd.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240503125202.35667-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240503125202.35667-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 5/3/24 05:52, Philippe Mathieu-Daudé wrote:
> Keep all user emulation headers under the same user/ directory.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Forgot to include this patch in "exec: Rework around CPUState user fields"
> https://lore.kernel.org/qemu-devel/20240428221450.26460-1-philmd@linaro.org/
> ---
>   bsd-user/qemu.h                    | 2 +-
>   include/exec/cpu-all.h             | 2 +-
>   include/exec/user/thunk.h          | 2 +-
>   include/{exec => }/user/abitypes.h | 4 ++--
>   include/user/syscall-trace.h       | 2 +-
>   linux-user/qemu.h                  | 2 +-
>   6 files changed, 7 insertions(+), 7 deletions(-)
>   rename include/{exec => }/user/abitypes.h (97%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

