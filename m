Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0BBC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJYE-0004Hb-9L; Fri, 10 Jul 2026 18:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJYC-0004H2-VN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:18:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJYB-0004h2-8F
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:18:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALCl931931562
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zqrpRIMQGVyr08KFahiw99zYaEHxTBaUO7oUtEVnDpw=; b=ioILwYHR1azIi6TD
 CdcJCNa1Le/FI68oe27iR7GvuasqmupgziFUTTr3F/LmnSHIp9Gq2cKcirlwRtNp
 VM6okYAsDJYYByOJ+yuRb+IYrvN8eUuc+yDILJddCk15Miyidu3eBR2yaP6SmUiH
 WZuD2bj38rixpFxK5qxK0NN5N1yNAiTqpFVwPyo0ufXj79hDFRVEYCKQ0vh5zsbD
 BG0ZXWPmXY3wAqDCA57zzfiT/DOWbQ0AQrZBrVUMCVmX/nyUn2PA9pn2aC2Rq0xD
 2dh33WwT9l7OR6wcNuEz11Bxa8p1yYyokmq9r56pfrJmpEuPCLhGHQaqk8f3he0F
 lU3qow==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r5tf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:18:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a8db414c7so19768591cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783721904; x=1784326704; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zqrpRIMQGVyr08KFahiw99zYaEHxTBaUO7oUtEVnDpw=;
 b=dVJ/tYht/WZ2SXRC6QN5mgGNiBPznbKol43DJI1+ppcnkuilGxZIzALZhj/PzwiIoX
 SXGqfnZz3wyPfgv6UUMT7wWaOuFSHUxfgPTpdFvFZnugMUqzkOM5OuVTkbZh2DEqlLif
 NIU7qGlouHhby12KfO/VMHZsyetXU5HVPdIOZ4MEviiHv0aJus3VwMLBFYI0J301DNxv
 7zcqmFznmpjJomvK7GBzeGiGp+atZ0N92Pk12LqzSSugV7Lw0Gm6hhVrbNLMuEJlJ9Lb
 YCjshWvuVGtWS3T22F1SdUmOtITc5o7224ot5Y4eK1IAClGlbf4I0gAQZGxHD5hFlH6i
 PLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783721904; x=1784326704;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zqrpRIMQGVyr08KFahiw99zYaEHxTBaUO7oUtEVnDpw=;
 b=ECiSjyqxBgu8d+0EJbLkjYTFRNrYw12U8ovrTVXbD9S7OJFiGuG0I1QYACf5kzYEMQ
 0EqawYS+L9kZpvhqu2ui+2kwy4SQt1rWfGRAw8UrYtWw2V9uPjexdPT1MDOtLrExX970
 BsbCc8EqOfShFlKgzvMaCOS3St5XnQ+rGymiwelR7XAaRHibGj5QKT56kcCCe54qZaqN
 A6iDrZnXFHQYVhcfBtsHoqmaCTvEE9a7f4d4LyQAG3C4FC2IEKRnqmUoE918GeMgx3nq
 xcol50dDLAP/JcgnWPfxRiEOsOXg/pdzl5XHKufjMTEixAzuB25wqPkWJuPiOv2kaUTS
 giqg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFZ/NiLvwp3KZqG4RbA6QcU7mF3VY/InLQrMq66iQMQrRaIsnluHIxTBIUPZ08APtXPISeIst9uW3U@nongnu.org
X-Gm-Message-State: AOJu0Yyvev5G3ftqfyKtgRIYc9iRghscAEyY4PQEj+Wy7Vcgj1eBpHqf
 i8kSXzKxZzka4r82x+flPG6foib824beDpfMFzTNBb+s6+L8g8qf4LEfd7pdKDhhZmZhjY71fh6
 29nfSmstRBT0IFOwofG/WBpwoBbaRl4R+CNaofhd+CupOZ2IEUqeJxIR7aQ==
