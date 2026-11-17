Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F7F606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HRpadrhM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N0p/Wvyy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFOT-0001Nc-Gg; Tue, 17 Nov 2026 04:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTFOK-0001NF-0d
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:22:16 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTFOI-0001Yr-3S
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:22:15 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AH6M3KW3980901
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 09:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=c3T5/LnQXF9f0aALNq0fM3
 XLp2cUR+w131uXYxhZHoc=; b=HRpadrhMgqg+ozpyTIoXT5f4JhBgSXEnFhny4V
 i+ak429lxolr44WaEWazePgE98eajILE8TLD/bbk+0g//WBq7wEFfjtqgmr9f5il
 igrXOH0+mYwbW05Vp8XE6quR5IWPIHAguNVEKN8r12sL6Uyu5MUAJsqeEf+Bm3oN
 Xga95G+3LaHGRszqx6kbORNShyZkpUodY0sJLBGwvvTTbXeCVyNYfJbVRutW36rx
 opQOc7Gvthna0St5CemB3D0dGUelBFkR8KAgvoH2LzitGf+X1jh8GHzSTl7QT1i7
 iZpTC+/D274U+ImWJbrPUm6k8joMD/fb7Ep8xRFles/+G8GA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hkd0p55-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 09:22:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f5844cb60so143981185a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794907331; x=1795512131; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c3T5/LnQXF9f0aALNq0fM3XLp2cUR+w131uXYxhZHoc=;
 b=N0p/WvyyEUtct3qzm4kgBmBKvH4hin8kADyRdhYn1ScOJV64keXXE+DKIIm8y0Toin
 msME5lBtEVXYqquaPVtfCqxfQCSj0SmRhDTCDnLoWpBmdPAsRenCFcdoafQi52w1ehSl
 28ehHbOeLAh58qznbPAWBLIJ4A13x6AVgvlwmoTK42FRl3gIWy1W7RTP493tuVoCHj/c
 PYbwy7m4yDjaTF9WpeXQzCMjwxUtrV4oxCODjG6+x3VzAndCnFP1QFS4kC5PzOqC/fbo
 9mxcioIQ8/fLFWQS3D70t2OfXIoJ2tjCchwSR4YG8kr3WRgIFhTUsEhA6gCOT2ody1vV
 kj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794907331; x=1795512131;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c3T5/LnQXF9f0aALNq0fM3XLp2cUR+w131uXYxhZHoc=;
 b=DokYf9ldhaTeHORq6jZGzM9ZJ2s42hQYC0AWqthSeGFJWTV8dwwzkmuAU6RJZQG6QK
 djslKgMEfQTIe5LsXR9Q5Le/404ufMNBGhIiXEZ/QQ5OiqGy5wuItdXkMHBlITe7efLc
 fh92s+cJVHTEZXdX9eZ/UPnDTgZBOXYV0SEqTRIrTPW1FBpNu5Co34JduJ/IFrOoSyNn
 9/mtdUhQ0x6upzsEJwnaNJuYDzdtZsfb6uuxDp8vzpFM9HBXHmM3OldJNWQra+v9f2lG
 JQECEwmpFGe3+tdUsksKuJ8Txxb4DsDDA6OzMdZM3vL19oYDyChNZ2uMcuq+261eXgXx
 EcuA==
X-Gm-Message-State: APuU4Z/4YAbiFeoJCZs8Y95Qvnf5lT1UWgZQ5D6nuaSYdv1cJYVNU2S8
 qR1ZpvrD/LyQay/Q8jl0zgUtNrlywyjcl+sd6thhu2pc3rp/YR6turPXnl5TVm0b4j6fxtyzNZ0
 roEO4XzcgWUVPsbnH6hRE+qAZhoU3cRnZygGHh6Welfwf+j1OXo8hpAZUZWPQk+qYYQ==
