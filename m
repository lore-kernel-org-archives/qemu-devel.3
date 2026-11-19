Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6560A2602
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EALB7EEA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UKbUYxGA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBXp-0000oG-NU; Thu, 19 Nov 2026 18:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUBXn-0000o0-PL
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:27:55 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUBXl-0003uy-Fe
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:27:55 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1mXc3148722
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fipkDZshbmXXZtU9H5KPG/PJcRS2NIClMYlneyb4Z9Q=; b=EALB7EEA9hUe0gMK
 fV9yKLvBbMIlQRy3N1izCatwK9NkPdV3vS7Tguk+xkpIcqcWsL7DQaPnHxfSQ3Zr
 AwiRvBcCs4HKOZKUj/xJAjchG0gkCnjmPEW42FenwBcxzC/QmNEJE0uFzBDXOCpT
 +tN5z2xuGW4LWNm2CafR+YG1+sjOi7YEZmhEQYdEFsWIVqtAJGgm5XXoYjDYK7yw
 94y2QHb7JeU8tAEawtYkt7+HFo1eT8Z4MpdrZz1/VTpNpQM6EZgtfGxKzrk/Snp7
 iBFMv8k5tmKiwfJM7qDjpFWIph5AvYrnYTMM/f2OMrOdZw7JfIWnpyUAgkCtTxAJ
 dRq72g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yx6b9vy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:27:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-384c78aa0dbso338003eec.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795130870; x=1795735670; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fipkDZshbmXXZtU9H5KPG/PJcRS2NIClMYlneyb4Z9Q=;
 b=UKbUYxGAXvJ/loQc1mEZHV0V5W26rGcFG3BCQJl35OdHCTG/Rfu2mXq21I8vSWJVDi
 N91J3toWoYjj2DQO6B97PtEsZQTAKCL+V2KOCWvMTZSBYxPpAjbZqzGWwMmF3qeuaUQ1
 ymCk4O+rXGQSSHfXFW7HsYUBnlSPsHes59ombQ7e8lvwBFcDevcHBNmHlDChArOqebn1
 /xj1Za7vRXSoo922cGG//iVUhVmluK4nu3YgrbIbbS/n2V9C8u5BlaKmSqrHiKEzUnuB
 5YMccYBj+dAYn7/tMOHItrAs+dMOZLx9+/P/OuLjeMfaOA0YYN+8tthGJ43lS8CRUHAF
 6JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795130870; x=1795735670;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fipkDZshbmXXZtU9H5KPG/PJcRS2NIClMYlneyb4Z9Q=;
 b=kk0RkE9YNKU/ZAsbhI//kMWOWL1pvjSLtNHH3zeaJ+8jF6nGrdROXj1HYkETKrTMYa
 1xtlp+rz/Q1hfEs58wevm8FmKlgqOI5AiCn8NNK9yKJKsvTr+YpF4dX78UuL0CcrU6d9
 P+BXvMV8pk+2aDyKqZQy+dmrDjo/hRpu4ql6+4AFmKzBnb8PYb97qksMC3Gqz99Y7Ct7
 Gfx2rJOSkDlZC6WVCq/IZ4CtvXDFDJ3aso8PJ8SFhZ7Qsd7SYewsxqT6f3r4nZEsVkpr
 nGQtppUtYXWX0SsvCpJHVQvVh9xVBV+7nILodkX1OkyzRZ3VSun4wQRfBd/D1bKCHn3k
 q+nA==
X-Forwarded-Encrypted: i=1;
 AL+hErE2T6zugUAwUm/kSZqrjrgNEJfyhwGqahPZj0NBmqAnO8TFH8Z8pDUfpJ+sMHDdl66mr830Ncyp06Pn@nongnu.org
