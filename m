Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734ECCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkfP-0005Rj-6A; Wed, 20 May 2026 13:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkf6-0005Nm-3k
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkez-0003q5-Mk
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:47 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45e8a834cc2so1890511f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297884; x=1779902684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EANHwnYYHEcI+VH4RFyz2Hu1fN96LzD1GzWYAjg5pqw=;
 b=V4p0oPrVHtzSefaJQuQko4oLeKzvh0Nn4hx0EbKNC8x6SDtLubckbPp+LXd1qxF5J8
 EwuXkhuMOA2w+iRsjx0CtBI/pDt+1cK7GaJK+Etknb2Cd0O8iztZmMb9K6yQKMcaqWw/
 hF6mpPcw+XmAN3dKnS6es1pApySgH4TbfLud+Lnu84+MzwShzlTd4dUoffH52z5NOdGV
 VU418t6ord2SoJTWZZp7XV2XuibqW+ecL2t2T+Tz2SNxwtvi3K8NY1TSYB2a3Jn+Jn8Y
 xm11MzBMrjzFlt9SNydSiUthHRcD1La/IJZR/YFf8i+1tsIIP72/Rx9kJtvpagWdWoLT
 fHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297884; x=1779902684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EANHwnYYHEcI+VH4RFyz2Hu1fN96LzD1GzWYAjg5pqw=;
 b=MWM1IHT14NcSqPM8Y+Niy6vkQXqHxy8Su5sgbY7Eqf+EwAlmnKJvJpZPDlrMeLx1PZ
 3FZp9aZL2o4S1Tf3MXGcaIk7k7xT29VhXaLJsfUzHpwwfrg3dS8JERHCXp7lXXb/yM6r
 Uv6ljt2t3mKdhRpQhvcJhSddjmTM8cOhFJX/iDH5NxJQ3xn5WWMnNcDTdgKfmdzCr5qE
 8XlqKoD4ZseiTPU83xJMUlhrxFaOay6TciDosA2/4Ynlg02lnzDAh7ucN0mYr7jvhWQO
 SuOzGLdsAUueph+24XJcGeRUEyJlyqDIrGvVPip1NuoWUVz4kL+1Loz9MAmoPatn16O1
 a66w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+L0W2Vl6gwqw6WckLgFdxhusT0gS/CUpYIvNTgbiWpbQre3U6dvIH3wMPfhJEoSk9KmEv+ZVVBDpie@nongnu.org
X-Gm-Message-State: AOJu0YwJ/TmYIE0AtjSmr0yGKJE0VGCLshXU0qIFNb6v1WExIcsH80Uv
 pJSBv8GBsus+Xf+5REEdkRG88uFhJl1rEEVAOcWlJQghfkbD4GVhBvAEtVO9iRXqv+k=
X-Gm-Gg: Acq92OFFcT+rCVIeW+FhOjmm50Nsjw8eqc51oafrG1CFjjj36T87YeXov3mrcKLpDuL
 L+2O8el2DCGp5qYs4aEXg70TCWaWqeYzAusB9cYQOiOidpfXEl+9ZFEVPmPOR1Ar9dxuPmF/Qna
 bhkj5WuhXOalAX2txIZVXA+Od6UG9eB3Nge3InaPSjLojEmWRvAM/4i87DakXoHRludnjda81fA
 wWBeBn9KogBCccepdYVxDKjiZU1hmdkeYO10R7Vj+T6IOK2DPAlx4ANc4SjmRs+1TWPjLRh5zbD
 LYBu/Dk89K1pJzRV/4JgPHXArK1RLvPIGfb02RU6y2CbqELuZaslRJd3uf1qIWS7xi1rbjGe5cb
 Ek6F7GjyKfPqVMNJj7AIMEWzuZ+ASQL9okljuoylKoW00DFmGHXO9vtvr7n8XEBX5Kb049y+3zt
 oRJXi+fkqZ1f7AqZESFzoPExsRJWjdC/QrrKn5hj1hT0KNoSG1ELUpxX/nO1TBbPqy4fKGvtQbZ
 tZB
X-Received: by 2002:a5d:5f53:0:b0:43d:73de:abd2 with SMTP id
 ffacd0b85a97d-45e5c58728cmr41517642f8f.26.1779297883919; 
 Wed, 20 May 2026 10:24:43 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a6454sm56789395f8f.34.2026.05.20.10.24.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:24:42 -0700 (PDT)
Message-ID: <3ccb29a3-1a70-4d27-a28f-330e6a60d3b3@linaro.org>
Date: Wed, 20 May 2026 19:24:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/30] fpu: Use parts64_round_to_int in
 parts_s390_divide_to_integer
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260520171820.848839-1-richard.henderson@linaro.org>
 <20260520171820.848839-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520171820.848839-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
> We will not expose parts_round_to_int_normal.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(as in previous version)

