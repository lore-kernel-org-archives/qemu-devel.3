Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB50CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PAZ-0001EU-3y; Thu, 02 Oct 2025 15:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4PAP-00017m-4B
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:40:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4PAA-0001Sf-7S
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759434020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1v7QIBY7vfhCqJf9vsGF8o5LWThPDsveEFn0SjqsOyQ=;
 b=FT5HmZhwYmQ7qbmhWw7ii+egMXhZFBQM4sVkyjPKuoYmQgZ+AfskV66d09cvTZ8wsQVLCu
 pemMb2US8Yw9F+gmhmRnn5uPuZVH6n4bXsAyre36f9VKN85PodgUuWAxxR45u/QNpe3R/U
 oRaRoMmWAiYj/aBXSC4QMFl4kVIZf/E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-oy5J2PToN96Bv76X5EhX5Q-1; Thu, 02 Oct 2025 15:40:19 -0400
X-MC-Unique: oy5J2PToN96Bv76X5EhX5Q-1
X-Mimecast-MFC-AGG-ID: oy5J2PToN96Bv76X5EhX5Q_1759434019
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4e57359997aso11065211cf.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 12:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759434019; x=1760038819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1v7QIBY7vfhCqJf9vsGF8o5LWThPDsveEFn0SjqsOyQ=;
 b=SatW4KHU39ANEAR85g3HU0jSn9tiRnhb91O2VdRiDNIQ4DCk4OA3jYZ4U+cQRGZSEV
 r/ZH24tmA7c7mTSDGZ8/BFuB//n/Wua8ab98cLAwGd75fw6YKqcNMboEAstYEzxDm0Ac
 Qv5pOkdO+jE6R/rYrR9JoV1FhVEGAlfrKhTrw1Nblptak7lhGVZ+9GSKYQKMR0om4uoo
 XNpiKUIt2WgS9qPfs3BZzsaMr9Ph/bfrCI6NVXja79B8iLdalyMBB4bjwyWEfwEYjSRW
 AyIx2hwGQTUZgHjXHv/xK+KfO4bBTuO+Dl/ZzCbslJP7lvwK+G6Hx7bRFwdXygKlx4bB
 HpAQ==
X-Gm-Message-State: AOJu0YzSvIShIl6jXXAY78vdYO35cbKX9KxA/APyr8KaSF0JPhrO78As
 2rWwVCEuxrAMCJDwPijyNih4HWYoQ5kSuWQAANNI6QMZ6/2caY+csHOKpCshh8XKjc1twmtYkGt
 vSqPHlClokgglyOZj7mltreI6TFBhpFWYN/cfLjpIf61BGAXvIBEjtTl5
X-Gm-Gg: ASbGncv4thM//fUzUQVk27Agjm0DGnqO4pcZD82hU0CGLCa/Xhrgk+tYXy+mdqMcEb1
 PH+/3jut/tsPaBJ4dgTEedvqJf9VdME03MiRQ5ODjikkHAghR/vTEfOLurSM0mKv/yt7QW7nymV
 Q64I20LTGrJEu7OTM/AcB6LYcV59qXLZA/+Cvhxo4bhrAuexEIXaf612dkM+m44eiZhraGRgXBS
 DXa8HHegdqsfYyVtiZIW1A37ry6exX3cw6UXMzz4D5yQzI7Ycz3zKwdNh2ZtBDGV8ZKs4bEvG+7
 B+x21VQqDMzhN1FVLQK+i4wMHF1wfNYJkf0GhQ==
X-Received: by 2002:a05:622a:4ccf:b0:4b4:9590:c1bb with SMTP id
 d75a77b69052e-4e576a5bd5emr7234261cf.20.1759434018833; 
 Thu, 02 Oct 2025 12:40:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjcUF1ycifCHxh3q9VR8hhGfd1p3DmWpakYJ/bCBHJMt8cUHZIPQ4EpVX6sCY+7QDNScatKA==
X-Received: by 2002:a05:622a:4ccf:b0:4b4:9590:c1bb with SMTP id
 d75a77b69052e-4e576a5bd5emr7233631cf.20.1759434018194; 
 Thu, 02 Oct 2025 12:40:18 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e55d0c8a57sm24641631cf.37.2025.10.02.12.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 12:40:17 -0700 (PDT)
Date: Thu, 2 Oct 2025 15:40:15 -0400
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
Message-ID: <aN7VH0j8HfaeRV1V@x1.local>
References: <20250917-subregion-v1-0-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-subregion-v1-2-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <aN7RHvjeQNtrXDcQ@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aN7RHvjeQNtrXDcQ@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
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

On Thu, Oct 02, 2025 at 03:23:10PM -0400, Peter Xu wrote:
> On Wed, Sep 17, 2025 at 07:32:48PM +0900, Akihiko Odaki wrote:
> > +static int del_memory_region(Object *child, void *opaque)
> > +{
> > +    MemoryRegion *mr = (MemoryRegion *)object_dynamic_cast(child, TYPE_MEMORY_REGION);
> > +
> > +    if (mr && mr->container) {
> > +        memory_region_del_subregion(mr->container, mr);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static void device_set_realized(Object *obj, bool value, Error **errp)
> >  {
> >      DeviceState *dev = DEVICE(obj);
> > @@ -582,6 +593,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
> >          if (dc->unrealize) {
> >              dc->unrealize(dev);
> >          }
> > +        object_child_foreach(OBJECT(dev), del_memory_region, NULL);
> 
> PS: I'll keep throwing some pure questions here, again, Paolo - it doesn't
> need to block merging if you're confident with the general approach.
> 
> Said that, a few things I still want to mention after I read this series..
> 
> One thing I really feel hard to review such work is, you hardly describe
> the problems the series is resolving.
> 
> For example, this patch proposed auto-detach MRs in unrealize() for qdev,
> however there's nowhere describing "what will start to work, while it
> doesn't", "how bad is the problem", etc..  All the rest patches are about
> "what we can avoid do" after this patch.

For this part, I should be more clear on what I'm requesting on the
answers.

I think I get the whole point that MRs (while still with MR refcount
piggypacked, as of current QEMU master does) can circular reference itself
if not always detached properly, so explicitly my question is about:

- What devices / use case you encountered, that QEMU has such issue?
  Especially, this is about after we have merged commit ac7a892fd3 "memory:
  Fix leaks due to owner-shared MRs circular references".  Asking because I
  believe most of them should already auto-detach when owner is shared.

- From above list of broken devices, are there any devices that are
  hot-unpluggable (aka, high priority)?  Is it a problem if we do not
  finalize a MR if it is never removable anyway?

> 
> Meanwhile, the cover letter is misleading. It is:
> 
> [PATCH 00/14] Fix memory region use-after-finalization
> 
> I believe it's simply wrong, because the whole series is not about
> finalize() but unrealize().  For Device class, it also includes the exit()
> which will be invoked in pci_qdev_unrealize(), but that is also part of the
> unrealize() routine, not finalize().
> 
> The other question is, what if a MR has a owner that is not the device
> itself?  There's no place enforcing this, hence a qdev can logically have
> some sub-objects (which may not really be qdev) that can be the owner of
> the memory regions.  Then the device emulation will found that some MRs are
> auto-detached and some are not.
> 
> One example that I'm aware of is this:
> 
> https://lore.kernel.org/all/20250910115420.1012191-2-aesteve@redhat.com/#t
> 
> TYPE_VIRTIO_SHARED_MEMORY_MAPPING is an object, not qdev here, which can be
> the owner of the MR.
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu


