Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE658C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJVeG-0006Q4-0u; Tue, 18 Jun 2024 06:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVeD-0006Ov-7I
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVeB-0000m9-GS
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718704862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZzF4vYQ9JKiaNwEPTfXs/7RsEVvYmnAzAweasViLfU=;
 b=Vt1SSP+k9g5jkUjzvTzeJ+UAJ/LdpjUMV+Rpn0zC9VVV5Smg7RYUXEeYUrCcJccMIkhWz4
 x5k5xaa3Wo8tnQR4RVf2pmUU7lH2oglXMeC20kNkf5ZSAr+maOLmbB8OI/F9yhff0csYCg
 zh5OzSkh6/O0FpXGPC8y3+DD+6mXyLY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-3yaBzg8POmanToADcECiMA-1; Tue, 18 Jun 2024 06:01:00 -0400
X-MC-Unique: 3yaBzg8POmanToADcECiMA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4246e5fd996so6350875e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718704856; x=1719309656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OZzF4vYQ9JKiaNwEPTfXs/7RsEVvYmnAzAweasViLfU=;
 b=eCavaAe7ZB5xaer5hufk37/KVqbgn+8CSrUOMotb2F1wQI94Ckhbx4YFcAnYWV7KH5
 5iJScNif7PXaAfVfltMEOffLqrOwC9TyuEo710tHl2mnLEhLvmeBr/cXbCrG/KCu2BN9
 NJSGh/fN+NkGq8cngFoVKx7oTqWzX26/3qd/Fks3mjCIwISMMKV2MWT+iQX0i9lZAVt4
 d1Jv6GSPKPWohwAVKQ0+jJEDSBW78Nu4FiWPxOKPJGZjScW5lHNPnxRX5PZY0qJn4uIG
 jS8do0JZKo4xwLoX/8CME96me5R1UGusaUKIopzIhUb6hB2io103Ii+rPsTGX7JkgZBj
 nBlA==
X-Gm-Message-State: AOJu0YydCE5jXjxkjx5cFUq64p5mLnNyyAcZDiMaqTFP0TgJzDsXITUE
 I9wflgWiE8XSq2giYqFDYYDZsK+mYlErjRYObXD2aRuMYewqftmpPpYx7dg0Vzw9OeJk98Uu+v/
 bdYhcVrpAcByZ+NC8N8wUMyOHI6BVL4ZoiSISOEA0qROXw+WzJThz09TjEuQCxjcWQmZTdInlNU
 X7/pTDXLO3tv/jCTdSaGSaQ5/y4I5QfjYI3MMh
X-Received: by 2002:adf:fe50:0:b0:360:6fd3:6f07 with SMTP id
 ffacd0b85a97d-3607a7e202cmr8526818f8f.45.1718704856065; 
 Tue, 18 Jun 2024 03:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1lsSX7kKh2TJovAJCG+VHlfHrsAIaxyKZ2c2cTga1XjtS6ZcevWp0ayACAQn4ku/+qrnAjA==
X-Received: by 2002:adf:fe50:0:b0:360:6fd3:6f07 with SMTP id
 ffacd0b85a97d-3607a7e202cmr8526784f8f.45.1718704855658; 
 Tue, 18 Jun 2024 03:00:55 -0700 (PDT)
Received: from step1.redhat.com ([193.207.160.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36094fa7ea8sm5206343f8f.80.2024.06.18.03.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 03:00:53 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: Coiby Xu <Coiby.Xu@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 stefanha@redhat.com, Markus Armbruster <armbru@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Brad Smith <brad@comstyle.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, gmaglione@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v8 01/13] qapi: clarify that the default is backend dependent
Date: Tue, 18 Jun 2024 12:00:31 +0200
Message-ID: <20240618100043.144657-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618100043.144657-1-sgarzare@redhat.com>
References: <20240618100043.144657-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2: https://patchew.org/QEMU/20240611130231.83152-1-sgarzare@redhat.com/
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


