Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0226FEE645D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soexL-0000Bv-BO; Thu, 12 Sep 2024 04:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soexI-0008Rc-9Z
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:13:33 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soexG-00052Z-BG
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:13:31 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5365b6bd901so711227e87.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726128808; x=1726733608; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=usAsBYht60fCTrH3jImZtclikoSTZQO9jDwJme+lkyk=;
 b=i+uvn77uIuVUfcfdCsJ+LunqyKZ8shtWjT9cgc3ZrH/y8ruL/slYFYTCwwugZ1LDIS
 oVDkqSd/5pqoDbsYFEuu04TMP7euAX2yl/RKD+C0g3zwcIq0RL2f2BBrPXqm6KhJsH/n
 kCrL6KXT0mKyNPtkwAm1ILdEXe+D7uLZkXdCRfGKucNv/09XV0HupBMdBaxxms1BofJx
 ikljO9kPZMvgWseRm++T/Eg33BcDt5B9ZW8jFZ7JcfJFF3q5S+ZwMkI5MNEODh+Z6ROE
 ZzsI4bCmNRAdjUerYs5/0KpG5f4KEn7nOoSsvxZoSsb+vh9juSnKiSef5Cm8ZLXIbSh+
 KW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726128808; x=1726733608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=usAsBYht60fCTrH3jImZtclikoSTZQO9jDwJme+lkyk=;
 b=vevlykacf2pQf/zDRP2XIsuxhbqfwNJbUCMevfxqE2UI8fn+5RTQxSasL9kRnn32MA
 mErYZqdq9SjMnWFoP75nmkW1MNDJWoad/7C2ZpffEOm1VFcn58PKZplCYLe8NqLWsdIp
 5ZZp7n0DlL23mlxx4kbW2lWG9ArQ5JjFPZKNutW25ooqwatc1PwUpCQt+0Dtr42kbayr
 NQ6VfIERzP3v3BWhv97e2CzrEFtlXuucek+vRng+4k2gOejWL7s5M5Di0e7BSWc1Lhc4
 L3RAgzNAvUrAuGxnAmKJD+ybJ0ytDyYgPcMxS3ah5P2AG2wogpTf3yeEY7z0CYumdwMs
 quyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtJ/tK8J62ZSZ00Z1OdVZjH1B75eDXK/zokS7KqRKsVObQhEVtmc9T1f6zeYsyzSjShCdcxjLC9wZ4@nongnu.org
X-Gm-Message-State: AOJu0Yy/OY/cuELigsBDgnmKPkIBwxE01nTo/ULlBihZT+ynKnoTDOav
 JzCf4ZwrfNPb9Pl8NrnDAAyr/aF1blGhOKgfKYi2knjq8ojk3qfjJVnYOgByL3CIkOgWuGlD5Fi
 p4AOAxgItvgkmPdGthJv9uyN/4BvnA5cGcd0o6g==
X-Google-Smtp-Source: AGHT+IG480IggDEdbp2yMXkPASY9GIbC0xQ0wBOQ1Gb6eCvBXVhCy7fTFUVbN7itmHCzwh4FabkCv5OncPsRxAN5QKE=
X-Received: by 2002:a05:6512:10ce:b0:533:3fc8:43ee with SMTP id
 2adb3069b0e04-53678fba1f0mr1025968e87.13.1726128807347; Thu, 12 Sep 2024
 01:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725889277.git.yong.huang@smartx.com>
 <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
 <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
 <Zt8H6pC2yQ2DD7DV@x1n> <87frq8lcgp.fsf@suse.de> <ZuC4pYT-atQwWePv@x1n>
 <87seu7qhao.fsf@suse.de> <ZuG-SijLg8Q27boE@x1n> <87ed5qq8e2.fsf@suse.de>
 <ZuH_pvnTCumKuXTh@x1n> <87bk0trifq.fsf@suse.de>
In-Reply-To: <87bk0trifq.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2024 09:13:16 +0100
Message-ID: <CAFEAcA9YkZiSSOAj0zH2OwF9AcziJT-zpnNVQn8BXizhSXHVOA@mail.gmail.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 qemu-devel@nongnu.org, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Wed, 11 Sept 2024 at 22:26, Fabiano Rosas <farosas@suse.de> wrote:
> I don't think we're discussing total CI time at this point, so the math
> doesn't really add up. We're not looking into making the CI finish
> faster. We're looking into making migration-test finish faster. That
> would reduce timeouts in CI, speed-up make check and reduce the chance
> of random race conditions* affecting other people/staging runs.

Right. The reason migration-test appears on my radar is because
it is very frequently the thing that shows up as "this sometimes
just fails or just times out and if you hit retry it goes away
again". That might not be migration-test's fault specifically,
because those retries tend to be certain CI configs (s390,
the i686-tci one), and I have some theories about what might be
causing it (e.g. build system runs 4 migration-tests in parallel,
which means 8 QEMU processes which is too many for the number
of host CPUs). But right now I look at CI job failures and my reaction
is "oh, it's the migration-test failing yet again" :-(

For some examples from this week:

https://gitlab.com/qemu-project/qemu/-/jobs/7802183144
https://gitlab.com/qemu-project/qemu/-/jobs/7799842373
https://gitlab.com/qemu-project/qemu/-/jobs/7786579152
https://gitlab.com/qemu-project/qemu/-/jobs/7786579155

-- PMM

