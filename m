Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CB5606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cQatz0a2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZVZQelNV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKV3u-0004jC-5c; Sat, 24 Oct 2026 02:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3e-0004bU-26
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3c-0004aA-8E
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O2pfVR982149
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7SHw/ox01Ib
 nWRUOYWajL8EE/RzDTHR2IpZuk74+aNY=; b=cQatz0a22ZIQ/TvXs6CuxtQTOdH
 2LuMKUv4zAmgBYTAMACQMZkR3/uuW5xr5Ag+5bOH6iY6CKN03CNBOWrXLALg5Jvs
 jjt+HSVQDyR65898PawlzcNvIOwgEFFxymwSPBzrGPslMeksM6JH4+pZEY+lcA7O
 71r752Q3+WtRLxe9h9KpbdpJlKGh9Tqje3JD6AT7MtTn8XVtSbEhLbBQReK/ba07
 Oro9duhdgWH/blbJIX8umzKg+0a8R9b77hK82AirxK29xoVSKfj6IVfsT3zHo0ge
 krC479G64zMmhnd5efpuq/AirvYjNfAqC60ud3rD5wS6MrGJ1LuEiiTIG6g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xgc49-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ada8bc8575so2247096a91.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792822602; x=1793427402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7SHw/ox01IbnWRUOYWajL8EE/RzDTHR2IpZuk74+aNY=;
 b=ZVZQelNVujMOPHagxmeeK4lzsCIhDUPPunPzgZDIGWWdoYizCzSyHZsoAZDjOe5n0K
 pZpYmYh9Tfw3uHn8KWCMFveG2yAgSrcmSJP5xPxE7TJKXwiBWUfOYO1D5x3sCqf40NPs
 D/pA5d4n7nVgMEqwBKlPGWBP2N7sFtZg0/KyTTO3BMw9HM4+SUUOEALSmkl7tRTIqm9a
 d7aYjluF+enWMrY78a9rVSiXPaH41McGudtYPj3mpogYfcqPDbuNafFC3j0rD3onO+sB
 Tb3lb+8ULos6DKLo0p/HV5oCssjnXnTOzAfkqj9dE2+hmczt1VO5Qu8PBhqJtFMdlBwg
 rvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822602; x=1793427402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7SHw/ox01IbnWRUOYWajL8EE/RzDTHR2IpZuk74+aNY=;
 b=SzpqxHxeGl9QGfBauv4WphyGpG4Gb62mUHa73L8uAY2NITOs5B1vpYRVEBSF2OrWfI
 qx11fmKxJKVr7vO9lbWM0wEseCb07UsdLehf1qfMKrxPVB5GprwZOgqMu+3yjoPJR1pp
 //0+H+WPLehWyVdpFhCcdOveJm2BL6hr+prM6I5Ilu5Q1CaTCxAhQC0li4rEjlPbdEWe
 FbJ0RpwEraIb+aw5tb47icW9NUzLzUTriVU0WPnIS6BSVeSNUDuspO5FK65hhu46Dwrg
 ul+saLeXkn/IlsPd7F0O+4jJna52kkUUofkRkVM2Iu67coXsMMwBdNNjBlVW3+kTRb2c
 I1QA==
X-Gm-Message-State: AFq9FYJYIQXwlbNH0q2aDuUnLpvXhRJbe7QAouUNh8gVqkHe9XeOyWzS
 I9iXuN/YFTU+W2figxHgghbGECwAKLxLX8ekQ4iosLtj3bf29QB0UfcynP8hUF7aDsQT32054Pi
 3UnOkndUFhd28nAUQdA1WHH3GV37A4DcvkvV9h37Hykh3G6zVTVVHOnVwiPwRuNHN2g==
X-Gm-Gg: AYBFou0wMu/1wuHNfW5gUH2U0Jy6aanj4S2LD0p1v8oElMWWxseQ4kfWUfCIXRluhyZ
 lPsP6spzqsR7Ykpw2E+DiYjNaRLh7obQyjtXzJwwMpgY59tSV29VC4pu422hrzrvIhE21aDMT/y
 9K2DceOorS9Y2iZaMXJO5OajN5disAeuFN+herMOOk8s65EXwAQXOvsMu1cMfa/IY3Bg9lSZPZy
 cX4XW7vOxRuTmoyKZom78v5y6Jrz/ZM1FW9aEg/AtyTFHaIIDdkCTXes4DM0wk4I2KrMkaSVzcf
 UVtyoJLbumuIqsGVMHZ7DMiWnknwWEKWRtuLVnyKER9Iia1lSLndykqLlnHBEsEE46DHBS0YDlA
 8VRLDukZ7j2spW/PqmkqPng+TUWwHiou8wsIWLWA2TLuap6ov8nPfA9/i3V/BA5Y=
X-Received: by 2002:a17:90a:d405:b0:3ab:4f1:4f7e with SMTP id
 98e67ed59e1d1-3adead49530mr1135547a91.28.1792822602140; 
 Fri, 23 Oct 2026 23:16:42 -0700 (PDT)
