Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0165EEED613
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 15:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1solWo-0004Zc-A4; Thu, 12 Sep 2024 11:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1solWm-0004Yz-6q
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 11:14:36 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1solWk-0002F7-8q
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 11:14:35 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f75c205e4aso13446921fa.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726154072; x=1726758872; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6YbNKbLEEV6GXJyOor5pZ7T3TCUvobFoRllN/rySyFc=;
 b=NMJ5csVHGJ1EX1rB1xnCftkzkaHyqIr6IYmFxRZ4Oly5pt3tMDPCl/f0E9CS+8jd5m
 3Ppy8oS5SeA7oVf6JhsUH3RU3FsJ6QsBS5jl4eY/nbzM5wBp1+C7FK/UKw3TLXwlTJ7J
 huSpnvZoW8h5r2ns130B+PF8baS1S1Rjyx4zdCbx31X987r4gVXkWK5oO9LVOludCVjS
 VBwbAx8oKou44B7M6Wtj5STYGOwxxTfsxDcfi7Dtlhwh/SSMSZ+aCxm0Z+aR+6BpLqhO
 t78Fn4EyGLN6wLxnrKMf7fY9qwoDevRASCY0QUD2FjKRsSxGGCvWmP5WrqhYs/+CPsNg
 mWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726154072; x=1726758872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6YbNKbLEEV6GXJyOor5pZ7T3TCUvobFoRllN/rySyFc=;
 b=wrws7oKuTs7xwz4omTxkqGUPa3C8wmu8xcvnU/7Wf/7cmevoSdloPnxAdh/giEWhc0
 jG0gD5j0ANDSoBM0uirfwPqwNOFOAQF2xM68kSNBFUH7NPsfRwZ213WjVZfWFYX8HuPK
 Zz4qXaWF2xvEz6PSbNUBAaxwgJk0lU81ga4xmZr6mN59X/CvE1fauDmage+EJuOWEbdJ
 uqCYZx2rx4ghkz9mnrx0Y3M+/x1J6fKJKjAaBylldOHur81gHMYzuU0+/CBMH2PSeg1i
 Qhb0/DKUaSD9bMYjFjc47wXn5Ap/4ATVIQw6PhtVqmyY+vor0Zyr9vxqtD8td/1Z3rtO
 jwkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGWJlZqF5FRbBuD82NMk17gJSJRy9gKB+0GwkjEdZkm5GN8AHpU1Gm/p19kIQbWzKYLfqtwOKZxB0E@nongnu.org
X-Gm-Message-State: AOJu0YwqYv0J7YMTN+gBwZAP+760A7H4iEj02K/dg6/ByAXmUUzT49ax
 1c2Cw2dHY6JxKnvrUZVCmw/10y601/6ulOF/f7zRq8DNrkscVHhz9tuCxZ9LEO9IB5eXNDSFmE3
 2Sl5nzB9FPZuiV01bpkMParaspD4cQDzlWstn2w==
X-Google-Smtp-Source: AGHT+IE6zhyNEsHXk2iZCDz3qMvrUcUW6ZwOwEAw3Y2r7Roiqgjxb0ZHa73QLvSN66PS/6g+HtTfGyc9tJlSkLlYTCc=
X-Received: by 2002:a05:6512:15a9:b0:536:554a:24c2 with SMTP id
 2adb3069b0e04-53678fb6adbmr2127272e87.13.1726154071800; Thu, 12 Sep 2024
 08:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
 <Zt8H6pC2yQ2DD7DV@x1n> <87frq8lcgp.fsf@suse.de> <ZuC4pYT-atQwWePv@x1n>
 <87seu7qhao.fsf@suse.de> <ZuG-SijLg8Q27boE@x1n> <87ed5qq8e2.fsf@suse.de>
 <ZuH_pvnTCumKuXTh@x1n> <87bk0trifq.fsf@suse.de>
 <CAFEAcA9YkZiSSOAj0zH2OwF9AcziJT-zpnNVQn8BXizhSXHVOA@mail.gmail.com>
 <ZuMEF99PF0q0U9G-@x1n>
In-Reply-To: <ZuMEF99PF0q0U9G-@x1n>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2024 16:14:20 +0100
Message-ID: <CAFEAcA9Bevk6Go_AgvjAhzyE-P_u6W0JS8deau09cU5zrPJkgg@mail.gmail.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Hyman Huang <yong.huang@smartx.com>,
 qemu-devel@nongnu.org, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Thu, 12 Sept 2024 at 16:09, Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 12, 2024 at 09:13:16AM +0100, Peter Maydell wrote:
> > On Wed, 11 Sept 2024 at 22:26, Fabiano Rosas <farosas@suse.de> wrote:
> > > I don't think we're discussing total CI time at this point, so the math
> > > doesn't really add up. We're not looking into making the CI finish
> > > faster. We're looking into making migration-test finish faster. That
> > > would reduce timeouts in CI, speed-up make check and reduce the chance
> > > of random race conditions* affecting other people/staging runs.
> >
> > Right. The reason migration-test appears on my radar is because
> > it is very frequently the thing that shows up as "this sometimes
> > just fails or just times out and if you hit retry it goes away
> > again". That might not be migration-test's fault specifically,
> > because those retries tend to be certain CI configs (s390,
> > the i686-tci one), and I have some theories about what might be
> > causing it (e.g. build system runs 4 migration-tests in parallel,
> > which means 8 QEMU processes which is too many for the number
> > of host CPUs). But right now I look at CI job failures and my reaction
> > is "oh, it's the migration-test failing yet again" :-(
> >
> > For some examples from this week:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/7802183144
> > https://gitlab.com/qemu-project/qemu/-/jobs/7799842373  <--------[1]
> > https://gitlab.com/qemu-project/qemu/-/jobs/7786579152  <--------[2]
> > https://gitlab.com/qemu-project/qemu/-/jobs/7786579155
>
> Ah right, the TIMEOUT is unfortunate, especially if tests can be run in
> parallel.  It indeed sounds like no good way to finally solve.. I don't
> also see how speeding up / reducing tests in migration test would help, as
> that's (from some degree..) is the same as tuning the timeout value bigger.
> When the tests are less it'll fit into 480s window, but maybe it's too
> quick now we wonder whether we should shrink it to e.g. 90s, but then it
> can timeout again when on a busy host with less capability of concurrency.

For the TIMEOUT part on cross-i686-tci I plan to try this patch:
https://patchew.org/QEMU/20240912151003.2045031-1-peter.maydell@linaro.org/
which makes 'make check' single-threaded; that will help to see
if the parallelism is a problem. (If it is then we might want
to do a more generalised approach rather than just for that one
CI job.)

> But indeed there're two ERRORs ([1,2] above)..  I collected some more info
> here before the log expires:

> So.. it's the same test (multifd/tcp/plain/cancel) that is failing on
> different host / arch being tested.  What is more weird is the two failures
> are different, the 2nd failure throw out a TLS error even though the test
> doesn't yet have tls involved.
>
> Fabiano, is this the issue you're looking at?
>
> Peter, do you think it'll be helpful if we temporarily mark this test as
> "slow" too so it's not run in CI (so we still run it ourselves when prepare
> migration PR, with the hope that it can reproduce)?

If you think that specific test is flaky then I think that's
probably a good idea. As usual with this kind of thing,
probably best to have a comment next to the test noting
why and with a URL to a gitlab issue for it, so we don't
forget why we disabled the test.

-- PMM

