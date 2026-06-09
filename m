Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675EFCD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JL-00079U-Mi; Tue, 09 Jun 2026 17:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JF-0006zP-Is
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JC-0008G5-6b
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:33 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4iXJ3642660
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8sCHdovJieU
 TeYl+QI24+TR9ZuQPkeXd9sERHwlfW3g=; b=NSaBeHlMIP9MHxUn0QTCU+60r/s
 q2kdSnWUgsd1oi4J1dl7OpY8zSnFkobfXnqSvuUKxCqgvdaK3VfIZJgKp6DLuj4U
 5BAIhW1wj066I5AxVmwUwr/qh5DQ/igDstXHZlxmXlnYDzKL0CfA9mfgQxOIy2zR
 LwIMjCbd83NR040/C7LkKl6QgPXlptNxBK7eEJsTOQETZlMXbXcG9fEnuJJXG+x7
 aIBXLi5Aqy6RfnFSTS5lS8whwej0Sr7OhkCX9WEgmWsO3UulufWjRcuZp4tqcIWr
 k8Z6eQTmTgr3VOMJ4oBZpyJS936XQMgb+/RB75m/zhFOcMxx/FKJ0eNrbYg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epe25v1rb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:25 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13815e0e6baso5108196c88.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041704; x=1781646504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8sCHdovJieUTeYl+QI24+TR9ZuQPkeXd9sERHwlfW3g=;
 b=C8j7Esh120WwVKj5kGti3Jtyd5b2WmVaPiTAU4/Nj7zbJyrzoLbn/ewHn58QhAUs1E
 2YMZ6or4U2mtVCs3yx5FCORcsFutZaTMNQPCox4BL3iiBu0+ux1bEL7pgvHDsowapfGk
 oYfci0dQAUQsubh5o3AVclndFSB0bKPOjjJjrLjKuxhXh/EpmjKXZoFo6xQvJhdi0cnp
 T1ueSKYRf2CV9B6+62XsdMC7S/l6I+Ep4OJm3LwbrMLNuP0nqjORhbovrpXtV20PXT/F
 /kY8AUkb8/KQksldfgWyl7APBWsr9pTqtjn5EKq/zB8j1CiruJDDcm9HoxZ2I+MVODRW
 Ww5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041704; x=1781646504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8sCHdovJieUTeYl+QI24+TR9ZuQPkeXd9sERHwlfW3g=;
 b=rddpNjyKqLF4jywhR9oG1felGFulf3GKNvHPGHfdnDeat5EEpZJWHRcmo6blICSo23
 ByQ7AHe/IpuRAouU0+pXYDU4q8b4pVeK9Ww/m55EcpAlDiv/3S7qB4Yuff+SuHmQ9mmr
 SBn59Sbjje4GZsx93Sa9VJ5Eoan5cHy/wWJXZIp5hakgGfs2abOzOY+fJniiUgkAYXxC
 Gcy1nqFBFoY0shNMdYVZjYYyOb40FIMKUepGCFfI5ACDH3sc1ANXyNECJeZHXydC52U3
 ybUfeUHacFTHLSNrhPCTHqqAXqAKx76AC4HhXkZanSftn4a+tLoYASFv+gw82tEuH2LU
 SVrw==
X-Gm-Message-State: AOJu0Ywmc1M+OLwLds7cNVcQ+l6cFfnT2P4FXCx/H13PBVubJOzRnY29
 XXLlXsGCwfvEN0bOymJ51uiRYGTtiOMtAAMiJM19iyJkU1yUMj7JBOvGK7KYDKXCIWjXN6YCuFQ
 miMQWnLg/PUTqWrs00/LM0rQIDbNOx8yFPvix+IvFlOm94WBni9aKhB+7Cu7zm4EMH9CF
