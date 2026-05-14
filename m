Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8824CD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNc8q-000185-6D; Thu, 14 May 2026 15:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNc8o-00017Y-7o
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:54:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNc8m-000267-Gt
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:54:41 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpMxT3219663
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JSgbAPFcIGDs8vGV5oeap45obO/yc6s4y9TiG5F4dyg=; b=SqbjorqEziyQicVv
 ahNb8Bccg8HXzeMQPXk0x9jvzoHa8YXTfXHIUW9WRCdIbeEspeHtfXbi/GZDDj4L
 qRx0Jx3MM5wsxbF0T7jORzv6ll7EY4bl5d0KFh8dhRuXytYLtBXw4Z6dHS+jy6At
 D0L2/nkx5DhYetjXXG0mDpXfv3XX1p4wm6pxV7FAdetr/J0Edw58lSqex0XnVskY
 id1Y21zVyS9jtdXFunfaS+dfVEHoFlKxc+1KnC5LlrrGD3akQo4Rq01Xtocnw6D8
 aqlIwwx3/ysHNzsVxHig1/vdqBKzJKnmBJWz9R1osj6BUKSN9Oc4q4kuCiA4lJoh
 MvDkzg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s069a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:54:39 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c16233ee11so11594991eec.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778788477; x=1779393277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSgbAPFcIGDs8vGV5oeap45obO/yc6s4y9TiG5F4dyg=;
 b=hx3HrPgUQEo2JP5lI5uUoBtAy56MKIa6wv5zqcFYMAEWlqHf67OOLcRO7fiyIR2ek1
 nC7oJU/c2cWyss+1sxaOr029EJle5aKW/fGL4lTQOjaiTvBKw2CXpVX80PGlymyJaTQ8
 onQ6odwOPf5KYEjl7w8Vvu9js6ecqdBEnT8hwrA+t4db4hYzL4g0Foo4eUaVbRpYNnhW
 5sdvcaKrjqu+ZKXfXdhfnEVOuRtar+dNGHx/eQzhNfgFLWhXYzs1wZ8Y35LALNDhTA/y
 OlHl2GFGvLH4/UKWv+hnNDEjjLHHdIP4MzwNjqJyWJAlbzCf3+9t/vOepANFqFPeZSp0
 Kpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778788477; x=1779393277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JSgbAPFcIGDs8vGV5oeap45obO/yc6s4y9TiG5F4dyg=;
 b=sLXfBg31TlQLFJFdPDLZLwtb5sMNzNunRD0Bq44fURM0qB44zlCxrDv7DWb2P6lIYJ
 03ZboSxAwlxJSx9lZsFey6mriNMbxR4vytxN2y+k1V+cMOTfuQt3XZTfVY3m0oZLSxJp
 TwFrqD/ymeFqyr/oLDctMUntr52eNqUp6J1LLM7CMmHz/iYrEX/63ffQG8XAULPLysCX
 7SDui32yj8zL+XEcKqrucosViNDwVlF5msEC79b5xU58H4paTxEdOIHOKhvBtbbk+MS3
 qAWzI3+y4VScryP5dy1b9SI/wWP7Bu53AQWigwV7kymjqM2d2Bs5eICWbYP2SDfHknO0
 CRag==
X-Gm-Message-State: AOJu0YzFQAFn7xyhmLdhs6cUpmf7f4A6x98AQQ/UPGanqa2xKGWgdYKt
 qmgnG6qa80Iony8F/kLXFZ/7SM1ud61YJO36DFiJAQIwn2xeJ5kqRq6iHVdUWLwLJtkNhod9P55
 iC8J0jswD/toyZcCDketn/u8mo4cLw8Bp7Oupwqt6vxg2CQcjvsZ4MUxAh+8NOTFcrLXR
