Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F2ACD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkg1-000650-2G; Wed, 20 May 2026 13:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfH-0005QW-Dt
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:05 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfD-0003xP-Dc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:02 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4526a8170ceso2482991f8f.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297896; x=1779902696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IJ4yH5acVGHfW9xD7pXc96FkCxZ4GQA3+/lqubaNPD8=;
 b=BNfobO1xJ8DH3lGanjo8P7LgcZAUrrG/bJdxdVE+ewIM/QelvB+t6rUPcmyvgWvKWt
 PyOUiRJ0CWlaHLFTSBtj07Vcg2YcCwXwkr3IKpRCJmBtsxp3kRM3VQW1bjZfj3UbAmG7
 6r/HFq9k4NuDxLF937b5OVZSKjpw+Ag6cbjrKoZFPrrXFzBzhx5sCj3U6jevyjiwrvnn
 BaEjTC6g0INvKVgQCKAdKK5StWS2xOBI4cPl7fs6yKvpJnSpZS/nJOhGTmeBKJ2cK5K2
 I5RPEMeR5DLhvbV2E7jXlJmbTe5wizKrlAJluCXSTPf1Gyt1ffQDLeMkD5XLlDBVlIzH
 Yj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297896; x=1779902696;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IJ4yH5acVGHfW9xD7pXc96FkCxZ4GQA3+/lqubaNPD8=;
 b=WGccmfF+MvF0Wv+nIC9voPAaQEDM0ZpXPOtENwmBIh0OLvS1zh62vD7q00lz7kmobx
 JhMjN1PmGpgxf7clixAUSx2kD/UCd6UIGLZOJQsE8JSZqutk4ABBwMg8A4CLDivISM5q
 YOZIuYs2tUCEHCa39WnmHs+kWKJJiu5ycrM4jLeb+iAZHbyPB8CL2vrsX3QdPJgGZV8m
 qOl9sz42EDQhLUIT6U0tuUv+0Wxk6GBGZlHSSm58XKOw0XcT99Dpk6JlxWOxKtdirsh/
 Uw4H/tCUjp8xe9B3vwqQmbPJ/rRnBgj1oOuNwdtvW6UO/r8UU+AiDeOv2T+8juR0KbCv
 jsoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bIVgjvKOKwA12oiZQfWCLMjVqoA8eRUf5n821++AgWeCYnriANi3Kk2OeVFql3DN4hKG+7WWHLOos@nongnu.org
X-Gm-Message-State: AOJu0YwjuPHfQU0useZG7ZZvht0zhuzlc8RildhWxkH9fZnbW6Uv5e8l
 J+bPDwjdJALDrWSGUBc9XPMbxonFyf7m4ia5ObxS8vgL8fYJWZmX+eyRPRuJx8STvnn1NxbbxCj
 FHUTY1/0=
X-Gm-Gg: Acq92OFqV3LNmQU3gu9vFTaUuaLa+sUWZpTjeL052Ztjjh4yOVcNcQXo9dvF+2ytmLC
 re65W5l/UpPDxueTItu28yh7sznLQakU5G0LYkGQd6nelj0w0mg5QtLHfCgS9Bdfo4Frj4zoEQs
 eSGwzNRNASToXG3RPCuZMosGOBqkheqpxycYobxaciwqn/ifIrVJOGmHz4rRmBzySgQcsEO311v
 ZvEUI9n35iK5AxbPbPxptfXhCWNjKKDLkKtXAvnj4s65GePhk1k9Qhh2pAPKmpwrklexNu7KQVN
 kJbXv4CkSMbcCXi+IoXtPOzZ9nnR2WKoc0qRRKGE6v2Op6x6wZqywArAdxmughAJaDxtdt6Vn5c
 4Vnhwnb3IMCIgwpsCwuwpRP3DbBzmMy1x7gKJH/3wFNzpvmTjWJ9XOQYcV8IzcYnp8wDC8oIsBW
 17lEj8Zttrwu276YPX0qAyP1dZ3eggcWd8dYiAS37M0sF71AA8rFbLuHCA+Kkh+ljLB3oL52VtG
 7IpVshuia+lKeY=
X-Received: by 2002:a05:6000:2383:b0:43f:dbbf:6d93 with SMTP id
 ffacd0b85a97d-45e5c5f2032mr40347362f8f.27.1779297896408; 
 Wed, 20 May 2026 10:24:56 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm56162412f8f.8.2026.05.20.10.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:24:55 -0700 (PDT)
Message-ID: <51a7560c-2c54-42ea-9351-fa56783a05d8@linaro.org>
Date: Wed, 20 May 2026 19:24:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/30] fpu: Simplify 0 +/- N case in parts_addsub
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260520171820.848839-1-richard.henderson@linaro.org>
 <20260520171820.848839-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520171820.848839-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 20/5/26 19:17, Richard Henderson wrote:
> Consolidate the tests for zero and anynorm.
> Add comments for a few cases.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(as in previous version)

