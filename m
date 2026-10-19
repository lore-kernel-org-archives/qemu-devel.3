Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74A606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V3UuSQOz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IogI8Tla
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIun7-0001aY-81; Mon, 19 Oct 2026 17:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun6-0001aH-3f
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun3-0005fb-Jr
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK1wo3627855
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=c2/MD9lwFqpgJ+2ZoSDTXt
 yxlqz/M09VA2v9vttHCZ8=; b=V3UuSQOz1tOdFJJPRp0j5EfgzjMpkNSUjHIhNp
 mUA2v2TxayDq+GNXCF6ev1I+fHg43o5/zBZQlOcD4CnDuUKd943FoiKecQcp5qbI
 5uYU34AbpBqaPfJQDFfHkgUf9eA7NNMbJ4aNMnFooUAMXMW6aJDnVDS5bfm0fslJ
 INY6CSk+s2SQlN1plMiCFesogmGyTc5EdSjZMuRnLgDLpP39BushcclnpVSYOjbq
 VMzoK32Og0nOWC9EVTo3fXvQ9ekqpJfr7j4eLS9bq8UIzHmuVKnGtukhNLW2OocC
 1tFgYlOpezE3YWzVKWOXbpcXwWQIUVUFKZkmMwSAfnlQ48oQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr42gptc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac77c3ff6aso3442664a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444862; x=1793049662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c2/MD9lwFqpgJ+2ZoSDTXtyxlqz/M09VA2v9vttHCZ8=;
 b=IogI8TlaQGzMtnn5wnFlVh5B0xwW9AsFv+H6oSQ2+jHpevvYiAIOlUiAVVzlkU30k1
 5j6Te6evA5EPv4bWEKKC2KowyAoBhGcUcHhnEQfEC56+DtJ48jQ/yOR0A4ivuoE9uj3k
 zNBBQtgFH9ivAPIMg4xEt/oayUlWXznl5dllThibRtpPaoM2LCaDEoR+owLnCxjF+YWa
 K6L+7Df8KvPoebAzfA4qJEilj4Bz4gtMKFXTsgo7awId1AQSDAXO3zSEVWcVzvK/VUnM
 vmvoYQeQ2kn4dPyUCl2EB2ecVOqF04iFtq7RhVJH1Sl5Xjv+GTXDUmWjLetbClCf9R2k
 sXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444862; x=1793049662;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c2/MD9lwFqpgJ+2ZoSDTXtyxlqz/M09VA2v9vttHCZ8=;
 b=UVxrC1gegPHaHkphmLiTJwViYUYnHA4xfwBsdQJjLybrJoKorkaLuGGfRR0EIgGavi
 fCcCYM3qoFfpR4iqtqr/HiXNw5OCBVQrlnTX8a9XDWhxZJ1VzpyPBe8OuuMblyObrPyI
 3GpQq+1RECcZQG/Kta/jpe9viZLTwcdjTuhgtBk0Jbqp+7SqJf7tjLpK8UvhZARdfFRa
 SN6ga/NjFdORfHZ5C6tzmLBRTql/V6YW7+MlgsKy3KvYxFFcI9zug0CUaA+h4slog9/U
 aaF3jqRXYo+TzSYvGc/Vq9JSDDw1gqKVog2Pb5QlMld9IBdLQDYSD9UgcDfNe9oCcnST
 r1Tw==
X-Gm-Message-State: AFq9FYKL4MGdhltalm1hka7HHI8rUf6S3DILTVMepL/j9OvrzdyjW0xI
 MArKCb4Fp3u6YtPIg5z5LSTxxWwfdLISzvyxNadJWMPActv5IOgU5XH9PyLJir9w2FZ7FdvZLJO
 AchMT9TZ0dWNF3XYpXc0lHiiM+o4K55iVyLE0kyWdzLNfejSiosRuULwMFAMyhkFDCg==
