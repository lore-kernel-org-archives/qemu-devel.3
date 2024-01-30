Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96614C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmK0-0005hd-Uq; Tue, 30 Jan 2024 06:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUmJx-0005fn-S1
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:30:29 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUmJo-0005F0-9H
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:30:29 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55f19a3ca7aso2582027a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706614218; x=1707219018; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJ4BNNQ/12Mbxx5pW9kipjNrOcVbSd5ZkJpUoXTBJqA=;
 b=A/HG4NMWEWqLtJH1y8rFAVreiMWDHPNZ0Ocy2SCace0o2tGE5YafDAkdRbiScXpWLk
 AE/LKsHX8i2BfxDWgmYqFXv2o2Pb13IgCAtcWqzLDkTZZ9OY0UAktjeq+SgMzp9byUTe
 TVdy6zUGB8ik8akGpqnOCYLXaNLmFXl1HlWYxP+q1nq7phIU8/nZ6nlHFqrP0GO1YsJT
 JpWGFZTQTTwjjqtRm6qv8osCM/cwVQlihH1QCk+2zSFetmrSxM/Q6ToL/3Qg/PKe0hRw
 zHPShT0Ggah4mJ17ByCvUdT630pmAKW3khWwZdp92e4Q0SQeUpXsKk9VnoJ2FoCABm1I
 vE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706614218; x=1707219018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJ4BNNQ/12Mbxx5pW9kipjNrOcVbSd5ZkJpUoXTBJqA=;
 b=LlIGId4CYoJVeoBZD5399+DN5Te/maVPOEOhgojBb7Z+XzYAY45RqI2p+Sm//GRSob
 1wSwVYnMA0STx+CKDd6sF3lM2IhsVy4kf8Z9xLaK4CHcEyKX07h3v5HgEK8vwiJzXShI
 22YYGdiwNB+buF0TQp3V1U/C1YpKfyHpEwuRsv8qcs8Jg3HR9q8lPc/PZb/fiweGNO8m
 FCu7EZk03ZR8wQvQI+zaqwG3BR2aqrSyT5vbukzccoNSupKeamnU9+r8ROP6Q95LopoP
 OzdX9dmXDdjVFsjuvqsZJnS8X72vyNVn9/RbcZo7ZpZHVZaK4ojrsVIUCLJsO2aIklt8
 UIqg==
X-Gm-Message-State: AOJu0YwHeyDgHGxlKkc4haHP+02YZyEakN2QMCCoIKF0OCpSSQ6jqE55
 eDRsoZGU7GmIdelFAnXunrLKKYWBMKTuWcp6NJvPYKbgcfdweUj9HgKVwbit1uRfNtPaaruvIa0
 hAsF9X/tqRLwA7xqA4e7IM29w19ksL4vVytUx/w==
X-Google-Smtp-Source: AGHT+IH+WdeJUs/eDAP6u+h2P+alQv5VbVlp4uftzkwINAkFcC8dCHAK5Wq+awfXoyHyfmqQ9EPKb+Uj75EK+xTTje4=
X-Received: by 2002:a05:6402:1d23:b0:55f:4d6a:c0ee with SMTP id
 dh3-20020a0564021d2300b0055f4d6ac0eemr643484edb.7.1706614218529; Tue, 30 Jan
 2024 03:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA8P-8rRRQJLEFzwVJiKqdd-cu5DgiBdxBXYhq=2Oov9Fg@mail.gmail.com>
 <CAAjaMXYbm4ANhMEXOc35mJkq7Zr+A_vz8wBY+tPv4rk=dCQEaA@mail.gmail.com>
 <CAFEAcA_XX07ND82_ZrokBhVDbTot16_SNJNQDQeNnBvRZ4MHkw@mail.gmail.com>
 <CAAjaMXZsAHQYSotdn0f_3iao=sW3XRiA5iMQO1MMFnVj0cft_w@mail.gmail.com>
 <CAFEAcA-qa729wTz99fW6ur+FYjkmUjTkjd8eG_dNo7fSzYh_rw@mail.gmail.com>
 <CAAjaMXZYLCaXK5otq9iC=-D4RrjkcLDrgjhWhWnJDqwJwwfWhw@mail.gmail.com>
 <a353c5db-4583-4662-bf28-4332d51e9d30@linaro.org>
In-Reply-To: <a353c5db-4583-4662-bf28-4332d51e9d30@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2024 11:30:07 +0000
Message-ID: <CAFEAcA907EzOaPEhs_ZTpmBZeCHiY2n6ncgzbixhcK4VMnQ30g@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 30 Jan 2024 at 11:24, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Manos,
>
> On 30/1/24 12:02, Manos Pitsidianakis wrote:
> > On Tue, 30 Jan 2024 at 12:57, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >>
> >> On Tue, 30 Jan 2024 at 10:51, Manos Pitsidianakis
> >> <manos.pitsidianakis@linaro.org> wrote:
> >>>
> >>> On Tue, 30 Jan 2024 at 12:42, Peter Maydell <peter.maydell@linaro.org=
> wrote:
> >>>>
> >>>> On Tue, 30 Jan 2024 at 10:39, Manos Pitsidianakis
> >>>> <manos.pitsidianakis@linaro.org> wrote:
> >>>>>
> >>>>> On Tue, 30 Jan 2024 at 12:34, Peter Maydell <peter.maydell@linaro.o=
rg> wrote:
> >>>>>>
> >>>>>> On Tue, 30 Jan 2024 at 10:11, Manos Pitsidianakis
> >>>>>> <manos.pitsidianakis@linaro.org> wrote:
> >>>>>>>
> >>>>>>> Check if a file argument is a cover letter patch produced by
> >>>>>>> git-format-patch --cover-letter; It is initialized with subject s=
uffix "
> >>>>>>> *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If t=
hey
> >>>>>>> exist, warn the user.
> >>>>>>
> >>>>>> FWIW, as far as I can see from my email archive, this particular
> >>>>>> mistake has been made by contributors to qemu-devel perhaps
> >>>>>> half a dozen times at most in the last decade...
> >>>>>>
> >>>>>> thanks
> >>>>>> -- PMM
> >>>>>
> >>>>> Peter, searching for `b:"BLURB HERE"` in lore.kernel.org yields abo=
ut
> >>>>> 170 results including these patches.
> >>>>>
> >>>>> https://lore.kernel.org/qemu-devel/?q=3Db%3A%22BLURB+HERE%22
>
> This comment is the default --blurb-template from git-publish:
> https://github.com/stefanha/git-publish/blob/master/git-publish#L742
> As the tool is also used to post patches to other projects, I'd
> recommend fixing it there at the source.

It's also in the general 'git format-patch' cover letter template,
where the workflow is supposed to be "produce cover letter template,
manually edit it, send it". Stray template markers generally are
the result of (a) a new contributor not knowing about the 'edit'
step or (b) remembering to add the subject and blurb but forgetting
to delete the 'blurb' template line so it gets left in at the
bottom of the cover letter. So I think it is a check that is within
checkpatch.pl's remit.

thanks
-- PMM

