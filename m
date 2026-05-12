Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5454CCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMocy-00086G-9f; Tue, 12 May 2026 11:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMocw-00085W-K3
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:02:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMocv-0000XE-3K
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:02:30 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CBcecB075038
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ulGAOE8HbLb/p8WT3p/HywicgLKOLlWLTHZNeMydSXg=; b=D1lQ0Bk3qdgpMFSs
 FhiYDeFP80mbZ2nr8uArlXRnTCSf4gHFaPJEMZ8s86sgWpMebn9o7c+21cRq+CzK
 2sixPhhvG8Ixm+u0VXxOOx/p4tfmiFKRlGiikPV66+1/KP4cTYDtJ9X8z/s2hgaP
 gI5RItfVA0kqlUw7MobJekkxLasZ1TxZxohXp40l8P9kwXiJNCjUAEJzoDK6t7G6
 pr/1RaECaw0IQ54pjvm41EVvPbAFmNeS2aNr2xVjCN0oCR+15yiXIHxd5bKZZzYC
 nw7wphF5Ghh5mysD/VsugwOLi6gup1Z5y23D06M/KpSyyOLi/V6haH5N6263EFe0
 xlAIOA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43gygv1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:02:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2efc342ef15so7723453eec.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778598147; x=1779202947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulGAOE8HbLb/p8WT3p/HywicgLKOLlWLTHZNeMydSXg=;
 b=LE+TBWteTm502cpsJQOeOWlTyn1uedEDsxoZuiwCypxlRSn9bB8prnM8nruv/6XRvL
 s/1pQ0nNS4qjRcBc3tKNBNddsqO4Pgq5g3utjU6gc2hL//F0Wdo9jR32hsbVPtR6+lN+
 1kKF48MraKSOfOqbcWsv2ucvL4ezT9xsrbIYHaBJLx4zc4M5tQfWB7XeGWtPD/Z6doHV
 jX1dYU57Dd2CQyp6/XNbFudRbug9juuiwIG0Rk/bppLBEJlnkWliZmF8T/OZsFmwsJ4i
 SY7hwdYwmpLBQLb+3oTjhKj1fZGuK4vynGBslMkHGbzadlfJpMT3kKAulbqKlB05hv9s
 5nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778598147; x=1779202947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ulGAOE8HbLb/p8WT3p/HywicgLKOLlWLTHZNeMydSXg=;
 b=esgalLUSBcpoCG4pAI3SIhwkhhGDIJiRWSHQc3cKQ5EM9TJtp/Dksl4b+w/W8uvnzi
 3gHB3QMWffXjjjmKu37QiIgxsXjF7AL1TEtyIz2Jg/C7xiTTdZRR4oy5j9ub28F2Aqz2
 OSGPXjZzHIbSbM40zgVODDiKFmXTcm/YY3VkuTQ8w1PR37fTB746cxZyqU/XDJjyT5jn
 w+DE8Xx4Ei0oyLTviw5sSXarQERXImYOiYmok7laKLIbEAgl/PJYr2sLinVwcD4eFHMq
 g5oy9B4RRtF8NVZRlm/fyyF/byR2Ac5SIXgE8Gt/EpLplKRZR8bVmhuA0JjoCSO2/eYd
 BtzA==
X-Gm-Message-State: AOJu0YzhhM/GjEEBnztIEXwdOEmUA5Bi7tr6mbN/CFo8kXoQhN//V4C9
 4w8OpxnmxAWC01SIP8RvhHotU5jizTDnN4isihqLlrkSqSNGyApdAEh8tA+akxsjGGwm3pC1bAC
 Su9v0pA7Hrei1u/EkTQGcTB5WpFayjfHS69SuBCerJ0VKlAFvr0k/ORJcHnMXdghchOiG
X-Gm-Gg: Acq92OG5ciJekv1/URxiqB0GFxtarezDAEUBZKbHVpTdLLDzoOoKlJL+OIjOgjrnWG1
 vvzJFh2Jnsj5Q/4bMcuuHk9VADICcgCOJJBTM4wQAQ/K//goN8sx+WV9Gf6Ac41RbavdrsJBCX1
 Bs4EMkvauA66+z80Zu7znAY8jr58WpQloDZtZbYhsMtc7vS/dRbaXTdKKsSHn/Cdt6sOaDhUsrv
 M+5oQ6qbj0OI8BrZGFMiwHC4d+nvu0a8R23erZUSX6yOhQw1QofkyMAMmXesA7NndmK25EpDkzT
 XlhJYTg8sRXUV8L5TfHSySJn+ZWLAV/bzelYq1Plle5VlEzk13nFmBrPYMgLplOz9tHiTxCaGsg
 k/ocEA14e1fZwP6eTAKsieWCge2Lk0TsmMnWXzFXGG48eComCMEiGbot+5XjUb8Fqwm2ohhe2pn
 sBEox1lw==
X-Received: by 2002:a05:693c:3015:b0:2e2:5bc5:f8eb with SMTP id
 5a478bee46e88-2f54c0812d1mr13360385eec.9.1778598141785; 
 Tue, 12 May 2026 08:02:21 -0700 (PDT)
X-Received: by 2002:a05:693c:3015:b0:2e2:5bc5:f8eb with SMTP id
 5a478bee46e88-2f54c0812d1mr13360300eec.9.1778598141026; 
 Tue, 12 May 2026 08:02:21 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8862d429asm18270335eec.12.2026.05.12.08.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 08:02:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 2/5] qom/object: initialize type_table in static ctor with
 fundamental QOM types
Date: Tue, 12 May 2026 08:02:05 -0700
Message-ID: <20260512150208.1167711-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fMAJG5ae c=1 sm=1 tr=0 ts=6a034104 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pDBHowQsxXgegazyqkAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: aGdKAU86PFc14UlJ0ty98qEwDKFUMtTv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE1NyBTYWx0ZWRfX/Vo8+NCQp+PL
 seSKWV9SJIJ/tpWl6qPIqwjF8BDoUSnhxUlRYF6cfCNkVG9WcXZr9WgUj3Zo+8jh3dELrTfBWuE
 GscDcA+eFTDJm4/ueWKLIeePlun+Tiq1uAFh97HVkeckx537UocpyqUGnbFpzgMH4+lwanspdkn
 N3/UsDnr6QAni4LULHwylpUz6doK/vjHQ88gB7cMFH3sOtUoTpFdN13wCrN5jPwSeVWKoYBVFxX
 F/WUeJmdc5Sf2pvib+5WaglzMmrfCg1owjlmkvDtyc1xvhuVFEnTMZTbqyIol+m0Mk5qpBOU69J
 /N4UbcZqZLN2wnV2KWOHBuVrrMyDxqHuifkXOpgcpRN4QAxMb3vv61/Vo3yFlFeC5gu4/yuBR67
 c3/watF3PyYhYnNxgEk8uipCGBzLkB/TxjwUTbD8kZQFznDQ7m72sA9eEJ6lsoFx7Za9m3QYCSE
 Z/U9cS7Ddv+BRmbnpFQ==
X-Proofpoint-GUID: aGdKAU86PFc14UlJ0ty98qEwDKFUMtTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120157
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