X-Gm-Gg: AYBFou16PT3jROGfBvwUQpdGREN6D676NSWjqcCXd1O4RJ+96d6LXdSG6Bh75vKxWip
 DUxaPXxYn51tawtEoZPi9iL0ZtgCdBWDVM6X++PhWsiIjM7hbbAwVPavwH3xU1ILzPucGNRgM2W
 hAsprYdFSYCtbjh6/AYlaZaxaNy/b5DxLiNmoaPzjVIxz83e1h3bT84egcELAXtMudUzFQT59fZ
 hLIcJ5CQVgAKz2ZzXlPJON3blb7lB0FWX5o24W/WOi6c7w4uPr89ZFyLHntuL7qK9neUg9dr5uq
 zOyhwgZpCD8VIkA9NdDMMGhm2Fy6Sq53iMan3SlJaK902ymZDCtGWgvMwMWzYOx0x8jy2Pld9Ki
 f1Pj43vsj68Na36oQVtttvSHriRvzasUK0pWE6tcGI7z14v3NGN5edIerZImxCNY=
X-Received: by 2002:a17:90b:3b84:b0:3ab:be66:ddc8 with SMTP id
 98e67ed59e1d1-3acef108628mr7704100a91.14.1792444862244; 
 Mon, 19 Oct 2026 14:21:02 -0700 (PDT)
X-Received: by 2002:a17:90b:3b84:b0:3ab:be66:ddc8 with SMTP id
 98e67ed59e1d1-3acef108628mr7704074a91.14.1792444861526; 
 Mon, 19 Oct 2026 14:21:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 00/26] multi-target: prefix helpers with target prefix
Date: Mon, 19 Oct 2026 21:20:19 +0000
Message-ID: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX6tDTCBkJvOSY
 tSIdNWxoUJv+NNQfzMp53x2qJdaz44/GOvVnXO7ha3+s3otM11WQYISgS0tDzSkkxIPaWfmTxkP
 FBx7KOmA7uBmAJnVZ5QyA7xqOJrG9Nq0rEeEqV04+kOMytr06bs4IGy+VQG+vPXsw8fDzeKx0KM
 tmXPxAzu00yJVV2YMQk+1J9HAZ2bD07N3SNnsvHfEIZDWyp0OY3NWbEL3Ef5xrxjLQIov1Ozwns
 qeok5Zr6QilJflSs/2LCBpYaYoxNPrFb7ndXqX7UilZ8MXnx+uBDhS3v3D/4Ts80QsoAyUtB8Ah
 w+bJu+kPhzoYswoggwmGjqZn/GgQNxPDYzXbE1RQdVqse8L22vTItqb9VXfuVtOaD6HQMcH3sZs
 UIWmuXcHB8Hg0iGWFaI4xh5curmg6pwgI4RdoE/60E01KuPSBWZnaEIdd1+AHmVAxEs+e/CBoZf
 CN41vCP3xESMuGDONHw==
X-Authority-Analysis: v=2.4 cv=Ve9ir1p9 c=1 sm=1 tr=0 ts=6ad689bf cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=iL01zeDmBSVNqY76XVcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX9VoIBu6iy5K6
 DjxXnX8Rc5P+ejdEjOsPSlLjJxySVuSp+3OarxrhnO+0zrUrEcqo2Q8Je1aimgrwS8BnbE8r7RF
 oVLhmdf1fnbXwx3/Om9P7NI3MwyHOfY=
X-Proofpoint-ORIG-GUID: JTqyXCLGFeXYiJRJAkkU2_z-woCYCmxS
X-Proofpoint-GUID: JTqyXCLGFeXYiJRJAkkU2_z-woCYCmxS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

When linking multiple targets together, we usually have conflicts with helper
names. So far, it was solved using ad-hoc renaming, but multiple people pointed it
would be better to have a general mechanism for it, so here it is.

A previous series attempted that:
https://lore.kernel.org/qemu-devel/20260930073935.712-1-luoyonggang@gmail.com/,
but it was relying on (binary) symbol renaming, which is not a portable solution.
Instead, this series approaches the problem from source code directly.
It requires more change, but it's cleaner IMHO.

Series follows these steps:

First, we make sure all helpers and definition are using HELPER() macro. A lot
of helpers were already defined this way, we just make sure it's exhaustive.
After that we don't have any 'helper_' left on any target code. This is a big
change touching the whole codebase, but it's a simple mechanical change. As long
as it compiles and links, we know it's correct.

