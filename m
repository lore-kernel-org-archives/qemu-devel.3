Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB5FC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 19:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a1Q-0002vw-BR; Fri, 04 Sep 2026 15:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2a1P-0002vM-Hz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:56:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2a1N-0007in-E9
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:56:23 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684HI3qn548685
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 19:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=KnjOQ/IdtAdF4gwBFBcHkIqZrx7vapmIMmn
 gb4n5JXU=; b=B043/DCOpq7YcpEdnMsFbZZeKiTyBAedvNcdeJNOc9a8UOQfIMS
 WIplJMp0b32361jUHpWPdqtqWzFRvorWO6ebm1sRHBiOksw/MJPryTgqeZcaR+cG
 YowY0VT/Dd54ix0xU+pNEVaPaOzKC2KH9TmMNXRckQ4hhL8rF0z8mzkv6Cj2XODt
 Dnw8JQkGUc0cjyqlvnxW6YGIO6HUHkuA6n2epxosYgHAYaMdtoW1nR7t0O6snOER
 B9ZsQ7MkLFkW5H4B8VelJYAjLSqgZpGLXlkZ7krEC0eTtB5jvbLAQSDTiTmyqh1V
 5S4zQVfTjyvQCVDND9TEtUltLvFHZKQE6xQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg0121s6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 19:56:17 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90cea0b5522so25869006d6.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788551777; x=1789156577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KnjOQ/IdtAdF4gwBFBcHkIqZrx7vapmIMmngb4n5JXU=;
 b=Iox08gnxh8tCuiN9JHgT50MHHgTvnVk+2V95N0KSPDPYJY7Q2ZPJiMEtHfIyKtGB8s
 5fxYXEO4eOc4KWfyTbCnX8TZwZMRvvPvgp+9+m4wIWlLBhaYA25mVpxie2OUALdHaN0L
 FoIJQlqshEG0g17wrMC7ArmXF5HNPKioVCULXBk1OoK4pcmRFkfsE9kCRqbjevxgM9Wl
 gq0quKEayCumzVXfz9R42gly69hZNZuBwISgsGxFJF+3JLZR5CaQuO6/1h0Cdo2yILQB
 anF2mXttXFwVyUS6zZH6J6uf3uuD2Cuc8frBCwWwphryXKyIzesHpMHFbmWc+C+zWPL7
 DwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788551777; x=1789156577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KnjOQ/IdtAdF4gwBFBcHkIqZrx7vapmIMmngb4n5JXU=;
 b=Tsg86co7wJSszm6Mx8sxgFp4wm0geteW2D0icCLmw2PwBUqzxUbO/HA7QoINgnVTHu
 7qmOT1MBakMFUnMNUwsO4iheluqLTbqQg8eSjzBkWA+qsTovdBFvKfCQ2FWED7xo9CEo
 6NDY3OJJWU6+J3H5OgeD5VAqb+4eNsQgZGbZ6WD/ylTx0rKfvi4ycGiXYJwoN3X5NmRW
 ycYu759kdzHcVq6YvLzlIPC+FKW9DQT1K+y/p5z6x6KqDXGj7zHAj6sOlJZIf/7YH861
 Fi0rEZECPAsiFDFdpUNZnBwVrkGJyM+uwMysVMMMhOpLNghM2mVvDVSRJ3vxDuF4sHl6
 qm0w==
X-Gm-Message-State: AFuF++mrIpE1VAOMLVxbV4McyKnJrZGCSUHhCI6EuzvyWl1r2DPqaMTd
 HRM5PGv2ZA4depIk5yc9eeyXjQNYx1N4M+8tst2HXztulpdlG7IRq8QqtbT3SAlCOmujoWb9WM4
 fOqa1SM8cVv66S9Uvr+bvRVkSvoOz5kuHDTEJWgkkY3y6ZQW/8gjwSW0LUTz1vhTkTg==
X-Gm-Gg: AYBFou2Th/Ch2NalAvuXW0o67a/N2tVUK1oo+sPc6nwOhuiAzWxs3Gh7MLkkw8CcAk6
 uLSQhfDt5YQ5FfHWrs9eMkeslqgUKDSJUKY5lSl9hjxLrm1omrKUMpawj15VLz0pxV8P9fl36jd
 4T7QO2ZJlp0hTEE4gTEWf+5GoAB542W0FKj9kGvvwDWR09Kgf8+Wf4sJN3xU1bOZ9+QS1fXRoBu
 qdXHfX8vvghYJw7JpPGR49h76sR9UcrQ1D4cUazC27tVp3qnsDGAHCVfbz4RDZrAg6/TIkdhYoJ
 K0UY8qCUtqKjFAnn/CdiyXzgDBjnygpOTtf8RW56LYHbfWhfKDQc6DzbYnfcm30GOYqlrtvFPmu
 KNM3pFNOkyKVnVCnYEh6DBA/EQXNi/mIiD1s4
