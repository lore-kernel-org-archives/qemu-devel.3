Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8E6D10BEB
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 04:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4YTm-0004A1-BY; Sat, 26 Oct 2024 00:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YTg-000498-8I
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:32:40 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YTe-0008Pt-FT
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:32:40 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20c714cd9c8so26052915ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 21:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729917156; x=1730521956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2xY5NFCSqNOVgI2joiK27KmS99wVtlCnPM+PxE8Ic9A=;
 b=Ti9pyyKfQ46/KUtNxUBVZSMM4vlUU8vTs2YL8+NG414uMWKHOkhwEl604N1psF2xlf
 ql9zOUfrNT1PMVuJ1v3ZsRjrBPjzlpZNgBGfwRijeu54O8Qt/x/yelWl9/nroYNLl0gB
 ISCQAR1AtzXGxxA46qp4TWaM95zTyubFtENneiqAqyA5m6IQg1YLLIEjuJPWqW7a5+fK
 S9q58BStH0hNkIhh8DLa/5ulhdWjkG8rBzBnBLuREkxL1bq29HDgVspJzIxkNVTe8npy
 aRfKzX+gxu9ypKR3GD46IhmYFmovNOX6arnSfQMGj70djtyek+xLGBIwmtCUxzQdRDVy
 AQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729917156; x=1730521956;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2xY5NFCSqNOVgI2joiK27KmS99wVtlCnPM+PxE8Ic9A=;
 b=s7IQa2KV9WKQ3Klg6XQu3aY7TZprXNuAr1LYsCM+Uq3p/a3QAZDFsxxOwpsZTUR11i
 0163UFkoVMiS7VC5eaZqJjc16pIPXTgsIfqhObCqr0SDa2rfXi/YGcWY/sPnv+fHDsGf
 TFiSPzXXRnWxa2P46zpDW883Bw4XxG1/V8MhdwBu6tgnDsqkLYWqPNuZAYHuGk27JTUQ
 ZX1X3cMdFDuUM6GYmCthhE4qHqikPHKO3LdFAMoTx2HIDyMBl8VU50YKDm2OVhjlEb+K
 3cFy5ZsHyvZ+scZTJ1y0LXMUidsYPjIB2NLxQgpQvUCg8ups4TdRU1v9VFURojips6mT
 FBaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZkPu2rteQ+7QczO8eeR+FqEVYCNVjssIn0Se3qfOlVlRg9NCIEL7/0ORf/k7DXvoHw39AG86nAPL+@nongnu.org
X-Gm-Message-State: AOJu0YxU12VmCXnqajchkqX7AfYrKJU+AWgqvO6UASp5oWdqxvbB6TyU
 r0ZQWyHhNjAsJ9BuEeY/vGABgYW5a7aEE9NaZhaRY2Hkv1giicc58TqTxIPqpRU=
X-Google-Smtp-Source: AGHT+IFJ8TBIq1vw2ZrDWZ66H+dIj/BiCfj7ifKHaOguXKsUTHM2GUCjEft7XwWKwwgXSFj43vaeag==
X-Received: by 2002:a17:902:cccd:b0:20c:9ec9:9a77 with SMTP id
 d9443c01a7336-210c6c3ec85mr19533225ad.37.1729917156310; 
 Fri, 25 Oct 2024 21:32:36 -0700 (PDT)
Received: from [192.168.120.226] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf445d5sm17221225ad.42.2024.10.25.21.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 21:32:35 -0700 (PDT)
Message-ID: <3bc58d20-a874-44e8-9f09-3a0fb54a46cb@linaro.org>
Date: Sat, 26 Oct 2024 01:32:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] target/sparc: Move cpu_put_fsr(env, 0) call to reset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-12-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025141254.2141506-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 25/10/24 11:12, Peter Maydell wrote:
> Currently we call cpu_put_fsr(0) in sparc_cpu_realizefn(), which
> initializes various fields in the CPU struct:
>   * fsr_cexc_ftt
>   * fcc[]
>   * fsr_qne
>   * fsr
> It also sets the rounding mode in env->fp_status.
> 
> This is largely pointless, because when we later reset the CPU
> this will zero out all the fields up until the "end_reset_fields"
> label, which includes all of these (but not fp_status!)
> 
> Move the cpu_put_fsr(env, 0) call to reset, because that expresses
> the logical requirement: we want to reset FSR to 0 on every reset.
> This isn't a behaviour change because the fields are all zero anyway.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/sparc/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


