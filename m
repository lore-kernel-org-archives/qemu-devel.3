Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BCAC87FCC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 03:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf8fa-0006Yi-Mj; Thu, 24 Jul 2025 23:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1uf8fQ-0006TK-VE
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 23:00:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1uf8fM-0008EO-J6
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 23:00:16 -0400
Received: from loongson.cn (unknown [209.85.219.176])
 by gateway (Coremail) with SMTP id _____8DxbKw084JompkxAQ--.35187S3;
 Fri, 25 Jul 2025 11:00:05 +0800 (CST)
Received: from mail-yb1-f176.google.com (unknown [209.85.219.176])
 by front1 (Coremail) with SMTP id qMiowJDx_8My84JoE7QlAA--.62163S3;
 Fri, 25 Jul 2025 11:00:03 +0800 (CST)
Received: by mail-yb1-f176.google.com with SMTP id
 3f1490d57ef6-e8dbe824ee8so1532698276.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 20:00:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXzNv7WpxhJZg8P2GsM1xpFA4MmqBZfGCaoDjKmSWDD+FvJVUmjv511BlGWhsVuBLIJQ/uDrZs1i1tw@nongnu.org
X-Gm-Message-State: AOJu0Yy0fhu1oFHmY11dBa7oBUKGg5874nMSOlfXmwn/KbSYqcOSAOte
 qbrnaNATagx7zOG8alv7lZnEQvfbXmtR6OqSxlhEpj9uYhBQwH4eSMOAde3LGp0TMpj1m/Q5nmX
 rIuEq/cyFJ9lMbUETKh1BkgQiGsfkavlLwOi1vUIk/w==
X-Google-Smtp-Source: AGHT+IEe0eG9Jxl+V0ECW81MAMSLRGrRWPLe+QrbANXaxsZP1BAUUVMjpzupkcWYLdYpweAPOB+wrQqv7tBXvHRCxr8=
X-Received: by 2002:a05:6902:1244:b0:e89:8a7b:5b14 with SMTP id
 3f1490d57ef6-e8df123d900mr154216276.47.1753412401100; Thu, 24 Jul 2025
 20:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250724072004.8047-1-wangrui@loongson.cn>
 <e5f43ac9-46cd-fb5b-7be9-e6c72021f3cc@loongson.cn>
In-Reply-To: <e5f43ac9-46cd-fb5b-7be9-e6c72021f3cc@loongson.cn>
From: WANG Rui <wangrui@loongson.cn>
Date: Fri, 25 Jul 2025 10:59:49 +0800
X-Gmail-Original-Message-ID: <CAHirt9jYUt5=C4L6nj+jACUtBY33+2ujF=fYtbtVFz4CuE5--w@mail.gmail.com>
X-Gm-Features: Ac12FXzfrzCCBl-ypf1B8Qf5O-7FUdrMg50UjU-RuAJHz_ySIz94XE8dUXkAz9Q
Message-ID: <CAHirt9jYUt5=C4L6nj+jACUtBY33+2ujF=fYtbtVFz4CuE5--w@mail.gmail.com>
Subject: Re: [PATCH v5] target/loongarch: Guard 64-bit-only insn translation
 with TRANS64 macro
To: Bibo Mao <maobibo@loongson.cn>
Cc: Gao Song <gaosong@loongson.cn>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 richard.henderson@linaro.org, qemu@hev.cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: qMiowJDx_8My84JoE7QlAA--.62163S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfJr43ury3Gry7urW3ArW3XFc_yoW8CFWfAo
 W8XF48tr1xJwnxuFZ0kryvq34jvr1Iva98A3y7Cw1UWF95XF1j934fCw1vva13ZrWDGFyU
 Wr4Ikan8Ja1fZwnxl-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUY47kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
 14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
 I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2
 jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CP
 fJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=wangrui@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Bibo,

On Fri, Jul 25, 2025 at 10:12=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Hi Rui,
>
> Here there is still checking with LSX 128bit/LASX 256bit. There is no
> conclusion that whether and how 128bit/256bit vector should be supported
> on 32-bit hardware system.
>
> I insist on that modification with LSX/LASX should be removed here, we
> can talk about this when real 32-bit hardware with LSX/LASX comes out.

If removing the vector part can help move the patch forward, I'm
willing to make that effort. It's another step toward a more accurate
simulation.

I'd also like to reiterate that allowing 64-bit wide data transfers
between general-purpose registers only on 64-bit architectures is
reasonable. This is also mandated by the LoongArch Reference Manual,
Volume II, which states:

Whether LSX or LASX is implemented is independent of whether the
architecture is LA32 or LA64. Except for a few instructions that
perform 64-bit wide data transfers between general-purpose and vector
registers, which are only required on LA64, all other vector extension
instructions can be implemented on either LA32- or LA64-based
processors.

Regards,
Rui

>
> BTW do you think when the 32-bit hardware with LSX/LASX will come out?
> one year later or two years...
>
> Regards
> Bibo Mao
>
> On 2025/7/24 =E4=B8=8B=E5=8D=883:20, WANG Rui wrote:
> > This patch replaces uses of the generic TRANS macro with TRANS64 for
> > instructions that are only valid when 64-bit support is available.
> >
> > This improves correctness and avoids potential assertion failures or
> > undefined behavior during translation on 32-bit-only configurations.
> >
> > Signed-off-by: WANG Rui <wangrui@loongson.cn>
> > ---
> > v4 -> v5:
> > - Add the instructions MOVGR2FR.D, MOVFR2GR.D, FSCALEB.S/D, FLOGB.S/D, =
FRINT.S/D,
> >    FRECIPE.S/D, FRSQRTE.S/D, FLD{GT/LE}.{S/D}, and FST{GT/LE}.{S/D}.
> > ---
> >   .../tcg/insn_trans/trans_atomic.c.inc         | 36 +++++++++---------=
-
> >   .../tcg/insn_trans/trans_extra.c.inc          |  8 +++--
> >   .../tcg/insn_trans/trans_farith.c.inc         |  8 ++---
> >   .../loongarch/tcg/insn_trans/trans_fcnv.c.inc |  4 +--
> >   .../tcg/insn_trans/trans_fmemory.c.inc        | 16 ++++-----
> >   .../tcg/insn_trans/trans_privileged.c.inc     |  4 +--
> >   .../tcg/insn_trans/trans_shift.c.inc          |  4 +--
> >   .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++++-----
> >   target/loongarch/translate.h                  |  4 +++
> >   9 files changed, 54 insertions(+), 46 deletions(-)
> >
> > diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/targe=
t/loongarch/tcg/insn_trans/trans_atomic.c.inc
> > index 3d70d75941..77eeedbc42 100644
> > --- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> > +++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> > @@ -74,38 +74,38 @@ TRANS(sc_w, ALL, gen_sc, MO_TESL)
> >   TRANS(ll_d, 64, gen_ll, MO_TEUQ)
> >   TRANS(sc_d, 64, gen_sc, MO_TEUQ)
> >   TRANS(amswap_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
> > -TRANS(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
> > +TRANS64(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
> >   TRANS(amadd_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
> > -TRANS(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
> > +TRANS64(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
> >   TRANS(amand_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
> > -TRANS(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
> > +TRANS64(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
> >   TRANS(amor_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
> > -TRANS(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
> > +TRANS64(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
> >   TRANS(amxor_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
> > -TRANS(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
> > +TRANS64(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
> >   TRANS(ammax_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
> > -TRANS(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
> > +TRANS64(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
> >   TRANS(ammin_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
> > -TRANS(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
> > +TRANS64(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
> >   TRANS(ammax_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
> > -TRANS(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
> > +TRANS64(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
> >   TRANS(ammin_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
> > -TRANS(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
> > +TRANS64(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
> >   TRANS(amswap_db_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
> > -TRANS(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
> > +TRANS64(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
> >   TRANS(amadd_db_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
> > -TRANS(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
> > +TRANS64(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
> >   TRANS(amand_db_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
> > -TRANS(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
> > +TRANS64(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
> >   TRANS(amor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
> > -TRANS(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
> > +TRANS64(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
> >   TRANS(amxor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
> > -TRANS(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
> > +TRANS64(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
> >   TRANS(ammax_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
> > -TRANS(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
> > +TRANS64(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ=
)
> >   TRANS(ammin_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
> > -TRANS(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
> > +TRANS64(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ=
)
> >   TRANS(ammax_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL=
)
> > -TRANS(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
> > +TRANS64(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEU=
Q)
> >   TRANS(ammin_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL=
)
> > -TRANS(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
> > +TRANS64(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEU=
Q)
> > diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target=
/loongarch/tcg/insn_trans/trans_extra.c.inc
> > index eda3d6e561..298a80cff5 100644
> > --- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> > +++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> > @@ -69,6 +69,10 @@ static bool trans_rdtimeh_w(DisasContext *ctx, arg_r=
dtimeh_w *a)
> >
> >   static bool trans_rdtime_d(DisasContext *ctx, arg_rdtime_d *a)
> >   {
> > +    if (!avail_64(ctx)) {
> > +        return false;
> > +    }
> > +
> >       return gen_rdtime(ctx, a, 0, 0);
> >   }
> >
> > @@ -100,8 +104,8 @@ static bool gen_crc(DisasContext *ctx, arg_rrr *a,
> >   TRANS(crc_w_b_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
> >   TRANS(crc_w_h_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
> >   TRANS(crc_w_w_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
> > -TRANS(crc_w_d_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
> > +TRANS64(crc_w_d_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
> >   TRANS(crcc_w_b_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(1)=
)
> >   TRANS(crcc_w_h_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(2)=
)
> >   TRANS(crcc_w_w_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(4)=
)
> > -TRANS(crcc_w_d_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
> > +TRANS64(crcc_w_d_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(8=
))
> > diff --git a/target/loongarch/tcg/insn_trans/trans_farith.c.inc b/targe=
t/loongarch/tcg/insn_trans/trans_farith.c.inc
> > index f4a0dea727..ff6cf3448e 100644
> > --- a/target/loongarch/tcg/insn_trans/trans_farith.c.inc
> > +++ b/target/loongarch/tcg/insn_trans/trans_farith.c.inc
> > @@ -183,16 +183,16 @@ TRANS(fmaxa_s, FP_SP, gen_fff, gen_helper_fmaxa_s=
)
> >   TRANS(fmaxa_d, FP_DP, gen_fff, gen_helper_fmaxa_d)
> >   TRANS(fmina_s, FP_SP, gen_fff, gen_helper_fmina_s)
> >   TRANS(fmina_d, FP_DP, gen_fff, gen_helper_fmina_d)
> > -TRANS(fscaleb_s, FP_SP, gen_fff, gen_helper_fscaleb_s)
> > -TRANS(fscaleb_d, FP_DP, gen_fff, gen_helper_fscaleb_d)
> > +TRANS64(fscaleb_s, FP_SP, gen_fff, gen_helper_fscaleb_s)
> > +TRANS64(fscaleb_d, FP_DP, gen_fff, gen_helper_fscaleb_d)
> >   TRANS(fsqrt_s, FP_SP, gen_ff, gen_helper_fsqrt_s)
> >   TRANS(fsqrt_d, FP_DP, gen_ff, gen_helper_fsqrt_d)
> >   TRANS(frecip_s, FP_SP, gen_ff, gen_helper_frecip_s)
> >   TRANS(frecip_d, FP_DP, gen_ff, gen_helper_frecip_d)
> >   TRANS(frsqrt_s, FP_SP, gen_ff, gen_helper_frsqrt_s)
> >   TRANS(frsqrt_d, FP_DP, gen_ff, gen_helper_frsqrt_d)
> > -TRANS(flogb_s, FP_SP, gen_ff, gen_helper_flogb_s)
> > -TRANS(flogb_d, FP_DP, gen_ff, gen_helper_flogb_d)
> > +TRANS64(flogb_s, FP_SP, gen_ff, gen_helper_flogb_s)
> > +TRANS64(flogb_d, FP_DP, gen_ff, gen_helper_flogb_d)
> >   TRANS(fclass_s, FP_SP, gen_ff, gen_helper_fclass_s)
> >   TRANS(fclass_d, FP_DP, gen_ff, gen_helper_fclass_d)
> >   TRANS(fmadd_s, FP_SP, gen_muladd, gen_helper_fmuladd_s, 0)
> > diff --git a/target/loongarch/tcg/insn_trans/trans_fcnv.c.inc b/target/=
loongarch/tcg/insn_trans/trans_fcnv.c.inc
> > index 833c059d6d..ca1d76a366 100644
> > --- a/target/loongarch/tcg/insn_trans/trans_fcnv.c.inc
> > +++ b/target/loongarch/tcg/insn_trans/trans_fcnv.c.inc
> > @@ -29,5 +29,5 @@ TRANS(ffint_s_w, FP_SP, gen_ff, gen_helper_ffint_s_w)
> >   TRANS(ffint_s_l, FP_SP, gen_ff, gen_helper_ffint_s_l)
> >   TRANS(ffint_d_w, FP_DP, gen_ff, gen_helper_ffint_d_w)
> >   TRANS(ffint_d_l, FP_DP, gen_ff, gen_helper_ffint_d_l)
> > -TRANS(frint_s, FP_SP, gen_ff, gen_helper_frint_s)
> > -TRANS(frint_d, FP_DP, gen_ff, gen_helper_frint_d)
> > +TRANS64(frint_s, FP_SP, gen_ff, gen_helper_frint_s)
> > +TRANS64(frint_d, FP_DP, gen_ff, gen_helper_frint_d)
> > diff --git a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc b/targ=
et/loongarch/tcg/insn_trans/trans_fmemory.c.inc
> > index 13452bc7e5..79da4718a5 100644
> > --- a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
> > +++ b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
> > @@ -148,11 +148,11 @@ TRANS(fldx_s, FP_SP, gen_floadx, MO_TEUL)
> >   TRANS(fldx_d, FP_DP, gen_floadx, MO_TEUQ)
> >   TRANS(fstx_s, FP_SP, gen_fstorex, MO_TEUL)
> >   TRANS(fstx_d, FP_DP, gen_fstorex, MO_TEUQ)
> > -TRANS(fldgt_s, FP_SP, gen_fload_gt, MO_TEUL)
> > -TRANS(fldgt_d, FP_DP, gen_fload_gt, MO_TEUQ)
> > -TRANS(fldle_s, FP_SP, gen_fload_le, MO_TEUL)
> > -TRANS(fldle_d, FP_DP, gen_fload_le, MO_TEUQ)
> > -TRANS(fstgt_s, FP_SP, gen_fstore_gt, MO_TEUL)
> > -TRANS(fstgt_d, FP_DP, gen_fstore_gt, MO_TEUQ)
> > -TRANS(fstle_s, FP_SP, gen_fstore_le, MO_TEUL)
> > -TRANS(fstle_d, FP_DP, gen_fstore_le, MO_TEUQ)
> > +TRANS64(fldgt_s, FP_SP, gen_fload_gt, MO_TEUL)
> > +TRANS64(fldgt_d, FP_DP, gen_fload_gt, MO_TEUQ)
> > +TRANS64(fldle_s, FP_SP, gen_fload_le, MO_TEUL)
> > +TRANS64(fldle_d, FP_DP, gen_fload_le, MO_TEUQ)
> > +TRANS64(fstgt_s, FP_SP, gen_fstore_gt, MO_TEUL)
> > +TRANS64(fstgt_d, FP_DP, gen_fstore_gt, MO_TEUQ)
> > +TRANS64(fstle_s, FP_SP, gen_fstore_le, MO_TEUL)
> > +TRANS64(fstle_d, FP_DP, gen_fstore_le, MO_TEUQ)
> > diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/t=
arget/loongarch/tcg/insn_trans/trans_privileged.c.inc
> > index ecbfe23b63..34cfab8879 100644
> > --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> > +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> > @@ -233,11 +233,11 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr=
 *a,
> >   TRANS(iocsrrd_b, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_b)
> >   TRANS(iocsrrd_h, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_h)
> >   TRANS(iocsrrd_w, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_w)
> > -TRANS(iocsrrd_d, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_d)
> > +TRANS64(iocsrrd_d, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_d)
> >   TRANS(iocsrwr_b, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_b)
> >   TRANS(iocsrwr_h, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_h)
> >   TRANS(iocsrwr_w, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_w)
> > -TRANS(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
> > +TRANS64(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
> >
> >   static void check_mmu_idx(DisasContext *ctx)
> >   {
> > diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc b/target=
/loongarch/tcg/insn_trans/trans_shift.c.inc
> > index 377307785a..136c4c8455 100644
> > --- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> > +++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> > @@ -78,7 +78,7 @@ TRANS(sra_w, ALL, gen_rrr, EXT_SIGN, EXT_NONE, EXT_SI=
GN, gen_sra_w)
> >   TRANS(sll_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
> >   TRANS(srl_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
> >   TRANS(sra_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
> > -TRANS(rotr_w, 64, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
> > +TRANS(rotr_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
> >   TRANS(rotr_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
> >   TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
> >   TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
> > @@ -86,5 +86,5 @@ TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg=
_gen_shri_tl)
> >   TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
> >   TRANS(srai_w, ALL, gen_rri_c, EXT_NONE, EXT_NONE, gen_sari_w)
> >   TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
> > -TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
> > +TRANS(rotri_w, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
> >   TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
> > diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/l=
oongarch/tcg/insn_trans/trans_vec.c.inc
> > index dff92772ad..a6f5b346bb 100644
> > --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> > +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> > @@ -4853,9 +4853,9 @@ static bool gen_g2x(DisasContext *ctx, arg_vr_i *=
a, MemOp mop,
> >   TRANS(vinsgr2vr_b, LSX, gen_g2v, MO_8, tcg_gen_st8_i64)
> >   TRANS(vinsgr2vr_h, LSX, gen_g2v, MO_16, tcg_gen_st16_i64)
> >   TRANS(vinsgr2vr_w, LSX, gen_g2v, MO_32, tcg_gen_st32_i64)
> > -TRANS(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
> > +TRANS64(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
> >   TRANS(xvinsgr2vr_w, LASX, gen_g2x, MO_32, tcg_gen_st32_i64)
> > -TRANS(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)
> > +TRANS64(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)
> >
> >   static bool gen_v2g_vl(DisasContext *ctx, arg_rv_i *a, uint32_t oprsz=
, MemOp mop,
> >                          void (*func)(TCGv, TCGv_ptr, tcg_target_long))
> > @@ -4886,15 +4886,15 @@ static bool gen_x2g(DisasContext *ctx, arg_rv_i=
 *a, MemOp mop,
> >   TRANS(vpickve2gr_b, LSX, gen_v2g, MO_8, tcg_gen_ld8s_i64)
> >   TRANS(vpickve2gr_h, LSX, gen_v2g, MO_16, tcg_gen_ld16s_i64)
> >   TRANS(vpickve2gr_w, LSX, gen_v2g, MO_32, tcg_gen_ld32s_i64)
> > -TRANS(vpickve2gr_d, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> > +TRANS64(vpickve2gr_d, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> >   TRANS(vpickve2gr_bu, LSX, gen_v2g, MO_8, tcg_gen_ld8u_i64)
> >   TRANS(vpickve2gr_hu, LSX, gen_v2g, MO_16, tcg_gen_ld16u_i64)
> >   TRANS(vpickve2gr_wu, LSX, gen_v2g, MO_32, tcg_gen_ld32u_i64)
> > -TRANS(vpickve2gr_du, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> > +TRANS64(vpickve2gr_du, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> >   TRANS(xvpickve2gr_w, LASX, gen_x2g, MO_32, tcg_gen_ld32s_i64)
> > -TRANS(xvpickve2gr_d, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> > +TRANS64(xvpickve2gr_d, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> >   TRANS(xvpickve2gr_wu, LASX, gen_x2g, MO_32, tcg_gen_ld32u_i64)
> > -TRANS(xvpickve2gr_du, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> > +TRANS64(xvpickve2gr_du, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> >
> >   static bool gvec_dup_vl(DisasContext *ctx, arg_vr *a,
> >                           uint32_t oprsz, MemOp mop)
> > @@ -4923,11 +4923,11 @@ static bool gvec_dupx(DisasContext *ctx, arg_vr=
 *a, MemOp mop)
> >   TRANS(vreplgr2vr_b, LSX, gvec_dup, MO_8)
> >   TRANS(vreplgr2vr_h, LSX, gvec_dup, MO_16)
> >   TRANS(vreplgr2vr_w, LSX, gvec_dup, MO_32)
> > -TRANS(vreplgr2vr_d, LSX, gvec_dup, MO_64)
> > +TRANS64(vreplgr2vr_d, LSX, gvec_dup, MO_64)
> >   TRANS(xvreplgr2vr_b, LASX, gvec_dupx, MO_8)
> >   TRANS(xvreplgr2vr_h, LASX, gvec_dupx, MO_16)
> >   TRANS(xvreplgr2vr_w, LASX, gvec_dupx, MO_32)
> > -TRANS(xvreplgr2vr_d, LASX, gvec_dupx, MO_64)
> > +TRANS64(xvreplgr2vr_d, LASX, gvec_dupx, MO_64)
> >
> >   static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
> >   {
> > diff --git a/target/loongarch/translate.h b/target/loongarch/translate.=
h
> > index 018dc5eb17..bbe015ba57 100644
> > --- a/target/loongarch/translate.h
> > +++ b/target/loongarch/translate.h
> > @@ -14,6 +14,10 @@
> >       static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> >       { return avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); }
> >
> > +#define TRANS64(NAME, AVAIL, FUNC, ...) \
> > +    static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> > +    { return avail_64(ctx) && avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_=
ARGS__); }
> > +
> >   #define avail_ALL(C)   true
> >   #define avail_64(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH) =3D=
=3D \
> >                           CPUCFG1_ARCH_LA64)
> >
>


