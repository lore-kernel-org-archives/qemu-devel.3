Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3182E7718E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 01:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPtZw-0000Jc-Lr; Mon, 23 Dec 2024 20:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1tPtZs-0000JJ-Uk; Mon, 23 Dec 2024 20:19:16 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1tPtZr-0000u1-E3; Mon, 23 Dec 2024 20:19:16 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so53565665e9.0; 
 Mon, 23 Dec 2024 17:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735003152; x=1735607952; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=icHMOdTLlBoLRm2V+ko9U8j9P3ZZxZhmiISyu8Xt3jU=;
 b=bCzvCvn4LWMWQPqNUn5LWq6FLZEf62VPfsaQ0nFOd35h5yK6+8rrP8nySa+cj1UKJh
 BWnwCl8M+t2EaL0NEz6fiQLji2dVwGwAJbZBYcq85cy8TJTyB9YFFY/yS6jBHuTvsSTc
 a+IGLk6Jp9M8e0jhwvYpaK0Bn7PAtc/om5bDSoQPvExOSKp0G34wTimrj3BdLNHx3FMa
 jk/ZXAIKOVurclPY67+ELYvZYT6t92irmZon+6lpzcZa9ku1gxIQ5ifbp9lE0vCntdZw
 J6ZM8tO/6m0s9bgS3DIcvrYTk8+Kg2zEo2a6QN4Usp5Yzzk4qWejYMNMT8cTTVWDHP1j
 fFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735003152; x=1735607952;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=icHMOdTLlBoLRm2V+ko9U8j9P3ZZxZhmiISyu8Xt3jU=;
 b=JWIioM3su1YrvaTcd4Bn+diCvHJiZkBqCrRRcWZC43kEbluRc+bkBibmRlXjqfAyR6
 xn9HknUm+rnuB1DALxu5ssQ0dHzRfjTTgQdSpJPrWPv8c0NXJpjVVNRe9msV8138zaea
 zxwHffyae9OyAeOGN+jYdC7Ce5D99ZmDuB57XWSyx94TGemwBYWFjsaiFMA18CmNufGv
 ijsqKd+HhBbURu9twiequxlA/TrsGogo7X1eRZAnyU5kAFUdgaHmrvnJS9aYk1D8NTSC
 Lg/ZUcCdVq2wtI0w8lPsly/z7FOAKEwBwvXoQbN0gpUkr7F61OF422c0RybgKx9QosuG
 f+Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg5RpQTrAj0dvel2D5KJzwZaFMJRo16vFibgpoizJcaJs1s7mj81t1YlKFmQdD40DtmozSxWo21Q==@nongnu.org
X-Gm-Message-State: AOJu0YypNis5FoD0SnstQrwgW31qf4rbr2i0f0DwYbF4SsNS0nlapvmh
 ZI59tng2B1pzv0AsZCUdrzIDaVj6aEKlq0cTmdgUUNxxBFXzU0Q+zEDGjmZlUViyNrbb+0U78Oz
 O7GkB6OFvM0Zpt19b7mVxYFPIk48=
X-Gm-Gg: ASbGncuj1I07MEvI33IpJLmHqwXTUfHu8JPlpP1Fr8fNxse4OyLeWu0J2H7c7uB8pbC
 wNuYVwUHvffSSd5HeLkcDzxbRCoX1FQ9kxJsJqKnpbcAxCGvToXG7Vp9eHUbOfa+9FFYE8H4=
X-Google-Smtp-Source: AGHT+IEwi/43OxJ7RnzpZb/UJZT5yb0R1hfZohYolbI6P8rX/ewqjSHgpBqwz4YH3mp8iXYb3EArXIIepEIPPbftmuE=
X-Received: by 2002:a7b:ce18:0:b0:436:6ddf:7a27 with SMTP id
 5b1f17b1804b1-4366ddf7c00mr107194425e9.23.1735003152255; Mon, 23 Dec 2024
 17:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20241220213103.6314-1-philmd@linaro.org>