X-Gm-Gg: Acq92OFerNuGF81ePT3tztZV9ef5Ss6HqtBcdoubdeZYauHKl6WLlU7artWXgjZlf18
 RJSlTzs7c7S4BG+dI1sDOsVXWlJ/nw2oPIjWs+mIwsBKl0qkrprthVPJ7ANNCcFUiGj7S4VrhPh
 sazH1KmQshRpgSp1pDMMR3prCwXFIV+CIyfePR3H8azWjp7TDny/6aCkeLwB3a1HLVkgZS+gx1j
 wdbHYI2Mg+l18Xz+Isjp51fpKlzYdLFHAD/S1Yjh2s02fZhg0A9zTzSDVfiHAXz6NXvt+waSXMi
 koQqtv0CUIP7KR47Sz16HtgiDhomO7Ym9cUfF6vpqWgfSxS2G9rI7gYlzWhReRO092cSTXOVIY1
 uz486tzYJQMI1aaN31pKcvM+JfblSZhYGEK+PpMTmKBi4gMQMfNc/i6gmhj3LX7HVhwxasK8Lx0
 UMZ8ZwWw==
X-Received: by 2002:a05:693c:2c8d:b0:2d9:6373:ad0a with SMTP id
 5a478bee46e88-3039818738dmr509048eec.11.1778788476980; 
 Thu, 14 May 2026 12:54:36 -0700 (PDT)
X-Received: by 2002:a05:693c:2c8d:b0:2d9:6373:ad0a with SMTP id
 5a478bee46e88-3039818738dmr509035eec.11.1778788476482; 
 Thu, 14 May 2026 12:54:36 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bcc5asm4180636eec.22.2026.05.14.12.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 12:54:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/5] qom/object: initialize type_table in static ctor with
 fundamental QOM types
Date: Thu, 14 May 2026 12:54:24 -0700
Message-ID: <20260514195427.1706609-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NyBTYWx0ZWRfX+EWLTe470MmD
 /+V0a5Lu8NZdWpHpijTEVM/tVJEs++jwakaN+ekEh9fwvkka5lrkPN3g3mbjGLHAFyi/FkoqDef
 xMuEn+foWMwEeNeIJQP2HyPHgZWkU1d6oCYo7syF0cPs2XCTd6fZEDw3yKKyQ0xginTlCEGdVUO
 uF4tIpL0zarlGaCxRZccRptKIiFuSkmV4YstkFGLN9+9PI63x3gcGQs8ZWn74wjOYeJIAil5+LJ
 dJCHouyR9vpr8Lnpu5qBUYLvLvquq6UkosLNNlpnQ+BgJQuegYb+z+AWtVMQqLE3LIYjnKktymk
 EhQmOGNULzFrZnNqEuZkpYJ122tOTsUm/uAx0CQaekkLgJZY2P2PGTzawfHDhCrOFq3KpfLEBCz
 IqnktREdqRlijw8FaroLAdJ19nG6o0Lri3ki8zRxNn00V8/Kq8VzOHz/KA0/FPiYbVkXJQxjXhN
 N7YwB52Ha61xp37Xoeg==
X-Proofpoint-GUID: PqNHWzCvBZeCYB4eBJLsrvwXRxVVlGqv
X-Proofpoint-ORIG-GUID: PqNHWzCvBZeCYB4eBJLsrvwXRxVVlGqv
X-Authority-Analysis: v=2.4 cv=HJ7z0Itv c=1 sm=1 tr=0 ts=6a06287f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pDBHowQsxXgegazyqkAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140197
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

This saves us having to check if it's initialized everytime we have to
access it. No other QOM type should be initialized or accessed during
static ctor calls, so we don't depend on their ordering.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260514172303.1484273-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 qom/object.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index b82b65a3a18..dfdc5c8e424 100644
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
 
@@ -2859,6 +2850,7 @@ static void __attribute__((constructor)) register_types(void)
         .abstract = true,
     };
 
+    type_table = g_hash_table_new(g_str_hash, g_str_equal);
     type_interface = type_register_internal(&interface_info);
     type_register_internal(&object_info);
 }
-- 
2.43.0


