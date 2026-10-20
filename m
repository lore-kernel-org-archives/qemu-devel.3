Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B10606A331
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m8QAyI0Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCLG-0002JX-Ks; Tue, 20 Oct 2026 12:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJCL8-0002HW-OM
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:05:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJCL3-0001pf-5a
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:05:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso29207845e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 09:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792512318; x=1793117118; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ZdS8EphSrx8dVHC6vQmdC21x8xN0ng7aiaD8/TqalI=;
 b=m8QAyI0QB7Cy3a5eOtQC5n9GcasmbhRMv0kK3POQlRlTSNNjcYfTxERtJHSnKW06ay
 XkfJaWxM82WWA59W6Zoi143PLorJJu0ac9kj8rMDlIUBfZaVAi1rJxHYJBXKj6sXKUJc
 019sb7RBgy+t3qnY6+cm/jSLYrbPcWXXCQ5whdRNlXeFj9xxsoo7ZEfOSmrFF25iqWIt
 XfvYnkRnprUUAlAa4jD54a24lgWMWoedDFvVwAz9oZMJvi9ncJoxUKnz65+f+V9b3AYT
 hb6ssllPbpQfrd6BNj9XRBYbEUtT7KRMStR7AaPafqa0xTSRfLxtYSM8z3KGLTrvfqSe
 bYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792512318; x=1793117118;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ZdS8EphSrx8dVHC6vQmdC21x8xN0ng7aiaD8/TqalI=;
 b=LixqdaWRyhns62+vLnRDGqMayf1YH5j9MhlUd9zoNUB6RRQHn/2Wh9ierC4pptczLU
 muwjtEble0qI06LZtJG/IgDs1XRg5d03DftykgPKLhuf5dLoTh1taBnvJyfUtSav6BWm
 NFm3iMcve5Ww+xl2T3CDLqSvaKR6mxlGEFC8PG4KiGP7t4I0Pt6EzwgTUf2Nb7tiqzhx
 Qt4zfVaN/13dp/+nRNBzG0mTP1fcslVIhOC11l9wt4v5Lkw/DEcpEMM3Ysj1pHKjU/dV
 h2+ZKpSIoDawF4K4TyFyaH1RKju98JdcFyGM4kCuQR1Z48AOa+aZlSUMoqBlM/xZrr0e
 AL2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXSZrQdvRzTcvIQp68ky6zFL/hKOIpEmchRKPtzU7tmlyivnlfOmPfeyJ0xSklxGlX0zz0BcJ4wTA7@nongnu.org
X-Gm-Message-State: AFq9FYJlpv/ORGxHoVIZpdicyDB7Hfbwhw6U+0XzokLi0EIYGwNsyiRj
 YNy+eFeUe8Hf2zZFr5fOkp2tI3EoR+jCrYUEnhGsjMr28GpkYX8YXRhcXYYVjEecRf4=
X-Gm-Gg: AYBFou3ddXosx+EGEaxrQlep3jjxM8vgu1hQzUc60agOvFEzk6u2T7Iuozam2l8YYiG
 pDB6il6y3Kt9mfLgX2ATaX8BINOnbrgkQUEcNkOJTMvAe6gyDGq6ILDq6pOqPC87HGtyDoRedzA
 d8hK/xfGPHiwdu1aPP1oI/bRZb+g/uwyku5INJI2lyg7jclKFepddRAQYjgSNJJnItrY7TU6Ons
 QqXeguQqMJYw5hwiTipCEIvBg4iutKSJHqhIw3ty2Fd7cu9FgWEJwfUYmlItMLuA53/lkC60xv5
 hwgcvSOXktV0L9fEGZvYP/lgAez1CONt94QffjtrKNVstB3S3zBfxp8YcAq43I1ZKFicYsrftQF
 4bokfqggjaaS2yzIDX/0bEYZPyoj7Bbb3+q3aQ9nxpQw/amNM1Lu+MMccojZ7RLhG2Fs8XVwcD1
 zvJ+BpGVF2GSJxUM0xPTBq4sQk8lvnjJWKvQl/+ZO1xUrRYa8FyqGAYYjmvQ/VUqsDV+eUeXhOo
 0JyygCg6pkm7zmJMFW6DoGcFkFxjtQKaBXZFc+mT/g7sqZhXrA/9w==
X-Received: by 2002:a05:600c:4f95:b0:4a1:706f:b40d with SMTP id
 5b1f17b1804b1-4a1d75e6f9bmr253215815e9.7.1792512317157; 
 Tue, 20 Oct 2026 09:05:17 -0700 (PDT)
Received: from [192.168.2.121] (p5b3b6184.dip0.t-ipconnect.de. [91.59.97.132])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fb845dc2sm6022795e9.8.2026.10.20.09.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 09:05:16 -0700 (PDT)
Message-ID: <dfa27a2d-fcc1-4a54-bf0b-f338cead756c@linaro.org>
Date: Tue, 20 Oct 2026 18:05:14 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/alpha: Convert to translate_for_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
 <20261020122752.3651914-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261020122752.3651914-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 14:27, Peter Maydell wrote:
> Convert alpha to providing the translate_for_debug method rather than
> the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/alpha/cpu.h    |  3 ++-
>   target/alpha/cpu.c    |  2 +-
>   target/alpha/helper.c | 15 +++++++++++++--
>   3 files changed, 16 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

