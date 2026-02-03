Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283A2E83050
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 04:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn8M0-0004x0-OH; Mon, 02 Feb 2026 23:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn8Ly-0004wX-HV
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 23:49:30 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn8Lx-0005wF-0Q
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 23:49:30 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-81f39438187so3006685b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 20:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770094166; x=1770698966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9CZewBfPZDHsRuB0GvHA16vQhGlAwRyocwa+kFE71jg=;
 b=VWAYxSk3w8XuJdSeCF/xL1M+JPBVXdV2vo6BgN8+YjvCRwhl6DpY6d1LRDxrB+9UTF
 NHJAsLjIE832fEiEDOKdVOonwoqvU5CovY3pSOVNtLD6Sc/OTKmXlI9SqNW4H8xiXFjR
 bTJprax/HJEFF0jGGfqC7ZmKMUKbtBaHaqJwfKJtJQWRXxGBEBjiW3PC9s6aE75qMl3e
 djLJwomUBE/G4MkHeKdNmQNLGw+5CoUJEMfvB/A2oGZLRWirO3pcotBhrUfyjjcH3dhU
 3gh13bcpzYMNKBFZ6DXEORPTCdT49aMX2wudbEBwM/cB+XABpu9JS904Hp0oD9HfZ/5Z
 W6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770094166; x=1770698966;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9CZewBfPZDHsRuB0GvHA16vQhGlAwRyocwa+kFE71jg=;
 b=Uaej91qQtIjL8re3qi1nzoQAx6B61G79Raf4YukfTtm+7YwkMVKw2Mi1oSJNvHfRz2
 fT9JY4ynV/AsFLNtls9HN8nxJdGMZlTRnOOg7NHa1xDRrHL9HTaKytQBhzuNMdrpX7VS
 QkXjIP2pvXqXQAzM21/g+w/f8KyizYNpkWkT3IztjYoUVNAc78zny1/OrqWb/Syr6A9F
 rbb687703F3paht4gwfvHdKKeVY9NOeUz57Q6hGFZos2pRT+yIMmVPR51oEJz+wOFCYD
 IwfO/5NMytqEELa63uMzCXWpoeGf+uypE9TYqJotCOyML8+1NXn9tJpKYcXgF+yQIMLL
 hpoA==
X-Gm-Message-State: AOJu0YxVIeTJKgiGxcjn3DFmjJGClk7lgxuzrEVe1l5MVdgFrkA5qYAT
 VSPKCXGLTGpmdoM+e44b1o6gvNLGNQ0nVRO3yKWWZHVJv0MPwBOPyH+TOE0Y8w5ZsRDVTUfnsmB
 jalcROkbSag==
X-Gm-Gg: AZuq6aIbhVOAxbp9lIfbvhEgdSSdiLIjI6VGaRNjD+cjaPK6v4VrjeFIt4w8U/zHp3u
 0dz/rPigKdjNey2OE0A2ZuEnXnpsv30paGrIWTZdQWlxrQR3iDRa2NTRAjtBSn8Y7EH2EQpUEXG
 ETlUted4ppcd0nQLPawzMujPE7BGzGnm/r5M0xueo4Jp7bSy345LreJM5cmndudN+H15Zpob4lE
 D7ZG3zqul41xZmhb12IWX7PiZzGyevH3SlHwcoLDbG++2BU8NDpZNt+W2ZDwOSTS05Y3T0FvsX9
 sviybGHHpQIE4p/zSfsRBIMn0SNJmrW5LcpueXhkKlvsGyOLMUJWowVqYUm7hpY34aGbA73J55w
 1BGx+1HnlXtKskVNrvKO4rDkzJlq0P/oD8NBZgdtpxIx0Isn9SLLdgB4CBMpgzeR3lC1JGScgNH
 E2z1j5Dbozc3aFE9PzIEAH62L8LtPSYG10LmRMRMZtgzaKy3YEVGts6TkeWregW1Cg0js6MLDNA
 8HA1++sbsJjGKRCyi8Z5t/Y0OaRbzgx7wb8a6+UxQ==
X-Received: by 2002:a05:6a00:1816:b0:81f:33a6:e9cd with SMTP id
 d2e1a72fcca58-823ab74d061mr13284309b3a.57.1770094166033; 
 Mon, 02 Feb 2026 20:49:26 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c54d4dsm20219251b3a.67.2026.02.02.20.49.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 20:49:25 -0800 (PST)
Message-ID: <8a59ac40-1ef5-47ca-840d-d0b19c4907e9@linaro.org>
Date: Tue, 3 Feb 2026 14:49:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tcg: Lower deposit/extract2 during optimize
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20260119000740.50516-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260119000740.50516-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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

Ping.

On 1/19/26 10:07, Richard Henderson wrote:
> The idea is that we can do a better job of lowering once
> we have a firm idea of which operands overlap, which are
> constants, and the like.
> 
> The first version of this was almost 2 years ago:
> 
> https://lore.kernel.org/qemu-devel/20240312143839.136408-16-richard.henderson@linaro.org/
> 
> This version is fairly simplified by not having to handle
> TCG_TARGET_REG_BITS == 32 anymore.  Some of Paolo's patches
> to choose and vs shift could be incorporated here, but during
> optimize instead of initial code generation.
> 
> 
> r~
> 
> 
> Richard Henderson (3):
>    tcg/optimize: Lower unsupported deposit during optimize
>    tcg/optimize: Lower unsupported extract2 during optimize
>    tcg: Expand missing rotri with extract2
> 
>   tcg/optimize.c | 257 ++++++++++++++++++++++++++++++++++++++++++++-----
>   tcg/tcg-op.c   | 174 ++++++---------------------------
>   2 files changed, 262 insertions(+), 169 deletions(-)
> 


