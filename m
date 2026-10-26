Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451BD606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pZIQjqwI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLS36-0007Me-78; Mon, 26 Oct 2026 17:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1xLS33-0007L4-SL
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:16:05 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1xLS31-00069n-Tm
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:16:05 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b06c0794cfso29933967b3.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793049362; cv=none;
 d=google.com; s=arc-20260327;
 b=M0kp7oOiDZwip0ixzGqYMP8X+yKxlbqV3vSYo5FHDblgGczNNiUHJ65sul/B/JYpz+
 zK2fDBaDDD8kBmrBWZxx0PTEwYonjC2vpojb64SC+XZ68GQSgfTZ7XL0+i1UuTs3ZI+V
 b49hmZNa8PnOguo1n12mIemgluW1YPEXjUo86byYbr2h6f6M16t11X5JrDb14ZX9rhhX
 98eAkLO5uuGS55nQT4OKpcueN9l++rCLt+LwCgi72ImZ/x32GpW4S/v5CKDwk/rEN2Sy
 SYxA1hIUa9wb/AzV0MtTHLxuYJkotLrHUqu0Ytxg75kvPkpx6GW1z9xdD/I6siChT41B
 FfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=41yFpMtqE3wplLn2MAYf8R+uso8EnJb09++TCDSfjGI=;
 fh=i/7RqEP4WRR2x+xnf5oVJS8DzcNyzognBo+4XJldFoI=;
 b=sG1Z9G2X7Q/nAmwtRyEIhWJVqwnQLS26sfuPRTFU43KHb5u44oG1ltoEv8dGMu1Y7b
 5zl2FumE0LAB5NDybn0OHg4tlfME1gVhsde87DayCpi1Kdk7Vzh3FHaSwUQRWmmxpzdn
 Hu70pd4SKkAGnca4mhBL1WrCGWE2Wo8Vh/gYK220p+HqEfG/Erzd0iku09efnnOyg9pN
 sN0CdJa6Vml719kRYXK064LJ3OPv+q/9j403JMVDGPEy0Qf8zJUEMZHE2GaHaFPwDT5n
 OstK5CkdJ0JpOdnNPVWxmoguiimXs0HQ50+ZbPBcNrn8Nd9vywT3Zo5L7loq1pcYlzjL
 LxMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793049362; x=1793654162; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=41yFpMtqE3wplLn2MAYf8R+uso8EnJb09++TCDSfjGI=;
 b=pZIQjqwIIa95TGudJEyl5L0grBGV8twnjGuPV9q6QGKm8C7IR+6B6h5E8sLQ7vRmaM
 f4xAMppsY9SF4evEOIFdGmD8uqT5bfwXSqajgZF7IW5U71w30TTSLX1kcH6Y9Ux7T6DU
 6W4sjREGPv3YUn4rIuDISoVtyWhw3wj8V4bXXBJCK197vVV1znpeUR7NRfXbb3mKQyZk
 HfmeM7f/OAOkzN2l9EpJieAVRgidiSVMVqvxuIsn2l2tT9JOu5v0mjzxb4NSgmyETbaS
 +WEIMuRFtI9O1mwVucef7dgkOH5i/N9gokSkDCrmb8AYjImOEvt0l1dMBRlahRBFZlIK
 MVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793049362; x=1793654162;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=41yFpMtqE3wplLn2MAYf8R+uso8EnJb09++TCDSfjGI=;
 b=I4umYR43lbUN5c5ap+nZK4ryysN/gIGXE06jdZ3eOs2V/8he3yxZAWDXJRkB+PLjUz
 E3/h+D6YdnMFAExHeHfDYoFi/Hu8gvutHHFjb6xjeMyBHZ1MvU42JTBSyWQOqWyl8wsv
 LNoMpTEx24UKMmqeym6VjQ+u5P4sYIsKDocKPVoe+F+ytkIrNsNacgcCeGtipDGJ6mQt
 qzaRKHzeIhPOAmKm/Y0cTSK9lChfobOd24JUPbENmOdlWIbUNteJ2/xKUA4e5KAm3uG3
 VhGutyhGVXc65g3/dQb5Te0VGANvicGvTg+r5OzlD6jz0L8bfJoD5OG1mc4j1BOHYEyg
 Y9Lw==
X-Forwarded-Encrypted: i=1;
 AKwUvBykr7DZb9q+99dh7Skn0sNn9G2lsvSUhf5sanEpGraHxe4CqXeUF1WUuCcZhgn7HWl+strS785EBN+q@nongnu.org
X-Gm-Message-State: AFq9FYJlXDI9Dc8o7GZmCoZwvPb7Jy5+ZtXRtywaTe/cKBBgtROWzS5v
 YjoGi4Ze0u/+q4PeOjD0hSjqB2p9oablteG3ipVSASxqPOojUS8KR1Jyf2STztp06ijAX4JrcHY
 zKZKQz5U7e1inv14HQRlfVvTW5NM8s6I=
