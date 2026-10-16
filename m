Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBC7CCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHrGm-0002tl-7B; Fri, 16 Oct 2026 19:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGh-0002s0-Ut
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGg-0001Rc-9I
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GNFF8B2784038
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UzKA+9MPV9r
 f5Vn+s3w4oWu6tOQrHnEZs4Q40GXZ4PM=; b=OGK4XjrJkC5+Gygu6aZLr8EiFAj
 EX2uk1StT4BBeOVioFFe59bdKLRuusi4gXmmIUSg0Ar9FY3JE1fhH1NVFN8T8dGH
 S8EF1wusCFtvj8/M1Qlm82qf2ay7yuriSOt9JwT+JFb39q4Oi+T7jUDr2T2jbXqC
 kgCc4cX2MhThXjZ6dVlmeAUvB3rhN1cuC3Px4qUeBdf4or+l5jS8j7bbppWh8DDf
 5zF9B/Bsqn6PDFz+tUTrSNOzo/9dy9jNs2SEEok0nSk/tPQhv1kSZ89Rc9GGdm4I
 NHAqhYrjCfP6yDdkU2FeFHbxAD+CdZTUzUwBSGmhKb7i08yGF6C4dML9eZA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbk3v2f52-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac76132001so301210a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792192996; x=1792797796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UzKA+9MPV9rf5Vn+s3w4oWu6tOQrHnEZs4Q40GXZ4PM=;
 b=TzEemlz3xGewAILEjTZRPmCvq4Wds0Msj6LzRsC6lQd3K59K60HfSnBy6A/nQBMZjJ
 w4+lf73TWjKlMG3b1fwVFZaJoy/yU7WLcFMttVh0OCtHb63nu+kRU5JHGbHGlmhMisgb
 TQPF+fFjNFLb1gLIqgw+QhSvhuvQM+2id7nRdICliKB9n+9Mw9MjoAlZK4ygo2VqvZRg
 rVd/cDAJs+lypLRNFgg45LJZxCGV33QXvsXNj+8MiPUcwsnNtpDBegom19Adqd3Lua2Q
 0KkVu1S7Tg9C4io7ICq7PKD/yeMBgblatLq83hVtLf1CbBlBpy79S2L8t4oMxwazGUpF
 eZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792192996; x=1792797796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UzKA+9MPV9rf5Vn+s3w4oWu6tOQrHnEZs4Q40GXZ4PM=;
 b=XKfrX6+vG81JKmUbp5xVIi8l1zok5Ozuw0j1QL3vS/tDshfMqmWNTUMzifxzM8pVUO
 dn/s9dVfzaxIaBgidpKKhTeBFGwTZ+yFgNAumshF9aEBHmRMqjTI493Nl9Ae0VUEVRsC
 y+tJiA2KxG5OFfatyr1NHiTeUn6ygBR+Ur7HjfkpLTWVPpGjUPsMyPUwGgatWY+CjCc3
 DYqA6kx4QGFjZJFLCMgDIn5Hlk2j4+3UY0NH6XI2eBjZUHw5LFOeWzQ+ofDTVHht5PQJ
 hoVKN8IgmyR0ujoK4pXNQKKWtMR/PoII1zcPaTMVJqc+Ab+tn/3EAQZ4WamkmafeQTu5
 7REQ==
X-Gm-Message-State: AFq9FYIXI/BAXZWfLhFMm+u+O2ub5b/5baHGLa/yehPQWfxU2Yichb90
 PwKFxU2+DzpAE+hLVEeuXGnlTg8mTCrJsdDVjagu8hPPb6o10l91lJWAblY5NBUVgo9BRtZUIHm
 RDeOF5xxsFpGSBb6E55Btpwa9LScHecNWfyj0uBne0AcobkCgTIwwLpIUgDAF2oul/Q==
