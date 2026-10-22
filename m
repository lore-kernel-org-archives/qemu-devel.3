Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CCB606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GdJtXipm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Iyf1fkAZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nN-0001kd-MN; Thu, 22 Oct 2026 17:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nK-0001jC-CP
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nI-0000FM-Az
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:54 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIH9UT1494698
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=eALf1Odmc4ER6OpR9PXon/
 fwX5OhpH0cpSiz0YtTKm8=; b=GdJtXipm67kxUAx7OU07LafE1MUFWXVund5TaP
 q5nYUGxYurIzIOSeadVvcTm3RgWhmYDWjoPNWsYL5O+CB6RWmFK021raUOc3RkkA
 0bsbHK5TcaGlO8/K4JJyd0T/JGOp/9PTF4KkzaolV9CH1t9I6ufaTZNQJqos/ykH
 BIbTbOO51cdAWAtPHDqQz6w0MQ56vlKJHFzG3LGF2vnGlgAiUtTUwv1MenA8CI21
 H8Mh3pvh1QW9Gz871vMofIeT7mXgJqr4s/3Dpz1KTxMxukZTFxM698raEfYo2Sxu
 se4GCqDC2UBlD1W+rzhlCtJiX/wn8oKhBPKmjyhLOUs34Ofg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr8q39-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac16335199so200272a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706270; x=1793311070; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eALf1Odmc4ER6OpR9PXon/fwX5OhpH0cpSiz0YtTKm8=;
 b=Iyf1fkAZ0wr+uf4qFWK0mH+eOFz5Jr+VaGpaGuyCIipFOs8UB6nPc8jk35i/8iKXsN
 C2hsNkfx+5oDtyE+bB4ZiEt3ABS54b8bJ3f7wHwVedCL/BwkLW3xdD9ugr2bx7vxh1ci
 j5Xc58WBCVeD4ZhM0oPc5KqLXuU4biREnw5JbAH0rDnSEmn2kbiZoaIhGtpWJKzBxmLW
 x2e6p1OTkyN33b+0rmpPdl3hIEUlRyE+EdCETr1eldb4YWqLcNs6TCkpZ9Uv2Jtc86eF
 aBjD6ZxN6AFA/jmzgdVdKoj0CDiuD3tUsi55FWqYaObwLLcmje3U/c8QZuHDAqnMPFXc
 m3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706270; x=1793311070;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eALf1Odmc4ER6OpR9PXon/fwX5OhpH0cpSiz0YtTKm8=;
 b=hlFCyM+0CwXNwQVdG7yWyVnF22xea6Hxkb+KHD66MlhyYWTBEMWwgGEmgk/KYuH5T7
 HI3VV8kd4o6DC3WXNs1AVE/iY44aQaKbinf1UuhMaytjo1eRf4tA4rE4J8CgGJJ0BTfx
 OpnOSNB8Xp0ZaqV1OR9qZ+dMSHgQ9OiSR1fGnImuJ4SBNsgJAPlA0Zk8cHpE0wEc/dR7
 idFYnOg8egh7Hz8D+pGmWUuCtZG3uEcWPews451hlG3KXH0HbFGLAjLqvCjdH+2MfrMo
 +QQmN2+4GHn1g1gLsfV8fImw94jpeRiqciuxQ7NskkvWhKy+a4w42RNZryiXi+FE+HZ0
 NcFQ==
X-Gm-Message-State: AFq9FYI/YIZSeNZXD8Lx1gVZ2stgKxp7J4Gm1sEh3E62AI+LzGJOyKK8
 JoaPLXJmtTGD9Bt761XZBHla22m4B03pb45BwOYre8KD4A4cYy6kwfIcTM4CMGhxd7aZ1Tf9owE
 aH9BaFXk1WRJpzKrgUHOvmA/kGelh7K4uBUC7o+42Ik/HJCdTnoG0NMtWPNZO8IGkMw==
