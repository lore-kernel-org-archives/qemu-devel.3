Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C51F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mR0GaIPU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YafTCnOg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqo2-0005TN-21; Fri, 30 Oct 2026 13:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqnl-0005SO-Gz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:54:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqni-0007nA-Ua
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:54:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERkph3207563
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=gYTyggP7fPvSF/wdI5N7JO
 CZ13p4LJFvMnbRyJJ2JbE=; b=mR0GaIPUu2Ab5sq9J/25eNRZ/SlLEK/NM2cO/5
 NQq6hVwzotyFlPQ+3M+qVjDfs5MImZ9DP48JGiW2bErDGRyzjOxkuk42V/N+Pq0B
 In7H37Ulx9PlNqfKAAF52A+aAo99HVFYY4xlpn0i9Xv9sJL8a4ND+vyTpYUJF6NB
 05WSLgiGaEGik8kXJrZ9u2r3bl78kOn8VCIgMrWAiaaBXuVxEuEy9fjT+vgav6Sz
 UhI2Rl+Xeq48ZmSDNugK9Xuoy5L4xEdZ6xKN/sUqhciajc94akuUreIA5EbzZdtW
 O/6JR03gpLJbduwFlDvdhyG/qU66E7U3CWFRaDSy7kmqNEgQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmaae-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:01 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c84af45c8so20991106d6.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382841; x=1793987641; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gYTyggP7fPvSF/wdI5N7JOCZ13p4LJFvMnbRyJJ2JbE=;
 b=YafTCnOg3uF4UVnlhyDY5ELI9x6StSmHu36dyn2M/2GAiGiJsM66RkpYtgYya1row1
 tdVFHLkCsXn7Kq4NBMwoicX9MKzZkq+ojJvSbHCCXyMtsq/0OTP1iJl9lUYOR5q8DZOr
 qeuA732DAvTFjjcEFkGq4yTbrhhN/TIxaW+qFpqAG1sI1tM6Bm64RPHhcH/DlIIxZ+UN
 zAe8Jh6zCWZFQdf+FuW5o1qyv0oRfpUYLTO3Gfogom+MYFjqhec+K22jcn1mIjuHI7Nc
 3EHy7vWWVrOzStC6TWBVPJkKD3bDt6CXj3eGqvJqhYEDgaD1VsTWTCB4eUO8i32WhFIj
 8ZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382841; x=1793987641;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gYTyggP7fPvSF/wdI5N7JOCZ13p4LJFvMnbRyJJ2JbE=;
 b=rjwXB2GxRMCM68hFAMzvFW5QbYqqUMUmydSnXHDPeO/iYRQB0JaTDh8OpPLLcSafeK
 d9f+WwOy3BAYuqHIx9J8lly6tUtUpQ5Uuv4rv5kFapqyQ7DyiYO9/eZEbHKw+a/aZO+q
 DXoV77mBzC430M4X7M3nLGICHDO4YIeRRp0T4sKNyP3CHZLalK9+iypPREZGupDBQZ64
 w5IHJUBDZ6l0ie2UOdsrNz5djb7aX3F+OnudCnAOJM7VumbF5qIepElQ+QRWIw4LYoRY
 GQsFJiK8JpvxsROta6O+RquSmRXW2545F06Ga8s2MpUzUgR8RdLAGY8bS/QaHxjz+Ct2
 F5Hw==
X-Gm-Message-State: AFq9FYJ255Wz5gjX8rb/QWBOrKQWYUns2dwIbfkgoWR5+M0X2aouade6
 23fmiX3Pdz9DfAPjPsMIK2RD2etNsioC4V1o64pV9B/Y+zxIdjnIDruFLK+eUspgu7HGBmrqnFd
 yevdbBq4y21OqnkLzn1bctEPD9wATmhzjMz7L5pODSDintYCKF4oE59ynZBzK//30siwY
