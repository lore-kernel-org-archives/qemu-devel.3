Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1689CD128D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 15:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrJwd-0007hA-9c; Mon, 01 Apr 2024 11:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rrJwc-0007h2-Db
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 11:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rrJwa-0007nG-C4
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 11:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711986690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d5tUeSvRuS3lzWWD5uA+jrkdUfMPQU6dNWakY/jEesY=;
 b=Ndso13/jc+Ap/gE7An0tfSVqQXC5UK8CsaeYsI0kZFivTXWyjuRVSEJqUBWdqcyRnVwb9P
 vEsYI0wCZVFjFwVt5m3QlkDvGeC/f122/lsKAmeJMaS2QCcdo6w380vHya+KE2sbSJFCe+
 dQtuI8NuGuqQyJccYFJijQFqny5r1VY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-yH7X_IMKN96vyWZ5me_k8Q-1; Mon, 01 Apr 2024 11:51:28 -0400
X-MC-Unique: yH7X_IMKN96vyWZ5me_k8Q-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d6d3815f9bso43407231fa.0
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 08:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711986687; x=1712591487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d5tUeSvRuS3lzWWD5uA+jrkdUfMPQU6dNWakY/jEesY=;
 b=sOjKboQGhz/VPB4p6IOnbcMshPuEg3yI8DHJygeFIcp2r5ChC4lAQmG5gbcltZMKHt
 Z51GhgjAgX5MnQJszuYKLsY9dpJqqiRUjaIKlsrniDlZyTEghXtNl5yuxqe4lcZZk74b
 2HSuKWaO5CSpLLhzvx0hVbvUJnoXu7Dz/1KHKDoevrK4GdFgmJUq6+GNDXV4tzPAhlqF
 BYQAV/yGs8ZjLjixAoSB6ufle4vigmx+PzG4X1f77+Imxp/nRevH4vo2iPBQr6VuzFOh
 0y3VgfJKG8KZa2IqSfVgJjsvvKPdBmR7WK7PyRVar70pcrooT9yEvc8eFYhZi4IyYz7w
 koNg==
X-Gm-Message-State: AOJu0YxJzqyxHQ0O6K02r0hHbS/gbmvUxta56lVMMEzTgGUtPFt/SgKj
 WfRDHaXn1B7UwggU6GYauMHHxPiKMtQHZdqGx0Z0AUXZS4E7Unzkn9yurYQwkJp8BrXgYUgodaN
 1f6XJqjVN8Cx2XVm01tTaP386XFibC3jzGCx9hGPTIfmhh25blOu6xnnBhwkNPbhr915mPF85u+
 LSMIIHhWmVH5kqheJIo+o7jCwdezU=
X-Received: by 2002:a2e:9157:0:b0:2d6:a73f:234e with SMTP id
 q23-20020a2e9157000000b002d6a73f234emr7536927ljg.11.1711986687250; 
 Mon, 01 Apr 2024 08:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3hgSGWdwPZGnw618MeMHI90d2egdaQkIDc1L0oKRZCnBkM2vlfL2AI90WFJY35KiNzIT8OkuTKvSe1ckTq4I=
X-Received: by 2002:a2e:9157:0:b0:2d6:a73f:234e with SMTP id
 q23-20020a2e9157000000b002d6a73f234emr7536904ljg.11.1711986686829; Mon, 01
 Apr 2024 08:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240320161648.158226-1-andrey.drobyshev@virtuozzo.com>
 <20240320161648.158226-2-andrey.drobyshev@virtuozzo.com>
 <Zf1f1yajMqqF6G6t@redhat.com>
 <d3c9b601-8363-420b-8a3b-13dc50f0469f@virtuozzo.com>
 <280cd27c-d771-4c23-9612-c3fdcd556114@virtuozzo.com>
In-Reply-To: <280cd27c-d771-4c23-9612-c3fdcd556114@virtuozzo.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 1 Apr 2024 18:51:15 +0300
Message-ID: <CAPMcbCrw0+ofi1oM0QFXorMzdDum8jYR-+to69WXFxheSx=-pQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] qga: guest-get-fsinfo: add optional
 'total-bytes-privileged' field
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, philmd@linaro.org, 
 den@virtuozzo.com, berrange@redhat.com
