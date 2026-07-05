Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20829C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUrA-0004qK-CX; Sun, 05 Jul 2026 17:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUr8-0004lu-OH
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUr7-0008Pq-7n
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:30 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665KWL192654230
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RtjZ4UawxKY6hyADvsRTIyYdzMF2IdfjAMMFIAxheic=; b=mjVOFLSbBeOSlMr2
 flfLb3D+Zk2QCPlvxMxP7w2M7PG3G3MNV+Uqfc+AU+P6zq7x4BG3ai/t+jNjZUzm
 Cd3FEx9P6EZc8uzo4TDvDKiXnakJYvVwJMsxMSCWSYPJ5ujS/uACfk+92HTfC9Js
 KGWq3qSAtF2hE2Gq9MD8cGf867TqKdtqM8PhbAih8Dyyk6aOTYAS6dhyr/YrThS+
 LIl3miSjzma9ZYtd5YGVv3bSWtShneVhLuxxFw8kthDIgFGiqqkhvEBR+jFMrCPT
 638y+MDuVrrMdnPyDaMADhHJq6lvCEtgWvswg4kcsAWNM0fP7DmWZ/Sqqg1g8pEK
 qzg3fA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6t8ukg60-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:58:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e59b0e0f4so167675785a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288698; x=1783893498; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RtjZ4UawxKY6hyADvsRTIyYdzMF2IdfjAMMFIAxheic=;
 b=LTGCDuDUjXsQYrMy8SQTPnHeqttiULT0+AlitNOqHmOpQdhKc2mq0CY0OYvignaU2A
 3l2UE+DPqYwDFHSYpJD9Jfzi5nOib3EyDYDsvFnGyKRQYUmTee6q1KouCVGnOh0YU3xS
 e0Ld0ggJs4wRCrjDBGLazr40MxexUgqxCMIlmNCf6PVwW7ckoJbXVf5SkF07S/yi6yGn
 lYKVIwB4AdXxxJnkwbE/dZxJ2N/GlOyQyAkmIp3xjakWqBNtYQjjYtscxwkpwSMaspCF
 QMkWWw5hbo8Nozt1yYJcgdj1GGOvJ1ewAUH57XxSvMrUUI3hEOnDtpEZL3HuhOFPZqiL
 qrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288698; x=1783893498;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RtjZ4UawxKY6hyADvsRTIyYdzMF2IdfjAMMFIAxheic=;
 b=pUGi8fN4PB5NRSPFWcxla5GVQJFKlOL4JC/UmACFqvelWtea0PGQ80lCWAfMpopM7c
 jSqnTtqzaYz1CdirZtHY7P8S0Agy/AcjhVfb6nu6LwF/TfPQ8HbOQY1mCTiCo7IV1EdZ
 4ir2wdpo3anarB/7c+Tnv53z62pxAKC8AcD2kNUBjYTBG1gkbrKJdc60f2u18EBmIgrR
 erX8H+JXVs0qGve48SEoyUsUkLyyGux6atx8Hiim2btEw+4adSiT20XoNdfqv30ecttk
 i3mMoGxnRh9+EWLf2Z9xr6Mnq5YWD1oHx2QdhSJivU/xxVqiWcKlmwe6XTI9dwlij9dC
 wg5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOJoTypewEUudBDI51cSJoK4t3S41IeB0m1uGcmjAsKgw3KGw4XYiOB4NNR+tDI0S3nOYB3MgAk2/r@nongnu.org
X-Gm-Message-State: AOJu0Yw/sG0htk4wzbFEN2T7kjbeEBz13am7MsXLHwQMYb1D8o+H9aKS
 3jMqZlqwiOEq84rPISfboWRqaEngIry8t7JGQPLumgufC347Nf1y3gumO12dtiavCDO/9hd498/
 MSmZIIb5FwiQH6NvSqivKEEyjIbg+LIsxWZJlPhEN/W3YDCJ0KnyisOMniO0129OfPw==
