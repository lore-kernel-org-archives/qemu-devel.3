Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62823606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oqRMqC/q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKBCD-0008Rt-8U; Fri, 23 Oct 2026 05:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKBCC-0008Rf-4f
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:04:16 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKBCA-0004h5-Cd
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:04:15 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b09e07e149so6037517b3.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:04:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792746253; cv=none;
 d=google.com; s=arc-20260327;
 b=fZOdUVcqmOobwuaaucbu98Fzjj+QxwTkzsHB2+hfpDAFQsm7thE2+u3elaViJhaSHy
 /BLGXNTmixod7LifSoADxtgjQdUYqD4vaoO8CFYLxcQSFxOBidl0D+rEnJFtNnofSMNg
 1k24jEx3HkaZqIRMEgQldlaY/2fTuso7EGkD07M9ZWMogYNuh2fZdLJtn78NxmrjCbGK
 VAc4bNz0AzTNyn+oq3sg5mFkqrARVFsBSxIaZ4HKonARUzj/MrTnPOR5R/QUh0kdrILi
 C2OK++gxbcKE4OSWVorbncMiKegUp+qACM2xpQ6Mb6tLF4rFiZelwG66u4JK33EzWAbr
 yhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Os6ZGdyP1xZgWKkKP2tEW6WxnVaIoC5joHapGphjUA4=;
 fh=BKDbynig6z8bGWxdtJN665Y7PKmXnL7W9fHt/EQT2S4=;
 b=LjsdSmorFP6kPL1G7uWGLrrA3pKi6RX0m+NrYkoXDySW3UqU66ZsbUeGlR3wSBDhWh
 H8YW+N34In6Bp3o6wttM0qjVTbdQUbkLcldb7DgqvjjNJ7g6yqrFnFVHq9NFJ/1vO2yN
 k3NwH1WLU+3P5llHAtHe1RaUDz+kqPmO50zznG/R5E5o2YYrLKLYRUqfT+6cblFSQy3y
 L6u7/stWFyU+6v9wCigEo7kVc+9IYxxw6hGG4St6Jmw/D2uSBQSlZvQIgstlTMXRiKaF
 vhdL51sGtmolCHSyP4mi+V5nSBCLCFGcbpsYR601clgP9G5jqr8kbcxg+KrGSvLPjNY4
 ZwLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792746253; x=1793351053; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Os6ZGdyP1xZgWKkKP2tEW6WxnVaIoC5joHapGphjUA4=;
 b=oqRMqC/qnmBAuhKoTDICwqyR4n3/L/gNFmnLC5LXdJdDpOlxEaqi5egnxn6ZdtNsql
 Kt5ULXVksOOV/++QJhmMPFNWHthbPRKn1S07X8ZH3hudwr3ICgrGzLchrgDqpvmKgfQj
 DPa8tPghgZNd+Z73649TiSbSxE7tG3+j0obHtq+jxNhxkAJ8rSVLKErCA8v0NWUhdig3
 DDhUqi6J1uFUxZ+QOlBl7ifta1Y/oI6Np3KS2bd8StD7ukvvKIhymcLoQ40z13n65DD8
 W3LWPj4GzNtSEmNNdVUrSyUnDS2mreGlT9zmvs9LrpcllgD5btQGJYPEGp12CZ1ej3b0
 oURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792746253; x=1793351053;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Os6ZGdyP1xZgWKkKP2tEW6WxnVaIoC5joHapGphjUA4=;
 b=WoHYNRC5pXJA/xoVksSJOOAjq2SKDqijN0Gvfkza9sKJLKvS//IKMJHr6dd8kHR2UP
 5R1fys8sPFFaGhrASUbABA/VNc2Ba02S5QFPX9SRj3qRi/1ANw9KBdpyFcwfVHzbOgYp
 9XPzR0cBE1mILVBgR0MbLTuWXdGrMb4t+tkhuQyrjVzrmw8O2ivy6Os5xbv07yslv0QV
 MmSn605Uv//sL3LKO//bOrUMWkM7biU/TtyR0tTxFkZkExjwAfQ6ww1mLcDFRfw8DQzU
 ytFPP4ZIEIhC9y6+rKoNuvnKJldUir25TA+3w9L3vWS5ZzyrMmTp/KwDkP3VVDVFiQLJ
 xGoQ==
X-Gm-Message-State: AFq9FYKPqFr5GIWBTVWp4jxvCPzFi4amikMmn7rv6FwfSZXPqVG+B21d
 uT9vHojJiHk3quAzhFVDG6a8cxfBQXK18W7R5O6GMRgBOCwcju7aDtLQKRfvdT4lYEigG7YLDl9
 mp0LzzpkbKW6L9XCvns7tvbdf5WGgO1bvUQJJ2hm8IA==
X-Gm-Gg: AYBFou0b1L4AIO5xvjkF8UPwA+2QeWsj4m3gblQl6raFwUVj/YPHXvV9qWJWGZ1pm3v
 JGMEUqlDeUr6phx2rviFcgswbVW6j9G76c4oxA1F4G604ZSA5vRSz3jscBKsYNw/SF5vDTFYM2Q
 tYB2kdfcuAt3A97/8GSz+trkYq4ymHPB0ncf+qrPHQFupQf2RcrrWjXG+EfEJuK1eeIxaY0PKFq
 asuTVNvDMK56pPlT7Afxc1dEeVefa9xPz2aQfJBSyi15VaBfLrs0zNQC/Ncm6qwm6E7/LVsJDe3
 P+nTEIPdyEQYYmN6nR5a0rWcSRsPKy5pYWE1iW1vyU1ppeGU+yNpFwIhG0X0amTmqWB4qs7/4If
 TgTiGwMfnDq1EXCPJx7q5ZlBTPV3hlP5BcKFbjCZAh0xfGVNz+ii3om/kgrV7d/nfgR/6SLm1U2
 5/fwMDb4wOcw0WX13bzoi3
X-Received: by 2002:a05:690c:d94:b0:8b0:df71:44d1 with SMTP id
 00721157ae682-8b157bc3377mr13355387b3.6.1792746252593; Fri, 23 Oct 2026
 02:04:12 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020211529.99689-1-conti.manuele@gmail.com>
In-Reply-To: <20261020211529.99689-1-conti.manuele@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 10:04:01 +0100
X-Gm-Features: AclHuK8qDtXOuSISYR0ttUn5MaoQGNLKPegAsm20y0fZbW4OotFmm-JnTxvy1TI
Message-ID: <CAFEAcA-kevPYzVCMRXej27Z9ZK0FPneZFVjpwN30hS=WLAr20A@mail.gmail.com>
Subject: Re: [PATCH] hw/adc/stm32f2xx_adc: fix left-aligned conversion results
To: Manuele Conti <conti.manuele@gmail.com>
Cc: qemu-devel@nongnu.org, alistair@alistair23.me, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 20 Oct 2026 at 22:15, Manuele Conti <conti.manuele@gmail.com> wrote:
>
> Left-aligned regular conversion results must occupy bits [15:4],
> [15:6], or [15:8] for 12-, 10-, or 8-bit resolution respectively.
> At 6-bit resolution the result is aligned within a byte, in bits [7:2].
>
> The current single-bit shift and 0xFFF0 mask both misalign the result
> and discard significant sample bits. Select the shift according to RES
> and keep the existing right-aligned sample generation unchanged.
>
> Signed-off-by: Manuele Conti <conti.manuele@gmail.com>
> ---
>  hw/adc/stm32f2xx_adc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied to target-arm.next, thanks. I expanded the comment
a little and added brackets round the "4 + 2 * resolution"
for clarity.

-- PMM

