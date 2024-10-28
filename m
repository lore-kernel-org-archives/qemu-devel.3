Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE3DD13588
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 10:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5NRp-0000Ma-SJ; Mon, 28 Oct 2024 06:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t5NRk-0000Lt-3j
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 06:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t5NRi-0002GP-20
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 06:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730113079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dXDALZxjJ9UOcmpBlbhesD0wlObTlv44PyZdbOhhN/s=;
 b=A6Ct/8pMxyVJ9fWu9KYkopzeRQheYIFGqPMCYATAyQozfmV+AAPf6rhQ5Z56kWmOD/v/+J
 Fis3Wf8O9Kt5xWZ66UxcVssQzgc23t1zcJ9/4OthX4d/jJUxhTJh6vQNW09FUMpa2CFrzJ
 DdvuY/DeEfQwasOI/cpf/P1j8GVidGM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-L4d2vA8PPoaFpCkahULExQ-1; Mon, 28 Oct 2024 06:57:57 -0400
X-MC-Unique: L4d2vA8PPoaFpCkahULExQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cc32a0b26bso65602926d6.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 03:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730113077; x=1730717877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dXDALZxjJ9UOcmpBlbhesD0wlObTlv44PyZdbOhhN/s=;
 b=IsseF7jZ1lvbB4AuX69oqeBYz1PcE9ugW+N3eCtrsOzZ8FlORt8PGKGctG407MlT1m
 miZATBhcualen6lHRHw5rmLix/55TWKAV2/F8ORIu5okU4xzQtzwWWIgpxUBnBnyap6x
 i5purGlLGh/X4MZfN1kAhbsxZ1gK26/dbzpUqLD04dGZu+NBuope2J+JeQjVEyCtLDNG
 S+iRbwp0p2JlB7kUfE3AP1wVrYATaOlGmHmGh/pApeJhQGRjqRQ4ls9wDQ6BMJrJDRKc
 TZsn8mFwmF0KsdnEGbH/I2FQzvLI5DDNv4+Qujk21gwSpQoY8RKUeqr3Y8BEl7FkOWTE
 mVkg==
X-Gm-Message-State: AOJu0Yx9dmW+xlrI3Ky3FyDmxPjV1tejYV9L0duo0WRMtktVJem7cjRd
 eVUWKzAZdLBL0IvS01odgX5giU9u5dDp617WpyS9XKO+OvJIgGAPA/43zH1KvsNkK8A1qW1Uk3l
 9KztwxPSDc3xRY+ZD5NAin6gZ3DPBGbFLySLBubXHUpUgPHoHBnX/e7D/R6pIwn0QxXqywiy+yI
 2uSYjG5QE3qwm3ixgWtCGu66Ucxzs=
X-Received: by 2002:a05:6214:5348:b0:6d1:7453:f96b with SMTP id
 6a1803df08f44-6d1856fb9a8mr125969456d6.30.1730113077141; 
 Mon, 28 Oct 2024 03:57:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2Y4oBeklCPMxcJVE/ha+ExLDuTeOnCtcIiI+FIpF107BfVja7tZNut7CeQblIZKeqEMalZAFAhXpjbDbnBKU=
X-Received: by 2002:a05:6214:5348:b0:6d1:7453:f96b with SMTP id
 6a1803df08f44-6d1856fb9a8mr125969356d6.30.1730113076824; Mon, 28 Oct 2024
 03:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241002100634.162499-2-jean-louis@dupond.be>
 <b0a518bc-a600-4d0d-b1c9-5b43f95c90b9@dupond.be>
 <33d6a951-033d-4827-9d85-88fba69bf839@dupond.be>
In-Reply-To: <33d6a951-033d-4827-9d85-88fba69bf839@dupond.be>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 28 Oct 2024 12:57:46 +0200
Message-ID: <CAPMcbCrkzq3dGSJBkYZ_bU8qYTvXDokgJGkh563gg8OHGqB1wQ@mail.gmail.com>
Subject: Re: [PATCH] qga: skip bind mounts in fs list
To: Jean-Louis Dupond <jean-louis@dupond.be>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="0000000000005da75e06258757e1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000005da75e06258757e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Louis,

Thanks for your patch. I hope next week, I will test and review this patch.

Just a question, did you have a chance to test that this patch fix kernel
crash?

Best Regards,
Konstantin Kostiuk.


On Fri, Oct 25, 2024 at 1:06=E2=80=AFPM Jean-Louis Dupond <jean-louis@dupon=
d.be>
wrote:

> On 9/10/2024 10:34, Jean-Louis Dupond wrote:
> > On 2/10/2024 12:06, Jean-Louis Dupond wrote:
> >> The filesystem list in build_fs_mount_list should skip bind mounts.
> >> This because we end up in locking situations when doing fsFreeze. Like
> >> mentioned in [1] and [2].
> >>
> >> Next to that, the build_fs_mount_list call did a fallback via
> >> build_fs_mount_list_from_mtab if mountinfo did not exist.
> >> There it skipped bind mounts, but this is broken for newer OS.
> >> This as mounts does not return the path of the bind mount but the
> >> underlying dev/partition, so S_ISDIR will never return true in
> >> dev_major_minor call.
> >>
> >> This patch simply checks the existing devmajor:devminor tuple in the
> >> mounts, and if it already exists, this means we have the same devices
> >> mounted again, a bind mount. So skip this.
> >>
> >> Same approach is used in open-vm-tools [3].
> >>
> >> [1]: https://gitlab.com/qemu-project/qemu/-/issues/592
> >> [2]: https://gitlab.com/qemu-project/qemu/-/issues/520
> >> [3]:
> >>
> https://github.com/vmware/open-vm-tools/commit/d58847b497e212737007958c94=
5af1df22a8ab58
> >>
> >> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> >> ---
> >>   qga/commands-linux.c | 25 +++++++++++++++++++++++++
> >>   1 file changed, 25 insertions(+)
> >>
> >> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> >> index 51d5e3d927..426b040ab8 100644
> >> --- a/qga/commands-linux.c
> >> +++ b/qga/commands-linux.c
> >> @@ -59,6 +59,22 @@ static int dev_major_minor(const char *devpath,
> >>       return -1;
> >>   }
> >>   +/*
> >> + * Check if we already have the devmajor:devminor in the mounts
> >> + * If thats the case return true.
> >> + */
> >> +static bool dev_exists(FsMountList *mounts, unsigned int devmajor,
> >> unsigned int devminor)
> >> +{
> >> +    FsMount *mount;
> >> +
> >> +    QTAILQ_FOREACH(mount, mounts, next) {
> >> +        if (mount->devmajor =3D=3D devmajor && mount->devminor =3D=3D
> >> devminor) {
> >> +            return true;
> >> +        }
> >> +    }
> >> +    return false;
> >> +}
> >> +
> >>   static bool build_fs_mount_list_from_mtab(FsMountList *mounts,
> >> Error **errp)
> >>   {
> >>       struct mntent *ment;
> >> @@ -89,6 +105,10 @@ static bool
> >> build_fs_mount_list_from_mtab(FsMountList *mounts, Error **errp)
> >>               /* Skip bind mounts */
> >>               continue;
> >>           }
> >> +        if (dev_exists(mounts, devmajor, devminor)) {
> >> +            /* Skip already existing devices (bind mounts) */
> >> +            continue;
> >> +        }
> >>             mount =3D g_new0(FsMount, 1);
> >>           mount->dirname =3D g_strdup(ment->mnt_dir);
> >> @@ -172,6 +192,11 @@ bool build_fs_mount_list(FsMountList *mounts,
> >> Error **errp)
> >>               }
> >>           }
> >>   +        if (dev_exists(mounts, devmajor, devminor)) {
> >> +            /* Skip already existing devices (bind mounts) */
> >> +            continue;
> >> +        }
> >> +
> >>           mount =3D g_new0(FsMount, 1);
> >>           mount->dirname =3D g_strdup(line + dir_s);
> >>           mount->devtype =3D g_strdup(dash + type_s);
> >
> >
> > Ping + add kkostiuk@redhat.com as I missed him in the initial mail.
> >
>
> Any chance on a review or getting it merged?
> Think it's a good (of course ;)) improvement.
>
>

--0000000000005da75e06258757e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Jean-Louis,</div><div><br></div><div>Thanks for yo=
ur patch. I hope next week, I will test and review this patch. <br></div><d=
iv><br></div><div>Just a question, did you have a chance to test that this =
patch fix kernel crash? <br></div><div><br></div><div><div><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr"><div>Best Regards,</div><div>Konstantin Kostiuk.</div></div></div></div=
><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Fri, Oct 25, 2024 at 1:06=E2=80=AFPM Jean-Louis Dupond &lt;<a=
 href=3D"mailto:jean-louis@dupond.be">jean-louis@dupond.be</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 9/10/2024 10:3=
