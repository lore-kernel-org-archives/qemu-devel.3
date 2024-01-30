Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFBAC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUliN-0004M0-Gq; Tue, 30 Jan 2024 05:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUliK-0004Jy-Jk
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:51:36 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUliI-00053t-QJ
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:51:36 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so4846508a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706611893; x=1707216693; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IucSWh5A6xi5WitKNrHO/upJe9xz/rJLvSGwccrSDwI=;
 b=rXfqXq5p0thEdtwzKLL+06yLI0gmmX9rWDRs2yD7HKFriGZW8casTmP5pniRdqGgTQ
 +4PKo8kH+hOjVqJO6SAR0nPBTWl38UfcQhsugB/uFkBtXQ3P1C7wrg1l+RJL1w2fwPh4
 IPR191JJyenM+4xqZPdB8ll3BLMupRrHcM911eXpzfuN89iPNh5gf3yqCxZ360trrn0y
 JmdUQhFUdu2AtRW8I/Pi0wzGQ8hJydakt6hyFf6fpO+DC2DEUta7kYcqxIwGjBqhcIMO
 SLDeJfjsNLmpRdKuD3ZkTKH8QU0GNGvix6ARQxJDEpcMxmVxT4lgsGJai96/58i0F+R8
 BOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706611893; x=1707216693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IucSWh5A6xi5WitKNrHO/upJe9xz/rJLvSGwccrSDwI=;
 b=SSVql5a5ewrkG1L9vkL5Nm6CfHCwgrcKnOP5WjKKTD3lC6kYJ0Dq3mTRnO7d9fzf3V
 9/dqmGS9L3OJLbClC45VVr+F0yqORKXyVV59bobcWudh4Snhdg0LveB3EnJ5xiWTsx+O
 +7NM498s/vb+YLW5zcnCGfNzwTi22ylvHmlpx0n5OyITjhmE5Y76gxSE5CEo3jdk1cEu
 CdQczawaE3oHKENDtqvmzsAxi/28q6Tfvc8bihTx6twm2swPrmk4iXC57TqVtbLFMLAr
 w9wxTVe7K4ZKur3MPIr+AXEITGslJusttlmoxHSfRb4zPd/sIEmi1uVOGfATEVZ05mqX
 kqjg==
X-Gm-Message-State: AOJu0Yz+YbcY2wfiMA/nDQScxNzd6WuSrqvPDLz4HDP6kZmLqer2CAHk
 h1ObrlWiFvJMVz7rWJR0+Sq4Dd3L3Kqya0JPwofzUiN+JM6238ERwr6svat6pPdXBYp2k9/I1F+
 gvGeNRk8tVIWhpSGg/5idZxkAKWVVE+cVjdm1Kg==
X-Google-Smtp-Source: AGHT+IFNc5FnfAJDl0Yu70Sl/ngKPK6dlBL6c5s14UE0yCNn8jDWp1e2elilzc/O3LwjaXYfpr+VqAoYvUk6+pJ1ypg=
X-Received: by 2002:a05:6402:2712:b0:55f:4ac3:c47f with SMTP id
 y18-20020a056402271200b0055f4ac3c47fmr729103edd.10.1706611892940; Tue, 30 Jan
 2024 02:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA8P-8rRRQJLEFzwVJiKqdd-cu5DgiBdxBXYhq=2Oov9Fg@mail.gmail.com>
 <CAAjaMXYbm4ANhMEXOc35mJkq7Zr+A_vz8wBY+tPv4rk=dCQEaA@mail.gmail.com>
 <CAFEAcA_XX07ND82_ZrokBhVDbTot16_SNJNQDQeNnBvRZ4MHkw@mail.gmail.com>
In-Reply-To: <CAFEAcA_XX07ND82_ZrokBhVDbTot16_SNJNQDQeNnBvRZ4MHkw@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 30 Jan 2024 12:51:16 +0200
Message-ID: <CAAjaMXZsAHQYSotdn0f_3iao=sW3XRiA5iMQO1MMFnVj0cft_w@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 30 Jan 2024 at 12:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 30 Jan 2024 at 10:39, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > On Tue, 30 Jan 2024 at 12:34, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Tue, 30 Jan 2024 at 10:11, Manos Pitsidianakis
> > > <manos.pitsidianakis@linaro.org> wrote:
> > > >
> > > > Check if a file argument is a cover letter patch produced by
> > > > git-format-patch --cover-letter; It is initialized with subject suffix "
> > > > *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
> > > > exist, warn the user.
> > >
> > > FWIW, as far as I can see from my email archive, this particular
> > > mistake has been made by contributors to qemu-devel perhaps
> > > half a dozen times at most in the last decade...
> > >
> > > thanks
> > > -- PMM
> >
> > Peter, searching for `b:"BLURB HERE"` in lore.kernel.org yields about
> > 170 results including these patches.
> >
> > https://lore.kernel.org/qemu-devel/?q=b%3A%22BLURB+HERE%22
>
> Yes, there's a few more 'blurb here' results than 'subject here'
> results, but they're almost always just where the submitter did
> provide a proper blurb but then forgot to delete the 'BLURB HERE'
> line, rather than where there's no blurb at all.

Though you said half a dozen times at most.

In general the only comments so far are examples of "moving the
goalposts" fallacy, where the argument changes each time and the
discussion changes topic every time.

https://en.wikipedia.org/wiki/Moving_the_goalposts

I know it's not anyone's intention in this case, but I'd like to
remind everyone that this can be perceived negatively by contributors
and demotivate them from contributing to QEMU at all. Let's keep the
discussion constructive instead of dismissive. I say this in a
completely friendly manner, no negativity intended.

Manos

