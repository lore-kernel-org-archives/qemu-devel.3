Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B256CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxee-0005RU-1j; Wed, 30 Sep 2026 12:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxec-0005QG-MU
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:59:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxea-0004c3-6O
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:59:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE0LiI3283992
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mq9+c5qcr5TaQZK4cwINyvrQNaSIiPHnk7fwG7hwS3g=; b=MU2+ug8kU3Edln49
 BwrDlKstv5FQTSfyNJmLfihLoU5CQoDK0bhCl8moruQhQt0Xln8H4YUzRtaLNFsO
 FUTy4nkmj1JoU1ttGx7tlbRbD5K5/KfvJV7p7HnC3WsBCrOxadMyEBNWrRKUufjZ
 uDXUtokiAtGsXmtOXxzlnChiNer1g1PMdCL4ZN32DWlJXy+8oYOnwNb5lRgUJqA8
 Y7qr267jXW32DynNH+CUGcLzZoBEBXy39vuSgZNjYy27z7yZOQAIiuF7g1CGhfQA
 0dIQ1hg7e0g1IZmX6CScuZgAAGR6rTKuUkh9a1sa8SQBum8X2fcIS5cW1ybzKv/s
 rYZlLA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn3f37-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:59:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a05d645acso1174137685a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790787573; x=1791392373; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mq9+c5qcr5TaQZK4cwINyvrQNaSIiPHnk7fwG7hwS3g=;
 b=JQEaUfuO0JoqSTEfc/IRmN7dUfAbmH2oGXTKDZyLVchBq2ybrbEnizeTUEBt8l/r0/
 MF/40Wk5m1bkmVzbHptIjTF0l0vDsNfmH69qJcVEd53wjwNjfLgU0LtS/70d51vzFzrc
 0af87IHedOV2llOGEpT5WpcKarwVLp5jQPZZlGXA/qsy7/FjzFx0OQbHOZyoYx/lQlMP
 rciy6d0ypj4F0amVINpTJpq9rFHhWy4UIo7AWYHoFaasZDCPLI19KOB6kavq/UcfaQrk
 HG3I/XUrKf1Igka8NG8GT2qrfaT/IYWFmEvZeZhwB/3y25YxMS7rX0HOnvD/xOiuIS14
 gWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787573; x=1791392373;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mq9+c5qcr5TaQZK4cwINyvrQNaSIiPHnk7fwG7hwS3g=;
 b=D1kGEBQ6t8MLmzHV/g5kH4Qo8M+pPEJ9787++c+7+qEEVsuLrVP3eeKcX8LO3oKeyE
 yDU29Jf/lIMo1SsVMS9cnnGRtca4xwPR7UPNBP8Sk/zkAJTXrsMXTWud2BGv7bl1a2Z1
 83Jx4/kRKInQT/496gFF+R0YyKfm25rjP+MwBqfpOqfDPiuGkLWtiXPkPiU7WzAGSfZ5
 36ogNA9zcksLxfS++1sBRjj6dDKfJLv7fkPCCHknJQ8mYI3CFZ2+y/faODnd1DVMtZ8S
 No7Qm+7RV6bQ1OKnc1+Dw2YorRWmo78XXqWoKNylUdvw236yYy/XfgOJtWWII4HwxogE
 o/MA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzh9dpX7UX21fpYEZKdciml06W1bTjXn9egWw+1r3wMh8+9S7dMNv9LMytdw7g6nLH9ShIeTawr7XF7@nongnu.org
X-Gm-Message-State: AFuF++lzWVelgmRgDOR7nU6mEETf7FpP2mx+kx3IIm2Di7tChd6yri9J
 0vbWQPsxYTpROIXS3KbpIwqMaAM6R6xvUEo9mGZzDAyE1NOWIJe3xHnk/jBW+QuJvIs7JL5udBi
 pB35XZyrLETjTOFJF8WwV7Sj/RroZCezQulwtJ8mX70TvJt18pztFJDFQ9w==
