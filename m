Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AF9C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLKN-0003KR-8M; Thu, 16 Jul 2026 08:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLKL-0003Jd-C1
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLKJ-00078m-Qx
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:33 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBioik2355470
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VdBHu7RF6Av
 1LP9UREznd7urSlOX77onQNWl0K2prdY=; b=E9Va4riY3hERmR/6G0MFn7WceeE
 rRE7Aj3XxLFm5OAU4h9G5ixtcf9Km5gVl5NrHpdvdRQbiz9iw/Hys9U0FP1tEOjw
 ggcqltaPCuGxCQVVkQZt3nXLoKvCVl4ujoQeSIE+BzDraO81nRUlYWm7sOPTYtbT
 NZMn9EHeHB34WGbxiaYBhVjgOIKlKxffhFpvNUOmF8AjMd94PN+NM+qwpUGxn+fP
 3yuosyRqq2gSQSiqPgj+rcDp3nqC+nDKt9l+m90rq1YxlVmJ34s9fMSW+cHhSX5i
 lcFPsPSI6IPyODzGcbb9DGaVyejY0Nd7lzYX/fyHfRk3cuu8LeQdl4SS96A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fed064c85-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ac0a54110so1090292785a.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205377; x=1784810177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VdBHu7RF6Av1LP9UREznd7urSlOX77onQNWl0K2prdY=;
 b=UEA78a8VV7t5mYUcOABZeNQFLyU/Xet6XyFz2vrxjwlYqc8e6OK5VhsxV2HjcwQK7J
 SMmZjgrf9/bBZ3LGRm8wjRUTrpGYNUfq419fwFe7FMyolLRSRwogRdi7lySEH7weXyZ0
 lZ2ZSkzWoXXKBkj8iV6z0cpFyPJgRlsXHzHXa6le8whnD4XPRafQ0dfniMpqfz1jWAfi
 fFt3DaVVe8ynsDLsUBE/ZJtzPU+O+YyCGn6Xl7oXZfVHXn2hum3QmW1iqB8It2z1BN6M
 qKh40tY6BaQxTBxu0dnaj/9dg8/Bu9W9IGTYYAcfN78wvOoD+RuhAvVwvz+mIr6pldXI
 SvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205377; x=1784810177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VdBHu7RF6Av1LP9UREznd7urSlOX77onQNWl0K2prdY=;
 b=Uwr+QfL3bP+LwfC59PgGNhvrvyV7oSAgszVQdbFOXcIfASVDxwT5MjaUTZ8/sPA34d
 xaOo8cfEy4eVqu8NryPugDVHrL5J5hPp6n9x7keEGBZF0M+gokQeVvCaizUw75M1WPXZ
 3F9c2ZHC/aS7iNIIWaMzS4GZKl0bGpw68gqbtwFVzvqb2o1nWq+lf7rEMPPj1zUobUcR
 TfbS418R5bheY86Y7bKPSWMuingwFYFTZNSDNA3GjjfbZPHaox8VMgBt/W8Owd25TNY7
 PmpQJwWlMhXU3c3iEn81GAS4oWWIpanD/sMsvEoPBppGUHK15K+Pc0FdT79xP7Je/PUh
 gjhg==
X-Gm-Message-State: AOJu0YyO0vigM68B2+zVwT9Obsk2HZk8fQ0VmAhdTgcNhH8nSJDHRYAE
 fQNNBBuI73Yj9dewljw4D8tA7qW1wiPIfzJdbNcFEdpYfaTfgQLgFDhlQaXJeod0r9oBjfIGCIj
 dnO5QzjbyEITmKh9ZHZaumy0tlZ9gHwhe53IG5vQXrJkWNwWotARsCpYfd/dFyPV3Yg==
X-Gm-Gg: AfdE7clrRhIFj/eMXlAREcOTSPjPtx72orbGV70vehBwv1LxZ+9Fwk5QIWD/iVOAk/s
 zkNIUxaIPNYDZLPCcWV/a0/ffKJpYD3fceVcigDFCXK2+FWVrDWOpKk5N2PiZMSLaHjqbITZpJx
 yeWc/hbxEve/P7vKZDHpBHJZzWxfMsb/WLqBWlnAHtFMohhw6vvNUqFN4pExVVtOm080cB/uwtR
 uuuABHyzFg5jGxHclvuweSAWaSy12eqqiDgWX69ek9NnWeeW3JEIBm3ktguw0ApL6R4hBCwi7Qo
 QDDACUXVo0g7YjMXT/tOF5hbGEJQWntDXSDbydhkU8yBv9CX3ZVr5zkhRL5g3Q2g8FkYlza4nZD
 VAwyvQU6ECAyx4xGAYZ77mrRRZWgJ2tOM6YA=
X-Received: by 2002:a05:620a:8903:b0:92e:4927:1ff9 with SMTP id
 af79cd13be357-9309622f306mr770335885a.40.1784205377069; 
 Thu, 16 Jul 2026 05:36:17 -0700 (PDT)
