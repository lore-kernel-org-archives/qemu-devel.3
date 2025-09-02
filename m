Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84ACDCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzg-0006gd-Q5; Mon, 01 Sep 2025 23:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzb-0006ew-74
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzU-0004Q4-PQ
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SMP8021885
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=rW2EvpQ35YOTNE6kmWfvPL
 hwxNuKJ25F1D7d/SD94Yo=; b=hBP3Kt2Qdr7aIqETdRlWv6D9KjIZYpYZP7rgev
 WexwkM25vyXsKaharcQ8eIY84hyCCzxelT5vbxrLyMJCU/kgNqH06ENecLtOWveP
 /cOkF3bfu4YjVF7fvrEpENBMSv659HFMkfsCMmO0JS9Y3FUAnF165wCO5t/YFm4k
 7evnzKUTzoJidLnjn+OnMG9I4UrfIPGc61Uw2+ryb9C85nyAqC5shO3zNyuXafkG
 rDvki+1nZiAGPgIb6yX5LG6IKfVnRqLJx3lIYQfv+QCJn/KqUkUZbo2J8B7CME4q
 df6TdVDwS3C5QfXEJE+jtExA+bIY/xzQG0u3RyV3hHwpaODQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8rxf17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24ab0409d3eso35573105ad.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784843; x=1757389643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rW2EvpQ35YOTNE6kmWfvPLhwxNuKJ25F1D7d/SD94Yo=;
 b=CsOMhNuuwi4VEnkyqBRBDqgcQjW1llCZ4JdJa5/q43svlpdBciyfpjRfrX6D6wjHAV
 11KJxFU6YQmTAhF7fQUnIDZnwyPJHEF74m6NKdpyBzuy0frbTtk4ggHyYW8fojuQuQ/H
 r72haejRx3HprfAaMuF01449PqZB+SFqHjPu5wY4IhV4hmbZ4u2cf8+rW2Bxi6RZZrLW
 NvF+436nCnc99j48TKMOidUX6dqlugrUe3Hg3+q+rjYg/ZPPrd8ALW6XTlZRlf1/93ni
 Hslcp57zad3X2QQIIqiSRv6pAMcSG9N9joticZG1NZkCN9qRnu9DIqUG5M17upG7zhHe
 5W2A==
X-Gm-Message-State: AOJu0YxqtpCnVRCWe7MQSP6ygIuqz02kDz7R0gKMWhr4CzZYje+bMWdf
 +vrSxL4f8+RL3ANaX8WHYFjARTF9ZFcsKu/p1DO5m7ntvVKBEPrB+LzAjzpF0lI8oDAjlW+lZhP
 OWCiuWdkvzOJbWF7TRZOtqo5iMY5AlKzbDstE0lmODS7p01YFlisUFKnwgpG01rx8DOqk
X-Gm-Gg: ASbGncvFeiKa7CO6ZCP92+p8b9SrFAy2YUX0Ba3iFuuP7TSyLshO3HAszrldCCKwm/F
 DPcWmoBSEFi3nATwLh5pP6K+kJhYi3WZ+BHbo33sHbsNseMIdfRtA/NnCSRp6dHdr0rHSi39DUZ
 OK9Tm/8+1bwur5RWxDJfQxrMjSCa+6wQ3kWrBrVp/NiVy85o0Lv/i7gMzWdcJ6avTfbNhXmcuFb
 gJGVQM50v+/oGsHUc4D7uhx6iJssO9p+R0B7daNf0sSu8zQDMFBEerbsKVxtx1psZF+/Sv6zPQO
 rVmjIDTk4QoL/1NNIXDAO/eaG52rX6Q2XenbQWV9WV1wLVQ6BliVGRfHZ/D+G7ESviIV+8UY38a
 LC8VHh0WOhBTL
X-Received: by 2002:a17:903:38c7:b0:246:2b29:71c7 with SMTP id
 d9443c01a7336-2494490485bmr125406075ad.25.1756784843176; 
 Mon, 01 Sep 2025 20:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRlcjf7VxIHQu+OOB4R3S3Fz799XhQFxy+8odnNsc5un7ZxNNv1Jq+W/gEJzx+zNQxLivgig==
X-Received: by 2002:a17:903:38c7:b0:246:2b29:71c7 with SMTP id
 d9443c01a7336-2494490485bmr125405685ad.25.1756784842639; 
 Mon, 01 Sep 2025 20:47:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
