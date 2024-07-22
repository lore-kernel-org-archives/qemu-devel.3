Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F218EC3DA70
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn3Q-000881-0b; Mon, 22 Jul 2024 03:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sVn3H-0007pX-C3
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sVn34-0006PN-0o
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721631686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLsFwBsjc+rncFCmTlFwKxWACKLgT/r3+Wr46hY6q9c=;
 b=iRhSevE6wxObqNWJZzd89qhUbqViJ9lyk7IRP8oHQjc5DVRYa3+/84RJLIG6E4nZtHfK9n
 HusGfeVWmH5qJD/eQIiJEoEvXJoWJkQE/l4Zlll7AEWMt+EAvip9f1D4L3mc4Svi2K0gN0
 dTXYdgFFPGFuBGQsidFdVrXDDajcVN8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-lKaj6aLqOsO2oV6dMVj6xg-1; Mon, 22 Jul 2024 03:01:23 -0400
X-MC-Unique: lKaj6aLqOsO2oV6dMVj6xg-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7036e5add8dso3952313a34.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 00:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721631683; x=1722236483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uLsFwBsjc+rncFCmTlFwKxWACKLgT/r3+Wr46hY6q9c=;
 b=SU0an2BNvrgMYwgmLwvNlgJ/xxKj3PBjkk12fSFmieh56+s9TP/NpT++2N9S/+G0sk
 jOFJ9i6c6Ir7s+IWKeXj+7CM736rk+KAhTvj6huk5flHtCTpw04c2sLo6IaoUlXdrQXb
 rABpP2K6bfnhn+ywS2xSh8JgF86Jlhg+DU5sIFeRA+0N8YkCXff6GrlHABwGg2XM5Vnu
 HLH1dnO3/aA3YZ/h1D/KTAPBelBC6E5pZIthBv5dkYFDcAiNHks+3OA2UFyShTVfe6bR
 bzD4hjlCOgqllUjfZKdIO+/NpcBOR82jU9oF60PgC2vDDj2P4xQhz35rkTFw3c7jYXs7
 xsvg==
X-Gm-Message-State: AOJu0YxxQpoFFhPGXr6fY8MYMOYL4EsX9T0a6v3Q6fs0x92qpFupeOCl
 50hXpLB89YRbxXaw0TUmchIFnV9tI2BcHiGWWG+f+QiEMLAQpUQtPKjPmtjRZlwZFFdkL4MQi8A
 0qwVp07TO6QRE/1vpmJxvUVxtZ7TGHgBBqYzNpjuU7LS4Bw0ZjoCVZ10vTfJfSmN7j7cvpffher
 tVnQwcfvl/E0eOFpO5uUwXdbZv7q4=
X-Received: by 2002:a05:6830:3c05:b0:703:6b2a:2af9 with SMTP id
 46e09a7af769-70900908d13mr9552951a34.10.1721631683144; 
 Mon, 22 Jul 2024 00:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbne/PeQ4PFMXI6DO3ZF43rPo2S5cI/N3PxB4oYFmueoEbvK+NmFJjpy1yd4vLl6jJXVLO6kt4JOzhvY2u4yk=
X-Received: by 2002:a05:6830:3c05:b0:703:6b2a:2af9 with SMTP id
 46e09a7af769-70900908d13mr9552932a34.10.1721631682793; Mon, 22 Jul 2024
 00:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <20240722040742.11513-13-yaoxt.fnst@fujitsu.com>
In-Reply-To: <20240722040742.11513-13-yaoxt.fnst@fujitsu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 22 Jul 2024 11:01:11 +0400
Message-ID: <CAMxuvawSh7H3yhN2nB91ggCebEhwo0n_92EBX=hhAK==WbnoUQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] dump: make range overlap check more readable
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e3240c061dd09cd7"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

--000000000000e3240c061dd09cd7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 8:10=E2=80=AFAM Yao Xingtao <yaoxt.fnst@fujitsu.com=
> wrote:

> use ranges_overlap() instead of open-coding the overlap check to improve
> the readability of the code.
>
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  dump/dump.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 84064d890d2c..45e84428aea5 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -30,6 +30,7 @@
>  #include "migration/blocker.h"
>  #include "hw/core/cpu.h"
>  #include "win_dump.h"
> +#include "qemu/range.h"
>
>  #include <zlib.h>
>  #ifdef CONFIG_LZO
> @@ -574,8 +575,10 @@ static void get_offset_range(hwaddr phys_addr,
>
>      QTAILQ_FOREACH(block, &s->guest_phys_blocks.head, next) {
>          if (dump_has_filter(s)) {
> -            if (block->target_start >=3D s->filter_area_begin +
> s->filter_area_length ||
> -                block->target_end <=3D s->filter_area_begin) {
> +            if (!ranges_overlap(block->target_start,
> +                                block->target_end - block->target_start,
> +                                s->filter_area_begin,
> +                                s->filter_area_length)) {
>                  /* This block is out of the range */
>                  continue;
>              }
> @@ -734,8 +737,9 @@ int64_t dump_filtered_memblock_start(GuestPhysBlock
> *block,
>  {
>      if (filter_area_length) {
>          /* return -1 if the block is not within filter area */
> -        if (block->target_start >=3D filter_area_start + filter_area_len=
gth
> ||
> -            block->target_end <=3D filter_area_start) {
> +        if (!ranges_overlap(block->target_start,
> +                            block->target_end - block->target_start,
> +                            filter_area_start, filter_area_length)) {
>              return -1;
>          }
>
> --
> 2.41.0
>
>

--000000000000e3240c061dd09cd7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 22, 2024 at 8:10=E2=80=AF=
AM Yao Xingtao &lt;<a href=3D"mailto:yaoxt.fnst@fujitsu.com">yaoxt.fnst@fuj=
itsu.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">use ranges_overlap() instead of open-coding the overlap check to im=
prove<br>
the readability of the code.<br>
<br>
Signed-off-by: Yao Xingtao &lt;<a href=3D"mailto:yaoxt.fnst@fujitsu.com" ta=
rget=3D"_blank">yaoxt.fnst@fujitsu.com</a>&gt;<br></blockquote><div><br></d=
iv><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre=
.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0dump/dump.c | 12 ++++++++----<br>
=C2=A01 file changed, 8 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/dump/dump.c b/dump/dump.c<br>
index 84064d890d2c..45e84428aea5 100644<br>
--- a/dump/dump.c<br>
+++ b/dump/dump.c<br>
@@ -30,6 +30,7 @@<br>
=C2=A0#include &quot;migration/blocker.h&quot;<br>
=C2=A0#include &quot;hw/core/cpu.h&quot;<br>
=C2=A0#include &quot;win_dump.h&quot;<br>
+#include &quot;qemu/range.h&quot;<br>
<br>
=C2=A0#include &lt;zlib.h&gt;<br>
=C2=A0#ifdef CONFIG_LZO<br>
@@ -574,8 +575,10 @@ static void get_offset_range(hwaddr phys_addr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_FOREACH(block, &amp;s-&gt;guest_phys_blocks.head=
, next) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dump_has_filter(s)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (block-&gt;target_start &gt;=
=3D s-&gt;filter_area_begin + s-&gt;filter_area_length ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;target_e=
nd &lt;=3D s-&gt;filter_area_begin) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ranges_overlap(block-&gt;ta=
rget_start,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;target_end - block-&gt;tar=
get_start,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;filter_area_begin,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;filter_area_length)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* This block=
 is out of the range */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -734,8 +737,9 @@ int64_t dump_filtered_memblock_start(GuestPhysBlock *bl=
ock,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (filter_area_length) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* return -1 if the block is not within f=
ilter area */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (block-&gt;target_start &gt;=3D filter_area=
_start + filter_area_length ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;target_end &lt;=3D fil=
ter_area_start) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ranges_overlap(block-&gt;target_start,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;target_end - block-&gt;target_start,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 filter_area_start, filter_area_length)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div></div>

--000000000000e3240c061dd09cd7--


