Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28754C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3UI-0004gd-SQ; Thu, 23 Jul 2026 20:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UG-0004gC-Rg
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UE-0005tU-Ig
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeMZL1069288
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=YQg2WzwRxNHDU12QYDoHdK
 fk7830UI6D6q/FsnmPz+M=; b=pYDImRQiKxIBHqK9HQ1qWAMGqVORUOCZmZWeH6
 3yi6wgfg3nHMfjJtZHEg1J2UqeeiBfuuhNSAUHB54gI9N37BIJfWRqMQx7w5FGbX
 So4I0YTkkvQZYgWuYF2DWzEMrqIZ1YMNkdc2EaKzi6MY8jdli/UcB6rH/kUzwOn5
 uCrnevflSX75AO28rsRAtE7+oR8GOCy7uMTjdDymwJLM55xefjLiPtrJuAZQMDOL
 9TNrVPi9MTyNok/mxuHyUI1Cwuj0hs/2iSy9QxTAYnuhARNa8UJcCq9ygx01ZzZf
 OWxrMmYPzw0hOjPljRfvxmyYPxd7FG0/jBt7OUSTsAhTNBkA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkg523f21-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:09:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb5cc1e13f8so1497310a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851794; x=1785456594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YQg2WzwRxNHDU12QYDoHdKfk7830UI6D6q/FsnmPz+M=;
 b=He57wb9Aq/QIDA+G85UI5eKPVQuoCros9cibdedt9fTrkN0eZiL3KCGwilZfW1PQvr
 qVFU+k+CeNL+OCrkkatnDdtUIpPia4VKjZLvvPPqIK+unpX1uGvznzqPS2ZJBL9pUsa3
 YDfDnxuhDWfQ9tagiDnSCaZszDO5y6p3V3HHgOK1RqVxOO5X/hTJta9nhwX7AwRpSTjR
 Zmpl4Gm4YKkh7dn4wq0fRmZ58csvNvBSSm4HYUyuhVYVX0Rsh+XqlxVrUSBm9Zf2I8Os
 p3YZLIpDqEm3d6ahzcZKz+mdUibxmYPxClwfYU1Exu+ZK3rpPigOdnVh1BiuLLQ7bMqL
 DSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851794; x=1785456594;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YQg2WzwRxNHDU12QYDoHdKfk7830UI6D6q/FsnmPz+M=;
 b=aKn6fBdNQm51/FaaFu4g50nq73IL8wqPzphk9nBir7REr2VUHxxRZ56N7V5KR2VNE9
 0gAOLoaeaPx/JjS041rdjJHBfNnq9sszt/BPuDg8wbLcocEZ1xDyQEGgpFnpcZSDP7/5
 quJA8YRAPHDFHoGErhmhZkzSJccfbryab5yC6YGZOk8fCCfJaEOC07Iy4y/r1AzbLscd
 bFfmM/bCfE29dB0OgVfS9W0s70L/3ILGLu+z8UiEMMxKiszIXe22Tb9IbHPIcIVZ/uSo
 4ApOVBctgkF/9YrHetS6ATlJr51nN0r/OO0aE82dwdfXHzufLsm47mvcCxRUuYWxQXCh
 a1qw==
X-Gm-Message-State: AOJu0Yxfoml88cPZZqh6Kl9F/gjmnFaZPf8M4YZWhvsm8wnsCH7/ZZZ7
 6qDA4UIUG0ibSL4UFe80Kradhc8ilV2STXwusmDaUwpq4Xw83VbKvQ7FN436UWi6Las0wsY3IoJ
 JnV/jfSNYpLw2C/Z33ZNBMX9dzrj8D4on8K3FauV0PJLggShXMs7BQ6hzJQWFqolLFA==
