Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B192C4828F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 02:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWpAB-0006WL-Vj; Sun, 04 Feb 2024 21:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWpAB-0006WC-12
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 21:56:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWpA9-0006e8-B5
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 21:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707101807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Ik2uvIDXiQs8+YNBltoMd/oxU45tyMya2pSr0obGSM=;
 b=DG0nyjVUp4J/nnr++UstwBTZbiedWwm4qonxV8UIwaxDMCSNvJtu97fzcqez7rJLLlWPaR
 kJJLtJnSMIE3wWrdFxyJbjxPzzbwx4mP8DYYwYrJWDtiLnMarfue8VbDY/tMo0wWDChzdw
 0Xwy7ixqGJKApvp7TBP+VEhsJNfBgNk=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-U_Hym3WLOT-4kffk6KUQLg-1; Sun, 04 Feb 2024 21:56:45 -0500
X-MC-Unique: U_Hym3WLOT-4kffk6KUQLg-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-21921e2c9f5so629106fac.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 18:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707101805; x=1707706605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ik2uvIDXiQs8+YNBltoMd/oxU45tyMya2pSr0obGSM=;
 b=lR3SjgLKvXZ5ys84+WiMzrEnxY78Be2Dhb/qWRkIGaivTwoHHyo4hq5iH4RU8yVdVh
 TYW+3uC2/P6ICcs3BdfgFpKU7WOhu6mfujAlMN0XFL1tFpzjR58WDlmBPVddekf+QKSX
 rpAYNtUF3mYpUPSdis+tcYymRj+9B3j4oGUEH8HEjnKULiHKmSQ5dmYuqCWbbhXHpwtG
 VajSRNYH/p3FxT7t72+/JXsaNmYK+OI8caGpO6Tl6fxv18WMOuSuZ6uKHdPnhrfOnKw9
 K/FW0U2csIpk0hLr5rvLuJABDBo9Wci5tDBbAGZjmYHTjTPr50QtH+snqRe2PQ01xABf
 4YVA==
X-Forwarded-Encrypted: i=0;
 AJvYcCUAf3F3pWJDnE+L2jwwgMnATaKynF6J6R5N6gOrUc91I8/p8KyLhIxZsKkyOIRqUq85qPozC0XtL5tQmFn4xElxV6XQpWE=
X-Gm-Message-State: AOJu0Yz30GI8B/LVglyLmnF9n1EAn8blSXQCUXKVEPAwfsSecagyAW9N
 ZpSQ0Ehr0aj6C5ueQgGLpI9caaDWbetT51PMfSH8AJgJLC/2UUMm4dlbbe+9lRgy/Vw3SBcCUd8
 bVSp4RJ3XQTmrv02h31zRtofYgCPFVC7m3qzxWZT5v3F66PZ1iUwt
X-Received: by 2002:a05:6808:2018:b0:3be:1590:82f6 with SMTP id
 q24-20020a056808201800b003be159082f6mr13655148oiw.0.1707101805031; 
 Sun, 04 Feb 2024 18:56:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBq2rdzxWoRdhUgYMkDvEROk9ShH38W4lkG0TceaqFw8gGeNFeO1R/KxM/L3XU80xvC0M/XQ==