X-Gm-Gg: AYBFou1wCON/VJFfd95+ODrE2IQG/GBAD0JDrUBtsOcYNjV3047+D62pIMgC7MBl3v7
 xQy02Xa9UYFYhdLFLIOG2Zc0Q5G8rh5d+//zUA3za5XBxvaIqxhEGqaJ40/ynT/GoMhbQ1awBFf
 GNIkGRNA23c8sDRC+uhpsyAr0C8JX+TLp+0Up8AmxAeDXBvnHt/Er6qgLGmoiLmUpZHg/jEjuW/
 YaDxmJxv2bbeqRb/5hE4vX97jPpNgso/QWK1lpSnMV5ooEcyUFeLlywIfFFv92jt5W02B57Bl5f
 gBeRhFhKFchMaMcUAsMH9uBtoFcdwhtXlKvXa5UVeFdoRFzLRKlXj0YTc9wT5RCgci76UN2+TLf
 Kw/9abAFndgopczveTu2FYP5RImsThe2REOVj1qYtqf4Ws9OjzjWGZKCbz415HvfP4Eim2v83TD
 nPvty+YcFYCEziVw==
X-Received: by 2002:a05:620a:2910:b0:949:671a:cc77 with SMTP id
 af79cd13be357-9498b765b0amr295693385a.1.1794907331125; 
 Tue, 17 Nov 2026 01:22:11 -0800 (PST)
X-Received: by 2002:a05:620a:2910:b0:949:671a:cc77 with SMTP id
 af79cd13be357-9498b765b0amr295690985a.1.1794907330586; 
 Tue, 17 Nov 2026 01:22:10 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49d673ce75fsm20149108f8f.55.2026.11.17.01.22.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Nov 2026 01:22:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/22] Misc TCG & HW patches for 2026-11-17
Date: Tue, 17 Nov 2026 10:22:07 +0100
Message-ID: <20261117092208.50442-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eqFKXYpX c=1 sm=1 tr=0 ts=6afc1cc3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=LKIf4-MQdHYapxLYbd4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfXyo5/I0YpmGN/
 9sPcc8DPPgeOVSTCZUWjAzrRwvducLvFjw77eLWtPzE15TWwB/j5sYJWevsKkarBevnqWSHHt85
 LcZgmoZJmMAibey7skgNlhHg4he6IW4=
X-Proofpoint-GUID: YqpW5FJtQ1-Dr4pJ67Nf9l0zkfQBratv
X-Proofpoint-ORIG-GUID: YqpW5FJtQ1-Dr4pJ67Nf9l0zkfQBratv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfX8Q3tzyUXrLbO
 xawP2aQalxOnwh6gX19bR4NBnwwdKE1g/1V7znuaB6uWQy0QiP3t9JGpNdQv0v7Ups14lmI7cjj
 8xMFRqJUv0RQwmS+iz+rVojiD95tosxptZ2dt9SEVvi8HdZlXjd81gG5sSlRuyBIf0b3gusLE6R
 7wngSb0gya1uWpy62xB0P6+KWWU6pIW6Mmdvr9Rw0sIlDKJPBhpijdTIOAwVFP7fogwymI8id+7
 Fy0gBO7SsM86nYrMIP2XpFX96YqYjmcQZh0hIbbGebCzFQuS2lPpMpmO/62c2C3KU5TdKkvyHIg
 looX9KITc1vB1T8XBazCQuNPbxaGg9+acklGflkZnTxe4N0gPjFEFYxEeh0AdbMoT5wE1b6J2fr
 rL82WsiLijBMJ3YnKd4f5Tra8Fc1yCpdCJcHY3T/jf0Zu4r5NvDbqXam/AKBZtsfHEkFNWuuGGQ
 7D3MziSKukQCB9goFEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170037
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

v2: Fixed mangled UTF8 in R-b tag (Marc-Andr=C3=A9 Lureau)

The following changes since commit 97c88c61d45dee6e1f9bc160a338048189846d28:

  Merge tag 'docs-security-devices-pull-request' of https://gitlab.com/berrange/qemu into staging (2026-11-16 15:48:48 -0800)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20261117

