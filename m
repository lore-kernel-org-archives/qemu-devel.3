Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFFA606A680
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UN5o7e2C;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j0CeBxAR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVUEJ-0001of-IT; Mon, 23 Nov 2026 08:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVUED-0001kc-Hu
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:37:06 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVUEB-0001KX-M8
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:37:05 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDKwBG2442739
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6AoQpW+ymI45nH3l0UGKC6lF6pJ+YGQ/TXcjiLHKz3Y=; b=UN5o7e2CdfObcLaX
 JHqyhDorXY9TR69JGvgfIM1y2r9DMfR4cEbhu5GSXVS8t7VdVXVtX4FPCCdBkTlA
 bWFUf4Sfye6m3bBy3Zgx4s96o/a12cFmWPN70YhOoAPtgOG+Wi2vDGJjguL7l8Uy
 u51eAQGgdfthv1idnRWi3RKzCF0fOMAhN3KSFN5/BxF9ouFOZjTqOgS0IC0HMG5U
 Qk3U/OMa9tUjO4w/HMVdfG/HUVImt6hc6q1pP0Cf2FDq8HtI9c1JD6a/rHv3XP+f
 Bffya2ghN6iC3BkvfRWWfUOQOkc1yqKt6F+332N2SJS4dShyKAFQT4z05f9We/I0
 wje+Ag==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k1kjq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:37:02 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-921273a6cacso49858906d6.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795441022; x=1796045822; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6AoQpW+ymI45nH3l0UGKC6lF6pJ+YGQ/TXcjiLHKz3Y=;
 b=j0CeBxARFJk/SrvybH8NeQ2rOVJ7F9lAXK+I4wxTg01jZ+LvAjblKormux78F2Od+N
 UVYDz8qhbrQgnlYLZandIAGWYtCtuM2uDDthoHfD6tzqcObR/rVLNluIUHTGse/Tn0N3
 hsF/ks+koTHY7IRPj5oHSoTvaoUll1WPkJD2SCrUpPT8v+0f6H4OHxCIJxOQCT0hbrTY
 dxp2TKay5RFH8dG7BEmJr1c5KqXfVQEHj4r6AdpkyYJ3qrFIvbvYqOsC08lSEvQmzvYn
 0kUBdF27uDwGZRsvNkI76g9jDDhOE948YUsg9++A+QEESBYWz12Z3kUK6tu8BEzIzGQO
 BsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795441022; x=1796045822;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6AoQpW+ymI45nH3l0UGKC6lF6pJ+YGQ/TXcjiLHKz3Y=;
 b=Wi3IVwpYzKZFMNTcASzgJ4SPWYTQJuWpo2IKTtKHhDGLmfi+sc52+Dtj37xutrfwXD
 Guxhrhu9ss8D2+Md56KGKxaXUbehjHwCBH+KNLV8kwnZxN2ErNRpjgjqrg6Ck6K9BEFI
 Gwgco3j5NtAzZyzs0vJzZzccxRWzQ2fEP8ks/0VQ9JkuUMYoiQwOS4vAl9jyTAoH4zq8
 3HWf+VcR3QV63iIR7X/KNpiYx9g8JGO0c9/i8fxBCsydkx7Kyiy2nYh/113FnkpOtsAk
 v2MSy4Umj3CW6S7pCEVusCrw7+x5ZbBGm5qcsZceDohxUgt0HabAmFX5+PnIszaEbDBH
 YwzA==
X-Forwarded-Encrypted: i=1;
 AL+hErEFzQ7p0n+YhxOcPFwpeahujGYpkfh4+C1ktvUq8YyLbfMncvvpn7XMjnjJ0GT0mS+jOWZjUv74brGN@nongnu.org
X-Gm-Message-State: APuU4Z/xMh6AGDH4GShUL1yTsJi7rcI8c1qGXQrUjURl9z7+iyrCLfK7
 hEuIbQ+cUdMyLEclP7cuMOLJsrAs7EvASWzmV6Hp4v39ybKE8ROYqmJR577DvgUbEWP7w0jPWUF
 prciRX1MwxGVWkOyPZT6CCoWnQj9Nf164GuRjLnHaU6s+OiaDDcfpeo9uDw==