X-Received: by 2002:a05:6808:2018:b0:3be:1590:82f6 with SMTP id
 q24-20020a056808201800b003be159082f6mr13655141oiw.0.1707101804708; 
 Sun, 04 Feb 2024 18:56:44 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXQvLqqlnNBnJWu3b06TEMaeijXvrMMoYPc6ps1ipQi0k9Y7aaU2edMhwZRly6urnyUJwWkxuzGScSy1csjWT0zFQXitSTsGF4j++F83WMSE2li063/OLnJcJUFnw==
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 g10-20020a056a000b8a00b006ddce8e110bsm1737358pfj.128.2024.02.04.18.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 18:56:44 -0800 (PST)
Date: Mon, 5 Feb 2024 10:56:36 +0800
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
Message-ID: <ZcBOZPhEq0gNHFzY@x1n>
References: <87y1c7ogze.fsf@suse.de>
 <CAFEAcA_BPf4LSh-JF1NVVVdaLoKgUcsnGeP7sHt-f73r4zyh7g@mail.gmail.com>
 <ZbjT5OYpzNJjkMw9@x1n> <87wmrqbjnl.fsf@suse.de>
 <ZbnG3qkMBPdsQxan@x1n> <878r45lkeb.fsf@suse.de>
 <ZbsIYKJ5fYG6zsVi@x1n> <87y1c4ib03.fsf@suse.de>
 <ZbwuSM7LjWCsa_VB@x1n>
 <CAFEAcA-h6BDiY4G1uBymcmmnzagHTvhevb1wXPzwBOwZYM338Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-h6BDiY4G1uBymcmmnzagHTvhevb1wXPzwBOwZYM338Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Feb 02, 2024 at 10:51:36AM +0000, Peter Maydell wrote:
> On Thu, 1 Feb 2024 at 23:50, Peter Xu <peterx@redhat.com> wrote:
> >
> > Fabiano, I think you forgot to reply-to-all.. adding back the list and
> > people in the loop.
> >
> > On Thu, Feb 01, 2024 at 10:12:44AM -0300, Fabiano Rosas wrote:
> > > Peter Xu <peterx@redhat.com> writes:
> > >
> > > > On Wed, Jan 31, 2024 at 10:09:16AM -0300, Fabiano Rosas wrote:
> > > >> If we ask for KVM and it falls back to TCG, we need a cpu that supports
> > > >> both. We don't have that. I've put some command-line combinations at the
> > > >> end of the email[1], take a look.
> > > >
> > > > Thanks a lot, Fabiano.  I think I have a better picture now.
> > > >
> > > > Now the question is whether it'll be worthwhile we (migration) explicitly
> > > > provide code to workaround such issue in qtest, or we wait for ARM side
> > > > until we have a processor that can be both stable and support KVM+TCG.
> > > >
> > > > I actually personally prefer to wait - it's not too bad after all, because
> > > > it only affects the new "n-1" migration test.  Most of the migration
> > > > functionality will still be covered there in CI for ARM.
> > >
> > > That's fine with me. We just need to do something about the arm CI job
> > > which is currently disabled waiting for a fix. We could remove it or add
> > > some words somewhere explaining the situation. I can do that once we
> > > reach an agreement here.
> >
> > Yes.  IMHO we can keep the test (with SKIPPED=1) but amend the message,
> > which will start to state inaccurately:
> >
> >         # This job is disabled until we release 9.0. The existing
> >         # migration-test in 8.2 is broken on aarch64. The fix was already
> >         # commited, but it will only take effect once 9.0 is out.
> >
> > IMHO then it won't mean 9.0 will have it fixed, but we'll simply wait for a
> > cpu model that is ready for both kvm+tcg, then we replace "max".
> 
> We already have a CPU model that works for both KVM and TCG: that
> is "max". We're not going to add another one.

Thanks, but then this is pretty sad.  I'm surprised aarch64 doesn't have
such requirement to allow some VM config to run across all kinds of hosts.

> The difference is just that we provide different cross-version migration
> compatibility support levels for the two cases. (Strictly speaking, I'm
> not sure we strongly support migration compat for 'max' on KVM either --
> for instance you probably need to be doing a migration on the same host
> CPU type and the same host kernel version. It's just that the definition
> of "max" on KVM is less QEMU-dependent and more host-kernel-dependent, so
> in your particular situation running the test cases you're less likely to
> see any possible breakage.)

Yes we don't have issue for the current CI on KVM compatibilities, but QEMU
does matter for sure.

Then we can either (1) add code as Fabiano suggested to choose different
cpu model by adding hack code in qtest, or (2) we simply not support
aarch64 on cross binary test like most of the rest of the arch, but only
support x86, until any arch can provide a stable CPU that support all
config of hosts (we can document it in the CI file).

I'd vote for (2).  Fabiano, do you have any preference?

-- 
Peter Xu


