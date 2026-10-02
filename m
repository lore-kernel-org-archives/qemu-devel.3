Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1314CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 05:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCWFn-0007Um-QA; Fri, 02 Oct 2026 01:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCWFj-0007UO-7P
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 01:56:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCWFh-00026e-9E
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 01:56:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6925jMRw658478
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 05:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8E2FcrWFtQzoHqmHUGBOry/IEuIMn1Gr9r+T8CUUpDk=; b=eBBvWawl7B5Wma2c
 lmEpaL9ecuBJ4OJYCQPoCsHEie2B3OzqpqMdwfgZd5cWUqPqYgCmJOP21p88D+Jg
 HxG1PRqOcMUSAOT8YBloFZJTFQIYs0CDUfNvefS+OgSp8YvP2UzWYY1DzkRs8P22
 fixmX4lRO2KsIJB3hwHndm3HQu+gTeenUHcSSPyi9YurdlSY4CYIbyKLsg4OTpYv
 /jBcaKcsqraT2umenXI/iNzpi/zoWphDdbu+Y6e8GW9nITYXInv7WJRW3J5j3+ws
 VGZILM4G+JLIHn4J/YPMIZGmBuNun5gfs4hE4OmYHa0dF/xDXuQ1lCdwNFg4/o1F
 YC6vUA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20nfs1m9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 05:56:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cbacbb996so211778485a.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790920570; x=1791525370; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8E2FcrWFtQzoHqmHUGBOry/IEuIMn1Gr9r+T8CUUpDk=;
 b=IHX9EPN+6OtV2y/ehQ5G4U74Cg6U4MRBNyAn+v/Xe34pwh8FsPt3QbEcC4h5IwQwwj
 XtJv7q7m13gKoKWU9izSZPfrgikYLkH1YQVmO6sp3MmE6I7CV27Me/jjjbWYhn09qFGM
 uNSZhMkFpMx+V1GdsKXDqoOcjsLKOpdn4EDiddlyRe34+kqBi2wcrNkZP1tod2tuIEaf
 E5LO8q16RknKcCnDPYlcCGuU/u/o1i6FNyXdlnVJHvYr1xYAm4CwZ15TdLyb97mm0zni
 VU/YjuwTuHlBzK4tPLDz6+iShmRSjx+6RK1Opb8n14fn2gypcv0UrDXJNNFpdSyC2qNr
 HqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790920570; x=1791525370;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8E2FcrWFtQzoHqmHUGBOry/IEuIMn1Gr9r+T8CUUpDk=;
 b=oUxVk+z5iWcnufi5Ft1HdirqItUnzFckGNS4/H3I877mk3xeFpI8y05O+dSOydaX2W
 4TdOld4n8ujb5UpFVLOBnA9juoDuahXTODnntBcFpJr5WjUAK135lIlFRha3JDvk/Gri
 zLeEelekxAU7hksatr8JdmHdTBf2pXO0jS2V1wktYoIy/juy+OwCiO82b4g9yv5qohPn
 1N7mB0ABeAY4H9ymqtT73kWh5uAs0KoDjS2c6BJ0Ex4EEb87+H6TFx+tqBiUWnw0Iida
 XEg+J4lUz2S6g5Gv+d30rlslJcmdyjVrjq4iYdyxw3eiQbXveylh4cwsOtNY1XxMu7OS
 F10w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbPDlX0WwmAbmQ7TLGDhVa7RT9smYoxEkn2JOtfgc9mBOtjUZySqPFyaNF/2GIv+P9Utv5JBNXr0Ik@nongnu.org
X-Gm-Message-State: AFuF++nKp4IwGhrCbd9Bppew2GZAvcGv1DHMZGrSjMQ7lKPb3bISqjpT
 hn25I+t7kKtnOanzRxLMp/C8KBvsQP5fDAs+Vlqd35TpE3HJElXFLCpbKaGtWOnOhpgipIZCvx6
 xQ1++YFYB/UYCpAFuCfN4TAYd4TUuM3hQY/brLp3iZ6d4Qqp9KDP/9w5MHg==
X-Gm-Gg: AYBFou2jwa+UlDXO1Ci9H2CpmSpb2P/nZ+TDBSrno+R28bldkxTF4gulI5/Oijhc+51
 +AEYeFctmuLLh5MrVHu5VzcGWzG/xWk+PatLXiNwVdDIPGubPeMOP+IkYKYDQNFMeNFFIn69qck
 6lKyWVKRsJgVX1jKVUSMonj4zibByYaxtdoPUORtowIdYtHZ5aW50v807PQkSp9JpGFA2dKUUex
 7/4/9i6arENstJ6VsCJlakebbwmbeShtA8tnKKkhI5Fb7oCmDaP9zh9gVaEJCFNUwCbK15ZKYv6
 nmy1vDrRhUV+nJ6uev+xglLlFDtEwxDBhu3x5LNnJjEhI3KjhIzotnkOBToVeAcl04hPU4YhAN6
 nJBAFmIJ1neNmnEMDxlqPp5MRDy1OgjM3Kw==
