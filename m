Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3163CCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmUa-0001jp-3r; Fri, 16 Oct 2026 14:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmU4-0001MK-Th
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:16:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmU0-00018t-Pz
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:16:46 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE67aa2455244
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JbdZQvu1SQNN9hOE8oYU2rvwvhiYNhBYY7Mk28TM2hw=; b=X3USiEHSM6avpMHA
 u+TmiQWUmzHo6jBOVirErlln+iKHfOrq/ogsA+l365yoUcN38ueXcoRI73xcL/An
 VuGMe/bwgceyacEJCegqaVNUI6I9BV8eHZ2uE9Wnwpx4SBEUgFJSTCD0c6gYhhSI
 O3PlqRktm14KpWyolsyXvChF3GTMB780+hjG/pflyz8eQGSNccDql17ieRJtKZks
 8UmqEizN448lCK2EwMcNxG8edAVmCAOuOM6M75L7kv7ZMoirsD9UN3kp942ZeW1Z
 XO0qzB/ZsAOoRWvwIoRKDK7uA98vg6aoVH2a7Pj+1uUR2VmVZ0FmGiIrXkizeFlL
 A7QEMA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5ytahg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:16:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so377133eec.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174601; x=1792779401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JbdZQvu1SQNN9hOE8oYU2rvwvhiYNhBYY7Mk28TM2hw=;
 b=GuzSDFXNL4Hdycd72qWaHDmqcYKy9VcNLeq4PvWFpXNCVcOGRbuO3wWH8DlBVeFtK4
 cL6eIlNEgdyRV8rubUnlJuQI3Kfi6EuXiT+q1upYbsafMWjNQdu2JBUEuMy/JF5S+9gk
 F57vBrb4PAwDLPrN4JU/s1XQPu7LIKWQvv3FMQUbu5dhkPAMwtV0CJznPDKdDH8qfiUz
 h7YBYvQyNt5nqZaNzoHL/knKZ81MNWCJSo5VoLpXiJ+uac5J+2PvHL/URUhiWOsiTGCP
 N3f1sC2f+UwyKiESef3tRBONai312eXd+1YVx3mFsemm673NroTQwaEAqOhMq25v63j2
 ghvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174601; x=1792779401;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JbdZQvu1SQNN9hOE8oYU2rvwvhiYNhBYY7Mk28TM2hw=;
 b=pP80RjpLlvkdkTcxqdGDqHizIktKfxgs+zP+h7pN4PyjdjpL5jSieRwsCAfbbmekZT
 udHx5j6yXxrZaG6SbuY6uSzVt2A9f4PJP9AZipweI7vsCDx+Ky1zPwlk9jjIxL+iu/TL
 YDeYuoYQ2ZQSvb3ox0qvTaR6BgOZScwvBwuKdInVQ0fVu/O5qSsTAVX4cLhSb4OBWEwk
 dwd0fcdKXCtwgdWi2ZTTzWmW9vgPqQLqy8OZmjkrPOG8hfAnfWkGNzjJN0CRCCc055ni
 rJ8f+YV21TInGUGQW8vbdkF/jKmc6+a/cjVPduDy5bUmhiv2nnt7H/gXMTv0tK3DzVOu
 +gGw==
X-Gm-Message-State: AFq9FYJgg0lo/ZhzDsLjF7gXVlsG10tAAyHB215gB3O7OakkWfHsJVTC
 E1Ml6AMKP/MLIQzszHrAVdWPctxEp+jC6MRgODDHW5AZgJBvbaPLcTTKMrYoFs8oGHyQX7Zu/HQ
 Mkn3aZlyEaadh1PdJU6S6tvHfkwqnb1/GY+oHsOZSFW8n84/kQujEs8Q9PSIpdO/dYg==
X-Gm-Gg: AYBFou0v1Pp/xI4wzo1hzCYkRvaPTnLzp8GdWQdywo3YUr13/GjvKhts3YMbKURoLtx
 cklwzdiBs9dwxYKym2Nut+cbqoFOWkyT9mKtiWoYH0RH5UnSnMoQ8Kp3xQZeIbwbsS768bOuX8m
 87M5o4r/5N12r2DGrB5xc0f0t74K2WdKCaIw9Hu/6GseD0t/13FGqURmKgeoacTwxgNVPCqllCm
 wtvfhbSMmyaT5pdSgLG457zP+f3SMLsJLMuBuMfRcANTQeMZHJ098YVciC2J7JJcvmrnImGQG6l
 qs3EYkPsd6NwV9NymjbX8sGKKeGsPVHa155ZaS7Umuzm77MGsyu4iZsrmBXC+g7tZUY1gx0SAT7
 Uy5SniLdMdeHLO4rlO3j57CeuWSUvA6EfI0yaHX1dJCDGT2DHcgu0q7FGp+9/dZJ8O11LIg==
X-Received: by 2002:a05:7022:ea50:b0:143:2968:564c with SMTP id
 a92af1059eb24-18512f1e993mr746455c88.26.1792174600969; 
 Fri, 16 Oct 2026 11:16:40 -0700 (PDT)
X-Received: by 2002:a05:7022:ea50:b0:143:2968:564c with SMTP id
 a92af1059eb24-18512f1e993mr746418c88.26.1792174600120; 
 Fri, 16 Oct 2026 11:16:40 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18319d3b880sm6273831c88.10.2026.10.16.11.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 11:16:39 -0700 (PDT)
