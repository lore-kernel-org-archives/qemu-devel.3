Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC1CCAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 02:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz3xO-0007LM-65; Wed, 17 Sep 2025 22:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1uz3xM-0007Gw-8l; Wed, 17 Sep 2025 22:01:08 -0400
Received: from [115.124.30.113] (helo=out30-113.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1uz3xE-0003c0-MG; Wed, 17 Sep 2025 22:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1758160835; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=SqVkt+MxUyHpK1gVpBDNXfdiWepK59egFjxoPeefLBU=;
 b=Mp7CAAF/daxgiE+AZNZeSVpGcrNP2RjQPJshA0LoXgD2dRO06VTRpFOFhqbcREAJrovSGhxCkrVE+Ahb3cFLqARj9sU8bUvOgHvi3RfspMyJdQZY8mH1D5cDMSm1F8r1TKZOm01qs9jcuIjiZ7+pWOU+dgjD0M8aWwuMZbslgyQ=
Received: from 30.166.64.213(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WoE4wKh_1758160833 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 18 Sep 2025 10:00:33 +0800
Content-Type: multipart/alternative;
 boundary="------------yDyiiodTsdftFd1ik6osoJF0"
Message-ID: <a1fa9371-bd5a-49da-97db-86846ec597e2@linux.alibaba.com>
Date: Thu, 18 Sep 2025 10:00:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] target/riscv: Add basic definitions and CSRs for
 SMMPT
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
References: <20250909132533.32205-1-zhiwei_liu@linux.alibaba.com>
 <20250909132533.32205-2-zhiwei_liu@linux.alibaba.com>
 <71565bcc-9d7a-4fbc-be4f-aa77e8679831@ventanamicro.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <71565bcc-9d7a-4fbc-be4f-aa77e8679831@ventanamicro.com>
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.113 (deferred)
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

This is a multi-part message in MIME format.
--------------yDyiiodTsdftFd1ik6osoJF0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/17/25 7:16 PM, Daniel Henrique Barboza wrote:
>
>
> On 9/9/25 10:25 AM, LIU Zhiwei wrote:
>> This patch lays the groundwork for the SMMPT (Supervisor Domains Access
>> Protection) extension by introducing its fundamental components.
>>
>> It adds:
>> - New CPU configuration flags, `ext_smmpt` and `ext_smsdid`, to enable
>>    the extension.
>> - Bit-field definitions for the `mmpt` CSR in `cpu_bits.h`.
>> - The `mmpt` and `msdcfg` CSR numbers and their read/write handlers in
>>    `csr.c`.
>> - New fields in `CPUArchState` to store the state of these new CSRs.
>> - A new translation failure reason `TRANSLATE_MPT_FAIL`.
>>
>> This provides the necessary infrastructure for the core MPT logic and
>> MMU integration that will follow.
>>
>> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
>> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
>>   target/riscv/cpu.h                |  9 +++-
>>   target/riscv/cpu_bits.h           | 27 ++++++++++
>>   target/riscv/cpu_cfg_fields.h.inc |  2 +
>>   target/riscv/csr.c                | 83 +++++++++++++++++++++++++++++++
>>   4 files changed, 120 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 4a862da615..fa7b804cb3 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -130,7 +130,8 @@ enum {
>>       TRANSLATE_SUCCESS,
>>       TRANSLATE_FAIL,
>>       TRANSLATE_PMP_FAIL,
>> -    TRANSLATE_G_STAGE_FAIL
>> +    TRANSLATE_G_STAGE_FAIL,
>> +    TRANSLATE_MPT_FAIL
>>   };
>>     /* Extension context status */
>> @@ -180,6 +181,7 @@ extern RISCVCPUImpliedExtsRule 
>> *riscv_multi_ext_implied_rules[];
>>   #if !defined(CONFIG_USER_ONLY)
>>   #include "pmp.h"
>>   #include "debug.h"
>> +#include "riscv_smmpt.h"
>>   #endif
>>     #define RV_VLEN_MAX 1024
>> @@ -486,6 +488,11 @@ struct CPUArchState {
>>       uint64_t hstateen[SMSTATEEN_MAX_COUNT];
>>       uint64_t sstateen[SMSTATEEN_MAX_COUNT];
>>       uint64_t henvcfg;
>> +    /* Smsdid */
>> +    uint32_t mptmode;
>> +    uint32_t sdid;
>> +    uint64_t mptppn;
>> +    uint32_t msdcfg;
>>   #endif
>>         /* Fields from here on are preserved across CPU reset. */
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index b62dd82fe7..c6a34863d1 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -1164,4 +1164,31 @@ typedef enum CTRType {
>>   #define MCONTEXT64 0x0000000000001FFFULL
>>   #define MCONTEXT32_HCONTEXT                0x0000007F
>>   #define MCONTEXT64_HCONTEXT 0x0000000000003FFFULL
>> +
>> +/* Smsdid */
>> +#define CSR_MMPT        0xbc0
>> +#define CSR_MSDCFG      0xbd1
>> +
>> +#define MMPT_MODE_MASK_32   0xC0000000
>> +#define MMPT_SDID_MASK_32   0x3F000000
>> +#define MMPT_PPN_MASK_32    0x003FFFFF
>> +
>> +#define MMPT_MODE_SHIFT_32  30
>> +#define MMPT_SDID_SHIFT_32  24
>> +
>> +#define MMPT_MODE_MASK_64   0xF000000000000000ULL
>> +#define MMPT_SDID_MASK_64   0x0FC0000000000000ULL
>> +#define MMPT_PPN_MASK_64    0x000FFFFFFFFFFFFFULL
>> +
>> +#define MPTE_L3_VALID       0x0000100000000000ULL
>> +#define MPTE_L3_RESERVED    0xFFFFE00000000000ULL
>> +
>> +#define MPTE_L2_RESERVED_64    0xFFFF800000000000ULL
>> +#define MPTE_L2_RESERVED_32    0xFE000000
>> +
>> +#define MPTE_L1_RESERVED_64    0xFFFFFFFF00000000ULL
>> +#define MPTE_L1_RESERVED_32    0xFFFF0000
>> +
>> +#define MMPT_MODE_SHIFT_64  60
>> +#define MMPT_SDID_SHIFT_64  54
>>   #endif
>> diff --git a/target/riscv/cpu_cfg_fields.h.inc 
>> b/target/riscv/cpu_cfg_fields.h.inc
>> index e2d116f0df..8c8a4ac236 100644
>> --- a/target/riscv/cpu_cfg_fields.h.inc
>> +++ b/target/riscv/cpu_cfg_fields.h.inc
>> @@ -60,6 +60,8 @@ BOOL_FIELD(ext_svpbmt)
>>   BOOL_FIELD(ext_svrsw60t59b)
>>   BOOL_FIELD(ext_svvptc)
>>   BOOL_FIELD(ext_svukte)
>> +BOOL_FIELD(ext_smmpt)
>> +BOOL_FIELD(ext_smsdid)
>>   BOOL_FIELD(ext_zdinx)
>>   BOOL_FIELD(ext_zaamo)
>>   BOOL_FIELD(ext_zacas)
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index 8842e07a73..77bc596ed3 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -793,6 +793,15 @@ static RISCVException rnmi(CPURISCVState *env, 
>> int csrno)
>>         return RISCV_EXCP_ILLEGAL_INST;
>>   }
>> +
>> +static RISCVException smsdid(CPURISCVState *env, int csrno)
>> +{
>> +    if (riscv_cpu_cfg(env)->ext_smsdid) {
>> +        return RISCV_EXCP_NONE;
>> +    }
>> +
>> +    return RISCV_EXCP_ILLEGAL_INST;
>> +}
>>   #endif
>>     static RISCVException seed(CPURISCVState *env, int csrno)
>> @@ -5470,6 +5479,77 @@ static RISCVException 
>> write_mnstatus(CPURISCVState *env, int csrno,
>>       return RISCV_EXCP_NONE;
>>   }
>>   +static RISCVException read_mmpt(CPURISCVState *env, int csrno,
>> +                                target_ulong *val)
>> +{
>> +    if (riscv_cpu_xlen(env) == 32) {
>> +        uint32_t value = 0;
>> +        value |= env->mptmode << MMPT_MODE_SHIFT_32;
>> +        value |= (env->sdid << MMPT_SDID_SHIFT_32) & MMPT_SDID_MASK_32;
>> +        value |= env->mptppn & MMPT_PPN_MASK_32;
>> +        *val = value;
>> +    } else if (riscv_cpu_xlen(env) == 64) {
>> +        uint64_t value_64 = 0;
>> +        uint32_t mode_value = env->mptmode;
>> +        /* mpt_mode_t convert to mmpt.mode value */
>> +        if (mode_value) {
>> +            mode_value -= SMMTT43 - SMMTT34;
>> +        }
>> +        value_64 |= (uint64_t)mode_value << MMPT_MODE_SHIFT_64;
>> +        value_64 |= ((uint64_t)env->sdid << MMPT_SDID_SHIFT_64)
>> +                    & MMPT_SDID_MASK_64;
>> +        value_64 |= (uint64_t)env->mptppn & MMPT_PPN_MASK_64;
>> +        *val = value_64;
>> +    } else {
>> +        return RISCV_EXCP_ILLEGAL_INST;
>> +    }
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static RISCVException write_mmpt(CPURISCVState *env, int csrno,
>> +                                 target_ulong val, uintptr_t ra)
>> +{
>> +    /* Fixme: if mode is bare, the remaining fields in mmpt must be 
>> zero */
>> +    if (riscv_cpu_xlen(env) == 32) {
>> +        /* Only write the legal value */
>> +        uint32_t mode_value = (val & MMPT_MODE_MASK_32) >> 
>> MMPT_MODE_SHIFT_32;
>> +        if (mode_value <= SMMTT34) {
>> +            env->mptmode = mode_value;
>> +        }
>> +        env->sdid = (val & MMPT_SDID_MASK_32) >> MMPT_SDID_SHIFT_32;
>> +        env->mptppn = val & MMPT_PPN_MASK_32;
>> +    } else if (riscv_cpu_xlen(env) == 64) {
>> +        uint32_t mode_value = (val & MMPT_MODE_MASK_64) >> 
>> MMPT_MODE_SHIFT_64;
>> +        /* check legal value */
>> +        if (mode_value < SMMTTMAX) {
>> +            /* convert to mpt_mode_t */
>> +            if (mode_value) {
>> +                mode_value += SMMTT43 - SMMTT34;
>> +            }
>> +            env->mptmode = mode_value;
>> +        }
>> +        env->sdid = (val & MMPT_SDID_MASK_64) >> MMPT_SDID_SHIFT_64;
>> +        env->mptppn = val & MMPT_PPN_MASK_64;
>> +    } else {
>> +        return RISCV_EXCP_ILLEGAL_INST;
>> +    }
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static RISCVException read_msdcfg(CPURISCVState *env, int csrno,
>> +                                   target_ulong *val)
>> +{
>> +    *val = env->msdcfg;
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>> +static RISCVException write_msdcfg(CPURISCVState *env, int csrno,
>> +                                    target_ulong val, uintptr_t ra)
>> +{
>> +    env->msdcfg = val;
>> +    return RISCV_EXCP_NONE;
>> +}
>> +
>>   #endif
>>     /* Crypto Extension */
>> @@ -6666,6 +6746,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>> write_mhpmcounterh                         },
>>       [CSR_SCOUNTOVF]      = { "scountovf", sscofpmf, read_scountovf,
>>                                .min_priv_ver = PRIV_VERSION_1_12_0 },
>> +    /* Supervisor Domain Identifier and Protection Registers */
>> +    [CSR_MMPT] =    { "mmpt",   smsdid,  read_mmpt, write_mmpt   },
>> +    [CSR_MSDCFG] =  { "msdcfg", smsdid,  read_msdcfg, write_msdcfg },
>
> I see that you added ext_smmpt but ended up not using in this patch. 
> Shouldn't
> read_mmpt and write_mmpt dependent on ext_smmpt?

Hi Daniel,

Great question—thanks for raising it.

From the straightforward reading of the spec, mmpt is part of the M-mode 
programming interface defined by Smsdid, not Smmpt. Quoting the spec: 
“Smsdid defines an interface to program the configuration for 
supervisor-domain-related extensions. The interface consists of M-mode 
CSRs msdcfg and mmpt.”

From another angle, we can mirror how satp relates to the MMU to get a 
cleaner design. As the privileged spec says, “When SXLEN=64, all satp 
encodings corresponding to MODE=Bare are reserved for future standard 
use.” Based on that analogy, a better approach is to let ext_smmpt 
constrain the legal mmpt settings:

  * Keep mmpt under ext_smsdid (CSR presence/decoding).
  * Make mmpt WARL: when ext_smmpt is absent, only MODE=Bare is legal
    and SDID remains readable/writable; writes to other fields are
    masked to zero and reads return zero.
  * When ext_smmpt is present, enable the full mmpt mode set and fields.

Concretely, I can:

  * Keep read_mmpt/write_mmpt gated by ext_smsdid, and
  * Add an access mask that depends on ext_smmpt as above (non-Bare
    modes are WARL-masked when ext_smmpt=0), with a comment referencing
    the spec.

If that sounds good, I’ll update this patch accordingly.
Thanks,
Zhiwei

>
>
> Thanks,
>
> Daniel
>
>>     #endif /* !CONFIG_USER_ONLY */
>>   };
>
--------------yDyiiodTsdftFd1ik6osoJF0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/17/25 7:16 PM, Daniel Henrique
      Barboza wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:71565bcc-9d7a-4fbc-be4f-aa77e8679831@ventanamicro.com">
      <br>
      <br>
      On 9/9/25 10:25 AM, LIU Zhiwei wrote:
      <br>
      <blockquote type="cite">This patch lays the groundwork for the
        SMMPT (Supervisor Domains Access
        <br>
        Protection) extension by introducing its fundamental components.
        <br>
        <br>
        It adds:
        <br>
        - New CPU configuration flags, `ext_smmpt` and `ext_smsdid`, to
        enable
        <br>
           the extension.
        <br>
        - Bit-field definitions for the `mmpt` CSR in `cpu_bits.h`.
        <br>
        - The `mmpt` and `msdcfg` CSR numbers and their read/write
        handlers in
        <br>
           `csr.c`.
        <br>
        - New fields in `CPUArchState` to store the state of these new
        CSRs.
        <br>
        - A new translation failure reason `TRANSLATE_MPT_FAIL`.
        <br>
        <br>
        This provides the necessary infrastructure for the core MPT
        logic and
        <br>
        MMU integration that will follow.
        <br>
        <br>
        Co-authored-by: Huang Tao <a class="moz-txt-link-rfc2396E" href="mailto:eric.huang@linux.alibaba.com">&lt;eric.huang@linux.alibaba.com&gt;</a>
        <br>
        Co-authored-by: TANG Tiancheng <a class="moz-txt-link-rfc2396E" href="mailto:lyndra@linux.alibaba.com">&lt;lyndra@linux.alibaba.com&gt;</a>
        <br>
        Signed-off-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a>
        <br>
        ---
        <br>
          target/riscv/cpu.h                |  9 +++-
        <br>
          target/riscv/cpu_bits.h           | 27 ++++++++++
        <br>
          target/riscv/cpu_cfg_fields.h.inc |  2 +
        <br>
          target/riscv/csr.c                | 83
        +++++++++++++++++++++++++++++++
        <br>
          4 files changed, 120 insertions(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
        <br>
        index 4a862da615..fa7b804cb3 100644
        <br>
        --- a/target/riscv/cpu.h
        <br>
        +++ b/target/riscv/cpu.h
        <br>
        @@ -130,7 +130,8 @@ enum {
        <br>
              TRANSLATE_SUCCESS,
        <br>
              TRANSLATE_FAIL,
        <br>
              TRANSLATE_PMP_FAIL,
        <br>
        -    TRANSLATE_G_STAGE_FAIL
        <br>
        +    TRANSLATE_G_STAGE_FAIL,
        <br>
        +    TRANSLATE_MPT_FAIL
        <br>
          };
        <br>
            /* Extension context status */
        <br>
        @@ -180,6 +181,7 @@ extern RISCVCPUImpliedExtsRule
        *riscv_multi_ext_implied_rules[];
        <br>
          #if !defined(CONFIG_USER_ONLY)
        <br>
          #include "pmp.h"
        <br>
          #include "debug.h"
        <br>
        +#include "riscv_smmpt.h"
        <br>
          #endif
        <br>
            #define RV_VLEN_MAX 1024
        <br>
        @@ -486,6 +488,11 @@ struct CPUArchState {
        <br>
              uint64_t hstateen[SMSTATEEN_MAX_COUNT];
        <br>
              uint64_t sstateen[SMSTATEEN_MAX_COUNT];
        <br>
              uint64_t henvcfg;
        <br>
        +    /* Smsdid */
        <br>
        +    uint32_t mptmode;
        <br>
        +    uint32_t sdid;
        <br>
        +    uint64_t mptppn;
        <br>
        +    uint32_t msdcfg;
        <br>
          #endif
        <br>
                /* Fields from here on are preserved across CPU reset.
        */
        <br>
        diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
        <br>
        index b62dd82fe7..c6a34863d1 100644
        <br>
        --- a/target/riscv/cpu_bits.h
        <br>
        +++ b/target/riscv/cpu_bits.h
        <br>
        @@ -1164,4 +1164,31 @@ typedef enum CTRType {
        <br>
          #define MCONTEXT64                        
        0x0000000000001FFFULL
        <br>
          #define MCONTEXT32_HCONTEXT                0x0000007F
        <br>
          #define MCONTEXT64_HCONTEXT               
        0x0000000000003FFFULL
        <br>
        +
        <br>
        +/* Smsdid */
        <br>
        +#define CSR_MMPT        0xbc0
        <br>
        +#define CSR_MSDCFG      0xbd1
        <br>
        +
        <br>
        +#define MMPT_MODE_MASK_32   0xC0000000
        <br>
        +#define MMPT_SDID_MASK_32   0x3F000000
        <br>
        +#define MMPT_PPN_MASK_32    0x003FFFFF
        <br>
        +
        <br>
        +#define MMPT_MODE_SHIFT_32  30
        <br>
        +#define MMPT_SDID_SHIFT_32  24
        <br>
        +
        <br>
        +#define MMPT_MODE_MASK_64   0xF000000000000000ULL
        <br>
        +#define MMPT_SDID_MASK_64   0x0FC0000000000000ULL
        <br>
        +#define MMPT_PPN_MASK_64    0x000FFFFFFFFFFFFFULL
        <br>
        +
        <br>
        +#define MPTE_L3_VALID       0x0000100000000000ULL
        <br>
        +#define MPTE_L3_RESERVED    0xFFFFE00000000000ULL
        <br>
        +
        <br>
        +#define MPTE_L2_RESERVED_64    0xFFFF800000000000ULL
        <br>
        +#define MPTE_L2_RESERVED_32    0xFE000000
        <br>
        +
        <br>
        +#define MPTE_L1_RESERVED_64    0xFFFFFFFF00000000ULL
        <br>
        +#define MPTE_L1_RESERVED_32    0xFFFF0000
        <br>
        +
        <br>
        +#define MMPT_MODE_SHIFT_64  60
        <br>
        +#define MMPT_SDID_SHIFT_64  54
        <br>
          #endif
        <br>
        diff --git a/target/riscv/cpu_cfg_fields.h.inc
        b/target/riscv/cpu_cfg_fields.h.inc
        <br>
        index e2d116f0df..8c8a4ac236 100644
        <br>
        --- a/target/riscv/cpu_cfg_fields.h.inc
        <br>
        +++ b/target/riscv/cpu_cfg_fields.h.inc
        <br>
        @@ -60,6 +60,8 @@ BOOL_FIELD(ext_svpbmt)
        <br>
          BOOL_FIELD(ext_svrsw60t59b)
        <br>
          BOOL_FIELD(ext_svvptc)
        <br>
          BOOL_FIELD(ext_svukte)
        <br>
        +BOOL_FIELD(ext_smmpt)
        <br>
        +BOOL_FIELD(ext_smsdid)
        <br>
          BOOL_FIELD(ext_zdinx)
        <br>
          BOOL_FIELD(ext_zaamo)
        <br>
          BOOL_FIELD(ext_zacas)
        <br>
        diff --git a/target/riscv/csr.c b/target/riscv/csr.c
        <br>
        index 8842e07a73..77bc596ed3 100644
        <br>
        --- a/target/riscv/csr.c
        <br>
        +++ b/target/riscv/csr.c
        <br>
        @@ -793,6 +793,15 @@ static RISCVException rnmi(CPURISCVState
        *env, int csrno)
        <br>
                return RISCV_EXCP_ILLEGAL_INST;
        <br>
          }
        <br>
        +
        <br>
        +static RISCVException smsdid(CPURISCVState *env, int csrno)
        <br>
        +{
        <br>
        +    if (riscv_cpu_cfg(env)-&gt;ext_smsdid) {
        <br>
        +        return RISCV_EXCP_NONE;
        <br>
        +    }
        <br>
        +
        <br>
        +    return RISCV_EXCP_ILLEGAL_INST;
        <br>
        +}
        <br>
          #endif
        <br>
            static RISCVException seed(CPURISCVState *env, int csrno)
        <br>
        @@ -5470,6 +5479,77 @@ static RISCVException
        write_mnstatus(CPURISCVState *env, int csrno,
        <br>
              return RISCV_EXCP_NONE;
        <br>
          }
        <br>
          +static RISCVException read_mmpt(CPURISCVState *env, int
        csrno,
        <br>
        +                                target_ulong *val)
        <br>
        +{
        <br>
        +    if (riscv_cpu_xlen(env) == 32) {
        <br>
        +        uint32_t value = 0;
        <br>
        +        value |= env-&gt;mptmode &lt;&lt; MMPT_MODE_SHIFT_32;
        <br>
        +        value |= (env-&gt;sdid &lt;&lt; MMPT_SDID_SHIFT_32)
        &amp; MMPT_SDID_MASK_32;
        <br>
        +        value |= env-&gt;mptppn &amp; MMPT_PPN_MASK_32;
        <br>
        +        *val = value;
        <br>
        +    } else if (riscv_cpu_xlen(env) == 64) {
        <br>
        +        uint64_t value_64 = 0;
        <br>
        +        uint32_t mode_value = env-&gt;mptmode;
        <br>
        +        /* mpt_mode_t convert to mmpt.mode value */
        <br>
        +        if (mode_value) {
        <br>
        +            mode_value -= SMMTT43 - SMMTT34;
        <br>
        +        }
        <br>
        +        value_64 |= (uint64_t)mode_value &lt;&lt;
        MMPT_MODE_SHIFT_64;
        <br>
        +        value_64 |= ((uint64_t)env-&gt;sdid &lt;&lt;
        MMPT_SDID_SHIFT_64)
        <br>
        +                    &amp; MMPT_SDID_MASK_64;
        <br>
        +        value_64 |= (uint64_t)env-&gt;mptppn &amp;
        MMPT_PPN_MASK_64;
        <br>
        +        *val = value_64;
        <br>
        +    } else {
        <br>
        +        return RISCV_EXCP_ILLEGAL_INST;
        <br>
        +    }
        <br>
        +    return RISCV_EXCP_NONE;
        <br>
        +}
        <br>
        +
        <br>
        +static RISCVException write_mmpt(CPURISCVState *env, int csrno,
        <br>
        +                                 target_ulong val, uintptr_t
        ra)
        <br>
        +{
        <br>
        +    /* Fixme: if mode is bare, the remaining fields in mmpt
        must be zero */
        <br>
        +    if (riscv_cpu_xlen(env) == 32) {
        <br>
        +        /* Only write the legal value */
        <br>
        +        uint32_t mode_value = (val &amp; MMPT_MODE_MASK_32)
        &gt;&gt; MMPT_MODE_SHIFT_32;
        <br>
        +        if (mode_value &lt;= SMMTT34) {
        <br>
        +            env-&gt;mptmode = mode_value;
        <br>
        +        }
        <br>
        +        env-&gt;sdid = (val &amp; MMPT_SDID_MASK_32) &gt;&gt;
        MMPT_SDID_SHIFT_32;
        <br>
        +        env-&gt;mptppn = val &amp; MMPT_PPN_MASK_32;
        <br>
        +    } else if (riscv_cpu_xlen(env) == 64) {
        <br>
        +        uint32_t mode_value = (val &amp; MMPT_MODE_MASK_64)
        &gt;&gt; MMPT_MODE_SHIFT_64;
        <br>
        +        /* check legal value */
        <br>
        +        if (mode_value &lt; SMMTTMAX) {
        <br>
        +            /* convert to mpt_mode_t */
        <br>
        +            if (mode_value) {
        <br>
        +                mode_value += SMMTT43 - SMMTT34;
        <br>
        +            }
        <br>
        +            env-&gt;mptmode = mode_value;
        <br>
        +        }
        <br>
        +        env-&gt;sdid = (val &amp; MMPT_SDID_MASK_64) &gt;&gt;
        MMPT_SDID_SHIFT_64;
        <br>
        +        env-&gt;mptppn = val &amp; MMPT_PPN_MASK_64;
        <br>
        +    } else {
        <br>
        +        return RISCV_EXCP_ILLEGAL_INST;
        <br>
        +    }
        <br>
        +    return RISCV_EXCP_NONE;
        <br>
        +}
        <br>
        +
        <br>
        +static RISCVException read_msdcfg(CPURISCVState *env, int
        csrno,
        <br>
        +                                   target_ulong *val)
        <br>
        +{
        <br>
        +    *val = env-&gt;msdcfg;
        <br>
        +    return RISCV_EXCP_NONE;
        <br>
        +}
        <br>
        +
        <br>
        +static RISCVException write_msdcfg(CPURISCVState *env, int
        csrno,
        <br>
        +                                    target_ulong val, uintptr_t
        ra)
        <br>
        +{
        <br>
        +    env-&gt;msdcfg = val;
        <br>
        +    return RISCV_EXCP_NONE;
        <br>
        +}
        <br>
        +
        <br>
          #endif
        <br>
            /* Crypto Extension */
        <br>
        @@ -6666,6 +6746,9 @@ riscv_csr_operations
        csr_ops[CSR_TABLE_SIZE] = {
        <br>
                                      
        write_mhpmcounterh                         },
        <br>
              [CSR_SCOUNTOVF]      = { "scountovf", sscofpmf, 
        read_scountovf,
        <br>
                                       .min_priv_ver =
        PRIV_VERSION_1_12_0 },
        <br>
        +    /* Supervisor Domain Identifier and Protection Registers */
        <br>
        +    [CSR_MMPT] =    { "mmpt",   smsdid,  read_mmpt,  
        write_mmpt   },
        <br>
        +    [CSR_MSDCFG] =  { "msdcfg", smsdid,  read_msdcfg,
        write_msdcfg },
        <br>
      </blockquote>
      <br>
      I see that you added ext_smmpt but ended up not using in this
      patch. Shouldn't
      <br>
      read_mmpt and write_mmpt dependent on ext_smmpt? <br>
    </blockquote>
    <br>
    <p
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">Hi
      Daniel,</p>
    <p data-spm-anchor-id="idealab.4d3ad9aa.0.i114.1c953d33suQLO5"
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">Great
      question—thanks for raising it.</p>
    <p
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">From
      the straightforward reading of the spec, mmpt is part of the
      M-mode programming interface defined by Smsdid, not Smmpt. Quoting
      the spec: “Smsdid defines an interface to program the
      configuration for supervisor-domain-related extensions. The
      interface consists of M-mode CSRs msdcfg and mmpt.”</p>
    <p
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">From
      another angle, we can mirror how satp relates to the MMU to get a
      cleaner design. As the privileged spec says, “When SXLEN=64, all
      satp encodings corresponding to MODE=Bare are reserved for future
      standard use.” Based on that analogy, a better approach is to let
      ext_smmpt constrain the legal mmpt settings:</p>
    <ul
style="box-sizing: border-box; list-style: revert; margin: revert; padding: revert; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li style="box-sizing: border-box; margin-left: 0px;">Keep mmpt
        under ext_smsdid (CSR presence/decoding).</li>
      <li style="box-sizing: border-box; margin-left: 0px;">Make mmpt
        WARL: when ext_smmpt is absent, only MODE=Bare is legal and SDID
        remains readable/writable; writes to other fields are masked to
        zero and reads return zero.</li>
      <li data-spm-anchor-id="idealab.4d3ad9aa.0.i112.1c953d33suQLO5"
        style="box-sizing: border-box; margin-left: 0px;">When ext_smmpt
        is present, enable the full mmpt mode set and fields.</li>
    </ul>
    <p
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">Concretely,
      I can:</p>
    <ul
style="box-sizing: border-box; list-style: revert; margin: revert; padding: revert; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li style="box-sizing: border-box; margin-left: 0px;">Keep
        read_mmpt/write_mmpt gated by ext_smsdid, and</li>
      <li data-spm-anchor-id="idealab.4d3ad9aa.0.i111.1c953d33suQLO5"
        style="box-sizing: border-box; margin-left: 0px;">Add an access
        mask that depends on ext_smmpt as above (non-Bare modes are
        WARL-masked when ext_smmpt=0), with a comment referencing the
        spec.</li>
    </ul>
    <p data-spm-anchor-id="idealab.4d3ad9aa.0.i113.1c953d33suQLO5"
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">If
      that sounds good, I’ll update this patch accordingly.<br>
      Thanks,<br>
      Zhiwei</p>
    <blockquote type="cite"
      cite="mid:71565bcc-9d7a-4fbc-be4f-aa77e8679831@ventanamicro.com"><br>
      <br>
      Thanks,
      <br>
      <br>
      Daniel
      <br>
      <br>
      <blockquote type="cite">    #endif /* !CONFIG_USER_ONLY */
        <br>
          };
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------yDyiiodTsdftFd1ik6osoJF0--

