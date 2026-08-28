Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EBDC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzt7o-000830-6H; Fri, 28 Aug 2026 05:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzt7m-00082G-DQ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:43:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzt7k-0001lE-K3
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:43:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S66gaD3205960
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 09:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 025tpNahb9PDvkr1BjiQhy8fBQm3yFsAj1TS4aewNTY=; b=GznlEVNGsKDzo4Is
 QoZwpOcsc8ERgW5szqCWzqabm1AkGuMn1FJEFZ5j7HYC12OtxXVNEeRYMMmQTm0j
 V9Pk2/n/Ti0wr9crAUl6geBFTjV+EAPJjR7pfDSOg9W3ESdiFsGrWfzUzn9GFkGs
 F3KEUbC1zcVf81bZ7EtCU3Pn55gwIQebSHjqlne3EHpwVaBFqIdMRAjHZtXZKAw4
 2nCWZIjZUFrLpGT+5hb7Ckl6YA7+HllUEWJ5CKk8Hm3wnhIIO5yuRnk5sgtPXM7Z
 yMY04GyY9BwqmoIyaogk+T/wxt/GxLKGSFMQZgQVzE93PCLU0gaBg9lflPv+X2xX
 rmWRXw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxkde0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 09:43:45 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90cdc69a7b5so7800686d6.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787910225; x=1788515025; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=025tpNahb9PDvkr1BjiQhy8fBQm3yFsAj1TS4aewNTY=;
 b=GgBaT3q5Htk2U6Ki4DZa0T2BISpL1NhtnHr272YoJ8QpABVcAPbdgjUyU6aI7stMpF
 3MBoTJrc0YN4D1tVPImdoeQVSVGiRrp7wKOQCWheVOmZ5pHMBAkoHg/2akTY3zjIPWvT
 pggIg5hiT0V1d1sARxx8tnub0VSlg8mjTOvh+tmXRt/drbm3ocK2J40HOo8fjv7naJpy
 jbvi2gY6bfpyXunL0N/SmWJ1GlpTTjL3xwlUDdm8kuyXg2VlHIb+ED1Z5ojZYf0vmhpR
 CIcESFedAUxNtpz+wUa0ybPsIz4rizPxlWtoJ3GUipUgL7es/8/9cMe218q9MYAkpfcZ
 Qjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787910225; x=1788515025;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=025tpNahb9PDvkr1BjiQhy8fBQm3yFsAj1TS4aewNTY=;
 b=grpwlOgBHoEoawcZ6rCNjhqWTdSlMxD/zyrbZRRc/4104KeQAxGE7E+D7zsizpaCQr
 ju8p3oA7qOAtDZgTZbwsMFTAi3rHd6CQl2z2FuQUwPuWpsxO246Nq/hyhvUvgI3B1Hho
 tQ197+UiGya5JPvdMJOk5XzvCUB/0YE4cObsgWYCjMbv4CsT6xeno8C3iiCu0rqfsTfd
 SEil9NRR2uFrLiTcCV74P79azRfNVEx9fughj4oUIVG7GfmY0+tWAPw9VMBqOAs5NJGU
 nxJ6YwEHMcJHgD58GKdsD4hu5VmTPBjSIjUMis2TkjpuaqYDgY9ggeUGN0RdNutAj4i9
 nvgw==
X-Forwarded-Encrypted: i=1;
 AHgh+RozvticEZOFjbEqqGtEh4bNCUdj2OHZYzqZxzGbrd+hD+8eg0V2OGJTEm/1Ju8ohe4B7FpkX0xjQSCf@nongnu.org
X-Gm-Message-State: AFuF++mxL9DBPcvrEBCRF12Vq14sA22l5J2v1ZfdlLcuE+bN+rbTl+rN
 zxi5e00IvlwD2K8Hxt9QVNvxWzp68MekTIlstxvXSC389a1ykQjr5g6dcJh05mcDh3fGG4uUut5
 qN246wiYk0ReE5YAuCTASrTmTnd8Z9TQ+BiZzXonBc55wnhZ0G9Ao/0tQ1g==
