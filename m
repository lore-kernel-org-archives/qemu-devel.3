Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F01C87FCF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufIo7-0006bx-OA; Fri, 25 Jul 2025 09:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ufImv-0005ry-Mp
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:48:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ufIms-0004mK-0T
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753451315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MaY4YWkc/M68iX1dA2gcT9p4ah9wLgrTTSikzI7QX0U=;
 b=VhgoQMN329RQaueM0HM4875tLqh3HzA25sou9nhgfGF8CuRjOf+cluX8slQtod4JhdUL6N
 oqD5yzPv5HsXgKv7UtYhxikyKOgyKKLgtT/7Jkn0q5kb+thOAjod8j/+3E2TlXN5OOd9rY
 ui7OwnDWLjFF5PE7iNioyYgHDzqXX0w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-QJdbogDxOBu5z2YOnjw1wg-1; Fri, 25 Jul 2025 09:48:28 -0400
X-MC-Unique: QJdbogDxOBu5z2YOnjw1wg-1
X-Mimecast-MFC-AGG-ID: QJdbogDxOBu5z2YOnjw1wg_1753451307
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3132e7266d3so2264757a91.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 06:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753451307; x=1754056107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MaY4YWkc/M68iX1dA2gcT9p4ah9wLgrTTSikzI7QX0U=;
 b=wrk0NkqWqdqj/LtQhWvJl0RZpf8CPxT6UugM4oVIUaK7gsL2AjwCCUvS79vmR3BLPF
 LOg5sAKOQNywAiAdv+uFuHHEfQlH+MhpO2bDi+KGg8M07OZeUpdne0/BJh+c2PF6LOHt
 L6zAj86hlEhmRULrK3iYCWW/H21/dXElh6feK9JUhH7VhjuKlerAmyWn5VtdSIM/MapM
 1RhwgXo0NS72UR0b9M4rw/xDe0ZFIi0KlK0Qaw06WbLJrdTKHiF9oYVn1a+EBEXqSuzW
 KK4uAzhyVU2nDvwgIFmaTSJidK86u6Qt4yjX1MIUMjF26jCdBQqmw/X0gJszlT7Tg4O+
 7MrQ==
X-Gm-Message-State: AOJu0Yz2ddhIStldLu5uzfxxgjiBFYvQnVFDHvIuTIkfnn/KqrWlTYL3
 NEt25YUqfqZWVe/kG6LGvCs+qL6OBcufY2syx1wdZTASPiB61gF+sRXGcDfKt0Pev414U8L8u2e
 4cfuP3fFVVYsW2Z4Lmi6IgGxjZsivCP5qBptr+RaQrxU+fHDnre0VfOxPju3XUn9fW32hLhUHOy
 JoFXbULN9VwBc8HyURIhbF2AKCYvswJr0=
X-Gm-Gg: ASbGnctsMExii+Fu9VrQ4FHZe24Oh+wqHaLBIXh0iS/pay6v6Z40tkLuCbTijA83+s3
 Ulg1Oz5GjjlEsfncGzUMv/aKhmemvWRdiYvHpXsqSd+39FTtc9EVLOM2IHmwbg8SyBHSiR1eqbi
 BjkwC8BkR6oabU3VkrlzAlTy4A+Lb2FCHAfkr0pOoIld6nrpTu+68pMA==
X-Received: by 2002:a17:90b:1a84:b0:31c:3872:9411 with SMTP id
 98e67ed59e1d1-31e77a2016bmr3410938a91.33.1753451306880; 
 Fri, 25 Jul 2025 06:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuA3sUVsMdGADDZjR1LCV3jgcQ20yjYNber1Ntd+oGjXUHSbu1X1YEPAsQ34UzLzqcyTFFSAr5R/ol/AMgcpY=
X-Received: by 2002:a17:90b:1a84:b0:31c:3872:9411 with SMTP id
 98e67ed59e1d1-31e77a2016bmr3410859a91.33.1753451306124; Fri, 25 Jul 2025
 06:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-2-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-2-d52704443975@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 25 Jul 2025 17:48:14 +0400
