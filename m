Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16858C9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAGn2-0000Ja-Ha; Fri, 25 Sep 2026 21:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAGmq-0000IX-J3
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 21:01:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAGmm-00067I-SA
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 21:01:08 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PNcqQN1136014
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dcPOu1WBy0Y5SKmH3N7AOX
 BmJm27MvpFkumMZp08rU4=; b=N/8khBrOtvftawiNMxSSfLf6Mm7l3F+LMD78IC
 3VVkzM+VYgZMirAVGCXPdTgPhY2doaI7YeQreaXVV0gTUjIYdPtrXjMqZ80vsevU
 JLw4f+2Bo+pCwlfx/IF0OVsQhbip12t/6i8bMr6jzj8RaFAMhkco0IvDHSZBd4Fx
 4zUA/UMcPSCmHuDJXwA/tnEMsroJWejTVrCb6E1yBcmx4BsJ8xX1G9wp4GiLOkqp
 KmT6slyrV6/MVBGUhyKBI8Yo3mDoPXAm/CGba1LywrFDubl+816ZfasECKkgo3Eb
 2ijyhJgPTQgDyS/7hVF+o2As0Yt4fYzmkmNHJsHlSnR8IjNg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwhm53v22-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:01:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39de1f85cb2so1614252a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 18:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790384461; x=1790989261; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dcPOu1WBy0Y5SKmH3N7AOXBmJm27MvpFkumMZp08rU4=;
 b=dXRv/BY9i6k6Hcfqg+yMQWv5+trG5vrBVnBnX80soUXzKHGnun7ky7Hhuc/Ar1tYNV
 96s1Fv7AtsST3GsdJ4IrhdUUbp1yp+Mta078aJtMcYT1W4Hq13AaBrSiuJRt4YVUcKmv
 jk2gks4FMwkLWh+O9k0uzZRBtuCDQ48T2LXkB6+WBDAB7FNfmLcnCXQP3o8+oyFouEQg
 ODlR4WUb5qa0sFO4VEEnPXCU8HNvKUQtyBku62KXuYmBVcjEXLUYAggtwLXVNx7fIAtu
 Ybd27MqNLmrQtHUFQ5SteaC7MA3UKAFhamTmcIx7gXaCagKzj0T4PGaTSxlPua3/nu/T
 IEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790384461; x=1790989261;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dcPOu1WBy0Y5SKmH3N7AOXBmJm27MvpFkumMZp08rU4=;
 b=cNJfZ7QU6p2x9TsghH5E5M1OFlff6ZpjpEe6X8tSegWw51X1UhnAtjLvAojbOMwMLK
 R5JDzaeGO0MD1vTOQUOMUaQi+CG4EysJMHJDNuHT9W+BtHOywxTOet6zUPrAYH11f8/R
 o/wRjd4MltYpJ6amGGuRrRsNq3zq2albpn2KQpYKSzyOES0ey21VLg98UfKKtrdaOtuA
 VZt19capOnIDkyHWE6IUsZCXqiX+0Z49JwDI2I+5l7VE7wSHwbigVWK7Ad3mYGsEfnUO
 MqZ0VTKlItr8QhpErgk8+YUuG5ypJq9frNmA17PhAptg+gBrHDSIX1RQ/dKwFZg/U+4V
 MgcQ==
X-Gm-Message-State: AFuF++kSQTgona+xBDH+2xskiWYpP2vSms9UNZmMeGpQN4srGTtSheLg
 Vvkhs5xAZSm4IMsRLgXdzfsikKgDFpHLHCVBDu5W+RMOIK8ZGxESQ7JS3QL7iWYsXkKLIm2aUHF
 onX1Dh/ULCaozRSvGtp4VPF2bcxtlC9s+82WmCX3s9Q9y3Ly95jy/JU1Wz34lDd1cTg==
