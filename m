Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF97AC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 14:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOI3b-0007Il-2r; Mon, 01 Jul 2024 10:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sOI3L-0007Ht-BY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:30:48 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sOI3F-0003sr-IN
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:30:45 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57cd26347d3so493279a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719844239; x=1720449039; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mx1BbZNoFXKbNgK2rGGxef64/Fo+sAmrJZLodx+tDP4=;
 b=g3Wymus++JMYfES7o0m3ZaqynPgJZQtBQsLNgyig4LRRWO+RxZri7rcwkMG8c9w5vi
 uK09YG1/dvQqKtbCCQ8NTwYbZ4wfMej1ssPOch3N1Ten9l3z2no5x35YaigYOqmmjJ55
 4rxVF/6rDc54ZIwcf5cfrKHAELDqwXv8mHB0rqzFdnIvRXUBN8ACk8iaPIlWDjjD7CCT
 L3s8lH4Pqhkj323TSd3tn+OFzr7W8lrsseW53sGGGTAuIsJEGT4bdAMj0nvmurqkqNSj
 XvdqePudkS5gPT/WUsZYGEOkVLdzmqqGkdPPKi/CjsRYWoNJ63z4p66+2o+BqDH/U2aS
 u5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719844239; x=1720449039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mx1BbZNoFXKbNgK2rGGxef64/Fo+sAmrJZLodx+tDP4=;
 b=Z1HiJC4pSbXoZRrXv7gOrgB3zxKyCIAkDsYUlI+MQPnniOzxmfnU4gPnwRtuuX2PbA
 N5mML6ufNYdskP8gmNbcNOR/fxuF6rUaAOEakqH8AQLWOsPcJBc0JVQb+KWHSmnZIf1C
 +ClgWh7kLPxKExzw4pOpjpCuGdDxASv95kDqLTGXFxRA3K9wBjPLHRO3Z1cNrNFf2Abk
 ZV5cu2UlcJr5Ecv+sdA/6suQI+/kt9cY+TQru9JdhtCtdbDanHJtjbfDBDTcn7Ahz1CB
 H0VekbgV1GsdOg+eSP9/YJS9OJzb9Zog8LbQvqjHNa18pAR3iiWjqpXn20Uu3yvGHPKY
 oaUw==
X-Gm-Message-State: AOJu0Yxm3rZlVIBcqG80G5VxWmN53DXJXvTEPEvCJuXF7H9NEOY0D8CQ
 zXUOPdZS+LrkJilOmxydqF3PJoztN9CNhkPL+RGyZ+475dkarPzoYUlaGVkzVgL4Bp3E7h/HeOO
 rvLgvYYHHL3i7RX2UcJXV87VMpcA=
X-Google-Smtp-Source: AGHT+IFfW/3Gj/TvJuH+0cyH3oL2sUBonnIH8EmEbqpFq7+OqmDQFW6b0kk26I/bgkc5lT9UrN5vHJS+BdRtuYWs8Ko=
X-Received: by 2002:a05:6402:524a:b0:57d:72e:5b3a with SMTP id
 4fb4d7f45d1cf-587a053e309mr3872445a12.33.1719844239082; Mon, 01 Jul 2024
 07:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
 <20240529140739.1387692-3-edgar.iglesias@gmail.com> <ZoKnQLBwIwh004yy@l14>
 <CAJy5ezqdxQ_y_sCyP243yTfgOJfLh1COzN9Eg+PxxoaVeOh-mQ@mail.gmail.com>
In-Reply-To: <CAJy5ezqdxQ_y_sCyP243yTfgOJfLh1COzN9Eg+PxxoaVeOh-mQ@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 1 Jul 2024 16:30:27 +0200
Message-ID: <CAJy5ezrSs8r=ibTgb_oURdFTDW07sVVBeU6Rw7jsM+iaqPLNgg@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] xen: mapcache: Unmap first entries in buckets
To: Anthony PERARD <anthony.perard@vates.tech>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Content-Type: multipart/alternative; boundary="000000000000f08b0c061c3070a6"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52d.google.com
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

--000000000000f08b0c061c3070a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 3:58=E2=80=AFPM Edgar E. Iglesias <edgar.iglesias@gm=
ail.com>
wrote:

