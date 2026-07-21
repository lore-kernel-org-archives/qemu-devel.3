Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9470BC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7tV-00060f-5f; Tue, 21 Jul 2026 06:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7tU-00060U-Hg
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7tS-000344-3W
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:12 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARP7H1516533
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=VvMCZNK0xamhD3N+ao2Rgu
 sLjks602Ue1irr5adbzJI=; b=okDDn42/+rtK3oKJgGPyOR5hCO35fwtDPjWjMN
 GjEimOjAZoqfQth+O/ClAtTybiG9zxBneB/Y6pG0v7xrxp3879+RpifvKivFC0cO
 1UnXMRvMRM0v+0ADltQtT8RBClLB4ddF9Zax0S6ve9RHAO4kqmDS2MfV85AffboZ
 m+uutEoOXJR7JVYQ/3WB9Jdpp5atc5rMy8yD6aPjEPozWxHWqc5VSRGvZi9F6PG+
 gGV0n9yy32HODrH5zLbnG1mtdw/9HnxU8OmN9nuNUAin92oPljio9z4A0j86k6sP
 JXiWRgv29+iLBTdG4ABY0PVngDAGK5i+JcsAHBQe2NXtsCTw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6860890-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bf321d786so98355421cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784630407; x=1785235207; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VvMCZNK0xamhD3N+ao2RgusLjks602Ue1irr5adbzJI=;
 b=YF63p5cBEdK8lNf24WwHS6GIYY+tm2/9thyB07r+MjpFR0lafch2W80noVKrx9cW9y
 wZhfFkWvjIpaGKheiugfst/7wpVwWOsILZrZug1KwJ3vr9/odP+lUErP0EDTr/9piDzz
 lXJCehi7/pq3sIn/GZnYtEI4howf2PVh5OjGIewWoezbLpyA7q1mjZ6z8K1qxEP1P3A/
 AoD3m/jvD+0gRNJt3NxQcfco53QUUsmbR3y2y95rwwubbiKdzAUNC0wTnUkeXZ9sTLlM
 wjtOrMxHM4/UCQDgyi9VT9slhWfOppEWnah1axEyaLSnv1LQb3C5enquv/PWCcyMZ2j9
 eBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784630407; x=1785235207;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VvMCZNK0xamhD3N+ao2RgusLjks602Ue1irr5adbzJI=;
 b=XzNxkWk9u1WH9yyXoe5j23SeXhP+gGpd8EPh63fHLTmUeEvjGbIFhEgQT1BwcGk0F+
 FJMZD/X1JzOvkCp2UP6ZPu0+v9y0WWfJ6ZZyapYItVyBXypHjI+RK9IZUIpyC5imAxXG
 /ucrpLS7RJRbnp+mKjk8NYtt4VhVC8aSbZUfpvc4jyaklShXWk5NnVouP839oa1HfsB9
 a4MN7zO128cu6kWsMFYnnvR2bi/M2cSMt9mVMDUlrz8Pa8OyliO9h0ACKXUkvDTQRlB3
 QtFrnIKvw5lgIioNoLVwfK5ONvSsG+RHmbeyNL8ed4BzCcvI1W6Inx8gqPy3V+6ankO4
 y7jQ==
X-Gm-Message-State: AOJu0Yz4SmpryGeeuw37t/1g/UOkepc5M/TGLeAgNBwtv4mA2b906SAc
 0ZfaJgpll+RJTVsF7LQXejC4jRKD+eDiUvrmBQgEB9s5yuW1vtjpBHZIaLybUfbfPC4UN+GPm7f
 7hn2NPXkMudQgLmdogzIbiJQOo0sZzKBNKt6F7LOGNhpAOmfb9+RRsW7W8TtGMs/naw==
X-Gm-Gg: AfdE7clzfl3c1thq6gFbb+JiQHh+BkWM6GM9+KTZXRYhroIzHngi8gPOYNKgnVaxvTM
 cZnMxvCSOI+N9atszSXcrEW0yfnAdePKq00phBPh/NdDfI2j5ZpJXDlemCUU8FgtNo60vDs68vO
 0Xk7lCwtSvEjR7fBgNjZa00i40JaMy+Je0myBLM2avEyx+ghbs43HudVQgrC+UCPBT2X4Gbe0Su
 xzGoGA6ikHGCGJKS9eFIsoYD38WOR3l6Lmwc56U51ps3HleQf3tNhNraQf6Uq/v3EZpC0WHQ3NW
 oEAIJKmgqhAL2qG2iYfRLl1RIZw4DHtD+yG4lzSht+qi7aXl4gnXMWbUJDkMLREbCdcoqCU7epr
 RipJIu79LLzDoeZPTP5JKU/TuDoQE1b7vvl6dzy3vT19ymKz1zEazc8Cpwg==
