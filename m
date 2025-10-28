Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83FECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd9B-0002Dt-3D; Tue, 28 Oct 2025 02:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDd8w-0001VO-9X
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDd8s-0000tn-7Y
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761632711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OeXmMuJ97KCbHZk7IqcUJuHso1crt7OPye/x9BVq2QI=;
 b=Fo0ApXvOmSuSeEiwxt7CxZzxrrRnshOSD67OMp4of+3LY55XxJFR2qRrbLq2lotJ6S1uhe
 W/dNMQDP7kJbIsk6jLGQEjFlSiMEq+axciYRA0OJ/hNJjhtAfZuhQ1BXlhuLzZXacfQ9JS
 NVZPkRcrApvjZ7micgJb82+ubQX4TqA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-0z_1uip-M0O98Bed4sMRNg-1; Tue, 28 Oct 2025 02:25:09 -0400
X-MC-Unique: 0z_1uip-M0O98Bed4sMRNg-1
X-Mimecast-MFC-AGG-ID: 0z_1uip-M0O98Bed4sMRNg_1761632708
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-28eb14e3cafso110231095ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632708; x=1762237508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeXmMuJ97KCbHZk7IqcUJuHso1crt7OPye/x9BVq2QI=;
 b=UuXgSsO+fz6TYL4ouK1b81z8A1RsZJ3mbcELbLE7Hw0zfNYkjGeTcGQTjrnewiJyFZ
 SCAKHW/2FtIbq0Fjj9rBQjdyhOGOzkC2O+oDvcmrAXun6c3UE4XYR9Xfcv6umkc0D2db
 QP6d8de2xf/JPvaWW5ZOLpWnIzXTUnmvnlt3gHlHlSCWl+F0fiWdyc+lVZuRPgErFf5R
 hZGA/PMPKfLFi4J6wxY9RLaBz2zKUgRVboWSf7aFgGxVa7MpmJtorNdI0WwGkxGQvkIS
 oZsrce2PrdR4HK+XExIRflwsaDO1415HbkWOJktK+1bctwL8AIPs5T3jud1YBQIuFEUe
 ggnA==
X-Gm-Message-State: AOJu0YzHnpBWOP+AW6OG5zoT5yhVi7YPtqLlHUhCoINESs1uyZoXlHqB
 SovKhwgQanAsC1qATpjUs3To6NtQReRU1m8hSeP8zeL3MmggAUPRfUjQcZ/tt68WC5cT8/IljkR
 +5xII6YaGI1CSbkMUmLM0arVHq3Am/iJugkLzFqm/ed10Bx0T+P4qz1IE
X-Gm-Gg: ASbGncuexgvYcN3b8Gk5ehkoueoLWLBrVgIRlOP/sSYeO207v//JJhmUr2ixcN8Bt/v
 5GnfOBttprvQLJJCPM6xun8bZTAflsozJ2I6v5H21yWPOMhEDC7Cohl/Hl/uUPpsyGg8jl0AgbZ
 Hv0tkNg8i5NhNL7aQNU/adbpuisBKZuRhbVJv70ueiLrrHoYvvoEWf6iYniol9PD9gtq6hNWDwM
 5+nNECkTuKMsas0LCqRZJ611U8ZjkCZS5zgPOqplPeeXSijK3y4OvbtDPDLLmFU+GxahfbRSm/G
 xVwYSshe24w97HJ53e/7KKrKA/G4vZVIBaR0E2HvrAZ9PT6opPRfspzMIC7Spkbtq6FNc5RWN5C
 5/HA4U4r6e192
X-Received: by 2002:a17:902:c947:b0:281:613:844b with SMTP id
 d9443c01a7336-294cb6870c1mr30941765ad.52.1761632708015; 
 Mon, 27 Oct 2025 23:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrGh3bcHZ3IaaSLhfSS69jPmuH+IBZuxfo6RuSviz7BrcxLRW5FoUKaI+JgRG0FENFYGid2Q==