for you to fetch changes up to f445ebd9d7fc1ea229821646d8d84c41b856da40:

  hw/virtio/virtio-iommu: Fix IOVA address lookup (2026-11-17 10:02:52 +0100)

Ignoring usual spurious checkpatch errors.

----------------------------------------------------------------
Misc fixes for 11.2

- Build system (obsolete Kconfig, QGA, illumos, macOS pvg)
- Fix wrong constant encoding in the vector .vi immediate emitters on RISC-V TCG
- USB device fixes (CCID card, U2F, MTP)
- m25p80, virtio-iommu, Xen
----------------------------------------------------------------

Bin Guo (1):
  hw/usb/u2f: validate ring buffer indices on migration load

Brad Smith (1):
  qga: fix uname() return value check in guest-get-osinfo

Chao Liu (1):
  hw/block/m25p80: fix write enable latch after WRSR2

Eric Auger (1):
  hw/virtio/virtio-iommu: Fix IOVA address lookup

John Snow (3):
  build: remove vestigial CONFIG_SGA
  build: update CONFIG_PVPANIC
  hw/i386: move bios functions into x86-bios.c

Mohamed Mediouni (1):
  pvg: disable by default

Peng Fan (1):
  hw/xen: Mark legacy Xen backends as hotpluggable

Peter Maydell (1):
  hw/usb/ccid-card: Use QemuSemaphore rather than QemuCond

Philippe Mathieu-Daudé (7):
  tcg/riscv64: Factor encode_vi_raw() out of encode_vi()
  tcg/riscv64: Use a uimm5 encoder for vector shift immediates
  tcg/riscv64: Extract elements for vector arithmetic immediates
  tcg/riscv64: Fix constant handling in vector comparisons and selects
  tcg/riscv64: Fix logical vector immediate matching and emission
  tests/tcg/aarch64: Add vector immediate regression tests
  hw/usb/u2f: Use QemuSemaphore rather than QemuCond

Roman Bogorodskiy (2):
  meson.build: fix getifaddrs() detection on illumos
  qga: fix build on illumos

Tommaso Califano (3):
  hw/usb/dev-mtp: Fix recursive delete of directories
  hw/usb/dev-mtp: Check length of class control request
  hw/usb/dev-mtp: Stop processing SendObjectInfo after an error

 configs/devices/i386-softmmu/default.mak |   6 +-
 meson.build                              |   2 +-
 tcg/riscv64/tcg-target-con-set.h         |   1 +
 tcg/riscv64/tcg-target-con-str.h         |   1 +
 hw/block/m25p80.c                        |   1 +
 hw/i386/x86-bios.c                       | 143 ++++++++++++++
 hw/i386/x86-common.c                     | 125 ------------
 hw/i386/x86.c                            |   1 -
 hw/usb/ccid-card-emulated.c              |  22 +--
 hw/usb/dev-mtp.c                         |  24 ++-
 hw/usb/u2f-emulated.c                    |  19 +-
 hw/usb/u2f.c                             |  31 +++
 hw/virtio/virtio-iommu.c                 |   2 +-
 hw/xen/xen-legacy-backend.c              |   7 +
 qga/commands-posix.c                     |   8 +-
 tests/tcg/aarch64/sve-vec-imm.c          | 233 +++++++++++++++++++++++
 tcg/riscv64/tcg-target.c.inc             | 116 ++++++++---
 hw/i386/meson.build                      |   1 +
 meson_options.txt                        |   2 +-
 tests/qtest/meson.build                  |   2 +-
 tests/tcg/aarch64/meson.build            |   1 +
 21 files changed, 555 insertions(+), 193 deletions(-)
 create mode 100644 hw/i386/x86-bios.c
 create mode 100644 tests/tcg/aarch64/sve-vec-imm.c

-- 
2.55.0


