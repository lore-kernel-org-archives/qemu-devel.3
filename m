Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914D910F9968
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYcE-0005Zs-8p; Wed, 08 Apr 2026 15:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAYA6-0000q7-FB
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:02:02 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAOMZ-00010b-RK
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 04:34:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b95e5b3afso3315205f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775637254; x=1776242054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UZhlEHU+bENR8VURxKqyDA9WFdD20Y0dP5ryc9G/KCM=;
 b=aKQBdye9Zx6unLGGxEbiwT1zz2kSoPb6s3CnbMSbQxA9pYq1zIzHaKLoR4RazdWXPC
 nDCYqOvxBP98tU0/oY1O1OGfkKi+9FOI/tbhIqVbMwvD6iaQoXDG9kwPkbXRCt7uUEaZ
 wlLA5ID3/jkeu5iOXaPT3NMXk7Qvut/rfG/ubAcF691foeQB8d0TPU7AM74RVlboVvzK
 2ClxgixdXm2wbpfelSC+0dyuYEUbQFwz11Tvh4y4ToFPZjbGFuXGVwxDcv6RGYq4FPvc
 /gkBG2j6Ux/X5B3z66Zks4uGSkfg7nw7+1K1+HwwHDBcE+tKCcayCJlkg+d5+mIpTA2B
 himw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775637254; x=1776242054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UZhlEHU+bENR8VURxKqyDA9WFdD20Y0dP5ryc9G/KCM=;
 b=ZOfIwaqChWvbqe0ZBu6kaicIU2elVEuO0aKMvRi+m0cJpjKP72x/SuKHzIpA6XzQpO
 FwpL/mcALTXiVe/4dvYLucTloJtdY6VrX8wuwzqycXh3ouIqBqZvgHuHZ/3ENNVrAQzg
 TRO1HYoKSu3r0T/aXTBs/pPv8/I1lk/drcJlc76OoMzjrtTOtJ/4uhEd0edO9K/4E0F7
 q6/VArJRHalBjssPhQqb45VyoJsD2vBeDYOCPRy8b+3MCz9qF2ghmE5OlGL0W+D0YrYI
 WbHCWkiXdGACtkW5IB8PjZZvmUmzaaEPUgEgKwplb4DN0CNCRhOCPIO/NDbLlkZbo6MB
 0yJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFPBd9JZBsUAtF1mMZLMM4jY11tfEAAXjcF/Sfh/XOccOmDqiinIlMM+38XZ6UGjKvlclC7ZpBoKHg@nongnu.org
X-Gm-Message-State: AOJu0YxBRR/eE+IDv8rn5MdSmY3gLA3L7oLka4JIc5Was+Di2hUj9WUS
 GLVSaEx5ym6h3p+Kvc+b4VXg9LgRZjePgj/BaVSKmcRY35A12eSd9TuciI4IMmX4mFISf58xAPZ
 1HfE+AZ4=
X-Gm-Gg: AeBDietE8z1KjKUm1+0RT/ktyJfvlzjB15jN/DSIUk4A7Q4FR//g+Ul6lXpkFcH6pa7
 Z3WjL2FY37ln24PfpFZV0efIct8JdULELgpClrM+88+tnapRI1Oq1p4MYuZhKPGfMyreUSnVRPV
 wxt9VVyHdAH99+QQOhFXlIWWZKOxTJeiYPu5411PTamMDPk/sRVMCF3Mno7U8/a96Osk7axL6B4
 bZrXKvvD89/JsgJN3BlfGIcAx4/RnwFmIG7eqp5FV5BXVwspApnovH10Y2KEO50lcukFK8QdgbE
 /FDep71ReXhqZgy+Cai/zRNliAhpObg2ftPaze4v5lMrx5YK0rWx+Dgi5OO577lYYK7IKC7qvgZ
 QKXF9ayGeK5VTv3G+oJ9diJvfB4r3/BEORFDFwszUtkQ1VMXwKwMSbUSAfYXITNax0pklbZoae1
 ccjsccC5K+ep2zc6xkvSJ+aP5rBm6NK5osdR1+QRCofZtRS1jD+ZAAk7BiOuzlWVPbKw==
X-Received: by 2002:a05:6000:1869:b0:43d:dd:8cad with SMTP id
 ffacd0b85a97d-43d292cbccdmr28207761f8f.32.1775637253997; 
 Wed, 08 Apr 2026 01:34:13 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4d282esm56142130f8f.18.2026.04.08.01.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 01:34:13 -0700 (PDT)
Message-ID: <63521e31-993d-4838-86cf-a8bf7c4b07e4@linaro.org>
Date: Wed, 8 Apr 2026 10:34:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 19/21] target/arm/cpu.c: simplify endianness handling
 in arm_disas_set_info
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
 <20260407222208.271838-20-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407222208.271838-20-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/4/26 00:22, Pierrick Bouvier wrote:
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

As per v10:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