X-Gm-Gg: AfdE7cliMm1nkgG6k/CyAcdow5JRZjd0gAn09hBByiljtp+WwCQCMPWOOMLN0dx19Wa
 KJQxdXv8E4coZGHnLyyZXzZhq8abNzEKtNIR0VBdiQUh8N1uoVUSN6tUjII739SIxeUNpRoDhyl
 KGmhSJc4zZMY65kWwyBJbF3Vzyw9PXCR49/c4WdrE2m7tvww1SCIScKaQuwv8j/Zzo691IZEGxk
 4sKAaxIy2nVDXQP8ACERaKjQwbz//hSf+k6HLoy9K9zGzkSJ4RyZ+02HqiceZhfPHT5iwA0Q31B
 3ua8Lluk6LOJftye8EhAgdgf7HwzbRHRtCHZJqTnysWLkXVs656bjgNXzr/ZQiq95uq+rivDqA3
 YGO2Q03fA3+zrhaefhRLoAkIPYgaOlaE+Zmk4LLPvb8+UjEF5bsbLr/euHLTkoQ==
X-Received: by 2002:a05:622a:2517:b0:50f:c1d4:d9e1 with SMTP id
 d75a77b69052e-51cbf1c358amr9080241cf.38.1783721904155; 
 Fri, 10 Jul 2026 15:18:24 -0700 (PDT)
X-Received: by 2002:a05:622a:2517:b0:50f:c1d4:d9e1 with SMTP id
 d75a77b69052e-51cbf1c358amr9079911cf.38.1783721903594; 
 Fri, 10 Jul 2026 15:18:23 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f4cbc620sm66970205e9.13.2026.07.10.15.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:18:22 -0700 (PDT)
Message-ID: <65f5aa4d-f730-4b7b-ac70-871a3ab6c150@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 47/51] accel/tcg: Use addr/last in
 tlb_flush_range_locked
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-48-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a516fb0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=tFyL1U_a-0HfV1VqAh8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 75GhGzOZihDalCuHaYbeSJNeDh0mn8LB
X-Proofpoint-ORIG-GUID: 75GhGzOZihDalCuHaYbeSJNeDh0mn8LB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNCBTYWx0ZWRfX4XvSxPri2uOC
 qWN10DfKCuDeeb1dHQ63wAtiIrEn7A/aqYdcycM819TG3pv7hqgajwUTZMCG5TeKLshMvFn90Tg
 O8fImufSR3HbUpwLoBQ0w3TPm/pqNDM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNCBTYWx0ZWRfX8TiC7aZDhF6G
 t+Hc3yaDmlsfVCY6Xqm95VXv8opRF3ScO1uOTon2nCIjxPbO24ZuUTJd07RLCjWGFaDIjn/QbtQ
 Z4zmcQLjZXIXM/f27TwX44aQpdy0Sfe68wBJML9y4s+0pgRwnDwMuUZ1TYO+DHjWERlHBMSSsET
 HYqDPLj1gJhKhLuc5kydtZp2oTFKM1ZANkPrv4yDHeRv3JiymPg3a4OtgAp7ZCYCcREkkk5Y5UA
 +S8PquoSxciPTYWxZCmU4KLREEV3LsPO8BF+IRxpuMI9l31XA4HHc3SMlv3PIxS004GUTFf0qm1
 Fn76aUmTpQ63o86GcmET4YCDDw6vuyZ5xPVgBgxdGGF+1bGGzkqOsR/Zr2Mcm75Je/s/gpAHYkN
 GC3z/PK1YtpvNpN7ECdvVsYlf/SE6pE6Aesu41dBBBchkhmluTiXundZaxkAD6BznXPJeOd61lD
 qasMT9BbG63t3nm/VtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100224
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 10/7/26 22:53, Richard Henderson wrote:
> Change from addr/len to addr/last in the implementation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 71 +++++++++++++++++++++++++---------------------
>   1 file changed, 38 insertions(+), 33 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index c8ba727859..2c0f7bed52 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -655,7 +655,7 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
>   }
>   
>   static void tlb_flush_range_locked(CPUState *cpu, int midx,
> -                                   vaddr addr, vaddr len,
> +                                   vaddr addr, vaddr last,
>                                      unsigned bits)
>   {
>       CPUTLBDesc *d = &cpu->neg.tlb.d[midx];
> @@ -669,13 +669,13 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
>        * TODO: Perhaps allow bits to be a few bits less than the size.
>        * For now, just flush the entire TLB.
>        *
> -     * If @len is larger than the tlb size, then it will take longer to
> +     * If [addr:last] is larger than the tlb size, then it will take longer to
>        * test all of the entries in the TLB than it will to flush it all.
>        */

[start:last] used in include/user/page-protection.h sounds clearer TBH.

