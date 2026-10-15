Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47013CCA465
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRAs-0008Jf-BJ; Thu, 15 Oct 2026 15:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRAr-0008JJ-3U
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:31:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRAo-0000Va-Il
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:31:32 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FGmZve4100189
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=knOmwnitFcHa25aCaq0FDx
 Z/Td3xuLXnyQwW/7H0YE4=; b=nAU6rhsaFnLPAkpDciUXOhdIS/FWYsNO1tPXaA
 i7cy0J1DLIPEvLbX/n7Jhjs5QTGYlIQB2H58K9dAJSaSc5u0KI5Jox4nOwTuDFlT
 xFmdCYQW+NpsgIuDEW9kdbMR0H4raBgvH/XtATlWmI85As9xThofEchrECplaTJq
 Fb2XrULjMLEsK/Qyvvfx7xyyNOI4njwdY7TnekxeOAEqTbCQtOIm2yJSetyPcKbl
 WWYW4xfh0f1yYl6CWAYf/CIxACHv8ofcrZ9upURvFZFeIDc452za1gfVL/lfZoJX
 FbyAAmmKPQME7XYVqndXdndHp1KNKMP4/jHbjtAbeGJ02+EQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2ra59e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:27 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35fb6be0f9fso1812909eec.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092687; x=1792697487; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=knOmwnitFcHa25aCaq0FDxZ/Td3xuLXnyQwW/7H0YE4=;
 b=JIMCwofcOZNwBcLyOpzLJ8im4rwxMwA7t4FGmTL8M9+rd8aVLl1kaGEFcbvM627fDG
 xpVN9fcKJhZwka4/FVfbP41m4Zhw+Nn68ElNlPn4nKE3VTbL5V/kCW50DLTXCnvL1J2L
 auRs5NJ9CEpnAa3hJc6CVHppbWViU3FzE5rLLxTjuHwUik9xzuoOz1lGWasltkxcufsj
 EfRYJFKDYpr5vHREqaYsMhCIV+83N+hOPEDnDSoHDq9z31h67JpjuQ36RlfMPqCHXvp8
 JTi4TYcjYIvTMw7y5u1cc6GcQvikIzlcbEgK76lU7+eZFWOz0mgKqJS/SC+zDLIwDfz8
 4Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092687; x=1792697487;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=knOmwnitFcHa25aCaq0FDxZ/Td3xuLXnyQwW/7H0YE4=;
 b=oz4VmTn5laMgNRMVX8Fj+VEh5VirDwFtMHy+hZtNtMSt8wMYJ4drTjAfIqnIMwdh6D
 G7PQtxGahruwkXgJ2dHdPodvIYHHGJm2ned7vR9xX71TpG8B9A2pl/XDMco0r15+ffb4
 k/vb4CtC1ASLzwtgLEZAPp6ukBTKT+TOtH2mMp+YrWkduRk9zhxgANG9h68TpElSiErx
 q/XrdRJ1p3jO5mzL8FG5oLl0N0B5P0e6y7bw8mcUht/bivndQOX9WkVvbcnNOn+5W47T
 /6zebMqhLZJwv61Qu1Dau3UNYhWzczyYGhIk4tImCZDasT1QVvjdCMS507m2waJw+Sg4
 8hCA==
X-Gm-Message-State: AFq9FYKfhUOoSWYLxKwa+tpv30Fd/9T0NS618H9+dhG+6lVJ4DVBtEPA
 N25a440FFjYGx6SATjxCCHQQMzVb8AHot+Ymc/9LADJL0s/6VOilK6A0AG67Ipace2L8pObmUbd
 R9sFnq8S5Vk6iwsNDwnmmdrZ50puaZ0/6AlKHQVi7wPtaH4Y1ZbyzkED7e8OF7y6SfA==
