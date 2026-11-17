Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A51A606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=bA7zqiRj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFmN-00089W-R4; Tue, 17 Nov 2026 04:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFmG-00088K-Rx
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:47:01 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFmF-0000bn-0f
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:47:00 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b547d6c07bso5902801a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1794908817; x=1795513617; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n5XubskUMNo7AUg8d0Mo/LKqvRp5YGsYaCRYiE27W6o=;
 b=bA7zqiRj/0/UoOfopSiIlFXeo/DPCzIvVKaQzsuQ4i9QjG3s8nSdaVbBliy4ilSQV4
 fFhcsp4nQQUPnjxnpnKCzrljL+ZThB7khJcdu0rmltVtKRWJkOymWpe2DHZrDmqRl264
 s2VoDr47UR4OCKJzXpsGix4rkYaAwxkp+pOTEV36fQYs5CuOqMNGbSLEbUHcNqG6LE5y
 7ddRMHbFx/eknju07wxBXM7OxXXXh5TP56EkR9FKDvbzCTDXLCRCPf7PlHJU5g7xQZ9Z
 j4gcQizwcJdSUUTjCJUIXNMYwHYXTrhKD9by4OCzUYs/6aGEfKlYsx+6+LQSg7XckVpz
 5AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794908817; x=1795513617;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n5XubskUMNo7AUg8d0Mo/LKqvRp5YGsYaCRYiE27W6o=;
 b=lzKGXuwz8+GzXrf68+GQb42XV2cKDR8ljIqN5ZCcK9fePpe+DpZX4EaXKu3uMCeMI2
 FDcu/+3B8ZTekWGo/dHuBWw3O5zK6LHEldniRBVA4r4znBOZ8mtL/H5dDi0rKrB2swTl
 Pc8oM2eP0+b5mXPhDd1AVtF8RQdK5wAgBV7dude4Pb+xjclFX14LfUAdjXmyG78xo100
 jZn1NiwPY7uOPH56Fq1KYyr1fwQcCkpp5j9R1GShffdSRfKqcYfQdNZecM/dZmQW9ceO
 iloqVHmjWMtEaSNe7yN9bx3u2VqR5tfvrDapPBOMlrJx/7DsU1kQCuPJzaF9p0f9O2Ih
 T3Hw==
X-Gm-Message-State: APuU4Z/3AuYpqAf1b0jZuYiWgjmK6X6Lto1yVxLNmbdkU+XZtkDrdJBO
 9QTWmnBxNAObkDdg1Xd11Dz24OuLemAn+VW3KSLexzvDxS0bq3Ia2ayCGpw/wKQzK+1NtikpG19
 fS83T/XH9RpIauyxKl0uaiJjpk/cHxG42eoIZ1pXzAPDJf4PFJ6uphUAHCjvbo10D/vZl3267lD
 Ua2Yxjmj6kWuehlf+qyx3HEjwRaoONfEoTLKp1Z3cVxxk=
X-Gm-Gg: AYBFou34w4TL5R28wvsdC2NaDu/VDVRBdTauU9j5iv7kDAdaHfUR63hr5wBQf1baLw+
 4T/qsM/6DdytR/IeszTxOZWzgonZnaNjT/VOtI1aCdodXYvlO2CwpYR3fXRpYQF2XcXkZJMnBLp
 LJ2GXksmXvfUtKXwRs4j8/dlYRtRRFX3ypOLmbSaHYfCJnyTx+PM40KFBAJpTozMly6PlL7jgP8
 4RXzndezCBwBGYhBVZghjo3FJFDZF78hbLSYFc07/ZL6MJBaTE0yKBHfiqobyjYRvCuxxnSVYJg
 IghObKZlCjy5ItonEOKpwZNeJJq8imRgbMDdhcV72nSrUC979IzJXXSSALqzgqmfvx5rLD/XJvu
 SjKITQkd6sm+0lg4TC2webvgL2MofXk4pMni8xmaa6LKq0e4Fo/FOhxPn3kt2Y0sML4hhoKnJJ5
 Sy0lG4KjipzXont0m0VagWlfzfCWH/CroVYDZjYhxg5tT8zX6OSyEJSeIqSToHNL25Mx1XbtLZc
 vXws441b4rw+f5vskmn6Xkmrb0di3I8evocnwYPf01w3Kg7RzoKPLjzGMMsxuvTlhJSU8RRATX2
 2zklU/FK0/G6uEueQntmPNS4vG/UtbbLWMIEJ/zRtb0Syjx28uih1Cyg+8RhAEA6kbQ=
