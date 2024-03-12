Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987F4C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZf-0004Ym-Sc; Tue, 12 Mar 2024 18:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZd-0004Xx-O8
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZc-0004Fk-1y
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MLCjiyp8QnFBUxFc7qME1kR1X9QPWEmOeOJtA7Cligg=;
 b=W/kTga2ZBmVo5z7uF2aHrh14minwS0QojcU3+SP9JBOqUkgxA8S/5HQkVn2WmPoVOAp/0n
 iMks6wW4jA5bvU48G6TuHQMV6H8o6wvAsoto4BcyY9831+UTwr9mPK2c1edHo47W+erzT/
 rSRMVDvfoehrX7We0wC9Rst4FrPmVOk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-xhJqIxGEPBuOO7jszLO39g-1; Tue, 12 Mar 2024 18:26:13 -0400
X-MC-Unique: xhJqIxGEPBuOO7jszLO39g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a448cfe2266so493964066b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282372; x=1710887172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLCjiyp8QnFBUxFc7qME1kR1X9QPWEmOeOJtA7Cligg=;
 b=gFrl9nsefcsYrp5/g10Wp56JoiOHX/TkadDZDqumprHqBM7bPbCt8wsZX5kpFVcCYC
 CLWSLC6nCFRAwNpqjs3JjY962NbhJrf7vWCNYD0KW41iEIDZL9qk7y+cLADiWkgqTU0t
 X3aVRz6EcniMi9nPGVrF3uAmyzwViSgAlee9JO8RBIlIb//hZF6TMaXkg4D7jdsBowo2
 mPHzavE8bDRlHldPhtyci3fLlLs4t1QurpRApQPUMQamndeHQGEpXU7CJHvZe5utufo9
 etQsDu8rO7uGreCGnZKPXoePlTR/mAC9bP1cSCSv3hkedQnMNke2sw+wqG8F8RfPPhAI
 Xk/g==
X-Gm-Message-State: AOJu0YzQmA0yiJ1xFaFNoyew/LhBOGWGPjFkHkMJ5XPHurS5XSQJuuS8
 K1qeHTdqGMkwrD0cv+4KN+WJMLruceyOWhx+YKwVYf+biHUP/n+fS5/d6IZ7BTVHeDA6y6w9pHh
 pTeudu9niQfvcVPZ7aeb3a1FkiJiHuHGkkvxjY9zzCwh6i7vLFKWhv1c4AbbrSMPLpECe8JW6G6
 JYhv2QSD4Bj4cCWjmW/Nuwf0f0eXiyteUP
X-Received: by 2002:a17:907:1004:b0:a44:1e32:a503 with SMTP id
 ox4-20020a170907100400b00a441e32a503mr7150146ejb.22.1710282371786; 
 Tue, 12 Mar 2024 15:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES1LxCqbH1uEMSvTyEC79+6VedJiYlHK04C0if/XXiZLQnAeB/scJCjQwYTr0SnPXLLP1A3g==
X-Received: by 2002:a17:907:1004:b0:a44:1e32:a503 with SMTP id
 ox4-20020a170907100400b00a441e32a503mr7150131ejb.22.1710282371182; 
 Tue, 12 Mar 2024 15:26:11 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 lg12-20020a170906f88c00b00a4432543b21sm4217408ejb.198.2024.03.12.15.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:10 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 13/68] libvhost-user: Bump up VHOST_USER_MAX_RAM_SLOTS to 509
Message-ID: <0fa6344c90a093e2421ecac3c96a8823ad74ee89.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: David Hildenbrand <david@redhat.com>

Let's support up to 509 mem slots, just like vhost in the kernel usually
does and the rust vhost-user implementation recently [1] started doing.
This is required to properly support memory hotplug, either using
multiple DIMMs (ACPI supports up to 256) or using virtio-mem.

The 509 used to be the KVM limit, it supported 512, but 3 were
used for internal purposes. Currently, KVM supports more than 512, but
it usually doesn't make use of more than ~260 (i.e., 256 DIMMs + boot
memory), except when other memory devices like PCI devices with BARs are
used. So, 509 seems to work well for vhost in the kernel.

Details can be found in the QEMU change that made virtio-mem consume
up to 256 mem slots across all virtio-mem devices. [2]

509 mem slots implies 509 VMAs/mappings in the worst case (even though,
in practice with virtio-mem we won't be seeing more than ~260 in most
setups).

With max_map_count under Linux defaulting to 64k, 509 mem slots
still correspond to less than 1% of the maximum number of mappings.
There are plenty left for the application to consume.

[1] https://github.com/rust-vmm/vhost/pull/224
[2] https://lore.kernel.org/all/20230926185738.277351-1-david@redhat.com/

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-3-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index c882b4e3a2..deb40e77b3 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -31,10 +31,12 @@
 #define VHOST_MEMORY_BASELINE_NREGIONS 8
 
 /*
- * Set a reasonable maximum number of ram slots, which will be supported by
- * any architecture.
+ * vhost in the kernel usually supports 509 mem slots. 509 used to be the
+ * KVM limit, it supported 512, but 3 were used for internal purposes. This
+ * limit is sufficient to support many DIMMs and virtio-mem in
+ * "dynamic-memslots" mode.
  */
-#define VHOST_USER_MAX_RAM_SLOTS 32
+#define VHOST_USER_MAX_RAM_SLOTS 509
 
 #define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
 
-- 
MST


