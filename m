Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5982CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waFpi-0004Q2-KA; Thu, 18 Jun 2026 12:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waFpY-0004Pl-W3
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:43:05 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waFpW-0001kF-RL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:43:03 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c40397e3caso12893425ad.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781800981; x=1782405781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Evttaykp8IEtAIkqe2evqHouVtD9wlUOgcS4qCIllvc=;
 b=FiFvoF0WNu/X6Wglvv0PjU5JDqPkMGtDQudCxue01ya+pwHTQCDijK6SdzI4Y4b5pA
 nUZi37ipZQ25pzI3e4+mfAmwEUUZv3ZfmQeN8gWkHsDJF0rT2q5qSPEc+yiO7I1lXOx5
 q25WYMTVVzWc0gvLF3NELKE0DqZKuPrYhjjqHcng+gJ7oub1M03S+Iu/klJxHrLXEHD9
 dI2uSFWtFeIplefQ95RqcI/LueAGYzSRHP3g87cJEnWsHVhNVcON/NQCnrvpJQdnymaa
 5T5g9xkuDwsz/3dEbLqR2ebvcDALyKbNbWI6kyn+NTrJt0cS2Lr2fa9AnrsN58/VKppV
 cl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781800981; x=1782405781;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Evttaykp8IEtAIkqe2evqHouVtD9wlUOgcS4qCIllvc=;
 b=hsxyvuh2+V9SKqDDzOeGRYtQEMYu7BCGpudDa2owjOb/rR9jiL7me1o/R4GGhqKVgf
 lubCLUpecXZVHAjUrg3Xkc11LHHpIAnRB1BRFPjCXvUj9l+AxAxJAt5TpCVS6XfVbM+j
 ZJwY6PagRPwWTkKgWePyYTgP8olG5MauPyITcqp5O/YzZKH5dWdA1nuag6KOqJXW93Yz
 Uu46GDm+5UowSk9V7jKx4+LgjQmUovDclQHu+x/bBD8LvnKFmJNFGUC44d2wmOhULzrR
 yjSWCRv4HYKcKm2j7VQ1xirfgAGhtoGvBUBb+7MYLBjo1iJqQ6goRKHtgMPew8Fk6y9R
 8L6Q==
X-Gm-Message-State: AOJu0YwXQKMEluFP1n062ZCKUOmlfy6HBnzq9+e1C+ukq6PzglG3Id95
 zF6cLIfa7dQnkBViH5tsYuVyONIGKivtZRJnPv0BBSWVAovGgUybe8GkP/iDJMo6ur+bltDDI2/
 M7s5+
X-Gm-Gg: AfdE7cnExiloAvqKbJY7C99f+bhotYIKLBN/4mTEDdDGfD4iJKwhEKHnYWW00ttCXnd
 9rxX0LFCJZcicJy73I8y6DLnH76ZwoV0qDL4NminqSHQpLwp10LPrrnUIR8UGWPl88Gh9uAn4jj
 Z3unU20vy/d9aLSbzQ0EY2otDKcehbgMSp3NdniLjeZFSZnuPCXNmO9aWDilKPaXx89IQGg5H4z
 LioBqMae6YaKfJrkNe8KeXGaiRCCVWwZXv2MHRuzgzrYw6IsbpaaaxzrzUIUzn+1+E4MCcCipoI
 j/zyijWQ0WnTPS/Nn2Ul1S0FUzQ4wU2FR3mZrJetFhrFuz8QnBt5yg5jDLpgrHMViVvGD3n9gJB
 5MBdJaht9Td4OR/9RAQoQ3snGz1U/9IDWHDWjMFWdZvDLwUM5xs6oaOsnfvakDxwHfUc/K8dpjf
 i2kX+h3LyFyx5NP6TICMoQ1pcjCua5S+kpqA/b97APKWJ7hDg+BceGJIRPlg==
X-Received: by 2002:a17:902:d2cc:b0:2c6:8eeb:a7c5 with SMTP id
 d9443c01a7336-2c6bc252f5fmr102515315ad.34.1781800980887; 
 Thu, 18 Jun 2026 09:43:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c6a1878426sm86789965ad.64.2026.06.18.09.42.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 09:43:00 -0700 (PDT)
Message-ID: <f54583a9-9b34-41fc-beee-716d84d6fa33@linaro.org>
Date: Thu, 18 Jun 2026 09:42:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] tests/tcg/aarch64/system: Alternative boot object
 for exception logging
To: qemu-devel@nongnu.org
References: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
 <20260618-jmac-gpc3b-v3-5-353e546067e7@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260618-jmac-gpc3b-v3-5-353e546067e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/18/26 09:33, Jim MacArthur wrote:
> This allows us to record information about exceptions using a small
> area of memory, and continue with the test so it can verify exceptions
> have been taken where expected.
> 
> LOGGING_VECTOR_TABLE is added to switch this on, and vec_logging_boot.o
> is built from boot.S with this flag. Since boot.o is created for multiple
> test targets, we have to build a separate object and selectively link this
> new vec_logging_boot.o into particular test binaries.
> 
> Signed-off-by: Jim MacArthur<jim.macarthur@linaro.org>
> ---
>   tests/tcg/aarch64/Makefile.softmmu-target | 11 ++++--
>   tests/tcg/aarch64/system/boot.S           | 65 +++++++++++++++++++++++++++++++
>   tests/tcg/aarch64/system/boot.h           | 14 +++++++
>   3 files changed, 86 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

