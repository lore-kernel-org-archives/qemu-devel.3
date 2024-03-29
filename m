Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B24ACD1288
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 01:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq0s0-0000WV-Va; Thu, 28 Mar 2024 21:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rq0rx-0000W0-Fn
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:17:21 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rq0rv-0005sT-9a
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 21:17:21 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29df0ca87d1so1317221a91.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 18:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1711674914; x=1712279714;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PD2cIsXwQSddSTUjJV9+NoNX0XUPMRUFW+hhYQ9wuHw=;
 b=jXXpLfLOWEa0OGBIp1L8uym80yuJ3R4/reaeOhcg+DSNuR4CNp3eop6mT1fUVLE0Rv
 l+9iLEOe4zfqSIo1EilZ2sm57bBIP0nwCLKu3DC1o+Ey0/u/1ACHZJoX6DhlUk/gcaKk
 dbFDCJAsie1vkL4RBzDMefT4pKygd5y59uKw47RX3y2/+A0EpuWWvgO7HRCW+as0ceuZ
 gJL7GQFyR4E7pTemBbjCas8JJOYYxaDrTq9LK57SusTBOMZTmKphfY6/mIV8s2UdDwxF
 8VzwndyzAVN/oWZjUq3HjknHaLQbw1NzYqIq5ZrzH//TAz7L2Qq9dTId+lXI6Gucthgp
 Hg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711674914; x=1712279714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PD2cIsXwQSddSTUjJV9+NoNX0XUPMRUFW+hhYQ9wuHw=;
 b=KqLpiGKrwHiKIeJaUEtYJTzIXxJnpaNN+oEkScpj295pkz9oG0K7OTudsxzIxVulR0
 soe+zJVegHwI77BIt3raxdr5zxjRqLiPBxeG6UaIqjVgdyJ33IpcKKIzwjdE3S2r6lGs
 zXcpdWKMGXy6Lp7/380kjlMdzIRSwjFOxbJPGit35ubuKkUSY6gK1Ahyc/9EFkZQe97J
 XJoYd3HEbLi1zKTbxKamc0J4ZJj+Ge6zOcd1vXQgs1nHyG/NqBiBKwm2/Skyhw7nsVKc
 lrDk9zXG5cdNdYmYth+Ak7DSc+cgQT1xGgAxZPNxdp+VJ2mh4AaA/BE/pspy9q9F2h72
 /InA==
X-Gm-Message-State: AOJu0YwEZUJBsePAj890SvRGELcQQHt/m8fkBKAhoEEEzJSv3upEUvYw
 ngKQZ9jqUWXNz/lCWeuyshiPO8rDFyAk9l/XBmHp0qwk02L8DhRGACu3+3F72tVxL4CGHUyvi7M
 Ii/dTwdXf2iP9mbE/oZPYBCbSCqENfEkf66yDdg==
X-Google-Smtp-Source: AGHT+IHn+yy0HS06djeECXzMFNb+Ypb12jI1ZICWHUgMxaADBFblafjSyu7FZCdlOHH5IqPQCmnH5Q7ywaIC5YtYAkE=
X-Received: by 2002:a17:90b:291:b0:29d:fdc5:8d07 with SMTP id
 az17-20020a17090b029100b0029dfdc58d07mr1014131pjb.13.1711674913718; Thu, 28
 Mar 2024 18:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-13-marcandre.lureau@redhat.com>
