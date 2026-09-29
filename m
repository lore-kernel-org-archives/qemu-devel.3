Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617E2CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSC-000341-1I; Tue, 29 Sep 2026 03:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSS9-00033I-Vd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSS4-0005o7-2W
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:41 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7U1684087187
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1feSs4MlC9Y
 ZDZzEA+daQuqqh8V9w/ch8Qdu5MJCY4w=; b=j7Dpdz0hon4VCPhPjs3NyQrcjR7
 gnHnsJuTKyQSqE0lP7PDO9JZTcb8Q0ZSqqrHUz3GenAoPpMEixDAB7aO5uzwRNG9
 8kzvSRHDvBuzLbbVzqgYLujaBAADo7B8ee/y1hXWTpt6HKG3H0IaMvgpP839/ao5
 FPeT1OhtAMJD25UZdpgbD9A2SBNDt7Wc8pVOwxlwzLdj7zigdznLkGozVy6/jJDy
 rZYn7y4zPnUtFZI/mg+h4/pK8/ncXPGjvtNuioO9tmVOqE/D0cK/7nkFTwwFoD8X
 //yrZ9Omau8f39SfS2c4NG0RnDFPycnk8wzPPDqUsjrCzKXIapOw9gnTj2w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4su77-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:34 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14388664b04so600059c88.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667633; x=1791272433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1feSs4MlC9YZDZzEA+daQuqqh8V9w/ch8Qdu5MJCY4w=;
 b=gMIFEN27VQa9PsYzxh3HtzL6UEFSb8YF+984frjUVaY8fHdl2YW9u8Pkvq1BH9U/Dq
 Ond9Kj0zlYVfLSqkMkDrvldeIFCgM5AIS6YQBQOiDc6nWshXIlzP8DoKBfptPiL43XbZ
 yM9Lw297KqvmycvYLyelqpmL7rUYvCPITxN+4B6lAkm+eCJdS5LAW99VUBny97QuJKR8
 P+JjgOy0rDQIoOAJuNpvSgMk3ZEZx4Xn0otdd3CGxzLDx51FZKr1D6hVxES8V9l8AUuf
 LPoOyqhcN7bX9Y67Af7BBlD2AuEwtf9xbHJzzp6e8IMeMZKcgKh4LERgWpcyUdroLQWA
 nkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667633; x=1791272433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1feSs4MlC9YZDZzEA+daQuqqh8V9w/ch8Qdu5MJCY4w=;
 b=Vb0L7C1JgDTMpdi0MvyrEtC8WVCInrVOwfyDPNrm9vAAlCRnKNYn8sEUk7GM07GzYN
 IKuogfYshk9igGVIPgIc2HtdnvQ7Dys6wp9aRfYtuZ/0QRqBsDCGWbCVdbVfymZkX3xz
 S15Y66x22MCOiAusWnoush0WcmCfzG872LAM+c8PTMd+YojjkpqjhzqBt+ioOBs0mRRV
 YyNEvj7xD0O5rWkR8OdIf6joJ9/L4dHOOAABNmkf9Fp6x7DiSMSfBmlycp4Iowvt16V4
 f6NbeuKAo9NaNI+/KNFHq4MGN/WVYDDPtzR95WmnHfuYkXcT4VHdmlZoBl8orVbAuVW9
 epww==
X-Gm-Message-State: AFuF++kWHnEoL1RdD/yzOOYMtSeMwsFnYA7oXhAEu8iriRi8q4hPfcpH
 MvYsTJH3teYboOr0QINnnjQeNsJN/yjHsbAIApwPpUcn64NSh26jw+AKLC6fKRg7yaL3j5Ymu/2
 Q+bPzaO2cFf13TrjLzXCNxt0vU5TlNvvubI3XdAzHpISvRHus81CKshy/GMBoVhzv3g==
