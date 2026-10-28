Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B56606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nUyIWhUx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=exqsoZKt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9DZ-00073Y-6j; Wed, 28 Oct 2026 15:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9DW-00073E-3v
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:21:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9DR-0005ma-D4
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:21:45 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIcT6R1918684
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 riGTo+FgPlvQBvc1Os+M/UY0Wg3KUXzTAUhwNZG68sM=; b=nUyIWhUxCoKDJ/zJ
 1nw6KKC5I5j8ZsLiWBDz25ATLGjlgFBIY8DVVRLbyO81Io6E7KbQEXrOp6lobnQX
 LlfKjN508P+X6kH/rao4x2waFrsf2/+5oelQOs6C0BybK6Xfl1MwE5WtK9Q9LACW
 1FKVhXXouY2rV0fpnGd2RpYFT5INTl05eTO4qfKmjGtq03ZZ8QdBIxaWDNBPQoBX
 QIa6nidDk9mBckQAmCwrn6zKGK2O5aFMAC7YU4W8Y73WZWJoVdUOOIr8IiMLx+o1
 Nm5Ca3hIr2EWlaNuDInUp36TBYMqhNXCtVxnr/e9xFK7mNKKJaN6QADgIMi8NoX9
 MTis3A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpgpr5fm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:21:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f559420f3so118664385a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215299; x=1793820099; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=riGTo+FgPlvQBvc1Os+M/UY0Wg3KUXzTAUhwNZG68sM=;
 b=exqsoZKttRcl89BlRylEXFPUQnMw5isHynlFR1IEnsl+fvYHkUnSPTfutjTwUZ8G2E
 anRMAlE42diL3qs81sc3cYlLJca7aBgUM8USLankWws3KGpABkNR5oclwS0QcAktVmFj
 MBmUmP7orXc4FfHJx0UD8uK6FEh5DpNJrQ9GvA7ogsvi/+iYV3aByLiwQYLADamzCOuk
 ekl3xlQrd6QvCWqTJTJAwXXQPNRxzw0q/AfVmUAwSFglVg9Zig0qhSPNoG7qfy43RvgI
 4XGobBjZoyZI2jIkR2QOOMqEEcRpzr/Qj/DMYP0kdeCy3e1k7tsisBDB8dQqiSMci859
 5HGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215299; x=1793820099;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=riGTo+FgPlvQBvc1Os+M/UY0Wg3KUXzTAUhwNZG68sM=;
 b=TQM+AYzKkAcMP96Nih3ni7Z5tsGWIdYyeCzEnYCJIg5Gds+h5+4YCGNaGdaFaU5rjb
 3Vhm0JNKJk3HKRIdRE5yLKWhOYvbSM7FFI7ASUwaLtHoZynw/OmvLRs2FRMPlDmzm6cn
 gTfe6WjD9Y5BuPWhfE5LmL2hjXB0JODBlXWzCEZllxlVZbCPjw1YbPYulT1O1gB/dT6p
 Cq9AU8MmNScGHXRQzMqVT7BZYDAu8cyOvo1nDJgVjSlrhW+wmudWxxw9aCX00Dop4H9T
 HeS6HzZEXsGH0k9ciWE05VKoWBPrkSF0t0W5RKKQmZPo2CV8m3sc+tODUE3u0oc0QWSp
 aFsA==
X-Gm-Message-State: AFq9FYJ5yV/vEfhwlxF1uCnWkce8s7HheUP95lh5usLDkAQRjEztiAWz
 9ardVGFRo9uabmTa3SoM5SRZ9hDG0RNdiA/wsc3ig12XapPzaQYO4f+95dLmzLRKJScNONT7Agk
 aqa7hEHPVcHOhI5fgBEGI6IHdBALxRTP+7/Nch3yrJL3NE8JjVm1fZ4s8C9fpKwdnD7Gt
X-Gm-Gg: AYBFou2ibGrx/JH2y7MeLUbr6YZ/U6le2qAdBH3eWR8A2AbMnZrKB2VUyF+8IpCJI88
 rz0RZWNBCj/UGHX99MEnkRw5fbiSqnFrC4U+rhfthdbPb9VAi5n2seX0JX/a+QECSBwN8ih5v9v
 odHhS/pp7FeXquLQ/B0x7qsVOEhClWrbbK1KTFL1Fu5/tWou+z6bSzxDsTtDT6c2ZjoEVEEPrRi
 bfhH2rNsqNDhfrhhoDorqX4H+U6VFr62SJ6wgnwTtRT/ep9ccoVT4Rbq5WfeSsJy0U35Z052svr
 fwlxfSEdids7HpqoJwALl5gqoAVpz89rc8BB+OGbwHq5EV/LiSiDqdL87eHiUXsYUb3eE42GlXn
 vqFjJVu9ipYCmdKbTpCXjMWAZSZYtU6otup0SPmEZSO8njAbIe7T80KDrfq8ToEQhgnmoQf1mM0
 MXLGteaQsj/yQpGjxDrJ86kfrX1qN8/w==
X-Received: by 2002:a05:620a:8088:b0:93f:94b:81ce with SMTP id
 af79cd13be357-94408d744ccmr446622885a.81.1793215298238; 
 Wed, 28 Oct 2026 12:21:38 -0700 (PDT)
X-Received: by 2002:a05:620a:8088:b0:93f:94b:81ce with SMTP id
 af79cd13be357-94408d744ccmr446612485a.81.1793215296658; 
 Wed, 28 Oct 2026 12:21:36 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48eesm30100369f8f.30.2026.10.28.12.21.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:21:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/4] tests/tcg/mips: Clear DSPControl at start of DSP tests
Date: Wed, 28 Oct 2026 20:21:20 +0100
Message-ID: <20261028192124.30941-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028192124.30941-1-philmd@oss.qualcomm.com>
References: <20261028192124.30941-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX3n7iBAE8TBk/
 bl0HgeRmDfRchlubiFBEHYqkYZU2lTua9vMJlWNQgzRMIESuxNfONQuwaTwnmOXGUY6ah/A2JAA
 gM1ZR19mTcLXcMOtuSe9DnD7o7Nfd4kPNbt0l+ROasOvKS4P3iesZwNNMpjbm3QFx5Oqs9VeqHD
 1glHbi7/vRdd3VBCpexE9+ArP9Ad7NJ/XUVsYXEGqSPtDH+DTpxqMc+YFXeWwdKdl9G7PSwwpb9
 kAaME57O/4wHY6f9FEkb8ixwklbO3/sI1t55aJWuBcSO8ylhHcWIC73rIDgOyavxJrZdwE81Qw1
 x0bTaFR5W+y5jP3XOORkjpMdDCi/PbBvbbfiBAvQCBwOrfQrm3Ue/DCxpX2st8ApD2iXqomVZNO
 bmxGD9vijetFSOgcJsHy6r/4aq3Nw/Hn11nXP+QFfv8XW/kPQd3zX/3jRx6sNCTouhXRxGj2K9o
 mXtWIDwFmOIphzgqq5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX9a8R54/3ZeIs
 UhbLG7LbJJEi/NcBZYeSUxEQ8BadyUZQ425PpJjuPrQfpJJRuuWffjiW4fhZbxvKu6F13raA2/o
 aJl3KV/V/Dkjbd8cfp3CkcczFoRwZgw=
