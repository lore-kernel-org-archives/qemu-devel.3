Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1071CD128A
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 18:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtXUt-0000Rx-9x; Sun, 07 Apr 2024 14:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtXUr-0000Pi-54
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 14:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtXUp-0003CT-Gx
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 14:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712515441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+GrYMGc7oT31T0/K+HtV5P5eFsEKl1OiL5niKLrpiMw=;
 b=Ox3WuEAcmrQ4XNSox4oHNcwhCun/zWGB04pQZ8aFgtd/Xh2/sdvNIdoDbYOMawHNZzxZzS
 JXh0uR/uN9sv4eTgnuPhKXZDRv0J0jeHbbyGhAcy2BOXtEQBP+4Sou50weMw+Fnc2g5oc2
 j99oCZUqSA6fSg9QWt2yvL8nDWu3sPk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-TLmtgyLAMWqkzZKW9D3ltg-1; Sun, 07 Apr 2024 14:43:59 -0400
X-MC-Unique: TLmtgyLAMWqkzZKW9D3ltg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-69b147e856aso2222676d6.1
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 11:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712515439; x=1713120239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GrYMGc7oT31T0/K+HtV5P5eFsEKl1OiL5niKLrpiMw=;
 b=SMV/OHoYlHUo3CSEI1MZrJALau364CNmqqGctkuvvBYqcLeyimlC8LnMOvpAXqwVCz
 Spy5FpmIYOgvbU7Z3KM38saz73aDLYUTyawNgxPAtqojByut+J4L6RD1z7YZeNT5gopm
 hv4alekkp6ztOxMVgv6TUSZZ1wDJF9YRz+5BR4LOT93nF3HYDSAtbrW4KvE7IZ5pt9Bz
 5xQFECnAJqjJOuDAKoG5QRdcEGaXZ7M1TP2mOo9JLeAOCDI++udPOlpbwqSglxc5n052
 /7p2kplFCB8+RNQTU5c14nrvEbKWMejsf+heJ/rXzyKlaNFAiC+uv2qXPAqd7xfun4XL
 qrJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMMEeghF9qgOxeTBV8ExBiyPxjta83rRUuUxOCcBfVsLkD3t23guBzDGJE79gFb7vkQpoYheGIBn1xZfJN8tOSezJXTFc=
X-Gm-Message-State: AOJu0YyQx05O61/s6GkFkdDokIKU2bTC81mANqTwlyggb1Vxfa3Th/5d
 feIvRVvF2uqzypsgef7fuEgqC2a9rWI+rcmX3O6nzWC4c/exDxzopCqziax04xaKFMsFuA3aaA9
 pgYa0DXONi5ijr3GAwMIBOTCJmlmN765SS5kErAy95iveV6v8u4xx
X-Received: by 2002:a05:6214:5087:b0:696:b235:f39 with SMTP id
 kk7-20020a056214508700b00696b2350f39mr7709734qvb.6.1712515439202; 
 Sun, 07 Apr 2024 11:43:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbI1jhuXXu6gJ7iCm75qGLDtd/7VBI4PW7U9zhz+kDnaGz4zGciK/o5Zt04rP4skofoWcKjQ==
X-Received: by 2002:a05:6214:5087:b0:696:b235:f39 with SMTP id
 kk7-20020a056214508700b00696b2350f39mr7709722qvb.6.1712515438541; 
 Sun, 07 Apr 2024 11:43:58 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
 by smtp.gmail.com with ESMTPSA id
 cw12-20020ad44dcc000000b0069905863252sm2416842qvb.84.2024.04.07.11.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Apr 2024 11:43:58 -0700 (PDT)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>, Lei Wang <lei4.wang@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>
Subject: [PULL 2/2] MAINTAINERS: Adjust migration documentation files
Date: Sun,  7 Apr 2024 14:43:54 -0400
Message-ID: <20240407184354.1839435-3-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240407184354.1839435-1-peterx@redhat.com>
References: <20240407184354.1839435-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Avihai Horon <avihaih@nvidia.com>

Commit 8cb2f8b172e7 ("docs/migration: Create migration/ directory")
changed migration documentation file structure but forgot to update the
entries in the MAINTAINERS file.

Commit 4c6f8a79ae53 ("docs/migration: Split 'dirty limit'") extracted
dirty limit documentation to a new file without updating dirty limit
section in MAINTAINERS file.

Fix the above.

Fixes: 8cb2f8b172e7 ("docs/migration: Create migration/ directory")
Fixes: 4c6f8a79ae53 ("docs/migration: Split 'dirty limit'")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/r/20240407081125.13951-1-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e71183eef9..d3fc2a06e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2170,7 +2170,7 @@ S: Supported
 F: hw/vfio/*
 F: include/hw/vfio/
 F: docs/igd-assign.txt
-F: docs/devel/vfio-migration.rst
+F: docs/devel/migration/vfio.rst
 
 vfio-ccw
 M: Eric Farman <farman@linux.ibm.com>
@@ -2231,6 +2231,7 @@ F: qapi/virtio.json
 F: net/vhost-user.c
 F: include/hw/virtio/
 F: docs/devel/virtio*
+F: docs/devel/migration/virtio.rst
 
 virtio-balloon
 M: Michael S. Tsirkin <mst@redhat.com>
@@ -3422,7 +3423,7 @@ F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/vmstate-static-checker-data/
 F: tests/qtest/migration-test.c
-F: docs/devel/migration.rst
+F: docs/devel/migration/
 F: qapi/migration.json
 F: tests/migration/
 F: util/userfaultfd.c
@@ -3442,6 +3443,7 @@ F: include/sysemu/dirtylimit.h
 F: migration/dirtyrate.c
 F: migration/dirtyrate.h
 F: include/sysemu/dirtyrate.h
+F: docs/devel/migration/dirty-limit.rst
 
 Detached LUKS header
 M: Hyman Huang <yong.huang@smartx.com>
-- 
2.44.0