X-Received: by 2002:a17:90a:d405:b0:3ab:4f1:4f7e with SMTP id
 98e67ed59e1d1-3adead49530mr1135529a91.28.1792822601625; 
 Fri, 23 Oct 2026 23:16:41 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb1e37esm1074882a91.4.2026.10.23.23.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 23:16:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 3/9] test/unit/multi-target: check QOM types can be
 initialized with any target
Date: Sat, 24 Oct 2026 06:16:09 +0000
Message-ID: <20261024061616.27381-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZFZGqE4c6_02gZ0njixZtuxqkrq0hXBg
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adc4d4b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=JF9118EUAAAA:8
 a=EUspDBNiAAAA:8 a=kdKFVfqNwfA-NhTVECEA:9 a=iS9zxrgQBfv6-_F4QbHw:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX9l3NohNYgHeR
 5RBWF62zqivq7yOcf/tp/ImMO6doZPJpogsoJ7s34gfeDkjoyQyQGmILZHoGIxYQ3kA8nX/3+u+
 5ppPkPOynok7Ff+SED7ugqUbCnsos54=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX19yMsnSv2G7T
 E/8RI1oq+TqPyRrcWM83dqaL1WFIfpY28PUeJbmnflK2yuoeYIOdln3dxPT+dSp24SBAOO1Qpfu
 mBrqaoPb31NxcQLRaVEVHPwhd3gEfkLPdehi2MyhI7PHf/kOXm49Xoq8VsWtoIk4B+aVhzo5hIQ
 8a3yLSdzTCKVKLvbmtkQhaVTIZxbfT9SBDQ4rCgPpxxsY/hCQRKHxy6rUtRe4cOGhYrgQx1zGeJ
 o2+Rfn8Y2M6ovnIukJ+d73yysJkgo2m4YJSFSOFmfyShKkkQRWQXaRFjDiDXuABn5IE52mkqMhN
 LZu6NAMcmjBelANhDzb5s61Cs7qIBE7ls/lGFqqyjOwzyMOjnGn7rd2hyMvgaFwLDUYKOUAKVqv
 xqH8Sj0u43YgaHhmzDNJGwhQuohCG2wL9+9iDz7HHxJAC8IcpFJXlto/9suEf5yeDdYbGwlSOqL
 U6G5Bc0kQMLuHTYAipA==
X-Proofpoint-ORIG-GUID: ZFZGqE4c6_02gZ0njixZtuxqkrq0hXBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240024
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, we are initializing QOM type after having set target to the
first one available. That's not enough to catch conflicts among types
within targets. Indeed, we'll miss some conflicts since some types are
registered conditionnally through .is_available.

To ensure full coverage, we detect all targets available, and generate a
sub test for each of them. Then, using g_test_trap_subprocess(), we can
recursively call only this test in a children process.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/unit/test-multi-target.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/tests/unit/test-multi-target.c b/tests/unit/test-multi-target.c
index 89b55bb1632..c7559827a08 100644
--- a/tests/unit/test-multi-target.c
+++ b/tests/unit/test-multi-target.c
@@ -30,13 +30,20 @@
 /* stub for system/main.c */
 int (*qemu_main)(void);
 
-static void test_qom_types_are_unique(void)
+static void test_qom_types_are_unique(const void *data)
 {
-    module_call_init(MODULE_INIT_TARGET_INFO);
-    g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
-    g_assert(targets);
-    const TargetInfo *first_ti = TARGET_INFO_CLASS(targets->data)->target_info;
-    target_info_qom_set_target_info(first_ti);
+    const TargetInfo *ti = data;
+
+    /* QOM types can be initialized only once, so do it in a subprocess. */
+    if (!g_test_subprocess()) {
+        /* parent process path - respawn this exact test path */
+        g_test_trap_subprocess(NULL, 0, G_TEST_SUBPROCESS_INHERIT_STDERR);
+        g_test_trap_assert_passed();
+        return;
+    }
+    /* child process path */
+
+    target_info_qom_set_target_info(ti);
 
     /* register all types */
     module_call_init(MODULE_INIT_QOM);
@@ -47,7 +54,18 @@ static void test_qom_types_are_unique(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
-    g_test_add_func("/multi-targets/qom-types-are-unique",
-                   test_qom_types_are_unique);
+
+    module_call_init(MODULE_INIT_TARGET_INFO);
+    g_autoptr(GSList) targets = object_class_get_list_sorted(TYPE_TARGET_INFO,
+                                                             false);
+    g_assert(targets);
+    for (GSList *elem = targets; elem; elem = elem->next) {
+        const TargetInfo *ti = TARGET_INFO_CLASS(elem->data)->target_info;
+        g_autofree char *path =
+            g_strdup_printf("/multi-targets/qom-types-are-unique/%s",
+                            ti->target_name);
+        g_test_add_data_func(path, ti, test_qom_types_are_unique);
+    }
+
     return g_test_run();
 }
-- 
2.43.0


