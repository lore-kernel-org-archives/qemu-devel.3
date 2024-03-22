Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC8DCD11BF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjN2-0006I2-P8; Fri, 22 Mar 2024 14:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMw-0006HH-2y
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMu-0006zs-FQ
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oyq/pYGuo/iu0l7uKUoPfrHl8ZU1WATY9EZskgY+m8=;
 b=NyRvV7BfC8Rj/z8IJaTfkf8GyUq5W4i4e1td3bWQbdj8HK6DxAeshBCDLowfTIDDv1K52l
 Fr2pqf2D4CU35aPhE8iWZeg3/SXZ52yhHk8yiNoocViwN9DDfDXkGIRyfpVtTzs2gwVrqZ
 7oBD+1DMO2VhViPwcQeovc1kTdpKtZ8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-L1psxzkIMfuCLIpMLVKpQg-1; Fri, 22 Mar 2024 14:11:49 -0400
X-MC-Unique: L1psxzkIMfuCLIpMLVKpQg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a4732ace81eso54945866b.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131106; x=1711735906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/oyq/pYGuo/iu0l7uKUoPfrHl8ZU1WATY9EZskgY+m8=;
 b=Ie//VnoyRTbga6uaguoqwqE4/mWOBMfDKcSYzIz/PwNJdDvH8hNGcQaMkdOPHdLusc
 4qjI24O1Prb253oTBE+f3hgbe9r3P3zzbYjZU1PFDI1jaFVE6bATaLq1/zqDof5N9iGu
 k/0WOx0nmoIHXrgrzjxzFYAl6A6YzuB/pVWP4M0Ff0AvYEuvXnilbmlDULtu0B+nGoY9
 hLiqWxJLfMVCqgA9z0ZhBtaT0RQVpZklKe6WzAacCANtF0PMmvaE9SIpgZHAy3zDZnbz
 WnOE66fBXjWZqIuAS5AXtpA8ztnmO2ZmS2ya4dE5aL5XK+94kgBQYnVgWRgzvQ+vuelX
 uwxA==
X-Gm-Message-State: AOJu0YypnR577A6hXkokgv1CyjgRhwSEVKQvP92pxT7JUoSNB/dmXgNN
 COjhos8kEXYmOUFOy48KEaa8FH15/m+v+oq7tAQkgTJHTx9FcZ2O5D+fkvQajbK/Rt4L6d2lzFg
 0+wqNlRPIF7YHi9ytvMGkvCrYZquFlV75JZ8JapVBLrKxIaxM18Bc1UtBL7rOui2eLXs96DslhH
 RU1gu0V7fnjTn63LU5A/HtCAGrUYeu2H/atYXo
X-Received: by 2002:a17:906:6958:b0:a46:30f4:6321 with SMTP id
 c24-20020a170906695800b00a4630f46321mr418889ejs.58.1711131106276; 
 Fri, 22 Mar 2024 11:11:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkmBUloOLbYrHyxnr3q+kfWGpqGz1abuCf4iKRSQ5eDjnywqyV4scKqipYSyEBSW6t+1mbHA==
X-Received: by 2002:a17:906:6958:b0:a46:30f4:6321 with SMTP id
 c24-20020a170906695800b00a4630f46321mr418868ejs.58.1711131105956; 
 Fri, 22 Mar 2024 11:11:45 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a17090679d500b00a4739efd7cesm77375ejo.60.2024.03.22.11.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:11:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 08/26] scripts/update-linux-headers: Add bits.h to file imports
Date: Fri, 22 Mar 2024 19:10:58 +0100
Message-ID: <20240322181116.1228416-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
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

From: Michael Roth <michael.roth@amd.com>

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index d48856f9e24..5f20434d5c5 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -169,7 +169,7 @@ rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
 for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost.h \
               psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h \
-              vduse.h iommufd.h; do
+              vduse.h iommufd.h bits.h; do
     cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
 done
 
-- 
2.44.0


