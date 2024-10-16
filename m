Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C50D1AD42
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 10:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t11Kd-0000lb-Vi; Wed, 16 Oct 2024 06:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trdthg47@gmail.com>)
 id 1t11Kb-0000kt-ES; Wed, 16 Oct 2024 06:32:41 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trdthg47@gmail.com>)
 id 1t11KZ-0004tT-G4; Wed, 16 Oct 2024 06:32:41 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e290200a560so5666520276.1; 
 Wed, 16 Oct 2024 03:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729074758; x=1729679558; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cF+emqqZwA8vU2jqnm2vx8kuQeFg0waOSmcB6zO3L8=;
 b=l28/w4qMJyd7HF/iaweRVAbVhit0EfVVVxHkE4/e3C+91jgKxBMvy/rn1GtrqfxCGd
 AvX8l4P7Jm37x/uJffPx1HZ2O2VhjCukWW4j4Y8hl8Fa2gd3iLs059aUNg+lBYgUKUdh
 VqQPnSVDklDDAbIpBkQElogSK1AuLPAMj+xT1LtZnDpC3Wi8gTivAO4NJyi7yLcge0SQ
 AyO8t+q6SNWn/qVJ2KeOvv6HaVi/+FbmrwBGm7QQ2DL5a+akDkhbU9cvdhs2OW3Ff5Dm
 G1X24mnucmRME/wxPZ3i4xfNrY3taDUSNw82l0ukTnYg/jmH7WF03cM6Xy40nolm9aWK
 Qydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729074758; x=1729679558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6cF+emqqZwA8vU2jqnm2vx8kuQeFg0waOSmcB6zO3L8=;
 b=cN/qShiwLc4oxeTvypqhzeLtnZ+OthyQDGOiel/7w581ZkkRaRsse464OmMUA8yoLB
 8D0Gl8l3nP/TBq6iAsjwOsvGMfZTeVgf05fml4zQZ9KTqaZ5XfxrppJWvaEXhgFHLgdS
 vuXHeWsPK51rguFek56ageGjtM4V0udQ5jRjaFCt+2BMy3ShjnmXlfix0LvvVJFAdHky
 eoAE0P37rRv6oIW7BIOvTImPTOnATHqO1/Rhg7N2DzFl9EV2AUvl0Q8lxLjQAU0LZENX
 yTB7c6NHcQkOMlKoHdZsJ5TbTLU42rpsBs1tHbEYt5BlRvkoOcH+4/fXZ0kSVL4SbjoQ
 pEpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8tyl6jsopbdxoiwc2iqaBcu6w0gSXOs9RLs/XrvP1lB05clHatjnCOZBjlQ1P6WYebYoWtFYkWqik@nongnu.org
X-Gm-Message-State: AOJu0YxTURwJxL65RdGOpR55R/2Cvcu6EutyhEjSzZe1bBFsbB+Xqict
 N8SqgmPAhh2YYr302Pnkmrpj493gDJOvuw2/iBPqCpUnVwb94gM0bI2wB55x7EYdj0hnJxjpZCl
 GJRSDSLOLNbx6iN/8I5flaEo7lkk=
X-Google-Smtp-Source: AGHT+IERYO1ZRkxjCcNXy/GwxjeUikhzP7sOm7RS9fqpI8aJjRDZuPIagpIt/j1i+oOhErMUtfaqvxBd8RXh5Km1xPA=
X-Received: by 2002:a05:6902:1105:b0:e28:f8e6:f74c with SMTP id
 3f1490d57ef6-e2931b53f8fmr9428350276.29.1729074757628; Wed, 16 Oct 2024
 03:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240927083508.59483-1-yanmingzhu@iscas.ac.cn>
 <CAKmqyKMobSzu-q8jdPhAU9PMG2GsGG1eOsemSS-Ny2vrX+wSbQ@mail.gmail.com>
 <52abee8d.225ee.1928a805a21.Coremail.yanmingzhu@iscas.ac.cn>
 <CAKmqyKOvgXKg+WioV2P1+Pe_DfgY1uUYs3cmMFQ8UtefPdDYKw@mail.gmail.com>
 <CAPVrrNLf449o57ZsC-T5qZeWJcQvvfOBVd+U+m60dwzvf3RBxg@mail.gmail.com>
