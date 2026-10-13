Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7464DCC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfSW-0003mq-VO; Tue, 13 Oct 2026 12:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1xGfSM-0003ln-1V
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:34:27 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1xGfSK-0006YU-4B
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:34:25 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so1613946a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20251104.gappssmtp.com; s=20251104; t=1791909262; x=1792514062;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:to
 :from:cc:in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pGc7XlSnnNv/Gs4VKCMJx1WcLuobkHR4JjSxUzcHqhk=;
 b=gNzp2/851m9DfpG30iPjWLBbxRv2xWuSaJjeSDToex0unmuVtunFSFDaMYvJlYFCXe
 wHKeRAUAvU/Ki962bdm/whRdGm7qNBeGIfpAu85o1a7GQrJXgQIdhu09gdOASc/W4E0C
 AGaUh9h6o9HYdKc6CHcxMmDzC0YKYhVS+FBOZ6w3iXp3SNa/YiH/uFV+1tbU7g5Ysf4m
 2SVi5nwk7EUskh306Ln1x6zRiz6xxpvlsyWeLqayw6+Fieo5bQFgNsjPgMdKyWtx5+cD
 WNfDNLbuMPhjYEwI7pX72xw1tIjRaiODz3I2BscofVC26Ecg89CjlFJM6F/jFAcClx5Z
 82OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791909262; x=1792514062;
 h=content-transfer-encoding:content-type:mime-version:message-id:to
 :from:cc:in-reply-to:subject:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pGc7XlSnnNv/Gs4VKCMJx1WcLuobkHR4JjSxUzcHqhk=;
 b=cKiqSCEdBPObruTeae3xF7BFj+4oABoQcmWSeKhHi6VSplLDXuUSz5NDU5aK1qeU6J
 ae39LN+Un2g00XzWEi9hyl+m5qy1Fu2ASFlpHo9ZbybE4hBJEZePpbw6zfTnuljnGa70
 voxdNcUsNFEN2kOVE4iZIQoIVowdV4jrxCnNBFtKZepiZfLp0TF0383VMdY+UrXgcJUJ
 C1Fm8I6s1FNzqmFHNYbT3xmdriIAyaeMakd0LppTFcC5xOVdrufJ8rwQpeHhGC1ttRxL
 /9nHpO/t7mm4O74NveuTHyLu6jB0bgPdIy/CFpW1Awird+LQhwH7KQuY3to08khH2Uxb
 GWew==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1twdw2jW4I8GZw46lPrVv66C2juiXf+/uhSrJMR6RdtN8bSdx3b3Wz7/XjI7uOnw0pjFd5oakiKB/@nongnu.org
X-Gm-Message-State: AFq9FYJmIKPQllkCzel8DeSEvEa91X8GOKLItf9xRxcssEY4JFRFxgU7
 Dnu9OaaWMUunkJmWDDeInYuSJbY4lYjchtI4/CXtGadWZJcXft+v+2yTGg0iBrLpoLQ=
X-Gm-Gg: AYBFou3WMJ0TDTlFDStEzUT8wWzCaUzazl07svs/MrQc9rfLo92jVBebE0kHblqj7IH
 2myqZ9qFEKSMvAroWq8EQ9dagkOaeeewVd+rdtKDdC1D7+VkD9rmp5hy8NgeKv2Vaznp2h1dV2H
 OORW0lOqweTXP68jZVtEtsj+Hry97//g0QsEpOaAvzCg7kuUJ2oyJGqy9X7bIQKIO2YTgQ+cR60
 hF7TEeZMDHC6bHb09a3kswIQZbZQDbnXZnuvCqPNLFUU3X/muNiyZxhW0gbt2Z3983LuXEZaYna
 fgvMYr1CtZoiRK9veVzKXtqRp5gdmDusGxF+fSU8p+xzX4y2niPgOe6B36vbFoTvV3603RbnUJw
 djO24aHMzaiYwR6fJNw6hOVJ+RMn7bPABR2D6t2rRcGRbBITgyMuqTawQ13sC9jptY8DpF+szuP
 kfbl/Udq5GQV699UgV7xxe+9huCzt3sQOkI6nParCtV6IsnkldJpaTlFgZfj8klKrzxPFc+bBui
 2RvZ7sKwDbwnz6gVr2Jnf1EjOOB8g==
X-Received: by 2002:a17:90a:2cc5:b0:3ab:a188:b896 with SMTP id
 98e67ed59e1d1-3aba188be47mr4751344a91.10.1791909261507; 
 Tue, 13 Oct 2026 09:34:21 -0700 (PDT)
Received: from localhost ([2001:5a8:4687:d600:60f5:5a60:a2fe:eaae])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f2b9769sm346860a91.15.2026.10.13.09.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 09:34:20 -0700 (PDT)
Date: Tue, 13 Oct 2026 09:34:20 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Oct 2026 09:34:19 PDT (-0700)
Subject: Re: [PATCH] target/riscv: Use TSO barriers instead of full barriers
 for Ztso
