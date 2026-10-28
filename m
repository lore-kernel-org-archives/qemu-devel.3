Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B0606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OR/mChtu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BICyLdKW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9HT-0000h5-Ka; Wed, 28 Oct 2026 15:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9HP-0000gS-8x
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:25:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9HM-0006AY-RY
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:25:46 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPIT42995031
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=eOEI8Ux9QcTE8BJqlT+fSp
 rb/7WCnJUBpUFh8eIwT9U=; b=OR/mChtuPbO62XQf2C+s6bpPian1aLaUf4Uj/c
 LDF+p6p11F2DfNz4w9V23FrmfhAgK3YtMfAJ9Rg4SHK1y5EwLhS2LQnhWkWH0XS7
 CAAbmFYWxoSYCmoOPUVIYq2l7Csfv7dx+68JNShas/B10o8NqicKNixjJ5XnZwKi
 mB/+3xFD6topCbXTpr7v+un4a+VfDxIVWJDMvUiySoMR5TW0nY4bcEUh6u5OBT92
 9UKY7007NhVClcpJKZxH8hG8ImFXq9howVwGps4bwESxilFuw15vx6Qht7TIfVxc
 7QQivPJ3Qx6W54pscdiHrls0MtyneiiDLcL8iDMkAmiHXFIw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkneurfyw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:25:42 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c817b56adso18942066d6.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215542; x=1793820342; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eOEI8Ux9QcTE8BJqlT+fSprb/7WCnJUBpUFh8eIwT9U=;
 b=BICyLdKW1VSysMfiVIp3aJMIqjOz+KnYRFFYVlirxqIZUzqhIxgeBxIFg5HIhTL9n4
 PEx7MHbZA4hIKlt8XPCD3+R7lSXnT4MxqkmzwQEhntF8mvlrlJTkSo+rkZP0NwjG2bjm
 fG+qrbL0750NS2MbjwbJ8uGuWq8DHx5XRBDdqQAh/NJzAl3Eu841CZCEM+RyLV2X5hNV
 Cj1ZZcdSDcndMB1RHmM+AxlPNJGpFVVzCQoox1C4sc4rMZW6bhYmcFegYu2AZKfUultu
 m7V0RbHBEb+334ODoeYtJKBevHfZmVqqnExbIxrZ9SoXm7/Ha51jiC3UjoBIJmN5RqIY
 K4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215542; x=1793820342;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eOEI8Ux9QcTE8BJqlT+fSprb/7WCnJUBpUFh8eIwT9U=;
 b=b2zpBj3khH/hPuAZRQL6mT1csQsc1RJ/DqVVXdOOTc+nx+dY9piFgoXksg/VC9giu5
 Xv9yhpy707V0IIJxaOEzYBUNOy3ktfxbbpli4i9VcdWxcTfVUVktGbl5XEw89rudz7WQ
 /qFq2nd1wm2zqjKSYfNX5zHM2O5CYplzYYvRJZQ6LC8Wb07erxrj8XCCBA3rxoa8QRar
 H9BOeAhQhUMgd/luYKxF7Nzdl7/hKb7LbtZU1mtYz7o/WRZBM57iv7JnY3euNbPUPM6R
 KMfkGcIDFeULks8piiaBHqS+CuPoe7iT+9qyg2MJAAInUFU/oMOopakEDxRuFosdb7nn
 BA/A==
X-Gm-Message-State: AFq9FYK7AwrOlASArMKui2aM9V5tVI7uGdasscrTpTJPlC2Pl95nMs5f
 hIMRX6TGZLqBNIV+ivi12xGVGM7wPt0WWNJtgLa1vnFWn+6rOurYOwWgxseGXaH/1Xch88hlU2d
 inOqFogDUjNRhGYzC/zX4aoyEgVIG2sax8CFgTPEypt4q1N19GdBcs406hbrj3pkZdQ9o
