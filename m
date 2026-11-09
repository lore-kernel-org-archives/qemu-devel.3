Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A9606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KRUAalQg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gPsug6cU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVm3-0004VC-Fe; Mon, 09 Nov 2026 15:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVln-0004PE-QR
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:15:12 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVll-0005Rz-N4
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:15:11 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HGxLG1865724
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UiWU+BJPD6hI3mdA2wts+i6FvUAkYujcvw5meorebZA=; b=KRUAalQgFdj+G9wH
 amYAkvUhDdmGQvps4mtJA9Pl9N4bO+7Po1kX07hKmYKpq+3XUurdGFeunA4eOfSP
 N9icBtRyLVC5W0e59YEek5edNgBmk6uLJn3Gl5A0jsh/JLVnBLtb/ZBtb0NwY2WQ
 sWUEqTl7gHhiDGu5mGSeK8jIaBim6QlKlOxRj3FrI1/NXEVYRPpFl39NqKJ5RE4j
 0LgaOJTdH2N5H7SSpPc1Aqr0XM3KC0FD84EBbh5n/r0nKPQuJoWDKpOkihlMmE0/
 unYkL4f5HFsOy/IZ1b9vgxC/duykdMAtT9ozQffwq07CzWhi97AypjvWzc/ZGco3
 C2TFXA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0qsra3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:15:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-542fc61841eso27657511cf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794255306; x=1794860106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UiWU+BJPD6hI3mdA2wts+i6FvUAkYujcvw5meorebZA=;
 b=gPsug6cULqX/9ztbCCU+LegGqEtcnv8mpT8zomTnqBNfLwq4M+dbnn1E3xwcoI05PG
 RuMGo1IK08N0gERe+dt58P2+gYmY7ALGQsX7HHLLC7JmdsxdbVz1rRsk+2Y2D4uqLzpM
 tAkf8zOpQJ4QRGjYMez/lMJj8d+Iy/18fNJ+E/kB77v8XLfiQZNh0rmIIb3GLxK8nEd+
 cyKQhZ3vqccAYsuegh1KvIH28WWSLpfJwhtTfjOiTwGPrAgJ6zxCwLleEwcNlE5aL71Y
 Naio7qVTr+8vo5uqJP8WsLDpWGxj42JViPS2DYQeJMlkA/sK4yM2mwTZJQDIaomREzul
 pG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794255306; x=1794860106;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UiWU+BJPD6hI3mdA2wts+i6FvUAkYujcvw5meorebZA=;
 b=HGYpI5YqcLGeSBn+H3FyZyJ3ba1XuD3mLW44sdLSyDFPXDDCxpr3Raz39xwd1AtPA3
 atGBr8HqO1hK7MOC2bY3HkQzsBZvARV0QT3NfKjMBjcuzZsdYDGuw8UHq3/ogeY+iRjF
 gC+/0c9S5BZYL6Uk1i44PkyupzAINYWm/AWijoiqGgBCZpqanv7WWtRRM6yqwDAs27li
 /MzkFNMoH5XTdlOvGNdNQ5qWp9bkyBqP6k2dfXO4eOplgUdjBzKugEYDGyJex6O6VnP7
 f9niix7cXFhccVzZJFcFWi3iLcK/WBv2rYsf4mTnfdOQbe8XVSSVfWkTh0HEJJdPMiRm
 N7yg==
X-Forwarded-Encrypted: i=1;
 AL+hErHFTrDwx5KaPuG94AYwVdhFUKagbktHy5rwuvLorqWoQ9ZZPyXvEWhmGdDbI3zsnH33sZ9TSzHVwWCf@nongnu.org
X-Gm-Message-State: APuU4Z8CVPgjBdERCHXhmVFoxsHvJaymELOUfjnnkaQjyP60mwAgdrIA
 SGibpKYdpegHpRIkxtOFL3yRPbxwg1NeKS+XLmVN4k95dqSIw5WV6/2tU+AwoIYp1VSlxqOdUyx
 jnmNcPWb5BgZarQ9t9MIcbiSu2ztfOJm60tpyhRdcZ4bO3xDtdW1ZPe5GxA==
