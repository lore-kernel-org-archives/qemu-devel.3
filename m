Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310D3C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 08:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujZbw-0000A7-Dd; Wed, 06 Aug 2025 04:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujZWN-00056Z-D6
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujZWI-00006K-Fp
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754468948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AQvMjAUcTsZfsH13g7B0+PNadDFJmMg+DacEDeiZ7Fs=;
 b=NpFpoVTP07vUxmrj8/mgQa5qNYAcgyE+ElFB+B0FFAmMnAi86w+PuCyFwfHnCi0B7gda3s
 d1J4kjfA6W4wQ5lsU2c4gXSAehATPMgyT0qqVsuGy3h9/7GkyeWbSErVWiwL5E0AXSZ/lj
 UhXPeEOKo5/fJfC4hi9X+16LF3Csuns=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-Ko6Blo9ZNc2K3VeYpSyCmA-1; Wed, 06 Aug 2025 04:29:07 -0400
X-MC-Unique: Ko6Blo9ZNc2K3VeYpSyCmA-1
X-Mimecast-MFC-AGG-ID: Ko6Blo9ZNc2K3VeYpSyCmA_1754468946
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2425e41424cso49559105ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 01:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754468946; x=1755073746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AQvMjAUcTsZfsH13g7B0+PNadDFJmMg+DacEDeiZ7Fs=;
 b=J2WJFDzRu9vYH/ZSsGoF8o2E33zkMcJ1oDTTXOo33+1Xa/W/VykNVzmyXGqSQRMd5P
 NhVF3xnIY+bgd3lslUjtoXvl/SG7zjV/QrV/E6fXVhTbacY4yH5g+mFiDldXcOIm8jIM
 z7tokgNQgUKyIhGuJNH22Um4izUQDry3Nj4xx34B3otkZVZguzhGHR0qnDf6HsYzZSii
 CrT6j95tJHZwcBsvdSjKMEp3agpxPRWEnWSjzoOKWDDJwd8K6uJhQwUPvvqwxLMY7qyL
 kuI8HTu+I4aW3lsorUe/aYjuhhUxaXjQwbRZynZ4otUpRY7wMhbpiRQPjNsOhkQZt3qH
 tUsw==
X-Gm-Message-State: AOJu0YzbEgumJDKuB1jD56keggv+Ow5r4IK6X6O4x3fXZgP2JrQwggbV
 uc4qNsrfHaxbJp8XZCBeRrdimm7u7faVHBw51ljdcrFIMoA4f6Fcpxi/TDLZpcif8Cgl/yUQa12
 W7rTJGrk+7O1z6TkNxiHKY8dVWHT09383bele0uYA4n4r7gVpgM/8jJ2A47GyM18h5PmpsNksFf
 Uz1Y85L1+fvBbxvG3Di015dCFQ9TcCDLw=
X-Gm-Gg: ASbGnctzPW/xJdaKL1JLePIzp/PUbSy3Zd+ncMIZsin8ANf/y8Y9ZXgONj7HyhhJh0+
 BzFZcVLbJCAVbOjWTFDDN1MMHXxSIMbpAvY0sYev1hOO78jYMtZG+m0A1L8pyx3iHUnYIZTSYYU
 a6/xGqL2gCxVWYgvYhvZM7M4Wvy03tMrHRJ7F/eQKCMjPZgoIO878+6Q==
X-Received: by 2002:a17:903:40c9:b0:240:a54e:21a0 with SMTP id
 d9443c01a7336-2429eebaf1fmr28603805ad.19.1754468945870; 
 Wed, 06 Aug 2025 01:29:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs8LTz/+OAN/vxLp/1jpcUfFypcTz0Y+5jaHJHUq2OXzHoWBS8vi1Veu0e4QDdiu9XezwxaiOS9dE7JrvJus4=
X-Received: by 2002:a17:903:40c9:b0:240:a54e:21a0 with SMTP id
 d9443c01a7336-2429eebaf1fmr28603325ad.19.1754468945398; Wed, 06 Aug 2025
 01:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-25-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-25-123450810db7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 6 Aug 2025 12:28:54 +0400
X-Gm-Features: Ac12FXzRMBU59PdDQIJTOEX0HJU_V6N9Ot0IjtjwyUGhxKqOmZnLrbZqUroEC2U
Message-ID: <CAMxuvayZkKyaTwj0orFx3k73=R0uesW2g-kZWVBDyoAiubP0WQ@mail.gmail.com>
Subject: Re: [PATCH v9 25/27] migration: Remove error variant of
 vmstate_save_state() function
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000042a8b9063bae2220"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000042a8b9063bae2220
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Aug 5, 2025 at 10:31=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This commit removes the redundant vmstate_save_state_with_err()
> function.
>
> Previously, commit 969298f9d7 introduced vmstate_save_state_with_err()
> to handle error propagation, while vmstate_save_state() existed for
> non-error scenarios.
> This is because there were code paths where vmstate_save_state_v()
> (called internally by vmstate_save_state) did not explicitly set
> errors on failure.
>
> This change unifies error handling by
>  - updating vmstate_save_state() to accept an Error **errp argument.
>  - vmstate_save_state_v() ensures errors are set directly within the errp
>    object, eliminating the need for two separate functions. Specifically
>    errors are handled by storing them in errp in vmstate_save_dispatch()
>
> All calls to vmstate_save_state_with_err() are replaced with
> vmstate_save_state(). This simplifies the API and improves code
> maintainability.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
>

