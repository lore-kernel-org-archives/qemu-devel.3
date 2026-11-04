Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC2606A329
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gfNLKuUp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BPIweerY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOcN1-0006PF-Rb; Wed, 04 Nov 2026 09:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOcMz-0006Nn-Fv
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:53:45 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOcMx-0003h2-AR
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:53:45 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4EHpbJ3019233
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 14:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H+2QCOFcKKLITDhHXmYsE/Z4g/ilHrukGMSmQgdwX1k=; b=gfNLKuUpRHFnjf3C
 20u0CDubYPDIF0ONSQs6M3+USjeCcrkx9H6ryzRCIGTATC2TiPAYfbknkWvgXuLT
 ESG1Mug1DkysZojRtPBsnKzMpa/ARoxZoMQuM2QQv9tYBHonuQvK9VzCA1CMW0jv
 nQJTrO5FKMD2Q3xrX9ZK9mGpYj6gMDj6OLfDesNvjLypFEo6/Ne3ei5y+9tHKLBG
 nrSIAfyo7IPp4cz2DAgUrUz3rZ9vsatHIoHlTk97LXjlYck7GWncF7mIncFo7Asy
 K6sD13UjscdIWy5vVEokUBv/Ogm/a5zGBAFvxO3y+bOixSrR79T5OsdLVXKAzr54
 A/tMEQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bj049a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 14:53:41 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cc01d48a1bso1689734137.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 06:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793804021; x=1794408821; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H+2QCOFcKKLITDhHXmYsE/Z4g/ilHrukGMSmQgdwX1k=;
 b=BPIweerYetCoannPna6hCMJjhRZqV9MvlJuDJr3x4dS6gvmEkMqqo08sPPEJn4LQ25
 a6kZPEujleohLbzfkYCqL3NlgXiVD22fJKkktZvFAEWHSOjiJhbGOalahVQ4nrYOpa+6
 F9OYSc6Rqg3o6Sr3cdRjR1jZkiUXiB4MeixSjoycVk1MRRIIfE1G97oi/DBReSzbvtlD
 6/dxt1vxNWgXwZmIdmcGYm1mH63lllNBlYtRZyzjKSNRifOhxGMZmlzocFzCZ2yVP2CC
 q3mA8cvByQP2wKXGi1+Al9t+M7VqFG4qe36WHuhquBaGqEQ/RuY3Bu3Wu5qvcZa9UoTH
 6cAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804021; x=1794408821;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H+2QCOFcKKLITDhHXmYsE/Z4g/ilHrukGMSmQgdwX1k=;
 b=QRkph/uVE0ZxLVL7G8GH8BKOoF5gPA6eVyu/Of4ovkVZ01ngH+/ugy5kQU0hvBM7Te
 kKSGCiywLH7+3R30FuwUz6QAFND335/k4yswd4W+Vt8+k3ygxlUwOuzDPCkjDk0gdyPG
 IrfEf8CoQdFeLl2SmVBf2qgp260FvDP9bfWPwWEh4ZOtLeWwQf6tpxSTGYp9D7DzNbaR
 VfxJE53xw8+m3cDn5fqCftEPSS0WQJ1nH2xl31BkWF/pwGRNeSEkw+Upy3aRFCH3kydc
 UgiMYQo/RAofNOhQra8MqJ9X1tQzw9XMO00KbCalW7rRPLA9jVODTSo/UNeIWZVvQX4V
 Jj/g==
X-Gm-Message-State: APuU4Z8I1f62n4UhOOUVCtWRjz1jf48VUAqYRgnJPe8zmFwtm5WxCr4A
 WcWDDupqFf6CrilqJyOLVeSLDAuFLGdCc4NGxS/8CGRQvwFdWpoA1bA0HeWvlGdU6eimauFU+9d
 B+XKmgt87uFgbsphMs28SISIS4GgNc5St4CZlmX07VsiIMX1yz+7oKgARbQnrzfcTwQ==
