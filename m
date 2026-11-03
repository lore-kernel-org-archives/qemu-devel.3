Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D534606A32C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ET9oKiyR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=exBpHfM8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOHnN-00021B-2u; Tue, 03 Nov 2026 11:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOHnJ-00020q-Lw
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 11:55:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOHnH-0003a5-0V
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 11:55:33 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3EA1iM2001428
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2026 16:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pg/Fn37HUJYh9o/8jX4eOn5CZLB43T+s7H37OxiOwVo=; b=ET9oKiyR1gTayHXy
 QFsH8dK+2RTASDlYnzD4MPN6PFP40Zc5N7vO/QjFhLRRozWYBMUp+mc2kyZqxn4R
 BFF6Ag/5VUyiu7IzHiYTqd6kEjYRUcZV0uaLBvvurmy3RP21zDn8PhdTAqjNeyAR
 4p15/3l2lT7/5a/UHHkodOBvNelRtNBR596ulQBQ3bZqvvT3cEJiHPFE7N50qTTh
 +fw9NHYvV+Huy/bJzDSRck07i0H/2fw5wtOtvvSZOEfHe/VcOe7NKKfxcmMa3RWG
 xFme1JjwAaDR1pOFC+k7Y46xwO6s35qAXO2tTQmsNlIxxW8DDfSVDYy/2CbvDOVr
 XXC9WA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq8u5jv8y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 16:55:29 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-998a2b06e4eso15814241.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 08:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793724928; x=1794329728; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pg/Fn37HUJYh9o/8jX4eOn5CZLB43T+s7H37OxiOwVo=;
 b=exBpHfM8///xOQEBv6uwDCVYxveXlMEQBDLGDFhnON7EtcXPtkE4ogHkom/pHrQNc1
 hCFrQTJewS2qmZkVe15fEfq6uLZ56+uTu5wItCR3F3H6DrNXiz6zkl6QrM7gNIWhUYcw
 ib2SZ6/zIEuAb9LnW6Kalk95g5QsN7u9bLf1oHvcR8cymko5ouW0a4OdiDJn8+8KstUD
 y1oIcgpe9EHCfNyRoHxZjtgCQHgQ3Xo4O2w7fmHB3aa7sm/xBUWNl/r1yvRI/zMXLNav
 rPCZQppnx/BFXsUmxK5XCXi883+Uj1qmOsT1SW1XQI7/gMp03BdpDPg91LWAVvkPeUFz
 hpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724928; x=1794329728;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pg/Fn37HUJYh9o/8jX4eOn5CZLB43T+s7H37OxiOwVo=;
 b=i2ZcI7+WPFmlsIPJljsLMlXaJcOquMOLEl97/wZoxB4UsFHWcxLqz37SGf91EF1MBn
 UFr+oj6JdL5y8JNbG685F6pEzdxEqLDPK1IzZMnGgWG0YZ1f7AH72QRu1fi7l7ti6Uzb
 6o8eqnop9UN9B+XHNzBSGdf1bszpBn75pUczN2PjfxpCB9FyyOcjrfa+Xqu3YQW07YRL
 1LH37nCpJ5J1c8uPxGpAOpw/JgyxnFjyXWTSfIObxuB6jAxRZ6Lzsj6fAXsuw41lcgox
 fF9GYlRFnLk+b1oPXItc94/flNGfDLC5qewv2UBgkJ/X0wOs0zJwD0XVhjHfv6KPPY4q
 ev7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZeQb11pNJRpL273Zn5zb9uYt2InIeGovbZeyeDu0q20VpIZWcOZYR6cAjVDp6fgeKlx5rGP8nV3Fu@nongnu.org
X-Gm-Message-State: APuU4Z/NXaXZbMjM/djvq70esXelaCWLAoubozWgXyuZmrTedEafe2vW
 d3tbIaA5R/lU7j1oI7Uo7vpGj3XGKmpj+ywCE+RrwR8290NGYmJjp1XvlDM3eLi8AnKoIDYwgHq
 mNDjMgTfGoRB9jNrTXXsknqT25yi+vlP9qpohTCCEnik2gxHukcrsD7aO+Q==
