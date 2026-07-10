Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9364AC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEZ-0006SG-Ql; Fri, 10 Jul 2026 08:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lG-0000Mt-Mu
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:26:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lD-00048w-2t
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:26:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mo5D3838430
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wAkmYPr0MnelD8xW3IvffI9h7BZbNMFvI2i
 1piqFbrc=; b=Q29CY+mG7YJ6t/7esMNXyc/WBKMzv1QCDe+Pum7yZAIyVncgWKm
 fh6Bn07reiq8gsep7Ik92NbRU1IumkomCkmVZci/nUL+BZpGktdDwOFtraX4LSqd
 IXroo7UH/X2xYiScoA39C8Gkiys/ktbCNvTTO4SfKxCGmuk8AYviY8V5NOZqsFuP
 AilZ9cMSsxMwlekU39n1wYqnHbz3pSGoAYjwh7YRjZUN7ba3NoiBodO3yviVPH0t
 JOsH47QZFS/qZNrR9HNYWaBaGk44FT6Q2wCpRkkBAInT/MtqJJG389MJlmBHz0pr
 aTQp5eZhaDRQ6v3ZQ6Ct3WVm6/i7zH5R9oQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwe8w9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:26:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-384d033f7f5so162415a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783661207; x=1784266007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wAkmYPr0MnelD8xW3IvffI9h7BZbNMFvI2i1piqFbrc=;
 b=ErA6igzEcQfN9MjKNPvtId027WZqQ88TiA3mw+3D6jdl1Bq94+rVlDz5/lkyrzSfxy
 Qk4DDDUeEm7GtZWpe+mTZ02oHOR6KDYjmyq28Nyf2TlPCe97N1eN0B3TMkqLzlFPlI4Z
 78pBhCoaXF2/6QcptSZJwiX5GKc9T5V64RTQK8Oc2G1kLPeGuEjZqilsax28Q1SMzkmt
 WIsTG+6A+tk1X6zvPTCJDF0UWWhoWLGuWFNRL8VavKcc0ll5t+pu/6zaK8J21r+n+J26
 lsUbvVSwR9R8Ark5taiaBsPmWd3xDP3as9Y2oeoiMfwZvXFamlK/FN/plhuXiwpEpQZN
 z5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783661207; x=1784266007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wAkmYPr0MnelD8xW3IvffI9h7BZbNMFvI2i1piqFbrc=;
 b=R+Hk+9G3CMvbBya5m0m/9QMvlW0RZWNnU2adJf81TAVgAR/PM11PuqhHBUO0/GOOGE
 Wu5AJaJPnEHjWblf1qC4Lva1+/s3QUPJr8TX3FkdN/X+iygFpKoKEB2SJ9k5d7RPunlV
 vC0th1WUnLN3Nz8kX8uBUiYD69k1D/t9qBI0Zji4k5+tqhdpzzqDFFMXJLqnm92Lcww1
 ufBlUGZQGVjSyqpIPC33zwMPsWp2hTlpm4RwBU0PUE/Ckgx5iqcb4Zp7Y0KlJISY4HeG
 bwl/xqbCK30fp8B0PbT/XBMbOMnUCWRmACj2GjLGmiJBmbMNIoKylZYGdb1t7XlEKhMS
 SGuQ==
X-Gm-Message-State: AOJu0YxdVKYmE3H5utyyBEN98nplnCfdTIkBNPyYOR8EOVXAIfBEr9s9
 EMD21hpBj6blHVqd6VGdeJCTN29YQAQuoO+Kf2rfzDajv4q1s6HCdYfaGm7Z8YjVn1J19fBsPdM
 mkG2vv4laRJe89AAXK7I/1JD8Bu5N12cdTykWdKMXTPVlp8GDejHgWJISa6ViR91zCA==
X-Gm-Gg: AfdE7cm+8mjGxRSd2GV0Eet/wJaJt/ckxBZ4vWkOJ4FU3htyNvfCAFSrI+ORNMB2O9s
 Olrwa+o3WaI2wjchFtpk2XoYvvzMt5qF4dxpvvmb/VbvegmwQNIcOSzwvmmaX27ZgGV54D0y5jT
 lOz9qPB2HxG+0UPUFD7zBF7VWI1YkFurpR+rzM7/B8zfdwRuI1Hwr7MroYTsOMqUVFYliVALJpV
 Wrp+Ashx53vq0i2vEJ2GKh2x0XPagBDnH9ic1IFhwxuecJDo9yRCCgdWDsjttz3RmXAZUHiWjKv
 DXjgPexwdxlibsxM8UVxMU4bxp0j97lnvdHgSDl+GC43ph2imUC71XGZmk9+EWA6GCytZQ08Tge
 W5rpD4njM36vmV26kwcrVMQzSy8dbzHS6kBgcqmBr3mAbpyYMp0gZLIJNKTaBu/yHHMHoEQAB18
 CGVawASlYDAhFjzfWrMthGXJmlKXIuBz8QV0WxEpo8uQ==
X-Received: by 2002:a17:90a:d606:b0:36a:5438:cff4 with SMTP id
 98e67ed59e1d1-389421acc3cmr8353771a91.6.1783661207185; 
 Thu, 09 Jul 2026 22:26:47 -0700 (PDT)
