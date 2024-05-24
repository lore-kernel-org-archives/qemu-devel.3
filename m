Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFD0C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 15:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAWbh-0000QJ-TE; Fri, 24 May 2024 11:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAWbg-0000Ps-Vr
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:13:21 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAWbf-0003ci-1F
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:13:20 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f6a045d476so3244021b3a.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 08:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716563597; x=1717168397; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z11zDzMLrrmIUEFa4NhJxnIN2OaZzxYHtp/pRwwXCw0=;
 b=gvIFdzkPf2xCmmpSJWePk01xTQENLF9V9gD8oNQiE8W5xDwQpArswqJz0Iw4Wi+KJg
 fW0T+xJpoOBQCVUIbOcgp0UHw5nfRfdBWuUnnYEvKCjWSR3keJR6sj+jYFts66jpSQHg
 +I2Ox3ALRVPs3XXsbCuvcWO96HBr7TK7JT7eR08vHGLcvhY/BP5bGxOffpo5YyNo7VsT
 rtQlyoK61ez+ca3qmynb2DKXSQWhHB4uKrhrCG4B+GnI53e0Eapt36wwrMu0D5pOetz9
 P/8k0c/rO+Wgo+OpiP2tOzfP5NloIXN0aUp49jXuYbMkIy8+mVoaq88r5erKO1+TZxgU
 x9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716563597; x=1717168397;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z11zDzMLrrmIUEFa4NhJxnIN2OaZzxYHtp/pRwwXCw0=;
 b=Lq7hDfLRlrV51KTTrYVIGduqu8xgeaxcBAppn8vRr7+nvAH+F85Mx80QAym/cwDNq5
 bZ7uKM1DXV7HC8nvIRVgoVof/FRVo4bCGg9HM6L4UDsQAjJ4GC/Uq27s3uyURl4Qm9XG
 I1qPxNA1ly1uAlbyBq1ESjMm4uEguDjcgmv0ThG6ryYzilqJJalfYoAFzC1L4ZAMCoA/
 SS2QoeqEWul4TPKyqODV3FZu1M3wsx6dUU3lAHls8THozBEUFL/WxqMrLNKJDQhez/W5
 roh9mV59c7SP82MyezKsjzR1KgqiyRVLEse54Zx/D9hFTiIvexRJJX+mAdi8Wu7tzvEI
 zQuw==
X-Gm-Message-State: AOJu0YxD7uR+pBnVd1d1GXumkQa4yvUuqLMdSkf55XPZcdCRkeHJ2poI
 yIDJF86nvYS85ClXCfyVWkClbSCxel1cdTPrKQ5OyBl2HpMpUX/JHbcCXXMjdKtj0tgj/VhTxxt
 R
X-Google-Smtp-Source: AGHT+IGIHtkVpXum8tdXqpOWIH9YmKKxFyiS0jSrImjHIC7ZIuCdnsfCpjJLbDi7EcgL8EWxW3Sgvw==
X-Received: by 2002:a05:6a00:3286:b0:6f4:74b5:f536 with SMTP id
 d2e1a72fcca58-6f8f44da2a9mr2578193b3a.34.1716563597174; 
 Fri, 24 May 2024 08:13:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcbeaa98sm1217996b3a.128.2024.05.24.08.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 08:13:16 -0700 (PDT)
Message-ID: <1ccb076b-156a-426f-ba4d-567a31798c19@linaro.org>
Date: Fri, 24 May 2024 08:13:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] target/i386: document and group DISAS_* constants
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-4-pbonzini@redhat.com>
 <a11a973a-bd0f-4f46-ae39-4dc1d7a65615@linaro.org>
 <CABgObfbXNZKwxxeCC+6OUt2fie92TGUzhcRAxGsO3QxaLM-1bg@mail.gmail.com>
 <CABgObfb04iUXNK+0OQMQUFkj58m5cALuuxe+kGfTaCZqxN3C5g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfb04iUXNK+0OQMQUFkj58m5cALuuxe+kGfTaCZqxN3C5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/24/24 08:04, Paolo Bonzini wrote:
> ... and nope, it's the other way round - DISAS_NORETURN is a bug
> waiting to happen for x86 translation because it doesn't process any
> of HF_INHIBIT_IRQ_MASK, HF_RF_MASK or HF_TF_MASK.

Do you need to suppress use_goto_tb in these cases?


r~

