Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABBECD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rub4D-0002ed-II; Wed, 10 Apr 2024 12:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rub4B-0002dx-Cq
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:44:55 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rub48-0000kC-Dh
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:44:55 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so7833874a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712767491; x=1713372291; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kU7fLL5zhn9t3uxjZrkjUvXD6TqmYBBsQf/9I0LY1nE=;
 b=D5f2LGQXnGpoB1xULS4k6gH64iIWOIexYN9nWOFV3Ueu1VmSWGCgY1xb5JiObitLsK
 aHNQU9lGikVoldcRvsWnsU/Yv1k8+eLV348rL3ca3XPnhHEjEWBUZ66pLB+jlyzjEDc4
 1LGunJTDxZKMBHmsecZu7kD78eSWhqR6a/lkzG379q9+KxOvc0ulF0XbLKTgld9O6cmL
 1uubWCh6YhtNdQ39YFTbbZnj+ImdTr5NuXKcltz5aUTg/Bgl9ijtlPm7f9gEcP/KzlTY
 ZVa8P50VVCj8Ha/gQJYd0xUnbGc7xY+y9fldMQd1EAwbPGvqV2K+po2DctbFS+r8qj6f
 N2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712767491; x=1713372291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kU7fLL5zhn9t3uxjZrkjUvXD6TqmYBBsQf/9I0LY1nE=;
 b=nWIqoDVUdlP2zbY1GTz5IJITwt4m0YRecj5bJQrxl9/HNfAykHy1FL9LAvq2y15o5x
 hiB0znwyHto+1PZv1YVL+JP1brAFM/D9AAOhTBXozoN0qfMxlVzamiORnAtVL+oOBeCH
 3pIQxeZ586wCHansokW/7CgJ2H8wD7Hmb/+rGUz0KNRjup3XmMuLL92BhfZG+Qw0vv6Y
 26obdpUB+BqfZ6pUkX72gYlZ01LiT+8ljkf8PxHDMrQvLk72QTxTKA8SXmaR4W5h47Hk
 NPrAhZxQuNlkCOmDkv69q/vK4118PO4d62lJoBTZVuOSS6hUdDPbGnmLWO+J0wp1v5UC
 rjSQ==
X-Gm-Message-State: AOJu0YxN8V3+stu6nLV21uzupzDmYx1NLkew5DYWPcv1DP0pXY0UELJy
 4SqwJIOi5dMI0UdVCv/RZKN2P01ulOWeMZQ8ayLqOXnA6Y9PtaGBimAc59mx/y+e5pCQNcNaI+8
 Mb5RveeO+6hgX/OxmIcP+XWZrwOc=
X-Google-Smtp-Source: AGHT+IFHfloCdvdb94WhFGbkl7JYZctSyDl5cLNUIi36u6ESOeU4ZLP8lRRn6ODZO9K4qM60fWIl50YGMlYdB+w0W5Q=
X-Received: by 2002:a50:8a84:0:b0:56d:c722:93a3 with SMTP id
 j4-20020a508a84000000b0056dc72293a3mr2445887edj.21.1712767490472; Wed, 10 Apr
 2024 09:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-6-vikram.garhwal@amd.com>
In-Reply-To: <20240227223501.28475-6-vikram.garhwal@amd.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 10 Apr 2024 18:44:38 +0200
Message-ID: <CAJy5ezpCWkOqthGR1c5Nsfyi_W_yGL_d17Jcp0VckaCEwx9z3Q@mail.gmail.com>
Subject: Re: [QEMU][PATCH v3 5/7] memory: add MemoryRegion map and unmap
 callbacks
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, vikram.garhwal@amd.com, 
 jgross@suse.com
Content-Type: multipart/alternative; boundary="000000000000da44650615c0c12f"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000da44650615c0c12f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:37=E2=80=AFPM Vikram Garhwal <vikram.garhwal@amd=
.com>
wrote:

> From: Juergen Gross <jgross@suse.com>
>
> In order to support mapping and unmapping guest memory dynamically to
> and from qemu during address_space_[un]map() operations add the map()
> and unmap() callbacks to MemoryRegionOps.
>
> Those will be used e.g. for Xen grant mappings when performing guest
> I/Os.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
>


Paolo, Peter, David, Phiippe, do you guys have any concerns with this patch=
?

Cheers,
Edgar



