Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D373C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 16:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcp1H-0006tj-T4; Wed, 21 Feb 2024 11:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1rcp1E-0006t7-8B
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:00:24 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1rcp19-0006JP-Uj
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:00:23 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512bce554a5so4030551e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 08:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708531218; x=1709136018; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rjvWc/3QHVSr2HC3mWDoRK7o/zHxm8KNdUqhH+F/E+A=;
 b=SUh620NbRIzYtgOdLKkDtzpJi25y8qAp9xR6/8Lz0k+3YXrA576rQ4HyFg6nxQlrfF
 jyGttfnXcKTYH7FGvYNtBfDoVEsxxJ82Wl/fed891kZ30B0cbaiEiShC+w5TJxVwx7R4
 N99mGndKGROwjP/jhEaKTa1wmC6yOOMcRn57P8Ydo2YjtkfkqnYDQLDKI/bgYz9upVRq
 9Sk7ZW6WenNTkao6aauacS2HyXTNCt/WHNDq4gn1efcK9EdlBq0HLv74jrbqmcFGuoX7
 ZZ+3Lys3c2CueQn2c3uXqO9TWLFIz1rcWp11AhYreCelfWYB7Wu0fZU01aBpTXois8oz
 vdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708531218; x=1709136018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rjvWc/3QHVSr2HC3mWDoRK7o/zHxm8KNdUqhH+F/E+A=;
 b=rpALVd1OdlFVOIhCyu3j+6cXU4+RGIKm3uHTLXtt0Fwm21gw5koZJpP79vTCN8ca57
 r4+61oCNzzKSdzCYj0aeZj+MUzMxDVqysQpG2w0LweA48Xh0M/R1sdqi/ITFAtiA5sqQ
 BrGyF538OakT4qBLP7njb2PyLA69xncbDBoGOtCZiJfoGoPzvGXh8hD9xm4Bb2Ju7jIx
 PbRrU/8p+f3ZDzWkodcBrSbhfMDoKq60RRrEYELOq1l4IWwAr46/1BmyFw2bvJco6MJC
 4ycspe/okuXPhXg2u2uVOvZAANmv+cnQA/GUyeDgLG72Ns+5ys4o7WV1Mt4EJry5ux6Y
 g8/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAENdqvo/SlmtOVTJMiK4Qggf686hodCiUy/U4dSm8vfv2prUKAIrM7rNmmQM9zHGGPgq+M6yyxdQVZWrfc2NPJCKG/n4=
X-Gm-Message-State: AOJu0YzRLiPa6ciHoUJqUaE2pRT21Vx+Cm0yfNlBo8WSvxnLXGwp5Vnj
 vsZz6vZyATGqW/S1iOAUh6A6wFs4+3GxycnIFG6ZgIHxVIKDZgmW/uIB24fGwpKv4uEanGaMbdh
 1QnxbB9CQRcQ6TWT4WTdaGiGu8vo=
X-Google-Smtp-Source: AGHT+IEXV0Fj1V8zWNVOVYySP/vwE1aDwi86OA610D9dGKGJ5kJMmWO3lTyBvKS9zGuLFv9iT7yv5WAowi/+OdggMQI=
X-Received: by 2002:ac2:5f50:0:b0:512:bc13:5ff0 with SMTP id
 16-20020ac25f50000000b00512bc135ff0mr4805516lfz.50.1708531217668; Wed, 21 Feb
 2024 08:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-4-hao.xiang@bytedance.com>
In-Reply-To: <20240216224002.1476890-4-hao.xiang@bytedance.com>
From: Elena Ufimtseva <ufimtseva@gmail.com>
Date: Wed, 21 Feb 2024 08:00:05 -0800
Message-ID: <CAEr7rXj93Ng2zA9aM=MXgu7Pke2YJHjYHeao08L4jT2isZ53ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] migration/multifd: Zero page transmission on the
 multifd thread.
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, 
 jdenemar@redhat.com
Content-Type: multipart/alternative; boundary="000000000000511d230611e66cf9"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=ufimtseva@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000511d230611e66cf9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 2:42=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.com>=
 wrote:

