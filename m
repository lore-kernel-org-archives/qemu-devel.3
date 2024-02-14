Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8A8C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDE3-0002sY-AP; Wed, 14 Feb 2024 06:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDE1-0002qM-E1
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDz-0006uS-Ua
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XM132RQQIUZpLEj5Uac/xI2M4i5v/RWBhoUWLeS7lSc=;
 b=KEwR46jZosdN4W2qUWK/HVuNssT4VWc4zQuk6EQ6+mCiiybeLy0EbMgXHKWwoJ9UKZpjew
 o/D3l6pAl1yfS7IxJ1lazoa27/VNUZi7uOoHKloRFWxctyfLcY8FppsW8vgDJAuvldfEZP
 qPJuhiOnQpJEvKnMAScQh1bN4jowwa0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-wZ5T-nstNVi4ShS86OcfEA-1; Wed, 14 Feb 2024 06:14:44 -0500
X-MC-Unique: wZ5T-nstNVi4ShS86OcfEA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-55fee28d93dso3093239a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909283; x=1708514083;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XM132RQQIUZpLEj5Uac/xI2M4i5v/RWBhoUWLeS7lSc=;
 b=jSuREEAeEV4WY3Zdm82SoKa3abl0Q+lJEj0yI3kpo7RY+4q3l6ISrnsYM9GoVnMlqw
 6GglZbNVwL/0gpnxEz/AzdqUiFDrGi/ThyLMRZJ7esEzNNz37d0wuhoTFH2xOlOfYaA/
 pSpaH1pQjwQH+TSSbU5SzrBRZ26op/wGfRrOjbovHcysUD0Hbp/QlUkm0DKa683e8c7h
 08ONY1R/b+HFEy7TTNZkwyKaAtyGhxW5BryVTQmVuIg8e1IRRuUpRBszSFjH+m7TUfwd
 sGktIF0MCF5fxQLD5wzCH+6kOILWoNt6DkIF6GAKJAXXMAHCaM26LCEJPOfkRnGSYw4u
 X5YA==
X-Gm-Message-State: AOJu0YzWrR+N1UVqafFxDTERNvBte3PE5L/PCWAp5CeZCzzbwMjDlSKg
 58zqVaIiiGIM7Y9HuxlzoH/xA+GFUTeqajTrtTU14Q2AZNyJfD/bArpRofveSV5vZxauwDlVTiY
 JrJyh05iQ+gjuOH2++uhQyD8ElTx0UDXiQl7ExXf3T9LEkTaZaoOdKF/zP6nsn1mDtTRzv0UDmC
 E0Hime2HP374wGnMqhtnn5NHnnNWG2YA==
X-Received: by 2002:a05:6402:8c2:b0:560:5c58:dfc4 with SMTP id
 d2-20020a05640208c200b005605c58dfc4mr1841048edz.1.1707909283265; 
 Wed, 14 Feb 2024 03:14:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGa1Q7mLxSy9uqtgQwswxcRerHydiHG9HnmpCMP0DQJqn13jEByxEVRfTeRv+Qd5XvJyydm+Q==
X-Received: by 2002:a05:6402:8c2:b0:560:5c58:dfc4 with SMTP id
 d2-20020a05640208c200b005605c58dfc4mr1841029edz.1.1707909282958; 
 Wed, 14 Feb 2024 03:14:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVCRUdDL7iWpdLfAd55S/UEUgY4N0w2WkNRxMRJwHwPZCXFGU/NXCO/fuwWWZzg7ZSMf++BcBkUi46Wr22xUOoTeosRO7hWW/CjEowTECN9/KJPllD08r/YHHPCk7MSAUu81tI85W1eECCdxLLS6em4bmoIboobhf/M+ElqiZQvrFlqVVeu4HTxm7ExJbjc
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 l20-20020aa7cad4000000b005638a4f935dsm183952edt.4.2024.02.14.03.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:42 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/60] exec/ioport: Add portio_list_set_enabled()
Message-ID: <f165cdf102bb93c255c63b77617ba371d73344e0.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

From: Bernhard Beschow <shentey@gmail.com>

Some SuperI/O devices such as the VIA south bridges or the PC87312 controller
allow to enable or disable their SuperI/O functions. Add a convenience function
for implementing this in the VIA south bridges.

The naming of the functions is inspired by its memory_region_set_enabled()
pendant.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240114123911.4877-7-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/ioport.h         | 1 +
 system/ioport.c               | 9 +++++++++
 docs/devel/migration/main.rst | 1 +
 3 files changed, 11 insertions(+)

diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index 96858e5ac3..4397f12f93 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -71,6 +71,7 @@ void portio_list_add(PortioList *piolist,
                      struct MemoryRegion *address_space,
                      uint32_t addr);
 void portio_list_del(PortioList *piolist);
+void portio_list_set_enabled(PortioList *piolist, bool enabled);
 void portio_list_set_address(PortioList *piolist, uint32_t addr);
 
 #endif /* IOPORT_H */
diff --git a/system/ioport.c b/system/ioport.c
index 000e0ee1af..fd551d0375 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -324,6 +324,15 @@ void portio_list_del(PortioList *piolist)
     }
 }
 
+void portio_list_set_enabled(PortioList *piolist, bool enabled)
+{
+    unsigned i;
+
+    for (i = 0; i < piolist->nr; ++i) {
+        memory_region_set_enabled(piolist->regions[i], enabled);
+    }
+}
+
 void portio_list_set_address(PortioList *piolist, uint32_t addr)
 {
     MemoryRegionPortioList *mrpio;
diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 9439adcf66..331252a92c 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -444,6 +444,7 @@ Examples of such API functions are:
   - memory_region_set_address()
   - memory_region_set_alias_offset()
   - portio_list_set_address()
+  - portio_list_set_enabled()
 
 Iterative device migration
 --------------------------
-- 
MST


