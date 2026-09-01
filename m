Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4858BC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Jol-0002z9-24; Tue, 01 Sep 2026 04:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1Joj-0002yx-G8
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1Joi-0003FY-4c
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788251163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F20tFHH/LJkfzBHp2X6+4igr83jVhHkSqcW6z5Wo+wQ=;
 b=DMqZmwdU5bOYBcLTBlNT3HgRUIuK5NJh8sYd+EutfBYOy3SnEKOkSxVyEkrwppqn/ekJLI
 cPSgLPVOjsxmY9e8Zd4PP0P2k4Z7iN78A10GI7T4R5Uktxz66oIfnLVR50DR0fjeBYTQHh
 yjIYwdLpi2n61xDKwucBsYm3Mie9T+c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-0-gLwbIgMPW-BJkBJsfKgA-1; Tue,
 01 Sept 2026 04:25:59 -0400
X-MC-Unique: 0-gLwbIgMPW-BJkBJsfKgA-1
X-Mimecast-MFC-AGG-ID: 0-gLwbIgMPW-BJkBJsfKgA_1788251158
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89B88193EF53; Tue,  1 Sep 2026 08:25:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.41])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 165F51800640; Tue,  1 Sep 2026 08:25:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 44BD9180614C; Tue, 01 Sep 2026 10:25:54 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 03/13] edk2: update submodule to edk2-stable202608
Date: Tue,  1 Sep 2026 10:25:36 +0200
Message-ID: <20260901082554.804169-4-kraxel@redhat.com>
In-Reply-To: <20260901082554.804169-1-kraxel@redhat.com>
References: <20260901082554.804169-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260824164751.1700783-4-kraxel@redhat.com>
---
 roms/edk2         | 2 +-
 roms/edk2-version | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/roms/edk2 b/roms/edk2
index 4dfdca63a934..2970e5699ba6 160000
--- a/roms/edk2
+++ b/roms/edk2
@@ -1 +1 @@
-Subproject commit 4dfdca63a93497203f197ec98ba20e2327e4afe4
+Subproject commit 2970e5699ba6267f3384ffab20f96647578aebc8
diff --git a/roms/edk2-version b/roms/edk2-version
index 069f19f8bf49..8a0cf62749cf 100644
--- a/roms/edk2-version
+++ b/roms/edk2-version
@@ -1,2 +1,2 @@
-EDK2_STABLE = edk2-stable202408
-EDK2_DATE = 08/13/2024
+EDK2_STABLE = edk2-stable202608
+EDK2_DATE = 08/12/2026
-- 
2.55.0