X-Gm-Features: Ac12FXwDdCi0KxHLvYAC8nQVGLPxRm6pfO44kf36S2MiQHehmoxbTEZJ5a1xkss
Message-ID: <CAMxuvaycFFEgWEtFEp8qsumYyxHmk-Vxpdw7bPcTQMBVHe5U+g@mail.gmail.com>
Subject: Re: [PATCH v7 02/24] migration: push Error **errp into
 vmstate_load_state()
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: multipart/alternative; boundary="0000000000003ba6da063ac13267"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000003ba6da063ac13267
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 4:19=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that vmstate_load_state() must report an error
> in errp, in case of failure.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/display/virtio-gpu.c     |  2 +-
>  hw/pci/pci.c                |  2 +-
>  hw/s390x/virtio-ccw.c       |  2 +-
>  hw/scsi/spapr_vscsi.c       |  2 +-
>  hw/vfio/pci.c               |  2 +-
>  hw/virtio/virtio-mmio.c     |  2 +-
>  hw/virtio/virtio-pci.c      |  2 +-
>  hw/virtio/virtio.c          |  4 ++--
>  include/migration/vmstate.h |  2 +-
>  migration/cpr.c             |  4 ++--
>  migration/savevm.c          |  6 ++++--
>  migration/vmstate-types.c   | 10 ++++-----
>  migration/vmstate.c         | 49
> ++++++++++++++++++++++++++++-----------------
>  tests/unit/test-vmstate.c   | 18 ++++++++---------
>  ui/vdagent.c                |  2 +-
>  15 files changed, 62 insertions(+), 47 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index
> 0a1a625b0ea6cf26cb0d799171a57ed3d3ab2442..5d2ca8d8b864350133a674802d7316a=
bd379591c
> 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1343,7 +1343,7 @@ static int virtio_gpu_load(QEMUFile *f, void
> *opaque, size_t size,
>      }
>
>      /* load & apply scanout state */
> -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, NULL);
>
>      return 0;
>  }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index
> c70b5ceebaf1f2b10768bd030526cbb518da2b8d..2ab5d30bb3c319ac1c7bfc9a2acf6a2=
b38082066
> 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -934,7 +934,7 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
>  int pci_device_load(PCIDevice *s, QEMUFile *f)
>  {
>      int ret;
> -    ret =3D vmstate_load_state(f, &vmstate_pci_device, s, s->version_id)=
;
> +    ret =3D vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
> NULL);
>      /* Restore the interrupt status bit. */
>      pci_update_irq_status(s);
>      return ret;
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index
> d2f85b39f30f7fc82e0c600144c0a958e1269b2c..2f6feff2b0a22d7d7f6aecfd7e7870d=
8362f1a73
> 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1136,7 +1136,7 @@ static void virtio_ccw_save_config(DeviceState *d,
> QEMUFile *f)
>  static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
>  {
>      VirtioCcwDevice *dev =3D VIRTIO_CCW_DEVICE(d);
> -    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
> +    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, NULL);
>  }
>
>  static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index
> 20f70fb2729de78b9636a6b8c869695dab4f8902..573fdea668536b464bca11f001e9e02=
88e781493
> 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -648,7 +648,7 @@ static void *vscsi_load_request(QEMUFile *f,
> SCSIRequest *sreq)
>      assert(!req->active);
>
>      memset(req, 0, sizeof(*req));
> -    rc =3D vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
> +    rc =3D vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, NULL)=
;
>      if (rc) {
>          fprintf(stderr, "VSCSI: failed loading request tag#%u\n",
> sreq->tag);
>          return NULL;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index
> e72d514a4cb91946f7c79332492bf5d709c308f2..498bbb96e97df50af5fc906fa00d443=
6c1edc05f
> 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2797,7 +2797,7 @@ static int vfio_pci_load_config(VFIODevice
> *vbasedev, QEMUFile *f)
>          old_addr[bar] =3D pdev->io_regions[bar].addr;
>      }
>
> -    ret =3D vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
> +    ret =3D vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1, NUL=
L);
>      if (ret) {
>          return ret;
>      }
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index
> 532c67107ba1d2978a76cf49f9cdc1de1dea3e11..9058b1563462d4464dcba799643a583=
c93fb5683
> 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -619,7 +619,7 @@ static int virtio_mmio_load_extra_state(DeviceState
> *opaque, QEMUFile *f)
>  {
>      VirtIOMMIOProxy *proxy =3D VIRTIO_MMIO(opaque);
>
> -    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
> +    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, NULL);
>  }
>
>  static bool virtio_mmio_has_extra_state(DeviceState *opaque)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index
> 767216d795998708f5716a23ae16c79cd90ff489..f8b52a611e56c22d844fd4cae3619da=
4f2686d03
> 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -161,7 +161,7 @@ static int virtio_pci_load_extra_state(DeviceState *d=
,
> QEMUFile *f)
>  {
>      VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);
>
> -    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1);
> +    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, NULL);
>  }
>
>  static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index
> 2ab1d20769495ea39445b87e3673b076ad172510..d5698b062a1e95437f6113f41136e90=
ae06f1974
> 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3317,14 +3317,14 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int
> version_id)
>      }
>
>      if (vdc->vmsd) {
> -        ret =3D vmstate_load_state(f, vdc->vmsd, vdev, version_id);
> +        ret =3D vmstate_load_state(f, vdc->vmsd, vdev, version_id, NULL)=
;
>          if (ret) {
>              return ret;
>          }
>      }
>
>      /* Subsections */
> -    ret =3D vmstate_load_state(f, &vmstate_virtio, vdev, 1);
> +    ret =3D vmstate_load_state(f, &vmstate_virtio, vdev, 1, NULL);
>      if (ret) {
>          return ret;
>      }
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index
> 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..056781b1c21e737583f081594d9f88b=
32adfd674
> 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1196,7 +1196,7 @@ extern const VMStateInfo vmstate_info_qlist;
>      }
>
>  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> -                       void *opaque, int version_id);
> +                       void *opaque, int version_id, Error **errp);
>  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>                         void *opaque, JSONWriter *vmdesc);
>  int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription
> *vmsd,
> diff --git a/migration/cpr.c b/migration/cpr.c
> index
> 42ad0b0d500e5de57faf0c6517e216b2d1c0cacf..9569c3f76bf8714def6406ae24f7fbc=
5afa4e793
> 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -233,9 +233,9 @@ int cpr_state_load(MigrationChannel *channel, Error
> **errp)
>          return -ENOTSUP;
>      }
>
> -    ret =3D vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
> +    ret =3D vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, err=
p);
>      if (ret) {
> -        error_setg(errp, "vmstate_load_state error %d", ret);
> +        error_prepend(errp, "vmstate_load_state error %d: ", ret);
>          qemu_fclose(f);
>          return ret;
>      }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> fabbeb296ae987d0c06ba6dafda63720205fecfd..ab947620f724874f325fb9fb59bef50=
b7c16fb51
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -969,7 +969,8 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry
> *se)
>      if (!se->vmsd) {         /* Old style */
>          return se->ops->load_state(f, se->opaque, se->load_version_id);
>      }
> -    return vmstate_load_state(f, se->vmsd, se->opaque,
> se->load_version_id);
> +    return vmstate_load_state(f, se->vmsd, se->opaque,
> se->load_version_id,
> +                              NULL);
>  }
>
>  static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
> @@ -2839,7 +2840,8 @@ static int qemu_loadvm_state_header(QEMUFile *f)
>              error_report("Configuration section missing");
>              return -EINVAL;
>          }
> -        ret =3D vmstate_load_state(f, &vmstate_configuration,
> &savevm_state, 0);
> +        ret =3D vmstate_load_state(f, &vmstate_configuration,
> &savevm_state, 0,
> +                                 NULL);
>
>          if (ret) {
>              return ret;
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index
> 741a588b7e18c6d37724b08a0101edc8bc74a0a5..1c5b76e1dd198030847971bc3563786=
7c9d54fc0
> 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -549,7 +549,7 @@ static int get_tmp(QEMUFile *f, void *pv, size_t size=
,
>
>      /* Writes the parent field which is at the start of the tmp */
>      *(void **)tmp =3D pv;
> -    ret =3D vmstate_load_state(f, vmsd, tmp, version_id);
> +    ret =3D vmstate_load_state(f, vmsd, tmp, version_id, NULL);
>      g_free(tmp);
>      return ret;
>  }
> @@ -649,7 +649,7 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t
> unused_size,
>
>      while (qemu_get_byte(f)) {
>          elm =3D g_malloc(size);
> -        ret =3D vmstate_load_state(f, vmsd, elm, version_id);
> +        ret =3D vmstate_load_state(f, vmsd, elm, version_id, NULL);
>          if (ret) {
>              return ret;
>          }
> @@ -803,7 +803,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t
> unused_size,
>              key =3D (void *)(uintptr_t)qemu_get_be64(f);
>          } else {
>              key =3D g_malloc0(key_size);
> -            ret =3D vmstate_load_state(f, key_vmsd, key, version_id);
> +            ret =3D vmstate_load_state(f, key_vmsd, key, version_id, NUL=
L);
>              if (ret) {
>                  error_report("%s : failed to load %s (%d)",
>                               field->name, key_vmsd->name, ret);
> @@ -811,7 +811,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t
> unused_size,
>              }
>          }
>          val =3D g_malloc0(val_size);
> -        ret =3D vmstate_load_state(f, val_vmsd, val, version_id);
> +        ret =3D vmstate_load_state(f, val_vmsd, val, version_id, NULL);
>          if (ret) {
>              error_report("%s : failed to load %s (%d)",
>                           field->name, val_vmsd->name, ret);
> @@ -892,7 +892,7 @@ static int get_qlist(QEMUFile *f, void *pv, size_t
> unused_size,
>
>      while (qemu_get_byte(f)) {
>          elm =3D g_malloc(size);
> -        ret =3D vmstate_load_state(f, vmsd, elm, version_id);
> +        ret =3D vmstate_load_state(f, vmsd, elm, version_id, NULL);
>          if (ret) {
>              error_report("%s: failed to load %s (%d)", field->name,
>                           vmsd->name, ret);
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index
> aeffeafaa4fa7582076a4f2747906ddf9aca891b..bb5e9bf38d6ee7619ceb3e9da292095=
81c3c12eb
> 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -132,29 +132,33 @@ static void vmstate_handle_alloc(void *ptr, const
> VMStateField *field,
>  }
>
>  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> -                       void *opaque, int version_id)
> +                       void *opaque, int version_id, Error **errp)
>  {
>      const VMStateField *field =3D vmsd->fields;
>      int ret =3D 0;
>
>      trace_vmstate_load_state(vmsd->name, version_id);
>      if (version_id > vmsd->version_id) {
> -        error_report("%s: incoming version_id %d is too new "
> -                     "for local version_id %d",
> -                     vmsd->name, version_id, vmsd->version_id);
> +        error_setg(errp, "%s: incoming version_id %d is too new "
> +                   "for local version_id %d",
> +                   vmsd->name, version_id, vmsd->version_id);
>          trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
>          return -EINVAL;
>      }
>      if  (version_id < vmsd->minimum_version_id) {
> -        error_report("%s: incoming version_id %d is too old "
> -                     "for local minimum version_id  %d",
> -                     vmsd->name, version_id, vmsd->minimum_version_id);
> +        error_setg(errp, "%s: incoming version_id %d is too old "
> +                   "for local minimum version_id  %d",
> +                   vmsd->name, version_id, vmsd->minimum_version_id);
>          trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>          return -EINVAL;
>      }
>      if (vmsd->pre_load) {
>          ret =3D vmsd->pre_load(opaque);
>          if (ret) {
> +            error_setg(errp, "VM pre load failed for: '%s', "
> +                       "version_id: '%d', minimum version_id: '%d', ret:
> %d",
> +                       vmsd->name, vmsd->version_id,
> vmsd->minimum_version_id,
> +                       ret);
>              return ret;
>          }
>      }
> @@ -192,10 +196,12 @@ int vmstate_load_state(QEMUFile *f, const
> VMStateDescription *vmsd,
>
>                  if (inner_field->flags & VMS_STRUCT) {
>                      ret =3D vmstate_load_state(f, inner_field->vmsd,
> curr_elem,
> -
>  inner_field->vmsd->version_id);
> +
>  inner_field->vmsd->version_id,
> +                                             errp);
>                  } else if (inner_field->flags & VMS_VSTRUCT) {
>                      ret =3D vmstate_load_state(f, inner_field->vmsd,
> curr_elem,
> -
>  inner_field->struct_version_id);
> +
>  inner_field->struct_version_id,
> +                                             errp);
>                  } else {
>                      ret =3D inner_field->info->get(f, curr_elem, size,
>                                                   inner_field);
> @@ -211,27 +217,34 @@ int vmstate_load_state(QEMUFile *f, const
> VMStateDescription *vmsd,
>                  }
>                  if (ret < 0) {
>                      qemu_file_set_error(f, ret);
> -                    error_report("Failed to load %s:%s", vmsd->name,
> -                                 field->name);
> +                    error_prepend(errp, "Failed to load %s:%s version_id=
:
> %d: ",
> +                                  vmsd->name, field->name,
> vmsd->version_id);
>                      trace_vmstate_load_field_error(field->name, ret);
>                      return ret;
>                  }
>              }
>          } else if (field->flags & VMS_MUST_EXIST) {
> -            error_report("Input validation failed: %s/%s",
> -                         vmsd->name, field->name);
> +            error_setg(errp, "Input validation failed: %s/%s version_id:
> %d",
> +                       vmsd->name, field->name, vmsd->version_id);
>              return -1;
>          }
>          field++;
>      }
>      assert(field->flags =3D=3D VMS_END);
> -    ret =3D vmstate_subsection_load(f, vmsd, opaque, NULL);
> +    ret =3D vmstate_subsection_load(f, vmsd, opaque, errp);
>      if (ret !=3D 0) {
>          qemu_file_set_error(f, ret);
>          return ret;
>      }
>      if (vmsd->post_load) {
>          ret =3D vmsd->post_load(opaque, version_id);
> +        if (ret < 0) {
> +            error_setg(errp,
> +                       "VM Post load failed for: %s, version_id: %d, "
> +                       "minimum_version: %d, ret: %d",
> +                       vmsd->name, vmsd->version_id,
> vmsd->minimum_version_id,
> +                       ret);
> +        }
>      }
>      trace_vmstate_load_state_end(vmsd->name, "end", ret);
>      return ret;
> @@ -607,12 +620,12 @@ static int vmstate_subsection_load(QEMUFile *f,
> const VMStateDescription *vmsd,
>          qemu_file_skip(f, len); /* idstr */
>          version_id =3D qemu_get_be32(f);
>
> -        ret =3D vmstate_load_state(f, sub_vmsd, opaque, version_id);
> +        ret =3D vmstate_load_state(f, sub_vmsd, opaque, version_id, errp=
);
>          if (ret) {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr,
> "(child)");
> -            error_setg(errp,
> -                       "Loading VM subsection '%s' in '%s' failed : %d",
> -                       idstr, vmsd->name, ret);
> +            error_prepend(errp,
> +                          "Loading VM subsection '%s' in '%s' failed:
> '%d': ",
> +                          idstr, vmsd->name, ret);
>              return ret;
>          }
>      }
> diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
> index
> 63f28f26f45691a70936d33e7341d16477a3471f..ca5e0ba1e3e5e2bb0a1ce39143a292f=
2c6f9420a
> 100644
> --- a/tests/unit/test-vmstate.c
> +++ b/tests/unit/test-vmstate.c
> @@ -114,7 +114,7 @@ static int load_vmstate_one(const VMStateDescription
> *desc, void *obj,
>      qemu_fclose(f);
>
>      f =3D open_test_file(false);
> -    ret =3D vmstate_load_state(f, desc, obj, version);
> +    ret =3D vmstate_load_state(f, desc, obj, version, NULL);
>      if (ret) {
>          g_assert(qemu_file_get_error(f));
>      } else{
> @@ -365,7 +365,7 @@ static void test_load_v1(void)
>
>      QEMUFile *loading =3D open_test_file(false);
>      TestStruct obj =3D { .b =3D 200, .e =3D 500, .f =3D 600 };
> -    vmstate_load_state(loading, &vmstate_versioned, &obj, 1);
> +    vmstate_load_state(loading, &vmstate_versioned, &obj, 1, NULL);
>      g_assert(!qemu_file_get_error(loading));
>      g_assert_cmpint(obj.a, =3D=3D, 10);
>      g_assert_cmpint(obj.b, =3D=3D, 200);
> @@ -391,7 +391,7 @@ static void test_load_v2(void)
>
>      QEMUFile *loading =3D open_test_file(false);
>      TestStruct obj;
> -    vmstate_load_state(loading, &vmstate_versioned, &obj, 2);
> +    vmstate_load_state(loading, &vmstate_versioned, &obj, 2, NULL);
>      g_assert_cmpint(obj.a, =3D=3D, 10);
>      g_assert_cmpint(obj.b, =3D=3D, 20);
>      g_assert_cmpint(obj.c, =3D=3D, 30);
> @@ -480,7 +480,7 @@ static void test_load_noskip(void)
>
>      QEMUFile *loading =3D open_test_file(false);
>      TestStruct obj =3D { .skip_c_e =3D false };
> -    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
> +    vmstate_load_state(loading, &vmstate_skipping, &obj, 2, NULL);
>      g_assert(!qemu_file_get_error(loading));
>      g_assert_cmpint(obj.a, =3D=3D, 10);
>      g_assert_cmpint(obj.b, =3D=3D, 20);
> @@ -504,7 +504,7 @@ static void test_load_skip(void)
>
>      QEMUFile *loading =3D open_test_file(false);
>      TestStruct obj =3D { .skip_c_e =3D true, .c =3D 300, .e =3D 500 };
> -    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
> +    vmstate_load_state(loading, &vmstate_skipping, &obj, 2, NULL);
>      g_assert(!qemu_file_get_error(loading));
>      g_assert_cmpint(obj.a, =3D=3D, 10);
>      g_assert_cmpint(obj.b, =3D=3D, 20);
> @@ -773,7 +773,7 @@ static void test_load_q(void)
>      TestQtailq tgt;
>
>      QTAILQ_INIT(&tgt.q);
> -    vmstate_load_state(fload, &vmstate_q, &tgt, 1);
> +    vmstate_load_state(fload, &vmstate_q, &tgt, 1, NULL);
>      char eof =3D qemu_get_byte(fload);
>      g_assert(!qemu_file_get_error(fload));
>      g_assert_cmpint(tgt.i16, =3D=3D, obj_q.i16);
> @@ -1127,7 +1127,7 @@ static void test_gtree_load_domain(void)
>
>      fload =3D open_test_file(false);
>
> -    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1);
> +    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1, NULL);
>      eof =3D qemu_get_byte(fload);
>      g_assert(!qemu_file_get_error(fload));
>      g_assert_cmpint(orig_domain->id, =3D=3D, dest_domain->id);
> @@ -1241,7 +1241,7 @@ static void test_gtree_load_iommu(void)
>      qemu_fclose(fsave);
>
>      fload =3D open_test_file(false);
> -    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1);
> +    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1, NULL);
>      eof =3D qemu_get_byte(fload);
>      g_assert(!qemu_file_get_error(fload));
>      g_assert_cmpint(orig_iommu->id, =3D=3D, dest_iommu->id);
> @@ -1376,7 +1376,7 @@ static void test_load_qlist(void)
>      qemu_fclose(fsave);
>
>      fload =3D open_test_file(false);
> -    vmstate_load_state(fload, &vmstate_container, dest_container, 1);
> +    vmstate_load_state(fload, &vmstate_container, dest_container, 1,
> NULL);
>      eof =3D qemu_get_byte(fload);
>      g_assert(!qemu_file_get_error(fload));
>      g_assert_cmpint(eof, =3D=3D, QEMU_VM_EOF);
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index
> c0746fe5b168fdc7aeb4866de2ba0c3387566649..83457dee0767433ad0778b37b41b9c6=
73a0e1860
> 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -1008,7 +1008,7 @@ static int get_cbinfo(QEMUFile *f, void *pv, size_t
> size,
>
>      vdagent_clipboard_peer_register(vd);
>
> -    ret =3D vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0);
> +    ret =3D vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0, NUL=
L);
>      if (ret) {
>          return ret;
>      }
>
> --
> 2.50.0
>
>

