Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428DFC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 12:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA7M4-0002Vh-5M; Thu, 23 May 2024 08:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA7M2-0002Ty-Ax
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:15:30 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA7M0-0004ry-Eg
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:15:29 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5708d8beec6so11885906a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 05:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716466526; x=1717071326; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xBwQJrjWjWv9hLuFM4+cx+lgLA27STR0by0u27d8BkE=;
 b=KM7jfi55bAVoaO6DCO4yYLdXwVhPmfpZdKrRY649zAltc7sLl7ZtW6aNKPPSDnRMnC
 4TsqqEAzlut307fInlpCD6+8UAzsOwgJQtvCID7e28DBWrCBXVeCQTRG2wCAtUN5x/WB
 X/EuzZEWBUDwn3zcAFegIMp49z9m+e4zfWV3EABaiFv4cR6DZPR8gyriHi+sLQdUFPFs
 s/HaD+1I30i94SILpC8yYAlE487Ca9LoFm1Bl0TA7cyfftlgBQYquKmolkASKibF3RPJ
 jBjslXAest98vwiuwTp1/pNSo72Sxg8XssEmJIMdF3+sRoI2MsPn9ZzEwM/tplZj6iLD
 WqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716466526; x=1717071326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xBwQJrjWjWv9hLuFM4+cx+lgLA27STR0by0u27d8BkE=;
 b=rP7BcrCqZPFtDyWTA1n0g+QIKB9rxkgBWT/XVwqnkYPIVdHHVdRYrylkz/pQBk2c1u
 qt7utQugnAeq5O9VXO4qFC6b9BrBb7VUZ/nok2Obk8cajOihsqTGKwai9zJgNKZ8k/co
 C1h3EvhqvctQSSKd9SvfIzVk+h+ZNL5ZGHSK3hphKuMwHW4qOIJXOEtqjVU2CwPkvPwd
 HO7aMblQNKhnAB1ETUXB+bT9gva+IGuoGB+6GHROpjGTYuz2vKoISrMYX6cxOa/k+BDs
 m9EqUNV0G6nxIAajFt9yLhuTbEbOALQ+yXghxDkPdZZDyRLlRWwwqqaQZmBkQ/iyl78m
 BHig==
X-Gm-Message-State: AOJu0Yxsm4oLrtbVk4dQ4yN4wHYDpGm8z+ZbDjh7BzqKuFQuiVbByyLJ
 a1VxpBlfvQ3q7eiu/YOe+10b1/LgLyUIuSTBXA71WGoJJZmKn+iE6UYYbKQaEskrXIpAHqSroff
 cW6A474FiIOs1VBGbE/OPamUhx3Y3Kp9PWfof0SNbskAOcSua
X-Google-Smtp-Source: AGHT+IEtT/8FWavX8tGz6vq59UX4+wdnTt65gRfekFPPloMrs+Dz2u/IMHYYdn0QpndlZHWshoxmCZCEyafpg8XR17s=
X-Received: by 2002:a50:d48e:0:b0:578:4cb1:ff5d with SMTP id
 4fb4d7f45d1cf-5784cb1ff91mr186105a12.10.1716466526451; Thu, 23 May 2024
 05:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-19-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 13:15:15 +0100
Message-ID: <CAFEAcA86Tx1QoibFe=5j2EbxEm1yKRFdCCa6G+M9e3G9u-VM9A@mail.gmail.com>
Subject: Re: [PATCH 18/57] target/arm: Convert FCMEQ, FCMGE, FCMGT, FACGE,
 FACGT to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 6 May 2024 at 02:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |   5 +
>  target/arm/tcg/a64.decode      |  30 ++++++
>  target/arm/tcg/translate-a64.c | 188 +++++++++++++++++++--------------
>  target/arm/tcg/vec_helper.c    |  30 ++++++
>  4 files changed, 174 insertions(+), 79 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

