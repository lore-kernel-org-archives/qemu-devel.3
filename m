Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E897C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 14:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOI7c-0000w6-C9; Mon, 01 Jul 2024 10:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sOI7b-0000vy-HV
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:35:11 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sOI7X-0004XM-E4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:35:11 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6fe7a0cb58so153074366b.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719844506; x=1720449306; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eZww6N4FXnwd+gMZy4Nk8A9I2Qib6HFNI65vtKUOJiY=;
 b=EIGG9VLhSG/dTlWfvOwvN4HL4W1xnalYMAE1gQhBe+9c8gVM8NFEsJOcFC3Mm8jK2w
 h+OLBF04K4OTWIXxWrZE5y9gqw5ik46iicCP2GAejW83671eYeocPFE6eSXR+KGNggIH
 oCvhqcMN4uHfpDmkGjKlhu/YSFZWWkCoFX7EaEEg7OuRB//dg32pX4kxJ8p/uVAssNl3
 FQutFj+lGFpRtXQXjcbNyKC3mjDbWEypDZvqGwjSZIglPhZ0aA5seAg/jD5rwE+cO4MX
 P/NPGVh5zjMGqKZ20UxqqEwFk4IYn8fEGJm3w95GdexQdLrUKqRUQtRJO+DK3EEAlesf
 sQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719844506; x=1720449306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eZww6N4FXnwd+gMZy4Nk8A9I2Qib6HFNI65vtKUOJiY=;
 b=RzzBE0jLUiQ5zs7WFTjelrtYGZW6O5OWu1eMvYn0CwKpGh2UiMpV+3JAbR3oaDRtIY
 Jp9tIapBBCH6rTxF+FmcZKCRaEzJQGL4IyKP8750rzk86Uuk5sDq6wYan1PPCQs4XdYO
 n3F1GXYLXv3DaNUFFzf95mI8DOlvxVX0dNPp0gh5L3dRb2wXliw2ig2YYxX0fIZ9dnNt
 ivLFpNHoUd77mJpr+3iNtukvZnE6L+VbilhxcsRhlDOtCkhi2RLQ7MP5Ex4lwKpyyQr5
 yTZIiaIHuqJnthFMf+MVzOHH4lSreJLwbjl6O0OlqQJFv8ObXIg2sR9fwW+QpGeTDRXT
 DacA==
X-Gm-Message-State: AOJu0YwAE3P68EpRlxXbzwez8gugiA/bnjBZh8UAdfZ+19G28Z63sN8G
 f1W7hbAE7ka46VgPp0S/0TC2K+Q2l8/XWavCYx5KcLn6XFIcxcHRZA1n91mdatAGrY1/9fodO7u
 LrJ5h1gm+xxwSeiu6owKsSi1UDVc=
X-Google-Smtp-Source: AGHT+IHRLrN6RbgnMhN+GP4BrC6L0LhuTVoWZrJC+PAQoWWAqLNzUu/TDjwQ6ko3aN82hro5kiwQGWdRDG4be7Jle5o=
X-Received: by 2002:a05:6402:1e88:b0:57c:6d89:eaef with SMTP id
 4fb4d7f45d1cf-5879f3ac701mr5577176a12.18.1719844505325; Mon, 01 Jul 2024
 07:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
 <20240529140739.1387692-3-edgar.iglesias@gmail.com> <ZoKnQLBwIwh004yy@l14>
 <CAJy5ezqdxQ_y_sCyP243yTfgOJfLh1COzN9Eg+PxxoaVeOh-mQ@mail.gmail.com>
 <CAJy5ezrSs8r=ibTgb_oURdFTDW07sVVBeU6Rw7jsM+iaqPLNgg@mail.gmail.com>
In-Reply-To: <CAJy5ezrSs8r=ibTgb_oURdFTDW07sVVBeU6Rw7jsM+iaqPLNgg@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 1 Jul 2024 16:34:53 +0200
Message-ID: <CAJy5ezrPgUR3-gWK3Mfnc7iAgV3MEStSardY+0kkvHB+PHbe4w@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] xen: mapcache: Unmap first entries in buckets
To: Anthony PERARD <anthony.perard@vates.tech>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Content-Type: multipart/alternative; boundary="000000000000cf1678061c30803d"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ej1-x633.google.com
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

--000000000000cf1678061c30803d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 4:30=E2=80=AFPM Edgar E. Iglesias <edgar.iglesias@gm=
ail.com>
wrote:

>
>
> On Mon, Jul 1, 2024 at 3:58=E2=80=AFPM Edgar E. Iglesias <edgar.iglesias@=
gmail.com>
> wrote:
>
>> On Mon, Jul 1, 2024 at 2:55=E2=80=AFPM Anthony PERARD <anthony.perard@va=
tes.tech>
>> wrote:
>>
>>> Hi all,
>>>
>>> Following this commit, a test which install Debian in a guest with OVMF
>>> as firmware started to fail. QEMU exit with an error when GRUB is
>>> running on the freshly installed Debian (I don't know if GRUB is
>>> starting Linux or not).
>>> The error is:
>>>     Bad ram offset ffffffffffffffff
>>>
>>> Some logs:
>>>
>>> http://logs.test-lab.xenproject.org/osstest/logs/186611/test-amd64-amd6=
4-xl-qemuu-ovmf-amd64/info.html
>>>
>>> Any idea? Something is trying to do something with the address "-1" whe=
n
>>> it shouldn't?
>>>
>>>
>> Hi Anothny,
>>
>> Yes, it looks like something is calling qemu_get_ram_block() on somethin=
g
>> that isn't mapped.
>> One possible path is in qemu_ram_block_from_host() but there may be
>> others.
>>
>> The following patch may help.
>> Any chance you could try to get a backtrace from QEMU when it failed?
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 33d09f7571..2669c4dbbb 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2277,6 +2277,9 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool
>> round_offset,
>>          ram_addr_t ram_addr;
>>          RCU_READ_LOCK_GUARD();
>>          ram_addr =3D xen_ram_addr_from_mapcache(ptr);
>> +        if (ram_addr =3D=3D RAM_ADDR_INVALID) {
>> +            return NULL;
>> +        }
>>          block =3D qemu_get_ram_block(ram_addr);
>>          if (block) {
>>              *offset =3D ram_addr - block->offset;
>>
>>
>>
> One more thing, regarding this specific patch. I don't think we should
> clear the
> entire entry, the next field should be kept, otherwise we'll disconnect
> following
> mappings that will never be found again. IIUC, this could very well be
> causing the problem you see.
>
> Does the following make sense?
>
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 5f23b0adbe..e9df53c19d 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -597,7 +597,14 @@ static void
> xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
>          pentry->next =3D entry->next;
>          g_free(entry);
>      } else {
> -        memset(entry, 0, sizeof *entry);
> +        /* Invalidate mapping.  */
> +        entry->paddr_index =3D 0;
> +        entry->vaddr_base =3D NULL;
> +        entry->size =3D 0;
> +        g_free(entry->valid_mapping);
> +        entry->valid_mapping =3D NULL;
> +        entry->flags =3D 0;
> +        /* Keep entry->next pointing to the rest of the list.  */
>      }
>  }
>
>
>

And here without double-freeing entry->valid_mapping:

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 5f23b0adbe..667807b3b6 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -597,7 +597,13 @@ static void
xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
         pentry->next =3D entry->next;
         g_free(entry);
     } else {
-        memset(entry, 0, sizeof *entry);
+        /* Invalidate mapping.  */
+        entry->paddr_index =3D 0;
+        entry->vaddr_base =3D NULL;
+        entry->size =3D 0;
+        entry->valid_mapping =3D NULL;
+        entry->flags =3D 0;
+        /* Keep entry->next pointing to the rest of the list.  */
     }
 }

--000000000000cf1678061c30803d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 1, 2024 at 4:30=E2=80=AFP=
M Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com">edgar.i=
glesias@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 1, 2024 =
at 3:58=E2=80=AFPM Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@g=
mail.com" target=3D"_blank">edgar.iglesias@gmail.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div d=
ir=3D"ltr">On Mon, Jul 1, 2024 at 2:55=E2=80=AFPM Anthony PERARD &lt;anthon=
y.perard@vates.tech&gt; wrote:<br></div><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">Hi all,<br>
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
=A0<br></div><div><br></div></div></div></blockquote><div><br></div><div><b=
r></div><div>And here without double-freeing entry-&gt;valid_mapping:</div>=
<div><br></div><div>diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcach=
e.c<br>index 5f23b0adbe..667807b3b6 100644<br>--- a/hw/xen/xen-mapcache.c<b=
r>+++ b/hw/xen/xen-mapcache.c<br>@@ -597,7 +597,13 @@ static void xen_inval=
idate_map_cache_entry_unlocked(MapCache *mc,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pentry-&gt;next =3D entry-&gt;next;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0g_free(entry);<br>=C2=A0 =C2=A0 =C2=A0} else {<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0memset(entry, 0, sizeof *entry);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* Invalidate mapping. =C2=A0*/<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;p=
addr_index =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;vaddr_base =3D =
NULL;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0entry-&gt;size =3D 0;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0entry-&gt;valid_mapping =3D NULL;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0entry-&gt;flags =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Keep en=
try-&gt;next pointing to the rest of the list. =C2=A0*/<br>=C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0}</div><div><br></div></div></div>

--000000000000cf1678061c30803d--

