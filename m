Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A934C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 13:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXLR0-0003rh-FY; Fri, 26 Jul 2024 09:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sXLQx-0003ib-Dt
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sXLQu-0007UL-Da
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722002191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8z7SsfoN2HQ7Cgo72/UoGz9yU2FDpyyEcMlllaj3mg=;
 b=Z51rEy4+cbANtCJMCgXPtYNQ0X+mgYIh/O3eycheasZe7sF/CEwr89hmQ+FA5pQYvx+700
 HWGoxRHsmjAbXsKOCasStGfdFrfYYB+y8ucgPrQ5RedEMTMEJVpQWO7mR+RFaO25p5vOQx
 gK3uwxMYd0+mDBIC8m3Dqil/BF7OaNo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-xtGVu3hvPH2f_0T9ZC8osw-1; Fri, 26 Jul 2024 09:56:28 -0400
X-MC-Unique: xtGVu3hvPH2f_0T9ZC8osw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-668e964ffd9so56352607b3.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 06:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722002188; x=1722606988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8z7SsfoN2HQ7Cgo72/UoGz9yU2FDpyyEcMlllaj3mg=;
 b=i628YjhnXH50etkhlWJAMGsuuA+LZwSlmb0/Adh4o2dYyIyPG0Nl92cPS4Z0TUnZFC
 c6tIDzmjjJYlHiCqZijphrwy1UND3wCbCO9QbZSDMXeQv5FVhyl6FpVVbAvRqjVLqukk
 w328kYR7n7yhGW75BHi29fqvNx86cY/FtFsuQTENdO9zC+GqzN8FMPCxgC2EuX8vZy6u
 dtrabNULp6HmMA1noinI6uGVdEa8p/lc4aLaLl92UHnUUm3TOvoa9EASFGaHp4hc3C3o
 DKSlx05o1nisQLPebqLpCWFbfkieSEQk7rGqO8Wj1b4kmlbIaPyTK4tz6nLjYZTMVQ+f
 GyIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3XBrAX8Ee+6isXUOf4+mc44XeA4UUzYZ8ml0krLD9GkCEZxjvhsRVgQss/JOPPnWpTPnq/8uUgeILeJZhXdpaidthndE=
X-Gm-Message-State: AOJu0Yx/gZxnquZC6Wu+n1fTvnYCa4mUaLOm6y2ePquTg5sUFcPIng3e
 CTc8okek+iQI9O8JDhZBrT9GhJvcicqpbrgpwVHtXk0JkuEVuLmAo4OrzdwMvXNp1EOyoEf/che
 mPc50ChRNvX7ymEGxofriguLAaHx83Xa8pz9uLKxL7kVtXkRsO3f4kV0mlKuClAsWtzWJaOxcfj
 lv3H/EUrpqSj50KRB5ieT1QjDqUds=
X-Received: by 2002:a05:690c:4d49:b0:627:24d0:5037 with SMTP id
 00721157ae682-675ae520a81mr73940957b3.0.1722002188136; 
 Fri, 26 Jul 2024 06:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc+SAn9stI+xdwhyC5vhROvmZpdnGXqsgNwYrqGUN/FGZxni19fyWwhePjr932c2RJs40caFKExl6jxCqdJ7A=
X-Received: by 2002:a05:690c:4d49:b0:627:24d0:5037 with SMTP id
 00721157ae682-675ae520a81mr73940717b3.0.1722002187827; Fri, 26 Jul 2024
 06:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240716112614.1755692-1-thuth@redhat.com>
 <CA+bd_6LbLbR5hEqUhn5Vutf1k5HsB4Zg=qYF-Tq_pOrxDeWo1A@mail.gmail.com>
 <e6022904-7656-4f88-9cac-3c40a55c24e6@redhat.com>
