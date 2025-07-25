Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B09C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 07:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufCaZ-0001XG-NZ; Fri, 25 Jul 2025 03:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCaX-0001Tz-Io
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:11:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCaS-0003n2-Rx
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753427483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/hiNlo9F2pP4knHdvgt5I6g4j66HbyowG3XokjDKYzg=;
 b=d3Og4oCQGTCahNQ2kC1Gz5nQmNSHbEUDk04Bzrgm40BmHgAGB3M+Ajn4d0kpy10WtVfPzH
 PIxZ+KOIGyfFmSFmX7qQZHznuRDycBf2DBuvfKOAda29cpo3tMuXk1fao3kQeJn3N1mKeY
 pDjxtyLIEbJke6xqtiGfjw6H7yWjS/I=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-PTMa1iXTNGisVaDWGshBmA-1; Fri, 25 Jul 2025 03:11:21 -0400
X-MC-Unique: PTMa1iXTNGisVaDWGshBmA-1
X-Mimecast-MFC-AGG-ID: PTMa1iXTNGisVaDWGshBmA_1753427480
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b38ec062983so1281682a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 00:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753427480; x=1754032280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hiNlo9F2pP4knHdvgt5I6g4j66HbyowG3XokjDKYzg=;
 b=ZA7xafFkvGq6SI+GSZBasezJ/l7Tdq/CrF7uQ85zdrgQQgon4zKz5WboqxvpYxVqfl
 SyP4Z494uAm4s5U/+D/impazNgVZ0yN4l/atSQSZ2Chc2pda9GsVdDs++IhYTdpQe2y9
 ARI5Sk8r1BSVfgY9PDQapLXM1ig/IWTw+9IIdT9LUrzbisMOSkZMGrWYNY+5G8ORbzJQ
 VrzPzCpB4Aw4jVea0PCNbb8Do5tshIbtFADH+TPcIdA/+pgU8X6tIC2nczSNOo8puAhm
 /jkiKjjK2izDEBQS8Ooir27O+UQ6w6N9GR500DZHP92BVez5ayf77UhTAWDBrXCiE8fh
 hNDg==
X-Gm-Message-State: AOJu0YwNJghEfSm1lXsgpMZmuuOVrcCKCHi24qbqNmeIIwLlVuPv4stO
 RoV+TEBNW/kYIBm4kMDBUJYsV0pBoD5s82OlRafU3DY9StpdDI5ldJrqNgd1hWbQx+s2dGks+6f
 0BaHp9yeHwcqUuAp/xxIKBX9T2auyMuk3J8MklAg7euL4Pq2fdvMifutp
X-Gm-Gg: ASbGncvtHZb4GKHF/h6mQgoVqk97M1i7dDiRjJFpM/SbHsa6RS/+v9hF+LEg3pqEtb0
 qN4+IV3Nxy6ImwMYvw08xkakcdy9RWQdo1x/W+iR8Dnvr4Ju7RW+fg8jX57xdP2+pi1VJYZ5h0w
 6wwDwlD4nhWV0r23m3TtTmCya4/1eZgL65uacqn5mc8lvMtRAzB04PzLcKlKdhTtd/73iky6s2e
 sUYcpsv6eCHLXHrRTfluO6c6gwZWL/vdTQxgOuMUGrr36ACFZXo+krPdpEzKSCPQRjLoqX9PNED
 +780UYdSqdcQsjb5dExqKCtFyw3m+mq+XRa2L0oP9PaaLWzWkhhb
X-Received: by 2002:a05:6a20:a125:b0:22c:5ade:f9dd with SMTP id
 adf61e73a8af0-23d701c593amr1168944637.42.1753427479771; 
 Fri, 25 Jul 2025 00:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/cWOY8R/R1W1FQvf2gsWymAhpVoplkhIFbAfR93npPqnQpqZMLDM0mgbl4YXWetq2kw0ogQ==
