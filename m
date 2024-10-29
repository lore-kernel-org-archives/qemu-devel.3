Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52393D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 14:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nTY-0000jO-6v; Tue, 29 Oct 2024 10:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5nTX-0000j9-Ik
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5nTU-0002o8-UI
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730213133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Qo2Rufronj31+T27+hZcVVcX0Fj9CajExJQlZUb8HU=;
 b=TMFBo1AFDaZbZglCyZ3xZ0W6EM0YS4IiHJa0UNRwy6w2Nr7g2HDBrTvNOlR6obMl4cQbhA
 TSFLyfuwrc9KK3kv6BJNJrv3NRaeRtn0uZJFag7ROjDc/Y2b8Kww5Y/Wdh70g1WZRMgBJ5
 UciDKnecKsFzS8gmg0KEtj+yNo/EaUU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-CxBDDUoOPSypOclTuaiWdA-1; Tue, 29 Oct 2024 10:45:28 -0400
X-MC-Unique: CxBDDUoOPSypOclTuaiWdA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4608a1a8d3eso135602861cf.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 07:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730213127; x=1730817927;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Qo2Rufronj31+T27+hZcVVcX0Fj9CajExJQlZUb8HU=;
 b=t0pOnKQP4WaHhGwmhmQ6yexY9HoBTWg9OG/CjYXF7kqTJvZ0ATiM1I2WhkE7xiafm1
 W8864+XZTbWvp3idSMWJfTgHMkbd8az/J3skKZRSePnr2n2/1YaGUGUW+6hmSJCz7nTI
 FN2tC8jfIZgYMXBlMbLWbexWKHDBaCCGFu9ahjtVj6j8tGpSlYZLsqJyPsWxa3heNVdS
 PWqCN6qbRQGiM55EDn5fLooYb3E++UpbczL17zFGb6mAPHSqsWXfuq6RObm2M8Vtkc4J
 KIEd7ybcD+ZubJnPpDzy2QyCNWY5ObYWimtnqJCVO6JbVY9R7aNVD5r3kUMND+tWbWej
 TGrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3agXw6Id+61nskJGijqzHY5wHX1qvx3WeZDh1V54lkhFyUPf6Q2am2UxeWJEuLFy1Ma79r7JmDnVz@nongnu.org
X-Gm-Message-State: AOJu0Yyv7bevCc6NLlJbFHDK6mqh9P8822VV4t/dzKvSk4u2NrlgfDbo
 JDl+0ddU2Mc7sSdDP5m0ZodxDuE5AuTTr/mfNlWxLo54hn8Oc85MU+0OW3iBB/JO/IgmQ8GFEbL
 Im/6xNh7Vg12zCyBV1pk0pwRy2Ok6Rz/Vy18DtRLD+rt3EKaPmGyD
X-Received: by 2002:ac8:7c47:0:b0:460:40c2:7493 with SMTP id
 d75a77b69052e-46168059f65mr35040941cf.7.1730213127538; 
 Tue, 29 Oct 2024 07:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWklLqexV1BpKL0fCY6r+ZgVziLj7Y+79Y8MFAzIYiLMse9pU8QByR4jFAsIagNRApyIw+Sg==
X-Received: by 2002:ac8:7c47:0:b0:460:40c2:7493 with SMTP id
 d75a77b69052e-46168059f65mr35040481cf.7.1730213127147; 
 Tue, 29 Oct 2024 07:45:27 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d32b9adsm419802885a.84.2024.10.29.07.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 07:45:26 -0700 (PDT)
Date: Tue, 29 Oct 2024 10:45:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/4] QOM: Singleton interface
Message-ID: <ZyD1BarDJUSA7Nen@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <87h690my2w.fsf@pond.sub.org> <Zxuy5CjKNlK49TUL@x1n>
 <ZyC8MmM7k6df2Awi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyC8MmM7k6df2Awi@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Oct 29, 2024 at 10:42:58AM +0000, Daniel P. Berrangé wrote:
