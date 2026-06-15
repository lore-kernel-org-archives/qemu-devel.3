Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A615CD98E6
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD7Q-0003Y3-2b; Mon, 15 Jun 2026 15:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD63-0002P0-Fs
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD60-0001Oi-4w
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ1dOR1367868
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=r+a8fu1tleJ
 mmUTuIuP/3HknQ8qhCGJWyLNi4ZoKaGM=; b=YAoY0aQzpU5AONmoobJIS3c0Sgt
 dFjRK2umckVuq2HQnzVML4gecB7pdZr9sSl6m/ZoLUfbhIsP/SpUU/kapHkQ+kUA
 C72G+5jRSFl+JnM4wErWkNSxDupZSgMTfctYikZnURcc3G/Drrx8cAzKspwNEqSg
 D65kpetHmZYkgAPo1aKFWNZmUhwrb2wvrPME/6LqLLqjTdgvc6rP4+jT0dG4Hz2v
 etQlmug6/w3y33s89XM5r7oCeIiQVBWNtKDfjD1zFkJ8eBMpmXlH8hcmgU94cp4I
 LIybzsNupYiIujq9fAsLuBda5LfeSjMuwzsMwi2VPLkW59fSjGV27s9CKOw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etegutnfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304dd917645so7795323eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552142; x=1782156942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+a8fu1tleJmmUTuIuP/3HknQ8qhCGJWyLNi4ZoKaGM=;
 b=cXWqJGYCPJgixF/itq6puUY9A7NWZspkWymhS6pkyryvTZyvdmbwmYGOzx1opzaypD
 toZWfhiMVRJFvVviaN9J9I1kYfibWamvbQvYl7PvdmVT8/1wFUimArfzM6hYSpFLnk0L
 CHIlHRD//zeqXRtahcg64kMVmiZ16RPlA088MjGRm2aBuV0rgb5AYMReHiTgoIFSn7VW
 MkMmpx4xCYNuF8sZ9N2yiv5LaBx84niuGiWC2mkcJ6eWtNJXYrMVh9cKeGoTSO6lKazX
 r4bYGD39tnUrPTXFzlUObHTNw2wCZVqQj99cNJe1YGu45rUayGdPdSogCmJXg7hgwvY2
 YOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552142; x=1782156942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r+a8fu1tleJmmUTuIuP/3HknQ8qhCGJWyLNi4ZoKaGM=;
 b=VixSmShDuKHuiEWyES+mxfvmiOyS4LRFxwE42xpgl6fjXhLOfPWDbFvMG6ksiYKCbM
 G8Qzz/wAgm2FNHxbSOv53vm9z2wR5FEPie7CuWQNy3aGLU9oYtOXjlnZlZn5snvVfI5R
 kiv8OnczKf+F3LvBvR89CQZ3DF6oB8qRkqY/6c4cfkEDh1hjyQqfzNiYM6vL6tBNTJyL
 KqeMv7Vt8eokoL/Yu3yeUf5ELP+LtGkShr7Owph6/2Q+xiUM3LPx7v+CXsPSYZsfRO6f
 LMHIow7oi9AA5UhRzkImOLAelhf7GPJ2JH8NFSglmLZ1VTuQEOAQIvGQvFdUKq7Mw80p
 uuIQ==
X-Gm-Message-State: AOJu0YwFvwn6HK6njjURNJY3/ZiQ/ae3nzpEQG3V5Ujat7Brm8b7Z44Y
 ENU8kwihCVJ7+vV8/4hmc/+9QWAhjWL0EWRKjHHxnr30pUGnjlEQdX+RfXOrEP/XOEhE+bAK/Lz
 iQUHE5RkRZyfohHueto37U/mm5BOypmb2aM++v9W7xVzA61s1lqq+cC2gIRj9hhHTeEG6
X-Gm-Gg: Acq92OE+JN00wQIpcfnespCMOJJ3sesEmD3PkcDZ1CcS8nX8u27EnpG4qpL19qoDoYr
 vZB9YryBoh4FZLIK6nUFCEQPwDrwkx2NUbc/d9J7GP63uL5SeIw4NF9ok6CjpY3J/f5EczjmwWT
 Wqizd7k031/DRH5bCHV9otutoufHW22Z8UBw7IWW9ZGY53mDRDBBEUoyqqFMhA2gx14BDDfNIfh
 EmNW7U+KtXmLtQ2dyOYgfZHJPTFBhEW7WlXqisK9zNewEHyTksfcwng93iA0luRKfKjilHCRbee
 RShluz60nt4qHOQrqCQER1oswq2wqdPhZyrvfmKzq2ZlcUVbUOixLqfTvSewPJgThFer1pAQuga
 NXYrBxhY0yhCGQb9j0fyBhfveLr3aPYIk0JBNbScOITR3e37HNczrdhV78CBwE2pl3LhM1xv+ab
 LYLm0dTA==
