Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5656C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 06:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8wQ9-0005Tz-SU; Mon, 20 May 2024 02:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1s8wNZ-0004YE-QN
 for qemu-devel@nongnu.org; Mon, 20 May 2024 02:20:14 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1s8wNU-0002zs-8W
 for qemu-devel@nongnu.org; Mon, 20 May 2024 02:20:13 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4df2fcafc19so930181e0c.0
 for <qemu-devel@nongnu.org>; Sun, 19 May 2024 23:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716186007; x=1716790807; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nWSfJ8nkVTeAGPDn3NsDKwH+Hst3W+GgAFishFrG+fE=;
 b=F7hDNSRfKTfix0ZD7pqJXy5HDrbk/7Bju+hK3j0emTLQhQiB620Tt58lNpRoAJbcqP
 dQL8oNrQDABoUI3Dglpc7KJYvhe/kikaSejj8AurVtFviDKrWsN6FLWEJj+pLFQarDyp
 HQgj8ClIiQpiNmm1X+j9sc/8cWvFEoPGaCY17pUWFOrOMQAdL5nubF8Mii0fcWUAGTt0
 fl5/EKHpurcO7ZPsuzYAIuc0XxkgLGhPFJ1PWHoBndqjI3WeHo6yk5B/itd/qLpu4E6E
 TfjY30c80Nd/g6IJ0NfEL1t+E/bd2WWCtRPkTOh1/4TW5Y+bHAWisMN8uYTJ0WBdRdXL
 QQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716186007; x=1716790807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nWSfJ8nkVTeAGPDn3NsDKwH+Hst3W+GgAFishFrG+fE=;
 b=FV1aUoS5jvDWEryySZ+muSjMvcF3hBnjofU4O1HrrIKg5/ZVBVSbrgqAQ5DlNqk6pQ
 BhQHterg52a2IluXTRwTCUj7rwOLqsoZM+bupMhotBUsuk+7DXEeFxN9FdKxQjnxuP6/
 xn0313IRKPeIZH5gpCFPSzOJMRLvgv2m9DAuYCE4nprr9b76aLxVLWUZTW37aOWQJ5en
 IlhgQFmKQfuNLx1VGtl3mqhAmkxUPjBZP2dva1LCRsezgGXEE4JLA0YNlaojH7h093nZ
 ebozmjesKNZAGI4vUx7ScXsaCg0fdPT9qvgs/IyzizE2HBefRLv+gjgHl6/lIaPAbjw/
 zzbg==
X-Gm-Message-State: AOJu0Ywe5DXce35GIJSu+I7DP7v1jUSuBpsNcSCjgaqqST6Hnnq1jJaP
 nZjrPtl2hR9rk/RpEU5pB1Ib7SATQhy6CSnJ7Hev0eR4McPEZLdkQOoNc7E3fWX/3ZPVZ+7LP1i
 CF983GKQWEfAIS3ZPlHWn6T0Ug74=
X-Google-Smtp-Source: AGHT+IFtVe0Dojaf7BriRlx3lcAuYBXhZxT8xNshYXLRYx1PF/6RAsTA5N3djBisURqZ13fapeYGIX0ElDSZFnn7V2U=
X-Received: by 2002:a05:6122:908:b0:4df:281d:905 with SMTP id
 71dfb90a1353d-4df8839f4b2mr23827754e0c.16.1716186006879; Sun, 19 May 2024
 23:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAK4993hFKoQh14k1L4cMrHrDzBn23D59aM-PQJ3pu6uH4qfsGw@mail.gmail.com>
 <c220a44a-5265-4003-b386-cc633f21d44b@linaro.org>
In-Reply-To: <c220a44a-5265-4003-b386-cc633f21d44b@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 20 May 2024 09:19:30 +0300
Message-ID: <CAK4993gwpD+HmRJoVvYArEbn7868_2P9f3FV-qjKNGJgJCW+fA@mail.gmail.com>
Subject: Re: A question regarding TARGET_ALIGNED_ONLY flag
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000004f05000618dcb175"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=mrolnik@gmail.com; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000004f05000618dcb175
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Richard.

On Sun, May 19, 2024 at 6:26=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 5/19/24 16:23, Michael Rolnik wrote:
> > Hi all,
> >
> > Previously there was *TARGET_ALIGNED_ONLY* option that caused all memor=
y
> accessed to be
> > aligned, now it seems to be removed.
> > Is there a way to achieve memory access alignment with QEMU v9.0.0 when
> I am building a
> > custom target?
>
> Explicitly add MO_ALIGN to the MemOp argument of
> tcg_gen_qemu_{ld,st}_{i32,i64,i128}.
>
>
> r~
>
>

--=20
Best Regards,
Michael Rolnik

--0000000000004f05000618dcb175
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you Richard.</div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Sun, May 19, 2024 at 6:26=E2=80=AFPM =
Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richa=
rd.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On 5/19/24 16:23, Michael Rolnik wrote:<br>
&gt; Hi all,<br>
&gt; <br>
&gt; Previously there was *TARGET_ALIGNED_ONLY* option that caused all memo=
ry accessed to be <br>
&gt; aligned, now it seems to be removed.<br>
&gt; Is there a way to achieve memory access alignment=C2=A0with QEMU v9.0.=
0 when I am building a <br>
&gt; custom target?<br>
<br>
Explicitly add MO_ALIGN to the MemOp argument of tcg_gen_qemu_{ld,st}_{i32,=
i64,i128}.<br>
<br>
<br>
r~<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Be=
st Regards,<br>Michael Rolnik</div>

--0000000000004f05000618dcb175--