X-Gm-Gg: AYBFou0VgNoJy6ekb2Fx1/YzKO9jXke974yo6LKFFPxDAds3xiDbqwPleLqngECZ8yw
 v+YGbCzdS2Tatg2p88isP/lKQMznuNYHdUNyOstjQr/Vv1i4uoj6o168iB/WQCHcVV5SdobIzfC
 CdWDRMsNlqHHjlQsmLXkcQ2CJe7vbXfiFQlVy2wzRiB/H6BbNYpBkyB1r09WBoGRmOIHRPeWoan
 I0JK3O27b+0JdJA1J+XS/xX2c+51mTUq9LmgAQTIpkTiIv4fDIWNSjgvrI7Tj903o7VB9dYekrl
 KnIINf6vJliz3UOQksKvp34c7yPTkIIO2nWs6Kh+2oUAj8BE/Vu+Up6taeaGqkI6wAIgTu8lT+c
 cAnhQWC5/viRUMC/2U2XhSv44PBUF3WV4sdKXjO8Zo87LMjioDmPJmKWlqfwl4KyGN2OyoxoC+3
 7YFQPllgk9
X-Received: by 2002:a05:6102:512c:b0:7ce:6474:720b with SMTP id
 ada2fe7eead31-7d07272e9a4mr4531451137.23.1793724928332; 
 Tue, 03 Nov 2026 08:55:28 -0800 (PST)
X-Received: by 2002:a05:6102:512c:b0:7ce:6474:720b with SMTP id
 ada2fe7eead31-7d07272e9a4mr4531438137.23.1793724927737; 
 Tue, 03 Nov 2026 08:55:27 -0800 (PST)
Received: from [192.168.68.102] ([152.234.122.253])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d1cf09b4e6sm514158137.4.2026.11.03.08.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:55:27 -0800 (PST)
Message-ID: <b8da8748-a668-4481-b483-66f333a0614b@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 13:55:24 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: add support for the hcontext CSR
To: Arseniy Semenov <ar.semenov@outlook.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "antikostya2@gmail.com" <antikostya2@gmail.com>
References: <2b1cfd78-2a92-4077-9ab1-a2c865d6d673@outlook.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2b1cfd78-2a92-4077-9ab1-a2c865d6d673@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TmWh27RIy3jzqd3nZkco9ZoG8rzpkdbt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NyBTYWx0ZWRfX0YnI57RLPS+Q
 fsxA4X6Rs/4uSJ5nRMWAoMh6kDcZMWElL/GmVPDQS9uMeTqY6wxDICfyHMiDbLiP9KfoXCCz2dU
 FAAzyeULQGESsjwKJMfHmxOkrpXwd3E=
