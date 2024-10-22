Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217A2D17157
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34D3-0001oJ-GP; Mon, 21 Oct 2024 22:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t34Cy-0001nZ-SI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:01:18 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t34Cv-00008U-S4
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:01:15 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71ec1216156so1642527b3a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 19:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729562471; x=1730167271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXFxZOmNTnMLHg3QBpReYIyRa5+eTrF7A5TV7ct0nNQ=;
 b=B3GphmFdkLREMp3FNcSjXk3SW4Ek3pNp1DnKIjspHOObmFcEtIfsPQcrIRCeIL67yO
 D8cqJ0uqP004qXMo1Yy0vo3BjVXLA8/QiwErKfPU06NNRJTd1WgaLq3FWQV/nqXDQyQx
 rA8/zJWNpSCAbR6rrsHrPsNdaK2LhyKOT6Lh6GBopftHaUDF7Ec5v/QYZyhxZD8GiHIh
 HQdJkh2bejjyi22LFyvcisVTCTTZeu0WLWHb8xoJG4k3uR+yez/xW8KTSvTiPB0tDfIq
 gBmmys1jNoelwpjsvZ1B8NaKvobsyJjoTXGHJI9Suc1u9sewfmmDjHCh5qsoYkw7PuL7
 YIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729562471; x=1730167271;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gXFxZOmNTnMLHg3QBpReYIyRa5+eTrF7A5TV7ct0nNQ=;
 b=HmilqQQYU2nJpO8qrCrWEWnVasz1ESaG7hn1eGz2hTIIVh9lZ9UOW1SPP99fDveSQx
 +tsRw24mjmJPupMZrxbVtK2iPt1aMg72UbaxSU1ySOdCZtPbp7e50SDav6JC0m6QXONq
 UqNec3+v4joukeBiFDVQQZ4s9cQb4Ailfk1w8LBCsmDLvL0t9QotRkWVfmlF3/BTKXm5
 cxOudiyIwgoIeiYyMieGX/WjEdxBnrmQO8ZjNNbsVTIXLOwob2Y48LDHXvffi0XvfqeD
 2fHGXWfCaQ4MafVn5lFdU0PltjaminHjR9jebNl/zZF3TEBq/4q0rXOxacbFwm5vma6a
 PYrA==
X-Gm-Message-State: AOJu0YydeDz7GmYYweHlqpgQ+hvzG/L656ww2lOP5Fhe2/IB24EL/ZZ1
 iFzym4C9KcbYPSvNwFlxW+gt8IU2DBkv7EGkUZ1Gm00mFXJiMNxqY6QzfZrh7QtUEn9wf4SGsuD
 Y
X-Google-Smtp-Source: AGHT+IEf/pF1XM8FNF00VbmM2sM6vNX+C2/J+uhzKdDk/u7Mmo9LeWb36qgXW4Honxy/BGWEIaPSHw==
X-Received: by 2002:a05:6a00:3c8d:b0:71d:ea77:e954 with SMTP id
 d2e1a72fcca58-71ea3212009mr18771470b3a.14.1729562471413; 
 Mon, 21 Oct 2024 19:01:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeaafbd13sm3846301a12.9.2024.10.21.19.01.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 19:01:11 -0700 (PDT)
Message-ID: <7009187f-4b90-4fae-93db-90f2fb557234@linaro.org>
Date: Mon, 21 Oct 2024 19:01:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] target/i386: Use probe_access_full_mmu in
 ptw_translate
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20241013184733.1423747-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20241013184733.1423747-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 10/13/24 11:47, Richard Henderson wrote:
> Changes for v2:
>    - Improve probe_access_full{,_mmu} documentation
>    - Remove ra parameter from ptw_translate
> 
> 
> r~
> 
> 
> Richard Henderson (3):
>    include/exec: Improve probe_access_full{,_mmu} documentation
>    target/i386: Use probe_access_full_mmu in ptw_translate
>    target/i386: Remove ra parameter from ptw_translate
> 
>   include/exec/exec-all.h              | 29 ++++++++++++++--------------
>   target/i386/tcg/sysemu/excp_helper.c | 28 +++++++++++++--------------
>   2 files changed, 27 insertions(+), 30 deletions(-)

Queued.


r~

