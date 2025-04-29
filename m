Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9ECC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 10:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ho1-0008LF-Jz; Tue, 29 Apr 2025 06:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9hnw-0008HF-NU
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9hnu-0002tB-L7
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745920985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YXmx3GgzNSUmiYWQCyuIxN87aHi82sd1QCdZjtrB0nE=;
 b=fcswVHIYTBd05TjKvFwAF5VABnE6EhZJ9trCG47JhQs51CTkXV65z6287kG8bNE2Wy4VXg
 PABWqsfRRBJDzZyroSK414u0BtiblCyLwHG/VUxexsBdxObBHLIQAp+sviDYWslAjCLU1j
 0xNLDlQumGSNE5xSyP1u5o+CXFKL3B0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-QbmBh-eyPRW_AAte3iU5kA-1; Tue, 29 Apr 2025 06:03:04 -0400
X-MC-Unique: QbmBh-eyPRW_AAte3iU5kA-1
X-Mimecast-MFC-AGG-ID: QbmBh-eyPRW_AAte3iU5kA_1745920983
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d734da1a3so26929735e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 03:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745920982; x=1746525782;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YXmx3GgzNSUmiYWQCyuIxN87aHi82sd1QCdZjtrB0nE=;
 b=ELwsgY2EDUAIapVsmjEaOYuwoheCm8SBVh955pnJP+/QnG5k+/UiHu1OHwhH1e2qr7
 nPatOqsj8YWcyebnuK09SYMLPKPNZIBqMvgZcRNHrGXdeNEd2EUxheZCYTtiZM8o4RZd
 SYjrss95UXmzX51lfY7xkF35c8hTf/GKs7p9VC2JUcQL9H3Gfpx7jFfhJAL/Jkd+sHoF
 hacpF+zNhTiMPh52tk5fur/ypacimAlGYVXCah3JeWqbVWIAx+X2yBTdNOOt1Z7OLdqP
 +FpqWaZOT0wWLVcaWAt3rGJi9AHYDXVqFokmlVqWsdv9CZShKf7G2hjQdzkQSIg7wuO5
 6K6Q==
X-Gm-Message-State: AOJu0Ywfzyz/aCeBNco4lqnm+qIHLpJMz1UBtI4wbM8qohG17qfWXyYE
 /lYZ+nH4Vw21qgXsNU4z70vr9XheMwKdjc/YptuN0dAXH8oHmVsZRHSWSGpW9IjHNN5cUWCgOB2
 zON8X03SG0E0IaPOxgw0MmJUYYzg7wMXcbkjqOM3N24CsVccoB8AcdJBN0YXBbg5rvli0I5DjwS
 WlMLLeBjY7B5WXRUmdF799wF8+cf8IHct946Q=
X-Gm-Gg: ASbGncv6ajb0N6lCufBj4mTBbWY2RsaApuwnVWaUFDwk5esVZwvDGqPnWYQzHNPiahk
 /G5Z1v053PUEKk9gMIBfjbbhhrNytsH9Q58D3wehqSMKmdUGCTid7SECjvjoxbbzhjQ==
X-Received: by 2002:a05:600c:4e47:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-440ab7be06dmr126883175e9.14.1745920981740; 
 Tue, 29 Apr 2025 03:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcRUt18leegeYwREu2YDTQpWTmLVxGchDthh6RhVTO57e0s82EHTaTkmzN3JD0npyCvZwPMezP5TZahm9yizc=
X-Received: by 2002:a05:600c:4e47:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-440ab7be06dmr126882775e9.14.1745920981314; Tue, 29 Apr 2025
 03:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250429093319.5010-1-magnuskulke@linux.microsoft.com>
In-Reply-To: <20250429093319.5010-1-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 29 Apr 2025 12:02:48 +0200
X-Gm-Features: ATxdqUGTs0VyJPSG4JM6M6YApb1Fv0tTudWVX-0uerHpgVahuozg9d6m3UVAOU0
Message-ID: <CABgObfaxzxdBf3f-JwKA8osOwZZQf-dqpsambpAFhPvkvjDo8w@mail.gmail.com>
Subject: Re: [PATCH v3] target/i386/emulate: remove rflags leftovers
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Type: multipart/alternative; boundary="000000000000e5c0230633e7e76d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000e5c0230633e7e76d
Content-Type: text/plain; charset="UTF-8"

Il mar 29 apr 2025, 11:33 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
scritto:

> Fixes: c901905ea670 ("target/i386/emulate: remove flags_mask")
>
> In c901905ea670 rflags have been removed from `x86_decode`, but there
> were some leftovers.
>
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
>

Thanks, I will queue thos; I have some more emulator patches but no way to
test that, could you please help?

Paolo

