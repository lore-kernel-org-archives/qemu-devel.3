Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8ACCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcKj-0006GH-Fc; Tue, 13 Oct 2026 09:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1xGcKi-0006Fx-2f
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:14:20 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1xGcKf-0003Ro-Ga
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:14:19 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-3535a54bed9so4080869eec.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20251104.gappssmtp.com; s=20251104; t=1791897255; x=1792502055;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:to
 :from:cc:in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PUV66Gn1sIrQwCvb4T+zP3Ycn4o9uPgk2+d8WggpDlA=;
 b=TEeawIOT0rOW/AmvEFr2klJGHF0jBVaUKKytKTNoCuMH8lqOQEC/8R9gX/JwbebHJS
 A/WXeFvoBb+MthnKNUHaDm2Z916WYMQeK3bCby/Bd46mCIBE98FX66V3TOv2b2jzzEmj
 tGh24vCy2WXMc/8iioE1y+eEqMJGo3E27sUWllWCdHyXZkt4uu1MRVQGCEtFRvCCsG+X
 3srmgzZCxTkIFJcj2MlGm9plEFBZuRpneYQEYimw1+NDJ6Sri8Y5f+Zg32a2C7wXoOFl
 h2sDPJgHpDCOtqoVTCFDP3fFm+Jt+vvpapygEU08i58W6Uaua+0sp3tkQEVF21obdBv7
 5mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791897255; x=1792502055;
 h=content-transfer-encoding:content-type:mime-version:message-id:to
 :from:cc:in-reply-to:subject:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PUV66Gn1sIrQwCvb4T+zP3Ycn4o9uPgk2+d8WggpDlA=;
 b=hibsvg4jEWs/ZPbZ+fgBW/FnmoAdeUAYZeuriKH9An8fKFaQTxH/KQ9r5fRZ2mwtLT
 JJd9gQzMupdXtqM9C0mTjyVvNusaXp5MhflY5wDe+gjCokO5k7Ybn/JufiRCVCOb3D4g
 qd7GickC29ViIbeuQe3Rq0cBwWJ6UrfQRk49SYsigEsB9IW6Sah3/qwL9RPv2vhIYywp
 h0MTRPP+6w9Fm2FJO3UZ06GuQxiht/caflm40KXCTlup/Bp2PhbFTQlDPlyr7CBfe7ne
 BkuPIDCR0WI+EQUWfIGBc7NeiBA8kOiJOH5tzljXDSUk05blp53E1kUvFK/CSXsu17M4
 lp/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3sU50hZFqyQLF1rPoA6gcC3B9ykeMdkoa+8PmOSRkZ3M9UspE+5fGgnokAz97asdpwi36S9YKV2qi@nongnu.org
X-Gm-Message-State: AFq9FYJo31Liq91Ku1xdXq0wCOcqXmPugQ4CHck6R3nPgAfs6Xbe5dtU
 7eBwrEGgl1IRRUF3z9ZUtV3TCUjVj2EmmebLA72CZIE3aHQrbdMOTBhEYERQQIsCGpg=
X-Gm-Gg: AYBFou1fj2Fua6MzdWTD2g+iLBK0mcCwkEthifdIH4qGSXZcX5X9uXKE31bHDQLFxsq
 09L2ptiVTRXll7rUZKh9CMssJfCgxsiEBEoTVxo0ZtTDiKfCiMRCUW9uojDFoLP7BO/x4PTuytp
 cbjvxlBN0i8EFGaxUVyW1kV6tcw0ZOvuhAjw+3lLwMUEBBz6AjwQfcZT1PVcCbMJz3+jDl6VYLr
 QaZKCVeBpfqJVzlhXz3a6H4JVVg8jwuoUGHfM9Dc2w8Hn4LYc40W5GjOqkFJ5GEKHfEfqmJRvzQ
 iSfSpiIBq6LypZsxqaVHoxRKyLEABfKaCliFi4JRN+TiRS0LBm5F+IvHDssIRSTpmfbGWH2Q9fY
 zxe7PS5eoJ7XvpkIiCkj2CKCShgj9RHphJ5RMj1i0gzFQBefx0WKr1yGnDGC3Z2zMzAQpGvv8ZM
 NWU/k2O6Y/9YS6Ke0cmzw02jD5rGl54QPT+boXhyDoGd7GRtAI6+/kBIZ65x+QOjDPN540bKtnl
 NLGn0xGXZZJ3LrkxeAQddns+Ic2hQ==
