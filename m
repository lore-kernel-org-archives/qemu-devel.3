Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802D0C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 21:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlEsn-0004aN-Kn; Fri, 15 Mar 2024 17:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlEsl-0004ZP-Pl
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:14:27 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlEsi-0003B2-3z
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:14:27 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5a480985625so500878eaf.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710537263; x=1711142063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fh8d2zstOCftc/dKsTY8TyD8fqXCj/7SQaJVwSfrd3o=;
 b=hLvO1M5M4QG5DswfKEeIdcXpgFgHxjiRHJjq+jdkm96MFJu977DRtZQmEsRaU4Og2c
 FGlMKnVyFxbfZMlobRabSEKLq043k37mTXgkDl85bD3KiarxzHQfDrCwliAvf9+MIT72
 N416SWP33aUY02Z+A8aoTUucNu9RpTrY2mawbB4aVbORczKzgANVl4aBZ282jExSL7YJ
 CRK/HoQ5emmfAheLlbWQ91NqsY2/PsiTpzaO7mRNmWGNeprVdV1duAuhPC6UQp/p18Km
 LtKC6+WU3I1NZkQdMTLFDR5TjOcfU0Bme9/HejEQqQWVRbE91UzDs2b4E8wiglJpTk2M
 C32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710537263; x=1711142063;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fh8d2zstOCftc/dKsTY8TyD8fqXCj/7SQaJVwSfrd3o=;
 b=gmmQ8J3ghlVeiVQRqSpyxA2Ce7wUwRK/bfhFxov2H1clMqWXCNq00mUA/RPccQXsoz
 8twhT2tEhuhzdIGD57lA8FMPihtnKNpdzFsYXHeZSec9lRns9qOLNH48PlQHZTcFzwfT
 HzITP1T7THgrx3/xACVYnc/eofrqWjJpdbdjg9KDtY585dq7v1/XL5YxpkSPrmBZgOyL
 /4js3kuxC74JS+gI0/2wRn7sBy79RFk/MyCKUKo840SVV5Ab+KnjVwuTT3A+7+HbR9G4
 bnPp7HC5+4vkjPXlfXFA+Byp7G5RAIk8YSWhNa8ns16Xq+7TPkmTXsg8ztwzN5vatU90
 s49g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF0TP/KUMaO7VVstxdqqpqZ/pRM83z3nVF6JwAs3UfA4bSlfiBVxvSHR76FXzx8MBQ6Si59KPBMxj+49sZxdbRsLy840Q=
X-Gm-Message-State: AOJu0YyUb6zFnBLRaGImS0/OCv55eiz7yw4Gljz/NV9nSuf6N6nt51E5
 8zdbwVNtqdV44xmLMrEvur5jGhhMlJJJyY8SRYCLf+IywPTcHaj1yNXju83ymvI=
X-Google-Smtp-Source: AGHT+IGV9/ypl8JZYY1JouWuHsZN3IlRopjiwEzAXDkyU17J9zpqIAagalUlugXt6no8YGJ3JmgMPw==
X-Received: by 2002:a05:6358:520b:b0:17c:263a:5b8e with SMTP id
 b11-20020a056358520b00b0017c263a5b8emr4919518rwa.14.1710537262821; 
 Fri, 15 Mar 2024 14:14:22 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 w13-20020a63490d000000b005dc389409c1sm2900217pga.93.2024.03.15.14.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 14:14:22 -0700 (PDT)
Message-ID: <1907bcad-4b98-40e4-a52f-d79a1f48305a@linaro.org>
Date: Fri, 15 Mar 2024 11:14:15 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 04/12] gdbstub/system: Rename 'user_ctx' argument
 as 'ctx'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
References: <20240313213339.82071-1-philmd@linaro.org>
 <20240313213339.82071-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313213339.82071-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

On 3/13/24 11:33, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   gdbstub/internals.h | 8 ++++----
>   gdbstub/system.c    | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

