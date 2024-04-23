Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A3EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 07:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzAN0-0005NU-3F; Tue, 23 Apr 2024 03:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rzAMx-0005NE-H3
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 03:15:11 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rzAMu-0001ik-I0
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 03:15:11 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2a58209b159so3450619a91.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 00:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1713856384; x=1714461184;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T0YJWMzqpvz3C7rEMAPM8EkwlAIx6xPmyD2jvLHmc7w=;
 b=yh8SvGfWqBaeiQu3w0laIQ5NH1X2MV5eE7XBv/L4kqpL4+Pzf1ZPAYwNqZ0wcnpGfU
 lJ8meOvWLTlK3eGzNaCJ7tlGPCzprm7X6pv7D0Ih/fzNhEddFdxNgv5owMnVRpYmiuGU
 RUzaOcoCnTf7qY59cCuKE9thNgtaySpql5VjPwk0ZDOXvXYWX5SDt3eQjpZ+kOymO3hm
 RmFgd+nfobw4UCJ8HYdN5IZERkp3lEfsBTKlE62jWQFpECZEkE1IkrvKWbj7FBJKF1Gi
 zQh+s0z04Ehnhkm48JGV8I6tl5AhDChVlCGWqOoBkPlGRrOuxqpgsc0JjN1SUcYUdps4
 Y5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713856384; x=1714461184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T0YJWMzqpvz3C7rEMAPM8EkwlAIx6xPmyD2jvLHmc7w=;
 b=P1gyc22IfzZyHWK2BcMwK0JHg1ZRo7ihESOJGc8gEULDCi9PaxruDs0oISm8l0Lxya
 LL8/nkXpGqk7diiulgeLn+f5vU6jFQljsfIyFZM0pWhHX1nev9/nF2MpAdVTa24EDBO8
 IhHw1uVNuFOm3oIAZEP2jOjqDLF4erpIEEE0bENfiYCtpkV7ZAfAO5rx9tRKeGDeV5IS
 O0NM211yL6zpNvDwNw/5zjwd8Uho2S+HC66Tx1csHWbTO3Zj/bDqRom3gyoVqt7rGgIz
 +Mj5jhJH9PhGfxwtRV3JSGC7d9NAKph0hoOkrIujkh+3Pl+rnYIeicfm5zQ/sf1JRcJS
 41+A==
X-Gm-Message-State: AOJu0Yy+p+Dbz1jpSK0KKutUqVXRyrZ9bxxN7E0doofjm4rYAL1ISN4v
 B3k1XIWKJ5FOB5Pkq0DxD6AXr39UcuqFTFPskHQNJvaQEnjdM2Y/IBxi5wqd7pJgIlEiT7J9/86
 Pg8HbMX2oyoxkleUt4uyUe8F6/0UBaA/CzrK/vQpFYLVpDXPVA01XNHbZ
X-Google-Smtp-Source: AGHT+IG1L0qtZTKsUfz9IarLJnFN9b0W8LnwcxvQZ+0wVasKrbY8cs7NSOA2cXg94gtc0g2zpVO4tKM365rUj7G8wxg=
X-Received: by 2002:a17:90a:bb16:b0:2a6:ff2e:dce0 with SMTP id
 u22-20020a17090abb1600b002a6ff2edce0mr10891727pjr.5.1713856383697; Tue, 23
 Apr 2024 00:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240423061925.254941-1-mii@sfc.wide.ad.jp>
In-Reply-To: <20240423061925.254941-1-mii@sfc.wide.ad.jp>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 23 Apr 2024 15:12:47 +0800
Message-ID: <CAK9dgmYwgaSPZ8rm1zmcDXJEYNPtXzE1i-+RUbnHkVHfyrjDig@mail.gmail.com>
Subject: Re: [PATCH] migration/dirtyrate: Fix segmentation fault
To: Masato Imai <mii@sfc.wide.ad.jp>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="000000000000f264e00616be4882"
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102c.google.com
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

--000000000000f264e00616be4882
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 2:19=E2=80=AFPM Masato Imai <mii@sfc.wide.ad.jp> wr=
ote:

> When the KVM acceleration parameter is not set, executing calc_dirty_rate
> with the -r option results in a segmentation fault due to accessing a
> null kvm_state pointer in the kvm_dirty_rate_enabled function.
>

s/kvm_dirty_rate_enabled/kvm_dirty_ring_enabled/

