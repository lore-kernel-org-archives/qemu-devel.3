Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDCFC5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPYW-0004Mx-Et; Tue, 18 Aug 2026 15:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYL-0003wd-UY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYH-0000Mk-T7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH36R1943375
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TuIcEVryY7jvg+gzW37zxxH1icxEgR1hxUnus/SEbmM=; b=k412Zq9ifOz3zqF7
 CeXyHk7NxbIkXuRGKv2nIqpS9NIYasOuAhyC62NxQZlvgNOClZgEc+cNO9IaBoDl
 AVwu7t27KgMAlpfwMu5LZiPPGAq9hdtAjsCgtqTiIsMke7DCoG+k4B+0GbGt+UQC
 o3rcxwHdfd2D/eFs213d4TSg7jh2GUrIsLXhgHgfVMItaMFCV/IKG8jnB6OvUZ6Z
 6eo2qVYRwJOwE77HaZpRYFeS7MwJMjq0YFFAVhiTcalLfasbB1fbnICIVrX/XE7m
 lk30VggJM1o6ZVXCwOU8BVQpO3EyBgmO5XezF7bikzLr5iEaiQ5Eyx/EOQdtcpEI
 wNwsew==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4prn2801-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:48 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbedf6e8a42so170082a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081567; x=1787686367; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TuIcEVryY7jvg+gzW37zxxH1icxEgR1hxUnus/SEbmM=;
 b=ZfEsaywu4IfCHPG4VTZ8VmheEgWrmFPHxzTnKTRz9pSM+MsBJFg1iKUtNp3WS7y1UD
 8iZk9TfBN1M1LBCtJr5e9VLUqL89zgv6vIrdZ+iKqZsdxV96uEProcGtq8On6mBk9okZ
 4dmnmKdk/KpI9YnHbRHMeGBrp8hrtlKLtugbq4f4yJap8WWV8P5DOvI/NMg8l1ZV1Tcn
 nd4DfMYvo5i0bCkIMEs2QPkZ8lNSI9MJHxVeCVTe4YrwiZ/a5EwCl1aZtvIeBBomKEQD
 MMSp9RWAGcCBUwJTQPYRNQG1zlnIfRzLq57iEOMFvFRDoZ4EH+Z3SPpP+KI3amF7+1LO
 4w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081567; x=1787686367;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TuIcEVryY7jvg+gzW37zxxH1icxEgR1hxUnus/SEbmM=;
 b=l9dSwLrbMujHiqbxFNm7+PVepEEZrKbg/hpLTCjGV9brIWjQWQ3P+d7nqDLC0hYp7X
 z1JJv0gnTrkWQq6fYxDPSgc08pKJAKisfZb+1l3MP0+Kbo7JDYAhevI5aCTgA4mhQ4Jj
 fFHJBsZ2WaNi8UNi9QdHiD9jfG1R6qYwlAHJWBNYJOqxOeoEVjIbNhCWewk0yhPIan6W
 F23T+3PKaj7AbBOM/oe0FXhxGOBg9htp4+mJkfFkeH49xFAzXEesdsZi/nD8U8vIBLlf
 4jiqaOBbWbHCLDlGKPSB6MmFuKzwTpIYy8rvL+9t/6g89EmIooO+EoCLFZjTpP20ZxBi
 oJNg==
X-Gm-Message-State: AOJu0YyvGjHYz2m2GhZ7QUtOTSX8TvtiRkFF5xQow3T0krwD5Nz2pqrL
 sGN+RWXUYj7y12VIBXUZSLAqq0IWEd2ALTIQIqooPqjblZSm27sPHt9ocP1p0/JJA9Yc04V70AB
 eGmt92qDIf18hGLogVpDF3NBMAFC9/gIpqV9XfINu6M8e4qOlQk95aGNA7ly2qhoFog==
X-Gm-Gg: AR+sD13iOFvTque8rYhZO8yltYeAClcbwIQen3pWNiEKDaDedAbl/LbYPFJ7nPhZOMs
 gR1vXoyfXifeWFU2EMr14D4tb/pG8JzRILhVxxOnXf3+n5Gg35xkjvhrvnRNG9wAb6ULx82jkY1
 W6SKtBmh/z6kqNg94dYweKOlnIz+ZBG8AnZZF7ayH06xcpSoPtnuO2HHALL/O71TG1wRubm04I3
 yQiiOjtf7X/ig2hyGEn8Zw0eI0swywhEmOJ3uoEFi78ssnss2DaRuvVCxpueUtAqcUceLPvxVpO
 a+R03D55pZm+4uK5xPIo28mOe4cVK04ghUWOXM5xm1m6Y5AN8cqQWDLCL1YwTr4vJgasrYQqRo0
 BG0YTzMY6axdtvG+4YZ/kArwWgYTK19caucxECZxKW4r4lF/G4i3B35aCjEw=
X-Received: by 2002:a05:6a21:62c2:b0:3cc:faf3:331a with SMTP id
 adf61e73a8af0-3ccff5e8f23mr122709637.10.1787081567143; 
 Tue, 18 Aug 2026 12:32:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:62c2:b0:3cc:faf3:331a with SMTP id
 adf61e73a8af0-3ccff5e8f23mr122646637.10.1787081566712; 
 Tue, 18 Aug 2026 12:32:46 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:45 -0700 (PDT)
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
Subject: [PATCH v7 099/104] configure: directly pass gdb path as a meson option
Date: Tue, 18 Aug 2026 19:23:03 +0000
Message-ID: <20260818192309.22169-100-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX7pRe022hxnvI
 fvRwO+OdCALUqTxTqVHqduE86HSrb/0QSdHTQ8YwUrkmEDmQCYyP3FVmwmKQ8uTUnDMA8DWbnBE
 Zx2FHt2tEzvbBHuKWjL1mwk6xAAf5pU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXyshTJ955bLff
 CQcU+C4zB6Q3aO9N4cMuX84ocogVgAlZJNuWqGkQSut9/P8Dn7sgJ8hJDio61Nq5BwswSF/0569
 tQ1IDwk7UDVdb3f6RucVrjfKw2mjQxBF72NE/gtkFaO91XzYjpa7cEuWMq4oOSVUFyv1BYJ2w2e
 FBLZdkNdjISKnD0KoAdUqiBbvPiiFDcm1yhyKaQy/kOw8x+8ubkGXJFCsZlTWM0vsUBL/xLMUk7
 j0FSordmjGbnZYqdYtf7967FrH8zj2EhBffgLN1rWw/7tbF45WS7XaoHsVGUPISTHRpZqI/ztub
 t9YSLgP88YPn+qk5bt+wnYYhYovhFGdO4FTwtgbjao426XYHQKFiZaMXE+pyFPjeayKu2FJVe2m
 +a7ig7DvbLhdFW105rCwAq/vCrYFHxSnop0gWnY95BE+GbHYRBC/0/f3KeR3YOvufLdRbkMaSRX
 jK38jGt9n7sDRwk1B1w==
X-Proofpoint-ORIG-GUID: Dqhm1aU6lAefo-XmeToQ2lP6gh_z3KUD
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=6a84b360 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=aUBqqdzzR3_ZQ_oyxzcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Dqhm1aU6lAefo-XmeToQ2lP6gh_z3KUD
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
index 0ae20b7cdfc..06af81e18f6 100755
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
@@ -1934,7 +1917,6 @@ if test "$skip_meson" = no; then
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