In-Reply-To: <20241220213103.6314-1-philmd@linaro.org>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Tue, 24 Dec 2024 06:48:59 +0530
Message-ID: <CAEuJdmoex3fHcxd4hmdnezvKff9cER4uiTH7dyxjttTLA3Kc_w@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] hw/ppc: Remove tswap() calls
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000009314180629f9e6e6"
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=harsh.prateek.bora@gmail.com; helo=mail-wm1-x32a.google.com
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

--0000000000009314180629f9e6e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Dec, 2024, 3:02=E2=80=AFam Philippe Mathieu-Daud=C3=A9, <philmd@=
linaro.org>
wrote:

> Since v3:
> - Addressed Nick & Harsh  review comments
>
> Remove the tswap() calls on ePAPR, and convert
> them to big-endian LD/ST API on sPAPR.
>
> Build-tested only.
>
> Philippe Mathieu-Daud=C3=A9 (6):
>   hw/ppc/spapr: Convert HPTE() macro as hpte_get_ptr() method
>   hw/ppc/spapr: Convert HPTE_VALID() macro as hpte_is_valid() method
>   hw/ppc/spapr: Convert HPTE_DIRTY() macro as hpte_is_dirty() method
>   hw/ppc/spapr: Convert CLEAN_HPTE() macro as hpte_set_clean() method
>   hw/ppc/spapr: Convert DIRTY_HPTE() macro as hpte_set_dirty() method
>   hw/ppc/epapr: Do not swap ePAPR magic value
>

For spapr:
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


>  hw/ppc/sam460ex.c     |  2 +-
>  hw/ppc/spapr.c        | 63 +++++++++++++++++++++++++++++--------------
>  hw/ppc/virtex_ml507.c |  2 +-
>  3 files changed, 45 insertions(+), 22 deletions(-)
>
> --
> 2.47.1
>
>
>

--0000000000009314180629f9e6e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, 21 Dec, 2024, 3:02=E2=80=
=AFam Philippe Mathieu-Daud=C3=A9, &lt;<a href=3D"mailto:philmd@linaro.org"=
>philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">S=
ince v3:<br>
- Addressed Nick &amp; Harsh=C2=A0 review comments<br>
<br>
Remove the tswap() calls on ePAPR, and convert<br>
them to big-endian LD/ST API on sPAPR.<br>
<br>
Build-tested only.<br>
<br>
Philippe Mathieu-Daud=C3=A9 (6):<br>
=C2=A0 hw/ppc/spapr: Convert HPTE() macro as hpte_get_ptr() method<br>
=C2=A0 hw/ppc/spapr: Convert HPTE_VALID() macro as hpte_is_valid() method<b=
r>
=C2=A0 hw/ppc/spapr: Convert HPTE_DIRTY() macro as hpte_is_dirty() method<b=
r>
=C2=A0 hw/ppc/spapr: Convert CLEAN_HPTE() macro as hpte_set_clean() method<=
br>
=C2=A0 hw/ppc/spapr: Convert DIRTY_HPTE() macro as hpte_set_dirty() method<=
br>
=C2=A0 hw/ppc/epapr: Do not swap ePAPR magic value<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">For spapr:</div><div dir=
=3D"auto">Reviewed-by: Harsh Prateek Bora &lt;<a href=3D"mailto:harshpb@lin=
ux.ibm.com">harshpb@linux.ibm.com</a>&gt;</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
<br>
=C2=A0hw/ppc/sam460ex.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0hw/ppc/spapr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 63 ++++++++++++++++++++++=
+++++++--------------<br>
=C2=A0hw/ppc/virtex_ml507.c |=C2=A0 2 +-<br>
=C2=A03 files changed, 45 insertions(+), 22 deletions(-)<br>
<br>
-- <br>
2.47.1<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000009314180629f9e6e6--

