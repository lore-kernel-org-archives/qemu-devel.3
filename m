Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25C7606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KpvZmI0u;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MyQBF2Ta
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIusz-0002gr-33; Mon, 19 Oct 2026 17:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIusw-0002gU-9B
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIusu-0006Iq-Gw
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:10 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK0OJ3328401
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CrX0xq73Pwx0+Y/YNg1mrh
 Zy2nS+uNgYn6BYKGSixek=; b=KpvZmI0uTIcMsgbeJjZMuxCEkDuyGw+1hfnZ7b
 WYXBLFmorlF8iNDEg/jFx8/OYczFwggkY1Go6qJ6tSEZNh5OT4b0PMtpthlmMQD5
 unGQ/EmuB30b7Zf4V6V5QAW+jLMRly54hS978Mny9CHax76eOwJs3UzktaWAgENQ
 S9ff0KfQk5X+L3epc0RyT6QNuxVWmGXI9Tz0dQv9YQavoemD9LlLUQBeq12ORdTc
 BP6jbdbgHZGkBi4CFG1IYIbRixQlLEiXp6uBdUfwS3qL8aNDDr+vCDvvzA2utC02
 qFaPo0t0pkRSYHK6p/Soq/RkEp7zTzgsyiaJmNqkgtOkz0bw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfj34w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab9850456aso4063385a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445225; x=1793050025; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CrX0xq73Pwx0+Y/YNg1mrhZy2nS+uNgYn6BYKGSixek=;
 b=MyQBF2TasH4DY7AxqmaLdtt7DcEv/zFt4V4u8tY/BwjjpFH/AL+x6tfFW2ov+d/v8G
 lnD3MDj2xLvnEA3ynPvb0vBwtFbm//j9R82SnFezULq8c1YSCFvww/6gMrggvskolTZ+
 T4/qBL7oNIFsE++feELTbiJmt34vm/6O2XMUBcUdsR70kDVSIGn/dpE7baieoCOexQEw
 VOL+YVMyk29KdDThRSRbSnXE21gVBb9DqHC7CRT0taaHQ6QXbwGuofkE5PtDTsZHrGVI
 1CvzAg0Uz4UIjOwYDIgAQYvyzLJPMC7XwCpiWT5C7FzSqS1CAYP1I3Sx49+NfcGaSMAj
 4+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445225; x=1793050025;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CrX0xq73Pwx0+Y/YNg1mrhZy2nS+uNgYn6BYKGSixek=;
 b=JWcxCGH+ZlDsufR6uQ4aCmiZNOpZ4n+qOosf1ZG2A32zAeZI2qsobPyFNm0pa5IK7K
 Hu4X/nmN9MeQIlRZn4zdornM++vjFFP2l3jyClrO7eDVPn359oSsk+UgHLdABCoc8sUt
 o+Pkrp5V2vqj++zIwPd2albJRBD9F/3brv8Sk+eJnJhePs7BorPjtqDSD8q9kvTmK3ms
 uCHqtJkf4Bd8OK2dMasoOOxbGbhN2HwcvWHTnGfbDsxdHaGKY+go50ZLNgcbOesC271B
 6k2uRVz08Urc2T2fRXQw+FJc5x9sg6bkTq5PYaV9pPOsZ8cAlB183OjsDd9arntLKjBP
 9SSQ==
X-Gm-Message-State: AFq9FYKjOWFoHBjwBXyxx01ywc328yBiIpU/rS8+C6dfSuoW3OyERuoq
 BQjproXI2edJKXzna37gaKfJx4gfNwPid1i4d34VVRbMNF3KfCGWYMUYNdeBOz6w9l6YqjfCXwX
 ZCAG5AAnMuW5Xew4aIQmV4zwYxfhnp/vVKjgA+GsDu9fTIE9u8f6nGj8TXZPEvHt+Mg==
