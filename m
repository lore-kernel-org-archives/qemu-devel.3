Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E1C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 15:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM7Uh-0003Ha-Mh; Mon, 02 Jun 2025 11:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uM7Ue-0003HH-U0
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 11:54:33 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uM7Ub-0005G9-V7
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 11:54:32 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4f71831abso3234179f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1748879668; x=1749484468; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RAhxNngyBY1URVSmtHycea97D5Uwa3dovmCZl1i8s8c=;
 b=SH9Q9qNhGHdmJaC18jJOGuOjRa9e84qVfjYnAIN3CnZyve2AGQTnoltKeYd0mqE73V
 M2CxEE7Y6LemJTjuS5UvGoZTfgFjvH9Hcm2F8xpinmHW3/rr+HMPZRhjazxCv2tWBzmo
 xu6YAvSbE9+43lPGgqvy9K5IQY+ZgsdJ2DI2YS5nN8ccAK1W5s1dofUaZtdq5jgJ2vhW
 6+Ugb3+g2M4G5KOS6XqayDobpxaWoevMR5Q9pQjNj7im8wCLpGr5Vv8GPrOYRXTOkwkZ
 YjxIc6qn+mGTFz0FipjJpZlOARB5BTjkh1MNuoeukwSQCyZcNbV/WYkf4m7m3+xiEnFi
 0TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748879668; x=1749484468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RAhxNngyBY1URVSmtHycea97D5Uwa3dovmCZl1i8s8c=;
 b=btmd7XTpZCGiL++q0BR/B+YrvP6e9UoquMN+BlzWZUG34bR1B93Gh+vo3HoBJuHKKK
 m7PHNpFYPCeQIVWXyFkqU6xsyXGDoUv/uG6CzY89VRZBxlWfi9w94anM3snE0WSEPnAI
 K8eCHeN89kJTakyH1RQ8XE4nXLivQBUU9gi8CDYo8ZYIYzYhS8qis0traAUHdoFhX0sP
 aAvKPV/K03EOMbimrDfxZmQsU2/Ub3e+m77LTMlPxK0O0IbRPl0qLyS4+qNfqkDi3MVS
 vNzNsfA5rE61OIibzKt5E1Jz0VEtkWTINLw+9aSJ6PUVPPgt3dMbjc2UtO3gTe642/qn
 KE4w==
X-Gm-Message-State: AOJu0YwE+ygzM5wG4CQ1XkwkLNe/0knuWl/Vq3pzl2j1uNb6SMrPf9CM
 RD0gkzRPn+gQLTLVqDH5QMnoSyIrbQtxK2b9AbG1XaWke6/2gOKNqVUR4zRRKzpyN7GM9ELGCxa
 j7l67dHbMfUNZQh0Ruel7oFJ5bkqiTnQ=
X-Gm-Gg: ASbGncstFYcw9aGlcPn7dhMKixHUcZU6cbyzJEzqJbeu1kGenP9g7sy94O9lx+HWm2s
 mLsnRR2g8B4ZuR2Q/ftaX2BR7r7L4GhXDXuABwpOkrXGW2JgvMBKZcxb+6bR/URo4fjFLPSPq81
 nKQdF4fAO6v6k6mNfMBLJc3nnHdKpwogdl
X-Google-Smtp-Source: AGHT+IFE37ChImGPZmvpENH0QyLlI7Ji2RXB1s26IaZTuySiPlPvO2TJwhZOs+ecrcO81tQdjKhRfFMD1seXJoT7KyM=
X-Received: by 2002:a05:6000:2306:b0:3a4:de02:208 with SMTP id
 ffacd0b85a97d-3a4f89ac91cmr9858062f8f.25.1748879667814; Mon, 02 Jun 2025
 08:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJHT5-JwrQ31MEKKSNL-E0RPm+cg7UOiqzV5cPL-mnTOPa7eUA@mail.gmail.com>
 <87h60y41u1.fsf@draig.linaro.org>
