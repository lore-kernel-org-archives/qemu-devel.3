Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27A2E98FA8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 05:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAi0y-0003jN-8A; Thu, 09 Apr 2026 01:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAi0w-0003io-NQ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 01:33:14 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAi0v-00029F-3l
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 01:33:14 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9c603ec2dfso60491466b.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 22:33:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775712791; cv=none;
 d=google.com; s=arc-20240605;
 b=Cr9QwmowHAsJCBFrP6tJQgEx1QuL5m1tixDD0uMRdDsT/5z5KFXOnCNMRWY/bw+NOc
 kX9feug4XK9RAhPzS2QI3q4BSsCGxJ1OYLTkUUS4LS1KollMzveRg9BKzErJyOCuO2Wc
 OwEmGBdDoU6ksJpDgtAgXwkuzGeC6da/I97I0GIEJ0+gLMwzAn3DJS797I38i3tSO2tS
 UrErx8X8lJ6NXFaCwgF5bIL7aRcuDrobfRhbkodaOAe96A3eGNS1qlJZEQQDTCpn4675
 k/GuxN91Ba0d2GCB7vOKo8FLyTMqqCAXuef/JGop08Kw31ed9ELUJBrdXTeuyWNqc+Xi
 Fedg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q7W5EgfYBUCh5Ur7tFbXwCFQlDAeWMpzxE/KfTvgmUc=;
 fh=Kc/dcn40HBQvYOJiosZxh95/A3tD5pu37BAko49UkXA=;
 b=bfQ0eUL+Gst3ZCOc8XEfehzSUVM3l7bWCK+VjbFqexM/WH0yAhqz3V42N4Caz80q9G
 av8wqttfJwb5/Ie8bZf2L8cmTE9Jx3l04YnRvwqVBK5ShjDJots6XbGViyIrqckYqGbJ
 OWfJt7NHdMkpJIEFfJVz1eqSMEe37EUaPsNRvF1BZQ8gVqGV24YlhSeMYBVq8kcHiWJZ
 p8EApsS97SD6LeOjUyV/jX6LLSWiM8JeKEUm8Gx2xqE4e+qryL0ZqLB/5WpuCgWqqsMQ
 GkklMxAlUO9U9AcxuKbGghhfaKVyc8fyCb5kkj+KUKbIDdnVkhDSjl+Gxv996NHcNPyn
 q4tg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775712791; x=1776317591; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7W5EgfYBUCh5Ur7tFbXwCFQlDAeWMpzxE/KfTvgmUc=;
 b=da80+o7NQ3XfZ40/LXo2mmo2tgnIMhVkjRrmA7tL8muClOCdZ8oDAdctbpqai0FZHT
 KkANT1Sb/1oKLaPhRPJvRZAB6y2XxZSDnzx2nMtpY4jn8nFGObHDiPi0Sp27SAToiKT5
 4xUqGfqIo/9jHV8ZKueSxMG0BliJHH/RZ83crdc6FdXGTYegvz1e6TksMn35T81ZbfXG
 MJ41AiT6orMDdpCFG5yhz4XXv2Mds3xsDd93NiCJ78fDOFsH9H7I/xNCawtok3VOtegr
 Sret0WCErVmr/+h649C2/8i1uPYBtkCBW0g/d2vOtm0VmLm66hg5XKAOatLSHnT6PzYU
 F3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775712791; x=1776317591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q7W5EgfYBUCh5Ur7tFbXwCFQlDAeWMpzxE/KfTvgmUc=;
 b=AvlmnO3L6qdM8cxyjRrt0OZ4e9/R/57E4yGzrWHqN13mddXOhtNGqWEhoV8RitroBE
 14rX5JGvqqzXgJMS6ylqLVH/vss0IUZfGC8/BXdByK3OSGfJ6O4VzYIM8iQzWwy2JoYM
 X9CoQcyyEF2U29wELgHDt6t0dsjmVwPrKNwXR+aJ0km/sO6siteSEAWHnZ0R7HdiiR0w
 pFzGVJsAT13dp/1i6G5UTNAlJBQOnp8VNokh1QUPImUaxAVF67+VZYS9Tjln0scL/BY7
 HeiqVd/CIp427rtM5ccg/a7ZC7Rj0+WgvGZP1dNlAp14jWqsJ1r4kTON1qTLq4R3iqba
 WBRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXScGWF3AIpBBEuxvqLFI1F2LOZkCuTGAELQYzGbuwAWsFcCzn0fOVgklTTFEjtizBE22uAM/Hv04kC@nongnu.org
