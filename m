Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8865E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 17:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJbz5-0002vL-Bu; Fri, 06 Dec 2024 12:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tJbz2-0002v3-NY
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 12:19:17 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tJbz0-0000aC-2d
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 12:19:16 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ffbf4580cbso25559341fa.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 09:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733505552; x=1734110352; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bEy6fKZZ9bEUI8c+w0mlDVBYliG5bUxmNkQ8XkcgC/g=;
 b=Af6ZHhfTB2jMy0yjlwKcVazmEWZ8kK7Azp+X2cjw1EM6u8Ts18ha1+wCKtyYBLhHKg
 WC+DzBNoRPR1BCLfjLOueVWrXbpgbiX/zedN+3nqfI28Pvl556jWSQwiPevDHT5J50yh
 3+fcIsIYsT+CWdG6MmC53O4EI/1RW8kbH5jFWQZHOUkJ/NOPU9urh0JpfBYb/DVEfkEw
 GLhw58QuFVDWfPaJDX1PQTOiElZd5Yr8ZD/naa+T6xuHgZqqT8wORPUx8MEALQpPbvi1
 QqJRXEPbdjpJJtRj+/Uqr6VIT64TZZUnRg9RqfZ5ECwmt0auAzhGntZf8R2O4KFywNZY
 nhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733505552; x=1734110352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bEy6fKZZ9bEUI8c+w0mlDVBYliG5bUxmNkQ8XkcgC/g=;
 b=NtaCH6gOskz3laOpuyyRQiy0Kj9eM/ztdTmKVcumCznLpHRxzT9tkHvqiHUuyNYgnN
 TNWBlSOO8aITOFavz90MnyPF0VHWikIiDypOueLOYVfLRBjoXu30KIO3Qb+8QE4ItVkE
 vJArMljSCrLDm2tuwXgvsGvSS3tGEnP/detn/IlPhJqxp4KT8BuBX4mKyQTUFUM3JUeZ
 ATVJo6LZNRjDv07jpV8S+VDWIp1dncIt5GE8GoZo1evKmyq6GY1KEgyRk4WW3h03hWBH
 tbTYfJkxCzOAz6OFWCBX4ssrbuszIOoeVCwj6ch/Z34FPP241l3IA7GndtgCiDW80Ys/
 9OhQ==
X-Gm-Message-State: AOJu0Yyr9hcfcwfwvdeBpzrsEXMUOGmxqfpjVSVXOtT+pYT/gLNjTFEO
 Q7Ixpi/m18CoCU2oI8qAYphVA8fpkpikYLl3xbg7vGhv1AcowyZe88ZW0rfigCRQ072j1Yi3On9
 Butdu6sUWDt0PmHBvG5SkRGManjK66A==
X-Gm-Gg: ASbGncsSFpQMprmxT/i4huiesiou89moz/0j7aTmvaleQR6zYAXvmUg407IQ50hm0Er
 6d3LJTy2Ox9/KzIUBOonN0YeakCwIhoTPtA==
X-Google-Smtp-Source: AGHT+IGsR13CG/7bsq4jxSlTiR2MJGB8LPRv4ScHb3EpmJT1Q4rUwtt0mzo8tt8456rDhxnzB+Bw1kvIHw2eoVm9IOE=
X-Received: by 2002:a2e:a587:0:b0:300:1edd:914d with SMTP id
 38308e7fff4ca-3002fc69a71mr20354761fa.40.1733505551517; Fri, 06 Dec 2024
 09:19:11 -0800 (PST)
MIME-Version: 1.0
References: <E1tJamT-007Cqk-9E@kylie.crudebyte.com>
In-Reply-To: <E1tJamT-007Cqk-9E@kylie.crudebyte.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 6 Dec 2024 12:19:01 -0500
Message-ID: <CAJSP0QUcniqssNjJGxAxBf0dCCrLkAfY6LFET+S3Gq2SS8x7wA@mail.gmail.com>
Subject: Re: [PATCH v2] 9pfs: improve v9fs_walk() tracing
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Content-Type: multipart/alternative; boundary="0000000000009d5e5d06289d365d"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=stefanha@gmail.com; helo=mail-lj1-x229.google.com
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