> On Mon, Jul 1, 2024 at 2:55=E2=80=AFPM Anthony PERARD <anthony.perard@vat=
es.tech>
> wrote:
>
>> Hi all,
>>
>> Following this commit, a test which install Debian in a guest with OVMF
>> as firmware started to fail. QEMU exit with an error when GRUB is
>> running on the freshly installed Debian (I don't know if GRUB is
>> starting Linux or not).
>> The error is:
>>     Bad ram offset ffffffffffffffff
>>
>> Some logs:
>>
>> http://logs.test-lab.xenproject.org/osstest/logs/186611/test-amd64-amd64=
-xl-qemuu-ovmf-amd64/info.html
>>
>> Any idea? Something is trying to do something with the address "-1" when
>> it shouldn't?
>>
>>
> Hi Anothny,
>
> Yes, it looks like something is calling qemu_get_ram_block() on something
> that isn't mapped.
> One possible path is in qemu_ram_block_from_host() but there may be other=
s.
>
> The following patch may help.
> Any chance you could try to get a backtrace from QEMU when it failed?
>
> diff --git a/system/physmem.c b/system/physmem.c
> index 33d09f7571..2669c4dbbb 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2277,6 +2277,9 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool
> round_offset,
>          ram_addr_t ram_addr;
>          RCU_READ_LOCK_GUARD();
>          ram_addr =3D xen_ram_addr_from_mapcache(ptr);
> +        if (ram_addr =3D=3D RAM_ADDR_INVALID) {
> +            return NULL;
> +        }
>          block =3D qemu_get_ram_block(ram_addr);
>          if (block) {
>              *offset =3D ram_addr - block->offset;
>
>
>
One more thing, regarding this specific patch. I don't think we should
clear the
entire entry, the next field should be kept, otherwise we'll disconnect
following
mappings that will never be found again. IIUC, this could very well be
causing the problem you see.

Does the following make sense?

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 5f23b0adbe..e9df53c19d 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -597,7 +597,14 @@ static void
xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
         pentry->next =3D entry->next;
         g_free(entry);
     } else {
-        memset(entry, 0, sizeof *entry);
+        /* Invalidate mapping.  */
+        entry->paddr_index =3D 0;
+        entry->vaddr_base =3D NULL;
+        entry->size =3D 0;
+        g_free(entry->valid_mapping);
+        entry->valid_mapping =3D NULL;
+        entry->flags =3D 0;
+        /* Keep entry->next pointing to the rest of the list.  */
     }
 }