Content-Type: multipart/alternative; boundary="000000000000543fe406150af646"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000543fe406150af646
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrey,

I am ok with these changes.
No need new iteration with the version change, I will update before merging=
.

I will merge it after release.

Best Regards,
Konstantin Kostiuk.


On Mon, Apr 1, 2024 at 5:49=E2=80=AFPM Andrey Drobyshev <
andrey.drobyshev@virtuozzo.com> wrote:

> On 3/22/24 15:17, Andrey Drobyshev wrote:
> > On 3/22/24 12:39, Daniel P. Berrang=C3=A9 wrote:
> >> On Wed, Mar 20, 2024 at 06:16:42PM +0200, Andrey Drobyshev wrote:
> >>> Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
> >>> GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo:
> >>> used =3D (f_blocks - f_bfree), total =3D (f_blocks - f_bfree + f_bava=
il) as
> >>> returned by statvfs(3).  While on Windows guests that's all we can ge=
t
> >>> with GetDiskFreeSpaceExA(), on POSIX guests we might also be
> interested in
> >>> total file system size, as it's visible for root user.  Let's add an
> >>> optional field 'total-bytes-privileged' to GuestFilesystemInfo struct=
,
> >>> which'd only be reported on POSIX and represent f_blocks value as
> returned
> >>> by statvfs(3).
> >>>
> >>> While here, also tweak the docs to reflect better where those values
> >>> come from.
> >>>
> >>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >>> ---
> >>>  qga/commands-posix.c | 2 ++
> >>>  qga/commands-win32.c | 1 +
> >>>  qga/qapi-schema.json | 7 +++++--
> >>>  3 files changed, 8 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> >>> index 26008db497..7df2d72e9f 100644
> >>> --- a/qga/commands-posix.c
> >>> +++ b/qga/commands-posix.c
> >>> @@ -1569,8 +1569,10 @@ static GuestFilesystemInfo
> *build_guest_fsinfo(struct FsMount *mount,
> >>>          nonroot_total =3D used + buf.f_bavail;
> >>>          fs->used_bytes =3D used * fr_size;
> >>>          fs->total_bytes =3D nonroot_total * fr_size;
> >>> +        fs->total_bytes_privileged =3D buf.f_blocks * fr_size;
> >>>
> >>>          fs->has_total_bytes =3D true;
> >>> +        fs->has_total_bytes_privileged =3D true;
> >>>          fs->has_used_bytes =3D true;
> >>>      }
> >>>
> >>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> >>> index 6242737b00..6fee0e1e6f 100644
> >>> --- a/qga/commands-win32.c
> >>> +++ b/qga/commands-win32.c
> >>> @@ -1143,6 +1143,7 @@ static GuestFilesystemInfo
> *build_guest_fsinfo(char *guid, Error **errp)
> >>>      fs =3D g_malloc(sizeof(*fs));
> >>>      fs->name =3D g_strdup(guid);
> >>>      fs->has_total_bytes =3D false;
> >>> +    fs->has_total_bytes_privileged =3D false;
> >>>      fs->has_used_bytes =3D false;
> >>>      if (len =3D=3D 0) {
> >>>          fs->mountpoint =3D g_strdup("System Reserved");
> >>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> >>> index 9554b566a7..dcc469b268 100644
> >>> --- a/qga/qapi-schema.json
> >>> +++ b/qga/qapi-schema.json
> >>> @@ -1026,7 +1026,10 @@
> >>>  #
> >>>  # @used-bytes: file system used bytes (since 3.0)
> >>>  #
> >>> -# @total-bytes: non-root file system total bytes (since 3.0)
> >>> +# @total-bytes: filesystem capacity in bytes for unprivileged users
> (since 3.0)
> >>> +#
> >>> +# @total-bytes-privileged: filesystem capacity in bytes for
> privileged users
> >>> +#     (since 9.0)
> >>
> >> Will need to be '9.1', not '9.0', since we don't accept new features
> >> during freeze periods.
> >>
> >>>  #
> >>>  # @disk: an array of disk hardware information that the volume lies
> >>>  #     on, which may be empty if the disk type is not supported
> >>> @@ -1036,7 +1039,7 @@
> >>>  { 'struct': 'GuestFilesystemInfo',
> >>>    'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
> >>>             '*used-bytes': 'uint64', '*total-bytes': 'uint64',
> >>> -           'disk': ['GuestDiskAddress']} }
> >>> +           '*total-bytes-privileged': 'uint64', 'disk':
> ['GuestDiskAddress']} }
> >>>
> >>>  ##
> >>>  # @guest-get-fsinfo:
> >>
> >> Assuming the version is changed:
> >>
> >>   Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >>
> >> With regards,
> >> Daniel
> >
> > Thanks, Daniel.
> >
> > @kkostiuk do I need to send one more iteration with the version change?
> > Whatever is most convenient for you.
> >
> > Andrey
>
> Ping
>
>

