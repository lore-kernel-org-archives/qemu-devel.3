Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6504FCD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNZmN-0003c1-GJ; Thu, 14 May 2026 13:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZmK-0003bJ-0i
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:23:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZmH-0005iT-Fw
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:23:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBePCT1717706
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ulGAOE8HbLb/p8WT3p/HywicgLKOLlWLTHZNeMydSXg=; b=AoQaPHvhieiEeN7/
 yEWBcJEM9Umiko/6qXpq5wETh0l+neq8sjNqN9Ezoj4RON8lGXdz1OxTrgKUyL62
 E2rP4hQYjk+WrQsv0cZB3h3LMOn1AqBa1AtaWnhe2k/GKVDFJ9Cd9Wk72cCkvEFN
 3tyT9JcCRMQlIAJkrPC/Nghfr3F4Ue7dfWUtr4wAHZOjVlnIooXi6u99joCJ72be
 qfxDUydNdyncmRb/FIEQmjSp/AJggE49W/j98XlJFUSW9/R3jJ6Y0aXpvv4dOG7X
 +4tr/wKHM1g9BWzdMWNlpLCD3nfh5RL0gqB9Q1F30cQNoWdQPURMw8m23H2NVexS
 2JM1zQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57y7jn3u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:23:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2f485961555so25511007eec.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778779393; x=1779384193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulGAOE8HbLb/p8WT3p/HywicgLKOLlWLTHZNeMydSXg=;
 b=bIYl/YyJVxMcJU2Adcm0CxmCwmwjajsXBiwrx6Jei4HzsR7ik5Q8PLUlzQKLcm/EWm
 qwy8kGdABebCc4lWweFNijs72hkgvrzjDi4TuX6jp7Wz2rbjvL3ggsX+bSZmK8L4w9Xn
 WHer8j99Wl+vVdFmnWE96wn5YnGqCgoTEBtKMLbLyymSWbbI7n+CG9pkhgfYsxCxo1KV
 bH0GwZlOKuHp9g1pHBsNoOfmcpm08yu1NZmAkWF7c7H2cBt4Vyp4WzYOwsReRNETkxPR
 de3pd02KuWW0pT6VrNLzseLlxXhMwlEjp3njN1Q/C3eex6k8sgL/vjxGXbHiRkojloaP
 QWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778779393; x=1779384193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ulGAOE8HbLb/p8WT3p/HywicgLKOLlWLTHZNeMydSXg=;
 b=LsQe0nPDTHWRIlFR2mSCPttm40NlHlo1O5rpoAM3eYdEo/0zdZCrDl/ETEyAxPMfE4
 eOwtKRwPbC+r6aw+XilHQs43QwaXeDdM2ID4lVn80kY+M5n+/VtKMPHa5YcNcXZ3X9Ga
 9llcYvNblnAWtSdJb7EQyXnK9niRb2F0RVYnwVvp62+VzbIWD+hYl0fy8TgwZbT3fmzv
 lPSP/F35ElSlryjh9rn4Uef9YKp2gBAdQUsl00PNfAXLfyp7YXG3Txt9iiETi+507v6m
 3e/f8d81wNEjGNADmAKt2ZEB2mQLgVF2aBpfGy4i6zpm+mfTK1DApw/WgSuGqEOC4ZU6
 XCxg==
X-Gm-Message-State: AOJu0YymwA+bdJ71jn1FlZaDCbtBC3fW1hNvMchA6WAO8Q+WmOQH4OvG
 CTBNw9yBP22NjOP4yIRDFLnEWuYQB5VGN++EfFLR+413rtUvQ3pzWAWYnuMlzREsx4fjne8XtYq
 mBMZYOj1Qif6SQ2wlElyjXZ6ZxWXCxRlBrPNJpRbPep3CadCgZ0L2BI4yRj2PKztaPxOM
X-Gm-Gg: Acq92OHqDhn2NaMUUChbQhINswtizRl64sfd3Kmrn+m4YW6zxqNlKIhc6/xCuefqedp
 Bbq890uk+XjfPuKDXIAC9TamMjn4S7l5hdlADgJ9V2IpKQLMQY+st8bMDbdg5ssQcRNNjQXw2kh
 ML595HvDLM3jw1HgHCTimHBAbeaCNJ14FHpwM1+NBKgq5EpZ9qYj0pRNgy2OXMhsJ21WhWGkf/K
 XnDdZogT+rbY3ZgzYEGirQys3e+toEgQL+MRTBOnS2Zb43OYTsy7S1ipRpNcrLvgRKpgabO4Kbw
 1U/z6FU3UkoN7Jz1d4HqB0nXsHWZCEXYdGDufJt8ILvzwFYFS6P9QZMiaphxcEZ6BEt1CS7jK0w
 nXV+TA8T7fOeDFx17+DjUM2H9UETCzI0Q2PvWllb9kJwL8rRIZqUHQjty/raSrZfUHvxmlajHeL
 Bvt6XPeA==
X-Received: by 2002:a05:7300:aacb:b0:2dd:5641:ef2 with SMTP id
 5a478bee46e88-30398642912mr203000eec.25.1778779392916; 
 Thu, 14 May 2026 10:23:12 -0700 (PDT)
X-Received: by 2002:a05:7300:aacb:b0:2dd:5641:ef2 with SMTP id
 5a478bee46e88-30398642912mr202973eec.25.1778779392347; 
 Thu, 14 May 2026 10:23:12 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302944ffdf0sm3828677eec.8.2026.05.14.10.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:23:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v7 2/5] qom/object: initialize type_table in static ctor with
 fundamental QOM types
Date: Thu, 14 May 2026 10:23:00 -0700
Message-ID: <20260514172303.1484273-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _57w-I-ddkIg4R2nc5SvUHxzyU479xp2
X-Authority-Analysis: v=2.4 cv=UY9hjqSN c=1 sm=1 tr=0 ts=6a060501 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pDBHowQsxXgegazyqkAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _57w-I-ddkIg4R2nc5SvUHxzyU479xp2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NCBTYWx0ZWRfX3vDMyfNqiFBz
 iYFfY6mj36bvAbSaSX75sz/INf6El35rcIsoL0l4LlWguUIt8OtbqkrgrrPY2vFiwGqa1NJo55M
 iqx41NKw2nImw6J+ufMdDi+5Gk8fxVeNw4bkdVd9UJyH5KWFeMtdJ0sZtMJm67y4fcxUZv8Nutd
 CjODf/THzqVpEXveV8pKtm/XvMnn6VOf+pHRsUmS9Yr06FgUu+aoIgJ2N+vEf1setKzrIedwhhk
 a8WHs5Mzy0vZUKMHPEry2eiVL4wt6iOpdMpT5b6LHckq1PkJF65El85UDiuQRqHrtXdAwbvadQ0
 oWpLgLqg50FA2BhVMVcLnk9e5sMnK27d7afNwPOu6+7LNE0DGd8l2T9CGIb2FnBidRPc856fxYs
 uEugm/Lo9x082aT0lYQoSDO1M5G8UVXktUIQd6ReUADZ6/qMc58cvGIwccw6EWBFjRaWHUC8SK2
 WYUT+GoexVnxJ5rbN/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140174
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


