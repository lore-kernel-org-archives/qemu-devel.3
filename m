Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4B0CD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 20:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNcxV-0005zJ-68; Thu, 14 May 2026 16:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNcxP-0005z1-NS
 for qemu-devel@nongnu.org; Thu, 14 May 2026 16:46:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNcxN-0000oy-VR
 for qemu-devel@nongnu.org; Thu, 14 May 2026 16:46:59 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpM8v3219657
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 20:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=W3TVK8+vBCIJa40Z7PQehmMPL4RBpRba7Kg
 5FRrTlAE=; b=DbUMvUzmguLDariYgF1Vx+0l6D1ijmcjEFKpw0k4jWj1jX0v5af
 9846VkrDuEz/evc4KYmLAIi2kQFX2ewcV8D/T8asnKYSiUm23uQsOpRFlkCiHJ7s
 s+mcxDWXGC01k0UAKH9dO1X/X5YDjJuP8zPo/a363M/zRbevmPP5bQuCpdCN3qG3
 qv5jGyGxYmihB5HghpiVoYWMUY+qj3g69J/pumdINRPQ13Zzx5rEaY4RH3/3/WgJ
 LTrlUVhh8v7hgl5npxvvrVjLlzNVhu9qJ2SomgSSOX72ZHDVZSfhBMpGZxGWTV87
 X7PTxwVXJgfxn9sigGPSnhgCY1ndZLfn5Jw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s0bc9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 20:46:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-90fdd724bf1so555401085a.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778791615; x=1779396415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W3TVK8+vBCIJa40Z7PQehmMPL4RBpRba7Kg5FRrTlAE=;
 b=SYXngviYz/CBFNz7lVe76TptwN+L+KA1lmDanqmtWn8OzliISgnA1ZOdg3piqVNINJ
 H3nNZEdNuGBwCky1OBwmjF8O6FQzeQsf3vpKHUHTtcszkSutfYUh9GjKpJU7zd+WurkC
 G/KnWJVj9K+O4R94ldgO4dhnMCOnceP5EGJ0TIwUjVGL3gc3Tf8q8fEKL+VD6oHGKZEY
 8DEPFDcSPwinV68PBuhZ1ze2Epd/f7YIMbqFDqxl8sUJnETRIAoX0EFj7FXkQ9qVdZXP
 9exl/TS5sA/Albjl9uTUOuyvVBqNgcq1z9rJuxCpmj1v4xPrt0RX4/btup2W7GSe2xys
 Nb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778791615; x=1779396415;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3TVK8+vBCIJa40Z7PQehmMPL4RBpRba7Kg5FRrTlAE=;
 b=DoGhew96U2tWrmMm/pp5ru0TgKHo4HWZ9WDhAB6oLqnXmH7Tkj97Hbwug99WWKREy4
 iqqgM45BP8+KQYSjWvAG7DuBtyHqxdddrUFJBEEvKKlIdQxmtjkvhsSRZhpp5aWE9rdt
 jmMg2rKAzr6pif5EBJY68G+xvg0C+g7xiC7vR3iQew7w7xgyL/OFBUyEKa1AWnoeXN8r
 cYbEj7OnZJxih1MiV0YF3stTccRc1FKe8RHjJFv6SfjsksfIyPgCoEv0BwnWSflb1N6a
 TRLgCAVVL4dT+dCX2FFYPvwX4c5HpXfg/w3sYSl7lW6VjYDh57PVBnDMg6hUhfxu45le
 EtVw==
X-Gm-Message-State: AOJu0YyRRQ+CFcr0LGKcFL4yTcUh7n2MKbbQCMn6EkIr0oaHq6RrVF2l
 tQUvwik1t5oOHS1koSE4dLRFw96bIkaOTmSX+hoPdEZZ9ssg552KZT2UZgUc8tzzr9pKj8Cm11+
 ariTkE/v4cSARJmUWDsZtsfFOsdj0gVZ3r+ifQrDpdWvpG1JL2D1dXl9oRNbvvQYkYw==