X-Gm-Message-State: AOJu0YwLh5WUZwRUan44ZQIC1SuuKGDfN7JdM2vIsneOzWsWIhtrryNs
 yWKgMxmD+N3x06wWOfbOUEiI4/MCMYYalxQGal8yWRN74vpSEwOAcL3dESyABv5EMefieKMhiws
 Ts7WpVBebo+6R3XidpDw1KRLYDXNyOMU=
X-Gm-Gg: AeBDietV7Ym4vb54NN9fd8e9+5iQyQ0SXRAqd05T/IaVhikhfyZ+r9Zb1ED4mrwFgHZ
 4/3WHfZGw02krZWBeqGVtXf3FM1rwlrgOLfEJwGBAYVe1fB3Eq05nERc7PKb8UZPy6JYynaBIXO
 aj6T5sPZdFDgX0QqFCPH7r8/KaMJMTjUGG1EEmr0w8CeIKVyOJyG9CnZ9mjdoJ2MDDjsGUfJP7h
 lwt4fFOE3A8kiHeflIlK0RT/3PVN7S8XPRO1d+HGAaDrjy5aE3tqim+dX7LjkCruMDIlX9NQ287
 h5WylTsMRLIzeanAnIRmuc0VTlWI3h6B64S77g==
X-Received: by 2002:a17:907:6d0e:b0:b9c:a70c:d30b with SMTP id
 a640c23a62f3a-b9ca70cd589mr945268466b.19.1775712790776; Wed, 08 Apr 2026
 22:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-6-alistair.francis@wdc.com>
 <ce3cde01-d4cf-4e01-befb-e9631dcf7757@linux.alibaba.com>
In-Reply-To: <ce3cde01-d4cf-4e01-befb-e9631dcf7757@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Apr 2026 15:32:44 +1000
X-Gm-Features: AQROBzA4ld6oI-3VJgKwhPQdeKKqUMkyO45kO2U3Vfm8inbv8J-vwxdXmuMKgoI
Message-ID: <CAKmqyKPcK4_o06geCsganH8h8yV80TfxPSzsuDY=nOsU7a2B6g@mail.gmail.com>
Subject: Re: [PATCH 5/5] target/riscv: Use ELEN for Fractional LMUL check
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 7, 2026 at 10:13=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> Hi Alistair,
>
> On 4/7/26 12:36 PM, alistair23@gmail.com wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> The RISC-V spec states that
>
> """
> For a given supported fractional LMUL setting, implementations
> must support SEW settings between SEWMIN and LMUL * ELEN, inclusive.
> """
>
> I think the meaning  of "must support"  in specification is "must at leas=
t support" instead of "must only support".

Good point, I didn't really think about that.

>
> Sail or Spike have the same check as this patch to prevent user program c=
an run on them, but
> can't run on RTLs, as RTLs implementation may support SEW besides the  SE=
WMIN and LMUL * ELEN range.
>
> We can refer to discussion here: https://github.com/riscv-software-src/ri=
scv-isa-sim/pull/620

I think this is still the right fix, as it seems like it's unlikely
there will be implementations that expect outside that minimum support
to work, see https://github.com/riscv/riscv-isa-manual/issues/2359#issuecom=
ment-3458627615
for example.

>
> In my opinion, we had better add a option such as "frac_sew_check" to mak=
e user set right value for their RTL implementation.

In future if there are implementations that want extra support that we
can add a property. Right now I suspect there isn't any software that
expects it to work, so it probably isn't an issue and will help catch
faulty implementations.

Alistair

>
> Otherwise,
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>
> Thanks,
> Zhiwei
>
> We were previously checking VLEN, instead of ELEN, so let's update to
> check ELEN instead of VLEN for fractional scaling.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3196
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/vector_helper.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 83dd26314d..b4fc791eb7 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -47,18 +47,17 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, targe=
t_ulong s1,
>      target_ulong reserved =3D s2 &
>                              MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                              xlen - 1 - R_VTYPE_RESERVED_=
SHIFT);
> -    uint16_t vlen =3D cpu->cfg.vlenb << 3;
>      int8_t lmul;
>
>      if (vlmul & 4) {
>          /*
>           * Fractional LMUL, check:
>           *
> -         * VLEN * LMUL >=3D SEW
> -         * VLEN >> (8 - lmul) >=3D sew
> -         * (vlenb << 3) >> (8 - lmul) >=3D sew
> +         * ELEN * LMUL >=3D SEW
> +         * ELEN >> (8 - vlmul) >=3D sew
>           */
> -        if (vlmul =3D=3D 4 || (vlen >> (8 - vlmul)) < sew) {
> +        if (vlmul =3D=3D 4 ||
> +            (cpu->cfg.elen >> (8 - vlmul)) < sew) {
>              vill =3D true;
>          }
>      }

