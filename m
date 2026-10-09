Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CFECA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJSS-0006YB-Ry; Fri, 09 Oct 2026 18:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSL-0006XB-Tl
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSK-0002e2-3x
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:49 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhksW2021214
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=J9GysZY5Rss
 DPBWWoApI6NRazDIO4o3udQj9mkDoCRY=; b=OW0mjkWI7CMpdPjbD4tFcfc4bLq
 9HezcFvWH9wnU0RA1WLQmNctrHNSCf98h0i+WdIDJRnaHTSmq+q3RVJ+IvPbVmd+
 hEEZO9uAoODrr6HONI3kLIessYyAv1ooaMTtp7a/7k/xlanYrZzZ2Ig14yRsByQ0
 cjsYldauX6WiX54SuKyiwKuyOT4oVVBdZpUhY99I5hpEb7Z7sYACNFEEYWGyg7fd
 b4F/ThTDEBIgOBmo5r+r4+DXgGfIz6hZo5tOUFyRdBKiyN6usDAIn0DfHOFwo5lP
 m8lt9hYEyYn9MkICFp3DJq9ii9cSCA5uoJ43rJPv+KtWa2PiMzViefl1LQg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t710ff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:52:46 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-14fed306427so673452c88.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791586366; x=1792191166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J9GysZY5RssDPBWWoApI6NRazDIO4o3udQj9mkDoCRY=;
 b=BdZJmdx+iwE7lU0WLERJqbOz4F4XTe3SzUAG1cfS7A0J6tWm2JNoC+m+iLDHzXGOYe
 Ip9HhPQX7oFiM/SX7Y69DOAyqbZVIHE5Km8XWuFdvW8kSWcIY9q0mttJYEUXMv6pz4QE
 JTvuaBqM149hN/gkOAcMXgOitpeEwC3Qhin5us+NZfvoQ48oLv4Z7ZM+/DQurK2aR5Jg
 zw28HziQGIrcBjuuwQ824J/PEY36rzqTrZSXl5lrv1Ywe02AKMPji1jUD59HaGu7g62r
 z9sSm3kSNGFY9rFy3NQjIxTFVY78jzXyw/ZBxTGMe0WPEdx73GnS+HAZkZmAmj9yyz5C
 hhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791586366; x=1792191166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J9GysZY5RssDPBWWoApI6NRazDIO4o3udQj9mkDoCRY=;
 b=xiYpLYwW4/or3ckvG9ztTjwucPppvumCjsiWJArydrJNI/YeWu++h2Uw2oQv0dgLlo
 U4RC1B2GWzncFDl5n2qrFoUReqVW85lIKZ9gwOO2Zr39hX2JV2JV7rKzZMF0UXq/Q2uM
 L4zCbhdJMsZfIi1Syu4gAhBEI7JpdbNuIPZyrYgnR7VtQzZ8tf9bvByu0Pck35IlZJbj
 rPHkpKzJtOyssFPrJFgPtWwIJTmDTQz74WCtE5a6sbRr1i/H2SL5dVqQI3aHr08ESQ6T
 TJhYfDD72YG7lFr9LrbjihbTegEmHmnBJk9NPYLWIUGyv9xXDnHIhgECadnmTexKyVXT
 CKgw==
X-Gm-Message-State: AFq9FYKVHGX9O/FiLlJhYnDC39Wgn4JqxKfTSlfUyBPa2V0FqYy2euKn
 mYAx/Ux4Bk4uQPqW18iDRYNqIvSTH/dU4CVhiS5WAHchN2WMZEocyz14QqMCi53/JojOO/x1iSc
 ohaLWonOlmTxUrh5wRa9mf2wGzpYwBSjpJp8Kmc3BeV8kxKAsYBWEVmaP0sraDs8ncg==
X-Gm-Gg: AYBFou1AtulLCwkUMOg0Jp+U1mJ55Ab3YL6+vrywHN+ZdC5H4FjGIxhlhi8L7SXhduU
 /jRGVRdmX+nfwDzz8tclgkdkaf2SAPNdPMMLRhyFxp0gUrWOhQijMSos4TGIE95Mi3vRZ3FMKOT
 E64Qijdmn9CvThWiTVVA9VsM/vv48gL6f5BPpPsSvT+Zu0w8JQksiH9FjL/Ww7jmGOgp/3hsTG8
 wTbBis7NVr1cFO2wjxHfW0eFmstTLftKRmBaXiuS+UWn83kDT0BplrcpCtTbIS/hyA5PoWMqJKD
 xmcYSmGbXP1P1cUr2ORRRKhtbUoG9UKSsIdDKaEvorLh2wkxFj9iivYDhOGPVABEJUe5DAn8MEI
 hts6SmZR7+lOIVVohRfT6DZic6rlNMvOSyqYjvlo+5DnzTI0tIrksRKFGauTQ
