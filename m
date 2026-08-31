Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715EEC61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 04:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0u5h-0004PE-9A; Mon, 31 Aug 2026 00:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0u5e-0004Ow-SY
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:57:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0u5d-000688-Du
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:57:50 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V1bqxd1622032
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y3YPPkYMOSBamSxvJGIPZEhLP7qy/jocOBTFT6Rg09c=; b=msLpd66/ALsbhEFC
 GUj9hYRCMul8E07rrz/F8iXwKBf7CygsfGWczf42gaboSkUaLb4j/dpNTUCnNX0l
 gH7s9G1EZ9txOUtoa7CJafR29J7LDwG0Yf61Dtb8rxrROzWot7gpxOIbC7CrgaUu
 IKspuswj5AFgG2GlBQd7cAruPSMGSCBFYf2A6gMmG6b+mtCDJDfbE+ea+Hfgxp9A
 nFiu83UED7YdAmWyp43g3DzRYCJRK1g70yn6tYSt7T9hs6pTdegZItMOOjl9P8Sp
 gghb0pGo1HyQbClUZwkyGxLQFy30+cGDLFA+HmfpQAe00VcVpSbZ81VtsOZyJocR
 NZw4sw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbr6dvgcd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:57:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so520834785a.1
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 21:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788152266; x=1788757066; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=y3YPPkYMOSBamSxvJGIPZEhLP7qy/jocOBTFT6Rg09c=;
 b=CBohuh4Y1abZaNS/ANlbtvLz+SCxOaJrwwNCV58aVRfPQz584O3RRGYiz492mkivK6
 Rfiq1UXQSp1+NluJWaFOKxoySrqhA/65qmahreiwdfPCv5hvraUrc7NxyMfOyymd18eg
 oQ1I4ikiUiAJGWD9twI4Oi7M9m7k2MoPSFKXG7Y77itPNMB3lFc6SzTMCKmbAlIYry/l
 7RvOrD2O8/C4bxEcbsQPXkuZ6c+GpLNb+E6j/KGMrLJeEGcOkVIZ5VHe0z2HIqwx2a7a
 AhX3/UUv3qXB6O5YPY2o+hrnKAUJQa2OSTmDn9P9IGJjF/wtZNlhnWCHbYMFpjOyXKIK
 M8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788152266; x=1788757066;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y3YPPkYMOSBamSxvJGIPZEhLP7qy/jocOBTFT6Rg09c=;
 b=tOoVEUPJG6Z5Gr8B5WEapMl1UVqNj8VQdwg8QRaUYG77J/fON0LByn0E49kRHGlZGA
 ZN1ucSJ2QVnFipEojy9brT8nxa8Ke6xlL0ZHrUPh69K831mMvqP+bT1vyHekBh55ekIS
 Q2mcaefg3AmqRyLNZqrCSmkVpLbxSfm5PGYskbS87jhWFpKDGJ1C22oRhMmnCL7Nvzgi
 dRjqZyzr0q+3Ggtaq2pZ9f+75XfKMmofnGa/a5Smfg+x2/HwbaB2WqcrsB1ttGEB+mis
 E6fRnQ79DeR3QKwXVslhBYtSbL2EoVHotgf1acRK8Q86lqg18KaAvuNei7K+W/Fcj/Uq
 5ofA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHCxggV2eOn4GRqEE2Hz4UlGfhZ3sNv/UypYfl9YlTu9sZ2+PqTOzuniGzFnso1ivyYH6Ory1dPLSv@nongnu.org
X-Gm-Message-State: AFuF++kDtsiZsM/+ty4ksFu9dF0UtxrfcLLzOj3xUZjskJyx8jhl7ruT
 uhqb2y4zaRV84aE3sgfwv53n82xQHnGOgFt8qbAH2irEAWCaLTbeHvWLNsUsIvu5qDfFga/dW9g
 bzljWmT7bxw7xMO3eZJyTtgFeFHnJHFpDPm/lb7RtumQw7QsmD9wPQZPWCg==