X-Gm-Gg: AR+sD12wmKVxp9ztQBkotIkIx+yYVK38SQOstYPLyLSUVMHU+r0Hm8nco+ku6kjwDwc
 Wz18Ar7maZKguxuvb5GkJlHisCpUNjEL6OQqUHpAqaZK88+jrTInlFiAxJg6TaQXE24SBVYsAGr
 1TE7rpyXGB3Ul2z1XqXzrkS1ZWA83dwvEH84bYI+tUMxWESUMxTFXVOdwe1QwLeIiq/ep6ABujg
 7ttjFt+gIiwKVLcoCimLyCdhk1/N3I3pXW31CMT2riqxMDz37/Aifq1zIXmNToJtuYXJEKxWqtb
 bCD28KBWXz3FUfstw6SxDKMvbGRvu9SAcvI7cfWd0JSzfoDH/xuXp8xYU9l54RcJTSp1z9qMr3R
 nxxsHBRNtr6/hvccFBlezRGmYBf3BcxU1eg==
X-Received: by 2002:ac8:5902:0:b0:52e:2d19:b242 with SMTP id
 d75a77b69052e-52fb9679ed8mr59511421cf.38.1787910224827; 
 Fri, 28 Aug 2026 02:43:44 -0700 (PDT)
X-Received: by 2002:ac8:5902:0:b0:52e:2d19:b242 with SMTP id
 d75a77b69052e-52fb9679ed8mr59511201cf.38.1787910224410; 
 Fri, 28 Aug 2026 02:43:44 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbac8e61sm2815268f8f.13.2026.08.28.02.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 02:43:43 -0700 (PDT)
Message-ID: <356f285f-2d28-4d55-b77e-a08977007d53@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 11:43:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] target/arm: Move -cpu max stuff out of cpu32.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com
References: <20260827041557.775080-1-richard.henderson@linaro.org>
 <20260827041557.775080-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260827041557.775080-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a915851 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4xcaoMNFPcli_URQss1gskjn5utYuSmJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4MiBTYWx0ZWRfX0aL6DFRLTNUR
 Gp3Pr7ywxRMKYCvJ1Hgvr6Z0H5vvmQ8wbowObI+kxsf1Mro69DA6xVmK2M9UUZLLTDo42K4odIE
 l3QI7hG4b7cx4IB/+jKcOkHh/g8D3Qu30Wa02phn2e5ta2fxLXfFT2+VCfM1yLtTUq169MWgVtq
 bRsen5jBxIt7ur9Uu9cAJiJPP+Hjmv16fFxLgZw1Ed+hb+HC9C/DVbZpd8tuVDmjLIPmr1y5tJ8
 zSRJ31etMNWhSyNiayJyR2EuEr9oVHfyunBEJKhvF901zfEolNUjOyu6vM3gJ63MjiME7inevq4
 6vCRQ69jD5F55E7KGgRz+TW0EXxaSTKHmH6Waz14DsE3j5RIbx7g9h0F/f7JKNZsK+kR9WZcnQC
 zpwnoP23S5oRgurj/wy5Xvsw3n2TjtLdWQeyZHqWydkNgADBh317U5cErMVP3mo3p+V5j3THAlO
 9RIr61tiKdCkQ7l4lyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4MiBTYWx0ZWRfXz9yEndAzNbSm
 6CzG/DjO8w68cWStemDZQHMcKKVcYRoXDF06vpUPZFxwyQ2hFkGUGn6qhAypvddDSYaAut671lp
 uhcIEgIXyJMhhFbvdbSxN/x+nBYMUWg=
X-Proofpoint-ORIG-GUID: 4xcaoMNFPcli_URQss1gskjn5utYuSmJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280082
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

On 27/8/26 06:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/cpu-max-v8.c | 117 ++++++++++++++++++++++++++++++++++++
>   target/arm/tcg/cpu32.c      | 111 ----------------------------------
>   target/arm/tcg/meson.build  |   1 +
>   3 files changed, 118 insertions(+), 111 deletions(-)
>   create mode 100644 target/arm/tcg/cpu-max-v8.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

