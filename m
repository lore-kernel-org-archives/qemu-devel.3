Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46050F459FC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5m-0006qC-4x; Fri, 10 Apr 2026 13:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5Z-0006nL-Pz
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5V-0001XS-AA
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:17 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AAqj5f1925776
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=z7TUtCBMKK6/GYYlF4XHyWbqgTp4dA//2YP
 7peowl7U=; b=BJF3PlvCBf1BiCN0b1Av9LE2H3VfIHmf9NTNUMYUuD35aimnIy7
 tE6kq8ZU6irdyTlCyZfZkQO09VTzSfWwqzCr031YtFaHTNrJAQ0ViPggBGFZ9wk/
 ZAeyXQnA6eQxiFTS1kli1bkWBp7qTtWqnKwB3FUPjYYoLa0nqfZk8W/GhcEpXf3l
 11/jertQaCZitbaXUaXwl8H4bchOqfxcro1o0QkwjhPOHPPMUygu09DKGJPBENkP
 kKLlHN3qMu2yDBy9HbUB6DTix61bFd0Niwguq/PlHUtfJcS2EbUNI0Ogwq8ht2d5
 M0dzXbCCTzXRQ9E3CamhPnFE9LkAll5bgOA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudjtcf5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bdd327d970so1344223eec.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843768; x=1776448568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z7TUtCBMKK6/GYYlF4XHyWbqgTp4dA//2YP7peowl7U=;
 b=AevPPDrfJbe40KezwP+MnsRjvpczhMij/QD2Zjx8mnVpsEpGci4E1LQ4S6ZHRTiyQp
 wkmTClXVPSdDPbfDc9q/Tp2VtvqxUdCkiVevSurd5g3XYOqk+rb7d6G50F1NbMNgFfUa
 3YDBtqN5RLgcu4JVzUd+oU2Dt78zzenFU1tla+rhsjdoe4eymfl1072k9622zCsJ4oef
 nzsiUZNENDDzsI9bffc6C5h2seS88YuNEawlbYyfoT1ZGhVbbxacZWcpyJSiyvx+bamV
 SGNo+mgVOChZTimIGindFpj5G0jJvSTuGXi5dy9cTpiqP/Fp/WSo4mFWp23jdHdZsXDk
 LLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843768; x=1776448568;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7TUtCBMKK6/GYYlF4XHyWbqgTp4dA//2YP7peowl7U=;
 b=BYooR610nmeGX4jfcsLlvnHsIVTIO+zd8SOo5LeRoCDgVUzGKny+zu2iE66dIN9Z3n
 3QxFG5BQcmOgvyzFKGAOtjxietiWmq09zUbK5Qc/4sLhUDNI9RUC6Rf1kmyQRELe7BhQ
 +c1Bq7y4/7lUa2Siw64dQcBfhCD1X6cXJEIz1+ZJuOTKUGR5EShjPWhEwTw7yfFCVpNb
 eUGyI1ePuj6fcS7hT+E6mPmMsXPrCJrUMztjUy/dmMxl4K29AeEx04vp0Xp4mFWhoLF3
 IeTU4gt3YJQSDg4NIFl0olMyId1kO89mIZSxOSNbwixDxW63xhvrULSdBTgL2/0t+Mc5
 s2wg==
X-Gm-Message-State: AOJu0YxAGzfZ6MB29qGQfAi527641+nzDBxSIm6TYkxigxNLHCspirkt
 8o7gQcT+TLi8IdwNuQMMX/k4JX+wsWCzDxna2IkSE5WraUXjRV4dQXHjxj/eypbDxYm2JALdZWG
 2X9DRC7HBZajQy2GOIGmATOvGHbwdJ9yZoVEyCt7CMcJcVTNpyfccjayQ6sW8ZfegiTtM