X-Gm-Gg: AYBFou3+VOxJYKRhqrY01MSOOFUmi+mMZu20ZNcCuu99dRHflqQCWIoFsUtfsExRFjN
 Tc8qWlGW0GGCkEDB7sof1hLxjLyWxqLcjqwQe/K67O3Y6MZhz+LeaD4/5MVUPdhiLQDBZMUhOt9
 h9FUuWA+p2wuEfjeJmQe4eRudBw8hJmt/cbjbTOCT7ZEnXTLwVfmM+YWplIn3oRl7KE/dBzxEPm
 I1O6/w9T5paZ+Nq45Pzckga70GItlAdN84gyyOOxBxicoxW/SvfC685uzozhpb/aPIIhl/odmgA
 dr3Me7NQra/QFWTImoUE2Ck3T5b32sf2BPeQgPuWkWK2O3Hv3u5EHYPeD3GhymIvfNxOyeZolzO
 +RNzUjsd/Jzpvn2rypC6BY/QUnfVGNQqxGC2p95bmchil/z44FjxR6yFNKiwI
X-Received: by 2002:a05:693c:66d1:20b0:35c:2261:814c with SMTP id
 5a478bee46e88-35c22619b75mr12436377eec.24.1792092686498; 
 Thu, 15 Oct 2026 12:31:26 -0700 (PDT)
X-Received: by 2002:a05:693c:66d1:20b0:35c:2261:814c with SMTP id
 5a478bee46e88-35c22619b75mr12436341eec.24.1792092685690; 
 Thu, 15 Oct 2026 12:31:25 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 00/20] Multi-target 20261015
Date: Thu, 15 Oct 2026 19:30:52 +0000
Message-ID: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX0T+SqZqVTTF5
 mnobDAIve4o4RlGTfadT4RTTtR8CiLZaz+Si0LalNDXrK9iROz3907nn4+Q6C7kHUZoKjOSCoiS
 VOtpDqcM+/dTRlQdMR0d23RMr0ERBlA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfXyRnC0abIY5lH
 mUpjQJ2kRhHBs7fvmoy4dAXng2ZtSRhlM0kvNL5jNmvNrmvn6iXkrAFAcyD2J1cym4Q3qUNtB3Q
 sgJZdcMhzBMSdLJWp2lKzR29khMem8qaQ+aMc0FQYB3sLhqeWVRJPsK8UQNCiFGzTT7AY/dFj6j
 3Mk3slEKxrEBBKy9ey6CtE+8eP9AQI6gbiJhzIiWzfpNvBlCxcgAvDO1NJeXRZKXaAxsZFdquLZ
 T3Lfq1dyegUJzx3oOCPL+/iK/lkhaAW9jOOubN51CQoXjyG9xVenGAE81zquVCyM0+NTYfzG5SC
 w2+gH5l0egAKTYpbYdCzmoVWRELufqs71gCFVV6WCzySuEfuCbg76wMY/X03IlU1QfUEj8ykgPk
 aUf+wqfcmvedpkY49dj7Mmy8zvKhiiGGFf46zpYq93U9Pwu1syNMKMH2aYTTzwmeq58tbIqlXp1
 GJgZU3S0WniRI+SVnxg==
X-Authority-Analysis: v=2.4 cv=BNMmP1QG c=1 sm=1 tr=0 ts=6ad12a0f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mWOq1OrBJjQHmwWOHXwA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: Y_WIdjVop5C7zuORacr2bUa1SnaTRkCm
X-Proofpoint-ORIG-GUID: Y_WIdjVop5C7zuORacr2bUa1SnaTRkCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150077
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 7e8d3c7fc460fe7cd28a3e423d7466fa292bc269:

  Merge tag 'pull-aspeed-20261015' of https://github.com/legoater/qemu into staging (2026-10-15 14:58:28 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261015

for you to fetch changes up to 269cab810cd7ee2f6955be2048979b206a711817:

  qmp: reimplement qmp_query_cpu_definitions as a dispatcher function (2026-10-15 19:30:24 +0000)

