Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C18C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 11:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujc8b-000436-Kj; Wed, 06 Aug 2025 07:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujc8R-0003yv-5i
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujc8J-00068R-CO
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754478992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1gghhlXYV9oJg6nNuqzCYaEbzvsxGNLZ+jInpPah4rA=;
 b=QhhYDwL9VJQKPt8gEBfVH70N3QNz6J9Fjs8nMw50OXFJin44OaoDAgD3lLqVfDOFiw2rN5
 gs+XMA83jLvFCr8oVPQXulsVoNo480OCAOO4FX5zXw7saFfw3trHIi0DbFdlyEnQS0SAKt
 yrcZOb+CP+/juQdJjB6Ff2n/ctlVDvk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-bH4RFCHSNKCxlEfYqJh6KQ-1; Wed, 06 Aug 2025 07:16:30 -0400
X-MC-Unique: bH4RFCHSNKCxlEfYqJh6KQ-1
X-Mimecast-MFC-AGG-ID: bH4RFCHSNKCxlEfYqJh6KQ_1754478989
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-31ed2a7d475so5735372a91.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 04:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754478989; x=1755083789;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1gghhlXYV9oJg6nNuqzCYaEbzvsxGNLZ+jInpPah4rA=;
 b=X5y/47oe1AcPvp6d4cVMos4L1Yph7+h1/YAIjOOr6AeVwwe8xcNu9QvNdGQDZQvAf8
 BuTELxVT2urBsaXlm0zAQ7jCr/9f4Xo+VfKzOVPMu1p1NWX9BkyZBcmLJyKQBsY314+G
 Jj4SyJ7ZXVOxIe6Jv92xRt3HFC1lkGt6pSZgWiHQlWlSnm6eMmYeJB06EO9db0ntlitR
 gQ53XvOXPwZSGgmLiizTYRfIpwpNSWb+e+Mv2hHWqLVrQh0pmOmlwayFzhsV4B0AsX5q
 P0yg1euUWjES2YVWO0Bm9y03FYqHVKY53G+PQhUlxr/O+Ph1JOS4cV4utoIgEdrr/ihL
 oXew==
X-Gm-Message-State: AOJu0YyTyxnAhDrWBjbzy55BwxAJFXRNY48nKqUjSW8xyHKmZB4XMkwp
 bPQeWi61vmUbKi4/B1rrw9DQWUUsx+p9N1h7lKAWO/UfV9TyAqQPvpIwXVc5T+1u/0lhAUNaswP
 /JLMxHw7GfMOoWHhTUIYC0M6/+cdFh1tAPqR7Yyzh4FsAWyA/lrS47eVV
X-Gm-Gg: ASbGncuBXwxTPai4aRfc6B5D3dQu8RySbGOrvg5lnqMrHHj97F5fG3zH4ubIwZKzbPT
 WPbwM/rhM0rYiYqRJWlW7z3nRtJ1fbgbxLD87YEw8Mx/1wVzce1h50k+7OUiaLSlapm/RC/yOwu
 JjJehDBl7SIP24YL35wPBDKPpJbhEB1yaSN07JEdU1q6BGpmh+GQV1IwmFk+aSq+aaDcyxppRR5
 rIKdmdX4Tb/kthhOPIPmGN7DHNERjxtt3vNhDRZPSLfXa+Gh3ZBxGgVgxuIdg4orBgo8YSHG9+W
 At3RuiEb5Xya7/kYoFejgiwHyrAGfWv1cde4YxOcocDX2pM8dfcRtA==
X-Received: by 2002:a17:90b:388b:b0:31e:fac5:5d3f with SMTP id
 98e67ed59e1d1-3216752317fmr3372938a91.16.1754478988974; 
 Wed, 06 Aug 2025 04:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFclfoNcxl/kN3LBgQTAAflpMDN6P63eNMMPm9qcLhbYrO1uU+qtgXDjxRz+Wfr0Oqydk4JCA==
X-Received: by 2002:a17:90b:388b:b0:31e:fac5:5d3f with SMTP id
 98e67ed59e1d1-3216752317fmr3372817a91.16.1754478987797; 
 Wed, 06 Aug 2025 04:16:27 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.249])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ee49d5sm19624248a91.22.2025.08.06.04.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 04:16:27 -0700 (PDT)
Date: Wed, 6 Aug 2025 16:46:16 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 25/27] migration: Remove error variant of
 vmstate_save_state() function