In-Reply-To: <f2600f08-73a0-4259-9175-7f644997c366@oss.qualcomm.com>
CC: rick@sloservers.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: daniel.barboza@oss.qualcomm.com
Message-ID: <mhng-0D33ADEF-8CD5-47F7-B852-CD30B674B87B@Palmers-Mini.rwc.dabbelt.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=palmer@dabbelt.com; helo=mail-pj1-x1029.google.com
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

On Tue, 13 Oct 2026 09:00:41 PDT (-0700), daniel.barboza@oss.qualcomm.com wrote:
>
>
> On 10/13/2026 10:14 AM, Palmer Dabbelt wrote:
>> On Tue, 13 Oct 2026 04:57:49 PDT (-0700), daniel.barboza@oss.qualcomm.com wrote:
>>>
>>>
>>> On 10/2/2026 10:47 AM, Rick Richard wrote:
>>>> With Ztso, plain loads and stores follow RVTSO, but the barriers
>>>> around them use TCG_MO_ALL.  That also orders a store before a later
>>>> load, which TSO doesn't require, and is expensive: on x86 hosts it
>>>> adds a locked instruction around every load and store in a
>>>> multi-threaded guest.
>>
>> Thanks.  I'm not quite sure why I had TCG_MO_ALL in there, I think maybe I just misread the TCG_MO_* vs TCG_BAR_* blurb?
>>
>> Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
>>
>>>> The barrier after a load now only keeps later loads and stores
>>>> behind it, and the barrier before a store only keeps earlier loads
>>>> and stores ahead of it.  That is all TSO needs.
>>>>
>>>
>>> Fixes: 09c4e88759 ("RISC-V: Add support for Ztso")
>>>
>>>> Signed-off-by: Rick Richard <rick@sloservers.com>
>>>> ---
>>>
>>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>>
>>>> I found this while looking into why riscv64 guests were so much
>>>> slower than aarch64 ones under bsd-user on FreeBSD.  The default -cpu
>>>> max enables Ztso, and turning it off with ztso=false accounted for
>>>> most of the difference.
>>
>> Maybe we shouldn't default to Ztso, or at least not default to Ztso on host systems that themselves aren't TSO?
>
> I vote to disable it in the 'max' CPU.  Changing the mem model from RVWMO to
> RVTSO seems like a decision users have to make in the command line, not
> something we decided to do because this particular CPU model must have all
> possible extensions enabled.
>
> In theory we could enable it depending on the host affinity with TSO, but I'd
> rather not create a precedent where a TCG CPU model delivers different
> extensions based on host capabilities.  We have enough of that in the KVM
> driver.

Ya, that seems reasonable.  I think the only issue is that TSO hosts 
will end up defacto TSO in the guest -- or at least I think they will, 
IIUC that is basicallly how things used to work because TCG didn't do 
any interesting memory reordering at compile time and thus the TSO-ness 
of the host essentially just bled through to the guest.

>
>
> Thanks,
> Daniel
>
>>
>>>> On an x86-64 host the patch made xz almost four times faster and cut
>>>> the time of a clang compile by about 30%, the same as running with
>>>> ztso=false.  The output didn't change.
>>>>
>>>> I also tested it on a Raspberry Pi 3B+, which is arm64 and doesn't
>>>> give TSO ordering in hardware, to make sure the weaker barriers still
>>>> hold up there.  Everything ran correctly, and xz was about 12% faster.
>>>>
>>>>   target/riscv/tcg/insn_trans/trans_rvi.c.inc | 4 ++--
>>>>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 4 ++--
>>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
>>>> index 40b4c9aa..d31e4295 100644
>>>> --- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
>>>> +++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
>>>> @@ -424,7 +424,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
>>>>       }
>>>>
>>>>       if (ctx->ztso) {
>>>> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>>>> +        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
>>>>       }
>>>>
>>>>       return out;
>>>> @@ -485,7 +485,7 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
>>>>       TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
>>>>
>>>>       if (ctx->ztso) {
>>>> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>>>> +        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
>>>>       }
>>>>
>>>>       tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
>>>> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
>>>> index a22e2cae..8c21ab87 100644
>>>> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
>>>> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
>>>> @@ -731,7 +731,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>>>>        * around the loop.
>>>>        */
>>>>       if (is_store && s->ztso) {
>>>> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>>>> +        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
>>>>       }
>>>>
>>>>       mark_vs_dirty(s);
>>>> @@ -739,7 +739,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>>>>       fn(dest, mask, base, tcg_env, desc);
>>>>
>>>>       if (!is_store && s->ztso) {
>>>> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>>>> +        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
>>>>       }
>>>>
>>>>       finalize_rvv_inst(s);