--0000000000003ba6da063ac13267
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25,=
 2025 at 4:19=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.co=
m">armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">This is an incremental step in converting vmstate load=
ing<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that vmstate_load_state() must report an error<br>
in errp, in case of failure.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/pci/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 +-<br>
=C2=A0hw/s390x/virtio-ccw.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/scsi/spapr_vscsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/vfio/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
=C2=A0hw/virtio/virtio-mmio.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/virtio/virtio-pci.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<b=
r>
=C2=A0include/migration/vmstate.h |=C2=A0 2 +-<br>
=C2=A0migration/cpr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 ++--<br>
=C2=A0migration/savevm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++++--=
<br>
=C2=A0migration/vmstate-types.c=C2=A0 =C2=A0| 10 ++++-----<br>
=C2=A0migration/vmstate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 49 +++++++++++=
+++++++++++++++++-----------------<br>
=C2=A0tests/unit/test-vmstate.c=C2=A0 =C2=A0| 18 ++++++++---------<br>
=C2=A0ui/vdagent.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 +-<br>
=C2=A015 files changed, 62 insertions(+), 47 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
index 0a1a625b0ea6cf26cb0d799171a57ed3d3ab2442..5d2ca8d8b864350133a674802d7=
316abd379591c 100644<br>
--- a/hw/display/virtio-gpu.c<br>
+++ b/hw/display/virtio-gpu.c<br>
@@ -1343,7 +1343,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque,=
 size_t size,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* load &amp; apply scanout state */<br>
