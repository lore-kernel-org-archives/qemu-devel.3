Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F412CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKn-0001BT-A2; Tue, 29 Sep 2026 17:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKi-0000z0-Ae
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKg-0003u9-9i
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TL51u0942133
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ko8tSpR4UjE
 FxIZ2I16OKCfyRxp/VIQAYnmg+HKf8fo=; b=HVGahE85gDIkvmFJy6Gvc0Lk4qc
 0ZH3y/zVQPy/r1yrUIHogYEn9i2++WlQu0yp5Cl3jegOo4mCaPvK3b5SkV9qtJ2t
 Y3NYOV8M74CcZxiKdzP3CGgNa8h9aG1OepSNLDBfFSYvxgcS/uqk5wejlmG8CCMZ
 hpmpRw4LR1h+VjAqIQnlQecKApAmbxgoKdRTt8NVgVR9C5JSEyqPqLtWXmCAhCyG
 nW5NPhISRbeB3tZiMa1KuIsACE1mmU9gCYEXN+T1YBetNddY3ZzoUWs5TUzv5xwe
 Re2KWX8ri4wi9L9VV7vjdpDMIsmjiU9z7vPTipG7TyCObTmCXJxLQ8NnrHA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0ftuhjuy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34318e88ba2so3590563eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717138; x=1791321938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ko8tSpR4UjEFxIZ2I16OKCfyRxp/VIQAYnmg+HKf8fo=;
 b=N89XdD43bW4YbmU9CJqaskKMbeHu8/hXbPjoHtkCq+jtsFU37xNbIXrqyPMeJ6ct1K
 LFQozMzSBfa0XIYuTyYRiLsken8g3kreme2rxg8QKjhv0jk8ONC5pnTeKFULuOBefbot
 o9U8UzVt5XAiHV1IdUF74E/R788cESWLJ7/S5HG3w5iiHVE9O7Rl2Kzp7l29V1yevuZ0
 NzhawlhdrWiPfaf/J1vANFDGq6DeETqMWbn5aWBjRtpOnkmY4OJ6tciIl2CNlGpd8K71
 6NL9xyfh58eiUEk98mU1OHlZdlsb+2wtngDY6SB6krsXpQfc3GjjfYyuEBR68DkL1t2a
 WyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717138; x=1791321938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ko8tSpR4UjEFxIZ2I16OKCfyRxp/VIQAYnmg+HKf8fo=;
 b=TCso919j8wQx5oZamu8+HB4C7dQCYKouN5Tibjkh1fPdkvTotkzGrimt+WXsYxJw9n
 EQjR+T3zD1NboeLqL7O13XUuLpUHcbNALPRswrX95FaWgkklEnDiEuxOw5lt3yQMUYpE
 2JbqANvhaNjVOWfz+n4LEF4L3Idc/r/P04LMekNj/cxWa27HLMbYAzKf/MBWrpUXs8TS
 OW9Tzf8x68NzYQBb2sXs3esrOXEdcVT2/HHdWYSJxDBAhLaLSomVSHwIGufItABbOt40
 lcwg/ShJc5XfGco9PM7K4fm89wA+GVZbH/ua9oPzxfISotRPY1Mbl3P31Y6XAsH6tqRp
 uouQ==
X-Gm-Message-State: AFq9FYIN7mrsWqE9ATVtxV34ySV/3d6bm37Q+W3HwGTPAZmMFka2psfs
 HwLhzY1DOTyHR4RwZpeYEH0Bv80v/CbjqFvRKvgkbIsECREwYYpMeZytOnP6JHKk7FTGEuLiahf
 f3Qo8rOICbn41HoON5LVqPdYNHCbK/YAfacLa3GvIYN3cSE+JkOtZkpgb3urHqyXGpA==
X-Gm-Gg: AYBFou2PHaPcuaCRdHYLsmhPDb9jn34PKY44k+FJiCoj/hZimz/q5Kpa1PWxYhB/TA+
 DgM7m9B38emScKFjh/Zo7xeNXf8HquYcLjFszsitrhPHwkryoaHk1enIFxZ7egH8TFzzKiBqQ8N
 4sjNkK1YZDoQ09oesBx449wt4rosVyvOg/GSLVyOPLBfMsKdLz7KJgn0YkEnOYP77IzBICbbG8/
 K+7hY5toPKauSY8PpCNddcUSNei7JcMaYBsBrDP9Asiki2WbJZmdGMZVXf9bCDDQ4f5kth/PXUm
 P7pIGEEnr/DSqwlgE4Oq6/aV7vFbVN3CC/hcXi+Sam9TNUnD06IszXPmwRNmcEDbse7gZ2r5i8P
 j5TzQLmF4gn7RJCjqv54osmCb4YuV2Zs1pd/pk/FCeCKCo7xO7iAq/kw8QWlP
X-Received: by 2002:a05:7301:fc0b:b0:334:2bbe:ad6b with SMTP id
 5a478bee46e88-34c6672df1fmr626133eec.22.1790717137362; 
 Tue, 29 Sep 2026 14:25:37 -0700 (PDT)
X-Received: by 2002:a05:7301:fc0b:b0:334:2bbe:ad6b with SMTP id
 5a478bee46e88-34c6672df1fmr626106eec.22.1790717136719; 
 Tue, 29 Sep 2026 14:25:36 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 22/24] tests/docker/debian-all-test: add mips32r5 toolchain