X-Gm-Gg: AfdE7ck4jGVkf5ntytTzDYlil9aXuztNTDJWxXehX3O5gszaCKllkEPM4kbq48dCtVW
 4zf3OjtSJjbxZiyzs8Z9aIPLyjUMPgkYh3Ltrhgoo5iB8JI57EWp3qtak8bpWGBYQ+m645lNugA
 YL3n2IzuUksyQ7U67BMl+jv6QbVBa4mCczzLAIkPOO5REdYthBWj1yHDP+mJD1doP7UCsu0iD6b
 h4Euy5lfoo2zLr1qOTa3gEhl6ZDXU8kVqHXBodkugWTGepDYC//EVquMuKPHNlIhhYNntw9ENu+
 EmUwV99zxqpIlBS3iIgMpYOlZM+SIKj9cHnY+dM9oBGjDiTcvxrEHmHLVsy8N6wNYc+vgAkuiVz
 QCBbUMflgSJ6LgaYtJU563JRKN6/oXYZUKIAqQ+YGwFRTt1o=
X-Received: by 2002:a05:620a:4114:b0:92e:6dc0:7b13 with SMTP id
 af79cd13be357-92e9a4e1555mr1019012885a.53.1783288697635; 
 Sun, 05 Jul 2026 14:58:17 -0700 (PDT)
X-Received: by 2002:a05:620a:4114:b0:92e:6dc0:7b13 with SMTP id
 af79cd13be357-92e9a4e1555mr1019010185a.53.1783288697069; 
 Sun, 05 Jul 2026 14:58:17 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9b4d850dsm20075486f8f.0.2026.07.05.14.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2026 14:58:16 -0700 (PDT)
Message-ID: <95d68083-87d6-42e0-bb84-26465bed9f20@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 23:58:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/hppa: Work-around for Fast TLB insert
 instruction on HP-UX 9
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20260703193224.33135-1-deller@kernel.org>
 <20260703193224.33135-2-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260703193224.33135-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NBosOv79YD2IilboISSWt9tMhZJ-VnE7
X-Proofpoint-GUID: NBosOv79YD2IilboISSWt9tMhZJ-VnE7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX7kbkxflg/4Aq
 MDhROG7vXl5pZYc835llEH2tUnnf4m/D9YRIuMXqtF0LtHrTVssCtXitZkLUhsHeWl+YcbZe7ia
 Fz6BHvDZ3fETn6yC7vkM2pI+h9NGKwA=
X-Authority-Analysis: v=2.4 cv=MZxcfZ/f c=1 sm=1 tr=0 ts=6a4ad37a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX0nKjoVlmM6mf
 Pc5/ggdcFHIfHjkHSHprHkw4kCM2xaPUU83Wv6k53dmsXCgfxNqf8ljmkq+eIl1nJ0JcPksSyVx
 tX4PXtGF429qyUo87i7U0d3lFKu2EqwFkn+usNUGXh/CTLiBjxt5QjMaLWJI3R7XThRHJDKNhc2
 dfCCv+OmSHfXFb0B1m8zWwujBSW6cSWRINUdjhB6EBjv3o/xKANohKB7Vmsmqvlytzqy7+bAtCs
 T2+xBQ5RvGXxvY8Qg1X2GOWQ61aEG3quX4emtUc+5b4g1jBHDOFV4VWE5t5mkRjK3RkD6TRat+C
 RJyGg1OA+nArf/EapnI5DGZc7ANPwS25U2rcBCtZ6aEI+Cc1w6Afy63KhFbEUKr5SbPC009w3og
 HV//s/ROsXyf9Eg0+Jl9g+CKPYB5UnfwV0JMvWiFOsw4T992nhyM7nTkbhiLxITrKApEsqqMzBH
 MmebLKAN2LwvoSlM3/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050237
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

On 3/7/26 21:32, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The HP-UX 9 kernel uses two TLB insert instructions (0x05315440 and
> 0x05385400), which seem to be wrongly encoded fast TLB instructions, but
> similiar to the non-fast instructions idtlba r17,(r9) and
> idtlbp r24,(r9).
> 
> It's not clear, if those undocumented instructions were used by mistake,
> or intentionally. Either way, this patch allows qemu to handle those
> instructions, so that a HP-UX 9 boot-CD can now boot somewhat further (but
> still crashes due to other reasons afterwards).
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/insns.decode | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

