Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89483CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsZf-00082d-7T; Wed, 03 Jun 2026 16:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZR-0007xd-8Q
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZL-0004CO-W1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:10 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653Gj8gE2260648
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BTwKFhN3UpB
 ypCiBHtCHvMi3SUawT+1H4PhMWJeUahw=; b=kDtwznsPWoq4DExxYPhQ929o1E7
 8qTnUjQQ2k468c22FJCtYYchCI+y8Nc/PesuZ2Ljza2S9My3KsSgzvHgZCmiR+jD
 0lBsBzanbbF7PgZW69WYmEd82cMe+fzZj0j6HD6xii97u3TUApxhQVWoZjhHTfl0
 WuZtcwzdUOQ/fqBmACUIxq2q63k8v0UzT1WDGP84GZ5ezdg8bM62Y5yTPcOYV4G+
 /vKJpZnMDyHaP0He/q5mPVh6CFnJfeSR62OBts+MIvcNhCkmfeVXxQTaOkiwZBWP
 sP/jHTHbcJdGYpTsMxUReF59a3M0jArWaCxud4e4GHT6W0i1Cdrh0qf7GNA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejr2mh0tx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3075fa5a407so1200065eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519926; x=1781124726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTwKFhN3UpBypCiBHtCHvMi3SUawT+1H4PhMWJeUahw=;
 b=kmZ/SDwu4iBjVcSfcmdcHzjEG5lwt/rgcu39mSLbge/9nNAComWK7OJlfTmV7D8a6k
 HiKAGOqL38oNqJyPhDuQMi2DeK7y1qRUQ9lacX6aSrVxI1Hr/NqRYgICmjuOtbu/VTqc
 1hYjaWdLHxB/EfXIL+Gd4fC7s+2aiA3kuLIXinpY6e1eMcu8voAeitwsldzu6kiLksz0
 kTJcWCeH5bnOE+HQPyBOKFvC4tX8FTBQHPeiI5DOSijlm4VrXbUjyNSEEu/hWa+piI2s
 R5qvIz4u+oGG5AmD2Ax/GpZi2fREa0jL2IsFQ31K+O69QMvfFcqK03v/Nj8dh8VBwT3c
 P+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519926; x=1781124726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BTwKFhN3UpBypCiBHtCHvMi3SUawT+1H4PhMWJeUahw=;
 b=Kx1M9DmrdvO2z3coIE7Mb+hDSACKPdfrE0jDzExqaXpkaFGPB1Q3d3sJcbgTwiZoIi
 c8EIfrMcJFWwBabFnfD2Zf0g2W8Qksth8vZiw00veM260VAC1WsUCR7NTKUW2jkSawh9
 kFsexEKk4waJGdwpuIjnXk5we2gGTPDpB52DgOz+RTnMWbC+MKgERKa5gbQs9anZaRzV
 V6pGc/r2xiXG1H6rLL7pJla5cjd+c8T13ma97wN48xY2ssa6LIFiEIKGd+ayy+AztlMG
 Z0PfqEebQo6u/wBP7Th8BzQLzxiGH//ce9Y5SNVMkkPjD577aybtuWolg0HhaTO7fx1y
 VKBQ==
X-Gm-Message-State: AOJu0Yz8iWmuB+kh/qKAyLWIrFLR3i+RoV/WsIuPVPonOWtvl9+Tk6lV
 7t2ktjh5F1p1EsSdMsTJuGsNNBMreyz9+aD1nsV7ursxgpW/mLojvm+T1gkHl1Mce1wEbXh8xSe
 R5+18wKfENAgRqXvnr1XYNxqkFwd24tIZUtE+cxr83dy8LJSWf4s8cd9qTxIpPaqxEvb5
X-Gm-Gg: Acq92OHXZYK5dzki8+dZsdWkWuzPrxbDXUrjtDW9xIYkB2Y2o7bugHg5q9VCp1Vb6ae
 3paCVvAqFOoIV62skSSgsJVZQzYCVsZsyPhzskPgUUkH5qLepAYTRgFdoirKxYBVjSqT7LcNKB0
 QZEmKTrBuWT+uZ4Tutt3kDu7QTHh2hEXY+jRaiqv97YACsGspaxaD1UNIXRdalqLfwfYZ43rbS0
 VBes0YnBbfH+7oVBDUqpXcYdRGycugvVJbnWuLl4rRsCPLM0v0qZdpTjFzWu9ly84KkdM7BppkS
 /wh63YvK1CBtVBDk/KqSSnKpTa47KzVPv2z5SUkTFvOLoPNSrvCIxZ57zB06UaAQ62WJ5fPfMEZ
 0/cvj48bQmEGQGC9QQLn5mG9NlS0o1ZLgYv4c5MzdX2GJHg8tqYoZ7IDuSMOHIUhk1yL1zLgLp7
 9122mDDLpks97KeGYo
