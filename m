Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D5606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fm5jv2y1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iacjhPel
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKV3h-0004c0-RC; Sat, 24 Oct 2026 02:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3a-0004aB-MW
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3Z-0004Zk-00
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:42 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O3PwHM468015
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=wQ8nF4EjWHANURKWbi0O2w
 noiKDEET7aWO3ffIRMDdg=; b=fm5jv2y1vW/NtlOj91j5JjNKq+dFurDhF4BIa8
 qC8ylWt9YxualL45g3L+cHvI6IRJwAEUhypMxXv5mmFsf+d8vqOhIdGcNPUFMRro
 v+O1Pl4QAvY9BiEHvnx0TGzL9W2VZAJhmxHdDrs4Xx7fi0OQv4F7fbIXjqywM3XX
 /6p1So5vCx8gYfP0E7IgocuOv4WZQ6AJM8u6gxjRpp+wFm29My/HmtJOooV0OX5k
 Aqq0m2631z53U2v+3PrMhJ4HYMaSYtr8nL1v4yVSRvU1bv9RhfoDC0uBhIovqIis
 7ab+jN+xoMgrEsae/wvN62+Ow1xhg70x2C9tM1DqXEBmW9Lg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmrug9w0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ade5b3ae97so400031a91.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792822597; x=1793427397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wQ8nF4EjWHANURKWbi0O2wnoiKDEET7aWO3ffIRMDdg=;
 b=iacjhPelGl4VDl2+eDyfW38cUY0+FAtMM5JwH2AQInmfsHbdogR2rvcS6K4xb2k/Rw
 D5f+D1+NphdLPWKR/ecL2T8hehU9ILNkDfty1C9qvvG6TjiZOk6u0Ef77QrUsDIymmmz
 WieIL68H0iTyVZ9AoNs7yhJxxbY5+WpHFywRu+X9PlEoBPkEVTUcAWgzQBaAlwD8v/KA
 k7ym8z3r/+0FkWj9OST4p++UsRWmRpBdkXbJ0FiCdSJXrHjS9OeE55EQL8JCJFFo4jl6
 8KbvtxkHbidGUwyEjlJGzUHsXnx3veoEJVHAg4TbjvAey7ZK1ThMKfOUMhZiot1t1U2A
 /69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822597; x=1793427397;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wQ8nF4EjWHANURKWbi0O2wnoiKDEET7aWO3ffIRMDdg=;
 b=VdSD7NBCDaikeWXMG7YK3jgT5hsSfmVbNtyP3AUW8C5Nmb9484ZZJSTjRj1D+6WVla
 rF1KkEEyhOq/q3MljsGLbBQ2AzZPvMh1EKNuJasQPxYbd/psJcljUb6dYVRKqXy9JHN1
 o5CnKzf3ERqoNhLa4EyDgJikpea6eyxeLetnHsYUHiXNYsa+aG9OIgGTcGRCIP3FZe9q
 BuLjLHz6RjaNU1B13K5YnloA1Vin9twCU+OyEE7NzPokDnry0gTnVdioruUG7oxghB9a
 kymbyWo2caWsBA6aMDX0C9BShQ3T2O0qf49OlGwBXh+u9+JjaYurbljyP8YQGgF+E1s9
 0ATg==
X-Gm-Message-State: AFq9FYL/RdW2JjYlDyj3lsz/5PJeTC1aW+GsLpsaxGiUzQQyirv2F+AT
 2QIs5h0svTowuReufx9RanX7ics/cd4rETcY6ZkQbgcNQ/lsB9TN5hMPwRw5+9AvIfTin9XULqf
 ZcVl9cQuU/Q42S9/lENMijlJ+BkgO6DqN9hwMD5DsHj7wc/+D4hA5od3bg7zaB0e/CQ==
X-Gm-Gg: AYBFou3yBhM0wusnshhZK+VTZ9BwRqlcFegavBrh4qjvFBNNJ0ujgnNoWcBbEjtZKSS
 tfnv/VzG4OvEsjWQNwtcM6n6cIH6JEccv6Zuaj4Jfyxjr6sPaS3yrLtczeivtPHPyf08DKaz9kQ
 wE/sQoilA3vcD7JgagYjOO/CWIltpv8l/xrkfi60hh5OuwWv+WKj8HaVmOdP0mykTB8qacoUxxV
 kwS3NUhzV8rfoC8/kTCS2SU61dqKt+3E5gzfhSp7MOEYj2/NqgiyMb+wv+hgRzRMjhc9ovDPWfY
 kYzb8wsNnUUqHXiNh4B9b/SEVp1XhstOyTwp3n4CV9qjZ0WNuqmf1X7lR0CiafJuQl+Dr9P9/ej
 b+qeYyP2fL3+4+gBGpU2oYrOmFxprBrNqvnheUjCnQORmUx38FPC7Nj9YFmeyDWA=
