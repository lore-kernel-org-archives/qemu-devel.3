Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B01C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12iQ-0003Je-VN; Mon, 31 Aug 2026 10:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iO-00039C-G2
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iH-0006cX-AR
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:19 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBAmpT2273007
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=kKVhsq0aXEJmMHeamjodVlIHhvVX8Bp34V2
 tQ4/PTeM=; b=HsZzlUdGJHc6mijlT19ccunC3Y03E/6eYp25RW/ImYVcifJef5Q
 KBBP8mawRPZKu96JDkgmuFYPRDqH6zx3wM3ggRauFbcQBQk4+Jf85MZdemkKHEap
 dBg+hclKGngESud7EKgtZVhGaa2/tbmQwHuc6xPfygtUPW8hb+sxGkvLFqSTi2BK
 HE1dS24E23eTz77MWxbzb0+tmLvKQe9rI+mEcVx3EHa8/Afmgbwli1V9oWJ4IgdT
 Lonv639PoLGzRqXgsN+jotTooGbg2iapBdHEsWNeCMJZcfECK1mP7Qd9HBKyEX48
 TUYgOIfo2UXoawj32PGVXHlUIMlyysL4vMg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6vah5jr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:14 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-451acf33124so5077330fac.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788185413; x=1788790213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kKVhsq0aXEJmMHeamjodVlIHhvVX8Bp34V2tQ4/PTeM=;
 b=b6WgloMUgGhjK7QUQnBb8eXQ5S55YEficaR/lnyZoW6dffD3zqzP5TpKUAgXMtP1VS
 NeA865vt9F1PlmIVZKUKaXRFPnDKjfk752gu6dlJD0DNFU07PbqmqiLZ9k21xYuLK1cD
 3dowcAwnUaz4o5fgpxIOCMqspQD+xbndxxa2fW07Bv3xATivhATql7hGxAqG691hzCK9
 b4ZnpDkXJgkWfyI1a3uP0vn/cu709uWkJUsEIVtCi+Vd/Q7CXfAExYetRTFmWj5t27Fe
 +dYdBGul60cM0tCoQ3fnNA2p0+p5k/mRT+MZWSUZ8PsCWXBRRIYEdr2AR4VyzGJ6Zd7h
 2eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788185413; x=1788790213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kKVhsq0aXEJmMHeamjodVlIHhvVX8Bp34V2tQ4/PTeM=;
 b=O5cYaaZUDZOLg9gdJZtHv4d+IwtEh5BgsD6tssENv3aJar2N96VonfQqECEc/tpsuh
 mmGUoMQu2cnLUxkTMEnji0ErReyuwLt1IWEP8CQqM2Gphl4Me7kwBR3ZCqzg/9aK56YX
 br2jqqB2LRl2+MWpbZf89nXiJ+mgMu87zwCqtmvpfVCyLmQaOmIQJm0DOx9bhfc7+86d
 zZZIcErC+9f51nrZ4F/s+8nO+VJtA+CpIQ34q1Ww3t/pEFYlUeRwbnFonqA+lLxhoH6z
 oYiJXUm/ehL4KC/RkKsZy9XEveg0De60S/WTJjfEOdZVRAeNVQFYEhtM2QA+V78vLnq/
 ej9w==
X-Gm-Message-State: AFuF++lzZixq3TQ4Udv5IoOsTU3iWw2DXS4I+d19JptSASD9sP7EDRJ0
 Urbiadx02CuhOt6mB9/4KyyfXkZaxu/E9MeGzavsMeADV5gxFMWSDLYvwZ3AQhAgEQWv704tD5M
 t6JHeaCwj3rPQidP2sML0MYgrnjJijp3oJSxP655HRHU2nwohc/oUpe/motKgJu3GxA==
X-Gm-Gg: AR+sD123Bos41DPJiRpBVvkUXFKzWvIi1bZ9L69j5uV6lL+HsWkrl8+zTAxt+7aeLAu
 99b9APmZZQkoci3X7OHWMq8reJ8RIUr6VFN8wf6CxqCGXh/PK9nY9BmYLoeHP1NhptSerUk+qLf
 8chlEZCUlSF/a+upM5M5E3PT+UhJ9fVtcc203SBBQid9DPSrBVSTGyRa2Ej/boJVPOdLLfNvIHN
 y/7YWSa1pUEwdSwR41XGDyqernleWa/jrD+nOODrug926NwcY9fF3XPeK7KZb9qiJTto7n0XEjx
 MnXuNzqrfgZo+cOG2ekb6Zod6D6svqUGgCh/znZGBbudL6NPZ9cbPV1sqFClW54FUlwmJg/YP1h
 7YhJPTcyJuJa7OYiOlngJYh19XwsNC9kpsBMW+Q==
