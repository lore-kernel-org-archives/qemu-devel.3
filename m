Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCCBC5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPYc-00053O-2v; Tue, 18 Aug 2026 15:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYZ-0004h5-PJ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:33:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPYX-0000No-Py
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:33:07 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGjV71518077
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cgQz322bJeeYkwVMGb6DC5oc37sEFVH9HsJqqq7Gmhk=; b=L/VUbhDkY2d+OPIV
 sveuruJ0wToP3OR/RmwowYJ2BZQKd0WPNOpT0eM77Ibf2az4Cq8bwpD0zgDPZFpe
 h1JF8+J58H2zr7J5okSidynuHfbHOOJ1LD3h5V4sRqBOFCgvJGvPYFrEGKBr4Bhw
 kIITIVRtJlsap68g/r6ZqYL2qoyh/A8PcOUQ4peM1kyhteEZCsikMOaeWM54Njq6
 CqvkSC2dHxzCVRcBkX9hWVkBQNKlXH7QKX8g+xpRbBePkh/tWLbv15FtJHvNyuMZ
 xu1WYYcGAFD04VHI0gtxFnf1UqJJNFTZwAiksbKaZg3q5XnXZU30RGZ+2qVPakKp
 6j/BJg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uab0q64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:53 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84e375d9736so250700b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081573; x=1787686373; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cgQz322bJeeYkwVMGb6DC5oc37sEFVH9HsJqqq7Gmhk=;
 b=SiP3LMJYuB9XMa2D2B88yvOTTaeIXKR9QRgJRabX6O0QAAwj6BFH86AqYG7mbj+lpt
 vDGcGBT2H8aEw2VO4GRUzHmUcjSK8lzSgUfVAZSDWVVSXAUKx3AJDee18A85iEuj6InB
 nVEPXsU/9tHMcz3tM9CBBDkf/aL2OfeIJ93nx8fK0e3AHF4cfPucMh6m5uslpjeXqjQq
 ERZaT6KOUsDqQbxU/KfzZm/rxANu2Hg9YJmzX9PZKgwnuqjwLfgnaMRVnltGIGVQVgRl
 tKVC3HdIwIemwp4EgVRZn71qcqUJoq3jYZJrO36bNwPRxEBNhwJdP+larDi/KwnXnhSa
 64zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081573; x=1787686373;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cgQz322bJeeYkwVMGb6DC5oc37sEFVH9HsJqqq7Gmhk=;
 b=C0CGywAfZtaGlNAGColP+znJDS35/+VsREUtqLKvKzjG0yCXCF0IXEsipWKDUhLJNC
 LLXR6FnBCzqIVxHDnT1A0aRSF9GOafex+dfgULKLnZrxDtRmvAqZ4mkZeCAouzDip/ps
 4xTx9boIvG2Ejlh/D5IwKIXFv1fo6IDe322wMD6vFgjlwnzgrpkvI4ZCiNItBj+88Cel
 UqZUbxymx6kXOArEwRLHa5paRdUOkKMs78Ev0TdyD5kNm9f7xVBu7e3GWREEOCmsDoQ4
 ohBp5Mx7/CONR3yT712dNt6R+a8DcS+2tFEd4d4pEaaZhHwpEZBdb5rR4fsFr59Hr5F7
 AQDQ==
X-Gm-Message-State: AOJu0YzCVLTjsOLHnSQDkwS4lfM805aArdkumdKZ8PzGJZbuNPVPPsJp
 rBhk/XhXu2abyCZ0v8PBX1+16xvEQyJ8AsAei5ei7STtIRJBJEIq/6SgPCmHcZG3IH7W1c2wmRx
 r1mOu3YczEsxfvptPXbruZ6uqWY/86omMKo2hg3N8wHXjHxvB0izL3VWRe2xnt1Gprw==
