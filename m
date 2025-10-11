Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6DECCD183
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 08:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Ubd-0005hv-67; Sat, 11 Oct 2025 04:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1v7Uba-0005hG-Fc
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 04:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1v7UbW-0003SP-0x
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 04:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760169922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2LjMu1SmBW0Il/Ad5mkR+kmEwLtrYj43T8cQppTZxI=;
 b=KsLbS3lz6HVzXyQ5uTOP+u48QIz38I9ObRMV6hFnXvD2yKYCK5Qjycv1f/K0m3RVo4lD8O
 Yt5miChPNNeccFv5wOalIlSCZF7peaFceUb8wz9NJ397p4Yz1ixIXRr+6vhbognDEhTtla
 C9bKQ5cDyJ/BAtONMl2XclhD6S/5REU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-2KUhWYAUMqiq-7lQvQURqA-1; Sat, 11 Oct 2025 04:05:19 -0400
X-MC-Unique: 2KUhWYAUMqiq-7lQvQURqA-1
X-Mimecast-MFC-AGG-ID: 2KUhWYAUMqiq-7lQvQURqA_1760169918
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3cbee9769fso330296766b.3
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 01:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760169918; x=1760774718;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2LjMu1SmBW0Il/Ad5mkR+kmEwLtrYj43T8cQppTZxI=;
 b=L9wuhYe+Di1oCkRLy9BAKdx8sAzLbVWtfPi6sVPPzEoS7/mLJrFgBt51GyRo6D9+vu
 r6QqqToEFOemMKWeSWymXyy+kkXO9NZTIWSwZGEsXJwyj8P7VF/9KX99Blkkv4ITOw2w
 3fKDXwsIh6Pj+dIblUcdFVMU/MmQh+pAeOtZKCQolR+mKdWXBgRB60sNyeSTEp4Y4yQM
 TGdbK4y1Z5PGQhYkSB8trdG8htOZbCONKVF9bn+gQHPJXw4b1fD82wRRDPjJTvHCWKTf
 NyZpKeZWTZ5Uyzk4NUM4UGuAqDMrFy5EolckAIwKYKolTI8aV2sW5LbM9kVByPHddKpd
 AG/w==
X-Gm-Message-State: AOJu0YzWKhde802d1SAvKmEpgEnTxheU4kaaDbWVXz5IDLgEx+EbzY1b
 h/3/m233mC/VTRf6G8Z1Ddt9qj+MBKSz8Gk0nejRv1Z90Fl4NznYCt09p0P8MaolVC/qOWP448q
 KWXZEsyTCUaZNkmLQ/yntKtgMmEUBK0QdnGz0ENz2qAoUCEaJcj4+52XxqcJ7U94K3YveGfRpgM
 D8CHxroBE7pJuZe56GZNW6srEDVBAbnMY=
X-Gm-Gg: ASbGncvzJQHl9IXa/XOrDSsZYJOGONPM48hxhgOR6sAxWsITzQNb2fYRxjDcia0Sl63
 7QqgVijQ1OBwq1MpVow7JxmSN/e1gLPhAUkp/tM0Z9H51rUnuf0yZC/mHv5p566Ix97Gyfn82wq
 6xSrjCPKMQoL8gYPfePLWnNg==
X-Received: by 2002:a17:907:7ea6:b0:b3f:a16d:da7b with SMTP id
 a640c23a62f3a-b50aa393bf8mr1491209466b.8.1760169918185; 
 Sat, 11 Oct 2025 01:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE3DyyiMDaaMTBg3JoQbRijruVINFfLcc173mHEsJip29dDI1C5WEjLBpdu++FotS9yq9T+mFf4vy6pyxKH1c=
X-Received: by 2002:a17:907:7ea6:b0:b3f:a16d:da7b with SMTP id
 a640c23a62f3a-b50aa393bf8mr1491206166b.8.1760169917752; Sat, 11 Oct 2025
 01:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20251010134226.72221-1-philmd@linaro.org>
 <20251010134226.72221-9-philmd@linaro.org>
 <781a3494-453e-47ea-ab10-48d0f5315f4f@linux.ibm.com>