X-Proofpoint-ORIG-GUID: -sVocXyLj8kOxl_f7cZQXQX6jTJiuHYN
X-Proofpoint-GUID: -sVocXyLj8kOxl_f7cZQXQX6jTJiuHYN
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6ae24b44 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=kOvjzV5T_FytuhA7fqAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some tests check sticky DSPControl flags assuming the register
starts zeroed. Clear it explicitly so tests remain valid when
run in the same process.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_absq_s_w.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_addq_ph.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_addq_s_w.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_addsc.c            | 2 ++
 tests/tcg/mipsel/test_dsp_r1_addu_qb.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_addwc.c            | 2 ++
 tests/tcg/mipsel/test_dsp_r1_bitrev.c           | 2 ++
 tests/tcg/mipsel/test_dsp_r1_bposge32.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c      | 2 ++
 tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c      | 2 ++
 tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c      | 2 ++
 tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c      | 2 ++
 tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c      | 2 ++
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c      | 2 ++
 tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c      | 2 ++
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r1_extp.c             | 2 ++
 tests/tcg/mipsel/test_dsp_r1_extpdp.c           | 2 ++
 tests/tcg/mipsel/test_dsp_r1_extpdpv.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_extpv.c            | 2 ++
 tests/tcg/mipsel/test_dsp_r1_extr_r_w.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_extr_s_h.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_extr_w.c           | 2 ++
 tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_extrv_w.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_insv.c             | 2 ++
 tests/tcg/mipsel/test_dsp_r1_lbux.c             | 2 ++
 tests/tcg/mipsel/test_dsp_r1_lhx.c              | 2 ++
 tests/tcg/mipsel/test_dsp_r1_lwx.c              | 2 ++
 tests/tcg/mipsel/test_dsp_r1_madd.c             | 2 ++
 tests/tcg/mipsel/test_dsp_r1_maddu.c            | 2 ++
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c      | 2 ++
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c      | 2 ++
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c     | 2 ++
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c     | 2 ++
 tests/tcg/mipsel/test_dsp_r1_mfhi.c             | 2 ++
 tests/tcg/mipsel/test_dsp_r1_mflo.c             | 2 ++
 tests/tcg/mipsel/test_dsp_r1_modsub.c           | 2 ++
 tests/tcg/mipsel/test_dsp_r1_msub.c             | 2 ++
 tests/tcg/mipsel/test_dsp_r1_msubu.c            | 2 ++
 tests/tcg/mipsel/test_dsp_r1_mthi.c             | 2 ++
 tests/tcg/mipsel/test_dsp_r1_mthlip.c           | 2 ++
 tests/tcg/mipsel/test_dsp_r1_mtlo.c             | 2 ++
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c    | 2 ++
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c    | 2 ++
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c   | 2 ++
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c   | 2 ++
 tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r1_mult.c             | 2 ++
 tests/tcg/mipsel/test_dsp_r1_multu.c            | 2 ++
 tests/tcg/mipsel/test_dsp_r1_packrl_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_pick_ph.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_pick_qb.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c     | 2 ++
 tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c     | 2 ++
 tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c   | 2 ++
 tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c  | 2 ++
 tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c   | 2 ++
 tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c  | 2 ++
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c    | 2 ++
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c   | 2 ++
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c    | 2 ++
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c   | 2 ++
 tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c      | 2 ++
 tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c     | 2 ++
 tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c   | 2 ++
 tests/tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c  | 2 ++
 tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r1_rddsp.c            | 2 ++
 tests/tcg/mipsel/test_dsp_r1_repl_ph.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_repl_qb.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_replv_ph.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_replv_qb.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shilo.c            | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shilov.c           | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shll_ph.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shll_qb.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shll_s_w.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shllv_ph.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shllv_qb.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shra_ph.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shra_r_w.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shrav_ph.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shrl_qb.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_subq_ph.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_subq_s_w.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r1_subu_qb.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r1_wrdsp.c            | 2 ++
 tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r2_addqh_ph.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r2_addqh_w.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r2_addu_ph.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r2_adduh_qb.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r2_append.c           | 2 ++
 tests/tcg/mipsel/test_dsp_r2_balign.c           | 2 ++
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c     | 2 ++
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c     | 2 ++
 tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c     | 2 ++
 tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c     | 2 ++
 tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c    | 2 ++
 tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c     | 2 ++
 tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c    | 2 ++
 tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r2_mul_ph.c           | 2 ++
 tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c    | 2 ++
 tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c      | 2 ++
 tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c   | 2 ++
 tests/tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c | 2 ++
 tests/tcg/mipsel/test_dsp_r2_prepend.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r2_shra_qb.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r2_shrav_qb.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r2_shrl_ph.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r2_subqh_ph.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c       | 2 ++
 tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r2_subqh_w.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r2_subu_ph.c          | 2 ++
 tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c        | 2 ++
 tests/tcg/mipsel/test_dsp_r2_subuh_qb.c         | 2 ++
 tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c       | 2 ++
 159 files changed, 318 insertions(+)

diff --git a/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c
index aa8411202e20..6f85ae493bdd 100644
--- a/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c
@@ -7,6 +7,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt     = 0x10017EFD;
     result = 0x10017EFD;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c
index 3f52a48039cd..3e96dec3159d 100644
--- a/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt     = 0x80000000;
     result = 0x7FFFFFFF;
     __asm
diff --git a/tests/tcg/mipsel/test_dsp_r1_addq_ph.c b/tests/tcg/mipsel/test_dsp_r1_addq_ph.c
index 96a549637b41..0b8f7e893e89 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addq_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addq_ph.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0xFFFFFFFF;
     rt     = 0x10101010;
     result = 0x100F100F;
diff --git a/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c
index 5f865f6cffd5..0846634d4926 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0xFFFFFFFF;
     rt     = 0x10101010;
     result = 0x100F100F;
