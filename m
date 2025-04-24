Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F99FC369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 04:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7oCe-00074Y-VO; Thu, 24 Apr 2025 00:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1u7oCd-00074M-19
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 00:28:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1u7oCY-00017L-UE
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 00:28:46 -0400
Received: from loongson.cn (unknown [209.85.219.172])
 by gateway (Coremail) with SMTP id _____8BxXWvzvQloFhDFAA--.64617S3;
 Thu, 24 Apr 2025 12:28:36 +0800 (CST)
Received: from mail-yb1-f172.google.com (unknown [209.85.219.172])
 by front1 (Coremail) with SMTP id qMiowMCxrhvwvQlopu6SAA--.53342S3;
 Thu, 24 Apr 2025 12:28:34 +0800 (CST)
Received: by mail-yb1-f172.google.com with SMTP id
 3f1490d57ef6-e72a786b1b8so580083276.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 21:28:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWOONVhP386z/antD9zGmNtqKb/3iSXyf2Hz6MVyioo5dTVRK42R6nvICSDAAXXTGuSXF9vYs1Swm1L@nongnu.org
X-Gm-Message-State: AOJu0Yzi046twElkXlwf1mGS83Bc0TLC4yI+rrOKmC2O+X8rS3xowWX7
 dconhx1wRql4NuudsfdxvN1Sww49gNQ/kOE4gngK7zSb9m4rynx9z0wLemXx+eDmVudNLMiMQBk
 dSNEKRzfQeAkz1xrsfCy163x5RsNk56wpiOl8IA==
X-Google-Smtp-Source: AGHT+IH9St9EPqHd0+SuTge3MHHgyASmlWaHZPtE2dx/Pg7Pn7qAR1g0XwhgY4WNtu7iCIlW98qfQKsrbDBH+YV15FQ=
X-Received: by 2002:a05:6902:161d:b0:e58:36ad:a1ba with SMTP id
 3f1490d57ef6-e730521b9f3mr998833276.16.1745468911899; Wed, 23 Apr 2025
 21:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250418082103.447780-1-wangrui@loongson.cn>
 <20250418082103.447780-4-wangrui@loongson.cn>
 <56cfe883-2de5-43f6-67db-a05d88a010e9@loongson.cn>
 <a395f6aa-c623-ba7d-2952-5b7249144ba8@loongson.cn>
 <CAHirt9gZEoTi4dnf69Pe0ZWAxFfn3La0=tcGESoATn1WaF4etg@mail.gmail.com>
 <446f7813-4d26-91c7-0baa-098b5c5eb2b0@loongson.cn>
 <CAHirt9jbrmTWgRHBYZAN2t_tzF9CJ86Z_=9XxPpkQYbj7WTqzw@mail.gmail.com>
 <806baf17-7d22-0d5e-f4a4-22f5ecd36ac0@loongson.cn>
In-Reply-To: <806baf17-7d22-0d5e-f4a4-22f5ecd36ac0@loongson.cn>
From: WANG Rui <wangrui@loongson.cn>
Date: Thu, 24 Apr 2025 12:28:20 +0800
X-Gmail-Original-Message-ID: <CAHirt9g8JcGhycVcw7-u6iaNPFonZhHY1kQGK+R7G2icFPQabA@mail.gmail.com>
X-Gm-Features: ATxdqUH5A6HV2cIeQ8ZHyGe32TMI47wVY2UF8KX67G45tQpW-A-sSQeYHIMIMjs
Message-ID: <CAHirt9g8JcGhycVcw7-u6iaNPFonZhHY1kQGK+R7G2icFPQabA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] target/loongarch: Guard 64-bit-only insn
 translation with TRANS64 macro
To: bibo mao <maobibo@loongson.cn>
Cc: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, qemu@hev.cc, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: qMiowMCxrhvwvQlopu6SAA--.53342S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3trW7Cr43Kw4UAw1xtFWDtrc_yoW8Zr47Zo
 WrXF47JF1xJ345urW5K34kt34qvw1xAa4DJ3yUJw1UuF9Yq3Wjkw1rCw1DZay3uFWDAFyU
 Wr4xG3Z5Aa13Xwn7l-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYz7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr4
 1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AK
 xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrx
 kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
 6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
 CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUU
 U
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

