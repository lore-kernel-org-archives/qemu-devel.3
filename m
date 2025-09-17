Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7798CAC59F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 22:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz0Cu-00075r-4K; Wed, 17 Sep 2025 18:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uz0Cq-00075T-Gs
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 18:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uz0Cn-0007ua-KE
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 18:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758146447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DLo0rzb+dJKCDFRyYv+riUgX2y/rgevETSxpRS/05vk=;
 b=Pe2rlVJi3TWstkuSps3MdHxlH8rn8pQ2Gq6umLfC8SDRr+LTtjZPzyJP1QgNxJwhokkKsh
 1JbnWt19z88aYQmmf+rKRj/NnwxxMG6EK8JUClYvBKN3BsTjIayIzaHpzKL4Ya6XppT7PK
 slec0EyVkJCBdnewQp5ATdNo44Iw4y8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-e_QqIDEBMrqFeimuGSPmRw-1; Wed, 17 Sep 2025 18:00:46 -0400
X-MC-Unique: e_QqIDEBMrqFeimuGSPmRw-1
X-Mimecast-MFC-AGG-ID: e_QqIDEBMrqFeimuGSPmRw_1758146445
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b5e303fe1cso4899241cf.2
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 15:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758146445; x=1758751245;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLo0rzb+dJKCDFRyYv+riUgX2y/rgevETSxpRS/05vk=;
 b=Ldr9gtK0FWYW65WKrXpIQ4MAMjMNO690mQx6zhGjynJZ7HCGM8qdhrUlpO+9vkH2V9
 zPdyDOLdmEzq8+by6Uy8iLWnmyJvvMc5Q53ynAdc7/luQL9/cmhnKr88ygj/rupGt6bu
 KDb4QQvYcd7hW38JMiUwkfMhV2Zy/SlVkaAPZHowYGPoYaIasM9JznHEJOrrIxOwQwmV
 eqbGwE1ZQnUrr3sy11iU1KpnyKSlZ6NEa2ks/8vZ22CFiycjQzucXfdGChQFQzitEAQm
 eyQRGghb9kQ6wyWGkSSuhuubOUzu/D9ZK9MpUV98rAL0gXnXtb1JVbRTLRJHhXgDKoYQ
 WuTg==
X-Gm-Message-State: AOJu0Ywbrz79NsInhV6qySDZoS8adL3xLSmX5+IfnUs0LYjN3eaZZ+fK
 4vfAdcgju4N6JqQ3z8zot2Oz2sFM0+0OrTbaWawQTieOlhCsPn0sexxdv8huo/Ngt4wvkMxb9Uj
 hFZpF2JvTT7I6Zt6IYfzZhZVFii9WXqE1ktiprqJFLIvc0RAq/APhLp8D
X-Gm-Gg: ASbGncskuO2IT9+igyD8gzNOaH+d4vWm9pIdzeZd2oZSUaJ+7TOtSsPA1I+iA8z2yyf
 gg6hWpv3Vs2fjkqkEiW09dkWjOuzntky90FN3wzI1eyH1IjH6FCNSF6pkQhbSsVc21/5QRmSTRk
 ex7hTcBkiZJY2j2h0opnD2HK13T8bFS2xGq1j0vdoMzVyYaGoDzU5l72vz/ZnqqMfP/AbUlin8Q
 PWJLBxjDbiZtC2dXdjuLXvhFMFpwDZ0A4E4P2eHSgr6x5mz65zx6Kk2SDYq7Ixk7Ll6zNKhCrlv
 iVSwNCG68IBGQmUu9ZVEWcW1yF2TyY0zgoY6ytYbaPbJ700pP59xZgMpQjDGuyzMTLDtljPZ8QK
 /bXWhpafAr1f68pqmzh6/WQ==
X-Received: by 2002:ac8:5a42:0:b0:4b5:d932:15d8 with SMTP id
 d75a77b69052e-4ba66750b07mr41918451cf.14.1758146445244; 
 Wed, 17 Sep 2025 15:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOAELiHnDB9Xlmv3TSdngM+U3D6Q5yEBp6vGqAuKBCtHIEpqUYZR4h1EmnV/PUoa6ZQcfmhA==
X-Received: by 2002:ac8:5a42:0:b0:4b5:d932:15d8 with SMTP id
 d75a77b69052e-4ba66750b07mr41917781cf.14.1758146444587; 
 Wed, 17 Sep 2025 15:00:44 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-83627d7d9c5sm52595885a.20.2025.09.17.15.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 15:00:44 -0700 (PDT)
Date: Wed, 17 Sep 2025 18:00:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 2/3] migration: Make migration_has_failed() work even for
 CANCELLING
Message-ID: <aMsvitYEzHao0i83@x1.local>
References: <20250910160144.1762894-1-peterx@redhat.com>
 <20250910160144.1762894-3-peterx@redhat.com>
 <87wm5wvm1l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wm5wvm1l.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 17, 2025 at 05:52:54PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > We set CANCELLED very late, it means migration_has_failed() may not work
> > correctly if it's invoked before updating CANCELLING to CANCELLED.
> >
> 
> The prophecy is fulfilled.
> 
> https://wiki.qemu.org/ToDo/LiveMigration#Migration_cancel_concurrency
> 
> I'm not sure I'm convinced, for instance, CANCELLING is part of
> migration_is_running(), while FAILED is not. This doesn't seem
> right. Another point is that CANCELLING is not a final state, so we're
> prone to later need a migration_has_finished_failing_now() helper. =)

Considering we only have two users so far, and the other user doesn't care
about CANCELLING (while the multifd shutdown cares?), then I assume it's ok
to treat CANCELLING to be "has failed"? :)  I didn't try to interpret "has
failed" in English, but only for the sake of an universal helper that works
for both places.

Or maybe it can be is_failing() too?  I don't have a strong feeling.

> 
> My mental model is that CANCELLING is a transitional, ongoing state
> where we shouldn't really be making assumptions. Once FAILED is reached,
> then we're sure in which general state everything is.
> 
> How did you catch this? It was one of the cancel tests that failed? I
> just noticed that multifd_send_shutdown() is called from
> migration_cleanup() before it changes the state to CANCELLED. So current
> code also has whatever issue you detected here.

No test failed, it was only by code observation, mentioned below [1],
exactly as you said.

I just think when cancelling the tls sessions, we shouldn't dump the error
messages anymore even if the bye failed.  Or maybe we simply do not need to
invoke migration_tls_channel_end() when CANCELLING / FAILED?  That's
relevant to your ask on the cover letter, we can discuss there.

This is very trivial.  Let me know how you thinks.  I can also drop this
patch when repost v3 but fix the postcopy warning first, which reliably
reproduce now with qtest.

> 
> > Allow that state will make migration_has_failed() working as expected even
> > if it's invoked slightly earlier.
> >
> > One current user is the multifd code for the TLS graceful termination,
> > where it's before updating to CANCELLED.

[1]

> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 7015c2b5e0..397917b1b3 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1723,7 +1723,8 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
> >  
> >  bool migration_has_failed(MigrationState *s)
> >  {
> > -    return (s->state == MIGRATION_STATUS_CANCELLED ||
> > +    return (s->state == MIGRATION_STATUS_CANCELLING ||
> > +            s->state == MIGRATION_STATUS_CANCELLED ||
> >              s->state == MIGRATION_STATUS_FAILED);
> >  }
> 

-- 
Peter Xu


