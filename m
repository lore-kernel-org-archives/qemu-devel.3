Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1381EE7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 22:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW1F6-0006NN-A7; Thu, 09 Jan 2025 17:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1F5-0006NF-5d
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:43:07 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1F3-0006RH-C2
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:43:06 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso1249792f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 14:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736462584; x=1737067384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CJLDbxi4A26vMVNBW5JQ1nKeEewWnnOjA4+678rLQuE=;
 b=QVoO+ZB4oaGkPuVBoloF7SjzCk0Jkvv11h7kuI70k9PbbmBV77bUzeP8ioTfxH0pW2
 QBawdZtfRYCt1yFVZx//KftCUwv4OLMyj1x6DFUQi0uNppD6ns43mbsmiT00CdLtG8qT
 S1NoZY21IjtGt628WL/AkUx/eDOpNIVHp0jN1b15/mHk2ugFv3LO+pfYCtz4qH/YPhjg
 pPcYpF7BQ44nhzg46MCtKsN61fr31/rz56Qw7nIhtm1eTuCIWMDqjuv2UkWNderpt1FK
 llPDV+MyKQJuBqJWfmFEeyxGV/ZuOF6c0S5I5II4qeQwr+vIQc3b5/dGVa6u+N9y2VkY
 /6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736462584; x=1737067384;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CJLDbxi4A26vMVNBW5JQ1nKeEewWnnOjA4+678rLQuE=;
 b=lTCAR5aV2FQWNGCIeTXo1ZLsxAQhl2AcCkdzPjPVHNDjzVrqmsZ4hAW0kN+tCLBkYv
 r2apUfVIwvk9jsMQGiC8RD8OiU1oWh5b/rfK+34xXA6a5+79a3FQWVnO0ZSDJuzj3lyH
 smkS4GjAUzbF0dJI+AktDIGsNCFqDyDS9eyRuvRWFNt9wMPkbmCaix4HFG93UyJtcB8a
 GldlAEIELVLtMJsOwvvFjM8gYgqtqrw8249iyulWat/F9neG6I/GcaQHkSN3+9v4ZJY5
 3+RCH5kBPFusGvQ+HD0Y0ou9ocYDYjl76oIsGtj0Ha24ZfJ8G/9umP7n09C8+lfPpHmF
 hgtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlcV+ei2FVH2GnX6rifThG1+cQJIlZ/13Zu41wikpV9PHUJCnVpmd5BEtwuzUtkKW3YpgH/AATs/gS@nongnu.org
X-Gm-Message-State: AOJu0Yw3+BW5UbOGtvk/A+jlL1mdKnGUhpLBL22Stx2gFforONUVViSE
 8QSEbYlV7jM3KWw7KPSo9sxKeE0vdFrn2cUbd0ozzmWwceYVESJfUn036BVBQhg=
X-Gm-Gg: ASbGncuaNMWo4e+hRHla29w6RrT8G5TQv9rkecXC7vN+V6NemeybOzbalBNzthlz7WL
 XmK7g/luokuJBtPMXA8E6wlLhVtbdIvBfSpp8Xk5++R1Gz+Oi/0BEVHaVZrRLpWqGilCFNClbez
 tSSBqWf2YZAwVOBj/eiT+yMU9mwTP94EemSzxQ4AxNdLm1U6L+FwB89m/z3ZZ8TAd5/h6chl4vu
 Qv6F0zbhnZfzC2L6MzD5ksWj2pVcz9PkjyV/sMtD603GQLOWtWAhFrU+Ymu84I23D8pud0ut/7v
 dDS93cLIrwJx2bfkUNHGpYeqDmo=
X-Google-Smtp-Source: AGHT+IHVHU5kSCpZMR6vCrKbAmrNsa74aFtBJ4TyC6OpBZ1OqmM8hu3uiOIwZYczvgJXwiCDWe+eFQ==
X-Received: by 2002:a5d:598e:0:b0:38a:8b56:f6c with SMTP id
 ffacd0b85a97d-38a8b56119emr4102767f8f.14.1736462583671; 
 Thu, 09 Jan 2025 14:43:03 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9df958dsm33472445e9.17.2025.01.09.14.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 14:43:03 -0800 (PST)
Message-ID: <5f831fb3-9054-417d-a238-ccb697c4e041@linaro.org>
Date: Thu, 9 Jan 2025 23:43:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 39/81] tcg/mips: Fold the ext{8,16,32}[us] cases into
 {s}extract
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-40-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-40-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Accept AND, ext32u, ext32s extensions with the extract opcodes.
> This is preparatory to removing the specialized extracts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/mips/tcg-target-has.h | 26 ++++++++++++++++++++++----
>   tcg/mips/tcg-target.c.inc | 33 ++++++++++++++++++++++++++++++---
>   2 files changed, 52 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


