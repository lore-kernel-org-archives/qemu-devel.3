Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF15DD2A53C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 18:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t18cH-0007Qc-7h; Wed, 16 Oct 2024 14:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t18cG-0007QJ-6h
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 14:19:24 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t18cB-0003N1-Nk
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 14:19:23 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso71034a12.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1729102758; x=1729707558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5daKztTnml4aSwqan75U+bHooEiqBY+dCmjsfgPCP1s=;
 b=L73McGSrEz6j6CKhopVU9qLV8enUc5d2ZDp84y49lpqnRIXABf+3MV06o4ubWxFA75
 lD5EUm6Zd1hwzcmjQsvai3hxBnovBdw0jaSQq3CbsPK5TPgEpBIkRbbnptEL9mMH6YBU
 hBGOL+kX03Qf/PHo/GZL3sWP0q6L8j/8V+pPPTeI1CNS+frUP4p3toAf3f+MyGPUOLGs
 dVgeAYCQ9BeMUWhJH7SC5q/IuWeYJSpoGzqxZprNzkB7dqNz03WdOZLJOIfnTskGysNM
 aYkwunCAr/EtviXgCYu1B17szyBrBOnghy/jO8aPooWELJH5wdCKLPx9o/Led38IfLtu
 Nsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729102758; x=1729707558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5daKztTnml4aSwqan75U+bHooEiqBY+dCmjsfgPCP1s=;
 b=Ez6nnoU6bxxXa4WhdCiLqb+dVFulukAAq/Y6X0w5fFTHQV55ZVF0X/8wMzTsVTX233
 gQgaSc0zQbDHdjDDJNzQSM99QJ5sGJ8LdjikqT3/iFV+W53vP25ROw44rbAM4/Wp/TUD
 AnNIj1Aj8o6vcrfUu/G6PQRZD4WYvqhFYtyTDdbSU9ayHrMB1OqAgRhjjtGo0aFCbInQ
 rc+9qYf5CcYzwx17fb95HcvYksPaLgmQnfkMYL4+46nH1qVreef+deKboDh4/D66b2Ut
 CadBuLdiO9iWe/S95TU4RdHEt+OuzGso2X4e/4WLHQH5QDvsaVAYMJ5XeSloCNZBuloD
 yp4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFSXqy3smZaskDWpicbvxJ9ioO9GrYewixdwrQPhjoEmLAvE0k7C9IWu8rK43SjAEwY61dZrzilYxp@nongnu.org
X-Gm-Message-State: AOJu0YzM2p2Uvp9qYnCFHRwiXS8qadSwN/6ovWtP0+w8utNPRf7F4MOK
 UlyeMEZiTFZ4R6kyQjAhKmDOHwZvbI/xeBl2JLYS/7sLM5U0VB5FxdUmMdneB1o=
X-Google-Smtp-Source: AGHT+IFzZNxQ4FHplOk2LFXVTGO0m1xP50vXsiXHwo2EPP57gb1yPa2rIU0308v0HwPJStn/ndbbyA==
X-Received: by 2002:a05:6a20:d80a:b0:1d9:911:af03 with SMTP id
 adf61e73a8af0-1d90911b0ebmr5946325637.49.1729102757984; 
 Wed, 16 Oct 2024 11:19:17 -0700 (PDT)
Received: from [192.168.68.110] ([177.188.133.9])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6bb076sm3551364a12.15.2024.10.16.11.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 11:19:17 -0700 (PDT)
Message-ID: <624029aa-baca-4740-b917-ead1ab8bcf20@ventanamicro.com>
Date: Wed, 16 Oct 2024 15:19:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/12] hw/riscv: add RISC-V IOMMU base emulation
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Sebastien Boeuf <seb@rivosinc.com>
References: <20241004155721.2154626-1-dbarboza@ventanamicro.com>
 <20241004155721.2154626-4-dbarboza@ventanamicro.com>
 <7e7d3373-1004-47d7-8c7f-219094f0f4b6@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <7e7d3373-1004-47d7-8c7f-219094f0f4b6@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 10/16/24 12:37 AM, Jason Chien wrote:
> Hi Daniel,
> 
> On 2024/10/4 下午 11:57, Daniel Henrique Barboza wrote:
>> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>>
>> The RISC-V IOMMU specification is now ratified as-per the RISC-V
>> international process. The latest frozen specifcation can be found at:
>>
>> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
>>
>> Add the foundation of the device emulation for RISC-V IOMMU. It includes
>> support for s-stage (sv32, sv39, sv48, sv57 caps) and g-stage (sv32x4,
>> sv39x4, sv48x4, sv57x4 caps).
>>
>> Other capabilities like ATS and DBG support will be added incrementally
>> in the next patches.
>>
>> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
>> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>> ---

(...)

