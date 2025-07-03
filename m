Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EB9C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGaw-0001B4-Jk; Thu, 03 Jul 2025 05:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGat-000106-Gk
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:51:04 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGar-0000qc-Pp
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:51:03 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-710f39f5cb9so76574827b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751536260; x=1752141060; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lFnVNfGKTkWj2ynS3ngMS1udr6sDkR1V40OLyy9paas=;
 b=eEmvyafsM5i0z60UbdY9zwwquZjDFG5e1qu/4Uci5LLr4kwZV1ma3cmm08zawe1tDr
 1Y8dWZlWiY8ZJMxUGUQBGHcQXEE1+Mv2clnl8ltDgh9KTVw+JTz/9Rm+ZZvmdwIEamUV
 7tU+6+uQ4jO9TEMf8ipNU5HdnBQ8Qo2EPJ1YuwBa2ht4UKsc8BI/ftTyjPCNExFECFPm
 NKc0FHrOqcC2o/SDFpavYuoDIMNDi7oXXiBffq4B7amXnOKhrCF+PVcQvYbBWUXSeLPp
 vBpqI4f5H5W+x5PPyAIzQvqbJC3IJzrqUUocrVyDOF9LIRqz4Gr6CaghPO4jt6vTDOrH
 HvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751536260; x=1752141060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lFnVNfGKTkWj2ynS3ngMS1udr6sDkR1V40OLyy9paas=;
 b=s523u43gOaDdDWmPkZEbxtzpKdlG0EgijuUdgo1uajFx6ny/Wr+UOeRgPaWnRsvek1
 KPyD/kBJjBb0qOhsolReM4HuoG/hrzIusHjl2Pu/B5l/6B//SetQoQ5EOrlkhkmb0DS2
 jCBu/BWru1h9E9+is0W5dAbd8vJzxOeS3nX3yywKKjxT3KeHtB9bHGGZRLq6xf5G89dJ
 wTsnuHJQuAJOznIMnotGSKYtEy2+Zo8FwGpiZpT+w8byHpGdNyUJR5TR/DafGpMFqGFL
 It/TlODusjNkDY2Lfl7DUKdvYj88mntW9lF8uvESIEhjiLB1DcjdqzTFhQw8p6/PXjUB
 QG4Q==
X-Gm-Message-State: AOJu0YwiV4Wp00vkCHkQ8mpfWlmzL7M6hdL0rxw0KVXx9dRjZN4x25D6
 GAgh6+gDqG9bfr1r/0m9jgGeiqcpgfO2D/kLdatkt1cTR0MkoqG70jRRKHFMGKSTTTI1zsPJ6a1
 vfY2pw3IkSnhhBasp+b0XVguf3XCExQUDrVcrqr3btSCQSp7UP1BW
X-Gm-Gg: ASbGnctwxPx7d+Aquyq5+vbx9QP/T40Io1Dv7HWRaLmc75q7jTZrSlA2slYjv+8wka6
 EGeK684HBKoJbyoRC+AI7HiRu2+7sIEZD5vVHMXIUQizxhhBN/4XLL8JmaBqBvup8KrktIanO2J
 sVUPNzo8ZZOb24RJhITuvEjzn1dcNPdDH/WajEK45g3L0K
X-Google-Smtp-Source: AGHT+IFBnCvgm6hPhBeeG7eFvtG1a9ow9JJcsgtkcZs1u9mFwCK9hntt0ldD1dETxlM0HMr/NSSUILdTzkAaatUl734=
X-Received: by 2002:a05:690c:1d:b0:70e:779:7e6a with SMTP id
 00721157ae682-7165a3b77c8mr31861337b3.22.1751536260707; Thu, 03 Jul 2025
 02:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-40-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-40-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:50:49 +0100
X-Gm-Features: Ac12FXy65ZPSOvc357OFRSfghh_4UyHmbdhaHRalZlfgORKrEFHbqRU1aeRISQs
Message-ID: <CAFEAcA9=bqnsiAVrtmmXS5Unw+_fC2vT7oSZ4R-iQcLet4MvOA@mail.gmail.com>
Subject: Re: [PATCH v3 39/97] target/arm: Implement SME2 BFMLA, BFMLS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 2 Jul 2025 at 13:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper.h        |  9 +++++++++
>  target/arm/tcg/translate-sme.c | 14 ++++++++++++++
>  target/arm/tcg/vec_helper.c    | 26 ++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 18 ++++++++++++++++++
>  4 files changed, 67 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

