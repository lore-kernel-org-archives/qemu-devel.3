Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AFAC87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujZ2t-0005Ah-B6; Wed, 06 Aug 2025 03:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1ujZ2j-00057M-5n
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:58:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1ujZ2h-0002Xb-7Z
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:58:36 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b7920354f9so5849140f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 00:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754467112; x=1755071912; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rEQ5uyrOLKaRE1iZfC6TC6DfKFr3slqqNRGVKsdJdNE=;
 b=OjRREBCkUAehd1A7u47VUt2ltJ1M9473d5PYFUu5qRwV12aX2xhVzzAJqViVWMhfXM
 MLdPSLXELfbteF6aKlwnFJR0wA9khHBqH8tDF1Hbj/GykmvS/+fUWVPU/5JpoUljwMFq
 gFo5bkKYuwNCtwHOuT5Olm/fQGtbiOmQPTiMlFRyx8r+VT76dKed26UXSHNV+eAVZn20
 9MR+VGmp9tq8Tmeb/JV7V4pIuQCDSj89/llSl5XFH2e+sWhQZ6+0jaS24HTwImRGMYsm
 0AS4DiLu63M4fUNgGyX4oL7cak2dUDhxeNyAIH+g5eWZ/KGJgxq4wNTa5mlh3k5GPmS6
 wptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754467112; x=1755071912;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rEQ5uyrOLKaRE1iZfC6TC6DfKFr3slqqNRGVKsdJdNE=;
 b=Xovh1ufGFiHTQA14UtfP+bOmwqcdVj0iJUgnIVpU++Qvat2ofd7aY9OT65yh2edPg2
 95m6/06SaSE8lkB15jjyQfSKsq1uWj1BQ9Wds59ac9WlETWuFdghi+MRBl1alkm5+QyC
 UXOSReYlQjCICLI9Agr+dPt/Tui9/rtBLZJrGIF+oB4zZ4oUrXZrqZRaJ2M27sDFD1Y2
 6tGQmHaBBe7nWYB0oL2z8FBob1m9KeASgGb1Brt66hW0NBx86pUVsrtVvqPyVLJlgdX+
 LroZP/fjuX2Oycp7i+/z+8qC/jv79bbDiqO2HIE6jaykcI7H2qBAwhlU0JlD+T40F6kU
 1D1A==
X-Gm-Message-State: AOJu0YzHZAdFKk+Iso3V/iHcjKQo6Er9rzbT5++MK6vvtWwWWRZ+Y2Mt
 6NYr+eqsxGkOcE0WRgetyZBcAxPMErGAJFne5hVVfuYH2Fmb9IX3nP9FcCmfUizPIAG57yx4VhC
 cmIBncikw2Rm7V4D05cH1Vez93uZI9MNGQemQ
X-Gm-Gg: ASbGnctyXKeiv8P1RQvFzvNdaqtgIjS/CzsZOYE+CiwtGS+t0zDLHH65Yag436u47WB
 1MoxrQuB1z63DzkLNy6zqP0YACkaL2PuUFlU2nS7jOg5HUQpJEyrDceK6FtfJlQKNJeN0209YI1
 MOE+JRCtwBl9GZ6ztirUkXIojwDQCe0l+DEvoMGaJZZwdyuGoWtlX0ZKOcWR7pb58eGMs6L/xPL
 NJpi16y8Ood+0iWbg==
X-Google-Smtp-Source: AGHT+IEVBq4kLsrz2oe/nHvgDftWdGRshkC0T+SYHHT+9Wqbl8woWzAixkL+norkHUP+80GOgkTf0xYoM288wsrPDug=
X-Received: by 2002:a05:6000:2586:b0:3a5:243c:6042 with SMTP id
 ffacd0b85a97d-3b8f4160d45mr1433096f8f.2.1754467111549; Wed, 06 Aug 2025
 00:58:31 -0700 (PDT)
MIME-Version: 1.0
From: Zero Tang <zero.tangptr@gmail.com>
Date: Wed, 6 Aug 2025 15:58:19 +0800
X-Gm-Features: Ac12FXzB1w3DJOiKZKBvgnoedrQmp2aeFdFOvGwuxDZURW2f944eViQxKDuSyiM
Message-ID: <CAAXNugBwiRuwiNHeuBV5U+HyrSisPSN-HL_7n6Pqc7oAOTX6Pw@mail.gmail.com>
Subject: [PATCH] i386/tcg/svm: fix incorrect canonicalization
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 Zero Linyakovskiy <zero.tangptr@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f44086063badb40b"
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=zero.tangptr@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000f44086063badb40b
Content-Type: text/plain; charset="UTF-8"

 Replaces "long" with "int64_t" during canonicalization.

 ---
 In Linux GCC, "long" has 8 bytes. However, in msys2 GCC, "long" has 4
 bytes. In this case, canonicalization would set all high bits to 1 when
 the segment base is bigger than 0x7FFF (assuming 48-bit linear address).

 This is why QEMU-TCG in Windows cannot boot a bluepill-like hypervisor
 in UEFI, in that the guest IDT and GDT bases are above 0x7FFF, thereby
 resulting in incorrect bases. When an interrupt arrives, it would
 trigger a #PF exception; the #PF would trigger again, resulting in a #DF
 exception; the #PF would trigger for the third time, resulting in
 triple-fault, and eventually causes the shutdown VM-Exit to the
 bluepill hypervisor right after it boots.

 In summary, this patch replaces "long" with "int64_t" in order to enforce
 the canonicalization with 64-bit signed integers.

 Signed-off-by: Zero Tang <zero.tangptr@gmail.com>
 ---
  target/i386/tcg/system/svm_helper.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

 diff --git a/target/i386/tcg/system/svm_helper.c
