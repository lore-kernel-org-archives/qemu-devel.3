Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02482F8A164
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL45-00056R-UN; Thu, 16 Apr 2026 07:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL44-00055r-4Y
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL3x-00039U-VH
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G9b2IB1553884
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=CBQuMkYFgYbkKlJsrAaBH93R22pERtrdpGj
 w4pa1muQ=; b=HBEIFCAyoZKLglAYnVO0fHTYMT60kKmD6dH6SwbJbWEVgEozXvG
 +fgaJlqQtBTzZyE3Io5Rp2UpuR19sG4aHRNChLq0gQWC4EQrPFrk24sjb+D6G9tY
 Q8ZJJFmER37px8DkRSp3XS4BHyWjHDtYWnE15uAFczZejqUOd9XNUisaBAwRE1h0
 nj30O+uGtpyDDMXBRH3nLZ9NuolKBy+j70DPN0NPRyNbxfZzM0u3pMsPh0K0cXUo
 r9QhLly2OpyvOwfj851VxD1eiBFIiUPvCtbAu8CmMzimCfXzkDw0XfJskXKvzaxc
 K2tMfDxDmvyDKXpAq5F4cDC9vQORFR7ZE3A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djrsn9g88-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so10020908eec.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339549; x=1776944349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CBQuMkYFgYbkKlJsrAaBH93R22pERtrdpGjw4pa1muQ=;
 b=g65BhqDtL0K+pXxi+6SJBLQm72Xd3UkbLrt9wCK7i1tzAe83EaQ2pzfSxHS/Hq4fup
 Mc5/J43Bf3DI4m/I613PH1P5r0OjOtCa6oA/JTNzJsL6ai23HDy/3+vcZyiW01L/SZ6l
 vmXdBW1A45yyngbwSCZ4TNUsKm6k1WIj8/2lhAQztY32tiUGZvqtxP8MknCzXRZaYDCo
 9lv3d2Sut0ZmT/SVBsgDotXrJRkpt649P2wLTXLaQb4wQxfEAcTcyMtRqoFpMxuu3Cj5
 H5+Rk3ZaJbP7K/Z+/TCjD8d8A1xeR2XUDLfZGr2Yyyb8AgRuJrttnPnRpcW7RTMYaPJa
 RNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339549; x=1776944349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBQuMkYFgYbkKlJsrAaBH93R22pERtrdpGjw4pa1muQ=;
 b=Gjzev30TAJWebwytLDwdcPzK70Gbvcc0LJbt2kSdEXxVBnff4bkUFgt5V6O1bqaLgC
 uphF7QPiECZG9zRj0MC+NoyQnMXAHKrv9FI6EaRT2CJlIvzgpz+ezKtoqONFYc+nSnvz
 cXWVN8SLvZBw6ddmpfyj7OIQxWsfEl5sEByqaLXxHZvI6obZF+uRmpnmTlQY0abeah0k
 8WeqHx5adjPGnUN10QBoGCe+lqYUuF3pg6mPxa6YdMCPzO3N3R9T72z+X0kiuklYcvaO
 xDmTvJZC1qtG4mCxDPI4jR6OGl2UKn6NIONbxShP93OPmBUgci0q0dIt84tSaxrh7/1a
 xtkw==
X-Gm-Message-State: AOJu0YzpOOJMuY0jmnDHrlKk2zrNNq+39LtdJJsr4mVpk9YEuegqwvMS
 82cedX/5kIwLR9rZ+YrtTMOYyh+VJU8q0kfgMKCDo3WEhpeUttEWl4C0pvS7wjUyGZxkj1ykYM4
 D1XRuMCS/EMrvcXyF/+LsYmd7pzSRCvTtMflrR6vr6Z4F69+tXVrGhp9b+iXwkfGq9yc6
X-Gm-Gg: AeBDieu+WAdx0q70j4/1U6OYGMgXsHbWObtgcEq0IDuueib+aC+TEBV3fq1F0aH9xJm
 MbPA1UVbMjncgraVRZQIeu6JHC6lLONj2RJ5VCpqgGS2QPsU23sOH3OaoNzSLsiUcX2yGYhv2cX
 Y+JsqT1Mfr+sfWj6WMS6NChI2MFLO1umIqTOdx9WWo6XqK7+xMmFWhAA+qZ3Jz66HYWBsIsbKQo
 ZtnD3vJNCmegbrKZpXwRseZkkGcIF3ZHAihCPMLNd8mDoaIVWh/bagHf+hKRkd5MWSFlFHvWLqZ
 1NqI6jWXcIR3BInrhLvlP5lPqR3OMevf946sG1E7oB3XD0mI+ULj4t6sj9PLqt1XJYoYNsCfsUi
 8CJEpaVUsWzei0uvKTkUSENPsSqkuqWhqhjPCAVrzOvBg72xPZYH4+FmQ2BikqPNZwIvs7wYgp9
 FiiEoSNbzhxlxAMy6tS7E=
