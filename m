Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6431CCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkkR-0007qH-48; Fri, 16 Oct 2026 12:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkM-0007oS-Ol
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkJ-0002Xn-FE
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5i9d3506084
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7H0119CL1lk
 rEFaf6nefTLdIawij223fOc3YYX1T8u0=; b=oBEVmcnvzLHT7nii75RZMyVJ9+7
 FizNiNm5Up7EaqlPDqcLPhCw/VW+eyLXvlxmGBUdLxx1eLCSqJf5ewMxdyIDimw7
 Y6TEv8JZExSMgVfQhCOjFTAuWVQEsQzyiU4ngckw32hiAiQPydHXN4aRZ60rWdhL
 jAOnHjc9lWqq3TWnv7ETi9HryUZRrj6/J9WRMlkM3AHjZ2IVVAbUdo/Jv9oWpsNU
 hh4CPLup2iC1YGzuVRtjGF+tIqXexY60qBZlkiuQkwIFF1LrLlzLycTug5aG/W/q
 /utAHViyN5P2oKvfhiyUsH+k79T3Gi2IoFBFRvdQvNB/ooa+kOxDKfogZvg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8r13efk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:18 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd652c0385bso82042a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792167918; x=1792772718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7H0119CL1lkrEFaf6nefTLdIawij223fOc3YYX1T8u0=;
 b=CTBe8vT3aJRzi7CqM2y2E70meduYH2o9qZ3wczLcXDeHw1TYFBNrrVAlP94kwSVgX0
 WWsvrk/vGw3uet9HZy1H9ptGStG0B+BHJrKzPzJ55bEWDhISa2P1wZZhrbaJU2RHAlLQ
 KN8yqJFN7QZCkWtDZemVqtN8PjMlaxSYsCDWRimwWcqDw+xMp/NcqFBUGvbQPWFScNXM
 fikKeKzBXnyD3KvNt3k9IamNwjSFK7N5r4y7itzDer3p8jD0bGRXHpmSqK0BWEv+vfq2
 qKP4nGYOO8Cy+hz98B8grQXYvFxDmsVU2kUUjVf2L4uTqQagLD9KjdLF8XOx9hTj5zAs
 2wOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792167918; x=1792772718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7H0119CL1lkrEFaf6nefTLdIawij223fOc3YYX1T8u0=;
 b=WkZO87P8aJmV1o9hN5lsDkTcarm2oYYmzU3+yaqWkQ4MhYzrKd/g5zK1GWwFpj+wkl
 Am5hih9raBrGVpgXQq/v3ew/Zpm4MLwGDgJpwrkEJzm9MIVnZHxitgBRY0X/aSQIGpLD
 oPW1qmF4g4lc3sSopGrvuTGjy2VSszhhDF4bsXB7fATPe4ryDUqVuyDz/fdLVoOPv9Yi
 kPzQQj+ejiWFzGOsym2AWQ6alsQiwkPnOzjCD+L/s1invqNtt4wKC5PJ1l58jJrOw+sq
 z//yB9vKfr56ld9Jyd6PtnCinSRtw6ZAEVNcCZz/cVov2Xg0ZWgHBJLqLtX0v+l+s0Ra
 fSMA==
X-Gm-Message-State: AFq9FYJx71IYOo+seYUiuKCRI3H4En8i66HhmPM4dNiUxsuTfxiRvtTw
 Yin9PDWUMo9s54/awXCsyAxf7yklDE2OeJOOaGhPc7GX1u3OsfBwyvXItVvFI2x7sBNzMJhsx1K
 Ou56Fs/u78DHY5unQUKXfQDv6o9X6/0fVIMlKC/lcCM+hZFu0tGY0Ie7YubS6Ih9uxw==
X-Gm-Gg: AYBFou2lbabAY9yXdbeU+RA/5bf1PRBx2Ykaw4M7PS1tHsNejoNbAKfi/6VYrsaG6Ij
 Yd0Kk4c4FMN7D3zewFyCHTYgwWMy6jomUb6dUgu0h/oIfNKty9rvXSczDdVhttTsqcSWzosD71m
 +q9lTiEc0Y7v9zZycy6sT27kpDvVoPw8ockZKqgUfsUWxvNFrmesEsg5z+UutEP5sMwx0ylYSxC
 RyKmKP+Nt1L4u0YacClp0FE545MFkX1/iZtGjlECahksxuVCilgyqPy6dv/cQFrqtIV+uP63P+s
 MBFEBu5+IyGcbUF3uIySnp00EXiHjbnKVtArCx22AG9llpXwMHOb5ANL8py5PT2iJQzQfEH52Sa
 He3nwJhj9yDgum5AuhHmnnnyAen2NNL1oLE5/z7YYHeb1V5ROjRMs0IojGOd4NDA=
