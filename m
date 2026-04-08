Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3AF10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYRq-00014y-VN; Wed, 08 Apr 2026 15:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAY2p-0005kg-QZ
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:54:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVu0-0006ny-0Y
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:21 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638G3MTP3781421
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=3VzeBgpaH6iR9nn1SS/Rv553/Y0HKEZ86RA
 EeJzNqJA=; b=fyPHnabp6p4RhkxpvUiBvkY1k4kLDzPi21O3MUEvgk3zgzPMTC+
 dPMeNePth4iCXsV7U94KM3+QOuQOnpQc8l73E2/7Voh59cTQS3f3EyAir+JVOKwd
 zH3KDMcrcRIVVozjElupEknR3/f95GZT3tpMg4vssRF0zrlDvoSVgivLhX4Al5Hu
 OfHxxo0F1iuLiTFdeO2DQOrcD5Ro0X6hT08EaADMnLOybzAX9vZqvoIpk3Z0vFen
 kzemeHV1dTJf4uIG3A/l3tDCOKZdkWhLhFtYgoawLz5TMoHApnmPZKboT26S1t0r
 TgqNvqOk4DDpHbngF2Kfezq1329XfgV6i4w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddt6y84bd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:12 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c76b69fb9d6so762877a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666232; x=1776271032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3VzeBgpaH6iR9nn1SS/Rv553/Y0HKEZ86RAEeJzNqJA=;
 b=PTRnhCBPaaJ79Wp6Uv9dwHih0Ss6xaDFiZsTFszPNVstv6b0kdmSEX9ebX5uxwkWyM
 jS1P+PEscMYZ7uoqxE2ZDHMYJ2zgistMOzeT30SfEUf1MlmoOM0/ecfjNLgdOLIEkYmx
 BpVGJ37jBcTEpAY91MXG8eqNNPnw4BQjW4d+JItdPGTgkESSPFQZjZ61xZLWfbKGuGqB
 g0zGdzPHe8FbudQEFapUBsyNAF+lTCgkBwmujKLRdyJfiSt/o6abBBEszt5ZDtm2zyy+
 AQ7lkuz+M6NFD9hSanrb2XwJzffnIBr3zkdvT6MDAMaY6PoqcfFeHlkrxoMfxyPUDGLL
 9JqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666232; x=1776271032;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VzeBgpaH6iR9nn1SS/Rv553/Y0HKEZ86RAEeJzNqJA=;
 b=U/82p4v5e14L89FeI4nkBuQ1DvlTivIsSO8j3UA25MIvI0GnvWwNwXOStdKB9IRBMV
 OxdzGCUZ50Xj9dgFN2OukJvjsBmbjjsPv/sfRDwieMWcDD/bEj2zzbn8gETz9sDbPRvp
 1Wm1jy4umZgF1uBVhFfU9YEA1BBLjppLBilFJ/CS2e9mFfC2mt1Ufr/J3/WkWIgLx2bU
 lmv5Zy8sZ/2rxrdRqfOka8uoXBh87yk0wc+///FJAmRzgqtioa46FKwuWBr9CcoklvrA
 5V8AhP1miJpOX1uanbzjvE4shthCol9mX4kTu77f7Wypkv0w7ktW74cR7JRwl7lL+Uh5
 6sZA==
X-Gm-Message-State: AOJu0YymfXwJbkmTr1HmCzzt7YTpBpyc4fX2BOBfYmUaampANOyJm0aH
 gjaeDat8i2yp87xhgsRJgq8K0oo/UUDb4uWyJRJOMURyXproEFR/h7cfwoN5tIrLFFuP9VPK3ph
 ByS8VQZKeWKZD9vGT4AaiMy/HPqKrmnf3yojbE1pBLZx9CSZHI94N1O++JJl6Gqj2pJGK
X-Gm-Gg: AeBDieviioWgiZK1xyyNyVvYAQ/hU6XvZd7adPL4Ponb3sE480jdkfRHRwYRqnOmcEa
 qKexFj2HzGUfeMH9qaZk7lSF3Jtg7PtdpWAtpV+BPFbGeVzxQQTJp0INn9mthHw+rQxIgxX6M25
 RXkUOFH3p8VsiLz49lAJW5f12JI5f6j3rVGzI+4jGgpo5ORYdUQu7QdV1xf3AGZv3dfToH0kJxR
 RYv9WRsD0BgZudEIuVyS6FZT9AfcBpJLywNnWodd3xi244AHZWROBFkPGwicKT+QOE8V+hdjfz3
 aKTRqcguMJ5oopLbLGZ8Z6zj1C6fYk8Qfhi+BhZj3VJNTVtWqxWXJ/vJwrRuc1YK58cmUZdXCGn
 6yhK6etiihezcsj/IR/I/+UbqK4aeElEmf7aENve3LejQT2Z7YzwBmDhBsexVNNP7KyCzap51DO
 jWsFXNkrIJ
X-Received: by 2002:a05:7022:62a7:b0:12a:6b26:8618 with SMTP id
 a92af1059eb24-12c28bfb94bmr63302c88.2.1775666230821; 
 Wed, 08 Apr 2026 09:37:10 -0700 (PDT)
X-Received: by 2002:a05:7022:62a7:b0:12a:6b26:8618 with SMTP id
 a92af1059eb24-12c28bfb94bmr63271c88.2.1775666229614; 
 Wed, 08 Apr 2026 09:37:09 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:09 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 00/16] hexagon: add missing HVX float instructions
Date: Wed,  8 Apr 2026 09:36:51 -0700
Message-Id: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kzh4xrU9oKNlydL7ub_8M8sZD8Vi7vrR
X-Proofpoint-GUID: kzh4xrU9oKNlydL7ub_8M8sZD8Vi7vrR
X-Authority-Analysis: v=2.4 cv=R9sz39RX c=1 sm=1 tr=0 ts=69d68438 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1Lf7G5IleHaA_IkOK-gA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfX4GsOdWEOIxtE
 iJdcC7lW8KAlxxh8hlcQ4Iw2c1kPyZMLyaF4apbqTssfrEk4bPwp7XfZqgCOB7IUXccTZEmj58S
 Mk12Ckyf97j4vEmgYtAshFK9Ufzj1E06hU+gYtrJcsBLdQpoMxaElhmPiQz6bn6ZEHsSdQrzUuF
 64Tdf+Yw0bCUyvWxdjTm7eKC+o1PfDo8FZnE7QBkVf/T+lnzDrQSGWMPI+ZHDr84/TeCny7vrcG
 GL+bpou+cOoau5u5OX3HNCjyH2SDTIEf1RkZ6lX8m9XOwDoZkKoHDW12b9V3/Zx8H+nwIILMQIQ
 nu/hBEGA10rVedXTRi9gzK87gL9NiMfNxdK++hqC0PwsLp8OgYufqOkyxmIG5Nctwls+s7oj79S
 Ca+cKN/cC+w5zF46y3Iwujk20oOk5Ixb7IvpWJbLh/S8jbj3DnUqbeSOg177edBtQ+GRSA8uZKK
 zYm4ZXsI51JszhJ9kPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080154
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

v2: https://lore.kernel.org/qemu-devel/cover.1775122853.git.matheus.bernardino@oss.qualcomm.com/
v1: https://lore.kernel.org/qemu-devel/cover.1774271525.git.matheus.bernardino@oss.qualcomm.com/

Changes in v3:
- replaced uint32_t/uint16_t in MMVector with float32/float16, making it
  clearer and greatly reducing the code size.