X-Received: by 2002:a05:6870:c98a:b0:448:71f4:a28 with SMTP id
 586e51a60fabf-46af537b000mr1197523fac.2.1788185412984; 
 Mon, 31 Aug 2026 07:10:12 -0700 (PDT)
X-Received: by 2002:a05:6870:c98a:b0:448:71f4:a28 with SMTP id
 586e51a60fabf-46af537b000mr1197435fac.2.1788185412364; 
 Mon, 31 Aug 2026 07:10:12 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a3535e25sm9886129fac.5.2026.08.31.07.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:10:11 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v7 0/7] riscv: add initial sdext support
Date: Mon, 31 Aug 2026 11:09:59 -0300
Message-ID: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfX7Lt/2sy10vcm
 9oI+CffZagPlF2LRN1HcxhTthqAevMtb6W47Ta2OT4rqwUkG3d+h0AWkbU/tfHR2LqXUCJPkC0Z
 7EoIlWrP0+1dpL9tC5lK5ZDF9qdOdpuAN2qJnaObQRtlMa674EKX19jqhlsU9ApYdDAxDHFU9qE
 /aX3flSNwR7tcWfZp35I3GuTce+9ZyDnaO+81gWrjSZHM887zXScxHcFqsiRu1LCe7emxyXCIFG
 oB6fXEK9FjZ6lhsVnj7hBuS9F/dykMIpYT3s28PoAZQJyTK0CBJoMC4btTcX2HoSJqW6rYb6po6
 KRq4K6AyIZAQySZ4onQTaFOqjABB7I7XWpqYxIYnveXqEaAeGez7wtXsDqxCWYkCTKaUifunDYk
 /0MSyRgWWqKORTXF6R91Vb/CbFEv4wZN/jBSgtIjdzW3U8y5/80A7Y/FYVgdRbwQ54ULEy6udaY
 wiuOomhODXfLdsu6stA==
X-Authority-Analysis: v=2.4 cv=YYmNIQRf c=1 sm=1 tr=0 ts=6a958b46 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=xvfqbYfxAAAA:20 a=pFyQfRViAAAA:8
 a=p0WdMEafAAAA:8 a=7QAV9UKVwuH8uxJJLZ4A:9 a=eBU8X_Hb5SQ8N-bgNfv4:22
 a=oJz5jJLG1JtSoe7EL652:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfXw9yTdkN+EWai
 ivuztdXNECLT5EafT+6QnsvHMmRGR/IQoqHUmR1rNMG85SBpBFsN5Pmw0v0NUOD6VkiThZ6PvLg
 2YtKbbryyj7REi2JHNGYPdIoYi63go8=
X-Proofpoint-GUID: yLw9mDV6aaLqOwQco0GaLZopkbpFe-Q6
X-Proofpoint-ORIG-GUID: yLw9mDV6aaLqOwQco0GaLZopkbpFe-Q6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310122
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hello,

This version of sdext contains no relevant changes in its base code,
patches 1-6 (former patches 2-7), all of them developed by Chao Lui
and all of them already reviewed.

The most significant changes are:

- former patch 1 (target/riscv: deprecate 'debug' CPU property) was
  removed.

- a new rebase with alistair/riscv-to-apply.next.  The most important
  bit is the rebase with the new Debug 0.13/1.0 code that landed in
  Alistair's branch.  Although no code changes were required in sdext,
  we're now running in the intended modernized 'sdtrig' base.

- a new TCG test case.  Chao, there's a high chance I messed up and
  maybe there's more we can test with TCG right now.  Let me know if I
  missed something.


This series, along with

"[PATCH v5 00/15] hw/riscv: trivial code dup work (riscv-server-ref prep)"

Are the last dependencies for the RISC-V Server Platform
(riscv-server-ref) board.  As soon as both are queued I'll send the v9.



Patches based on alistair/riscv-to-apply.next.  Only patch 7 missing
reviews/acks.



Changes in v7:
- former patch 1: dropped;
- rebased on top of latest alistair/riscv-to-apply.next and the now
  modernized Debug 1.0 support;
- patch 7 (new):
  - add TCG test coverage for illegal insn outside of Debug mode.
- v6 link: https://lore.kernel.org/qemu-devel/cover.1775959096.git.chao.liu.zevorn@gmail.com/


----------------------------
Original cover letter/series change history:


The implementation follows RISC-V Debug Specification 1.0 [2].

It introduces the sdext/sdtrig config bits, DCSR/DPC/DSCRATCH state,
Debug Mode enter/leave helpers, DRET, EBREAK entry, single-step, and
trigger action=debug mode.

To reduce review load, this series focuses on the Sdext features first.
The Debug Module (DM) and related flows will follow in a later series.


Changes in v6:
- Rebased onto latest riscv-to-apply.next

