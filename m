Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8938C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsmA-0004mA-DV; Thu, 27 Jun 2024 13:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMslw-0004km-Dn
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:19:03 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMslp-0003ex-IO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:18:57 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7066c9741b7so4052722b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508731; x=1720113531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FBBsYpXTSfwyieWuRdBbS4XvPy8ZT0MFCKByPU8fuBY=;
 b=ZtT6+Ktd+wBUIi64RiRgllUEkAWByVtrI1mS59beXWExFh7ieJWczckuEC2Ugxu6bB
 ZAvnOOqHitEzSC5U17/yIZqtuMniIeYjXKgk+nWef69JnFoy6u5a5RV0xzUz/5LOZngF
 gOyJvSnPegx9LAB+v4wsbjMFbHhpZYWj2/4uUqA3ZmqlQfnwnSuX8tnOGGekqtCTpc0S
 ChsltqtYwmqDhGV4wTQxP9Xd1TS5Pukoq4ryLVKRQ3s9vbw0Zm4nHPUz/20mB8Ea8+uy
 MPlTLLtUh9L4XRCZf0d2PWoNmRcFLyWApM2uDwMcdFLnlMABHcGNWgBvNeUm3XCPzcKN
 VtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508731; x=1720113531;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FBBsYpXTSfwyieWuRdBbS4XvPy8ZT0MFCKByPU8fuBY=;
 b=JQP1o0kxjax0yqK97C9baeOF3+dt3UdCn2Tllel445ILMOz7CKeic8kTVx3P5iKRLM
 okrARlAtsRc6rqWJ+H2uGmt1ewlqFAYE/BWwV7dLdGP/fFVBHDuSr4yoVlGOAssBgz75
 s6/YSiXehuv6v1uMlBpgAoN+Sna/TgjI0RRAOWeu3hTcJRi/CiLJjQz5omLyRdEDFxVr
 9AYYAdPnkDKxWpvXbY1nFjFDLnL375UoEpz5AdHIa05g1OSK9UFgcs6NVo5JCFw0F47+
 dpoSbLZxRXUcpoE3EvXEEtUIlv4rhKUxCpCE9cfafAMsnj4OrcIfBdWhmcQbR77BX9XD
 aaXg==
X-Gm-Message-State: AOJu0YwcdkFuThNzpDnAPfsupgZ4U6VngJItNess8c3Xsyy000koX1MA
 dmnNsfHwOPa/mA3E/mmTpj2OlIW28X9NjbXTT2ohDDeJN/yGbSfqRMnUuAQZj+U=
X-Google-Smtp-Source: AGHT+IErTt4foLbEW5FvDVzMeQGPpX5lxWkT02XKQX9H4WHX0bFtw1G6ZLF/2QOZtOHF1LP3Kxe4Jg==
X-Received: by 2002:a05:6a20:4e21:b0:1be:c0c9:5fa7 with SMTP id
 adf61e73a8af0-1bec0c9602dmr4306902637.15.1719508731108; 
 Thu, 27 Jun 2024 10:18:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c8dbacc68esm2026131a91.0.2024.06.27.10.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 10:18:50 -0700 (PDT)
Message-ID: <06940d7c-a5bf-4a15-928b-793c667223e0@linaro.org>
Date: Thu, 27 Jun 2024 10:18:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] util: fix building on OpenBSD/powerpc
To: Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <ZnzM1T6Vo1Q0yAH-@humpty.home.comstyle.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZnzM1T6Vo1Q0yAH-@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 6/26/24 19:22, Brad Smith wrote:
> util: fix building on OpenBSD/powerpc
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
> v2: Keep headers in the same order as they originally were.
> 
>   util/cpuinfo-ppc.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)

Queued, replacing v1.

r~

