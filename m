Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52286C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZpA-0008AF-8A; Tue, 28 Jul 2026 00:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoQ-0006af-3T
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:53:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoN-0002aS-Hf
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:53:05 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aYiE1714763
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sa6vZjnhF7g
 AA6ybTUVnWmbkmhk3J7upDqB92g4m8tM=; b=NxeUFUZlE2FaJAGXaKjwNDVTgYH
 2LiIXZnkKp3wMMdvvYYllfhjRbxJCKQKdfPolDvPeOQn8yZB/ZHzR3dyfi7kzWpe
 ++GZ9iCYwylpZpyOSy14TMwQIepETJ+iVZ7E8pbqQ8ZAxLmzjkSdqdy+dAPg38mQ
 zZe9wXrD8kjKTwW+Tisf/7Cu2BVqg0iz2Edu5yHSRgGeW+Z9+JC6Y/B6nyJstNgJ
 55D1uEN4q+T+7zrmVoE+M7fOfKHsyYSypuSYY831/gwRI1HW2Pv0qoxwMca32U4F
 GlH2aiE7SOoLiJBFZoOq5u8uJqaPA6buwYzSXNxVbVTdiAigrbV/Kt9oykA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkk02a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cee1ec30f2so43743225ad.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214371; x=1785819171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sa6vZjnhF7gAA6ybTUVnWmbkmhk3J7upDqB92g4m8tM=;
 b=WIDS0EtcsTDjeaWzWUnXalXwdRudnJHXrGZjW6ywzV7ERlC06966nue1+ctC+ZX1od
 NO1/7Sri8T7Vz0XTUXbqbVA3jeDkLdh7WVkyjweOLg0aKK9FtYJ2IHvNP/HKyu8qDpN9
 u008aU9jGMTiIGMTYTUghrYHF0TO5TNdxboWNDOM1bQWoYoxCH3U2e+BXZcrVd9AQAUP
 X+KvvcVC89yXOsAtrc9XYIbnGo3AoNW5AxYMBsRdygdznXfnxLxOI8pP893Ad0wjaHGd
 19r2e0NLC+VhOodfPmHGeunEwF3pleIvae6rDTPGj3crrQN5g/DIR8A92wa33GRAZLNA
 fXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214371; x=1785819171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sa6vZjnhF7gAA6ybTUVnWmbkmhk3J7upDqB92g4m8tM=;
 b=Dqk2MlOc8KhjVSXNMAN7L8tM+g0KTpPZ6rV1Phnj5uu0cuBcvmOfjaM4pAYoXQblsK
 IMye6kR3FI3iXzq0cRpnPzQmwTG0WGRnazaduJEBZt1fBRxvrdmciP6N/5YDBY+fR0sT
 fUa6unYa6ag1i8JNqDU+abzXSo6cjXFZev6LaIx1yKm8rqxQrnIHLsgAAori+vuUF1HJ
 GTjlMcdu0dzWFIcNfbI7bogrj9E5DnhHkW+TJX6qbpjbItJ8OhzhDxTtok4Pmns86y4f
 eJFU9RQ2XOoxDc7lla7VljH+eQohH7h8S5aGdaOw9XFDp3SIseAGXMl/2in1/leuNygd
 Z1Pg==
X-Gm-Message-State: AOJu0YzFQAcRl+7tqE9JbvglmGLoyqe/pup3gme4kR6jXkrS96ejFP6A
 FiksahDCcVSueHhcx+M5yK8ZJ9e+6S4Dcdr3F/7GvILs0w1aqaQBFNsPMJUrncU5JQtwlsvhSnH
 dhTa7BMZFJ1Ux6CBTa1H4US+pBcjo/07OX+vWQ8z3fYD0pS99vA350cqAPYwPSLnGlA==
X-Gm-Gg: AR+sD13paZEVuDg4leVHKepRvdnRKV2ODGSOAhx8jbcCx/E0ONxJDspiJj1iRfM16rU
 Z7eGVgYadFPgJb4GLtlq1YjKfhYZ8USemf/cClu4D6ZOHC4OIWbtlhjjHqP0DvnFnXq++BQeLpd
 gMVhvppLbRtcx3FD6jTF9wdSEPHh9KKVRDiRSGaIUBj0D3NWm/SbKE4YkdztGgXJvOZFzlk4Au3
 C/MFDhE/LCuX5IPtZ85rMO4sU4wSHVEbBchZ66mxMxf8qwNowj+mECt5JzAyP58gGmUQjmj2q7z
 FBx3BOmdwkfLk9aa4IFcp5grhXEnJKiPWoOFRKP1Cdymqe9C37Z2bIDSb6QTKe7o6rt/zZD1o/p
 OXdZieDWk7ZObwK0vKW7QJcXUG2g3Ip/NRQBfH/Wg/UhjLVU9/N2xSqn6Mx7cWxk9iAd0P6I=
X-Received: by 2002:a05:6a20:cc0e:b0:3c4:1c9f:d7d with SMTP id
 adf61e73a8af0-3c8ba5d8fcfmr1101683637.46.1785214371212; 
 Mon, 27 Jul 2026 21:52:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:cc0e:b0:3c4:1c9f:d7d with SMTP id
 adf61e73a8af0-3c8ba5d8fcfmr1101656637.46.1785214370729; 
 Mon, 27 Jul 2026 21:52:50 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:50 -0700 (PDT)
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
Subject: [PATCH v6 098/103] configure: directly pass gdb path as a meson option
Date: Mon, 27 Jul 2026 21:42:42 -0700
Message-ID: <20260728044248.137626-99-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 86vty8hqYff5bRgQLpbqSllgT6b3LC2D
X-Proofpoint-GUID: 86vty8hqYff5bRgQLpbqSllgT6b3LC2D
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a6835a3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=aUBqqdzzR3_ZQ_oyxzcA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX3IzBR+44d+2d
 EKOF5PninsNH1PCJEfey7IguSeqHe9YxSStCr9VtlelEJloWGrWpxyk6aPh+nll+9bh3KJBvxvY
 A5MDOTpaUON0h1iw2E6gGeFrcCsdhscnU4yrNppmdXSnxlNAa1z/vugy1Mzbqy8nL2fJIWug47L
 WpFBpIxstpM/bixyM4jfzjMVtRBcnWdTtBWVL5VfPNPuvQ2REZ1acdINf7kGxuQQAKiV2UmneKT
 59J4aGllKtKpr5C1X7OQPXB/wRqGI1FSYxySTY8gwPVzBN+tCqV5v4OEqbE09fszvT8Y7f8G3s7
 qSAldWNWBdn5n3IYloaHoXwk7N0CM6Skqs3rltdnt8vSidt7ft+FtxfEdVh5AKZiW1ETvNG9VtJ
 BpAL4aw3sLBOgk/kIfXMCJGLzpTQnQhgsNUbKoPSfCgHX9h+mSWnyaFjGFdmn8xH6Shb4y2UpZ3
 olnjZULAKv6ai+pSN9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfXwJKmxirMwzaP
 63wJNy9gIEuy6+sYapwPICfquNASuN515t2qLRgzGWLGFW0FgIKX7Vc8OWU+iyxG1F8Em5h2+0Z
 d1GYBjnvs+/TexdbMrePvEn5TJiXkxc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280042
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
index 88b2a6337bb..120634ae0b0 100644
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
2.47.3


