Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF51606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EYbZTpQF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NRqyJwra
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZEU-0000Zt-He; Thu, 12 Nov 2026 13:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZER-0000Yh-TZ
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZEQ-0002zp-2y
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:07 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFaOhS1593513
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=pVWiYHdM6YKo6pteq5QLHc
 WbolKGnQxEQXcOHu3pPXg=; b=EYbZTpQF2OMoLBrRYXaYea+aZcWrI4G3pXZ6uY
 99A+NByG8bn/xCdHumWuBmbteBY0Q9HY8QVuDkq6PlfM1sckgtTdjz0ZTEb/mwcQ
 L/yvPZKSCjegP4I8paPLop3PoSP5PKRABp7SJ/+egtkXiEtX735FdbxFxqQhKHpX
 VLRkGgc1GDj4v5upGN+Pb7r2ucIuB67+qPz1NqVzkbqtWl3a0aKGAdtxw0yCoh8A
 piIKM3HqCwECHKN7/OvdBIUA+rvpdlTgHXeWxg8uieWfYf68Va4acDRCLF1bbAkK
 JSVxUn2i6Tz62EbchMsXTnxaTX0Zg1OXBhGUXgqAbWmN1CZA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8m4m9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:03 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7d2d7d7608dso16217137.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794506943; x=1795111743; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pVWiYHdM6YKo6pteq5QLHcWbolKGnQxEQXcOHu3pPXg=;
 b=NRqyJwraXMK+GZ2Jx+AXMiWPfziKF9hGyEZF3Aa4DhkTkjRLEsGRwDntdLIZYRxB66
 3Qpb+11kcdsdHuNp+IQksPhyTAQeuazPfXjFzkf2WRI6QSdsAY0GgQIPgGsu/nICV95j
 6s8pBoVOBwM3mbT6mAb3ZReAS9yXY6efXPfVWZ7NXMpx5T3t1PKp7MrtfNueqCMNP9hk
 aqFYX0gXnMk5PJsGu4eyYeK8Ct/6FJ3YA1J8psBf3eIY1bxr700/XUSrSWrC33X6zyD5
 z441z5W7ZCZQfAciofZZUBd+pJiWNDglHw/gFS/SzjFLBOWZMN4mmo8PJYnHP0GqrQDD
 c0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506943; x=1795111743;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pVWiYHdM6YKo6pteq5QLHcWbolKGnQxEQXcOHu3pPXg=;
 b=NMbmzDMNEDZK7sMJsU+o9Axrc7A/pDCo2FE9eLm2gC0ggexLydSJgsdemd3Lp7T7G3
 ytRa3Y65PWPgt2k9D/kjXDtfW2KFzXfr18kAOBBZ99CeBmwIooD2XPpHYIib0MOWfHLX
 tlC8P+5+CvG9sVFM5VcUJneMb5bT4S985n3omFRmKYpMRoYAhTlI103YsLN0pXXK2Z7l
 XBt41D46UOVk7htCkk8dpgSp7oPB4LRqJItGk+FeiaPFexc+5cikIBHQoJw/Q0cPJL/x
 6jb3xBitWx9dKdwXKG6OmAz0U+LJ0DZ46sVHar6Xv8O/vQRO3/Pfyokbjto/8RRLOgLa
 SqMw==
X-Gm-Message-State: APuU4Z+tSPIjFsCpdRoUG0epK7slqMUsqP6hRPxSiu8fwTziSDVJanaO
 nbb7kh1XfbhG+hAVJ8v+VB9WNu2CoZqf5pxSOPLM51+GGRxDC9QtG8OLgfUi7VBkijaOPlXwCQd
 1FZ2xRStmSp7jo0Nl0XDv7QeIrw2bFhAtMLzAJ9kKWsL2yyat70aO4+tt/4riFk4LFu4R