----------------------------------------------------------------
Changes:
- [PATCH v3 00/12] multi-target: add hexagon (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com
- [PATCH 0/8] multi-target: remove qmp_query_cpu_definitions duplication (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (20):
      target/hexagon: prefix helpers conflicting with other arch
      target-info: add target_hexagon
      hw/hexagon/virt: make machine available for hexagon target only
      hw/core/cpu: restrict tcg_ops to CONFIG_TCG only
      semihosting: declare semihosting cpu ops
      target/riscv/cpu: constify cpu parameter for riscv_cpu_mxl
      target/riscv: declare semihosting ops
      target/hexagon: declare semihosting ops
      target/arm: declare semihosting ops
      semihosting: use new semihosting ops
      semihosting: remove common_* functions
      meson.build: add hexagon-softmmu to multi-target
      target/arm: rename qmp_query_cpu_definitions to qmp_query_arm_cpu_definitions
      target/i386: rename qmp_query_cpu_definitions to qmp_query_i386_cpu_definitions
      target/loongarch: rename to qmp_query_loongarch_cpu_definitions
      target/mips: rename qmp_query_cpu_definitions to qmp_query_mips_cpu_definitions
      target/ppc: rename qmp_query_cpu_definitions to qmp_query_ppc_cpu_definitions
      target/riscv: rename to qmp_query_cpu_definitions to qmp_query_riscv_cpu_definitions
      target/s390x: rename qmp_query_cpu_definitions to qmp_query_s390x_cpu_definitions
      qmp: reimplement qmp_query_cpu_definitions as a dispatcher function

 hw/core/machine-qmp-cmds.c            | 32 ++++++++++++++++++++
 hw/hexagon/virt.c                     |  2 ++
 include/hw/core/cpu.h                 |  8 +++++
 include/qemu/target-info.h            |  7 +++++
 include/semihosting/common-semi.h     | 24 ++++++++++-----
 include/system/qmp-cpu.h              | 20 +++++++++++++
 meson.build                           |  1 +
 semihosting/arm-compat-semi.c         | 56 +++++++++++++++++------------------
 stubs/meson.build                     |  6 ++++
 stubs/qmp-cpu-arm.c                   |  9 ++++++
 stubs/qmp-cpu-i386.c                  |  9 ++++++
 stubs/qmp-cpu-loongarch.c             |  9 ++++++
 stubs/qmp-cpu-mips.c                  |  9 ++++++
 stubs/qmp-cpu-ppc.c                   |  9 ++++++
 stubs/qmp-cpu-riscv.c                 |  9 ++++++
 stubs/qmp-cpu-s390x.c                 |  6 ++++
 stubs/qmp-cpu.c                       |  7 -----
 target-info.c                         |  5 ++++
 target/arm/arm-qmp-cmds.c             |  3 +-
 target/arm/common-semi-target.c       | 33 ++++++++++++++-------
 target/arm/cpu.c                      |  4 +++
 target/arm/internals.h                |  2 ++
 target/hexagon/common-semi-target.c   | 30 ++++++++++++-------
 target/hexagon/cpu.c                  |  2 ++
 target/hexagon/gen_tcg.h              |  2 +-
 target/hexagon/gen_tcg_sys.h          |  2 +-
 target/hexagon/helper.h               |  4 +--
 target/hexagon/hex_mmu.c              |  2 +-
 target/hexagon/hex_mmu.h              |  2 +-
 target/hexagon/internal.h             |  2 ++
 target/hexagon/op_helper.c            |  4 +--
 target/hexagon/translate.c            |  4 +--
 target/i386/cpu.c                     |  3 +-
 target/loongarch/loongarch-qmp-cmds.c |  3 +-
 target/mips/system/mips-qmp-cmds.c    |  3 +-
 target/ppc/ppc-qmp-cmds.c             |  3 +-
 target/riscv/common-semi-target.c     | 37 +++++++++++++++--------
 target/riscv/cpu.c                    |  4 +++
 target/riscv/cpu.h                    |  2 +-
 target/riscv/internals.h              |  2 ++
 target/riscv/riscv-qmp-cmds.c         |  3 +-
 target/s390x/cpu_models_system.c      |  3 +-
 42 files changed, 293 insertions(+), 94 deletions(-)
 create mode 100644 include/system/qmp-cpu.h
 create mode 100644 stubs/qmp-cpu-arm.c
 create mode 100644 stubs/qmp-cpu-i386.c
 create mode 100644 stubs/qmp-cpu-loongarch.c
 create mode 100644 stubs/qmp-cpu-mips.c
 create mode 100644 stubs/qmp-cpu-ppc.c
 create mode 100644 stubs/qmp-cpu-riscv.c

