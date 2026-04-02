Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF2CD39410
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FaZ-0004gP-0k; Thu, 02 Apr 2026 06:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaV-0004f6-Nm
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaS-0007mo-Km
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:47 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6326p30A4009504
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=1pQSC19ewjyZZTtIjDkEvptK8ZxQKMecfO0
 5nI01un4=; b=N5ev4dLxZkhJJoCfWmLc1WmKahpeH8ES82plSaNJ0OqC4farPFY
 Bs5CraqzmcJuJtsnxmF0Zj+8kn936BlAIwSZE5/OftfE0PyZK+xwASBl8s5mgRrR
 /UN0SqwqGSLCmd5spphdLHAJnow8x1OIKUxQyE9q77LzBZcbSr9Wyl/YviO7sZUp
 QeCgyjQL2nkhoTzOCSRDI/baEJ6aOlHtJIbzBHwJfnzgCgDQkzTp4zmGLvchRP3q
 Yw+dHs9uKJPKtCqDbyJbJcfUUBNNO6NJwCjzd55ELJTFlzNZl7roWN/A1t5cwPFW
 DD3QCL1tZGqWganGS6NjeJCB2feB5WjbxEQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d97e03jx4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c18175fc54so3806826eec.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126856; x=1775731656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1pQSC19ewjyZZTtIjDkEvptK8ZxQKMecfO05nI01un4=;
 b=j6zxC1qzBlIqzwf9oa4vho+zJrH6k/+oFh47FkISLWxhkmkqY4PUiCZpNQb7x7pbRq
 ldv0mJno+0xca+tySnY2VhC9zX+jqqPj91jeX83Hz0pRU0+alBOgxGJkQHvgrgcjap7n
 S/JkTSpwUnbZ0E/ATri99+cHbxrkNKpHZI5ijceA5vjtrhw+vCYDW0wi1N4FtBAntC0T
 R9IyZAZXElg+9+iV6zEHhnX4Q+/4mXH/h19WkSHTzno/SA3GQOJ16VURfs8USWBCmBsB
 RrdPth7z+JZuaTWQbbWsCWqkEMC8ysth4n0YIamUm7kFosBl/qGsKbVAq0GG3IEFivdJ
 PaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126856; x=1775731656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1pQSC19ewjyZZTtIjDkEvptK8ZxQKMecfO05nI01un4=;
 b=NvYaAp60QC6t0qCGqv4ylbXISHim/pT4PlJ25/5FBQfv0mZdC0S+renASXxcj7Nuk6
 lLIZwd4plLm8pT4+u4HcX2cgoH139MY2qiBgScCZfcI6smYrClHeloWg6oW/sBA5EzoI
 zHmjFix88/VFEn8xu1M+2efYhdXzGRVCr7Qfyaq1mU+hZW9WAuKfIcMrK6NfDC265mOF
 /0pgYNBCW23zpOyF6ap3cU3wLQzVw5cNkezJZssqAZVHw2dioapiWQsaGFSA6x5SRuB5
 3EDTrsDeqqlyxNDVKCZw4qxCXOz5RK2dE97IalLuJvz3OOjGgQrth3LcH+sbJDiRneB7
 RWmw==
X-Gm-Message-State: AOJu0YwwV1sy6NomJYjyia2FmYkwWvO8UNF/iNUl9wpD4Jgea74aMPjP
 D2Re1vXWR0BTnIFWQSR9/tmcYp1GXIvPyQKKCUO1sGKPqAZ3hiy3eU/Ut5JvjtPZsyT2ISJ8ezg
 xcfuEWi6cpFFXJV6UpL7On9OmLzxHyudeDL87HRFppjJ2wa0ukPdpXylCVTYD4nSz+mFD
X-Gm-Gg: ATEYQzyDEPFLHUCKO/jQ8vv6t6aPTWGh5/Ry/+8PtDQ09dvuS5DwJKMOBdnZemZe/uS
 VfnomRBXsLgPCEdCREHiaHd5rQKzMgeoZWWi7Pj7LaCKvuWNX6Djmt0mXLD8JWs/YQR5pNFAHKa
 BPyHsJV4jlcXGtDjzNj6GC0LFsjyR8hwEFoudGdVE8meZKlUMwYjkt+KXd70GkoWg+sMpyDyzrx
 46GL17l4mSBu5JjUxyFTNVHO+xJoIPYJSHuQ8pbMq/APgoSSS+bv7bMw/1nKUJ0oDUbTYybA3rK
 euC/4N4xUGq8xcbeR55S+re4BZnUg9rePTUoSj7O+0CriqC2t4nf79WslG0e4xD2MtJ6G8m5Y4f
 sCL7ns1ytMTAX3TLSwjUUXDAQJYHh4HZtPonZe53rB0QDOTyyHd6KOm6MHT7D0NZ4EpokTAtNvH
 Du84j8YxZw
X-Received: by 2002:a05:7300:fb8b:b0:2c1:59ea:10f7 with SMTP id
 5a478bee46e88-2c9327a3825mr3596702eec.18.1775126856242; 
 Thu, 02 Apr 2026 03:47:36 -0700 (PDT)
