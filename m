Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE575C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk260-0003O7-Id; Mon, 17 Feb 2025 09:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk25z-0003Nr-4Y
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:27:39 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk25x-0001XG-KO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:27:38 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so3192034276.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739802455; x=1740407255; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxiwDJ1qW5vdcxFmENcGV/lROpT347z1Pr9uK/v9y00=;
 b=OChC/0qdHeBbTsfz5uQqGn0zE39y1F7QxTnT5ivdJ6X7rtmOWWKbWE/rJFk8DTQ6qd
 l0IlkmvAA90yi7sK1c4lNDDYiAkKTRo+0ygSe4obWnC6Aitx5GAxA5okrBF3vKJ0HyeA
 +Zytqu8QGSUmGY3H8gCPvZbxsQdHHDuAfGNZZ6PF7O3wBxStTBVndOCaWqBsWtEGgf5B
 U4lkF5xQ+StPJA4fCFGkF+Cx4bQEov0+Yff9jBq1aR9OjrJEqs12rqTTUm38je+Oj/hM
 MMe6ifA7QlFUY1333dzuuhnt6CW/vo+RNqe2RzZ9YeND6b2J/eqEA2gbA3nM6WVOmnqr
 PnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739802455; x=1740407255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxiwDJ1qW5vdcxFmENcGV/lROpT347z1Pr9uK/v9y00=;
 b=lWUSJK5GW1yvjws4+gcIHXtWS2f6YhxiPaorp7YiLnOLyvuh356wI4d8T+Gj8eLIF0
 CNXodkY1VojDW8A9jHUkpnumUbYtqT9VL9pB/4CSxbhJMydGeB8w5uCONACGdtFsfGtY
 5/srSbS6cKxg2sS6j0x41hFm8dHlRPpkUa6u00f4HmcrglwQ0oluMEo9llYIEOD9+rb8
 GMzXuZsggAtdZ5w/dtx1EohHPRjdVbJFRpZc8QH7eYPlNZPrUi2ePG7emSklHGyCDVX3
 EaXI3ZOARNZJ6Pj/zj5O+2Ayjg0zLAFmTBCXQVcl2lSiXdKhgLmp/aE1QAYzdtNrRcKu
 eEjg==
X-Gm-Message-State: AOJu0Yy9Dd3nqSQjx40iNW4cRgexsdwSv3KItds+KXa4WzlZ43o4FX5J
 /cBPmf1Qyg/GzdUnKKp6Xy8UcHv+1mxhBFrHiAXxm7E0jQKfm0MK6yQMKCMkmruWMLQnm2SijPU
 9+qc2oPSA/Mb0TeCqIR43eh1n4wCs8sQE6ZL6Yg==
X-Gm-Gg: ASbGncuwx7M/4T+WVztFPMgK/7CnlZCrfR3wo/n7sivIypDKCqT/cYWQfz5LIbJFOK5
 QgCHiPoInLVr+DCsfMbEyuGuCXueY5SiAiOY8XyoVbibL2MtGtFUXYiCFwXo68gKvJcyY0DqeIg
 ==
X-Google-Smtp-Source: AGHT+IHion98uDMErcaTy2KPDAunnvltZi+2+sHJ8Hxe7/touv6pVzrd3SAufrHnX48C56WA3GgnaBMlzBijSZiBlA0=
X-Received: by 2002:a05:6902:1244:b0:e5d:e04f:f29d with SMTP id
 3f1490d57ef6-e5de04ff47cmr3922630276.47.1739802455245; Mon, 17 Feb 2025
 06:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20250208163911.54522-1-philmd@linaro.org>
 <20250208163911.54522-5-philmd@linaro.org>
In-Reply-To: <20250208163911.54522-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 14:27:23 +0000
X-Gm-Features: AWEUYZnHyY9QVYCsEtLpJqHhz5JU_qpfhzRLYxyrW4MRz-YfS2xNraqZW7BR4jc
Message-ID: <CAFEAcA-tQUL2Rt4Y_eNFxCFXzNXupzQz3qYdEupB6Bb3HFyhfw@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] hw/char/pl011: Trace FIFO enablement
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Sat, 8 Feb 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/char/pl011.c      | 4 +++-
>  hw/char/trace-events | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index b9c9e5b5983..447f185e2d5 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -148,6 +148,7 @@ static bool pl011_loopback_enabled(PL011State *s)
>
>  static bool pl011_is_fifo_enabled(PL011State *s)
>  {
> +    trace_pl011_fifo_is_enabled((s->lcr & LCR_FEN) !=3D 0);
>      return (s->lcr & LCR_FEN) !=3D 0;

Might be neater having a local variable rather than
repeating the expression twice.

Anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

