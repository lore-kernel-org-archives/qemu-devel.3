Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A32FC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVu-0004T4-4F; Thu, 27 Aug 2026 18:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVp-0004Dg-If
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVl-0000HQ-Ts
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLvJ1848985
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8jHx35bCilqU/qD1rZE8PznQsHeob5lbBh0X85ksk+I=; b=k0Xa0wUJp6lK5OUI
 NAPSbqaQ+h6A2X9GPbdQc/9S+jlj/D2Du2zWvNnarFwQBj3eYeV1jOagzlGwIL0H
 M/RtLqjS/kWnUyqt6unUVrhn/gxzf3tmD0yBMpVrTOYLaz/4lajhoCVzXNUcz8ME
 ouiWLh3qonZcP5jLok2CfrSWiJn5SE3mg5MfeP5+GKGw3xE5bBwm0oWE54FbVbqR
 Mx30YGgKOCMqPt2V/tP893hA4psIX3uiCCHoa07QdEPTapKti6/F13k16Wmwh7Pe
 Pwdnr2d0oeGfFss+wqwNbYX5EjpB+TFEstdZN+rX2UBMth4S6Xbtfqdx3EpM2GVR
 1/BIXg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a7u3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb48f41343aso1286805a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869431; x=1788474231; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8jHx35bCilqU/qD1rZE8PznQsHeob5lbBh0X85ksk+I=;
 b=BfMUmV+fnfuY3j/A8no79QI6gCt82dr83JzWFF/9VxD7+bNdTxWIN1vBaXwLjdMaOQ
 HGeuzW0egWJsZaxsH5FT/o9Xv5s9N4TR/BTLuAgNAE7SleEFrdy6ozwC+9N+HrWJiwcH
 E55Kn0Nvn2z5YlHM6VUzY0SeGkArHfuP5Vh6+magN0hT/WOeYYUcreeFiA9hZV4F38oM
 jN44Ig0V/UN7US0HqAFFE+jUZexCh2sta9ItOb7p/lm2h13h/mjCOdqepYLoB9pEOl20
 GHZLs5UWGF7JTRB64AxOC9TX2Gcm0aorFyXRTyX5dN4zWHgAVXoxEfGTd8/LLhEYIT+d
 x0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869431; x=1788474231;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8jHx35bCilqU/qD1rZE8PznQsHeob5lbBh0X85ksk+I=;
 b=JVkhbwOwWCWQIjqzXcQwnronVdtV4ikdlkTV5jvP+e55MhrO/ef/LImn6d4tUTxalC
 TJDz6N5ZRVuzYEjf1Q3u5Tu+dQhJPuxA0kWXB8dWIU4CO4nIpl0jcq7idDRcKwy/b9XX
 0ebWBVqukDRngeAcodS0cmmQ1CZOk9/qar01ln/eUygDSevOeSWT44XtztfNiSqJLJ3r
 06nshmblMaYDX0gCToeX8UUYXd4RzPTdRUD8lclCeo7QvtJhuxJ+DulWxo/htgnnl+bJ
 Zc/ZNB74eiBCyRBBb2G5cDRG0Z78ESyusMCnkOeHrHuvI/qTrqg6LgUuWfKk/KYMf8Eo
 8uwQ==
X-Gm-Message-State: AFuF++nbrM7X/wXK+ICytB1JHrYEPMoV7MIiDkg/4QBkH9phpA93YheB
 YAZcur/Yy4R3WoN1/toWKbq3qBAfFgPi5/bW+TNg0o2PF2nlL3rVJYuUHA+kTPOLDg1zsKMJJne
 jLBMuXxAUqm7bBlQhEYGIoc2V7FEEiZijtdGDLcqGgy6175y0eUvcj4rhgkKOWQlb1g==
X-Gm-Gg: AR+sD10pEOFo7/xlPMVdK2xRbt08Uc1XDmRSO7v5lDO4xkE6G4mMgHXdd2tNF3vZFVj
 VxQrT+7xZ6DjY3FNsR1gm94Bi4bjPocpQFhNeh4c5ZPqY8xjBPbht43Hr4Zipif5fz8qG9gbm4P
 3PwrseYUBOD4hqGjTFIFdxPtugkGEZkPdV7MmrfbomrE0p9EekDlt/IY3QE6nKN6rXlIFoDQktS
 d/8lS9frJdqsDl4BdSEOx5axm2FstALzLLggFWIEfcQadVql+f22DKUXywZ0yP/KvRu4eLVYSf2
 tfR2a5MHN4ypgJLeSvmu5fBUezirZz/dbSzsZ84Z7RpDtsiXC5thsh4V7QQJb/OvW4UL7P9QeNH
 AcuqIhlwpnJ5oRBKIoPeU4uWWdE7Wve3aSE3kk1SmCPtFAXsNtrhqJ9bOl/4=
X-Received: by 2002:a17:902:fd90:b0:2cc:89ce:2f07 with SMTP id
 d9443c01a7336-2d74cc49183mr26279465ad.1.1787869431437; 
 Thu, 27 Aug 2026 15:23:51 -0700 (PDT)
X-Received: by 2002:a17:902:fd90:b0:2cc:89ce:2f07 with SMTP id
 d9443c01a7336-2d74cc49183mr26278985ad.1.1787869431033; 
 Thu, 27 Aug 2026 15:23:51 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:50 -0700 (PDT)
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
Subject: [PATCH v8 100/105] tests/tcg/meson.build: implement ./configure
 containers options
Date: Thu, 27 Aug 2026 22:15:01 +0000
Message-ID: <20260827221506.91574-101-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX/yShEQttcDq3
 D4M912hpmveve4La5izsm0S64NCSdcHUBcZtkTSCfWfYbnzbPLwLewHk/whGzN5vTqwS1tIrGAs
 fkw8FXAerhhMqziMhkM9YqI+q8iAvj2VNlRxY6sy0zpDfZXjH/y6bce1QVqMxsgm5uUX76+kM46
 niEm5QFnvElh8v+wgABNZIZB5ULSO26u64GA22oVKmRbaD7WOpYFuwgUFd4FRP4QsIItOGiMAWM
 5QkF3KT1HLYD6/PLjOILyRWoroL0bliFQom/hKDB+ozn+vpsav+9h7eA46/WRgvSBzBcVW+cnZA
 DTXdTqRW2lbAxqkZGpdv21Dt2S2dhinSPymSz22ETJFY1ak1KA7dRYhCe53U3zUy9mTKzgjm4ay
 TzlmlKVQuuWXDHZ1S51/jH0kl44jP4GECfc/m8ioUvyklcfi/uLN+BPRrn4qfb+8OA7g61aPQ93
 ApnUMxjvUNoAK+IwRyA==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90b8f8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=lx9kXCH1NlTzeEEIdf4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: JsmugXPwfrMHf4MDieuDVF9YqMbPBuHo
X-Proofpoint-ORIG-GUID: JsmugXPwfrMHf4MDieuDVF9YqMbPBuHo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX3/2bz4WvuvIN
 3WC+Xv91NLEOJAepqFMe7zrIOpd3EQn/GZ6HirL4Eo1pa6b4JqzaVjhfuzWp6Frpd15PqpxyxKE
 Q65Z2nZEp3my8Au3IJ0gJ3iXSy9nCwI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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
index e686a4e0609..d173ab93068 100755
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
 echo "PYTHON=$python" >> $config_host_mak
 echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
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


