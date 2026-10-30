Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5CD606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cXKZdVuw;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oScmsTuk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMiH2-00081U-Cu; Fri, 30 Oct 2026 04:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xMiH0-00081D-9t
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xMiGx-0004cZ-Lg
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793350058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uoHT1rJvruYlzCTz11YHIxHvKsZlkyJMzw6yX7lV53Q=;
 b=cXKZdVuwlJhdAJn1iJKuW8Ie6nPZ5o/wznYBp876HoK6dmg4A43heIg36rl2BL5dPugGuB
 ZC79pO0V8shhO4lDyLPXWVS2JpNkqpCq5VpCJyJECzE2gy1xPW+gDIkVzKqyjD9iGrAHRj
 ScHSpBNYhEn7gyH//EsFdbx28aoqrKs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-1DbEzytDPmyxe0H8WUzcXw-1; Fri, 30 Oct 2026 04:47:29 -0400
X-MC-Unique: 1DbEzytDPmyxe0H8WUzcXw-1
X-Mimecast-MFC-AGG-ID: 1DbEzytDPmyxe0H8WUzcXw_1793350049
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3aaf955db5fso709848a91.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793350049; cv=none;
 d=google.com; s=arc-20260327;
 b=WZuz0q+BN45vEuiG2bjQQrtd3oozHEax9wiS51fBfqbtLm7lsXh3AWYMAOq+kGI3g9
 Kn2eRmBTA14uswAv7mnsRDB6Ks8cSaQ3hZMooL3ZVptZ2q9uFwX0hpBMyHqXQL0PoKqm
 ffMNKS5ku7pawROl8xVzsbnrtSoofitx3V5+WRa8Tc6Jivrfl5yVciPcgIqTRqqXRG25
 HLknj8pbVSIRpddGVzb5riGzAvjXExmlr/SbbdojfApqqell97q1XewHi2aFp2RYtBX+
 8famewJndQYCCTuhA7Aq7qIOy7LChUoFL9Pu8nmCgP85oEk4g/dC4raD7vQcIz9Y3T11
 2OXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uoHT1rJvruYlzCTz11YHIxHvKsZlkyJMzw6yX7lV53Q=;
 fh=lZLkOphK9EAX+1MVdeTF4LY6MVAmJaj+PuynQ7+aa/I=;
 b=b/fFFpAz51BtrEwl5XMGaqYwZFX2ykyGuHmo4BNsLuhPpBEb4Zn9eaBIf67LiAUu72
 qWoDzpX3xqYTpWXiAN3FM/UHXuKg5sEydHInk3TYnKDsigJhH+r5nSisO9p62PUbFhcS
 DMwkNhS/6ChQSNlnPUGqm9XIqUQYwWBWL9MEAkgbYqpN5wTX2Mq8Hmm/I2rfck8dMAI1
 NKUgCrEKOMl9ozxja+IOPm+YckQsdJfzqTy29Ord/ZVg5mxu2f+NvtFBPeG4PD82oJY5
 s8lgNF1O48Nsf/QZQTZTN5AFKF64RLYYWC55tPOg52PLOvqULNvrNN43d9yMgJVi6tm2
 c14g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793350049; x=1793954849; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uoHT1rJvruYlzCTz11YHIxHvKsZlkyJMzw6yX7lV53Q=;
 b=oScmsTuky9Wyu6nITMeZIfzBzVfsRYp3WfhsvFtieRy3ew9jXWtLsX6z3bKluQusqG
 5Dsz17VV7l1kNvZp89JYUPgu/cYbj/irryukxKBE/3gTVOVUs+O2a/shyf6PT3jKYsVm
 o8A6I8xSaGhHsFbW9XpYQYicp3Bg4i22mm1OAce2n0a4Y2Ai+TgLFeO0RLMeJlTmx8R4
 IDq633DdW1465j0b0+fLfj5Zb1zz/w8uUDRbMOXDIA6t0wCumb8teQKaGDr5sABiVtZe
 rUVKFrzLklpqWUI9evZNh4dY3OciEttQ6JOO5Dc63jeqfsKQeu5l+Ra9FmHpzY4Mwn8/
 tTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793350049; x=1793954849;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uoHT1rJvruYlzCTz11YHIxHvKsZlkyJMzw6yX7lV53Q=;
 b=YqhSyNj3RKrIRDejn5IcisO7ptXY9WJMQdv9xb6sZ4ISFYHvY5F4KbyTSJgIXUN2Bw
 EidHvJpOUoQ96xDUR3hwOT1jfxZ4rVI/wssA5TqGYFMsTGA4XtHARhrpADfDZbLkSdu7
 8u9khcujHCKafB30jgxsJya9mfXTmqdCGQaJBpUL+F8r5jc57IBm6u2SLvozbnyh93Ki
 prC3NYCj5lOjwiGdYjkaANrs1Tr75N3nA4P2JhMJgCpfIhimTP2ZUOSGu8yy3VsTex5H
 +n2ZGplzDH+4iwqUpwPW7IznyO7KOprtPMXRBDAaC7PNnz0V7M5KT0n21Z8dt4viRyY5
 6GXw==
