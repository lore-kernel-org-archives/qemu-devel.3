Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB92606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cRrZL4qx;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=alDLA0Hf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM2Em-0003pD-En; Wed, 28 Oct 2026 07:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xM2El-0003p5-Rl
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xM2Ej-0005qu-Vf
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793188472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kIP/JKm7+DezmLB2+AICK6egNR42rHvkONIZbvMP5bQ=;
 b=cRrZL4qx9npxJEneLyB9q2QI/bh0u4639g5ddf9vnhIrR8Zqmf1oTmpy4QY64UthwgWsd/
 mOlzML7a4f4ltdOt2e5NvXL8HXUukJwEdQS7ae5LUFII+lwMtonGnrSbsEWLCN2Fs57iaN
 L4AS5RHs6ALWFfSblDO06zDrmMWZads=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-_O_Jtg0-MSeulz_UtW6UJQ-1; Wed, 28 Oct 2026 07:54:31 -0400
X-MC-Unique: _O_Jtg0-MSeulz_UtW6UJQ-1
X-Mimecast-MFC-AGG-ID: _O_Jtg0-MSeulz_UtW6UJQ_1793188470
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91c70349f65so20561406d6.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 04:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793188470; x=1793793270; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kIP/JKm7+DezmLB2+AICK6egNR42rHvkONIZbvMP5bQ=;
 b=alDLA0HfcA/FSXjBxVsEqpMp31i8TONf29TejhNKcJjBbjwOsi3aO1zxMfQEOTnqir
 SLHHl1UsaF2mE1665dryqBZUwwsRZ8lz7j1zSmICj43GA5rSwW86DlksSYSQAmXCVTbl
 GAVW2C6qGzdIbAa/GsY++wbdHIUCZpExn0iz+PbgIB0MrsqSTijVXppN3q4dgXUPhEFI
 gdhjEoq0WsyYiP+yC17+CkOKsr5N6yaD07O6+GIspWhCVAMY1MYjnT10/MjGaetTlDcM
 HPp6UiizLQRG1jWMTXfla4D0GcsZ7x0lAIPa4ePtY5aeakH5/maUV7EwXItwGnTzoQyc
 hu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793188470; x=1793793270;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kIP/JKm7+DezmLB2+AICK6egNR42rHvkONIZbvMP5bQ=;
 b=M7ZVEJnbuhcMxMsI9hB1OOCajkMDhd9DO+jh3DLLAnERpF55exyC0k8rVdQxLWwwzu
 ygpK+DHTJs/DmbJVXfA2nRbuyckky7hRI/uKVleBtbPMvR6FFi8Ahk5SdajMPpLGgjEw
 AqkHlpxH+7ib47vQAqh4dqZy51C88BHde/4Rbux3JyhstxD3YALMT5FbpA9rP0CTznLD
 qdpohgmZLl7jYvLrSHPMaZCG+OAxCJUlu4zEhK3eVRKWBzgpLMaPBkbUHb/PUJVbx0h3
 1pypuVSOFeaoQRNCg1RLFq1Wa+deSHxDsmXENXvGt2GF/+wwM1467fKNoGlFnpVu8uFz
 ruPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVL4xE5FGYZLAqo9anwNp61ZvoMYPpvqNazCOHRskZalAH14oMgHTV10Da32DYVe+DWcH3oaRaSMPA@nongnu.org
X-Gm-Message-State: AFq9FYJdEEhcyhPGKAQ73zEOSemRKt66vRrVP/z2XJPQPHr6VCm8F3hW
 uFUTZYskptrrXXHMnKlzPfXDb4ZDHMQNCGDYCCRSF8n4I+avmlFqkDaRDWO7KXNJfJPPcrW4S0p
 5VnKUH7BwYyTGks9e21NBEuIlHdJgz0fupkQjTw6LtpHp8eXEwZNVb1bC
X-Gm-Gg: AYBFou19w2abBODqEdrlfmlboaYaoXRdLki+xu5lF2wHu9oRwexA+KissLXrhsXos//
 tTRtRVYm0locnuHjp4lHYQmJX85t5YoKbkqT+BCwN8LMNdAmXYdpJa+S5TpAFphjjcV++ZaYvTF
 HH5ufU1ayPE8pQy6OB/AIFo3KJgJAuKfwTk+c1K8xUy1sUX7ABbWcWfuepxnm7tG3/8CkzeThPN
 JPkVbrJurxRPihys2IorWKu+buN4DA3X4hZE6J+DQcS7mJQ7E8igFHqmBi8FTC0SZJu7L44Xx/t
 LVk1DFuOl1QbXQESjKE+d/iWojc0FAjkyYRbYe+1NobERGw3Ad7bQE9qG8u3NifxHCj0vd1DjzV
 Lx5s1HMdQnAg2pZy3NHz5Tv+OHzYW6l0RxbMhcwla8UVo