X-Gm-Gg: Acq92OEXtb0zLERTJExKevgwOaxM1I16MsJbc9ipgCa6OjtUTDuD78B9GuPZMzu19GM
 e4dNgeBjmzw3mE8vdWzOWWs+2qEtGHTpgcL+HkiuZP5yHzNC3Pfhv0LXzUn5xi9iQbJk+cy1mve
 gW5aEEe5A/KxFWuRFFaAYW3TzvI0L55zzcUZEGa5q2wpqAh/QRe0CfnCUTTLh+9lYZ1wDVI58Rs
 yhCcswCBFZMshu3l5s29vXiHW4rwbuPtA7mhak+5Rfdj4wTrp/YY/qocIKVFIGkPREghs/9gnFT
 DiBI4Q9tjr7qd3SO9urVu7/25zSNeH0dQ48txjZQPHYzodiJ9VBemiY8YL+lfGCg5H34MrJ6/T0
 l8deRJtwR9aFZfyTp8O9KCoiOfE1vhUzHCfG238nRP9fuhuS2RGExbhk49aNXuD/qDgia8kA=
X-Received: by 2002:a05:620a:6910:b0:8cd:8ee1:2eec with SMTP id
 af79cd13be357-911c91b649dmr230785685a.0.1778791614920; 
 Thu, 14 May 2026 13:46:54 -0700 (PDT)
X-Received: by 2002:a05:620a:6910:b0:8cd:8ee1:2eec with SMTP id
 af79cd13be357-911c91b649dmr230780385a.0.1778791614385; 
 Thu, 14 May 2026 13:46:54 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bad2dd8esm343022885a.19.2026.05.14.13.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 13:46:53 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com, andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v6 0/4] hw/riscv: Server Platform Reference Board
Date: Thu, 14 May 2026 17:46:36 -0300
Message-ID: <20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIwNiBTYWx0ZWRfX3dS1mHbF3LR3
 SjDPSZ2fHp4+5RPvrh9AOXlpiJ1lAxfUd0z127IFjy58uhbaFv7Mv0aUOvAxX3HErUJXOvSg9PR
 mF2b4FKMN2a4UMQ/z1pAwSmk3D+2/Tnfrz8l4gIeyPOhd99bMQI+NtmALc9ywrHKTpqwJDI+Jhu
 ZG+xag2B/swiKIDsKdGe6L5T2ZVPJBoRxWHV/YVcptS4AHHh/1PfwrjamkNK9LM0lvqgAUWO17X
 qorv2+SdZdvjuJ5+BgCh1AOKvwdKMbW5Lo9pBco7yPzt09FzKZeQJiybL8UViwkd7EHbPocYOJ1
 dKuwKnHu3eLb+BFgeEjTDfZFmVTxK+HS6bKmJ/ifBWRNVlbbQtNqIH7GGwT7Sa974G9wPGNrB40
 D1tgVhM/TKSBkC6fSEwaIVdQAx31gFXFtmeXs4qCFnxOZb8YCVJAPl6iegOpfUjPygJQQWaKcAt
 U6TAulbgmSShGeJKmWQ==
X-Proofpoint-GUID: aJrKMB6mmQjcIRqo9dkXG9GCrnu1kNDo
X-Proofpoint-ORIG-GUID: aJrKMB6mmQjcIRqo9dkXG9GCrnu1kNDo
X-Authority-Analysis: v=2.4 cv=HJ7z0Itv c=1 sm=1 tr=0 ts=6a0634bf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Q6y0mC3KEe5r5_0tKYQA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140206
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

Hello,

In this version minor changes were made in patch 2 and 4.  No other
changes were made.

Patches are based on alistair/riscv-to-apply.next @56bbd4f25c, plus
Chao Liu's series "[PATCH v6 0/7] riscv: add initial sdext support"
[1].  For convenience this series is available at this branch:

https://gitlab.com/danielhb/qemu/-/tree/riscv-server-ref_v6


Changes from v5:
- patch 2: changed CPU satp mode to sv48
- patch 6: added extra information about how the board will eventually
  support future spec revisions
- v5 link: https://lore.kernel.org/qemu-devel/20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com/

Daniel Henrique Barboza (2):
  target/riscv/cpu.c: remove 'bare' condition for .profile
  docs: add riscv-server-ref.rst

Fei Wu (2):
  target/riscv: Add server platform reference cpu
  hw/riscv: server platform reference machine

 configs/devices/riscv64-softmmu/default.mak |    1 +
 docs/system/riscv/riscv-server-ref.rst      |   37 +
 docs/system/target-riscv.rst                |    1 +
 hw/riscv/Kconfig                            |   15 +
 hw/riscv/meson.build                        |    1 +
 hw/riscv/server_platform_ref.c              | 1371 +++++++++++++++++++
 target/riscv/cpu-qom.h                      |    1 +
 target/riscv/cpu.c                          |   12 +-
 8 files changed, 1438 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst
 create mode 100644 hw/riscv/server_platform_ref.c

-- 
2.43.0