X-Gm-Message-State: AFq9FYJFaZ6rF4G2xrQgoJxoofg+YcYoJJkDJmG5uGZm8psplCz5EXpZ
 b4bGGT8f2PEbzZ3hWuCAT3Gwt9CYuhDb68xaANOVpNA0IF16C1NqNkbN5B35sFi4OYlO8iZSaGY
 7QFfXxFJQ9zerjYf+G79qm13SdJtECmCJUVnYLYlEBiBMhvabQAeHpguHufxPvaJcwIxzl6FJRi
 z0lgb8UwJAP4VU+T06601ZF1Vy2wLTheI=
X-Gm-Gg: AYBFou38+cUJYaWbgC6oGqXYbIKdj48YPVqUv4pT8vIB89Kwt1ocrIHIh+PC2bpbuAH
 2j+ZuzAQO8+EfIoJzgvhPvRbplIQF0VWmmYPOugvqpU8SChYNg7douvuj5zYD13bZetBR6h4CH3
 r2yttfFyGm68RB8qqAOAsiRL63iVWH3eigV2Ymwohgp1jWDRsfBFzcBRUlb6nzqbGTOG6YWdDiD
 eVfEPrtKmixS4ujtoQxyYGJHQgJEJxgNn8C5/YgWxGAdreLFQx7YnyJZLJGJIGu9TdWBg0aDu7G
 iw==
X-Received: by 2002:a17:90b:1f88:b0:3a0:9c9d:eb18 with SMTP id
 98e67ed59e1d1-3ae897e0645mr1424535a91.54.1793350048585; 
 Fri, 30 Oct 2026 01:47:28 -0700 (PDT)
X-Received: by 2002:a17:90b:1f88:b0:3a0:9c9d:eb18 with SMTP id
 98e67ed59e1d1-3ae897e0645mr1424522a91.54.1793350048054; Fri, 30 Oct 2026
 01:47:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015112044.1999748-1-berrange@redhat.com>
 <179206655287.744241.865023521920859070.b4-review@b4>
 <atDHwThz_5XPY9Yx@redhat.com>
 <CAMxuvayG8mPvVSagb6EyEH-hhA094qw3LPUWdeL_PJ5qeEk3=g@mail.gmail.com>
 <auODPFwxQ0Bc0oi-@redhat.com>
 <CAJ+F1CJJEX8TDQLS9okRNYQ2RU64YBnWOAqTG3K9PGnCjS8_Yg@mail.gmail.com>
 <auOQT9WYbNU1Y7X9@redhat.com>
