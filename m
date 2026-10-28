Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B6606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jpXW0A6j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YjNHPnM7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9IN-0001Ua-PL; Wed, 28 Oct 2026 15:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9IE-00019s-FD
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9IA-0006Du-UX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPdjm1580036
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pf7VP172a86le6KatWWx9AzTG3KlPIH9Jp+pw3ouWn8=; b=jpXW0A6jeD4yx+dC
 D8UUeB1O0PLqOU+V6riapSH9kWLPrKQDz6Exv91Vmps5qC5JmyrwFz5EYDV/OfX7
 dTEphpAm27oQH5QYWRfK24bVt8YKdbIL9qSvY5ZyAP1URWGGF9G+jcj4EfCcICW+
 8fFEtPb0mYVj5Hs7ZDHOHUuhgwtxHyqx5M3y6d8mhniS89TLk6v40c/chNgZjXms
 KcNZ2sK3TR1Sw92rg0b/3rqH8xs66iVr8Bjh5XX/NEqEajTv/xCVyCdQEKeMxHY1
 AnYXdlAmsG8/rEZTGba6p3P5ZVJipGedxhjdKYL/rSjvUNDvXqaZ3WeHiUjhcNuk
 2R5SGg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkp8dys-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-535131e4c25so35275461cf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215593; x=1793820393; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pf7VP172a86le6KatWWx9AzTG3KlPIH9Jp+pw3ouWn8=;
 b=YjNHPnM7G9rsg9eBW6rvj7QmM1Hwky1sbPvy7ywzinPWUg9fi78qXdnxaEekZ5qxPf
 68gaeKl+y7WaqtJ0/K4J8bwgUR1hrSbXzXN3MNKNEZ7NlKS3ZRa7zzDcL3K1TfjD8Njz
 dnhf+xYJpG/c68gZ3/sHwFX/LTvvkOP2T5lq+zVkJx8myon9suga2tjY8Hjw4kTJvUia
 DVLi7bY8ChPCOus/Nn6K9lypR+bEy5PJ7SqpvYyP7sYrICamzfmOq4DiikluoMP6HnMq
 ZMe7GvEsH7bUFitz1Kz3/gGKJEQYqxV3psykTqoCzBLnkOoo9Dfrpqt2Sm2YsoruMVmA
 b3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215593; x=1793820393;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pf7VP172a86le6KatWWx9AzTG3KlPIH9Jp+pw3ouWn8=;
 b=qIu3T9jsaTfXsDjvX/yH46VZju18AdeMAocvQreQW0ZHQW1EFWIMXjLxDfLrGSbASu
 ZGhcUsC3lU9tgr3iU3BjshKVQnfIHrlpo5nkcFullCV0tqTn9MnQN+Sx7FVpWdiwekqQ
 3G4WbpUmGjL0MkwvVLLBTHgorl52Gf7llyl11Db/C9tGOAEGt/IewnJSrfk+2WA9iIdc
 XTnss6F8D7KV3w4QGvJ5l8cMLb3MNI6U7dW8c2r6knzVK8ajCY+XnMIvZTyMv7HPxCY3
 3W5Xs6zesiMG6A7/Yjx0UBYvyvhG0maBhI/ZsP2CNwYmAZCAMVkrrESxwmFpvuDxGbSC
 +fiA==
X-Gm-Message-State: AFq9FYJ1uXUSn3lDw/4QfoD+3be4u0NfscfrHKnOBmtY2JNwfyqVJQnK
 AWnkkZU73yHdtUFRljSiROVLtH2NiCaHnE1qbYS81ULrcMSUoqS6BOsTVZV5IxtyU9N5n2ssXn1
 9G1FBr0CFAtqk9yDp4bGAFFx3bWu6lAWaN8on4YAoW6ndJwaVTbG3Y0njWnz0MOaRn03d
