Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FF5C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 21:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOWK-00082z-ML; Thu, 02 Jul 2026 17:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOWI-00082m-Oc
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 17:00:26 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOWH-0006aF-23
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 17:00:26 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8478fe07f0fso2235504b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783026023; x=1783630823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EflicaIUgjxoSqGPty5Nlg1N8ol7jXe0UDpgPQB7Lls=;
 b=Y0CsfB67ez9WnrTzW5dh1TgLutpdpjsYTU0rOLn4CtQ4dWq4nBQCpwtsWdPjeITM3q
 nsijZDm60nRwwlihKuxH1DR6NfaVmab2za8e1AU4PQgvZe+EiQTQ/TLCT1WJoysYOAdj
 LdL/pe17z73XdeG/ns1274jfBmx687RAnX8Tf0LXuqLwtIhJWqBcMICf7FtMYEBY9jhK
 zaWTGAyQIL1Ls9T44r1qgAyNUHsBoQu2Qp4aVW5WXj8LjRIWvUjer7ccW5ijlZWpSpqu
 IwQ6MXI7SsuNGLznESk6g1btDcUVAkGox+bf1erXCPvFtAXhX3ZNAhK/5BNFViWMaxSQ
 XY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783026023; x=1783630823;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EflicaIUgjxoSqGPty5Nlg1N8ol7jXe0UDpgPQB7Lls=;
 b=K89FGiHGyjh6jJNzy2ZskT4HdDgw7ALjgyTr8SoGi5OYWvCmg0y6lOsZM7SfQRJf3V
 tvmQ/vT9fEPxQoXFgs2YJIId0kIXCcdz+vOC/6XLGQcf6OUd9xtS7MGjx0QCVflmcyqz
 oS4DxLCO23LerI5Po1WOs+Nvhr67MEYoDRmmHVdGOF9B+HHb6Hknrs9vczqFUGXRRjfR
 fBiCIvsS/VP0nndjRv217iuffocT2LcDV1967xbHwEXi+A82SKTV8THYxgZo03FRS7mb
 UJeHEkvSc4BKjRrHjCevlqBCTr6ZxAav2dqy3mHQ9bH8gzC8bPsy+v5R1dmzlymzFzBQ
 Mkaw==
X-Gm-Message-State: AOJu0YzEqPl6fBrgJiJ5YbVFvaMnPXof4SklpQn5mhDQSIy03GVng/bw
 k1ghB6MFIXcziHBkptSy0k7oWDXrGfpohjdRXR/ChCoO0Q7iW6gdxYsvkEz6KPjQFzCVgw0WFfg
 iXMoJ
X-Gm-Gg: AfdE7cnkme6sIE4Fkr2WwKM9bb36+q5ZQHPU0sKgIb6NrNn6gR0FVtqlygDaGRhx/i+
 Od2E1bDizx9/z1eO0hqjxj33+6EQ3Zja1lf3K4v9WwbUbCOndqxz2xMxEkUh0ccyqWE7owxNZ2+
 Tv7Tiv7ySzJk2uKaFOkKWfb0FUSZTouE1DcrH/HHv18Q05piCUiALh7+NNYk1nCM0r6MCIJqOuc
 Kx+baNcvtnIgboAsLIlIkdDhdXze2aTHUu5brtgKXcMpAyGkQu0mMSjO0PY62KJZlS6FLbs0+IJ
 tlxS5Uq8siBZ/IACFuxm3A9jebdu6wDhAHnTf3qldoaR4TkohjA2T5yrtd2exUXaBkgyhDA3Oip
 I7+Nm7XBvV9Qx0Q3GXHrJQ0zxQhBKHulatR/LM/eWC4kWCxsj/kBPjK+B6jyLZagIMCuUV+fXJ8
 eDbeIIbrIHcIraPuGosj6PZNEoJWi2Gt7hCUzyJWdQjbEnLvfHF0vVW8ekIw==
X-Received: by 2002:a05:6a00:8d1:b0:845:dedd:89b1 with SMTP id
 d2e1a72fcca58-847c082cc4amr7832091b3a.34.1783026022907; 
 Thu, 02 Jul 2026 14:00:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb747817sm1942393b3a.16.2026.07.02.14.00.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 14:00:22 -0700 (PDT)
Message-ID: <578611d0-63c5-4e4b-bb77-c7f056db9420@linaro.org>
Date: Thu, 2 Jul 2026 14:00:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] target/arm: Define fields for NSACR
To: qemu-devel@nongnu.org
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
 <20260702184019.3431139-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260702184019.3431139-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 7/2/26 11:40, Peter Maydell wrote:
> Currently we handle cp15.nsacr with raw bit numbers in the few places
> we need to work with it.  We're about to add some more uses of this
> field, so define its fields with the FIELD macro and use the macros
> in the places that were previously using bit numbers.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c       |  2 +-
>   target/arm/helper.c    | 10 +++++-----
>   target/arm/internals.h |  8 ++++++++
>   3 files changed, 14 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

