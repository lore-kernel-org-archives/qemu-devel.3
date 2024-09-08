Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD843CD4F4C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 17:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snLsa-0004IA-9n; Sun, 08 Sep 2024 13:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snLsY-0004H8-Ef
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 13:39:15 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snLsW-0006Jw-QI
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 13:39:14 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7d4ed6158bcso2567550a12.1
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 10:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725817151; x=1726421951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=naU9Lr3JyQwlpeT11t1RZr79ucebsjosGEYejKvNb3Q=;
 b=vmGdw9q/+tazvO9GZs9ScB9dRigzdQnlQUvoGJcBLVSQexO5bU8VaGrGtp3pmgdGuE
 clbQ9uHxM573U3BEn4yVkWh+SZ5VI5utQR6muciy/9Du1m6gQ9di7GTfdqmY0ri8w9dq
 aq/vCtc6Pm7vZ2sgQNuRVUTNog8RVzDzF8a81gInawDbZilIn3FRvk/XZoPy+iM6uq8q
 bgLVpjiu6KVqzhYWB85VLmGvxaWnoAhRvkC/FhcjmMxEkM7GgKh2QB8I9FOwgELYgbKk
 /fcathYygdRNwTljPkiEVvlwZmvavrwMGlPH3vuEcnsEhFqlSjKuVDlzS3AorEAD20O7
 KMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725817151; x=1726421951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=naU9Lr3JyQwlpeT11t1RZr79ucebsjosGEYejKvNb3Q=;
 b=tTPeqlghCSNfiEd+FQhUGZ4XBzen4+aWOSLTxwzTOSfksIMErEeHfZe6kk2SdPytn2
 AarcPQ9mH90X33zJR2yFFwV6txfz0jg1tzUaBdLruxVCoOCrMybv07tvAuDmBYsPbc4H
 C2O1MnN6MAsxFK73uUldY9yPqtQYaC0rHvIhALsoQ+lWaJTcRPPGbr6PGMWbw3a2+/8R
 wUAB4dhMDo2ST/Kri9excQlZYwUcvMSHgdZ6RUvPLHPGxA9/kIMzdTo/hmWCvpOV0Q4F
 dXyETeloT/1YUmQhNt3H+bjcUnf/n3fmJNziZZCMjkCmeCK9zLSM5tBnL9wQ03z9GiMd
 I5WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOBcrsFbLNrOxlLc5mBbk7D7bNTsF2b7WMByLJk3ygMXPDBvB1O7BmgnhiXB70+4dOVvZSRboaL6MR@nongnu.org
X-Gm-Message-State: AOJu0Yxy3mQoACma6/buERd6NNWKi6HrfjF0doO3q7n2HXL13y0xwck0
 on0UxvoQDvC0xd/V16Vr4esAL0I4nuVbmrhtChI5BOzlZjJn7IAtlCsSJ8C5b5o=
X-Google-Smtp-Source: AGHT+IFIKrZDzvFiTOc5r4FEu8xCwk4hOj9U8d27Jhy0PQURM0OIgspjbTMlLEr+X1yrOthwIPNeVQ==
X-Received: by 2002:a05:6a20:45c:b0:1cf:2ef7:b396 with SMTP id
 adf61e73a8af0-1cf2ef7b523mr2568652637.6.1725817150634; 
 Sun, 08 Sep 2024 10:39:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc127ba8sm5036122a91.48.2024.09.08.10.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Sep 2024 10:39:10 -0700 (PDT)
Message-ID: <08b5c803-cfcc-49bd-910b-61934fa2d1e6@linaro.org>
Date: Sun, 8 Sep 2024 10:39:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trvivial] linux-user/syscall.c: replace function pointers
 for flock64 fcntl with macros
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240908071600.430410-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240908071600.430410-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 9/8/24 00:16, Michael Tokarev wrote:
> For 32bit ARM fcntl64 syscall there are 2 possible argument types,
> depending on cpu_env->eabi.  For other architectures, it is plain
> struct flock64 in all cases.  In order to solve this, old code
> used to take address of the conversion function and and run it
> through this pointer.  Instead, introduce 2 helper macros for
> the flock64 conversion, and define them in the same block where
> the oabi conversion functions are defined, and use these
> helpers directly in the actual code, making each part more
> self-contained and easier to read.
> 
> Also add comment to the block of code which itroduces the oabi
> conversion functions.
> 
> Note also there was an inconsistency in the old code: different
> the differences in single place we eliminate this difference.
> 
> While at it, replace tabs with spaces in nearby code.
> 
> Signed-off-by: Michael Tokarev<mjt@tls.msk.ru>
> ---
>   linux-user/syscall.c | 40 +++++++++++++++++++++++-----------------
>   1 file changed, 23 insertions(+), 17 deletions(-)

Why do you think this is an improvement?
What was wrong with the function pointers?


r~

