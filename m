Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E18CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 15:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo22K-0005FC-BX; Mon, 18 Aug 2025 11:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1uo22J-0005Ee-3Q
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 11:44:39 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zero.tangptr@gmail.com>)
 id 1uo22H-0005hM-Ft
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 11:44:38 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a28ff47a0so7673895e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 08:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755531875; x=1756136675; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=53pY2YEAtY8HvvohLk0U/sgRS3vn1wH8FzoLbtoiGC0=;
 b=FZ2biWLTwQwf2avTWZPZEUT6q4urVtbfDcxnhFrJTYxnOAlID2fNM0M5JI9j3jJVYs
 KPVTTcTXFN5lyVlkad3FwHraAvezyaGpmcRIBQaZ4UnJzdg3SqTINi/YmuEvpXcnf/6H
 4pnK5Ymj2nRCwRbg+F/8ZFRcs13GT4voxAAYO/pwUZBXxrsz14fNS/NBSw7UZbMg+Ckm
 uA6/HQDcX5HsdILzuVWTDUhpi0y376BYGUMgC6vij9dMGHhEkpbAlZIN/bRkAKETgJdt
 dPJLDX3OWH1T5ZWHmK94jk5lImeKMvsfjDiTN22/KQJKvGlNpI7s90/FG3kRcJ4g/1dM
 wlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755531875; x=1756136675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=53pY2YEAtY8HvvohLk0U/sgRS3vn1wH8FzoLbtoiGC0=;
 b=FM0p3gI1XcloCqEbmF0TEpTKoUQJ/MRO2+hxmFpVyq/5QvmGgw1Vr8ZwFkyjpF62+d
 cJwheCyOhnAX0OeSaeJbyF2hr768XMcgyXnJRszer2jyBWsxPgvHi4clcUI3DLw21CwF
 jjzyeTih3FBoTwkR5x7w7wrALrnquVWj4pKIjpP/v7f9exZvBhDUDk1BRoN7dbeu0fug
 U29QLORXIo0dAeDOLuyOZxj4Q8YSI/tYq864Amqk3g9hyPlMDHuxRdvy+vNchLfEqvxF
 q4xDQi8NqeMHXxZRNchFF2oO8zmM9+ab8eMAtMk9ertJ4cHGzYOFih5FNPhyRkhRAEW7
 xeew==
X-Gm-Message-State: AOJu0Yx0B6i2EQ7Uf7TpLJVemb2rpXQzAm72OobQ6NTMeIIVp0eX3Fc1
 gC5fiH3N2cC+4lU47uHtww4AFhrlx/5wZj9Rfb7cotklOJ564jwOW0CX7A7ZF6++TOa+4J4Xmfx
 NAwerSxcl1K8t2QnSZ55zn6QGfy9tyXQ=
X-Gm-Gg: ASbGncsTLuODGeKYmBwH9uAEVvCmSkv58ud2vLwbI7Jfq+PBeYOvz7oqbnoFiENauNt
 iVcddYjxzdT/qLYMvbjqPCcj17F1fQHzP4rzRGZxiW0rAeGiEG8VyXssIN6pJn8olT0JLjL4HP/
 wkM5Exz+H9IJJW4BaB7D2Jj0YD6IL5vpi3hXcWPYcvGFGX43fIUyl/E/rUwhc0qHGSpKr9shHwH
 Gx5cgnf
X-Google-Smtp-Source: AGHT+IEZYiYp/cpmi9hcK48VN2AInup+xILDPnLCT+IWYcUDNb3eywjoGjVV4z4KICgqgrT1nGCdP8SCvn81kQJB8Zc=
X-Received: by 2002:a05:6000:40c7:b0:3b8:d1a4:bab9 with SMTP id
 ffacd0b85a97d-3bb68ee7120mr9449808f8f.45.1755531874605; Mon, 18 Aug 2025
 08:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAAXNugBwiRuwiNHeuBV5U+HyrSisPSN-HL_7n6Pqc7oAOTX6Pw@mail.gmail.com>
 <c92d983d-0b89-467b-b5e2-b09fe61ff5b9@linaro.org>