I realize that vmstate_save_state() callers progressively became silent on
error with this series (switching to error_report to error_set). I suggest
you make a preliminary patch to make vmstate_save_state() verbose by
passing &error_warn to vmstate_save_state_v. wdyt?

patch lgtm otherwise




> ---
>  hw/display/virtio-gpu.c     |  3 ++-
>  hw/pci/pci.c                |  2 +-
>  hw/s390x/virtio-ccw.c       |  2 +-
>  hw/scsi/spapr_vscsi.c       |  2 +-
>  hw/vfio/pci.c               |  4 ++--
>  hw/virtio/virtio-mmio.c     |  2 +-
>  hw/virtio/virtio-pci.c      |  2 +-
>  hw/virtio/virtio.c          |  4 ++--
>  include/migration/vmstate.h |  2 --
>  migration/cpr.c             |  5 +++--
>  migration/savevm.c          |  7 ++++---
>  migration/vmstate-types.c   | 12 +++++++-----
>  migration/vmstate.c         | 18 ++++++++----------
>  tests/unit/test-vmstate.c   |  8 +++++---
>  ui/vdagent.c                |  3 ++-
>  15 files changed, 40 insertions(+), 36 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index
> 5ff9f5e6dc0b6b112e36170318c900f893a73c5e..bddb26fa21312e5d0b2b6412cdf2a6c=
28dd06eb3
> 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1246,7 +1246,8 @@ static int virtio_gpu_save(QEMUFile *f, void
> *opaque, size_t size,
>      }
>      qemu_put_be32(f, 0); /* end of list */
>
> -    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
> +    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
> +                              &error_warn);
>  }
>
>  static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index
> 80545189980f176ca6a3dc9abce7043c8bc2708c..f7fb3931ff190c25ffa665ba80abe77=
37dbefdb6
> 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -926,7 +926,7 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
>       * This makes us compatible with old devices
>       * which never set or clear this bit. */
>      s->config[PCI_STATUS] &=3D ~PCI_STATUS_INTERRUPT;
> -    vmstate_save_state(f, &vmstate_pci_device, s, NULL);
> +    vmstate_save_state(f, &vmstate_pci_device, s, NULL, &error_warn);
>      /* Restore the interrupt status bit. */
>      pci_update_irq_status(s);
>  }
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index
> bafcb9b76d81749925e31b5a0a1320b3332ad2cf..14304fd3e8901d28a7788266df2c7ef=
7334b691c
> 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1130,7 +1130,7 @@ static int virtio_ccw_load_queue(DeviceState *d, in=
t
> n, QEMUFile *f)
>  static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
>  {
>      VirtioCcwDevice *dev =3D VIRTIO_CCW_DEVICE(d);
> -    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL);
> +    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL,
> &error_warn);
>  }
>
>  static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index
> a4812afd0cc7c495080ef03a531c7d279af29b33..2204beb40c7cdc827db2bf86fb8612d=
8c09999ed
> 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -630,7 +630,7 @@ static void vscsi_save_request(QEMUFile *f,
> SCSIRequest *sreq)
>      vscsi_req *req =3D sreq->hba_private;
>      assert(req->active);
>
> -    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL);
> +    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL,
> &error_warn);
>
>      trace_spapr_vscsi_save_request(req->qtag, req->cur_desc_num,
>                                     req->cur_desc_offset);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index
> 04d385d7674f444844beeee7364ee0424f762758..8e2b6d611de8efdf98235355226f5e5=
a6fd87b19
> 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2780,8 +2780,8 @@ static int vfio_pci_save_config(VFIODevice
> *vbasedev, QEMUFile *f, Error **errp)
>  {
>      VFIOPCIDevice *vdev =3D container_of(vbasedev, VFIOPCIDevice, vbased=
ev);
>
> -    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev=
,
> NULL,
> -                                       errp);
> +    return vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL,
> +                              errp);
>  }
>
>  static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index
> f14f0487fec3ed30d2cc3aec96950c2121265716..58957990743f061e78d0eafcfcb6cc5=
989252edc
> 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -613,7 +613,7 @@ static void virtio_mmio_save_extra_state(DeviceState
> *opaque, QEMUFile *f)
>  {
>      VirtIOMMIOProxy *proxy =3D VIRTIO_MMIO(opaque);
>
> -    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL);
> +    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL, &error_warn=
);
>  }
>
>  static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f=
)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index
> 07f144d6d1bfbb561b28015de71762601080dc23..0826399cdfbf09b5b3f9acd9967de34=
17858c9d2
> 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -154,7 +154,7 @@ static void virtio_pci_save_extra_state(DeviceState
> *d, QEMUFile *f)
>  {
>      VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);
>
> -    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL);
> +    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL, &error_warn)=
;
>  }
>
>  static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index
> aac317a93c3cd55ece9b0fd858c7b2459f8242f9..552e167529e9c22fb4cba2b445ffad8=
5fef619f3
> 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3025,14 +3025,14 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>      }
>
>      if (vdc->vmsd) {
> -        int ret =3D vmstate_save_state(f, vdc->vmsd, vdev, NULL);
> +        int ret =3D vmstate_save_state(f, vdc->vmsd, vdev, NULL,
> &error_warn);
>          if (ret) {
>              return ret;
>          }
>      }
>
>      /* Subsections */
> -    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
> +    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL,
> &error_warn);
>  }
>
>  /* A wrapper for use as a VMState .put function */
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index
> 056781b1c21e737583f081594d9f88b32adfd674..5fe9bbf39058d0cf97c1adab54cc516=
dbe8dc32a
> 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1198,8 +1198,6 @@ extern const VMStateInfo vmstate_info_qlist;
>  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>                         void *opaque, int version_id, Error **errp);
>  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> -                       void *opaque, JSONWriter *vmdesc);
> -int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription
> *vmsd,
>                         void *opaque, JSONWriter *vmdesc, Error **errp);
>  int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                           void *opaque, JSONWriter *vmdesc,
> diff --git a/migration/cpr.c b/migration/cpr.c
> index
> bdb24736f44e91ba59b6e622a315597c97e7f64d..d48f013dac21b531e41a26f4bb33eef=
e32097757
> 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -163,6 +163,7 @@ bool cpr_is_incoming(void)
>
>  int cpr_state_save(MigrationChannel *channel, Error **errp)
>  {
> +    ERRP_GUARD();
>      int ret;
>      QEMUFile *f;
>      MigMode mode =3D migrate_mode();
> @@ -182,9 +183,9 @@ int cpr_state_save(MigrationChannel *channel, Error
> **errp)
>      qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
>      qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
>
> -    ret =3D vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0);
> +    ret =3D vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0, err=
p);
>      if (ret) {
> -        error_setg(errp, "vmstate_save_state error %d", ret);
> +        error_prepend(errp, "vmstate_save_state error %d: ", ret);
>          qemu_fclose(f);
>          return ret;
>      }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> 4df50fb5c674e56c0173c357c1e23367373e2114..3cb9c34efb22fdcb2b05cf1fefcb6fb=
d80cadca5
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1056,8 +1056,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry
> *se, JSONWriter *vmdesc,
>      if (!se->vmsd) {
>          vmstate_save_old_style(f, se, vmdesc);
>      } else {
> -        ret =3D vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmd=
esc,
> -                                          errp);
> +        ret =3D vmstate_save_state(f, se->vmsd, se->opaque, vmdesc,
> +                                 errp);
>          if (ret) {
>              return ret;
>          }
> @@ -1303,7 +1303,8 @@ void qemu_savevm_state_header(QEMUFile *f)
>              json_writer_start_object(vmdesc, "configuration");
>          }
>
> -        vmstate_save_state(f, &vmstate_configuration, &savevm_state,
> vmdesc);
> +        vmstate_save_state(f, &vmstate_configuration, &savevm_state,
> vmdesc,
> +                           &error_warn);
>
>          if (vmdesc) {
>              json_writer_end_object(vmdesc);
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index
> e2020a733d0921d748b6f832a193e5de8d302d5f..2b88dc145ab32072f09845cee95b79a=
ad7ac3cb2
> 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -564,7 +564,7 @@ static int put_tmp(QEMUFile *f, void *pv, size_t size=
,
>
>      /* Writes the parent field which is at the start of the tmp */
>      *(void **)tmp =3D pv;
> -    ret =3D vmstate_save_state(f, vmsd, tmp, vmdesc);
> +    ret =3D vmstate_save_state(f, vmsd, tmp, vmdesc, &error_warn);
>      g_free(tmp);
>
>      return ret;
> @@ -675,7 +675,7 @@ static int put_qtailq(QEMUFile *f, void *pv, size_t
> unused_size,
>
>      QTAILQ_RAW_FOREACH(elm, pv, entry_offset) {
>          qemu_put_byte(f, true);
> -        ret =3D vmstate_save_state(f, vmsd, elm, vmdesc);
> +        ret =3D vmstate_save_state(f, vmsd, elm, vmdesc, &error_warn);
>          if (ret) {
>              return ret;
>          }
> @@ -712,7 +712,8 @@ static gboolean put_gtree_elem(gpointer key, gpointer
> value, gpointer data)
>      if (!capsule->key_vmsd) {
>          qemu_put_be64(f, (uint64_t)(uintptr_t)(key)); /* direct key */
>      } else {
> -        ret =3D vmstate_save_state(f, capsule->key_vmsd, key,
> capsule->vmdesc);
> +        ret =3D vmstate_save_state(f, capsule->key_vmsd, key,
> capsule->vmdesc,
> +                                 &error_warn);
>          if (ret) {
>              capsule->ret =3D ret;
>              return true;
> @@ -720,7 +721,8 @@ static gboolean put_gtree_elem(gpointer key, gpointer
> value, gpointer data)
>      }
>
>      /* put the data */
> -    ret =3D vmstate_save_state(f, capsule->val_vmsd, value,
> capsule->vmdesc);
> +    ret =3D vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmd=
esc,
> +                             &error_warn);
>      if (ret) {
>          capsule->ret =3D ret;
>          return true;
> @@ -856,7 +858,7 @@ static int put_qlist(QEMUFile *f, void *pv, size_t
> unused_size,
>      trace_put_qlist(field->name, vmsd->name, vmsd->version_id);
>      QLIST_RAW_FOREACH(elm, pv, entry_offset) {
>          qemu_put_byte(f, true);
> -        ret =3D vmstate_save_state(f, vmsd, elm, vmdesc);
> +        ret =3D vmstate_save_state(f, vmsd, elm, vmdesc, &error_warn);
>          if (ret) {
>              error_report("%s: failed to save %s (%d)", field->name,
>                           vmsd->name, ret);
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index
> ef78a1e62ad92e9608de72d125da80ea496c8dd1..569e66ea983f833e6a0d651d2a751f3=
4a64e8f5c
> 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -403,12 +403,6 @@ bool vmstate_section_needed(const VMStateDescription
> *vmsd, void *opaque)
>
>
>  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> -                       void *opaque, JSONWriter *vmdesc_id)
> -{
> -    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id,
> vmsd->version_id, NULL);
> -}
> -
> -int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription
> *vmsd,
>                         void *opaque, JSONWriter *vmdesc_id, Error **errp=
)
>  {
>      return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id,
> vmsd->version_id, errp);
> @@ -530,7 +524,7 @@ static int vmstate_save_dispatch(QEMUFile *f,
>
>                  if (inner_field->flags & VMS_STRUCT) {
>                      ret =3D vmstate_save_state(f, inner_field->vmsd,
> -                                             curr_elem, vmdesc_loop);
> +                                             curr_elem, vmdesc_loop,
> errp);
>                  } else if (inner_field->flags & VMS_VSTRUCT) {
>                      ret =3D vmstate_save_state_v(f, inner_field->vmsd,
>                                                 curr_elem, vmdesc_loop,
> @@ -539,6 +533,10 @@ static int vmstate_save_dispatch(QEMUFile *f,
>                  } else {
>                      ret =3D inner_field->info->put(f, curr_elem, size,
>                                                   inner_field,
> vmdesc_loop);
> +                    if (ret) {
> +                        error_setg(errp, "Save of field %s failed",
> +                                   inner_field->name);
> +                    }
>                  }
>
>                  written_bytes =3D qemu_file_transferred(f) - old_offset;
> @@ -551,8 +549,8 @@ static int vmstate_save_dispatch(QEMUFile *f,
>                  }
>
>                  if (ret) {
> -                    error_setg(errp, "Save of field %s/%s failed",
> -                                vmsd->name, field->name);
> +                    error_prepend(errp, "Save of field %s/%s failed: ",
> +                                  vmsd->name, field->name);
>                      ps_ret =3D post_save_dispatch(vmsd, opaque, &local_e=
rr);
>                      if (ps_ret) {
>                          ret =3D ps_ret;
> @@ -723,7 +721,7 @@ static int vmstate_subsection_save(QEMUFile *f, const
> VMStateDescription *vmsd,
>              qemu_put_byte(f, len);
>              qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
>              qemu_put_be32(f, vmsdsub->version_id);
> -            ret =3D vmstate_save_state_with_err(f, vmsdsub, opaque, vmde=
sc,
> errp);
> +            ret =3D vmstate_save_state(f, vmsdsub, opaque, vmdesc, errp)=
;
>              if (ret) {
>                  return ret;
>              }
> diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
> index
> 807deb3531f3079864ac99567d4dece7122571dd..5f31ed4b6969c4ebf72b298f965bcbd=
c752ff87f
> 100644
> --- a/tests/unit/test-vmstate.c
> +++ b/tests/unit/test-vmstate.c
> @@ -69,7 +69,7 @@ static void save_vmstate(const VMStateDescription *desc=
,
> void *obj)
>      QEMUFile *f =3D open_test_file(true);
>
>      /* Save file with vmstate */
> -    int ret =3D vmstate_save_state(f, desc, obj, NULL);
> +    int ret =3D vmstate_save_state(f, desc, obj, NULL, &error_warn);
>      g_assert(!ret);
>      qemu_put_byte(f, QEMU_VM_EOF);
>      g_assert(!qemu_file_get_error(f));
> @@ -429,7 +429,8 @@ static void test_save_noskip(void)
>      QEMUFile *fsave =3D open_test_file(true);
>      TestStruct obj =3D { .a =3D 1, .b =3D 2, .c =3D 3, .d =3D 4, .e =3D =
5, .f =3D 6,
>                         .skip_c_e =3D false };
> -    int ret =3D vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL)=
;
> +    int ret =3D vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL,
> +                                 &error_warn);
>      g_assert(!ret);
>      g_assert(!qemu_file_get_error(fsave));
>
> @@ -451,7 +452,8 @@ static void test_save_skip(void)
>      QEMUFile *fsave =3D open_test_file(true);
>      TestStruct obj =3D { .a =3D 1, .b =3D 2, .c =3D 3, .d =3D 4, .e =3D =
5, .f =3D 6,
>                         .skip_c_e =3D true };
> -    int ret =3D vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL)=
;
> +    int ret =3D vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL,
> +                                 &error_warn);
>      g_assert(!ret);
>      g_assert(!qemu_file_get_error(fsave));
>
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index
> b9a22a689d9acfeafb862ae73308db6fbd52331e..e0fc7ff71468bfe66761385387653c7=
42c375f05
> 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -992,7 +992,8 @@ static int put_cbinfo(QEMUFile *f, void *pv, size_t
> size,
>          }
>      }
>
> -    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmdesc)=
;
> +    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmdesc,
> +                              &error_warn);
>  }
>
>  static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
>
> --
> 2.50.1
>
>

--00000000000042a8b9063bae2220
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 5, 20=
25 at 10:31=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com"=
>armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">This commit removes the redundant vmstate_save_state_wit=
h_err()<br>
function.<br>
<br>
Previously, commit 969298f9d7 introduced vmstate_save_state_with_err()<br>
to handle error propagation, while vmstate_save_state() existed for<br>
non-error scenarios.<br>
This is because there were code paths where vmstate_save_state_v()<br>
(called internally by vmstate_save_state) did not explicitly set<br>
errors on failure.<br>
<br>
This change unifies error handling by<br>
=C2=A0- updating vmstate_save_state() to accept an Error **errp argument.<b=
r>
=C2=A0- vmstate_save_state_v() ensures errors are set directly within the e=
rrp<br>
=C2=A0 =C2=A0object, eliminating the need for two separate functions. Speci=
fically<br>
=C2=A0 =C2=A0errors are handled by storing them in errp in vmstate_save_dis=
patch()<br>
<br>
All calls to vmstate_save_state_with_err() are replaced with<br>
vmstate_save_state(). This simplifies the API and improves code<br>
maintainability.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
I realize that=C2=A0vmstate_save_state() callers progressively became silen=
t on error with this series (switching to error_report to error_set). I sug=
gest you make a preliminary patch to make=C2=A0vmstate_save_state() verbose=
 by passing &amp;error_warn to=C2=A0vmstate_save_state_v. wdyt?</div><div><=
br></div><div>patch lgtm otherwise</div><div><br></div><div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
=C2=A0hw/pci/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 +-<br>
=C2=A0hw/s390x/virtio-ccw.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/scsi/spapr_vscsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/vfio/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 4 ++--<br>
=C2=A0hw/virtio/virtio-mmio.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/virtio/virtio-pci.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<b=
r>
=C2=A0include/migration/vmstate.h |=C2=A0 2 --<br>
=C2=A0migration/cpr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 5 +++--<br>
=C2=A0migration/savevm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 ++++--=
-<br>
=C2=A0migration/vmstate-types.c=C2=A0 =C2=A0| 12 +++++++-----<br>
=C2=A0migration/vmstate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 ++++++++---=
-------<br>
=C2=A0tests/unit/test-vmstate.c=C2=A0 =C2=A0|=C2=A0 8 +++++---<br>
=C2=A0ui/vdagent.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 3 ++-<br>
=C2=A015 files changed, 40 insertions(+), 36 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
index 5ff9f5e6dc0b6b112e36170318c900f893a73c5e..bddb26fa21312e5d0b2b6412cdf=
2a6c28dd06eb3 100644<br>
--- a/hw/display/virtio-gpu.c<br>
+++ b/hw/display/virtio-gpu.c<br>
@@ -1246,7 +1246,8 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque,=
 size_t size,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0qemu_put_be32(f, 0); /* end of list */<br>
<br>
-=C2=A0 =C2=A0 return vmstate_save_state(f, &amp;vmstate_virtio_gpu_scanout=
s, g, NULL);<br>
+=C2=A0 =C2=A0 return vmstate_save_state(f, &amp;vmstate_virtio_gpu_scanout=
s, g, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_warn);<br>
=C2=A0}<br>
<br>
=C2=A0static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,<br>
diff --git a/hw/pci/pci.c b/hw/pci/pci.c<br>
index 80545189980f176ca6a3dc9abce7043c8bc2708c..f7fb3931ff190c25ffa665ba80a=
be7737dbefdb6 100644<br>
--- a/hw/pci/pci.c<br>
+++ b/hw/pci/pci.c<br>
@@ -926,7 +926,7 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)<br>
=C2=A0 =C2=A0 =C2=A0 * This makes us compatible with old devices<br>
=C2=A0 =C2=A0 =C2=A0 * which never set or clear this bit. */<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;config[PCI_STATUS] &amp;=3D ~PCI_STATUS_INTERRUPT=
;<br>
-=C2=A0 =C2=A0 vmstate_save_state(f, &amp;vmstate_pci_device, s, NULL);<br>
+=C2=A0 =C2=A0 vmstate_save_state(f, &amp;vmstate_pci_device, s, NULL, &amp=
;error_warn);<br>
=C2=A0 =C2=A0 =C2=A0/* Restore the interrupt status bit. */<br>
=C2=A0 =C2=A0 =C2=A0pci_update_irq_status(s);<br>
=C2=A0}<br>
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c<br>
index bafcb9b76d81749925e31b5a0a1320b3332ad2cf..14304fd3e8901d28a7788266df2=
c7ef7334b691c 100644<br>
--- a/hw/s390x/virtio-ccw.c<br>
+++ b/hw/s390x/virtio-ccw.c<br>
@@ -1130,7 +1130,7 @@ static int virtio_ccw_load_queue(DeviceState *d, int =
n, QEMUFile *f)<br>
=C2=A0static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtioCcwDevice *dev =3D VIRTIO_CCW_DEVICE(d);<br>
-=C2=A0 =C2=A0 vmstate_save_state(f, &amp;vmstate_virtio_ccw_dev, dev, NULL=
);<br>
+=C2=A0 =C2=A0 vmstate_save_state(f, &amp;vmstate_virtio_ccw_dev, dev, NULL=
, &amp;error_warn);<br>
=C2=A0}<br>
<br>
=C2=A0static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)<br>
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c<br>
index a4812afd0cc7c495080ef03a531c7d279af29b33..2204beb40c7cdc827db2bf86fb8=
612d8c09999ed 100644<br>
--- a/hw/scsi/spapr_vscsi.c<br>
+++ b/hw/scsi/spapr_vscsi.c<br>
@@ -630,7 +630,7 @@ static void vscsi_save_request(QEMUFile *f, SCSIRequest=
 *sreq)<br>
