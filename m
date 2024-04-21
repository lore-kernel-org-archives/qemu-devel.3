Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04524C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 05:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryPbz-0003Sv-Ph; Sun, 21 Apr 2024 01:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryPbi-0003SB-5B
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 01:19:18 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryPbg-0007a7-KM
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 01:19:17 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-222a9eae9a7so1761164fac.3
 for <qemu-devel@nongnu.org>; Sat, 20 Apr 2024 22:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713676755; x=1714281555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wG1pYCiCmIWRKqu+HwzHU6KcDf/FwZ40m3VSEEfhQCU=;
 b=gC55HTlXos/5iigMVkNOxMat8Ub4/kH/vj13miOVw0UVie64HAbcKPy5XVzwcJ7UAt
 NdAWl2Sl+7Cveo+iYUFNDD95eXmaOOMOUmlBLhIiXxFNzn1GnMgkud8ZwY4UkEtK+IAv
 o++J3jsdbQkSvyK0Pn9SFw1q+BtMoOgSp2oSFxkAKMw5+Xj32/S9fb5+kLymDC0C2yS1
 /vVl09prPpRnomgVEeULgQTSiibXB9tvHd16+9hXAGMyI++oGcrCdKq4VCQ/VMqwllCo
 GUdxsI+hX/pAzvGo8Pe0Zs1qAJ1+cmYtwFdrbaVBcqY8Wi5tfx6pN8IHiCEQ273T/RsF
 bmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713676755; x=1714281555;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wG1pYCiCmIWRKqu+HwzHU6KcDf/FwZ40m3VSEEfhQCU=;
 b=L1Oo+S7ttMbc2otdEgB7ZAkVs3NIxion4AWJ8xAROVQDI7LEVQlS0qk2J6fwhe72vf
 JZH/c/Ea24tEVH+glyoW/0tD+Vos6WIzyZkmFdZDdxfKkG/fnJPBnCW/agTLGuRzrwb6
 9J88d2ZdlWp6FsX+m/ItMpnUyRTd+3Z+ltc3aWABhxsqKz9lQB6T9Q4ivBuEgizFo1Eo
 y8wj9mtCZAPCDx12QTWH7b9U2p3SSSkB+6WVTe99U+WxFJoTH0M61ciLfQAgD5Br8KEZ
 m4rpg4aamOr838ezzbBlqTwA48vr/B0WxtVZ7NM5LWY5JKu8Wikb3pmKoIsFhOaRHuD/
 ebyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnMhE6EhXDzv6STxlYDaFMV1vtSirYKhOUEjD0abnSGnBDuZJt6F8DHk7gbYoAYK4NLJ8QLjBnRv6k3gA9gbC6zUn4RpM=
X-Gm-Message-State: AOJu0YyKZvkxd8092UrodkG9TNqJVVHX3k02tqIdPtbedNrRK4ielvIt
 PtS5DqWfL7EQ07edtFwmck9XLrjti+5GRlSyY9rhjMjrtGQKbqluxNRo88N9lU4=
X-Google-Smtp-Source: AGHT+IF7i6fPS+3VDJqjPbncg9rVPge/phekKYnjVaGULSBZ7Bsx93z51twdgWa1K4OPDuzRSuswcQ==
X-Received: by 2002:a05:6870:80ce:b0:233:b575:4b4a with SMTP id
 r14-20020a05687080ce00b00233b5754b4amr8844145oab.36.1713676755011; 
 Sat, 20 Apr 2024 22:19:15 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 r18-20020aa79892000000b006ed0c9751d0sm5780761pfl.98.2024.04.20.22.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Apr 2024 22:19:14 -0700 (PDT)
Message-ID: <7eaedcbb-32d1-4660-860e-0456fa069db2@linaro.org>
Date: Sat, 20 Apr 2024 22:19:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] exec: Declare CPUBreakpoint/CPUWatchpoint type in
 'breakpoint.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> The CPUBreakpoint and CPUWatchpoint structures are declared
> in "hw/core/cpu.h", which contains declarations related to
> CPUState and CPUClass. Some source files only require the
> BP/WP definitions and don't need to pull in all CPU* API.
> In order to simplify, create a new "exec/breakpoint.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/breakpoint.h | 23 +++++++++++++++++++++++
>   include/hw/core/cpu.h     | 16 +---------------
>   target/arm/internals.h    |  1 +
>   target/ppc/internal.h     |  1 +
>   target/riscv/debug.h      |  2 ++
>   5 files changed, 28 insertions(+), 15 deletions(-)
>   create mode 100644 include/exec/breakpoint.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

