Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2600AF428C0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 18:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD55Y-00046I-9K; Wed, 15 Apr 2026 14:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD55V-00045W-Oj
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 14:35:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD55T-0005p0-Kh
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 14:35:44 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FIZdhF2772748
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tk1k25mHTbUInJoMAgeea6AeksT7eR/9x0TO95VDOQk=; b=Y62cNxw1QqwuHDy+
 Kd2bwmv+TcLm9lXI+LNjDqF8Y03FrtiN/9R4Nk6uF3hrRn9XjCabE6BNdfEBJhSw
 s4wAq/hEqPR9Acg9jMVBCkPlIkwZu2u1OJ22RAPXWFaLsib+G96ASF3J8uvqgidZ
 IygkMTLUi81PD0Gqekpg0Y5Y6VlcmhYx7QfqlumCVahXEeC/yQ65oQmHiAY8KNTf
 qO/EOHIViPe9wPB0uY5VOGZDUeoXAheaAy6klFEBMJqmFd0fqPFtkzNs14hXQBg8
 pcTrC47Ut2xpkNKkdkGlrxrT5RGEV+rHGGGvFNBHjnJBLUHULOkF8MK7TcHQaSwz
 iFYozQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj50v2r14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:35:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2da19227bc1so12257801eec.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776278141; x=1776882941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tk1k25mHTbUInJoMAgeea6AeksT7eR/9x0TO95VDOQk=;
 b=gwaRRrGoFi8GBKS97vJsPZA9ToRURXWY1TqQ2/SK896nPjyhwozXx3SfKKNX+NzIsP
 MPTUcR8aL5GrUFDlMteOUyKcay0cpnZnq8zKzeriB9lOScrkXd12WVK7BoRs7BI3Auqx
 lbScDrj5kMPIfE01l/E/JHu1cWc7W8oLwTp1nMW7sUlQvQNBEzPSqdeOEaW1S9E8h7Hs
 trCRpAqBc2SqtDFZ1M/qPMu+ZyJtn7hQO/yie3SG3z4c5TY/LzIkha3tjSnfxesHx3HK
 q5vY7TjA+hnd8sACJOG9ab5/gERwThvXhOJ6rXqRWikLl/WbxF75tidCCom1VqOmT4UB
 MlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776278141; x=1776882941;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tk1k25mHTbUInJoMAgeea6AeksT7eR/9x0TO95VDOQk=;
 b=EDJ5cx+eYRUQxUC67tEAfk66W3Vj/AcmRkRi49W7IxHqFEiJ8F8hr5vUOkPborrYz0
 jbMyJ85i72slzzqmexKY9HqOkU28AR8gC2T8xCNgcRcc0140GT9czNozdzZG/3JTPlf2
 fXvnpLzzz+zhlDNEf45T32iIk0Hn0QWiue/oW56TFcpSnDpcRO0BS3OeKKB15myr17sY
 L429PpBMB6h4nd3lwGacJdMPT8+dWn/yJgg5m50+wKLlb9xJkRnnL/HBRqdxNX52OkTq
 nNc3jgAJlwxflHm4qE8Chw7TK4dMwt1eVAsTyDaI8DqZhYwHtACBaWdGNaEcXnDrHkV+
 RZeA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yKNOmf6TOcV83dUFBW3Z66wzX9B9qoJ79GpDfjfPipMwsXEl7rmRL18kjFdRtWsi6NtIt4s79m6oH@nongnu.org
X-Gm-Message-State: AOJu0Yx+nu+SDSpKP0mX6dVnheUB9268Ttk/qwm59Qn3QrrlvtjFwx+N
 gioEku8HlwOd3mqdID2xRG7XWZEJ8bBMOcAvJKEO91Tq4uIvbb8irARdpCrDO3Tc7ASOEwDdQ4p
 qrn5zsNfFHd8StjPeGkMRQmYtEZdzOL8p57OT63FSHytOQIk97FrWDA94ZQ==
