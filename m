Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE176CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOIu-0004Q0-Jm; Wed, 07 Oct 2026 05:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODD-0007ZI-Ff
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:45:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODB-0000Ke-Kv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:45:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jdgB3194033
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=NpF7j6EQ52oVheqe2PYRK6
 UPYuywZL07ZtJesi15bkU=; b=mtVnX7BcLnJzJ4mK+a9PeUIOjFcjMe5f0jNtYd
 0lInu46qju0yuCzVftOZWprSC9psUcjeRTHSeXHZK2Yo9wpQaXkOXE0tIxwDE52I
 UpWwgC1hKrTXbR5Wy0QOUPo0PHBAC/ckD/qH+qeBkK2XN8LuSY59nqsO1FE8MAHV
 2EIVh2nFA6s7OMPOi0O0M06XhS2l4bqJp2Sb+e7++4v62t38Dv/j0uhB5BZ7q5xZ
 2tzWqfcgOl5X3oR779cVzTNc0fn0L0lkcYH3empXr7irrhuRQigCtnUxQ+dgg/lQ
 T/W39QFwPwA+P76309bXnwlg0VdGNWMrvEMasOSydBQiZMkg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h541ukpfw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:45:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso825670285a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366319; x=1791971119; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NpF7j6EQ52oVheqe2PYRK6UPYuywZL07ZtJesi15bkU=;
 b=jJCE7jaVBR6CYwdZwPrrULdPFUnT/JozvFo22amsf/83qFouYsI5V1Qg815D+6oFvQ
 7WppFKOJzcLmdO8aCg87pUQ/YmQg5h9gvtbRi0G8teOFO23F1Q90c/tmRRJgdjGBPC5u
 y/pEBvz9HWIcLWWBOQFjs4TnqWjjMwHptzyWGWCCa8WWqxgK20WRXtb322a9V/Wv/7R4
 gDA0r9QABERLbcTkrZepNXx1SL1cGnQeGEQlO2yVE+vPI0Dw0ILFodLimv8d4pwS1Q4M
 ChAworVCs5VjV84sDGPP+zRveDZGRpyEQQdbuDhuAy9gi5Uj3HfU3wcequyV5+ziT+Fo
 MCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366319; x=1791971119;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NpF7j6EQ52oVheqe2PYRK6UPYuywZL07ZtJesi15bkU=;
 b=fcsp7ZuBhW2dakCTOCDLswirPQ0ikMgTtyCon2b1N3/g27dfxXidCRNMmXtrSeYLox
 YCA4Prn11QU9kcMHIYcdni21wH6jslDlHRSsrnGelvEqi+rRqW9ni9kgbFtjZWDIhz9R
 B19YuPwOc0ox1av5KXOpWhcHXITlQmux8mozcP24HQof+SIv1APmI+1WIYDiu9tvKarK
 0GKaZvUj65aiFUFBFnqrHoz3FaWIRQe7P5lffsfWYP41taAEnnF/f3kqulQEt+6Dkpjr
 CCfE78jVNbVVxIlQ8rnUukThWgCYpKT860M97cy5rWh2V+MLvIlUZ9jQFVRoQ7hMPJa2
 XFjQ==
X-Gm-Message-State: AFuF++lJasVUo5bB6bkbJGWLr1USP80wAcwZNgzR0uBOuJA+6o0YzbAa
 rroWOjOXs6tX48t11myUAxsVBnSodT7w94c5sm6lcQ1JEiu9TrJXJ50oQntgQ3GkQChOxkcmh5N
 7RaJ4SD3XoA3S9BY9U1naEGeCMG70dZzGjih/+9qad0mtlbgRMvTkF8UIo3WCfNov2SL4
