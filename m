Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF03C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 18:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tubbd-0005SA-VI; Tue, 18 Mar 2025 14:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tubba-0005RF-OX
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:23:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tubbZ-0003iu-1G
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:23:58 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39130ee05b0so5860988f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742322235; x=1742927035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ca5OzeAfDza/pVt7y4FEpceZizjqIEYxRi/Rj6lwIAY=;
 b=bxMDnaqwF/c2KRK3dIvEEgUnL0plevmT8FGy+UJrZ8Qi+Z3PbWZs77AzkbFvYuV2mW
 +LU6fTfQId0bhK5Razkz5Sqed3SsGQn+mR7LzRtJIodceJJxv2pilzucePmA5X+CQtHp
 sLET8SJzgoudO0FfVsH+cGO20N3onvX5OVhQ42LfP+VFYQxZlmnR46gxvz7B5wnW54rt
 xEivo6JkHaN585Um3p+cLzxllj88zJcdk194/chyXcog62xfq62xd169kFtX9IdceQlQ
 9MQgy1iNPRbvGscXuVTJV4Kl6Fw/i+vmXTqCY32Qvf1paJp2yia4SGDu3+0lKK1DfoDk
 NKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742322235; x=1742927035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ca5OzeAfDza/pVt7y4FEpceZizjqIEYxRi/Rj6lwIAY=;
 b=k7oUMTYzX94Q8iS5ua6CyqRsP99R9GwxpNRsdmA7nYQAiMycMzosDigjLwgo+Wn7xS
 McxToyTxX3/luNiq3/YqeYbbOetkjH9Q3V+W9PbNGlKrxajjBO23vuJFJ/Y3AcnzNELV
 Yr0rKc76ta+igvs+Se4jcpKr9VbOdZwtSeQ0VO1+IfoO9ZG8547llv/2Y+n31+7SpmNB
 vnKV1llYJb5KUxDn9CT0NcW9ZQ6ccElEOklpHezNzwmkWEfKAHJccN1YHOgrM3AiMT6t
 4dkJYq9eAeBc95vkkKi7/R/+V6RjqpBCmxfKvXXZar050ZJuvxXiaUoS2b4wVUauBrqz
 nqOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDlEI1q97skfaNuKCRK51iGtL7c55npyIHpz0Sydwaqtt1iviQ/4uCGbhtB20V3ukqE5NzyR+M0eze@nongnu.org
X-Gm-Message-State: AOJu0YwNLIVR3Uq/nQ2GIMtn6fccL3FivZt6IvaGscSJnyKyIkdA0qsb
 6wjmTD2fnpTwp3qLOj/5oH1XjcutKM8vZBe1ugfgsE5aVvTVaKwKmal60VtRk4g=
X-Gm-Gg: ASbGnct8KBP6b9LUeRh6quqBdimZxYbEawzRXsPEuEXdWgfVOga04gKUl8dru2p8tXH
 r4qHBWRsGi3tvWAuaCbi76t/+OLsP6mjqmLkeTaNNTXZbJIVPieuVSbioMYn1+cXkEzgTviy/Ah
 Pry0Tb1ytPp7eIHy1pJ1PWjwiqYecBS97V0GGiHVoG1QTzWJTPfgEkfU1fSCxZWtoymiEw1lN2b
 f6eulgpEGtN479rz7vRMLgjDb7oGkE+QRqiL+iUq8G6RJv6UxceO08PqyRugDyzLUNeqiTRwB/K
 qXmgbrEDPjSViYsDErvw0FU5t0hfW0t54TLmhftYQfuepOiM259KK9V9Tc4rg8kuvx3oWfcyUPE
 NxGs1k9jGAfAm
X-Google-Smtp-Source: AGHT+IEdXpK8gAleIvewBZeHXTpPGztWIm7oIKvHqVj71MvXnIXWeAxuEbU13dfKLcWcyaIDZPyfew==
X-Received: by 2002:a05:6000:1885:b0:390:f0ff:2c11 with SMTP id
 ffacd0b85a97d-3971d234488mr21408671f8f.2.1742322235142; 
 Tue, 18 Mar 2025 11:23:55 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6e87sm19430848f8f.32.2025.03.18.11.23.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 11:23:54 -0700 (PDT)
Message-ID: <b8cab5d8-c024-4cb4-a240-9a9f3ce3588d@linaro.org>
Date: Tue, 18 Mar 2025 19:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system/arm: Use "functional tests" instead of
 "integration tests"
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: qemu-arm@nongnu.org
References: <20250318061420.20378-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318061420.20378-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 18/3/25 07:14, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We don't use the term "integration tests" for these kind of tests
> anymore, it's "functional tests" nowadays.
> 
> Suggested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/system/arm/bananapi_m2u.rst | 6 +++---
>   docs/system/arm/orangepi.rst     | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


