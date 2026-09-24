Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09233C9831F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9rB9-00008V-Pj; Thu, 24 Sep 2026 17:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9rAX-0008OR-Sn
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:39:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9rAV-0000w1-RX
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:39:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdlII3462615
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jFEH+leyhlM
 zariTIPS0SsHzlEknJrriIVvM0aHFpLs=; b=jiY9OTN54PqnL4qZ8KPmKUqSeAF
 pqOEidbVck/m+cGEQjz7iGf05bURdqif6g/c1ytP6fkQDhZGthcm/67X62rPx/gH
 qO55P4FlJYgl6oyOe+7612ERD/VJUlwTIi3CE5n5z5cDBtgc0wHEK4/d2y4e6E5T
 iL990OejnU3XPnIUEP1eURnYDWR6/1WuBBefgdMXHOP8LAnIbt0OLARhRc5VKUXC
 mDazUzEUS84n0r0w1t+eeqmXWVWgd5N/Y2ssfi47WVrC2We7p286ebsvVWVgf4gg
 J0d7xvZNHg5olVoYIhdVpqnDIwBNtymY8uCujIiGnnL6rIBOHg/HiUCrkqg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjjry0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:39:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3286d2bac04so307550eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790285988; x=1790890788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jFEH+leyhlMzariTIPS0SsHzlEknJrriIVvM0aHFpLs=;
 b=Widc332WFFWNZ3xbIbsujA28FIHrj2Z+9jCZVptBw77TMeWWHK945//CLM5Qu8gNuu
 Seh8zyoRiw/46V5sag5BhG95pZqqoRHUE1JBixhQtiO/UONCqEOxCZ88m00yuCLSB++R
 tkko1yJ+VLLetoaVeHysxiUm64C8le8rNe5+nwg8NfuC7x2E0vtUpS9vQ8DamU3rw6q6
 1QEjRZk4PbKfIvLbS7vR1bWCJar2bFq76FGEJPshauxY8CKJoSm3dFLLKmLxUB9Gw6Po
 zcZxNsc/+IfbLk5gFBCMf1VQDqLIDFLJIGfJprzjQ2jZLCdmt/en6a7dNpP+uPEv8edD
 VGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790285988; x=1790890788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jFEH+leyhlMzariTIPS0SsHzlEknJrriIVvM0aHFpLs=;
 b=ECFplH5YzDtggV9To/tI5hBE6gCySpRkZ+XtU7v0hDnIY3cFI/JSw2lSp7E4NoSz0X
 tXME7WYKaPbicV1gFvYrz2ik282+vE9doon2RaqYtIPV+VBSkOtn/IK4iBywDg+Jl/x5
 QN5GzV4mTjAxSuGxQL1vEcciJPx+EmwjKUDttF2NECvSiwIO+H+hnmuGDAsnKLfNXOkr
 5WUyXYGnw5g2JfLdYRxPexQrygEY7zJvKrXNipNTL9pfVbCejQ5kqf2GP29ggUaOnGnF
 FyFPsaMLiGo72WNFzpzCeyeEwUdeXXxx+N5PC0KxdBWHyjk2zAUFEriRXeWhedDK2dCc
 MSew==
X-Gm-Message-State: AFuF++loR4acnceEimXntVFrgHX9qo5Cl7DvO17Gww9E48NMeHpVksSG
 lri0QXX8yZYG8bddk/7OYBYOReZ50h1j4XI9KcKM+7m5SL0dciXBjCU036L/8JgnYn25uA330kw
 2gSby+EAOONiXmKX44q7kt9BukejENHZYxjy0AnLnatir9/euMVTiTM7BqhbDvwsD/w==
X-Gm-Gg: AYBFou2tYrDkW834s1IC/1WTny6VvyU+LtqGGL+bua+4wgZK2Usl7/C/CL8xUr7lJOJ
 QnKnotsBBi643XUlXNg19447bDTHT3AJx6Gs0M8YAtbvm3gp0fpSFKmzhRaIjZBMBvg9InRJ8kK
 nVxENJFfelNak6bg6QgpF1BTnW7XJDIN5YC7xcfap3LZf1VAp5x6ZYURpdI34wU0m8GDUhnXg5W
 vh72fSzdzD7k7o2/dVdUrkR2nFRqn6YnVbcuy2AcnIU6LMjWsEI6oWr9ePk09mYNo/3hf7FSWin
 LlI2bhQSr0iMP2fkOuQrueUBu+myyrN+wR3FvoSSuBrGNK+Ob9tghKZZef41uWSdOqGNIJoG/kj
 3cRJmIJLMSKgMmhaXutCt83LgUQOdjL5+azgUUGbZhEec+YsQKvFXQcthwQ==
X-Received: by 2002:a05:693c:37c3:b0:33b:afe4:fc63 with SMTP id
 5a478bee46e88-3400566dc79mr4454641eec.36.1790285987938; 
 Thu, 24 Sep 2026 14:39:47 -0700 (PDT)
X-Received: by 2002:a05:693c:37c3:b0:33b:afe4:fc63 with SMTP id
 5a478bee46e88-3400566dc79mr4454619eec.36.1790285987297; 
 Thu, 24 Sep 2026 14:39:47 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-341463ec3ecsm1273668eec.31.2026.09.24.14.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:39:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/4] tests/tcg/meson.build: report correct cc in summary
Date: Thu, 24 Sep 2026 21:39:39 +0000
Message-ID: <20260924213942.26491-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ysRjY5AJau1uLOn7z_PszZ-q8n4A67HG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfX0K++Cpaqz4WG
 2TEcDrNw4XLhyn2sfuSpoy/Al38eeMOo4Fui2eDsdGBna/6PRAOytiwdUXmUF20BUFb29j94oHu
 30iVtrgYE4TAvqq4djx5gCd6mtvIHmMCRlb7binH3qxWEIlvxSsDfgWWRLJG5fe+pB17cp9muX7
 NM/Xxc5Gj5nP/lJX8LdbGwHGv97BVcklYNKY1cY4khmZhiahd655UFZZfRQWSb+wqZBH3DApFkx
 jWTJzVd2qwxJsZ+cY0sKphbdvbh0yIh/1rYcIMDb0e9bB2Z4BgXh0IzReB4cZYWiSmJEG+KVzRU
 QeSh+Pi59MUr49MAmHneJD8XaW8llxX+eioDLRm/Q8a1qDOYDLbhxdrQykniTC5U4dcPiPcosjL
 lXfVZirkJRkf0VGFugic41tla2/QFYSl/jFgWZXsjJC01ulDWPlxf7HuTPFiqhI7DfNHK3jwDmZ
 WdILTPxski+odI8syzQ==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab598a5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=LSmmSi2P5UYe0wEEQoEA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: ysRjY5AJau1uLOn7z_PszZ-q8n4A67HG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfX3BRdSkCahZHp
 om5ntur7Y4iaYKKFbIyZZ0aQEE+qdFgd+l3kEwJnKqtkADAgk6qJx4RCHSP8ceRRVt5Hxb4UQfW
 IL5gMDIjv2i6hdbBn/lDFGdRo9kboRA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240088
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 474e4d8f6e3..0006d192cab 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -292,9 +292,10 @@ foreach target, plan: tcg_tests
 
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
2.43.0


