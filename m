Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B75EC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 08:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkJRg-0001Yo-Oh; Tue, 18 Feb 2025 03:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tkJRb-0001YJ-D0
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:59:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tkJRZ-00054F-Mr
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739869145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qIwuXD6/ONz2171hIJuj+xhguDKZYXrMniDXK/rZZdw=;
 b=ZKR40Zw1dtgNokOnwmuZT3nskPgQqskTrMNMHixtumMCelfce/91GYJh/XfOjsxhgRaOGG
 kzpuHfCeRXdVgTlkshzwNjBPeB9UliPNS2EGZqGSUNMuRx9HJWTgLD5lSwWwO3jw0tCbvK
 LL86n7GZqEhZCCpfpVYSwzaAIG3iumM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-yl0tTTylO1-vVTbxeRiAgw-1; Tue, 18 Feb 2025 03:59:03 -0500
X-MC-Unique: yl0tTTylO1-vVTbxeRiAgw-1
X-Mimecast-MFC-AGG-ID: yl0tTTylO1-vVTbxeRiAgw_1739869142
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f28a4647eso2835316f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 00:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739869141; x=1740473941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qIwuXD6/ONz2171hIJuj+xhguDKZYXrMniDXK/rZZdw=;
 b=Oryz5wzTUdLPvAKbCsg1ycqY6aZugEqNkHO9zOisk8SB/SUG+XJVLNQd+6+dEcOJhl
 QH8kAaQDESGKGsu4sBcKk0MF/84d+QrdQ7HVly6JESuA+bu0+3D1zZLLVBTyYMQ4EtAU
 H2ypYcf9TCQx+e6ZrTlpqs7tmJlZRdS1lJmcZeYB1S9UYY+QOclrSLr22Mx4zTfde3so
 OJxuWy64Cuo1fcn/Te1OmnRBgL60BQSPOVuAaVBNN4b53D5QAZ7aOzsd7kdLMhO7fec6
 9rQuYLbXkDqnk6JyDkJ61VIMOAG40/jsHCxzEw+wxPQeVInQ4NMIwp6aHKoPCaFgkZ+P
 SoWw==
X-Gm-Message-State: AOJu0YwP/rynyrQPUGFF+nc1LNSS9nM2pDzU8rd494dtlSdwt547dK1t
 Gn8E5rgA7ZKejjfvjqX0kpVzZbWng1cm9L2HTaiuGABCmBgeOPntaOOxL3WHjmbi61NFjbQoikC
 fGmVVinNahSlOkoLmfKelznEpo0y6jSgvWXbdzwJtL/HgFeEVN5e2yaBU3iMCuhWbSpXk0A4/zM
 s94htNyiT7YGDTcR256q5QAPz/8IQghWcdZ2vSQA==
X-Gm-Gg: ASbGncu5Xf90MCjzIU8x5/9EVa1m8qWDSzJGidd1WNT0A2UVDOmpbA9vguetZdPEyKo
 0699BqnOKnSqnVcyQ/wk0mMTHLnWt1AGw0F112LDEaTKxNFFk5jSkXqge45Xmj9tX
X-Received: by 2002:a05:600c:3ba5:b0:439:9377:fa21 with SMTP id
 5b1f17b1804b1-4399377fbccmr12667295e9.19.1739869141512; 
 Tue, 18 Feb 2025 00:59:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOx99PiL6zXdxdaM6BzAGuNmGRrf4IMqAV/8pJMq3qtj/ygPczmiGVIdzLmhVi80M++jBtX4DgMRPJKEjTplY=
X-Received: by 2002:a05:600c:3ba5:b0:439:9377:fa21 with SMTP id
 5b1f17b1804b1-4399377fbccmr12667135e9.19.1739869141217; Tue, 18 Feb 2025
 00:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-5-ppandit@redhat.com>
 <871pvwvb69.fsf@suse.de>
In-Reply-To: <871pvwvb69.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 18 Feb 2025 14:28:44 +0530
X-Gm-Features: AWEUYZmuB9odVLEksm8uqsEHzHGkT8JV4ZDfZLY28CVVlnG2W0bpRPuHKk_O-5U
Message-ID: <CAE8KmOzknFTcKnSp3iQwhV__e0_r-kJnXDy3x3zeyrohH5B6Tg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] tests/qtest/migration: add postcopy tests with
 multifd
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 17 Feb 2025 at 21:03, Fabiano Rosas <farosas@suse.de> wrote:
> > @@ -110,6 +129,10 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
> >              "/migration/postcopy/recovery/double-failures/reconnect",
> >              test_postcopy_recovery_fail_reconnect);
> >
> > +        migration_test_add("/migration/multifd+postcopy/plain",
> > +                           test_multifd_postcopy);
> > +        migration_test_add("/migration/multifd+postcopy/preempt/plain",
> > +                           test_multifd_postcopy_preempt);
>
> For postcopy-tests.c I'd use /migration/postcopy/multifd so we can run
> them all via command-line. These are also the only ones actually doing
> postcopy migration. We need to distinguish multifd+postcopy proper from
> merely postcopy-ram=true.

* ie. repalce 'multifd+postcopy'  with '../postcopy/multifd/' only in
postcopy-tests.c? And keep other instances unchanged?

...
> >
> > +static void test_multifd_postcopy_tcp_cancel(void)
> > +{
> > +    postcopy_ram = true;
> > +    test_multifd_tcp_cancel();
> > +    postcopy_ram = false;
>
> You could pass this in, there's just one other caller.

* Sorry, what do you mean here?

Thank you.
---
  - Prasad


