Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A00C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtj-0002wA-WF; Mon, 06 Jul 2026 18:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtI-0002jN-7G
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtC-0005Ox-8Y
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:13 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE4bs1665125
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+nARfBLk/ie
 qx4TZnBGoktfYPrws57bddrN6fArSHoQ=; b=gKx6TB9PXJZKjc8vHpIshzPiOJB
 UGggZUKFXy7UDsymFWISmQoTcT/jw+gl/1SjhbcUBE6Qqx6YPvsokrsrdTl+79ua
 pKqe1A1vqFdvE6oQ+oPZgDD0F8sbiGN4jqydfC3j4IJVbgGNPlnviiCgZ+EJIhxv
 4g9o3fafOU8Z0nYOh+JnMzNa0jgQ+TkgR7JyGWIG7WltPLgwItPdekGZb5kfuRzt
 iyWbQE+Df+HQYiZdCYLKjSGKK4Oua3Yfw68ZxpFCTl9apdyweyLm3TYCEVEjkDyV
 YQOtUXN7oUr1DxwkmM78Qm6/7PH+BY789n7E7BITpVFb6baxc1icenzo7TA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gu6d8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8895156101so5370738a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377248; x=1783982048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nARfBLk/ieqx4TZnBGoktfYPrws57bddrN6fArSHoQ=;
 b=FDSluX1jN+FPLp82E7afyW3fHfWXAXjgfG7KKX0flU817Av3GlA2Oz7I150gq5l5Te
 GF7EKxnH51WwxAal1PTYjzbw2OPFjRLSZ+1OQLqkqhysCCaTiIOncwzTXjzXxmvPofWC
 qcvAYL1B/CGxDffP55Dp/E7MeU9CZGNRMW/E5T4qZzIcRyUO2J+XndKAQ1wpwTwvsGV+
 37QtbRiryUVtvxF1OgGyJLvdGXfeTZEV++YopmYWnRgnl+/GCzO91nEhaDJeMqiJqCgg
 Aj6glragYRO/dbLRfr3yU1pFWKGB04sjxrnKR5QopJDshnRJcCnSM4Uh++/fljaH/Yr7
 asMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377248; x=1783982048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+nARfBLk/ieqx4TZnBGoktfYPrws57bddrN6fArSHoQ=;
 b=Sqbo+p9wdxC1NQwPKPbR/kLXW8rgKqnz9aT7ZvyTwybx9mCG17d5Dp9vp6XGV925R1
 tbPJMEilhjA012UXYZ/ypCBBHnH0VGSeDSQee7JvRVAJcdVe1a0iU15ktyvfuYQzMGHT
 FQ7wFMTyvh63voo3Yd5UDwGafdI0P0QQlxUX6Z0z9Uo7JaKxNRMkreXsGkklbgDwi/rX
 hRl3gruEPMxKJ3owFkq6m/kj0SdeO5bAgMHjkV2XUo8N1DZYcyLILzfBBF7/3tCydkpQ
 CBTlnvJkSBhqDbXfi81GKL5apF978+rJyN8sVB39C6AV33ZWohHv1Yo1gVT4dHD3nbs4
 i59Q==
X-Gm-Message-State: AOJu0YxuCAJNti9gIlK/jOUMJ/4drA/PyeaIYCdc23jHaGlz6fCcN2Uk
 YafKQ+2LaGdbt+zYI/3Ow3MF2cqEgcNEfNrkQ6+sNlZI8ShZMiUx42JTWyKoUuXL5CWHBHnYcR/
 KI23P1sx7DO0xKT+/psp+4ulKziZtd0IBHyWFcFUt211N7Irww8VCA+O8Q1/Yb3lQCg==
