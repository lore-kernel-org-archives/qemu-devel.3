Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FBDD3943A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 15:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Jy3-0007ft-7P; Thu, 02 Apr 2026 11:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8Jxz-0007fV-Qq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8Jxx-0005Ps-Al
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775143695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJESAtxqsZMKzcOizUBiIb+xWW9p/W9IBvakz8KuL6E=;
 b=FLSp5yegv/T/T6AXDTIJYiVjYQ+lUbNx+y83WBLxUhDH1849z1H00gFhl3IHf+4rrqu2Us
 Fme3Z7Wy7NVr3viT0avPI8ZPVhwOPzmxWWG1732j3uSRUPXti6S7z+0byNW8EtmIJeWBIB
 H+rV1NCvsdym2l4uxzfwQjmao4Wu5mw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-NK1syj7JPOu-LUHVXohy0w-1; Thu, 02 Apr 2026 11:28:13 -0400
X-MC-Unique: NK1syj7JPOu-LUHVXohy0w-1
X-Mimecast-MFC-AGG-ID: NK1syj7JPOu-LUHVXohy0w_1775143693
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8d3bb33c8b8so61432085a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775143692; x=1775748492; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EJESAtxqsZMKzcOizUBiIb+xWW9p/W9IBvakz8KuL6E=;
 b=URipNs7T/pJU+tl/ia1/tCkOJRPV+V9ehut8atWAzCIOK59EjDQ0KipCLI8JessouZ
 2gLvc7okZOmxkqllOU/7JUq3Nl2RXovE0GIr1NPdzfDG9psGnmxgAVjn5uNltrSxIffQ
 1ru/vlzmqacpXXZYHokkkRbpI/1BWXvd/0/q1xSEpuA+vwkf0ZebzP8j0EoPCDMtjT37
 bNn890KVcHkJII5BI6rweCq+6bBShdKbCtD8UNbq7tfwpavRWlvbLFniS0DHMER4fN5E
 cTLbrimBz59bAK8RvyyZcLf0Ha86NzygsnKSI2vofiHfv9eMJ+656Qj6VvtSkN1gVa9t
 /MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775143692; x=1775748492;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EJESAtxqsZMKzcOizUBiIb+xWW9p/W9IBvakz8KuL6E=;
 b=V1iZgZRiKIAVPI3epjQBjldFLJa8vmbWROOtMjW/eYjBD07xRI2bor8LqZdKMF81Sw
 5W5jG9GPhn8rWVRr+LDYrVpfF8t5AbpTSs2URxbpzZIp7+v/U2YiWBImKOh57bUSRNj4
 +kSHVrP8LOfZPmtzVVPZTWJiOH55YrnCsF8/KdeEyn7HDJjdQnOVegiEQmLdxzRbhVXR
 hZAo6HIS2MUuTOAhRxZb5y5fP/sQeXszxxRPFf6lO7ulK333wC0iFc7qSqoNK7o3gXbN
 1ZQMYhimilZN6bXp6O5pYit+e0Nwuz/Oz58S1lk1bAfHMfcBujxTqMZGyai+oltg2Cs2
 OnUA==
X-Gm-Message-State: AOJu0YzCzDwWUErwHFpkLkuhJSJWnXM8iAMJf8sePX2stufGXSXVjT4w
 /GdtV8/P8P2dmDW+N+E6rKPt5cC0eiwn8l6LQp08O/nEhWZZSZRxXd2RwJnqMiUtWhjFXnzofJX
 6bLH3uW9zkfmg1kofK8CMvEgKRS19G7aCpNsecOl2OefggTMzmCrizKAS7gqcD6+M
X-Gm-Gg: ATEYQzwAwD9wZJuB6Rtj2+KQ8obG+n3xvbxFIGGHuHXkpcRW1+xfDuPLShf2Ax32ZF0
 COQqDLvS4KBj9AZr6LVnr9isyIIf0wG5i1x1VRvXFY00KLdumczR3VFdugf1GEEM+XLBAKiJR4v
 xetEBYObPVJVe9sNFpAS8sxqk2usP+O86aaLtrkfhUilMt/ehXwsPImlqVo3sNLEamSsBhJCnUY
 Bu2sux6XknQfqWXH1ySozmh7grmUUKCpfHm4esxphlwohPiPqCuov8sIsETLf1PqwHC05qkf1Xu
 Rqhr+RE7yL04qgkn1d5gLhicbkEHV8PHHViL/UTHvAqnXpEcOT+SO20d4TH3GD8se69Fbl8k//4
 iij/F9OeLXf7tHEXriFXZc1nFoxmi/BNEYSDB0+X3yUpUgg==
