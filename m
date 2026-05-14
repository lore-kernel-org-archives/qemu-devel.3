Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9B8CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNZmS-0003d1-CE; Thu, 14 May 2026 13:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZmM-0003c2-TZ
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:23:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZmL-0005jk-BV
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:23:22 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeaop2241778
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Uf/5jLZ/NET2/tvaeuFYNcja/q48puCNeH8wc3fMTqA=; b=e1beL7kijEWeXrZQ
 sMqam16cl7A145HyMMAP2KSbi46c1snXeQgpOr6LHuS0aierDVr4XcKVl7+USEoB
 tAcWRPcSK6pJRx67I1QsVgwhEFC+4EnUdzfpcuj+Ay70NjWOUsnTODDCU9wH55mJ
 /e97KtFY8LdCEMX8lB2b3iSYyT4zafOcXDHNtC8JgBizYwCV21ctmiIvD+Tvyub4
 5PwZlr1BLEZe+EX8f8llrv/SAARh1WUAxvONrCwYx4ybHq5KrLtkguPp0yQzXpiI
 gFy9TBCJe8pZ30pBzFDk7037bYkNnDkve07MNErSNPl75L5q9T4xhHbM+2xPV4xc
 SwU/kw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e513gbtb1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:23:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2f485961555so25511862eec.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778779399; x=1779384199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uf/5jLZ/NET2/tvaeuFYNcja/q48puCNeH8wc3fMTqA=;
 b=JaQYDVdmOtxLgthj4eFVdPopn3tO9fCgN9khO7lMjn4TLxvE6XGvnMi1j0ChDNrrb6
 y2o/14I7PYTkNFr5Ht9VAui9jD/rY8uZfqARtbGiXhl00PXsLY0X+o2A51Yozs2R617m
 KxSXsv9AKWzZHXmIO/lrjaUHVO8bRVPP7z9C+cvIiXcQdg4Op7v3jA5oeQ3VAfDRgx0L
 cvOKv4D0SQzsKMJaU/O7f5rgkAFwaU+rf0nCW5OR97HMPrec7f0hAwrxFZdRABpCU0qU
 PcNGGtSGBQ32rRw45mpwTksq5DFdbOpnSP4Ep9hs/LfAbAKGc0pdGZNn79WU3xeVkJf3
 pESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778779399; x=1779384199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uf/5jLZ/NET2/tvaeuFYNcja/q48puCNeH8wc3fMTqA=;
 b=dA4noqldn1wzW99bk64auragr7AVhgDjjqxr9oYiA4cq34PUKEes4wEAQpzEf7gFcq
 HK9TMJ32UCbchUg30l1i/VnvY4lTEIsfC43vW33UvpBgMAivRsDT5pNWZjVh/sH2UXqJ
 kJJWXxK56FoQvxmQ4NCFRZEDLKjINHiNR5opzJb9i+A9OrNQ23CF/l9fqf9Swe6wv7kr
 U6sR6A/N3Jd3pC9UBjPBJ0tX3ixGkLZkRodvRruHeZDac8S96Wl/h72/Kxw9MGs30qfr
 3xjSsaZFdMTn0TfLIug5hglApxxFeBdvWEufV1yh34FcJCrAB7TaNsljWPj6IAAMjsgj
 s+Gg==
X-Gm-Message-State: AOJu0YzNiLGl5u3Wvn9wTdgUEIaGQ36x1OvMtwOxc+GYPpxRn3IPde9D
 56tmPKRDdwXgLCyEYVHCVoHs1pk4vdsVbIYU/UpQRjvTGeQwd+PTVOrWJcQk4FlJe1VwlGtQfz0
 3atFa35x8+5Rm3+HG3ELUZUrOaUsnI0K+ywZZI7n67gh0Ing2aYJCsrG4EmVEpDWMOY1i
