Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D949CC61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0u9R-0005ia-1C; Mon, 31 Aug 2026 01:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0u9O-0005hi-8j
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:01:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0u9M-0006Sq-Qh
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:01:42 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V1bPWm1496291
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FuDDS1Ulu4DUR8FA8LQLoCZjbUgOpGIww0AMXWy7CU0=; b=SoECXhZZeMZrIlZv
 wDRwbjUPW1T3DhmiJZtJ3qg+vNiuE7F+d5hr0gHzs6x2LwOaNg2KqiPqE43TTySE
 VcNZWNvAYSmtD3cgI48zBwFv55qOww7vP9722gYYewszBzvF731UJAHgFVd/00Xe
 IHDBrrTrQm5KcukogVX4XHZQotUsx74i4jhgBCoDORsoNXIAa7cMiBifOIy4419b
 Fxmk4jvSnWIjrDg+ThtG+5Z+Se9xF06Ptog7mfruTXcBa0Vs8scg8SER4ognKRAP
 BkLxti8lXYd6W35M05P0/whiHhydSLNUm36qGd67U1TcD/CrAB0VwsHTkOonPH3V
 rX/d2Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrq84f26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:01:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-938153538caso552104785a.1
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 22:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788152498; x=1788757298; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FuDDS1Ulu4DUR8FA8LQLoCZjbUgOpGIww0AMXWy7CU0=;
 b=XNwXHYHv23yZu7AH7JACQvw5gQmykJdDvAyWEzCr6TvYQ7FaRUSOF87J9AswPoIavf
 FkXW6CWjcdCWc10IgBBuTPzSqfH3gAlfUOyoWH/76jNnzZ3MMKr0O8VshMZXq3YsqnVR
 P3FCRsISqg+eTiwg788UZct/bHQuFTjT6Oznd+TY3wvN7OK6bdUN17Pn/52dx0eh6cv1
 lu/zZinLkmJiuJIKpUinFRMNR0J/NFYF/aaW1LPPz7VxtMZDd5cinGSapy/ra27Xcfvi
 ZY0LQKu3jwdjIawe1YmIOUqMsyl7SnO5NwEsDMciMfNatb/N5bpwhGzgm7f/JChi59Yy
 BHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788152498; x=1788757298;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FuDDS1Ulu4DUR8FA8LQLoCZjbUgOpGIww0AMXWy7CU0=;
 b=j2mppysTwjliX0fU2aVNIarS/pJbn6dkyfm2C/VC8Tohvv/lMPzBELA8bTygo4OO/B
 pCAtygdYIjx1Mp5UG1aY3sQ6zuMjHSxMBiexC83kHXITI9TR2P/+cpHkn2hgTK9hPU4I
 zrtuXm1wqyUhSiMcmy90V6lVz1h5fQxAtOnHghidfhjWiLuK1bFL22G+LweH4un86CQj
 +opLL6z0avH3/WJ1Lm4mFj2iC2mKmmoBpnFqhgHjJEY62VA7t+wRl1+SGQSDHh9br8Xf
 DC7EUfN5eS8FZjErhE6lbxs78I76anaBgjucfKwp6XeP877T8L0BL3R2v+jc91xRx1Jk
 KG9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPoOegSdLFuIwwAXoJPVlhvxGTgN7NDSAeUzoWTNQ7xKbtvkmGAhAJE7sqcwT/EyIrgvR4xT1AeOJW@nongnu.org
X-Gm-Message-State: AFuF++mQwYlk42Od9a0hW3xiKIFV9IIIF0io8fKC9K2pzPhoZvjDC2pl
 T4IIr64Z7LjeczJBONb7O1nECAYO8LMCletLcOPksc+JkgbAgS50b7CWGIs9KXrDYSZ/40iW2q/
 egBE6h+QTWSHfo6EjHKkZcfW+H/VO+yQMrmwJb5J4X82GhDmEmG4syseBUw==
