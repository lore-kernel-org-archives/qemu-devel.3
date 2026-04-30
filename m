Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89996FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJ1F-0000BH-Nf; Thu, 30 Apr 2026 00:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIJ1D-0000Au-Ds
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:28:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIJ1B-0003Hg-B9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:28:54 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKb9rb2533833
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tSmPencAU5o
 10CcjukLavzqfOdGbkNhhQxdywYnluD8=; b=Kze2fZKN/xu2ErTO1LagsP9QzQZ
 N3bKYPuysyE6Sb6CjLVVdTRP7w99iKKUDWmpMBhEO/Ff6d9n01GGN2/JBiSh3kNq
 ih4Bsllccn052WmUf3mlrQMNxcqPXc1d1IPIqlwjne13oMphk8e1aHSOh/U+aAqd
 2i0wDBd83n6m5Kl4wgMR+Kg80jw5a+ARuP1m7VdkJnwDV06VxJh2fUVavlr5bNjp
 bIafpvmN/zr7MBYM3B7N7BWRuiqgaD6ngqyIKCrw5wBHUVod+wW1vtEi6z0t8X0W
 6jtAG8uxD7tX7GI29j+hVmDtXJCibiWjDxGChci7Jyxy7XT2XBfpmykr+iQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dupe91ucr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2eaf70f3b5fso590595eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 20:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777521395; x=1778126195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSmPencAU5o10CcjukLavzqfOdGbkNhhQxdywYnluD8=;
 b=H1EUg5yreGeGTrddoLsA1gnvKgjXUWJfeIImq6WtMINDm//klo6NqGROAslMEVKa5t
 3YU3wU5jRnAuHhGL/AHrk7Jgk0/dMPhXVpx9RECeTd9tj7tUfd6T8jsRbC3vOdMiA+dN
 JyAmu4hxdFIkod6XFXj4KuSg+vBTOKSgsE4gZ6164OX3wqYtHByNADTUI7g+6NUw01MS
 5nj2TSknNNOIZP99KAdh6nb8oN+4bfVMXxZh70qdu9qR9gsP/MR76NEqxxNiEWKzVUi6
 00xWQOUmiGxYb8eglcOXg+HbvlELBlHyILTYAaOvEreHuBJlC3N0renpQq4pz1pyCYEI
 YP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777521395; x=1778126195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tSmPencAU5o10CcjukLavzqfOdGbkNhhQxdywYnluD8=;
 b=L5qaVFFpdG9KhVI1Yilsdsgu0GgcUFzOFj6GJjzZ30sDdWJFG1ZD7wvsJ9Xj8zp2pS
 dChc/sr5iq0WAWkIHisp7rwxjwO0O43RtgT9xMo905PYPXea5mPjgz1zFXQjpZxSMTnz
 HYuKxc54tnsEPwjKs6vrz6icmhF9vMaSXLWwZOUBrTo9JO59j8laFW1xTAcBFab/JZsr
 1cV1oyEViCHBV/j1Ck9S3bF9DRy+cJpfRR09iULhCt3V4fj36jKE3IfQqP/S4JGs1huD
 TAPJGUA6+iqTDATjn2wZ60u2jyKALzTbDJREyynODn/cBgm7kcKXTkuUXKuVNhRcui36
 Ga+g==
X-Gm-Message-State: AOJu0YwUvzX7M0eS1iIoMdrMTi4gC9In93kDAozeW11Q8DE+xf8uPQui
 QQdHv3aQEoruDI5WERIfs6TfmmtwqvwqgyaOyl3BqwdedFGCwu65cPT325vIhcKrWmD2s/cUUE7
 9/kzQtpnYp0z/+AZ7Mg5lRMMsliNV4vvFUTR1mCuxp1uPUq88FPWbTdUAo1tboQO82JzE