X-Gm-Gg: AR+sD103al0dRFa0hcfSucTlzyflIndqjwNzAs29NqAWlMlTHIL80zI/sg3Rr22NuWC
 ObHaCUu3RMV9teG/Gxx9cMu1TvHn+QVz1EP3jFDXH37WWHrv7C+l7QYK8aorjQPz+XTHDxrAhKG
 I5NCquRrGD11deBALMerG+7UIiVw8N3KVSZ6PqYg8/offx80Fr7wz66fwLi43i7ZWsXyyMa6bqN
 DQgXN8IyOPiRjlTMPRfhEOSiLKqMIDZkSCNrW9d3bGkFQ+5KWqpzqkHb0INpKDE9dak2V0jj2Tj
 7nlWlpkaeF1iKQ+71eOihSNesszEVpi6t944IbodLDHxPudkfTdE0Ul/rOcub5vX8Bw068yXmdJ
 d83dGHVM3t4e6ivCnOahseorYtNLHCp0e3oJQq0G+J1XW9B43KFLr+mTrMrkFtrl4RhXaHy0=
X-Received: by 2002:a05:6a20:c784:b0:3c3:ac9c:9a66 with SMTP id
 adf61e73a8af0-3c44b25089bmr5634326637.69.1784851794160; 
 Thu, 23 Jul 2026 17:09:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:c784:b0:3c3:ac9c:9a66 with SMTP id
 adf61e73a8af0-3c44b25089bmr5634289637.69.1784851793628; 
 Thu, 23 Jul 2026 17:09:53 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:09:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 00/27] single-binary: implement dynamic filtering for machine
 types
Date: Fri, 24 Jul 2026 00:09:20 +0000
Message-ID: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DtZmPm/+ c=1 sm=1 tr=0 ts=6a62ad53 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=7WQIUGgTjQZxjCxQNFYA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXww4Za1L4TuFC
 cDLdLLbr/JR2hVg8m5MfaV5uFtbneecrpbQ5k7j0+xYR4ARstm2YCwJQQLHoZKbH+Z613swJcxO
 xyED+xyKa4qn+nj/yjd89PaO3H8YdxI=
X-Proofpoint-GUID: rWNRP57PlTLzyY54vWg0XmEC1WugQTkW
X-Proofpoint-ORIG-GUID: rWNRP57PlTLzyY54vWg0XmEC1WugQTkW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXwvTmIyyJdqyT
 l0IiKZ769bHDXVsPJ0SQnIPlx0Qn27wDZh0SilpOzLIZOpXuSwId0OhHXbvYVlmDF6r2++bD8MG
 6o9+ekdnjjjWapEE3rGi+ELIw7a3JfMlZsdcm1Ne4AVTrRQUEi4uVIrd2WiUL5J1ADDlIH7dT2E
 a+1XoY2s3vwv09yKEsj2zdJhnvBK42ltK/zCYU5SCYCT+SP6SuYh8OIemMrbqxOfZHfm6WGUcT2
 Sh3EMmrOjS1OynU8oVVGpdcTSLVLb081yJHec4E7ySBmSpQDKGTj6d1GW760RErlG9/06FWdOA9
 f3qprGYbwe4hAjmp+W8p1QXn/GsN2oqp9Np2Bj7YO04Dv5AK0eVMBXscVaKiimbZfFbiS1mCYoP
 l+fhw3IQh7nsvUB4prFGNwULBfJQ78wM/mXjLGvGqSfRgw3XLDRI0jNAVL0ulEIghYd7b8IAsJp
 4bSK+xuVs1Rvvfb9nxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Now that we can link a single-binary with at least two targets (arm, aarch64),
we want to make sure that we expose the same set of machines (later devices and
cpus) than target binaries. For that, we implemented a static filtering based on
target interfaces that each machine will implement to declare which targets have
this machine.

However, we discovered that this static filtering is not enough. Indeed, some
machines and devices do not depend only on target, and their presence can depend
on Kconfig or host/target combination. Thus, our static approach can't work, and
we need something more flexible.

