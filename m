Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5339C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7GA2-0002hx-Om; Thu, 17 Sep 2026 13:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x7G9u-0002VY-0J
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:44:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x7G9p-0001bk-IQ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:44:28 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH5kZu2728652
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=PA+pyKUKmRRRuQbzqiu/nMXMQb6umpeCVcM
 e+qD/HOw=; b=i2b7BlUml6EXKz8MStRMJE7bkvQNtQiZamlixGuGmSUXvNJNKmO
 3vnL8PBcSBxxbHPQWM3Aiaj6hME7zIloZRBb3Go/Anwa001XYK9yV5jq+PXA9Cye
 Ghd3ygQ8RrwNPIO9QPGTSp2gx91WIMPjSnL4CNnuDXr+xesCiwAJt0YyvPOTSFBz
 uw05xz40oT/y3jiW5CgQ49DU/B5NEn1/tRug2TgAo0m5lRo75lQPkVZZI8qhwkRi
 Jnf2UxXdVzuLPPHJpUwYLVpKBzqZzGW7w9upvKbJnn+rKRkNfSfan4HqaAilTf1I
 a5d5SZnLIh+9M1kOoy0ALXli5+I7Y/eLxPA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grfpphpwu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:21 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9123c523d0cso12313066d6.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789667050; x=1790271850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PA+pyKUKmRRRuQbzqiu/nMXMQb6umpeCVcMe+qD/HOw=;
 b=GRwk6OKcFefRlVtUk8lec1W8WFMXcJAqmepRCdyqSQ+EQwqgl5nm0UWeXa+h+bJRSM
 3GPljINqi4zPSOsFpD04zaSur0r8A7bRYNj36wjIpFAPw1+ZCYX6wipZxiYyncBboOL2
 Ouwrk+VaL90fDguOb2iNp3lLfAuafj+mD/V6zPevCJ7TAW/jplyLw3/QJ1jTaMt+Y1MR
 omEFzHISP5xqG+i95UEEodzHQalOEno45v1ykeEOCm7iaX/ILV7f5325kLDeYRiNsSDG
 jyV7dyFYaMRurvj0BT6gRx8nwnCherqyAI/zT10XRC7sLc/mJzbh7Pw7V9M45IQPUoGs
 i0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789667050; x=1790271850;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PA+pyKUKmRRRuQbzqiu/nMXMQb6umpeCVcMe+qD/HOw=;
 b=GEx93H5vzgGXl4VmXfU0+fkspsC0csxJ+1QWSBrBkkoyCX68efDB/OKc9j3m28S9S6
 VZUuK3Nb5pNwaczudWGQUHxSmFM1Tg450JhJZBrNAmIzVy6L1SfkRaVh7T0pSYR5RZgt
 BxfYdWNK4mq3K2TfwSEDIsztA8uTg2t6OEwAWTZNtUkmVF2NGGbPBXuuAarrxzHaqyi5
 hZvk2RSTkYoD3K2mK8k1meo2kbQMkGexyqYMDhwX2l5Dn+kKEue8uZHdKUmmWAyYxASC
 d8v+8A6Oi1AqXUaKDF4r8+dG/PESVeVxEys8e1H0jWrFtGdYd1SYUlQWMeDLKugqTOD9
 JVoA==
X-Gm-Message-State: AFuF++koRGOnIXgXj2UgfW4GDQpn6fTOiv+0M7dqjQfkJf85cgGtivCR
 DIMon40336KHKSE+sWXD6qRJASIv8B8khWf4NU4s62oExQJ23dtLrPZ34sOiRa7xikY2q9WHDzj
 ZHyUr/RAyuNp+C72oiZqpxaG4sXckTndvJM5xOTkJR+XhXnpCeo5AkJ4sWj/4Vc5OcA==
X-Gm-Gg: AYBFou1B726yA4JR/ElV/OiE2Fx1r6pCjcpqCwa5sA5XXrxzO3UjeSb6ff/tzmZHXr6
 UBHGHb7iyrZx9ZQlE4BAk5i9y5Wcc+9V0fPbGfGb5IgYhOKlwsHNp/2QUwyAb6tWjh2LliTDVhJ
 QoI/3o+gqRFNgg93Gtx3yLazD5ZUD4w+noC2v4x1xUbO6QiQYHOOpUM4bMcb1BMB4zWCF0PGUK7
 ldcFvOocV8vZyxkDggCYQSITYxl1dLELbDX/yfoad+5KC/gTCef7RR+RAoQlK/vgJx8YD4R8LQs
 EhnvVGfF4V0WyDVgfIGD0ME+AWPc1/Y7Ul32bJMhCoxuxhmPNVCSWfuKvhvlpsQnKSjOFc9TUaa
 ouHGjjRMjR5le0tre378s/etdHYElg4PcizSUv60=
X-Received: by 2002:a05:6214:634b:b0:912:40b6:d591 with SMTP id
 6a1803df08f44-91240b6d75fmr84321876d6.34.1789667049937; 
 Thu, 17 Sep 2026 10:44:09 -0700 (PDT)