X-Gm-Gg: AeBDiev0HVVVoH4kfUVpMZYrmrA9/cn/d8m6mLvh5ZgU/rQ2VNw1ho+9KvjfpOKT5DN
 B/PICDYHtaRW/BpYsrxGp8//1hhmn+KO+8IPIHFemDIoTz83Iw7I0EbnpGJdL+da3bm0S5LXeZ+
 ottaPzVdCJt4qGF53k0z/ES61E+zlC9+HGgdsiGXnHQtSHHT3JaLmFO0idnAOIpqItHRuf/C9vX
 gILvVl6Nfgnwtf8txMmxURvdrgT/gTXODxV72/ipLZ5AcLrWGe3OM/BF6gQ74P1igB8iCcNZlS4
 NJc/xLHq+6+aF8H4xYqWo1K2jc7TN9IOIpzq+YpA/7oO7NMQCwaYAHxprp2mBrVtWuJi1eSceGK
 VW5RP/BMCVSpd8JtKlybIsFzgVruTYWf1l7XrQUoj1A8Yy6YfXNz+6hVwkDvGUKQ25J1OAxPXkI
 BagAbVAwfP
X-Received: by 2002:a05:7022:ea21:b0:128:f1fd:78be with SMTP id
 a92af1059eb24-12c351acbfemr1712727c88.5.1775843767818; 
 Fri, 10 Apr 2026 10:56:07 -0700 (PDT)
X-Received: by 2002:a05:7022:ea21:b0:128:f1fd:78be with SMTP id
 a92af1059eb24-12c351acbfemr1712705c88.5.1775843766921; 
 Fri, 10 Apr 2026 10:56:06 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:06 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 00/16] hexagon: add missing HVX float instructions
Date: Fri, 10 Apr 2026 10:55:48 -0700
Message-Id: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X+hi7mTe c=1 sm=1 tr=0 ts=69d939b8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=7K7JIuq7Fjm6eQbchdUA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: uXCZRKOgS6PKCmw-swYobfTY4YEVm5gH
X-Proofpoint-ORIG-GUID: uXCZRKOgS6PKCmw-swYobfTY4YEVm5gH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX6wo2TG63Fw/I
 wV7qic/G+nIUVbXlx29teeuVm5It9LIvX+6TSVILswlBDlb9308kZsPk6phG23OoLByh9YwByHW
 XYGxIClOFGFnGbR5Xej6RObEOxlkncyxS0dOTFkyALOiLZO0dg9EELuIdXLGAl1myG4RkkpcUsh
 bjFK8CM09cEOyfk9qdAYncbaSjZNuccFGvO6FHtdoIfG639p8KlkmXcotI8kGYPp+dKIsR/Prv2
 SLG//xKaCYEAejqOe30ZOh9mAHjr1Dn4jjvXzrjim4k0dOyOA/jgtLEUGuTmqem+sZCboo+7naE
 TvlCrUb/DnE41Mxq/qEculB2r7piJeTNm+eJhEmQcQB84BwjkwwI+cH42KDNdAdZ2EhHC+KbNc3
 EFia92aZDMZLbdDvKcpiQfPhAlHl98N2W1gXceWT838rrnN3lNa5FSWvvqqRwSBGJ2E35K5bNDs
 FfwWVsIJubWYEk0yXEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100168
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

v3: https://lore.kernel.org/qemu-devel/cover.1775665981.git.matheus.bernardino@oss.qualcomm.com/
v2: https://lore.kernel.org/qemu-devel/cover.1775122853.git.matheus.bernardino@oss.qualcomm.com/
v1: https://lore.kernel.org/qemu-devel/cover.1774271525.git.matheus.bernardino@oss.qualcomm.com/

Changes in v4:
  - Renamed bf_to_sf/sf_to_bf helpers to bf16_to_f32/f32_to_bf16 for
    consistency
  - Changed signatures from raw integer types (uint32_t/uint16_t) to the
    proper softfloat typedef types (float32/float16).
  - Fixed vabs_sf, which was incorrectly accessing the .hf vector field
    instead of .sf.
  - Fixed MAX_TESTS_bf
  - Removed unused gen_zero() for Q regs.
  - Added missing hex_test.h dependencies in Makefile.target
  - Added more tests for cmp insns

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