X-Gm-Gg: AYBFou31uutxXFa7mdlzvLkwZMyJ2tk4HjytjyOVV8Dvz91nMGxJ/vBzjd/7vG09egt
 xWBbQcgYISHCHsUNf7EglCKWov2AvK3gNPMBEWyGq2m0ABEkcTKDMUHaQ3HqboFQkMTxhWHLF8i
 8k/EepiU7nNve6TWn0VPn3wOlufAZc4VnzI1GAQ2ISvUD7IEaCvzT6qdhnGfIzdw48k5Zuj5y7T
 eoQEtBbqiVnu4TpbukzaRdQbO34/FdgSq4M6uEQrc/4BiWPm+qEUWpwNfITqgprThqy+QvVyFRl
 J8EYxXyVzMf8rtMwci6fEAwrFwFnH86BTD0DErGHGFy7HULlkQrCGs/QMM3v9SBMTUfzqnJ1ioS
 1tO3LOBdgHqMJ5myL2IFTQhK2dC5c8uYgj/ynPwcdb/ce18Jr8sW8xi/EWQHnbztXSr46ypWItg
 VXAWfZYZRUeP/EYw==
X-Received: by 2002:a05:6102:e0a:b0:7d5:c1e0:2482 with SMTP id
 ada2fe7eead31-7d64d69dca2mr7826137.11.1794506942561; 
 Thu, 12 Nov 2026 10:09:02 -0800 (PST)
X-Received: by 2002:a05:6102:e0a:b0:7d5:c1e0:2482 with SMTP id
 ada2fe7eead31-7d64d69dca2mr7803137.11.1794506942015; 
 Thu, 12 Nov 2026 10:09:02 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c1797sm653492f8f.11.2026.11.12.10.09.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 10:09:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Subject: [PATCH-for-12.0 v2 00/12] linux-user/aarch64: Support both endianness
 at runtime
Date: Thu, 12 Nov 2026 19:08:46 +0100
Message-ID: <20261112180859.85380-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfXy8Q/oLljFbEE
 nwYpdcfC9HKXKm0rUb3kuXIDQ88u6xfOm/F6sV2EMOlgiLBTuzy2JmERCKECNcGlTkBxKv+RtfW
 MQYOyXglO8VQlh+cW6V8zJ3pVINXplM=
X-Proofpoint-GUID: aK2hJm6hBHcj215bSxxXGRlUzH6nkV2R
X-Proofpoint-ORIG-GUID: aK2hJm6hBHcj215bSxxXGRlUzH6nkV2R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX9h1M/sKeNxHc
 WwZPQiFJP1EQchj9vBiEfk5iK3xZ3jE/v1vzX7INNCIcOcEdc7zy7213xfejUNLsjCdyGzK1zJT
 rBK9wZmQKw9uhrFT2pmDy8znyreo9GnCNxWxc8/V9AwFAX5AkqmN66tjHxQUKSMUSFe6yTyX6t8
 fBTa9h1knjmA1WGp3MWTiLQojk0PgtIiv/xTMr2go/JXV3kaLS+wADgdDSbf+21jXC7YsXVXt9s
 ZVuloSha4wrnvCo/H4sLErGsvgBmC7Yocvw+NLHK44S3SCZqYR18NwWkfl8LaAgOX16yAIDZclM
 PLQDpSaN+tePXkKgx6uecFRA3KrEq5riySzpbGF5CGGctCR0a9hNgTqxZ+V36orK7aH2FEVKa+D
 V/iaq5uCW38ptaUB6Z33sa2LklrjW6tksn6sgux2Wd8jB9u3yn8BthJJIRbuXg6c3HaLMEYJhp6
 4gSmHlmFIWTS3xicgjw==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af600bf cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=6IaHPsI2-x5WLNNLdMwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120072
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since v1:
- add ./configure error msg
- cover ARM32

This series lets qemu-aarch64 run both little- and big-endian
ELF binaries, retaining qemu-aarch64_be as a compatibility alias.

The ELF loader selects the target byte order once, before execution.
AArch64 CPU, signal, ABI and vDSO handling then use that selection.
Fixed-endian targets and system emulation retain their existing
accessors.

Runtime-endian TargetInfo data is exposed const to readers, allowing
target_big_endian() to be inlined without a separate boolean cache.
The writable initializer remains outside LTO, preserving the boundary
between ELF initialization and subsequent reads.

