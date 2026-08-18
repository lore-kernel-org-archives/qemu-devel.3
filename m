Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129A7C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPYY-0004Xe-2r; Tue, 18 Aug 2026 15:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYN-0003yb-5n
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYJ-0000Mz-TU
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:54 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH3hu1943377
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XEkGQgpYqjv7PG9UO5LqIqxRZEJ7Tk6JmFjlzisEyVQ=; b=LGaLSPFoIioGm+Ng
 ZaXVp/2oIVGF3ncS/YXv48OJ4obGc+/Rp1aE1H15UtcpjPXXejU5rEo5KbBCiLZp
 1XMI5idYzlx0KCiYqEc/sN8ofWy2myHFCs5u3T3OtcKRIBQfBsUsjNrJd9PYAsrt
 +0sGjFDU9zG2Ibrx6b0ayyLpUz0AIrYP1XZFV6ZsNghzMMBIT6L83otRGdDnRSOO
 0lZnvcicsKZmgzTwRiwrt5uceiQo10UEpvawKtsqUBM3s1NJ0lrQkqhsz1OoZtJn
 dTGUZ9RhujkB6937EUBA3g19SIEM/KzV0YgfevIk9qQR3l4xQD7r3VwtJHwB7pm9
 Ksx8nA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4prn280m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:49 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so192335a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081568; x=1787686368; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XEkGQgpYqjv7PG9UO5LqIqxRZEJ7Tk6JmFjlzisEyVQ=;
 b=ePx3dVuOA/VqCd9pFYqEdawpM1Heg4chqWbz7i3cl1aSavs0xwHBYjk05siz//Ml0H
 d4dC2YAkUFtCumghlrx4WzALi0BsAPxoKkInLxcrrJ6h3ONzo++ziJbLuM68Qlq1Si42
 8eyA+7sgM8Zth1v1EAs+9Dl4usFW1YS4pYAbvJB9yu4SHCUESzMjcpJEMRshUVw3Dlcq
 swxGk0MyXSKb16gqQSdDyHl2FF9fIPodzKIXmCLEPaInzpIJvm9i4i6hGx3H7PsPeXL4
 TZAnWpS32Wz2dvZSvkGq1oBtMD3lIU7pnz39cycZVtu104dhxTd+QL5gI8lMZRV11u3b
 NDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081568; x=1787686368;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XEkGQgpYqjv7PG9UO5LqIqxRZEJ7Tk6JmFjlzisEyVQ=;
 b=cDS+z2/FmUaeqvPJ/OnAL8UybjsX+kkkZSBOcU8c+M6XaKgYs2Izw/d5ECn4ZBiryq
 1JV9XFyDbfgPlgVFyat1Op2dF9CBFn7NNA2IFpGq6I5QftTxfIocz1ccanHGV0+hiiQI
 In3nWzx/1EilJU4/4gxmO0BL3Qx8buib4xspFPMIEBYGsJ8KelUfDh0cpWqDgufWgW3c
 hCqBG6x6i50LcTomEaMq0S65D5pjEvdQCTs+CZjxOWBeNK3jwkA835UxjVXUeD1TLW2A
 ynfRiwfhaCxR3eVYGXPBf1/PTwMxrTqlKNr4NaDmci+CHI3LIlVVMD4p5T8WbS5INeSk
 ztQw==
X-Gm-Message-State: AOJu0YzJQ2LHSFR/ECT+zkGSkFJr+pwHmykvE4oSRndoWVmPCC1w9P/O
 M3AV2uL8TbLo2i+XnYzeMhFboijzfpywyq931Q8zAIFNnisf3DgUiShUKU0ivJnVOwplK1T9JUe
 DMWQpUM7e6KqomwzIwqhk2R+Us7KUGJSO+cl6sovM/QtznMyr4oDXFWCgSbiWDDjrHA==
X-Gm-Gg: AR+sD11NOQOBmemiOYlOwjg74kas/uyEWuG4DGzEPLPl9Q77QyKIMoFnTLzL+yoPiWo
 eu2eosmJLURA45D4nuziGNmBelGT/B2z1/L8R51utDHoMM+r+RkELvjXGEsWfBdQo/CCKnATneN
 3tbSg1K61+T3301Jrgj6R1E8wTNTjAOtKM1DTW0Khv0XNGoau9vnxd+YY4U4Rm/GZvXNRUJDKeI
 8OszwRdrbEGhxOAzCmESBvQwkZe20REwGabpEJN3+nxjEZqopXfAzuFnt2Lz9764HfF/sk5ASd3
 SzkYRAvn6LqU/p1fx4Uk/BbQ1HECaRH5mYWLaFQd4NKsATFFuwc7+hoLGJWApRzxgLD+77Ue6JZ
 UsGpMheG13TpOMxU556SP3jPScw3AULNe11jqRbRGCPw4UL4OzEQmTqppadM=
X-Received: by 2002:a05:6a21:4c03:b0:3c1:fbf:1e2e with SMTP id
 adf61e73a8af0-3ccfef69fe6mr260731637.10.1787081568382; 
 Tue, 18 Aug 2026 12:32:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c03:b0:3c1:fbf:1e2e with SMTP id
 adf61e73a8af0-3ccfef69fe6mr260673637.10.1787081567996; 
 Tue, 18 Aug 2026 12:32:47 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 100/104] tests/tcg/meson.build: implement ./configure
 containers options
