Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07432CD98F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waA8K-0007D8-ED; Thu, 18 Jun 2026 06:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waA8F-0007Be-8Z
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:38:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waA8D-0000Lh-MQ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:37:58 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I8Djng667650
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r+FQEDeKjztwcptyMEXTTRUrL4AKFzXo1TYjT98eECo=; b=otdYE1EnfvkD/DAm
 Mhpq5ngx1fvUxS1NdSuhzQdTAIs8I44wNDenzCduh80/fmNmHXkmepIGmTuuq+zu
 DPALBSsz1hdJm4LexJVS+l5KNNIgh0ASr1o5YAWrTsE7nxImxAhNipEWG87gBnzs
 EdVBEvpgW6I+CE0H5ZBdxOSgOChap+1o/2JibZs3d5cHcS77PR+hbxn68G3aIbB7
 N8sjUoiPCn4pbGbVfhGPqMP7QH3ejvsmxn5JgGQGkdZJzkFYfULFDYPNBawuU2Xy
 0N7LWKjd3YWzi6OhCk5YGGG9WAiOd2GA80bUrLMCgKM/IfripYNiVaa+gCufO5XY
 rKCb+g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vm31q7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:37:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915c1997732so197237985a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781779074; x=1782383874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r+FQEDeKjztwcptyMEXTTRUrL4AKFzXo1TYjT98eECo=;
 b=eFp+NZhj44YiK/PqATybxfwwY8tzw+iSLPvyVRpNbUoW0gL+685DTVO5uxcP51rrx6
 TOzNIQ7tieyT9nOLqD4pikp0zrxZQ6wSXzxku7FPE9N1psO5FHOcNarXuSzYOfC1FQCB
 0ud2U3JAY6yyoWZyMVuJk8pMAFANadf7CF7mUI7gh9Gxn+RlALo8cawu8UEIuqKFITB4
 dMPj8OtgMrgsaQvN6Ffuv6gGW+T6PbfbBurcMx1CLKBAzVRZyKOVfdn5CJPSJzeNtCHc
 2M/NvM7DK0g+lDTXI88Z5iyuUSi2vS+phaozds0v4CaDWqVGo1f3QBVVNNm6fAcPtUEW
 qy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779074; x=1782383874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r+FQEDeKjztwcptyMEXTTRUrL4AKFzXo1TYjT98eECo=;
 b=TP0Qq2FPULs98fQuxXmp5TuLOQxJxV/lijOn2zvtK3CFO5cb+ISllixM91SUHcjDax
 WVxYNCJQW4MvvIM+P2sCuYtk2rD8CAT7JUgRiPisvZZKYlmLN6ZP4obJJjoyYjqsMDgO
 ArF3xNzWx2W8Xu6YvUj0wGRUxBI3RV+qPrVeecv+yEuNu3lJMUFa0zzzXy+j4xPnj+Uc
 y790OT9pTrS59uDNXz+0338OeIUKyF6LV3jesF6xf0xYkaZ1/kIcvgNDnte/FuVa2/rH
 YccuEQ/Ap1eUOJX6FzY9pd2u4zkd49mETXKBr5MMIZpCK5NSVuT4D+jhZSlJP2SRImeo
 Tmmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bV+PC6Ri/dbyMC154eAGy4khVvUd0NMM+DFGLKwgoN7Qd0Xf3Im5sRsdjszp6APhmotH8JRUl2HLU@nongnu.org
X-Gm-Message-State: AOJu0YyGXfmOto/AvBqNcQ2VFrYVfKG3d10EiJY+z4pWiq5MCc6wCXku
 Ulis5E3ujgrqJuoClWMEIGBw6QizSqWsbotNwpKQVyphq0upPRXQUp0JzLKuNl+WZxecZpPRoJN
 5yq2b2swrzhwiMDuGa7NksXMGUBok5NWqVloAwLnWEnA1Im/tIgAhx5QHFA==
