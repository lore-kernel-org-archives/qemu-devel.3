Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17442C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUloi-0005dt-SO; Tue, 30 Jan 2024 05:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUlob-0005aF-8d
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:58:06 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUloX-0006Gj-Il
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:58:03 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55f13b682d4so2443569a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706612279; x=1707217079; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6yw3m2J22M7Trjrlz6yziszgg0bgLk9hMVWenJKOVWM=;
 b=j/LLMJ1Xy4APRWjKunnj6QhXqN5T49aj5C4CFROQ92sWJHKa+5FuW67XKT7IjYAHOD
 hBimrVsA9S76spEFI1QBfATpkQblpii39qcvAci8vK0//FNzSZMga8FbjYcoU7hXda1d
 NY+/ybj/HdqLMHzA94FJ2S5Xq9kEy0xD90fPrz9eNgc47r+ddiqwv0EgBg0vnHl+KX6x
 o9FpeBTOfFUTfnNWOd6pQJSkbuU1Dl9clC7Urck1uU8p5IMhH93TeyrXMnRNV5brk+BE
 Q7RRkgxvx8YBGnrLhEud1LTT2djerN/OcQLDlBUNUuqz0mFmuAv22i4HJl2CAWxYw+Mg
 ya+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706612279; x=1707217079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6yw3m2J22M7Trjrlz6yziszgg0bgLk9hMVWenJKOVWM=;
 b=DUsHpSKQNci/nUM4uDMlSz6/wcLOHeXUxwT1L3set2PDo1FCNbB9q1ZqHsF3egEJL5
 p1OHLIJUxhT2VPJXpIWX/goBYaXRCYSlVJMKEZVd2qd+mXhkj33K22zTKG6Joub5nPbm
 11Ga9W41O6QJ1ZGPGf0ljk2ONe0hJZyZMIsHM6waZEOgnVSa7CHF1sey+J4eh7iTEHRJ
 0uKQBDulbwsvyD34RU1eHztMuhTbAY3WupSZ8VLCqNWt1YS0i4F+wvgWhNqnh0qqqgF8
 reHM0yi5jHFH1OgRxreWyyHZ6FoTUKm2qRBy0qpj+kljH8LIjizNRN0cjpO71OeECgJv
 +jgg==
X-Gm-Message-State: AOJu0Yz7wE96AixK0rddOOWjvKtB2O1REHavIgkGUJ1qeCMqmmleEl74
 IGLI3k5PmC/Pea/eM4mnKNvVaMM8/wtq26CCaiVWKfQc64YDd1Nf9/E1Q8EG9Db64HxEvlGv3wA
 AgIsBTlDOJKPHSN0Vdgq1/HgWrpYLy4nEmPGJIQ==
X-Google-Smtp-Source: AGHT+IGPhSfBIx6rJArSsCEk4/zMyXlZpGFSE5h3vpkooOpdlnKMLhTmmYOjISouZpex0SYFfRzuGcFzQyYnIIoNvho=
X-Received: by 2002:aa7:da0d:0:b0:55f:ed:27e8 with SMTP id
 r13-20020aa7da0d000000b0055f00ed27e8mr3556334eds.30.1706612279200; 
 Tue, 30 Jan 2024 02:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA8P-8rRRQJLEFzwVJiKqdd-cu5DgiBdxBXYhq=2Oov9Fg@mail.gmail.com>
 <CAAjaMXYbm4ANhMEXOc35mJkq7Zr+A_vz8wBY+tPv4rk=dCQEaA@mail.gmail.com>
 <CAFEAcA_XX07ND82_ZrokBhVDbTot16_SNJNQDQeNnBvRZ4MHkw@mail.gmail.com>
 <CAAjaMXZsAHQYSotdn0f_3iao=sW3XRiA5iMQO1MMFnVj0cft_w@mail.gmail.com>
In-Reply-To: <CAAjaMXZsAHQYSotdn0f_3iao=sW3XRiA5iMQO1MMFnVj0cft_w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2024 10:57:47 +0000
Message-ID: <CAFEAcA-qa729wTz99fW6ur+FYjkmUjTkjd8eG_dNo7fSzYh_rw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 30 Jan 2024 at 10:51, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Tue, 30 Jan 2024 at 12:42, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 30 Jan 2024 at 10:39, Manos Pitsidianakis
> > <manos.pitsidianakis@linaro.org> wrote:
> > >
> > > On Tue, 30 Jan 2024 at 12:34, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > >
> > > > On Tue, 30 Jan 2024 at 10:11, Manos Pitsidianakis
> > > > <manos.pitsidianakis@linaro.org> wrote:
> > > > >
> > > > > Check if a file argument is a cover letter patch produced by
> > > > > git-format-patch --cover-letter; It is initialized with subject suffix "
> > > > > *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
> > > > > exist, warn the user.
> > > >
> > > > FWIW, as far as I can see from my email archive, this particular
> > > > mistake has been made by contributors to qemu-devel perhaps
> > > > half a dozen times at most in the last decade...
> > > >
> > > > thanks
> > > > -- PMM
> > >
> > > Peter, searching for `b:"BLURB HERE"` in lore.kernel.org yields about
> > > 170 results including these patches.
> > >
> > > https://lore.kernel.org/qemu-devel/?q=b%3A%22BLURB+HERE%22
> >
> > Yes, there's a few more 'blurb here' results than 'subject here'
> > results, but they're almost always just where the submitter did
> > provide a proper blurb but then forgot to delete the 'BLURB HERE'
> > line, rather than where there's no blurb at all.
>
> Though you said half a dozen times at most.

Yes, because I was counting 'subject here'.

My question here is really "how much do we care about having
checkpatch point out this error?".

thanks
-- PMM

