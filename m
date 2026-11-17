Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D477606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=h8Tk5JfI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFfR-0005H3-Mo; Tue, 17 Nov 2026 04:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFfQ-0005Gj-26
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:39:56 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFfN-0000ue-VK
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:39:55 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b75712fb57so5669602a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1794908392; x=1795513192; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7WvqTuXbUhpWlFGZWnVfHUTHePiaHeFofmnkw7ZzuPc=;
 b=h8Tk5JfI8zlPMp4cM+4TdO5iIR4OzWRjvTSjBtdHW3exspJmqxRGUZ/lYhSYGIRm7o
 kvH+cBtkLmkoLhHvRMGBcDwKkWk0iF9ls9IgOxa7YOfbZ2H8O1oz4TJIcBnFLtXabAbV
 OyBf5Y0yciujaCZamKJ+eVTWK5kzgIhq78CxOxTy0p727weAHDXzQ9awgcEKJKzCOhZc
 kXubgTcg+risG+yBrh9Ret7YnW/wmPi1MBC/dBpifpYPk7x+o5MMjIUT36YkWF/KqLBh
 lqH6InEhHkQJO1IoMRfl6ZPlnH3x8KWxGWXfeLCazfix2sumrXycxABXC0tWvub+zrTo
 IyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794908392; x=1795513192;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7WvqTuXbUhpWlFGZWnVfHUTHePiaHeFofmnkw7ZzuPc=;
 b=rggOChECoRw8L94CjAiDzoXIUTl17GmhM788/xXYRw2ArU2wCs7W+CV3+8nJps0d+P
 Fz5hCLqWGXHHQ1pDO8VSwWAYdUz/eOAALQkqQ2mGM5On0oZqpqwpoIpbRT/ozcfPFpqb
 xIHWZGC9fn/vPv8xp0nP9B7mb5ny4/gCFYQSsMbhdWlnFM8+WkFoQDsRu/BeVop8e/Ds
 ebA0GGGg5DnmYg6NoSWjjAtzT1vJ+sPogrQOZ+2g8l5CLx0sv6ieCdiToLYJvtLPd0vT
 HinfcNwIFjdYFMW4+n6ZubwhmMx1oQhLIuJvghHkBI2gMlf4fonT5oxSEwQYJCipFLfD
 OsqQ==
X-Gm-Message-State: APuU4Z++sCmGDAyM/fH+NttCK+6UNMKU81zYuX1XNGNNpMkNOeiNjKkO
 udVtR/nOzg0F8ueeT+MEOWqb2N2qEmz8a3EQqL/3ZMqubxukHWHAxG9e5PPObp1y6GTp9px9yNF
 UfjotzQe4WbX0oKGC8WD8ISbULD3xAXX7gL/3rw9P8Jbl31n0iVbb9zljA4F14YAJWFAoaYu7wq
 r/dkoOA/OVJR7BSnxD/R+TGMW8OZCErzwpye40+oxNHKI=
X-Gm-Gg: AYBFou3v5Uqjr4uGbNgxhWLAuzr0HyddZBIj5rpb10BtzgteQJFNi2Sn8M4Fu0t6yc5
 vvlC73PdV1JheWH8r6yngVRo1Bt/utxDYvb6CoY0Af4mxB4tNADE+XgJpqoEAAx+wmeF2VqG71m
 udyTRq81Moa7QaiKQb7jqeV8cUs6ALm5BlAg00a/gWF292OuVSoRqCoVvA4DMR+bStfymMX1Frq
 P0xTOTNBKPgKKb86aq6vvkwnQ4FXed5sz0hdkl6ZnkyY0p9aaBIR1R0yagLDeFRcovbQ7CW9KhK
 EYgMXJxHOionkeBdNA9LUWa8WsfCjB8gnX/OjXxoxTuf6z/7jFmtEP3iI6sla5/i9ezqWnyb8qT
 uC53jZwa/KRh22yk/bbF7Kje28iCQrNWUUO9n/ex7YwPpMZibpJDlA0nK68eeN9vBIL3cXeDFF0
 HDpny/AxLGFV77/FPIICxqE2dzHKOPB5VGNkzV+4IXDE7wetcm44KhYccs92cms7Rq5Ft9eA79J
 Hscefzvnt3mnX2pqC4xG6+IY2SgVZ2qwHqhCsUq0fG48nqqREOLh4D1dFb8A6yIy4lzki/zg9CJ
 2cp03N7o48+HcntNajpf/8Wcbc1hZWtuMRKtOQt8GJPbHiSXHQVlx6eFf+Vrh8NrwfsCP91n9fU
 gFuDWQgwV02xP