Date: Tue, 18 Aug 2026 19:23:04 +0000
Message-ID: <20260818192309.22169-101-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX2dJygKcOTf66
 wSaQutdvNXD/MlFMjwBq5AeKrUNHzFYv+L5ufqpdtYsrK/Esrjkhz/QUbrpJ9rpt8dezlZ0UWf0
 lpca2d0fxG9OoSC7bADMdueP5Je7boU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX+ptd+6gmHu38
 Y49C2VOUjnXNfZYuboxvDui64G4X3xOhE/yVuqOMgwXv4Srw2OgaemaRk4sBIaOIdnFc2ctBSBf
 /FNWop5DfIaR9hdJTdMuB+kMI79ocCPmSRamy2E4jv53W1mq5Gw4f/p4Wn8qIWYky8EDVqk0AgG
 SPqB8lk/cKVdIksK866R/LaUuAc7yuAcAit913oMCv/oHnHcwnKGtf73Hnr/OrMWj+JlrH9QqUS
 +5kQgE2892wQ6+AbFJ8g8kEnYHGtgnl2gV1+71SstjHrmRWGKMKZj/4oHsW938xvBs3GbJ0m7AV
 CL48oOV8GVWfNhGoOjS1NTZc5gKubGfFIb+fcw5TgKDy5Szw4Ye7CjtRFTabWLJcNE63MBSWM2V
 iZlcu6eqxeiK9X792K34WKoPW9/IpYOtGFVHY3yC3P/Eq9pJLlZSSLR554980jD5sRWsrG5BsMt
 ax9BfWdlmqKdIzgyxGg==
X-Proofpoint-ORIG-GUID: _OLg1GC4cm9bmlhx-AbQrK73LENMM3kP
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=6a84b361 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=JsWHpuHCQTrgjtn0QZgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _OLg1GC4cm9bmlhx-AbQrK73LENMM3kP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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

./configure --disable-containers now skip containers build.
./configure --container-command "/path/to/docker" can be used to
override autodetection.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configure             | 11 +++--------
 meson_options.txt     |  4 ++++
 tests/tcg/meson.build | 21 +++++++++++++++++----
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index 06af81e18f6..568de41dadd 100755
--- a/configure
+++ b/configure
@@ -172,7 +172,6 @@ fi
 # some defaults, based on the host environment
 
 # default parameters
-container_command=""
 cpu=""
 cross_compile="no"
 cross_prefix=""
@@ -260,7 +259,6 @@ ninja=""
 python=
 download="enabled"
 skip_meson=no
-use_containers="yes"
 rust="disabled"
 rust_target_triple=""
 
@@ -728,11 +726,11 @@ for opt do
   ;;
   --disable-plugins) plugins="no"
   ;;
-  --enable-containers) use_containers="yes"
+  --enable-containers) # enabled by default
   ;;
-  --disable-containers) use_containers="no"
+  --disable-containers) meson_option_add -Dcontainers=false
   ;;
-  --container-command=*) container_command="$optarg"
+  --container-command=*) meson_option_add -Dcontainer_command="$optarg"
   ;;
   --rust-target-triple=*) rust_target_triple="$optarg"
   ;;
@@ -1719,9 +1717,6 @@ echo all: >> $config_host_mak
 
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
-if test "$container_command" != ""; then
-    echo "CONTAINER_COMMAND=$container_command" >> $config_host_mak
-fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
 if test "$rust" != disabled; then
   echo "RUST_TARGET_TRIPLE=$rust_target_triple" >> $config_host_mak
diff --git a/meson_options.txt b/meson_options.txt
index d2bf5ca1f53..5e91969414a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -385,3 +385,7 @@ option('rust', type: 'feature', value: 'disabled',
        description: 'Rust support')
 option('strict_rust_lints', type: 'boolean', value: false,
        description: 'Enable stricter set of Rust warnings')
+option('containers', type: 'boolean', value: true,
+       description: 'use containers to cross compile tcg tests')
+option('container_command', type: 'string',
+       description: 'command to build/run containers')
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 144577fd94e..2458a231f5f 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -78,10 +78,23 @@ if gdb.found()
   endforeach
 endif
 
-docker_probe = run_command(docker_wrapper, 'probe', check: false)
-docker_supported = docker_probe.returncode() == 0
-if docker_supported
-  docker_wrapper = [docker_wrapper, '--command', docker_probe.stdout().strip()]
+docker_supported = false
+if get_option('containers')
+  if get_option('container_command') != ''
+    # make sure command is working
+    cmd = get_option('container_command').split()
+    run_command([cmd, 'info'], check: true)
+    docker_supported = true
+    docker_wrapper = [docker_wrapper, '--command',
+                      get_option('container_command')]
+  else
+    docker_probe = run_command(docker_wrapper, 'probe', check: false)
+    docker_supported = docker_probe.returncode() == 0
+    if docker_supported
+      docker_wrapper = [docker_wrapper, '--command',
+                        docker_probe.stdout().strip()]
+    endif
+  endif
 endif
 
 # plugins come first, as we need to build the list
-- 
2.43.0


