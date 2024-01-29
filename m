Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC7BC47DDF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 02:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHkH-0001IW-Io; Sun, 28 Jan 2024 21:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHkF-0001I7-QH
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 21:51:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHkD-0000g4-W0
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 21:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706496692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQ6A9nBrW8nPlhkYv3MIGSl5aT9C6NGpQkEBGkINVEQ=;
 b=VklLl4Hxf4LwWCAmYC6Uika7JFGH54rQ9pKggMjhlQ6I9hLXiFTOakjLqNO2qDJYkxPjZR
 gcg4bmRlp87FmT/tQibvxntlDHGXaDY6TOV1hlhOugVeetVV26likgoJMS4QVKCl0FWSdH
 UemUcoDuPTQCEIkZ0HAgbAh9tjhsTok=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-9098uunAPGmchxk0piwxBw-1; Sun, 28 Jan 2024 21:51:31 -0500
X-MC-Unique: 9098uunAPGmchxk0piwxBw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6da5a9defd5so411890b3a.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 18:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706496690; x=1707101490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQ6A9nBrW8nPlhkYv3MIGSl5aT9C6NGpQkEBGkINVEQ=;
 b=FAlhpu4U3ZMeXBUeuw7IQau9WVnakIyGYp79jkCRNIfSX0MjqPoMw4VYzvblUos5PH
 bT3MATvfNjGrWhAuwouer3hc466ag/e/EEaD30r2Lco3daI3O+y7Thcy6Ho6hHCXQkez
 bcj02s5C34ihrtGpaJGsx4w5e2vC36c2FRHud+55Goi/FgwmiiIEQBYQm3syXov++rI4
 xgqK9aMf84tho1ZLHHjm3GnnBM3XGBBUYSNqeSLrxG2i4tsn33dufquGF6OGBNy2waAC
 H9p+b70TQ+igyFo4s7/M58Nf2Zokea+pP8Ty/VgE2UUdFeeSK/To8rLvBohSauep/Wdk
 l5+w==
X-Gm-Message-State: AOJu0YyENIxWo1uN/38qJSsHQrHxLR835/SozL9/ThsvE0WOeq90fh5T
 clCXIFdvRcpeYseFOyu/q9WdxNjkslDEmXeiLxcD0pD237HshkbcNWuTfCJNqiqKJs3S3YI7end
 HXqnQ5V7AZ0ky3afSl5106Qi30dNKD5DodICLs+cSARaHlkMPJnha
X-Received: by 2002:a05:6a20:8e06:b0:19c:9b7d:bb36 with SMTP id
 y6-20020a056a208e0600b0019c9b7dbb36mr8345489pzj.2.1706496689996; 
 Sun, 28 Jan 2024 18:51:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESwQU3bQqhhxmSMGO/5ybE/MH0NcpZdrXU8c5Fc+aBmtEIwDziu2Tcy3XAbRsgZ47n5UgvYg==
X-Received: by 2002:a05:6a20:8e06:b0:19c:9b7d:bb36 with SMTP id
 y6-20020a056a208e0600b0019c9b7dbb36mr8345483pzj.2.1706496689550; 
 Sun, 28 Jan 2024 18:51:29 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 m12-20020aa78a0c000000b006ddb1286b74sm4715895pfa.105.2024.01.28.18.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 18:51:29 -0800 (PST)
Date: Mon, 29 Jan 2024 10:51:23 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
Message-ID: <ZbcSqyGNLGu7ugBb@x1n>
References: <20240126041725.124562-1-peterx@redhat.com>
 <20240126041725.124562-7-peterx@redhat.com>
 <87le8c6u1d.fsf@suse.de>
 <CAFEAcA-x4WqvPsN-KZOA3SPN0F=vvYi=NFZ2qom2iT7-CN0RSg@mail.gmail.com>
 <87il3g6t7b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il3g6t7b.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jan 26, 2024 at 11:54:32AM -0300, Fabiano Rosas wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On Fri, 26 Jan 2024 at 14:36, Fabiano Rosas <farosas@suse.de> wrote:
> >>
> >> peterx@redhat.com writes:
> >>
> >> > From: Fabiano Rosas <farosas@suse.de>
> >> >
> >> > The 'max' cpu is not expected to be stable in terms of features across
> >> > QEMU versions, so it should not be expected to migrate.
> >> >
> >> > While the tests currently all pass with -cpu max, that is only because
> >> > we're not testing across QEMU versions, which is the more common
> >> > use-case for migration.
> >> >
> >> > We've recently introduced compatibility tests that use two different
> >> > QEMU versions and the tests are now failing for aarch64. The next
> >> > patch adds those tests to CI, so we cannot use the 'max' cpu
> >> > anymore. Replace it with the 'neoverse-n1', which has a fixed set of
> >> > features.
> >> >
> >> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> >> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> > Link: https://lore.kernel.org/r/20240118164951.30350-2-farosas@suse.de
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> > ---
> >> >  tests/qtest/migration-test.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> >> > index 7675519cfa..15713f3666 100644
> >> > --- a/tests/qtest/migration-test.c
> >> > +++ b/tests/qtest/migration-test.c
> >> > @@ -820,7 +820,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >> >          memory_size = "150M";
> >> >          machine_alias = "virt";
> >> >          machine_opts = "gic-version=max";
> >> > -        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
> >> > +        arch_opts = g_strdup_printf("-cpu neoverse-n1 -kernel %s", bootpath);
> >> >          start_address = ARM_TEST_MEM_START;
> >> >          end_address = ARM_TEST_MEM_END;
> >> >      } else {
> >>
> >> This breaks the tests on an arm host with KVM support. We could drop
> >> this patch from the PR, it doesn't affect anything else.
> >>
> >> Or squash in:
> >>
> >> -->8--
> >> From b8aa5d8a2b33dcc28e4cd4ce2c4f4eacc3a3b845 Mon Sep 17 00:00:00 2001
> >> From: Fabiano Rosas <farosas@suse.de>
> >> Date: Fri, 26 Jan 2024 11:33:15 -0300
> >> Subject: [PATCH] fixup! tests/qtest/migration: Don't use -cpu max for aarch64
> >>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  tests/qtest/migration-test.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> >> index 15713f3666..2ba9cab684 100644
> >> --- a/tests/qtest/migration-test.c
> >> +++ b/tests/qtest/migration-test.c
> >> @@ -820,7 +820,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >>          memory_size = "150M";
> >>          machine_alias = "virt";
> >>          machine_opts = "gic-version=max";
> >> -        arch_opts = g_strdup_printf("-cpu neoverse-n1 -kernel %s", bootpath);
> >> +        arch_opts = g_strdup_printf("-cpu %s -kernel %s",
> >> +                                    qtest_has_accel("kvm") ?
> >> +                                    "host" : "neoverse-n1", bootpath);
> >>          start_address = ARM_TEST_MEM_START;
> >>          end_address = ARM_TEST_MEM_END;
> >>      } else {
> >
> > If you want to do that then a comment explaining why would be
> > helpful for future readers, I think.
> 
> Ok, let's drop this one then, I'll resend.

I'll drop this one for now then, thanks.

Just to double check: Fabiano, you meant that "-cpu host" won't hit the
same issue as what "-cpu max" would have for the new "n-1" CI test, right?

I can also wait to read your patch if that will contain the explanations.

-- 
Peter Xu


