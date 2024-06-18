Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A09BC2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 19:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJeEs-00012Y-Dq; Tue, 18 Jun 2024 15:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJeEo-0000zz-Rt; Tue, 18 Jun 2024 15:11:27 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJeEk-0005nN-HB; Tue, 18 Jun 2024 15:11:26 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6f85f82ffeso320212566b.0; 
 Tue, 18 Jun 2024 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718737879; x=1719342679; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kx3MasQzPb0i82/yoR6WHGybnQWXWbY2d4zz4Ldo0pw=;
 b=M/ulSpQ74Toac4kOq1DFXLkq7/+e7MYN1NYC7GeQnOlrjW+/23F56GkfbT55ezMgYY
 8AXw5z76vLkpl9OY+XQBtG7Ti8cN8MSnZ+Ulz0kL66fVJBXlkCtzKy2uPqCnSzjwVLV9
 2fm425kTd4OT75Q/qgcmBEZVEB91GCEGiaUpyPNSyZcH9HWRQkzFhVlhWPzveTfYc8VX
 IKSemquUKEILJwHEn7qE1VZqRRPipkHkNWdM8CDLL8rw0LV3vZtviQ6g5QJyJs/NKbcA
 1O8NDtaA/3KmrtUpsdIySeNOvn21CaMcLaW5YFwgD/uO6UCwe+VxJntW7wQsdIDDSOM5
 gA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718737879; x=1719342679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kx3MasQzPb0i82/yoR6WHGybnQWXWbY2d4zz4Ldo0pw=;
 b=WTor0/ByaJLM/Pdyh4uf0ovZ/WdA++sWOwPNQsgMXM9gWsllaRdlSYjuoRV5+gINd1
 LvWczUqBqSI2RqWvHB1Oo9hJJPLuEw3EYuiJwmSesA+HyLajJvV/rQgOhfvSA5IZODE+
 b1tLQLGRDFReB6cnnUGXZoIoxeFqfQK/ceJgyPbuJVVHC4ILC5pb6T/Sr2NGGIZPK2xt
 bu/bQOzDM7lQ1W1vXI8+fIpZck/Xq5upsZc9ZK62+7+LsIRrTUHQJMO+P1k1onudVmps
 CqIm8tGjr3zG4DE7fHTKtVOndiUKftXQb1fDt9f8Y1zUxZIai9TVt9h4g/qDN+0seICS
 WRYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCyrM3ubboxOrmTO9i/gGGziwCd0vG20FNrYFGgty8mW0ZbF+CGgw0w85cYW1XoVa6Tbq0OlcrffnJmNHN7YqyIErtBvmyTvreudgsA55lMAKT14I/g4P11Ei8qA==
X-Gm-Message-State: AOJu0YzsXSqfVTa+dpaMQy+vThUq8lKYZGjNn1JJSZKul23xOjRUE8vs
 IXDJq8J3h3per+M+g7SniNuXRZ4aS+zVCHWJCswfsi86DqvkTFC+fC8xSd4Qxa1bwu85cNwQwJW
 fxp2uxLKTYjBpZLoWymubR1anx6ecFuYOGFYB
X-Google-Smtp-Source: AGHT+IE5OYb5q0VLDBRhRcR7+GUr6+fK3CnZwRKgNtWR6pfb0Go3oAA4gdeYers9cu3hR0pc0ri12RJx+ppV7KvfGS4=
X-Received: by 2002:a17:907:cc1f:b0:a6f:5ef5:2f63 with SMTP id
 a640c23a62f3a-a6fab6171fcmr20299966b.18.1718737878907; Tue, 18 Jun 2024
 12:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240618152328.3163680-1-zheyuma97@gmail.com>
 <896bbf08-7a3d-4a2c-b7f7-b260073255cb@linaro.org>
In-Reply-To: <896bbf08-7a3d-4a2c-b7f7-b260073255cb@linaro.org>
From: Zheyu Ma <zheyuma97@gmail.com>
Date: Tue, 18 Jun 2024 21:11:07 +0200
Message-ID: <CAMhUBjmpYLFuRfsHACUjGvwfydEU7R89AEWToLAyo-0kQ-B41A@mail.gmail.com>
Subject: Re: [PATCH] block: m25p80: Fix heap-buffer-overflow in flash_erase
 function
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bc1489061b2ed8ff"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=zheyuma97@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000bc1489061b2ed8ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your useful advice!