X-Gm-Gg: AYBFou1w37/bACsjMDhLeajV/Q/cf2lgHSu+3Bl69F9YJXu8fAqj6pGz3MfUdDHIjT/
 aoMgx8g2IzBMM8v753Mh6pdShx6EUmfV7L1REsDosL/8YgrJZEAURp1qd8tjlk2okpnKWAJyA06
 FBoBQGwc8Pj+Tnukky2+CsDX+SrQ1mLZHcuQwBVrTQ9m32Wt/mj+T2FoSM+gK3AUCy3A0SSuJZy
 dl3CxhxSjuZy0Z5L3k2cDrgFwoDi7YnSiby0XEiCT3QObGMRaSZv+6apcawQxsecPBGIu+gxroA
 8S8R9I5yDzSL640KC8le9ajEmYR0D0N//XmdUjSRSxcvF5A/7TFFypSsKLBJHHRyljNbRo9k4wc
 UVLIVuYpUDTcbrL4BU4ib5yc+BinDvmif+5lJ17qlTa+1PmeeCYbPjzJevU6GQcU=
X-Received: by 2002:a17:90b:50c7:b0:3ab:ab5a:ef06 with SMTP id
 98e67ed59e1d1-3adcdfdb8cfmr200828a91.12.1792706269819; 
 Thu, 22 Oct 2026 14:57:49 -0700 (PDT)
X-Received: by 2002:a17:90b:50c7:b0:3ab:ab5a:ef06 with SMTP id
 98e67ed59e1d1-3adcdfdb8cfmr200816a91.12.1792706269261; 
 Thu, 22 Oct 2026 14:57:49 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:57:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 00/27] multi-target 20261022
Date: Thu, 22 Oct 2026 14:57:19 -0700
Message-ID: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NZGWE8F6Jgda_dZSKyUx6VGUIngVQzKz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXwgtc4ku6edIt
 ZvVPJx+yHfjrA3eC7GtJ8/zkKfLOJKJI552vymn3EGV3epJI6GecpXhiiHNg/q3pWeGXloJQxMq
 6vtn6veUdXLNKnqSneCGImBUDCPPQyU=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6ada86de cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xrDi-8IQUHkOiQaKMSsA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX3jqcBllcqz5c
 zuJlDyVXGSqdXsXAkbKFsu9WfbrwNydy+NnHa5X9F0SvssrmpEY1qaVCjvSj6W8Fvws6cq8QiTc
 x221uLC1fbGP1mgzL2EQzSlvbkWc7jaEeVLm6UWxOsSjXIwXqI3zv8Ne2h5huXzxq+HmPtqmAJ3
 5ZkvUGNhmB0O02Qrwz2PkdD9xWdQ+EdO2HW6domI8FtGRw1Z9rWwgHwxBMMqzeuT9czOBdznB7/
 rBQu13pPuuCB/f5YOJLW76Iakm313X3NtO5/11NKev5b/hhj8h98Fi3wzxR/TUNaOiaeRpllGkh
 zZplPdFdIM/hwGUKqheVeTFeeqYCMRvs/0oCKKDLd2vFH+IGX5cRALdjxvNDU9m9zjuwT4H0bAI
 aw1yWo/Z0vlJPfuXD4ufR5Oj5EA5wVYXV6gcB8+tcV0JhDUQlnICqo0tQxf3okdsO5uZIW64a14
 UpqlusNlApERZ0YLEYg==
X-Proofpoint-ORIG-GUID: NZGWE8F6Jgda_dZSKyUx6VGUIngVQzKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 4f4225874d4d3747ec1142e935dbd314218992fa:

  Merge tag 'pull-request-2026-10-22' of https://gitlab.com/thuth/qemu into staging (2026-10-22 12:47:21 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261022

for you to fetch changes up to 0e1015d2959e307fb91637b93339fe7d5ac145fd:

  qmp: reimplement qmp_query_cpu_model_expansion as a dispatcher function (2026-10-22 20:34:01 +0000)

