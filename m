Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2440CEF06FB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 00:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpFYK-0002VR-SU; Sun, 08 Feb 2026 19:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpFYG-0002Uv-Gx
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 19:54:56 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpFYE-00014A-MC
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 19:54:56 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-354b79a9ad5so1065399a91.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 16:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770598492; x=1771203292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UikTqaRB1pLI6bxabYQDTfQzVSlB0r3b/OnYfZgTZt8=;
 b=Mi3YLbacaKX4qZRC6tCC3Xhk3YJwqbziaecqQ8sSyPRiP36sxkVMq3VIPifMAyZzUz
 A9CwcG1ufHj6odvEBDx4tXFw48Q/jeZ5rZOpkhyCXB1orzUBTIRZIbtq1IBS0+xfVwgh
 LMePrcbsP6V8V3p/kGOo+Et5Timads5ULstEuEJVeWuUCZydn1qaUgirO3zhQxO3HpyQ
 umJyVDhGWsEhHYk/8/x23q5cZwq9YPHEPHCdAM8mYi/+ulcf64jX/oPAi3F0FFaSoAhH
 ElnbORLWg96CWWbAt9gOJsy5NRRcAG9QlwwhtybHnFBXJ2rkYN/dxaPy9L32AfXa922A
 nUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770598492; x=1771203292;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UikTqaRB1pLI6bxabYQDTfQzVSlB0r3b/OnYfZgTZt8=;
 b=s+qXw7jci5ewoxr4IP9NNiHIgzFKgOu3Sv1NFlBPdsE44B2RRQAV2VIQXJeQ+L3Dof
 xsiJEy6txTv11J+OmAx7EN+0fmTa1WKTbTDxaa8h6Ya/EzST/W7eC2SBZ5uyiZSjAxcj
 0Ncn6kEwL0ul4UU1Yu5vtlFiVoqtuLlebF/1OmoOtbu2BX/ktSo+OR99ypYrzdJ7PaWV
 QRUwfsRCPL6Q3UJddU5vHz9moAqh20t1orBUQF0DEhCRPIEoU34RcOYjY2hc3KwenCVy
 5lCjuAx1SGnWRze7omBxqzlS5fsuRjTSts/Mtarr9HL7+fE5VaFUg9kKkKYcVjjcRHKy
 hecQ==
X-Gm-Message-State: AOJu0Yz1ziENTfy6XMWULjoSy7mj1TkEF/2x1ylhm31xO/Wv1VaG74P3
 F13nnO4G5qDEOPwlkzKE/lUE4wl3WKeLqXlCnI3/FjAXiR9EVoXMOzkEboOcjvs1Rxc827doXUG
 4N7qjsU0=
X-Gm-Gg: AZuq6aI4a+iPQ6O/vuzTZ9G3c94/m/ewRgRmZvsdGzdj+XUPhi7rV3VzfzvN7+/AZvT
 jqII9cn04RvMdrGtBCp3paHtcG3tt8yGQstB9F09NfkUFT3KxWfaJ9HpVKUsJUP2eQOPMqU0i+x
 5MnX0N+tEdl5k9BSaFqZ49lW3tf50e7jMNZs4ABN8Fmp57NTx3ySbfZKOaROurS46jDIQft6poU
 G7CKcMDNHUM1N3b2DI39mWcbaBIMH/UWPijS5KPQN4lu9xcBNB2Ti18cNe5zDWuhGgcIyMgiQ8R
 h0Ys2rG6mmMZolxLSf0mOtwvrixuK3e6ryMgJf95iiP7clcY1fsxrJciCY7tHa9LK6fynX5+Ax3
 Z9XYT0q0xetKagbUKKc7kUvDghCP5A7kEOeXds3iAUwEj6SnkD60nw0hz/tAvHG+5fXdGPpY8kf
 Js0+hbY5wpbETbN5oVS0BD/UTryB3mtW3Q1m1rqZkw9QyhFRHgp9ECghzk9lsu/zk=
X-Received: by 2002:a17:90a:dfc7:b0:32e:1b1c:f8b8 with SMTP id
 98e67ed59e1d1-354b3e456fbmr8102266a91.26.1770598491486; 
 Sun, 08 Feb 2026 16:54:51 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b1e3d056sm8711893a91.3.2026.02.08.16.54.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 16:54:50 -0800 (PST)
Message-ID: <ec2e2ab7-dee0-49cc-a9e5-96b9dedd71ba@linaro.org>
Date: Mon, 9 Feb 2026 10:54:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/24] bsd-user: Add target_semid_ds and
 target_msqid_ds structures
To: qemu-devel@nongnu.org
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-3-58e5fcfdb84f@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260208-bsd-user-claude-v2-3-58e5fcfdb84f@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 2/9/26 05:26, Warner Losh wrote:
> Add the target ABI definitions for System V semaphore and message queue
> data structures, needed for semctl() and msgctl() syscall emulation.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Mikael Urankar<mikael.urankar@gmail.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/syscall_defs.h | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


