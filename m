Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D4EC55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrKmt-0007DB-3w; Tue, 04 Aug 2026 15:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKmr-0007Cn-51
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKmp-0005BF-Px
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785871611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/YLITtyQZk/29n/Ki+VXTGedtcpRCCASc2TUbUo+E6I=;
 b=M/t0QtBBISSge18zvaovZ7UzHLYIncMMQcyIC1d7LPhW27z4q8MJ0fbB3bDn4SNovoncwh
 H2iGrDABWw1MOonVBSZ+FG7gWRODbjZreZrxQnW97XhIo0k91W8W+J2qJ4FSAjwQInVZXi
 L/yhATtcPJ39wbNxPGx4MjqDqubseRc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-E8pNb1lJOBu6hu1nJpfyIg-1; Tue,
 04 Aug 2026 15:26:48 -0400
X-MC-Unique: E8pNb1lJOBu6hu1nJpfyIg-1
X-Mimecast-MFC-AGG-ID: E8pNb1lJOBu6hu1nJpfyIg_1785871606
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1836195604F; Tue,  4 Aug 2026 19:26:45 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B0C71800480; Tue,  4 Aug 2026 19:26:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 04 Aug 2026 23:21:52 +0400
Subject: [GIT PULL v2 5/9] hw/display/virtio-gpu: drop redundant
 node->value NULL checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-fix-v2-5-70e8fe489c9e@redhat.com>
References: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
In-Reply-To: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sjywyeADAIGro/JFp1dJCBH1U0aQQKbRC3WkRHfn7go=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcjzU8/YFVMzcaA0yc9afdkP85xYlBEsw01SOC
 qtfVxGOERGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanI81AAKCRDa6OEJdZac
 5RqQD/9ZReOeQKPkmXcC1KOTOJXBMrkg4/OzkkI4jEvyGWZGfzfFstlcysjxbQxIsgq8oiw6j10
 WUC/POekaMXDnQK411HyXT2v/cR+TXNgb0Tlmok+cqzd55YG+UunQVpYHxE8fyPFQ3K3ErqdDx2
 chDAbtkPvOVJZeCOPQR+4LaOxKNJUsKNG7+0SkBi0sNBwZs7pwiudD2HjuvU3tK//xXp4kVK/0p
 CzS4CnYr1Za+wA1F4YfUg4n6ORoq/TQSNmbgBgRkQekVlGglQ1Iv+Y25I6pp3Qv0hujqYoX4k+g
 5szv1UM3t2wpeQA5e4vHEYYpOUqhLVb0MHmWUHHYxRjcobyuklSd3dFjqLKUgEtO8n8QRmIB54e
 HdQHzXSO3JL0vqx0MZmrnuNFz/uXeGD0WXeq1WWbxaeeUACUEvZRBGtxtlXQvsc7M9bnWO3nibl
 aIc+E4UxCYdxzoG0ZgIQKrYVoX34HVGcM4hcBXLTxbVYo1WcO6RpH5utKVpLI4yOFAxELUwLHF7
 55KNFSwdMdOJKMgkuT/pWbaPGb9Fcsc1shall8YF9russm+a7xjVQZUixvA/ONbxZcXNKCQHrZ+
 f1Y3KQACfNDdWkTri+khQqMmzYzwym1Y0ICs2DC+1idn+IoxNcV4E0mxPh7nPa9KFUEG4Tged/A
 7AhFBYW//swUFkw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

QAPI-generated list visitors guarantee that node->value is never NULL:
the input visitor allocates it via g_malloc0() in visit_start_struct(),
and on failure the entire list parse is aborted and freed.

Remove the unnecessary NULL checks from both callsites iterating
g->conf.outputs.

Resolves: Coverity CID 1664272
Fixes: 8dc8449a678f ("hw/display/virtio-gpu: Avoid leaking migration blocker")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260730114751.3515083-1-marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 946e56b42f61..270fbaae1029 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -69,7 +69,7 @@ virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
 
     for (output_idx = 0, node = g->conf.outputs;
          output_idx <= scanout && node; output_idx++, node = node->next) {
-        if (output_idx == scanout && node->value && node->value->name) {
+        if (output_idx == scanout && node->value->name) {
             info.name = node->value->name;
             break;
         }
@@ -206,7 +206,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
             error_setg(errp, "invalid outputs > %d", g->conf.max_outputs);
             return false;
         }
-        if (node->value && node->value->name &&
+        if (node->value->name &&
             strlen(node->value->name) > EDID_NAME_MAX_LENGTH) {
             error_setg(errp, "invalid output name '%s' > %d",
                        node->value->name, EDID_NAME_MAX_LENGTH);

-- 
2.55.0


