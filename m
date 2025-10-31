Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED067CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwPK-0007Fc-U4; Fri, 31 Oct 2025 17:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwPH-0007F3-Vh
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:11:36 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwPA-00014v-78
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:11:34 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-429b7ba208eso1563339f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761945081; x=1762549881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NOV12DNH/0tQRi8ffrmTQEuwi6cNRI+zSSaxHN0ksz4=;
 b=GEnQNCrWp5MMH8zkRgYPX4ZPSD+SdOnMJfYxf5q3YUujuyuaYxJCDFs3W4emQZMJg6
 6NSKwFlhaProwV8zTS9Dg8zxj+voFnVj9qzpQlPqHQ06BC+/J/NC6qmdtqSKOQlVTe/C
 vAKwCQbGTcVKdqjZshvQHozPID1ZrqnuWxFrmYliNU7YFbSBkLAYpo6GZ4+hhNrxRrJa
 ISY7DBuEgnGWKO7bRkWzcg69NUsYG11VcceQPB71E4NOh8rQ6WeMtKabfkbWEkSEzVGH
 J6pI63jrMsiUxOTl/fGN/4mNmXEam/noHHhO/M+2spxvuTY3dlSHReiFKJla+6DlOqAt
 0ydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945081; x=1762549881;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NOV12DNH/0tQRi8ffrmTQEuwi6cNRI+zSSaxHN0ksz4=;
 b=RabShTXcqY2NoTUcjlb2IUJir4r9HbDcedRXSeVsO6aHbSCSwEiXWKZDZ4cLo9xm0z
 CeBp5genDcR37QhqlPNoveS53w+937qXglRrgi4GyKRSoO4AQuE6RX/OWwdCSaR1y1wv
 WxDaCHij9MtB0IjrNkjVL2V3of1anloaeFRF3rYtvXaNlbmslF20wGYlKQA9q4MPAN9C
 ZOSjKBtbXR4LWQLRKG41GM4uXKlohpZhfLdKZtIIznZKBzj7R8yH2PTSo1VtgHInCYFp
 kBX7iHqqMc4Ys73l7r9Ju5/9ofjK9SxBRq+ySAResS28YxhJQFW/b0k/zaXZa8auXnSc
 HuOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgzAEeLpJP7a7KdjIeTmgoTAGizVZkE/m1NN4Fc9GG29kPcvkljEUZMCQFo9Z0G/JOMt9cQInjaY1R@nongnu.org
X-Gm-Message-State: AOJu0YztXhVuVmJ2C31o1EieJJSWrfnVLTOt7e3n9awSm7HLrsZA0obE
 o3fhEhbL0acpgqvqlLZtxHMJeOouwpwJR32ALIv0TAN6oT2q4Pb2FgrOSzy48eWmbX2ZLSFhvbQ
 BFhaDa2cFQw==
X-Gm-Gg: ASbGnctkObwh//C0anwOQfYyv65XAjbPkAIfScfrQ2gUljvTHJdeFSdw8PuBM17hT+Q
 9+hZ/GPxdEeHZV8LFxLe9MY5yFtDtq2Ev30ZItF9znAdwi9mU+FitgavDFGFVbe5k5NPWTDyWKk
 zGQLoDocusiy+sqNRbz0o6CUnFHYi75mxbyNir98HJY/8eggCxGZLOaA7kUWKQPa4+UevtZZkOH
 SZjezI0VT5Hln0pCDZz7pI7YNWu0pCU4Y1sktY91XLuLwk34V7sZjapbd/IOaRwX8kPAg4CBID5
 XcRZR289soCz9zLLb6xx942j8evyG/c5k7hYmqouFV4sWGGhwbgL5mFwBKadathMcQWu5YeeBth
 bX6EgLX4n1Kho5Q1HJUPCjlQHyHLPnHLAV+iQiHuKdtkV23667iS5aDTVaCuHCygBoEf1+TFSP/
 cuOnJdXt0/LPDujL7H7vIoPc72qpU7WtM4wtMr48m/e/nQ9QL0RWjxqeicSBSl1mEe0g==
X-Google-Smtp-Source: AGHT+IF76WvlmKPKiRf/q30hFR+RCziQAN9v08UAi3OTwXjO7p/n5yQHWRZ4QcKo1hM7O+zINlC4SA==
X-Received: by 2002:a5d:5888:0:b0:3e9:3b91:e846 with SMTP id
 ffacd0b85a97d-429bd676a88mr4633668f8f.10.1761945081238; 
 Fri, 31 Oct 2025 14:11:21 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c1406a45sm5279532f8f.47.2025.10.31.14.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 14:11:20 -0700 (PDT)
Message-ID: <d07453e5-8e66-4658-8b82-84109abb88f3@linaro.org>
Date: Fri, 31 Oct 2025 22:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] timers: properly prefix init_clocks()
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20251030173302.1379174-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251030173302.1379174-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 30/10/25 18:33, Alex Bennée wrote:
> Otherwise we run the risk of name clashing, for example with
> stm32l4x5_usart-test.c should we shuffle the includes.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/qemu/timer.h              | 5 +++--
>   tests/unit/test-aio-multithread.c | 2 +-
>   util/main-loop.c                  | 2 +-
>   util/qemu-timer.c                 | 2 +-
>   4 files changed, 6 insertions(+), 5 deletions(-)

Queued, thanks.