diff --git a/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c
index 1e13acf68fb9..4bdc59a6c9a9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c
@@ -7,6 +7,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt     = 0x10017EFD;
     rs     = 0x11111111;
     result = 0x2112900e;
diff --git a/tests/tcg/mipsel/test_dsp_r1_addsc.c b/tests/tcg/mipsel/test_dsp_r1_addsc.c
index ace749f667c4..90361cd836fd 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addsc.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addsc.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x0000000F;
     rt     = 0x00000001;
     result = 0x00000010;
diff --git a/tests/tcg/mipsel/test_dsp_r1_addu_qb.c b/tests/tcg/mipsel/test_dsp_r1_addu_qb.c
index 23ba2e90d1c9..c82d15c41a6a 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addu_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addu_qb.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x00FF00FF;
     rt     = 0x00010001;
     result = 0x00000000;
diff --git a/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c b/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c
index fe7fd3e6aa2d..91de186fad6b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x10FF01FF;
     rt     = 0x10010001;
     result = 0x20FF01FF;
diff --git a/tests/tcg/mipsel/test_dsp_r1_addwc.c b/tests/tcg/mipsel/test_dsp_r1_addwc.c
index 8a8d81fab4ca..77ac3381bde9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addwc.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addwc.c
@@ -7,6 +7,8 @@ int main()
     int dspi, dspo;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x10FF01FF;
     rt     = 0x10010001;
     dspi   = 0x00002000;
diff --git a/tests/tcg/mipsel/test_dsp_r1_bitrev.c b/tests/tcg/mipsel/test_dsp_r1_bitrev.c
index 04d8a3844eb8..3ece5c9f2c82 100644
--- a/tests/tcg/mipsel/test_dsp_r1_bitrev.c
+++ b/tests/tcg/mipsel/test_dsp_r1_bitrev.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt     = 0x12345678;
     result = 0x00001E6A;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_bposge32.c b/tests/tcg/mipsel/test_dsp_r1_bposge32.c
index d25417ea77b2..6e9f5f28b2ca 100644
--- a/tests/tcg/mipsel/test_dsp_r1_bposge32.c
+++ b/tests/tcg/mipsel/test_dsp_r1_bposge32.c
@@ -6,6 +6,8 @@ int main()
     int dsp, sum;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     dsp =  0x20;
     sum = 0x01;
     result = 0x02;
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
index 957bd88ce01f..378bf17213a2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x11777066;
     rt     = 0x55AA33FF;
     result = 0x00;
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
index 356f156c5d1f..d42bc4a54df3 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x11777066;
     rt     = 0x55AA33FF;
     result = 0x02;
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
index 3fb4827ad761..dd85601decbe 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x11777066;
     rt     = 0x55AA33FF;
     result = 0x02;
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
index 2615c84c75c7..28c8ff4de27e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x11777066;
     rt     = 0x55AA70FF;
     result = 0x02;
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
index 65d0813c3b19..5bcd20782889 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x11777066;
     rt     = 0x55AA70FF;
     result = 0x0F;
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
index 7dddad98532c..fa7ae80051b4 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x11777066;
     rt     = 0x55AA70FF;
     result = 0x0D;
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
index 680f2a1999d8..c770a78ca7a0 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs         = 0x11777066;
     rt         = 0x55AA70FF;
     result     = 0x02;
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
index 43cfa509ca3c..e107731c494a 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs         = 0x11777066;
     rt         = 0x55AA70FF;
     result     = 0x0F;
diff --git a/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
index 074ca5b402de..a1ae33d371d2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs         = 0x11777066;
     rt         = 0x55AA70FF;
     result     = 0x0D;
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
index a6425b6edc84..9031d7cc2852 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
@@ -7,6 +7,8 @@ int main()
     int ach = 0, acl = 0;
     int resulth, resultl, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs        = 0x800000FF;
     rt        = 0x80000002;
     resulth   = 0x00;
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c b/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
index cbf900713f33..992513cf4798 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
@@ -7,6 +7,8 @@ int main()
     int ach = 0, acl = 0;
     int resulth, resultl, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs        = 0x80000000;
     rt        = 0x80000000;
     resulth   = 0x7FFFFFFF;
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
index 6017b5e73ab2..5417db80495e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
@@ -7,6 +7,8 @@ int main()
     int ach = 5, acl = 3;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs        = 0x800000FF;
     rt        = 0x80000002;
     resulth   = 0x05;
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
index e4abb2e2af03..d51372ab768e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
@@ -7,6 +7,8 @@ int main()
     int ach = 5, acl = 3;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs        = 0x800000FF;
     rt        = 0x80000002;
     resulth   = 0x05;
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
index 74058fe7ecd0..d79b16c3e690 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
@@ -7,6 +7,8 @@ int main()
     int ach = 5, acl = 5;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs      = 0xBC0123AD;
     rt      = 0x01643721;
     resulth = 0x00000004;
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c b/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
index eda3b14e2be2..fb819c7cde22 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
@@ -7,6 +7,8 @@ int main()
     int ach = 5, acl = 5;
     int resulth, resultl, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs      = 0xBC0123AD;
     rt      = 0x01643721;
     resulth = 0x00BD3A22;
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
index 94e2bf625499..34b81489078c 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
@@ -7,6 +7,8 @@ int main()
     int ach = 5, acl = 5;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs      = 0xBC0123AD;
     rt      = 0x01643721;
     resulth = 0x04;
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
index a1e66356310d..06e6e0e6f9f3 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
@@ -7,6 +7,8 @@ int main()
     int ach = 5, acl = 5;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs      = 0xBC0123AD;
     rt      = 0x01643721;
     resulth = 0x04;
diff --git a/tests/tcg/mipsel/test_dsp_r1_extp.c b/tests/tcg/mipsel/test_dsp_r1_extp.c
index b18bdb34c872..3092067b36db 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extp.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extp.c
@@ -6,6 +6,8 @@ int main()
     int rt, ach, acl, dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x05;
     acl = 0xB4CB;
     dsp = 0x07;
diff --git a/tests/tcg/mipsel/test_dsp_r1_extpdp.c b/tests/tcg/mipsel/test_dsp_r1_extpdp.c
index 79ee16e8b87c..8bdb1fb6999b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extpdp.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extpdp.c
@@ -6,6 +6,8 @@ int main()
     int rt, ach, acl, dsp, pos, efi;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x05;
     acl = 0xB4CB;
     dsp = 0x07;
