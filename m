Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF4606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UyBjRAm9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RtzWCyew
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKFdX-0006TS-IX; Fri, 23 Oct 2026 09:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKFdQ-0006Q3-CP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:48:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKFdO-0003o7-Gw
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:48:40 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAASOo3550496
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 13:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gvoiRV3JClZ93oLpY177JWdz1/pUnZWOiKogRyDhpAw=; b=UyBjRAm9eIJF2zb3
 1ggij6MXcZ8h+FWWOH50me4MOgZXo6A6UG94JewbUuPTEp1yLul3vTaDGc7eCPqD
 I4Cf0eIb3oNOzQCLhVwYSVniZCnLXXD4op/WRS/1Ql3RQWKeTZN4e/T/GR/WcMVD
 PwKupbq0Nmr+x39KPQbB5h0YqL/PkN2iBELfLjMRGGZQkhigJguXHjeObMcF30jR
 L8kb8tEGwpy1jDPPW13U1wWCL+pFKeK78Tx8WsVHnqkMDfaV9Xd2NTY8M+tPkyMC
 1e6cfgOGxqkoDichIAeZP74QL+m1BqTLe3TX7ae1lCUDAWmMYQpdqfcGNlUhHSMT
 ig2Hyg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrbwwe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 13:48:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5363763b556so17985111cf.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792763314; x=1793368114; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gvoiRV3JClZ93oLpY177JWdz1/pUnZWOiKogRyDhpAw=;
 b=RtzWCyewkvPRDChC/OXTAHxvK8BywLEPbqBPhFQ2XzvYnHRWWnn8jJ2xo+/kaag5Fx
 W0hjRCGpBVqiyMfE6vP6Upp/fBd8u8RQi/aZrllwq474dARsguwyuOVfQa9eeheocuYs
 t8CiJxteYobtACu3IK4+hM2tOC83JRVqj1fy5mdp8f3Jv8WvkrbQdCKmYmoInpGUK748
 mN6VnIEZz6zgBdbOKhezLiBOnqCzHCCznw0CmIdNrlz3sPBwo352GNhy2APiG84AHW2o
 yQPuMaimqPUt+8Ci+16uqMiDk0TfHacNGfMKn8XUgdQz/UOb15Xn75U1+VWME97otWO4
 /S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792763314; x=1793368114;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gvoiRV3JClZ93oLpY177JWdz1/pUnZWOiKogRyDhpAw=;
 b=ER2M+JZbbA8OontClUe80SUuVlY4Eut+0fmtEH24Kuvbb0CRC1I8lJTqp8WTuWnOHY
 6sdDzQESfdS3gzkS1ipGcilgIH2/dhIGZZr4RvJnc6QbK7FC3yDYPHSK2+DLj8CRjSb6
 TyCMkPO7UCDQbc1XC+4FT1sQ4XwAgDJeVv7OwySkVfvmGnxVL9LDX3Oi4s57DIakRSF/
 fNBECIw7hx+7QTGB7WYP17zrA5XdC1DnevMXxkvEXND1mtfBaC1YY1PlLgQ4j4bKbfTo
 qElP80+ZU7fSHEr6yi7Wq0QwBtT1G+D7WFPN1szfGIv0DsGwiVVRdq6qAaYXWSyd4Hmv
 5bww==
X-Forwarded-Encrypted: i=1;
 AKwUvByVCThqGlDg/j5BnFe2Glwv61Om5yeqkzgZXmw/H8KiSjDG2UBrO5sOqrlgfyTIBSWDU4rDSNNIBTuD@nongnu.org
X-Gm-Message-State: AFq9FYJx80gWl/wswgRxlEORxQpjtE+rea5Lbv2cxfKlG7/hlIv6jkZy
 r2GU02v1zTlWbY0Vsx4QdhuutjopWv2IrFVmISMTYneebjSk5q/IAhjaQN4aj8OeFbxYfhVSnU9
 lJ5wGq+81hKNqJAcvE40QQC2N8EcwWA1tmFeRxKz9kfDk8c3lTDfn6G95yQ==
X-Gm-Gg: AYBFou0YMlv7rY1Wn6x3QWMPhcFl5Mdyijr017s6g/dvkHEUaUcZ89VyzdG4a32tdah
 joL2JEaEjIkpkSIxDzo6jkxxtVryVIgWgS4lSE3Z8iTgw9880c7/VpGk4RcdVzU8htpHB2YjqTq
 Y6KTuHCkAbJKun3BbA2gkZUaA+g/o/Tlc+S9tlnS+B+F8fdLR+M19Drs5loMGVobfMbrd7nvpzQ
 pLttCA/KhM6UNgv0dpJuK0ImwZh1Q6y5x0vUD62MrZVshlDGOlkWMd0M8Xtx+Ej5Wel/9ghlEGI
 Vz9p+3AgaOhfiXA1kyJteboZfYYUmOHA0a94AVHiqA6w5sh4KraGyFbMNrQxSaal7vL2TvGfbn5
 EIkRBAqGDlVT54IUdf8wnX/vJdpCVQGDf3g==