Message-ID: <efbcbe66-ee43-4c4f-9bad-9291bae20b8c@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 11:16:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] multi-target: remove dump functions duplication
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 anjo@rev.ng
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qOnB5-LqkCoCMPNQZK962egtplNTiP7x
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad26a0a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7WEKf8L4-7P9FoNF4-UA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfXw5SVazJMiaTK
 gEWnAvcwazR74/mhC+tv/mMgjMxoz1umnnMR2pA+eYM362M209aNEnjdtk5qgc/e1m/gQSidpql
 jTS15JZNQ/7Ia3vN7c/LveKzhe4KJd4=
X-Proofpoint-GUID: qOnB5-LqkCoCMPNQZK962egtplNTiP7x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX0PFMUFKZJdDb
 zefnsyDCyE4DPs7BiCYrYPu9ClbojYFYF+SNs/vMc5jdpU2N5yecO10Zporj1MJfDe3gFm+SWpy
 bPWb6qRRsHzbBhDuDVI+vcT6aOrQA5dvNHSF+Hwr61jJnyLdicSks0AoHPFBa9bZ8iaaRO9XSc4
 xFxMto7BVDAaTf0lTtKb3mWmXz4TMStUY11h96g+LCxCASID0ZGp+XbkmKvXyKTFWlzRzcU5vf4
 /n0zuWGPM3+PX0zkSannFKlsVy7ifpcCVWhR8oniM2K0MSQTLHR74ObUrg1Gz2fFya9KnKIibN7
 UFvA1Cp4IGI22eKqGD0Oxob4aEhh+OUlQlakaIZ2QruS3y6lQ8YrPcS+1JzGPa1Ibv5visvkQMw
 RXAcUdGff3OPWOXTwtIGA5WRxpF4ER0U8wHSU7o2u3Xp1rFB+ckG2CEa2lX1bMazRZ4y0Qy9N4Z
 PfuEy9uZeFeTJHeMyOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/15/2026 2:32 PM, Pierrick Bouvier wrote:
> This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
> target. For this, we define a new set of Dump operations for a given cpu, and
> implement it per target.
> 
> Existing implementations were using first_cpu, which is what we continue to do.
> When we'll work on heterogeneous later, we can revisit this to either forbid a
> dump, or perform a dump for each target active.
> 
> Based-on: 20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com
> "[PATCH v3 00/12] multi-target: add hexagon"
> This base is only needed due to conflicts with current wip, it's not important
> for this series implementation.
> 
> Pierrick Bouvier (19):
>   hw/core/sysemu-cpu-ops: add get_dump_info
>   target/arm: implement get_dump_info sysemu op
>   target/i386: implement get_dump_info sysemu op
>   target/ppc/cpu: constify cpu parameter for
>     ppc_interrupts_little_endian
>   target/ppc: implement get_dump_info sysemu op
>   target/riscv: implement get_dump_info sysemu op
>   target/s390x: implement get_dump_info sysemu op
>   target/loongarch: implement get_dump_info sysemu op
>   dump: use get_dump_info sysemu op
>   dump: remove cpu_get_dump_info
>   hw/core/sysemu-cpu-ops: add get_note_size
>   target/arm: implement get_note_size sysemu op
>   target/i386: implement get_note_size sysemu op
>   target/ppc: implement get_note_size sysemu op
>   target/riscv: implement get_note_size sysemu op
>   target/s390x: implement get_note_size sysemu op
>   target/loongarch: implement get_note_size sysemu op
>   dump: use get_note_size sysemu op
>   dump: remove cpu_get_note_size
> 
>  dump/dump.c                      | 21 +++++++++++++--------
>  include/hw/core/sysemu-cpu-ops.h | 14 ++++++++++++++
>  include/system/dump-arch.h       |  3 ---
>  stubs/dump.c                     | 27 ---------------------------
>  stubs/meson.build                |  1 -
>  target/arm/arch_dump.c           | 18 ++++++------------
>  target/arm/cpu.c                 |  2 ++
>  target/arm/internals.h           |  5 +++++
>  target/i386/arch_dump.c          | 10 ++++++----
>  target/i386/cpu-internal.h       |  7 +++++++
>  target/i386/cpu.c                |  2 ++
>  target/loongarch/arch_dump.c     |  7 ++++---
>  target/loongarch/cpu.c           |  2 ++
>  target/loongarch/internals.h     |  7 +++++++
>  target/ppc/arch_dump.c           | 14 +++++---------
>  target/ppc/cpu.h                 |  6 +++---
>  target/ppc/cpu_init.c            |  2 ++
>  target/ppc/internal.h            |  8 ++++++++
>  target/riscv/arch_dump.c         | 18 +++++++-----------
>  target/riscv/cpu.c               |  2 ++
>  target/riscv/internals.h         |  5 +++++
>  target/s390x/arch_dump.c         |  7 ++++---
>  target/s390x/cpu-system.c        |  2 ++
>  target/s390x/s390x-internal.h    |  6 ++++++
>  24 files changed, 112 insertions(+), 84 deletions(-)
>  delete mode 100644 stubs/dump.c
> 

Sent v3, with all changes requested:
https://lore.kernel.org/qemu-devel/20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

