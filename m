Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2976606A320
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AxpNytSc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV05J-0008D0-F0; Sun, 22 Nov 2026 00:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xV05I-0008Cs-AX
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 00:25:52 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xV05G-0008Hg-Go
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 00:25:52 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5c14f7768acso1774574e87.3
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 21:25:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795325148; cv=none;
 d=google.com; s=arc-20260327;
 b=Ia225hW+29cN5q0oyW6pSL16wP6Sye5CRqfgDUuEWSBOPpw+zRZDxhDLWRMKbDRwx0
 v0dWyjSBbEOLDxNbYCmTOIRfvwIGPRBvxQPF5vsMlB03T7JRiXZQRUkdbF5qoBUjagk6
 hVXhM8O6BW+TMd2SlGexq0urDKFjNB0kBLMYs5uV64mpucdfRTuEuccTWpn+aHFVPsgm
 Rmp+wMf0rr1cXOOiXOpjF3C+rK11ez8sYp1gMwy3yK3PVS2FI9YHKa5oR68RpSGUKNSq
 Y2LQCf++HapSoJZb4ALw/92aIUqWhlE/8jg0S1RKRN/+8OUn9lbzGZd1QbCbooyXRRBM
 s1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q1vkn3qCdeLpe6VOBfNT0BFUoKeFAMzfNrmgRoO2+dY=;
 fh=NApBPSZ7j1ViPcYnv8ZYewkViF4tMKjVZ5D1uXgAfGU=;
 b=UjrJG1TCJevKBOD90HSuwFJaFGqN+E012tc4MXUfXjJx6rSrbw2CUnpMp2BV10uKvI
 rss59Mpswe4jaD6+tTYL+TPNDWkxaMW1F4F4I5C2SCcScgxYKNC4Zocf0GXoFr7nrv/g
 tbdlyChbGk4cmV7uZ9sp+llpTaqeooePIrHi5kF0jpCrodohtwZDI80BZ5E6ymy9eloL
 eLBXip0Y/jGRqnIo1MbCi7cjP8dScv7aWjLHZ9dKfGB+SIKBj9buqcUFULf3g9ilKuGp
 nch0lJHwzPY0OLYUPbpt05Y4jzEmN+4WsJEdArczsHerOcSQaIwCuxhkPVSfhlJYlQ34
 wHtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795325148; x=1795929948; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Q1vkn3qCdeLpe6VOBfNT0BFUoKeFAMzfNrmgRoO2+dY=;
 b=AxpNytSc/lY6Ts+FVYQgJ6o4Hjv13aM7fepC9Sw0wOWaxTioF9qY+bpwDHTHd9cvM3
 S8KY5pLDCJIWVO+6ggTTWO4uRHY8+QskFw4VBEVP1FVpJNGIR5Fd2dDeM9DmNK1MxZc7
 iH0SZA82VXzNFA38g0OhQ3yeDhGKtOdnhopECgmCc1HqeWQ0nDmELP8PyGvDndyQSXHc
 efJ0k8nYe2MLoiSqMzAsrbyvTGc7VihA0FSp2Ibl0Ew4ph8w1LhE/7ZzbfG9yczmeTrH
 0CsNJVteTXc2qBxcJUhZSA1DVY2srQQ8/5BItq2s3TDKUeh4SV6STwDBSIxFrwM5A2QG
 cl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795325148; x=1795929948;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q1vkn3qCdeLpe6VOBfNT0BFUoKeFAMzfNrmgRoO2+dY=;
 b=EigxHTusXQXF7/QWbfUdAb4y4kvIIZkf3OjFxdL04uw4n/2SEmT45W88nlx/rLjwU+
 zS3HyuYhiWvhK1o8ail5M4uvM8g+gI7bvmsRriJrFeun+UmhZsRX6WUd81dEq5NiXFix
 EfMlRjH+VwSrZl2rH6OY38ZFsf9qH3kqWdxhfwqPNFB2I5wWt9J4BtYES5Y8WzKWK4+a
 9KeRS4tJRiRbICRxe10EA9454CVP1wiVfk8W79yHZ7b2iawelKdF37+slssGtjF6jO0d
 coYT7X2SSevg/qiMsUPGagH9MXo8WMu3OzUVu/Ij3dOOJWjCBXCf4PJhJd20RedFtOA0
 53MQ==
