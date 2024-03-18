Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE73C54E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFfa-0000sp-FG; Mon, 18 Mar 2024 12:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfU-0000IG-2o
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfF-0004lI-Nh
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yZWruUO8dFIZZVtmp1f4qBT11vEoiubRwmFIaapjlUQ=;
 b=XrkIIXGIb8qds5B4eY4ptU1HtID0iKvYZ3sUv3d/HJHnHBqSqa4vHfYxAPwmlRsEyTTLnO
 e9G0VXBbMAOct9ffuKIw0227P5Xjb2hGlx9aBnURatunmyQ5nwhL0ebIHOkofr2RIVcnhk
 CzYcwMSdiuHj+DODQD6V5qyNt3gGJLM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Sv6FKCiAM5q8QsAj1TghUw-1; Mon, 18 Mar 2024 12:16:37 -0400
X-MC-Unique: Sv6FKCiAM5q8QsAj1TghUw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4140e6bbc87so6434255e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778595; x=1711383395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZWruUO8dFIZZVtmp1f4qBT11vEoiubRwmFIaapjlUQ=;
 b=hoq+LRtVEeQT4EmBBbobdbm5HijNWXlh90ojpTmMg1a4wRQV+6MLUvZYmPzugi5zUc
 UawdqC0mqWmfxe/UKWaCYtoGPXPnHdk3NYipMyFV1/tkY/5GFkXetUaY4xfLhxI1MYZB
 YOETV6xzTydE/zm3LAKdwu5azIOuYu6HI5sMI6WPMuHWA22myrEUxi/jzZFAA+0A64rz
 J+soAeKIornasxhYj6BIDuh+vhOJFne17UTRbNro4bg9gbsAXg2L4qnkrolCHvEcHDkq
 1ev3LNu0UsOrqWalsK9e+VlqoWDPI5EDiRWJHBhL0TR1d1nbEkVbl4Qp4xhoCPLyH2no
 wAcw==
X-Gm-Message-State: AOJu0Yz9DUIjnL9EOes+wtKKGjUrSaK8Osx2rTL7XUkqUbzz9mzbbILa
 eWuW00MNHRZbmTqyS5FHFKextZF/psjFPkLftEB1h7ENWJHL50Iqzf5EMKCDcick1ChuFtR/1MH
 OurwzZlisfzVokEHG/06OC4KcatQ9iSKR04DqTaLSl0P48Mdz0UjRMHrEcwWepbDODOJhv4DVmG
 CwgSjllPOK5H77RCyIxxuJA1uIPALWXA==
X-Received: by 2002:a05:600c:4686:b0:414:c5:8503 with SMTP id
 p6-20020a05600c468600b0041400c58503mr7514997wmo.38.1710778595538; 
 Mon, 18 Mar 2024 09:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1mjFKLM9C6mWEK/TfGwcNV8csr5z5QmQ7yGuXKF2/URoCEXjkN/r64bXmyxuf3aNtm8JMCA==
X-Received: by 2002:a05:600c:4686:b0:414:c5:8503 with SMTP id
 p6-20020a05600c468600b0041400c58503mr7514977wmo.38.1710778595036; 
 Mon, 18 Mar 2024 09:16:35 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 q11-20020a05600c46cb00b0041312d21a35sm18649855wmo.7.2024.03.18.09.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:16:34 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:16:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 17/24] smbios: clear smbios_type4_count before building tables
Message-ID: <6735a4943e024715cf256625f02231e88f76c40b.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Igor Mammedov <imammedo@redhat.com>

it will help to keep type 4 tables accounting correct in case
SMBIOS tables are built multiple times.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240314152302.2324164-15-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 0ab77b5ec8..48713aa505 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1096,6 +1096,7 @@ void smbios_get_tables(MachineState *ms,
            ep_type == SMBIOS_ENTRY_POINT_TYPE_64);
 
     g_free(smbios_tables);
+    smbios_type4_count = 0;
     smbios_tables = g_memdup2(usr_blobs, usr_blobs_len);
     smbios_tables_len = usr_blobs_len;
     smbios_table_max = usr_table_max;
-- 
MST


