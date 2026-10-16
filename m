Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBDCCCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmRp-00076g-4l; Fri, 16 Oct 2026 14:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRl-00075I-Nx
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRj-0000UH-GX
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5l9u2153755
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=8CFJipNOGa3dvJX39cOF2i
 JbhAsnWyISfpWnFsZ7TJ8=; b=HN0aJRSMWy8sNWVPmxvH8ZrqXhfgoRanYJ1McW
 5uziaX65mkNguFJC+PPG1V7Jz2s7QvfQQQe8WICVJH7mrt8txg/88o7rMcPeeRoZ
 mghtR/fEkqwGj46FF8vwSSmMHKdREK0sbwMeuzOkeQdXKmEXwlFIlQ2hMy0C45lA
 egcdrn/sbixuTKRBmbmJ0f0Lto4OvMkXPfrGso27NfEpmqLvqUb8VCrXOgIocDE0
 9hXMcSxoI6sQDZSYdNvXZqbKYoEMjJLQdgwnw2YfDNNifgpb8rL178/lzrd/JU6c
 CmmpcWKduCJ4PE+b1CrLrH6Rr3wXQBqCdSy0zi+zGGmKdp3Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhumsstw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a470ead068so305027a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174458; x=1792779258; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8CFJipNOGa3dvJX39cOF2iJbhAsnWyISfpWnFsZ7TJ8=;
 b=PoG2k4hmdlGN05dtCKksNMwMYmpVObl9AYBCwzbI0o9xdTn6B/tOLaE6gWU5OpWtwg
 VmFRtPWZq8+ZpJ9m0GM0fXN9oByuP9+rUz+Gbn6JTrikcqh40Z1jWNLnT8PAomeimr9K
 Maru40XmyVMIMPDPaV6Yuf+oOfSwOLXoRQwQoSzusPmwYosWyDPf75kdwIOfg3vAPwS+
 reFtcnIsvtoWjqgY7BGd6P/2SzzNs3jbVjwgFA7EC+FZYn/XhmH9M+4Vwp+U0mWjK61c
 31BHvaU5QBGv4/dOkh8Fbm77B7X4R0/VtddWO5KfSvKbyiemQAY6Bjr46c4eLa2hpEBj
 Bf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174458; x=1792779258;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8CFJipNOGa3dvJX39cOF2iJbhAsnWyISfpWnFsZ7TJ8=;
 b=MGpnkiUyP7aMZoJU2GMfO4Y1rkoz8bIsYHVwG9Of+9ylulyzLZScOP5TFSywavvqSt
 RMUh2gc/TzYurDSlkUKN07wWvw+2FVYh6KloYIfll3Mqk8qSk7IsOJ01/4JAHH13OduU
 cK8gmp+LzB05A630EWV4MZknYX5G2BKnhj+lLW8FjVTZwqx1+yYlDknUn1AhvHj2jkH3
 AnEyBmCwxZcOUq81y53Kt1C3R5I28KlpARnOzu2jPiu9p72enG83BO0R6LBzGjPnpkq6
 slDADymsbhAguGZBhvqV4IEZu+Uh9suOixL/5uzZJ+G5nRbH0BggDSlBIjF7UFwnEHgE
 CBFw==
X-Gm-Message-State: AFq9FYIn9a8Bxc8c4iEink9i/ZmvuSJZ+foindtCvt0solyT5853IGBB
 SWKWuc+N+WBvIt9PRWZdMbLLzUX/42FBdIDl8LIZ7rcJePPv9rg2e7/uYeN5WMyLN1X3ML5tQ8P
 RTC5GZMmE+nzUk6mcdVmEPnEisVDg9WTB9Wt2YHj9h7xgqlLc/ASxvXVTSpzJiUZY2w==
X-Gm-Gg: AYBFou1LAPlL8jWNuZd9Qp6vPLNi7glnZCcRel39e9NSPANmNFhOZYeJedCRlYNAq1Q
 1lMFPr4mrAUmQCS0ZWvWrO4sCz3kXinXyEplNvUP2ZnIu9tnB/xkBnhyGTvhuvrOIQd5eXUJRPS
 3leB0fyUmFIqfqj9PyAXPXaLR41rB6XpZ5gVoShE08XBS7fp6JACC9psh1PX/w37ST42EFZWRFo
 +OsAtMs5hnlPOA9kbgU8B6DuKuQ5eLuP1J0BOEn0dNJaCvZURIxpFRBq1mgUhpvZoGYuE0hB9zP
 clZannBmxscKX3VbaHXANcP/zI2PLX/fjBbWMhOu4ZbAviUnsmf4fyYOO6Q8rzzH7K1k7XTC8Md
 v0O1Rq/Byx4YQTRpffnxBio6X9f1M+tJLcZjAwSQE4bhDfbwXtPSXYNgILk6L8/A=
X-Received: by 2002:a17:90b:4b09:b0:3ab:188b:c5bc with SMTP id
 98e67ed59e1d1-3aceebb4bb9mr588957a91.14.1792174457840; 
 Fri, 16 Oct 2026 11:14:17 -0700 (PDT)
X-Received: by 2002:a17:90b:4b09:b0:3ab:188b:c5bc with SMTP id
 98e67ed59e1d1-3aceebb4bb9mr588931a91.14.1792174457237; 
 Fri, 16 Oct 2026 11:14:17 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 00/23] multi-target: remove dump functions duplication
Date: Fri, 16 Oct 2026 11:13:47 -0700
Message-ID: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MSBTYWx0ZWRfX0vuS7dIDxaA0
 lKTLcnJo7iZdYhGnjPXIwFY0IsYUClI9nYwigoqCrccio5hslZf7XIV9T23udodNDE9+eI2knn1
 Ld8KmFo4ISulWpHGfqO4bg3dwqnVpGM=
