Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5345C5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 09:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvWoW-0004St-8W; Sun, 16 Aug 2026 05:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWoR-0004Rs-Uf
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:05:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWoQ-0000LF-Ah
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:05:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67G71fYt3319349
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 77LeBJ+22Eapc1K3oRR7nbu1P891lTBRsoTsMkhlZuo=; b=nD+Xb4YVYQ87bNhP
 bHyvpRpc+pO/XFixO9eAR7KgY3ui91WXODpSiLpNVOIUNGjs8ghic/W18oFgkq3w
 6HuQ701PSs6UHGOQQIQoFEWpX8lpXMxEv9WNkjToylk5ihonI4bH5Rd8IhRO4tF7
 uBYmzvNWgFtdlceyY5oaGj9/DLiv+KxXhNfIrNEjQb/So6E5LmgH4atyBYaN933Y
 jbXBPLS+rX+j/ubXmktPAl+zcptkRlOFLzdJt41fKOONGh4UMvq9WLWbsxyq6BG8
 SBxjBqEV6Ym90woJk0YysvxE6z+vxXZVaylBVFwpkOOCsTMHr9LMlT25udJKdutr
 OyG7Fw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghwk3y7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:05:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52ce3c7cb2eso43740791cf.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 02:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786871147; x=1787475947; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=77LeBJ+22Eapc1K3oRR7nbu1P891lTBRsoTsMkhlZuo=;
 b=EzfPn4raAosXk3e+/q3Rh9q76B6NRiB/fWYMLKhjPDxxC5fW2XEdW5Ds+O+/ZCA0Bq
 yxvB4JofCefLmfQ8fqKhrRArMCZAw7Fv9Nfp0Zf3rRpVAnCuITU5PFpv0mvI0JmrzemB
 kLGS3dzJNSqTDixfUp9DeFWal/CfV+BfdNWjZeHcGPVFBlMDSRRENScQ8KYFUz2UTAVw
 r+QwEHVH0iSfmiGzUCoWQXIbKoMmA2fE61RRQ9rCgYKuXymGs47d9PNQAby2Lyb0UxaH
 ipb289wz4ZMn64fIjUxILu7DncdUzrKccI8j6KA3x8XF9xyOn0aryT9Hulj/ziBsNKYL
 F/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786871147; x=1787475947;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=77LeBJ+22Eapc1K3oRR7nbu1P891lTBRsoTsMkhlZuo=;
 b=Fa0wBqzK5qD/Ipu6+i/Tn9T/TiStAxog0ar88+Q242LRsohSbPclWEyxuG/u4eezDs
 REAtswySTAVJMn4U0kmFWOu2UYqWn/zE0ga6Jn1SBb/o/FZG0IzppRJP/dNN2dvtXCzs
 r6FUE6tZ/UPX6UB3BxW2gXF1KlBX8aZr1Xr8P5L3ylhGlnckwLpz59nsaob/R0zFhJ2q
 GUlTM0Fp/vgxoEzLUjxYc+95VXXAdK2uuEDjwFHbuZS3J4fbOemaRuIxENL+QtAFgMYC
 S6J2TgFO7j5wF8ZMoUSwmr/luObwlucr8jaA0oYy4XLHxfgU8iRQoqzUNc85jWpP2mxD
 5GRg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6t3LLBINfYROtPC3QEuKg5yEaWcwfGo0LieRoljgUe5oMQTO9g2WX5XdpwSbf5yIjUC+iWgOSLXsz@nongnu.org
X-Gm-Message-State: AOJu0YxX8jecDRTH1IcssuqYRtvYGaTZSMwIG4tgDptMzp6eEhTnxb9Z
 8gOSwh2HW+ScYglqI1lEEr0xRHy5L6/YB584YdSdQe6gnvMgeZp25ao0K3SE9ICpFsWNw3sZtiu
 EF/Uk9l/J026BhQmPbDUfms4KptFSdr+RBiqDMPW3C0y/zYxIumnfBR14nA==
