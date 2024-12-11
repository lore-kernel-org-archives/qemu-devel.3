Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C09CE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLP15-0002oV-5U; Wed, 11 Dec 2024 10:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLP13-0002o0-Ay
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:52:45 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLP11-0003rS-UM
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:52:45 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e39841c8fd6so6301036276.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733932362; x=1734537162; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A52QEXv8FOSRjKI59L4HXMitBwhypcyabijsi9jeNsg=;
 b=BKLZ0C3+Kfn75zQG20qu2nZEYB0l/iTVHBIJrpdRw+y8GL/OcGIJHVKOTA3k8X4r4E
 ai7SP3ljzd3ttK/REeEX/TKpzdpXbjct6fv1GBamVohqOylZnWvZ17Yn7cQPjvMcpGQm
 v3f+LyqJlcRNCNPmeBEOEC1+Ne4Eqe18H3pssBtkxRwFEehefN41lNDM+KucjlMPjcNr
 NGEsE1sM9BG0kmzHfbRj9KiYMAKBaUULHmQg7LCLITeled2fw6rRnbVDSrmHX4Zv/hPf
 fzmBek3T7RW0OD72hW88tn3fQwIZyfmCZEc+Qtsj+YowOzlAplFVnUtpQ4zsgUUN2LTK
 jlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932362; x=1734537162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A52QEXv8FOSRjKI59L4HXMitBwhypcyabijsi9jeNsg=;
 b=fqt/RUGBV6E9bbTy2cqih+vWvfsmKTAe4c+nwhUsiBhkOnheUy/RJ4eZSTOKsOlQnh
 jXv7LkWHgHzG4MBExAuTGqtngO6RhNxbV5E83Zbw/5D6tnafqpPqtPULdkawoW9ywYrx
 BfFuB1QvmsVrVbokQnHVrEmz003ot0zN1lHZlpEyIH1xvnL6PQ7I2kRAbHpLRAN6zJB2
 NpwBern0cK5rU01n1wbX3+CkQV8sevQ7m0sQsfMcaKMaPHLU/zqUXCiH3zyHyB522HFE
 3nLKTUZfhfJZJcDcvy8qhj157Q2TIOZkBUvmjsfQ4yPVK9yeGJu1y8dAsPp56H9+eJ1N
 JE6w==
X-Gm-Message-State: AOJu0Yw+zUPh+Lhg9EzS2hdY8FzsJLZYESXNBNNozpB1Uz2BVmteTual
 845K30nTG0VAsARwvu6nG86aoQenaC5XozQB5fJJy3RDAcCxWaykk1sS5Qudg/N2156S7fav3kY
 rA5ZWlg6p7ouPl2sha1TAcv3cVGmdyH3CxgIrbA==
X-Gm-Gg: ASbGnctsG5GFJ0R2Z65XaToEVYn5j8XWcDjAuFb/Hnv2Kn4+HkR/XXDyPC7vSDOkiCi
 T1EjE1hkXI8Qx7Z7euWsMzEbwi8nosLGJXhER
X-Google-Smtp-Source: AGHT+IF4R43ezs7YVFD9G/q0jVABxGd//PQzHwF+nUYVjKNTOdjOiDvVoLbLsKgX0pt9ijrkgmI1esmRoTXhQCBRmNE=
X-Received: by 2002:a05:6902:1505:b0:e39:940e:3252 with SMTP id
 3f1490d57ef6-e3ca0585b0cmr230004276.52.1733932362695; Wed, 11 Dec 2024
 07:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-30-richard.henderson@linaro.org>
In-Reply-To: <20241210161733.1830573-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 15:52:31 +0000
Message-ID: <CAFEAcA-hnRuQ_rVhQU3+cfroZaa9xvnKZDH7xjhNCu5Sgxma6g@mail.gmail.com>
Subject: Re: [PATCH v2 29/69] target/arm: Convert BFCVT to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Tue, 10 Dec 2024 at 16:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 26 +++++++-------------------
>  target/arm/tcg/a64.decode      |  3 +++
>  2 files changed, 10 insertions(+), 19 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

