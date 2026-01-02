Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEF9E9410B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 08:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbae3-0004RC-23; Fri, 02 Jan 2026 03:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1vbae1-0004Qn-Rc
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 03:36:25 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1vbadz-0004Zc-Ua
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 03:36:25 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-598f59996aaso14140109e87.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 00:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767342981; x=1767947781; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cS8lWiBIN83g79kBvv7llOiuw0TiSnAEmPquxUp+uEs=;
 b=bQ5Jxv7fGx/yTK90hgFgSxdgsKFy0w//fHw/dZgsknX7Vn2zXU9WvQbHORGmTvsaMb
 C9aGI8koTxOV9yUy9a6uhLTFMIMglg9++lZHHY6KUpuPzdzfGnA1VxP/nYMqppuDYhcm
 bRYrgqtapMAmrWuxx9seDD6X6QreGOthPA0UWOXjyap1nW+xUmBX0YdiBYtSQwDhi0gz
 Cz2dOqbkRXtBmf6Z6EovlRDBTtmuYw/FEA8g3WOpVcFfxAQVsg4CATlDx64TFJwz5IY7
 K09VypdxAis62Ehl7ZfjI9aEJ12rS5B0wp+fehvH1rrhxdsAMprf91U6YsNJO9AHzW+t
 AXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767342981; x=1767947781;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cS8lWiBIN83g79kBvv7llOiuw0TiSnAEmPquxUp+uEs=;
 b=eaN2i5Y9MrasoLAqXJrReE+8aez1OLla7RrEI3SQpAOe4pBH35C5DGKhQvOuHYXN6g
 1AboWRvW9EssR0UW7wf0U5QKqDEXXVMM/gJ3QZuprDYd+aakgb722swwkeDFGHLDvXsF
 66SAx8HTEC3/cH5n58ibBbY5qiSZfYJKicgcHf+V5nRQZYcstRNF1sR/6svXfBOk0pXo
 4vFDv99EusqxDATcNC6DMwT2kpundrbJWGTo8jzd7/p8ePMcjPbheIaSmYUx43wgruyD
 ljCjWUz1jviXGTiumDG4p42MIM8XZHFE6aGAh+aa6f6pxhZRkm/fpHQpYu4jfH+Oo2Ev
 Yi/w==
X-Gm-Message-State: AOJu0YwogMOJWxfjbvBZxOhc9GCT0JJ5ssoRuDdeYXdcK5pyWfiqgkU4
 PapryqJMf1il18EU+X08Bql6ma7elwLYxMJrCjxPrYGZthskIX2lmDnoo4FC7mE3wwfmvRpIbQQ
 NfnR6LfvaJHlUWk6zLjIT70oYHhyplsM8OX7j
X-Gm-Gg: AY/fxX73IStOonDRXoUQVI0gWPUCUVmEOXMDU0Oun4XbAlZVlXipJr/SKm6ajNYVals
 hX7/wE94F+0dyIhmc5LSyZJHRXzVYHeiEzdtc0VEnHjSbiMhhJjLsYkbyk2veU7PRiMPf4ppJ3e
 K68rnus4aSLLP6xief7Ay3IPABPmXN5XzkaK4wnxWLwxf+dzor5iLFGnQQHSrehyci+7VUieq+D
 75lS0/iFoF9zANiKCU/1BOb/smcLWxuhkuHALk8dyfocBv3zs0kVczx2z2Fo7IgWv1T0wk=
X-Google-Smtp-Source: AGHT+IFga/EgJieb2weCtz1bxEVQhS2XN8CFSdFZHMWRYcQbSV5lvGCpRsxUZB28yoJrp62SDOcvdV/J/jRKJuYp/Oo=
X-Received: by 2002:a05:6512:3b9d:b0:595:840c:cdd0 with SMTP id
 2adb3069b0e04-59a17cff3d9mr13055650e87.2.1767342980592; Fri, 02 Jan 2026
 00:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20251209085349.61510-1-munkhuu0825@gmail.com>
In-Reply-To: <20251209085349.61510-1-munkhuu0825@gmail.com>
From: =?UTF-8?B?0JzTqdC90YXQsdCw0LDRgtCw0YAg0K3QvdGF0LHQsNCw0YLQsNGA?=
 <munkhuu0825@gmail.com>
