Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEFDC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBiM-0007f9-4X; Tue, 09 Jul 2024 10:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRBiJ-0007Z0-0O
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:21:03 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRBiG-0001j7-Aw
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:21:02 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5957040e32aso425516a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720534858; x=1721139658; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8nvEN43i8s8OHgYCcHuQ5agVs7nVCZH4nZVhTyQm1lk=;
 b=uYpMHgkkZ3v/m/C/9vl2FTr9xROPRrhFNvTkWqGo06m/yqkKnMr+gzaRVTZZ9+HDXe
 cc7kAm+acWHGEbIUsj88DhQJDBqgiHjlDrlCwsv1tiDsOGg/jOWk62paLGyukfpyYNk8
 ljDBV7KUm9VJteaC3GjwtuYORjONloII0VzxjpsHfBMbQfnqOLMtYzr9IlzKe9lAiW/+
 6a3J74JDAETUyWcFSSrym83F6Y86N5EHOcIFzzVDRfasBHHECcIDoQiTpYhyExPBvQ2z
 Ajp/S4UhHLiGqx6FHdoVdlp/7jowlQzHmWzZ52ElPhnLaBjyN3/uhm4OALsB+VuavYkI
 sjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720534858; x=1721139658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8nvEN43i8s8OHgYCcHuQ5agVs7nVCZH4nZVhTyQm1lk=;
 b=KmYFF4spWPNvTpKsfVd0rb4CRCgft+9SscCgbq8m20ACHvKTXToaUW7uRUpAw4zqtt
 qzDH5MBNiAowK8jDX+SKYlZnMGBBpJuKLt51Sky5nck83lyetgXteVrsI7kRrkAikl1Y
 b8l+rDiez7Z3SzPNZUFvu5b5PUfkcd26YyASNnM7LGsPNW2p72PP2XEEJmGw70bYU4Al
 DzSrY979cQ1Npbt6Jsg089T5PN0e/40w/KHYakggF6ffM50yMLq8HHi+I7AS7DzhVAf0
 mHcJIvYxpQIak0sy+wnsoGl148lw63zaUlgv2Cy6XQJdUk/shzo8l1ZmapaodBxXmFDo
 8PYg==
X-Gm-Message-State: AOJu0YwcbJD5Ty+n/pa1JSZefKKYPM+qcqvFba/5rsq6k9sP698cWm3G
 zDrJNlk800oI7neVxFmSl7PWDSMIqL220KjxG0M2ePRTZp6HFYHwjRehlGdOVg0uVlzoihpUZLJ
 TVb1hNwGeJSe+0DopLsgENP0JRAbEMbSbVs50pg==
X-Google-Smtp-Source: AGHT+IFcOw0/+SbuOG0GRNmLPGjGYGWLsU7i7te4jaopUTQE9sbb3ZMSRCOjEax/pDgCeUBQb+0KImbtsAsDcXEIt58=
X-Received: by 2002:a05:6402:510c:b0:58c:15a5:3e12 with SMTP id
 4fb4d7f45d1cf-594bcba84c9mr2474401a12.38.1720534858581; Tue, 09 Jul 2024
 07:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240709000610.382391-1-richard.henderson@linaro.org>
 <20240709000610.382391-2-richard.henderson@linaro.org>
In-Reply-To: <20240709000610.382391-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2024 15:20:47 +0100
Message-ID: <CAFEAcA-6C4uykQM6J+rXTAqfhTCYGZBKR75k3ZNcVPFq_BwBkw@mail.gmail.com>
Subject: Re: [PATCH 1/6] target/arm: Convert SMULL, UMULL, SMLAL, UMLAL,
 SMLSL, UMLSL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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
>  target/arm/tcg/translate-a64.c | 184 ++++++++++++++++++++++++---------
>  target/arm/tcg/a64.decode      |  22 ++++
>  2 files changed, 156 insertions(+), 50 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

