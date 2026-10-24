Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A09606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IuxB9FE5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hqv3Ojba
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfg6-0003zB-76; Sat, 24 Oct 2026 13:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg2-0003xv-Jm
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKffz-0008Gu-5k
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:04 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF0JlV1864398
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=+bd5Mn7R2mIxb6lzfLM8gq
 rni3VMxn4eBX5takIf5s4=; b=IuxB9FE5WRQqK+P1vamwgH2NP/L5cACPr5pB0v
 PURjE5enDJOlkESg78PBHQutAdrV4nwoUWb4QskthH6wWe9Tpwug6Yjj66DSUY7W
 VyZDrFHUEHcsYXWDWeyuiwzxQ3ng4n8gtkj/efsX2LWfyKAySxA9kCqJNTpHNBXH
 7LT6+F4xZuxOT0MGKz3gHQW0urlrBEA5vsy+1NghAZyF2WjfiSZxpEBe8AfP3SJx
 6La267LNxpOtcWfa/ZlLyLsZwnlQA9LiYSTHEvda1ugqabdHOXYn+vWErGFkZRe1
 1Gl2sOTFBssWoxJNHwXPleu/SdngL7r8NJpmgEAep8Lw6Cvw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmruhesk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab2395f104so1544803a91.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863419; x=1793468219; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+bd5Mn7R2mIxb6lzfLM8gqrni3VMxn4eBX5takIf5s4=;
 b=hqv3Ojba3WdcYYBe/KDXxZB4hcnKawPkq4XX3TlCixIv92ptgM3EHyhaTyQaSdl+Tc
 +WecC6vgKRZsXiJG4XscpLhEEmGKn8iaZZw/PFKBAPbmhp1d2lPldEak0jifIz9Qdsrd
 l0oJPhJnjZoShEQAQWRnPVjEK89xKVJplwvLawHHztVz5YyS5G5oml8qRrRhIYkKMyrl
 HTIPPStLQORvSl2B63LJNF1k/RjhrrBrpeLKLDnB1I5AiPVdRjeZPbBw/3fltj3l3mgn
 kg6UmKgoEIp71FxkbpgNuguYaUddPeWsYN3Ti07uw4AelI9WARrCyiZRK3qJsic8yBYE
 IPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863419; x=1793468219;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+bd5Mn7R2mIxb6lzfLM8gqrni3VMxn4eBX5takIf5s4=;
 b=rLyASejEG0B/tmDqYNxs4Z8ZfFXm+/EtFfGPapqXHdL/CG1wacSm+h+uTKG0rYfZBU
 Eq4a3mDJINLtI0gMnK33HVa9fD1HODRKa3gYsKTkKVDcEi3OiT7CkEOfIwzModn71rT8
 fDhER4Oen8ijLt4TY6QPk5YW3eux6zk6XymF4VxhunTSE2B46UhgDQvo7sw6H69lLGVa
 LAmSOAlx9ntxGO1AMPTLmzUn9v8beJLyXG2ulD1IT98uvZSy5Xtd5hMYTopb70akdgeu
 wISuWr/kR4zf3wY29WKGg+afQYihiWhLX3YT7GjXORDP1UAJqXJ54LEUdGIxXpVY/RNQ
 rxTA==
X-Gm-Message-State: AFq9FYIa1HQEobUo7jeRcrDNxEU21Sc3osEW2KAo5bmUAqm//yPy/Jpn
 qe1SfqAzmaAyFnbJbaz3uIU4PJnnnbN1tXTCueTOUxJNf0EZd8L/BKXOw3X/pHtd+I4tgtc38xf
 z3ycxltm+WTFd04gH2ycJ67SB57PyCfXI+0SOU08otSkbrAS8ZokgOl7SL8/W+BAmZg==
X-Gm-Gg: AYBFou2HX7v+EnilmZJihWz3cApxMN4hp2enmYP/N7uJEmp4mDB7fqI8GOzOwtRsRsa
 O3YpLsUx9k8PYPKCu01rvK42FxhEpP5qPPs4/Q0+ZPOwc7HBikq1eM9bV4WBIwuco/eSteQH8x+
 iGV63WPXsVI+GR03WOhNLx+ndnNIeOY64tDcBUvEpk6GZE3v4E/xmnGSFNvr9B4dfFd2CYBHby8
 mA5+Qb2xBWcVkjzuxChzfwHNtNbO2pUPLCq5jlLsOoKKU/lhZmgIx3KjAkWxfGqfjxkgTNIutAq
 eWDh0yuzAFnSXZcIWnowJt/mdBID2LbKnFAbsSg7IIZAk+z1n5h9d77vxWqa/hWWOSVaiqWvUZu
 Tw8dp/vjhRqMM3h/P4leN8MQB9XbsBQnZGoE1Sgd3NIZe815ljRXEq9LjaQSBV94=
X-Received: by 2002:a17:90b:1fc6:b0:3ad:3938:4444 with SMTP id
 98e67ed59e1d1-3adeafb0273mr2350707a91.62.1792863419129; 
 Sat, 24 Oct 2026 10:36:59 -0700 (PDT)
X-Received: by 2002:a17:90b:1fc6:b0:3ad:3938:4444 with SMTP id
 98e67ed59e1d1-3adeafb0273mr2350690a91.62.1792863418548; 
 Sat, 24 Oct 2026 10:36:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:36:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 00/20] multi-target 20261024
