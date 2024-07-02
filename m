Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8071AC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwo-0002yj-1C; Tue, 02 Jul 2024 16:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwh-0002MF-VW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwe-0008V2-4e
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4UiaVaJHqFRMzcgj8Lsoa2O3CKB9KU5Hs0p0vn09PA=;
 b=AHc3RaG9XmWjOU54+r2CQCaVCeSuBUt78fNGRb9eroGF5d8I0/qKmne6keKqHTXm5lwC41
 +Ty4qZ2C3PGNsTDS91obR2nI4nmQtlOi/BhzVluQZBKoLPCEPTm5AHNULeomh8IQxImNGz
 DF6Outso0QqarmeHwXqNddZ/XaOjUMc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-6Zu5CjTHNgKW1wunOb3oNg-1; Tue, 02 Jul 2024 16:17:42 -0400
X-MC-Unique: 6Zu5CjTHNgKW1wunOb3oNg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-363542774e1so4860168f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951460; x=1720556260;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g4UiaVaJHqFRMzcgj8Lsoa2O3CKB9KU5Hs0p0vn09PA=;
 b=j1QbckjddPYxP+X86sjPISyHNQWAO5mTN4hucWsUKV603oR4gu4rnyzovNyVsDx7Gi
 mlUtLln3zE7sy5EsQjr/rBUTTQ2I+zziXolR5GD3NFPjPavVnC2BdSHRP1pu3DRcyGEW
 2Sy2kId5/9RzHEos5EKCxnzmY8gz+k0zgNzgNRGxQYw2eZ7ASEj+4eQz7SU1B2lZLtR8
 VSLZuD+vwq2sGV5zo6StPAI5Ec6T4iVuDj/mAeqNwXAP3d1tis2kWHajeXUcTz19M+Q7
 Y9knHwvypdtcykXio6R9rE1BrOxW3vioDe3aWW4lZ+iM3+HYTCMn/OcJHz7+2jSYsQu8
 ojBQ==
X-Gm-Message-State: AOJu0YyAy9lZfpkj4heLCizx9cUp8dQQta0kxDsMomKfREcvQ9XgJo/7
 PG6QOOPZBO2IWc4rP+wXuTwHg+py2o+cx2s4mAZ2Xo0/qK8Dc8bp9g4gly0dZXccNBU9IgCVxVd
 Q34qJE6CqBhmXWQMuUgbxJH4saDYHpekORpcBpQL0co+FGErYFa3Er2vQ15H75+ECoJtunTe17Y
 Mv77Pho15B1NYtAKAzmQnOU0KcDQA/pg==
X-Received: by 2002:a05:6000:1f88:b0:366:f2c2:61f3 with SMTP id
 ffacd0b85a97d-3677572492dmr9653100f8f.51.1719951460450; 
 Tue, 02 Jul 2024 13:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH+TGxMh99Mc5Ft2lSoxDo4TyJtXrv56JEw1a6jDH3BelwvfUpvmqQXu/kEzPveujoF1PfyQ==
X-Received: by 2002:a05:6000:1f88:b0:366:f2c2:61f3 with SMTP id
 ffacd0b85a97d-3677572492dmr9653076f8f.51.1719951459963; 
 Tue, 02 Jul 2024 13:17:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678a23b349sm2303124f8f.36.2024.07.02.13.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:17:39 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:17:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 36/88] Revert "docs/specs/pvpanic: mark shutdown event as
 not implemented"
Message-ID: <0c0cc13d319cf7b876f327fa1c5cc1866ad868cc.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Weißschuh <thomas@t-8ch.de>

The missing functionality has been implemented now.

This reverts commit e739d1935c461d0668057e9dbba9d06f728d29ec.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240527-pvpanic-shutdown-v8-8-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/pvpanic.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/specs/pvpanic.rst b/docs/specs/pvpanic.rst
index b0f27860ec..61a80480ed 100644
--- a/docs/specs/pvpanic.rst
+++ b/docs/specs/pvpanic.rst
@@ -29,7 +29,7 @@ bit 1
   a guest panic has happened and will be handled by the guest;
   the host should record it or report it, but should not affect
   the execution of the guest.
-bit 2 (to be implemented)
+bit 2
   a regular guest shutdown has happened and should be processed by the host
 
 PCI Interface
-- 
MST


