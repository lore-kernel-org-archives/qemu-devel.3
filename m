Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D6606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VLOk4dTq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0yb-0002Ge-6u; Thu, 19 Nov 2026 07:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU0yZ-0002G7-6Q
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:10:51 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU0yX-0001YW-Hx
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:10:50 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-67990a45e02so2112728d50.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 04:10:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795090247; cv=none;
 d=google.com; s=arc-20260327;
 b=lzQMOV602Jq5DbLt5jTipMEGzH1T5L5NwGySbpICnmbqk4Ecu5GMGTpU/DbJvG3OlK
 MY3N1yCEqdCMwu+/h+jKBmtfmwV/kpVzmPS+iVpSey23vIqrGfX9O2nFUGrIIaYyqSzQ
 4vlpHns5iK37+4W0Ulc0/JLck2zMS4FbfJ3ih5pva+qR2LWwwMWS6EJqAeUjhiAn9I44
 uTb7b+05TSxckSuj5t5lqy02ru9IA1oc5xX4fjn8Pg+i4PAHycGbCV46qfGRqTduJZ0F
 Jp2MSDsF9qcj1ZWcqe8ea4lv6mOVxG9jr3yf+51dMfHwjbbtugVpjAzso3NwupyWa3Y0
 C4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iPcBdzViZwQ+fNss99j44h/Sf0feLv3OOV2Aw6W59tg=;
 fh=cb6kDQaIrw4vgWAWyowOQrxSFLhOFkwVdiYImsKr/W4=;
 b=Qytuv4+gOBCRJTbTktArOQejlgab0tbNBBwAoaRrARDgAOrSe3/diFh0JclzCJwnv7
 59rSSubZAaAZMNHLAmzWQg7NeteXg3RTV5zsIHNMSiqlPbmv1sfvd9MIHTSCOlvtLa0H
 Zc47pTSxHQLA2BkmwDgdevRZncw7EbqCD10VrXMq5xCjfaWHqD45PZ5ew5vHHFw+ltKZ
 v7iyVvCkgxv7ao5sQquIihrBQSwDRQCBHJKT3ON6fDj3n4twTjq9fqPnwpIwXuJ7Yfxb
 TwX/3kTUlcW/nxSa2s2ct8zBK0+pirhJyx52ZKzm14rjDRkCFXbP/DmTUqqjG5Hr8OVW
 fH+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795090247; x=1795695047; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iPcBdzViZwQ+fNss99j44h/Sf0feLv3OOV2Aw6W59tg=;
 b=VLOk4dTqhWF4YH8GDiz+jz2tSNZZotgs2OH6UDjb2hIPWgZqUjbLtCig/LrcNGtni6
 Y8kW67nvKMdDh+To3+gBxu4TavLWboA9Z12oQKqjkd3ba4bI1t6HRqyASayW99eljyOc
 KACtb9Q8+ndBTmXo7u6niznkSeCqQ/vBwRftHZZ2iBq4/GqhflNGuSjq9ttnO0xk3URj
 oHDtoydzeL3u+vHhqKUoMTi4pnPBNlGdxTZZkwJACRGKnS3vLUfxLFnUFR8RlR5X7mr+
 wYQw3WNS69xWc1GtmNIeE3yuh6tb3aL27jKzPdhH7L2v37uj2AC8u9MJd0842PvytFL4
 Bb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795090247; x=1795695047;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iPcBdzViZwQ+fNss99j44h/Sf0feLv3OOV2Aw6W59tg=;
 b=2feBh56qFMhluTbtekukdC2BiBKV/XzlfTik/b6k2EF6peJkRizAr0iLbAGYXCw9IV
 rmouN/hTi+NMlO1F9b4FqHJrf8wupixrpnq1sijTLkXTJnsr3WNJEBWRUjvBPzKDcvou
 IHCaXfm6w0mwZ7GFwjpZQRJxtiqAWIEEXYCDQ69p/t4vBZyr/DBu2p5g1jmL0oVIXBT7
 ZEQ81szZNAjmXOy03vwop4HL71AFJlXhs5G9n4HHXgu/iJXsXXYlkDJUnT2zyko/R4RY
 M0nDh2xX+GAgUwSqZyggnQHmxZmBzSxrHrCNpf0VPZNYTFdP+jJyTYIGGzLte4fR7i6K
 koJg==
