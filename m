Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FF8CA5FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxwi-00019x-Cf; Wed, 30 Sep 2026 13:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxwe-00019R-Uz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:18:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxwc-0006YJ-7o
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:18:15 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UFX98P194739
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RniTDDMG82IEM77nUIb7XymL4YdAieiaVPlgPhw0huA=; b=Nsdzey3t0Fl2hyau
 zrKizND1gbF9HDySAdzCjAlr4MIt219HG15w3ewocZuAUte8QmT37O8oUYreEJEU
 f9HL0SQZHktYS8G/gHh/3EzCGvbMF3eXP4XOuxnbGbcGzb1fpDhqIZw2WCLMAJVs
 beizXZegtUegrmMVKY+KT9qjNLnk7kg1i1mQrfMbbTKMuiSHQ6OMcE/sy402y5ve
 9av0hlWNqB2CelihLaz1JgX5Hk9Gze44fwP2lYYZRwS8PFFLBco/al+2eA3SPowh
 njZfgbB5F/WBWep4VKXsVuzcvdBrjz6zjeo9im5EtDDCYio/YKQo8qmdMSRkw9rj
 hBqHRg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h155vrg2s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:18:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939c30aa9a0so595989585a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790788691; x=1791393491; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RniTDDMG82IEM77nUIb7XymL4YdAieiaVPlgPhw0huA=;
 b=fpb1z8E6+Ou/kBofVF66WAz75H244sbBLlwaVRZC75wqofIZ+3xTgbbLlLispyi4pF
 JkOJ5o2JOS0N8Qk+oMbfWBLsUwEy/2OiHyTMWIYmiONbCemySbdaDukzdxCrIP2IQ0Kn
 f3Qzdf3PuZi03JdpVCCt0j3OUiV9cKrHWVvbD+zfd8P1ec8EpTXasFluFDV0SzLLlJvZ
 5EHQD5mGcxa4qodIA45gI+yN34kvXsheUMOK/MwVdxus6EiRuLFm3uL5H/u5QuVh7m7S
 tb6VVEG4oKdF9pk/a0fo27y7lKc0yuJ5RZAZeLB0NRQHPt1CkFtHfNeYFU3JKl9gRS4B
 683A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790788691; x=1791393491;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RniTDDMG82IEM77nUIb7XymL4YdAieiaVPlgPhw0huA=;
 b=jzQ9sP8PpE/6iwfiY7FqUuhYAb1zewka2DuBheUliGLAhodTYLNWO5q99Gb8WyYO3A
 P1fQHo9dS3HUFSRx6JtuGuOPzOM5wMpPMlNcSeeQVvS0bFFOcJjCzzYwqw+6MO+5uHrb
 Mqq3WnGS0dQYRqT1mPfuR/WSyVwrBqKyuR4WJwzSuj6RQgPSnjWPaZdupWvNOtGgHuXQ
 Ub1aVWNIVwRApb/xB3y8uJ1DOkqSfabadXrGZsJAeCF3zSOYXxHCiOoxQIftkrqKnQRM
 GgqHniAkAoVnHuMk4yb8ZJIwTogbBQuWlSasc/BRYg3YcYV8E4MnoErRrJvhKVqkbvv2
 PABw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiiDkWPiHHt6b1hCqHjh1bL5jb3EvlTGZRxUxtR/WbeDThqfcePvN4/muvPmSlBQm8djil4ad+yo5A@nongnu.org
X-Gm-Message-State: AFuF++lbhPUHmJNCcziS8VCiugMLQl/pJwGpHu1jXNrg5A9Ktxwf8Nfd
 IVz6zchFjOPhUeNWf6XNl11g5XleztMt3SCeKdTGmrr/9wa8t6s1MVROGh17jmFHAahmDGHonwO
 M4K0jkCT6it2kRnNJip9O8DHDmgz7sbm/0Jbu9w00zbWFAUhM9VHecagUjw==
X-Gm-Gg: AYBFou0PkmO3wckPpnPl65twxgTdMqXiurc3zd+dUIVP2/+iBMkqgpEZUTqIZudmaEv
 lA0Y5rm4dfJ5cqmaaMDcSx4dVfvfYxqci5TTa2BC+HMOCMx0j6FexwXu9vitLptucZhf5HhUDr4
 RmiMTJ/YrnVxtCCKbh0a8qjEkFYwH8AYQVOQiqBPhBEAk8mnmVhsJUlRhPfy5iAxYEMY9LR/Dcd
 QWh7CBwOT5cDpv6wbjg7RyxaJxvJtqZiwF6a2jY5cuhmr0ZsTF609CrgefU2yueUHlvahCeLgAC
 lctj87Zy87QToZB1uSlkH9xvE5GZ8Xeicms2e6R5l+AnT7l26c+t919+Tj1j4BCtEMiRDuaBH5M
 95e7x2G/dloQXWwdG/gGRnafLEB1LnuEmXA==
X-Received: by 2002:a05:620a:2728:b0:93c:a709:e8f9 with SMTP id
 af79cd13be357-93ca96930c9mr372356085a.22.1790788691109; 
 Wed, 30 Sep 2026 10:18:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2728:b0:93c:a709:e8f9 with SMTP id
 af79cd13be357-93ca96930c9mr372349785a.22.1790788690589; 
 Wed, 30 Sep 2026 10:18:10 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01cb8abc1sm10313645e9.0.2026.09.30.10.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 10:18:09 -0700 (PDT)