-=C2=A0 =C2=A0 vmstate_load_state(f, &amp;vmstate_virtio_gpu_scanouts, g, 1=
);<br>
+=C2=A0 =C2=A0 vmstate_load_state(f, &amp;vmstate_virtio_gpu_scanouts, g, 1=
, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
diff --git a/hw/pci/pci.c b/hw/pci/pci.c<br>
index c70b5ceebaf1f2b10768bd030526cbb518da2b8d..2ab5d30bb3c319ac1c7bfc9a2ac=
f6a2b38082066 100644<br>
--- a/hw/pci/pci.c<br>
+++ b/hw/pci/pci.c<br>
@@ -934,7 +934,7 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)<br>
=C2=A0int pci_device_load(PCIDevice *s, QEMUFile *f)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
-=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_pci_device, s, s-=
&gt;version_id);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_pci_device, s, s-=
&gt;version_id, NULL);<br>
=C2=A0 =C2=A0 =C2=A0/* Restore the interrupt status bit. */<br>
=C2=A0 =C2=A0 =C2=A0pci_update_irq_status(s);<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c<br>
index d2f85b39f30f7fc82e0c600144c0a958e1269b2c..2f6feff2b0a22d7d7f6aecfd7e7=
870d8362f1a73 100644<br>
--- a/hw/s390x/virtio-ccw.c<br>
+++ b/hw/s390x/virtio-ccw.c<br>
@@ -1136,7 +1136,7 @@ static void virtio_ccw_save_config(DeviceState *d, QE=
MUFile *f)<br>
=C2=A0static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtioCcwDevice *dev =3D VIRTIO_CCW_DEVICE(d);<br>
-=C2=A0 =C2=A0 return vmstate_load_state(f, &amp;vmstate_virtio_ccw_dev, de=
v, 1);<br>
+=C2=A0 =C2=A0 return vmstate_load_state(f, &amp;vmstate_virtio_ccw_dev, de=
v, 1, NULL);<br>
=C2=A0}<br>
<br>
=C2=A0static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)<br>
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c<br>
index 20f70fb2729de78b9636a6b8c869695dab4f8902..573fdea668536b464bca11f001e=
9e0288e781493 100644<br>
--- a/hw/scsi/spapr_vscsi.c<br>
+++ b/hw/scsi/spapr_vscsi.c<br>
@@ -648,7 +648,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIReques=
t *sreq)<br>
=C2=A0 =C2=A0 =C2=A0assert(!req-&gt;active);<br>
<br>
=C2=A0 =C2=A0 =C2=A0memset(req, 0, sizeof(*req));<br>
-=C2=A0 =C2=A0 rc =3D vmstate_load_state(f, &amp;vmstate_spapr_vscsi_req, r=
eq, 1);<br>
+=C2=A0 =C2=A0 rc =3D vmstate_load_state(f, &amp;vmstate_spapr_vscsi_req, r=
eq, 1, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (rc) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;VSCSI: failed loadi=
ng request tag#%u\n&quot;, sreq-&gt;tag);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c<br>
index e72d514a4cb91946f7c79332492bf5d709c308f2..498bbb96e97df50af5fc906fa00=
d4436c1edc05f 100644<br>
--- a/hw/vfio/pci.c<br>
+++ b/hw/vfio/pci.c<br>
@@ -2797,7 +2797,7 @@ static int vfio_pci_load_config(VFIODevice *vbasedev,=
 QEMUFile *f)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0old_addr[bar] =3D pdev-&gt;io_regions[bar=
].addr;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_vfio_pci_config, =
vdev, 1);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_vfio_pci_config, =
vdev, 1, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c<br>
index 532c67107ba1d2978a76cf49f9cdc1de1dea3e11..9058b1563462d4464dcba799643=
a583c93fb5683 100644<br>
--- a/hw/virtio/virtio-mmio.c<br>
+++ b/hw/virtio/virtio-mmio.c<br>
@@ -619,7 +619,7 @@ static int virtio_mmio_load_extra_state(DeviceState *op=
aque, QEMUFile *f)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtIOMMIOProxy *proxy =3D VIRTIO_MMIO(opaque);<br>
<br>
-=C2=A0 =C2=A0 return vmstate_load_state(f, &amp;vmstate_virtio_mmio, proxy=
, 1);<br>
+=C2=A0 =C2=A0 return vmstate_load_state(f, &amp;vmstate_virtio_mmio, proxy=
, 1, NULL);<br>
=C2=A0}<br>
<br>
=C2=A0static bool virtio_mmio_has_extra_state(DeviceState *opaque)<br>
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c<br>
index 767216d795998708f5716a23ae16c79cd90ff489..f8b52a611e56c22d844fd4cae36=
19da4f2686d03 100644<br>
--- a/hw/virtio/virtio-pci.c<br>
+++ b/hw/virtio/virtio-pci.c<br>
@@ -161,7 +161,7 @@ static int virtio_pci_load_extra_state(DeviceState *d, =
QEMUFile *f)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);<br>
<br>
-=C2=A0 =C2=A0 return vmstate_load_state(f, &amp;vmstate_virtio_pci, proxy,=
 1);<br>
