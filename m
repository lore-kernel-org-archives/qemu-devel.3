Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF9FCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkt-00050N-OG; Tue, 16 Jun 2026 14:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkf-0004Zz-VI
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkb-0000S8-CV
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOewK303370
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=e+BO43wzAIV
 a1OjcMaVblkps9FSWXeUailIm9njhO8o=; b=U7lnG2/Vp9uBcIIFeGTCJRYz3l5
 JLYag/Ak1PtJNhBFkpsPZ5oo+cgxB4RuUIFjFSIduZq4LWekPXih0hBNRam49Rqt
 FGQbFt2qmcpKSWkb5lHPz19SLTXS8W7ivIuCHzX8utfQHf572QSjG12cRycrh1KR
 mc9U9KKD6U98OmAAubqVaAi+7a2UsBTbSP6Toqy0hKIXUxhGwYqANkhUhmzraXmI
 QJrROohdn7ZnKbubaNH0VawYC+t6fX2HyF7jmHLXR7wLTZLagKTAn7PZSkpgAQNZ
 2unrkdsl/28Dk6Fg0xN8DODN1tF8YZ6GrcVJXDwnGw2OFwKA0exbp6skJ6Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1epb7d5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:52 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8423f1fe39eso5669478b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635371; x=1782240171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+BO43wzAIVa1OjcMaVblkps9FSWXeUailIm9njhO8o=;
 b=aBC46QtcKc5GM9AOe/35aEscU0iGgECB/XQ/s8nqQoquwxE0hurSJ3t+XcE+QPHXcz
 PiTwcc0+JaW4YzKg25Rtm3yIds3tmtdEdGAiyzC9rkkj7Xhsp2R1tAbe/qkmTQWYRriO
 SHrtOdY01PUhQw0uTOOaJXlOxuFnHGy6VMohXP6nRLAMNcJIHTM+WAwH5md8KSBWamZT
 2I6nUwzUVxsJFeJSAwWDTyYDDC8dTUnHVvmg3cQJOJWDhlFj3dcMSOkjH6UERiE0I5Ii
 HEEUxU7sVHQtrNi/CosJLIXiyap/NTn8bu+92QDrUYgbZS/Ka8TROnf7/5stVw61/qzs
 IrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635371; x=1782240171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e+BO43wzAIVa1OjcMaVblkps9FSWXeUailIm9njhO8o=;
 b=KnC+NVwwdRM8/949/zBBLH3EyAhBSN+AmPmbc0Mm9Mw+PxIS1rMPdXCRD3Fj6lJY2N
 up/C/rroaydRpqe2EBB9SxTx3dti3awQHTHf4tYzV/HIdvh3woKFm088ZbLnfTbTUcbe
 NgbViP7vrg6P49pnowVk64z4trkzWb2t6bJMZvrom6GmAtRKP96iikiH91hxVI4u/fW5
 Jvmi9zhPTgXK5Ebs5ZN4rbYqQn2jdz2mLy2xTbdqptkVsLEhwkH98eI2hRAiJDzPcZTy
 ImqTTB/pkUx3w1kfbtiJL6/VutrxyVqxZabxJAbPKuQD9W7HTmfiDeIyyOM0vx3VLiHT
 yafA==
X-Gm-Message-State: AOJu0Ywbz4CAkPAbocsKEGZUN/pY0LMEhsrtxLSKyCOdXj+anavhpRSY
 5xvAjEf5p2UWTLpUXdT9YE73QxwJEl7m1W9gDh5os28OSaMy6iSI0KE0z119NT/g0Bf3l1Cn/ft
 IsO1JERHsczzKl2Usiiqgs9BEhrZK+htjQk0rAUnpgVq9nZ9ZHNCAN/EOdNbqQ34AZudx
X-Gm-Gg: Acq92OGRLXdxIbyaB+/BAwSjKUavApivpLynfvEQ8GAxy7Ts5khBtyy8dp9ZWTEOeCp
 g3HLf2kc87p+3ULDGxVdcPzfJG3lqmiQxBWRvnvaMtpC6ceqQG9QPWIZGBMvK6BMqmZvhBGnIrH
 IgG1vUt/LmDFq+gcXq2Da0dCJqeUUf/3+UZqQjKxiOhbdENf6EOjr0e63WLTn9ASyv7hFcsq8hP
 pYtF3H7lPEP0l8M4XpwQRDtwTuXWaEV1mUMDHyTjD/B3WrIITQdu1DFTbeWU57XJiYbd+eTgMKV
 RSsvbQ/vVDwsZspbKuvk5gXqjSaZ2ARyavpbkwCkWUhMlDRwsI9zOiSL2UdQbpVLwU9JKQ5raDi
 Md3iaP89H9JXCdTH+ktosL0gS3o69+VrvWGqDWNetgKl9rqm8INlRu4p5zO9gI3Sze6ZPM18HAU
 UlFVC/N50=
