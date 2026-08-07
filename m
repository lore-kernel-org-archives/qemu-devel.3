Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AB2C5AC82
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsMF3-0006BO-KS; Fri, 07 Aug 2026 11:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsMF2-0006Aq-Dw
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:12:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsMEz-0004gR-TN
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:12:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677CfpGQ680755
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 15:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XR/2cuWnIPLe2HNUK7p7MjclOFkLGz6vzavnYvcztmM=; b=SF2cDcMHRi69Zod0
 Ghsz5kZf4mOcVg8ra8Vj8oXrCW0kxYJ+CEoNAPh/SDuF8K9x701kHvvVDXY5DWls
 AVx7EGjzkyQOOXIok6aYkzcymeGt/LN2XT2OCrQ9C9SQ/B1veB55yLPLZ6gII45E
 gfB8mo6L72FBvxT2T18Ge8dbuOQtHYcb/IhXSg8SgHcOcddKCfhRmqH55n/dsH+y
 AJRne/70K+iiq4gIJbSpk8i7WJXtVNDiDNaTRlMSRT5S5VvInbjkimIEJLeTX/No
 XAJvsV54DrYi8t4UbrT50sSx7dbU4Ad1obCQznX3iMZImLaGsZDNw65pG4mNAX/m
 wVDT6A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwcujhar1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 15:12:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ac0a54110so377070885a.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786115527; x=1786720327; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XR/2cuWnIPLe2HNUK7p7MjclOFkLGz6vzavnYvcztmM=;
 b=jsjfF+nC+AzNFn8EVsOa2HrJtexznBHktiWfZAzXQyVOrmYyE3/ONl5lft02pGFoKg
 F/upjgm7vySqGjV672Bxdi2WWBmIBqGj6Xj5r2YL6uK91m5CB9ao19eca3xZHiS8H/e/
 4W8UJXmeuauk+mqhqqNZQlYpKzlk7sYVSQzTb+uBlymyYyAAJkQXYoKmirnc4sTfMT7o
 x+9CkxBjY5Sf3y4WF/rTMcJNk5EHxY0UNKLFT/+Ap+haly77MLFoIQKMJZbpxCk6U2od
 Hj4t8+vJK97+1WHLcbB8J8HoBXwJnxM24CjqcCOoE+VhzBUELcDkMKi9YsKKv8kqxKzl
 5Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786115527; x=1786720327;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XR/2cuWnIPLe2HNUK7p7MjclOFkLGz6vzavnYvcztmM=;
 b=f2ELGW3FU50LdTjZ8AcS32QMpvtGbalg96/WAlLQoZ8koN1iHZsoO6Oj6ILYFtkVCU
 iuAi8YNy4Og7rZVB+/vLlguuf74E6Oz1lD5SNOTuD2GOm/TAe5GND+ow8/1V9cBUFymi
 RBfyg0Y3zVIa/1JmVp1y8Q1sDlqlovIzWtAIRh2OT/aqzkV3Omt/MiAyIoIt1UaELNEC
 WAY7BLGsIEIj+uIOCDa0qk6gcrytTTmaBT0maTMC52MLgrqxfGSBMn79/Tf/bf46aELT
 39CeAk5tiViY4PTtX4WxxSlNds+9E7nU1hmWTLqlrq5cJiSKTnW3ep2JnOcFVoxH1IE9
 TydA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5T1wNkL8rep3RqKDeXfUv8vkgxxtiMQ9kHF3FgoaIshNLXUJWwUOVyV0CXdJBe4yWJKKPJM887eCg@nongnu.org
X-Gm-Message-State: AOJu0YzkLxUy5dtQL/3FlCH0DKc5K3iuRAjHDaOvwoRlg6d01lIW4q53
 RKZHjOA4IufxN/uMVxbfeWTHIaw2ALzEONm7IjwKfCrlPdl7frp5llOYXhNvkzhX3zAbQJv1VuY
 Xzga6BS3dssMOzsxiFc9mvAqnnGb1PouoGCPpoH4JRbrxNw70SxsGCXJGtA==
X-Gm-Gg: AR+sD12WBOO48Eo9DeF59K1nvyZwAGV8pP/peXnQKl6+brAblWSolsnazdpRh/ji8jJ
 Wv46g/4dRc/0g96UHJEfeKg/YmV5+tFXZQ39xLQ56DrBMJAvJImYZStdxwBNtvH6ixuF9IxD2ec
 Mw2VSDbXsJGvIuMVpsQwYl8CLx8iKDiNebm8I7y8l/Y0nngsKxiZoKeP2PivHTVDBKV/xr/nnBg
 Pblng4MavjJ6eu+yNpEVyRTOFGHiXV8sDhTe8gRcHf0aKpKwefGA1k2pm1jHbhSVpBrPxmlF047
 ffk/MKyzL2cGZZjDNbaGLqsuf+/aIrjCRZes3/PpyysxVqDnnVKr+mhke2bDuHteE6I5DjgHMuW
 MvJS6CkW45unVwa10urmw0qMmU1yT5ymSuQA5
X-Received: by 2002:a05:620a:a004:b0:930:f554:40c with SMTP id
 af79cd13be357-93648ff052amr2182993885a.14.1786115526731; 
 Fri, 07 Aug 2026 08:12:06 -0700 (PDT)
X-Received: by 2002:a05:620a:a004:b0:930:f554:40c with SMTP id
 af79cd13be357-93648ff052amr2182984785a.14.1786115526289; 
 Fri, 07 Aug 2026 08:12:06 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e032303sm168811185a.9.2026.08.07.08.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 08:12:05 -0700 (PDT)