X-Gm-Gg: AZFdTZeViBvRNAY7HnaWsl7h3mOR7mEP+YSnHxtHmp33C2w1I12PiA5oAAsu66q6psB
 MfaQc1I5Lgqm1j9vqpqddYVRoCoibEK/9IALskp89WJUbwubREzD+875NSCggkQ/UzBKrVezKdM
 Ao3032HlO38+SHfWZDpebFVFaSGevecrqo1XHouAUaXUwZe1ilXEM8gI2q2YGOeoxM0zHFMsRDq
 RHh7xXBABCJC7cvdSXiCXzj0uXfwfLicxbMbEtXzK3JBxKMmlrJENyz619wPY6MPwTBDE4NBknO
 SF45Z8QFigrRbsn7gZ0VYZkOLVcHkf2OiIGYmJyu+h4ovcKMUGasC/U78O4CpSrftKXFuS8t54q
 t2j4U/7CQ4pLhXFljg5e4C2CLIuVKCBcuct5NeqS+CULpaAExJZovKHM3fEjD1V+Lelekj2L281
 d+IHyp32WI
X-Received: by 2002:a05:620a:2610:b0:947:920d:3408 with SMTP id
 af79cd13be357-949bab188famr2031572985a.46.1795441021559; 
 Mon, 23 Nov 2026 05:37:01 -0800 (PST)
X-Received: by 2002:a05:620a:2610:b0:947:920d:3408 with SMTP id
 af79cd13be357-949bab188famr2031566385a.46.1795441020994; 
 Mon, 23 Nov 2026 05:37:00 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949ca846322sm615464785a.34.2026.11.23.05.36.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 05:37:00 -0800 (PST)
Message-ID: <f2ff2235-807e-4292-a559-1f892c810805@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:36:57 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: fix WPRI handling in mhpmevent CSRs
To: Dmitry Kokorev <domestos48@mail.ru>, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, chao.liu@processmission.com, liwei1518@gmail.com,
 palmer@dabbelt.com, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
References: <20261111200924.49157-1-domestos48@mail.ru>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261111200924.49157-1-domestos48@mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfXzNrs+u9UWy/P
 FGExK18lGx3aHpza1NMLChML2HGvEQiwAYJTZJwjQ4nsD+sakQsu+Xx8mnY4uIZNTfU6bM7OKe7
 oxBzdi6VCDBTu36QmoZ4T+DG96ubm/s=
X-Proofpoint-GUID: m4eetfrtPtw-2--yBDp6P-utsqx7_-KN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfXy8lOpCAfV+pA
 7nBs9fDceVNhsmqPk7Y1jLlkciZEW40DKDj3AHs+eRuHWv4WhjXfq+xC8T8Ql6JB9egdgGHMiQh
 OCbWzva2c80gIm2LojVYR50O2tShsCmRamxp48xEGJVYn15JRRaGaUAVzdz7A9lAPqUeDOm2Gwg
 bBzAccYiXFsghuYUBcX4pbS0QgnkQpuELsGCsadRdpxQ1dCKkO8ZJL7RXNZsC+OloMR3PO3F0nj
 T1jDWZOF1tBzwtx4UrJqD7pKXBEYLKoLw5FnM1hZsnDLbgWl1lOsLqkUZMDpe/sGrUyMuUTje5B
 l2mbSiM3buMcCTc/r0W3l2YEaImhpNOG0M/yKMwYBF1DsmRrYHpmerqY9y6C3uIXGbLKFM5zOLu
 kfqMgIyqv+Vp9NRRFqrnNhhZ0NM9aYRMNCrcf7C63gfm93e0OJ3V+Soh/DxlWGMNvvSuQmoWqBW
 77s8Qdn7UeDBeqnVU/Q==