---
>  target/i386/emulate/x86_decode.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/target/i386/emulate/x86_decode.c
> b/target/i386/emulate/x86_decode.c
> index 7fee219687..7efa2f570e 100644
> --- a/target/i386/emulate/x86_decode.c
> +++ b/target/i386/emulate/x86_decode.c
> @@ -1408,7 +1408,7 @@ struct decode_tbl _2op_inst[] = {
>  };
>
>  struct decode_x87_tbl invl_inst_x87 = {0x0, 0, 0, 0, 0, false, false,
> NULL,
> -                                       NULL, decode_invalid, 0};
> +                                       NULL, decode_invalid};
>
>  struct decode_x87_tbl _x87_inst[] = {
>      {0xd8, 0, 3, X86_DECODE_CMD_FADD, 10, false, false,
> @@ -1456,8 +1456,7 @@ struct decode_x87_tbl _x87_inst[] = {
>       decode_x87_modrm_st0, NULL, decode_d9_4},
>      {0xd9, 4, 0, X86_DECODE_CMD_INVL, 4, false, false,
>       decode_x87_modrm_bytep, NULL, NULL},
> -    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL, NULL,
> -     RFLAGS_MASK_NONE},
> +    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL,
> NULL},
>      {0xd9, 5, 0, X86_DECODE_CMD_FLDCW, 2, false, false,
>       decode_x87_modrm_bytep, NULL, NULL},
>
> @@ -1478,20 +1477,17 @@ struct decode_x87_tbl _x87_inst[] = {
>       decode_x87_modrm_st0, NULL},
>      {0xda, 3, 3, X86_DECODE_CMD_FCMOV, 10, false, false,
> decode_x87_modrm_st0,
>       decode_x87_modrm_st0, NULL},
> -    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
> -     RFLAGS_MASK_NONE},
> +    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
>      {0xda, 4, 0, X86_DECODE_CMD_FSUB, 4, false, false,
> decode_x87_modrm_st0,
>       decode_x87_modrm_intp, NULL},
>      {0xda, 5, 3, X86_DECODE_CMD_FUCOM, 10, false, true,
> decode_x87_modrm_st0,
>       decode_decode_x87_modrm_st0, NULL},
>      {0xda, 5, 0, X86_DECODE_CMD_FSUB, 4, true, false,
> decode_x87_modrm_st0,
>       decode_x87_modrm_intp, NULL},
> -    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
> -     RFLAGS_MASK_NONE},
> +    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
>      {0xda, 6, 0, X86_DECODE_CMD_FDIV, 4, false, false,
> decode_x87_modrm_st0,
>       decode_x87_modrm_intp, NULL},
> -    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
> -     RFLAGS_MASK_NONE},
> +    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
>      {0xda, 7, 0, X86_DECODE_CMD_FDIV, 4, true, false,
> decode_x87_modrm_st0,
>       decode_x87_modrm_intp, NULL},
>
> @@ -1511,8 +1507,7 @@ struct decode_x87_tbl _x87_inst[] = {
>       decode_x87_modrm_intp, NULL, NULL},
>      {0xdb, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
>       decode_db_4},
> -    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
> -     RFLAGS_MASK_NONE},
> +    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
>      {0xdb, 5, 3, X86_DECODE_CMD_FUCOMI, 10, false, false,
>       decode_x87_modrm_st0, decode_x87_modrm_st0, NULL},
>      {0xdb, 5, 0, X86_DECODE_CMD_FLD, 10, false, false,
> --
> 2.34.1
>
>

--000000000000e5c0230633e7e76d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 29 apr 2025, 11:33 Magnus=
 Kulke &lt;<a href=3D"mailto:magnuskulke@linux.microsoft.com">magnuskulke@l=
inux.microsoft.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Fixes: c901905ea670 (&quot;target/i386/emulate: remo=
ve flags_mask&quot;)<br>
<br>
In c901905ea670 rflags have been removed from `x86_decode`, but there<br>
were some leftovers.<br>
<br>
Signed-off-by: Magnus Kulke &lt;<a href=3D"mailto:magnuskulke@linux.microso=
ft.com" target=3D"_blank" rel=3D"noreferrer">magnuskulke@linux.microsoft.co=
m</a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Thanks, I will queue thos; I have some more emulator patches but =
no way to test that, could you please help?</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto=
"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
---<br>
=C2=A0target/i386/emulate/x86_decode.c | 17 ++++++-----------<br>
=C2=A01 file changed, 6 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_dec=
ode.c<br>
index 7fee219687..7efa2f570e 100644<br>
--- a/target/i386/emulate/x86_decode.c<br>
+++ b/target/i386/emulate/x86_decode.c<br>
@@ -1408,7 +1408,7 @@ struct decode_tbl _2op_inst[] =3D {<br>
=C2=A0};<br>
<br>
=C2=A0struct decode_x87_tbl invl_inst_x87 =3D {0x0, 0, 0, 0, 0, false, fals=
e, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, dec=
ode_invalid, 0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, dec=
ode_invalid};<br>
<br>
=C2=A0struct decode_x87_tbl _x87_inst[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{0xd8, 0, 3, X86_DECODE_CMD_FADD, 10, false, false,<br>
@@ -1456,8 +1456,7 @@ struct decode_x87_tbl _x87_inst[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 decode_x87_modrm_st0, NULL, decode_d9_4},<br>
=C2=A0 =C2=A0 =C2=A0{0xd9, 4, 0, X86_DECODE_CMD_INVL, 4, false, false,<br>
=C2=A0 =C2=A0 =C2=A0 decode_x87_modrm_bytep, NULL, NULL},<br>
-=C2=A0 =C2=A0 {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, N=
ULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0RFLAGS_MASK_NONE},<br>
+=C2=A0 =C2=A0 {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, N=
ULL, NULL},<br>
=C2=A0 =C2=A0 =C2=A0{0xd9, 5, 0, X86_DECODE_CMD_FLDCW, 2, false, false,<br>
=C2=A0 =C2=A0 =C2=A0 decode_x87_modrm_bytep, NULL, NULL},<br>
<br>
@@ -1478,20 +1477,17 @@ struct decode_x87_tbl _x87_inst[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 decode_x87_modrm_st0, NULL},<br>
=C2=A0 =C2=A0 =C2=A0{0xda, 3, 3, X86_DECODE_CMD_FCMOV, 10, false, false, de=
code_x87_modrm_st0,<br>
=C2=A0 =C2=A0 =C2=A0 decode_x87_modrm_st0, NULL},<br>
-=C2=A0 =C2=A0 {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NU=
LL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0RFLAGS_MASK_NONE},<br>
+=C2=A0 =C2=A0 {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NU=
LL, NULL},<br>
=C2=A0 =C2=A0 =C2=A0{0xda, 4, 0, X86_DECODE_CMD_FSUB, 4, false, false, deco=
de_x87_modrm_st0,<br>
=C2=A0 =C2=A0 =C2=A0 decode_x87_modrm_intp, NULL},<br>
=C2=A0 =C2=A0 =C2=A0{0xda, 5, 3, X86_DECODE_CMD_FUCOM, 10, false, true, dec=
ode_x87_modrm_st0,<br>
=C2=A0 =C2=A0 =C2=A0 decode_decode_x87_modrm_st0, NULL},<br>
=C2=A0 =C2=A0 =C2=A0{0xda, 5, 0, X86_DECODE_CMD_FSUB, 4, true, false, decod=
e_x87_modrm_st0,<br>
=C2=A0 =C2=A0 =C2=A0 decode_x87_modrm_intp, NULL},<br>
-=C2=A0 =C2=A0 {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NU=
LL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0RFLAGS_MASK_NONE},<br>
+=C2=A0 =C2=A0 {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NU=
LL, NULL},<br>
=C2=A0 =C2=A0 =C2=A0{0xda, 6, 0, X86_DECODE_CMD_FDIV, 4, false, false, deco=
de_x87_modrm_st0,<br>
=C2=A0 =C2=A0 =C2=A0 decode_x87_modrm_intp, NULL},<br>
-=C2=A0 =C2=A0 {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NU=
LL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0RFLAGS_MASK_NONE},<br>
+=C2=A0 =C2=A0 {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NU=
LL, NULL},<br>
=C2=A0 =C2=A0 =C2=A0{0xda, 7, 0, X86_DECODE_CMD_FDIV, 4, true, false, decod=
e_x87_modrm_st0,<br>
=C2=A0 =C2=A0 =C2=A0 decode_x87_modrm_intp, NULL},<br>
<br>
@@ -1511,8 +1507,7 @@ struct decode_x87_tbl _x87_inst[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 decode_x87_modrm_intp, NULL, NULL},<br>
=C2=A0 =C2=A0 =C2=A0{0xdb, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NUL=
L, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 decode_db_4},<br>
-=C2=A0 =C2=A0 {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NU=
LL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0RFLAGS_MASK_NONE},<br>
+=C2=A0 =C2=A0 {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NU=
LL, NULL},<br>
=C2=A0 =C2=A0 =C2=A0{0xdb, 5, 3, X86_DECODE_CMD_FUCOMI, 10, false, false,<b=
r>
=C2=A0 =C2=A0 =C2=A0 decode_x87_modrm_st0, decode_x87_modrm_st0, NULL},<br>
=C2=A0 =C2=A0 =C2=A0{0xdb, 5, 0, X86_DECODE_CMD_FLD, 10, false, false,<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div></div>

--000000000000e5c0230633e7e76d--


