Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452F3CA6012
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF7Uj-0006a2-9A; Fri, 09 Oct 2026 06:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xF7Ug-0006ZU-Vi
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 06:06:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xF7Ue-00066Q-0Z
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 06:06:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KRNh1252612
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 10:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W+lHPM5kU/5vcT3S4xI/sYJZpBb3ucE0qcfIkau1g70=; b=Ah8CSSVEQ1ujNcmO
 mQ5yCuRFIRiYlLW9nrUGASpVuGTqwnwj4+x8o8k5+vCGkYfuCUNz+VyjhwB+eP9b
 m8fl2Hb/hmSs+9uyvLR+K60CemO2cSzsDRbVrquF3lC5HO8x2SmhqbHP1xfmzeJa
 A8RmEDx5nxof7/K8MPE16smXG7bqarwmAed2DSChug4s82sZN7xlTc955vcowcSn
 4n/AZ0/KLRPNy1qBwHi2KDFpLtsc7sL5CZ+PLbnzSyFtSwfvYi5Dpeeu4w3tovCL
 2iMDRdZxUtF15rEvlh1IIunegdL46KEQhKxpAYgBcR35S+RlwXGUSuesibM2Wv2W
 NDwdEQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6baj47t5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 10:06:21 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5d88f5414dbso1383365e0c.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 03:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791540381; x=1792145181; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W+lHPM5kU/5vcT3S4xI/sYJZpBb3ucE0qcfIkau1g70=;
 b=axIN/vFmJ2grdwYbtk/Tq1mX7JOoKDL0SkvbTQtv7JTX1KKC9QiKM5rPkQJSnJ5PKZ
 ch998aoz+NKHYxz497+Tg63pUA4h7fmJlBKHQ/f71NhNNcb8CSkc/HZBnXn94PPFc32K
 L9WKp8nrO3Zk+mF7ovIvlRiG+WGww6YiWJIOr+BwzhMadsFBeyuOlhFeIsEOKMbstbz7
 egpX13EK4gfTqRf82H2YdEWkFPoNhWDfOl2m8NMk/wYrgqzZctgaQp5wrhcS3iFvUrLQ
 O5eOIWqILB3jW/6wOFIxwLPkncSi2/czTdc7Uuos1Y+rGwcmUkVqZP75vPCVuWQ8T5y7
 VkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791540381; x=1792145181;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W+lHPM5kU/5vcT3S4xI/sYJZpBb3ucE0qcfIkau1g70=;
 b=iDPWiVdj/ue0DGmJgtgXUB2e/Yeo0vcD75T6x4kuM7Icv0gDoxLaPJbVB7Y/NxD0Cr
 Vpz3wbGPt1aTCVv6bnT29UZqO3C8KS5XJBo88CBsTTdWuTOooUettqLUv2gk0Ei2IVUP
 nAl5jECzEC2U+2KMaY6pOGt8xtAHbzQav/0AyfFCPb0im5i7Vdqe80YucQxxNG03BoOA
 iHUJTLYfiSrOkksuUwWo+d7IG7yzNhmaIhLDfcKTayFLlU7jWpJXyhdI3t+mFHQ2+dTy
 8WhkzQDDmYo3nWkplfAtxAcSHC5HVfTVzfwJPnTGyaA+AOW84sCr+yp7r12/WuX9cIsS
 1bVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcLfFIY1EDgIDMpbPr7Ko3OfS2UnjDuYNCeyCDOliz/eRvHjJZRKbgu6s4oNSqzq04tVUUYBFB8h3/@nongnu.org
X-Gm-Message-State: AFq9FYK7BxABPBwZAbBrvabbIuKcNl3th63oU9PC1LiktTcxdnBcaUu5
 1AEnwQ/kLs/ksEQMIVoNGSJNrmIoVkUS7Dv2ilmEhE9+KtgNVUk68lRMMpUbKHieeKaL1Stf8TG
 ieMruVt4JCYEBCnCPNaYJHbY/yVu7pfvb2rBm8rPp4FglSPGZSTeKv6SKZg==
X-Gm-Gg: AYBFou0YiewwLeh04vIyWIV+7FF5Tr9AqV0cIUDh/Dc/8w0/315OTUBZC3y8jDSOdTe
 4cH7tlFPPvHj9hmx4wnr+hudv723HeudUAXjW+zoS0bSxQGR/U+LcAmkI/z3VUrdLmFPDCfAyEW
 QwnNTOg6aLaBVjpVq7nOiAnNACIgcNtj/NO+Crx/cnvX0OXhnGUk0EeAfXKDuGPTLrybUa90h3Z
 PJPXdRvzvhT0624NmYfbyuQ48+B0bFkg/a9CuDEXSAK2gPFqg7DsXh1U7Aa3bW3uNbcXXZxV6IA
 rErFwUnJ/UDUavMaxqVC87+2C4xgkyg68eYr0pXjeS4X11m38QPBQDvGhsyvcqpUF2lsp/9y+6p
 OcRZZm+SS0hIVorl6+5pLAU2+BUE4nREl/A==