X-Gm-Gg: AYBFou2Eo8ghX1xWVsS42XdvWUNV19YkeU9n7PY9/5uQFEM161dG3KeUn96TPbCKoD8
 u9gkLuWqd2NKEc6BZsWzx0pcdjN9akbSijMFTIow9s8QzVD10eqMbGlfJT44Il56iNvYoomtdf0
 Csa0EcaGgq9unCfKXdaihntr+4T9aOpORDZu2beK/LJnWayhSQWIRABCPcj/miKja0Y8h7N7d2q
 fzRjsIZvxvpPfj7zT/dCS2ptsoWonXVef/XqTd2CoRMj4VXpZdJZNR5TwMaT4k1JHV0VLeWd7yH
 jxaKUInjiO+QoS1B9Cf7VUyyGS1x4EfjJE/e2H/X6V8Wmt1wJCHPJi1/ZMPKQh2mkFwt5Hs+KwS
 l4I09mXwOXPBGeiv1bDo3Dd4QEJAonyVfbVODQx228yjeBp+JYbW5RtTfU8M9xvQOuXmTzFLNEF
 oxCEz0J8iZ4DlPl8eMaJoa/JFYECLMNw==
X-Received: by 2002:a05:620a:4505:b0:914:afc1:c66d with SMTP id
 af79cd13be357-9440896db71mr490456585a.11.1793215541539; 
 Wed, 28 Oct 2026 12:25:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4505:b0:914:afc1:c66d with SMTP id
 af79cd13be357-9440896db71mr490452385a.11.1793215541043; 
 Wed, 28 Oct 2026 12:25:41 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94f629d5fsm27170535e9.3.2026.10.28.12.25.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:25:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 0/9] target/mips: Re-introduce the R5900 CPU (system) +
 sort tcg tests
Date: Wed, 28 Oct 2026 20:25:28 +0100
Message-ID: <20261028192538.31600-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX9ikl/qPKjeLj
 32NjAxJPMIllzhpVws84mq39I0DrF8avhBha8iFFf4bAc60/yjtwzouL75yMT7SGHHo0OUQJTEo
 YJ2HaV6GbgESfZHgdmaHCSmmKmTZrih4p3MbsAmodFt3t5QOpE8EX9VspKVPjeCrhD5YFi561pJ
 mm2A2OkS2WIR9fcYwWU8QBXd7fjaycWiSu6OZHiry7jwnM1sfP2Tuqy/MWD2NTGT/R48iDZ0fmr
 K6PWQbXDMUWchI6adFIvNhNRI77ACBPfapKRKTIRDLqVnrOYd9wl1pxz8nSbbgzoHSUz85XQhxJ
 ckkWPXuL37i+A7QaOJzXdPmHgNTdZrpujcvUTkuoqPm8OG2OpymTkE53wkJFdgvTx4hMQCnbvLH
 W9xv6UjDyMy5rhvX+h1NBa36D09fQYPddn6FlK7530E7h/PsXiqGrHJoQBmuLRicCEH0TqT5dGj
 AOHqGHr2hmSmV/M1yeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX/QHPtKkDeEx/
 mNfCIPJaHHtqyruOTw499gwj2pRYpRFdEgA74rcQ9AZfK+1wnS0fzVCMAN8aogfKSo+iFlECI4q
 76jNVqt4iUB7pg64i3fZLj+qji2SIok=
X-Authority-Analysis: v=2.4 cv=LoAHWXdc c=1 sm=1 tr=0 ts=6ae24c36 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=Ixn1CAxRAAAA:8 a=gvTcTximQ6crK5jfQFIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=_0vDLAJOulx5KDpLVjVP:22
X-Proofpoint-GUID: 1qw7u_NOxJJgnKJn3nm-8eoidZBapiNH
X-Proofpoint-ORIG-GUID: 1qw7u_NOxJJgnKJn3nm-8eoidZBapiNH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280077
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add R5900 system tests, code is covered, CPU can come back,
allowing to fix a bug on PCGT opcode.

Since [v1]:
- rebased
- added freestanding libc stubs
- o32/n32 tests

[v1]: https://lore.kernel.org/qemu-devel/20210214175912.732946-1-f4bug@amsat.org/

