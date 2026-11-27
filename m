Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35648606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ciUTYuhX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWys1-0002ey-D8; Fri, 27 Nov 2026 11:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWys0-0002ed-5O
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:32:20 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWyry-00057C-N9
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:32:19 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67db89857abso8648390d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 08:32:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795797137; cv=none;
 d=google.com; s=arc-20260327;
 b=JMGgLcRGGXXcK5DuxRQdgM7iQm3viV3pqqNfSu5QRTlAtOnfZ1JwndrtuufOzmkE+R
 dPp5j4CSA0RG42B0YsWtLS0nD5welV06beVcPDVAcwukoi2Vm4gWW3cq8jSK7Gkh2imI
 r1rctWQEiVqcphrXXPrvjFpiObKmeDddDrKZFeO7ELK/4d6qzvvJjwy+5pvVgJz5Lr2Y
 2ftYwcwGl3RnSG1L5+M9ug4XYRzb77Ojo8gRYgs81TDng1ARuAOcOx8q3fezO5WXZdyx
 kiSMkY53uBqVfmU7db7fefYRiBEJO6ZxxgD9bb83rEGUSgjGbXnI0jYS3A/Xri9u92dH
 Bepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KLtlk+TdHgw3CehDohe/QPYEXiX1nen96Hla4zHMC2s=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=LcUfLu27Eb6sEDs2xI/G0fI7MwuCfnSipHavLoQtLIdYWRrHmtRDzDjdsrjKNaIP+J
 PUzAxOh5U+fmOob0PjskWsurW7swQiaF7VLuu3zFojuoZs2Mmr6ZLe8jl/ZIPBWsMw1Z
 X3FRs52jlp9b6G90UZYedaxRfJnStckClnkdLBG6j01yFJG3a5HCij5OgF+zaR+/oHas
 GK8J4e/sukAl4AoaZfJEolutUd4sdh29Utow4aj6LtujWLoK2E1SCc9t5D6jCabymcyy
 5gzlvySRhkEVtGBwXbvc+I6V1ui6SHJd8ciA92ZiKNyTK0+GZfaFEaK5mRA6KMHuyNBW
 7u4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795797137; x=1796401937; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KLtlk+TdHgw3CehDohe/QPYEXiX1nen96Hla4zHMC2s=;
 b=ciUTYuhX7vWYCOzpiDzW8f3sdV1A23xRgJ8W71jVE5ZPZ7xN8xCPv71ZMexRTUNgqu
 uM4pYZlzgJtMQYLavH+eDMzkefKMTBrEVaRFvNMW1uGnUOmDhqtu6g5PHF2sdQdvzq1X
 A+wqU3dFWI/gVeTUH5CRJXq49qfpp9wS4Uo8kVMWlqwHyRZO42X5DH9Ueta88vBuK8GG
 YZ5vVFurgmqQrNy4E99H3T2XvPcdt/JlofwS40RZcD5psiBVo4v3HYKCd3cL4Z/zi/5h
 n6PjAtnNLcKCA0R5MpnVAgdDGBRdKaJ5gy87l/sO1PN1vlQ4+Kv2X3MvMW0sI9Z8t0dh
 eOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795797137; x=1796401937;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KLtlk+TdHgw3CehDohe/QPYEXiX1nen96Hla4zHMC2s=;
 b=nA4rg2R2mS4MR8Fzs78fFQe83p8C9A1qiFLwmMwJs+CzEP/gHGJLDzLoez9PQgq0Ws
 wGuh2+RNsS5M+R5zeEDwj8/pRy2wJWIZ1phnsar5xGLuDoNC1jtN5pu2VFRyue/V2he6
 i7AtB+8YWEwc717h1xexjtuGh2rZ3nJDDxWU87laJCpT4iGDVesNIaHIma9Dfq7ZCSMj
 r2AIktpfM5GDgdvnJQSRuY/Mueh+fqSdmrKqknnjN9mHicMOKQENofKM8xtc4N/6xxDh
 7fwbp0kHlgjpncKR7oZLxGnGhiIQYxUA/0izLR/d4QPNOgsStpQewjkXmnupjDhd3xf9
 yZAA==
X-Gm-Message-State: APuU4Z9ngVpNFzFighRjXxGSrYSMvttlSwi05YeXFrDoqJmBtzLf5YIq
 5UtoxT/ldFUlrkQxQNt0g6lGrvoIX7jg6BikscBBchqv48HciGwQC9hNxrlQabJycRgHYI1GHPM
 zYPBrQ4fDFztHsFs8oib1QZA8dIg29axtjTnvYK2Fhw==
X-Gm-Gg: AZFdTZd0xA32uIsF+/7axuLkXUYnPZEfIQuxp5HQZqi6AkXvod71avD9IIDiVAHMWzo
 cTzQO8r1gsffZoHZ+bUyNm2CbFHojqlq3VoXB3fffq/WvhlsR26iitPgIGnfEfPXYrSN5W2p5eb
 3IH3YyJF2IBwpvRYk8LjjAQX+6rcXucgF2Dp1IjhPFyuvSMgXsg17fa1UyliZ3Bsey/ggLPYtG4
 gR5xtMec6bnH1+KgZFUg7fnktjLwwoSyf0neoQ/zJCPbG9jjitX23WrM+oov4Ra4/okbKOrNI+k
 OQNTGiOFC5SJjH4Qes38f3FN7j1hXu461d8SiUlBNuAdDI8y324cqUDRsdBU/ohe4B6WmBEnQ6B
 eUTf0TepFDv6nQ5xML7wCTAd19T9OvksSiid20AxLGMD3x3nCEx1QR0Ef1TpAwE65+iWjcFNubS
 Wp4Lo6JL7gmQy/okZaxewk
X-Received: by 2002:a05:690e:1698:b0:67d:ab75:a917 with SMTP id
 956f58d0204a3-67df445360bmr8695540d50.60.1795797137298; Fri, 27 Nov 2026
 08:32:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030194318.319310-1-richard.henderson@linaro.org>
 <20261030194318.319310-4-richard.henderson@linaro.org>
In-Reply-To: <20261030194318.319310-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 16:32:03 +0000
X-Gm-Features: Aa3M54qs1Ndoi1CpLz3b7ZRD0HwYRBAQlZC2cuHr2e9jhcG-BV1TXiBSfylV02k
Message-ID: <CAFEAcA-Kftdu66GSjrdmyqYtcd+_CJ8gZC1ao_FBGsY3AGoDiQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] target/arm: Add second value to DisasCompare64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 19:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Do not assume zero for the second value.
> But do set it to zero in a64_test_cc.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