In-Reply-To: <781a3494-453e-47ea-ab10-48d0f5315f4f@linux.ibm.com>
From: Lei Yang <leiyang@redhat.com>
Date: Sat, 11 Oct 2025 16:04:41 +0800
X-Gm-Features: AS18NWCycbECoPyr2kFT74R6nWLh2fUh6yKnVk1kvhSdqRWs7AAghWVGIfWo-wI
Message-ID: <CAPpAL=zqm5NqdC7Zeb0x5W-exK2TkeNJ_Qd0RWAAwFb4RZVA2g@mail.gmail.com>
Subject: Re: [PATCH 08/16] hw/virtio: Replace HOST_BIG_ENDIAN #ifdef with
 runtime if() check
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Farhan Ali <alifm@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Philippe Mathieu-Daud=C3=A9

According to my test result this change introduced a minor bug, qemu
output error messages "qemu-system-x86_64: virtio-blk missing headers"
reproduced command:
/usr/local/bin/qemu-system-x86_64 -M q35 -m 8G -smp 8 -cpu host
-enable-kvm -device VGA,bus=3Dpcie.0,addr=3D0x2 -drive
file=3D///home/fedora-40.qcow2,media=3Ddisk,if=3Dvirtio -device
virtio-net-pci,mac=3D00:11:22:33:44:00,netdev=3Dnetdev1,id=3Dnet1,bus=3Dpci=
e.0,addr=3D0x7
 -netdev tap,id=3Dnetdev1,script=3D/etc/qemu-ifup,downscript=3D/etc/qemu-if=
down
-vnc :0  -monitor stdio
QEMU 10.1.50 monitor - type 'help' for more information
(qemu) qemu-system-x86_64: virtio-blk missing headers

Thanks
Lei

On Sat, Oct 11, 2025 at 3:25=E2=80=AFAM Farhan Ali <alifm@linux.ibm.com> wr=
ote:
>
>
> On 10/10/2025 6:42 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Replace compile-time #ifdef with a runtime check to ensure all code
> > paths are built and tested. This reduces build-time configuration
> > complexity and improves maintainability.
> >
> > No functional change intended.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   include/hw/virtio/virtio-access.h | 6 +-----
> >   hw/virtio/vhost.c                 | 7 +++----
> >   2 files changed, 4 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virt=
io-access.h
> > index 07aae69042a..80328912ad3 100644
> > --- a/include/hw/virtio/virtio-access.h
> > +++ b/include/hw/virtio/virtio-access.h
> > @@ -149,11 +149,7 @@ static inline uint64_t virtio_ldq_p(VirtIODevice *=
vdev, const void *ptr)
> >
> >   static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t s)
> >   {
> > -#if HOST_BIG_ENDIAN
> > -    return virtio_access_is_big_endian(vdev) ? s : bswap16(s);
> > -#else
> > -    return virtio_access_is_big_endian(vdev) ? bswap16(s) : s;
> > -#endif
> > +    return HOST_BIG_ENDIAN ^ virtio_access_is_big_endian(vdev) ? s : b=
swap16(s);
>
> This patch breaks virtio devices(at least input/net devices) on s390x. I
> am not sure if ^ is the right check here? Changing the logic back to how
> it was fixes it for me.
>
> Thanks
>
> Farhan
>
> >   }
> >
> >   static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 266a11514a1..6343477b42f 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -1168,11 +1168,10 @@ static inline bool vhost_needs_vring_endian(Vir=
tIODevice *vdev)
> >       if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> >           return false;
> >       }
> > -#if HOST_BIG_ENDIAN
> > -    return vdev->device_endian =3D=3D VIRTIO_DEVICE_ENDIAN_LITTLE;
> > -#else
> > +    if (HOST_BIG_ENDIAN) {
> > +        return vdev->device_endian =3D=3D VIRTIO_DEVICE_ENDIAN_LITTLE;
> > +    }
> >       return vdev->device_endian =3D=3D VIRTIO_DEVICE_ENDIAN_BIG;
> > -#endif
> >   }
> >
> >   static int vhost_virtqueue_set_vring_endian_legacy(struct vhost_dev *=
dev,
>


