Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD860A2636
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PqYJ1cYd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UsVFh4x7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0h4-0005QO-Lj; Thu, 22 Oct 2026 17:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0h2-0005Q8-Fe
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0h0-0007Ok-9M
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:24 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKutmZ792321
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xzsOFWooDCJaIc6qPfl9zy
 3gCecXJU88Uwmybxxs58s=; b=PqYJ1cYdy/CsTyFXxxnGmowyZNBqSwHgy/Sf8C
 xOVFTnXHtM4gMHpz4iou9zwnP2EgWFtbJle7GsyJgFukj+ihXsBFu/reoxFgx1LT
 dwq0Jc8EhR1gWLi3Q2U+Zj4H9516KusWFxSj46jER5FwYTGmHv6lJQbLhW0jRfAR
 pHsGgUgMVk06DpiubTk1djiAXfpCqFDfqrEcHX05bl0M+mHmnI/y6Rpgn84YCYGf
 1mW2xeCeV3AknGDKL9aoLbyaZfmhhLGKyq5ivK2im1/ZczBBQBtVipibCd/Ro4M+
 +HarwIhoj5qRsxnwtYebeC+fMicowGlZ0BMIrAtLFG5hGgUA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk857p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f26dd2165so79239885a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705878; x=1793310678; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xzsOFWooDCJaIc6qPfl9zy3gCecXJU88Uwmybxxs58s=;
 b=UsVFh4x7Vv2cbcS5prwd5J5wxXAyC7a3v2c5OKLbNKeK+OAeGSUXNX6uAFRN935DuY
 1jDifGLGodtzkNLDLRfVMc4SU1AFCyr6RQOnHpXyb/ewe+LzxlGQAfvBzF2elp0PozLe
 hF/7od1b0zjb+RHtGDPT9iufl7+gMu19JQ702e2uRghWKJ65cIZmzT6sYEw387GTX6/Q
 Ym+QQ9OQr4sjpGNVRCV6gKId/x1otXHTk+vncUogIWupXjYlZQiy/M1NNaBfJ59i4wkP
 nbWZdxwbNiujFifXKeUSZpvsT4cI4RFdP6b8MXtbO0LhQkWnYdcLyGs67YdMzJzOqmCS
 AzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705878; x=1793310678;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xzsOFWooDCJaIc6qPfl9zy3gCecXJU88Uwmybxxs58s=;
 b=y9vN6ZeZbGlidjmEzPDiIG661Tbn6gPNQ8WLB5/d5TUGZ9UwmrshU4odYxkta+R/+i
 zhQSor5S/SGiBhfo6lAvvuvbDnBva0TqPAY/PnY7YCy0uNo8dTpyJ72ayrVNwEi2N5HJ
 KU+5ijECduKt0i+eNSXqsu4sy5fNVhWunKkHwprCoDjgkmKoTm2RsJTg7ajC6bVGCNh0
 q8rf7MyPn+uWREkkgCRM9zR0wnzrvmarWCMA+z1SifPt7rsngCinjVoPKyEY8R3LxiWu
 kx4prRrnkcRZ4hQnnnw/bkFiB0LVi0hxgSKCXXotHrgfoyeR0ri4gdl1BcL8OsymMFvR
 ZPOA==
X-Gm-Message-State: AFq9FYJPNOYNFl2nvEB3H4hHt6+EzAf6bXFLvfOdOZOV2epAEmWzyl6e
 MZ2FjpsFIgRqucPRCkrPbsqAB3UY1NPJoxsfp6/QjF6ETkG8PAqmu4q6yuVMw2iFX604eOj1VcZ
 PypBtt2SVi+g+2EYZbkYKu+YxPnj5xCZypZiVLm6QijKJLdvQEuurD+gMizY0uITyaw==
X-Gm-Gg: AYBFou1H24WB0twFHy3o0dMd90DUr96aHz1nWxTgvOtulmJGagLqKuidU1t31XczANl
 ESFWngqXQUi/yhvdz3Xr9MobZFMflSJiTHIWm2C0HrJWX/Ol7iUH5uDXMZ17Xb4sIYbI47fCniA
 mBRZlfRR8D9NM2SmJ3t5GBbi2YNyFIZgoYVZO6VZZE18tSjKMzGIGtaOYULedMR9bGIJ7/I6XU4
 wbaOeCzTHST0wEaCjjE/tf2+0AmvR8qaMiZ6IQnOxf5ynGmVKPVdefLPmzCjElWSn1HJr0aT0/Q
 HxUXlIpfiiR0O7DtcLHRS8cAhvSsMg7JEkyKikgqzNS/+J1U1bf+wtMvCLtzlETrEuqeSVwatZR
 FVFDxVTSanx51d6RH3gPG3Pfj5Xgh5OmIyAzK+0Jb