X-Gm-Gg: AYBFou2ovOl5uIzT6oQBhpU0URc7PkInaJ1g038HS6n5/QPmOD7ewCCFZ2tcsgtE629
 BIeJ/vsLoBxvgRzqBqk3QqkNYyP7U3OVBUhlvx894epUfGg/X/AYgIx4eY9R8SA5KKHeM0jFyjv
 ig6J3fq/LIy037QO0M4DFjXTOJ78NVI/z2xLVZElhc2gvpzPl2XRpY5/cbbYo0Yf6C/yh32WTG9
 0p0ddlbMfr79+OkG+l39jb2EbJ5r2jvTLP3sSXqG8DH5+4DNaza1/OPz76cmflaICBByYtHQ1Lw
 M4i4w5uhwONu69EN4FlGe+ksY+xyTx0TNtxoU2DUyGXCIoqlSQbP/IlmtXmEfWUKNWnKqW9koyR
 V1PTM8wD1PAf+GfZoWevAlxPgQ1z9Gm5QAnu2bmI=
X-Received: by 2002:a05:690c:dd6:b0:8b0:cee8:53cf with SMTP id
 00721157ae682-8b1669cb374mr65640797b3.3.1793049362240; Mon, 26 Oct 2026
 14:16:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023153150.1710372-1-peter.maydell@linaro.org>
In-Reply-To: <20261023153150.1710372-1-peter.maydell@linaro.org>
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Mon, 26 Oct 2026 22:15:51 +0100
X-Gm-Features: AclHuK94R0hhYGC6zq59C2BXJk6qgATQeFl2N8vU2ICxvVDt68RMgdhW2zQWzj8
Message-ID: <CABtshVSC3gw+juhvnr9AYUdro-ADkBZRgEhrJPC443OrFmtOkA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/allwinner-h3-dramc: Avoid shift by negative amount
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000004d1c7e065ec4d65b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-yw1-x112c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000004d1c7e065ec4d65b
Content-Type: text/plain; charset="UTF-8"

Looks good to me.

On Fri, Oct 23, 2026, 17:31 Peter Maydell <peter.maydell@linaro.org> wrote:

> In allwinner_h3_dramc_map_rows(), we take a row_bits count from a
> register, and calculate (1 << (row_bits - 3)).  If the guest programs
> row_bits to less than 3 then this is undefined behaviour.
>
> Treat overly small row_bits values as "doesn't match actual RAM
> size".
>
> Fixes: b71d0385e97e ("hw/arm/allwinner-h3: add SDRAM controller device")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4210
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/allwinner-h3-dramc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
> index 10d929a3039..2a4b33aa182 100644
> --- a/hw/misc/allwinner-h3-dramc.c
> +++ b/hw/misc/allwinner-h3-dramc.c
> @@ -78,7 +78,7 @@ static void allwinner_h3_dramc_map_rows(AwH3DramCtlState
> *s, uint8_t row_bits,
>          }
>      }
>
> -    if (s->ram_size == (1 << (row_bits - 3))) {
> +    if (row_bits >= 3 && s->ram_size == (1 << (row_bits - 3))) {
>          /* When row bits is the expected value, remove the mirror */
>          memory_region_set_enabled(&s->row_mirror_alias, false);
>          trace_allwinner_h3_dramc_rowmirror_disable();
> --
> 2.43.0
>


Reviewed-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>

Best regards,
Strahinja

>

--0000000000004d1c7e065ec4d65b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Looks good to me.<br><br><div class=3D"gmail_quote" dir=
=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 2026, 17:31=
 Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_b=
lank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">In allwinner_h3_dramc_map_rows(), we take a r=
ow_bits count from a<br>
register, and calculate (1 &lt;&lt; (row_bits - 3)).=C2=A0 If the guest pro=
grams<br>
row_bits to less than 3 then this is undefined behaviour.<br>
<br>
Treat overly small row_bits values as &quot;doesn&#39;t match actual RAM<br=
>
size&quot;.<br>
<br>
Fixes: b71d0385e97e (&quot;hw/arm/allwinner-h3: add SDRAM controller device=
&quot;)<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/4210=
" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://gitlab=
.com/qemu-project/qemu/-/work_items/4210</a><br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" rel=3D"noreferrer noreferrer" target=3D"_blank">peter.maydell@linaro.org<=
/a>&gt;<br>
---<br>
=C2=A0hw/misc/allwinner-h3-dramc.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c<br=
>
index 10d929a3039..2a4b33aa182 100644<br>
--- a/hw/misc/allwinner-h3-dramc.c<br>
+++ b/hw/misc/allwinner-h3-dramc.c<br>
@@ -78,7 +78,7 @@ static void allwinner_h3_dramc_map_rows(AwH3DramCtlState =
*s, uint8_t row_bits,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (s-&gt;ram_size =3D=3D (1 &lt;&lt; (row_bits - 3))) {<br>
+=C2=A0 =C2=A0 if (row_bits &gt;=3D 3 &amp;&amp; s-&gt;ram_size =3D=3D (1 &=
lt;&lt; (row_bits - 3))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* When row bits is the expected value, r=
emove the mirror */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_set_enabled(&amp;s-&gt;row_=
mirror_alias, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_allwinner_h3_dramc_rowmirror_disabl=
e();<br>
-- <br>
2.43.0<br></blockquote></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Reviewed-by: Strahinja Jankovic &lt;<a href=3D"=
mailto:strahinja.p.jankovic@gmail.com">strahinja.p.jankovic@gmail.com</a>&g=
t;</div><div dir=3D"auto"><br></div><div dir=3D"auto">Best regards,</div><d=
iv dir=3D"auto">Strahinja</div><div class=3D"gmail_quote" dir=3D"auto"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"></blockquote></div></div>

--0000000000004d1c7e065ec4d65b--