> 1. Implements the zero page detection and handling on the multifd
> threads for non-compression, zlib and zstd compression backends.
> 2. Added a new value 'multifd' in ZeroPageDetection enumeration.
> 3. Add proper asserts to ensure pages->normal are used for normal pages
> in all scenarios.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  migration/meson.build         |  1 +
>  migration/multifd-zero-page.c | 59 +++++++++++++++++++++++++++++++++++
>  migration/multifd-zlib.c      | 26 ++++++++++++---
>  migration/multifd-zstd.c      | 25 ++++++++++++---
>  migration/multifd.c           | 50 +++++++++++++++++++++++------
>  migration/multifd.h           |  7 +++++
>  qapi/migration.json           |  4 ++-
>  7 files changed, 151 insertions(+), 21 deletions(-)
>  create mode 100644 migration/multifd-zero-page.c
>
> diff --git a/migration/meson.build b/migration/meson.build
> index 92b1cc4297..1eeb915ff6 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -22,6 +22,7 @@ system_ss.add(files(
>    'migration.c',
>    'multifd.c',
>    'multifd-zlib.c',
> +  'multifd-zero-page.c',
>    'ram-compress.c',
>    'options.c',
>    'postcopy-ram.c',
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.=
c
> new file mode 100644
> index 0000000000..f0cd8e2c53
> --- /dev/null
> +++ b/migration/multifd-zero-page.c
> @@ -0,0 +1,59 @@
> +/*
> + * Multifd zero page detection implementation.
> + *
> + * Copyright (c) 2024 Bytedance Inc
> + *
> + * Authors:
> + *  Hao Xiang <hao.xiang@bytedance.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "exec/ramblock.h"
> +#include "migration.h"
> +#include "multifd.h"
> +#include "options.h"
> +#include "ram.h"
> +
> +void multifd_zero_page_check_send(MultiFDSendParams *p)
> +{
> +    /*
> +     * QEMU older than 9.0 don't understand zero page
> +     * on multifd channel. This switch is required to
> +     * maintain backward compatibility.
> +     */
> +    bool use_multifd_zero_page =3D
> +        (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_MULTIF=
D);
> +    MultiFDPages_t *pages =3D p->pages;
> +    RAMBlock *rb =3D pages->block;
> +
> +    assert(pages->num !=3D 0);
>

Not needed, the check is done right before calling send_prepare.


> +    assert(pages->normal_num =3D=3D 0);
> +    assert(pages->zero_num =3D=3D 0);
>

Why these asserts are needed?

> +
>
+    for (int i =3D 0; i < pages->num; i++) {
> +        uint64_t offset =3D pages->offset[i];
> +        if (use_multifd_zero_page &&
> +            buffer_is_zero(rb->host + offset, p->page_size)) {
> +            pages->zero[pages->zero_num] =3D offset;
> +            pages->zero_num++;
> +            ram_release_page(rb->idstr, offset);
> +        } else {
> +            pages->normal[pages->normal_num] =3D offset;
> +            pages->normal_num++;
> +        }
> +    }
> +}
> +
> +void multifd_zero_page_check_recv(MultiFDRecvParams *p)
> +{
> +    for (int i =3D 0; i < p->zero_num; i++) {
> +        void *page =3D p->host + p->zero[i];
> +        if (!buffer_is_zero(page, p->page_size)) {
> +            memset(page, 0, p->page_size);
> +        }
> +    }
> +}
> diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> index 012e3bdea1..cdfe0fa70e 100644
> --- a/migration/multifd-zlib.c
> +++ b/migration/multifd-zlib.c
> @@ -123,13 +123,20 @@ static int zlib_send_prepare(MultiFDSendParams *p,
> Error **errp)
>      int ret;
>      uint32_t i;
>
> +    multifd_zero_page_check_send(p);
> +
> +    if (!pages->normal_num) {
> +        p->next_packet_size =3D 0;
> +        goto out;
> +    }
> +
>      multifd_send_prepare_header(p);
>
> -    for (i =3D 0; i < pages->num; i++) {
> +    for (i =3D 0; i < pages->normal_num; i++) {
>          uint32_t available =3D z->zbuff_len - out_size;
>          int flush =3D Z_NO_FLUSH;
>
> -        if (i =3D=3D pages->num - 1) {
> +        if (i =3D=3D pages->normal_num - 1) {
>              flush =3D Z_SYNC_FLUSH;
>          }
>
> @@ -138,7 +145,7 @@ static int zlib_send_prepare(MultiFDSendParams *p,
> Error **errp)
>           * with compression. zlib does not guarantee that this is safe,
>           * therefore copy the page before calling deflate().
>           */
> -        memcpy(z->buf, p->pages->block->host + pages->offset[i],
> p->page_size);
> +        memcpy(z->buf, p->pages->block->host + pages->normal[i],
> p->page_size);
>          zs->avail_in =3D p->page_size;
>          zs->next_in =3D z->buf;
>
> @@ -172,10 +179,10 @@ static int zlib_send_prepare(MultiFDSendParams *p,
> Error **errp)
>      p->iov[p->iovs_num].iov_len =3D out_size;
>      p->iovs_num++;
>      p->next_packet_size =3D out_size;
> -    p->flags |=3D MULTIFD_FLAG_ZLIB;
>
> +out:
> +    p->flags |=3D MULTIFD_FLAG_ZLIB;
>      multifd_send_fill_packet(p);
> -
>
Spurious?

     return 0;
>  }
>
> @@ -261,6 +268,14 @@ static int zlib_recv_pages(MultiFDRecvParams *p,
> Error **errp)
>                     p->id, flags, MULTIFD_FLAG_ZLIB);
>          return -1;
>      }
> +
> +    multifd_zero_page_check_recv(p);
> +
> +    if (!p->normal_num) {
> +        assert(in_size =3D=3D 0);
> +        return 0;
>

return here will have no effect. Also, why is assert needed here?
This change also does not seem to fit the description of the patch, probaby
separate patch will be better.


> +    }
> +
>      ret =3D qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp);
>
>      if (ret !=3D 0) {
> @@ -310,6 +325,7 @@ static int zlib_recv_pages(MultiFDRecvParams *p, Erro=
r
> **errp)
>                     p->id, out_size, expected_size);
>          return -1;
>      }
> +
>      return 0;
>  }
>
> diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> index dc8fe43e94..27a1eba075 100644
> --- a/migration/multifd-zstd.c
> +++ b/migration/multifd-zstd.c
> @@ -118,19 +118,26 @@ static int zstd_send_prepare(MultiFDSendParams *p,
> Error **errp)
>      int ret;
>      uint32_t i;
>
> +    multifd_zero_page_check_send(p);
> +
> +    if (!pages->normal_num) {
> +        p->next_packet_size =3D 0;
> +        goto out;
> +    }
> +
>      multifd_send_prepare_header(p);
>
>      z->out.dst =3D z->zbuff;
>      z->out.size =3D z->zbuff_len;
>      z->out.pos =3D 0;
>
> -    for (i =3D 0; i < pages->num; i++) {
> +    for (i =3D 0; i < pages->normal_num; i++) {
>          ZSTD_EndDirective flush =3D ZSTD_e_continue;
>
> -        if (i =3D=3D pages->num - 1) {
> +        if (i =3D=3D pages->normal_num - 1) {
>              flush =3D ZSTD_e_flush;
>          }
> -        z->in.src =3D p->pages->block->host + pages->offset[i];
> +        z->in.src =3D p->pages->block->host + pages->normal[i];
>          z->in.size =3D p->page_size;
>          z->in.pos =3D 0;
>
> @@ -161,10 +168,10 @@ static int zstd_send_prepare(MultiFDSendParams *p,
> Error **errp)
>      p->iov[p->iovs_num].iov_len =3D z->out.pos;
>      p->iovs_num++;
>      p->next_packet_size =3D z->out.pos;
> -    p->flags |=3D MULTIFD_FLAG_ZSTD;
>
> +out:
> +    p->flags |=3D MULTIFD_FLAG_ZSTD;
>      multifd_send_fill_packet(p);
> -
>
Spurious removal.


>      return 0;
>  }
>
> @@ -257,6 +264,14 @@ static int zstd_recv_pages(MultiFDRecvParams *p,
> Error **errp)
>                     p->id, flags, MULTIFD_FLAG_ZSTD);
>          return -1;
>      }
> +
> +    multifd_zero_page_check_recv(p);
> +
> +    if (!p->normal_num) {
> +        assert(in_size =3D=3D 0);
> +        return 0;
> +    }
> +
>
Same question here about assert.


