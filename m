Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE97DC44501
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwv-0006ZB-Ed; Sun, 05 Jul 2026 10:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwt-0006Lv-C7
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwr-0001Sq-SZ
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DNcvRMiitysJcmRtUZXzlgXLa0I8VMObuPV+Psg+jNU=;
 b=g1rvJX59jBKNGUMxlYXmdrQZez5VGFcmCKeXRoMk335MNi4dj50wxWaucTeUcGu7hpaKkN
 nl9PRNvrrigoHbpqmtAGwehplb3xqlEph8/283OvyHBBSQqT47O9nwkiUhH1EM6T6fiNq0
 qDhsSZIPB5Lki5pnmAia9qkZ8HME+gw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-7L_ugxnHO8mFZwIiZJY_0Q-1; Sun, 05 Jul 2026 10:35:56 -0400
X-MC-Unique: 7L_ugxnHO8mFZwIiZJY_0Q-1
X-Mimecast-MFC-AGG-ID: 7L_ugxnHO8mFZwIiZJY_0Q_1783262155
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493b0fe95b6so11369705e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262155; x=1783866955; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DNcvRMiitysJcmRtUZXzlgXLa0I8VMObuPV+Psg+jNU=;
 b=Fv2RUnOAsqikfy3twyTgJSjHysN3RlGvlHs0c5+ZHX0asCTNVCS/MHGhEfloyeKrcA
 EGkfR1M0ZJP4ebUwmEzX29eQWJvW+e+nwVRM1slrnnPszl0n2hO7MDeTr3+gvrAiO03a
 i82Bfvfm5LM5wJHujJN45QEamJufLtWgtuMFxHHgVtCMQoEIETlYkQiSU0S2PYryIkh/
 UPhpDyTBk78FZEBpOjC7e69Hdr9/Ac5DRiG1bMl4Xva1cuBlQMxhpbv5kyn9Ok+cXLD4
 h2M9e4ejO3G5lu9/lD48w9f+15jDOYhliNxrScEZgvXmOaLS96vjAr5tPV3SRHMR02NK
 QPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262155; x=1783866955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNcvRMiitysJcmRtUZXzlgXLa0I8VMObuPV+Psg+jNU=;
 b=tFlksjiLZeEAnolxp67gYMc9RwqT9RuhF/bofHaQlgnQqzq80upOUHK/Ukz+IB3ivu
 wC2jpVjNbf9D48loYMOdSxfNg/g36gZuRIvyvwXdin40h6+o+WYzuUAwIXQEnsAsBI9d
 wNeqkbLwHJ4JvwvI156r5FOiRcYNG4Fz48BK8g1Xa9t7yLCIhP7gJbGukoM7pI4WVU2j
 ChjdWH3oBmCx7FGvWWLveIEkxVca5YbXfWMJK0y6F8ROJWPWLfQfpbO0m7xktA7XusVV
 krgCzoEZUjpSmSA3GcwdsrV9tEArewTkSs8ATGhOi49XSMT4tuynCKB0KLZ1I4COS3W6
 DDSg==
X-Gm-Message-State: AOJu0YwnBWLSGUBKXFH0zh7lYWoHhC8AgE2vyM3WvIqfWcZulaTCWMb2
 ZjerjVq45XrRcmXZDW0w6njy2pAb060XEIXgymCrHUQNq4WSYMb94drP1Li3fVG7xBpXGwdfexQ
 hSnIxTHcnVt1/l4fRRs0Qj5+1d6Cw/fFRBp3+GhCaIpASpdiXjjzGetFAlAvYtyooXC92S9k7jg
 h9PxNUeHY26VqwGJc5vjsKaeJ9nLT8U+6Vbg==
X-Gm-Gg: AfdE7cnovKs43G5NMflQ1EvHL+K3wbRamhAr0iH1mPiytQDs0QXGJcwt0OgK5RyXfMM
 WAUStWhPUh8Lc2UoqLLz5it2DuoqKcRjKuxxFn+u74alEI1eLnq5gwJU5QnTw6uksSKjrk13gLJ
 rcUshQX/dprzX0kF8g31wQZA7JVVFStROQNwbLCnWr7h/4wn7HXiM6f6sbGxv5gv15s4LLFoPdI
 lnrDbKSP6JSjl8yxseoTFodctORrYjDBgdcXbS9CQPWlBsi87icH5h+K6XKP4OJqADieLI6YTaG
 5YFzYM4bg4JRA8c5TqYp/YnYduk/QceHCwWFa3xxsy9re6r3jeJfqYGqBT0aJJ5FyevE+4xYWOG
 DZYgNpDRIpweuSeIGtSEqYNIuv0gm2ZH3
X-Received: by 2002:a05:600c:528c:b0:492:454c:347c with SMTP id
 5b1f17b1804b1-493d11d3bc2mr84590605e9.7.1783262154512; 
 Sun, 05 Jul 2026 07:35:54 -0700 (PDT)
X-Received: by 2002:a05:600c:528c:b0:492:454c:347c with SMTP id
 5b1f17b1804b1-493d11d3bc2mr84590175e9.7.1783262153952; 
 Sun, 05 Jul 2026 07:35:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef183e7sm376987125e9.2.2026.07.05.07.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:53 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PULL 29/44] arm: sbsa_gwdt: rename device type to sbsa-gwdt
Message-ID: <5cb6dfc12d36ede1f79deb58385e324e7dc1cce9.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Use hyphenated name to follow QEMU device naming convention.
Migration compatibility is preserved since the vmstate name
is already "sbsa-gwdt".

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260702145856.1539572-4-imammedo@redhat.com>
---
 include/hw/watchdog/sbsa_gwdt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/watchdog/sbsa_gwdt.h b/include/hw/watchdog/sbsa_gwdt.h
index 307a4f291a..8941dcff9e 100644
--- a/include/hw/watchdog/sbsa_gwdt.h
+++ b/include/hw/watchdog/sbsa_gwdt.h
@@ -16,7 +16,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 
-#define TYPE_WDT_SBSA "sbsa_gwdt"
+#define TYPE_WDT_SBSA "sbsa-gwdt"
 #define SBSA_GWDT(obj) \
     OBJECT_CHECK(SBSA_GWDTState, (obj), TYPE_WDT_SBSA)
 #define SBSA_GWDT_CLASS(klass) \
-- 
MST


