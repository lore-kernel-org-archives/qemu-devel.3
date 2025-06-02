Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0180EC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 12:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM3s8-0005MG-DB; Mon, 02 Jun 2025 08:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uM3s5-0005L3-IJ
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 08:02:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uM3s2-0002Aq-7E
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 08:02:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so31433745e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 05:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1748865741; x=1749470541; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZEJFqk2F8FWRANFG2dY4a81X+NTaL96SF/qjsyS1kMk=;
 b=Brgp7eOvLJQR0QOsuBeWWEfB6tefOqN1fBftS5P2iSpAIku3kkbw0a9ssuBkkLQ68j
 wBEMysxP/SA4VfyJOXL+20SJdVmptdRGuZ2cudLZf3dK0N6REgntkdFwv/GU9GxkQ3P1
 t2yuzTFYtlum6+UIMH/qLhaHmQQEaN7049T4Egn+F9FTPBNXpoFlQ8VzECyHMwPzVVMK
 RvqgN7sqiMECHTn1vdw0QmTSugYnUaWhdU96IUU97p5THJwzZsWjq1tVDoSEKkdO7yWY
 6/n/EMmsGgEIxgdCn1eW6Dou+okuUi/uJ0jHUoVSjn/Vm5xGIM6p3xTuAwQeY+NNDNdV
 6vVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748865741; x=1749470541;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZEJFqk2F8FWRANFG2dY4a81X+NTaL96SF/qjsyS1kMk=;
 b=Pg0q6aT9axcEsOPv56NmKCEK9n/NkHhXcDIsxaPu17sGKnQuB53qoVsVBN9eHTRk1K
 Ey5AWQ7NCOGF3nPQJUOoo+ODI1kwEQNGVFK0xvkG4jIhqNAtePeHpa4QqEihgNil6GAb
 1Sss3mK5+RmNJ5sCSWzPzKiwqDMW9g9LMrCVK8SC7n9zM5snJS8Sj7KJR8FZnJbgrp9N
 QmmqbYajdfLvhlHMdS0WlraZeT3Bj9HsK798TK4kTZZtKG+Mm1bPt+SKi3oKrghcNRpf
 I/GzoryqVYeRx5p/Z5DRaPftTI7tNbXKXCjjIhuUEW2bEliiXEmXXHP90WktIdMosZls
 oJTA==
X-Gm-Message-State: AOJu0YylhizW/lcTpAjMHG6I+2KEiezV4Q1kJIirXU3Moy+zQlw497qB
 wlefQoRj8frsGheFyQCXplze62y1MMfC0Ryn+u0pGLy/6QsPqCQobOS5Qa2ofs772giBIsqibUE
 BGC0angWGvnmlT0crtcUOyCL35HcLCi6QoFsQ
X-Gm-Gg: ASbGncv8trleWHwy4WJtPpudOLrK/WTPt4CFRXFpcVpplUSLBBPP1uJ0b/9uY/weGk1
 3FSRKVhSfJSUp8aAQ0R17GCYEcRqGrA+gDpchM3BLEQeHQJYyKbMNQ+fiPAt/t7Awv9UmTixH4J
 46mIe7ZbBM8s3aHIUNMbUXYW96Th41nXEw
X-Google-Smtp-Source: AGHT+IFJJhAU13LBBUJKpj6FBR91+OZuLGNVrSSNPA9LyUHJTfHb0BgdJc5C5N95f1no/HJs/4wcaFmAW4J0DZofQUA=
X-Received: by 2002:a05:600c:6286:b0:442:f98e:f37 with SMTP id
 5b1f17b1804b1-450d657fbf9mr105254445e9.21.1748865739118; Mon, 02 Jun 2025
 05:02:19 -0700 (PDT)
MIME-Version: 1.0
From: Jon Wilson <jonwilson030981@googlemail.com>
Date: Mon, 2 Jun 2025 13:02:08 +0100
X-Gm-Features: AX0GCFvUAaTPm3Vntma792-3HbZZDK9keAFe0kx-CmwtWWwlXKOFtbKRcb6JaGI
Message-ID: <CAJHT5-JwrQ31MEKKSNL-E0RPm+cg7UOiqzV5cPL-mnTOPa7eUA@mail.gmail.com>
Subject: TCG Address Sanitizer Optimization.
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000023dd180636958921"
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=jonwilson030981@googlemail.com; helo=mail-wm1-x32b.google.com
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