diff --git a/tests/tcg/mipsel/test_dsp_r1_extpdpv.c b/tests/tcg/mipsel/test_dsp_r1_extpdpv.c
index f5774eed3cae..e865052e3f24 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extpdpv.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extpdpv.c
@@ -6,6 +6,8 @@ int main()
     int rt, rs, ach, acl, dsp, pos, efi;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x05;
     acl = 0xB4CB;
     dsp = 0x07;
diff --git a/tests/tcg/mipsel/test_dsp_r1_extpv.c b/tests/tcg/mipsel/test_dsp_r1_extpv.c
index 401b94afadfc..8fe8555a4f4d 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extpv.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extpv.c
@@ -6,6 +6,8 @@ int main()
     int rt, ac, ach, acl, dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x05;
     acl = 0xB4CB;
     dsp = 0x07;
diff --git a/tests/tcg/mipsel/test_dsp_r1_extr_r_w.c b/tests/tcg/mipsel/test_dsp_r1_extr_r_w.c
index 489c1931b475..a8dc1fb88799 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extr_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extr_r_w.c
@@ -6,6 +6,8 @@ int main()
     int rt, ach, acl, dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x05;
     acl = 0xB4CB;
     result = 0xA0001699;
diff --git a/tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c b/tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c
index f9d2ed646fa3..2295d0180417 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c
@@ -6,6 +6,8 @@ int main()
     int rt, ach, acl, dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x05;
     acl = 0xB4CB;
     result = 0x7FFFFFFF;
diff --git a/tests/tcg/mipsel/test_dsp_r1_extr_s_h.c b/tests/tcg/mipsel/test_dsp_r1_extr_s_h.c
index 9bc2a63cc2d1..e0c3e75a22d7 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extr_s_h.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extr_s_h.c
@@ -6,6 +6,8 @@ int main()
     int rt, ach, acl, dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x05;
     acl = 0xB4CB;
     result = 0x00007FFF;
diff --git a/tests/tcg/mipsel/test_dsp_r1_extr_w.c b/tests/tcg/mipsel/test_dsp_r1_extr_w.c
index cf926146d54c..19ec7a37c4ae 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extr_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extr_w.c
@@ -6,6 +6,8 @@ int main()
     int rt, ach, acl, dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x05;
     acl = 0xB4CB;
     result = 0xA0001699;
diff --git a/tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c
index 2403b3afe40f..8f4ccefdabff 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c
@@ -6,6 +6,8 @@ int main()
     int rt, rs, ach, acl, dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x05;
     acl = 0xB4CB;
     dsp = 0x07;
diff --git a/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
index 10c182a54b23..783dcd167175 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
@@ -6,6 +6,8 @@ int main()
     int rt, rs, ach, acl, dsp = 0;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x03;
     ach = 0x05;
     acl = 0xB4CB;
diff --git a/tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c b/tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c
index feac3e2e334a..6369a138b4fd 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c
@@ -6,6 +6,8 @@ int main()
     int rt, rs, ach, acl, dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x05;
     acl = 0xB4CB;
     dsp = 0x07;
diff --git a/tests/tcg/mipsel/test_dsp_r1_extrv_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_w.c
index 9e8b238a04d4..f839dac03827 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extrv_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extrv_w.c
@@ -6,6 +6,8 @@ int main()
     int rt, rs, ach, acl, dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x05;
     acl = 0xB4CB;
     dsp = 0x07;
diff --git a/tests/tcg/mipsel/test_dsp_r1_insv.c b/tests/tcg/mipsel/test_dsp_r1_insv.c
index 9d674697ccaa..81843726aa21 100644
--- a/tests/tcg/mipsel/test_dsp_r1_insv.c
+++ b/tests/tcg/mipsel/test_dsp_r1_insv.c
@@ -6,6 +6,8 @@ int main()
     int rt, rs, dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     /* msb = 10, lsb = 5 */
     dsp    = 0x305;
     rt     = 0x12345678;
diff --git a/tests/tcg/mipsel/test_dsp_r1_lbux.c b/tests/tcg/mipsel/test_dsp_r1_lbux.c
index 2337abea2acb..39b21ab2c150 100644
--- a/tests/tcg/mipsel/test_dsp_r1_lbux.c
+++ b/tests/tcg/mipsel/test_dsp_r1_lbux.c
@@ -8,6 +8,8 @@ int main(void)
     unsigned long addr, index;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     value  = 0xBCDEF389;
     p = &value;
     addr = (unsigned long)p;
diff --git a/tests/tcg/mipsel/test_dsp_r1_lhx.c b/tests/tcg/mipsel/test_dsp_r1_lhx.c
index 10be3b385fee..822e56c0d093 100644
--- a/tests/tcg/mipsel/test_dsp_r1_lhx.c
+++ b/tests/tcg/mipsel/test_dsp_r1_lhx.c
@@ -8,6 +8,8 @@ int main(void)
     unsigned long addr, index;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     value  = 0xBCDEF389;
     p = &value;
     addr = (unsigned long)p;
diff --git a/tests/tcg/mipsel/test_dsp_r1_lwx.c b/tests/tcg/mipsel/test_dsp_r1_lwx.c
index e6543c9e7eae..149a8d254cff 100644
--- a/tests/tcg/mipsel/test_dsp_r1_lwx.c
+++ b/tests/tcg/mipsel/test_dsp_r1_lwx.c
@@ -8,6 +8,8 @@ int main(void)
     unsigned long addr, index;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     value  = 0xBCDEF389;
     p = &value;
     addr = (unsigned long)p;
diff --git a/tests/tcg/mipsel/test_dsp_r1_madd.c b/tests/tcg/mipsel/test_dsp_r1_madd.c
index af4bfcfe9df3..732e366b9afc 100644
--- a/tests/tcg/mipsel/test_dsp_r1_madd.c
+++ b/tests/tcg/mipsel/test_dsp_r1_madd.c
@@ -8,6 +8,8 @@ int main()
     int acho, aclo;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     achi = 0x05;
     acli = 0xB4CB;
     rs  = 0x01;