X-Received: by 2002:a17:90b:1c88:b0:3ac:17c:6e8a with SMTP id
 98e67ed59e1d1-3acef4fec74mr293880a91.51.1792167917626; 
 Fri, 16 Oct 2026 09:25:17 -0700 (PDT)
X-Received: by 2002:a17:90b:1c88:b0:3ac:17c:6e8a with SMTP id
 98e67ed59e1d1-3acef4fec74mr293850a91.51.1792167917102; 
 Fri, 16 Oct 2026 09:25:17 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc4872861sm5246143a91.7.2026.10.16.09.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:25:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 1/6] target/arm: rename qmp_query_cpu_model_expansion to
 qmp_query_arm_cpu_model_expansion
Date: Fri, 16 Oct 2026 16:25:04 +0000
Message-ID: <20261016162509.24854-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CTm6BMV2D_A0XNwgS8B2yQUnMDwM5BHv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX8qhbXflqQQrU
 mzVh5mQjB9Arey2j1JZAU/NLGdTmos/GEHcvcGOaevRPhlp7MHv+Et0yKqXNeqAyyP95m+5ysBg
 9z60jiYmnj38encs08hXlz6taXKjKbY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfXwb3ZHQ1yPDkr
 xDZeL5ROFeQlC6bfKZIXclYgQdI0TOb3ygauu440gd2wk5mDEex38vZ6WD/U0Rm+vjC+7+Bt0Rx
 LwsKJtTFLVA5CuKvAtGRq3/b06kCnTpGAsnI6dfr8ile0Ir5GI8nvCISZx5tLw5smdQQKWO/2QB
 y5W6Q5ywdiJ3gNOLDN6HcOhdDBqQts3tqSgpRa3b+X/RzIp/Ubse8rzyYjODk7T3r7g+EXWlPv0
 izjCI9y4uli2FJRPWYjrdYz9ECtNza6tON3Oq7igCB/8TEAgC4zp2dH+qyuZ90wCgEeTMtmUufX
 DdN3yzIQHRu/vmwERn9pK7ldsmzbIZRBjlJxBAg1NJHsQuojJmMM+FxKyQdA4LBH+c/Sh4CTDss
 uycWQIju0AjjjEheH05ATaBEKOnwjzpcgc0j5xO45MKtff5UJM3PVsl1gRgTqqinjbd6n4sK6xm
 CUH/T4Vcv51IonPMNNA==
X-Proofpoint-GUID: CTm6BMV2D_A0XNwgS8B2yQUnMDwM5BHv
X-Authority-Analysis: v=2.4 cv=L/CI0OT8 c=1 sm=1 tr=0 ts=6ad24fee cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=sdP6eRXOC6WRn2VZrgwA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160065
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

In a future commit, a single target-agnostic qmp_query_cpu_model_expansion()
will dispatch call to the per-architecture implementations based on
target_arch(). Rename the arm implementation.

We keep the existing qmp_query_cpu_model_expansion() function to not break
the build.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h  |  5 +++++
 target/arm/arm-qmp-cmds.c | 15 ++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index f0e0d427e3b..d2e7c76ca25 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -17,4 +17,9 @@ CpuDefinitionInfoList *qmp_query_ppc_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_riscv_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_s390x_cpu_definitions(Error **errp);
 
+CpuModelExpansionInfo *
+qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
+                                  CpuModelInfo *model,
+                                  Error **errp);
+
 #endif
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index cef0c27db65..2614aea258f 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -80,9 +80,10 @@ static const char *cpu_model_advertised_features[] = {
     NULL
 };
 
-CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                     CpuModelInfo *model,
-                                                     Error **errp)
+CpuModelExpansionInfo *
+qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
+                                  CpuModelInfo *model,
+                                  Error **errp)
 {
     CpuModelExpansionInfo *expansion_info;
     const QDict *qdict_in;
@@ -202,6 +203,14 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     return expansion_info;
 }
 
+CpuModelExpansionInfo *
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    return qmp_query_arm_cpu_model_expansion(type, model, errp);
+}
+
 static void arm_cpu_add_definition(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
-- 
2.43.0


