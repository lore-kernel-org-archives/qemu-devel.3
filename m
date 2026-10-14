Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A842CC6B30
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6AX-0001LH-8j; Wed, 14 Oct 2026 17:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6AV-0001L0-Qk
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6AU-0000gv-1h
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJuL3642833
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=t2RVsju4dgaRBOlYtOYqip
 6DKIOzd+1zt7DBwEHUves=; b=VrB9e2F/lh68lFcbe4v0JBSIFYH9O0l6IFncqv
 3d7LkN+dWNKvkEorLR86oGNNBEazOhoXSk3Jdrh+n5t/9GgYp42kP6Wp08y+OqIr
 ITe8lGu4WjZYVSVimgnWWujbcv6db/TXDhQHzytjvviSojPleB7leZOlgKt8BzA7
 rpXYjmYIJGb+zrPnsg4dd4mqeanu3SGlTQtP+TkCvWlcRd9VDCIzCB647baq6WDK
 a8aKxgsJ6+QP2ZZSA0RwLOzAtwJwk0j75O997TgeM8Oxf3DQTMLpOe859J1B4TAm
 6mcGvIfQgIoiT4xr0X5dyttvrLtvDo8UXu3pQGJ7Laip5O9A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470bg3m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3552883bd19so8471429eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011943; x=1792616743; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t2RVsju4dgaRBOlYtOYqip6DKIOzd+1zt7DBwEHUves=;
 b=JqCzAFNmdX2lj/j8GC/h8ySvdp7N9oS2bp+fUW/RknE4CjY39x+8vZPMWyxWWHdeDp
 jI7OrZncnTicpRA5eiYNAZ5grXsXIL/wib5iAdtqKQKHb+1T5FGcUBq0FtkqlXqeP6EH
 oqGGJ0GnwNU+PIh3scxgTBpxxX+1vibfPbVozKpalj7YkcMjNC0Utbrg8KlapMsukfrs
 T24qTyg2bKIO+slt83SCAua+iBtiMV6axQ+kCMWzfFM7J4WTtXSRsmLIB8mlbXXw923a
 SaOnVndsjWq3fMK/VgPAdaHbGs2TCabvVN3jbwciJS6hPGftCEBNIjEInaY2XV02R2kZ
 vDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011943; x=1792616743;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t2RVsju4dgaRBOlYtOYqip6DKIOzd+1zt7DBwEHUves=;
 b=zzd+ex4WHlxqgw3GgGK2QRb3x8iTndesWoZpayea3/c0jlZGo6gs++2htRNaI8mHs8
 1TCweR5OFH0DoVarssSPftcR303S8JWCaYp+epMlYsTmJTTwsMg1h7Jw1Rb1gYLzZLJF
 V3HAuRRPycH8FfoqBuJwxP6UhphEgTm7cfQQwPuJtWZ7manZ3AnM5U9n3WuDysdrU8ye
 T/yoZdsCMqAQps80YqesS7Mcxj9mhpxn/YhVgCG4vUPNMi6gvQvegs0UFgvJwOiHl70X
 7Jc65kO87xC0P2O+d01ft02fYKmSm4R8DcxiAnQ+Rhw/D9PrsxSyFqi3FtpRmpSz3Qc7
 nS/g==
X-Gm-Message-State: AFq9FYLk2giQh67lB8GJfVQRj3e6umiQY56XaRj5rc5Ojt7JOmf/sTsz
 iXuUUemvpGvD0nHhzYKJB7o/8Ghv7hX4bgapRnEZoIk/aYBnNZG8dUAvPGlq6SHisr0dfkp5h1G
 3vhEYkNZWzCm1ZUy6LnEJaNTzlwgzBS3r7ZnVHc1hbNeO7J+X3bE89ET/BMobA18vIg==
X-Gm-Gg: AYBFou2PXkBYnQ9nxzC6N8supdy0woBYnbvvo+ZEBTqz09j20F9JfNBKzvBOcO4UQ/D
 V856sZcqy4dSfpX0dpXKM2v8gFPnuTNziqE1Bk5iYybzLaLf1qyaAdoJ7PWyaoknwwx1h9Foq59
 aCPWE2MhqCkkjFA4bDOmMnGhkjISkU+RyiFh2o/c2UG48F0I1hB2hpOgvkrgfUBMV/FM9AD+uDV
 jRKcLyBB460wXBsoBbwJ2nq7T1+L3kWJz23hXpNIrhSEjW+FwlZRudgpMynt45oEprqESTKdVXP
 DNZMyk4ZJsNjH0x6Npz6RViaDrMsCwPeFoQkElsTm2conHeAxGBHSTh7Vt+pj4sHpnFaCh4AiER
 5PLPBXdbzOL4uiUoeKNGxpSHMXgS88DreDz65g3zDxKkIj2Rk9FeziXWlbjWv