X-Gm-Gg: AYBFou38rtANmXAxqLftmUf3+1dsIvA+syWtJDm8apCRt77Q+ZXICpjDnLnmAkHWXMV
 W23slVS9UGtZxj77Dk4vIOSoF+5cpCeTyw6FDWETJxGUETygHgnNf4P3jr8XwZpswcIZMBecNbe
 DqQYGQhWEvifNznP1u2HLxrO79W5a0A6DKn918GsgXF+0i1MpyVCkUlRfTsjNORqTFBNZVLqFWG
 HECkAbM4U5xSLRFdjqrQ9owyGWHAbgDqDm0Qlk+s4zQb3D660XUttkWidVoSZiStkDeW+ihXy2E
 Se1nlkTdbmfOBsTuXbYe+9FOqZlniM7W1MOErsXtYRNuhcc5V/r6Oy3GNdS06kcqrAnh8qfZ9iu
 d5J5EFEtYGUJh9LOPxqOOHJFYosqT1ygQKV5rPIW2
X-Received: by 2002:a05:620a:27c1:b0:93a:14c:32ad with SMTP id
 af79cd13be357-93e9af3458dmr350408585a.0.1791366319468; 
 Wed, 07 Oct 2026 02:45:19 -0700 (PDT)
X-Received: by 2002:a05:620a:27c1:b0:93a:14c:32ad with SMTP id
 af79cd13be357-93e9af3458dmr350407385a.0.1791366319082; 
 Wed, 07 Oct 2026 02:45:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71b786d8sm4553545f8f.0.2026.10.07.02.45.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:45:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 00/27] cpus: Add common CPUClass::exception_name() handler
Date: Wed,  7 Oct 2026 11:44:48 +0200
Message-ID: <20261007094516.75732-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TRCZgvtAkDGAXp5KyCl7mfYIDhjYAuW3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX2Z/4nUrmwWGT
 R0FrUECJA306LZLkFx657VoU8FeAQaYQ9CLp4NPTDAQ5yCZeCDfzClMJkKsy9Xy+JipYHTsmG3I
 wYZuRQtTAEN9o/XFJR8mR+YXBzzaTME=
X-Authority-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6ac614b0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=YXr4UVjmoPJm1gVQGGwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX3+Z2Hd05mXfI
 YU4b3Og3p14qqLeIYoQi1CxiBG3J4bNkxbXsGZtxRn3NAqOOy5uz2WivxxtygfYYWiLMcm/NOhx
 3ZCa3O6uwOLEYHinEMCF5/Bw2im72DMTmUsR41H3Ir7WUFv/2lZc2gAmlyb3hUUI0iCNrw5tEly
 GbOcawxz/9F//SOGv1zG4C1lh0DHIA34Z1gn2Nqtmtn95UBy7E0rPdYHbQIger7vWOeK3gDv0dp
 QELmy0hr+YTt3LlVN0h3wwiwoNlyh3P1QS6u2kefLDQaAeGlaYWmmjBI0b2maoJu5gYfVS5hq1Z
 unXfojm1b6noDzU1FLpYx7W8+zagkTB9sSPbhNgT4XUGeOugrcUzMHxGNVP7U1tSurCJAuXJBys
 lnZzgw6ZfluZZ5FYF7vCZs2hFEBXn2ZflKyOqwmtxDt9Kj0pJF9SypoDZl1sdPqZMuC9uSIJSvM
 qpekE8Ip0mXHPMscB/g==