Then, we introduce the prefix for target helpers. For this , we add a new define
(from meson) that applies to all target related code. It could later be used to
prefix other symbols also, that's why it's not named "TCG".

Finally, we cleanup the previous manual helpers prefix that were added in
codebase.

Pierrick Bouvier (26):
  target/alpha: define and call helpers using HELPER macro
  target/arm: define and call helpers using HELPER macro
  target/avr: define and call helpers using HELPER macro
  target/hppa: define and call helpers using HELPER macro
  target/i386: define and call helpers using HELPER macro
  target/loongarch: define and call helpers using HELPER macro
  target/m68k: define and call helpers using HELPER macro
  target/microblaze: define and call helpers using HELPER macro
  target/mips: define and call helpers using HELPER macro
  target/or1k: define and call helpers using HELPER macro
  target/ppc: define and call helpers using HELPER macro
  target/riscv: define and call helpers using HELPER macro
  target/rx: define and call helpers using HELPER macro
  target/s390x: define and call helpers using HELPER macro
  target/sh4: define and call helpers using HELPER macro
  target/sparc: define and call helpers using HELPER macro
  target/tricore: define and call helpers using HELPER macro
  tcg: introduce HELPER_INFO macro
  tcg: prefix helpers with target base architecture
  target/alpha: remove explicit target specific prefix
  target/hexagon: remove explicit target specific prefix
  target/hppa: remove explicit target specific prefix
  target/microblaze: remove explicit target specific prefix
  target/or1k: remove explicit target specific prefix
  target/rx: remove explicit target specific prefix
  target/tricore: remove explicit target specific prefix

 include/exec/helper-gen-common.h        |   7 +
 include/exec/helper-gen.h.inc           |  48 +-
 include/exec/helper-head.h.inc          |   8 +-
 include/exec/helper-info.c.inc          |  16 +-
 include/exec/helper-proto-common.h      |   7 +
 meson.build                             |   2 +
 target/alpha/clk_helper.c               |   2 +-
 target/alpha/fpu_helper.c               |  60 +--
 target/alpha/helper.c                   |   6 +-
 target/alpha/helper.h                   |   2 +-
 target/alpha/int_helper.c               |  38 +-
 target/alpha/sys_helper.c               |  12 +-
 target/alpha/translate.c                |   4 +-
 target/alpha/vax_helper.c               |  42 +-
 target/arm/tcg/helper-a64.c             |   6 +-
 target/arm/tcg/mve_helper.c             |  28 +-
 target/arm/tcg/psci.c                   |   2 +-
 target/arm/tcg/sme_helper.c             |   4 +-
 target/arm/tcg/sve_helper.c             | 141 ++---
 target/arm/tcg/tlb_helper.c             |   2 +-
 target/arm/tcg/vec_helper.c             |  72 +--
 target/arm/tcg/vec_helper64.c           |  64 +--
 target/arm/tcg/vec_internal.h           |   5 +-
 target/avr/helper.c                     |  12 +-
 target/hexagon/gen_tcg.h                |   2 +-
 target/hexagon/gen_tcg_sys.h            |   2 +-
 target/hexagon/helper.h                 |   4 +-
 target/hexagon/op_helper.c              |   4 +-
 target/hexagon/translate.c              |   4 +-
 target/hppa/fpu_helper.c                |   2 +-
 target/hppa/helper.h                    |   6 +-
 target/hppa/op_helper.c                 |   4 +-
 target/hppa/sys_helper.c                |  10 +-
 target/hppa/translate.c                 |   6 +-
 target/i386/ops_sse.h                   | 401 +++++++-------
 target/i386/tcg/bpt_helper.c            |   6 +-
 target/i386/tcg/cc_helper.c             |  14 +-
 target/i386/tcg/excp_helper.c           |   8 +-
 target/i386/tcg/fpu_helper.c            | 182 +++----
 target/i386/tcg/int_helper.c            |  34 +-
 target/i386/tcg/mem_helper.c            |   4 +-
 target/i386/tcg/misc_helper.c           |  16 +-
 target/i386/tcg/mpx_helper.c            |  12 +-
 target/i386/tcg/seg_helper.c            |  32 +-
 target/i386/tcg/system/bpt_helper.c     |   6 +-
 target/i386/tcg/system/misc_helper.c    |  32 +-
 target/i386/tcg/system/seg_helper.c     |   4 +-
 target/i386/tcg/system/smm_helper.c     |  12 +-
 target/i386/tcg/system/svm_helper.c     |  16 +-
 target/i386/tcg/user/seg_helper.c       |   4 +-
 target/loongarch/tcg/csr_helper.c       |  22 +-
 target/loongarch/tcg/fpu_helper.c       | 126 ++---
 target/loongarch/tcg/iocsr_helper.c     |  16 +-
 target/loongarch/tcg/op_helper.c        |  18 +-
 target/loongarch/tcg/tlb_helper.c       |  26 +-
 target/loongarch/tcg/vec_helper.c       |   4 +-
 target/m68k/op_helper.c                 |   2 +-
 target/microblaze/helper.h              |  10 +-
 target/microblaze/op_helper.c           |  46 +-
 target/microblaze/translate.c           |  10 +-
 target/mips/tcg/dsp_helper.c            | 187 +++----
 target/mips/tcg/exception.c             |   8 +-
 target/mips/tcg/fpu_helper.c            | 291 +++++-----
 target/mips/tcg/ldst_helper.c           |  18 +-
 target/mips/tcg/lmmi_helper.c           |  98 ++--
 target/mips/tcg/msa_helper.c            | 690 ++++++++++++------------
 target/mips/tcg/octeon_crypto.c         | 100 ++--
 target/mips/tcg/op_helper.c             |  34 +-
 target/mips/tcg/system/cp0_helper.c     | 276 +++++-----
 target/mips/tcg/system/lcsr_helper.c    |   8 +-
 target/mips/tcg/system/special_helper.c |  12 +-
 target/mips/tcg/system/tlb_helper.c     |  14 +-
 target/mips/tcg/vr54xx_helper.c         |  30 +-
 target/or1k/fpu_helper.c                |  16 +-
 target/or1k/helper.h                    |   2 +-
 target/or1k/interrupt_helper.c          |   2 +-
 target/or1k/translate.c                 |   2 +-
 target/ppc/dfp_helper.c                 |  52 +-
 target/ppc/fpu_helper.c                 | 396 +++++++-------
 target/ppc/int_helper.c                 | 292 +++++-----
 target/ppc/internal.h                   |   7 +-
 target/ppc/mem_helper.c                 |  28 +-
 target/ppc/misc_helper.c                |  56 +-
 target/ppc/mmu-hash64.c                 |  18 +-
 target/ppc/mmu_helper.c                 |  70 +--
 target/ppc/power8-pmu.c                 |  14 +-
 target/ppc/tcg-excp_helper.c            |  56 +-
 target/ppc/timebase_helper.c            |  54 +-
 target/ppc/translate/vsx-impl.c.inc     |   2 +-
 target/riscv/tcg/debug.c                |   2 +-
 target/riscv/tcg/fpu_helper.c           | 196 +++----
 target/riscv/tcg/op_helper.c            |  74 +--
 target/rx/helper.h                      |  12 +-
 target/rx/op_helper.c                   |  62 +--
 target/rx/translate.c                   |  14 +-
 target/s390x/tcg/mem_helper.c           |   2 +-
 target/sh4/op_helper.c                  |  76 +--
 target/sparc/fop_helper.c               | 106 ++--
 target/sparc/helper.c                   |  22 +-
 target/sparc/int64_helper.c             |   6 +-
 target/sparc/ldst_helper.c              |  14 +-
 target/sparc/vis_helper.c               |  94 ++--
 target/sparc/win_helper.c               |  38 +-
 target/tricore/fpu_helper.c             |  32 +-
 target/tricore/helper.h                 |  14 +-
 target/tricore/op_helper.c              | 220 ++++----
 target/tricore/translate.c              |  14 +-
 107 files changed, 2789 insertions(+), 2739 deletions(-)

-- 
2.43.0