X-Received: by 2002:a05:620a:3188:b0:93f:3163:3e37 with SMTP id
 af79cd13be357-94408a71d5fmr282668785a.28.1793188470391; 
 Wed, 28 Oct 2026 04:54:30 -0700 (PDT)
X-Received: by 2002:a05:620a:3188:b0:93f:3163:3e37 with SMTP id
 af79cd13be357-94408a71d5fmr282665385a.28.1793188469758; 
 Wed, 28 Oct 2026 04:54:29 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f066629dsm1231039085a.7.2026.10.28.04.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 04:54:29 -0700 (PDT)
Date: Wed, 28 Oct 2026 07:54:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PULL 51/59] system: Remove deprecated 'debug-threads' option
 for -name
Message-ID: <auHidAzj6lX3Y0CN@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
 <20261027192341.9197-52-philmd@oss.qualcomm.com>
 <0dab848f-426e-49af-a28e-8165591b9d03@linaro.org>
 <e84af371-8fce-466c-9df6-c74863c127a4@oss.qualcomm.com>
 <auHEv-AQmulcwaad@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auHEv-AQmulcwaad@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 09:47:43AM +0000, Daniel P. Berrangé wrote:
> On Wed, Oct 28, 2026 at 08:32:20AM +0100, Philippe Mathieu-Daudé wrote:
> > (Cc'ing migration compat and libvirt teams)
> > 
> > On 28/10/26 02:01, Richard Henderson wrote:
> > > On 10/27/26 14:23, Philippe Mathieu-Daudé wrote:
> > > > 'debug-threads' option for -name was deprecated in v11.0
> > > > (commit 1b65aeed2a0 "system: unconditionally enable thread
> > > > naming") thus can now be removed.
> > > > 
> > > > Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> > > > Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> > > > Reviewed-by: Ján Tomko<jtomko@redhat.com>
> > > > Reviewed-by: Dr. David Alan Gilbert<dave@treblig.org>
> > > > Message-Id:<20261018232917.7716-1-philmd@oss.qualcomm.com>
> > > > ---
> > > >   docs/about/deprecated.rst             |  7 -------
> > > >   docs/about/removed-features.rst       |  9 +++++++--
> > > >   system/vl.c                           | 11 -----------
> > > >   tests/qtest/migration/framework.c     |  4 ++--
> > > >   tests/qtest/migration/precopy-tests.c |  2 +-
> > > >   qemu-options.hx                       |  7 +++----
> > > >   6 files changed, 13 insertions(+), 27 deletions(-)
> > > 
> > > You need to remove this from the testsuite as well:
> > > 
> > > https://gitlab.com/qemu-project/qemu/-/jobs/17523155796#L58
> > 
> > Hmm I was surprised because the pipeline in my fork passed, but then
> > looking clearer this job is marked as "allow_failure: true" for me,
> > why is it blocking on the mainstream repo?
> 
> It isn't blocking on upstream repo, it is allow_failure: true there
> too. Manual inspection of the job shows it is a real bug though.
> 
> > Back to the test, this is the migration-compat-x86_64 job running
> > previous release binary vs latest one, so I'd think this is the
> > expected behavior, v11.0 and v11.1 have that deprecated option, and
> > we can not test vs v11.2 which removed it.
> > 
> > If we want to change that workflow, then when deprecating on v11.0
> > we also need to remove the tests coverage, so when we remove the
> > feature at $deprecation_release+2 the migration-compat test does not
> > break. Here the question is, do we want to keep testing deprecated
> > features? Maybe yes in the case of unmaintained area when the
> > deprecation process triggers new maintainers stepping in and the
> > deprecation to be cancelled.
> > 
> > We could also mark the feature removed but keep it ignored and
> > undocumented until the next release but we'll likely forget and
> > miss that in workflow so I don't recommend that way.
> > 
> > Maybe there are another ways to resolve that but I'm not seeing
> > them. Ideas?
> 
> 'debug-threads=on' has no relationship to live migration data
> stream, it merely gives the threads names. Just remove this
> option from the migration testsuite as it is irrelevant to
> what is being tested.

We're testing with the old migration-test for compat, so Phil doesn't have
an easy way to remove that part:

.migration-compat-common:
    ...
    # Use the migration-tests from the older QEMU tree. This avoids
    # testing an old QEMU against new features/tests that it is not
    # compatible with.
    - cd build-previous

Intentional to avoid new things not working with old QEMU binaries, but
then this will be the case things break if we don't have protection of
2-release deprecation (where we could have removed the usage in test cases
2 releases in advance too when deprecating).

At least two options I see: (1) for this release, we lose compat
protection, we'll need to manually guard it, or (2) we provide some way to
script/patch on top of the build-previous/ build before it builds, in this
case we only need to remove the string in that test alone.

I prefer (2) but I'd apologize in advance I don't have almost any time
upstream before forum (replied this one only because I want to raise the
point of using old test, in case Fabiano's already in PTO), I'm not sure if
someone thinks it worthwhile.

Thanks,

-- 
Peter Xu


