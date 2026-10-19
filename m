Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5BF606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sU2ptv8H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIsZl-0001IK-AV; Mon, 19 Oct 2026 14:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samanyu.goel16@gmail.com>)
 id 1xIqAz-0001aD-J7
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:25:29 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <samanyu.goel16@gmail.com>)
 id 1xIqAx-0001PI-Rm
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:25:29 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-9178aabd30dso21445396d6.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792427127; cv=none;
 d=google.com; s=arc-20260327;
 b=ciLB9V2Wjkk0+IH56t0ld8oOIoM6LzBOw73ybTzRTGhPlN2K2t0HixiQBjAlLLCbqc
 YsjJW+VP7JDQaWzf6D0uyJjLgvL/0uivNEwiH39K6lSye0pBFcDvmp5twf9h5VupQvRl
 dTQetUJ9Kz0RUUReM4505XlKkaegUNXmCsFv35vXhiQBt6VTNENlp26RT/HkyKjOCXqM
 sMkRCQqqR8XOYCV65DqT8fUNhCsPvYjbWn/fck+FFk0V/BDJDqgux9WazghBIwwIpR35
 FwchCFFljfoD3Kc+/DBrT1WZZzj2u1/tefooGXSEL5HOrxc3u9uMtVQMR63fAP0xOuao
 X6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Kl9iXwi4LOXMFWUH/bOEVH1gGOQOhUX9QNpEdl9gE5s=;
 fh=VQUMc85x8ANizanga/Uk0eVpSOWbPwTPWK+d/C2OKHM=;
 b=rIfLdrKMWQzAF6j5fuJ/7PdMOtlK+YALWy4bIxQcbU583C8bjWI0PYB6Fk7M0IbJXm
 Nfph4iXV455kDlPa7Ho6XwXaLw0v3C4o9bFLaxrJvNddy1jdZOFK8SgFHSwRXahY3LcI
 8Jk5Hr8kqqkVpjqHxqzDjNHm40LuGdf+6pO8SImKVrU9qADmGH828/y2e9VWkV+TGhZr
 AItirBPunN5MVuLvHFJCBg9wUaKFK5gZ/efIMpw8CPMtGrU+4NRJbJkI4eor2GR2xemT
 vbNJXqeLkiK5h5cFZzrJcbvAdw6KKJf8HqtMV780dtCDzSW9QUwdJX2lsk9208Fpmhym
 HSRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792427127; x=1793031927; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kl9iXwi4LOXMFWUH/bOEVH1gGOQOhUX9QNpEdl9gE5s=;
 b=sU2ptv8HVHkWLiemf0lv0Wg2yrbwMr7gqIDK+gobyw4Kj5F8TFTtCowR6M+67xqSvw
 d15/CuH/rKMu7k0jI1omNLOvfaVp/HETmpbreEudsONwTALMJtCgKOf1qnLVk/mFblhI
 gCy3s2WkQ+fSaS/A1Wt9kV4BG6khx1XR6IogoRGQt16/t6n+CdWFSFyKUIFWGXMpctqg
 ZtuV+ATetaSPdrByrG/j0qXKV6gnSbBi0+aTP+H+jR4ifegSjv5HwtZ6bBBalsJwN8qk
 iz5lyE5lG/TR5DR28HvMI1srBq3xpcFoYA6vrlJagZV5tPFiGGz8TJoybzQ+dKRdeKnW
 W4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792427127; x=1793031927;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Kl9iXwi4LOXMFWUH/bOEVH1gGOQOhUX9QNpEdl9gE5s=;
 b=fpURh2leaPb+qioTwVBUwawR1jq3z9t4bvlcWhhIu4bXddj30hvbuD2Jfmbqb+y2+p
 tw+NpWuC+Xa8Qs+3Tdk9v8A+fX9Yoc8cdJcMp3WVLb20V8V9Zcx1/Tcib10+5ucWn97y
 r1uLvQzF2M1pt4aUGsGqOzWmUsRodIZUqLyZgzLz2fBFrmeVkrYpeQ8IP1JuIPV2/ViW
 44U4PESWETWA0Z07jHjRKcffpMpZPYiF/R4K7X4tO9KTTcKet5iN0fZaf5x0ksd+6TGx
 4Udmw8nQ3WRdf7G47WGiBQ7s6Ikt7lo0iTDgsddaZ4nwZrAertZ8e8NRAZl11Vx2GbZm
 xjNA==
X-Gm-Message-State: AFq9FYLmS6w1Sd0eucUgfEEqbbqq+QMs9FKhcaIzVxWEujhatymNCFVJ
 sW7tyJXl1LZ+TUNV4xEELzGvBDmlBhSZ0SyZHuvE6sExvgKQkzjRTJ2/Jj7F3SLAkw3mUZUJnZo
 72hemcbzip3VADx7K9AtySqdjSdjgodc=
X-Gm-Gg: AYBFou32ZSFNpYB+jxMygYPdP4iCCK57FxiTNPBN6/xOJhwLemha8FOoWWihX3mVCks
 dN6ejn4Pp+bZLm9penOPs6YnrTrhjCM+JeQUrvgvR006+pz3Y/m4Dn/Vn16bEf6lzqfXCizqLpw
 26DtOJcp/X64oVattw4dW7yRADSilLSblGx67pVvkAcR9xWHBx35BAILRkHnZIrWQHngXe8pY9Q
 q135ivH5PyAN2R7EyeqbPNUrRE7AYXEmHtESjbebBayiljSYY+Jy81cV5vRACdoCbTr80ZC/Mmh
 kqW+kbamLu9iyjNIwa7JTMhL37O8yUopLTNn8yzR5hbUU6wdcdYn82fQKwi1uWGbrqVkYr9PT9y
 fQCgQH3xov9UnDqeXnrLL30GZNZ+/oXCbkuzqNcA=
