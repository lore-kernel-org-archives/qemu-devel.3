Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30578D13C1D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 14:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkNIU-0004RU-OL; Mon, 26 Jan 2026 09:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkNI4-0004NT-Mt
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 09:10:07 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vkNI0-0006fy-4k
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 09:10:02 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-29f2676bb21so46161305ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 06:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769436599; x=1770041399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8U6Dkda0Ul9/ZBFIwhfzFKD1FgjP5iPQZyF3QW2j3BU=;
 b=NOfN3abBqipODklAx8WvqLrW0vCRad3Y9Sca1DVCGRXeM53NPf/kK69j85u+6AacBP
 insIpbf8PFZCXm4+yqTX1utXpRCOtVfjIQ+kHjeHrh68yDx1AZpirDLcLt+Q3SdzMku/
 igm6cKrHv+9S7ZyvOfvpSv5djfuE3jSfgBEyIGEzbxCqi2y77M+uDi+/PzGcGiuXeofg
 SEhMsOYFUs8uKrhDWpUayE1z3eIiumH/w4FYuOE6g2h9KNZUe3SD5yrOpkBiAv264Och
 l163NMggjNxTfMnn4rPGN2kAQfQ6xzIb4kmrD0uKYp4y2AXZqA7yYg7Bx56W6Xg2iml2
 og3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769436599; x=1770041399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8U6Dkda0Ul9/ZBFIwhfzFKD1FgjP5iPQZyF3QW2j3BU=;
 b=qPVAjUkpnERxnRpK3IrdHtAbkrAQwr2cs3ueWz0ZYUxT99FgqstAwWPAydpNdw7/1z
 6ll/zNCRf3T1a8U0RdhwI13KurhZiOeFpE1MrPeqsz2GBKoYN6ej/30xWFoixaY+J+V5
 Okfwfy7/WOgAPgbIIaH1jv0xqVSc2wFIYVVnt9aFiCwmUKBSaYLjHfgigAZQ03uAV/Ya
 hIG6dCJgM49d1qs5DZHkdEiMp6eLMVepgM6rBWnuLuyuGas7yU9KsGix64wFdH5QYmJW
 P+wWPcBQwZDO06k8bre7oUhyEldyICJg/n3HZi+s5aogwVPejh92sy5iMHB5+QtFG1hg
 1xUA==
X-Gm-Message-State: AOJu0YwKHU4a8T4yuANYsvZHV5pK1Xlj4tGtAxYPq4EtHNk2v5asRvoi
 tHoU0ZfwAc+i2KkFW2G5QRuSCKbgr5nh8tCv5Qt6Jc6AtCisnPmTnbCJ
X-Gm-Gg: AZuq6aKBciGwcqskkpWaX4X/vjeGz3b/Dunq7q6q6ShoQHsU0wBz5niNgLjK7fSghTe
 hvBXvn4Fj+x6DksPE0fYYbm/Y88DMzs3KNZd5Np7rPYP12bkUSIw9SXNG9VtnoOUcfBKITvWrmk
 AmfP966X3aHRh5OJc0RDVfT51GFixTxx4xq0SWwO77zVrZI6/T4giAaXt9K6SwOA1eFtJaZD7et
 C4oSc5v5qSKTVofOOC9aiSBnuC06wHudCWPGaG3f6Axw0ExyZTbuAFkNBHWgO/HaEL2XblhxKSz
 kdd39uTMhGhrFXjWRx2kTrZuI5bNZP8wPZBE80dV+BYpPTdXK/aI70pWaO3yef+ax795eqj9pga
 jOKmrLmX/AU+A/EnE8OeL7WK8nNJBfDetHqvp0LX+clNsiBLQeCAzNiEmNd/P77Dgz0gdjvvV4z
 zv2rfxMJ68VK1/5fj4dcO8np8sFaz6Hdl40o19BWpfwzjsfb2SIkISFHOigM6TRfdYpqA=
X-Received: by 2002:a17:902:d4c2:b0:2a0:8358:88f8 with SMTP id
 d9443c01a7336-2a845285967mr33538095ad.22.1769436598434; 
 Mon, 26 Jan 2026 06:09:58 -0800 (PST)
