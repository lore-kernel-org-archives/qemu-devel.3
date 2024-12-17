Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273E0E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 13:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNXTF-0000UC-WE; Tue, 17 Dec 2024 08:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tNXTD-0000Th-Mw
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 08:18:40 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tNXT9-0001dv-TN
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 08:18:39 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5f2d5b3c094so1131768eaf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 05:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1734441513; x=1735046313;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eJsEXxpj1ugkiSvxpg/rmwWIoK++7rM22YhsAMpQ50E=;
 b=ItQrqpnVjX1eG9C6aahBseFHFAReX4Y3L0mbm6YX/MpgGsx/g0PdJk7OCTnIggh/Rh
 1YpOOK7rYKBdwR0Cn8oL0wTjXSMbyEfQo5BSiXmJ0roZVhngSw4sqSYOdvmj6CfjjMRv
 N/ieJyj2+CmnXDKZA1f+V6MdWH3DAOAuSg2Ui/acVqFCUnhad7BZRvdkLYXY676I+jVn
 lJsteZVzS1hj9v+69+AnVrZx2T4OIW46Hr4cwcAPr03f2VIZN4m5CoFOpGSGoSlvcta6
 Yc734wmT9zh8bC2pafmFnoE3aZqQJe8MnpMOV89bqUJHhW8dba3k3wQhELi25Up9NtYc
 SGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734441513; x=1735046313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eJsEXxpj1ugkiSvxpg/rmwWIoK++7rM22YhsAMpQ50E=;
 b=gtOp/ojpNc9Wq+RbEkEdAYC+wM/DAJFLUPV16+orsVdj90E2dCZQjDlot7xT/WpNwp
 0eQCcZtvcaG/hnK47vSlAqM+NmJVUuut9/bOkZ0h5bn3/rtKi0y9wfsuTgUocvfucu77
 hcMvEl4wettS0RgQJplnFOoKrdD7Lznqut4F1xG2s/UVpUtvFMhQoNz3M5sASfeJ7NIC
 aTbRs+S/EyGiiq2vN9z4WJ3GPwA2QvkN149toDDMadV4rCm7srLPPzmy9BIYTnQvOvoY
 IqVhzOq4g7rKIfr1uAXTqNPN3GAbZGpwuUrE89x+ZwJFqAGizXAE+lsq3XAhNCDwDX4f
 VgCA==
X-Gm-Message-State: AOJu0YwscCuXvKLLtbvgyrVNzFjiIZuN5aEZEAWUUoSZ7FddZZKf5uEb
 MTz8hn9RYeecVbPrp82Q3mhQrW/CzXGMjnVnX6xNP0nX+iMuJNQ65h3COk3oJp1yh5YQ1l49DF5
 iDR7BBaPqLep4Y29xeNbwA+wAU0jewOKYopxyiA==
X-Gm-Gg: ASbGncsAQDNoyOc4qEtdIk/0PpaXwPwOANP6HwqW9hHoAVrHdsE+DR5EZ0zuPOkdHxV
 W/0ynFCBCjwao8hMt535dJ8M3qgCxy4nblnz5Z3Y=
X-Google-Smtp-Source: AGHT+IFh3nwPiDE6WfbU48TeQAecQsnBQShcz2b3rnwc/ePC/mqRukqCJFv0saKehADDTJ+oPfNp3jTfrUqzw285/Kw=
X-Received: by 2002:a05:6871:e492:b0:29e:2f3a:761a with SMTP id
 586e51a60fabf-2a3ac6d6449mr9283881fac.20.1734441512861; Tue, 17 Dec 2024
 05:18:32 -0800 (PST)
MIME-Version: 1.0
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-8-avihaih@nvidia.com>
 <CAK9dgmYowKNMD=5-PXGTL71K=sa22tuusZZPojkRQeMbaHyd3w@mail.gmail.com>
 <61d32bea-b6fd-4fdb-9c89-65aba23477c3@nvidia.com>
In-Reply-To: <61d32bea-b6fd-4fdb-9c89-65aba23477c3@nvidia.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 17 Dec 2024 21:18:17 +0800
Message-ID: <CAK9dgmbe9ez+6i2NTUha7rKy1UXhciaQpoSqGc=pNo8-ZR3RYw@mail.gmail.com>
Subject: Re: [PATCH 7/9] system/dirtylimit: Don't use migration_is_active()
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Maor Gottlieb <maorg@nvidia.com>
Content-Type: multipart/alternative; boundary="00000000000042166d06297722b9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--00000000000042166d06297722b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 5:47=E2=80=AFPM Avihai Horon <avihaih@nvidia.com> w=
rote:

