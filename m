Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB11FC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 16:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNEF6-0004Xr-3V; Fri, 28 Jun 2024 12:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNEF4-0004XE-Jk
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:14:30 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNEF3-0003V0-4I
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:14:30 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-706b539fcaeso1379444b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719591268; x=1720196068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QZP8kctCzPqb+XVusCA+TZZDfcfOZKoPaur+h5nqVhU=;
 b=gnzxnABW/Y7hFg6+AlFs70dVzv3hGiG4SKW5rFHVCHMxJMrJO2IoCTpdJd1y0NJK0A
 Dr9qq4adBfARrTk2bmXXbGCkvhWYOCjkyk5VrVtuqc/6BmKk+0+oAAtCBZb/jUhb0jVe
 9nlfKgUa7rojndy4o4KAVshVPsl4l+6tFfks6g0cE+hEb5tVROS29894KasWes8MFfTQ
 C0aKg/UEtME00SoRvEksL2uaJ5Uo07RMtlSCkDmYoAs37uwn4CK+p4ypaVbVpXGCmoYk
 u4Nup/rOwtxm5MTlt3MHRAURshsCf6+4wLrUs+fYSGYbkrHjbf/xBfFQfEb/AC1YFyfJ
 TvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719591268; x=1720196068;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QZP8kctCzPqb+XVusCA+TZZDfcfOZKoPaur+h5nqVhU=;
 b=fpByPBMFSuHVIU9o+qYTLE39NHmjlLNDuD9ci48ert9bElLNL26wvI+YFFojDBCknq
 Qa9a4WoljKsi3aeaFCUFhC3jkYL8iyWVR75sF0a9ZUOUVvE10x5X9CWnk1oNrzIJJGW7
 34F8gSTUqfAJ2eACwpWf8bYh27p2Z65Mam3UIZREqPsvyF+DivC6EtKy7pNdyeaRRWfF
 dnFelU1SIzMUPrZFIjIafqbr/pjR+ih69wUZhH4obNFZMgjq+iZbH+lFa2jS9TSJGROX
 Va8ODH1tbq1Nj+jJjhwm6VCBYnERR6aEZZJHHKo52OGN79ReTsuzZmBx2+j+Whi+9bD8
 qfqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeAmawJI/cCKDgAaA2pqc5c8+NX5skMPheqn9q6p0KQCnM1INbtkXGtuCrrrjCwmcigPygZduFA1O/2bw54TY727O0GRQ=
X-Gm-Message-State: AOJu0YwdIUF4tfmbqmRKS340hlmQsTuBYYQa0QUo5PbuD8vw7W4Croem
 UHxEM9vaSpDqTABewK0FpjMC2BnvXnUr/DGRXVL41Wwj1W740+cnAA3F9wetQT/dYFrvu3/0m8V
 O
X-Google-Smtp-Source: AGHT+IFmkehbzC5uUZ4F7uKv9Y5O71HKFZysJ5ZtpFFH1eSbcgVPAZw61SXcSkGd7K+fDrDymFwR6Q==
X-Received: by 2002:a05:6a20:7f93:b0:1b6:dd1e:da51 with SMTP id
 adf61e73a8af0-1bee495cdbfmr3596431637.21.1719591267468; 
 Fri, 28 Jun 2024 09:14:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70804a7e7c7sm1782397b3a.208.2024.06.28.09.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 09:14:26 -0700 (PDT)
Message-ID: <f078e65c-7e77-469e-8643-033f81026bbc@linaro.org>
Date: Fri, 28 Jun 2024 09:14:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] target/arm: Allow FPCR bits that aren't in FPSCR
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
 <20240628142347.1283015-10-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628142347.1283015-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 6/28/24 07:23, Peter Maydell wrote:
> In order to allow FPCR bits that aren't in the FPSCR (like the new
> bits that are defined for FEAT_AFP), we need to make sure that writes
> to the FPSCR only write to the bits of FPCR that are architecturally
> mapped, and not the others.
> 
> Implement this with a new function vfp_set_fpcr_masked() which
> takes a mask of which bits to update.
> 
> (We could do the same for FPSR, but we leave that until we actually
> are likely to need it.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/vfp_helper.c | 54 ++++++++++++++++++++++++++---------------
>   1 file changed, 34 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

