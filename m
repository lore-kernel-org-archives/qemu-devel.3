Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEA606A8B6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fKrfepe0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AtiSYtcy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZGQ-0002wJ-E9; Thu, 12 Nov 2026 13:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZFW-0001Im-RQ
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:10:20 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZFV-0007kY-65
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:10:14 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFZjkY3180961
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tvPgX6zbt550DX3PMKCkJzPcSsfzMzrq0LIQQnTkVFE=; b=fKrfepe0GvLQrToi
 pVwLWLmcSD8EkaM90vKbfIct0cV4f4cUht8yJJewRrH+diZAj9p36FVmnABcsvIU
 RFkX1DkItjuhpwXnIeFGnnwm0zGebin1kEFWBXNlRRHLMVw454jaSZ5rZSmFISib
 Mpx02Kez5ulTaQhpnt8a8sWy0mLpy/VM7do7/Wnbpso44AgCUmHin4c6NMAdbFAB
 9Czo/lnmd3EBUFP6lKDFOYj1GLQ0B8M2+onuWyfqgexgtdc3ghmZ1qR3AYcrne58
 Vw54cTM2vuM8Zgl/adM9AthP82lPuP1EBRo9v5fs0z9d2OEKhOWJ9wyWpMORo/WU
 oV37kg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwc1j1ndf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:10:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f322ef7d3so6191885a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794507011; x=1795111811; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tvPgX6zbt550DX3PMKCkJzPcSsfzMzrq0LIQQnTkVFE=;
 b=AtiSYtcytMkuoM2R8utQVWuJQqsS7z/N2caWZ4ydZ1iq7o4XANz0Gi5mJSN1BdurgE
 sE3bitg9/OvMxPap44i7r6V8WwhgKjq1sj0GX19dPZLMnZCZLq2VLe7YwcCDNG/Yvz3H
 v6hCHm7IYhquAL9bGEeGlekkkhtSL6hXm9owUpz3DQoLEe3Los3ZqeN3UyU2kFZgc7qy
 rNjtRA08NQ+N5OZDaBElA4qiiN6hqWZvNqzCUhrxw10EkmkXYHEMLWdJo0a34L72SwFw
 XZcyHVDK6a9XHyyO66X8rDVYf8XWqH93ksxCRoDHq5SPjjjfykfvTXQAoRJiXvFUGvJZ
 Sswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794507011; x=1795111811;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tvPgX6zbt550DX3PMKCkJzPcSsfzMzrq0LIQQnTkVFE=;
 b=gheTSicml6uDgC5uSj1YP15On/peyMouJtwDNFU/jekRH8ylfHgny9aur4YhJhsFLA
 dboX2NybkEAGy7ryhVBeDZQDNVMTb4asmqdeYWyVIGduW+bckhz6rOJricfCHXhcsZ7S
 oN9CgEr3a9NWRs9IvvyPgSHv+aXjcOph5o8NyJ+d4eZT2l0ktFluopkur0LYYdK6vFO7
 qnTeM1Nk6fQynBP9ijK0rQxiKAOqfRMzAdPPSGj7SVxv3W3XRvfIW5638CCcoZRRF6p0
 lA4XcMPhB1PoLcCOIb8NxF/fmEyifjayi9fyOGiiDE0F1dH4marTw5slr1SgNIGXV/oo
 8I2Q==
X-Gm-Message-State: APuU4Z9Qsnwepe/wREriy2Tl1lD3l3T2ZmaZ7dFhcpcQoSNVJdX8/a6L
 HFkavMj2q0/9PiLt2vN75YD+UBQSYM/7u9Ww8G+cVZXml3dld9I2XBUUt7J2QAU/toe3PACa4j2
 YMqwJ/mHRyHrMDv+BeR28OkPRblQiOCefkrlF9McT3FIP1Fr2FaAJtiXb7nt+xsj0Gyn8
X-Gm-Gg: AYBFou11zsQi2lbkRrm7zBqL1FM1aVRZs2QmU4p1z9pt60riQlAxAQ2+AlQiWjwcKcb
 K/xNVa3Xb+M+WuzOmuag4Rk3rTq0rTkL7hzra81QDMxPZhOCIE8aN/Q8OxQrzlSImoboxV8ds5/
 FRL4rThrhyq0WtrGriaXv4Dvy48wA9iBYa2MaFX9niHyaOHR+XdtwcMtv6+21BgY9sJlG0TbAgA
 ltNO0FvoAYxWhJo08lb9vzXd1WZuvRApjBcAKWpipj+LuBSPpznLhJWVq4sWKCkkq7uRjSJ++Z6
 HcRbzfAx3nrC7haUR7cTydaGlPQqOYlLihOfTBGUIgSrZ0Ybt2Th7zbr7hEde1OjBADX1Xnmgsi
 oZ4t/dBps7GSzaZyycrGR9lHRirNtjbzDEUvZ+5VQS311ozn8gXla2V5Nf6cGj6qLrD8xII7zfl
 ndusTM+3UObZBGsg==
