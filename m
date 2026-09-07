Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839ADC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Xfi-0007xg-Et; Mon, 07 Sep 2026 07:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x3Xfh-0007xQ-7v
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:37:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x3Xfe-0001gm-P9
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:37:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687Ammwh3180532
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 11:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wbz+NUyX1mcY6m3RPT/McHzeKi8bAyxsRjF
 xkx87UlY=; b=HgLwJUzVEXwHUQh2WKDDb5BkCPiNsXkgG468CHVYa6IcUCSj58a
 aQpzRr7FU6gEWXlJFEvXkLgDZY+h4w7PPaE1OGVHLAqWiK3eT7e67H5tJliCzfiX
 7NO+OtCc3gBrfq6Cdl7fGn117RJHwWZQ17taJjI1+riM8GbRRhQucbfv34JFm3Gs
 rwZmMqEPpozXQuFARaOg1P+yWZ6RJcXLmFA7bFLtrpTAPPK5HE6JAdBxAdbXdnFI
 yRMoFjFiXjS41dKIJYOxslAg5WAT9303YH7Omp610GMLs/6DBn7n3mb2NGzSf8It
 8/Dp1JtcfjQfcFbuUtsFFWvawPPg3z5Ar7A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsw20re5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 11:37:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e8d1600b3so898789a91.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788781069; x=1789385869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wbz+NUyX1mcY6m3RPT/McHzeKi8bAyxsRjFxkx87UlY=;
 b=QwMGrrg7c6QMSx9Ms7dHQV2/Pi3YYPseb3+BTZqquKmn+X6+wnqUOVY+IlqWYpqdGC
 IMHh5MHIpfgpwI6/wui70DiYgjSeMCcuzX0MUnYuU3/krTyOuHMa0zangd1u7noK8jFX
 neSm7Tal8YRK1SxvzoEoGQVBgzCkVF3RPCHoqQHEhx2RTvJSl8YFGvEZQzcZLYDpELhX
 SlKRUd47PgVOt/QF58CdjlIgI3Mq6ecyrEMk8LZEyOEKq8pp0EBuu2vlTTdVgVOQgviK
 eD4s2tBmFzH2o5XUwYQvSzAUFwaXBvXYToElmlcHGwEGWYwsurMgSgo2f6V5x2PidG00
 rnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781069; x=1789385869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wbz+NUyX1mcY6m3RPT/McHzeKi8bAyxsRjFxkx87UlY=;
 b=eRQuo3D1/1eLq8dZVCBSJ8k3F7qIRarmeLC9Le6BfNSn99Kt4DiWuUI+NxYrqy+sYl
 tqqxZDBq3E5OctfUA4afXewF1Foz7LxF7AymIYdjYkiyQRQD8O50DIpfYrI5oEy+MMm1
 MsW4Cr3/338Jml/GBT+gE+54NOjr2n1tS603LzqvhxnIZk4SDsH44sOWotJoHN1jEv9s
 Dfj99q9JnV1SatxfkTcrtJCqwcve2X7WhPECeEgoH7Add7MVj90AjsFkAvIGXfbDWdSV
 /BRca5RLet365sdaAFm7x3uV0OQbJSP+m0rMKll8rRdt5Yl3oo9bOq7sCcA0OGdOV8SV
 NCJw==
X-Gm-Message-State: AFuF++lYfN9vPSxWXVAUNjyRj0463oDYTkVQgwYUDCipGsVFTULHK+JQ
 +nRFv6p4gGmRSuC1kYAL1lOgsgVuv+L88A+Y6gz6jMZlvfiHx6akB0djba3nDclQ/RzrsHivI9d
 HXEQpwCHBHz/x45Vz8ctzZL9JQNM3VE1ISBjVRYxS+DrYOjxuscSBvPSdvhD9vdv7qg==
X-Gm-Gg: AYBFou3NWZqIlKSo88A5JZe4CIxuh7Q3PrfOapINMNqZDhgNlAUgaZGpQot8lE6OCYa
 EVNYkGtbgd9R7qUJXjk1O28pUQpdEPyt/0VVYBpxVTQF6vN2aj4epKAt0PLSwaTIn0QG7i4O7le
 TMBJCrtClLYAx/nmWcrBpbzRaVPxESGXLUu7vSj1TVJf4BKf64qJ289bx75db+o3u3/Ljezp6PS
 q4IVIMYIlkRY5MqweDW1M6P/r2eQzM7hUbVfdCxAruEG1Q7JPsDWjzBY6Qqik1nH/TQC1gtLpL7
 33N0KOwF6UXBW5f49TXANMLAJ5Sx60VjYzexVC07eDNb6cuDeQk+QOQGtUbucN/UACPfHxhbReA
 Z7tYLxn9q0ib9aNd1q3hKvRgNhLLTOZPn3aHT6jOy74DoMh7cq/paD35yYfr5WdUn82XgLLpka7
 Y4vuf1KNxquPPv+lGrbAPA7xlTOvV0Vw0=
X-Received: by 2002:a17:90b:384d:b0:398:bac0:238e with SMTP id
 98e67ed59e1d1-39b3d8377camr16468452a91.6.1788781069108; 
 Mon, 07 Sep 2026 04:37:49 -0700 (PDT)
X-Received: by 2002:a17:90b:384d:b0:398:bac0:238e with SMTP id
 98e67ed59e1d1-39b3d8377camr16468399a91.6.1788781068497; 
 Mon, 07 Sep 2026 04:37:48 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33517b57ac8sm17169507eec.28.2026.09.07.04.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:37:48 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v1 0/2] riscv: add RPMI support for server reference platform
