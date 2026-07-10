Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC36C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4lF-00061l-Re; Fri, 10 Jul 2026 02:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lD-0005zT-KD
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:30:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lB-000744-WC
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:30:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n6st3661819
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JmYuAnlurkf
 AsXbjMhREVU3TTPhkVPVawUzrQ+fKvEc=; b=fPBkMhmgv+8vGFFYWECmmHViRYq
 shbEZUIvilD+OZQe/gFRPZkElE3acVxrC8cuUNdzqavURE0UWT2mUeTLEpJg+2rf
 dH1vCM83P6uLIzl/wZjgGlimD7ShOKFxH11csfFKpVUlvGCFQ47Z6WNFmCSuKK4G
 XB+nPTEW3CYbiMzoKTD74qU4MthixN4rl7t7F5ws4LZ+5r0TomaLYiWu88MITMNe
 gyTo0gclfWoceZaftFeUBAibADmhm7CRi2/MG++Ljwjg8g8jh2PIziuXau2ID9HK
 MQrKFHe6kVsRnJqjghEyEiO45kQDFo7Bo+rKVIe+yEmLjBk2MqEToxJEpDw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24txa4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:30:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so751506a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783665052; x=1784269852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JmYuAnlurkfAsXbjMhREVU3TTPhkVPVawUzrQ+fKvEc=;
 b=Z+/sFqfBQGMC4mvzzN5dziuMiZX5Q8KznQfyGg7VSZkCNdVdJiuW/0+GV2mvC983lp
 BdA6OoXDqr7d/2e7o2Nr6+uS+PjkzEJZimNit2Sb3TjQNjnvgPh0QDu92mntQo0A6dQL
 bxiIPdTvS2lPUV4ilYJ0g4o3ygISGw2NZ045QhEzPfDivDFwLhrPnWPXcGV7IAi3BE4G
 YOy9DNUTn759DKoRTpqVU/nW16MvcMFtlMMWkeOqtreMUJI77/PvVVaLn93b5Ku75yEt
 h6Ue7YgPlSErPFQJk8WH3Z9yJHjgoTRHD9YvhpNY5bxOQ5xRc8xVurty+4oLondee0SL
 eQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665052; x=1784269852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JmYuAnlurkfAsXbjMhREVU3TTPhkVPVawUzrQ+fKvEc=;
 b=szWLP2Rh855hRUyb254nwasCCaRebrRS3cBrpELRiS0AtvW570S5HGCNXvSI0XvIda
 cifLGm1baSWloBJTFo9OqjaKHaCSLUHeYyY12YjsXZk1SyiSo4yGEtYF0J8BUORPcVy3
 2l1ekKE0JOJvqrDyV7nzQI1joHMILVVEUXtn6D5w/kaWJsNBfYRzsNm2fTJdfgYVKoCT
 r875om/MwZyW8AKmvynV1B8C13vT66d8yUsrkNTeL+YPNp2Sp7XY4U0oHGdG1slwfbBr
 KM1I4EB8qwN+J5NDM+9A5qsKPua9bOe+MlICnGTbCHU0C0b9jlj/lgnU/Io1k9fjVcII
 lfLQ==
X-Gm-Message-State: AOJu0YzU7xRts/uFaLco0SAZ8/PYaH6lCI3Ccyb39gtYJeq1sAZBTek+
 /KmgIH22Y6cgYAL00zpKLz6yMueylcoRUj3NIe0qklunSVyljDl6YhG+rG1hg7MAzytxfPmednp
 4Lo03TzYVXABuy4/siXQg2xabxTNRsg6aDQC9o6fmdqDZa2h4hSo5YX5+2ZzmOLNeQg==
X-Gm-Gg: AfdE7cnC7amIIKGsIva5y5pzvwhNlOuaj95W8GhVCv+eF3O5CQf7cPRi4VqqAgEgHYe
 HkXbIBeZhmjeiL3KTiPaHRdsVIVUTlclc3GVbgfK1CuPFk9hHXriKzCpKcPUDqz+PNtynFWe+6t
 9p6db3hU7f/qrMk3cDzXOr1sprrsfaQL0hj4FFrbH41CqZqrTEahkG6PZPN9R9ThOoajLmQZpRz
 hH7ElbxylhGbJLHNBJDXulO9OjLOJApJceCaKLkvf0bJSeG/XbWOaYUb06nbit6Yb0GoAOsKSML
 VpCFccWM70n6xGrj7zRzfZ/f6ybPTtEsFCRNrFOYtaTLu0llfrUbhzZcbdptK4+23Q0YtF0ErWc
 tSfRe98dz5YWo69ADPf/XmfQ9o+RefGlJN1mZtCCSpKpYtLHzdkQYQhJUOizsUYvP9ciytOfr95
 eFjmg2aQ==
X-Received: by 2002:a05:6a20:6a21:b0:3c0:9c1a:8939 with SMTP id
 adf61e73a8af0-3c0bccbae8emr12236280637.65.1783665051974; 
 Thu, 09 Jul 2026 23:30:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a21:b0:3c0:9c1a:8939 with SMTP id
 adf61e73a8af0-3c0bccbae8emr12236240637.65.1783665051467; 
 Thu, 09 Jul 2026 23:30:51 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm6258960eec.15.2026.07.09.23.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:30:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 83/97] tests/tcg/s390x: system tests
