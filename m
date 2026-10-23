Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D31606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XyPjWMoI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YtwwvR7I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHMM-0002GP-3y; Fri, 23 Oct 2026 11:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHMK-0002Fa-2j
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:39:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHMG-0006ak-SD
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:39:07 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5wCL4063428
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 15:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xh9WkvANXHp34qa4XV8+8FU/JqDCw8UnZbR7UZyEHow=; b=XyPjWMoICStwrlY2
 nSMB+fsPqjJZYZCe8ZegJ8qyXPSvDHNQ9+no1EeY0iuUMbYYoGDfkY++Bf0JCu4J
 9tVbIqLcsLEhLRZFhWUi2h/0HqfBWlB8YBsQybTW76qdqvBGqPRt47SFyKWRXF60
 9gpBLen8a4ja+VoGdQYMTWYbFqqy4fZ4So15vC+sao9ATqR0YWfgi3bmwIQBP2kZ
 Dcz0Qm45KHMRRHPhkG/k1uvgtXYE0II4dclA3Cr3LxIYtq7fwflYHR1NqL3J4DnG
 1sSxqM9ONQ0849Ap68ZZiKuhh/lgAek2iakYxVrPbIhZnfKSlkmeV4HwwdDW+nWL
 ej/pDA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrcbhd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 15:38:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f1e62510cso251447485a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769931; x=1793374731; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xh9WkvANXHp34qa4XV8+8FU/JqDCw8UnZbR7UZyEHow=;
 b=YtwwvR7IfRbBZ1LBtyvudpLZCXC3wPKasc+qf8lA4SSa/0KP4G5g1DqAz3eiCdOoYp
 E/RMXd2co50OdhAPub65bqEU70cuuk3UJNGowwtpb7K1U3d+A4oMCK/sVYILdsU1iM7w
 sb16qyZIeLN0VcNNQlp29WhFSVMdclr2Eaq+Bbmduz6ryOGDahW9IPoPH4+4YPHU5gKM
 cA/+GMLTQhdn0CusaiRWPPlp3GdWrGfdL7JZE+IYN0AgkLvAi9Xeh1yfdjj7HrDiss+4
 91RsrskAQSAlKEke9/C5XV8F44AWCtzzdnGalYJOQr/G/krECTpuuH0wmxuWYjDEIS2+
 swyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769931; x=1793374731;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xh9WkvANXHp34qa4XV8+8FU/JqDCw8UnZbR7UZyEHow=;
 b=hBfnnzLpvizYcywqLQfRso4NMm3/F55wAUPtpWHWzyGtoD+kiS0Qe5I7y5ysnuqROv
 /c59eyA68wLw5/kVeRfcrZxCmt6PEFflVrNHj9rK0X0HTEvUpsW28WjARbxJfPBAZouK
 V4f+u19tPM9Qj+/9mQSWl3L8fsjbl7THQPkTNsd3MACi/ZX7+xpft5RHY7urpd/SpxmJ
 anpl8Hm/oZPLf5D/KHnRIVnBhx6m77QbKothAKhTyvzXBtrAsatSn54RkZ5NuwfLFbJ4
 hT5RZNC1gPq6Yr1KxEqPYAdU7j5ObKA3dJx7axFb5M60BpRVYsTrtxF8o1wIyFKqwW3h
 BoWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6XUa/4cSgcVYqZd81TWCRXbb468vCViycM0izIKRWoFXopgZlnXulsbG5hyJhl3OdVsV2EvfIV/tf@nongnu.org
X-Gm-Message-State: AFq9FYLEQj4zbst0qHCk2rLd5kAXsAmqAvGXqefppgw8K251Vh6GL8PS
 NowBVkj5MvzsKwicmFWWgS5z0zuJNw3z5XtJRXl1jTPHSM3kwusTERZAt7IMDVy9QMsTw658y+q
 SFCu/bte1Bb4+mieHz6gR9IOJRT0TKhJ//8pdpg1A5V9Bxrc15iu8hB5p5Q==
X-Gm-Gg: AYBFou07W942x3BL+R7Nt2fyp1Ec/acuprq9uzUMM7wJEhI7mAG9y26yhk2XVmsusCh
 X67vA2zFqKtM+94Qi+KCUKeYpyYOUXnVMG6UPX9f6KQvhDDQtc0x/1nqJvOIuWH53kyAdzRiy6H
 aCEn7S6Yci69UqFgOUz7E/fdBKE9ROhm8sFeXn/zYXEZce2a3bRQ4Uop1s2zegOy2A/k08d5So2
 eneJGv0ONQ3XvHyNlYoBgisxdqzHWlVqoISLLaoRhLgkvjrVZ4NyrX6qh4OwA/3FL580BvY6i2v
 ijnMGFOCwLoEIXeKRypR+H4KdDCIpkkbogr80OZ7j39prTnDCo7MrVI+MIN7b4AdJoaT3nSENAC
 jv46E+eEBlgppBr3OGA2aSqtsdjUaREtG4g==