Subject: [PATCH v2 00/40] hexagon system emulation v2, part 1/3
Date: Mon,  1 Sep 2025 20:46:35 -0700
Message-Id: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX3moNW98iiP9M
 ZGJYGEaqVFJ6uDWQrU1SDelP9WTivrqJzyxCGSYTF6U5JJJ7dLnO7Gz+S9qJXuaMveI25JIe6g2
 0wQQKHgXVIdV5+jOGyinpq8OagNySUez2/TUowptvEbxfyXx3tkv+sDBt8EMALrRqYY0P9NQqp4
 r4zFDs24rPmRIW/3Lm3SZul4a9efaGp9EL/P+RX0JENoDRcC21BsecuF8+H3iYD6WPwF6TjLbb2
 ZMTm8y9YSwQyGf7RyjpUbl1nMRHSHOo4wPB28AeSJq2NI9/zxxaYlvDWdgCS8ZSA5tNksUxw7cV
 5HfnO31vi5XEM+AXM6H2F9fsARBSzMytI9jKrLQJ8KHdANTZq71j5qDAo8pKMch+H79OvPzvXdG
 jHandaZG
X-Proofpoint-GUID: QExWSd12U9-wQvDePCrg0I5GoOHkP-lW
X-Proofpoint-ORIG-GUID: QExWSd12U9-wQvDePCrg0I5GoOHkP-lW
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b668cc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=4azlsQMGSF3UK1F-O_AA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Several review issues have been addressed and the series is now rebased.
We are now modeling the global system register state as its own object, and
will likely want to follow up in v3 with a similar change for the global
TLB state.

Issues not yet addressed by v2 (will work on this for v3):
* "Add TCG values for sreg, greg" - combined patch
* "Add imported macro, attr defs for sysemu" - excess attributes
* "Add new macro definitions for sysemu" - READ,WRITE_SREG.  Are they needed?
* "Add sysemu TCG overrides" - arch_get_system_reg() as static inline
* "Add gdb support for sys regs" - checks / mutability of regs via gdbstub TBD
* "Add initial MMU model" - hex_dump_mmu_entry, cpu_index


