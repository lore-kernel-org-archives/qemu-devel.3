Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE33EC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4O-00058v-1u; Mon, 24 Aug 2026 11:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4G-00056O-Nz
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4B-0001jE-KI
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:36 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFn3sY2261417
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=SQd2Zl9tHahFRc9+z3sWOhl+/jLP2WhflWt
 oaDnMU58=; b=HZ4D/3JbpXXQFXntZsg6AUUScpVJuBjT34v4IC4lT2BCQIs4bSz
 7HTQoX0BlZeZURPT+KrrJ5A2l9m2IZ0BdXGSqRWNTl/Xnvwe9++U/v94lTkw52kY
 zZjm3mMZ3MiTJ7IlkDH2OMmOlBa8zF79F2TpZLQ84dyG2yvYg0Af4yGiQVsKSUdP
 WGcIQ7JDajmSMWeWNTpOgPHNszMwNKTuBBiDKAcuvYaTHblcjZBDyJ/ASVlboasG
 odfl0+AOr9siAZD6SUcvfxIgDyMpnyd0/dS6HH35dG6Qu6qGYjIduIXTTKqO9483
 vHmAheNGnlb2ATDYfjuR4/x8NSqZ8I2FSrw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf22jg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:27 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so3335293a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587107; x=1788191907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SQd2Zl9tHahFRc9+z3sWOhl+/jLP2WhflWtoaDnMU58=;
 b=XR/WtmkQNS83mmLZr2BZRNOxKqgTWUIZWQR+4M4wZCPP5Aft5jopZ1/urH2NhPp4D/
 ALDy5QQXfcmv980lexIaDskRnX44RzhotVTo7a/NtxsGlP9i/kgPG+Nop03VfNVNZnOk
 iCnh4UzxcGiodzKbaGxiuOpiirqt9XTJSdHpUeYFo04i1ddeZXChWVUj+jArlPJ0Y87S
 uB1NjSY22HtH/pLk1u/XUHdWssz6zLEBz1NvASUYs50OanqhFdTho5iBM5Q/sNIdEBcU
 CKreWYLRz7hDJimqwelnBsZeEiGByt5jCb13+mHy8ZCtcj5fc2j2yScywrGt60UhzrAn
 5ZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587107; x=1788191907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SQd2Zl9tHahFRc9+z3sWOhl+/jLP2WhflWtoaDnMU58=;
 b=qY5xjvAj1Q7RbouFKJuJjDCP+iCqaovF0NpbOmS9O1nAFyPT1nKtoQfKWygF1xQegP
 e2kqlre67d7cY+kT1ExcLocuKIEuBWf4dmpQnxRxNDyD4iCtx0Qy4WGk294e3oDvZCft
 WKXKyAEJwEeLC/4aU4/s2I3VJTOGz9yhCdYgcYUJiZY3VQ42Rtsa2HKuwft+HEvcAsmp
 cX3+3sdnJX16gpe51R2ppZAXdkUWIu17Odg3/rbLsencDOE9eu1QnO8zV0gYkLlS6cQd
 TdKWW8eFd7EYYtE6YdoR9b3JqQcoqLhKJUWYyPtJHguqUCuAqG7yUIJ8xzGcZ/FMdyTL
 S07w==
X-Gm-Message-State: AFuF++lThpBFetdV7VNStrXyVa8P1EZWLX3ubvYizDI2z6+fCE3ScLP9
 OuKpGNG3DKO+hPsjPsK7Dxj4gaBnJ+YHbzUCTMOmLAhG+p1t8opMgpepKE5MD+HXv7gUdlJJFKE
 0YR4sk0NyvJx/JL6JzIhwY944sZka9JaS+psnbO0tYANL75gTxSRDdwohJdg6mJ9K5go0
X-Gm-Gg: AR+sD13dPW38VBWMGI15oiB4bYbqKwHA2uPRkS4kFzBttNfh8TZVX8kDGMfrP+NYYjG
 Gufcldtq9dECL9I6YJY0wOI+0LXmxSIyA6SZYzv9hCXWhoh5uRHiq2YVbCY5wbiLNQqZ+IZaMH2
 90Ins0mW+EyD50nAllJvsyPbTG7bgQIAJR+ntQSd8Ifu6GmlpEM72WSblQXqYtaHq4rshgK+F7R
 dNIZFwj+o7UrE+HIJu+Ux7YYlg5mSV3X+AyPUfSnn9KAAqU+uKf6YoMXksiO21wqw/y/JpSw3wt
 NDKjQkRxEHCYNjCjSDwbhjNVIbUPhSTx5gYE2psNnxd+RkNjM+bOho4R122p1Q7dl5Bk65+JicO
 94cRjWJ8y2qBQjDoeUdYco3GrkHNfAO8hbCnssZz4QKveKSNDcrpI7y+QN70IJj8=
