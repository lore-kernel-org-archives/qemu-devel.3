Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B519CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 08:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unuqL-0006OF-VZ; Mon, 18 Aug 2025 04:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1unuqK-0006NQ-2f
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 04:03:48 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1unuqI-0003JQ-6U
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 04:03:47 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b9e4148134so1844406f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 01:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755504223; x=1756109023; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/p3WKBhx8t2zKoh6VUTPyCzQxr3ulgkU2ZFP5VimQMg=;
 b=OwI95ZNiu1Cmw1CTqTXDQIVUkly9jHF0mADYnh1Cm4LRgRv6H7Mu40+aPXABlKWGe0
 Vfg2MdwD/Fov9hduhy5ddD+4fTDoK4JgJNjFddEQGmO5BKRm5OBrjnrTkhxO5PcKoyiT
 75KtGkI2OZJs93LMmw+y17BQ82S0rlq9iqZtUw6LCBzcqlirms7QTOsIOQnIPqW/IgGe
 fFY26sNg0+dhm0jJIfFTIf6PskkhgFYsXykxG6E5DWdd9tHtoYZu/X2nUu/1TSGroJLj
 nuXucPh0bCEgjqo0u/ThW7xxwbB/lTtnU0FjV9jeQlISwFWszsnLZ1sldRT3D8r6czQV
 EdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755504223; x=1756109023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/p3WKBhx8t2zKoh6VUTPyCzQxr3ulgkU2ZFP5VimQMg=;
 b=czD5cquH5uWM+R2WIGQcadafn5AZkk91WAlnxOTYFxmJn3yHym2dyAOZmJgACnq17h
 eWfTHQHN3vzp4tAWoCLRPf+qiiAq4B/4f+6cw8LTfLOTJfhkiU/JdKYUHVa0pH16WtQA
 utlRSR3c44Kq/RMXvGwOpzLVB6gSeq+xYA6jqc3ibxsbDaVJWYa9VxutXoSYZhds8viD
 jk9E2CCKZpQgJpjSk6XyO18+jsGe2ry8W4KsjeU4eur96IrF8FUiMgDWsh9fnumlzg7d
 EqI5v4CHKlrkw44oL34HBWUTf37ur7/FMhq+JcOIeq/+3Axr6dRFqi9k86UrmluCntPd
 F80w==
X-Gm-Message-State: AOJu0YzPlvbMdaFPm7wfGjhLxxKpDRS3DbOMzwtCtlDjnmw5hRWvUty1
 cs2JWPVTh3OUTsoU9Fjb0+XiSgZehCP/KWJr/J3uo/HsFZSResdTKPEedTUxFZWmcUuviME4q09
 8oN3eDdv0eAi57QHlbQoxJYwGC/5EKgSgpWVc7BI=
X-Gm-Gg: ASbGnctsHiiludqTiDrmjnD/ZE02RDnwAtx0wAMjHI91us8vzMFVTJrrO01cKM9vuhS
 Dah/d6jh6JoVbXpMFY93U15q4PETzNlDibpHqevYh0ZmkBkUAiEnSQXyUwomM2YZ9Ul4UCJSos3
 qJAlaFsDBAuHVQM63xDBj535tOz3GbR975c6qrrnJFPB5lqqNQexjGWyuUDipsIbF9kQgGsGKRb
 e0v49Ho
X-Google-Smtp-Source: AGHT+IFB5WE8Wjvfeb5mTeHqn5nNXFVyp6/i4DjbFvDlt8tVXwjQSIbtiVTHlT3mTDu5+xX4p0LEnsUQVhjEixyI04s=
X-Received: by 2002:a05:6000:2dc8:b0:3b7:7c3b:1073 with SMTP id
 ffacd0b85a97d-3bb692bd8c8mr7723112f8f.52.1755504223247; Mon, 18 Aug 2025
 01:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAAXNugBwiRuwiNHeuBV5U+HyrSisPSN-HL_7n6Pqc7oAOTX6Pw@mail.gmail.com>