Brian Cain (40):
  docs: Add hexagon sysemu docs
  docs/system: Add hexagon CPU emulation
  target/hexagon: Fix badva reference, delete CAUSE
  target/hexagon: Add missing A_CALL attr, hintjumpr to multi_cof
  target/hexagon: Handle system/guest registers in gen_analyze_funcs.py
    and hex_common.py
  target/hexagon: Make gen_exception_end_tb non-static
  target/hexagon: Switch to tag_ignore(), generate via
    get_{user,sys}_tags()
  target/hexagon: Add system event, cause codes
  target/hexagon: Add privilege check, use tag_ignore()
  target/hexagon: Add memory order definition
  target/hexagon: Add a placeholder fp exception
  target/hexagon: Add guest, system reg number defs
  target/hexagon: Add guest, system reg number state
  target/hexagon: Add TCG values for sreg, greg
  target/hexagon: Add guest/sys reg writes to DisasContext
  target/hexagon: Add imported macro, attr defs for sysemu
  target/hexagon: Define DCache states
  target/hexagon: Add new macro definitions for sysemu
  target/hexagon: Add handlers for guest/sysreg r/w
  target/hexagon: Add placeholder greg/sreg r/w helpers
  target/hexagon: Add vmstate representation
  target/hexagon: Make A_PRIV, "J2_trap*" insts need_env()
  target/hexagon: Define register fields for system regs
  target/hexagon: Implement do_raise_exception()
  target/hexagon: Add system reg insns
  target/hexagon: Add sysemu TCG overrides
  target/hexagon: Add implicit attributes to sysemu macros
  target/hexagon: Add TCG overrides for int handler insts
  target/hexagon: Add TCG overrides for thread ctl
  target/hexagon: Add TCG overrides for rte, nmi
  target/hexagon: Add sreg_{read,write} helpers
  target/hexagon: Add locks, id, next_PC to state
  target/hexagon: Add a TLB count property
  target/hexagon: Add {TLB,k0}lock, cause code, wait_next_pc
  target/hexagon: Add stubs for modify_ssr/get_exe_mode
  target/hexagon: Add gdb support for sys regs
  target/hexagon: Add initial MMU model
  target/hexagon: Add clear_wait_mode() definition
  target/hexagon: Define f{S,G}ET_FIELD macros
  target/hexagon: Add hex_interrupts support

 MAINTAINERS                             |   3 +
 docs/devel/hexagon-sys.rst              | 112 +++++
 docs/devel/index-internals.rst          |   1 +
 docs/system/hexagon/cdsp.rst            |  12 +
 docs/system/hexagon/emulation.rst       |  18 +
 docs/system/target-hexagon.rst          | 103 +++++
 docs/system/targets.rst                 |   1 +
 target/hexagon/cpu-param.h              |   9 +
 target/hexagon/cpu.h                    |  76 +++-
 target/hexagon/cpu_bits.h               |  87 +++-
 target/hexagon/cpu_helper.h             |  43 ++
 target/hexagon/gen_tcg.h                |   9 +
 target/hexagon/gen_tcg_sys.h            | 103 +++++
 target/hexagon/helper.h                 |  23 +
 target/hexagon/hex_interrupts.h         |  15 +
 target/hexagon/hex_mmu.h                |  30 ++
 target/hexagon/hex_regs.h               | 115 +++++
 target/hexagon/internal.h               |  21 +
 target/hexagon/macros.h                 |  40 +-
 target/hexagon/sys_macros.h             | 238 ++++++++++
 target/hexagon/translate.h              |  43 ++
 target/hexagon/attribs_def.h.inc        | 413 ++++++++++++++++--
 target/hexagon/reg_fields_def.h.inc     |  96 ++++
 linux-user/hexagon/cpu_loop.c           |  16 +
 target/hexagon/arch.c                   |   5 +
 target/hexagon/cpu.c                    |  84 +++-
 target/hexagon/cpu_helper.c             |  96 ++++
 target/hexagon/gdbstub.c                |  45 ++
 target/hexagon/genptr.c                 | 142 ++++++
 target/hexagon/hex_interrupts.c         | 327 ++++++++++++++
 target/hexagon/hex_mmu.c                | 525 ++++++++++++++++++++++
 target/hexagon/machine.c                |  63 +++
 target/hexagon/op_helper.c              | 292 +++++++++++++
 target/hexagon/translate.c              |  21 +-
 gdb-xml/hexagon-sys.xml                 | 116 +++++
 target/hexagon/gen_analyze_funcs.py     |  21 +-
 target/hexagon/gen_helper_funcs.py      |  23 +-
 target/hexagon/gen_helper_protos.py     |  23 +-
 target/hexagon/gen_idef_parser_funcs.py |   2 +
 target/hexagon/gen_op_attribs.py        |   2 +-
 target/hexagon/gen_opcodes_def.py       |   5 +-
 target/hexagon/gen_tcg_func_table.py    |  14 +-
 target/hexagon/gen_tcg_funcs.py         |  32 +-
 target/hexagon/hex_common.py            | 191 +++++++-
 target/hexagon/imported/encode_pp.def   | 213 ++++++---
 target/hexagon/imported/macros.def      | 558 ++++++++++++++++++++++++
 target/hexagon/imported/system.idef     | 262 ++++++++++-
 target/hexagon/meson.build              |  14 +-
 48 files changed, 4506 insertions(+), 197 deletions(-)
 create mode 100644 docs/devel/hexagon-sys.rst
 create mode 100644 docs/system/hexagon/cdsp.rst
 create mode 100644 docs/system/hexagon/emulation.rst
 create mode 100644 docs/system/target-hexagon.rst
 create mode 100644 target/hexagon/cpu_helper.h
 create mode 100644 target/hexagon/gen_tcg_sys.h
 create mode 100644 target/hexagon/hex_interrupts.h
 create mode 100644 target/hexagon/hex_mmu.h
 create mode 100644 target/hexagon/sys_macros.h
 create mode 100644 target/hexagon/cpu_helper.c
 create mode 100644 target/hexagon/hex_interrupts.c
 create mode 100644 target/hexagon/hex_mmu.c
 create mode 100644 target/hexagon/machine.c
 create mode 100644 gdb-xml/hexagon-sys.xml
 mode change 100755 => 100644 target/hexagon/imported/macros.def

-- 
2.34.1