Philippe Mathieu-Daudé (9):
  target/mips: Re-introduce the R5900 CPU in system mode
  target/mips/tx79: Fix PCGT* (Parallel Compare for Greater Than)
  tests/guest-debug: Allow placing the binary within system QEMU args
  tests/tcg/mips64el: Add bare-metal harness for R5900 system tests
  tests/tcg/mips64el: Move R5900 tests to system mode and build with
    meson
  target/mips: Factor mips_gdb_read_value() out
  target/mips: Describe gdbstub registers with XML features
  target/mips: Expose R5900 registers to gdb
  tests/tcg/mips64el: Add a TX79 instruction test in system mode

 MAINTAINERS                                   |   1 +
 configs/targets/mips-linux-user.mak           |   1 +
 configs/targets/mips-softmmu.mak              |   1 +
 configs/targets/mips64-linux-user.mak         |   1 +
 configs/targets/mips64-softmmu.mak            |   1 +
 configs/targets/mips64el-linux-user.mak       |   1 +
 configs/targets/mips64el-softmmu.mak          |   1 +
 configs/targets/mipsel-linux-user.mak         |   1 +
 configs/targets/mipsel-softmmu.mak            |   1 +
 configs/targets/mipsn32-linux-user.mak        |   1 +
 configs/targets/mipsn32el-linux-user.mak      |   1 +
 target/mips/internal.h                        |   2 +
 tests/tcg/mips64el/system/include/assert.h    |  15 +
 tests/tcg/mips64el/system/include/inttypes.h  |   7 +
 tests/tcg/mips64el/system/include/stdio.h     |  17 +
 tests/tcg/mips64el/system/include/string.h    |  16 +
 target/mips/cpu.c                             |   4 +
 target/mips/gdbstub.c                         | 152 +++++-
 target/mips/tcg/tx79_translate.c              |  10 +-
 tests/tcg/mips64el/system/harness.c           |  66 +++
 .../system}/test_r5900_div1.c                 |   0
 .../system}/test_r5900_divu1.c                |   0
 .../system}/test_r5900_madd.c                 |   0
 .../system}/test_r5900_maddu.c                |   0
 .../system}/test_r5900_mflohi1.c              |   0
 .../system}/test_r5900_mtlohi1.c              |   0
 .../system}/test_r5900_mult.c                 |   0
 .../system}/test_r5900_multu.c                |   0
 tests/tcg/mips64el/system/test_r5900_tx79.c   | 477 ++++++++++++++++++
 target/mips/cpu-defs.c.inc                    |  45 ++
 gdbstub/gdb-xml/mips32-cp0.xml                |   9 +
 gdbstub/gdb-xml/mips32-cpu.xml                |  42 ++
 gdbstub/gdb-xml/mips32-fpu.xml                |  41 ++
 gdbstub/gdb-xml/mips64-cp0.xml                |   9 +
 gdbstub/gdb-xml/mips64-cpu.xml                |  42 ++
 gdbstub/gdb-xml/mips64-fpu.xml                |  41 ++
 gdbstub/gdb-xml/mips64-r5900.xml              |  47 ++
 tests/guest-debug/run-test.py                 |   9 +-
 tests/tcg/mips/user/isa/r5900/Makefile        |  32 --
 tests/tcg/mips/user/isa/r5900/README          |   6 -
 tests/tcg/mips64el/meson.build                |   2 +
 tests/tcg/mips64el/system/boot.S              |  23 +
 tests/tcg/mips64el/system/kernel.ld           |  43 ++
 tests/tcg/mips64el/system/meson.build         |  62 +++
 tests/tcg/mips64el/system/test-r5900.py       |  30 ++
 45 files changed, 1211 insertions(+), 49 deletions(-)
 create mode 100644 tests/tcg/mips64el/system/include/assert.h
 create mode 100644 tests/tcg/mips64el/system/include/inttypes.h
 create mode 100644 tests/tcg/mips64el/system/include/stdio.h
 create mode 100644 tests/tcg/mips64el/system/include/string.h
 create mode 100644 tests/tcg/mips64el/system/harness.c
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_div1.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_divu1.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_madd.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_maddu.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mflohi1.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mtlohi1.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mult.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_multu.c (100%)
 create mode 100644 tests/tcg/mips64el/system/test_r5900_tx79.c
 create mode 100644 gdbstub/gdb-xml/mips32-cp0.xml
 create mode 100644 gdbstub/gdb-xml/mips32-cpu.xml
 create mode 100644 gdbstub/gdb-xml/mips32-fpu.xml
 create mode 100644 gdbstub/gdb-xml/mips64-cp0.xml
 create mode 100644 gdbstub/gdb-xml/mips64-cpu.xml
 create mode 100644 gdbstub/gdb-xml/mips64-fpu.xml
 create mode 100644 gdbstub/gdb-xml/mips64-r5900.xml
 delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
 delete mode 100644 tests/tcg/mips/user/isa/r5900/README
 create mode 100644 tests/tcg/mips64el/system/boot.S
 create mode 100644 tests/tcg/mips64el/system/kernel.ld
 create mode 100644 tests/tcg/mips64el/system/meson.build
 create mode 100644 tests/tcg/mips64el/system/test-r5900.py

-- 
2.55.0


