Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2FFC3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyAO-0007Lp-HY; Tue, 30 Jul 2024 21:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyAM-0007KQ-IV
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:30:10 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyAK-0005zn-8X
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:30:09 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cf78366187so3270230a91.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 18:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722389406; x=1722994206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9biiJL0mbDr1bvDdX9pp1KXU1e+FESJgSWe1rySFiE4=;
 b=SaxsTTJAfrOCOaqj+ztyTj0mfXynI3A7fBy8s2Cep/VhaFJIGcDd9erjzrdMc1CLxP
 XAL6pT7hft2T74c/yJYuRTaCn1JKsfpn7kOIiG3U8KcJjASpKmeCznPC/uGDwzo8BGHd
 o9g8nkJ5dMgTLkE0xeR2wrPoDRrwYacuM0fo4cpdVR/i649wuqUy6Gx2I0N0bCD8/RW3
 NMyzqOrMExX0EAZ9WDQSP4Eq0d7q18E7j/xnkXEx4qvdLpY+volt0FsK+nSeMVwI60qr
 7nu/YjYf4N3PNeT0GZeO84MN5nEoJEr7hsPvoDXctFKH0EGjQmveJoAuyReU45pCoYjf
 Tuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722389406; x=1722994206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9biiJL0mbDr1bvDdX9pp1KXU1e+FESJgSWe1rySFiE4=;
 b=bmAKZLQx6mjsztawZ09ikRrwBEXK0Fk0WqFvHECK9sDjYw0rKPQbV+0WLIijHGRHJ6
 OK0va+P1TISkh/uHube+ijTZY7M0e97o4YBl2A5F8uLBv1aR8YUFd3uI7uvMWYPt4mXT
 e3wto4Ujli0N0eEtlC0bStrVC0lCPvQnr3fkIEMu+qJImAqOQ3mNRuGbg6RkcBJRpRhe
 lbth/Kb2jMijhS2aOHlbAVP5fnAOcHDykaslXgoe6444lncFacDnwIlj+ITTdAn45oQ3
 79yhETq4D4tdoCRIl20WZMlNvUEBi8QiPICVM4RwEf3QaZL2ZF6Y/ElIaCiQH34Cifee
 PC2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKGBubIRPrY3IhvJqJ2Nm9FiV47Bvi5pEn7ujBD1YrYqNd6jWvHdE7dp3e1SySg5qryGLoNUi0CkYYkVPoN+t5BmQyrY4=
X-Gm-Message-State: AOJu0YyDa8Ttk4U00xjtQEV2sXGvCz0oT1dkm63zt5e4KPLTliui9T5K
 kmeBtdmpijBrsVsUWkRfIqW2APc/1IF7/8zDNKEPNtJ2IOTAUnJWeVxUk4YKvoM=
X-Google-Smtp-Source: AGHT+IGUIMJgiuBbeBI7Uw7Wh94UmGpl8VX7meZaHbHUk21e+jI6TA3kJC67xHkVTW8Xc6ChzUzypQ==
X-Received: by 2002:a17:90a:888:b0:2cb:55f9:b7c5 with SMTP id
 98e67ed59e1d1-2cf7e1df02dmr14985782a91.12.1722389406278; 
 Tue, 30 Jul 2024 18:30:06 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc4bd11fsm72812a91.55.2024.07.30.18.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 18:30:05 -0700 (PDT)
Message-ID: <aa95043b-2192-417f-9c46-5d3b92f8dd92@linaro.org>
Date: Wed, 31 Jul 2024 11:30:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] target/arm: Allow setting the FPCR.EBF bit for
 FEAT_EBF16
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
 <20240730160306.2959745-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730160306.2959745-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 7/31/24 02:02, Peter Maydell wrote:
> FEAT_EBF16 adds one new bit to the FPCR floating point control
> register.  Allow this bit to be read and written when the ID
> registers indicate the presence of the feature.
> 
> Note that because this new bit is not in FPSCR_FPCR_MASK the bit is
> not visible in the AArch32 FPSCR, and FPSCR writes do not affect it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h | 5 +++++
>   target/arm/cpu.h          | 1 +
>   target/arm/vfp_helper.c   | 8 ++++++--
>   3 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

