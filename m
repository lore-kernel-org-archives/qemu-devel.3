Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F138C606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lP7nKSMh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hmTfkwPh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2PR-00063w-1l; Wed, 11 Nov 2026 02:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR2PM-00061D-9w
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 02:06:12 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR2PJ-000291-2a
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 02:06:12 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5Keh4864271
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 07:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=+ngUNJz1Af2o5DkRz/y7ogTZDMGnTrouMSY
 MwaAlZDU=; b=lP7nKSMhQDx+fMzncMdAKrSTZZnFHXJUWcOS6Hx3cuiHxRtV76e
 CHew2JWADOcVAyc8HKYBxCNrvLwQcQFObiJqLrgDp+SEG8UzVNVzK3M2DwZ6+wAd
 pBInLTvKlUBqFS6JICezu6oyaVpta1CS+foiSuq5k4bWLMFAy4quY/v2M4LtajeE
 pOgDsBCrBWRU9Jv9UNY9hl8Y0FtyWBSsqtnEtghTDJIf6q6x0BJjSdnPTjGPJ+4/
 L3cSgpcA9f5ZbC8oBvb1T+vSX1+qVm8uDo4Q50asRC2x7kmlrI7p/oN1Wfuhi8hJ
 2PiqoUI6QmelJSfNXfXSpO+twcl7hFiQirQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawgxq1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 07:06:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so586070685a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 23:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794380766; x=1794985566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+ngUNJz1Af2o5DkRz/y7ogTZDMGnTrouMSYMwaAlZDU=;
 b=hmTfkwPhTVhDaeOuDVI5hvnYbi6k1AtrTagvZX2eMNbGhLC98VqFr6UN9PxLT5RhIO
 1y6eTnGplVdnfdlLVbnskN0GWRhg+jetgKA307MovQfDB/sGTJVHFqHB4CH5iLlSNmJ6
 TCWewFwJtlZl13BTnl2ddf89XRhUm1J9/Rdr8C82laVTMZw8ko43EEAAm+VERsfGInX6
 5uGE5TqcrOTFzz4dtlKAjXK2+8dVCrqJR2w+yDdh13II1YdJy17rnVTtWdCOD/vVSpTw
 /0RLFjzKANHX25q7ok3FFvFu7ZCDgiipX1OU6tGrZHdTOl2iUeW8SzUUR3v7BIKb5LVi
 lxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794380766; x=1794985566;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+ngUNJz1Af2o5DkRz/y7ogTZDMGnTrouMSYMwaAlZDU=;
 b=f2xDWSTtBeiqa5XLu/LtWkY2ZStgh0kbF6Ub5MwWB5x5uSuC81y72pvYoHLJ805VNU
 VyWVupkwbLu+nzD8L5MO5cXN5+I9Vn69PzPEvucpLCA1Z91pjtP7dhd+ciYjmCd/dj6o
 GpscR1zCBuGxxnRtjhweVSOFp4NFDd17c3dHgMYx1lUCrTFWNSZtmIS6dTVfhihMrU/C
 ewvAmqX5K49bT4tRcZNqwFpu5TBx4E6ZS/3b3IYcReafSH+qLRx46NrJpCO8pECxg1vg
 IXy7fPUMiiVTPCaLx/blhrZMn2aYnB+i91yrU+RzEs5P0BGUr6eXqtQrpKZ05TsZxwvh
 hIDg==
X-Gm-Message-State: APuU4Z/zdBGr8PWwrFFbGhTk9pC3Hw/zAlHFZHpWa8Icm57opDS396Tc
 mQbKLz/BHfIoKrz9n1A3x9eT4iputIkKyE1RpK+olgqGKagXd8RmKVCu+bKmj54pB6iZ6lXCWeI
 APMFGNaYkPgvDpM8mdhGiL19qvkLqFP9VONbk0GRR1aBdtKF6Mgmds27QUMrEwbhcKQ==
