Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F36CD3427
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNNM-0008UK-9B; Mon, 11 May 2026 05:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNLu-0007DO-91
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:55:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNLi-00052E-57
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:54:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B7A41I1258491
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xuy5ne3v5Rsvx5pJBBXGe0bXMTYVf17Z35c5dihCnok=; b=iPHGvqLZpCzAjSs1
 tdi3gI06in6GAl2VfjEXkGfuo5C3X/3ctGPBPhxG2A6NBju6ZsbijSJT+rMkXpKq
 dRFr7nEbVJmiDdkPxFqkTfSuilZYAINCtkIYRWMzgK8w3lwSx5xADcpZi6EuwHA7
 pmWifkS/NYF8eFuxd2+Uhbjqec9PcpMTCMtCfAtcFiXSht4p8Jcd2v8DcT9gEXTL
 pd48IVj/edtPFlZdCIOUssTDuUoVuWfOEt40Kr/dZFE9qYe25kAZ6ZAtSENDk21J
 OzucXdlLOwGeGoT6jwDtU6gYv5/9l9Vh0qRA/mTu7+e4q7JKdf+UCYLgJUKvI4oD
 nKpzfg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag20kx3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:54:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8aca4660827so107993646d6.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778493287; x=1779098087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xuy5ne3v5Rsvx5pJBBXGe0bXMTYVf17Z35c5dihCnok=;
 b=UJ7LhCnXLEB7rJbaujQDDs0PFOUlQDL3cRARmw8ZJf54Zwna2/U6/A8TorPLiUuH7E
 4D47PfRzTOx09g9ftvvYOtemXYT8RTpJTSUdHos4hO2Uq2o9l9uE2cHgIffNf7UMGgfU
 J5PzOnITrfZ6i7EnPuhA6seBvDW6ZJ2vmaE2qKE2oMkx7tAkcHnimXKn1tNAIIiVQg09
 z5uWhM6aKSueQbaxOnv2Qn166xs2ZrQfcNoI1Yv0heMRoDF8VMjF4KzCqQvzHphW/elc
 Qfl7nF1mCAh3HMtfPOupj0IafKQG97fMYjgMVuc1aezYfZn/E2qxRt/C+oCvjVMFuwWm
 A2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778493287; x=1779098087;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xuy5ne3v5Rsvx5pJBBXGe0bXMTYVf17Z35c5dihCnok=;
 b=rCVGbf7j6g5+doCn1TEc+XjrB0rrvgCs+4zeemOQSA+Ghxaxad+fWPocjvqZ5ukobJ
 cWPwTvXuHk/dJiY2yMSsogKrerivOp8JXcWPyYMv1UcV1bqdQDqsiaIGEEBY7jLn25NC
 XnHM3UT+Fzqmpo0N9uA+YukSl1guLUD0kKk+du0PwIOp0dBX4a6ITgNGI3Wdfj5+h+Jv
 HL7ttf7KkmwIIIgAkgc7mcUCp7G0qHf1fWmp8BFVMfrKrtsxrFBBTCfWN1U7jPxMvtT9
 WKBMeFA0DKpN1iD+bx/UxtIpXEsXfDsgLiHmJEp1YWoQw2KT5AmDzHhs5TkaIvaZYj1n
 ZihA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/REiE8gor0IK8Ro9MClvET55pMMhmY3XJliuoagDHD/Xsb1o2YHL54PLuRY/zVjtUl718vG84B2AJk@nongnu.org
X-Gm-Message-State: AOJu0YwWWxFnub1OwxYgpoQ9OfSckuF8wJV8DutZAazjc4/kQch5dP+O
 rKRzKHtOM3/6ip1NyRePXWo3Bhdo1sE9XB8ST76XdWnLIsthqFIka4MiN4wxfGzJTMZl3awJkFb
 iiN/MbdEwY7feLR8J9zphUHqSpalb3bKXQ9/B4L4iczIA+pxqlJMFdJBOdoenqv9Vag==
X-Gm-Gg: Acq92OEKvr3AIdtRik46RjxiesGvpEqaOWzwygdE/vryMVAmNwXwYlcLeDREjXGuUQx
 EpADQgF5N7b4U/FuDsfBBC50646rcg2dG8QSbdJP50e0VFgTI06yYL5PWvK8MlFhHUDREr3ZybL
 CYzemUInB9DkAIAxX+srxRzAtn2VTaGa52SJu6fbqldGjQDYpNlgM6polXygcK5+RH8DgMrSxzs
 JygCS/mE+z5zyFnDY4n9SEa535Apyd2j8l+SxCRWcGbvg4ombPZm6eKzasWNrp24+dyF5je0Of/
 94FMl98cmC+GnVvBZACe+v1Ch4jplmhcEL2vm04idYA9gNOHaF8ZdXKkWavxjAWjMCN4yEjSazB
 L+P5v0IQnYU0aaR6qZYGbQPHNYaKyDTCZTfz+PXfvWE5AcOgDrRjP73Zl1Tc=