X-Received: by 2002:a05:6a21:3e0a:b0:3cd:8bba:824f with SMTP id
 adf61e73a8af0-3cd8bba82a1mr2943798637.4.1787587106705; 
 Mon, 24 Aug 2026 08:58:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:3e0a:b0:3cd:8bba:824f with SMTP id
 adf61e73a8af0-3cd8bba82a1mr2943684637.4.1787587106068; 
 Mon, 24 Aug 2026 08:58:26 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:25 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 00/14] hexagon: add semihosting support
Date: Mon, 24 Aug 2026 08:58:09 -0700
Message-Id: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX3h+tDtzj7CIK
 SaqSb9CQQNaDKj+GUZXrP00oHIYqFPU/uY/oFsbqFbcZPF8zbj78QmuekMJkAYuP9VrRh7pCL0/
 lwlAIT0beHKNDtqAD2Gt4zt2eADDDp4=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8c6a24 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=meGi3fvSS9zDSD1UJl0A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: YDyXVNWehkYxTPqu7A3aFYNxqpicN2ld
X-Proofpoint-GUID: YDyXVNWehkYxTPqu7A3aFYNxqpicN2ld
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX8MQoKrdljPTW
 cd6luJqPJPAhiawkjUuZsN80DltiZPPRVtuNAHTlKWkTGs59i018dB2m4lmw20X9k4bF6JSb9Hc
 DttOHuow8mVGbe2LEbwmKS9JZE8r4CNo0EYB3B/AFdntGaDfTsYLsCso7x3Xx7LyLp0wpazLaYE
 mj3BeT3jyW4eGOk7L/JFQ2zZ24MLr/YWgK6Ek7FpARzqkxrZ8aInM8n7nJzz/P2vQROuPOEDV30
 ryYtTnC7CZpCGhhOm5Rg2A/Y3XOKoLPHGYidMQazmIpeqCiHc3iUN/v39Fs6yEV1/hJ7wbSvYiO
 Mu18TZ3Kt+6+nteyHNuf7w6u3ZOG1dzCreHn1duPnAsNjDGkgXFn8743s0Lw8M6EBV34z3CxWQ5
 qC2V8VWyR0OgDsNqe6wMeuMf3kkAGLKQzMDpG/I2OCbxPcfrbmUEfslz8F0cDLYdWpIsxTW3DgU
 ujAAOo3BwR6/xRRweXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

This series adds semihosting support to hexagon system emulation,
together with functional tests for the added operations.

The Hexagon semihosting spec can be found at:
https://docs.qualcomm.com/doc/80-N2040-101_102648/topic/semihosting-specification.html

v1: https://lore.kernel.org/qemu-devel/cover.1783973054.git.matheus.bernardino@oss.qualcomm.com/
v2: https://lore.kernel.org/qemu-devel/3cd3a419-ee2c-4d7a-9396-60eab8d26908@oss.qualcomm.com/T/#m9e966877cda81c5661838fedadf4e69bd912cbb5
v3: https://lore.kernel.org/qemu-devel/cover.1784568922.git.matheus.bernardino@oss.qualcomm.com/

Changes in v4:
- Added patches 1 and 2: a couple hexagon fixes for big-endian hosts
- Patch 3: fix unaligned pc reporting on linux-user mode
- Patch 5: fix big-endian issues
- Patch 8 and 11: drop arch_[gs]et_(thread|system)_reg()
- Patch 10: avoid OS-specific ifdefs and fixes for big-endian
- Patch 12: define target errnos in a more readable way
- Patch 14: drop unuseful code comments

Changes in v3:
- Reworded semihosting section at Hexagon docs
- Rebased, added Reviewed-by's, dropped already merged patch

Changes in v2:
- Added patch 1, a fix for an existing bug that appeared with the new
  test semantics from the last patch.
- Patch 3: s/hexagon_touch_memory/hexagon_peek_memory_range/
- Patch 7:
  * Add semihosting spec link to docs
  * Fixed HEX_SYS_EXCEPTION
- Patch 10:
  * Moved tables to static definition
  * Fixed compilation for Windows
- Dropped patch 11 (OPEN/READ/CLOSE_DIR support): for now we don't have
  dirent semantics for Windows, so leave these ops to a followup series.
- Patch 14:
  * Update test version
  * Don't change directory
  * Don't use os.path, use scratch_file

Brian Cain (4):
  semihosting: add APIs for chardev-aware guest fd routing
  target/hexagon: Add an errno mapping
  python/machine: support routing semihosting output to the test console
  tests/functional: Add hexagon semihosting systests