>
> On 17/12/2024 5:01, Yong Huang wrote:
> > *External email: Use caution opening links or attachments*
> >
> >
> >
> >
> > On Mon, Dec 16, 2024 at 5:47=E2=80=AFPM Avihai Horon <avihaih@nvidia.co=
m> wrote:
> >
> >     vcpu_dirty_rate_stat_collect() uses migration_is_active() to detect
> >     whether migration is running or not, in order to get the correct
> dirty
> >     rate period value.
> >
> >     However, recently there has been an effort to simplify the migratio=
n
> >     status API and reduce it to a single migration_is_running() functio=
n.
> >
> >
> > Could you post the related links?
>
> Sure, it's here:
>
> https://lore.kernel.org/qemu-devel/20241024213056.1395400-1-peterx@redhat=
.com/
>
> Peter took only patches 1-5 of this series.
>
> Thanks.
>
> >
> >     To accommodate this, and since the same functionality can be achiev=
ed
> >     with migration_is_running(), use it instead of migration_is_active(=
).
> >
> >     Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> >     ---
> >      system/dirtylimit.c | 3 +--
> >      1 file changed, 1 insertion(+), 2 deletions(-)
> >
> >     diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> >     index ab20da34bb..d7a855c603 100644
> >     --- a/system/dirtylimit.c
> >     +++ b/system/dirtylimit.c
> >     @@ -80,8 +80,7 @@ static void vcpu_dirty_rate_stat_collect(void)
> >          int i =3D 0;
> >          int64_t period =3D DIRTYLIMIT_CALC_TIME_MS;
> >
> >     -    if (migrate_dirty_limit() &&
> >     -        migration_is_active()) {
> >     +    if (migrate_dirty_limit() && migration_is_running()) {
> >              period =3D migrate_vcpu_dirty_limit_period();
> >          }
> >
> >     --
> >     2.40.1
> >
> >
> >
> > --
> > Best regards
>

Thanks,

Reviewed-by: Hyman Huang <yong.huang@smartx.com>

--=20
Best regards

--00000000000042166d06297722b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Tue, Dec 17, 2024 at 5:47=E2=80=AFPM Avihai Horon &lt;<a href=3D"mai=
lto:avihaih@nvidia.com">avihaih@nvidia.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wid=
th:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-l=
eft:1ex"><br>
On 17/12/2024 5:01, Yong Huang wrote:<br>
&gt; *External email: Use caution opening links or attachments*<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Dec 16, 2024 at 5:47=E2=80=AFPM Avihai Horon &lt;<a href=3D"ma=
ilto:avihaih@nvidia.com" target=3D"_blank">avihaih@nvidia.com</a>&gt; wrote=
:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0vcpu_dirty_rate_stat_collect() uses migration_is_ac=
tive() to detect<br>
&gt;=C2=A0 =C2=A0 =C2=A0whether migration is running or not, in order to ge=
t the correct dirty<br>
&gt;=C2=A0 =C2=A0 =C2=A0rate period value.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0However, recently there has been an effort to simpl=
ify the migration<br>
&gt;=C2=A0 =C2=A0 =C2=A0status API and reduce it to a single migration_is_r=
unning() function.<br>
&gt;<br>
&gt;<br>
&gt; Could you post the related links?<br>
<br>
Sure, it&#39;s here: <br>
<a href=3D"https://lore.kernel.org/qemu-devel/20241024213056.1395400-1-pete=
rx@redhat.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.or=
g/qemu-devel/20241024213056.1395400-1-peterx@redhat.com/</a><br>
<br>
Peter took only patches 1-5 of this series.<br>
<br>
Thanks.<br>
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0To accommodate this, and since the same functionali=
ty can be achieved<br>
&gt;=C2=A0 =C2=A0 =C2=A0with migration_is_running(), use it instead of migr=
ation_is_active().<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Avihai Horon &lt;<a href=3D"mailto:a=
vihaih@nvidia.com" target=3D"_blank">avihaih@nvidia.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0system/dirtylimit.c | 3 +--<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 1 insertion(+), 2 deletions(-=
)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/system/dirtylimit.c b/system/dirtylimi=
t.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index ab20da34bb..d7a855c603 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/system/dirtylimit.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/system/dirtylimit.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -80,8 +80,7 @@ static void vcpu_dirty_rate_stat_=
collect(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0int i =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0int64_t period =3D DIRTYLIMIT_C=
ALC_TIME_MS;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 if (migrate_dirty_limit() &amp;&amp;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_is_active())=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (migrate_dirty_limit() &amp;&amp;=
 migration_is_running()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0period =3D migrat=
e_vcpu_dirty_limit_period();<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.40.1<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; -- <br>
&gt; Best regards<br>
</blockquote></div><div><br clear=3D"all"></div><div><div style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Thanks,</=
div></div><div><br></div><div><font face=3D"comic sans ms, sans-serif">Revi=
ewed-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com">yong.huan=
g@smartx.com</a>&gt;<span class=3D"gmail_default"></span></font></div><div>=
<span class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot=
;,sans-serif"><br></span></div><span class=3D"gmail_signature_prefix">-- </=
span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font =
face=3D"comic sans ms, sans-serif">Best regards</font></div></div></div>

--00000000000042166d06297722b9--