X-Gm-Gg: AYBFou0k/2qzbXYRYzQKSTneLHAShH4l3KObRLbshiCOOS8BCPKYV2wwXdar817bsbe
 bcuooGPk0I+Gv0gVTiRQ9v16aoeqV16H0e0+OrA3K3QR3m5DoLKan+DovVUedSe89q/I61tU/+G
 wNNh7YiB+mZich8etd+DTeOUqPYzjzEZ3XjY+86+zOQubpnoxWtD5FMYYw3xR44JxRzXyCmI1jE
 AYNRiBfHXHIIfPiNbaTpQY+dNSn0kHVT/XWae4Uzn36RmbOmM2WRWgN2W11co61qUIsqaIRQ7Ce
 bk02NcaZ0IpxzXJCTYHAIFgwZdI+Zr0jbYefcSv6Ve/MWbwZEdGom9q97npptNtxIrUWpAJA0KO
 Pn1QdGxQ21kUfzqPQZe9dlXQ6vZPGtQ7N1NQkWKWPNuGpoUjEmBcBMe3hk2dm
X-Received: by 2002:a17:90b:17c3:b0:3a0:7261:d58e with SMTP id
 98e67ed59e1d1-3a098b39ba8mr6116890a91.22.1790384460721; 
 Fri, 25 Sep 2026 18:01:00 -0700 (PDT)
X-Received: by 2002:a17:90b:17c3:b0:3a0:7261:d58e with SMTP id
 98e67ed59e1d1-3a098b39ba8mr6116860a91.22.1790384459868; 
 Fri, 25 Sep 2026 18:00:59 -0700 (PDT)
Received: from localhost.localdomain (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b898cabesm7138253a91.0.2026.09.25.18.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 18:00:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/5] tcg/tests: integrate some of mipsel tests
Date: Sat, 26 Sep 2026 01:00:48 +0000
Message-ID: <20260926010053.2840-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I8Zqn4IQXDIRSvlE1NfxD2XtKa3mOQt0
X-Authority-Analysis: v=2.4 cv=QYnzLcbv c=1 sm=1 tr=0 ts=6ab7194d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=PvdraAWqxjNkXReWDOIA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAwMyBTYWx0ZWRfX+qVW0H/ykux0
 +Gg7F04doop78Mk7IYzL5LBRog/tZ9sAFOOUt3PeMi0z9nC1MJbX87VnNx8A45QRd4HOTLb9HoH
 ie9JPb7qm/CJjgurMPlN7TzV0rLPtNqEDGO8k2CFGlut+hxCQEqCN5aq3D2zDfGD23NBr9wDuwc
 fdeh06p2ercAHlZBtAadPRJ/xORkB9Z4aXm6yaE6CEEQ4eQ4iWYehJdXAFdg3gAljy9ZmgKug6r
 85vH1SBt9l8cN8JImSsiSWp+H8DZKsvej21enStMFNaB8DWLHTH8jaVeTWdcp5IJQ8nhtFOmxLM
 KX3QdRCuRyea1U40jAkQWEYmVOzb7cB6KSssej5nUY2kUKusCUCvTnC5KQT8fqDZKkziVLxZJlU
 4b8Sxckt50iN8Ohu500Cf3dAD7D5j4OPVaHGmNH+rp9YWiQXL851e5F0ixzJZ3yqLM7UGNinE1E
 hhcZpyfpZsIZCDq8Xfw==
X-Proofpoint-ORIG-GUID: I8Zqn4IQXDIRSvlE1NfxD2XtKa3mOQt0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAwMyBTYWx0ZWRfX9amjv8J1IL0H
 MMg8KARRVwzKys0rqQ6sgTmtgnhqt0ch2DP9TlAh6qgVRU0Wyj5tn1p4mpYefXpEqQSDw7MHTi9
 aoyDoWHK0eTEH0nN8A+WeqreAsVP9ro=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260003
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

This series integrates tests from tests/tcg/mips/user/ase/dsp, and also adds
multiarch tests for mipsel target.

Pierrick Bouvier (5):
  tests/tcg/mipsel: move dsp sources
  tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c: fix compilation warning
  tests/tcg/mipsel: add dsp tests
  tests/tcg/mipsel: add float reference files
  tests/tcg/mipsel: add multiarch tests

 meson_options.txt                             |   4 +
 scripts/meson-buildoptions.sh                 |   2 +
 tests/tcg/meson.build                         |   1 +
 tests/tcg/mips/user/ase/dsp/Makefile          | 184 ----
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
 168 files changed, 2703 insertions(+), 185 deletions(-)
 delete mode 100644 tests/tcg/mips/user/ase/dsp/Makefile
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


