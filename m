Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5197E6781B
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 09:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7XJs-0002cd-4F; Sun, 03 Nov 2024 04:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7XJp-0002bs-If
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 04:54:50 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7XJm-0001hy-7v
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 04:54:49 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fb561f273eso25307801fa.2
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2024 01:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730627684; x=1731232484; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eK1ACBQdcVq11/sNE0g5q33esKHBWkQCzFbqxdrPPHs=;
 b=OChaQh0Gy/9vb/kvttofSoEa5a/rYUj+gqmPF+46E7PNkx8H27tnvKMNPbFBmqvFQ9
 STypYkR8MZPTivZ6Hr1yvZXHne/ZUO6Z4FsWrLU4DYR2mA0k9k4PaNeAB0FcpwvGylgO
 1VJ5FYaMpJ6XV2J1aOaqI+5n9zxTjHalNLP3eH8BP2fgv26M8vfvxwA+2esAJSKu8OjO
 4GBIwfYzXRctgD4LYcPoi9O0sWRfROAKaxIRp7fikBXvUKM3eZUXmWlYDib4eTUiGnEt
 0puzY6a1z0awNXOLgvTZP9oIAh17ZWW3DJEKC4y0eVv4hUA2QE79TQ2lFXxYnBkk4ua8
 PCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730627684; x=1731232484;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eK1ACBQdcVq11/sNE0g5q33esKHBWkQCzFbqxdrPPHs=;
 b=nhMMR9CE4AgzFNPYe6ZEsTO3qm3VwiEV6tfxyBfIUnrgEMXlRKKERU79R6g8gBh04r
 F6PlddHhbX75MEi+LlYG85WMgCE9n8gEBte93h0DFCTWr2kZgneH6VQ0lQXa+23SXwCn
 9M+ENnej5Fwufo87ASZgRUCxU88GFpvRgMDRsfEp6xklVq0MynsGQ2RTBA5AMuU4XHSA
 jqrt4owOdMvUDNYoUlhxVCddWDS5IwbV8rVHhBU3aVdfcKW4eAkv73Q2yyBqyOopBww7
 Ivw6MRYmbM5UgBguWNfdW7YzBSMf1zHXxl/WyDGQwsiAuc4QqiAqMtEDuash4bdGZQ4Y
 vQ6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHqxT2TFHPdBnayjdsXi5UHAme0Az7KRo7IsQzoa2kU/v3aN/5kIVVsycwjTHUJvhxvF9Wk/EZt8QK@nongnu.org
X-Gm-Message-State: AOJu0YxTcHsSo6/wLPw2ui3EYtgfyzrz+GZE143LQM6lRFHuwE2nzquJ
 pQLhqEBc7jj851JX0NJvI1WS0/xOMJwtncoU3ge5CYyTdXT+04ilfJGSRR3rAkk=
X-Google-Smtp-Source: AGHT+IG7pMezLXsiQfcFT+ZGiuUdY0/lqeT4KIz5/wIFo4ItTtf8fJXhlVWtTmRQj0rKIjgHigT/6w==
X-Received: by 2002:a2e:a98e:0:b0:2fa:d4c1:3b6b with SMTP id
 38308e7fff4ca-2fd059d2d1fmr88755631fa.33.1730627683986; 
 Sun, 03 Nov 2024 01:54:43 -0800 (PST)
Received: from [192.168.21.227] ([91.209.212.64])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fdef8a62c0sm12501271fa.75.2024.11.03.01.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Nov 2024 01:54:42 -0800 (PST)
Message-ID: <cc3fe99c-11c9-4130-8559-e95b00688b2a@linaro.org>
Date: Sun, 3 Nov 2024 09:54:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix SVE SDOT/UDOT/USDOT (4-way, indexed)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20241101185544.2130972-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241101185544.2130972-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x236.google.com
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

On 11/1/24 18:55, Peter Maydell wrote:
> Our implementation of the indexed version of SVE SDOT/UDOT/USDOT got
> the calculation of the inner loop terminator wrong.  Although we
> correctly account for the element size when we calculate the
> terminator for the first iteration:
>     intptr_t segend = MIN(16 / sizeof(TYPED), opr_sz_n);
> we don't do that when we move it forward after the first inner loop
> completes.  The intention is that we process the vector in 128-bit
> segments, which for a 64-bit element size should mean (1, 2), (3, 4),
> (5, 6), etc.  This bug meant that we would iterate (1, 2), (3, 4, 5,
> 6), (7, 8, 9, 10) etc and apply the wrong indexed element to some of
> the operations, and also index off the end of the vector.
> 
> You don't see this bug if the vector length is small enough that we
> don't need to iterate the outer loop, i.e.  if it is only 128 bits,
> or if it is the 64-bit special case from AA32/AA64 AdvSIMD.  If the
> vector length is 256 bits then we calculate the right results for the
> elements in the vector but do index off the end of the vector. Vector
> lengths greater than 256 bits see wrong answers. The instructions
> that produce 32-bit results behave correctly.
> 
> Fix the recalculation of 'segend' for subsequent iterations, and
> restore a version of the comment that was lost in the refactor of
> commit 7020ffd656a5 that explains why we only need to clamp segend to
> opr_sz_n for the first iteration, not the later ones.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2595
> Fixes: 7020ffd656a5 ("target/arm: Macroize helper_gvec_{s,u}dot_idx_{b,h}")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/vec_helper.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

D'oh.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

