Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D57606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dmTrrWUn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kOL3SFkH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgM-00044V-TG; Sat, 24 Oct 2026 13:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg9-00040C-Nb
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg7-0008Jf-Un
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:13 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OHPvjO3255293
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=duUe2HhI/k4
 8PIc36NXl6OAwzpMRzgixSQr+Hkem90w=; b=dmTrrWUnGo97O5zN8uP/kyAvpgx
 l9GUS/5ihWCqLUxJp1BEvNemiw2p4hDCTBxVv3Orjf3zQJUn9zc5tzxvI7vnlbkU
 8UT+IwJtNebidDCTMaodWodEeSr7TGKpRS/1u3HH9QN5wCMhWk4eDh/zXspove/2
 3WxAcEyIckAcTgyMgGN4ZbbJvdwT8U21GQHc3B+MRsEiJ9k7W5THthTrSbh5wElN
 Y0HW6RdxiHMODiNXwDhHhFvEZc39SLvpb+aXjlK5ltGzPlic9y4oik7VJzSZbblB
 yopZa9pBE3zYA0BQirNcbqxcQi5RMf3i+WiqROmRBi8vE97XZGRBXDOWz5A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgssfn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac0ae43900so1923583a91.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863430; x=1793468230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=duUe2HhI/k48PIc36NXl6OAwzpMRzgixSQr+Hkem90w=;
 b=kOL3SFkHr+5+VmfyPGfxIifbi8F2nZzSMehPYOFNOgPgpoZNIlh/QdddkByV6+4BSJ
 Q0tvRMVoob2fVQ1eWsaIt8rNK/koRNHsPCGqAVWYmEHMNrTcpAHhD2pgujp8WUNhZYUd
 OAS0iX4EmVZD+kbhysJtCfUMsq1RQPedHeUUgANTE22ClVhqQ2Z3+eYRbEuIAXDDGo1M
 f3Bq0fEG25dUevx0vAK8bnOtp7ebKrcxNaTqU88T6d1OegC/7i04BZlJsT/yQCTQHd/4
 1vCl6WgM0ZCf+MgAgJ7dGQz70KKAlCP20eAewOWLGNEBXSVW7O7mX56xvwTCREQLVEFj
 SwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863430; x=1793468230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=duUe2HhI/k48PIc36NXl6OAwzpMRzgixSQr+Hkem90w=;
 b=acD5/pFFltlpoUscOfoPNwGkirIg9KjvsFPzxhSZ496qCLJCwpgxI0M+wgDKzmgqle
 Ta4XIAhpHQRKZO1mvjdA7kSEGhx68MQX1uBGU1DSFuenLB/KFQyUWVc1857N7vfZfHNW
 pzcpLg69N/wZnJjv4S1cKz0Ni5lSxEgizYbtDsr1wlLOMrMNsiJO4QwyV635IIPiEF/l
 rEhTHIyDYmGe9dCbltKw0HimGxVxC0T/6zebH9UInXEKEDAmgSpVZ7xxGXgQ2kriONtR
 IGaP5uwUA9fwud6HKDVXFkihXtZAOE24wAEFZm/4kfo4734gEQY4nmWn4Px+1Judc8yL
 dgNQ==
X-Gm-Message-State: AFq9FYJWKX+vmSDWLfsf8tDFJq5mEqmBw70rhNoFc9qKIgv5DrUFSQLP
 KiOCGyJ3cL4qVHhFwi8nCxKo6D4QgG37KYZRCqdRsSaa9bLnhoPXhmKIGMduDJIpdFSShcOzb2Q
 IfE7yI5YMJpaR8W5m207SE6g3W/MO7DSHnCFPyBjokzefEZD8au3qwXOVtbioDrXmxA==
X-Gm-Gg: AYBFou1Oq5ZLX9bGegmKjpyJXrNSzl4j88NhRdM5PF67O/bDVlyboIZcS362LchYR4q
 AXr6XeX7gJ05RkPU5NaomtGtjOALsxFU1ZbpyhacPz35rPflkHbzX1MmQ3zt7LQCvd3PEkdk7d/
 92QsEdGSYzIxn9LeGrRxO7xF0gLvS7SFHMjYylTWMoZY6XMSY4SKz9wLty5ZINs/yBtMTZwofzo
 7/ayTokcgUnvVYMDV3N7AwncMJcY7906XtnEA/f3MdclWid0dsy4arh7u2aO+qVoZqnFeAj1E4z
 /RJszqprgfarCciieDoXfaKSUgw+eoLDutTYwhyp7XcBegaSLkYBNB1u7szGFWtTo5fyjLpaIU/
 odWTfc0edzWhd/Q7HjhuzYKUYQApQzg451ASYpLwSD02mXizwt8K5xMv3mDnP46A=
X-Received: by 2002:a17:90b:2689:b0:3ac:a203:e092 with SMTP id
 98e67ed59e1d1-3ade9b2d3a4mr2111403a91.1.1792863429738; 
 Sat, 24 Oct 2026 10:37:09 -0700 (PDT)
X-Received: by 2002:a17:90b:2689:b0:3ac:a203:e092 with SMTP id
 98e67ed59e1d1-3ade9b2d3a4mr2111392a91.1.1792863429252; 
 Sat, 24 Oct 2026 10:37:09 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 14/20] test/unit/multi-target: check QOM types can be
 initialized with any target
Date: Sat, 24 Oct 2026 17:36:43 +0000
Message-ID: <20261024173649.7405-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXx7wO5d+dbhHQ
 zLDOFFYKjKr6kxmmPw2ttGE01/XYgWyC6ZuSl8acqfdTUSoH31uookkdGg++bq9Xuqk5Q5DrlvP
 csr7Rdp/2ldc278hucRXttLxPuINDsU=
X-Proofpoint-GUID: QLsUMB3BFVYfV13pE5qy5ILFVjLvgjZJ
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6adcecc6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=kdKFVfqNwfA-NhTVECEA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX3OXjBvM8ZOFZ
 qLVxPdR2FwGb3lPNfBlKCaSGlJ/OML1InJPSXj8x6W09aKt701rGNhAySfGjWjNfVW2Dk9aBZbk
 bOIAemLeyDYaGyWEt+kOjXERvto2wfYXyLCAH1EHby7iDbXaneTJA2mgz2xrogT9LuEART2LV+Y
 Hf7zT++FSMjqC9OKWIznJV2cyDPu1dZYx4cFOyLQDrP75KFnDfe4C87TBA41/6NhO9IRhVtr1Va
 Vx8vDiOYh9f3Hc18SNgbvhTSlj/ZmCxkhGs0UMKCmLHWwjSvCXK7vpa2TmCNB6VhDGAhcsZGao8
 6MoyAykdwGiA4rwepD0MmJa52mb2oIJM0GOQPHRO7TEWdMdYLn2itw0l0v4LiPpYshxMzeUG/pP
 0Yq2KQzcVuz4oslQe1xkQdgksw4uzElWIAX+W25mUWd8izaThZ5+I8v9tIFdlNjIUC0a84mLQEY
 mVBf4j2iepLtfM3pDcg==
X-Proofpoint-ORIG-GUID: QLsUMB3BFVYfV13pE5qy5ILFVjLvgjZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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
Link: https://lore.kernel.org/qemu-devel/20261024061616.27381-4-pierrick.bouvier@oss.qualcomm.com
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