X-Received: by 2002:a17:902:c947:b0:281:613:844b with SMTP id
 d9443c01a7336-294cb6870c1mr30941535ad.52.1761632707673; 
 Mon, 27 Oct 2025 23:25:07 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d09a33sm102779215ad.32.2025.10.27.23.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 23:25:07 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:54:55 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] migration: Fix regression of passing error_fatal into
 vmstate_load_state()
Message-ID: <aQBht5GFEfqD5Ac3@armenon-kvm.bengluru.csb>
References: <20251024-solve_error_fatal_regression-v1-1-d26e6cbd0a7e@redhat.com>
 <c1be8f5a-fa01-4d02-88b6-76beeec4ab55@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1be8f5a-fa01-4d02-88b6-76beeec4ab55@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Akihiko,
Thanks for the review.

On Mon, Oct 27, 2025 at 09:37:52AM +0900, Akihiko Odaki wrote:
> On 2025/10/25 1:32, Arun Menon wrote:
> > error_fatal is passed to vmstate_load_state() and vmstate_save_state()
> > functions. This was introduced in commit c632ffbd74. This would exit(1)
> > on error, and therefore does not allow to propagate the error back to
> > the caller.
> > 
> > To maintain consistency with prior error handling i.e. either propagating
> > the error to the caller or reporting it, we must set the error within a
> > local Error object instead of using error_fatal.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   hw/display/virtio-gpu.c | 20 ++++++++++++++------
> >   hw/pci/pci.c            | 13 +++++++++++--
> >   hw/s390x/virtio-ccw.c   | 15 +++++++++++++--
> >   hw/scsi/spapr_vscsi.c   |  9 +++++++--
> >   hw/virtio/virtio-mmio.c | 15 +++++++++++++--
> >   hw/virtio/virtio-pci.c  | 15 +++++++++++++--
> >   hw/virtio/virtio.c      | 10 +++++++---
> >   7 files changed, 78 insertions(+), 19 deletions(-)
> > 
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 3a555125be60aa4c243cfb870caa517995de8183..c0c88c283e2ef7fa70b3fecc1e935cca76423276 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1225,7 +1225,8 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
> >   {
> >       VirtIOGPU *g = opaque;
> >       struct virtio_gpu_simple_resource *res;
> > -    int i;
> > +    Error *err = NULL;
> > +    int i, ret;
> >       /* in 2d mode we should never find unprocessed commands here */
> >       assert(QTAILQ_EMPTY(&g->cmdq));
> > @@ -1248,8 +1249,12 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
> >       }
> >       qemu_put_be32(f, 0); /* end of list */
> > -    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
> > -                              &error_fatal);
> > +    ret = vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
> > +                             &err);
> > +    if (ret < 0) {
> > +        error_report_err(err);
> > +    }
> > +    return ret;
> >   }
> >   static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
> > @@ -1288,7 +1293,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
> >       Error *err = NULL;
> >       struct virtio_gpu_simple_resource *res;
> >       uint32_t resource_id, pformat;
> > -    int i;
> > +    int i, ret;
> >       g->hostmem = 0;
> > @@ -1348,8 +1353,11 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
> >       }
> >       /* load & apply scanout state */
> > -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);
> > -
> > +    ret = vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &err);
> > +    if (ret < 0) {
> > +        error_report_err(err);
> > +        return ret;
> > +    }
> >       return 0;
> 
> virtio_gpu_save() always "return ret" instead of having "return ret" and
> "return 0"; this function can do the same.

Sure. Fixed in v2. Thanks.

> 
> >   }
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index acc03fd4707cdb843ba8ed8ff0e2cc8c4830932c..0090c72560de313db160f71ff494d206859ec796 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -925,8 +925,13 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
> >        * in irq_state which we are saving.
> >        * This makes us compatible with old devices
> >        * which never set or clear this bit. */
> > +    int ret;
> > +    Error *local_err = NULL;
> >       s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT;
> > -    vmstate_save_state(f, &vmstate_pci_device, s, NULL, &error_fatal);
> > +    ret = vmstate_save_state(f, &vmstate_pci_device, s, NULL, &local_err);
> > +    if (ret < 0) {
> > +        error_report_err(local_err);
> > +    }
> >       /* Restore the interrupt status bit. */

Regards,
Arun