Received: from [192.168.1.4] ([183.195.21.199])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fb0262sm90713285ad.70.2026.01.26.06.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 06:09:57 -0800 (PST)
Message-ID: <e0f0e63d-3aca-42b4-8ce8-40609191f918@gmail.com>
Date: Mon, 26 Jan 2026 22:09:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/7] target/riscv: add sdext debug CSRs state
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn
References: <cover.1768892407.git.chao.liu.zevorn@gmail.com>
 <329a6d5fde74c5cce615053e7f4a0e1c48a27a1b.1768892407.git.chao.liu.zevorn@gmail.com>
 <f6019bbf-1860-4de2-8af6-fdb17cc56139@ventanamicro.com>
 <CAGL8uCU96wSWSX+Hb_JY8Nt5kRBEFDO1JoGvpiPs60+qXQZCpQ@mail.gmail.com>
 <c2d7e4ba-1acd-439b-b420-7f0d97419f62@ventanamicro.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <c2d7e4ba-1acd-439b-b420-7f0d97419f62@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


On 1/26/2026 10:01 PM, Daniel Henrique Barboza wrote:
>
>
> On 1/26/2026 10:16 AM, Chao Liu wrote:
>> __
>>
>>
>> Hi Daniel,
>>
>> On 1/26/2026 8:47 PM, Daniel Henrique Barboza wrote:
>>> Hi Chao,
>>>
>>> I wasn't able to apply this patch. Applied all Max's series first, then tried to apply yours.
>>>
>>> The conflict in target/riscv/cpu.c seems to indicate you're basing the patches on top of something that we don't have upstream:
>>>
>>> diff a/target/riscv/cpu.c b/target/riscv/cpu.c    (rejected hunks)
>>> @@ -788,6 +789,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>>>      set_ocp_fp8_same_canonical_nan(true, &env->fp_status);
>>>      set_ocp_fp8e5m2_no_signal_nan(true, &env->fp_status);
>>>      env->vill = true;
>>> +    env->debug_mode = false;
>>> +    env->dcsr = DCSR_DEBUGVER(4);
>>> +    env->dpc = 0;
>>> +    env->dscratch[0] = 0;
>>> +    env->dscratch[1] = 0;
>>>
>>>  #ifndef CONFIG_USER_ONLY
>>>      if (cpu->cfg.ext_sdtrig) {
>>>
>>>
>>> The 'set_ocp_fp8*' lines over here can't be find anywhere else in QEMU, so I suppose you're basing the patches on top of something else.
>>>
>>> If you could base the patches on top of alistair/riscv-to-apply.next tree, plus Max's patches, that would be great.
>>>
>> This series is based on the master commit: 06a24591: "disas/riscv: Add support of Zvfofp4min extension".
>> Max's patches have been merged into the master branch.
>
> I'm afraid there's some confusion ...
>
>
> $ git checkout master
> Already on 'master'
> Your branch is up to date with 'origin/master'.
> $ git pull
> Already up to date.
> $ git log --grep="Zvfofp4min"
> $
>
>
> You can also check out here:
>
> https://gitlab.com/qemu-project/qemu/-/commits/master?search=Zvfofp4min
>
>
> There's no "Zvfofp4min" in QEMU master. In fact, if you're referring to
> these patches:
>
> [PATCH 00/18] Add OCP FP8/FP4 and RISC-V Zvfofp8min/Zvfofp4min extension support
>
> They're still under review. Thanks,
>
> Daniel
>
>
Thanks to Daniel for pointing this out. I will rebase this series of sdext patches on the
alistair/riscv-to-apply.next tree and Max’s patches for resubmission.

Thanks,
Chao
>> Thanks,
>> Chao
>>>
>>>
>>> On 1/20/2026 5:23 AM, Chao Liu wrote:
>>>> RISC-V Debug Specification:
>>>> https://github.com/riscv/riscv-debug-spec/releases/tag/1.0 <https:// github.com/riscv/riscv-debug-spec/releases/tag/1.0>
>>>>
>>>> Add architectural state for Sdext Debug Mode: debug_mode, dcsr, dpc
>>>> and dscratch0/1. Wire up CSR access for dcsr/dpc/dscratch and gate
>>>> them to Debug Mode (or host debugger access).
>>>>
>>>> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com> <mailto:chao.liu.zevorn@gmail.com>
>>>> ---
>>>>   target/riscv/cpu.c                |   9 +++
>>>>   target/riscv/cpu.h                |   4 +
>>>>   target/riscv/cpu_bits.h           |  33 ++++++++
>>>>   target/riscv/cpu_cfg_fields.h.inc |   1 +
>>>>   target/riscv/csr.c                | 126 ++++++++++++++++++++++++++++++
>>>>   target/riscv/machine.c            |  20 +++++
>>>>   6 files changed, 193 insertions(+)
>>>>
>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>> index f1b977f0ee..bd6cff33cf 100644
>>>> --- a/target/riscv/cpu.c
>>>> +++ b/target/riscv/cpu.c
>>>> @@ -211,6 +211,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>>>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>>>>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>>>>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>>>> +    ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
>>>>       ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>>>>       ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
>>>>       ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
>>>> @@ -788,6 +789,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>>>>       set_ocp_fp8_same_canonical_nan(true, &env->fp_status);
>>>>       set_ocp_fp8e5m2_no_signal_nan(true, &env->fp_status);
>>>>       env->vill = true;
>>>> +    env->debug_mode = false;
>>>> +    env->dcsr = DCSR_DEBUGVER(4);
>>>> +    env->dpc = 0;
>>>> +    env->dscratch[0] = 0;
>>>> +    env->dscratch[1] = 0;
>>>>     #ifndef CONFIG_USER_ONLY
>>>>       if (cpu->cfg.ext_sdtrig) {
>>>> @@ -1140,6 +1146,9 @@ static void riscv_cpu_init(Object *obj)
>>>>        */
>>>>       cpu->cfg.ext_sdtrig = true;
>>>>   +    /* sdext is not fully implemented, so it is disabled by default. */
>>>> +    cpu->cfg.ext_sdext = false;
>>>> +
>>>>       if (mcc->def->profile) {
>>>>           mcc->def->profile->enabled = true;
>>>>       }
>>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>>> index 4c0676ed53..2a265faae5 100644
>>>> --- a/target/riscv/cpu.h
>>>> +++ b/target/riscv/cpu.h
>>>> @@ -476,6 +476,10 @@ struct CPUArchState {
>>>>         /* True if in debugger mode.  */
>>>>       bool debugger;
>>>> +    bool debug_mode;
>>>> +    target_ulong dcsr;
>>>> +    target_ulong dpc;
>>>> +    target_ulong dscratch[2];
>>>>         uint64_t mstateen[SMSTATEEN_MAX_COUNT];
>>>>       uint64_t hstateen[SMSTATEEN_MAX_COUNT];
>>>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>>>> index b62dd82fe7..bb59f7ff56 100644
>>>> --- a/target/riscv/cpu_bits.h
>>>> +++ b/target/riscv/cpu_bits.h
>>>> @@ -467,6 +467,39 @@
>>>>   #define CSR_DCSR            0x7b0
>>>>   #define CSR_DPC             0x7b1
>>>>   #define CSR_DSCRATCH        0x7b2
>>>> +#define CSR_DSCRATCH1       0x7b3
>>>> +
>>>> +/* DCSR fields */
>>>> +#define DCSR_XDEBUGVER_SHIFT    28
>>>> +#define DCSR_XDEBUGVER_MASK     (0xfu << DCSR_XDEBUGVER_SHIFT)
>>>> +#define DCSR_DEBUGVER(val)      ((target_ulong)(val) << DCSR_XDEBUGVER_SHIFT)
>>>> +#define DCSR_EXTCAUSE_SHIFT     24
>>>> +#define DCSR_EXTCAUSE_MASK      (0x7u << DCSR_EXTCAUSE_SHIFT)
>>>> +#define DCSR_CETRIG             BIT(19)
>>>> +#define DCSR_PELP               BIT(18)
>>>> +#define DCSR_EBREAKVS           BIT(17)
>>>> +#define DCSR_EBREAKVU           BIT(16)
>>>> +#define DCSR_EBREAKM            BIT(15)
>>>> +#define DCSR_EBREAKS            BIT(13)
>>>> +#define DCSR_EBREAKU            BIT(12)
>>>> +#define DCSR_STEPIE             BIT(11)
>>>> +#define DCSR_STOPCOUNT          BIT(10)
>>>> +#define DCSR_STOPTIME           BIT(9)
>>>> +#define DCSR_CAUSE_SHIFT        6
>>>> +#define DCSR_CAUSE_MASK         (0x7u << DCSR_CAUSE_SHIFT)
>>>> +#define DCSR_V                  BIT(5)
>>>> +#define DCSR_MPRVEN             BIT(4)
>>>> +#define DCSR_NMIP               BIT(3)
>>>> +#define DCSR_STEP               BIT(2)
>>>> +#define DCSR_PRV_MASK           0x3u
>>>> +
>>>> +#define DCSR_CAUSE_EBREAK       1
>>>> +#define DCSR_CAUSE_TRIGGER      2
>>>> +#define DCSR_CAUSE_HALTREQ      3
>>>> +#define DCSR_CAUSE_STEP         4
>>>> +#define DCSR_CAUSE_RESET        5
>>>> +#define DCSR_CAUSE_GROUP        6
>>>> +#define DCSR_CAUSE_OTHER        7
>>>>     /* Performance Counters */
>>>>   #define CSR_MHPMCOUNTER3    0xb03
>>>> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/ cpu_cfg_fields.h.inc
>>>> index a8c133d663..99b5529161 100644
>>>> --- a/target/riscv/cpu_cfg_fields.h.inc
>>>> +++ b/target/riscv/cpu_cfg_fields.h.inc
>>>> @@ -46,6 +46,7 @@ BOOL_FIELD(ext_zilsd)
>>>>   BOOL_FIELD(ext_zimop)
>>>>   BOOL_FIELD(ext_zcmop)
>>>>   BOOL_FIELD(ext_ztso)
>>>> +BOOL_FIELD(ext_sdext)
>>>>   BOOL_FIELD(ext_sdtrig)
>>>>   BOOL_FIELD(ext_smstateen)
>>>>   BOOL_FIELD(ext_sstc)
>>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>>> index 870fad87ac..3e38c943e0 100644
>>>> --- a/target/riscv/csr.c
>>>> +++ b/target/riscv/csr.c
>>>> @@ -3136,6 +3136,126 @@ static RISCVException write_mtval(CPURISCVState *env, int csrno,
>>>>       return RISCV_EXCP_NONE;
>>>>   }
>>>>   +#if !defined(CONFIG_USER_ONLY)
>>>> +static RISCVException sdext(CPURISCVState *env, int csrno)
>>>> +{
>>>> +    if (!riscv_cpu_cfg(env)->ext_sdext) {
>>>> +        return RISCV_EXCP_ILLEGAL_INST;
>>>> +    }
>>>> +
>>>> +    if (!env->debug_mode && !env->debugger) {
>>>> +        return RISCV_EXCP_ILLEGAL_INST;
>>>> +    }
>>>> +
>>>> +    return RISCV_EXCP_NONE;
>>>> +}
>>>> +
>>>> +static target_ulong dcsr_visible_mask(CPURISCVState *env)
>>>> +{
>>>> +    target_ulong mask = (target_ulong)-1;
>>>> +    RISCVCPU *cpu = env_archcpu(env);
>>>> +
>>>> +    if (!riscv_has_ext(env, RVH)) {
>>>> +        mask &= ~(DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V);
>>>> +    }
>>>> +    if (!riscv_has_ext(env, RVS)) {
>>>> +        mask &= ~DCSR_EBREAKS;
>>>> +    }
>>>> +    if (!riscv_has_ext(env, RVU)) {
>>>> +        mask &= ~DCSR_EBREAKU;
>>>> +    }
>>>> +    if (!cpu->cfg.ext_zicfilp) {
>>>> +        mask &= ~DCSR_PELP;
>>>> +    }
>>>> +    if (!cpu->cfg.ext_smdbltrp) {
>>>> +        mask &= ~DCSR_CETRIG;
>>>> +    }
>>>> +
>>>> +    return mask;
>>>> +}
>>>> +
>>>> +static RISCVException read_dcsr(CPURISCVState *env, int csrno,
>>>> +                                target_ulong *val)
>>>> +{
>>>> +    *val = env->dcsr & dcsr_visible_mask(env);
>>>> +    return RISCV_EXCP_NONE;
>>>> +}
>>>> +
>>>> +static target_ulong dcsr_writable_mask(CPURISCVState *env)
>>>> +{
>>>> +    target_ulong mask = DCSR_EBREAKM | DCSR_EBREAKS | DCSR_EBREAKU |
>>>> +                        DCSR_STEPIE | DCSR_STOPCOUNT | DCSR_STOPTIME |
>>>> +                        DCSR_STEP | DCSR_PRV_MASK;
>>>> +    RISCVCPU *cpu = env_archcpu(env);
>>>> +
>>>> +    mask |= DCSR_MPRVEN;
>>>> +
>>>> +    if (riscv_has_ext(env, RVH)) {
>>>> +        mask |= DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V;
>>>> +    }
>>>> +    if (riscv_has_ext(env, RVS)) {
>>>> +        mask |= DCSR_EBREAKS;
>>>> +    }
>>>> +    if (riscv_has_ext(env, RVU)) {
>>>> +        mask |= DCSR_EBREAKU;
>>>> +    }
>>>> +    if (cpu->cfg.ext_zicfilp) {
>>>> +        mask |= DCSR_PELP;
>>>> +    }
>>>> +    if (cpu->cfg.ext_smdbltrp) {
>>>> +        mask |= DCSR_CETRIG;
>>>> +    }
>>>> +
>>>> +    return mask;
>>>> +}
>>>> +
>>>> +static RISCVException write_dcsr(CPURISCVState *env, int csrno,
>>>> +                                 target_ulong val, uintptr_t ra)
>>>> +{
>>>> +    target_ulong mask = dcsr_writable_mask(env);
>>>> +    target_ulong new_val = env->dcsr;
>>>> +
>>>> +    new_val &= ~mask;
>>>> +    new_val |= val & mask;
>>>> +    new_val &= ~DCSR_XDEBUGVER_MASK;
>>>> +    new_val |= DCSR_DEBUGVER(4);
>>>> +    env->dcsr = new_val;
>>>> +    return RISCV_EXCP_NONE;
>>>> +}
>>>> +
>>>> +static RISCVException read_dpc(CPURISCVState *env, int csrno,
>>>> +                               target_ulong *val)
>>>> +{
>>>> +    *val = env->dpc & get_xepc_mask(env);
>>>> +    return RISCV_EXCP_NONE;
>>>> +}
>>>> +
>>>> +static RISCVException write_dpc(CPURISCVState *env, int csrno,
>>>> +                                target_ulong val, uintptr_t ra)
>>>> +{
>>>> +    env->dpc = val & get_xepc_mask(env);
>>>> +    return RISCV_EXCP_NONE;
>>>> +}
>>>> +
>>>> +static RISCVException read_dscratch(CPURISCVState *env, int csrno,
>>>> +                                    target_ulong *val)
>>>> +{
>>>> +    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
>>>> +
>>>> +    *val = env->dscratch[index];
>>>> +    return RISCV_EXCP_NONE;
>>>> +}
>>>> +
>>>> +static RISCVException write_dscratch(CPURISCVState *env, int csrno,
>>>> +                                     target_ulong val, uintptr_t ra)
>>>> +{
>>>> +    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
>>>> +
>>>> +    env->dscratch[index] = val;
>>>> +    return RISCV_EXCP_NONE;
>>>> +}
>>>> +#endif /* !CONFIG_USER_ONLY */
>>>> +
>>>>   /* Execution environment configuration setup */
>>>>   static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
>>>>                                      target_ulong *val)
>>>> @@ -6297,6 +6417,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>>>>       [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata, write_tdata    },
>>>>       [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo, write_ignore   },
>>>>       [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
>>>> +#if !defined(CONFIG_USER_ONLY)
>>>> +    [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr, write_dcsr },
>>>> +    [CSR_DPC]       =  { "dpc",       sdext, read_dpc, write_dpc },
>>>> +    [CSR_DSCRATCH]  =  { "dscratch0", sdext, read_dscratch, write_dscratch },
>>>> +    [CSR_DSCRATCH1] =  { "dscratch1", sdext, read_dscratch, write_dscratch },
>>>> +#endif
>>>>         [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl    },
>>>>       [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xctrctl    },
>>>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>>>> index 62c51c8033..52264cf047 100644
>>>> --- a/target/riscv/machine.c
>>>> +++ b/target/riscv/machine.c
>>>> @@ -248,6 +248,25 @@ static const VMStateDescription vmstate_sdtrig = {
>>>>           VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
>>>>           VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
>>>>           VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
>>>> +        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
>>>> +        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
>>>> +        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
>>>> +        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    }
>>>> +};
>>>> +
>>>> +static const VMStateDescription vmstate_sdext = {
>>>> +    .name = "cpu/sdext",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .needed = sdtrig_needed,
>>>> +    .post_load = sdtrig_post_load,
>>>> +    .fields = (const VMStateField[]) {
>>>> +        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
>>>> +        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
>>>> +        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
>>>> +        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
>>>>           VMSTATE_END_OF_LIST()
>>>>       }
>>>>   };
>>>> @@ -499,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>>>>           &vmstate_ctr,
>>>>           &vmstate_sstc,
>>>>           &vmstate_sdtrig,
>>>> +        &vmstate_sdext,
>>>>           NULL
>>>>       }
>>>>   };
>>>
>