X-Gm-Gg: AYBFou1lvro6Z5UUakDU/zm/CFY4t6usvrppHYl/i+p/dxKXzvSZ1j1ayj4A2SIfZg+
 WosnMiMQ/y8lFXMEP/FWXZ4MIyC+vEdK9eQNl7SUf1nREMfgsDq+pUSsoI47Dtew4NmqYwlwfXN
 hFoLg8upHqYaKcPusbSKV3gfS/VPhZ+cB/u4+lslBmMqDLJ7feaOac3OKk/d8jHHKNX8XKQnMFq
 mGVEszZP2lqFCqIFLjPV1IEd7BgSBEGJ36YWlC8fYwQ37tCdPgWFAJcDInoXOcvtFkEEIqxZrA5
 ky4SwWv/rzzoFdIxZZQYrywUsDbSg75mggym2+MqfEMY9KrJESeLifxfZukwxCQIC+Qy+2go5Uv
 qML0nFhjTFPMuGyMMsJoNg9OUaZ8JjBfb1uMuAgyQFgoc+KElwza7U+kd+JWjeOoLw6ZJ810/c+
 RfQ/AckoqifhP+0A==
X-Received: by 2002:a05:6102:3ec9:b0:7cb:91a5:7cb1 with SMTP id
 ada2fe7eead31-7d05439aacamr5671646137.39.1793804020613; 
 Wed, 04 Nov 2026 06:53:40 -0800 (PST)
X-Received: by 2002:a05:6102:3ec9:b0:7cb:91a5:7cb1 with SMTP id
 ada2fe7eead31-7d05439aacamr5671636137.39.1793804020056; 
 Wed, 04 Nov 2026 06:53:40 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed552afcsm4324763f8f.41.2026.11.04.06.53.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 06:53:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 3/5] tests/unit: Replace deprecated sprintf() with snprintf()
Date: Wed,  4 Nov 2026 15:53:14 +0100
Message-ID: <20261104145316.18841-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104145316.18841-1-philmd@oss.qualcomm.com>
References: <20261104145316.18841-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1OSBTYWx0ZWRfX8rfEJ2ZFgCjk
 tybEbNJRSP6OWtzS3OuQDwQ00x9gnaBSmXo89aQpWQCYrC+Qqyq6KTeulilUnXs8eJ9LFuxIZc/
 QhMiIVaXPMZsBXvHoaqrqOqyshgiGON27qzgNUa7AFUA2KQ3D5QvzbgfL8VmPt2LND12zsZEav1
 cjBsEy0SyYwkjqx69s+cd3MwdPBG42ZmcOSq71WkKJhXaGlTUBGE1Z6IRW9NQ+sDalOJ6bcqdn+
 hWW2ASff0BGIPL0eK4aDmnGDaiS0uc0Mf/r5+7RCu7xdGAdf0YIK+/ggtPx2OnNnRjWoNc20s6C
 GGPz18CJxsXiUGQTbjSMAtUfY8Yrc62Gw4hPp6Mmz17EfovACBs+VjEJzXsmeEQaY95GQNVBjK5
 OtMPJmvN24kwDf7414mOJ83OcTduqcyubQDVJwjpVYTitKlvXWRu7j1gAcPApiiWv3M1sId5K/z
 4ebFlqnslCKmkUAeAUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1OSBTYWx0ZWRfX4LRSPQcntd4R
 5EKlHnGxfZcnQau0/XrqyD+FVnr2i1Lgo5NQUNNfUYfXXltJy4BMf7irl6VcVAQb1nNUsQMSgRu
 x3kAz5DuQvzXyrnLZyW4tRYTqoGH9zA=
X-Proofpoint-ORIG-GUID: LYHjRf681eRQd3PpvObk69rmoOk1J6ow
X-Proofpoint-GUID: LYHjRf681eRQd3PpvObk69rmoOk1J6ow
X-Authority-Analysis: v=2.4 cv=N/u8hG9B c=1 sm=1 tr=0 ts=6aeb46f5 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=K5v2QzCvipGKQWMlk_wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer snprintf() to avoid when using
Apple clang 17.0.0 on macOS ARM64:

  ../tests/unit/test-qobject-output-visitor.c:598:9: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/unit/test-qobject-input-visitor.c:600:9: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/unit/test-visitor-serialization.c:1031:5: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/unit/test-visitor-serialization.c:1035:13: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ...

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/unit/test-qobject-input-visitor.c  |  2 +-
 tests/unit/test-qobject-output-visitor.c |  2 +-
 tests/unit/test-visitor-serialization.c  | 19 +++++++++++--------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
