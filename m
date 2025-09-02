Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF33CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIae-0007R6-8i; Tue, 02 Sep 2025 00:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIac-0007Lj-Hg
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:25:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIaV-0001RB-GQ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:25:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RxPa029702
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hiK0rnf+f5QY6KQVKSZwlc3ty3G+c3Iu4L+7N9JIUbM=; b=Bpfu9oIDavkjS5ko
 mwF0jEnOosW3E3xK2aeGALxySBALYhBP/lRj+DaCiFeGEqc6YextPM7jRUnYKmeS
 /8qJa33mu6nIAvSg9wmaR1DnC4gCPbdSrLkBedtVH3mQEGbzW5NiL0mjz0LsBaoP
 6S9N7usmlkaF/A2EcCAHapaT0GRJnirj4HTMxpVctk5FC6qvGu31j3i+KFmp9gjx
 zYluQrGtAn2/ZZJXHNLGqj++bT1JAy5s2SbTYYzrPIMvDZYVTS+Jo3oRD4iCgQcp
 WczMF7XPwLx6JqSSgbMQMOjCEVwEIUzpQWRkA/uhaIIHimPr0mBE83wy9wPL5WFt
 Wm/87Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8pehj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:25:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b3415ddb6aso12935711cf.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756787141; x=1757391941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hiK0rnf+f5QY6KQVKSZwlc3ty3G+c3Iu4L+7N9JIUbM=;
 b=ScX9JpU6nGO/5cIdlN5IMT/lEmI+l+hy79/IM5y7njdx1M/rpQhdIm9MKDbnXmXX6z
 8OJpFSHjU26HpDrRU5/9iUkrE9Jh5rNnpQcJ2vvDySUFIzYFeKcGsS9LU/CkHysd/LsO
 hnKwnVmglM8eooQwJD+Coz5kpdW7AjjS6Cps1+wfasTXqfC/sHQVZYByCELWRiyK1f1j
 ipMhqyfFgn2mgLiAWYXrmHsrEkTe/BHFUzctLGActsav6k86O6vIDCk306GvdCPlrunS
 vN8hq8LFDRlOlE7sCCOPCHug04HOG7c82yHUfYSRGJmHxA/0CJ//OeC7f0SZ0Rd15bt9
 au0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdqnF9vj5HItkfKj7tLwLW5KJXme8L5KGKnqpwnpQmxzwQ0Z/d7GEjDzNdeM3AurecFyINMJ1HTDvv@nongnu.org
X-Gm-Message-State: AOJu0Yyl4IBIlsm1XCLID8muScDeU0mz46RU18o7NGSNNo66f8PtfaFO
 pLfPgHBNPwVT7suU3X5M2gMEwxfJPH8IkJh1cg52+az1LJ2fT+qea8KMVoo/Hy+c+r7Yi8+dD8y
 YHlYgqq43MW2sp0hVMepzRCT6PEfmqlFL10mshwT5X2ODSZTxGcZVSzRJMg==
X-Gm-Gg: ASbGncumH5KfvSqSNYjwozqsDcu7K1ipln1uv/4rW9zYGevqxi+q/JQ/OddO7n8/R0z
 xSmeLaL5muh1AO++VXCB4OfZAKARG/73y3IARLk6gzY4Chw7poaR9M/I/MP5Ej8GKWFxKK1hcSg
 AhqcR0ZnFYvetaGP+GB1w3IqNN6kMIkQMn9lDNFLRZ2+/TFVhuXaLVbhEWoq/fiFQM12AKVJ1o3
 US4oNuYHTkbcD88sM+8XjQtLz5yT/usHlzVCsj0tWZj5TOWcfjxJTUotFJCjvAVTBgBJMMXBz/D
 IwjrUFKQxX6AV4UnrajgUeyjc0BQcpnwfxPlD0bncs5UOvp9rZDoFOtCsQ/NEg==
X-Received: by 2002:ac8:5f94:0:b0:4b2:d40b:997 with SMTP id
 d75a77b69052e-4b31b889a3cmr115580811cf.11.1756787141087; 
 Mon, 01 Sep 2025 21:25:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXn62zFP91fw01jJpbfAjubhchSUjJ74ND0b+jlXnThneeLwv15MnpV/5+2vMz8ayp7nJoMg==
X-Received: by 2002:ac8:5f94:0:b0:4b2:d40b:997 with SMTP id
 d75a77b69052e-4b31b889a3cmr115580611cf.11.1756787140396; 
 Mon, 01 Sep 2025 21:25:40 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b88007a60sm65955265e9.8.2025.09.01.21.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:25:40 -0700 (PDT)