In-Reply-To: <CAAXNugBwiRuwiNHeuBV5U+HyrSisPSN-HL_7n6Pqc7oAOTX6Pw@mail.gmail.com>
From: Zero Tang <zero.tangptr@gmail.com>
Date: Mon, 18 Aug 2025 16:02:00 +0800
X-Gm-Features: Ac12FXydMZwSwKBYL5wusdJzDEyyG-wFzRiuciE6GuWI96rpoz20bn18fiX1QgM
Message-ID: <CAAXNugCc6oQ3Py83bCKL8ksMziAmr+TQHbfUCC6wcgqMas31ng@mail.gmail.com>
Subject: Re: [PATCH] i386/tcg/svm: fix incorrect canonicalization
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net
Content-Type: multipart/alternative; boundary="000000000000a0f6e0063c9f2d3e"
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=zero.tangptr@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000a0f6e0063c9f2d3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'd like to PING this patch in that it's been two weeks since I sent the
patch.

Kind regards,
Zero Tang

On Wed, Aug 6, 2025 at 3:58=E2=80=AFPM Zero Tang <zero.tangptr@gmail.com> w=
rote:

>  Replaces "long" with "int64_t" during canonicalization.
>
>  ---
>  In Linux GCC, "long" has 8 bytes. However, in msys2 GCC, "long" has 4
>  bytes. In this case, canonicalization would set all high bits to 1 when
>  the segment base is bigger than 0x7FFF (assuming 48-bit linear address).
>
>  This is why QEMU-TCG in Windows cannot boot a bluepill-like hypervisor
>  in UEFI, in that the guest IDT and GDT bases are above 0x7FFF, thereby
>  resulting in incorrect bases. When an interrupt arrives, it would
>  trigger a #PF exception; the #PF would trigger again, resulting in a #DF
>  exception; the #PF would trigger for the third time, resulting in
>  triple-fault, and eventually causes the shutdown VM-Exit to the
>  bluepill hypervisor right after it boots.
>
>  In summary, this patch replaces "long" with "int64_t" in order to enforc=
e
>  the canonicalization with 64-bit signed integers.
>
>  Signed-off-by: Zero Tang <zero.tangptr@gmail.com>
>  ---
>   target/i386/tcg/system/svm_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
>  diff --git a/target/i386/tcg/system/svm_helper.c
> b/target/i386/tcg/system/svm_helper.c
>  index b27049b9ed..1ccfccf419 100644
>  --- a/target/i386/tcg/system/svm_helper.c
>  +++ b/target/i386/tcg/system/svm_helper.c
>  @@ -49,7 +49,7 @@ static void svm_save_seg(CPUX86State *env, int mmu_idx=
,
> hwaddr addr,
>   static inline void svm_canonicalization(CPUX86State *env, target_ulong
> *seg_base)
>   {
>       uint16_t shift_amt =3D 64 - cpu_x86_virtual_addr_width(env);
>  -    *seg_base =3D ((((long) *seg_base) << shift_amt) >> shift_amt);
>  +    *seg_base =3D ((((int64_t) *seg_base) << shift_amt) >> shift_amt);
>   }
>
>   static void svm_load_seg(CPUX86State *env, int mmu_idx, hwaddr addr,
>
>  ---
>  base-commit: e0006a86615baa70bc9d8b183e528aed91c1ac90
>  change-id: 20250806-fix-tcg-svm-canon-adbea9508073
>
>  Best regards,
>  --
>  Zero Tang <zero.tangptr@gmail.com>
>

--000000000000a0f6e0063c9f2d3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I&#39;d like to PING this patch =
in that it&#39;s been two weeks since I sent the patch.</div><div><br></div=
><div>Kind regards,</div><div>Zero Tang</div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 6, 2025 at 3:58=E2=
=80=AFPM Zero Tang &lt;<a href=3D"mailto:zero.tangptr@gmail.com" target=3D"=
_blank">zero.tangptr@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div dir=3D"ltr">=C2=A0Replaces &quot;long&qu=
ot; with &quot;int64_t&quot; during canonicalization.<br>=C2=A0<br>=C2=A0--=
-<br>=C2=A0In Linux GCC, &quot;long&quot; has 8 bytes. However, in msys2 GC=
C, &quot;long&quot; has 4<br>=C2=A0bytes. In this case, canonicalization wo=
uld set all high bits to 1 when<br>=C2=A0the segment base is bigger than 0x=
7FFF (assuming 48-bit linear address).<br>=C2=A0<br>=C2=A0This is why QEMU-=
TCG in Windows cannot boot a bluepill-like hypervisor<br>=C2=A0in UEFI, in =
that the guest IDT and GDT bases are above 0x7FFF, thereby<br>=C2=A0resulti=
ng in incorrect bases. When an interrupt arrives, it would<br>=C2=A0trigger=
 a #PF exception; the #PF would trigger again, resulting in a #DF<br>=C2=A0=
exception; the #PF would trigger for the third time, resulting in<br>=C2=A0=
triple-fault, and eventually causes the shutdown VM-Exit to the<br>=C2=A0bl=
uepill hypervisor right after it boots.<br>=C2=A0<br>=C2=A0In summary, this=
 patch replaces &quot;long&quot; with &quot;int64_t&quot; in order to enfor=
ce<br>=C2=A0the canonicalization with 64-bit signed integers.<br>=C2=A0<br>=
=C2=A0Signed-off-by: Zero Tang &lt;<a href=3D"mailto:zero.tangptr@gmail.com=
" target=3D"_blank">zero.tangptr@gmail.com</a>&gt;<br><font face=3D"monospa=
ce">=C2=A0---<br>=C2=A0 target/i386/tcg/system/svm_helper.c | 2 +-<br>=C2=
=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>=C2=A0<br>=C2=A0diff -=
-git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_hel=
per.c<br>=C2=A0index b27049b9ed..1ccfccf419 100644<br>=C2=A0--- a/target/i3=
86/tcg/system/svm_helper.c<br>=C2=A0+++ b/target/i386/tcg/system/svm_helper=
.c<br>=C2=A0@@ -49,7 +49,7 @@ static void svm_save_seg(CPUX86State *env, in=
t mmu_idx, hwaddr addr,<br>=C2=A0 static inline void svm_canonicalization(C=
PUX86State *env, target_ulong *seg_base)<br>=C2=A0 {<br>=C2=A0 =C2=A0 =C2=
=A0 uint16_t shift_amt =3D 64 - cpu_x86_virtual_addr_width(env);<br>=C2=A0-=
 =C2=A0 =C2=A0*seg_base =3D ((((long) *seg_base) &lt;&lt; shift_amt) &gt;&g=
t; shift_amt);<br>=C2=A0+ =C2=A0 =C2=A0*seg_base =3D ((((int64_t) *seg_base=
) &lt;&lt; shift_amt) &gt;&gt; shift_amt);<br>=C2=A0 }<br>=C2=A0 <br>=C2=A0=
 static void svm_load_seg(CPUX86State *env, int mmu_idx, hwaddr addr,<br>=
=C2=A0<br>=C2=A0---<br>=C2=A0base-commit: e0006a86615baa70bc9d8b183e528aed9=
1c1ac90<br>=C2=A0change-id: 20250806-fix-tcg-svm-canon-adbea9508073</font><=
br>=C2=A0<br>=C2=A0Best regards,<br>=C2=A0-- <br>=C2=A0Zero Tang &lt;<a hre=
f=3D"mailto:zero.tangptr@gmail.com" target=3D"_blank">zero.tangptr@gmail.co=
m</a>&gt;</div>
</blockquote></div>

--000000000000a0f6e0063c9f2d3e--

