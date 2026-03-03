Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060FCEDEBE0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxV0O-0004T0-1o; Tue, 03 Mar 2026 14:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vxV0J-0004Qv-5R
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:02:00 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vxV0E-0003lW-RH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:01:58 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so649395666b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:01:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772564510; cv=none;
 d=google.com; s=arc-20240605;
 b=VFRgyg1gZ+6DsKqUREr1Y7ltlop26cQa1L8H8kfK9ctDguCqQ+5j9zCtWPXfvILAw6
 gaYWi0GNwxZbF2sjMwDxAiauJ9gtBVzsFK8ZVNacjuOBmkEPCBwb6bq0aYFWy4pWm++d
 eo2igDgCzsPV/wi0VCqRmwR1o0jA/iJP5LvsKTatfxdfeTzCVIkuKZHjawiqpmrpCc4A
 0rCpAF281BmEgZ6Oxzzl1rNrhWx3ZWZztMFT3qZp7LH7QLSxj2Z+NRJIEiMs6sOqr+Bt
 UUd86VyXP40XPD3UDx5ON15aI2FXKFPA+tMI5ijlqL+ZZjorN6C22AbYBM+zirLxgrDS
 WY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9zRXY1BEItwlGTFUfk0GnQnwYToDsBlkVLcKmtOezvg=;
 fh=+Uvb7Yz34LHuqkZPJ52D9u/06VY8vB5uNr1P6A8AzDo=;
 b=bSV4T5fufrX1zjsc65f9cwUeDaEThYbl5ONBzO6JcOc4XL/E1LPcKqQ+lQGR0u6s16
 ZnIfBuqT2yn3tk3GVi5eezgpjKW3jQ7ZO/VnHmb9muxhOl+kv3sUpCl1fjMJIi+zT1Wb
 lYAZRY8yEvZ9kGCRGAjfj75NrWGxHRb88AxNLWxkoCLV7mfpGKoVyZb9KwW7taGp10BN
 s+KbGfWVHICqfngcakqSjURW5fjRm2NJcdU+55jQJhUkzwc710penCnMhndsjccN0HH4
 E3btFK/4d5FUXlzMQ9K42QZapKaX1Jhv4j7ZTRrwk7/U3vFpJdO9Xx+6r2gXf5muBnu3
 sC8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772564510; x=1773169310; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9zRXY1BEItwlGTFUfk0GnQnwYToDsBlkVLcKmtOezvg=;
 b=dQjf3NZ06Q0NETyheWF1PGsEOFI7Hf6J+lyTrS+ofGOhos/rwvpYC9utvGGTehatWC
 1BGxjj6lmbV1/n6Frw65POGJ0slQpRUGl6nYP3kcuWX5x8326cS4PMysEh25XvyIYvsk
 JSpyb1R6zjkFcBdiaLXwozr4z8ywA0sB/FBzAvM2izt4fUzk3QbZ3sK8NkAZi6Q+lk76
 VeXk3zWaUd8qfZlK4Iq93YWSZFnNawef91wqf7BAxaQkXU69pVsvdhHBloR+S+5cs953
 PuQQ4Q6wHI4Tf+4rZvSovfTg65cMu6+yVJCBhMJuKdNByka7+2hP4hFFmdxYtkCkFOAz
 5n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772564510; x=1773169310;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zRXY1BEItwlGTFUfk0GnQnwYToDsBlkVLcKmtOezvg=;
 b=ZQ+Bi6v1MnVmwMiIojBS9Vt7hDRB9wW5YoKAwqqxGxk5QrICRgtSarh8EApO9B3deN
 Pjb+T+bsb8ngeL5o5qTb7Ao/B1mBcN/qiq/cuW0TaYSmbXHvAFUf16sK7p8P4+rbFkOJ
 YG3W0iF2Mki01poCKRMu7dskbCQl5Ve3/0yw5nKkBdgcctPVaf0LfAfDdhewW2i6Y1Du
 HEDMTdkhU2Qlh4qRemQtArMdZBiBNr9F40RZyc7ldMGj2hmZA/Y1S1RwV/yv0TLQqRgi
 P8OajcoYvr4qXUCGO1Fc4qTMu/KqI42NKSrKx9nNXulwmAoezgEWMfc8n2UFdGXrPc6C
 aqKw==
