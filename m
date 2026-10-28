Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37239606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RvGAbhRG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RM0kCp4D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9DM-00072Z-Fi; Wed, 28 Oct 2026 15:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9DJ-00072C-86
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:21:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9DG-0005m1-Tn
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:21:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIcRDN1918668
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=wgP3RZ+dEN4vwB3w7uklxB
 VR7w43ODCOn5SdC/Icda4=; b=RvGAbhRGsJtPSOOZK6k2N1C6AABB+auo+AsScM
 2MDQzyNfwAvLyO1GB+PcAlzo8jAuKlUBhE95syxMSddYB2bM4hdBNrex/NrQ5UYv
 XMNj+rxU2GkBsiRpDsgDRX1rOp8yAk/hvBA6uaTC5zHyNgindI1g8oYBaViKGU1t
 FiqEvEi+YQ0eQNKXa9DHgjI7vst7aDqV32KAUPlI6dg9Jc0+zYpKn9guFPNuU5bB
 fyuT1YfmGTFk1LQdOUps/1IdxcxLZTYsynSSRSeU4h59g7rnKRGwspN45EcW5EiZ
 mwwdWxS6nejDXjvTPBrfnGeEolRKg20wc19RepC5ZdTiZa+Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpgpr5f1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:21:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-944101e6367so1953485a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215288; x=1793820088; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wgP3RZ+dEN4vwB3w7uklxBVR7w43ODCOn5SdC/Icda4=;
 b=RM0kCp4D/U8KWWVpaRTAPhI6u5zzRWBwuDFXvakReVqXnLXTvdX//VcEDU9wRRsPf7
 nfXlFxHH7GRHzbxGjczHtbHBoJhghrkybDJBrMFmLFlvLfjBfNthKwTxqejHEPSwApFD
 TxN/OZA2QcQdgG0Q2sJFTzjfYAVsEHrJML9a7ssMZpC2+xIZ7LlGGl0WKICpbXx0rG+U
 BWk+mIYG5oLpZR+fjA1JIRHycW0Y+N8V0fnq022FWKkQfXQgL+VOw+ySnVUgCq2KkDu+
 HU7Gclo2lhyXiZZJiIiZvZUcRfDfDtpOXthY6sJpzczfXcnVVlhDDaFlQu3wJoGf/hFW
 1zjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215288; x=1793820088;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wgP3RZ+dEN4vwB3w7uklxBVR7w43ODCOn5SdC/Icda4=;
 b=O+ZW+qW95pcWFYfofmPz/UBx0d/oiJHU4MPaxUFCXwPSU8S1E3Jm9Y25+YKfBGPWaC
 aH5BmSUfcLD0L+3ba+D92NL0MjXFgvOjDYeRA26c4uPHOhn0VJ07mJKGn1r7DNltTHQt
 i27pdBEslwn/XtAnHVIoccJLo0F/xpYj+z3U8e1pptqRELZbtIxhdbWkRT/HsHDSsxc+
 RKHla9RLUzR4Qgk/H99ojYg9RfZeCZiH9VsHM3hjibt5mw4+xE3bGoj1xBxWWFhpjGAT
 O75hxjfRkHduGHz9fAae/OqdS0MVlzIgG+yJUlyi1zwJk6/74elQ7CvBzAy8gOJtQgpX
 umSw==
X-Gm-Message-State: AFq9FYKLt/lYwjpEmafXIkzXG8bO0bGG68rVc1iXipMm0ioriAek5YRF
 PH1H+NX/+sj3XIyMjtHPWoLxKUYmmNWPJk0h2i/sgJU8FkBbbpws3hlVfOcSGF9PO0bQO9BkYNb
 gJFynHUPelm3jPgg/NG4Em+1Vnotn9D4S/KfnZgQkVlwoUNCt8BS9/Y+sD5hTLyNNs0pA
