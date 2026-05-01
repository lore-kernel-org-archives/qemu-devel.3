Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4252CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 09:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkLE-0001Ia-2K; Fri, 01 May 2026 05:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkL8-0001I7-GA
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:39:18 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkL6-0003ch-Tp
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:39:18 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c795f096fa5so666836a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777628355; x=1778233155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NXzH+0bThSq+hixyp2oDpGP66Fd+UhVi1kTNl9/exDI=;
 b=eO6PpwUqGOOVhf+Oogw55PWPCmyOzpHs/9HPNE/5nuxfwL8Q3i3k7cuVX6tTOOQg1s
 z1h8Di1AjWoy9LEFIuaTCq4NSdDMJKmu8+i87ig/N+0ySMaUGvaDysjeGosnSruHBQ15
 49RRu8YbieMryELSYsQAE3MFgrz7PoQ74/ztb6Ua/irjZRE6FbG2+I6dbg+Lq4SJAZv7
 FC7/JRMI1SzKluVlM2U0snbvXKJVmUWZ/RVjOiU2Js+TWDxKlEKgqG19h0l9d67Kos5Y
 6GG09o5Nju3N7D7VOg6jY1ctjy3LVwn2ZsxJ96NLYeb6aoV9yW33lVbFdX0c3KWZgv3X
 9jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777628355; x=1778233155;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NXzH+0bThSq+hixyp2oDpGP66Fd+UhVi1kTNl9/exDI=;
 b=fF3i7Q7WZVxtpK9KHW6FjH1ZKen4h9YvaiNbFUv4tGFeDx9pYgqvuWHFU7EPy8I7DP
 sv8T092HHNCIeOB/YcYiRZuYwjHAO9p4YxtU1RrQQUSynpQWPvWmomTioOIkEHz1imSW
 Gw8od2zOz/JafOP2Zln6kuI7va6hT5duVnCQvQoQoqDM83d4TYr7PW5WSSbfIq4Wx9Lp
 r3H+vAyUYwYlkONIktzbJrqQKyg/4h2gw/IBPh2/2jETDL0XOZi1gznZ6oJvi7f949Mn
 rrNqDGE04dcqwoyb45L0IIa1wFZTHBWB8cVfySsd7Km7xVodbwbFhEo7te+GLCQDn7Pd
 3J6A==
X-Gm-Message-State: AOJu0YybEipfPtFeziKDL8N6jJgwpzBXK0NXZ3CKXtA5wv00SoJ7RRlR
 K3Iy6Ztbz2XeZ8zo+cXiFQ3w6TJdV2xzkuotIViJktaH3fmzsBIkObr1nEDpzAhXUmiTUaF13Ct
 Khj/XxXI=
X-Gm-Gg: AeBDieu5VZwkZnCEdxVV5aG8Vup+h2Vx7szWNLG2L5CnK6uwLKa9idrY6UgONuBdr2K
 vHio2E1TyMv8lryMcLtfU+1ZcUfk4J7JY7v24fUHhOc/lcLUn8ulsVYYbhRUFBiXTBaGyesXdwL
 YecLO7werQ5P573wrhINQX5ZtxyaK3XUPCk3/iAFBSEi7zXT22xaU6tQXaLT+5C06YZKdtGYpFN
 pfzjnldkztfNf+V28fOPk0qsiOojub3eCSxCyOj0sI6Icw12gw9aFV7CSlRCXcPxq4V82hIXcTn
 uoO+JIYJxTgpjoOCrIre+WmcEZYxDIhJMyDDocLGYpDb4F8OT9RN7K9YXli0axUY0+pg7n4rmkK
 uLD7VNoZqP3Vq98+MlMmFuDuuqj6cLDkoki+5OjiGwJ1RxMEP9valIh8qboVYLgFqEz23p/Tkpw
 pUQuUmrMjyT1COz/r7Qifod/pduwjdmGW6fXHKgtEskt0HCBTIWrHE
X-Received: by 2002:a05:6a20:258e:b0:3a1:5cce:ca8d with SMTP id
 adf61e73a8af0-3a3cf7a8c0bmr7433843637.51.1777628354473; 
 Fri, 01 May 2026 02:39:14 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7ffbc85c61sm1785445a12.22.2026.05.01.02.39.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 02:39:14 -0700 (PDT)
Message-ID: <59cbfe6b-656a-4b8f-a683-e9e79ddbd4de@linaro.org>
Date: Fri, 1 May 2026 19:39:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] target/arm: implement WFET
To: qemu-devel@nongnu.org
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
 <20260430104434.1482407-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430104434.1482407-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 4/30/26 20:44, Alex Bennée wrote:
> Now we have the event stream and SEV/SEVL implemented we can finally
> enable WFET for Aarch64.
> 
> To avoid issues with QEMU's incomplete ldst exclusive handling causing
> potential deadlocks in common WFE enabled locking patterns we take
> advantage of the architectures flexibility and treat being in the
> exclusive region as a reason to exit.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    - fix exception syndrome by using enum value
>    - use env->halt_reason
> v3
>    - fix check_wfx_trap(s/false/true/) as it is a WFE
> v4
>    - defer expensive calculations until needed
>    - treat cs->exclusive_addr as a IMPDEF WFE exit
>    - update commit message
> ---
>   target/arm/tcg/helper-defs.h   |  1 +
>   target/arm/tcg/op_helper.c     | 95 ++++++++++++++++++++++++++++++++++
>   target/arm/tcg/translate-a64.c | 15 +++---
>   3 files changed, 104 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