Date: Tue, 29 Sep 2026 21:24:37 +0000
Message-ID: <20260929212439.110454-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfXy+x7B8/BLis0
 DsJVMq8+3pC3mx9RPvdeWvHN1PhoZyE0K3jc9UNOeXR+TrWCvIzioxCYaTvpHX3ybcSy3XaYkqn
 xrqbjCXExP2PTHsiv6uh7b7HrBjBbZDEwDxS9nAD3SvQ4iokUAo3X09AJkQXd6HHezo1NwS4mdJ
 hwOvwNja8bPGZWrNcEF/5WvO8t+55VisV7S2GDPyfR+QDUoAgf1sRvMX3wGALaVaSLhTO2KmYVM
 FCA1mvsBLFEWHVkdQYDiqXurOt8gjUlmhAwE/tNFt1AVVy4mdVJ1OAYMQ0lz9nuEIQPFWvzH56R
 zEYBy6TY7lL7Ap/ohO8ZH8KHzMWRfE0NrkboB6wCL3dKerb+/jbvduXmAaZm+KP41ae0u2IGAIz
 2+RWRqkkdaXCoWM5vOm7Shrl7YKYaMf4HpKwblIoFBg6K2BnkYiDyW0Kxp6Lk/Th0Zsagi1/Swd
 68Q3fHpJarJXSASlsrw==
X-Authority-Analysis: v=2.4 cv=AoB7T+9P c=1 sm=1 tr=0 ts=6abc2cd2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=gPJu0pBYAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=LKAvCFhEUFdIRXT5rOkA:9
 a=PxkB5W3o20Ba91AHUih5:22 a=AlIIF0cMT2hfDT4axODj:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfXz7lEQVSr3zR7
 DO0Y+pPSEe6aPqNkYCD03pDSMgw69NFGk+ZAHUmf26Gv5Ulk8Czp+E6+WSAFsBwtZ5LPHfgQPWi
 fDii4ifTEwnZTrfFntnEbYUBlziLA2k=
X-Proofpoint-GUID: CwZySZkuibHjdJvmkaz3P5DQDU8_309Y
X-Proofpoint-ORIG-GUID: CwZySZkuibHjdJvmkaz3P5DQDU8_309Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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

For our test, we need a compiler and libc that supports -mnan=2008.
Debian compilers support this option, but no libc is available for it.

One possibility is to use previous version (2019 or 2020) of official
MIPS toolchain from https://codescape.mips.com/. However, it's a huge
download (2G), and even bigger on disk (8GB).

Bootlin provides toolchains
(https://toolchains.bootlin.com/toolchains.html) for mips64r5el only,
which is small (80MB dl, and 500MB on disk). Since all mipsel* variant
binaries have the same name, we explicitly rename them to
mips64r5el-linux-gnu-*. Also, this toolchain is maintained, used, and
updated frequently, so it's an excellent choice for us.

mips32r5el is more widely used compared to mips32r5, so we can ignore
the latter.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .../dockerfiles/debian-all-test-cross.docker     | 16 ++++++++++++++++
 tests/lcitool/refresh                            | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 94524480880..eefc03c49a4 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -113,6 +113,22 @@ RUN apt update && \
   libc6-dev-sparc64-cross \
   && \
   dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
+
+RUN apt update && DEBIAN_FRONTEND=noninteractive eatmydata apt install -y rename
+
+# download mips32r5el toolchain from bootlin, and rename binaries who are simply
+# named mipsel-linux-gnu-*
+RUN apt update && \
+  mkdir -p /opt/mips32r5el/ && \
+  cd /opt/mips32r5el/ && \
+  wget -q https://toolchains.bootlin.com/downloads/releases/toolchains/mips32r5el/tarballs/mips32r5el--glibc--stable-2026.08-1.tar.xz && \
+  tar xvf *.tar.xz && \
+  rm *.tar.xz && \
+  mv mips32r5el--glibc--stable-2026.08-1/* . && \
+  cd bin && \
+  rename 's/mipsel/mips32r5el/' mipsel*
+ENV PATH="$PATH:/opt/mips32r5el/bin"
+
 ENV QEMU_CONFIGURE_OPTS=--disable-docs
 ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 662d8a79f3a..94cab24bbdb 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -224,6 +224,22 @@ RUN apt update && \
   libc6-dev-sparc64-cross \
   && \
   dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
+
+RUN apt update && DEBIAN_FRONTEND=noninteractive eatmydata apt install -y rename
+
+# download mips32r5el toolchain from bootlin, and rename binaries who are simply
+# named mipsel-linux-gnu-*
+RUN apt update && \
+  mkdir -p /opt/mips32r5el/ && \
+  cd /opt/mips32r5el/ && \
+  wget -q https://toolchains.bootlin.com/downloads/releases/toolchains/mips32r5el/tarballs/mips32r5el--glibc--stable-2026.08-1.tar.xz && \
+  tar xvf *.tar.xz && \
+  rm *.tar.xz && \
+  mv mips32r5el--glibc--stable-2026.08-1/* . && \
+  cd bin && \
+  rename 's/mipsel/mips32r5el/' mipsel*
+ENV PATH="$PATH:/opt/mips32r5el/bin"
+
 ENV QEMU_CONFIGURE_OPTS=--disable-docs
 ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 """
-- 
2.43.0