In-Reply-To: <auOQT9WYbNU1Y7X9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 30 Oct 2026 12:47:16 +0400
X-Gm-Features: AclHuK-4KFzUNgMN-hU54NuBe0hIHo8lB4jQpke2k2PahCeKi_7IfapM8DFCQw8
Message-ID: <CAMxuvaxk3xRZV+0qrBgnA9wGYddKW53g+H=3F6NjbHB8L6__zA@mail.gmail.com>
Subject: Re: [PATCH 00/21] system: introduce a live data recorder facility
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Thu, Oct 29, 2026 at 10:29=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Thu, Oct 29, 2026 at 10:15:46PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Oct 29, 2026 at 9:33=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > On Fri, Oct 16, 2026 at 11:20:11AM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi
> > > >
> > > > On Thu, Oct 15, 2026 at 4:32=E2=80=AFPM Daniel P. Berrang=C3=A9 <be=
rrange@redhat.com> wrote:
> > > > >
> > > > > On Thu, Oct 15, 2026 at 04:15:52PM +0400, marcandre.lureau@redhat=
.com wrote:
> > > > > > > This series introduces a new facility called 'tldr' which is =
a
> > > > > > > live data recorder. This is intended to aid support of produc=
tion
> > > > > > > QEMU deployments, by providing a data collection facility tha=
t
> > > > > > > can be left "always on", such that in the event of a QEMU cra=
sh
> > > > > > > or guest OS crash, certain important information will be reco=
rded.
> > > > > > >
> > > > > > > The data recorder has to be enabled by adding a "tldr-config"
> > > > > > > object instance with -object / object_add.
> > > > > > >
> > > > > > > With this series, the data recorder collects
> > > > > > >
> > > > > > >  * error_report/warn_report/error_printf messages
> > > > > > >  * QMP events
> > > > > >
> > > > > > It should probably be recorded at emission, not per monitor
> > > > >
> > > > > Opps.
> > > > >
> > > > > > >  * QMP errors
> > > > > > >  * QMP commands, which are not query-XXX/qom-list,
> > > > > > >    or any command associated with a QMP error.
> > > > > > >  * qemu_log output
> > > > > > >
> > > > > > > The last item is intended primarily to be used in combination
> > > > > > > with tracing and its 'log' backend, to have continuous
> > > > > > > recording of certain interesting probes.
> > > > > > >
> > > > > > > Each type of data is collected in a distinct circular
> > > > > > > buffer, such that high volumes of one type of data, does
> > > > > > > not result in overwriting other types of low volume data.
> > > > > > >
> > > > > > > The data recorder is set to trigger on SIGBUS, SIGSEGV,
> > > > > > > SIGILL, SIGFPE and SIGABRT, or manually via QMP 'tldr-dump'.
> > > > > >
> > > > > > Instead of allocating and dumping by a signal handler, why not =
use a file-backed
> > > > > > mmap or a memfd? We would need to define a small fixed header f=
or the file
> > > > > > layout/buckets.  This would avoid all the issues with signal ha=
ndlers.
> > > > >
> > > > > That would impose a continuous I/O workload on data recording, wh=
ich
> > > > > is something I wanted to explicitly avoid, until the time the dat=
a is
> > > >
> > > > Yes, a file-backed mapping shouldn't be the default, but memfd/tmpf=
s
> > > > should have the same performance.
> > > >
> > > > > needed to be preserved. This only persists the final data, not an=
y
> > > > > intermediate data that is overwritten as the circular buffer wrap=
s.
> > > >
> > > > Same design, the reader would handle the ring data
> > > >
> > > > > Coupling the in-memory layout to the on-disk layout also means th=
at
> > > > > dumps would always be the max size, since we would not have grow-=
on
> > > > > demand buffers.
> > > >
> > > > The dump output would not be the raw data, a reader would emit the
> > > > same text format, skipping the unused parts.
> > >
> > > IMHO that reader has to be QEMU owned code, as otherwise we're
> > > exposing a private data structure to a 3rd party and that makes
> > > it public ABI/API which is highly undesirable for this.
> >
> > The resulting data will be ABI/API anyway, no?
>
> I was considering it human targetted data, not machine
> targetted data, so not API and subject to change.

So why would intermediate data be considered differently?

>
> >
> > >
> > > > mapping reserves address space only, pages are allocated on first w=
rite.
> > > >
> > > > The benefits:
> > > > - no signal handler, no conflict with MCE, ASAN etc
> > >
> > > A signal handler is integral to some extent, as captured info about
> > > the signal is itself is an important part of the data record. IOW,
> > > even if moving writing of the dump out of the signal handler in some
> > > manner, I still want to be able to capture several siginfo_t fields.
> > >
> > > You can get that info from a core dump, but the working premise
> > > is that a core dump is not guaranteed available, whereas the data
> > > record dumps are something we can more easily acquire.
> >
> > right.. this is something you don't touch in the cover letter. I
> > assume most systems have a core dump handler already (perhaps
> > differently on Windows), thus we could also rely on the dumped data
> > instead of a signal handler. We should be explicit about why we don't
> > follow that path
> >
> > systemd/coredumpctl does store siginfo_t of the process too
>
> We often can't get at those core dump records when inside a container.
>

I am not sure I understand that justification. But anyway, since the
record will be in memory, we can also retrieve it from the coredump,
even if a trace is written too.