X-Gm-Gg: AeBDievgOJxOIP1sIRe83oAxbiZW1wp1M4fLKOXelsIKexst2XSV+WFmpHZ7A3SVpm2
 duzZrNQIgF/YQeuS3iK4IeOWqAnYsZ0P7TgcfINAzSgGJz7nRkeNfh45PSMfQx2+ZaQrjrwmZu7
 FX5+zSR/CrmAcf3mM575rxpUX+ZO2YEEEcq9hKUTJxp2ok3++8wQDoUOA1WryQgQqB7U1ecbe4I
 uAT+2N7oQUIaWHYbfrPK3vT9CeKAij3TMrWayAJt2vDFtF+LbxbHOM6RLdTn8NJBPwPQvPTNUdh
 rGayFDuHZWliFSQr38aLg5yFruh2i2KAjIo7jM04t9Y6fj96JB8Ix2cwdabDF7QEK933Cf9hx+G
 6HyGliAJYFmOaFCsnaLZkxqxVCWx4Y5WrrzsFo3pgzVOckWxujLZXlt8otLwbCXlutcccTl9Z6B
 ihuCJchfuOvQ==
X-Received: by 2002:a05:7300:7b86:b0:2d4:62f0:b2d4 with SMTP id
 5a478bee46e88-2d586ea98e8mr15128287eec.13.1776278141014; 
 Wed, 15 Apr 2026 11:35:41 -0700 (PDT)
X-Received: by 2002:a05:7300:7b86:b0:2d4:62f0:b2d4 with SMTP id
 5a478bee46e88-2d586ea98e8mr15128256eec.13.1776278140369; 
 Wed, 15 Apr 2026 11:35:40 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a688sm5155561eec.4.2026.04.15.11.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 11:35:39 -0700 (PDT)
Message-ID: <ef7f7c12-0dc5-4c03-a402-eb1570de0bff@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:35:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/arm/smmuv3: Avoid including CONFIG_DEVICES in
 hw/ header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260410200031.18572-1-philmd@linaro.org>
 <20260410200031.18572-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260410200031.18572-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iY9c98XVOjKtfwfY-2gsPVPCzxVFYoOo
X-Authority-Analysis: v=2.4 cv=eLMjSnp1 c=1 sm=1 tr=0 ts=69dfda7d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=nq8n1J83xunWhl9p0hoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3MyBTYWx0ZWRfXy3zcnoKMq9HD
 3rTL8GW9UTJNPpOjUwpAFzooKPY4D9no7g9yIeRF57HJjmhLYPi0Qh0m+W2kOgqSEg99MBmr2uA
 l8H53xyxPS7KxW2VGGNPLA4xcFpsKd7RQwP9KZAstumPhtbTezJpduAOYafFojPT73HG6BmyZpO
 CYlkKISBJA8LZI6s+FoMLeQVw6d/It0JG+ZXFLdM9kNAIIDLremAOtSB3Nw4tPwFNpL3MCHF7Lj
 pPdaOzfVweqQQ2nYz5fr3+ynFi/qrS2TeohD6pryl/AZtuyJDt+vBXFI0eML5TKSh/ueA0igLYF
 f0tsFB0yBwpqbYXIP4LIWD/DQfL/vFUw7ovWTvBl/C+UBx4zy1hdj7NNnFlRaA9avb5NdTf1j4E
 Trx+nC2DXOdt7Ln5B8yoXJryEugR+dA4qtjrVEGnu6qshOOjjafBva+xFQqEiIMbx96X406B4WI
 3STTUaJ+fJ5anzkLL/w==
X-Proofpoint-ORIG-GUID: iY9c98XVOjKtfwfY-2gsPVPCzxVFYoOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150173
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 4/10/2026 1:00 PM, Philippe Mathieu-Daudé wrote:
> By turning the inline functions into stubs we can avoid the
> use of target-specific CONFIG_DEVICES include in a hw/ header,
> allowing to build the source files including it as common objects.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/arm/smmuv3-accel.h       | 42 ------------------------------
>   hw/arm/smmuv3-accel-stubs.c | 52 +++++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build          |  5 ++--
>   3 files changed, 55 insertions(+), 44 deletions(-)
>   create mode 100644 hw/arm/smmuv3-accel-stubs.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

