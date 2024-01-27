Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719A5C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTacp-0008G9-6g; Fri, 26 Jan 2024 23:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTacn-0008Fv-Sr
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:49:01 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTacm-0000ft-9w
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:49:01 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-290b37bb7deso1080796a91.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706330938; x=1706935738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fth+xJGip/ygfMkXcfNJczfemnfTrsADz9WST6FT1Os=;
 b=kCPBHtyGJXYQsqoCyRrwXVqdA2qsHWSpDhKfJHEIFtS6+flyM0C9Inu3IB/FkJ4e/T
 hCMqIsCmbhs1oa5ln5Bg5+DvB77XSQRc+/7QSQ9Q4jQKqbBmwwpqr76Bwb4uuVznhbFS
 1spYd2/5al2NAG55a3bhi+9R3XFMXWjILwhh2zJhr1SMqXyE2IDUno4CgMvEFSbAcENE
 e5sOfmV3I6eIGbkrOq2G25wI2svszRE8pZAfzCuXuz78+IIW13hkYx6rqJicjM5HR+mz
 ctBNEsACrI/yoJrm7k8IXYZ24vnzUBUYZ/YhzyHlZTXasy9b/ysN1/R5vHIojD/6dSsz
 qxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706330938; x=1706935738;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fth+xJGip/ygfMkXcfNJczfemnfTrsADz9WST6FT1Os=;
 b=vRNJ70tZgSpD9dm9qwg7ttvK5xoNXHhKeIZW8RJK1DShI5qoZe5txlpBA2zttgabTQ
 IaxDSP6+lBmaecCnBIAzlwfXu7bb0x2SFtf2eHYFF4yHNEMBVrMRN0ygYyFNUsfOHvX+
 O8BfhMq8dybof1Zj4E4YZP+rY5ZBaE6Pe+7omdqx9aDWDOSUU5dLNG2xE12iA4lWyT02
 LltXw1GgLJzDvvFFTrUKFsb0meGZBLnXECvMa6RUC+HJuupizMN0iAV9gVxS2BpNe9oF
 n77jpxV4HoBAXqHfKbNjZgOHJ3KSPNBUhkr2GjtPRMl0VE8MP4pe2x6oliyD6KVonVeD
 rgfw==
X-Gm-Message-State: AOJu0YwAJCs1J2jKrHY+4FOGsgq+6gF/LJ9UHOBhhTN+GhEVa1tKT4Js
 TjM315WwwMYr/SKVHjOWENmfeIYiAE3WHg0jsSVKUQphKStCZvXJpSfwnjrLKduA9y3M3nM3Mz7
 U7XU=
X-Google-Smtp-Source: AGHT+IHlA5Sq2JitCfDRCrheV3QZLEN1wGpLSTKV8eNCbW4j3R3Wp6R/7dkjhWxJEL8HA/f0dWQHag==
X-Received: by 2002:a17:90a:f60b:b0:28d:1e38:88f8 with SMTP id
 bw11-20020a17090af60b00b0028d1e3888f8mr847521pjb.41.1706330938454; 
 Fri, 26 Jan 2024 20:48:58 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170902c1c500b001d7712c6d00sm1683989plc.233.2024.01.26.20.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:48:58 -0800 (PST)
Message-ID: <1446a65b-23d7-4052-b999-16b8be9b4237@linaro.org>
Date: Sat, 27 Jan 2024 14:48:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/23] target/sh4: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-21-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 1/27/24 08:04, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sh4/cpu.c       | 15 +++++----------
>   target/sh4/gdbstub.c   |  6 ++----
>   target/sh4/helper.c    | 11 +++--------
>   target/sh4/translate.c |  3 +--
>   4 files changed, 11 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

