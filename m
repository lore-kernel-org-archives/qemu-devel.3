Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5810BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hgV-0001OS-Ss; Fri, 03 Oct 2025 11:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hgT-0001OC-Ur
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hgG-0003TN-Lr
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759505201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7zbVpT2ZKmt31v7KXTFLTINitE/cIBdFBZsnKc90n4=;
 b=N1DpNldX0u5s/p2MBuiohgHhqUSbl17kCqKD71XZtwfhsgwQbr6vq8ihnRJr/8GGdTJtIt
 CbgCQaVICOnbpo4Pq//RQv6ArOZFKZ4BF6+wlBZyfhwVSSOkafNW+6bCLY0+1o5DwnnDly
 2vOs3eaWSI7J2WzYYzIUjleoIpK1be8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-dE4lNCizNuWZfxLP3RAyCA-1; Fri, 03 Oct 2025 11:26:40 -0400
X-MC-Unique: dE4lNCizNuWZfxLP3RAyCA-1
X-Mimecast-MFC-AGG-ID: dE4lNCizNuWZfxLP3RAyCA_1759505200
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-863cd58a92dso509482985a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759505200; x=1760110000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7zbVpT2ZKmt31v7KXTFLTINitE/cIBdFBZsnKc90n4=;
 b=E2YLeuki7v/58TZOvOsQ8GL66kYC2WM1+z55GH2rwaSmYALTPkydGbV/OSnyanJG+a
 Fc36PvEqLrCRAXu97d4UeIY0pHhjuF7Jbjy54j0LNHLvwCcqqjQJh3Vw3pXEhyfEPCT4
 aB7xns8HbptjJlEXzM2Vv9zvSnV1ixW9v2Nwg6rr2JFD9ZqsNNFzJGMNnto62Q6yQg98
 tgfKj4X/L158U8HkMpiVbBdYNIWJN1Y37eTma26McFvOO6gI+XvH5JkdR9LKjjxvlzgx
 rNYAWt51YqUVmpJQV6WdOWSsWgCORVuUwuO60sDq3iR1YeVElvSu0zmHAEQ8Psq9gePt
 fQfQ==
X-Gm-Message-State: AOJu0YwqkBUFq4DPsmfwe0oIdBlFZ9eF6Sczm11WStMbRaruQoei0pxh
 McjaBlKw486+ywqpazlcTyF5je6n7IYTBSUc0c7NOgpRp83yXa6iF7S4NxHHTFe7B1e5SaiGpnc
 grladyyGQhttzHJLUqM3Swbv2vS6M4LhqhMbPNK6r9FBS86vmWjAKO4ru
X-Gm-Gg: ASbGncsNoWmrKlubEAEw0SwlUovhPIYcgEDHiWvCiNODaQvtAHdEoDUx9WzOA1LWCY8
 kOY85J8nSrbBgQnIw08zGHiqtfGu2j6h4mIpXqRee+yz9vv5wZultQnFMyO24xZih5Bikh95cEI
 T972qJPfAapnqxJ/n1VzwtdXDWHlQYidb2ZV0BPZ2EtyaUqQ4zlXUvLo0opJTTEFfGXJHbI5Oz1
 2q68nEbI8EWJ3cIkmsYPSc2TfjB91AO0/PkcQEWc8FEJFIRhtubgeXKU29Y84KTYEb/6d9ztHla
 WS0arxx/IqtNWPLoi9Mqyv87iaLgRqpi7LmoaQ==
X-Received: by 2002:a05:620a:1a11:b0:875:c212:fe07 with SMTP id
 af79cd13be357-87a390f1f2bmr434189185a.78.1759505199853; 
 Fri, 03 Oct 2025 08:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4Zr3icmAnjzX/7bVjAwG5d94ur2+7y4UQxbBgkpkBWWKB6wjCUGZK3vtchiWr4XDldDPG1w==
X-Received: by 2002:a05:620a:1a11:b0:875:c212:fe07 with SMTP id
 af79cd13be357-87a390f1f2bmr434183985a.78.1759505199150; 
 Fri, 03 Oct 2025 08:26:39 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-87771129478sm433186985a.1.2025.10.03.08.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:26:38 -0700 (PDT)
Date: Fri, 3 Oct 2025 11:26:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH 02/14] qdev: Automatically delete memory subregions
Message-ID: <aN_rLDLeMcvRtmAa@x1.local>
References: <20250917-subregion-v1-0-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-subregion-v1-2-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <aN7RHvjeQNtrXDcQ@x1.local> <aN7VH0j8HfaeRV1V@x1.local>
 <32e36e0c-c947-4fa4-bdbf-5ef3ce6ea0a3@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32e36e0c-c947-4fa4-bdbf-5ef3ce6ea0a3@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 03, 2025 at 11:01:38PM +0900, Akihiko Odaki wrote:
