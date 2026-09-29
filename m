Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C6FCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSS9-000330-7V; Tue, 29 Sep 2026 03:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSS7-00032O-HD
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSS3-0005o1-H7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:38 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7U4mZ4088180
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=JjCgd3wU5pn53P+OrtcCaH
 NCUozCRB4Cz9fOX935hYQ=; b=h9arJcl7Kjyw4xEU/iN1I3OAs/+DE5Fe8/94p1
 dYfLg6em0layVJtB5hkVjTHhgdGa+pGYVAdOUkMpEtAdsmSEf37zejJ9fime2l6A
 E4yureWSL/tQzgZ46majHYJ3ZmlU+lfU4gOaLqVVs2l8SjELuAtC/W+6qg5XeaGM
 twRAUepXHMmDItwqhovw1tnNnBL6HLXoYfibLSlJLvkzNxIlss6AL88WJvpHB5my
 xCdLlIGujJLzKa1ktOUkmlooMH/9uQqBZabaSlXsQWTll3ZoLQnzRmrtZmvMFbJo
 bFnz7nJrXro2AD3cHF/TUhuow1aHTLEAC3TXRQgJCiCwUEJg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4su74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:32 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso502536eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667632; x=1791272432; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JjCgd3wU5pn53P+OrtcCaHNCUozCRB4Cz9fOX935hYQ=;
 b=SBZ2DQhZ5Eey1pS8mEnmS8/VH2U1ZzFOyqYTZRKkPAZVLyVR0QDp0c6sFuRo1G3KMX
 VMOXDefe+RUQPotYtnbyqNotAG7UIc6121MdQxa0vWLLOGNwH6fUgfyTJwrN2nrQuIux
 fnfQ12F5S3FWKG9tyqCSV0l19/NQ6kSZHtRDWIUeUKfS8ZVQ78M2fAIM2pFfZYL/hEk/
 BUoLrbXsA3E0ZcBjRRhLzpXAD6Qa0sbZiQ5cSZYHa+FrKe6mq4B9WXjw+5eZEnyv2Z5Z
 Wv9VyEDlUb/5QqkOjw24ok1iEhv5nbsojfM4Azy0+qL5ry8oNcSs6reGsswXLmoQbYqH
 UpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667632; x=1791272432;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JjCgd3wU5pn53P+OrtcCaHNCUozCRB4Cz9fOX935hYQ=;
 b=URw3bG4ZvF57m49BcwGB81fEs+HZOem9xgqkOdZnbQ87XAj631ysvGu0D0YbcwQQIc
 5c+1QvNdho210UYUE0Znc7yvu3i2EwYFsULTgd8cb4WIgdVh6a02BcagCWydUTgWMnTV
 xKUs4uL2updmEQ68suEPAttVBlHkmo8vhsAp9nadDo1v3wktbDfTCCIaI0aH5JpKpaWL
 CqQpCSjCKUTqesWf+ir+pPde0sjvELz3XvZ32cXYa1+gZN/GhTfcQWS3BOAvRiVnnDFr
 6womIKi6SdrPw1GsBc8NiIHKHuD0pnn9xJZsdzlSsWPJC2A0FcHn8TBQ7MCrmWIm3VpP
 /XwA==
X-Gm-Message-State: AFq9FYIAOyQXajzlzer9+9nH45qJFr0dQ6lfHsM7FLkPs/zKidEc/+MM
 xAJvo71TXlWgiD7q04Cyra8v23VsOo6uknWjyvAJMe+8l9wLSHKtsclUohy7+xJeBFnUijFjK9E
 mrkrF6oiJkirIDLA/1eT/riNyK/K3alY31vscWoY1MSma6mpH4gQqlEOOiYyoD882KA==
X-Gm-Gg: AYBFou17WB0yFiwO+Nq26Q5Uq2j/dQtLRN/LTIcAECJLeLkQXt3p3phfDdfg67UEmTY
 Xv6YV5AmttVLUsa+jkaFHbmbq7Z3+QjHca7BQ/7WvePBtKEREN0zY8Plyu61DZS36gbXWwJvBkK
 uRdNwzm+fNtHLBYTbu4FuOfj9x+ZmFEqPuzz7Vb419/D7kN9NIsHKAZMPQTjbl6YNDPajO82Nyv
 11b305Un4/Ul/PeBJE34tfaOlD6kXsnfuwm6mCHyx3ZZTK+TUdI+BIgDdpkXWV3Ksv67k3z3rXG
 0v60R0ivghwlH40vqNK9xWunmcmNVJ3VNeDUOTX2JKv/3BwnMeR5zsL8AHvMNe03B5eSf5RVINv
 pA6+Gup/0w6JRVzA+aWz7G6ThqEz7ciyMCh+Qz1mK5IhL0bgcF9vlhKhiGQ==