X-Received: by 2002:a05:620a:6404:b0:93f:33a8:8e84 with SMTP id
 af79cd13be357-93f6f815513mr404422485a.56.1792763314544; 
 Fri, 23 Oct 2026 06:48:34 -0700 (PDT)
X-Received: by 2002:a05:620a:6404:b0:93f:33a8:8e84 with SMTP id
 af79cd13be357-93f6f815513mr404417685a.56.1792763313889; 
 Fri, 23 Oct 2026 06:48:33 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21555fcd1sm33021285e9.4.2026.10.23.06.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 06:48:33 -0700 (PDT)
Message-ID: <beced835-ef5d-412b-8015-fd0cd5334fc8@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 15:48:32 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/25] target/hexagon: gdbstub - Add sys reg support
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, peter.maydell@linaro.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
 <20261012041722.1159355-7-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261012041722.1159355-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3nm9-xGT2YCNyJTCNscR0oeE6kTMd_DR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfXyTOBU8TbYmJ2
 sYt1+ktLcr18rMrqrs5VpqfGK460jxxBHdU/3/TQcUtZF2zJzPFjkMPJgnHbLNI0rw9ZNM7bhce
 Waw5R1QukRTDq/t5aERJnKs5/xNqPnA=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb65b3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p43JHkzjH0k1_VF-uZEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX9modgma111Ej
 +pQhqQHXXIXiFMYNzIe4JPCpv2/HBA0VXqNzCl29TuOXasU01hZ6SuG8fEdMCgvi5tjD7VLDE/T
 SIdqhYFdn7aqE8j1+Gjw3fIYyQB2alHg6WZwn+1cpvFsLf3b6rrLDj47mwnWdpORZCRkEE2tgAa
 PFJ/+35t6yIr2GrfKjyPq2Yjx7IXWGRg+WmzKJu496qt5vP9NrqxYs2kCBrJh/e6cy/H4Rv/g18
 znsBcAdAUcepmWBa2SwKJ9XBu883f4DT3EFDD5X1BaXTSDQGoOSmP8JEBAcsVYYxerLtzEBcFHU
 hUHXoSitSQOOLrmnzI20vgxuh4AgoBudPEQVQFl3iOMxsxGeUfhTmxok94+y1+DzdXrXZI8moIC
 1dx4lT6W6eujevPGkB9yd9jJ7jao8VjHnZE8Bu5cBPHtK8PNtykVaekvnKeB/XlQBa8N8pPEPuy
 wWuekM7FpvzXET3rqYg==
X-Proofpoint-ORIG-GUID: 3nm9-xGT2YCNyJTCNscR0oeE6kTMd_DR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230053
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 12/10/26 06:17, Brian Cain wrote:
> Add support for the system and guest registers to the gdbstub.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h      |  1 +
>   target/hexagon/internal.h |  4 +++
>   target/hexagon/cpu.c      | 13 ++++++--
>   target/hexagon/gdbstub.c  | 63 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 78 insertions(+), 3 deletions(-)


> +int hexagon_sys_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
> +{
> +    CPUHexagonState *env = cpu_env(cs);
> +    HexagonCPU *cpu = env_archcpu(env);
> +    BQL_LOCK_GUARD();
> +
> +    if (n < NUM_SREGS) {
> +        uint32_t val;
> +        if (n < HEX_SREG_GLB_START) {
> +            val = env->t_sreg[n];
> +        } else {
> +            val = cpu->globalregs ?
> +                hexagon_globalreg_read(cpu->globalregs, n, env->threadId) : 0;
> +        }
> +        return gdb_get_regl(mem_buf, val);
> +    }
> +    n -= NUM_SREGS;
> +
> +    if (n < NUM_GREGS) {
> +        return gdb_get_regl(mem_buf, hexagon_greg_read(env, n));

And my PR removing gdb_get_regl failed because it got re-used
meanwhile :(

https://lore.kernel.org/qemu-devel/20261007232326.66240-1-philmd@oss.qualcomm.com/

Hexagon is 32-bit so I'll replace by gdb_get_reg32 like in
commit 7831e5f48d2 ("target/hexagon: Expand gdb_get_regl()
-> gdb_get_reg32()").

> +    }
> +    n -= NUM_GREGS;
> +
> +    g_assert_not_reached();
> +}