In-Reply-To: <87h60y41u1.fsf@draig.linaro.org>
From: Jon Wilson <jonwilson030981@googlemail.com>
Date: Mon, 2 Jun 2025 16:54:16 +0100
X-Gm-Features: AX0GCFsa4T9xaKvcTh24ObWZCkEtX752klfVAqSHn9sezqDVxUXebPeiJYz-pPs
Message-ID: <CAJHT5-+tAuCoDV2G=-bZfP-j0gvY8Um-8TO8un2uNSGZpA1pcg@mail.gmail.com>
Subject: Re: TCG Address Sanitizer Optimization.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005ae657063698c7e2"
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=jonwilson030981@googlemail.com; helo=mail-wr1-x430.google.com
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

--0000000000005ae657063698c7e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It would be good if we could have QEMU provide clean APIs to allow the sort
of additional instrumentation that fuzzing requires. I guess the
qemu-libafl-bridge project show the sort of modification which has been
required so far...
https://github.com/AFLplusplus/qemu-libafl-bridge/tree/main/libafl

I would like to conditionally call a helper, or even just insert a
breakpoint instruction, but like I say I don't seem to be able to make use
of any sort of branches. Even if I add a benign instrumentation that simply
conditionally branches at a label and nothing else (e.g. no actual
functionality), I still have the same problem.
e.g.

///////////////////////////////////////////////////////////////////////////=
/////


TCGLabel *done =3D gen_new_label();
TCGv addr_val =3D temp_tcgv_tl(addr);
TCGv zero =3D tcg_constant_tl(0);
tcg_gen_brcond_tl(TCG_COND_EQ, addr_val, zero, done);
gen_set_label(done);

///////////////////////////////////////////////////////////////////////////=
/////


Hence the current implementation is a little clumsy!

Thanks for your advice.

Jon



