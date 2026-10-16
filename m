Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63688CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHiL8-0001fH-Tn; Fri, 16 Oct 2026 09:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHiL6-0001ei-At
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:51:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHiL4-000378-Et
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:51:16 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GAANMM2496907
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 13:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aaiMzdN1FsAMDpjCoJ/kd+lYlLRQUSBvNZtGlnn0IvM=; b=pPrDeSBhH2nGbyOF
 1jUg79meTVM/JIo5nl4OxEHKgVybjTboO+tJkFdw7UmoZvV6ee/YZ1r2zq5VAEuP
 sAWa26kfkXhB1yxGvI0Fhh3eHaYoy9dqwy28d2hXUgJViVXPhcmV9D6gjaMYJ8yF
 3CACgvcsQJsnGHNH3pcUR322YCII624ALnL6mgN9x7VBp2aqdFM3yCgMIIw0kleX
 r5ddF8c7iiRhin+r6REftGChWq3iOVAVSAvwqFQPE4g2kMt83NzeOLFYS/2CTQ2l
 y4d/kW317v22Jb7KUEHxxfXlQn4vKPfadp21K4NIclZ6jfD1/gKe9P5cwk8gF5dJ
 uVAkgg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa401v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 13:51:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ea8067974so1510734285a.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 06:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792158671; x=1792763471; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aaiMzdN1FsAMDpjCoJ/kd+lYlLRQUSBvNZtGlnn0IvM=;
 b=YUa4ysl1m31p28+LC3Sq93gc16Wm6criwX8KTtZmhnCKGhH1Qec8X5TGbf9hWB+XZy
 JOhyQwADfdQ2h3sMOUXVhRW3a65z1n5Idwnu6D6H/mwzFw1Hm4KTXkIrR828xkD6Kiqy
 JZMYWfAFAc7/PG52isZgmyEEV/3/vlskVGOVXVlh9CI8/dakyV/VrTi9+NbC2AJU2RST
 s1fUE3koPCPjre1nfOI0L3kP88UlVlMSR9Hyq77JaPipI4uCLCI+2zxpvQD3hX4duhbH
 C+Zgo10xnjAHNB98aUZcjrmt3RFYC1nQUsV5BVVnO2XRKFT1B7H1hIrvhrEacICyeZs9
 FA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792158671; x=1792763471;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aaiMzdN1FsAMDpjCoJ/kd+lYlLRQUSBvNZtGlnn0IvM=;
 b=2xUIGqV3IVOCGkUdhpzz3BOkGGZ0ChQoO1Q1EOC9tMKK8kSf/5qCmLiKBY+AofSnxQ
 8wy+9LYgu2bOQYyweOQAfLbMKNOw5rCVjkFqN4G4wlZW6qup1v1YlGaqLW78umBbHFOB
 XSS4acCBjABaf+16Cm6JqJX1AD25+qqb4TgqsTBV2gmZs++Re1UddKidyjg/2ie1olv8
 NOFMbFY8+tiZg/ZMRj73uoKlaH0fg7uEDIW/BYFOFfKY8KoIWjm9MNrY6nuX5wjxtMAt
 7Z0TZgGHJo3Bw6eintpNUxSSMTNq/qAMgH6EqJTPXevmnby6Xcn//CRkjLDZdmvXpqso
 S/IA==
X-Gm-Message-State: AFq9FYJsBvn5bkIQkJ2ShQ4deKNJasedh4wg3yUDAYcccU5oyNTxeRZw
 so62D6VXuIDSzjBTgcTyPSKoQNZaiyb2y9BrzjGTdLE1VP+UkFirT1ApAQfJbod9HFznebTtfWm
 VGfiv21bwDce8szZgCg+Fu6bpSHNnJocppFbbGvfjl/JHc7HkCaBhSz5hig==
