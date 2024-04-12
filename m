Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07612C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 22:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvPYi-0007pf-PL; Fri, 12 Apr 2024 18:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvPYf-0007pR-Ai
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 18:39:45 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvPYN-0008EO-Cd
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 18:39:29 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2a2f82ded89so856845a91.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712961565; x=1713566365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/z1FRpujluDYs5zX5Th7zZh41irmg+bo8RV6QA0k1BM=;
 b=uPBzLBDt+4enugmclau4EuQkj7igB8W5qQOVZqf/8QlrTnlUk5bOL3PCE77CKqE/x6
 Bv7ZUKcj6pzImejR9Z2cAYu4Ogkrc8kicejNqlt32MvXISk2PRXZyspICutKlsaSk7E3
 sMySYzLXdpm8fTq1K5SuqSiBzmnkQxLrkfCSNyb7wlGWq/Dzz4MRWaAgiVkaKh4xjSKE
 C74nTMpJEk9P3GGRXOVFmpkVPm6jqrERzsE7hHuq0T4teNN7tzsY1uRYdRPeiL1HN/hW
 DtqfTGfKMDLH1V9LJIbcSqRu9aHc2CAnkr51FqfTOFwycUIeI3XV2bzGLOE8TAIfQI5g
 nhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712961565; x=1713566365;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/z1FRpujluDYs5zX5Th7zZh41irmg+bo8RV6QA0k1BM=;
 b=FSQlH/tZf3craYetY+nX9GIdQFEG3WexEG+x7InNn9FOAh8Abr40TXCW+E63umF+CI
 UCl5mnYe5hUj31cGAaUxSA5fEWS+R3/IhT3xtlT+VwF8mYLFxstEoI57/gshPtShCRO9
 CsN5Hpa1axNxLmFZExNaMIEdVWXBrEcNXazc0ixYGdFfBojRCHBB0WDRddJEVdcgk3Uo
 xodNizFh6fqHTf7QstDxqRbYGwAVVx/kOUYUh3jVNo96MduzOgQE9MBYUaa5R45yXqzW
 wZBwG+cwIOLcMu3a5I2//MpznAWVqyhpREQZDi8XTeqUu9w0CBnTu9ycRKigbV4nVsK7
 MqdA==
X-Gm-Message-State: AOJu0YwxR4fWD7vaHbxvNVtzFpQbZc0XyZ8SGaDDlYShTJfdwq0+TLJQ
 9WcQdNYr+PVhYQU9A5mb9dSz9TMxKy6bjjdT1joBhnwONNIsa+ND0n+t6Cf04TRdqmXg/k9mIl7
 D
X-Google-Smtp-Source: AGHT+IGuTed+IwJKHguiZO/emM07KDgna7745IAGE3xRfhC1MfOcJZKdZRW1ssxekvc/KMOGUYqyFg==
X-Received: by 2002:a17:90b:46d0:b0:2a5:34a7:3430 with SMTP id
 jx16-20020a17090b46d000b002a534a73430mr4287059pjb.11.1712961564763; 
 Fri, 12 Apr 2024 15:39:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a17090aac1300b002a537abb536sm4765066pjq.57.2024.04.12.15.39.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 15:39:24 -0700 (PDT)
Message-ID: <05edd96c-1073-48ff-a51e-622d2aac46f2@linaro.org>
Date: Fri, 12 Apr 2024 15:39:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] target/sparc late fix
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240412185431.465942-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240412185431.465942-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 4/12/24 11:54, Richard Henderson wrote:
> Since this problem has 4 issues open, let's get it for 9.0.
> 
> 
> r~
> 
> 
> The following changes since commit be72d6ab361a26878752467a17289066dfd5bc28:

I've updated the tag to 2786a3f8d3a047cc21271380324c0b7d8217f238
to include M Bazz's tested-by tag.


r~

> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-04-12 16:01:04 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-sp-20240412
> 
> for you to fetch changes up to c84f5198b0b676ad67962b5250af1b0d0842e319:
> 
>    target/sparc: Use GET_ASI_CODE for ASI_KERNELTXT and ASI_USERTXT (2024-04-12 11:48:26 -0700)
> 
> ----------------------------------------------------------------
> target/sparc: Fix ASI_USERTXT for Solaris gdb crashes
> 
> ----------------------------------------------------------------
> Richard Henderson (1):
>        target/sparc: Use GET_ASI_CODE for ASI_KERNELTXT and ASI_USERTXT
> 
>   target/sparc/helper.h      |  3 +++
>   target/sparc/ldst_helper.c | 65 ++++++++++++++++++++++++++++++++--------------
>   target/sparc/translate.c   | 48 ++++++++++++++++++++++++++++++++--
>   3 files changed, 94 insertions(+), 22 deletions(-)