- Many functions were inlined (now that we don't have to use make_float,
  the functions were mostly one-liners).

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
 target/hexagon/mmvec/hvx_ieee_fp.c            | 136 +++++++
 target/hexagon/printinsn.c                    |   7 +-
 target/hexagon/translate.c                    |   5 +-
 tests/tcg/hexagon/fp_hvx.c                    | 226 +++++++++++
 tests/tcg/hexagon/fp_hvx_cmp.c                | 279 +++++++++++++
 tests/tcg/hexagon/fp_hvx_cvt.c                | 219 +++++++++++
 tests/tcg/hexagon/fp_hvx_disabled.c           |  57 +++
 target/hexagon/gen_tcg_funcs.py               |  11 +
 target/hexagon/hex_common.py                  |  37 ++
 target/hexagon/imported/mmvec/encode_ext.def  | 126 ++++--
 target/hexagon/imported/mmvec/ext.idef        | 369 +++++++++++++++++-
 target/hexagon/meson.build                    |   1 +
 .../dockerfiles/debian-hexagon-cross.docker   |  10 +-
 tests/tcg/hexagon/Makefile.target             |  14 +
 28 files changed, 1699 insertions(+), 48 deletions(-)
 create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.h
 create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.c
 create mode 100644 tests/tcg/hexagon/fp_hvx.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_cmp.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_cvt.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_disabled.c

