Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C8606A33E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F3YL+0Pp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TUC128JN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAND-0005dL-QQ; Thu, 19 Nov 2026 17:12:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUANB-0005cY-M2
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:12:53 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUAN9-0006sg-8s
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:12:53 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1mQi3148722
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wIHwm052QZ+KzJFmywSgLUJnL/p1QR39AKReFWD3K9s=; b=F3YL+0PpwpdHQ1/b
 PgsfGUwF6b8FnpLGJeN+naMC6JegNaUbdEEy+e1OSpbYGQSOSSUw92PdmTltDHgf
 W6KAV2vYtCgsxq/iA7scy1u3c9yUAebhM5Ry5mkheR8oY8HK81lj87yQpt/bWAov
 69Fe9UPzJu7EFKx+maZ/PaQSUrnEB8q6rUifUQxC8Ps3s8Zs1DkvIrTSgDnpE/pG
 YsqNBwfolsJCMb+YM2uZbNYjUCHBtil0Gf7UNJZVhhO9UtTkeaD4hBsuv2vwaBmS
 UCerBcsooiQrzVCZ39QBOFy6q+Z9eW9lMWprvdm8KsVP7XbPB4YoGcE3XN/kdblG
 DH6S9A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yx6b2xc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:12:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9495a1f5e47so53444885a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795126368; x=1795731168; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wIHwm052QZ+KzJFmywSgLUJnL/p1QR39AKReFWD3K9s=;
 b=TUC128JNLTRTTwi6BtPeSe7mebWwACkRoWqodBtzzREJhjfcjpLWovFG36OaeL6SeQ
 BAPYNBdZ2K5rpMrnnxiRXiRIogQ/YpEIj3cC0tT26SNJqi4SEgWL73ebDfEQIVnktvFG
 gRhhjhlUVCSMsufrS9WMo8VGqX6qplUvPZjPiWoeAQItup+2TRNh0Zh3MD0MrJFDDxm4
 OV1WTxCt6rj8GnbUNplxUjzOhcdrByvAU5o8q+y5UL3UeSeGhKkLrPDEMs8945Tcgfxp
 M58jAWRO9NsDjEj25L+1LBPiIyb52CZCo/YQ5yy7hEblsNmUdEIEk8kJnHBMWyX2rceL
 ArIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795126368; x=1795731168;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wIHwm052QZ+KzJFmywSgLUJnL/p1QR39AKReFWD3K9s=;
 b=ijh6BLfz3ibWuMuH9jogFFsQ7PMu/IPMIPQr2E7JHhU/NIvf2osMIsNGgfgm0NcFdG
 BXDU6wUQhncCwnQYll46f19ap6Kx7vEHqLb4i5Z6Rus/wFt/UasBjL1PJ7YM7Ylpt9I2
 o09U6EzWJc60FQkiJYseEWeCJkJ0brcA2BijO95p33YMXQatUYovjKNzQipKJan271A1
 HSW/F+Zs1Wx0jPQvZZ2atNmOAFdSUSoIMwNkR4H5pXt8SdR1YvryywwrYln/Q+cjUViY
 gupSFgH45ZlNliQHY+OQfxCCFwPWxVNYVr1ta6cKO5kvN38VJNvNrOmUpVu8U/tOlt41
 8Onw==
X-Forwarded-Encrypted: i=1;
 AL+hErEQYW8T+5Qh+HdQKNP9Z9ZYgV9ToGBcLgQwRdKD/VvnVMZ3Y2RWx+liX2q6vzkKOjMvej7+6iCS5wJf@nongnu.org
X-Gm-Message-State: APuU4Z/DCKWIepnTT3tWJAro8ggO5VWBY2dbd51qyr0IRWodd7oaGkfe
 sHFJoOH6ZQcsAg683zj+8GgSJ/KAzZ/6PJiLf267OPnRV5Clpi8/4egc8I6Oexk3aZMw/vA212k
 jdYLHFQ3wJQFyNgncDS5BCZsdAWnrgUvx31RpGlCkVQ4vKXb6rpGJZKaL/g==
