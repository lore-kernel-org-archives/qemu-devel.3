Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D07C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAsI-0002Ny-NF; Mon, 29 Jun 2026 08:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weAs6-00023Y-Nl
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:13:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weAry-0005IK-FE
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:13:52 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATKPu2579262
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 12:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4S5hg6UoKDcoDtvdEmQB9KlQ/wlZ0Kl+bdd
 kvuCQtcE=; b=mVm227UTh/Kttl+JX/8FLyvlAfatdu/wZ3aIst7AP4lM14ufkI9
 4nr7cl+7HS9MJv6zsvfVkLHZ9zFhBsJRUJ6FpTEwgw0UaYpErWAB93KdSeq/fiwq
 +o4inYh3jpt1oV/ik2+o1KglAVSkTSXVSAq9WAW4SoQRQwi/vNZ2iAVoZj8VPfo+
 DFVtSLtC3J/WEGFFW5yETq33PoFuRYbiIwRhos0xqn11cEpYWSnnecTf7MqejBpM
 cPR7eDWa3GYtQmNnDT5fBMezV3/1jrcN1Sot4QXgHS6XlAq5DxuH6chVQKw2/NKA
 y9uS8APGoeweKAXp5mNCN02dW0RLDi4mq4Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7h8ev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 12:13:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37dfe4f6924so2161735a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782735221; x=1783340021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4S5hg6UoKDcoDtvdEmQB9KlQ/wlZ0Kl+bddkvuCQtcE=;
 b=iKECBQewAjksxqcmOGGRply8JRXSENVJy9IZm2/MhTMc1WqJafv4Rq9AAKR6jiyLJL
 cnoeavMJkmhCrIl0u7bVeHUCTdngxUpvzOwgsA6qteST1XwWnjfPs7NeCPsTebkMwsgG
 BU6Rp9FQRWz6lWW864kDCZmgUnrHBIIjrioXKGTuYRfG1UByEmLejK9rZ5alWqL9Qg9t
 X1eWb3oUwcC1Kw5rdJF8l0EF3b4/iqc+5+Hq9iQX3qK7JtuKjB8W5vCf9Z4ic6sGgCMQ
 4thdGN3fyVz/zuKlGmhe7hC7kqmTOZdiGZf7bvJ4vAklFg2nSzHYALaunGPyZskeRjz5
 nU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782735221; x=1783340021;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4S5hg6UoKDcoDtvdEmQB9KlQ/wlZ0Kl+bddkvuCQtcE=;
 b=Qca+Lgk5P+gHqReUvjwTvQl+Oud42LhoOlICJ4GaCp+Ni6McfgHOmb+aE6uhPFaBFA
 +Us/iZL2rufPiJiICIVBKZsB1U9XyK1eAsWpkfIDJb/PTL7j7hpcGhsY4PKG8amCI4I6
 3s8HRFKstLI30oeZZ03v3ZLAwtrvn7sUWPldSCT5Nkv0RWysaPzTY/zlcsseikId8TpD
 BQIKhcKy3E7yDhT6iz1n42sqoSARftYFl8FwI+vOOYOk3BxUpPlIbEGa+piBgynWw4vg
 wP/8PRQCpJ2EOZOo2GjfPzDCuEjsfZpkSbw7YVttjp7gercUNjgYjITNmPyXG0rfgqHU
 7uyw==
X-Gm-Message-State: AOJu0YwfvnZrttaAu/zN8kfHDpiMeU5qCeFNsDeF9OFjDKQg3HrOF3Yw
 P4r5ka9a83aMZjskzRE4ejSPU6xY/QtBrFNr8ke8sHhOfJSbd8aArqNO+i+v6TmVH9UyKqed3BI
 vSpvzy6MByCXEoRtjbO/9XGSXK80F3Ak40N0xa7YvSFVWFU5SPIjC2TWsnKKYA8GOmg==