--00000000000023dd180636958921
Content-Type: text/plain; charset="UTF-8"

I am attempting to optimize some TCG code which I have previously written
for
qemu-libafl-bridge (https://github.com/AFLplusplus/qemu-libafl-bridge), the
component used by the LibAFL project when fuzzing binaries using QEMU to
provide runtime instrumentation. The code is used to write additional TCG
into
basic blocks whenever a load or store operation is performed in order to
provide
address sanitizer functionality.

Address sanitizer is quite simple and works by mapping each 8-byte region of
address space to single byte within a region called the shadow map. The
address
(on a 64-bit platform) of the shadow map for a given address is:

    Shadow = (Mem >> 3) + 0x7fff8000;

The value in the shadow map encodes the accessibility of an address:

    0  - The whole 8 byte region is accessible.
    1 .. 7 - The first n bytes are accessible.
    negative - The whole 8 byte region is inaccessible.

The following pseudo code shows the algorithm:

////////////////////////////////////////////////////////////////////////////////

https://github.com/google/sanitizers/wiki/addresssanitizeralgorithm

byte *shadow_address = MemToShadow(address);
byte shadow_value = *shadow_address;
if (shadow_value) {
  if (SlowPathCheck(shadow_value, address, kAccessSize)) {
    ReportError(address, kAccessSize, kIsWrite);
  }
}

// Check the cases where we access first k bytes of the qword
// and these k bytes are unpoisoned.
bool SlowPathCheck(shadow_value, address, kAccessSize) {
  last_accessed_byte = (address & 7) + kAccessSize - 1;
  return (last_accessed_byte >= shadow_value);
}

////////////////////////////////////////////////////////////////////////////////

My current implementation makes use of conditional move instructions to
trigger
a segfault by way of null dereference in the event that the shadow map
indicates
that a memory access is invalid.

////////////////////////////////////////////////////////////////////////////////

#if TARGET_LONG_BITS == 32
#define SHADOW_BASE (0x20000000)
#elif TARGET_LONG_BITS == 64
#define SHADOW_BASE (0x7fff8000)
#else
#error Unhandled TARGET_LONG_BITS value
#endif

void libafl_tcg_gen_asan(TCGTemp * addr, size_t size)
{
    if (size == 0)
        return;

    TCGv addr_val = temp_tcgv_tl(addr);
    TCGv k = tcg_temp_new();
    TCGv shadow_addr = tcg_temp_new();
    TCGv_ptr shadow_ptr = tcg_temp_new_ptr();
    TCGv shadow_val = tcg_temp_new();
    TCGv test_addr = tcg_temp_new();
    TCGv_ptr test_ptr = tcg_temp_new_ptr();

    tcg_gen_andi_tl(k, addr_val, 7);
    tcg_gen_addi_tl(k, k, size - 1);

    tcg_gen_shri_tl(shadow_addr, addr_val, 3);
    tcg_gen_addi_tl(shadow_addr, shadow_addr, SHADOW_BASE);
    tcg_gen_tl_ptr(shadow_ptr, shadow_addr);
    tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);

    /*
     * Making conditional branches here appears to cause QEMU issues with
dead
     * temporaries so we will instead avoid branches. We will cause the
guest
     * to perform a NULL dereference in the event of an ASAN fault. Note
that
     * we will do this by using a store rather than a load, since the TCG
may
     * otherwise determine that the result of the load is unused and simply
     * discard the operation. In the event that the shadow memory doesn't
     * detect a fault, we will simply write the value read from the shadow
     * memory back to it's original location. If, however, the shadow memory
     * detects an invalid access, we will instead attempt to write the value
     * at 0x0.
     */
    tcg_gen_movcond_tl(TCG_COND_EQ, test_addr,
        shadow_val, tcg_constant_tl(0),
        shadow_addr, tcg_constant_tl(0));

    if (size < 8)
    {
        tcg_gen_movcond_tl(TCG_COND_GE, test_addr,
            k, shadow_val,
            test_addr, shadow_addr);
    }

    tcg_gen_tl_ptr(test_ptr, test_addr);
    tcg_gen_st8_tl(shadow_val, test_ptr, 0);
}

////////////////////////////////////////////////////////////////////////////////

