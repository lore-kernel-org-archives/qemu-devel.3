Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8031606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RnT+8FnY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gdT41rcq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMo7W-000787-R9; Fri, 30 Oct 2026 11:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo7V-00077j-BN
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:02:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo7S-00075h-ME
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:02:17 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER6sQ346859
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=841d6T5vcaSoL+73zbU7v8
 Q2tz7pof0IEJ79Xj8ZBqA=; b=RnT+8FnYJnVhf1aQPykKW8DHZDcNBCMAPagcNy
 1hzukT10NvikPdSpnVhDunmKFdw3MSL7anPwzjjXaMZNoiBOblE7Jl7I5Kr7t3Zf
 UA/wQ4cwDM4DYfmxXnj6VAxrG/jkMWcRth7CDXeESzym9mnRExSMs5xjIF5c3zea
 dVXXVtcofwnV1VbGVXaRfgBhMgSsBuNE8/fon4rHgmDQJtMcUH3WGspBTeBuajy7
 X28M90XVTNtzgWyS9lyPtujkF4WM3gMm53C7624QULQVKmWjZFDKYnh6PKi9+BkZ
 Cly/uWMT1dD1l/2gv2iEPvAJZZHPOof5Y0R8nY5d6xJUAw7A==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rkqrh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:02:08 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5eac4de614aso706971e0c.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372527; x=1793977327; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=841d6T5vcaSoL+73zbU7v8Q2tz7pof0IEJ79Xj8ZBqA=;
 b=gdT41rcq9iMoXzh58SzOtQp94a2rgh9GcSBUpIXgKtqTi+0FyEaRmE2DnIugSTBSbr
 s64jmhN3m7yT1McHb6YcD3WUEMjJ0dYEq2/yC+L8P+f5Q1yBNCbXKbu7bFsLRYB6Tyuv
 PxDy8Yt/AF6XSk3XFSeXp2gDypqMV9hZUL2aWqEbW9bVFz+cP1P3UG1CMAq4c96FxYpa
 /oaGs9w4SookD1au0/7R+Fzt0LYC6t26bVG1dEV1J3VY1fBuUqIdirDhbSHp8ZZDGJKm
 Rbm+xdlpdzOANEVpMJYcCtkydJfW5xDsQ50LVrUqGEa6lFp22h8tUSWlsWtjZI5b5VsF
 RCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372527; x=1793977327;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=841d6T5vcaSoL+73zbU7v8Q2tz7pof0IEJ79Xj8ZBqA=;
 b=eR96MvxHs8cntsDiqDrcDMquCsJDPkyRaAgkysZKdbp+AVF00Cp7hVeeYoLWHDCBZU
 FpWn+/EPFlmdGvOgtg/FyhW8Z5ejtYwiB3xTgYQJP3BPYQf+Mw31/fu9U9fwSGwCEQ3V
 R38tKK8Z6viercha+YBhuqSvcm01CLo+9OKymsmPyg8j8GELNGVTGRWnkBWX8AGE4cw9
 NwweVPNMWKMQKRE8fSM5tKqG2MvCkhc+NCupmhF4uaJWfjQSYHYr7SPXk/RYdP9CuIP9
 1Vf05wkUXVHyjnEMNFxhIRYf+jdxOPyhd5LJ6dRUs7JHpJNspfnCWehZuNhuT2CUe192
 8xMA==
X-Gm-Message-State: AFq9FYJoD5krnKppVsHh3FoFlaJOGcK2t/gC59DyY4IR9DJNuZq1MZR4
 gLw/h7ja4X3JWurNEz9FwTdzKVYSKqYYdR4YNk1ZB/LvOF3k1OcD+euBtXX9/pcyLoZVlBqd4fS
 xPDXwqoZYKi7jeeb4HQOnHZFYdOxX8KIyG7H8ltLinrZ7pgx7dUezXZZwrXM7tF7h1qb9
X-Gm-Gg: AYBFou26RAVrRS7T78aCBgJZuKZRtTR8hpZ+mkVU3nPRxPtz4xL1IkdRLVHR1oWLRXF
 CCOsRkTct+kuVBhAab4qI5Zlhk1Ww23csS0WSg3qrvbh49FJJuBuS7ioSRcdTIOm56IBcoX7JBg
 9TTSxo4hpAOA6yIqZLOxd+FKQVubItMSEtTi6CEC4Sr8Nx2RPghAbEDTTVtSbo0zwmMh9Rf0vHB
 zBr8SI6NKiAHXj2/jlK0EqBy158VY4pqJe+6eIbrbGKHcDokDgG3VceorHZJqk0Un0xHJrMhTjY
 Kwq9bPFTg6tgr+n4ztl2OVhkQVORVT3U842DRk4PVFHWsKbxz8UP5o0b+sHQn2by9Oc+yWH47BY
 n7Lx/rjRtMybrufwDa4iIzuiGB3IBnDTbbtNO1TgRxRVYoeIVtha//WvXNf4suTzlZhzfB5dJ8H
 Tz6hn9ak6M30v2N29H0CfetDjKC4EwEw==