X-Received: by 2002:a05:6402:2712:b0:6b6:ea98:2539 with SMTP id
 4fb4d7f45d1cf-6b7c0891b0cmr10394983a12.6.1794908392270; 
 Tue, 17 Nov 2026 01:39:52 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7c23c7a2asm5520338a12.16.2026.11.17.01.39.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 01:39:50 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6b596afb4c5so5055249a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:39:50 -0800 (PST)
X-Received: by 2002:a05:6402:540f:b0:6b3:c422:9257 with SMTP id
 4fb4d7f45d1cf-6b7c0c6e019mr11609216a12.25.1794908390086; Tue, 17 Nov 2026
 01:39:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
 <20260825-upstream-ntrace_core-v1-8-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-8-f8be2f40d2fd@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 17 Nov 2026 17:39:38 +0800
X-Gmail-Original-Message-ID: <CAMXXpfYKa1tRjvhFpOo9qTUovP2KRq+og-1Ai2YAensCZfpTRQ@mail.gmail.com>
X-Gm-Features: AclHuK8XNMTfpYsPaP5irTfUGDy0bzHrBniJinP-0kDfMmhgOyUfBv4cAnJfUzs
Message-ID: <CAMXXpfYKa1tRjvhFpOo9qTUovP2KRq+og-1Ai2YAensCZfpTRQ@mail.gmail.com>
Subject: Re: [PATCH 08/13] hw/riscv: add n-trace ResourceFull rv-trace-message
To: Konstantin Semichastnov <antikostya2@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexei Filippov <halip0503@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000fedf10066075ac19"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x533.google.com
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

--000000000000fedf10066075ac19
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Jay Chang<jay.chang@sifive.com>
Thanks

On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semichastnov <
antikostya2@gmail.com> wrote:

> Add generation, encoding and sending logic for N-Trace ResourceFull
> message.
>
> Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
> ---
>  hw/riscv/rv-trace-messages.c | 29 +++++++++++++++++++++++++++++
>  hw/riscv/rv-trace-messages.h |  1 +
>  hw/riscv/trace-encoder.c     |  5 +++--
>  3 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
> index 2ee38c4354..8a9a3c6955 100644
> --- a/hw/riscv/rv-trace-messages.c
> +++ b/hw/riscv/rv-trace-messages.c
> @@ -359,10 +359,12 @@ typedef enum {
>      WIDTH_FADDR  =3D 63,
>      WIDTH_UADDR  =3D 63,
>      WIDTH_HIST   =3D 32,
> +    WIDTH_RCODE  =3D 4,
>  } NTraceFieldWidth;
>
>  typedef enum {
>      TCODE_PROG_TRACE_SYNC        =3D 0x9,
> +    TCODE_RESOURCE_FULL          =3D 0x1b,
>      TCODE_INDIRECT_BRANCH_HIST   =3D 0x1c,
>  } NTraceTcodeFieldValues;
>
> @@ -371,6 +373,10 @@ typedef enum {
>      SYNC_TRACE_ENABLED =3D 5,
>  } NTraceSyncFieldValues;
>
> +typedef enum {
> +    RCODE_HIST_PRESENT =3D 1,
> +} NTraceRcodeFieldValues;
> +
>  typedef struct NTraceFieldPayload {
>      NTraceFieldType type;
>      NTraceFieldWidth width;
> @@ -425,6 +431,14 @@ typedef struct NTraceFieldPayload {
>          .width =3D WIDTH_HIST, \
>          .value =3D (val),      \
>      }
> +
> +#define PAYLOAD_RCODE(val)    \
> +    {                         \
> +        .type =3D FIELD_FIXED,  \
> +        .width =3D WIDTH_RCODE, \
> +        .value =3D (val),       \
> +    }
> +
>  #define PAYLOAD_END()      \
>      {                      \
>          .type =3D FIELD_END, \
> @@ -517,6 +531,21 @@ size_t
> rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t faddr)
>      return rv_ntrace_gen_encoded_msg(buf, msg_fields);
>  }
>
> +size_t rv_ntrace_gen_encoded_resource_full_msg(uint8_t *buf, uint32_t
> hist)
> +{
> +    const NTraceFieldPayload msg_fields[] =3D {
> +        PAYLOAD_TCODE(TCODE_RESOURCE_FULL),
> +        /* SRC field is not supported for now */
> +        PAYLOAD_RCODE(RCODE_HIST_PRESENT),
> +        /* I-CNT overflow is not supported for now */
> +        PAYLOAD_HIST(hist),
> +        /* TSTAMP field is not supported for now */
> +        PAYLOAD_END(),
> +    };
> +
> +    return rv_ntrace_gen_encoded_msg(buf, msg_fields);
> +}
> +
>  size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btyp=
e,
>                                                uint32_t icnt, uint64_t
> uaddr,
>                                                uint32_t hist)
> diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
> index d113129d65..7ed8737d14 100644
> --- a/hw/riscv/rv-trace-messages.h
> +++ b/hw/riscv/rv-trace-messages.h
> @@ -38,6 +38,7 @@ size_t rv_etrace_gen_encoded_format1(uint8_t *buf,
>                                       bool notify, bool updiscon);
>
>  size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t
> faddr);
> +size_t rv_ntrace_gen_encoded_resource_full_msg(uint8_t *buf, uint32_t
> hist);
>  size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btyp=
e,
>                                                uint32_t icnt, uint64_t
> uaddr,
>                                                uint32_t hist);
> diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
> index face6f83b7..302458bfba 100644
> --- a/hw/riscv/trace-encoder.c
> +++ b/hw/riscv/trace-encoder.c
> @@ -694,8 +694,9 @@ static void trencoder_send_branch_map(Object
> *trencoder_obj)
>      uint8_t msg_size;
>
>      if (te->ntrace) {
> -        /* send ResourceFull message */
> -        return;
> +        uint32_t hist =3D rv_ntrace_encode_and_reset_branch_map(te);
> +
> +        msg_size =3D rv_ntrace_gen_encoded_resource_full_msg(msg, hist);
>      } else {
>          msg_size =3D rv_etrace_gen_encoded_format1_noaddr(msg,
>                                                          te->branches,
>
> --
> 2.43.0
>
>
>

--000000000000fedf10066075ac19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Jay Chang&lt;<a href=3D"mailto:jay.chang@sifi=
ve.com" target=3D"_blank">jay.chang@sifive.com</a>&gt;<div>Thanks</div></di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semic=
hastnov &lt;<a href=3D"mailto:antikostya2@gmail.com">antikostya2@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">A=
dd generation, encoding and sending logic for N-Trace ResourceFull<br>
message.<br>
<br>
Signed-off-by: Konstantin Semichastnov &lt;<a href=3D"mailto:antikostya2@gm=
ail.com" target=3D"_blank">antikostya2@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/riscv/rv-trace-messages.c | 29 +++++++++++++++++++++++++++++<br>
=C2=A0hw/riscv/rv-trace-messages.h |=C2=A0 1 +<br>
=C2=A0hw/riscv/trace-encoder.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++--<br>
=C2=A03 files changed, 33 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c<br=
>
index 2ee38c4354..8a9a3c6955 100644<br>
--- a/hw/riscv/rv-trace-messages.c<br>
+++ b/hw/riscv/rv-trace-messages.c<br>
@@ -359,10 +359,12 @@ typedef enum {<br>
=C2=A0 =C2=A0 =C2=A0WIDTH_FADDR=C2=A0 =3D 63,<br>
=C2=A0 =C2=A0 =C2=A0WIDTH_UADDR=C2=A0 =3D 63,<br>
=C2=A0 =C2=A0 =C2=A0WIDTH_HIST=C2=A0 =C2=A0=3D 32,<br>
+=C2=A0 =C2=A0 WIDTH_RCODE=C2=A0 =3D 4,<br>
=C2=A0} NTraceFieldWidth;<br>
<br>
=C2=A0typedef enum {<br>
=C2=A0 =C2=A0 =C2=A0TCODE_PROG_TRACE_SYNC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x=
9,<br>
+=C2=A0 =C2=A0 TCODE_RESOURCE_FULL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x=
1b,<br>
=C2=A0 =C2=A0 =C2=A0TCODE_INDIRECT_BRANCH_HIST=C2=A0 =C2=A0=3D 0x1c,<br>
=C2=A0} NTraceTcodeFieldValues;<br>
<br>
@@ -371,6 +373,10 @@ typedef enum {<br>
=C2=A0 =C2=A0 =C2=A0SYNC_TRACE_ENABLED =3D 5,<br>
=C2=A0} NTraceSyncFieldValues;<br>
<br>
+typedef enum {<br>
+=C2=A0 =C2=A0 RCODE_HIST_PRESENT =3D 1,<br>
+} NTraceRcodeFieldValues;<br>
+<br>
=C2=A0typedef struct NTraceFieldPayload {<br>
=C2=A0 =C2=A0 =C2=A0NTraceFieldType type;<br>
=C2=A0 =C2=A0 =C2=A0NTraceFieldWidth width;<br>
@@ -425,6 +431,14 @@ typedef struct NTraceFieldPayload {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.width =3D WIDTH_HIST, \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.value =3D (val),=C2=A0 =C2=A0 =C2=A0 \<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+#define PAYLOAD_RCODE(val)=C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D FIELD_FIXED,=C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .width =3D WIDTH_RCODE, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .value =3D (val),=C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0#define PAYLOAD_END()=C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0{=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D FIELD_END, \<br>
@@ -517,6 +531,21 @@ size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8=
_t *buf, uint64_t faddr)<br>
=C2=A0 =C2=A0 =C2=A0return rv_ntrace_gen_encoded_msg(buf, msg_fields);<br>
=C2=A0}<br>
<br>
+size_t rv_ntrace_gen_encoded_resource_full_msg(uint8_t *buf, uint32_t hist=
)<br>
+{<br>
+=C2=A0 =C2=A0 const NTraceFieldPayload msg_fields[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PAYLOAD_TCODE(TCODE_RESOURCE_FULL),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* SRC field is not supported for now */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PAYLOAD_RCODE(RCODE_HIST_PRESENT),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* I-CNT overflow is not supported for now */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PAYLOAD_HIST(hist),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TSTAMP field is not supported for now */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PAYLOAD_END(),<br>
+=C2=A0 =C2=A0 };<br>
+<br>
+=C2=A0 =C2=A0 return rv_ntrace_gen_encoded_msg(buf, msg_fields);<br>
+}<br>
+<br>
=C2=A0size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t b=
type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uint32_t icnt, uint64_t uaddr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uint32_t hist)<br>
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h<br=
>
index d113129d65..7ed8737d14 100644<br>
--- a/hw/riscv/rv-trace-messages.h<br>
+++ b/hw/riscv/rv-trace-messages.h<br>
@@ -38,6 +38,7 @@ size_t rv_etrace_gen_encoded_format1(uint8_t *buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool notify, bo=
ol updiscon);<br>
<br>
=C2=A0size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64=
_t faddr);<br>
+size_t rv_ntrace_gen_encoded_resource_full_msg(uint8_t *buf, uint32_t hist=
);<br>
=C2=A0size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t b=
type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uint32_t icnt, uint64_t uaddr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uint32_t hist);<br>
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c<br>
index face6f83b7..302458bfba 100644<br>
--- a/hw/riscv/trace-encoder.c<br>
+++ b/hw/riscv/trace-encoder.c<br>
@@ -694,8 +694,9 @@ static void trencoder_send_branch_map(Object *trencoder=
_obj)<br>
=C2=A0 =C2=A0 =C2=A0uint8_t msg_size;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (te-&gt;ntrace) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* send ResourceFull message */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t hist =3D rv_ntrace_encode_and_reset_b=
ranch_map(te);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_size =3D rv_ntrace_gen_encoded_resource_fu=
ll_msg(msg, hist);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg_size =3D rv_etrace_gen_encoded_format=
1_noaddr(msg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0te-&gt;branches,<br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div>

--000000000000fedf10066075ac19--