X-Gm-Gg: AYBFou3x+3aX1dz8IMDcQjlPhxsWK4Y/1zTm8LTUmqbUYYn+ZjdLnvEHpeaecyY/XXn
 PenHCZ8mSsJ7RmgNNU0eLxcQOLPad0SV+wM97b8FGNsQdTFXzzWKd8o3YFZKAfL37rlVE2TFXT6
 735OS28uAVueZHTG/XjaJoTt2qfFH5+f6OB2+Y6qbfKDVFcEVJnBrAKLB+h3niHfHN+IjKcQNzF
 sFAWJSswu70iudmgETSmPB4o6HanY4PpxFS+rhUJRXE0U8u+B26OgDMvj/Vt8rMo1ogUrsoBAuO
 xq8CIG+/rg+GGdNIcUhiTgEmUvKLRhyz1km26mvhMb4rJojAZbsWgO0QJ4NP5UDle9ciAbW3dHt
 v/CI6uYlRr4InPACZnxOw2D8moKXI1tMTUsviu9WhHDh1d9iKNrYIPF54xA==
X-Received: by 2002:a05:7022:ff49:b0:148:516e:53e with SMTP id
 a92af1059eb24-14b2d89e1bcmr2968987c88.6.1790667632701; 
 Tue, 29 Sep 2026 00:40:32 -0700 (PDT)
X-Received: by 2002:a05:7022:ff49:b0:148:516e:53e with SMTP id
 a92af1059eb24-14b2d89e1bcmr2968898c88.6.1790667631578; 
 Tue, 29 Sep 2026 00:40:31 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 01/19] tests/tcg/mipsel: move dsp sources
Date: Tue, 29 Sep 2026 07:39:49 +0000
Message-ID: <20260929074007.118970-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX2ow1ABPhDH3+
 2PG+27zgWzI+0GeGUy7lyFOA+ui0XCI3fxfmq/HJtYww01Z9xIjjaAqZbBU3F5Cb96osOrUdhzf
 7AxBFIjGTLcBnOE577Gtte4RtktWNx4=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abb6b72 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=sw0IbGe5VMtlCODVeQsA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX00+mC/Gs9Utw
 SCIClRM5/ZJilxzUKvxh05Gb5y1y6jm7Ek6PGpjVDXrVekVgwlIqX4MzkeQNqGHuKKtTyj4QMA+
 4E12JD4bXDH3iEw/l+L6BESR8ii3EcAyyM7KwNHxuczNOS7kpbK3H51CEjlSyv6pPtAjHP3zfvO
 Md4rhSXHmVT5BpHoNi4aHrEvsL50QRaJADl06c8qx6JJvBgC6PYmUvgaDyuPljRwU6mmkJ/qSP5
 Ff/T9fxvAzlDZWzhjzN+548YN+BcuePlBNj7A5jP6CYHWwm8d5PddxMZ3cnXrVj7aj7HUncseHT
 xCQne1B3S38k4H3CB7JUaDcywDz8PtmCCjXUmXc9F5DYzw82M9pXNGrsvoaj+2y/6eZ1Q635Ufn
 3nMHyiE7qn6mOJYWWIKd5zmYCyXP47MDKLNgol8qg98MQEpBRGN3Q2yEXnPqSO0wbCG8JECEk5q
 DUy9Rqf/8Db1KAUnprQ==
