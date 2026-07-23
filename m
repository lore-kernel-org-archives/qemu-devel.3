Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4635CC531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1xp-0005y0-7h; Thu, 23 Jul 2026 18:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1x3-0005D5-Az
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:37 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1x1-0001W7-Pv
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:37 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-81ef8255cccso9579447b3.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845895; x=1785450695; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wsH8kj/3dWv6cLIAPdQqtziw/Fcf/VIereTmaACRGrU=;
 b=s52DGFvYW0L6VFYgbFawu57yhBYWC+CvQ1ET4aeZ0BdPYeDEXE8qURWcYv+GcyrjWi
 O5XBDLkWtfqo0cpKZLVwgcSY30NN9ux/9SEJt9ga/5lF+VoiwTuJ4TJl3bGBC7jGBual
 3CUdo8MATKfjt4ro6UDjoYEMxlkoty/jdAZCt14+AebZIRavWC+AplKJSmmVulBheVRE
 fV1VqTlbBZZ3HAPF1y4m2JM91cr3qdfeSBY+WhVroaLTKJ1/2VL9+vWOOIqNWp0UYeyS
 dKSEvdrLW7rgldJNi2/RYm3eUEcU2TujZJ6z6Dz3ro5FAhgk7AXbFvqOcyh2Je4laolc
 G1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845895; x=1785450695;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wsH8kj/3dWv6cLIAPdQqtziw/Fcf/VIereTmaACRGrU=;
 b=eysOYviDQmigixnIkDOopJuDtmRVu0/WF3CRyrxGJ0I2PfdQhyMXwjhuQtxXvNX5yw
 5hAY0Uty/gxfkv+6Lm1KBgGqqfxR7ZfEmnq/opN6dV6DOJWtaNqc2vIlHKa9tQbcmxQp
 hDJilHKq1HOoBXMw6h11kG+gDwRc+II5bKjbzUtWAOh/CS1wvJ4RmHnn1RnrCIbNFVPF
 LKhHvKahL6JPsTVL+pmmlJ0en3O0ojc0Y/73nHy5vys5h+7THOcLsZ5Pc+pWptgbDILK
 1GmRoVklN0A0XiJs/WDR/I3kmVY4UuW5w+p7JMDZAdQMHjQBOBbKw890izIkp737vjeE
 NFmA==
X-Gm-Message-State: AOJu0YxtqviOA1mvbdnuR5a+PNSRDzO21zAKZhlY9Zd4E6dwZKEuTa8g
 hJM2IEI5LVcughU9jznxuaSc5RiMsUCOXvCASn2q/DF8ST8uBgEjrH/0
X-Gm-Gg: AR+sD12U6ySnrdArPIrA7X1lsNPEhSKavXpo3L0w+1KHZn8IUFj1YGCEnbB34EdV0Qr
 QF8WGPY7ZmXKbx/MmOXTaUubo5K26pyJVmq5rbBFCUkvKC+Qkct8vkVK7Qx0ovDlDVTd95NkaRr
 vnfHVguyjwKjOuIE9UN4U/PWutOe/JWEvw3JWFnT1kriw0tSGAqOiMDmwYwRT9BXPNKCPJ7DRJx
 8tbSgmZFbKUWVJm1NAVT44lAVA9ZCQGBz0ihWg0e7kTHwHtYS4X8APEdmW0tblrifxd3cszTDO6
 oo5Jv/Lq+FjFbFhfXBhcX4KEGZoQGwhyAAlcAbZULFAcTI87XyrAmlE/PdAPjDptP31EeBO29wd
 OVaOO9hNm2Y6ZYJmxNn7rq2bzJIJZrXsF/eviLLk3yTzUFOt64VxCY13Wf5UF9HoplIRWLOrtrC
 ZNTOf3r6c=
X-Received: by 2002:a05:690c:6e0f:b0:81e:fbcd:7d5b with SMTP id
 00721157ae682-81f4c322550mr16240747b3.48.1784845894768; 
 Thu, 23 Jul 2026 15:31:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:31:34 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:14 -0700
Subject: [PATCH RFC 15/15] hw/virtio/vhost-user: shadow vq cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-15-6b97c439eb28@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=1307;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=pisgaTgm+ZiObME3tqs8+StA8fZGh7Ia1Av4+zrft74=;
 b=TKTPDfMHj7ZdjHO/ODp2CBOHuJLnh0vD84p1jGP0HewGtInAJEuyxPU1ExLs8Hpdj392t+hFk
 aqkNu70i+oaA+6Qkgwug3b6ISRANc5tQC0LoyjBr6aCpMgIFECkEtSD
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x1135.google.com
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

Implements functionality to cleanup svqs on cleanup of isolation
regions.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-user.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e65f877f9a..bb4de78b95 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1140,6 +1140,15 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
     return 0;
 }
 
+static void vhost_user_svq_cleanup(struct vhost_user *u)
+{
+    for (int i = 0; i < u->shadow_vqs->len; i++) {
+        vhost_svq_stop(g_ptr_array_index(u->shadow_vqs, i));
+    }
+
+    g_ptr_array_free(u->shadow_vqs, true);
+}
+
 /* TODO: Is there any notifier cleanup required here?*/
 static void cleanup_isolation_regions(struct vhost_dev *dev)
 {
@@ -1147,6 +1156,7 @@ static void cleanup_isolation_regions(struct vhost_dev *dev)
     if (u->iso_memory.base_addr) {
         vhost_iova_tree_delete(u->iso_iova_tree);
         u->iso_iova_tree = NULL;
+        vhost_user_svq_cleanup(u);
         memset(&u->iso_memory, 0, sizeof(IsolationRegion));
         qemu_memfd_free((gpointer) u->iso_memory.base_addr, u->iso_memory.size,
                          u->iso_memory.iso_fd);

-- 
2.43.0


