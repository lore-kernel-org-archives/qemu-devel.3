Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522EEC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAF3-0007Cb-9e; Fri, 10 Jul 2026 08:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi6mi-0000Wy-EA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:40:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi6mc-0001qs-Fe
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:40:33 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A7eITY190744
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=zspPc59cvvc/pEEc2ld7E1FQ8dOziLtNn8i
 kItMelo4=; b=YjfhlssUYQFV/xAp/Y4ds/qwSO8uE34MdinBn1ZrwljVull9Uj2
 l8Twl3hqKlX2D28EGmvN7cX7X56sNX6ZBe2zWK60DJGljFgcu4YOE3buXyWTS1bI
 M7TJKEgxeM/ECMDqJhi46Ifv9PIdHwIKKRK1depW64B/pIJrTXRd7fYQ/JsX7eep
 ODQNMIdCtRB+2m3HCEIhRsadxW01k061m+yEKEe/mWrj9EJlQjPGJ5SKgx37w95N
 ub4c/gQ/2ziQPk+3+96ZNwVfh2tgoPlXHjkPMtIYohb/2Sd4OsPC1ILd2U+Wrasj
 6w1urPNEdCG62eYX29np5YTjYMvSQN/uLsQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n10y4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:40:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37dedbd1cf1so382789a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783672809; x=1784277609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zspPc59cvvc/pEEc2ld7E1FQ8dOziLtNn8ikItMelo4=;
 b=VwEOjcL4hGfeXwv9B5zaQ+vO3l/H0ZAl+ou4ADn6ejUJeGJ0GWS7Sp0NQYtEVN3iZx
 rnQhieHItZrrtcnT1Y1o5///yo5k0JgaIa0V7qdV209sCFr0d0I4+oXo9Ep++1WoSiKg
 5tQeFHeysMSu5LcBEJmJkZCNJkKQDWhQJ/cYSBlaCoefFjBRNpidR1xZ/yO6DqYZJC4G
 PleVEOXt5+Xt1W8otPsg+XB7wwlZ9T00wJiGxPMua7vqZe14B+QylJTzDN1QFnRbiVjG
 IsZQJbM3gYjjT5pyIo/mxTmXsmwxM+yi+Rnl16ugt4T5zTp5rt26k+ZvPPBCzxNi1T3C
 bIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783672809; x=1784277609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zspPc59cvvc/pEEc2ld7E1FQ8dOziLtNn8ikItMelo4=;
 b=Ldycb9RrCcmGIyjEYUzql2l4a6J0mAnvBBJG+7BZhxhTVWxcU9xUlP7RHO9hDjMieH
 37yk7xP3k7ikJLL7c9w/iGN9fMbhS/yK0VCK6COCK/dtQNjaBv/bCwitFAkQQXxslex5
 NDku72j/ikGtHdSYNp1fI43DGAiM9iSbZZ+oOG2uH6zjnb9lZNO+vos+Dt972T3GFaJo
 3R65kP8BkcwuYDn2bL2vQXAfCCfV62ElpFjq5ANf79s/Z4Yd2JLkrFVHx86CSz23vy2n
 qTGs/NeDjZkHWwM5TkYhsirlkZy/AWJY4ptJJsENeyU2Zd50e+Smi5obGnx2BDtR2mNv
 kBFA==
X-Gm-Message-State: AOJu0YwGHL7qd2T3achCOBRFaxqiHA/RLZRoq3605TEJ/FobbTrlQrzj
 KI0uBxXEkR4Ag/RD22+/vR6kz73Wee94chgIiFBLQuAClJcOHe6P8iM4RaB2BZK/Ri//TrkStAy
 iTirKKvZqhGKw5RmD1RW10brmiPgJgKgs3MGcHJR6M7XNvKEzLCTqn6eggA==
