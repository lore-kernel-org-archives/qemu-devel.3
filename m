Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A0CC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1UyX-0002I2-OY; Tue, 01 Sep 2026 16:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyW-0002Ha-8K
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyS-0003Tz-Jv
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgDoi199689
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3VLgw2AN0uFRN8Br5n1Rn/
 dF+iR9ITJ98UBeFFrTZ+E=; b=U1GHZ2zzaulwdKhdBtdlVxX9hRf9qbo7e1xtnx
 QmsMqBFwwiRKbnTdlDK/TJqYF9N6sXsuVDIPjk+qx6Rj1ei9+FAlVNgu5YAk8hqq
 +4KAY+zytLLljxPctT5LQySbEXiOOId6TMKlWdVtNBjRQkwtQ9ZZ4K5te/k3+5a3
 IIx3W67CEjXzquTtZLjAQY8Gagx92374asvTLunbtukH5z2nMwE7vCVM5yn9FNNO
 xgBE14Wtp98lla1guecxvUVGcd3pXjp63waoenFOUZbvgCdvPg6SUMuakh6WmGZ4
 53RvbTuPc+kLW8vU0bZx1Wi4TsK9B97OfCJEm8LdKCn9Sdcg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdsnu3tvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:20:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so497627a91.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294049; x=1788898849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3VLgw2AN0uFRN8Br5n1Rn/dF+iR9ITJ98UBeFFrTZ+E=;
 b=Tu328+fAgPVqKvr12tufdszut10t+Z3dzVjk2r13YC1BGbR6on/to6Z9eNk7iLLSys
 vk3XxB+HFweL6Z8D6zz6moDpMnE4kbR/QK5CzMpA+SG0npjg/M+ktNV61ssTksPHGnWK
 R9JYI3sMAFooTh681J4149VgAGIW4w4/enh8GkiNY6BrAsyrO7yu4CtnCqxvzkkf7LiV
 TlKwGsX4QIC4tn6XdvowPvWxC5CwU0p3oRi172fZ0pt9iwHgNz60R2+FggCDWurQviAt
 RCkiHBQQDmVn4OhCyKfoi/0rt1k0jqYk+Bgs6Z21/P+OwhARys10lCLKlS3ewjPC5OaW
 REzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294049; x=1788898849;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3VLgw2AN0uFRN8Br5n1Rn/dF+iR9ITJ98UBeFFrTZ+E=;
 b=fh7uBt8Q7OTMauVHHJoXRijirLeDd8PSwY9IVfa/PuUrIYjX8dWp5EaJ6cBPHP+pO6
 j0EYMB3cW5zZEks15Q+QWWxTwjNFqpz+fmKhAW0GW0S7RMztncYr70R4cZ3dzIg6RVcR
 o8v/J4cSRKZpLcbJKuFTvj6ZnKezipF0EXK33uzeSdtXVCdcfVHHhM/jXUGwdPen824u
 qLyi2MAqbCmq9rrThr0r1QBaYAOV4pTTgkNgqDvVed+eYh2wl3Y24APNtUopqqejJsMi
 +J2NhluCdBSRamx0kr470n4IOu9IM5ueh8LIFBckwAqyxvOLFW0vSQgUYjvH1b3X1G+3
 WaFA==
X-Gm-Message-State: AFuF++lNlH8UP76tB/4TJlVarqesoo7HyktuMd0BIiSgkze/tiLQex9Q
 yjy2Y+bDq8J1supw1btHsM/ixnqRIAGUkl6r3CGE+OVbKKqNwKf3tCeACKag+fTh/ZhlywkzIiy
 0RxNrCxtCvLVxnbwIXmziN3LZYJfwP/EwTJmhXbiSDS1Pe76igJK8VXILtYwVHFgRrQ==
X-Gm-Gg: AYBFou2njJKwOC4ONh5Cx66VOG5/S4Vbb0oKKBtOlfTftqoRZ190exPZyONTdLhnzho
 BIqRL3c7YMsLlQPnEMtqGSveBEd2A1qQebGM8/w2XHtPDc+KvtspCShyQZT9IZ9kSLzghEyq45h
 fmrvKVWI87mouuVGvx58Z8+/Ok6QyHnQ1JcZ6pQXt0VezqG9MtdqDUZH9v0A2PmStzMNod7Hm1s
 R6ut+wOAkH1yxSABi1q4u8WFZY71L3tmz1nYE6bXZbglYCPsaO6sKJv8QJ6hw3lMYRw2eJVAXcq
 KfQcMowS8D9GYqV6ntg55HZnT1oAxpkbUabinUwSjNvlY/YfP2Cpu35QY9vimRjaGb2bz1ROraI
 gh7i65fx9BgSzUJMZv3Kngv/9IqCB2S83ULGu7UW+84+BdR74XQlpxcfo7yM=
X-Received: by 2002:a17:90a:114f:b0:398:9be5:b41e with SMTP id
 98e67ed59e1d1-3989be5b50emr27485435a91.25.1788294049467; 
 Tue, 01 Sep 2026 13:20:49 -0700 (PDT)