X-Received: by 2002:a05:620a:2b91:b0:93e:d364:c9fe with SMTP id
 af79cd13be357-93f6f964e55mr142141985a.40.1792705877784; 
 Thu, 22 Oct 2026 14:51:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2b91:b0:93e:d364:c9fe with SMTP id
 af79cd13be357-93f6f964e55mr142139585a.40.1792705877306; 
 Thu, 22 Oct 2026 14:51:17 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a211ba3e22sm11575425e9.8.2026.10.22.14.51.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:51:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 00/33] cpus: Add common CPUClass::exception_name() handler
Date: Thu, 22 Oct 2026 23:50:40 +0200
Message-ID: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXxLanHkXQKOAS
 M5M6/yMWGk38RKOZ+zggLvyTyWUU7hcUnmRPHneLVe7e8XLxvpRqMc1aQsC5jAohVVPCNwglZCO
 WzBvIIz433h56O4qQME8hDUkP+XZrQ+P/cjlzAMuVqYOvMMIhGNHKgoci5InWDOMlxamdXh2u8d
 uzMihUc2MpullpbxiI2JbGbHUKCTUXSWfdK35NPkSAOZwvU7JboluDIFnjFb7MsLHXedtP5BNQZ
 Gk8KlIRErMBkZvRjiJHDbnFfu6AXpyPXAu5lrIe7Rjt4j6wYsK6eL5vJjMO0CORX2WHmy782XDu
 frNxtU0EePQDS+i+eK4o0vaz1AoA4lTOtKrUJ63Gu6T8RIJaEX+NKJt1jhCQryy6+YPfcQ5NPc/
 /ICgjKlX6ttTgajndPINpCIs80NTQEeRZxiGhBX3xSCSDg4um9qGV8xORfO2YZ2JoA7tJZGW5Sc
 V4huj0cUIgSv4ZuYmqg==
X-Proofpoint-ORIG-GUID: vmf1Abhs2DFOQ4iVmYUd2HVv4ujEbRGz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX2cGrpYRXvyeY
 by92guOlqbmd/dpO+9Bb75Aw5B/rFcAkwHjevXs3EQiQnz26W1BF5M3JMcZ9sUdzvKSi4id5gpd
 lSXlg0x0RMbMiMQv/H3guG250bgXSUY=
X-Proofpoint-GUID: vmf1Abhs2DFOQ4iVmYUd2HVv4ujEbRGz
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6ada8556 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=fwSM-n4fPOTFBuO-yL4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Missing review: 1 (new), 2 (rewrite)

v3:
- Add STR_ARRAY_ELEM_OR_NULL() suggested by Pierrick

v2:
- Addressed Pierrick suggestions
- No change addressed wrt logging-prefix (patch 2) because
  not needed so far.

Add qemu_excp_name() to resolve QEMU internal exception
values.

Add a common CPUClass::exception_name() callback so the
generic exception logger can resolve architecture-specific
exception values to human-readable names.

Re-use existing methods (expose prototype or refactor) when
available otherwise implement new ones (AVR, X86, MicroBlaze,
S390x, TriCore and Xtensa).

This series is the base for consolidating exception management
in accel/tcg/ (more series to be posted on top).

Philippe Mathieu-Daudé (31):
  qemu/osdep: Document ARRAY_SIZE() macro rejects pointers
  util/cutils: Add STR_ARRAY_ELEM_OR_NULL() for string table lookups
  cpus: Add helper to log raised exceptions with '-d int'
  cpus: Introduce CPUClass::exception_name() handler
  target/alpha: Register CPUClass::exception_name() handler
  target/alpha: Use a static table in alpha_exception_name()
  target/arm: Register CPUClass::exception_name() handler
  target/avr: Implement and register CPUClass::exception_name()
  target/hexagon: Register CPUClass::exception_name() handler
  target/hppa: Register CPUClass::exception_name() handler
  target/i386: Replace magic value by proper EXCP0E_PAGE definition
  target/i386: Implement and register CPUClass::exception_name()
  target/loongarch: Register CPUClass::exception_name() handler
  target/m68k: Register CPUClass::exception_name() handler
  target/m68k: Use a static table in m68k_exception_name()
  target/microblaze: Implement and register CPUClass::exception_name()
  target/mips: Remove EXCP_LAST, use ARRAY_SIZE(excp_names)
  target/mips: Register CPUClass::exception_name() handler
  target/or1k: Register CPUClass::exception_name() handler
  target/ppc: Name the EBB exceptions
  target/ppc: Use a static table in powerpc_excp_name()
  target/ppc: Register CPUClass::exception_name() handler
  target/riscv: Register CPUClass::exception_name() handler
  target/rx: Unify BRK and INT trap handling
  target/rx: Register CPUClass::exception_name() handler
  target/s390x: Implement and register CPUClass::exception_name()
  target/sh4: Register CPUClass::exception_name() handler
  target/sh4: Use a static table in sh4_exception_name()
  target/sparc: Remove always-defined DEBUG_PCALL
  target/sparc: Register CPUClass::exception_name() handler
  target/xtensa: Implement and register CPUClass::exception_name()

