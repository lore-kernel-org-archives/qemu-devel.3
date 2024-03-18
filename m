Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4CCC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFeW-00075p-DY; Mon, 18 Mar 2024 12:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeN-00073F-Go
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeM-0004aW-1z
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LgMKQIgmrlt2/gT6pFRai77FFjqKkjfoJlKBE508wB8=;
 b=RkY7VGSv/opIpEYO+fJDuXC8Us1SbTw6YhJeQF0JuPCsTUxKSCU4+kl5Iy10wLa/XmdgwY
 xGJxEbgPckMTPkxP+7H+qZ46srYu2Q6RtphA6Bd7ljdcWgn1UmD8VCICbAsOXiClkMtOQq
 Ln80ernAMXTVZ+L4KIlVQlkVXm7KFv0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-lxgHLeZfPj68QKUEYpm96A-1; Mon, 18 Mar 2024 12:15:43 -0400
X-MC-Unique: lxgHLeZfPj68QKUEYpm96A-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-513da602cafso2722871e87.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778540; x=1711383340;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LgMKQIgmrlt2/gT6pFRai77FFjqKkjfoJlKBE508wB8=;
 b=DdId0dRqm0dwhjlYkUFrGKwyBfjrjJXK7XmCZo3Us1mXq1zq+4rCLXL3WbiWoszrsU
 liYXWGtUMYTek7LAG766Jt+8Mg9bv6lgp+9oo1V/Juqd5GY1FwqXrXzIXX8Q/4NgkQtC
 k4m6vo7zMTt7AA1SB1j2a7lGweTR8yYFsUX+ZUSO1I5B/O+yJ4nYqcwXug61FeheJcpo
 IT2iOi0hleBgpKHlWSdKJYtZGVfcAzVTEpLBctUARtMiTOKFZRedYW7w6/AHG6ctSKpU
 jXF8M6pKLrbu2gUnZgT82+dbkiBx97c6HRWDCNds/NV6cBLN/wJgo4yzNljzQ7MEv72V
 YGbg==
X-Gm-Message-State: AOJu0YxS4I3hlecXQekl9g0tZNXIqPW6LjNNljPErC56TZwIK0ASVDjB
 Nc9jg0FBNhmWmiXBivMLkvHSrtgFJAFU19/jP9G0jXIwKJgf/rmStMLK7N2Ar1JY0B88cdBSKBM
 IPrVM9kH0PWmbVOnfZePo8nuI3618VQfZLOf+cwCD2hC/wJtBvuvS1z0tx6V5vQLFtP0AQdgIvx
 FzJjw0B9cpmxLwtJQao9dcovnvBm39HA==
X-Received: by 2002:ac2:5b5e:0:b0:513:d1cd:b902 with SMTP id
 i30-20020ac25b5e000000b00513d1cdb902mr7678065lfp.32.1710778540153; 
 Mon, 18 Mar 2024 09:15:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfJwSLvV25bVw3/ZZn9bT44TODshzLSpj0xAhllnCGOWmBpEh3o1Ykms8ughzKUiZITIY4VA==
X-Received: by 2002:ac2:5b5e:0:b0:513:d1cd:b902 with SMTP id
 i30-20020ac25b5e000000b00513d1cdb902mr7678048lfp.32.1710778539643; 
 Mon, 18 Mar 2024 09:15:39 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 w9-20020a05600c474900b0041408af4b34sm7818539wmo.10.2024.03.18.09.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:15:38 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:15:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/24] docs/specs/pvpanic: mark shutdown event as not
 implemented
Message-ID: <e739d1935c461d0668057e9dbba9d06f728d29ec.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

From: Thomas Weißschuh <thomas@t-8ch.de>

Mention the fact that this event is not yet implemented
to avoid confusion.
As requested by Michael.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240313-pvpanic-note-v1-1-7f2571cdaedc@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/pvpanic.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/specs/pvpanic.rst b/docs/specs/pvpanic.rst
index 61a80480ed..b0f27860ec 100644
--- a/docs/specs/pvpanic.rst
+++ b/docs/specs/pvpanic.rst
@@ -29,7 +29,7 @@ bit 1
   a guest panic has happened and will be handled by the guest;
   the host should record it or report it, but should not affect
   the execution of the guest.
-bit 2
+bit 2 (to be implemented)
   a regular guest shutdown has happened and should be processed by the host
 
 PCI Interface
-- 
MST