+=C2=A0 =C2=A0 return vmstate_load_state(f, &amp;vmstate_virtio_pci, proxy,=
 1, NULL);<br>
=C2=A0}<br>
<br>
=C2=A0static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)=
<br>
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
index 2ab1d20769495ea39445b87e3673b076ad172510..d5698b062a1e95437f6113f4113=
6e90ae06f1974 100644<br>
--- a/hw/virtio/virtio.c<br>
+++ b/hw/virtio/virtio.c<br>
@@ -3317,14 +3317,14 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int ve=
rsion_id)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (vdc-&gt;vmsd) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, vdc-&gt;vmsd, vd=
ev, version_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, vdc-&gt;vmsd, vd=
ev, version_id, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Subsections */<br>
-=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_virtio, vdev, 1);=
<br>
+=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_virtio, vdev, 1, =
NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h<br>
index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..056781b1c21e737583f081594d9=
f88b32adfd674 100644<br>
--- a/include/migration/vmstate.h<br>
+++ b/include/migration/vmstate.h<br>
@@ -1196,7 +1196,7 @@ extern const VMStateInfo vmstate_info_qlist;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0void *opaque, int version_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0void *opaque, int version_id, Error **errp);<br>
=C2=A0int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 void *opaque, JSONWriter *vmdesc);<br>
=C2=A0int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription=
 *vmsd,<br>