On Thu, Apr 24, 2025 at 12:11=E2=80=AFPM bibo mao <maobibo@loongson.cn> wro=
te:
>
>
>
> On 2025/4/24 =E4=B8=8A=E5=8D=8810:59, WANG Rui wrote:
> > Hi Bibo,
> >
> > On Thu, Apr 24, 2025 at 10:32=E2=80=AFAM bibo mao <maobibo@loongson.cn>=
 wrote:
> >>
> >>
> >>
> >> On 2025/4/24 =E4=B8=8A=E5=8D=8810:11, WANG Rui wrote:
> >>> Hi Song,
> >>>
> >>> On Thu, Apr 24, 2025 at 9:40=E2=80=AFAM gaosong <gaosong@loongson.cn>=
 wrote:
> >>>>
> >>>> =E5=9C=A8 2025/4/18 =E4=B8=8B=E5=8D=884:45, bibo mao =E5=86=99=E9=81=
=93:
> >>>>>
> >>>>>
> >>>>> On 2025/4/18 =E4=B8=8B=E5=8D=884:21, WANG Rui wrote:
> >>>>>> This patch replaces uses of the generic TRANS macro with TRANS64 f=
or
> >>>>>> instructions that are only valid when 64-bit support is available.
> >>>>>>
> >>>>>> This improves correctness and avoids potential assertion failures =
or
> >>>>>> undefined behavior during translation on 32-bit-only configuration=
s.
> >>>>>>
> >>>>>> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> >>>>>> ---
> >>>>>>     .../tcg/insn_trans/trans_atomic.c.inc         | 36 +++++++++--=
--------
> >>>>>>     .../tcg/insn_trans/trans_extra.c.inc          |  8 +++--
> >>>>>>     .../tcg/insn_trans/trans_privileged.c.inc     |  4 +--
> >>>>>>     .../tcg/insn_trans/trans_shift.c.inc          |  4 +--
> >>>>>>     .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++++-----
> >>>>>>     target/loongarch/translate.h                  |  4 +++
> >>>>>>     6 files changed, 40 insertions(+), 32 deletions(-)
> >>>>>>
> >>>>>> diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> >>>>>> b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> >>>>>> index 3d70d75941..77eeedbc42 100644
> >>>>>> --- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> >>>>>> +++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> >>>>>> @@ -74,38 +74,38 @@ TRANS(sc_w, ALL, gen_sc, MO_TESL)
> >>>>>>     TRANS(ll_d, 64, gen_ll, MO_TEUQ)
> >>>>>>     TRANS(sc_d, 64, gen_sc, MO_TEUQ)
> >>>>>>     TRANS(amswap_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
> >>>>>> -TRANS(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
> >>>>>> +TRANS64(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
> >>>>>>     TRANS(amadd_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TE=
SL)
> >>>>>> -TRANS(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
> >>>>>> +TRANS64(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEU=
Q)
> >>>>>>     TRANS(amand_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TE=
SL)
> >>>>>> -TRANS(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
> >>>>>> +TRANS64(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEU=
Q)
> >>>>>>     TRANS(amor_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL=
)
> >>>>>> -TRANS(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
> >>>>>> +TRANS64(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
> >>>>>>     TRANS(amxor_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TE=
SL)
> >>>>>> -TRANS(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
> >>>>>> +TRANS64(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEU=
Q)
> >>>>>>     TRANS(ammax_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_T=
ESL)
> >>>>>> -TRANS(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ=
)
> >>>>>> +TRANS64(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TE=
UQ)
> >>>>>>     TRANS(ammin_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_T=
ESL)
> >>>>>> -TRANS(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ=
)
> >>>>>> +TRANS64(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TE=
UQ)
> >>>>>>     TRANS(ammax_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_=
TESL)
> >>>>>> -TRANS(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEU=
Q)
> >>>>>> +TRANS64(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_T=
EUQ)
> >>>>>>     TRANS(ammin_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_=
TESL)
> >>>>>> -TRANS(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEU=
Q)
> >>>>>> +TRANS64(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_T=
EUQ)
> >>>>>>     TRANS(amswap_db_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TES=
L)
> >>>>>> -TRANS(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
> >>>>>> +TRANS64(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ=
)
> >>>>>>     TRANS(amadd_db_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO=
_TESL)
> >>>>>> -TRANS(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TE=
UQ)
> >>>>>> +TRANS64(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_=
TEUQ)
> >>>>>>     TRANS(amand_db_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO=
_TESL)
> >>>>>> -TRANS(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TE=
UQ)
> >>>>>> +TRANS64(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_=
TEUQ)
> >>>>>>     TRANS(amor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_T=
ESL)
> >>>>>> -TRANS(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ=
)
> >>>>>> +TRANS64(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TE=
UQ)
> >>>>>>     TRANS(amxor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO=
_TESL)
> >>>>>> -TRANS(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TE=
UQ)
> >>>>>> +TRANS64(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_=
TEUQ)
> >>>>>>     TRANS(ammax_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, M=
O_TESL)
> >>>>>> -TRANS(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_T=
EUQ)
> >>>>>> +TRANS64(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO=
_TEUQ)
> >>>>>>     TRANS(ammin_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, M=
O_TESL)
> >>>>>> -TRANS(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_T=
EUQ)
> >>>>>> +TRANS64(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO=
_TEUQ)
> >>>>>>     TRANS(ammax_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, =
MO_TESL)
> >>>>>> -TRANS(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_=
TEUQ)
> >>>>>> +TRANS64(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl,
> >>>>>> MO_TEUQ)
> >>>>>>     TRANS(ammin_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, =
MO_TESL)
> >>>>>> -TRANS(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_=
TEUQ)
> >>>>>> +TRANS64(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl,
> >>>>>> MO_TEUQ)
> >>>>>> diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> >>>>>> b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> >>>>>> index eda3d6e561..298a80cff5 100644
> >>>>>> --- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> >>>>>> +++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> >>>>>> @@ -69,6 +69,10 @@ static bool trans_rdtimeh_w(DisasContext *ctx,
> >>>>>> arg_rdtimeh_w *a)
> >>>>>>       static bool trans_rdtime_d(DisasContext *ctx, arg_rdtime_d *=
a)
> >>>>>>     {
> >>>>>> +    if (!avail_64(ctx)) {
> >>>>>> +        return false;
> >>>>>> +    }
> >>>>>> +
> >>>>>>         return gen_rdtime(ctx, a, 0, 0);
> >>>>>>     }
> >>>>>>     @@ -100,8 +104,8 @@ static bool gen_crc(DisasContext *ctx, arg=
_rrr *a,
> >>>>>>     TRANS(crc_w_b_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_=
tl(1))
> >>>>>>     TRANS(crc_w_h_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_=
tl(2))
> >>>>>>     TRANS(crc_w_w_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_=
tl(4))
> >>>>>> -TRANS(crc_w_d_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(=
8))
> >>>>>> +TRANS64(crc_w_d_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_t=
l(8))
> >>>>>>     TRANS(crcc_w_b_w, CRC, gen_crc, gen_helper_crc32c, tcg_constan=
t_tl(1))
> >>>>>>     TRANS(crcc_w_h_w, CRC, gen_crc, gen_helper_crc32c, tcg_constan=
t_tl(2))
> >>>>>>     TRANS(crcc_w_w_w, CRC, gen_crc, gen_helper_crc32c, tcg_constan=
t_tl(4))
> >>>>>> -TRANS(crcc_w_d_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_t=
l(8))
> >>>>>> +TRANS64(crcc_w_d_w, CRC, gen_crc, gen_helper_crc32c,
> >>>>>> tcg_constant_tl(8))
> >>>>>> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.in=
c
> >>>>>> b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> >>>>>> index ecbfe23b63..34cfab8879 100644
> >>>>>> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> >>>>>> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> >>>>>> @@ -233,11 +233,11 @@ static bool gen_iocsrwr(DisasContext *ctx,
> >>>>>> arg_rr *a,
> >>>>>>     TRANS(iocsrrd_b, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_b)
> >>>>>>     TRANS(iocsrrd_h, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_h)
> >>>>>>     TRANS(iocsrrd_w, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_w)
> >>>>>> -TRANS(iocsrrd_d, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_d)
> >>>>>> +TRANS64(iocsrrd_d, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_d)
> >>>>>>     TRANS(iocsrwr_b, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_b)
> >>>>>>     TRANS(iocsrwr_h, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_h)
> >>>>>>     TRANS(iocsrwr_w, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_w)
> >>>>>> -TRANS(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
> >>>>>> +TRANS64(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
> >>>>>>       static void check_mmu_idx(DisasContext *ctx)
> >>>>>>     {
> >>>>>> diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> >>>>>> b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> >>>>>> index 377307785a..136c4c8455 100644
> >>>>>> --- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> >>>>>> +++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> >>>>>> @@ -78,7 +78,7 @@ TRANS(sra_w, ALL, gen_rrr, EXT_SIGN, EXT_NONE,
> >>>>>> EXT_SIGN, gen_sra_w)
> >>>>>>     TRANS(sll_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sl=
l_d)
> >>>>>>     TRANS(srl_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sr=
l_d)
> >>>>>>     TRANS(sra_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sr=
a_d)
> >>>>>> -TRANS(rotr_w, 64, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr=
_w)
> >>>>>> +TRANS(rotr_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rot=
r_w)
> >>>>>>     TRANS(rotr_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_r=
otr_d)
> >>>>>>     TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli=
_tl)
> >>>>>>     TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_=
tl)
> >>>>>> @@ -86,5 +86,5 @@ TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN=
,
> >>>>>> tcg_gen_shri_tl)
> >>>>>>     TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_=
tl)
> >>>>>>     TRANS(srai_w, ALL, gen_rri_c, EXT_NONE, EXT_NONE, gen_sari_w)
> >>>>>>     TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_=
tl)
> >>>>>> -TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
> >>>>>> +TRANS(rotri_w, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
> >>>>>>     TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotr=
i_tl)
> >>>>> The modification looks good to me.
> >>>>>
> >>>>>> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> >>>>>> b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> >>>>>> index dff92772ad..a6f5b346bb 100644
> >>>>>> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> >>>>>> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> >>>>>> @@ -4853,9 +4853,9 @@ static bool gen_g2x(DisasContext *ctx, arg_v=
r_i
> >>>>>> *a, MemOp mop,
> >>>>>>     TRANS(vinsgr2vr_b, LSX, gen_g2v, MO_8, tcg_gen_st8_i64)
> >>>>>>     TRANS(vinsgr2vr_h, LSX, gen_g2v, MO_16, tcg_gen_st16_i64)
> >>>>>>     TRANS(vinsgr2vr_w, LSX, gen_g2v, MO_32, tcg_gen_st32_i64)
> >>>>>> -TRANS(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
> >>>>>> +TRANS64(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
> >>>>>>     TRANS(xvinsgr2vr_w, LASX, gen_g2x, MO_32, tcg_gen_st32_i64)
> >>>>>> -TRANS(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)
> >>>>>> +TRANS64(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)
> >>>>> This looks good, only that I do not know whether it is necessary.
> >>>>> Can you conclude that LSX/LASX means that 64 bit is supported also?
> >>>>>
> >>>>> Song, what is your option?
> >>>>>
> >>>> I think LSX/LASX is enough
> >>>>
> >>>> Hi , WANG Rui
> >>>> why only these XXX_d vec instructions need  TRANS64?
> >>>
> >>> As far as I know, although there are currently no LoongArch 32-bit
> >>> implementations that support LSX or LASX, the ISA itself does not
> >>> explicitly forbid such a combination. In other words, LSX/LASX is not
> >>> inherently tied to a 64-bit base architecture.
> >> I do not know. it will be better chip guys can give us the answer. LSX
> >> is 128bit vector instruction, LASX is 256bit vector instruction, I do
> >> not know how chip guys skip 64bit support and design another LSX/LASX
> >> instruction.
> >
> > Actually, this point is clarified in the LoongArch Reference Manual --
> > Volume II. According to the first section of the document:
> >
> > The implementation of LSX or LASX is independent of whether the base
> > architecture is LA32 or LA64. Except for a small number of
> > instructions that transfer 64-bit data between general-purpose and
> > vector registers -- which are only required on LA64 -- all other
> > vector extension instructions can be implemented on either LA32 or
> > LA64 processors.
> >
> >>
> >>> Given this, I chose to mark certain vector instructions --
> >>> specifically those that access general-purpose registers using 64-bit
> >>> data width (such as the _d variants) -- as requiring TRANS64. This
> >>> ensures the backedn correctly handles them in case LSX/LASX support
> >>> apperars on a 32-bit target in the future.
> >> If LSX/LASX support will be added 32-bit target, we need indicator
> >> showing its capability firstly, and then add partial LSX/LASX support,
> >> rather than do it now.
> >>
> >> We are SW developers, rather than chip designers -:)
> >
> > You're absolutely right -- we're not chip designers -:) But in a way,
> > what we're doing with software is building a machine that simulates
> > the ISA. With just a few dozen lines of code, we can easily create a
> > 32-bit virtual CPU that supports vector features. This kind of setup
> > is already happening in practice, especially for developers using QEMU
> > to validate 32-bit system software stacks.
> >
> > That's why I believe it's worthwhile to introduce the necessary
> > constraints now, to prevent certain vector instructions -- those that
> > implicitly rely on 64-bit GPR access -- from silently working in
> It will cause dozen of compatible issues. It is impossible that people
> write FPGA version and require SW following this, it is private SW even
> if there is.
>
> Hardware manual from official public website should be published at
> first, and SW follows this, rather than informal HW with FPGA version onl=
y.

I agree with your point - the ISA specification should come first, and
software should follow. That=E2=80=99s exactly why I think it's meaningful =
to
handle this case properly in QEMU now.

According to the latest version of the LoongArch ISA specification
that I have access to, LSX and LASX are explicitly allowed to be
implemented on LA32, with only a few instructions restricted to LA64
due to 64-bit GPR transfers. So the idea of supporting LSX/LASX on a
32-bit target isn't based on any private or unofficial hardware - it=E2=80=
=99s
aligned with what's permitted by the official spec.

From this perspective, what we're doing in QEMU is not following any
informal implementation, but rather respecting and staying compatible
with the ISA as officially defined.

Anyway, thanks for the discussion - good to hear different perspectives on =
this.

Regards,
Rui

>
> Regards
> Bibo Mao
> > environments where they shouldn't. This patch aims to ensure
> > correctness and consistency in such simulated or future scenarios.
> >
> > Regards,
> > Rui
> >
> >>
> >> Regards
> >> Bibo Mao
> >>>
> >>> Let me know if you have other suggestions or if I misunderstood someh=
ing.
> >>>
> >>> Regards,
> >>> Rui
> >>>
> >>>>
> >>>> I just pick up patch1, 2 to loongarch-next .
> >>>>
> >>>> Thanks.
> >>>> Song Gao
> >>>>> Regards
> >>>>> Bibo Mao
> >>>>>>       static bool gen_v2g_vl(DisasContext *ctx, arg_rv_i *a, uint3=
2_t
> >>>>>> oprsz, MemOp mop,
> >>>>>>                            void (*func)(TCGv, TCGv_ptr, tcg_target=
_long))
> >>>>>> @@ -4886,15 +4886,15 @@ static bool gen_x2g(DisasContext *ctx,
> >>>>>> arg_rv_i *a, MemOp mop,
> >>>>>>     TRANS(vpickve2gr_b, LSX, gen_v2g, MO_8, tcg_gen_ld8s_i64)
> >>>>>>     TRANS(vpickve2gr_h, LSX, gen_v2g, MO_16, tcg_gen_ld16s_i64)
> >>>>>>     TRANS(vpickve2gr_w, LSX, gen_v2g, MO_32, tcg_gen_ld32s_i64)
> >>>>>> -TRANS(vpickve2gr_d, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> >>>>>> +TRANS64(vpickve2gr_d, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> >>>>>>     TRANS(vpickve2gr_bu, LSX, gen_v2g, MO_8, tcg_gen_ld8u_i64)
> >>>>>>     TRANS(vpickve2gr_hu, LSX, gen_v2g, MO_16, tcg_gen_ld16u_i64)
> >>>>>>     TRANS(vpickve2gr_wu, LSX, gen_v2g, MO_32, tcg_gen_ld32u_i64)
> >>>>>> -TRANS(vpickve2gr_du, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> >>>>>> +TRANS64(vpickve2gr_du, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
> >>>>>>     TRANS(xvpickve2gr_w, LASX, gen_x2g, MO_32, tcg_gen_ld32s_i64)
> >>>>>> -TRANS(xvpickve2gr_d, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> >>>>>> +TRANS64(xvpickve2gr_d, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> >>>>>>     TRANS(xvpickve2gr_wu, LASX, gen_x2g, MO_32, tcg_gen_ld32u_i64)
> >>>>>> -TRANS(xvpickve2gr_du, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> >>>>>> +TRANS64(xvpickve2gr_du, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
> >>>>>>       static bool gvec_dup_vl(DisasContext *ctx, arg_vr *a,
> >>>>>>                             uint32_t oprsz, MemOp mop)
> >>>>>> @@ -4923,11 +4923,11 @@ static bool gvec_dupx(DisasContext *ctx,
> >>>>>> arg_vr *a, MemOp mop)
> >>>>>>     TRANS(vreplgr2vr_b, LSX, gvec_dup, MO_8)
> >>>>>>     TRANS(vreplgr2vr_h, LSX, gvec_dup, MO_16)
> >>>>>>     TRANS(vreplgr2vr_w, LSX, gvec_dup, MO_32)
> >>>>>> -TRANS(vreplgr2vr_d, LSX, gvec_dup, MO_64)
> >>>>>> +TRANS64(vreplgr2vr_d, LSX, gvec_dup, MO_64)
> >>>>>>     TRANS(xvreplgr2vr_b, LASX, gvec_dupx, MO_8)
> >>>>>>     TRANS(xvreplgr2vr_h, LASX, gvec_dupx, MO_16)
> >>>>>>     TRANS(xvreplgr2vr_w, LASX, gvec_dupx, MO_32)
> >>>>>> -TRANS(xvreplgr2vr_d, LASX, gvec_dupx, MO_64)
> >>>>>> +TRANS64(xvreplgr2vr_d, LASX, gvec_dupx, MO_64)
> >>>>>>       static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
> >>>>>>     {
> >>>>>> diff --git a/target/loongarch/translate.h b/target/loongarch/trans=
late.h
> >>>>>> index 018dc5eb17..bbe015ba57 100644
> >>>>>> --- a/target/loongarch/translate.h
> >>>>>> +++ b/target/loongarch/translate.h
> >>>>>> @@ -14,6 +14,10 @@
> >>>>>>         static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a=
) \
> >>>>>>         { return avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); =
}
> >>>>>>     +#define TRANS64(NAME, AVAIL, FUNC, ...) \
> >>>>>> +    static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> >>>>>> +    { return avail_64(ctx) && avail_##AVAIL(ctx) && FUNC(ctx, a,
> >>>>>> __VA_ARGS__); }
> >>>>>> +
> >>>>>>     #define avail_ALL(C)   true
> >>>>>>     #define avail_64(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH=
) =3D=3D \
> >>>>>>                             CPUCFG1_ARCH_LA64)
> >>>>>>
> >>>>
> >>
> >
>