In-Reply-To: <20240328102052.3499331-13-marcandre.lureau@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 29 Mar 2024 09:14:57 +0800
Message-ID: <CAK9dgmZ_TcJbcsv5xWjf_hnhxE_asv7exPCib-QZAEiEnT_89w@mail.gmail.com>
Subject: Re: [PATCH 12/19] migration: fix -Werror=maybe-uninitialized
 false-positives
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, 
 Klaus Jensen <its@irrelevant.dk>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>, 
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003422890614c25f05"
Received-SPF: none client-ip=2607:f8b0:4864:20::102d;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000003422890614c25f05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 6:23=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> ../migration/dirtyrate.c:186:5: error: =E2=80=98records=E2=80=99 may be u=
sed uninitialized
> [-Werror=3Dmaybe-uninitialized]
> ../migration/dirtyrate.c:168:12: error: =E2=80=98gen_id=E2=80=99 may be u=
sed uninitialized
> [-Werror=3Dmaybe-uninitialized]
> ../migration/migration.c:2273:5: error: =E2=80=98file=E2=80=99 may be use=
d uninitialized
> [-Werror=3Dmaybe-uninitialized]
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  migration/dirtyrate.c | 4 ++--
>  migration/migration.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 1d2e85746f..22dd22922c 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -144,12 +144,12 @@ int64_t vcpu_calculate_dirtyrate(int64_t
> calc_time_ms,
>                                   unsigned int flag,
>                                   bool one_shot)
>  {
> -    DirtyPageRecord *records;
> +    DirtyPageRecord *records =3D NULL;
>      int64_t init_time_ms;
>      int64_t duration;
>      int64_t dirtyrate;
>      int i =3D 0;
> -    unsigned int gen_id;
> +    unsigned int gen_id =3D 0;
>
>  retry:
>      init_time_ms =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> diff --git a/migration/migration.c b/migration/migration.c
> index 9fe8fd2afd..412138ea94 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2247,7 +2247,7 @@ static bool
> migrate_handle_rp_resume_ack(MigrationState *s,
>   */
>  static void migration_release_dst_files(MigrationState *ms)
>  {
> -    QEMUFile *file;
> +    QEMUFile *file =3D NULL;
>
>      WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
>          /*
> --
> 2.44.0
>
>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>

Yong

--=20
Best regards

--0000000000003422890614c25f05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 28, 20=
24 at 6:23=E2=80=AFPM &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">ma=
rcandre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-lef=
t-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">From: Ma=
rc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" tar=
get=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>../migration/dirtyrate.c:186:5: error: =E2=80=98records=E2=80=99 may be=
 used uninitialized [-Werror=3Dmaybe-uninitialized]<br>../migration/dirtyra=
te.c:168:12: error: =E2=80=98gen_id=E2=80=99 may be used uninitialized [-We=
rror=3Dmaybe-uninitialized]<br>../migration/migration.c:2273:5: error: =E2=
=80=98file=E2=80=99 may be used uninitialized [-Werror=3Dmaybe-uninitialize=
d]<br>
<br>Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>=
---<br>=C2=A0migration/dirtyrate.c | 4 ++--<br>=C2=A0migration/migration.c =
| 2 +-<br>=C2=A02 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c<br>index 1d2=
e85746f..22dd22922c 100644<br>--- a/migration/dirtyrate.c<br>+++ b/migratio=
n/dirtyrate.c<br>@@ -144,12 +144,12 @@ int64_t vcpu_calculate_dirtyrate(int=
64_t calc_time_ms,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned=
 int flag,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool one_shot)<=
br>=C2=A0{<br>-=C2=A0 =C2=A0 DirtyPageRecord *records;<br>+=C2=A0 =C2=A0 Di=
rtyPageRecord *records =3D NULL;<br>=C2=A0 =C2=A0 =C2=A0int64_t init_time_m=
s;<br>=C2=A0 =C2=A0 =C2=A0int64_t duration;<br>=C2=A0 =C2=A0 =C2=A0int64_t =
dirtyrate;<br>=C2=A0 =C2=A0 =C2=A0int i =3D 0;<br>-=C2=A0 =C2=A0 unsigned i=
nt gen_id;<br>+=C2=A0 =C2=A0 unsigned int gen_id =3D 0;<br>
<br>=C2=A0retry:<br>=C2=A0 =C2=A0 =C2=A0init_time_ms =3D qemu_clock_get_ms(=
QEMU_CLOCK_REALTIME);<br>diff --git a/migration/migration.c b/migration/mig=
ration.c<br>index 9fe8fd2afd..412138ea94 100644<br>--- a/migration/migratio=
n.c<br>+++ b/migration/migration.c<br>@@ -2247,7 +2247,7 @@ static bool mig=
rate_handle_rp_resume_ack(MigrationState *s,<br>=C2=A0 */<br>=C2=A0static v=
oid migration_release_dst_files(MigrationState *ms)<br>=C2=A0{<br>-=C2=A0 =
=C2=A0 QEMUFile *file;<br>+=C2=A0 =C2=A0 QEMUFile *file =3D NULL;<br>
<br>=C2=A0 =C2=A0 =C2=A0WITH_QEMU_LOCK_GUARD(&amp;ms-&gt;qemu_file_lock) {<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>-- <br>2.44.0<br>
<br>
</blockquote></div><br clear=3D"all"><div><font face=3D"comic sans ms, sans=
-serif">Reviewed-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.co=
m">yong.huang@smartx.com</a>&gt;</font><br></div><div><br></div>Y<span clas=
s=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-ser=
if">ong</span><div><font face=3D"comic sans ms, sans-serif"><br></font></di=
v><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" cla=
ss=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-s=
erif">Best regards</font></div></div></div>

--0000000000003422890614c25f05--