Date: Mon,  7 Sep 2026 17:07:13 +0530
Message-ID: <20260907113715.1219775-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZvaTR0PLSMbhJlHvAWedq0mrPTZSIz4P
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyOCBTYWx0ZWRfXyjJxfOiZrbmo
 j38KlXtlOBhrPaY0EDiHgh0eLiWoIXGTF1nw8oub81Wouij2rAYRs2FtRrl0oj8+6I6dVZW2tCn
 zMoodVpqJY8dYzK0EjKy/IPJiW3nPns=
X-Authority-Analysis: v=2.4 cv=eKwjSnp1 c=1 sm=1 tr=0 ts=6a9ea20d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=D1dBp2MNxbUKwEfqZIUA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyOCBTYWx0ZWRfX/n6IGPOXXEKp
 daf+EWlOCDNojXiR/XYLOsG+QJ0z+L89oi+vbS6yWTRWJqANRORSeD/916ku/X1H9KaOaSnLJwr
 xlOieC5wGcMpiP4dQkOdWhZIZaW3WykNR/MieSf0lIb0vuHkbdddZ9CKZVFBfojvcX0zQz5/mrK
 rUSWs6O8KCOfvmzLrGkFvfHYUSCwQ3cycZi6ZIRU4q0CbJQZyB0wB0HXshMTqzPi0pmDp07o7ln
 vCcQZ2KMOI7JBY9r1tDEVkKUfJ0QUCV1umF7qvU/LrrSKFr7Zj92svJfXZ50z7sFJEuGLxfsCRl
 iNdLTjWGpy3q9f7P6tBfgL5uPhKzrzoyxdhDduSTulq/bgR8F9vJx9TnGjeM1YylW/VzcmBT8fE
 93Sv+0FbUcs0ldQm65UaenEGG9zW9+2L16fe8kAAsHljoGDL3cTWgIos+icDs4IpsTdC6yV8bAq
 PBdJjbP5MsWTJt9TUug==
X-Proofpoint-GUID: ZvaTR0PLSMbhJlHvAWedq0mrPTZSIz4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070128
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
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

Add RPMI support for the RISC-V server reference platform by wiring the
existing RISC-V RPMI device and FDT helpers into the riscv-server-ref
machine.

The series enables Base, System Reset, HSM, and System Suspend service
groups for riscv-server-ref.  When QEMU is built with librpmi support,
the riscv-server-ref machine always advertises reset, shutdown, HSM, and
suspend through RPMI and has no rpmi=on|off machine option.

If librpmi is not enabled in a default riscv64-softmmu build, configure
warns that riscv-server-ref will be built without RPMI support and
continues so RISC-V machines that do not require RPMI still build without
librpmi.  Booting riscv-server-ref from such a build also emits a warning
that RPMI support is not compiled in.

Dependencies:
- Daniel Henrique Barboza's prerequisite server reference board series:
  [PATCH v9 0/5] hw/riscv: Server Platform Reference Board
  https://lore.kernel.org/qemu-devel/20260903183125.682865-1-daniel.barboza@oss.qualcomm.com/
- RPMI virt prerequisite:
  [PATCH v10 00/10] riscv: add initial RPMI virt support
  https://lore.kernel.org/qemu-devel/20260828112803.86636-1-subrahmanya.lingappa@oss.qualcomm.com/

Public branch for this exact stack:
https://github.com/slingappa/qemu/tree/server-ref-platform

The PR/review branch is based on a replay of the RPMI virt support on
top of Daniel's server-ref v9 branch:
https://github.com/slingappa/qemu/tree/server-ref-platform-base

Testing:
- Built riscv64-softmmu with librpmi.
- Ran focused RPMI qtests:
  - qemu:qtest-riscv64/riscv-rpmi-virt-test: 18 subtests passed
  - qemu:qtest-riscv64/riscv-rpmi-server-ref-test: 15 subtests passed
- Built riscv64-softmmu without librpmi.
- Checked that riscv-server-ref boots from the no-librpmi build and
  reports that RPMI support is not compiled in.
- Booted riscv-server-ref Linux guest and checked OpenSBI, Linux, board
  model, e1000e, and init startup console messages.
- Booted riscv-server-ref Linux guest to login prompt and validated
  RPMI-backed poweroff, reboot, and suspend/wakeup from the guest console.

Subrahmanya Lingappa (2):
  hw/riscv: add RPMI support for server reference platform
  tests/qtest: split RISC-V RPMI tests by machine

 MAINTAINERS                              |   2 +-
 docs/system/riscv/riscv-server-ref.rst   |  41 ++
 hw/riscv/Kconfig                         |   1 +
 hw/riscv/server_platform_ref.c           | 146 ++++++-
 meson.build                              |   4 +
 tests/qtest/meson.build                  |   4 +-
 tests/qtest/riscv-rpmi-server-ref-test.c |  36 ++
 tests/qtest/riscv-rpmi-test.c            | 476 ++++++++++++-----------
 tests/qtest/riscv-rpmi-test.h            | 131 +++++++
 tests/qtest/riscv-rpmi-virt-test.c       |  45 +++
 10 files changed, 659 insertions(+), 227 deletions(-)
 create mode 100644 tests/qtest/riscv-rpmi-server-ref-test.c
 create mode 100644 tests/qtest/riscv-rpmi-test.h
 create mode 100644 tests/qtest/riscv-rpmi-virt-test.c


base-commit: 8e3bcd4648eea7e4f38781308eff13cbf828ae82
-- 
2.43.0

