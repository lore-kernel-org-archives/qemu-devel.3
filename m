Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031C2CDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 18:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqzTM-0002Oc-HC; Wed, 18 Sep 2024 14:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzTI-00028H-IO
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzTD-00020l-0g
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726684326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4/INXL/PVn5TMqQnxTEKZfK/Si8TZmajwPGuc+4jWg=;
 b=bVMiBzcD4OyKsBt0cI+tA6Ukod3PCgYpIEeZSHldKLmMh3J3WLfGWI7PYFGssSBt6CMe9q
 nU7O9AQUtx1DQd7vQrJ09TIYzJeAmCExo7oUbNgWmVfPg2TR2C/58gogejuD67Y8FjBu/A
 TDrfNHjonY7I77n/68Ei00KygASkGi0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-DGZnF_SaO0KQLDE2M0TILg-1; Wed, 18 Sep 2024 14:32:05 -0400
X-MC-Unique: DGZnF_SaO0KQLDE2M0TILg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4581d371964so559691cf.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 11:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726684324; x=1727289124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w4/INXL/PVn5TMqQnxTEKZfK/Si8TZmajwPGuc+4jWg=;
 b=Eu0l2u5q4pm9xH5SSKVWs6nEGZoWY4VSjZ81+lpBuRScROQwoMqA5+CdH/KuAnQMb4
 B6YvBkQQzQ3QCm79aN+srjPF2DNTl4QwJSP1hm9A70aJojtq/RuSkyzJf+VNkZEC1gPp
 3xgaxHGBcxJ/ywlaLegycxBIom6jf3u4UaY/o5jXvk0wcp/4P8jvHVPDUj0i+CSxbu9E
 LSqmVhezRT6RcXedVCkJu2X1x9sSBk4aWw4vWqnSLp7VHH9OtR1LGKHIWPjVI/oBD71C
 V0eGDBdNqPA0mYK2wO7VkluAS7ceLgXbYAz47hiGFNa79WcHJ2HRGYjluwHm2GtnRc8j
 ThkQ==
X-Gm-Message-State: AOJu0YxN6r5MWPlh8b/ycIlpI+pK5e9BTCmA3vxiaZeeLruCgXxqymAQ
 JXIih2yG1+FDcIZydKCx9IOj3HWyDo6QVmcIOG/BeT4I2ffVogKjX0UJ2Rf8JR2CKyXwKQvYhHR
 M7JtxAaXEtWpCbeE0UiHtT1i27jrMoJc7qsr+SrvHEZYxe5AFhRGze7hjU7ybPYl3DzASyG/hy2
 8Yp9ydaUR7YdC5uYuFyUOd8yTVqJInUZ0dyw==
X-Received: by 2002:a05:6214:448b:b0:6c5:681e:1d4 with SMTP id
 6a1803df08f44-6c5736cbbb9mr439299036d6.34.1726684324006; 
 Wed, 18 Sep 2024 11:32:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJi16r2N/lzXN4dbpFGtJgjveCfMxRgrJhniOuy7eKhoXuY2yCxnp6Stvu3hu462F+ia/VSw==
X-Received: by 2002:a05:6214:448b:b0:6c5:681e:1d4 with SMTP id
 6a1803df08f44-6c5736cbbb9mr439298636d6.34.1726684323504; 
 Wed, 18 Sep 2024 11:32:03 -0700 (PDT)
Received: from x1n.. (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e494a28sm30486d6.68.2024.09.18.11.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 11:32:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PULL v2 5/6] migration/savevm: Remove extra load cleanup calls
Date: Wed, 18 Sep 2024 14:31:50 -0400
Message-ID: <20240918183151.6413-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240918183151.6413-1-peterx@redhat.com>
References: <20240918183151.6413-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

There are two qemu_loadvm_state_cleanup() calls that were introduced
when qemu_loadvm_state_setup() was still called before loading the
configuration section, so there was state to be cleaned up if the
header checks failed.

However, commit 9e14b84908 ("migration/savevm: load_header before
load_setup") has moved that configuration section part to
qemu_loadvm_state_header() which now happens before
qemu_loadvm_state_setup().

Remove the cleanup calls that are now misplaced.

Note that we didn't use Fixes because it's benign to cleanup() even if
setup() is not invoked.  So this patch is not needed for stable, as it
falls into cleanup category.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240917185802.15619-2-farosas@suse.de
[peterx: added last paragraph of commit message]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d500eae979..d0759694fd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2732,13 +2732,11 @@ static int qemu_loadvm_state_header(QEMUFile *f)
     if (migrate_get_current()->send_configuration) {
         if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
             error_report("Configuration section missing");
-            qemu_loadvm_state_cleanup();
             return -EINVAL;
         }
         ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
 
         if (ret) {
-            qemu_loadvm_state_cleanup();
             return ret;
         }
     }
-- 
2.45.0