X-Received: by 2002:a05:620a:271c:b0:939:6de6:9518 with SMTP id
 af79cd13be357-93cf1763839mr237442685a.47.1790920570354; 
 Thu, 01 Oct 2026 22:56:10 -0700 (PDT)
X-Received: by 2002:a05:620a:271c:b0:939:6de6:9518 with SMTP id
 af79cd13be357-93cf1763839mr237440185a.47.1790920569904; 
 Thu, 01 Oct 2026 22:56:09 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38307190sm3074601f8f.45.2026.10.01.22.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 22:56:09 -0700 (PDT)
Message-ID: <496e9e78-1def-4877-9312-8d6764b63639@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 07:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] target/riscv: Make internals.h target agnostic
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-1-ea69b07afd31@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261001-rv-dedup-v1-1-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WxHoFxK4gwvIO0q1Zr3Wo2Hp6gRY3k1f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyMyBTYWx0ZWRfX/LTqWnhA2LNd
 jYVVqA75i2hupFyyiGW2Hbxv5kn4UnudCEFigaiDd9hlU3PaP3VAYzsiHjAOFlB1lbZAlZTSSsG
 Npa+9vsLEY1csRZ80oyX/WNLUnAv3iI=
X-Proofpoint-ORIG-GUID: WxHoFxK4gwvIO0q1Zr3Wo2Hp6gRY3k1f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyMyBTYWx0ZWRfX2KJirkX8l0G8
 PekYPBhSW43YLlcJC3zdcukEsjppxq4zTp8XcWYsHi2aqrbhLTxlvn9g+LeTOj8F93sSGGrAvdT
 6c1mEhMlR8wgq/RbVwZenWvloYVraqfsYB3ffrdKV5Tjvubjpkv0EInv8duIpqWq09nv3JFRJL7
 P+9OvxbYnILyfVI+qfTCgQmpCCOCTZ+iyEub9dscOFEXe71gBiKsZ35GOd3DL9eMJr8uOQ0gyO4
 lN3cs+21GWdXrRzYJHll3jED1OpgNFKDrEwxulChy7qup+MZzgWIjm9ohV+z1vNKpg1EQdLIg8k
 XTu9ku47dJwthV3NNBcxcVrxUwQFHKGLtaSIgjna4yA1SvXiQiMUeBJia3ppZfW/7+Ry9NaWum1
 3M9o2JZNhZZQulHcy0ASgpFXkkH/B1IpWmgCHCiZ7n6HJithPnStUejp32mJZRBTXrsI4uEXc2K
 iEJJ192J5i9/Dr/cyIA==
X-Authority-Analysis: v=2.4 cv=f+jdl+yM c=1 sm=1 tr=0 ts=6abf477b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=MA8BGWbniLDi54e50OQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020023
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/10/26 17:59, Anton Johansson via qemu development wrote:
> Replaces uses of target_ulong with fixed-size integers, this is a
> prerequisite step to compiling cpu.c once for system-mode.
> 
> Note: the widening of target_long to int64_t in adjust_addr_body() is
> safe as rv32 is ruled out earlier in the function via the check
> 
>    /* do nothing for rv32 mode */
>    if (riscv_cpu_mxl(env) == MXL_RV32) {
>        return addr;
>    }
> 
> meaning target_long must be equal to int64_t anyway.
> 
> Duplicate includes between vector_helper.c and vector_internals.h are
> removed.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/internals.h            | 31 +++++++++---------
>   target/riscv/tcg/vector_internals.h |  5 +--
>   target/riscv/tcg/vector_helper.c    | 64 +++++++++++++++++--------------------
>   3 files changed, 47 insertions(+), 53 deletions(-)


>   /* Zjpm addr masking routine */
> -static inline target_ulong adjust_addr_body(CPURISCVState *env,
> -                                            target_ulong addr,
> -                                            bool is_virt_addr)
> +static inline uint64_t adjust_addr_body(CPURISCVState *env,
> +                                        uint64_t addr,
> +                                        bool is_virt_addr)
>   {
>       RISCVPmPmm pmm = PMM_FIELD_DISABLED;
>       uint32_t pmlen = 0;
> @@ -239,7 +238,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
>   
>       /* sign/zero extend masked address by N-1 bit */
>       if (signext) {
> -        addr = (target_long)addr >> pmlen;
> +        addr = (int64_t)addr >> pmlen;
>       } else {
>           addr = addr >> pmlen;
>       }
Maybe safer as (untested):

         addr = (sign ? sextract64 : extract64)
                (addr, 0, (riscv_cpu_mxl_bits(env) - pmlen);

