Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D950C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVr9Y-00013X-Fo; Fri, 02 Feb 2024 05:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVr9W-00013H-Cq
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:52:10 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVr9U-0002tI-Qf
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:52:10 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55fb4b22da8so1981840a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 02:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706871126; x=1707475926; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=itDgKjMGZAOGmTD+JCVxWrkIGb1XhiKhqOP1myH6hHw=;
 b=Xh9F38hcbaMsMX7T43FKI2ULlEImNnx24L9gu7DGAMAgbiG0Fa0a/UOqVZkPi6RABy
 4G8xwJwVVK9GZPV6Kho/isJ1H6bq2Q8e+/STs5uDzNCfaRH5qbVioA0RJV+jq0zZbG7l
 fOblanIpIZ/M0hFjMG6m8jC3yZP1UosIBxjW4+Dfl0FUnI5KO6UOl8vWE/xHuJdRe5XH
 LULc6yAl/FKjCKwxVYPaencq/r1sD84zSI6W3gkScpm9IG3hJWjDtEZTwY+rq+YHBhaV
 a1qh8zNzP2/JCGwxJRZ44Y/DwRAM9TUn6eh7OSZ8LNZFLD8JRgypD7fBR2Kmu3zvvLC6
 qHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706871126; x=1707475926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=itDgKjMGZAOGmTD+JCVxWrkIGb1XhiKhqOP1myH6hHw=;
 b=fc13q2p5dBDVwLXDC3MxxOWCn2NK5CO85eDKdnUZOx4OLqMPGTTMemzQ2qbt+1Kgzb
 noio/TbA2A7yeoZpiIEAZZtWF4ei1O7lrGwGnKxXL1rHKGgTuCsJciWTHRKZXzIMccU8
 voqkFrVCGoMcZVVYcchY1Q3soqnw1TdXcR+dLmzWbcJl3pWSSJzurGDJg8sDmXi5EfiU
 GuNicvxz87kVY8O/AXiMw+hFTDCykJ1WPQrlKUhSYYmhWoENG81cBhRmyBdwVoWnonBa
 J9WdANPa2Kf3IYhhP4TZn5jttLDJg/cXYIOcgE1E/opzFFnA+5CyFq/NPDtBurO7xqwB
 NH+Q==
X-Gm-Message-State: AOJu0YzrBAvkXyTNJK0skBNuer+9cA0VRCrqF2E0Bp9w61rlYpUna+i2
 vOZ/6uDzceF64zWwC9IHTPqNRv765zrIqlcsIs0xkyv1PpmWPJ08yTMv5yX8H9hSrBw9hLSp8+1
 yPBLN+Wjp3lwVd5z1vbD2g0cFIXVYi69Z3i/ZtjyoqmMTP7a9
X-Google-Smtp-Source: AGHT+IGQvscCfWPGbcOpWM4mucK6C+M4nZeVcDHLwcrDS+RtLbLESluZiQmtkwRtbYOs+b0HfkB43XAUkvyRxIDDu/A=
X-Received: by 2002:a05:6402:65a:b0:560:463:8cd7 with SMTP id
 u26-20020a056402065a00b0056004638cd7mr175641edx.34.1706871126347; Fri, 02 Feb
 2024 02:52:06 -0800 (PST)
MIME-Version: 1.0
References: <ZbcSqyGNLGu7ugBb@x1n> <87sf2ge3qu.fsf@suse.de>
 <87y1c7ogze.fsf@suse.de>
 <CAFEAcA_BPf4LSh-JF1NVVVdaLoKgUcsnGeP7sHt-f73r4zyh7g@mail.gmail.com>
 <ZbjT5OYpzNJjkMw9@x1n> <87wmrqbjnl.fsf@suse.de> <ZbnG3qkMBPdsQxan@x1n>
 <878r45lkeb.fsf@suse.de> <ZbsIYKJ5fYG6zsVi@x1n> <87y1c4ib03.fsf@suse.de>
 <ZbwuSM7LjWCsa_VB@x1n>
In-Reply-To: <ZbwuSM7LjWCsa_VB@x1n>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 10:51:36 +0000
Message-ID: <CAFEAcA-h6BDiY4G1uBymcmmnzagHTvhevb1wXPzwBOwZYM338Q@mail.gmail.com>
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 1 Feb 2024 at 23:50, Peter Xu <peterx@redhat.com> wrote:
>
> Fabiano, I think you forgot to reply-to-all.. adding back the list and
> people in the loop.
>
> On Thu, Feb 01, 2024 at 10:12:44AM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> >
> > > On Wed, Jan 31, 2024 at 10:09:16AM -0300, Fabiano Rosas wrote:
> > >> If we ask for KVM and it falls back to TCG, we need a cpu that supports
> > >> both. We don't have that. I've put some command-line combinations at the
> > >> end of the email[1], take a look.
> > >
> > > Thanks a lot, Fabiano.  I think I have a better picture now.
> > >
> > > Now the question is whether it'll be worthwhile we (migration) explicitly
> > > provide code to workaround such issue in qtest, or we wait for ARM side
> > > until we have a processor that can be both stable and support KVM+TCG.
> > >
> > > I actually personally prefer to wait - it's not too bad after all, because
> > > it only affects the new "n-1" migration test.  Most of the migration
> > > functionality will still be covered there in CI for ARM.
> >
> > That's fine with me. We just need to do something about the arm CI job
> > which is currently disabled waiting for a fix. We could remove it or add
> > some words somewhere explaining the situation. I can do that once we
> > reach an agreement here.
>
> Yes.  IMHO we can keep the test (with SKIPPED=1) but amend the message,
> which will start to state inaccurately:
>
>         # This job is disabled until we release 9.0. The existing
>         # migration-test in 8.2 is broken on aarch64. The fix was already
>         # commited, but it will only take effect once 9.0 is out.
>
> IMHO then it won't mean 9.0 will have it fixed, but we'll simply wait for a
> cpu model that is ready for both kvm+tcg, then we replace "max".

We already have a CPU model that works for both KVM and TCG: that
is "max". We're not going to add another one. The difference is
just that we provide different cross-version migration compatibility
support levels for the two cases. (Strictly speaking, I'm not sure we
strongly support migration compat for 'max' on KVM either --
for instance you probably need to be doing a migration on the
same host CPU type and the same host kernel version. It's just
that the definition of "max" on KVM is less QEMU-dependent and
more host-kernel-dependent, so in your particular situation running
the test cases you're less likely to see any possible breakage.)

-- PMM