X-Gm-Gg: AYBFou191wIH9E+GaHQ79jIFGiSTi/6V01qfIW5Qknn42t4kQSzSPwH1+8hLNYA5tYi
 5sFKUtGXnWSgaRR+ol8Q0chM8sb7mdxnrBuj8yZGhbLsZecsmXv6u+m6ouOH5kd+Kjz8D/jm4pl
 N9pJ5lamBcmXvUjG8xlJKMr2+o61fWkZoEXeaFNJRIqHD/tWjJtlvyH58daoKKdsMLj6g+klkMp
 iCrLOCBDp8izcgvwwW2bxZvpeSgCB81L7WZaguE+WFXoOzswHSC67qQYwOQZq5bVOr8czG52SjE
 Ko37LYatkz/5k/Be7d9v0qeOIkRc831q8m+itW8CgNNtlh6DbwixVfDmABK3i9IJ7J3DZ2pexMu
 MHiT+WBLayOK/PMvJ8C0lpHn2WK+M8/hPOT6aWnID4ngVReZ0RCM7X5jGYqogoVhH7HMQg8i38W
 obPd3MHyyADJw=
X-Received: by 2002:a05:620a:258b:b0:947:8f05:39fe with SMTP id
 af79cd13be357-947b00a92fcmr203721485a.77.1794380766135; 
 Tue, 10 Nov 2026 23:06:06 -0800 (PST)
X-Received: by 2002:a05:620a:258b:b0:947:8f05:39fe with SMTP id
 af79cd13be357-947b00a92fcmr203717885a.77.1794380765555; 
 Tue, 10 Nov 2026 23:06:05 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e4fa312sm419911385a.0.2026.11.10.23.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 23:06:03 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 0/1] target/riscv/tcg: clear itrigger_enabled during
 trigger_reset_hold()
Date: Wed, 11 Nov 2026 04:05:59 -0300
Message-ID: <20261111070600.169519-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX7NoYdkGzdvxn
 +4r3P0b/b9h45638DH347JTZmTAHom6RFCMhJGq5WBf/saGg9mT4m6N5At1Lllaf70DFO1Lz/A4
 C2zQNyHd4EST4F/Sk5dgq6UgaX39Po0=
X-Proofpoint-ORIG-GUID: IP7bZR3UQsYRJ_DUQnkIz8wgSwb4C1RB
X-Proofpoint-GUID: IP7bZR3UQsYRJ_DUQnkIz8wgSwb4C1RB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX28mAMjrEAekH
 ZLf0ftBMFNQGBO42de5FeByoqYEMCGPQ2BX07a3ABfrtsJOTNpEhd/7SsD83qWazKUGLEgAiUxQ
 g2915P26PEMuF/9HGFS6WmJ+YEjwei1tRaDqiHAk8ZVxeu4KbPXwn1e9RceRpcib2YaDGv3pCMW
 OAd+JK9cNxpfHFnlsxQBplAnNTzfSuyAe7s2QcOvfrvenN+himAXKtbYBJO5VhA6xA+moTm3/lU
 5+uGQflxBOUoAw1YQDcdiP3N6IaxBkH17cSi7PBfWTTNadkcPgEN2XVy8wo8TyaduS7H+6IcR/w
 wbh4WijYf9i46wX89yIXvl4QGYculRTQ9xFfRZQcHMOo/mI8EvGrZWFZA5fbUwKKOvzsOxHXfav
 IUBMmF1xzaeu8CFQfBIeEEiWaO980djq6UkNVflUVCmllEaDhiVhXfMx7F4wd6zpABurBq+5/pb
 zZv/mz0kdIYMohbjmdg==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af413df cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Yr0rI23_fJXgV-w7aHEA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110028
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

This version just changes the "Fixes" tag in the commit msg.  Sashiko pointed out
that it pointed out the wrong commit in v1.

No other changes made.

Changes in v2:
- changed "Fixes" tag in commit msg
- v1 link: https://lore.kernel.org/qemu-devel/20261110195023.20927-1-daniel.barboza@oss.qualcomm.com/

Daniel Henrique Barboza (1):
  target/riscv/tcg: clear itrigger_enabled during trigger_reset_hold()

 target/riscv/tcg/debug.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.43.0


