Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485FAD2F7E5
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 04:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1I1x-0006NL-GW; Thu, 17 Oct 2024 00:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t1I1v-0006Md-Dc; Thu, 17 Oct 2024 00:22:31 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t1I1t-0003RB-Ds; Thu, 17 Oct 2024 00:22:31 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-50d3998923dso182987e0c.2; 
 Wed, 16 Oct 2024 21:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729138948; x=1729743748; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGY0seKQQC2bxvU7af1iF9nnFN6bBhN552IzxZ0vQ0c=;
 b=jP8296uthmH6VmslJJ3fJlhpFM+bCyK7jiz0/Hsyc7ygXQtkC72zlgPgDY7zn0NNVl
 kC/fHx5fkhnIPmPaAb0/Qxzd0fl204UYTBQ7JxYeysxL/77QUx1XNBFTR302uoFP+wOk
 yygviPtr+WXnIX17DG16TuzGT+gSonDWtX5/nD/U9P5xBZ4h1BAv42XcIxaZqtoAhSZg
 /Z8BqULko7qgepk4H8vDFjywU7/yCtCq5m1dSHpflOJVTPA0m7o7LFAsa0QyB27yg8Or
 6cpUNhRvMwBNrOxSmpqMRCpbmdq9RLq9B331XXqHot51/B1r9QM/5+byXP1XVJUNGXKH
 JRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729138948; x=1729743748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGY0seKQQC2bxvU7af1iF9nnFN6bBhN552IzxZ0vQ0c=;
 b=NqqA3k7dhnYepFrXWMLO05TOO/hzv7dKLcrIIpNQAvS8eFJ5GXA8xtG3bwZBVeXG1E
 zN/iBNR0yEuU0TF5r7D6Csqi5tCQaofQCQNInWpUPgh5yHp+saApB5CTz1k9O05bvf3y
 ad/Z0fIXmyrtUeEA2ol7edQ4omDMY/VBsuOkNp9PfxUIMtTKJWTzptWhEz994q07Nkv2
 yVCx/uRS4cMsabp/ROzgJyJCUJqbx2zjj+UV3sofic8sglwXeiQP6y9kMPKnJqMxABLZ
 c12I04p51Dz9zp/PhoPqiMqi5fdJJvbosZgvFQeCG7NtyGLF0pv9t2LVQwZgFBRk7FMP
 +gFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvW5hYyqmoXvMyXNwnRVGfYPi7437XIpFoxhoek6ZZrjKdJUqAqxeNMetEdqTTH6rjn5WuPEn5WSJO@nongnu.org
X-Gm-Message-State: AOJu0Yz/2w/5WYrnzmr4cflEilKA3vLDrr1azSgw4GsRc28ZJ4TiyV/o
 anzPQ1XGBFA5bfy2YHDpvA+aDGd9RtO3Qz3iGN4wicIFZV/gPhHEPHa4Vjnurz3VGoJqDvzgs8S
 KiGt+xUGTMPobav7o/kYvcPRt8pyUvA==
X-Google-Smtp-Source: AGHT+IEKJTfMlx3kjtQPaGm8pZB/dPM9BRnuta0ZPRSGpGZamjA2vreSc9vBJcP4tkEbyESHl4T/YbkQrqpEenQck+E=
X-Received: by 2002:a05:6102:3a13:b0:4a5:ad80:a9e1 with SMTP id
 ada2fe7eead31-4a5ad80aaecmr6858186137.28.1729138947757; Wed, 16 Oct 2024
 21:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240927083508.59483-1-yanmingzhu@iscas.ac.cn>
 <CAKmqyKMobSzu-q8jdPhAU9PMG2GsGG1eOsemSS-Ny2vrX+wSbQ@mail.gmail.com>
 <52abee8d.225ee.1928a805a21.Coremail.yanmingzhu@iscas.ac.cn>
 <CAKmqyKOvgXKg+WioV2P1+Pe_DfgY1uUYs3cmMFQ8UtefPdDYKw@mail.gmail.com>
 <CAPVrrNLf449o57ZsC-T5qZeWJcQvvfOBVd+U+m60dwzvf3RBxg@mail.gmail.com>
 <CAPVrrNJTasrpMxbWFacFGQkvgf1LRyZoJpn1Z-9E-_iXmGfuyA@mail.gmail.com>