This series adds a new TYPE_TARGET_SPECIFIC, that declare a single function
bool is_available(void). From there, any machine type (and later devices and
cpus) can implement it to override their presence for each target.
We first replace the existing static mechanism with this, and once done, we
cleanup all the old interface. One nice benefit is that we can get rid of
config/targets/*.c files, which saves duplication.

This series was tested by comparing list of machines for all qemu system
binaries, before and after this change, to make sure we don't introduce a
regression.

Pierrick Bouvier (27):
  include/qemu/target-info-qom.h: declare TYPE_TARGET_SPECIFIC interface
  hw/arm: implement TYPE_TARGET_SPECIFIC
  target-info: add target_riscv32 and target_base_riscv
  hw/riscv: implement TYPE_TARGET_SPECIFIC
  target-info: add target_config_multiprocess
  hw/remote/machine: remove unsupported arm target
  hw/remote/machine: implement TYPE_TARGET_SPECIFIC
  target-info: add target_config_xen
  hw/arm/xen-pvh: implement TYPE_TARGET_SPECIFIC
  hw/xenpv/xen_machine_pv: implement TYPE_TARGET_SPECIFIC
  target-info: add target_config_nitro
  hw/nitro/machine: implement TYPE_TARGET_SPECIFIC
  target-info-qom: implement new machine filtering per target
  target-info-qom: use TYPE_MACHINE instead of target_machine_typename
  target-info: remove target_machine_typename
  target-info-qom: add type_target_specific
  hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
  hw/arm: remove {arm,arm_aarch64,aarch64}_machine_interfaces
  include/hw/core/boards.h: add DEFINE_MACHINE_TARGET_SPECIFIC
  hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
  hw/arm: remove machines-qom.h
  hw/riscv: remove TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
  hw/riscv: remove {riscv32,riscv32_64,riscv64}_machine_interfaces
  hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
  hw/riscv: remove machines-qom.h
  configs/targets: remove target info definitions
  target-info: rename target-info-stub.c in target-info-def.c

 configs/targets/aarch64-softmmu.c         | 27 ------------
 configs/targets/arm-softmmu.c             | 27 ------------
 configs/targets/meson.build               |  6 ---
 configs/targets/riscv32-softmmu.c         | 26 -----------
 configs/targets/riscv64-softmmu.c         | 26 -----------
 hw/arm/aspeed.c                           |  1 -
 hw/arm/aspeed_ast1040_evb.c               |  4 +-
 hw/arm/aspeed_ast10x0_evb.c               |  7 +--
 hw/arm/aspeed_ast2400_palmetto.c          |  4 +-
 hw/arm/aspeed_ast2400_quanta-q71l.c       |  4 +-
 hw/arm/aspeed_ast2400_supermicrox11.c     |  4 +-
 hw/arm/aspeed_ast2500_evb.c               |  4 +-
 hw/arm/aspeed_ast2500_g220a.c             |  4 +-
 hw/arm/aspeed_ast2500_romulus.c           |  4 +-
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |  4 +-
 hw/arm/aspeed_ast2500_tiogapass.c         |  4 +-
 hw/arm/aspeed_ast2500_witherspoon.c       |  4 +-
 hw/arm/aspeed_ast2500_yosemitev2.c        |  4 +-
 hw/arm/aspeed_ast2600_anacapa.c           |  4 +-
 hw/arm/aspeed_ast2600_bletchley.c         |  4 +-
 hw/arm/aspeed_ast2600_catalina.c          |  4 +-
 hw/arm/aspeed_ast2600_evb.c               |  4 +-
 hw/arm/aspeed_ast2600_fby35.c             |  4 +-
 hw/arm/aspeed_ast2600_fuji.c              |  4 +-
 hw/arm/aspeed_ast2600_gb200nvl.c          |  4 +-
 hw/arm/aspeed_ast2600_rainier.c           |  4 +-
 hw/arm/aspeed_ast27x0-fc.c                |  4 +-
 hw/arm/aspeed_ast27x0_evb.c               |  7 +--
 hw/arm/b-l475e-iot01a.c                   |  4 +-
 hw/arm/bananapi_m2u.c                     |  4 +-
 hw/arm/collie.c                           |  4 +-
 hw/arm/cubieboard.c                       |  4 +-
 hw/arm/digic_boards.c                     |  4 +-
 hw/arm/exynos4_boards.c                   |  7 +--
 hw/arm/imx25_pdk.c                        |  4 +-
 hw/arm/imx8mm-evk.c                       |  4 +-
 hw/arm/imx8mp-evk.c                       |  4 +-
 hw/arm/integratorcp.c                     |  4 +-
 hw/arm/kzm.c                              |  4 +-
 hw/arm/max78000fthr.c                     |  4 +-
 hw/arm/mcimx6ul-evk.c                     |  4 +-
 hw/arm/mcimx7d-sabre.c                    |  4 +-
 hw/arm/microbit.c                         |  4 +-
 hw/arm/mps2-tz.c                          | 13 +++---
 hw/arm/mps2.c                             | 13 +++---
 hw/arm/mps3r.c                            |  4 +-
 hw/arm/msf2-som.c                         |  4 +-
 hw/arm/musca.c                            |  7 +--
 hw/arm/musicpal.c                         |  4 +-
 hw/arm/netduino2.c                        |  4 +-
 hw/arm/netduinoplus2.c                    |  4 +-
 hw/arm/npcm7xx_boards.c                   | 16 ++++---
 hw/arm/npcm8xx_boards.c                   |  4 +-
 hw/arm/olimex-stm32-h405.c                |  4 +-
 hw/arm/omap_sx1.c                         |  7 +--
 hw/arm/orangepi.c                         |  4 +-
 hw/arm/raspi.c                            | 16 ++++---
 hw/arm/raspi4b.c                          |  4 +-
 hw/arm/realview.c                         | 13 +++---
 hw/arm/sabrelite.c                        |  4 +-
 hw/arm/sbsa-ref.c                         |  4 +-
 hw/arm/stellaris.c                        |  7 +--
 hw/arm/stm32vldiscovery.c                 |  4 +-
 hw/arm/versatilepb.c                      |  7 +--
 hw/arm/vexpress.c                         |  7 +--
 hw/arm/virt.c                             |  4 +-
 hw/arm/xen-pvh.c                          |  4 +-
 hw/arm/xilinx_zynq.c                      |  4 +-
 hw/arm/xlnx-versal-virt.c                 |  7 +--
 hw/arm/xlnx-zcu102.c                      |  4 +-
 hw/core/machine-qmp-cmds.c                |  3 +-
 hw/core/null-machine.c                    |  9 +---
 hw/nitro/machine.c                        |  4 +-
 hw/remote/machine.c                       |  5 +--
 hw/riscv/boston-aia.c                     |  4 +-
 hw/riscv/k230.c                           |  4 +-
 hw/riscv/microblaze-v-generic.c           |  4 +-
 hw/riscv/microchip_pfsoc.c                |  4 +-
 hw/riscv/opentitan.c                      |  4 +-
 hw/riscv/shakti_c.c                       |  4 +-
 hw/riscv/sifive_e.c                       |  4 +-
 hw/riscv/sifive_u.c                       |  4 +-
 hw/riscv/spike.c                          |  4 +-
 hw/riscv/tt_atlantis.c                    |  4 +-
 hw/riscv/virt.c                           |  3 --
 hw/riscv/xiangshan_kmh.c                  |  4 +-
 hw/xenpv/xen_machine_pv.c                 |  3 +-
 include/hw/arm/machines-qom.h             | 46 -------------------
 include/hw/core/boards.h                  |  4 ++
 include/hw/riscv/machines-qom.h           | 46 -------------------
 include/qemu/target-info-impl.h           |  9 +++-
 include/qemu/target-info-qom.h            | 24 ++++++++++
 include/qemu/target-info.h                | 45 +++++++++++++++----
 meson.build                               |  9 +---
 monitor/qemu-config-qmp.c                 |  4 +-
 system/vl.c                               |  5 +--
 target-info-stub.c => target-info-def.c   | 29 ++++++++++--
 target-info-qom.c                         | 54 ++++++++++++++++-------
 target-info.c                             | 36 ++++++++++++---
 target/arm/machine.c                      | 19 +-------
 target/riscv/machine.c                    | 18 +-------
 101 files changed, 385 insertions(+), 481 deletions(-)
 delete mode 100644 configs/targets/aarch64-softmmu.c
 delete mode 100644 configs/targets/arm-softmmu.c
 delete mode 100644 configs/targets/meson.build
 delete mode 100644 configs/targets/riscv32-softmmu.c
 delete mode 100644 configs/targets/riscv64-softmmu.c
 delete mode 100644 include/hw/arm/machines-qom.h
 delete mode 100644 include/hw/riscv/machines-qom.h
 rename target-info-stub.c => target-info-def.c (67%)

-- 
2.43.0


