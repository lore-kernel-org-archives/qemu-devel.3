Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E50BC25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OYi-0007pe-1L; Tue, 21 May 2024 08:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9OYh-0007nV-1N
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:25:35 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9OYb-0000Vl-74
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:25:33 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so9013444a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716294327; x=1716899127; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JEhJjN5mr75Bv0xjuq7Bq0vjpz/ZXWzAxeDaanU/jz4=;
 b=jUZVLmuxw0W4Q224E6HYmXBxdyk92g8cq+g2rm24qvcKoP87eR8uQ37ryv/Qy8zDFP
 Beok0keLA3AM2AdT5VLTMsGigyDuSv2Vr29RrHwHAuDP/rehS9mqBEaC7tQDZvbo4T1j
 LwGaRgSQU8K/GuQtCrEefGRnnwZYYpEf1/PK5Ae8DPhqpJ6e4qb/mtD7c3WpNlKhFoOW
 MXW7QAmjs366sJ4j6+tb+NtkvjSBzuaGTGyypn4ZqNJ4sirCSeZNiC7DJduL6NTX/+dD
 rsWjiXfVZ6Q8+dgSfTuQIQ4eu1CINTMNDf3R6TGWKRrEIJegfMFTg5AmxOAl5PFJWih3
 ID1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716294327; x=1716899127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JEhJjN5mr75Bv0xjuq7Bq0vjpz/ZXWzAxeDaanU/jz4=;
 b=PuUVzFrqHRk98Vr0jzV0BMX2dFXcql2DfQiKUwm09lnRuBMH1cp+Bo6C5ZgxELaLu0
 YVeS3A1H3KJ4JAf0iXURvKzCobw4qGVZVZvYsXQIU3asHZJxWAbeFJDCB5M/z1FW7tu3
 Rb+Hj14L/ATyEAaivWVvvjZZ/6i1xu3y/NX6kXGr3tNnDalUdH3JjxLDfCZA59pWObPT
 wehHZNe6VoUAf3Mtpc2+1G6L4G/JQiT/HMssuGU3xtZ6xsJN8xbXFj3974+oC7Jjst5P
 eNbnvdZngK9VWceJciORNrD8JZBpJuG+cy1TwBu/0/VN0vGCDwKTUfO0ztBEk1/dwxnr
 IqhA==
X-Gm-Message-State: AOJu0YwAOPGnMLZJpTxVsFkcSAUhAg9M+nbiSUW0lEcEHP5DHs/coxdD
 Hfx6jRxZfdsJxTo25fyN5IjPwrZMu6qddVdiEqdsWio4nc+IEHDFudR7csGhttctGLAF4PO5lAC
 v1P0Utf3eRB7o6TGDL4ZoAqUS/hqv1l3lmOLJCw==
X-Google-Smtp-Source: AGHT+IEr4QlVpznD6YDiJ/W+uleLnsRlwn+Qokg57XMBpy1Vvu4ayneC2Kn7lvAp4o9qIOyELYG3EB+UQTk3KmSOLKA=
X-Received: by 2002:a50:9e6d:0:b0:572:8aab:441c with SMTP id
 4fb4d7f45d1cf-5734d6ed908mr20572912a12.26.1716294327494; Tue, 21 May 2024
 05:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-10-richard.henderson@linaro.org>
In-Reply-To: <20240511115400.7587-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2024 13:25:16 +0100
Message-ID: <CAFEAcA8Gn7BjA02fPn+uf1uz_QXamN4mSc3HnMPGq6mkii4xHw@mail.gmail.com>
Subject: Re: [PATCH 09/17] ppc64: Clean up reginfo_dump
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, 11 May 2024 at 12:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Dump only the registers that we copied in reginfo_init.
> Improve the formatting and layout of what we do dump

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>> ---
>  risu_reginfo_ppc64.c | 51 ++++++++++++++++++--------------------------
>  1 file changed, 21 insertions(+), 30 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