Matheus Tavares Bernardino (10):
  disas/hexagon: honour target byte order when printing instructions
  target/hexagon: fix store-conditional on big-endian hosts
  target/hexagon: fix improper assign of cause code to exception index
  target/hexagon: fix PC advancement for non-COF TB terminators
  target/hexagon: add aux functions for guest mem load/store
  semihosting: add callback to set error
  target/hexagon: add semihosting support
  semihosting: add ftruncate helper (to be used for hexagon)
  target/hexagon: add main arch-specific semihosting operations
  target/hexagon: add COREDUMP semihosting operation

 configs/targets/hexagon-softmmu.mak       |   2 +
 disas/hexagon.c                           |   6 +-
 docs/system/target-hexagon.rst            |   8 +-
 hw/hexagon/Kconfig                        |   1 +
 hw/hexagon/hexagon_dsp.c                  |   2 +
 include/semihosting/common-semi.h         |   2 +
 include/semihosting/console.h             |   9 +
 include/semihosting/guestfd.h             |   9 +
 include/semihosting/syscalls.h            |   2 +
 linux-user/hexagon/cpu_loop.c             |   5 +-
 python/qemu/machine/machine.py            |  10 +-
 qemu-options.hx                           |   8 +-
 semihosting/arm-compat-semi.c             |   3 +-
 semihosting/console.c                     |   5 +
 semihosting/guestfd.c                     |   8 +
 semihosting/syscalls.c                    |  29 +
 target/arm/common-semi-target.c           |   4 +
 target/hexagon/common-semi-target.c       |  51 ++
 target/hexagon/cpu.c                      |   5 +-
 target/hexagon/cpu_helper.c               | 100 ++++
 target/hexagon/cpu_helper.h               |   6 +
 target/hexagon/genptr.c                   |   4 +-
 target/hexagon/hexswi.c                   | 672 +++++++++++++++++++++-
 target/hexagon/internal.h                 |   1 +
 target/hexagon/meson.build                |   1 +
 target/hexagon/translate.c                |  17 +-
 target/riscv/common-semi-target.c         |   4 +
 tests/functional/hexagon/meson.build      |   5 +
 tests/functional/hexagon/test_systests.py |  94 +++
 29 files changed, 1046 insertions(+), 27 deletions(-)
 create mode 100644 target/hexagon/common-semi-target.c
 create mode 100755 tests/functional/hexagon/test_systests.py

