Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E0AC3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyIN-0006dx-KN; Tue, 30 Jul 2024 21:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyIL-0006QI-9e
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:38:25 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyIJ-0007b8-PJ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:38:25 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc65329979so42233525ad.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 18:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722389902; x=1722994702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jWhAJ0Hb8WBosGSO3xPnD88U9/cyZVVY3ietIjXHoTM=;
 b=bgTlEpyhzQqCRikc0GSRTDNgVpkDewX5Y0vMdJWvcsxNZHrEF3HFrs+MjJE6YLp8oR
 2vSyvQrHn26+odSmdsdyf1sLwJbDJKoe6qWM5n1Y4sZQ2jiEytNBjGf45dmsYbAodXgv
 9g6htu0IHd0RoELjTkDlisGy2csH0sKVWlzVOrz4d5n0ejVJgs63F6sQiBfu6nf6piZY
 CYkS6hypQdj7syOCwMbhO6+3X2Uz0zvfOH2Zp7PQJ5V60hr5aOqCGimqshD7tbcVtRcZ
 rvSfa5+j4eEMEjO4HkygYCYSqNuKo5BiacF3AooFC+jvGxVIdczjGQg/LUGmS2CvUbVN
 QOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722389902; x=1722994702;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jWhAJ0Hb8WBosGSO3xPnD88U9/cyZVVY3ietIjXHoTM=;
 b=abhKyam2GmjFvWDR7ToNY9Jmq3LnqlLPEek0dQUQTPLN9ffZ+j6Pkfnxy5CWLn/VBo
 B04QU7jmYnkQdrhFf/z3gcy4EeL9WMOlr98zcXqOatO6Z+guIILaFjleB2t0bG7d0GGt
 9pjFKL9yp97P+aK0Ltr4xFrgNTlg6ejVJp//VdQbIPmutLVyE62gsWsSpyhnZM0EYo4s
 Dr80u06LYQd9gCljSowgTxAfyIvJxZioCmfwVbBUI2IgQEMYPnBHZp8z4z3X0appKACU
 7ZXWn0hGFIas6yW7uFLB1nKJzsV0KhiQSS83QPnKorrayOJflwA8G9swrfq6guuKIXVX
 zYnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+ScbxKGmhmOi34o7Lt1WDtQ7WhRyAlv2OXXd07ufedZDj2hV/1BUqEfoYoSuhZK83gOHkmlnG/1rDTze7qWOOopVAe0w=
X-Gm-Message-State: AOJu0YzsQK//Oor8kv5Ab13Cyorzen1P1t1adonWlpcvygd34s27SHvs
 BLDIgrGb5FYOlLG7WQ5iX9bBHlH50a6zetmOhgYmJZBuG7PguI/LRneo4WwnpIw=
X-Google-Smtp-Source: AGHT+IESAwxVvGcpq9iDm0HC+ZSrWQEBk/3QGoV1QusCQhLtN8xlNlyZcrnHcacDEdFNKPE+TWpuLQ==
X-Received: by 2002:a17:902:7688:b0:1fd:a1d2:c03b with SMTP id
 d9443c01a7336-1ff0491af26mr124494865ad.59.1722389902232; 
 Tue, 30 Jul 2024 18:38:22 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ff680bsm108325615ad.298.2024.07.30.18.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 18:38:21 -0700 (PDT)
Message-ID: <5c5c1f49-0fea-4e46-92f6-e3c03fd05fe4@linaro.org>
Date: Wed, 31 Jul 2024 11:38:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] target/arm: Pass env pointer through to gvec_bfmmla
 helper
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
 <20240730160306.2959745-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730160306.2959745-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/31/24 02:03, Peter Maydell wrote:
> Pass the env pointer through to the gvec_bfmmla helper,
> so we can use it to add support for FEAT_EBF16.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.h             | 4 ++--
>   target/arm/tcg/translate-a64.c  | 2 +-
>   target/arm/tcg/translate-neon.c | 4 ++--
>   target/arm/tcg/translate-sve.c  | 2 +-
>   target/arm/tcg/vec_helper.c     | 3 ++-
>   5 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