b/target/i386/tcg/system/svm_helper.c
 index b27049b9ed..1ccfccf419 100644
 --- a/target/i386/tcg/system/svm_helper.c
 +++ b/target/i386/tcg/system/svm_helper.c
 @@ -49,7 +49,7 @@ static void svm_save_seg(CPUX86State *env, int mmu_idx,
hwaddr addr,
  static inline void svm_canonicalization(CPUX86State *env, target_ulong
*seg_base)
  {
      uint16_t shift_amt = 64 - cpu_x86_virtual_addr_width(env);
 -    *seg_base = ((((long) *seg_base) << shift_amt) >> shift_amt);
 +    *seg_base = ((((int64_t) *seg_base) << shift_amt) >> shift_amt);
  }

  static void svm_load_seg(CPUX86State *env, int mmu_idx, hwaddr addr,

 ---
 base-commit: e0006a86615baa70bc9d8b183e528aed91c1ac90
 change-id: 20250806-fix-tcg-svm-canon-adbea9508073

 Best regards,
 --
 Zero Tang <zero.tangptr@gmail.com>

--000000000000f44086063badb40b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0Replaces &quot;long&quot; with &quot;int64_t&quot; d=
uring canonicalization.<br>=C2=A0<br>=C2=A0---<br>=C2=A0In Linux GCC, &quot=
;long&quot; has 8 bytes. However, in msys2 GCC, &quot;long&quot; has 4<br>=
=C2=A0bytes. In this case, canonicalization would set all high bits to 1 wh=
en<br>=C2=A0the segment base is bigger than 0x7FFF (assuming 48-bit linear =
address).<br>=C2=A0<br>=C2=A0This is why QEMU-TCG in Windows cannot boot a =
bluepill-like hypervisor<br>=C2=A0in UEFI, in that the guest IDT and GDT ba=
ses are above 0x7FFF, thereby<br>=C2=A0resulting in incorrect bases. When a=
n interrupt arrives, it would<br>=C2=A0trigger a #PF exception; the #PF wou=
ld trigger again, resulting in a #DF<br>=C2=A0exception; the #PF would trig=
ger for the third time, resulting in<br>=C2=A0triple-fault, and eventually =
causes the shutdown VM-Exit to the<br>=C2=A0bluepill hypervisor right after=
 it boots.<br>=C2=A0<br>=C2=A0In summary, this patch replaces &quot;long&qu=
ot; with &quot;int64_t&quot; in order to enforce<br>=C2=A0the canonicalizat=
ion with 64-bit signed integers.<br>=C2=A0<br>=C2=A0Signed-off-by: Zero Tan=
g &lt;<a href=3D"mailto:zero.tangptr@gmail.com">zero.tangptr@gmail.com</a>&=
gt;<br><font face=3D"monospace">=C2=A0---<br>=C2=A0 target/i386/tcg/system/=
svm_helper.c | 2 +-<br>=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)=
<br>=C2=A0<br>=C2=A0diff --git a/target/i386/tcg/system/svm_helper.c b/targ=
et/i386/tcg/system/svm_helper.c<br>=C2=A0index b27049b9ed..1ccfccf419 10064=
4<br>=C2=A0--- a/target/i386/tcg/system/svm_helper.c<br>=C2=A0+++ b/target/=
i386/tcg/system/svm_helper.c<br>=C2=A0@@ -49,7 +49,7 @@ static void svm_sav=
e_seg(CPUX86State *env, int mmu_idx, hwaddr addr,<br>=C2=A0 static inline v=
oid svm_canonicalization(CPUX86State *env, target_ulong *seg_base)<br>=C2=
=A0 {<br>=C2=A0 =C2=A0 =C2=A0 uint16_t shift_amt =3D 64 - cpu_x86_virtual_a=
ddr_width(env);<br>=C2=A0- =C2=A0 =C2=A0*seg_base =3D ((((long) *seg_base) =
&lt;&lt; shift_amt) &gt;&gt; shift_amt);<br>=C2=A0+ =C2=A0 =C2=A0*seg_base =
=3D ((((int64_t) *seg_base) &lt;&lt; shift_amt) &gt;&gt; shift_amt);<br>=C2=
=A0 }<br>=C2=A0 <br>=C2=A0 static void svm_load_seg(CPUX86State *env, int m=
mu_idx, hwaddr addr,<br>=C2=A0<br>=C2=A0---<br>=C2=A0base-commit: e0006a866=
15baa70bc9d8b183e528aed91c1ac90<br>=C2=A0change-id: 20250806-fix-tcg-svm-ca=
non-adbea9508073</font><br>=C2=A0<br>=C2=A0Best regards,<br>=C2=A0-- <br>=
=C2=A0Zero Tang &lt;<a href=3D"mailto:zero.tangptr@gmail.com">zero.tangptr@=
gmail.com</a>&gt;</div>

--000000000000f44086063badb40b--

