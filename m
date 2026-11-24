Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C02606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BKB6glI1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jmMKB9VQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzdl-0008Tm-U6; Tue, 24 Nov 2026 18:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzdf-0008S2-PY
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:09:28 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzdc-0004rv-GZ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:09:26 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMaXB31654118
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=mEqHR5+GOoK51Sg6ptoDVb
 FldQv3VTelh84WjBi+sKY=; b=BKB6glI1ZOwhEiykeGl5VkOpt+CBThlf5Erzhw
 dJmAWwdcXaq2fLAuz4fGWFyuGzK5ah670gNLaiNeaIvMlviouJbS5fmTFFYDQ9kq
 H6oiXKT16MXQUpgay4kojT6aH3bCOgl2hWvb81btYAaDFhRBIXDlkFRvmZUcujPv
 gMmgyuTkLhsBmanQ1hFTReRZUw6Mhw3Y/EtHOcW1fMZ4qTeVVgNhbXZUtXjVceDb
 MozDzNafJsGCD2hf23i0Ywq1lo+a/OhfMu7ogDP1ywbWtPBzXKHY+x68RYvmLJLV
 rU0BaROQLw83o74+G4b+mDbztUsYEQ/lxvPsJQBZwxWr18cg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eyd98td-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:09:21 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-92109408212so105763876d6.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561760; x=1796166560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mEqHR5+GOoK51Sg6ptoDVbFldQv3VTelh84WjBi+sKY=;
 b=jmMKB9VQQylfpZ7F2XCmRu67/HEIy1cYtr55jwCIvGwHcAeCm265KQ+QMj+0yHG02z
 a6xpZzdU+0MpX3U9N3yHSlz8SQVgExqEZxhEJeNRdsMY7k7EHZHGHB/HcHQmRc2GYsGK
 +1WxVIuyUKIqYo1/sO4OuRTGQmY4rn3YWHA25fmQILX7pAhPhuSGjcbXwFW9PAd1Ku29
 +pRSh//ZfgwFBThWDgtMem60LSYcU8xX3uvMssntiYgMFcVq6eUUV+xLPgq4MLCqT1S/
 FB7O4paABJnvQ9FA4B47X1iVs8vZBELfSZIxsKwsjwIPxp9/aAIIbFQSRNQbYnXMXxz2
 Yl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561760; x=1796166560;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mEqHR5+GOoK51Sg6ptoDVbFldQv3VTelh84WjBi+sKY=;
 b=b5fdB+mMhHoCygS1cMJAVJX05AZMJCPcc64fqv3cv+EjHtFRVfJpUhKrlfNJgCwJSJ
 ScL2gRV+qM+1ZZPlqIM4VxrXbYO9h925MRSMHSUIKlcIEB/vLO2I1K+9na4TFFBfnWVh
 p3PVvrOjD7NTUamPOaKZmbqI3Qk9Nd7C2wzYE+17wynsnX15QPNumpsuMBHzECOP0LXj
 j1iNtU5aoLOYsXhOo4Yu7gqm5zcfxf8/0oJlf0mkxEcfLXvpQ8KHrzKazREXAF3nAkDa
 1W/IlmuSR0HDTj9exTSeEcyTe9T4eVLWY87dGScfaLQf3YFYPP/ksU996cDn7Sb8nLME
 6rVg==
X-Gm-Message-State: APuU4Z+aFw3M5a9LQ+ikSXThfJzzG1yYBJ5oRyqKy9L9VRAdR6hIRol2
 nqvwXRO415rpeiLtukalRUknz/99Sg+e1+uBKjhYF9PXOV3VNVXD2/mcV/4/1rwvD7B/3YeoVBd
 3ITr6DD5FM+YCLtZk5eztXLNS/Bukh9ibHwKO5TDDdWZzaDLRHJQOdY2CAa3u3kq3o9KS
X-Gm-Gg: AZFdTZcdE0ITtrtvXWs/d1H9iKuICTU0p2R1uCxuj6WW+cSF5pdyKPfI72OEzPPwefR
 ARJW94pvkrbHog+/Rd8uzmnNVAopYkyjqBMwzh6YqVgb7g+1c72l161QAq+Xmc0riXLrQbfiphr
 0oOm9AQHam0lPT+MfwQDVv3NzJrX+q5mbpjRhnXqPMFKB14onzdG1pV6uPNY8qvIdgmI4Qkpdkn
 VIEOaCsoccGnqfFl0qHbbig4fyNO7K8HWXVXaz/SRFOIzBHmmvbqFXqB6WrjhpXfW3qK1HYkJWz
 /4n+vN4ZqcvfsYhOfmrhYdKFHlYI1pbQKa+p4J1pgxpBktLD/lKSVfU+DbFF/mTyrffgBGELHqd
 nxvEWDJcrDd0vxTS/0+msIW4KtafgbEHqNMV6ycu8VMaa2WPTvVE2SjdTuHnQCqOsj0CFsYcuCP
 tMWRIi4Mq8s6uXVw==
X-Received: by 2002:a05:620a:a8d4:10b0:93e:c03c:c2ab with SMTP id
 af79cd13be357-94a0327418cmr132036485a.20.1795561760419; 
 Tue, 24 Nov 2026 15:09:20 -0800 (PST)
