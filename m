Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97084C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 07:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0GNM-0006bN-H2; Fri, 26 Apr 2024 03:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1s0GNJ-0006af-MY
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 03:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1s0GNH-0006IL-DQ
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 03:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714117921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y7YfO62PO3plVyaHClYh3rvnH/44rk6LEMpI3tdtSkw=;
 b=izy80mrHxOl2uOeAfnzwfIQiZhEFgaUGaL9rPtFlLrjjAlCUiiwtc5TppdVWcnsJLYfSyi
 2VaXS6kQT4/mvih+aaPr+pXMn+0P6JUW2dfYgj6WP/UWbtwSbOGGBvZia6VNNXdkQjDm0r
 WjUhzIonkvUfW2wG61g+86nWKfVldkA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-tOkQLRB0MkWXLdWAjBgKLA-1; Fri, 26 Apr 2024 03:50:34 -0400
X-MC-Unique: tOkQLRB0MkWXLdWAjBgKLA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d865b3b04cso11017061fa.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 00:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714117833; x=1714722633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y7YfO62PO3plVyaHClYh3rvnH/44rk6LEMpI3tdtSkw=;
 b=fRMEN2uuWJDoJCurJ6sNpuTh878Jh8MJJ/6J+w/430hYAWJdEfSXPImkV2EGd9cLLL
 viqGLBThA1azyn3Rgz/g2GqmefOAAAyGn8XirJGYGhk5jp/TUp0yt0PSJP0Uhq4bnjCc
 WlK6dPfJ7VZKE+tEjxW9J9augDQHAatIJKrpeuKKE7Q94c17ourAQ9gMgyEcz2dCDeUE
 xsd10nda+5uolppkCvuxwsvs+XWM3P/ln7gxgc2fbEhL3BFY3rCojE8dnP6XcJnPERCh
 7WuOHClW4joiM416yAaXScWcttRkoJJLlP5mP/NfXpwrmw6Ok3WN77YHyNz6Gw9uqRs3
 d6ZA==
X-Gm-Message-State: AOJu0YyfCXeK8ipceQ6dfw4F15h8CHtDSFDazIQIwGVBk+ZDntb17xSk
 xZ4Tc9sPJdcDcNH5vCNrQy0mRSWyPWiYHYs2Vzw41EUcrbIjC9PpSz7UchL0Gekju6bFpkkyURP
 Vqf1LQfEY/0bD7ZyLfRu04i7TnNdR3hZimc5g0MnBeDjFmTaO1TxYSBdUFCcb4hIeBoWV5VpIZO
 ZbZdvF9T2t4E0olAgYapbmq0ZvsJo=
X-Received: by 2002:a2e:a995:0:b0:2df:3f04:396a with SMTP id
 x21-20020a2ea995000000b002df3f04396amr731983ljq.6.1714117832882; 
 Fri, 26 Apr 2024 00:50:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHshZb8wKQSlSCsGC7A8HSrCct5GxrOXNrdG/5uvph6R9HtJ9SUQYimTMX2BgkIqhfe8oJBW7piE6SXoiuAWk=
X-Received: by 2002:a2e:a995:0:b0:2df:3f04:396a with SMTP id
 x21-20020a2ea995000000b002df3f04396amr731972ljq.6.1714117832512; Fri, 26 Apr
 2024 00:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240416141426.588544-1-david@redhat.com>
In-Reply-To: <20240416141426.588544-1-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Fri, 26 Apr 2024 09:50:21 +0200
Message-ID: <CAMXpfWuPJb_LGwFt5uU5QOZ3nyP2CY_694eK1vyBo21RWLZQYA@mail.gmail.com>
Subject: Re: [PATCH v1] virtio-mem: improve error message when unplug of
 device fails due to plugged memory
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Liang Cong <lcong@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

This patch has been successfully tested. Boot up a VM with a
virtio-mem device, hotplug some memory increasing the requested-size,
finally try to unplug the device and see the new message:
(qemu) device_del vmem0
Error: virtio-mem device cannot get unplugged while some of its memory
is still plugged

Tested-by: Mario Casquero <mcasquer@redhat.com>


On Tue, Apr 16, 2024 at 4:14=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> The error message is actually expressive, considering QEMU only. But
> when called from Libvirt, talking about "size" can be confusing, because
> in Libvirt "size" translates to the memory backend size in QEMU (maximum
> size) and "current" translates to the QEMU "size" property.
>
> Let's simply avoid talking about the "size" property and spell out that
> some device memory is still plugged.
>
> Cc: Liang Cong <lcong@redhat.com>
> Cc: Mario Casquero <mcasquer@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-mem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index ffd119ebac..ef64bf1b4a 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -1832,8 +1832,8 @@ static void virtio_mem_unplug_request_check(VirtIOM=
EM *vmem, Error **errp)
>      }
>
>      if (vmem->size) {
> -        error_setg(errp, "virtio-mem device cannot get unplugged while"
> -                   " '" VIRTIO_MEM_SIZE_PROP "' !=3D '0'");
> +        error_setg(errp, "virtio-mem device cannot get unplugged while s=
ome"
> +                   " of its memory is still plugged");
>          return;
>      }
>      if (vmem->requested_size) {
> --
> 2.44.0
>


