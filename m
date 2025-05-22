Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59B2C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7Ro-0008QR-DK; Thu, 22 May 2025 11:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uI7Rm-0008Pw-Fe
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:03:02 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uI7Rj-0005ME-VM
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:03:02 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so6870676a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747926177; x=1748530977; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nTy/XVNu5Lka/SoXgsV7D8fpc3MBCWmzO9f19ccLcgg=;
 b=ACu911jDvdp97yvt4pW0D+TQsbb7Y8uncrTkdlX5k9qbHX6J+alP4HL1Vzyw8bEESC
 7I22YD7kfOy6+uM6K9Q+7ktFHVx5kfZk/VBolmbUxHw5sece1KjOMf1tc979uV29d21i
 73zYgnBpa2bYs2VzxdyNvBfVTYbV09fMg5SdSGKnkC5JorRf5F2bWbHyCtu2pgkcrJQs
 L5m35yP/pNljJeZz6+DYIvPe1+EGlkTShnTmjWBX/GTTY1kHmORnz9fhfwN0/y72D9Xa
 xzCrAd4G4840fmdFcPDTIEt4pFRJfrPdBiIGmGSthuZS6hqDVRqcgpApkKv0KlliuUiX
 lhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747926177; x=1748530977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nTy/XVNu5Lka/SoXgsV7D8fpc3MBCWmzO9f19ccLcgg=;
 b=NGFVJ0c3RuhT+dUyhQFpI5FePq/CK4NBehZ6oWTb1efTatP8e8fd7UCSGSHo3TVZjw
 UPsd2UXBBytIrTupkxb5lI1VVa2M71PhXUS54wiidxdrJ1VeeN+XKoOlApGmtTmSiDJh
 uirQYXyVSO/aR1ctHIVaIOCq3xV6mg3MIWdXuRbEmCx0JCouUEAlfgZx1IraTmiWOekO
 tvVbas1WU+HymMqBtN36UhPCUsx0J69MKOT3cp1WW/YYzuY9z2Hf6IFVf7CBcroiSgNe
 vK61VIbA6Ygoe/0Ux/PnFDv9qHnkBSKAFQGUEBGxIWf6Hygtc2QxGr6+kbRgXGvtiKN0
 iIlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVttUmrer3wRTFUHhz2mSseOmpOV/JvNeLu+RVemdc/8xjpKv6Id/qROYzxIsZAu8S5ApKTQFoTsNxJ@nongnu.org
X-Gm-Message-State: AOJu0Yy6KQ1lBhujSYuotOqdgval25GmxzHckuHnfJK4KgyFcRi1vkZw
 vQ/3Fs0p9xJcyoK0jwv7GmVuWF9lHYEsYgjAJOeAaZwSq8mVqu94EPjPaer7rrCt3lJq1y/rpkL
 sr/P1cTFTG0Pl8rYD7ji/jUNyzLtYzQ2RMGvYYkc=
X-Gm-Gg: ASbGncvm7Va0SPqRa7yhOxLjKap7oWnn2vZfVhEMJn5B/KvvPF/NUXyG1VisFEFXnrg
 UXgW6zgpHiBl94UPRV6aPQIGMQ0YsCmaJBPKkQw5KscIuZyD7ldwXO6DeU338Ap4OfsOKx2ATNZ
 5+pbGGn0EPjMj/j+cqrE7oeA/fgWfgcvA=
X-Google-Smtp-Source: AGHT+IHlHgYQeWaKlGtKdgRXLcgZvXdyVplmDLU2SOQQKBUxSAKvj9NfummV3A6UVsR+tZpEGyJDg098oXiMIPdsVL0=
X-Received: by 2002:a17:90b:28c5:b0:2fc:a3b7:108e with SMTP id
 98e67ed59e1d1-30e7d4fea80mr39084900a91.4.1747926176814; Thu, 22 May 2025
 08:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-3-rowanbhart@gmail.com>
 <20250522115935.34716-2-neither@nut.email>
In-Reply-To: <20250522115935.34716-2-neither@nut.email>
From: Rowan Hart <rowanbhart@gmail.com>
Date: Thu, 22 May 2025 08:02:46 -0700
X-Gm-Features: AX0GCFsfs0tWqj_jxQslmhaawMe8XsEzl0xnifRGfJvU2v8nOrOweNfvjCZw_ps
Message-ID: <CAE5MsNZhr8eNvsDHqVSAWkn4=Yw8ZFU713NNBy0ax0cSxtp1yQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] Add register write API
To: Julian Ganz <neither@nut.email>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000dcdb3a0635bac6a4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=rowanbhart@gmail.com; helo=mail-pg1-x533.google.com
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

--000000000000dcdb3a0635bac6a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Julian,

> Again, what was the reason for moving `qemu_plugin_read_register`?

I moved it so it's grouped with get_registers above instead of being
separated below the memory functions. I can move it back, just seemed nicer
that way.

-Rowan

On Thu, May 22, 2025, 4:59=E2=80=AFAM Julian Ganz <neither@nut.email> wrote=
:

> Hi Rowan,
>
> > diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> > index 3a850aa216..68c8632fd7 100644
> > --- a/include/qemu/qemu-plugin.h
> > +++ b/include/qemu/qemu-plugin.h
> > @@ -893,6 +891,41 @@ typedef struct {
> >  QEMU_PLUGIN_API
> >  GArray *qemu_plugin_get_registers(void);
> >
> > +/**
> > + * qemu_plugin_read_register() - read register for current vCPU
> > + *
> > + * @handle: a @qemu_plugin_reg_handle handle
> > + * @buf: A GByteArray for the data owned by the plugin
> > + *
> > + * This function is only available in a context that register read
> access is
> > + * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
> > + *
> > + * Returns the size of the read register. The content of @buf is in
> target byte
> > + * order. On failure returns -1.
> > + */
> > +QEMU_PLUGIN_API
> > +int qemu_plugin_read_register(struct qemu_plugin_register *handle,
> > +                              GByteArray *buf);
> > +
> > +/**
> > + * qemu_plugin_write_register() - write register for current vCPU
> > + *
> > + * @handle: a @qemu_plugin_reg_handle handle
> > + * @buf: A GByteArray for the data owned by the plugin
> > + *
> > + * This function is only available in a context that register write
> access is
> > + * explicitly requested via the QEMU_PLUGIN_CB_W_REGS flag.
> > + *
> > + * The size of @buf must be at least the size of the requested registe=
r.
> > + * Attempting to write a register with @buf smaller than the register
> size
> > + * will result in a crash or other undesired behavior.
> > + *
> > + * Returns the number of bytes written. On failure returns 0.
> > + */
> > +QEMU_PLUGIN_API
> > +int qemu_plugin_write_register(struct qemu_plugin_register *handle,
> > +                              GByteArray *buf);
> > +
> >  /**
> >   * qemu_plugin_read_memory_vaddr() - read from memory using a virtual
> address
> >   *
> > @@ -915,22 +948,6 @@ QEMU_PLUGIN_API
> >  bool qemu_plugin_read_memory_vaddr(uint64_t addr,
> >                                     GByteArray *data, size_t len);
> >
> > -/**
> > - * qemu_plugin_read_register() - read register for current vCPU
> > - *
> > - * @handle: a @qemu_plugin_reg_handle handle
> > - * @buf: A GByteArray for the data owned by the plugin
> > - *
> > - * This function is only available in a context that register read
> access is
> > - * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
> > - *
> > - * Returns the size of the read register. The content of @buf is in
> target byte
> > - * order. On failure returns -1.
> > - */
> > -QEMU_PLUGIN_API
> > -int qemu_plugin_read_register(struct qemu_plugin_register *handle,
> > -                              GByteArray *buf);
> > -
>
> Why the code move?
>
> > diff --git a/plugins/api.c b/plugins/api.c
> > index 3c9d4832e9..79b2dc20b8 100644
> > --- a/plugins/api.c
> > +++ b/plugins/api.c
> > @@ -433,6 +433,25 @@ GArray *qemu_plugin_get_registers(void)
> >      return create_register_handles(regs);
> >  }
> >
> > +int qemu_plugin_read_register(struct qemu_plugin_register *reg,
> GByteArray *buf)
> > +{
> > +    g_assert(current_cpu);
> > +
> > +    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) -
> 1);
> > +}
> > +
> > +int qemu_plugin_write_register(struct qemu_plugin_register *reg,
> > +                               GByteArray *buf)
> > +{
> > +    g_assert(current_cpu);
> > +
> > +    if (buf->len =3D=3D 0) {
> > +        return 0;
> > +    }
> > +
> > +    return gdb_write_register(current_cpu, buf->data,
> GPOINTER_TO_INT(reg) - 1);
> > +}
> > +
> >  bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data,
> size_t len)
> >  {
> >      g_assert(current_cpu);
> > @@ -453,13 +472,6 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr,
> GByteArray *data, size_t len)
> >      return true;
> >  }
> >
> > -int qemu_plugin_read_register(struct qemu_plugin_register *reg,
> GByteArray *buf)
> > -{
> > -    g_assert(current_cpu);
> > -
> > -    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) -
> 1);
> > -}
> > -
>
> Again, what was the reason for moving `qemu_plugin_read_register`?
>
> Reviewed-By: Julian Ganz <neither@nut.email>
>
> Regards,
> Julian
>

--000000000000dcdb3a0635bac6a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi Julian, </p>
<p dir=3D"ltr">&gt; Again, what was the reason for moving `qemu_plugin_read=
_register`?</p>
<p dir=3D"ltr">I moved it so it&#39;s grouped with get_registers above inst=
ead of being separated below the memory functions. I can move it back, just=
 seemed nicer that way. </p>
