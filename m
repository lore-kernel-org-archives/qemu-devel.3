Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EAC606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p3rWcFOa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU1I5-0005Cf-8L; Thu, 19 Nov 2026 07:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU1Hc-0005Az-Kf
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:30:32 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU1Ha-0007S1-CM
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:30:32 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-67dae7d3f7dso2512117d50.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 04:30:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795091429; cv=none;
 d=google.com; s=arc-20260327;
 b=kExwMH4HwDXYXAdWuaJw8+kX7GcIV9KPQvyg3eRgMTslHn8gMJxiGeVPl8ftsPpG6n
 MYLu7oRlEfG+3N1cZepMe8qQDXbZ+vUfUzRdHYNtcRwXKs+StxLXWtAstxisrgpcHcfl
 eTKCao0UN5pLtykvZPNwPtB4B0jTlkrTuv0Ty7POxIwBhd15yW1SqKzVNU1EacYgDr/Z
 jnU7RTKdUYELsMmewDBrcNV9xJpdVh/3TeLGGEYfoyMrbxAThfTm6iKsKVj4WXSmH3ON
 e6svl9FEvTAn1Qcbhg17hCdk+zGEn8GkfshGcqsnVmVRBXq+HbGG4KRXrYBTfwXQ/gS2
 89nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FkxX51kyglOHMyIJgjEF57xoJHQA3Ydw84c+6OZBTt4=;
 fh=cb6kDQaIrw4vgWAWyowOQrxSFLhOFkwVdiYImsKr/W4=;
 b=q9vu3HM1fG06MquMb4QuQjKIrPyTfckDns3r24KYTTcLWnH4gPFE3TSIN3SnCAPAQm
 QA5dFmPB6q0fLLyb570O6A5KOzK3bpZwJ95cGMA6Z5B75Mjj5bnn+/125zbFlEizGnpP
 0uc8VVJp3RdtVdptD218ln4ltfDCme3tU1yKUC8g4JCgdrBFL0codNKIoKGqCn/ZNz3K
 7N0rmQNjDk6NWAABl1lijNK9rPWuiEWvyqxdt4roYEJka9lw/fv1C4dOInO8PcIWpvRY
 95wo+wuXf9gbkMmPpgjlyUgXoOAU6FYGFJ78/19Ahe4Ts9sIL5wSWZfODHi8Cu/Z4ywi
 PGQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795091429; x=1795696229; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FkxX51kyglOHMyIJgjEF57xoJHQA3Ydw84c+6OZBTt4=;
 b=p3rWcFOab5l+s9EbaVXfV4VvjGBi19evT8PUbu1a/KbFoil1CftGudu6A8ADrA/k8l
 EzUiMoHSsMO9Oz0qmH/R8zf1YKpEbZAZVCFTAqlVwPUomEN/hfmLfZTGKu9daR2HmX5p
 3A1Fpw+oQLYJd2uO5Jqrhn8j4qM2OSoyBndQysoSUnW7YV+1Se382h30c4gGHwJarC1b
 cTawTLZZnQSFMTkHPHcsiXIgmUdQAdKbWoKhefzhgkISJM9T6X7pFgsBWwLtRYNpEvpR
 ZHkS7NkrICp0ePJfRjGuzKPvWxCgTMcJjuUE8EahMdFTHXuoYrHeiCDE7FtPRbUopmj9
 1NIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795091429; x=1795696229;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FkxX51kyglOHMyIJgjEF57xoJHQA3Ydw84c+6OZBTt4=;
 b=Ca3nrGo8tB23IIX3TaNFoiuqfKm2h7MptFIiOG0v5nEmMcj3bNbUTe1wln5PJF0f8y
 TKP+z0utyJS4MuCBLf4Nkauth8kpiW8Cy4YocpMUtCg502b3d/OR0sfetY8WZEUgOWB1
 W+uGDsJ2VxGHIqGMQM23dj20oxNBtoMhJ5UuTGFtWz9xM8hsWGdc4DCeGe9rEhvQ+aE6
 3hhnu2lKEx3Ar7u3XEM1F0bGndw1M7/E0XWP3NWYCBgeIJcItxnnu1xrASGo3KFVNDHd
 45TlIpkVBzu1/K7YRGSw4O1fHTZDE7QGiBr004yYxnVjBbQwC2JwI0rnvW9nmc59s/YC
 TMXw==
X-Gm-Message-State: APuU4Z9F0SrBClPm0WmUTytucmX1SBpSujgPAEDKi1WuEnHQuSDC5YEg
 WHsWebqaCaDb+P10zQvF/RU0sV4lH2+sssSUQFPpWOhXYtnJ8u3m769vBBRHcsk6fTuWVwGHuiM
 so4f0tD49d4oc3rtD33AhLJ+WCZKnEduEjsp+ggadHg==
X-Gm-Gg: AZFdTZcTOe9bo4M//nJMFLCaXkATh36VV7MAySHqKFtES3V7NEAYtWa0yB8Tm5v4eV9
 4tZZhJ/MXlP1dC7dnGPMs+fokMAOz85jh/eyp4eM41f5fYIU7lV5qDDkiW+ULN/dLcFKik8Ebmr
 MBPUdpk+Z8U7ZpuwzEjyjDp9UgVp+ZXREY1/p44WbEYaML4rbnPhWwqC0yATVGl7KBm7BilwwZb
 OgEyAOHTXqEMOzgeVKp7s032ybaa19KZQn6vfyudC3Te+9JQ12F1afW5nrfD/PVVWi3MnozsXSS
 HAOAJ7wQmjgwYqr+5oyn4Aq+/97vIcLwdDvh/tGhqMUVtx78/9NbULfwau4mdiTmR4CZrh7wcgC
 GTQ05w9i+Wh8gMB0kK7giRMbXPwecYB5OtJJLtllHhzwMFKwbqcG49hz5DLouRXxr+dYl8sk3u5
 kh9DoKXFOQ1Vo138csNavY