4, Jean-Louis Dupond wrote:<br>
&gt; On 2/10/2024 12:06, Jean-Louis Dupond wrote:<br>
&gt;&gt; The filesystem list in build_fs_mount_list should skip bind mounts=
.<br>
&gt;&gt; This because we end up in locking situations when doing fsFreeze. =
Like<br>
&gt;&gt; mentioned in [1] and [2].<br>
&gt;&gt;<br>
&gt;&gt; Next to that, the build_fs_mount_list call did a fallback via<br>
&gt;&gt; build_fs_mount_list_from_mtab if mountinfo did not exist.<br>
&gt;&gt; There it skipped bind mounts, but this is broken for newer OS.<br>
&gt;&gt; This as mounts does not return the path of the bind mount but the<=
br>
&gt;&gt; underlying dev/partition, so S_ISDIR will never return true in<br>
&gt;&gt; dev_major_minor call.<br>
&gt;&gt;<br>
&gt;&gt; This patch simply checks the existing devmajor:devminor tuple in t=
he<br>
&gt;&gt; mounts, and if it already exists, this means we have the same devi=
ces<br>
&gt;&gt; mounted again, a bind mount. So skip this.<br>
&gt;&gt;<br>
&gt;&gt; Same approach is used in open-vm-tools [3].<br>
&gt;&gt;<br>
&gt;&gt; [1]: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/592"=
 rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/=
-/issues/592</a><br>
&gt;&gt; [2]: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/520"=
 rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/=
-/issues/520</a><br>
&gt;&gt; [3]: <br>
&gt;&gt; <a href=3D"https://github.com/vmware/open-vm-tools/commit/d58847b4=
97e212737007958c945af1df22a8ab58" rel=3D"noreferrer" target=3D"_blank">http=
s://github.com/vmware/open-vm-tools/commit/d58847b497e212737007958c945af1df=
22a8ab58</a><br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Jean-Louis Dupond &lt;<a href=3D"mailto:jean-louis@=
dupond.be" target=3D"_blank">jean-louis@dupond.be</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 qga/commands-linux.c | 25 +++++++++++++++++++++++++<br>
&gt;&gt; =C2=A0 1 file changed, 25 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
&gt;&gt; index 51d5e3d927..426b040ab8 100644<br>
&gt;&gt; --- a/qga/commands-linux.c<br>
&gt;&gt; +++ b/qga/commands-linux.c<br>
&gt;&gt; @@ -59,6 +59,22 @@ static int dev_major_minor(const char *devpath,=
<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;<br>
&gt;&gt; =C2=A0 }<br>
&gt;&gt; =C2=A0 +/*<br>
&gt;&gt; + * Check if we already have the devmajor:devminor in the mounts<b=
r>
&gt;&gt; + * If thats the case return true.<br>
&gt;&gt; + */<br>
&gt;&gt; +static bool dev_exists(FsMountList *mounts, unsigned int devmajor=
, <br>
&gt;&gt; unsigned int devminor)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 FsMount *mount;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 QTAILQ_FOREACH(mount, mounts, next) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mount-&gt;devmajor=
 =3D=3D devmajor &amp;&amp; mount-&gt;devminor =3D=3D <br>
&gt;&gt; devminor) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return true;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 return false;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 static bool build_fs_mount_list_from_mtab(FsMountList *moun=
ts, <br>
&gt;&gt; Error **errp)<br>
&gt;&gt; =C2=A0 {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mntent *ment;<br>
&gt;&gt; @@ -89,6 +105,10 @@ static bool <br>
&gt;&gt; build_fs_mount_list_from_mtab(FsMountList *mounts, Error **errp)<b=
r>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* Skip bind mounts */<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 continue;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev_exists(mounts,=
 devmajor, devminor)) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* Skip already existing devices (bind mounts) */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 continue;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 moun=
t =3D g_new0(FsMount, 1);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mount-&gt;d=
irname =3D g_strdup(ment-&gt;mnt_dir);<br>
&gt;&gt; @@ -172,6 +192,11 @@ bool build_fs_mount_list(FsMountList *mounts,=
 <br>
&gt;&gt; Error **errp)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 }<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev_exists(=
mounts, devmajor, devminor)) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* Skip already existing devices (bind mounts) */<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 continue;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mount =3D g=
_new0(FsMount, 1);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mount-&gt;d=
irname =3D g_strdup(line + dir_s);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mount-&gt;d=
evtype =3D g_strdup(dash + type_s);<br>
&gt;<br>
&gt;<br>
&gt; Ping + add <a href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kk=
ostiuk@redhat.com</a> as I missed him in the initial mail.<br>
&gt;<br>
<br>
Any chance on a review or getting it merged?<br>
Think it&#39;s a good (of course ;)) improvement.<br>
<br>
</blockquote></div>

--0000000000005da75e06258757e1--