X-Received: by 2002:a05:6214:2e48:b0:914:40fb:8e89 with SMTP id
 6a1803df08f44-91bdefbc857mr130146526d6.16.1792427126643; Mon, 19 Oct 2026
 09:25:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019155519.1302964-1-samanyu.goel16@gmail.com>
 <CAFEAcA_QYXpjXdC8oiTfn2Z3E99hW0j-mcDSqGLhKfKKex8VsA@mail.gmail.com>
In-Reply-To: <CAFEAcA_QYXpjXdC8oiTfn2Z3E99hW0j-mcDSqGLhKfKKex8VsA@mail.gmail.com>
From: Samanyu Goel <samanyu.goel16@gmail.com>
Date: Mon, 19 Oct 2026 21:55:13 +0530
X-Gm-Features: AclHuK9DfyJEFY0MWupTHVEG_JtaPCW-ax_PvkOfeG_WeYxSbGhg25GiD-Awng4
Message-ID: <CAL3-oQiGT2OSxq7casnW7JuwrCM5wa2L4SDpDe_As7+1hyEuww@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/exynos4210_combiner: Fix out of bounds access
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002b5f11065e33f621"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=samanyu.goel16@gmail.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 19 Oct 2026 14:59:09 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000002b5f11065e33f621
Content-Type: text/plain; charset="UTF-8"

Thanks Peter! Good catch on the read function, I totally missed that part
of it while focusing just on the main issue.

It makes complete sense to clean up both functions together in your fix.
This was a great learning experience for me, so thank you for taking the
time to review and share feedback.

Best,
Samanyu

On Mon, Oct 19, 2026, 21:46 Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 19 Oct 2026 at 16:55, Samanyu Goel <samanyu.goel16@gmail.com>
> wrote:
> >
> > In exynos4210_combiner_write(), the bounds check used req_quad_base_n
> > instead of grp_quad_base_n. Because req_quad_base_n counts 4-group blocks
> > rather than individual groups, invalid offsets were allowed through.
> >
> > For example, writing to offset 0x100 resulted in req_quad_base_n = 16,
> > passing the check (16 < 64). As verified in GDB, this caused
> > grp_quad_base_n to reach 64, leading to an out-of-bounds write at
> > s->group[64].
> >
> > Signed-off-by: Samanyu Goel <samanyu.goel16@gmail.com>
> > ---
>
> This is https://gitlab.com/qemu-project/qemu/-/work_items/4709.
>
> You've missed the equivalent check in the read function.
>
> As it happens I was working on this bug this afternoon; I have
> a patch nearly ready to send which fixes this and also cleans up
> some other oddities about the checks in these functions.
>
> thanks
> -- PMM
>

--0000000000002b5f11065e33f621
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks Peter! Good catch on the read function, I totally =
missed that part of it while focusing just on the main issue.<div dir=3D"au=
to">=C2=A0=C2=A0</div><div dir=3D"auto">It makes complete sense to clean up=
 both functions together in your fix. This was a great learning experience =
for me, so thank you for taking the time to review and share feedback.</div=
><div dir=3D"auto">=C2=A0=C2=A0</div><div dir=3D"auto">Best,</div><div dir=
=3D"auto">Samanyu</div></div><br><div class=3D"gmail_quote gmail_quote_cont=
ainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 19, 2026, 21:46 Pe=
ter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@l=
inaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Mon, =
19 Oct 2026 at 16:55, Samanyu Goel &lt;<a href=3D"mailto:samanyu.goel16@gma=
il.com" target=3D"_blank" rel=3D"noreferrer">samanyu.goel16@gmail.com</a>&g=
t; wrote:<br>
&gt;<br>
&gt; In exynos4210_combiner_write(), the bounds check used req_quad_base_n<=
br>
&gt; instead of grp_quad_base_n. Because req_quad_base_n counts 4-group blo=
cks<br>
&gt; rather than individual groups, invalid offsets were allowed through.<b=
r>
&gt;<br>
&gt; For example, writing to offset 0x100 resulted in req_quad_base_n =3D 1=
6,<br>
&gt; passing the check (16 &lt; 64). As verified in GDB, this caused<br>
&gt; grp_quad_base_n to reach 64, leading to an out-of-bounds write at<br>
&gt; s-&gt;group[64].<br>
&gt;<br>
&gt; Signed-off-by: Samanyu Goel &lt;<a href=3D"mailto:samanyu.goel16@gmail=
.com" target=3D"_blank" rel=3D"noreferrer">samanyu.goel16@gmail.com</a>&gt;=
<br>
&gt; ---<br>
<br>
This is <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/4709" =
rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-pro=
ject/qemu/-/work_items/4709</a>.<br>
<br>
You&#39;ve missed the equivalent check in the read function.<br>
<br>
As it happens I was working on this bug this afternoon; I have<br>
a patch nearly ready to send which fixes this and also cleans up<br>
some other oddities about the checks in these functions.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000002b5f11065e33f621--