X-Gm-Message-State: APuU4Z9sMq2p1ZoB66Ej6yc+Ntx49uQOoUpuP8ElKUBXnaF01hSUfkDg
 EO+7lUJx05TNbhoPHd8ceLH4WmLLsED1U02K3gtm/7vNFHT04GnU16+I1igpz/cZhLUAJgd9ik4
 EmrMoNOl22iySrq/zb6ppFBRlkE29OMayoFfLAP13D0QiMXBSImVSKUzB2w==
X-Gm-Gg: AZFdTZevQxBArG7dUWnQMyr7EusCUVh6OP7muYc6RlZgMj5qW6kOt1cJI/4uGEBmnVQ
 kbZ1ntBozEBzII2WQx6sUdN7zWyKCMywILFXaKZ4+uQbSQHfhgC2Mtrzpjki+z4gehDX//mCMMq
 XsuhN8RnkiYnZH4NgbezEsk/SJCY5USRfV23/MnYNUMShbB4cWfgwb905b4JL6iEC9qwCB61Cek
 iC6frpMlFji8w9oLTBxMhnywAwN4VKCpL4uJWSOGGFc+Sa/xOE61FT4L4Txr21uWAt1XWziFiDX
 TKUFlpu4tCJgITHpdgLl8W9n16n+kkyTrtsptEsWpNByH6/H9djoC4P1+2QZC0zy0lVOFdZRSVg
 zNfktRRC86o6bizqgCpMr2g1frY/Rq1PnAuG1r8TtAt23sJsN5BXUzs2lidPQZpIHViueWH34af
 OH3hRzQDXAQ3dWS5m7mkfUFFVDdGPO7fP+bXbk
X-Received: by 2002:a05:693c:864c:10b0:377:a1c8:a628 with SMTP id
 5a478bee46e88-3856f65dc4fmr912531eec.6.1795130869877; 
 Thu, 19 Nov 2026 15:27:49 -0800 (PST)
X-Received: by 2002:a05:693c:864c:10b0:377:a1c8:a628 with SMTP id
 5a478bee46e88-3856f65dc4fmr912505eec.6.1795130869225; 
 Thu, 19 Nov 2026 15:27:49 -0800 (PST)
Received: from [10.248.104.162] (160.sub-174-226-161.myvzw.com.
 [174.226.161.160]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385672cf745sm1857976eec.18.2026.11.19.15.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 15:27:48 -0800 (PST)
Message-ID: <a3f0c1bc-58da-45c5-91a0-9cd4b7e3ac8d@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 17:27:44 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] target/hexagon: retain both scalar packet fault
 addresses
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
 <20261119215853.987158-10-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261119215853.987158-10-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HpJCDQAmyvog-dtcl41l_ve29fJMc9_K
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5NCBTYWx0ZWRfX5Z72cWKmuWyL
 3uktqHhBuGLU3KUUI/4UcwMQFLIyrlCqTd39RVZTXWTdexKLSlYw1iv+ujWpX7GNqtXEpFC8R2d
 68JanOg7JQB4kZ//vB6aTPsLQUFqYTc=
X-Proofpoint-ORIG-GUID: HpJCDQAmyvog-dtcl41l_ve29fJMc9_K
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6aff85f6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=GMQ7njlnOdzlMr1UnwV+Pw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VQ_LU4iI7PEz2cgcdtEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5NCBTYWx0ZWRfXzKqw11Lvqj+i
 GIVy0XSRDbdGk+m4/6u2swgEg/7KwFq+PGNHigfZz+Vx+hgTnGBU8n2WDIRsdzS9QDKa8ONzfuW
 e7G4U5lL7VrLpqeJxdSFfrewXJC9hrKsBGQnc/kmPhSsASIZ4gmNd1CKe389FNOETsEWhlKBtdt
 Znl1EQc21jD4FCC1VpnGmb7hmCZh8Z77/uFifcrl5VL1236r9ykw8SUmNH+h+vc+t2GDCtfx634
 gUD7BOpp17pCG3TdYF+GzmQEegagAASn6uammC/8TUnh2vXdPHVty1TdUyMzjG5CmrEYrH20UPt
 diukpvMMWmt/ZhtEd9Apl81TRUkJ+cZBq+Mv6J8RurvF/9ckmJqaBfdc8e/i+N7q1p1ovJ4r2X+
 BCjMMGoXHpJGyQmy5PfJUPDXu6klRqBiMioQWWslva8U6nRLAad5La5wWwQ6j3SfLlvhgAOvYDq
 aytikqqI3QN1GaS9fbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/19/2026 3:58 PM, Marco Liebel wrote:
> Generate address-only code from scalar memory semantics. Record both
> active slots before memory execution, without loads, stores, or pointer
> updates. Use the recorded addresses and validity bits on a data fault.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.c                 | 16 ++++++++++++
>   target/hexagon/cpu.h                 |  2 ++
>   target/hexagon/gen_tcg_func_table.py |  6 +++++
>   target/hexagon/gen_tcg_funcs.py      | 38 ++++++++++++++++++++++++++++
>   target/hexagon/genptr.c              | 17 +++++++++++++
>   target/hexagon/genptr.h              |  4 +++
>   target/hexagon/hex_common.py         | 22 ++++++++++++++++
>   target/hexagon/translate.c           | 16 ++++++++++++
>   target/hexagon/translate.h           |  1 +
>   9 files changed, 122 insertions(+)
>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 11d622948e..34f80d6671 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -759,6 +759,22 @@ static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
>   {
>       env->t_sreg[HEX_SREG_BADVA] = VA;
>   
> +    if (access_type != MMU_INST_FETCH && env->mem_access_valid) {
> +        uint32_t valid = env->mem_access_valid | (1U << slot);
> +        for (int i = 0; i < 2; i++) {
> +            if (valid & (1U << i)) {
> +                env->t_sreg[HEX_SREG_BADVA0 + i] =
> +                    i == slot ? VA : env->mem_access_va[i];
> +            } else {
> +                env->t_sreg[HEX_SREG_BADVA0 + i] = INVALID_BADVA;
> +            }
> +        }
> +        SET_SSR_FIELD(env, SSR_V0, valid & 1);
> +        SET_SSR_FIELD(env, SSR_V1, (valid >> 1) & 1);
> +        SET_SSR_FIELD(env, SSR_BVS, slot);
> +        return;
> +    }
> +
>       if (access_type == MMU_INST_FETCH || slot == 0) {
>           env->t_sreg[HEX_SREG_BADVA0] = VA;
>           env->t_sreg[HEX_SREG_BADVA1] = INVALID_BADVA;
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index d6a513988c..915da339a0 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -167,6 +167,8 @@ typedef struct CPUArchState {
>       uint32_t t_sreg[NUM_SREGS];
>       /* Slot of the memory operation currently being executed or probed. */
>       uint32_t mem_slot;
> +    uint32_t mem_access_valid;
> +    uint32_t mem_access_va[2];
>   
>       uint32_t greg[NUM_GREGS];
>   
> diff --git a/target/hexagon/gen_tcg_func_table.py b/target/hexagon/gen_tcg_func_table.py
> index ba56ede568..3ec136d6f1 100755
> --- a/target/hexagon/gen_tcg_func_table.py
> +++ b/target/hexagon/gen_tcg_func_table.py
> @@ -22,6 +22,12 @@ def main():
>               f.write(f"    [{tag}] = generate_{tag},\n")
>   
>           f.write("};\n\n")
> +        f.write("#ifndef CONFIG_USER_ONLY\n")
> +        f.write("const SemanticInsn opcode_address[XX_LAST_OPCODE] = {\n")
> +        for tag in hex_common.tags:
> +            if not hex_common.tag_ignore(tag) and hex_common.packet_memory_info(tag):
> +                f.write(f"    [{tag}] = address_{tag},\n")
> +        f.write("};\n#endif\n\n")
>           f.write("#endif    /* HEXAGON_FUNC_TABLE_H */\n")
>   
>   
> diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
> index eb2e5f3a7e..f67056049e 100755
> --- a/target/hexagon/gen_tcg_funcs.py
> +++ b/target/hexagon/gen_tcg_funcs.py
> @@ -154,11 +154,49 @@ def gen_tcg_func(f, tag, regs, imms):
>       f.write("}\n\n")
>   
>   
> +def gen_memory_address(f, tag, regs, imms):
> +    info = hex_common.packet_memory_info(tag)
> +    if info is None:
> +        return
> +    ea, pred, width = info
> +    for reg in ("SP", "FP", "GP", "LR"):
> +        ea = ea.replace(f"fREAD_{reg}()", f"hex_gpr[HEX_REG_{reg}]")
> +    f.write("#ifndef CONFIG_USER_ONLY\n")
> +    f.write(f"static void address_{tag}(DisasContext *ctx)\n{{\n")
> +    f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
> +    f.write("    TCGv EA = tcg_temp_new();\n")
> +    for i, (regtype, regid) in enumerate(regs):
> +        name = f"{regtype}{regid}V"
> +        if regtype == "R" and re.search(rf"\b{name}\b", ea):
> +            f.write(f"    TCGv {name} = hex_gpr[insn->regno[{i}]];\n")
> +    for immlett, bits, shift in imms:
> +        name = hex_common.imm_name(immlett)
> +        if re.search(rf"\b{name}\b", ea):
> +            i = 1 if immlett.isupper() else 0
> +            f.write(f"    int {name} = insn->immed[{i}];\n")
> +    if pred:
> +        name = pred.group(3)
> +        i = next(i for i, (t, r) in enumerate(regs)
> +                 if f"{t}{r}" == name[:-1])
> +        source = "ctx->new_pred_value" if pred.group(1) == "NEW" else "hex_pred"
> +        f.write("    TCGv LSB = tcg_temp_new();\n")
> +        f.write("    TCGLabel *skip = gen_new_label();\n")
> +        f.write(f"    tcg_gen_andi_tl(LSB, {source}[insn->regno[{i}]], 1);\n")
> +        cond = "NE" if pred.group(2) else "EQ"
> +        f.write(f"    tcg_gen_brcondi_tl(TCG_COND_{cond}, LSB, 0, skip);\n")
> +    f.write(f"    {ea};\n")
> +    f.write("    gen_log_mem_address(ctx, EA);\n")
> +    if pred:
> +        f.write("    gen_set_label(skip);\n")
> +    f.write("}\n#endif\n\n")
> +
> +
>   def gen_def_tcg_func(f, tag, tagregs, tagimms):
>       regs = tagregs[tag]
>       imms = tagimms[tag]
>   
>       gen_tcg_func(f, tag, regs, imms)
> +    gen_memory_address(f, tag, regs, imms)
>   
>   
>   def main():
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index 954dea6622..e270a41b8d 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -1722,6 +1722,23 @@ static void vec_to_qvec(size_t size, TCGv_ptr dstbase, intptr_t dstoff,
>       }
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +void gen_log_mem_address(DisasContext *ctx, TCGv va)
> +{
> +    unsigned slot = ctx->insn->slot;
> +    TCGv valid = tcg_temp_new();
> +
> +    tcg_debug_assert(slot < 2);
> +    tcg_gen_st_i32(va, tcg_env,
> +                   offsetof(CPUHexagonState, mem_access_va[slot]));

Can this be isolated to A_CONDEXEC instructions?


> +    tcg_gen_ld_i32(valid, tcg_env,
> +                   offsetof(CPUHexagonState, mem_access_valid));
> +    tcg_gen_ori_i32(valid, valid, 1U << slot);
> +    tcg_gen_st_i32(valid, tcg_env,
> +                   offsetof(CPUHexagonState, mem_access_valid));
> +}
> +#endif
> +
>   void probe_noshuf_load(TCGv va, int s, int mi)
>   {
>       TCGv size = tcg_constant_tl(s);
> diff --git a/target/hexagon/genptr.h b/target/hexagon/genptr.h
> index 270375251f..99dff75973 100644
> --- a/target/hexagon/genptr.h
> +++ b/target/hexagon/genptr.h
> @@ -23,6 +23,10 @@
>   #include "translate.h"
>   
>   extern const SemanticInsn opcode_genptr[];
> +#ifndef CONFIG_USER_ONLY
> +extern const SemanticInsn opcode_address[];
> +void gen_log_mem_address(DisasContext *ctx, TCGv va);
> +#endif
>   
>   void gen_store32(TCGv vaddr, TCGv src, uint32_t width, uint32_t slot);
>   void gen_store1(TCGv_env cpu_env, TCGv vaddr, TCGv src, uint32_t slot);
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index f85f063f52..6d335e9423 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -299,6 +299,28 @@ def need_pkt_has_multi_cof(tag):
>       return False
>   
>   
> +def packet_memory_info(tag):
> +    """Return a side-effect-free scalar address expression, if available."""
> +    attrs = attribdict[tag]
> +    if not ("A_LOAD" in attrs or "A_STORE" in attrs):
> +        return None
> +    if any(a in attrs for a in ("A_CVI", "A_HVX", "A_HLX", "A_HMX")):
> +        return None
> +    sem = semdict[tag]
> +    ea = re.search(r"fEA_(?:RI|RRs|IRs|IMM|REG|BREVR)\([^;]+\)", sem)
> +    if not ea:
> +        return None
> +    # A locked store is conditional on the reservation, not a predicate.
> +    if "fSTORE_LOCKED" in sem:
> +        return None
> +    width = next((n for n in (1, 2, 4, 8)
> +                  if f"A_MEMSIZE_{n}B" in attrs), None)
> +    if width is None:
> +        return None
> +    pred = re.search(r"fLSB(OLD|NEW)(NOT)?\((P\w+)\)", sem)
> +    return ea.group(0), pred, width
> +
> +
>   def need_pkt_need_commit(tag):
>       return 'A_IMPLICIT_WRITES_USR' in attribdict[tag]
>   
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 68d6a64fe6..41151250b7 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -814,6 +814,7 @@ static void gen_start_packet(DisasContext *ctx)
>        * gen phase, so clear it again.
>        */
>       bitmap_zero(ctx->pregs_written, NUM_PREGS);
> +    ctx->mem_addresses_generated = false;
>   #ifndef CONFIG_USER_ONLY
>       for (i = 0; i < HEX_SREG_GLB_START; i++) {
>           ctx->t_sreg_new_value[i] = NULL;
> @@ -1021,6 +1022,21 @@ static void gen_insn(DisasContext *ctx)
>   
>   #ifndef CONFIG_USER_ONLY
>       if (GET_ATTRIB(opcode, A_LOAD) || GET_ATTRIB(opcode, A_STORE)) {
> +        if (!ctx->mem_addresses_generated) {
> +            Insn *saved = ctx->insn;
> +
> +            tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
> +                           offsetof(CPUHexagonState, mem_access_valid));
> +            for (int i = 0; i < ctx->pkt.num_insns; i++) {
> +                Insn *in = &ctx->pkt.insn[i];
> +                if (opcode_address[in->opcode]) {
> +                    ctx->insn = in;
> +                    opcode_address[in->opcode](ctx);
> +                }
> +            }
> +            ctx->insn = saved;
> +            ctx->mem_addresses_generated = true;
> +        }
>           tcg_gen_st_i32(tcg_constant_i32(ctx->insn->slot), tcg_env,
>                          offsetof(CPUHexagonState, mem_slot));
>       }
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index aaafcb0954..ac498b78fd 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -88,6 +88,7 @@ typedef struct DisasContext {
>       DECLARE_BITMAP(insn_qregs_read, NUM_QREGS);
>       bool pre_commit;
>       bool need_commit;
> +    bool mem_addresses_generated;
>       TCGCond branch_cond;
>       target_ulong branch_dest;
>       bool is_tight_loop;