Message-ID: <fc24d542-f6cb-47bd-af1d-caa99d3c9d8c@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 21:35:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/39] target/hexagon: Add next_PC, {s,g}reg writes
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-31-brian.cain@oss.qualcomm.com>
 <024f01db9836$aab62000$00226000$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <024f01db9836$aab62000$00226000$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1dCVqX3H2X-U6i5ret3gzrA51l-Mip4s
X-Proofpoint-GUID: 1dCVqX3H2X-U6i5ret3gzrA51l-Mip4s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX/GAGhFj/KXxG
 RUbGblp6EV2HFkaQxnmZtK0DQ0xXnVQkI67PYwn5k3l7yXKE2Fwe9TqjAlaYWGNSo6+CW7Gj2LN
 dLqq0HqccWgX3cjGcngcZqy5LUMv3cS//nsU8spAAUXF3U8FQ4k2suXPUwikNIJWhfxmEG2IaWF
 Qbp3J2TtFqjFFI5At6RRSWxdvZVafCftDCFAZxOOkA/zBBHpcPHR/hv8Q09D8ktQp2KZXJs486C
 H9wsejRd5lNRvVzdVczVKcejuBiTgJxUfs9ku+lRUQONWS2e7E3oMvXfl4QKLf7xQF8lOZSisRp
 lh+nxvFD/0C5cbv1ypX0WGJcvbgdui7jOk/0h+KnbmqR/YUAQOiSpA0TUQCcB6RE69SJ42LP8us
 zpT3ED46
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b671c6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=1GvbeEhO9WgkJuYG0qQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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