I compared the complete series against its baseline, with normal and
LTO builds and LE/BE guests and did not notice significative speed
down.

The inspiration comes from previous optimization intent from Richard:
https://lore.kernel.org/qemu-devel/20260511190634.472174-1-richard.henderson@linaro.org/

Philippe Mathieu-Daudé (12):
  tests/tcg/aarch64_be: Check data byte order in hello
  tests/tcg/arm: Add BE8 and BE32 hello tests
  linux-user/aarch64: Move ELF/vDSO endian checks to runtime
  linux-user/aarch64: Move CPU/signal endian checks to runtime
  linux-user/arm: Move ELF/vDSO endian checks to runtime
  linux-user/arm: Move CPU endian checks to runtime
  target-info: Support runtime-endian Linux-user targets
  linux-user: Honor runtime byte order in ABI accesses
  linux-user: Select target byte order from the ELF header
  meson: Support Linux-user executable aliases
  linux-user/aarch64: Unify both endianness under qemu-aarch64
  linux-user/arm: Unify both endianness under qemu-arm

 docs/about/deprecated.rst                 | 23 +++++++++++++
 docs/user/main.rst                        | 18 +++++++++--
 configure                                 | 12 ++++++-
 configs/targets/aarch64-linux-user.mak    |  2 ++
 configs/targets/aarch64_be-linux-user.mak | 10 ------
 configs/targets/arm-linux-user.mak        |  2 ++
 configs/targets/armeb-linux-user.mak      |  9 ------
 meson.build                               | 39 +++++++++++++++++++++--
 include/exec/tswap.h                      | 11 ++++---
 include/qemu/target-info-def.h            | 14 ++++++++
 include/qemu/target-info.h                | 20 ++++++++++++
 linux-user/aarch64/target_elf.h           |  6 +---
 linux-user/aarch64/target_syscall.h       |  6 +---
 linux-user/arm/target_proc.h              | 20 ++++--------
 linux-user/arm/target_syscall.h           |  6 +---
 linux-user/qemu.h                         | 17 +++++++++-
 linux-user/syscall_defs.h                 |  7 ----
 target/arm/cpu.h                          | 10 ++++--
 target/arm/internals.h                    |  2 +-
 linux-user/aarch64/cpu_loop.c             | 12 +++----
 linux-user/aarch64/elfload.c              | 10 +++++-
 linux-user/aarch64/signal.c               | 20 ++++--------
 linux-user/arm/cpu_loop.c                 |  2 +-
 linux-user/arm/elfload.c                  | 36 +++++++--------------
 linux-user/elfload.c                      |  6 +---
 linux-user/main.c                         | 26 +++++++++++++++
 linux-user/syscall.c                      |  6 ++--
 linux-user/uname.c                        | 13 ++------
 target-info-def.c                         | 19 +++++++++++
 target/arm/gdbstub64.c                    |  4 +--
 target/arm/tcg/translate-sve.c            |  2 +-
 tests/tcg/aarch64_be/hello.c              | 16 ++++++----
 tests/tcg/arm/hello-arm-be.c              | 34 ++++++++++++++++++++
 tests/tcg/arm/hello-arm-be32.c            |  4 +++
 .gitlab-ci.d/buildtest.yml                |  2 +-
 .gitlab-ci.d/crossbuild-template.yml      |  4 +--
 linux-user/aarch64/meson.build            | 10 +++---
 linux-user/arm/meson.build                |  4 ---
 tests/tcg/aarch64_be/meson.build          |  4 +--
 tests/tcg/arm/hello-arm.ref               |  1 +
 tests/tcg/arm/meson.build                 | 11 +++++++
 41 files changed, 323 insertions(+), 157 deletions(-)
 delete mode 100644 configs/targets/aarch64_be-linux-user.mak
 delete mode 100644 configs/targets/armeb-linux-user.mak
 create mode 100644 tests/tcg/arm/hello-arm-be.c
 create mode 100644 tests/tcg/arm/hello-arm-be32.c
 create mode 100644 tests/tcg/arm/hello-arm.ref

-- 
2.55.0