X-Received: by 2002:a17:90a:d606:b0:36a:5438:cff4 with SMTP id
 98e67ed59e1d1-389421acc3cmr8353736a91.6.1783661206464; 
 Thu, 09 Jul 2026 22:26:46 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm62476707c88.14.2026.07.09.22.26.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:26:46 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] riscv: add initial RPMI virt support
Date: Fri, 10 Jul 2026 10:56:32 +0530
Message-ID: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a508297 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=ifwrZjGQlPW6EF0WfpIA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX7nGM6WzRnG48
 1+VCSE5GrkxJk/2gjLkygP78SYlFPPDQPX2XKoOQi4ZMy23e+f7mcNDdeJOR8nImPnPWi5SLnSO
 hE64TVFEqGQbyGsrpCa4iD4s5842Fd2FCVbj8m62lcdeO7OgiSdRjbVDH0axeb6qQ+ZZWRH4EWU
 /Y/QbrjH8WuJTDEw3o1oPpu3vz5fv6K9ytY8oZ7kUpqHgLrZpeiLHy55wzXlAN/OisvLxv7Pl/b
 bwM8NI5QAw8k+J6HnyGEIggA3zP6WjaYxnjmmdJH8m9RxocgMsCJT2SAvg/jYOeuoITtlVTt63n
 43gzo4lBO7U+HxpqyVikuinuqXrzedkjZEFVHNc4DOy/hnsDeyp1z6DGQ/Xk3lZII1K5by4mKPv
 IhEpgQuioQ4uMZfOJ8U7Nvdp16pGvJPfbGTVRAGRbwQjcbukUpHXd8gV6Ga6nJzDYLI4E4IDMMN
 sD+SHZ4yv2Uiy12PoIQ==
X-Proofpoint-ORIG-GUID: qgkD_u0-_iKJYAGODpvhsl03jCsswepB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX1YiTWdFNTuBi
 6JbHVn4PQPgQ91EVBeJlY87wNvIt0K+mRb/f4RH5KG8cfesbBJPbp4hTtfgKOHmMvC20r7ZQJ8i
 3Y71HQnIKTHGgS8U3Bce87qJ6OWghVE=
X-Proofpoint-GUID: qgkD_u0-_iKJYAGODpvhsl03jCsswepB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100048
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:33 -0400
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

Add optional librpmi support and the initial RISC-V virt RPMI
implementation. This series introduces the shared-memory transport, FDT
helpers, opt-in virt wiring, and the Base, System Reset, HSM, and System
Suspend service groups with qtest and functional coverage.

The implementation targets the RISC-V Platform Management Interface
(RPMI) Specification v1.0 Ratified and uses librpmi as the backend.

Subrahmanya Lingappa (10):
  build: add optional librpmi dependency
  hw/misc: add RISC-V RPMI transport and Base support
  hw/riscv: add RPMI FDT helpers
  hw/riscv/virt: add opt-in RPMI base support
  riscv: add RPMI system reset service
  riscv: add RPMI HSM service
  riscv: add RPMI system suspend service
  docs/system/riscv: document initial virt RPMI support
  tests/qtest: cover initial RISC-V RPMI services
  tests/functional: add initial RPMI virt guest smoke

 Kconfig.host                               |   3 +
 MAINTAINERS                                |   3 +
 docs/system/riscv/virt.rst                 |  50 ++
 hw/misc/Kconfig                            |   4 +
 hw/misc/meson.build                        |   6 +
 hw/misc/riscv_rpmi.c                       | 558 +++++++++++++++++
 hw/misc/riscv_rpmi_hsm.c                   | 287 +++++++++
 hw/misc/riscv_rpmi_internal.h              |  42 ++
 hw/misc/riscv_rpmi_sysreset.c              | 206 +++++++
 hw/misc/riscv_rpmi_syssusp.c               | 191 ++++++
 hw/riscv/Kconfig                           |   1 +
 hw/riscv/meson.build                       |   1 +
 hw/riscv/rpmi-fdt.c                        | 103 ++++
 hw/riscv/virt.c                            | 167 +++++
 include/hw/misc/riscv_rpmi.h               | 126 ++++
 include/hw/riscv/rpmi-fdt.h                |  41 ++
 include/hw/riscv/virt.h                    |   3 +
 meson.build                                |  14 +
 meson_options.txt                          |   2 +
 scripts/meson-buildoptions.sh              |   3 +
 tests/functional/riscv64/meson.build       |   2 +
 tests/functional/riscv64/test_rpmi_virt.py | 172 ++++++
 tests/qtest/meson.build                    |   2 +
 tests/qtest/riscv-rpmi-test.c              | 684 +++++++++++++++++++++
 24 files changed, 2671 insertions(+)
 create mode 100644 hw/misc/riscv_rpmi.c
 create mode 100644 hw/misc/riscv_rpmi_hsm.c
 create mode 100644 hw/misc/riscv_rpmi_internal.h
 create mode 100644 hw/misc/riscv_rpmi_sysreset.c
 create mode 100644 hw/misc/riscv_rpmi_syssusp.c
 create mode 100644 hw/riscv/rpmi-fdt.c
 create mode 100644 include/hw/misc/riscv_rpmi.h
 create mode 100644 include/hw/riscv/rpmi-fdt.h
 create mode 100644 tests/functional/riscv64/test_rpmi_virt.py
 create mode 100644 tests/qtest/riscv-rpmi-test.c

-- 
2.43.0


