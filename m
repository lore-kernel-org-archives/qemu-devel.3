Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD55C61CE8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 20:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uO0Rm-0003fr-06; Sat, 07 Jun 2025 16:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hasueng@gmail.com>) id 1uO0Rk-0003fe-Iz
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 16:47:20 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hasueng@gmail.com>) id 1uO0Rj-0007du-0V
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 16:47:20 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b26ed340399so312418a12.2
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749329237; x=1749934037; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cov4CTkUpCsVkIe02HnV5LuoBWqru9K/KnaflJkBZ4U=;
 b=J8PMKH7DjROZ90cYixjvxiKeJH9vozbVRakaEx6ZM8nk0ofekGHM8AVWqEoPf9D05d
 axBH5q4w9NptSSuEn2MkoQ9UTihpEzY92EuskHJk3LdGvOwhNfGrsZa7FoNYcAc+TTw5
 5BKCCXOrSkvCq5btlsbPcaRFgZW96S4Tl6+dPe8Bvg7tBW22ZdEyqBbNB3Qf9Ouuwb/n
 KgTriT7ZHD2qNZCWoBKL+1Ll9fTQiPJ+krGB1RiNXi4u4yvWmpceu2BnybHKV7Ak/xAl
 D755cotVkoO9gSRFY4kaBFv2IuxR0oW4iTMnMJ7WZ7+JjxccDKGG9L5UuGTCshJlRL0N
 r1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749329237; x=1749934037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cov4CTkUpCsVkIe02HnV5LuoBWqru9K/KnaflJkBZ4U=;
 b=f1GNKJvSVS3/7Jfvw3TvP5xtMZTkctQIxgP5Dp8q1gxperIdp67AZT5QBldg6IWB34
 Lh4hNlhp3b/H465mf1sQZCY0bl5esOVE+p+z/xzhCqtmb1MSLUtz603p93wUUZ9CgRO7
 f+dJeDcds5CAnVFWfVQ2c1LziRWtFrMUNPzv4h9N1ZMAltnHQgHyNOtMRdEMYoJ1T/vF
 ILODH1ixmpoAkuglWZPoEsXhKlv2ljE6h5A34BzbCDdf2TiAkiYXeRJWqhYE4bGuHdNF
 p3kVHC1IPlt9CMBBx5k2N+IRmLxd5Bk8F1BLD77o15IZDar84xi3ZaecQ5wy0tRLqiR2
 dgzw==
X-Gm-Message-State: AOJu0YwHy14vyrzBmiFNjRmLXCN7J2+5V75ibMH4kQuBgx2FXsKKWxA8
 DwAaeQMaAuMY4YWvNN7YBm/GDzJELu6v3xw+tV+8hi4Khg2yqCt+Dk92HNGoYwRa3o4PPU0+YZr
 9ny4dKA7RNOaJZ8dws3Ok7WJ28edlVzonoGWp6i7gJg==
X-Gm-Gg: ASbGncsHiE7pnSyM0qu07FjmRlIVX7grJ/U4g3vp+jJfFZPpnedqtscZmYJQfaQJ3yc
 yPRnZkAHxRPXpfixWqQzfehRtLeZAKTUw59Rt2hZJUhWcvJKwkou+0VCLQfK75/+cefbTWwpXIM
 02Tdd53rh2dzTT9lev4FIA0tewVKJwr2jz
X-Google-Smtp-Source: AGHT+IFek/4m9kVnMbhoL/Ls2Uz5C3+22RcScpiON8+0xROQTABME0R7/WBMK1IMpu8lAcwTJreggQVm7VQktjV+dJY=
X-Received: by 2002:a17:902:e80e:b0:234:c549:da0c with SMTP id
 d9443c01a7336-23603f4afa2mr42586875ad.0.1749329237146; Sat, 07 Jun 2025
 13:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250607074747.56072-1-hasueng@gmail.com>
In-Reply-To: <20250607074747.56072-1-hasueng@gmail.com>
From: Haseung Bong <hasueng@gmail.com>
Date: Sun, 8 Jun 2025 05:47:06 +0900
X-Gm-Features: AX0GCFu0Xl2ExefpoTNwaKGqaVk9Qf1omZqU-rhva2ytkArbcEACfWkik_bS4ds
Message-ID: <CABD1TAvVd8GCufVVOVrR4KSM_QLKBceSg0fFKL5F5wnrPnPM0g@mail.gmail.com>
Subject: Re: [PATCH] tests/vm/README: fix documentation path in tests/vm/README
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, thuth@redhat.com
Content-Type: multipart/alternative; boundary="000000000000c682830637017316"
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=hasueng@gmail.com; helo=mail-pg1-x531.google.com
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

--000000000000c682830637017316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
This is a duplicate patch. Please ignore. Sorry for the noise.

Thanks,
Haseung Bong

2025=EB=85=84 6=EC=9B=94 7=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 4:49, Ha=
seung Bong <hasueng@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> From: "haseung.bong" <hasueng@gmail.com>
>
> The README file in tests/vm/ points to a non-existent file,
> docs/devel/testing.rst. Update the README to point to
> docs/devel/testing/main.rst, which now contains information
> about VM testing.
>
> Signed-off-by: Haseung Bong <hasueng@gmail.com>
> ---
>  tests/vm/README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/vm/README b/tests/vm/README
> index f9c04cc0e7..14ac323309 100644
> --- a/tests/vm/README
> +++ b/tests/vm/README
> @@ -1 +1 @@
> -See docs/devel/testing.rst for help.
> +See docs/devel/testing/main.rst for help.
> --
> 2.43.0
>
>

--000000000000c682830637017316
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br>This is a duplicate patch. Please ignore. Sorr=
y for the noise.<br><br>Thanks,<br></div>Haseung Bong<br></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">2025=EB=85=84 6=EC=9B=94 7=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 4:49=
, Haseung Bong &lt;<a href=3D"mailto:hasueng@gmail.com">hasueng@gmail.com</=
a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">From: &quot;haseung.bong&quot; &lt;<a href=3D"=
mailto:hasueng@gmail.com" target=3D"_blank">hasueng@gmail.com</a>&gt;<br>
<br>
The README file in tests/vm/ points to a non-existent file,<br>
docs/devel/testing.rst. Update the README to point to<br>
docs/devel/testing/main.rst, which now contains information<br>
about VM testing.<br>
<br>
Signed-off-by: Haseung Bong &lt;<a href=3D"mailto:hasueng@gmail.com" target=
=3D"_blank">hasueng@gmail.com</a>&gt;<br>
---<br>
=C2=A0tests/vm/README | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/tests/vm/README b/tests/vm/README<br>
index f9c04cc0e7..14ac323309 100644<br>
--- a/tests/vm/README<br>
+++ b/tests/vm/README<br>
@@ -1 +1 @@<br>
-See docs/devel/testing.rst for help.<br>
+See docs/devel/testing/main.rst for help.<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000c682830637017316--

