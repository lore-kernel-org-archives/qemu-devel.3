Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B32C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 15:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wglA0-0004Kx-8G; Mon, 06 Jul 2026 11:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wgl9z-0004Kb-0H; Mon, 06 Jul 2026 11:23:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wgl9v-0006Xj-M3; Mon, 06 Jul 2026 11:23:02 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FIQ8S4069640; Mon, 6 Jul 2026 15:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SsCq2I
 ZNFRmy9bqqBi1V9xPkZfISfMJdtpRwCD3c49M=; b=gdIXobpsX3U6c3TCVhK8NV
 mNv8DuVhNDXrtPua/rDt/7JSNLCbWYWcjI02lS7ZzoM9FO0s6xiYUzFLxi1A7zjr
 TTJLbmAacZmtjxUuScGBkaLH1iXcyxJylue+rHMO+t/GIUKXHGirPJ/nt/zgbuDl
 52gvEFkXbwKa3KVazUSx6/AVXQetajZQt3lczn7KmepgzCog3Fn7zeZ6WjScVdCK
 C2iGym0dFEGmLUhFddHrz9yrOx9F3Xsr0dPo8iTMtnDkyGlA79W8ZAhwf7SNqHkJ
 cqvFFvFryVDQuSXTH5fVIRoHWDxuwYGhPSd2d4GMgPPF8N/yeAGBmg4X0YUXXnTg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdjr1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 15:22:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666FJuMY028631;
 Mon, 6 Jul 2026 15:22:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfww53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 15:22:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666FMtEZ1245896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 15:22:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C285D58062;
 Mon,  6 Jul 2026 15:22:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F94E58059;
 Mon,  6 Jul 2026 15:22:52 +0000 (GMT)
Received: from [9.124.213.143] (unknown [9.124.213.143])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 15:22:51 +0000 (GMT)
Message-ID: <fe7d9247-70f5-4f37-b5d5-86938518e7c9@linux.ibm.com>
Date: Mon, 6 Jul 2026 20:52:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 23/28] target/ppc: Move VMX integer arithmetic and BCD
 instructions to decodetree.
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, shivangu@linux.ibm.com
Cc: milesg@linux.ibm.com, richard.henderson@linaro.org, harshpb@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-24-rathc@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260520160728.2283628-24-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4bc851 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=k6pmM3x2w95Kt7QaEM8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1NiBTYWx0ZWRfX7wtri43iTItA
 HJjCwXaPy7WucphUSnJz3YKklAsRjp9FzVbAqDJIIlKhprW3Rtb+2Laz4bCnJyPrOK9F6Yr4jVP
 wGbrkBSedFls30dsrvKc5MONIoIq/VNcYQn9FxoRXKjFpLiHaBDBGsSM/Wb0WOV5/mr19cfjTY3
 1jTcxA2MECx1ilTg76ZloW6ZhpiSy8z/2k1b2R9U5I1+eCneRVXV19UONt1lqjkpHxU+lO+SNBU
 2fpr01G/I066f4jvROX+topA5rfU8JDImXcBD1jzIdhpQw+GDUFoNRZ1/VjM4nLfE2mI+nU21FK
 3vl5Q1woemOIjHWaIXBbiVF4YbxvLwAuidgRqPgwhvXt5OkSup73qqdZZFdirDMGPGxi4h9UbE2
 7EvWdvFWr+EZxDBShQ4ZD+A19afDA1quMr2p8cVrxb9RsWl0wAV8BrfZnXosjosN187/HRRyCWA
 eW92K28DHocJPUdzfkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1NiBTYWx0ZWRfX1tfTdJIPBUJC
 4ikZ19B8BPHaWdWrWmTFC3hLzJP+Oh98fWbP78sjj/zBeYVcV7yrRNzh/X2dPJubCwVS4KeY675
 M5fdvsv0fEf1NvHX4MK37ciDZWqDtiU=