X-Received: by 2002:a05:6214:4a08:b0:8ac:8cbb:49bd with SMTP id
 6a1803df08f44-8bc4517616emr365569676d6.38.1778493287467; 
 Mon, 11 May 2026 02:54:47 -0700 (PDT)
X-Received: by 2002:a05:6214:4a08:b0:8ac:8cbb:49bd with SMTP id
 6a1803df08f44-8bc4517616emr365569486d6.38.1778493286988; 
 Mon, 11 May 2026 02:54:46 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf3a71be9csm91958286d6.17.2026.05.11.02.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 02:54:46 -0700 (PDT)
Message-ID: <bc178e80-8713-47df-80e0-89581418fb09@oss.qualcomm.com>
Date: Mon, 11 May 2026 06:54:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: Allow mseccfg access based on ext_zicfilp
To: Zishun Yi <vulab@iscas.ac.cn>, palmer@dabbelt.com, alistair.francis@wdc.com
Cc: liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260511072705.3015986-1-vulab@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511072705.3015986-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RyH-PrSw6cy5ua6Oe0EOy4epMjMwd9W9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEwOCBTYWx0ZWRfX22t9rsmxGYmk
 uOagRWglTXD9qT0G2Fl0niXN0Y+vl/PAMP8CId6vD3fctl6icyvad9gGLbnseo2sCnnFQH3Bqzq
 /UbvD6XY0Rk7BIYK8W2q4J8F6bW3m8+nUcGG29kibE86XZUTx2yPcLN7m+LYVL0SqBwDw8vlBxQ
 o1P2JX9wDhWS/n4P+nrzzN0edki8ewyBuLgT0Z/LWXnqBd3hodA50+u5UJMPs/2s24Y3Iyo7T+M
 YAiVMdTCyLfYDZPnAAJZMrLwGzJCGwaVvHrPitv7bP8Itn2UALIuj8qspb7Ch48AgMLqBmxUJCC
 yB8NVzLyB/DFg+3EYHWt5XRy4Plb73eEb3c5qEm5C6y3aKN36+0CNgR69Mnkbwc5BuFkQPXisTp
 XMPbppy9hTVs9JTKiXTaJE+Dul9/DDCeYJnZcZrMo0bJB3lWD37dnVcNSDMO6AAFiMdeaoNeHrR
 mSqBBGNcshX7xDoV8Ww==
X-Proofpoint-GUID: RyH-PrSw6cy5ua6Oe0EOy4epMjMwd9W9
X-Authority-Analysis: v=2.4 cv=NODlPU6g c=1 sm=1 tr=0 ts=6a01a768 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=7WufM6Q2AAAA:20 a=EUspDBNiAAAA:8 a=rGvZjCNGmgrfT8XSmwUA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110108
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 5/11/2026 4:27 AM, Zishun Yi wrote:
> The Zicfilp extension adds the MLPE field to the mseccfg CSR. According
> to the RISC-V Privileged Specification, mseccfg exists if any extension
> that adds a field to it is implemented.
> 
> Currently, the `have_mseccfg()` predicate function checks for Smepmp,
> Zkr, and Smmpm, but misses Zicfilp. As a result, if a CPU is configured
> with `zicfilp=true` but without the other extensions, accessing the
> mseccfg CSR will incorrectly raise an illegal instruction exception.
> 
> This patch adds the missing check for `ext_zicfilp` to ensure the CSR
> is properly accessible when the Zicfilp extension is enabled.
> 
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
> 
> Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2561/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> v2: Removed mistakenly added #include "cpu_bits.h".
> v3: add a missing space after the Link tag clon
> 
>   target/riscv/csr.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index da366cf56271..e1cd4a299cb0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -783,6 +783,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
>       if (riscv_cpu_cfg(env)->ext_smmpm) {
>           return RISCV_EXCP_NONE;
>       }
> +    if (riscv_cpu_cfg(env)->ext_zicfilp) {
> +        return RISCV_EXCP_NONE;
> +    }
>   
>       return RISCV_EXCP_ILLEGAL_INST;
>   }


