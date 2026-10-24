Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E04B606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DdKv5Dsx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YNOXYStQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKPG2-0002Zw-Db; Fri, 23 Oct 2026 20:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKPFz-0002ZU-Eo
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:05:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKPFw-0001GT-Cj
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:05:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLv1lK3116026
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vDpSj5pvSv1dVJu84V8GQt0GugkjKdpxPD5J/deaihs=; b=DdKv5DsxEwZxc8+d
 HcswwMRikmeOpG8Ewb31s3PMduS8nvpFjR8TeaHHZQUjh2PuukSftBwTdjElzqie
 7SjuyYqydIE4SpMTtCY8IbhSu1Z8FV9nAG3Uc8czq/O5F92c8XDIUnff5lGtgYXP
 6c0ufIvjlBolmunpdX79EmvYaRVf4ZcJbJHWSA4S7XMaWg8Ml3VL4yoVGDNxET6d
 EUf7uaOd1dKlZ/a9Y/R01M+7h9Ay2RkACRV/iBdVvLcMJrJxgyCqmDFdWBkOPHSY
 cBnujtbM3w50HwxnFRmv+t/WKZG8UgCZ7K9CTvoFArZbsjkx0L0QZb8yqkBHkP2e
 RXBBMw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcrt8y1e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:05:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510d0baf63so3448000eec.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 17:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792800302; x=1793405102; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vDpSj5pvSv1dVJu84V8GQt0GugkjKdpxPD5J/deaihs=;
 b=YNOXYStQtWCuc/uOW0cP8yho1AgLpWZCsr9Untgtgjy1QDSW2trcLpDIypoT94LRfh
 dZxECSA2Xe3Ir2DPgrPw0oJJGtpGbRVEG1PYwXJAEz5WDXB7RZdms2ubU0BliGlOP7cT
 RBTqyoCumW51XjUxlu3+DzF0dBv9pQRhRnk7pg42EG/rWJDeBm+87gLNhc0T5afbWY3e
 JTjQzP/Al+W7aqG+Rehwyp8J8/96YWg3gMBvvbQ7605UtCsT8wrcuCKjZYgR0BHbXEqV
 OIaug8FGW+k1Pzo/Xlh6d6qP2AEO69n9NYBWSZj2WuhE93hO1cgdU198bjlMsu0frcjk
 rcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792800302; x=1793405102;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vDpSj5pvSv1dVJu84V8GQt0GugkjKdpxPD5J/deaihs=;
 b=muHA8xC8zFP3iYHtKKKSNgruu79OqN3Q/Z4Te4RW6GlelJOjEan4iPCwJqTmjUfzpo
 1d8CUlbSd9knkt/9L3jPHgBWkJvdTUr7ATM1KDRLproeTgXN27h3CL8UyNVa9xF6S8Od
 WOMmEnG3BjYIHV0eNubU4qqtfaQHA2IBBg3h/1x2naM/6+K4s1JeYAsKL8A2ZSx+vyv3
 m09Z4fbNjFoc/C9gKF3HVJf5VSyvQgmP2oyvnnpIhvo2KnIGLyWyw4AeT0VGiXF8usNG
 JneETwkM7vEP/X3Gs5uOIOa4mTjkGCB8/e5BciHui6eRKePc7pigdHp/usgqqKEpmCft
 WXZw==
X-Gm-Message-State: AFq9FYK3w+IdfWPdOswZH5kOD83d5euo1srOuSEThjgNBEOMACTx1uym
 dpl7+UGmP0sHfgfFu4ckRU8bVoxI7eV9U2Y7pZfQmFxHwdAy5H1kG5X6fZ+t9jyvnu68zBjfbuW
 M29xdYHeI0fPGlpf15QwMZU9+yamJpOS5ONuq9Dm4pLQpaLvba4uSyU3tGo5CZfyuKQ==