X-Authority-Analysis: v=2.4 cv=H+BOUOYi c=1 sm=1 tr=0 ts=6ad2697a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=kuKEfuKucTbmE4YA2pQA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Q814ObIscp3EYL30SLEJD4YmSeN4Lmgi
X-Proofpoint-ORIG-GUID: Q814ObIscp3EYL30SLEJD4YmSeN4Lmgi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MSBTYWx0ZWRfX80LZKDDa/tAI
 MkgSzdZQDBjHZVic5nL1RZRx0SCgVyinoYsi2ce3Bb34Im/R/uAsnBrldB/eoFot3xGHBsTIGYF
 xarkE9wlKFZdQKcDpzu3pQMvAEffTLjr6D5FhDQYzbDkGdj0wQwq6Rd+jkfl+bo63zydXSs6Jdt
 Jo9MNhywDWYhtSk9CHWpgJqBHlgSCBniAiL4QUPqQ5NuMbFRG75vBdorHwq3AgaHbJWBLyb3ymp
 iFGJt8RtppwgLNTDywblSaZu6qa/eHrTscraN+5nXL9lbC4+k6iwNaIQDGtyPIebx4D6UZ3x3/y
 Sgq0fNjsUvnEBjtRCM1Zi7OZ+JWQNnkYgggZcmEJBmiYjTWNQsSnPU2OLLmM9agz2pleU/MjEXr
 qTBGb6/Utyj18uoV7RXiNkDpyGYoTmxP5qqrRRE5x93/VtykVLp+N/lRzW7rjAnL4ESojJ2/RyY
 WOekUiHQ6j7yk7gb3dQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160071
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
target. For this, we define a new sysemu operations for a given cpu, and
implement it per target.

Existing implementations were using first_cpu, which is what we continue to do.
When we'll work on heterogeneous later, we can revisit this to either forbid a
dump, or perform a dump for each target active. Meanwhile, add a check if we run
heterogeneous emulation, and refuse to dump if that's the case.

v3
--

- riscv_get_dump_info: add const to riscv cpu
- use forward decl for ArchDumpInfo instead of including system/dump.h
- use forward decl for GuestPhysBlockList instead of including system/memory_mapping.h
- update comment for get_note_size sysemu ops
- add target_heterogeneous to target_info: returns false for now
- edit commit description for dump_init changes about why we can have first_cpu null
- add target_heterogeneous check in dump_init
- rebased on master (previous "based on" is not needed anymore)

v2
--

- Add new ops to existing SysEmuOps instead of a new DumpOps.

Pierrick Bouvier (23):
  target-info: add target_heterogeneous
  dump/dump: do not dump machine if doing heterogeneous emulation
  include/qemu/typedefs: add ArchDumpInfo
  include/qemu/typedefs: add GuestPhysBlockList
  hw/core/sysemu-cpu-ops: add get_dump_info
  target/arm: implement get_dump_info sysemu op
  target/i386: implement get_dump_info sysemu op
  target/ppc/cpu: constify cpu parameter for
    ppc_interrupts_little_endian
  target/ppc: implement get_dump_info sysemu op
  target/riscv: implement get_dump_info sysemu op
  target/s390x: implement get_dump_info sysemu op
  target/loongarch: implement get_dump_info sysemu op
  dump: use get_dump_info sysemu op
  dump: remove cpu_get_dump_info
  hw/core/sysemu-cpu-ops: add get_note_size
  target/arm: implement get_note_size sysemu op
  target/i386: implement get_note_size sysemu op
  target/ppc: implement get_note_size sysemu op
  target/riscv: implement get_note_size sysemu op
  target/s390x: implement get_note_size sysemu op
  target/loongarch: implement get_note_size sysemu op
  dump: use get_note_size sysemu op
  dump: remove cpu_get_note_size

 dump/dump.c                      | 27 +++++++++++++++++++--------
 include/hw/core/sysemu-cpu-ops.h | 13 +++++++++++++
 include/qemu/target-info.h       |  8 ++++++++
 include/qemu/typedefs.h          |  2 ++
 include/system/dump-arch.h       |  5 -----
 stubs/dump.c                     | 27 ---------------------------
 stubs/meson.build                |  1 -
 target-info.c                    |  6 ++++++
 target/arm/arch_dump.c           | 18 ++++++------------
 target/arm/cpu.c                 |  2 ++
 target/arm/internals.h           |  4 ++++
 target/i386/arch_dump.c          | 10 ++++++----
 target/i386/cpu-internal.h       |  5 +++++
 target/i386/cpu.c                |  2 ++
 target/loongarch/arch_dump.c     |  7 ++++---
 target/loongarch/cpu.c           |  2 ++
 target/loongarch/internals.h     |  5 +++++
 target/ppc/arch_dump.c           | 16 ++++++----------
 target/ppc/cpu.h                 |  6 +++---
 target/ppc/cpu_init.c            |  2 ++
 target/ppc/internal.h            |  7 +++++++
 target/riscv/arch_dump.c         | 18 +++++++-----------
 target/riscv/cpu.c               |  2 ++
 target/riscv/internals.h         |  4 ++++
 target/s390x/arch_dump.c         |  7 ++++---
 target/s390x/cpu-system.c        |  2 ++
 target/s390x/s390x-internal.h    |  5 +++++
 27 files changed, 126 insertions(+), 87 deletions(-)
 delete mode 100644 stubs/dump.c

-- 
2.47.3


