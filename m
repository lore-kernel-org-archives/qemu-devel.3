Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD125C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 04:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV1qa-00006r-3r; Tue, 30 Jan 2024 23:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV1qW-00006e-Jk
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 23:05:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV1qS-0001IP-JF
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 23:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706673899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RljuSivBPVFCrLZHRTF8lwn8Pwgz61p/VG3JbLqe/Co=;
 b=ihMHxnc1D/JO54IKBiYpQoEBmAqpB17ykmFb6df16RTxu8uU7u+/Ha+KA5UCjC/25+Qo68
 qxud4Cbp7XR3BvFPLWAemzAN4sZ0wRLXixNmMnzNGHeKUvsmJgzMEK/T9r5lEjnDuCOW9J
 5KFshrOIM0agkHa8/RVUCK3ZrWb0qhc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-Jenzp_ZPNyGUnxlnE_nbPQ-1; Tue, 30 Jan 2024 23:04:55 -0500
X-MC-Unique: Jenzp_ZPNyGUnxlnE_nbPQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-28c0765415eso734591a91.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 20:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706673895; x=1707278695;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RljuSivBPVFCrLZHRTF8lwn8Pwgz61p/VG3JbLqe/Co=;
 b=jQ3SOrVyDcZLKO+BqR5AAr9q93ps0POEe1hMNuK+Wv5A10VQSyMwEVtux4+bsWstdW
 +Ga35WoSC1ZLDMGC3I0++03b9oHWIQOMgOR+5XoICtrRuQ0ev0W8HaVAy0H6iZFcNCcg
 kGtSPyrrrUJB0VjqlBFDjAeUCzmS7KGSMgVnmsWX4FFUuLURaD+2+sdH7kKyf/H45UJA
 tNFdydoibgO//LcUrgflQtvKMdVdv9U5WwruzMvtdANNg2/MOutAXwVTXnhmH3fX6Kcd
 3m6GhrUiQhHc4N9hBCpIZ4AaF4ezk02jgAKAVWmpxg9uGfCdXjDnBCFojq5m2yyT2SUB
 RI5A==
X-Forwarded-Encrypted: i=0;
 AJvYcCWhZfCYnyXrr+gwNG6e+iaj7chmGIA3xIz00XnDJJ+WnXdHebKT+GR8t/TaeqS73sEtAiqe69daHqOtQAThLkhYFfp0FvA=
X-Gm-Message-State: AOJu0YwE5/UfMqF4uE07pwkz3kYoNVaxsK/yhcGtuVX2+z1sExnQZcVl
 UOk6qNIiXj6tJaqv9j3Fa7WQTUywrh62BbIoQtTm+NEZjkqIv2Aw8VUhW+qDEtrZevkR92F7Rzo
 1+PsVaEL/0ipu/hJEA/ZD0lK0b6ulbcdMATvllNtG61T/1UKr3GHw
X-Received: by 2002:a17:902:ed04:b0:1d9:143:a25c with SMTP id
 b4-20020a170902ed0400b001d90143a25cmr607803pld.4.1706673894735; 
 Tue, 30 Jan 2024 20:04:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbcADQ8k4tH4CFMtgg/vu2M+G2JABkJjd3FSChtJ1XzNiMjh/tUogi4cebqEVn//0/juczzA==
X-Received: by 2002:a17:902:ed04:b0:1d9:143:a25c with SMTP id
 b4-20020a170902ed0400b001d90143a25cmr607790pld.4.1706673894315; 
 Tue, 30 Jan 2024 20:04:54 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 x10-20020a170902e04a00b001d8accb025fsm6936833plx.197.2024.01.30.20.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 20:04:53 -0800 (PST)
Date: Wed, 31 Jan 2024 12:04:46 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
Message-ID: <ZbnG3qkMBPdsQxan@x1n>
References: <20240126041725.124562-7-peterx@redhat.com>
 <87le8c6u1d.fsf@suse.de>
 <CAFEAcA-x4WqvPsN-KZOA3SPN0F=vvYi=NFZ2qom2iT7-CN0RSg@mail.gmail.com>
 <87il3g6t7b.fsf@suse.de> <ZbcSqyGNLGu7ugBb@x1n>
 <87sf2ge3qu.fsf@suse.de> <87y1c7ogze.fsf@suse.de>
 <CAFEAcA_BPf4LSh-JF1NVVVdaLoKgUcsnGeP7sHt-f73r4zyh7g@mail.gmail.com>
 <ZbjT5OYpzNJjkMw9@x1n> <87wmrqbjnl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmrqbjnl.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jan 30, 2024 at 06:23:10PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Jan 30, 2024 at 10:18:07AM +0000, Peter Maydell wrote:
