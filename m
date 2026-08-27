Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C10C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVv-0004ZB-26; Thu, 27 Aug 2026 18:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVt-0004Pi-84
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVr-0000Fp-BD
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLclH1358479
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lTS2GE5Re7lVKW50PR5c27qyec0t3SaHaPOu+r2mSWA=; b=ZhfgROlPhIUv6usA
 RA6gN8H/Bf7QPtxe20KQRLcoegRCp9m9ylu5MP2gy9aPu8Qun8qL00ozd+mRv0k7
 5V2NxZiMWNuxPdeHwoTA5F9cKiKd9G+99LeUwnw9zobbYCswzvCrgpZR2x53mfvM
 qnbG5YRznZm7S2N9HJvCkw4bzENVFmdRceal9oTvZYhq4ol8xiB5yDaEFs7llbva
 ykdPFtm8HvpKrtqvKVtMQ8hSGTagyXQDtxPn6SAy+NdFkT3u0FH1gSlcOk2rYD2W
 K6TSx5Dp7S9eGujVpRJyvshp6OkvAuwqFPrKSkxS8QMcD1vv1TlNHvPH4TdXHw9m
 8Pz4mA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgvaapj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfca8558d2so4034905ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869426; x=1788474226; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lTS2GE5Re7lVKW50PR5c27qyec0t3SaHaPOu+r2mSWA=;
 b=cvpA8eQTcS8AgJGJPj3vnljusMPTcaO4T5w3shkCGypQWHNPH/6KLzfDpoJcTDKwwT
 ihskcidcEe0j0V9rclCG8vOZ1e6RjSzMQggN2qaBrDb5HSczTewDa2B+2nD/YWAGguLX
 5NfoUQCGLrbj5R0tnEVasqBXnk9wSMZV2JmQ8IY7xqTGwh9RcqpR8cvDxFd3OD/OIZiN
 Y6arRbqwa+mxUs3Z6Ei3rjtDKXlvqgtcxwPnNnUILTalZ5ts8RQl/4vUKE72f9e/kuyb
 R+FTHvgDhPSt7DIZ7yokDbvPknGB8TsZ8bCchYK9n8VtRIZCFy8DVLFsp9n+vG4dtCk7
 I8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869426; x=1788474226;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lTS2GE5Re7lVKW50PR5c27qyec0t3SaHaPOu+r2mSWA=;
 b=B9iLVPMVmQNMUc1GN0FZ1hwyUURHeumGs+DVMDPefT23kwJavxBvEkKXxhIlRz27fb
 KcQy8EGEC3YvBOiJ1TGcm7wb8WFotPJTScMzEi4zibo67vrW0A1s41HUzWDUqMfiwvnk
 IL5+HYI9yCGrRfYqmg1yHIEZ1DSAamjlSmnsufusJuwbZLE+5204W9Rmb3N00U/m/G9f
 4h2S5WC9/55K/NGvycGKtZVEoDillRcWdrT7GO9dSX3yNVtXzNJphNjENrzqVF8IM+4G
 y4uYuUvPLAnU8QsnGvnMU78N9ZhbhJxIacfhMnlIr6yvgDGe2ka3G86PRi7QMLnusNsa
 husw==
X-Gm-Message-State: AFuF++nBx/ArrCW8kfry3Ev0Qf++L6UlXb1i6GRXlDtcS22fEnQH6j0X
 5r87siAv2DldYcDSeAu9NID4mQyLM403Rb9WYVSWzjsVlmptzE3IQNXKeOlkZdYtCSLMhe7MA55
 K/vFnzVuiHowSxIZ6aPKOV8MsfM0BoThFHGymglxf6O5YuSxkzxuJGwqX1OXiNaHEiA==
X-Gm-Gg: AR+sD10M61oDGCuhVjn4SQLJFop4R/3sOIJOxw2KO+2hRNgDPgd9+73Y9qkTpVTV1Tj
 s3Xln9kRahETpS1aL6d/1bZfAULilBdJOrXu5zTqlad7jyfMPKRjey5629cs5MfqCblz2LcwRIZ
 iNDPv/c4O3u1tC/9Bom0xIUUZbRr6D1xGmVWOAWT9EuBsQiAMTRi67higNhJ7D9PX1unkITRdsZ
 gtBVLabvCSbTPiieVWsb52jfPRCbI7t5XvCuESI+I2OvIKkPTKbRiaoxOVFAx+F1DEfHCeqQ9t8
 E070Pv4iF/xTmLkTm4sIy9QjW0pITmCSQ2RgnuYmwIYcMKw61TkCn41bUAtDpALFOpg4ln5GXwd
 RluICS7Z9kCOeAEg12u8+9pirm1LZ1iM0tO3NEj3uf4DEr/31spiznV2tub8=