In-Reply-To: <e6022904-7656-4f88-9cac-3c40a55c24e6@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Date: Fri, 26 Jul 2024 09:56:14 -0400
Message-ID: <CA+bd_6JgRESXwBQf+nbaC3OH=J5_v4Z85cxsdv-f-wKkDnoM4w@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Convert avocado tests to normal Python unittests
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 26, 2024 at 6:07=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 25/07/2024 16.21, Cleber Rosa wrote:
> > On Tue, Jul 16, 2024 at 7:28=E2=80=AFAM Thomas Huth <thuth@redhat.com> =
wrote:
> ...
> >> There have been several attempts to update the test suite in QEMU
> >> to a newer version of Avocado, but so far no attempt has successfully
> >> been merged yet.
> >
> > So, we've seen in the past an attempt to update Avocado from 88.1 to a
> > regular release, and the troubles it caused, including a revert.  My
> > take was that a LTS version should be used, but during this time,
> > Avocado experienced a rewrite and having it replacing the old
> > implementation in a production level project such as QEMU was tricky.
> > Then 103.0 LTS was released, and there was extensive work to test the
> > QEMU tests before that release was cut.  Additionally, there was
> > further work, but unfortunately not posted yet, to make use of 103.0
> > features in the existing tests[2].   I've tested on GitLab with tests
> > running in parallel, cutting job times in 1/3[2].  A side node is
> > that, because 103.0 is an LTS release, it will receive the needed bug
> > fixes and updates that we deem necessary, including things we find in
> > QEMU tests.  In fact, 103.1[3] is in the works.
>
>   Hi Cleber,
>
> thanks for the explanation, but we really need to replace v88 rather *now=
*
> since v88 does not work with the latest versions of Python anymore (there=
 is
> a work-around on Fedora fortunately, but it's completely broken on Ubuntu
> 24.04 as far as I know). So even a single-threaded execution with v103 wo=
uld
> have been better than waiting forever for your update to land. The proble=
m
> with v88 being broken has been raised a couple of times already, but it's
> incredibly hard to get a response from you Avocado folks, so with hardly =
any
> help from the Avocado side, and nobody on the QEMU side being really
> familiar with the Avocado stuff, and with the meson test runner being use=
d
> by all other subsystems in QEMU already, I think it's best if we continue
> with this series here.
>

Hi Thomas,

I agree with the urgency.  I've posted the updates here:

   https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg06236.html

Sorry for the delay, and I hope this gives more time to make the
evolution towards a solution that better suits QEMU.

Regards,
- Cleber.

> >> Additionally, the whole "make check" test suite in QEMU is using the
> >> meson test runner nowadays, so running the python-based tests via the
> >> Avocodo test runner looks and feels quite like an oddball, requiring
> >> the users to deal with the knowledge of multiple test runners in
> >> parallel (e.g. the timeout settings work completely differently).
> >>
> >
> > Now I believe we can be very much in sync here.  I've thought for a
> > while that there's no reason for Avocado to cooperate or be compatible
> > with Meson.  There's no reason why users can't simply pick how the
> > test gets run.  In fact, with the new Avocado architecture, you don't
> > even need to run "avocado" to run an "avocado-instrumented" test.  You
> > could pretty much run "avocado-runner-avocado-instrumented" with the
> > right parameters through Meson.
>
> Ok, good to know, we could maybe use that eventually for the tests that
> really require the Avocado framework (i.e. the cloud-init based tests).
>
> For the others, as Daniel said in an earlier mail, it's much more conveni=
ent
> if you can also run the tests directly instead, without such a layer in
> between - that makes debugging way easier.
>
> >> Only tests that use the LinuxTest / LinuxDistro and LinuxSSHMixIn
> >> classes (e.g. based on cloud-init images or using SSH) really depend
> >> on the Avocado framework, so we'd need a solution for those if we
> >> want to continue using them. One solution might be to simply use the
> >> required functions from avocado.utils for these tests, and still run
> >> them via the meson test runner instead, but that needs some further
> >> investigation that will be done later.
> >
> > So, I believe this type of higher level testing is something that
> > needs to remain, and even grow.  Speaking for Red Hat, I see the
> > movement of QE contributing more Avocado-VT style tests into QEMU
> > itself.
>
> I didn't really see such a movement in recent times yet ... Could you poi=
nt
> to an example?
>

Indeed, there is no public evidence of that, yet.

> >  This means way more libraries and features that go into a
> > common set of utilities and features (more on that later) than it
> > currently exists in avocado.utils.
> >
> > This brings the autils[4] initiative into the picture.  We're about
> > 80% done with the project structure, and after that, it will be a
> > common utility project (such as the cloudinit and ssh) which can be
> > released automatically when the maintainer votes (through GitHub) that
> > a new release is needed.
>
> autils sounds promising, but I just had a look at the repository, and the=
re
> does not seem to be that much code available there yet, so I guess it wil=
l
> take still quite a long time 'til that's ready?
>

Like I said previously, we were working on the project infrastructure.
We haven't ported much code over there yet.  There are very few things
missing, and all of them have been assigned to be worked on.  It's
been tracked here:

   https://github.com/avocado-framework/autils/issues/1

My estimation is that 2-4 weeks for the project infrastructure to be comple=
te.

Regards,
- Cleber.

>   Thomas
>