X-Gm-Gg: AfdE7ckNUo3GMU/43xhSqlbBGuAfqNJH7+nbu0HaAtsXPwHXdhQgvvbbiUq/cRH1Bl+
 rMa85ERlKeh9ZdxjFxqs3Uw2L93bhOdejgjqAZn9z0X8imxUR3gYxgzaV/PDTLq5bvysaV+Y5mL
 /xAmAH22KUWycpnRZidyGzGXYp1rcWdF4Uhdme6fBsTmdPmWaRrNM0C1hcqqOoHc2rnlnI3236B
 Cc/5m0BrvOpBm6cPR3F73OCPU3/7roMx42wqu7CZVXQKLjRxCLmdYweuCDLovzqZvXoOnwIgLhp
 EZzW9yyPVMw69+Q0NYj1995bXjRdfO2VrGspKIKWHWEf1pyyW7uXSnlzHYgaLyOLcwhYZ0NGDeG
 /MnmiaYcyxubehnXy8vSgaLU3846e598YNXm5MDqEvf5kkw==
X-Received: by 2002:a17:90b:2e49:b0:37f:9cdf:f03c with SMTP id
 98e67ed59e1d1-37f9cdff63amr7801611a91.31.1782735220877; 
 Mon, 29 Jun 2026 05:13:40 -0700 (PDT)
X-Received: by 2002:a17:90b:2e49:b0:37f:9cdf:f03c with SMTP id
 98e67ed59e1d1-37f9cdff63amr7801591a91.31.1782735220429; 
 Mon, 29 Jun 2026 05:13:40 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37e1c93272fsm5800179a91.14.2026.06.29.05.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:13:40 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 0/2] hw/riscv/riscv-iommu.c: additional PTE checks
Date: Mon, 29 Jun 2026 09:13:32 -0300
Message-ID: <20260629121334.567587-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwMCBTYWx0ZWRfX4J2DdrGkr+Yz
 kxCC9dH9eKlbDie2SgEaDSMcjWpFzymf+7C799WdwBsZ5xrigVPrRZqSBi+asz3r9wEUj2xUs6i
 uC+V2xglLQrcwT08gZ4C84r0j6Oh+64=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwMCBTYWx0ZWRfXzH+VMK7Pv6lz
 QD3l64bnJYdRyImAF0/XbfJLG8fUBINrK1LyGo9ji1eyCp9aThE2CjBUDVwqqOEXYEHA83M55cF
 Jv+GRrPkEjYU5t4Fy0JyFu2etlkbCGLQZT5GPqLgwpZnOstbYOJ2JOwXPZTwF81ELHF2XDDgmi8
 vqKWF5tTBU9r3ow7YYR0/jYDfc+++7VBEtOtjhHdN8+yc2bWmg/Ppil6c/97/K0hVuqTH2kHyRa
 5CfFyOshZERUQH3KxY4YEbmnKQk5J7m2TLUuu/ARiu5TGcnZLGjTnfhZd7LTAUhZn1lRgegyaLh
 4mBRMiyOADETXICl/B5BbPZ3rmhw1vkaYqFdYY+rmKssBWIp/T8ag2oGG1yiC6qd46y4rzFpgk5
 /0mHkIwXTVUSnSxhtZwvy29rBdZ8hRM0Q4hovLlN/oAYiBMBGH1dC+KOHZ1tC+bNpUyRq6Qus3X
 d5huGV93PvBPtOtQijg==
X-Proofpoint-ORIG-GUID: 9YBwJk-waVJ8DNfiucvZ3SGuvnqV9qg3
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a426175 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=d0xOqgMxaoBQG4MqiXkA:9
 a=zZCYzV9kfG8A:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 9YBwJk-waVJ8DNfiucvZ3SGuvnqV9qg3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290100
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi,

This is a short series of mostly trivial patches that fixes two gitlab
bugs.

I'm sending them together because they happen to conflict with one
another if applied in separate.


Daniel Henrique Barboza (2):
  hw/riscv/riscv-iommu.c: check for reserved PTE bits
  hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access

 hw/riscv/riscv-iommu.c               | 10 ++++++++++
 tests/qtest/libqos/qos-riscv-iommu.h |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.43.0