diff --git a/tests/tcg/mipsel/test_dsp_r1_maddu.c b/tests/tcg/mipsel/test_dsp_r1_maddu.c
index af4bfcfe9df3..732e366b9afc 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maddu.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maddu.c
@@ -8,6 +8,8 @@ int main()
     int acho, aclo;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     achi = 0x05;
     acli = 0xB4CB;
     rs  = 0x01;
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
index 0f7c070155a8..1842889ba43f 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
@@ -10,6 +10,8 @@ int main()
     int resulth, resultl;
     int resdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     achi = 0x00000005;
     acli = 0x0000B4CB;
     rs  = 0xFF060000;
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
index 942722a530c2..5255ca8f527b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
@@ -10,6 +10,8 @@ int main()
     int resulth, resultl;
     int resdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     achi = 0x00000005;
     acli = 0x0000B4CB;
     rs  = 0x0000FF06;
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
index d83dce6f3272..90b109749350 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
@@ -10,6 +10,8 @@ int main()
     int resulth, resultl;
     int resdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     achi = 0x00000000;
     acli = 0x0000B4CB;
     rs = 0xFF060000;
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
index d2331118abb8..cbc05492f51a 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
@@ -10,6 +10,8 @@ int main()
     int resulth, resultl;
     int resdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     achi = 0x00000000;
     acli = 0x0000B4CB;
     rs  = 0x0000FF06;
diff --git a/tests/tcg/mipsel/test_dsp_r1_mfhi.c b/tests/tcg/mipsel/test_dsp_r1_mfhi.c
index 43a80669d1ea..c4f2cc00efbb 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mfhi.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mfhi.c
@@ -6,6 +6,8 @@ int main()
     int achi, acho;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     achi   = 0x004433;
     result = 0x004433;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_mflo.c b/tests/tcg/mipsel/test_dsp_r1_mflo.c
index caeafdb05ce4..fad79768c687 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mflo.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mflo.c
@@ -6,6 +6,8 @@ int main()
     int acli, aclo;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     acli   = 0x004433;
     result = 0x004433;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_modsub.c b/tests/tcg/mipsel/test_dsp_r1_modsub.c
index c294eebb519d..96d9bca2595d 100644
--- a/tests/tcg/mipsel/test_dsp_r1_modsub.c
+++ b/tests/tcg/mipsel/test_dsp_r1_modsub.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0xFFFFFFFF;
     rt     = 0x000000FF;
     result = 0xFFFFFF00;
diff --git a/tests/tcg/mipsel/test_dsp_r1_msub.c b/tests/tcg/mipsel/test_dsp_r1_msub.c
index 5779e6f47ac7..ddcc144da129 100644
--- a/tests/tcg/mipsel/test_dsp_r1_msub.c
+++ b/tests/tcg/mipsel/test_dsp_r1_msub.c
@@ -7,6 +7,8 @@ int main()
     int acho, aclo;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs      = 0x00BBAACC;
     rt      = 0x0B1C3D2F;
     achi    = 0x00004433;
diff --git a/tests/tcg/mipsel/test_dsp_r1_msubu.c b/tests/tcg/mipsel/test_dsp_r1_msubu.c
index e0f9b5a77ae3..7955f4e174b2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_msubu.c
+++ b/tests/tcg/mipsel/test_dsp_r1_msubu.c
@@ -7,6 +7,8 @@ int main()
     int acho, aclo;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs      = 0x00BBAACC;
     rt      = 0x0B1C3D2F;
     achi    = 0x00004433;
diff --git a/tests/tcg/mipsel/test_dsp_r1_mthi.c b/tests/tcg/mipsel/test_dsp_r1_mthi.c
index 43a80669d1ea..c4f2cc00efbb 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mthi.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mthi.c
@@ -6,6 +6,8 @@ int main()
     int achi, acho;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     achi   = 0x004433;
     result = 0x004433;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_mthlip.c b/tests/tcg/mipsel/test_dsp_r1_mthlip.c
index 85f94d8450ea..61ed5aeb25eb 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mthlip.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mthlip.c
@@ -6,6 +6,8 @@ int main()
     int rs, ach, acl, dsp;
     int result, resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     dsp = 0x07;
     ach = 0x05;
     acl = 0xB4CB;
diff --git a/tests/tcg/mipsel/test_dsp_r1_mtlo.c b/tests/tcg/mipsel/test_dsp_r1_mtlo.c
index caeafdb05ce4..fad79768c687 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mtlo.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mtlo.c
@@ -6,6 +6,8 @@ int main()
     int acli, aclo;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     acli   = 0x004433;
     result = 0x004433;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
index b3a5370fe59e..157275550aab 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x80001234;
     rt = 0x80001234;
     result = 0x7FFFFFFF;
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
index 8066d7d02a1e..887ea0e6574f 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x8000;
     rt = 0x8000;
     result = 0x7FFFFFFF;
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
index 66a382806a21..caf2e9c0e5cc 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x80001234;
     rt = 0x80004321;
     result = 0xFFFF0000;
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
index 4cc6c8f7cfe1..6e16fe6384bb 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x8000;
     rt = 0x80004321;
     result = 0xFFFF0000;
diff --git a/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c b/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
index 370c2a801832..444cd7678631 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x80001234;
     rt = 0x80004321;
     result = 0x7FFF098C;
diff --git a/tests/tcg/mipsel/test_dsp_r1_mult.c b/tests/tcg/mipsel/test_dsp_r1_mult.c
index 15e6fde92c0e..d8e834f153b4 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mult.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mult.c
@@ -6,6 +6,8 @@ int main()
     int rs, rt, ach, acl;
     int result, resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs  = 0x00FFBBAA;
     rt  = 0x4B231000;
     resulth = 0x4b0f01;
diff --git a/tests/tcg/mipsel/test_dsp_r1_multu.c b/tests/tcg/mipsel/test_dsp_r1_multu.c
index 85d36c1b621a..f628172d778c 100644
--- a/tests/tcg/mipsel/test_dsp_r1_multu.c
+++ b/tests/tcg/mipsel/test_dsp_r1_multu.c
@@ -6,6 +6,8 @@ int main()
     int rs, rt, ach, acl;
     int result, resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs  = 0x00FFBBAA;
     rt  = 0x4B231000;
     resulth = 0x4b0f01;
diff --git a/tests/tcg/mipsel/test_dsp_r1_packrl_ph.c b/tests/tcg/mipsel/test_dsp_r1_packrl_ph.c
index 1f8e69992503..9bbdf1946a6f 100644
--- a/tests/tcg/mipsel/test_dsp_r1_packrl_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_packrl_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0x56788765;
diff --git a/tests/tcg/mipsel/test_dsp_r1_pick_ph.c b/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
index 929a002e7544..c53b894f320e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     dsp = 0x0A000000;
diff --git a/tests/tcg/mipsel/test_dsp_r1_pick_qb.c b/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
index a79047524662..2d848b8fbaf9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     dsp = 0x0f000000;
diff --git a/tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c
index bf70bf7d3aec..af302e1032a9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt = 0x87654321;
     result = 0x87650000;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c