In-Reply-To: <CAPVrrNJTasrpMxbWFacFGQkvgf1LRyZoJpn1Z-9E-_iXmGfuyA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 17 Oct 2024 14:22:01 +1000
Message-ID: <CAKmqyKOEKLny_U-ugsN3zLh_m1vCtwke+DrjwK1OSPgWEU6q9Q@mail.gmail.com>
Subject: Re: Re: [PATCH] hw/char/riscv_htif: Fix htif_mm_write that causes
 infinite loop in ACT.
To: Trd thg <trdthg47@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 MingZhu Yan <yanmingzhu@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Oct 16, 2024 at 8:32=E2=80=AFPM Trd thg <trdthg47@gmail.com> wrote:
>
> Sorry about the email style, I'm not familiar with it yet

No worries! It takes some getting used to. Mostly just plain text
emails and reply inline :)

Alistair

>
> > It's probably worth including this in the commit message.
> Agree, I'll do it.
>
> > It would be good to reference the sail implementation and the
> justification for the change there
>
> Sail implementation is probably here:
> https://github.com/riscv/sail-riscv/blob/master/model/riscv_platform.sail=
#L340
> - related commit:
> https://github.com/riscv/sail-riscv/commit/848312ce7c59fa08c304cab4b4e806=
0c67d5dfc9
>
> The following is the "infinite loop" part is exported by objdump from
> the test ELF of the add instruction generated from ACT
> ```txt
> 00000000800082a0 <write_tohost>:
>     800082a0:   00001f17                auipc   t5,0x1
>     800082a4:   d61f2023                sw      ra,-672(t5) # 80009000 <t=
ohost>
>     800082a8:   ff9ff06f                j       800082a0 <write_tohost>
> ```
> QEMU cannot respond to the above `sw` behavior, It makes no
> distinction regarding the size written,
> I guess that currently qemu will only respond to the writing to the
> high 32 bits and low 32 bits of tohost twice in succession.
> I think the behavior here is very strange, and you can find
> aswaterman's description of HTIF(include RV32) at:
> https://github.com/riscv-software-src/riscv-isa-sim/issues/364#issuecomme=
nt-607657754
> So this patch try to distinguish these cases based on size and addr.
>
> About the sail impl, there are some related discussions at:
> https://github.com/riscv/sail-riscv/issues/218
> I made some summaries:
> - The implementation of sail as a workaround is not very ideal; we
> should follow the experience of spike
>   I checked the impl of spike. Although spike handles tohost in a
> syscall manner, I don't think this means that spike is better.
>   Compared to sail, it does not distinguish whether the write to
> tohost is 4 bytes or 8 bytes, but at least in act, it always works
> properly.
>   - spike code:
> https://github.com/riscv-software-src/riscv-isa-sim/blob/master/fesvr/hti=
f.cc#L265
> - HTIF has been deprecated
>   I don't know if this is true or not, because I haven't found any
> official comment.
>   However, since ACT is still using htif and is not expected to change
> for quite a long time, and no new solutions have emerged, we should go
> ahead and implement it
> - What are the advantages of QEMU supporting ACT
>   - do cross validation with sail/spike, and contributors can use ACT
> to verify the correctness when adding new instructions to QEMU. (we do
> have this need.)
>   > If you think that the benefits of supporting ACT are not obvious,
> then I think we can remove all the code related to supporting ACT
> (should be the commit mentioned above)
>
> What do you think about this? Thank you!
>
> Alistair Francis <alistair23@gmail.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=88=
16=E6=97=A5=E5=91=A8=E4=B8=89 13:27=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Oct 14, 2024 at 8:08=E2=80=AFPM =E9=98=8E=E6=98=8E=E9=93=B8 <ya=
nmingzhu@iscas.ac.cn> wrote:
> > >
> > > Thank you for your reply and I'm sorry that I didn't explain it clear=
ly.
> > >
> > > - ACT is an official riscv test suite to check the riscv support of t=
he DUT(device under test).
> >
> > It's probably worth including this in the commit message.
> >
> > > - Currently ACT support using [sail-riscv](https://github.com/riscv/s=
ail-riscv)(default) or [spike](https://github.com/riscv-software-src/riscv-=
isa-sim)
> > > - QEMU is not supported yet=EF=BC=8Cbut someone made a commit: [commi=
t](https://github.com/qemu/qemu/commit/66247edc8b6fb36d6b905babcd795068ea98=
9ad5)
> > >
> > > But there are still problems, so I'm trying to fix it. After debuggin=
g, I found that it's a htif problem, and the idea of fixing it is reference=
d from the sail-riscv implementation
> >
> > It would be good to reference the sail implementation and the
> > justification for the change there
> >
> > Alistair
> >
> > >
> > > "Alistair Francis" &lt;alistair23@gmail.com&gt;=E5=86=99=E9=81=93=EF=
=BC=9A
> > > &gt; On Fri, Sep 27, 2024 at 11:26=E2=80=AFPM MingZhu Yan <trdthg47@g=
mail.com> wrote:
> > > &gt; &gt;
> > > &gt; &gt; Applications sometimes only write the lower 32-bit payload =
bytes, this is used
> > > &gt; &gt; in ACT tests. As a workaround, this refers to the solution =
of sail-riscv.
> > > &gt;
> > > &gt; I'm not sure what ACT is, but this feels like a guest bug, not a=
 QEMU issue.