diff --git a/migration/cpr.c b/migration/cpr.c<br>
index 42ad0b0d500e5de57faf0c6517e216b2d1c0cacf..9569c3f76bf8714def6406ae24f=
7fbc5afa4e793 100644<br>
--- a/migration/cpr.c<br>
+++ b/migration/cpr.c<br>
@@ -233,9 +233,9 @@ int cpr_state_load(MigrationChannel *channel, Error **e=
rrp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSUP;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_cpr_state, &amp;c=
pr_state, 1);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_cpr_state, &amp;c=
pr_state, 1, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;vmstate_load_state erro=
r %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;vmstate_load_state e=
rror %d: &quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fclose(f);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index fabbeb296ae987d0c06ba6dafda63720205fecfd..ab947620f724874f325fb9fb59b=
ef50b7c16fb51 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -969,7 +969,8 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *se=
)<br>
=C2=A0 =C2=A0 =C2=A0if (!se-&gt;vmsd) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 Old style */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return se-&gt;ops-&gt;load_state(f, se-&g=
t;opaque, se-&gt;load_version_id);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 return vmstate_load_state(f, se-&gt;vmsd, se-&gt;opaque, se-=
&gt;load_version_id);<br>
+=C2=A0 =C2=A0 return vmstate_load_state(f, se-&gt;vmsd, se-&gt;opaque, se-=
&gt;load_version_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL);<br>
=C2=A0}<br>
<br>
=C2=A0static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,<b=
r>
@@ -2839,7 +2840,8 @@ static int qemu_loadvm_state_header(QEMUFile *f)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;Configur=
ation section missing&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_con=
figuration, &amp;savevm_state, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_con=
figuration, &amp;savevm_state, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c<br>
index 741a588b7e18c6d37724b08a0101edc8bc74a0a5..1c5b76e1dd198030847971bc356=
37867c9d54fc0 100644<br>
--- a/migration/vmstate-types.c<br>
+++ b/migration/vmstate-types.c<br>
@@ -549,7 +549,7 @@ static int get_tmp(QEMUFile *f, void *pv, size_t size,<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Writes the parent field which is at the start of the=
 tmp */<br>
=C2=A0 =C2=A0 =C2=A0*(void **)tmp =3D pv;<br>
-=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, vmsd, tmp, version_id);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, vmsd, tmp, version_id, NULL);<=
br>
=C2=A0 =C2=A0 =C2=A0g_free(tmp);<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
@@ -649,7 +649,7 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t unu=
sed_size,<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (qemu_get_byte(f)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elm =3D g_malloc(size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, vmsd, elm, versi=
on_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, vmsd, elm, versi=
on_id, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -803,7 +803,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unus=
ed_size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0key =3D (void *)(uintptr_t)=
qemu_get_be64(f);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0key =3D g_malloc0(key_size)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, ke=
y_vmsd, key, version_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, ke=
y_vmsd, key, version_id, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(=
&quot;%s : failed to load %s (%d)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 field-&gt;name, key_vmsd-&gt;name, ret);<br=
>
@@ -811,7 +811,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unus=
ed_size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D g_malloc0(val_size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, val_vmsd, val, v=
ersion_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, val_vmsd, val, v=
ersion_id, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;%s : fai=
led to load %s (%d)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 field-&gt;name, val_vmsd-&gt;name, ret);<br>
@@ -892,7 +892,7 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unus=
ed_size,<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (qemu_get_byte(f)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elm =3D g_malloc(size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, vmsd, elm, versi=
on_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, vmsd, elm, versi=
on_id, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;%s: fail=
ed to load %s (%d)&quot;, field-&gt;name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 vmsd-&gt;name, ret);<br>
diff --git a/migration/vmstate.c b/migration/vmstate.c<br>
index aeffeafaa4fa7582076a4f2747906ddf9aca891b..bb5e9bf38d6ee7619ceb3e9da29=
209581c3c12eb 100644<br>
--- a/migration/vmstate.c<br>
+++ b/migration/vmstate.c<br>
@@ -132,29 +132,33 @@ static void vmstate_handle_alloc(void *ptr, const VMS=
tateField *field,<br>
=C2=A0}<br>
<br>
=C2=A0int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0void *opaque, int version_id)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0void *opaque, int version_id, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const VMStateField *field =3D vmsd-&gt;fields;<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_vmstate_load_state(vmsd-&gt;name, version_id);<br=
>
=C2=A0 =C2=A0 =C2=A0if (version_id &gt; vmsd-&gt;version_id) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: incoming version_id %d =
is too new &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;for local version_id %d&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0vmsd-&gt;name, version_id, vmsd-&gt;version_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s: incoming version_id=
 %d is too new &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;for local version_id %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmsd-=
&gt;name, version_id, vmsd-&gt;version_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vmstate_load_state_end(vmsd-&gt;nam=
e, &quot;too new&quot;, -EINVAL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if=C2=A0 (version_id &lt; vmsd-&gt;minimum_version_id) =
{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: incoming version_id %d =
is too old &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;for local minimum version_id=C2=A0 %d&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0vmsd-&gt;name, version_id, vmsd-&gt;minimum_version_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s: incoming version_id=
 %d is too old &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;for local minimum version_id=C2=A0 %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmsd-=
&gt;name, version_id, vmsd-&gt;minimum_version_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vmstate_load_state_end(vmsd-&gt;nam=
e, &quot;too old&quot;, -EINVAL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (vmsd-&gt;pre_load) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vmsd-&gt;pre_load(opaque);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;VM pre lo=
ad failed for: &#39;%s&#39;, &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;version_id: &#39;%d&#39;, minimum version_id: &#39;%d&#39;,=
 ret: %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vmsd-&gt;name, vmsd-&gt;version_id, vmsd-&gt;minimum_version_id,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -192,10 +196,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDesc=
ription *vmsd,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (inner_fie=
ld-&gt;flags &amp; VMS_STRUCT) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ret =3D vmstate_load_state(f, inner_field-&gt;vmsd, curr_elem,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inner_field-&gt;vmsd-&gt;version_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inner_field-&gt;vmsd-&gt;version_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (in=
ner_field-&gt;flags &amp; VMS_VSTRUCT) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ret =3D vmstate_load_state(f, inner_field-&gt;vmsd, curr_elem,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inner_field-&gt;struct_version_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inner_field-&gt;struct_version_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ret =3D inner_field-&gt;info-&gt;get(f, curr_elem, size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 inner_field);<br>
@@ -211,27 +217,34 @@ int vmstate_load_state(QEMUFile *f, const VMStateDesc=
ription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; =
0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0qemu_file_set_error(f, ret);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_report(&quot;Failed to load %s:%s&quot;, vmsd-&gt;name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0field-&gt;name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_prepend(errp, &quot;Failed to load %s:%s version_id: %d: &quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmsd-&gt;name, field-&gt;name=
, vmsd-&gt;version_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0trace_vmstate_load_field_error(field-&gt;name, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (field-&gt;flags &amp; VMS_MUST=
_EXIST) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Input validat=
ion failed: %s/%s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0vmsd-&gt;name, field-&gt;name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Input val=
idation failed: %s/%s version_id: %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vmsd-&gt;name, field-&gt;name, vmsd-&gt;version_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0field++;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0assert(field-&gt;flags =3D=3D VMS_END);<br>
-=C2=A0 =C2=A0 ret =3D vmstate_subsection_load(f, vmsd, opaque, NULL);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_subsection_load(f, vmsd, opaque, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (ret !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_file_set_error(f, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (vmsd-&gt;post_load) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vmsd-&gt;post_load(opaque, versio=
n_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;VM Post load failed for: %s, version_id: %d, &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;minimum_version: %d, ret: %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vmsd-&gt;name, vmsd-&gt;version_id, vmsd-&gt;minimum_version_id,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0trace_vmstate_load_state_end(vmsd-&gt;name, &quot;end&q=
uot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
@@ -607,12 +620,12 @@ static int vmstate_subsection_load(QEMUFile *f, const=
 VMStateDescription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_file_skip(f, len); /* idstr */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version_id =3D qemu_get_be32(f);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, sub_vmsd, opaque=
, version_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, sub_vmsd, opaque=
, version_id, errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vmstate_subsection_lo=
ad_bad(vmsd-&gt;name, idstr, &quot;(child)&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Loading VM subsection &#39;%s&#39; in &#39;%s&#39; failed :=
 %d&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0idstr, vmsd-&gt;name, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;Loading VM subsection &#39;%s&#39; in &#39;%s&#39; =
failed: &#39;%d&#39;: &quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 idstr, vmsd-&gt;name, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c<br>
index 63f28f26f45691a70936d33e7341d16477a3471f..ca5e0ba1e3e5e2bb0a1ce39143a=
292f2c6f9420a 100644<br>
--- a/tests/unit/test-vmstate.c<br>
+++ b/tests/unit/test-vmstate.c<br>
@@ -114,7 +114,7 @@ static int load_vmstate_one(const VMStateDescription *d=
esc, void *obj,<br>
=C2=A0 =C2=A0 =C2=A0qemu_fclose(f);<br>
<br>
=C2=A0 =C2=A0 =C2=A0f =3D open_test_file(false);<br>
-=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, desc, obj, version);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, desc, obj, version, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert(qemu_file_get_error(f));<br>
=C2=A0 =C2=A0 =C2=A0} else{<br>
@@ -365,7 +365,7 @@ static void test_load_v1(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0QEMUFile *loading =3D open_test_file(false);<br>
=C2=A0 =C2=A0 =C2=A0TestStruct obj =3D { .b =3D 200, .e =3D 500, .f =3D 600=
 };<br>
-=C2=A0 =C2=A0 vmstate_load_state(loading, &amp;vmstate_versioned, &amp;obj=
, 1);<br>
+=C2=A0 =C2=A0 vmstate_load_state(loading, &amp;vmstate_versioned, &amp;obj=
, 1, NULL);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!qemu_file_get_error(loading));<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(obj.a, =3D=3D, 10);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(obj.b, =3D=3D, 200);<br>
@@ -391,7 +391,7 @@ static void test_load_v2(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0QEMUFile *loading =3D open_test_file(false);<br>
=C2=A0 =C2=A0 =C2=A0TestStruct obj;<br>
-=C2=A0 =C2=A0 vmstate_load_state(loading, &amp;vmstate_versioned, &amp;obj=
, 2);<br>
+=C2=A0 =C2=A0 vmstate_load_state(loading, &amp;vmstate_versioned, &amp;obj=
, 2, NULL);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(obj.a, =3D=3D, 10);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(obj.b, =3D=3D, 20);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(obj.c, =3D=3D, 30);<br>
@@ -480,7 +480,7 @@ static void test_load_noskip(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0QEMUFile *loading =3D open_test_file(false);<br>
=C2=A0 =C2=A0 =C2=A0TestStruct obj =3D { .skip_c_e =3D false };<br>
-=C2=A0 =C2=A0 vmstate_load_state(loading, &amp;vmstate_skipping, &amp;obj,=
 2);<br>
+=C2=A0 =C2=A0 vmstate_load_state(loading, &amp;vmstate_skipping, &amp;obj,=
 2, NULL);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!qemu_file_get_error(loading));<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(obj.a, =3D=3D, 10);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(obj.b, =3D=3D, 20);<br>
@@ -504,7 +504,7 @@ static void test_load_skip(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0QEMUFile *loading =3D open_test_file(false);<br>
=C2=A0 =C2=A0 =C2=A0TestStruct obj =3D { .skip_c_e =3D true, .c =3D 300, .e=
 =3D 500 };<br>
-=C2=A0 =C2=A0 vmstate_load_state(loading, &amp;vmstate_skipping, &amp;obj,=
 2);<br>
+=C2=A0 =C2=A0 vmstate_load_state(loading, &amp;vmstate_skipping, &amp;obj,=
 2, NULL);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!qemu_file_get_error(loading));<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(obj.a, =3D=3D, 10);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(obj.b, =3D=3D, 20);<br>
@@ -773,7 +773,7 @@ static void test_load_q(void)<br>
=C2=A0 =C2=A0 =C2=A0TestQtailq tgt;<br>
<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_INIT(&amp;tgt.q);<br>
-=C2=A0 =C2=A0 vmstate_load_state(fload, &amp;vmstate_q, &amp;tgt, 1);<br>
+=C2=A0 =C2=A0 vmstate_load_state(fload, &amp;vmstate_q, &amp;tgt, 1, NULL)=
;<br>
=C2=A0 =C2=A0 =C2=A0char eof =3D qemu_get_byte(fload);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!qemu_file_get_error(fload));<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(tgt.i16, =3D=3D, obj_q.i16);<br>
@@ -1127,7 +1127,7 @@ static void test_gtree_load_domain(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0fload =3D open_test_file(false);<br>
<br>
-=C2=A0 =C2=A0 vmstate_load_state(fload, &amp;vmstate_domain, dest_domain, =
1);<br>
+=C2=A0 =C2=A0 vmstate_load_state(fload, &amp;vmstate_domain, dest_domain, =
1, NULL);<br>
=C2=A0 =C2=A0 =C2=A0eof =3D qemu_get_byte(fload);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!qemu_file_get_error(fload));<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(orig_domain-&gt;id, =3D=3D, dest_domain=
-&gt;id);<br>
@@ -1241,7 +1241,7 @@ static void test_gtree_load_iommu(void)<br>
=C2=A0 =C2=A0 =C2=A0qemu_fclose(fsave);<br>
<br>
=C2=A0 =C2=A0 =C2=A0fload =3D open_test_file(false);<br>
-=C2=A0 =C2=A0 vmstate_load_state(fload, &amp;vmstate_iommu, dest_iommu, 1)=
;<br>
+=C2=A0 =C2=A0 vmstate_load_state(fload, &amp;vmstate_iommu, dest_iommu, 1,=
 NULL);<br>
=C2=A0 =C2=A0 =C2=A0eof =3D qemu_get_byte(fload);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!qemu_file_get_error(fload));<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(orig_iommu-&gt;id, =3D=3D, dest_iommu-&=
gt;id);<br>
@@ -1376,7 +1376,7 @@ static void test_load_qlist(void)<br>
=C2=A0 =C2=A0 =C2=A0qemu_fclose(fsave);<br>
<br>
=C2=A0 =C2=A0 =C2=A0fload =3D open_test_file(false);<br>
-=C2=A0 =C2=A0 vmstate_load_state(fload, &amp;vmstate_container, dest_conta=
iner, 1);<br>
+=C2=A0 =C2=A0 vmstate_load_state(fload, &amp;vmstate_container, dest_conta=
iner, 1, NULL);<br>
=C2=A0 =C2=A0 =C2=A0eof =3D qemu_get_byte(fload);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!qemu_file_get_error(fload));<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(eof, =3D=3D, QEMU_VM_EOF);<br>
diff --git a/ui/vdagent.c b/ui/vdagent.c<br>
index c0746fe5b168fdc7aeb4866de2ba0c3387566649..83457dee0767433ad0778b37b41=
b9c673a0e1860 100644<br>
--- a/ui/vdagent.c<br>
+++ b/ui/vdagent.c<br>
@@ -1008,7 +1008,7 @@ static int get_cbinfo(QEMUFile *f, void *pv, size_t s=
ize,<br>
<br>
=C2=A0 =C2=A0 =C2=A0vdagent_clipboard_peer_register(vd);<br>
<br>
-=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_cbinfo_array, &am=
p;cbinfo, 0);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_cbinfo_array, &am=
p;cbinfo, 0, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div>

--0000000000003ba6da063ac13267--