X-Gm-Gg: AYBFou3HHebAZQbQL1GOBYRtSeFRliOIY+5MY2swK6w970YaOn3vOBkxagDcqOgg8Xz
 e/FCjktF7edjVwdzEDLaeSaln1YVzVqpG7r8jXE3QD2P+ITKmCL9eAd/c98TWOUthCKcXyx+3Pw
 PAseY/W/EEFiMkzfAd72XRpKoBHvGLdzIWzC6SPE13OFUvsizpHZeWDO06qnCj/dCstlySTusIv
 XW0qqXwilKBR1cOEEFSbFey0h5jXnUJCOM3v0o+oj+eppqZvhUZlNZ0j2JHbv45TncsvpNyIoZd
 V7k8QNYY0c+VLOky7eRYbi/Xye/sb+8wYrJLoD9EWCHH3m1054cbtirPwrXxb3q5vbwmWwDUV3a
 KsOnINQ3ASL5lzXBGrJoQtWAwZgAzDvMIu1ZtTRezVR8+rLSUSrCCkqYkm8Y03x3j
X-Received: by 2002:a05:620a:2248:20b0:93f:11ee:ba5f with SMTP id
 af79cd13be357-93f11eee5edmr579330685a.79.1792158671047; 
 Fri, 16 Oct 2026 06:51:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2248:20b0:93f:11ee:ba5f with SMTP id
 af79cd13be357-93f11eee5edmr579324585a.79.1792158670463; 
 Fri, 16 Oct 2026 06:51:10 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f1a1690fdsm216994685a.11.2026.10.16.06.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 06:51:09 -0700 (PDT)
Message-ID: <077274ba-002e-4241-9158-13a3270bddaa@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 08:51:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target-info: dispatch CPU QMP, dump, monitor, and Angel
 semihosting
To: luoyonggang@gmail.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Song Gao <17746591750@163.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>, Philippe Mathieu-Daude
 <philmd@mailo.com>, Xianglai Li <lixianglai@loongson.cn>,
 Chao Liu <chao.liu@processmission.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261015044104.879-1-luoyonggang@gmail.com>
 <CAFEAcA8n9E1jpcOCat0kzv0Q++x7YwK_MNJBJ0qGdtX1-As4zg@mail.gmail.com>
 <CAE2XoE-fgq_c9qONyvfbNi3Ys_hv7yKvGCkk+Wz+rHPW0p65Eg@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAE2XoE-fgq_c9qONyvfbNi3Ys_hv7yKvGCkk+Wz+rHPW0p65Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NSBTYWx0ZWRfX0yQrcCyKRoou
 7g+balpfuUK85DzIdrpXHr6bm9RsKX4m9is/z9wf6B4FmVEe6H7bVLJ5JYvynBUBnleV3XhwwOc
 hbSyMwc4WIZSJEcpaKAsfoHw19/yntM=
X-Proofpoint-ORIG-GUID: _Z6d_4p7qnm5SoyzevYu9pP6j8ouma1q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NSBTYWx0ZWRfX9BSEJnCqC+Sq
 YefNsqp2j7CAB1O/8ZHRXNCCxaDBR3xVMhuWtQAkFFYoa/62Ow2GFMSTjb1FhML5CLf1r8pXsiJ
 oaUlP04X4rncD4toOsa9C/NsJCC43oBRb+CeTrsen1D3djLKU1ppyg79+tnpM2ykeKHlIr2LHod
 NX1yaWifXmYsb5uXpKK31lPlG/7QlEqkuxPyMed2h/g5gVqOZmGb2czZpicNePVjgEdmW5AY5dz
 DA2DzJom2BQgslbalaJbDvLu7h94ne/WZrYNHrQCokdYg5g2T+WBM2pooym7Rckig0hIND9ilst
 itgZogqz2v1bxfaNTPB3S84H+rCqel7T4MoNnlzXylcFLmDNKUrEC7V3fuNRgodE0CevAB5SNgj
 LIvr+WF7493/fLEvk0t6eVY/roAr5ijZFMs7w0vbAOwCpjNs6rOjEpxFsccJcQYyOb4qu6J91UJ
 auANl0PwcLKqo2YLYrA==