However, I would like test an implementation more like the following to see
how
the performance compares. Whilst this introduces branches, the fast path is
much
more likely to be executed than the slow path and hence bypassing the
additional
checks and unnecessary memory writes I am hopeful it will improve
performance.

////////////////////////////////////////////////////////////////////////////////

void libafl_tcg_gen_asan(TCGTemp* addr, size_t size)
{
    if (size == 0) {
        return;
    }

    if (size > 8) {
        size = 8;
    }

    TCGLabel *done = gen_new_label();

    TCGv addr_val = temp_tcgv_tl(addr);
    TCGv shadow_addr = tcg_temp_new();
    TCGv_ptr shadow_ptr = tcg_temp_new_ptr();
    TCGv shadow_val = tcg_temp_new();
    TCGv k = tcg_temp_new();
    TCGv zero = tcg_constant_tl(0);
    TCGv_ptr null_ptr = tcg_temp_new_ptr();

    tcg_gen_shri_tl(shadow_addr, addr_val, 3);
    tcg_gen_addi_tl(shadow_addr, shadow_addr, SHADOW_BASE);
    tcg_gen_tl_ptr(shadow_ptr, shadow_addr);
    tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);

    tcg_gen_brcond_tl(TCG_COND_EQ, shadow_val, zero, done);

    tcg_gen_andi_tl(k, addr_val, 7);
    tcg_gen_addi_tl(k, k, size - 1);

    tcg_gen_brcond_tl(TCG_COND_LT, shadow_val, k, done);

    tcg_gen_tl_ptr(null_ptr, zero);
    tcg_gen_st8_tl(zero, null_ptr, 0);

    gen_set_label(done);
}

////////////////////////////////////////////////////////////////////////////////

However, when I change to using this implementation, I get the following
error.
I have tested it with a trivial hello world implementation for x86_64
running in
qemu-user. It doesn't occur the first time the block is executed, therefore
I
think the issue is caused by the surrounding TCG in the block it is injected
into?

