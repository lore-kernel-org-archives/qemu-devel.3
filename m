Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D63CA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBHVi-0004LI-Rc; Mon, 28 Sep 2026 15:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBHVN-0004KK-4n
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:59:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBHVH-0006hy-7V
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:59:12 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI00is1384871
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 19:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=6h6ewQlcslb6o35Pe7JwdOvqw2Cz138bscq
 5UMFbsjA=; b=WcOFFE3Dzzd4Ug2Fp0pF4qI5gJA2tM9fNzXD5Kwe/FLQ8V5DCL7
 +91WpwcESigQ4OL7qI+eChmrd+E76G7KfYVzPZ2+WTMU2zPI8Pl1+DBDK0iXTY46
 y2rspupto6IRj2njfJ4YZyFucG3Z9ipl5qqifWvX5/P4DZgH6HBO8CygryLyQ8Wp
 oh6rlUYNFTVFRCe/1x1zUBBU+TYRxNKyenq7X7daVcerblL42fOXIV7U7xFMSG5p
 WrehV0YMlqO1kMoZnS9gLZzPnEZ0CoCXF9iBK2AhQ85zBCl6A+z8X941aWgIIRQ1
 HiKvNXhZ96R0emY2daCuGQa4/qAK78JqWew==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt139w8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 19:59:08 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-915e6c351f3so24206896d6.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790625548; x=1791230348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6h6ewQlcslb6o35Pe7JwdOvqw2Cz138bscq5UMFbsjA=;
 b=VpSAAjIDVFl6/7FngMBi07Qt0Pb7pK40wUD7z1QFMbkUkq4Dov5jDlhu8zWzmQA+7x
 tfXy67OFb9yoVx78djGHLjw1NAbPx2d1knJ54Cg8vdT6e0eTEJeifXD4x1Xp+EjRnV8h
 ao5I55/z/gBzEBtt59fUyTvX39CT4ItMngMswGOHZ3ICbFvGomW2T8yX9PSR8n2MyUfX
 LKTKaFw+XKJm1hMfBMBUIa2ZdacPDxI/hGr+UpHFHhsbW4ImrhbzLcE/ZRLEzihLMukR
 0WWLfh72s2fWa8qIW9njEwV7BsK7gGrsyRRNay4gtvdvkXKtSmbWzc0EyKKeCFcMzCup
 5LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790625548; x=1791230348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6h6ewQlcslb6o35Pe7JwdOvqw2Cz138bscq5UMFbsjA=;
 b=0mb0uAzQMdzp47+lKLiYpe82XJKtczYhyx1HpEu9wsYkGQr2+khzdadCcJ04yj7bWQ
 OAj8rAUc5+LRxNmlC/ZOSWpY4ywHWkRZHTSTZhNsWpkVGcEOR9waarzJ1j3YmWJ1Sb1K
 8lugfT/XajwKdW/26ib5wWqRxckne5r9SyeXB2slpHK9vcom5oLuyYTT6+Xh5rtrpsu+
 5VZMjpUtuNzH4jzJm1MEaOX8LduzqmXa+YMH2LWhde6i9P6IVFAy3Ut3JpRwYPU2sDLj
 l6wXQDYGkLrMCCnvXSqRSlFnLMhr2iOB/InCgLSS5ZduzLeHZnL42weU3x0AB1qUBGDX
 Qdww==
X-Gm-Message-State: AFuF++mK2u9l88MAeibDZ/qDdFa5PRN3rp9ggXVy55Q5+x9YVJNkpDj2
 Fq6Zj84eDBGZeZLEEhZPrOmFWIOaslP4lyO97iYkzbzdjTQZn72qo/xjkWcgFcLTeS2DBOGiFjJ
 hVyeGKiXthxrOVBNcram/FiAQGh9CAmbitaxE+6kLfw7YnC/IYJVhMiXxk+4oZAyk2A==
X-Gm-Gg: AYBFou0em2exl2p86iQBrL+DPxgOlA/XyahN20ey0R+t/po0QoU8M+t7wRSHuPtMilU
 g2DjAcpsu1rSmU5fTvY8fF6MtOdWb9nUUsDXSLqvbdjLerZeMsmGaS+0fy0HpFKu6aXJX/3IthS
 qcPnRju8ymY2mqE40b2TzkIrcCA9AA1uVN5IGhNIQL9XYyhIaqCSYrKIdcg1CbtYLRO4oSCtzDa
 h3bbNmrf4CZu5m3/yWppSHsn+FYE0LnsYAJdxe8QsGBqPw2XqdVrdmZBWCkeW1yKiVLM2+X76pt
 vxqsJX/X0o9PBG9XYcJo0HBmQ7GS3KUh+z0NI9Y604RNwAwyWQ7IX1AkL9TKZbV1ZWeoka4BpKg
 ODWm7sO5YxZX0lNA6uoxJLJLMeM7OXhsafkA=
