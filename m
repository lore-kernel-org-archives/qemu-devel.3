Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2E4C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsFT-0000YZ-5m; Tue, 11 Aug 2026 15:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtsFN-0000YG-KT
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtsFL-00054r-OA
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786476886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h5jYfm+CvxMRA0ENZWb6+tfU6DID4sCV4Eg1pb1rb2I=;
 b=UZXoHh1uyeUH0/HMr0lCXwWjqwmvdonX1d38jOVmAJMCXI9vMJvQHt3OwSMtNj9qA7JktC
 WFlzbSuwRJUuQ2WZObnKhxdXj2/VKsXUL3P89M6JvCZ/iBzxtshvfkQhixo+zVKUB/2pja
 viYWSuBIrIqg2H5dgRQsJAoiktwOIc8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-t7T9jvUtOzazw_Qgtq9jig-1; Tue,
 11 Aug 2026 15:34:44 -0400
X-MC-Unique: t7T9jvUtOzazw_Qgtq9jig-1
X-Mimecast-MFC-AGG-ID: t7T9jvUtOzazw_Qgtq9jig_1786476883
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3E961800145; Tue, 11 Aug 2026 19:34:43 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA8281800347; Tue, 11 Aug 2026 19:34:42 +0000 (UTC)
Date: Tue, 11 Aug 2026 15:34:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V11 05/15] block/export: track IOThread references
Message-ID: <20260811193440.GD170741@fedora>
References: <20260806202531.243806-1-zhangckid@gmail.com>
 <20260806202531.243806-6-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pBOWDeEFaOLauAZ5"
Content-Disposition: inline
In-Reply-To: <20260806202531.243806-6-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--pBOWDeEFaOLauAZ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2026 at 04:25:14AM +0800, Zhang Chen wrote:
> Track the IOThreads used by a block export and identify the holder
> with the unique BlockExportOptions id.
>=20
> Acquire holder-aware references during export creation and release
> them on error or export deletion.  Support both single- and
> multi-iothread exports.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  block/export/export.c  | 79 +++++++++++++++++++++++++++++++++++++-----
>  include/block/export.h |  6 ++++
>  2 files changed, 76 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/export/export.c b/block/export/export.c
> index b733f269f3..96d719418e 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c
> @@ -15,7 +15,6 @@
> =20
>  #include "block/block.h"
>  #include "system/block-backend.h"
> -#include "system/iothread.h"
>  #include "block/export.h"
>  #include "block/fuse.h"
>  #include "block/nbd.h"
> @@ -85,6 +84,8 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Er=
ror **errp)
>      AioContext *ctx;
>      AioContext **multithread_ctxs =3D NULL;
>      size_t multithread_count =3D 0;
> +    g_autofree IOThread **local_iothreads =3D NULL;
> +    const char *holder_id =3D NULL;
>      uint64_t perm;
>      int ret;
> =20
> @@ -139,7 +140,16 @@ BlockExport *blk_exp_add(BlockExportOptions *export,=
 Error **errp)
>              goto fail;
>          }
> =20
> -        new_ctx =3D iothread_get_aio_context(iothread);
> +        holder_id =3D export->id;
> +        const IOThreadHolder holder =3D {
> +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
> +            .u.block_export.export_id =3D (char *)holder_id,

Is this char * cast necessary since the holder variable is declared
const?

> +        };
> +
> +        new_ctx =3D iothread_ref_and_get_aio_context(iothread, &holder);
> +        multithread_count =3D 1;
> +        local_iothreads =3D g_new0(IOThread *, 1);
> +        local_iothreads[0] =3D iothread;
> =20
>          /* Ignore errors with fixed-iothread=3Dfalse */
>          set_context_errp =3D fixed_iothread ? errp : NULL;
> @@ -163,8 +173,15 @@ BlockExport *blk_exp_add(BlockExportOptions *export,=
 Error **errp)