In-Reply-To: <CAPVrrNLf449o57ZsC-T5qZeWJcQvvfOBVd+U+m60dwzvf3RBxg@mail.gmail.com>
From: Trd thg <trdthg47@gmail.com>
Date: Wed, 16 Oct 2024 18:32:27 +0800
Message-ID: <CAPVrrNJTasrpMxbWFacFGQkvgf1LRyZoJpn1Z-9E-_iXmGfuyA@mail.gmail.com>
Subject: Fwd: Re: [PATCH] hw/char/riscv_htif: Fix htif_mm_write that causes
 infinite loop in ACT.
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 MingZhu Yan <yanmingzhu@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=trdthg47@gmail.com; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1,
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

Sorry about the email style, I'm not familiar with it yet

> It's probably worth including this in the commit message.
Agree, I'll do it.

> It would be good to reference the sail implementation and the
justification for the change there

Sail implementation is probably here:
https://github.com/riscv/sail-riscv/blob/master/model/riscv_platform.sail#L=
340
- related commit:
https://github.com/riscv/sail-riscv/commit/848312ce7c59fa08c304cab4b4e8060c=
67d5dfc9

The following is the "infinite loop" part is exported by objdump from
the test ELF of the add instruction generated from ACT
```txt
00000000800082a0 <write_tohost>:
    800082a0:   00001f17                auipc   t5,0x1
    800082a4:   d61f2023                sw      ra,-672(t5) # 80009000 <toh=
ost>
    800082a8:   ff9ff06f                j       800082a0 <write_tohost>
```
QEMU cannot respond to the above `sw` behavior, It makes no
distinction regarding the size written,
I guess that currently qemu will only respond to the writing to the
high 32 bits and low 32 bits of tohost twice in succession.
I think the behavior here is very strange, and you can find
aswaterman's description of HTIF(include RV32) at:
https://github.com/riscv-software-src/riscv-isa-sim/issues/364#issuecomment=
-607657754
So this patch try to distinguish these cases based on size and addr.

About the sail impl, there are some related discussions at:
https://github.com/riscv/sail-riscv/issues/218
I made some summaries:
- The implementation of sail as a workaround is not very ideal; we
should follow the experience of spike
  I checked the impl of spike. Although spike handles tohost in a
syscall manner, I don't think this means that spike is better.
  Compared to sail, it does not distinguish whether the write to
tohost is 4 bytes or 8 bytes, but at least in act, it always works
properly.
  - spike code:
https://github.com/riscv-software-src/riscv-isa-sim/blob/master/fesvr/htif.=
cc#L265
- HTIF has been deprecated
  I don't know if this is true or not, because I haven't found any
official comment.
  However, since ACT is still using htif and is not expected to change
for quite a long time, and no new solutions have emerged, we should go
ahead and implement it
- What are the advantages of QEMU supporting ACT
  - do cross validation with sail/spike, and contributors can use ACT
to verify the correctness when adding new instructions to QEMU. (we do
have this need.)
  > If you think that the benefits of supporting ACT are not obvious,
then I think we can remove all the code related to supporting ACT
(should be the commit mentioned above)

What do you think about this? Thank you!

Alistair Francis <alistair23@gmail.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=8816=
=E6=97=A5=E5=91=A8=E4=B8=89 13:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Oct 14, 2024 at 8:08=E2=80=AFPM =E9=98=8E=E6=98=8E=E9=93=B8 <yanm=
ingzhu@iscas.ac.cn> wrote:
> >
> > Thank you for your reply and I'm sorry that I didn't explain it clearly=
.
> >
> > - ACT is an official riscv test suite to check the riscv support of the=
 DUT(device under test).