X-Gm-Gg: AYBFou3wwHyweNAt7rA+HLXu6hjYVMY+GuF/oiywJjdDEjN1EiDTu2qQo2UXXbvlyOu
 onckwdYCVq1m/XHMb5GysDcgvTPv8ViWVuwUvracFaCvnXl1VwAWvIch3kqimZJUf40HQgf7p3i
 uS6dUewvcPs7xFyYtOeSSuK/Mgb6Q33OefHbeGhC1TQW6rJlpWqP68WqGO+XR68/DqHT1iW1tis
 9TB/0DvEH22ICWPHjtzGUvaSSDyZvITbtaKjsqUBbmkHTy253jVQJd0MQmF5JMY1+8VWVvjPjXl
 6XJ7i/nVA/cqZYUmzqRvgxYKYN2XSg2dbQXo4Fi6A9lJj+y1RhEZ83BEQuJAZjrC1z5BtgX7ltr
 jxwATQSkc/qaPQBGMykEToVW9A9iIx1dA/ZRvew33yVjQq1J7m1+Wa79UNq4Cg4Cd5720U7gh4d
 SxfqWhejkXObnqcx//FzLoeuKicqP+Wg==
X-Received: by 2002:a05:620a:3715:b0:939:31b5:4e08 with SMTP id
 af79cd13be357-944087ff6eemr520857685a.0.1793215592913; 
 Wed, 28 Oct 2026 12:26:32 -0700 (PDT)
X-Received: by 2002:a05:620a:3715:b0:939:31b5:4e08 with SMTP id
 af79cd13be357-944087ff6eemr520853385a.0.1793215592276; 
 Wed, 28 Oct 2026 12:26:32 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm38198951f8f.49.2026.10.28.12.26.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:26:31 -0700 (PDT)
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
Subject: [PATCH v2 7/9] target/mips: Describe gdbstub registers with XML
 features
Date: Wed, 28 Oct 2026 20:25:35 +0100
Message-ID: <20261028192538.31600-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028192538.31600-1-philmd@oss.qualcomm.com>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae24c69 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=WmjIyukEGkL0WYVkHRwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: BVweH9vc3pqCK-cayXQIj2wKrah5lowL
X-Proofpoint-GUID: BVweH9vc3pqCK-cayXQIj2wKrah5lowL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX0DST9GHRpWdW
 EADKX2xZVWlEMMEUNI6mxm25Th1YuFRsB7eLEx7UBdngda0uz78+zMhyvPQdS8B4eNsAB8gJbrJ
 gnf0Yo5dYUbO8SnXe3MwvH4HP886KCo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfXzCf1bK7S5jED
 //uC6V/vbzjO7evyicUSFkozqoq2RuHm/vmeVNM98WlMNsovGzZ23PQYq9JV6TjA4WTeUtvTNL0
 lxlcT8+cxz1sjGyC1vwUtdRyKLzsVMwRqPbsrq1lxFDvkPZsF8tcLOVfFc/yncaPUF8qNpp58+o
 aF2Jfm0Kh6YMpE1+tx7uHxYjn3zjGlIEeSI2LCGE9o/PG3uxKI9Ev+0aBGplgMd3LGtnZYwRhXn
 ZKAEtJwLvj1Tki8xTrrEtykC0vhsR8Wp1B5SdvMVfFj6sgfNUagBB+NARpzyY2Yue57Vyde25jX
 eYUzc6AE8GaiXR0DA6AWZqzCACB7D74ahBmm4/uZWRC3c+61i3xbINylc3Z5tPLjO16wMf/ZGXk
 mlSiKGLLP7WwHjB/nvNwG5N+1MK8K0fC2dU6OHx5Poe7Ft1K/2me9K64nFS9TgiYeoKQcTRHMRY
 C8/bRAtfBcJOGh2qJNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MIPS has no XML target description, so extra features can not
be registered. Expose the cpu, cp0 and fpu registers as the GDB
standard features, mapped to the legacy register numbers.

