Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94B2C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Jbk-0002hU-8w; Wed, 09 Sep 2026 10:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4Jbh-0002gd-6b
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:49:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4Jbf-00078u-5S
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:49:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689DISeS2081000
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 14:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=BNZq8f6haN7eZR2vxXJRo8tSko0cEM1Glc6
 eWHTwJnI=; b=gfKXxhpc5NKEEjLBL51RdBFj9/Z63kTJb93C4sQ1Dx9RMmlctsr
 xmIyPmBvyLDsZxa0y5UzjtYUz5q/jzQSIYvEYV/Pz2g4HGTm5cKiEQ9SqVL3Ubzw
 gSvxSBv34bEjAEkglqFdadlhqRsgZg1UA3/FhWFKhyBz4azR9b4PpHiaDDJfcDYl
 fkVAxeWK8e8mhesD6uzUhHDIMzz7hsmSxBxankeme8ZUWUnutIyrmm/MH5kh4xdA
 LJhgv2RaYIT+Wn/MyBm8+arXcW1JZBMBHRzUnbgyGL/Cq9y0rBptVEZ/+02/EkRF
 rfs8mv0SZWYoNUbbDv77mXAozxC6/BpUEeQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk87r0ek6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 14:48:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90e7f98bcb9so81209616d6.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788965336; x=1789570136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BNZq8f6haN7eZR2vxXJRo8tSko0cEM1Glc6eWHTwJnI=;
 b=DxzmGh/hJ6EIRvoSYMwuN+PtxUx4FvsniJz0Kk6g1HmQKyBv01dK+0uUDIwGI2dWeL
 /9eRmyR17fPxd4ast1fD0EMuiEzsGVU/xVN9E2PZ/i2DnJTa1y5/gXT/t2pnrYPTD5dA
 g7V/ng7qHMU+o6TCovjjcio/4FvQ7f/KgQtwtCInqU5anFB9jKBt8+a9gafhRigIoREa
 yTeTxFjKgFyBqlE2OVRkt3nJTD8ymMc9RmqB0HOtDle4K0E6N2pnwBkFFmMRO8OgXkc2
 VoMWlkthaHqWkQIv2jISvlpIBzvYdi3oQpBgZnVHgXGb6L0NnKezkYsZF2ocgKMT7q1O
 tVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788965336; x=1789570136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BNZq8f6haN7eZR2vxXJRo8tSko0cEM1Glc6eWHTwJnI=;
 b=VyLun3R7X27qflwnyfqXYuZ/Ilg+WFriIQ+992IiEre7h6BZDS/CCJ1o8KMEdl02M9
 2aOi1j1L7QtWo5BYYJsekNGQuP1S+DiikoxHIK/1BaDVii+0KVglT1Miugw0nrGAzFf4
 +VgnRezf7C94Dj9UKCBp/z5td5/pfltFAWTxNrKSMgFlRJmkWSBmrQQifSixDSJoBJil
 j5XQYiT8u8yL73IrngRFNftHXgXL92lx4t8aLRiDC3pNucwTJPvdDBEH/4Pty91SqkzZ
 4ypRPi5RVjsapibVrgKhlaxZ7VeWsr7kQJreBi26pfIiyWInHFRlETA/L9uae+RZ6sIy
 QMYw==
X-Gm-Message-State: AFuF++klohs63XtxI4SX0mTbXuMgNp/wUmHAQpTf5ap9c4qtylbeARuE
 ITJfOt6BF2OrsdVZby+zngBWIYJW9UaExWcC5IMVeRO1UdjsNQb+2iPxwiN2FKV1F+V83h5iH9K
 REaUm746f0NP3I0sN+RbrtRtWgHO2Xd1zfB+b3xLiwJIjRUqi1jeiFIycMsx1qrDleQ==