--000000000000543fe406150af646
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Andrey,</div><div><br></div><div>I am ok with thes=
e changes. <br></div><div>No need new iteration with the version change, I =
will update before merging.</div><div><br></div><div>I will merge it after =
release.<br></div><div><br></div><div><div><div dir=3D"ltr" class=3D"gmail_=
signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Re=
gards,</div><div>Konstantin Kostiuk.</div></div></div></div><br></div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mo=
n, Apr 1, 2024 at 5:49=E2=80=AFPM Andrey Drobyshev &lt;<a href=3D"mailto:an=
drey.drobyshev@virtuozzo.com">andrey.drobyshev@virtuozzo.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 3/22/24 15:1=
7, Andrey Drobyshev wrote:<br>
&gt; On 3/22/24 12:39, Daniel P. Berrang=C3=A9 wrote:<br>
&gt;&gt; On Wed, Mar 20, 2024 at 06:16:42PM +0200, Andrey Drobyshev wrote:<=
br>
&gt;&gt;&gt; Since the commit 25b5ff1a86 (&quot;qga: add mountpoint usage i=
nfo to<br>
&gt;&gt;&gt; GuestFilesystemInfo&quot;) we have 2 values reported in guest-=
get-fsinfo:<br>
&gt;&gt;&gt; used =3D (f_blocks - f_bfree), total =3D (f_blocks - f_bfree +=
 f_bavail) as<br>
