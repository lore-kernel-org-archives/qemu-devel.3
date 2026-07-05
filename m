Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057D7C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUtW-0003oG-16; Sun, 05 Jul 2026 18:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUtU-0003ld-KA
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUtS-000135-PQ
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:56 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxNVG2863625
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 22:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0zxOegtK9/HXZJNp7+v9NFHsGRS7+LXc2HkX7d76Edg=; b=DAe3SJjGw2MamgZR
 bHp3lNh10V+0NBVQ3HCWUDNT1YtOp+kh/iGdlpMkWhi0qyDenZx2mUfNWH74dqvS
 pONulk9Zm0pnaq4msef4MB/5IiB1glOR8OvcA92KsPEYEmXUVqW26iTwIFVCsHii
 ZRnBug8HJJLfo53xtdGRYWAFdSXd8pHsaxT0VK3jUmlE8CTW1pPUvY/Wr21DN7PY
 Qz3aE21nRng3Mi770WdOGqk+Yc0p0nwC5x2lzuyanK/0t8JewlHnUNmg+YxSx4Vr
 WG28k+3UFgstDNi4hY6cO3k0xaV3Z73ErOIpojfoeDOe0P5vfMJoPiCDAA9ikXkj
 MREVaw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s64kmtv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:00:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92d1cae5740so261918285a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288853; x=1783893653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0zxOegtK9/HXZJNp7+v9NFHsGRS7+LXc2HkX7d76Edg=;
 b=W66fGG5sTe5Y21tmPClwnWUWb5zuH8ZVQCByEUphIGTiqOjd/3IJwMEr3Dp/Bg8hkm
 0fHCzuxcCq5kqnL7aFTOTLDBYcBUZ1Xuyux5O/eHCVhucdXXf0O+qm+7UEux8D71vjy+
 BhBcVLk5LlrGAP+TJu4wSVJJSaGBQ+SOTOpzvrBE0lKQezhmWC9BM5BrpV273sZeMkCv
 631Q0lCPf1wKO5TYDs4xjVI80nS1KMcE5DdUpaG+osJQtesp7eT0z64DL0dnXbCTGOzn
 ProjbyAB8frJZrai04W8J9A2/S/sPxPIYY2ieDEEEPATyQobJm/ytsIeGVjTxD97Fh8S
 I2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288853; x=1783893653;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0zxOegtK9/HXZJNp7+v9NFHsGRS7+LXc2HkX7d76Edg=;
 b=EsA+Hsql2ue6mZ6/rQMJCh29AOlv8OEJ9YRZ06PjyngtVJyTp1deuYhIO0YuJ46i+9
 ZKoos1N5zdrO4YVqncJhBazhJ+CqJONHJiJI42zofUtWev6PlU2gCQli6uPw/wXQ3PAL
 PV9aSnraiwzSzUrjHwT+0eEdbUs6dh+8Kzllbt3b2AjpePUTSrOAR2znrLKsgCiclvlx
 iXsVctIF6EPeXbqT55XWFsYT5iZvMAd+WOhBaO2mAYQPk86sy08uj91vM70Kb6A5BbPV
 jaeeRwVFQwRLxjO/YyFzvDtEAGDrGLudvOrX8zMbAYJmHrLxWfBth0ZXH69nSAa7YEjo
 z0JA==
X-Gm-Message-State: AOJu0YyNzSxTqIhvkODnDS2S6aZsvSS+tLjBk8uHztgOhScRW9d+m10Y
 aUg9tWmO6cjfOb3Yi+p1VmU4AUe1BdDq5pl4qOY9KygTL77fnBedtW5ndUNxDgQMEnzVHPFBDE2
 heXfCrrLxmrIL1zqQZubfN73Ca2z/R48/AICLJVKORxjhzx+Uusf7hQMCUq607GpQ1Q==
X-Gm-Gg: AfdE7cljJAp58vqOOrJLV4WYl2h0vSxVK6bRbAGYCzHVDnsT4Ok5e8wYtjhe1eTxL56
 l6+A46WJEe2hLQFPwBtrx3QtlXECKsBmXqYcklepZ6TCqjfCqLY8Iu/rqIVTrhu1uWSh96CWjLQ
 E6Bv7oIgLS41dI3SJtEVq4IGywdJu1iTfD99rUr/QrALRdsyHCRcsvEXay6HyR8u2cw+EJQBFlq
 /lOiznjgJF0YwDB9n19kGm/YN5fxi9OYMCkcCi5uU1LDEdXA0akRneyN2PtQeizQx1iz/sUJ8h/
 s8dWlt2F0M+Tg1664lnY4gQeOJwZ2Bq85Vp1eCmd1E/J3uyUkA/Pm23zyQiRyElKj0JgQhCb2CC
 KHkimuPYjbrmFBsCcjtdYhBUB52Wzxm+ZrHm5U0OC5dA53L4Ot95lqE4IpeSumVD46KAH
