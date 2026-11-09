Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056FE607009D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ME4w1f6G;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S+ydmPKG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQU3g-0005kz-Fy; Mon, 09 Nov 2026 13:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQU3N-0005jD-0S
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:25:20 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQU3K-00034s-EX
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:25:11 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHG7V899570
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 18:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 osiub48KcjmmDo5/nPyDvP2rfV6puvFo06w28EkFb4k=; b=ME4w1f6GgFbfsibj
 tjGGs+S3VnvSX32XhBurP1+YZ4WSeynZhtxCsANqReqIrC3bxAtjfelH41rS7ur7
 Av3E8KAL7SPAowmexjJdVfVXsWRPlSrRN0cymI0W8jvNnimV6vLloYuq+/ty0CLg
 wGp6/JC8/uf0NNoyOwC5BvJrpAQJHcUhBUHZSlyzBOFDjWUi5i0eEoJZ4QmEdR4x
 3OhlTDNnd67gn4fM/Yp5K5MCZRVOfME5OQbmRPcB4CZMkA+1+l1W/EgMizrjkBfr
 00B3D0ZqIqMjDm1uSvQ0qgIkAjDCbYDfTn6dOEF73ePG6kGMKOcwqK0kUuAqCLTN
 5qNWSQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2k0tr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 18:25:05 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91c8a517107so35173816d6.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794248705; x=1794853505; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=osiub48KcjmmDo5/nPyDvP2rfV6puvFo06w28EkFb4k=;
 b=S+ydmPKGuyXqzRqeS7DAnbsWUFgsGzMKAi2nRwLW4jNgUUOrmieeOHGpE8RW6L4QEl
 NpDxWzfhUqDnW3eZpTBYOmBREVWu/GbkjPHcKi5p3kimBjypLWFmZzvzlEdehip8iRtY
 ls95QWpS05ggvK0yYlLoq1B3JMlco45t5tpvZsbSY8Ozx+uMb/JkZq69pMxwuo0qb8xK
 Rvs0+5YRKfJEs8To2DdvNBRsiOTA8+FLqAYft3iHMf3e4n/U22Ah8WuAO06r3ThqEEf3
 QMqPMSO+X/3FTFbDmnpcme3cIOCIENtl8Ksz2uIP1epOBXYyxPd7UFpOIKdQg8LRKSf8
 oFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794248705; x=1794853505;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=osiub48KcjmmDo5/nPyDvP2rfV6puvFo06w28EkFb4k=;
 b=s+pFLQheNCxmTdNJcoEQNv1iu1HdKse6Vnc/VHiePWoMo/fpjE4s3iFpWxfvjxOYei
 rTHyaLWLHgGgdnKuELfpCNn9C6HvDXwLjca/KQ4Na55Y1VhZ+LqSlTWjv8NRGSfnSl/l
 KmrbVR4bCsY+KpBop1DRXGMefi5hztuPUTuGsGrMbOaeT2SfDHUQ2Ou0jVzY9Gz0f0EI
 cLvBY2Pth3uzTf7c4oLeXXaE69xE+vWqnTa/rtGiMCuW1fXNyuWdsgogyzZGpxFpYM0V
 bfhJpbfrgojkGNc911lxz/TzZWpSgt+6SXmTBykE5NjgOxI8v7oZmf0T2BRz/AUUWAHW
 ZNJw==
X-Forwarded-Encrypted: i=1;
 AL+hErFdEVIYP0lc0jApWeDaPOvJmvcUSeI+/LQYedfVXK8ReuzuvBzzAhyKuxfNEw24tcNuO2SdZdX2DIZC@nongnu.org
X-Gm-Message-State: APuU4Z8/ZIENDctv9YU9sSrlMYQLOzqlBJL24PEJLP8fAbshO87LtXb3
 PIghHDMkK6AqMeR6VBwLcAM9L82tiqXXo0KBjQU294dPDCfJ70B5ON6JAq8uf1Wo7W8XhieAZRD
 gHXewQRDlc1a1HzXpwA2e2CKcXQV+sOaWQVx5zWRAx4rX5ZLbDSapeF9x7g==
X-Gm-Gg: AYBFou1V4ElbSXw1jqp3kOCn2TFY+vXe46zkAPTjVg8PqfS3C63A8O8JD0MM0TiOTj2
 +HnQZeL0lUlRCe5S5Yi7aQKeBnOdpBFyr5/E1AhRMHFGYu6MngHNQ40axVfkZQmQgQ5qvR4DXGZ
 fiClwbjklLAysKzKchLrxvMLkFgGQO5HgYXU9n4tT6EtRv3ycKf36w6ZgXxByla3GJSpSS7wEjD
 +bW9m7gkAhJQZ0R94vMADIjNxp2fale/n8qJ9q9LX81KB1l+KGSdtehEKZmfSU8zl+I9iyiv9wn
 3s5vk+AtchFE77PGbful3g2JJaV5f/NV1JMKnurgCQ8niv4g1rX98IgjCy2qgEEcAZ0zK+3OJ5P
 18vQScB/+beAmgp2BDG1PaLRSueExUghx+Wkx8O9aKQSnt+d2kevnqLCqq5i6ozqnXx12tF1tqR
 RsX9C/DoA0
