Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C592EC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZpB-0008I4-CC; Tue, 28 Jul 2026 00:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoR-0006bU-Px
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:53:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoO-0002af-Ou
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:53:06 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3bA7F1062923
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BAYtMrGBH4j
 nOHGGndHU5MEpybqmB72zjVOHKMfp5x4=; b=B/NVrP7/9m6eyThNyF43nu7ABRn
 15oPVGG4FW9bjIoG+4R97vEYsl8GpHG/ONBa3NblrgTZ5iZP99u57WgjopRUUKOL
 azQzbdKfHW3fBiMzyG6EdEuhVs8cye7NrdwHV11k5GEMNfpY8lEOu79E90H3/UKe
 oeC6V1BQQDdKYOmcOWJwNCx4coOyLAhVzH8Cmb4vZFOrC6glqJ4EDwUAo1xdcJ78
 moPDYMX20ayPFpZ/WIZY/IvWQGsvB25aIVD7BfsRPOXGttG3oFYcjE0mDp8kbBIl
 kOxxlow2sQOVtc0Gj6ReNdmZstaIVzPvhlxIOcmpkpRCTi9U0h1X1m2wCjw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v6chtp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:53 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb48f41343aso489743a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214372; x=1785819172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BAYtMrGBH4jnOHGGndHU5MEpybqmB72zjVOHKMfp5x4=;
 b=cGWNIwqnCXxdp+wv5JunjFzHbwq0zVqsamSYQuUuqhV0nL86kCsgesnS3sZpC0YF1e
 tHFTyLLr6ydNMrD//e8wHv2rBLrGTzozNrCsxhGsbF7C5YaQNA5w5V6ynVRQB0ypWl7F
 wYMxgxRrKmSackOGz3TysEnGZa04b7bvZrvrjDVf6pGFh/8XB78Td6ubNxoqezkfDM6v
 Uzx5j26heFzy7Zj2TfuOweIjsPZEbR+63hsy9uZoiHEnRrQm0YrnzDEs/Z9CsfzC02n4
 5HzcrkPABCFgvxAnaZEyORM0DwsH+vWJVALMO+3JRyPKyj1vzyAYa1wStbw856MUIT/p
 Hqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214372; x=1785819172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BAYtMrGBH4jnOHGGndHU5MEpybqmB72zjVOHKMfp5x4=;
 b=ovn/P499AOy5YycMHVbwTiOiJzfcI0n1TE9fkcZJueWXXuHG9csswRpExVIubd1rmM
 T/Js8uAWTlUbkvmj9D5YZgF/Dm9FDhMqwCtEKFd5hnnPZlyDNhm28LNbXPaIl7RYS31k
 wJYuHtjRcfZIpMCIKLDt+jRl+XQsVlCOZyFyqIdbM8LyU2wkd6XOhoqvcXIGCa5rr7BQ
 w8nFwqtWDR32jBg/PW/4z4aD9hA4Qp0LeWh2SpidvQ4VnoPPYl4baUPapXUavbeB1OJY
 Px2iwTusbjNrhJfDNlQZ/cnBlCCkafS5+cwaIkmFfKIO0gOLva16EcVjcZn81SmwvP3o
 ANSw==
X-Gm-Message-State: AOJu0YwDvNNq8/7/xFsnvqzbc7HpijSskfctxpEfrdstYeiXflz2ussb
 pN5DYS/uSsRhe0AibMgqXdsR1a+vz081nBN5ilM6go9avpsSDLR/2ZnsDv0lrVk2TNPbZC49gy/
 OG9Iz8sAXmHv/BR2w/YrpwU/9NGA4lH1N+Ypq4+uLW4K/iVsMVSGaUwcvtD6llYGVAA==
X-Gm-Gg: AR+sD117+eF0/3lCCgqZeZoYn/6M9CXQkV5KFJDNa9I8kNW6leqs87pqTAgnCi5aAGQ
 pVFJ2DFW1SYqb07tnsVyh5KLwUZoS+z7HqReRkoz0E/cc+gjpbGkhYzSt1fj3IRxurFuD7tMg+N
 C9qZ4VkfJ+ubOIJy4ONstAjKFVtcQiWGJamP7WPVj3rlz6ZzToPGzvZxkJnSmgz/hliU+yriKcg
 pz1RF2yhMHSAaUZutaXT8GuyfpHwSRqFlWzI3YH/BBi3KuDDI1pISh2rSjyszoAZThKben2aNR7
 JTQ0+noXHEkz2/aRt5qTY3bxQ/79L760usPiyMXh2ENuU7S522EH/LkRd1GDgIVComzC2ud8q4c
 ejWt3cyD2ZU9U/36xbQlDQBVGIUFJJD0PCbCSZ/+Lsdz7QfxVEfXC2Le0CvPaqlvGKbHkvMg=
X-Received: by 2002:a17:903:90c:b0:2cc:ac15:ff4c with SMTP id
 d9443c01a7336-2d015c94766mr9536845ad.8.1785214372540; 
 Mon, 27 Jul 2026 21:52:52 -0700 (PDT)
X-Received: by 2002:a17:903:90c:b0:2cc:ac15:ff4c with SMTP id
 d9443c01a7336-2d015c94766mr9536465ad.8.1785214372102; 
 Mon, 27 Jul 2026 21:52:52 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 099/103] tests/tcg/meson.build: implement ./configure
 containers options
Date: Mon, 27 Jul 2026 21:42:43 -0700
Message-ID: <20260728044248.137626-100-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX2Wcdqj/2nsyq
 nBiKB9AYkm5XauNIJx+ZTudP+XPmrpdQY8LcX8W2r7IOkpt1GTXURyF35Oje41HqwR/Pv7fPvFr
 Jrfj2fl2422en/BY3/ryJaIv5CIUhaQ=
X-Proofpoint-GUID: -adAW7sfMMbXmQXdu7BU7xUumHO93zht
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a6835a5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=JsWHpuHCQTrgjtn0QZgA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: -adAW7sfMMbXmQXdu7BU7xUumHO93zht
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX0Ws0p8F8GJyB
 C+cjyorTDZ2IwqE1ElCLCrVXDM2nyC6woWmRNSNQ4bfmdY6Ok6JcMkuuoWMGWUlRxQPAsj8rINp
 0gbEFOgyQZI26DnnEvvKpqhpN2PvwFK7HFYG76Zb8d6lJs/d08jC2OqLgJyyy13FuaQwhXQr8Jr
 dqX5IErJqNdyJY7td5H3ApaNVI9iERRXNFt+NsNsL4EQYMg9XYBembNirsLesdidFNMl8Yq3oTq
 WwsCGgKyhdhmS1tzMYewL03GBnvnPAl4VCilQCvC7fksXJ42JMF1KpdZPU0rYtwkbPNKZCQ7lGs
 9kTH9LS0IXeWw4wq1pyvCZbGDg3Jc6L8AVy/XYestB0tyDyG4S3VWbmvxACDTAtcx/l7fOYaXCy
 K2L2dW1Hx5g8J90UczRH4vPgRA6yrMm4KqCle4OQSits+gdBXczQoAUUv4Ks5JFrkx17X6vz2Ea
 J6YgfbEt0so4OJO9YIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280042
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
index 120634ae0b0..ba73eecf1c9 100644
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
2.47.3