Yonggang Luo (2):
  target/rx: Define exception vector constants
  target/sh4: Define exception vector constants

 include/hw/core/cpu.h          |   2 +
 include/qemu/cutils.h          |  17 ++++
 include/qemu/osdep.h           |   9 ++
 target/alpha/cpu.h             |   1 +
 target/arm/cpu.h               |   4 +-
 target/avr/cpu.h               |   2 +
 target/hexagon/cpu_bits.h      |   2 +
 target/hppa/cpu.h              |   2 +
 target/i386/cpu.h              |   2 +
 target/loongarch/internals.h   |   2 +
 target/m68k/cpu.h              |   2 +
 target/microblaze/cpu.h        |   2 +
 target/mips/cpu.h              |   4 +-
 target/mips/tcg/tcg-internal.h |   2 -
 target/or1k/cpu.h              |   2 +
 target/ppc/cpu.h               |   2 +
 target/riscv/cpu.h             |   1 +
 target/rx/cpu.h                |  14 +++
 target/rx/helper.h             |   3 +-
 target/s390x/cpu.h             |   2 +
 target/sh4/cpu.h               |  22 +++++
 target/sparc/cpu.h             |   1 +
 target/xtensa/cpu.h            |   2 +
 accel/tcg/cpu-exec-common.c    |  36 ++++++++
 target/alpha/cpu.c             |   1 +
 target/alpha/helper.c          |  57 +++++-------
 target/arm/cpu.c               |   1 +
 target/arm/helper.c            |  77 ++++++++--------
 target/avr/cpu.c               |  17 ++++
 target/hexagon/cpu.c           |  35 ++++++++
 target/hexagon/hexswi.c        |  30 +------
 target/hppa/cpu.c              |  42 +++++++++
 target/hppa/int_helper.c       |  48 +---------
 target/i386/cpu.c              |  30 +++++++
 target/i386/tcg/excp_helper.c  |   7 +-
 target/i386/tcg/seg_helper.c   |  11 ++-
 target/loongarch/cpu.c         |  38 ++++++++
 target/loongarch/tcg/tcg_cpu.c |  41 ---------
 target/m68k/cpu.c              |   1 +
 target/m68k/op_helper.c        | 159 ++++++++++++---------------------
 target/microblaze/cpu.c        |  15 ++++
 target/mips/cpu.c              |   1 +
 target/mips/tcg/exception.c    |  10 +--
 target/or1k/cpu.c              |   1 +
 target/or1k/exception.c        |  22 +++++
 target/or1k/interrupt.c        |  19 +---
 target/ppc/cpu_init.c          |   1 +
 target/ppc/excp_helper.c       | 140 +++++++++++++++--------------
 target/riscv/cpu.c             |  20 ++---
 target/riscv/tcg/op_helper.c   |   2 +-
 target/rx/cpu.c                |   1 +
 target/rx/helper.c             |  62 +++++++------
 target/rx/op_helper.c          |  17 ++--
 target/rx/translate.c          |  23 +++--
 target/s390x/cpu.c             |   1 +
 target/s390x/interrupt.c       |  16 ++++
 target/s390x/tcg/excp_helper.c |   6 +-
 target/s390x/tcg/misc_helper.c |   3 +-
 target/sh4/cpu.c               |   1 +
 target/sh4/helper.c            | 109 ++++++++++------------
 target/sh4/op_helper.c         |  16 ++--
 target/sparc/cpu.c             |   1 +
 target/sparc/int32_helper.c    |  22 ++---
 target/sparc/int64_helper.c    |  42 ++++-----
 target/xtensa/cpu.c            |  24 +++++
 target/xtensa/exc_helper.c     |   3 +-
 util/cutils.c                  |   6 ++
 67 files changed, 750 insertions(+), 567 deletions(-)

-- 
2.55.0


