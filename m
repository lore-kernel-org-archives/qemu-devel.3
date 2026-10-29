Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F8606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PVGtKfRR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d7S6k9JM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTqb-0005Lx-Gb; Thu, 29 Oct 2026 13:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTqZ-0005LV-Kx
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:23:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTqX-0000z5-06
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:23:27 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGCxF21619565
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zZghyqVMgNO1BxXvTNnkXh
 w/WOYhZKinTP6qrJN9EZY=; b=PVGtKfRRz8wYfWkE90I98snY73wvSae5psLrLl
 yR8xRfSNYqxSMKiIlqfaeboSg05+Gf3jeTjJKcqoTDNJsbIJm7//YihgNNCdUq31
 /LuWvwDMGDvzZmlkGfG4IUqpg91Gu5/ej3tzUajp9nociJqOd4EhByS995SutGTA
 Zjy7EZ9aq7rAFEqMsBsbVwtr/hSbmDuWoRJrVtTKtaIqK9PDS35yCvc69l+FkTFW
 Gt4vOsL6nTY/PTnmJD+rvtDBQsMorqZAiqM987mzb5P0KMbKFppKKIqUhHgh0kqo
 HnrL8b4o6oV+BfXoSggfpvfeVeFwMWk2PPZwHUoPg1jyesiA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q9svb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:23:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f6f4fe531so406124785a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294602; x=1793899402; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zZghyqVMgNO1BxXvTNnkXhw/WOYhZKinTP6qrJN9EZY=;
 b=d7S6k9JM0gdipBRRR1pd+o0XBx2UoMjy0tf+2i6h0qgnuOTM0YjtiPjZcGFrfh2lfU
 x/TsXRVd8Pxkl3VNIFv5C9DPJe6aoQgV1j2C9SjKIU5hLH+Pj5r2UiB/XSf3w0RuLZnd
 O+ZcROFdaEbeuJk/2mhajp5WMqnaBSxWHpi6i3aFGJRyKFVT1DmRiCD8iZbXkX3gnEZb
 kcs/qHPWBeG3LtfNI6uz8Dcq2qygOiOzuXH+IYyqYXu2CZ+8VA98tHbRJak/RYC6YVk0
 V8Nw7wYXp3r1mHW59JRdB1vnYWmpaZLmzeVgQfos3fm+jxtM1U7jlwR90gKVr+/+XLir
 DKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294602; x=1793899402;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zZghyqVMgNO1BxXvTNnkXhw/WOYhZKinTP6qrJN9EZY=;
 b=inUmxVJVMyjH3AgX/POXL1YvbuQ5XH8wbJww+XLsa7gpPs7D8AoHQuYQ5qi184U5RP
 PWTinu8hJqHdnIerwtCC6UGFdzmBWw1ip5dkWX+zb53AlvGMCqwHYaNJmnaF3uce7hmU
 UbsKQU7aUuvmIlGUJjzFIns84XBkRNXImPc/IjslCvYWBiLrcWiEgO6GbITZtFr+l+Cq
 w4If1BVrb5mH4SqnFiujD5esFJvksoej4Lc/TafrPzoubbSkBzDWr4gSFgTWU3akJv2b
 0kXlsbg2R+gusTEPdGH8UPe6qHnx0/IqxcxaatY8RyENAPWx3BatgZa+UNyEnii5WnbL
 t9Lg==
X-Gm-Message-State: AFq9FYLrXGQ+sdd0Vg0AQkYMzMU2crB8CjVIUlFpVRov16W8RWREdGLy
 OAbBwXFfidNsiiPrtC9Rhe4r2ALO+lx0D3k9hDnTBKLR4mqo31GXcGTCRjjJTx54sNNbISOgQgY
 40nAGE0PawDErxsl667c3fwU0RV9vB9Kjn3qOQmrpmPhOOdDWFvhT7cvFQo94Ad3RhUom
X-Gm-Gg: AYBFou2vy/QRdnvM8bDanUiescdqyetuqLOwZnuTRxH5ZdnlBqRYf4AFcswbQyVSw/g
 wK9jdn7EDZKFUkez/lxDRahhIgbXIwl01Cq/QrEnpedi0wgEcahyBAc9QjdifBfMMJ5KXir3rV1
 lvWgfSy59QWudYaFuoU13YUsUS7Sa+gGQ0SgPRRAllQeELNutzvcG6oYGYpSADZKg0oxfC16o26
 4UIDXB6xW0ujaopfPg1Y1Yj17OprHNpbac1IiIZApZc71FitO83PiDTmOUxnplEpER/FNzGfG32
 EIenIyneQU4PsVrkQ2IcT4dZHANis/X6/HVcat3Vp7/jZPnpmEOXPXmE8s4Ii/3I4c3EimarkMH
 KbN5MkqpwQ3Wagltm7U3g+unL/5KcLZwA95ekWe6wlC7ZC0y8er3J1BTzWFhaxrq9EFZmyXqj4N
 OVsp6ehQTANzjgZN52n6T7B3NsExDOYg==
X-Received: by 2002:a05:620a:4505:b0:914:afc1:c66d with SMTP id
 af79cd13be357-9440896db71mr912126185a.11.1793294601932; 
 Thu, 29 Oct 2026 10:23:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4505:b0:914:afc1:c66d with SMTP id
 af79cd13be357-9440896db71mr912119985a.11.1793294601312; 
 Thu, 29 Oct 2026 10:23:21 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe7706516sm1803525e9.0.2026.10.29.10.23.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:23:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 00/31] tests/tcg: Massage MIPS tests for easier maintenance