X-Received: by 2002:a05:620a:4548:b0:93f:567b:6157 with SMTP id
 af79cd13be357-93f6f7cd876mr459500085a.46.1792769930757; 
 Fri, 23 Oct 2026 08:38:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4548:b0:93f:567b:6157 with SMTP id
 af79cd13be357-93f6f7cd876mr459493885a.46.1792769930161; 
 Fri, 23 Oct 2026 08:38:50 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d403001sm524548f8f.26.2026.10.23.08.38.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 08:38:49 -0700 (PDT)
Message-ID: <d97c3770-f02a-4d37-bbd1-ef464ad3d8f4@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:38:48 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/alpha: FPCR exception status fixes for
 IEEE-mode code
Content-Language: en-US
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20261016-alpha-fpcr-status-s-v2-0-4719bec02b3b@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016-alpha-fpcr-status-s-v2-0-4719bec02b3b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 11pHKcquhBqjW17g1rnh2Uvs26t4ZExQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX1kdsGBFFhOIB
 IDvNwzKBmQnHLmXM/1Mv+VV362vCflxjclD8wrc/x5tN2FkdBXBhjgj7F4/xT8Ngf54lKOLc+nG
 XqtX8PlVGlQwIMNz1BRQIu9uS5ggHYU=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb7f8c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=uTuyO71btrFX9dLMuX0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfXzLUzM14E+Yf4
 IDKpSe8LpmeMwMSYkLxZgWvqrD9/EXKRmjuEwQCMPz7pnyGZ7XpMMD4MpBtZrbb13vDbGqwOfej
 StYfLM4HUQDUyBxxAmLrcr5sUxNbWGb6ngAn18847LgmYIMjP2qbHaGK/+hgVsZw4DFo0IQR3eH
 ezF+mtSsxdIO0pxTe3pPIEwGR9jLgPuHXLWRBoIQy1foijPkmvxJIa3YPrp00geA0EjOHyIuVpO
 iFuID8rLbpdhFFQ8M0jxwe8Eql1pMgyV19iot7JQxghBLnvLdIiDpyYsrDWshGvGGb8kA3TEp9c
 2Itcke3zgC8gsPvlcmxNhjtZ4j4L0OPnrEPQLo0c39BUHiPcmXhvcyK6cvrC516pe1RqGyrIMnX
 fSbCaW+lV85UB1djTDl3EvXNdrn3P9BHLYJ4YG2A6BXoUizR39e9z5Q+AJLKtnFgdtBXB6FOLUs
 igVpVv9JY0OMh7YSCGg==
X-Proofpoint-ORIG-GUID: 11pHKcquhBqjW17g1rnh2Uvs26t4ZExQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230061
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/10/26 02:58, Matt Turner wrote:
> Two fixes for the exception status that qemu-alpha reports to code
> built with gcc -mieee.  I found both running glibc's math tests under
> linux-user.
> 
> Patch 1 fixes 471d493047, which was meant to record masked exceptions
> in the FPCR but had no effect for insns with software completion.
> Without it FE_INEXACT is never set for -mieee code.
> 
> Patch 2 makes underflow match the hardware for a result that rounds up
> to the smallest normal number.  Alpha raises no underflow there and
> softfloat does.
> 
> Patch 1 does not depend on patch 2.
> 
> Tested with linux-user only; system mode is untested.
> 
> glibc's math tests (make check subdirs=math), run under linux-user:
> 
>              PASS  FAIL  XFAIL
>    master    1400   110      1
>    series    1510     0      1
> 
> Nearly all of the failures on master are 'Exception "Inexact" not
> set'.  The XFAIL is test-float32x-float64-div.  On master it fails for
> missing inexact; with the series it fails only the four
> div_{upward,downward}_double cases that glibc expects to fail on
> Alpha.
> 
> The tcg-alpha-linux-user suite has six failures (float_convs,
> float_convd, float_madds and a plugin variant of each).  They fail the
> same way on master.

We need the float_* tests fixed to get this series merged, re-generate?

   93/1938 tcg+tcg-alpha-linux-user - qemu:alpha-linux-user-float_convd 
                      FAIL             0.03s   exit status 1
<   to single: f32(0x0.00000000000000000000p+0:0000000000) (UNDERFLOW 
INEXACT )
<    to int32: 0 (INEXACT )
<    to int64: 0 (INEXACT )
<   to uint32: 0 (INEXACT )
<   to uint64: 0 (INEXACT )
---
 >   to single: f32(0x0.00000000000000000000p+0:0000000000) (UNDERFLOW )
 >    to int32: 0 (OK)
 >    to int64: 0 (OK)
 >   to uint32: 0 (OK)
 >   to uint64: 0 (OK)
870,874c870,874
...
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> Changes in v2:
> - Patch 2: fold the underflow check into soft_to_fpcr_exc, which now
>    takes whether the delivered result is normal, instead of adding
>    soft_to_fpcr_exc_tiny.
> - Patch 2: check float_flag_input_denormal_used for CONFIG_USER_ONLY
>    only.
> - Link to v1: https://lore.kernel.org/qemu-devel/20261012-alpha-fpcr-status-s-v1-0-bc7efa6d5609@gmail.com
> 
> ---
> Matt Turner (2):
>        target/alpha: Record masked exceptions in FPCR for /S insns