> > > &gt;
> > > &gt; Alistair
> > > &gt;
> > > &gt; &gt; if the payload is written a few times with the same value, =
we process the whole
> > > &gt; &gt; htif command anyway.
> > > &gt; &gt;
> > > &gt; &gt; Signed-off-by: MingZhu Yan <yanmingzhu@iscas.ac.cn>
> > > &gt; &gt; ---
> > > &gt; &gt;  hw/char/riscv_htif.c | 35 +++++++++++++++++++-------------=
---
> > > &gt; &gt;  1 file changed, 19 insertions(+), 16 deletions(-)
> > > &gt; &gt;
> > > &gt; &gt; diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> > > &gt; &gt; index 9bef60def1..d74cce3bef 100644
> > > &gt; &gt; --- a/hw/char/riscv_htif.c
> > > &gt; &gt; +++ b/hw/char/riscv_htif.c
> > > &gt; &gt; @@ -65,16 +65,8 @@ void htif_symbol_callback(const char *st=
_name, int st_info, uint64_t st_value,
> > > &gt; &gt;  {
> > > &gt; &gt;      if (strcmp("fromhost", st_name) =3D=3D 0) {
> > > &gt; &gt;          fromhost_addr =3D st_value;
> > > &gt; &gt; -        if (st_size !=3D 8) {
> > > &gt; &gt; -            error_report("HTIF fromhost must be 8 bytes");
> > > &gt; &gt; -            exit(1);
> > > &gt; &gt; -        }
> > > &gt; &gt;      } else if (strcmp("tohost", st_name) =3D=3D 0) {
> > > &gt; &gt;          tohost_addr =3D st_value;
> > > &gt; &gt; -        if (st_size !=3D 8) {
> > > &gt; &gt; -            error_report("HTIF tohost must be 8 bytes");
> > > &gt; &gt; -            exit(1);
> > > &gt; &gt; -        }
> > > &gt; &gt;      } else if (strcmp("begin_signature", st_name) =3D=3D 0=
) {
> > > &gt; &gt;          begin_sig_addr =3D st_value;
> > > &gt; &gt;      } else if (strcmp("end_signature", st_name) =3D=3D 0) =
{
> > > &gt; &gt; @@ -290,18 +282,26 @@ static void htif_mm_write(void *opaqu=
e, hwaddr addr,
> > > &gt; &gt;                            uint64_t value, unsigned size)
> > > &gt; &gt;  {
> > > &gt; &gt;      HTIFState *s =3D opaque;
> > > &gt; &gt; -    if (addr =3D=3D TOHOST_OFFSET1) {
> > > &gt; &gt; -        if (s-&gt;tohost =3D=3D 0x0) {
> > > &gt; &gt; -            s-&gt;allow_tohost =3D 1;
> > > &gt; &gt; -            s-&gt;tohost =3D value &amp; 0xFFFFFFFF;
> > > &gt; &gt; +    int htif_cmd_write =3D 0;
> > > &gt; &gt; +    if (size =3D=3D 8 &amp;&amp; addr =3D=3D TOHOST_OFFSET=
1) {
> > > &gt; &gt; +        htif_cmd_write =3D 1;
> > > &gt; &gt; +        s-&gt;tohost =3D value;
> > > &gt; &gt; +        htif_handle_tohost_write(s, s-&gt;tohost);
> > > &gt; &gt; +    } else if (size =3D=3D 4 &amp;&amp; addr =3D=3D TOHOST=
_OFFSET1) {
> > > &gt; &gt; +        if ((value) =3D=3D (s-&gt;tohost &amp; 0xFFFF)) {
> > > &gt; &gt; +            s-&gt;allow_tohost =3D s-&gt;allow_tohost + 1;
> > > &gt; &gt;          } else {
> > > &gt; &gt;              s-&gt;allow_tohost =3D 0;
> > > &gt; &gt;          }
> > > &gt; &gt; -    } else if (addr =3D=3D TOHOST_OFFSET2) {
> > > &gt; &gt; -        if (s-&gt;allow_tohost) {
> > > &gt; &gt; -            s-&gt;tohost |=3D value &lt;&lt; 32;
> > > &gt; &gt; -            htif_handle_tohost_write(s, s-&gt;tohost);
> > > &gt; &gt; +        s-&gt;tohost =3D deposit64(s-&gt;tohost, 0, 32, va=
lue);
> > > &gt; &gt; +    } else if (size =3D=3D 4 &amp;&amp; addr =3D=3D TOHOST=
_OFFSET2) {
> > > &gt; &gt; +        if ((value &amp; 0xFF) =3D=3D (s-&gt;tohost &amp; =
0xFF00)) {
> > > &gt; &gt; +            s-&gt;allow_tohost =3D s-&gt;allow_tohost + 1;
> > > &gt; &gt; +        } else {
> > > &gt; &gt; +            s-&gt;allow_tohost =3D 1;
> > > &gt; &gt;          }
> > > &gt; &gt; +        htif_cmd_write =3D 1;
> > > &gt; &gt; +        s-&gt;tohost =3D deposit64(s-&gt;tohost, 32, 32, v=
alue);
> > > &gt; &gt;      } else if (addr =3D=3D FROMHOST_OFFSET1) {
> > > &gt; &gt;          s-&gt;fromhost_inprogress =3D 1;
> > > &gt; &gt;          s-&gt;fromhost =3D value &amp; 0xFFFFFFFF;
> > > &gt; &gt; @@ -312,6 +312,9 @@ static void htif_mm_write(void *opaque,=
 hwaddr addr,
> > > &gt; &gt;          qemu_log("Invalid htif write: address %016" PRIx64=
 "\n",
> > > &gt; &gt;              (uint64_t)addr);
> > > &gt; &gt;      }
> > > &gt; &gt; +    if ((s-&gt;tohost =3D=3D 1 &amp;&amp; htif_cmd_write) =
|| s-&gt;allow_tohost &gt; 2) {
> > > &gt; &gt; +        htif_handle_tohost_write(s, s-&gt;tohost);
> > > &gt; &gt; +    }
> > > &gt; &gt;  }
> > > &gt; &gt;
> > > &gt; &gt;  static const MemoryRegionOps htif_mm_ops =3D {
> > > &gt; &gt; --
> > > &gt; &gt; 2.34.1
> > > &gt; &gt;
> > > &gt; &gt;
> > > </yanmingzhu@iscas.ac.cn></trdthg47@gmail.com>

