Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2234CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkK-0004N3-If; Tue, 16 Jun 2026 14:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkG-0004M6-0x
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkD-0000OQ-Qv
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:43 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOoQ9140438
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=t1QyXM2R8of
 zHdRbHbdifjXGBo1Eok+BnO0eKH4+PJc=; b=m19bFjVrv0syBnUP2qj7kfroW3s
 rICGoelL5mqBo9ve5EXG402Pxz5by1BT3MQrLI6ei8o3vL5ep7qk4NlwHhUNctbA
 elF0VCSjvOCQR/lEQpCV0sQE3/JRnig/OsfQ7nECbycUVkLetn8WZtRoNyFWqQRT
 XrNQg2357WM/k7phczKzyDT6GGJ1Q1KuZQZ6g15DMx13phCmKpspegu8ad0yMh/M
 phK3CueYRXWaUhCBA4Ml2srh6S4OXNucHFqOTk7h4UYigcQdPAE6ds82/je4GcDh
 vzduiVx61+qOt54H794L5jp7NQl8/XlLUCYuJhlKKBMlpoqJuj6FA/+aMEQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1ysu3d9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:40 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8423f544944so3413401b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635360; x=1782240160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1QyXM2R8ofzHdRbHbdifjXGBo1Eok+BnO0eKH4+PJc=;
 b=jz0JIkINNmSk66wphcOpJni7aWuuaqmCjVfLuJurQOenWlRiWLmBATvfW7ujT82hC0
 8xnIQ5IeqSXxZIJECC+TwS+I/oG6mYNA1neC1Q0uR1B/Nw/9QoByiWUwb8XWmO41O7BE
 5YQy6qJDDNFG3srVoaqopkosx+gsW5hxbY2VgCU3zDbZ8xiV4jSc3JBq4mZSvivru4xg
 o7DXsGtmV1f9x1mtY71+DnWyPMGGfS4vk4qFAFdE/k1RFQ2ec2Ytgeu6DBcbP3kT0GIx
 1XAG/Wy+3pe/rviX1Lwb+5BFgUhEt4oBonBTxvZ820dZbayX1Knd5dwkOhDp8oo3ki41
 YZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635360; x=1782240160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t1QyXM2R8ofzHdRbHbdifjXGBo1Eok+BnO0eKH4+PJc=;
 b=YAdn3p9+p+nL9Wyz2W/ONR5TS7+7aW/m+M8q/IS4PVFGQ4F1YgIlXxSlO8Ci6oy+KD
 OsB2ZocUpEIfnMQg2D0Dx72l7NJqBNtwbYf1zE2MNZ3VWe0ww8zIeiuy6C1s1LlgmZ3e
 6CGYPc5xgryvxZdMDxY6bjVs02CRzX+kZyijMtEmIR02w8Z9ta0/c4yBYu63yoGhcfKG
 1fvLFCH6+6d5DFiS2b1lxoLxqJ3i/Iq/AnfJqahoeLGpgq5Sycd4U6u/4ipc/7dejeO+
 VtP7wIOQnTnOQs7Z65N6y9y3irqCFLn5IthTdyKCjtUr+DpcE4KsI6C35ldAsaF8CrcZ
 XF7w==
X-Gm-Message-State: AOJu0Yy7L9IGRu010ODWLgSPQwxxi5V19hRJNLSXKdQPipV7lBABFTOH
 PnQlzRzgCJ9o1NgTQB2wyR1wNXYE+lMh/3Po1JMvtDbAtfJ6328mNQVY98tXiATgrO8q08ghcs3
 0kGw87JY2PFJldZfFRin3Tb7eQBoEgeKHrBqZQuOJKbnx48f5d8rbNWAJhq0dZchzI6Fz
X-Gm-Gg: Acq92OGbKU27XKTSxtRTEe6NovT0FGvEnkfulTJ9iO57v0cNqbBFhC9sBXse+qw/hoS
 WKnAX6m7vow2sSJTxJBoy7vBW6DSBCgw2DFi1dIT8DFIS3i+oGkmvWq0byaKmhAntBA6WX+zNNV
 HbeNR006ardg/3Nbw5fL00khR9a3/ta5LdId6PuIvg4L3TizbfbwRYYbVbt4p9AMrA+F8iUa/IF
 KzytXq0Ibf0c7YdvHH8ftnTeCMfSm0onA0j+QKQcQvBwIsB51snIgggbce0kImYqupMVwGeDSQF
 ztCBsEVkjo/ALEawqDNqLEUiHDC1QnmfnFjSm7tbgoLXv7ESzyp4wTpWGBV4KvQvmXG9e44CISQ
 6O79LzGWBBbbEddYDFSvTqVM8Elllqtl04wSUJCzkD70gWiKaIZkpAG6+3zpYSfuHduI9q4TbmZ
 ZuUc5iKfs=
X-Received: by 2002:a05:6a00:3925:b0:839:9ad:ee31 with SMTP id
 d2e1a72fcca58-84524444c85mr364490b3a.8.1781635359816; 
 Tue, 16 Jun 2026 11:42:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:3925:b0:839:9ad:ee31 with SMTP id
 d2e1a72fcca58-84524444c85mr364453b3a.8.1781635359337; 
 Tue, 16 Jun 2026 11:42:39 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 03/26] plugins: add userdata to qemu_plugin_register_flush_cb
Date: Tue, 16 Jun 2026 11:42:07 -0700
Message-ID: <20260616184230.303038-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PhEL25W68BWTmZP8ixAQmb0HDVB-ayCt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX2nXObOuD4uza
 7wlD5bvF57f96K4XTv58BRuI8Ecv9FtqD3W7I0gasqsC+g34xrgmiqCMgGZMN6Vpi17g3yNnNHW
 TOjki8+TkiOZlvgEu++SyYst/ADY03E=
X-Proofpoint-ORIG-GUID: PhEL25W68BWTmZP8ixAQmb0HDVB-ayCt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfXzjklTliIlaEg
 6Qs5FcldD3bFsnqU9FxW25raqjItb2af6MvgzKe5O6UOo012zL6Z4MgMFm6gBemNynk6nbFlXL4
 IdIwpdFfkW8puFlB+W3+4vJtV6n/yvRDWay1LMABZO5g3shcJjg8E7F7OhlBRhNmZaGrOoR5CCC
 EXGfouFB9TaD7wnIxAp5WfBYFkWUGWHu9hG1542KUkEoLLK/LyB+qJuOyAdzWEklMMwZAoXLl5y
 278RnBh6HWsNOCE9/DpK3vdyeH/rGI6wvypiEO115egDUmZFTKWZZzh9LbSMo7VJ0iKlMQkm0dh
 dqo3KQoA2lv905TQuTlqpVXiO5bd5OX3mTNVNy16qCwoxBSu/EYbGZQ0+qtO0Xnd+BWfNiCErku
 0qfr3djVLIbBoyIsXQI5thy1cZdnhKf3cQtVDg3gDYdbHC7h32NAYLCZSylcxwxDx1cCUsolSur
 4lhzqktw9amXjlDPQeQ==
X-Authority-Analysis: v=2.4 cv=JJcLdcKb c=1 sm=1 tr=0 ts=6a319920 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=jbUUBHnpNWWeZ8W5LfIA:9
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160190
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
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-4-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