X-Gm-Message-State: APuU4Z9qNhzDNY4/DDeh/Moyj2L92kiZuXJ2Pruh3KeYPghZ4R1iibbR
 1LvkqseqYevpe6+SP1+p6U47/r4Q8lY7cj/CPrPEFBxI6r+o739vyjAekx15GTA6Gm/4o948hZR
 DiiG0Neu9gVAK+oBL/kcdp5SWn1psybNRz9/w
X-Gm-Gg: AZFdTZf1sHmDPqiTST9TEONhcyDaluGYtn9VBnhZXMnMQE9QotF9nP1d5CWqQeHEP82
 1rZIz9UtPCVNWAxaqrQXSGQV3madLBkyOClD02oKMf9aZyv0GPGa/0xq9n/cBo94ToD8njIBeTN
 dJchB+UaZj9dr9XFyt92APILRaiJOoMeaGmpIuJJpjxNWtaZhVigL4FJ63doaUlydOUxmv0CIIi
 SyGjfK4DjsnEb9i422dDjIjWGhkip9BAeibAJK9DDBrbOe2NdA4dqd33/jIjFAeZhKCtQGiR6l3
 aHFu/P+si7GLlrPMlB0GoCMRaBtfk6NppIhFakQddkV2rfqd+MsPZde9tS+w5sVFz+2PCBipK+q
 hI8sgzDfGHsYA4O+orRt1/dRGQ7FeQkU4faN3gfKROunI65uDtBi3enbeo6rgSVnsNyrX+Q==
X-Received: by 2002:a05:6512:32c9:b0:5bf:ec93:5a1e with SMTP id
 2adb3069b0e04-5c1bc7fea73mr2212662e87.32.1795325147760; Sat, 21 Nov 2026
 21:25:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115-4729-out-of-bounds-rx-interrupt-idx-v1-1-164891765f6c@gmail.com>
In-Reply-To: <20261115-4729-out-of-bounds-rx-interrupt-idx-v1-1-164891765f6c@gmail.com>
From: xmphyr <xmphyr@gmail.com>
Date: Sat, 21 Nov 2026 23:25:36 -0600
X-Gm-Features: Aa3M54rzwCPayvCuiiOA5y3vX5OwyfBdw7s9xIfCxiAWsipu_CQiyKs5um6HW9w
Message-ID: <CA+hLWEGHz2mxXyWx9=iGoTyd8nLsbqDQ++zPg2FnmuJbWo12cA@mail.gmail.com>
Subject: Re: [PATCH] hw/net: always validate the interrupt index of the first
 RX descriptor
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, jasowangio@gmail.com
Content-Type: multipart/alternative; boundary="000000000000b04d390660d6b5c2"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=xmphyr@gmail.com; helo=mail-lf1-x12f.google.com
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000b04d390660d6b5c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> ping
https://lore.kernel.org/qemu-devel/20261115-4729-out-of-bounds-rx-interrupt=
-idx-v1-1-164891765f6c@gmail.com/

On Sun, Nov 15, 2026 at 8:45=E2=80=AFPM Andrew Nguyen <xmphyr@gmail.com> wr=
ote:

> Made it so that vmxnet3_validate_interrupts will always validate
> s->rxq_descr[0].intr_idx.
>
> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4729
> ---
> This is a resolution for issue #4729:
> https://gitlab.com/qemu-project/qemu/-/work_items/4729.
> From the report, I got the impression that rxq_descr[0] will always
> "exist" even if the value
> of rxq_num is 0. This is because RXQ_IDX is 0. Therefore, my solution is
> to always validate
> rxq_descr[0].intr_idx.
>
> To: qemu-devel@nongnu.org
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
>
> Changes:
> - vmxnet3.c: changed the RX queue interrupt index validation for loop to =
a
> do-while loop
> ---
>  hw/net/vmxnet3.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 24c551a054..58bb7fb869 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -1367,13 +1367,15 @@ static bool
> vmxnet3_validate_interrupts(VMXNET3State *s)
>          }
>      }
>
> -    for (i =3D 0; i < s->rxq_num; i++) {
> +    i =3D 0;
> +    do {
>          int idx =3D s->rxq_descr[i].intr_idx;
>          VMW_CFPRN("Verifying RX queue %d interrupt index (%d)", i, idx);
>          if (!vmxnet3_validate_irq_idx("RX", s->msix_used, idx)) {
>              return false;
>          }
> -    }
> +        i++;
> +    } while (i < s->rxq_num);
>
>      return true;
>  }
>
> ---
> base-commit: e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5
> change-id: 20261115-4729-out-of-bounds-rx-interrupt-idx-78d69a7d847d
>
> Best regards,
> --
> Andrew Nguyen <xmphyr@gmail.com>