&gt;&gt;&gt; returned by statvfs(3).=C2=A0 While on Windows guests that&#39=
;s all we can get<br>
&gt;&gt;&gt; with GetDiskFreeSpaceExA(), on POSIX guests we might also be i=
nterested in<br>
&gt;&gt;&gt; total file system size, as it&#39;s visible for root user.=C2=
=A0 Let&#39;s add an<br>
&gt;&gt;&gt; optional field &#39;total-bytes-privileged&#39; to GuestFilesy=
stemInfo struct,<br>
&gt;&gt;&gt; which&#39;d only be reported on POSIX and represent f_blocks v=
alue as returned<br>
&gt;&gt;&gt; by statvfs(3).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; While here, also tweak the docs to reflect better where those =
values<br>
&gt;&gt;&gt; come from.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Andrey Drobyshev &lt;<a href=3D"mailto:andrey.d=
robyshev@virtuozzo.com" target=3D"_blank">andrey.drobyshev@virtuozzo.com</a=
>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 qga/commands-posix.c | 2 ++<br>
&gt;&gt;&gt;=C2=A0 qga/commands-win32.c | 1 +<br>
&gt;&gt;&gt;=C2=A0 qga/qapi-schema.json | 7 +++++--<br>
&gt;&gt;&gt;=C2=A0 3 files changed, 8 insertions(+), 2 deletions(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
&gt;&gt;&gt; index 26008db497..7df2d72e9f 100644<br>
&gt;&gt;&gt; --- a/qga/commands-posix.c<br>
&gt;&gt;&gt; +++ b/qga/commands-posix.c<br>
&gt;&gt;&gt; @@ -1569,8 +1569,10 @@ static GuestFilesystemInfo *build_guest=
_fsinfo(struct FsMount *mount,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nonroot_total =3D used + buf=
.f_bavail;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;used_bytes =3D used *=
 fr_size;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;total_bytes =3D nonro=
ot_total * fr_size;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;total_bytes_privileged =3D=
 buf.f_blocks * fr_size;<br>
&gt;&gt;&gt;=C2=A0 <br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_total_bytes =3D t=
rue;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_total_bytes_privileged=
 =3D true;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_used_bytes =3D tr=
ue;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;=C2=A0 <br>
&gt;&gt;&gt; diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
&gt;&gt;&gt; index 6242737b00..6fee0e1e6f 100644<br>
&gt;&gt;&gt; --- a/qga/commands-win32.c<br>
&gt;&gt;&gt; +++ b/qga/commands-win32.c<br>
&gt;&gt;&gt; @@ -1143,6 +1143,7 @@ static GuestFilesystemInfo *build_guest_=
fsinfo(char *guid, Error **errp)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fs =3D g_malloc(sizeof(*fs));<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fs-&gt;name =3D g_strdup(guid);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fs-&gt;has_total_bytes =3D false;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 fs-&gt;has_total_bytes_privileged =3D false;<br=
>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 fs-&gt;has_used_bytes =3D false;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (len =3D=3D 0) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;mountpoint =3D g_strd=
up(&quot;System Reserved&quot;);<br>
&gt;&gt;&gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt;&gt;&gt; index 9554b566a7..dcc469b268 100644<br>
&gt;&gt;&gt; --- a/qga/qapi-schema.json<br>
&gt;&gt;&gt; +++ b/qga/qapi-schema.json<br>
&gt;&gt;&gt; @@ -1026,7 +1026,10 @@<br>
&gt;&gt;&gt;=C2=A0 #<br>
&gt;&gt;&gt;=C2=A0 # @used-bytes: file system used bytes (since 3.0)<br>
&gt;&gt;&gt;=C2=A0 #<br>
&gt;&gt;&gt; -# @total-bytes: non-root file system total bytes (since 3.0)<=
br>
&gt;&gt;&gt; +# @total-bytes: filesystem capacity in bytes for unprivileged=
 users (since 3.0)<br>
&gt;&gt;&gt; +#<br>
&gt;&gt;&gt; +# @total-bytes-privileged: filesystem capacity in bytes for p=
rivileged users<br>
&gt;&gt;&gt; +#=C2=A0 =C2=A0 =C2=A0(since 9.0)<br>
&gt;&gt;<br>
&gt;&gt; Will need to be &#39;9.1&#39;, not &#39;9.0&#39;, since we don&#39=
;t accept new features<br>
&gt;&gt; during freeze periods.<br>
&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 #<br>
&gt;&gt;&gt;=C2=A0 # @disk: an array of disk hardware information that the =
volume lies<br>
&gt;&gt;&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0on, which may be empty if the disk =
type is not supported<br>
&gt;&gt;&gt; @@ -1036,7 +1039,7 @@<br>
&gt;&gt;&gt;=C2=A0 { &#39;struct&#39;: &#39;GuestFilesystemInfo&#39;,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 &#39;data&#39;: {&#39;name&#39;: &#39;str&#39;, &=
#39;mountpoint&#39;: &#39;str&#39;, &#39;type&#39;: &#39;str&#39;,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*used-byte=
s&#39;: &#39;uint64&#39;, &#39;*total-bytes&#39;: &#39;uint64&#39;,<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;disk&#39;: [&#3=
9;GuestDiskAddress&#39;]} }<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*total-bytes-pr=
ivileged&#39;: &#39;uint64&#39;, &#39;disk&#39;: [&#39;GuestDiskAddress&#39=
;]} }<br>
&gt;&gt;&gt;=C2=A0 <br>
&gt;&gt;&gt;=C2=A0 ##<br>
&gt;&gt;&gt;=C2=A0 # @guest-get-fsinfo:<br>
&gt;&gt;<br>
&gt;&gt; Assuming the version is changed:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"ma=
ilto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; With regards,<br>
&gt;&gt; Daniel<br>
&gt; <br>
&gt; Thanks, Daniel.<br>
&gt; <br>
&gt; @kkostiuk do I need to send one more iteration with the version change=
?<br>
&gt; Whatever is most convenient for you.<br>
&gt; <br>
&gt; Andrey<br>
<br>
Ping<br>
<br>
</blockquote></div>

--000000000000543fe406150af646--