X-Received: by 2002:a05:7300:3b05:b0:304:de8e:17b with SMTP id
 5a478bee46e88-3074fa57336mr2662540eec.5.1780519925695; 
 Wed, 03 Jun 2026 13:52:05 -0700 (PDT)
X-Received: by 2002:a05:7300:3b05:b0:304:de8e:17b with SMTP id
 5a478bee46e88-3074fa57336mr2662504eec.5.1780519924962; 
 Wed, 03 Jun 2026 13:52:04 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 03/25] plugins: add userdata to qemu_plugin_register_flush_cb
Date: Wed,  3 Jun 2026 13:51:30 -0700
Message-ID: <20260603205152.1440291-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rtJ0d86M21rh5XK5d3AupqNi9pTjwRQq
X-Proofpoint-ORIG-GUID: rtJ0d86M21rh5XK5d3AupqNi9pTjwRQq
X-Authority-Analysis: v=2.4 cv=A91c+aWG c=1 sm=1 tr=0 ts=6a2093f6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=jbUUBHnpNWWeZ8W5LfIA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX5KrtFgKMfUWe
 BJ07KBbsO/6WUtWjabKfATAX6yN8g1LsO3qZi30W09ULxn44TeCwWnBbpKEb1yGm9PksYKsX+sT
 HY8r59uzo+eNUdPj9LeQCOojI6txxhxIzCdGnKfLL4AwrODzTY1qsopVi+YM3jDE3O3XphqQEKF
 YoxA7SzlPlem0/OlzT2x0lP74tpQtfZ8axie8iiz2yc2n/WogXub7jL+Gl676KnevE/4j91bl9z
 sirjOcLiRQwpFiQDDXMHfrZYdE95iLLNVnYeDeiMoEEJ/BxNp/qWaeDaDFZwSsEn053nQSISMUA
 cNrTDVp35+aKuPi9Q+fx1p0p+q/QbUGGc0/dexqP8Fnf7G+CuAfUdce6qn1x4Q+9jtl11111yQm
 n8tN7s9fKRIx0u/cmUzGS8TwokiieZz+RrQ+F5m9h7XuYt3vPtp6ARq0YbADwIxLoCKD/wR1/SZ
 tpjqKJ7c1ljcByVrGmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030203
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h |  4 +++-
 plugins/core.c                | 31 +++++--------------------------
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 11213c2ca3f..499441bde23 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -973,6 +973,7 @@ void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
  * qemu_plugin_register_flush_cb() - register code cache flush callback
  * @id: plugin ID
  * @cb: callback
+ * @userdata: user data for callback
  *
  * The @cb function is called every time the code cache is flushed.
  * The callback can be used to free resources associated with existing
@@ -981,7 +982,8 @@ void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
  */
 QEMU_PLUGIN_API
 void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
-                                   qemu_plugin_simple_cb_t cb);
+                                   qemu_plugin_udata_cb_t cb,
+                                   void *userdata);
 
 /**
  * qemu_plugin_register_atexit_cb() - register exit callback
diff --git a/plugins/core.c b/plugins/core.c
index 2324bbffa3d..21a3c5b15cf 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -131,29 +131,6 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
 }
 
-/*
- * Disable CFI checks.
- * The callback function has been loaded from an external library so we do not
- * have type information
- */
-QEMU_DISABLE_CFI
-static void plugin_cb__simple(enum qemu_plugin_event ev)
-{
-    struct qemu_plugin_cb *cb, *next;
-
-    switch (ev) {
-    case QEMU_PLUGIN_EV_FLUSH:
-        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
-            qemu_plugin_simple_cb_t func = cb->f.simple;
-
-            func(cb->ctx->id);
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /*
  * Disable CFI checks.
  * The callback function has been loaded from an external library so we do not
@@ -166,6 +143,7 @@ static void plugin_cb__udata(enum qemu_plugin_event ev)
 
     switch (ev) {
     case QEMU_PLUGIN_EV_ATEXIT:
+    case QEMU_PLUGIN_EV_FLUSH:
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_udata_cb_t func = cb->f.udata;
 
@@ -690,9 +668,10 @@ void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
 }
 
 void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
-                                   qemu_plugin_simple_cb_t cb)
+                                   qemu_plugin_udata_cb_t cb,
+                                   void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_FLUSH, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_FLUSH, cb, userdata);
 }
 
 static bool free_dyn_cb_arr(void *p, uint32_t h, void *userp)
@@ -706,7 +685,7 @@ void qemu_plugin_flush_cb(void)
     qht_iter_remove(&plugin.dyn_cb_arr_ht, free_dyn_cb_arr, NULL);
     qht_reset(&plugin.dyn_cb_arr_ht);
 
-    plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
+    plugin_cb__udata(QEMU_PLUGIN_EV_FLUSH);
 }
 
 void exec_inline_op(enum plugin_dyn_cb_type type,
-- 
2.43.0