X-Gm-Gg: AeBDietZ0OaCuIY6RqJzih7C5onWRMTj48ZzHphV5Ui57K0CRH8hCYW3hG3K/XFNGFE
 fkq1keRnF6uH7pIekS8YMzCgBkQP0TVuWqzuzpDAHJMHpWlhSt1/MEh/BXWpZd+sjYH83+Hxfmf
 SQ/mdcE1qbp/nZh6KH8EYUQ+ZLXKfqDZaBpX60ZKLjLJ8dqc7zEygJyBeGcTFxRojIwkG9Mmrk6
 wRw9YTFxha9ZawKEzMtlrKnUXED4CBUfLZOgqRd6+NMagQyYqGT/2WcVIjdEnlFJcU9xo4JZ4Qs
 Ghm5UkPmNPsRitC2EG5WvGuePl0/84WVDQ+3XO7tmnxVqY/IgEqxDYGvJB9yssoF6EGkbpJrFqM
 l2ECa7Pbi6HUqkLyhq6US0r73T+bJs7D8x3kXqULdnejcfAqcSLr+coJ4vPYWxuoOO6DkZQ71KI
 x7pvz7rENgqUGvBTIT
X-Received: by 2002:a05:7022:394:b0:12b:ed30:5a32 with SMTP id
 a92af1059eb24-12deac47e60mr632558c88.5.1777521395115; 
 Wed, 29 Apr 2026 20:56:35 -0700 (PDT)
X-Received: by 2002:a05:7022:394:b0:12b:ed30:5a32 with SMTP id
 a92af1059eb24-12deac47e60mr632545c88.5.1777521394629; 
 Wed, 29 Apr 2026 20:56:34 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de32173acsm7159443c88.5.2026.04.29.20.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 20:56:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 3/7] qom/object: register OBJECT and INTERFACE QOM types
 before main
Date: Wed, 29 Apr 2026 20:56:22 -0700
Message-ID: <20260430035626.3511676-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kedrjNvLj1YdCKLU2KVs-xXsQezn1bOb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzNiBTYWx0ZWRfXxcMfzaGsueJv
 Vyaoio3lSsjopb1n6efR3b2Kj8T41s4VRmNqBu7vBnQB+R6t570VFe07mUawseluXtm1kjzHR4m
 hDc5kZdLm2ECycFDpYkE2R62A/78XFmLz+ASrgCnL6JRaRdn0aRIJqZo7ARiLXGTxq/q/323RsR
 iMqmfvuyb0xuXaskJVT49HLv3oyJMtTsVKTmeJpCh+3fP6jRBM0AyfAVC+xJ7xUsva8SVylMRQu
 XmA220pZyz79Q6k39FV78+IQvrZ1rCa+96ovUP0PIH+J9Ib1udUYBDz//PmBbdiXqMKwv+DVKKq
 wtr4nSwXXv6CJCLUUuvWqOJ+Aqdn8W4pHuSb7GBc5BM1IATtD8C8j1PNtPJKy0DXhdG656nUV/M
 U7J8ASgMaB+724h28vxn3P+XIvZTR2tIc+7D4UXQCxlDZ+Y1EOQ9lI0T8U4M/9nLXQx9v1jcO5J
 RDzu9E0uIl4GeiX9Qjg==
X-Proofpoint-ORIG-GUID: kedrjNvLj1YdCKLU2KVs-xXsQezn1bOb
X-Authority-Analysis: v=2.4 cv=PvmjqQM3 c=1 sm=1 tr=0 ts=69f2d2f4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VDdTCajPACCFXhBZtZ0A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300036
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

Those types are special, as they are the base of all other QOM types. In
next commit, we'll introduce an extra step in module initialization for
target-info-* types.

However, those types depend on TYPE_OBJECT, which is only registered
at MODULE_INIT_QOM step.

To avoid having to introduce another step, and modify all code calling
module_call_init(MODULE_INIT_QOM), we simply register those base types
directly in the static constructor, before anything else.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 qom/object.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index f981e270440..a5d268d0722 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2839,7 +2839,7 @@ static void object_class_init(ObjectClass *klass, const void *data)
                                   NULL);
 }
 
-static void register_types(void)
+static void __attribute__((constructor)) register_types(void)
 {
     static const TypeInfo interface_info = {
         .name = TYPE_INTERFACE,
@@ -2857,5 +2857,3 @@ static void register_types(void)
     type_interface = type_register_internal(&interface_info);
     type_register_internal(&object_info);
 }
-
-type_init(register_types)
-- 
2.43.0


