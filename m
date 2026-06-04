Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EE5CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4l6-0005Ra-RT; Thu, 04 Jun 2026 05:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV4l3-0005R2-DS
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:53:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV4l1-0003h2-Go
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:53:01 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548pon42260794
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 09:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=NZ6hPJRYwadJfMNp9Bnjqd3FquB62aoqSjy
 U8o3/O7I=; b=j6gpmMvh7Cu05idR+ldZHhSIZEn0dBXTGlejYW6G65nMnaBc9Ye
 /ScWOi3Ldx4+xUxnzuUblZ/UsQe2wPWblYHZJBHJJEAVGTnlnABqmDPHbEssmLel
 prXEoklqEtDZKRYBJwzwIa/ROqOJxEKsX3qINHJ8hTGaSuV+Z/LB0I1NMCajQKQR
 i5aXypvsd9i9F+sw7VLo8JGSL2hiRXWCxu74XaM9IWE3cjWagiY75lBunzvWaTgW
 3kApQCkMd65JNZDAi9FLNjtuq4TC8EkEQgenGw/yH6BVc2WeUuYpbmSc94ZEzYgl
 rOFSyN4dbXNncIkTK4UZ0moDjfP6OdpxWNA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejr2mkfn6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 09:52:57 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-660f247c238so867381d50.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 02:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780566777; x=1781171577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NZ6hPJRYwadJfMNp9Bnjqd3FquB62aoqSjyU8o3/O7I=;
 b=LiiHcPCzgCBSoZdn0gKGVXfnTQk04wQSUHWFplXtX4GrRwvxKISliGmKzINW1yUH1y
 3hTYniVEp0Tr78NUy0S45R9uZIXuAelMAOH0ATgaN/bhqP/cVCZRRpTubcoOxiZvIcb/
 sFnIsLrbgKf5JgVUycCOsYl/q8ctbt+05zijyk2UH8/WLNGOVAjUyLJqWgL3kuzhNAMF
 xZIg7T/omUnJElLIpXEfn1kpjWrifvkbi8M4O53ZVGa6Wf1Ec4YQTMfoJ3vuJJJyiqzt
 LE2YAyfqFMO3euxkL6WEPJVgRcX6ky+N4eLOhbY6AEnMoqJy52U7U9EnsjkzU2orW5uX
 wxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780566777; x=1781171577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZ6hPJRYwadJfMNp9Bnjqd3FquB62aoqSjyU8o3/O7I=;
 b=Ef7MralPaaV7twHMg3dSS/6bBWwbhacOrI9ZOwGUf0X/AzsPe2yabYaEeyGPiV5Lld
 uV9c4wAcVBtXT6TbwhpcPUkLVzwjeFb0yymNZLbsOZGMEkPInauZPzndvkLXZ5/cfYr+
 Du8Kel44szFw7EVaPuCHTlvGjH84TS5gVOBNAlAl2vPPIN6ULFAJ/b3vH2VI1eBBc/be
 Jv6z0mg4FDNMS/n06lxFiqjrQvCNLhwz+nP+8UlZl9w6iLr1xyCcoMy5xTPXJetXAaxY
 PKCF+rcChuWeFfS3LHpKIwBv8/MX2BTEzpHUI0LsrlYPk78bO8O5jlqgOrMTE9CgBVpo
 gyOA==
X-Gm-Message-State: AOJu0Ywq6fdHt8GxcOfGCYdSHQyVC9UvQtEvKdc2n8CBC1169yq/rQZ0
 TTjkCgBT+2lvvWl0U8zQT8FVJ1s/Gxkkgx3L1VQ0xP7g4bjPkFZAJp3ARK7PLTTeVOKdGlk60gw
 Q7jYRkhbE0TY16j6DyZ2xD11zgW3w1Ay7ESCQNYdyRdBcYdZtA+WETEIaFHho8saEIg==
X-Gm-Gg: Acq92OFpfpfoYy5BB2yjSdSLYnKue/YXx2xXiZfZq9WTgFcObiIBNZPnmHftrbpexMI
 9yGETwBxY7ybGlOi20jxeHk4zljEakke+DzIg1MXci1ri+NgqlvSCrG3vdWdBkW2FkuYvnSCVN9
 5wamEtCevlT2czhas1HrFGxpK2tnTQSd7DwVGRyJThP1pa091efO9FFs9WZft4+uoYe9BZ36afz
 BC459Jtal0SJrstBnY5aJrzT5NRUz2bx2QV++dCZpSu3mcE8F3Hs22tbpNNDh2CiD4an6RK2wod
 qSEYYjfHiaz8ZWGn3E3u0pE4gUQwCFt0eWVz0CrYhJGkE0IkOaZWZF8cdkePbkCNRJa6K4+KzBa
 9+7mOpbV9PFfKMPX1UEAlc9ut2LfYWJ3VGc7selIvzwhf9O4fJgXDMrE/i76yNGFRpV5lHA==
