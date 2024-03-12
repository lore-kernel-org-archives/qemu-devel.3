Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E35C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZd-0004Xw-PE; Tue, 12 Mar 2024 18:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZ7-0004Op-Np
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZ2-0004CL-TZ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krVRp63g5I+fEEA6M4zx0/VUoa56zmARDX83eYqmjT0=;
 b=iv9XIQa5l9zo7qePeuXQallJGrAAJJ/NZGmWFfEgd6K38ibV6dLt0+9ba7kCNSgyM9UmS3
 9vvUmmdOjSdyZYOMrQN+jG13K5GxZkCkYnMuPEI5e0scQ82VlWsnrg8XkNF+iX6ehwiRu1
 fAk8gjreWVegVysvS6Z6lmhIZrc+zgM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-mtUONPT4PnmiInIu_7OAMw-1; Tue, 12 Mar 2024 18:25:39 -0400
X-MC-Unique: mtUONPT4PnmiInIu_7OAMw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513c6e69b85so348555e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282336; x=1710887136;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=krVRp63g5I+fEEA6M4zx0/VUoa56zmARDX83eYqmjT0=;
 b=cvVpkjkChD+cxNFYn1OjVxQunmjkQQ6rUMFZb7dDGxhHzJ0avQ/2Q1bVulyqRfdcmX
 J3AiW2iDxqkiLORLZIWOPvX6dR5kUpW1qpP0MumPVwFjq77+vspQUNFYH9N1VZedqqwV
 DJCKYqRlV2LAycmwLtkDYQhhfngf2q6t9KZLxNSPSkO+JdaxgMgcQFBO5DqATJcvzl+X
 wNU3E2ucpob5s1zUG2v7SzqXsp5bvAtwRxCq3PuYhgqTtu3GyYctX1cm4Nekb+ovDna2
 /LXrCX9jg9BqMApJYEBCGXw4u9Mab+JYx+N8q1kmo2y1eZJWHEkOhAjvrV4I7B39G9yP
 wxgA==
X-Gm-Message-State: AOJu0Yx2/kDJgjsZYsj7WqoiGrlswkbfy2bLkb5AApAEqOx8lh3kKUbk
 Y+u2ondEzj/oRAHXs7cUzfSJ+c1gzNzn/6KGPxtSWzvm3lPYCbsPobgODVXBWPyCthLpgafVS73
 m6leBcChAkmqegb7KYANoKJJzTTR5WNpWf8pmYyXQJemzN0F1V3xfvCf9HuexX/in9fqGupDWYr
 MeHCphaTPGJ+s7mO8gyU1RZCmkhtwX/g9K
X-Received: by 2002:ac2:4c9c:0:b0:513:7ef5:1059 with SMTP id
 d28-20020ac24c9c000000b005137ef51059mr7631689lfl.18.1710282336475; 
 Tue, 12 Mar 2024 15:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiPRmz0z8sAT7zaOzl680KYS5WmcNdKjtBRGKMACegR27ISQ3JMkUPDnJ1/4EnuR7x79M9WA==
X-Received: by 2002:ac2:4c9c:0:b0:513:7ef5:1059 with SMTP id
 d28-20020ac24c9c000000b005137ef51059mr7631666lfl.18.1710282335763; 
 Tue, 12 Mar 2024 15:25:35 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 ws7-20020a170907704700b00a42f6d17123sm4176501ejb.46.2024.03.12.15.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:25:35 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:25:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 01/68] vdpa: add back vhost_vdpa_net_first_nc_vdpa
Message-ID: <573581b18dfd458ddac22f832bfb3f6fc9b585dc.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Si-Wei Liu <si-wei.liu@oracle.com>

Previous commits had it removed. Now adding it back because
this function will be needed by future patches.

Message-Id: <1707910082-10243-2-git-send-email-si-wei.liu@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e6bdb4562d..1d9496cdd9 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -287,6 +287,16 @@ static ssize_t vhost_vdpa_receive(NetClientState *nc, const uint8_t *buf,
     return size;
 }
 
+
+/** From any vdpa net client, get the netclient of the first queue pair */
+static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
+{
+    NICState *nic = qemu_get_nic(s->nc.peer);
+    NetClientState *nc0 = qemu_get_peer(nic->ncs, 0);
+
+    return DO_UPCAST(VhostVDPAState, nc, nc0);
+}
+
 static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
 {
     struct vhost_vdpa *v = &s->vhost_vdpa;
@@ -511,7 +521,7 @@ dma_map_err:
 
 static int vhost_vdpa_net_cvq_start(NetClientState *nc)
 {
-    VhostVDPAState *s;
+    VhostVDPAState *s, *s0;
     struct vhost_vdpa *v;
     int64_t cvq_group;
     int r;
@@ -522,7 +532,8 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
     s = DO_UPCAST(VhostVDPAState, nc, nc);
     v = &s->vhost_vdpa;
 
-    v->shadow_vqs_enabled = v->shared->shadow_data;
+    s0 = vhost_vdpa_net_first_nc_vdpa(s);
+    v->shadow_vqs_enabled = s0->vhost_vdpa.shadow_vqs_enabled;
     s->vhost_vdpa.address_space_id = VHOST_VDPA_GUEST_PA_ASID;
 
     if (v->shared->shadow_data) {
-- 
MST


