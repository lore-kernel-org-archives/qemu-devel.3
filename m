Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F011AC5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPQF-0008Fm-92; Tue, 18 Aug 2026 15:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPQD-0008EL-UN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPQC-0006kZ-BO
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:29 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHIo8r1971968
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /QL7wOLed48jpkQIUubZX+1keQHcXyLrTH24QFQQ8cM=; b=cQ91YayJ6PWzRk2m
 rk/QRK/ZAXZrdOtz3jIc68Jx3tqGvVn6MEGsbg/Jx4s/YuvzBM3dJkMvQ8Ne89gj
 siA1VrZXNch469el56C14N7tLNfOW/SfOSsvfgrhBBfjJlVK6KceI6sdAeyjVGba
 eyBJNURxIrgHyddr6szm9ainQIdD0LtL3J34PXjtHmKbuyqj8nzlxbKBTkhmA/EO
 nTVA5kNXhZvj9E4jturmHnj0gkCgQU6+ac97Uf+mX4BsHMZ4QyuWVTKsgC+qzEs4
 DIMW3PxjenB8Tei7k0GJ+t0vDDCowMKsX2YpHC3tIKEBw6pZsYb/9lHG9zjlpFkz
 pSfwQQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qyx1sdv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:13 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc15155cde2so106614a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081052; x=1787685852; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/QL7wOLed48jpkQIUubZX+1keQHcXyLrTH24QFQQ8cM=;
 b=dDXNqvaNB14DO+v+IpfOP0m3ztXkE8cnZY5j3yhjRgRdHPzHhAAwgOvwumPR6oUMV+
 BG728+pSpoJiJF95r+DVWztAWfLKyqjWUb1rhAxXkPvKf4DKZBcCgHnp1VAbQs0viV5K
 XiUWd7/j7wORw1mdzw9EOpnb7KnaxeLRp7pn0292zgQd8lRUVkrgYnf9wBwD/i5RGf6q
 t0+hg8Qdtrhl2qYh262VB/3thO13bKrJeoHJwd1M04AmNarfUmsjfCotTb6vln9/RjAS
 ZPwtwpsZpMQCTbXZAECfnn1TEBN7K04SB0ZTgCRxIfOVXoJhVXj+QKmQrMoY+Toiqd8g
 zMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081052; x=1787685852;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/QL7wOLed48jpkQIUubZX+1keQHcXyLrTH24QFQQ8cM=;
 b=r/vQVwMXC4vLBFX+oR4WZ05BybCmbc/nrlaMMZ9eFZhSTF6oetlCN+AxF5DfWqDjsA
 pmwHSps9FRMn+Icpe03NVvYU+VEl3wfqMbn0VqrHgpuXZMoF136tJ0N8w111UTPGJXwR
 oGyKsjObFcS1PJo8fJvlL4/m6FyjBBucOy9O/9g2sHrdrojidP0cTNtnEU6p950cHUgO
 +48eto/ZJIGLecVoaC7zYNBywq5fC7X6Gd9w5vzIcgunk6bPcdAm9MS4VcPHvsNAlP9X
 41IQVAMEIDPcN3g3o8aoDaHh1EM7+VNR6TjqJRUIlMcG6JvOEFb2hh5VBrYXs2Rch5DC
 S9og==
X-Gm-Message-State: AOJu0YyV/OSWE7lNcGwIIzpGCjokxcsDy6jThHQ75UVvi1ejGkBGtGh/
 vTVAlhS2iZHzOZr0MZenjsdlbfUH9dIiQQV6VyV9vujnVFYjLhAk9YuIypzZpHHgILdjY0biy2s
 vs1xKKDhcwlZas7q4rf4vFNulTXZxzQRbSghM3V7FibPBQQYiddmYY3DvW5/1QfuCUg==
X-Gm-Gg: AR+sD10J4SRUNkTFQSnOSFtSgUfkCtBo9m2Vh2Vz1FhfudRifNGwfEbFJ55Fltikmwh
 we76US79cgVV+OvefkuyNcHkbESiF0OIjnultnIfdTYmZpK/uqbIZG4sg//4iTmwvnEr766J82W
 LR7vAHJjNB+rOJwjXR79trE9zIsW40bhcXLHYSMaZC5LaLBHEzHE+Tk3N4H16aLxqzIxLpoDV76
 Ei4toObgtgqYJTXrODUEk3J/IOxumi4XkssI25eYgL+LVLuGFO3N0AUQgImSVg1NQDur9h+ZmsZ
 cOPn8ScDn1C9UgB9f4Nk4iKcDO4JwKJpK7f0udRrFyAb3f8n9wWuQ+e3BiDPVt+dkNAOTZ7a63o
 UGL11leIl8bbJU4MfVGIxf8r6soYeSE1qjE5GcCJRkQhXOyIfAiyp4D9tVIg=
