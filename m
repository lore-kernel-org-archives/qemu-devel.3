Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318F6CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 20:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzKzE-0004vf-W6; Thu, 18 Sep 2025 16:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzKzC-0004uP-O7
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzKz9-0001v0-D1
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758226325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oEVcW8H0ePrVkukmBhlQeYMXet9+27y8NnV6UVsaWN8=;
 b=X2YbZBLYFhjoSd+VcbaRzH+Mf3p9exp3Y4SnAQkvElFMwi3IJPxwYVUVQkS9KEriV1qawR
 wRfRTeUuZSzxGgaIXgbP9jbRsyWinFenu7lxFcK/zo87ISRg1GyQzRY8ZN3AJi4mxghXdL
 u1piyFlURmbOUvR9bbM5JRovSW2ijjA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Wb6XzFxJNuawwdK0WbJ18Q-1; Thu, 18 Sep 2025 16:12:04 -0400
X-MC-Unique: Wb6XzFxJNuawwdK0WbJ18Q-1
X-Mimecast-MFC-AGG-ID: Wb6XzFxJNuawwdK0WbJ18Q_1758226324
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b5fb1f057fso17003761cf.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 13:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758226324; x=1758831124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEVcW8H0ePrVkukmBhlQeYMXet9+27y8NnV6UVsaWN8=;
 b=GcliFwaF+sQzYge9/PH2MPz/vqQdBtCt+gwh0VhrDlYTbc5N/oysIlf5xtvrl5Jetp
 usH5ULUPjGISxsepA/IYR3sQ8onEURCUUYpWlxTyXihfP/PYaWoykmYIIn0ZkhYfX/Bb
 hV324zm13VO/LblyTE5oNdia9W8R9mXPZmOJcEdNdNqqs9FJzRtA9t1ZsFhHN1zBg8TK
 m51ezYCO7Bp+m9K5eS5J7HRX7F2BdKoeVFJ1c3NU43Jt0x/FWwVnFlw9bSL9G7nkB7j0
 /JkMiimREpOb1l+euT9f5fFaMTHIpz6V9nDSslOHLQN15CkOzj8Okxx3qWyNacpR/1Ua
 p0UQ==
X-Gm-Message-State: AOJu0YwecEbPf2UJMj/Nz8xd45cZmAdyqVWCg3S5Ly6HzbsV+OLFnDXe
 TMyREqwwT7GTH+oQ8hFgex/QdyAHgJb7yNBPcDj6ExeBFvcEcEYjb71Psb0DH6CKt09LDfAF817
 n7xHmqT/pzM3fVeyiOUN3ojtiNdyB9ZUiElsmh4vXV4sS0MZwp3BMn53y
X-Gm-Gg: ASbGncv+JBDqX8ecNt9kILyc0CroAA+QsQy6j2JeFHhm42JI1YHdWfebpnj/zIO6ymZ
 z+PhMctQrgzVEfdIX7TBNQ1sjaU1sHaRY1K23bZ2+kFO+bqlYwrBNMDhJHQ6f69wDak9CMIEF1D
 r3QJcsVBdvwE9r7H75vWnKBiKSGpr/KQ+lrHxtjfSE6jUez7QrPlmyLchgmMSpAIN5ZsTdZtY43
 Th2FWQwSsgeIEHeUB0BWV7nKgTcThruUOYDNuJLUJybm6utXctScQMSI/A/IIa37ZQNNopzZkKI
 9fpUqR4XbgEiGyahc1Cc2WrqwJJIHneUKc55ko3YIyS61ovfGmlySSdLx+spRoAYwjKqXqkNtKS
 IHW1WF6TTBsvNV5HX/gQwZA==
X-Received: by 2002:a05:622a:1c15:b0:4b7:7c2c:8534 with SMTP id
 d75a77b69052e-4c06e3f8fe3mr6440781cf.15.1758226323618; 
 Thu, 18 Sep 2025 13:12:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlL/+jeC2xoiK55a+vc+/BjJtvtoJAoNqaFYRNOAjjjJKNk/RRtRDSXXsR7MkcplaBP8vv5Q==
