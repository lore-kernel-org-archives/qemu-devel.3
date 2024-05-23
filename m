Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F125C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 11:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA6ht-0001C8-W2; Thu, 23 May 2024 07:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA6hj-00018B-SY
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:33:54 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA6hh-0005Se-SS
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:33:51 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso13036645a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 04:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716464026; x=1717068826; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LXyoHh/LlTtV23son32S4wXBIb55AcBOOE7zzdUn6bk=;
 b=kb16GX6dDRXHpDywVd64iNR3/NyQgh6lwrui51btScPMWhqMnYU6/S/d19GSw3pD4y
 D+WxGZf4Moai1AVMovXMxKPpy0TbwPQLYbTCRU/mCdDx2OBap+58mpOuQ3/zJcqS2ge0
 lCd8r97w76ZD8YtCHf0VNSxqd3ZVQwBf47h4lF7iMVtrHuOqq8gvpQEBUs+QWmLlhA9W
 lZLkD/r1/VzXPXBlPgv/JcBuVGYVr6HHtnAPh9tI5FMgvoMM2QV7Scq6oj8154rc43Xc
 AZpHEjaMLEu13zb0BnPrfJ7Rrl/wH1rsb37mKgqu7pCC3IdPfY7ajtrVjZt/dmpKapmz
 4KNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716464026; x=1717068826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LXyoHh/LlTtV23son32S4wXBIb55AcBOOE7zzdUn6bk=;
 b=K/qfmyd9O0LAVrqfjMnOZmGypQqcg1lR7qubekaCZIyHXJpj2J/F/Q16JezA2vb8kW
 wgyXvbhewJcjTPiTm8ae/ETjbeEBNZGcyeI/45mArtxcIyw5K683oAWhjf9GVw57UcpM
 Wx6EeoVVRYrXmpGnASDXcArJO0Mg36th1+yf3brFxoWNnbKKXGbD/ZfKdXJnlG5nLj+G
 Gwqvb7qCF7EGbAIVFjBpEEXKrnXR2ilDKBufbEoFcsnJM5UgWFzlGr8KKQS3gICCSfmm
 X08nZBcKevowrfKumU1yCsAqgFXP8Y5t3TwBc56OWyDyhuWXOc2aPHKpStel1dVy+PiX
 Giog==
X-Gm-Message-State: AOJu0YwEqfDBzTBjWDcsetF0hx9iWC34E9mMshJKMC7G2Q+nK3uXN96X
 dyRQLmLi48CVd4bB0lIqQ3zGxz+VHgVHatcmUN7FMYvEe9i7v2BS2Crx8XwOD1czIdZqYZeE9xA
 XiprIbsUQ5eGU73qrQTl7PMBi7Kdj5rTR+G49aw==
X-Google-Smtp-Source: AGHT+IG+Wp844Q8Fj47wOTPSOgpzmSnVz0RfUscDCdTzq8ypASrQrhK40Ml4cdl2LX6kNjL1PFDyWhpp6aFikkd328M=
X-Received: by 2002:a50:8ad2:0:b0:572:a16f:294 with SMTP id
 4fb4d7f45d1cf-57832c2d013mr3575926a12.30.1716464025878; Thu, 23 May 2024
 04:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-13-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 12:33:35 +0100
Message-ID: <CAFEAcA8L6pw+d0X_4Wn+w4fZbxoDs+qEjn98gZAzHr9=nMfWTQ@mail.gmail.com>
Subject: Re: [PATCH 12/57] target/arm: Convert FMULX to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 6 May 2024 at 02:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Convert all forms (scalar, vector, scalar indexed, vector indexed),
> which allows us to remove switch table entries elsewhere.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