> On Fri, Oct 25, 2024 at 11:01:56AM -0400, Peter Xu wrote:
> > On Fri, Oct 25, 2024 at 09:38:31AM +0200, Markus Armbruster wrote:
> > > Peter Xu <peterx@redhat.com> writes:
> > > 
> > > > This patchset introduces the singleton interface for QOM.
> > > >
> > > > The singleton interface is as simple as "this class can only create one
> > > > instance".
> > > >
> > > > We used to have similar demand when working on all kinds of vIOMMUs,
> > > > because in most cases that I am aware of, vIOMMU must be a singleton as
> > > > it's closely bound to the machine and also the root PCIe systems.  We used
> > > > to have a bunch of special code guarding those, for example, X86 has
> > > > pc_machine_device_pre_plug_cb() just to detect when vIOMMU is created more
> > > > than once.
> > > >
> > > > There is a similar demand raising recently (even if the problem existed
> > > > over years) when we were looking at a migration bug, that part of it was
> > > > involved with the current_migration global pointer being referenced
> > > > anywhere, even after the migration object was finalize()ed.  So far without
> > > > singleton support, there's no way to reset the variable properly.
> > > > Declaring migration object to be a singleton also just makes sense, e.g.,
> > > > dynamically creating migration objects on the fly with QMP commands doesn't
> > > > sound right..
> > > >
> > > > The idea behind is pretty simple: any object that can only be created once
> > > > can now declare the TYPE_SINGLETON interface, then QOM facilities will make
> > > > sure it won't be created more than once.  For example, qom-list-properties,
> > > > device-list-properties, etc., will be smart enough to not try to create
> > > > temporary singleton objects now.
> > > 
> > > QOM design assumption: object_new() followed by object_unref() is always
> > > possible and has no side effect.
> > 
> > I see.
> > 
> > > 
> > > QOM introspection relies on this.  Your PATCH 1 makes non-class
> > > properties of singletons invisible in introspection.  Making something
> > > with such properties a singleton would be a regression.
> > > 
> > > Anything that violates the design assumption must be delayed to a
> > > suitable state transition.  For devices (subtypes of TYPE_DEVICE), this
> > > is ->realize().  For user-creatable objects (provide interface
> > > TYPE_USER_CREATABLE), this is ->complete().  For anything else, it's
> > > something else that probably doesn't even exist, yet.  See "Problem 5:
> > > QOM lacks a clear life cycle" in
> > > 
> > >     Subject: Dynamic & heterogeneous machines, initial configuration: problems
> > >     Date: Wed, 31 Jan 2024 21:14:21 +0100
> > >     Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
> > >     https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
> > 
> > The major challenge here might be that, in migration's use case we want to
> > do something after the last refcount is released.
> 
> This is rather a strange idea, and feels back to front. An object's last
> refcount must never be released until code has entirely finished using
> the object.
> 
> > IOW, I don't yet see an easy way to explicit do qdev_unrealize() (even if
> > migration object will use realize(), while it doesn't yet..), because there
> > can be more than one thread holding refcount of the object, and we don't
> > know where to invoke it, and we don't want to do the cleanup if the other
> > one still holds a refcount.
> 
> This sounds like the code is missing some synchronization mechanism
> beween the threads, which need to communicate with each other when
> they are "done", so that the "primary" thread can then finally
> release any resources.
> 
> > Maybe I can also try do that with a "magic property" with its set/get, as
> > that's indeed the other hook (basically, object_property_del_all()) that is
> > only invoked after the final refcount is released.  However I think we
> > still need the singleton idea somehow..
> 
> Based on the description above it feels like the problem is outside
> of QOM, around the lack of synchronization across threads.

Right, this used to be discussed here and you were also in the loop:

https://lore.kernel.org/qemu-devel/20190228122822.GD4970@work-vm/

I kind of agree join() would be perfect, disregard the question on whether
QEMU would still benefit from a singleton interface, no matter migration
would rely on that for refcounting, or simply it'll also make sense to just
avoid people creating random migration objects.

So yes, I think migration can benefit from singleton idea for more than one
reason, while the refcount issue here might be even better resolved by
join() in main.

It's just that in the thread Dave raised a few points on possible
challenges on join() in the main thread.  I'm not sure whether we should go
that route instead.  Obviously I am digging one of our legacy rabbit holes
from when I started to look at this "access current_migration anywhere"
issue reported from VFIO.  But if some of us think we should give it a
shot, I can try.  After all, I started digging.

Another simpler but direct solution to "access current_migration" is, we
simply don't free it at all, leaving process exit() to do the job.  Then I
can drop all object_[un]ref() for the migration object.  I think that could
work too, but ugly, for the refcount issue.

Thanks,

-- 
Peter Xu