X-Received: by 2002:a05:7300:e11a:b0:342:4d8:ccd9 with SMTP id
 5a478bee46e88-3427236efedmr13862405eec.27.1790667631259; 
 Tue, 29 Sep 2026 00:40:31 -0700 (PDT)
X-Received: by 2002:a05:7300:e11a:b0:342:4d8:ccd9 with SMTP id
 5a478bee46e88-3427236efedmr13862344eec.27.1790667630367; 
 Tue, 29 Sep 2026 00:40:30 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 00/19] tcg/tests: integrate rest of mips tests
Date: Tue, 29 Sep 2026 07:39:48 +0000
Message-ID: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX9nF5P0bHA2V4
 VdMvS7qEt2YflGveEKveyXzEc1baPqTyr0dxGjvyW/rfwFtFjmpKBYMN/Ykk8TBIkxMpeEDkt4F
 6BLHbt6QfRl4cFv/Idhn8lst9jYq9j8=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abb6b70 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=idCEyl8koMNDwFdoXOwA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfXzju9eluzGHKn
 wnMTNwucjHd72cBfeNpVdW5X1m6rdO860hGNcRa9Nhtg2Tp4dNNaxkQesFQBCvBjQnYLaMOsdZR
 TyucZ7OAfMZdPDNDng/cEoAmFqE/zxysmzPV28dHyGuOccO7vElLYU6B3TE7aOO4k5Yl5/0qvBS
 lfxPLmIWwMLsy2kWZEW6zu4qmhlwlUkzMFSFXQMQZrrQFJV0OCdZPL3xsf1y62gzzIUpA8GcJ5t
 nmbx9ahdXbOlK/fpwP17D+tqGPyJ4klp8bWhYdIoasyNKJxpU4EHOFEHWQfbXPkarjD5u7b5Vq2
 g7PJqHdQs2pk7L5EDpQd5Fh/WVTIh0Wz+W8zvWtFG8193MCh3Szvyv6KgGol4QUYYB2bjSmqXvM
 iRydkXFuN3ZyljvTJG4J9by8uSI3Xy68LvwbnXzad9iIx+RJpiapjDRH/gTDI0k1T+ItfAJUT5q
 CNceZIbddT+HzfMya1A==
X-Proofpoint-GUID: J81aLsx_ewf8xn1-n4nv7dK6ebEmVmZ7
X-Proofpoint-ORIG-GUID: J81aLsx_ewf8xn1-n4nv7dK6ebEmVmZ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290030
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

This series integrates tests from tests/tcg/mips/user/, and also adds
multiarch tests for mipsel target.

v2
--
- add all tests from tests/tcg/mips/user/isa
- move octeon test to mips64 folder
- add mips64r6 tests (and fix them)
- add README for r5900 tests that we can't run

v1
--
- add tests from tests/tcg/mips/user/ase/dsp