X-Received: by 2002:a05:622a:343:b0:536:8e69:8fe6 with SMTP id
 d75a77b69052e-5552722f3f1mr2709771cf.14.1794248704806; 
 Mon, 09 Nov 2026 10:25:04 -0800 (PST)
X-Received: by 2002:a05:622a:343:b0:536:8e69:8fe6 with SMTP id
 d75a77b69052e-5552722f3f1mr2709361cf.14.1794248704355; 
 Mon, 09 Nov 2026 10:25:04 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550af60493sm3482831cf.4.2026.11.09.10.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 10:25:03 -0800 (PST)
Message-ID: <3903b65f-229f-42c1-9236-03b4f55e7d5f@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 15:25:00 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Use gen_goto_tb() for vsetivli exits
To: WX Chen <wxchen0913@gmail.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20261104-research-vsetivli-direct-chain-20261103-v1-1-ace12cf5280a@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104-research-vsetivli-direct-chain-20261103-v1-1-ace12cf5280a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af21001 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mzOeKfuatP8-4bX6b9kA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3MyBTYWx0ZWRfX6wrAlRFKl/Qt
 HN+BwidCWMpQwdrTZqoqeRMHyJBCDICasBlL20CGA+Aie+Mr90/ffNdm5vCv/68iVxEuRgZtJ2c
 Pv5xjzjz+fj19qk76qTllWiz+SAvY2bfa1puyCIQE40dhcDUIpvuuafxDU5PDQgLYYJl0sFRMaN
 4nIV4dt2kw0HTRsnCNCab4KrKZyA89ewADHN79sd67OGasUS4bt6WNW4oggS3Llr0AQWI7pYgRg
 zXtIuY3YrCAbb6/hfciJAA1kaZq7sIGEUZbm6t4Ck6/uJzwT86Xfxk+rmGwM2d1f3xU6l8ZYYsh
 gxKmND6IG31k7uOKSjbvzAZ6YF/Ux8oiy5iC9jFslGy9JqNaJx/fRDw+NObunbSBoJ8oKT+3ZfZ
 OhEXuvl/MfUJgAkPanBrAhGunEtvRElbGljYoYYCUZ2zKmIa0EgnMlcZJtHXsw2mLywnwLw9kKn
 r7Is7iDmkFLA8cl/a0Q==
X-Proofpoint-GUID: GKHhnT4FRNahw-aOi_S7BxofOILVj1rf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3MyBTYWx0ZWRfXyqRLMeWkAZ0q
 EoRbtPU2LkjPKqPacrJK1xCK3WOrkcYooK+xlNew9/TTLIptcwDAC2LWJyMCkiGVKbMgxemmGRo
 MwAcdXH3MhHed+31obsBSUGlijZi0IE=
X-Proofpoint-ORIG-GUID: GKHhnT4FRNahw-aOi_S7BxofOILVj1rf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090073
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



On 11/3/2026 2:34 PM, WX Chen wrote:
> This change adjusts the translation exit of `vsetivli`. While preserving
> the existing helper, state update flow, and TB boundaries, it uses the
> generic `gen_goto_tb()` path to reduce the overhead of repeated successor-TB
> lookups.
> 
> `vsetivli` is used to set the vector length and type, and both its AVL and
> vtype encodings are provided by immediates. Given the CPU configuration and
> the source TB execution context, after this instruction completes normally,
> the vector state changes relevant to subsequent translation are
> deterministic. Therefore, this exit is eligible for direct TB linking.
> 
> Measured on an AMD Ryzen AI 9 H 365 (x86-64) host, using qemu-riscv64
> with -cpu rv64,v=true,vlen=128,elen=64. A RISC-V GCC 14.2.0 cc1 built for
> rv64gcv compiles the packages with -O2 -g0 -march=rv64gcv -mabi=lp64d.
> Only cc1 runs under emulation; make, the compiler driver, assembler and
> linker run on the host.
> 
> Each variant is warmed up once, followed by three paired clean builds in
> AB/BA/AB order, using -j1 and fixed host CPU affinity (CPU 7). Median build
> wall times are:
> 
>                    Before (s)    After (s)    Wall time reduction
>    LZ4 1.10.0         125.017      123.060                  1.57%
>    zlib 1.3.1          71.062       70.310                  1.06%
> 
> In a separate untimed test, a loop executes two vsetivli instructions per
> iteration for 37 iterations. Host-side GDB entry breakpoints show that
> helper_lookup_tb_ptr() entries at the two successor PCs fall from 74 to 0.
> The guest still executes 74 vsetivli instructions. Initial TB dispatch and
> link establishment still occur through the normal dispatcher.
> 
> Signed-off-by: WX Chen <wxchen0913@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index a22e2cae6ce8e5a055c106fb76c305c92ac53d3c..b299c82d7a29057433e280b49b5220e6ad71498f 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -234,8 +234,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
>       gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl(0));
>       gen_set_gpr(s, rd, dst);
>       finalize_rvv_inst(s);
> -    gen_update_pc(s, s->cur_insn_len);
> -    lookup_and_goto_ptr(s);
> +    gen_goto_tb(s, 0, s->cur_insn_len);
>       s->base.is_jmp = DISAS_NORETURN;
>   
>       return true;
> 
> ---
> base-commit: d73149283205645625bfa9fe029cfb68e4c4a9ae
> change-id: 20261104-research-vsetivli-direct-chain-20261103-69536f07be37
> 
> Best regards,


