Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C60CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 18:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMrtc-0001dz-Lf; Tue, 12 May 2026 14:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrsW-0001CL-Ve
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:30:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrsU-00017E-4g
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:30:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CC4QAZ3320942
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P3hKQ9f1wEcmiWzhTST187E49tUgOgiKvr3Kl31j/+w=; b=ddB2NdXzuQMXxeop
 dc5y8y+OAlS2AhpGu1/fF291EZdoAWxKPD5CcLnixrsa4hPuKtjOpcyb1mPUkq5W
 NvAv4j29coXfVqNDGhSlLQLK85LietUXAT6GVYfX1IlmXGMgmXJrLAYaVTcO4tXz
 BGfzYiyZani8HUoH1IF+MIOISxA7g0sl7dpO/HqUQleuyECjoawlb9EVgl6SX1bp
 fjdVQGrbafJRvjTtx6KWAPtCD/ItMUSVU/HL2TG525DABSgygIhEaT5BmGGfGK5Q
 SxraZ33DM69ZtrhpjJPj+GT17Zg0mri4z+EDqSxWnAm5M8Op1Ggov8oHbxdHtJG2
 eFMl1Q==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43w1sggs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:30:44 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1334825de51so775834c88.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778610643; x=1779215443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3hKQ9f1wEcmiWzhTST187E49tUgOgiKvr3Kl31j/+w=;
 b=QpwnmOl6hrRVivB9DSL3a2MBYAAsBkDprfw6vkeVmiO9jFF8YhJycrEs8wdmUY7xDm
 WRatvdELV3SORfWaIa0KfrtHXQjlYw3gr27i+ApnhcEkN1VfHGHTCwJFs1t9QI6o9oN0
 Jxqn/DeENyDcJVLl9U0SrDNYqBeCI7D8ykeKNsRAsRrMBkF7g7VmE1YO4yiMpzz2GWHs
 ev5UB5ntRknmZTGJiwJKMSUAF/5yYReZeDiEQ0Bd0oClOf5URqC1GKzIoqtRT+ztrCFj
 YcJx4hiqdeshIMY+X1/nnw7h9fvUz5kcX9Kb4ZaIm52/e6uL2+6GVnrdHGST42Uylt51
 2b9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778610643; x=1779215443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P3hKQ9f1wEcmiWzhTST187E49tUgOgiKvr3Kl31j/+w=;
 b=d/Fl+XdK9jdpoRa+ar5SJHO9M0YIQpE8JS1VKRLP8mFByFc7C57GLXaNPQLLZsjOdD
 S4oWUWyBTazJwlWnQ/RkionbPErJOCItvxWqb5gWETcUaxupGS6BfNjq1yf39FQPAw3L
 xInzlvfToHMKZWm4FGQhC8m2Wc5mBmHzFVMt8RjT2m9DBzcV0XQU1GbaS+D6rgOUC2g+
 Q76mi7SLqLQdtfaGTuR6xYPOuJjRsB0vEu2SErklzJNrdxR8jISRuUNuzm6Br4SNjwWT
 a2PCFdpZc63WOJMpHOLE2q2LbkNNO+kwrjrmw/Lb01B9wLD6cQiMrAgDwQnT47lSp6ak
 g8gg==
X-Gm-Message-State: AOJu0YxeII7W0zT7e3gN81HmJqEQ3nqhBz+xC8Mn0W9TYtohmUva9RwR
 MxMMhyZWGXkgXdbRA5Dm6Jlb0OoEQRn9IcWuF6fIjP4skpD0fh3FHm85ep0x/OOqOldKC6HEByE
 jSo1+u3eDHpmhIZuHZQzVLiiky19VblfhrLCuI/ck/1hqFingHwgXG9k/aKGDpJQUV3vv
X-Gm-Gg: Acq92OEt5nmUl4NpQgxXlaTqugqzZB7P6oYbnWGCm8FVorOmoPc7CyIDYf/Z6CD9jkB
 ElzUIRV6XObSY8TzRPpTFJv7ciN7H28QHVaFl0RJa9wMt2ocZ1yZqOYBZpKCv16hkW/ddq+HVtn
 dBDsHO6QXEfYpE9NDc2d6PpnNd3OBTp+eIiepaQlOhsbZIZDySsQHDE6qzyzU82+o47w9uoQtif
 pBtNl+5gJDWCb38DZ/Rmh+dpSgC/qfw8rJaYZRDb6vIMXkJh89QJ843nyv28otN50Vdo4HbMWD/
 a+VKhPRbQDMW3CwsT6DctFmc09SENRPS925yfeiWiuj9pGRBZe0eM4RRUzDtCfuOTiKf67QCUhh
 LyYOnX1nG4kGOlES+XgfrD2z72jfWf+1AE4EaejLf1wgNqowhINENUZIo/7TKuE9FP9/eH0aYUA
 RiD3r3ng==
X-Received: by 2002:a05:7022:218:b0:128:d3de:c9e4 with SMTP id
 a92af1059eb24-13436aa4a35mr46512c88.30.1778610643149; 
 Tue, 12 May 2026 11:30:43 -0700 (PDT)
X-Received: by 2002:a05:7022:218:b0:128:d3de:c9e4 with SMTP id
 a92af1059eb24-13436aa4a35mr46453c88.30.1778610641825; 
 Tue, 12 May 2026 11:30:41 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327865955fsm25221376c88.11.2026.05.12.11.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 11:30:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/5] qom/object: initialize type_table in static ctor with
 fundamental QOM types
Date: Tue, 12 May 2026 11:30:27 -0700
Message-ID: <20260512183030.1431103-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AdVSXSdeOeQZvrRd7JmDeqnjlwMon9-h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE5MiBTYWx0ZWRfX4jTr/AxSt0lw
 HQlkY+7vFFHRlcRWB71K34NJMdHWtAAO+8N6K5ub0qQiSvuS8UMmhZPE522GEa7hAB90NTVxHdX
 9/K5LgVHZ2ZQJOMD2B5amZ4B7oqXxnUDGjC1rUqSemM6zpPchtOwfjR03rCg3nuZnE/pombVCZF
 GcSPZBB24HOiKOXr9shvi8UGKKDmGk1xAbqxMhSGnwKRIgsffvHtaviMFdRP2dFwNPMmbvcl6z8
 n/mJFs8h7eQqwfyxXCJmxo6dFhBvUPBcHKO+eKSBZlJXMyRMLrq5MJEH284bkiQPMrUXI/jJBKV
 Wp0dGAIQoqyMvSq5+a1ENKPkXybZViJbRFF4WSTVdDZUoON1MZjtwdHkAg61DhPl3KS+SHKKNJp
 TO/lOi09AHVQgNSlHHdQjrrpNVQdbiMftHqkG67yCaFjk8vx5kxaQr1MEPcIW7NOcQjzb+pi+WX
 q2ndYrMZ/KZSt8MgAkw==
X-Proofpoint-ORIG-GUID: AdVSXSdeOeQZvrRd7JmDeqnjlwMon9-h
X-Authority-Analysis: v=2.4 cv=BoGtB4X5 c=1 sm=1 tr=0 ts=6a0371d4 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pDBHowQsxXgegazyqkAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120192
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260512150208.1167711-3-pierrick.bouvier@oss.qualcomm.com
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