X-Gm-Gg: AfdE7cm+PMY9eeYhdxMHhLTyxVWK/Pm7flTddo9d1xDMNCuq2nXeXEnmAeaLvSLMNbi
 yOGxJ88Ngrvy5iIfqQppv5Sg98F84FS8SsDE2E9O8SREK9TRcUubYAYufpDAM6jQtBxFLPqy6yH
 cykR7TNsbZwmZGYT3Q1/Hpy2wF9a5iPd9EqNDc+K3RLBVwoWxeh4Sxphzr8my9p4yLm07Mml21z
 mi4id/f5pvVLPicFCwxByCzs/SA335CW7LqDVlo2qX22gisM2LmU7Lumu/BPMSqTLhghIrED0OD
 ERDd0W8tVLoEWeFwQ9I2EhiRxlX+rt/uw1K4AYwlmz4pYu1hzjhFrIuKI5wkF+NsrShunotmhtg
 HBpGJKkegw0lBxd5aeaffRWXVy1jBS+kyyerXtogti+j1nkAkYsWxTN89siQr9LOv+a2CSY7Rgs
 yjLksmZw==
X-Received: by 2002:a05:6a20:9184:b0:3bf:6c08:fb82 with SMTP id
 adf61e73a8af0-3c08ef675c4mr2857697637.50.1783377248052; 
 Mon, 06 Jul 2026 15:34:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:9184:b0:3bf:6c08:fb82 with SMTP id
 adf61e73a8af0-3c08ef675c4mr2857677637.50.1783377247645; 
 Mon, 06 Jul 2026 15:34:07 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 10/91] tests/tcg/plugins: build list of test_plugins
Date: Mon,  6 Jul 2026 15:32:22 -0700
Message-ID: <20260706223343.988769-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4FauqWG3aYaOsBudJfo6dqcOBWhI_QHB
X-Proofpoint-ORIG-GUID: 4FauqWG3aYaOsBudJfo6dqcOBWhI_QHB
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c2d60 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=mwllZrKobXNPg8A7wcwA:9 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX8LcjaxcrtbcV
 pIHqivdhBWdoMW8x/dv95LiripyE/n+tSDOe4rwsCsdL8Fwpyu/uuxgm8rM7Q7fRFeJyHqN0OmT
 32oUqjjej0sUl5OsQ9JzHbEWJZljexk7iQe0KQXaRqfoEfqNijCvuOOGDlXuIN6n8bx2QJLzpy5
 aNkK7r+y84CMRzV+phKkodEe1ML008uulsSkAWE1MCROrWT97Xti2OhQI3dk5nj2eSziRRtNgcx
 BjVtpG8TSVGFKuXPQOjb4tyO/XJwBMFkH+itzZHb0yNdZj23YKQE/EPtRpYd5ll6f5a+a3JXDrx
 zURTEwnVxRt/LcxEAGIRS+YXbDJQX31PfleSqL16NjAfguxhQeaStUoTyCuUS0OYDvEFcOvkoqq
 06CURUdQVri8OpoQkkXIA5ZH/hO1fI15pzmVULhDFPgBnmd727TfwkTRV4DD2QPYwyVFUEz1cGt
 SYG5+G5nK8ZOcLDP42w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX83eIu4qZoBHi
 sS0PvNBK/j1z5WdUuHT9CJD6QWLxGeckKaRcn53AYzCu4lC4wG2Rz1S3wRDX9dnM0TabPVMcJdl
 7iXO9a/jf0w+kOMgETkDl40hnga0hqs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

We previously had list of test_plugins sources, but not the target
themselves. Create this list, so tests can then reference a plugin by
its name from there.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 +
 tests/tcg/plugins/meson.build | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0acda478198..3edb525dd12 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -31,6 +31,7 @@ tcg_tests = {}
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
+test_plugins = {}
 subdir('plugins')
 
 # Finally, we can create all test executables and test targets
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index d7f8f0ae0ad..2abc317d1e7 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,4 +1,4 @@
-test_plugins = [
+test_plugins_src = [
 'bb.c',
 'discons.c',
 'empty.c',
@@ -14,9 +14,12 @@ test_plugins = [
 
 t = []
 if get_option('plugins')
-  foreach i : test_plugins
-    t += shared_module(fs.stem(i), files(i),
-                       dependencies: plugins_deps)
+  foreach i : test_plugins_src
+    name = fs.stem(i)
+    plugin = shared_module(name, files(i),
+                           dependencies: plugins_deps)
+    t += plugin
+    test_plugins += {name: plugin}
   endforeach
 endif
 if t.length() > 0
-- 
2.47.3


