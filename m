Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9615CD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVDj-0006OP-Jo; Fri, 05 Jun 2026 10:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVVDi-0006OH-DN
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVVDg-0001BS-7F
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780668498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qbYHadcjXrmyb7C+J41ebM17S3OsEPvceTUNrJaRado=;
 b=TPLx7EaV0g6mHp9Rcc6/tBp0C3P9qeQJNHiNO7RWoAYK/XxOO+IbrSFsE+gB2U8MTOZp3V
 973qu9TRnEyHaZESZYuK7hohxmDSu/vmcaDhmHAd8SgLS0edUjmQW4QGpgpN6U1eijguCY
 xSLM+x1+lYhJtFP30BivGFiQOVBOZ+w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-exXsySHVMoSLijaWawJUzA-1; Fri, 05 Jun 2026 10:08:16 -0400
X-MC-Unique: exXsySHVMoSLijaWawJUzA-1
X-Mimecast-MFC-AGG-ID: exXsySHVMoSLijaWawJUzA_1780668496
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915b3587972so52765385a.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780668496; x=1781273296; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qbYHadcjXrmyb7C+J41ebM17S3OsEPvceTUNrJaRado=;
 b=gvmYf04HLySf/Msvn30qPfUYX7uEneI+q/pJeJ0FK0Xc/tnT4XKc+I6cXLxH2aw7Yp
 7+lP5BHsVSWqUmj98+YagPc4anao34qjW0WN/HuYmM5/WfFtYUzSB2E6XBrKO3rchgCs
 QyN4QPm947gXiIX5QhYpV4+pT8tVzDXYhpDQBHH0+aP2gOqBshHpQdUbBLvh5AkyCVKg
 4/KwNd1V1oAxthPSAKqbddJZ6J4+iKcaiHRqNl9nrIzYQU4jzTFxb1t8GxA06dTd0LHM
 068YkQ6LBEG5ATcD708/RFpyeaLejwjDiV5jyxBKOHOpjNifsC/9EadDvRTzT5wtYcEi
 gGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780668496; x=1781273296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbYHadcjXrmyb7C+J41ebM17S3OsEPvceTUNrJaRado=;
 b=PCgebNuNVEaNvS2pdSiC7UrqXKzZj5jTjhobHVv7KFfui1xyDeVq/rVzcuTU0t8yqw
 apScTO2IrSNt0lvS5qJE1y626m0HvmPriOWyeLJ3l3op1OwtByOMkJqsIg5jHhkWWHvL
 G0wElxbuRrxir9V4ARH1T7z2Y2O8VPYcabdJ7N4fhMAfX4U55gqCugxKrYtV5S9NPGFB
 VtJc7DF75MIozVvkucwWW52n2LUj8l47OADjnogPZl8Z4bIuFvEVXB2r/oEUu1XKBt7G
 NIC0Eukjeu0wn+tQ/BGy6cSduLD6iITTpIev7trLf9z/Z/1FzBNDFy4vjImpu4qz7l3W
 i6JQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ90RWKdg22T9/szsM8dje6F0N2vnDE6x2rV0Yk23MopfxCG24Gfyjy0S1pbLN1C4wZTTnKTjsuOHqWX@nongnu.org
X-Gm-Message-State: AOJu0YycuQon6CirHxUkfL5ua+2E/bXzKgUrw11MdDRw1VaB+GnEEEBT
 nmBpLNNuOJQ4NBffh/SeLdDZx9J//HQFTBU45CIKOF3XW1CNbzf8qwgamrAxscettt86LnoQop7
 UyY19QiUQv9i6L1XsxxzcOnigJfv9V9lZnLbsN966X2T8IdCA2ovxRwdm
X-Gm-Gg: Acq92OG89oxHEmVwtHeADNElCvjXSaRS8LmhnxGzBfxKQtQsA3ngtdPNRUAbirur/pY
 1IK2O2ob/XZU3I+3As/vGFCpAD8BMGjZ4UPmMnH/YwstJxJ2VIad7fzewc3eLNO+jB3Nt/kKw0r
 c1ZWmCfzgEO+34tfdCefZgFpo3BBe90UVwuRgpvjU5m0kGr2IWXugAT4SRjSoqDu6llcVf288GQ
 sF48e5fejGc/M2XhLsXPf/RNE+11Rv+BToNqr947feOUH3fwS/xIh47uZvpzF8zuBwu1DDk2iL0
 +4TuQCuB6XHg+ZMYvtropbcA/82nB8aPksRd0zipnjkQ4PN9K981niKW2AnVYV+2mzrdcTKzoiN
 DcucDanChZpFjzxrWZLpyorwoHA==
X-Received: by 2002:a05:620a:270d:b0:90e:2f56:2f0b with SMTP id
 af79cd13be357-915a9c22776mr665240985a.7.1780668495874; 
 Fri, 05 Jun 2026 07:08:15 -0700 (PDT)
X-Received: by 2002:a05:620a:270d:b0:90e:2f56:2f0b with SMTP id
 af79cd13be357-915a9c22776mr665233085a.7.1780668495209; 
 Fri, 05 Jun 2026 07:08:15 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a22dbbesm882201485a.13.2026.06.05.07.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 07:08:14 -0700 (PDT)
