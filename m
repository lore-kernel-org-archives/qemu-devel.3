Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43794C4829E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 22:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZega-0002ft-Cv; Mon, 12 Feb 2024 17:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZegW-0002e8-OS
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 17:21:57 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZegV-0001dY-31
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 17:21:56 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so3108776b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 14:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707776513; x=1708381313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cyqff/kE7nGx+lsHGo1/Z4ql3bDv6ArKL+b5MM/Ueic=;
 b=qUhryDdKt2t7fKO8xvz0fDl/K5IS3glvUmhE9upnxgjljXlPoBEOqbj9ni7XYtdZ5i
 MQ38Zlbr9QkveLFzgA+oVNzpUQh/BXYZT7X0LAei/kK0uoAkKRxz1+Wa62B/QSd6JJuJ
 lmcugY+suAXOGO+Ulw+qpfVV473bCufwjlvbGXVS5rYQYrZJDGDI7eY50cqCozyjMKRL
 L7GEdQYhr4Ecj9k61Q/YBPkkjwYwPltKNDSLwarhO5jpeMGqZoJm3xjgdRtDcfXuu+hD
 qIU2qcnnmKoDxJfFNIEfmu2lh9V9EA/j3C8O0LHFpMtesTs+ewzAIgoGkGTWIZLMoNLH
 cRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707776513; x=1708381313;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cyqff/kE7nGx+lsHGo1/Z4ql3bDv6ArKL+b5MM/Ueic=;
 b=ljZDS/zHMVUQq2JhCxGUzGT4Or0Gc5XvP9aB9yLY7p08BY77zy/QftNleSQPSmMC6l
 yt6nBUR1eZKmhk4wxpoDBbyqXcrtSOEhL+apFLbDP8BgYUMxpQu+4IxfTR3InDFQHl+o
 pVLf/O2Ie3a2U9SkPp2y4rGQrrKYZ2PLdhLqnncyQJrPGfKrheT8jf1liOW6zELzCyYf
 JwdwwXmsBkEUqgWVaVs+6vIrgY/nQkqNb+dp3YI9Gx/ZHKuf9WWzGuAw4jAIXgqFH5UF
 5wwehhe7bxaK3UDEqbqf6LJK2qCbOUiuijQdvmTeW3AeoFdCtDHBFGsPIUjGrOd4FAXW
 sdCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDQ4+2fUx+CmGJkA5ZOzBpDh4h4pj2LD3zjUGC/L1NUxvCIUI+bziPRidODmC5YKkJiril6DitslP25jWdP/3COocbQBw=
X-Gm-Message-State: AOJu0YzNTiZaOucCezjpe5z4uIaTniqMa3Sj8CFGeMbCTpQmbJSarhpM
 XnvaGxtj7YZEWlEI4ceVohnIlDn0BUg6E+0mid+32fXdvnlLxQlRmmy2U4BL+66SLxuMAOYlDoD
 x
X-Google-Smtp-Source: AGHT+IGXsNneJU0R+ik7q5WQd+sP3pFMmcJnOmoy/gPl9mnTjp42tfKWJfP0sl1YcR8dfz3RZXdgNw==
X-Received: by 2002:a05:6a00:7508:b0:6e0:9f24:af4a with SMTP id
 lw8-20020a056a00750800b006e09f24af4amr8080152pfb.7.1707776513149; 
 Mon, 12 Feb 2024 14:21:53 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXbXiplDxvTbjyKNr+PRtaXjn1+/B2r9Nk8gLuPsybfjkUWQTq6brFgTljtVv+Cc4PBpLJ3pxjoeCRm8yNI22kNjrz3lWgvTFvVI4kkRIr/2WbWArPzd4dSmX8am7ETEhpdRUAS6th6umIVTbtA9ez4ZcnEA7qEtIES47svXSh4jMq6
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 x37-20020a056a0018a500b006de11c980e5sm5932251pfh.80.2024.02.12.14.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 14:21:52 -0800 (PST)
Message-ID: <f07f918e-d7b4-41bd-88eb-ddb2bd96dd73@linaro.org>
Date: Mon, 12 Feb 2024 12:21:49 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/ppc: Move add and subf type fixed-point
 arithmetic instructions to decodetree
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, npiggin@gmail.com
Cc: harshpb@linux.ibm.com, sbhat@linux.ibm.com
References: <20240209113532.580983-1-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240209113532.580983-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/9/24 01:35, Chinmay Rath wrote:
> +&Z23_tab_cy     rt ra rb cy
> +@Z23_tab_cy     ...... rt:5 ra:5 rb:5 cy:2 ........ .           &Z23_tab_cy
...
> +ADDEX           011111 ..... ..... ..... .. 10101010 -  @Z23_tab_cy
...
> +static bool trans_ADDEX(DisasContext *ctx, arg_Z23_tab_cy *a)
> +{
> +    gen_op_arith_add(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
> +                     cpu_ov, cpu_ov32, true, true, false, false);
> +    return true;
> +}

CY != 0 is reserved.

While you could diagnose this in trans_ADDEX, it seems cleaner to simply match 00 in the 
CY field until a future ISA defines something else.  All that is required is a comment in 
the decodetree entry.

# Z23-form, with CY=0; all other values for CY are reserved.
# This works out the same as X-form.
ADDEX    011111 ..... ..... ..... 00 10101010 -   @X


r~

