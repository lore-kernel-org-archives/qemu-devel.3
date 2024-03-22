Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28994C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjN4-0006Iq-Cv; Fri, 22 Mar 2024 14:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjN2-0006IC-TG
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjN1-00070r-FR
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9UbgN6L5wwHBr2/dEFTK02U3qWZ6pGNJNZEj7uTD6i0=;
 b=FFqqARWxIWXPlrKuBaDhEif/+s0irCbpS70MxEYHj/nPrnJvS/bKRe7Y8wU4OTkaDm3QTX
 flSFyiRUgqt0QZm74BkNIJjg+BOHoqgiocoquFOzb2ck4xd8BZuPFMIIkImFEZrD3nUE8i
 8M0qQsINBeTsEyMFeABVfKZZr6bO/WA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-QJmSKQ2gPIGHIMvzTguNLA-1; Fri, 22 Mar 2024 14:11:55 -0400
X-MC-Unique: QJmSKQ2gPIGHIMvzTguNLA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-558aafe9bf2so1970146a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131111; x=1711735911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9UbgN6L5wwHBr2/dEFTK02U3qWZ6pGNJNZEj7uTD6i0=;
 b=gQAzFb+vpm7TbvpsUdDZ3tx3yHy7f0kNiYm9jHro9F0zC3tMb3GPcfrEeSiZ8kGdgw
 su/mBnTbZ2lqDRZWttit1fqgoo00g10u8awQeT+PNgDW4bsJZp22KRUThoOfx4cCN+U2
 2tc9+Fa8/HChXbZ4hlcVTOxcHGEt74iRj8msyFX3QATZdDTSsVIy7ovMcdt1rtTX6vNO
 NO4qx8PJVqw6NVZ74HfUxxAhkL5qFkI2gbJadVrIkX7539xMF4t7r07TsQlHDgW1Og4i
 PUfjaIZjPPSUXPpkTKqHAXMs4WCWvaNpinDmoD7wn4ABDO8hpMs4btFohX9PlKd4qmL1
 tPwQ==
X-Gm-Message-State: AOJu0YxKsvoOk8kKWLT7v2jR1oaxSGhSlvs9IfHdjlmGImx0HupQSE3C
 NnWP+DemUx/XZs51TKNicry+kjO1qhx8y9kH5eIGmF9wzpVrVXWEuAeMd3KC7UdSHDo1ryFPxrF
 gZ6IkSarphBZMFm/ipgfF3ChzldyZc7VtcXY8byTsUNs9xWIQ14wNkesla1UXHMad3ne5eQMdF8
 rGVV8MhPKBZFSme51Cure7RZI8WfmJhLmkASPx
X-Received: by 2002:a50:9e45:0:b0:568:145a:4a19 with SMTP id
 z63-20020a509e45000000b00568145a4a19mr198268ede.4.1711131111404; 
 Fri, 22 Mar 2024 11:11:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3Ex6mGzd3lN6OgvfZj+75F8N+ee2vQZGBNPCaTnQxJzKUrFeu8JolWZO5nC6UuWwKroZoRg==
X-Received: by 2002:a50:9e45:0:b0:568:145a:4a19 with SMTP id
 z63-20020a509e45000000b00568145a4a19mr198250ede.4.1711131111061; 
 Fri, 22 Mar 2024 11:11:51 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 e25-20020a50fb99000000b0056be8a21ec4sm74579edq.32.2024.03.22.11.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:11:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 10/26] [TO SQUASH] hw/i386: Remove redeclaration of struct
 setup_data
Date: Fri, 22 Mar 2024 19:11:00 +0100
Message-ID: <20240322181116.1228416-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Michael Roth <michael.roth@amd.com>

It is now provided by kernel headers.

This needs to be squashed with the header update to avoid temporary
build bisect breakage. Keeping it separate for reference.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Message-ID: <20240320083945.991426-6-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/x86.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index ffbda48917f..84a48019770 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -679,14 +679,6 @@ DeviceState *ioapic_init_secondary(GSIState *gsi_state)
     return dev;
 }
 
-struct setup_data {
-    uint64_t next;
-    uint32_t type;
-    uint32_t len;
-    uint8_t data[];
-} __attribute__((packed));
-
-
 /*
  * The entry point into the kernel for PVH boot is different from
  * the native entry point.  The PVH entry is defined by the x86/HVM
-- 
2.44.0