>              return NULL;
>          }
> =20
> +        local_iothreads =3D g_new0(IOThread *, multithread_count);
>          multithread_ctxs =3D g_new(AioContext *, multithread_count);
>          i =3D 0;
> +        holder_id =3D export->id;
> +        const IOThreadHolder holder =3D {
> +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
> +            .u.block_export.export_id =3D (char *)holder_id,

Same here.

> +        };
> +
>          for (strList *e =3D iothread_list; e; e =3D e->next) {
>              IOThread *iothread =3D iothread_by_id(e->value);
> =20
> @@ -172,7 +189,9 @@ BlockExport *blk_exp_add(BlockExportOptions *export, =
Error **errp)
>                  error_setg(errp, "iothread \"%s\" not found", e->value);
>                  goto fail;
>              }
> -            multithread_ctxs[i++] =3D iothread_get_aio_context(iothread);
> +            local_iothreads[i] =3D iothread;
> +            multithread_ctxs[i++] =3D iothread_ref_and_get_aio_context(i=
othread,
> +                                                                     &ho=
lder);
>          }
>          assert(i =3D=3D multithread_count);
>      }
> @@ -225,12 +244,15 @@ BlockExport *blk_exp_add(BlockExportOptions *export=
, Error **errp)
>      assert(drv->instance_size >=3D sizeof(BlockExport));
>      exp =3D g_malloc0(drv->instance_size);
>      *exp =3D (BlockExport) {
> -        .drv        =3D drv,
> -        .refcount   =3D 1,
> -        .user_owned =3D true,
> -        .id         =3D g_strdup(export->id),
> -        .ctx        =3D ctx,
> -        .blk        =3D blk,
> +        .drv                  =3D drv,
> +        .refcount             =3D 1,
> +        .user_owned           =3D true,
> +        .id                   =3D g_strdup(export->id),
> +        .ctx                  =3D ctx,
> +        .blk                  =3D blk,
> +        .iothreads            =3D g_steal_pointer(&local_iothreads),
> +        .iothread_count       =3D multithread_count,
> +        .iothread_holder_id   =3D g_strdup(holder_id),
>      };
> =20
>      ret =3D drv->create(exp, export, multithread_ctxs, multithread_count=
, errp);
> @@ -250,8 +272,32 @@ fail:
>          blk_unref(blk);
>      }
>      if (exp) {
> +        if (exp->iothreads) {
> +            const IOThreadHolder holder =3D {
> +                .type =3D IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
> +                .u.block_export.export_id =3D exp->iothread_holder_id,
> +            };
> +            for (size_t j =3D 0; j < exp->iothread_count; j++) {
> +                if (exp->iothreads[j]) {
> +                    iothread_put_aio_context(exp->iothreads[j], &holder);
> +                }
> +            }
> +            g_free(exp->iothreads);
> +        }
> +        g_free(exp->iothread_holder_id);
>          g_free(exp->id);
>          g_free(exp);
> +    } else if (local_iothreads) {
> +        const IOThreadHolder holder =3D {
> +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
> +            .u.block_export.export_id =3D (char *)holder_id,

Same here.

> +        };
> +
> +        for (size_t j =3D 0; j < multithread_count; j++) {
> +            if (local_iothreads[j]) {
> +                iothread_put_aio_context(local_iothreads[j], &holder);
> +            }
> +        }
>      }
>      g_free(multithread_ctxs);
>      return NULL;
> @@ -269,10 +315,25 @@ static void blk_exp_delete_bh(void *opaque)
>      BlockExport *exp =3D opaque;
> =20
>      assert(exp->refcount =3D=3D 0);
> +
>      QLIST_REMOVE(exp, next);
>      exp->drv->delete(exp);
>      blk_set_dev_ops(exp->blk, NULL, NULL);
>      blk_unref(exp->blk);
> +
> +    if (exp->iothreads) {
> +        const IOThreadHolder holder =3D {
> +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
> +            .u.block_export.export_id =3D exp->iothread_holder_id,
> +        };
> +
> +        for (size_t i =3D 0; i < exp->iothread_count; i++) {
> +            iothread_put_aio_context(exp->iothreads[i], &holder);
> +        }
> +        g_free(exp->iothreads);
> +    }
> +
> +    g_free(exp->iothread_holder_id);
>      qapi_event_send_block_export_deleted(exp->id);
>      g_free(exp->id);
>      g_free(exp);
> diff --git a/include/block/export.h b/include/block/export.h
> index ca45da928c..a093dea0b6 100644
> --- a/include/block/export.h
> +++ b/include/block/export.h
> @@ -16,6 +16,7 @@
> =20
>  #include "qapi/qapi-types-block-export.h"
>  #include "qemu/queue.h"
> +#include "system/iothread.h"
> =20
>  typedef struct BlockExport BlockExport;
> =20
> @@ -89,6 +90,11 @@ struct BlockExport {
> =20
>      /* List entry for block_exports */
>      QLIST_ENTRY(BlockExport) next;
> +
> +    /* The IOThreads utilized by this specific block export */
> +    IOThread **iothreads;
> +    size_t iothread_count;
> +    char *iothread_holder_id;
>  };
> =20
>  BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
> --=20
> 2.53.0
>=20

--pBOWDeEFaOLauAZ5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmp7eVAACgkQnKSrs4Gr
c8ihDAf7BNFxb4EwB1Jzr3Xz4dh0x0k4HZQZL7l8FWWeNdFiMnmtl9MQaBuyXquI
pMqeAatF0DRXRjhQRn+qzeNwcTknZE6H3iXXjaLey9Fym6hNKmt8PobYBBfx6HmC
z7gKaFaUPpn6mJ9UEBUM/UzI+p/T12j6SaPD53pbT9cGUaBUllc62Wa8/cxVVcKw
kbfvZAO9T/nqZtWvVgBz8LZK/mjAkZC7exJwr5qQ61kZ4+yp4rZ9RDOmC29PoWve
lRbd5R3W3l6LOXVb3DZ/h7kwfbPJcVsY3jB4JkNlQW+G4Z7wbnaTT0GJ8X7KhzhW
DaGO3KnXhzVMDcaG1d1OJptnNixESA==
=CU6q
-----END PGP SIGNATURE-----

--pBOWDeEFaOLauAZ5--


