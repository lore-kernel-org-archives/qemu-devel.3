Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB7FCD37AC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 00:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLVyg-0000el-KW; Fri, 08 May 2026 20:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyN-0000TX-CM
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyK-0005xg-Op
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:15 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648HU2mC2515326
 for <qemu-devel@nongnu.org>; Sat, 9 May 2026 00:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BJj8s2vRp8m
 9n1bJfX7JiIDpyg6+MDEeWrD16gq9sQ4=; b=OTmYcROJxohrUnEHB3ceH4NiOJd
 kWmlbYKvNWVU8sPGk+x5F1KG8mxsng61Kjd01JB29XB5j3iCw77TgCPFUJPhjuxr
 M63y8mhB3uElUogec9k87SaYx/zUnD9mBiJpCvja0uGJNvETy4/FdCW4u7zsVUCJ
 ewH3aA8QrvJ5Hb3uPatmmDDH1uw8jearFGcmbhqlhzcw28P9RucVyUepNaAh9u8F
 wMg2fl1UZUfnjx/EMIYOIdSsqPH77FdkFH8vSoQUPtWZ26afYmRHmkWRIB5NCmRQ
 ela6NdxrD0mONghFDUtQVVXtG+n8zye9ApDDSMt8w5gVlcUHPzdo/zK69Ng==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1m9ns5gf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 00:55:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2f3eb8f3419so368128eec.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 17:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778288110; x=1778892910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJj8s2vRp8m9n1bJfX7JiIDpyg6+MDEeWrD16gq9sQ4=;
 b=jVYduqesJ5Ebhoj9qNC7lF1clfDgJF+Py0OP/OSnimCPtqizkCN1XUIFkTcnlHVraz
 Vu0pe8alp5zUP1o1hIznCGDfykgXUpcxgW6T/2DcYY4H1nfPo3inuAsO9vME52NtudZs
 WoI46f+D7uBhxWjz0Al9MP2UFBN7hAT3AdbFou4Y84GWDOOzP3ZOauIXf+uQQ0p4bLEX
 6JNjkUXXQXnTbeT4N/pnoPCV/g2pi2cBPULRcsFKwaXnLsu6sSCBlrnTfOSHp4FTSHfM
 jzvgstaCybo5dwiCI/F4udY2JjHXKw00G31VyNxx+7KCc1PcZeZrLSV/wag6Shwa46Q9
 XrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778288110; x=1778892910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BJj8s2vRp8m9n1bJfX7JiIDpyg6+MDEeWrD16gq9sQ4=;
 b=mYFb2MsfSACTXCe51Ggq3iaEu5e60WNnsUYDDVRoOOYEi3yN9tmM53QGVd4P4BMBCH
 am4jfAGKNMwJVOxSKNbuSaksMsUNW2gYYJnLVHQ4p2PA2DWL67YkOqKD7SokSzH7ecK3
 nFOucI246D/h6pyKoZXGozkGdSaNYjuIqRY0luPw6Yxu5AwmA44jAidhTDebuMdo2YH5
 U8b6ZbipH9VIJHKcnItqHvx+GpdFRzJ9TagbWb8xhcBZKZZOK2IwKQfJEtjxdprDrY2g
 JIZzY1DTV52UfvYbbUxY8kGRp/ph7nfAdpsDarmir93LFNZPuuMr6erw3wruDbRs9Z4B
 b8zQ==
X-Gm-Message-State: AOJu0Yxif95PBVK7/wVgEtgD01L0Iy1tI8KrJbfDZ8gjUp/4XmkM+U6Q
 YFZQkHG1bz62mnVG4JuWakZrUvW3RDRXyhFh01v4TtWH2wPaRX2egXPy9Jseh9iks8YR36jxz0r
 JOtAu1v4c2A/rHy6XAAH7OSoCnhesUkhiHiSWuGaamOTZichi0Yq5wJfm5XVulXFPN6iq
X-Gm-Gg: AeBDieu3kB7OwSqayTlh7syNnQlHYbkS6KDri2lbdaTi5X5s91jr8iitywKHGMgwVTD
 bdXXA5nJ6ViOROFtR3MMrQTJ8G+y3Qbg5SElCEzzW65p9OGHNFaandgKzn3F52lti0cItMP0/kv
 6zq8H6FUvuWlyMJspUjh4dSHUT+cL3f/tD2xvrTdEF+9Gi8v/xIWLQMqFzfUx1QoNqAGZTE5vWY
 9jDj0d9yY7AmCrA3T9tQQ/CNi85TMYmsEaSMV2ioD55Vs11L+wbXDqrqvhsyN8+YYRXm3pHApLy
 udsjFLFHhwgzVzfffQYLs3V0BqfBoSefgDUHNnDenJrA8ykt3lpouPJQW+PcwetnRrpxuqFrLRe
 jYAOJVmCv0U1X8B1+0PnVFtYcz49qLeu0pPZXryB1BG2WD2BnYxFqa/F5bB4cotnL19fYoaG6r3
 njfFtzSg==