X-Received: by 2002:a05:6a20:a125:b0:22c:5ade:f9dd with SMTP id
 adf61e73a8af0-23d701c593amr1168877637.42.1753427479134; 
 Fri, 25 Jul 2025 00:11:19 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.73])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761adb7874csm3204229b3a.2.2025.07.25.00.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 00:11:18 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:41:07 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v6 02/24] migration: push Error **errp into
 vmstate_load_state()
Message-ID: <aIMuC4WXrq-vvV1M@armenon-kvm.bengluru.csb>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-2-fef740e15e17@redhat.com>
 <1aae8b7a-fe5a-4250-8184-b966d299010d@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aae8b7a-fe5a-4250-8184-b966d299010d@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,
Thanks for the review.

On Mon, Jul 21, 2025 at 09:24:58PM +0900, Akihiko Odaki wrote:
> On 2025/07/21 20:29, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that vmstate_load_state() must report an error
> > in errp, in case of failure.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   hw/display/virtio-gpu.c     |  2 +-
> >   hw/pci/pci.c                |  2 +-
> >   hw/s390x/virtio-ccw.c       |  2 +-
> >   hw/scsi/spapr_vscsi.c       |  2 +-
> >   hw/vfio/pci.c               |  2 +-
> >   hw/virtio/virtio-mmio.c     |  2 +-
> >   hw/virtio/virtio-pci.c      |  2 +-
> >   hw/virtio/virtio.c          |  4 ++--
> >   include/migration/vmstate.h |  2 +-
> >   migration/cpr.c             |  4 ++--
> >   migration/savevm.c          |  6 ++++--
> >   migration/vmstate-types.c   | 10 +++++-----
> >   migration/vmstate.c         | 45 ++++++++++++++++++++++++++++-----------------
> >   tests/unit/test-vmstate.c   | 18 +++++++++---------
> >   ui/vdagent.c                |  2 +-
> >   15 files changed, 59 insertions(+), 46 deletions(-)
> > 
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 0a1a625b0ea6cf26cb0d799171a57ed3d3ab2442..5d2ca8d8b864350133a674802d7316abd379591c 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1343,7 +1343,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
> >       }
> >       /* load & apply scanout state */
> > -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> > +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, NULL);
> >       return 0;
> >   }
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index c70b5ceebaf1f2b10768bd030526cbb518da2b8d..2ab5d30bb3c319ac1c7bfc9a2acf6a2b38082066 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -934,7 +934,7 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
> >   int pci_device_load(PCIDevice *s, QEMUFile *f)
> >   {
> >       int ret;
> > -    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id);
> > +    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id, NULL);
> >       /* Restore the interrupt status bit. */
> >       pci_update_irq_status(s);
> >       return ret;
> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > index d2f85b39f30f7fc82e0c600144c0a958e1269b2c..2f6feff2b0a22d7d7f6aecfd7e7870d8362f1a73 100644
> > --- a/hw/s390x/virtio-ccw.c
> > +++ b/hw/s390x/virtio-ccw.c
> > @@ -1136,7 +1136,7 @@ static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
> >   static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
> >   {
> >       VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> > -    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
> > +    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, NULL);
> >   }
> >   static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
> > diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> > index 20f70fb2729de78b9636a6b8c869695dab4f8902..573fdea668536b464bca11f001e9e0288e781493 100644
> > --- a/hw/scsi/spapr_vscsi.c
> > +++ b/hw/scsi/spapr_vscsi.c
> > @@ -648,7 +648,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq)
> >       assert(!req->active);
> >       memset(req, 0, sizeof(*req));
> > -    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
> > +    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, NULL);
> >       if (rc) {
> >           fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->tag);
> >           return NULL;
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index be05002b9819fafa45cf2fb4d2a0acdc475c558c..f8ce4a40dbe4c070a0d6c111051051ee97542719 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2797,7 +2797,7 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> >           old_addr[bar] = pdev->io_regions[bar].addr;
> >       }
> > -    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
> > +    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1, NULL);
> >       if (ret) {
> >           return ret;
> >       }
> > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> > index 532c67107ba1d2978a76cf49f9cdc1de1dea3e11..9058b1563462d4464dcba799643a583c93fb5683 100644
> > --- a/hw/virtio/virtio-mmio.c
> > +++ b/hw/virtio/virtio-mmio.c
> > @@ -619,7 +619,7 @@ static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
> >   {
> >       VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
> > -    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
> > +    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, NULL);
> >   }
> >   static bool virtio_mmio_has_extra_state(DeviceState *opaque)
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 767216d795998708f5716a23ae16c79cd90ff489..f8b52a611e56c22d844fd4cae3619da4f2686d03 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -161,7 +161,7 @@ static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
> >   {
> >       VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
> > -    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1);
> > +    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, NULL);
> >   }
> >   static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 2ab1d20769495ea39445b87e3673b076ad172510..d5698b062a1e95437f6113f41136e90ae06f1974 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3317,14 +3317,14 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> >       }
> >       if (vdc->vmsd) {
> > -        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id);
> > +        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id, NULL);
> >           if (ret) {
> >               return ret;
> >           }
> >       }
> >       /* Subsections */
> > -    ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1);
> > +    ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1, NULL);
> >       if (ret) {
> >           return ret;
> >       }
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..056781b1c21e737583f081594d9f88b32adfd674 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -1196,7 +1196,7 @@ extern const VMStateInfo vmstate_info_qlist;
> >       }
> >   int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> > -                       void *opaque, int version_id);
> > +                       void *opaque, int version_id, Error **errp);
> >   int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> >                          void *opaque, JSONWriter *vmdesc);
> >   int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
> > diff --git a/migration/cpr.c b/migration/cpr.c
> > index 42ad0b0d500e5de57faf0c6517e216b2d1c0cacf..74fac9521717ec568d14dabcbcb574b19fc1da67 100644
> > --- a/migration/cpr.c
> > +++ b/migration/cpr.c
> > @@ -233,9 +233,9 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
> >           return -ENOTSUP;
> >       }
> > -    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
> > +    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);
> >       if (ret) {
> > -        error_setg(errp, "vmstate_load_state error %d", ret);
> > +        error_prepend(errp, "vmstate_load_state error %d ", ret);
> >           qemu_fclose(f);
> >           return ret;
> >       }
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index fabbeb296ae987d0c06ba6dafda63720205fecfd..ab947620f724874f325fb9fb59bef50b7c16fb51 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -969,7 +969,8 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
> >       if (!se->vmsd) {         /* Old style */
> >           return se->ops->load_state(f, se->opaque, se->load_version_id);
> >       }
> > -    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id);
> > +    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
> > +                              NULL);
> >   }
> >   static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
> > @@ -2839,7 +2840,8 @@ static int qemu_loadvm_state_header(QEMUFile *f)
> >               error_report("Configuration section missing");
> >               return -EINVAL;
> >           }
> > -        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
> > +        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
> > +                                 NULL);
> >           if (ret) {
> >               return ret;
> > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> > index 741a588b7e18c6d37724b08a0101edc8bc74a0a5..1c5b76e1dd198030847971bc35637867c9d54fc0 100644
> > --- a/migration/vmstate-types.c
> > +++ b/migration/vmstate-types.c
> > @@ -549,7 +549,7 @@ static int get_tmp(QEMUFile *f, void *pv, size_t size,
> >       /* Writes the parent field which is at the start of the tmp */
> >       *(void **)tmp = pv;
> > -    ret = vmstate_load_state(f, vmsd, tmp, version_id);
> > +    ret = vmstate_load_state(f, vmsd, tmp, version_id, NULL);
> >       g_free(tmp);
> >       return ret;
> >   }
> > @@ -649,7 +649,7 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
> >       while (qemu_get_byte(f)) {
> >           elm = g_malloc(size);
> > -        ret = vmstate_load_state(f, vmsd, elm, version_id);
> > +        ret = vmstate_load_state(f, vmsd, elm, version_id, NULL);
> >           if (ret) {
> >               return ret;
> >           }
> > @@ -803,7 +803,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
> >               key = (void *)(uintptr_t)qemu_get_be64(f);
> >           } else {
> >               key = g_malloc0(key_size);
> > -            ret = vmstate_load_state(f, key_vmsd, key, version_id);
> > +            ret = vmstate_load_state(f, key_vmsd, key, version_id, NULL);
> >               if (ret) {
> >                   error_report("%s : failed to load %s (%d)",
> >                                field->name, key_vmsd->name, ret);
> > @@ -811,7 +811,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
> >               }
> >           }
> >           val = g_malloc0(val_size);
> > -        ret = vmstate_load_state(f, val_vmsd, val, version_id);
> > +        ret = vmstate_load_state(f, val_vmsd, val, version_id, NULL);
> >           if (ret) {
> >               error_report("%s : failed to load %s (%d)",
> >                            field->name, val_vmsd->name, ret);
> > @@ -892,7 +892,7 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
> >       while (qemu_get_byte(f)) {
> >           elm = g_malloc(size);
> > -        ret = vmstate_load_state(f, vmsd, elm, version_id);
> > +        ret = vmstate_load_state(f, vmsd, elm, version_id, NULL);
> >           if (ret) {
> >               error_report("%s: failed to load %s (%d)", field->name,
> >                            vmsd->name, ret);
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index 129b19d7603a0ddf8ab6e946e41c1c4d773d1fa8..288b57e1ed778cce21247b64d5e97dfef41ad586 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -132,29 +132,33 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
> >   }
> >   int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> > -                       void *opaque, int version_id)
> > +                       void *opaque, int version_id, Error **errp)
> >   {
> >       const VMStateField *field = vmsd->fields;
> >       int ret = 0;
> >       trace_vmstate_load_state(vmsd->name, version_id);
> >       if (version_id > vmsd->version_id) {
> > -        error_report("%s: incoming version_id %d is too new "
> > -                     "for local version_id %d",
> > -                     vmsd->name, version_id, vmsd->version_id);
> > +        error_setg(errp, "%s: incoming version_id %d is too new "
> > +                   "for local version_id %d",
> > +                   vmsd->name, version_id, vmsd->version_id);
> >           trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
> >           return -EINVAL;
> >       }
> >       if  (version_id < vmsd->minimum_version_id) {
> > -        error_report("%s: incoming version_id %d is too old "
> > -                     "for local minimum version_id  %d",
> > -                     vmsd->name, version_id, vmsd->minimum_version_id);
> > +        error_setg(errp, "%s: incoming version_id %d is too old "
> > +                   "for local minimum version_id  %d",
> > +                   vmsd->name, version_id, vmsd->minimum_version_id);
> >           trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
> >           return -EINVAL;
> >       }
> >       if (vmsd->pre_load) {
> >           ret = vmsd->pre_load(opaque);
> >           if (ret) {
> > +            error_setg(errp, "VM pre load failed for: '%s', "
> > +                       "version_id: '%d', minimum version_id: '%d', ret: %d",
> > +                       vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
> > +                       ret);
> >               return ret;
> >           }
> >       }
> > @@ -192,10 +196,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >                   if (inner_field->flags & VMS_STRUCT) {
> >                       ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> > -                                             inner_field->vmsd->version_id);
> > +                                             inner_field->vmsd->version_id,
> > +                                             errp);
> >                   } else if (inner_field->flags & VMS_VSTRUCT) {
> >                       ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> > -                                             inner_field->struct_version_id);
> > +                                             inner_field->struct_version_id,
> > +                                             errp);
> >                   } else {
> >                       ret = inner_field->info->get(f, curr_elem, size,
> >                                                    inner_field);
> > @@ -211,27 +217,32 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >                   }
> >                   if (ret < 0) {
> >                       qemu_file_set_error(f, ret);
> > -                    error_report("Failed to load %s:%s", vmsd->name,
> > -                                 field->name);
> > +                    error_prepend(errp, "Failed to load %s:%s version_id: %d ",
> > +                                  vmsd->name, field->name, vmsd->version_id);
> >                       trace_vmstate_load_field_error(field->name, ret);
> >                       return ret;
> >                   }
> >               }
> >           } else if (field->flags & VMS_MUST_EXIST) {
> > -            error_report("Input validation failed: %s/%s",
> > -                         vmsd->name, field->name);
> > +            error_setg(errp, "Input validation failed: %s/%s version_id: %d",
> > +                       vmsd->name, field->name, vmsd->version_id);
> >               return -1;
> >           }
> >           field++;
> >       }
> >       assert(field->flags == VMS_END);
> > -    ret = vmstate_subsection_load(f, vmsd, opaque, NULL);
> > +    ret = vmstate_subsection_load(f, vmsd, opaque, errp);
> >       if (ret != 0) {
> >           qemu_file_set_error(f, ret);
> >           return ret;
> >       }
> >       if (vmsd->post_load) {
> >           ret = vmsd->post_load(opaque, version_id);
> > +        if (ret < 0) {
> > +            error_setg(errp, "VM Post load failed for: %s, version_id: %d,"
> > +                       "minimum_version: %d, ret: %d", vmsd->name,
> 
> This error message lacks a whitespace between "," and "minimum_version".
Yes, shall amend.
> 
> By the way, I prefer not to have line breaks in string literals to ease code
> search.
> 
> While QEMU's coding style guide says nothing about the length limit for a
> line with a string literal, scripts/checkpatch.pl make an exemption for such
> a line.
> 
> scripts/checkpatch.pl came from Linux, and Linux's coding style guide says:
> > However, never break user-visible strings such as printk messages
> > because that breaks the ability to grep for them.
> 
> https://www.kernel.org/doc/html/v6.15/process/coding-style.html#breaking-long-lines-and-strings
> 
> While we don't have to follow Linux's style, I think this particular
> statement makes sense for QEMU too.

Given that I want to make the script work, because it is part of the workflow
'b4 prep --check; b4 send;' and that I also agree to what you say about searching 
the codebase using these strings, I shall try to use bare minimum line breaks, if
that is ok.
I will keep grep searchability in mind while making these line break decisions.

> 
> > +                       vmsd->version_id, vmsd->minimum_version_id, ret);
> > +        }
> >       }
> >       trace_vmstate_load_state_end(vmsd->name, "end", ret);
> >       return ret;
> > @@ -607,11 +618,11 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
> >           qemu_file_skip(f, len); /* idstr */
> >           version_id = qemu_get_be32(f);
> > -        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
> > +        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id, errp);
> >           if (ret) {
> >               trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
> > -            error_setg(errp, "Loading VM subsection '%s' in '%s' failed : %d",
> > -                       idstr, vmsd->name, ret);
> > +            error_prepend(errp, "Loading VM subsection '%s'"
> > +                          "in '%s' failed : %d ", idstr, vmsd->name, ret);
> >               return ret;
> >           }
> >       }
> > diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
> > index 63f28f26f45691a70936d33e7341d16477a3471f..ca5e0ba1e3e5e2bb0a1ce39143a292f2c6f9420a 100644
> > --- a/tests/unit/test-vmstate.c
> > +++ b/tests/unit/test-vmstate.c
> > @@ -114,7 +114,7 @@ static int load_vmstate_one(const VMStateDescription *desc, void *obj,
> >       qemu_fclose(f);
> >       f = open_test_file(false);
> > -    ret = vmstate_load_state(f, desc, obj, version);
> > +    ret = vmstate_load_state(f, desc, obj, version, NULL);
> >       if (ret) {
> >           g_assert(qemu_file_get_error(f));
> >       } else{
> > @@ -365,7 +365,7 @@ static void test_load_v1(void)
> >       QEMUFile *loading = open_test_file(false);
> >       TestStruct obj = { .b = 200, .e = 500, .f = 600 };
> > -    vmstate_load_state(loading, &vmstate_versioned, &obj, 1);
> > +    vmstate_load_state(loading, &vmstate_versioned, &obj, 1, NULL);
> >       g_assert(!qemu_file_get_error(loading));
> >       g_assert_cmpint(obj.a, ==, 10);
> >       g_assert_cmpint(obj.b, ==, 200);
> > @@ -391,7 +391,7 @@ static void test_load_v2(void)
> >       QEMUFile *loading = open_test_file(false);
> >       TestStruct obj;
> > -    vmstate_load_state(loading, &vmstate_versioned, &obj, 2);
> > +    vmstate_load_state(loading, &vmstate_versioned, &obj, 2, NULL);
> >       g_assert_cmpint(obj.a, ==, 10);
> >       g_assert_cmpint(obj.b, ==, 20);
> >       g_assert_cmpint(obj.c, ==, 30);
> > @@ -480,7 +480,7 @@ static void test_load_noskip(void)
> >       QEMUFile *loading = open_test_file(false);
> >       TestStruct obj = { .skip_c_e = false };
> > -    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
> > +    vmstate_load_state(loading, &vmstate_skipping, &obj, 2, NULL);
> >       g_assert(!qemu_file_get_error(loading));
> >       g_assert_cmpint(obj.a, ==, 10);
> >       g_assert_cmpint(obj.b, ==, 20);
> > @@ -504,7 +504,7 @@ static void test_load_skip(void)
> >       QEMUFile *loading = open_test_file(false);
> >       TestStruct obj = { .skip_c_e = true, .c = 300, .e = 500 };
> > -    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
> > +    vmstate_load_state(loading, &vmstate_skipping, &obj, 2, NULL);
> >       g_assert(!qemu_file_get_error(loading));
> >       g_assert_cmpint(obj.a, ==, 10);
> >       g_assert_cmpint(obj.b, ==, 20);
> > @@ -773,7 +773,7 @@ static void test_load_q(void)
> >       TestQtailq tgt;
> >       QTAILQ_INIT(&tgt.q);
> > -    vmstate_load_state(fload, &vmstate_q, &tgt, 1);
> > +    vmstate_load_state(fload, &vmstate_q, &tgt, 1, NULL);
> >       char eof = qemu_get_byte(fload);
> >       g_assert(!qemu_file_get_error(fload));
> >       g_assert_cmpint(tgt.i16, ==, obj_q.i16);
> > @@ -1127,7 +1127,7 @@ static void test_gtree_load_domain(void)
> >       fload = open_test_file(false);
> > -    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1);
> > +    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1, NULL);
> >       eof = qemu_get_byte(fload);
> >       g_assert(!qemu_file_get_error(fload));
> >       g_assert_cmpint(orig_domain->id, ==, dest_domain->id);
> > @@ -1241,7 +1241,7 @@ static void test_gtree_load_iommu(void)
> >       qemu_fclose(fsave);
> >       fload = open_test_file(false);
> > -    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1);
> > +    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1, NULL);
> >       eof = qemu_get_byte(fload);
> >       g_assert(!qemu_file_get_error(fload));
> >       g_assert_cmpint(orig_iommu->id, ==, dest_iommu->id);
> > @@ -1376,7 +1376,7 @@ static void test_load_qlist(void)
> >       qemu_fclose(fsave);
> >       fload = open_test_file(false);
> > -    vmstate_load_state(fload, &vmstate_container, dest_container, 1);
> > +    vmstate_load_state(fload, &vmstate_container, dest_container, 1, NULL);
> >       eof = qemu_get_byte(fload);
> >       g_assert(!qemu_file_get_error(fload));
> >       g_assert_cmpint(eof, ==, QEMU_VM_EOF);
> > diff --git a/ui/vdagent.c b/ui/vdagent.c
> > index c0746fe5b168fdc7aeb4866de2ba0c3387566649..83457dee0767433ad0778b37b41b9c673a0e1860 100644
> > --- a/ui/vdagent.c
> > +++ b/ui/vdagent.c
> > @@ -1008,7 +1008,7 @@ static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
> >       vdagent_clipboard_peer_register(vd);
> > -    ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0);
> > +    ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0, NULL);
> >       if (ret) {
> >           return ret;
> >       }
> > 
> 

Regards,
Arun


