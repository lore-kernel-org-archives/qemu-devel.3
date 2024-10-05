Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A48BCFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAQc-0000P7-KZ; Sat, 05 Oct 2024 15:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAQa-0000Ow-P5
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:26:56 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAQZ-0004vy-Eo
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:26:56 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71dc4451fffso3178922b3a.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728156414; x=1728761214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O+QUIzbsmKQz7yWKePSKF/MTe0CfJIeb3Y/PCdXU7/8=;
 b=hRDYv22azW4LHxFUnrTKuNUs0axaZcjshAKfX0MpbfGBYOH2yKB205y5wlUQ8yBJJP
 UtalZ2eURAkXWvD1dZt3jmd5xx5bi8je9rVb30kb6yub5ahOxcmQJX+Nrc4z8GLca0IN
 kn+pQN+lFSOgpbApCJ5lbKhqAt059gyZkHYBeGJ7eFhzJnMhVIAJ5n/g936onrcU3ii8
 rJUNf9kc7os31+hDYfVvSZBvbKhF03R+P9gE20ey/Rv4XD8vpbjYbxcnEOKDMukOR2qA
 uUdYwTiTrX9hMM+NE6rbzn42P1YaeojoBMfDQObDusLslTrWkYqlBRjEKsNAk4rISwDL
 MWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728156414; x=1728761214;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O+QUIzbsmKQz7yWKePSKF/MTe0CfJIeb3Y/PCdXU7/8=;
 b=A9ruDIbXnl/BkAGa+mIQ8ROA7VfZusVknlrX9LqG7Y+bHrqQHOK5ZyeRQfqs3FTi0I
 Sam3zmxA2Ng3R+A60VUL2gntMH6ds1mPidBe1JfMknc4saMhqMqeQ0Knl5dL/+QhcfqD
 ijXk1xB4c4YrTCx6CyLloj1TDUGVhZbXv2PrdEtS8BUqaJd5XLSzb/xaCc2jZLgA+i8f
 oqNGoNWUTvjlAdWpvFCSaH9Hq9Ce6rceEN7BBpsf9ez6+My/ZqzQShTSxYj1YCF867WT
 rC6hOfsaikw5Zqk8gaZ4W73PF+v4ImAb0A69fbUoB6gUZJ8blI8jy7ZXvzwbyL+v/pgx
 fX+w==
X-Gm-Message-State: AOJu0YzPeVnasEqP5no24nlkY2NUdUfJ+b4MuacYeU0doVT5zjO2Qyni
 oVW/L9htHFnQBYyaMAyFkHkKLSQvh82sL03+alc6H7D02oMlOr6/0edz1isEsAA=
X-Google-Smtp-Source: AGHT+IEkzFr4bEzcy2arV39UcCfNozOHRkq82JOaxSDrEWj/lTOyp+AaxTEpZsimEhmbyUEdQDRLrw==
X-Received: by 2002:a05:6a20:2d07:b0:1cf:9ac1:ac8d with SMTP id
 adf61e73a8af0-1d6dfae30c3mr12024516637.44.1728156414041; 
 Sat, 05 Oct 2024 12:26:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d651f6sm1790060b3a.164.2024.10.05.12.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 12:26:53 -0700 (PDT)
Message-ID: <6bbff82c-cdd9-404b-bc04-c85ffef72841@linaro.org>
Date: Sat, 5 Oct 2024 12:26:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] gdbstub: Factor out gdb_try_stop()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <20240923162208.90745-5-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240923162208.90745-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 9/23/24 09:12, Ilya Leoshkevich wrote:
> Move checking and setting allow_stop_reply into a function.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   gdbstub/gdbstub.c   | 15 +++++++++++----
>   gdbstub/internals.h |  2 ++
>   gdbstub/system.c    |  6 ++----
>   gdbstub/user.c      | 11 ++++-------
>   4 files changed, 19 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