X-Received: by 2002:a05:6a21:3398:b0:3c4:2cf9:28ad with SMTP id
 adf61e73a8af0-3ccfee1d275mr187007637.12.1787081051960; 
 Tue, 18 Aug 2026 12:24:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:3398:b0:3c4:2cf9:28ad with SMTP id
 adf61e73a8af0-3ccfee1d275mr186938637.12.1787081051575; 
 Tue, 18 Aug 2026 12:24:11 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:24:11 -0700 (PDT)
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
Subject: [PATCH v7 038/104] tests/tcg/meson.build: add generic plugin tests
Date: Tue, 18 Aug 2026 19:22:02 +0000
Message-ID: <20260818192309.22169-39-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX5E0fCvrwi0/8
 9Av0LK81fEMul9Qh4UlBuEWVl7Wt+gH1LYjnVTzyKqxStIlq8ipsP7FcIVJxfOB9rIJYKfeLVCw
 K0q+s7n4Nf7M8n4jpwI21TVi0NRSvMU=
X-Proofpoint-GUID: GFIrATUB_PG2mxC1SXztxBNi9P9-m6xP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXy71yhl3cU9GN
 nLqCXLKARFadE2F75vMJ52FdUDzVVg/FUubwHIt8Q986MKqIvFVE/fd9XzmER4JHkX4wD/8r5Nx
 YKAiz9FsvWUzDP+oo8SmMGIRrVu8WynN/d2lLsBNP5CKjITFNvEr4wVRWiGs7mi6Oa3OHzB6ljb
 y2YXdVNWa1VSLIgc+dMpg+DjZQtVLue0nLNgwhOFYHDrqvy905aeV3ZYI6Bu3A3HfQRjRHHP8yj
 KXVYDZwrP/cHL07ugjQUwFDkXvnRtDqJ2IVJDj8gqCNw+BNpcDfwCQrNp0yUHSTA18ui3ginDVH
 J06Iimz9RVSsTCyyAGSMpuEOHrQkGTv3XotOZgzr0H85r4hNtCnjMKj6RRizCPOLcL6LDpGEVbq
 Kg5pU10qRH8sFqRcokmOUEu4yrBiEurmc3KhZVNuxg7jkL/djWe0PhUslEKXwVgAnH46ZG1wWJ7
 ZDKSAoUGepyOejSq2hA==
X-Authority-Analysis: v=2.4 cv=Ad+B2XXG c=1 sm=1 tr=0 ts=6a84b15d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=20YfESkggsZWOKr5SEMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GFIrATUB_PG2mxC1SXztxBNi9P9-m6xP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

We add one test for each plugin by picking a different user and system
multiarch test.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 536def60b44..16292d4d7b0 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -90,6 +90,51 @@ subdir('plugins')
 # multiarch comes second, so it can be referenced by other arch after
 subdir('multiarch')
 
+# Generic Plugin tests
+# add a single test for each plugin in user/system multiarch set
+plugin_tests_exclude = ['patch']
+foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
+  plugin_tests = []
+  tests = tcg_tests[target]['tests']
+  normal_tests = []
+
+  # filter tests that are not plugin or gdb tests
+  foreach t: tests
+    foreach src, setup: t
+      if 'plugin_test' in setup or 'gdb_test' in setup
+        continue
+      endif
+      normal_tests += {src: setup}
+    endforeach
+  endforeach
+
+  idx = 0
+  foreach plugin_name, _: test_plugins
+    if plugin_name in plugin_tests_exclude
+      continue
+    endif
+
+    # pick one different test for each plugin
+    foreach src, setup: normal_tests[idx % normal_tests.length()]
+      # copy existing setup and remove existing cflags
+      new_setup = {}
+      foreach key, val: setup
+        if key == 'cflags'
+          continue
+        endif
+        new_setup += {key: val}
+      endforeach
+      new_setup += {'plugin_test': {'plugin': plugin_name}}
+      plugin_tests += {src: new_setup}
+    endforeach
+
+    idx += 1
+  endforeach
+
+  # replace list of tests with old and new ones
+  tcg_tests += {target: {'tests': tests + plugin_tests}}
+endforeach
+
 image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
-- 
2.43.0