X-Received: by 2002:a05:7300:fb8b:b0:2c1:59ea:10f7 with SMTP id
 5a478bee46e88-2c9327a3825mr3596685eec.18.1775126855690; 
 Thu, 02 Apr 2026 03:47:35 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:35 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 00/16] hexagon: add missing HVX float instructions
Date: Thu,  2 Apr 2026 03:47:17 -0700
Message-Id: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fdGgCkQF c=1 sm=1 tr=0 ts=69ce4949 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=LQJwM_6ZSQfPnY-jlgAA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: mG2TSpQmoFvZRqDGKxaF1pIjpNzh3PFb
X-Proofpoint-GUID: mG2TSpQmoFvZRqDGKxaF1pIjpNzh3PFb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX5EirzuyH8q3n
 9RNvQBDz7T50gfCMLRw6NihDU8xP+uEDCwBXpHW85C+v1aAboU9qxNINJz+Uu3LO0+AJgX7BznZ
 1pgu68bsTYnXXNQJso8w8RdLN31bNf0H07jbUebaPWS0NYmGbIlNjL8nMRAnKcrckhI76oYLeMp
 WP6b25fAgroRfB5UED3OLaj+GYCPYO6CnT3+k34lHtycQb/XAcNH2CdNhMhI3+biiiSoIfqbqrU
 kk1I5xg1T/kgtKbTTxChv4UX3GDFgKLKiWOK9DGURICMOKy35qA3Dnv4uaByQtodsslRVbBhi4c
 yVIA1DH4AnwmQOUhkJPN2/X8hDfezSfVyv5pOKxGQ6U+gk4vRcjID4rXp18qrI0CwCHpAiYJuKl
 PnqqsBr4ChF41IXttzd54ycoFgLF90knGPYDXWnOiI3wyXHiIOsp74LlTiGU9gFV606HI9pmxrE
 cRkcZ2Rgxq0O8JZ7xYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020097
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

v1: https://lore.kernel.org/qemu-devel/cover.1774271525.git.matheus.bernardino@oss.qualcomm.com/

Changes in v2:

  - Renamed kvx_ieee.{c,h} to hvx_ieee_fp.{c,h}
  - Dedicated HVX floating-point status: Added a separate hvx_fp_status
    field in CPUArchState for HVX IEEE FP operations. This isolates HVX
    FP state from scalar FP operations and allows configuring the
    correct default NaN pattern for HVX (0x7FFF... instead of
    0xFFFF...)
  - Disabled IEEE FP behavior: When the HVX IEEE FP extension is
    disabled, instructions now zero out their destination registers
    instead of being complete no-ops. This matches actual hardware
    behavior more closely
  - Fixed NaN comparison ordering: Rewrote the comparison functions
    (fCMPGT_SF, fCMPGT_HF, fCMPGT_BF) with proper NaN ordering
    semantics: QNaN > SNaN > +Inf > numbers > -Inf > SNaN_neg >
    QNaN_neg
  - Simplified FP helper macros: Removed redundant NaN checks from
    DEF_FP_INSN_2/DEF_FP_INSN_3 macros since the softfloat library
    handles NaN propagation correctly when default_nan_mode is enabled
  - Expanded test coverage:
    - Tests to cover NaN vs NaN, NaN vs Inf, and NaN vs regular numbers
    - Added tests for vcmp_gtand/vcmp_gtor variants
    - Added bfloat tests
    - Added .new register usage tests for disabled IEEE FP

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
 target/hexagon/mmvec/hvx_ieee_fp.h            | 128 ++++++
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
 target/hexagon/mmvec/hvx_ieee_fp.c            | 275 +++++++++++++
 target/hexagon/printinsn.c                    |   7 +-
 target/hexagon/translate.c                    |   5 +-
 tests/tcg/hexagon/fp_hvx.c                    | 226 +++++++++++
 tests/tcg/hexagon/fp_hvx_cmp.c                | 279 ++++++++++++++
 tests/tcg/hexagon/fp_hvx_cvt.c                | 219 +++++++++++
 tests/tcg/hexagon/fp_hvx_disabled.c           |  57 +++
 target/hexagon/gen_tcg_funcs.py               |  11 +
 target/hexagon/hex_common.py                  |  37 ++
 target/hexagon/imported/mmvec/encode_ext.def  | 126 ++++--
 target/hexagon/imported/mmvec/ext.idef        | 363 +++++++++++++++++-
 target/hexagon/meson.build                    |   1 +
 .../dockerfiles/debian-hexagon-cross.docker   |  10 +-
 tests/tcg/hexagon/Makefile.target             |  14 +
 28 files changed, 1891 insertions(+), 48 deletions(-)
 create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.h
 create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.c
 create mode 100644 tests/tcg/hexagon/fp_hvx.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_cmp.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_cvt.c
 create mode 100644 tests/tcg/hexagon/fp_hvx_disabled.c

-- 
2.37.2


