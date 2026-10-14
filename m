Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67B3CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4vW-0002fN-W8; Wed, 14 Oct 2026 15:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4vV-0002fE-JN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:46:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4vT-00023f-VH
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:46:13 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EFMoI91682834
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0wIbSmpZMS1B84U2B/6PZzlvX4JpBY6oP1XG9dHdrbs=; b=GxP4wLKWqQDLJISc
 1jhc1m/my6kLYXLm8whvPdYJMIrjMKuNSNe4D6PRsucmJd50jv0HTd1h10Xn8uzR
 AASpFEvw/FMTP7tjOeiNyIXSP4sflFylJU0o3JEY9NTFzGmAaTSoxvnsSnQWfeA/
 VA3laqhGOd/GrppFLRKhB8kKlt0HygfZMZ0V9x+Boy9VDdGiATtjxzswUplFRsuO
 Dn1efE0lLCccAlv6PX6C6Ov9TZzZmE9sBB3fhcD7PCHDEcsSotKEi4myHhFL9cvN
 buwtiUBBAPfq9viq/fkEZUIPdI73CJEfOjVOrnS+jdGia9+fK1vqEMX8S+GT5JHJ
 SInYKQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb010r3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:46:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e46c120dfso101580285a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792007169; x=1792611969; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0wIbSmpZMS1B84U2B/6PZzlvX4JpBY6oP1XG9dHdrbs=;
 b=T4FVeHWTzeeK+ZxtrTL6szGSdmdfDpGCKXWMoZgLgTlCBt6Iq7aiWEW0j5xJu3GeVA
 5sR2GXxPifKfhmwQ3mxNCLgv60pid8NcR1+8nvD1MMgeQ2QMq/YfZbwdj0JdPiVIKNxr
 y0Ygpyc50iijlN/HQDr8Cw4TsGv6cHVBvNOk6hCmdzaAsDEMxW5n1jGaYO5+MQy+cjug
 Ca2QCSkPHtOSvMaOkN1zX/iSknKV7jb98hQM513dAVde4pHE74iJ/h+tb/8KsTakrWAG
 4+l7Ag70KXEG7IJdYRu0yaZ9HCrCLjr4EQivLha+ZI7dne8Fa8gdY95BEge0ZzaCm9vH
 HyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007169; x=1792611969;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0wIbSmpZMS1B84U2B/6PZzlvX4JpBY6oP1XG9dHdrbs=;
 b=FEGGlfKQNAhMACDq+NXYN4bNYeXDiuqWCQYWjlnxDi1KWzPzlkN3N/16BrJ7ya17PV
 B4jfYdh8o/fjKUwxjZtGqQXx9DMDbjPYcMi76iIml/4vxiCAZTe7W2Fk9zJBCP6yWhlh
 Z/6gUUob191rHyjoMw9NoMhhjUL4NTrn9U8pvvtvXYuAKqHDOcepuxWz/bVPg11xOfwn
 Y9sMl45Jywh1q7FdRqbrLVVyDCIauEFdp6SYmLPx/F+Bo8EXkjXnS6aZFScymXZxElyD
 CDmPUNkfxTo56lg/WUcdZXEpBDJVcpnBzkDLS2epYIm2ok4VvVkNAV8U0SEK1NtSO5TH
 1xTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0Up54lF77EXkLltd4uxvWymysRCjEL7/7kRFAnOU7/9D71hojnDaDghMEgaBr2aKp+/ukhCCLp75L@nongnu.org
X-Gm-Message-State: AFq9FYLf72zGhA2eG6FP1IYbBtCJsqgRaCuft1cRBoDgkCuNpqh1TQNz
 pkjK9ZRi9m+Dg5W22cZ+jhwIrd1/FvnuicrHChAhvYthDpP0G1dCrfABBNQnatSIcn0LCSKK1tJ
 P7nYg791iC3mXPRsMvmOFj6SJQbLiIV27Y61XwEQWm8Zpm7eD2feWsLxvNQ==
