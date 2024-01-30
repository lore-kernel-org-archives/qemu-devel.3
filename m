Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC792C48285
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUla7-00006E-Q4; Tue, 30 Jan 2024 05:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUlZy-0008TT-Ks
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:42:59 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUlZw-0002q1-Sl
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:42:58 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55f0367b15fso2462443a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706611375; x=1707216175; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WKsAKeaUem+pYbX25AJVejlbx3Y1JGPDoxVeDL4qbb8=;
 b=fihVBaYOJ3B9FRafWO11ca6q9e2uu1D4ATdUVycWZcihKMcpRp2d1/M9v/P067yKrx
 45GsRTybfd0tRxnlFrQ04IQRnEy7tVzw9iOIYpRB5Q/9ZHJY5vL+2TXb7Srx9yUuoX96
 RX3UPDmgdsrvBJ1KGrkf34zCzLuCvfSf0fBtvKuBXYXGKB40Q+2v/tsbbIJrVblG3piu
 mLq6jGySDG3suTnd7NRo8jyPXesUCnUP5iCXpLbazOhIe+RlD/oRVSIqvKBdBypJ9T88
 2UIdpeDnfE//e/ySkhswux5eAaZW9cy/hoIV33brPb8LisY3LbInTlOkxH9KO0ZaaSJ6
 Et3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706611375; x=1707216175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WKsAKeaUem+pYbX25AJVejlbx3Y1JGPDoxVeDL4qbb8=;
 b=TC4fSzlonZuEescOyeB+4gQZJD6XDAPwincmnAvBRsnBOMDNnWorMZcFN6ApcfrBzr
 m/ImJnTsatmwjl2jUYm3pxe65JSD//+eMp9czFRwoBwfzT4kP/ptqnMi61Qhm3kv8TEB
 Tj9d6Zcfb+PsjB4QMm3YywPPtFTNYbypEa5WRu7dWX7Ys+jiTHyCd8IlZFKvKFVk9rsZ
 qXKapi97VIkb401EtFpsZEBCflKue/yAmbSldhTrc83e2jMUlGNV8UrvtDc+/XfEk+Mk
 PnHrYfOxygxVp/HAllMCSCsg4jp7wVh70zqyfiD+lCmVnVbuiiZF14AkApRGv9UPnIZs
 R99w==
X-Gm-Message-State: AOJu0YxVx8Qgtr1+pnrWIbwzd9kubkFxdMvL1l6wn+mKUto+X91AF5Fs
 ngLVKxeDIabcFr6E9GIxwS9JtoBUgXWieFajklhxh7hHxX/iyPeDB0mwJ4yP5BvQv/D7rT5O+DJ
 FEs1e18I4bSBlOwAsLFVwGEfKGidzn5RPJlIgdg==
X-Google-Smtp-Source: AGHT+IFqbvMFFFkFIZp92LTb15iYbJWAXjxNHVq9BGnIXvRjU3vshsOSdpe5IOlTauFGfxpsa656nQlUKwwQwidvdN0=
X-Received: by 2002:aa7:d049:0:b0:55f:3cb:9c33 with SMTP id
 n9-20020aa7d049000000b0055f03cb9c33mr3449985edo.31.1706611375183; Tue, 30 Jan
 2024 02:42:55 -0800 (PST)
MIME-Version: 1.0
References: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA8P-8rRRQJLEFzwVJiKqdd-cu5DgiBdxBXYhq=2Oov9Fg@mail.gmail.com>
 <CAAjaMXYbm4ANhMEXOc35mJkq7Zr+A_vz8wBY+tPv4rk=dCQEaA@mail.gmail.com>
In-Reply-To: <CAAjaMXYbm4ANhMEXOc35mJkq7Zr+A_vz8wBY+tPv4rk=dCQEaA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2024 10:42:44 +0000
Message-ID: <CAFEAcA_XX07ND82_ZrokBhVDbTot16_SNJNQDQeNnBvRZ4MHkw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Tue, 30 Jan 2024 at 10:39, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Tue, 30 Jan 2024 at 12:34, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 30 Jan 2024 at 10:11, Manos Pitsidianakis
> > <manos.pitsidianakis@linaro.org> wrote:
> > >
> > > Check if a file argument is a cover letter patch produced by
> > > git-format-patch --cover-letter; It is initialized with subject suffix "
> > > *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
> > > exist, warn the user.
> >
> > FWIW, as far as I can see from my email archive, this particular
> > mistake has been made by contributors to qemu-devel perhaps
> > half a dozen times at most in the last decade...
> >
> > thanks
> > -- PMM
>
> Peter, searching for `b:"BLURB HERE"` in lore.kernel.org yields about
> 170 results including these patches.
>
> https://lore.kernel.org/qemu-devel/?q=b%3A%22BLURB+HERE%22

Yes, there's a few more 'blurb here' results than 'subject here'
results, but they're almost always just where the submitter did
provide a proper blurb but then forgot to delete the 'BLURB HERE'
line, rather than where there's no blurb at all.

thanks
-- PMM