X-Received: by 2002:a05:6214:311a:b0:90e:7fa0:2da0 with SMTP id
 6a1803df08f44-9103f0c2e81mr103409176d6.26.1788551776598; 
 Fri, 04 Sep 2026 12:56:16 -0700 (PDT)
X-Received: by 2002:a05:6214:311a:b0:90e:7fa0:2da0 with SMTP id
 6a1803df08f44-9103f0c2e81mr103408516d6.26.1788551775981; 
 Fri, 04 Sep 2026 12:56:15 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910406871b6sm29117736d6.32.2026.09.04.12.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 12:56:15 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v10 0/5] hw/riscv: Server Platform Reference Board
Date: Fri,  4 Sep 2026 16:56:05 -0300
Message-ID: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE4MiBTYWx0ZWRfXwyl//x5qoK1S
 a4Ezxf1zftOEjUM+EUxonM7mdwkTTG/JkE2ENMDSjDJf8heEE25yECpXKstF/lGbpuA3l+l/OB7
 S4msmPKmyqil28cE9P7Oeb2wVdHU/3g=
X-Proofpoint-GUID: GsVmRZZhndl-7FkGfXrA-jNQwK3NjgTm
X-Authority-Analysis: v=2.4 cv=LreiDHdc c=1 sm=1 tr=0 ts=6a9b2261 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=QuDlC9pgq9_tyQN771IA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: GsVmRZZhndl-7FkGfXrA-jNQwK3NjgTm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE4MiBTYWx0ZWRfXwbV/xxOLRMiy
 G1PFASlGL6RuZD6OUzZx3V8hXkYEUR/QtRULphHgeBw8n2sopGrZbpvlwvUhjWl02yfshcGw5iU
 oYrUMvoGiflYUhR43nFS1Cj/Ji6/tpQBFjVMqE2ddVR8D8s41nfRBL8iA3YDPIp38lzABVh+JWr
 S1ypX97/OfAa469DvsgaZ5EqIyxYG8GeVhiOHNA1/j3eBxSUp+l6kIcB3rUKtb5uEqGvd9iSNcO
 PDdSp3Pt1oGPninespiCbaT5ZxMVpuqM7tR82NMULnu0sMnx1+G0/O5irYlX3iPsLiyKbLBHusi
 9mrKnewr7isBO8CesA1dneI2OHnU4Po2XymfugTTVnKuYwnOnftmkXv4FcP3TU2NPbTM0TRiqKs
 zKIlpKBB3aIxRutu2CZgLUJuAf6NfKa9u8/0RybEJha6rFz6wSymuPC/mIw+vjZKm4iDuUdKDV2
 z5v2oU1FAl9yqi+RtPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040182
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Greetings,

The latest RISC-V PR merged in trunk introduced changes that conflicts
with the v9 version.  This version is a trivial rebase on top of it.

No other changes made.  Patches based on master.

All patches acked.

Please bear in mind that we need

[PATCH v7 0/7] riscv: add initial sdext support

To land before this series.


Changes from v9:
- fixed conflicts after changes in QAPI and aia/mtimer APIs that landed
  in master.
- v9 link: https://lore.kernel.org/qemu-devel/20260903183125.682865-1-daniel.barboza@oss.qualcomm.com/


Based-on: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com> 
([PATCH v7 0/7] riscv: add initial sdext support)

Daniel Henrique Barboza (5):
  target/riscv/cpu.c: remove 'bare' condition for .profile
  target/riscv: add riscv-server-ref CPU
  hw/riscv: server platform reference machine
  tests/functional/riscv64: add riscv-server-ref tests
  docs: add riscv-server-ref.rst

 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/riscv-server-ref.rst      |  62 ++
 docs/system/target-riscv.rst                |   1 +
 hw/riscv/Kconfig                            |  16 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/server_platform_ref.c              | 769 ++++++++++++++++++++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  32 +-
 tests/functional/riscv64/meson.build        |   2 +
 tests/functional/riscv64/test_opensbi.py    |   4 +
 tests/functional/riscv64/test_server_ref.py |  88 +++
 11 files changed, 976 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst
 create mode 100644 hw/riscv/server_platform_ref.c
 create mode 100755 tests/functional/riscv64/test_server_ref.py

-- 
2.43.0