Date: Fri, 2 Jan 2026 16:36:09 +0800
X-Gm-Features: AQt7F2oOo1tU8KVHbeMeVuGDss7oZg4gT3xMjW1uGG2XnIOaLdU2v2b5LtsnC1A
Message-ID: <CA+0p-WxYdkTFV4qn7GYZrw+VA3MkmjRUrjr0VAcYRBrfSzRxLQ@mail.gmail.com>
Subject: Re: [PATCH V2] htif: reject invalid signature ranges (end <= begin)
 [PING]
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008df5a20647639a78"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=munkhuu0825@gmail.com; helo=mail-lf1-x136.google.com
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

--0000000000008df5a20647639a78
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Ping on this patch =E2=80=94 I just wanted to check if there are any update=
s or
feedback.

I=E2=80=99d be happy to address any comments or send a revised version if n=
eeded.

Thanks for your time.

Best regards,
Munkhuu Enkhbaatar

On Tue, Dec 9, 2025 at 4:53=E2=80=AFPM heropd <munkhuu0825@gmail.com> wrote=
:

> From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
>
> Prevents huge allocations and crashes caused by malformed HTIF signature
> addresses.
> Fixes: link to issue #3205
>
> Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
> ---
>  hw/char/riscv_htif.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index a78ea9b01c..aa205c84c0 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -170,6 +170,11 @@ static void htif_handle_tohost_write(HTIFState *s,
> uint64_t val_written)
>                   * begin/end_signature symbols exist.
>                   */
>                  if (sig_file && begin_sig_addr && end_sig_addr) {
> +                    if (end_sig_addr <=3D begin_sig_addr) {
> +                        error_report("Invalid HTIF signature range:
> begin=3D0x%llx end=3D0x%llx",
> +                                    begin_sig_addr, end_sig_addr);
> +                        return;
> +                    }
>                      uint64_t sig_len =3D end_sig_addr - begin_sig_addr;
>                      char *sig_data =3D g_malloc(sig_len);
>                      dma_memory_read(&address_space_memory, begin_sig_add=
r,
> --
> 2.50.1 (Apple Git-155)
>
>

--0000000000008df5a20647639a78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><p class=3D"gmail-isSelectedEnd" style=3D=
"color:rgb(0,0,0)">Hi all,</p><p class=3D"gmail-isSelectedEnd" style=3D"col=
or:rgb(0,0,0)">Ping on this patch =E2=80=94 I just wanted to check if there=
 are any updates or feedback.</p><p class=3D"gmail-isSelectedEnd" style=3D"=
color:rgb(0,0,0)">I=E2=80=99d be happy to address any comments or send a re=
vised version if needed.</p><p class=3D"gmail-isSelectedEnd" style=3D"color=
:rgb(0,0,0)">Thanks for your time.</p><p style=3D"color:rgb(0,0,0)">Best re=
gards,<br>Munkhuu Enkhbaatar</p></div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 9, 2025 a=
t 4:53=E2=80=AFPM heropd &lt;<a href=3D"mailto:munkhuu0825@gmail.com">munkh=
uu0825@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:s=
olid;border-left-color:rgb(204,204,204);padding-left:1ex">From: Munkhbaatar=
 Enkhbaatar &lt;<a href=3D"mailto:munkhuu0825@gmail.com" target=3D"_blank">=
munkhuu0825@gmail.com</a>&gt;<br>
<br>
Prevents huge allocations and crashes caused by malformed HTIF signature<br=
>
addresses.<br>
Fixes: link to issue #3205<br>
<br>
Signed-off-by: Munkhbaatar Enkhbaatar &lt;<a href=3D"mailto:munkhuu0825@gma=
il.com" target=3D"_blank">munkhuu0825@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/char/riscv_htif.c | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c<br>
index a78ea9b01c..aa205c84c0 100644<br>
--- a/hw/char/riscv_htif.c<br>
+++ b/hw/char/riscv_htif.c<br>
@@ -170,6 +170,11 @@ static void htif_handle_tohost_write(HTIFState *s, uin=
t64_t val_written)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * begin/end_=
signature symbols exist.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sig_file =
&amp;&amp; begin_sig_addr &amp;&amp; end_sig_addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
end_sig_addr &lt;=3D begin_sig_addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 error_report(&quot;Invalid HTIF signature range: begin=3D0x%llx =
end=3D0x%llx&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 begin_sig_addr, end_si=
g_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t sig_len =3D end_sig_addr - begin_sig_addr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0char *sig_data =3D g_malloc(sig_len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dma_memory_read(&amp;address_space_memory, begin_sig_addr,<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
</blockquote></div></div>

--0000000000008df5a20647639a78--