X-Gm-Gg: AYBFou2mtW+Gz5nJ2KapDum//x0B9+hZTw6qeL+T4iqtLoP3aVIrliZhcnISY6j+dza
 3vS3ZadcXHzl9e54h6hFYMDU0s9uiHApEAsFT6I9h7n5vQFfECHDa3ykSNKggdzuv5xs41qwJYD
 rszx2HTjDVWh8YaEL1SCCUeAp/5yQZYVLXGumSgsI4z3bIFj2kAbPbHqdXiXV3sTSDHMekz0O6f
 MnclFeeTNSCrWRBRU/98jfEkHGEANR5puBBKxsBQKUJylv7yKEiIlZxiP0i4sgf0i80AB9NSljD
 Idk5YeojYh+Alalwli8wRX+AM1RXs/mA7AnWvPacK5X8ZRpUMBa9I1U/MmtNeoJzDs8Tp0AZgy4
 W+5Kfk66KMmn513kh0p32F11oYLi0E6YH/Q==
X-Received: by 2002:a05:620a:6910:b0:93c:23c0:c2b8 with SMTP id
 af79cd13be357-93ca95018f6mr361498385a.7.1790787573408; 
 Wed, 30 Sep 2026 09:59:33 -0700 (PDT)
X-Received: by 2002:a05:620a:6910:b0:93c:23c0:c2b8 with SMTP id
 af79cd13be357-93ca95018f6mr361493185a.7.1790787572904; 
 Wed, 30 Sep 2026 09:59:32 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0690e19asm331431f8f.18.2026.09.30.09.59.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:59:32 -0700 (PDT)
Message-ID: <53419ffe-9540-40a5-b080-425c5bfbd1b3@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:59:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] hmp: don't crash on invalid register
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
 <20260911-query-reg-v1-1-0c04f0c02cf3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260911-query-reg-v1-1-0c04f0c02cf3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abd3ff6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=B-miyySTQTp80Hq9ejcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 4C_5A2CntMDYf-UZ26RrglG5TVnfze2q
X-Proofpoint-GUID: 4C_5A2CntMDYf-UZ26RrglG5TVnfze2q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NyBTYWx0ZWRfX+aIB74jvPufj
 +C99z3LM3umFwZYN1uWpfhpZxtTOnPCf8Cox7nI+9atcePtkosoOQ/7JBgJFILRch2KZzHeCm26
 4sfvcbBhjmkiJXvlW44G8kNkdPULzdZ1dM6XTM1UBblK6NckzH+sNYdKOEq5Ec5uUWOPOQtX7zj
 d1tOb9sPcJrEYasm/yuIS8U2E89jD396BgaFaUpQIHr9AQRafZw6QZ7zfzgk3nU2Db+N4HCfkzN
 YwqB0wmk84wsDLlO5u9CACZHOC09PEMDXK/WLoLLXP7nHtNoaFTlhHq+GNzDuiGPDDriszHC6ph
 vCWcWnkTbhseG4oLFsZIBQC+y8+PBlLWGMxjaI0m3NzS9W9oCBpydXzs0NlDRwW1boTOT5dIl7q
 ghCKOmfTonY97+vYipJHZOW4Wqa69ofcvF0cGMXSj7DIbh2zKlhywekmFYfI+IMQN/fOPKlWoLo
 ROB9cGdsg8OyqDmfP3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NyBTYWx0ZWRfX5x0u6vhn97da
 SqFOHq8TxPAr4lfl8up2siNTKbvHh7z1i6aWyMdjusWxHieul9Fq8ak8pSwRjPsPse4qNOygOzf
 dMGouN56UuFZOJ2qO4ChasXZ+2XECro=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300067
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 11/9/26 14:27, Marc-AndrÃ© Lureau wrote:
> When printing an invalid/denied register, QEMU crashes with:
> ERROR:include/qemu/bswap.h:488:ldn_le_p: code should not be reached
> 
> (ex: "p $sireg" when siselect=0 on riscv)
> 
> Return false instead.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   monitor/hmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

