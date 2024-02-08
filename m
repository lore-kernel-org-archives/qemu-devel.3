Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4D0C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 21:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYBjG-0001AW-KZ; Thu, 08 Feb 2024 16:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBjE-00019s-8r
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 16:14:40 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBj8-00059o-S6
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 16:14:36 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d8da50bffaso1489275ad.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 13:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707426873; x=1708031673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uzOdaFIhHCNFkEwO5ZqaaJ4UYQlmsjt1EeOWpRjy4TA=;
 b=nY9+iPrc5VVvIqU0ms8nKLcZlZ/k3EMsN2RjygoBFVrMqWO7ruQMeEefFDwo4c39Ba
 h4ARKsNYoDvu/MrR9cHt5pMbjKSAqBxiIPEFFoK0JCdX6xCtpiPI+qT/REXvZMNxyVuY
 GztmoydnedLUbe1Sw0KDvH+lDSWZh3tDbhxgg7PacVdEd7c2ZZpYAG+KycKlSN/qX6dv
 cONzno3Knkv5lTBRELh6+lbKfElrcAVxaibfD5chSMVx7d9Y4EEuifpoNehcuJTZuAPY
 LSc0i2AaxyCV3EXm27AS+U38RpfDS6asIPOhMmw5O8P2UUcuVTsufrUfXqUshzGeKGRG
 I0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707426873; x=1708031673;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uzOdaFIhHCNFkEwO5ZqaaJ4UYQlmsjt1EeOWpRjy4TA=;
 b=AVRcnMPnx8Rwyzz1ZbwtnG6v7455RJeyVggAU+Wf24ZLJW4IJ/GVUcUEH/gDSxuizW
 Q6qf6NbPSVjOan8vcCp51b6/I2MvEdZvNL1AqY0SfPKMHAhcZuOZn7fjp1DTixcRQjLn
 6ozSbOuRgQsHb20cXasvOe6ToOyGg6fv1NT5Si9b9gcK3GqyYwWqCXg/3oroaJJYMYW9
 Ctwy/IxN6CrzPOaqafY9ol30clRDLNiqrjZwlVCnvd12N87+caffbZCNuU6Y+mOaivrY
 J1CJH9P1eAHVe6SRqAzA5rimCt/85OWch5zKG58t7ZNnrnLhwZcxNDIYbsdNjF+TbPps
 ke5w==
X-Gm-Message-State: AOJu0YyIgli1ZulmGMCPfVB10k62lZ9zu9fJYws8t6Auv2dkco/z7eac
 vgjqqf9QwFnHLYTuqp8hFYtUDJvTY3JndwXD038tyLykSJWdBoHvs7nIVCFC63s=
X-Google-Smtp-Source: AGHT+IESiHP/YK+u11vogJIQmrjqUdgGOk6J2BH/nXZK1UtFKfw/MqSYR3uriMW6wxrX4+DJU2WK4g==
X-Received: by 2002:a17:903:2ad0:b0:1d8:deb5:3390 with SMTP id
 lw16-20020a1709032ad000b001d8deb53390mr483783plb.42.1707426873352; 
 Thu, 08 Feb 2024 13:14:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVV4issy7JbKL5SkRuEuooTmri4LnqXoolME3XBmX52h5b9s2fotBj8PZWoax6LzGJUsv7PD//rQfHjZoBmPaWVGG8wl9w=
Received: from [192.168.4.112] (066-027-223-101.inf.spectrum.com.
 [66.27.223.101]) by smtp.gmail.com with ESMTPSA id
 jk15-20020a170903330f00b001d947e65ad8sm199627plb.251.2024.02.08.13.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 13:14:33 -0800 (PST)
Message-ID: <eae9c8de-ac34-485b-bb0b-f2903f6ba16d@linaro.org>
Date: Thu, 8 Feb 2024 11:14:30 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] target/hppa: Check privilege only when PSW.P is set
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240207182023.36316-1-deller@kernel.org>
 <20240207182023.36316-11-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240207182023.36316-11-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2/7/24 08:20, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> CHECK_MOST_PRIVILEGED() should check the privilege level only when the PSW.P
> bit is set.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 7e58775bbf..21c2734a1f 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -604,7 +604,7 @@ static bool gen_illegal(DisasContext *ctx)
>   #else
>   #define CHECK_MOST_PRIVILEGED(EXCP) \
>       do {                                     \
> -        if (ctx->privilege != 0) {           \
> +        if (ctx->privilege != 0 && (ctx->tb_flags & PSW_P)) { \
>               return gen_excp_iir(ctx, EXCP);  \
>           }                                    \
>       } while (0)

PSW_P is documented as applying only to protection identifiers.
I do not believe this to be correct at all.


r~