X-Received: by 2002:a17:903:388e:b0:2d7:44c5:1a13 with SMTP id
 d9443c01a7336-2d74df17b06mr40311255ad.8.1787869426446; 
 Thu, 27 Aug 2026 15:23:46 -0700 (PDT)
X-Received: by 2002:a17:903:388e:b0:2d7:44c5:1a13 with SMTP id
 d9443c01a7336-2d74df17b06mr40310685ad.8.1787869426027; 
 Thu, 27 Aug 2026 15:23:46 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 096/105] tests/tcg/xtensa: xtensaeb system tests
Date: Thu, 27 Aug 2026 22:14:57 +0000
Message-ID: <20260827221506.91574-97-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FWQFeFwAWFJQsPAOe95xCkNmXXvlqK3u
X-Proofpoint-GUID: FWQFeFwAWFJQsPAOe95xCkNmXXvlqK3u
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b8f3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=Y7GLNXJ1w4EJNdMAD_QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX6kTD5LxRrbxf
 NXFO1mFpFFjL/zYcJSJ42SjXB9qLcmm69kj3KY5h1zU9pHEsun0i0UnbDlRrObuVNiuvPhr9wHF
 LnZ5cSIFG4e75FSrEYbqQkq+p0YaqDLJjSGWX68WeLcs6qQP75yon9sKMLgokhhEPXGDPmsV2Zo
 mD96nozTCAUBX+PzZTOplo26Om/lWuDDCgoXUwo/uj1v1uP0lZcWJlbEYfo3ViaF2WYwPkgb72N
 7WSax9J7J4IAx2GbyKjpRS8w2dHqK0u4GmLZMdP8TPFE7GSzh3CfZyEfAeweD6vGtMFNjj8Gswd
 DC84BGZLNk8CcPSblxOixOvseErPtBbie4v2dWJK/U2dwhe5UXWcCohBa8fuqxXNbplIU7SbrWz
 qFzFr/aEWXLf7NLPIXMP9OHRNuT4Bzgg6iB01bnxi+1VAUleRVtcdfM5d6YYOQXhGZPg5piDqTV
 rVYwvKmX9oqTW7vWvog==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX7ddZYOOKG9NE
 WgnV6ufCWc04ysidZHoZdu6FVAyngztzaPd55+9O5H83kY+SCdXWnG9BZLruu9oYR8or5ufRWRo
 c+fA7EkHnJQXMVXLTQjK4Cfq5Gi4EnU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/xtensa/meson.build               | 16 +++++++++++++++-
 tests/tcg/xtensaeb/Makefile.softmmu-target |  5 -----
 2 files changed, 15 insertions(+), 6 deletions(-)
 delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target

diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
index 339a9a1294e..bb1dd1542e5 100644
--- a/tests/tcg/xtensa/meson.build
+++ b/tests/tcg/xtensa/meson.build
@@ -1,5 +1,5 @@
 tests_per_core = {}
-cores = ['dc232b']
+cores = ['dc232b', 'test_kc705_be']
 
 foreach core: cores
   tests = []
@@ -94,3 +94,17 @@ if 'qemu-system-xtensa' in emulators
     }
   }
 endif
+
+if 'qemu-system-xtensaeb' in emulators
+  tcg_tests += {
+    'xtensaeb-softmmu': {
+      'cc': 'xtensa-test_kc705_be-elf-gcc',
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'xtensa',
+      'gdb_arch': 'xtensaeb',
+      'qemu': emulators['qemu-system-xtensaeb'],
+      'tests': tests_per_core['test_kc705_be'],
+    }
+  }
+endif
diff --git a/tests/tcg/xtensaeb/Makefile.softmmu-target b/tests/tcg/xtensaeb/Makefile.softmmu-target
deleted file mode 100644
index 3df131acea7..00000000000
--- a/tests/tcg/xtensaeb/Makefile.softmmu-target
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Xtensa system tests
-#
-
-#include $(SRC_PATH)/tests/tcg/xtensa/Makefile.softmmu-target
-- 
2.43.0


