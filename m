Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B592ACD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD6Q-0002Un-NF; Mon, 15 Jun 2026 15:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD63-0002P9-Rn
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD60-00018S-8W
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ1JPM1220312
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/OyPY5qd/+O
 IP4Mmj974ZNY6OrTTznWE834Wr+6NIaU=; b=QczVwSC8p/EZusA5AarOtTjRDaz
 PYae3szDw9XuEe+rCLRBdnVQS51iCZ3Q105D9Q/4GFkG2RH+eTcpoAt5JbkCeDWK
 l1paPWonKeJdFa9FFbdqtj1B6y+YxqMKhsW03lD/LUOl/dzMuBD+qGsDXHdCgiyj
 g7RYTHVJ8W2pxxY8hsdAaEORGCKtY7f8vww6nyesanBVjvjB1ELoLqLC04B007oV
 BodVgSfXER98e80Llv0r0Whu2gXKqvOmV/thepyC19p8+vJXo9W109qWOmd6HCAi
 8E7xl8eEeibzkplRsoumun8pEoL3ojnXqST/TN3h7ViTRqNU9q2bn4rVDSw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx2k1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:34 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-13986163c34so36314c88.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552133; x=1782156933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/OyPY5qd/+OIP4Mmj974ZNY6OrTTznWE834Wr+6NIaU=;
 b=h8C3ngT7SCixeT+fRmwG2dqFPueSD4Mlb0c1qegmeYHsDE041TxUqGJ1bCfogtF8kb
 dC2hKVcgQeNKhYec+hgqv7/z0/1fwWG6eiHGjln/NsvxOz+hyMorr7QGQOExsVxr3zoh
 1IcDcXGAFQMYopKgVjxHfauDZC7L7vysmuES8pBcq6cawrcEIK6jxy7TTW3+yKXljJZh
 C2o4LiKhEIKQg4fAzCfH6ms4y1m8/bOvEuclkcPBjQbeEMCqUgWUyboL+rCpQGS/DK6T
 WmqxJgApZt2xwReSJvXm2YNLkofp8Vki2gntt26yUdW8D3/uMBwuNB3LUecnc8mXxYZK
 mdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552133; x=1782156933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/OyPY5qd/+OIP4Mmj974ZNY6OrTTznWE834Wr+6NIaU=;
 b=Pzv8rT/ExuqtbE/4dEHnWYBp6iXPuwHpszZBHzwE6q+QkdUvJQAnUIbm3f6YTrCSRN
 FgwbLR6cETEzZQXfd0ELQ3vnXsP2+4smBBzfD677Oeb8iIX25Yrorq/JNEvqoVFi3Imq
 GUVPMgANJpZXCKhwrd9PCZNIZOhOQlDlAho67bxUQgUCGTqDhrv3xNHDYydR82PSW5fj
 cx+aW7Ty/crYIgK41ZRRWRJIoJPVHEHpkTyym45HNu6ID9TVUEUc6zgwre0axMchIf44
 5jxRmzqAi+RhVcaFguZZri98wmjV12FsXVyySNNmlsKAybq6L+T0kCHmA0jYS7oeAZav
 omHg==
X-Gm-Message-State: AOJu0YyGLzvvtDTcSUFMkR5H7yx56SqAL/C4MKuy4AdDmlB5IcPNm5mB
 KbDVAISMCCz7hQU6LLZx3efXX9z89xddLzAiInJc6AioGFyOvxOnrs9se7yUURLapG+zv2Nax6/
 XsEKcMQlH8bwz8M11WyJ9gunQRt15EQEmbXAz30rhDBRqSM9KqxdbIMpsM/UDvkOVHRht
X-Gm-Gg: Acq92OFUBurw94B6DR53lzTVqX47DvB185ZHbfrU+yJGig2qGABpgAmtjB0jZkn+NdH
 WK5HARQz1HWX8Xp6FY8SoYQkuFVgieksSyHzgFx1SCRQfg3NCvrrOH1kQAaamm/VK+bdIxunUi7
 L5tbKEOq9JW5FIb2MfGHLiIKw+rFizr/AIMamGN88dS0GgSiciux2F283ftsMnWPqjLT+OaGn1a
 JCgRqQV28o/DAgC+uBEVOGHvi2hO3ZD0RUoNzutkVfCSsrRp69U7gOqkgsax/z012stVftYrnnp
 sx+4NqODOMjrGdAULy7EopKdoDgulgQff7jVTrIuxCqDqHcGQeJJ7mMqaG6q68GTXuYETVnxoxC
 Q9rIIeuZ0cskqsi71Y09J3gWsdRTfLSI8zLKv7Q1vkrRNULIX00IVCC3KTW8XRy3QFlsYzuh3Oi
 qk20JKdA==
X-Received: by 2002:a05:7022:622:b0:136:5e4c:7aba with SMTP id
 a92af1059eb24-13985ebe992mr268310c88.16.1781552133481; 
 Mon, 15 Jun 2026 12:35:33 -0700 (PDT)
X-Received: by 2002:a05:7022:622:b0:136:5e4c:7aba with SMTP id
 a92af1059eb24-13985ebe992mr268275c88.16.1781552132630; 
 Mon, 15 Jun 2026 12:35:32 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:31 -0700 (PDT)
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
Subject: [PATCH v2 03/26] plugins: add userdata to
 qemu_plugin_register_flush_cb
Date: Mon, 15 Jun 2026 12:35:02 -0700
Message-ID: <20260615193526.2883349-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ygW2Xh7keUGmyOpc3TZ9j7NprHjzEP0S
X-Proofpoint-GUID: ygW2Xh7keUGmyOpc3TZ9j7NprHjzEP0S
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a305406 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=jbUUBHnpNWWeZ8W5LfIA:9 a=Fk4IpSoW4aLDllm1B1p-:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX8coRgkCfviXu
 p4/PL63TpPT9DSv/3vFYr+eY2Syg+kwRLSMAFieViTRizsIN8KAfz5+W+Z+INcDYoQ1X4ASTnh7
 xh5swtwSE2B1s8gWDhTXKe9plL9P2As=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXz7wY7pYbhaxD
 lr40d1CQwR0dnzHxWMTsNRzn3GHo2O8/7k+svsRdQ+ObOCTmFdKjtPUmJR3kCxQIc4U8aZuurSJ
 PSCrOHy2XgYERFhVJHHwJcbihbGmCtwmOX44/VBPOx6aCqe9fbdbwm/1HnhMZQKY1IFbskueQsl
 oo0GfJqrUFIa4IPKspEu8fYhTBF+WVHLzOs8gFCusFEdI8StY7odh/j534P63YCYLppldkGJknB
 1kqo6zt033yYY/wF1/oojWl14Pfc7g3mJ+DXmRk80s7YBsam55N0hqLv/QBX33vf8EuCHhScfFY
 TLu/9K+mxR19XRPQl8KD5c14lHgY2P2zrg/2Zghx3Ylh/S7G2kvL0CObA9XUHBH7k7CEWD+S20Z
 +U2Df01gtRQMr4WrnFFYEE8vSQtaaRLEc9WzWud3ZxHxLVsDYy8LKzfpuhRY0CDnP70aWnQ6JJ0
 AisKcVNE6g20sX5etWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150207
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


