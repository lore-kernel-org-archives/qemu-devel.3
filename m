Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F039C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh24a-0003Li-T7; Tue, 07 Jul 2026 05:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh24V-0003L0-IJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:26:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh24S-0005xU-8Y
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:26:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678DwAM3070346
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 09:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +ZHBkycwrjZJef6ktEx76B6ct7lWJzLoFi+SDAMpJEY=; b=f9amCEPodQHVJw/P
 UCsJ+eRhth689BRR9a3HZvhMGVavbRlQN5dXgSYktQgtElA2yv6ecNf1Aff66YjW
 j2E5+GMLLePNfOgMOSbpmzjxIp6p7M3onj1vmzeP1Z5BBUuEqAOgd+MCDIZkOisq
 x9gMGYOVVYNyFI5DwLSPFw1bNkgr7tFehpdKbcDjdMozH1EgUguc80kBEH5fonKH
 nOZ8SkhancJotl2fosZxGC2GEHmtLtUE0j5nif0jGYaVo38D88rnTQDmzLqspCBk
 UT1ur9Om0svTEYP4+nxsSQLYgLqmNP1jg//vX7zP6xIVcyp2vNaeoKTxJAxZZ+KC
 SwcO8Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8h9df-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:26:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a97644aso52950411cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783416383; x=1784021183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+ZHBkycwrjZJef6ktEx76B6ct7lWJzLoFi+SDAMpJEY=;
 b=FQnV3njgs2JFCBhQmvJ1UIlOnfSjFpfKpFALThTADaMHgYWsx5eG7BmWk4pkeakmi3
 rkcv08D+bCNu+PHaA0Jy72tcz/iyPUxtgOztxjvUeFkSu+wq8N5viDOBXaNS3s0BXGrs
 jmg0klr2nc3hAzbXI8knlsdlB0B9inlC8h8lu0gE/erWHe0nRYg8pk7wAQtwHFkBBwUy
 hbpyFs2/sL8d2npTIaw/N9A7M7jVZOF8Ruq+gr8gZ34bKAo411EPAujRhByB4ib5VyTU
 LkAPcRZCKvrwv0kZCCR/muuJ8bDgRdd3D8C1KvbhXvdxopzuwYEUQtOBR8CTjECGSEkx
 hegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783416383; x=1784021183;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ZHBkycwrjZJef6ktEx76B6ct7lWJzLoFi+SDAMpJEY=;
 b=YzJ3RjPeA8hDvEQeSGnP2FCEq2KROenWaelvxRGY7NAAnMWkd2SMF4QGv5tr1pTY8Z
 KTpKX/r1eLyYaT9HhPBeM5bds7wrbse2eDsx0PEq1jv8XHPk7G9ImJswUpb7xcvV8/N7
 Pw5FoaBZr011iJxUHLcOs699ZDrUJtJ/ZqBZSbK5YwRGly/bstK904GHepUBW73rfhFG
 ooCJkyXmNf/xEIH8Ux2T/B6ZcvHn88RhUgFKazOFF5rfrXHpcLFwDxC/VLCsiXJKd2UF
 q1Neo97pCn1wJybUpeym/wyqSQ5qyOlhAM3ArVOUyoC54M2AkvU1piR0smcxg+N+8seh
 jF/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RorS+I+E5J0X+cuqSy7vhF3D0JJ1iysFoOuv9UFxUjlrdCvaGDEWaDzW6MewsEjtrtR2LBcwdk8AgCm@nongnu.org
X-Gm-Message-State: AOJu0YzDBIE0h4eXrWzYrCzqNw/AcK33BZjoSnJMq6QaUMQ8MreEAXsu
 heBV+jZQkt1ixRe014SWWNd7QAcjuRFsInszNG4fmIKy9RlWTJTvhfCcRdh6/iC/XsEKprHh4qe
 ltmVufeX+93bFq7kMnUdcqwg661OGhIhd1/m5dkRJsW5ItytocW+q2hv8Ow==
