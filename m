Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F368C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlsw-0001CZ-Qc; Tue, 30 Jan 2024 06:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUlsu-0001CN-78
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:02:32 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUlsr-0007py-BH
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:02:31 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d043160cd1so25962981fa.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706612545; x=1707217345; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wOSWdDHiLKoLnultCId7x3ld088ShR7cGizs6XpJRQg=;
 b=M4OKoF4Q3mXgFQQndL0I0Y3/BeByvJfjcX10fjI6JTtXX7PXSXhjUb7dpW1Nmd7YgU
 QEBe19na0vYfMvzZgpiN1iSF0FhseJ5z3iq367mU8fFFup1dV2DcWu4aT3gZapvUy+Gy
 UOO3WxRm1G+3t4VOK5r83T2OPWXvffDaJ/sm5s7t/BkKeBm1M5w4KqmEbRGGIIr6klwG
 hG4tIaiI0G+4Ou8OI1ufCysXfw8e/DBIpqt9zIKuYvh+eoymXibvemXBHgYIPZWFJ2A+
 4gCcA5DjYw00dxWORfUvmBmfL7v0oH7IQ769af6ynflnu1+R//5N9+pEOfyBsIX+Zysn
 vtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706612545; x=1707217345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wOSWdDHiLKoLnultCId7x3ld088ShR7cGizs6XpJRQg=;
 b=ABRpMtuyqVZwAOpUZ0bIztezMwX1+Vt4/5hUsJh0d8KBThEBYyX7YktLTMqksv3Vys
 ZLaXWPC5N5bVSzsoDfVa0d/i0bnTuqKvkKOdNjqUxaJ/TjQlY7huepPKclYfE+kil5tL
 /sS/jvYfxHG+eYE8eUBg8TQc9HiymW9jpyNB4FnDli7FQaDcdWE38JAkDHNuboLQt4Nu
 HfPsbOnfH1AN94fvLF0jjX/lUgVR3RZF0kzGyBj8MdpDPNkhVljbAuhJ/Uz25G/h61It
 Oo4ZTh/72dTJaKy4xzpFm5xfz+QzakyvwbbWfNa5mL4mkJkXB+TFBh8N2jKMSLe6dKwO
 NwJw==
X-Gm-Message-State: AOJu0YyB7i1lHA3o4GdftkTZznr0GPm2WJmgdqbhA0rqWWEj0m2yVI6J
 Vz0CLMoS6pxd3gqktAhn49Sk3BberJ4Zy03lcrcHqcCW5pRyts2QJH6zDN+0HMZk22uDGJhiUmK
 apKbFCe+0E7WmWJJpg10Vpa4apoLo93aufp+5+w==
X-Google-Smtp-Source: AGHT+IFHYY35s16dBNd08NFONKIbOke5fb90r7isoXTK/byJGefwhUx39NagCZTF40LrlkgtrnUDVIU7w7nVKCyGWXU=
X-Received: by 2002:a2e:9688:0:b0:2d0:5101:2bbb with SMTP id
 q8-20020a2e9688000000b002d051012bbbmr2751894lji.23.1706612545132; Tue, 30 Jan
 2024 03:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA8P-8rRRQJLEFzwVJiKqdd-cu5DgiBdxBXYhq=2Oov9Fg@mail.gmail.com>
 <CAAjaMXYbm4ANhMEXOc35mJkq7Zr+A_vz8wBY+tPv4rk=dCQEaA@mail.gmail.com>
 <CAFEAcA_XX07ND82_ZrokBhVDbTot16_SNJNQDQeNnBvRZ4MHkw@mail.gmail.com>
 <CAAjaMXZsAHQYSotdn0f_3iao=sW3XRiA5iMQO1MMFnVj0cft_w@mail.gmail.com>
 <CAFEAcA-qa729wTz99fW6ur+FYjkmUjTkjd8eG_dNo7fSzYh_rw@mail.gmail.com>
In-Reply-To: <CAFEAcA-qa729wTz99fW6ur+FYjkmUjTkjd8eG_dNo7fSzYh_rw@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 30 Jan 2024 13:02:09 +0200
Message-ID: <CAAjaMXZYLCaXK5otq9iC=-D4RrjkcLDrgjhWhWnJDqwJwwfWhw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x229.google.com
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

On Tue, 30 Jan 2024 at 12:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 30 Jan 2024 at 10:51, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > On Tue, 30 Jan 2024 at 12:42, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Tue, 30 Jan 2024 at 10:39, Manos Pitsidianakis
> > > <manos.pitsidianakis@linaro.org> wrote:
> > > >
> > > > On Tue, 30 Jan 2024 at 12:34, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > > >
> > > > > On Tue, 30 Jan 2024 at 10:11, Manos Pitsidianakis
> > > > > <manos.pitsidianakis@linaro.org> wrote:
> > > > > >
> > > > > > Check if a file argument is a cover letter patch produced by
> > > > > > git-format-patch --cover-letter; It is initialized with subject suffix "
> > > > > > *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
> > > > > > exist, warn the user.
> > > > >
> > > > > FWIW, as far as I can see from my email archive, this particular
> > > > > mistake has been made by contributors to qemu-devel perhaps
> > > > > half a dozen times at most in the last decade...
> > > > >
> > > > > thanks
> > > > > -- PMM
> > > >
> > > > Peter, searching for `b:"BLURB HERE"` in lore.kernel.org yields about
> > > > 170 results including these patches.
> > > >
> > > > https://lore.kernel.org/qemu-devel/?q=b%3A%22BLURB+HERE%22
> > >
> > > Yes, there's a few more 'blurb here' results than 'subject here'
> > > results, but they're almost always just where the submitter did
> > > provide a proper blurb but then forgot to delete the 'BLURB HERE'
> > > line, rather than where there's no blurb at all.
> >
> > Though you said half a dozen times at most.
>
> Yes, because I was counting 'subject here'.
>
> My question here is really "how much do we care about having
> checkpatch point out this error?".
>
> thanks
> -- PMM

I do, because it gives some peace of mind. But I do not care so much
that I'd want to continue this conversation further.

-- 
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

