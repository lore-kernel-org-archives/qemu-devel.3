Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9383AC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 19:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYsFo-00057t-M8; Tue, 30 Jul 2024 15:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYsFn-00056i-Au
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 15:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYsFi-0000GD-IP
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 15:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722366677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1j5ENjtHekPa0AsZsCL8lQYhUWqqsL80WVTGDF3cPjc=;
 b=INgf5KQ1Um5n/5ZnbQ0UA7O+dV30mox6XZ+IjuINxlxEV3+LzcXlVmwfdzaEpMul6MOsK8
 lHBdhHpMloRJq/1oBuAMghIxeExMsmKLP6GdBP400m2PN5KwOAGN3scgf6zFcB0v2TbiKu
 7X1uJu0v3YocLkGbqsL/DtWw+uteqWo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-XPpAz8RYOyygJqpuOS3K2w-1; Tue, 30 Jul 2024 15:11:13 -0400
X-MC-Unique: XPpAz8RYOyygJqpuOS3K2w-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4503ee1b5d6so1030581cf.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 12:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722366672; x=1722971472;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1j5ENjtHekPa0AsZsCL8lQYhUWqqsL80WVTGDF3cPjc=;
 b=jjiZAqEpriBXzO5e7cdqI4TfyCBN9XXIExsH2ZJ74qSODHuFsZxACCLU5gjEaGNfSM
 ZiAMMAXXouzeqe5sJzwRvfiZ12yf5hOsCdhZkCu5pezHMYrDIg0fXPMjRCZUWJgevfw8
 kpDNKtBVAcxhaz2S6aSS3IogYFNLD2h4UNttrx/0HRTw1mP1RyZRgzxFZkG0oD+wXIkg
 hb7C1JhF5xxL68ZSXSEgWg84Xg2AwQ3ljYobJ650bWf9tIxQZdVCExM284JpGCwIlBeD
 DyfMOr9Uz9ifG/CICUMabBHb5bUainCq39Xnqndo2tPN/TRpkeWO32mZoekV6hDF8GWf
 GbSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR3pMMMrPDq/OKogQnIwMpyqWu7UYB1Or0oTnHRsQcze1LY+rEHh2xvo0Rj2b7Co3TGDovnASJNosa6tBT8FoX9O+FSgE=
X-Gm-Message-State: AOJu0Yx72DbQxdfS3HyvBX7rXdMH/s+PsMG3JnLl5wfizsfGdzpAOhIA
 RHol/6dNJ3nXpJrKuicxY3OYUlblXhxNe6uHpupPUBfa/8tWCVY5BPo7tYw4kSCmDNOj7gjnQWI
 xusMyN7Oziiy7//N0Bl0Ap3dnyRRPgwB69HV2lHmRjlSrqSnJfKQU
X-Received: by 2002:a05:622a:1903:b0:44f:de40:201e with SMTP id
 d75a77b69052e-44fe5b35db3mr147197811cf.9.1722366672493; 
 Tue, 30 Jul 2024 12:11:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/qyQiiMooFeipKZmpx8TpfmTi4Drdk99hd6oGyiexQBhDqFa5f+FckkNBtGAb3MXVjDaYig==
X-Received: by 2002:a05:622a:1903:b0:44f:de40:201e with SMTP id
 d75a77b69052e-44fe5b35db3mr147197571cf.9.1722366671943; 
 Tue, 30 Jul 2024 12:11:11 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44fe8416c80sm52084351cf.96.2024.07.30.12.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 12:11:11 -0700 (PDT)
Date: Tue, 30 Jul 2024 15:11:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <Zqk6x2nd3Twz--75@x1n>
References: <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <Zqe8C9AfaojKHM8A@redhat.com> <ZqfKrtQSSRVnEOGt@x1n>
 <ZqfQ0cGf8t2trEdl@redhat.com> <ZqktXwxBWjuAgGxZ@x1n>
 <Zqk09BGxlpdxMBMx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zqk09BGxlpdxMBMx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 07:46:12PM +0100, Daniel P. Berrangé wrote:
