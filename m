Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F076AC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 07:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6ms7-0007Uw-GE; Tue, 14 May 2024 03:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s6ms5-0007Ud-7M
 for qemu-devel@nongnu.org; Tue, 14 May 2024 03:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s6ms3-0002HW-Fi
 for qemu-devel@nongnu.org; Tue, 14 May 2024 03:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715672805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+YE8u8G1oyYQZ+CgE8cW5NHWOb2fWMOZm+PPxv0so0=;
 b=UAqpzBQv6oyKY9k6XQfB1SmmeudKo33+ZzGbA0PoIlJ/dfVUpFlYBTdT0u60/88OMAFYsr
 TnR1RrgR3FbF7zeMcvEjQtKwCGmTuOgskHCA1j31XQEjxDs242ghFovhr5XDwHarjW7bJp
 gwm8tVROjIcNpQRTbKmu+qhaga5TLH4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-jkS1fihHNX2erbIn21hnKA-1; Tue, 14 May 2024 03:25:39 -0400
X-MC-Unique: jkS1fihHNX2erbIn21hnKA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5725f45da8eso326550a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 00:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715671538; x=1716276338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+YE8u8G1oyYQZ+CgE8cW5NHWOb2fWMOZm+PPxv0so0=;
 b=Yz4UdYwCzIAtY1XQOW9s4E501A02ChVp8ta66/OYBv5Kb3HX/HIwdSNk9BhGMvCs57
 ZDBYXXelEvYXYsmn/eguGq+e0Djqy7Xt6Dn8THfo2Kk0RC6tIg2DMO/TTxQzSNQgz5Zf
 2RO7z53GDH3vN/xdrqiaRzbALEaudOOcac542yBiaRTgvNqqwC2wBIa/k+XoRJwEQCxx
 yWwwFG4kY+AUD6jkzbtJtEraZokhIKpVfeUp97ALZ5NcwTOcJ40yroWmzNMaWcnHtrel
 9KrQWxOu0CBJOJ1QD4hWG7B7nSUaZo4bZDT6Er52NsqZk3Vdf61G/QfoRggoR0/p/MiB
 wgqw==
X-Gm-Message-State: AOJu0YyW03NaGigz1tr15yvM235oygWvwcgRERTt+MH8BWRnsNu7bh8h
 MtNU6kYJ9T+rU0vvhOJweeae6qX6E3W6t7I6MbBJCwHidyYg4eL9bKy4wmw+Jb+Oer44SGhh0j+
 WRpLNL5I9FgdNCwowDWYTRRuH81C2E9DD2UNHE+j0pVsphVVyhzx55lLnTHc+Ge517OAPZHSh1N
 XlgvSRTEZuqg39QY/TlYPgyzpATrg=
X-Received: by 2002:a50:d793:0:b0:572:3fe4:18b5 with SMTP id
 4fb4d7f45d1cf-5734d67aa8fmr7295492a12.32.1715671538692; 
 Tue, 14 May 2024 00:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVpYfaGylMsxilQQuu96KhUsJ6Ngxt8tclDlSa21gh1frfyuPe0Zx8CHPQpXXB1EWJwe2IcpQfq/mpvC7bl10=
X-Received: by 2002:a50:d793:0:b0:572:3fe4:18b5 with SMTP id
 4fb4d7f45d1cf-5734d67aa8fmr7295474a12.32.1715671538251; Tue, 14 May 2024
 00:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240513071905.499143-1-marcandre.lureau@redhat.com>
 <20240513071905.499143-4-marcandre.lureau@redhat.com> <ZkLojVI4ZAKANIBr@x1n>
In-Reply-To: <ZkLojVI4ZAKANIBr@x1n>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 14 May 2024 11:25:26 +0400
Message-ID: <CAMxuvayd5X04dOSRMHYQr-NbHrwNeZLTD6wvNb2bq6c+-qU-9w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] virtio-gpu: add x-vmstate-version
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Tue, May 14, 2024 at 8:35=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Hey, Marc-Andre,
>
> On Mon, May 13, 2024 at 11:19:04AM +0400, marcandre.lureau@redhat.com wro=
te:
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index ae831b6b3e..7f9fb5eacc 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1234,7 +1234,8 @@ static int virtio_gpu_save(QEMUFile *f, void *opa=
que, size_t size,
> >      }
> >      qemu_put_be32(f, 0); /* end of list */
> >
> > -    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL=
);
> > +    return vmstate_save_state_v(f, &vmstate_virtio_gpu_scanouts, g,
> > +                                NULL, g->vmstate_version, NULL);
> >  }
> >
> >  static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
> > @@ -1339,7 +1340,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opa=
que, size_t size,
> >      }
> >
> >      /* load & apply scanout state */
> > -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> > +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, g->vmstate_=
version);
>
> [sorry for a late response; attending a conf, and will reply to the v1
>  thread later for the other discussions..]
>
> These two changes shouldn't be needed if we go with the .field_exists()
> approach, am I right?  IIUC in that case we can keep the version 1 here a=
nd
> don't boost anything, because we relied on the machine versions.
>
> IIUC this might be the reason why we found 9.0 mahines are broken on
> migration.  E.g, IIUC my original patch should work for 9.0<->9.0 too.
>

Indeed, but for consistency, shouldn't it use the x-vmstate-version
value for the top-level VMSD save/load ?

Otherwise, it feels a bit odd that this x-vmstate-version is only used
for the nested "virtio-gpu-one-scanout" version.

Or perhaps we should rename it to x-scanout-vmstate-version ? wdyt


> Thanks,
>
> >
> >      return 0;
> >  }
> > @@ -1659,6 +1660,7 @@ static Property virtio_gpu_properties[] =3D {
> >      DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
> >                      VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
> >      DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0)=
,
> > +    DEFINE_PROP_UINT8("x-vmstate-version", VirtIOGPU, vmstate_version,=
 1),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > --
> > 2.41.0.28.gd7d8841f67
> >
>
> --
> Peter Xu
>


