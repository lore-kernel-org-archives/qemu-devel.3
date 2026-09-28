Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A4DC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB81Z-0005u2-18; Mon, 28 Sep 2026 05:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB81X-0005oZ-PC
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:51:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB81V-00083Q-FD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:51:51 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MDqe322684
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kbqGKE7IymnKy3AGPJcXaahz7cXKiHNmsPTM/HEX/Ug=; b=FD1tepX7/nFy4XmT
 HiOZXG0BpbcossVgUutUro8vUmgiExOk4Nl7IfPH+QchM+qv+dpRMmkMWbbxZ3tK
 MWVXGuGBG9JL5vHhEl7ZvYnTVAoOQd2eoCrHsamPstaeSdG/yNvHQHqwP2bqGX61
 Vdk+Y4UgAtKPc6EZ++lgvmruUM3HX3t2BvhxLkX+ovAtEfN1m3kffekMcqpa+xG9
 0RjeJAGhmNNhQDSKx8bab1MnZaoNotcTLQG90c0O2KCStx6y/aWzDLxbVgBuETsa
 Sq3oSMCvaMtRLzessAXRuV5BH+BxEHyX7456IrfiFpBSieQmFuj8TNJW53K764a4
 eZNXew==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq1jv3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:51:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c444b438aso627154685a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589107; x=1791193907; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kbqGKE7IymnKy3AGPJcXaahz7cXKiHNmsPTM/HEX/Ug=;
 b=VHp2QcvCEPLG+h3865a3Sc8cbSXS7vINDyHaJVqBm0dD5XMDDXefQ/Xrg02nKCeC+z
 5C98MS8ThOKXs2CyatW/22yH3UMcLCajaBuX1kWYTys6QRvG/mv9kGPdq4i/BRksLpm9
 tNC6A8MIMpjC4fAmbnXhF0ip4APVMn3Ox5GkM9CZsiPOyMsk70z52p6NTvuBBvM+ZkN0
 VxmyciQeSEqWFwX3LbtnSkGBD51J2vgRP3E1uVhsF+F5s0MiZ/r80GOn1hV8XsfNrSfg
 hwxHTKZ60HgmH/ACXL1HQbRNiC5NZqGoK1ovkPifVuDOZMzC4WTRhTBP0uocvm8OBbe7
 HtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589107; x=1791193907;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kbqGKE7IymnKy3AGPJcXaahz7cXKiHNmsPTM/HEX/Ug=;
 b=cFbCYa28Sviq/sbp1+B0ffetVUCE6dK5+CnhgRup9W41PTTdb61WSEt8VFPKbhY2rv
 JjESQDMjotChciPkRKi132jnoaCHdkIYwOizH69tPT+AGPgFFQ+bKboPX0C1T4xX4toF
 dLXedrSvV85TXavwYcedDwlXx+N3E3SnXB1g30I9Guaow4aEhTQk3VEWr0Au1N/EJduK
 qkScYoND4ScZxyffDakypMHqxSXwhDRNUwHu3ILKspXTTzd0VR/S3PnlWhcheW+GwT67
 H880uoH3UQoPDyMwJojZYjtM2qG6HvTKyShksqJu1PyL6DRulhz2Sr/UTSjmXGf8YFJ2
 dIUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5cjjBlApsmCB+kqyZeM0y1rcVjp13rsa+IsXGmcgguzzLcdQlkfElw7gAsHwu5w+AGGyWkhVR+EjW@nongnu.org
X-Gm-Message-State: AFuF++kSMeMdN0g9RBH9Muj9FDk1mGyDXcsSExXSeFIOYKD/OuAwgGIj
 VwQ7HQ++mku50TlFqNbcog2F959XzQ4SJM0m/0oh9Ji1/h3jVRempwHF3tvggqHConLOjqzXfms
 6yltv+34CwvddLe5U47LVIUFDPGWaT/rkqx65ndJw4rh29togiRAPNcvE6g==
X-Gm-Gg: AYBFou07X3Gmv1XktmykocftVet7tG7SUkQRv20fjxc97ibt4G9b1melHnpVofy9/Lp
 9FxExq8Hj0+ZujFv6p+OWpUvb5q457wyTlpK3GKi+X/Tc1ofQWuG2I/rAKy1hKD2CQMTR05Nd30
 85ybaKHmDZZGlTjvG0lq+PSBc+/BaK6qohyZUkk6c2H3fM1dd17CQkRGpztOksZYkCZiqWRREyX
 Qs5Ljt7YWU3c77sV/UtFvKrM05QvyOO78bh6YVuhG0t9d0BpZbrvNOfzcDCiJ0xgDI7FjRmNTd+
 Oshv0b+7PJstpknJ9Ee6vSHWnUXm07QTSNCaHorkD/TCYqxeRqvzmAXVTxaGJ1UgJjSlQS03eUp
 Aj3T1AJNxuGWdkiYd53ie61BXGBy7HnME1g==
X-Received: by 2002:a05:620a:2628:b0:93b:beb3:5898 with SMTP id
 af79cd13be357-93c43ce7bfcmr1910137485a.49.1790589106692; 
 Mon, 28 Sep 2026 02:51:46 -0700 (PDT)
X-Received: by 2002:a05:620a:2628:b0:93b:beb3:5898 with SMTP id
 af79cd13be357-93c43ce7bfcmr1910135285a.49.1790589106208; 
 Mon, 28 Sep 2026 02:51:46 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a001906c5esm129209175e9.12.2026.09.28.02.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:51:45 -0700 (PDT)
Message-ID: <166b9574-72ff-4d24-824c-1355dece3ffe@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 040/101] tcg: Generic expansion of tcg_gen_nand_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-41-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-41-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: K9tBz8TYj4x9vNsMLlO86PEno0g_wkB6
X-Proofpoint-GUID: K9tBz8TYj4x9vNsMLlO86PEno0g_wkB6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX6LqC8Fw0pxqT
 PYUpnocxaELUz602kprcaK2rh3CpTbfEDlXo/d2FOlocaYY7aUeBRkBwKSda28H6JAcQEef/Ijn
 pqZRRfxYWQ8vTV5AusYzjsubPF5GTFQ=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba38b3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfXzK7iNWHxgJkq
 sqCmieYxWw1aZ4BdxTj9/vCG+35Xi6EydGeXV6CHpBdtqpAdJwdOMHXA7Bzh9T3YQr/P9MTMajH
 Hr3c0M+AeLAbT7W0uOPMDiNL05LTvGoAAROKSikS2iwr1PWEDixIJOLSEXC/rww4N1eYVeiver4
 aLcp7TKzB9+323gI0YYgdISvbHzU4QocRgn8Y85Ltv4ce/hWDPPVBTxoR9rdsk7pb+lLVtrRX5Q
 UIqDeqViWGnPWEG/noe2GpXZ2sIwTp8Ci5gzwnX0igGLGp18VWkIao1IsKhXJIF5btuPh1nS9tM
 zhpFc04BvcTahhrCnK9WRisY7UBywDbQPsuHQ6Vx2E0w1quzXEkKQ+tvFsZ6MW2AdZdi6+cr/4J
 zaGe4sY4nXI4wHZnGwpAEs+4A9/uiB4y7ciZnWT/SgQsvZflkWooP6cp9nLo35mhoz5mhEQOs/a
 KQZDEykUhOAVABU3pvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280039
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 30 ++++++++++--------------------
>   3 files changed, 11 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