X-Gm-Gg: AR+sD11qeK7UtTmjxX/77+zW9he/ZEVTMQVd3+jpi39Be5w+ELCx/1HQBnSZBYI5Edy
 2xC/UHTeb0T5WYl0L7JcXKcKO74jU/cuZmCCEpk1REsSjcpXSUYz1DFBofu1hqB/Ffr0XehOwJn
 BjRQvC8pSYbOuR9qQDwjk+geD1xY85mNe43FngI1ssS4OFvWXDFWXUNyPidgaQwanboWBOh/sTH
 ylxbj7Wyq37p81ijpiBEOAcjKRpuiiIijHox/PsyC0EoOdUhy3ErOV+3/pO12PDXved6kJSdxfW
 tyEz1CP+94gL9OUqYXrcHsDIsCE2Clb+CYkS/P4+Y3cJ0X7J0UuQM77l84vZVI1aJgEsX5dxv29
 JDaq8k1E/Uoywqj4b8GPmjcAHL95BFu6WEuIWHt1wO7lzwGHQx5cvQyIjL84=
X-Received: by 2002:a05:6a21:110:b0:3c3:c080:71ca with SMTP id
 adf61e73a8af0-3ccfef7f220mr281552637.0.1787081572565; 
 Tue, 18 Aug 2026 12:32:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:110:b0:3c3:c080:71ca with SMTP id
 adf61e73a8af0-3ccfef7f220mr281478637.0.1787081572144; 
 Tue, 18 Aug 2026 12:32:52 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:51 -0700 (PDT)
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
Subject: [PATCH v7 103/104] meson.build: add summary for TCG tests
Date: Tue, 18 Aug 2026 19:23:07 +0000
Message-ID: <20260818192309.22169-104-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX9yPzws7V50LB
 bZoXIDZzSHVKQVLsI0cVPvo2iseyUEtSp7W7Kv8wJev3PiNO482KUZ7M9eufg0i0vjfRlGCtLjw
 Zz1JIhWArwz+45sGnHpbhiEzzkESVf08DbNjSf1FyYk8OqS2C80d7avDmvy5lFyH/N1quqc2zq7
 dq9Xi6vKTHJR1KentbWyrvmVZk53jDU2HWhbd+5YJjMKc4A60hho2Ee6VcvaFHy6tDV8iE3UWwe
 hiMv0W1Et2nk/hTRxXGAUhHO3zxZl7uCPVMlmRirJAsccOn2X0wE3p9M0L2I7IArPKqyrd0vIth
 uHC0gxEIoF9OGpju8hYNqe8qW3InvX/E98w9gaFn2WnS5fN+tU/TRadyRf+Cho3P+XCVOv1Ap5b
 CP6EmmUU2u3LOO2T6uS1tWVsE42BcJAfW8Z93cS7qm0+WNJmk44i6RBav8AjufyL7zwGmsgvknJ
 t8YWs2B22qXZGfoaULA==
X-Authority-Analysis: v=2.4 cv=BvitB4X5 c=1 sm=1 tr=0 ts=6a84b365 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0WdsRCv6IZyI2kSXPrQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: hPTyup943p0_MXB2jueCkvHtrsze5FmO
X-Proofpoint-GUID: hPTyup943p0_MXB2jueCkvHtrsze5FmO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX386kjpKUFPfx
 9aM+U/m9/zMJJWPDWvaW2Jvly72dURvkkTzUUdv4OZ99x4xrHi5vxhhVb3sywiCAWt1WKMun5AF
 iLdPMRy/lZSWpLqW1b33Q0qPUIZ1riM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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

Replacing existing summary that only contained information about
existing cross compilers with a full summary for all targets.
We add gdb and container information.
We specify cc for each target (softmmu + linux-user) independently
in case we would use different cc for bare metal vs user binaries.

Users can query full command line for tests by building tests with
tcg-tests target, so no need to repeat it here.

Output before change:

$ ./configure
  Cross compilers
    aarch64                         : /path/to/qemu/build/pyvenv/bin/python3 -B /path/to/qemu/tests/docker/docker.py --engine auto cc --cc aarch64-linux-gnu-gcc -i qemu/debian-arm64-cross -s /path/to/qemu --
    aarch64_be                      : /path/to/qemu/build/pyvenv/bin/python3 -B /path/to/qemu/tests/docker/docker.py --engine auto cc --cc aarch64-linux-gnu-gcc -i qemu/debian-all-test-cross -s /path/to/qemu --
    alpha                           : alpha-linux-gnu-gcc
    ...