X-Gm-Gg: AYBFou3zf+M3Opv6b9C9VFJanfvpC4DFQBYFDtbEJDSJjNIu2xAA1HLgP49vtl3sSDY
 JFA1Ltr/h8CuCvLdkHPKjTlSNxhVmVh36TwgJv5MM7KhYiW3Tg/P9eYZw8C5T7HbCIJWIMDTFWq
 r9cPPzzROhddi4632FwXKPHVoaxUH/4OyfF+wx1ACNKOHjwzDK+zd7vfugs+GlR/hea3rG0Sf7t
 2TRJnK2UVlqmKq97+Ci6ANM4IPVFWLReJ6WECgFwPhyiowzlGvrw4ubPLaf6qCEbh8ltZmBrhPT
 bOKwFDrKzJnHp7La6EUkKbR4geEmkv9KsPN9whdhaEtX3vtWsn4auazXlFQlODdFOsceGHUAWMd
 VKBL1D8ykhxU+xZa+w54+W4DUtbaYYtK88rkR
X-Received: by 2002:a05:6214:3f84:b0:90c:e3b5:85da with SMTP id
 6a1803df08f44-910ba02ce24mr27635706d6.0.1788965331203; 
 Wed, 09 Sep 2026 07:48:51 -0700 (PDT)
X-Received: by 2002:a05:6214:3f84:b0:90c:e3b5:85da with SMTP id
 6a1803df08f44-910ba02ce24mr27627106d6.0.1788965325879; 
 Wed, 09 Sep 2026 07:48:45 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910464bf898sm125678886d6.7.2026.09.09.07.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 07:48:45 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v9 0/7] riscv: add initial sdext support
Date: Wed,  9 Sep 2026 11:48:33 -0300
Message-ID: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AImJJIpd c=1 sm=1 tr=0 ts=6aa171d9 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1X1KHL8RLlM2lqwBaMMA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NSBTYWx0ZWRfX2zDN0lfG9Dhv
 1W4XaXICNW4y12kcgCPGCsdYovTYBfFWeli7UQD0czS46iinQ6aPTNy8XxJc1W6fpR4wzi6ZswE
 0c/5hTBdUNW+caKXBj+fgcrmehmrdq36k0tBoe/Zjs006JA1pveAZnIGJqI6Rrd5QTv/IVKqVZQ
 /4mtZTZYmd1oK7xSBQlwTVRdP+xIi3sS/Mp66drHl6Syp0Tb4S0CFdXmzbCq51AwxTQ+ROaXohK
 OaI6gApbLOcM6gDbEU/dUiTqpu5aEspCl7C00hOatT9SrOtXSu3bO9ubdgl0LEirv0UkFAc+b/n
 HloZmBC4OovXPiAjIjbea5P9mnonvZ9q6IKFhYFC1aKBvZykVuLYohjkIAgjXkaDWhQMSE7/jn8
 hCKbXm5BWpQ7eeUOqryge66fTsOI7laI6AI+wfBRp7OLtrDteaV6C9VgjClHdbk4b3HsURIOedo
 ewzg1c8/M6Lf+TbBijQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NSBTYWx0ZWRfX9fi7t19z++jV
 SJJWmthG7HkQuvUB6xqd5Rwc6HVz77kDXQHB2msEdezhO+oi79ntCeJ0ga2IdKRKtlYy1/0/pLe
 vuGUJsBVmqgWr0J0HiCCAd1E6Z51d0A=
X-Proofpoint-ORIG-GUID: ptLjEE6NW9-omOEiZ3l4FmZ5XwnbbD5-
X-Proofpoint-GUID: ptLjEE6NW9-omOEiZ3l4FmZ5XwnbbD5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090165
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

Hi there!

In this new version I changed patch 7 to use the new meson tcg tests
framework.

No other changes made.  Patches based on master.

Changes from v8:
- patch 7:
  - use the new meson infrastructure for test-sdext-sigill.S
- v8 link: https://lore.kernel.org/qemu-devel/20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com/

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
 tests/tcg/riscv64/system/meson.build          |   8 ++
 tests/tcg/riscv64/test-sdext-sigill.S         |  83 ++++++++++++
 17 files changed, 567 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-sdext-sigill.S

-- 
2.43.0


