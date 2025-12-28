Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8D7D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0CI-0004Wt-7i; Sun, 28 Dec 2025 18:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1va0C8-0004JE-DX
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:29:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1va0C6-0001ey-TP
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766964541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHFO0Y/knymLK96ocWjL6NzNh/Mdevc69JPRd8u7Ils=;
 b=igesJ2j6kq8hl7C0MxZxpFj9U/fq0Thj1Ru43rQasZhJwkZkMJUh2CJXCgdZHkJI1LAo59
 bIWBL36Y02w0VF3RhhAFc1aM5HCAyOC5la3M3ZgyrK809Dkg1LpDj//5tFcxI/Ch6HEt0V
 7B/BJ7DxQIxiaYg8crGeM8tTag0JevY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-3S60ctkCO1W6EQTut0MJww-1; Sun,
 28 Dec 2025 18:26:58 -0500
X-MC-Unique: 3S60ctkCO1W6EQTut0MJww-1
X-Mimecast-MFC-AGG-ID: 3S60ctkCO1W6EQTut0MJww_1766964418
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C33E918009C2; Sun, 28 Dec 2025 23:26:57 +0000 (UTC)
Received: from harajuku.usersys.redhat.com.homenet.telecomitalia.it (unknown
 [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 248A519560AB; Sun, 28 Dec 2025 23:26:54 +0000 (UTC)
From: Andrea Bolognani <abologna@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/2] docs/interop/firmware: Rename FirmwareFormat to
 FirmwareFlashFormat
Date: Mon, 29 Dec 2025 00:26:48 +0100
Message-ID: <20251228232649.1708400-2-abologna@redhat.com>
In-Reply-To: <20251228232649.1708400-1-abologna@redhat.com>
References: <20251228232649.1708400-1-abologna@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

We are about to introduce a new set of enums that will be used
by FirmwareMappingMemory and that don't overlap with the formats
that are supported for FirmwareMappingFlash, so we need to
disambiguate things.

Signed-off-by: Andrea Bolognani <abologna@redhat.com>
---
 docs/interop/firmware.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index da0362a2c0..ef9b976a34 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -233,7 +233,7 @@
              'verbose-dynamic', 'verbose-static' ] }
 
 ##
-# @FirmwareFormat:
+# @FirmwareFlashFormat:
 #
 # Formats that are supported for firmware images.
 #
@@ -243,7 +243,7 @@
 #
 # Since: 3.0
 ##
-{ 'enum': 'FirmwareFormat',
+{ 'enum': 'FirmwareFlashFormat',
   'data': [ 'raw', 'qcow2' ] }
 
 ##
@@ -265,7 +265,7 @@
 ##
 { 'struct' : 'FirmwareFlashFile',
   'data'   : { 'filename' : 'str',
-               'format'   : 'FirmwareFormat' } }
+               'format'   : 'FirmwareFlashFormat' } }
 
 
 ##
-- 
2.52.0


