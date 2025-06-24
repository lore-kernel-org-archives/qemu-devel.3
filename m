Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D897C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4uQ-00018B-9K; Tue, 24 Jun 2025 10:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU4uM-00017N-8D
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:45:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU4uK-00009J-Fj
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:45:58 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-23694cec0feso6020995ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750776352; x=1751381152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ODBmitI/0MMzGttdFqYT7jEoIYibHI8H5fbSfW3QObo=;
 b=iZZ4MMnGERB5ne8lND0KVXjALTcF75/KUm4K6KHl9itnU8GYf4HWMc5Pj+crjJlSzn
 iHko7RW5zdwkP90TTEjmhgWpA6mXETfQa3oUptztSxFJCPU4aqMZkwbWS2KhXxyOEDRy
 WBCXvTrv/Nt0/OYc6BwsEnp6ymIMtJ2L0cU1VaB0WzmYs6hDV5d0jmiz/qi8nTv7P3Za
 lapRaxF+F07zdKkwL1ItmkuzX5brdTL0+83srsf3QLcGn10cVz5v1t70qvaWKJWju4gd
 vSFpG6XEBTNUFfjGkYMrt7A+3SEVBb4IvAmj+C1mhu6QLp7a9tN08n7br9W8GXQZaC36
 RVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750776352; x=1751381152;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ODBmitI/0MMzGttdFqYT7jEoIYibHI8H5fbSfW3QObo=;
 b=agIQOSo6bZpN+1ojdeYv92rx0RIiHA/jxIKM59Mz0evEu32KqwRC6zbLYGcpG9geUd
 zY0MyrvFYBegYkYi5AFMFPjdYqX801EIjEKx83Y2FlvcyrXWTY7Rqhz1MxKGROUwbFox
 xDpPmpbhqBhp6Qqv+vYR0F+tVSR8I/hEZm74dYTw8kwqTRgmRFChJ0AAXeqEEkSMxYHq
 Ck4U7BBRHWlW1Vmbxy5VX11IvehTGh0ImbHLYeWWIm1qXIYZAyjmBvK8loDqy7Rko2ml
 oei9q02LMQBG7xhwipzK8m6R7BnNjGjzfx95DBT1zcycO3FCinQOcCzyYzXBLosyDAss
 x1QA==
X-Gm-Message-State: AOJu0YwsFtolE8dSF1chQLq0/w6FrH8IxbHFbqUFyWJ7SomgOZBbcS2u
 SO53uPuM7DC5aKJtmpU91jkXJEpb0CsswAvgbfjRccpGxBAuUEsLZHgAKSxt7YYb8/A=
X-Gm-Gg: ASbGnctvI7bswEnYrmvhafYzbtxdnA5kfd1egDXHbvK+IbvfGi4J+2sVFhqnRGMk4ws
 knUs7SFOrSliYEu1JBEYIAUr6UXoj/fjg812pi3EuFIvVexZdG07jbk8RyjLcV0a16JJT3N+CWg
 f3sv8+f5HjT0PX+D/9FEZAgbJMcml5KPqPr0FL57OWKE24R2gHvJS/t2Gat8gSJHDVAfu8jIyG1
 7l923Lgna3ptlPvmvpNJ01YVi1Fn0JdHWZAek0ra/5LzbK1KhCKl+swup7TjDlT4E8BfJ7kIU3w
 MTJVteufUyHvP6+pyoNlypYn5tllNkC9kV3LGmOL4qOnqS/qbf7dcSg/Z0ruMmBkFIGqwxZ+KcU
 rzC8Z+aFrUbCyJ7joSpktYjo6bl45
X-Google-Smtp-Source: AGHT+IHUsdAq36jvqtI2drFhkZ+kYzh4ix3nGgDD/vSY5sgus1hnI5NawxYK2LxuBsAOpELJlNesXA==
X-Received: by 2002:a17:903:320e:b0:234:e8db:431d with SMTP id
 d9443c01a7336-237d9764d8cmr252942195ad.20.1750776352127; 
 Tue, 24 Jun 2025 07:45:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d860b619sm112160715ad.102.2025.06.24.07.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 07:45:51 -0700 (PDT)
Message-ID: <b7e787e9-4e4a-45d1-8cd6-d06bcb86880f@linaro.org>
Date: Tue, 24 Jun 2025 07:45:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 034/101] target/arm: Implement SME2 FMLAL, BFMLAL
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-35-richard.henderson@linaro.org>
 <CAFEAcA-FziWjBk6_QYVfcoyPkwOwnNOPNFugkSBBxsjCOPHEzA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-FziWjBk6_QYVfcoyPkwOwnNOPNFugkSBBxsjCOPHEzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 6/24/25 07:28, Peter Maydell wrote:
>> +static bool do_azz_acc_fp(DisasContext *s, int nreg, int nsel,
>> +                          int rv, int off, int zn, int zm,
>> +                          int data, int shsel, bool multi, int fpst,
>> +                          gen_helper_gvec_4_ptr *fn)
>> +{
>> +    if (sme_sm_enabled_check(s)) {
> 
> Looking more closely, this isn't the right check: these
> insns all call CheckStreamingSVEAndZAEnabled(), so we want
> sme_smza_enabled_check(). (Which makes sense, as we're
> accessing the zarray.)

Whoops, yes indeed.

r~

