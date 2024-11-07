Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98252D43352
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 13:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t92Uz-0003mz-JH; Thu, 07 Nov 2024 08:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1t92Uw-0003fj-Q9
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:24:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1t92Uu-00035d-Ge
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730985867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HaE3QGiJli1D5kDAJzi3Y1tqb60XoykLNIdW6XHDiVs=;
 b=ZKN14YW+5yFxa8BLcDn41RCpiZFYRzUTomD7ptI25v67Rdps+KQBo9GSXiYQW2TF8zUwau
 vza+wDIVbVds7VyBUYnwMIB5cm70PaEns7KdZgCpAXJB/XBlnqA84QQjHZjXMOhK5zytnU
 berWnggXJRh2V/g4EUM8erCnxxr0IEE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-8-wGp3v1OL6nN9e30o4ugA-1; Thu, 07 Nov 2024 08:24:25 -0500
X-MC-Unique: 8-wGp3v1OL6nN9e30o4ugA-1
X-Mimecast-MFC-AGG-ID: 8-wGp3v1OL6nN9e30o4ugA
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230fcso1017157a91.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 05:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730985864; x=1731590664;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HaE3QGiJli1D5kDAJzi3Y1tqb60XoykLNIdW6XHDiVs=;
 b=ij+znXi1n1a8y9OsoWX34fGQ3kwvikACLUbQHfL4KKp2bK7haPCsFrvaBZivywP/y8
 dswFTg9Dwzb7CtXQHzISG24jAyTo6e/8Ipf+/n+Su4beqUCDIkUWFj9xzFMDPemuHCv0
 RdDvk7bLTH5NuEbeOuKoFNp9TorTOD+xr8GKglPCaslv4GGtwj5BgDJcYTWfybOa7KEU
 t0E7YotE/ahZzYAaHzufmsUUrdWRSPy2g4e+nlIt7ZSkpPI6syyEtzia0HwOXL8n/Xop
 FdcSc0pN5ZEoe/E/n8d2ftFqzk4h5SFotHkWtn1I1b0mygy30/IS3PMTegMdNunFwcbh
 zgmQ==
X-Gm-Message-State: AOJu0YwvmzEZbxvLvkQcOCryTakh5B89Ng0i3ZPWDXnT+7BY7hnalivO
 PYtypVFjRQ+autsmNztbBPs2+5QZjwBLkw7x9/G/KpDPsiwMmFngOSf+kHCdtrtGaa6TKrmy6oL
 QZBcEp2QnC8k+Gj/WYf9d0H9Vn0PwL97BFeuqfwmUPT09fPUe+L3mcYkVZOmEeKfPkm1e/GxH++
 k74kpM/BL8rwv046mhARZswTsIZJY=
X-Received: by 2002:a17:90b:4c48:b0:2db:2939:d9c0 with SMTP id
 98e67ed59e1d1-2e9aaffa373mr1264694a91.2.1730985864545; 
 Thu, 07 Nov 2024 05:24:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsDQkEs/xW8ibQAfSUohgVXKmgTlDrKcTWhHR1ZphtKT0eSes1W3ipnL7lW3c6rsLlbD76c+6pu07gV6j+U9k=
X-Received: by 2002:a17:90b:4c48:b0:2db:2939:d9c0 with SMTP id
 98e67ed59e1d1-2e9aaffa373mr1264677a91.2.1730985864276; Thu, 07 Nov 2024
 05:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20241107125201.1640759-1-dbassey@redhat.com>
In-Reply-To: <20241107125201.1640759-1-dbassey@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 7 Nov 2024 14:24:13 +0100
Message-ID: <CADSE00KWV9zkAw4kdqMZt3ikLDgvwANvpkdKGDmw3Qxh_qxB5g@mail.gmail.com>
Subject: Re: [PATCH] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Nov 7, 2024 at 1:52=E2=80=AFPM Dorinda Bassey <dbassey@redhat.com> =
wrote:
>
> In `virtio_add_resource` function, the UUID used as a key for
> `g_hash_table_insert` was temporary, which could lead to
> invalid lookups when accessed later. This patch ensures that
> the UUID remains valid by duplicating it into a newly allocated
> memory space (persistent_uuid). The value is then inserted into
> the hash table with this persistent UUID key to ensure that the
> key stored in the hash table remains valid as long as the hash
> table entry exists.
>
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> ---
>  hw/display/virtio-dmabuf.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> index 3dba4577ca7..4353970bc87 100644
> --- a/hw/display/virtio-dmabuf.c
> +++ b/hw/display/virtio-dmabuf.c
> @@ -39,7 +39,12 @@ static bool virtio_add_resource(QemuUUID *uuid, Virtio=
SharedObject *value)
>                                                 g_free);
>      }
>      if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NULL) {
> -        g_hash_table_insert(resource_uuids, uuid, value);
> +        QemuUUID *persistent_uuid =3D g_memdup2(uuid, sizeof(QemuUUID));
> +        if (persistent_uuid =3D=3D NULL) {
> +            result =3D false;
> +        } else {
> +            g_hash_table_insert(resource_uuids, persistent_uuid, value);
> +        }

Reviewed-by: Albert Esteve <aesteve@redhat.com>

The description of `virtio_add_*` functions in the header state:

"""
* Return: true if the UUID did not exist and the resource has been added,
* false if another resource with the same UUID already existed.
"""

I think it may be worth clarifying that it can also return false if
the resource failed
to be added.


>      } else {
>          result =3D false;
>      }
> --
> 2.47.0
>