X-Received: by 2002:a05:690e:400b:b0:67c:41a:bf5b with SMTP id
 956f58d0204a3-67dd3cf2cc4mr2003491d50.9.1795091428651; Thu, 19 Nov 2026
 04:30:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117133750.322253-1-pbonzini@redhat.com>
 <20261117133750.322253-3-pbonzini@redhat.com>
 <CAFEAcA9YRZTkdjhOm9M6kW_E8HayQONUNEFWdVg=t7k6Ow273g@mail.gmail.com>
In-Reply-To: <CAFEAcA9YRZTkdjhOm9M6kW_E8HayQONUNEFWdVg=t7k6Ow273g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Nov 2026 12:30:16 +0000
X-Gm-Features: AclHuK9cegAst_y2xvbJzCHEUVAT8F9H-beku9TS-lhl2KmT89j4V2_SzghSbWo
Message-ID: <CAFEAcA-9Z5bXAedSmRBHOonR3rXjHhzTLtt3HNBws4OkiFCyYg@mail.gmail.com>
Subject: Re: [PULL 02/15] target/i386/tcg: reject VEX encodings of PBLENDVB,
 BLENDVPS and BLENDVPD
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 12:10, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Tue, 17 Nov 2026 at 13:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The opcodes 66 0F 38 10, 14 and 15 (PBLENDVB, BLENDVPS and BLENDVPD) ha=
ve
> > vex_class 4, which allows both the legacy and the VEX encoding, so
> > VEX.66.0F38 10, 14 and 15 were decoded as the same instructions.  The V=
EX
> > forms of these instructions are VPBLENDVB, VBLENDVPS and VBLENDVPD, whi=
ch
> > have four operands and are in map 0F 3A, so the VEX opcodes in map 0F 3=
8
> > should raise #UD.
> >
> > Keep vex_class 4, which provides the legacy SSE checks, and add a new
> > vex_special that raises #UD if the VEX or EVEX prefix is present.  This
> > is borderline disgusting, but an effective solution to x86's opcode spr=
awl
> > will have to wait for a new AI policy...
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Hi; this test case fails "make check" if built with clang.
>
> Configure flags:
>   '--cc=3Dclang' '--cxx=3Dclang++'
> '--target-list=3Dx86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux=
-user'
> '--enable-debug'

...and in fact it breaks with gcc too:

/home/pm215/qemu/tests/tcg/../docker/docker.py --command podman run
--run-as-current-user -- --security-opt label=3Ddisable --platform
linux/amd64 -w /home/pm215/qemu/build/x86 -v
/home/pm215/qemu/build/x86:/home/pm215/qemu/build/x86 -v
/home/pm215/qemu:/home/pm215/qemu qemu/debian-i686-cross
i686-linux-gnu-gcc ../../tests/tcg/i386/test-i386-blendv.c -o
tests/tcg/i386-linux-user-test-i386-blendv.test -static -MMD -MF
tests/tcg/i386-linux-user-test-i386-blendv.d -Wall -Werror -O0 -g
-fno-strict-aliasing -fno-stack-protector
../../tests/tcg/i386/test-i386-blendv.c: In function =E2=80=98main=E2=80=99=
:
../../tests/tcg/i386/test-i386-blendv.c:20:22: error: the register
=E2=80=98xmm1=E2=80=99 cannot be clobbered in =E2=80=98asm=E2=80=99 for the=
 current target
   20 | #define SSE_INSN(op) asm volatile(".byte 0x66, 0x0f, 0x38, "
#op ", 0xc9" \
      |                      ^~~
../../tests/tcg/i386/test-i386-blendv.c:43:5: note: in expansion of
macro =E2=80=98SSE_INSN=E2=80=99
   43 |     SSE_INSN(0x10);
      |     ^~~~~~~~
../../tests/tcg/i386/test-i386-blendv.c:20:22: error: the register
=E2=80=98xmm1=E2=80=99 cannot be clobbered in =E2=80=98asm=E2=80=99 for the=
 current target
   20 | #define SSE_INSN(op) asm volatile(".byte 0x66, 0x0f, 0x38, "
#op ", 0xc9" \
      |                      ^~~
../../tests/tcg/i386/test-i386-blendv.c:44:5: note: in expansion of
macro =E2=80=98SSE_INSN=E2=80=99
   44 |     SSE_INSN(0x14);
      |     ^~~~~~~~
../../tests/tcg/i386/test-i386-blendv.c:20:22: error: the register
=E2=80=98xmm1=E2=80=99 cannot be clobbered in =E2=80=98asm=E2=80=99 for the=
 current target
   20 | #define SSE_INSN(op) asm volatile(".byte 0x66, 0x0f, 0x38, "
#op ", 0xc9" \
      |                      ^~~
../../tests/tcg/i386/test-i386-blendv.c:45:5: note: in expansion of
macro =E2=80=98SSE_INSN=E2=80=99
   45 |     SSE_INSN(0x15);
      |     ^~~~~~~~

I'm not sure how this made it through CI, maybe it's a compiler
version related thing?

thanks
-- PMM

