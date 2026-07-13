Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777FFC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwA-0005fT-5L; Mon, 13 Jul 2026 16:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMw8-0005f5-Ho
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMw6-0006P6-Fk
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:32 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9XhS2389503
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=uIeQPAh89lm8VgBT+J3Wbd7n2dBeNwle+Ag
 43rPsYVs=; b=IFdnBk9GDjMyuzwBV/iUjTzZhRH8IaYod74jeGWiaNAq+q2aCBw
 BwKyYZWVHBQ0ikSswk5m0+Mgf752ZZvgUjUtgjy5OK9Xzv1qoZX09zJiVFlEkMI8
 tgvQaWQmRlQK9Zz1feMLpqwcbhhEjVhX24ZlgtV1Bs3saTGJOFtE9zUmKJs5nEQt
 MXcpvaw0YULJeg1/xAAscYgC0QBcVEAJrsCA+A5I3h6joYossNgrRDN35CKvrKys
 c0XsOq0bjApz1vdwmOEdIU4xONLjxyMdiwc7orlNsrtDr/t8QOCt66cDeWNJdyrJ
 GfIPPCr0pi9ZQOwTuzw4Mnre0CwQg1VQjaA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44j0nf5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:28 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8487ed7f7beso302146b3a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973247; x=1784578047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uIeQPAh89lm8VgBT+J3Wbd7n2dBeNwle+Ag43rPsYVs=;
 b=FijqnfeOvkyhqjuNkxzBSBtqLfwB+C1Gez5lxxmc/o5AU0uj8NDgrCfH48XSGJ6LIJ
 xbTy4cGx8WGSK6WW1L26G1/izmPDpD52Q3ccOWRPlkO+031eFs/uZafwJiwDgWy6Ipb/
 kZrVHYO4/jpamLNMDrT8baDiFXcDpVAcRfNNLs9EZ5zjJ6BzSTYQBWd8nQvrobKqpt05
 uAVySAUH5vb3iA9JK4WsbJfTO6TXNZFxLvt1nfiNsDLCfykmRdrHPA60R/vkgRw0zD1D
 1itbZQGwIT0xHVOFkgPRpSPMvXeZRJXGMXhdApHPJPoesV3U2FLl+GvLuF9I9fF9UneY
 4v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973247; x=1784578047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uIeQPAh89lm8VgBT+J3Wbd7n2dBeNwle+Ag43rPsYVs=;
 b=RyMA/pCiSp5HhDh9JrLX2TGEwfqHJRo02EY53MbuCrbd8nF6x5qETkQaaR1VvuhnhL
 daHi0NMf2EVe3b1zj8uspDEa2OcHLhvzVOGIOYIrjGdpM0a323P27fO3hfO+ULcka+S3
 VVFyIqLj42oAuHmyDWdRWyr6vqCMIeKJE8ROpaxqbrVcuMadsQDY4sR5Bth3S9ae4RCS
 M7gb/CbmwpaSQf6ECZqKmd2xFcQwQ/k9nnCB5TQXCc3p53yc/YN5Ovi+Fe0B+nOIqfVN
 qml61xtSGMDXmhw/6QpIZcZC397bBwq1lHUPuAPZiqPM+Vbh85NvBOp1gyFaPK68zGDY
 WSmw==
X-Gm-Message-State: AOJu0YxqcGUWDRynTL4EsEi6xJq++phaI6NXK///+mn6BdTCyWd/9r12
 Qu8caKHes4V68t2bDWAHNpv8LK6EZjcD18UWNQIIbFoU+sHxKiKdwvSqXeeAlLB504CiXxKKzJz
 HD8L7iRYt770iUHVHvxGjIs5i/J8d4VAXkAxZWWRkM0OnDEx3LTJaub/biDnkzpuptDxg
X-Gm-Gg: AfdE7cngN7BZieF4kYPivuq3UnpznyM7JUPfznrOSvy/ZxExmygM/R6bQk5edVwk/+8
 wQ7eg11r0vSGrs7gdWQXcOvP7Ytou6+b+eS2DrKeaVfPM4oSVZcvaHjEooDlbvEnFpvx9mmV9t3
 4YCt25lmVnR59ABYq9La1KPMx0XL8uZQRYEbPKPMdm8q+OjgbDwxSICb+qsHQtk2Ctjlv9FNkv0
 BsiCq4bb3brPIkerwh0QQLgM2IZzCaudXfEY2cZCpYXdgkay0pAc/R2o2uDLz/d23ar0C8iB1UK
 s7Vnr4acD+TIGY0f9P2PSJ1tqh6D8e9nRDUfcHi2kIr+8bwdQGxl+hc6d3PlXoPjpjSITJBiEq+
 q0yPwXeV2rOyk9uVOccsmfpd9tKixTMI71ah9ePEp5lAQgHn18sQJYYGXeRLKKGz166qmwwD5EQ
 ==
