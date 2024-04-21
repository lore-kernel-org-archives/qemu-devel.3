Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE716C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 05:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryPft-0004X4-2U; Sun, 21 Apr 2024 01:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryPce-0003os-Q3
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 01:20:20 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryPcb-0007xG-UC
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 01:20:16 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5e8470c1cb7so2238460a12.2
 for <qemu-devel@nongnu.org>; Sat, 20 Apr 2024 22:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713676812; x=1714281612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lDXAB8ltRRwkbBawSc6C2SFgBQpWEcy0Yr0gdbEefAg=;
 b=UkUqV0LPbqEAn1/4Kve9uA0bMCasiBIgyjBaZqo0kiflLThvtSEWzV9xferP6HvLRp
 6Ks4VL5RtgssOjqriE/aqBHJQVhm4nFiT+7hP83Xx7d9anzBOFRwUNIqtXCJJRy1AGKJ
 /VSymuWccx/+PJYk59PkLOtKi2HJbfA4OaXfiGhPAZLTEAIvl+7y6zs+sMIjIfniaSOX
 Z+IPr260jOy/d70C36FpkPuJ+aZzFidmzNbQOMzbsLH8LSyRMdv9F7EYT1Tz4a878oST
 0R7rT3OeJNxntiGIefAt/h7DuqNRr6hiv7erTPjtrT60bTHIgnhmggRAtYg9imrpGlCm
 24VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713676812; x=1714281612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lDXAB8ltRRwkbBawSc6C2SFgBQpWEcy0Yr0gdbEefAg=;
 b=P2aiJxidJrJr1IL0TQUBaUX6E7InxbWDzsPvQUwfMgxWZVYc9h8I2zmaDlgeBGX4/D
 5t+96fMUb4Z2hXt8oTXKrUw8+DBTk6pfK1WBnA8liau/dFW2CvMvtLSe7wQavzxLnG4+
 SqLwEnxIxO5ULErGgSaoWPnZHkGxmPO6v6his32N5q6F+IU8r34iIjv8YtZFeCQ1yx49
 GR2ZLQmfgXgwWASxPAkg5br4T7JLU14sd7lTZoZc23xDEPs56gXm7hseYn1XNHslcLOl
 o42WheMeJ7+Yth4ut0xzKoSTaA93CUmGgd0ipTu8qVOf7XXRdF8JuRoty6aAcW3G5gj4
 oPEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNExQwXYZAV3Z+/noiId21MIQcmTZoOa9nLcZpzUHGkmIKHYqf0pz+K+DTfLXYI5DYk2He89y2lcNYw3r+oqicft2mcJA=
X-Gm-Message-State: AOJu0YwXSW4E+MXZx9csPfhiyiW8O8AZa4Kj3Rj61MyI6fTBRm5QXorB
 JJMZM57BGZx+xeaPEAoqsOUopzzq1Mjn+x04t2Q1ihkHhgnu7hIDxZBEoVWCSIoyJV7PNml+IgT
 i
X-Google-Smtp-Source: AGHT+IHkMyM5opv2eoOylQZroSnk6GqGYbzNWxMP5sTw32UbvTFvHfQW0vjUnKeBk99bL24mNOUByQ==
X-Received: by 2002:a17:902:daca:b0:1e2:7d3b:353c with SMTP id
 q10-20020a170902daca00b001e27d3b353cmr7571336plx.18.1713676812239; 
 Sat, 20 Apr 2024 22:20:12 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 mi8-20020a170902fcc800b001e294f2f30dsm5792306plb.93.2024.04.20.22.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Apr 2024 22:20:11 -0700 (PDT)
Message-ID: <374ff057-b799-47c0-a033-fc17847e98e9@linaro.org>
Date: Sat, 20 Apr 2024 22:20:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] hw/core: Avoid including the full 'hw/core/cpu.h'
 in 'tcg-cpu-ops.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> Only include what is required, avoiding the full
> CPUState API from the huge "hw/core/cpu.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/core/tcg-cpu-ops.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

