Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DC9C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtT0-0007xG-3D; Fri, 02 May 2025 12:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSn-0007om-DY
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSl-0006VG-I7
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxAXCRgMFBUrR/bs744IU7o+At9NXW4bLRS1vlLvNyo=;
 b=ERICSb7t/7PYLAjIQbHpJ9fApsZX1g3hPG7Z46+iavTBKY6tkdQX1/kU6Z1Y8VKp0zpSMY
 qCcPeTKsbbYQVH+Pcv2/GTEyRoEc7t/Fk1zvtWFQ2FUjjLAqXisdAUJsrnLMpOc2CW8W4Z
 U4b6XhijxtQLt8Jr3tBKpLxFV7ld89c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-fSMIj9wgNV6FIA_shm3yYQ-1; Fri, 02 May 2025 12:42:07 -0400
X-MC-Unique: fSMIj9wgNV6FIA_shm3yYQ-1
X-Mimecast-MFC-AGG-ID: fSMIj9wgNV6FIA_shm3yYQ_1746204127
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c54a6b0c70so211000985a.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204126; x=1746808926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yxAXCRgMFBUrR/bs744IU7o+At9NXW4bLRS1vlLvNyo=;
 b=ZJE2CZPfoyiXB00SxAZiPOCIUk2Kq37ML6Y4rsP5yp2mAaB0HGITBJaPPOgHM22o52
 q6z8oUWhhjegyzbgNahb7kJBoqt27cQoHUYnB6YxY/ejLs4bt2zhLGvv+vRkxpzTF8l1
 7npacnIUYuAVkc6ERQZgpWshVwG0b6HznK1XErBszC5jbzkgunVwgJUDwYH1cByvXUVr
 Gd1+HRKM8i+KBA/qi3INwq8rlGMe0+pDzSfc/dnvhmVskExPbaB+BkSHZAzsaToUbQUh
 +4YBScGIjucW80pYk+SyWwNPzyTBcjEWsVYxgzaeS8NTXubuViCSCUoMn+WdSHUfCbLQ
 h9JQ==
X-Gm-Message-State: AOJu0YzhVYTota7yI6MbBgriGHgxR5MLQqAWboTlqo8QTrxc8UPenHnl
 c4KD6z4zexatAjoZ9VwCdU+iCSE03aySejX+hULesl7yQaEHOd1OKXPrKh89Pl2mNrhR0cZ3a4n
 37Lzih0VabFarmlope9WuHLt1oZgEFvHLU5KhS4KfKXh1bRd7oVtgwPaGRRWCoFdO1d53ns6Y5+
 4e5beqJKHigT0Vzr8IF1vr8RgkbRnUf1mDXQ==
X-Gm-Gg: ASbGncvHQBTSZUp+aYUMPnNwy1JvWarikuutateAj0BjRvpDz3HJJi1DO2Hx+e+YhpR
 Dd4nmcb5juTl0a5xIO09mnz7+xFromvhfxAdmJ8694zHDOcCLw1TLBsLXqeLgfJjE4eGZR4haR3
 izKwU37CsBaQF31ysSMK5u3kLJjeps6S1JC7FWSHf6DZCFoD0XKOjKHucRwoJ/YwxbcOhx0JFsK
 f4ChxsMpSjgi8T79JFi1RbKNlbliYrAS5bOQ5uNGzV2RHZRwzPJb+/A4VibH1b4VgCBPOsHMjlS
X-Received: by 2002:a05:620a:2724:b0:7c7:a604:d432 with SMTP id
 af79cd13be357-7cad5b4cc54mr593144285a.30.1746204126459; 
 Fri, 02 May 2025 09:42:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7wwibhixRfqal2VlS13xB8xJzXoVhjjDXGhxF4DGn/37sb3XmwW07w/mILlQSdjMFyt2Tqw==
X-Received: by 2002:a05:620a:2724:b0:7c7:a604:d432 with SMTP id
 af79cd13be357-7cad5b4cc54mr593139285a.30.1746204126021; 
 Fri, 02 May 2025 09:42:06 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:42:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Thomas Huth <thuth@redhat.com>
Subject: [PULL 14/14] scripts/vmstate-static-checker.py: Allow new name for
 ghes_addr_le field
Date: Fri,  2 May 2025 12:41:41 -0400
Message-ID: <20250502164141.747202-15-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

ghes_addr_le has been renamed to hw_error_le in commit 652f6d86cbb
("acpi/ghes: better name the offset of the hardware error firmware").
Adjust the checker script to allow that changed field name.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20250429152141.294380-3-thuth@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/vmstate-static-checker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
index 9c0e6b81f2..25aca839a0 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -42,6 +42,7 @@ def check_fields_match(name, s_field, d_field):
     # Some fields changed names between qemu versions.  This list
     # is used to allow such changes in each section / description.
     changed_names = {
+        'acpi-ghes': ['ghes_addr_le', 'hw_error_le'],
         'apic': ['timer', 'timer_expiry'],
         'e1000': ['dev', 'parent_obj'],
         'ehci': ['dev', 'pcidev'],
-- 
2.48.1


