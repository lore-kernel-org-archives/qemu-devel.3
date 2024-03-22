Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A77C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 10:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rncSX-0007Yt-HB; Fri, 22 Mar 2024 06:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rncSJ-0007Or-Co
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rncSG-0004FD-Qj
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711104536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MAN1EYJQkPaJyw8u+zCNoGpDsR1Jprwp5JVYuSLRjA8=;
 b=JX6akIOiIJLrVNSi53QX6088K0MUiqMM+e88gyOYuZI4wE7mkr5dSBvOChZlU0LqZas9Kl
 fwarlvrwyxcJoRjQL/qRa1VwloUPVpCneWeNoJJAvOOn1hppL4G8XhlE5JW/aC3ApsC4sc
 70VsfoE5RyXufaa+dpWSw0dtbLR865Q=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-toG3Yk3xMgqEjdQ3NTehzA-1; Fri, 22 Mar 2024 06:48:54 -0400
X-MC-Unique: toG3Yk3xMgqEjdQ3NTehzA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dcc58cddb50so2987373276.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 03:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711104534; x=1711709334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MAN1EYJQkPaJyw8u+zCNoGpDsR1Jprwp5JVYuSLRjA8=;
 b=XKLj+Lks+jnwOktZGGiUijwG7vntSE9vWT9BIfxyubZ5iuWeDSshohX+HkffkyAwrm
 8ZJ+UZhgMrEPMndfOgcOkalpsupUMpmM3ygRBLE1i98PCWoFIn6eESc9RYiyy+MGGJ7O
 ByFuH7Pvy+zR8XzdRvpSA6CubDXShqW66DAPEIUQD8xnX9m04MCZDUDzMzM2fdkP5ATO
 xxP2tIcxptK8ReEQEN4Fj5Ef1hSc704UOnh8eRpA1Saz2LvGk1Krp8EVQ2QboMCOlzGt
 fZEJKjxErlw/pCJC8Lo2fe965PGLs4lLG3l2VIxOgwZI3GxVxg6QCJm6Pjud+Y5ImHlb
 YVfw==
X-Gm-Message-State: AOJu0YyfdpOyC6Mp19U3yyww8Vu/H+VFBEqy/66W2cWNPi4SPkfQv+V9
 y4/IevRbTFhxX21aQnBUf8QDK/3KIHJ0CiuQFpWc8cWVWyXgOT+CA62yNZZVRRfeU2beD+vrJvf
 GCMW+R+HzDIgtW4yIJagi6qEd44RDIBjM8oHBH1E0mPQy78/OtUotN4yiBlrES1FhqN8wI26A7Z
 eHHipTznRWOJHJf1G3GZMhAmSQj0I=
X-Received: by 2002:a25:e015:0:b0:dc7:1ab6:6aca with SMTP id
 x21-20020a25e015000000b00dc71ab66acamr1523368ybg.63.1711104533936; 
 Fri, 22 Mar 2024 03:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENOTcSDqu6/rHbyyQbijhEsp8Y3Ytsxm0+NcuNuka+ggLItlGf0d6HEyqJ8s/Z7y53Aiq5FnSqKmugHdYUhMM=
X-Received: by 2002:a25:e015:0:b0:dc7:1ab6:6aca with SMTP id
 x21-20020a25e015000000b00dc71ab66acamr1523358ybg.63.1711104533717; Fri, 22
 Mar 2024 03:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240321155717.1392787-1-jonah.palmer@oracle.com>
 <20240321155717.1392787-9-jonah.palmer@oracle.com>
In-Reply-To: <20240321155717.1392787-9-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 22 Mar 2024 11:48:17 +0100
Message-ID: <CAJaqyWf=_7EPKdr81JTfk0s3OAaL5ZXTkRpzvjWac66uWyt7_g@mail.gmail.com>
Subject: Re: [RFC 8/8] virtio: Add VIRTIO_F_IN_ORDER property definition
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org, 
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

On Thu, Mar 21, 2024 at 4:57=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Extend the virtio device property definitions to include the
> VIRTIO_F_IN_ORDER feature.
>
> The default state of this feature is disabled, allowing it to be
> explicitly enabled where it's supported.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  include/hw/virtio/virtio.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index eeeda397a9..ffd78830a3 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -400,7 +400,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
>      DEFINE_PROP_BIT64("packed", _state, _field, \
>                        VIRTIO_F_RING_PACKED, false), \
>      DEFINE_PROP_BIT64("queue_reset", _state, _field, \
> -                      VIRTIO_F_RING_RESET, true)
> +                      VIRTIO_F_RING_RESET, true), \
> +    DEFINE_PROP_BIT64("in_order", _state, _field, \
> +                      VIRTIO_F_IN_ORDER, false)
>
>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
>  bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
> --
> 2.39.3
>