=C2=A0 =C2=A0 =C2=A0vscsi_req *req =3D sreq-&gt;hba_private;<br>
=C2=A0 =C2=A0 =C2=A0assert(req-&gt;active);<br>
<br>
-=C2=A0 =C2=A0 vmstate_save_state(f, &amp;vmstate_spapr_vscsi_req, req, NUL=
L);<br>
+=C2=A0 =C2=A0 vmstate_save_state(f, &amp;vmstate_spapr_vscsi_req, req, NUL=
L, &amp;error_warn);<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_spapr_vscsi_save_request(req-&gt;qtag, req-&gt;cu=
r_desc_num,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;cur_desc_offse=
t);<br>
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c<br>
index 04d385d7674f444844beeee7364ee0424f762758..8e2b6d611de8efdf98235355226=
f5e5a6fd87b19 100644<br>
--- a/hw/vfio/pci.c<br>
+++ b/hw/vfio/pci.c<br>
@@ -2780,8 +2780,8 @@ static int vfio_pci_save_config(VFIODevice *vbasedev,=
 QEMUFile *f, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VFIOPCIDevice *vdev =3D container_of(vbasedev, VFIOPCID=
evice, vbasedev);<br>
<br>
-=C2=A0 =C2=A0 return vmstate_save_state_with_err(f, &amp;vmstate_vfio_pci_=
config, vdev, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errp);<br=
>
+=C2=A0 =C2=A0 return vmstate_save_state(f, &amp;vmstate_vfio_pci_config, v=
dev, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errp);<br>
=C2=A0}<br>
<br>
=C2=A0static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)<br=
>
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c<br>
index f14f0487fec3ed30d2cc3aec96950c2121265716..58957990743f061e78d0eafcfcb=
6cc5989252edc 100644<br>
--- a/hw/virtio/virtio-mmio.c<br>
+++ b/hw/virtio/virtio-mmio.c<br>
@@ -613,7 +613,7 @@ static void virtio_mmio_save_extra_state(DeviceState *o=
paque, QEMUFile *f)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtIOMMIOProxy *proxy =3D VIRTIO_MMIO(opaque);<br>
<br>
-=C2=A0 =C2=A0 vmstate_save_state(f, &amp;vmstate_virtio_mmio, proxy, NULL)=
;<br>
+=C2=A0 =C2=A0 vmstate_save_state(f, &amp;vmstate_virtio_mmio, proxy, NULL,=
 &amp;error_warn);<br>