> >> On Mon, 29 Jan 2024 at 23:31, Fabiano Rosas <farosas@suse.de> wrote:
> >> >
> >> > Fabiano Rosas <farosas@suse.de> writes:
> >> >
> >> > > Peter Xu <peterx@redhat.com> writes:
> >> > >
> >> > >> On Fri, Jan 26, 2024 at 11:54:32AM -0300, Fabiano Rosas wrote:
> >> > > The issue that occurs to me now is that 'cpu host' will not work with
> >> > > TCG. We might actually need to go poking /dev/kvm for this to work.
> >> >
> >> > Nevermind this last part. There's not going to be a scenario where we
> >> > build with CONFIG_KVM, but run in an environment that does not support
> >> > KVM.
> >> 
> >> Yes, there is. We'll build with CONFIG_KVM on any aarch64 host,
> >> but that doesn't imply that the user running the build and
> >> test has permissions for /dev/kvm.
> >
> > I'm actually pretty confused on why this would be a problem even for
> > neoverse-n1: can we just try to use KVM, if it fails then use TCG?
> > Something like:
> >
> >   (construct qemu cmdline)
> >   ..
> > #ifdef CONFIG_KVM
> 
> >   "-accel kvm "
> > #endif
> >   "-accel tcg "
> >   ..
> >
> > ?
> > IIUC if we specify two "-accel", we'll try the first, then if failed then
> > the 2nd?
> 
> Aside from '-cpu max', there's no -accel and -cpu combination that works
> on all of:
> 
> x86_64 host - TCG-only
> aarch64 host - KVM & TCG
> aarch64 host with --disable-tcg - KVM-only
> aarch64 host without access to /dev/kvm - TCG-only
> 
> And the cpus are:
> host - KVM-only
> neoverse-n1 - TCG-only
> 
> We'll need something like:
> 
> /* covers aarch64 host with --disable-tcg */
> if (qtest_has_accel("kvm") && !qtest_has_accel("tcg")) {
>    if (open("/dev/kvm", O_RDONLY) < 0) {
>        g_test_skip()
>    } else {
>        "-accel kvm -cpu host"
>    }
> }
> 
> /* covers x86_64 host */
> if (!qtest_has_accel("kvm") && qtest_has_accel("tcg")) {
>    "-accel tcg -cpu neoverse-n1"
> }
> 
> /* covers aarch64 host */
> if (qtest_has_accel("kvm") && qtest_has_accel("tcg")) {
>    if (open("/dev/kvm", O_RDONLY) < 0) {
>       "-accel tcg -cpu neoverse-n1"
>    } else {
>       "-accel kvm -cpu host"
>    }
> }

The open("/dev/kvm") logic more or less duplicates what QEMU already does
when init accelerators:

    if (!qemu_opts_foreach(qemu_find_opts("accel"),
                           do_configure_accelerator, &init_failed, &error_fatal)) {
        if (!init_failed) {
            error_report("no accelerator found");
        }
        exit(1);
    }

If /dev/kvm not accessible I think it'll already fallback to tcg here, as
do_configure_accelerator() for kvm will just silently fail for qtest.  I
hope we can still rely on that for /dev/kvm access issues.

Hmm, I just notice that test_migrate_start() already has this later:

        "-accel kvm%s -accel tcg "

So we're actually good from that regard, AFAIU.

Then did I understand it right that in the failure case KVM is properly
initialized, however it crashed later in neoverse-n1 asking for TCG?  So
the logic in the accel code above didn't really work to do a real fallback?
A backtrace of such crash would help, maybe; I tried to find it in the
pipeline log but I can only see:

  ----------------------------------- stderr -----------------------------------
  Broken pipe
  ../tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)

Or, is there some aarch64 cpu that will have a stable CPU ABI (not like
-max, which is unstable), meanwhile supports both TCG + KVM?

Another thing I noticed that we may need to be caution is that currently
gic is also using max version:

        machine_opts = "gic-version=max";

We may want to choose a sane version too, probably altogether with the
patch?

-- 
Peter Xu