X-Gm-Message-State: AOJu0YyiK+181+ZwCgl5Q1M89rdACadnZ+S2M7tvgdI9pfEHE2XpF7iZ
 MBp0Z36PgCvd/HASEHdyjj6j2PuGoVucOR5/s3kMK5sLG4z1RA2H4Fw95G7DKhCFo0Q4UQ2067a
 XHOlhx4T8c3sHQZayeDFiBj8fFgL6hDN+3ybVEzc=
X-Gm-Gg: ATEYQzz+k3u3eaGGPHD3syDuOtXCwf4JmRUv48YAnGPlxUUW0Pf1+R6B41Bxtjjk4/Q
 oroo+HcEsDhIjz5WC8V19bjSFGrBw+jLdnBxHApL+Gicriv1GFsdJ1A4X36EoMeyAQVk+HXbMrP
 BkjJcbjPEZYNyFAfexdXbXRESQf1abXkTY53faOFuIQWWYjYJo2T40E7mmmL1e70XJd2LvJ2qzk
 iYJPCEIZGbkb2/t8Rv7a3ngAPZBd7fWqGCGkJM9/NNJl2E/eMMIpeaAWANG2rvMHJMAfP1bf4eN
 wOuCuYF2Few9hWhLc4SqmKAljSPKRZk4qm3NfkDKSnDiWuzHZqU=
X-Received: by 2002:a17:906:9fc8:b0:b88:4c99:bc0e with SMTP id
 a640c23a62f3a-b93763d2329mr1131489266b.26.1772564509956; Tue, 03 Mar 2026
 11:01:49 -0800 (PST)
MIME-Version: 1.0
References: <20260203073740.19913-1-razvanghiorghe16@gmail.com>
 <20260203073740.19913-2-razvanghiorghe16@gmail.com>
In-Reply-To: <20260203073740.19913-2-razvanghiorghe16@gmail.com>
From: razvan ghiorghe <razvanghiorghe16@gmail.com>
Date: Tue, 3 Mar 2026 21:01:42 +0200
X-Gm-Features: AaiRm51L3YWd49fRnw5s1JQ7M1uDdWbc4S90pbYyOjkJvG1qibsKhy-3GyaFgNM
Message-ID: <CAK=UehKoaT5ZsoOwS++BY1TKZwHCWNkgL67VWajZseS-69evWw@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg/x86_64: Add tests for zero_bss() with RX
 PT_LOAD segments
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.henderson@linaro.org
Content-Type: multipart/alternative; boundary="000000000000f51f32064c23554b"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=razvanghiorghe16@gmail.com; helo=mail-ej1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000f51f32064c23554b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I'd like to kindly ping this patch. It has been a few weeks since
submission and I haven't received any feedback yet.
I'm working on getting familiar with the contribution flux. Any review,
even brief comments on the approach would be very helpful!
Thanks in advance,
Razvan

=C3=8En mar., 3 feb. 2026 la 09:39, Razvan Ghiorghe <razvanghiorghe16@gmail=
.com>
a scris:

> Add 2 test cases to validate the fix for issue #3179, where the linux-use=
r
> ELF Loader incorrectly rejected binaries with .bss sections in R_X PT_LOA=
D
> segments.
>
> test-zerobss-1.c: defines a minimal _start routine that exists immediatel=
y
> without accessing the .bss region. Although a .bss region is present in
> ELF,
> it is never referenced at runtime. This test validates that the loader ca=
n
> correctly handle and zero the fractional .bss region in an R_X segment
> without triggering permission violations.
>
> test-zerobss-2.c: explicitly reads from multiple .bss variables to verify
> they are zeroed properly. If the .bss was correctly zeroed, the exit code
> will
> be 0.
>
> rx_anonymous_bss.ld: tests require a custom linker script to create the
> specific ELF
> layout that triggers the bug. The linker script:
> - creates a single PT_LOAD segment with FLAGS(5) =3D PF_R | PF_X
> (read-execute)
> - places .text and .bss in this same segment
> - sets .bss to ALIGN(1) to force it into the tail of the R_X segment
> - results in p_filesz < p_memsz, where the gap is anonymous .bss
>
> Expected behavior:
> - Without the fix: Both tests fail with "PT_LOAD with non-writable bss"
> - With the fix: Both tests pass (exit code 0)
>
> Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
> ---
>  tests/tcg/x86_64/Makefile.target     | 15 ++++++++++++
>  tests/tcg/x86_64/rx_anonymous_bss.ld | 27 +++++++++++++++++++++
>  tests/tcg/x86_64/test-zerobss-1.c    | 20 ++++++++++++++++
>  tests/tcg/x86_64/test-zerobss-2.c    | 36 ++++++++++++++++++++++++++++
>  4 files changed, 98 insertions(+)
>  create mode 100644 tests/tcg/x86_64/rx_anonymous_bss.ld
>  create mode 100644 tests/tcg/x86_64/test-zerobss-1.c
>  create mode 100644 tests/tcg/x86_64/test-zerobss-2.c
>
> diff --git a/tests/tcg/x86_64/Makefile.target
> b/tests/tcg/x86_64/Makefile.target
> index be20fc64e8..ca375a4318 100644
> --- a/tests/tcg/x86_64/Makefile.target
> +++ b/tests/tcg/x86_64/Makefile.target
> @@ -19,6 +19,9 @@ X86_64_TESTS +=3D test-1648
>  X86_64_TESTS +=3D test-2175
>  X86_64_TESTS +=3D cross-modifying-code
>  X86_64_TESTS +=3D fma
> +
> +X86_64_TESTS +=3D  test-zerobss-1
> +X86_64_TESTS +=3D  test-zerobss-2
>  TESTS=3D$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
>  else
>  TESTS=3D$(MULTIARCH_TESTS)
> @@ -36,5 +39,17 @@ test-x86_64: LDFLAGS+=3D-lm -lc
>  test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.=
h
>         $(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
>
> +test-zerobss-1: $(SRC_PATH)/tests/tcg/x86_64/test-zerobss-1.c
> +       $(CC) -nostdlib -static -fno-stack-protector -fno-pie -no-pie \
> +            -Wl,-T,$(SRC_PATH)/tests/tcg/x86_64/rx_anonymous_bss.ld \
> +            -Wl,--build-id=3Dnone \
> +            $< -o $@
> +
> +test-zerobss-2: $(SRC_PATH)/tests/tcg/x86_64/test-zerobss-2.c
> +       $(CC) -nostdlib -static -fno-stack-protector -fno-pie -no-pie \
> +            -Wl,-T,$(SRC_PATH)/tests/tcg/x86_64/rx_anonymous_bss.ld \
> +            -Wl,--build-id=3Dnone \
> +            $< -o $@
> +
>  %: $(SRC_PATH)/tests/tcg/x86_64/%.c
>         $(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
> diff --git a/tests/tcg/x86_64/rx_anonymous_bss.ld
> b/tests/tcg/x86_64/rx_anonymous_bss.ld
> new file mode 100644
> index 0000000000..3ec72fde6c
> --- /dev/null
> +++ b/tests/tcg/x86_64/rx_anonymous_bss.ld
> @@ -0,0 +1,27 @@
> +/* Linker script to create RX PT_LOAD with anonymous .bss tail
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +PHDRS
> +{
> +    text PT_LOAD FLAGS(5);
> +}
> +SECTIONS
> +{
> +    . =3D 0x400000;
> +    .text : {
> +        *(.text .text.*)
> +        _etext =3D .;
> +    } :text
> +    .bss ALIGN(1) : {
> +        _bss_start =3D .;
> +        *(.bss .bss.* COMMON)
> +        _bss_end =3D .;
> +    } :text
> +    /DISCARD/ : {
> +        *(.note.GNU-stack)
> +        *(.note.gnu.property)
> +        *(.comment)
> +        *(.eh_frame)
> +    }
> +}
> +ENTRY(_start)
> diff --git a/tests/tcg/x86_64/test-zerobss-1.c
> b/tests/tcg/x86_64/test-zerobss-1.c
> new file mode 100644
> index 0000000000..809ea3cb52
> --- /dev/null
> +++ b/tests/tcg/x86_64/test-zerobss-1.c
> @@ -0,0 +1,20 @@
> + /*
> +  * .bss region exists but unused
> +  * SPDX-License-Identifier: GPL-2.0-or-later
> +  */
> +int x;
> +void _start(void)
> +{
> +    /*
> +     * Exit immediately & never touched x
> +     */
> +    __asm__ volatile(
> +        "mov $60, %%rax\n"
> +        "xor %%rdi, %%rdi\n"
> +        "syscall\n"
> +        : /* no out */
> +        : /* no in */
> +        : "rax", "rdi"
> +    );
> +    __builtin_unreachable();
> +}
> diff --git a/tests/tcg/x86_64/test-zerobss-2.c
> b/tests/tcg/x86_64/test-zerobss-2.c
> new file mode 100644
> index 0000000000..1f4f0d9704
> --- /dev/null
> +++ b/tests/tcg/x86_64/test-zerobss-2.c
> @@ -0,0 +1,36 @@
> +/*
> + * Test case for zero_bss() with anonymous BSS in RX PT_LOAD
> + *
> + * This binary has .bss in the same PT_LOAD as .text (R_X permissions),
> + * but the BSS is anonymous (beyond p_filesz), not file-backed.
> + * Actual behavior:
> + * old code: Fails with "PT_LOAD with non-writable bss"
> + * new code: Succeeds, zeros BSS, exits with code 0
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +/* These will be included in .bss (uninitialized anonymous memory) */
> +int bss_value;
> +int bss_array[64];
> +
> +void _start(void)
> +{
> +    int sum =3D bss_value;
> +    int i;
> +
> +    for (i =3D 0; i < 64; i++) {
> +        sum +=3D bss_array[i];
> +    }
> +    /* If BSS was properly zeroed, sum should be 0 */
> +    /* Exit with sum as exit code */
> +    __asm__ volatile (
> +        "movl %0, %%edi\n\t"
> +        "movl $60, %%eax\n\t"
> +        "syscall\n\t"
> +        : /* no out*/
> +        : "r" (sum)
> +        : "rdi", "rax"
> +    );
> +
> +    __builtin_unreachable();
> +}
> --
> 2.43.0
>
>

--000000000000f51f32064c23554b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div id=3D"gmail-:pu" class=3D"gmail-Am gmail-aiL gmail-aO=
9 gmail-Al editable gmail-LW-avf gmail-tS-tW gmail-tS-tY" aria-label=3D"Cor=
pul mesajului" role=3D"textbox" aria-multiline=3D"true" tabindex=3D"1" styl=
e=3D"direction:ltr;min-height:85px" aria-controls=3D":z9" aria-expanded=3D"=
false">Hi,<br>I&#39;d like to kindly ping this patch. It has been a few wee=
ks since submission and I haven&#39;t received any feedback yet.<div>I&#39;=
m working on getting familiar with the contribution flux. Any review, even =
brief comments on the approach would be very helpful!<br><div>Thanks in adv=
ance,=C2=A0</div><div>Razvan</div></div></div></div><br><div class=3D"gmail=
_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">=C3=8En=
 mar., 3 feb. 2026 la 09:39, Razvan Ghiorghe &lt;<a href=3D"mailto:razvangh=
iorghe16@gmail.com">razvanghiorghe16@gmail.com</a>&gt; a scris:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Add 2 test cases to validat=
e the fix for issue #3179, where the linux-user<br>
ELF Loader incorrectly rejected binaries with .bss sections in R_X PT_LOAD<=
br>
segments.<br>
<br>
test-zerobss-1.c: defines a minimal _start routine that exists immediately<=
br>
without accessing the .bss region. Although a .bss region is present in ELF=
,<br>
it is never referenced at runtime. This test validates that the loader can<=
br>
correctly handle and zero the fractional .bss region in an R_X segment<br>
without triggering permission violations.<br>
<br>
test-zerobss-2.c: explicitly reads from multiple .bss variables to verify<b=
r>
they are zeroed properly. If the .bss was correctly zeroed, the exit code w=
ill<br>
be 0.<br>
<br>
rx_anonymous_bss.ld: tests require a custom linker script to create the spe=
cific ELF<br>
layout that triggers the bug. The linker script:<br>
- creates a single PT_LOAD segment with FLAGS(5) =3D PF_R | PF_X (read-exec=
ute)<br>
- places .text and .bss in this same segment<br>
- sets .bss to ALIGN(1) to force it into the tail of the R_X segment<br>
- results in p_filesz &lt; p_memsz, where the gap is anonymous .bss<br>
<br>
Expected behavior:<br>
- Without the fix: Both tests fail with &quot;PT_LOAD with non-writable bss=
&quot;<br>
- With the fix: Both tests pass (exit code 0)<br>
<br>
Signed-off-by: Razvan Ghiorghe &lt;<a href=3D"mailto:razvanghiorghe16@gmail=
.com" target=3D"_blank">razvanghiorghe16@gmail.com</a>&gt;<br>
---<br>
=C2=A0tests/tcg/x86_64/Makefile.target=C2=A0 =C2=A0 =C2=A0| 15 ++++++++++++=
<br>
=C2=A0tests/tcg/x86_64/rx_anonymous_bss.ld | 27 +++++++++++++++++++++<br>
=C2=A0tests/tcg/x86_64/test-zerobss-1.c=C2=A0 =C2=A0 | 20 ++++++++++++++++<=
br>
=C2=A0tests/tcg/x86_64/test-zerobss-2.c=C2=A0 =C2=A0 | 36 +++++++++++++++++=
+++++++++++<br>
=C2=A04 files changed, 98 insertions(+)<br>
=C2=A0create mode 100644 tests/tcg/x86_64/rx_anonymous_bss.ld<br>
=C2=A0create mode 100644 tests/tcg/x86_64/test-zerobss-1.c<br>
=C2=A0create mode 100644 tests/tcg/x86_64/test-zerobss-2.c<br>
<br>
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.t=
arget<br>
index be20fc64e8..ca375a4318 100644<br>
--- a/tests/tcg/x86_64/Makefile.target<br>
+++ b/tests/tcg/x86_64/Makefile.target<br>
@@ -19,6 +19,9 @@ X86_64_TESTS +=3D test-1648<br>
=C2=A0X86_64_TESTS +=3D test-2175<br>
=C2=A0X86_64_TESTS +=3D cross-modifying-code<br>
=C2=A0X86_64_TESTS +=3D fma<br>
+<br>
+X86_64_TESTS +=3D=C2=A0 test-zerobss-1<br>
+X86_64_TESTS +=3D=C2=A0 test-zerobss-2<br>
=C2=A0TESTS=3D$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64<br>
=C2=A0else<br>
=C2=A0TESTS=3D$(MULTIARCH_TESTS)<br>
@@ -36,5 +39,17 @@ test-x86_64: LDFLAGS+=3D-lm -lc<br>
=C2=A0test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muld=
iv.h<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(CC) $(CFLAGS) $&lt; -o $@ $(LDFLAGS)<br>
<br>
+test-zerobss-1: $(SRC_PATH)/tests/tcg/x86_64/test-zerobss-1.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(CC) -nostdlib -static -fno-stack-protector -f=
no-pie -no-pie \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wl,-T,$(SRC_PATH)/tests/tcg/x86=
_64/rx_anonymous_bss.ld \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wl,--build-id=3Dnone \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $&lt; -o $@<br>
+<br>
+test-zerobss-2: $(SRC_PATH)/tests/tcg/x86_64/test-zerobss-2.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(CC) -nostdlib -static -fno-stack-protector -f=
no-pie -no-pie \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wl,-T,$(SRC_PATH)/tests/tcg/x86=
_64/rx_anonymous_bss.ld \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wl,--build-id=3Dnone \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $&lt; -o $@<br>
+<br>
=C2=A0%: $(SRC_PATH)/tests/tcg/x86_64/%.c<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(CC) $(CFLAGS) $&lt; -o $@ $(LDFLAGS)<br>
diff --git a/tests/tcg/x86_64/rx_anonymous_bss.ld b/tests/tcg/x86_64/rx_ano=
nymous_bss.ld<br>
new file mode 100644<br>
index 0000000000..3ec72fde6c<br>
--- /dev/null<br>
+++ b/tests/tcg/x86_64/rx_anonymous_bss.ld<br>
@@ -0,0 +1,27 @@<br>
+/* Linker script to create RX PT_LOAD with anonymous .bss tail<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+PHDRS<br>
+{<br>
+=C2=A0 =C2=A0 text PT_LOAD FLAGS(5);<br>
+}<br>
+SECTIONS<br>
+{<br>
+=C2=A0 =C2=A0 . =3D 0x400000;<br>
+=C2=A0 =C2=A0 .text : {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(.text .text.*)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _etext =3D .;<br>
+=C2=A0 =C2=A0 } :text<br>
+=C2=A0 =C2=A0 .bss ALIGN(1) : {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _bss_start =3D .;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(.bss .bss.* COMMON)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _bss_end =3D .;<br>
+=C2=A0 =C2=A0 } :text<br>
+=C2=A0 =C2=A0 /DISCARD/ : {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(.note.GNU-stack)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(.note.gnu.property)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(.comment)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(.eh_frame)<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+ENTRY(_start)<br>
diff --git a/tests/tcg/x86_64/test-zerobss-1.c b/tests/tcg/x86_64/test-zero=
bss-1.c<br>
new file mode 100644<br>
index 0000000000..809ea3cb52<br>
--- /dev/null<br>
+++ b/tests/tcg/x86_64/test-zerobss-1.c<br>
@@ -0,0 +1,20 @@<br>
+ /*<br>
+=C2=A0 * .bss region exists but unused<br>
+=C2=A0 * SPDX-License-Identifier: GPL-2.0-or-later<br>
+=C2=A0 */<br>
+int x;<br>
+void _start(void)<br>
+{<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Exit immediately &amp; never touched x<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 __asm__ volatile(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;mov $60, %%rax\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;xor %%rdi, %%rdi\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;syscall\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : /* no out */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : /* no in */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;rax&quot;, &quot;rdi&quot;<br>
+=C2=A0 =C2=A0 );<br>
+=C2=A0 =C2=A0 __builtin_unreachable();<br>
+}<br>
diff --git a/tests/tcg/x86_64/test-zerobss-2.c b/tests/tcg/x86_64/test-zero=
bss-2.c<br>
new file mode 100644<br>
index 0000000000..1f4f0d9704<br>
--- /dev/null<br>
+++ b/tests/tcg/x86_64/test-zerobss-2.c<br>
@@ -0,0 +1,36 @@<br>
+/*<br>
+ * Test case for zero_bss() with anonymous BSS in RX PT_LOAD<br>
+ *<br>
+ * This binary has .bss in the same PT_LOAD as .text (R_X permissions),<br=
>
+ * but the BSS is anonymous (beyond p_filesz), not file-backed.<br>
+ * Actual behavior:<br>
+ * old code: Fails with &quot;PT_LOAD with non-writable bss&quot;<br>
+ * new code: Succeeds, zeros BSS, exits with code 0<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+/* These will be included in .bss (uninitialized anonymous memory) */<br>
+int bss_value;<br>
+int bss_array[64];<br>
+<br>
+void _start(void)<br>
+{<br>
+=C2=A0 =C2=A0 int sum =3D bss_value;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 64; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sum +=3D bss_array[i];<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 /* If BSS was properly zeroed, sum should be 0 */<br>
+=C2=A0 =C2=A0 /* Exit with sum as exit code */<br>
+=C2=A0 =C2=A0 __asm__ volatile (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;movl %0, %%edi\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;movl $60, %%eax\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;syscall\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : /* no out*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r&quot; (sum)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;rdi&quot;, &quot;rax&quot;<br>
+=C2=A0 =C2=A0 );<br>
+<br>
+=C2=A0 =C2=A0 __builtin_unreachable();<br>
+}<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000f51f32064c23554b--