X-Proofpoint-GUID: gNovDXPJvQHnASwluKfLW3fcQsVAXtoj
X-Proofpoint-ORIG-GUID: gNovDXPJvQHnASwluKfLW3fcQsVAXtoj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 5/20/26 21:37, Chinmay Rath wrote:
> From: Shivang Upadhyay <shivangu@linux.ibm.com>
>
> Move below instructions to decodetree specification :
>
>          vadd{u, s}{b, h, w, d}m[.],
>          vsub{u, s}{b, h, w, d}m[.],
>          vmuluwm[.],
>          vmul10{u, eu, ecu, cu}q[.]       : VX-form
>
>          bcd{add, sub}[.],
>          bcd{s, us}[.],
>          bcdcpsgn[.],
>          bcdct{sq, n}[.],
>          bcdcf{sq, z, n}[.],
>          bcdctz[.],
>          bcdsetsgn[.],
>          bcdsr[.],
>          bcd{u,}trunc[.]                  : VX-form
>
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the '-d
> in_asm,op' flag.
>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/helper.h                 |  30 +--
>   target/ppc/insn32.decode            |  39 ++++
>   target/ppc/int_helper.c             |  32 ++--
>   target/ppc/translate/vmx-impl.c.inc | 286 +++++++++++++---------------
>   target/ppc/translate/vmx-ops.c.inc  |  22 ---
>   5 files changed, 200 insertions(+), 209 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 50493a72a5..1db6f81ddc 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -350,21 +350,21 @@ DEF_HELPER_FLAGS_3(vshasigmaw, TCG_CALL_NO_RWG, void, avr, avr, i32)
>   DEF_HELPER_FLAGS_3(vshasigmad, TCG_CALL_NO_RWG, void, avr, avr, i32)
>   DEF_HELPER_FLAGS_4(vpermxor, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
>   
> -DEF_HELPER_FLAGS_4(bcdadd, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> -DEF_HELPER_FLAGS_4(bcdsub, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> -DEF_HELPER_FLAGS_3(bcdcfn, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> -DEF_HELPER_FLAGS_3(bcdctn, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> -DEF_HELPER_FLAGS_3(bcdcfz, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> -DEF_HELPER_FLAGS_3(bcdctz, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> -DEF_HELPER_FLAGS_3(bcdcfsq, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> -DEF_HELPER_FLAGS_3(bcdctsq, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> -DEF_HELPER_FLAGS_4(bcdcpsgn, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> -DEF_HELPER_FLAGS_3(bcdsetsgn, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> -DEF_HELPER_FLAGS_4(bcds, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> -DEF_HELPER_FLAGS_4(bcdus, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> -DEF_HELPER_FLAGS_4(bcdsr, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> -DEF_HELPER_FLAGS_4(bcdtrunc, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> -DEF_HELPER_FLAGS_4(bcdutrunc, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> +DEF_HELPER_FLAGS_4(BCDADD, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> +DEF_HELPER_FLAGS_4(BCDSUB, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> +DEF_HELPER_FLAGS_3(BCDCFN, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> +DEF_HELPER_FLAGS_3(BCDCTN, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> +DEF_HELPER_FLAGS_3(BCDCFZ, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> +DEF_HELPER_FLAGS_3(BCDCTZ, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> +DEF_HELPER_FLAGS_3(BCDCFSQ, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> +DEF_HELPER_FLAGS_3(BCDCTSQ, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> +DEF_HELPER_FLAGS_4(BCDCPSGN, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> +DEF_HELPER_FLAGS_3(BCDSETSGN, TCG_CALL_NO_RWG, i32, avr, avr, i32)
> +DEF_HELPER_FLAGS_4(BCDS, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> +DEF_HELPER_FLAGS_4(BCDUS, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> +DEF_HELPER_FLAGS_4(BCDSR, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> +DEF_HELPER_FLAGS_4(BCDTRUNC, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
> +DEF_HELPER_FLAGS_4(BCDUTRUNC, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
>   
>   DEF_HELPER_4(XSADDDP, void, env, vsr, vsr, vsr)
>   DEF_HELPER_5(xsaddqp, void, env, i32, vsr, vsr, vsr)
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 0ec9a4d5de..56c9f2568d 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -90,6 +90,9 @@
>   &VX             vrt vra vrb
>   @VX             ...... vrt:5 vra:5 vrb:5 .......... .           &VX
>   
> +&VX_ps             vrt vra vrb ps
> +@VX_ps             ...... vrt:5 vra:5 vrb:5 . ps:1 ........ .           &VX_ps
> +
>   &VX_bf          bf vra vrb
>   @VX_bf          ...... bf:3 .. vra:5 vrb:5 ...........          &VX_bf
>   
> @@ -108,6 +111,9 @@
>   &VX_tb          vrt vrb
>   @VX_tb          ...... vrt:5 ..... vrb:5 ...........            &VX_tb
>   
> +&VX_tb_ps       vrt vrb ps
> +@VX_tb_ps       ...... vrt:5 ..... vrb:5 . ps:1 .........            &VX_tb_ps
> +
>   &X              rt ra rb
>   @X              ...... rt:5 ra:5 rb:5 .......... .              &X
>   
> @@ -991,6 +997,10 @@ VADDSBS         000100 ..... ..... ..... 01100000000    @VX
>   VADDSHS         000100 ..... ..... ..... 01101000000    @VX
>   VADDSWS         000100 ..... ..... ..... 01110000000    @VX
>   
> +VADDUBM         000100 ..... ..... ..... 00000000000    @VX
> +VADDUHM         000100 ..... ..... ..... 00001000000    @VX
> +VADDUWM         000100 ..... ..... ..... 00010000000    @VX
> +VADDUDM         000100 ..... ..... ..... 00011000000    @VX
>   VADDUBS         000100 ..... ..... ..... 01000000000    @VX
>   VADDUHS         000100 ..... ..... ..... 01001000000    @VX
>   VADDUWS         000100 ..... ..... ..... 01010000000    @VX
> @@ -1006,6 +1016,10 @@ VSUBSBS         000100 ..... ..... ..... 11100000000    @VX
>   VSUBSHS         000100 ..... ..... ..... 11101000000    @VX
>   VSUBSWS         000100 ..... ..... ..... 11110000000    @VX
>   
> +VSUBUBM         000100 ..... ..... ..... 10000000000    @VX
> +VSUBUHM         000100 ..... ..... ..... 10001000000    @VX
> +VSUBUWM         000100 ..... ..... ..... 10010000000    @VX
> +VSUBUDM         000100 ..... ..... ..... 10011000000    @VX
>   VSUBUBS         000100 ..... ..... ..... 11000000000    @VX
>   VSUBUHS         000100 ..... ..... ..... 11001000000    @VX
>   VSUBUWS         000100 ..... ..... ..... 11010000000    @VX
> @@ -1099,6 +1113,13 @@ VMULHSD         000100 ..... ..... ..... 01111001001    @VX
>   VMULHUD         000100 ..... ..... ..... 01011001001    @VX
>   VMULLD          000100 ..... ..... ..... 00111001001    @VX
>   
> +VMULUWM         000100 ..... ..... ..... 00010001001    @VX
> +
> +VMUL10UQ        000100 ..... ..... ..... 01000000001    @VX
> +VMUL10EUQ       000100 ..... ..... ..... 01001000001    @VX
> +VMUL10ECUQ      000100 ..... ..... ..... 00001000001    @VX
> +VMUL10CUQ       000100 ..... ..... ..... 00000000001    @VX
> +
>   ## Vector Multiply-Sum Instructions
>   
>   VMSUMUBM        000100 ..... ..... ..... ..... 100100   @VA
> @@ -1141,6 +1162,24 @@ VPKSWSS         000100 ..... ..... ..... 0011100111 0    @VX
>   VPKSDSS         000100 ..... ..... ..... 1011100111 0    @VX
>   VPKPX           000100 ..... ..... ..... 0110000111 0    @VX
>   
> +## Decimal Integer Arithmetic Instructions
> +
> +BCDADD          000100 ..... ..... ..... 1.000000001    @VX_ps
> +BCDSUB          000100 ..... ..... ..... 1.001000001    @VX_ps
> +BCDUS           000100 ..... ..... ..... 10010000001    @VX
> +BCDS            000100 ..... ..... ..... 1.011000001    @VX_ps
> +BCDCTSQ         000100 ..... 00000 ..... 10110000001    @VX_tb
> +BCDCTN          000100 ..... 00101 ..... 10110000001    @VX_tb
> +BCDCFSQ         000100 ..... 00010 ..... 1.110000001    @VX_tb_ps
> +BCDCTZ          000100 ..... 00100 ..... 1.110000001    @VX_tb_ps
> +BCDCFZ          000100 ..... 00110 ..... 1.110000001    @VX_tb_ps
> +BCDCFN          000100 ..... 00111 ..... 1.110000001    @VX_tb_ps
> +BCDSETSGN       000100 ..... 11111 ..... 1.110000001    @VX_tb_ps
> +BCDCPSGN        000100 ..... ..... ..... 01101000001    @VX
> +BCDSR           000100 ..... ..... ..... 1.111000001    @VX_ps
> +BCDTRUNC        000100 ..... ..... ..... 1.100000001    @VX_ps
> +BCDUTRUNC       000100 ..... ..... ..... 10101000001    @VX
> +
>   # VSX Load/Store Instructions
>   
>   LXSD            111001 ..... ..... .............. 10    @DS
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 8e8076a92c..86346f5b9a 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -2348,7 +2348,7 @@ static void bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
>       *overflow = carry;
>   }
>   
> -uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDADD(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>   {
>   
>       int sgna = bcd_get_sgn(a);
> @@ -2395,7 +2395,7 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>       return cr;
>   }
>   
> -uint32_t helper_bcdsub(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDSUB(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>   {
>       ppc_avr_t bcopy = *b;
>       int sgnb = bcd_get_sgn(b);
> @@ -2406,10 +2406,10 @@ uint32_t helper_bcdsub(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>       }
>       /* else invalid ... defer to bcdadd code for proper handling */
>   
> -    return helper_bcdadd(r, a, &bcopy, ps);
> +    return helper_BCDADD(r, a, &bcopy, ps);
>   }
>   
> -uint32_t helper_bcdcfn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDCFN(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>   {
>       int i;
>       int cr = 0;
> @@ -2445,7 +2445,7 @@ uint32_t helper_bcdcfn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>       return cr;
>   }
>   
> -uint32_t helper_bcdctn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDCTN(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>   {
>       int i;
>       int cr = 0;
> @@ -2479,7 +2479,7 @@ uint32_t helper_bcdctn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>       return cr;
>   }
>   
> -uint32_t helper_bcdcfz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDCFZ(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>   {
>       int i;
>       int cr = 0;
> @@ -2523,7 +2523,7 @@ uint32_t helper_bcdcfz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>       return cr;
>   }
>   
> -uint32_t helper_bcdctz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDCTZ(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>   {
>       int i;
>       int cr = 0;
> @@ -2582,7 +2582,7 @@ static inline int ucmp128(uint64_t alo, uint64_t ahi,
>           (ahi > bhi ? 1 : -1);
>   }
>   
> -uint32_t helper_bcdcfsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDCFSQ(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>   {
>       int i;
>       int cr;
> @@ -2640,7 +2640,7 @@ uint32_t helper_bcdcfsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>       return cr;
>   }
>   
> -uint32_t helper_bcdctsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDCTSQ(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>   {
>       uint8_t i;
>       int cr;
> @@ -2680,7 +2680,7 @@ uint32_t helper_bcdctsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>       return cr;
>   }
>   
> -uint32_t helper_bcdcpsgn(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDCPSGN(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>   {
>       int i;
>       int invalid = 0;
> @@ -2703,7 +2703,7 @@ uint32_t helper_bcdcpsgn(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>       return bcd_cmp_zero(r);
>   }
>   
> -uint32_t helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDSETSGN(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>   {
>       int sgnb = bcd_get_sgn(b);
>   
> @@ -2717,7 +2717,7 @@ uint32_t helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>       return bcd_cmp_zero(r);
>   }
>   
> -uint32_t helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDS(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>   {
>       int cr;
>       int i = a->VsrSB(7);
> @@ -2753,7 +2753,7 @@ uint32_t helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>       return cr;
>   }
>   
> -uint32_t helper_bcdus(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDUS(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>   {
>       int cr;
>       int i;
> @@ -2790,7 +2790,7 @@ uint32_t helper_bcdus(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>       return cr;
>   }
>   
> -uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDSR(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>   {
>       int cr;
>       int unused = 0;
> @@ -2836,7 +2836,7 @@ uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>       return cr;
>   }
>   
> -uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDTRUNC(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>   {
>       uint64_t mask;
>       uint32_t ox_flag = 0;
> @@ -2869,7 +2869,7 @@ uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>       return bcd_cmp_zero(&ret) | ox_flag;
>   }
>   
> -uint32_t helper_bcdutrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> +uint32_t helper_BCDUTRUNC(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
>   {
>       int i;
>       uint64_t mask;
> diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
> index 65230f3461..78ed7eccf0 100644
> --- a/target/ppc/translate/vmx-impl.c.inc
> +++ b/target/ppc/translate/vmx-impl.c.inc
> @@ -142,7 +142,8 @@ static void gen_mtvscr(DisasContext *ctx)
>       gen_helper_mtvscr(tcg_env, val);
>   }
>   
> -static void gen_vx_vmul10(DisasContext *ctx, bool add_cin, bool ret_carry)
> +static bool do_vx_vmul10(DisasContext *ctx, arg_VX *a,
> +                         bool add_cin, bool ret_carry)
>   {
>       TCGv_i64 t0;
>       TCGv_i64 t1;
> @@ -150,10 +151,7 @@ static void gen_vx_vmul10(DisasContext *ctx, bool add_cin, bool ret_carry)
>       TCGv_i64 avr;
>       TCGv_i64 ten, z;
>   
> -    if (unlikely(!ctx->altivec_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_VPU);
> -        return;
> -    }
> +    REQUIRE_VECTOR(ctx);
>   
>       t0 = tcg_temp_new_i64();
>       t1 = tcg_temp_new_i64();
> @@ -163,40 +161,33 @@ static void gen_vx_vmul10(DisasContext *ctx, bool add_cin, bool ret_carry)
>       z = tcg_constant_i64(0);
>   
>       if (add_cin) {
> -        get_avr64(avr, rA(ctx->opcode), false);
> +        get_avr64(avr, a->vra, false);
>           tcg_gen_mulu2_i64(t0, t1, avr, ten);
> -        get_avr64(avr, rB(ctx->opcode), false);
> +        get_avr64(avr, a->vrb, false);
>           tcg_gen_andi_i64(t2, avr, 0xF);
>           tcg_gen_add2_i64(avr, t2, t0, t1, t2, z);
> -        set_avr64(rD(ctx->opcode), avr, false);
> +        set_avr64(a->vrt, avr, false);
>       } else {
> -        get_avr64(avr, rA(ctx->opcode), false);
> +        get_avr64(avr, a->vra, false);
>           tcg_gen_mulu2_i64(avr, t2, avr, ten);
> -        set_avr64(rD(ctx->opcode), avr, false);
> +        set_avr64(a->vrt, avr, false);
>       }
>   
>       if (ret_carry) {
> -        get_avr64(avr, rA(ctx->opcode), true);
> +        get_avr64(avr, a->vra, true);
>           tcg_gen_mulu2_i64(t0, t1, avr, ten);
>           tcg_gen_add2_i64(t0, avr, t0, t1, t2, z);
> -        set_avr64(rD(ctx->opcode), avr, false);
> -        set_avr64(rD(ctx->opcode), z, true);
> +        set_avr64(a->vrt, avr, false);
> +        set_avr64(a->vrt, z, true);
>       } else {
> -        get_avr64(avr, rA(ctx->opcode), true);
> +        get_avr64(avr, a->vra, true);
>           tcg_gen_mul_i64(t0, avr, ten);
>           tcg_gen_add_i64(avr, t0, t2);
> -        set_avr64(rD(ctx->opcode), avr, true);
> +        set_avr64(a->vrt, avr, true);
>       }
> -}
> -
> -#define GEN_VX_VMUL10(name, add_cin, ret_carry)                         \
> -    static void glue(gen_, name)(DisasContext *ctx)                     \
> -    { gen_vx_vmul10(ctx, add_cin, ret_carry); }
>   
> -GEN_VX_VMUL10(vmul10uq, 0, 0);
> -GEN_VX_VMUL10(vmul10euq, 1, 0);
> -GEN_VX_VMUL10(vmul10cuq, 0, 1);
> -GEN_VX_VMUL10(vmul10ecuq, 1, 1);
> +    return true;
> +}
>   
>   #define GEN_VXFORM_V(name, vece, tcg_op, opc2, opc3)                    \
>   static void glue(gen_, name)(DisasContext *ctx)                         \
> @@ -338,19 +329,6 @@ static void glue(gen_, name)(DisasContext *ctx)                         \
>       gen_helper_##name(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], rb); \
>   }
>   
> -GEN_VXFORM_V(vaddubm, MO_8, tcg_gen_gvec_add, 0, 0);
> -GEN_VXFORM_DUAL_EXT(vaddubm, PPC_ALTIVEC, PPC_NONE, 0,       \
> -                    vmul10cuq, PPC_NONE, PPC2_ISA300, 0x0000F800)
> -GEN_VXFORM_V(vadduhm, MO_16, tcg_gen_gvec_add, 0, 1);
> -GEN_VXFORM_DUAL(vadduhm, PPC_ALTIVEC, PPC_NONE,  \
> -                vmul10ecuq, PPC_NONE, PPC2_ISA300)
> -GEN_VXFORM_V(vadduwm, MO_32, tcg_gen_gvec_add, 0, 2);
> -GEN_VXFORM_V(vaddudm, MO_64, tcg_gen_gvec_add, 0, 3);
> -GEN_VXFORM_V(vsububm, MO_8, tcg_gen_gvec_sub, 0, 16);
> -GEN_VXFORM_V(vsubuhm, MO_16, tcg_gen_gvec_sub, 0, 17);
> -GEN_VXFORM_V(vsubuwm, MO_32, tcg_gen_gvec_sub, 0, 18);
> -GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
Hey Shivang,
Please clean up any macros that end up being unused after the movement.
GEN_VXFORM_V is one such.

Thanks,
Chinmay
> -
>   static bool do_vmrg(DisasContext *ctx, arg_VX *a,
>                       void (*helper)(TCGv_ptr, TCGv_ptr, TCGv_ptr))
>   {
> @@ -370,6 +348,38 @@ TRANS_FLAGS(ALTIVEC, VMRGLB, do_vmrg, gen_helper_VMRGLB);
>   TRANS_FLAGS(ALTIVEC, VMRGLH, do_vmrg, gen_helper_VMRGLH);
>   TRANS_FLAGS(ALTIVEC, VMRGLW, do_vmrg, gen_helper_VMRGLW);
>   
> +static bool do_vx_vaddsubm(DisasContext *ctx, arg_VX *a, MemOp vece,
> +                           void (*gen_op)(unsigned, uint32_t, uint32_t,
> +                                          uint32_t, uint32_t, uint32_t))
> +{
> +    REQUIRE_VECTOR(ctx);
> +
> +    gen_op(vece,
> +           avr_full_offset(a->vrt),
> +           avr_full_offset(a->vra),
> +           avr_full_offset(a->vrb),
> +           16, 16);
> +
> +    return true;
> +}
> +
> +TRANS_FLAGS(ALTIVEC, VADDUBM, do_vx_vaddsubm, MO_8, tcg_gen_gvec_add)
> +TRANS_FLAGS(ALTIVEC, VADDUHM, do_vx_vaddsubm, MO_16, tcg_gen_gvec_add)
> +TRANS_FLAGS(ALTIVEC, VADDUWM, do_vx_vaddsubm, MO_32, tcg_gen_gvec_add)
> +TRANS_FLAGS2(ALTIVEC_207, VADDUDM, do_vx_vaddsubm, MO_64, tcg_gen_gvec_add)
> +
> +TRANS_FLAGS(ALTIVEC, VSUBUBM, do_vx_vaddsubm, MO_8, tcg_gen_gvec_sub)
> +TRANS_FLAGS(ALTIVEC, VSUBUHM, do_vx_vaddsubm, MO_16, tcg_gen_gvec_sub)
> +TRANS_FLAGS(ALTIVEC, VSUBUWM, do_vx_vaddsubm, MO_32, tcg_gen_gvec_sub)
> +TRANS_FLAGS2(ALTIVEC_207, VSUBUDM, do_vx_vaddsubm, MO_64, tcg_gen_gvec_sub)
> +
> +TRANS_FLAGS2(ALTIVEC_207, VMULUWM, do_vx_vaddsubm, MO_32, tcg_gen_gvec_mul)
> +
> +TRANS_FLAGS2(ISA300, VMUL10CUQ, do_vx_vmul10, false, true)
> +TRANS_FLAGS2(ISA300, VMUL10ECUQ, do_vx_vmul10, true, true)
> +TRANS_FLAGS2(ISA300, VMUL10UQ, do_vx_vmul10, false, false)
> +TRANS_FLAGS2(ISA300, VMUL10EUQ, do_vx_vmul10, true, false)
> +
>   static void trans_vmrgew(DisasContext *ctx)
>   {
>       int VT = rD(ctx->opcode);
> @@ -684,7 +694,6 @@ static void trans_vclzd(DisasContext *ctx)
>       set_avr64(VT, avr, false);
>   }
>   
> -GEN_VXFORM_V(vmuluwm, MO_32, tcg_gen_gvec_mul, 4, 2);
>   GEN_VXFORM(vsrv, 2, 28);
>   GEN_VXFORM(vslv, 2, 29);
>   GEN_VXFORM(vslo, 6, 16);
> @@ -2523,126 +2532,93 @@ GEN_VXFORM(vpmsumb, 4, 16)
>   GEN_VXFORM(vpmsumh, 4, 17)
>   GEN_VXFORM(vpmsumw, 4, 18)
>   
> -#define GEN_BCD(op)                                 \
> -static void gen_##op(DisasContext *ctx)             \
> -{                                                   \
> -    TCGv_ptr ra, rb, rd;                            \
> -    TCGv_i32 ps;                                    \
> -                                                    \
> -    if (unlikely(!ctx->altivec_enabled)) {          \
> -        gen_exception(ctx, POWERPC_EXCP_VPU);       \
> -        return;                                     \
> -    }                                               \
> -                                                    \
> -    ra = gen_avr_ptr(rA(ctx->opcode));              \
> -    rb = gen_avr_ptr(rB(ctx->opcode));              \
> -    rd = gen_avr_ptr(rD(ctx->opcode));              \
> -                                                    \
> -    ps = tcg_constant_i32((ctx->opcode & 0x200) != 0); \
> -                                                    \
> -    gen_helper_##op(cpu_crf[6], rd, ra, rb, ps);    \
> -}
> -
> -#define GEN_BCD2(op)                                \
> -static void gen_##op(DisasContext *ctx)             \
> -{                                                   \
> -    TCGv_ptr rd, rb;                                \
> -    TCGv_i32 ps;                                    \
> -                                                    \
> -    if (unlikely(!ctx->altivec_enabled)) {          \
> -        gen_exception(ctx, POWERPC_EXCP_VPU);       \
> -        return;                                     \
> -    }                                               \
> -                                                    \
> -    rb = gen_avr_ptr(rB(ctx->opcode));              \
> -    rd = gen_avr_ptr(rD(ctx->opcode));              \
> -                                                    \
> -    ps = tcg_constant_i32((ctx->opcode & 0x200) != 0); \
> -                                                    \
> -    gen_helper_##op(cpu_crf[6], rd, rb, ps);        \
> -}
> -
> -GEN_BCD(bcdadd)
> -GEN_BCD(bcdsub)
> -GEN_BCD2(bcdcfn)
> -GEN_BCD2(bcdctn)
> -GEN_BCD2(bcdcfz)
> -GEN_BCD2(bcdctz)
> -GEN_BCD2(bcdcfsq)
> -GEN_BCD2(bcdctsq)
> -GEN_BCD2(bcdsetsgn)
> -GEN_BCD(bcdcpsgn);
> -GEN_BCD(bcds);
> -GEN_BCD(bcdus);
> -GEN_BCD(bcdsr);
> -GEN_BCD(bcdtrunc);
> -GEN_BCD(bcdutrunc);
> -
> -static void gen_xpnd04_1(DisasContext *ctx)
> -{
> -    switch (opc4(ctx->opcode)) {
> -    case 0:
> -        gen_bcdctsq(ctx);
> -        break;
> -    case 2:
> -        gen_bcdcfsq(ctx);
> -        break;
> -    case 4:
> -        gen_bcdctz(ctx);
> -        break;
> -    case 5:
> -        gen_bcdctn(ctx);
> -        break;
> -    case 6:
> -        gen_bcdcfz(ctx);
> -        break;
> -    case 7:
> -        gen_bcdcfn(ctx);
> -        break;
> -    case 31:
> -        gen_bcdsetsgn(ctx);
> -        break;
> -    default:
> -        gen_invalid(ctx);
> -        break;
> -    }
> +static bool do_bcd_ps(DisasContext *ctx, arg_VX_ps *a,
> +                   void (*helper)(TCGv_i32, TCGv_ptr, TCGv_ptr,
> +                                  TCGv_ptr, TCGv_i32))
> +{
> +    TCGv_ptr ra, rb, rd;
> +    TCGv_i32 ps;
> +
> +    REQUIRE_VECTOR(ctx);
> +
> +    ra = gen_avr_ptr(a->vra);
> +    rb = gen_avr_ptr(a->vrb);
> +    rd = gen_avr_ptr(a->vrt);
> +    ps = tcg_constant_i32(a->ps);
> +
> +    helper(cpu_crf[6], rd, ra, rb, ps);
> +    return true;
>   }
>   
> -static void gen_xpnd04_2(DisasContext *ctx)
> -{
> -    switch (opc4(ctx->opcode)) {
> -    case 0:
> -        gen_bcdctsq(ctx);
> -        break;
> -    case 2:
> -        gen_bcdcfsq(ctx);
> -        break;
> -    case 4:
> -        gen_bcdctz(ctx);
> -        break;
> -    case 6:
> -        gen_bcdcfz(ctx);
> -        break;
> -    case 7:
> -        gen_bcdcfn(ctx);
> -        break;
> -    case 31:
> -        gen_bcdsetsgn(ctx);
> -        break;
> -    default:
> -        gen_invalid(ctx);
> -        break;
> -    }
> +static bool do_bcd(DisasContext *ctx, arg_VX *a,
> +                   void (*helper)(TCGv_i32, TCGv_ptr, TCGv_ptr,
> +                                  TCGv_ptr, TCGv_i32))
> +{
> +    TCGv_ptr ra, rb, rd;
> +    TCGv_i32 ps;
> +
> +    REQUIRE_VECTOR(ctx);
> +
> +    ra = gen_avr_ptr(a->vra);
> +    rb = gen_avr_ptr(a->vrb);
> +    rd = gen_avr_ptr(a->vrt);
> +    ps = tcg_constant_i32(0);
> +
> +    helper(cpu_crf[6], rd, ra, rb, ps);
> +    return true;
> +}
> +
> +static bool do_bcd_tb(DisasContext *ctx, arg_VX_tb *a,
> +                    void (*helper)(TCGv_i32, TCGv_ptr, TCGv_ptr, TCGv_i32))
> +{
> +    TCGv_ptr rd, rb;
> +    TCGv_i32 ps;
> +
> +    REQUIRE_VECTOR(ctx);
> +
> +    rb = gen_avr_ptr(a->vrb);
> +    rd = gen_avr_ptr(a->vrt);
> +
> +    ps = tcg_constant_i32(0);
> +
> +    helper(cpu_crf[6], rd, rb, ps);
> +
> +    return true;
>   }
>   
> -GEN_VXFORM_DUAL(vsububm, PPC_ALTIVEC, PPC_NONE, \
> -                bcdadd, PPC_NONE, PPC2_ALTIVEC_207)
> -GEN_VXFORM_DUAL(vsubuhm, PPC_ALTIVEC, PPC_NONE, \
> -                bcdsub, PPC_NONE, PPC2_ALTIVEC_207)
> -GEN_VXFORM_DUAL(vsubudm, PPC2_ALTIVEC_207, PPC_NONE, \
> -                bcds, PPC_NONE, PPC2_ISA300)
> -GEN_VXFORM_DUAL(vsubuwm, PPC_ALTIVEC, PPC_NONE, \
> -                bcdus, PPC_NONE, PPC2_ISA300)
> +static bool do_bcd_tb_ps(DisasContext *ctx, arg_VX_tb_ps *a,
> +                    void (*helper)(TCGv_i32, TCGv_ptr, TCGv_ptr, TCGv_i32))
> +{
> +    TCGv_ptr rd, rb;
> +    TCGv_i32 ps;
> +
> +    REQUIRE_VECTOR(ctx);
> +
> +    rb = gen_avr_ptr(a->vrb);
> +    rd = gen_avr_ptr(a->vrt);
> +
> +    ps = tcg_constant_i32(a->ps);
> +
> +    helper(cpu_crf[6], rd, rb, ps);
> +
> +    return true;
> +}
> +
> +TRANS_FLAGS2(ALTIVEC_207, BCDADD, do_bcd_ps, gen_helper_BCDADD)
> +TRANS_FLAGS2(ALTIVEC_207, BCDSUB, do_bcd_ps, gen_helper_BCDSUB)
> +TRANS_FLAGS2(ISA300, BCDUS, do_bcd, gen_helper_BCDUS)
> +TRANS_FLAGS2(ISA300, BCDS, do_bcd_ps, gen_helper_BCDS)
> +TRANS_FLAGS2(ISA300, BCDCFN, do_bcd_tb_ps, gen_helper_BCDCFN)
> +TRANS_FLAGS2(ISA300, BCDCTN, do_bcd_tb, gen_helper_BCDCTN)
> +TRANS_FLAGS2(ISA300, BCDCFZ, do_bcd_tb_ps, gen_helper_BCDCFZ)
> +TRANS_FLAGS2(ISA300, BCDCTZ, do_bcd_tb_ps, gen_helper_BCDCTZ)
> +TRANS_FLAGS2(ISA300, BCDCFSQ, do_bcd_tb_ps, gen_helper_BCDCFSQ)
> +TRANS_FLAGS2(ISA300, BCDCTSQ, do_bcd_tb, gen_helper_BCDCTSQ)
> +TRANS_FLAGS2(ISA300, BCDSETSGN, do_bcd_tb_ps, gen_helper_BCDSETSGN)
> +TRANS_FLAGS2(ISA300, BCDCPSGN, do_bcd, gen_helper_BCDCPSGN)
> +TRANS_FLAGS2(ISA300, BCDTRUNC, do_bcd_ps, gen_helper_BCDTRUNC)
> +TRANS_FLAGS2(ISA300, BCDUTRUNC, do_bcd, gen_helper_BCDUTRUNC)
> +TRANS_FLAGS2(ISA300, BCDSR, do_bcd_ps, gen_helper_BCDSR)
>   
>   static void gen_vsbox(DisasContext *ctx)
>   {
> @@ -3502,5 +3478,3 @@ TRANS_FLAGS2(ISA310, VMODUQ, do_vx_helper, gen_helper_VMODUQ)
>   #undef GEN_VXFORM_NOA
>   #undef GEN_VXFORM_UIMM
>   #undef GEN_VAFORM_PAIRED
> -
> -#undef GEN_BCD2
> diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
> index 2820976c0f..c1951c6975 100644
> --- a/target/ppc/translate/vmx-ops.c.inc
> +++ b/target/ppc/translate/vmx-ops.c.inc
> @@ -24,39 +24,17 @@ GEN_HANDLER_E(name0##_##name1, 0x4, opc2, opc3, 0x00000000, type0, type1)
>   GEN_HANDLER_E(name0##_##name1, 0x4, opc2, opc3, 0x00000000, tp0, tp1), \
>   GEN_HANDLER_E(name0##_##name1, 0x4, opc2, (opc3 | 0x10), 0x00000000, tp0, tp1),
>   
> -GEN_VXFORM_DUAL(vaddubm, vmul10cuq, 0, 0, PPC_ALTIVEC, PPC_NONE),
> -GEN_VXFORM_DUAL(vadduhm, vmul10ecuq, 0, 1, PPC_ALTIVEC, PPC_NONE),
> -GEN_VXFORM(vadduwm, 0, 2),
> -GEN_VXFORM_207(vaddudm, 0, 3),
> -GEN_VXFORM_DUAL(vsububm, bcdadd, 0, 16, PPC_ALTIVEC, PPC_NONE),
> -GEN_VXFORM_DUAL(vsubuhm, bcdsub, 0, 17, PPC_ALTIVEC, PPC_NONE),
> -GEN_VXFORM_DUAL(vsubuwm, bcdus, 0, 18, PPC_ALTIVEC, PPC2_ISA300),
> -GEN_VXFORM_DUAL(vsubudm, bcds, 0, 19, PPC2_ALTIVEC_207, PPC2_ISA300),
> -GEN_VXFORM_300(bcds, 0, 27),
>   GEN_VXFORM_300(vextublx, 6, 24),
>   GEN_VXFORM_300(vextuhlx, 6, 25),
>   GEN_VXFORM_DUAL(vmrgow, vextuwlx, 6, 26, PPC_NONE, PPC2_ALTIVEC_207),
>   GEN_VXFORM_300(vextubrx, 6, 28),
>   GEN_VXFORM_300(vextuhrx, 6, 29),
>   GEN_VXFORM_DUAL(vmrgew, vextuwrx, 6, 30, PPC_NONE, PPC2_ALTIVEC_207),
> -GEN_VXFORM_207(vmuluwm, 4, 2),
>   GEN_VXFORM_300(vsrv, 2, 28),
>   GEN_VXFORM_300(vslv, 2, 29),
>   GEN_VXFORM(vslo, 6, 16),
>   GEN_VXFORM(vsro, 6, 17),
>   
> -GEN_VXFORM(xpnd04_1, 0, 22),
> -GEN_VXFORM_300(bcdsr, 0, 23),
> -GEN_VXFORM_300(bcdsr, 0, 31),
> -GEN_VXFORM_300_EXT(vmul10uq, 0, 8, 0x0000F800),
> -GEN_VXFORM_300(vmul10euq, 0, 9),
> -GEN_VXFORM_300(bcdcpsgn, 0, 13),
> -GEN_VXFORM_207(bcdadd, 0, 24),
> -GEN_VXFORM_207(bcdsub, 0, 25),
> -GEN_VXFORM_300(bcdtrunc, 0, 28),
> -GEN_VXFORM_300(xpnd04_2, 0, 30),
> -GEN_VXFORM_300(bcdtrunc, 0, 20),
> -GEN_VXFORM_300(bcdutrunc, 0, 21),
>   GEN_VXFORM(vsl, 2, 7),
>   GEN_VXFORM(vsr, 2, 11),
>   GEN_VXFORM(vsum4ubs, 4, 24),

