Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A273C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfUD6-0005k7-3X; Thu, 02 Jul 2026 23:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfUD2-0005jj-PF
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 23:04:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfUD0-0004Wh-QX
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 23:04:56 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6632rMIj2505021
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 03:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v1lhVfM/300NTlXe/6sdbliDaxbAiPLGf0cogvRfTec=; b=TsHCIvirlNK33Bm0
 lQ3e5A653xYvLltTUn3ucpoyLN7+Knbt8vG7T6Jo+pK85E+RIk/o2uzlIqzXpBof
 GgLaOXdlI02GIq8krhZzsMZOj9I24gv5GMff6HKA0wR29gsyFXxDaIeoV4z43UPe
 mLgcfeOKo+paOhXLxhbomG7yn/MgLvgapi2qWyWsvSiM2bVW3ZMBOAPYV0CntwjR
 GNbRsTTobxzmeP5oCURbZSU1U/OfzQisw8A+C5x1B2baKZVfG0L9WuBIiLCd3CX0
 UctEQiV59+lTfjzcc2Tc//FDHrzjZ9TipiVzMhS8SIA2TLv+Ka4X+2hqtEyVnpGn
 nvddCw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n0403-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:04:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so11840285a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 20:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783047892; x=1783652692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v1lhVfM/300NTlXe/6sdbliDaxbAiPLGf0cogvRfTec=;
 b=PVSdVjy6n5Jx4U+yMSZ56l7IKTwBDLsGinLCSIe742ev5Ge7mJ7SUhimHbEg3eXnLw
 71tPsnV7v94Z990eQCmIbCmP5ZvXuDJFXSmBXjLmgrjg3QWNZS2Hd1UJsFRSFGNSYg+J
 iwbDgqnu9MbuqoX+eG+fEG5o32CxYv90MKpsysa0jSN4PVlGbRNuwYvJI/DVn/daWjWz
 B9gN4uPqh7SfaMx7k+Nu4yVjoCMNjcJ5NBwKkaUnAQ6I0CbNNUkCzEp7LTRuHrHv8I40
 S738xL1TLf0VcXWcvvLvexgPdDHtKOvtHCkhwDizI9AoB/Jt8hS7gRG3HxU9t5xrBi+i
 K/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047892; x=1783652692;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v1lhVfM/300NTlXe/6sdbliDaxbAiPLGf0cogvRfTec=;
 b=gIV7/rtrUEkOyKigbAM83Uts99fTN/t3qlIvEE9qNLgldmUCaXRkAFnQoVO5nz3hl0
 ait6ufRXoqiXfVvV58LeJKWBhoWIkS5jTSLbSRLHspUCJCtG5jn1OptJm63sQFSmRTE3
 7c/mWTCFqv547O3cxzUUvjUlTZcPRDDZ6U2FuKwIQyhg0WkmR3eWZ14H8F2c7t8IoscR
 Ye/C3NpMutCbrr1t+5J7aVhhgrTPq0R3FQ/DO+VaVzHU4FjQBRzI1Hc2tQjCDxibXS0F
 yuM7Ms0R+kFBzrsrX6fDplYavShb9dFUykLpn5sCHkOe4r+p2ReiJ2kVcSA+MkbkOkfe
 zS2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/29UA8G/yvqVmAOFUgS2DXlo7FmkSIDxJfMn61ACJXSyCPWXLw38c6Gnotk4zD6eE0C2Sa05F7kOoT@nongnu.org
X-Gm-Message-State: AOJu0YyJF0Ah1yT0eoOV1Rh7XfEi+kLoIQKOSqbd/8Z7NsLLOrVZogH5
 6aW/Fs9nBNJSCmg8CU/jADY9K8qcU7KDeoDTCVcYhYyhQTBO6RS2Rpjvlynzrdcf6uXdaOKY1lc
 nR/5sjptlJ4grKRHzYOqCUJv70FNpijKUAo7Tixy8mRiAq2D+TCNZxh8jgw==
X-Gm-Gg: AfdE7clGEcJrll+P+hGDLSrblDFrfAbhx50Qjnmxk70SYrvqXiF4TiPsMgI1KdMnLzG
 9w5j1BCwI0YH8hkw9JxE6baZhkKkMXzuesW0hO0lmbNyPGo1Zc96eBWWupZyV/AQW/9SaOiEZYy
 8mu5xu73Kx+53wQU6vSEtNicRChTZRF4LbPzIdqcJBAxIFJ3i0lqVevX8zv/2Rxfbad7i0d3+5v
 tgXn79YxRLq3N7+BfnmjpKp+ZLpEVR4QSripOMprWOlUd/nQJbsJnfPKD4jKltM9IelNYkAW7Td
 C4A/uLL3YFGbTnhIXR8OwID+dRg4dFH2jT/9m1ESQ2uzSBOMjLN8WVpe1xDJhbkG/AQxC+li0hb
 mPXEYH6ZkQrYzYR2jV+yTlquGEnVhlHuVdK5oYJqZOt2t68S9WQujWRjwhg+PlQ==