X-Gm-Gg: Acq92OHOrSXJ4EF9eK2Awf29Q2ZBqKYGp7+aVoT/H0iVBUkVd5tk+8fm3F5uDEHQbm9
 NdzLwAEkXHpVUj7e/MPvVcs4d5Hi6S6nFaMRpyTkAcZwZ8E+be5hoe4V/XaEy2gBGkBaho6fxFX
 xeP9JyW6r//hnloL2TezYSCnDlnhPp3m3DLGgBBRAHa/923ZCVWxki/NyN/18+OpyiUomwF8ieI
 P8GTeLCjVYBBrHRGsbc+dA5E90ZSitLjHQ+plbGDgDSMYxBtzJOLSKj1YhYXJ5ocGqWhJA4FZ+k
 imoxyTZDLDqCE2bDWi0BTJvPJwawZKZyP/aVDrZZdPfg7P9hZrw31TviAXqsdDxHc9y3S42N0D6
 Rewhoja0NWUor4cVqcN8To7l3y7rdfPyOCNkWosgFJlUwkuF5jxfZtCPndUSWYXuGey/ihdFZ/m
 Bd4H3Drj7LAEMtUtPB
X-Received: by 2002:a05:701b:4582:10b0:138:33cc:d87f with SMTP id
 a92af1059eb24-13833ccde36mr1642259c88.5.1781041704132; 
 Tue, 09 Jun 2026 14:48:24 -0700 (PDT)
X-Received: by 2002:a05:701b:4582:10b0:138:33cc:d87f with SMTP id
 a92af1059eb24-13833ccde36mr1642243c88.5.1781041703550; 
 Tue, 09 Jun 2026 14:48:23 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 27/27] tests/tcg/meson.build: add generic plugin tests
Date: Tue,  9 Jun 2026 14:47:45 -0700
Message-ID: <20260609214745.772536-28-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Bn4cgMpvjfwUHTGvF2e_V25d0aJ7V0D3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfX3teAlcpv9Ik2
 J3vZ1jTJTCouJGg9Qz5EEMOPRYrBc50Hkwxv5kXNS+Uv0AXmkXyFO2UQ7IGniTU57cryP58bK+p
 4PHytxN8LLe8jxo900EutyRVxjCB6u2aJoMsjSeDQ0n/sCKyD+iTeeWlDsNM/7MtBYQHYBZUxyB
 Jj+lwS/hYYH1MLnR3W9rvLwOcUJjt2tckzBs/VUTgNsZHzTwbN0TyJo1/G1bCiWm5Z+QdAQOJHT
 7JTYWU347ecjDWdfUB0H7QM6nz6q8/g9oT3+o4hpkhFP9IM/BrFRZRZJNFNGeez6pPr9c4294ze
 ZmfAZrn4ZLMx+M89zGg1pqb8zuoa5GEV+74bPggZQWSMWO/C8I+LqKeTuu0SVZfI3Q7JSGsxVRP
 nqAKzlnM47p5y1AI19zjhvPazNgZEOD47WrDDvneVamStGsJW7/Q7L+sxd8zgpYsgX1qzLAoMX4
 uTygFCGtPs5N6ImAbDQ==
X-Proofpoint-GUID: Bn4cgMpvjfwUHTGvF2e_V25d0aJ7V0D3
X-Authority-Analysis: v=2.4 cv=LoqiDHdc c=1 sm=1 tr=0 ts=6a288a29 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=BIqm1_bdGbE99qZVJLcA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090205
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

We finally run every multiarch test (user & system) with every plugin we
have. We can implement another strategy easily, the point here is just
to show how we can do this without impacting test definitions files.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9ec33739884..e88c018fb6e 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -70,6 +70,42 @@ subdir('plugins')
 # multiarch comes second, so it can be referenced by other arch after
 subdir('multiarch')
 
+# Generic Plugin tests - add plugin for every user/system multiarch test
+plugin_tests_exclude = ['patch']
+foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
+  plugin_tests = []
+  tests = tcg_tests[target]['tests']
+
+  foreach plugin_name, _: test_plugins
+    if plugin_name in plugin_tests_exclude
+      continue
+    endif
+
+    foreach t: tests
+      foreach src, setup: t
+        if 'plugin_test' in setup or 'gdb_test' in setup
+          continue
+        endif
+
+        # copy existing setup and remove existing cflags
+        new_setup = {}
+        foreach key, val: setup
+          if key == 'cflags'
+            continue
+          endif
+          new_setup += {key: val}
+        endforeach
+
+        new_setup += {'plugin_test': {'plugin': plugin_name}}
+        plugin_tests += {src: new_setup}
+      endforeach
+    endforeach
+  endforeach
+
+  # replace list of tests with old and new ones
+  tcg_tests += {target: {'tests': tests + plugin_tests}}
+endforeach
+
 # Now let's go through all architectures
 subdir('aarch64')
 
-- 
2.43.0