X-Received: by 2002:a05:620a:a8d4:10b0:93e:c03c:c2ab with SMTP id
 af79cd13be357-94a0327418cmr132033585a.20.1795561759840; 
 Tue, 24 Nov 2026 15:09:19 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb98b4dsm31347233f8f.53.2026.11.24.15.09.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:09:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] Misc HW patches for 2026-11-24
Date: Wed, 25 Nov 2026 00:09:00 +0100
Message-ID: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX8o8HY5ZDWaWK
 5jjCRRpdNi3eXKBoM5l428yan6piv4Cbc8dke7WNmnP3MYr+4MoA+Dgaemeog5XbbBSaXC18BNe
 Z0z36v6TICGCgoPEtdl24HbinaTmGvY=
X-Proofpoint-ORIG-GUID: X-tE_S-hxO_40ykYznH4y_0BAFWB-Hza
X-Proofpoint-GUID: X-tE_S-hxO_40ykYznH4y_0BAFWB-Hza
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b061921 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=BQJTiO58KWaoi10Hfi8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfXxn+mFTnVzAJX
 n/HLKAYnYkBvCgxtCPkzuUQkWrPPB5tJZUG8C9PrrYHylsVnLYOnvSLWNh8GQug0vpNqCrbNOi5
 E7fMEz/KSWMjBO8crqWFWzyzLqmHyaXcUAXz/hn9OG5d8D4DE65YOlDKT6NUmfTQu1J/1tKq39Q
 ccl1PyH7bTkfP8uaVfNocaerqtuMDnyOukebTxf8cmkzYahBA/vKYEyyIMYeLrF5XchWAKKuYdX
 lJQ+Ye8bClNkMNqBHL8suOVcwSS90jj5Vx4pOR20YOS6e5bXNUsYcpIcDJwf87RFTTCFHXpO3Zt
 Ei76Pa8g+uzNDx7LYn/CQyxtkYM53EehD9ao5ikgJ1ZrztpD+kVsQ/E3/vBenjlYX+0rfEvABJp
 gAq5bwPVdQIPZF6zs1ocCVHqmtaBjqyolQDkvDyN0i4N0SxggGeb2ETkdu+DAO0w9b/TVNX/dbK
 CKOcKKl6HNoWlkXTyNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240091
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 6bf90d4fc5027567cb704d7888f5ec792b4ed75a:

  Merge tag 'pull-target-arm-20261124' of https://gitlab.com/pm215/qemu into staging (2026-11-24 07:09:41 -0800)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20261124

for you to fetch changes up to c3800302668ff745e10b810f12723eac7068abda:

  hw/ppc/amigaone: Invalidate TBs on NVRAM write (2026-11-25 00:02:01 +0100)

----------------------------------------------------------------
Misc fixes for 11.2

- SD (card, controller)
- VMWare VGA display
- Parallel NOR Flashes
- I8257 DMA controller
- IDE ATAPI layer
- Amiga One
----------------------------------------------------------------

Denis V. Lunev (1):
  hw/ide/atapi: fix abort on CD-ROM reads past LBA 2^31

Harshit Mukhedkar (1):
  hw/sd/sdcard: Validate migrated blk_len in post_load

Peter Maydell (4):
  hw/display/vmware_vga: Zero-initialize scratch space
  hw/display/vmware_vga: Check for bogus FIFO_STOP and FIFO_NEXT values
  hw/display/vmware_vga: Reject attempts to set resolution outside VRAM
    size
  hw/display/vmware-vga: Check incoming migration width and height

Philippe Mathieu-Daudé (11):
  hw/sd/sdcard: Do not abort when writing DAT lines on invalid cmd state
  hw/sd/sdcard: Fill SPI R1 response for rejected commands
  hw/sd/sdcard: Reject zero block length (CMD16)
  hw/sd/sdhci: Report Auto CMD12 response timeout in error status
  hw/dma/i8257: Read the mask from the RWAMB port
  hw/dma/i8257: Honor the command register group-disable bit
  hw/block/pflash_cfi01: Register VM change handler once
  hw/block/pflash_cfi01: Allow zero-count buffer write
  hw/block/pflash_cfi01: Reject out-of-range blk_offset on load
  hw/block/pflash_cfi02: Return to read-array mode on reset
  hw/ppc/amigaone: Invalidate TBs on NVRAM write

 hw/sd/sdhci-internal.h   |  1 +
 include/hw/ide/ide-dev.h |  2 +-
 hw/block/pflash_cfi01.c  | 12 ++++++++++--
 hw/block/pflash_cfi02.c  |  2 +-
 hw/display/vmware_vga.c  | 23 +++++++++++++++++++----
 hw/dma/i8257.c           |  9 ++++++++-
 hw/ide/atapi.c           | 22 +++++++++++-----------
 hw/ide/macio.c           |  2 +-
 hw/ppc/amigaone.c        |  1 +
 hw/sd/sd.c               | 23 +++++++++++++++++++++--
 hw/sd/sdhci.c            | 17 ++++++++++++++---
 tests/qtest/ahci-test.c  | 36 ++++++++++++++++++++++++++++++++++++
 hw/ide/trace-events      |  8 ++++----
 13 files changed, 128 insertions(+), 30 deletions(-)

-- 
2.55.0


