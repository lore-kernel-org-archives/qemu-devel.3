Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7088C54E66
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 03:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkybH-0000i9-0E; Thu, 14 Mar 2024 23:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkybF-0000hu-7k
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkybA-0000rc-DY
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710474670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTUJ63Ff/LIQRV+2sxLg6+1LbvZzmyCqap2ksTZlA+g=;
 b=Sr5Eu4QGJgvoUEPu1b5IdsDNv48tEd3KshWBxz3zypShUQ32DK2FSnghezI0ZCVg3aLmsv
 dKMESwhHpstcvtJfv4gzq2B5ZsD4yWugBA6DlzG54TckcVNz1vF3cdKXw8dYlagzXm6zmo
 k/0WazD20g/sZSqedrukV5QuJCKqcwI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-AdhiyG2sNh6Txvi0YhVd9g-1; Thu, 14 Mar 2024 23:51:08 -0400
X-MC-Unique: AdhiyG2sNh6Txvi0YhVd9g-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5cfc2041cdfso1321807a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 20:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710474667; x=1711079467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTUJ63Ff/LIQRV+2sxLg6+1LbvZzmyCqap2ksTZlA+g=;
 b=T2BiuIeRhl51ZoJ0gV8LRsqvp3oYlD+1K4/4VJwe8+QF3v5eiIXc8wQxpwMCZ0dITF
 hKWGEoEy2+Pv5sdlwr+k8ylo2nuv50nZEYfTeznpt4TlYeNkNj0SNoiwNkwleMfaiWpf
 k2zaOhER7N0wEYvj9V18vxGZ7NPQkyiTtyRkopHr6KgUEqleWw8XaCOFh1llzUYlBm38
 YSp8juZWeY/SeOOm1Xwa8RO0bLpvD/A767/O/F59LIZF4Fs1ogWpVI/VrWEMZYFzt+a/
 0AWxsbMemVMTCy0Wkf57LpOlm/es8ayxrEjau5o1s9oQUS164ZMyzDO5R2nP19QNb8Jv
 yfrA==
X-Gm-Message-State: AOJu0Yz2IIJlaWsJ6Ccn439hOoZ+VHDU4KASFHfDVDhpG08weoi+dphD
 lQzIAyshqxt6LI0IfFHOyc0mFjDepIE5hxY+K13yNkMdFihUQUmT4SCH6XrzjR92A1ivNY5Xjuz
 AJZd+vytbRXRB3Zz2e0XFu664yAoPZI5Fp6RbnA4+MFH5FUawhFvr97PNQlPQ7nIxbTFWafyEA9
 uPA1kVF+bAMdDlfEgDqvbQn6Dkzns=
X-Received: by 2002:a05:6a20:7f87:b0:1a3:3db3:48c4 with SMTP id
 d7-20020a056a207f8700b001a33db348c4mr2334233pzj.18.1710474666948; 
 Thu, 14 Mar 2024 20:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCPtBeyu1ZCKtqbTEH3Uq75yBtC4e4oJ8HjzL6MDwYKQ7xcx/kadlqnekQN7dEoxeaO1PMBSX2F3Wt0jJuitg=
X-Received: by 2002:a05:6a20:7f87:b0:1a3:3db3:48c4 with SMTP id
 d7-20020a056a207f8700b001a33db348c4mr2334223pzj.18.1710474666628; Thu, 14 Mar
 2024 20:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Mar 2024 11:50:55 +0800
Message-ID: <CACGkMEt2-naXvHjCcPyQAoSfto44OVaSUqPtg_gvS8-wrhNwZA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] vhost: dirty log should be per backend type
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com, 
 joao.m.martins@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 15, 2024 at 5:39=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> There could be a mix of both vhost-user and vhost-kernel clients
> in the same QEMU process, where separate vhost loggers for the
> specific vhost type have to be used. Make the vhost logger per
> backend type, and have them properly reference counted.

It's better to describe what's the advantage of doing this.

>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>
> ---
> v3->v4:
>   - remove checking NULL return value from vhost_log_get
>
> v2->v3:
>   - remove non-effective assertion that never be reached
>   - do not return NULL from vhost_log_get()
>   - add neccessary assertions to vhost_log_get()
> ---
>  hw/virtio/vhost.c | 45 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 2c9ac79..612f4db 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -43,8 +43,8 @@
>      do { } while (0)
>  #endif
>
> -static struct vhost_log *vhost_log;
> -static struct vhost_log *vhost_log_shm;
> +static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
> +static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>
>  /* Memslots used by backends that support private memslots (without an f=
d). */
>  static unsigned int used_memslots;
> @@ -287,6 +287,10 @@ static int vhost_set_backend_type(struct vhost_dev *=
dev,
>          r =3D -1;
>      }
>
> +    if (r =3D=3D 0) {
> +        assert(dev->vhost_ops->backend_type =3D=3D backend_type);
> +    }
> +

Under which condition could we hit this? It seems not good to assert a
local logic.

Thanks