Message-ID: <aJM5gEhU2_9EsAJ8@armenon-kvm.bengluru.csb>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-25-123450810db7@redhat.com>
 <CAMxuvayZkKyaTwj0orFx3k73=R0uesW2g-kZWVBDyoAiubP0WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvayZkKyaTwj0orFx3k73=R0uesW2g-kZWVBDyoAiubP0WQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Marc-André,

On Wed, Aug 06, 2025 at 12:28:54PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Aug 5, 2025 at 10:31 PM Arun Menon <armenon@redhat.com> wrote:
> 
> > This commit removes the redundant vmstate_save_state_with_err()
> > function.
> >
> > Previously, commit 969298f9d7 introduced vmstate_save_state_with_err()
> > to handle error propagation, while vmstate_save_state() existed for
> > non-error scenarios.
> > This is because there were code paths where vmstate_save_state_v()
> > (called internally by vmstate_save_state) did not explicitly set
> > errors on failure.
> >
> > This change unifies error handling by
> >  - updating vmstate_save_state() to accept an Error **errp argument.
> >  - vmstate_save_state_v() ensures errors are set directly within the errp
> >    object, eliminating the need for two separate functions. Specifically
> >    errors are handled by storing them in errp in vmstate_save_dispatch()
> >
> > All calls to vmstate_save_state_with_err() are replaced with
> > vmstate_save_state(). This simplifies the API and improves code
> > maintainability.
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> >
> 
> I realize that vmstate_save_state() callers progressively became silent on
> error with this series (switching to error_report to error_set). I suggest
> you make a preliminary patch to make vmstate_save_state() verbose by
> passing &error_warn to vmstate_save_state_v. wdyt?

