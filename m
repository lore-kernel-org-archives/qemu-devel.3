Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04B7C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUPW-0000Ov-80; Mon, 27 May 2024 03:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBUPN-0000LE-Id; Mon, 27 May 2024 03:04:37 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBUPL-0002QL-P1; Mon, 27 May 2024 03:04:37 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f8ea3e9543so2268707b3a.2; 
 Mon, 27 May 2024 00:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716793474; x=1717398274; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OkRTKUuLy+20YEprZvh0a0McG/3Sumb6XN5f4D5Erbo=;
 b=m+DchKSDI1qCG1B8rSOf1kZnVPdeJIeYHNMFWfNNlhAPHCMY9NJwefXVp5M2sqfffb
 vuKoEosIwgadTzGiB81qW+jQ0+aUJcXEMhawZDx9Ad2c340amayMPtCrOpFOIXNyhf/R
 gAQcUa0vjwTTW5EjYD9guW78YKWT1zcvAVv7WH2zh9LQTnLRINrzD4F2XBGy+QgYPjZm
 /NA47F2S5/BpMbcPY0FWmudM0W2O9mO2vc/hNkzShIScD666FNch/6+dUxLKZnlDkpjY
 GO3xPgZogxIxcFfx4IVyF9Gvq7FI5K596uqv10bihq9wHIBA7WKHA2g9lzPjC7i/Z842
 1wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716793474; x=1717398274;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OkRTKUuLy+20YEprZvh0a0McG/3Sumb6XN5f4D5Erbo=;
 b=e1RsKFd/SHm6ddyZhhmroMfXbp4FnvRnAwNeB7Bjzs/Xxpuk8oRyQz9w0ilKsQWyeP
 XEGVgm7D9ydQ7VG/knmlZVHIOsH04iy+58znOc00q827uYzZ98GD+JuUoHAUYKIsEJWl
 mCOPvxaGDC8ouroBPsO1jHt3x/xAtVbV5d9+gzhW/bdti1sLnKwZpFP283PjWD3ZQc0I
 C6J12YnHRN9+i/SiTCsldWxwE2Bqt0LRyI69M2WPPhLtTrjs+Cyt1H2ZBl1Oy90NS3O/
 wVtc4Gx8P4JuIwbStqWXlFCNaxt0TdPPXK55YDPjiXXNEQmbgAA44KndnxNrOxoNzNnt
 GuaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcp89JS+Y2OXKcx+V8eSGjQUJ8ZjTT5Q8HOggCLASyO4GZ6pX/f1pi+Xb9udibC0QmSNKi8PB2CmS2YZKjaUUjsp0fGGY=
X-Gm-Message-State: AOJu0YztNInovLbNVr/mw5p/i6HZNlAQQkfV/8Z8FHgDDbIe6PC2Wrdu
 aKZ4U1p6wTNkRJQYL+jOrd7D4DbCHtGDzDRQbJTi1ddyPtEb/jYV
X-Google-Smtp-Source: AGHT+IHYsCCq6xOCRUREuZOst4Vqlf46jEuJzc8iPyHCtu+Eqjs25z/Visquu2VgHFCPpZ6WN1jjSw==
X-Received: by 2002:a05:6a20:9f03:b0:1aa:6167:b6d6 with SMTP id
 adf61e73a8af0-1b212e20d21mr10848456637.42.1716793473682; 
 Mon, 27 May 2024 00:04:33 -0700 (PDT)
Received: from localhost ([1.146.73.168]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c967ad7sm53539885ad.136.2024.05.27.00.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 00:04:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 17:04:25 +1000
Message-Id: <D1K8HPYOSEZN.9TWVXUFHPPO3@gmail.com>
Cc: <qemu-s390x@nongnu.org>, "Halil Pasic" <pasic@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "David Hildenbrand"
 <david@redhat.com>, "Thomas Huth" <thuth@redhat.com>, "Peter Xu"
 <peterx@redhat.com>, "Fabiano Rosas" <farosas@suse.de>, "Laurent Vivier"
 <lvivier@redhat.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 2/3] tests/qtest/migration-test: enable on s390x
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Prasad Pandit" <ppandit@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240525131241.378473-1-npiggin@gmail.com>
 <20240525131241.378473-3-npiggin@gmail.com>
 <CAE8KmOwYPf_1rX_An0K5gncDAC7V5jvR735tEAomVJiVxOeyTg@mail.gmail.com>
In-Reply-To: <CAE8KmOwYPf_1rX_An0K5gncDAC7V5jvR735tEAomVJiVxOeyTg@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon May 27, 2024 at 3:46 PM AEST, Prasad Pandit wrote:
> Hi,
>
> On Sat, 25 May 2024 at 18:44, Nicholas Piggin <npiggin@gmail.com> wrote:
> > s390x is more stable now. Enable it.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  tests/qtest/migration-test.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> >
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.=
c
> > index 94d5057857..7987faaded 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -3428,16 +3428,6 @@ int main(int argc, char **argv)
> >      migration_test_add("/migration/analyze-script", test_analyze_scrip=
t);
> >  #endif
> >
> > -    /*
> > -     * On s390x, the test seems to be touchy with TCG, perhaps due to =
race
> > -     * conditions on dirty bits, so disable it there until the problem=
s are
> > -     * resolved.
> > -     */
>
>     -> https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg04774.=
html
>
> * Above patch (not reviewed yet) adds comment about sporadic problems
> on s390x, and this patch says s390x is stable now? It'll help to
> mention in the commit log - what changed to make it stable in 1 day.

Patch 1 of this series.

> * IIUC, this and the ppc64 patch above enable 'migration-test' for
> s390x and ppc64 platforms, when KVM is not available for them? ie.
> When running s390x & ppc64 migration-tests with TCG on non s390x or
> non-ppc64 machines, right? Maybe the commit message could say
> something to the effect of - enable s390x and ppc64 'migration-test'
> to run with TCG across platforms where KVM for s390x  OR  KVM for
> ppc64 is not available.

Yes they should be called "enable for TCG" indeed.

> > -    if (g_str_equal(arch, "s390x") && !has_kvm) {
> > -        g_test_message("Skipping tests: s390x host with KVM is require=
d");
> > -        goto test_add_done;
> > -    }
> > -
> >      if (is_x86) {
> >          migration_test_add("/migration/precopy/unix/suspend/live",
> >                             test_precopy_unix_suspend_live);
> > @@ -3619,8 +3609,6 @@ int main(int argc, char **argv)
> >                             test_vcpu_dirty_limit);
> >      }
> >
> > -test_add_done:
> > -
> >      ret =3D g_test_run();
> >
> >      g_assert_cmpint(ret, =3D=3D, 0);
> > --
>
> * Otherwise, the change looks okay to enable 'migration-test' for
> s390x with TCG IIUC.

Thanks,
Nick