=C2=A0}<br>
<br>
=C2=A0static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile=
 *f)<br>
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c<br>
index 07f144d6d1bfbb561b28015de71762601080dc23..0826399cdfbf09b5b3f9acd9967=
de3417858c9d2 100644<br>
--- a/hw/virtio/virtio-pci.c<br>
+++ b/hw/virtio/virtio-pci.c<br>
@@ -154,7 +154,7 @@ static void virtio_pci_save_extra_state(DeviceState *d,=
 QEMUFile *f)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);<br>
<br>
-=C2=A0 =C2=A0 vmstate_save_state(f, &amp;vmstate_virtio_pci, proxy, NULL);=
<br>
+=C2=A0 =C2=A0 vmstate_save_state(f, &amp;vmstate_virtio_pci, proxy, NULL, =
&amp;error_warn);<br>
=C2=A0}<br>
<br>
=C2=A0static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)<b=
r>
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
index aac317a93c3cd55ece9b0fd858c7b2459f8242f9..552e167529e9c22fb4cba2b445f=
fad85fef619f3 100644<br>
--- a/hw/virtio/virtio.c<br>
+++ b/hw/virtio/virtio.c<br>
@@ -3025,14 +3025,14 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)<br=
>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (vdc-&gt;vmsd) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret =3D vmstate_save_state(f, vdc-&gt;vmsd=
, vdev, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret =3D vmstate_save_state(f, vdc-&gt;vmsd=
, vdev, NULL, &amp;error_warn);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Subsections */<br>
-=C2=A0 =C2=A0 return vmstate_save_state(f, &amp;vmstate_virtio, vdev, NULL=
);<br>
+=C2=A0 =C2=A0 return vmstate_save_state(f, &amp;vmstate_virtio, vdev, NULL=
, &amp;error_warn);<br>
=C2=A0}<br>
<br>
=C2=A0/* A wrapper for use as a VMState .put function */<br>
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h<br>
index 056781b1c21e737583f081594d9f88b32adfd674..5fe9bbf39058d0cf97c1adab54c=
c516dbe8dc32a 100644<br>
--- a/include/migration/vmstate.h<br>
+++ b/include/migration/vmstate.h<br>
@@ -1198,8 +1198,6 @@ extern const VMStateInfo vmstate_info_qlist;<br>
=C2=A0int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 void *opaque, int version_id, Error **errp);<br>
=C2=A0int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0void *opaque, JSONWriter *vmdesc);<br>
-int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vms=
d,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 void *opaque, JSONWriter *vmdesc, Error **errp);<br>
=C2=A0int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 void *opaque, JSONWriter *vmdesc,<br>
diff --git a/migration/cpr.c b/migration/cpr.c<br>
index bdb24736f44e91ba59b6e622a315597c97e7f64d..d48f013dac21b531e41a26f4bb3=
3eefe32097757 100644<br>
--- a/migration/cpr.c<br>
+++ b/migration/cpr.c<br>
@@ -163,6 +163,7 @@ bool cpr_is_incoming(void)<br>
<br>
=C2=A0int cpr_state_save(MigrationChannel *channel, Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0QEMUFile *f;<br>
=C2=A0 =C2=A0 =C2=A0MigMode mode =3D migrate_mode();<br>
@@ -182,9 +183,9 @@ int cpr_state_save(MigrationChannel *channel, Error **e=
rrp)<br>
=C2=A0 =C2=A0 =C2=A0qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);<br>
=C2=A0 =C2=A0 =C2=A0qemu_put_be32(f, QEMU_CPR_FILE_VERSION);<br>
<br>
-=C2=A0 =C2=A0 ret =3D vmstate_save_state(f, &amp;vmstate_cpr_state, &amp;c=
pr_state, 0);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_save_state(f, &amp;vmstate_cpr_state, &amp;c=
pr_state, 0, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;vmstate_save_state erro=
r %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;vmstate_save_state e=
rror %d: &quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fclose(f);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index 4df50fb5c674e56c0173c357c1e23367373e2114..3cb9c34efb22fdcb2b05cf1fefc=
b6fbd80cadca5 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -1056,8 +1056,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *=
se, JSONWriter *vmdesc,<br>
=C2=A0 =C2=A0 =C2=A0if (!se-&gt;vmsd) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmstate_save_old_style(f, se, vmdesc);<br=
>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_save_state_with_err(f, se-&gt;=
vmsd, se-&gt;opaque, vmdesc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e=
rrp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_save_state(f, se-&gt;vmsd, se-=
&gt;opaque, vmdesc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -1303,7 +1303,8 @@ void qemu_savevm_state_header(QEMUFile *f)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0json_writer_start_object(vm=
desc, &quot;configuration&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vmstate_save_state(f, &amp;vmstate_configurati=
on, &amp;savevm_state, vmdesc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vmstate_save_state(f, &amp;vmstate_configurati=
on, &amp;savevm_state, vmdesc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_warn);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vmdesc) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0json_writer_end_object(vmde=
sc);<br>
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c<br>
index e2020a733d0921d748b6f832a193e5de8d302d5f..2b88dc145ab32072f09845cee95=
b79aad7ac3cb2 100644<br>
--- a/migration/vmstate-types.c<br>
+++ b/migration/vmstate-types.c<br>
@@ -564,7 +564,7 @@ static int put_tmp(QEMUFile *f, void *pv, size_t size,<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Writes the parent field which is at the start of the=
 tmp */<br>
=C2=A0 =C2=A0 =C2=A0*(void **)tmp =3D pv;<br>
-=C2=A0 =C2=A0 ret =3D vmstate_save_state(f, vmsd, tmp, vmdesc);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_save_state(f, vmsd, tmp, vmdesc, &amp;error_=
warn);<br>
=C2=A0 =C2=A0 =C2=A0g_free(tmp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
@@ -675,7 +675,7 @@ static int put_qtailq(QEMUFile *f, void *pv, size_t unu=
sed_size,<br>
<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_RAW_FOREACH(elm, pv, entry_offset) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_put_byte(f, true);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_save_state(f, vmsd, elm, vmdes=
c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_save_state(f, vmsd, elm, vmdes=
c, &amp;error_warn);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -712,7 +712,8 @@ static gboolean put_gtree_elem(gpointer key, gpointer v=
alue, gpointer data)<br>
=C2=A0 =C2=A0 =C2=A0if (!capsule-&gt;key_vmsd) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_put_be64(f, (uint64_t)(uintptr_t)(ke=
y)); /* direct key */<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_save_state(f, capsule-&gt;key_=
vmsd, key, capsule-&gt;vmdesc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_save_state(f, capsule-&gt;key_=
vmsd, key, capsule-&gt;vmdesc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_warn);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capsule-&gt;ret =3D ret;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
@@ -720,7 +721,8 @@ static gboolean put_gtree_elem(gpointer key, gpointer v=
alue, gpointer data)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* put the data */<br>
-=C2=A0 =C2=A0 ret =3D vmstate_save_state(f, capsule-&gt;val_vmsd, value, c=
apsule-&gt;vmdesc);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_save_state(f, capsule-&gt;val_vmsd, value, c=
apsule-&gt;vmdesc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_warn);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capsule-&gt;ret =3D ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
@@ -856,7 +858,7 @@ static int put_qlist(QEMUFile *f, void *pv, size_t unus=
ed_size,<br>
=C2=A0 =C2=A0 =C2=A0trace_put_qlist(field-&gt;name, vmsd-&gt;name, vmsd-&gt=
;version_id);<br>
=C2=A0 =C2=A0 =C2=A0QLIST_RAW_FOREACH(elm, pv, entry_offset) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_put_byte(f, true);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_save_state(f, vmsd, elm, vmdes=
c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_save_state(f, vmsd, elm, vmdes=
c, &amp;error_warn);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;%s: fail=
ed to save %s (%d)&quot;, field-&gt;name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 vmsd-&gt;name, ret);<br>
diff --git a/migration/vmstate.c b/migration/vmstate.c<br>
index ef78a1e62ad92e9608de72d125da80ea496c8dd1..569e66ea983f833e6a0d651d2a7=
51f34a64e8f5c 100644<br>
--- a/migration/vmstate.c<br>
+++ b/migration/vmstate.c<br>
@@ -403,12 +403,6 @@ bool vmstate_section_needed(const VMStateDescription *=
vmsd, void *opaque)<br>
<br>
<br>
=C2=A0int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0void *opaque, JSONWriter *vmdesc_id)<br>
-{<br>
-=C2=A0 =C2=A0 return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd=
-&gt;version_id, NULL);<br>
-}<br>
-<br>
-int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vms=
d,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 void *opaque, JSONWriter *vmdesc_id, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id,=
 vmsd-&gt;version_id, errp);<br>
@@ -530,7 +524,7 @@ static int vmstate_save_dispatch(QEMUFile *f,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (inner_fie=
ld-&gt;flags &amp; VMS_STRUCT) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ret =3D vmstate_save_state(f, inner_field-&gt;vmsd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0curr_elem, vmdesc_loop);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0curr_elem, vmdesc_loop, errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (in=
ner_field-&gt;flags &amp; VMS_VSTRUCT) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ret =3D vmstate_save_state_v(f, inner_field-&gt;vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 curr_elem, vmdesc_loop,<br>
@@ -539,6 +533,10 @@ static int vmstate_save_dispatch(QEMUFile *f,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ret =3D inner_field-&gt;info-&gt;put(f, curr_elem, size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 inner_field, vmdesc_loop);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 error_setg(errp, &quot;Save of field %s failed&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inner_field-&gt;name);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0written_bytes=
 =3D qemu_file_transferred(f) - old_offset;<br>
@@ -551,8 +549,8 @@ static int vmstate_save_dispatch(QEMUFile *f,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_setg(errp, &quot;Save of field %s/%s failed&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmsd-&gt;name, field-&gt;name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_prepend(errp, &quot;Save of field %s/%s failed: &quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmsd-&gt;name, field-&gt;name=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ps_ret =3D post_save_dispatch(vmsd, opaque, &amp;local_err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (ps_ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ret =3D ps_ret;<br>
@@ -723,7 +721,7 @@ static int vmstate_subsection_save(QEMUFile *f, const V=
MStateDescription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_put_byte(f, len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_put_buffer(f, (uint8_t=
 *)vmsdsub-&gt;name, len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_put_be32(f, vmsdsub-&g=
t;version_id);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_save_state_with_=
err(f, vmsdsub, opaque, vmdesc, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_save_state(f, vm=
sdsub, opaque, vmdesc, errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c<br>
index 807deb3531f3079864ac99567d4dece7122571dd..5f31ed4b6969c4ebf72b298f965=
bcbdc752ff87f 100644<br>
--- a/tests/unit/test-vmstate.c<br>
+++ b/tests/unit/test-vmstate.c<br>
@@ -69,7 +69,7 @@ static void save_vmstate(const VMStateDescription *desc, =
void *obj)<br>
=C2=A0 =C2=A0 =C2=A0QEMUFile *f =3D open_test_file(true);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Save file with vmstate */<br>
-=C2=A0 =C2=A0 int ret =3D vmstate_save_state(f, desc, obj, NULL);<br>
+=C2=A0 =C2=A0 int ret =3D vmstate_save_state(f, desc, obj, NULL, &amp;erro=
r_warn);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!ret);<br>
=C2=A0 =C2=A0 =C2=A0qemu_put_byte(f, QEMU_VM_EOF);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!qemu_file_get_error(f));<br>
@@ -429,7 +429,8 @@ static void test_save_noskip(void)<br>
=C2=A0 =C2=A0 =C2=A0QEMUFile *fsave =3D open_test_file(true);<br>
=C2=A0 =C2=A0 =C2=A0TestStruct obj =3D { .a =3D 1, .b =3D 2, .c =3D 3, .d =
=3D 4, .e =3D 5, .f =3D 6,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 .skip_c_e =3D false };<br>
-=C2=A0 =C2=A0 int ret =3D vmstate_save_state(fsave, &amp;vmstate_skipping,=
 &amp;obj, NULL);<br>
+=C2=A0 =C2=A0 int ret =3D vmstate_save_state(fsave, &amp;vmstate_skipping,=
 &amp;obj, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_warn);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!ret);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!qemu_file_get_error(fsave));<br>
<br>
@@ -451,7 +452,8 @@ static void test_save_skip(void)<br>
=C2=A0 =C2=A0 =C2=A0QEMUFile *fsave =3D open_test_file(true);<br>
=C2=A0 =C2=A0 =C2=A0TestStruct obj =3D { .a =3D 1, .b =3D 2, .c =3D 3, .d =
=3D 4, .e =3D 5, .f =3D 6,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 .skip_c_e =3D true };<br>
-=C2=A0 =C2=A0 int ret =3D vmstate_save_state(fsave, &amp;vmstate_skipping,=
 &amp;obj, NULL);<br>
+=C2=A0 =C2=A0 int ret =3D vmstate_save_state(fsave, &amp;vmstate_skipping,=
 &amp;obj, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_warn);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!ret);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!qemu_file_get_error(fsave));<br>
<br>
diff --git a/ui/vdagent.c b/ui/vdagent.c<br>
index b9a22a689d9acfeafb862ae73308db6fbd52331e..e0fc7ff71468bfe667613853876=
53c742c375f05 100644<br>
--- a/ui/vdagent.c<br>
+++ b/ui/vdagent.c<br>
@@ -992,7 +992,8 @@ static int put_cbinfo(QEMUFile *f, void *pv, size_t siz=
e,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 return vmstate_save_state(f, &amp;vmstate_cbinfo_array, &amp=
;cbinfo, vmdesc);<br>
+=C2=A0 =C2=A0 return vmstate_save_state(f, &amp;vmstate_cbinfo_array, &amp=
;cbinfo, vmdesc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_warn);<br>
=C2=A0}<br>
<br>
=C2=A0static int get_cbinfo(QEMUFile *f, void *pv, size_t size,<br>
<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div></div>

--00000000000042a8b9063bae2220--


