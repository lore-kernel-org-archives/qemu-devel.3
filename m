Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0271C98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA8A-0008FG-A9; Fri, 25 Sep 2026 13:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA84-0008CS-Ia
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA80-0000eQ-5i
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0JqY1362989
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uYxBfRk2qEpJYsBnsk7YFly7I8cAJlci98s+5I8anLI=; b=J+auy+PvZWxOTqy/
 9QbbVtI10j3nIgOFMsjwGISwiYi7kOdKv+exHpQsgNDY1L702YUHeiir7NRwqk7q
 PB1sSLZKB/IGxGkXsN/jmMtZ0cmsmwQ/jzrCCGo4TA5AIHslq/7zbiB82AyYFdGF
 s+hADazLyI6NlTeXvqrsjADUybUmz+ERkOXqRi6Otve1y63OQLvPg5LZO3q78Cwg
 2tcNLQAzo+atJ2sDlf1t/zfmuAzQ62VKIFfB0b63qOgE9ECnBaNRzWUDLY3N4Dcc
 7kXRwOt9Yfku6eQ8jOI9WoTcCHU8Yio5aumkjdQV/kTXphWD4gxJBl7A9BHmD18x
 n46P8g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvnsmmf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so1872592eec.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358860; x=1790963660; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uYxBfRk2qEpJYsBnsk7YFly7I8cAJlci98s+5I8anLI=;
 b=SeY9zpiSr3vbL4KfCJMLgpgYk4k4X2eZsvqp6IwDybkMnPbFsKQI6QGDc0QwCtv6fK
 xzg7GseRHYRfQUfb1noRl2p4dxQBKSKdQQEP/3Fo9L4p0P48eTj1sKn8YT7+QsK1As1l
 zYCT70czDOXVkJptya3JQKnNZYRv/XHL6QlVKiXFIZEo8eqTlzSQqMJNRKbJ7y7alp3z
 F4dmkhOIuV+mPhYU3QNATgMrbeeGytkSIbzUibvgGpLMyTI4UUKdl0XmXzQ/NnLyJEEx
 ib0CEDU5XNEmlx6eBZejQCFRoQhJpS7Ev8iYeQGagGUf4A8E5GzW8k98O79Rg2QDx1U/
 9MNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358860; x=1790963660;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uYxBfRk2qEpJYsBnsk7YFly7I8cAJlci98s+5I8anLI=;
 b=Q54MEkBXyYFXLY1zHsuMJrSwKoeN6vH+Po3WKWBOYx6tcdjZ/PEd0NdERiUiKH3QPu
 VGD+yKN+fHDQK87ML2F0tka5VXQ2+OsMe8a0wwRjWvpB0yin5DSHUOper/E5qacwVtnP
 WNWYFWtSbl+8KnB8Ao+9Da+9NsclAN604dDqj+stLaZlpmiOfjCEa1xPe1NeC2hjjSbu
 4h9PPPpkcF5FZ9XFpLuZ99B46JlwR/N6snAdDUUN0e68ljVzS63adPn1upJ2SVHYybDz
 kFhS7juhbfW4TcRcSQeDu7Q2TQN14MjVw8uZgSNMEXH0Uk7dZHwcD8TO5O6gua/GDgwF
 PywQ==
X-Gm-Message-State: AFuF++mVjGmGgWRLe9J2UHJFtRdd7kWTwHsCNXAxS+LyjDkGJ76fdKA3
 l0MvWx5i089BLlnzVjtr4qXwJFGvlvtss0XBFoMKaSt7J0SZUyy9PEThSe3iTzjvYeuQNvB66xD
 gawffVJsc45ay2EvoAeGcB09aQiJWLV6WtVbPIX6zoFcrNoTBEMePTw3VmrjsDn+ZoQ==
