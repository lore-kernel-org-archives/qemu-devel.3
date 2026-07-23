Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8DBC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1we-0004ox-UA; Thu, 23 Jul 2026 18:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wd-0004oF-4r
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:11 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wb-0001SG-Ml
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:10 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-81e86df8987so10768947b3.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845868; x=1785450668; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0mhSD+dGlrr16JyRhT612XgJdqAQYtisMHkX7vK1jo8=;
 b=V/ta2K6ExA8jE+q0p63YNPXcwmDT/lEl0FF8BcoHapYgA5V+fp2m24GsTyFtbmslDC
 l7qoc4cPSX3PQLG2jNBY2XwVDUpNDD8DJ6Dk0BXKaCdkkcSzWgwIeNOA1X90V6zHmH/G
 FND15VTLkbcBAdSi80Ocs07wR1LhNBX8laupVu5Lqi2ZN6XlBKfXl4EW1jHBGlu7JPnw
 ghRtHu5AH4pmhCTSoM/Txw/9ibuWO2zPVYJfycMSHQ1+zQ7fWxKejphucpXiK/Yd0ZoR
 nD9Q4cVw4CuC6VQIYmocBQqaOQVRTBoMHC0TVE44Wv8kyi74ugSz6Nsn65LHnoasQtSK
 K8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845868; x=1785450668;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0mhSD+dGlrr16JyRhT612XgJdqAQYtisMHkX7vK1jo8=;
 b=ZYxlt9U2HFLxnzUF+lsYT4NPQR8NFg3boE6B6B2Ako8mmIpd7KPqrY5LJWwQIEuneK
 0YTaD5taYoK6hmult33A79cWfCqZrESGj1nAMyhjPp0X9TbgvKQ/Mt+fSilomljSDO5q
 RP1G3ualLqWCe1y0t+ULj2Xb5Yyo7l2OiUZg5+jSPOEMFOxUnGrp2e9Vdel9u+Ko+Lv5
 iDjotjR5B9WjBGQ57MZPmSe1Y/HOTsRvul9S+h+IBWFkABDwlRN1v36V1IDbirKa2r7z
 3gdL/Y89E/lRpTZb5EjCK9VYlkVEW+rfuZVq2q4wZx34Pa3agKb58iCinMu4tmoHY4Rj
 5x9A==
X-Gm-Message-State: AOJu0Yy+wj3U4ET4j8Xv0iIOYC6AinafHZyJ5AaJdDS0nXWe74z6nL3t
 G32Qg3JXezIBs3BjXw3R1RUprlsTWhqCjcxIhzTFbhwomLPNdJDLJolZ
X-Gm-Gg: AR+sD10xaOLO7f5WIh4EzFsFtPLYesJzYLa2345xw7saCnyJNaiGlsdSES6bo26T+qT
 bm234Rf1fcjQ/wYpIxgZy3E6FmfxNA8kNUv8paWygzrqbG7UbDxgf+ZxMtEkUR6xD11jkOnlc3y
 pRt0ZgvWbtwTH3Is6fZgDfIgYdRa27YDK1QqBa/zJ0lTpvABxj0tfxJxwZqC/eKUhyyXi19eR73
 8EGO/IR9Ag/WN/Xvsw4gd0ct2amFZyFL3G/+//7oPXTCuRn4TO+JnGfrkRKlTo7L41M+/wLm6qV
 qGJftjukj1pIap/pqLZqcIv4FBOFOVTNpW4wx9tmLIw1VWAvUwc/mpi0LDjS1x7R0GaovXZfye8
 cHSRWEt3mAyrarDka+YTPqw2mLC1posN1MF0CZ4nKb1L4l0E0R17cAbVFhnRAieMHFeA+LJQTcF
 kVCma2uTE=
X-Received: by 2002:a05:690c:600c:b0:81d:6eec:fe22 with SMTP id
 00721157ae682-81f4c31fc3bmr16487457b3.44.1784845868465; 
 Thu, 23 Jul 2026 15:31:08 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:31:06 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:06 -0700
Subject: [PATCH RFC 07/15] hw/virtio: iova_tree_foreach wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-7-6b97c439eb28@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=1785;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=Yoe4ouzD+Ga6/WRjo8rrhPx85XUfhnHf/hoKZtpa4Yk=;
 b=SHFDvD0FHkAmxfuGP0PJ+XhJubxb/9Wsa2vNeIpQYm30SiB9dn47KOyhBUjqLUHJCQAMZpONh
 2Odk2TK5fDCBU7bFrC04DFy3SRr5uW7vINzO/2fA8K0BupPKKrrCzXL
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add a wrapper to vhost-iova-tree that calls iova_tree_foreach on the
underlying iova_map.  This provides a means to execute some function on
each node of the tree.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-iova-tree.c | 15 +++++++++++++++
 hw/virtio/vhost-iova-tree.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
index fa4147b773..d8206379bf 100644
--- a/hw/virtio/vhost-iova-tree.c
+++ b/hw/virtio/vhost-iova-tree.c
@@ -189,3 +189,18 @@ void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)
     iova_tree_remove(iova_tree->gpa_iova_map, map);
     iova_tree_remove(iova_tree->iova_map, map);
 }
+
+
+/**
+ * Traverse through the iova tree in sorted order
+ *
+ * @tree: The VhostIOVATree
+ * @func: Function called at every node.  A false return value ends traversal
+ * @data: An argument passed to func
+ */
+void vhost_iova_tree_foreach(VhostIOVATree *tree,
+                             GTraverseFunc func,
+                             gpointer data)
+{
+    iova_tree_foreach(tree->iova_map, func, data);
+}
diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
index 08f63b61cd..f3b7c48cb9 100644
--- a/hw/virtio/vhost-iova-tree.h
+++ b/hw/virtio/vhost-iova-tree.h
@@ -29,5 +29,8 @@ const DMAMap *vhost_iova_tree_find_gpa(const VhostIOVATree *iova_tree,
 int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *iova_tree, DMAMap *map,
                                   hwaddr taddr);
 void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map);
+void vhost_iova_tree_foreach(VhostIOVATree *tree, GTraverseFunc func,
+                               gpointer data);
+
 
 #endif

-- 
2.43.0