Range-diff against v3:
 1:  a04c3c5feb =  1:  1440dd86da tests/docker: Update hexagon cross toolchain to 22.1.0
 2:  c63e568f6c =  2:  b9a5a46b82 target/hexagon: fix incorrect/too-permissive HVX encodings
 3:  bd05d9aa88 !  3:  7889db953a target/hexagon/cpu: add HVX IEEE FP extension
    @@ target/hexagon/hex_common.py: def decl_tcg(self, f, tag, regno):
          def gen_write(self, f, tag):
              f.write(code_fmt(f"""\
                  gen_vreg_write_pair(ctx, {self.hvx_off()}, {self.reg_num},
    -@@ target/hexagon/hex_common.py: def decl_tcg(self, f, tag, regno):
    -                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
    -                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
    -             """))
    -+    def gen_zero(self, f):
    -+        f.write(code_fmt(f"""\
    -+            tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
    -+                sizeof(MMQReg), sizeof(MMQReg), 0);
    -+        """))
    -     def gen_write(self, f, tag):
    -         pass
    -     def helper_hvx_desc(self, f):
    -@@ target/hexagon/hex_common.py: def decl_tcg(self, f, tag, regno):
    -                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
    -                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
    -             """))
    -+    def gen_zero(self, f):
    -+        f.write(code_fmt(f"""\
    -+            tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
    -+                sizeof(MMQReg), sizeof(MMQReg), 0);
    -+        """))
    -     def gen_write(self, f, tag):
    -         pass
    -     def helper_hvx_desc(self, f):
 4:  d7cc954b23 !  4:  ac72a36fd8 hexagon: group cpu configurations in their own struct
    @@ Commit message
     
         This will be used in a follow up commit.
     
    +    Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/cpu.h ##
 5:  192fd1ca5c !  5:  e24b76d95a hexagon: print info on "-d in_asm" for disabled IEEE FP instructions
    @@ Commit message
     
         0x00020e30:  0x1f82e1c0 {       V0.sf = vadd(V1.sf,V2.sf) (disabled: no ieee_fp) }
     
    +    Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/cpu_bits.h ##
 6:  42b4b2d1c6 !  6:  8c9ded658c target/hexagon: add v68 HVX IEEE float arithmetic insns
    @@ Commit message
         - vadd_sf_sf, vsub_sf_sf, vadd_sf_hf, vsub_sf_hf: add/sub with sf output
         - vadd_hf_hf, vsub_hf_hf: add/sub with hf output
     
    +    Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/cpu.h ##
 7:  0104072468 !  7:  a89b231b2c target/hexagon: add v68 HVX IEEE float min/max insns
    @@ Commit message
         The Hexagon qfloat variants are similar to the IEEE-754 ones, but they
         handle NaN slightly differently. See comment on hvx_ieee_fp.h
     
    +    Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/mmvec/hvx_ieee_fp.h ##
    @@ target/hexagon/mmvec/hvx_ieee_fp.h: float32 fp_mult_sf_hf(float16 a1, float16 a2
                       float_status *fp_status);
      
     +/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller than -INF */
    -+uint32_t qf_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
    -+uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
    -+uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    -+uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    ++float32 qf_max_sf(float32 a1, float32 a2, float_status *fp_status);
    ++float32 qf_min_sf(float32 a1, float32 a2, float_status *fp_status);
    ++float16 qf_max_hf(float16 a1, float16 a2, float_status *fp_status);
    ++float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status);
     +
      #endif
     
    @@ target/hexagon/mmvec/hvx_ieee_fp.c: float32 fp_vdmpy(float16 a1, float16 a2, flo
     +#define float16_is_pos_nan(X) (float16_is_any_nan(X) && !float16_is_neg(X))
     +#define float16_is_neg_nan(X) (float16_is_any_nan(X) && float16_is_neg(X))
     +
    ++/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller than -INF */
     +float32 qf_max_sf(float32 a1, float32 a2, float_status *fp_status)
     +{
     +    if (float32_is_pos_nan(a1) || float32_is_neg_nan(a2)) {
 8:  2aa7f10503 !  8:  27a5ca1ce3 target/hexagon: add v68 HVX IEEE float misc insns
    @@ Commit message
         - vfneg_hf, vfneg_sf: vector floating-point negate
         - vabs_hf, vabs_sf: vector absolute value
     
    +    Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/imported/mmvec/encode_ext.def ##
    @@ target/hexagon/imported/mmvec/ext.idef: ITERATOR_INSN_ANY_SLOT_2SRC(16,vmin_hf,"
     +ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vabs_hf,  "Vd32.hf=vabs(Vu32.hf)", \
     +    "Vector IEEE abs: hf", VdV.hf[i] = float16_abs(VuV.hf[i]))
     +ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vabs_sf,  "Vd32.sf=vabs(Vu32.sf)", \
    -+    "Vector IEEE abs: sf", VdV.hf[i] = float32_abs(VuV.hf[i]))
    ++    "Vector IEEE abs: sf", VdV.sf[i] = float32_abs(VuV.sf[i]))
     +
      /******************************************************************************
       DEBUG Vector/Register Printing
 9:  99bac24648 !  9:  7fecae322c target/hexagon: add v68 HVX IEEE float conversion insns
    @@ Commit message
         - vcvt_hf_b, vcvt_hf_h, vcvt_hf_ub, vcvt_hf_uh: int to half float
         - vcvt_b_hf, vcvt_h_hf, vcvt_ub_hf, vcvt_uh_hf: half float to int
     
    +    Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/mmvec/hvx_ieee_fp.h ##
    @@ target/hexagon/mmvec/hvx_ieee_fp.h
      
      float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
      float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
    -@@ target/hexagon/mmvec/hvx_ieee_fp.h: uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
    - uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    - uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    +@@ target/hexagon/mmvec/hvx_ieee_fp.h: float32 qf_min_sf(float32 a1, float32 a2, float_status *fp_status);
    + float16 qf_max_hf(float16 a1, float16 a2, float_status *fp_status);
    + float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status);
      
     +int32_t conv_w_sf(float32 a, float_status *fp_status);
     +int16_t conv_h_hf(float16 a, float_status *fp_status);
    @@ target/hexagon/imported/mmvec/ext.idef: ITERATOR_INSN_ANY_SLOT_DOUBLE_VEC(WIDTH,
      EXTINSN(V6_##TAG, SYNTAX, ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VS,A_CVI_VS_3SRC,A_NOTE_SHIFT_RESOURCE,A_NOTE_NOVP,A_NOTE_VA_UNARY),  \
     @@ target/hexagon/imported/mmvec/ext.idef: ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vabs_hf,  "Vd32.hf=vabs(Vu32.hf)", \
      ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vabs_sf,  "Vd32.sf=vabs(Vu32.sf)", \
    -     "Vector IEEE abs: sf", VdV.hf[i] = float32_abs(VuV.hf[i]))
    +     "Vector IEEE abs: sf", VdV.sf[i] = float32_abs(VuV.sf[i]))
      
     +/* Two pipes: P2 & P3, two outputs, 16-bit */
     +#define ITERATOR_INSN_IEEE_FP_DOUBLE_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \
10:  9518dd95bd ! 10:  ebc920dfcf target/hexagon: add v68 HVX IEEE float compare insns
    @@ Commit message
         - V6_vgthf_or, V6_vgtsf_or: greater-than with predicate-or
         - V6_vgthf_xor, V6_vgtsf_xor: greater-than with predicate-xor
     
    +    Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/mmvec/hvx_ieee_fp.h ##
    -@@ target/hexagon/mmvec/hvx_ieee_fp.h: uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    +@@ target/hexagon/mmvec/hvx_ieee_fp.h: float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status);
      int32_t conv_w_sf(float32 a, float_status *fp_status);
      int16_t conv_h_hf(float16 a, float_status *fp_status);
      
     +/* IEEE - FP compare instructions */
    -+uint32_t cmpgt_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
    -+uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    ++uint32_t cmpgt_sf(float32 a1, float32 a2, float_status *fp_status);
    ++uint16_t cmpgt_hf(float16 a1, float16 a2, float_status *fp_status);
     +
      #endif
     
11:  f84d180547 ! 11:  d408ee2b2c target/hexagon: add v73 HVX IEEE bfloat16 insns
    @@ Commit message
         Conversion operations:
         - V6_vcvt_bf_sf: convert sf to bf16
     
    +    Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## target/hexagon/mmvec/hvx_ieee_fp.h ##
    @@ target/hexagon/mmvec/hvx_ieee_fp.h
     +
      #define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status)
      #define f32_to_f16(A) float32_to_float16((A), true, &env->hvx_fp_status)
    -+#define bf_to_sf(A) bfloat16_to_float32(A, &env->hvx_fp_status)
    ++#define bf16_to_f32(A) bfloat16_to_float32(A, &env->hvx_fp_status)
      
      float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
      float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
     @@ target/hexagon/mmvec/hvx_ieee_fp.h: int16_t conv_h_hf(float16 a, float_status *fp_status);
    - uint32_t cmpgt_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
    - uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
    + uint32_t cmpgt_sf(float32 a1, float32 a2, float_status *fp_status);
    + uint16_t cmpgt_hf(float16 a1, float16 a2, float_status *fp_status);
      
     +/* IEEE BFloat instructions */
     +
     +#define fp_mult_sf_bf(A, B) \
    -+    float32_mul(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status)
    ++    float32_mul(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp_status)
     +
     +#define fp_add_sf_bf(A, B) \
    -+    float32_add(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status)
    ++    float32_add(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp_status)
     +
     +#define fp_sub_sf_bf(A, B) \
    -+    float32_sub(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status)
    ++    float32_sub(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp_status)
     +
     +#define fp_mult_sf_bf_acc(f1, f2, f3) \
    -+    float32_muladd(bf_to_sf(f1), bf_to_sf(f2), f3, 0, &env->hvx_fp_status)
    ++    float32_muladd(bf16_to_f32(f1), bf16_to_f32(f2), f3, 0, &env->hvx_fp_status)
     +
    -+static inline uint16_t sf_to_bf(int32_t A, float_status *fp_status)
    ++static inline bfloat16 f32_to_bf16(float32 A, float_status *fp_status)
     +{
     +    uint32_t rslt = A;
     +    if ((rslt & 0x1FFFF) == 0x08000) {
    @@ target/hexagon/mmvec/hvx_ieee_fp.h: int16_t conv_h_hf(float16 a, float_status *f
     +}
     +
     +#define fp_min_bf(A, B) \
    -+    sf_to_bf(float32_min(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status), \
    ++    f32_to_bf16(float32_min(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp_status), \
     +             &env->hvx_fp_status);
     +
     +#define fp_max_bf(A, B) \
    -+    sf_to_bf(float32_max(bf_to_sf(A), bf_to_sf(B), &env->hvx_fp_status), \
    ++    f32_to_bf16(float32_max(bf16_to_f32(A), bf16_to_f32(B), &env->hvx_fp_status), \
     +             &env->hvx_fp_status);
     +
      #endif
    @@ target/hexagon/imported/mmvec/ext.idef: ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_h
     +    fCVI_VX_NO_TMP_LD(); fBFLOAT())
     +ITERATOR_INSN_IEEE_FP_16(32, vcvt_bf_sf,
     +    "Vd32.bf=vcvt(Vu32.sf,Vv32.sf)",   "Vector IEEE cvt: sf to bf",
    -+    VdV.bf[2*i]   = sf_to_bf(VuV.sf[i], &env->hvx_fp_status);
    -+    VdV.bf[2*i+1] = sf_to_bf(VvV.sf[i], &env->hvx_fp_status); fBFLOAT())
    ++    VdV.bf[2*i]   = f32_to_bf16(VuV.sf[i], &env->hvx_fp_status);
    ++    VdV.bf[2*i+1] = f32_to_bf16(VvV.sf[i], &env->hvx_fp_status); fBFLOAT())
     +
     +ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vmax_bf, "Vd32.bf=vmax(Vu32.bf,Vv32.bf)",
     +    "Vector IEEE max: bf", VdV.bf[i] = fp_max_bf(VuV.bf[i], VvV.bf[i]);
12:  e66f33dc97 ! 12:  cde613d444 tests/hexagon: add tests for v68 HVX IEEE float arithmetics
    @@ Metadata
      ## Commit message ##
         tests/hexagon: add tests for v68 HVX IEEE float arithmetics
     
    +    Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## tests/tcg/hexagon/hex_test.h ##
    @@ tests/tcg/hexagon/fp_hvx.c (new)
     +
     +static void test_new(void)
     +{
    -+    asm volatile("r0 = #0x2\n"
    ++    asm volatile("r0 = #%2\n"
     +                 "v0 = vsplat(r0)\n"
     +                 "vmem(%1 + #0) = v0\n"
    -+                 "r1 = #0x1\n"
    ++                 "r1 = #%3\n"
     +                 "v1 = vsplat(r1)\n"
     +                 "v2 = vsplat(r1)\n"
     +                 "{\n"
    @@ tests/tcg/hexagon/fp_hvx.c (new)
     +                 "  vmem(%0 + #0) = v0.new\n"
     +                 "}\n"
     +                 :
    -+                 : "r"(output), "r"(expect)
    ++                 : "r"(output), "r"(expect), "i"(SF_two), "i"(SF_one)
     +                 : "r0", "r1", "v0", "v1", "v2", "memory");
     +    check_output_w(__LINE__, 1);
     +}
    @@ tests/tcg/hexagon/Makefile.target: v68_hvx: CFLAGS += -mhvx -Wno-unused-function
      v69_hvx: v69_hvx.c hvx_misc.h
      v69_hvx: CFLAGS += -mhvx -Wno-unused-function
      v73_scalar: CFLAGS += -Wno-unused-function
    -+fp_hvx: fp_hvx.c hvx_misc.h
    ++fp_hvx: fp_hvx.c hvx_misc.h hex_test.h
     +fp_hvx: CFLAGS += -mhvx -mhvx-ieee-fp
    -+fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h
    ++fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h hex_test.h
     +fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
     +
     +run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
13:  5055daa72b = 13:  08abae5ee5 tests/hexagon: add tests for v68 HVX IEEE float min/max
14:  102a431804 ! 14:  c20a21aad6 tests/hexagon: add tests for v68 HVX IEEE float conversions
    @@ tests/tcg/hexagon/Makefile.target: HEX_TESTS += scatter_gather
      HEX_TESTS += fp_hvx_disabled
      HEX_TESTS += invalid-slots
      HEX_TESTS += invalid-encoding
    -@@ tests/tcg/hexagon/Makefile.target: fp_hvx: fp_hvx.c hvx_misc.h
    +@@ tests/tcg/hexagon/Makefile.target: fp_hvx: fp_hvx.c hvx_misc.h hex_test.h
      fp_hvx: CFLAGS += -mhvx -mhvx-ieee-fp
    - fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h
    + fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h hex_test.h
      fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
     +fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h hex_test.h
     +fp_hvx_cvt: CFLAGS += -mhvx -mhvx-ieee-fp
15:  a76a9a239b ! 15:  6b473acaf5 tests/hexagon: add tests for v68 HVX IEEE float comparisons
    @@ Metadata
      ## Commit message ##
         tests/hexagon: add tests for v68 HVX IEEE float comparisons
     
    +    Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## tests/tcg/hexagon/hex_test.h ##
    @@ tests/tcg/hexagon/fp_hvx_cmp.c (new)
     +    CHECK(hf, 2);
     +}
     +
    ++static void check_byte_pred(HVX_VectorPred pred, int byte_idx, uint8_t exp_mask,
    ++                            int line)
    ++{
    ++    /*
    ++     * Note: ((uint8_t *)&pred)[N] returns the expanded value of bit N:
    ++     * 0xFF if bit is set, 0x00 if clear.
    ++     */
    ++    for (int i = 0; i < 8; i++) {
    ++        int idx = byte_idx * 8 + i;
    ++        int val = ((uint8_t *)&pred)[idx];
    ++        int exp = (exp_mask >> i) & 1 ? 0xff : 0x00;
    ++        if (exp != val) {
    ++            printf("ERROR line %d: pred bit %d is 0x%x, should be 0x%x\n",
    ++                   line, idx, val, exp);
    ++            err++;
    ++        }
    ++    }
    ++}
    ++
    ++#define CHECK_BYTE_PRED(PRED, BYTE, EXP) check_byte_pred(PRED, BYTE, EXP, __LINE__)
    ++
     +static void test_cmp_variants(void)
     +{
    -+    HVX_VectorPred true_pred, false_pred, pred;
    -+    memset(&true_pred, 0xff, sizeof(true_pred));
    -+    memset(&false_pred, 0, sizeof(false_pred));
    ++    HVX_VectorPred pred;
     +
    ++    /*
    ++     * Setup: comparison result will have bits 4-7 set (0xF0 in pred byte 0)
    ++     * - sf[0]: SF_zero > SF_one = false -> bits 0-3 = 0
    ++     * - sf[1]: SF_one > SF_zero = true  -> bits 4-7 = 1
    ++     */
     +    PREP_TEST();
    -+    ADD_TEST_CMP(sf, SF_one,  SF_zero, true);
     +    ADD_TEST_CMP(sf, SF_zero, SF_one,  false);
     +    ADD_TEST_CMP(sf, SF_one,  SF_zero, true);
    -+    ADD_TEST_CMP(sf, SF_zero, SF_one,  false);
     +
    -+    /* greater and */
    -+    pred = Q6_Q_vcmp_gtand_QVsfVsf(true_pred, buffers[0], buffers[1]);
    -+    *hvx_output = Q6_V_vmux_QVV(pred, true_vec, false_vec);
    -+    for (int j = 0; j < 4; j++) {
    -+        int exp = j % 2 ? 0 : 0xffffffff;
    -+        if (output[0].sf[j] != exp) {
    -+            printf("ERROR line %d: gtand %d: expected 0x%x got 0x%x\n",
    -+                   __LINE__, j, exp, output[0].sf[j]);
    -+            err++;
    -+        }
    -+    }
    -+    pred = Q6_Q_vcmp_gtand_QVsfVsf(false_pred, buffers[0], buffers[1]);
    -+    *hvx_output = Q6_V_vmux_QVV(pred, true_vec, false_vec);
    -+    for (int j = 0; j < 4; j++) {
    -+        if (output[0].sf[j]) {
    -+            printf("ERROR line %d: gtand %d: expected false\n", __LINE__, j);
    -+            err++;
    -+        }
    -+    }
    ++    /* greater and: 0xF0 & 0xF0 = 0xF0 */
    ++    memset(&pred, 0xF0, sizeof(pred));
    ++    pred = Q6_Q_vcmp_gtand_QVsfVsf(pred, buffers[0], buffers[1]);
    ++    CHECK_BYTE_PRED(pred, 0, 0xF0);
     +
    -+    /* greater or */
    -+    pred = Q6_Q_vcmp_gtor_QVsfVsf(false_pred, buffers[0], buffers[1]);
    -+    *hvx_output = Q6_V_vmux_QVV(pred, true_vec, false_vec);
    -+    for (int j = 0; j < 4; j++) {
    -+        int exp = j % 2 ? 0 : 0xffffffff;
    -+        if (output[0].sf[j] != exp) {
    -+            printf("ERROR line %d: gtor %d: expected 0x%x got 0x%x\n",
    -+                   __LINE__, j, exp, output[0].sf[j]);
    -+            err++;
    -+        }
    -+    }
    -+    pred = Q6_Q_vcmp_gtor_QVsfVsf(true_pred, buffers[0], buffers[1]);
    -+    *hvx_output = Q6_V_vmux_QVV(pred, true_vec, false_vec);
    -+    for (int j = 0; j < 4; j++) {
    -+        if (!output[0].sf[j]) {
    -+            printf("ERROR line %d: gtor %d: expected true\n", __LINE__, j);
    -+            err++;
    -+        }
    -+    }
    ++    /* greater or: 0x0F | 0xF0 = 0xFF */
    ++    memset(&pred, 0x0F, sizeof(pred));
    ++    pred = Q6_Q_vcmp_gtor_QVsfVsf(pred, buffers[0], buffers[1]);
    ++    CHECK_BYTE_PRED(pred, 0, 0xFF);
    ++
    ++    /* greater xor: 0xFF ^ 0xF0 = 0x0F */
    ++    memset(&pred, 0xFF, sizeof(pred));
    ++    pred = Q6_Q_vcmp_gtxacc_QVsfVsf(pred, buffers[0], buffers[1]);
    ++    CHECK_BYTE_PRED(pred, 0, 0x0F);
     +}
     +
     +int main(void)
    @@ tests/tcg/hexagon/Makefile.target: HEX_TESTS += hvx_misc
      HEX_TESTS += fp_hvx_disabled
      HEX_TESTS += invalid-slots
      HEX_TESTS += invalid-encoding
    -@@ tests/tcg/hexagon/Makefile.target: fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h
    +@@ tests/tcg/hexagon/Makefile.target: fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h hex_test.h
      fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
      fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h hex_test.h
      fp_hvx_cvt: CFLAGS += -mhvx -mhvx-ieee-fp
    -+fp_hvx_cmp: fp_hvx_cmp.c hvx_misc.h
    ++fp_hvx_cmp: fp_hvx_cmp.c hvx_misc.h hex_test.h
     +fp_hvx_cmp: CFLAGS += -mhvx -mhvx-ieee-fp
      
      run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
16:  456b1863af ! 16:  10ebb63b81 tests/hexagon: add tests for HVX bfloat
    @@ Metadata
      ## Commit message ##
         tests/hexagon: add tests for HVX bfloat
     
    +    Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
         Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
     
      ## tests/tcg/hexagon/hex_test.h ##
    @@ tests/tcg/hexagon/fp_hvx_cmp.c: int err;
      
      #define MAX_TESTS_hf (MAX_VEC_SIZE_BYTES / 2)
      #define MAX_TESTS_sf (MAX_VEC_SIZE_BYTES / 4)
    -+#define MAX_TESTS_bf (MAX_VEC_SIZE_BYTES / 4)
    ++#define MAX_TESTS_bf (MAX_VEC_SIZE_BYTES / 2)
      
      #define TRUE_MASK_sf 0xffffffff
      #define TRUE_MASK_hf 0xffff
    @@ tests/tcg/hexagon/fp_hvx_cmp.c: static void test_cmp_hf(void)
          CHECK(hf, 2);
      }
      
    -+
     +static void test_cmp_bf(void)
     +{
     +    /*
    @@ tests/tcg/hexagon/fp_hvx_cmp.c: static void test_cmp_hf(void)
     +    CHECK(bf, 2);
     +}
     +
    - static void test_cmp_variants(void)
    + static void check_byte_pred(HVX_VectorPred pred, int byte_idx, uint8_t exp_mask,
    +                             int line)
      {
    -     HVX_VectorPred true_pred, false_pred, pred;
     @@ tests/tcg/hexagon/fp_hvx_cmp.c: int main(void)
      
          test_cmp_sf();
-- 
2.37.2