Changes in v5:
- Patch 2: removed redundant `cpu->cfg.ext_sdext = false;` in
  riscv_cpu_init() since it's already set to false in MULTI_EXT_CFG_BOOL.
  (Daniel)
- Patch 7: changed LOG_UNIMP to LOG_GUEST_ERROR for invalid trigger
  action=debug mode when Sdext is not enabled. LOG_UNIMP is reserved
  for unimplemented features, while LOG_GUEST_ERROR is for invalid
  guest actions. (Daniel)

Changes in v4:
- Fixed linux-user build errors: moved debug_mode/dcsr/dpc/dscratch
  fields inside #ifndef CONFIG_USER_ONLY block in cpu.h, and wrapped
  all code using these fields with proper guards. (Daniel)
- Updated dependency from single patch (patch 5 only) to patches 1-5
  of Max Chou's "Add Zvfbfa extension support" v2 series to avoid
  compilation errors.

Changes in v3:
- Rebase onto Alistair's riscv-to-apply.next branch.
- Depend on Max Chou's patch "target/riscv: Use the tb->cs_bqse as
  the extend tb flags." (not included; apply it first) [3].
- Patch 2: default sdext to false in riscv_cpu_extensions.

Changes in v2:
- Drop the RHCT expected AML update from this series.
- Replace the split sdext/sdtrig config bits patch with deprecating the
  'debug' CPU property.
- Rebase and update patch subjects to target/riscv prefix.

Changes in v1:
- Debug Mode entry/exit updates DCSR/DPC and restores execution via DRET.
- EBREAK honors DCSR ebreak bits and enters Debug Mode when enabled.
- Single-step uses DCSR.STEP with a TB flag and a helper at TB exit.
  It references Max Chou's patch "target/riscv: Use the tb->cs_bqse as
  the extend tb flags." [3].
- Sdtrig supports action=debug mode for mcontrol/mcontrol6 and reports
  inst-count triggers in tinfo.

---

Differences vs Debug Spec (known gaps):
- No Debug Module (no DMI, dmcontrol/dmstatus, haltreq/resumereq).
- No debug ROM, program buffer, abstract commands, or SBA.
- Resume is modeled by leaving Debug Mode at cpu_exec_enter.
- Step/exception ordering is simplified: if the stepped instruction
  traps, the normal exception is taken and Debug Mode is not forced.
- Several DCSR fields are not fully modeled (stopcount/stoptime, etc).

Roadmap (next stage, DM focus):
1) Add a DM core with DMI access and hart state tracking.
2) Implement halt/resume handshake and move Debug Mode transitions
   under DM control.
3) Add debug ROM, program buffer, and abstract commands for GPR/CSR
   and memory access.
4) Add SBA if required by tooling.
5) Tighten ordering rules for step/exception/trigger priorities.


[1] https://github.com/alistair23/qemu/tree/riscv-to-apply.next
[2] https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
[3] https://lore.kernel.org/qemu-devel/20260108132631.9429-1-max.chou@sifive.com/
[4] https://gitlab.com/TaoTang/qemu/-/pipelines/2446308835


Chao Liu (6):
  target/riscv: add sdext debug CSRs state
  target/riscv: add sdext Debug Mode helpers
  target/riscv: add dret instruction
  target/riscv: add sdext enter Debug Mode on ebreak
  target/riscv: add sdext single-step support
  target/riscv: add sdtrig trigger action=debug mode

Daniel Henrique Barboza (1):
  tests/tcg/riscv64: add sdext "not on Debug mode" sigill tests

 include/exec/translation-block.h              |   4 +-
 target/riscv/cpu.c                            |   7 +
 target/riscv/cpu.h                            |   9 ++
 target/riscv/cpu_bits.h                       |  33 +++++
 target/riscv/cpu_cfg_fields.h.inc             |   1 +
 target/riscv/helper.h                         |   3 +
 target/riscv/insn32.decode                    |   1 +
 target/riscv/machine.c                        |  20 +++
 target/riscv/tcg/cpu_helper.c                 |  91 +++++++++++++
 target/riscv/tcg/csr.c                        | 126 ++++++++++++++++++
 target/riscv/tcg/debug.c                      |  59 +++++++-
 .../tcg/insn_trans/trans_privileged.c.inc     |  24 ++++
 target/riscv/tcg/op_helper.c                  |  70 ++++++++++
 target/riscv/tcg/tcg-cpu.c                    |  19 +++
 target/riscv/tcg/translate.c                  |  15 ++-
 tests/tcg/riscv64/Makefile.softmmu-target     |   5 +
 tests/tcg/riscv64/test-sdext-sigill.S         |  83 ++++++++++++
 17 files changed, 564 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-sdext-sigill.S

-- 
2.43.0