X-Received: by 2002:a17:90a:114f:b0:398:9be5:b41e with SMTP id
 98e67ed59e1d1-3989be5b50emr27485379a91.25.1788294048894; 
 Tue, 01 Sep 2026 13:20:48 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:20:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 00/14] target-info: remove machine_typename
Date: Tue,  1 Sep 2026 20:20:29 +0000
Message-ID: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX1teE1eQtQPyZ
 v0rpGcQ37rTD+hZs/XkIPweqWes/thoaoY+u1BDLKQMt54err2czSyHviOoMUi3xLimfnZGm9+T
 4fp1CEJ+pEB40PnaaVEjXQbu6L+WAH+3bYSKBKMeb48zpgsljLD4kEAEq0e3R1RQyesBH5sVe8H
 20e2JRB0VFPMrC+SNTCojRJw6p5EFQhftaznKjF1qu4GRk98SnCN82AO/y1vEEhBPGlwslwtboB
 /gNtyUK6sXrY4yD0l5NyeWdcTMBFVO3+MLR//TOsctLHNX3ifN6SVRExXQb4PI8yf9xOSCkWjNY
 /p+ib5xUD8wKTgah4b5ZRX0ryxxopFgMd3JRbdu3YGn7Y+DqWtv8zfbwH3SxQHyxMa8rD52bAkz
 xAO69CG9wujLQ8qnM/Yp0+1xZjSiE0yy+/TzbtWlpl9deBWLy3btOIq+7y/Fq/C35hhJglFj0gj
 NRfr70npZRVJX93rCug==
X-Authority-Analysis: v=2.4 cv=L6ItheT8 c=1 sm=1 tr=0 ts=6a9733a2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Q1o3_xrxerSsmfMJ3jIA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX7olStzSCr/h+
 9WfWFqoNP8tSU5I4An9egJFnPBVNkGeU1257t3JWU+9nQO7E6Tncs/Bc+VXQBBpFCVN+wA7f8gz
 j3qp0fTHY6LIMPe+djMsLpifGrrcNWQ=
X-Proofpoint-ORIG-GUID: esBqvZOUkb_yNPkBL0v84WKZQ9JV0TxN
X-Proofpoint-GUID: esBqvZOUkb_yNPkBL0v84WKZQ9JV0TxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010178
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

This series cleans up the existing filtering interface we implemented
previously. It's cumbersome and incomplete, and we can have a much simpler
callback added in TypeInfo, to achieve the same result.

Also, it allows to remove a bunch of code, and remove duplication of target info
definitions per target, which is the biggest benefit.