X-Received: by 2002:a05:7301:1014:b0:2f9:5c29:ffb6 with SMTP id
 5a478bee46e88-2f95c2a01a1mr1081890eec.13.1778288110125; 
 Fri, 08 May 2026 17:55:10 -0700 (PDT)
X-Received: by 2002:a05:7301:1014:b0:2f9:5c29:ffb6 with SMTP id
 5a478bee46e88-2f95c2a01a1mr1081868eec.13.1778288109470; 
 Fri, 08 May 2026 17:55:09 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c3b301sm5352610eec.23.2026.05.08.17.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:55:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v5 2/6] qom/object: initialize type_table in static ctor with
 fundamental QOM types
Date: Fri,  8 May 2026 17:54:49 -0700
Message-ID: <20260509005453.3984184-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DaEnbPtW c=1 sm=1 tr=0 ts=69fe85ef cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=vRPrYSdLeMI82gwj_0sA:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: VXsoXfEfP2QXoJP_vy38Lv0m-UoFQUTI
X-Proofpoint-ORIG-GUID: VXsoXfEfP2QXoJP_vy38Lv0m-UoFQUTI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAwNiBTYWx0ZWRfX4faB+z5/ookN
 CQFDfW70jcgJhGybuJfD2UiAytQAmoO1KUtSTz8wKoedOpmhtcDYCa2KufKhC/v/fUw+BDQj4/v
 OZhJVljVu8SF4JWswOytWFoyWeVm0OcLEAikigMVQwzn4Boz98SF0ewLILEc/25OUzPEAt1XUfo
 11QHr1tdlsy1QBoN3p/cpr5mukqIANtGqoYbAcKl6v2KpCrPbtwHrLt7hKvVwBXCBsjUQHSD3DU
 pWg486F2haLoNE61PW2Y1vtOY5gma9lGbEqIuRwN7Js8kE6h+U/dlUMS7lMpUjUsGLWVu+2hf81
 6jkKkM03IPvwEyULuk4FqHtoxZ0zohGQKYFyL86OzSakmvLYE3ykQRT4qa7PUIbvhl4jSZ6Rpzf
 pXixr813MZ+/8kXlif/cqr13RgeejVWG5HLDOyKfNqOcnAd6GgLaZPlMGu92A2UaYgzF9PJBcLQ
 YzD3rPyCNEC7kGtzgpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090006
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

This saves us having to check if it's initialized everytime we have to
access it. No other QOM type should be initialized or accessed during
static ctor calls, so we don't depend on their ordering.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 qom/object.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index a5d268d0722..bd48f22bb00 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -76,28 +76,19 @@ struct TypeImpl
 
 static Type type_interface;
 
-static GHashTable *type_table_get(void)
-{
-    static GHashTable *type_table;
-
-    if (type_table == NULL) {
-        type_table = g_hash_table_new(g_str_hash, g_str_equal);
-    }
-
-    return type_table;
-}
+static GHashTable *type_table;
 
 static bool enumerating_types;
 
 static void type_table_add(TypeImpl *ti)
 {
     assert(!enumerating_types);
-    g_hash_table_insert(type_table_get(), (void *)ti->name, ti);
+    g_hash_table_insert(type_table, (void *)ti->name, ti);
 }
 
 static TypeImpl *type_table_lookup(const char *name)
 {
-    return g_hash_table_lookup(type_table_get(), name);
+    return g_hash_table_lookup(type_table, name);
 }
 
 static TypeImpl *type_new(const TypeInfo *info)
@@ -1069,7 +1060,7 @@ void object_class_foreach(void (*fn)(ObjectClass *klass, void *opaque),
     OCFData data = { fn, implements_type, include_abstract, opaque };
 
     enumerating_types = true;
-    g_hash_table_foreach(type_table_get(), object_class_foreach_tramp, &data);
+    g_hash_table_foreach(type_table, object_class_foreach_tramp, &data);
     enumerating_types = false;
 }
 
@@ -2854,6 +2845,7 @@ static void __attribute__((constructor)) register_types(void)
         .abstract = true,
     };
 
+    type_table = g_hash_table_new(g_str_hash, g_str_equal);
     type_interface = type_register_internal(&interface_info);
     type_register_internal(&object_info);
 }
-- 
2.43.0