X-Received: by 2002:a05:690e:480d:b0:65c:1f97:2c4a with SMTP id
 956f58d0204a3-660dbff3992mr3975838d50.16.1780566776880; 
 Thu, 04 Jun 2026 02:52:56 -0700 (PDT)
X-Received: by 2002:a05:690e:480d:b0:65c:1f97:2c4a with SMTP id
 956f58d0204a3-660dbff3992mr3975826d50.16.1780566776465; 
 Thu, 04 Jun 2026 02:52:56 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d64ba680sm3522830d50.21.2026.06.04.02.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:52:55 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v7 0/5] hw/riscv: Server Platform Reference Board
Date: Thu,  4 Jun 2026 06:52:39 -0300
Message-ID: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XEjw3jtXhh92cYkPvaMx9A-PvnFyFarN
X-Proofpoint-ORIG-GUID: XEjw3jtXhh92cYkPvaMx9A-PvnFyFarN
X-Authority-Analysis: v=2.4 cv=A91c+aWG c=1 sm=1 tr=0 ts=6a214af9 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YvhIPXZnleHe2a3Z7c0A:9
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5NSBTYWx0ZWRfX9FdTOqnJXML2
 eO1gBalTbq5ubLuPlIs4RNR8lu38rUZ7aS4UmnEvzWz/ngseIzKZdfe+Ei83Z1q5eYXu+y2gbuJ
 Qx6PfEVIfpNWjcLML63h+hUX0yCqssbSUQ+CUSFPWOxpBSLK/ubTUX6+FN3vg/vC34HkK8Cs8ws
 KdLmHgLqZ96xdo2ZRrMStuEp5wbsG93a8/zWyArQyJc2MxfjFtYcZFvo4OVlU/9EHTerPsKkcUQ
 0S68wMabY8QAGv81iPmGCbkeVdk2Zo2PEo9dd1df4l07gea5OEIQjIDLN8tssYse0jas4lj+B2G
 D951ya6PsZO1mSN9zLkehaS28YXAwrhfNHjDC8k0eq9C3Ym46unl106ftA5VAJmZ9w6D7+3WwaO
 QBVbf7vKvZQ3FkcLKHeWKPQxAttctOklyVjxAiSAuZ0FDFW7UZNoaYnjLMyCWAIdQJeTXBlYZQ6
 ync3Jv187uQH7hVo+Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040095
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In this version a new patch was added to include board tests.  There's
also minor changes in the docs to cite how the board was tested.

No other changes were made.

Patches are based on alistair/riscv-to-apply.next @2d9be31092, plus
Chao Liu's series "[PATCH v6 0/7] riscv: add initial sdext support"
[1].  For convenience this series is available at this branch:

https://gitlab.com/danielhb/qemu/-/tree/riscv-server-ref_v7

Changes from v6:
- patch 4 (new): add riscv-server-ref tests
- patch 5 (former 4): add more information about how the machine can be
  tested/run
- v6 link: https://lore.kernel.org/qemu-devel/20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com/ 


Daniel Henrique Barboza (3):
  target/riscv/cpu.c: remove 'bare' condition for .profile
  tests/functional/riscv64: add riscv-server-ref tests
  docs: add riscv-server-ref.rst

Fei Wu (2):
  target/riscv: Add server platform reference cpu
  hw/riscv: server platform reference machine

 configs/devices/riscv64-softmmu/default.mak |    1 +
 docs/system/riscv/riscv-server-ref.rst      |   52 +
 docs/system/target-riscv.rst                |    1 +
 hw/riscv/Kconfig                            |   15 +
 hw/riscv/meson.build                        |    1 +
 hw/riscv/server_platform_ref.c              | 1373 +++++++++++++++++++
 target/riscv/cpu-qom.h                      |    1 +
 target/riscv/cpu.c                          |   12 +-
 tests/functional/riscv64/meson.build        |    2 +
 tests/functional/riscv64/test_opensbi.py    |    4 +
 tests/functional/riscv64/test_server_ref.py |   57 +
 11 files changed, 1518 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst
 create mode 100644 hw/riscv/server_platform_ref.c
 create mode 100755 tests/functional/riscv64/test_server_ref.py

-- 
2.43.0


