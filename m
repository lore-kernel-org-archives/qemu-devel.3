Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE00C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziW4-0005GB-M8; Thu, 27 Aug 2026 18:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziW2-00052R-18
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVz-0000IY-Qz
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLoWh779222
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KSqPDXpLYuygM96/fPhpbgNIelkTQQOxHTXDfAisY7c=; b=GEYNZfdo0WmqSWEA
 CYZWdacHQJJK1vgx1LER5jkr1QIRInOadd6UyCVha3D5fauTzSu1RmZd/p7ErzWp
 MwJMFAq+hA63XO6OKaX0zwmltM3HaSnONsWdzqVTYdPK1Hsv2OOJFS75j+h5ZopN
 PZVW7zI49d2Y/aYfmXFpzc2KzYaqYc1j2Vejtnn/3neN/3IPuhz7umxrxHBaep5l
 zaKcYzN2D1bbxb/UnuJ9r9T1PR3m0EyX0xAGLuCy0xZtxnaY9otx9CJxLpOATwmh
 EfEpU4rdsqz18QjZ0ZSRwV3jTG7VSWD2iqQhpI4FCOR90dftcJwKoCFimS73suw+
 uGDq4g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garee1r7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfa55c9430so1259685ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869436; x=1788474236; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KSqPDXpLYuygM96/fPhpbgNIelkTQQOxHTXDfAisY7c=;
 b=NyAzvFZvlQPAndIB5QYfpBp72Z279Q86jOKMUnCcL3fHomgwBercS1PEmeYf0mRHHF
 FD6RfGGKx+jIztfQAj5it+0h3mjqw4RlECELUYYmzlhf53a8ck+hyVmr6B64sQ3pBBlK
 SDAlCv9YDHOS0bhH5vT2rXXwH99ZpDxf0itvJwcJJwSz1rtQACmNnnWRTMDJBmpvKpc2
 K92RBdmqWJxNP0aN/1q9Z47zH28u+8+wTbTWSKKKoKi/BRV7FfMsx/cwl6XvnChFTnvd
 9DgxrHrE+3m5IviDV2BeZxU0w1dcIEf5Pk9rAFWBoiVgkNcyJXZAIMvEcb0VU9XizY/y
 B+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869436; x=1788474236;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KSqPDXpLYuygM96/fPhpbgNIelkTQQOxHTXDfAisY7c=;
 b=FFfcpcFdFRUvh6NYsB3pc+Lw6aQCcRqtkmtlS2YUFWQjeSzc4KdsTluMZy9+yQmcU6
 92MEzpSz9v2tIHiEG7FtbgIMKjuOyxv8s8q7aGZXNjKK+bzszYKeuEdq3G03zl4CPG0F
 9UQgQJMxm2NE+TV+tgAd56cdmxZ9SetiWsjPgw4y2fmW2nWb2z2qWwQFeReSOzJszVYC
 ibgG0IN/MPzxNHxQBD+1c78L9tdJBuMY+u0yWYJYDVjgGEWnmrvb0fXZPqy+q//j0Snw
 lpsDKjYIC/vWmyT016FZqLS7/4w7JT9sRNIcPz8dQW3qUNxzbS7AlWo7ebFqcj0QYMVi
 crGw==
X-Gm-Message-State: AFuF++msPrbPpZoJCyvfABs52FVQCeBh1wKdNPYYVdGbksdMm4FEuse7
 tOgELkzGtuLvSAbIU7mlSjcC1ACBLxnxJdArcrG1/WvlLF4qSNicvYeoRKLPcE9FhDR8/f7Vmuk
 Gnq+acIWaANmreSTcAclcoLkSUr5MVL9qMo8Y9sjcy7ikz9Hz/IXrRWD+WAFcVIw7wA==