X-Received: by 2002:a05:7300:1486:b0:2de:cc07:e8b with SMTP id
 5a478bee46e88-2decc071235mr3406099eec.1.1776339549191; 
 Thu, 16 Apr 2026 04:39:09 -0700 (PDT)
X-Received: by 2002:a05:7300:1486:b0:2de:cc07:e8b with SMTP id
 5a478bee46e88-2decc071235mr3406062eec.1.1776339548485; 
 Thu, 16 Apr 2026 04:39:08 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:07 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v5 00/16] hexagon: add missing HVX float instructions
Date: Thu, 16 Apr 2026 04:38:49 -0700
Message-Id: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: byxMBAEBWJC-7S2Ybdk8qezbtlViPuyX
X-Proofpoint-GUID: byxMBAEBWJC-7S2Ybdk8qezbtlViPuyX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfXxP5z+r5cTe/5
 oBVyudUfPIyCjY0N45vhto1jH0wpkDiUo7PNuhIsPGsChefnya6bHOZyTlDSrCOh7r6xCqjs07M
 mLyi69T20Z9g/abIr8cO4DbOk841KI0LUz9kYeSjm1t6WUHaAjTLgWzUOq8NietHia6MKA9BYez
 7Q7g2shRJsOasYkICzWR3EKIXgBWkkKTYRn9Q6Uihi/IaDGLnDjry79iZ/UGE7F14EQ+0++k0oU
 +crgBEcJPS+aQHQSYxiSQ9Pe1REnW5lTdKoE61C+yWRBPj7hkbRfKI7jNhAqNr0bDsDM1k+5poa
 v8vrs6k6TnSHiV4+VlUS0mUgMWTxV9VT605KPBi+meG+Vp43h4tq2Q3dnWoNBN09gctMq/vA0la
 +X+PMVv2aIdI1qX26PipI4WrrtLkJqf4xaEEN7GcGXZFvrM1TvRfGusXqFo2GZ7yHwgxP3NGiTT
 I7cXVbLsoFSwkVStc/Q==
X-Authority-Analysis: v=2.4 cv=EojiaycA c=1 sm=1 tr=0 ts=69e0ca5e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=mnG_I7bxJU9Y1e3E8IoA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160110
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This patchset adds 59 HVX floating point instructions from Hexagon
revisions v68 and v73 that were missing in qemu. Tests are also added at
the end.

v4: https://lore.kernel.org/qemu-devel/cover.1775843299.git.matheus.bernardino@oss.qualcomm.com/
v3: https://lore.kernel.org/qemu-devel/cover.1775665981.git.matheus.bernardino@oss.qualcomm.com/
v2: https://lore.kernel.org/qemu-devel/cover.1775122853.git.matheus.bernardino@oss.qualcomm.com/
v1: https://lore.kernel.org/qemu-devel/cover.1774271525.git.matheus.bernardino@oss.qualcomm.com/

Changes in v5:
	- patch 11: fixed copy-and-paste error (s/vmax/vmin)
	- patch 16: replaced float16 value for BF_* constants for
	  clearity


Brian Cain (1):
  tests/docker: Update hexagon cross toolchain to 22.1.0

Matheus Tavares Bernardino (15):
  target/hexagon: fix incorrect/too-permissive HVX encodings
  target/hexagon/cpu: add HVX IEEE FP extension
  hexagon: group cpu configurations in their own struct
  hexagon: print info on "-d in_asm" for disabled IEEE FP instructions
  target/hexagon: add v68 HVX IEEE float arithmetic insns
  target/hexagon: add v68 HVX IEEE float min/max insns
  target/hexagon: add v68 HVX IEEE float misc insns
  target/hexagon: add v68 HVX IEEE float conversion insns
  target/hexagon: add v68 HVX IEEE float compare insns
  target/hexagon: add v73 HVX IEEE bfloat16 insns
  tests/hexagon: add tests for v68 HVX IEEE float arithmetics
  tests/hexagon: add tests for v68 HVX IEEE float min/max
  tests/hexagon: add tests for v68 HVX IEEE float conversions
  tests/hexagon: add tests for v68 HVX IEEE float comparisons
  tests/hexagon: add tests for HVX bfloat

 target/hexagon/cpu.h                          |  10 +-
 target/hexagon/cpu_bits.h                     |  10 +-
 target/hexagon/mmvec/hvx_ieee_fp.h            |  69 ++++
 target/hexagon/mmvec/macros.h                 |   8 +
 target/hexagon/mmvec/mmvec.h                  |   3 +
 target/hexagon/printinsn.h                    |   2 +-
 target/hexagon/translate.h                    |   1 +
 tests/tcg/hexagon/hex_test.h                  |  32 ++
 tests/tcg/hexagon/hvx_misc.h                  |  73 ++++
 target/hexagon/attribs_def.h.inc              |   9 +
 disas/hexagon.c                               |   3 +-
 target/hexagon/arch.c                         |   8 +
 target/hexagon/cpu.c                          |  18 +-
 target/hexagon/decode.c                       |   4 +-
 target/hexagon/mmvec/hvx_ieee_fp.c            | 137 +++++++
 target/hexagon/printinsn.c                    |   7 +-
 target/hexagon/translate.c                    |   5 +-
 tests/tcg/hexagon/fp_hvx.c                    | 226 +++++++++++
 tests/tcg/hexagon/fp_hvx_cmp.c                | 275 +++++++++++++
 tests/tcg/hexagon/fp_hvx_cvt.c                | 219 +++++++++++
 tests/tcg/hexagon/fp_hvx_disabled.c           |  57 +++
 target/hexagon/gen_tcg_funcs.py               |  11 +
 target/hexagon/hex_common.py                  |  27 ++
 target/hexagon/imported/mmvec/encode_ext.def  | 126 ++++--
 target/hexagon/imported/mmvec/ext.idef        | 369 +++++++++++++++++-
 target/hexagon/meson.build                    |   1 +
 .../dockerfiles/debian-hexagon-cross.docker   |  10 +-
 tests/tcg/hexagon/Makefile.target             |  14 +
 28 files changed, 1686 insertions(+), 48 deletions(-)
 create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.h
 create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.c
 create mode 100644 tests/tcg/hexagon/fp_hvx.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_cmp.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_cvt.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_disabled.c

