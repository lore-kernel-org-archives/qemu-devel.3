Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518ADC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Xo3-0002h0-W1; Mon, 07 Sep 2026 07:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Xnz-0002gc-1D
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Xnw-0003EE-Od
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AvLN6496177
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 11:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=MfOh7ttXWdhkxG5r0SqLAEJyPpyfp4MVb+0
 xcBgjsYw=; b=QyL+9DdkR8Uic3TfY96iweE0BIO/+Jpl3R3vZTWODQTM8yIag9I
 WCERbQE5g8IUWpIliVKQAyHGyD3ESLQ36e3A995aRk4AYL8AnhPk2WilPIlzM1U9
 pjWWM6WIelStxVI1TRZfiaJtSfOcF+lul+uGzEMwImgj4HD0QjkFW5Nx6cx2vTIS
 fWWK9Xw2SWPRS1i0yyTWqNP81fzBKSmGotXe16PChEoo+NZjBs6aPZ2FEFzQmTl3
 kkJfNSfbab0Rn7N/XL5dN6w3Z8P55jyWWQsmSx9p8iB31bh4OCp8/5mewFuhpv09
 332ZlID9SbCwLCSx8UnkgNPAHEvd2hmGNJw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuyk852c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 11:46:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5304f2b5946so65409971cf.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788781585; x=1789386385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MfOh7ttXWdhkxG5r0SqLAEJyPpyfp4MVb+0xcBgjsYw=;
 b=RQv45dcI96TpR20Uf4uFrHh43aYY6+8MFY8v2X9bLSGOr2I9dVbiec4rqvhECP5kr/
 cLkeoWemztF76vrS8WK6Pc4wrUZZlvpAZQ/nY87B6wOKLBh3chQaUoXVM7z7nMD30mRQ
 W0gsw99KumdtHogOZeL4T/OBGP9xhrkoQnsAyW613H/RdlXMdQKkKhq4kBd3zhIMacwl
 XKZv4TmhoA2Qj3Ps0q3c9PljM7xVgMcHEIp63RkjpWuyFoCKAsGUdlPI3a6t9zfnRMFF
 ZLOSek5b+58bF5r3ZqOgOGgEH/ZcrFjMgCaWJHA0uZMhsskDQk8ydYdgzipvd0hWwMXr
 31ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781585; x=1789386385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MfOh7ttXWdhkxG5r0SqLAEJyPpyfp4MVb+0xcBgjsYw=;
 b=M6m9hftWM5sdwp989/5+wyew+Xx7ovSR0Vvo5TATADvdPtECICyk0sx5ECLjkv6Dz8
 fcT3zgCMs2bU0/GneD8Imqp9vY/MT4IVo0mK/NXoUeJgk1FtejNQbVSILFLJywjMuJuQ
 G4Ku3dIZtEZCmQzWlgKyramooTjhrPd1byda1kDP5VUz2PicGTV7ukwR/Bj1eYc6siJ/
 n8J7QDR6hdMrGe0ELbEQcmOId3L/v/BR8ssWtZOQu3uD1NIAy7zLA4bjK4l2m7/Qb8Xe
 GEfsl2oYm7vYISRmhQ5R+rzhsOvBt+24EcunhLSlAQLDF3zay73hFnsNSGDIWK1s0VRX
 lvyA==
X-Gm-Message-State: AFuF++mCmv3mWJ4R7PMn2dtSmUpLpB9S2i7Mj+FsHrLq4IM4oaZtUkvu
 KMMoPU8ykW1tz1bHX349XNctLeRTJoGpsfMU3Wvdjd09boYIIWuoks+5H5h2Vksx5JClOpXyhZG
 cK3yE5yW6jxIkZJW1Bh0/8ZVnKQELgLFZ9Gx72mblrdmgeTKdoLWvV2+7GbFtYw+Dbw==
X-Gm-Gg: AYBFou14MFwYaKgwAzxIKozhqhJcNZq/Ng8Sy760KP7561fEuPUfJw2SXaJWThbAHdp
 8jbzNUokDsXRrj5gItQN8MsQeZtli/BHhwi1LCWbTQHDI6dZkRMm+dVQN8TFTAoGIelqngaKw4r
 mN7gKVcztz6/Ed2PBLmFWdQdwmAGSj2Gb+HVGYJ2+mWeG5pCf0LRbI5+Sv2ykQC9wCPMMBjLK48
 KuhA2O/lkWM9YBPCfTe36Y6MBUyKf9bBNsst2tRiKP7adFjJWa3ZERJd/XuI8/4/1WsSa9sFRJ1
 ji/BQczm1p/OLphj0vrv5bD64s0bTHD+SfbTI9SXCYxtQq+S/uhv7noosgYVGrqQ2DHdpxyHgrh
 diZJ2WuOSz4F59lYehXOD7xsT37BkFxGemgUO