In-Reply-To: <c92d983d-0b89-467b-b5e2-b09fe61ff5b9@linaro.org>
From: Zero Tang <zero.tangptr@gmail.com>
Date: Mon, 18 Aug 2025 23:44:20 +0800
X-Gm-Features: Ac12FXy7mPIw0Pfj55CBKkQTIHBKPMVMYAPflMZ8ZMSIr1DyNu64EvyigB7sVA4
Message-ID: <CAAXNugAJAD=2aBenCJWR-xYt2HszJjEAguxfDBE=hNYZ+osu4w@mail.gmail.com>
Subject: Re: [PATCH] i386/tcg/svm: fix incorrect canonicalization
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, Lara Lazier <laramglazier@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c7244e063ca59dcd"
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=zero.tangptr@gmail.com; helo=mail-wm1-x32e.google.com
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

--000000000000c7244e063ca59dcd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Thanks for your review comment! But if the patch is already
queued, is it too late to apply it?

Kind regards,
Zero Tang

On Mon, Aug 18, 2025 at 8:16=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Zero,
>
> On 6/8/25 09:58, Zero Tang wrote:
> >   Replaces "long" with "int64_t" during canonicalization.
> >
> >   ---
> >   In Linux GCC, "long" has 8 bytes. However, in msys2 GCC, "long" has 4
> >   bytes. In this case, canonicalization would set all high bits to 1 wh=
en
> >   the segment base is bigger than 0x7FFF (assuming 48-bit linear
> address).
> >
> >   This is why QEMU-TCG in Windows cannot boot a bluepill-like hyperviso=
r
> >   in UEFI, in that the guest IDT and GDT bases are above 0x7FFF, thereb=
y
> >   resulting in incorrect bases. When an interrupt arrives, it would
> >   trigger a #PF exception; the #PF would trigger again, resulting in a
> #DF
> >   exception; the #PF would trigger for the third time, resulting in
> >   triple-fault, and eventually causes the shutdown VM-Exit to the
> >   bluepill hypervisor right after it boots.
> >
> >   In summary, this patch replaces "long" with "int64_t" in order to
> enforce
> >   the canonicalization with 64-bit signed integers.
> >
> >   Signed-off-by: Zero Tang <zero.tangptr@gmail.com
> > <mailto:zero.tangptr@gmail.com>>
> >   ---
> >    target/i386/tcg/system/svm_helper.c | 2 +-
> >    1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >   diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/
> > system/svm_helper.c
> >   index b27049b9ed..1ccfccf419 100644
> >   --- a/target/i386/tcg/system/svm_helper.c
> >   +++ b/target/i386/tcg/system/svm_helper.c
> >   @@ -49,7 +49,7 @@ static void svm_save_seg(CPUX86State *env, int
> > mmu_idx, hwaddr addr,
> >    static inline void svm_canonicalization(CPUX86State *env,
> > target_ulong *seg_base)
> >    {
> >        uint16_t shift_amt =3D 64 - cpu_x86_virtual_addr_width(env);
> >   -    *seg_base =3D ((((long) *seg_base) << shift_amt) >> shift_amt);
> >   +    *seg_base =3D ((((int64_t) *seg_base) << shift_amt) >> shift_amt=
);\
>
> Alternatively:
>
>           *seg_base =3D sextract64(*seg_base, 0, 64 -
> cpu_x86_virtual_addr_width(env));
>
> >    }
> >
> >    static void svm_load_seg(CPUX86State *env, int mmu_idx, hwaddr addr,
> >
> >   ---
> >   base-commit: e0006a86615baa70bc9d8b183e528aed91c1ac90
> >   change-id: 20250806-fix-tcg-svm-canon-adbea9508073
> >
> >   Best regards,
> >   --
> >   Zero Tang <zero.tangptr@gmail.com <mailto:zero.tangptr@gmail.com>>
>
>

--000000000000c7244e063ca59dcd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Philippe,<div><br></div><div>Thanks for your review com=
ment! But if the patch is already</div><div>queued, is it too late to apply=
 it?</div><div><br></div><div>Kind regards,</div><div>Zero Tang</div></div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, Aug 18, 2025 at 8:16=E2=80=AFPM Philippe Mathieu-Da=
ud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Zero,=
<br>
<br>
On 6/8/25 09:58, Zero Tang wrote:<br>
&gt;=C2=A0 =C2=A0Replaces &quot;long&quot; with &quot;int64_t&quot; during =
canonicalization.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0In Linux GCC, &quot;long&quot; has 8 bytes. However, in ms=
ys2 GCC, &quot;long&quot; has 4<br>
&gt;=C2=A0 =C2=A0bytes. In this case, canonicalization would set all high b=
its to 1 when<br>
&gt;=C2=A0 =C2=A0the segment base is bigger than 0x7FFF (assuming 48-bit li=
near address).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0This is why QEMU-TCG in Windows cannot boot a bluepill-lik=
e hypervisor<br>
&gt;=C2=A0 =C2=A0in UEFI, in that the guest IDT and GDT bases are above 0x7=
FFF, thereby<br>
&gt;=C2=A0 =C2=A0resulting in incorrect bases. When an interrupt arrives, i=
t would<br>
&gt;=C2=A0 =C2=A0trigger a #PF exception; the #PF would trigger again, resu=
lting in a #DF<br>
&gt;=C2=A0 =C2=A0exception; the #PF would trigger for the third time, resul=
ting in<br>
&gt;=C2=A0 =C2=A0triple-fault, and eventually causes the shutdown VM-Exit t=
o the<br>
&gt;=C2=A0 =C2=A0bluepill hypervisor right after it boots.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0In summary, this patch replaces &quot;long&quot; with &quo=
t;int64_t&quot; in order to enforce<br>
&gt;=C2=A0 =C2=A0the canonicalization with 64-bit signed integers.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Signed-off-by: Zero Tang &lt;<a href=3D"mailto:zero.tangpt=
r@gmail.com" target=3D"_blank">zero.tangptr@gmail.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:zero.tangptr@gmail.com" target=3D"_blank"=
>zero.tangptr@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 target/i386/tcg/system/svm_helper.c | 2 +-<br>
&gt;=C2=A0 =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0diff --git a/target/i386/tcg/system/svm_helper.c b/target/=
i386/tcg/ <br>
&gt; system/svm_helper.c<br>
&gt;=C2=A0 =C2=A0index b27049b9ed..1ccfccf419 100644<br>
&gt;=C2=A0 =C2=A0--- a/target/i386/tcg/system/svm_helper.c<br>
&gt;=C2=A0 =C2=A0+++ b/target/i386/tcg/system/svm_helper.c<br>
&gt;=C2=A0 =C2=A0@@ -49,7 +49,7 @@ static void svm_save_seg(CPUX86State *en=
v, int <br>
&gt; mmu_idx, hwaddr addr,<br>
&gt;=C2=A0 =C2=A0 static inline void svm_canonicalization(CPUX86State *env,=
 <br>
&gt; target_ulong *seg_base)<br>
&gt;=C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t shift_amt =3D 64 - cpu_x86_virtual=
_addr_width(env);<br>
&gt;=C2=A0 =C2=A0- =C2=A0 =C2=A0*seg_base =3D ((((long) *seg_base) &lt;&lt;=
 shift_amt) &gt;&gt; shift_amt);<br>
&gt;=C2=A0 =C2=A0+ =C2=A0 =C2=A0*seg_base =3D ((((int64_t) *seg_base) &lt;&=
lt; shift_amt) &gt;&gt; shift_amt);\<br>
<br>
Alternatively:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *seg_base =3D sextract64(*seg_base, 0, 6=
4 - <br>
cpu_x86_virtual_addr_width(env));<br>
<br>
&gt;=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 static void svm_load_seg(CPUX86State *env, int mmu_idx, h=
waddr addr,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0base-commit: e0006a86615baa70bc9d8b183e528aed91c1ac90<br>
&gt;=C2=A0 =C2=A0change-id: 20250806-fix-tcg-svm-canon-adbea9508073<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Best regards,<br>
&gt;=C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0Zero Tang &lt;<a href=3D"mailto:zero.tangptr@gmail.com" ta=
rget=3D"_blank">zero.tangptr@gmail.com</a> &lt;mailto:<a href=3D"mailto:zer=
o.tangptr@gmail.com" target=3D"_blank">zero.tangptr@gmail.com</a>&gt;&gt;<b=
r>
<br>
</blockquote></div>

--000000000000c7244e063ca59dcd--