Range-diff against v4:
 1:  1440dd86da =  1:  e94d57178d tests/docker: Update hexagon cross toolchain to 22.1.0
 2:  b9a5a46b82 =  2:  1fe4b8a0fc target/hexagon: fix incorrect/too-permissive HVX encodings
 3:  7889db953a =  3:  10fb5b86db target/hexagon/cpu: add HVX IEEE FP extension
 4:  ac72a36fd8 =  4:  8f9a2e2ccf hexagon: group cpu configurations in their own struct
 5:  e24b76d95a =  5:  1bdc772e4a hexagon: print info on "-d in_asm" for disabled IEEE FP instructions
 6:  8c9ded658c =  6:  8923b6c6bc target/hexagon: add v68 HVX IEEE float arithmetic insns
 7:  a89b231b2c =  7:  8e274a7a10 target/hexagon: add v68 HVX IEEE float min/max insns
 8:  27a5ca1ce3 =  8:  0bd3279ca0 target/hexagon: add v68 HVX IEEE float misc insns
 9:  7fecae322c =  9:  beca620d2e target/hexagon: add v68 HVX IEEE float conversion insns
10:  ebc920dfcf = 10:  96e27588ad target/hexagon: add v68 HVX IEEE float compare insns
11:  d408ee2b2c ! 11:  1a25337356 target/hexagon: add v73 HVX IEEE bfloat16 insns
    @@ target/hexagon/imported/mmvec/ext.idef: ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_h
     +    "Vector IEEE max: bf", VdV.bf[i] = fp_max_bf(VuV.bf[i], VvV.bf[i]);
     +    fBFLOAT())
     +ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vmin_bf, "Vd32.bf=vmin(Vu32.bf,Vv32.bf)",
    -+    "Vector IEEE max: bf", VdV.bf[i] = fp_min_bf(VuV.bf[i], VvV.bf[i]);
    ++    "Vector IEEE min: bf", VdV.bf[i] = fp_min_bf(VuV.bf[i], VvV.bf[i]);
     +    fBFLOAT())
      
      /******************************************************************************
12:  cde613d444 = 12:  791f122bfd tests/hexagon: add tests for v68 HVX IEEE float arithmetics
13:  08abae5ee5 = 13:  7fdbc12ed4 tests/hexagon: add tests for v68 HVX IEEE float min/max
14:  c20a21aad6 = 14:  ec6af07a28 tests/hexagon: add tests for v68 HVX IEEE float conversions
15:  6b473acaf5 = 15:  53e7370709 tests/hexagon: add tests for v68 HVX IEEE float comparisons
16:  10ebb63b81 ! 16:  392114c4c1 tests/hexagon: add tests for HVX bfloat
    @@ tests/tcg/hexagon/fp_hvx_cmp.c: static void test_cmp_hf(void)
     +
     +    /* Common numbers */
     +    PREP_TEST();
    -+    TEST_CMP_GT(bf, raw_hf((_Float16)2.2),  raw_hf((_Float16)2.1));
    -+    TEST_CMP_GT(bf, raw_hf((_Float16)0),    raw_hf((_Float16)-2.2));
    ++    TEST_CMP_GT(bf, BF_two, BF_one);
    ++    TEST_CMP_GT(bf, BF_one, BF_zero);
     +    CHECK(bf, 2);
     +
     +    /* Infinity vs Infinity/NaN */
-- 
2.37.2


