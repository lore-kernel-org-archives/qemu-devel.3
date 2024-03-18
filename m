Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23226C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmKb8-0008Ge-1B; Mon, 18 Mar 2024 17:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmKb7-0008GS-7K
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:32:45 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmKb5-00048G-Nd
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:32:44 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e703e0e5deso2013848b3a.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710797562; x=1711402362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f0nZQdFow14fiUro79vWahr0ok3JtIsUql6yL3ZtOm4=;
 b=LhjXGw7FTPRSGsYd3zz9sxAYtoh2p8A679LvSZnXo/Keu6hX9FdqIwUIu/O0n+6ZcB
 b+LdaL+zRn5Sr8LK4z9iNX/oPUXjZSuo/g0yIykADzd+SzqPgovVhV9uQrRk1XsXADnY
 lPdZtf5j0Grs6i6dyF95jTEJsquCfTVd0q/y2ff9c29k3ycv2GoW0K2xXzZe4CsEPY/g
 9b698Is0QBcmdTkI4fQc7+IMY/Ef3mJ6UCId5pWd74bMjJfpOcSI4Zx46U0sa7FKi3/R
 9zbQNTGyRg9eK1BP/Ufbx7BIRzMPGBdik52p/8vKVqK/We87vlhWrKe5YiN2s8uqvZzG
 m+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710797562; x=1711402362;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f0nZQdFow14fiUro79vWahr0ok3JtIsUql6yL3ZtOm4=;
 b=iMia0C/UsN4scj7yWhIRoWs8mlH71qjhboQ61CI6L5Fir+45lGLuX70gXKp/LxwOjf
 9GkpQdMbkfH31AhCZMvQ/0zaYqNL1CaAZDWXJvU91f3ejQanx7bMVVq11/eGmvfuaFQg
 xEn0VJYvz98H2emm7HygWYTndS0cwkvwdgZhUA9jxeMWdinJBkT0cDT0wdFwsxjbaQSl
 H8vOJGdD9un6WboDjYuppqLIhE5bUfOo3Q5+Wny2xHMIPacMlVmsBc5J/Oi9F54iyqeF
 0Wr5Ofzw+7vPqO3V7KJNQWE2eqCZB2GeVCZ84XuwsGUL1IsMvSlsgxz7C/2UKOoWV6j7
 4WLw==
X-Gm-Message-State: AOJu0YxnDa16dINIlHFtOQNiT+FNdxmhKzi8WJe87OrEy8yIZgdn98Mr
 oEumulK7BhlC0flU+kZTClLunMkWv58FUlOfvU17L0/lwmcnpJFJDlKQru1wVOY0Qp33vES1a5R
 q
X-Google-Smtp-Source: AGHT+IGpeCnDC5c3sOZypbjyksppSAenKgKFLl8soNw+x/Jyqsle+ngGtXVL5y6sRf+5kcxmKgxbNA==
X-Received: by 2002:a05:6a21:920f:b0:1a3:4a1d:1092 with SMTP id
 tl15-20020a056a21920f00b001a34a1d1092mr13124782pzb.35.1710797561691; 
 Mon, 18 Mar 2024 14:32:41 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 d14-20020a63d70e000000b005dc36761ad1sm7825068pgg.33.2024.03.18.14.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 14:32:41 -0700 (PDT)
Message-ID: <f134b127-922d-4cf5-8de0-22ef29f2d6cc@linaro.org>
Date: Mon, 18 Mar 2024 11:32:38 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] target/hppa: mask privilege bits in mfia
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240317221431.251515-1-svens@stackframe.org>
 <20240317221431.251515-7-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240317221431.251515-7-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 3/17/24 12:14, Sven Schnelle wrote:
> mfia should return only the iaoq bits without privilege
> bits.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 98a9cb792c8 ("target-hppa: Implement system and memory-management insns")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