X-Received: by 2002:a05:7300:d18b:b0:351:1e2e:da4d with SMTP id
 5a478bee46e88-3537e0bdfe0mr18683928eec.23.1791897254641; 
 Tue, 13 Oct 2026 06:14:14 -0700 (PDT)
Received: from localhost ([2001:5a8:4687:d600:60f5:5a60:a2fe:eaae])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm49858819eec.3.2026.10.13.06.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 06:14:13 -0700 (PDT)
Date: Tue, 13 Oct 2026 06:14:13 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Oct 2026 06:14:11 PDT (-0700)
Subject: Re: [PATCH] target/riscv: Use TSO barriers instead of full barriers
 for Ztso
In-Reply-To: <96294abc-af49-433d-99ec-9376b7b78091@oss.qualcomm.com>
CC: rick@sloservers.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: daniel.barboza@oss.qualcomm.com
Message-ID: <mhng-29CE4AFA-6FA7-4BFC-8C6F-F6719A684302@Palmers-Mini.rwc.dabbelt.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=palmer@dabbelt.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 13 Oct 2026 04:57:49 PDT (-0700), daniel.barboza@oss.qualcomm.com wrote:
>
>
> On 10/2/2026 10:47 AM, Rick Richard wrote:
>> With Ztso, plain loads and stores follow RVTSO, but the barriers
>> around them use TCG_MO_ALL.  That also orders a store before a later
>> load, which TSO doesn't require, and is expensive: on x86 hosts it
>> adds a locked instruction around every load and store in a
>> multi-threaded guest.

Thanks.  I'm not quite sure why I had TCG_MO_ALL in there, I think maybe 
I just misread the TCG_MO_* vs TCG_BAR_* blurb?

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>

>> The barrier after a load now only keeps later loads and stores
>> behind it, and the barrier before a store only keeps earlier loads
>> and stores ahead of it.  That is all TSO needs.
>>
>
> Fixes: 09c4e88759 ("RISC-V: Add support for Ztso")
>
>> Signed-off-by: Rick Richard <rick@sloservers.com>
>> ---
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>
>> I found this while looking into why riscv64 guests were so much
>> slower than aarch64 ones under bsd-user on FreeBSD.  The default -cpu
>> max enables Ztso, and turning it off with ztso=false accounted for
>> most of the difference.

Maybe we shouldn't default to Ztso, or at least not default to Ztso on 
host systems that themselves aren't TSO?

>> On an x86-64 host the patch made xz almost four times faster and cut
>> the time of a clang compile by about 30%, the same as running with
>> ztso=false.  The output didn't change.
>>
>> I also tested it on a Raspberry Pi 3B+, which is arm64 and doesn't
>> give TSO ordering in hardware, to make sure the weaker barriers still
>> hold up there.  Everything ran correctly, and xz was about 12% faster.
>>
>>   target/riscv/tcg/insn_trans/trans_rvi.c.inc | 4 ++--
>>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
>> index 40b4c9aa..d31e4295 100644
>> --- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
>> +++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
>> @@ -424,7 +424,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
>>       }
>>
>>       if (ctx->ztso) {
>> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>> +        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
>>       }
>>
>>       return out;
>> @@ -485,7 +485,7 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
>>       TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
>>
>>       if (ctx->ztso) {
>> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>> +        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
>>       }
>>
>>       tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
>> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
>> index a22e2cae..8c21ab87 100644
>> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
>> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
>> @@ -731,7 +731,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>>        * around the loop.
>>        */
>>       if (is_store && s->ztso) {
>> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>> +        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
>>       }
>>
>>       mark_vs_dirty(s);
>> @@ -739,7 +739,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>>       fn(dest, mask, base, tcg_env, desc);
>>
>>       if (!is_store && s->ztso) {
>> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>> +        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
>>       }
>>
>>       finalize_rvv_inst(s);