> On Tue, Jul 30, 2024 at 02:13:51PM -0400, Peter Xu wrote:
> > On Mon, Jul 29, 2024 at 06:26:41PM +0100, Daniel P. Berrangé wrote:
> > > On Mon, Jul 29, 2024 at 01:00:30PM -0400, Peter Xu wrote:
> > > > On Mon, Jul 29, 2024 at 04:58:03PM +0100, Daniel P. Berrangé wrote:
> > > > > 
> > > > > We've got two mutually conflicting goals with the machine type
> > > > > definitions.
> > > > > 
> > > > > Primarily we use them to ensure stable ABI, but an important
> > > > > secondary goal is to enable new tunables to have new defaults
> > > > > set, without having to update every mgmt app.  The latter
> > > > > works very well when the defaults have no dependancy on the
> > > > > platform kernel/OS, but breaks migration when they do have a
> > > > > platform dependancy.
> > > > > 
> > > > > >   - Firstly, never quietly flipping any bit that affects the ABI...
> > > > > > 
> > > > > >   - Have a default value of off, then QEMU will always allow the VM to boot
> > > > > >     by default, while advanced users can opt-in on new features.  We can't
> > > > > >     make this ON by default otherwise some VMs can already fail to boot,
> > > > > > 
> > > > > >   - If the host doesn't support the feature while the cmdline enabled it,
> > > > > >     it needs to fail QEMU boot rather than flipping, so that it says "hey,
> > > > > >     this host does not support running such VM specified, due to XXX
> > > > > >     feature missing".
> > > > > > 
> > > > > > That's the only way an user could understand what happened, and IMHO that's
> > > > > > a clean way that we stick with QEMU cmdline on defining the guest ABI,
> > > > > > while in which the machine type is the fundation of such definition, as the
> > > > > > machine type can decides many of the rest compat properties.  And that's
> > > > > > the whole point of the compat properties too (to make sure the guest ABI is
> > > > > > stable).
> > > > > > 
> > > > > > If kernel breaks it easily, all compat property things that we maintain can
> > > > > > already stop making sense in general, because it didn't define the whole
> > > > > > guest ABI..
> > > > > > 
> > > > > > So AFAIU that's really what we used for years, I hope I didn't overlook
> > > > > > somehting.  And maybe we don't yet need the "-platform" layer if we can
> > > > > > keep up with this rule?
> > > > > 
> > > > > We've failed at this for years wrt enabling use of new defaults that have
> > > > > a platform depedancy, so historical practice isn't a good reference.
> > > > > 
> > > > > There are 100's (possibly 1000's) of tunables set implicitly as part of
> > > > > the machine type, and of those, libvirt likely only exposes a few 10's
> > > > > of tunables. The vast majority are low level details that no mgmt app
> > > > > wants to know about, they just want to accept QEMU's new defaults,
> > > > > while preserving machine ABI. This is a good thing. No one wants the
> > > > > burden of wiring up every single tunable into libvirt and mgmt apps.
> > > > > 
> > > > > This is what the "-platform" concept would be intended to preserve. It
> > > > > would allow a way to enable groups of settings that have a platform level
> > > > > dependancy, without ever having to teach either libvirt or the mgmt apps
> > > > > about the individual tunables.
> > > > 
> > > > Do you think we can achieve similar goal by simply turning the feature to
> > > > ON only after a few QEMU releases?  I also mentioned that idea below.
> > > > 
> > > > https://lore.kernel.org/r/ZqQNKZ9_OPhDq2AK@x1n
> > > > 
> > > > So far it really sounds like the right thing to do to me to fix all similar
> > > > issues, even without introducing anything new we need to maintain.
> > > 
> > > Turning a feature with a platform dependency to "on" implies that
> > > the machine type will cease to work out of the box for platforms
> > > which lack the feature. IMHO that's not acceptable behaviour for
> > > any of our supported platforms.
> > 
> > Right, that's why I was thinking whether we should just always be on the
> > safe side, even if I just replied in the other email to Akihiko, that we do
> > have the option to make this more aggresive by turning those to ON after
> > even 1-2 years or even less.. and we have control of how aggressive this
> > can be.
> > 
> > > 
> > > IOW, "after a few QEMU releases" implies a delay of as much as
> > > 5 years, while we wait for platforms which don't support the
> > > feature to drop out of our supported targets list.  I don't
> > > think that'll satisfy the desire to get the new feature
> > > available to users as soon as practical for their particular
> > > platform.
> > 
> > The feature is always available since the 1st day, right?  We just need the
> > user to opt-in, by specifying ON in the cmdline.
> > 
> > That'll be my take on this that QEMU's default VM setup should be always
> > bootable, migratable, and so on.  Then user opt-in on stuff like this one,
> > where there's implication on the ABIs.  The "user" can also include
> > Libvirt.  I mean when something is really important, Libvirt should, IMHO,
> > opt-in by treating that similarly like many cpu properties, and by probing
> > the host first.
> > 
> > IIUC there aren't a lot of things like that (part of guest ABI & host
> > kernel / HW dependent), am I right?  Otherwise I would expect more failures
> > like this one, but it isn't as much as that yet.  IIUC it means the efforts
> > to make Libvirt get involved should be hopefully under control too.  The
> > worst case is Libvirt doesn't auto-on it, but again the user should always
> > have the option to turn it on when it's necessary.
> 
> If it is left to libvirt, then it would very likely end up being a user
> opt-in, not auto-enabled.

Not sure whether there's other opinions, but that's definitely fine by me.

I think it even makes more sense, as even if Libvirt probed the host and
auto-on the feature, it also means Libvirt made a decision for the user,
saying "having a better performance" is more important than "being able to
migrate this VM everywhere".

I don't see a way that can make such fair decision besides requesting the
user to opt-in always for those, then the user is fully aware what is
enabled, with the hope that when a migration fails later with "target host
doesn't support feature XXX" the user is crystal clear on what happened.

Thanks,

-- 
Peter Xu