X-Received: by 2002:a05:7022:f114:b0:130:7246:10aa with SMTP id
 a92af1059eb24-1384bafee0fmr7143886c88.12.1781552142082; 
 Mon, 15 Jun 2026 12:35:42 -0700 (PDT)
X-Received: by 2002:a05:7022:f114:b0:130:7246:10aa with SMTP id
 a92af1059eb24-1384bafee0fmr7143863c88.12.1781552141615; 
 Mon, 15 Jun 2026 12:35:41 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:41 -0700 (PDT)
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
Subject: [PATCH v2 11/26] plugins: add userdata to qemu_plugin_vcpu_for_each
Date: Mon, 15 Jun 2026 12:35:10 -0700
Message-ID: <20260615193526.2883349-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXxXKP2T2dLC5R
 u88HSVPCAOt7bv1SLVMc2cn3muU90bQzDRdvHK/4aR2DfiZbkf/FTnoCkbl1JtP5PNu/X6adZCk
 muRuUMSLwQsR5J/Jc7yjH3w1C7LK82DYhfVTx+rBBcPex85hvxmMtZj995CZoNRYoeal3CBbi0E
 lRaiiB7VuCYNuH4p1IaRGgAVSVBNfs9DCG92Fdp2f0Yju52kfv5T7bMSpo5DlV46ShqUqsSLPmQ
 i6sZ3zMGGvJzDIKfcymED0Pt4kHf3jH+WpYkgFinHlrygrah1Lb5lwU7ZB9swTx8SXc4muVZrPi
 NAgqeOfE860eoeBk0A22hu2qP3cpgtDIAF53AqpY3YNJekHV5fWxXIWUlrZZbt4y4qIT/+aolR+
 6KTdVn0NXsbdvsp2d4Q6ggjbo/bWkrsti+wY+/G3Len9gudq+Zu2SqOwP6fGMf2Uok7L1pDAOLz
 jGVPrZkbCzk+bw7w7iw==
X-Proofpoint-ORIG-GUID: AR-Zgxb1Xzs0Lg8Yn8kB43H0Vk2aa-xo
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a30540e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=6uvAROY9rCAfoAu75HUA:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXw0XQQYTryYXG
 2+zHzdWhMfm1nwk7I4bQ4pPFWnmoN9fr/T+MUcEiV5zO35T0zmbs29KqxvbIQkuh9W9L6KMblus
 bABD/6tTq9R91ym3AaIO8Nmgs6kacnM=
X-Proofpoint-GUID: AR-Zgxb1Xzs0Lg8Yn8kB43H0Vk2aa-xo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
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
 include/plugins/qemu-plugin.h | 4 +++-
 plugins/core.c                | 9 ++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 8c146ea49c2..320644a2f0a 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -957,6 +957,7 @@ const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn);
  * qemu_plugin_vcpu_for_each() - iterate over the existing vCPU
  * @id: plugin ID
  * @cb: callback function
+ * @userdata: user data for callback
  *
  * The @cb function is called once for each existing vCPU.
  *
@@ -964,7 +965,8 @@ const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn);
  */
 QEMU_PLUGIN_API
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
-                               qemu_plugin_vcpu_simple_cb_t cb);
+                               qemu_plugin_vcpu_udata_cb_t cb,
+                               void *userdata);
 
 /**
  * qemu_plugin_register_flush_cb() - register code cache flush callback
diff --git a/plugins/core.c b/plugins/core.c
index 342357a7499..5b4ed0ce213 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -297,18 +297,20 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
 
 struct plugin_for_each_args {
     struct qemu_plugin_ctx *ctx;
-    qemu_plugin_vcpu_simple_cb_t cb;
+    qemu_plugin_vcpu_udata_cb_t cb;
+    void *userdata;
 };
 
 static void plugin_vcpu_for_each(gpointer k, gpointer v, gpointer udata)
 {
     struct plugin_for_each_args *args = udata;
     int cpu_index = *(int *)k;
-    args->cb(cpu_index);
+    args->cb(cpu_index, args->userdata);
 }
 
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
-                               qemu_plugin_vcpu_simple_cb_t cb)
+                               qemu_plugin_vcpu_udata_cb_t cb,
+                               void *userdata)
 {
     struct plugin_for_each_args args;
 
@@ -318,6 +320,7 @@ void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
     qemu_rec_mutex_lock(&plugin.lock);
     args.ctx = plugin_id_to_ctx_locked(id);
     args.cb = cb;
+    args.userdata = userdata;
     g_hash_table_foreach(plugin.cpu_ht, plugin_vcpu_for_each, &args);
     qemu_rec_mutex_unlock(&plugin.lock);
 }
-- 
2.43.0