X-Gm-Gg: AR+sD12lCAooORDZuKaNL/sr7bONjxtyVYf/C4BSvhc81o79gPCytk8c4yzssWEnl2H
 HA41TQbY96oyUXVkxiL3Hq/ZxkVLDATz2ZYftKc0xE9M+lvuG7BI+5dkItdrnWBvUa3qKIcE0PE
 TPay07CksgyVaftaaQqml4yG4rozXVLHfJdEO6zBU9YziI6QcsEe70PXZKDaGnshpudM2V+rtmC
 7skpITGXtyYAEk4Uy5DKxfSdkv1pmxWbSyH7rxpg2spCiTxu/cnUGQJsOYbVVwkx69/8QVcCj0M
 5/oV6xd8/7IKFS34RKld0qDwhoymkTvk7GPl40+8bvFiNY2QmD5GZw6ykC9ag+gcxX00Hlimavf
 e/Htyua/xP4WKNYqLmc9vtpQor1VN1AnvdA==
X-Received: by 2002:a05:620a:4148:b0:939:f89:368d with SMTP id
 af79cd13be357-93936daaf1dmr578653085a.22.1788152266152; 
 Sun, 30 Aug 2026 21:57:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4148:b0:939:f89:368d with SMTP id
 af79cd13be357-93936daaf1dmr578650685a.22.1788152265718; 
 Sun, 30 Aug 2026 21:57:45 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4942298fsm352121605e9.1.2026.08.30.21.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 21:57:44 -0700 (PDT)
Message-ID: <522d3f1a-037d-40eb-a86a-38c5fc1b4b6a@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 06:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] hw/riscv/aia: Take a MemoryRegion for the
 created devices
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-2-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831021500.82565-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MCBTYWx0ZWRfX3fjBcfyT8XbH
 HFfEQ6/VgYDZv0PuAqOmqfESXSMnEdbjdrJlsZKc/nufecv/0veZlAZtHfHhU+U7ddO9FIKek4t
 rb5jCX8RNHPFAv93NY0/OWAlOYW2dTHXYY3b+iBxvwggC34HgwzHQPDALKva+pDGozWR2KH5CxB
 MOLSwpRKG9dG4V5a+C4B2AVD9kQh+DmPVbTGj1PjGXZ1WfcFrizAu6gohwlxCpHxh8zmcYx4O06
 oJz2mEqZYf/NQDjuTynFkA1mso0WKQX/qt7fyI4C8mm8PyKAeUrAv+jNq4IW7+aCf1zhVbg9JQL
 1dTIi3e+qDQHfCfTDVGw3Emw0FZrbKcjZ9kUZJQsbX3MhZnwnTx+mhiDbhe6YnmvgKnnYezHOxk
 lGvAzU8drv7DIOxeW4R9l+vACGnzaw1od6QHVxdjJK/srKAsOZuFp62VPf+cGmUrEpA1BXiCXfv
 s63If2zNwF3ckcyZkqA==
X-Proofpoint-GUID: yt00BD3GJcyBZ-ml1futIwVAF1onzyK1
X-Authority-Analysis: v=2.4 cv=Zakt8MVA c=1 sm=1 tr=0 ts=6a9509cb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MCBTYWx0ZWRfX1MekCElWyUA5
 lYEMgKjgFdKoeWDL2yme6DkZF1EWctl/+idJ2p4dscvawMUhEvmanvKSxWXLZsxdaLbjddD6x9Z
 fAIFmISQ0xxhAOW4khZ4HxjjQdpWKAw=
X-Proofpoint-ORIG-GUID: yt00BD3GJcyBZ-ml1futIwVAF1onzyK1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310040
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

On 31/8/26 04:14, Joel Stanley wrote:
> Add a MemoryRegion parameter to riscv_create_aia(), to be passed on to
> the IMSIC and APLIC helpers so a SoC can have the controllers mapped
> into its own memory container. Both callers pass system_memory, so there
> is no change in behaviour.
> 
> As the controllers don't yet take a MemoryRegion the parameter is not
> yet passed on. Changing riscv_create_aia first avoids churn in the
> intermediate commits.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/riscv/aia.h         | 2 +-
>   hw/riscv/aia.c         | 2 +-
>   hw/riscv/tt_atlantis.c | 3 ++-
>   hw/riscv/virt.c        | 3 ++-
>   4 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