Pierrick Bouvier (14):
  qom/object: add is_available callback to TypeInfo
  hw/arm: filter minimal set of machines
  system: query machines using TYPE_MACHINE
  target-info: remove machine_typename
  configs/targets: remove target info definitions
  target-info: rename target-info-stub.c in target-info-def.c
  hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
  hw/arm: remove {arm,arm_aarch64,aarch64}_machine_interfaces
  hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
  hw/arm: remove machines-qom.h
  hw/riscv: remove TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
  hw/riscv: remove {riscv32,riscv32_64,riscv64}_machine_interfaces
  hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
  hw/riscv: remove machines-qom.h

 configs/targets/aarch64-softmmu.c         | 27 -------------
 configs/targets/arm-softmmu.c             | 27 -------------
 configs/targets/meson.build               |  6 ---
 configs/targets/riscv32-softmmu.c         | 26 -------------
 configs/targets/riscv64-softmmu.c         | 26 -------------
 hw/arm/aspeed.c                           |  1 -
 hw/arm/aspeed_ast1040_evb.c               |  2 -
 hw/arm/aspeed_ast10x0_evb.c               |  3 --
 hw/arm/aspeed_ast2400_palmetto.c          |  2 -
 hw/arm/aspeed_ast2400_quanta-q71l.c       |  2 -
 hw/arm/aspeed_ast2400_supermicrox11.c     |  2 -
 hw/arm/aspeed_ast2500_evb.c               |  2 -
 hw/arm/aspeed_ast2500_g220a.c             |  2 -
 hw/arm/aspeed_ast2500_romulus.c           |  2 -
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |  2 -
 hw/arm/aspeed_ast2500_tiogapass.c         |  2 -
 hw/arm/aspeed_ast2500_witherspoon.c       |  2 -
 hw/arm/aspeed_ast2500_yosemitev2.c        |  2 -
 hw/arm/aspeed_ast2600_anacapa.c           |  2 -
 hw/arm/aspeed_ast2600_bletchley.c         |  2 -
 hw/arm/aspeed_ast2600_catalina.c          |  2 -
 hw/arm/aspeed_ast2600_evb.c               |  2 -
 hw/arm/aspeed_ast2600_fby35.c             |  2 -
 hw/arm/aspeed_ast2600_fuji.c              |  2 -
 hw/arm/aspeed_ast2600_gb200nvl.c          |  2 -
 hw/arm/aspeed_ast2600_rainier.c           |  2 -
 hw/arm/aspeed_ast27x0-fc.c                |  3 +-
 hw/arm/aspeed_ast27x0_evb.c               |  5 +--
 hw/arm/ax3000-boards.c                    |  2 -
 hw/arm/b-l475e-iot01a.c                   |  2 -
 hw/arm/bananapi_m2u.c                     |  3 +-
 hw/arm/collie.c                           |  2 -
 hw/arm/cubieboard.c                       |  3 +-
 hw/arm/digic_boards.c                     |  3 +-
 hw/arm/exynos4_boards.c                   |  3 --
 hw/arm/imx25_pdk.c                        |  3 +-
 hw/arm/imx8mm-evk.c                       |  3 +-
 hw/arm/imx8mp-evk.c                       |  2 -
 hw/arm/integratorcp.c                     |  3 +-
 hw/arm/kzm.c                              |  3 +-
 hw/arm/max78000fthr.c                     |  3 +-
 hw/arm/mcimx6ul-evk.c                     |  3 +-
 hw/arm/mcimx7d-sabre.c                    |  3 +-
 hw/arm/microbit.c                         |  2 -
 hw/arm/mps2-tz.c                          |  5 ---
 hw/arm/mps2.c                             |  5 ---
 hw/arm/mps3r.c                            |  2 -
 hw/arm/msf2-som.c                         |  3 +-
 hw/arm/musca.c                            |  3 --
 hw/arm/musicpal.c                         |  3 +-
 hw/arm/netduino2.c                        |  3 +-
 hw/arm/netduinoplus2.c                    |  3 +-
 hw/arm/npcm7xx_boards.c                   |  6 ---
 hw/arm/npcm8xx_boards.c                   |  2 -
 hw/arm/olimex-stm32-h405.c                |  3 +-
 hw/arm/omap_sx1.c                         |  3 --
 hw/arm/orangepi.c                         |  3 +-
 hw/arm/raspi.c                            |  8 +---
 hw/arm/raspi4b.c                          |  3 +-
 hw/arm/realview.c                         |  5 ---
 hw/arm/sabrelite.c                        |  2 -
 hw/arm/sbsa-ref.c                         |  2 -
 hw/arm/stellaris.c                        |  3 --
 hw/arm/stm32vldiscovery.c                 |  3 +-
 hw/arm/versatilepb.c                      |  3 --
 hw/arm/vexpress.c                         |  3 --
 hw/arm/virt.c                             |  2 -
 hw/arm/xen-pvh.c                          |  2 -
 hw/arm/xilinx_zynq.c                      |  2 -
 hw/arm/xlnx-versal-virt.c                 |  3 --
 hw/arm/xlnx-zcu102.c                      |  2 -
 hw/core/machine-qmp-cmds.c                |  2 +-
 hw/core/null-machine.c                    |  9 +----
 hw/nitro/machine.c                        |  6 ---
 hw/remote/machine.c                       |  3 --
 hw/riscv/boston-aia.c                     |  3 +-
 hw/riscv/k230.c                           |  2 -
 hw/riscv/microblaze-v-generic.c           |  3 +-
 hw/riscv/microchip_pfsoc.c                |  2 -
 hw/riscv/opentitan.c                      |  2 -
 hw/riscv/shakti_c.c                       |  2 -
 hw/riscv/sifive_e.c                       |  2 -
 hw/riscv/sifive_u.c                       |  2 -
 hw/riscv/spike.c                          |  2 -
 hw/riscv/tt_atlantis.c                    |  2 -
 hw/riscv/virt.c                           |  3 --
 hw/riscv/xiangshan_kmh.c                  |  2 -
 include/hw/arm/machines-qom.h             | 46 -----------------------
 include/hw/riscv/machines-qom.h           | 46 -----------------------
 include/qemu/target-info-impl.h           |  2 -
 include/qemu/target-info.h                |  8 ----
 include/qom/object.h                      |  3 ++
 meson.build                               |  7 +---
 monitor/qemu-config-qmp.c                 |  2 +-
 qom/object.c                              |  4 ++
 rust/qom/src/qom.rs                       |  1 +
 system/vl.c                               |  5 +--
 target-info-stub.c => target-info-def.c   |  1 -
 target-info-qom.c                         | 23 ------------
 target-info.c                             |  5 ---
 target/arm/machine.c                      | 18 ---------
 target/riscv/machine.c                    | 17 ---------
 102 files changed, 39 insertions(+), 488 deletions(-)
 delete mode 100644 configs/targets/aarch64-softmmu.c
 delete mode 100644 configs/targets/arm-softmmu.c
 delete mode 100644 configs/targets/meson.build
 delete mode 100644 configs/targets/riscv32-softmmu.c
 delete mode 100644 configs/targets/riscv64-softmmu.c
 delete mode 100644 include/hw/arm/machines-qom.h
 delete mode 100644 include/hw/riscv/machines-qom.h
 rename target-info-stub.c => target-info-def.c (96%)

-- 
2.43.0