X-Received: by 2002:a17:90b:3f43:b0:3a0:2900:f55e with SMTP id
 98e67ed59e1d1-3adeb5e5ba1mr800836a91.29.1792822596873; 
 Fri, 23 Oct 2026 23:16:36 -0700 (PDT)
X-Received: by 2002:a17:90b:3f43:b0:3a0:2900:f55e with SMTP id
 98e67ed59e1d1-3adeb5e5ba1mr800820a91.29.1792822596246; 
 Fri, 23 Oct 2026 23:16:36 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb1e37esm1074882a91.4.2026.10.23.23.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 23:16:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 0/9] multi-target: add riscv64-softmmu
Date: Sat, 24 Oct 2026 06:16:06 +0000
Message-ID: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX6oQPXDldYIfP
 UCPEOCiz9bazKYZ/o8K+IrYMsP6FHWK+6+aUizoTYUcbDVKXLMBDRPj2jRit5GLJi4KI7hr8my7
 1dP1apPLrx9KX0lrweJ4jf5yi94Bfju3B2WujRO2qooEWGC5pat6oozVpcWKazUHV5G2ljqifB+
 OEvSbBG7D4OJ/WBlPU/AKgOr5CSy7II12Ylu+hJm/GrO3DJsvHp+uoghEQ+FofQHKnhKGHnOElb
 BMePgToQlxKWP2AELui9oCOgOpmEkRdffOIWHVLm0lJFVgANFI2Z/sfZTRpXui8HDsyI5HM+aOE
 T3dfCiD9Kk5BvknOlvNIQ473WfKETwMPxbmYv1/WLLL8lOWI6ruPJVLO/BfsV5xAb81XPjodWHn
 8kUJXhtT7M503sovf9UlrG0FwlzOdb7AwDHLAMOKyyLE4lJsuIQzHAx5oCdO+dgEKcKT6bD+4oG
 hA1JzoGFRWVzbqot/eQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX0ubFe5mcDsTj
 DnOlUZegMppsZvnmzXA/3rNBsOHfcteVTDnj/FrPadWCcb4TWq1cgSAiiiI80izAbpEbIo6omwX
 cT9Ke+5a/M4CCYZd+coj2v7QHUu9AHY=
X-Proofpoint-ORIG-GUID: PnowBugzzb1u5xsK9dxay4zf0tequcNC
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adc4d45 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=q1JEB58aOUwSyPitUGsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: PnowBugzzb1u5xsK9dxay4zf0tequcNC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240024
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds this target to set of multi-target.
Changes are straightforward: functions and helpers renaming, and one type
restriction for this target only.

Based-on: 20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com
"multi-target: prefix helpers with target prefix"

v3
--

- rebase on master
- dropped the patch renaming helpers. Now based on:
  20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com
  "multi-target: prefix helpers with target prefix"
- fixed issue on riscv host where kvm cpu type had no parent type in
  multi-target test.

v2
--

- make virt machine only available for riscv targets
- enhance multi-target test to detect duplicated types between all targets (we
  missed the virt machine since we were always picking the first target avail)
- add an additional commit with the rest of softmmu commented for future work

Pierrick Bouvier (9):
  target-info: add target_base_riscv
  hw/riscv/virt: make machine available for riscv targets only
  test/unit/multi-target: check QOM types can be initialized with any
    target
  hw/riscv/virt: restrict scope of virt_is_acpi_enabled to this file
  target/riscv: rename virt_acpi_setup to riscv_virt_acpi_setup
  target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv targets
  target/riscv/kvm: restrict kvm-accel-riscv-cpu to riscv targets
  meson.build: add riscv64-softmmu to multi-target
  meson.build: list all remaining softmmu targets as comments

 hw/riscv/virt-acpi-build.c     |  2 +-
 hw/riscv/virt.c                | 14 ++++++++------
 include/hw/riscv/virt.h        |  3 +--
 include/qemu/target-info.h     |  7 +++++++
 meson.build                    | 18 ++++++++++++++++++
 target-info.c                  | 11 +++++++++++
 target/riscv/kvm/kvm-cpu.c     |  2 ++
 target/riscv/tcg/tcg-cpu.c     |  1 +
 tests/unit/test-multi-target.c | 34 ++++++++++++++++++++++++++--------
 9 files changed, 75 insertions(+), 17 deletions(-)

-- 
2.43.0