////////////////////////////////////////////////////////////////////////////////
runner-x86_64: ../tcg/tcg.c:4852: tcg_reg_alloc_mov: Assertion
`ts->val_type == TEMP_VAL_REG' failed.
Aborted (core dumped)
////////////////////////////////////////////////////////////////////////////////

I would be very grateful for any advice of how to resolve this issue, or any
alternative approaches I could use to optimize my original implementation.
The
code is obviously a very hot path and so even a tiny performance improvement
could result in a large performance gain overall.

--00000000000023dd180636958921
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am attempting to optimize some TCG code which I have pre=
viously written for<br><div>qemu-libafl-bridge (<a href=3D"https://github.c=
om/AFLplusplus/qemu-libafl-bridge">https://github.com/AFLplusplus/qemu-liba=
fl-bridge</a>), the=C2=A0</div><div>component used by the LibAFL project wh=
en fuzzing binaries using QEMU to=C2=A0</div><div>provide runtime instrumen=
tation. The code is used to write additional TCG into=C2=A0</div><div>basic=
 blocks whenever a load or store operation is performed in order to provide=
</div><div>address sanitizer functionality.</div><br>Address sanitizer is q=
uite simple and works by mapping each 8-byte region of<br>address space to =
single byte within a region called the shadow map. The address<br>(on a 64-=
bit platform) of the shadow map for a given address is:<br><br>=C2=A0 =C2=
=A0 Shadow =3D (Mem &gt;&gt; 3) + 0x7fff8000;<br><br>The value in the shado=
w map encodes the accessibility of an address:<br><br>=C2=A0 =C2=A0 0 =C2=
=A0- The whole 8 byte region is accessible.<br>=C2=A0 =C2=A0 1 .. 7 - The f=
irst n bytes are accessible.<br>=C2=A0 =C2=A0 negative - The whole 8 byte r=
egion is inaccessible.<br><br>The following pseudo code shows the algorithm=
:<br><br>//////////////////////////////////////////////////////////////////=
//////////////<br><br><a href=3D"https://github.com/google/sanitizers/wiki/=
addresssanitizeralgorithm">https://github.com/google/sanitizers/wiki/addres=
ssanitizeralgorithm</a><br><br>byte *shadow_address =3D MemToShadow(address=
);<br>byte shadow_value =3D *shadow_address;<br>if (shadow_value) {<br>=C2=
=A0 if (SlowPathCheck(shadow_value, address, kAccessSize)) {<br>=C2=A0 =C2=
=A0 ReportError(address, kAccessSize, kIsWrite);<br>=C2=A0 }<br>}<br><br>//=
 Check the cases where we access first k bytes of the qword<br>// and these=
 k bytes are unpoisoned.<br>bool SlowPathCheck(shadow_value, address, kAcce=
ssSize) {<br>=C2=A0 last_accessed_byte =3D (address &amp; 7) + kAccessSize =
- 1;<br>=C2=A0 return (last_accessed_byte &gt;=3D shadow_value);<br>}<br><b=
r>/////////////////////////////////////////////////////////////////////////=
///////<br><br>My current implementation makes use of conditional move inst=
ructions to trigger<br>a segfault by way of null dereference in the event t=
hat the shadow map indicates<br>that a memory access is invalid.<br><br>///=
///////////////////////////////////////////////////////////////////////////=
//<br><br>#if TARGET_LONG_BITS =3D=3D 32<br>#define SHADOW_BASE (0x20000000=
)<br>#elif TARGET_LONG_BITS =3D=3D 64<br>#define SHADOW_BASE (0x7fff8000)<b=
r>#else<br>#error Unhandled TARGET_LONG_BITS value<br>#endif<br><br>void li=
bafl_tcg_gen_asan(TCGTemp * addr, size_t size)<br>{<br>=C2=A0 =C2=A0 if (si=
ze =3D=3D 0)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br><br>=C2=A0 =C2=A0 TC=
Gv addr_val =3D temp_tcgv_tl(addr);<br>=C2=A0 =C2=A0 TCGv k =3D tcg_temp_ne=
w();<br>=C2=A0 =C2=A0 TCGv shadow_addr =3D tcg_temp_new();<br>=C2=A0 =C2=A0=
 TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr();<br>=C2=A0 =C2=A0 TCGv shadow_v=
al =3D tcg_temp_new();<br>=C2=A0 =C2=A0 TCGv test_addr =3D tcg_temp_new();<=
br>=C2=A0 =C2=A0 TCGv_ptr test_ptr =3D tcg_temp_new_ptr();<br><br>=C2=A0 =
=C2=A0 tcg_gen_andi_tl(k, addr_val, 7);<br>=C2=A0 =C2=A0 tcg_gen_addi_tl(k,=
 k, size - 1);<br><br>=C2=A0 =C2=A0 tcg_gen_shri_tl(shadow_addr, addr_val, =
3);<br>=C2=A0 =C2=A0 tcg_gen_addi_tl(shadow_addr, shadow_addr, SHADOW_BASE)=
;<br>=C2=A0 =C2=A0 tcg_gen_tl_ptr(shadow_ptr, shadow_addr);<br>=C2=A0 =C2=
=A0 tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);<br><br>=C2=A0 =C2=A0 /*<br>=
=C2=A0 =C2=A0 =C2=A0* Making conditional branches here appears to cause QEM=
U issues with dead<br>=C2=A0 =C2=A0 =C2=A0* temporaries so we will instead =
avoid branches. We will cause the guest<br>=C2=A0 =C2=A0 =C2=A0* to perform=
 a NULL dereference in the event of an ASAN fault. Note that<br>=C2=A0 =C2=
=A0 =C2=A0* we will do this by using a store rather than a load, since the =
TCG may<br>=C2=A0 =C2=A0 =C2=A0* otherwise determine that the result of the=
 load is unused and simply<br>=C2=A0 =C2=A0 =C2=A0* discard the operation. =
In the event that the shadow memory doesn&#39;t<br>=C2=A0 =C2=A0 =C2=A0* de=
tect a fault, we will simply write the value read from the shadow<br>=C2=A0=
 =C2=A0 =C2=A0* memory back to it&#39;s original location. If, however, the=
 shadow memory<br>=C2=A0 =C2=A0 =C2=A0* detects an invalid access, we will =
instead attempt to write the value<br>=C2=A0 =C2=A0 =C2=A0* at 0x0.<br>=C2=
=A0 =C2=A0 =C2=A0*/<br>=C2=A0 =C2=A0 tcg_gen_movcond_tl(TCG_COND_EQ, test_a=
ddr,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 shadow_val, tcg_constant_tl(0),<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 shadow_addr, tcg_constant_tl(0));<br><br>=C2=A0 =
=C2=A0 if (size &lt; 8)<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
cg_gen_movcond_tl(TCG_COND_GE, test_addr,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 k, shadow_val,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
est_addr, shadow_addr);<br>=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 tcg_gen_tl_=
ptr(test_ptr, test_addr);<br>=C2=A0 =C2=A0 tcg_gen_st8_tl(shadow_val, test_=
ptr, 0);<br>}<br><br>//////////////////////////////////////////////////////=
//////////////////////////<br><br>However, I would like test an implementat=
ion more like the following to see how<br>the performance compares. Whilst =
this introduces branches, the fast path is much<br>more likely to be execut=
ed than the slow path and hence bypassing the additional<br>checks and unne=
cessary memory writes I am hopeful it will improve performance.<br><br>////=
///////////////////////////////////////////////////////////////////////////=
/<br><br>void libafl_tcg_gen_asan(TCGTemp* addr, size_t size)<br>{<br>=C2=
=A0 =C2=A0 if (size =3D=3D 0) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>=
=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 if (size &gt; 8) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 size =3D 8;<br>=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 TCGLabel =
*done =3D gen_new_label();<br><br>=C2=A0 =C2=A0 TCGv addr_val =3D temp_tcgv=
_tl(addr);<br>=C2=A0 =C2=A0 TCGv shadow_addr =3D tcg_temp_new();<br>=C2=A0 =
=C2=A0 TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr();<br>=C2=A0 =C2=A0 TCGv sh=
adow_val =3D tcg_temp_new();<br>=C2=A0 =C2=A0 TCGv k =3D tcg_temp_new();<br=
>=C2=A0 =C2=A0 TCGv zero =3D tcg_constant_tl(0);<br>=C2=A0 =C2=A0 TCGv_ptr =
null_ptr =3D tcg_temp_new_ptr();<br><br>=C2=A0 =C2=A0 tcg_gen_shri_tl(shado=
w_addr, addr_val, 3);<br>=C2=A0 =C2=A0 tcg_gen_addi_tl(shadow_addr, shadow_=
addr, SHADOW_BASE);<br>=C2=A0 =C2=A0 tcg_gen_tl_ptr(shadow_ptr, shadow_addr=
);<br>=C2=A0 =C2=A0 tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);<br><br>=C2=
=A0 =C2=A0 tcg_gen_brcond_tl(TCG_COND_EQ, shadow_val, zero, done);<br><br>=
=C2=A0 =C2=A0 tcg_gen_andi_tl(k, addr_val, 7);<br>=C2=A0 =C2=A0 tcg_gen_add=
i_tl(k, k, size - 1);<br><br>=C2=A0 =C2=A0 tcg_gen_brcond_tl(TCG_COND_LT, s=
hadow_val, k, done);<br><br>=C2=A0 =C2=A0 tcg_gen_tl_ptr(null_ptr, zero);<b=
r>=C2=A0 =C2=A0 tcg_gen_st8_tl(zero, null_ptr, 0);<br><br>=C2=A0 =C2=A0 gen=
_set_label(done);<br>}<br><br>/////////////////////////////////////////////=
///////////////////////////////////<br><br>However, when I change to using =
this implementation, I get the following error.<br>I have tested it with a =
trivial hello world implementation for x86_64 running in<br>qemu-user. It d=
oesn&#39;t occur the first time the block is executed, therefore I<br>think=
 the issue is caused by the surrounding TCG in the block it is injected<br>=
into?<br><br>//////////////////////////////////////////////////////////////=
//////////////////<br>runner-x86_64: ../tcg/tcg.c:4852: tcg_reg_alloc_mov: =
Assertion `ts-&gt;val_type =3D=3D TEMP_VAL_REG&#39; failed.<br>Aborted (cor=
e dumped)<br>//////////////////////////////////////////////////////////////=
//////////////////<br><br>I would be very grateful for any advice of how to=
 resolve this issue, or any<br>alternative approaches I could use to optimi=
ze my original implementation. The<br>code is obviously a very hot path and=
 so even a tiny performance improvement<br>could result in a large performa=
nce gain overall.<br><br><br></div>

--00000000000023dd180636958921--

