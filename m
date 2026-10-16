Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64421CCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHrGi-0002s2-65; Fri, 16 Oct 2026 19:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGe-0002rB-JI
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGc-0001RD-AU
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GNF9ur482410
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=XqjBAs+RKAeUXk9lpRNbHR
 RhQhU8DpFSClWEki0j3PI=; b=iBBmM8TIP4tjy12qsPJ52UILRHf8weZxDG2KqO
 26I4VBftwXdX09nJhj2saPsvBcFo25ZDEkDh3cNjAB5jC4CzvV5Tyra2Qh8eDX+t
 JfZHw9s5VCDzBJgwMQ3jQW/yRoeO/fSNYLf9+1E8aUQrJ2nllpAhaUwD+5rcfjsW
 hXWvJD5PKEJbWR/jg1KyCIyls7Ao51fEQuzYt3FqJ0KACWJG36pkQJ77IsNcs4KP
 e38zyopIaPYg/vGzfhGRnNL+ghX5e0IQaEmDkYlyq8Hu+xQvcD2a4MK+aOAAez1a
 B11lnBjfZnrHb0BudspNPqDdt4yikKZhHBEvy3vdDf6lj4nw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbrvwgxp9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a46f0f158dso576546a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792192990; x=1792797790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XqjBAs+RKAeUXk9lpRNbHRRhQhU8DpFSClWEki0j3PI=;
 b=HZAIwABprpYFLDBXy3zQAEUijq+yJmg4E7zWpavTBq6xzN9L03EChWERLvKTTH84sE
 WYWxNH0YFzsiCA2l4jaV5FVf6+dHIB/TGHx6TGvdHobQKyOsMB3n1aQl4GOE1v0Cj6FU
 BE9GpXZ6bU40Lp4w/GhaUdY+5zmMTvpm1bPXJG1rlecX1mp7TIFvkZ08tK4qfwoJ6sIu
 XCfPDz8ORy6ZxH8ztl+COEGC5BNhG5wFfXBw6ObrEEgzjztLkLDsd/bvDlWRVMJsTkGB
 8nYkV5GcFmrpx48dpIppXBGB/fE8DzVskbLtg4VVEikE/JhjhFNOYrFvzgDjfLmjkW4B
 9ETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792192990; x=1792797790;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XqjBAs+RKAeUXk9lpRNbHRRhQhU8DpFSClWEki0j3PI=;
 b=mAsqjxzcFix6VQXcq9OqZtVhrEMcGLJgSYxumywtr0slbHX3OeZONZ5e6IH9jGofZ8
 FomvBVkEZypYhaV16kOcCLQyxAR59O1yOTI7/Oid9+gacku7ljS8xHJa6n0QavYBNU9X
 nvcFjUbs2a4RHiwie44EYpKImaA18LIC5LinGPxg9NBA6AecE0rmdpFlhCZHklUTUInz
 WFaivauKV5oT01bdW3/55XH9V0A8deMu8utO00S8skZuCac5a1mqdof7rhDqvDaWU+8u
 l+SJpZgacznv5uxpCaB+DAFT6VlfTow3+/seiZW/Fqrd2HcMpMhrjgceT68RwCGWynTn
 ZktQ==
X-Gm-Message-State: AFq9FYLUBi8UdoRbcRFbBzjzrFdoRYSRad1p18GIFxBTJPJfVWG5kTqz
 FdP8LOq4NQ9nTis7uEDIgrTn4b0lNsIoOgDNIDpLk66YiqQCeTdAbpJM9pvG04yenfIMm+RwbJG
 dPcCR0NbkeGPkNAZIo/al13bfL0YsuniX3aDrTpgNOCW8Hqa/PrHpWSPvbnatpA3r1w==
X-Gm-Gg: AYBFou35Hp7mQ5iazMz7yTnHYVVt2ipQkxnrlPVQaiSFmy1R+Yu6aunNy+xZwzi6WVB
 wYHTldvAyQA+HHIvlmN9/SOF1Sdj7iH2OqmxEUcZvaL//DjYnly/Xfng+dP6rew8BGiEzn+D+CD
 7TZh4682zi8pupZJzr0IrLygom0LyWSKlMGr6iHhFiWpgYvOPbWGCqSQO+Qxwy4BoasX/aCtZuL
 xHGgfOrI43LxCrqvJqIAg72CP/W3IDu8VVcsFhsj14O3rPmeFJ37ALUmskRcoy56TeBoWF01SdR
 4Kh4wU8jR5+LrbGJsqHr6tgruzGruQOXKnDS471wuK738+M6AF5CI1zAi1fVw2BylrHI1vz9oOT
 HZGWV3/6JaY6NZbaoA+LqXq0dRzOiNPaYQRCb0NUnty076flBTY7ZdMiwIlBw3ys=