X-Gm-Gg: AYBFou22guHwmyIfWP72HjSmfr9GlR72XGKJa6pPUfBVxKkPkmUVSyhrvqyKpp3xBG+
 tQ7WoQ16V+HhfImybGQOm20FVzQfb1g41ijX4h7WEYSgs8qAyi+cwMAugl9b6UspBNWGpys98ZQ
 UQtYFiFes5C9KUNqp1ecyAfUAo3oQebUYQmuaOMHMI5hdoqNJ+tn9K5Wi2pqiEtWvTX/GWsXF2B
 TBnIiLtD9Dm+DOYuA2MJh/GwRMt210qr/DRnc0ZNTx2osLnciWb5lEjP0AyMIXyluRDZJZ8BTty
 5jIACFc137Wlr+blKEynxuSKhN/2VXRmsRBCIL4LXdSblKtl1YRSYIY6Lh19lJov7r2bP164uy4
 l6xsF2PkZhIqFd5g4OjH6ozmWEqj3DVse88OzT2ZWuE6Wa6SJ2vTgt2xwpfSfaeTDQohb2g==
X-Received: by 2002:a05:7301:514a:b0:343:ff9f:26f3 with SMTP id
 5a478bee46e88-369e842b597mr1037214eec.9.1792800302200; 
 Fri, 23 Oct 2026 17:05:02 -0700 (PDT)
X-Received: by 2002:a05:7301:514a:b0:343:ff9f:26f3 with SMTP id
 5a478bee46e88-369e842b597mr1037168eec.9.1792800301406; 
 Fri, 23 Oct 2026 17:05:01 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db450bsm1473181eec.17.2026.10.23.17.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 17:05:00 -0700 (PDT)
Message-ID: <c69390c0-1e25-4639-ac51-b46f1929bad2@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:04:59 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/21] multi-target: remove dump functions duplication
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwMCBTYWx0ZWRfX3ZZg8r0Z0ih+
 ud4NDx3Jt5LJ5Mutj96DMg3qUBTt5SverAcbLlwNkKFI9IR34lJMk+U6hYzfE7gZvSJxoV7LhFU
 OCCQ+j3cpCX2Zykto/GusRx9nnpUiT8=
X-Proofpoint-ORIG-GUID: 5xS-Wdh-qTmzwQiBK6mbh5ugeEF54DIT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwMCBTYWx0ZWRfXxFSX5A75HzyZ
 o/NwPMeyrjypreImNbfYh+4Vx8CMabsrm/oxyH2yAaLy7fdLdCFSZHBFT2Yib9bdzhWI/btUaV0
 /SPI5SUct0IeN+NVgVhszyLFmKo4aTWXM7jfiUE3Lp5amVcHdVlw1jW/N3OTsIbiIUXLuhc0spO
 RyKkHNsoDreQmeC7zjS2OWCGHWw0e9wG/16eMS24bUqP55EqCsDFiFuaru5gbBDILBIPidD4Evf
 tjc4/w2209XC8JB3Pc1KD11rhz+Uo1UBg9EMJktZKWd+BQtPqAaTGCteFgZuEfbgMEZL5U6EdIn
 L6XLcBqrDwdoDcXESfPTQmtXZbM9WLavfjqy8/XTQaxei8KF25MSFwP/4XNrBTT52ZfTKTMxwPm
 1CbrZGddBy/dTXCfx7PHqX7+w5kyhfsvX6Xl/G30i58ohZI+fxUsUTLIYBFAOCfs/b0yyKIJXi3
 5+TUVelV0C1JXWGP3sA==