<p dir=3D"ltr">-Rowan<br>
</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, May 22, 2025, 4:59=E2=80=AFAM Julian Ganz &lt;neith=
er@nut.email&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Rowan,<b=
r>
<br>
&gt; diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h<b=
r>
&gt; index 3a850aa216..68c8632fd7 100644<br>
&gt; --- a/include/qemu/qemu-plugin.h<br>
&gt; +++ b/include/qemu/qemu-plugin.h<br>
&gt; @@ -893,6 +891,41 @@ typedef struct {<br>
&gt;=C2=A0 QEMU_PLUGIN_API<br>
&gt;=C2=A0 GArray *qemu_plugin_get_registers(void);<br>
&gt; <br>
&gt; +/**<br>
&gt; + * qemu_plugin_read_register() - read register for current vCPU<br>
&gt; + *<br>
&gt; + * @handle: a @qemu_plugin_reg_handle handle<br>
&gt; + * @buf: A GByteArray for the data owned by the plugin<br>
&gt; + *<br>
&gt; + * This function is only available in a context that register read ac=
cess is<br>
&gt; + * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.<br>
&gt; + *<br>
&gt; + * Returns the size of the read register. The content of @buf is in t=
arget byte<br>
&gt; + * order. On failure returns -1.<br>
&gt; + */<br>
&gt; +QEMU_PLUGIN_API<br>
&gt; +int qemu_plugin_read_register(struct qemu_plugin_register *handle,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GByteArray *buf);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * qemu_plugin_write_register() - write register for current vCPU<br>
&gt; + *<br>
&gt; + * @handle: a @qemu_plugin_reg_handle handle<br>
&gt; + * @buf: A GByteArray for the data owned by the plugin<br>
&gt; + *<br>
&gt; + * This function is only available in a context that register write a=
ccess is<br>
&gt; + * explicitly requested via the QEMU_PLUGIN_CB_W_REGS flag.<br>
&gt; + *<br>
&gt; + * The size of @buf must be at least the size of the requested regist=
er.<br>
&gt; + * Attempting to write a register with @buf smaller than the register=
 size<br>
&gt; + * will result in a crash or other undesired behavior.<br>
&gt; + *<br>
&gt; + * Returns the number of bytes written. On failure returns 0.<br>
&gt; + */<br>
&gt; +QEMU_PLUGIN_API<br>
&gt; +int qemu_plugin_write_register(struct qemu_plugin_register *handle,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GByteArray *buf);<br>
&gt; +<br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* qemu_plugin_read_memory_vaddr() - read from memory using=
 a virtual address<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; @@ -915,22 +948,6 @@ QEMU_PLUGIN_API<br>
&gt;=C2=A0 bool qemu_plugin_read_memory_vaddr(uint64_t addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GByteArray *d=
ata, size_t len);<br>
&gt; <br>
&gt; -/**<br>
&gt; - * qemu_plugin_read_register() - read register for current vCPU<br>
&gt; - *<br>
&gt; - * @handle: a @qemu_plugin_reg_handle handle<br>
&gt; - * @buf: A GByteArray for the data owned by the plugin<br>
&gt; - *<br>
&gt; - * This function is only available in a context that register read ac=
cess is<br>
&gt; - * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.<br>
&gt; - *<br>
&gt; - * Returns the size of the read register. The content of @buf is in t=
arget byte<br>
&gt; - * order. On failure returns -1.<br>
&gt; - */<br>
&gt; -QEMU_PLUGIN_API<br>
&gt; -int qemu_plugin_read_register(struct qemu_plugin_register *handle,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GByteArray *buf);<br>
&gt; -<br>
<br>
Why the code move?<br>
<br>
&gt; diff --git a/plugins/api.c b/plugins/api.c<br>
&gt; index 3c9d4832e9..79b2dc20b8 100644<br>
&gt; --- a/plugins/api.c<br>
&gt; +++ b/plugins/api.c<br>
&gt; @@ -433,6 +433,25 @@ GArray *qemu_plugin_get_registers(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return create_register_handles(regs);<br>
&gt;=C2=A0 }<br>
&gt; <br>
&gt; +int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByte=
Array *buf)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_assert(current_cpu);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return gdb_read_register(current_cpu, buf, GPOINTER_TO_=
INT(reg) - 1);<br>
&gt; +}<br>
&gt; +<br>
&gt; +int qemu_plugin_write_register(struct qemu_plugin_register *reg, <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GByteArray *buf)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_assert(current_cpu);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (buf-&gt;len =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return gdb_write_register(current_cpu, buf-&gt;data, GP=
OINTER_TO_INT(reg) - 1);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *da=
ta, size_t len)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_assert(current_cpu);<br>
&gt; @@ -453,13 +472,6 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr,=
 GByteArray *data, size_t len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByte=
Array *buf)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 g_assert(current_cpu);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 return gdb_read_register(current_cpu, buf, GPOINTER_TO_=
INT(reg) - 1);<br>
&gt; -}<br>
&gt; -<br>
<br>
Again, what was the reason for moving `qemu_plugin_read_register`?<br>
<br>
Reviewed-By: Julian Ganz &lt;neither@nut.email&gt;<br>
<br>
Regards,<br>
Julian<br>
</blockquote></div>

--000000000000dcdb3a0635bac6a4--

