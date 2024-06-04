Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F66C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 01:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEJPS-0004rA-GQ; Mon, 03 Jun 2024 21:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEJPQ-0004qP-TV
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 21:56:20 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEJPP-0003MO-D3
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 21:56:20 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-795186ae3e9so12101385a.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 18:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717466178; x=1718070978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q4UbFOzSyV81kogGs2H/YvbzXNHVLZH+gEpKBvbqakE=;
 b=fFvc+X96mNxwBPZHTNTMygNLBQRnDykRCHJs16ava0reaU6/k9KYtkpSkbfUY0dPPN
 xOma0sgAziZa+SIvMd0k80tqYmk3+5c/7cCt1fRiBYxkpBEILpNP+qpRdIJudoRRkULm
 HzD/4Hrr4y0bxKJpK9Hi9RZ7vXiYSzCh+fr8aQ/2rSHHuEZ0oS27xPITdP/bgDVyXFE3
 w7bcPzmTa5FtObLSV2fVDTPcqtaxXMU0EDlF4ugybjMIItp1j86KOrCB6/LvnjYp3zLi
 sWwVvhhNSgEZGduuPybj2U/HZgutga2PGzf1LjDQuDtNY5YyoJwm8Pi75Sn2H9034twP
 truw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717466178; x=1718070978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q4UbFOzSyV81kogGs2H/YvbzXNHVLZH+gEpKBvbqakE=;
 b=e7DZYG+FrwCHOstofF5IAiBShF+IJgdvHsuLQXg5bob8MlSEh2408tqC1jCmfoC+fq
 8vLGJO5Xor3HIQ4HZ7S+HOpsenurPYGXvAoV0QJ7RpbHxMnzNbzqkWD6LH8Q3GAccClo
 iZbGP41feVqFmBvF3YaBxOK/g0agdAPJ3+vLWaxYsc4y7DEXZojOLPZul6PdKZVPQ5pq
 /QjnXiNrpzQOsQzawf9FyWrEReH6zRYVHkZjH6rJrZHZnFMWLuiVTzkeJODKyOUkuFYk
 38Nn01tTGWBVczBRDjaNVZfVv59wjXjmbmQFg4ELMxu70fWKp3wqIE2F+k92/i68XFW6
 YVCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxDtvamfpr34ttsqPQJpR2YdeTc+mHfD2ke981fV3Z8wIZUBrVbSWuO6OFl/ufp0rYo7wDuOLTPNov+KbrZ+g3+yepjmc=
X-Gm-Message-State: AOJu0YwXYBFEUSG4/dnTIlaGkQVcVoAuOPmSw0F3gI/HyEXAE+vUAvkB
 463rRr/b9V/KfJnLR5K0FRmNc+fycrw1O+yOdjqn1Jkkt5FgkNhmnswMD/vdK1w=
X-Google-Smtp-Source: AGHT+IFQj45O3lZ3wBAcVCpnDmJUdd1ISMLVv6IRKXBRJ4qVhaTuu0Ccq7v3UZ07SHcZdPFtmZ7OGA==
X-Received: by 2002:a05:620a:561b:b0:795:14f8:f0dd with SMTP id
 af79cd13be357-79514f8fabfmr119061985a.30.1717466178117; 
 Mon, 03 Jun 2024 18:56:18 -0700 (PDT)
Received: from [192.168.223.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f31706e9sm328339185a.102.2024.06.03.18.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 18:56:17 -0700 (PDT)
Message-ID: <35535d71-f059-4821-a376-f9eb9bfdad01@linaro.org>
Date: Mon, 3 Jun 2024 20:56:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] scripts/ci: remove CentOS bits from common
 build-environment
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240603175328.3823123-1-alex.bennee@linaro.org>
 <20240603175328.3823123-6-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240603175328.3823123-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/3/24 12:53, Alex Bennée wrote:
> Although I've just removed the CentOS specific build-environment its
> probably a bit too confusing to have multiple distros mixed up in one
> place. Prior to moving clean-up what will be just for ubuntu.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Message-Id:<20240529160934.982373-6-alex.bennee@linaro.org>
> ---
>   scripts/ci/setup/build-environment.yml | 98 --------------------------
>   1 file changed, 98 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

