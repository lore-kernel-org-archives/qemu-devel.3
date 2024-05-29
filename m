Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C92EC27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCL6M-0000Yi-9G; Wed, 29 May 2024 11:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCL6K-0000SI-FC
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:20:28 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCL6F-0001Sn-Fc
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:20:28 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-681ad26f4a5so1299772a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716996021; x=1717600821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hb+RAronmVWcQOHs+i7Y4Kg1cIIZ8hlMnnhzrGnzp0o=;
 b=HqNjQNV7zd3O8otK/MPCNwQuCh/t1U+qet+UZo55pYILoFrFY/K9n/OnZ/AB5iyCLa
 AkAoFAZjglzdxQzdc8uNdPutu6ucpwEW6Tscpc6CqHUfOf8MEUfMqSk2hgrY9hTfU5br
 ropNh0EiLs7l1vgOCCN6eBk8yWmd85IX5uGYQdDxC+iSBQA/EYpcjUsuT4ur7QIdHtrm
 /vXvhqJsG6uL+syUTlnqhJLy9A+Tt7dbd0OCi/zgnfCFYsMlao8e/lPt8gIlzMUQKKTc
 1+fEL+cfo0P6Hr/YEq9g535EcziThpgdoJj0u5dD8VuA/lz/Oh9CSjlbaPMAWOxv/tqc
 Hmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716996021; x=1717600821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hb+RAronmVWcQOHs+i7Y4Kg1cIIZ8hlMnnhzrGnzp0o=;
 b=X6tA0uUlM7oz1w0Y7PYN9mlpX8wosfBH3KefAc9fEIMJ4BKZEjObyirDsVJ/Xt00nx
 8qfgCOzZVN+1KS4QMKxPRt8uaany/Wl/lRLeo2ENgOJ0kYcHW/K0L0Jzr7pFz1gX31Ir
 7uyptLPhpA2XwgbSgP/FJ0RP2rbUcZ81GqZfbDG8OoRMoF72WkcItQKFe1ziU2o31Pos
 TVQKYeKU2KLqgN4jVXE0xTa2A9TTyvoRH7DoF1EH6Tos7BHBiCRmg1ysrEEF0PIsfK+J
 Oh/JCxj5QVwMADqpuIHsQhsbGnMxs2tSGCwDubbaR0QdMoudWtu2TJo/FzJPo70R8s5L
 /gQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOKPqB9ucnNO6sdL2vF33a3pUcmrhAxQ0p/3k28z3as0MEl/CIPOhFmHYsOqFuTwnTNWSnJGGjw1O4bjRDxNn/gjzhbtk=
X-Gm-Message-State: AOJu0YxXzgr5kFr04M/r0+WLqm/CWtWxXVo66+gi8383DLW7yeqCi2R2
 vTSfz0qd5DrbypZjViognqEpw56f1my38web0JMaxMFelY83R/yLAIb3bTRy92A=
X-Google-Smtp-Source: AGHT+IG+xBlpQQoJVHp7DgsksS2dwHwcRK6COCtBb3E5RC/9kxKryFQa1je6ePcemXxcFgAaVMfpDw==
X-Received: by 2002:a17:90a:ea05:b0:2b6:226a:c910 with SMTP id
 98e67ed59e1d1-2bf5f518656mr14591483a91.36.1716996019045; 
 Wed, 29 May 2024 08:20:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bdd9f4dffcsm11613007a91.38.2024.05.29.08.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 08:20:18 -0700 (PDT)
Message-ID: <0ded3230-3b56-45ed-afe7-a4bd7d99dc76@linaro.org>
Date: Wed, 29 May 2024 08:20:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Add ioctl for BLKBSZSET
To: Michael Vogt <michael.vogt@gmail.com>, qemu-devel@nongnu.org
Cc: Michael Vogt <mvogt@redhat.com>, qemu-trivial@nongnu.org
References: <20240423152438.19841-2-mvogt@redhat.com>
 <CAPOxN2FyxFp+BJzgFa=EkxDkrctBg5TZWWW1x7r0tKONLHJ7Jg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAPOxN2FyxFp+BJzgFa=EkxDkrctBg5TZWWW1x7r0tKONLHJ7Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 5/29/24 00:56, Michael Vogt wrote:
> Friendly ping
> 
> I tested the patch as part of cross architecture build (using qemu-user) with 
> bootc-image-builder in https://github.com/osbuild/bootc-image-builder/pull/342 
> <https://github.com/osbuild/bootc-image-builder/pull/342> (not sure that is relevant, but 
> I wanted to mention that it is working for my test-case).
> 
> On Tue, Apr 23, 2024 at 5:25 PM Michael Vogt <michael.vogt@gmail.com 
> <mailto:michael.vogt@gmail.com>> wrote:
> 
>     Tiny patch to add the ioctl wrapper definition for BLKBSZSET.
> 
>     Signed-off-by: Michael Vogt <mvogt@redhat.com <mailto:mvogt@redhat.com>>
>     ---
>       linux-user/ioctls.h | 1 +
>       1 file changed, 1 insertion(+)
> 
>     diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
>     index d508d0c04a..3b41128fd7 100644
>     --- a/linux-user/ioctls.h
>     +++ b/linux-user/ioctls.h
>     @@ -102,6 +102,7 @@
>            IOCTL(BLKRAGET, IOC_R, MK_PTR(TYPE_LONG))
>            IOCTL(BLKSSZGET, IOC_R, MK_PTR(TYPE_INT))
>            IOCTL(BLKBSZGET, IOC_R, MK_PTR(TYPE_INT))
>     +     IOCTL(BLKBSZSET, IOC_W, MK_PTR(TYPE_INT))
>            IOCTL_SPECIAL(BLKPG, IOC_W, do_ioctl_blkpg,
>                          MK_PTR(MK_STRUCT(STRUCT_blkpg_ioctl_arg)))
> 
>     -- 
>     2.43.0
> 

Queued, thanks.


r~

