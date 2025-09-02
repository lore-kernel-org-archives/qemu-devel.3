Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F454CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI2U-0006er-II; Mon, 01 Sep 2025 23:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2E-0006Pa-9O
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2B-0004v1-Bh
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822THOD027558
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=hL7UmL2Kie/
 yf9fkb3P5KDf5suYVSPAEj/x+A/SAuHs=; b=QzbCqvOtbK1Z3Azx1WqD5hFKlbq
 PLei56mbAwm9M3gva4Tri3xm/sR+G5DNCvvh1Fiqxxny54w2sVuVwFXYmE0Z03AI
 tfwEfrogCjYvwNq9YL7XuMUZWZOWm7D+XY92mIeyHzPC3/h+Xc/tsZ1bg9GKKh8Y
 pdoJoNpTbtXYt6lAi8XyCFPY6qK6hLfrsFpWW8XFowWJrP4JZbHSCE0r/TrxesfD
 V12V9bHGGGFvomt1PKJDyttA+oHgXr0y4HWrx0+ENL11+icxPvN3qh3c+kyy4EIV
 ahEDP7R0lQRBZFG+JoCqohQ8BYe0NY0rIVark51xyOXQT6hBAgnIqDPVMyg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxecr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:50:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2488490fe4eso67570015ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785003; x=1757389803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hL7UmL2Kie/yf9fkb3P5KDf5suYVSPAEj/x+A/SAuHs=;
 b=gaolkc1JanwN0d3NhlXrOgkpWXShwJXj4+Tc9FHNzTT+AIOMAlvY7YxFN3nKsKYotf
 CIoJK8bNu9aJRWQ0dxpCyrrkZ1GuhPVDxWqa0SUm/cYSkf1AxR4mY1aPwekjNc5e/UAs
 0tozbHIocavA9vuj0WQpqxCkMzNpnrpIJi0CukGpsUiUdCrRa9vbIA8mT0jj80WQFqsf
 dSqgndx+kPAhl9do05eEynPC6jqWnQZJ7mVdZADyraKq4anp7HZ9TpsN3q3a8IK7FbZu
 5n184ym2DIgW1MLa/qfeog6EpsVEV6gfSXx85Ll/vdpX31bUySgMAv2CWayL0uhMqCPB
 KdOQ==
X-Gm-Message-State: AOJu0YyJ+euajcPOx1IXVW45xdk4YFpFN0wCNf+jV6LGYNzvRVZS+CvV
 CfSA20NG2BFcUPESGynSSUW9zKdXLmA0QqsLewLZw254VmE50hFjX8REqZuvrwL6oLqW7ruAthD
 ypKqFLrf80wGBEojm6wLnuWwnaRVIDalNmKUMkv3u2Nw0JnsEydyBz4NeVkfX5uqJrpuw
X-Gm-Gg: ASbGncuu3y3duywSL4T3mhctTP+TqUM5PfkhfGqHyr92Op4/E1YZMowJbsrVIHThyvD
 w0yWoqlP0TMiSiUJZfbgN/NQo+JWTF1X+oCGkxDuF8TbxFJZ9/R/Oagc38Tdd8l80MC0ik3Vb6l
 C7Lpd9IaA1i46e7+RBdYykKz+fYiniVDehluSQozBCympGcr57yc1vbD+MGgORXfq9h2bEPG6+n
 5Nj+InzMDErMcCDff8GCqEWuN9Iv/MZRa0WrROfhqLzTpU2IUVBHPeKqAcNb2BDxdX2NOHb29OC
 iJOzsrdu6TUzt9mfG9zU6onW1kyYMqrOMu4HsefNzUCtXQAOwoRTxoJXMWmkXvALczIQ/wDh3U3
 vuFmgda4mrZA/
X-Received: by 2002:a17:903:41d0:b0:23f:e869:9a25 with SMTP id
 d9443c01a7336-24944acf3b2mr118460285ad.44.1756785002620; 
 Mon, 01 Sep 2025 20:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkyNFdxKEJ7fQlA3mgS07brl1LfE1MGsfoPF7smUmBlg7a/R6xRXhkmJjNSCql/qYIYQlr1g==
X-Received: by 2002:a17:903:41d0:b0:23f:e869:9a25 with SMTP id
 d9443c01a7336-24944acf3b2mr118460035ad.44.1756785002147; 
 Mon, 01 Sep 2025 20:50:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327c5fc5055sm14117932a91.14.2025.09.01.20.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:50:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
Subject: [PATCH v2 00/11] hexagon system emulation v2, part 3/3
Date: Mon,  1 Sep 2025 20:49:40 -0700
Message-Id: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX+0SZe1Neau28
 WIw7x3n8h/Jj8MUC2xzf00VWvITmjjhtkdXAL/5mnMlYsAybJRAgBh1wzeDfqbZeb9j1cWKavDT
 SKsOeO0OA5ps7Uq7bF2ceMv7F06vwk7Uuk3VIfeJBTYe1+o5zI3B0TNGR8eYs/4L1zFEavt2jg6
 RwezPKt4yaGpyJ8X8Sadf9AgaAJgiIxyq5fAgy0EzYBNVc5IHgsYjSoNF0ffQpdLc71ERGPS2wD
 hgL/1DrG84rad6ofZPB/Od7OiPcStDbjWy2LPP6uakjykx4TGHhDnT7jtkTga7qlBem4YDAFkvD
 e9Dy05rq48qgjIAMdTTVJrBa96zC1O7BY1+5tu7oz9KEzq4Mrg7Mq2nYy3G3XSJntxNyhdj3o/9
 txP2bapc
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6696c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=JmbkjY8jM9pbaCcUt8YA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: EXXZxp6XrK2kMDE70tmeD_2wPyI4KAB5
X-Proofpoint-GUID: EXXZxp6XrK2kMDE70tmeD_2wPyI4KAB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As with parts 1, 2 - some of the changes requested have been made, but not
all.

