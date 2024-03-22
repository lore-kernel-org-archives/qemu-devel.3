Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FD8C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjEz-0004Eg-PX; Fri, 22 Mar 2024 14:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjEx-000479-8G
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjEv-0004uk-H5
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711130616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pwqm0yPMCt/Cb45Z2l8g/Yv5VVdENSi1uYZg9eq16Zw=;
 b=SX5sP7z19C35dKYmylpadkSE40e6V6AOarl5yhq6VJQnA43U/XlmD6oNlaj523PsYoZdid
 OEacjWg9R1hJdjJLlNxjF0wjoHkaaLSpVXLWgBvLZLmyi0fnj9OfhBZbx+cPdXD9trdQQn
 dLaOG8x/EqHdi1ls4OOpO2mNC56jYkk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-bMe8G-40PkG7BOiMOCiIvQ-1; Fri, 22 Mar 2024 14:03:34 -0400
X-MC-Unique: bMe8G-40PkG7BOiMOCiIvQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33e7ef510aaso1424824f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711130612; x=1711735412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pwqm0yPMCt/Cb45Z2l8g/Yv5VVdENSi1uYZg9eq16Zw=;
 b=NMk+OYZJcRAqJ4OeFP9Vr4XQ+tXAhmPcxpLN7mTsUQdt7Z+UzDn7u+Hbj4q/W0V0Q5
 98B5ZJEo0xf+zhZMcCKgqRGtT9xCJzWh+S7SJvaM8LeJkPbshzD8kZhl+PeruImzoQZA
 z/vsHraIzmu85aLlpNYE1wXligyf8IULnIOhbKTBnYZqWRu2UfBtzaRZJ5VThkHHKeXv
 R7HwcXgLtDzKJ+fmNxd1DFN36nSE6Y4jfmtbb0B+IRFYLNMI0QIs+0+Ea129TRMTpf1W
 zpubDj0TFYcejbubJTvxP5d1tqjvTZFQXFaNmhTy4KlQ1lNX8R+lffkxQN/wgt5YYMk1
 w9bA==
X-Gm-Message-State: AOJu0YxcqvyOo7DDRhQ57VDgyd7Q3OiNl4pjELGooFYmharsBFPry6I3
 wB24JgazFy5UefnPKWU8Ox4fqk43UaA5lx1De4dd1qp4qIlpZYRUZYu3le0WppjUbGXwNf2ksmE
 LEMg/HyMVdUdijzlewyFcDFIK0TjnZ2hQNxEIvHE/Ujs2PegfZI7D8zSnuuVCld2iY7gYRiPsRw
 fkd7Mn26XVMOGICQAvzibj7CGehh1IWMtVp1Bf
X-Received: by 2002:adf:e045:0:b0:33e:db44:9a5b with SMTP id
 w5-20020adfe045000000b0033edb449a5bmr93864wrh.14.1711130611846; 
 Fri, 22 Mar 2024 11:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3XVrK9cFFB6OZ33hLjSvXt/A0k++QrIvC2hm91vsrksL4Y3fgX7dlTcqWY3ZlnYwbEd2SyQ==
X-Received: by 2002:adf:e045:0:b0:33e:db44:9a5b with SMTP id
 w5-20020adfe045000000b0033edb449a5bmr93837wrh.14.1711130611315; 
 Fri, 22 Mar 2024 11:03:31 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a17090654cb00b00a470ab9a0c5sm71573ejp.25.2024.03.22.11.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:03:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com
Subject: [PATCH] virtio: move logging definitions to hw/virtio/virtio.h
Date: Fri, 22 Mar 2024 19:03:29 +0100
Message-ID: <20240322180329.1227880-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

They are not included in upstream Linux, and therefore should not be
in standard-headers.  Otherwise, the next update to the headers would
eliminate them.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/virtio/virtio.h                  | 7 +++++++
 include/standard-headers/linux/virtio_pci.h | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b3c74a1bca7..2db5eef432a 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -38,6 +38,13 @@
 #define LM_DISABLE      0x00
 #define LM_ENABLE       0x01
 
+#define LM_LOGGING_CTRL                 0
+#define LM_BASE_ADDR_LOW                4
+#define LM_BASE_ADDR_HIGH               8
+#define LM_END_ADDR_LOW                 12
+#define LM_END_ADDR_HIGH                16
+#define LM_VRING_STATE_OFFSET           0x20
+
 struct VirtQueue;
 
 static inline hwaddr vring_align(hwaddr addr,
diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
index 86733278ba3..3e2bc2c97e6 100644
--- a/include/standard-headers/linux/virtio_pci.h
+++ b/include/standard-headers/linux/virtio_pci.h
@@ -221,13 +221,6 @@ struct virtio_pci_cfg_cap {
 #define VIRTIO_PCI_COMMON_ADM_Q_IDX	60
 #define VIRTIO_PCI_COMMON_ADM_Q_NUM	62
 
-#define LM_LOGGING_CTRL                 0
-#define LM_BASE_ADDR_LOW                4
-#define LM_BASE_ADDR_HIGH               8
-#define LM_END_ADDR_LOW                 12
-#define LM_END_ADDR_HIGH                16
-#define LM_VRING_STATE_OFFSET           0x20
-
 #endif /* VIRTIO_PCI_NO_MODERN */
 
 /* Admin command status. */
-- 
2.44.0


