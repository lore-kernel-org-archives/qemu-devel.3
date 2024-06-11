Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD34C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 13:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH19F-0004WE-2a; Tue, 11 Jun 2024 09:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sH19D-0004Vy-9o
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 09:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sH19B-0005ye-Eo
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 09:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718110962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BsYAO8t0dWqiWEp7FBYd/Kh0kqbTzrHFt8cO1O8H7Y4=;
 b=a5106DLbv8rUQfL2gkftSt+XDpRjlFfu7UNzpLkhSMvDiS0nxkkLUzgNbSYu2zz+tJJziU
 qid+55admv/+kaUAeijjK06G0hHFp7a7vjOZLztgbxsurydNiFWFUxLJAEb9IekloxXHAp
 GEf5/RuCgLDiaW1I1kJy2RNMOFl9Juc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-pBpMvkslMfyWaPGlOSXzsQ-1; Tue, 11 Jun 2024 09:02:36 -0400
X-MC-Unique: pBpMvkslMfyWaPGlOSXzsQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52c82e67810so2305251e87.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 06:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718110954; x=1718715754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BsYAO8t0dWqiWEp7FBYd/Kh0kqbTzrHFt8cO1O8H7Y4=;
 b=AH1u8fa0hWPsAEAjoA4V03/wsfj+ueLrCZ+ZxS7Ls5SE67uzvx98CAYNkqRFCRkNba
 DAggIzJA9pxwgB5wotnRNRM+RDcVyZF723ZE1Wy32vE9BfTEuC9Vi5yiwosv3u1tJerY
 P3YfK0x7uwLaGVtv4Hl76VcukuBZe9gruKzcL3IOxVTffyD4Gb+ptAL88vYRKXYUTKeK
 8QxmuvHETS3HCVSJMsww6E4/BN+waoZGGI/plAfLHKSQRZ5DSu9nYJZv7gxVCEgym6cB
 LiBaNQwMY40nmQ+f4VwuMUxIgcqAZvrppcOiY7mFlnVj7i5V4ZMdqKXg3fe1p/1pubot
 kbmQ==
X-Gm-Message-State: AOJu0YwOUxuvOgRJ68D9ECbv//jK5oeoge/fq5GgyS+aXGZnIffN0qsp
 BmJjNdC5Yp6KKpps0AimbZ1/9dZ3pH0OekuX66JiK+RF3zlRBRuxTFolv2BWCKKa+meB0ugBwpU
 rejZAU2JWRyyt6Qd6/sxaeKWGVdMG6JKmX0hnwmpj17bl9LXWVkmF3yY36jIhXFbpcTPs7eUynN
 bVLVsOeIk5LizFJHj79Ec7K1OAaOoNpiwCTWc0
X-Received: by 2002:a05:6512:1308:b0:521:cc8a:46dd with SMTP id
 2adb3069b0e04-52bb9f6275fmr11243252e87.11.1718110954660; 
 Tue, 11 Jun 2024 06:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9erVx+pMsLsMerOzQhd1Jcz+pQm6us+WFoiIPAYWSkg+x5Z8un+5bZdhBxMz1gHt66NiFcg==
X-Received: by 2002:a05:6512:1308:b0:521:cc8a:46dd with SMTP id
 2adb3069b0e04-52bb9f6275fmr11243225e87.11.1718110954217; 
 Tue, 11 Jun 2024 06:02:34 -0700 (PDT)
Received: from step1.. ([193.207.216.99]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8058c485sm755980366b.38.2024.06.11.06.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 06:02:33 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2] qapi: clarify that the default is backend dependent
Date: Tue, 11 Jun 2024 15:02:31 +0200
Message-ID: <20240611130231.83152-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

The default value of the @share option of the @MemoryBackendProperties
really depends on the backend type, so let's document the default
values in the same place where we define the option to avoid
dispersing the information.

Cc: David Hildenbrand <david@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- documented @share's default right where it's defined [Markus]

v1: https://patchew.org/QEMU/20240523133302.103858-1-sgarzare@redhat.com/
---
 qapi/qom.json | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 8bd299265e..9b8f6a7ab5 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -600,7 +600,9 @@
 #     preallocation threads (default: none) (since 7.2)
 #
 # @share: if false, the memory is private to QEMU; if true, it is
-#     shared (default: false)
+#     shared (default false for backends memory-backend-file and
+#     memory-backend-ram, true for backends memory-backend-epc and
+#     memory-backend-memfd)
 #
 # @reserve: if true, reserve swap space (or huge pages) if applicable
 #     (default: true) (since 6.1)
@@ -700,8 +702,6 @@
 #
 # Properties for memory-backend-memfd objects.
 #
-# The @share boolean option is true by default with memfd.
-#
 # @hugetlb: if true, the file to be created resides in the hugetlbfs
 #     filesystem (default: false)
 #
@@ -726,8 +726,6 @@
 #
 # Properties for memory-backend-epc objects.
 #
-# The @share boolean option is true by default with epc
-#
 # The @merge boolean option is false by default with epc
 #
 # The @dump boolean option is false by default with epc
-- 
2.45.2