X-Authority-Analysis: v=2.4 cv=RZ0FmFtv c=1 sm=1 tr=0 ts=6aea1201 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=LQvE5zGBNe+6ot3hfEwogQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=UqCG9HQmAAAA:8 a=vnr7sMAykzA4DXE1U6EA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: TmWh27RIy3jzqd3nZkco9ZoG8rzpkdbt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NyBTYWx0ZWRfX4QeaPd8pbo7r
 s54D2jIjVwcmMLwknBvUfwb95QZfMYV8OYV71UgZzyRoo7qyHgvFMyZdP2aA5WG3OdTQuH+2zRj
 gzT7EjhSh4jKMBjPBJtdT2n/3v4y2jgbTl2B10BQHdhtvC/MGbNl3QCLAA4s7rxwGeiCJejwaGi
 40KhGPf/ri0liamZYRK5uLuu+nynKANoWRVA8HJqEC7cpvkLWrKh9KTSd27+pESRccir6T3BVUJ
 vSQvjygUBXTIANXcsjmNsivKnj0QSjNnDk3sDv0Czb6qdYOhrnp7x89V2FgHnehVuSElwfa0UsB
 2wzCuIJbHu4VMoqzPtBoYQrOZAcRk+LL7h3o7/VCX+s4OyXARYEg9YG8Bwv/tXN9Vpm/C/F+Tr+
 W7x49NbsVtmLRg6w28pJL9JO0z1Z9nPZMKi14crcLn0jWs7htibd4KPwro6JuEWxDOFYd2Q6Sav
 TOt3H7LMghy2KpUwwgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030067
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/30/2026 2:25 PM, Arseniy Semenov wrote:
> Implement the hypervisor context (hcontext) register described in
> "The RISC-V Debug Specification" Version 1.0.  The hcontext CSR is
> accessible from H and M mode, gated by the Smstateen HSCONTXT bit.
> Writes are masked to the width mandated by the RV32/RV64 xlen.
> 
> Signed-off-by: Arseniy Semenov <ar.semenov@outlook.com>
> ---
> This series adds emulation support for the hypervisor context (hcontext)
> register, as specified in "The RISC-V Debug Specification" Version 1.0.
> 
> The hcontext CSR (0x6a8) is a read/write register accessible from H and M
> mode, whose value is derived from the mcontext register.  Accesses are
> gated behind the Smstateen HSCONTXT enable bit and writes are masked to
> the xlen-dependent width defined by the spec.
> 
> No behaviour change occurs when the H extension is not enabled.
> ---
>    target/riscv/cpu_bits.h |  1 +
>    target/riscv/tcg/csr.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>    2 files changed, 47 insertions(+)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 3579789a1f..bfa10afca8 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -456,6 +456,7 @@
>    #define CSR_MNSTATUS        0x744
>    
>    /* Debug/Trace Registers (shared with Debug Mode) */
> +#define CSR_HCONTEXT        0x6a8
>    #define CSR_TSELECT         0x7a0
>    #define CSR_TDATA1          0x7a1
>    #define CSR_TDATA2          0x7a2
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 063590f56a..db1c8e58f4 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -814,6 +814,16 @@ static RISCVException debug(CPURISCVState *env, int csrno)
>        return RISCV_EXCP_ILLEGAL_INST;
>    }
>    
> +static RISCVException hmode_debug(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_has_ext(env, RVH) &&
> +        (riscv_cpu_cfg(env)->debug || riscv_cpu_cfg(env)->ext_sdtrig)) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
> +
>    static RISCVException rnmi(CPURISCVState *env, int csrno)
>    {
>        RISCVCPU *cpu = env_archcpu(env);
> @@ -5703,6 +5713,40 @@ static RISCVException write_mcontext(CPURISCVState *env, int csrno,
>        return RISCV_EXCP_NONE;
>    }
>    
> +static RISCVException read_hcontext(CPURISCVState *env, int csrno,
> +                                    target_ulong *val)
> +{
> +    RISCVException ret;
> +
> +    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTXT);
> +    if (ret != RISCV_EXCP_NONE) {
> +        return ret;
> +    }

I am not sure if this smstateen check is correct.  Sdtrig spec says:

------------
Hypervisor Context (hcontext, at 0x6a8)

This optional register may be implemented only if the H extension is implemented.
If it is implemented, mcontext must also be implemented.

This register is only accessible in HS-Mode, M-mode and Debug Mode. If Smstateen is
implemented, then accessibility of in HS-Mode is controlled by mstateenzero[57].
------------

Note that smstateen check is only relevant for HS-Mode.  M-mode and Debug mode
must have access to the reg regardless of Smstateen.


> +
> +    *val = env->mcontext;
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_hcontext(CPURISCVState *env, int csrno,
> +                                     target_ulong val, uintptr_t ra)
> +{
> +    RISCVException ret;
> +
> +    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTXT);
> +    if (ret != RISCV_EXCP_NONE) {
> +        return ret;
> +    }

Same 'smstateen' observation from above.


> +
> +    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32 ? true : false;


I suggest doing the short version:

bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;



Thanks,
Daniel


> +
> +    target_ulong mask = rv32 ? MCONTEXT32_HCONTEXT : MCONTEXT64_HCONTEXT;
> +
> +    env->mcontext = val & mask;
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
>    static RISCVException read_mnscratch(CPURISCVState *env, int csrno,
>                                         target_ulong *val)
>    {
> @@ -6620,6 +6664,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>        [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
>        [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
>        [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
> +    [CSR_HCONTEXT]  =  { "hcontext", hmode_debug,
> +                         read_hcontext, write_hcontext },
>    #if !defined(CONFIG_USER_ONLY)
>        [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr,     write_dcsr },
>        [CSR_DPC]       =  { "dpc",       sdext, read_dpc,      write_dpc },
> 
> ---
> base-commit: a19f59a72d96056d9a8f48cf6c77f5787491e414
> change-id: 20261019-hcontext-e8e8f54989a4
> 
> Best regards,
> --
> Arseniy Semenov <ar.semenov@outlook.com>
> 


