Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F18EC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 18:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reg4L-0001C1-9d; Mon, 26 Feb 2024 13:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1reg48-00018Q-JS
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:51:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1reg44-0002Vt-CR
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708973457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uAcECbiIhT9JXkvHWKkmuMXS3gnLB2awgABt4y/loCs=;
 b=FMnGzTeqpZpNhZ82pVFrhbGi1ONBBFXESazs00SgS4wi9CRv1wFhNh+T4R1dPfarDxIBlb
 824pKqQxHZcrRquD74bb6caM7AZWavJxeE2omaVsQNh9gmBrAfQIFoIRFj5AfHteyg69AB
 n8XPcDIE2GnPhOqn9Y002SIKU1/iY+I=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-gO6KI8RbPdCu6AcVzazNCQ-1; Mon, 26 Feb 2024 13:50:54 -0500
X-MC-Unique: gO6KI8RbPdCu6AcVzazNCQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-512fcc26118so781230e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 10:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708973452; x=1709578252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uAcECbiIhT9JXkvHWKkmuMXS3gnLB2awgABt4y/loCs=;
 b=DJY8iq2GW+V7blp3MUXYT3XEEBgCB0K/ggjREPHyRateg3sEFcCVS8RD9kNbJj3Ezi
 X+0nc3kwHKvZOBCEDkawaZh5f671btRcUlayrLgjNZsE8gg2SsnKPpdHKtamR2sachk/
 0Wcp7KZHyNrGfRUMI9515GUHK7rRp2dXsWuDP3Wj4R1yaRqk8JUuSWy+Z6iw+xIjobBS
 ADpcSK/4N5T02H3TcC+983qHpXy9oiI/ce9s+2ah+Xl6ieGWlarvfBLQB4kqySugBYDC
 JlOLamgOOOAUVVh9wKA8x3zDW+qPppkCh/8Qu2laIayNfyvExLIwHYlqZysALVtDrREl
 Rmow==
X-Gm-Message-State: AOJu0Ywj/O13QKNqZtaEVevCbvT98LZax8++GgQlwWMtDfpy6lEOff4E
 HVqAWnllhm0QiylPTv5tkD2O1lBQmixdp50+SRNxe8TTzf54ytT8BcwFCcPOBPW78TtANteEGu2
 wQf3ReSAyY8T9qRrtw1FLbD8m1kqkf58rskt+EAs3XhkDCRi4ENnu9bShIHvCMUzS8/0u3AFfId
 T2ZKEptwC5d/aw3tGmGqTdap8sfus=
X-Received: by 2002:a05:6512:1093:b0:513:d1:770d with SMTP id
 j19-20020a056512109300b0051300d1770dmr910869lfg.7.1708973452637; 
 Mon, 26 Feb 2024 10:50:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqhM8f5giRdiItEJamxZkKzFrhBB8hVgBj1fkTqtsE/8iijwaVrCDeXfBKl8EnuSuiuns8mgj+u/ii+BaWFHU=
X-Received: by 2002:a05:6512:1093:b0:513:d1:770d with SMTP id
 j19-20020a056512109300b0051300d1770dmr910858lfg.7.1708973452014; Mon, 26 Feb
 2024 10:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20240226165642.807350-1-andrey.drobyshev@virtuozzo.com>
 <20240226165642.807350-2-andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20240226165642.807350-2-andrey.drobyshev@virtuozzo.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 26 Feb 2024 20:50:41 +0200
Message-ID: <CAPMcbCqf_fh67zRvarH2Y3tD-HPY=+O4nDC=6af+TGuMm1yj_Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] qga/commands-posix: return fsinfo values directly as
 reported by statvfs
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, marcandre.lureau@redhat.com, 
 den@virtuozzo.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000089ccc306124d63dd"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000089ccc306124d63dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Best Regards,
Konstantin Kostiuk.


On Mon, Feb 26, 2024 at 7:02=E2=80=AFPM Andrey Drobyshev <
andrey.drobyshev@virtuozzo.com> wrote:

> Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
> GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo:
> used =3D (f_blocks - f_bfree), total =3D (f_blocks - f_bfree + f_bavail).
> These calculations might be obscure for the end user and require one to
> actually get into QGA source to understand how they're obtained. Let's
> just report the values f_blocks, f_bfree, f_bavail (in bytes) from
> statvfs() as they are, letting the user decide how to process them furthe=
r.
>
> Originally-by: Yuri Pudgorodskiy <yur@virtuozzo.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  qga/commands-posix.c | 16 +++++++---------
>  qga/qapi-schema.json | 11 +++++++----
>  2 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 26008db497..752ef509d0 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1554,8 +1554,7 @@ static GuestFilesystemInfo
> *build_guest_fsinfo(struct FsMount *mount,
>                                                 Error **errp)
>  {
>      GuestFilesystemInfo *fs =3D g_malloc0(sizeof(*fs));
> -    struct statvfs buf;
> -    unsigned long used, nonroot_total, fr_size;
> +    struct statvfs st;
>      char *devpath =3D g_strdup_printf("/sys/dev/block/%u:%u",
>                                      mount->devmajor, mount->devminor);
>
> @@ -1563,15 +1562,14 @@ static GuestFilesystemInfo
> *build_guest_fsinfo(struct FsMount *mount,
>      fs->type =3D g_strdup(mount->devtype);
>      build_guest_fsinfo_for_device(devpath, fs, errp);
>
> -    if (statvfs(fs->mountpoint, &buf) =3D=3D 0) {
> -        fr_size =3D buf.f_frsize;
> -        used =3D buf.f_blocks - buf.f_bfree;
> -        nonroot_total =3D used + buf.f_bavail;
> -        fs->used_bytes =3D used * fr_size;
> -        fs->total_bytes =3D nonroot_total * fr_size;
> +    if (statvfs(fs->mountpoint, &st) =3D=3D 0) {
> +        fs->total_bytes =3D st.f_blocks * st.f_frsize;
> +        fs->free_bytes =3D st.f_bfree * st.f_frsize;
> +        fs->avail_bytes =3D st.f_bavail * st.f_frsize;
>
>          fs->has_total_bytes =3D true;
> -        fs->has_used_bytes =3D true;
> +        fs->has_free_bytes =3D true;
> +        fs->has_avail_bytes =3D true;
>      }
>
>      g_free(devpath);
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b8efe31897..1cce3c1df5 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1030,9 +1030,12 @@
>  #
>  # @type: file system type string
>  #
> -# @used-bytes: file system used bytes (since 3.0)
> +# @total-bytes: total file system size in bytes (since 8.3)
>  #
> -# @total-bytes: non-root file system total bytes (since 3.0)
> +# @free-bytes: amount of free space in file system in bytes (since 8.3)
>

I don't agree with this as it breaks backward compatibility. If we want to
get
these changes we should release a new version with both old and new fields
and mark old as deprecated to get a time for everyone who uses this
API updates its solutions.

A similar thing was with replacing the 'blacklist' command line.
https://gitlab.com/qemu-project/qemu/-/commit/582a098e6ca00dd42f317dad8affd=
13e5a20bc42
Currently, we support both 'blacklist' and 'block-rpcs' command line option=
s
but the first one wrote a warning.

@Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> @Philippe Mathieu-Dau=
d=C3=A9
<philmd@linaro.org>
What do you think about this?


> +#
> +# @avail-bytes: amount of free space in file system for unprivileged
> +#     users in bytes (since 8.3)
>  #
>  # @disk: an array of disk hardware information that the volume lies
>  #     on, which may be empty if the disk type is not supported
> @@ -1041,8 +1044,8 @@
>  ##
>  { 'struct': 'GuestFilesystemInfo',
>    'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
> -           '*used-bytes': 'uint64', '*total-bytes': 'uint64',
> -           'disk': ['GuestDiskAddress']} }
> +           '*total-bytes': 'uint64', '*free-bytes': 'uint64',
> +           '*avail-bytes': 'uint64', 'disk': ['GuestDiskAddress']} }
>
>  ##
>  # @guest-get-fsinfo:
> --
> 2.39.3
>
>
>

--00000000000089ccc306124d63dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>Kons=
tantin Kostiuk.</div></div></div></div><br></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 26, 2024 at 7:02=E2=
=80=AFPM Andrey Drobyshev &lt;<a href=3D"mailto:andrey.drobyshev@virtuozzo.=
com">andrey.drobyshev@virtuozzo.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Since the commit 25b5ff1a86 (&quot;qga: =
add mountpoint usage info to<br>
GuestFilesystemInfo&quot;) we have 2 values reported in guest-get-fsinfo:<b=
r>
used =3D (f_blocks - f_bfree), total =3D (f_blocks - f_bfree + f_bavail).<b=
r>
These calculations might be obscure for the end user and require one to<br>
actually get into QGA source to understand how they&#39;re obtained. Let&#3=
9;s<br>
just report the values f_blocks, f_bfree, f_bavail (in bytes) from<br>
statvfs() as they are, letting the user decide how to process them further.=
<br>
<br>
Originally-by: Yuri Pudgorodskiy &lt;<a href=3D"mailto:yur@virtuozzo.com" t=
arget=3D"_blank">yur@virtuozzo.com</a>&gt;<br>
Signed-off-by: Andrey Drobyshev &lt;<a href=3D"mailto:andrey.drobyshev@virt=
uozzo.com" target=3D"_blank">andrey.drobyshev@virtuozzo.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 16 +++++++---------<br>
=C2=A0qga/qapi-schema.json | 11 +++++++----<br>
=C2=A02 files changed, 14 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 26008db497..752ef509d0 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1554,8 +1554,7 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct=
 FsMount *mount,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GuestFilesystemInfo *fs =3D g_malloc0(sizeof(*fs));<br>
