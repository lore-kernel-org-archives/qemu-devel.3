Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF473CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 12:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCGlC-000373-Di; Fri, 24 Oct 2025 08:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vCGlA-00036P-PG
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 08:19:08 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vCGl7-0003YU-T8
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 08:19:08 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71d71bcab69so19605937b3.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761308343; x=1761913143; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EXna/SU1hFDHQ+jFTsz1hhSFhQn+gkgnGe0tRJOmQTo=;
 b=TrkVKcrChRjtUqLhzBmUCijVmBpPbXUBh1Ck8KawH1A9hg0ReL3R42797NlQNnaMSQ
 O6HtoygTLYdtWNUekWyM3H2jqqGJnCPepLkkrP8U2oL7iel+FoCGostiVCArPXledT0o
 Gkfh0N122j8iDdY7JDhAFhl7wZI4JqAhEJ12lTJIUmtTxbe80a0mP7f27w+iVgYPu0Mp
 rJLsd7KB0+IME/BtJPVewH7njW/bWuEjq6pYajTHEFFgjvl7l5Oc1gcg6mPAcmhbB6dL
 q2l6afBe/l7Rd+oM7rF5xHgAe22eNO+b6y09St+E+7uci/DrQocaU/PjTVljUZ/g6lzy
 ZC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761308343; x=1761913143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EXna/SU1hFDHQ+jFTsz1hhSFhQn+gkgnGe0tRJOmQTo=;
 b=u/RPWsfx3oqAhGxskb5zmDUltL7aRYPM9zPRAu8WUYU6HT+icR0Jfve43QtawackJs
 RxbYOG8GIFTOM8j//46qKFuYUyO4OK/PupgU5ZxUi8ajhaZgJhZ3n8Qz8Zpt4v6V73d0
 BHLN+oWj75PxgC7kUJnw74bGoaWFwo1XIyfhL/jxX3DBnJeEZVeNBF0RhpugQcoCgbGb
 rgM4Lj+vmu3+n1qQRdxYU1YNpZPlTH8ahgTrlz3P5QmLwyuDj9cCgex/B4e1xe3OyqV0
 ygdiYYR1mXNPWHhMD79OYGCWmjp5CQC9yDpclAiCGLxVngbNm/3D6GeQxMPRim6hVxuG
 sXQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmDd7qHGulgx8atxL6/On1UTM83DrBl6ADMvyU5YH/+0qNhMseGHCaQZLeRsQtSfYEABSi/IOgaxyJ@nongnu.org
X-Gm-Message-State: AOJu0YzbyXVsjQIl89yamg0DYwHKwgf8OACmfA31gjMYrKYG/8eyc5dq
 /TvIKQrFGAyZ/1zwA8rA4EMyCdlDepwi+vCYL1n6J+V40xACqTH+5VTVzwvLVUDEOszT2cws7Do
 Kpn0rmGITYHSOxIMC7mPfhsW5w/oe0BCIFi4j4fpQqA==
X-Gm-Gg: ASbGncuOXerk6vUMacFYq8bTEkOtf0k6EIWaM/EX3CZ6uvszlUJozaqwwGSAxxiUoHh
 oYuYl2RVpZZb2OOVEQ/hdT5rlUrbepaGyvgyzztxymudlH9aicQqLlUFhNAXq+KwnU+WGTYwuqH
 bMZpOBX8t63TUkwVQDy5Kd4Gx1dQpbmO+OMZFbhcyjIyJ0BoSUgPMHG3IH0mdEL0c9AJ19RJ8TJ
 EPH2YTtrXB712ucqSfuXYXjD0H/ETeAJZvuaJI8ouB5CiO0vG4y761mCFnoMg==
X-Google-Smtp-Source: AGHT+IEaSClK7VaJYf5t83bCQgdtzdDPnIxRQ7YMxOxAgTGAmiLH6siSJbCNzXnyl9lB+cZV8CUg74hTnZVG8Pnn8xg=
X-Received: by 2002:a05:690e:4084:b0:63e:3a34:7bac with SMTP id
 956f58d0204a3-63e3a349322mr11953731d50.62.1761308343402; Fri, 24 Oct 2025
 05:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-6-vishalc@linux.ibm.com>
 <aecf60d5-8bb2-48bb-28b5-20b58729fb56@eik.bme.hu>
In-Reply-To: <aecf60d5-8bb2-48bb-28b5-20b58729fb56@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Oct 2025 13:18:51 +0100
X-Gm-Features: AS18NWAA81xXOaGA-1gP2nzsvi0YeInoBK6a1q_tjK9VbSgkYi2nEhJ9AcZEDCQ
Message-ID: <CAFEAcA_2B-Q9QzvT+dEL3DFnkfuG6hh0cUObqcKdaqiatQwgaw@mail.gmail.com>
Subject: Re: [Patch v9 3/6] core/loader: improve error handling in image
 loading functions
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, 
 milesg@linux.ibm.com, npiggin@gmail.com, alistair23@gmail.com, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
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

On Fri, 24 Oct 2025 at 12:25, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Fri, 24 Oct 2025, Vishal Chourasia wrote:
> > Add error checking for lseek() failure and provide better error
> > messages when image loading fails, including filenames and addresses.
> >
> > Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

> > +    if (size > max_sz) {
> > +        error_setg(errp, "%s exceeds maximum image size (%" PRIu64 " MiB)",
> > +                   filename, max_sz / MiB);
>
> MiB is arbitrary here. This function is used to load all kinds of images
> such as ROMs which may be 64k-2MB or even executables in generic loader
> that can be a few kilobytes. This might result in errors saying max size
> is 0 MiB if the allowed size is less than a MiB (e.g. amigaone PROM_SIZE =
> 512 KiB) and integer division discards fractions. Do we have a function to
> pretty print sizes or maybe this should be left as bytes or at most
> kilobytes?

Yes, we have size_to_str() for this purpose.

thanks
-- PMM

