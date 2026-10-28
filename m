Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B1E606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OVQRk4Oo;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JexMZkPg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7G9-0000Ud-ES; Wed, 28 Oct 2026 13:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FO-0006rn-T4
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FN-0003mu-BM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C82Df0CVZiltYQMNBJ4Ez/GeXw7e26DSg3uA8bAJFsI=;
 b=OVQRk4OoMjnjh2S+oOFNYOQgvdwbUnG4RhizXYLTe+82zXhhuQDXxgL4IoWxqO6/nHfjyq
 2VYFr5JTiT5g8v9KOGKC3f4j3eZdCirFub+P9IWPfEtFZ9Ton9oL8DH9E2Vx/Qk7Ed8XmN
 Trbf0+vWniCDnGxn6FO0XNIKxzBL6aU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-oTRtbriFMcy8RTB2J_LqFw-1; Wed, 28 Oct 2026 13:15:30 -0400
X-MC-Unique: oTRtbriFMcy8RTB2J_LqFw-1
X-Mimecast-MFC-AGG-ID: oTRtbriFMcy8RTB2J_LqFw_1793207729
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48c7fe9736eso1033150f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207729; x=1793812529; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C82Df0CVZiltYQMNBJ4Ez/GeXw7e26DSg3uA8bAJFsI=;
 b=JexMZkPg09j2R2bzMhYKUtTjeOlyGijE01CfQKUt6V00AClX3jEqikfoWZrWKLcogd
 qDUK5JzLAJCcBABd6KhUVy3Zt6onUenBHRpKhLThADPYH7DDqs6Oi94oc1AS6k7F+G8B
 T/DA8lH9pcoNwmvErmbEn1zvvSHkA59lE4LNE7yivxrCjNzlnoeWVI+HPEzn0OusdKXg
 ZcpCSxN6ZWoC8iguiMDmaH5Mq4qIOOHQwSmcYug7cQ0BpUS9blClITqT2wtjjapBQSwt
 PQYx80axTzU61mcvatDXnhVV79Nkdyi1XU9xZYEgTyWc+Ejo7C3LIeuNyFbeUU8boiTQ
 JBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207729; x=1793812529;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C82Df0CVZiltYQMNBJ4Ez/GeXw7e26DSg3uA8bAJFsI=;
 b=G1CYm1duM4YXRIbWG6+v46R0P1p1yU3gaEZXQwwGlRD7JFP+3QBqSr0DZY03n64uFL
 ip3V5W1cuvjtpRfK9jdHyc0wRaDFAS7Dd8eh/Fm7PX3DjQxWhvfr1VNvOTMxjMHhR41+
 nbakaOX4iXlpBi7ilpwfW58Ah/5gx6JEwZRlA43zj7qPGtuq+vhHeAx8Fl1uJsEgsCT3
 EeIw0GoJLWyzyQsmnhTNTOkYGv4ORbLn4j70U/rjRQwkYx97/UtrAN1r6dgtqG2ycVx1
 UIaxdt7YE9GUGRLvQAjhmN+8S71KFGd2IgziiImYy1dkp02SZ7SZi+Vtv2dddZfOtomZ
 ebjg==
X-Gm-Message-State: AFq9FYKOQvSdVC2hf81jkmx3ZaGlPcJDAkXC8xGS3/tYZsEaywkwwiKr
 6OCVslQHYSLjBM6IkYlzuvIwDSpugRN7P2y+YPtOHbhKb7D3cm+uTvf9eerrEtNI7SG83IuJxda
 1/MidsfQ8RjiI1VNZmj34oFKL+2UBII8+yfhY+wMYbfI6Zlc0aq6OAAoNkiDq8nEvRUsoFmM3Nh
 3PnEYNpSyKfk4zwDgtTeoMQOAHZLskovFwZA==