>
>
>> Cheers,
>>
>> Anthony
>>
>> On Wed, May 29, 2024 at 04:07:33PM +0200, Edgar E. Iglesias wrote:
>> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>> >
>> > When invalidating memory ranges, if we happen to hit the first
>> > entry in a bucket we were never unmapping it. This was harmless
>> > for foreign mappings but now that we're looking to reuse the
>> > mapcache for transient grant mappings, we must unmap entries
>> > when invalidated.
>> >
>> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>> > ---
>> >  hw/xen/xen-mapcache.c | 11 ++++++++---
>> >  1 file changed, 8 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
>> > index bc860f4373..ec95445696 100644
>> > --- a/hw/xen/xen-mapcache.c
>> > +++ b/hw/xen/xen-mapcache.c
>> > @@ -491,18 +491,23 @@ static void
>> xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
>> >          return;
>> >      }
>> >      entry->lock--;
>> > -    if (entry->lock > 0 || pentry =3D=3D NULL) {
>> > +    if (entry->lock > 0) {
>> >          return;
>> >      }
>> >
>> > -    pentry->next =3D entry->next;
>> >      ram_block_notify_remove(entry->vaddr_base, entry->size,
>> entry->size);
>> >      if (munmap(entry->vaddr_base, entry->size) !=3D 0) {
>> >          perror("unmap fails");
>> >          exit(-1);
>> >      }
>> > +
>> >      g_free(entry->valid_mapping);
>> > -    g_free(entry);
>> > +    if (pentry) {
>> > +        pentry->next =3D entry->next;
>> > +        g_free(entry);
>> > +    } else {
>> > +        memset(entry, 0, sizeof *entry);
>> > +    }
>> >  }
>> >
>> >  typedef struct XenMapCacheData {
>> > --
>> > 2.40.1
>> >
>> >
>> --
>>
>> Anthony Perard | Vates XCP-ng Developer
>>
>> XCP-ng & Xen Orchestra - Vates solutions
>>
>> web: https://vates.tech
>>
>

--000000000000f08b0c061c3070a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 1, 2024 at 3:58=E2=80=AFP=
M Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com">edgar.i=
glesias@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">On Mon, Jul 1, 2024 at 2=
:55=E2=80=AFPM Anthony PERARD &lt;anthony.perard@vates.tech&gt; wrote:<br><=
/div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Hi all,<br>
<br>
Following this commit, a test which install Debian in a guest with OVMF<br>
as firmware started to fail. QEMU exit with an error when GRUB is<br>
running on the freshly installed Debian (I don&#39;t know if GRUB is<br>
starting Linux or not).<br>
The error is:<br>
=C2=A0 =C2=A0 Bad ram offset ffffffffffffffff<br>
<br>
Some logs:<br>
<a href=3D"http://logs.test-lab.xenproject.org/osstest/logs/186611/test-amd=
64-amd64-xl-qemuu-ovmf-amd64/info.html" rel=3D"noreferrer" target=3D"_blank=
">http://logs.test-lab.xenproject.org/osstest/logs/186611/test-amd64-amd64-=
xl-qemuu-ovmf-amd64/info.html</a><br>
<br>
Any idea? Something is trying to do something with the address &quot;-1&quo=
t; when<br>
it shouldn&#39;t?<br>
<br></blockquote><div><br></div><div>Hi Anothny,</div><div><br></div><div>Y=
es, it looks like something is calling=C2=A0qemu_get_ram_block() on somethi=
ng that isn&#39;t mapped.</div><div>One possible path is in=C2=A0qemu_ram_b=
lock_from_host() but there may be others.</div><div><br></div><div>The=C2=
=A0following patch may help.</div><div>Any chance you could try to get a ba=
cktrace from QEMU when it failed?</div><div><br></div><div>diff --git a/sys=
tem/physmem.c b/system/physmem.c<br>index 33d09f7571..2669c4dbbb 100644<br>=
--- a/system/physmem.c<br>+++ b/system/physmem.c<br>@@ -2277,6 +2277,9 @@ R=
AMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ram_addr_t ram_addr;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0RCU_READ_LOCK_GUARD();<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ram_a=
ddr =3D xen_ram_addr_from_mapcache(ptr);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (ram_addr =3D=3D RAM_ADDR_INVALID) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return NULL;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0block =3D qemu_get_ram_block(ram_addr);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (block) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*offset =3D ram_addr - block-&gt;offset;<br></div><div><br></d=
iv><div><br></div></div></div></blockquote><div><br></div><div>One more thi=
ng, regarding this specific patch. I don&#39;t think we should clear the</d=
iv><div>entire entry, the next field should be kept, otherwise we&#39;ll di=
sconnect following</div><div>mappings that will never be found again. IIUC,=
 this could very well be causing the problem you see.</div><div><br></div><=
div>Does the following make sense?</div><div class=3D"gmail_quote"><br></di=
v>diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c<br>index 5f23b=
0adbe..e9df53c19d 100644<br>--- a/hw/xen/xen-mapcache.c<br>+++ b/hw/xen/xen=
-mapcache.c<br>@@ -597,7 +597,14 @@ static void xen_invalidate_map_cache_en=
try_unlocked(MapCache *mc,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pentry-&gt;=
next =3D entry-&gt;next;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(entry)=
;<br>=C2=A0 =C2=A0 =C2=A0} else {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(en=
try, 0, sizeof *entry);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Invalidate mappi=
ng. =C2=A0*/<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;paddr_index =3D 0;<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;vaddr_base =3D NULL;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0entry-&gt;size =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0g=
_free(entry-&gt;valid_mapping);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;v=
alid_mapping =3D NULL;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;flags =3D =
0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Keep entry-&gt;next pointing to the r=
est of the list. =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br><div>=C2=
=A0<br></div><div><br></div><div><br></div><div><br></div><div><br></div><d=
iv><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Cheers,<br>
<br>
Anthony<br>
<br>
On Wed, May 29, 2024 at 04:07:33PM +0200, Edgar E. Iglesias wrote:<br>
&gt; From: &quot;Edgar E. Iglesias&quot; &lt;<a href=3D"mailto:edgar.iglesi=
as@amd.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt; <br>
&gt; When invalidating memory ranges, if we happen to hit the first<br>
&gt; entry in a bucket we were never unmapping it. This was harmless<br>
&gt; for foreign mappings but now that we&#39;re looking to reuse the<br>
&gt; mapcache for transient grant mappings, we must unmap entries<br>
&gt; when invalidated.<br>
&gt; <br>
&gt; Signed-off-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@=
amd.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt; Reviewed-by: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kern=
el.org" target=3D"_blank">sstabellini@kernel.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/xen/xen-mapcache.c | 11 ++++++++---<br>
&gt;=C2=A0 1 file changed, 8 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c<br>
&gt; index bc860f4373..ec95445696 100644<br>
&gt; --- a/hw/xen/xen-mapcache.c<br>
&gt; +++ b/hw/xen/xen-mapcache.c<br>
&gt; @@ -491,18 +491,23 @@ static void xen_invalidate_map_cache_entry_unloc=
ked(MapCache *mc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 entry-&gt;lock--;<br>
&gt; -=C2=A0 =C2=A0 if (entry-&gt;lock &gt; 0 || pentry =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 if (entry-&gt;lock &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 pentry-&gt;next =3D entry-&gt;next;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ram_block_notify_remove(entry-&gt;vaddr_base, entr=
y-&gt;size, entry-&gt;size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (munmap(entry-&gt;vaddr_base, entry-&gt;size) !=
=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;unmap fails&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(-1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(entry-&gt;valid_mapping);<br>
&gt; -=C2=A0 =C2=A0 g_free(entry);<br>
&gt; +=C2=A0 =C2=A0 if (pentry) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pentry-&gt;next =3D entry-&gt;next;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(entry);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(entry, 0, sizeof *entry);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct XenMapCacheData {<br>
&gt; -- <br>
&gt; 2.40.1<br>
&gt; <br>
&gt; <br>
-- <br>
<br>
Anthony Perard | Vates XCP-ng Developer<br>
<br>
XCP-ng &amp; Xen Orchestra - Vates solutions<br>
<br>
web: <a href=3D"https://vates.tech" rel=3D"noreferrer" target=3D"_blank">ht=
tps://vates.tech</a><br>
</blockquote></div></div>
</blockquote></div></div>

--000000000000f08b0c061c3070a6--