Message-ID: <9c8ca1aa-de8e-4ca2-93b4-df10e6e4ea81@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 12:12:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/8] target/riscv: Enable Zicclsm for the compatible
 CPUs
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
References: <20260805164345.698208-1-frank.chang@sifive.com>
 <20260805164345.698208-3-frank.chang@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805164345.698208-3-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX5V8fT5VZWcFc
 Q2hbmHZ1sEa/g2H5v7NZQDVatwWcBnyAtNJBo7j3qO756f3JoLb7uzuWSgVP6Fx4svjO5yUiR/h
 0MogMH0td15mRika1rk3SJqa+TGmh7w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX16Krri1jqRpY
 vSitbrjn26o4SuBXKfGNjxtHxAmTmUIPEPWgknMPeXr3dPZfSDqjqHKEwmiGVf14jWkazv4KevP
 SsMB1/nO9EHTQFtpPRE7CI7j8GZAJBKpWQkX7/UJs54fYb5VaYx4NsfX3mVnsXtAZLzJB9GtbWL
 37dV3Vm+z3xuprtPvlf2C3aD2hbhuV1XKyyoVn9SR5vqyeoYDJBMvQJFKe5aSySAzCOsb43dyyg
 GyECZrj8VeZqZDU9NrcHzhYcFOntRykPmNDVbBeRPyg5DARWw4zrO+sJLvLMfW46bRf/ZQzl2EN
 NNDzZ1DMT48Y7z503b63g7VwKXNqURRFYgZtVgbDeLXYHD9ia/N25ShZLyv444pFKoSlmuUx5Zm
 OGPPG5FCY4uKYDPA6zsf/EL0tz/Jeag+nteParl29hjnpYo4fAmsoWje1RkHmYte/xxvxScDZuy
 BBqBT9vt9fvvCkuJS8w==
X-Proofpoint-ORIG-GUID: wJprIwtbCGvLk05NvntEJccnSrwOb6Hr
X-Proofpoint-GUID: wJprIwtbCGvLk05NvntEJccnSrwOb6Hr
X-Authority-Analysis: v=2.4 cv=Wssb99fv c=1 sm=1 tr=0 ts=6a75f5c7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pFyQfRViAAAA:8 a=JF9118EUAAAA:8 a=EUspDBNiAAAA:8 a=_HahZhrRswo1gu_DB80A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=oJz5jJLG1JtSoe7EL652:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070119
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



On 8/5/2026 1:43 PM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> To support Zicclsm, let's enable Zicclsm for the following compatible
> CPUs:
> 
> - Base 32 CPU (to be backward compatible)
> - Base 64 CPU (to be backward compatible)
> - XuanTie (T-Head) C908
> - Tenstorrent Ascalon
> - Ventana Veyron V1
> - XiangShan Kunminghu
> - MIPS P8700 (ISA doesn't include Zicclsm, but their datasheet claims that
>    it has unaligned load/store support in hardware)
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> ---
>   target/riscv/cpu.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5a82e6563bf..7ee89f6fc4b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3268,6 +3268,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.ext_zicbom = true,
>           .cfg.ext_zicbop = true,
>           .cfg.ext_zicboz = true,
> +        .cfg.ext_zicclsm = true,
>           .cfg.ext_zicntr = true,
>           .cfg.ext_zicsr = true,
>           .cfg.ext_zifencei = true,
> @@ -3340,6 +3341,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.ext_zicbom = true,
>           .cfg.ext_zicbop = true,
>           .cfg.ext_zicboz = true,
> +        .cfg.ext_zicclsm = true,
>           .cfg.ext_zicntr = true,
>           .cfg.ext_zicsr = true,
>           .cfg.ext_zifencei = true,
> @@ -3426,6 +3428,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.ext_zbs = true,
>           .cfg.ext_zkt = true,
>           .cfg.ext_zbkc = true,
> +        .cfg.ext_zicclsm = true,
>           .cfg.ext_zicsr = true,
>           .cfg.ext_zifencei = true,
>           .cfg.ext_zihintpause = true,
> @@ -3469,6 +3472,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.ext_zicbom = true,
>           .cfg.ext_zicbop = true,
>           .cfg.ext_zicboz = true,
> +        .cfg.ext_zicclsm = true,
>           .cfg.ext_zicntr = true,
>           .cfg.ext_zicond = true,
>           .cfg.ext_zicsr = true,
> @@ -3518,6 +3522,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>   
>           /* ISA extensions */
>           .cfg.mmu = true,
> +        .cfg.ext_zicclsm = true,
>           .cfg.ext_zifencei = true,
>           .cfg.ext_zicsr = true,
>           .cfg.pmp = true,
> @@ -3577,6 +3582,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>        * The RISC-V Instruction Set Manual: Volume I
>        * Unprivileged Architecture
>        */
> +    .cfg.ext_zicclsm = true,
>       .cfg.ext_zicntr = true,
>       .cfg.ext_zihpm = true,
>       .cfg.ext_zihintntl = true,
> @@ -3633,6 +3639,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
>           .priv_spec = PRIV_VERSION_1_12_0,
>           .cfg.max_satp_mode = VM_1_10_SV48,
> +        .cfg.ext_zicclsm = true,
>           .cfg.ext_zifencei = true,
>           .cfg.ext_zicsr = true,
>           .cfg.mmu = true,