X-Received: by 2002:a05:620a:2886:b0:8c7:ad9:d0a2 with SMTP id
 af79cd13be357-8d1b5af80f0mr1168247285a.22.1775143691617; 
 Thu, 02 Apr 2026 08:28:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2886:b0:8c7:ad9:d0a2 with SMTP id
 af79cd13be357-8d1b5af80f0mr1168238085a.22.1775143690914; 
 Thu, 02 Apr 2026 08:28:10 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a806e54bsm270069185a.30.2026.04.02.08.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:28:10 -0700 (PDT)
Date: Thu, 2 Apr 2026 11:28:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 08/12] vfio/migration: Fix incorrect reporting for
 VFIO pending data
Message-ID: <ac6LCWmVHl8fq81J@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-9-peterx@redhat.com>
 <e6a9aaf2-e2ab-4b25-a01d-b6093922668e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6a9aaf2-e2ab-4b25-a01d-b6093922668e@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 25, 2026 at 07:32:12PM +0200, Avihai Horon wrote:
> 
> On 3/20/2026 1:12 AM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > VFIO used to report different things in its fast/slow version of query
> > pending results.  It was likely because it wants to make sure precopy data
> > can reach 0 hence trigger sync queries.
> 
> It was to guarantee precopy data can reach 0 and trigger dirty sync queries,
> since not all VFIO device data may be precopy-able.

Thanks for confirming.

> 
> > 
> > Now with stopcopy size reporting facility it doesn't need this hack
> > anymore.  Fix this.
> 
> Looks good, now the fast/slow path are consistent, plus we get the benefit
> that if VFIO device has much stopcopy data, migration will try to reduce
> RAM/other iterative devices to the minimum continuously instead of jumping
> from fast to slow path as it currently does.

Yep.

> 
> I still want to test this later with a few workloads, just to make sure we
> don't miss anything here.

Thanks a lot.  Let me know if there's any update.

> 
> > 
> > Copy stable might be too much; just skip it and skip the Fixes.
> > 
> > Cc: Avihai Horon <avihaih@nvidia.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   hw/vfio/migration.c | 11 +++++++----
> >   1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index c054c749b0..9dbe5ad9e9 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -591,6 +591,10 @@ static void vfio_state_pending_sync(VFIODevice *vbasedev)
> >                             __func__, migration->precopy_init_size,
> >                             migration->precopy_dirty_size,
> >                             migration->stopcopy_size);
> > +        migration->stopcopy_size = 0;
> > +    } else {
> > +        migration->stopcopy_size -=
> > +            (migration->precopy_init_size + migration->precopy_dirty_size);
> 
> Query of stopcopy and precopy are not atomic, so we better use MIN() here:
> 
> migration->stopcopy_size -= MIN(migration->stopcopy_size,
> migration->precopy_init_size + migration->precopy_dirty_size);

Yes.  I'll revisit all these places on atomicity and possible overflow
issues in this series after I get better understanding on the "data shrink"
possibilities.

> 
> >       }
> >   }
> > 
> > @@ -598,19 +602,18 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending)
> >   {
> >       VFIODevice *vbasedev = opaque;
> >       VFIOMigration *migration = vbasedev->migration;
> > -    uint64_t remain;
> > 
> >       if (pending->fastpath) {
> >           if (!vfio_device_state_is_precopy(vbasedev)) {
> >               return;
> >           }
> > -        remain = migration->precopy_init_size + migration->precopy_dirty_size;
> >       } else {
> >           vfio_state_pending_sync(vbasedev);
> > -        remain = migration->stopcopy_size;
> >       }
> > 
> > -    pending->precopy_bytes += remain;
> > +    pending->precopy_bytes +=
> > +        migration->precopy_init_size + migration->precopy_dirty_size;
> > +    pending->stopcopy_bytes += migration->stopcopy_size;
> 
> Now that migration->stopcopy_size holds only the stopcopy size (and not
> stopcopy+precopy), we should remove these lines from
> vfio_update_estimated_pending_data():
> 
>     /* The total size remaining requires separate accounting */
>     migration->stopcopy_size -= data_size;

Good point, I missed this part when changing the definition, I'll fix.

Thanks,

> 
> Thanks.
> 
> > 
> >       trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
> >                                migration->precopy_init_size,
> > --
> > 2.50.1
> > 
> 

-- 
Peter Xu