X-Received: by 2002:a05:620a:8903:b0:92e:4927:1ff9 with SMTP id
 af79cd13be357-9309622f306mr770331185a.40.1784205376458; 
 Thu, 16 Jul 2026 05:36:16 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:36:15 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 13/17] target/riscv/debug: Fix migration post_load
 icount_enabled() test
Date: Thu, 16 Jul 2026 09:35:30 -0300
Message-ID: <20260716123535.3709148-14-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfXzmmv2D7y2Il4
 G4/pNvMJ4g+AMA16x3Iv4uWRsZf6gVPrOXm3bYC/BrTZvfAeGehbzHwfgb7elHpl+vGTrUf6fQI
 msEAimHHQHAvDmLh3PceVyDBEe4yT04=
X-Proofpoint-GUID: peSUdAcXKnXhDiYyGIAZDmOJWtsFiCxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX+SnSViCPcFnW
 tDl5z6m1y92UXexPoCOgOFt4uCvmibvJKBf1lcmkeEu4VpcFofyhtf9Xha9PBKvsCQYkI/6uDMy
 c0tZEK+F7jluzzjj8xTzsLhNLPB89x6OR1Wj5vCGXlNZyOeIusbvG4MKECvkcCnSSWVqVt4HYIz
 CDf2JXIMJq+5kKLjUm3wi93yuWqwRvjh5lVhOea+ke6sbV3Ni9dUCN7coEQ23GhE2Jb+mY8Z2C4
 FpKq5wj8WGUSpXD4QS5U10dymOMvdUWtSBoTmgmdw0Bf8R/PrvJzBYRpPLYJqfQVhY8lUi0+ixP
 eLycLOPRudH8iuujcHxqo7qdX9MjLdHU71M4qUo5e0s77b4RgQ5AzpTemJBaKcLIznGIdEvT9QE
 clfdzDtDAaECMQMForA+ZQ7reZOH+7P4KZ/sCgYkVk/A/FqSeeN/JEuCPPfMNeDeIc98PHsp26P
 kyiIGiX4fns5Bhos1GA==
X-Authority-Analysis: v=2.4 cv=Xb25Co55 c=1 sm=1 tr=0 ts=6a58d043 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=bMkCNzlFxodDL1lM-IsA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: peSUdAcXKnXhDiYyGIAZDmOJWtsFiCxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

itrigger_enabled is relevant to the !icount_enabled() path, the test in
debug_post_load() is inverted.

While we're at it, move debug CPU post_load details into debug.c since
there's no need for machine.c to know internals of how debug.c maintains
debug state.

Fixes: 577f028694 ("target/riscv: Add itrigger_enabled field to CPURISCVState")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/machine.c   | 13 ++++++++-----
 target/riscv/tcg/debug.c |  9 ++++++++-
 target/riscv/tcg/debug.h |  2 +-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 0ab613a298..82d2e11eb3 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -228,18 +228,21 @@ static bool debug_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.debug;
+    if (kvm_enabled()) {
+        return false;
+    }
+
+    return tcg_enabled() && cpu->cfg.debug;
 }
 
 static int debug_post_load(void *opaque, int version_id)
 {
+#ifdef CONFIG_TCG
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
 
-    if (icount_enabled()) {
-        env->itrigger_enabled = riscv_itrigger_enabled(env);
-    }
-
+    riscv_cpu_debug_post_load(env);
+#endif
     return 0;
 }
 
diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 6cdf89c638..56f9ceb042 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -675,7 +675,7 @@ static bool check_itrigger_priv(CPURISCVState *env, int index)
     return icount_priv_match(env, index);
 }
 
-bool riscv_itrigger_enabled(CPURISCVState *env)
+static bool riscv_itrigger_enabled(CPURISCVState *env)
 {
     int count;
 
@@ -1155,6 +1155,13 @@ void riscv_cpu_debug_change_priv(CPURISCVState *env)
     }
 }
 
+void riscv_cpu_debug_post_load(CPURISCVState *env)
+{
+    if (!icount_enabled()) {
+        env->itrigger_enabled = riscv_itrigger_enabled(env);
+    }
+}
+
 void riscv_trigger_reset_hold(CPURISCVState *env)
 {
     target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
diff --git a/target/riscv/tcg/debug.h b/target/riscv/tcg/debug.h
index 88d34ecac9..6246bedff3 100644
--- a/target/riscv/tcg/debug.h
+++ b/target/riscv/tcg/debug.h
@@ -151,9 +151,9 @@ void riscv_trigger_realize(CPURISCVState *env);
 void riscv_trigger_unrealize(CPURISCVState *env);
 void riscv_trigger_reset_hold(CPURISCVState *env);
 
-bool riscv_itrigger_enabled(CPURISCVState *env);
 void riscv_itrigger_update_priv(CPURISCVState *env);
 
 void riscv_cpu_debug_change_priv(CPURISCVState *env);
+void riscv_cpu_debug_post_load(CPURISCVState *env);
 
 #endif /* RISCV_DEBUG_H */
-- 
2.43.0