X-Gm-Gg: AYBFou1/C7UupxW3NjlNqyLNBI2Kr8P3FdJ4uerAXIxP0tWQv25XcrUyW57w3WwcFqA
 gih7kxqlwBVnNYeRMlut6ELsDdQBKJkJoYAKC0FZgi9ChTkPVVTKx7dmyUeyiNXtm2H1PDlpNMy
 nGJ57oDkXPXuX2+jh/4Yr75udInOAwqLAPjTpDMCqLoAfoKGpL9YPbPptom5zat1uJDHprO0/wj
 uYUpDMNS+rm0ZLBG/Xa27EzLRub6MJ2QluXAbLfwr+gru2wJLWQ5yF6B30/0qcX731itynS7CAI
 o2J4lAjrCvuRy91Pz+QMO+cxTx3mshueqAwoXCOi6FeivMqRGDLVMz5hBJVs8a4aSMKvgC0HzJd
 UHoOt5+kQT1vd/wC/2n262m+lIyK+rFEOpEloADdm/5YmgR8lhl+kUwbkKBAH2jK+FgLgsaXOZh
 ogVBQ2bd5u
X-Received: by 2002:a05:622a:5b85:b0:535:2db3:c05f with SMTP id
 d75a77b69052e-555284f5d51mr7062711cf.61.1794255305500; 
 Mon, 09 Nov 2026 12:15:05 -0800 (PST)
X-Received: by 2002:a05:622a:5b85:b0:535:2db3:c05f with SMTP id
 d75a77b69052e-555284f5d51mr7062241cf.61.1794255304833; 
 Mon, 09 Nov 2026 12:15:04 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550b942e83sm5626491cf.18.2026.11.09.12.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:15:03 -0800 (PST)
Message-ID: <ac3eb49a-72bd-47de-8386-0c6cc2aa8382@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:15:00 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/38] target/riscv: rvv: Implement Zvfwdota16bf
 instruction
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
 <20261104194155.679241-14-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-14-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MCBTYWx0ZWRfX5eoF6dM3D4c6
 zgHzzCDUA/A4y7tTBlEdzyHu9z2+INDy03v/EYOqGRVf6VuIefaKjB+E3kpb6Eu4R/oX4lhySTD
 dQeQURL/TT9vG5qfw8I1h8VoUcZQe0zY+RY40rM7moPuTAwJWP0IKGoqz825QRKbMQB/JNaB0lN
 Ur9NhwnPIlH1Id6JNrk7zee/k9rVl0BQpH6VkQria4YAmR8nswBZVLXLadyopeUvnHSZYZw8clL
 E6sZKA58+fkDLpGWy7AgaX4B/5v4ntX0JXthbSw7aaOHCbg2noFllZ3sqWAJG6WHhrWkR7p3a5P
 7oIFKeHcPPwzbmCJqd8nTU6d/UIdNu4YmT5V0DWKf143kYx1+lj335KQrEIC+1sYEp0j6H173Js
 u2AjXJalBmwkOWNuNQphFLmV+XtUYWFYcUILtVGVvH4OBtxs2lwfcavOs0H2pfelJq8PWEsTlTa
 TpaHRWZr8VR0yXH542w==
X-Authority-Analysis: v=2.4 cv=DZuCOftW c=1 sm=1 tr=0 ts=6af229ca cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pFyQfRViAAAA:8 a=x5J11q0p18l5my3RchUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: QDvrbok2M3gZM3fy3ilngtBkQtuSygbL
X-Proofpoint-ORIG-GUID: QDvrbok2M3gZM3fy3ilngtBkQtuSygbL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MCBTYWx0ZWRfX/9btDjhrVc6r
 SQQmW2zysHO05gIJLcdR2Gm61PbA4ZGbQIr83wfHbj7agXOPoz4qThx/Uur6cM/ThWOi4HMxtoz
 HW3udTQMSlYvNSt41huF1j/kNu4E1UE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Implement the vfwdota.vv instruction from the Zvfwdota16bf extension.