X-Received: by 2002:a05:6214:634b:b0:912:40b6:d591 with SMTP id
 6a1803df08f44-91240b6d75fmr84321426d6.34.1789667049526; 
 Thu, 17 Sep 2026 10:44:09 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.170])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252c56d73sm3118136d6.13.2026.09.17.10.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:44:08 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v12 0/5] hw/riscv: Server Platform Reference Board
Date: Thu, 17 Sep 2026 14:43:59 -0300
Message-ID: <20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fdgk3gOmFK19poDMaub5BIV25-a4JdS9
X-Authority-Analysis: v=2.4 cv=YcYodARf c=1 sm=1 tr=0 ts=6aac26f5 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=arNgJ3JLhM/z8Vk/iMOFgQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=k5snQTODxFSaQZLrqV8A:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: fdgk3gOmFK19poDMaub5BIV25-a4JdS9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI1MyBTYWx0ZWRfXza+scsjMm1ca
 0FB/2MbWM2ZXQmcgse0s8T9elq+O8fj1JwBRSQMWRQmeUdw/tukJVwO55Kc5Ifn1X5H8VHmmd04
 mGQZSJTfN27Wus9hqKoBN30nLPNRioHA3F3imE6ECM15NtrG+m+bvhu+ainGQjnjv5Gau8dUAmf
 Rgd16eFAbHQXrpMaSEeXU+q5rKGS3k1ETFSWrgRS/jJ1cUjRb65ORCaPDw9XAISzes1Vupvmf11
 9WTrms9vVRySK2kWl7rfQKu85xUE+2VG+hB+EiSndums1uo42XkBMOkPpVr7yA/iTprWW/z6iZv
 sZsfSwvDvfopEycZ8ui/uAv0gDSNZj8E3NbDrnz3EMDKxLLhliLYHo0MfXeqAtr+eizggu+Oi2m
 xphmhTV61Pa02a/bwcSrGsTFJOlLK3yUCgTIA2u+w+3oyMp7OqpIug70wb5P6Y6H1TvfUARfbwh
 hWtCXe7Lr+tJV4Eoahw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI1MyBTYWx0ZWRfX2mpLdxidC/mi
 3C6m77GiS8C88VTSwA3Fwm8P9C1Iv0VeLSh9L+InvJUV8nMLwWCWxcNZ79hzI/xjV5HBhJW0vCx
 NfUQEbznnbcvycGaGxB8Evu6XLXGXK8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170253
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

In this new version we have lots of changes suggested by Drew on v11.

The most notable change is the removal of default e1000e NIC and default
AHCI ich9 bus, following the idea where the board should be as minimalist
as possible w.r.t default features.  Note that both can be added again
with:

-device ich9-ahci,id=ahci0 -device ide-hd,drive=hd0,bus=ahci0.0
-netdev user,id=net0 -device e1000e,netdev=net0

So I feel comfortable removing them from the default design since it's
just a matter of adding them in the command line.

Patches are based on top of sdext-v9 patches:

"[PATCH v9 0/7] riscv: add initial sdext support"


Changes from v11:
- patch 2:
  - commit msg: s/trigger-count/num-triggers
  - removed the "N < 128" num-trigger bit from commit msg
  - added an explicit "PRIV_VERSION_1_13_0" val in RVServerRef1_0 description
  - default pmu_mask is now set to MAKE_64BIT_MASK(3, 6) (i.e. 6 counters)
- patch 3:
  - Kconfig changes:
    - changed PCI_DEVICES to PCIE_DEVICES
    - changed SERIAL to SERIAL_MM
    - added PLATFORM_BUS
  - removed duplicated "system/qtest.h" header
  - aligned macros names and values
  - fixed "accommodate" typo
  - removed default NIC and AHCI bus by removing rvserver_init_pci_devices()
  - removed RVSERVER_DEBUG memmap
  - added RVSERVER_ACLINT_TIMEBASE_FREQ 1Ghz macro
  - added .instance_finalize() to clean up the s->flash[] objects
  - added NULL at the end of valid_cpu_types[] declaration
- patch 4:
  - added ahci bus and e1000e command line in do_test_boot_linux_test()
- patch 5:
  - fixed nvme disk command line example
- v11 link: https://lore.kernel.org/qemu-devel/20260909210756.1767711-1-daniel.barboza@oss.qualcomm.com/  

Daniel Henrique Barboza (5):
  target/riscv/cpu.c: remove 'bare' condition for .profile
  target/riscv: add riscv-server-ref CPU
  hw/riscv: server platform reference machine
  tests/functional/riscv64: add riscv-server-ref tests
  docs: add riscv-server-ref.rst

 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/riscv-server-ref.rst      |  64 ++
 docs/system/target-riscv.rst                |   1 +
 hw/riscv/Kconfig                            |  17 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/server_platform_ref.c              | 776 ++++++++++++++++++++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  35 +-
 tests/functional/riscv64/meson.build        |   2 +
 tests/functional/riscv64/test_opensbi.py    |   4 +
 tests/functional/riscv64/test_server_ref.py |  90 +++
 11 files changed, 991 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst
 create mode 100644 hw/riscv/server_platform_ref.c
 create mode 100755 tests/functional/riscv64/test_server_ref.py

-- 
2.43.0


