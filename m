Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0931ED10BE4
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 04:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Ya7-0007ek-FT; Sat, 26 Oct 2024 00:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Ya6-0007eL-69
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:39:18 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Ya4-0000gg-Qd
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:39:17 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7db90a28cf6so2419517a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 21:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729917555; x=1730522355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gs6F87cjm0we97xF2OmKhXtcxUpIT/xX+fPAETT/hiA=;
 b=miFvgaqX1j9BSz7wMgHb/jBtUzXBpH1TILaURKTFrsvTwyAnutMh2uR8nLRipTm0/m
 Ampbvs0svpFATf/MLv1OUHQo6GIU+N93g/PuXf7YqfEmOgbCnfo6/Mub2NIshUdnUaun
 OwrtBqI5eXwXo1dHB/3nkYxLMZ24fbdtvOKd7N2Wv8bXWcLXG9I53j1tsdwUZt/1ICsR
 cX0ODRmLklm3nYBXMebVWGqMZnPy5qRriTr9JReS5uAeDt+RvczFfenWnUT4vEobW2q2
 FIo87Eg2r9r7BfY9WRRPxLPEvP2dOpgMf+nqYcysfJ4skKKrvABNoFj+tKJE2TTtuKXT
 dpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729917555; x=1730522355;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gs6F87cjm0we97xF2OmKhXtcxUpIT/xX+fPAETT/hiA=;
 b=JbkB7GubPLNe0KPBiBB6R98Pp8780xLbohAm46gZvEIqFcXLXc1GtXcb3C8MMaBrOw
 Yq2PslcGopBUujC2NyTvNlzGld/heWQnohRkA4h8v+BH4G/e0SgQgPSZnwm2rG6cuox9
 pB4xoWeOB4ctjpNZ01XPLOZqxvmjhyouVPmxSek3tUFwRvs3VMdy1o/XVcPkmTfDdm0I
 gb9XiO+hhU5bv4Xl8na4XKvdw5dm212y+xARCRwPhp0NxvDbKRbwhBKNQuNWD/Wqn/84
 gynuofvs8QchvctLvzdqlTOrDh/KeEvELX6R7ME77f6cECymibn321Vm5/i/2w4gYt7q
 mZow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiYtdd3O+GRQmCLyDn5ggPO1USMUYVfDYsNQ4Lt0p3H6DJ7EyTjUi3T9K0YQt3M1E2ZWGmvJ1KcH4x@nongnu.org
X-Gm-Message-State: AOJu0YwfU8sDGBDnZOiz7wW2SLuzgdHkDe/cqfv+Ewd2Xja7g4omnY8s
 kzq+e6qkEEDlqTbzRV9v6CfLF66mHCp9lTzZRp6bt8V87MW1yVIip/oVbbUo9Mo=
X-Google-Smtp-Source: AGHT+IE9cAmM7uvfX63iDT5wbxyT+quafADF/2cuZhczWLuuSId5gPFypr8wGxOgyNuz2Jpnye1Idg==
X-Received: by 2002:a05:6a20:c6ce:b0:1d3:418a:e42 with SMTP id
 adf61e73a8af0-1d9a74dfaf2mr2800762637.10.1729917555344; 
 Fri, 25 Oct 2024 21:39:15 -0700 (PDT)
Received: from [192.168.120.226] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8664f4csm1981393a12.7.2024.10.25.21.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 21:39:14 -0700 (PDT)
Message-ID: <1451fb8c-029e-4342-81e1-74cef282ba0d@linaro.org>
Date: Sat, 26 Oct 2024 01:39:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] target/alpha: Explicitly set 2-NaN propagation rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-17-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025141254.2141506-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 25/10/24 11:12, Peter Maydell wrote:
> Set the NaN propagation rule explicitly for the float_status word
> used in this target.
> 
> This is a no-behaviour-change commit, so we retain the existing
> behaviour of x87-style pick-largest-significand NaN propagation.
> This is however not the architecturally correct handling, so we leave
> a TODO note to that effect.
> 
> We also leave a TODO note pointing out that all this code in the cpu
> initfn (including the existing setting up of env->flags and the FPCR)
> should be in a currently non-existent CPU reset function.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/alpha/cpu.c             | 11 +++++++++++
>   fpu/softfloat-specialize.c.inc |  2 +-
>   2 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