index 3f885ef584e6..67986518faa1 100644
--- a/tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt = 0x87654321;
     result = 0x43210000;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c
index 63b7a9568345..130bd8236685 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt = 0x87654321;
     result = 0x43803280;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c
index 31627f0bd606..47821692d892 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt = 0x87654321;
     result = 0x43802180;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c
index b6f72d3cbfde..1c592f74746b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt = 0x87654321;
     result = 0x21801080;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c
index 4764fd031d8a..cc7c8ef6a126 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt = 0x87654321;
     result = 0x32801080;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c
index fa95c26cc48f..ca10372c9c7c 100644
--- a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt = 0x87654321;
     result = 0x00870065;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c
index 021f21a74440..843c70fd57aa 100644
--- a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c
+++ b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt = 0x87654321;
     result = 0x00870043;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c
index 03df18c72ca5..ab3680b40733 100644
--- a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt = 0x87654321;
     result = 0x00430021;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c
index 634327618cce..f729e035dd9c 100644
--- a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c
+++ b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt = 0x87654321;
     result = 0x00650021;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c b/tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c
index 25d45f1a9aa8..f4cb4b498b64 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0x12348765;
diff --git a/tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c b/tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c
index fe23acce8c47..50c2b7697aa6 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0x12568743;
diff --git a/tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c b/tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c
index da6845bf2423..3dca43c0630a 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0x12348765;
diff --git a/tests/tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c b/tests/tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c
index 7481d5af3a5b..7fab8bb0f3e9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87657FFF;
     result = 0x24AC00FF;
diff --git a/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c b/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c
index 77a983c0d20f..d611a4b853d9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     result = 0x114;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_rddsp.c b/tests/tcg/mipsel/test_dsp_r1_rddsp.c
index 2f3028503324..a08ff4fe965b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_rddsp.c
+++ b/tests/tcg/mipsel/test_dsp_r1_rddsp.c
@@ -7,6 +7,8 @@ int main()
     int ccond_i, outflag_i, efi_i, c_i, scount_i, pos_i;
     int ccond_o, outflag_o, efi_o, c_o, scount_o, pos_o;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ccond_i   = 0x0000000C;  /* 4 */
     outflag_i = 0x0000001B;  /* 3 */
     efi_i     = 0x00000001;  /* 5 */