X-Gm-Gg: AYBFou1qEUTs1GklAgQ62GeJunh6Enw6drnOFcwkj5BWw1X8wlLye+jSNk4Z1f5gyWL
 K3uKMtTlwNQdeh6iaURAjuq74E74NN05LLgJR9G7EJx0dlz19NYTDAvOvu8RE3BQ91Pjatjg4lU
 MpkXY5LoFc81ILS+C1qAWR7Zga+8ZFatpr1IFgE9PPUDJKkVoixY8QrJCOUXPLaBCtKYP40l9PA
 Wi/H4EsXhWodx89bjKUHiZ0QsPKJTpHyWURywMt4tiTIPxw5k6aPZh4a48b1J6XrH4DixwZHAs9
 4WZoycowngOqkOBJupHAcOMHww0wB0s8XOJYaiu9zFB/kFW9s7tyrAuInHoSAvl8VT/ZgQQcD8O
 oJ89rbbpGtN0YpwuWMYkStiCrB68ZJZFcKTJsx10CMt38O533FcwI3N0L5Hx0se8=
X-Received: by 2002:a17:90b:51c2:b0:3a4:f75d:d1a3 with SMTP id
 98e67ed59e1d1-3acef0c891cmr8318678a91.32.1792445225572; 
 Mon, 19 Oct 2026 14:27:05 -0700 (PDT)
X-Received: by 2002:a17:90b:51c2:b0:3a4:f75d:d1a3 with SMTP id
 98e67ed59e1d1-3acef0c891cmr8318662a91.32.1792445225022; 
 Mon, 19 Oct 2026 14:27:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 00/21] multi-target: remove dump functions duplication
Date: Mon, 19 Oct 2026 21:26:27 +0000
Message-ID: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bdh9vV79kUmsTpwOLLzT_YXLLV8xqdBO
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad68b2a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=kuKEfuKucTbmE4YA2pQA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX0SJqhHeP7A6G
 27fIbofFmPni35H+msZ0hOFSm3/VXIuHcqtTqg8M3oCr2MtIcGP5byvu2kAEVCrV6jd7HnXPE1O
 5FKxTRAHzx1X6AKlrPF6P7Oh9N/GBhEcf0OXtWyYFH0ALXtm/u5G3DPRI7RhD4OpU3xbia5N6jx
 29L7FEAwvh8NoqqlZQBvcYTpr3nXeDo3gc3NUGCIIZ0zg6GXyKKZmU7PXEOWPpEk//T5+DnZPfN
 OC6imoBqqFdYr8IOEeSGh6HAEVDgnto2RuPn6McKaCZOx/TOhCawR89qsIM8s+iDaQO14yTvb7A
 8GuoJZqAz06t5wrp3c79iYEzfiyUMQ5lKXdppld92Rgvob8Tj+GS6wpY1ZB124BCdbsbWaAo9wI
 Ow/LVG2KcKMmqLKDAS1M6L1x9WFFOQHCm4Ha28ezCGjOs6mAAu9Sreq3m2I04BEo+XvToywjmzL
 XXu1UsPO6hlvCu76YOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX4Eq+e8tIkK7t
 yHGNeOkpuHOgWRtH1qIs17Y94skypvAJ2x+giKvBOIZrnoNdcPEIC13zNotKN3uydVc3jKCYqrb
 saeDW/F7sjpzXQhXCkPOynPcUNRBmtM=
X-Proofpoint-ORIG-GUID: bdh9vV79kUmsTpwOLLzT_YXLLV8xqdBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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

This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
target. For this, we define a new sysemu operations for a given cpu, and
implement it per target.

Existing implementations were using first_cpu, which is what we continue to do.
When we'll work on heterogeneous later, we can revisit this to either forbid a
dump, or perform a dump for each target active. Meanwhile, add a check if we run
heterogeneous emulation, and refuse to dump if that's the case.

v4
--

- define global wrapper for cpu_get_dump_info and cpu_get_note_size, both using
  the sysemu op we introduced.

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

Pierrick Bouvier (21):
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
  dump: reimplement cpu_get_dump_info using get_dump_info sysemu op
  hw/core/sysemu-cpu-ops: add get_note_size
  target/arm: implement get_note_size sysemu op
  target/i386: implement get_note_size sysemu op
  target/ppc: implement get_note_size sysemu op
  target/riscv: implement get_note_size sysemu op
  target/s390x: implement get_note_size sysemu op
  target/loongarch: implement get_note_size sysemu op
  dump: reimplement cpu_get_note_size using get_note_size sysemu op

 dump/dump.c                      | 14 ++++++++++----
 hw/core/cpu-system.c             | 18 ++++++++++++++++++
 include/hw/core/cpu.h            | 24 ++++++++++++++++++++++++
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
 29 files changed, 159 insertions(+), 83 deletions(-)
 delete mode 100644 stubs/dump.c

-- 
2.43.0