>
> It's probably worth including this in the commit message.
>
> > - Currently ACT support using [sail-riscv](https://github.com/riscv/sai=
l-riscv)(default) or [spike](https://github.com/riscv-software-src/riscv-is=
a-sim)
> > - QEMU is not supported yet=EF=BC=8Cbut someone made a commit: [commit]=
(https://github.com/qemu/qemu/commit/66247edc8b6fb36d6b905babcd795068ea989a=
d5)
> >
> > But there are still problems, so I'm trying to fix it. After debugging,=
 I found that it's a htif problem, and the idea of fixing it is referenced =
from the sail-riscv implementation
>
> It would be good to reference the sail implementation and the
> justification for the change there
>
> Alistair
>
> >
> > "Alistair Francis" &lt;alistair23@gmail.com&gt;=E5=86=99=E9=81=93=EF=BC=
=9A
> > &gt; On Fri, Sep 27, 2024 at 11:26=E2=80=AFPM MingZhu Yan <trdthg47@gma=
il.com> wrote:
> > &gt; &gt;
> > &gt; &gt; Applications sometimes only write the lower 32-bit payload by=
tes, this is used
> > &gt; &gt; in ACT tests. As a workaround, this refers to the solution of=
 sail-riscv.
> > &gt;
> > &gt; I'm not sure what ACT is, but this feels like a guest bug, not a Q=
EMU issue.
> > &gt;
> > &gt; Alistair
> > &gt;
> > &gt; &gt; if the payload is written a few times with the same value, we=
 process the whole
