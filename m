Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DB2C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziW4-0005Cr-DK; Thu, 27 Aug 2026 18:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziW0-0004sx-MJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVy-0000I2-MJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:08 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLoWg779222
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VkcxtTaOnU7X/eofCccQvSf+h7wnMVZEsZ+Pa+okGc4=; b=n3zc3Ram+EJHDNmk
 O47nchfJ4fqA3fjlF2sNJ3IFPoPVOXmsbk+oK87/zGUK3zwPOTBPm4v7LIeVuVgJ
 VbX2mAdmH42/8MqOR3aH7tPFDPWbruAay1gtS23JG9+vPFf5G3ZnRgDv0Oy+RaoI
 4/99PLtobn2Hzn9eRnRB69cuBn67FTyR5bdC0ZoamRsXkxIze2Zr15Sf3GlG3Ben
 NV7AT0i20eXoV/4Qs6hpF/JD/WK0b6javbFVqcdxEpiu8VVQu+qvQMsDlaaM/Kvj
 tjsO7XrHxZhiI3sqGJHnW6LoXvXVdM5hA+sFU50oXG9X8aikor4PtLCoe5Blzox+
 TCxFJw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garee1r7d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d6f80c76e6so3981765ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869430; x=1788474230; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VkcxtTaOnU7X/eofCccQvSf+h7wnMVZEsZ+Pa+okGc4=;
 b=H8KIpGje4EVoQOdiAN9LWm/5ceSTjH21kOVtvCRv37ukwT3r0mRzc8HJNyuEdCNO2X
 w/T4YEMXPG/NuFTFZjXl6T+R7osdzOQtTn4nVb8xht/G5gJIJO2qaBArf7ncYH9B7pLp
 SpeA1gAxfjsTEH+f9h1D9PZ4mT6wvPGn87g9N7Hj9rku+YPKR8usf8VZKB0c5yWs23cF
 CI/dSywFGWmaiTbBDZbg9vlUjd+2/1wuSH9D/R7Ej8dN9NbGPj4kdOL3s0XVWtpyD08M
 rBEXKUwEYiUsvX/T4F0s8yEt6qTA4uESxKBIEr+11KTc6wI7mZcdeRlTySRnjwLUx5PE
 2AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869430; x=1788474230;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VkcxtTaOnU7X/eofCccQvSf+h7wnMVZEsZ+Pa+okGc4=;
 b=GKgjk+DfovnbjaPH8WLKrdA4B4A5P6y+QQrOMJKTe2k+ThpK4+P4ZHkvrNOTIgG5ie
 jtH+zQ8AExBslFLLMJJdwgqHB7fhdNKljrJn2KiwXipj7rP95xaMmKKXDUZQ8Ee5+uE5
 yzn2tgDk4ndWXm8Bq/8YqziHPCyLGCImMfpymm8XUeh1Xojs69rMbxHDuUFm72U+Keeg
 YGtPazpLFCmbijGPVagCeNP3R2HlEk2ro03Vh0tFOMYLAHTtWU3oLLJvjs5vpQuOWffO
 TQODnDe+xWhlp5n2yBqaY++2nr4T0keYEkb7Rq2W5Bsjk906XMffxrnuweGSjxMl4oMs
 aTOA==
X-Gm-Message-State: AFuF++keMn/O6RPCO+Cdqi5Ak4Qc0ykrx1e2NMBraDDDIpXuvCB+GnIz
 1q2jjk+eqMSKrCwmlpHFnPpbH3IJZdkuHUnL0rHgkPQlxapDrO5WxeMghCI0Y/pvBJIrsGTKavn
 IIehQugWBSBgEY6oyC0QxJN+DBDHRn/+IlcBLy5BUo9nd4eLP58KC+VdDg39RbmX8nw==
X-Gm-Gg: AR+sD12wplaaKfkPtZLv4PfH8h0RW/nxO8dSwlzqN0Chmqa3QfoXSKSdC7pV2nArRZM
 xLd/leCcSLphliM373mEs51BnmndoXFu/fJ4XAlnSMaYu40iByaU+oJpUwvpv8Asb8xfL2Qxkb2
 hSK+ydKYC5Eu8gi+Z/V68MUKOa0DSDY7W1wLU43TukN+U5BimPHTsP9GDmEZhHCC4e1MQx+a9vd
 dD7d0xo0edZGAm04nCC+RBPJEZBsdiq1DbMJVJN81HsudbAB8RFjN7pg7P040vRzUaHQgNfIBDg
 +VAXpohndoHvMRdoxVDBx5eD7+IbAquhJ0Mn/IMl2MbSz/sN7Nk8QtVHih+nigTxzY1jsgiSdC7
 bob3jdYUlSt8gJ/i8octpSe3U6TxKPCJRz/fvjS1Urt4KDH479EUzS3/WPB0=
X-Received: by 2002:a17:903:9cc:b0:2d3:716e:e2ae with SMTP id
 d9443c01a7336-2d74dc5f3f5mr31884195ad.6.1787869430314; 
 Thu, 27 Aug 2026 15:23:50 -0700 (PDT)