X-Gm-Gg: AYBFou23p3q20XqpUMIiDGss5zu/T7Lbc52HK+3KzO9kpxj9KE7uSEg7E4vxIHwfLMw
 S+/GsSIjujxpZTY1kO9CLGopETKaBtrtsQAzT2f1lJKPtY+/rJnBe0vIGu+NaTFmN++8c2/haib
 95zEI+dTDS8+d7YIDwj3fRZtj74frr/gzdH0KTd/eimBp8TZ9uN4Kjdo102pAfyf+t3tapanSjC
 h1Ysmd2cjcsAA6AApgJVlDQd/ad1S6hCebVdBtxicVMxenEvrilMukWxGjgJQe/cI25GuUZgx7r
 GGqMIo8HtTY2DEieVh16thvZeoNXFv7Bnw3uFO5skL9uxvUjPHRPbVjiAI80piLsLA3KfVlik9l
 t4BzadLcBWru4vB6nvz7IH1LKkkGIeqVNuQ==
X-Received: by 2002:a05:620a:278f:b0:93e:c12c:fbcb with SMTP id
 af79cd13be357-93ec12d06e8mr2586244785a.71.1792007169029; 
 Wed, 14 Oct 2026 12:46:09 -0700 (PDT)
X-Received: by 2002:a05:620a:278f:b0:93e:c12c:fbcb with SMTP id
 af79cd13be357-93ec12d06e8mr2586241585a.71.1792007168403; 
 Wed, 14 Oct 2026 12:46:08 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc506asm14343134f8f.47.2026.10.14.12.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 12:46:07 -0700 (PDT)
Message-ID: <722ac0a0-6717-4275-9bf0-a5d4424a1177@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 21:46:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] target/arm: declare semihosting ops
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-9-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014182543.135965-9-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6acfdc02 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX2DHrGTFFXwQ8
 yBtSHxBhUzSjjPJUIhuzDyMs/KG/SeiPI58XXk4vOFxBVKHl2i3ge4OEIgo6xI+aFa/DUEdsCW3
 HiEU9L3vRk7gZVUTHMOsWqwKC5HaENg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX3UwbexXkPaSk
 86v1ipC/r921P6vqIGaZnq57OAestdh0GpwK0DJLGhmUHY+aKYiwqrF+fmqJiN/ECBpFonD2HUG
 wcdatM8h27JiNx9pKDyGEyU3spvt4E0YxQj3A/MtjTCpyeR6e97Jvr1g2ETe05ksXyVYcosDr6p
 GRo7FYqh9JQen2ojuTAsd00Fb4U+cMKrh9OFeohL082bbr/1W+AcVum3vvhnRSD31nGSOeQD+W3
 FgYhTIud5byX3x0qOFFNpTvmHyhbBAUZ4tbVCpapCRdoqaQ1jgg3ku7TR711cpuI4rG7UuchtL3
 qvNeyHtnpJzLEBXP/Ebg18YPtSUMfyngXRdNiraMrx4XeGiwEGkxO8ZC+5IysGEg8cXqwHAqiIQ
 8ipinjJzEIn6deiT7aR1+3Vavhl+P9HIdFcL4TYySNyefG31T38YBy42Er8FiK3jAzUhJJh+urN
 MLj8njPkBm6Tj6ZHLCg==
X-Proofpoint-ORIG-GUID: 81-Nb2grxIBYF93Ih76n3wmdM5Pv-_z2
X-Proofpoint-GUID: 81-Nb2grxIBYF93Ih76n3wmdM5Pv-_z2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140078
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

On 14/10/26 20:25, Pierrick Bouvier wrote:
> For now, we keep the global common_* symbols defined.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/arm/common-semi-target.c | 72 +++++++++++++++++++++++++++------
>   target/arm/cpu.c                |  4 ++
>   target/arm/internals.h          |  2 +
>   3 files changed, 65 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