X-Received: by 2002:a05:7022:3a88:b0:14a:88ce:74fb with SMTP id
 a92af1059eb24-16a61d5c320mr5432555c88.45.1791586365975; 
 Fri, 09 Oct 2026 15:52:45 -0700 (PDT)
X-Received: by 2002:a05:7022:3a88:b0:14a:88ce:74fb with SMTP id
 a92af1059eb24-16a61d5c320mr5432523c88.45.1791586365393; 
 Fri, 09 Oct 2026 15:52:45 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm8443977c88.22.2026.10.09.15.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:52:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 10/11] semihosting: remove common_* functions
Date: Fri,  9 Oct 2026 22:52:25 +0000
Message-ID: <20261009225226.10657-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX6i28juh5B5DU
 Fen1MrkpUpVb722g0RLdRRPZNeRFgXvgCcJr6v0rMNkAsGUtb1HAmET3ZXBCKY6kYViFJyQCSD0
 v9aDk+2lqf+DcxE3ajAPRbwGBUCxm5BjUAZU4WMku3Is96c9UAhUo51CUD0tVjNW5YaWpTSWNgZ
 KlbZhYWLmL73NLE9yXOPs7jyGbe0/on9bGCL/+5wPUEt2vBCeNpxO3BUKfK58wAFUcnvbGUe1qE
 kQWFfBSmf6IhKAwYX4Q2FZM7j4qgrBfcsY6uXUjwNkwUNo6P86q9+cD0w+UsgMFlf44dsY3ZRHG
 d/nvJfBLQJKTvELDGbm/HL+SKvAl7nQCAMQpARJ2fM5Sznl8KdvI9smc0vRL54k87Hj3fbbRkgx
 DY9OhHQDGEBhH/TirWIofd6g7/dxSLLk3cwvd9jnd4ebtouC6GrzGZcsGYsJk7s3yO9uiLKeb7g
 d34ql60PnwKRCpAZfuw==
X-Authority-Analysis: v=2.4 cv=Zt94uN7G c=1 sm=1 tr=0 ts=6ac9703e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=lHUEnDEh36thAgea6SoA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfXzafqc0gKt9r3
 KXZkdFXvPSRwctEuhuz7qMrkFRZDg7kJms6hymCT9hX9IH+ewPKbqn4ZzEcQNj4iSA/GALTZTWR
 31yierMp+u4Y5ZvM1MvU65x5+wo5f8c=
X-Proofpoint-GUID: gDsKsX5BEu3AKxTYtz5A5Q6hnNjSH6oG
X-Proofpoint-ORIG-GUID: gDsKsX5BEu3AKxTYtz5A5Q6hnNjSH6oG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090091
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

Now that both targets and semihosting implementation both use the
semihosting ops interface, we can remove all common_* functions.
This allows us to link together the three targets concerned: arm,
hexagon and riscv.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/semihosting/common-semi.h   |  7 ------
 target/arm/common-semi-target.c     | 35 -----------------------------
 target/hexagon/common-semi-target.c | 35 -----------------------------
 target/riscv/common-semi-target.c   | 35 -----------------------------
 4 files changed, 112 deletions(-)

diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index 618f60f76e7..8875aec3c86 100644
--- a/include/semihosting/common-semi.h
+++ b/include/semihosting/common-semi.h
@@ -53,12 +53,5 @@ typedef struct SemihostingCPUOps {
 
 void common_semi_cb(CPUState *cs, uint64_t ret, int err);
 void do_common_semihosting(CPUState *cs);
-uint64_t common_semi_arg(CPUState *cs, int argno);
-void common_semi_set_ret(CPUState *cs, uint64_t ret);
-void common_semi_set_err(CPUState *cs, int err);
-bool is_64bit_semihosting(CPUArchState *env);
-bool common_semi_sys_exit_is_extended(CPUState *cs);
-uint64_t common_semi_stack_bottom(CPUState *cs);
-bool common_semi_has_synccache(CPUArchState *env);
 
 #endif /* COMMON_SEMI_H */
diff --git a/target/arm/common-semi-target.c b/target/arm/common-semi-target.c
index 5263c0435a8..aa5190ee16c 100644
--- a/target/arm/common-semi-target.c
+++ b/target/arm/common-semi-target.c
@@ -71,38 +71,3 @@ const SemihostingCPUOps arm_semihosting_ops = {
     .stack_bottom = arm_semi_stack_bottom,
     .has_synccache = arm_semi_has_synccache,
 };
-
-uint64_t common_semi_arg(CPUState *cs, int argno)
-{
-    return arm_semi_arg(cs, argno);
-}
-
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
-{
-    arm_semi_set_ret(cs, ret);
-}
-
-void common_semi_set_err(CPUState *cs, int err)
-{
-    arm_semi_set_err(cs, err);
-}
-
-bool is_64bit_semihosting(CPUArchState *env)
-{
-    return arm_semi_is_64bit(env_cpu(env));
-}
-
-bool common_semi_sys_exit_is_extended(CPUState *cs)
-{
-    return arm_semi_sys_exit_is_extended(cs);
-}
-
-uint64_t common_semi_stack_bottom(CPUState *cs)
-{
-    return arm_semi_stack_bottom(cs);
-}
-
-bool common_semi_has_synccache(CPUArchState *env)
-{
-    return arm_semi_has_synccache(env_cpu(env));
-}
diff --git a/target/hexagon/common-semi-target.c b/target/hexagon/common-semi-target.c
index b97ed6796f8..0a33b872e3a 100644
--- a/target/hexagon/common-semi-target.c
+++ b/target/hexagon/common-semi-target.c
@@ -59,38 +59,3 @@ const SemihostingCPUOps hexagon_semihosting_ops = {
     .stack_bottom = hexagon_semi_stack_bottom,
     .has_synccache = hexagon_semi_has_synccache,
 };
-
-uint64_t common_semi_arg(CPUState *cs, int argno)
-{
-    return hexagon_semi_arg(cs, argno);
-}
-
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
-{
-    hexagon_semi_set_ret(cs, ret);
-}
-
-void common_semi_set_err(CPUState *cs, int err)
-{
-    hexagon_semi_set_err(cs, err);
-}
-
-bool is_64bit_semihosting(CPUArchState *env)
-{
-    return hexagon_semi_is_64bit(env_cpu(env));
-}
-
-bool common_semi_sys_exit_is_extended(CPUState *cs)
-{
-    return hexagon_semi_sys_exit_is_extended(cs);
-}
-
-uint64_t common_semi_stack_bottom(CPUState *cs)
-{
-    return hexagon_semi_stack_bottom(cs);
-}
-
-bool common_semi_has_synccache(CPUArchState *env)
-{
-    return hexagon_semi_has_synccache(env_cpu(env));
-}
diff --git a/target/riscv/common-semi-target.c b/target/riscv/common-semi-target.c
index 7fa3bef6883..24c42254558 100644
--- a/target/riscv/common-semi-target.c
+++ b/target/riscv/common-semi-target.c
@@ -62,38 +62,3 @@ const SemihostingCPUOps riscv_semihosting_ops = {
     .stack_bottom = riscv_semi_stack_bottom,
     .has_synccache = riscv_semi_has_synccache,
 };
-
-uint64_t common_semi_arg(CPUState *cs, int argno)
-{
-    return riscv_semi_arg(cs, argno);
-}
-
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
-{
-    riscv_semi_set_ret(cs, ret);
-}
-
-void common_semi_set_err(CPUState *cs, int err)
-{
-    riscv_semi_set_err(cs, err);
-}
-
-bool is_64bit_semihosting(CPUArchState *env)
-{
-    return riscv_semi_is_64bit(env_cpu(env));
-}
-
-bool common_semi_sys_exit_is_extended(CPUState *cs)
-{
-    return riscv_semi_sys_exit_is_extended(cs);
-}
-
-uint64_t common_semi_stack_bottom(CPUState *cs)
-{
-    return riscv_semi_stack_bottom(cs);
-}
-
-bool common_semi_has_synccache(CPUArchState *env)
-{
-    return riscv_semi_has_synccache(env_cpu(env));
-}
-- 
2.43.0