Message-ID: <1b9d9cef-8f65-4e96-9e7b-fd136f64a75d@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 19:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] monitor/hmp: replace MonitorDef with GDB registers
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX0ytmcQnSYN3d
 coQcKMDQKWTvaV7nb7Ur43t2bQaNVsz1l/ZLh2DxrE6Id/RMfQsoBcrLyaltqnpq3UgcO5Odtun
 pyI+FBWBP7m4lDoI1CGjlbfZNygqTsA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX4tTcK/zifJy5
 CGIM8DSkbyQVxe+JI/IpHaAeLUxbfWlsp6PYcegYe3hGpbYMZ9pt4Z7tvJYJT1VjV9gm/HbzQ1O
 eR6EJtfd9/fW6mfcmzmcsUQ84njT87xf16BW61R48s1if78UBNfSd9Gy0KHA+KbNf7NguNxNyVO
 4KMiWzOnsv+e2wYhAznphS7mASeNxJyntdjv5TBAYPcUcuHi8UD8uOQ3QBJLoQHAaWYtIRK9+Zs
 Xlbi6NwOCgRDVebzEEyIauHdUCxurTamA6tJVXlYGjgvhrBQZ3GKY0S0ZwO3DZsGQrhbaNJcsl2
 aAxHDbl9FAWUKyu8nWYngExZSBbaiEl7TseneN/tgPDLWqyIrhReZzbQoEvK5Ya18Wu9CacBZq8
 6arqdxO2+NOpj4MKRE3LqiL/Ih/+sirACbnuaGBikThnvShQev/QeoD/fqcj/NzgIZUJvZf+U/O
 1O9yHxS9jKycbRvLB0g==
X-Proofpoint-ORIG-GUID: 0P-z7Av1dcP2ZjNyWz84dNOajZHe25cE
X-Proofpoint-GUID: 0P-z7Av1dcP2ZjNyWz84dNOajZHe25cE
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6abd4454 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=DDMjwm-puq-sXqiEz9gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300068
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

Cc'ing Akihiko who worked on gdbstub.

On 11/9/26 14:27, Marc-AndrÃ© Lureau wrote:
> Hi,
> 
> HMP monitor supports printing $register expression. The lookup
> was done via GDB stub registers, and supplementary MonitorDef
> HMP-specific tables.
> 
> Migrate HMP registers to use the GDB infrastructure and remove the
> legacy HMP MonitorDef. Use a "qemu-debug" register group, as they are
> aliases or synthetic registers, but gdb doesn't seem to care.
> 
> Known behavioural changes on RISC-V: CSR lookup is now case-sensitive
> and vector registers now report "unkown register" instead of a
> target-specific message ("Unable to print the value of vector vreg 'v0'
> from this API")
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> Marc-André Lureau (10):
>        hmp: don't crash on invalid register
>        gdbstub: fix next register base after register gaps
>        gdbstub: set feature->base_reg for dynamic features
>        target/i386: expose segment limits via GDB
>        monitor/hmp: add CPUClass::get_pc fallback for HMP $pc
>        target/m68k: expose system registers via GDB
>        target/sparc64: expose system registers via GDB
>        target/riscv: bypass smstateen check in debugger mode
>        target/riscv: expose register aliases via GDB
>        monitor/hmp: remove legacy MonitorDef infrastructure
> 
>   configs/targets/i386-softmmu.mak          |   2 +-
>   configs/targets/m68k-softmmu.mak          |   2 +-
>   configs/targets/riscv32-linux-user.mak    |   2 +-
>   configs/targets/riscv32-softmmu.mak       |   2 +-
>   configs/targets/riscv64-bsd-user.mak      |   2 +-
>   configs/targets/riscv64-linux-user.mak    |   2 +-
>   configs/targets/riscv64-softmmu.mak       |   2 +-
>   configs/targets/sparc64-softmmu.mak       |   2 +-
>   configs/targets/x86_64-softmmu.mak        |   2 +-
>   gdbstub/gdb-xml/i386-segments.xml         |  14 +++
>   gdbstub/gdb-xml/m68k-system.xml           |  32 +++++++
>   gdbstub/gdb-xml/riscv-32bit-alias.xml     | 105 ++++++++++++++++++++++
>   gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml |  40 +++++++++
>   gdbstub/gdb-xml/riscv-64bit-alias.xml     | 105 ++++++++++++++++++++++
>   gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml |  46 ++++++++++
>   gdbstub/gdb-xml/sparc64-system.xml        |  22 +++++
>   gdbstub/gdbstub.c                         |  14 +--
>   include/hw/core/cpu.h                     |   2 +-
>   include/hw/core/sysemu-cpu-ops.h          |  16 ----
>   include/monitor/hmp.h                     |   6 --
>   include/qemu/typedefs.h                   |   1 -
>   monitor/hmp.c                             |  52 ++---------
>   target/arm/gdbstub.c                      |   8 +-
>   target/arm/gdbstub64.c                    |  10 ++-
>   target/i386/cpu.c                         |  32 -------
>   target/i386/gdbstub.c                     |  24 +++++
>   target/m68k/cpu.c                         |  22 -----
>   target/m68k/helper.c                      |  47 ++++++++++
>   target/ppc/gdbstub.c                      |   2 +-
>   target/riscv/cpu.c                        |   1 -
>   target/riscv/gdbstub.c                    |  52 ++++++++++-
>   target/riscv/internals.h                  |   3 -
>   target/riscv/monitor.c                    | 140 ------------------------------
>   target/riscv/tcg/csr.c                    |   3 +-
>   target/sparc/cpu.c                        |  19 ----
>   target/sparc/gdbstub.c                    |  38 ++++++++
>   target/xtensa/cpu.c                       |   2 +-
>   37 files changed, 562 insertions(+), 314 deletions(-)
> ---
> base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
> change-id: 20260910-query-reg-80cd59cf4707
> 
> Best regards,
> --
> Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> 


