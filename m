Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C22FF60EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Uyr-0006J0-25; Tue, 31 Mar 2026 05:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7Uyp-0006IR-DY
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:01:47 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7Uyn-0000nJ-TD
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:01:47 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso1471340a91.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774947704; x=1775552504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dl9nKcFYK8oPU2RgRQMSgPVtpl8RimSaYEpjWJuj/as=;
 b=X6gt7tTOO2su9ZwZ+4fhpF/lyiIaLyu94CmwWdToCd4vlbeclkooEOpmBLJBqJdqSy
 R2f27O2E3WQq67x1jnSBhVyxnaqU0ZYiia6XPaiqt51JiHnm3j9lR6/bPr3+mTTZVdqq
 W2N5K75uWBFyKiM3/c3nIwj4jkowKoILFo8ywonUObj+lhVutd/ab+T02LugNEGvXMPk
 zmAUIkEtLZPK7S5V7rgkQsXAtALNgAtv0Mjpk5SxnV2ghj/3LpmPPJFDj/FtDor7ECyN
 CO1lAYrFrFZLkckYvOWMYprkQBoo8VbGd/jHjoqak5QTdGeFzuApD2aIBYesthNxCRc1
 roGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774947704; x=1775552504;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dl9nKcFYK8oPU2RgRQMSgPVtpl8RimSaYEpjWJuj/as=;
 b=a86Bu7tLrLyUyDAzNMzKlrqsX8b2qFpOoa7v5jxoDm0zF4Ec89WzG5LNcpZAry0Blc
 PcoRdDguu+W7xOt74x18Q+k/ddlZq8fHFSzvqujwf9mz4+66S4gQK/KmsCoRAXSZoFbV
 ps0T9H2E8hiXqSKFQ5nnKKMN3f0ICq9JMOyE9xcjvsaOZmxtoge0vwPn5FUS5/jXu49v
 VMQzAG6XVfMa9/TTEzZEVlAmfUV5n4Z2IAUyGWUZyJWuhC3GPTtYE4rIr1cJDsAcVdDD
 t0AjTgF891woxkvozRAdqrEPLuAMAJO9XURyEB5+o5dJDaJhjNPvZH9QFPaSG9vOFFRM
 pqHQ==
X-Gm-Message-State: AOJu0YyxjjIoGeCcF9pm+Q7DODHUbU0EVCHgLRyshFgXGAJJiH167JKN
 5fjXUxf0+RdL5RufWGnazUoqHen4eI+saIsxz+QF8tszHCRVT9MTrXk4csSMCotO8PUQAftJDLR
 bOKF8Ywc=
X-Gm-Gg: ATEYQzw5VnT+O7FDpIzKg5WR7wWi8FEWIMoyRcGoTguOjdsw7Zgg3pSShJxykgK/tH3
 XnKkhPjU7vBV1BVcZzykN4Jn1odumKnJLNxUbyxW1Gm1Glu9K+oDdwReuqEcoxB6K0XiZ+HjRdM
 TVrDVAnOepDk7VXUIPnhw01cGHPFVZbEihgOyzF2jQIeeMFs5CrIVcx9nkTQQFMV8LScjTxO7cs
 hx7rynpcmg9/X7oZfbLXSerc9n/HZLbaBRQLLm0w4DRoPbH0guBWpiV6bahIWNL2JxL7SfXaKZw
 i+zVJuKQnn0/Bby13La7fxCXcGeiW6qq5kN5r/lMqr/tsi0TMqMD7+kYKF3nyBQkHMBcV1QthP+
 3s+D/ubRtNTblSDOB4wZCH3clY5/E8ZGfkuJsSmXFkcvzt/TL3xMHyd2UyAgOW6TAKwjUtELDMU
 1UutX7PuuhE1mDL6BYkGavDbyBvwA+XvLcAtsDEds=
X-Received: by 2002:a17:90b:1dc2:b0:35b:e51a:ec77 with SMTP id
 98e67ed59e1d1-35c3005729amr14495285a91.16.1774947704030; 
 Tue, 31 Mar 2026 02:01:44 -0700 (PDT)
Received: from [192.168.4.112] ([103.73.85.112])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dba33bfb9sm886738a91.0.2026.03.31.02.01.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 02:01:43 -0700 (PDT)
Message-ID: <7380580c-cb21-4944-8d92-2562a541dbd3@linaro.org>
Date: Tue, 31 Mar 2026 19:01:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: fix decoding of MOVBE and CRC32 in
 16-bit mode
To: qemu-devel@nongnu.org
References: <20260331065831.423094-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260331065831.423094-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 3/31/26 16:58, Paolo Bonzini wrote:
> Table A-4 of the SDM shows
> 
>                      F0                     F1
> --------------------------------------------------------
>       NP           MOVBE Gy,My           MOVBE My,Gy
>       66           MOVBE Gw,Mw           MOVBW Mw,Gw
>       F2           CRC32 Gd,Eb           CRC32 Gd,Ey
>    66+F2           CRC32 Gd,Eb           CRC32 Gd,Ew
> 
> However, this is incorrect.  Both MOVBE and (for 0xF1) CRC32
> take Gv, Ev or Mv operands.  In 16-bit mode therefore the
> operand is of 16-bit size without prefix and 32-bit mode
> with 0x66 (the data size override).
> 
> For example, with NASM you get:
> 
>                                   bits 16
>     67 0F 38 F0 02                movbe ax, [edx]
>     66 67 0F 38 F0 02             movbe eax, [edx]
> 
>     67 F2 0F 38 F0 02             crc32 ax, word [edx]
>     66 67 F2 0F 38 F0 02          crc32 eax, dword [edx]
> 
> versus
> 
>                                   bits 32
>     66 0F 38 F0 02                movbe ax, [edx]
>     0F 38 F0 02                   movbe eax, [edx]
> 
>     66 F2 0F 38 F1 02             crc32 eax, word [edx]
>     F2 0F 38 F1 02                crc32 eax, dword [edx]
> 
> The instruction is listed correctly in the APX documentation
> as "SCALABLE" (which means it has v-size operands).
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