X-Gm-Gg: AR+sD11mDblf6/wzD7AkJGZJp6pFV/VnjCLJkPrhKA+YQwaZ0mfSyuuEAmkUwb5Q9aI
 QHtVpxfx1T0ERa/mPky2PDBvK1qAe/l+pOfJ0bAN7fXvGDpIJIFm9vvZEW7nr0R2dL4gfwKBIuy
 7bBx/14QJ6jFTN7P61bEZqxpeuHmx5vhobZoC4uriXOPyDbrqO1UnaI8pFQjmb/HY/8hkJHMJiK
 oVS4HgFlmHp8WuDUqwJVBI9LR9cH8cvSz6OEyVuUrdtUqqRrFNYp4aRHl7hjHX9lJocrxV59STZ
 RPln9rXSsVPWQRMX8vJFbIbwtJpbRSPirpFtStcYYLJ7mPvMi90ESd1jicpZIMKI+NEoDzn9RwH
 KRSjruuucfKbYISwstrVTTvMtVYlVHwG9caLe/rtGy6LpkSA5mzY8n7ZpfhE=
X-Received: by 2002:a17:903:2d1:b0:2bf:7b62:a038 with SMTP id
 d9443c01a7336-2d74e0b118emr41588955ad.9.1787869435625; 
 Thu, 27 Aug 2026 15:23:55 -0700 (PDT)
X-Received: by 2002:a17:903:2d1:b0:2bf:7b62:a038 with SMTP id
 d9443c01a7336-2d74e0b118emr41588045ad.9.1787869435143; 
 Thu, 27 Aug 2026 15:23:55 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:54 -0700 (PDT)
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
Subject: [PATCH v8 103/105] meson.build: add summary for TCG tests
Date: Thu, 27 Aug 2026 22:15:04 +0000
Message-ID: <20260827221506.91574-104-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXxgZlmRABw1hC
 n98NgtsDMuBRTJELAcYLlQWiU1TowNS6tfl7v7S8/pMRH/NHzv2pBJw5mFTbKDelWYL7wN/S4ua
 q1ytL7Fsc6YdWyGsjTr0pPNkwRL8gYrUC4x4qj2CidY344jSBJnxE56vObn2gBDSq18ehyqNozY
 yPrMgGyqPIR5e1RW0Naxga9TX9BUzu8F98BqVECYfRFwAqNanL2u6pRp9jPWgi9z5rAcwsge8Cy
 7usg/lzwsf6COCZE4r3E0hfo0IaJmeyplymJeniiwn+3JLI6V17CZQB2AhdkHk8JbjquvdN5KPX
 AEveV3Fj351QurITJCkxLJ6ef1bWkQpmoI4ruFk+DstqORzqQKRJoBMl8A2noEqSPR4bEPZCo3c
 bW2uPxGMYf1MZzCa1HaN04HPPeRS02rmPh5rDWrgZVZ4pj4sPtR7qCwXtyzDRlZnJvJhGPMKi1e
 OBEoMLhbgUUCc1RxyrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXxw0bDn5Q9NXi
 Mf0rk+iUaTQ6fZv3HY9pmvQo3NS5ayyTFN/glXJk6cLTfWjQzt1LWr9qKqfqwhBHG4Tiq25PdBS
 DsmW0VUB9WyAk8JhqO1wbXlNPCC7QsA=
X-Proofpoint-ORIG-GUID: 9bfqO0nhM5Cg6gyDmqWhX5szjaTYJe1G
X-Proofpoint-GUID: 9bfqO0nhM5Cg6gyDmqWhX5szjaTYJe1G
X-Authority-Analysis: v=2.4 cv=e8E2j6p/ c=1 sm=1 tr=0 ts=6a90b8fc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0WdsRCv6IZyI2kSXPrQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
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
index 2c4cfffa728..b6f091750b9 100644
--- a/meson.build
+++ b/meson.build
@@ -4606,6 +4606,7 @@ subdir('docs')
 subdir('pyvenv')
 # Tests are disabled on emscripten because they rely on host features that aren't
 # supported by emscripten (e.g. fork and unix socket).
+tcg_tests_summary = {}
 if host_os != 'emscripten'
   subdir('tests')
 endif
@@ -4793,21 +4794,9 @@ summary_info += {'sparse':            sparse}
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


