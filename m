Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B231AC3DA61
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUcO1-0002mW-0Z; Thu, 18 Jul 2024 21:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUcNz-0002ia-Ek
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:26:15 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUcNx-0007KA-PM
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:26:15 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fc49c1f3e5so13861615ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721352372; x=1721957172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zmj9pMO3Ucq+mGI2rmRIXB720/2tej18O0M2DBlX76o=;
 b=UYEdhBjG1GXcEDBi/vnK3AxZAr7Mti+h8RNIINyuS/V4G6JWgPjzPA74EkfJA5JZ3G
 bEioZEjXB4HY0rXWvq32p/qcUhMAgUbPWSsZiCubIK+LbkHMg0nh8eUFeQwmGF0/h9B5
 5Lfztt5AxUzdffYdXNsmGAi9KmMhj+zvKyWjUTwVV3O7s+AlyU298NZYKSUmoA/LAu2N
 swF07bJtr7sBwwHl6z05XPes7EfiA03GmBvEzN+uwSIzhydKK9fBr4iuf30Lu3SfFLLg
 Vc2+jLko9tDsw/jvGU5PEbZ1J8GmN8F1PwlBu/P7vQv/ZP6UGnrwMeqQV4k3y+2z4pkW
 FoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721352372; x=1721957172;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zmj9pMO3Ucq+mGI2rmRIXB720/2tej18O0M2DBlX76o=;
 b=F+2ai3anzqe8xKm7BbnmNvAYsMB6O8jX7+a3/krpTAoOEBtt9zc0w1vx9RFQ0XliqC
 AV5vFQan+soVSeB/fkDKMB+kIGu43umYu6Cq0mkK5ssyYyhKBBMq8E+mUdArcO4PdN4t
 XudlNGtlJFCzO97OU0rsC8dG1byZJDYhjYn8Lq/mrnjWiIIdI0LoaUS3RKGJS0/PYpmh
 2g682zSJEV1BPrFl/r1UXi9rTBCZKxk1DXERkVdsAICUftFGklqdUPgKhFegD46vb2vs
 PSKt95BNKOgdUeDy5jQfOfEbAevn9Ut8c8C8w4Zrd0+dzCFMBUxRUTe6N95Hfqhjl123
 v8DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURZhzkj8ZRYZ8CKy99yyfls+DqcCLIlW4BZSqoWN+LWY3tyn5nvDj273Yc4n4mIGEgUR6gY2USE38fGqLmZaoNUksKuIQ=
X-Gm-Message-State: AOJu0YzvtYizuJOKmZLMCL8NyCuyuV12ZFHcXdgSCoieC3RfFwbhOo9p
 P3ZxMPRMZ66KBt8s//msUNjMFpwRjS6mOAur/xOqpVOg/Rif+d+kalpr5122DJkeC4sV1BzIP6i
 lgzlwTg==
X-Google-Smtp-Source: AGHT+IFkg6HcUXSiIBuK6eInFM3KJt5qtSvdIK+EVMdpBB+2KBNatPE/fW9BDhaU0JhDlsHi7mtksQ==
X-Received: by 2002:a05:6a21:3514:b0:1c0:defa:b68e with SMTP id
 adf61e73a8af0-1c3fdd99bc4mr8120661637.39.1721352371873; 
 Thu, 18 Jul 2024 18:26:11 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf80a9b0csm289349a91.57.2024.07.18.18.26.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 18:26:11 -0700 (PDT)
Message-ID: <0ac3f760-c105-4bb1-a397-3ee4570941db@linaro.org>
Date: Fri, 19 Jul 2024 11:26:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/26] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240718132028.697927-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 7/18/24 23:20, Peter Maydell wrote:
> Hi; hopefully this is the last arm pullreq before softfreeze.
> There's a handful of miscellaneous bug fixes here, but the
> bulk of the pullreq is Mostafa's implementation of 2-stage
> translation in the SMMUv3.
> 
> thanks
> -- PMM
> 
> The following changes since commit d74ec4d7dda6322bcc51d1b13ccbd993d3574795:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu into staging (2024-07-18 10:07:23 +1000)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240718
> 
> for you to fetch changes up to 30a1690f2402e6c1582d5b3ebcf7940bfe2fad4b:
> 
>    hvf: arm: Do not advance PC when raising an exception (2024-07-18 13:49:30 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Fix handling of LDAPR/STLR with negative offset
>   * LDAPR should honour SCTLR_ELx.nAA
>   * Use float_status copy in sme_fmopa_s
>   * hw/display/bcm2835_fb: fix fb_use_offsets condition
>   * hw/arm/smmuv3: Support and advertise nesting
>   * Use FPST_F16 for SME FMOPA (widening)
>   * tests/arm-cpu-features: Do not assume PMU availability
>   * hvf: arm: Do not advance PC when raising an exception

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