----------------------------------------------------------------
Changes:
- [PATCH v5 00/21] multi-target: remove dump functions duplication (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com
- [PATCH 0/6] multi-target: remove qmp_query_cpu_model_expansion (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link:https://lore.kernel.org/qemu-devel/20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (27):
      target-info: add target_heterogeneous
      dump/dump: do not dump machine if doing heterogeneous emulation
      include/qemu/typedefs: add ArchDumpInfo
      include/qemu/typedefs: add GuestPhysBlockList
      hw/core/sysemu-cpu-ops: add get_dump_info
      target/arm: implement get_dump_info sysemu op
      target/i386: implement get_dump_info sysemu op
      target/ppc/cpu: constify cpu parameter for ppc_interrupts_little_endian
      target/ppc: implement get_dump_info sysemu op
      target/riscv: implement get_dump_info sysemu op
      target/s390x: implement get_dump_info sysemu op
      target/loongarch: implement get_dump_info sysemu op
      dump: reimplement cpu_get_dump_info using get_dump_info sysemu op
      hw/core/sysemu-cpu-ops: add get_note_size
      target/arm: implement get_note_size sysemu op
      target/i386: implement get_note_size sysemu op
      target/ppc: implement get_note_size sysemu op
      target/riscv: implement get_note_size sysemu op
      target/s390x: implement get_note_size sysemu op
      target/loongarch: implement get_note_size sysemu op
      dump: reimplement cpu_get_note_size using get_note_size sysemu op
      target/arm: rename qmp_query_cpu_model_expansion to qmp_query_arm_cpu_model_expansion
      target/i386: rename qmp_query_cpu_model_expansion to qmp_query_i386_cpu_model_expansion
      target/loongarch: rename to qmp_query_loongarch_cpu_model_expansion
      target/riscv: rename qmp_query_cpu_model_expansion to qmp_query_riscv_cpu_model_expansion
      target/s390x: rename qmp_query_cpu_model_expansion to qmp_query_s390x_cpu_model_expansion
      qmp: reimplement qmp_query_cpu_model_expansion as a dispatcher function

 dump/dump.c                           | 14 ++++++++++----
 hw/core/cpu-system.c                  | 19 +++++++++++++++++++
 hw/core/machine-qmp-cmds.c            | 26 ++++++++++++++++++++++++++
 include/hw/core/cpu.h                 | 24 ++++++++++++++++++++++++
 include/hw/core/sysemu-cpu-ops.h      | 12 ++++++++++++
 include/qemu/target-info.h            |  8 ++++++++
 include/qemu/typedefs.h               |  2 ++
 include/system/dump-arch.h            |  9 ++-------
 include/system/memory_mapping.h       |  4 ++--
 include/system/qmp-cpu.h              | 21 +++++++++++++++++++++
 stubs/dump.c                          | 27 ---------------------------
 stubs/meson.build                     |  2 --
 stubs/qmp-cpu-arm.c                   |  8 ++++++++
 stubs/qmp-cpu-i386.c                  |  8 ++++++++
 stubs/qmp-cpu-loongarch.c             |  8 ++++++++
 stubs/qmp-cpu-riscv.c                 |  8 ++++++++
 stubs/qmp-cpu-s390x.c                 |  8 ++++++++
 stubs/qmp-cpu.c                       | 14 --------------
 target-info.c                         |  6 ++++++
 target/arm/arch_dump.c                | 22 +++++++---------------
 target/arm/arm-qmp-cmds.c             |  7 ++++---
 target/arm/cpu.c                      |  2 ++
 target/arm/internals.h                |  4 ++++
 target/i386/arch_dump.c               | 14 +++++++-------
 target/i386/cpu-internal.h            |  5 +++++
 target/i386/cpu-system.c              |  7 ++++---
 target/i386/cpu.c                     |  2 ++
 target/loongarch/arch_dump.c          |  9 ++++-----
 target/loongarch/cpu.c                |  2 ++
 target/loongarch/internals.h          |  5 +++++
 target/loongarch/loongarch-qmp-cmds.c |  7 ++++---
 target/mips/system/mips-qmp-cmds.c    |  9 ---------
 target/ppc/arch_dump.c                | 18 ++++++------------
 target/ppc/cpu.h                      |  6 +++---
 target/ppc/cpu_init.c                 |  2 ++
 target/ppc/internal.h                 |  7 +++++++
 target/ppc/ppc-qmp-cmds.c             |  9 ---------
 target/riscv/arch_dump.c              | 20 +++++++-------------
 target/riscv/cpu.c                    |  2 ++
 target/riscv/internals.h              |  4 ++++
 target/riscv/riscv-qmp-cmds.c         |  7 ++++---
 target/s390x/arch_dump.c              |  8 ++++----
 target/s390x/cpu-system.c             |  2 ++
 target/s390x/cpu_models_system.c      |  7 ++++---
 target/s390x/s390x-internal.h         |  5 +++++
 45 files changed, 272 insertions(+), 148 deletions(-)
 delete mode 100644 stubs/dump.c
 delete mode 100644 stubs/qmp-cpu.c