>      ret =3D qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp);
>
>      if (ret !=3D 0) {
> diff --git a/migration/multifd.c b/migration/multifd.c
> index a33dba40d9..fbb40ea10b 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -11,6 +11,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qemu/rcu.h"
>  #include "exec/target_page.h"
>  #include "sysemu/sysemu.h"
> @@ -126,6 +127,8 @@ static int nocomp_send_prepare(MultiFDSendParams *p,
> Error **errp)
>      MultiFDPages_t *pages =3D p->pages;
>      int ret;
>
> +    multifd_zero_page_check_send(p);
> +
>      if (!use_zero_copy_send) {
>          /*
>           * Only !zerocopy needs the header in IOV; zerocopy will
> @@ -134,13 +137,13 @@ static int nocomp_send_prepare(MultiFDSendParams *p=
,
> Error **errp)
>          multifd_send_prepare_header(p);
>      }
>
> -    for (int i =3D 0; i < pages->num; i++) {
> -        p->iov[p->iovs_num].iov_base =3D pages->block->host +
> pages->offset[i];
> +    for (int i =3D 0; i < pages->normal_num; i++) {
> +        p->iov[p->iovs_num].iov_base =3D pages->block->host +
> pages->normal[i];
>          p->iov[p->iovs_num].iov_len =3D p->page_size;
>          p->iovs_num++;
>      }
>
> -    p->next_packet_size =3D pages->num * p->page_size;
> +    p->next_packet_size =3D pages->normal_num * p->page_size;
>      p->flags |=3D MULTIFD_FLAG_NOCOMP;
>
>      multifd_send_fill_packet(p);
> @@ -202,6 +205,13 @@ static int nocomp_recv_pages(MultiFDRecvParams *p,
> Error **errp)
>                     p->id, flags, MULTIFD_FLAG_NOCOMP);
>          return -1;
>      }
> +
> +    multifd_zero_page_check_recv(p);
> +
> +    if (!p->normal_num) {
> +        return 0;
> +    }
> +
>      for (int i =3D 0; i < p->normal_num; i++) {
>          p->iov[i].iov_base =3D p->host + p->normal[i];
>          p->iov[i].iov_len =3D p->page_size;
> @@ -339,7 +349,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>
>      packet->flags =3D cpu_to_be32(p->flags);
>      packet->pages_alloc =3D cpu_to_be32(p->pages->allocated);
> -    packet->normal_pages =3D cpu_to_be32(pages->num);
> +    packet->normal_pages =3D cpu_to_be32(pages->normal_num);
>      packet->zero_pages =3D cpu_to_be32(pages->zero_num);
>      packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
>
> @@ -350,18 +360,25 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>          strncpy(packet->ramblock, pages->block->idstr, 256);
>      }
>
> -    for (i =3D 0; i < pages->num; i++) {
> +    for (i =3D 0; i < pages->normal_num; i++) {
>          /* there are architectures where ram_addr_t is 32 bit */
> -        uint64_t temp =3D pages->offset[i];
> +        uint64_t temp =3D pages->normal[i];
>
>          packet->offset[i] =3D cpu_to_be64(temp);
>      }
>
> +    for (i =3D 0; i < pages->zero_num; i++) {
> +        /* there are architectures where ram_addr_t is 32 bit */
> +        uint64_t temp =3D pages->zero[i];
> +
> +        packet->offset[pages->normal_num + i] =3D cpu_to_be64(temp);
> +    }
> +
>      p->packets_sent++;
> -    p->total_normal_pages +=3D pages->num;
> +    p->total_normal_pages +=3D pages->normal_num;
>      p->total_zero_pages +=3D pages->zero_num;
>
> -    trace_multifd_send(p->id, packet_num, pages->num, pages->zero_num,
> +    trace_multifd_send(p->id, packet_num, pages->normal_num,
> pages->zero_num,
>                         p->flags, p->next_packet_size);
>  }
>
> @@ -451,6 +468,18 @@ static int
> multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>          p->normal[i] =3D offset;
>      }
>
> +    for (i =3D 0; i < p->zero_num; i++) {
> +        uint64_t offset =3D be64_to_cpu(packet->offset[p->normal_num + i=
]);
> +
> +        if (offset > (p->block->used_length - p->page_size)) {
> +            error_setg(errp, "multifd: offset too long %" PRIu64
> +                       " (max " RAM_ADDR_FMT ")",
> +                       offset, p->block->used_length);
> +            return -1;
> +        }
> +        p->zero[i] =3D offset;
> +    }
> +
>      return 0;
>  }
>
> @@ -842,7 +871,7 @@ static void *multifd_send_thread(void *opaque)
>
>              stat64_add(&mig_stats.multifd_bytes,
>                         p->next_packet_size + p->packet_len);
> -            stat64_add(&mig_stats.normal_pages, pages->num);
> +            stat64_add(&mig_stats.normal_pages, pages->normal_num);
>              stat64_add(&mig_stats.zero_pages, pages->zero_num);
>
>              multifd_pages_reset(p->pages);
> @@ -1256,7 +1285,8 @@ static void *multifd_recv_thread(void *opaque)
>          p->flags &=3D ~MULTIFD_FLAG_SYNC;
>          qemu_mutex_unlock(&p->mutex);
>
> -        if (p->normal_num) {
> +        if (p->normal_num + p->zero_num) {
> +            assert(!(flags & MULTIFD_FLAG_SYNC));
>
This assertion seems to be not relevant to this patch. Could you post it
separately and explain why it's needed here?


>              ret =3D multifd_recv_state->ops->recv_pages(p, &local_err);
>              if (ret !=3D 0) {
>                  break;
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 9822ff298a..125f0bbe60 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -53,6 +53,11 @@ typedef struct {
>      uint32_t unused32[1];    /* Reserved for future use */
>      uint64_t unused64[3];    /* Reserved for future use */
>      char ramblock[256];
> +    /*
> +     * This array contains the pointers to:
> +     *  - normal pages (initial normal_pages entries)
> +     *  - zero pages (following zero_pages entries)
> +     */
>      uint64_t offset[];
>  } __attribute__((packed)) MultiFDPacket_t;
>
> @@ -224,6 +229,8 @@ typedef struct {
>
>  void multifd_register_ops(int method, MultiFDMethods *ops);
>  void multifd_send_fill_packet(MultiFDSendParams *p);
> +void multifd_zero_page_check_send(MultiFDSendParams *p);
> +void multifd_zero_page_check_recv(MultiFDRecvParams *p);
>
>  static inline void multifd_send_prepare_header(MultiFDSendParams *p)
>  {
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 99843a8e95..e2450b92d4 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -660,9 +660,11 @@
>  #
>  # @none: Do not perform zero page checking.
>  #
> +# @multifd: Perform zero page checking on the multifd sender thread.
> (since 9.0)
> +#
>  ##
>  { 'enum': 'ZeroPageDetection',
> -  'data': [ 'legacy', 'none' ] }
> +  'data': [ 'legacy', 'none', 'multifd' ] }
>
>  ##
>  # @BitmapMigrationBitmapAliasTransform:
> --
> 2.30.2
>
>
>

--=20
Elena

--000000000000511d230611e66cf9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 16, 2024 at 2:42=E2=80=AF=
PM Hao Xiang &lt;<a href=3D"mailto:hao.xiang@bytedance.com">hao.xiang@byted=
ance.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">1. Implements the zero page detection and handling on the multifd<b=
r>
threads for non-compression, zlib and zstd compression backends.<br>
2. Added a new value &#39;multifd&#39; in ZeroPageDetection enumeration.<br=
>
3. Add proper asserts to ensure pages-&gt;normal are used for normal pages<=
br>
in all scenarios.<br>
<br>
Signed-off-by: Hao Xiang &lt;<a href=3D"mailto:hao.xiang@bytedance.com" tar=
get=3D"_blank">hao.xiang@bytedance.com</a>&gt;<br>
---<br>
=C2=A0migration/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br=
>
=C2=A0migration/multifd-zero-page.c | 59 ++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0migration/multifd-zlib.c=C2=A0 =C2=A0 =C2=A0 | 26 ++++++++++++---<br>
=C2=A0migration/multifd-zstd.c=C2=A0 =C2=A0 =C2=A0 | 25 ++++++++++++---<br>
=C2=A0migration/multifd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 50 ++++=
+++++++++++++++++++------<br>
=C2=A0migration/multifd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7=
 +++++<br>
=C2=A0qapi/migration.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4=
 ++-<br>
=C2=A07 files changed, 151 insertions(+), 21 deletions(-)<br>
=C2=A0create mode 100644 migration/multifd-zero-page.c<br>
<br>
diff --git a/migration/meson.build b/migration/meson.build<br>
index 92b1cc4297..1eeb915ff6 100644<br>
--- a/migration/meson.build<br>
+++ b/migration/meson.build<br>
@@ -22,6 +22,7 @@ system_ss.add(files(<br>
=C2=A0 =C2=A0&#39;migration.c&#39;,<br>
=C2=A0 =C2=A0&#39;multifd.c&#39;,<br>
=C2=A0 =C2=A0&#39;multifd-zlib.c&#39;,<br>
+=C2=A0 &#39;multifd-zero-page.c&#39;,<br>
=C2=A0 =C2=A0&#39;ram-compress.c&#39;,<br>
=C2=A0 =C2=A0&#39;options.c&#39;,<br>
=C2=A0 =C2=A0&#39;postcopy-ram.c&#39;,<br>
diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c<=
br>
new file mode 100644<br>
index 0000000000..f0cd8e2c53<br>
--- /dev/null<br>
+++ b/migration/multifd-zero-page.c<br>
@@ -0,0 +1,59 @@<br>
+/*<br>
+ * Multifd zero page detection implementation.<br>
+ *<br>
+ * Copyright (c) 2024 Bytedance Inc<br>
+ *<br>
+ * Authors:<br>
+ *=C2=A0 Hao Xiang &lt;<a href=3D"mailto:hao.xiang@bytedance.com" target=
=3D"_blank">hao.xiang@bytedance.com</a>&gt;<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
+ * See the COPYING file in the top-level directory.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/cutils.h&quot;<br>
+#include &quot;exec/ramblock.h&quot;<br>
+#include &quot;migration.h&quot;<br>
+#include &quot;multifd.h&quot;<br>
+#include &quot;options.h&quot;<br>
+#include &quot;ram.h&quot;<br>
+<br>
+void multifd_zero_page_check_send(MultiFDSendParams *p)<br>
+{<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* QEMU older than 9.0 don&#39;t understand zero page<b=
r>
+=C2=A0 =C2=A0 =C2=A0* on multifd channel. This switch is required to<br>
+=C2=A0 =C2=A0 =C2=A0* maintain backward compatibility.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 bool use_multifd_zero_page =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (migrate_zero_page_detection() =3D=3D ZERO_PAG=
E_DETECTION_MULTIFD);<br>
+=C2=A0 =C2=A0 MultiFDPages_t *pages =3D p-&gt;pages;<br>
+=C2=A0 =C2=A0 RAMBlock *rb =3D pages-&gt;block;<br>
+<br>
+=C2=A0 =C2=A0 assert(pages-&gt;num !=3D 0);<br></blockquote><div><br></div=
><div>Not needed, the check is done right before calling send_prepare.</div=
><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 assert(pages-&gt;normal_num =3D=3D 0);<br>
+=C2=A0 =C2=A0 assert(pages-&gt;zero_num =3D=3D 0);<br></blockquote><div>=
=C2=A0</div><div>Why these asserts are needed?<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+ <br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; pages-&gt;num; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t offset =3D pages-&gt;offset[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (use_multifd_zero_page &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_is_zero(rb-&gt;host + off=
set, p-&gt;page_size)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pages-&gt;zero[pages-&gt;zero_nu=
m] =3D offset;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pages-&gt;zero_num++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_release_page(rb-&gt;idstr, o=
ffset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pages-&gt;normal[pages-&gt;norma=
l_num] =3D offset;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pages-&gt;normal_num++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+void multifd_zero_page_check_recv(MultiFDRecvParams *p)<br>
+{<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; p-&gt;zero_num; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *page =3D p-&gt;host + p-&gt;zero[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!buffer_is_zero(page, p-&gt;page_size)) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(page, 0, p-&gt;page_size)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c<br>
index 012e3bdea1..cdfe0fa70e 100644<br>
--- a/migration/multifd-zlib.c<br>
+++ b/migration/multifd-zlib.c<br>
@@ -123,13 +123,20 @@ static int zlib_send_prepare(MultiFDSendParams *p, Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t i;<br>
<br>
+=C2=A0 =C2=A0 multifd_zero_page_check_send(p);<br>
+<br>
+=C2=A0 =C2=A0 if (!pages-&gt;normal_num) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;next_packet_size =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0multifd_send_prepare_header(p);<br>
<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; pages-&gt;num; i++) {<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; pages-&gt;normal_num; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t available =3D z-&gt;zbuff_len - =
out_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flush =3D Z_NO_FLUSH;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D pages-&gt;num - 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D pages-&gt;normal_num - 1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flush =3D Z_SYNC_FLUSH;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -138,7 +145,7 @@ static int zlib_send_prepare(MultiFDSendParams *p, Erro=
r **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * with compression. zlib does not guaran=
tee that this is safe,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * therefore copy the page before calling=
 deflate().<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(z-&gt;buf, p-&gt;pages-&gt;block-&gt;ho=
st + pages-&gt;offset[i], p-&gt;page_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(z-&gt;buf, p-&gt;pages-&gt;block-&gt;ho=
st + pages-&gt;normal[i], p-&gt;page_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zs-&gt;avail_in =3D p-&gt;page_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zs-&gt;next_in =3D z-&gt;buf;<br>
<br>
@@ -172,10 +179,10 @@ static int zlib_send_prepare(MultiFDSendParams *p, Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;iov[p-&gt;iovs_num].iov_len =3D out_size;<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;iovs_num++;<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;next_packet_size =3D out_size;<br>
-=C2=A0 =C2=A0 p-&gt;flags |=3D MULTIFD_FLAG_ZLIB;<br>
<br>
+out:<br>
+=C2=A0 =C2=A0 p-&gt;flags |=3D MULTIFD_FLAG_ZLIB;<br>
=C2=A0 =C2=A0 =C2=A0multifd_send_fill_packet(p);<br>
-<br></blockquote><div></div><div>Spurious?</div><div><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
@@ -261,6 +268,14 @@ static int zlib_recv_pages(MultiFDRecvParams *p, Error=
 **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt=
;id, flags, MULTIFD_FLAG_ZLIB);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 multifd_zero_page_check_recv(p);<br>
+<br>
+=C2=A0 =C2=A0 if (!p-&gt;normal_num) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(in_size =3D=3D 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br></blockquote><div><br></div><div>=
return here will have no effect. Also, why is assert needed here?</div><div=
>This change also does not seem to fit the description of the patch, probab=
y separate patch will be better.<br></div><div>=C2=A0<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0ret =3D qio_channel_read_all(p-&gt;c, (void *)z-&gt;zbu=
ff, in_size, errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ret !=3D 0) {<br>
@@ -310,6 +325,7 @@ static int zlib_recv_pages(MultiFDRecvParams *p, Error =
**errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt=
;id, out_size, expected_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c<br>
index dc8fe43e94..27a1eba075 100644<br>
--- a/migration/multifd-zstd.c<br>
+++ b/migration/multifd-zstd.c<br>
@@ -118,19 +118,26 @@ static int zstd_send_prepare(MultiFDSendParams *p, Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t i;<br>
<br>
+=C2=A0 =C2=A0 multifd_zero_page_check_send(p);<br>
+<br>
+=C2=A0 =C2=A0 if (!pages-&gt;normal_num) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;next_packet_size =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0multifd_send_prepare_header(p);<br>
<br>
=C2=A0 =C2=A0 =C2=A0z-&gt;out.dst =3D z-&gt;zbuff;<br>
=C2=A0 =C2=A0 =C2=A0z-&gt;out.size =3D z-&gt;zbuff_len;<br>
=C2=A0 =C2=A0 =C2=A0z-&gt;out.pos =3D 0;<br>
<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; pages-&gt;num; i++) {<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; pages-&gt;normal_num; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ZSTD_EndDirective flush =3D ZSTD_e_contin=
ue;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D pages-&gt;num - 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D pages-&gt;normal_num - 1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flush =3D ZSTD_e_flush;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 z-&gt;in.src =3D p-&gt;pages-&gt;block-&gt;hos=
t + pages-&gt;offset[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 z-&gt;in.src =3D p-&gt;pages-&gt;block-&gt;hos=
t + pages-&gt;normal[i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0z-&gt;in.size =3D p-&gt;page_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0z-&gt;in.pos =3D 0;<br>
<br>
@@ -161,10 +168,10 @@ static int zstd_send_prepare(MultiFDSendParams *p, Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;iov[p-&gt;iovs_num].iov_len =3D z-&gt;out.pos;<br=
>
=C2=A0 =C2=A0 =C2=A0p-&gt;iovs_num++;<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;next_packet_size =3D z-&gt;out.pos;<br>
-=C2=A0 =C2=A0 p-&gt;flags |=3D MULTIFD_FLAG_ZSTD;<br>
<br>
+out:<br>
+=C2=A0 =C2=A0 p-&gt;flags |=3D MULTIFD_FLAG_ZSTD;<br>
=C2=A0 =C2=A0 =C2=A0multifd_send_fill_packet(p);<br>
-<br></blockquote><div>Spurious removal.</div><div>=C2=A0<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
@@ -257,6 +264,14 @@ static int zstd_recv_pages(MultiFDRecvParams *p, Error=
 **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt=
;id, flags, MULTIFD_FLAG_ZSTD);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 multifd_zero_page_check_recv(p);<br>
+<br>
+=C2=A0 =C2=A0 if (!p-&gt;normal_num) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(in_size =3D=3D 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br></blockquote><div>Same question here about assert.</div><div>=C2=A0<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0ret =3D qio_channel_read_all(p-&gt;c, (void *)z-&gt;zbu=
ff, in_size, errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ret !=3D 0) {<br>
diff --git a/migration/multifd.c b/migration/multifd.c<br>
index a33dba40d9..fbb40ea10b 100644<br>
--- a/migration/multifd.c<br>
+++ b/migration/multifd.c<br>
@@ -11,6 +11,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/rcu.h&quot;<br>
=C2=A0#include &quot;exec/target_page.h&quot;<br>
=C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
@@ -126,6 +127,8 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0MultiFDPages_t *pages =3D p-&gt;pages;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
+=C2=A0 =C2=A0 multifd_zero_page_check_send(p);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (!use_zero_copy_send) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Only !zerocopy needs the header in IOV=
; zerocopy will<br>
@@ -134,13 +137,13 @@ static int nocomp_send_prepare(MultiFDSendParams *p, =
Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0multifd_send_prepare_header(p);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 for (int i =3D 0; i &lt; pages-&gt;num; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;iov[p-&gt;iovs_num].iov_base =3D pages-&=
gt;block-&gt;host + pages-&gt;offset[i];<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; pages-&gt;normal_num; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;iov[p-&gt;iovs_num].iov_base =3D pages-&=
gt;block-&gt;host + pages-&gt;normal[i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;iov[p-&gt;iovs_num].iov_len =3D p-&=
gt;page_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;iovs_num++;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 p-&gt;next_packet_size =3D pages-&gt;num * p-&gt;page_size;<=
br>
+=C2=A0 =C2=A0 p-&gt;next_packet_size =3D pages-&gt;normal_num * p-&gt;page=
_size;<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;flags |=3D MULTIFD_FLAG_NOCOMP;<br>
<br>
=C2=A0 =C2=A0 =C2=A0multifd_send_fill_packet(p);<br>
@@ -202,6 +205,13 @@ static int nocomp_recv_pages(MultiFDRecvParams *p, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt=
;id, flags, MULTIFD_FLAG_NOCOMP);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 multifd_zero_page_check_recv(p);<br>
+<br>
+=C2=A0 =C2=A0 if (!p-&gt;normal_num) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; p-&gt;normal_num; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;iov[i].iov_base =3D p-&gt;host + p-=
&gt;normal[i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;iov[i].iov_len =3D p-&gt;page_size;=
<br>
@@ -339,7 +349,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)<br>
<br>
=C2=A0 =C2=A0 =C2=A0packet-&gt;flags =3D cpu_to_be32(p-&gt;flags);<br>
=C2=A0 =C2=A0 =C2=A0packet-&gt;pages_alloc =3D cpu_to_be32(p-&gt;pages-&gt;=
allocated);<br>
-=C2=A0 =C2=A0 packet-&gt;normal_pages =3D cpu_to_be32(pages-&gt;num);<br>
+=C2=A0 =C2=A0 packet-&gt;normal_pages =3D cpu_to_be32(pages-&gt;normal_num=
);<br>
=C2=A0 =C2=A0 =C2=A0packet-&gt;zero_pages =3D cpu_to_be32(pages-&gt;zero_nu=
m);<br>
=C2=A0 =C2=A0 =C2=A0packet-&gt;next_packet_size =3D cpu_to_be32(p-&gt;next_=
packet_size);<br>
<br>
@@ -350,18 +360,25 @@ void multifd_send_fill_packet(MultiFDSendParams *p)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncpy(packet-&gt;ramblock, pages-&gt;bl=
ock-&gt;idstr, 256);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; pages-&gt;num; i++) {<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; pages-&gt;normal_num; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* there are architectures where ram_addr=
_t is 32 bit */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t temp =3D pages-&gt;offset[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t temp =3D pages-&gt;normal[i];<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packet-&gt;offset[i] =3D cpu_to_be64(temp=
);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; pages-&gt;zero_num; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* there are architectures where ram_addr_t is=
 32 bit */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t temp =3D pages-&gt;zero[i];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet-&gt;offset[pages-&gt;normal_num + i] =
=3D cpu_to_be64(temp);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;packets_sent++;<br>
-=C2=A0 =C2=A0 p-&gt;total_normal_pages +=3D pages-&gt;num;<br>
+=C2=A0 =C2=A0 p-&gt;total_normal_pages +=3D pages-&gt;normal_num;<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;total_zero_pages +=3D pages-&gt;zero_num;<br>
<br>
-=C2=A0 =C2=A0 trace_multifd_send(p-&gt;id, packet_num, pages-&gt;num, page=
s-&gt;zero_num,<br>
+=C2=A0 =C2=A0 trace_multifd_send(p-&gt;id, packet_num, pages-&gt;normal_nu=
m, pages-&gt;zero_num,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 p-&gt;flags, p-&gt;next_packet_size);<br>
=C2=A0}<br>
<br>
@@ -451,6 +468,18 @@ static int multifd_recv_unfill_packet(MultiFDRecvParam=
s *p, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;normal[i] =3D offset;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; p-&gt;zero_num; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t offset =3D be64_to_cpu(packet-&gt;off=
set[p-&gt;normal_num + i]);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (offset &gt; (p-&gt;block-&gt;used_length -=
 p-&gt;page_size)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;multifd: =
offset too long %&quot; PRIu64<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot; (max &quot; RAM_ADDR_FMT &quot;)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0offset, p-&gt;block-&gt;used_length);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;zero[i] =3D offset;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
@@ -842,7 +871,7 @@ static void *multifd_send_thread(void *opaque)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stat64_add(&amp;mig_stats.m=
ultifd_bytes,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 p-&gt;next_packet_size + p-&gt;packet_len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat64_add(&amp;mig_stats.normal=
_pages, pages-&gt;num);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat64_add(&amp;mig_stats.normal=
_pages, pages-&gt;normal_num);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stat64_add(&amp;mig_stats.z=
ero_pages, pages-&gt;zero_num);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0multifd_pages_reset(p-&gt;p=
ages);<br>
@@ -1256,7 +1285,8 @@ static void *multifd_recv_thread(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;flags &amp;=3D ~MULTIFD_FLAG_SYNC;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;p-&gt;mutex);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p-&gt;normal_num) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p-&gt;normal_num + p-&gt;zero_num) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(!(flags &amp; MULTIFD_FLA=
G_SYNC));<br></blockquote><div></div><div>This assertion seems to be not re=
levant to this patch. Could you post it separately and explain why it&#39;s=
 needed here?</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D multifd_recv_state-=
&gt;ops-&gt;recv_pages(p, &amp;local_err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/migration/multifd.h b/migration/multifd.h<br>
index 9822ff298a..125f0bbe60 100644<br>
--- a/migration/multifd.h<br>
+++ b/migration/multifd.h<br>
@@ -53,6 +53,11 @@ typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0uint32_t unused32[1];=C2=A0 =C2=A0 /* Reserved for futu=
re use */<br>
=C2=A0 =C2=A0 =C2=A0uint64_t unused64[3];=C2=A0 =C2=A0 /* Reserved for futu=
re use */<br>
=C2=A0 =C2=A0 =C2=A0char ramblock[256];<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* This array contains the pointers to:<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 - normal pages (initial normal_pages entries)<=
br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 - zero pages (following zero_pages entries)<br=
>
+=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0uint64_t offset[];<br>
=C2=A0} __attribute__((packed)) MultiFDPacket_t;<br>
<br>
@@ -224,6 +229,8 @@ typedef struct {<br>
<br>
=C2=A0void multifd_register_ops(int method, MultiFDMethods *ops);<br>
=C2=A0void multifd_send_fill_packet(MultiFDSendParams *p);<br>
+void multifd_zero_page_check_send(MultiFDSendParams *p);<br>
+void multifd_zero_page_check_recv(MultiFDRecvParams *p);<br>
<br>
=C2=A0static inline void multifd_send_prepare_header(MultiFDSendParams *p)<=
br>
=C2=A0{<br>
diff --git a/qapi/migration.json b/qapi/migration.json<br>
index 99843a8e95..e2450b92d4 100644<br>
--- a/qapi/migration.json<br>
+++ b/qapi/migration.json<br>
@@ -660,9 +660,11 @@<br>
=C2=A0#<br>
=C2=A0# @none: Do not perform zero page checking.<br>
=C2=A0#<br>
+# @multifd: Perform zero page checking on the multifd sender thread. (sinc=
e 9.0)<br>
+#<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39;: &#39;ZeroPageDetection&#39;,<br>
-=C2=A0 &#39;data&#39;: [ &#39;legacy&#39;, &#39;none&#39; ] }<br>
+=C2=A0 &#39;data&#39;: [ &#39;legacy&#39;, &#39;none&#39;, &#39;multifd&#3=
9; ] }<br>
<br>
=C2=A0##<br>
=C2=A0# @BitmapMigrationBitmapAliasTransform:<br>
-- <br>
2.30.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Elena</div></=
div>

--000000000000511d230611e66cf9--