Date: Sat, 24 Oct 2026 17:36:29 +0000
Message-ID: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXyBzcSIJEUQR0
 Zj4LAIx5ckYY5PCqsthB8hKYW198SqGLq3FUZL3GwilZimPUDJYc6lMRv0CUrJJUhOrTcDcQCQ+
 QEYlUMmz8u7hrY9tKxigZmxLfnLK4mGLaUWVgGlBBGXEO/Kz8p836WLoikIXSnyc3Q06HcHrrOY
 3MKRL41FsNm3UWxoLX0xxnoU1/ADKVKRdkZimqbR0cjOZ78eSI9hHxgMc1w+D8L4UqwGwoaUGA5
 vrclQErZ0KXItX4TSGWBJJayoIW42BL7Kq9thsHlhp14OawWxAAvZHmEJJsvI4weaQDMP4tlNwR
 0h9LN/HSnT/xiX0vgMLpwa5WGSeilr5+Fb92ZVStfakqEiG76IKc9kyqOeEnmVyBlvPG0nIa6X1
 p4nLR7ekxeYqJoTGTp8R/xO6nD/a5MiLpdjycXJH5VFJsqMXCMqB+4CzT2LySiYvC/h/ZWx+UUe
 xnF/dPO74qWb+Wnv5gA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX1Hvud8gaectL
 8JF6zU3n40uVDSXfRJA1hpNmBdkikR9EcaY/MWOCpHvZrSFwtgcWgmD8BLRxFVkxym4ZDsQXBWU
 c1AVPr72AcgsqYEjCc9IBf7VJBjfW1c=
X-Proofpoint-ORIG-GUID: pJtDrshQ3ubMUnzufj5tQH7bDcyi4CZr
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adcecbc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=xNf9USuDAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=91CwBCBniN9oHHsYdjYA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: pJtDrshQ3ubMUnzufj5tQH7bDcyi4CZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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

The following changes since commit d73149283205645625bfa9fe029cfb68e4c4a9ae:

  Merge tag 'samuel-thibault' of https://people.debian.org/~sthibault/qemu into staging (2026-10-24 16:09:37 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261024

for you to fetch changes up to 59f954f8277e80065b1286bfe89ca8861c08d1c5:

  meson.build: list all remaining softmmu targets as comments (2026-10-24 17:36:09 +0000)

----------------------------------------------------------------
Changes:
- [PATCH v2 00/11] multi-target: prefix helpers with target prefix (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com
- [PATCH v3 0/9] multi-target: add riscv64-softmmu (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (20):
      target/rx: define and call helpers using HELPER macro
      tcg: introduce HELPER_INFO macro
      target/sparc: define crypto helpers using HELPER macro
      tcg: prefix helpers with target base architecture
      target/alpha: remove explicit target specific prefix
      target/hexagon: remove explicit target specific prefix
      target/hppa: remove explicit target specific prefix
      target/microblaze: remove explicit target specific prefix
      target/or1k: remove explicit target specific prefix
      target/rx: remove explicit target specific prefix
      target/tricore: remove explicit target specific prefix
      target-info: add target_base_riscv
      hw/riscv/virt: make machine available for riscv targets only
      test/unit/multi-target: check QOM types can be initialized with any target
      hw/riscv/virt: restrict scope of virt_is_acpi_enabled to this file
      target/riscv: rename virt_acpi_setup to riscv_virt_acpi_setup
      target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv targets
      target/riscv/kvm: restrict kvm-accel-riscv-cpu to riscv targets
      meson.build: add riscv64-softmmu to multi-target
      meson.build: list all remaining softmmu targets as comments

 hw/riscv/virt-acpi-build.c         |  2 +-
 hw/riscv/virt.c                    | 14 +++++----
 include/exec/helper-gen-common.h   |  7 +++++
 include/exec/helper-gen.h.inc      | 48 +++++++++++++++---------------
 include/exec/helper-head.h.inc     |  8 ++++-
 include/exec/helper-info.c.inc     | 16 +++++-----
 include/exec/helper-proto-common.h |  7 +++++
 include/hw/riscv/virt.h            |  3 +-
 include/qemu/target-info.h         |  7 +++++
 meson.build                        | 20 +++++++++++++
 target-info.c                      | 11 +++++++
 target/alpha/fpu_helper.c          |  2 +-
 target/alpha/helper.h              |  2 +-
 target/alpha/translate.c           |  4 +--
 target/hexagon/gen_tcg.h           |  2 +-
 target/hexagon/gen_tcg_sys.h       |  2 +-
 target/hexagon/helper.h            |  4 +--
 target/hexagon/op_helper.c         |  4 +--
 target/hexagon/translate.c         |  4 +--
 target/hppa/helper.h               |  6 ++--
 target/hppa/op_helper.c            |  4 +--
 target/hppa/sys_helper.c           |  8 ++---
 target/hppa/translate.c            |  6 ++--
 target/microblaze/helper.h         | 10 +++----
 target/microblaze/op_helper.c      | 10 +++----
 target/microblaze/translate.c      | 10 +++----
 target/or1k/helper.h               |  2 +-
 target/or1k/interrupt_helper.c     |  2 +-
 target/or1k/translate.c            |  2 +-
 target/riscv/kvm/kvm-cpu.c         |  2 ++
 target/riscv/tcg/tcg-cpu.c         |  1 +
 target/rx/helper.h                 | 12 ++++----
 target/rx/op_helper.c              | 60 +++++++++++++++++++-------------------
 target/rx/translate.c              | 14 ++++-----
 target/sparc/crypto_helper.c       | 30 +++++++++----------
 target/tricore/fpu_helper.c        | 12 ++++----
 target/tricore/helper.h            | 14 ++++-----
 target/tricore/translate.c         | 14 ++++-----
 tests/unit/test-multi-target.c     | 34 ++++++++++++++++-----
 39 files changed, 250 insertions(+), 170 deletions(-)