> On 2025/10/03 4:40, Peter Xu wrote:
> > On Thu, Oct 02, 2025 at 03:23:10PM -0400, Peter Xu wrote:
> > > On Wed, Sep 17, 2025 at 07:32:48PM +0900, Akihiko Odaki wrote:
> > > > +static int del_memory_region(Object *child, void *opaque)
> > > > +{
> > > > +    MemoryRegion *mr = (MemoryRegion *)object_dynamic_cast(child, TYPE_MEMORY_REGION);
> > > > +
> > > > +    if (mr && mr->container) {
> > > > +        memory_region_del_subregion(mr->container, mr);
> > > > +    }
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > >   static void device_set_realized(Object *obj, bool value, Error **errp)
> > > >   {
> > > >       DeviceState *dev = DEVICE(obj);
> > > > @@ -582,6 +593,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
> > > >           if (dc->unrealize) {
> > > >               dc->unrealize(dev);
> > > >           }
> > > > +        object_child_foreach(OBJECT(dev), del_memory_region, NULL);
> > > 
> > > PS: I'll keep throwing some pure questions here, again, Paolo - it doesn't
> > > need to block merging if you're confident with the general approach.
> > > 
> > > Said that, a few things I still want to mention after I read this series..
> > > 
> > > One thing I really feel hard to review such work is, you hardly describe
> > > the problems the series is resolving.
> > > 
> > > For example, this patch proposed auto-detach MRs in unrealize() for qdev,
> > > however there's nowhere describing "what will start to work, while it
> > > doesn't", "how bad is the problem", etc..  All the rest patches are about
> > > "what we can avoid do" after this patch.
> > 
> > For this part, I should be more clear on what I'm requesting on the
> > answers.
> > 
> > I think I get the whole point that MRs (while still with MR refcount
> > piggypacked, as of current QEMU master does) can circular reference itself
> > if not always detached properly, so explicitly my question is about:
> > 
> > - What devices / use case you encountered, that QEMU has such issue?
> >    Especially, this is about after we have merged commit ac7a892fd3 "memory:
> >    Fix leaks due to owner-shared MRs circular references".  Asking because I
> >    believe most of them should already auto-detach when owner is shared.
> > 
> > - From above list of broken devices, are there any devices that are
> >    hot-unpluggable (aka, high priority)?  Is it a problem if we do not
> >    finalize a MR if it is never removable anyway?

[1]

> > 
> > > 
> > > Meanwhile, the cover letter is misleading. It is:
> > > 
> > > [PATCH 00/14] Fix memory region use-after-finalization
> > > 
> > > I believe it's simply wrong, because the whole series is not about
> > > finalize() but unrealize().  For Device class, it also includes the exit()
> > > which will be invoked in pci_qdev_unrealize(), but that is also part of the
> > > unrealize() routine, not finalize().
> 
> The subject of the cover letter "fix memory region use-after-finalization"
> is confusing. While this series has such fixes, it also contain refactoring
> patches. The cover letter says:
> 
> > Patch "qdev: Automatically delete memory subregions" and the
> > succeeding patches are for refactoring, but patch "vfio-user: Do not
> > delete the subregion" does fix use-after-finalization.
> 
> More concretely, patch "qdev: Automatically delete memory subregions"
> implements a common pattern of device unrealization, and the suceeding
> patches remove ad-hoc implementations of it.
> 
> And since patch "hw/pci-bridge: Do not assume immediate MemoryRegion
> finalization" fixes nothing as you pointed out, only patch "vfio-user: Do
> not delete the subregion" fixes something.
> 
> Without patch "vfio-user: Do not delete the subregion",
> vfio_user_msix_teardown() calls memory_region_del_subregion(). However, this
> function is called from instance_finalize, so the subregion is already
> finalized and results in a use-after-finalization scenario.
> 
> Anything else is for refactoring and it's quite unlike patch "memory: Fix
> leaks due to owner-shared MRs circular references", which is a bug fix.
> 
> I think I'll drop patch "hw/pci-bridge: Do not assume immediate MemoryRegion
> finalization" and rename this series simply to "qdev: Automatically delete
> memory subregions" to avoid confusion.

Yes, thanks.  I went over quite a few follow up patches but I missed this
one.  IMHO you can also split the only fix out, so that can be better
looked at by vfio-user developers.  It'll also be easier for them to verify
if they want.

> 
> > > 
> > > The other question is, what if a MR has a owner that is not the device
> > > itself?  There's no place enforcing this, hence a qdev can logically have
> > > some sub-objects (which may not really be qdev) that can be the owner of
> > > the memory regions.  Then the device emulation will found that some MRs are
> > > auto-detached and some are not.
> > > 
> > > One example that I'm aware of is this:
> > > 
> > > https://lore.kernel.org/all/20250910115420.1012191-2-aesteve@redhat.com/#t
> > > 
> > > TYPE_VIRTIO_SHARED_MEMORY_MAPPING is an object, not qdev here, which can be
> > > the owner of the MR.
> 
> Patch "qdev: Automatically delete memory subregions" and the succeeding
> patches are for refactoring of qdev. MRs not directly owned by qdev are out
> of scope of the change.

Do you have a rough answer of above question [1], on what might suffer from
lost MRs?  I sincerely want to know how much we are missing after we could
already auto-detach owner-shared MRs.

From a quick glance, at least patch 4-14 are detaching MRs that shares the
same owner.  IIUC, it means at least patch 4-14 do not rely on patch 2.

Then I wonder how much patch 2 helps in real life.

There's indeed a difference though when a qdev may realize(), unrealize()
and realize() in a sequence, in which case patch 2 could help whil commit
ac7a892fd3 won't, however I don't know whether there's real use case,
either.

I also wished if there's such device, it'll have explicit detach code so
that when I debug a problem on the device I can easily see when the MRs
will be available, instead of remembering all the rules when something in
some layer will auto-detach...

Personally I think such automation adds burden to developers' mind if
there're still a bunch of MRs that are not used in this way (there
definitely are, otherwise we should be able to completely unexport
memory_region_del_subregion). But that's subjective; I believe at least
Paolo agrees with your general approach.

Thanks,

-- 
Peter Xu


