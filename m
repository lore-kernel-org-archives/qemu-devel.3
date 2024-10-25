Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7988FD0C61F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Lpc-0005EP-85; Fri, 25 Oct 2024 11:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4LpM-00053L-GZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4LpH-0005nm-Nj
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729868525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ayimgUOV6oiNG2otsl8CtpEN9hd6vRsB4BAX4QQm5Hs=;
 b=Zav8YNM1WyK+hsDNjQBJq1so1TgMgcDp9+HwmpoAVgXW0eq4VFsj+jc4yq4CETYqiu8qy7
 DZTgknaYOY8JYrAW9W5MI3utxpMpHsTH+umkA4lR3368emL+evF1/X+dQr++zH+BtQcxg9
 bXG/KUBsweC1W6ub/wkdVDNIA5FzPHQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-inTg0k46M7uuGGekkluE7A-1; Fri, 25 Oct 2024 11:02:04 -0400
X-MC-Unique: inTg0k46M7uuGGekkluE7A-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-460c368028eso32204131cf.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 08:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729868524; x=1730473324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ayimgUOV6oiNG2otsl8CtpEN9hd6vRsB4BAX4QQm5Hs=;
 b=HPuJFQbpFgfjt7Rs/gvpS62fR1Cxj6FEvGWIygk2656ENtJ3MNO+rJrh64yobHxM+o
 xXqwm9IsTKuZyeMvYiDrU1Na8b8cXRZoQBK0WXQzlcFQnSzbXsEEorLWabFmHwvdox9y
 jyReehAiXPwTMmpjRPyflOhzPMWINRm3ZF8Vc/pBusBY7gHU1jsBeMMH7fEzT12HoB98
 3ZhBGOAloZMNFNR0jH+pTezJoErU5KObE+dA8kmQw8rWIfDm1H8J+Wv+/HExtlX7WXg+
 ZbJo4K2YvabPAs5zgTLXADpnlMVM4L/Dfyc0wcPyZvrL+uzdfPRuS6aVVPhPk4Dp54nf
 6CMw==
X-Gm-Message-State: AOJu0YwaTboRbdQhOBgMXaWDQOmdigKi9d2TkhAJZahJ9Aj8reYMWUob
 Ki4LJBVe5bk3orgBnOC8Rz198KKxhg8lBqSNuaNeq+No+1FeQUnGSsf2iOiYxF0T/iR//gLnyTC
 J15vDqNyG23P923P/owVPL0gGFIYULqE/Ap5+U9ZGO6QeVR7iFL4+
X-Received: by 2002:a05:622a:4489:b0:461:3834:b62e with SMTP id
 d75a77b69052e-4613834bb57mr7746641cf.3.1729868523300; 
 Fri, 25 Oct 2024 08:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF54z8tpLTmErNQE6009AEOPu9qTcmlOluhRiz0O+uHDmo3owD4mAlDK2nSWt4I2qig5mb5vg==
X-Received: by 2002:a05:622a:4489:b0:461:3834:b62e with SMTP id
 d75a77b69052e-4613834bb57mr7746221cf.3.1729868522752; 
 Fri, 25 Oct 2024 08:02:02 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17991b712sm6460846d6.59.2024.10.25.08.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 08:02:02 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:01:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/4] QOM: Singleton interface
Message-ID: <Zxuy5CjKNlK49TUL@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <87h690my2w.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h690my2w.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On Fri, Oct 25, 2024 at 09:38:31AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > This patchset introduces the singleton interface for QOM.
> >
> > The singleton interface is as simple as "this class can only create one
> > instance".
> >
> > We used to have similar demand when working on all kinds of vIOMMUs,
> > because in most cases that I am aware of, vIOMMU must be a singleton as
> > it's closely bound to the machine and also the root PCIe systems.  We used
> > to have a bunch of special code guarding those, for example, X86 has
> > pc_machine_device_pre_plug_cb() just to detect when vIOMMU is created more
> > than once.
> >
> > There is a similar demand raising recently (even if the problem existed
> > over years) when we were looking at a migration bug, that part of it was
> > involved with the current_migration global pointer being referenced
> > anywhere, even after the migration object was finalize()ed.  So far without
> > singleton support, there's no way to reset the variable properly.
> > Declaring migration object to be a singleton also just makes sense, e.g.,
> > dynamically creating migration objects on the fly with QMP commands doesn't
> > sound right..
> >
> > The idea behind is pretty simple: any object that can only be created once
> > can now declare the TYPE_SINGLETON interface, then QOM facilities will make
> > sure it won't be created more than once.  For example, qom-list-properties,
> > device-list-properties, etc., will be smart enough to not try to create
> > temporary singleton objects now.
> 
> QOM design assumption: object_new() followed by object_unref() is always
> possible and has no side effect.

I see.

> 
> QOM introspection relies on this.  Your PATCH 1 makes non-class
> properties of singletons invisible in introspection.  Making something
> with such properties a singleton would be a regression.
> 
> Anything that violates the design assumption must be delayed to a
> suitable state transition.  For devices (subtypes of TYPE_DEVICE), this
> is ->realize().  For user-creatable objects (provide interface
> TYPE_USER_CREATABLE), this is ->complete().  For anything else, it's
> something else that probably doesn't even exist, yet.  See "Problem 5:
> QOM lacks a clear life cycle" in
> 
>     Subject: Dynamic & heterogeneous machines, initial configuration: problems
>     Date: Wed, 31 Jan 2024 21:14:21 +0100
>     Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
>     https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/

The major challenge here might be that, in migration's use case we want to
do something after the last refcount is released.

IOW, I don't yet see an easy way to explicit do qdev_unrealize() (even if
migration object will use realize(), while it doesn't yet..), because there
can be more than one thread holding refcount of the object, and we don't
know where to invoke it, and we don't want to do the cleanup if the other
one still holds a refcount.

The only sane place now is in instance_finalize(), which is the only clean
place so far that is invoked after last refcount dropped.

Maybe I can also try do that with a "magic property" with its set/get, as
that's indeed the other hook (basically, object_property_del_all()) that is
only invoked after the final refcount is released.  However I think we
still need the singleton idea somehow..

Thanks,

-- 
Peter Xu


