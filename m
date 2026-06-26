Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C52C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9f-00040g-Nn; Fri, 26 Jun 2026 19:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9c-0003wd-Uc
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9b-00046r-4J
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:12 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMwmQL2209079
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RGb70iN/S6g
 59wLpkAbDsbdKWagfh72V6KAHtz9T2U8=; b=NhULt1Y19y0fAw0F4So6XrVZJjQ
 5Ni7wIExNIn5TiJKOUZdpKJ28zF9/73C3ynz70WLqLuzm2UuXNKhhuwjhRATiAAT
 qwARV2pZitD9gAYS0WMmiAaS34BRaTPCxWgSSArOFi2e1BnEZilkyb4DB+sdaNHm
 GwLzArWKJ3Yzo7Uvu9f6f8RVR8NgqRbhOZYXAkvXqt3XlXb1xaw9DWF20JTrINFs
 Eb7kMmwuqsGGFlTRZvOMDAZrkOqjN8L/IpSXMLPwB0tRv9sbyyiFGXKrH6L7Yy9E
 7iUUNGbeHs3O9sso/+9+Fne+7WoZMhPde3wUictDoMLVDM5Z2H4RwKwNpQQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1t0qt2vh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30ba395b047so4488185eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517199; x=1783121999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGb70iN/S6g59wLpkAbDsbdKWagfh72V6KAHtz9T2U8=;
 b=FwERqmnbdQthK1rga3XI9C+LUUOXzhuYIX4PKEsRRay7HCRQ2NIvlVMpdg5UJbutmk
 Nhq7hV/3bp7oyKmRYVLQ3Su+V+77BHx3Fb7iA7Yp5ou6rGzEHTS7j2F9VhlWV9ONWcad
 9DmoZB/YdAPVk/4LvvtgmQ21pWEcKNUfcI/X7jLHRMm0hTIpH6LPsjUd25ESOTvBrWgN
 +o1FGUgMRXFGmgPwPJD3EaoEUcyuY728f5KUpmq1qCqlsVvjMP0ItIF05xHTtYYybmUn
 L970fS/IHWzLkOk1rnqnl0U9ux51ALPtWcUgqb7hRROm99SOg5nmZ9FHfs+hmn9BO/l0
 eLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517199; x=1783121999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RGb70iN/S6g59wLpkAbDsbdKWagfh72V6KAHtz9T2U8=;
 b=NswU50ufZ/5dRtw6fU1Vqk9VpDT/Xeo0dlf1qM3KsFUV4pt66+q3j3VDI8VW2rKzoj
 de1+ncgl1LTiK1cAnK0An3bHD/I2VZb2YDCNzuDP18vr6nuPJshaRwzF8mUKfOmJCVO7
 WOSZqXt/tFekmsc+X82v4Eyw08koM7eQA+GYEaBuW6ZyweZgk0tIwz2TrtMKn2OyUFwD
 hnDxIpqACXVgIjLu+jQ45xTQFu22JhOUm+EydZl455n22Drb7ZDgn4vMcCINZK9YdV8W
 jWAql/VLrzGWiMhfHW2LDijDeGwvbuRn4wwrJO5pIS0QPnp+TcI2JSzh5Nz0xNTIq93Z
 yqdg==
X-Gm-Message-State: AOJu0Yxq3rZI8e05gn7HXa9XAHNCS206z2zRGdWJ2Z/dNrvOMuILJ0Yz
 wyvz25v++hsrxo+ZskX0booMp/1w79eBuRSBzBgl/tRA6tH+okD+E9qjytXyIjOs0N7HmTxGb8o
 7yEVIscKTd8hSd54/8DxP5Z4BM1pd4VujlKaXwgDhd0DLryHlRqewW71ZwUnZ7anTmA==
X-Gm-Gg: AfdE7ckKFA6lHQaq/V9JrsAvV6gUvB9K9cpZsdZzn5Hgpwg+3DwoXn+JBjRPleNvVgC
 ltxVkV9Y19vzIvN+9IfApkEjlFctB5p/FtgCW4Xdsu6mBXiSQ2I2zg3VMW6ylFfn1QV1Cp5A7L0
 +kK6XCAhi6dZA9iy8JBRlEmiw5pS3BmXXLIJdm610FeyLFhFbf+CwQSFjHxk4EqCvJNwUvFA7t4
 DPx6rq7Ymj8WOEMTCLAH3izv2bT2cM/uW0BpKRok/CpEuWJHztA0NkWkl2vgyQAbxUKARcnYq/d
 3SWf0T2Jdxfo7ow+oNgUPIc3JjvO8QmUtOKMFYiy0k4tYmD6wndyY7Pdp/vskYkvqyb5WAT/Ocx
 GZGsAfnhQwu8CINYg08u4weZ2dMAHYF4HYHFhe2CbnflFc64/5Z1brWhQTSDMySa5rjSmo7+aMT
 nbyzsN8A==