X-Received: by 2002:a05:6a20:4e92:b0:3bf:6c07:b2f0 with SMTP id
 adf61e73a8af0-3c110ad2d7fmr10947971637.51.1783973247168; 
 Mon, 13 Jul 2026 13:07:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:4e92:b0:3bf:6c07:b2f0 with SMTP id
 adf61e73a8af0-3c110ad2d7fmr10947944637.51.1783973246772; 
 Mon, 13 Jul 2026 13:07:26 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:26 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH 00/14] hexagon: add semihosting support 
Date: Mon, 13 Jul 2026 13:07:08 -0700
Message-Id: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX1Sm0yrH5NbFh
 oqxxBVVyAHLhpcZyVAFE8ozJIW1PDDBeUJZjyWAnAU9yYRSs54dVcq0FHFaYJHlMvDOJVJFlAmN
 ByU5HIaCqDK1njG6zd20DiMUPYO1izQ=
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a554580 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=MPocqjWHC0lbcK9OoRgA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: ud48dVTqVwj8hdGeEw3wwqwTi8_WaaTF
X-Proofpoint-ORIG-GUID: ud48dVTqVwj8hdGeEw3wwqwTi8_WaaTF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfXxFdUwqQQmeyP
 hPSZpSnOvm/EgHCfOWP3UdzhzY13XN1feu/QovoWcjSw+aYpmSulbDEfORe++v1wiGi7cv3nrVt
 ZMyljODw3I3axFTha1bQulM0ZIgGBTDc6BmThWrzr8qg4fwSyMwCahJGn6t1Lzjfhqu96iVTE/C
 y+9uW+UAOHfUhNg6KvGtmIcOcuanYVxueXiLljjMUeoLIPNPOWzlNxcYm8CMe+F7K450C1HyPxZ
 dFPqSDUhBZslNuWnbh46pXX2t8G7kBvVAOupMtXma8WXiT3JOwlnSdphF3ZS2hIQgcEwgY+W/Lh
 XFuacbNuA0SY/0lMZsLMVf9WsyCqzgvezdiysGw0x74sLqFxcNRW2r4srah3voxrumiPgwd/CZw
 ZQOU8gBUmBbkGMpIrZ1xiUl+UM33a6ELDPdfuO9Rld4X8L+yXGSBgRza2KmPtGPpzy7QT9kaDPQ
 em27z6HVU+8otVgjGGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130208
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

This series adds semihosting support to hexagon system emulation,
together with functional tests for the added operations.

The Hexagon semihosting spec can be found at:
https://docs.qualcomm.com/doc/80-N2040-101_102648/topic/semihosting-specification.html

Brian Cain (4):
  semihosting: add APIs for chardev-aware guest fd routing
  target/hexagon: Add an errno mapping
  python/machine: support routing semihosting output to the test console
  tests/functional: Add hexagon semihosting systests

Matheus Tavares Bernardino (10):
  target/hexagon: fix get_phys_addr_debug with in-page offset
  target/hexagon: fix PC advancement for non-COF TB terminators
  target/hexagon: add aux functions for guest mem load/store
  hexagon: cpu_helper: add reg reading/writing helpers
  semihosting: add callback to set error
  target/hexagon: add semihosting support
  semihosting: add ftruncate helper (to be used for hexagon)
  target/hexagon: add main arch-specific semihosting operations
  target/hexagon: add COREDUMP semihosting operation
  target/hexagon: add OPEN/READ/CLOSE_DIR semihosting operations

 configs/targets/hexagon-softmmu.mak       |   2 +
 include/semihosting/common-semi.h         |   2 +
 include/semihosting/console.h             |   9 +
 include/semihosting/guestfd.h             |   9 +
 include/semihosting/syscalls.h            |   2 +
 target/hexagon/cpu.h                      |   1 +
 target/hexagon/cpu_helper.h               |  24 +
 target/hexagon/internal.h                 |   1 +
 hw/hexagon/hexagon_dsp.c                  |   7 +
 hw/hexagon/virt.c                         |   5 +
 semihosting/arm-compat-semi.c             |   3 +-
 semihosting/console.c                     |   5 +
 semihosting/guestfd.c                     |   8 +
 semihosting/syscalls.c                    |  29 +
 target/arm/common-semi-target.c           |   4 +
 target/hexagon/common-semi-target.c       |  51 ++
 target/hexagon/cpu.c                      |   4 +-
 target/hexagon/cpu_helper.c               | 173 +++++
 target/hexagon/hexswi.c                   | 728 +++++++++++++++++++++-
 target/hexagon/op_helper.c                |  18 +-
 target/hexagon/translate.c                |  13 +-
 target/riscv/common-semi-target.c         |   4 +
 hw/hexagon/Kconfig                        |   1 +
 python/qemu/machine/machine.py            |  10 +-
 qemu-options.hx                           |   8 +-
 target/hexagon/meson.build                |   3 +
 tests/functional/hexagon/meson.build      |   9 +
 tests/functional/hexagon/test_systests.py | 133 ++++
 tests/functional/meson.build              |   1 +
 29 files changed, 1236 insertions(+), 31 deletions(-)
 create mode 100644 target/hexagon/common-semi-target.c
 create mode 100644 tests/functional/hexagon/meson.build
 create mode 100644 tests/functional/hexagon/test_systests.py

-- 
2.37.2