X-Received: by 2002:a05:693c:23c6:b0:351:1f56:3a89 with SMTP id
 5a478bee46e88-3537e00a83amr33131996eec.23.1792011943008; 
 Wed, 14 Oct 2026 14:05:43 -0700 (PDT)
X-Received: by 2002:a05:693c:23c6:b0:351:1f56:3a89 with SMTP id
 5a478bee46e88-3537e00a83amr33131959eec.23.1792011942385; 
 Wed, 14 Oct 2026 14:05:42 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm46562092eec.15.2026.10.14.14.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:05:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 00/12] multi-target: add hexagon
Date: Wed, 14 Oct 2026 21:05:14 +0000
Message-ID: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX81nmAxTNIq6S
 AMHviuUdikml+V9GR6U9a7mF59pFZcu0ABwfDGwUqlu1yN9ms/8bBKcIiX5dkcwoH7vwfNNjL31
 z9c4MbAfmSF1C3XRDNOkFGDNtHBqVQBDHUv5ku9p95slF90TGorhremEnDlhuIOTUYc3ku9JIQo
 YxV2BmJGS8ZkML8VLJaMbVkzJ8mK4nIDRzLjnzveG/BYXM77zEhaOHRazJrW2xb5HoyrfXszB5U
 hvDeRHc8qWBCHCgq1ILawVCTUnuUd8iq0qp5EvxdRgBFuAFjy4x+AedMHzAMxQztbl9dgrGmsgK
 z//7HdvherWs/7+H4RIVllxZzCBHARN9eu9Hs8O5GJxMsARRWVX1xetY9Rfmr5fpeGk5pv/5ZN7
 SRqWEeiocctVC8h948KmXYl7kYHKHtL2PAHa31T8EKeF4zZ0YZC00jXQYhn94bA2urwRGfIrgy/
 VFXf/B4PNhL2DzcYEyA==
X-Proofpoint-GUID: 6AJoJiVKFgs_R-mdoqiMk0XsKYP9ABa0
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acfeea8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=d0C3LG-tqr2QDOkIXKsA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 6AJoJiVKFgs_R-mdoqiMk0XsKYP9ABa0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX3uhxx3zJXAKM
 MJqa97tSqICSmdEht3T+932HbzpETxOUnlHjULA1sHLdyZytcOBVelPkkI10Fs/9GMT44wwUKeQ
 mCueXHC1hptn08M4S/Hj26wVjPxBxmY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140084
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

This series makes hexagon compatible with the other ones we already integrated.

The biggest change is to introduce a semihosting interface, since existing arm
symbols conflict with hexagon ones. This is also need for when we'll integrate
riscv soon.

v3
--

- constify some semihosting operations (now taking a const *cs in parameter).
- edit commit description when using new interface in semihosting
  implementation, to reflect we don't check if semi_ops is NULL.

v2
--

- rebase on top of master (one conflict with helper renaming)

Note: this series is fully reviewed and I'll send it as PR on Friday if there
are no additional comments.

Pierrick Bouvier (12):
  target/hexagon: prefix helpers conflicting with other arch
  target-info: add target_hexagon
  hw/hexagon/virt: make machine available for hexagon target only
  hw/core/cpu: restrict tcg_ops to CONFIG_TCG only
  semihosting: declare semihosting cpu ops
  target/riscv/cpu: constify cpu parameter for riscv_cpu_mxl
  target/riscv: declare semihosting ops
  target/hexagon: declare semihosting ops
  target/arm: declare semihosting ops
  semihosting: use new semihosting ops
  semihosting: remove common_* functions
  meson.build: add hexagon-softmmu to multi-target

 hw/hexagon/virt.c                   |  2 ++
 include/hw/core/cpu.h               |  8 +++++
 include/qemu/target-info.h          |  7 ++++
 include/semihosting/common-semi.h   | 24 +++++++++----
 meson.build                         |  1 +
 semihosting/arm-compat-semi.c       | 56 ++++++++++++++---------------
 target-info.c                       |  5 +++
 target/arm/common-semi-target.c     | 33 +++++++++++------
 target/arm/cpu.c                    |  4 +++
 target/arm/internals.h              |  2 ++
 target/hexagon/common-semi-target.c | 30 ++++++++++------
 target/hexagon/cpu.c                |  2 ++
 target/hexagon/gen_tcg.h            |  2 +-
 target/hexagon/gen_tcg_sys.h        |  2 +-
 target/hexagon/helper.h             |  4 +--
 target/hexagon/hex_mmu.c            |  2 +-
 target/hexagon/hex_mmu.h            |  2 +-
 target/hexagon/internal.h           |  2 ++
 target/hexagon/op_helper.c          |  4 +--
 target/hexagon/translate.c          |  4 +--
 target/riscv/common-semi-target.c   | 37 ++++++++++++-------
 target/riscv/cpu.c                  |  4 +++
 target/riscv/cpu.h                  |  2 +-
 target/riscv/internals.h            |  2 ++
 24 files changed, 161 insertions(+), 80 deletions(-)

-- 
2.43.0