X-Proofpoint-ORIG-GUID: m4eetfrtPtw-2--yBDp6P-utsqx7_-KN
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b04417e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=JF9118EUAAAA:8 a=RgBw9RmQAAAA:8 a=EUspDBNiAAAA:8
 a=LDk848BDNixZ8QLvqFcA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230054
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/2026 5:09 PM, Dmitry Kokorev wrote:
> Writes to the mhpmevent CSRs can currently modify the
> reserved WPRI bits 57:56. Fix this by ignoring writes to
> these bits when writing to the mhpmevent CSRs through both
> direct and indirect CSR access paths.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4722
> Suggested-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Dmitry Kokorev <domestos48@mail.ru>
> 
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> v2:
> - Drop explicit preservation of mhpmevent WPRI bits.
> 
>   target/riscv/cpu_bits.h | 2 ++
>   target/riscv/tcg/csr.c  | 9 ++++++---
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 3579789a1f..3df9ea4ec3 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -1161,6 +1161,8 @@ typedef enum CTRType {
>   #define MHPMEVENTH_BIT_VSINH               BIT(27)
>   #define MHPMEVENT_BIT_VUINH                BIT_ULL(58)
>   #define MHPMEVENTH_BIT_VUINH               BIT(26)
> +#define MHPMEVENT_WPRI                     (BIT_ULL(57) | BIT_ULL(56))
> +#define MHPMEVENTH_WPRI                    (BIT(25) | BIT(24))
>   
>   #define MHPMEVENT_FILTER_MASK              (MHPMEVENT_BIT_MINH  | \
>                                               MHPMEVENT_BIT_SINH  | \
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index af444e3e6f..94a57a4553 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1230,13 +1230,15 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
>       if (riscv_cpu_mxl(env) == MXL_RV32) {
>           mhpmevt_val = deposit64(env->mhpmevent_val[evt_index], 0, 32, val);
>       } else {
> -        inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH;
> +        inh_avail_mask = (~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH) &
> +                         ~MHPMEVENT_WPRI;
>           inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENT_BIT_UINH : 0;
>           inh_avail_mask |= riscv_has_ext(env, RVS) ? MHPMEVENT_BIT_SINH : 0;
>           inh_avail_mask |= (riscv_has_ext(env, RVH) &&
>                              riscv_has_ext(env, RVU)) ? MHPMEVENT_BIT_VUINH : 0;
>           inh_avail_mask |= (riscv_has_ext(env, RVH) &&
>                              riscv_has_ext(env, RVS)) ? MHPMEVENT_BIT_VSINH : 0;
> +
>           mhpmevt_val = val & inh_avail_mask;
>       }
>   
> @@ -1263,6 +1265,7 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
>       target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
>                                                     MHPMEVENTH_BIT_MINH);
>   
> +    inh_avail_mask &= ~MHPMEVENTH_WPRI;
>       inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENTH_BIT_UINH : 0;
>       inh_avail_mask |= riscv_has_ext(env, RVS) ? MHPMEVENTH_BIT_SINH : 0;
>       inh_avail_mask |= (riscv_has_ext(env, RVH) &&
> @@ -1531,7 +1534,7 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
>               *val &= ~MHPMEVENT_BIT_MINH;
>           }
>       } else if (wr_mask) {
> -        wr_mask &= ~MHPMEVENT_BIT_MINH;
> +        wr_mask &= ~(MHPMEVENT_BIT_MINH | MHPMEVENT_WPRI);
>           /* wr_mask is 64-bit so upper 32 bits of mhpmevt_val are retained */
>           mhpmevt_val = (new_val & wr_mask) | (mhpmevt_val & ~wr_mask);
>           env->mhpmevent_val[evt_index] = mhpmevt_val;
> @@ -1560,7 +1563,7 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
>               *val &= ~MHPMEVENTH_BIT_MINH;
>           }
>       } else if (wr_mask) {
> -        wr_mask &= ~MHPMEVENTH_BIT_MINH;
> +        wr_mask &= ~(MHPMEVENTH_BIT_MINH | MHPMEVENTH_WPRI);
>           mhpmevth_val = (new_val & wr_mask) | (mhpmevth_val & ~wr_mask);
>           mhpmevt_val = deposit64(mhpmevt_val, 32, 32, mhpmevth_val);
>           env->mhpmevent_val[evt_index] = mhpmevt_val;