X-Received: by 2002:a05:620a:2996:b0:93e:c06a:7313 with SMTP id
 af79cd13be357-9494bbdd0afmr32194085a.13.1794507011422; 
 Thu, 12 Nov 2026 10:10:11 -0800 (PST)
X-Received: by 2002:a05:620a:2996:b0:93e:c06a:7313 with SMTP id
 af79cd13be357-9494bbdd0afmr32187385a.13.1794507010945; 
 Thu, 12 Nov 2026 10:10:10 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d03b10fsm725381f8f.1.2026.11.12.10.10.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 10:10:10 -0800 (PST)
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
Subject: [PATCH-for-12.0 v2 09/12] linux-user: Select target byte order from
 the ELF header
Date: Thu, 12 Nov 2026 19:08:55 +0100
Message-ID: <20261112180859.85380-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112180859.85380-1-philmd@oss.qualcomm.com>
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX8O6Pknwt4t78
 dQnm3hcmWZd0HRQ8rH5Y38nNdUPlB8qop2GjnekT0Y+4HNY3DZvMbv2nKpZxlDnlUKDZoG2Q4Oc
 9iiKmU3LnspbdYynWyZ4LoLEfOqsw4I=
X-Proofpoint-ORIG-GUID: 44YFM1xXpHlaKtg3IEGknQjYAbpNTRJz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX04zcm3uXSny0
 LMwE0sUvJVfoFWPgzhFusVvjDxT8/yo5aJEaYmVU0KR65CuqtSp14mJv/DEZOc5WPwQSCAHwjDR
 PbhpUotLC0piiR+Lg6t+qFaAS1ba3qDUr1FoZPbMUPyUw2LidwGH9pYPAPyQJHwe2mlWFfVoxUx
 p4jNpbLa3WuyBn0HFYmWXFslW/n3ikUeFGNcrEWVluFjNcNgHTJJkeveh5+gaOhE8hVlHYIxf5a
 kcIwBm0SYu4nzl2aRR4QmYqJePMJBzpIcrIvm2gIMBcR1VRmObbnNmsfWRbefa1yaQRkdc8xO55
 lVVEsc+q0jmtdkHt7CzyI/wzakoaaciaEznhmCI7wb+ZhEde8XdX4ChwF2j2HEkujSSFzQhiSus
 dwjFcTn8nX+CbADZoIn1BgFWq0y22xZjqXbmTt7fuUc8G4/GFSSSKGrrJm13WfSbea10ofRdeVq
 ylK3IeU2lFJBGJbRhNA==
X-Proofpoint-GUID: 44YFM1xXpHlaKtg3IEGknQjYAbpNTRJz
X-Authority-Analysis: v=2.4 cv=Vqe2kO2n c=1 sm=1 tr=0 ts=6af60104 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=kZLfmvQpzMa1BZTGQ20A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120072
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Read EI_DATA from the executable descriptor before selecting the CPU and
loading the image. This also covers binfmt open-binary execution and an
explicitly selected CPU model.

Reject invalid ELF byte-order encodings without using the invoked
emulator name to select an ABI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 linux-user/main.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 2f0c0a50c8a4..71718f974f6b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -22,6 +22,7 @@
 #include "qemu/units.h"
 #include "qemu/accel.h"
 #include "qemu/version.h"
+#include "elf.h"
 #include <sys/syscall.h>
 #include <sys/resource.h>
 #include <sys/shm.h>
@@ -769,6 +770,31 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+#ifdef TARGET_RUNTIME_ENDIAN
+    {
+        unsigned char ident[EI_NIDENT];
+        ssize_t len = pread(execfd, ident, sizeof(ident), 0);
+
+        if (len < 0) {
+            error_report("Error reading %s: %s", exec_path, strerror(errno));
+            exit(EXIT_FAILURE);
+        }
+        if (len == sizeof(ident) && memcmp(ident, ELFMAG, SELFMAG) == 0) {
+            switch (ident[EI_DATA]) {
+            case ELFDATA2LSB:
+                target_set_big_endian(false);
+                break;
+            case ELFDATA2MSB:
+                target_set_big_endian(true);
+                break;
+            default:
+                error_report("%s: Invalid ELF byte order", exec_path);
+                exit(EXIT_FAILURE);
+            }
+        }
+    }
+#endif
+
     /* Resolve executable file name to full path name */
     /* Keep how we started the program in exec_path, e.g. "./my_program" */
     /* Store real path in real_exec_path, e.g. "/usr/local/bin/my_program" */
-- 
2.55.0