X-Gm-Gg: AYBFou2qd8eXi26wCQYv6y/MXSqiN5ePAjLQt6hE64aGc25iz04kefnU2942Ut3usbK
 mFzOy77rxvAYA58MJVmZj1QyE0wlJBinc2nlsRj3MjqLw7xhxhfx17/7DedmPFC27zWP6vQ4Qxg
 nS29gVwA1YOJxuvFqfpxaGIBwQhJyy3keozqFgyuX6bP1AwgPWiv0TXX85K25dC9McW3DjYHKK+
 ApKfxAJr5StSG+j4OFMmB2jGi+Q4bYK8s21fn3yAotXjjm2ioZvqgqwq+WfrVBs/yg5d1bV3bcV
 5kVb0H/LmJnLCcD0tw+BpXgriPBBhoUjoTvPyYc3nHJMSHW6KeTCc9YpZDe5mbCy7ZXMSzZ8wKv
 xMVM80GjNaAE4StbBJm2JWeAC5VlULKdww7Jx10TQ4odG2olJfSKR3W9SP/vpCJo/7j36mMEG83
 mFrwp5LD4ybLyfCTZw2q8CPjzEnDr6kg==
X-Received: by 2002:a05:620a:6603:b0:93f:2610:fb6f with SMTP id
 af79cd13be357-944216f0744mr505302585a.20.1793382840570; 
 Fri, 30 Oct 2026 10:54:00 -0700 (PDT)
X-Received: by 2002:a05:620a:6603:b0:93f:2610:fb6f with SMTP id
 af79cd13be357-944216f0744mr505299085a.20.1793382840026; 
 Fri, 30 Oct 2026 10:54:00 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf751c2d2sm81463125e9.15.2026.10.30.10.53.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:53:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v4 00/32] tests/tcg: Massage MIPS tests for easier maintenance
Date: Fri, 30 Oct 2026 18:53:22 +0100
Message-ID: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4d9b9 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=28VLhoCYwVMoX6u5A-8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 8gRle7-AmJqIUQaIALoh9LusFNVRkEdd
X-Proofpoint-GUID: 8gRle7-AmJqIUQaIALoh9LusFNVRkEdd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX1TOxY+aitAPv
 cRgdym7+JsRxXxSw0/0xcR1TdNNj7Ptmh6/QufKS3eL5UkU7sJWUvIQRsqTkW4eEdmqNwwkCtrp
 +tKsqGI236lPUDyr/MgCs6Bm62G5nVkYA6/N4w893lnY8fWuL3FbB5yzAugmJQUVTI1wm3qDbVt
 Tm8275wdLqUAYCO27Eh/+W3Wl0d9z4+xOV/RmftUIqRZYODPCbZt70vzfPWpvb4NGn7QOWW01eM
 83tQkK+1Uk8jrNvbefRnTXECIuswbm2vVB1pq9QliM/WwufUArui43GRhnPpo3ompWbayxEbbBr
 Zuq9cp1XOrrYWKVwbBSoXM9jhggXgosJAK58skZYnkOPQDOCIN3Cg0+HzOyD7qWrsaT/gLmmJdn
 DE0YhaEoyzZz1OpcFafuGe7T5lb7hICYtHcQ28gQ6lNB1YzUJdz5SzuYh+xYArdYHndpQVcUqpd
 qxA4tzSZ7HQSBIVFCPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX4TsfXEgyRdbc
 dqvLPi0XwEYkZ2cbYMG+DQ5p4gR4eR8EnKV+sn/eVEqJMa56h16/3SqnWw0TjKk4lz0kcnAoGBd
 qNMZx2+K6vACmKuUqthm5FTlD2iGV0I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
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

Missing review: #1

Since v3:
- removed unused header
- update to use latest TAP header correctly (rth)

Since v2:
- meson 1-line doc (pbo)
- use generic TAP header

Since v1:
- TAP (pbo)
- no more assert (pbo)
- split per group
- MSA ld/st tests

Based-on: <20261030174856.98759-1-philmd@oss.qualcomm.com>