On 3/18/2025 1:50 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:29 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 30/39] target/hexagon: Add next_PC, {s,g}reg writes
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.h       |   2 +-
>>   target/hexagon/translate.h |   2 +
>>   target/hexagon/genptr.c    |   7 +-
>>   target/hexagon/translate.c | 142 ++++++++++++++++++++++++++++++++-
>> ----
>>   4 files changed, 132 insertions(+), 21 deletions(-)
>>
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
>> 4667a1f748..73c3bb34b0 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -142,9 +142,9 @@ typedef struct CPUArchState {
>>       hex_lock_state_t k0_lock_state;
>>       target_ulong tlb_lock_count;
>>       target_ulong k0_lock_count;
>> -    target_ulong next_PC;
>>       CPUHexagonTLBContext *hex_tlb;
>>   #endif
>> +    target_ulong next_PC;
> You are moving this from system-mode only to unconditional.  There must be an earlier patch in this series that put it in system-mode.  Find that and remove it, so there is only a single addition.
>
> Also, does this need to be part of the global state?  The answer is no if it doesn't live across packets.  If it is only used within the context of a single packet, you can just create a temporary TCGv in DisasContext.  There are several examples already.
>
We were not eager to re-introduce next_PC but there were some features 
that wouldn't work without it - in particular the wait instruction IIRC.

If this is objectionable, I can try and share the illustrating test case(s).

>>       target_ulong new_value_usr;
>>
>>       MemLog mem_log_stores[STORES_MAX];
>> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h index
>> c9533fee1f..ad1a2f4045 100644
>> --- a/target/hexagon/translate.h
>> +++ b/target/hexagon/translate.h
>> @@ -85,6 +85,7 @@ typedef struct DisasContext {
>>       TCGv dczero_addr;
>>       bool pcycle_enabled;
>>       bool pkt_ends_tb;
>> +    bool need_next_pc;
>>       uint32_t num_cycles;
>>   } DisasContext;
>>
>> @@ -306,6 +307,7 @@ static inline void ctx_log_qreg_read(DisasContext
>> *ctx,  }
>>
>>   extern TCGv hex_gpr[TOTAL_PER_THREAD_REGS];
>> +extern TCGv hex_next_PC;
>>   extern TCGv hex_pred[NUM_PREGS];
>>   extern TCGv hex_slot_cancelled;
>>   extern TCGv hex_new_value_usr;
>> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c index
>> 5554c9515c..afc7e5f3a5 100644
>> --- a/target/hexagon/genptr.c
>> +++ b/target/hexagon/genptr.c
>> @@ -634,14 +634,15 @@ static void gen_write_new_pc_addr(DisasContext
>> *ctx, TCGv addr,
>>           tcg_gen_brcondi_tl(cond, pred, 0, pred_false);
>>       }
>>
>> +    TCGv PC_wr = ctx->need_next_pc ? hex_next_PC :
>> hex_gpr[HEX_REG_PC];
>>       if (ctx->pkt->pkt_has_multi_cof) {
>>           /* If there are multiple branches in a packet, ignore the second one */
>> -        tcg_gen_movcond_tl(TCG_COND_NE, hex_gpr[HEX_REG_PC],
>> +        tcg_gen_movcond_tl(TCG_COND_NE, PC_wr,
>>                              ctx->branch_taken, tcg_constant_tl(0),
>> -                           hex_gpr[HEX_REG_PC], addr);
>> +                           PC_wr, addr);
>>           tcg_gen_movi_tl(ctx->branch_taken, 1);
>>       } else {
>> -        tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], addr);
>> +        tcg_gen_mov_tl(PC_wr, addr);
>>       }
>>
>>       if (cond != TCG_COND_ALWAYS) {
>> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c index
>> 475726388a..d4b22acb72 100644
>> --- a/target/hexagon/translate.c
>> +++ b/target/hexagon/translate.c
>> @@ -49,6 +49,7 @@ static const AnalyzeInsn
>> opcode_analyze[XX_LAST_OPCODE] = {  TCGv
>> hex_gpr[TOTAL_PER_THREAD_REGS];  TCGv hex_pred[NUM_PREGS];  TCGv
>> hex_slot_cancelled;
>> +TCGv hex_next_PC;
>>   TCGv hex_new_value_usr;
>>   TCGv hex_store_addr[STORES_MAX];
>>   TCGv hex_store_width[STORES_MAX];
>> @@ -61,12 +62,14 @@ TCGv_i64 hex_cycle_count;  TCGv
>> hex_vstore_addr[VSTORES_MAX];  TCGv hex_vstore_size[VSTORES_MAX];
>> TCGv hex_vstore_pending[VSTORES_MAX];
>> +static bool need_next_PC(DisasContext *ctx);
> You don't need this.  The function definition is before any reference to it.


I'll remove this declaration in v3.

>>   #ifndef CONFIG_USER_ONLY
>>   TCGv hex_greg[NUM_GREGS];
>>   TCGv hex_t_sreg[NUM_SREGS];
>>   TCGv_ptr hex_g_sreg_ptr;
>>   TCGv hex_g_sreg[NUM_SREGS];
>> +TCGv hex_cause_code;
> This doesn't belong in this patch.
Fixed in v2.
>>   #endif
>>
>>   static const char * const hexagon_prednames[] = { @@ -184,6 +187,9 @@
>> static void gen_end_tb(DisasContext *ctx)
>>
>>       gen_exec_counters(ctx);
>>
>> +    if (ctx->need_next_pc) {
>> +        tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], hex_next_PC);
>> +    }
>>       if (ctx->branch_cond != TCG_COND_NEVER) {
>>           if (ctx->branch_cond != TCG_COND_ALWAYS) {
>>               TCGLabel *skip = gen_new_label(); @@ -371,18 +377,24 @@ static
>> bool pkt_ends_tb(Packet *pkt)  static bool need_next_PC(DisasContext
>> *ctx)  {
>>       Packet *pkt = ctx->pkt;
>> -
>> -    /* Check for conditional control flow or HW loop end */
>> -    for (int i = 0; i < pkt->num_insns; i++) {
>> -        uint16_t opcode = pkt->insn[i].opcode;
>> -        if (GET_ATTRIB(opcode, A_CONDEXEC) && GET_ATTRIB(opcode,
>> A_COF)) {
>> -            return true;
>> -        }
>> -        if (GET_ATTRIB(opcode, A_HWLOOP0_END) ||
>> -            GET_ATTRIB(opcode, A_HWLOOP1_END)) {
>> -            return true;
> Was this inserted by an earlier patch in this series?  If so, don't insert it before.  Just put the below code in this patch.
>
>> +    if (pkt->pkt_has_cof || ctx->pkt_ends_tb) {
>> +        for (int i = 0; i < pkt->num_insns; i++) {
>> +            uint16_t opcode = pkt->insn[i].opcode;
>> +            if ((GET_ATTRIB(opcode, A_CONDEXEC) && GET_ATTRIB(opcode,
>> A_COF)) ||
>> +                GET_ATTRIB(opcode, A_HWLOOP0_END) ||
>> +                GET_ATTRIB(opcode, A_HWLOOP1_END)) {
>> +                return true;
>> +            }
>>           }
>>       }
>> +    /*
>> +     * We end the TB on some instructions that do not change the flow (for
>> +     * other reasons). In these cases, we must set pc too, as the insn won't
>> +     * do it themselves.
>> +     */
>> +    if (ctx->pkt_ends_tb && !check_for_attrib(pkt, A_COF)) {
>> +        return true;
>> +    }
>>       return false;
>>   }
>>
>> @@ -523,7 +535,14 @@ static void analyze_packet(DisasContext *ctx)  static
>> void gen_start_packet(DisasContext *ctx)  {
>>       Packet *pkt = ctx->pkt;
>> +#ifndef CONFIG_USER_ONLY
>> +    target_ulong next_PC = (check_for_opcode(pkt, Y2_k0lock) ||
>> +                            check_for_opcode(pkt, Y2_tlblock)) ?
> Should we also check for Y2_wait?

Let me review why we didn't include Y2_wait here - the behavior is 
similar but not identical between these instructions.


>> +                               ctx->base.pc_next :
>> +                               ctx->base.pc_next +
>> +pkt->encod_pkt_size_in_bytes; #else
>>       target_ulong next_PC = ctx->base.pc_next + pkt-
>>> encod_pkt_size_in_bytes;
>> +#endif
> You don't need the #ifndef CONFIG_USER_ONLY here.  Note that the opcodes exist in linux-user mode as well as system mode.  So, you can just keep the first version.
>
> Note that check_for_opcode is currently guarded by #ifndef CONFIG_USER_ONLY, but you can remove that.
>
>>       int i;
>>
>>       /* Clear out the disassembly context */ @@ -531,6 +550,10 @@ static void
>> gen_start_packet(DisasContext *ctx)
>>       ctx->reg_log_idx = 0;
>>       bitmap_zero(ctx->regs_written, TOTAL_PER_THREAD_REGS);
>>       bitmap_zero(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
>> +#ifndef CONFIG_USER_ONLY
>> +    ctx->greg_log_idx = 0;
>> +    ctx->sreg_log_idx = 0;
>> +#endif
>>       ctx->preg_log_idx = 0;
>>       bitmap_zero(ctx->pregs_written, NUM_PREGS);
>>       ctx->future_vregs_idx = 0;
>> @@ -563,21 +586,41 @@ static void gen_start_packet(DisasContext *ctx)
>>        * gen phase, so clear it again.
>>        */
>>       bitmap_zero(ctx->pregs_written, NUM_PREGS);
>> +#ifndef CONFIG_USER_ONLY
>> +    for (i = 0; i < NUM_SREGS; i++) {
>> +        ctx->t_sreg_new_value[i] = NULL;
>> +    }
>> +    for (i = 0; i < ctx->sreg_log_idx; i++) {
>> +        int reg_num = ctx->sreg_log[i];
>> +        if (reg_num < HEX_SREG_GLB_START) {
>> +            ctx->t_sreg_new_value[reg_num] = tcg_temp_new();
>> +            tcg_gen_mov_tl(ctx->t_sreg_new_value[reg_num],
>> hex_t_sreg[reg_num]);
>> +        }
>> +    }
>> +    for (i = 0; i < NUM_GREGS; i++) {
>> +        ctx->greg_new_value[i] = NULL;
>> +    }
>> +    for (i = 0; i < ctx->greg_log_idx; i++) {
>> +        int reg_num = ctx->greg_log[i];
>> +        ctx->greg_new_value[reg_num] = tcg_temp_new();
>> +    }
>> +#endif
>>
>>       /* Initialize the runtime state for packet semantics */
>>       if (need_slot_cancelled(pkt)) {
>>           tcg_gen_movi_tl(hex_slot_cancelled, 0);
>>       }
>>       ctx->branch_taken = NULL;
>> -    ctx->pkt_ends_tb = pkt_ends_tb(pkt);
>>       if (pkt->pkt_has_cof) {
>>           ctx->branch_taken = tcg_temp_new();
>> -        if (pkt->pkt_has_multi_cof) {
>> -            tcg_gen_movi_tl(ctx->branch_taken, 0);
>> -        }
>> -        if (need_next_PC(ctx)) {
>> -            tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], next_PC);
>> -        }
>> +    }
>> +    if (pkt->pkt_has_multi_cof) {
>> +        tcg_gen_movi_tl(ctx->branch_taken, 0);
>> +    }
>> +    ctx->pkt_ends_tb = pkt_ends_tb(pkt);
>> +    ctx->need_next_pc = need_next_PC(ctx);
>> +    if (ctx->need_next_pc) {
>> +        tcg_gen_movi_tl(hex_next_PC, next_PC);
>>       }
>>
>>       /* Preload the predicated registers into get_result_gpr(ctx, i) */ @@ -
>> 713,6 +756,59 @@ static void gen_reg_writes(DisasContext *ctx)
>>       }
>>   }
>>
>> +#ifndef CONFIG_USER_ONLY
>> +static void gen_greg_writes(DisasContext *ctx) {
>> +    int i;
>> +
>> +    for (i = 0; i < ctx->greg_log_idx; i++) {
>> +        int reg_num = ctx->greg_log[i];
>> +
>> +        tcg_gen_mov_tl(hex_greg[reg_num], ctx-
>>> greg_new_value[reg_num]);
>> +    }
>> +}
>> +
>> +
>> +static void gen_sreg_writes(DisasContext *ctx) {
>> +    int i;
>> +
>> +    TCGv old_reg = tcg_temp_new();
>> +    for (i = 0; i < ctx->sreg_log_idx; i++) {
>> +        int reg_num = ctx->sreg_log[i];
>> +
>> +        if (reg_num == HEX_SREG_SSR) {
>> +            tcg_gen_mov_tl(old_reg, hex_t_sreg[reg_num]);
>> +            tcg_gen_mov_tl(hex_t_sreg[reg_num], ctx-
>>> t_sreg_new_value[reg_num]);
>> +            gen_helper_modify_ssr(tcg_env, ctx->t_sreg_new_value[reg_num],
>> +                                  old_reg);
>> +            /* This can change processor state, so end the TB */
>> +            ctx->base.is_jmp = DISAS_NORETURN;
>> +        } else if ((reg_num == HEX_SREG_STID) ||
>> +                   (reg_num == HEX_SREG_IMASK) ||
>> +                   (reg_num == HEX_SREG_IPENDAD)) {
>> +            if (reg_num < HEX_SREG_GLB_START) {
>> +                tcg_gen_mov_tl(old_reg, hex_t_sreg[reg_num]);
>> +                tcg_gen_mov_tl(hex_t_sreg[reg_num],
>> +                               ctx->t_sreg_new_value[reg_num]);
>> +            }
>> +            /* This can change the interrupt state, so end the TB */
>> +            gen_helper_pending_interrupt(tcg_env);
>> +            ctx->base.is_jmp = DISAS_NORETURN;
>> +        } else if ((reg_num == HEX_SREG_BESTWAIT) ||
>> +                   (reg_num == HEX_SREG_SCHEDCFG)) {
>> +            /* This can trigger resched interrupt, so end the TB */
>> +            gen_helper_resched(tcg_env);
>> +            ctx->base.is_jmp = DISAS_NORETURN;
>> +        }
>> +
>> +        if (reg_num < HEX_SREG_GLB_START) {
>> +            tcg_gen_mov_tl(hex_t_sreg[reg_num], ctx-
>>> t_sreg_new_value[reg_num]);
>> +        }
>> +    }
>> +}
>> +#endif
>> +
>>   static void gen_pred_writes(DisasContext *ctx)  {
>>       /* Early exit if not needed or the log is empty */ @@ -1012,6 +1108,10 @@
>> static void gen_commit_packet(DisasContext *ctx)
>>       process_store_log(ctx);
>>
>>       gen_reg_writes(ctx);
>> +#if !defined(CONFIG_USER_ONLY)
>> +    gen_greg_writes(ctx);
>> +    gen_sreg_writes(ctx);
>> +#endif
>>       gen_pred_writes(ctx);
>>       if (pkt->pkt_has_hvx) {
>>           gen_commit_hvx(ctx);
>> @@ -1073,6 +1173,7 @@ static void
>> hexagon_tr_init_disas_context(DisasContextBase *dcbase,
>>       ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
>>       ctx->short_circuit = hex_cpu->short_circuit;
>>       ctx->pcycle_enabled = FIELD_EX32(hex_flags, TB_FLAGS,
>> PCYCLE_ENABLED);
>> +    ctx->need_next_pc = false;
> Don't need this because it is initialized in gen_start_packet.
>
>>   }
>>
>>   static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu) @@
>> -1201,6 +1302,13 @@ void hexagon_translate_init(void)
>>           offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
>>       hex_cycle_count = tcg_global_mem_new_i64(tcg_env,
>>               offsetof(CPUHexagonState, t_cycle_count), "t_cycle_count");
>> +#ifndef CONFIG_USER_ONLY
>> +    hex_cause_code = tcg_global_mem_new(tcg_env,
>> +        offsetof(CPUHexagonState, cause_code), "cause_code"); #endif
> Doesn’t' belong in this patch


Not fixed in v2, will address it in v3.

>
>> +    hex_next_PC = tcg_global_mem_new(tcg_env,
>> +        offsetof(CPUHexagonState, next_PC), "next_PC");
>> +
>>       for (i = 0; i < STORES_MAX; i++) {
>>           snprintf(store_addr_names[i], NAME_LEN, "store_addr_%d", i);
>>           hex_store_addr[i] = tcg_global_mem_new(tcg_env,
>> --
>> 2.34.1
>

