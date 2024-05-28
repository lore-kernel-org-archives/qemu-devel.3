Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5F7C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 13:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBweD-0007ph-6l; Tue, 28 May 2024 09:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBweB-0007oq-7H
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:13:47 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBwe8-0005jl-64
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:13:45 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f462so993940a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716902022; x=1717506822; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qAfY2pNB/sTeMjVLMwj6jXQx4mSb0Wv6WFJKt/AI0K8=;
 b=L/UmEM7NM22RKS0vVWT0rrdWGXF8kxcvrTUSmHVMWDJ11EjrFtDn15GoJTdt5xifNP
 8jYLO3/8zRMPm1AKkmkhmGzPWJSSUNaLatQQ295NIM0tRiKo6IWyw/LHgL2X3njMgVCC
 C4oT2eI0orWuDmom47DseABbIAwWJrrCYFxwlHT0GL4TdcdoiEZ/yizNhqQtIDj6n17C
 MK1MdRJy0z5EZD4OJVQm22n3datDn1q9KNgJsMtFpef1HX8h1V+Nd7LLMZ94OcdNAgRy
 TW9SJ/OyHVexGFu28dBNWU5rrWDFy+UsZqtCzfaj8bGwVsEnyPK7Tj690iQ4s6lF5DvL
 DayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716902022; x=1717506822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qAfY2pNB/sTeMjVLMwj6jXQx4mSb0Wv6WFJKt/AI0K8=;
 b=c1UmkyIRDknBOAQ11FeWuHLGgJJUsnSpDOu6SoPhWs/q6IJ7Vp0V0DwPh2jrZHvp79
 eoRg6j2vb3AmhoOMtLzJprjlRZOcKT76kMOMgzevqAt5FKuZkhTB5+hg6BDcKwpe1AT0
 cdOjmcLVEOUm19QMghfchjPHMTFsL8kGFv1WC/j+XtjP3gUkocaL/w/41YnjTL0u/eAX
 8t63QdfNo7wxRvukqHihO+rOeuSDz/xr5KVI97TcclQr4gSoQruKZh60hm7y/3CAK+hs
 3+5pHr/wTZWlTP9WDlk2AQ2lyDUDf0Yds+YlmlM5LAk8KTmnNeg6xAZ/0nV/Uz0FjMkb
 AMGA==
X-Gm-Message-State: AOJu0YzAoF+5VEByOwG7nlhd3HLaw0MwOE1QXzDh0pBQeknAfLwaTdt0
 9tjLWeSpyUxcMCCColoOpoExPPm2E6Br+Phn7OQxhkF6VI/HcRa8F/PXFpTWm/1x3XULecz+p1z
 V64hP/qt7QYj4z2Unip5d4Pm4UmHiPEoNHMchfA==
X-Google-Smtp-Source: AGHT+IEBT4EwMa8IGKzSXfTZS8pLcUjTS0ixdA6BqiME2/BOv19mdXL6GJQ0nRUwetDVDjp0MVcbzLPuKxpo41JpJHs=
X-Received: by 2002:a50:ccda:0:b0:578:56f1:e2f5 with SMTP id
 4fb4d7f45d1cf-57856f1e42fmr8512696a12.13.1716902022200; Tue, 28 May 2024
 06:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-3-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 14:13:30 +0100
Message-ID: <CAFEAcA_LC6MZ3eLY9RF3pzAzNvPvED8orebbdQsUJ0We7v5hsg@mail.gmail.com>
Subject: Re: [PATCH v2 02/67] target/arm: Use PLD, PLDW, PLI not NOP for t32
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 25 May 2024 at 00:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This fixes a bug in that neither PLI nor PLDW are present in ARMv6T2,
> but are introduced with ARMv7 and ARMv7MP respectively.
> For clarity, do not use NOP for PLD.
>
> Note that there is no PLDW (literal) -- bit 5 of the first word
> is not decoded, and is PLD (literal).  Confirmed on neoverse-n1
> host which does *not* trap on the (0) bit in the decode.

Handling of "(0)" and "(1)" bits in decode is CONSTRAINED UNPREDICTABLE
(see Arm ARM DDI0487K.a F1.7.2): implementations might:
 * UNDEF
 * NOP
 * ignore the bit and execute the insn
 * set any destination registers to UNKNOWN values

Usually (but not always) in QEMU we opt to UNDEF. If I'm
reading the decode lines correctly here in this case we're
opting to ignore the bit because we have both:

+    PLD          1111 1000 -001 1111 1111 ------------        # (literal)
+    PLD          1111 1000 -011 1111 1111 ------------        # (literal)

And this isn't a change in this commit because the NOP lines
we used to have also meant we ignored the bit.

With a tweaked commit message
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