X-Gm-Gg: AYBFou1FveRBnJz0q9UExaZCDBRBUyDmmwzONFzNexHKt52Lp6at/4eedB2XPYu2EFQ
 407EhM7Tl9L3MmPGmr50ISD5aww0NQgnuQIQrd/Vt/kLMDBkgcNtLfXWZZgQBBD+R5oUl0LLbrU
 VtGOnNLqMFrPtvGqK2Rn2i8/0eMEtCam9YE9dn/eYhjVI/AKzgX6tUA/CvYVuDw1boWykxDeYyE
 ruWG9W46RH8fKEjecAnP6qsIKCtyv1syScxV3RTBn3Edpf5EaPsdQ7pxutjKMwEiXg0ZAOMxY8q
 Rz6Xdb+211B5ChzNUbLteCT1PLI3w9dE+gSfLxz54kqZelt2558yLdpSBdBiRDn5HPwNKKqEOCA
 pnmWqdGK4bXGlx8htxZ3bSUcJsltK2nS/PFqxwIkkvRpS0BgYJ/coFoRSJsYz9Zk=
X-Received: by 2002:a17:90b:5825:b0:3ac:7c52:faf6 with SMTP id
 98e67ed59e1d1-3acee2963bdmr985463a91.1.1792192995570; 
 Fri, 16 Oct 2026 16:23:15 -0700 (PDT)
X-Received: by 2002:a17:90b:5825:b0:3ac:7c52:faf6 with SMTP id
 98e67ed59e1d1-3acee2963bdmr985419a91.1.1792192993507; 
 Fri, 16 Oct 2026 16:23:13 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd0cde4fdsm2829304a91.4.2026.10.16.16.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:23:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 3/9] test/unit/multi-target: check QOM types can be
 initialized with any target
Date: Fri, 16 Oct 2026 16:22:58 -0700
Message-ID: <20261016232304.1215119-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: u1sYc8QbicfhN-s1VmxRjEyuZ-a6frBY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfXygiEPZsLehFN
 05FA3jxcigbQGXaCSVPy1Uivww9Q6/ZQPFWUxm7Y4jLpP/1F69IT6eAt76QYqDe658Cm8w6/h/C
 1ddWkV5v9iJ5uSRiucE4F+LNNGnxE7U=
X-Authority-Analysis: v=2.4 cv=BZdNQbt2 c=1 sm=1 tr=0 ts=6ad2b1e4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=kdKFVfqNwfA-NhTVECEA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX+zFoZy5Q/I3p
 fcmaTGa3/RU+Mjbi9BH5QdOGZgcBVoJHYYbpUztbrwhLClmViYuvz4LW4EVa1+7Hj/PsZJJ2shO
 BvbvyGpUnaeUtW4mofINiVIpXzDgUp1DbqWCQKpgcXNNxlKmCWtBz7uCU3lqoZrGesvVWz7ltXE
 Ru460KTNzeKLWZWpbySQY22Y4kNT5PestdkYiPBBUqJH0LECbuqf2h2IZWoIjnbHjLHuUCDh74t
 G1wfRpEqPxmGOPswQOkhO71WK/TBHTNo2jDA4G06P1CMDy03Ao3gJqviDF5Xndf6onQw2t7hgZe
 seIy3+J2U7U+rDbKtPPL65HO9Pz1s+AR2v4JFHDHoTWq6hjV6jGVL6TF6s02ylpDfMkJb9zmIH6
 kFfnhz9LKHxpF6lRaUQsKEVyB0sMxr1Rm0vA/RDIWTsYoTLYPYI2Zb48OO21ZS0w43uRhJrPuTw
 CrwVmQhWbfhhZNTu1wQ==
X-Proofpoint-ORIG-GUID: u1sYc8QbicfhN-s1VmxRjEyuZ-a6frBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160093
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

Currently, we are initializing QOM type after having set target to the
first one available. That's not enough to catch conflicts among types
within targets. Indeed, we'll miss some conflicts since some types are
registered conditionnally through .is_available.

To ensure full coverage, we detect all targets available, and generate a
sub test for each of them. Then, using g_test_trap_subprocess(), we can
recursively call only this test in a children process.

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
2.47.3