>> +
>> +static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
>> +{
>> +    struct riscv_iommu_command cmd;
>> +    MemTxResult res;
>> +    dma_addr_t addr;
>> +    uint32_t tail, head, ctrl;
>> +    uint64_t cmd_opcode;
>> +    GHFunc func;
>> +
>> +    ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
>> +    tail = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQT) & s->cq_mask;
>> +    head = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQH) & s->cq_mask;
>> +
>> +    /* Check for pending error or queue processing disabled */
>> +    if (!(ctrl & RISCV_IOMMU_CQCSR_CQON) ||
>> +        !!(ctrl & (RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CQMF))) {
>> +        return;
>> +    }
>> +
>> +    while (tail != head) {
>> +        addr = s->cq_addr  + head * sizeof(cmd);
>> +        res = dma_memory_read(s->target_as, addr, &cmd, sizeof(cmd),
>> +                              MEMTXATTRS_UNSPECIFIED);
>> +
>> +        if (res != MEMTX_OK) {
>> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
>> +                                  RISCV_IOMMU_CQCSR_CQMF, 0);
>> +            goto fault;
>> +        }
>> +
>> +        trace_riscv_iommu_cmd(s->parent_obj.id, cmd.dword0, cmd.dword1);
>> +
>> +        cmd_opcode = get_field(cmd.dword0,
>> +                               RISCV_IOMMU_CMD_OPCODE | RISCV_IOMMU_CMD_FUNC);
>> +
>> +        switch (cmd_opcode) {
>> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOFENCE_FUNC_C,
>> +                             RISCV_IOMMU_CMD_IOFENCE_OPCODE):
>> +            res = riscv_iommu_iofence(s,
>> +                cmd.dword0 & RISCV_IOMMU_CMD_IOFENCE_AV, cmd.dword1,
> The correct address is cmd.dword1 << 2.

You're right. In riscv-iommu spec, section 3.1.2 "IOMMU Command-queue Fence commands":

The AV command operand indicates if ADDR[63:2] operand and DATA operands are valid.
If AV=1, the IOMMU writes DATA to memory at a 4-byte aligned address ADDR[63:2] * 4 as
a 4-byte store when the command completes. When AV is 0, the ADDR[63:2] and DATA
operands are ignored.


I'll fix this instance and the other 2 instances you pointed out in patch 8.

> Reviewed-by: Jason Chien <jason.chien@sifive.com>

Thanks for the tag!


Daniel

>> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOFENCE_DATA));
>> +
>> +            if (res != MEMTX_OK) {
>> +                riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
>> +                                      RISCV_IOMMU_CQCSR_CQMF, 0);
>> +                goto fault;
>> +            }
>> +            break;
>> +
>> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA,
>> +                             RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
>> +            if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
>> +                /* illegal command arguments IOTINVAL.GVMA & PSCV == 1 */
>> +                goto cmd_ill;
>> +            }
>> +            /* translation cache not implemented yet */
>> +            break;
>> +
>> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
>> +                             RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
>> +            /* translation cache not implemented yet */
>> +            break;
>> +
>> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
>> +                             RISCV_IOMMU_CMD_IODIR_OPCODE):
>> +            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
>> +                /* invalidate all device context cache mappings */
>> +                func = riscv_iommu_ctx_inval_all;
>> +            } else {
>> +                /* invalidate all device context matching DID */
>> +                func = riscv_iommu_ctx_inval_devid;
>> +            }
>> +            riscv_iommu_ctx_inval(s, func,
>> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID), 0);
>> +            break;
>> +
>> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT,
>> +                             RISCV_IOMMU_CMD_IODIR_OPCODE):
>> +            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
>> +                /* illegal command arguments IODIR_PDT & DV == 0 */
>> +                goto cmd_ill;
>> +            } else {
>> +                func = riscv_iommu_ctx_inval_devid_procid;
>> +            }
>> +            riscv_iommu_ctx_inval(s, func,
>> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID),
>> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_PID));
>> +            break;
>> +
>> +        default:
>> +        cmd_ill:
>> +            /* Invalid instruction, do not advance instruction index. */
>> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
>> +                RISCV_IOMMU_CQCSR_CMD_ILL, 0);
>> +            goto fault;
>> +        }
>> +
>> +        /* Advance and update head pointer after command completes. */
>> +        head = (head + 1) & s->cq_mask;
>> +        riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_CQH, head);
>> +    }
>> +    return;
>> +
>> +fault:
>> +    if (ctrl & RISCV_IOMMU_CQCSR_CIE) {
>> +        riscv_iommu_notify(s, RISCV_IOMMU_INTR_CQ);
>> +    }
>> +}
>> +
>> +static void riscv_iommu_process_cq_control(RISCVIOMMUState *s)
>> +{
>> +    uint64_t base;
>> +    uint32_t ctrl_set = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
>> +    uint32_t ctrl_clr;
>> +    bool enable = !!(ctrl_set & RISCV_IOMMU_CQCSR_CQEN);
>> +    bool active = !!(ctrl_set & RISCV_IOMMU_CQCSR_CQON);
>> +
>> +    if (enable && !active) {
>> +        base = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_CQB);
>> +        s->cq_mask = (2ULL << get_field(base, RISCV_IOMMU_CQB_LOG2SZ)) - 1;
>> +        s->cq_addr = PPN_PHYS(get_field(base, RISCV_IOMMU_CQB_PPN));
>> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~s->cq_mask);
>> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQH], 0);
>> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQT], 0);
>> +        ctrl_set = RISCV_IOMMU_CQCSR_CQON;
>> +        ctrl_clr = RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQMF |
>> +                   RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CMD_TO |
>> +                   RISCV_IOMMU_CQCSR_FENCE_W_IP;
>> +    } else if (!enable && active) {
>> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~0);
>> +        ctrl_set = 0;
>> +        ctrl_clr = RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQON;
>> +    } else {
>> +        ctrl_set = 0;
>> +        ctrl_clr = RISCV_IOMMU_CQCSR_BUSY;
>> +    }
>> +
>> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, ctrl_set, ctrl_clr);
>> +}
>> +
>> +static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)
>> +{
>> +    uint64_t base;
>> +    uint32_t ctrl_set = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
>> +    uint32_t ctrl_clr;
>> +    bool enable = !!(ctrl_set & RISCV_IOMMU_FQCSR_FQEN);
>> +    bool active = !!(ctrl_set & RISCV_IOMMU_FQCSR_FQON);
>> +
>> +    if (enable && !active) {
>> +        base = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_FQB);
>> +        s->fq_mask = (2ULL << get_field(base, RISCV_IOMMU_FQB_LOG2SZ)) - 1;
>> +        s->fq_addr = PPN_PHYS(get_field(base, RISCV_IOMMU_FQB_PPN));
>> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQH], ~s->fq_mask);
>> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQH], 0);
>> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQT], 0);
>> +        ctrl_set = RISCV_IOMMU_FQCSR_FQON;
>> +        ctrl_clr = RISCV_IOMMU_FQCSR_BUSY | RISCV_IOMMU_FQCSR_FQMF |
>> +            RISCV_IOMMU_FQCSR_FQOF;
>> +    } else if (!enable && active) {
>> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQH], ~0);
>> +        ctrl_set = 0;
>> +        ctrl_clr = RISCV_IOMMU_FQCSR_BUSY | RISCV_IOMMU_FQCSR_FQON;
>> +    } else {
>> +        ctrl_set = 0;
>> +        ctrl_clr = RISCV_IOMMU_FQCSR_BUSY;
>> +    }
>> +
>> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR, ctrl_set, ctrl_clr);
>> +}
>> +
>> +static void riscv_iommu_process_pq_control(RISCVIOMMUState *s)
>> +{
>> +    uint64_t base;
>> +    uint32_t ctrl_set = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
>> +    uint32_t ctrl_clr;
>> +    bool enable = !!(ctrl_set & RISCV_IOMMU_PQCSR_PQEN);
>> +    bool active = !!(ctrl_set & RISCV_IOMMU_PQCSR_PQON);
>> +
>> +    if (enable && !active) {
>> +        base = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_PQB);
>> +        s->pq_mask = (2ULL << get_field(base, RISCV_IOMMU_PQB_LOG2SZ)) - 1;
>> +        s->pq_addr = PPN_PHYS(get_field(base, RISCV_IOMMU_PQB_PPN));
>> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQH], ~s->pq_mask);
>> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQH], 0);
>> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQT], 0);
>> +        ctrl_set = RISCV_IOMMU_PQCSR_PQON;
>> +        ctrl_clr = RISCV_IOMMU_PQCSR_BUSY | RISCV_IOMMU_PQCSR_PQMF |
>> +            RISCV_IOMMU_PQCSR_PQOF;
>> +    } else if (!enable && active) {
>> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQH], ~0);
>> +        ctrl_set = 0;
>> +        ctrl_clr = RISCV_IOMMU_PQCSR_BUSY | RISCV_IOMMU_PQCSR_PQON;
>> +    } else {
>> +        ctrl_set = 0;
>> +        ctrl_clr = RISCV_IOMMU_PQCSR_BUSY;
>> +    }
>> +
>> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR, ctrl_set, ctrl_clr);
>> +}
>> +
>> +typedef void riscv_iommu_process_fn(RISCVIOMMUState *s);
>> +
>> +static void riscv_iommu_update_icvec(RISCVIOMMUState *s, uint64_t data)
>> +{
>> +    uint64_t icvec = 0;
>> +
>> +    icvec |= MIN(data & RISCV_IOMMU_ICVEC_CIV,
>> +                 s->icvec_avail_vectors & RISCV_IOMMU_ICVEC_CIV);
>> +
>> +    icvec |= MIN(data & RISCV_IOMMU_ICVEC_FIV,
>> +                 s->icvec_avail_vectors & RISCV_IOMMU_ICVEC_FIV);
>> +
>> +    icvec |= MIN(data & RISCV_IOMMU_ICVEC_PMIV,
>> +                 s->icvec_avail_vectors & RISCV_IOMMU_ICVEC_PMIV);
>> +
>> +    icvec |= MIN(data & RISCV_IOMMU_ICVEC_PIV,
>> +                 s->icvec_avail_vectors & RISCV_IOMMU_ICVEC_PIV);
>> +
>> +    trace_riscv_iommu_icvec_write(data, icvec);
>> +
>> +    riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_ICVEC, icvec);
>> +}
>> +
>> +static void riscv_iommu_update_ipsr(RISCVIOMMUState *s, uint64_t data)
>> +{
>> +    uint32_t cqcsr, fqcsr, pqcsr;
>> +    uint32_t ipsr_set = 0;
>> +    uint32_t ipsr_clr = 0;
>> +
>> +    if (data & RISCV_IOMMU_IPSR_CIP) {
>> +        cqcsr = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
>> +
>> +        if (cqcsr & RISCV_IOMMU_CQCSR_CIE &&
>> +            (cqcsr & RISCV_IOMMU_CQCSR_FENCE_W_IP ||
>> +             cqcsr & RISCV_IOMMU_CQCSR_CMD_ILL ||
>> +             cqcsr & RISCV_IOMMU_CQCSR_CMD_TO ||
>> +             cqcsr & RISCV_IOMMU_CQCSR_CQMF)) {
>> +            ipsr_set |= RISCV_IOMMU_IPSR_CIP;
>> +        } else {
>> +            ipsr_clr |= RISCV_IOMMU_IPSR_CIP;
>> +        }
>> +    } else {
>> +        ipsr_clr |= RISCV_IOMMU_IPSR_CIP;
>> +    }
>> +
>> +    if (data & RISCV_IOMMU_IPSR_FIP) {
>> +        fqcsr = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
>> +
>> +        if (fqcsr & RISCV_IOMMU_FQCSR_FIE &&
>> +            (fqcsr & RISCV_IOMMU_FQCSR_FQOF ||
>> +             fqcsr & RISCV_IOMMU_FQCSR_FQMF)) {
>> +            ipsr_set |= RISCV_IOMMU_IPSR_FIP;
>> +        } else {
>> +            ipsr_clr |= RISCV_IOMMU_IPSR_FIP;
>> +        }
>> +    } else {
>> +        ipsr_clr |= RISCV_IOMMU_IPSR_FIP;
>> +    }
>> +
>> +    if (data & RISCV_IOMMU_IPSR_PIP) {
>> +        pqcsr = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
>> +
>> +        if (pqcsr & RISCV_IOMMU_PQCSR_PIE &&
>> +            (pqcsr & RISCV_IOMMU_PQCSR_PQOF ||
>> +             pqcsr & RISCV_IOMMU_PQCSR_PQMF)) {
>> +            ipsr_set |= RISCV_IOMMU_IPSR_PIP;
>> +        } else {
>> +            ipsr_clr |= RISCV_IOMMU_IPSR_PIP;
>> +        }
>> +    } else {
>> +        ipsr_clr |= RISCV_IOMMU_IPSR_PIP;
>> +    }
>> +
>> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, ipsr_set, ipsr_clr);
>> +}
>> +
>> +/*
>> + * Write the resulting value of 'data' for the reg specified
>> + * by 'reg_addr', after considering read-only/read-write/write-clear
>> + * bits, in the pointer 'dest'.
>> + *
>> + * The result is written in little-endian.
>> + */
>> +static void riscv_iommu_write_reg_val(RISCVIOMMUState *s,
>> +                                      void *dest, hwaddr reg_addr,
>> +                                      int size, uint64_t data)
>> +{
>> +    uint64_t ro = ldn_le_p(&s->regs_ro[reg_addr], size);
>> +    uint64_t wc = ldn_le_p(&s->regs_wc[reg_addr], size);
>> +    uint64_t rw = ldn_le_p(&s->regs_rw[reg_addr], size);
>> +
>> +    stn_le_p(dest, size, ((rw & ro) | (data & ~ro)) & ~(data & wc));
>> +}
>> +
>> +static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
>> +                                          uint64_t data, unsigned size,
>> +                                          MemTxAttrs attrs)
>> +{
>> +    riscv_iommu_process_fn *process_fn = NULL;
>> +    RISCVIOMMUState *s = opaque;
>> +    uint32_t regb = addr & ~3;
>> +    uint32_t busy = 0;
>> +    uint64_t val = 0;
>> +
>> +    if ((addr & (size - 1)) != 0) {
>> +        /* Unsupported MMIO alignment or access size */
>> +        return MEMTX_ERROR;
>> +    }
>> +
>> +    if (addr + size > RISCV_IOMMU_REG_MSI_CONFIG) {
>> +        /* Unsupported MMIO access location. */
>> +        return MEMTX_ACCESS_ERROR;
>> +    }
>> +
>> +    /* Track actionable MMIO write. */
>> +    switch (regb) {
>> +    case RISCV_IOMMU_REG_DDTP:
>> +    case RISCV_IOMMU_REG_DDTP + 4:
>> +        process_fn = riscv_iommu_process_ddtp;
>> +        regb = RISCV_IOMMU_REG_DDTP;
>> +        busy = RISCV_IOMMU_DDTP_BUSY;
>> +        break;
>> +
>> +    case RISCV_IOMMU_REG_CQT:
>> +        process_fn = riscv_iommu_process_cq_tail;
>> +        break;
>> +
>> +    case RISCV_IOMMU_REG_CQCSR:
>> +        process_fn = riscv_iommu_process_cq_control;
>> +        busy = RISCV_IOMMU_CQCSR_BUSY;
>> +        break;
>> +
>> +    case RISCV_IOMMU_REG_FQCSR:
>> +        process_fn = riscv_iommu_process_fq_control;
>> +        busy = RISCV_IOMMU_FQCSR_BUSY;
>> +        break;
>> +
>> +    case RISCV_IOMMU_REG_PQCSR:
>> +        process_fn = riscv_iommu_process_pq_control;
>> +        busy = RISCV_IOMMU_PQCSR_BUSY;
>> +        break;
>> +
>> +    case RISCV_IOMMU_REG_ICVEC:
>> +    case RISCV_IOMMU_REG_IPSR:
>> +        /*
>> +         * ICVEC and IPSR have special read/write procedures. We'll
>> +         * call their respective helpers and exit.
>> +         */
>> +        riscv_iommu_write_reg_val(s, &val, addr, size, data);
>> +
>> +        /*
>> +         * 'val' is stored as LE. Switch to host endianess
>> +         * before using it.
>> +         */
>> +        val = le64_to_cpu(val);
>> +
>> +        if (regb == RISCV_IOMMU_REG_ICVEC) {
>> +            riscv_iommu_update_icvec(s, val);
>> +        } else {
>> +            riscv_iommu_update_ipsr(s, val);
>> +        }
>> +
>> +        return MEMTX_OK;
>> +
>> +    default:
>> +        break;
>> +    }
>> +
>> +    /*
>> +     * Registers update might be not synchronized with core logic.
>> +     * If system software updates register when relevant BUSY bit
>> +     * is set IOMMU behavior of additional writes to the register
>> +     * is UNSPECIFIED.
>> +     */
>> +    riscv_iommu_write_reg_val(s, &s->regs_rw[addr], addr, size, data);
>> +
>> +    /* Busy flag update, MSB 4-byte register. */
>> +    if (busy) {
>> +        uint32_t rw = ldl_le_p(&s->regs_rw[regb]);
>> +        stl_le_p(&s->regs_rw[regb], rw | busy);
>> +    }
>> +
>> +    if (process_fn) {
>> +        process_fn(s);
>> +    }
>> +
>> +    return MEMTX_OK;
>> +}
>> +
>> +static MemTxResult riscv_iommu_mmio_read(void *opaque, hwaddr addr,
>> +    uint64_t *data, unsigned size, MemTxAttrs attrs)
>> +{
>> +    RISCVIOMMUState *s = opaque;
>> +    uint64_t val = -1;
>> +    uint8_t *ptr;
>> +
>> +    if ((addr & (size - 1)) != 0) {
>> +        /* Unsupported MMIO alignment. */
>> +        return MEMTX_ERROR;
>> +    }
>> +
>> +    if (addr + size > RISCV_IOMMU_REG_MSI_CONFIG) {
>> +        return MEMTX_ACCESS_ERROR;
>> +    }
>> +
>> +    ptr = &s->regs_rw[addr];
>> +    val = ldn_le_p(ptr, size);
>> +
>> +    *data = val;
>> +
>> +    return MEMTX_OK;
>> +}
>> +
>> +static const MemoryRegionOps riscv_iommu_mmio_ops = {
>> +    .read_with_attrs = riscv_iommu_mmio_read,
>> +    .write_with_attrs = riscv_iommu_mmio_write,
>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .impl = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 8,
>> +        .unaligned = false,
>> +    },
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 8,
>> +    }
>> +};
>> +
>> +/*
>> + * Translations matching MSI pattern check are redirected to "riscv-iommu-trap"
>> + * memory region as untranslated address, for additional MSI/MRIF interception
>> + * by IOMMU interrupt remapping implementation.
>> + * Note: Device emulation code generating an MSI is expected to provide a valid
>> + * memory transaction attributes with requested_id set.
>> + */
>> +static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
>> +    uint64_t data, unsigned size, MemTxAttrs attrs)
>> +{
>> +    RISCVIOMMUState* s = (RISCVIOMMUState *)opaque;
>> +    RISCVIOMMUContext *ctx;
>> +    MemTxResult res;
>> +    void *ref;
>> +    uint32_t devid = attrs.requester_id;
>> +
>> +    if (attrs.unspecified) {
>> +        return MEMTX_ACCESS_ERROR;
>> +    }
>> +
>> +    /* FIXME: PCIe bus remapping for attached endpoints. */
>> +    devid |= s->bus << 8;
>> +
>> +    ctx = riscv_iommu_ctx(s, devid, 0, &ref);
>> +    if (ctx == NULL) {
>> +        res = MEMTX_ACCESS_ERROR;
>> +    } else {
>> +        res = riscv_iommu_msi_write(s, ctx, addr, data, size, attrs);
>> +    }
>> +    riscv_iommu_ctx_put(s, ref);
>> +    return res;
>> +}
>> +
>> +static MemTxResult riscv_iommu_trap_read(void *opaque, hwaddr addr,
>> +    uint64_t *data, unsigned size, MemTxAttrs attrs)
>> +{
>> +    return MEMTX_ACCESS_ERROR;
>> +}
>> +
>> +static const MemoryRegionOps riscv_iommu_trap_ops = {
>> +    .read_with_attrs = riscv_iommu_trap_read,
>> +    .write_with_attrs = riscv_iommu_trap_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .impl = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 8,
>> +        .unaligned = true,
>> +    },
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 8,
>> +    }
>> +};
>> +
>> +static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>> +{
>> +    RISCVIOMMUState *s = RISCV_IOMMU(dev);
>> +
>> +    s->cap = s->version & RISCV_IOMMU_CAP_VERSION;
>> +    if (s->enable_msi) {
>> +        s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
>> +    }
>> +    if (s->enable_s_stage) {
>> +        s->cap |= RISCV_IOMMU_CAP_SV32 | RISCV_IOMMU_CAP_SV39 |
>> +                  RISCV_IOMMU_CAP_SV48 | RISCV_IOMMU_CAP_SV57;
>> +    }
>> +    if (s->enable_g_stage) {
>> +        s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
>> +                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
>> +    }
>> +    /* Report QEMU target physical address space limits */
>> +    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
>> +                       TARGET_PHYS_ADDR_SPACE_BITS);
>> +
>> +    /* TODO: method to report supported PID bits */
>> +    s->pid_bits = 8; /* restricted to size of MemTxAttrs.pid */
>> +    s->cap |= RISCV_IOMMU_CAP_PD8;
>> +
>> +    /* Out-of-reset translation mode: OFF (DMA disabled) BARE (passthrough) */
>> +    s->ddtp = set_field(0, RISCV_IOMMU_DDTP_MODE, s->enable_off ?
>> +                        RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_MODE_BARE);
>> +
>> +    /* register storage */
>> +    s->regs_rw = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
>> +    s->regs_ro = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
>> +    s->regs_wc = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
>> +
>> +     /* Mark all registers read-only */
>> +    memset(s->regs_ro, 0xff, RISCV_IOMMU_REG_SIZE);
>> +
>> +    /*
>> +     * Register complete MMIO space, including MSI/PBA registers.
>> +     * Note, PCIDevice implementation will add overlapping MR for MSI/PBA,
>> +     * managed directly by the PCIDevice implementation.
>> +     */
>> +    memory_region_init_io(&s->regs_mr, OBJECT(dev), &riscv_iommu_mmio_ops, s,
>> +        "riscv-iommu-regs", RISCV_IOMMU_REG_SIZE);
>> +
>> +    /* Set power-on register state */
>> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_CAP], s->cap);
>> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_FCTL], 0);
>> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FCTL],
>> +             ~(RISCV_IOMMU_FCTL_BE | RISCV_IOMMU_FCTL_WSI));
>> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_DDTP],
>> +        ~(RISCV_IOMMU_DDTP_PPN | RISCV_IOMMU_DDTP_MODE));
>> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQB],
>> +        ~(RISCV_IOMMU_CQB_LOG2SZ | RISCV_IOMMU_CQB_PPN));
>> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQB],
>> +        ~(RISCV_IOMMU_FQB_LOG2SZ | RISCV_IOMMU_FQB_PPN));
>> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQB],
>> +        ~(RISCV_IOMMU_PQB_LOG2SZ | RISCV_IOMMU_PQB_PPN));
>> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_CQCSR], RISCV_IOMMU_CQCSR_CQMF |
>> +        RISCV_IOMMU_CQCSR_CMD_TO | RISCV_IOMMU_CQCSR_CMD_ILL);
>> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQCSR], RISCV_IOMMU_CQCSR_CQON |
>> +        RISCV_IOMMU_CQCSR_BUSY);
>> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_FQCSR], RISCV_IOMMU_FQCSR_FQMF |
>> +        RISCV_IOMMU_FQCSR_FQOF);
>> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQCSR], RISCV_IOMMU_FQCSR_FQON |
>> +        RISCV_IOMMU_FQCSR_BUSY);
>> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_PQCSR], RISCV_IOMMU_PQCSR_PQMF |
>> +        RISCV_IOMMU_PQCSR_PQOF);
>> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQCSR], RISCV_IOMMU_PQCSR_PQON |
>> +        RISCV_IOMMU_PQCSR_BUSY);
>> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
>> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_ICVEC], 0);
>> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_DDTP], s->ddtp);
>> +
>> +    /* Memory region for downstream access, if specified. */
>> +    if (s->target_mr) {
>> +        s->target_as = g_new0(AddressSpace, 1);
>> +        address_space_init(s->target_as, s->target_mr,
>> +            "riscv-iommu-downstream");
>> +    } else {
>> +        /* Fallback to global system memory. */
>> +        s->target_as = &address_space_memory;
>> +    }
>> +
>> +    /* Memory region for untranslated MRIF/MSI writes */
>> +    memory_region_init_io(&s->trap_mr, OBJECT(dev), &riscv_iommu_trap_ops, s,
>> +            "riscv-iommu-trap", ~0ULL);
>> +    address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
>> +
>> +    /* Device translation context cache */
>> +    s->ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
>> +                                         riscv_iommu_ctx_equal,
>> +                                         g_free, NULL);
>> +
>> +    s->iommus.le_next = NULL;
>> +    s->iommus.le_prev = NULL;
>> +    QLIST_INIT(&s->spaces);
>> +}
>> +
>> +static void riscv_iommu_unrealize(DeviceState *dev)
>> +{
>> +    RISCVIOMMUState *s = RISCV_IOMMU(dev);
>> +
>> +    g_hash_table_unref(s->ctx_cache);
>> +}
>> +
>> +static Property riscv_iommu_properties[] = {
>> +    DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
>> +        RISCV_IOMMU_SPEC_DOT_VER),
>> +    DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
>> +    DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
>> +    DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
>> +    DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
>> +    DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
>> +    DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
>> +        TYPE_MEMORY_REGION, MemoryRegion *),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void riscv_iommu_class_init(ObjectClass *klass, void* data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    /* internal device for riscv-iommu-{pci/sys}, not user-creatable */
>> +    dc->user_creatable = false;
>> +    dc->realize = riscv_iommu_realize;
>> +    dc->unrealize = riscv_iommu_unrealize;
>> +    device_class_set_props(dc, riscv_iommu_properties);
>> +}
>> +
>> +static const TypeInfo riscv_iommu_info = {
>> +    .name = TYPE_RISCV_IOMMU,
>> +    .parent = TYPE_DEVICE,
>> +    .instance_size = sizeof(RISCVIOMMUState),
>> +    .class_init = riscv_iommu_class_init,
>> +};
>> +
>> +static const char *IOMMU_FLAG_STR[] = {
>> +    "NA",
>> +    "RO",
>> +    "WR",
>> +    "RW",
>> +};
>> +
>> +/* RISC-V IOMMU Memory Region - Address Translation Space */
>> +static IOMMUTLBEntry riscv_iommu_memory_region_translate(
>> +    IOMMUMemoryRegion *iommu_mr, hwaddr addr,
>> +    IOMMUAccessFlags flag, int iommu_idx)
>> +{
>> +    RISCVIOMMUSpace *as = container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);
>> +    RISCVIOMMUContext *ctx;
>> +    void *ref;
>> +    IOMMUTLBEntry iotlb = {
>> +        .iova = addr,
>> +        .target_as = as->iommu->target_as,
>> +        .addr_mask = ~0ULL,
>> +        .perm = flag,
>> +    };
>> +
>> +    ctx = riscv_iommu_ctx(as->iommu, as->devid, iommu_idx, &ref);
>> +    if (ctx == NULL) {
>> +        /* Translation disabled or invalid. */
>> +        iotlb.addr_mask = 0;
>> +        iotlb.perm = IOMMU_NONE;
>> +    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb)) {
>> +        /* Translation disabled or fault reported. */
>> +        iotlb.addr_mask = 0;
>> +        iotlb.perm = IOMMU_NONE;
>> +    }
>> +
>> +    /* Trace all dma translations with original access flags. */
>> +    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(as->devid),
>> +                          PCI_SLOT(as->devid), PCI_FUNC(as->devid), iommu_idx,
>> +                          IOMMU_FLAG_STR[flag & IOMMU_RW], iotlb.iova,
>> +                          iotlb.translated_addr);
>> +
>> +    riscv_iommu_ctx_put(as->iommu, ref);
>> +
>> +    return iotlb;
>> +}
>> +
>> +static int riscv_iommu_memory_region_notify(
>> +    IOMMUMemoryRegion *iommu_mr, IOMMUNotifierFlag old,
>> +    IOMMUNotifierFlag new, Error **errp)
>> +{
>> +    RISCVIOMMUSpace *as = container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);
>> +
>> +    if (old == IOMMU_NOTIFIER_NONE) {
>> +        as->notifier = true;
>> +        trace_riscv_iommu_notifier_add(iommu_mr->parent_obj.name);
>> +    } else if (new == IOMMU_NOTIFIER_NONE) {
>> +        as->notifier = false;
>> +        trace_riscv_iommu_notifier_del(iommu_mr->parent_obj.name);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static inline bool pci_is_iommu(PCIDevice *pdev)
>> +{
>> +    return pci_get_word(pdev->config + PCI_CLASS_DEVICE) == 0x0806;
>> +}
>> +
>> +static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int devfn)
>> +{
>> +    RISCVIOMMUState *s = (RISCVIOMMUState *) opaque;
>> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>> +    AddressSpace *as = NULL;
>> +
>> +    if (pdev && pci_is_iommu(pdev)) {
>> +        return s->target_as;
>> +    }
>> +
>> +    /* Find first registered IOMMU device */
>> +    while (s->iommus.le_prev) {
>> +        s = *(s->iommus.le_prev);
>> +    }
>> +
>> +    /* Find first matching IOMMU */
>> +    while (s != NULL && as == NULL) {
>> +        as = riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));
>> +        s = s->iommus.le_next;
>> +    }
>> +
>> +    return as ? as : &address_space_memory;
>> +}
>> +
>> +static const PCIIOMMUOps riscv_iommu_ops = {
>> +    .get_address_space = riscv_iommu_find_as,
>> +};
>> +
>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>> +        Error **errp)
>> +{
>> +    if (bus->iommu_ops &&
>> +        bus->iommu_ops->get_address_space == riscv_iommu_find_as) {
>> +        /* Allow multiple IOMMUs on the same PCIe bus, link known devices */
>> +        RISCVIOMMUState *last = (RISCVIOMMUState *)bus->iommu_opaque;
>> +        QLIST_INSERT_AFTER(last, iommu, iommus);
>> +    } else if (!bus->iommu_ops && !bus->iommu_opaque) {
>> +        pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
>> +    } else {
>> +        error_setg(errp, "can't register secondary IOMMU for PCI bus #%d",
>> +            pci_bus_num(bus));
>> +    }
>> +}
>> +
>> +static int riscv_iommu_memory_region_index(IOMMUMemoryRegion *iommu_mr,
>> +    MemTxAttrs attrs)
>> +{
>> +    return attrs.unspecified ? RISCV_IOMMU_NOPROCID : (int)attrs.pid;
>> +}
>> +
>> +static int riscv_iommu_memory_region_index_len(IOMMUMemoryRegion *iommu_mr)
>> +{
>> +    RISCVIOMMUSpace *as = container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);
>> +    return 1 << as->iommu->pid_bits;
>> +}
>> +
>> +static void riscv_iommu_memory_region_init(ObjectClass *klass, void *data)
>> +{
>> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>> +
>> +    imrc->translate = riscv_iommu_memory_region_translate;
>> +    imrc->notify_flag_changed = riscv_iommu_memory_region_notify;
>> +    imrc->attrs_to_index = riscv_iommu_memory_region_index;
>> +    imrc->num_indexes = riscv_iommu_memory_region_index_len;
>> +}
>> +
>> +static const TypeInfo riscv_iommu_memory_region_info = {
>> +    .parent = TYPE_IOMMU_MEMORY_REGION,
>> +    .name = TYPE_RISCV_IOMMU_MEMORY_REGION,
>> +    .class_init = riscv_iommu_memory_region_init,
>> +};
>> +
>> +static void riscv_iommu_register_mr_types(void)
>> +{
>> +    type_register_static(&riscv_iommu_memory_region_info);
>> +    type_register_static(&riscv_iommu_info);
>> +}
>> +
>> +type_init(riscv_iommu_register_mr_types);
>> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
>> new file mode 100644
>> index 0000000000..af3fcafc19
>> --- /dev/null
>> +++ b/hw/riscv/riscv-iommu.h
>> @@ -0,0 +1,126 @@
>> +/*
>> + * QEMU emulation of an RISC-V IOMMU
>> + *
>> + * Copyright (C) 2022-2023 Rivos Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2 or later, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef HW_RISCV_IOMMU_STATE_H
>> +#define HW_RISCV_IOMMU_STATE_H
>> +
>> +#include "qom/object.h"
>> +#include "hw/riscv/iommu.h"
>> +
>> +struct RISCVIOMMUState {
>> +    /*< private >*/
>> +    DeviceState parent_obj;
>> +
>> +    /*< public >*/
>> +    uint32_t version;     /* Reported interface version number */
>> +    uint32_t pid_bits;    /* process identifier width */
>> +    uint32_t bus;         /* PCI bus mapping for non-root endpoints */
>> +
>> +    uint64_t cap;         /* IOMMU supported capabilities */
>> +    uint64_t fctl;        /* IOMMU enabled features */
>> +    uint64_t icvec_avail_vectors;  /* Available interrupt vectors in ICVEC */
>> +
>> +    bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
>> +    bool enable_msi;      /* Enable MSI remapping */
>> +    bool enable_s_stage;  /* Enable S/VS-Stage translation */
>> +    bool enable_g_stage;  /* Enable G-Stage translation */
>> +
>> +    /* IOMMU Internal State */
>> +    uint64_t ddtp;        /* Validated Device Directory Tree Root Pointer */
>> +
>> +    dma_addr_t cq_addr;   /* Command queue base physical address */
>> +    dma_addr_t fq_addr;   /* Fault/event queue base physical address */
>> +    dma_addr_t pq_addr;   /* Page request queue base physical address */
>> +
>> +    uint32_t cq_mask;     /* Command queue index bit mask */
>> +    uint32_t fq_mask;     /* Fault/event queue index bit mask */
>> +    uint32_t pq_mask;     /* Page request queue index bit mask */
>> +
>> +    /* interrupt notifier */
>> +    void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
>> +
>> +    /* IOMMU State Machine */
>> +    QemuThread core_proc; /* Background processing thread */
>> +    QemuCond core_cond;   /* Background processing wake up signal */
>> +    unsigned core_exec;   /* Processing thread execution actions */
>> +
>> +    /* IOMMU target address space */
>> +    AddressSpace *target_as;
>> +    MemoryRegion *target_mr;
>> +
>> +    /* MSI / MRIF access trap */
>> +    AddressSpace trap_as;
>> +    MemoryRegion trap_mr;
>> +
>> +    GHashTable *ctx_cache;          /* Device translation Context Cache */
>> +
>> +    /* MMIO Hardware Interface */
>> +    MemoryRegion regs_mr;
>> +    uint8_t *regs_rw;  /* register state (user write) */
>> +    uint8_t *regs_wc;  /* write-1-to-clear mask */
>> +    uint8_t *regs_ro;  /* read-only mask */
>> +
>> +    QLIST_ENTRY(RISCVIOMMUState) iommus;
>> +    QLIST_HEAD(, RISCVIOMMUSpace) spaces;
>> +};
>> +
>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>> +         Error **errp);
>> +
>> +/* private helpers */
>> +
>> +/* Register helper functions */
>> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
>> +    unsigned idx, uint32_t set, uint32_t clr)
>> +{
>> +    uint32_t val = ldl_le_p(s->regs_rw + idx);
>> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
>> +    return val;
>> +}
>> +
>> +static inline void riscv_iommu_reg_set32(RISCVIOMMUState *s, unsigned idx,
>> +                                         uint32_t set)
>> +{
>> +    stl_le_p(s->regs_rw + idx, set);
>> +}
>> +
>> +static inline uint32_t riscv_iommu_reg_get32(RISCVIOMMUState *s, unsigned idx)
>> +{
>> +    return ldl_le_p(s->regs_rw + idx);
>> +}
>> +
>> +static inline uint64_t riscv_iommu_reg_mod64(RISCVIOMMUState *s, unsigned idx,
>> +                                             uint64_t set, uint64_t clr)
>> +{
>> +    uint64_t val = ldq_le_p(s->regs_rw + idx);
>> +    stq_le_p(s->regs_rw + idx, (val & ~clr) | set);
>> +    return val;
>> +}
>> +
>> +static inline void riscv_iommu_reg_set64(RISCVIOMMUState *s, unsigned idx,
>> +                                         uint64_t set)
>> +{
>> +    stq_le_p(s->regs_rw + idx, set);
>> +}
>> +
>> +static inline uint64_t riscv_iommu_reg_get64(RISCVIOMMUState *s,
>> +    unsigned idx)
>> +{
>> +    return ldq_le_p(s->regs_rw + idx);
>> +}
>> +#endif
>> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
>> new file mode 100644
>> index 0000000000..3d5c33102d
>> --- /dev/null
>> +++ b/hw/riscv/trace-events
>> @@ -0,0 +1,14 @@
>> +# See documentation at docs/devel/tracing.rst
>> +
>> +# riscv-iommu.c
>> +riscv_iommu_new(const char *id, unsigned b, unsigned d, unsigned f) "%s: device attached %04x:%02x.%d"
>> +riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f, uint64_t reason, uint64_t iova) "%s: fault %04x:%02x.%u reason: 0x%"PRIx64" iova: 0x%"PRIx64
>> +riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
>> +riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f, unsigned pasid, const char *dir, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
>> +riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64" -> 0x%"PRIx64
>> +riscv_iommu_mrif_notification(const char *id, uint32_t nid, uint64_t phys) "%s: sent MRIF notification 0x%x to 0x%"PRIx64
>> +riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%"PRIx64" 0x%"PRIx64
>> +riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
>> +riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed"
>> +riscv_iommu_notify_int_vector(uint32_t cause, uint32_t vector) "Interrupt cause 0x%x sent via vector 0x%x"
>> +riscv_iommu_icvec_write(uint32_t orig, uint32_t actual) "ICVEC write: incoming 0x%x actual 0x%x"
>> diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
>> new file mode 100644
>> index 0000000000..8c0e3ca1f3
>> --- /dev/null
>> +++ b/hw/riscv/trace.h
>> @@ -0,0 +1 @@
>> +#include "trace/trace-hw_riscv.h"
>> diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
>> new file mode 100644
>> index 0000000000..80769a1400
>> --- /dev/null
>> +++ b/include/hw/riscv/iommu.h
>> @@ -0,0 +1,36 @@
>> +/*
>> + * QEMU emulation of an RISC-V IOMMU
>> + *
>> + * Copyright (C) 2022-2023 Rivos Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2 or later, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef HW_RISCV_IOMMU_H
>> +#define HW_RISCV_IOMMU_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "qom/object.h"
>> +
>> +#define TYPE_RISCV_IOMMU "riscv-iommu"
>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)
>> +typedef struct RISCVIOMMUState RISCVIOMMUState;
>> +
>> +#define TYPE_RISCV_IOMMU_MEMORY_REGION "riscv-iommu-mr"
>> +typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
>> +
>> +#define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
>> +typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
>> +
>> +#endif
>> diff --git a/meson.build b/meson.build
>> index 10464466ff..71de8a5cd1 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3439,6 +3439,7 @@ if have_system
>>       'hw/pci-host',
>>       'hw/ppc',
>>       'hw/rtc',
>> +    'hw/riscv',
>>       'hw/s390x',
>>       'hw/scsi',
>>       'hw/sd',

