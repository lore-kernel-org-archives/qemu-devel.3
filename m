Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7DAE6FE23
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 18:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY7Ji-0003pS-CH; Tue, 23 Dec 2025 13:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.avcz3212g2ez0v6=kq7azdnbl7w1=aw3ze8kahxz6mf@em483429.getutm.app>)
 id 1vY7JV-0003ow-GQ
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 13:40:54 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.avcz3212g2ez0v6=kq7azdnbl7w1=aw3ze8kahxz6mf@em483429.getutm.app>)
 id 1vY7JT-0004DQ-Fp
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 13:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766516142; h=Feedback-ID:
 X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=4BY0VZOet5vd6KSlhhmDdLMHab3R98aFPuZ5N2Log9w=; b=gRr494BbZaPtDk0HsJKxjD2eJ8
 tjjVU+yNKN5A6kd+T1+YaX/h+G8IcxVYDnLodqySmOtRXHFFr/YFj1Mmrd7AaukqPpV1F7zafXlz6
 ta6TVMBm/UWl3/ZhCDZAOo/uKfrgU9uNXmLo5gmuwBuMU/Iy6whTTkG4ZCTI3f0xSakSSvo73SSAk
 l8rNhI1dvPBww9LWpfVznfodrX+ZoYvHiC86j8cBGzRw040813PFx7IvUtMgWKR4t/+kzXnIi3wHX
 RTYJvg2QSCycAZtHtUqAo5FX5LGzkOVF1cvWrvgNa/3ggUgEdIpT6w3ueCILlvEZUIt3DITlkzAqT
 uEwSIeNQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766515242; h=from : subject :
 to : message-id : date;
 bh=4BY0VZOet5vd6KSlhhmDdLMHab3R98aFPuZ5N2Log9w=;
 b=E9ljRwhiIdj4OjLuK/sGBJ1k55GXY8/k6ZhB5bScgxDl5dAH/kmKIsp1Yws9XLU2yXg94
 iGIXQdXkvdpNBW7tCpuwANwbuSg3WtLQe8v5QKrXOa+zEcp1Zvw54+7JnatszjQugCTghC4
 HNiJqpfAoQcxQT7/Y+ny9xoTTietlzKsN2ULz6kgQ7+jg5flgROo9z9ygsZ/cAgFxiWVC+r
 Id1Ckd8fuDViVmk+XAK4VfZYyxKZlqCCMpb6hAAW3ql0VvOmAn6Q2lWTUwn9QdDmANKJBuO
 b1YdOdjZZifFG/DZQgoSQQi27m065P6lVpWy0DbhpZzFyKuf+Gl759am6Vlg==
Received: from [10.45.79.114] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>)
 id 1vY7JE-pH9N2I-Mb; Tue, 23 Dec 2025 18:40:36 +0000
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vY7JC-FnQW0hPnEd1-NKBb; Tue, 23 Dec 2025 18:40:35 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2] virtio-gpu-virgl: correct parent for blob memory region
Date: Tue, 23 Dec 2025 10:40:23 -0800
Message-ID: <20251223184023.1913-1-j@getutm.app>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: li8Tt7G8UIy_.Ru0QzrBkZFJT.N4WANw_bNOl
Feedback-ID: 483429m:483429abrvJvs:483429sV2aZ3aji2
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.avcz3212g2ez0v6=kq7azdnbl7w1=aw3ze8kahxz6mf@em483429.getutm.app;
 helo=a2i327.smtp2go.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When `owner` == `mr`, `object_unparent` will crash:

object_unparent(mr) ->
object_property_del_child(mr, mr) ->
object_finalize_child_property(mr, name, mr) ->
object_unref(mr) ->
object_finalize(mr) ->
object_property_del_all(mr) ->
object_finalize_child_property(mr, name, mr) ->
object_unref(mr) ->
fail on g_assert(obj->ref > 0)

However, passing a different `owner` to `memory_region_init` is not
enough. `memory_region_ref` has an optimization where it takes a ref
only on the owner. It specifically warns against calling unparent on
the memory region. So we initialize the memory region first and then
patch in the owner with itself.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/display/virtio-gpu-virgl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 18404be5892..70e0aff0ca3 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -123,7 +123,8 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     vmr->g = g;
 
     mr = &vmr->mr;
-    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
+    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
+    mr->owner = OBJECT(mr);
     memory_region_add_subregion(&b->hostmem, offset, mr);
     memory_region_set_enabled(mr, true);
 
-- 
2.50.1 (Apple Git-155)


