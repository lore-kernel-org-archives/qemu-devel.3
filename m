Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D96C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZg5-00066V-7A; Tue, 28 Jul 2026 00:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfd-00054j-FD
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfa-0001eY-Fr
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:01 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aXoa1303470
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VUZ1aVawKeBWCXnaVJ8Sm/yqQ9CZWmUU2nvcueJRbwo=; b=FSn+AteLd7Ht0xuw
 +z8OtukQIM/CUSE5jpO2o30hRfQJ7BZRIYCmcn81le3Mvgh4jg7aTAZCzdfL4PAI
 xDjYOC/j+b5lIFIkEln/prEmrJY1qmRu9uowaXBPbaaaf5en9A69waFwRvV0T798
 26EhbFY585eaaGy6I0ygsj9AGDDOxVLAK1Kv7bUvSdii5JiM9w15IecmuXTJyOg/
 y+/HawUq4aJWaw59FtcPgHSl1FLk29wz0AjX6wlUnZpxQxA6vpYa/IRyi+kjmNpO
 RxPjEqq4a/y0uWHOuOwNtzOBZLWIBzLGK1zErLnzNy7xAiuhzPCx1acz+JlLPV1X
 3FnXYg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp8afsw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38827cee19eso3821826a91.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213836; x=1785818636; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VUZ1aVawKeBWCXnaVJ8Sm/yqQ9CZWmUU2nvcueJRbwo=;
 b=ZE90Wyoy/wXtw76xoLb7fmIhoKxZgf1DGM8R0+q6WlQiEI52uKw9ttXB+zPsw1onUs
 SE0X92vXgE15fTO9GA1hiB65FEzrx6efhc8mmGhZ2HDTXZ/DiXA9ZRME8PIeTYSt0QMY
 OmwKxmH5X2rTOgHVyQbryW5YfC/oos8YFKwoErPtTUYIa4OQueVtKGxugCq0vvp13kIM
 qm6mjqoNpA6gcq8pEWwzRnYVHZOLTZw2NdZ0+ZYKRFiA8VPvRnXjC1CSiG2tiKSR3hgU
 9awCy4XYHnvSOSaJGsYfL2JS6eX2vfrbCYdKl7Sye9gdGqFvu3oGIUnUVAHkP3w+or+O
 8W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213836; x=1785818636;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VUZ1aVawKeBWCXnaVJ8Sm/yqQ9CZWmUU2nvcueJRbwo=;
 b=Bm4gFEwLQef7wfsTSELUQjHQ2mFjyTIxyxRTLjuU7ZEzZpYMu8L6ipG1ZwZPKUEYiD
 nsc+DUL2MBr78LcfePBFIQUx40yo20oHnPGTqMfR3ZrlgWcasB3V5ecI8ZmL6j9o6HMp
 JdH6yk9kOy1Z/l/644Tb2wnNPOh3iYqfLWNQaW1ZUQzwNrNl21gVGcwz0Cnm+NN9B2tp
 /7uijx4V4889wAetxWIIXH7skI+LbdpIFbNZiMzeICN8X0w9EhvUZh3TgCPO1UFXFUgJ
 dbz1AfkNFGmGHemjQOoLsnTt7c7RmBC5z48hWa/kyzs2B5J/tl02VTgw6BQINhTWgLhS
 jqVg==
X-Gm-Message-State: AOJu0YyKkcg6nNMs7Czv9DLLACAY1HFs9T3EM9wg+FwBXRiq1khVYBKV
 68FPBptdF7GSKVz9vpUAbTyId5+/BbCpm1ySUwcXsX1XMbXtESBnp5LlJ7U4e4E0lkObseUnr0M
 1Qc174tewp844iWGbB8mP82Frmyr1cmMa9mlbsnAuazVN0qneIXRdsx4+egZRqZINKw==
X-Gm-Gg: AR+sD10bnmj9dR82zOhOfBz0fQ4952vuBMwkPRUA4ZsQdAd/uNxEhvWguO3dpiNJrFg
 OrBE6KpPif5ArwsgqpBwgms2VG1xQNJgMhaO5Qmh1Zi88aKyveVTKHqNGKrC/x5SoWBoak3Ozja
 wSk108WuAhXnpiUqcQlkEJudwDVVnMQdHFkLtND2+mKGKSDhFajEWy1aBYnbw8JiI7x5M05PrW0
 ClnA6TctpQiv3qLzdCe+eYhwiYWyzB4LJOipo0ZKu9ZiS2EWeL+VxcK7EqcKLoT9piGHQrSyBlm
 RP6VhM0eSKEnh1yC8WnbWzsktVDXCJzZ5OMvMEufVmLrRVIebNEPAi4r9Tx93yWIMeJmH0JrnU/
 gIqFB5bxCPI11pdHEUbjMrtVQGFSffe0L6/xtvJK2NpUvEGShscDuTdZGKS6pNO7NoeW3tqw=
X-Received: by 2002:a17:90a:d60f:b0:38e:712a:bb38 with SMTP id
 98e67ed59e1d1-38f6a425a2fmr944518a91.24.1785213836537; 
 Mon, 27 Jul 2026 21:43:56 -0700 (PDT)
X-Received: by 2002:a17:90a:d60f:b0:38e:712a:bb38 with SMTP id
 98e67ed59e1d1-38f6a425a2fmr944490a91.24.1785213836117; 
 Mon, 27 Jul 2026 21:43:56 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:55 -0700 (PDT)
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
Subject: [PATCH v6 037/103] tests/tcg/meson.build: add generic plugin tests
Date: Mon, 27 Jul 2026 21:41:41 -0700
Message-ID: <20260728044248.137626-38-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX27AwNRcpVQf9
 Z6hnRI/K60TzxSZ0vx3YAYXaxJ+4WCysp4fwDDMPCcQEt4XBiD6u8EsBm5+swSCpQtAgBgsq8Ic
 MeSdo3SdYUx3vs7oQ9/aCAxZUnyaJ/s=
X-Proofpoint-GUID: 6CH9cs6pbyCzgCOfDlyelsoesJeqhunt
X-Proofpoint-ORIG-GUID: 6CH9cs6pbyCzgCOfDlyelsoesJeqhunt
X-Authority-Analysis: v=2.4 cv=KLJqylFo c=1 sm=1 tr=0 ts=6a68338d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wqf4aQdLe3djFSc-YlYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX6iJmBioT031f
 8G4DXK9LCHxHCWd4YFsphPXbARgDZKsFPKcQSF2g8yoOrkL50lFF6VCqKnpse8uFu1db3SPahxn
 8rHL01InqOvGSUugG4/oQSUF7qsfpMhTI/IPqCTxn7ZCEpQ6sGaJPvbAfE+jdyjhuHeNS5M3eHV
 kFfkLYpZF67iIP9A15BKuFR+MboEF8e8XRIhC7/wQRSyDaQtGub+MwI743zBQv6z+Buxi8BHR1m
 85gfGwWJ4mZomguUMAWWZlukLbKGEfl/rmP/7T8uniooLdpJF4bnJ6kE5RM7IB1tpuSJclUPebS
 DGiZ2urghJQ+lZEOTNXkIDJodgEUyT4W7VIx47DHYobJ1JzoOSVJPmTYo/AFEAeFZX82f6NEuWl
 xUSirjsuY21a5LAQtV23xfU4yYbdit/PYhJGuPNni58uiomVe0WjftzF/RLLzTlFDg0W1EskIAv
 ffomg4JmOtplbqCPLDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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

We add one test for each plugin by picking a different user and system
multiarch test.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4b3a9d2fd72..3bca0de8baf 100644
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
2.47.3


