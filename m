Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C5F606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HSG99Rjk;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hMASPbQy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7IN-0005rm-Uo; Wed, 28 Oct 2026 13:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HO-0003QJ-Ml
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HM-00043B-I5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MNJVsBWmCkJO0pPrgSkqSm3MElOoW69IWkAogG/MGWw=;
 b=HSG99RjkouZR0ICMKeaU2h9n8SozE3bIe1rfB9WMCwPB+sJDiRsTKt/jtDo6HNKdmk7+V3
 XPjA6mwewucTaPddqFFfJ9Sr+XC0UFOKj2AICogfkbCGVPHLU9OrXRoVhRLNpHhOGViLSK
 7Osk1fe4eGjEML/0hVKwxuce/qjqd3c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-Cu074L3cMmi4gRJ3vNvqQQ-1; Wed, 28 Oct 2026 13:17:34 -0400
X-MC-Unique: Cu074L3cMmi4gRJ3vNvqQQ-1
X-Mimecast-MFC-AGG-ID: Cu074L3cMmi4gRJ3vNvqQQ_1793207852
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a35e1d2dddso11376025e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207852; x=1793812652; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MNJVsBWmCkJO0pPrgSkqSm3MElOoW69IWkAogG/MGWw=;
 b=hMASPbQyoxOg2YSe9Nkb7p6ull4rV/xOzs69gpFCbpht88oJY92VpB05noi/vbEAiR
 fpayAKa9kmqI7H7hYxPRZevdPPH1T8nrr6Sr2tk/dJD3uF+MQguDgbhGHoNp0iQovupY
 dNa/+fKzhrA5/D24aa1UV0x8dvp/tpJnynt5AtP3xZnzv2p4r3CKD/GGI8eRSv+2B6cZ
 I9EGJaJ4wFOkyRM9EafUijzAzBseB+Yz4WUxpTf5WVqXY0UY+Yavp0zwXCSLi+qg6CGy
 7uepn/rFUIULX+DrGPIIYJd9ZvwFilXdkzRs/KctprJRM/DfQV+SFd7ETD1o2kz1+42q
 mgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207852; x=1793812652;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MNJVsBWmCkJO0pPrgSkqSm3MElOoW69IWkAogG/MGWw=;
 b=bHbeeqM2hJa8OQn3uPE93AAEjKuV0tHIEyRQ8Z/NMNrRUbYDrDyoUhZgrI0LjMA8b3
 2vjYwK05Iu8rsa4T24cdcZ0hCG4Ze8pve7ntw8iEqWeRDWUm7uAVhjijwIjj4eocYTUz
 jW2GfsOiQH9OfZ1OmJYY1AwkxfmjFMQvg2OmklDS0cD9C/gCafAkfINIaIVzgDtqI7lm
 Vyp7/vjWzE56a6v3w7iE+OlfRFilOE31EI4r9TsiBL/ztEScJ1dYBfq0HnjLS7hRosEo
 Smu8XzbPe0eU3X3xx6a2GMANbsu98/krQcJ7ZLx+86CGJ1lvqhHa5LSvu5KK8l3+YK3B
 68uQ==
X-Gm-Message-State: AFq9FYLFKOhjtAKt9UO/vhLFETHV64/S6h0yfa+AmADR62lJrQfHmxG0
 cKlaacrRZgwFYAUg0xdR7J4u04ZAWfe9X0GddBYTbXzEnO34igiz4Dc3bymhEbrKBBF35XNSwTa
 1L/7eaAtIm0yCKEsojwB8W7h34lvilFGCj4PWK4+R/f5h70auZtpG+1x0J6VaL69nTYDQ5MhmGJ
 eAC8q/Vj+XdJJXebxa8oiw/wByVEDoo2qCrg==
X-Gm-Gg: AYBFou2RLe2oqV4/b6AZJIRIEcS4nRSJRpe24Q7N9tmECMjaIw7IgeW/k6gLx0GadVG
 Ov5/zg7D0+zZyJFL2Mr8wuR03It1LCKm5MQQfB3EnhXX6YvxUJZvKhX7kVyupoi8SF+sM4VLXeU
 P6wKDeHjCXXe0XOjOJkZzXB3EiLCUV0EvLB75tztE0NiNHW0zsWRVvZdy4AFMLv/n8OaUOF4McA
 FQ2zAxGWYIkJ2cUG9+8FaQVD7z4hMGVCYzBD5/2b3fZly3q0Jx+Dkcjmy99pq+XgG1s1f4vWwWC
 o4nn6BkKPVlkQw7SztIPb+EUJMTQAgq/qlNbINlKMMNMRkxJzdulH6Bw0Mw/O9cmcMXmV/GlAae
 0/sTOMPMo1+su4qTtpCNfTdcH3KfkpgwZDtk0oXip
X-Received: by 2002:a05:600c:37c3:b0:4a2:1867:10e8 with SMTP id
 5b1f17b1804b1-4a96701830cmr66182545e9.25.1793207852188; 
 Wed, 28 Oct 2026 10:17:32 -0700 (PDT)
X-Received: by 2002:a05:600c:37c3:b0:4a2:1867:10e8 with SMTP id
 5b1f17b1804b1-4a96701830cmr66181835e9.25.1793207851556; 
 Wed, 28 Oct 2026 10:17:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f418afbsm6877935e9.6.2026.10.28.10.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:17:30 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:17:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PULL 75/78] hw/virtio/virtio-mem: Fix error message on invalid NUMA
 node
Message-ID: <3650cf4f7c7cdd013bb801d5945e57899da195d4.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Gavin Shan <gshan@redhat.com>

Add space as the separator between "exceeds" and "the number of numa
nodes:". Otherwise, we will see error message with twisted format like
below.

  qemu-system-aarch64: -device virtio-mem-pci,id=vmem1,bus=pcie.3, \
  memdev=virtio-mem1-mem,requested-size=0,node=1: 'node' property  \
  has value '1', which exceedsthe number of numa nodes: 1

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261020012404.191329-1-gshan@redhat.com>
---
 hw/virtio/virtio-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7130ed852d..ee6a0c206a 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -846,7 +846,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     if ((nb_numa_nodes && vmem->node >= nb_numa_nodes) ||
         (!nb_numa_nodes && vmem->node)) {
         error_setg(errp, "'%s' property has value '%" PRIu32 "', which exceeds"
-                   "the number of numa nodes: %d", VIRTIO_MEM_NODE_PROP,
+                   " the number of numa nodes: %d", VIRTIO_MEM_NODE_PROP,
                    vmem->node, nb_numa_nodes ? nb_numa_nodes : 1);
         return;
     }
-- 
MST


