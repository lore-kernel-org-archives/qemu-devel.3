Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D0DFF887E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 23:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHs7n-00034w-NO; Tue, 28 Apr 2026 19:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7k-00033w-0x
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7i-0000YH-06
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SFsTHi1531447
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UqvrOZA1rya
 qM8y6rfpVP8fG/TkSHRABapIXGQB4QbU=; b=NPzgSNgwwmgyUeBPJobUS8xJ16Q
 kJXG0TnGNqLKvSrO42Lo8TkoyyWDiO1DdXdV2CnlQPAG4fG9KxI9dfYvkInH0Nvi
 STJh11kYu/v4hbOnCJZo8NM8nToyE6eeQ/Puo8/Nb1MnNnQ96NEClveTORauw7Dx
 KZkV0SG2gNCGJagQ5lPgW8jz/ERMqOUph7ppFP6+0lIMmqB5TxQ4t4pjls4EXosE
 5ur3QR9LiMrFLBotzdLWBzQppi3VCI7cPpZuIpb9z5aQD+u62OZSVtsIV8mNMuQ+
 lSJGr4pPFsL09lYYJA35ETD/noVxfb0vTjy7xqsy6L7zSV6FzMTWORxA/5Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtud22qyb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:48 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2cc75e79b97so34828846eec.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 16:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777419947; x=1778024747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqvrOZA1ryaqM8y6rfpVP8fG/TkSHRABapIXGQB4QbU=;
 b=DM5leleFVOEhwcoEto9xwDCJpWBG7FbgVQsl92ITp65qmx3QsvoPYdaE0xkQttALpw
 fCARGMkq7uEixUL5IQonGSQQ5EmTcjIGs0aSUqGfMNkRWk7HdquvsYivni81zY3Puy59
 G+EcSYM0KSY2Z/WJjlWV49tT6yqU/rTtMhlfT47CRylhcGN/2iJTi+EfHbVVX+OS0gnD
 SFLWBFYWYRHKCwTyHiQMf6wgIfJe3cy/v8b7ZOMvCoGcDYfDUU0ePA0skFJQ+Ly8lkc2
 SOml3BQ36gxihLaGh/86higLz5uC8V5MKUM0VoJQYRfuOT0rlTeQiJsDby4DyAr5qyWL
 2lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777419947; x=1778024747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UqvrOZA1ryaqM8y6rfpVP8fG/TkSHRABapIXGQB4QbU=;
 b=WiJqpmicmM5AX2jeKDZhsey+nMxn5gpqWUJaAd2w38cd7bpbVQz9j19cWeII0T7UWc
 cHWWaPQMh5DFWoILnDBVy0UgPngBkYb1OKTfnTn7h6+mrO1jk4Tcs1ZzIHh8XH0BCtnT
 S1EKQCsxW03Az9IMJNg0fUNE/N4K6yBP700kPWVFIUpL7wrOpgE11PXhuNKGGvkOnPCD
 EATVHI+bBUNpENoVnf2p/9fuH2edQAD4A0tXxWMKT0UTcvRS1XaiVSwLRof9zw8JHzuA
 0M7PyJW5D3F+/TOP4lcB1XyE7Npo9uVu89KsKJadxe4Hkbo20nBqkv/SWxA3kcCTtiRE
 Pu2g==
X-Gm-Message-State: AOJu0YxntqHMDr0DjjtsguyziBMU8QwQbUGI4tKn09fPANJCVrZ7Mdfo
 Tr9ndo4BcK1vX3C17esmtGzdLzMGDeHbbCZ8TEyBOottwMMWNnOX/+eaol+Lnbw2REz5alFIgDS
 chY98E8OnnS4TrR5GhVCnC1EOMUoUecmyElQM1jqUOMIFoqM2BZjj308Ww03DGJIwkEFE
X-Gm-Gg: AeBDietirX2GayRSrMWQaP0X7p+GzQFkeve24Hi1D9abGukxWBvVVo3k65sWHCugOky
 tjJ0psyhwPnapsLQm2W+MxolXkahqx8fu1xqwmUUg3vX8ebXP4wiT5xFGtG0IU6Z2+x1YOBptud
 H5bUy6d3mY721tv7S5Rrp7BZ5ODKDP3MqPyj+qACvrakMuVdAfjGLvWr0ICF4FYciQ56iP1mj6R
 9vZelalEWMogKULS9UB/tdWQ0Jr7L8MwkMcACMyM2Krz2exHG9wN4hvf1YHBq0XjNW/U9ld+kFZ
 ARtWFBLpjyKJb5fEdp5grRg2E+w16w5VrLWu1DN1iN1eSzVswK0GhXKj/ofK8JjGxQodbxxm8Og
 IKE3YmtTxnJi8TAZCZ4CmKKY0JtXBd2Xy+vcNz8sgGBhXFKnNUjdH3QhfqVvKZUMUOpr2lCP7Er
 jEQ7aXWytBLesFzhRW