X-Gm-Message-State: APuU4Z//BLnUAJWhnuxRs+QhCydh8wC0Tt4H+CMMUxCMuz73NcHg++cl
 XWlP2wem+bNKA/IOd7rn5ZvU1gxr0G5trvFSxjmFPIHssCh89R/n64Mrgw96du8OyOHLQw+oFsT
 D6QiTkkcvwAThRw53cDEF9Yw7K42k1O1cVtT7cYHjJg==
X-Gm-Gg: AZFdTZcibNJZHURIsCqRmlU37IyOr6G2ko0JuyxNsaRou9fAaZM7VB3KvkDnG75ykir
 +tOmxcoWeRJOSWVNPym7WTbEr5cbvt1G/yIypoATwOF2hf1MBr6CS36WUy/RbI7kqz8TB3dyZFN
 YmXjcbLr0gpCdoHFBJWoj5ieYz5aD/1PrQefByvN6mMJptfxxf81o//xb1X9sKmMYuZbxMeZ6G3
 7wpcV9P4Z2f7Z3w73hA5pHW+U3y+c8Kif/4ziic48fHMI07rlW7HtfX6uW+S75tOOpPTXCMKHbX
 v7b4w2rC3W65WXPq1ska4eesplhLj+5526goXyV3Rg6BN+M8KWbaz8eUZCgEECPiknpv2ChwGG4
 9WIpWdVNS2h1/E69O6TgbfLLKzlKzx+XkmfK03phBHEW/063JGRt883aktCw4Rs9ivkJGSQyOe4
 JfJ1jTRiLsSeGinit9Z93m
X-Received: by 2002:a05:690e:108a:20b0:67c:864:5982 with SMTP id
 956f58d0204a3-67dd3fa561amr1783290d50.76.1795090247451; Thu, 19 Nov 2026
 04:10:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117133750.322253-1-pbonzini@redhat.com>
 <20261117133750.322253-3-pbonzini@redhat.com>
In-Reply-To: <20261117133750.322253-3-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Nov 2026 12:10:35 +0000
X-Gm-Features: AclHuK9vlhOZjjXuG5g0IzYkUcivdOob2j1p2t27cO3UYLTzVLnOTvj0pi3_lNY
Message-ID: <CAFEAcA9YRZTkdjhOm9M6kW_E8HayQONUNEFWdVg=t7k6Ow273g@mail.gmail.com>
Subject: Re: [PULL 02/15] target/i386/tcg: reject VEX encodings of PBLENDVB,
 BLENDVPS and BLENDVPD
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 17 Nov 2026 at 13:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The opcodes 66 0F 38 10, 14 and 15 (PBLENDVB, BLENDVPS and BLENDVPD) have
> vex_class 4, which allows both the legacy and the VEX encoding, so
> VEX.66.0F38 10, 14 and 15 were decoded as the same instructions.  The VEX
> forms of these instructions are VPBLENDVB, VBLENDVPS and VBLENDVPD, which
> have four operands and are in map 0F 3A, so the VEX opcodes in map 0F 38
> should raise #UD.
>
> Keep vex_class 4, which provides the legacy SSE checks, and add a new
> vex_special that raises #UD if the VEX or EVEX prefix is present.  This
> is borderline disgusting, but an effective solution to x86's opcode spraw=
l
> will have to wait for a new AI policy...
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi; this test case fails "make check" if built with clang.

Configure flags:
  '--cc=3Dclang' '--cxx=3Dclang++'
'--target-list=3Dx86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-u=
ser'
'--enable-debug'

The failure happens because clang complains about the clobbers
line in the SSE_INSN macro:

FAILED: tests/tcg/i386-linux-user-test-i386-blendv.test
/home/pm215/qemu/tests/tcg/../docker/docker.py --command podman run
--run-as-current-user -- --security-opt label=3Ddisable --platform
linux/amd64 -w /home/pm215/qemu/build/x86-clang -v
/home/pm215/qemu/build/x86-clang:/home/pm215/qemu/build/x86-clang -v
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

> +/* 66 0F 38 xx with modrm =3D 11 001 001 (xmm1, xmm1 operands).  */
> +#define SSE_INSN(op) asm volatile(".byte 0x66, 0x0f, 0x38, " #op ", 0xc9=
" \
> +                                     : : : "xmm0", "xmm1")

thanks
-- PMM

