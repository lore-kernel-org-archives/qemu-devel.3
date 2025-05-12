Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12920C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVCG-0000gF-VO; Mon, 12 May 2025 11:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEVBt-0000Ue-Cs
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:35:42 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEVBr-00078R-4l
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:35:40 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e733cd55f9eso4591808276.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747064138; x=1747668938; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qe/NyfgQlTpjUm39PL7rrDqLnUgfos936c65Rpt8wqc=;
 b=Iu5pJCSMUfHVJagY3MwsDGbs8BrmsFjdcDWoCA980e6DJdY9tLi7LSBfcaCysspINW
 Y1Jk70gBbMbKYd/DkYBMHrSdCWOO3It89v7U1fcNTgntgD8pXBDcJHlawQEgdaErQuCs
 /RSUuyqIGjq1D3O4HF6kp1/sDoO8qdJ+pSR7aPjTthTmaNp3IPa/RWEfV++JsFL6yUVr
 8+/TNCaHmrcrI5DMPODtrXvM/oydmpB/74CwKx0b35y6qdv+KMHkJCTzf3x04BC1m2Yy
 +2b+/jiwd0VuD13NrQw0jI3eWU9MF1NnyepaY/mUt0zZupatvvI+GaUCjEgVGtjNoK55
 Gf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747064138; x=1747668938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qe/NyfgQlTpjUm39PL7rrDqLnUgfos936c65Rpt8wqc=;
 b=KDg9WgEMaPfjGPo8HuyyuTvG+aOMOepCvAxbMloGiqJLKCAG0ArpXH8bYcWezI2gmI
 zL9354b9n9XX2Vm8DWc2tvYUktUCK3EuRPCMahLpZBa1M6psYChbasuj09Aw8ryFbC7k
 sw/vwO3zXwOLKiU9amxrtuHo7bYa5Kw/p9CGflGcVJofhQoVQggNxvxIzQq9ZT/RaX2z
 1pcewJZ0owe5pGpIyWrIdkQyJzNYvjZhvz2q2ThHrm3PHrhShqyIMoHMGWO8ksmCw0WV
 MTcXzG/BA+9Db6XYHfC3A+qiH9RcWs1liHyKvUqzqcp2NaBM+DaJMs1u5GcyzfDyC1cU
 uNsA==
X-Gm-Message-State: AOJu0Yz2UfwWR7qS2dFrceIeX11BOaijnKm2/lAFLu2C60YWLBrLZqHX
 dZPREXsnBhZmL8FMM9xF1FyO1OytBOVUg+MSk4fIm2upUoXdWgu+ktGMNL+riKExSqcjziaUsb6
 VC6rbrEjtnyUWtfOrFZj7L5Uv5uvXv2H8dVmKxA==
X-Gm-Gg: ASbGncstm7KRrxV4sU8AiFoH4vy9tSads3AQ71Qrgd7CZXSXa2Sey3Fe6f8M9X1K27K
 DmP1cDe0YgLntoUNAq0gJn/qIt11cFHMmZR3SFA5xVUjkdsHs1Jt58w5gGz8XWL7ojznvmOCGHx
 17eYKX1a9eaHiTEN5oWOHcR1LtyKawakpfWw==
X-Google-Smtp-Source: AGHT+IG4eLhjiS1myv2RBEelmrodX/ui/oB2WvZPK67tZ07Tx/xf5hPN5Ce8Zs0YGXcNPcDUTcNSRTJ8M4ZF4A26tmI=
X-Received: by 2002:a05:690c:4b8d:b0:708:bdb4:6d07 with SMTP id
 00721157ae682-70a3fb35516mr182214947b3.25.1747064137692; Mon, 12 May 2025
 08:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250512153337.153954-1-pbonzini@redhat.com>
 <20250512153337.153954-3-pbonzini@redhat.com>
In-Reply-To: <20250512153337.153954-3-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 16:35:25 +0100
X-Gm-Features: AX0GCFssu5QqnWld97LjxzavGOpaMhfAyidlgNDjFg6i3uDGwreDvlpvKAGpV6k
Message-ID: <CAFEAcA-jcS+apGg4hVwsTD4yfjBdOZd6Fittt_ZSc9pZQGtv7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: pl011: Really use RX FIFO depth
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Mon, 12 May 2025 at 16:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> While we model a 16-elements RX FIFO since the PL011 model was
> introduced in commit cdbdb648b7c ("ARM Versatile Platform Baseboard
> emulation"), we only read 1 char at a time!
>
> Have can_receive() return how many elements are available, and use that
> in receive().
>
> This is the Rust version of commit 3e0f118f825 ("hw/char/pl011: Really
> use RX FIFO depth"); but it also adds back a comment that is present
> in commit f576e0733cc ("hw/char/pl011: Add support for loopback") and
> absent in the Rust code.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