New features for part 3:
- global registers device model
- boot-serial-test qtest case

Issues not addressed with v2:
* "Add l2vic interrupt controller" - DECLARE_SIMPLE_TYPE, bitops
    - I might also push this and/or QTimer out of this series to simplify
      things a bit.

Brian Cain (8):
  hw/hexagon: Add globalreg model
  hw/hexagon: Add global register tracing
  hw/hexagon: Add machine configs for sysemu
  hw/hexagon: Add v68, sa8775-cdsp0 defs
  hw/hexagon: Modify "Standalone" symbols
  target/hexagon: add build config for softmmu
  hw/hexagon: Define hexagon "virt" machine
  tests/qtest: Add hexagon boot-serial-test

Sid Manning (3):
  hw/hexagon: Add support for cfgbase
  hw/timer: Add QTimer device
  hw/intc: Add l2vic interrupt controller

 MAINTAINERS                                 |   7 +
 docs/devel/hexagon-l2vic.rst                |  59 +++
 docs/devel/index-internals.rst              |   1 +
 configs/devices/hexagon-softmmu/default.mak |   8 +
 configs/targets/hexagon-softmmu.mak         |   7 +
 meson.build                                 |   1 +
 qapi/machine.json                           |   4 +-
 include/hw/hexagon/hexagon.h                | 150 ++++++
 include/hw/hexagon/hexagon_globalreg.h      |  60 +++
 include/hw/hexagon/virt.h                   |  43 ++
 include/hw/intc/l2vic.h                     |  38 ++
 include/hw/timer/qct-qtimer.h               |  85 ++++
 target/hexagon/cpu.h                        |   6 +-
 hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc   |  63 +++
 hw/hexagon/machine_cfg_v66g_1024.h.inc      |  63 +++
 hw/hexagon/machine_cfg_v68n_1024.h.inc      |  64 +++
 hw/hexagon/hexagon_dsp.c                    | 211 ++++++++
 hw/hexagon/hexagon_globalreg.c              | 345 +++++++++++++
 hw/hexagon/virt.c                           | 457 +++++++++++++++++
 hw/intc/l2vic.c                             | 421 ++++++++++++++++
 hw/timer/qct-qtimer.c                       | 520 ++++++++++++++++++++
 system/qdev-monitor.c                       |   2 +-
 target/hexagon/cpu.c                        |   5 +
 target/hexagon/op_helper.c                  |   2 +-
 target/hexagon/translate.c                  |   1 +
 tests/qtest/boot-serial-test.c              |   8 +
 hw/Kconfig                                  |   1 +
 hw/hexagon/Kconfig                          |  16 +
 hw/hexagon/meson.build                      |   7 +
 hw/hexagon/trace-events                     |   3 +
 hw/intc/Kconfig                             |   3 +
 hw/intc/meson.build                         |   2 +
 hw/intc/trace-events                        |   4 +
 hw/meson.build                              |   1 +
 hw/timer/meson.build                        |   2 +
 target/Kconfig                              |   1 +
 target/hexagon/Kconfig                      |   2 +
 target/hexagon/meson.build                  |  12 +-
 tests/qemu-iotests/testenv.py               |   1 +
 tests/qtest/meson.build                     |   2 +
 40 files changed, 2680 insertions(+), 8 deletions(-)
 create mode 100644 docs/devel/hexagon-l2vic.rst
 create mode 100644 configs/devices/hexagon-softmmu/default.mak
 create mode 100644 configs/targets/hexagon-softmmu.mak
 create mode 100644 include/hw/hexagon/hexagon.h
 create mode 100644 include/hw/hexagon/hexagon_globalreg.h
 create mode 100644 include/hw/hexagon/virt.h
 create mode 100644 include/hw/intc/l2vic.h
 create mode 100644 include/hw/timer/qct-qtimer.h
 create mode 100644 hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
 create mode 100644 hw/hexagon/machine_cfg_v66g_1024.h.inc
 create mode 100644 hw/hexagon/machine_cfg_v68n_1024.h.inc
 create mode 100644 hw/hexagon/hexagon_dsp.c
 create mode 100644 hw/hexagon/hexagon_globalreg.c
 create mode 100644 hw/hexagon/virt.c
 create mode 100644 hw/intc/l2vic.c
 create mode 100644 hw/timer/qct-qtimer.c
 create mode 100644 hw/hexagon/Kconfig
 create mode 100644 hw/hexagon/meson.build
 create mode 100644 hw/hexagon/trace-events
 create mode 100644 target/hexagon/Kconfig

-- 
2.34.1