X-Received: by 2002:a05:620a:271a:b0:91e:712d:f79d with SMTP id
 af79cd13be357-92e8b5b2815mr274385185a.40.1783047891957; 
 Thu, 02 Jul 2026 20:04:51 -0700 (PDT)
X-Received: by 2002:a05:620a:271a:b0:91e:712d:f79d with SMTP id
 af79cd13be357-92e8b5b2815mr274382285a.40.1783047891522; 
 Thu, 02 Jul 2026 20:04:51 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477d766e0b4sm13444082f8f.0.2026.07.02.20.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 20:04:50 -0700 (PDT)
Message-ID: <a558d31d-84ba-484c-80d5-c4a9e295ff5c@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 05:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/24] target/riscv: move some irq helpers to cpu.c
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-14-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260702135128.1188021-14-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyNiBTYWx0ZWRfX3kSbbRBldXgz
 k7g053qbcmsfpoK3aOe7+XkCJg4YQR9guSMNQXAlmF2jIcI8CjeoerslLEdebrxMbCNw1l2xELX
 JqK+W7xlYf0eEMZ/Ag8sk+aq0pksATQ=
X-Proofpoint-ORIG-GUID: u91fRSGBDAE936aP6QLNdQVtodrDHZeD
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a4726d4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=_IOKp0FnopO0b47MFCYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: u91fRSGBDAE936aP6QLNdQVtodrDHZeD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyNiBTYWx0ZWRfX3BzhgtjVn4a/
 QX50JY9cSDZdAI94aLb1b3sQ239wwjLzkc0AESkGI5+CFcTTn0fJGM6qUeprgUJq0OEl7rwmS8M
 BA9RadHcBWTZk2BMl9XM3qYKKSjEmOoO9Mp+vvPo40SIhGlnymyl4vbZ6QQfZ3gLq3kl311X4Fk
 AzVryDnNyovW3n+PYCvq8AUrH+GKCFqDLVJ7DskuYDjny4HjCVy8DWoX38vKrX9qMqrsxAgB/XC
 bXWQzOkjmW2j77bhnLOgV3dtUghpARhQ12qwRkFoIZhNzeSSZmxFwJccGu4LFyaefBB4j6SK2uC
 7QBcO3XqIw4Y6hXXAM944J0Umj7OCppzYshmaZrAFIvLv/6TPD8LvRtR32rMjI537cMzaE2QPWu
 JqU3aZmqNc9o6K9hkS3SzNbIG/WsiE7Cq4axBQ/0ugTID9r4BcYqnsTyVeGIbqS+RcPnQj6I1wq
 Od8tvyAP2pIOuyuRxiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030026
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

+Peter, Paolo, Richard

On 2/7/26 15:51, Daniel Henrique Barboza wrote:
> riscv_cpu_has_work() uses a handful of irq pending functions from
> cpu_helper.c.  There is a very high possibility that KVM doesn't need
> the current implermentation of has_work(), but the common accel code
> needs an implementation of this callback (see cpu_exec_class_post_init)
> otherwise the KVM driver won't initialize.

See commits 408b2b3d9df ("accel/tcg: Make TCGCPUOps::cpu_exec_halt
return bool for whether to halt") and  0487c631801 ("accel/tcg: Make
TCGCPUOps::cpu_exec_halt mandatory").

Looking at cpu_thread_is_idle(), TCG could register its 
AccelOpsClass::cpu_thread_is_idle handler as !cpu_exec_halt, allowing
to restrict cpu_has_work() to TCG?

> Move the relevant irq helpers to cpu.c to allow KVM to keep using the
> current has_work implementation, allowing --disable-tcg to work.  We'll
> circle it back to evaluate a proper KVM implementation for it in a later
> date.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.c            | 187 ++++++++++++++++++++++++++++++++++
>   target/riscv/cpu.h            |   5 +
>   target/riscv/tcg/cpu_helper.c | 187 ----------------------------------
>   3 files changed, 192 insertions(+), 187 deletions(-)


