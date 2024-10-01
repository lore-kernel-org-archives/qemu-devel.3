Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0BDCEACFA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 19:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svi68-0006nf-ON; Tue, 01 Oct 2024 14:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1svi63-0006nD-FA
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 14:59:43 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1svi61-0005O7-0y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 14:59:43 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-45aeed46f5eso26335421cf.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727809179; x=1728413979; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RcLvPXt9hb08ZelLVXcrQeVZc/gIcwr9ohqgaUVxngw=;
 b=Xsh0WWDUOi3pKzLs9+AtqPFsy2lU7cNCUI0lxFHGGTrCqBJbEUbJBZaFlIA8vMWhcq
 DosG5U6PJoVOP4d3Uo5T0cOnmgFZzpCBsEhnluSituZ5oA1e5qFDfrMyiZUS+x9Hvv6v
 C6Numuiaw7zfVsIfTuzYMZFSjT1CNuIAoP/I3n1KASIGGPHvRxZ7I70v1iH0WfAeX/Mx
 e7BvOCcY2Gs2OucjYDs/KBiqcpaWkDJZcn35551Hg5/aSOvsstplh/yL2jvuElyL/U49
 p+GrL7ORMv9Ap+oNU9gmVw6Rw/DK33xa0byBI31vOclxNqDo3M22CsQMbqZkC/CFr9sq
 aLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727809179; x=1728413979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RcLvPXt9hb08ZelLVXcrQeVZc/gIcwr9ohqgaUVxngw=;
 b=YV4UegnBfDhSyYLV61LdFqblVvIK+zyqv7PQiNsqZXoWMfrD36JSm04KpGyfpPBQ9K
 ZbLcccNJvdT2eoiFw5xSMR/izn3YfoCR5g75iuW8ybAMfTmnqYxb6jTfPlRGXSZJM9Yu
 d11faf9vglqyZdaj56cnVEMrnepl2xB04E5oSBx7/HFC3KWul9vRYcvmW63SjmjF7jm7
 arxoqBtJekCbDrCfeskuIH+TH3W11umBF7ZXW9EXg5w/OgMRPoSXYdIPTH/OP7bzc0nM
 G4N1kcuf0Kc6ejAmUxb5nWrLvcL1HGKY/lfMOKUPdm5fQf9IxZxu6fjwI4c6fyeVkqpT
 OGhA==
X-Gm-Message-State: AOJu0YwZG1pD1vyZDxx6UaBgiV/F6s0urIjj3q4p5iwTc7ksYh8WvSIp
 Rw4EXJfO3RLnJ5EI23TtXnFkaGOEnxTmmB+IxRBds5SnbqAL/VHVDnH0zra/dB70bHwvPaIm22K
 SKBecECSkByl9Tg28IK2kNi8NUEg=
X-Google-Smtp-Source: AGHT+IHzdXhRnDEwpnFLuwE3dmGw2qyHp7qgt+AImnhjraDxs5eKMEYZtvmZRSUhx4WtVhyuMPJ92Nj3xW6gpZuRcos=
X-Received: by 2002:a05:622a:1496:b0:458:5716:fbd8 with SMTP id
 d75a77b69052e-45d804eb220mr8699131cf.32.1727809179488; Tue, 01 Oct 2024
 11:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-unref-v1-1-88606ffd4552@daynix.com>
In-Reply-To: <20240723-unref-v1-1-88606ffd4552@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 1 Oct 2024 22:59:28 +0400
Message-ID: <CAJ+F1C+Om1SRmGS5UdT=BD9B24-C=QxVQvxkAcwo3SLFQ5Bqaw@mail.gmail.com>
Subject: Re: [PATCH] qemu-keymap: Release local allocation references
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000621c1106236eec56"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

--000000000000621c1106236eec56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com>
wrote:

> Commit 2523baf7fb4d ("qemu-keymap: Make references to allocations
> static") made references to allocations static to ensure LeakSanitizer
> can track them. This trick unfortunately did not work with gcc version
> 14.0.1; that compiler is clever enough to know that the value of the
> "state" variable is only referred in the current execution of the
> function and to put it on the stack.
>
> Release references to allocations and suppress the error once for all.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  qemu-keymap.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/qemu-keymap.c b/qemu-keymap.c
> index 701e4332af87..6707067fea04 100644
> --- a/qemu-keymap.c
> +++ b/qemu-keymap.c
> @@ -154,9 +154,9 @@ static xkb_mod_mask_t get_mod(struct xkb_keymap *map,
> const char *name)
>
>  int main(int argc, char *argv[])
>  {
> -    static struct xkb_context *ctx;
> -    static struct xkb_keymap *map;
> -    static struct xkb_state *state;
> +    struct xkb_context *ctx;
> +    struct xkb_keymap *map;
> +    struct xkb_state *state;
>      xkb_mod_index_t mod, mods;
>      int rc;
>
> @@ -213,6 +213,7 @@ int main(int argc, char *argv[])
>
>      ctx =3D xkb_context_new(XKB_CONTEXT_NO_FLAGS);
>      map =3D xkb_keymap_new_from_names(ctx, &names,
> XKB_KEYMAP_COMPILE_NO_FLAGS);
> +    xkb_context_unref(ctx);
>      if (!map) {
>          /* libxkbcommon prints error */
>          exit(1);
> @@ -234,6 +235,8 @@ int main(int argc, char *argv[])
>
>      state =3D xkb_state_new(map);
>      xkb_keymap_key_for_each(map, walk_map, state);
> +    xkb_state_unref(state);
> +    xkb_keymap_unref(map);
>
>      /* add quirks */
>      fprintf(outfile,
>
> ---
> base-commit: a87a7c449e532130d4fa8faa391ff7e1f04ed660
> change-id: 20240723-unref-d62e2b8338f4
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

--000000000000621c1106236eec56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 23, 2024 at 12:50=E2=80=
=AFPM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko=
.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Commit 2523baf7fb4d (&quot;qemu-keymap: Make references to=
 allocations<br>
static&quot;) made references to allocations static to ensure LeakSanitizer=
<br>
can track them. This trick unfortunately did not work with gcc version<br>
14.0.1; that compiler is clever enough to know that the value of the<br>
&quot;state&quot; variable is only referred in the current execution of the=
<br>
function and to put it on the stack.<br>
<br>
Release references to allocations and suppress the error once for all.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
---<br>
=C2=A0qemu-keymap.c | 9 ++++++---<br>
=C2=A01 file changed, 6 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qemu-keymap.c b/qemu-keymap.c<br>
index 701e4332af87..6707067fea04 100644<br>
--- a/qemu-keymap.c<br>
+++ b/qemu-keymap.c<br>
@@ -154,9 +154,9 @@ static xkb_mod_mask_t get_mod(struct xkb_keymap *map, c=
onst char *name)<br>
<br>
=C2=A0int main(int argc, char *argv[])<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 static struct xkb_context *ctx;<br>
-=C2=A0 =C2=A0 static struct xkb_keymap *map;<br>
-=C2=A0 =C2=A0 static struct xkb_state *state;<br>
+=C2=A0 =C2=A0 struct xkb_context *ctx;<br>
+=C2=A0 =C2=A0 struct xkb_keymap *map;<br>
+=C2=A0 =C2=A0 struct xkb_state *state;<br>
=C2=A0 =C2=A0 =C2=A0xkb_mod_index_t mod, mods;<br>
=C2=A0 =C2=A0 =C2=A0int rc;<br>
<br>
@@ -213,6 +213,7 @@ int main(int argc, char *argv[])<br>
<br>
=C2=A0 =C2=A0 =C2=A0ctx =3D xkb_context_new(XKB_CONTEXT_NO_FLAGS);<br>
=C2=A0 =C2=A0 =C2=A0map =3D xkb_keymap_new_from_names(ctx, &amp;names, XKB_=
KEYMAP_COMPILE_NO_FLAGS);<br>
+=C2=A0 =C2=A0 xkb_context_unref(ctx);<br>
=C2=A0 =C2=A0 =C2=A0if (!map) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* libxkbcommon prints error */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
@@ -234,6 +235,8 @@ int main(int argc, char *argv[])<br>
<br>
=C2=A0 =C2=A0 =C2=A0state =3D xkb_state_new(map);<br>
=C2=A0 =C2=A0 =C2=A0xkb_keymap_key_for_each(map, walk_map, state);<br>
+=C2=A0 =C2=A0 xkb_state_unref(state);<br>
+=C2=A0 =C2=A0 xkb_keymap_unref(map);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* add quirks */<br>
=C2=A0 =C2=A0 =C2=A0fprintf(outfile,<br>
<br>
---<br>
base-commit: a87a7c449e532130d4fa8faa391ff7e1f04ed660<br>
change-id: 20240723-unref-d62e2b8338f4<br>
<br>
Best regards,<br>
-- <br>
Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_bl=
ank">akihiko.odaki@daynix.com</a>&gt;<br></blockquote><div><br></div><div>R=
eviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@r=
edhat.com">marcandre.lureau@redhat.com</a>&gt; <br></div></div><br clear=3D=
"all"><br><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"=
ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000621c1106236eec56--