Date: Fri, 5 Jun 2026 10:08:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Message-ID: <aiLYTYTb6TGY2Fgm@x1.local>
References: <ahmfh2s7CLFLoZKN@x1.local> <ah_4hixGcNv-CLfv@redhat.com>
 <aiBNXUU0xcT_UbKO@x1.local> <aiBhTTqSctU9lFsS@redhat.com>
 <87o6hr7brx.fsf@suse.de> <aiBrp1UJZjmC1aI1@redhat.com>
 <aiB2nA5bmtBRWras@x1.local>
 <21a05595-0266-4755-8a99-29a85b9da2db@yandex-team.ru>
 <aiG9Yn5My8LoTraZ@x1.local>
 <fde9e6a3-9aef-4c9b-8458-6b135cd60598@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fde9e6a3-9aef-4c9b-8458-6b135cd60598@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 05, 2026 at 10:35:52AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 04.06.26 21:01, Peter Xu wrote:
> > On Thu, Jun 04, 2026 at 01:00:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 03.06.26 21:46, Peter Xu wrote:
> > > > > My general feeling wrt changes to the current command line is that
> > > > > any suggestion should be desgined with a nod towards a future scenario
> > > > > where QEMU is 100% configured with QMP. ie the full command line is
> > > > > 
> > > > >      qemu-system-x86_64 -qmp <address>
> > > > > 
> > > 
> > > [..]
> > > 
> > > > 
> > > > Requirements like this (allow migration parameters to be accessible during
> > > > early stage of QEMU) is going towards the other direction of the that idea.
> > > > That means even if we put all configs (caps/params) into QMP command
> > > > migrate[-incoming], libvirt will still need to manage these global setup
> > > > and making sure when invoking migrate[-incoming] QMP commands they match
> > > > with the globals.  Say, if one start QEMU with -incomingconfig:local=on
> > > > but then invoke "migrate-incoming,local=off" it's illegal.
> > > 
> > > Right.. And this show, that moving "local" from migrate-set-parameters to
> > > commandline is not a clear solution for the whole problem.
> > > 
> > > We don't need cmdline argument. We need two things:
> > > 
> > > 1. "local" must be set before initializing tap-device.
> > > 
> > > It not actually requires it being a cmdline parameter. Calling
> > > migrate-set-parameters before netdev_add is also OK.
> > 
> > Ohh is it ok?  I thought it was not OK so we look at this.
> > 
> > Say, this is what I see on init TAP device when without hotplug:
> > 
> > qemu_create_late_backends() -> net_init_clients()
> > 
> > Such happens before migration object initialization.
> 
> Yes, it doesn't work for TAP devices added through commandline. But
> if devices are added only throuhg QMP (isn't libvirt do so?), it
> should work.
> 
> > 
> > > 
> > > So, moving to cmdline solves this [1] point, but may be too restrictive.
> > > 
> > > 
> > > 2. "local" must not be changed after initializing tap-device.
> > > 
> > > And this one is not guaranteed anyway, with cmdline or with QMP.
> > > 
> > > ---
> > > 
> > > 
> > > So, in my series, if drop "incoming-fds" and rely on "local" instead, we
> > > actually want "local" be immutable after first read in tap initialization
> > > code.
> > > 
> > > Maybe, just implement this feature? So, in code it will look like:
> > > 
> > > set_migration_parameters(...) {
> > > 
> > > ...
> > > 
> > > if "local" value is changing and "local" is immutable:
> > >     fail
> > 
> > We can't do that, can we?
> > 
> > Imagine we need to further migrate this VM to another host, where we need
> > to turn "local" off after this incoming migration.. we can forbid only
> > during incoming phase and re-enable the mutability, but it seems too much.
> 
> Agree, right. I missed further outgoing migration.
> 
> > 
> > My understanding is such protection is fine but not strongly necessary.
> > IMHO we rely on a lot of things that admin needs to do right.  I hope this
> > isn't a major issue to offload that to admin to say the admin should always
> > do the right things.
> > 
> > We have a bunch of similar issues in QEMU IIUC, e.g. we have known issue
> > that some -device needs to be ordered in some way otherwise it'll stop
> > working.  We then need admin (or in this case libvirt) do the right thing
> > too.
> 
> So, possible way is:
> 
> 1. net devices are only added by QMP commands
> 2. migration parameter "local" is set before adding devices
> 
> So, we can omit "incoming-fds" and rely on "local" && "support-local-migration".
> 
> And we can check in .pre_incoming of TAP device, does current value of "local"
> equal to what it was at time of TAP initialization, and fail if it differs.
> 
> Still, having explicit incoming-fds looks safer, as it's more difficult to do
> a mistake.

If this will be the only outlier, then maybe yes, an extra option in a
special device backend isn't much of an issue.

The question is if there'll be more things relying on "local=on".  We may
not want to keep introducing per-device flags even if all of them can play
the same role as migration's "local".

> 
> With incoming-fds=true, user is sure, that new target vm will not try
> to connect/open resources, which are still used by running source vm,
> regardless of migration configuration correctness.
> 
> For example, if user accidentally set "local" _after_ creating TAP device,
> we can of-course check it in .pre_incoming and fail, but at the moment we
> already break networking in running guest, by attaching to same backend on
> target QEMU.
> 
> -- 
> Best regards,
> Vladimir
> 

-- 
Peter Xu


