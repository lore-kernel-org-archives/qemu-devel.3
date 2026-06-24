Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B82CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 18:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcSPR-0006aB-Of; Wed, 24 Jun 2026 14:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcSPP-0006Zd-PK
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 14:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcSPN-0007Iu-9W
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 14:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782325988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BhAaGi2O/ml/0vWRXVr/H6enpI4cbmj2iJWkmTNYa1Q=;
 b=eQX8MqrU0ObWpLgnTJHYMLKumaBn+fpuC4EFYE+xJZ3AukoMV6MxARBjIU8TVe7T9N55Qp
 kxeV225AgA4DjWVuD5DYS+byE0FRhTp5JsZ0rOX1c7J3EwRO7Kyz6++Nr8tx91Tb2GO1EH
 ipeQ9JCu/l27EY1q0hDKXbXUykFEblM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-S1tge47AMmWS3ghwvP51rg-1; Wed,
 24 Jun 2026 14:33:06 -0400
X-MC-Unique: S1tge47AMmWS3ghwvP51rg-1
X-Mimecast-MFC-AGG-ID: S1tge47AMmWS3ghwvP51rg_1782325985
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DED81956041; Wed, 24 Jun 2026 18:33:05 +0000 (UTC)
Received: from localhost (unknown [10.2.17.97])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C8241956041; Wed, 24 Jun 2026 18:33:04 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:51:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH V9 05/17] block/export: track IOThread reference in
 BlockExport
Message-ID: <20260624175143.GD109308@fedora>
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-6-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="li1ZLVn/mkTC3rMs"
Content-Disposition: inline
In-Reply-To: <20260624070851.13342-6-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--li1ZLVn/mkTC3rMs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 03:08:39PM +0800, Zhang Chen wrote:
> Users currently lack visibility into which block exports
> are utilizing specific IOThreads. This patch integrates IOThread
> referencing into the BlockExport lifecycle.
>=20
> - Add iothreads array and holder_name to BlockExport struct.
> - Use iothread_ref_and_get_aio_context during export creation.
> - Implement proper cleanup in blk_exp_add fail path and blk_exp_delete_bh.
> - Support both single and multi-iothread export configurations.
>=20
> This ensures IOThread 'holders' status correctly reflects active block
> exports for better debugging and resource tracking.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  block/export/export.c  | 63 ++++++++++++++++++++++++++++++++++++------
>  include/block/export.h |  6 ++++
>  2 files changed, 60 insertions(+), 9 deletions(-)

If AI was used to generate this patch series, please see QEMU's AI
policy:
https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-gener=
ated-content

This feels like AI generated code in that it is verbose and has lots of
structure (e.g. commit messages that look like an AI summary of the code
change), but the details are not correct (misleading comments, leaks,
etc).

I will pause my review at this patch and wait for your response.

>=20
> diff --git a/block/export/export.c b/block/export/export.c
> index b733f269f3..b6c07f69b5 100644
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
> +    const char *holder_name =3D NULL;
>      uint64_t perm;
>      int ret;
> =20
> @@ -139,7 +140,16 @@ BlockExport *blk_exp_add(BlockExportOptions *export,=
 Error **errp)
>              goto fail;
>          }
> =20
> -        new_ctx =3D iothread_get_aio_context(iothread);
> +        holder_name =3D bdrv_get_node_name(bs);
> +        IOThreadHolder holder =3D {
> +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_NODE,

This is not a block node, this is a block export (a separate type of
object). Reporting the export as a node is confusing because users will
not know which block export id is assigned using this IOThread, they
will only know the block node (which could be doing other things too).

> +            .u.block_node.node_name =3D (char *)holder_name,

To remove the suspicious-looking const cast, try:

  const IOThreadHolder holder =3D {
      .type =3D ...,
      .u.block_node.node_name =3D holder_name,
  };

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
> +        holder_name =3D bdrv_get_node_name(bs);
> +        IOThreadHolder holder =3D {
> +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_NODE,
> +            .u.block_node.node_name =3D (char *)holder_name,
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
> +        .iothread_holder_name =3D g_strdup(holder_name),
>      };
> =20
>      ret =3D drv->create(exp, export, multithread_ctxs, multithread_count=
, errp);
> @@ -253,6 +275,18 @@ fail:
>          g_free(exp->id);
>          g_free(exp);
>      }
> +    if (local_iothreads) {

This doesn't handle the drv->create() goto fail code path where
g_steal_pointer(&local_iothreads) has moved the pointer into exp.
local_iothreads will be leaked.

iothread_holder_name will also be leaked (it should be handled like
g_free(exp->id) above).

> +        IOThreadHolder holder =3D {
> +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_NODE,
> +            .u.block_node.node_name =3D (char *)holder_name,
> +        };
> +
> +        for (size_t j =3D 0; j < multithread_count; j++) {
> +            if (local_iothreads[j]) {
> +                iothread_put_aio_context(local_iothreads[j], &holder);
> +            }
> +        }
> +    }
>      g_free(multithread_ctxs);
>      return NULL;
>  }
> @@ -269,6 +303,17 @@ static void blk_exp_delete_bh(void *opaque)
>      BlockExport *exp =3D opaque;
> =20
>      assert(exp->refcount =3D=3D 0);
> +    if (exp->iothreads) {
> +        IOThreadHolder holder =3D {
> +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_NODE,
> +            .u.block_node.node_name =3D (char *)exp->iothread_holder_nam=
e,
> +        };
> +
> +        for (size_t i =3D 0; i < exp->iothread_count; i++) {
> +            iothread_put_aio_context(exp->iothreads[i], &holder);
> +        }
> +        g_free(exp->iothreads);
> +    }

iothread_holder_name is leaked.

>      QLIST_REMOVE(exp, next);
>      exp->drv->delete(exp);

iothread_put_aio_context() must be moved after ->delete() since exports
may still need to do some AioContext cleanup (e.g.
vduse_blk_detach_ctx()).

>      blk_set_dev_ops(exp->blk, NULL, NULL);
> diff --git a/include/block/export.h b/include/block/export.h
> index ca45da928c..2bb98aae31 100644
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
> +    /* The iothreads list for block_exports */

This comment is confusing: block_export is the global list of
BlockExports. This iothreads[] array is not for block_exports, it's for
this specific BlockExport only.

> +    IOThread **iothreads;
> +    size_t iothread_count;
> +    char *iothread_holder_name;
>  };
> =20
>  BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
> --=20
> 2.49.0
>=20

--li1ZLVn/mkTC3rMs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo8GS8ACgkQnKSrs4Gr
c8hTKQf/cLi5HeM59zcbdBiYbIyPq4FCKELRyDpoYBRXOw82JoOBdC1z6FP6Ev83
n29coa+53MjXyLWchrT7J8L73le+Gx7S2psD5ba7haTLbG9E0nJVlTqBTVN7ENvw
ORQlj0tcZ+Ikrs+MWW1l+/H1CXKb3kg4MAtb69G7W5tlriTbXBnDZwG54iV1fuHG
VOMEUZEVqP0nMSUjv4KUO0bDD+tV4JQzMcSK/V9ed3kp8WYGFW2M/lST4+rLgvpk
RL49qugpYUgsQeEDrjurMSR9BnXfKojChQy1ht7mQKINYItXyVlItGb0VDp2oadm
BGyvWZwgfD2eqNIpziEQI2XIHOevUg==
=WaCI
-----END PGP SIGNATURE-----

--li1ZLVn/mkTC3rMs--


