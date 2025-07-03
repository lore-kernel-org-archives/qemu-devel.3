Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4B9C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGxT-0001jC-Kx; Thu, 03 Jul 2025 06:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGxR-0001iq-W1
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:14:22 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGxQ-0001DL-Dt
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:14:21 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-710fe491842so74609047b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751537659; x=1752142459; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zFI9XTu4SqR5/5krjtdStjyPwuW/mKvuZtIJbLHd3yc=;
 b=rz6LD7inDPDKfuZVLTxZT/0QFKVN/Uc4cuHSQ80NZ+RZ0QxyR72M8ZzvQf4VEb8b0/
 fQaeQEXjkYZ2NGeWEyjxNJe149+mJNdtEOVU1i11fDiT+gvpozW5BwaFMDni/9JKn2bc
 EzjgTdLYEQzmj38eesNfQXSgghQwdz5DB38h9WUyQSUdLBWxW+kl5QC+BPVYi3FkTZd5
 WmiF2Su8PtxNSa4k1lYW9/YFw58LldTI1mcAfXS6GqZ398Vf56CZAt+bB/YGU1juHonx
 Zs9xus6OP9glGPKqjdLmjqt7Rx0tmzXA5JJzO/giDkch5gfGDq7i0Xx2TGUAM5M0KQ3I
 CYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751537659; x=1752142459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zFI9XTu4SqR5/5krjtdStjyPwuW/mKvuZtIJbLHd3yc=;
 b=TKJHKdA/CBvrtNZAOLOOt2ru4jvSGjoLrHj5kX1q/wj8eX06EhnXkkHzcZK/pl9UOD
 6Ha5Je2LQfyyXUjl+krcy9R1uXZasqmTnupfVpiygH84a9tHdXTLMmScoVrJSWR2lmOc
 7pP0jEzG69q0Wa5phh1K53n423q+N0eobFTC9ch53zvcC43qDRn5qkzRi/MLoN/Qn4u5
 mJDbYblMV2qZbH1yhtEELivGq51ryxq4Hu9mBKRvZMVXwfVzekWjg+zxjfdmkJN47M2X
 nEtFLtEoCoshAeeyq1OSCVJUfqNG9D7DdpbCHwhhid4Pk+tf242xd+qGzonzT2AZ0Dqv
 z8yA==
X-Gm-Message-State: AOJu0Yyr9vzXxaukMa9QlAVixmRJlHFWNIbtmHDpLk8X8vRmfALt64lt
 wOSl0Y329VFNIbW2chKmxwA/RafeKkMA+w0o3MSAf9Btkiry56qy1ePmLCMeOMLcNmElb+zXASF
 563or63smSGWFSeIz9myn9+b2qND3UEX9zn0dcAW7vw==
X-Gm-Gg: ASbGnctNJyDouiQC83A510/ibujugvKmk0w+mTGVF/todAPjN74ApDwgxZtcXM+I9uC
 0gUhaXaKYwIU3NjcxCcEpfVpZ6zg7Fh9S2T0Ei+QdkeqrFws/POsGe+YL2b3Uiw5NTiBLx2Q/j1
 4qzUVfQcQ8Gfe4lFzI5YDU5ptcm9Y61PzQoJawlx2FZsNSWYMGetyzWgY=
X-Google-Smtp-Source: AGHT+IGxUHzy3n1egtD762VV7ksKKbB4VnHI9Vk2iBkMoi1E6nWd4jQnZiRgNV7LcD76mESU4XZgkgkzXimuVBHv+xI=
X-Received: by 2002:a05:690c:4d08:b0:711:16d4:60dd with SMTP id
 00721157ae682-7165a3b79dbmr36323797b3.19.1751537659263; Thu, 03 Jul 2025
 03:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-44-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-44-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:14:07 +0100
X-Gm-Features: Ac12FXxLjxHlL1VoQ7JXfYWs6oHslT6_oIwg1ZW3-J4PAt961ywFYuHv8Wh_ViQ
Message-ID: <CAFEAcA8Zyu7iqJzh43Br9M+5RLQ0S8nbVgttcLY=npOMYv5PGQ@mail.gmail.com>
Subject: Re: [PATCH v3 43/97] target/arm: Implement SME2 FCVT (widening), FCVTL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    |  2 ++
>  target/arm/tcg/vec_internal.h  |  1 +
>  target/arm/tcg/sme_helper.c    | 38 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sve_helper.c    |  2 +-
>  target/arm/tcg/translate-sme.c |  5 +++++
>  target/arm/tcg/sme.decode      |  5 +++++
>  6 files changed, 52 insertions(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

