Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC197C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 22:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSm9k-0006JE-6z; Wed, 24 Jan 2024 17:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSm9j-0006HT-43
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 17:55:39 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSm9f-0002HZ-Jj
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 17:55:37 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso30225815ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 14:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706136934; x=1706741734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SV2C7UD6E08+4MuqNIOOHdBEOzIP3IxS94vbuRd31nU=;
 b=KsS8f5m02Fs8jWxijoqK53IOAnK/GtNB2wZbHJGJ5hlMOEYbDRBur33T4o8c8OMbQQ
 XKdPt/trlhWTHv+V7abL4QV23TZ2hmmx2atF/I7ErQvAblaX5agJLtvrg1q2EQ4eKzig
 ZUsooWGjrD+BiGF/S6rkZYMcFGbU+wmhZDvVx1t2BgW09yWjnWjUM5Jffe1u/9JZpS/L
 taTvoq8i/jQVBS6OBbd28TuG6w+n7oCuRdTSBfejP03LGCkuEwuBfKYLM+7rD631hENw
 Zd9NWQ+tAz/JWBASxA/F6QUetCC9BqpTdkOQZ7b9dlV49U5QI00qtvMowHS6kLb0so0F
 Gckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706136934; x=1706741734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SV2C7UD6E08+4MuqNIOOHdBEOzIP3IxS94vbuRd31nU=;
 b=CN+ky0dH8JW0QmwGoCW3CIdScTDOUVTe3X2S9nQIBPMtK8bdxPHeEeYahrqjkL4IAG
 g/rN2Zei1wCXAVJ0E77eZDBThLnC3q1S5nD3EZbjuOaNtdlqgPaQCU41sc84r+sDOUMz
 EAabn9R497sYKS2I0TdX0tpHrPiTkzW3Wsi6kWE/kEWD76CMeKAw0ly/8/xtJ2CGpx/i
 +rvfe3zW60eKjSyt925JdgKEU5L4RdE9xvGvvxyDPYLqJJwR2QbcXb4YRMVNpXMoORZ6
 ZMWTHKKeFuU/FFEwwhYaGz8WQcnWQbxAoijFZbuIzdhYqCWxMaoNcMKPGN0OO+4wcV15
 u1Ug==
X-Gm-Message-State: AOJu0Yx6c+iJM4MgTpugkaz7pP2ziUbjeqhxjwcdGQER+pcBVhWPU4sj
 ASOESR94LZOR7pHLzkrD2z27DyDnzp739mBVBCF4DadhFDOF6kTOk88VvCuYrak=
X-Google-Smtp-Source: AGHT+IF+FRLJWGC8bbB62L5GMPk03L06xdaAxp1zaZmFSTSCmB1wViRa0WqlbWksafeEvfuyv+6LTQ==
X-Received: by 2002:a17:902:7ec1:b0:1d4:42c1:3470 with SMTP id
 p1-20020a1709027ec100b001d442c13470mr97005plb.64.1706136934218; 
 Wed, 24 Jan 2024 14:55:34 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 bi3-20020a170902bf0300b001d6fe15b563sm10909619plb.157.2024.01.24.14.55.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 14:55:33 -0800 (PST)
Message-ID: <a6e8c008-7941-488d-a3b2-95daed07cf9a@linaro.org>
Date: Thu, 25 Jan 2024 08:55:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] accel/tcg: Rename tcg_cpus_exec() -> tcg_cpu_exec()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124101639.30056-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/24 20:16, Philippe Mathieu-Daudé wrote:
> tcg_cpus_exec() operates on a single vCPU, rename it
> as 'tcg_cpu_exec'.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops.h       | 2 +-
>   accel/tcg/tcg-accel-ops-mttcg.c | 2 +-
>   accel/tcg/tcg-accel-ops-rr.c    | 2 +-
>   accel/tcg/tcg-accel-ops.c       | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

