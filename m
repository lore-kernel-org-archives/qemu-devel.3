Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1F3C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEZ-0006S9-Hv; Fri, 10 Jul 2026 08:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi41I-0002CY-2O
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:43:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi41G-0007iV-6n
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:43:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nCJU3752749
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=zspPc59cvvc/pEEc2ld7E1FQ8dOziLtNn8i
 kItMelo4=; b=Pg1D25VuEa47/Hn3i8DGzLWYQgNnp/QIpI6XNgjRp1QQKMbHcWz
 jD1SM+rddVmDuaJy343uzWJ//kdEQGpUTM6nNgtyRr9j61EOPZTVjUMgC27k6JPY
 9zutBOSrLo09/URpmgQW2f6BF4jRY3nZKJUQAVX0wxKTJ3Jwgi+lWK/TgbtyPDEi
 Lrbsc/aPe/6YB7xmA/qVdhAlsabGgkhAfXumP1/9jIUKbKh8I9l/vBFcEoZSgegR
 T3ItJzegQczj02bh49SapPm2CW3qKylxGzA0kanolwjg5oxU7Ai6kq+Iaf5Fp68Q
 joA0uN3oBN/qiw8TaFya5HoqN3iu3iv1y4A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjb4j0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:43:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37dedbd1cf1so325924a91.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783662204; x=1784267004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zspPc59cvvc/pEEc2ld7E1FQ8dOziLtNn8ikItMelo4=;
 b=FRDZ5wUuJkr0kD6QfDeOBc5dumfpBS7R2hVL6Dcl1nPSAXEZCug98eWa0sbnkXZ0jA
 wZQQzEiQyoInrfpJbaHjwQzRp92LFCewKrmvCwCCJm68M7U/otbCJfCjwbQXYp0BWACK
 HVDtc3edmJOGpIlSjiwAZLcJLN+2aI94KSfLA4/7jrVNRSEaUG39nUD712IrNnoK+dmd
 rBbnUgQ1KdcIevfdJqFhOgPpN7UQJkdOkszY9f1OonzirqE3xXR7kfSXofar1mjEpPX/
 9WXH0Xg1+Q1e2obSRAsd5zUBdQN9guDLGt0Rz0qu1zgSAr1p//JaASJBj4o1g25kit2S
 dVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783662204; x=1784267004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zspPc59cvvc/pEEc2ld7E1FQ8dOziLtNn8ikItMelo4=;
 b=g5nP8bHpbcc/KgB9biFoSZr8w8KuLDV/UVrtN8pmSVx/HXRPaHuV3igL2hxaVUvBIT
 bYqyphmj4nzthZ0PGT5+kfQWGhYc4BYzRUpbZmw1Jr1XCZFXoHmW5Soyoq+srPND0cRD
 Ptx7kLUFvlI3+2cbYWQEZ7drd2QQka0RHbRtkY45f0EiaB7cyeLOqicdLh5LXOVNeshx
 c7HbFQesArQsXNSiHUWcbkn7Hh+MQiPLXVUJ/7m6FNTl7WLtvyhFtbT0dkufiGh7NU4j
 Ls5jzs03xCGtUUmFL04FEJ4cYgZQO49Ey31kWlEvHOeo+k/TsFGKqZxRBI9R3bLjh5lT
 F1KQ==
X-Gm-Message-State: AOJu0YwKHR+ICVQ7v2GPNbKVvbsC3NehXJDq6nXqjbLUyJrzAZEwHggH
 72HeOpbl+b5IvcvQGjk3CMgcI3qeq1JS1tXmsoFQT8efDrQexAvsTpvS1MtrzOXL9GQeazjeniB
 vdnKWtAL7CY43tR92eo0jTyRX+4YoNs+zrnJ+qiLV4t7tofiHRTQCWW9mY6Bj0jE5zw==
X-Gm-Gg: AfdE7cnUokthq4FPj/l23Sm9YmBYCqkpU9h5kcVqa4x/zmDlO5xNDI3XWPqXTxfrf6O
 Z+usRa29hHbb3WVB+oS2eSeQ+zsDgR10B+1gu1+Mtf7sThImVZDQY0Ph3ACvh4yM1R8ERPDL3pS
 DNe5k6hyDKalqqPKyUYAacNca5CRYs2zIBxxfeEkUUV3geEVegzi1wkfdDIjl16KmOVhoqlUOwo
 VtsTtbwqWwFcvm3vAvMVxrjeA1foVqwq43DXuNb/bQjQ9gxNaNZSuvi8Ka9hv1w3hjS3Dddyuej
 V6oNhEQLUfoRLp7kiGd5ICPjizFv7mN08fxrdihUlrA6dh8U/nRc6rls0kaa/+H0HTc68fksJIm
 P/N2J8ajU2Nsk0Vts7q9rm2n19LUhjkLuIF2MUQBExevbf9bNBfhaQ/4JzL6bAxn4gNJ7O6tmez
 p1Q4G4/8Qoude0hY59qkTFhCJMtJC2CgujUkp01jlxRg==
X-Received: by 2002:a17:90b:4c0e:b0:381:1ffc:7d35 with SMTP id
 98e67ed59e1d1-38a2122c84amr6336704a91.6.1783662203685; 
 Thu, 09 Jul 2026 22:43:23 -0700 (PDT)
X-Received: by 2002:a17:90b:4c0e:b0:381:1ffc:7d35 with SMTP id
 98e67ed59e1d1-38a2122c84amr6336675a91.6.1783662203049; 
 Thu, 09 Jul 2026 22:43:23 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c865asm39112785c88.11.2026.07.09.22.43.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:43:22 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/10] riscv: add initial RPMI virt support
Date: Fri, 10 Jul 2026 11:13:08 +0530
Message-ID: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1MiBTYWx0ZWRfX61iHPNBEljNy
 Vk7Jbr3V1EYOO9HTiPQH88mi5pIPkPVd3e6z/frcgB3meZlG4u1azNr+ybjh/J4dgpkz5xVS9UR
 qlIw29F9rgg7x99hXo8ZgnIaPrPC7fhKHwVU2LcyqL+mFkEEhX6X8ZZM/quzkb5HRAelfWd7h1m
 B1JH9woSaV2iqW4ETSgDU0yiYvw3i9Zn2bvzowwtt7tDJAqcms/oicEUY6GWoaDo8VhintHCBtN
 EebKGReXht3Gk/K9zSojdCpBkXmoBeXmIE08zxAF9Dqetl8HVb1U37/Oz/W63FQYl4ZCoSEeEWy
 RiJN/hpXT0foubtKGhqxvuMd4xGppB05r+ANLD0lpRNE2ic9mP+4579Wx7EU5hkSmaIkKf659Uf
 aVbp4EVpzq7ZN0o7j6PQu3IYQmVIvFQ8GTU3RDvJoQroB42GkKPz6x/+Q69L+MMpAylKXrafSzW
 uAMm+3XjSkcugtyBtAQ==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50867c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ifwrZjGQlPW6EF0WfpIA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: PN-SHom1LUFtBQT3B1eR16jmZ3HBPiXt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1MiBTYWx0ZWRfX0NTix7pGQHDp
 e+0W+kJ6Yyllfl+sK3IsxKzk4+Cth7L9K/aQsIE+VzmA8lS7Q8h4CZhxiCWS5CbCGncrFWZY/66
 kOoq2agjRv2/CFNjbPMaN+d7Q2QSdmw=
X-Proofpoint-ORIG-GUID: PN-SHom1LUFtBQT3B1eR16jmZ3HBPiXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100052
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