X-Gm-Gg: AR+sD12fu4PCI7JVKCpSkMlU7YuiVQemENbPpm8Gz7wWt2fAt3vk6ipABX2JLOdc5Dk
 LTw4yiUFkqg1zvnqV+uorZRbbq9HSqHzfaIjRKu67dFgPk2rtKyA6bJILlHLZ0fWRqWNbGU0HAU
 jW0w5LbpvVwETg2oYi63yca85A11CFSsctZraFLX2GBC45YHwSv3/LRVpz7qZusKnlxAYDbLPb7
 Usl3l7DP4/uYsiEAjScRKgrmPC5ltV5tXr1gkbE2Msc5X518SbAb1rnuICAFLy/L+ZsynsuQ4+B
 QINur9PI1e5VqMAky4B0HOToHcq4wXqnDXoG+KTSRGsC8g+JWR6ggQBRJc6HEPje85I1qH/G5Gx
 tDx7FDOu4eDII+Wt3bBbv6weZ7c+Ca6/bjg==
X-Received: by 2002:a05:620a:2719:b0:936:e702:51a9 with SMTP id
 af79cd13be357-9391395d467mr405426185a.36.1788152497979; 
 Sun, 30 Aug 2026 22:01:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2719:b0:936:e702:51a9 with SMTP id
 af79cd13be357-9391395d467mr405421685a.36.1788152497573; 
 Sun, 30 Aug 2026 22:01:37 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4942298fsm352383635e9.1.2026.08.30.22.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 22:01:36 -0700 (PDT)
Message-ID: <0d9d86d6-a66f-4692-8cc8-0d1df6c9a1a8@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 07:01:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] hw/intc/riscv_imsic: Take a MemoryRegion for the
 created device
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
 <20260831021500.82565-4-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831021500.82565-4-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PSIll5zp78wkriedb8K2BM7Z-i63MDqr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MCBTYWx0ZWRfXwvgaHAxmR9Ta
 AnaVAVPEEtPk6Otw1PWuhCr91n5+ZqXsy4hQtRWWCIqGsDasvaiYu2aZIQ4fI7L5OKdSssnHcEV
 2H7Q/UERlrAGgWPEwyNhyRfODMocEPQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MCBTYWx0ZWRfXxsS3rocqrJKZ
 hlhDR/zLqyCrjkAfI4Qz8buC90iCsIqupVQJ6otb5VZ2ZOk0itYUy0468xT3WEl6L0WH5LzSG8x
 4tcWtCXDW7i8QU1JfSvdiT3AKX8MqIq/KY/aiJwcWpeJoRrjEJlnTzO9ZdYZdtJsG3ARkh+4az7
 2WmYJ7USTfU7kp/yoIUUn32EPOHftdMyfLVYsNEoiR3ok4pYcuJV8lAs+wyLdJ+Eg3JFsOZorH0
 exgRvoBY4NF+t/VBmTCgtOLMM2tVZVl0Hw83ypbeOR6SPHYy4wZm+h092cgSwtg7EHqCwvM78W9
 Z2s7LcSqHnXVebTUgb5Ed5biQpy3FW2U8kgqMhILNT7WpCHEgkB3pAxwepW+sQVR74YjF084WxW
 osqPdayWlYAlK907nnftpyG5YuD9I4eHtJ51AG6fiF5xLKcQQTdViUiiTnvamikwYoHR1mCWpHB
 YxtExnX2xokmEemNQfg==
X-Authority-Analysis: v=2.4 cv=ZOPnX37b c=1 sm=1 tr=0 ts=6a950ab3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=oeOAIEJQpRq6JHWgIQkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: PSIll5zp78wkriedb8K2BM7Z-i63MDqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310040
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
> riscv_imsic_create() maps the device it creates into system_memory,
> which prevents its use by SoCs that map devices into their own memory
> container.

Reviewing previous patches I was thinking maybe @mr argument would
be better named as @container. This description confirms that. Not
a request to change, but still mentioning in case you think it fits
well if a v3 is required.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Add a MemoryRegion parameter and map the device into it instead of
> calling sysbus_mmio_map(). All callers pass system_memory, so there is
> no change in behaviour.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/intc/riscv_imsic.h | 3 ++-
>   hw/intc/riscv_imsic.c         | 6 ++++--
>   hw/riscv/aia.c                | 6 ++++--
>   hw/riscv/xiangshan_kmh.c      | 5 +++--
>   4 files changed, 13 insertions(+), 7 deletions(-)

