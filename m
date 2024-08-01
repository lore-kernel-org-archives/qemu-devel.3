Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A83CC52D6D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTA6-0002PJ-6R; Thu, 01 Aug 2024 06:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTA4-0002Nb-Cc
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTA3-0001Vt-0k
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kgmm3IotKTqf6PLczhlGHew1zzskcB2o2OnEpQJZu0M=;
 b=H43ZAeF58TweFZO8XSTjkm93wWB9rZ11WKrB1OBxPSkPcLH4BgYJmtEY+6Jdnf31WzrLnR
 Svi3BnNmCI6RPNcgxTr0wpl0HHvoWUKuhHbpJYxyc2C/odzCZcny1WpynPmegTWhXGUt6l
 ob4+UFFxExbFoUH3WDCvSDcQY1XxozQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-V46F0ZBIO5a16yBWn_yIjw-1; Thu, 01 Aug 2024 06:35:53 -0400
X-MC-Unique: V46F0ZBIO5a16yBWn_yIjw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7bcaa94892so579678566b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508551; x=1723113351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kgmm3IotKTqf6PLczhlGHew1zzskcB2o2OnEpQJZu0M=;
 b=qACyhGJnGHrtauNr0FW0SlyNOvN2umkA7PNzCzy2Z+1xR+iF2K5N7EQVF+8TxuNi4G
 KegDtTzFOXAdFc/QYu7eMaQaCFrl0mzqwoH1JdIz/qnieX+vRXyOj98KeCIa5e/qcjim
 Ar6gHXnr8iPQRmXmc/UAH8R4Fky9A2fj+kj2Iygws4o5brgoHgiFuY8O/mqj/WUhzjRW
 N+5GAL1GTC05r7R+lH5OdzKe9M1DdCZDsTJ1YR+PjavJlzd5PSXyfuYxx+HX1CoJ47rh
 lpvZnWVpuAxljhgONEA/wjX7LdCWDGCjiYB4t/dCn1Rs3KGqT6XMqLHVMMhBdHep8R7h
 ovFQ==
X-Gm-Message-State: AOJu0Yyiw0Vymnw4lzF8gLTIWV+y33d5Dy1klsNUxLhQ2zTW+bXcVkQh
 ozOARIquujMflb5DwFF3tnGWfAQ1HYyzS8PMKV3gvI3uFxcU7VoN6IJdo4KZQyfVgUY+s6vUUej
 9OMsgyn+FPQn3J/rLqM6HO3l+7sZdcenPl8WB3aQapH9uox++euTOd2AugiZSRUEXHNZofudqAJ
 2Jy7BVneTXsUWMkILixk1VRCX9vNl1AQ==
X-Received: by 2002:a17:906:c10c:b0:a77:c583:4f78 with SMTP id
 a640c23a62f3a-a7daf50bc67mr125783166b.39.1722508551455; 
 Thu, 01 Aug 2024 03:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErFd6dsamrHS13ZBXmsYaXFQ0DqR1nu4qSX+9Sxk8NmCJGQaUtAXo7wsmWvYYeVfKkuxGf+w==
X-Received: by 2002:a17:906:c10c:b0:a77:c583:4f78 with SMTP id
 a640c23a62f3a-a7daf50bc67mr125780166b.39.1722508550616; 
 Thu, 01 Aug 2024 03:35:50 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab4d27csm880999366b.46.2024.08.01.03.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:35:44 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:35:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/19] Revert "virtio-net: Implement SR-IOV VF"
Message-ID: <cc91ac0a7240dea713acc802d0c304163a1c15c6.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This reverts commit c2d6db6a1f39780b24538440091893f9fbe060a7.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-net-pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index dba4987d6e..e03543a70a 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -75,7 +75,6 @@ static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_VIRTIO_NET;
     k->revision = VIRTIO_PCI_ABI_VERSION;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
-    k->sriov_vf_user_creatable = true;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     device_class_set_props(dc, virtio_net_properties);
     vpciklass->realize = virtio_net_pci_realize;
-- 
MST