Registers are sized by the target long size (mips32-*.xml or
mips64-*.xml) instead of the CPU: a 32-bit CPU on a 64-bit target
now reports 64-bit registers. FPU registers are single-precision
on 32-bit targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS                              |  1 +
 configs/targets/mips-linux-user.mak      |  1 +
 configs/targets/mips-softmmu.mak         |  1 +
 configs/targets/mips64-linux-user.mak    |  1 +
 configs/targets/mips64-softmmu.mak       |  1 +
 configs/targets/mips64el-linux-user.mak  |  1 +
 configs/targets/mips64el-softmmu.mak     |  1 +
 configs/targets/mipsel-linux-user.mak    |  1 +
 configs/targets/mipsel-softmmu.mak       |  1 +
 configs/targets/mipsn32-linux-user.mak   |  1 +
 configs/targets/mipsn32el-linux-user.mak |  1 +
 target/mips/internal.h                   |  2 +
 target/mips/cpu.c                        |  4 ++
 target/mips/gdbstub.c                    | 86 ++++++++++++++++++++++++
 gdbstub/gdb-xml/mips32-cp0.xml           |  9 +++
 gdbstub/gdb-xml/mips32-cpu.xml           | 42 ++++++++++++
 gdbstub/gdb-xml/mips32-fpu.xml           | 41 +++++++++++
 gdbstub/gdb-xml/mips64-cp0.xml           |  9 +++
 gdbstub/gdb-xml/mips64-cpu.xml           | 42 ++++++++++++
 gdbstub/gdb-xml/mips64-fpu.xml           | 41 +++++++++++
 20 files changed, 287 insertions(+)
 create mode 100644 gdbstub/gdb-xml/mips32-cp0.xml
 create mode 100644 gdbstub/gdb-xml/mips32-cpu.xml
 create mode 100644 gdbstub/gdb-xml/mips32-fpu.xml
 create mode 100644 gdbstub/gdb-xml/mips64-cp0.xml
 create mode 100644 gdbstub/gdb-xml/mips64-cpu.xml
 create mode 100644 gdbstub/gdb-xml/mips64-fpu.xml

diff --git a/MAINTAINERS b/MAINTAINERS
index b36582c9d0b1..4269299b8ca3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -139,6 +139,7 @@ S: Odd Fixes
 K: ^Subject:.*(?i)mips
 F: docs/system/target-mips.rst
 F: configs/targets/mips*
+F: gdbstub/gdb-xml/mips*.xml
 F: tests/functional/mips*/meson.build
 
 X86 general architecture support
diff --git a/configs/targets/mips-linux-user.mak b/configs/targets/mips-linux-user.mak
index 69bdc459b69a..0ee6a2722822 100644
--- a/configs/targets/mips-linux-user.mak
+++ b/configs/targets/mips-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL_ABI=o32
 TARGET_SYSTBL=syscall_o32.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_XML_FILES= mips32-cpu.xml mips32-cp0.xml mips32-fpu.xml
diff --git a/configs/targets/mips-softmmu.mak b/configs/targets/mips-softmmu.mak
index 95397af9442e..156310f94069 100644
--- a/configs/targets/mips-softmmu.mak
+++ b/configs/targets/mips-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=mips
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_XML_FILES= mips32-cpu.xml mips32-cp0.xml mips32-fpu.xml
diff --git a/configs/targets/mips64-linux-user.mak b/configs/targets/mips64-linux-user.mak
index 04e82b3ab11d..52c3ae8dff32 100644
--- a/configs/targets/mips64-linux-user.mak
+++ b/configs/targets/mips64-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_SYSTBL_ABI=n64
 TARGET_SYSTBL=syscall_n64.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