X-Proofpoint-GUID: MV6qZFFcdPqrNbM62QyfADragSqalFJU
X-Proofpoint-ORIG-GUID: MV6qZFFcdPqrNbM62QyfADragSqalFJU
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/{mips/user/ase/dsp => mipsel}/Makefile                  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_absq_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_absq_s_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_s_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addsc.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addu_qb.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addu_s_qb.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addwc.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_bitrev.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_bposge32.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_eq_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_le_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_lt_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_eq_qb.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_le_qb.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_lt_qb.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_eq_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_le_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_lt_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpaq_s_w_ph.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpaq_sa_l_w.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbl.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbr.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsq_s_w_ph.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsq_sa_l_w.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbl.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbr.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extp.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpdp.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpdpv.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpv.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_r_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_rs_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_s_h.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_w.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_r_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_rs_w.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_s_h.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_w.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_insv.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lbux.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lhx.c         | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lwx.c         | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_madd.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maddu.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_main.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phl.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phr.c | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phl.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phr.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mfhi.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mflo.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_modsub.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_msub.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_msubu.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mthi.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mthlip.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mtlo.c        | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phl.c | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phr.c | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbl.c    | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbr.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mulq_rs_ph.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mult.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_multu.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_packrl_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_pick_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_pick_qb.c     | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceq_w_phl.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceq_w_phr.c  | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbl.c    | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbla.c   | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbr.c    | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbra.c   | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbl.c | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbla.c    | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbr.c | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbra.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_ph_w.c | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_qb_ph.c  | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_rs_ph_w.c    | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrqu_s_qb_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_raddu_w_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_rddsp.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_repl_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_repl_qb.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_replv_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_replv_qb.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shilo.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shilov.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_qb.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_s_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_qb.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_s_ph.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_s_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_r_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_r_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_r_ph.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_r_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrl_qb.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrlv_qb.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_s_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subu_qb.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subu_s_qb.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_wrdsp.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_absq_s_qb.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_r_ph.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_r_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_w.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addu_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addu_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_adduh_qb.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_adduh_r_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_append.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_balign.c      | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_eq_qb.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_le_qb.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_lt_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpa_w_ph.c    | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpaqx_s_w_ph.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpaqx_sa_w_ph.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpax_w_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dps_w_ph.c    | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsqx_s_w_ph.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsqx_sa_w_ph.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsx_w_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mul_ph.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mul_s_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_rs_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_s_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulsa_w_ph.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulsaq_s_w_ph.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_qb_ph.c | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_sra_ph_w.c    | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_sra_r_ph_w.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_prepend.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shra_qb.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shra_r_qb.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrav_qb.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrav_r_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrl_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrlv_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_r_ph.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_r_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_w.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subu_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subu_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subuh_qb.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subuh_r_qb.c  | 0
 161 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/Makefile (100%)
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
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_rs_w.c (100%)
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