Date: Thu, 29 Oct 2026 18:22:44 +0100
Message-ID: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX6tSZ0+WqKHbc
 MM0C26zrlp/MJxAkwzRXKyoqJRFEUJp35oNLyUpxfyzYujFjCHVmrKMm8kP5sOBOU0hvFzwg0ya
 0WlxTwmxhUH8+ns51RLmK04gpYpMSMk=
X-Proofpoint-ORIG-GUID: DntTE5bZ0bIw-ogVxbPF12m0-AW0BEoP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfXw1M2KutekxKz
 y1d5i1zZPZlA7kkujmFTbvl6oEDDDTchEMSxl2E3Ru7nF9Pparqlj7XcKpfI3fqFgAKblSHzhY5
 ARDMsEeJVI6DtsGnmgfE99iyB6oFa+lXQqiihafmMgR8m9NSpLas1T0YgqidqTYFEDz/NFGVlwS
 Y92Bt4J601aWWUGrIPc0MzRQIhhKzbAteHPpQ8OiBwsaHGQ+VoL5NYtm/KBto0uSbUHq0yMvSjt
 ftm8AGXL0ROhsYMnHCjcybQ5x4Xz/OiT8/ayJ1PwMCZ0GpE2DENoGjnSEsC2i1KSElIEWhWQyKJ
 5eqLHMEcJHNlfft4yF5dHHrw0LTRk+fC8rb44+ArJWk90ZjHDcHDfuGtp8NOiRURBz6PKx+sJ5R
 jgxX0BMGy1LzRlGUgTbPcbk3Rs1IlHg4HYTuUkA+aThhj8otFD+y73nHpX0pjfVHr5nue9r8mfD
 MH1Nsiw1TW5hxbN5xtg==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae3810b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=sVLXhHKWFHBH7t45zQ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: DntTE5bZ0bIw-ogVxbPF12m0-AW0BEoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

Since v1:
- TAP (pbo)
- no more assert (pbo)
- split per group
- MSA ld/st tests

Based-on: <20261029152009.19812-1-philmd@oss.qualcomm.com>

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
 tests/tcg/mipsel/test_dsp_runner.h            |  39 +++
 tests/tcg/mips/test_msa_bit_count.c           | 103 +++++++
 tests/tcg/mips/test_msa_bit_move.c            |  97 ++++++
 tests/tcg/mips/test_msa_bit_set.c             | 103 +++++++
 tests/tcg/mips/test_msa_fixed_multiply.c      | 103 +++++++
 tests/tcg/mips/test_msa_float_max_min.c       |  79 +++++
 tests/tcg/mips/test_msa_int_add.c             | 187 ++++++++++++
 tests/tcg/mips/test_msa_int_average.c         | 127 ++++++++
 tests/tcg/mips/test_msa_int_compare.c         | 151 ++++++++++
 tests/tcg/mips/test_msa_int_div_mod.c         | 127 ++++++++
 tests/tcg/mips/test_msa_int_dot_product.c     | 139 +++++++++
 tests/tcg/mips/test_msa_int_max_min.c         | 175 +++++++++++
 tests/tcg/mips/test_msa_int_multiply.c        | 103 +++++++
 tests/tcg/mips/test_msa_int_subtract.c        | 235 +++++++++++++++
 tests/tcg/mips/test_msa_interleave.c          | 127 ++++++++
 tests/tcg/mips/test_msa_load_store.c          | 166 +++++++++++
 tests/tcg/mips/test_msa_logic.c               |  61 ++++
 tests/tcg/mips/test_msa_pack.c                | 103 +++++++
 tests/tcg/mips/test_msa_shift.c               | 151 ++++++++++
 tests/tcg/mips64/test_mips64r6_bitops.c       |  62 ++++
 tests/tcg/mips64/test_mips64r6_crc.c          |  74 +++++
 tests/tcg/mips64/test_mips64r6_logic.c        |  50 ++++
 tests/tcg/mips64/test_mips64r6_multiply.c     |  74 +++++
 tests/tcg/mips64/test_mips64r6_shift.c        |  62 ++++
 tests/tcg/mipsel/test_dsp_acc.c               | 112 +++++++
 tests/tcg/mipsel/test_dsp_arith.c             | 182 ++++++++++++
 tests/tcg/mipsel/test_dsp_cmp.c               |  87 ++++++
 tests/tcg/mipsel/test_dsp_ctrl.c              |  47 +++
 tests/tcg/mipsel/test_dsp_dot.c               | 157 ++++++++++
 tests/tcg/mipsel/test_dsp_mul.c               |  67 +++++
 tests/tcg/mipsel/test_dsp_pack.c              | 152 ++++++++++
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
 tests/tcg/mipsel/test_dsp_shift.c             | 127 ++++++++
 tests/tcg/mips/meson.build                    | 277 ------------------
 tests/tcg/mips64/meson.build                  |  63 ++--
 tests/tcg/mipsel/meson.build                  | 193 ++----------
 197 files changed, 3694 insertions(+), 641 deletions(-)
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


