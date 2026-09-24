Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3413C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lJB-0001ks-Cq; Thu, 24 Sep 2026 11:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lJ9-0001kh-Ku
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:24:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lJ7-0000D6-Eb
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:24:23 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4gHG2594263
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=yaeZSEgPU218o3dxfE2k9p
 fW7HNSWwmX0x0IUXOj6zE=; b=JAZjj+qJuALwGVbwpsg5KOdCvNFXpUeSDCzMdi
 4hGjWaOqegtk/mcd30ZS/gBtU7jpXENKQHJccC1Q38fTtXhp7flUuiEQ+LrSv4yW
 WfUMF0Ner4eN88+KKAo3pDRpAbljlXbei/+9Jt0gFieHAnsqCNy+QcBgvlbu1M1Q
 N3paPd5OEOdPiJG9nPsfWu6WW7AT8AFuI7zgLUI9c+NCbQza5PMSfw8m/zGBS7Hf
 ic4IJuCIrcPNPKwi99XFJZ50JfISqq13EXhf7qZrUYtBtoNalDnBscB40PPeLMpb
 yh3knurCUgD0dU2GO5oUPxr6+qdQT26kPGdfbgKSQIVXFefQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjh8pr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:24:18 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c82f879767so2685652e0c.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263458; x=1790868258; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yaeZSEgPU218o3dxfE2k9pfW7HNSWwmX0x0IUXOj6zE=;
 b=Usw1mcdbvjto6vZhwBp/mYfukVLunwZztZUrnaSyE+JNlE2P2AZgfHeLPpyK+dYIkz
 uATxBvBnP0Dyxg6LUzo4k3x4FeA3a185aDL1abBK3wY9dNmALDRm9IPaLb9YgSpphDxQ
 O/+1mj0VPequyN+C2X2A3X431KUw6lJriL8Q/iD5k4sZN6Rx5CYPTHOX9v0dHhWNvpmp
 rmZ8WGzz1vFvPlzKYrdKB+MuYKVeTeHTcHfo2lAUwUNdy2Hms94VGxiWPRK0gneUUebQ
 R6qoxq6hkvJoiJlDCuMTFw4peun3/yGYWTRdhmpoJeMXHe6DnCy+2PqfgkK4ANskOkG9
 yWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263458; x=1790868258;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yaeZSEgPU218o3dxfE2k9pfW7HNSWwmX0x0IUXOj6zE=;
 b=E+1d6AYQkWNypJ3/o69XmoGiwxgxWZzEtZjMJ7u4/fSYMKv9UIB0kW4xq9tEjVhYrp
 hr53uAvqYOeN/sGzbRrv8NhkgEvMnQS7wTGnsIF0d9t8M1lqG1bqtrsSeMEuIbmWnq7O
 MiPjs47F13lwDdUGi3BMW+zWMDYp1Myx8tYok7SsOHaJLaw8NZYVF6rx8VnDkKNJcq5c
 oi+5dJI9eZmIaB4a9Kt/V06J2tPEurRPxOcv9cY8yUvHTsHSBl5UnQ+kuR7ClvCpv0xW
 nEg+IunElAgAAfuWI4H0kStKaCLEEot00NzKzOGHrwX1ECGB8kaiNo+67Mb9OxBd3u60
 aaSw==
X-Gm-Message-State: AFuF++lJzKUVIJY1c5+8U4MIY6fj3Ko7cgO1hhbojgZ9/iZNpY0Qckhn
 WWij/D2JdyBgGk4MTun5PzmrjE69QciSAtpEpk6yyDGaUzDaME4bJiZBcc5w0n88SuRYa7a4/OW
 AT3xTA/p0dsDt8J82BUq1VjIsWeW7EjCe9+h8QCoGjNjVo5oDZkBcTj4/jpTNJ5awSg==
X-Gm-Gg: AYBFou3x4r9uLx7+pFfFhqf6ubRc8Z/nMmWSg0Mduya0qIqRXwz1rzW4XMmJYw7/pPD
 HpUdOewuW6sI4EbWUkOZMrw2uVv4p1qLRMw9e717bjvSdLIS6b6PhGH11bO4dWFCRksFo0WiO5H
 PORiWFEOKkBKbiKWqvKURlS7fSGXHjArzRnKDxuNWE+81jcIDnwaHHVeVlfKIAdzJ4eE4B7BmSH
 L6soaisg6sZM4TxHJtGzVSK+iMu7v0aVD58ovkbZgATBnlEGPb0mFd1iBayPTMBdCBOluvEt7kA
 HbnY4hexL7P2qhxfV8oYsWpn0B0X5vTmiyWVKEMoY2SmxTnuSOxtfBSP6ph6Jg608Ak9GC9TfY3
 q6XO7vonxXzcn+DkU201XWivFT8Q1gdBXUv+BoHM3jLXjSsvNgkE=
X-Received: by 2002:a05:6102:38ce:b0:7a3:3d26:5c67 with SMTP id
 ada2fe7eead31-7af1e4f2ddamr1368752137.24.1790263457510; 
 Thu, 24 Sep 2026 08:24:17 -0700 (PDT)
X-Received: by 2002:a05:6102:38ce:b0:7a3:3d26:5c67 with SMTP id
 ada2fe7eead31-7af1e4f2ddamr1368738137.24.1790263456923; 
 Thu, 24 Sep 2026 08:24:16 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868889409sm12773417f8f.35.2026.09.24.08.24.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:24:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] Misc target/ patches for 2026-09-24