index beee11db4e47..41d3dd983b3c 100644
--- a/tests/unit/test-qobject-input-visitor.c
+++ b/tests/unit/test-qobject-input-visitor.c
@@ -597,7 +597,7 @@ static void test_visitor_in_list_struct(TestInputVisitorData *data,
     for (str_list = arrs->string; str_list; str_list = str_list->next) {
         char expected[32];
 
-        sprintf(expected, "%d", i);
+        snprintf(expected, sizeof(expected), "%d", i);
         g_assert_cmpstr(str_list->value, ==, expected);
         i++;
     }
diff --git a/tests/unit/test-qobject-output-visitor.c b/tests/unit/test-qobject-output-visitor.c
index 3c47b28f6638..ff571cd91ed6 100644
--- a/tests/unit/test-qobject-output-visitor.c
+++ b/tests/unit/test-qobject-output-visitor.c
@@ -595,7 +595,7 @@ static void test_visitor_out_list_struct(TestOutputVisitorData *data,
         char expected[32];
 
         g_assert(qvalue);
-        sprintf(expected, "%d", i);
+        snprintf(expected, sizeof(expected), "%d", i);
         g_assert_cmpstr(qstring_get_str(qvalue), ==, expected);
         i++;
     }
diff --git a/tests/unit/test-visitor-serialization.c b/tests/unit/test-visitor-serialization.c
index 2d365999fc82..21755d27036b 100644
--- a/tests/unit/test-visitor-serialization.c
+++ b/tests/unit/test-visitor-serialization.c
@@ -1028,12 +1028,13 @@ static void add_visitor_type(const SerializeOps *ops)
     TestArgs *args;
     int i = 0;
 
-    sprintf(testname_prefix, "/visitor/serialization/%s", ops->type);
+    snprintf(testname_prefix, sizeof(testname_prefix),
+             "/visitor/serialization/%s", ops->type);
 
     if (ops->caps & VCAP_PRIMITIVES) {
         while (pt_values[i].type != PTYPE_EOL) {
-            sprintf(testname, "%s/primitives/%s", testname_prefix,
-                    pt_values[i].description);
+            snprintf(testname, sizeof(testname), "%s/primitives/%s",
+                     testname_prefix, pt_values[i].description);
             args = g_malloc0(sizeof(*args));
             args->ops = ops;
             args->test_data = &pt_values[i];
@@ -1043,13 +1044,14 @@ static void add_visitor_type(const SerializeOps *ops)
     }
 
     if (ops->caps & VCAP_STRUCTURES) {
-        sprintf(testname, "%s/struct", testname_prefix);
+        snprintf(testname, sizeof(testname), "%s/struct", testname_prefix);
         args = g_malloc0(sizeof(*args));
         args->ops = ops;
         args->test_data = NULL;
         g_test_add_data_func(testname, args, test_struct);
 
-        sprintf(testname, "%s/nested_struct", testname_prefix);
+        snprintf(testname, sizeof(testname),
+                 "%s/nested_struct", testname_prefix);
         args = g_malloc0(sizeof(*args));
         args->ops = ops;
         args->test_data = NULL;
@@ -1057,7 +1059,8 @@ static void add_visitor_type(const SerializeOps *ops)
     }
 
     if (ops->caps & VCAP_LISTS) {
-        sprintf(testname, "%s/nested_struct_list", testname_prefix);
+        snprintf(testname, sizeof(testname),
+                 "%s/nested_struct_list", testname_prefix);
         args = g_malloc0(sizeof(*args));
         args->ops = ops;
         args->test_data = NULL;
@@ -1067,8 +1070,8 @@ static void add_visitor_type(const SerializeOps *ops)
     if (ops->caps & VCAP_PRIMITIVE_LISTS) {
         i = 0;
         while (pt_values[i].type != PTYPE_EOL) {
-            sprintf(testname, "%s/primitive_list/%s", testname_prefix,
-                    pt_values[i].description);
+            snprintf(testname, sizeof(testname), "%s/primitive_list/%s",
+                     testname_prefix, pt_values[i].description);
             args = g_malloc0(sizeof(*args));
             args->ops = ops;
             args->test_data = &pt_values[i];
-- 
2.55.0