> ---
>  include/exec/memory.h | 21 ++++++++++++++++++
>  system/physmem.c      | 50 +++++++++++++++++++++++++++++++++----------
>  2 files changed, 60 insertions(+), 11 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 8626a355b3..9f7dfe59c7 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -282,6 +282,27 @@ struct MemoryRegionOps {
>                                      unsigned size,
>                                      MemTxAttrs attrs);
>
> +    /*
> +     * Dynamically create mapping. @addr is the guest address to map;
> @plen
> +     * is the pointer to the usable length of the buffer.
> +     * @mr contents can be changed in case a new memory region is create=
d
> for
> +     * the mapping.
> +     * Returns the buffer address for accessing the data.
> +     */
> +    void *(*map)(MemoryRegion **mr,
> +                 hwaddr addr,
> +                 hwaddr *plen,
> +                 bool is_write,
> +                 MemTxAttrs attrs);
> +
> +    /* Unmap an area obtained via map() before. */
> +    void (*unmap)(MemoryRegion *mr,
> +                  void *buffer,
> +                  ram_addr_t addr,
> +                  hwaddr len,
> +                  bool is_write,
> +                  hwaddr access_len);
> +
>      enum device_endian endianness;
>      /* Guest-visible constraints: */
>      struct {
> diff --git a/system/physmem.c b/system/physmem.c
> index 949dcb20ba..d989e9fc1f 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3141,6 +3141,7 @@ void *address_space_map(AddressSpace *as,
>      hwaddr len =3D *plen;
>      hwaddr l, xlat;
>      MemoryRegion *mr;
> +    void *ptr =3D NULL;
>      FlatView *fv;
>
>      if (len =3D=3D 0) {
> @@ -3174,12 +3175,20 @@ void *address_space_map(AddressSpace *as,
>          return bounce.buffer;
>      }
>
> -
>      memory_region_ref(mr);
> +
> +    if (mr->ops && mr->ops->map) {
> +        ptr =3D mr->ops->map(&mr, addr, plen, is_write, attrs);
> +    }
> +
>      *plen =3D flatview_extend_translation(fv, addr, len, mr, xlat,
>                                          l, is_write, attrs);
>      fuzz_dma_read_cb(addr, *plen, mr);
> -    return qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
> +    if (ptr =3D=3D NULL) {
> +        ptr =3D qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
> +    }
> +
> +    return ptr;
>  }
>
>  /* Unmaps a memory region previously mapped by address_space_map().
> @@ -3195,11 +3204,16 @@ void address_space_unmap(AddressSpace *as, void
> *buffer, hwaddr len,
>
>          mr =3D memory_region_from_host(buffer, &addr1);
>          assert(mr !=3D NULL);
> -        if (is_write) {
> -            invalidate_and_set_dirty(mr, addr1, access_len);
> -        }
> -        if (xen_enabled()) {
> -            xen_invalidate_map_cache_entry(buffer);
> +
> +        if (mr->ops && mr->ops->unmap) {
> +            mr->ops->unmap(mr, buffer, addr1, len, is_write, access_len)=
;
> +        } else {
> +            if (is_write) {
> +                invalidate_and_set_dirty(mr, addr1, access_len);
> +            }
> +            if (xen_enabled()) {
> +                xen_invalidate_map_cache_entry(buffer);
> +            }
>          }
>          memory_region_unref(mr);
>          return;
> @@ -3272,10 +3286,18 @@ int64_t address_space_cache_init(MemoryRegionCach=
e
> *cache,
>           * doing this if we found actual RAM, which behaves the same
>           * regardless of attributes; so UNSPECIFIED is fine.
>           */
> +        if (mr->ops && mr->ops->map) {
> +            cache->ptr =3D mr->ops->map(&mr, addr, &l, is_write,
> +                                      MEMTXATTRS_UNSPECIFIED);
> +        }
> +
>          l =3D flatview_extend_translation(cache->fv, addr, len, mr,
>                                          cache->xlat, l, is_write,
>                                          MEMTXATTRS_UNSPECIFIED);
> -        cache->ptr =3D qemu_ram_ptr_length(mr->ram_block, cache->xlat, &=
l,
> true);
> +        if (!cache->ptr) {
> +            cache->ptr =3D qemu_ram_ptr_length(mr->ram_block, cache->xla=
t,
> &l,
> +                                             true);
> +        }
>      } else {
>          cache->ptr =3D NULL;
>      }
> @@ -3297,14 +3319,20 @@ void
> address_space_cache_invalidate(MemoryRegionCache *cache,
>
>  void address_space_cache_destroy(MemoryRegionCache *cache)
>  {
> -    if (!cache->mrs.mr) {
> +    MemoryRegion *mr =3D cache->mrs.mr;
> +
> +    if (!mr) {
>          return;
>      }
>
> -    if (xen_enabled()) {
> +    if (mr->ops && mr->ops->unmap) {
> +            mr->ops->unmap(mr, cache->ptr, cache->xlat, cache->len,
> +                           cache->is_write, cache->len);
> +    } else if (xen_enabled()) {
>          xen_invalidate_map_cache_entry(cache->ptr);
>      }
> -    memory_region_unref(cache->mrs.mr);
> +
> +    memory_region_unref(mr);
>      flatview_unref(cache->fv);
>      cache->mrs.mr =3D NULL;
>      cache->fv =3D NULL;
> --
> 2.17.1
>
>
>

--000000000000da44650615c0c12f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Feb 27, 2024 at 11:37=E2=80=AFPM =
Vikram Garhwal &lt;<a href=3D"mailto:vikram.garhwal@amd.com">vikram.garhwal=
@amd.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">From: Juergen Gross &lt;<a href=3D"mailt=
o:jgross@suse.com" target=3D"_blank">jgross@suse.com</a>&gt;<br>
<br>
In order to support mapping and unmapping guest memory dynamically to<br>
and from qemu during address_space_[un]map() operations add the map()<br>
and unmap() callbacks to MemoryRegionOps.<br>
<br>
Those will be used e.g. for Xen grant mappings when performing guest<br>
I/Os.<br>
<br>
Signed-off-by: Juergen Gross &lt;<a href=3D"mailto:jgross@suse.com" target=
=3D"_blank">jgross@suse.com</a>&gt;<br>
Signed-off-by: Vikram Garhwal &lt;<a href=3D"mailto:vikram.garhwal@amd.com"=
 target=3D"_blank">vikram.garhwal@amd.com</a>&gt;<br></blockquote><div><br>=
</div><div><br></div><div>Paolo, Peter, David, Phiippe, do you guys have an=
y concerns with this patch?</div><div><br></div><div>Cheers,</div><div>Edga=
r</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
---<br>
=C2=A0include/exec/memory.h | 21 ++++++++++++++++++<br>
=C2=A0system/physmem.c=C2=A0 =C2=A0 =C2=A0 | 50 +++++++++++++++++++++++++++=
++++++----------<br>
=C2=A02 files changed, 60 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/include/exec/memory.h b/include/exec/memory.h<br>
index 8626a355b3..9f7dfe59c7 100644<br>
--- a/include/exec/memory.h<br>
+++ b/include/exec/memory.h<br>
@@ -282,6 +282,27 @@ struct MemoryRegionOps {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned size,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxAttrs attrs=
);<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Dynamically create mapping. @addr is the guest addre=
ss to map; @plen<br>
+=C2=A0 =C2=A0 =C2=A0* is the pointer to the usable length of the buffer.<b=
r>
+=C2=A0 =C2=A0 =C2=A0* @mr contents can be changed in case a new memory reg=
ion is created for<br>
+=C2=A0 =C2=A0 =C2=A0* the mapping.<br>
+=C2=A0 =C2=A0 =C2=A0* Returns the buffer address for accessing the data.<b=
r>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 void *(*map)(MemoryRegion **mr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr addr,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr *plen=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool is_writ=
e,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxAttrs a=
ttrs);<br>
+<br>
+=C2=A0 =C2=A0 /* Unmap an area obtained via map() before. */<br>
+=C2=A0 =C2=A0 void (*unmap)(MemoryRegion *mr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *buffe=
r,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_addr_t =
addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr len,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_wri=
te,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr acce=
ss_len);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0enum device_endian endianness;<br>
=C2=A0 =C2=A0 =C2=A0/* Guest-visible constraints: */<br>
=C2=A0 =C2=A0 =C2=A0struct {<br>
diff --git a/system/physmem.c b/system/physmem.c<br>
index 949dcb20ba..d989e9fc1f 100644<br>
--- a/system/physmem.c<br>
+++ b/system/physmem.c<br>
@@ -3141,6 +3141,7 @@ void *address_space_map(AddressSpace *as,<br>
=C2=A0 =C2=A0 =C2=A0hwaddr len =3D *plen;<br>
=C2=A0 =C2=A0 =C2=A0hwaddr l, xlat;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *mr;<br>
+=C2=A0 =C2=A0 void *ptr =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0FlatView *fv;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (len =3D=3D 0) {<br>
@@ -3174,12 +3175,20 @@ void *address_space_map(AddressSpace *as,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return bounce.buffer;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-<br>
=C2=A0 =C2=A0 =C2=A0memory_region_ref(mr);<br>
+<br>
+=C2=A0 =C2=A0 if (mr-&gt;ops &amp;&amp; mr-&gt;ops-&gt;map) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D mr-&gt;ops-&gt;map(&amp;mr, addr, plen=
, is_write, attrs);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0*plen =3D flatview_extend_translation(fv, addr, len, mr=
, xlat,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0l,=
 is_write, attrs);<br>
=C2=A0 =C2=A0 =C2=A0fuzz_dma_read_cb(addr, *plen, mr);<br>
-=C2=A0 =C2=A0 return qemu_ram_ptr_length(mr-&gt;ram_block, xlat, plen, tru=
e);<br>
+=C2=A0 =C2=A0 if (ptr =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D qemu_ram_ptr_length(mr-&gt;ram_block, =
xlat, plen, true);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return ptr;<br>
=C2=A0}<br>
<br>
=C2=A0/* Unmaps a memory region previously mapped by address_space_map().<b=
r>
@@ -3195,11 +3204,16 @@ void address_space_unmap(AddressSpace *as, void *bu=
ffer, hwaddr len,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mr =3D memory_region_from_host(buffer, &a=
mp;addr1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(mr !=3D NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_write) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 invalidate_and_set_dirty(mr, add=
r1, access_len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (xen_enabled()) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xen_invalidate_map_cache_entry(b=
uffer);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mr-&gt;ops &amp;&amp; mr-&gt;ops-&gt;unmap=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mr-&gt;ops-&gt;unmap(mr, buffer,=
 addr1, len, is_write, access_len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_write) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 invalidate_and_set=
_dirty(mr, addr1, access_len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (xen_enabled()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xen_invalidate_map=
_cache_entry(buffer);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_unref(mr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
@@ -3272,10 +3286,18 @@ int64_t address_space_cache_init(MemoryRegionCache =
*cache,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * doing this if we found actual RAM, whi=
ch behaves the same<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * regardless of attributes; so UNSPECIFI=
ED is fine.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mr-&gt;ops &amp;&amp; mr-&gt;ops-&gt;map) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cache-&gt;ptr =3D mr-&gt;ops-&gt=
;map(&amp;mr, addr, &amp;l, is_write,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MEMTXATTRS_UNSP=
ECIFIED);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0l =3D flatview_extend_translation(cache-&=
gt;fv, addr, len, mr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ca=
che-&gt;xlat, l, is_write,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ME=
MTXATTRS_UNSPECIFIED);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cache-&gt;ptr =3D qemu_ram_ptr_length(mr-&gt;r=
am_block, cache-&gt;xlat, &amp;l, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cache-&gt;ptr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cache-&gt;ptr =3D qemu_ram_ptr_l=
ength(mr-&gt;ram_block, cache-&gt;xlat, &amp;l,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cache-&gt;ptr =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -3297,14 +3319,20 @@ void address_space_cache_invalidate(MemoryRegionCac=
he *cache,<br>
<br>
=C2=A0void address_space_cache_destroy(MemoryRegionCache *cache)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (!cache-&gt;<a href=3D"http://mrs.mr" rel=3D"noreferrer" =
target=3D"_blank">mrs.mr</a>) {<br>
+=C2=A0 =C2=A0 MemoryRegion *mr =3D cache-&gt;<a href=3D"http://mrs.mr" rel=
=3D"noreferrer" target=3D"_blank">mrs.mr</a>;<br>
+<br>
+=C2=A0 =C2=A0 if (!mr) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (xen_enabled()) {<br>
+=C2=A0 =C2=A0 if (mr-&gt;ops &amp;&amp; mr-&gt;ops-&gt;unmap) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mr-&gt;ops-&gt;unmap(mr, cache-&=
gt;ptr, cache-&gt;xlat, cache-&gt;len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0cache-&gt;is_write, cache-&gt;len);<br>
+=C2=A0 =C2=A0 } else if (xen_enabled()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xen_invalidate_map_cache_entry(cache-&gt;=
ptr);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 memory_region_unref(cache-&gt;<a href=3D"http://mrs.mr" rel=
=3D"noreferrer" target=3D"_blank">mrs.mr</a>);<br>
+<br>
+=C2=A0 =C2=A0 memory_region_unref(mr);<br>
=C2=A0 =C2=A0 =C2=A0flatview_unref(cache-&gt;fv);<br>
=C2=A0 =C2=A0 =C2=A0cache-&gt;<a href=3D"http://mrs.mr" rel=3D"noreferrer" =
target=3D"_blank">mrs.mr</a> =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0cache-&gt;fv =3D NULL;<br>
-- <br>
2.17.1<br>
<br>
<br>
</blockquote></div></div>

--000000000000da44650615c0c12f--