X-Received: by 2002:a05:620a:4110:b0:92e:6430:3c73 with SMTP id
 af79cd13be357-92e9a385325mr1203158885a.21.1783288852999; 
 Sun, 05 Jul 2026 15:00:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4110:b0:92e:6430:3c73 with SMTP id
 af79cd13be357-92e9a385325mr1203146685a.21.1783288852171; 
 Sun, 05 Jul 2026 15:00:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636ea60sm284187235e9.3.2026.07.05.15.00.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 15:00:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 26/32] target/arm: Inline check_watchpoints() in
 arm_debug_check_watchpoint()
Date: Sun,  5 Jul 2026 23:57:22 +0200
Message-ID: <20260705215729.62196-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX7b+IYrzeEvWt
 3ptHNNeXHKQJIx1xYVbiixjlpHiQ7dU+LXLxRvEmxmhZoWs4lRh9CTvqM6z732bk1DbQGw58l7N
 9Yt/LCBPmKRbm6qBqYvGJWAvsBDUcBz/fPiEidOQoJHhwC0Bk1eMPN9sQwPSB0y0JK9WErp2l1q
 AwbcFmYYaYB5nHfi5+oQ5X6KuxQLJgLY6Sn09elODIu4Wd5eYpx72JkXzAG/mnahKk80tTydnq4
 Ebcz66ShH7HiTaPaGntGh30JFbuiWhOYgIohnqdYp9EziWRUreqczC6bEQK46T/nlR5EJVG/RHc
 rOORfX8WX+JBB4k+8C8dBiuPGMaUsox36/oqQRAA2yhUDgsDa0aw80QNEJOi8GwdgAVWDBT2Uai
 2FwbVqqE9/qzJXxTSyoKKt/4XsCP9oV2x2CBe5vHJ9wOKZSOiWZG0MBIWhArhqq3UdLnuUurYw7
 O270H/vERjWRbsr6EZw==
X-Authority-Analysis: v=2.4 cv=VvITxe2n c=1 sm=1 tr=0 ts=6a4ad415 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FSafjcPV3XuXVNEPM0UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vJXQKP2of8585jT9F1nCvJZ6xXDoIpRr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfXxaIzYzi5KE/Z
 +ri3Jgyi69z5mfwU0Wf+ZFuz+77zYid6/cVm1kgigUP4L5NX9oYSOvZZ2RKlqzUXzFBUmaOVBYl
 kF5GF+uM5p2vzEU3dL/zWjFtWAXmX4o=
X-Proofpoint-GUID: vJXQKP2of8585jT9F1nCvJZ6xXDoIpRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050238
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

check_watchpoints() is called once, by arm_debug_check_watchpoint(),
which doesn't do more than this call. Merge both. No logical change
intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/debug.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 11043ecd589..7171501d400 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -351,28 +351,6 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
     return true;
 }
 
-static bool check_watchpoints(ARMCPU *cpu)
-{
-    CPUARMState *env = &cpu->env;
-    int n;
-
-    /*
-     * If watchpoints are disabled globally or we can't take debug
-     * exceptions here then watchpoint firings are ignored.
-     */
-    if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
-        || !arm_generate_debug_exceptions(env)) {
-        return false;
-    }
-
-    for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
-        if (bp_wp_matches(cpu, n, true)) {
-            return true;
-        }
-    }
-    return false;
-}
-
 bool arm_debug_check_breakpoint(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -426,8 +404,24 @@ bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
      * is also an architectural watchpoint match.
      */
     ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    int n;
 
-    return check_watchpoints(cpu);
+    /*
+     * If watchpoints are disabled globally or we can't take debug
+     * exceptions here then watchpoint firings are ignored.
+     */
+    if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
+        || !arm_generate_debug_exceptions(env)) {
+        return false;
+    }
+
+    for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
+        if (bp_wp_matches(cpu, n, true)) {
+            return true;
+        }
+    }
+    return false;
 }
 
 /*
-- 
2.53.0


