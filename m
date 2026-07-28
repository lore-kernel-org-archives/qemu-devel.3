Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEBDC54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZpD-00007S-7O; Tue, 28 Jul 2026 00:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoY-0006dc-0t
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:53:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoT-0002ay-Jt
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:53:11 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3bAW81062986
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tzhUo/Lgyqc
 w6MHdeyYZqV9/kIE6pkdsoGxXj2rSAxU=; b=kmy0B3J1yi/i1G22CZT5Q1oVnFo
 nRAO970Sd91sb3JMwRYvpX0dEZy5lK0G1ihaot3ksvsRDWKADkI5Imvh7gRoPapy
 9FiixTK2pV5BUaKLcj7J/oJY/IewJKBUYemG6X2w+OScDTeFP5ONyVJRu3D9zO53
 gdntJI9EtZ3l2w9fuX9PiTnn6anFPnicO1sJkpsGnwk2J9RBPdTYRwi5U5M9l0xF
 JJI0FbjF8sNWoduc56gsBM33iaEGd0X185Nl60qambf2qqiCvCJcHa7n/wE3E8Z/
 OVuC7rUkZbwPM/cn4yTBsD4ifv08ehH1topvC+BFcDMq/7w464LxTA5ypXA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v6chu7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:57 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb5bdd8450dso2364668a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214377; x=1785819177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tzhUo/Lgyqcw6MHdeyYZqV9/kIE6pkdsoGxXj2rSAxU=;
 b=WE00um+aQHZYLqbYe7+8upnOSn7Wk4FC6zNMCNh1s8nArJjKFzkVv1y5lnDAK2EXvW
 XzbUxaex9zZ9i948ZzMz24lajLUOyUGkenOOSC4KfxdhxuIoRoGeFoLO3DvhfqQdV+BK
 zd03jmCSGfAw9upLTKcl9lWywq53MVEeVlMDA/HGNaue/gQ8jqPrkGOwRKQDyFY3xpss
 L67U5NIA7ihzIPLhpUibyUWRmN9pKqtYKU4lYAfDRsaVLoafSeQvZ1kHPVfPXJL864B0
 7KTMulwNOPaPkbe3UZ/OPpF+cJbZEj4Xl6WbsxI8555dDY7hSXHWpF1AetKu8/5aUCoB
 Ygqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214377; x=1785819177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tzhUo/Lgyqcw6MHdeyYZqV9/kIE6pkdsoGxXj2rSAxU=;
 b=B25O7TA9lbpUeSF5Z8zieuChG9Y/vxirJ3ZcsjdB5pbjEFZ1Euuhnq8CCPfH93kZbp
 p2y/7JSAzj4Fe6Yi9HlQ591+1ppSxuHJUaBq2TciVcuoPQ87C+fffc/0Vkx4dXgPKu7P
 CM4nUbQAPBQyztFM9UsUi8gqrOTEmOXkH84OdGQqa6DbY5MJEpdPrOubOxyNnyRPlN4d
 oWAANIzAYnc7PjEWwBLxhm7SospAd/XEGJJFcnRNZ3nChJwn4SGygF2MhgGme6LAqtMO
 jZVegEaMeBtaJuABQKhxmJNHG3+xI7Odt6PaxBIHbNtJkxaDnyjudob/n9TNv3XyqNmn
 0qcg==
X-Gm-Message-State: AOJu0Yxng3j81cNr3yM+8Jy2eqilobqGKi39Bp2lUunfKDYrYlCuDSEK
 31hqBxZBtqgNj/Lldk6n/nAbiU4rq/XZF+r3BpcEKiGjg6Qjd7lq54ANNwDie8joA1Fx+JTwxqM
 09VnZzDPowNTXOGen6FM8pjg1gqq8hz8J+o9kZpQW37REXLgv3cMVIanhK2Og9DDdsQ==
X-Gm-Gg: AR+sD10mBNeEhLj/Hh12x1fPjp/Up3sJdorpgw4ctXGISzHJ9SCswHX9d/UCukRfkfz
 ecXv6g6D/+/8IpMQmdYVbMaNhLc4PI6//VgmgVhAO65pMMZAzjMnr/JbZkX/Hyp8+/CnNadZtI7
 qU+3xxWe0+mfpkJGSFK82laxoNKL4WjxmF7xbcV4XKCYQ4hUn+JIhMC0zcgOid0KBqCvAISGzBb
 f1207YLBJ8E248XfDrt2m9a8uMn1p4djQXtnnzFp8R8RqPwhPlEWS3jLiZF/hz7N3YtJdev5v/c
 KzAyMIghXa4xPWVqlR1EunApXA/sfbFylEibwHGa2hNv91PvXJzOOq9VfrSXFr7WyjfSTcoAq3t
 MhT6zjYoyQVdbhCb3800GYvItN+B4ir6uZe2BpQ43Q+qYdn5KcESBzd6ErXT7aJjsAnChGY8=
X-Received: by 2002:a05:6a21:7a8c:b0:3c0:9c19:b271 with SMTP id
 adf61e73a8af0-3c8ba63c8fcmr1099709637.63.1785214376746; 
 Mon, 27 Jul 2026 21:52:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a8c:b0:3c0:9c19:b271 with SMTP id
 adf61e73a8af0-3c8ba63c8fcmr1099685637.63.1785214376351; 
 Mon, 27 Jul 2026 21:52:56 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:55 -0700 (PDT)
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
Subject: [PATCH v6 102/103] meson.build: add summary for TCG tests
Date: Mon, 27 Jul 2026 21:42:46 -0700
Message-ID: <20260728044248.137626-103-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX71ECUQttCndX
 jbQjI08i5kunSX64/qQlSM2XqY7EHNuVR59mNU4uS1vl52mTVK6e1KtH7C2bUwIKCXkmm0ruJVf
 1H8UKloOHMIVFq8ccERN+QjcuEPdsNc=
X-Proofpoint-GUID: mcRAvQ2eWKXbATGe--QxY_2DnIWPXHrB
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a6835a9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=0WdsRCv6IZyI2kSXPrQA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: mcRAvQ2eWKXbATGe--QxY_2DnIWPXHrB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX5rqfmbKGz0Ff
 VDahQ9xi6aANtGJjq1wItHdNrNUcEIMWytyN+LvSLXJncO1iq1Rg4sDcrkOWF8sn6st/B1SkwUh
 NWR/F/uhSQBoOVUY4z8GyfKZD1UkYIyJORBxwJppzcBT2BDXvYzEP5iW2cUrfMiJ3H6w8HVe63k
 tIINZCNnDO/CkJ1ymf92K7lUuc+Lwb5LixiYqveboXHuzTMImtLvqvd9L1V5dwhrUbMBmZ/ej8g
 mEY2k4NbTt2EpReVo/v8llC9NUsWZPKwGzPv967eVbNqdwk/vf+yoBmcPUgtw2cvm7jCtZHPTcB
 g/8E6buKJlNThDszBLBImFt9VBpL0MmPV1oAw26071x0eODg1ZYPRZnO1w2xvRLe5Xr8+24q8B5
 PwKAMHMAmuzgh4MPsNOAvoHf5G7lITw2T400yj1soUPaIi6CmHkSE3e8qX4MSRs8pza+RigHn3F
 7Oh0TALl3Sz8X/fxZhQ==
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build           | 19 ++++---------------
 tests/tcg/meson.build | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/meson.build b/meson.build
index d59c86ab2bc..f66c466dddd 100644
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
index 8dd6623ad1d..5a634c7fdf5 100644
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
@@ -269,6 +274,15 @@ foreach target, plan: tcg_tests
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
2.47.3