Range-diff against v3:
 -:  ---------- >  1:  16f730778f disas/hexagon: honour target byte order when printing instructions
 -:  ---------- >  2:  4fc8afeddf target/hexagon: fix store-conditional on big-endian hosts
 1:  3f809b51ae !  3:  5403f0e70b target/hexagon: fix improper assign of cause code to exception index
    @@ Commit message
         Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
    + ## linux-user/hexagon/cpu_loop.c ##
    +@@ linux-user/hexagon/cpu_loop.c: void cpu_loop(CPUHexagonState *env)
    +             break;
    +             case HEX_CAUSE_MISALIGNED_LOAD:
    +             case HEX_CAUSE_MISALIGNED_STORE:
    ++            case HEX_CAUSE_PC_NOT_ALIGNED:
    +             force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
    +                     env->gpr[HEX_REG_PC]);
    +             break;
    +@@ linux-user/hexagon/cpu_loop.c: void cpu_loop(CPUHexagonState *env)
    +                 exit(EXIT_FAILURE);
    +             }
    +             break;
    +-        case HEX_CAUSE_PC_NOT_ALIGNED:
    +-            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
    +-                            env->gpr[HEX_REG_R31]);
    +-            break;
    +         case HEX_CAUSE_INVALID_PACKET:
    +         case HEX_CAUSE_REG_WRITE_CONFLICT:
    +             force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
    +
      ## target/hexagon/cpu.c ##
     @@ target/hexagon/cpu.c: static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
              hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
 2:  903af8b645 =  4:  c1dad05e0a target/hexagon: fix PC advancement for non-COF TB terminators
 3:  334bb76346 !  5:  a1f63c8909 target/hexagon: add aux functions for guest mem load/store
    @@ target/hexagon/cpu_helper.c
     +#ifndef CONFIG_USER_ONLY
     +
     +static bool hexagon_read_memory_small(CPUHexagonState *env, target_ulong addr,
    -+                                      int byte_count, unsigned char *dstbuf,
    ++                                      int byte_count, uint64_t *data,
     +                                      int mmu_idx, uintptr_t retaddr)
     + {
     +    /* handle small sizes */
     +    switch (byte_count) {
     +    case 1:
    -+        *dstbuf = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, retaddr);
    ++        *data = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, retaddr);
     +        return true;
     +
     +    case 2:
    -+        if (QEMU_IS_ALIGNED(addr, 2)) {
    -+            *(unsigned short *)dstbuf =
    -+                cpu_lduw_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
    -+            return true;
    -+        }
    -+        break;
    ++        *data = cpu_lduw_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
    ++        return true;
     +
     +    case 4:
    -+        if (QEMU_IS_ALIGNED(addr, 4)) {
    -+            *(uint32_t *)dstbuf =
    -+                cpu_ldl_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
    -+            return true;
    -+        }
    -+        break;
    ++        *data = cpu_ldl_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
    ++        return true;
     +
     +    case 8:
    -+        if (QEMU_IS_ALIGNED(addr, 8)) {
    -+            *(uint64_t *)dstbuf =
    -+                cpu_ldq_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
    -+            return true;
    -+        }
    -+        break;
    ++        *data = cpu_ldq_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
    ++        return true;
     +
     +    default:
     +        /* larger request, handle elsewhere */
     +        return false;
     +    }
    -+
    -+    /* not aligned, copy bytes */
    -+    for (int i = 0; i < byte_count; ++i) {
    -+        *dstbuf++ = cpu_ldub_mmuidx_ra(env, addr++, mmu_idx, retaddr);
    -+    }
    -+    return true;
     +}
     +
     +void hexagon_read_memory(CPUHexagonState *env, target_ulong vaddr, int size,
    @@ target/hexagon/cpu_helper.c
     +    BQL_LOCK_GUARD();
     +    CPUState *cs = env_cpu(env);
     +    unsigned mmu_idx = cpu_mmu_index(cs, false);
    -+    if (!hexagon_read_memory_small(env, vaddr, size, retptr, mmu_idx,
    -+                                   retaddr)) {
    ++    uint64_t data;
    ++    if (hexagon_read_memory_small(env, vaddr, size, &data, mmu_idx, retaddr)) {
    ++        stn_he_p(retptr, size, data);
    ++    } else {
     +        cpu_abort(cs, "%s: ERROR: bad size = %d!\n", __func__, size);
     +    }
     +}
     +
     +static bool hexagon_write_memory_small(CPUHexagonState *env, target_ulong addr,
    -+                                       int byte_count, unsigned char *srcbuf,
    ++                                       int byte_count, uint64_t data,
     +                                       int mmu_idx, uintptr_t retaddr)
     +{
     +    /* handle small sizes */
     +    switch (byte_count) {
     +    case 1:
    -+        cpu_stb_mmuidx_ra(env, addr, *srcbuf, mmu_idx, retaddr);
    ++        cpu_stb_mmuidx_ra(env, addr, (uint8_t)data, mmu_idx, retaddr);
     +        return true;
     +
     +    case 2:
    -+        if (QEMU_IS_ALIGNED(addr, 2)) {
    -+            cpu_stw_le_mmuidx_ra(env, addr, *(uint16_t *)srcbuf, mmu_idx, retaddr);
    -+            return true;
    -+        }
    -+        break;
    ++        cpu_stw_le_mmuidx_ra(env, addr, (uint16_t)data, mmu_idx, retaddr);
    ++        return true;
     +
     +    case 4:
    -+        if (QEMU_IS_ALIGNED(addr, 4)) {
    -+            cpu_stl_le_mmuidx_ra(env, addr, *(uint32_t *)srcbuf, mmu_idx, retaddr);
    -+            return true;
    -+        }
    -+        break;
    ++        cpu_stl_le_mmuidx_ra(env, addr, (uint32_t)data, mmu_idx, retaddr);
    ++        return true;
     +
     +    case 8:
    -+        if (QEMU_IS_ALIGNED(addr, 8)) {
    -+            cpu_stq_le_mmuidx_ra(env, addr, *(uint64_t *)srcbuf, mmu_idx, retaddr);
    -+            return true;
    -+        }
    -+        break;
    ++        cpu_stq_le_mmuidx_ra(env, addr, (uint64_t)data, mmu_idx, retaddr);
    ++        return true;
     +
     +    default:
     +        /* larger request, handle elsewhere */
     +        return false;
     +    }
    -+
    -+    /* not aligned, copy bytes */
    -+    for (int i = 0; i < byte_count; ++i) {
    -+        cpu_stb_mmuidx_ra(env, addr++, *srcbuf++, mmu_idx, retaddr);
    -+    }
    -+
    -+    return true;
     +}
     +
     +void hexagon_write_memory(CPUHexagonState *env, target_ulong vaddr,
    @@ target/hexagon/cpu_helper.c
     +{
     +    CPUState *cs = env_cpu(env);
     +    unsigned mmu_idx = cpu_mmu_index(cs, false);
    -+    if (!hexagon_write_memory_small(env, vaddr, size, (unsigned char *)&data,
    -+                                   mmu_idx, retaddr)) {
    ++    if (!hexagon_write_memory_small(env, vaddr, size, data, mmu_idx, retaddr)) {
     +        cpu_abort(cs, "%s: ERROR: bad size = %d!\n", __func__, size);
     +    }
     +}
 4:  f2fc7ed466 <  -:  ---------- hexagon: cpu_helper: add reg reading/writing helpers
 5:  c8f8868aa7 =  6:  47eb2ef70d semihosting: add APIs for chardev-aware guest fd routing
 6:  ef17701179 =  7:  a37971603c semihosting: add callback to set error
 7:  f0d35e6115 !  8:  7529648c78 target/hexagon: add semihosting support
    @@ target/hexagon/common-semi-target.c (new)
     +uint64_t common_semi_arg(CPUState *cs, int argno)
     +{
     +    CPUHexagonState *env = cpu_env(cs);
    -+    return arch_get_thread_reg(env, HEX_REG_R00 + argno);
    ++    return env->gpr[HEX_REG_R00 + argno];
     +}
     +
     +void common_semi_set_ret(CPUState *cs, uint64_t ret)
     +{
     +    CPUHexagonState *env = cpu_env(cs);
    -+    arch_set_thread_reg(env, HEX_REG_R00, ret);
    ++    env->gpr[HEX_REG_R00] = ret;
     +}
     +
     +void common_semi_set_err(CPUState *cs, int err)
     +{
     +    CPUHexagonState *env = cpu_env(cs);
    -+    arch_set_thread_reg(env, HEX_REG_R01, err);
    ++    env->gpr[HEX_REG_R01] = err;
     +}
     +
     +bool common_semi_sys_exit_is_extended(CPUState *cs)
    @@ target/hexagon/common-semi-target.c (new)
     +uint64_t common_semi_stack_bottom(CPUState *cs)
     +{
     +    CPUHexagonState *env = cpu_env(cs);
    -+    return arch_get_thread_reg(env, HEX_REG_SP);
    ++    return env->gpr[HEX_REG_SP];
     +}
     +
     +bool common_semi_has_synccache(CPUArchState *env)
    @@ target/hexagon/hexswi.c
     +    g_assert(bql_locked());
     +    init_semihosting_guestfds();
     +
    -+    what_swi = arch_get_thread_reg(env, HEX_REG_R00);
    -+    swi_info = arch_get_thread_reg(env, HEX_REG_R01);
    ++    what_swi = env->gpr[HEX_REG_R00];
    ++    swi_info = env->gpr[HEX_REG_R01];
     +
     +    qemu_log_mask(CPU_LOG_INT,
     +                  "sim_handle_trap0: swi=0x%" PRIx32
     +                  " info=0x%" PRIx32 " PC=0x%" PRIx32
     +                  " thread=%" PRId32 "\n",
     +                  (uint32_t)what_swi, (uint32_t)swi_info,
    -+                  (uint32_t)arch_get_thread_reg(env, HEX_REG_PC),
    ++                  (uint32_t)env->gpr[HEX_REG_PC],
     +                  (uint32_t)env->threadId);
     +
     +    if (!is_hexagon_specific_swi_flag(what_swi)) {
    @@ target/hexagon/hexswi.c
     +
     +    case HEX_SYS_EXCEPTION:
     +    {
    -+        uint32_t ret = arch_get_thread_reg(env, HEX_REG_R02);
    -+        arch_set_system_reg(env, HEX_SREG_MODECTL, 0);
    ++        uint32_t ret = env->gpr[HEX_REG_R02];
    ++        env->gpr[HEX_SREG_MODECTL] = 0;
     +        gdb_exit(ret);
     +        exit(ret);
     +    }
    @@ target/hexagon/hexswi.c
     +    /* TODO: implement other hexagon-specific semihosting calls */
     +
     +    default:
    -+        qemu_log_mask(LOG_GUEST_ERROR,
    ++        qemu_log_mask(LOG_UNIMP,
     +                      "unknown swi request: 0x%" PRIx32 "\n",
     +                      (uint32_t)what_swi);
     +        common_semi_cb(cs, -1, ENOSYS);
    @@ target/hexagon/hexswi.c: void hexagon_cpu_do_interrupt(CPUState *cs)
     
      ## target/hexagon/meson.build ##
     @@ target/hexagon/meson.build: hexagon_softmmu_ss.add(files(
    +     'hex_interrupts.c',
    +     'hexswi.c',
          'machine.c',
    ++    'common-semi-target.c',
      ))
      
    -+hexagon_softmmu_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
    -+                       if_true: files('common-semi-target.c'))
    -+
      #
    - # Step 4.5
    - # We use flex/bison based idef-parser to generate TCG code for a lot
 8:  35d0c39f75 =  9:  2b36fa4993 semihosting: add ftruncate helper (to be used for hexagon)
 9:  924d0069ad ! 10:  dde7923648 target/hexagon: add main arch-specific semihosting operations
    @@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
     +            err = errno;
     +        }
     +        if (rc == 0) {
    -+            sys_stat.dev   = st_buf.st_dev;
    -+            sys_stat.ino   = st_buf.st_ino;
    -+            sys_stat.mode  = st_buf.st_mode;
    -+            sys_stat.nlink = (uint32_t) st_buf.st_nlink;
    -+            sys_stat.rdev  = st_buf.st_rdev;
    -+            sys_stat.size  = (uint32_t) st_buf.st_size;
    -+#if defined(__linux__)
    -+            sys_stat.atime = (uint32_t) st_buf.st_atim.tv_sec;
    -+            sys_stat.mtime = (uint32_t) st_buf.st_mtim.tv_sec;
    -+            sys_stat.ctime = (uint32_t) st_buf.st_ctim.tv_sec;
    -+#elif defined(_WIN32)
    -+            sys_stat.atime = st_buf.st_atime;
    -+            sys_stat.mtime = st_buf.st_mtime;
    -+            sys_stat.ctime = st_buf.st_ctime;
    -+#endif
    ++            sys_stat.dev   = cpu_to_le64(st_buf.st_dev);
    ++            sys_stat.ino   = cpu_to_le64(st_buf.st_ino);
    ++            sys_stat.mode  = cpu_to_le32(st_buf.st_mode);
    ++            sys_stat.nlink = cpu_to_le32((uint32_t) st_buf.st_nlink);
    ++            sys_stat.rdev  = cpu_to_le64(st_buf.st_rdev);
    ++            sys_stat.size  = cpu_to_le32((uint32_t) st_buf.st_size);
    ++            sys_stat.atime = cpu_to_le32(st_buf.st_atime);
    ++            sys_stat.mtime = cpu_to_le32(st_buf.st_mtime);
    ++            sys_stat.ctime = cpu_to_le32(st_buf.st_ctime);
     +        }
     +        hexagon_read_memory(env, swi_info + 4, 4, &statBufferAddr, retaddr);
     +
    @@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
     +    case HEX_SYS_READ_TCYCLES:
     +    case HEX_SYS_READ_ICOUNT:
     +    {
    -+        arch_set_thread_reg(env, HEX_REG_R00, 0);
    -+        arch_set_thread_reg(env, HEX_REG_R01, 0);
    ++        env->gpr[HEX_REG_R00] = 0;
    ++        env->gpr[HEX_REG_R01] = 0;
     +        break;
     +    }
     +
     +    case HEX_SYS_READ_PCYCLES:
     +    {
    -+        arch_set_thread_reg(env, HEX_REG_R00,
    -+            arch_get_system_reg(env, HEX_SREG_PCYCLELO));
    -+        arch_set_thread_reg(env, HEX_REG_R01,
    -+            arch_get_system_reg(env, HEX_SREG_PCYCLEHI));
    ++        env->gpr[HEX_REG_R00] = hexagon_get_sys_pcycle_count_low(env);
    ++        env->gpr[HEX_REG_R01] = hexagon_get_sys_pcycle_count_high(env);
     +        break;
     +    }
     +
    @@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
     +        break;
      
          default:
    -         qemu_log_mask(LOG_GUEST_ERROR,
    +         qemu_log_mask(LOG_UNIMP,
10:  a81c46b955 ! 11:  0664a4a5a9 target/hexagon: add COREDUMP semihosting operation
    @@ target/hexagon/hexswi.c: static void common_semi_ftell_cb(CPUState *cs, uint64_t
      
     +static void coredump(CPUHexagonState *env)
     +{
    -+    uint32_t ssr = arch_get_system_reg(env, HEX_SREG_SSR);
    ++    uint32_t ssr = env->t_sreg[HEX_SREG_SSR];
     +    FILE *f = qemu_log_trylock();
     +
     +    if (!f) {
    @@ target/hexagon/hexswi.c: static void common_semi_ftell_cb(CPUState *cs, uint64_t
     +        break;
     +    case HEX_CAUSE_MISALIGNED_LOAD:
     +        fprintf(f, "0x%x, Misaligned Load @ 0x%" PRIx32,
    -+                HEX_CAUSE_MISALIGNED_LOAD,
    -+                arch_get_system_reg(env, HEX_SREG_BADVA));
    ++                HEX_CAUSE_MISALIGNED_LOAD, env->t_sreg[HEX_SREG_BADVA]);
     +        break;
     +    case HEX_CAUSE_MISALIGNED_STORE:
     +        fprintf(f, "0x%x, Misaligned Store @ 0x%" PRIx32,
    -+                HEX_CAUSE_MISALIGNED_STORE,
    -+                arch_get_system_reg(env, HEX_SREG_BADVA));
    ++                HEX_CAUSE_MISALIGNED_STORE, env->t_sreg[HEX_SREG_BADVA]);
     +        break;
     +    case HEX_CAUSE_PRIV_NO_READ:
     +        fprintf(f, "0x%x, Privilege violation: "
     +                "user/guest read permission @ 0x%" PRIx32,
    -+                HEX_CAUSE_PRIV_NO_READ,
    -+                arch_get_system_reg(env, HEX_SREG_BADVA));
    ++                HEX_CAUSE_PRIV_NO_READ, env->t_sreg[HEX_SREG_BADVA]);
     +        break;
     +    case HEX_CAUSE_PRIV_NO_WRITE:
     +        fprintf(f, "0x%x, Privilege violation: "
     +                "user/guest write permission @ 0x%" PRIx32,
    -+                HEX_CAUSE_PRIV_NO_WRITE,
    -+                arch_get_system_reg(env, HEX_SREG_BADVA));
    ++                HEX_CAUSE_PRIV_NO_WRITE, env->t_sreg[HEX_SREG_BADVA]);
     +        break;
     +    case HEX_CAUSE_PRIV_NO_UREAD:
     +        fprintf(f, "0x%x, Privilege violation:"
     +                " user read permission @ 0x%" PRIx32,
    -+                HEX_CAUSE_PRIV_NO_UREAD,
    -+                arch_get_system_reg(env, HEX_SREG_BADVA));
    ++                HEX_CAUSE_PRIV_NO_UREAD, env->t_sreg[HEX_SREG_BADVA]);
     +        break;
     +    case HEX_CAUSE_PRIV_NO_UWRITE:
     +        fprintf(f, "0x%x, Privilege violation:"
     +                " user write permission @ 0x%" PRIx32,
    -+                HEX_CAUSE_PRIV_NO_UWRITE,
    -+                arch_get_system_reg(env, HEX_SREG_BADVA));
    ++                HEX_CAUSE_PRIV_NO_UWRITE, env->t_sreg[HEX_SREG_BADVA]);
     +        break;
     +    case HEX_CAUSE_COPROC_LDST:
     +        fprintf(f, "0x%x, Coprocessor VMEM address error @ 0x%" PRIx32,
    -+                HEX_CAUSE_COPROC_LDST,
    -+                arch_get_system_reg(env, HEX_SREG_BADVA));
    ++                HEX_CAUSE_COPROC_LDST, env->t_sreg[HEX_SREG_BADVA]);
     +        break;
     +    case HEX_CAUSE_STACK_LIMIT:
     +        fprintf(f, "0x%x, Stack limit check error",
11:  289e5cb2d9 ! 12:  71b686df7f target/hexagon: Add an errno mapping
    @@ target/hexagon/hexswi.c: static void do_preload(CPUHexagonState *env, target_ulo
      }
      
     +/* Hexagon semihosting errno values */
    -+#define HEX_EINVAL          22
    -+#define HEX_ERRNOS \
    -+    HEX_ERRNO(EPERM,        1) \
    -+    HEX_ERRNO(ENOENT,       2) \
    -+    HEX_ERRNO(EINTR,        4) \
    -+    HEX_ERRNO(EIO,          5) \
    -+    HEX_ERRNO(ENXIO,        6) \
    -+    HEX_ERRNO(EBADF,        9) \
    -+    HEX_ERRNO(EAGAIN,       11) \
    -+    HEX_ERRNO(ENOMEM,       12) \
    -+    HEX_ERRNO(EACCES,       13) \
    -+    HEX_ERRNO(EFAULT,       14) \
    -+    HEX_ERRNO(EBUSY,        16) \
    -+    HEX_ERRNO(EEXIST,       17) \
    -+    HEX_ERRNO(EXDEV,        18) \
    -+    HEX_ERRNO(ENODEV,       19) \
    -+    HEX_ERRNO(ENOTDIR,      20) \
    -+    HEX_ERRNO(EISDIR,       21) \
    -+    HEX_ERRNO(EINVAL,       HEX_EINVAL) \
    -+    HEX_ERRNO(ENFILE,       23) \
    -+    HEX_ERRNO(EMFILE,       24) \
    -+    HEX_ERRNO(ENOTTY,       25) \
    -+    HEX_ERRNO(ETXTBSY,      26) \
    -+    HEX_ERRNO(EFBIG,        27) \
    -+    HEX_ERRNO(ENOSPC,       28) \
    -+    HEX_ERRNO(ESPIPE,       29) \
    -+    HEX_ERRNO(EROFS,        30) \
    -+    HEX_ERRNO(EMLINK,       31) \
    -+    HEX_ERRNO(EPIPE,        32) \
    -+    HEX_ERRNO(ERANGE,       34) \
    -+    HEX_ERRNO(ENAMETOOLONG, 36) \
    -+    HEX_ERRNO(ENOSYS,       38) \
    -+    HEX_ERRNO(ELOOP,        40) \
    -+    HEX_ERRNO(EOVERFLOW,    75)
    ++enum {
    ++    TARGET_EPERM        =  1,
    ++    TARGET_ENOENT       =  2,
    ++    TARGET_EINTR        =  4,
    ++    TARGET_EIO          =  5,
    ++    TARGET_ENXIO        =  6,
    ++    TARGET_EBADF        =  9,
    ++    TARGET_EAGAIN       = 11,
    ++    TARGET_ENOMEM       = 12,
    ++    TARGET_EACCES       = 13,
    ++    TARGET_EFAULT       = 14,
    ++    TARGET_EBUSY        = 16,
    ++    TARGET_EEXIST       = 17,
    ++    TARGET_EXDEV        = 18,
    ++    TARGET_ENODEV       = 19,
    ++    TARGET_ENOTDIR      = 20,
    ++    TARGET_EISDIR       = 21,
    ++    TARGET_EINVAL       = 22,
    ++    TARGET_ENFILE       = 23,
    ++    TARGET_EMFILE       = 24,
    ++    TARGET_ENOTTY       = 25,
    ++    TARGET_ETXTBSY      = 26,
    ++    TARGET_EFBIG        = 27,
    ++    TARGET_ENOSPC       = 28,
    ++    TARGET_ESPIPE       = 29,
    ++    TARGET_EROFS        = 30,
    ++    TARGET_EMLINK       = 31,
    ++    TARGET_EPIPE        = 32,
    ++    TARGET_ERANGE       = 34,
    ++    TARGET_ENAMETOOLONG = 36,
    ++    TARGET_ENOSYS       = 38,
    ++    TARGET_ELOOP        = 40,
    ++    TARGET_EOVERFLOW    = 75,
    ++};
     +
     +/* Map host errno to hexagon semihosting errno */
    ++static uint32_t errno_h2g(uint32_t err) {
    ++    switch (err) {
    ++    case 0:            return 0;
    ++    case EPERM:        return TARGET_EPERM;
    ++    case ENOENT:       return TARGET_ENOENT;
    ++    case EINTR:        return TARGET_EINTR;
    ++    case EIO:          return TARGET_EIO;
    ++    case ENXIO:        return TARGET_ENXIO;
    ++    case EBADF:        return TARGET_EBADF;
    ++    case EAGAIN:       return TARGET_EAGAIN;
    ++    case ENOMEM:       return TARGET_ENOMEM;
    ++    case EACCES:       return TARGET_EACCES;
    ++    case EFAULT:       return TARGET_EFAULT;
    ++    case EBUSY:        return TARGET_EBUSY;
    ++    case EEXIST:       return TARGET_EEXIST;
    ++    case EXDEV:        return TARGET_EXDEV;
    ++    case ENODEV:       return TARGET_ENODEV;
    ++    case ENOTDIR:      return TARGET_ENOTDIR;
    ++    case EISDIR:       return TARGET_EISDIR;
    ++    case EINVAL:       return TARGET_EINVAL;
    ++    case ENFILE:       return TARGET_ENFILE;
    ++    case EMFILE:       return TARGET_EMFILE;
    ++    case ENOTTY:       return TARGET_ENOTTY;
    ++    case ETXTBSY:      return TARGET_ETXTBSY;
    ++    case EFBIG:        return TARGET_EFBIG;
    ++    case ENOSPC:       return TARGET_ENOSPC;
    ++    case ESPIPE:       return TARGET_ESPIPE;
    ++    case EROFS:        return TARGET_EROFS;
    ++    case EMLINK:       return TARGET_EMLINK;
    ++    case EPIPE:        return TARGET_EPIPE;
    ++    case ERANGE:       return TARGET_ERANGE;
    ++    case ENAMETOOLONG: return TARGET_ENAMETOOLONG;
    ++    case ENOSYS:       return TARGET_ENOSYS;
    ++    case ELOOP:        return TARGET_ELOOP;
    ++    case EOVERFLOW:    return TARGET_EOVERFLOW;
    ++    }
    ++    return TARGET_EINVAL;
    ++}
    ++
     +static void semi_cb(CPUState *cs, uint64_t ret, int err)
     +{
    -+#define HEX_ERRNO(NAME, CODE) case NAME: err = CODE; break;
    -+    switch (err) {
    -+    case 0:
    -+        break;
    -+    HEX_ERRNOS
    -+    default:
    -+        err = HEX_EINVAL;
    -+        break;
    -+    }
    -+    common_semi_cb(cs, ret, err);
    ++    common_semi_cb(cs, ret, errno_h2g(err));
     +}
     +
      static void common_semi_ftell_cb(CPUState *cs, uint64_t ret, int err)
    @@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
                            "SWI call %" PRIx32
                            " is unimplemented in QEMU\n",
     @@ target/hexagon/hexswi.c: static void sim_handle_trap0(CPUHexagonState *env)
    -         qemu_log_mask(LOG_GUEST_ERROR,
    +         qemu_log_mask(LOG_UNIMP,
                            "unknown swi request: 0x%" PRIx32 "\n",
                            (uint32_t)what_swi);
     -        common_semi_cb(cs, -1, ENOSYS);
12:  61d0585371 = 13:  abcd31dac2 python/machine: support routing semihosting output to the test console
13:  12b2448ce3 ! 14:  0aab35393d tests/functional: Add hexagon semihosting systests
    @@ tests/functional/hexagon/test_systests.py (new)
     +        self.archive_extract(self.ASSET_TARBALL)
     +
     +    def binary(self, name):
    -+        """Return the full path to binary *name* inside bin dir."""
     +        path = self.scratch_file(*_TARBALL_BIN_PATH, name)
     +        self.assertTrue(os.path.exists(path))
     +        return path
     +
     +    def run_exit_zero(self, binary_name, *extra_args, machine="V66G_1024"):
    -+        """Launch *binary_name* and assert it exits with code 0.
    -+
    -+        :param binary_name: name of the binary inside bin dir.
    -+        :param extra_args: optional pairs of (flag, value) strings passed
    -+            to set_vm_arg(), e.g. ('-append', 'myarg').
    -+        :param machine: QEMU machine type (default "V66G_1024").
    -+        """
     +        self.set_machine(machine)
     +        self.set_vm_arg("-display", "none")
     +        self.set_vm_arg("-kernel", self.binary(binary_name))
    @@ tests/functional/hexagon/test_systests.py (new)
     +
     +    def run_console_pattern(self, binary_name, pattern, *extra_args,
     +                            machine="V66G_1024"):
    -+        """Launch *binary_name* and wait for *pattern* on the semihosting console.
    -+
    -+        :param binary_name: name of the binary inside bin dir.
    -+        :param pattern: string pattern to wait for via wait_for_console_pattern.
    -+        :param extra_args: optional pairs of (flag, value) strings passed
    -+            to set_vm_arg(), e.g. ('-append', 'myarg').
    -+        :param machine: QEMU machine type (default "V66G_1024").
    -+        """
     +        self.set_machine(machine)
     +        self.set_vm_arg("-display", "none")
     +        self.set_vm_arg("-kernel", self.binary(binary_name))
-- 
2.37.2