X-Received: by 2002:a05:6402:194a:b0:6b6:f5b0:889a with SMTP id
 4fb4d7f45d1cf-6b7c0ccf784mr12326391a12.35.1794908817158; 
 Tue, 17 Nov 2026 01:46:57 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com.
 [209.85.208.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b8786f205fsm176403a12.22.2026.11.17.01.46.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 01:46:56 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso9886957a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:46:54 -0800 (PST)
X-Received: by 2002:a05:6402:a513:10b0:6b7:186:e60b with SMTP id
 4fb4d7f45d1cf-6b7c0891425mr7829110a12.5.1794908813794; Tue, 17 Nov 2026
 01:46:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
 <20260825-upstream-ntrace_core-v1-11-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-11-f8be2f40d2fd@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 17 Nov 2026 17:46:42 +0800
X-Gmail-Original-Message-ID: <CAMXXpfbkuD1f2xpqARBsMn1aozLWWzPjm0AgjGkhMDutGmrM2A@mail.gmail.com>
X-Gm-Features: AclHuK9IwHkVr6pd3OVhjDk3qCS0MOS6uxv_zmoQerlcRW-wc-ZQLY7_2TtFA_I
Message-ID: <CAMXXpfbkuD1f2xpqARBsMn1aozLWWzPjm0AgjGkhMDutGmrM2A@mail.gmail.com>
Subject: Re: [PATCH 11/13] hw/riscv/trace-encoder.c: add remaining fields to
 trace-encoder
To: Konstantin Semichastnov <antikostya2@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexei Filippov <halip0503@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000402072066075c6a0"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000402072066075c6a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Jay Chang<jay.chang@sifive.com>
Thanks

On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semichastnov <
antikostya2@gmail.com> wrote:

> Add remaining unsupported register bits to trace-encoder as read-only zer=
o
>
> Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
> ---
>  hw/riscv/trace-encoder.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
> index c36d205f50..58ed4b2646 100644
> --- a/hw/riscv/trace-encoder.c
> +++ b/hw/riscv/trace-encoder.c
> @@ -68,6 +68,8 @@ REG32(TR_TE_CONTROL, 0x0)
>      FIELD(TR_TE_CONTROL, EMPTY, 3, 1)
>      FIELD(TR_TE_CONTROL, INST_MODE, 4, 3)
>      FIELD(TR_TE_CONTROL, CONTEXT, 9, 1)
> +    FIELD(TR_TE_CONTROL, INST_TRIG_ENABLE, 11, 1)
> +    FIELD(TR_TE_CONTROL, INST_STALL_OR_OVERFLOW, 12, 1)
>      FIELD(TR_TE_CONTROL, INST_STALL_ENA, 13, 1)
>      FIELD(TR_TE_CONTROL, INHIBIT_SRC, 15, 1)
>      FIELD(TR_TE_CONTROL, INST_SYNC_MODE, 16, 2)
> @@ -161,6 +163,8 @@ static uint64_t
> trencoder_te_ctrl_set_hardwire_vals(uint64_t input)
>  {
>      input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_MODE, 0x6);
>      input =3D FIELD_DP32(input, TR_TE_CONTROL, CONTEXT, 0);
> +    input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_TRIG_ENABLE, 0);
> +    input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_OR_OVERFLOW, 0=
);
>      input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_ENA, 0);
>      input =3D FIELD_DP32(input, TR_TE_CONTROL, INHIBIT_SRC, 1);
>
>
> --
> 2.43.0
>
>
>

--000000000000402072066075c6a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Jay Chang&lt;<a href=3D"mailto:jay.chang@sifi=
ve.com" target=3D"_blank">jay.chang@sifive.com</a>&gt;<div>Thanks</div></di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semic=
hastnov &lt;<a href=3D"mailto:antikostya2@gmail.com">antikostya2@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">A=
dd remaining unsupported register bits to trace-encoder as read-only zero<b=
r>
<br>
Signed-off-by: Konstantin Semichastnov &lt;<a href=3D"mailto:antikostya2@gm=
ail.com" target=3D"_blank">antikostya2@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/riscv/trace-encoder.c | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c<br>
index c36d205f50..58ed4b2646 100644<br>
--- a/hw/riscv/trace-encoder.c<br>
+++ b/hw/riscv/trace-encoder.c<br>
@@ -68,6 +68,8 @@ REG32(TR_TE_CONTROL, 0x0)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_TE_CONTROL, EMPTY, 3, 1)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_TE_CONTROL, INST_MODE, 4, 3)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_TE_CONTROL, CONTEXT, 9, 1)<br>
+=C2=A0 =C2=A0 FIELD(TR_TE_CONTROL, INST_TRIG_ENABLE, 11, 1)<br>
+=C2=A0 =C2=A0 FIELD(TR_TE_CONTROL, INST_STALL_OR_OVERFLOW, 12, 1)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_TE_CONTROL, INST_STALL_ENA, 13, 1)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_TE_CONTROL, INHIBIT_SRC, 15, 1)<br>
=C2=A0 =C2=A0 =C2=A0FIELD(TR_TE_CONTROL, INST_SYNC_MODE, 16, 2)<br>
@@ -161,6 +163,8 @@ static uint64_t trencoder_te_ctrl_set_hardwire_vals(uin=
t64_t input)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_MODE, 0=
x6);<br>
=C2=A0 =C2=A0 =C2=A0input =3D FIELD_DP32(input, TR_TE_CONTROL, CONTEXT, 0);=
<br>
+=C2=A0 =C2=A0 input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_TRIG_ENABLE,=
 0);<br>
+=C2=A0 =C2=A0 input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_OR_OVE=
RFLOW, 0);<br>
=C2=A0 =C2=A0 =C2=A0input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_E=
NA, 0);<br>
=C2=A0 =C2=A0 =C2=A0input =3D FIELD_DP32(input, TR_TE_CONTROL, INHIBIT_SRC,=
 1);<br>
<br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div>

--000000000000402072066075c6a0--