Range-diff against v2:
 -:  ---------- >  1:  a04c3c5feb tests/docker: Update hexagon cross toolchain to 22.1.0
 -:  ---------- >  2:  c63e568f6c target/hexagon: fix incorrect/too-permissive HVX encodings
 -:  ---------- >  3:  bd05d9aa88 target/hexagon/cpu: add HVX IEEE FP extension
 -:  ---------- >  4:  d7cc954b23 hexagon: group cpu configurations in their own struct
 -:  ---------- >  5:  192fd1ca5c hexagon: print info on "-d in_asm" for disabled IEEE FP instructions
 1:  fd24bfcb36 !  6:  42b4b2d1c6 target/hexagon: add v68 HVX IEEE float arithmetic insns
    @@ target/hexagon/mmvec/hvx_ieee_fp.h (new)
     +
     +#include "fpu/softfloat.h"
     +
    -+/* Hexagon canonical NaN */
    -+#define FP32_DEF_NAN      0x7FFFFFFF
    -+#define FP16_DEF_NAN      0x7FFF
    ++#define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status)
     +
    -+/*
    -+ * IEEE - FP ADD/SUB/MPY instructions
    -+ */
    -+uint32_t fp_mult_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
    -+uint32_t fp_add_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
    -+uint32_t fp_sub_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
    -+
    -+uint16_t fp_mult_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    -+uint16_t fp_add_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    -+uint16_t fp_sub_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    -+
    -+uint32_t fp_mult_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    -+uint32_t fp_add_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    -+uint32_t fp_sub_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    -+
    -+/*
    -+ * IEEE - FP Accumulate instructions
    -+ */
    -+uint16_t fp_mult_hf_hf_acc(uint16_t a1, uint16_t a2, uint16_t acc,
    -+                           float_status *fp_status);
    -+uint32_t fp_mult_sf_hf_acc(uint16_t a1, uint16_t a2, uint32_t acc,
    -+                           float_status *fp_status);
    -+
    -+/*
    -+ * IEEE - FP Reduce instructions
    -+ */
    -+uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t a4,
    -+                  float_status *fp_status);
    -+uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uint16_t a3,
    -+                      uint16_t a4, float_status *fp_status);
    ++float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
    ++float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
    ++                 float_status *fp_status);
     +
     +#endif
     
    @@ target/hexagon/mmvec/mmvec.h: typedef union {
          int16_t   h[MAX_VEC_SIZE_BYTES / 2];
          uint8_t  ub[MAX_VEC_SIZE_BYTES / 1];
          int8_t    b[MAX_VEC_SIZE_BYTES / 1];
    -+    int32_t  sf[MAX_VEC_SIZE_BYTES / 4];   /* single float (32-bit) */
    -+    int16_t  hf[MAX_VEC_SIZE_BYTES / 2];   /* half float (16-bit) */
    ++    float32  sf[MAX_VEC_SIZE_BYTES / 4];
    ++    float16  hf[MAX_VEC_SIZE_BYTES / 2];
      } MMVector;
      
      typedef union {
    @@ target/hexagon/mmvec/hvx_ieee_fp.c (new)
     +#include "qemu/osdep.h"
     +#include "hvx_ieee_fp.h"
     +
    -+#define DEF_FP_INSN_2(name, rt, a1t, a2t, op) \
    -+    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
    -+                           float_status *fp_status) { \
    -+        float##a1t f1 = make_float##a1t(a1); \
    -+        float##a2t f2 = make_float##a2t(a2); \
    -+        return (op); \
    -+    }
    -+
    -+#define DEF_FP_INSN_3(name, rt, a1t, a2t, a3t, op) \
    -+    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
    -+                           uint##a3t##_t a3, float_status *fp_status) { \
    -+        float##a1t f1 = make_float##a1t(a1); \
    -+        float##a2t f2 = make_float##a2t(a2); \
    -+        float##a3t f3 = make_float##a3t(a3); \
    -+        return (op); \
    -+    }
    -+
    -+DEF_FP_INSN_2(mult_sf_sf, 32, 32, 32, float32_mul(f1, f2, fp_status))
    -+DEF_FP_INSN_2(add_sf_sf, 32, 32, 32, float32_add(f1, f2, fp_status))
    -+DEF_FP_INSN_2(sub_sf_sf, 32, 32, 32, float32_sub(f1, f2, fp_status))
    -+
    -+DEF_FP_INSN_2(mult_hf_hf, 16, 16, 16, float16_mul(f1, f2, fp_status))
    -+DEF_FP_INSN_2(add_hf_hf, 16, 16, 16, float16_add(f1, f2, fp_status))
    -+DEF_FP_INSN_2(sub_hf_hf, 16, 16, 16, float16_sub(f1, f2, fp_status))
    -+
    -+DEF_FP_INSN_2(mult_sf_hf, 32, 16, 16,
    -+              float32_mul(float16_to_float32(f1, true, fp_status),
    -+                          float16_to_float32(f2, true, fp_status),
    -+                          fp_status))
    -+DEF_FP_INSN_2(add_sf_hf, 32, 16, 16,
    -+              float32_add(float16_to_float32(f1, true, fp_status),
    -+                          float16_to_float32(f2, true, fp_status),
    -+                          fp_status))
    -+DEF_FP_INSN_2(sub_sf_hf, 32, 16, 16,
    -+              float32_sub(float16_to_float32(f1, true, fp_status),
    -+                          float16_to_float32(f2, true, fp_status),
    -+                          fp_status))
    -+
    -+DEF_FP_INSN_3(mult_hf_hf_acc, 16, 16, 16, 16,
    -+              float16_muladd(f1, f2, f3, 0, fp_status))
    -+DEF_FP_INSN_3(mult_sf_hf_acc, 32, 16, 16, 32,
    -+              float32_muladd(float16_to_float32(f1, true, fp_status),
    -+                             float16_to_float32(f2, true, fp_status),
    -+                             f3, 0, fp_status))
    -+
    -+uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t a4,
    -+                 float_status *fp_status)
    ++float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status)
     +{
    -+    float32 prod1 = fp_mult_sf_hf(a1, a3, fp_status);
    -+    float32 prod2 = fp_mult_sf_hf(a2, a4, fp_status);
    -+    return fp_add_sf_sf(float32_val(prod1), float32_val(prod2), fp_status);
    ++    return float32_mul(float16_to_float32(a1, true, fp_status),
    ++                       float16_to_float32(a2, true, fp_status), fp_status);
     +}
     +
    -+uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2,
    -+                      uint16_t a3, uint16_t a4,
    -+                      float_status *fp_status)
    ++float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
    ++                 float_status *fp_status)
     +{
    -+    float32 red = fp_vdmpy(a1, a2, a3, a4, fp_status);
    -+    return fp_add_sf_sf(float32_val(red), acc, fp_status);
    ++    return float32_add(fp_mult_sf_hf(a1, a3, fp_status),
    ++                       fp_mult_sf_hf(a2, a4, fp_status), fp_status);
     +}
     
      ## target/hexagon/hex_common.py ##
    @@ target/hexagon/imported/mmvec/ext.idef: EXTINSN(V6_vprefixqw,"Vd32.w=prefixsum(Q
     +/* IEEE FP multiply instructions */
     +ITERATOR_INSN_IEEE_FP_DOUBLE_SINGLE_32(32, vmpy_sf_sf,
     +    "Vd32.sf=vmpy(Vu32.sf,Vv32.sf)", "Vector IEEE mul: sf",
    -+    VdV.sf[i] = fp_mult_sf_sf(VuV.sf[i], VvV.sf[i], &env->hvx_fp_status))
    ++    VdV.sf[i] = float32_mul(VuV.sf[i], VvV.sf[i], &env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_hf,
     +    "Vdd32.sf=vmpy(Vu32.hf,Vv32.hf)", "Vector IEEE mul: hf widen to sf",
     +    VddV.v[0].sf[i] = fp_mult_sf_hf(VuV.hf[2*i], VvV.hf[2*i], &env->hvx_fp_status);
     +    VddV.v[1].sf[i] = fp_mult_sf_hf(VuV.hf[2*i+1], VvV.hf[2*i+1], &env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_16(16, vmpy_hf_hf,     "Vd32.hf=vmpy(Vu32.hf,Vv32.hf)",
     +    "Vector IEEE mul: hf",
    -+    VdV.hf[i] = fp_mult_hf_hf(VuV.hf[i], VvV.hf[i], &env->hvx_fp_status))
    ++    VdV.hf[i] = float16_mul(VuV.hf[i], VvV.hf[i], &env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_32(32, vdmpy_sf_hf,     "Vd32.sf=vdmpy(Vu32.hf,Vv32.hf)",
     +    "Vector IEEE mul reduction: hf widen to sf",
     +    VdV.sf[i] = fp_vdmpy(VuV.hf[2*i+1], VuV.hf[2*i], VvV.hf[2*i+1],
    @@ target/hexagon/imported/mmvec/ext.idef: EXTINSN(V6_vprefixqw,"Vd32.w=prefixsum(Q
     +/* IEEE FP multiply-accumulate instructions */
     +ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_hf_acc,
     +    "Vxx32.sf+=vmpy(Vu32.hf,Vv32.hf)", "Vector IEEE fma: hf widen to sf",
    -+    VxxV.v[0].sf[i] = fp_mult_sf_hf_acc(VuV.hf[2*i], VvV.hf[2*i],
    -+        VxxV.v[0].sf[i], &env->hvx_fp_status);
    -+    VxxV.v[1].sf[i] = fp_mult_sf_hf_acc(VuV.hf[2*i+1], VvV.hf[2*i+1],
    -+        VxxV.v[1].sf[i], &env->hvx_fp_status))
    ++    VxxV.v[0].sf[i] = float32_muladd(f16_to_f32(VuV.hf[2*i]),
    ++                                     f16_to_f32(VvV.hf[2*i]),
    ++                                     VxxV.v[0].sf[i], 0, &env->hvx_fp_status);
    ++    VxxV.v[1].sf[i] = float32_muladd(f16_to_f32(VuV.hf[2*i+1]),
    ++                                     f16_to_f32(VvV.hf[2*i+1]),
    ++                                     VxxV.v[1].sf[i], 0, &env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_ACC_16(16, vmpy_hf_hf_acc,
     +    "Vx32.hf+=vmpy(Vu32.hf,Vv32.hf)", "Vector IEEE fma: hf",
    -+    VxV.hf[i] = fp_mult_hf_hf_acc(VuV.hf[i], VvV.hf[i], VxV.hf[i], &env->hvx_fp_status))
    ++    VxV.hf[i] = float16_muladd(VuV.hf[i], VvV.hf[i], VxV.hf[i], 0, &env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_ACC_32(32, vdmpy_sf_hf_acc,
     +    "Vx32.sf+=vdmpy(Vu32.hf,Vv32.hf)", "Vector IEEE fma reduce: hf widen to sf",
    -+    VxV.sf[i] = fp_vdmpy_acc(VxV.sf[i], VuV.hf[2*i+1], VuV.hf[2*i], VvV.hf[2*i+1],
    -+        VvV.hf[2*i], &env->hvx_fp_status))
    ++    VxV.sf[i] = float32_add(fp_vdmpy(VuV.hf[2*i+1], VuV.hf[2*i],
    ++                                     VvV.hf[2*i+1], VvV.hf[2*i],
    ++                                     &env->hvx_fp_status),
    ++                            VxV.sf[i], &env->hvx_fp_status))
     +
     +/* IEEE FP add/sub instructions */
     +ITERATOR_INSN_IEEE_FP_32(32, vadd_sf_sf, "Vd32.sf=vadd(Vu32.sf,Vv32.sf)",
     +    "Vector IEEE add: sf",
    -+    VdV.sf[i] = fp_add_sf_sf(VuV.sf[i], VvV.sf[i], &env->hvx_fp_status))
    ++    VdV.sf[i] = float32_add(VuV.sf[i], VvV.sf[i], &env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_32(32, vsub_sf_sf, "Vd32.sf=vsub(Vu32.sf,Vv32.sf)",
     +    "Vector IEEE sub: sf",
    -+    VdV.sf[i] = fp_sub_sf_sf(VuV.sf[i], VvV.sf[i], &env->hvx_fp_status))
    ++    VdV.sf[i] = float32_sub(VuV.sf[i], VvV.sf[i], &env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_16(16, vadd_hf_hf, "Vd32.hf=vadd(Vu32.hf,Vv32.hf)",
     +    "Vector IEEE add: hf",
    -+    VdV.hf[i] = fp_add_hf_hf(VuV.hf[i], VvV.hf[i], &env->hvx_fp_status))
    ++    VdV.hf[i] = float16_add(VuV.hf[i], VvV.hf[i], &env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_16(16, vsub_hf_hf, "Vd32.hf=vsub(Vu32.hf,Vv32.hf)",
     +    "Vector IEEE sub: hf",
    -+    VdV.hf[i] = fp_sub_hf_hf(VuV.hf[i], VvV.hf[i], &env->hvx_fp_status))
    ++    VdV.hf[i] = float16_sub(VuV.hf[i], VvV.hf[i], &env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vadd_sf_hf,
     +    "Vdd32.sf=vadd(Vu32.hf,Vv32.hf)",  "Vector IEEE add: hf widen to sf",
    -+    VddV.v[0].sf[i] = fp_add_sf_hf(VuV.hf[2*i], VvV.hf[2*i], &env->hvx_fp_status);
    -+    VddV.v[1].sf[i] = fp_add_sf_hf(VuV.hf[2*i+1], VvV.hf[2*i+1], &env->hvx_fp_status))
    ++    VddV.v[0].sf[i] = float32_add(f16_to_f32(VuV.hf[2*i]),
    ++                                  f16_to_f32(VvV.hf[2*i]), &env->hvx_fp_status);
    ++    VddV.v[1].sf[i] = float32_add(f16_to_f32(VuV.hf[2*i+1]),
    ++                                  f16_to_f32(VvV.hf[2*i+1]), &env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vsub_sf_hf,
     +    "Vdd32.sf=vsub(Vu32.hf,Vv32.hf)",  "Vector IEEE sub: hf widen to sf",
    -+    VddV.v[0].sf[i] = fp_sub_sf_hf(VuV.hf[2*i], VvV.hf[2*i], &env->hvx_fp_status);
    -+    VddV.v[1].sf[i] = fp_sub_sf_hf(VuV.hf[2*i+1], VvV.hf[2*i+1], &env->hvx_fp_status))
    ++    VddV.v[0].sf[i] = float32_sub(f16_to_f32(VuV.hf[2*i]),
    ++                                  f16_to_f32(VvV.hf[2*i]), &env->hvx_fp_status);
    ++    VddV.v[1].sf[i] = float32_sub(f16_to_f32(VuV.hf[2*i+1]),
    ++                                  f16_to_f32(VvV.hf[2*i+1]), &env->hvx_fp_status))
      
      /******************************************************************************
       DEBUG Vector/Register Printing
 2:  30254b5750 !  7:  0104072468 target/hexagon: add v68 HVX IEEE float min/max insns
    @@ Commit message
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/mmvec/hvx_ieee_fp.h ##
    -@@ target/hexagon/mmvec/hvx_ieee_fp.h: uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t a4,
    - uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uint16_t a3,
    -                       uint16_t a4, float_status *fp_status);
    +@@ target/hexagon/mmvec/hvx_ieee_fp.h: float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
    + float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
    +                  float_status *fp_status);
      
    -+/* IEEE - FP min/max instructions */
    -+uint32_t fp_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
    -+uint32_t fp_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
    -+uint16_t fp_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    -+uint16_t fp_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    -+
     +/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller than -INF */
     +uint32_t qf_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
     +uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
    @@ target/hexagon/mmvec/hvx_ieee_fp.h: uint32_t fp_vdmpy(uint16_t a1, uint16_t a2,
     +
      #endif
     
    + ## target/hexagon/attribs_def.h.inc ##
    +@@ target/hexagon/attribs_def.h.inc: DEF_ATTRIB(CVI_SCATTER, "CVI Scatter operation", "", "")
    + DEF_ATTRIB(CVI_SCATTER_RELEASE, "CVI Store Release for scatter", "", "")
    + DEF_ATTRIB(CVI_TMP_DST, "CVI instruction that doesn't write a register", "", "")
    + DEF_ATTRIB(CVI_SLOT23, "Can execute in slot 2 or slot 3 (HVX)", "", "")
    ++DEF_ATTRIB(CVI_VA_2SRC, "Execs on multimedia vector engine; requires two srcs", "", "")
    + 
    + DEF_ATTRIB(VTCM_ALLBANK_ACCESS, "Allocates in all VTCM schedulers.", "", "")
    + 
    +@@ target/hexagon/attribs_def.h.inc: DEF_ATTRIB(HVX_IEEE_FP_ACC, "HVX IEEE FP accumulate instruction", "", "")
    + DEF_ATTRIB(HVX_IEEE_FP_OUT_16, "HVX IEEE FP 16-bit output", "", "")
    + DEF_ATTRIB(HVX_IEEE_FP_OUT_32, "HVX IEEE FP 32-bit output", "", "")
    + DEF_ATTRIB(CVI_VX_NO_TMP_LD, "HVX multiply without tmp load", "", "")
    ++DEF_ATTRIB(HVX_FLT, "This a floating point HVX instruction.", "", "")
    + 
    + /* Keep this as the last attribute: */
    + DEF_ATTRIB(ZZ_LASTATTRIB, "Last attribute in the file", "", "")
    +
      ## target/hexagon/mmvec/hvx_ieee_fp.c ##
    -@@ target/hexagon/mmvec/hvx_ieee_fp.c: uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2,
    -     float32 red = fp_vdmpy(a1, a2, a3, a4, fp_status);
    -     return fp_add_sf_sf(float32_val(red), acc, fp_status);
    +@@ target/hexagon/mmvec/hvx_ieee_fp.c: float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
    +     return float32_add(fp_mult_sf_hf(a1, a3, fp_status),
    +                        fp_mult_sf_hf(a2, a4, fp_status), fp_status);
      }
     +
    -+DEF_FP_INSN_2(min_sf, 32, 32, 32, float32_min(f1, f2, fp_status))
    -+DEF_FP_INSN_2(max_sf, 32, 32, 32, float32_max(f1, f2, fp_status))
    -+DEF_FP_INSN_2(min_hf, 16, 16, 16, float16_min(f1, f2, fp_status))
    -+DEF_FP_INSN_2(max_hf, 16, 16, 16, float16_max(f1, f2, fp_status))
    -+
     +#define float32_is_pos_nan(X) (float32_is_any_nan(X) && !float32_is_neg(X))
     +#define float32_is_neg_nan(X) (float32_is_any_nan(X) && float32_is_neg(X))
     +#define float16_is_pos_nan(X) (float16_is_any_nan(X) && !float16_is_neg(X))
     +#define float16_is_neg_nan(X) (float16_is_any_nan(X) && float16_is_neg(X))
     +
    -+uint32_t qf_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status)
    ++float32 qf_max_sf(float32 a1, float32 a2, float_status *fp_status)
     +{
    -+    float32 f1 = make_float32(a1);
    -+    float32 f2 = make_float32(a2);
    -+    if (float32_is_pos_nan(f1) || float32_is_neg_nan(f2)) {
    ++    if (float32_is_pos_nan(a1) || float32_is_neg_nan(a2)) {
     +        return a1;
     +    }
    -+    if (float32_is_pos_nan(f2) || float32_is_neg_nan(f1)) {
    ++    if (float32_is_pos_nan(a2) || float32_is_neg_nan(a1)) {
     +        return a2;
     +    }
    -+    return fp_max_sf(a1, a2, fp_status);
    ++    return float32_max(a1, a2, fp_status);
     +}
     +
    -+uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status)
    ++float32 qf_min_sf(float32 a1, float32 a2, float_status *fp_status)
     +{
    -+    float32 f1 = make_float32(a1);
    -+    float32 f2 = make_float32(a2);
    -+    if (float32_is_pos_nan(f1) || float32_is_neg_nan(f2)) {
    ++    if (float32_is_pos_nan(a1) || float32_is_neg_nan(a2)) {
     +        return a2;
     +    }
    -+    if (float32_is_pos_nan(f2) || float32_is_neg_nan(f1)) {
    ++    if (float32_is_pos_nan(a2) || float32_is_neg_nan(a1)) {
     +        return a1;
     +    }
    -+    return fp_min_sf(a1, a2, fp_status);
    ++    return float32_min(a1, a2, fp_status);
     +}
     +
    -+uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status)
    ++float16 qf_max_hf(float16 a1, float16 a2, float_status *fp_status)
     +{
    -+    float16 f1 = make_float16(a1);
    -+    float16 f2 = make_float16(a2);
    -+    if (float16_is_pos_nan(f1) || float16_is_neg_nan(f2)) {
    ++    if (float16_is_pos_nan(a1) || float16_is_neg_nan(a2)) {
     +        return a1;
     +    }
    -+    if (float16_is_pos_nan(f2) || float16_is_neg_nan(f1)) {
    ++    if (float16_is_pos_nan(a2) || float16_is_neg_nan(a1)) {
     +        return a2;
     +    }
    -+    return fp_max_hf(a1, a2, fp_status);
    ++    return float16_max(a1, a2, fp_status);
     +}
     +
    -+uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status)
    ++float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status)
     +{
    -+    float16 f1 = make_float16(a1);
    -+    float16 f2 = make_float16(a2);
    -+    if (float16_is_pos_nan(f1) || float16_is_neg_nan(f2)) {
    ++    if (float16_is_pos_nan(a1) || float16_is_neg_nan(a2)) {
     +        return a2;
     +    }
    -+    if (float16_is_pos_nan(f2) || float16_is_neg_nan(f1)) {
    ++    if (float16_is_pos_nan(a2) || float16_is_neg_nan(a1)) {
     +        return a1;
     +    }
    -+    return fp_min_hf(a1, a2, fp_status);
    ++    return float16_min(a1, a2, fp_status);
     +}
     
    + ## target/hexagon/hex_common.py ##
    +@@ target/hexagon/hex_common.py: def need_env(tag):
    +             "A_CVI_GATHER" in attribdict[tag] or
    +             "A_CVI_SCATTER" in attribdict[tag] or
    +             "A_HVX_IEEE_FP" in attribdict[tag] or
    ++            "A_HVX_FLT" in attribdict[tag] or
    +             "A_IMPLICIT_WRITES_USR" in attribdict[tag])
    + 
    + 
    +
      ## target/hexagon/imported/mmvec/encode_ext.def ##
     @@ target/hexagon/imported/mmvec/encode_ext.def: DEF_ENC(V6_vsub_sf_hf,"00011111100vvvvvPP1uuuuu101ddddd")
      DEF_ENC(V6_vadd_hf_hf,"00011111101vvvvvPP1uuuuu111ddddd")
    @@ target/hexagon/imported/mmvec/ext.idef
      #define ITERATOR_INSN2_ANY_SLOT(WIDTH,TAG,SYNTAX,SYNTAX2,DESCR,CODE) \
      ITERATOR_INSN_ANY_SLOT(WIDTH,TAG,SYNTAX2,DESCR,CODE)
     @@ target/hexagon/imported/mmvec/ext.idef: ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vsub_sf_hf,
    -     VddV.v[0].sf[i] = fp_sub_sf_hf(VuV.hf[2*i], VvV.hf[2*i], &env->hvx_fp_status);
    -     VddV.v[1].sf[i] = fp_sub_sf_hf(VuV.hf[2*i+1], VvV.hf[2*i+1], &env->hvx_fp_status))
    +     VddV.v[1].sf[i] = float32_sub(f16_to_f32(VuV.hf[2*i+1]),
    +                                   f16_to_f32(VvV.hf[2*i+1]), &env->hvx_fp_status))
      
     +#define ITERATOR_INSN_IEEE_FP_16_32_LATE(WIDTH,TAG,SYNTAX,DESCR,CODE) \
     +EXTINSN(V6_##TAG, SYNTAX, \
    @@ target/hexagon/imported/mmvec/ext.idef: ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vsub
     +
     +/* IEEE FP min/max instructions */
     +ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfmin_hf, "Vd32.hf=vfmin(Vu32.hf,Vv32.hf)", \
    -+    "Vector IEEE min: hf",  VdV.hf[i] = fp_min_hf(VuV.hf[i], VvV.hf[i], \
    ++    "Vector IEEE min: hf",  VdV.hf[i] = float16_min(VuV.hf[i], VvV.hf[i], \
     +	&env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfmin_sf, "Vd32.sf=vfmin(Vu32.sf,Vv32.sf)", \
    -+    "Vector IEEE min: sf",  VdV.sf[i] = fp_min_sf(VuV.sf[i], VvV.sf[i], \
    ++    "Vector IEEE min: sf",  VdV.sf[i] = float32_min(VuV.sf[i], VvV.sf[i], \
     +	&env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfmax_hf,  "Vd32.hf=vfmax(Vu32.hf,Vv32.hf)", \
    -+    "Vector IEEE max: hf", VdV.hf[i] = fp_max_hf(VuV.hf[i], VvV.hf[i], \
    ++    "Vector IEEE max: hf", VdV.hf[i] = float16_max(VuV.hf[i], VvV.hf[i], \
     +	&env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfmax_sf,  "Vd32.sf=vfmax(Vu32.sf,Vv32.sf)", \
    -+    "Vector IEEE max: sf", VdV.sf[i] = fp_max_sf(VuV.sf[i], VvV.sf[i], \
    ++    "Vector IEEE max: sf", VdV.sf[i] = float32_max(VuV.sf[i], VvV.sf[i], \
     +	&env->hvx_fp_status))
     +
     +ITERATOR_INSN_ANY_SLOT_2SRC(32,vmax_sf,"Vd32.sf=vmax(Vu32.sf,Vv32.sf)", \
 3:  c6fe780abf =  8:  2aa7f10503 target/hexagon: add v68 HVX IEEE float misc insns
 4:  85dccc1913 !  9:  99bac24648 target/hexagon: add v68 HVX IEEE float conversion insns
    @@ Commit message
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/mmvec/hvx_ieee_fp.h ##
    +@@
    + #include "fpu/softfloat.h"
    + 
    + #define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status)
    ++#define f32_to_f16(A) float32_to_float16((A), true, &env->hvx_fp_status)
    + 
    + float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
    + float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
     @@ target/hexagon/mmvec/hvx_ieee_fp.h: uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
      uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
      uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
      
    -+/*
    -+ * IEEE - FP Convert instructions
    -+ */
    -+uint16_t f32_to_f16(uint32_t a, float_status *fp_status);
    -+uint32_t f16_to_f32(uint16_t a, float_status *fp_status);
    -+
    -+uint16_t f16_to_uh(uint16_t op1, float_status *fp_status);
    -+int16_t  f16_to_h(uint16_t op1, float_status *fp_status);
    -+uint8_t  f16_to_ub(uint16_t op1, float_status *fp_status);
    -+int8_t   f16_to_b(uint16_t op1, float_status *fp_status);
    -+
    -+uint16_t uh_to_f16(uint16_t op1);
    -+uint16_t h_to_f16(int16_t op1);
    -+uint16_t ub_to_f16(uint8_t op1);
    -+uint16_t b_to_f16(int8_t op1);
    -+
    -+int32_t conv_sf_w(int32_t a, float_status *fp_status);
    -+int16_t conv_hf_h(int16_t a, float_status *fp_status);
    -+int32_t conv_w_sf(uint32_t a, float_status *fp_status);
    -+int16_t conv_h_hf(uint16_t a, float_status *fp_status);
    ++int32_t conv_w_sf(float32 a, float_status *fp_status);
    ++int16_t conv_h_hf(float16 a, float_status *fp_status);
     +
      #endif
     
      ## target/hexagon/mmvec/hvx_ieee_fp.c ##
    -@@ target/hexagon/mmvec/hvx_ieee_fp.c: uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status)
    +@@ target/hexagon/mmvec/hvx_ieee_fp.c: float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status)
          }
    -     return fp_min_hf(a1, a2, fp_status);
    +     return float16_min(a1, a2, fp_status);
      }
     +
    -+uint16_t f32_to_f16(uint32_t a, float_status *fp_status)
    ++int32_t conv_w_sf(float32 a, float_status *fp_status)
     +{
    -+    return float16_val(float32_to_float16(make_float32(a), true, fp_status));
    -+}
    -+
    -+uint32_t f16_to_f32(uint16_t a, float_status *fp_status)
    -+{
    -+    return float32_val(float16_to_float32(make_float16(a), true, fp_status));
    -+}
    -+
    -+uint16_t f16_to_uh(uint16_t op1, float_status *fp_status)
    -+{
    -+    return float16_to_uint16_scalbn(make_float16(op1),
    -+                                    float_round_nearest_even,
    -+                                    0, fp_status);
    -+}
    -+
    -+int16_t f16_to_h(uint16_t op1, float_status *fp_status)
    -+{
    -+    return float16_to_int16_scalbn(make_float16(op1),
    -+                                   float_round_nearest_even,
    -+                                   0, fp_status);
    -+}
    -+
    -+uint8_t f16_to_ub(uint16_t op1, float_status *fp_status)
    -+{
    -+    return float16_to_uint8_scalbn(make_float16(op1),
    -+                                   float_round_nearest_even,
    -+                                   0, fp_status);
    -+}
    -+
    -+int8_t f16_to_b(uint16_t op1, float_status *fp_status)
    -+{
    -+    return float16_to_int8_scalbn(make_float16(op1),
    -+                                   float_round_nearest_even,
    -+                                   0, fp_status);
    -+}
    -+
    -+uint16_t uh_to_f16(uint16_t op1)
    -+{
    -+    return uint64_to_float16_scalbn(op1, float_round_nearest_even, 0);
    -+}
    -+
    -+uint16_t h_to_f16(int16_t op1)
    -+{
    -+    return int64_to_float16_scalbn(op1, float_round_nearest_even, 0);
    -+}
    -+
    -+uint16_t ub_to_f16(uint8_t op1)
    -+{
    -+    return uint64_to_float16_scalbn(op1, float_round_nearest_even, 0);
    -+}
    -+
    -+uint16_t b_to_f16(int8_t op1)
    -+{
    -+    return int64_to_float16_scalbn(op1, float_round_nearest_even, 0);
    -+}
    -+
    -+int32_t conv_sf_w(int32_t a, float_status *fp_status)
    -+{
    -+    return float32_val(int32_to_float32(a, fp_status));
    -+}
    -+
    -+int16_t conv_hf_h(int16_t a, float_status *fp_status)
    -+{
    -+    return float16_val(int16_to_float16(a, fp_status));
    -+}
    -+
    -+int32_t conv_w_sf(uint32_t a, float_status *fp_status)
    -+{
    -+    float32 f1 = make_float32(a);
     +    /* float32_to_int32 converts any NaN to MAX, hexagon looks at the sign. */
    -+    if (float32_is_any_nan(f1)) {
    -+        return float32_is_neg(f1) ? INT32_MIN : INT32_MAX;
    ++    if (float32_is_any_nan(a)) {
    ++        return float32_is_neg(a) ? INT32_MIN : INT32_MAX;
     +    }
    -+    return float32_to_int32_round_to_zero(f1, fp_status);
    ++    return float32_to_int32_round_to_zero(a, fp_status);
     +}
     +
    -+int16_t conv_h_hf(uint16_t a, float_status *fp_status)
    ++int16_t conv_h_hf(float16 a, float_status *fp_status)
     +{
    -+    float16 f1 = make_float16(a);
     +    /* float16_to_int16 converts any NaN to MAX, hexagon looks at the sign. */
    -+    if (float16_is_any_nan(f1)) {
    -+        return float16_is_neg(f1) ? INT16_MIN : INT16_MAX;
    ++    if (float16_is_any_nan(a)) {
    ++        return float16_is_neg(a) ? INT16_MIN : INT16_MAX;
     +    }
    -+    return float16_to_int16_round_to_zero(f1, fp_status);
    ++    return float16_to_int16_round_to_zero(a, fp_status);
     +}
     
      ## target/hexagon/imported/mmvec/encode_ext.def ##
    @@ target/hexagon/imported/mmvec/ext.idef: ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vab
     +
     +ITERATOR_INSN_IEEE_FP_DOUBLE_16(32,  vcvt_hf_ub, "Vdd32.hf=vcvt(Vu32.ub)",
     +    "Vector IEEE cvt from int: ub widen to hf",
    -+    VddV.v[0].hf[2*i]   = ub_to_f16(VuV.ub[4*i]);
    -+    VddV.v[0].hf[2*i+1] = ub_to_f16(VuV.ub[4*i+1]);
    -+    VddV.v[1].hf[2*i]   = ub_to_f16(VuV.ub[4*i+2]);
    -+    VddV.v[1].hf[2*i+1] = ub_to_f16(VuV.ub[4*i+3]))
    ++    VddV.v[0].hf[2*i]   = uint64_to_float16_scalbn(VuV.ub[4*i], float_round_nearest_even, 0);
    ++    VddV.v[0].hf[2*i+1] = uint64_to_float16_scalbn(VuV.ub[4*i+1], float_round_nearest_even, 0);
    ++    VddV.v[1].hf[2*i]   = uint64_to_float16_scalbn(VuV.ub[4*i+2], float_round_nearest_even, 0);
    ++    VddV.v[1].hf[2*i+1] = uint64_to_float16_scalbn(VuV.ub[4*i+3], float_round_nearest_even, 0))
     +
     +ITERATOR_INSN_IEEE_FP_DOUBLE_16(32,  vcvt_hf_b,  "Vdd32.hf=vcvt(Vu32.b)",
     +    "Vector IEEE cvt from int: b widen to hf",
    -+    VddV.v[0].hf[2*i]   = b_to_f16(VuV.b[4*i]);
    -+    VddV.v[0].hf[2*i+1] = b_to_f16(VuV.b[4*i+1]);
    -+    VddV.v[1].hf[2*i]   = b_to_f16(VuV.b[4*i+2]);
    -+    VddV.v[1].hf[2*i+1] = b_to_f16(VuV.b[4*i+3]))
    ++    VddV.v[0].hf[2*i]   = int64_to_float16_scalbn(VuV.b[4*i], float_round_nearest_even, 0);
    ++    VddV.v[0].hf[2*i+1] = int64_to_float16_scalbn(VuV.b[4*i+1], float_round_nearest_even, 0);
    ++    VddV.v[1].hf[2*i]   = int64_to_float16_scalbn(VuV.b[4*i+2], float_round_nearest_even, 0);
    ++    VddV.v[1].hf[2*i+1] = int64_to_float16_scalbn(VuV.b[4*i+3], float_round_nearest_even, 0))
     +
     +ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vcvt_sf_hf, "Vdd32.sf=vcvt(Vu32.hf)",
     +    "Vector IEEE cvt: hf widen to sf",
    -+    VddV.v[0].sf[i] = f16_to_f32(VuV.hf[2*i], &env->hvx_fp_status);
    -+    VddV.v[1].sf[i] = f16_to_f32(VuV.hf[2*i+1], &env->hvx_fp_status))
    ++    VddV.v[0].sf[i] = f16_to_f32(VuV.hf[2*i]);
    ++    VddV.v[1].sf[i] = f16_to_f32(VuV.hf[2*i+1]))
     +
     +ITERATOR_INSN_IEEE_FP_16(16,    vcvt_hf_uh, "Vd32.hf=vcvt(Vu32.uh)",
     +    "Vector IEEE cvt from int: uh to hf",
    -+    VdV.hf[i] = uh_to_f16(VuV.uh[i]))
    ++    VdV.hf[i] = uint64_to_float16_scalbn(VuV.uh[i], float_round_nearest_even, 0))
     +ITERATOR_INSN_IEEE_FP_16(16,    vcvt_hf_h,  "Vd32.hf=vcvt(Vu32.h)",
     +    "Vector IEEE cvt from int: h to hf",
    -+    VdV.hf[i] = h_to_f16(VuV.h[i]))
    ++    VdV.hf[i] = int64_to_float16_scalbn(VuV.h[i], float_round_nearest_even, 0))
     +ITERATOR_INSN_IEEE_FP_16_32(16, vcvt_uh_hf, "Vd32.uh=vcvt(Vu32.hf)",
     +    "Vector IEEE cvt to int: hf to uh",
    -+    VdV.uh[i] = f16_to_uh(VuV.hf[i], &env->hvx_fp_status))
    ++    VdV.uh[i] = float16_to_uint16_scalbn(VuV.hf[i], float_round_nearest_even, 0, &env->hvx_fp_status))
     +ITERATOR_INSN_IEEE_FP_16_32(16, vcvt_h_hf,  "Vd32.h=vcvt(Vu32.hf)",
     +    "Vector IEEE cvt to int: hf to h",
    -+    VdV.h[i]  = f16_to_h(VuV.hf[i], &env->hvx_fp_status))
    ++    VdV.h[i]  = float16_to_int16_scalbn(VuV.hf[i], float_round_nearest_even, 0, &env->hvx_fp_status))
     +
     +ITERATOR_INSN_IEEE_FP_16(32, vcvt_hf_sf, "Vd32.hf=vcvt(Vu32.sf,Vv32.sf)",
     +    "Vector IEEE cvt: sf to hf",
    -+    VdV.hf[2*i]   = f32_to_f16(VuV.sf[i], &env->hvx_fp_status);
    -+    VdV.hf[2*i+1] = f32_to_f16(VvV.sf[i], &env->hvx_fp_status))
    ++    VdV.hf[2*i]   = f32_to_f16(VuV.sf[i]);
    ++    VdV.hf[2*i+1] = f32_to_f16(VvV.sf[i]))
     +
     +ITERATOR_INSN_IEEE_FP_16_32(32, vcvt_ub_hf, "Vd32.ub=vcvt(Vu32.hf,Vv32.hf)", "Vector cvt to int: hf narrow to ub",
    -+    VdV.ub[4*i]   = f16_to_ub(VuV.hf[2*i], &env->hvx_fp_status);
    -+    VdV.ub[4*i+1] = f16_to_ub(VuV.hf[2*i+1], &env->hvx_fp_status);
    -+    VdV.ub[4*i+2] = f16_to_ub(VvV.hf[2*i], &env->hvx_fp_status);
    -+    VdV.ub[4*i+3] = f16_to_ub(VvV.hf[2*i+1], &env->hvx_fp_status))
    ++    VdV.ub[4*i]   = float16_to_uint8_scalbn(VuV.hf[2*i], float_round_nearest_even, 0, &env->hvx_fp_status);
    ++    VdV.ub[4*i+1] = float16_to_uint8_scalbn(VuV.hf[2*i+1], float_round_nearest_even, 0, &env->hvx_fp_status);
    ++    VdV.ub[4*i+2] = float16_to_uint8_scalbn(VvV.hf[2*i], float_round_nearest_even, 0, &env->hvx_fp_status);
    ++    VdV.ub[4*i+3] = float16_to_uint8_scalbn(VvV.hf[2*i+1], float_round_nearest_even, 0, &env->hvx_fp_status))
     +
     +ITERATOR_INSN_IEEE_FP_16_32(32, vcvt_b_hf,  "Vd32.b=vcvt(Vu32.hf,Vv32.hf)",
     +    "Vector cvt to int: hf narrow to b",
    -+    VdV.b[4*i]   = f16_to_b(VuV.hf[2*i], &env->hvx_fp_status);
    -+    VdV.b[4*i+1] = f16_to_b(VuV.hf[2*i+1], &env->hvx_fp_status);
    -+    VdV.b[4*i+2] = f16_to_b(VvV.hf[2*i], &env->hvx_fp_status);
    -+    VdV.b[4*i+3] = f16_to_b(VvV.hf[2*i+1], &env->hvx_fp_status))
    ++    VdV.b[4*i]   = float16_to_int8_scalbn(VuV.hf[2*i], float_round_nearest_even, 0, &env->hvx_fp_status);
    ++    VdV.b[4*i+1] = float16_to_int8_scalbn(VuV.hf[2*i+1], float_round_nearest_even, 0, &env->hvx_fp_status);
    ++    VdV.b[4*i+2] = float16_to_int8_scalbn(VvV.hf[2*i], float_round_nearest_even, 0, &env->hvx_fp_status);
    ++    VdV.b[4*i+3] = float16_to_int8_scalbn(VvV.hf[2*i+1], float_round_nearest_even, 0, &env->hvx_fp_status))
     +
     +ITERATOR_INSN_SHIFT_SLOT_FLT(32, vconv_w_sf,"Vd32.w=Vu32.sf",
     +    "Vector conversion of sf32 format to int w",
    @@ target/hexagon/imported/mmvec/ext.idef: ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vab
     +
     +ITERATOR_INSN_SHIFT_SLOT_FLT(32, vconv_sf_w,"Vd32.sf=Vu32.w",
     +    "Vector conversion of int w format to sf32",
    -+    VdV.sf[i] = conv_sf_w(VuV.w[i], &env->hvx_fp_status))
    ++    VdV.sf[i] = int32_to_float32(VuV.w[i], &env->hvx_fp_status))
     +
     +ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
     +    "Vector conversion of int hw format to hf16",
    -+    VdV.hf[i] = conv_hf_h(VuV.h[i], &env->hvx_fp_status))
    ++    VdV.hf[i] = float16_val(int16_to_float16(VuV.h[i], &env->hvx_fp_status)))
     +
      /******************************************************************************
       DEBUG Vector/Register Printing
 5:  9ac626fa17 ! 10:  9518dd95bd target/hexagon: add v68 HVX IEEE float compare insns
    @@ Commit message
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/mmvec/hvx_ieee_fp.h ##
    -@@ target/hexagon/mmvec/hvx_ieee_fp.h: uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
    - uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    - uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    +@@ target/hexagon/mmvec/hvx_ieee_fp.h: uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    + int32_t conv_w_sf(float32 a, float_status *fp_status);
    + int16_t conv_h_hf(float16 a, float_status *fp_status);
      
     +/* IEEE - FP compare instructions */
     +uint32_t cmpgt_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
     +uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
     +
    - /*
    -  * IEEE - FP Convert instructions
    -  */
    + #endif
     
      ## target/hexagon/mmvec/macros.h ##
     @@
    @@ target/hexagon/mmvec/macros.h
     +
      #endif
     
    - ## target/hexagon/attribs_def.h.inc ##
    -@@ target/hexagon/attribs_def.h.inc: DEF_ATTRIB(CVI_SCATTER, "CVI Scatter operation", "", "")
    - DEF_ATTRIB(CVI_SCATTER_RELEASE, "CVI Store Release for scatter", "", "")
    - DEF_ATTRIB(CVI_TMP_DST, "CVI instruction that doesn't write a register", "", "")
    - DEF_ATTRIB(CVI_SLOT23, "Can execute in slot 2 or slot 3 (HVX)", "", "")
    -+DEF_ATTRIB(CVI_VA_2SRC, "Execs on multimedia vector engine; requires two srcs", "", "")
    - 
    - DEF_ATTRIB(VTCM_ALLBANK_ACCESS, "Allocates in all VTCM schedulers.", "", "")
    - 
    -@@ target/hexagon/attribs_def.h.inc: DEF_ATTRIB(HVX_IEEE_FP_ACC, "HVX IEEE FP accumulate instruction", "", "")
    - DEF_ATTRIB(HVX_IEEE_FP_OUT_16, "HVX IEEE FP 16-bit output", "", "")
    - DEF_ATTRIB(HVX_IEEE_FP_OUT_32, "HVX IEEE FP 32-bit output", "", "")
    - DEF_ATTRIB(CVI_VX_NO_TMP_LD, "HVX multiply without tmp load", "", "")
    -+DEF_ATTRIB(HVX_FLT, "This a floating point HVX instruction.", "", "")
    - 
    - /* Keep this as the last attribute: */
    - DEF_ATTRIB(ZZ_LASTATTRIB, "Last attribute in the file", "", "")
    -
      ## target/hexagon/mmvec/hvx_ieee_fp.c ##
    -@@ target/hexagon/mmvec/hvx_ieee_fp.c: int16_t conv_h_hf(uint16_t a, float_status *fp_status)
    +@@ target/hexagon/mmvec/hvx_ieee_fp.c: int16_t conv_h_hf(float16 a, float_status *fp_status)
          }
    -     return float16_to_int16_round_to_zero(f1, fp_status);
    +     return float16_to_int16_round_to_zero(a, fp_status);
      }
     +
     +/*
    @@ target/hexagon/mmvec/hvx_ieee_fp.c: int16_t conv_h_hf(uint16_t a, float_status *
     +    return float16_is_neg(f1) ? !result : result;
     +}
     +
    -+uint32_t cmpgt_sf(uint32_t a1, uint32_t a2, float_status *fp_status)
    ++uint32_t cmpgt_sf(float32 a1, float32 a2, float_status *fp_status)
     +{
    -+    float32 f1 = make_float32(a1);
    -+    float32 f2 = make_float32(a2);
    -+    if (float32_is_any_nan(f1) || float32_is_any_nan(f2)) {
    -+        return float32_nan_compare(f1, f2, fp_status);
    ++    if (float32_is_any_nan(a1) || float32_is_any_nan(a2)) {
    ++        return float32_nan_compare(a1, a2, fp_status);
     +    }
     +    return float32_compare(a1, a2, fp_status) == float_relation_greater;
     +}
     +
    -+uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status)
    ++uint16_t cmpgt_hf(float16 a1, float16 a2, float_status *fp_status)
     +{
    -+    float16 f1 = make_float16(a1);
    -+    float16 f2 = make_float16(a2);
    -+    if (float16_is_any_nan(f1) || float16_is_any_nan(f2)) {
    -+        return float16_nan_compare(f1, f2, fp_status);
    ++    if (float16_is_any_nan(a1) || float16_is_any_nan(a2)) {
    ++        return float16_nan_compare(a1, a2, fp_status);
     +    }
     +    return float16_compare(a1, a2, fp_status) == float_relation_greater;
     +}
     
    - ## target/hexagon/hex_common.py ##
    -@@ target/hexagon/hex_common.py: def need_env(tag):
    -             "A_CVI_GATHER" in attribdict[tag] or
    -             "A_CVI_SCATTER" in attribdict[tag] or
    -             "A_HVX_IEEE_FP" in attribdict[tag] or
    -+            "A_HVX_FLT" in attribdict[tag] or
    -             "A_IMPLICIT_WRITES_USR" in attribdict[tag])
    - 
    - 
    -
      ## target/hexagon/imported/mmvec/encode_ext.def ##
     @@ target/hexagon/imported/mmvec/encode_ext.def: DEF_ENC(V6_vconv_w_sf,"00011110--0--101PP1uuuuu001ddddd")
      DEF_ENC(V6_vconv_hf_h,"00011110--0--101PP1uuuuu100ddddd")
    @@ target/hexagon/imported/mmvec/encode_ext.def: DEF_ENC(V6_vconv_w_sf,"00011110--0
      ## target/hexagon/imported/mmvec/ext.idef ##
     @@ target/hexagon/imported/mmvec/ext.idef: ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
          "Vector conversion of int hw format to hf16",
    -     VdV.hf[i] = conv_hf_h(VuV.h[i], &env->hvx_fp_status))
    +     VdV.hf[i] = float16_val(int16_to_float16(VuV.h[i], &env->hvx_fp_status)))
      
     +/******************************************************************************
     + * IEEE FP compare instructions
 6:  b12d94be22 ! 11:  f84d180547 target/hexagon: add v73 HVX IEEE bfloat16 insns
    @@ Commit message
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/mmvec/hvx_ieee_fp.h ##
    -@@ target/hexagon/mmvec/hvx_ieee_fp.h: int16_t conv_hf_h(int16_t a, float_status *fp_status);
    - int32_t conv_w_sf(uint32_t a, float_status *fp_status);
    - int16_t conv_h_hf(uint16_t a, float_status *fp_status);
    +@@
    + 
    + #include "fpu/softfloat.h"
    + 
    ++#define FP32_DEF_NAN 0x7FFFFFFF
    ++
    + #define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status)
    + #define f32_to_f16(A) float32_to_float16((A), true, &env->hvx_fp_status)
    ++#define bf_to_sf(A) bfloat16_to_float32(A, &env->hvx_fp_status)
    + 
    + float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
    + float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
    +@@ target/hexagon/mmvec/hvx_ieee_fp.h: int16_t conv_h_hf(float16 a, float_status *fp_status);
    + uint32_t cmpgt_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
    + uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
      
     +/* IEEE BFloat instructions */
     +
     +#define fp_mult_sf_bf(A, B) \
    -+    fp_mult_sf_sf(bfloat16_to_float32(A, &env->hvx_fp_status), \
    -+                  bfloat16_to_float32(B, &env->hvx_fp_status), \
    -+                  &env->hvx_fp_status)
    ++    float32_mul(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status)
    ++
     +#define fp_add_sf_bf(A, B) \
    -+    fp_add_sf_sf(bfloat16_to_float32(A, &env->hvx_fp_status), \
    -+                 bfloat16_to_float32(B, &env->hvx_fp_status), \
    -+                 &env->hvx_fp_status)
    ++    float32_add(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status)
    ++
     +#define fp_sub_sf_bf(A, B) \
    -+    fp_sub_sf_sf(bfloat16_to_float32(A, &env->hvx_fp_status), \
    -+                 bfloat16_to_float32(B, &env->hvx_fp_status), \
    -+                 &env->hvx_fp_status)
    ++    float32_sub(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status)
     +
    -+uint32_t fp_mult_sf_bf_acc(uint16_t op1, uint16_t op2, uint32_t acc,
    -+                           float_status *fp_status);
    -+
    -+#define bf_to_sf(A, fp_status) bfloat16_to_float32(A, fp_status)
    ++#define fp_mult_sf_bf_acc(f1, f2, f3) \
    ++    float32_muladd(bf_to_sf(f1), bf_to_sf(f2), f3, 0, &env->hvx_fp_status)
     +
     +static inline uint16_t sf_to_bf(int32_t A, float_status *fp_status)
     +{
    @@ target/hexagon/mmvec/hvx_ieee_fp.h: int16_t conv_hf_h(int16_t a, float_status *f
     +}
     +
     +#define fp_min_bf(A, B) \
    -+    sf_to_bf(fp_min_sf(bf_to_sf(A, &env->hvx_fp_status), \
    -+                       bf_to_sf(B, &env->hvx_fp_status), \
    -+                       &env->hvx_fp_status), \
    ++    sf_to_bf(float32_min(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status), \
     +             &env->hvx_fp_status);
     +
     +#define fp_max_bf(A, B) \
    -+    sf_to_bf(fp_max_sf(bf_to_sf(A, &env->hvx_fp_status), \
    -+                       bf_to_sf(B, &env->hvx_fp_status), \
    -+                       &env->hvx_fp_status), \
    ++    sf_to_bf(float32_max(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status), \
     +             &env->hvx_fp_status);
     +
      #endif
    @@ target/hexagon/mmvec/macros.h
      ## target/hexagon/mmvec/mmvec.h ##
     @@ target/hexagon/mmvec/mmvec.h: typedef union {
          int8_t    b[MAX_VEC_SIZE_BYTES / 1];
    -     int32_t  sf[MAX_VEC_SIZE_BYTES / 4];   /* single float (32-bit) */
    -     int16_t  hf[MAX_VEC_SIZE_BYTES / 2];   /* half float (16-bit) */
    -+    uint16_t bf[MAX_VEC_SIZE_BYTES / 2];   /* bfloat16 */
    +     float32  sf[MAX_VEC_SIZE_BYTES / 4];
    +     float16  hf[MAX_VEC_SIZE_BYTES / 2];
    ++    bfloat16 bf[MAX_VEC_SIZE_BYTES / 2];
      } MMVector;
      
      typedef union {
     
    - ## target/hexagon/mmvec/hvx_ieee_fp.c ##
    -@@ target/hexagon/mmvec/hvx_ieee_fp.c: uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status)
    -     }
    -     return float16_compare(a1, a2, fp_status) == float_relation_greater;
    - }
    -+
    -+DEF_FP_INSN_3(mult_sf_bf_acc, 32, 16, 16, 32,
    -+              float32_muladd(bf_to_sf(f1, fp_status), bf_to_sf(f2, fp_status),
    -+                             f3, 0, fp_status))
    -
      ## target/hexagon/imported/mmvec/encode_ext.def ##
     @@ target/hexagon/imported/mmvec/encode_ext.def: DEF_ENC(V6_vgthf_or,"00011100100vvvvvPP1uuuuu001101xx")
      DEF_ENC(V6_vgtsf_xor,"00011100100vvvvvPP1uuuuu111010xx")
    @@ target/hexagon/imported/mmvec/ext.idef: ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_h
     +    VddV.v[1].sf[i] = fp_mult_sf_bf(VuV.bf[2*i+1], VvV.bf[2*i+1]); fBFLOAT())
     +ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_bf_acc,
     +    "Vxx32.sf+=vmpy(Vu32.bf,Vv32.bf)", "Vector IEEE fma: hf widen to sf",
    -+    VxxV.v[0].sf[i] = fp_mult_sf_bf_acc(VuV.bf[2*i], VvV.bf[2*i],
    -+                                        VxxV.v[0].sf[i], &env->hvx_fp_status);
    -+    VxxV.v[1].sf[i] = fp_mult_sf_bf_acc(VuV.bf[2*i+1], VvV.bf[2*i+1],
    -+                                        VxxV.v[1].sf[i], &env->hvx_fp_status);
    ++    VxxV.v[0].sf[i] = fp_mult_sf_bf_acc(VuV.bf[2*i], VvV.bf[2*i], VxxV.v[0].sf[i]);
    ++    VxxV.v[1].sf[i] = fp_mult_sf_bf_acc(VuV.bf[2*i+1], VvV.bf[2*i+1], VxxV.v[1].sf[i]);
     +    fCVI_VX_NO_TMP_LD(); fBFLOAT())
     +ITERATOR_INSN_IEEE_FP_16(32, vcvt_bf_sf,
     +    "Vd32.bf=vcvt(Vu32.sf,Vv32.sf)",   "Vector IEEE cvt: sf to bf",
 7:  0cfe85d9fb = 12:  e66f33dc97 tests/hexagon: add tests for v68 HVX IEEE float arithmetics
 8:  eb66aadfac = 13:  5055daa72b tests/hexagon: add tests for v68 HVX IEEE float min/max
 9:  166c7bc232 = 14:  e0d756ec35 tests/hexagon: add tests for v68 HVX IEEE float conversions
10:  cdc88a2115 = 15:  f46538124c tests/hexagon: add tests for v68 HVX IEEE float comparisons
11:  54d79eb29d = 16:  12d1c25d33 tests/hexagon: add tests for HVX bfloat
-- 
2.37.2