X-Received: by 2002:a17:903:9cc:b0:2d3:716e:e2ae with SMTP id
 d9443c01a7336-2d74dc5f3f5mr31883465ad.6.1787869429775; 
 Thu, 27 Aug 2026 15:23:49 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:49 -0700 (PDT)
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
Subject: [PATCH v8 099/105] configure: directly pass gdb path as a meson option
Date: Thu, 27 Aug 2026 22:15:00 +0000
Message-ID: <20260827221506.91574-100-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXxjYG8ssZ3SNJ
 3xsfiqOiYhIWd997uk/mnJhxZ3CTTxi6o7bAVzDKyN4xMA8e1cy87Ll2s0mDAKIeUjZZjMlNcvm
 50rAsMyRi8bJt7DORrPsL8zWyEnUpCGD31DcXrb6d12fYCfVoLWyhgvHexS24n9LLGjxoNmgglY
 tABvdij1EClkyC2QJyFdBxVQibqbnU4wDhUZHbLwXN96Q/qRho1Fi+o6l9C6p/yptTKvgTruSy3
 X2qWmK8l5+0McZ43Q+6aWpcpi2ghApA52BEJwwoJ/gN8nM/8+5cJmJbEfqSe+BCSjghKEqVfb7P
 cOKzZ8CWGvsRQAwJlpywLxP6arWJfyC3xuynmlCW5B+vlMXIY+aHvqZMlEoKMltCbJqTC9ueMZU
 QN/xU51r5ms0u1RN9G5V2y+OZ5OCQWG385kPWin3W9/gDvgsnSmUohc0HZB5JQk2Bdx1UtL9VJM
 0xUujrFxyvAA9t+powA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXw217PebIs5XN
 vAWS5VKO09Ic4UczY7KY8Ap/Yh/gN6Rmnh7Asc1h3IeM8Odx1+9LtQm9nnXbEk6pbly/SYfGhP+
 oI7CpNgS7qojawyAYrJXHG+HXOrjOf4=
X-Proofpoint-ORIG-GUID: NT3aDtUOWpKSuNx4hCb24L7hrIemHp86
X-Proofpoint-GUID: NT3aDtUOWpKSuNx4hCb24L7hrIemHp86
X-Authority-Analysis: v=2.4 cv=e8E2j6p/ c=1 sm=1 tr=0 ts=6a90b8f6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=aUBqqdzzR3_ZQ_oyxzcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
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

Move the remaining bit of the detection logic to meson. We can assume
gdb can be probed since gdb-9 has been published more than 6 years ago.
If ./configure --gdb is set, make sure the given program exists by using
find_program(..., required: true).

Also, using a proper meson option lists this at end of meson summary.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configure             | 22 ++--------------------
 meson_options.txt     |  2 +-
 tests/tcg/meson.build |  8 ++++----
 3 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/configure b/configure
index 259a3ca3662..e686a4e0609 100755
--- a/configure
+++ b/configure
@@ -263,8 +263,6 @@ skip_meson=no
 use_containers="yes"
 rust="disabled"
 rust_target_triple=""
-gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
-gdb_arches=""
 
 # Don't accept a target_list environment variable.
 unset target_list
@@ -738,7 +736,7 @@ for opt do
   ;;
   --rust-target-triple=*) rust_target_triple="$optarg"
   ;;
-  --gdb=*) gdb_bin="$optarg"
+  --gdb=*) meson_option_add -Dgdb="$optarg"
   ;;
   --enable-rust) rust=enabled
   ;;
@@ -870,7 +868,7 @@ Advanced options (experts only):
   --cpu=CPU                Build for host CPU [$cpu]
   --disable-containers     don't use containers for cross-building
   --container-command=CMD  which container command to use [autodetect]
-  --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
+  --gdb=GDB-path           gdb to use for gdbstub tests [autodetect]
   --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
                                is to use the whole 64-bit range).
 EOF
@@ -1121,20 +1119,6 @@ if test "$tcg" = "auto"; then
   fi
 fi
 
-#########################################
-# gdb test
-
-if test -n "$gdb_bin"; then
-    gdb_version_string=$($gdb_bin --version | head -n 1)
-    # Extract last field in the version string
-    gdb_version=${gdb_version_string##* }
-    if version_ge $gdb_version 9.1; then
-        gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
-    else
-        gdb_bin=""
-    fi
-fi
-
 ##########################################
 # big/little endian test
 cat > $TMPC << EOF
@@ -1735,7 +1719,6 @@ echo all: >> $config_host_mak
 
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
-echo "GDB=$gdb_bin" >> $config_host_mak
 if test "$container_command" != ""; then
     echo "CONTAINER_COMMAND=$container_command" >> $config_host_mak
 fi
@@ -1931,7 +1914,6 @@ if test "$skip_meson" = no; then
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$plugins" = yes && meson_option_add "-Dplugins=true"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
-  test -n "$gdb_bin" && meson_option_add "-Dgdb=$gdb_bin"
 
   run_meson() {
     NINJA=$ninja $meson setup "$@" "$PWD" "$source_path"
diff --git a/meson_options.txt b/meson_options.txt
index a07cb47d35e..d2bf5ca1f53 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -36,7 +36,7 @@ option('trace_file', type: 'string', value: 'trace',
 option('coroutine_backend', type: 'combo',
        choices: ['ucontext', 'sigaltstack', 'windows', 'wasm', 'auto'],
        value: 'auto', description: 'coroutine backend to use')
-option('gdb', type: 'string', value: '',
+option('gdb', type: 'string',
        description: 'Path to GDB')
 
 # Everything else can be set via --enable/--disable-* option
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 76f8f3e6e02..144577fd94e 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,11 +1,11 @@
 env = find_program('env')
 
 docker_wrapper = find_program('../docker/docker.py')
-gdb_progs = ['gdb-multiarch', 'gdb']
-if config_host.has_key('GDB')
-  gdb_progs = [config_host['GDB'], gdb_progs]
+if get_option('gdb') != ''
+  gdb = find_program(get_option('gdb'), required: true)
+else
+  gdb = find_program(['gdb-multiarch', 'gdb'], required: false)
 endif
-gdb = find_program(gdb_progs, required: false)
 prog_check_plugin_output = find_program('./scripts/check_plugin_output.sh')
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_record_replay = find_program('./scripts/record_replay.sh')
-- 
2.43.0


