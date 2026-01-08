Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100FCD185F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqHz-0005R9-R3; Thu, 08 Jan 2026 08:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vdqHy-0005Ng-IE
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:42:58 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vdqHw-0005v0-OH
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:42:58 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 608B2nVv1970139
 for <qemu-devel@nongnu.org>; Thu, 8 Jan 2026 13:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wwBbRcRJy1POGyz818YYjbQODdCOPw1AciW9fPZJBmY=; b=jdGU0kKhBPdpOFCE
 wxtAmOiG2gwptoHEJYWTT7g3wPkkfUWaUQ6MPAApceIRVtf2GVJCgN7ElKE4Fuby
 8bIdq4v7ef/mTHPqr+ObZ2kNJxgKyPOcROkQD8BYoMhU60PKf8NnN98JfhRw1gB3
 bIE0f4dPE+wEuRKwIzwyPUgCGtq2AInfSu+hkksJJCrUOtHvRK5A55cmKKxooGRr
 4h1wCCG451YUPOmt0JwBuv966QEQDPFUISiTpolgY65+edfCM9c4khckrZ6Khjf3
 7lL8oyk75lYTn56cDcAKStN0QsLLzNOA6/ZLnOk/DPw7uK63phM352uEmQYy6TNs
 OtxNow==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjbc4rea3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:42:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c2a3a614b5so610378485a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767879774; x=1768484574; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wwBbRcRJy1POGyz818YYjbQODdCOPw1AciW9fPZJBmY=;
 b=itCuyRw+YJ5BU9vK0BrNI5NxiZ5yYrqFqX4lsR8rBwxq5PZe8xjps3rk9zQ90FBR74
 /YTKNqAlQw94+rBXRgT5r4fvRlEZzOHJ6rHD2ClCEPRFHQFKUU/RchYjHdlR2mbg28m0
 6VYNqX1SsRDYwEq5sioCf/vgFfWXgrdbIKdn4GYYQhPL0q0N7v6fCA22W2OStKQAtW8x
 qX1LbpeoMAUTfvAH3cIkDL80GmsF+Jr49aVSk6FOiWIkr8+NW8MX8vGm1kDx2GtmesJ6
 yq3cs6Sd++2DmOLsqLUrzsFqDCEof++cPpWjggOEiwS6GH5ZGtv34HcajCDjFrOc5QFk
 99hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767879774; x=1768484574;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wwBbRcRJy1POGyz818YYjbQODdCOPw1AciW9fPZJBmY=;
 b=H24prdMzquxiKDw6xKZMXE+TT+G/R7ALOk0IG2cgwD2FCuhw+gPxY8cZsXLxlCOhQy
 U8a8yrXA2eVqE1rGaxIY9mQZsTmlzY+NC/wMgc58Y/kdqFdK0IbpCInjaZ82tfqBf7Xu
 KhAIo5STBdlB9Ks6dX4d3PrlVuoM1EJqY6IZ+EJg8NoroaqaNwvRT0ohM2IQvHZtV/WI
 BGLa5Sp5ELG3x/OqAEjdY9kTMkbAwcsmcuGLx5CwRyQiFS/YhSOjr4MhTURT18I6qR/e
 0td5wVwik9fMsdtU0ymEBpjzxcbxPvijJRDsfSmMSZJm4lyO5a4Bb4oTHKA+lCmAwGSL
 uZhg==
X-Gm-Message-State: AOJu0Yw4WeTtmmKhoHWLSZerk21EE4SZd3BWR5dzYUi89Y8nw3djvx+T
 WZuQ7ViXLM3+TKkruruouD0ub+NJUEkYSI9sr6mZUzApF0J5lfhBgTkYjuA9nyrbQ/BH5b00Z0o
 Au84BniWYwD2ravYqGxi7xe428iYYy55v+Pl3n/ICd/tYuprQf1dH755fnSTmA5o6kA==
X-Gm-Gg: AY/fxX7nuv1dqy6u1xvejjkGE9ikvmepiZRK0Qv8384+FqoobaVlBDn3Y+8zIG8RKfJ
 1GKlKDYV/QPJH4xSnApJCIXkIFz+uzFOK7LZybIltr8hDGCM8CwkRS6da8MkTWe39oHvrpePQPp
 ZiqGF3szcARWtkpOEZOHfSy+YDEHHB7hcc/8aMin8kqAP93VQKeOr2vaFxQXq5QceUKf8sncAFq
 0wn4boqOwrE0ygzqeH5L8WSlM9QHvSAm5Hx1vue09xWkk4qJzahpZ/v7aSGo7Yz+PJbAjwbNbMG
 k6mjSmq50Bx2Ht5k6MireZ3Wcuxeq1IEZ2r4ikjjrRZw0pt9JhbbmVB8MNTJwk7h2nz0oA6tUdt
 N0LBfjIbXhzUFdSNz+xiOF76rPTAKAtVoLHVdczoukH76Xf6ZG2TY/ifFqJwWn52MIWp2DHX+2y
 46V73OFh5OcDx5RaIQ
