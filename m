Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E695C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 05:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXDVn-0007yw-Vn; Fri, 26 Jul 2024 01:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXDVm-0007yO-Cs
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:29:02 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXDVj-0006Ic-PY
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:29:01 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fd90c2fc68so2501335ad.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 22:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721971737; x=1722576537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j/4LJTiFl0k7aGXpmE0CbIHimPEjdPLt9xGncfvw+ww=;
 b=eSAqBV36GGS8+d00jBjfFu5O8ZvIHjTZt288dgV5zWNMImG8trJZpOd5UsqulJgrBB
 0C4axHoZJXUTwheb6ktTCPu8FPnLSwivTcmFIC8m8DeNQ7JsZuQ4f9iBQ9hbJNPdqEiv
 k9m5oFVSwzvFjt4+B8ueY31gSHapFSsBwWYe1TEFgGCR47QMYUtduWRAvgVAhML+58u8
 Lu2A4rbtPpU8P4m6AxVb/qWwTuA6qJk+EGewKErHt00m/i6biUxU7dZaPPSrix8164KO
 wb4eSCNag0Sc6oVR0lP493FD0K2ysrk3058r988OIKa203Fvvu0IIAg/Ei3uaV4iKzeC
 /3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721971737; x=1722576537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j/4LJTiFl0k7aGXpmE0CbIHimPEjdPLt9xGncfvw+ww=;
 b=Nuxru+xLyZwdawTDb5aFliXuWHzh9/Z91/+7/yPYxV6nOyo2eANySLIIE0eoJqRhjs
 WGghX153z/6LOxfJ9eqOdJOi5+UiFZ93z7SZBhST3o9BliFr4bB+aGGOaeT/oAtSNrmC
 5Y3At7YevEGxa2eL21AvOUjuPZH1gETqKeq0ycLdR3llD4Gp28E/CcRe/kH4UFb64nSa
 Ysz34SpmTRcBXEwa6Y0EwiH0vQBPK042f7dmgUMa1+1JMr2Z58j6OqABmtsHFiX6TjNY
 px57NEsYaQ6Vxzx4QCxti/NAjcnQLN+5zt8z/+9bAuiiEN4q1NscFt7K9UxfjP57FaxO
 wIbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmT2GfjyC9nfGulS0f6DUgnYiChnq891z9Q/7LIU68mT35bYgys/ivMJr6fOXLiI37znGaM7YlohpWqaBOEU65lLdptyU=
X-Gm-Message-State: AOJu0Yx+Sj0c6ryradlzJKBPynyVqr2m+r0Hev7bQakJy28KMjQIzCrH
 LqbSr+XJk1rdg9MjlIj3CFvFf7YHd961QVGWsamqOo7CKW/o5TxV5/RvlrfpLkJ8ueb50IndbfW
 P0O1FUg==
X-Google-Smtp-Source: AGHT+IFqo99i0PC23fwh0k0szNo0zsuL0AVPPybZFCfGuDlA4wjQDOvXpnoGZh+y+xdocs+kdaP+sA==
X-Received: by 2002:a17:903:1cd:b0:1fd:9a23:90cc with SMTP id
 d9443c01a7336-1fed389af71mr65111375ad.26.1721971737450; 
 Thu, 25 Jul 2024 22:28:57 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7f71ffbsm23242155ad.231.2024.07.25.22.28.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 22:28:57 -0700 (PDT)
Message-ID: <ca0090bb-9784-4355-b5a2-0783dd160c3e@linaro.org>
Date: Fri, 26 Jul 2024 15:28:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Let gen-vdso tool to use internal ELF header
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240726043246.10999-1-jim.shu@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240726043246.10999-1-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/26/24 14:32, Jim Shu wrote:
> Let gen-vdso tool to use QEMU's internal ELF header. It could avoid
> compatibility issue of glibc version in the environment. QEMU RISC-V
> zicfiss/lp extension patchset will add "EM_RISCV" symbol to it. This
> symbol is not supported in the legacy glibc.

I see EM_RISCV added added (by myself, amusingly, as part of a bulk merge) in 2016, 
included in glibc 2.24.

 From repology, vs our oldest supported OS,

centos stream 8:   2.28
debian 11:         2.31
fedora 39:         2.37
opensuse leap 15:  2.28
ubuntu 20.04:      2.31

So unless there's some *other* symbol you require, all supported OS will have EM_RISCV.


r~