X-Gm-Gg: AfdE7clRenR4AXPu/HBziE+XE2f90jyow31TsdejXMlKE/PH/QoFYNX85B0vGgRN9TK
 +YqkuBMyRABUv//7+1x78NXJMtmtpIDr9nnagKiLfhUF8cPZ48xzn8mMpRAms7s/QKk+WHCLlR1
 DRmxbhINs9td6sgyHOWqMzS2PDqA8BlbS23GFwCMIgAASSV+D3PVT9+i+K+pm1k/C6k8C/mcacM
 WikfoN1Ve2zoQBhZp2StZEJq1dtx6OXUtZ8CDVdFw6abbqPmsNzLDNvloy1rjOLhMqqlhz/UpDU
 pe4ExCIGRPDKWI7tdKFlp6eVsBo1fSNBzfFsIAvZFOjnox5Q8frNdL0ylQLOTYAAv4CUJjJhEtx
 Lv65yEZS49ouTFgVPphGA9+va6goJ+rZDeW/xieEVwFWbZOQQl/eecS9po0LVdw==
X-Received: by 2002:a05:620a:4056:b0:916:16d8:6319 with SMTP id
 af79cd13be357-91d8e5a1b74mr1346339885a.53.1781779073966; 
 Thu, 18 Jun 2026 03:37:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4056:b0:916:16d8:6319 with SMTP id
 af79cd13be357-91d8e5a1b74mr1346337085a.53.1781779073518; 
 Thu, 18 Jun 2026 03:37:53 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa3a8efsm228659935e9.2.2026.06.18.03.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:37:52 -0700 (PDT)
Message-ID: <d8ff8634-80fe-42fa-954c-51494419802f@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 12:37:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/tcg: Restrict IOMMU declarations
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260616153633.93267-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260616153633.93267-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfX6HJokvyeqALl
 QzI8uhn/kBEQN+eiatTRoRcZ464Adbz4AMHOEMmsDxITprY32LL41VubFurqgxibl4PWyeaQM+i
 pP1fKuRfwwQuVdRB1vKQjbDVw9MA0zuNF0h0EWRX42SBPWDltjWb1bKEcl2YnfDE7fguqAnjO/w
 hTu5NfpYqy7Zo2rlUPOjdQzfbKhUqJcR23s0OSzLB5kY8u5yxPCvXKtoK6LFggtMQMaGeMaMi+t
 FXbAAYti/ct8u3s4EKhFVcsnCy6QW93vqk+kbQTtoS5OhV7UJMOt6JdMV/NwjyhFym7mBkxDOlE
 lK5j0YMtvBedgK5HGbU2+x/XG6szP4tlW27euwwj53kFZLOq9vLMXV8DOWg+/ytyT4urIokGjcI
 nYi9RFRdYvbeVAtsTduRIMSht1P0UdwgthBzuyBl5FmT18FDDdkkvknXWLGD7Z68yvMTiZbFshM
 vCVVweANwRH3kyNO85Q==
X-Proofpoint-ORIG-GUID: j35-Cio0Jkeb6dHzpD-9vqlh811OprvG
X-Authority-Analysis: v=2.4 cv=UrRT8ewB c=1 sm=1 tr=0 ts=6a33ca82 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=209pFy6FlnFkDuPbtgoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: j35-Cio0Jkeb6dHzpD-9vqlh811OprvG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfXxrbDcrJthK83
 6UJTF3NZqRAdtLZyQPzuFVZNECsl42j+EcHMKbAPvztXIYbxtA/ZicJQ87RxC2blpKAKyegRlqN
 XsK5gXt8bQXsaVOpndFXs6yDZH3WPN4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180098
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

On 16/6/26 17:36, Philippe Mathieu-DaudÃ© wrote:
> Move the two TCG-specific IOMMU method declarations from the
> generic "exec/cpu-common.h" header to "accel/tcg/iommu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/iommu.h | 7 +++++++
>   include/exec/cpu-common.h | 3 ---
>   accel/tcg/cpu-exec.c      | 4 +++-
>   3 files changed, 10 insertions(+), 4 deletions(-)

Queued, thanks.