On Mon, Jun 2, 2025 at 4:09=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> Jon Wilson <jonwilson030981@googlemail.com> writes:
>
> (Adding Richard, the TCG maintainer to CC)
>
> > I am attempting to optimize some TCG code which I have previously
> written for
> > qemu-libafl-bridge (https://github.com/AFLplusplus/qemu-libafl-bridge),
> the
> > component used by the LibAFL project when fuzzing binaries using QEMU t=
o
> > provide runtime instrumentation. The code is used to write additional
> TCG into
> > basic blocks whenever a load or store operation is performed in order t=
o
> provide
> > address sanitizer functionality.
>
> I would like to figure out if we can push any of this instrumentation
> into TCG plugins so you can avoid patching QEMU itself. I guess you need
> something that allows you to hook a memory address into some sort of
> gadget?
>
> > Address sanitizer is quite simple and works by mapping each 8-byte
> region of
> > address space to single byte within a region called the shadow map. The
> address
> > (on a 64-bit platform) of the shadow map for a given address is:
> >
> >     Shadow =3D (Mem >> 3) + 0x7fff8000;
> >
> > The value in the shadow map encodes the accessibility of an address:
> >
> >     0  - The whole 8 byte region is accessible.
> >     1 .. 7 - The first n bytes are accessible.
> >     negative - The whole 8 byte region is inaccessible.
> >
> > The following pseudo code shows the algorithm:
> >
> >
> /////////////////////////////////////////////////////////////////////////=
///////
> >
> > https://github.com/google/sanitizers/wiki/addresssanitizeralgorithm
> >
> > byte *shadow_address =3D MemToShadow(address);
> > byte shadow_value =3D *shadow_address;
> > if (shadow_value) {
> >   if (SlowPathCheck(shadow_value, address, kAccessSize)) {
> >     ReportError(address, kAccessSize, kIsWrite);
> >   }
> > }
> >
> > // Check the cases where we access first k bytes of the qword
> > // and these k bytes are unpoisoned.
> > bool SlowPathCheck(shadow_value, address, kAccessSize) {
> >   last_accessed_byte =3D (address & 7) + kAccessSize - 1;
> >   return (last_accessed_byte >=3D shadow_value);
> > }
> >
> >
> /////////////////////////////////////////////////////////////////////////=
///////
> >
> > My current implementation makes use of conditional move instructions to
> trigger
> > a segfault by way of null dereference in the event that the shadow map
> indicates
> > that a memory access is invalid.
> >
> >
> /////////////////////////////////////////////////////////////////////////=
///////
> >
> > #if TARGET_LONG_BITS =3D=3D 32
> > #define SHADOW_BASE (0x20000000)
> > #elif TARGET_LONG_BITS =3D=3D 64
> > #define SHADOW_BASE (0x7fff8000)
> > #else
> > #error Unhandled TARGET_LONG_BITS value
> > #endif
> >
> > void libafl_tcg_gen_asan(TCGTemp * addr, size_t size)
> > {
> >     if (size =3D=3D 0)
> >         return;
> >
> >     TCGv addr_val =3D temp_tcgv_tl(addr);
> >     TCGv k =3D tcg_temp_new();
> >     TCGv shadow_addr =3D tcg_temp_new();
> >     TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr();
> >     TCGv shadow_val =3D tcg_temp_new();
> >     TCGv test_addr =3D tcg_temp_new();
> >     TCGv_ptr test_ptr =3D tcg_temp_new_ptr();
> >
> >     tcg_gen_andi_tl(k, addr_val, 7);
> >     tcg_gen_addi_tl(k, k, size - 1);
> >
> >     tcg_gen_shri_tl(shadow_addr, addr_val, 3);
> >     tcg_gen_addi_tl(shadow_addr, shadow_addr, SHADOW_BASE);
> >     tcg_gen_tl_ptr(shadow_ptr, shadow_addr);
> >     tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);
> >
> >     /*
> >      * Making conditional branches here appears to cause QEMU issues
> with dead
> >      * temporaries so we will instead avoid branches.
>
> This sounds like a TCG bug that may have been fixed.
>
> >      We will cause the guest
> >      * to perform a NULL dereference in the event of an ASAN fault. Not=
e
> that
> >      * we will do this by using a store rather than a load, since the
> TCG may
> >      * otherwise determine that the result of the load is unused and
> simply
> >      * discard the operation. In the event that the shadow memory doesn=
't
> >      * detect a fault, we will simply write the value read from the
> shadow
> >      * memory back to it's original location. If, however, the shadow
> memory
> >      * detects an invalid access, we will instead attempt to write the
> value
> >      * at 0x0.
> >      */
>
> Why not conditionally call a helper here? Forcing the guest to actually
> fault seems a bit hammer like.
>
> >     tcg_gen_movcond_tl(TCG_COND_EQ, test_addr,
> >         shadow_val, tcg_constant_tl(0),
> >         shadow_addr, tcg_constant_tl(0));
> >
> >     if (size < 8)
> >     {
> >         tcg_gen_movcond_tl(TCG_COND_GE, test_addr,
> >             k, shadow_val,
> >             test_addr, shadow_addr);
> >     }
> >
> >     tcg_gen_tl_ptr(test_ptr, test_addr);
> >     tcg_gen_st8_tl(shadow_val, test_ptr, 0);
> > }
> >
> >
> /////////////////////////////////////////////////////////////////////////=
///////
> >
> > However, I would like test an implementation more like the following to
> see how
> > the performance compares. Whilst this introduces branches, the fast pat=
h
> is much
> > more likely to be executed than the slow path and hence bypassing the
> additional
> > checks and unnecessary memory writes I am hopeful it will improve
> performance.
> >
> >
> /////////////////////////////////////////////////////////////////////////=
///////
> >
> > void libafl_tcg_gen_asan(TCGTemp* addr, size_t size)
> > {
> >     if (size =3D=3D 0) {
> >         return;
> >     }
> >
> >     if (size > 8) {
> >         size =3D 8;
> >     }
> >
> >     TCGLabel *done =3D gen_new_label();
> >
> >     TCGv addr_val =3D temp_tcgv_tl(addr);
> >     TCGv shadow_addr =3D tcg_temp_new();
> >     TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr();
> >     TCGv shadow_val =3D tcg_temp_new();
> >     TCGv k =3D tcg_temp_new();
> >     TCGv zero =3D tcg_constant_tl(0);
> >     TCGv_ptr null_ptr =3D tcg_temp_new_ptr();
> >
> >     tcg_gen_shri_tl(shadow_addr, addr_val, 3);
> >     tcg_gen_addi_tl(shadow_addr, shadow_addr, SHADOW_BASE);
> >     tcg_gen_tl_ptr(shadow_ptr, shadow_addr);
> >     tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);
> >
> >     tcg_gen_brcond_tl(TCG_COND_EQ, shadow_val, zero, done);
> >
> >     tcg_gen_andi_tl(k, addr_val, 7);
> >     tcg_gen_addi_tl(k, k, size - 1);
> >
> >     tcg_gen_brcond_tl(TCG_COND_LT, shadow_val, k, done);
> >
> >     tcg_gen_tl_ptr(null_ptr, zero);
> >     tcg_gen_st8_tl(zero, null_ptr, 0);
> >
> >     gen_set_label(done);
> > }
> >
> >
> /////////////////////////////////////////////////////////////////////////=
///////
> >
> > However, when I change to using this implementation, I get the followin=
g
> error.
> > I have tested it with a trivial hello world implementation for x86_64
> running in
> > qemu-user. It doesn't occur the first time the block is executed,
> therefore I
> > think the issue is caused by the surrounding TCG in the block it is
> injected
> > into?
> >
> >
> /////////////////////////////////////////////////////////////////////////=
///////
> > runner-x86_64: ../tcg/tcg.c:4852: tcg_reg_alloc_mov: Assertion
> `ts->val_type =3D=3D TEMP_VAL_REG' failed.
> > Aborted (core dumped)
> >
> /////////////////////////////////////////////////////////////////////////=
///////
> >
> > I would be very grateful for any advice of how to resolve this issue, o=
r
> any
> > alternative approaches I could use to optimize my original
> implementation. The
> > code is obviously a very hot path and so even a tiny performance
> improvement
> > could result in a large performance gain overall.
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000005ae657063698c7e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It would be good if we could have QEMU provide clean APIs =
to allow the sort of additional instrumentation that fuzzing requires. I gu=
ess the qemu-libafl-bridge project show the sort of modification which has =
been required so far...<br><div><a href=3D"https://github.com/AFLplusplus/q=
emu-libafl-bridge/tree/main/libafl">https://github.com/AFLplusplus/qemu-lib=
afl-bridge/tree/main/libafl</a></div><div><br></div><div>I would like to co=
nditionally call a helper, or even just insert a breakpoint instruction, bu=
t like I say I don&#39;t seem to be able to make use of any sort of branche=
s. Even if I add a benign instrumentation that simply conditionally branche=
s at a label and nothing else (e.g. no actual functionality), I still have =
the same problem.</div><div>e.g.</div><div><br></div><div>
///////////////////////////////////////////////////////////////////////////=
///// <br></div><div><br></div><div>TCGLabel *done =3D gen_new_label();<br>=
TCGv addr_val =3D temp_tcgv_tl(addr);<br>TCGv zero =3D tcg_constant_tl(0);<=
br>tcg_gen_brcond_tl(TCG_COND_EQ, addr_val, zero, done);<br>gen_set_label(d=
one);</div><div><br></div><div>
///////////////////////////////////////////////////////////////////////////=
/////

<br></div><div><br></div><div>Hence the current implementation is a little =
clumsy!</div><div><br></div><div>Thanks for your advice.</div><div><br></di=
v><div>Jon</div><div><br></div><div><br></div></div><br><div class=3D"gmail=
_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon,=
 Jun 2, 2025 at 4:09=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex=
.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">Jon Wilson &lt;<a href=3D"mailto:=
jonwilson030981@googlemail.com" target=3D"_blank">jonwilson030981@googlemai=
l.com</a>&gt; writes:<br>
<br>
(Adding Richard, the TCG maintainer to CC)<br>
<br>
&gt; I am attempting to optimize some TCG code which I have previously writ=
ten for<br>
&gt; qemu-libafl-bridge (<a href=3D"https://github.com/AFLplusplus/qemu-lib=
afl-bridge" rel=3D"noreferrer" target=3D"_blank">https://github.com/AFLplus=
plus/qemu-libafl-bridge</a>), the <br>
&gt; component used by the LibAFL project when fuzzing binaries using QEMU =
to <br>
&gt; provide runtime instrumentation. The code is used to write additional =
TCG into <br>
&gt; basic blocks whenever a load or store operation is performed in order =
to provide<br>
&gt; address sanitizer functionality.<br>
<br>
I would like to figure out if we can push any of this instrumentation<br>
into TCG plugins so you can avoid patching QEMU itself. I guess you need<br=
>
something that allows you to hook a memory address into some sort of<br>
gadget?<br>
<br>
&gt; Address sanitizer is quite simple and works by mapping each 8-byte reg=
ion of<br>
&gt; address space to single byte within a region called the shadow map. Th=
e address<br>
&gt; (on a 64-bit platform) of the shadow map for a given address is:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Shadow =3D (Mem &gt;&gt; 3) + 0x7fff8000;<br>
&gt;<br>
&gt; The value in the shadow map encodes the accessibility of an address:<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A00=C2=A0 - The whole 8 byte region is accessible.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A01 .. 7 - The first n bytes are accessible.<br>
&gt;=C2=A0 =C2=A0 =C2=A0negative - The whole 8 byte region is inaccessible.=
<br>
&gt;<br>
&gt; The following pseudo code shows the algorithm:<br>
&gt;<br>
&gt; //////////////////////////////////////////////////////////////////////=
//////////<br>
&gt;<br>
&gt; <a href=3D"https://github.com/google/sanitizers/wiki/addresssanitizera=
lgorithm" rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sa=
nitizers/wiki/addresssanitizeralgorithm</a><br>
&gt;<br>
&gt; byte *shadow_address =3D MemToShadow(address);<br>
&gt; byte shadow_value =3D *shadow_address;<br>
&gt; if (shadow_value) {<br>
&gt;=C2=A0 =C2=A0if (SlowPathCheck(shadow_value, address, kAccessSize)) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0ReportError(address, kAccessSize, kIsWrite);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; }<br>
&gt;<br>
&gt; // Check the cases where we access first k bytes of the qword<br>
&gt; // and these k bytes are unpoisoned.<br>
&gt; bool SlowPathCheck(shadow_value, address, kAccessSize) {<br>
&gt;=C2=A0 =C2=A0last_accessed_byte =3D (address &amp; 7) + kAccessSize - 1=
;<br>
&gt;=C2=A0 =C2=A0return (last_accessed_byte &gt;=3D shadow_value);<br>
&gt; }<br>
&gt;<br>
&gt; //////////////////////////////////////////////////////////////////////=
//////////<br>
&gt;<br>
&gt; My current implementation makes use of conditional move instructions t=
o trigger<br>
&gt; a segfault by way of null dereference in the event that the shadow map=
 indicates<br>
&gt; that a memory access is invalid.<br>
&gt;<br>
&gt; //////////////////////////////////////////////////////////////////////=
//////////<br>
&gt;<br>
&gt; #if TARGET_LONG_BITS =3D=3D 32<br>
&gt; #define SHADOW_BASE (0x20000000)<br>
&gt; #elif TARGET_LONG_BITS =3D=3D 64<br>
&gt; #define SHADOW_BASE (0x7fff8000)<br>
&gt; #else<br>
&gt; #error Unhandled TARGET_LONG_BITS value<br>
&gt; #endif<br>
&gt;<br>
&gt; void libafl_tcg_gen_asan(TCGTemp * addr, size_t size)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (size =3D=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv addr_val =3D temp_tcgv_tl(addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv k =3D tcg_temp_new();<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv shadow_addr =3D tcg_temp_new();<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr();<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv shadow_val =3D tcg_temp_new();<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv test_addr =3D tcg_temp_new();<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv_ptr test_ptr =3D tcg_temp_new_ptr();<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_andi_tl(k, addr_val, 7);<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_addi_tl(k, k, size - 1);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_shri_tl(shadow_addr, addr_val, 3);<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_addi_tl(shadow_addr, shadow_addr, SHADOW_BA=
SE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_tl_ptr(shadow_ptr, shadow_addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * Making conditional branches here appears to caus=
e QEMU issues with dead<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * temporaries so we will instead avoid branches.<b=
r>
<br>
This sounds like a TCG bug that may have been fixed.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 We will cause the guest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * to perform a NULL dereference in the event of an=
 ASAN fault. Note that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * we will do this by using a store rather than a l=
oad, since the TCG may<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * otherwise determine that the result of the load =
is unused and simply<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * discard the operation. In the event that the sha=
dow memory doesn&#39;t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * detect a fault, we will simply write the value r=
ead from the shadow<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * memory back to it&#39;s original location. If, h=
owever, the shadow memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * detects an invalid access, we will instead attem=
pt to write the value<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * at 0x0.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 */<br>
<br>
Why not conditionally call a helper here? Forcing the guest to actually<br>
fault seems a bit hammer like.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_movcond_tl(TCG_COND_EQ, test_addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shadow_val, tcg_constant_tl(0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shadow_addr, tcg_constant_tl(0));<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (size &lt; 8)<br>
&gt;=C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_movcond_tl(TCG_COND_GE, test_=
addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0k, shadow_val,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_addr, shadow_addr)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_tl_ptr(test_ptr, test_addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_st8_tl(shadow_val, test_ptr, 0);<br>
&gt; }<br>
&gt;<br>
&gt; //////////////////////////////////////////////////////////////////////=
//////////<br>
&gt;<br>
&gt; However, I would like test an implementation more like the following t=
o see how<br>
&gt; the performance compares. Whilst this introduces branches, the fast pa=
th is much<br>
&gt; more likely to be executed than the slow path and hence bypassing the =
additional<br>
&gt; checks and unnecessary memory writes I am hopeful it will improve perf=
ormance.<br>
&gt;<br>
&gt; //////////////////////////////////////////////////////////////////////=
//////////<br>
&gt;<br>
&gt; void libafl_tcg_gen_asan(TCGTemp* addr, size_t size)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (size =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (size &gt; 8) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D 8;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGLabel *done =3D gen_new_label();<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv addr_val =3D temp_tcgv_tl(addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv shadow_addr =3D tcg_temp_new();<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr();<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv shadow_val =3D tcg_temp_new();<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv k =3D tcg_temp_new();<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv zero =3D tcg_constant_tl(0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv_ptr null_ptr =3D tcg_temp_new_ptr();<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_shri_tl(shadow_addr, addr_val, 3);<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_addi_tl(shadow_addr, shadow_addr, SHADOW_BA=
SE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_tl_ptr(shadow_ptr, shadow_addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_brcond_tl(TCG_COND_EQ, shadow_val, zero, do=
ne);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_andi_tl(k, addr_val, 7);<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_addi_tl(k, k, size - 1);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_brcond_tl(TCG_COND_LT, shadow_val, k, done)=
;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_tl_ptr(null_ptr, zero);<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_st8_tl(zero, null_ptr, 0);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_set_label(done);<br>
&gt; }<br>
&gt;<br>
&gt; //////////////////////////////////////////////////////////////////////=
//////////<br>
&gt;<br>
&gt; However, when I change to using this implementation, I get the followi=
ng error.<br>
&gt; I have tested it with a trivial hello world implementation for x86_64 =
running in<br>
&gt; qemu-user. It doesn&#39;t occur the first time the block is executed, =
therefore I<br>
&gt; think the issue is caused by the surrounding TCG in the block it is in=
jected<br>
&gt; into?<br>
&gt;<br>
&gt; //////////////////////////////////////////////////////////////////////=
//////////<br>
&gt; runner-x86_64: ../tcg/tcg.c:4852: tcg_reg_alloc_mov: Assertion `ts-&gt=
;val_type =3D=3D TEMP_VAL_REG&#39; failed.<br>
&gt; Aborted (core dumped)<br>
&gt; //////////////////////////////////////////////////////////////////////=
//////////<br>
&gt;<br>
&gt; I would be very grateful for any advice of how to resolve this issue, =
or any<br>
&gt; alternative approaches I could use to optimize my original implementat=
ion. The<br>
&gt; code is obviously a very hot path and so even a tiny performance impro=
vement<br>
&gt; could result in a large performance gain overall.<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--0000000000005ae657063698c7e2--

