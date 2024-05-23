Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B314C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 10:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA5JO-0008BV-0c; Thu, 23 May 2024 06:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5JH-00089c-Eg
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:04:33 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5JF-0004tz-L1
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:04:31 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5755fafa5a7so6499011a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716458668; x=1717063468; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gseeate5nXuN/96Nm4Hv3YwY4ngTp6AnC0AphvtiByQ=;
 b=f4RVfXgF/Uif9/vJpy2HLvbwX/BoIDIz9/Orw8vUgKqEK9MKLPJDjTxrUJELLcjqwX
 K0zkyT2Gp0w9QalpKO09H5mLPhygZPCIXytvfvJrWtyY2aY2Z+w3H64gV0ct09ySWBzB
 ID3RxER7JGnWod7yy3IU2xGQFqmtA+VRewQ4Xa8ctzOnpHAjRJ1Z6C+erZdmu2fCscPN
 sUR96TxRx8gzb75bd0OPlM4FZi6iVsgdS+eHmaANjvdggfCTSPB+qBMpFaTzleCA24sA
 99M3FnLL+gKU189MXNpLsQDmK6Ot1mZS7x60fzILOFzokySqwqiHaKSUDaPUeqm/Geg3
 bxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716458668; x=1717063468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gseeate5nXuN/96Nm4Hv3YwY4ngTp6AnC0AphvtiByQ=;
 b=nGotnR6ST0WAzKhXsS/dtuZoq2tkVvTqQUmJlJVv1NN4pdfh+QqnM0Wz31c3p6niQh
 BsV+m/HLyYz6cnu9zgDTDwWumi1OWPgEps9j9F3vVkgYIpZ3wW1Gjm2UPOWXWKRPTnSt
 P8FLRmtF/4i3hY7DdFcsWrZi8hrVu7jFa8KJNjT0F1OFpHn5bXRAsDUVykU2+ryTLPzk
 FgVz2jOGi8T8Lll4Rz2WHKQn9E47gU3noUIxzC/24Pkelzrr7hAW1+YpIQv3tpSZGWzM
 YNdhaTIn5H0rtmUJrZVTxK6XMvB9IBQI/Rr6s1e9WlqLYmXZ99GkbhXb+2lpBFsm32a+
 GFXA==
X-Gm-Message-State: AOJu0YyJwFfEsgo43AMJDp+P5Tka46FFgGGF3etDEexCfpMoKWQU7jTv
 sA+d575wym8GoQPtNJTKR39YRlIQXX390nGv2L10KPRmWHT0QiFAT6BgXJccpUzWMMOf7mwhwMB
 hpydR+fCgdAQ2qKtHA0n8x5Jqc+3YLBtXZ6gCvn/69Zb/JGR+
X-Google-Smtp-Source: AGHT+IGeMq8gVsUDv1ulQ2ehTS/qpcLBfJjV7/2SjkhXIomQ21TUnmM9d4iNSmB+WVbhbh6ugAuQqu31vMBqtSWpc8g=
X-Received: by 2002:a50:bb03:0:b0:578:258c:1091 with SMTP id
 4fb4d7f45d1cf-578329fe356mr2699807a12.4.1716458667920; Thu, 23 May 2024
 03:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-5-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 11:04:10 +0100
Message-ID: <CAFEAcA-U8XsO2ScjeGXMgqJLvVbEFWdp0s7KOEh7-ZK8-evqTA@mail.gmail.com>
Subject: Re: [PATCH 04/57] target/arm: Convert Cryptographic 3-register SHA to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 6 May 2024 at 02:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      | 11 +++++
>  target/arm/tcg/translate-a64.c | 78 +++++-----------------------------
>  2 files changed, 21 insertions(+), 68 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

