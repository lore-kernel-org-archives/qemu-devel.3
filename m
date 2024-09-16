Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69026C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 12:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqApo-0004Qe-Pf; Mon, 16 Sep 2024 08:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sqApm-0004Gd-TI
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sqApl-0001gM-J2
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726489681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3Hjj/OEDLJjSfxe7ftgtLWgSJhA6VUxc/owXq6JXaQ=;
 b=CDMzAeId7Eralv3AqOGIbHj9usgmfhZA61B6FcqGzECcUcFtEOGTumvMNwsMx85y8e0MoJ
 xX6sVw0fqDr4TppvakfIgOjRWv1FbaOdqp5VF51cZqiRZkJh8MSL3S8RX396/VMq4TqIR9
 3filUB49W/ZfekrwBthI+QBfYNWxGLU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-Z6aXanFXMNO784fYw8q40A-1; Mon,
 16 Sep 2024 08:26:09 -0400
X-MC-Unique: Z6aXanFXMNO784fYw8q40A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 754D81955D48; Mon, 16 Sep 2024 12:26:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.72])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D17D81956088; Mon, 16 Sep 2024 12:26:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A68C71801033; Mon, 16 Sep 2024 14:26:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 1/4] update submodule and version file to edk2-stable202408
Date: Mon, 16 Sep 2024 14:25:52 +0200
Message-ID: <20240916122603.71615-2-kraxel@redhat.com>
In-Reply-To: <20240916122603.71615-1-kraxel@redhat.com>
References: <20240916122603.71615-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/edk2         | 2 +-
 roms/edk2-version | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/roms/edk2 b/roms/edk2
index edc6681206c1..b158dad150bf 160000
--- a/roms/edk2
+++ b/roms/edk2
@@ -1 +1 @@
-Subproject commit edc6681206c1a8791981a2f911d2fb8b3d2f5768
+Subproject commit b158dad150bf02879668f72ce306445250838201
diff --git a/roms/edk2-version b/roms/edk2-version
index 1594ed8c4de9..069f19f8bf49 100644
--- a/roms/edk2-version
+++ b/roms/edk2-version
@@ -1,2 +1,2 @@
-EDK2_STABLE = edk2-stable202402
-EDK2_DATE = 02/14/2024
+EDK2_STABLE = edk2-stable202408
+EDK2_DATE = 08/13/2024
-- 
2.46.0