Date: Thu,  9 Jul 2026 23:20:01 -0700
Message-ID: <20260710062016.1818125-84-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: s7TJBgzLUlopSg6eWJYRjKzP7APlStvD
X-Proofpoint-ORIG-GUID: s7TJBgzLUlopSg6eWJYRjKzP7APlStvD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX7GTeH3/mqdyL
 INOGpaGSkpyzUdsNsEjEm6WXBv//g7SLNIFEewPb/88W27DGqLCdrQ97CwGMrEShuo2CCG33JZk
 86lICYPpn3X0vbe8vlHAD25R7QYFzjU=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a50919d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=sup0HnWOECoxuvPl1CIA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfXxKRsC4N9hqmu
 6xKq1QI658XvChFj/nwQpe7FWdLX2k/7E0qj09VEHPHjkMqIYyCdsNYWAyzpPHYQrELLQ5QGTLF
 JzHsjQ0cEwKJeAW2f92FFrXk0Lgf3JDlU5wMd/jSdsxdxO3WX3/Fhb8fbfG7wIQJi61z0tR0X2Z
 vP3chVxOnC0FKOUMDQKNoUETimgRvuxOJGVrxGm2jRDQ+L2GbPHzlekanQbI3EiSiAtg5+RQN93
 hm7pA3ZVh0s+Ep3uedXCjjEiZ7mzusj03k2Hk5s7aQf/JjRO0LgCSFptxAmTI14fuFUc1JjaT10
 G8oDsyQ3jKaPvmEfxbIp47eKttjZ/Vnext9X+8LKE18Yt6AYThHcQ/CXKm2Wk8euf+gY7lfYOy6
 nQfGmqaA46Dn4syZa3MW37ZAOQPhLAfnP7QpBWtGet7vtSczMA4ceKqrloNe5i+XPa/O4mcp1Ww
 tZPUAelXxhRCUkvaCvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100060
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/s390x/meson.build        |  2 +
 tests/tcg/s390x/system/meson.build | 90 ++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 tests/tcg/s390x/system/meson.build

diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index 3adb7dc464c..d614531ca61 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -21,6 +21,8 @@ tests_s390x_pgm = [
   'strl-unaligned.S',
 ]
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
new file mode 100644
index 00000000000..041fe83e382
--- /dev/null
+++ b/tests/tcg/s390x/system/meson.build
@@ -0,0 +1,90 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('../softmmu.ld')[0]
+head64 = files('../head64.S')[0]
+console = files('../console.c')[0]
+ipl_inc = meson.project_source_root()/'include'/'hw'/'s390x'/'ipl'
+cflags = ['-nostdlib',
+          '-I', minilib_dir, minilib_printf,
+          '-I', ipl_inc,
+          '-march=z13',
+          head64, console]
+asmflags = ['-nostdlib',
+            '-Wl,-T', link_script, '-Wl,--build-id=none',
+            '-march=z13', '-Wa,--noexecstack']
+qemu_args = ['-display', 'none',
+             '-action', 'panic=exit-failure',
+             '-serial', 'stdio',
+             '-kernel']
+
+# Multi arch tests - add cflags only once per src
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if 'test_name' in setup and setup['test_name'] == 'memory-access'
+      # s390x clears the BSS section so we need to account for that
+      # ./validate-memory-counts.py --bss-cleared
+      setup += {'wrapper': setup['wrapper'] + '--bss-cleared'}
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_args}}
+  endforeach
+endforeach
+
+tests += {
+  'mvc-smc.c': {'cflags': [cflags], 'qemu_args': qemu_args},
+}
+
+setup_asm = {'cflags': [asmflags], 'qemu_args': qemu_args}
+tests += {
+  'bal.S': setup_asm,
+  'cksm.S': setup_asm,
+  'clm.S': setup_asm,
+  'exrl-ssm-early.S': setup_asm,
+  'icm.S': setup_asm,
+  'sam.S': setup_asm,
+  'lpsw.S': setup_asm,
+  'lpswe-early.S': setup_asm,
+  'lra.S': setup_asm,
+  'mc.S': setup_asm,
+  'per.S': setup_asm,
+  'precise-smc-softmmu.S': setup_asm,
+  'sckc.S': setup_asm,
+  'ssm-early.S': setup_asm,
+  'stosm-early.S': setup_asm,
+  'stpq.S': setup_asm,
+  'unaligned-lowcore.S': setup_asm,
+}
+
+foreach src: tests_s390x_pgm
+  tests += {
+    src: {
+      'cflags': [asmflags, files('../pgm-specification-softmmu.S')],
+      'qemu_args': qemu_args,
+    }
+  }
+endforeach
+
+if 'qemu-system-s390x' in emulators
+  tcg_tests += {
+    's390x-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 's390x',
+      'gdb_arch': 's390x',
+      'qemu': emulators['qemu-system-s390x'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