X-Received: by 2002:ac8:7f13:0:b0:51a:8c99:1f17 with SMTP id
 d75a77b69052e-5213eb8266cmr161699711cf.70.1784630407146; 
 Tue, 21 Jul 2026 03:40:07 -0700 (PDT)
X-Received: by 2002:ac8:7f13:0:b0:51a:8c99:1f17 with SMTP id
 d75a77b69052e-5213eb8266cmr161699431cf.70.1784630406476; 
 Tue, 21 Jul 2026 03:40:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7ea1sm39211975f8f.24.2026.07.21.03.40.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 03:40:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] Misc HW patches for 2026-07-21
Date: Tue, 21 Jul 2026 12:39:55 +0200
Message-ID: <20260721104004.84934-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX8zcRwmHIMWns
 717Qwwmr7CyStOoT9g89tbfvxi975hRd9fLaHdxie0Am+2S+onGNUqSFJ+NvsYmtCjoUIeqZgK1
 J+qshch/d4M8/Q4Px7YUy4qh73WhxEM=
X-Proofpoint-ORIG-GUID: mz0x1nZcpiCvJ8gfJ2J2zvVHh4LpuuR1
X-Proofpoint-GUID: mz0x1nZcpiCvJ8gfJ2J2zvVHh4LpuuR1
X-Authority-Analysis: v=2.4 cv=X75i7mTe c=1 sm=1 tr=0 ts=6a5f4c87 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=_wz04_nRUj-U--lh6QUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfXxkGDeUQrFBs1
 7fZyPN9/gS5y4HOMfC+a9CPp7BMCZ0WFARWyEo3QJE0JUXEXMD7TDPHgf3E3YXHyjHYN5TjBJAP
 ylgYCG63nOT2XRHK/BTFhKtFLpXZHA9xgdcOfcdiWe6QBhgJZJ+5SoyVWApoXGx6DEgD/dz7GoS
 0HpNx0fPVbYROBDCcYOUyo1fWYQb51doLvJ0+Pyurjz2dUFFPz5q3qU+kgsQeW6QyRdLZY75g3A
 Szd6+yIam2dS6cnd4vyhmnI7AnyEWgPKWSwkggSVpkdgYtGNUSsgs1lLQROWlIcQZ5kNeIZijLG
 X69v5tW4K+TMnFs+opXWHOVk9Qumphh3TPJZJPF8lBTwGRytYRLu9nwxDAoZdhlvtjIEal0dTRU
 7Pk14vBMap7NtAA28ximq9mX4a5Ho4Kc2rKos+AxejGxcizmm4gzAfymsmMWE6K8uNW+SXrk5Gt
 /D1a85LRs1FjQNk3E3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210112
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

The following changes since commit bd6079a7a1d14de0918a7715ef6db85dc32de3bb:

  Merge tag 'next-pull-request' of https://gitlab.com/peterx/qemu into staging (2026-07-20 11:12:38 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260714

for you to fetch changes up to d06edc83b522c68627b83d3178197353c4d548ab:

  vfio/listener: Remove unnecessary 'linux/kvm.h' include (2026-07-21 12:38:48 +0200)

----------------------------------------------------------------
Misc HW patches

Various fixes mostly related to misc hardware devices.

The only CI failure is related to a sphinx error, and there is
already developers looking at that so I ignored it:
https://lore.kernel.org/qemu-devel/20260720222717.33078-1-pierrick.bouvier@oss.qualcomm.com/
----------------------------------------------------------------

Bernhard Beschow (1):
  hw/sd/sdcard: Fix error case for CMD18

Bin Meng (1):
  hw/net/cadence: Return current Cadence GEM queue pointers

Cédric Le Goater (1):
  vfio/listener: Remove unnecessary 'linux/kvm.h' include

Haotian Jiang (1):
  hw/audio/intel-hda: restrict all DMA engine paths to memories

Marc-André Lureau (2):
  hw/display/qxl: validate monitors_config heads[] in phys2virt
  replay: fix use of uninitialized pointer on error

Peter Maydell (1):
  net: Correct padding check in qemu_receive_packet()

Philippe Mathieu-Daudé (1):
  hw/misc/applesmc: Fix a typo setting MSSD key

Richard Henderson (1):
  user/guest-host: Include exec/abi_ptr.h

 include/net/net.h         | 23 +++++++++++++++++++++++
 include/user/guest-host.h |  1 +
 hw/audio/intel-hda.c      |  9 ++++++---
 hw/display/qxl.c          |  2 +-
 hw/misc/applesmc.c        |  6 +++---
 hw/net/cadence_gem.c      | 17 ++++++++++++++++-
 hw/sd/sd.c                |  3 ++-
 hw/vfio/listener.c        |  1 -
 net/net.c                 |  2 +-
 replay/replay-debugging.c | 23 ++++++++++++-----------
 10 files changed, 65 insertions(+), 22 deletions(-)

-- 
2.53.0