X-Gm-Gg: Acq92OHf8qxlA5CHBcXSCwZcLIwNyLVFoAo2uClNxc/PtSlKuQnDrXObkJbzvHhJXSN
 ScbHMXht38AaNGG/lMuqKFk+3zdmAIHWvCF5uXmOHsSxV5Hf2IL3BeBgnKF5r8d111nbPLyCDcR
 PyTl/m0m6JHhZ4biE3ikCvPmn64FrPgN7dYxY4v6+WzG3zrgMj4F+a06zcYywl8KDCH+D4fHpe2
 ClyFld36mH7VBqIS7V0v5jTGLCjGhfO77OWOenRwvXiwL8z/KF6uufJcgt+VcnKicjy3N9BbiY9
 oOrs/tpx5Mgci+k+CioTpomfmxnY9HGDxrN6NJe+0qQp4E7RL8ghRM/koPltGfORfk2R9kOdly/
 0menlIlfiEDQFNA6Et1cfDVsf/g2e/U4xWTv7ymjk4cZG+EyYiFikkRMHNKU3MiPxiIa35J9WHO
 kCp85yQVk+az67JUUp
X-Received: by 2002:a05:7300:b586:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-3039812a5a6mr226719eec.3.1778779398800; 
 Thu, 14 May 2026 10:23:18 -0700 (PDT)
X-Received: by 2002:a05:7300:b586:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-3039812a5a6mr226681eec.3.1778779398232; 
 Thu, 14 May 2026 10:23:18 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302944ffdf0sm3828677eec.8.2026.05.14.10.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:23:14 -0700 (PDT)
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
Subject: [PATCH v7 5/5] target-info: replace target_info() in system-mode
Date: Thu, 14 May 2026 10:23:03 -0700
Message-ID: <20260514172303.1484273-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NCBTYWx0ZWRfX3jsLkx83g+ST
 +mUbD2RxuQ98lGtbam4jPozsoHXi3PhKZSaXTO4/XjE1wtJexUL8AzhnBSY9RZMSH/9SXR2gFeT
 7dcdL71F0WK/VGnEamrb5QQOBWvvneqAl1uEBJOAtvVVKqJInXpaiIVt8iQPvIrxRytpxiceTdD
 unPSXQ90v7SwoBRXqOmLoKakbc2wNlHPenp6bEz/yAJgf8pnM/4dyuXuhZVzjF0iIFaImBfHE5D
 7ZzV7w1Fn8AMYw90bNqCNhoX+sfs8WguYhCEDKXbj3FJCSUlJ/bNsEre4/HwEzliwKSyKlE+GXx
 tXBjkqT2TqzMU9Qn7AseLjhLmY8PImuQ7BpgXoHnhs0DDrw68fE9d7ucnoSPq9PDZOGlMwPFskM
 aUWoc5E6j+pc3cwXXeba8yRCrFaYGBmbCrHX/OWzLPRWIb2Fu+XUFPbqNVCqjdeMXOiv380ssjg
 8kRzIttMnRcOD3Qrl2w==
X-Proofpoint-ORIG-GUID: 0cV-XyRcdzcthjJ9p4SrT9iFXdgHHQOj
X-Authority-Analysis: v=2.4 cv=Iba3n2qa c=1 sm=1 tr=0 ts=6a060507 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=W37sF3GUcAVBL6lWIEgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0cV-XyRcdzcthjJ9p4SrT9iFXdgHHQOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140174
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

We now can use TargetInfo information available from QOM, and remove
duplicated target_info() symbol.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-init.h | 5 -----
 target-info-qom.c               | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index 32c323a7ef9..b7024c9faef 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -38,11 +38,6 @@ const TargetInfo *target_info(void)     \
 #include "qom/object.h"
 
 #define target_info_init(ti_var)                                            \
-const TargetInfo *target_info(void)                                         \
-{                                                                           \
-    return &ti_var;                                                         \
-}                                                                           \
-                                                                            \
 static const TypeInfo target_info_qom_target_type_info = {                  \
     .name =  TYPE_TARGET_INFO"-"TARGET_NAME,                                \
     .parent = TYPE_TARGET_INFO,                                             \
diff --git a/target-info-qom.c b/target-info-qom.c
index 9947fcc9922..b48714cc77f 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -49,6 +49,11 @@ DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
 
 static const TargetInfo *target_info_ptr;
 
+const TargetInfo *target_info(void)
+{
+    return target_info_ptr;
+}
+
 void target_info_qom_set_target(void)
 {
     g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
-- 
2.43.0