+TARGET_XML_FILES= mips64-cpu.xml mips64-cp0.xml mips64-fpu.xml
diff --git a/configs/targets/mips64-softmmu.mak b/configs/targets/mips64-softmmu.mak
index f9cc41b9ed43..03db5ef74abc 100644
--- a/configs/targets/mips64-softmmu.mak
+++ b/configs/targets/mips64-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BASE_ARCH=mips
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_XML_FILES= mips64-cpu.xml mips64-cp0.xml mips64-fpu.xml
diff --git a/configs/targets/mips64el-linux-user.mak b/configs/targets/mips64el-linux-user.mak
index 27f416942654..0600e05a877b 100644
--- a/configs/targets/mips64el-linux-user.mak
+++ b/configs/targets/mips64el-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_BASE_ARCH=mips
 TARGET_SYSTBL_ABI=n64
 TARGET_SYSTBL=syscall_n64.tbl
 TARGET_LONG_BITS=64
+TARGET_XML_FILES= mips64-cpu.xml mips64-cp0.xml mips64-fpu.xml
diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/mips64el-softmmu.mak
index 4e7dedc5f30d..b3433d8cf7ab 100644
--- a/configs/targets/mips64el-softmmu.mak
+++ b/configs/targets/mips64el-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_XML_FILES= mips64-cpu.xml mips64-cp0.xml mips64-fpu.xml
diff --git a/configs/targets/mipsel-linux-user.mak b/configs/targets/mipsel-linux-user.mak
index 8b7e86ab2880..7fd2e2e6f791 100644
--- a/configs/targets/mipsel-linux-user.mak
+++ b/configs/targets/mipsel-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_ABI_MIPSO32=y
 TARGET_SYSTBL_ABI=o32
 TARGET_SYSTBL=syscall_o32.tbl
 TARGET_LONG_BITS=32
+TARGET_XML_FILES= mips32-cpu.xml mips32-cp0.xml mips32-fpu.xml
diff --git a/configs/targets/mipsel-softmmu.mak b/configs/targets/mipsel-softmmu.mak
index b0fba8a9d0ad..c36b65918026 100644
--- a/configs/targets/mipsel-softmmu.mak
+++ b/configs/targets/mipsel-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=mips
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_XML_FILES= mips32-cpu.xml mips32-cp0.xml mips32-fpu.xml
diff --git a/configs/targets/mipsn32-linux-user.mak b/configs/targets/mipsn32-linux-user.mak
index 39ae214633f1..ec1af1d969ed 100644
--- a/configs/targets/mipsn32-linux-user.mak
+++ b/configs/targets/mipsn32-linux-user.mak
@@ -6,3 +6,4 @@ TARGET_SYSTBL_ABI=n32
 TARGET_SYSTBL=syscall_n32.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
+TARGET_XML_FILES= mips64-cpu.xml mips64-cp0.xml mips64-fpu.xml
diff --git a/configs/targets/mipsn32el-linux-user.mak b/configs/targets/mipsn32el-linux-user.mak
index d9b61d699025..3c74de867e45 100644
--- a/configs/targets/mipsn32el-linux-user.mak
+++ b/configs/targets/mipsn32el-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_BASE_ARCH=mips
 TARGET_SYSTBL_ABI=n32
 TARGET_SYSTBL=syscall_n32.tbl
 TARGET_LONG_BITS=64
+TARGET_XML_FILES= mips64-cpu.xml mips64-cp0.xml mips64-fpu.xml
diff --git a/target/mips/internal.h b/target/mips/internal.h
index d4a4fdad9128..1ca41b1e5284 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -93,6 +93,8 @@ extern const int mips_defs_number;
 
 int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+void mips_cpu_gdb_class_init_xml(CPUClass *cc);
+void mips_cpu_register_gdb_regs(CPUState *cs);
 QTree *mips_octeon_llm_tree_new(void);
 uint64_t mips_octeon_llm_load(QTree *tree, uint64_t addr);
 void mips_octeon_llm_store(QTree **treep, uint64_t addr, uint64_t value);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 8ad5e49ade41..443b6d62b86f 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -604,6 +604,8 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    mips_cpu_register_gdb_regs(cs);