X-Gm-Gg: AYBFou3T39pGqYD/txp8gNegvvN8dGXk78R01SDxi49B7tynUKc6tf0gw6Hokpf82SQ
 lf4pcsdbQeVxN15p4/yEa8xrdJjHPSLaPlSu2rBCliWnHOuN3XSJKJ8wwS06E7eoFNAERNN8kpO
 JnRpJzKGPe2Kh73x9jMt6u8jlaT0h1JTESjXi4HK7Jvr79ABiCoDQhEAeqKCY9LjAFZ9WV6snRa
 iIEHST7s6OKBruSatAOA9taKdBgRWs+HfJLSZsnJxCjCl7BTUirxefSDILYQb4ck2eF3A5ZgjLJ
 Mvp4MrcEQmMKlll6VicIrmJY3FtptfGNk4Zmu3bviI1088DuYh5EihpvheB96uEu2r7HpNEm5Uj
 cHnbIqvoATDb6Lu5mxTDuKj4ho0QZ3jvPZT1gxaugIB/Yh38WjVR4XlJrA2w5+Kqz1K5E
X-Received: by 2002:a05:7301:dd81:b0:341:4553:a529 with SMTP id
 5a478bee46e88-34271d8d31emr706833eec.20.1790358859671; 
 Fri, 25 Sep 2026 10:54:19 -0700 (PDT)
X-Received: by 2002:a05:7301:dd81:b0:341:4553:a529 with SMTP id
 5a478bee46e88-34271d8d31emr706818eec.20.1790358859076; 
 Fri, 25 Sep 2026 10:54:19 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 10/13] tests/tcg/meson.build: report correct cc in summary
Date: Fri, 25 Sep 2026 10:53:57 -0700
Message-ID: <20260925175400.1897574-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: q83mBN0Sk3B01CmhejtJUkxCsorBVdfs
X-Proofpoint-GUID: q83mBN0Sk3B01CmhejtJUkxCsorBVdfs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX77Fl7QlueCr/
 SSexfyU/8Oh3dVACr7MaKtcW4qcfNt4H1eeX/IyMfBlD7pfFJUaRbX+ftFlOPk0z23sSe384JNv
 u4yLynfdRRIuioHsfLsJPA+YGjKynvY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX79OQYim/6xsd
 nQU1F09gO/FhcmDGF9dfPSyEXdL80k4a8O6Or8aquLEY5PvizYLity1kaZvTM/ZYTl7UrhCmT67
 +gOd1saandEPiIfWqgCuSUdykySA9AcE/qDuQBAccsn/W5Ig675zYYtYkkIYunKcKYi4iLr6tZQ
 TqzizbFPz1jvOMjHanwqaAShJpc0wvx9Rph8e9sJQztThn+AOKBWcJbrkpaXHgx56y40cLeo9o7
 FUhQOvxwLAt1lR7/QTKvHG5hS7vgV1+PUsfbXVsUNBipMVpj8AnMpd+eUiau2/aIwMqPing5S6g
 Z0w7iqDJ3ksHOHscpkR6YpqiadrJwMURQcJMzeCwflnEyauIh0TZTeyJEDNpfYz5ARPU+AR0Qrl
 IqvZsdbi0/6US009OH+C7iC/zv2QXzsDD2nzOSUGZIba7a+r9GzwBGW7Fdg2ll21ewrHwMB41qR
 Z25UKEwBrXaJ3xZwF9w==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab6b54c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=ZxuuHP5aqR2_myhI6OUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250071
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

Summary didn't consider that cc could have been set using --cross-cc*
options, and was wrongly reporting default cc declared in test suite.
Fix that by reporting path of compiler found.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260924213942.26491-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 52d073a0bf6..24600d087a2 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -290,9 +290,10 @@ foreach target, plan: tcg_tests
 
   summary_cc = false
   if has_cc
-    summary_cc = plan['cc']
-    if not cc_from_system
-      summary_cc += ' (from \'qemu/' + plan['cc_dockerfile'] + '\' container)'
+    if cc_from_system
+      summary_cc = cc.full_path()
+    else
+      summary_cc = plan['cc'] + ' (from \'qemu/' + plan['cc_dockerfile'] + '\' container)'
     endif
   endif
   tcg_tests_summary += {'cc for ' + target: summary_cc}
-- 
2.47.3


