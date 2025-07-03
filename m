Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2F5C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFMY-0000AD-Gc; Thu, 03 Jul 2025 04:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFM7-0008Rk-FA; Thu, 03 Jul 2025 04:31:43 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFM5-0006az-MP; Thu, 03 Jul 2025 04:31:43 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e819ebc3144so6841856276.0; 
 Thu, 03 Jul 2025 01:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751531499; x=1752136299; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ACN3/5ZwuMHWPnIM2LvNkb6ZNX2drFxWaI640q4NOCk=;
 b=NlHEnfeDKaMMeRMARD7OfVUuwmxr74AI6pBvvv0uXS5grSxUlbXhytWtxMMD9Pwvxd
 N4diRdtY/o8g3F0S94v7p3SHw2fEvawCG3AXKwrt8alqDCKb87gJ4pt594mldOTntBxy
 Qo7S1QVgUfJmFXIp1LDgRdsfEs/RQFO3UzPrQhRGSd8rFMoxikoofO97ORNUhzxVxSkY
 dOLL78iZNS0wydiCaEBb/J3nIyTVWLV1E7ItCip2EM2sLiGflyVr4OR7kKyKr2fAP1Rx
 K49RXPgU4kdUYaHFyIKZvIHYSyWTYBJXEVB7zxaUYYlnW0tsDiICRpXzpOUZcvnXQXvv
 4I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751531499; x=1752136299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ACN3/5ZwuMHWPnIM2LvNkb6ZNX2drFxWaI640q4NOCk=;
 b=ZHjBq+62CTLlUwpPj3Xwg2Dm697V58dGBErLfxcD/QR0H2Q+X4k+YGsjnxJg3YOkVm
 UKnoSJaCWngMJ+I882tolfyFKf2Q3WpEGCR4kLOj+ARDj7yD6/1imIkRKNz4FOFukrcD
 7q2z9xEv431Yj3YKbF5uV05n5l26oAzzw3XNrwTUgRCCelB0EDxbta9/YOEYjtrqfXDu
 3ZhzBN9Q3zk+YBIHckc1auw9LM1UFBS3bM/ENNxiBs4d+JjpLNK4LrMtbGrapwVcbMew
 1LiI/AetIlIlxFiCX4GjgjGohkS+rqilUNbyBP+BFxbTFBqPKmEvjYvo1XvPAsPcPvkw
 pk9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCIF54Ee4MPKMS48K9+CfWkiL81BF+gY0dkrhjbMb4dYhP4Q8wvC6eBnusfMUKePNwaWbxEPmnKg==@nongnu.org
X-Gm-Message-State: AOJu0YyLeky5mK5zEBI9sDCvEXegqO4wtkeGPAd+3HjCiHq7U8y7kpan
 x5y27hc3yWCvIspnABBLEoqAWQYo0J5Owr35VC947Z61p79mhdOornqpEyVF7ydhAvZZhrhnRVg
 5D8Q9BdKK4Xph8VomP6HTlLN9EzXFcO0=
X-Gm-Gg: ASbGncscdhUj0j6NAMp3yTAwzw+MgH94Csg5rnvCRRTNIWLGKknuM2CaZXtEPEREkj2
 59NbaYfwA1sWUb1bv5O1YYh0iMUxEcAHWpxjK/CKsbtIX+ZB7XvfpTK/lVDp5j445YkriDzT3Tb
 dTi+hWDfZTnK6EpjpjzYc1IMpmf/dI28/INNmzTJ+EgZg=
X-Google-Smtp-Source: AGHT+IHAU7GG+0ZBhY1SJMSuyjy1D0pZhzrSXUi5Cfrvl0VDj+KwYzn4eOr88y87NKbpRWZhiRTPbfFNuJtrjqhefEI=
X-Received: by 2002:a05:6902:160d:b0:e87:a485:b430 with SMTP id
 3f1490d57ef6-e898f9caefbmr2933418276.35.1751531499377; Thu, 03 Jul 2025
 01:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-5-kosasihwilliam4@gmail.com>
 <bfdc5e5d-40fa-49e6-88d4-b70dcbdfd71d@linaro.org>
In-Reply-To: <bfdc5e5d-40fa-49e6-88d4-b70dcbdfd71d@linaro.org>
From: William Kosasih <kosasihwilliam4@gmail.com>
Date: Thu, 3 Jul 2025 18:01:27 +0930
X-Gm-Features: Ac12FXwtUjcfdobSiDA5d862nUAbeSn_L2C7ukHrAzJ_lWuieKk0BFB10fig9jc
Message-ID: <CAG66A_fib3v1HM=R4A6sv3OU77JmhY8VHpA_qJ6i1n42kiiNNA@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] target/arm: Fix VLDR helper load alignment checks
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d558cc0639023430"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-yb1-xb2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000d558cc0639023430
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Much better, thanks.

Cheers! :-)

Use MO_SB, MO_TESW here.

It won't matter for normal operation, but the sign of the operation is
> exposed to plugins.


Ah okay. I'll update accordingly and copy over your Reviewed-by line.
Thanks!

On Thu, Jul 3, 2025 at 12:14=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/2/25 05:19, William Kosasih wrote:
> > +DO_VLDR(vldrb_sh, MO_UB, 1, int8_t, ldb, 2, int16_t)
> > +DO_VLDR(vldrb_sw, MO_UB, 1, int8_t, ldb, 4, int32_t)
> ...
> > +DO_VLDR(vldrh_sw, MO_TEUW, 2, int16_t, ldw, 4, int32_t)
>
> Use MO_SB, MO_TESW here.
>
> It won't matter for normal operation, but the sign of the operation is
> exposed to plugins.
>
>
> r~
>

--000000000000d558cc0639023430
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Much bet=
ter, thanks.</blockquote><div>Cheers! :-)</div><div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Use MO_SB, MO_TESW here.</blockquote><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">It won&#39;t matter for no=
rmal operation, but the sign of the operation is exposed to plugins.=C2=A0<=
/blockquote><div><br></div><div>Ah okay. I&#39;ll update accordingly and co=
py over your Reviewed-by line. Thanks!=C2=A0</div></div><br><div class=3D"g=
mail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On =
Thu, Jul 3, 2025 at 12:14=E2=80=AFAM Richard Henderson &lt;<a href=3D"mailt=
o:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 7/2/25 05:19=
, William Kosasih wrote:<br>
&gt; +DO_VLDR(vldrb_sh, MO_UB, 1, int8_t, ldb, 2, int16_t)<br>
&gt; +DO_VLDR(vldrb_sw, MO_UB, 1, int8_t, ldb, 4, int32_t)<br>
...<br>
&gt; +DO_VLDR(vldrh_sw, MO_TEUW, 2, int16_t, ldw, 4, int32_t)<br>
<br>
Use MO_SB, MO_TESW here.<br>
<br>
It won&#39;t matter for normal operation, but the sign of the operation is =
exposed to plugins.<br>
<br>
<br>
r~<br>
</blockquote></div>

--000000000000d558cc0639023430--