Philippe Mathieu-Daudé (32):
  tests/tcg/mips: Remove unused test_utils_32.h
  tests/tcg/mips: Group DSP acc tests
  tests/tcg/mips: Group DSP arith tests
  tests/tcg/mips: Group DSP cmp tests
  tests/tcg/mips: Group DSP ctrl tests
  tests/tcg/mips: Group DSP dot tests
  tests/tcg/mips: Group DSP mul tests
  tests/tcg/mips: Group DSP pack tests
  tests/tcg/mips: Group DSP shift tests
  tests/tcg/mips: Group Release 6 bitops tests
  tests/tcg/mips: Group Release 6 crc tests
  tests/tcg/mips: Group Release 6 logic tests
  tests/tcg/mips: Group Release 6 multiply tests
  tests/tcg/mips: Group Release 6 shift tests
  tests/tcg/mips: Group MSA bit-count tests
  tests/tcg/mips: Group MSA bit-move tests
  tests/tcg/mips: Group MSA bit-set tests
  tests/tcg/mips: Group MSA fixed-multiply tests
  tests/tcg/mips: Group MSA float-max-min tests
  tests/tcg/mips: Group MSA int-add tests
  tests/tcg/mips: Group MSA int-average tests
  tests/tcg/mips: Group MSA int-compare tests
  tests/tcg/mips: Group MSA int-div-mod tests
  tests/tcg/mips: Group MSA int-dot-product tests
  tests/tcg/mips: Group MSA int-max-min tests
  tests/tcg/mips: Group MSA int-multiply tests
  tests/tcg/mips: Group MSA int-subtract tests
  tests/tcg/mips: Group MSA interleave tests
  tests/tcg/mips: Group MSA logic tests
  tests/tcg/mips: Group MSA pack tests
  tests/tcg/mips: Group MSA shift tests
  tests/tcg/mips: Add MSA load/store tests

 tests/tcg/mips/include/test_utils_128.h       |  32 +-
 tests/tcg/mips/include/test_utils_32.h        |  78 -----
 tests/tcg/mips/include/test_utils_64.h        |  24 +-
 tests/tcg/mipsel/test_dsp_runner.h            |  26 ++
 tests/tcg/mips/test_msa_bit_count.c           |  99 ++++++
 tests/tcg/mips/test_msa_bit_move.c            |  93 ++++++
 tests/tcg/mips/test_msa_bit_set.c             |  99 ++++++
 tests/tcg/mips/test_msa_fixed_multiply.c      |  99 ++++++
 tests/tcg/mips/test_msa_float_max_min.c       |  75 +++++
 tests/tcg/mips/test_msa_int_add.c             | 183 +++++++++++
 tests/tcg/mips/test_msa_int_average.c         | 123 +++++++
 tests/tcg/mips/test_msa_int_compare.c         | 147 +++++++++
 tests/tcg/mips/test_msa_int_div_mod.c         | 123 +++++++
 tests/tcg/mips/test_msa_int_dot_product.c     | 135 ++++++++
 tests/tcg/mips/test_msa_int_max_min.c         | 171 ++++++++++
 tests/tcg/mips/test_msa_int_multiply.c        |  99 ++++++
 tests/tcg/mips/test_msa_int_subtract.c        | 231 ++++++++++++++
 tests/tcg/mips/test_msa_interleave.c          | 123 +++++++
 tests/tcg/mips/test_msa_load_store.c          | 168 ++++++++++
 tests/tcg/mips/test_msa_logic.c               |  57 ++++
 tests/tcg/mips/test_msa_pack.c                |  99 ++++++
 tests/tcg/mips/test_msa_shift.c               | 147 +++++++++
 tests/tcg/mips64/test_mips64r6_bitops.c       |  60 ++++
 tests/tcg/mips64/test_mips64r6_crc.c          |  72 +++++
 tests/tcg/mips64/test_mips64r6_logic.c        |  48 +++
 tests/tcg/mips64/test_mips64r6_multiply.c     |  72 +++++
 tests/tcg/mips64/test_mips64r6_shift.c        |  60 ++++
 tests/tcg/mipsel/test_dsp_acc.c               | 109 +++++++
 tests/tcg/mipsel/test_dsp_arith.c             | 179 +++++++++++
 tests/tcg/mipsel/test_dsp_cmp.c               |  84 +++++
 tests/tcg/mipsel/test_dsp_ctrl.c              |  44 +++
 tests/tcg/mipsel/test_dsp_dot.c               | 154 +++++++++
 tests/tcg/mipsel/test_dsp_mul.c               |  64 ++++
 tests/tcg/mipsel/test_dsp_pack.c              | 149 +++++++++
 tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_absq_s_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_addq_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_addq_s_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_addsc.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_addu_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_addwc.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_bitrev.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_bposge32.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_extp.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_extpdp.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_extpdpv.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_extpv.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_extr_r_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_extr_s_h.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_extr_w.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_extrv_w.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_insv.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_lbux.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_lhx.c            |   1 -
 tests/tcg/mipsel/test_dsp_r1_lwx.c            |   1 -
 tests/tcg/mipsel/test_dsp_r1_madd.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_maddu.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_main.c           |   6 -
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_mfhi.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_mflo.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_modsub.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_msub.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_msubu.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_mthi.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_mthlip.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_mtlo.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_mult.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_multu.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_packrl_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_pick_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_pick_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c |   1 -
 .../tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c |   1 -
 .../tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c |   1 -
 .../tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_rddsp.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_repl_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_repl_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_replv_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_replv_qb.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_shilo.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_shilov.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_s_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_qb.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_shra_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_shra_r_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrav_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrl_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_subq_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_subq_s_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_subu_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_wrdsp.c          |   1 -
 tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_w.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_addu_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_adduh_qb.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_append.c         |   1 -
 tests/tcg/mipsel/test_dsp_r2_balign.c         |   1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_mul_ph.c         |   1 -
 tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c |   1 -
 .../tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_prepend.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_shra_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrav_qb.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrl_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_w.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_subu_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_subuh_qb.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c     |   1 -
 tests/tcg/mipsel/test_dsp_shift.c             | 124 ++++++++
 tests/tcg/mips/meson.build                    | 299 ++----------------
 tests/tcg/mips64/meson.build                  |  42 +--
 tests/tcg/mipsel/meson.build                  | 172 +---------
 198 files changed, 3583 insertions(+), 745 deletions(-)
 delete mode 100644 tests/tcg/mips/include/test_utils_32.h
 create mode 100644 tests/tcg/mipsel/test_dsp_runner.h
 create mode 100644 tests/tcg/mips/test_msa_bit_count.c
 create mode 100644 tests/tcg/mips/test_msa_bit_move.c
 create mode 100644 tests/tcg/mips/test_msa_bit_set.c
 create mode 100644 tests/tcg/mips/test_msa_fixed_multiply.c
 create mode 100644 tests/tcg/mips/test_msa_float_max_min.c
 create mode 100644 tests/tcg/mips/test_msa_int_add.c
 create mode 100644 tests/tcg/mips/test_msa_int_average.c
 create mode 100644 tests/tcg/mips/test_msa_int_compare.c
 create mode 100644 tests/tcg/mips/test_msa_int_div_mod.c
 create mode 100644 tests/tcg/mips/test_msa_int_dot_product.c
 create mode 100644 tests/tcg/mips/test_msa_int_max_min.c
 create mode 100644 tests/tcg/mips/test_msa_int_multiply.c
 create mode 100644 tests/tcg/mips/test_msa_int_subtract.c
 create mode 100644 tests/tcg/mips/test_msa_interleave.c
 create mode 100644 tests/tcg/mips/test_msa_load_store.c
 create mode 100644 tests/tcg/mips/test_msa_logic.c
 create mode 100644 tests/tcg/mips/test_msa_pack.c
 create mode 100644 tests/tcg/mips/test_msa_shift.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_bitops.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_crc.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_logic.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_multiply.c
 create mode 100644 tests/tcg/mips64/test_mips64r6_shift.c
 create mode 100644 tests/tcg/mipsel/test_dsp_acc.c
 create mode 100644 tests/tcg/mipsel/test_dsp_arith.c
 create mode 100644 tests/tcg/mipsel/test_dsp_cmp.c
 create mode 100644 tests/tcg/mipsel/test_dsp_ctrl.c
 create mode 100644 tests/tcg/mipsel/test_dsp_dot.c
 create mode 100644 tests/tcg/mipsel/test_dsp_mul.c
 create mode 100644 tests/tcg/mipsel/test_dsp_pack.c
 delete mode 100644 tests/tcg/mipsel/test_dsp_r1_main.c
 create mode 100644 tests/tcg/mipsel/test_dsp_shift.c

-- 
2.55.0