diff --git a/tests/tcg/mips/user/ase/dsp/Makefile b/tests/tcg/mipsel/Makefile
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/Makefile
rename to tests/tcg/mipsel/Makefile
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_w.c
rename to tests/tcg/mipsel/test_dsp_r1_absq_s_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_ph.c b/tests/tcg/mipsel/test_dsp_r1_addq_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_addq_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_w.c
rename to tests/tcg/mipsel/test_dsp_r1_addq_s_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addsc.c b/tests/tcg/mipsel/test_dsp_r1_addsc.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addsc.c
rename to tests/tcg/mipsel/test_dsp_r1_addsc.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_qb.c b/tests/tcg/mipsel/test_dsp_r1_addu_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_addu_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_s_qb.c b/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_s_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addwc.c b/tests/tcg/mipsel/test_dsp_r1_addwc.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addwc.c
rename to tests/tcg/mipsel/test_dsp_r1_addwc.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_bitrev.c b/tests/tcg/mipsel/test_dsp_r1_bitrev.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_bitrev.c
rename to tests/tcg/mipsel/test_dsp_r1_bitrev.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_bposge32.c b/tests/tcg/mipsel/test_dsp_r1_bposge32.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_bposge32.c
rename to tests/tcg/mipsel/test_dsp_r1_bposge32.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_eq_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_eq_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_le_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_le_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_lt_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_lt_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_eq_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_le_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_le_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_lt_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_eq_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_le_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_le_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_lt_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_s_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_sa_l_w.c b/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_sa_l_w.c
rename to tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbl.c b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbl.c
rename to tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbr.c b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbr.c
rename to tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_s_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_sa_l_w.c b/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_sa_l_w.c
rename to tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbl.c b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbl.c
rename to tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbr.c b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbr.c
rename to tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extp.c b/tests/tcg/mipsel/test_dsp_r1_extp.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extp.c
rename to tests/tcg/mipsel/test_dsp_r1_extp.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdp.c b/tests/tcg/mipsel/test_dsp_r1_extpdp.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdp.c
rename to tests/tcg/mipsel/test_dsp_r1_extpdp.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdpv.c b/tests/tcg/mipsel/test_dsp_r1_extpdpv.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdpv.c
rename to tests/tcg/mipsel/test_dsp_r1_extpdpv.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpv.c b/tests/tcg/mipsel/test_dsp_r1_extpv.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpv.c
rename to tests/tcg/mipsel/test_dsp_r1_extpv.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_r_w.c b/tests/tcg/mipsel/test_dsp_r1_extr_r_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_r_w.c
rename to tests/tcg/mipsel/test_dsp_r1_extr_r_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_rs_w.c b/tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_rs_w.c
rename to tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_s_h.c b/tests/tcg/mipsel/test_dsp_r1_extr_s_h.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_s_h.c
rename to tests/tcg/mipsel/test_dsp_r1_extr_s_h.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_w.c b/tests/tcg/mipsel/test_dsp_r1_extr_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_w.c
rename to tests/tcg/mipsel/test_dsp_r1_extr_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_r_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_r_w.c
rename to tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_rs_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_rs_w.c
rename to tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_s_h.c b/tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_s_h.c
rename to tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_w.c
rename to tests/tcg/mipsel/test_dsp_r1_extrv_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_insv.c b/tests/tcg/mipsel/test_dsp_r1_insv.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_insv.c
rename to tests/tcg/mipsel/test_dsp_r1_insv.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lbux.c b/tests/tcg/mipsel/test_dsp_r1_lbux.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_lbux.c
rename to tests/tcg/mipsel/test_dsp_r1_lbux.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lhx.c b/tests/tcg/mipsel/test_dsp_r1_lhx.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_lhx.c
rename to tests/tcg/mipsel/test_dsp_r1_lhx.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lwx.c b/tests/tcg/mipsel/test_dsp_r1_lwx.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_lwx.c
rename to tests/tcg/mipsel/test_dsp_r1_lwx.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_madd.c b/tests/tcg/mipsel/test_dsp_r1_madd.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_madd.c
rename to tests/tcg/mipsel/test_dsp_r1_madd.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maddu.c b/tests/tcg/mipsel/test_dsp_r1_maddu.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_maddu.c
rename to tests/tcg/mipsel/test_dsp_r1_maddu.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_main.c b/tests/tcg/mipsel/test_dsp_r1_main.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_main.c
rename to tests/tcg/mipsel/test_dsp_r1_main.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phl.c
rename to tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phr.c
rename to tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phl.c
rename to tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phr.c
rename to tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mfhi.c b/tests/tcg/mipsel/test_dsp_r1_mfhi.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mfhi.c
rename to tests/tcg/mipsel/test_dsp_r1_mfhi.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mflo.c b/tests/tcg/mipsel/test_dsp_r1_mflo.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mflo.c
rename to tests/tcg/mipsel/test_dsp_r1_mflo.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_modsub.c b/tests/tcg/mipsel/test_dsp_r1_modsub.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_modsub.c
rename to tests/tcg/mipsel/test_dsp_r1_modsub.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_msub.c b/tests/tcg/mipsel/test_dsp_r1_msub.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_msub.c
rename to tests/tcg/mipsel/test_dsp_r1_msub.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_msubu.c b/tests/tcg/mipsel/test_dsp_r1_msubu.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_msubu.c
rename to tests/tcg/mipsel/test_dsp_r1_msubu.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthi.c b/tests/tcg/mipsel/test_dsp_r1_mthi.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthi.c
rename to tests/tcg/mipsel/test_dsp_r1_mthi.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthlip.c b/tests/tcg/mipsel/test_dsp_r1_mthlip.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthlip.c
rename to tests/tcg/mipsel/test_dsp_r1_mthlip.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mtlo.c b/tests/tcg/mipsel/test_dsp_r1_mtlo.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mtlo.c
rename to tests/tcg/mipsel/test_dsp_r1_mtlo.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phl.c
rename to tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phr.c
rename to tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c
rename to tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c
rename to tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mulq_rs_ph.c b/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mulq_rs_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mult.c b/tests/tcg/mipsel/test_dsp_r1_mult.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mult.c
rename to tests/tcg/mipsel/test_dsp_r1_mult.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_multu.c b/tests/tcg/mipsel/test_dsp_r1_multu.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_multu.c
rename to tests/tcg/mipsel/test_dsp_r1_multu.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_packrl_ph.c b/tests/tcg/mipsel/test_dsp_r1_packrl_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_packrl_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_packrl_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_ph.c b/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_pick_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_qb.c b/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_pick_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phl.c
rename to tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phr.c
rename to tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbl.c
rename to tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbla.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbla.c
rename to tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbr.c
rename to tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbra.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbra.c
rename to tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbl.c
rename to tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbla.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbla.c
rename to tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbr.c
rename to tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbra.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbra.c
rename to tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_ph_w.c b/tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_ph_w.c
rename to tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_qb_ph.c b/tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_qb_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_rs_ph_w.c b/tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_rs_ph_w.c
rename to tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c b/tests/tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_raddu_w_qb.c b/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_raddu_w_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_rddsp.c b/tests/tcg/mipsel/test_dsp_r1_rddsp.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_rddsp.c
rename to tests/tcg/mipsel/test_dsp_r1_rddsp.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_ph.c b/tests/tcg/mipsel/test_dsp_r1_repl_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_repl_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_qb.c b/tests/tcg/mipsel/test_dsp_r1_repl_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_repl_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_ph.c b/tests/tcg/mipsel/test_dsp_r1_replv_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_replv_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_qb.c b/tests/tcg/mipsel/test_dsp_r1_replv_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_replv_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilo.c b/tests/tcg/mipsel/test_dsp_r1_shilo.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilo.c
rename to tests/tcg/mipsel/test_dsp_r1_shilo.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilov.c b/tests/tcg/mipsel/test_dsp_r1_shilov.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilov.c
rename to tests/tcg/mipsel/test_dsp_r1_shilov.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_ph.c b/tests/tcg/mipsel/test_dsp_r1_shll_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shll_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_qb.c b/tests/tcg/mipsel/test_dsp_r1_shll_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_shll_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_w.c b/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_w.c
rename to tests/tcg/mipsel/test_dsp_r1_shll_s_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_ph.c b/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shllv_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_qb.c b/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_shllv_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_w.c b/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_w.c
rename to tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_ph.c b/tests/tcg/mipsel/test_dsp_r1_shra_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shra_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_ph.c b/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_w.c b/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_w.c
rename to tests/tcg/mipsel/test_dsp_r1_shra_r_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_ph.c b/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shrav_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_ph.c b/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_w.c b/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_w.c
rename to tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrl_qb.c b/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrl_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_shrl_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrlv_qb.c b/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrlv_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_ph.c b/tests/tcg/mipsel/test_dsp_r1_subq_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_subq_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_w.c
rename to tests/tcg/mipsel/test_dsp_r1_subq_s_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_qb.c b/tests/tcg/mipsel/test_dsp_r1_subu_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_subu_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_s_qb.c b/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_s_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_wrdsp.c b/tests/tcg/mipsel/test_dsp_r1_wrdsp.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_wrdsp.c
rename to tests/tcg/mipsel/test_dsp_r1_wrdsp.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_absq_s_qb.c b/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_absq_s_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_ph.c b/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_addqh_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_ph.c b/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_w.c b/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_w.c
rename to tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_w.c b/tests/tcg/mipsel/test_dsp_r2_addqh_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_w.c
rename to tests/tcg/mipsel/test_dsp_r2_addqh_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_ph.c b/tests/tcg/mipsel/test_dsp_r2_addu_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_addu_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_qb.c b/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_adduh_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_r_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_append.c b/tests/tcg/mipsel/test_dsp_r2_append.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_append.c
rename to tests/tcg/mipsel/test_dsp_r2_append.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_balign.c b/tests/tcg/mipsel/test_dsp_r2_balign.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_balign.c
rename to tests/tcg/mipsel/test_dsp_r2_balign.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_le_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_le_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpa_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpax_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpax_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dps_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dps_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsx_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsx_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_ph.c b/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_mul_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_rs_w.c b/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_rs_w.c
rename to tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_w.c b/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_w.c
rename to tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsa_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_qb_ph.c b/tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_qb_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_ph_w.c b/tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_ph_w.c
rename to tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c b/tests/tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c
rename to tests/tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_prepend.c b/tests/tcg/mipsel/test_dsp_r2_prepend.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_prepend.c
rename to tests/tcg/mipsel/test_dsp_r2_prepend.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_qb.c b/tests/tcg/mipsel/test_dsp_r2_shra_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_shra_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_r_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_qb.c b/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_shrav_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_r_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrl_ph.c b/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrl_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_shrl_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrlv_ph.c b/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrlv_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_ph.c b/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_subqh_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_ph.c b/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_w.c b/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_w.c
rename to tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_w.c b/tests/tcg/mipsel/test_dsp_r2_subqh_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_w.c
rename to tests/tcg/mipsel/test_dsp_r2_subqh_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_ph.c b/tests/tcg/mipsel/test_dsp_r2_subu_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_subu_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_qb.c b/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_subuh_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_r_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c
-- 
2.43.0