X-Gm-Gg: AYBFou1dcin3uOx2l5Vpd4VbybTSFuF1YIgCFrpWvNfxedDizkOzFHPbBC2Vzs/MjpD
 fDYf6GKZecjLegNbFCuKARvScovzOmvMxJtceJWqsZ6m4druipcPw5KnwY7wolRRdTYx8/V7uyM
 +WkifjSpRchHt3sYNVssxcXFlQMioNTiOTZEZFLsQeo/PAA0jqy1s7YbItM99CFwF8Qvlowjz5W
 otE5WFsGzjYHUr9G1CV3dw+BdNUqm9jX2BOt2goAMKly7cszU5T1UBHYK34jGagrK43ka1KEsM6
 Hq4tYVMVeMC/71n0uXha5SDxNKdAr8sEDAlQaE2JZPkeQnF/v9JGM+6l98YTGBZ8ccDpo/G+NDE
 TfMplAsxFRrC2CRDD/jPTkEwRG/Q2RpqAtIrvQr2l
X-Received: by 2002:a05:600c:4452:b0:4a2:fe3:121b with SMTP id
 5b1f17b1804b1-4aa4eb767d1mr24065015e9.28.1793207729100; 
 Wed, 28 Oct 2026 10:15:29 -0700 (PDT)
X-Received: by 2002:a05:600c:4452:b0:4a2:fe3:121b with SMTP id
 5b1f17b1804b1-4aa4eb767d1mr24063965e9.28.1793207728544; 
 Wed, 28 Oct 2026 10:15:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm6260745e9.15.2026.10.28.10.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:27 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Nikolay Kuratov <kniv@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 33/78] qapi/monitor: Handle missing vhost-user protocol features
Message-ID: <7d09b0224d2794dfcd3e00956dd8563945a8ff51.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Commit f9a8f5812607 moved protocol_features to the vhost-user backend.
As a result, VhostStatus.protocol_features is only populated for
vhost-user devices.

For an active kernel vhost device, HMP info virtio-status and QMP
x-query-virtio-status crashes now because of unset protocol-features.

Make protocol-features optional in VhostStatus and skip dumping a
missing object in HMP.

This is a compatibility break.  Okay, since VhostStatus is only used
by x-query-virtio-status, which is unstable.

Fixes: f9a8f5812607 ("vhost: move protocol_features to vhost_user")
Co-authored-by: Nikolay Kuratov <kniv@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260922213210.1429435-4-vsementsov@yandex-team.ru>
---
 qapi/virtio.json            | 5 +++--
 hw/virtio/virtio-hmp-cmds.c | 6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index 0a4753cc34..f6876a5de1 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -82,7 +82,8 @@
 #
 # @acked-features: vhost_dev acked_features
 #
-# @protocol-features: vhost_dev protocol_features
+# @protocol-features: vhost-user protocol features.  Present only for
+#     vhost-user devices.
 #
 # @max-queues: vhost_dev max_queues
 #
@@ -101,7 +102,7 @@
             'vq-index': 'int',
             'features': 'VirtioDeviceFeatures',
             'acked-features': 'VirtioDeviceFeatures',
-            'protocol-features': 'VhostDeviceProtocols',
+            '*protocol-features': 'VhostDeviceProtocols',
             'max-queues': 'uint64',
             'backend-cap': 'uint64',
             'log-enabled': 'bool',
diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index e5da6f0069..5b08a06ec4 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -176,8 +176,10 @@ void hmp_virtio_status(MonitorHMP *hmp, const QDict *qdict)
         hmp_virtio_dump_features(hmp, s->vhost_dev->features);
         monitor_hmp_printf(hmp, "    Acked features:\n");
         hmp_virtio_dump_features(hmp, s->vhost_dev->acked_features);
-        monitor_hmp_printf(hmp, "    Protocol features:\n");
-        hmp_virtio_dump_protocols(hmp, s->vhost_dev->protocol_features);
+        if (s->vhost_dev->protocol_features) {
+            monitor_hmp_printf(hmp, "    Protocol features:\n");
+            hmp_virtio_dump_protocols(hmp, s->vhost_dev->protocol_features);
+        }
     }
 
     qapi_free_VirtioStatus(s);
-- 
MST


