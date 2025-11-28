Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8FDD116EA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 08:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOu76-0006nh-4q; Fri, 28 Nov 2025 03:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOu6j-0006d8-4M
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 03:45:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOu6g-0000QF-Rw
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 03:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764319534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxaXDMAD6zUCmVhB7rZY0V4c7CIz7haBVW4MpnLM3ZU=;
 b=UzmYtb8VnPkLIRujm67rhy6wkOad9KCdAWnR936oeJdzOaZwyxuwfQPXFlTSIkWYJlBPOY
 5PNuswbOjhXnthPVRT4jq+/3al6i9pe3iw8zq4l53/NAHNdoLFvWXHrWcCHZhv++KtZZm1
 9h1NHkK9EgViITKe21XuxsLx58yDTYA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-9tgCnmv2OaCmxvo5-pw-ig-1; Fri,
 28 Nov 2025 03:45:32 -0500
X-MC-Unique: 9tgCnmv2OaCmxvo5-pw-ig-1
X-Mimecast-MFC-AGG-ID: 9tgCnmv2OaCmxvo5-pw-ig_1764319531
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 337631956089; Fri, 28 Nov 2025 08:45:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.236])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF53E180047F; Fri, 28 Nov 2025 08:45:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5EF9A180079D; Fri, 28 Nov 2025 09:45:24 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 3/9] edk2: update submodule to edk2-stable202511
Date: Fri, 28 Nov 2025 09:45:10 +0100
Message-ID: <20251128084524.363989-4-kraxel@redhat.com>
In-Reply-To: <20251128084524.363989-1-kraxel@redhat.com>
References: <20251128084524.363989-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/edk2         | 2 +-
 roms/edk2-version | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/roms/edk2 b/roms/edk2
index 4dfdca63a934..46548b1adac8 160000
--- a/roms/edk2
+++ b/roms/edk2
@@ -1 +1 @@
-Subproject commit 4dfdca63a93497203f197ec98ba20e2327e4afe4
+Subproject commit 46548b1adac82211d8d11da12dd914f41e7aa775
diff --git a/roms/edk2-version b/roms/edk2-version
index 069f19f8bf49..1c2e9c9819df 100644
--- a/roms/edk2-version
+++ b/roms/edk2-version
@@ -1,2 +1,2 @@
-EDK2_STABLE = edk2-stable202408
-EDK2_DATE = 08/13/2024
+EDK2_STABLE = edk2-stable202511
+EDK2_DATE = 11/19/2025
-- 
2.52.0