--0000000000009d5e5d06289d365d
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 6, 2024, 11:44 Christian Schoenebeck <qemu_oss@crudebyte.com>
wrote:

> 'Twalk' is the most important request type in the 9p protocol to look out
> for when debugging 9p communication. That's because it is the only part
> of the 9p protocol which actually deals with human-readable path names,
> whereas all other 9p request types work on numeric file IDs (FIDs) only.
>
> Improve tracing of 'Twalk' requests, e.g. let's say client wanted to walk
> to "/home/bob/src", then improve trace output from:
>
>   v9fs_walk tag 0 id 110 fid 0 newfid 1 nwnames 3
>
> to:
>
>   v9fs_walk tag=0 id=110 fid=0 newfid=1 nwnames=3 wnames={home, bob, src}
>
> To achieve this, add a new helper function trace_v9fs_walk_wnames() which
> converts the received V9fsString array of individual path elements into a
> comma-separated string presentation for being passed to the tracing system.
> As this conversion is somewhat expensive, this conversion function is only
> called if tracing of event 'v9fs_walk' is currently enabled.
>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>  V2:
>  - Use trace_event_get_state_backends(TRACE_V9FS_WALK) instead of
>    trace_event_get_state(TRACE_V9FS_WALK) && qemu_loglevel_mask(LOG_TRACE).
>  - Move that check from helper function trace_v9fs_walk_wnames() to caller
>    function v9fs_walk().
>
>  hw/9pfs/9p.c         | 36 +++++++++++++++++++++++++++++++-----
>  hw/9pfs/trace-events |  2 +-
>  2 files changed, 32 insertions(+), 6 deletions(-)
>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 578517739a..6f24c1abb3 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1774,6 +1774,21 @@ static bool same_stat_id(const struct stat *a,
> const struct stat *b)
>      return a->st_dev == b->st_dev && a->st_ino == b->st_ino;
>  }
>
> +/*
> + * Returns a (newly allocated) comma-separated string presentation of the
> + * passed array for logging (tracing) purpose for trace event "v9fs_walk".
> + *
> + * It is caller's responsibility to free the returned string.
> + */
> +static char *trace_v9fs_walk_wnames(V9fsString *wnames, size_t nwnames)
> +{
> +    g_autofree char **arr = g_malloc0_n(nwnames + 1, sizeof(char *));
> +    for (size_t i = 0; i < nwnames; ++i) {
> +        arr[i] = wnames[i].data;
> +    }
> +    return g_strjoinv(", ", arr);
> +}
> +
>  static void coroutine_fn v9fs_walk(void *opaque)
>  {
>      int name_idx, nwalked;
> @@ -1787,6 +1802,7 @@ static void coroutine_fn v9fs_walk(void *opaque)
>      size_t offset = 7;
>      int32_t fid, newfid;
>      P9ARRAY_REF(V9fsString) wnames = NULL;
> +    g_autofree char *trace_wnames = NULL;
>      V9fsFidState *fidp;
>      V9fsFidState *newfidp = NULL;
>      V9fsPDU *pdu = opaque;
> @@ -1800,11 +1816,9 @@ static void coroutine_fn v9fs_walk(void *opaque)
>      }
>      offset += err;
>
> -    trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames);
> -
>      if (nwnames > P9_MAXWELEM) {
>          err = -EINVAL;
> -        goto out_nofid;
> +        goto out_nofid_nownames;
>      }
>      if (nwnames) {
>          P9ARRAY_NEW(V9fsString, wnames, nwnames);
> @@ -1814,15 +1828,23 @@ static void coroutine_fn v9fs_walk(void *opaque)
>          for (i = 0; i < nwnames; i++) {
>              err = pdu_unmarshal(pdu, offset, "s", &wnames[i]);
>              if (err < 0) {
> -                goto out_nofid;
> +                goto out_nofid_nownames;
>              }
>              if (name_is_illegal(wnames[i].data)) {
>                  err = -ENOENT;
> -                goto out_nofid;
> +                goto out_nofid_nownames;
>              }
>              offset += err;
>          }
> +        if (trace_event_get_state_backends(TRACE_V9FS_WALK)) {
> +            trace_wnames = trace_v9fs_walk_wnames(wnames, nwnames);
> +            trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames,
> +                            trace_wnames);
> +        }
> +    } else {
> +        trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, "");
>      }
> +
>      fidp = get_fid(pdu, fid);
>      if (fidp == NULL) {
>          err = -ENOENT;
> @@ -1957,7 +1979,11 @@ out:
>      }
>      v9fs_path_free(&dpath);
>      v9fs_path_free(&path);
> +    goto out_pdu_complete;
> +out_nofid_nownames:
> +    trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, "<?>");
>  out_nofid:
> +out_pdu_complete:
>      pdu_complete(pdu, err);
>  }
>
> diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
> index a12e55c165..ed9f4e7209 100644
> --- a/hw/9pfs/trace-events
> +++ b/hw/9pfs/trace-events
> @@ -11,7 +11,7 @@ v9fs_stat(uint16_t tag, uint8_t id, int32_t fid) "tag %d
> id %d fid %d"
>  v9fs_stat_return(uint16_t tag, uint8_t id, int32_t mode, int32_t atime,
> int32_t mtime, int64_t length) "tag %d id %d stat={mode %d atime %d mtime
> %d length %"PRId64"}"
>  v9fs_getattr(uint16_t tag, uint8_t id, int32_t fid, uint64_t
> request_mask) "tag %d id %d fid %d request_mask %"PRIu64
>  v9fs_getattr_return(uint16_t tag, uint8_t id, uint64_t result_mask,
> uint32_t mode, uint32_t uid, uint32_t gid) "tag %d id %d
> getattr={result_mask %"PRId64" mode %u uid %u gid %u}"
> -v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_t
> nwnames) "tag %d id %d fid %d newfid %d nwnames %d"
> +v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_t
> nwnames, const char* wnames) "tag=%d id=%d fid=%d newfid=%d nwnames=%d
> wnames={%s}"
>  v9fs_walk_return(uint16_t tag, uint8_t id, uint16_t nwnames, void* qids)
> "tag %d id %d nwnames %d qids %p"
>  v9fs_open(uint16_t tag, uint8_t id, int32_t fid, int32_t mode) "tag %d id
> %d fid %d mode %d"
>  v9fs_open_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t
> version, uint64_t path, int iounit) "tag %u id %u qid={type %u version %u
> path %"PRIu64"} iounit %d"
> --
> 2.39.5
>
>
>