X-Gm-Gg: AYBFou1VBuJRMIzMIBKUUOBTJ9ugLeon3a2ATCflyTHfQ7YVzaA+gk+ICCJIaiAp0H4
 Hakg0hr2jVRc2YUpJFt8ksAx3ByenrrBacKmsW99cMWlOvht3IlfbWBJIgJtWXw57jAYMoEewli
 0rZQyQGgUnvEzy+7eUzxar6LecAA5maxpoHm+8xih8wn7SOOn+DUz1muam0mZaWIwA7348jchYT
 nh3WUQoqFPz8VlGAHD/d+Fa+SDbM1XeEDSpXDNBMWAGKfcYrlHlwWRx9YrGwwn+5nIT8eZPJdBV
 skxzYPwAB5IBrciuk2+pFwV+7Uka2+C7BeiM13IrXJZQZ4mgrpfCNlbOkHWDvgKcUig4zBKL7xh
 VfWkD8zDNOk/ahEk5JtNTGzaJX0dHuuTsbVNMK/lYN1ICBO5zctVWK/83ltgf0nbfUAraYf1ScB
 66IFEeBNmKnNYjvqcJn8coK8acQyoe+A==
X-Received: by 2002:a05:620a:8804:b0:93f:2571:c317 with SMTP id
 af79cd13be357-944133b1f9cmr89885185a.28.1793215288193; 
 Wed, 28 Oct 2026 12:21:28 -0700 (PDT)
X-Received: by 2002:a05:620a:8804:b0:93f:2571:c317 with SMTP id
 af79cd13be357-944133b1f9cmr89876785a.28.1793215287144; 
 Wed, 28 Oct 2026 12:21:27 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81b7fe80sm14440025e9.11.2026.10.28.12.21.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:21:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/4] tests/tcg: Massage MIPS tests for easier maintenance
Date: Wed, 28 Oct 2026 20:21:19 +0100
Message-ID: <20261028192124.30941-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX9BKo07sCD2XS
 luT22+N1fO8Mvt9c58XmXERNKu7ym6llPW8ebtGcwdd8GEP23DTwoAmQuXRYGxMSZMQ38of8zUk
 fPrx2VNWwwFlbUxjelmPpvwAizlrsFnUNKfailXuMUCToCSiEUs5NWHUY1P8UsfHwsf6dfRoYS2
 3dt57Oox/3VZiS00RQIrDlTQpP8UmNd5g47fbQVomvAuoTxqIBAF7p7kDLytL86QAFXWrrqiVVN
 MfpDe8oW9bYuVATGvxXEi4n7sv6DdDqkGoNWBE8Q9vUx4yGDr9FQ6GVH1frmA2nyNr0NuKVI7xU
 iZNQvcUqVpqdtDDD3MJurZZX13v9sqG6ajuUscZWQHT5daLJXyw7M03fEyVHFGm0X9kE3f7/jQA
 KqGaqaNagtWP4kxVI9GdeIxBNax89zfPxzHu25eIrHJZ5DGd7PAV013BDe6WUO8tztnxyycaOf4
 loRlqbqtxVXdKB/K9BA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX+qkQ141zGCIB
 TifOsbxFzv/sKSlucCis6+sDRyeJd/BB2aUUqdbToEO+bmQBK+3v6iQQtD98UzhYClwzYaZMJ39
 Ix1/TbVt6c9aM3ioNpG1LeKK6raykew=