So how about report the issue and return:

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 8dec134832..2121b43708 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -617,6 +617,12 @@ static void flash_erase(Flash *s, int offset, FlashCMD
cmd)
         abort();
     }

+    if (offset + len > s->size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "M25P80: Erase operation exceeds storage size\n");
+        return;
+    }
+
     trace_m25p80_flash_erase(s, offset, len);

     if ((s->pi->flags & capa_to_assert) !=3D capa_to_assert) {

regards,
Zheyu

On Tue, Jun 18, 2024 at 5:35=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Zheyu,
>
> On 18/6/24 17:23, Zheyu Ma wrote:
> > This patch fixes a heap-buffer-overflow issue in the flash_erase functi=
on
> > of the m25p80 flash memory emulation. The overflow occurs when the
> > combination of offset and length exceeds the allocated memory for the
> > storage. The patch adds a check to ensure that the erase length does no=
t
> > exceed the storage size and adjusts the length accordingly if necessary=
.
> >
> > Reproducer:
> > cat << EOF | qemu-system-aarch64 -display none \
> > -machine accel=3Dqtest, -m 512M -machine kudo-bmc -qtest stdio
> > writeq 0xc0000010 0x6
> > writel 0xc000000c 0x9
> > writeq 0xc0000010 0xf27f9412
> > writeq 0xc000000f 0x2b5cdc26
> > writeq 0xc000000c 0xffffffffffffffff
> > writeq 0xc000000c 0xffffffffffffffff
> > writeq 0xc000000c 0xffffffffffffffff
> > writel 0xc000000c 0x9
> > writeq 0xc000000c 0x9
> > EOF
> >
> > ASan log:
> > =3D=3D2614308=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on add=
ress
> 0x7fd3fb7fc000 at pc 0x55aa77a442dc bp 0x7fffaa155900 sp 0x7fffaa1550c8
> > WRITE of size 65536 at 0x7fd3fb7fc000 thread T0
> >      #0 0x55aa77a442db in __asan_memset
> llvm/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cpp:26:3
> >      #1 0x55aa77e7e6b3 in flash_erase hw/block/m25p80.c:631:5
> >      #2 0x55aa77e6f8b1 in complete_collecting_data
> hw/block/m25p80.c:773:9
> >      #3 0x55aa77e6aaa9 in m25p80_transfer8 hw/block/m25p80.c:1550:13
> >      #4 0x55aa78e9a691 in ssi_transfer_raw_default hw/ssi/ssi.c:92:16
> >      #5 0x55aa78e996c0 in ssi_transfer hw/ssi/ssi.c:165:14
> >      #6 0x55aa78e8d76a in npcm7xx_fiu_uma_transaction
> hw/ssi/npcm7xx_fiu.c:336:9
> >      #7 0x55aa78e8be4b in npcm7xx_fiu_ctrl_write
> hw/ssi/npcm7xx_fiu.c:428:13
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >   hw/block/m25p80.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> > index 8dec134832..e9a59f6616 100644
> > --- a/hw/block/m25p80.c
> > +++ b/hw/block/m25p80.c
> > @@ -617,6 +617,12 @@ static void flash_erase(Flash *s, int offset,
> FlashCMD cmd)
> >           abort();
> >       }
> >
> > +    if (offset + len > s->size) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "M25P80: Erase exceeds storage size, adjusting
> length\n");
>
> Usually hardware doesn't "adjust" but report error earlier.
>
> > +        len =3D s->size - offset;
> > +    }
> > +
> >       trace_m25p80_flash_erase(s, offset, len);
> >
> >       if ((s->pi->flags & capa_to_assert) !=3D capa_to_assert) {
>
>

--000000000000bc1489061b2ed8ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thanks for your useful advice!<br><br><di=
v>So how about report the issue and return:<br><br>diff --git a/hw/block/m2=
5p80.c b/hw/block/m25p80.c<br>index 8dec134832..2121b43708 100644<span clas=
s=3D"gmail-im" style=3D"color:rgb(80,0,80)"><br>--- a/hw/block/m25p80.c<br>=
+++ b/hw/block/m25p80.c<br>@@ -617,6 +617,12 @@ static void flash_erase(Fla=
sh *s, int offset, FlashCMD cmd)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abort=
();<br>=C2=A0 =C2=A0 =C2=A0}<br><br>+ =C2=A0 =C2=A0if (offset + len &gt; s-=
&gt;size) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERROR,<=
br></span>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&quot;M25P80: Erase operation exceeds storage size\n&quot;);<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<span class=3D"gmail-im" style=3D"col=
or:rgb(80,0,80)"><br>+ =C2=A0 =C2=A0}<br>+<br>=C2=A0 =C2=A0 =C2=A0trace_m25=
p80_flash_erase(s, offset, len);<br><br>=C2=A0 =C2=A0 =C2=A0if ((s-&gt;pi-&=
gt;flags &amp; capa_to_assert) !=3D capa_to_assert) {<br><br></span>regards=
,<br>Zheyu</div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, Jun 18, 2024 at 5:35=E2=80=AFPM Philippe Math=
ieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi=
 Zheyu,<br>
<br>
On 18/6/24 17:23, Zheyu Ma wrote:<br>
&gt; This patch fixes a heap-buffer-overflow issue in the flash_erase funct=
ion<br>
&gt; of the m25p80 flash memory emulation. The overflow occurs when the<br>
&gt; combination of offset and length exceeds the allocated memory for the<=
br>
&gt; storage. The patch adds a check to ensure that the erase length does n=
ot<br>
&gt; exceed the storage size and adjusts the length accordingly if necessar=
y.<br>
&gt; <br>
&gt; Reproducer:<br>
&gt; cat &lt;&lt; EOF | qemu-system-aarch64 -display none \<br>
&gt; -machine accel=3Dqtest, -m 512M -machine kudo-bmc -qtest stdio<br>
&gt; writeq 0xc0000010 0x6<br>
&gt; writel 0xc000000c 0x9<br>
&gt; writeq 0xc0000010 0xf27f9412<br>
&gt; writeq 0xc000000f 0x2b5cdc26<br>
&gt; writeq 0xc000000c 0xffffffffffffffff<br>
&gt; writeq 0xc000000c 0xffffffffffffffff<br>
&gt; writeq 0xc000000c 0xffffffffffffffff<br>
&gt; writel 0xc000000c 0x9<br>
&gt; writeq 0xc000000c 0x9<br>
&gt; EOF<br>
&gt; <br>
&gt; ASan log:<br>
&gt; =3D=3D2614308=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on ad=
dress 0x7fd3fb7fc000 at pc 0x55aa77a442dc bp 0x7fffaa155900 sp 0x7fffaa1550=
c8<br>
&gt; WRITE of size 65536 at 0x7fd3fb7fc000 thread T0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #0 0x55aa77a442db in __asan_memset llvm/compiler-r=
t/lib/asan/asan_interceptors_memintrinsics.cpp:26:3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #1 0x55aa77e7e6b3 in flash_erase hw/block/m25p80.c=
:631:5<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #2 0x55aa77e6f8b1 in complete_collecting_data hw/b=
lock/m25p80.c:773:9<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #3 0x55aa77e6aaa9 in m25p80_transfer8 hw/block/m25=
p80.c:1550:13<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #4 0x55aa78e9a691 in ssi_transfer_raw_default hw/s=
si/ssi.c:92:16<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #5 0x55aa78e996c0 in ssi_transfer hw/ssi/ssi.c:165=
:14<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #6 0x55aa78e8d76a in npcm7xx_fiu_uma_transaction h=
w/ssi/npcm7xx_fiu.c:336:9<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #7 0x55aa78e8be4b in npcm7xx_fiu_ctrl_write hw/ssi=
/npcm7xx_fiu.c:428:13<br>
&gt; <br>
&gt; Signed-off-by: Zheyu Ma &lt;<a href=3D"mailto:zheyuma97@gmail.com" tar=
get=3D"_blank">zheyuma97@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/block/m25p80.c | 6 ++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 6 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c<br>
&gt; index 8dec134832..e9a59f6616 100644<br>
&gt; --- a/hw/block/m25p80.c<br>
&gt; +++ b/hw/block/m25p80.c<br>
&gt; @@ -617,6 +617,12 @@ static void flash_erase(Flash *s, int offset, Fla=
shCMD cmd)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abort();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 if (offset + len &gt; s-&gt;size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;M25P80: Erase exceeds storage size, adjusting length\n&quot;)=
;<br>
<br>
Usually hardware doesn&#39;t &quot;adjust&quot; but report error earlier.<b=
r>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D s-&gt;size - offset;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_m25p80_flash_erase(s, offset, len);<br=
>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;pi-&gt;flags &amp; capa_to_assert=
) !=3D capa_to_assert) {<br>
<br>
</blockquote></div>

--000000000000bc1489061b2ed8ff--