Output after change:

$ ./configure --disable-containers
  TCG tests
    gdb                             : /usr/bin/gdb-multiarch
    container command               : NO
    cc for aarch64-softmmu          : NO
    cc for aarch64-linux-user       : NO
    cc for aarch64_be-linux-user    : NO
    cc for alpha-softmmu            : alpha-linux-gnu-gcc

$ ./configure --gdb=gdb --container-command=podman
  TCG tests
    gdb                             : /usr/bin/gdb
    container command               : podman
    cc for aarch64-softmmu          : aarch64-linux-gnu-gcc (from 'debian-all-test-cross' container)
    cc for aarch64-linux-user       : aarch64-linux-gnu-gcc (from 'debian-all-test-cross' container)
    cc for aarch64_be-linux-user    : aarch64-linux-gnu-gcc (from 'debian-all-test-cross' container)
    cc for alpha-softmmu            : alpha-linux-gnu-gcc
    ...

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build           | 19 ++++---------------
 tests/tcg/meson.build | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/meson.build b/meson.build
index b873c46165e..2c561d58c72 100644
--- a/meson.build
+++ b/meson.build
@@ -4605,6 +4605,7 @@ subdir('docs')
 subdir('pyvenv')
 # Tests are disabled on emscripten because they rely on host features that aren't
 # supported by emscripten (e.g. fork and unix socket).
+tcg_tests_summary = {}
 if host_os != 'emscripten'
   subdir('tests')
 endif
@@ -4792,21 +4793,9 @@ summary_info += {'sparse':            sparse}
 summary_info += {'mingw32 support':   host_os == 'windows'}
 summary(summary_info, bool_yn: true, section: 'Compilation')
 
-# snarf the cross-compilation information for tests
-summary_info = {}
-have_cross = false
-foreach target: target_dirs
-  tcg_mak = meson.current_build_dir() / 'tests/tcg' / target / 'config-target.mak'
-  if fs.exists(tcg_mak)
-    config_cross_tcg = keyval.load(tcg_mak)
-    if 'CC' in config_cross_tcg
-      summary_info += {config_cross_tcg['TARGET_NAME']: config_cross_tcg['CC']}
-      have_cross = true
-    endif
-  endif
-endforeach
-if have_cross
-  summary(summary_info, bool_yn: true, section: 'Cross compilers')
+# TCG tests configuration
+if tcg_tests_summary != {}
+  summary(tcg_tests_summary, bool_yn: true, section: 'TCG tests')
 endif
 
 # Targets and accelerators
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9cf632d2717..243cdb5fc8c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -77,25 +77,30 @@ if gdb.found()
     gdb_arch_supported += {arch: true}
   endforeach
 endif
+tcg_tests_summary += {'gdb': gdb}
 
 docker_supported = false
+container_command = false
 if get_option('containers')
   if get_option('container_command') != ''
     # make sure command is working
-    cmd = get_option('container_command').split()
+    container_command = get_option('container_command')
+    cmd = container_command.split()
     run_command([cmd, 'info'], check: true)
     docker_supported = true
     docker_wrapper = [docker_wrapper, '--command',
-                      get_option('container_command')]
+                      container_command]
   else
     docker_probe = run_command(docker_wrapper, 'probe', check: false)
     docker_supported = docker_probe.returncode() == 0
     if docker_supported
+      container_command = docker_probe.stdout().strip()
       docker_wrapper = [docker_wrapper, '--command',
-                        docker_probe.stdout().strip()]
+                        container_command]
     endif
   endif
 endif
+tcg_tests_summary += {'container command': container_command}
 
 # plugins come first, as we need to build the list
 test_plugins = {}
@@ -270,6 +275,15 @@ foreach target, plan: tcg_tests
     endif
   endif
 
+  summary_cc = false
+  if has_cc
+    summary_cc = plan['cc']
+    if not cc_from_system
+      summary_cc += ' (from \'' + plan['cc_dockerfile'] + '\' container)'
+    endif
+  endif
+  tcg_tests_summary += {'cc for ' + target: summary_cc}
+
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
-- 
2.43.0


