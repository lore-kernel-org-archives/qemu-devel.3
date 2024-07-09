Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DA4C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBj3-0000t0-Qi; Tue, 09 Jul 2024 10:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRBj2-0000o7-Oc
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:21:48 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRBj1-0001p0-Cc
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:21:48 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58c2e5e8649so9215158a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720534905; x=1721139705; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6D/9RMjKtvoqhRxf33uzC2d8AED/S/Pv/V6JQ++ckuw=;
 b=xfa113FfJEi96Scj6DlumDRc+YW8n22z05f2abLCMemTQU5OTKbmEXa2xj4QZVjlRW
 Au11kjje/p5SZIje3e0DFTkJMa31GAo43bVVTViP75uPV2CfKAaTEhixXdYjbInC85Lh
 pomFVmx7Efmm3+YeIsk2tAfabhk09f+Hpy7TvqZZ7UDvLon+Iofm24rDj2RE08e//AvT
 77h+N0GYKxNDUfo0V+4iKmIAryb4iUCgXVABcvmzHcQQWBsh4/JrZaaltz5vOTVl7Rge
 DSKy9p9Uk45K8eMguHhnJjl943wLJ09K05SgAlW9v2iRTA+wJMigjxtci4L9ZAcJqioC
 likA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720534905; x=1721139705;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6D/9RMjKtvoqhRxf33uzC2d8AED/S/Pv/V6JQ++ckuw=;
 b=X3wt7LvlnGXH3R9n1zOjOHtS1z9/hSD+PjRNr/bFx+dSLvYghflLkl1oFQkfaAmymy
 RZOxQA2T1mjLhtsn4K+OpFC5LP3mYcQqLDx0Pu6USY3lbKViIAABGPc9YJ6bjSf/wotQ
 gvoPib09NXm++LHdzlq99fMZjO2bH3l5qx7RZBe3qlh62WzWxqqzzdzmZtlf9RTmOU5o
 8dNB9K8lPZGzmyNrlhPf2iuAnqL5O4ybDs+vFJu82CszwffUivGRWATGTg6fBdjLxM0w
 9ZblfNfbtMh/3qA0cZyO4Sxh1ki36vWs7LOpoOyAj0f+siQvop2/oDeMv4fGGVtE3xq9
 YseQ==
X-Gm-Message-State: AOJu0YyDMBVbASS7+nGApNsIaZK9Zg4HkEmqQlRpaahGAmtGYP2Yem0G
 UBYPTjMu8R4xtQuuTlD9id56F6qShHyKAqRH9CIgvTbFYAEe5BOZ2NNFBYqP07dVJYaN/dtqOjw
 po2xb1gAF6uwtGeCFrlMqQtFIr6+v8YwhoDMYPwcb33mnLSu1
X-Google-Smtp-Source: AGHT+IET+rwFPsAGbAE91U5vbWjXJQYXKhjhBYgNiC+ZrDCIccVdJQWQHMlvCAIeEsTZkHk1vpuczZdHdgEV/Ux5uIY=
X-Received: by 2002:aa7:c315:0:b0:57d:1d9e:d1fe with SMTP id
 4fb4d7f45d1cf-594dcf70159mr2010506a12.9.1720534905463; Tue, 09 Jul 2024
 07:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240709000610.382391-1-richard.henderson@linaro.org>
 <20240709000610.382391-5-richard.henderson@linaro.org>
In-Reply-To: <20240709000610.382391-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2024 15:21:34 +0100
Message-ID: <CAFEAcA__vKaph1S+jWGYj_JyR_NPGzxuR2muVMAv2jY3XE7EOQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] target/arm: Convert SADDW, SSUBW, UADDW,
 USUBW to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 9 Jul 2024 at 01:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 86 +++++++++++++++++-----------------
>  target/arm/tcg/a64.decode      |  5 ++
>  2 files changed, 48 insertions(+), 43 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