X-Received: by 2002:a05:7300:a90c:b0:2d8:c521:c157 with SMTP id
 5a478bee46e88-2ed198a26acmr724351eec.18.1777419947236; 
 Tue, 28 Apr 2026 16:45:47 -0700 (PDT)
X-Received: by 2002:a05:7300:a90c:b0:2d8:c521:c157 with SMTP id
 5a478bee46e88-2ed198a26acmr724332eec.18.1777419946679; 
 Tue, 28 Apr 2026 16:45:46 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8ddaasm345300eec.7.2026.04.28.16.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 16:45:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/6] qom/object: add object_class_get_list_by_name_prefix
Date: Tue, 28 Apr 2026 16:45:17 -0700
Message-ID: <20260428234519.1812371-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a/0AM0SF c=1 sm=1 tr=0 ts=69f146ac cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=U2icrZDLpMIrgAZKopMA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: ff0auyUDpHkZ-RpFus44qP2YjyR89GGY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDIzNCBTYWx0ZWRfX8W5Fcw8vMfIu
 a++u/Sr3eq1v0SsaogtEngMnpcd1CzdFj4xPcJUiUojgt75d/a7BQSUPN9nuaXcYwd5P/kUd+Fk
 dEC3tTpE+Z4TxSEj19TxF3EiUcGslt6C3/SPo3FikrPHCxlM3wO4FqM5jbXl/QTFm0zOjKKY6cH
 90liKGVyMOHNPpky9Rf+ns6RNuUYrNR5FC11slrhvLJPa7z8pJYdCuKX92rGwz05ZGeFYZk6I+r
 WO/SAI15dca/t9C6u2Aag4QNZusnBxnJ7WqlJTvOjJ5h/ZyTmap+sEBjzOQgA0yD4odb/zvRrsV
 2KOAfXwBj3+hELS/r0L5hsOeQAT3q2mgvzNSa64uUg5BcIvBQWUyjqyAlLYKNeWO5Gi2BOGfxnJ
 ZeypxDk5q33OMz1SYQ9Z1fNSFCDrsIDQWHnislHiP4NGwnljt9wbhhyrTWr6ZPcxHzp82XfAz7/
 0dmch8r6lZ33S/YGoAg==
X-Proofpoint-GUID: ff0auyUDpHkZ-RpFus44qP2YjyR89GGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280234
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

The existing object_class_get_list forces an initialization of all QOM
types, which triggers call to class_init for all types.
This function checks type name before initializing it.

Next commit will query list of target-info QOM types. However, some
existing classes already rely on target detection to add conditional
properties. Thus, we need to be able to initialize only target-info
types first.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qom/object.h | 13 +++++++++++++
 qom/object.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 510885218ba..a6d7b3874a7 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1033,6 +1033,19 @@ GSList *object_class_get_list(const char *implements_type,
 GSList *object_class_get_list_sorted(const char *implements_type,
                               bool include_abstract);
 
+/**
+ * object_class_get_list:
+ * @name_prefix: Name prefix for type to filter for.
+ * @include_abstract: Whether to include abstract classes.
+ *
+ * To the opposite of object_class_get_list, only matching types are
+ * initialized.
+ *
+ * Returns: A singly-linked list of the classes in reverse hashtable order.
+ */
+GSList *object_class_get_list_by_name_prefix(const char *name_prefix,
+                                             bool include_abstract);
+
 /**
  * object_ref:
  * @obj: the object
diff --git a/qom/object.c b/qom/object.c
index f981e270440..14527108a2e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1062,6 +1062,30 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
     data->fn(k, data->opaque);
 }
 
+static void object_class_foreach_match_name_prefix(gpointer key, gpointer value,
+                                                   gpointer opaque)
+{
+    OCFData *data = opaque;
+    TypeImpl *type = value;
+    ObjectClass *k;
+
+    const char *name_prefix = data->implements_type;
+    size_t prefix_len = name_prefix ? strlen(name_prefix) : 0;
+
+    if (strncmp(type->name, name_prefix, prefix_len)) {
+        return;
+    }
+
+    type_initialize(type);
+    k = type->class;
+
+    if (!data->include_abstract && type->abstract) {
+        return;
+    }
+
+    data->fn(k, data->opaque);
+}
+
 void object_class_foreach(void (*fn)(ObjectClass *klass, void *opaque),
                           const char *implements_type, bool include_abstract,
                           void *opaque)
@@ -1131,6 +1155,22 @@ GSList *object_class_get_list(const char *implements_type,
     return list;
 }
 
+GSList *object_class_get_list_by_name_prefix(const char *name_prefix,
+                                             bool include_abstract)
+{
+    GSList *list = NULL;
+
+    OCFData data = { object_class_get_list_tramp,
+                     name_prefix, include_abstract, &list };
+
+    enumerating_types = true;
+    g_hash_table_foreach(type_table_get(),
+                         object_class_foreach_match_name_prefix,
+                         &data);
+    enumerating_types = false;
+    return list;
+}
+
 static gint object_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     return g_ascii_strcasecmp(object_class_get_name((ObjectClass *)a),
-- 
2.43.0