X-Gm-Gg: AR+sD12qBqscE1IoL+6KJf9Zw1lGXyjJBnsk4otoL401LIBYmFTM0x1eniViWfITYtd
 dSzkCvZd20E9iJwJuflYGT8zLxWSbLwQzLc4rY3RFGRYTqf6eKuHtit8mN4TzrxZ48Po7IXBoYC
 tSYOwlQEvrnm/GGaiTvIBa9hXiKzPRoefLb7XZMxZoKvBHOmU/jrpmxy+xI1KgoqcdJjBgMPSoj
 ctEBdq2wD0uCkZmOii9TNEWV5IHVcz+Lkl8h7Hmj5ycQiyDgHcIa1hQ483gpwHhmWZ3eLBI+ogx
 eme6K2phKIoUfpthw26u0scgTWJ1Jp/n27JMiRiL84KAG2R4aHCnONfeKDaAKXYykT9hX78uM9X
 W11tnM2pNI+Q+zXGmf9wmjWAywSF+dUe5Uxs=
X-Received: by 2002:a05:622a:40c8:b0:527:7842:72cc with SMTP id
 d75a77b69052e-52d854e5526mr203053561cf.39.1786871146670; 
 Sun, 16 Aug 2026 02:05:46 -0700 (PDT)
X-Received: by 2002:a05:622a:40c8:b0:527:7842:72cc with SMTP id
 d75a77b69052e-52d854e5526mr203053341cf.39.1786871146355; 
 Sun, 16 Aug 2026 02:05:46 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1f90sm21758169f8f.18.2026.08.16.02.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 02:05:45 -0700 (PDT)
Message-ID: <701c7946-1396-447b-8fff-2e17fdf5bfcc@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 11:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/18] accel/tcg: Drop fault_size from user-only
 probe_access_internal
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260815203730.1468365-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jlDPbPvNMdqelJxuwNTOj53SUjbLoe9g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDA2NiBTYWx0ZWRfX0FNX442yKZp/
 m77nKXG4MGZAVLlCW6YbbXee/BSY40LDG57DR25o79l9CRRY2o79XbgsKxATjWJP1uvxgx4WBgi
 u6Cw0UIBWaV4F0dOEiFof/evcAUtCQTjaiO2j6N0faJBoOFaytvfBkWzjvQxSj/qpuo3yCoejuK
 5W5rU16lrayZdGEelol61uYB/zzqEHF0LfrBKO+eWLS0GVWiFZ/7AzI6aU75LMCzB6qu/O/KpwB
 ja44RCY03neVaVH8q1OOEAQH58S2Ng1QORygsacZCvllmSpd3yn6O7ELtiv9cDFnttBYBBGrEil
 1ZeBKYd59TL//mMWBOIkhycZDC2o7GCrCJo9W5MLs2rSqn6wwWfbH9tjWDgLTTCwKLMc+46P8eF
 BI+a9pyqYTAf1AB5lQrHO8lLrZatZE270qR+05hB2iDPK5jSckDTm6NKXyx7W0JL50/SPnD+td8
 0r35uz5LiwLh5VVYu/A==
X-Proofpoint-GUID: jlDPbPvNMdqelJxuwNTOj53SUjbLoe9g
X-Authority-Analysis: v=2.4 cv=DdknbPtW c=1 sm=1 tr=0 ts=6a817d6b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDA2NiBTYWx0ZWRfXx28hsa9qYm0H
 iD4j0tYGn3gRrDTpuAQ1XxgZSqSaLqm64WXZ65o8PX8MboqSQcRxIX6wQKh6POVFYksIZw7TkVO
 vPl74NiN7go52XZs9xEZP9hRlvc9Zx4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608160066
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

On 15/8/26 22:37, Richard Henderson wrote:
> This argument is unused.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/user-exec.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