--000000000000b04d390660d6b5c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"></blockq=
uote><div>ping</div><div><a href=3D"https://lore.kernel.org/qemu-devel/2026=
1115-4729-out-of-bounds-rx-interrupt-idx-v1-1-164891765f6c@gmail.com/" targ=
et=3D"_blank">https://lore.kernel.org/qemu-devel/20261115-4729-out-of-bound=
s-rx-interrupt-idx-v1-1-164891765f6c@gmail.com/</a></div><br></div><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Sun, Nov 15, 2026 at 8:45=E2=80=AFPM An=
drew Nguyen &lt;<a href=3D"mailto:xmphyr@gmail.com" target=3D"_blank">xmphy=
r@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Made it so that vmxnet3_validate_interrupts will always validate=
<br>
s-&gt;rxq_descr[0].intr_idx.<br>
<br>
Signed-off-by: Andrew Nguyen &lt;<a href=3D"mailto:xmphyr@gmail.com" target=
=3D"_blank">xmphyr@gmail.com</a>&gt;<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/4729=
" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu=
/-/work_items/4729</a><br>
---<br>
This is a resolution for issue #4729: <a href=3D"https://gitlab.com/qemu-pr=
oject/qemu/-/work_items/4729" rel=3D"noreferrer" target=3D"_blank">https://=
gitlab.com/qemu-project/qemu/-/work_items/4729</a>.<br>
From the report, I got the impression that rxq_descr[0] will always &quot;e=
xist&quot; even if the value<br>
of rxq_num is 0. This is because RXQ_IDX is 0. Therefore, my solution is to=
 always validate<br>
rxq_descr[0].intr_idx.<br>
<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
Cc: Dmitry Fleytman &lt;<a href=3D"mailto:dmitry.fleytman@gmail.com" target=
=3D"_blank">dmitry.fleytman@gmail.com</a>&gt;<br>
Signed-off-by: Andrew Nguyen &lt;<a href=3D"mailto:xmphyr@gmail.com" target=
=3D"_blank">xmphyr@gmail.com</a>&gt;<br>
<br>
Changes:<br>
- vmxnet3.c: changed the RX queue interrupt index validation for loop to a =
do-while loop<br>
---<br>
=C2=A0hw/net/vmxnet3.c | 6 ++++--<br>
=C2=A01 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c<br>
index 24c551a054..58bb7fb869 100644<br>
--- a/hw/net/vmxnet3.c<br>
+++ b/hw/net/vmxnet3.c<br>
@@ -1367,13 +1367,15 @@ static bool vmxnet3_validate_interrupts(VMXNET3Stat=
e *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; s-&gt;rxq_num; i++) {<br>
+=C2=A0 =C2=A0 i =3D 0;<br>
+=C2=A0 =C2=A0 do {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int idx =3D s-&gt;rxq_descr[i].intr_idx;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMW_CFPRN(&quot;Verifying RX queue %d int=
errupt index (%d)&quot;, i, idx);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vmxnet3_validate_irq_idx(&quot;RX&qu=
ot;, s-&gt;msix_used, idx)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i++;<br>
+=C2=A0 =C2=A0 } while (i &lt; s-&gt;rxq_num);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
---<br>
base-commit: e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5<br>
change-id: 20261115-4729-out-of-bounds-rx-interrupt-idx-78d69a7d847d<br>
<br>
Best regards,<br>
-- <br>
Andrew Nguyen &lt;<a href=3D"mailto:xmphyr@gmail.com" target=3D"_blank">xmp=
hyr@gmail.com</a>&gt;</blockquote></div></div>
</div>
</div>

--000000000000b04d390660d6b5c2--