On further examining, I see that vmstate_save_state_v() was never changed
from error_report to error_setg. There is only one error_report() call in
vmstate_save_state_v(), see below,

} else {                                                         
            if (field->flags & VMS_MUST_EXIST) {                         
                error_report("Output state validation failed: %s/%s",    
                        vmsd->name, field->name);                        
                assert(!(field->flags & VMS_MUST_EXIST));    


So if a caller called vmstate_save_state(), inturn calling vmstate_save_state_v()
that passed NULL, error_report() within the function should report that error.
This series did not convert any error_report to error_setg in vmstate_save_state_v().

Sorry to bring this up again. I was wondering do we still need an extra patch
in this case.

> 
> patch lgtm otherwise
> 
> 
> 
> 
> > ---
> >  hw/display/virtio-gpu.c     |  3 ++-
> >  hw/pci/pci.c                |  2 +-
> >  hw/s390x/virtio-ccw.c       |  2 +-
> >  hw/scsi/spapr_vscsi.c       |  2 +-
> >  hw/vfio/pci.c               |  4 ++--
> >  hw/virtio/virtio-mmio.c     |  2 +-
> >  hw/virtio/virtio-pci.c      |  2 +-
> >  hw/virtio/virtio.c          |  4 ++--
> >  include/migration/vmstate.h |  2 --
> >  migration/cpr.c             |  5 +++--
> >  migration/savevm.c          |  7 ++++---
> >  migration/vmstate-types.c   | 12 +++++++-----
> >  migration/vmstate.c         | 18 ++++++++----------
> >  tests/unit/test-vmstate.c   |  8 +++++---
> >  ui/vdagent.c                |  3 ++-
> >  15 files changed, 40 insertions(+), 36 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index
> > 5ff9f5e6dc0b6b112e36170318c900f893a73c5e..bddb26fa21312e5d0b2b6412cdf2a6c28dd06eb3
> > 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1246,7 +1246,8 @@ static int virtio_gpu_save(QEMUFile *f, void
> > *opaque, size_t size,
> >      }
> >      qemu_put_be32(f, 0); /* end of list */
> >
> > -    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
> > +    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
> > +                              &error_warn);
> >  }
> >
> >  static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index
> > 80545189980f176ca6a3dc9abce7043c8bc2708c..f7fb3931ff190c25ffa665ba80abe7737dbefdb6
> > 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -926,7 +926,7 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
> >       * This makes us compatible with old devices
> >       * which never set or clear this bit. */
> >      s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT;
> > -    vmstate_save_state(f, &vmstate_pci_device, s, NULL);
> > +    vmstate_save_state(f, &vmstate_pci_device, s, NULL, &error_warn);
> >      /* Restore the interrupt status bit. */
> >      pci_update_irq_status(s);
> >  }
> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > index
> > bafcb9b76d81749925e31b5a0a1320b3332ad2cf..14304fd3e8901d28a7788266df2c7ef7334b691c
> > 100644
> > --- a/hw/s390x/virtio-ccw.c
> > +++ b/hw/s390x/virtio-ccw.c
> > @@ -1130,7 +1130,7 @@ static int virtio_ccw_load_queue(DeviceState *d, int
> > n, QEMUFile *f)
> >  static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
> >  {
> >      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> > -    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL);
> > +    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL,
> > &error_warn);
> >  }
> >
> >  static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
> > diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> > index
> > a4812afd0cc7c495080ef03a531c7d279af29b33..2204beb40c7cdc827db2bf86fb8612d8c09999ed
> > 100644
> > --- a/hw/scsi/spapr_vscsi.c
> > +++ b/hw/scsi/spapr_vscsi.c
> > @@ -630,7 +630,7 @@ static void vscsi_save_request(QEMUFile *f,
> > SCSIRequest *sreq)
> >      vscsi_req *req = sreq->hba_private;
> >      assert(req->active);
> >
> > -    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL);
> > +    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL,
> > &error_warn);
> >
> >      trace_spapr_vscsi_save_request(req->qtag, req->cur_desc_num,
> >                                     req->cur_desc_offset);
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index
> > 04d385d7674f444844beeee7364ee0424f762758..8e2b6d611de8efdf98235355226f5e5a6fd87b19
> > 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2780,8 +2780,8 @@ static int vfio_pci_save_config(VFIODevice
> > *vbasedev, QEMUFile *f, Error **errp)
> >  {
> >      VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> >
> > -    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev,
> > NULL,
> > -                                       errp);
> > +    return vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL,
> > +                              errp);
> >  }
> >
> >  static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> > index
> > f14f0487fec3ed30d2cc3aec96950c2121265716..58957990743f061e78d0eafcfcb6cc5989252edc
> > 100644
> > --- a/hw/virtio/virtio-mmio.c
> > +++ b/hw/virtio/virtio-mmio.c
> > @@ -613,7 +613,7 @@ static void virtio_mmio_save_extra_state(DeviceState
> > *opaque, QEMUFile *f)
> >  {
> >      VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
> >
> > -    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL);
> > +    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL, &error_warn);
> >  }
> >
> >  static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index
> > 07f144d6d1bfbb561b28015de71762601080dc23..0826399cdfbf09b5b3f9acd9967de3417858c9d2
> > 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -154,7 +154,7 @@ static void virtio_pci_save_extra_state(DeviceState
> > *d, QEMUFile *f)
> >  {
> >      VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
> >
> > -    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL);
> > +    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL, &error_warn);
> >  }
> >
> >  static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index
> > aac317a93c3cd55ece9b0fd858c7b2459f8242f9..552e167529e9c22fb4cba2b445ffad85fef619f3
> > 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3025,14 +3025,14 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
> >      }
> >
> >      if (vdc->vmsd) {
> > -        int ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL);
> > +        int ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL,
> > &error_warn);
> >          if (ret) {
> >              return ret;
> >          }
> >      }
> >
> >      /* Subsections */
> > -    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
> > +    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL,
> > &error_warn);
> >  }
> >
> >  /* A wrapper for use as a VMState .put function */
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index
> > 056781b1c21e737583f081594d9f88b32adfd674..5fe9bbf39058d0cf97c1adab54cc516dbe8dc32a
> > 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -1198,8 +1198,6 @@ extern const VMStateInfo vmstate_info_qlist;
> >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >                         void *opaque, int version_id, Error **errp);
> >  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> > -                       void *opaque, JSONWriter *vmdesc);
> > -int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription
> > *vmsd,
> >                         void *opaque, JSONWriter *vmdesc, Error **errp);
> >  int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >                           void *opaque, JSONWriter *vmdesc,
> > diff --git a/migration/cpr.c b/migration/cpr.c
> > index
> > bdb24736f44e91ba59b6e622a315597c97e7f64d..d48f013dac21b531e41a26f4bb33eefe32097757
> > 100644
> > --- a/migration/cpr.c
> > +++ b/migration/cpr.c
> > @@ -163,6 +163,7 @@ bool cpr_is_incoming(void)
> >
> >  int cpr_state_save(MigrationChannel *channel, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      int ret;
> >      QEMUFile *f;
> >      MigMode mode = migrate_mode();
> > @@ -182,9 +183,9 @@ int cpr_state_save(MigrationChannel *channel, Error
> > **errp)
> >      qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
> >      qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
> >
> > -    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0);
> > +    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0, errp);
> >      if (ret) {
> > -        error_setg(errp, "vmstate_save_state error %d", ret);
> > +        error_prepend(errp, "vmstate_save_state error %d: ", ret);
> >          qemu_fclose(f);
> >          return ret;
> >      }
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index
> > 4df50fb5c674e56c0173c357c1e23367373e2114..3cb9c34efb22fdcb2b05cf1fefcb6fbd80cadca5
> > 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1056,8 +1056,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry
> > *se, JSONWriter *vmdesc,
> >      if (!se->vmsd) {
> >          vmstate_save_old_style(f, se, vmdesc);
> >      } else {
> > -        ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc,
> > -                                          errp);
> > +        ret = vmstate_save_state(f, se->vmsd, se->opaque, vmdesc,
> > +                                 errp);
> >          if (ret) {
> >              return ret;
> >          }
> > @@ -1303,7 +1303,8 @@ void qemu_savevm_state_header(QEMUFile *f)
> >              json_writer_start_object(vmdesc, "configuration");
> >          }
> >
> > -        vmstate_save_state(f, &vmstate_configuration, &savevm_state,
> > vmdesc);
> > +        vmstate_save_state(f, &vmstate_configuration, &savevm_state,
> > vmdesc,
> > +                           &error_warn);
> >
> >          if (vmdesc) {
> >              json_writer_end_object(vmdesc);
> > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> > index
> > e2020a733d0921d748b6f832a193e5de8d302d5f..2b88dc145ab32072f09845cee95b79aad7ac3cb2
> > 100644
> > --- a/migration/vmstate-types.c
> > +++ b/migration/vmstate-types.c
> > @@ -564,7 +564,7 @@ static int put_tmp(QEMUFile *f, void *pv, size_t size,
> >
> >      /* Writes the parent field which is at the start of the tmp */
> >      *(void **)tmp = pv;
> > -    ret = vmstate_save_state(f, vmsd, tmp, vmdesc);
> > +    ret = vmstate_save_state(f, vmsd, tmp, vmdesc, &error_warn);
> >      g_free(tmp);
> >
> >      return ret;
> > @@ -675,7 +675,7 @@ static int put_qtailq(QEMUFile *f, void *pv, size_t
> > unused_size,
> >
> >      QTAILQ_RAW_FOREACH(elm, pv, entry_offset) {
> >          qemu_put_byte(f, true);
> > -        ret = vmstate_save_state(f, vmsd, elm, vmdesc);
> > +        ret = vmstate_save_state(f, vmsd, elm, vmdesc, &error_warn);
> >          if (ret) {
> >              return ret;
> >          }
> > @@ -712,7 +712,8 @@ static gboolean put_gtree_elem(gpointer key, gpointer
> > value, gpointer data)
> >      if (!capsule->key_vmsd) {
> >          qemu_put_be64(f, (uint64_t)(uintptr_t)(key)); /* direct key */
> >      } else {
> > -        ret = vmstate_save_state(f, capsule->key_vmsd, key,
> > capsule->vmdesc);
> > +        ret = vmstate_save_state(f, capsule->key_vmsd, key,
> > capsule->vmdesc,
> > +                                 &error_warn);
> >          if (ret) {
> >              capsule->ret = ret;
> >              return true;
> > @@ -720,7 +721,8 @@ static gboolean put_gtree_elem(gpointer key, gpointer
> > value, gpointer data)
> >      }
> >
> >      /* put the data */
> > -    ret = vmstate_save_state(f, capsule->val_vmsd, value,
> > capsule->vmdesc);
> > +    ret = vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmdesc,
> > +                             &error_warn);
> >      if (ret) {
> >          capsule->ret = ret;
> >          return true;
> > @@ -856,7 +858,7 @@ static int put_qlist(QEMUFile *f, void *pv, size_t
> > unused_size,
> >      trace_put_qlist(field->name, vmsd->name, vmsd->version_id);
> >      QLIST_RAW_FOREACH(elm, pv, entry_offset) {
> >          qemu_put_byte(f, true);
> > -        ret = vmstate_save_state(f, vmsd, elm, vmdesc);
> > +        ret = vmstate_save_state(f, vmsd, elm, vmdesc, &error_warn);
> >          if (ret) {
> >              error_report("%s: failed to save %s (%d)", field->name,
> >                           vmsd->name, ret);
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index
> > ef78a1e62ad92e9608de72d125da80ea496c8dd1..569e66ea983f833e6a0d651d2a751f34a64e8f5c
> > 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -403,12 +403,6 @@ bool vmstate_section_needed(const VMStateDescription
> > *vmsd, void *opaque)
> >
> >
> >  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> > -                       void *opaque, JSONWriter *vmdesc_id)
> > -{
> > -    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id,
> > vmsd->version_id, NULL);
> > -}
> > -
> > -int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription
> > *vmsd,
> >                         void *opaque, JSONWriter *vmdesc_id, Error **errp)
> >  {
> >      return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id,
> > vmsd->version_id, errp);
> > @@ -530,7 +524,7 @@ static int vmstate_save_dispatch(QEMUFile *f,
> >
> >                  if (inner_field->flags & VMS_STRUCT) {
> >                      ret = vmstate_save_state(f, inner_field->vmsd,
> > -                                             curr_elem, vmdesc_loop);
> > +                                             curr_elem, vmdesc_loop,
> > errp);
> >                  } else if (inner_field->flags & VMS_VSTRUCT) {
> >                      ret = vmstate_save_state_v(f, inner_field->vmsd,
> >                                                 curr_elem, vmdesc_loop,
> > @@ -539,6 +533,10 @@ static int vmstate_save_dispatch(QEMUFile *f,
> >                  } else {
> >                      ret = inner_field->info->put(f, curr_elem, size,
> >                                                   inner_field,
> > vmdesc_loop);
> > +                    if (ret) {
> > +                        error_setg(errp, "Save of field %s failed",
> > +                                   inner_field->name);
> > +                    }
> >                  }
> >
> >                  written_bytes = qemu_file_transferred(f) - old_offset;
> > @@ -551,8 +549,8 @@ static int vmstate_save_dispatch(QEMUFile *f,
> >                  }
> >
> >                  if (ret) {
> > -                    error_setg(errp, "Save of field %s/%s failed",
> > -                                vmsd->name, field->name);
> > +                    error_prepend(errp, "Save of field %s/%s failed: ",
> > +                                  vmsd->name, field->name);
> >                      ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
> >                      if (ps_ret) {
> >                          ret = ps_ret;
> > @@ -723,7 +721,7 @@ static int vmstate_subsection_save(QEMUFile *f, const
> > VMStateDescription *vmsd,
> >              qemu_put_byte(f, len);
> >              qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
> >              qemu_put_be32(f, vmsdsub->version_id);
> > -            ret = vmstate_save_state_with_err(f, vmsdsub, opaque, vmdesc,
> > errp);
> > +            ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc, errp);
> >              if (ret) {
> >                  return ret;
> >              }
> > diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
> > index
> > 807deb3531f3079864ac99567d4dece7122571dd..5f31ed4b6969c4ebf72b298f965bcbdc752ff87f
> > 100644
> > --- a/tests/unit/test-vmstate.c
> > +++ b/tests/unit/test-vmstate.c
> > @@ -69,7 +69,7 @@ static void save_vmstate(const VMStateDescription *desc,
> > void *obj)
> >      QEMUFile *f = open_test_file(true);
> >
> >      /* Save file with vmstate */
> > -    int ret = vmstate_save_state(f, desc, obj, NULL);
> > +    int ret = vmstate_save_state(f, desc, obj, NULL, &error_warn);
> >      g_assert(!ret);
> >      qemu_put_byte(f, QEMU_VM_EOF);
> >      g_assert(!qemu_file_get_error(f));
> > @@ -429,7 +429,8 @@ static void test_save_noskip(void)
> >      QEMUFile *fsave = open_test_file(true);
> >      TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
> >                         .skip_c_e = false };
> > -    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
> > +    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL,
> > +                                 &error_warn);
> >      g_assert(!ret);
> >      g_assert(!qemu_file_get_error(fsave));
> >
> > @@ -451,7 +452,8 @@ static void test_save_skip(void)
> >      QEMUFile *fsave = open_test_file(true);
> >      TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
> >                         .skip_c_e = true };
> > -    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
> > +    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL,
> > +                                 &error_warn);
> >      g_assert(!ret);
> >      g_assert(!qemu_file_get_error(fsave));
> >
> > diff --git a/ui/vdagent.c b/ui/vdagent.c
> > index
> > b9a22a689d9acfeafb862ae73308db6fbd52331e..e0fc7ff71468bfe66761385387653c742c375f05
> > 100644
> > --- a/ui/vdagent.c
> > +++ b/ui/vdagent.c
> > @@ -992,7 +992,8 @@ static int put_cbinfo(QEMUFile *f, void *pv, size_t
> > size,
> >          }
> >      }
> >
> > -    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmdesc);
> > +    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmdesc,
> > +                              &error_warn);
> >  }
> >
> >  static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
> >
> > --
> > 2.50.1
> >
> >

Regards,
Arun Menon