diff --git a/tests/tcg/mipsel/test_dsp_r1_repl_ph.c b/tests/tcg/mipsel/test_dsp_r1_repl_ph.c
index 21074953bdde..1d91dae105a2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_repl_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_repl_ph.c
@@ -5,6 +5,8 @@ int main()
 {
     int rd, result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     result = 0x01BF01BF;
     __asm
         ("repl.ph %0, 0x1BF\n\t"
diff --git a/tests/tcg/mipsel/test_dsp_r1_repl_qb.c b/tests/tcg/mipsel/test_dsp_r1_repl_qb.c
index 6631393ea131..e704a3a85fff 100644
--- a/tests/tcg/mipsel/test_dsp_r1_repl_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_repl_qb.c
@@ -5,6 +5,8 @@ int main()
 {
     int rd, result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     result = 0xBFBFBFBF;
     __asm
         ("repl.qb %0, 0xBF\n\t"
diff --git a/tests/tcg/mipsel/test_dsp_r1_replv_ph.c b/tests/tcg/mipsel/test_dsp_r1_replv_ph.c
index 07fb15f1f795..7285f215b69d 100644
--- a/tests/tcg/mipsel/test_dsp_r1_replv_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_replv_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt = 0x12345678;
     result = 0x56785678;
     __asm
diff --git a/tests/tcg/mipsel/test_dsp_r1_replv_qb.c b/tests/tcg/mipsel/test_dsp_r1_replv_qb.c
index dd1271fedff0..a65b9299f976 100644
--- a/tests/tcg/mipsel/test_dsp_r1_replv_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_replv_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt     = 0x12345678;
     result = 0x78787878;
     __asm
diff --git a/tests/tcg/mipsel/test_dsp_r1_shilo.c b/tests/tcg/mipsel/test_dsp_r1_shilo.c
index ce8ebc69c2ac..1066600f3085 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shilo.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shilo.c
@@ -6,6 +6,8 @@ int main()
     int ach, acl;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0xBBAACCFF;
     acl = 0x1C3B001D;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_shilov.c b/tests/tcg/mipsel/test_dsp_r1_shilov.c
index e1d6cea4b6de..aa7838fdb96e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shilov.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shilov.c
@@ -6,6 +6,8 @@ int main()
     int rs, ach, acl;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs  = 0x0F;
     ach = 0xBBAACCFF;
     acl = 0x1C3B001D;
diff --git a/tests/tcg/mipsel/test_dsp_r1_shll_ph.c b/tests/tcg/mipsel/test_dsp_r1_shll_ph.c
index 5fa58ccf6374..7090aa5766bd 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shll_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shll_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt        = 0x12345678;
     result    = 0xA000C000;
     resultdsp = 1;
diff --git a/tests/tcg/mipsel/test_dsp_r1_shll_qb.c b/tests/tcg/mipsel/test_dsp_r1_shll_qb.c
index 729716d62618..7234f7229dd0 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shll_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shll_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt     = 0x87654321;
     result  = 0x87654321;
     resultdsp = 0x00;
diff --git a/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c
index 910fea3b317e..1cfc6222fe13 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt        = 0x12345678;
     result    = 0x7FFF7FFF;
     resultdsp = 0x01;
diff --git a/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c b/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c
index 628c7521027b..9ba756ca4fe7 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt        = 0x82345678;
     result    = 0x82345678;
     resultdsp = 0x00;
diff --git a/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c b/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c
index f98a6322dc1d..834189585424 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs        = 0x0;
     rt        = 0x12345678;
     result    = 0x12345678;
diff --git a/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c b/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c
index 6d8ff4a259ba..2db00c662a88 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x03;
     rt     = 0x87654321;
     result = 0x38281808;
diff --git a/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c
index fc9bd32765b8..51a7f6a35516 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs        = 0x0;
     rt        = 0x12345678;
     result    = 0x12345678;
diff --git a/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c b/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c
index 350c25617adc..752c9a2615fb 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs        = 0x0B;
     rt        = 0x12345678;
     result    = 0x7FFFFFFF;
diff --git a/tests/tcg/mipsel/test_dsp_r1_shra_ph.c b/tests/tcg/mipsel/test_dsp_r1_shra_ph.c
index 5b2d840a6bc5..625a2289051a 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shra_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shra_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt     = 0x87654321;
     result = 0xF0EC0864;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c b/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c
index adc4ae68bdc3..10608405f232 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt     = 0x87654321;
     result = 0xF0ED0864;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c b/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c
index ec0cf2c72ccb..cd71c81e1e95 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt     = 0x87654321;
     result = 0xF0ECA864;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c b/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c
index 6e42aaf8e1a7..a0750eb5a9bc 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x03;
     rt     = 0x87654321;
     result = 0xF0EC0864;
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c b/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c
index f03b978d0544..b944765a494c 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x03;
     rt     = 0x87654321;
     result = 0xF0ED0864;
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c b/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c
index 2ab03bb5daae..002466d1c15d 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x03;
     rt     = 0x87654321;
     result = 0xF0ECA864;
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c b/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c
index a7e4e6a5e4f5..d00d69f82413 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt     = 0x12345678;
     result = 0x00010203;
 
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c b/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c
index db77f6d0e117..1f8f8852c205 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x05;
     rt     = 0x12345678;
     result = 0x00010203;
diff --git a/tests/tcg/mipsel/test_dsp_r1_subq_ph.c b/tests/tcg/mipsel/test_dsp_r1_subq_ph.c
index fdd7b38b647e..8c9a3abdfe92 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subq_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subq_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x77777777;
     rt = 0x67654321;
     result    = 0x10123456;
diff --git a/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c
index 64c89ebd5114..7436af4ce95b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result    = 0x7FFF1357;
diff --git a/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c
index 9d456a90f417..bd74f731d75e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result    = 0x7FFFFFFF;
diff --git a/tests/tcg/mipsel/test_dsp_r1_subu_qb.c b/tests/tcg/mipsel/test_dsp_r1_subu_qb.c
index 420909615526..4161424a8d37 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subu_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subu_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result    = 0x8BCF1357;
diff --git a/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c b/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c
index 3d650533d171..4ac17d051b05 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result    = 0x00001357;
diff --git a/tests/tcg/mipsel/test_dsp_r1_wrdsp.c b/tests/tcg/mipsel/test_dsp_r1_wrdsp.c
index dc54943a99e8..bd6e163d343e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_wrdsp.c
+++ b/tests/tcg/mipsel/test_dsp_r1_wrdsp.c
@@ -7,6 +7,8 @@ int main()
     int ccond_i, outflag_i, efi_i, c_i, scount_i, pos_i;
     int ccond_o, outflag_o, efi_o, c_o, scount_o, pos_o;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ccond_i   = 0x000000BC;  /* 4 */
     outflag_i = 0x0000001B;  /* 3 */
     efi_i     = 0x00000001;  /* 5 */
diff --git a/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c b/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c
index af4683f30475..5269a7eb4692 100644
--- a/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c
@@ -6,6 +6,8 @@ int main()
     int input, result, dsp;
     int hope;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     input = 0x701BA35E;
     hope  = 0x701B5D5E;
 
diff --git a/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c b/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c
index 921f0eaf33c7..797386d9d9ba 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x706A13FE;
     rt     = 0x13065174;
     result = 0x41B832B9;
diff --git a/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c b/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c
index 213ba3725006..8bcb48f1d18d 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x706A13FE;
     rt     = 0x13065174;
     result = 0x41B832B9;
diff --git a/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c b/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c
index 75a75c50f32d..046ccbf8bd24 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x00000010;
     rt     = 0x00000001;
     result = 0x00000009;
diff --git a/tests/tcg/mipsel/test_dsp_r2_addqh_w.c b/tests/tcg/mipsel/test_dsp_r2_addqh_w.c
index de6926ebbb72..224e20e43691 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addqh_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addqh_w.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x00000010;
     rt     = 0x00000001;
     result = 0x00000008;
diff --git a/tests/tcg/mipsel/test_dsp_r2_addu_ph.c b/tests/tcg/mipsel/test_dsp_r2_addu_ph.c
index 1d7a25a2a773..9511a29ae14f 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addu_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addu_ph.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x00FF00FF;
     rt     = 0x00010001;
     result = 0x01000100;
diff --git a/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c
index 979651bfc9ac..0b7c09bbd63d 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x00FE00FE;
     rt     = 0x00020001;
     result = 0x010000FF;
diff --git a/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c b/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c
index a1f5d631b52e..6f82890be468 100644
--- a/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0xFF0055AA;
     rt     = 0x0113421B;
     result = 0x80094B62;
diff --git a/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c
index 81e98c190d2b..5ed7c1825c3b 100644
--- a/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0xFF0055AA;
     rt     = 0x01112211;
     result = 0x80093C5E;
diff --git a/tests/tcg/mipsel/test_dsp_r2_append.c b/tests/tcg/mipsel/test_dsp_r2_append.c
index 9a91e1650dbd..b9437c6b1d2b 100644
--- a/tests/tcg/mipsel/test_dsp_r2_append.c
+++ b/tests/tcg/mipsel/test_dsp_r2_append.c
@@ -6,6 +6,8 @@ int main()
     int rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0xFF0055AA;
     rt     = 0x0113421B;
     result = 0x02268436;
diff --git a/tests/tcg/mipsel/test_dsp_r2_balign.c b/tests/tcg/mipsel/test_dsp_r2_balign.c
index 537cf0451cc8..4c68722f2779 100644
--- a/tests/tcg/mipsel/test_dsp_r2_balign.c
+++ b/tests/tcg/mipsel/test_dsp_r2_balign.c
@@ -6,6 +6,8 @@ int main()
     int rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0xFF0055AA;
     rt     = 0x0113421B;
     result = 0x13421BFF;
diff --git a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
index 2d6340d6fb12..6314772051bd 100644
--- a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x11777066;
     rt = 0x55AA70FF;
     result = 0x02;
diff --git a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
index a0ecdca2ac2e..ec612e204dad 100644
--- a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs         = 0x11777066;
     rt         = 0x55AA70FF;
     result     = 0x0F;
diff --git a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
index dba99e392c29..cbdcdc78dc8e 100644
--- a/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
@@ -7,6 +7,8 @@ int main()
     int dsp;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs         = 0x11777066;
     rt         = 0x55AA70FF;
     result     = 0x0D;
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
index fae49f10eb95..3b58d4c66863 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
@@ -7,6 +7,8 @@ int main()
     int ach = 5, acl = 5;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x00FF00FF;
     rt     = 0x00010002;
     resulth = 0x05;
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
index ce8783024685..a7926b423f48 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
@@ -7,6 +7,8 @@ int main()
     int ach = 5, acl = 5;
     int resulth, resultl, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x800000FF;
     rt     = 0x00018000;
     resulth = 0x05;
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
index d551d64ae293..e7a4e5ff255d 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
@@ -7,6 +7,8 @@ int main()
     int ach, acl;
     int resulth, resultl, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x00000005;
     acl = 0x00000005;
     rs     = 0x00FF00FF;
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
index 514797cfd1b4..f925c97ae12d 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
@@ -7,6 +7,8 @@ int main()
     int ach = 5, acl = 5;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x00FF00FF;
     rt     = 0x00010002;
     resulth = 0x05;
diff --git a/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
index f51f9b9d13d7..56393dd21b53 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
@@ -7,6 +7,8 @@ int main()
     int ach = 5, acl = 5;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x00FF00FF;
     rt     = 0x00010002;
     resulth = 0x04;
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
index e40543fd8292..ce711058d3a6 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
@@ -7,6 +7,8 @@ int main()
     int ach = 5, acl = 5;
     int resulth, resultl, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs      = 0xBC0123AD;
     rt      = 0x01643721;
     resulth = 0x00000005;
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
index 7da278eacc0e..6177894090ed 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
@@ -7,6 +7,8 @@ int main()
     int ach = 5, acl = 5;
     int resulth, resultl, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0xBC0123AD;
     rt = 0x01643721;
     resulth = 0x00;
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
index bb49a4031d34..ac508e25c9f3 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
@@ -7,6 +7,8 @@ int main()
     int ach = 5, acl = 5;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs      = 0xBC0123AD;
     rt      = 0x01643721;
     resulth = 0x05;
diff --git a/tests/tcg/mipsel/test_dsp_r2_mul_ph.c b/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
index c7e9d60d12e2..d8c3b6a1be7b 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x03FB1234;
     rt = 0x0BCC4321;
     result = 0xF504F4B4;
diff --git a/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
index 33da110de869..6feac41dd6e5 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x03FB1234;
     rt = 0x0BCC4321;
     result = 0x7fff7FFF;
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c b/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
index 7ba633bc17f7..5754484735dd 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x80001234;
     rt = 0x80004321;
     result = 0x7FFFAAAB;
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
index 00e015542e69..132f50d0a899 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x80000000;
     rt = 0x0ffc0000;
     result = 0xF0040000;
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c b/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
index 9c2be06cc08a..ffc802fb0e66 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x80001234;
     rt = 0x80004321;
     result = 0x7FFFAAAB;
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
index a6940939ca50..d55031f82d58 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
@@ -6,6 +6,8 @@ int main()
     int rs, rt, ach, acl;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x05;
     acl = 0x00BBDDCC;
     rs = 0x80001234;
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
index 06c91a43e7ea..3ec7b4c50b5b 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
@@ -6,6 +6,8 @@ int main()
     int rs, rt, ach, acl;
     int resulth, resultl;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     ach = 0x05;
     acl = 0x00BBDDCC;
     rs = 0x80001234;
diff --git a/tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c b/tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c
index 3a2b3fde0573..ee7eb8f99b80 100644
--- a/tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0x34786521;
diff --git a/tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c b/tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c
index 5c9baab03d00..48bbf3ce49ac 100644
--- a/tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c
@@ -6,6 +6,8 @@ int main()
     int rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0x43215678;
diff --git a/tests/tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c b/tests/tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c
index 6474a108c057..396449764ae3 100644
--- a/tests/tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c
@@ -6,6 +6,8 @@ int main()
     int rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0x43215678;
diff --git a/tests/tcg/mipsel/test_dsp_r2_prepend.c b/tests/tcg/mipsel/test_dsp_r2_prepend.c
index f6bcd47b2da9..736a4e2dd499 100644
--- a/tests/tcg/mipsel/test_dsp_r2_prepend.c
+++ b/tests/tcg/mipsel/test_dsp_r2_prepend.c
@@ -6,6 +6,8 @@ int main()
     int rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0x87654321;
diff --git a/tests/tcg/mipsel/test_dsp_r2_shra_qb.c b/tests/tcg/mipsel/test_dsp_r2_shra_qb.c
index 48193de87ad0..530b79d39068 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shra_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shra_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt = 0x12345678;
     result = 0x02060A0F;
 
diff --git a/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c
index 29afa0e4b07b..d38f4cb70825 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt = 0x12345678;
     result = 0x02070B0F;
 
diff --git a/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c b/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c
index b21e1b7ca64a..2627285ac08d 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x03;
     rt = 0x12345678;
     result = 0x02060A0F;
diff --git a/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c
index 9ea8aa0cbb90..7527e4ef4fb5 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x03;
     rt = 0x12345678;
     result = 0x02070B0F;
diff --git a/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c b/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c
index 724b9a7a4691..8ce0a4ef26a1 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rt     = 0x12345678;
     result = 0x009102B3;
 
diff --git a/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c b/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c
index ac79aa69acf0..7bff8170422a 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs     = 0x05;
     rt     = 0x12345678;
     result = 0x009102B3;
diff --git a/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c b/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c
index dbc096734ceb..cadd988dea43 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0x456709AB;
diff --git a/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c b/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c
index 24ef0f1aeb91..53a2e677c6bf 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0x456809AC;
diff --git a/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c b/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c
index d460f8630fae..fc97a1984cef 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0x456789AC;
diff --git a/tests/tcg/mipsel/test_dsp_r2_subqh_w.c b/tests/tcg/mipsel/test_dsp_r2_subqh_w.c
index 42be3deb80a3..6c8db811b935 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subqh_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subqh_w.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0x456789AB;
diff --git a/tests/tcg/mipsel/test_dsp_r2_subu_ph.c b/tests/tcg/mipsel/test_dsp_r2_subu_ph.c
index 0d39a017c79d..209d88c2c7b2 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subu_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subu_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x87654321;
     rt = 0x11111111;
     result    = 0x76543210;
diff --git a/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c
index 8e4da4f3e544..0ca208fe4bca 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt, dsp;
     int result, resultdsp;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x87654321;
     rt = 0x12345678;
     result    = 0x75310000;
diff --git a/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c b/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c
index 92cfc764b8c9..0dce73bbea39 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0xC5E7092B;
diff --git a/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c
index dac81d47db60..dc83aa5907aa 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c
@@ -6,6 +6,8 @@ int main()
     int rd, rs, rt;
     int result;
 
+    __asm("wrdsp $zero, 0x3f\n\t");
+
     rs = 0x12345678;
     rt = 0x87654321;
     result = 0xC6E80A2C;
-- 
2.55.0