X-Proofpoint-ORIG-GUID: TRCZgvtAkDGAXp5KyCl7mfYIDhjYAuW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Philippe Mathieu-Daudé (25):
  cpus: Add helper to log raised exceptions with '-d int'
  cpus: Introduce CPUClass::exception_name() handler
  target/alpha: Register CPUClass::exception_name() handler
  target/arm: Register CPUClass::exception_name() handler
  target/avr: Implement and register CPUClass::exception_name()
  target/hexagon: Register CPUClass::exception_name() handler
  target/hppa: Register CPUClass::exception_name() handler
  target/i386: Replace magic value by proper EXCP0E_PAGE definition
  target/i386: Implement and register CPUClass::exception_name()
  target/loongarch: Register CPUClass::exception_name() handler
  target/m68k: Register CPUClass::exception_name() handler
  target/microblaze: Implement and register CPUClass::exception_name()
  target/mips: Remove unuseful EXCP_LAST definition
  target/mips: Register CPUClass::exception_name() handler
  target/or1k: Register CPUClass::exception_name() handler
  target/ppc: Register CPUClass::exception_name() handler
  target/riscv: Register CPUClass::exception_name() handler
  target/rx: Unify BRK and INT trap handling
  target/rx: Register CPUClass::exception_name() handler
  target/s390x: Implement and register CPUClass::exception_name()
  target/sh4: Register CPUClass::exception_name() handler
  target/sparc: Remove well tested DEBUG_PCALL definition
  target/sparc: Register CPUClass::exception_name() handler
  target/tricore: Implement and register CPUClass::exception_name()
  target/xtensa: Implement and register CPUClass::exception_name()

Yonggang Luo (2):
  target/rx: Define exception vector constants
  target/sh4: Define exception vector constants

 include/hw/core/cpu.h          |   2 +
 target/alpha/cpu.h             |   1 +
 target/arm/cpu.h               |   2 +
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
 target/rx/cpu.h                |  14 ++++
 target/rx/helper.h             |   3 +-
 target/s390x/cpu.h             |   2 +
 target/sh4/cpu.h               |  21 +++++
 target/sparc/cpu.h             |   1 +
 target/tricore/cpu.h           |   2 +
 target/xtensa/cpu.h            |   2 +
 accel/tcg/cpu-exec-common.c    |  38 ++++++++++
 target/alpha/cpu.c             |   1 +
 target/alpha/helper.c          |  82 +++++++++++---------
 target/arm/cpu.c               |   1 +
 target/arm/helper.c            |  79 +++++++++----------
 target/avr/cpu.c               |  19 +++++
 target/hexagon/cpu.c           |  37 +++++++++
 target/hexagon/hexswi.c        |  30 +-------
 target/hppa/int_helper.c       |  91 +++++++++++-----------
 target/i386/cpu.c              |  33 ++++++++
 target/i386/tcg/excp_helper.c  |   5 +-
 target/i386/tcg/seg_helper.c   |   8 +-
 target/loongarch/cpu.c         |  38 ++++++++++
 target/loongarch/tcg/tcg_cpu.c |  45 -----------
 target/m68k/cpu.c              |   1 +
 target/m68k/op_helper.c        |   8 +-
 target/microblaze/cpu.c        |  17 +++++
 target/mips/cpu.c              |   1 +
 target/mips/tcg/exception.c    |  12 +--
 target/or1k/cpu.c              |   1 +
 target/or1k/exception.c        |  24 ++++++
 target/or1k/interrupt.c        |  19 +----
 target/ppc/cpu_init.c          |   1 +
 target/ppc/excp_helper.c       |   5 +-
 target/riscv/cpu.c             |  29 ++++---
 target/riscv/tcg/op_helper.c   |   2 +-
 target/rx/cpu.c                |   1 +
 target/rx/helper.c             |  62 +++++++++------
 target/rx/op_helper.c          |  17 ++---
 target/rx/translate.c          |  23 +++---
 target/s390x/cpu.c             |   1 +
 target/s390x/interrupt.c       |  18 +++++
 target/s390x/tcg/excp_helper.c |   6 +-
 target/s390x/tcg/misc_helper.c |   3 +-
 target/sh4/helper.c            | 135 +++++++++++++++++----------------
 target/sh4/op_helper.c         |  16 ++--
 target/sparc/cpu.c             |   1 +
 target/sparc/int32_helper.c    |  23 +++---
 target/sparc/int64_helper.c    |  42 +++++-----
 target/tricore/cpu.c           |  21 +++++
 target/xtensa/cpu.c            |  26 +++++++
 target/xtensa/exc_helper.c     |   3 +-
 64 files changed, 692 insertions(+), 408 deletions(-)

-- 
2.55.0