X-Gm-Gg: AfdE7ckp6YzbPmFsUdPDhs+UXO1FAxP4JJZSdCvFTyGhfRc15eL3QFQevYec26Z/bbN
 8DZSbx2KuV37jT4yJblwYntQY6rlaH5qhbbFwKu5n3veM27asLaSyvV4Ieo/dzCj5ctLoqFwoVX
 SJVrBnguuyOmBr4u5gjyqIlNG0OqIc9ncEm4unXMW8h4XzDTCejgYhuet94DPM8HmE/Bza81XF8
 20m34OLIwEsN4ZP+aCQbIO1Y1w4MhfCxvKQSeP6h1sNpthE+zSGiwVct8dWirP8PiM1kLw6AiTF
 aT0MQp9c/17PTDG7WpQT1FF2Jue7eIEaOTvZkl4muPCAL6JjcOu8Jefr5K9x73FmP4LDbzxLJum
 P9cBVfdSWqeGChoquIFlM+5zToHqCXTKqBwWhSYpmbdLOX9kLN1Bgj+nLj3fyMA==
X-Received: by 2002:a05:622a:393:b0:51a:8c9c:7f45 with SMTP id
 d75a77b69052e-51c7491ee69mr41696511cf.72.1783416383346; 
 Tue, 07 Jul 2026 02:26:23 -0700 (PDT)
X-Received: by 2002:a05:622a:393:b0:51a:8c9c:7f45 with SMTP id
 d75a77b69052e-51c7491ee69mr41696281cf.72.1783416382863; 
 Tue, 07 Jul 2026 02:26:22 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad882289sm92323066b.26.2026.07.07.02.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:26:21 -0700 (PDT)
Message-ID: <8fea73d6-2be3-4d46-919c-db102044c145@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] hw/arm/ast27x0: Share FMC controller with SSP and
 TSP
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
 <20260707060919.350637-8-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707060919.350637-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfX3SiwSi0+go01
 ImHnwqvQvnKZSy2J/ylp6JnG/QE7jvTh3BwgruYeHcs1gaJpXgjzV02w8HS+qDlRoav836hCSgn
 kHTIYfpGL0xiPSKF01xpEfJ24hGwcNXuN25/LrbEOg4RRbE/al1jHFlc+OPy1FLFpBnBfKspXra
 td86YQCpm6uxmZou9PlFXL+Yj7mUFFrao8kkJMCSF9KhNSy8EwJJPR5IMFpYxiwvP59UPVS2cwL
 5Ir4nO4owsQgDPFnS1UIWBCCkCmX1oBONE09Xcx5093j2gIZq3S4IADshd7I8hClwMAcRa5LQTd
 kiLm+u90AJS4jopMIVe1kBs2XMrdsWcbmZ+JAIPgii1ukorFMhuacjv4VqmUkJiVAlvxe4e1EOm
 TZYybVk8jHmfpOZ2sy5fM6IZhHEjkX1IjPDyOlV6QBxxPObVlAttbGvaIg0F2boteTE2Rue1iPV
 cg8FfoIoUVbVgqTUdaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfX4t92ffB3MKSa
 J47qKxBjV6wm9JNPWCj/kSADwPAalJ1+yZnNPYe/hge/SxvIiboR/NYz2XzTttFBnVdZlKf2cE2
 aiE1L+DirVMUi/pnsVMLG7GZPJ2ZSAQ=
X-Proofpoint-GUID: XXSu5r6GQSU44R7YgPIj3Kx2fpIOerYe
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4cc640 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=ZF2H4-TtLR8raOJ9nFIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-ORIG-GUID: XXSu5r6GQSU44R7YgPIj3Kx2fpIOerYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070090
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

On 7/7/26 08:09, Jamin Lin wrote:
> AST2700 provides a single FMC controller shared by the main CA35 processor
> (PSP) and the SSP/TSP coprocessors.
> 
>  From the PSP perspective, the FMC controller is memory-mapped at
> 0x14000000–0x140000FF. The SSP and TSP access the same controller through
> a different address window at 0x74000000–0x740000FF.
> 
> This change allows the SSP and TSP SoC models to reference the existing
> PSP FMC instance instead of creating independent controllers. An MMIO
> alias is added in the SSP and TSP address spaces to map their FMC access
> window to the shared FMC device.
> 
> This ensures consistent FMC state across PSP, SSP, and TSP and matches
> the AST2700 hardware design.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h |  2 ++
>   hw/arm/aspeed_ast27x0-fc.c          |  4 ++++
>   hw/arm/aspeed_ast27x0-ssp.c         | 16 ++++++++++++++++
>   hw/arm/aspeed_ast27x0-tsp.c         | 16 ++++++++++++++++
>   4 files changed, 38 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