This commit adds a check for kvm_enabled to prevent segmentation faults.
>
> Signed-off-by: Masato Imai <mii@sfc.wide.ad.jp>
> ---
>  migration/dirtyrate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 1d2e85746f..4c1579c6e9 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -800,6 +800,8 @@ void qmp_calc_dirty_rate(int64_t calc_time,
>       * on the contrary, dirty bitmap mode is not.
>       */



     if (((mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_RING) &&
> +        !kvm_enabled()) ||
> +        ((mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_RING) &&

         !kvm_dirty_ring_enabled()) ||
>          ((mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP) &&

          kvm_dirty_ring_enabled())) {
>

This path may result in segmentation fault likewise, we can fix it together
by adding the following logic before this code:

    if (!kvm_enabled() &&
       (mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_RING ||
        mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP)) {
        error_setg(errp, ...
        return;
    }



> --
> 2.34.1
>
>
Thanks for your work,
Yong

--=20
Best regards

--000000000000f264e00616be4882
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 23, 20=
24 at 2:19=E2=80=AFPM Masato Imai &lt;<a href=3D"mailto:mii@sfc.wide.ad.jp"=
>mii@sfc.wide.ad.jp</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-styl=
e:solid;border-left-color:rgb(204,204,204);padding-left:1ex">When the KVM a=
cceleration parameter is not set, executing calc_dirty_rate<br>
with the -r option results in a segmentation fault due to accessing a<br>
null kvm_state pointer in the kvm_dirty_rate_enabled function.<br></blockqu=
ote><div>=C2=A0</div><div class=3D"gmail_default"><font face=3D"comic sans =
ms, sans-serif">s/kvm_dirty_rate_enabled/kvm_dirty_ring_enabled/</font></di=
v><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif"><br=
></font></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(=
204,204,204);padding-left:1ex">
This commit adds a check for kvm_enabled to prevent segmentation faults.<br=
>
<br>
Signed-off-by: Masato Imai &lt;<a href=3D"mailto:mii@sfc.wide.ad.jp" target=
=3D"_blank">mii@sfc.wide.ad.jp</a>&gt;<br>
---<br>
=C2=A0migration/dirtyrate.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c<br>
index 1d2e85746f..4c1579c6e9 100644<br>
--- a/migration/dirtyrate.c<br>
+++ b/migration/dirtyrate.c<br>
@@ -800,6 +800,8 @@ void qmp_calc_dirty_rate(int64_t calc_time,<br>
=C2=A0 =C2=A0 =C2=A0 * on the contrary, dirty bitmap mode is not.<br>
=C2=A0 =C2=A0 =C2=A0 */=C2=A0</blockquote><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:=
solid;border-left-color:rgb(204,204,204);padding-left:1ex">=C2=A0</blockquo=
te><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204=
);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0if (((mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_RING) &=
amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 !kvm_enabled()) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIRTY_RI=
NG) &amp;&amp;</blockquote><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-le=
ft-color:rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!kvm_dirty_ring_enabled()) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((mode =3D=3D DIRTY_RATE_MEASURE_MODE_DIR=
TY_BITMAP) &amp;&amp;=C2=A0</blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_dirty_ring_enabled())) {<br></blockq=
uote><div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-se=
rif"><br></font></div><div class=3D"gmail_default"><font face=3D"comic sans=
 ms, sans-serif">This path may result in segmentation fault<span class=3D"g=
mail-Apple-converted-space">=C2=A0likewise, we can fix it=C2=A0</span></fon=
t><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">together=
</span></div><div class=3D"gmail_default"><span style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif">by adding the following logic before this c=
ode:</span></div><div class=3D"gmail_default"><span style=3D"font-family:&q=
uot;comic sans ms&quot;,sans-serif"><br></span></div><div class=3D"gmail_de=
fault"><font face=3D"comic sans ms, sans-serif">=C2=A0 =C2=A0 if (!kvm_enab=
led() &amp;&amp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0(mode =3D=3D DIRTY_RATE_MEAS=
URE_MODE_DIRTY_RING ||<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D=3D DIRTY_RAT=
E_MEASURE_MODE_DIRTY_BITMAP)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(e=
rrp, ...<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br></font><div><font face=
=3D"comic sans ms, sans-serif">=C2=A0 =C2=A0 }</font></div></div></div><div=
 class=3D"gmail_default"><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
-- <br>
2.34.1<br>
<br>
</blockquote></div><div><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Thanks for your work,</div><=
div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,=
sans-serif"></div><div class=3D"gmail_default" style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif">Yong</div><div><br></div><span class=3D"gmai=
l_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature=
"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</f=
ont></div></div></div>

--000000000000f264e00616be4882--