X-Received: by 2002:a05:6122:3d13:b0:5c9:a60d:3277 with SMTP id
 71dfb90a1353d-5e91f4bd146mr365699e0c.11.1791540380677; 
 Fri, 09 Oct 2026 03:06:20 -0700 (PDT)
X-Received: by 2002:a05:6122:3d13:b0:5c9:a60d:3277 with SMTP id
 71dfb90a1353d-5e91f4bd146mr365682e0c.11.1791540379686; 
 Fri, 09 Oct 2026 03:06:19 -0700 (PDT)
Received: from [192.168.68.107] ([187.10.234.20])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5e91cab57c8sm1318540e0c.5.2026.10.09.03.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 03:06:18 -0700 (PDT)
Message-ID: <67cb8199-17ff-4bda-8115-48dd16b23d97@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 07:06:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] target/riscv: Replace gdb_get_regl() by
 riscv_gdb_get_reg_mxl()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
 <20261007232326.66240-9-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007232326.66240-9-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MCBTYWx0ZWRfX6iArgi4r/Bk+
 fbm8AkJTeaO1XUGQqQpCrBXNSXyDRxYxp7ydulvVThwmSbnP3K+gCMZerH9QA+uxf6Q/synch/s
 7bkn1b64m/e/ORBW1IRJZ6iuXt9sX+QSNokZCbUQIFj3IrNaJh7S24Iwh9W+tM7aqmoN/4wn2za
 IINpIeWVALS3jbmwELMyYVwsiaLAI4lYCZnqTZD1CrhrWFCTlbMahuwbHs+TdWJ4SO2CLQnUBcc
 bHCePIOGj1+Vb2+EufMK2Yle+PAr/hDf9cFVhPWsXJcrh69w0SV8lV02KZDLSgEiBQl+Od+/l2d
 UDYFNnpv7gN2pbIrnB2cV3LVM012RfX7HVrYHaY1QLZIs7fCiK3pFAD93dikPlxTY6psbxJYNH2
 avo3mezZvtxRvYH/gmi9zze3y2UUgiSK9GCVjaaNwPMA7HfYom/x5l6jyhatEH6/FwSV9wXRXRn
 8ZIP2oEgX1qLQ80ODXg==
X-Proofpoint-GUID: hEvvkdbgt7Euc2o5RTCrUILyv1N5u0Nb
X-Authority-Analysis: v=2.4 cv=H/dOUOYi c=1 sm=1 tr=0 ts=6ac8bc9d cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=jbqyKmyYbxlRs/MVMa3Ccg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=xeZyZPjq7wcwBkyzFCoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: hEvvkdbgt7Euc2o5RTCrUILyv1N5u0Nb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MCBTYWx0ZWRfX1ZCKgW8f7rM7
 mb5F7ooPL85/2EkGR+J6KNGVcvMYlueJCq065tzvWXRzxH7asbul6iS2w2O8qOFC1xs1C1LwJWm
 i/uEHWK3zrBE8HHuWXlwToPVtSaUu8Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



On 10/7/2026 8:23 PM, Philippe Mathieu-Daudé wrote:
> riscv_gdb_get_reg_mxl() picks the register width from the CPU's
> misa_mxl_max instead of target_long_bits(); use it in place of
> the deprecated gdb_get_regl().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/gdbstub.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index b3c11db5397..50e834e367c 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -183,7 +183,7 @@ static int riscv_gdb_get_csr(CPUState *cs, GByteArray *buf, int n)
>   
>           result = riscv_csrrw_debug(env, n, &val, 0, 0);
>           if (result == RISCV_EXCP_NONE) {
> -            return gdb_get_regl(buf, val);
> +            return riscv_gdb_get_reg_mxl(cs, buf, val);
>           }
>       }
>       return 0;
> @@ -211,7 +211,7 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
>   {
>       if (n == 0) {
>   #ifdef CONFIG_USER_ONLY
> -        return gdb_get_regl(buf, 0);
> +        return riscv_gdb_get_reg_mxl(cs, buf, 0);
>   #else
>           RISCVCPU *cpu = RISCV_CPU(cs);
>           CPURISCVState *env = &cpu->env;
> @@ -219,7 +219,7 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
>           /* Per RiscV debug spec v1.0.0 rc4 */
>           uint32_t vbit = (env->virt_enabled) ? BIT(2) : 0;
>   
> -        return gdb_get_regl(buf, env->priv | vbit);
> +        return riscv_gdb_get_reg_mxl(cs, buf, env->priv | vbit);
>   #endif
>       }
>       return 0;