Pierrick Bouvier (19):
  tests/tcg/mipsel: move dsp sources
  tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c: fix compilation warning
  tests/tcg/mipsel: add dsp tests
  tests/tcg/mipsel: add float reference files
  tests/tcg/mipsel: add multiarch tests
  tests/tcg/mips64: move octeon test here
  tests/tcg/mips/user/isa/r5900: add README
  tests/tcg/mips64*/meson.build: remove unused cc_feat
  tests/tcg/mips64: move mips64r6 sources
  tests/tcg/mips64/test_mips64r6: fix include path
  tests/docker/dockerfiles/debian-all-test: add mips64r6 toolchains
  tests/tcg/mips/include/wrappers_mips64r6.h: add missing wrappers for
    and, nor, or, xor insn
  tests/tcg/mips/include/wrappers_mips64r6.h: use proper types for
    parameters
  tests/tcg/mips64/test_mips64r6: fix call to check_results_64
  tests/tcg/mips/include/test_utils_64.h: add check_binary_op_64
  tests/tcg/mips64/mips64r6: update failing tests to use
    check_binary_op_64
  target/mips/tcg/translate: add sign extension for srav
  tests/tcg/mips64/mips64r6: update references
  tests/tcg/mips64: add mips64r6(el) tests

 meson_options.txt                             |  12 +
 scripts/meson-buildoptions.sh                 |   6 +
 target/mips/tcg/translate.c                   |   1 +
 .../dockerfiles/debian-all-test-cross.docker  |   4 +
 tests/lcitool/refresh                         |   4 +
 tests/tcg/meson.build                         |   1 +
 tests/tcg/mips/include/test_utils_64.h        |  40 +
 tests/tcg/mips/include/wrappers_mips64r6.h    |  22 +-
 tests/tcg/mips/user/ase/dsp/Makefile          | 184 ----
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  40 -
 .../isa/mips64r6/logic/test_mips64r6_and.c    | 153 ---
 .../isa/mips64r6/logic/test_mips64r6_nor.c    | 153 ---
 .../isa/mips64r6/logic/test_mips64r6_or.c     | 153 ---
 .../isa/mips64r6/logic/test_mips64r6_xor.c    | 153 ---
 .../isa/mips64r6/shift/test_mips64r6_srav.c   | 153 ---
 tests/tcg/mips/user/isa/r5900/README          |   6 +
 tests/tcg/mips64/meson.build                  |  60 +-
 .../user/isa/octeon => mips64}/octeon-insns.c |   0
 tests/tcg/mips64/test_mips64r6_and.c          | 118 +++
 .../test_mips64r6_bitswap.c                   |   9 +-
 .../bit-count => mips64}/test_mips64r6_clo.c  |   9 +-
 .../bit-count => mips64}/test_mips64r6_clz.c  |   9 +-
 .../crc => mips64}/test_mips64r6_crc32b.c     |  12 +-
 .../crc => mips64}/test_mips64r6_crc32cb.c    |  12 +-
 .../crc => mips64}/test_mips64r6_crc32cd.c    |  12 +-
 .../crc => mips64}/test_mips64r6_crc32ch.c    |  12 +-
 .../crc => mips64}/test_mips64r6_crc32cw.c    |  12 +-
 .../crc => mips64}/test_mips64r6_crc32d.c     |  12 +-
 .../crc => mips64}/test_mips64r6_crc32h.c     |  12 +-
 .../crc => mips64}/test_mips64r6_crc32w.c     |  12 +-
 .../test_mips64r6_dbitswap.c                  |   9 +-
 .../bit-count => mips64}/test_mips64r6_dclo.c |   9 +-
 .../bit-count => mips64}/test_mips64r6_dclz.c |   9 +-
 .../test_mips64r6_dmuh.c                      |   9 +-
 .../test_mips64r6_dmuhu.c                     |   9 +-
 .../test_mips64r6_dmul.c                      |   9 +-
 .../test_mips64r6_dmulu.c                     |   9 +-
 .../shift => mips64}/test_mips64r6_dsllv.c    |   9 +-
 .../shift => mips64}/test_mips64r6_dsrav.c    |   9 +-
 .../shift => mips64}/test_mips64r6_dsrlv.c    |   9 +-
 .../test_mips64r6_muh.c                       |   9 +-
 .../test_mips64r6_muhu.c                      |   9 +-
 .../test_mips64r6_mul.c                       |   9 +-
 .../test_mips64r6_mulu.c                      |   9 +-
 tests/tcg/mips64/test_mips64r6_nor.c          | 118 +++
 tests/tcg/mips64/test_mips64r6_or.c           | 118 +++
 .../shift => mips64}/test_mips64r6_sllv.c     |   9 +-
 tests/tcg/mips64/test_mips64r6_srav.c         | 118 +++
 .../shift => mips64}/test_mips64r6_srlv.c     |   9 +-
 tests/tcg/mips64/test_mips64r6_xor.c          | 118 +++
 tests/tcg/mips64el/meson.build                |  12 +-
 tests/tcg/mipsel/float_convd.ref              | 988 ++++++++++++++++++
 tests/tcg/mipsel/float_convs.ref              | 748 +++++++++++++
 tests/tcg/mipsel/float_madds.ref              | 768 ++++++++++++++
 tests/tcg/mipsel/meson.build                  | 191 ++++
 .../dsp => mipsel}/test_dsp_r1_absq_s_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_absq_s_w.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_addq_ph.c  |   0
 .../dsp => mipsel}/test_dsp_r1_addq_s_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_addq_s_w.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_addsc.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_addu_qb.c  |   0
 .../dsp => mipsel}/test_dsp_r1_addu_s_qb.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_addwc.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_bitrev.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_bposge32.c |   0
 .../dsp => mipsel}/test_dsp_r1_cmp_eq_ph.c    |   0
 .../dsp => mipsel}/test_dsp_r1_cmp_le_ph.c    |   0
 .../dsp => mipsel}/test_dsp_r1_cmp_lt_ph.c    |   0
 .../dsp => mipsel}/test_dsp_r1_cmpgu_eq_qb.c  |   0
 .../dsp => mipsel}/test_dsp_r1_cmpgu_le_qb.c  |   0
 .../dsp => mipsel}/test_dsp_r1_cmpgu_lt_qb.c  |   0
 .../dsp => mipsel}/test_dsp_r1_cmpu_eq_qb.c   |   0
 .../dsp => mipsel}/test_dsp_r1_cmpu_le_qb.c   |   0
 .../dsp => mipsel}/test_dsp_r1_cmpu_lt_qb.c   |   0
 .../dsp => mipsel}/test_dsp_r1_dpaq_s_w_ph.c  |   0
 .../dsp => mipsel}/test_dsp_r1_dpaq_sa_l_w.c  |   0
 .../dsp => mipsel}/test_dsp_r1_dpau_h_qbl.c   |   0
 .../dsp => mipsel}/test_dsp_r1_dpau_h_qbr.c   |   0
 .../dsp => mipsel}/test_dsp_r1_dpsq_s_w_ph.c  |   0
 .../dsp => mipsel}/test_dsp_r1_dpsq_sa_l_w.c  |   0
 .../dsp => mipsel}/test_dsp_r1_dpsu_h_qbl.c   |   0
 .../dsp => mipsel}/test_dsp_r1_dpsu_h_qbr.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_extp.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_extpdp.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_extpdpv.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_extpv.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_extr_r_w.c |   0
 .../dsp => mipsel}/test_dsp_r1_extr_rs_w.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_extr_s_h.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_extr_w.c   |   0
 .../dsp => mipsel}/test_dsp_r1_extrv_r_w.c    |   0
 .../dsp => mipsel}/test_dsp_r1_extrv_rs_w.c   |   2 +-
 .../dsp => mipsel}/test_dsp_r1_extrv_s_h.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_extrv_w.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_insv.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_lbux.c     |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_lhx.c |   0
 .../user/ase/dsp => mipsel}/test_dsp_r1_lwx.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_madd.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_maddu.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_main.c     |   0
 .../dsp => mipsel}/test_dsp_r1_maq_s_w_phl.c  |   0
 .../dsp => mipsel}/test_dsp_r1_maq_s_w_phr.c  |   0
 .../dsp => mipsel}/test_dsp_r1_maq_sa_w_phl.c |   0
 .../dsp => mipsel}/test_dsp_r1_maq_sa_w_phr.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_mfhi.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_mflo.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_modsub.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_msub.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_msubu.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_mthi.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_mthlip.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_mtlo.c     |   0
 .../test_dsp_r1_muleq_s_w_phl.c               |   0
 .../test_dsp_r1_muleq_s_w_phr.c               |   0
 .../test_dsp_r1_muleu_s_ph_qbl.c              |   0
 .../test_dsp_r1_muleu_s_ph_qbr.c              |   0
 .../dsp => mipsel}/test_dsp_r1_mulq_rs_ph.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_mult.c     |   0
 .../ase/dsp => mipsel}/test_dsp_r1_multu.c    |   0
 .../dsp => mipsel}/test_dsp_r1_packrl_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_pick_ph.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_pick_qb.c  |   0
 .../dsp => mipsel}/test_dsp_r1_preceq_w_phl.c |   0
 .../dsp => mipsel}/test_dsp_r1_preceq_w_phr.c |   0
 .../test_dsp_r1_precequ_ph_qbl.c              |   0
 .../test_dsp_r1_precequ_ph_qbla.c             |   0
 .../test_dsp_r1_precequ_ph_qbr.c              |   0
 .../test_dsp_r1_precequ_ph_qbra.c             |   0
 .../test_dsp_r1_preceu_ph_qbl.c               |   0
 .../test_dsp_r1_preceu_ph_qbla.c              |   0
 .../test_dsp_r1_preceu_ph_qbr.c               |   0
 .../test_dsp_r1_preceu_ph_qbra.c              |   0
 .../dsp => mipsel}/test_dsp_r1_precrq_ph_w.c  |   0
 .../dsp => mipsel}/test_dsp_r1_precrq_qb_ph.c |   0
 .../test_dsp_r1_precrq_rs_ph_w.c              |   0
 .../test_dsp_r1_precrqu_s_qb_ph.c             |   0
 .../dsp => mipsel}/test_dsp_r1_raddu_w_qb.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_rddsp.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_repl_ph.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_repl_qb.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_replv_ph.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_replv_qb.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shilo.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shilov.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shll_ph.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shll_qb.c  |   0
 .../dsp => mipsel}/test_dsp_r1_shll_s_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shll_s_w.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shllv_ph.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shllv_qb.c |   0
 .../dsp => mipsel}/test_dsp_r1_shllv_s_ph.c   |   0
 .../dsp => mipsel}/test_dsp_r1_shllv_s_w.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shra_ph.c  |   0
 .../dsp => mipsel}/test_dsp_r1_shra_r_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shra_r_w.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shrav_ph.c |   0
 .../dsp => mipsel}/test_dsp_r1_shrav_r_ph.c   |   0
 .../dsp => mipsel}/test_dsp_r1_shrav_r_w.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shrl_qb.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r1_shrlv_qb.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_subq_ph.c  |   0
 .../dsp => mipsel}/test_dsp_r1_subq_s_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_subq_s_w.c |   0
 .../ase/dsp => mipsel}/test_dsp_r1_subu_qb.c  |   0
 .../dsp => mipsel}/test_dsp_r1_subu_s_qb.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r1_wrdsp.c    |   0
 .../dsp => mipsel}/test_dsp_r2_absq_s_qb.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r2_addqh_ph.c |   0
 .../dsp => mipsel}/test_dsp_r2_addqh_r_ph.c   |   0
 .../dsp => mipsel}/test_dsp_r2_addqh_r_w.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r2_addqh_w.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r2_addu_ph.c  |   0
 .../dsp => mipsel}/test_dsp_r2_addu_s_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r2_adduh_qb.c |   0
 .../dsp => mipsel}/test_dsp_r2_adduh_r_qb.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r2_append.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r2_balign.c   |   0
 .../dsp => mipsel}/test_dsp_r2_cmpgdu_eq_qb.c |   0
 .../dsp => mipsel}/test_dsp_r2_cmpgdu_le_qb.c |   0
 .../dsp => mipsel}/test_dsp_r2_cmpgdu_lt_qb.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_dpa_w_ph.c |   0
 .../dsp => mipsel}/test_dsp_r2_dpaqx_s_w_ph.c |   0
 .../test_dsp_r2_dpaqx_sa_w_ph.c               |   0
 .../dsp => mipsel}/test_dsp_r2_dpax_w_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r2_dps_w_ph.c |   0
 .../dsp => mipsel}/test_dsp_r2_dpsqx_s_w_ph.c |   0
 .../test_dsp_r2_dpsqx_sa_w_ph.c               |   0
 .../dsp => mipsel}/test_dsp_r2_dpsx_w_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r2_mul_ph.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r2_mul_s_ph.c |   0
 .../dsp => mipsel}/test_dsp_r2_mulq_rs_w.c    |   0
 .../dsp => mipsel}/test_dsp_r2_mulq_s_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r2_mulq_s_w.c |   0
 .../dsp => mipsel}/test_dsp_r2_mulsa_w_ph.c   |   0
 .../test_dsp_r2_mulsaq_s_w_ph.c               |   0
 .../dsp => mipsel}/test_dsp_r2_precr_qb_ph.c  |   0
 .../test_dsp_r2_precr_sra_ph_w.c              |   0
 .../test_dsp_r2_precr_sra_r_ph_w.c            |   0
 .../ase/dsp => mipsel}/test_dsp_r2_prepend.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r2_shra_qb.c  |   0
 .../dsp => mipsel}/test_dsp_r2_shra_r_qb.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r2_shrav_qb.c |   0
 .../dsp => mipsel}/test_dsp_r2_shrav_r_qb.c   |   0
 .../ase/dsp => mipsel}/test_dsp_r2_shrl_ph.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r2_shrlv_ph.c |   0
 .../ase/dsp => mipsel}/test_dsp_r2_subqh_ph.c |   0
 .../dsp => mipsel}/test_dsp_r2_subqh_r_ph.c   |   0
 .../dsp => mipsel}/test_dsp_r2_subqh_r_w.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r2_subqh_w.c  |   0
 .../ase/dsp => mipsel}/test_dsp_r2_subu_ph.c  |   0
 .../dsp => mipsel}/test_dsp_r2_subu_s_ph.c    |   0
 .../ase/dsp => mipsel}/test_dsp_r2_subuh_qb.c |   0
 .../dsp => mipsel}/test_dsp_r2_subuh_r_qb.c   |   0
 215 files changed, 3585 insertions(+), 1126 deletions(-)
 delete mode 100644 tests/tcg/mips/user/ase/dsp/Makefile
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
 create mode 100644 tests/tcg/mips/user/isa/r5900/README
 rename tests/tcg/{mips/user/isa/octeon => mips64}/octeon-insns.c (100%)
 create mode 100644 tests/tcg/mips64/test_mips64r6_and.c
 rename tests/tcg/{mips/user/isa/mips64r6/bit-swap => mips64}/test_mips64r6_bitswap.c (94%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_clo.c (94%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_clz.c (94%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32b.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cb.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cd.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32ch.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32cw.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32d.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32h.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/crc => mips64}/test_mips64r6_crc32w.c (93%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-swap => mips64}/test_mips64r6_dbitswap.c (94%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_dclo.c (94%)
 rename tests/tcg/{mips/user/isa/mips64r6/bit-count => mips64}/test_mips64r6_dclz.c (94%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmuh.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmuhu.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmul.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_dmulu.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsllv.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsrav.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_dsrlv.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_muh.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_muhu.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_mul.c (95%)
 rename tests/tcg/{mips/user/isa/mips64r6/int-multiply => mips64}/test_mips64r6_mulu.c (95%)
 create mode 100644 tests/tcg/mips64/test_mips64r6_nor.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_or.c
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_sllv.c (95%)
 create mode 100644 tests/tcg/mips64/test_mips64r6_srav.c
 rename tests/tcg/{mips/user/isa/mips64r6/shift => mips64}/test_mips64r6_srlv.c (95%)
 create mode 100644 tests/tcg/mips64/test_mips64r6_xor.c
 create mode 100644 tests/tcg/mipsel/float_convd.ref
 create mode 100644 tests/tcg/mipsel/float_convs.ref
 create mode 100644 tests/tcg/mipsel/float_madds.ref
 create mode 100644 tests/tcg/mipsel/meson.build
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_absq_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_absq_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addsc.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addu_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addu_s_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addwc.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_bitrev.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_bposge32.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_eq_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_le_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_lt_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_eq_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_le_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_lt_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_eq_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_le_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_lt_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpaq_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpaq_sa_l_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsq_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsq_sa_l_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extp.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpdp.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpdpv.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpv.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_rs_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_s_h.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_rs_w.c (97%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_s_h.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_insv.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lbux.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lhx.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lwx.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_madd.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maddu.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_main.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mfhi.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mflo.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_modsub.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_msub.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_msubu.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mthi.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mthlip.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mtlo.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mulq_rs_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mult.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_multu.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_packrl_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_pick_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_pick_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceq_w_phl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceq_w_phr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbla.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbra.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbla.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbra.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_ph_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_qb_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_rs_ph_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrqu_s_qb_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_raddu_w_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_rddsp.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_repl_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_repl_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_replv_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_replv_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shilo.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shilov.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_r_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_r_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrl_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrlv_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subu_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subu_s_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_wrdsp.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_absq_s_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_r_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addu_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addu_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_adduh_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_adduh_r_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_append.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_balign.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_eq_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_le_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_lt_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpa_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpaqx_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpaqx_sa_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpax_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dps_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsqx_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsqx_sa_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsx_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mul_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mul_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_rs_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulsa_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulsaq_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_qb_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_sra_ph_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_sra_r_ph_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_prepend.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shra_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shra_r_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrav_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrav_r_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrl_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrlv_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_r_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subu_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subu_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subuh_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subuh_r_qb.c (100%)

-- 
2.43.0