X-Proofpoint-GUID: _Z6d_4p7qnm5SoyzevYu9pP6j8ouma1q
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad22bd0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=X7ICM6PgokHMk0l1ZBYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160055
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/15/2026 4:38 AM, Yonggang Luo wrote:
> On Thu, Oct 15, 2026 at 5:20 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>> On Thu, 15 Oct 2026 at 05:41, Yonggang Luo <luoyonggang@gmail.com> wrote:
>>> Put query-cpu-definitions, dump notes, monitor, and Angel semihosting on
>>> TargetOps[SYS_EMU_TARGET__MAX] and look up by target_arch().
>>> Keep the table in target-ops.c and with a stub
>>>
>>> - Register with a QEMU_ARCH_* bitmask so shared base-arch objects
>>>    can fill both slots (e.g. QEMU_ARCH_ARM is ARM|AARCH64).
>>> - TARGET_INFO_CPU_OP is type_init. A NULL member means no handler.
>>> - Drop stubs/qmp-cpu.c
>>>         stubs/hmp-cmd-info_tlb.c
>>>         stubs/hmp-cmd-info_mem.c
>>>         stubs/dump.c
>>>
>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>> ---
>>>   MAINTAINERS                           |  1 -
>>>   hw/core/cpu-system.c                  | 23 ++++++++++
>>>   hw/core/machine-qmp-cmds.c            | 27 ++++++++++++
>>>   include/qemu/target-ops.h             | 59 +++++++++++++++++++++++++
>>>   include/semihosting/common-semi.h     | 63 ++++++++++++++++++++++++---
>>>   meson.build                           |  1 +
>>>   monitor/hmp.c                         | 25 +++++++++++
>>>   stubs/dump.c                          | 27 ------------
>>>   stubs/hmp-cmd-info_mem.c              | 12 -----
>>>   stubs/hmp-cmd-info_tlb.c              | 12 -----
>>>   stubs/meson.build                     |  4 --
>>>   stubs/qmp-cpu.c                       | 21 ---------
>>>   target-ops.c                          | 49 +++++++++++++++++++++
>>>   target/arm/arch_dump.c                |  8 +++-
>>>   target/arm/arm-qmp-cmds.c             | 15 +++++--
>>>   target/arm/common-semi-target.c       | 26 ++++++++---
>>>   target/arm/meson.build                |  7 +--
>>>   target/hexagon/common-semi-target.c   | 26 ++++++++---
>>>   target/i386/arch_dump.c               |  8 +++-
>>>   target/i386/cpu-system.c              | 12 +++--
>>>   target/i386/cpu.c                     |  6 ++-
>>>   target/i386/monitor.c                 |  8 +++-
>>>   target/loongarch/arch_dump.c          |  8 +++-
>>>   target/loongarch/loongarch-qmp-cmds.c | 15 +++++--
>>>   target/m68k/monitor.c                 |  4 +-
>>>   target/mips/system/mips-qmp-cmds.c    | 15 +++----
>>>   target/ppc/arch_dump.c                |  8 +++-
>>>   target/ppc/monitor.c                  |  4 +-
>>>   target/ppc/ppc-qmp-cmds.c             | 15 +++----
>>>   target/riscv/arch_dump.c              |  8 +++-
>>>   target/riscv/common-semi-target.c     | 28 ++++++++----
>>>   target/riscv/meson.build              |  4 +-
>>>   target/riscv/monitor.c                |  4 +-
>>>   target/riscv/riscv-qmp-cmds.c         | 15 +++++--
>>>   target/s390x/arch_dump.c              |  8 +++-
>>>   target/s390x/cpu_models_system.c      | 15 +++++--
>>>   target/sh4/monitor.c                  |  4 +-
>>>   target/sparc/monitor.c                |  4 +-
>>>   target/xtensa/monitor.c               |  4 +-
>>>   39 files changed, 428 insertions(+), 175 deletions(-)
>>>   create mode 100644 include/qemu/target-ops.h
>>>   delete mode 100644 stubs/dump.c
>>>   delete mode 100644 stubs/hmp-cmd-info_mem.c
>>>   delete mode 100644 stubs/hmp-cmd-info_tlb.c
>>>   delete mode 100644 stubs/qmp-cpu.c
>>>   create mode 100644 target-ops.c
>> Too big a patch touching stuff all over the place with
>> insufficient explanation of what it's doing or why.
> Oh, sorry, I post is just for demo(DRAFT) for other place to
> reference, but git-publish have no way
> to title it(maybe because I use it wrongly).

git publish has `--subject-prefix=PREFIX` - that will let you qualify 
this as DRAFT/RFC.


>> thanks
>> -- PMM
>
>