X-Received: by 2002:a05:6214:29ce:b0:8ef:4ed2:316 with SMTP id
 6a1803df08f44-917819e1cb7mr23876776d6.1.1790625547970; 
 Mon, 28 Sep 2026 12:59:07 -0700 (PDT)
X-Received: by 2002:a05:6214:29ce:b0:8ef:4ed2:316 with SMTP id
 6a1803df08f44-917819e1cb7mr23876376d6.1.1790625547491; 
 Mon, 28 Sep 2026 12:59:07 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9143d0a64b9sm75905556d6.35.2026.09.28.12.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:59:06 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v10 0/7] riscv: add initial sdext support
Date: Mon, 28 Sep 2026 16:58:54 -0300
Message-ID: <20260928195902.2045235-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3OSBTYWx0ZWRfX1+iupxaorTl5
 SNKA/rC3JeQtCQbn7jxgDgNGpl5XrMma/fLRkEVPJmwpUcjk27v4q+q0TSZ8wwhpLQS4hJvLN5D
 HUURMjKNV+AvNvj5yXkIKa2XyjVwWj4H8/ksnfe/R1A3+ziZz0/qGoKfGFztR1It+KgFBjXtUnl
 ERxsLQ5CO95xfEomoK/57fZtu8l98xsKRbepfieKUA99eqA8NNcpBOhL8xB0N5oHkW9NHxRk760
 sxfEGxFPDnfpzxlEJMV56SDbOVSS9XwkSrQyRtNe6w8X8oklTSw5RSvXJ17QuHbyOEDpz0BHDUD
 jMxgrg+1w6KpFX918/uKyHuLSkk4x88rgr+VAYYn7I/W53GhA7ANb8hdTwt7qYF9im9hxME//Vg
 +lzu4AXv3/LRnW714g+IzbC/vnQuN6/6/2ovoTAMjT1MsKurfNqHF3hQkr6JCwP64xuDgs6bLt+
 0uxfufWgsupEDJicg/A==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6abac70c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_RQOco2gYyG3p533wUoA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: LLiPgEnNqKbHsUeUzjwsZ91H--3eVzg0
X-Proofpoint-GUID: LLiPgEnNqKbHsUeUzjwsZ91H--3eVzg0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3OSBTYWx0ZWRfX+vVCGYNDapB4
 iJu2BiWTOoyqIR0nMTrL0ukA2nFQ1vFEzfbMZ7G8Ib3v2di0UXnUHTbBDtlm2vi1SUxnR08Xw+D
 E7StIzwoGJzfCjx+COKZpTOWQ6BmHv8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280079
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

In this version we have minor changes proposed during v8, in particular
the 'dcsr' field being an uint32_t instead of a target_ulong given that
the reg is always 32 bits.

No other changes made.  Patches based on alistair/riscv-to-apply.next.

Changes from v9:
- patch 1:
  - change 'dcsr' field type from target_ulong to uint32_t.
- patch 2
  - remove (target_ulong) cast when evaluating env->dcsr in
    riscv_cpu_enter_debug_mode();
  - move var declarations to the top of riscv_cpu_leave_debug_mode().
- patch 3:
  - move 'retpc' var declaration up in helper_dret().
- v9 link: https://lore.kernel.org/qemu-devel/20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com/


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
 target/riscv/machine.c                        |  22 +++
 target/riscv/tcg/cpu_helper.c                 |  94 +++++++++++++
 target/riscv/tcg/csr.c                        | 126 ++++++++++++++++++
 target/riscv/tcg/debug.c                      |  59 +++++++-
 .../tcg/insn_trans/trans_privileged.c.inc     |  24 ++++
 target/riscv/tcg/op_helper.c                  |  72 ++++++++++
 target/riscv/tcg/tcg-cpu.c                    |  19 +++
 target/riscv/tcg/translate.c                  |  15 ++-
 tests/tcg/riscv64/system/meson.build          |   8 ++
 tests/tcg/riscv64/test-sdext-sigill.S         |  83 ++++++++++++
 17 files changed, 574 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-sdext-sigill.S

-- 
2.43.0