X-Proofpoint-ORIG-GUID: n_4BPEj6tPwuUhBjbKrjXAY9MYXYoX-Y
X-Proofpoint-GUID: n_4BPEj6tPwuUhBjbKrjXAY9MYXYoX-Y
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6ae24b38 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=F7oaLL2QW1-sIKFIQ68A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Philippe Mathieu-Daudé (4):
  tests/tcg/mips: Clear DSPControl at start of DSP tests
  tests/tcg/mips: Group DSP tests
  tests/tcg/mips: Group Release 6 tests
  tests/tcg/mips: Group MSA tests

 .../user/ase/msa/test_msa_group_bit_count.c   |  82 +++++
 .../user/ase/msa/test_msa_group_bit_move.c    |  76 +++++
 .../user/ase/msa/test_msa_group_bit_set.c     |  82 +++++
 .../ase/msa/test_msa_group_fixed_multiply.c   |  82 +++++
 .../ase/msa/test_msa_group_float_max_min.c    |  58 ++++
 .../user/ase/msa/test_msa_group_int_add.c     | 166 ++++++++++
 .../user/ase/msa/test_msa_group_int_average.c | 106 +++++++
 .../user/ase/msa/test_msa_group_int_compare.c | 130 ++++++++
 .../user/ase/msa/test_msa_group_int_div_mod.c | 106 +++++++
 .../ase/msa/test_msa_group_int_dot_product.c  | 118 +++++++
 .../user/ase/msa/test_msa_group_int_max_min.c | 154 +++++++++
 .../ase/msa/test_msa_group_int_multiply.c     |  82 +++++
 .../ase/msa/test_msa_group_int_subtract.c     | 214 +++++++++++++
 .../user/ase/msa/test_msa_group_interleave.c  | 106 +++++++
 .../mips/user/ase/msa/test_msa_group_logic.c  |  40 +++
 .../mips/user/ase/msa/test_msa_group_pack.c   |  82 +++++
 .../mips/user/ase/msa/test_msa_group_shift.c  | 130 ++++++++
 tests/tcg/mips64/test_mips64r6_bitops.c       |  46 +++
 tests/tcg/mips64/test_mips64r6_crc.c          |  58 ++++
 tests/tcg/mips64/test_mips64r6_logic.c        |  34 ++
 tests/tcg/mips64/test_mips64r6_multiply.c     |  58 ++++
 tests/tcg/mips64/test_mips64r6_shift.c        |  46 +++
 tests/tcg/mipsel/test_dsp_acc.c               | 105 +++++++
 tests/tcg/mipsel/test_dsp_arith.c             | 175 +++++++++++
 tests/tcg/mipsel/test_dsp_cmp.c               |  80 +++++
 tests/tcg/mipsel/test_dsp_ctrl.c              |  40 +++
 tests/tcg/mipsel/test_dsp_dot.c               | 150 +++++++++
 tests/tcg/mipsel/test_dsp_mul.c               |  60 ++++
 tests/tcg/mipsel/test_dsp_pack.c              | 145 +++++++++
 tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_absq_s_w.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_addq_ph.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_addq_s_w.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_addsc.c          |   2 +
 tests/tcg/mipsel/test_dsp_r1_addu_qb.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_addwc.c          |   2 +
 tests/tcg/mipsel/test_dsp_r1_bitrev.c         |   2 +
 tests/tcg/mipsel/test_dsp_r1_bposge32.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c    |   2 +
 tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c    |   2 +
 tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c    |   2 +
 tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c     |   2 +
 tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c     |   2 +
 tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c     |   2 +
 tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c    |   2 +
 tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c    |   2 +
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c     |   2 +
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c     |   2 +
 tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c    |   2 +
 tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c    |   2 +
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c     |   2 +
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c     |   2 +
 tests/tcg/mipsel/test_dsp_r1_extp.c           |   2 +
 tests/tcg/mipsel/test_dsp_r1_extpdp.c         |   2 +
 tests/tcg/mipsel/test_dsp_r1_extpdpv.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_extpv.c          |   2 +
 tests/tcg/mipsel/test_dsp_r1_extr_r_w.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_extr_s_h.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_extr_w.c         |   2 +
 tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c     |   2 +
 tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_extrv_w.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_insv.c           |   2 +
 tests/tcg/mipsel/test_dsp_r1_lbux.c           |   2 +
 tests/tcg/mipsel/test_dsp_r1_lhx.c            |   2 +
 tests/tcg/mipsel/test_dsp_r1_lwx.c            |   2 +
 tests/tcg/mipsel/test_dsp_r1_madd.c           |   2 +
 tests/tcg/mipsel/test_dsp_r1_maddu.c          |   2 +
 tests/tcg/mipsel/test_dsp_r1_main.c           |   6 -
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c    |   2 +
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c    |   2 +
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c   |   2 +
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c   |   2 +
 tests/tcg/mipsel/test_dsp_r1_mfhi.c           |   2 +
 tests/tcg/mipsel/test_dsp_r1_mflo.c           |   2 +
 tests/tcg/mipsel/test_dsp_r1_modsub.c         |   2 +
 tests/tcg/mipsel/test_dsp_r1_msub.c           |   2 +
 tests/tcg/mipsel/test_dsp_r1_msubu.c          |   2 +
 tests/tcg/mipsel/test_dsp_r1_mthi.c           |   2 +
 tests/tcg/mipsel/test_dsp_r1_mthlip.c         |   2 +
 tests/tcg/mipsel/test_dsp_r1_mtlo.c           |   2 +
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c  |   2 +
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c  |   2 +
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c |   2 +
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c |   2 +
 tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c     |   2 +
 tests/tcg/mipsel/test_dsp_r1_mult.c           |   2 +
 tests/tcg/mipsel/test_dsp_r1_multu.c          |   2 +
 tests/tcg/mipsel/test_dsp_r1_packrl_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_pick_ph.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_pick_qb.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c   |   2 +
 tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c   |   2 +
 tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c |   2 +
 .../tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c  |   2 +
 tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c |   2 +
 .../tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c  |   2 +
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c  |   2 +
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c |   2 +
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c  |   2 +
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c |   2 +
 tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c    |   2 +
 tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c   |   2 +
 tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c |   2 +
 .../tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c  |   2 +
 tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c     |   2 +
 tests/tcg/mipsel/test_dsp_r1_rddsp.c          |   2 +
 tests/tcg/mipsel/test_dsp_r1_repl_ph.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_repl_qb.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_replv_ph.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_replv_qb.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_shilo.c          |   2 +
 tests/tcg/mipsel/test_dsp_r1_shilov.c         |   2 +
 tests/tcg/mipsel/test_dsp_r1_shll_ph.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_shll_qb.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_shll_s_w.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_shllv_ph.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_shllv_qb.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c     |   2 +
 tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_shra_ph.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_shra_r_w.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_shrav_ph.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c     |   2 +
 tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_shrl_qb.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_subq_ph.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_subq_s_w.c       |   2 +
 tests/tcg/mipsel/test_dsp_r1_subu_qb.c        |   2 +
 tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c      |   2 +
 tests/tcg/mipsel/test_dsp_r1_wrdsp.c          |   2 +
 tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c      |   2 +
 tests/tcg/mipsel/test_dsp_r2_addqh_ph.c       |   2 +
 tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c     |   2 +
 tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c      |   2 +
 tests/tcg/mipsel/test_dsp_r2_addqh_w.c        |   2 +
 tests/tcg/mipsel/test_dsp_r2_addu_ph.c        |   2 +
 tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r2_adduh_qb.c       |   2 +
 tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c     |   2 +
 tests/tcg/mipsel/test_dsp_r2_append.c         |   2 +
 tests/tcg/mipsel/test_dsp_r2_balign.c         |   2 +
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c   |   2 +
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c   |   2 +
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c   |   2 +
 tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c       |   2 +
 tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c   |   2 +
 tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c  |   2 +
 tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c       |   2 +
 tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c   |   2 +
 tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c  |   2 +
 tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r2_mul_ph.c         |   2 +
 tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c       |   2 +
 tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c      |   2 +
 tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c       |   2 +
 tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c     |   2 +
 tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c  |   2 +
 tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c    |   2 +
 tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c |   2 +
 .../tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c |   2 +
 tests/tcg/mipsel/test_dsp_r2_prepend.c        |   2 +
 tests/tcg/mipsel/test_dsp_r2_shra_qb.c        |   2 +
 tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c      |   2 +
 tests/tcg/mipsel/test_dsp_r2_shrav_qb.c       |   2 +
 tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c     |   2 +
 tests/tcg/mipsel/test_dsp_r2_shrl_ph.c        |   2 +
 tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c       |   2 +
 tests/tcg/mipsel/test_dsp_r2_subqh_ph.c       |   2 +
 tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c     |   2 +
 tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c      |   2 +
 tests/tcg/mipsel/test_dsp_r2_subqh_w.c        |   2 +
 tests/tcg/mipsel/test_dsp_r2_subu_ph.c        |   2 +
 tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c      |   2 +
 tests/tcg/mipsel/test_dsp_r2_subuh_qb.c       |   2 +
 tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c     |   2 +
 tests/tcg/mipsel/test_dsp_shift.c             | 120 ++++++++
 tests/tcg/mips/meson.build                    | 291 +-----------------
 tests/tcg/mips64/meson.build                  |  37 +--
 tests/tcg/mipsel/meson.build                  | 168 +---------
 193 files changed, 3279 insertions(+), 472 deletions(-)
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_bit_count.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_bit_move.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_bit_set.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_fixed_multiply.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_float_max_min.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_add.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_average.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_compare.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_div_mod.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_dot_product.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_max_min.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_multiply.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_int_subtract.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_interleave.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_logic.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_pack.c
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_group_shift.c
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