> This instruction computes a dot product between two BF16 vectors,
> accumulating into an FP32 scalar in vd[0].
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/helper.h                       |  2 +
>   target/riscv/insn32.decode                  |  3 ++
>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 42 ++++++++++++++++++
>   target/riscv/tcg/vector_helper.c            | 48 +++++++++++++++++++++
>   4 files changed, 95 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 23d3e9b3c43..918ff21b3e2 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1393,6 +1393,8 @@ DEF_HELPER_6(vqwdotas_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
>   DEF_HELPER_6(vqwdotau_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>   DEF_HELPER_6(vqwdotas_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>   
> +/* Zvfwdota16bf - BF16 Dot Product */
> +DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
>   /* SiFive Custom int8 Matrix-Multiply */
>   DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
>   DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index b8a5d0567b1..d800ad99451 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1101,3 +1101,6 @@ vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
>   # *** Zvqwdota8i/Zvqwdota16i Integer Dot-Product Extension ***
>   vqwdotau_vv  100110 . ..... ..... 000 ..... 1110111 @r_vm
>   vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
> +
> +# *** Zvfwdota16bf BF16 Dot-Product Extension ***
> +vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index fcff472a2ea..c50f863ea0b 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4200,3 +4200,45 @@ GEN_ABD_OPIVX_WIDEN_TRANS(vwabdau_vx, vwabd_vx_check)
>   
>   GEN_ZVDOTA_INT_TRANS(vqwdotau_vv, vext_vqwdota_check)
>   GEN_ZVDOTA_INT_TRANS(vqwdotas_vv, vext_vqwdota_check)
> +
> +static bool vext_vfwdota_check(DisasContext *s, arg_rmrr * a)
> +{
> +    return s->mstatus_fs != EXT_STATUS_DISABLED &&
> +           vext_zvdota_base_check(s, a) &&
> +           (s->cfg_ptr->ext_zvfwdota16bf && s->sew == MO_16 && s->altfmt == 1);
> +}
> +
> +static bool trans_vfwdota_vv(DisasContext *s, arg_rmrr * a)
> +{
> +    if (vext_vfwdota_check(s, a)) {
> +        TCGv_ptr dest, src1, src2, mask;
> +        TCGv_i32 desc;
> +        uint32_t data = 0;
> +
> +        gen_set_rm(s, RISCV_FRM_DYN);
> +
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> +        data = FIELD_DP32(data, VDATA, VTA, s->vta);
> +        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);
> +
> +        dest = tcg_temp_new_ptr();
> +        mask = tcg_temp_new_ptr();
> +        src1 = tcg_temp_new_ptr();
> +        src2 = tcg_temp_new_ptr();
> +        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,
> +                                          data));
> +
> +        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
> +        tcg_gen_addi_ptr(src1, tcg_env, vreg_ofs(s, a->rs1));
> +        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2));
> +        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
> +
> +        gen_helper_vfwdota_vv(dest, mask, src1, src2, tcg_env, desc);
> +
> +        finalize_rvv_inst(s);
> +
> +        return true;
> +    }
> +    return false;
> +}
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 41b526d25ef..5947427b6b4 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -6025,3 +6025,51 @@ GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_b, 32, 8, uint8_t, H4, H1)
>   GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_b, 32, 8, int8_t, H4, H1)
>   GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_h, 64, 16, uint16_t, H8, H2)
>   GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_h, 64, 16, int16_t, H8, H2)
> +
> +/*
> + * Zvfwdota16bf: BF16 Dot Product with Accumulation
> + */
> +void HELPER(vfwdota_vv)(void *vd, void *v0, void *vs1, void *vs2,
> +                        CPURISCVState *env, uint32_t desc)
> +{
> +    uint32_t vlmax = vext_max_elems(desc, 1);
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t vl = env->vl;
> +    uint32_t vta = vext_vta(desc);
> +    uint32_t vta_all_1s = vext_vta_all_1s(desc);
> +    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb >> 2;
> +    uint32_t i;
> +    bfloat16 *a_vec, *b_vec;

Although we don't have any existing instances of it in the code, it is perfectly
fine to do:

+    g_autofree bfloat16 *a_vec = NULL;
+    g_autofree bfloat16 *b_vec = NULL;


Sparing us from calling g_free() on both arrays later.


LGTM otherwise.  Thanks,
Daniel


> +    uint32_t dot_result, acc;
> +
> +    VSTART_CHECK_EARLY_EXIT(env, vl);
> +
> +    a_vec = g_new0(bfloat16, vlmax);
> +    b_vec = g_new0(bfloat16, vlmax);
> +
> +    for (i = 0; i < vl; i++) {
> +        if (!vm && !vext_elem_mask(v0, i)) {
> +            continue;
> +        }
> +        a_vec[i] = *((uint16_t *)vs1 + H2(i));
> +        b_vec[i] = *((uint16_t *)vs2 + H2(i));
> +    }
> +
> +    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
> +    dot_result = rvbna_dot_bfloat16_bfloat16(a_vec, b_vec, vlmax,
> +                                             &env->fp_status);
> +
> +    acc = *((uint32_t *)vd + H4(0));
> +    *((uint32_t *)vd + H4(0)) = rvbna_final_f32_add(dot_result, acc,
> +                                                    &env->fp_status);
> +    riscv_cpu_check_fflags(env, pre_fflag);
> +
> +    g_free(a_vec);
> +    g_free(b_vec);
> +
> +    env->vstart = 0;
> +
> +    if (vta_all_1s) {
> +        vext_set_elems_1s(vd, vta, 1 * 4, total_elems * 4);
> +    }
> +}


