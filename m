Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011C3E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 16:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkEM-0001hh-2l; Tue, 14 Jan 2025 11:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXkEK-0001hU-Sb
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:57:28 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXkEJ-0001xK-CJ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:57:28 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so9782114a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 08:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736873845; x=1737478645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=khOj2ayD/Bsy9rdJiin+lRbKKaKl3IiZiYPQwlbJzrE=;
 b=t3ERjwfHRsgXZW5AdTnYPX959IVaenBYQdFthpDlX822yFQEoyrgG//PG7y6hxwUaW
 aWiSxYNood8L7+U3h1f+sNXVtrtSka1X8TjR7d13mGdUfRgk6rKBzErHwBEqbbYgd51E
 ujX7KGFZxhTLEkn3rP8kBLa3X2WMdtqIbbvFSPbW8GB6EK8wDO2WWFd2IvDGrZTt0htD
 s5dMwCx+zJ5VJDCCfl+n+FPUBzUBY8P31kGqUkM35B8i5iTvf/r40hL8AkIUXK6qUhFE
 G0QFu4dglyodkZgLPIYvPgPS5/5RRGPLV0serq9eVZMtx//BSIGFTNbu7m0Vgqd9Dptd
 dmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736873845; x=1737478645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=khOj2ayD/Bsy9rdJiin+lRbKKaKl3IiZiYPQwlbJzrE=;
 b=TEI/Ucl2somThCDM5r7YhWachhwkh/HcZL5dpmp9usJLPJyC9Vn8uNR685PmUzQwIe
 Pi7UhzMm7PvXDYIzrRGcJNkw/xCfKxvNCPRkCG5mOviH005sEvmb6UKS8pWpVHVwsCoh
 O12Ye97j/Vd0qj9EJXPn2GnqySEsSgJhs71qYD/yx719mZIze41rVg9IXkiXzW4mxEwN
 nzsEOkC82Sq5gHqENzb05+a4LAuB2XrZguBs452X4RogE7YwDV2o4X4hMh/ZZ4p8tQA9
 tFNrWODEN0i8vdLNtuTmyZDUR1nzkeOmLU3OvF5xM85tsPWsUMX1u50c8BuC1xut/+Da
 D+/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9YXGEjzW6Eb9IwEgj3B4kISI+jPBYp/fgsnfvhOBl8Av4XVAGSh6ZUqtZ6SwwvN+Y+boM/YzBgILL@nongnu.org
X-Gm-Message-State: AOJu0Yws1rw7tocHQ6bRRoI3I2SnJXL802ATLDA7KduAJwNeNfpGQwZV
 gnnTnjJC+Y8dQHvCcY/rXEqqtzuWiw8l41lG/UoOahPCM+I886aA7cYQypOYlhqPBqFv5Q93vHQ
 zePY=
X-Gm-Gg: ASbGncuIP5Vbsad/OiyxjtXzRkpxN/4PXPjLy28vfpQrYG5lgGX6/XqmK9LfGtKPDLz
 DOo4d5esokNSuQ/q63T6hB+ck1nP4t9sk912v1z7GE9O1iifXAECBALI+ljSf9qCGDcHdMXilgj
 21Qhnfiba5O0qwso2qHMOjQ2UTbqMO1/XJS/4pbW4uKu54fAIN2Geit+OuWs2NXlJX6GVQw0CYq
 CtVJOjIH3xwA1sRIxkUs3RKu2hijTLVVT8JZeSYHsEgYq3Jjc50vVrTIROtm35jfLoQZIji47o8
 Vv3pHqxNnJ3IK8vuAGlmmTiy
X-Google-Smtp-Source: AGHT+IFvicdhhZ6HbTyV1kH7kGiWX1qpj1WyXxNOCr6xcSIRQBihmJGC0ys3Szn1QIcbOjBlYGYong==
X-Received: by 2002:a17:906:f59a:b0:aa6:9503:aa73 with SMTP id
 a640c23a62f3a-ab2abcb1135mr2535115966b.51.1736873844736; 
 Tue, 14 Jan 2025 08:57:24 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c91362a2sm645196866b.85.2025.01.14.08.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 08:57:24 -0800 (PST)
Message-ID: <316c02ad-cdbe-4920-982c-5e4e0997688b@linaro.org>
Date: Tue, 14 Jan 2025 17:57:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/81] tcg: Constify tcg_op_defs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-25-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Now that we're no longer assigning to TCGOpDef.args_ct,
> we can make the array constant.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h | 2 +-
>   tcg/tcg-common.c  | 2 +-
>   tcg/tcg.c         | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