X-Authority-Analysis: v=2.4 cv=E7lYNqdl c=1 sm=1 tr=0 ts=6adbf62f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=FEzH-yfZ0SP5dq0QMlYA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 5xS-Wdh-qTmzwQiBK6mbh5ugeEF54DIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240000
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/2026 11:12 AM, Pierrick Bouvier wrote:
> This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
> target. For this, we define a new sysemu operations for a given cpu, and
> implement it per target.
> 
> Existing implementations were using first_cpu, which is what we continue to do.
> When we'll work on heterogeneous later, we can revisit this to either forbid a
> dump, or perform a dump for each target active. Meanwhile, add a check if we run
> heterogeneous emulation, and refuse to dump if that's the case.
> 
> v5
> --
> 
> - remove redundant typedefs for ArchDumpInfo and GuestPhysBlockList
> - make new sysemu op infallible (get_dump_info has no return, and get_note_size
>   return size_t). Keep fallible global wrappers.
> 
> v4
> --
> 
> - define global wrapper for cpu_get_dump_info and cpu_get_note_size, both using
>   the sysemu op we introduced.
> 
> v3
> --
> 
> - riscv_get_dump_info: add const to riscv cpu
> - use forward decl for ArchDumpInfo instead of including system/dump.h
> - use forward decl for GuestPhysBlockList instead of including system/memory_mapping.h
> - update comment for get_note_size sysemu ops
> - add target_heterogeneous to target_info: returns false for now
> - edit commit description for dump_init changes about why we can have first_cpu null
> - add target_heterogeneous check in dump_init
> - rebased on master (previous "based on" is not needed anymore)
> 
> v2
> --
> 
> - Add new ops to existing SysEmuOps instead of a new DumpOps.
> 
> Pierrick Bouvier (21):
>   target-info: add target_heterogeneous
>   dump/dump: do not dump machine if doing heterogeneous emulation
>   include/qemu/typedefs: add ArchDumpInfo
>   include/qemu/typedefs: add GuestPhysBlockList
>   hw/core/sysemu-cpu-ops: add get_dump_info
>   target/arm: implement get_dump_info sysemu op
>   target/i386: implement get_dump_info sysemu op
>   target/ppc/cpu: constify cpu parameter for
>     ppc_interrupts_little_endian
>   target/ppc: implement get_dump_info sysemu op
>   target/riscv: implement get_dump_info sysemu op
>   target/s390x: implement get_dump_info sysemu op
>   target/loongarch: implement get_dump_info sysemu op
>   dump: reimplement cpu_get_dump_info using get_dump_info sysemu op
>   hw/core/sysemu-cpu-ops: add get_note_size
>   target/arm: implement get_note_size sysemu op
>   target/i386: implement get_note_size sysemu op
>   target/ppc: implement get_note_size sysemu op
>   target/riscv: implement get_note_size sysemu op
>   target/s390x: implement get_note_size sysemu op
>   target/loongarch: implement get_note_size sysemu op
>   dump: reimplement cpu_get_note_size using get_note_size sysemu op
> 
>  dump/dump.c                      | 14 ++++++++++----
>  hw/core/cpu-system.c             | 19 +++++++++++++++++++
>  include/hw/core/cpu.h            | 24 ++++++++++++++++++++++++
>  include/hw/core/sysemu-cpu-ops.h | 12 ++++++++++++
>  include/qemu/target-info.h       |  8 ++++++++
>  include/qemu/typedefs.h          |  2 ++
>  include/system/dump-arch.h       |  9 ++-------
>  include/system/memory_mapping.h  |  4 ++--
>  stubs/dump.c                     | 27 ---------------------------
>  stubs/meson.build                |  1 -
>  target-info.c                    |  6 ++++++
>  target/arm/arch_dump.c           | 22 +++++++---------------
>  target/arm/cpu.c                 |  2 ++
>  target/arm/internals.h           |  4 ++++
>  target/i386/arch_dump.c          | 14 +++++++-------
>  target/i386/cpu-internal.h       |  5 +++++
>  target/i386/cpu.c                |  2 ++
>  target/loongarch/arch_dump.c     |  9 ++++-----
>  target/loongarch/cpu.c           |  2 ++
>  target/loongarch/internals.h     |  5 +++++
>  target/ppc/arch_dump.c           | 18 ++++++------------
>  target/ppc/cpu.h                 |  6 +++---
>  target/ppc/cpu_init.c            |  2 ++
>  target/ppc/internal.h            |  7 +++++++
>  target/riscv/arch_dump.c         | 20 +++++++-------------
>  target/riscv/cpu.c               |  2 ++
>  target/riscv/internals.h         |  4 ++++
>  target/s390x/arch_dump.c         |  8 ++++----
>  target/s390x/cpu-system.c        |  2 ++
>  target/s390x/s390x-internal.h    |  5 +++++
>  30 files changed, 165 insertions(+), 100 deletions(-)
>  delete mode 100644 stubs/dump.c
> 

This was merged into master (3745b15e090e3dbcfcf28fc96928abba8fd2ed2a).

Regards,
Pierrick