X-Received: by 2002:a05:622a:1c15:b0:4b7:7c2c:8534 with SMTP id
 d75a77b69052e-4c06e3f8fe3mr6440401cf.15.1758226322974; 
 Thu, 18 Sep 2025 13:12:02 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda23b2f56sm18877261cf.17.2025.09.18.13.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 13:12:02 -0700 (PDT)
Date: Thu, 18 Sep 2025 16:11:59 -0400
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
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Bin Meng <bmeng.cn@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 1/7] docs/devel: Do not unparent in instance_finalize()
Message-ID: <aMxnj7ID0PpWUVNu@x1.local>
References: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-use-v3-1-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
 <aMxlpfp_LSgiIk9Z@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMxlpfp_LSgiIk9Z@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 18, 2025 at 04:03:49PM -0400, Peter Xu wrote:
> On Wed, Sep 17, 2025 at 07:13:26PM +0900, Akihiko Odaki wrote:
> > Children are automatically unparented so manually unparenting is
> > unnecessary.
> > 
> > Worse, automatic unparenting happens before the instance_finalize()
> > callback of the parent gets called, so object_unparent() calls in
> > the callback will refer to objects that are already unparented, which
> > is semantically incorrect.
> > 
> > Remove the instruction to call object_unparent(), and the exception
> > of the "do not call object_unparent()" rule for instance_finalize().
> > 
> > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > ---
> >  docs/devel/memory.rst | 19 ++++++-------------
> >  1 file changed, 6 insertions(+), 13 deletions(-)
> > 
> > diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
> > index 57fb2aec76e0..749f11d8a4dd 100644
> > --- a/docs/devel/memory.rst
> > +++ b/docs/devel/memory.rst
> > @@ -161,18 +161,11 @@ or never.
> >  Destruction of a memory region happens automatically when the owner
> >  object dies.
> >  
> > -If however the memory region is part of a dynamically allocated data
> > -structure, you should call object_unparent() to destroy the memory region
> > -before the data structure is freed.  For an example see VFIOMSIXInfo
> > -and VFIOQuirk in hw/vfio/pci.c.
> 
> Should we still keep some of these examples?  After the series they'll be
> doing the right things.  Dynamic MRs are still slightly tricky, I think
> it's still good to have some references.
> 
> > -
> >  You must not destroy a memory region as long as it may be in use by a
> >  device or CPU.  In order to do this, as a general rule do not create or
> > -destroy memory regions dynamically during a device's lifetime, and only
> > -call object_unparent() in the memory region owner's instance_finalize
> > -callback.  The dynamically allocated data structure that contains the
> > -memory region then should obviously be freed in the instance_finalize
> > -callback as well.
> > +destroy memory regions dynamically during a device's lifetime.
> > +The dynamically allocated data structure that contains the
> > +memory region should be freed in the instance_finalize callback.
> >  
> >  If you break this rule, the following situation can happen:
> >  
> > @@ -198,9 +191,9 @@ this exception is rarely necessary, and therefore it is discouraged,
> >  but nevertheless it is used in a few places.
> >  
> >  For regions that "have no owner" (NULL is passed at creation time), the
> > -machine object is actually used as the owner.  Since instance_finalize is
> > -never called for the machine object, you must never call object_unparent
> > -on regions that have no owner, unless they are aliases or containers.
> > +machine object is actually used as the owner.  You must never call
> > +object_unparent on regions that have no owner, unless they are aliases
> > +or containers.
> 
> This looks like a completely separate change.  So we start to allow
> machines to be finalized now?  I'm not familiar with machine object
> lifecycles.  Maybe split it out even if it's true?

I didn't see anything elsewhere.  If you agree with above, I can queue this
series with above touched up, then no need to repost.

Thanks,

-- 
Peter Xu


