Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69328CD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD6k-0002gc-M5; Mon, 15 Jun 2026 15:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6G-0002Up-F6
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6D-0001RD-Sw
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:59 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ17th1454047
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eLKXGMn2n62
 lJRcUytZ5WT38KcmBIzFIunI3KoTmHtY=; b=I/qpMh76TuPWn6QWcszOjV0zj7s
 S2P5uKvoKzG1OW4Id0FHJAG+8CWGqFjLqpkQIMshZP2IK9LfmsPqtai7125Kfd7K
 7jlpcp479+pwEIsNkvlDuSyfsQwcjCKK7N6GlrXi7M/QKkECW7/svzdsHDdzimad
 ALTpQpN8jzHpsdnKCYNmW6H73hnCaeLdAcrT4eMm+fxb4HYKMw2JK80/QK1dG2jH
 brw5hPE/8xqjMHva1Y8oSqYl8G3hKIV2BplQOKCglsQU9/dGlKSaHeBEImKCSMYN
 Gcwv+Al2TBws/UwWPdrKQhPuvwE++RgXE3ggtlP8b/RQ66k3g0w4YuDLUJg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2cb4cd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304e7fc90b1so4233383eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552146; x=1782156946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLKXGMn2n62lJRcUytZ5WT38KcmBIzFIunI3KoTmHtY=;
 b=Eqh/guR/wNQEheYsK/5vSVrur91f3CCV1r1RTdAdCafjEM7/d3wnaz4tK9mJupMnlr
 erOE1OKIl6SID8cfpehjNidgFNn7gS3JUF/+HBRrvAXRhXT1PP/Jmo7PFzkn58OgO0DW
 yIPS0lptF9Zkv9hlrGTkcFUW8PYfnuYZ7iFZIMcDOHOxuHYBAapak9AYi++MuS3DDJin
 dTBPTWSfkHMSzadJbU78ZFSFrnRKeGkarUyV++dk9PFQDdzqdeXcVPYuPkGlLRgyD/Cw
 u35tQ0oW2hC+IN+P567AnYinrQUQvwRnOo74GpVLae5fno0O7sGLpEdo5/6OS9RZ2p7y
 TOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552146; x=1782156946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eLKXGMn2n62lJRcUytZ5WT38KcmBIzFIunI3KoTmHtY=;
 b=eSuUjVtQCoir1Wn5HAY80NxRcjNfvhTL4jDcZzTQbIkYza1Dopv0ndDwUcK5YTiflL
 CIJwJwJGPIbgofq76GWuctPOVWXwOnBmI6dF1gX+knaVvFkVAdfD6zMqs90SFCZPI48T
 Gud6Fm5DvRhKKuDsoW6YW7GN6xSXBKNsq+mDg80+ezO2hdPBXWtpzxWRZzR3gsW93wcj
 OY8qrFLvUoawq+v61LwwCkh6AC4e4gNuzHGu/zsL0gysOxXaF1sHu6XJGN15tw3JV9iw
 QPQw7/4HXgID7nTUo8kNTXENISKI2MzF2R9IQFAkrJRkbFR6O6icNtiOPXtMzruly1pJ
 2RZA==
X-Gm-Message-State: AOJu0YztsdWrLI4KXbEg20vxhtKNYE2YHEb5T3lfwDq7AaOCXfzt1kVn
 C51B93Ddn3n24++d59Mq3KIHCHuq+qu7MTqynhYa1Xb3ptaN0fUnTWWNV4YWKQw9s6+SibQGGco
 3zT915Uti2c6wH8oYkQrrS0rD9CjnBWRJZVXlsEqzpvwkeTBkXVfCOgvtOkDgtF/gkMHY
X-Gm-Gg: Acq92OFJMCEaLL72EdT5fUC1lExsJzMR0mxBkU+75PFdqc7CjF511bxkE/e80z63Bw5
 Qd5ct/A7cMqTTvzIXGcrSIBPWD9VQU3TrmPYZywAfRXwkKLq7NLK8KJroz3HtSv4cD8uQCek3L8
 mhCeiFgekkf666pionHbYsCESoFZF6meAPW7X1mT8zfsSzN5PnOfs/r2oRHupwtqcWgKjPmblZn
 mVMDi9Ah4pwOXXj99iVD/Mm21If5ynKUC1rQ7ihfpt6WVl+k1ieqfH45hSidv57qPGnS47Sl0gg
 z10EPLbU7pvBGSd6paPcm3jk3shgl9dZSCeMInEvfXFEKoza9CyuwNIENgSjHRvGWG7rkjeZKkP
 P9nglm82+mjY742444m7Ih+EbJr3GS97ugGOgrNpg/NueqzaloIiY19nQQZ6O7PhoKGqkoRSAlK
 nUw2l+kw==
X-Received: by 2002:a05:701b:454e:10b0:139:7a47:ab68 with SMTP id
 a92af1059eb24-1397a47b13cmr2312345c88.37.1781552145770; 
 Mon, 15 Jun 2026 12:35:45 -0700 (PDT)
X-Received: by 2002:a05:701b:454e:10b0:139:7a47:ab68 with SMTP id
 a92af1059eb24-1397a47b13cmr2312320c88.37.1781552145096; 
 Mon, 15 Jun 2026 12:35:45 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 14/26] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_discon_cb_t
Date: Mon, 15 Jun 2026 12:35:13 -0700
Message-ID: <20260615193526.2883349-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXxR44SwY0qKSD
 0WcnSmN6dWKHNC3hzwAn/4sqmebvWyMdMZuUPe+fE5LVaJ3hFpD30oimCYnoXRS8YHvivl3cQ+U
 4x68+rb2Oc+0p88BcUOxOfOCqEBym0ZQ+ynNwBj7tI+XzrivPq2FPxef2wOc+us3VMtdubGbrQY
 JzAFJlLNMA7qD8b0pRnPH2uTIe/nzL/npK0i1dnUZt86qJCboylUCAoVW+s0Wuz0mIllZvF4x/8
 NrC84KdrqkciMpes0TCCOpyVWunYMPfB/TTESnli4FJi0j3cfDgqvqjEumHcYM4Qp2gG2HbW1MC
 QvDcxq9ZpnukrN4M5bWkGToq2ax74KRAqST3xi8wmxBFPiDMFOC5H+mDFqrFoOR11uZgRcr98SI
 2rsqM0JgOOj3Y0uHzxlzFUM7TcExjVTLaeqouZXG6oo/+okcxkg1YD5h/sIMgTHkcAGxU/qfLGX
 YGtjN9MOWGAPucORCug==
X-Proofpoint-ORIG-GUID: 8HBo88NwxHHXGyWdB10WdnOGJgABTM6B
X-Proofpoint-GUID: 8HBo88NwxHHXGyWdB10WdnOGJgABTM6B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXyWInhQ0ZNOdB
 u1a8RqEQBjhxjYPjmm4i84pnbN+RueS/NS5QDrAZ8EReedQTHDIvlh5NJ3dboyTBDfiyQSUpEbo
 ++ID8YK7XVN4SM+fNiGYqiH4IGms4nE=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a305412 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=ZiyQStk_4VnRclnpaacA:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150207
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
2.43.0