X-Received: by 2002:a05:6123:107:b0:5ea:ea07:b119 with SMTP id
 71dfb90a1353d-5ec68963642mr1519541e0c.16.1793372526922; 
 Fri, 30 Oct 2026 08:02:06 -0700 (PDT)
X-Received: by 2002:a05:6123:107:b0:5ea:ea07:b119 with SMTP id
 71dfb90a1353d-5ec68963642mr1519376e0c.16.1793372525493; 
 Fri, 30 Oct 2026 08:02:05 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3cesm3952174f8f.7.2026.10.30.08.02.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:02:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/31] tests/tcg: Massage MIPS tests for easier maintenance
Date: Fri, 30 Oct 2026 16:01:30 +0100
Message-ID: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SrDWUEn4keG230NKsyZKDws7fcQ5YVa1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX3pYk7YBZ+7lN
 Lgm2t00OVjVymoLLuiia2/ODLFk4NLlshvNJQ3AAiS7kgGcZlbYIocJcxRAMHjh1RnAbPi8VDQ2
 PoAiaRBQTxeSYsuFIKs4mWar4WJcZDk=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae4b170 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=jZrkaVxyW7hlrTSUV-EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX+gDM1zZLBWK9
 lqed24jKTsHE+yjnAbUODVCwvJ26I6cfFRPKaPaqHsrEf9Q1mkanOk5V0kAJMmrwtoY88iKhuQ2
 KhgiZe4o5UZQ2cfq+fS+0Ar5okZ8l23GA9bPtj+qJUR3EEHIJJlbAfWzeA7NsiJSGHA0EXzxhWP
 Uu/SUAg/++yma0WKsUePZ2bmY6YduCFvuLNo1tWChMck1NDpTy2aRbled0tSFWF9zY2r+kntG4E
 WzvlqNnTCSXbd5je+Q4ZcyKAspTesL5rWf4aEzskjX+RAdOSTkgtKHoAUC5+5B8yGiaQeFxV5a5
 q/Qh2E6rhAmGdJIGrGkGjqrUgVeYwgvaWyvc7VP3nVc1CP0n3S1IFKqOtVjZQHfO0NcjAsihrAJ
 3QQIR1OH/EUDOs4kjzgby+akAEp8W4HHPMQDVEcRYwmwCSW5fkL89e2Rx/ZjmqfcuYsmsffHB0q
 /32NxKG1Y5/4Njv1Rfw==
X-Proofpoint-GUID: SrDWUEn4keG230NKsyZKDws7fcQ5YVa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Series fully reviewed, will be included in next mips PR.

I'm glad we have many MIPS tests but they are in too
many files, taking time to get compiled. In particular
on Aarch64 host via x86_64 docker image... Group the
test in order to reduce CI build time.

But per v1 review "We can't trade usability for faster
compilation", so convert to run one test at a time --
not exiting on the first assert() -- and use TAP
protocol to get integrated with meson. For example we
can now list each opcode as a TAP subtest with:

  $ meson test --suite tcg-mipsel -v

Now as a maintainer I can relax a bit :)

Since v2:
- meson 1-line doc (pbo)
- use generic TAP header

Since v1:
- TAP (pbo)
- no more assert (pbo)
- split per group
- MSA ld/st tests

Based-on: <20261030145218.58385-1-philmd@oss.qualcomm.com>

Philippe Mathieu-Daudé (31):
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

 tests/tcg/mips/include/test_utils_128.h       |   2 +-
 tests/tcg/mips/include/test_utils_64.h        |   6 +-
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
 tests/tcg/mips/test_msa_load_store.c          | 163 ++++++++++
 tests/tcg/mips/test_msa_logic.c               |  57 ++++
 tests/tcg/mips/test_msa_pack.c                |  99 ++++++
 tests/tcg/mips/test_msa_shift.c               | 147 +++++++++
 tests/tcg/mips64/test_mips64r6_bitops.c       |  60 ++++
 tests/tcg/mips64/test_mips64r6_crc.c          |  72 +++++
 tests/tcg/mips64/test_mips64r6_logic.c        |  48 +++
 tests/tcg/mips64/test_mips64r6_multiply.c     |  72 +++++
 tests/tcg/mips64/test_mips64r6_shift.c        |  60 ++++
 tests/tcg/mipsel/test_dsp_acc.c               | 108 +++++++
 tests/tcg/mipsel/test_dsp_arith.c             | 178 +++++++++++
 tests/tcg/mipsel/test_dsp_cmp.c               |  83 +++++
 tests/tcg/mipsel/test_dsp_ctrl.c              |  43 +++
 tests/tcg/mipsel/test_dsp_dot.c               | 153 +++++++++
 tests/tcg/mipsel/test_dsp_mul.c               |  63 ++++
 tests/tcg/mipsel/test_dsp_pack.c              | 148 +++++++++
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
 tests/tcg/mipsel/test_dsp_shift.c             | 123 +++++++
 tests/tcg/mips/meson.build                    | 299 ++----------------
 tests/tcg/mips64/meson.build                  |  42 +--
 tests/tcg/mipsel/meson.build                  | 172 +---------
 197 files changed, 3548 insertions(+), 641 deletions(-)
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