X-Gm-Gg: AfdE7cmVcVGRA/5H9qF5DK6vOA1Y7/I7+upna7k36ByGQwjYac1yRcdsyMXWLy9Zism
 71Ozm0KAhfFkdYWvDgxdfjXDeIr0T+P0ZYaPYJ5HrVTPD8QfwRleebwhEGg1dW/8vK7G4T0Ezus
 LDJnZg5WzUmz4wHnOydt0aMu+DBUx7YMpbuTJWdWEJng6pXvpH5cLKEEcEZtUJ2aivYKtvI3We1
 YzimFWNUEXJ1cbIS0qb19AtDcQxUrExj5KZeahwY7Xhve3gODI3j+02hf8dtehTr99ZU+0iH6Ax
 hlUF6D7ZDo0gkq8Vkw0IGpCGHv+OQIRfTnCsUiStiSEpTK18EoNPQ7kaLlM3n+4BLuwD1+7uDuh
 bQhu6kS2ez1jFPEourljmNuFoy9u70XjCio6/GVrnY8CgEqo2J6IngrLb0t2FRRRvgjTT8plafz
 rtKBBuRor+cb0w1ar0eQN6TMDbHpIxojof3zBu8yAO1Q==
X-Received: by 2002:a17:90b:2f0c:b0:381:abcc:c8d8 with SMTP id
 98e67ed59e1d1-38a1f1de21emr6431287a91.1.1783672809375; 
 Fri, 10 Jul 2026 01:40:09 -0700 (PDT)
X-Received: by 2002:a17:90b:2f0c:b0:381:abcc:c8d8 with SMTP id
 98e67ed59e1d1-38a1f1de21emr6431242a91.1.1783672808739; 
 Fri, 10 Jul 2026 01:40:08 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm29164925eec.20.2026.07.10.01.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 01:40:08 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, daniel.barboza@oss.qualcomm.com,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v2 00/10] riscv: add initial RPMI virt support
Date: Fri, 10 Jul 2026 14:09:42 +0530
Message-ID: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4MiBTYWx0ZWRfX9WkBnNgJ6Ifo
 qhbjOqHVaw1Q3UaatD4KfG4lzDDqkE0Yu6uBN0MdJeB0XW4TSyfg9ihQvLdQEGrmPQ1RO6iEHty
 LbQxM7m7Ao4yMZ8yDdDjuXrY2karhxM=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a50afea cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ifwrZjGQlPW6EF0WfpIA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: QnJAMxQGJzPkB7UgUMyYdLtJNqrYlK8P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4MiBTYWx0ZWRfXxktji+2h/lg/
 M+99xFoZh5+BGHXB5jLFMiJd/ylmkr5PDgqTjwdJX2oRQHCokFPza7xiQir+nAyjWRZgfk+qMFp
 5Tqn7gSm2h0MGFISN0JwmyFE3Km7zgJR0L35lNi3z3zHKp9bNPOnftL+PmKPlL9XzzyswIuo1T+
 1PB8PSGl0LQrea+kA6dH7H4tom98OzDc/lc9d2LMsupb7zBKhKZ9t9QCKNPy9LAl+HiG33w6VGh
 CDakGj7VRqWi82u8QVyPOgHBIk6nnivIoHMf70H6/4mcMQY0sKDwLQOXreL1SlGHN2GJong2mSS
 TUeRDBqynQVNa7XPXahex1vH0NPK0l7cXbeCDHGhwFjsxD92nNYbD/8BRyWPPCfW3ZbhZXdBprs
 o+I0dO7kh4szxcPOzPrwC8Z/GIwQBS7fM1VI64NV7v5FBFiIMaUnA4gCjT6BCcAn0UnljH+Evbg
 HTo8hB8rwmt8IE5w9Iw==
X-Proofpoint-GUID: QnJAMxQGJzPkB7UgUMyYdLtJNqrYlK8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:34 -0400
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
Message-ID: <20260710083942.LxFOJ8Zdk8pEO9mo7R6Enpqy6PJwxl3Pn0ix7umwinY@z>

Add optional librpmi support and the initial RISC-V virt RPMI
implementation. This series introduces the shared-memory transport, FDT
helpers, opt-in virt wiring, and the Base, System Reset, HSM, and System
Suspend service groups with qtest and functional coverage.

The implementation targets the RISC-V Platform Management Interface
(RPMI) Specification v1.0 Ratified and uses librpmi as the backend.

Changes since v1:
- Resend with the oss.qualcomm.com author, signoff, and mail metadata.

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


