Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D5ACD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 17:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruF5t-00053p-EF; Tue, 09 Apr 2024 13:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruF5r-00051x-Lm
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 13:17:12 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruF5p-0005sZ-MM
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 13:17:11 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a4702457ccbso760293666b.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712683028; x=1713287828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=asXtyIfaSO//gCjw6FPT6742wQh3+qmSi9zD3kPJMUw=;
 b=S1XwAHUBoBpqIPDm/KxVZ3ibF0CIFtqx7PEpqFNB6y9ObiTS4YvPoxfButkWPd3b1O
 RRAmlAHLoGGki6Ju/7RzkyqVqdJndadR+1rMQHmuo4VzxfTx3AbJfaJUGUfF17istZ5x
 qz7P0jdjR3siFEdJCwmVzpBCXIoQFDP6isBHeEvNwjfp5wp86mz0/HEGc5cDUGeanARQ
 HXlfzU/PZa+pBGBFz7MLVSpweOxD/JnWLbqcOstdk3Z0HQhfTfR3ZPU8I93Du0iIVok/
 /GT6adMR/iIsI31k2QDao6F+PjhDOz2T8GDNwNZCoBNTQDlu8UMl7zTqT1R5WaZ4dqVj
 cidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712683028; x=1713287828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=asXtyIfaSO//gCjw6FPT6742wQh3+qmSi9zD3kPJMUw=;
 b=Xq542UIiW5sPI0JetyT0GVibxA/rm8ZgH7jetNlxcUOA1EZSOYLK1UJs9NVUHYaJKx
 vTEPoDpF5J7V1A+s7mDLUMzUhImgQ8lazhqec8bHGNVaZHKkc6oQehGmdR2v/rnY/OOM
 0JSvAQhFcwbBx2zX14xMS1H0upudjwKkRejwJbO5X1lvNrqbMB7bs/38Acf3apT7Q7D4
 /RUHzxv9pUAGdzFlAqfZ3U4sMR3TO16b6NklvN77b7XpoXUuqCh8IXJ+2OqYFCnkYb8e
 w115g9tFB+4Sv6R1bzlyA/DQv62cV9eFoY4GfnQxQOR2doltN67OY+EmXVzzhhU8SRla
 jWvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaL8qKGybhSaYeFSSwnMudSMtDvsPJCpdh3dL9K8uudn+otD4pUDMLBwhG8J6Pk6gztdpj5XQinwi390GBC2nOW45+ImY=
X-Gm-Message-State: AOJu0YwVlJ1NcUI2LfqzMLMWCEwjtu/P0dfKMIMc1zl2SzyAVq/XOZZR
 UekHW0UjNmoTjUTfRCN8OfSXMRCGWWcj89wYlmiT1eoPbtAf5JM/Dy/0neqz+V0=
X-Google-Smtp-Source: AGHT+IG/YGXsZ331+Se93got7Y2HhCf3KG6C42sDx1gc/68ppvdh3B9i5D+OtuymUdSAD81ymfPGPg==
X-Received: by 2002:a17:906:6a10:b0:a4e:3715:7f4a with SMTP id
 qw16-20020a1709066a1000b00a4e37157f4amr61535ejc.71.1712683027910; 
 Tue, 09 Apr 2024 10:17:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 ho40-20020a1709070ea800b00a4e8acaccb1sm5848605ejc.132.2024.04.09.10.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 10:17:07 -0700 (PDT)
Message-ID: <4be08729-e077-4217-a8b1-930b33f120c7@linaro.org>
Date: Tue, 9 Apr 2024 19:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 18/19] target/i386: split legacy decoder into a
 separate function
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-19-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240409164323.776660-19-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 9/4/24 18:43, Paolo Bonzini wrote:
> Split the bits that have some duplication with disas_insn_new, from
> those that should be the main topic of the conversion.  This is the
> first step towards removing duplicate decoding of prefixes between
> disas_insn and disas_insn_new.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 58 +++++++++++++++++++++++--------------
>   1 file changed, 37 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