X-Gm-Gg: AYBFou0cAylW5+zhU1zk5+Nuhh1BlYNkvzi8jlf5ZoYAHOlNpF57Puw1xFs/OtQH5Fb
 iXP1T+gIILA2KDGfLgqdvTSwEoqhtngqlZf9aaxkCPTCC6+GJQI7vVgRFztJi1uNmKUzi0izOfV
 NFsbSUUe907vOnVTdFb+0ZYdEw9ylRkMCaXZNpVMkBzZGoEXQ64MMROvJ+haa3X8ncyi4SlRfiM
 z3A9L9DTT/cXESyeVPep9INhjXjVBBeKRXKnwlZqC+vkQCqMGrQuV81ly3QXOpdQQbZjMlpS3b/
 rlTi+SmTUOVvDO60+lvBQNYJXkOPywfLb1JB+QrZdWKJGZATlmhcoxW2toh7C6vb/zoOvx8QFh6
 vRXGbRSbQwB0CJj0qCsrnL9GpauTbxJ4tBtZxQ07Uuhx9Yx/hnkZuKfxFcz1ZScS5slzuntyjnL
 738bjt++ERD8eV0RiQ0Z3T7Z+sPuUGh/IgGRsDlg==
X-Received: by 2002:a05:620a:f10:b0:949:5ee9:ab27 with SMTP id
 af79cd13be357-949bab4dee9mr180756585a.83.1795126367993; 
 Thu, 19 Nov 2026 14:12:47 -0800 (PST)
X-Received: by 2002:a05:620a:f10:b0:949:5ee9:ab27 with SMTP id
 af79cd13be357-949bab4dee9mr180752385a.83.1795126367414; 
 Thu, 19 Nov 2026 14:12:47 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb0319fcsm63201885a.4.2026.11.19.14.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 14:12:46 -0800 (PST)
Message-ID: <725cd0bd-491b-4e9d-815d-f8830db96c88@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:12:44 -0600
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
X-Proofpoint-GUID: CrWvVPWj3MrovAJ8W8IWGptF77kiZuWE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfX2KiZbQmTYyHq
 pUsN2uPtIAAe2NsQHgi3PDahEXFcJgMCKb8tW1LoZNA6LAEnr1Rk7fTkNwPWTOUSYxpm9CB3S5K
 bGXI1bbNAvfCcfMgot4FLtVmyDP17c8=
X-Proofpoint-ORIG-GUID: CrWvVPWj3MrovAJ8W8IWGptF77kiZuWE
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6aff7461 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VQ_LU4iI7PEz2cgcdtEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfXxy2c2fMbmA6j
 0oMuCQPkUfPTYio5LuNdXG93XFRVh+ZcCbvsZRKbeEI6igK2UrS9+Chetdglg1bE5SpQ98qNYuE
 1juXrADd7X9QtGXW5z/Cn2O8kAiDEMB6IW5xxfRrvU/AXQsUUSu53smj93C/HpAKCZNyh/mzmw0
 7+sb148qQ+uFJz29BohtuEH+tamOsxTeWUGA9v5+WIZrgb5iiHLGVLJS3gx25zbT/AIzmqiHzLk
 fE5awFFwD2V0MRJZsJ4jg0TW5Ri4htVqBZODMBG9f7dt/Gox6H3LGygZSHwc7Ugyrc6Y3axZfvb
 vSz0CR83EUxJxzePw29XbYm2ojt9KWgXOIVfSO4futZ/nz1j/RPvuoI+uKndKfw6PuZ66IVgU3O
 Oc2r519xFQSbTxWccNMAeYAqqrqQTA1iydZkLSTxWxurNE+jPTxT2SoK8ax2brFgTJohocN570m
 L2u/BhoPSxu5yqWGcVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190089
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

This is clearer as vaddr.


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

Can you use an explicit TCGv_i32 for va?


> +{
> +    unsigned slot = ctx->insn->slot;
> +    TCGv valid = tcg_temp_new();
> +
> +    tcg_debug_assert(slot < 2);
> +    tcg_gen_st_i32(va, tcg_env,
> +                   offsetof(CPUHexagonState, mem_access_va[slot]));
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

