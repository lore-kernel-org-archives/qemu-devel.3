Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893E7C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8kv-000403-3y; Wed, 03 Jul 2024 18:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8kt-0003lG-PB
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8kq-0001Zc-Vi
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4UiaVaJHqFRMzcgj8Lsoa2O3CKB9KU5Hs0p0vn09PA=;
 b=f98gqa6XZyuA5q/1nw1o3NWZlNYN+7+GIuf6KHxHJBW0cJ8Ao3dg+dSnlUjodrXLBDEvny
 CQWytZlH9nEcHpMx7bXsR3i/yddWzpMeMz4j+7GhFi/79xEzSMNA5R5zpTFmZKAsFfj86n
 KwitXelRWc1mqzlMK+yyazUQ/4Bcw2U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-uGaIPky4M0eZvtWkFH4IXg-1; Wed, 03 Jul 2024 18:47:10 -0400
X-MC-Unique: uGaIPky4M0eZvtWkFH4IXg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a72716df71eso1114566b.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046828; x=1720651628;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g4UiaVaJHqFRMzcgj8Lsoa2O3CKB9KU5Hs0p0vn09PA=;
 b=G/CXPeRBIipORqxPXR/kYMZwNKDorAkfInlMD0Ofm+2H2PTwNeHnntGZ/7Qv3Iqfw1
 gbtghUPA2Kk8cqKp0UXpazCUQJ15XMElbz0EdrUQqW9+XN2E8xmLDcwZQ7A4yFNnKFBH
 3T6CpUM3dgxJU0Gr4LZe7QnwBUklKK6iVLiN5yLwPdn1S56C9ZcYX9etG697I8m0BaMW
 Xq8CDkFz9wp/i21lhfTAqkl+8paJJq06S33BlHfiS0IE09bXqwUo0YrtbORJF+KLfOwe
 OPfX8MS0sVYEn4hxgoXt5rHlFj4nqUlydNcjXWfUDtnmgPjU3UEE6f895BaDqO5qj55C
 xH+g==
X-Gm-Message-State: AOJu0YyxA6AIEHvrQwFEj1cP/dcoVH7HOnd183SYLRaLObJKCVPf7A9U
 meC4QPgNTI94L21kVENimIZaHUL9uA+qqCuXB6BxL0gtVpGJFBVBpqbYeNtkzPdpQ2Upa5AEPTN
 2Xp2QZlyLxi900MFQtMEUO4aOQjVqdFcLxXfZZ2hJ5mS3T1baEBSU2NlJztyRYrXEoiCfoXrOhk
 5CjIvJu81iy28ac4FylaZ2oQ7Epd6gxw==
X-Received: by 2002:a17:906:3518:b0:a72:b278:5a7 with SMTP id
 a640c23a62f3a-a751449f46cmr939805866b.44.1720046828492; 
 Wed, 03 Jul 2024 15:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0tgV/R+7BiCjys6UuOvXJNtdz1hKaqFOBJGBXHpiOv/lsyw5B4nhwHjR1S7ese8Mj7kFSHA==
X-Received: by 2002:a17:906:3518:b0:a72:b278:5a7 with SMTP id
 a640c23a62f3a-a751449f46cmr939804266b.44.1720046827930; 
 Wed, 03 Jul 2024 15:47:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab065651sm543222366b.126.2024.07.03.15.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:47:07 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:47:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 36/85] Revert "docs/specs/pvpanic: mark shutdown event as
 not implemented"
Message-ID: <0c0cc13d319cf7b876f327fa1c5cc1866ad868cc.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Thomas Weißschuh <thomas@t-8ch.de>

The missing functionality has been implemented now.

This reverts commit e739d1935c461d0668057e9dbba9d06f728d29ec.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240527-pvpanic-shutdown-v8-8-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/pvpanic.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/specs/pvpanic.rst b/docs/specs/pvpanic.rst
index b0f27860ec..61a80480ed 100644
--- a/docs/specs/pvpanic.rst
+++ b/docs/specs/pvpanic.rst
@@ -29,7 +29,7 @@ bit 1
   a guest panic has happened and will be handled by the guest;
   the host should record it or report it, but should not affect
   the execution of the guest.
-bit 2 (to be implemented)
+bit 2
   a regular guest shutdown has happened and should be processed by the host
 
 PCI Interface
-- 
MST