--0000000000009d5e5d06289d365d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Dec 6, 2024, 11:44 Christian Schoenebeck &lt;<=
a href=3D"mailto:qemu_oss@crudebyte.com">qemu_oss@crudebyte.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&#39;Twalk&#=
39; is the most important request type in the 9p protocol to look out<br>
for when debugging 9p communication. That&#39;s because it is the only part=
<br>
of the 9p protocol which actually deals with human-readable path names,<br>
whereas all other 9p request types work on numeric file IDs (FIDs) only.<br=
>
<br>
Improve tracing of &#39;Twalk&#39; requests, e.g. let&#39;s say client want=
ed to walk<br>
to &quot;/home/bob/src&quot;, then improve trace output from:<br>
<br>
=C2=A0 v9fs_walk tag 0 id 110 fid 0 newfid 1 nwnames 3<br>
<br>
to:<br>
<br>
=C2=A0 v9fs_walk tag=3D0 id=3D110 fid=3D0 newfid=3D1 nwnames=3D3 wnames=3D{=
home, bob, src}<br>
<br>
To achieve this, add a new helper function trace_v9fs_walk_wnames() which<b=
r>
converts the received V9fsString array of individual path elements into a<b=
r>
comma-separated string presentation for being passed to the tracing system.=
<br>
As this conversion is somewhat expensive, this conversion function is only<=
br>
called if tracing of event &#39;v9fs_walk&#39; is currently enabled.<br>
<br>
Signed-off-by: Christian Schoenebeck &lt;<a href=3D"mailto:qemu_oss@crudeby=
te.com" target=3D"_blank" rel=3D"noreferrer">qemu_oss@crudebyte.com</a>&gt;=
<br>
Reviewed-by: Greg Kurz &lt;<a href=3D"mailto:groug@kaod.org" target=3D"_bla=
nk" rel=3D"noreferrer">groug@kaod.org</a>&gt;<br>
---<br>
=C2=A0V2:<br>
=C2=A0- Use trace_event_get_state_backends(TRACE_V9FS_WALK) instead of<br>
=C2=A0 =C2=A0trace_event_get_state(TRACE_V9FS_WALK) &amp;&amp; qemu_logleve=
l_mask(LOG_TRACE).<br>
=C2=A0- Move that check from helper function trace_v9fs_walk_wnames() to ca=
ller<br>
=C2=A0 =C2=A0function v9fs_walk().<br>
<br>
=C2=A0hw/9pfs/9p.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 36 ++++++++++++++++++=
+++++++++++++-----<br>
=C2=A0hw/9pfs/trace-events |=C2=A0 2 +-<br>
=C2=A02 files changed, 32 insertions(+), 6 deletions(-)<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by: Stefan =
Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>=
&gt;</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c<br>
index 578517739a..6f24c1abb3 100644<br>
--- a/hw/9pfs/9p.c<br>
+++ b/hw/9pfs/9p.c<br>
@@ -1774,6 +1774,21 @@ static bool same_stat_id(const struct stat *a, const=
 struct stat *b)<br>