X-Received: by 2002:a05:6a00:1749:b0:842:55b6:f5a1 with SMTP id
 d2e1a72fcca58-8452441837dmr374598b3a.6.1781635371215; 
 Tue, 16 Jun 2026 11:42:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:1749:b0:842:55b6:f5a1 with SMTP id
 d2e1a72fcca58-8452441837dmr374557b3a.6.1781635370601; 
 Tue, 16 Jun 2026 11:42:50 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 14/26] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_discon_cb_t
Date: Tue, 16 Jun 2026 11:42:18 -0700
Message-ID: <20260616184230.303038-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a31992c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ZiyQStk_4VnRclnpaacA:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX5JXsE52Mu6om
 Hr390nMipgLH9ksMQ4XaETc1zRK6Svj97ZEHX7RYlkmGpr4X2LNfXx914O73aLqmSzUqCjZbuSJ
 RbVny8qchd3qSrWiZFjw4OAn9vlYR9A=
X-Proofpoint-ORIG-GUID: YRjnM2vxmwCIwk-PI1yhe33htBCYCxCh
X-Proofpoint-GUID: YRjnM2vxmwCIwk-PI1yhe33htBCYCxCh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX7XM1PwaXZu6C
 EKRVz0cUbXNy7+4A6RwCrRhUZ+5uOLokyFbOaOeNuKQe6e1VBExhrbGjeHroevNSGd0lSccNdP6
 sodOsmBCPDvrhmgfF/KHEik/bcQcnKd/wApMkTeeKm3NCeMa7G6O5jdNqBd/KW6wHiQpBT3E27B
 9NnyHpZa2aV83CUFxzmol1i294/j8ANf0Ab5B5/9W75fMXXi/0zyCwkb8qx9eGoLB8NvF87NbsJ
 bS/ydP2oJei8sI8d4Peqw4k+Z5NT//bnFLIZ9JWF1trf0nma3KIDvOaJ4IriQNzncwOeySjdi9K
 ngxwjvuxsViBS4D8ArLQSzeBdxY5q822cJOoZLitv4pfXoJvfFoc2n5C+B59x/dtFXIqAJ9GutI
 XoBtFfkKBwKgLFkzQdEtFVQmztoqjjzt2QdQSodlam5wqJ7PGZ53NnC7kZ9w+d7357A8cLreTj8
 nBJVTq53jFZtqvzk9+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160190
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-15-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/traps.c       | 2 +-
 include/plugins/qemu-plugin.h | 4 +---
 plugins/core.c                | 2 +-
 tests/tcg/plugins/discons.c   | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
index 4d59aa3c09d..b6df4455d63 100644
--- a/contrib/plugins/traps.c
+++ b/contrib/plugins/traps.c
@@ -23,7 +23,7 @@ typedef struct {
 
 static struct qemu_plugin_scoreboard *traps;
 
-static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
+static void vcpu_discon(unsigned int vcpu_index,
                         enum qemu_plugin_discon_type type, uint64_t from_pc,
                         uint64_t to_pc, void *userdata)
 {
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 03e7b2b1fb8..60d27d8d9c1 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -180,7 +180,6 @@ enum qemu_plugin_discon_type {
 
 /**
  * typedef qemu_plugin_vcpu_discon_cb_t - vcpu discontinuity callback
- * @id: plugin ID
  * @vcpu_index: the current vcpu context
  * @type: the type of discontinuity
  * @from_pc: the source of the discontinuity, e.g. the PC before the
@@ -196,8 +195,7 @@ enum qemu_plugin_discon_type {
  * observable via general instruction exec callbacks. The same may be the case
  * for some host calls such as hypervisor call "exceptions".
  */
-typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
-                                             unsigned int vcpu_index,
+typedef void (*qemu_plugin_vcpu_discon_cb_t)(unsigned int vcpu_index,
                                              enum qemu_plugin_discon_type type,
                                              uint64_t from_pc, uint64_t to_pc,
                                              void *userdata);
diff --git a/plugins/core.c b/plugins/core.c
index 0da7fbf929b..7e4ccd37b73 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -122,7 +122,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_discon_cb_t func = cb->f.vcpu_discon;
-            func(cb->ctx->id, cpu->cpu_index, type, from, to, cb->udata);
+            func(cpu->cpu_index, type, from, to, cb->udata);
         }
     }
     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
index 22114830fdc..5ab645705e3 100644
--- a/tests/tcg/plugins/discons.c
+++ b/tests/tcg/plugins/discons.c
@@ -96,7 +96,7 @@ static void report_mismatch(const char *pc_name, unsigned int vcpu_index,
     g_free(report);
 }
 
-static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
+static void vcpu_discon(unsigned int vcpu_index,
                         enum qemu_plugin_discon_type type, uint64_t from_pc,
                         uint64_t to_pc, void *userdata)
 {
-- 
2.47.3