+
     env->exception_base = (int32_t)0xBFC00000;
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
@@ -777,6 +779,8 @@ static void mips_cpu_cpudef_class_init(ObjectClass *oc, const void *data)
 {
     MIPSCPUClass *mcc = MIPS_CPU_CLASS(oc);
     mcc->cpu_def = data;
+
+    mips_cpu_gdb_class_init_xml(CPU_CLASS(oc));
 }
 
 static void mips_register_cpudef_type(const struct mips_def_t *def)
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 54649bfffc8d..e21eb6f67fbd 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -21,6 +21,7 @@
 #include "qemu/bitops.h"
 #include "cpu.h"
 #include "internal.h"
+#include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
 #include "fpu_helper.h"
 
@@ -177,3 +178,88 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 
     return regsz;
 }
+
+static int mips_gdb_cpu_legacy_regnum(int n)
+{
+    switch (n) {
+    case 32:
+        return 33; /* lo */
+    case 33:
+        return 34; /* hi */
+    case 34:
+        return 37; /* pc */
+    default:
+        return n;
+    }
+}
+
+/* org.gnu.gdb.mips.cp0: status, badvaddr, cause */
+static const int mips_gdb_cp0_legacy_regnum[] = { 32, 35, 36 };
+
+/* org.gnu.gdb.mips.fpu: f0..f31, fcsr, fir */
+#define MIPS_GDB_FPU_LEGACY_BASE  38
+
+static int mips_gdb_read_legacy(CPUState *cs, GByteArray *buf, int n)
+{
+    uint64_t val;
+
+    if (!mips_gdb_read_value(cpu_env(cs), n, &val)) {
+        return 0;
+    }
+    return target_long_bits() == 64 ? gdb_get_reg64(buf, val)
+                                    : gdb_get_reg32(buf, val);
+}
+
+static int mips_gdb_read_cpu(CPUState *cs, GByteArray *buf, int n)
+{
+    return mips_gdb_read_legacy(cs, buf, mips_gdb_cpu_legacy_regnum(n));
+}
+
+static int mips_gdb_write_cpu(CPUState *cs, uint8_t *buf, int n)
+{
+    return mips_cpu_gdb_write_register(cs, buf,
+                                       mips_gdb_cpu_legacy_regnum(n));
+}
+
+static int mips_gdb_read_cp0(CPUState *cs, GByteArray *buf, int n)
+{
+    return mips_gdb_read_legacy(cs, buf, mips_gdb_cp0_legacy_regnum[n]);
+}
+
+static int mips_gdb_write_cp0(CPUState *cs, uint8_t *buf, int n)
+{
+    return mips_cpu_gdb_write_register(cs, buf,
+                                       mips_gdb_cp0_legacy_regnum[n]);
+}
+
+static int mips_gdb_read_fpu(CPUState *cs, GByteArray *buf, int n)
+{
+    return mips_gdb_read_legacy(cs, buf, MIPS_GDB_FPU_LEGACY_BASE + n);
+}
+
+static int mips_gdb_write_fpu(CPUState *cs, uint8_t *buf, int n)
+{
+    return mips_cpu_gdb_write_register(cs, buf,
+                                       MIPS_GDB_FPU_LEGACY_BASE + n);
+}
+
+void mips_cpu_gdb_class_init_xml(CPUClass *cc)
+{
+    cc->gdb_core_xml_file = target_long_bits() == 64 ? "mips64-cpu.xml"
+                                                     : "mips32-cpu.xml";
+    cc->gdb_num_core_regs = 0;
+    cc->gdb_read_register = mips_gdb_read_cpu;
+    cc->gdb_write_register = mips_gdb_write_cpu;
+}
+
+void mips_cpu_register_gdb_regs(CPUState *cs)
+{
+    const bool is_64bit = target_long_bits() == 64;
+    const char *cp0_xml = is_64bit ? "mips64-cp0.xml" : "mips32-cp0.xml";
+    const char *fpu_xml = is_64bit ? "mips64-fpu.xml" : "mips32-fpu.xml";
+
+    gdb_register_coprocessor(cs, mips_gdb_read_cp0, mips_gdb_write_cp0,
+                             gdb_find_static_feature(cp0_xml));
+    gdb_register_coprocessor(cs, mips_gdb_read_fpu, mips_gdb_write_fpu,
+                             gdb_find_static_feature(fpu_xml));
+}
diff --git a/gdbstub/gdb-xml/mips32-cp0.xml b/gdbstub/gdb-xml/mips32-cp0.xml
new file mode 100644
index 000000000000..eb15f00eee31
--- /dev/null
+++ b/gdbstub/gdb-xml/mips32-cp0.xml
@@ -0,0 +1,9 @@
+<?xml version="1.0"?>
+<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.mips.cp0">
+  <reg name="status" bitsize="32"/>
+  <reg name="badvaddr" bitsize="32"/>
+  <reg name="cause" bitsize="32"/>
+</feature>
diff --git a/gdbstub/gdb-xml/mips32-cpu.xml b/gdbstub/gdb-xml/mips32-cpu.xml
new file mode 100644
index 000000000000..8aa23d314c48
--- /dev/null
+++ b/gdbstub/gdb-xml/mips32-cpu.xml
@@ -0,0 +1,42 @@
+<?xml version="1.0"?>
+<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.mips.cpu">
+  <reg name="r0" bitsize="32"/>
+  <reg name="r1" bitsize="32"/>
+  <reg name="r2" bitsize="32"/>
+  <reg name="r3" bitsize="32"/>
+  <reg name="r4" bitsize="32"/>
+  <reg name="r5" bitsize="32"/>
+  <reg name="r6" bitsize="32"/>
+  <reg name="r7" bitsize="32"/>
+  <reg name="r8" bitsize="32"/>
+  <reg name="r9" bitsize="32"/>
+  <reg name="r10" bitsize="32"/>
+  <reg name="r11" bitsize="32"/>
+  <reg name="r12" bitsize="32"/>
+  <reg name="r13" bitsize="32"/>
+  <reg name="r14" bitsize="32"/>
+  <reg name="r15" bitsize="32"/>
+  <reg name="r16" bitsize="32"/>
+  <reg name="r17" bitsize="32"/>
+  <reg name="r18" bitsize="32"/>
+  <reg name="r19" bitsize="32"/>
+  <reg name="r20" bitsize="32"/>
+  <reg name="r21" bitsize="32"/>
+  <reg name="r22" bitsize="32"/>
+  <reg name="r23" bitsize="32"/>
+  <reg name="r24" bitsize="32"/>
+  <reg name="r25" bitsize="32"/>
+  <reg name="r26" bitsize="32"/>
+  <reg name="r27" bitsize="32"/>
+  <reg name="r28" bitsize="32"/>
+  <reg name="r29" bitsize="32"/>
+  <reg name="r30" bitsize="32"/>
+  <reg name="r31" bitsize="32"/>
+
+  <reg name="lo" bitsize="32"/>
+  <reg name="hi" bitsize="32"/>
+  <reg name="pc" bitsize="32"/>
+</feature>
diff --git a/gdbstub/gdb-xml/mips32-fpu.xml b/gdbstub/gdb-xml/mips32-fpu.xml
new file mode 100644
index 000000000000..4e73b88dacc2
--- /dev/null
+++ b/gdbstub/gdb-xml/mips32-fpu.xml
@@ -0,0 +1,41 @@
+<?xml version="1.0"?>
+<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.mips.fpu">
+  <reg name="f0" bitsize="32" type="ieee_single"/>
+  <reg name="f1" bitsize="32" type="ieee_single"/>
+  <reg name="f2" bitsize="32" type="ieee_single"/>
+  <reg name="f3" bitsize="32" type="ieee_single"/>
+  <reg name="f4" bitsize="32" type="ieee_single"/>
+  <reg name="f5" bitsize="32" type="ieee_single"/>
+  <reg name="f6" bitsize="32" type="ieee_single"/>
+  <reg name="f7" bitsize="32" type="ieee_single"/>
+  <reg name="f8" bitsize="32" type="ieee_single"/>
+  <reg name="f9" bitsize="32" type="ieee_single"/>
+  <reg name="f10" bitsize="32" type="ieee_single"/>
+  <reg name="f11" bitsize="32" type="ieee_single"/>
+  <reg name="f12" bitsize="32" type="ieee_single"/>
+  <reg name="f13" bitsize="32" type="ieee_single"/>
+  <reg name="f14" bitsize="32" type="ieee_single"/>
+  <reg name="f15" bitsize="32" type="ieee_single"/>
+  <reg name="f16" bitsize="32" type="ieee_single"/>
+  <reg name="f17" bitsize="32" type="ieee_single"/>
+  <reg name="f18" bitsize="32" type="ieee_single"/>
+  <reg name="f19" bitsize="32" type="ieee_single"/>
+  <reg name="f20" bitsize="32" type="ieee_single"/>
+  <reg name="f21" bitsize="32" type="ieee_single"/>
+  <reg name="f22" bitsize="32" type="ieee_single"/>
+  <reg name="f23" bitsize="32" type="ieee_single"/>
+  <reg name="f24" bitsize="32" type="ieee_single"/>
+  <reg name="f25" bitsize="32" type="ieee_single"/>
+  <reg name="f26" bitsize="32" type="ieee_single"/>
+  <reg name="f27" bitsize="32" type="ieee_single"/>
+  <reg name="f28" bitsize="32" type="ieee_single"/>
+  <reg name="f29" bitsize="32" type="ieee_single"/>
+  <reg name="f30" bitsize="32" type="ieee_single"/>
+  <reg name="f31" bitsize="32" type="ieee_single"/>
+
+  <reg name="fcsr" bitsize="32" group="float"/>
+  <reg name="fir" bitsize="32" group="float"/>
+</feature>
diff --git a/gdbstub/gdb-xml/mips64-cp0.xml b/gdbstub/gdb-xml/mips64-cp0.xml
new file mode 100644
index 000000000000..a48c894e8362
--- /dev/null
+++ b/gdbstub/gdb-xml/mips64-cp0.xml
@@ -0,0 +1,9 @@
+<?xml version="1.0"?>
+<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.mips.cp0">
+  <reg name="status" bitsize="64"/>
+  <reg name="badvaddr" bitsize="64"/>
+  <reg name="cause" bitsize="64"/>
+</feature>
diff --git a/gdbstub/gdb-xml/mips64-cpu.xml b/gdbstub/gdb-xml/mips64-cpu.xml
new file mode 100644
index 000000000000..deaa3ee7be63
--- /dev/null
+++ b/gdbstub/gdb-xml/mips64-cpu.xml
@@ -0,0 +1,42 @@
+<?xml version="1.0"?>
+<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.mips.cpu">
+  <reg name="r0" bitsize="64"/>
+  <reg name="r1" bitsize="64"/>
+  <reg name="r2" bitsize="64"/>
+  <reg name="r3" bitsize="64"/>
+  <reg name="r4" bitsize="64"/>
+  <reg name="r5" bitsize="64"/>
+  <reg name="r6" bitsize="64"/>
+  <reg name="r7" bitsize="64"/>
+  <reg name="r8" bitsize="64"/>
+  <reg name="r9" bitsize="64"/>
+  <reg name="r10" bitsize="64"/>
+  <reg name="r11" bitsize="64"/>
+  <reg name="r12" bitsize="64"/>
+  <reg name="r13" bitsize="64"/>
+  <reg name="r14" bitsize="64"/>
+  <reg name="r15" bitsize="64"/>
+  <reg name="r16" bitsize="64"/>
+  <reg name="r17" bitsize="64"/>
+  <reg name="r18" bitsize="64"/>
+  <reg name="r19" bitsize="64"/>
+  <reg name="r20" bitsize="64"/>
+  <reg name="r21" bitsize="64"/>
+  <reg name="r22" bitsize="64"/>
+  <reg name="r23" bitsize="64"/>
+  <reg name="r24" bitsize="64"/>
+  <reg name="r25" bitsize="64"/>
+  <reg name="r26" bitsize="64"/>
+  <reg name="r27" bitsize="64"/>
+  <reg name="r28" bitsize="64"/>
+  <reg name="r29" bitsize="64"/>
+  <reg name="r30" bitsize="64"/>
+  <reg name="r31" bitsize="64"/>
+
+  <reg name="lo" bitsize="64"/>
+  <reg name="hi" bitsize="64"/>
+  <reg name="pc" bitsize="64"/>
+</feature>
diff --git a/gdbstub/gdb-xml/mips64-fpu.xml b/gdbstub/gdb-xml/mips64-fpu.xml
new file mode 100644
index 000000000000..06cad1898e01
--- /dev/null
+++ b/gdbstub/gdb-xml/mips64-fpu.xml
@@ -0,0 +1,41 @@
+<?xml version="1.0"?>
+<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.mips.fpu">
+  <reg name="f0" bitsize="64" type="ieee_double"/>
+  <reg name="f1" bitsize="64" type="ieee_double"/>
+  <reg name="f2" bitsize="64" type="ieee_double"/>
+  <reg name="f3" bitsize="64" type="ieee_double"/>
+  <reg name="f4" bitsize="64" type="ieee_double"/>
+  <reg name="f5" bitsize="64" type="ieee_double"/>
+  <reg name="f6" bitsize="64" type="ieee_double"/>
+  <reg name="f7" bitsize="64" type="ieee_double"/>
+  <reg name="f8" bitsize="64" type="ieee_double"/>
+  <reg name="f9" bitsize="64" type="ieee_double"/>
+  <reg name="f10" bitsize="64" type="ieee_double"/>
+  <reg name="f11" bitsize="64" type="ieee_double"/>
+  <reg name="f12" bitsize="64" type="ieee_double"/>
+  <reg name="f13" bitsize="64" type="ieee_double"/>
+  <reg name="f14" bitsize="64" type="ieee_double"/>
+  <reg name="f15" bitsize="64" type="ieee_double"/>
+  <reg name="f16" bitsize="64" type="ieee_double"/>
+  <reg name="f17" bitsize="64" type="ieee_double"/>
+  <reg name="f18" bitsize="64" type="ieee_double"/>
+  <reg name="f19" bitsize="64" type="ieee_double"/>
+  <reg name="f20" bitsize="64" type="ieee_double"/>
+  <reg name="f21" bitsize="64" type="ieee_double"/>
+  <reg name="f22" bitsize="64" type="ieee_double"/>
+  <reg name="f23" bitsize="64" type="ieee_double"/>
+  <reg name="f24" bitsize="64" type="ieee_double"/>
+  <reg name="f25" bitsize="64" type="ieee_double"/>
+  <reg name="f26" bitsize="64" type="ieee_double"/>
+  <reg name="f27" bitsize="64" type="ieee_double"/>
+  <reg name="f28" bitsize="64" type="ieee_double"/>
+  <reg name="f29" bitsize="64" type="ieee_double"/>
+  <reg name="f30" bitsize="64" type="ieee_double"/>
+  <reg name="f31" bitsize="64" type="ieee_double"/>
+
+  <reg name="fcsr" bitsize="64" group="float"/>
+  <reg name="fir" bitsize="64" group="float"/>
+</feature>
-- 
2.55.0