X-Received: by 2002:a05:7300:7c17:b0:2f1:6252:f8fe with SMTP id
 5a478bee46e88-30c84b94259mr8612971eec.3.1782517198913; 
 Fri, 26 Jun 2026 16:39:58 -0700 (PDT)
X-Received: by 2002:a05:7300:7c17:b0:2f1:6252:f8fe with SMTP id
 5a478bee46e88-30c84b94259mr8612952eec.3.1782517198464; 
 Fri, 26 Jun 2026 16:39:58 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 25/37] tests/tcg/multiarch: declare system tests
Date: Fri, 26 Jun 2026 16:39:06 -0700
Message-ID: <20260626233918.158740-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX5msana04G+CT
 eGsLoqhYmb4gEVdFFKps+RmbIAZw9izsieDTgfoupLN9uOYuCPqIAvxxQPL57mVIJhsvP9yt0M3
 e/itx8YwXh+lURkXHRJ5eLqiJ0u+/vw=
X-Proofpoint-GUID: W218jgww8y9gifINpVzGJkzucJMgsZDj
X-Authority-Analysis: v=2.4 cv=StqgLvO0 c=1 sm=1 tr=0 ts=6a3f0dcf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=8vYM-gic8w0O4C_0kjEA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: W218jgww8y9gifINpVzGJkzucJMgsZDj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX20xlb3Bm8Zmd
 44+H8ZjP28ZK2J5SlFSM7hk+KwMI8tGv+xwXnq9SrO9L4zUS7xdtQJuyVF3HOMa4a+dQiz3N0h8
 tUDnT5m6ZG2E8GVKllO2ty48jUCrG+bMmMtV5KIwZnddFS80mPpjBCO1VTBgjoKiTcm/G+m6gh1
 3BV7RJ3IsCjHv30dZNG5vFig3AgcxK8kwaYPISzNGe6+FJNJg1eQVBOGBic5gdyDHWkFW+wcJ+l
 ZOLrMe7962YmyNKrxMd9deZloaesaaEeyGkFHCHo1GVu1M4JbmuIFnLSN5FEE0VqmkLi3mWSL7/
 WtoKxHnQyPQJWVy+fhqpW2CXkHmAsP71r5WQsXFJ7nLeOHEceA2vVNy4XkUw7CcyLi0t+qH7s/6
 dpuQlDllLWIljxT8cSUGidxci6HD7sSvoVn3YvoyJivnnU0GgG5u5z51EsqhyYX2603DZmU9zbV
 olpX/HEFVMJ/KJvDC4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We now declare all multiarch system tests.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/meson.build        |  2 +
 tests/tcg/multiarch/system/meson.build | 53 ++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 tests/tcg/multiarch/system/meson.build

diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index 99af41b3fcc..508fdb585b7 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -1,3 +1,5 @@
+subdir('system')
+
 tests = []
 
 float_helpers = files('libs/float_helpers.c')[0]
diff --git a/tests/tcg/multiarch/system/meson.build b/tests/tcg/multiarch/system/meson.build
new file mode 100644
index 00000000000..f71c12db38e
--- /dev/null
+++ b/tests/tcg/multiarch/system/meson.build
@@ -0,0 +1,53 @@
+tests = []
+
+# multiarch src path are written to be included from any other arch folder,
+# so all arch can directly add those tests.
+multiarch = meson.current_source_dir()
+
+tests += {
+  multiarch/'hello.c': {},
+  multiarch/'interrupt.c': {},
+  multiarch/'memory.c': {},
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'gdb_test': ['--test', files('../gdbstub/memory.py')]
+  },
+  multiarch/'interrupt.c': {
+    'gdb_test': ['--test', files('../gdbstub/interrupt.py')]
+  },
+  multiarch/'hello.c': {
+    'test_name': 'untimely-packet',
+    'gdb_test': ['--gdb-args',  '-ex \'set debug remote 1\'',
+                 '--output', '/dev/stdout',
+                 '--stderr', '/dev/stdout'],
+    'wrapper': [prog_run_and_check_forbidden_output,
+                'Packet instead of Ack, ignoring it']
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'registers',
+    'gdb_test': ['--test', files('../gdbstub/registers.py')]
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'memory-access',
+    'plugin_test': {
+      'plugin': 'mem',
+      'args': ['region-summary=true'],
+    },
+    'wrapper': [prog_check_plugin_output,
+                find_program('./validate-memory-counts.py')]
+  }
+}
+
+tcg_tests += {
+  'multiarch-softmmu': {
+    'tests': tests
+  }
+}
-- 
2.47.3