-=C2=A0 =C2=A0 struct statvfs buf;<br>
-=C2=A0 =C2=A0 unsigned long used, nonroot_total, fr_size;<br>
+=C2=A0 =C2=A0 struct statvfs st;<br>
=C2=A0 =C2=A0 =C2=A0char *devpath =3D g_strdup_printf(&quot;/sys/dev/block/=
%u:%u&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mount-&gt;devmaj=
or, mount-&gt;devminor);<br>
<br>
@@ -1563,15 +1562,14 @@ static GuestFilesystemInfo *build_guest_fsinfo(stru=
ct FsMount *mount,<br>
=C2=A0 =C2=A0 =C2=A0fs-&gt;type =3D g_strdup(mount-&gt;devtype);<br>
=C2=A0 =C2=A0 =C2=A0build_guest_fsinfo_for_device(devpath, fs, errp);<br>
<br>
-=C2=A0 =C2=A0 if (statvfs(fs-&gt;mountpoint, &amp;buf) =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fr_size =3D buf.f_frsize;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 used =3D buf.f_blocks - buf.f_bfree;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 nonroot_total =3D used + buf.f_bavail;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;used_bytes =3D used * fr_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;total_bytes =3D nonroot_total * fr_size=
;<br>
+=C2=A0 =C2=A0 if (statvfs(fs-&gt;mountpoint, &amp;st) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;total_bytes =3D st.f_blocks * st.f_frsi=
ze;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;free_bytes =3D st.f_bfree * st.f_frsize=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;avail_bytes =3D st.f_bavail * st.f_frsi=
ze;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fs-&gt;has_total_bytes =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_used_bytes =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_free_bytes =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_avail_bytes =3D true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(devpath);<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index b8efe31897..1cce3c1df5 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1030,9 +1030,12 @@<br>
=C2=A0#<br>
=C2=A0# @type: file system type string<br>
=C2=A0#<br>
-# @used-bytes: file system used bytes (since 3.0)<br>
+# @total-bytes: total file system size in bytes (since 8.3)<br>
=C2=A0#<br>
-# @total-bytes: non-root file system total bytes (since 3.0)<br>
+# @free-bytes: amount of free space in file system in bytes (since 8.3)<br=
></blockquote><div><br></div><div>I don&#39;t agree with this as it breaks =
backward compatibility. If we want to get <br></div><div>these changes we s=
hould release a new version with both old and new fields</div><div>and mark=
 old as deprecated to get a time for everyone who uses this</div><div>API u=
pdates its solutions.</div><div><br></div><div>A similar thing was with rep=
lacing the &#39;blacklist&#39; command line.<br></div><div><a href=3D"https=
://gitlab.com/qemu-project/qemu/-/commit/582a098e6ca00dd42f317dad8affd13e5a=
20bc42">https://gitlab.com/qemu-project/qemu/-/commit/582a098e6ca00dd42f317=
dad8affd13e5a20bc42</a></div><div>Currently, we support both &#39;blacklist=
&#39; and &#39;block-rpcs&#39; command line options</div><div>but the first=
 one wrote a warning.</div><div><br></div><div><a class=3D"gmail_plusreply"=
 id=3D"plusReplyChip-0" href=3D"mailto:marcandre.lureau@redhat.com" tabinde=
x=3D"-1">@Marc-Andr=C3=A9 Lureau</a>=C2=A0<a class=3D"gmail_plusreply" id=
=3D"plusReplyChip-1" href=3D"mailto:philmd@linaro.org" tabindex=3D"-1">@Phi=
lippe Mathieu-Daud=C3=A9</a>=C2=A0</div><div>What do you think about this?<=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
+#<br>
+# @avail-bytes: amount of free space in file system for unprivileged<br>
+#=C2=A0 =C2=A0 =C2=A0users in bytes (since 8.3)<br>
=C2=A0#<br>
=C2=A0# @disk: an array of disk hardware information that the volume lies<b=
r>
=C2=A0#=C2=A0 =C2=A0 =C2=A0on, which may be empty if the disk type is not s=
upported<br>
@@ -1041,8 +1044,8 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestFilesystemInfo&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;name&#39;: &#39;str&#39;, &#39;mountpoin=
t&#39;: &#39;str&#39;, &#39;type&#39;: &#39;str&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*used-bytes&#39;: &#39;uint6=
4&#39;, &#39;*total-bytes&#39;: &#39;uint64&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;disk&#39;: [&#39;GuestDiskAd=
dress&#39;]} }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*total-bytes&#39;: &#39;uint=
64&#39;, &#39;*free-bytes&#39;: &#39;uint64&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*avail-bytes&#39;: &#39;uint=
64&#39;, &#39;disk&#39;: [&#39;GuestDiskAddress&#39;]} }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-fsinfo:<br>
-- <br>
2.39.3<br>
<br>
<br>
</blockquote></div></div>

--00000000000089ccc306124d63dd--