X-Received: by 2002:a05:620a:1982:b0:8c0:8bb7:49b7 with SMTP id
 af79cd13be357-8c37f4c2b91mr1259578785a.3.1767879773738; 
 Thu, 08 Jan 2026 05:42:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbnOZZ0vpWYeVcJKIeDctveyLjWwnXOtcUW/BFLtNib5uBaAld9Ev5gcNnRz7amNqm5bbi1g==
X-Received: by 2002:a05:620a:1982:b0:8c0:8bb7:49b7 with SMTP id
 af79cd13be357-8c37f4c2b91mr1259575385a.3.1767879773343; 
 Thu, 08 Jan 2026 05:42:53 -0800 (PST)
Received: from [192.168.68.101] (200-162-225-127.static-corp.ajato.com.br.
 [200.162.225.127]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f531207sm588028785a.42.2026.01.08.05.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 05:42:52 -0800 (PST)
Message-ID: <9fab4d0c-8902-4f1d-bdef-fe39489bbd13@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 10:42:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/cpu.c: enable PMP by default for profile CPUs
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Thomas Perrot <thomas.perrot@bootlin.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>
References: <20260106205152.3654975-1-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260106205152.3654975-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2QcIhB7XWUtMLvIgMk2mjLNV33jAWA5d
X-Proofpoint-GUID: 2QcIhB7XWUtMLvIgMk2mjLNV33jAWA5d
X-Authority-Analysis: v=2.4 cv=fdegCkQF c=1 sm=1 tr=0 ts=695fb45e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ewOVoc8TSmC0cCmMeNMfEg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JfrnYn6hAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=90Fz4OoM-9CFJI9hay8A:9 a=QEXdDO2ut3YA:10 a=mH4BKZv_3NcA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=1CNFftbPRP8L7MoqJWF3:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA5NiBTYWx0ZWRfXw1eAjqJ/GJI5
 neWKX+1l02wqyx6+O8eotsIMQOXJXMyjdlifpQ91wc7lzzhCgf0yTFFCAerwyXmP+SR3LoNdbKf
 2dROauBvAQlzcdE8HjoUkPeNAGgFO0zRPXnVERKXTwI4lt6M11sc1lU/xsoXcZKWQmEy5D6NoXN
 Jj6VJFrbcWnMUpX7UovYfbEhKlfcWYa0vAXB0V8edqZVojx3oHWuNQh9n6e1r1sZN+0QQegK67X
 GzljN7rXFmURNePGHYqxs2rTRJ3N+Q+9a/QsZa7K1bwb0QfVTr97TKRNizxrJjdCkMeSU2XkF+G
 mb/y29fezSICiYLDmkiHl9RRLDyeZ1/ayfcd0vyjF1hSy6YJyyBl1Jk2bHm2qNX6wRNFqonxKIO
 4gOBmtK+yEU7DiA6CevPchKx5Nnl13ZoAEpbnWr9Nk9mMgCFXF8PuuYeTUxQadyGhvM5U/h17c1
 uNTDNKYYWU0qk0/VnzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080096
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

Please discard this patch. OpenSBI 1.8.1 found a way to go around the 
issue of a CPU not having PMP enabled.


Thanks,

Daniel

On 1/6/2026 5:51 PM, Daniel Henrique Barboza wrote:
> The new OpenSBI v1.8 release is not happy about PMP being disabled in
> the profile CPUs [1], showing a:
> 
> init_coldboot: hart isolation configure failed (error -3)
> 
> error when booting. It seems benign given that it doesn't affect
> anything else during boot, but still a rather unpleasant message.
> 
> We do not have RISC-V profiles that mandates PMP to be enabled. That
> said, most of our other CPUs enables PMP by default. Setting it to 'on'
> for profile CPUs allows for a more standard experience between CPUs. And
> it's not like enabling PMP will bring any additional extensions to the
> CPU either, meaning that we can still claim a certain level of design
> purity for our profile CPUs.
> 
> [1] https://lists.infradead.org/pipermail/opensbi/2026-January/009307.html
> 
> Reported-by: Thomas Perrot <thomas.perrot@bootlin.com>
> Reported-by: Anup Patel <anup.patel@oss.qualcomm.com>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ffd98e8eed..a26e547a38 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2955,7 +2955,8 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
>   
>   #define DEFINE_PROFILE_CPU(type_name, parent_type_name, profile_)    \
>       DEFINE_RISCV_CPU(type_name, parent_type_name,             \
> -        .profile = &(profile_))
> +        .profile = &(profile_), \
> +        .cfg.pmp = true)
>   
>   static const TypeInfo riscv_cpu_type_infos[] = {
>       {