X-Received: by 2002:a05:622a:17c7:b0:52e:2e04:44f2 with SMTP id
 d75a77b69052e-530548c8f29mr286564721cf.20.1788781585077; 
 Mon, 07 Sep 2026 04:46:25 -0700 (PDT)
X-Received: by 2002:a05:622a:17c7:b0:52e:2e04:44f2 with SMTP id
 d75a77b69052e-530548c8f29mr286564051cf.20.1788781584556; 
 Mon, 07 Sep 2026 04:46:24 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040679e13sm89834876d6.26.2026.09.07.04.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:46:24 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v8 0/7] riscv: add initial sdext support
Date: Mon,  7 Sep 2026 08:46:07 -0300
Message-ID: <20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyOSBTYWx0ZWRfX0SDABVIixams
 aj4LHllZksGoRkycZ5DjgQ4z5bH9TAWkJiu57/uuVVSavZVp/8vNqmmC5PKrAJdzILuyow8dFpg
 vs4p3FaKpWhyr58e/2uAOBFMaccjjF8=
X-Proofpoint-GUID: N95w_i1ule_MIUYrFCB7xqRc07EUKU4t
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9ea412 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1X1KHL8RLlM2lqwBaMMA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: N95w_i1ule_MIUYrFCB7xqRc07EUKU4t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyOSBTYWx0ZWRfXziLykyml4tC4
 J0dK8Fup0qPo97qsLM7KID5pUoYSfS0KQASSDXTRbYlTuFZqmIoBLj23JQfWSmINFfg1o9MrT50
 pbuWMBxmas32Fpk1U8jE8TflMkzJxUjNAWnYAQtv8hrQnMVNTl6/dOPNW3YBSZ/PZzvUrFTIfR7
 4Hyk+UOX/+S4nf/DYCh1oUikuBAJiQiMgDm+MeMgQ7lPBkbMIpH6GANvIXadbcw0uqCIqDcnRhd
 wzQR8U03nGkQLwoVloII3hnwYTwSbZBIFR5yQDKDOYXLNeHiLy5xaL5K/9LwABVKO2eb6rr+mg4
 gALENf0vIr3pG+nfSuLXVH1nwWsTaLNKYKutpLPR1LEtisKWFtT8i2HwRDsff+idAw7kztNBj8p
 Lpv96g3EyroPxRermgF/EKUb//QgdYKFULPwS9dJjDqqb53LA53vaTNl+cDfAd/AyUSTNT7QGk1
 RxiIvD1tU5BiK534EnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070129
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Greetings,

This version is a simple rebase with master, where a trivial conflict
with tests/tcg/riscv64/Makefile.softmmu-target was solved, and with my
S-o-Bs on patches 1-6. 

No other changes made.  Patches based on master.

Changes from v7:
- Added my S-o-B in patches 1-6
- Patch 7:
  - fixed conflict with Makefile.softmmu-target
- v7 link: https://lore.kernel.org/qemu-devel/20260831141007.353854-1-daniel.barboza@oss.qualcomm.com/

Chao Liu (6):
  target/riscv: add sdext debug CSRs state
  target/riscv: add sdext Debug Mode helpers
  target/riscv: add dret instruction
  target/riscv: add sdext enter Debug Mode on ebreak
  target/riscv: add sdext single-step support
  target/riscv: add sdtrig trigger action=debug mode

Daniel Henrique Barboza (1):
  tests/tcg/riscv64: add sdext "not on Debug mode" sigill tests

 include/exec/translation-block.h              |   4 +-
 target/riscv/cpu.c                            |   7 +
 target/riscv/cpu.h                            |   9 ++
 target/riscv/cpu_bits.h                       |  33 +++++
 target/riscv/cpu_cfg_fields.h.inc             |   1 +
 target/riscv/helper.h                         |   3 +
 target/riscv/insn32.decode                    |   1 +
 target/riscv/machine.c                        |  20 +++
 target/riscv/tcg/cpu_helper.c                 |  91 +++++++++++++
 target/riscv/tcg/csr.c                        | 126 ++++++++++++++++++
 target/riscv/tcg/debug.c                      |  59 +++++++-
 .../tcg/insn_trans/trans_privileged.c.inc     |  24 ++++
 target/riscv/tcg/op_helper.c                  |  70 ++++++++++
 target/riscv/tcg/tcg-cpu.c                    |  19 +++
 target/riscv/tcg/translate.c                  |  15 ++-
 tests/tcg/riscv64/Makefile.softmmu-target     |   5 +
 tests/tcg/riscv64/test-sdext-sigill.S         |  83 ++++++++++++
 17 files changed, 564 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-sdext-sigill.S

-- 
2.43.0