X-Received: by 2002:a17:90b:3e85:b0:3ac:36c7:c144 with SMTP id
 98e67ed59e1d1-3acef2b4edamr706430a91.28.1792192990393; 
 Fri, 16 Oct 2026 16:23:10 -0700 (PDT)
X-Received: by 2002:a17:90b:3e85:b0:3ac:36c7:c144 with SMTP id
 98e67ed59e1d1-3acef2b4edamr706420a91.28.1792192989867; 
 Fri, 16 Oct 2026 16:23:09 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd0cde4fdsm2829304a91.4.2026.10.16.16.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:23:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 0/9] multi-target: add riscv64-softmmu
Date: Fri, 16 Oct 2026 16:22:55 -0700
Message-ID: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pH3lx2n40BQnmstVCSyUC2Vt_nwdMpfe
X-Authority-Analysis: v=2.4 cv=COa/zhrD c=1 sm=1 tr=0 ts=6ad2b1df cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=wvi6n_hDwa1uRB3WN3MA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: pH3lx2n40BQnmstVCSyUC2Vt_nwdMpfe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX/G4GGTeBXoPr
 9/xsKxkbFrwvUzFanjsTmi4P5YV0/Al3JmYOMnXGXzGl3sZ2m9NpovPnHFjV03rxFUTylfeWAiD
 DfL05bwzO/UpsZKQagWFJcdNCV0FmXo65ALB02bvtUe1cephPP41QsnX9gvZBvFHlaSkoXaqj+l
 DLRtgyCQTKUVmVJ3sk+qB1ZD1Q5pzCx2ZjkYfXrfweKIuwYk4PAsEer5PwIDHRF8AW1B2iI20ra
 2YbHDzyyKUeLa/XEFYgkA5MPPa31jX5HYhV8RYvnUHD19gEW08D6ds+PwX7E2JU4oDRA6gB0woX
 /fgcTO2F1audqGQmG5JGtpgHpdENCtM11T1TWIEbc/VV373WnKyEi+MU53gb3XB0QiGw7pzABKZ
 QhK9SmuGbva8qTFd0HJyNhcDZnFRP86jE+437OmMhjzOQM2P5HiXYEF1Hp5xn1ohjBzQJ65Wi9r
 dFWaUd6YK1WnZ+BjWPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfXz3FQUlyeumUs
 TU4BGDi9nEfTmUt6QdX3XYJNdqvp6XskDl3Od3ldiJnETNa2zvj5eJa7STju3TxA8KVtWs11QfD
 zL1ZL+3I4zDMhmKGeejZ1PnCKCadnqo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160093
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

This series adds this target to set of multi-target.
Changes are straightforward: functions and helpers renaming, and one type
restriction for this target only.

While the series applies cleanly, it will need those additional two series to
build multi-target test binary:

- Based-on: 20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com
"multi-target: remove dump functions duplication"
- Based-on: 20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com
"multi-target: remove qmp_query_cpu_model_expansion duplication"

Usually I prefer to wait for series to be merged, but I have good hope to catch
the freeze date if current series is reviewed, and send all three at once.

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
  target/riscv: prefix helpers conflicting with other arch
  target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv targets
  meson.build: add riscv64-softmmu to multi-target
  meson.build: list all remaining softmmu targets as comments

 hw/riscv/virt-acpi-build.c                    |  2 +-
 hw/riscv/virt.c                               | 14 ++++----
 include/hw/riscv/virt.h                       |  3 +-
 include/qemu/target-info.h                    |  7 ++++
 meson.build                                   | 18 ++++++++++
 target-info.c                                 | 11 ++++++
 target/riscv/helper.h                         | 24 ++++++-------
 target/riscv/tcg/bitmanip_helper.c            |  4 +--
 target/riscv/tcg/fpu_helper.c                 | 16 ++++-----
 .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
 target/riscv/tcg/insn_trans/trans_rvd.c.inc   |  8 ++---
 target/riscv/tcg/insn_trans/trans_rvf.c.inc   |  8 ++---
 target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  4 +--
 .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  2 +-
 target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |  4 +--
 target/riscv/tcg/op_helper.c                  |  4 +--
 target/riscv/tcg/tcg-cpu.c                    |  1 +
 target/riscv/tcg/translate.c                  |  4 +--
 tests/unit/test-multi-target.c                | 34 ++++++++++++++-----
 19 files changed, 113 insertions(+), 57 deletions(-)

-- 
2.47.3


