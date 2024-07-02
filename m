Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0091DC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOg5e-0006gf-BW; Tue, 02 Jul 2024 12:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOg5c-0006fV-1q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:10:44 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOg5Q-0008Kb-4l
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:10:42 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57ccd1111b0so1207951a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719936628; x=1720541428; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+i7ACyt1A0jbEbq7uoJN/YZ4dYpl40dS0lxWrdwFWE=;
 b=ouQuq5kWS+cU9DJkxi+MZVaBQ4Wkll3LkIZu57jdfUkQJlYRPOatNiFtU4+sOoma4Q
 C3Goj+hatIILKYeVUWif3ZJUv4kAiH4k1MNQ3UHKJ25qlnT01yW44lyWG0VGIdZf2Z+U
 vLM4yoGIb3ndiwMOY8LAnSxZrRTVGZSNIIe4x7nBnXY2X5GzaFCO3tebRjZkjOZiVwZQ
 u4GbU0nXNSVwcZUoptqAhx6VdKLzymTIVOad197dfpAGp199hNjiC0eDhi5CpRPH0c8f
 fvILuXHW92dxSqaAUX9zYinE3uGzXEXcjBkTPiL/Zk1tsF9cfazHM5n+4QX06y/AYCWt
 5ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719936628; x=1720541428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+i7ACyt1A0jbEbq7uoJN/YZ4dYpl40dS0lxWrdwFWE=;
 b=YFnz9bacgbXutkCmNKNt5fEbbAsvZESW2rJY1dI8/0NQlIpkf3nWjvkKglDTvbeLDf
 PzWMFaVt4Jq7MoW4O8+P9dmPdmlABWrc3ag/bHQRraiN827cio6sE+efkyLrCc3TlWRc
 EtRnWbfiAFbQ9tXeN5tWcmrtl2klhd4a+YayoBw6Wsm8jvw5V98mMscd83F6zbna+crL
 leMzjtueccA7zkHVubDzaOGfUJaU+f+mL15SL4hPIIs7u5yYPILqZQGQj0zrJ5+epq8s
 XHnChA8OuC7kZs8/7oRpJQTbLMcNBh28z/7EtuTMwrWRBbgAxCU+sWQjyfH9KoHNOo4P
 JOvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7M7PAloQsKxwttlWjTxECEGvK+KpOFTfzErfS0ljx6W56XXQ3p7i/8KgOXimmL7F6Idi4y1DXLWFmr6YEMP9+/1LaaUo=
X-Gm-Message-State: AOJu0YzqRfdvCsjFaulEBd7zEyZYDSZajctfYU1KaF9hKX9Uclm6L6F5
 jO5Oh9AL51zMpBrOomWPXg0UMlVqTMBtF8MdnnJyMG5235aLAz9hK+IQF6HbFdYIZPrv8xwDY5L
 QIZCR8nIPmjXf33og9uLjXOE7XPSoQzUh0/6/KQ==
X-Google-Smtp-Source: AGHT+IEnuT1Rv5cWYuGuBaO46pzlv+m+rP5BeTSbSwFLaatEozTSQSd0KgaV6os3ECnMB4yoFOT35gJZs/MA93a5UOs=
X-Received: by 2002:a05:6402:2549:b0:57d:42f6:63fe with SMTP id
 4fb4d7f45d1cf-5879f69b504mr8401197a12.22.1719936628594; Tue, 02 Jul 2024
 09:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240702154042.3018932-1-zheyuma97@gmail.com>
 <3bdd7747-316d-4b58-a9c3-2320864e6cf8@linaro.org>
In-Reply-To: <3bdd7747-316d-4b58-a9c3-2320864e6cf8@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2024 17:10:17 +0100
Message-ID: <CAFEAcA9iGeUc75tfPPOh2K2QMjVVjsE6s4owmrsO62+-9=Go2Q@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/bcm2835_thermal: Fix access size handling in
 bcm2835_thermal_ops
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 2 Jul 2024 at 16:50, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
> Personally I consider accepting access of
>
>    .valid.min_access_size > .impl.min_access_size
>
> as a bug in the memory core layer, whether being
> unaligned or not.

Mmm. You could make an argument for
  .valid: min_access_size =3D 4, unaligned =3D true
  .impl.min_access_size =3D 1, unaligned =3D false

meaning "accesses must be 32 bits, and if the guest
makes an unaligned 32 bit access then you can
synthesize it with 4 byte reads/writes", I guess.
But whether we (a) get that right (b) use it anywhere
(c) use it anywhere intentionally is not something
I'd be very confident in asserting :-)

I definitely think that our "synthesize accesses
where valid and impl mismatch" code could use a
going-over, so we either get it right or assert if
the MemoryRegionOps ask for something we don't handle.
Maybe someday...

thanks
-- PMM