> > &gt; &gt; htif command anyway.
> > &gt; &gt;
> > &gt; &gt; Signed-off-by: MingZhu Yan <yanmingzhu@iscas.ac.cn>
> > &gt; &gt; ---
> > &gt; &gt;  hw/char/riscv_htif.c | 35 +++++++++++++++++++---------------=
-
> > &gt; &gt;  1 file changed, 19 insertions(+), 16 deletions(-)
> > &gt; &gt;
> > &gt; &gt; diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> > &gt; &gt; index 9bef60def1..d74cce3bef 100644
> > &gt; &gt; --- a/hw/char/riscv_htif.c
> > &gt; &gt; +++ b/hw/char/riscv_htif.c
> > &gt; &gt; @@ -65,16 +65,8 @@ void htif_symbol_callback(const char *st_n=
ame, int st_info, uint64_t st_value,
> > &gt; &gt;  {
> > &gt; &gt;      if (strcmp("fromhost", st_name) =3D=3D 0) {
> > &gt; &gt;          fromhost_addr =3D st_value;
> > &gt; &gt; -        if (st_size !=3D 8) {
> > &gt; &gt; -            error_report("HTIF fromhost must be 8 bytes");
> > &gt; &gt; -            exit(1);
> > &gt; &gt; -        }
> > &gt; &gt;      } else if (strcmp("tohost", st_name) =3D=3D 0) {
> > &gt; &gt;          tohost_addr =3D st_value;
> > &gt; &gt; -        if (st_size !=3D 8) {
> > &gt; &gt; -            error_report("HTIF tohost must be 8 bytes");
> > &gt; &gt; -            exit(1);
> > &gt; &gt; -        }
> > &gt; &gt;      } else if (strcmp("begin_signature", st_name) =3D=3D 0) =
{
> > &gt; &gt;          begin_sig_addr =3D st_value;
> > &gt; &gt;      } else if (strcmp("end_signature", st_name) =3D=3D 0) {
> > &gt; &gt; @@ -290,18 +282,26 @@ static void htif_mm_write(void *opaque,=
 hwaddr addr,
> > &gt; &gt;                            uint64_t value, unsigned size)
> > &gt; &gt;  {
> > &gt; &gt;      HTIFState *s =3D opaque;
> > &gt; &gt; -    if (addr =3D=3D TOHOST_OFFSET1) {
> > &gt; &gt; -        if (s-&gt;tohost =3D=3D 0x0) {
> > &gt; &gt; -            s-&gt;allow_tohost =3D 1;
> > &gt; &gt; -            s-&gt;tohost =3D value &amp; 0xFFFFFFFF;
> > &gt; &gt; +    int htif_cmd_write =3D 0;
> > &gt; &gt; +    if (size =3D=3D 8 &amp;&amp; addr =3D=3D TOHOST_OFFSET1)=
 {
> > &gt; &gt; +        htif_cmd_write =3D 1;
> > &gt; &gt; +        s-&gt;tohost =3D value;
> > &gt; &gt; +        htif_handle_tohost_write(s, s-&gt;tohost);
> > &gt; &gt; +    } else if (size =3D=3D 4 &amp;&amp; addr =3D=3D TOHOST_O=
FFSET1) {
> > &gt; &gt; +        if ((value) =3D=3D (s-&gt;tohost &amp; 0xFFFF)) {
> > &gt; &gt; +            s-&gt;allow_tohost =3D s-&gt;allow_tohost + 1;
> > &gt; &gt;          } else {
> > &gt; &gt;              s-&gt;allow_tohost =3D 0;
> > &gt; &gt;          }
> > &gt; &gt; -    } else if (addr =3D=3D TOHOST_OFFSET2) {
> > &gt; &gt; -        if (s-&gt;allow_tohost) {
> > &gt; &gt; -            s-&gt;tohost |=3D value &lt;&lt; 32;
> > &gt; &gt; -            htif_handle_tohost_write(s, s-&gt;tohost);
> > &gt; &gt; +        s-&gt;tohost =3D deposit64(s-&gt;tohost, 0, 32, valu=
e);
> > &gt; &gt; +    } else if (size =3D=3D 4 &amp;&amp; addr =3D=3D TOHOST_O=
FFSET2) {
> > &gt; &gt; +        if ((value &amp; 0xFF) =3D=3D (s-&gt;tohost &amp; 0x=
FF00)) {
> > &gt; &gt; +            s-&gt;allow_tohost =3D s-&gt;allow_tohost + 1;
> > &gt; &gt; +        } else {
> > &gt; &gt; +            s-&gt;allow_tohost =3D 1;
> > &gt; &gt;          }
> > &gt; &gt; +        htif_cmd_write =3D 1;
> > &gt; &gt; +        s-&gt;tohost =3D deposit64(s-&gt;tohost, 32, 32, val=
ue);
> > &gt; &gt;      } else if (addr =3D=3D FROMHOST_OFFSET1) {
> > &gt; &gt;          s-&gt;fromhost_inprogress =3D 1;
> > &gt; &gt;          s-&gt;fromhost =3D value &amp; 0xFFFFFFFF;
> > &gt; &gt; @@ -312,6 +312,9 @@ static void htif_mm_write(void *opaque, h=
waddr addr,
> > &gt; &gt;          qemu_log("Invalid htif write: address %016" PRIx64 "=
\n",
> > &gt; &gt;              (uint64_t)addr);
> > &gt; &gt;      }
> > &gt; &gt; +    if ((s-&gt;tohost =3D=3D 1 &amp;&amp; htif_cmd_write) ||=
 s-&gt;allow_tohost &gt; 2) {
> > &gt; &gt; +        htif_handle_tohost_write(s, s-&gt;tohost);
> > &gt; &gt; +    }
> > &gt; &gt;  }
> > &gt; &gt;
> > &gt; &gt;  static const MemoryRegionOps htif_mm_ops =3D {
> > &gt; &gt; --
> > &gt; &gt; 2.34.1
> > &gt; &gt;
> > &gt; &gt;
> > </yanmingzhu@iscas.ac.cn></trdthg47@gmail.com>

