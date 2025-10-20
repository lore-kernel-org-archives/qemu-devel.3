Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DB4CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArCL-00072u-Jl; Mon, 20 Oct 2025 10:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArCJ-00070T-Cy
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:49:19 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArCH-0004AX-Ex
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:49:19 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-63cf0df1abbso4613837d50.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760971754; x=1761576554; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7q2+5dIa0Yzx69aZayx4LpDkshouazBU6lCeu6IMxfg=;
 b=VxyJ20AX8LEa3VPtNJgQf6vvy7a+ftv8ZQGH4R7pjTBbu4C3+vLoGedU80iy9JMEcT
 W4opmmL6v97Xw1WEEw8DRCsA3mbNAGNeHa9QkU5WSKhmTOXrGmtApqbEJAYR7WU50pOB
 l84BSlRAf3uz0LoooyoHLonmj0dgIkkixojt9HMA4p76aYKCccgrq7fmKsGJhk31zaJj
 C8E4u187Bju9mQdvan7wJdxYCdNHfQxIIsu30MvA7v69u88fAs0h0H+UVi8jkzWfiAtD
 BvcHyqyDm1kGEcgoHT2YG0t61Kc76Hy9FU2fqZLSLzcCt6EGT4U1ls+idjpQgwTXR3CU
 IKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760971754; x=1761576554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7q2+5dIa0Yzx69aZayx4LpDkshouazBU6lCeu6IMxfg=;
 b=k9elTffjD8OFd+TmoQgudaN5X0QHaUH6JDIn3rYFqD+BHqyuJhcwubKun5rQkq3pcF
 9EpMQKSGJZWt6QhzquzczrgBdPey233N4ID6YhwRkFCXA2tcLLejI6eieBVObiIr78pc
 b1XnzKDjb4vHC5YttMoV0XqqKDqlUHcbfo7iYi0ZHBKCF8F6nSiuF3JT6dZ2BG/CsQzo
 uv+6IG5QSBoBzU78a4litmBVJX1ktH+qnthHxKm2LNMT8x/0Hg1YQdp3Ez9gbfxgVak2
 Gf0kgD3KnVZZznxH1k2Qr7CaRJfUQ/ivzC8f+V1aWwn+ut5tKbuVdpJa0iD+g6jiMv6j
 TaAg==
X-Gm-Message-State: AOJu0YxRBKhRmtEJ9InOpt6G3QUYYO4O/KODUACvtj9uD5tNSadELSLV
 cIOxRxnTwxztbdLy+mq374HPjLaKQNcTj3lto2E/WPu05x4kTiL995hBDUnVHCqBdPsuybTzK+U
 ygfaBP+7qbtFHkMNqjd4dKEySEOWQvCrYEWYAHCcwpQ==
X-Gm-Gg: ASbGncuRYCnHF4oW95N3C5yd4uGUwPn157I9/jmAdA70uCF0iaqYcbMiNF2/4nwPhOk
 LTwu34qW5JzSYDfealIu++ddURQPoRxCkZ66Ba4a9wUnFDtbBY2dtHSBggJBZWrueczr++MuQah
 Fw763I0skwu9/Ahdugqqr/578uzi52OYcRiO2hb5uNMkcmj3g0TNEURWJeQLKNTH0lr1SGn2+Js
 QQEoMxDkH2zVNtheK9bsbtyZG5g20gkp/4w8tgGVYM8VDdy/CkyFhtH62av5w==
X-Google-Smtp-Source: AGHT+IH4kLVkskDyysny43vcHBZGEk7Ord2q64O9dJU7hjIEVDkP9d2Daq1Q8If40YqQm1gsdxINXy5ajJaUTKrxAm8=
X-Received: by 2002:a05:690e:1186:b0:63e:2d1a:b422 with SMTP id
 956f58d0204a3-63e2d1ab544mr6229657d50.24.1760971754447; Mon, 20 Oct 2025
 07:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-30-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 15:49:03 +0100
X-Gm-Features: AS18NWDe0XWZVZ21CHoV8VbVmrlbgTY5MtvnKKUKQdqQMtvtyg75RQuK0Jv_pp0
Message-ID: <CAFEAcA_hAjuy8GObT3dczmQ-C0vVrMBuLHz6WyPzsSrA2ytErw@mail.gmail.com>
Subject: Re: [PATCH v2 29/37] target/arm: Implement TLBIP RIPAS1E1, RIPAS1LE1, 
 RIPAS2E1IS, RIPAS2LE1IS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Tue, 14 Oct 2025 at 21:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/tlb-insns.c | 39 ++++++++++++++++++++++++++++++--------


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

