Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8913CD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0Mg-0006vd-Si; Mon, 18 May 2026 11:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0MY-0006se-V9
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:58:41 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP0MV-0003lH-Sm
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:58:37 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso15987455ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779119914; x=1779724714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sKTeYk193SgxNNV8ckkY4BhEF8kSKHrtKeZ1cCPBvYw=;
 b=Do/dP7KpYdsDzpyMqF8Ljquyfz3pv3yDcVms9PVxkFHBCnHmFK3uyMEC6oh9LInnln
 VC2VOlPicN+TDYWH+zETkrKZ3aE7KhS9xtGlmj8rlro2wPArcMg3ZAd5akJiTJUU/Glh
 C+mjgmJ18UkLZWiktgohEnSTbLVJBsI7fire6ot1hqgu0o70ebkpSSmeqJr8jIZS44aM
 /aU5yFw+2hA36AWAwlHu6JhX9t40dMMt5rSmLk5n26fKDNEQuBNh04cwYxeFV7MZiYV9
 JChD2DkGkZEABenCdPO1QzIiZIDE5BFUnSnY1vR3G44wIxD0/qfCS8YFQ52QF9LAYt85
 paMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779119914; x=1779724714;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sKTeYk193SgxNNV8ckkY4BhEF8kSKHrtKeZ1cCPBvYw=;
 b=L/jR87oGJcPAeFWjFYGJUxNnwpxqmwyTJardunApJfHf2Tob9VEgHJoxxoFLT1JQo5
 DBNTzBZk1iR/XZlSeC0NHjHNrFoHjqX/wFCZi7Yq0y4wjyHkZmKXyk+r2/pgfyxqitUu
 ReHm0uHLE0JzZR8qWPRWCOva+ut9UJh5JTNHxC1UpDXbtGjxykMy1EHYA51EmyvXSxsB
 kLh/iVlUkVllqupeu0W0s4SnJHgvjcLYMJQdmP6pdStCWJmifY0Nx0+r3oZXynMaE1h5
 yI4y0/q6NEfyJJcZ408Gj1bpvwdAVe9vRddRAZpaE5CZu7AX1eqbW3QQLvLMAaJpfYgt
 NbuA==
X-Gm-Message-State: AOJu0YwxRVIerhUR9VU1s+2N2JHCgAio1H2gxaEuYw1a5Ziw16SmOROU
 3QIH2ZTZLG8FZ/jWcoore+f43ZSPAsJAQSsCdPppni0EWnNkPomdVccxT3m7jjWur8h6uRZ1hfq
 hkvwKdzk=
X-Gm-Gg: Acq92OGdDGwB/ffiUbBIJGzcXyomGMXca9PKEX+d6K3tVVkR1ttTb5Cynxx/hSpnuQq
 cQFrroOKPcfUghkPmW7Lf7hRJmMkSqAhj2M31+CP0QqyPmAUQiABoaPz66VChziWxze3vGZHgvb
 0+GSuil3SY2YZ/mEUWnDQCCKM4f9ERqH6MZF1TDP0/b3kvGamrb0Xl/I/7MViOc5Niqsh7oee4w
 97AxTBBD6ZQDil1/9MFN0PwKcVH3omuFADbVCNRM53A6z7HfC4hnjCLWmH2L9JWlSRenAE4uKh7
 EOlmLE0vsuxbMTVEAxUyN5RbX5uvcaCuuDj5yarTDEaeDQGhKqQ5v4jEG2wFQ1X15jUZvX0hgAu
 zhKT+Hmat3iNfqJVL+LkTjFvltC5dNdRla9OdA8EVq/pwE7u7ERGjRPLXDS7+8J1KkG/+sHkw5P
 mS2F3dMiCatKHvaR3PeExFc3IMDgpT8oWZDi4n
X-Received: by 2002:a17:902:9a94:b0:2b4:65f6:e24a with SMTP id
 d9443c01a7336-2bd7e7849a3mr106664425ad.4.1779119914384; 
 Mon, 18 May 2026 08:58:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd791e0b06sm131397685ad.22.2026.05.18.08.58.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:58:33 -0700 (PDT)
Message-ID: <6f91f1dd-645e-4726-af36-6da7c1a1df64@linaro.org>
Date: Mon, 18 May 2026 08:58:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/14] target/arm/ptw: Flip sense of
 get_phys_addr_for_at return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 5/15/26 07:25, Peter Maydell wrote:
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/internals.h     |  2 ++
>   target/arm/ptw.c           |  2 +-
>   target/arm/tcg/cpregs-at.c | 12 ++++++------
>   3 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

