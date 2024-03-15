Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DCDC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 21:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlEsD-0004TD-TV; Fri, 15 Mar 2024 17:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlEsB-0004SQ-TN
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:13:51 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlEs9-00032f-Gz
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:13:50 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e6aaa2f02cso2148277b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710537228; x=1711142028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MzaaEFlwLGwtLCVuKz0C6RDCsHmn4uNPAtl/Q4Bsghc=;
 b=yTZNdFPEp8rIjez4vzbsFIuqI0BzJcxot1dE5LhGV5osqYTme+r6eiMDxa2IoPdwuG
 RT9XPVhddjIuS1ooLW6aBjSc2WB7rsJ7djBGvYBBuZcMYDGTuj1+zytgWR8pf0zbbGdZ
 rQ2uGNNsRMLiyMU09ITv1Y2qV17ER2unO6OGdlskhoZd3Ugx2LvZya1ea9GpHThfjcOO
 fe9tS9TY9FIYiyQ/2cxETWm2oMpOMLyYE4SET1higgTcfUsnXVzdRqaF6yOJIHUzRQeV
 gWPFp9TwUifAqHHpCMveToon0jhARqQmlooigXafHqaAcGjgjemWeIzlU3ZpSThkBvdp
 BoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710537228; x=1711142028;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MzaaEFlwLGwtLCVuKz0C6RDCsHmn4uNPAtl/Q4Bsghc=;
 b=GKhz13BOFq2IeNux7I4OPitADj3GU+erYwVCelUfEzD4KhKS47BKiK+DCgabtjYPSv
 pbWfVBnVnpxxdZWuaxY4ydnz+v/s4zgSHbadLigpW/4V7sEx4Xun36gnny9r636BKMyy
 JyyzQvzVJD1dese0IC+QQh1q1xzrsJdLloGkz4qmPRJ4i3V4UApAS+3QZgj+FERcokb3
 IJp24zL2b0VuxEY36SmvB5CJigcXurUhc1EQr2aCQZvAINpDkiOj7U4y9SpSM8dOHYpa
 3onauq4BFlCgIaguGMeHkZQI2EQgj9Tz7A8MQUxtVxXnWoWv4a2QGRB6f+LM490xOLxb
 vaCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIVZq38I9YKIsJJX3bZorBpaO6G5tY8bif1Stlzj2TJlFvQSaLCmIb37ESWq49en0mhfVaFWEJLaiahOgl1IVrZqoDG5U=
X-Gm-Message-State: AOJu0YwTz8KQ19AT9+annyfE2NCyjctHA6C8ConZuVM+8VllAJerzbzD
 ZnjdToOAbKZfTFvu7ijEFiPme7qcSgFVeUnmB1zTOzxXd5blju2ASd9aVKRf/BI=
X-Google-Smtp-Source: AGHT+IEp3PjWw6NpaBVQwuL0RXg30SAxiMOaslr8PVEso/3LjcH78FOeiuY7U8kFqKTmR0x7/Jfe/g==
X-Received: by 2002:a05:6a20:d38e:b0:1a3:4469:769b with SMTP id
 iq14-20020a056a20d38e00b001a34469769bmr5419675pzb.44.1710537227719; 
 Fri, 15 Mar 2024 14:13:47 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 w13-20020a63490d000000b005dc389409c1sm2900217pga.93.2024.03.15.14.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 14:13:47 -0700 (PDT)
Message-ID: <91ea4fae-a9e2-458b-9111-28b0f4cb4a84@linaro.org>
Date: Fri, 15 Mar 2024 11:13:41 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 03/12] gdbstub: Correct invalid mentions of
 'softmmu' by 'system'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
References: <20240313213339.82071-1-philmd@linaro.org>
 <20240313213339.82071-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313213339.82071-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/13/24 11:33, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   gdbstub/internals.h | 20 ++++++++++----------
>   gdbstub/system.c    |  2 +-
>   2 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