Date: Thu, 24 Sep 2026 17:23:35 +0200
Message-ID: <20260924152353.36209-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rV8NR5-z6ofBgj03MZ30ufEZDOh4oi6P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX3ktjnLTicaLw
 xX0tj8hNmgZKHc6JJpbEaZUpLG7YhrWOdpfEoAF1A83oucXEaSGguVYtlUa10BQnhYvxzZJbAnz
 fMDP9/42bmNDDJXjbrlFKzaUnKAK2p8lYfCodfYxitjxdn18Js909iFf/aaZQYpqCopc47XRKsc
 oVt+5LIz+bbOlVqpVvDHvL/vY+fssq+eiYW4OXWYTJfbIYZgVHDgqCiYmYniw6Ud3ERpz7zhNlE
 IZm44XXdq3MHdehF/kbuzNVTkZC05Vf1TVmYlZsoB5W6X2P4Udzib0zQlwOyXClgILbMAFF3ISR
 jdh0bDUFECkq0V9ReH6ArahqHbZASEs2GHdOfEZy6TXj3lTEwAIAuYwR3qEPS+kE5Mw0JpbOn73
 JZYX73nmjbCoJ23OJpe4lMLgPgT8fJW5HT70BUGGxfFHarHHjzpLsAOCLGnBT1z8IaJI/Q4HKe7
 94auq/SOCNlHjRadyww==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab540a2 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=toM632NGkhDn055D1wsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: rV8NR5-z6ofBgj03MZ30ufEZDOh4oi6P
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX2Zz+/ItjTlON
 JBrsVG+3dIqf7EbO9KhxyHJw+WsVh89xfxVgtdK50pgazpnXI2VFf/XrNnvc9vPZpVz4cNP2W+Y
 5zVJO3pJHqBIHA1HHlgjNmDza1L7cJQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240063
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

The following changes since commit 942229961efea74b153c44c59188eb08375f10f1:

  Merge tag 'pull-tcg-20260923-v2' of https://gitlab.com/rth7680/qemu into staging (2026-09-23 15:14:55 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/target-misc-20260924

for you to fetch changes up to cbbd4d74eb298e2b407018185a40cb813435527e:

  target/ppc: Stop vCPU thread before calling parent_unrealize (2026-09-24 17:22:06 +0200)

----------------------------------------------------------------
Misc target patches queue

- DOC: Improve SysemuCPUOps::has_work docstring
- MIPS: Let TCG middle-end optimize MXU opcodes (not front-end)
- S390x: Access S390CpuState atomically
- ARM: Access halt/PSCI states atomically
- X86: Access interrupt_request atomically
- PPC: Fix double-free in ppc_cpu_unrealize()
----------------------------------------------------------------

Anton Johansson (1):
  target/riscv: Stub out kvm functions

Janosch Frank (1):
  target/s390x: Extend comment about PV cpu load state

Philippe Mathieu-Daudé (9):
  system: Document has_work() synchronization requirements
  target/s390x: Use s390_cpu_get_state() consistently
  target/s390x: Make s390_cpu_set_state() return void
  target/s390x: Use S390CpuState for CPU state APIs
  target/s390x: Access S390CpuState atomically
  target/arm: Un-inline arm_set_cpu_power_state()
  target/arm: Access PSCI state atomically
  target/arm: Access halt state atomically
  target/i386: Use an acquire load for interrupt_request()

Richard Henderson (6):
  target/mips: Fix zero in gen_mxu_d8sum
  target/mips: Drop zero optimization in gen_mxu_s32mul
  target/mips: Split out gen_mxu_logic
  target/mips: Use gen_mxu_logic for gen_mxu_S32MAX_S32MIN
  target/mips: Use gen_mxu_logic for gen_mxu_S32SLT
  target/mips: Use gen_mxu_logic for gen_mxu_S32CPS

Shivang Upadhyay (1):
  target/ppc: Stop vCPU thread before calling parent_unrealize

 include/hw/core/sysemu-cpu-ops.h |   6 +-
 target/arm/internals.h           |   8 +-
 target/s390x/cpu.h               |   9 +-
 target/s390x/kvm/kvm_s390x.h     |   2 +-
 hw/intc/s390_flic.c              |   7 +-
 target/arm/arm-powerctl.c        |   7 +
 target/arm/cpu.c                 |  13 +-
 target/arm/tcg/op_helper.c       |   8 +-
 target/i386/cpu.c                |   4 +-
 target/mips/tcg/mxu_translate.c  | 265 +++++++------------------------
 target/ppc/cpu_init.c            |   4 +-
 target/riscv/kvm/kvm-stub.c      |  23 +++
 target/s390x/cpu-system.c        |  32 ++--
 target/s390x/cpu.c               |   2 +-
 target/s390x/kvm/kvm.c           |   4 +-
 target/s390x/kvm/stubs.c         |   2 +-
 target/s390x/machine.c           |   2 +-
 target/s390x/sigp.c              |   9 +-
 target/riscv/kvm/meson.build     |   1 +
 target/riscv/meson.build         |   3 +
 20 files changed, 156 insertions(+), 255 deletions(-)
 create mode 100644 target/riscv/kvm/kvm-stub.c

-- 
2.53.0


