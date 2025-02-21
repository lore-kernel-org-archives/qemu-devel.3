Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE379C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS5B-0000ol-Ao; Fri, 21 Feb 2025 07:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4s-0007uy-Ry
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4q-0007Bd-J4
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+vuP+wp5WYQIHMmPYDAfhQFy0pXwNh7ZSHKv4P/Gxg=;
 b=Au9qt93vd0/ViYWRvUkliPTdUhVvOAurWRknoq9bEQIqvGFeJ5JyfXjRSZG3rQzFjI1v1P
 z04unoQp7p74e5hQPXc/zaG5OiyjkBdIlGRD+9LBAQb+Wl7v/WBQ0tBz5rlHuaBM06c8BH
 CATE41kgOnRSy0o/IhQ2z4TajNTz1mQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-HD71-DUPOrC96YwfTrw_xg-1; Fri, 21 Feb 2025 07:24:17 -0500
X-MC-Unique: HD71-DUPOrC96YwfTrw_xg-1
X-Mimecast-MFC-AGG-ID: HD71-DUPOrC96YwfTrw_xg_1740140656
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43995bff469so22360695e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140656; x=1740745456;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A+vuP+wp5WYQIHMmPYDAfhQFy0pXwNh7ZSHKv4P/Gxg=;
 b=R8zd8YmHP0wjfkf8ksav15xfrCKTuwkMf2qDrEwu+qRMCvwJDjXowdRlJImhN7Orpu
 QGfcfTeYIT8GHcsLWPbD5dkjq3Tfe/b/EpauLvSP8IzzYy690hhO/o4sWQU63Pd0uQeh
 VA9Jp1ZGg5Pfc9fHZx0bScHwMGDMJC5n/9z1/bI9hjt6N8LM3JGAs+uXh/GyG6o/62nM
 Wi4mBNsU12JaS4+d7RZOKXoVLlT75CJly44TVjCvCeW3SMfm/6d4GQKy4S7dsmdel3Le
 WKPimp8/5ZsouthY313ceCxQ+OTG/v/V4D9LDsZyg6E+voEo1SsJ9CKPePgYNLMmjqAE
 yVnA==
X-Gm-Message-State: AOJu0YwLLtI6+CtyqYo0lGtZ7iNJsiEzmsnmkbS/WnhZ0jyIlEUAGreG
 yGD0CzNFYmRLiG6QQRyDwYj074dF59klbl1aPYetMTRozREGxFBU+OI07Od+6kMnoqqJGEh3kwj
 KSqKlNkKtNgNme81xYXTofhldbRIq17f/Rq7ztmAy850h6nOVOEQQ5eSuhIpCrBUg0Li7TpvT7F
 yBBcLH/dxtm3orF6AAHjDgu866rzDGvw==
X-Gm-Gg: ASbGncuM8toDDyR3bQPA074JjchNOVvjTnFIa7oNZJHoQtht7P+KKLd9DcAQMD0TmHg
 dyW/dHMvY9jMaGqtK8tnrKvfvHxBL4sNE8v3dCQ9npZsT2v41qFwq5+QwLT6UFV0w6Mwvxm3bRk
 YSFWLIMTRgw7V9d0/Lu0/QAL2eXyBO3ENFD51xcvVhc0JVVWVArqq13hfUcAeRjHpV6gakyYIWL
 VN9UJy9F1ESoVwGZ/0kreUYhwDvlCpibYPH7Sx5mn1Y3M9qGTb/2dYb01H+9/wshMEmizkW4nbn
 Qo/oyA==
X-Received: by 2002:a5d:64a3:0:b0:38d:eb33:79c2 with SMTP id
 ffacd0b85a97d-38f707b0962mr1943488f8f.32.1740140656140; 
 Fri, 21 Feb 2025 04:24:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOQdYe/jRCBs/h5WCxs8VZNxg4pjXo2WFNg3p1tnMmOnzsadTHHEqus1bu6mU2w5l500hkbQ==
X-Received: by 2002:a5d:64a3:0:b0:38d:eb33:79c2 with SMTP id
 ffacd0b85a97d-38f707b0962mr1943465f8f.32.1740140655719; 
 Fri, 21 Feb 2025 04:24:15 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5923sm23452690f8f.74.2025.02.21.04.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:15 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 30/41] vhost-iova-tree: Update documentation
Message-ID: <332859dd597b78f7d1ebfaefd6195e3a2b3e5906.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Minor update to some of the documentation / comments in
hw/virtio/vhost-iova-tree.c.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Message-Id: <20250217144936.3589907-4-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-iova-tree.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
index 9d2d6a7af2..fa4147b773 100644
--- a/hw/virtio/vhost-iova-tree.c
+++ b/hw/virtio/vhost-iova-tree.c
@@ -37,9 +37,9 @@ struct VhostIOVATree {
 };
 
 /**
- * Create a new IOVA tree
+ * Create a new VhostIOVATree
  *
- * Returns the new IOVA tree
+ * Returns the new VhostIOVATree.
  */
 VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
 {
@@ -56,7 +56,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
 }
 
 /**
- * Delete an iova tree
+ * Delete a VhostIOVATree
  */
 void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
 {
@@ -69,10 +69,10 @@ void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
 /**
  * Find the IOVA address stored from a memory address
  *
- * @tree: The iova tree
+ * @tree: The VhostIOVATree
  * @map: The map with the memory address
  *
- * Return the stored mapping, or NULL if not found.
+ * Returns the stored IOVA->HVA mapping, or NULL if not found.
  */
 const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
                                         const DMAMap *map)
@@ -81,10 +81,10 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
 }
 
 /**
- * Allocate a new mapping
+ * Allocate a new IOVA range and add the mapping to the IOVA->HVA tree
  *
- * @tree: The iova tree
- * @map: The iova map
+ * @tree: The VhostIOVATree
+ * @map: The IOVA mapping
  * @taddr: The translated address (HVA)
  *
  * Returns:
@@ -92,7 +92,7 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
  * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
  * - IOVA_ERR_NOMEM if tree cannot allocate more space.
  *
- * It returns assignated iova in map->iova if return value is VHOST_DMA_MAP_OK.
+ * It returns an assigned IOVA in map->iova if the return value is IOVA_OK.
  */
 int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map, hwaddr taddr)
 {
@@ -117,9 +117,9 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map, hwaddr taddr)
 }
 
 /**
- * Remove existing mappings from iova tree
+ * Remove existing mappings from the IOVA-only and IOVA->HVA trees
  *
- * @iova_tree: The vhost iova tree
+ * @iova_tree: The VhostIOVATree
  * @map: The map to remove
  */
 void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
-- 
MST