=C2=A0 =C2=A0 =C2=A0return a-&gt;st_dev =3D=3D b-&gt;st_dev &amp;&amp; a-&g=
t;st_ino =3D=3D b-&gt;st_ino;<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Returns a (newly allocated) comma-separated string presentation of the<=
br>
+ * passed array for logging (tracing) purpose for trace event &quot;v9fs_w=
alk&quot;.<br>
+ *<br>
+ * It is caller&#39;s responsibility to free the returned string.<br>
+ */<br>
+static char *trace_v9fs_walk_wnames(V9fsString *wnames, size_t nwnames)<br=
>
+{<br>
+=C2=A0 =C2=A0 g_autofree char **arr =3D g_malloc0_n(nwnames + 1, sizeof(ch=
ar *));<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; nwnames; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arr[i] =3D wnames[i].data;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return g_strjoinv(&quot;, &quot;, arr);<br>
+}<br>
+<br>
=C2=A0static void coroutine_fn v9fs_walk(void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int name_idx, nwalked;<br>
@@ -1787,6 +1802,7 @@ static void coroutine_fn v9fs_walk(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0size_t offset =3D 7;<br>
=C2=A0 =C2=A0 =C2=A0int32_t fid, newfid;<br>
=C2=A0 =C2=A0 =C2=A0P9ARRAY_REF(V9fsString) wnames =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree char *trace_wnames =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0V9fsFidState *fidp;<br>
=C2=A0 =C2=A0 =C2=A0V9fsFidState *newfidp =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0V9fsPDU *pdu =3D opaque;<br>
@@ -1800,11 +1816,9 @@ static void coroutine_fn v9fs_walk(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0offset +=3D err;<br>
<br>
-=C2=A0 =C2=A0 trace_v9fs_walk(pdu-&gt;tag, pdu-&gt;id, fid, newfid, nwname=
s);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (nwnames &gt; P9_MAXWELEM) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -EINVAL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_nofid;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_nofid_nownames;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (nwnames) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0P9ARRAY_NEW(V9fsString, wnames, nwnames);=
<br>
@@ -1814,15 +1828,23 @@ static void coroutine_fn v9fs_walk(void *opaque)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nwnames; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D pdu_unmarshal(pdu, =
offset, &quot;s&quot;, &amp;wnames[i]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_nofid;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_nofid_now=
names;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (name_is_illegal(wnames[=
i].data)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENOE=
NT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_nofid;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_nofid_now=
names;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset +=3D err;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (trace_event_get_state_backends(TRACE_V9FS_=
WALK)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_wnames =3D trace_v9fs_walk=
_wnames(wnames, nwnames);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_v9fs_walk(pdu-&gt;tag, pdu=
-&gt;id, fid, newfid, nwnames,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 trace_wnames);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_v9fs_walk(pdu-&gt;tag, pdu-&gt;id, fid, =
newfid, nwnames, &quot;&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0fidp =3D get_fid(pdu, fid);<br>
=C2=A0 =C2=A0 =C2=A0if (fidp =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENOENT;<br>
@@ -1957,7 +1979,11 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0v9fs_path_free(&amp;dpath);<br>
=C2=A0 =C2=A0 =C2=A0v9fs_path_free(&amp;path);<br>
+=C2=A0 =C2=A0 goto out_pdu_complete;<br>
+out_nofid_nownames:<br>
+=C2=A0 =C2=A0 trace_v9fs_walk(pdu-&gt;tag, pdu-&gt;id, fid, newfid, nwname=
s, &quot;&lt;?&gt;&quot;);<br>
=C2=A0out_nofid:<br>
+out_pdu_complete:<br>
=C2=A0 =C2=A0 =C2=A0pdu_complete(pdu, err);<br>
=C2=A0}<br>
<br>
diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events<br>
index a12e55c165..ed9f4e7209 100644<br>
--- a/hw/9pfs/trace-events<br>
+++ b/hw/9pfs/trace-events<br>
@@ -11,7 +11,7 @@ v9fs_stat(uint16_t tag, uint8_t id, int32_t fid) &quot;ta=
g %d id %d fid %d&quot;<br>
=C2=A0v9fs_stat_return(uint16_t tag, uint8_t id, int32_t mode, int32_t atim=
e, int32_t mtime, int64_t length) &quot;tag %d id %d stat=3D{mode %d atime =
%d mtime %d length %&quot;PRId64&quot;}&quot;<br>
=C2=A0v9fs_getattr(uint16_t tag, uint8_t id, int32_t fid, uint64_t request_=
mask) &quot;tag %d id %d fid %d request_mask %&quot;PRIu64<br>
=C2=A0v9fs_getattr_return(uint16_t tag, uint8_t id, uint64_t result_mask, u=
int32_t mode, uint32_t uid, uint32_t gid) &quot;tag %d id %d getattr=3D{res=
ult_mask %&quot;PRId64&quot; mode %u uid %u gid %u}&quot;<br>
-v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_t =
nwnames) &quot;tag %d id %d fid %d newfid %d nwnames %d&quot;<br>
+v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_t =
nwnames, const char* wnames) &quot;tag=3D%d id=3D%d fid=3D%d newfid=3D%d nw=
names=3D%d wnames=3D{%s}&quot;<br>
=C2=A0v9fs_walk_return(uint16_t tag, uint8_t id, uint16_t nwnames, void* qi=
ds) &quot;tag %d id %d nwnames %d qids %p&quot;<br>
=C2=A0v9fs_open(uint16_t tag, uint8_t id, int32_t fid, int32_t mode) &quot;=
tag %d id %d fid %d mode %d&quot;<br>
=C2=A0v9fs_open_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t ver=
sion, uint64_t path, int iounit) &quot;tag %u id %u qid=3D{type %u version =
%u path %&quot;PRIu64&quot;} iounit %d&quot;<br>
-- <br>
2.39.5<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000009d5e5d06289d365d--

