Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBCEC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIU-0007dv-Nr; Thu, 28 Aug 2025 13:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdRc-0008Ky-UU
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:17:41 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdRZ-0005Yc-3Y
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:17:39 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-71d71bcab6fso8412237b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756390653; x=1756995453; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MIEBzxAzyaO6k5cbyPaYdXQPtBxMUU8DPaw2lTxgUK4=;
 b=LdcwuQ4K58/fJwkHYGVauo9MF5zmGptLJFUfKgN8EvPqNH745+jUGF1HIpHr1XzEkx
 F4soG7gn3vaQ/OAz4Jv3FtufUpyJHPC3hpStdoW4lqkJ775/uPFzpTZ5wzOOeuAXxNq9
 F4Ey0QEn2LgaFECvC3sE9s7D/L3v8TNQLWPzhedCzbnNbD3aPPkT+PxQ/SdzHtppLBS4
 ZrzK10VrSdA3McYAey1RouoZ38W5iz6pCDB367fUtVzCkeCeeC2gtmBZsRIDAYRetJEJ
 kdFm9vhnM59I1Nx+QItcdtyyugE6ypJQuv2arVc+OXY5lYRW459ZQ+1hKpD0jpUbwTOS
 2+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756390653; x=1756995453;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MIEBzxAzyaO6k5cbyPaYdXQPtBxMUU8DPaw2lTxgUK4=;
 b=qfB4GNa5kOvIp1xm95bir3y377tPX9JeIMYL/+fPO21VwmlZ7OghzqI9D8A/x4s2tq
 HLvJc83OksryI4ITz6X9n+QaQ2FEko2hTaRl89mQikqlE6KxPylgHJWtkf0lgB7cK+7O
 US8V3CujqCbV6xHlb29ckxkKBsxFFB5pO/S3nGQHjNn6xMpd4VH9wSuBQFXMQeSbydUY
 i8DxL6XhtgvzGjp0zoh/mf6l31oDdmqoyMmWkBPJHBHzYw05MMlygRtrhKJEHCru+gYQ
 h3dQDAUgVh3LGQNFw2snayfByxeV+OKnGbRJwsdSGfvxQbBNrEEK3/8eCN51cyRVcV4e
 CUOg==
X-Gm-Message-State: AOJu0YwlVUkqEexpuKPA+AqGnm9CSfDBugpCVbrGh7ZXxrtG3VuOAwbf
 GFHiyRCRe7uReungIeaa7NQPy/UXATVkDFWSXDxqWhb9vhtsXd0N/0o+hZendm1NlI8vikjixhU
 P5R6YKrv93GsFrRNGEurout78z3xSHdCu6AhoLVO0ng==
X-Gm-Gg: ASbGncva+xj1gcR98qIWHx3AZFeN2lovg7/Gk+O17MxGB0OrZbJNDLkiUdM2dyHxtZi
 qGTXCe1xl5EaQbyeWAxMLw0dOZ+crxBw8cZeM65tn2dsT5wXROV7wz6hTMgfjIBvQjRqJwTwVUQ
 wY93RznPIDaZamR42zGDuyOlCvyLgMCiZzZsbzmWONHPX5wvLhv0+suobajYVb+vmrbZr5t3Hhm
 0rn3PCs
X-Google-Smtp-Source: AGHT+IFvshWc76ok5nmUOq6esnsN4mp9uMFxX4dM3x7LEKXtIdBHcKnpo/tMT8e2nlIpH0pH9vFRloTUB5MPiWuDw+4=
X-Received: by 2002:a05:690c:d8a:b0:71b:d6a0:9771 with SMTP id
 00721157ae682-71fdc30b9d7mr306534567b3.20.1756390653009; Thu, 28 Aug 2025
 07:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-2-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:17:21 +0100
X-Gm-Features: Ac12FXxYypMiGY3ObwOnmKQUK5_vfbO1KHZpcLbNtyEqGAOYt5w4fOWcN70LjII
Message-ID: <CAFEAcA-pu1mq7sF1ek9vthV7ttxVNXnSH2oX7d8gvRCeP6=nyQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/87] linux-user/x86_64: Convert target_elf_gregset_t
 to a struct
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 28 Aug 2025 at 13:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> A structure typedef may be abstract, while an array typedef cannot.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 60 +++++++++++++++++++++++---------------------
>  1 file changed, 31 insertions(+), 29 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

