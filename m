Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6953ACA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 12:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwJjV-0005Lm-KY; Wed, 10 Sep 2025 08:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1uwJjT-0005LZ-Ov
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 08:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1uwJjN-0003yA-IL
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 08:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757506510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uJniuZhYISePtco/niv/T3uqABFCNlSUfkb8G2pfi0M=;
 b=bsF0GIvGUvc31HO6RP7UrNemkeBXvvcQk8UQWbqJhXUGogR94o4rIQYD8F+KVyAxxSF+6U
 Hkvh+eh7LI4WydkRphJxoBmvSfhfnlp8PAQwgrGj1Zxzjh6zpLOT3ISSJFTVqTLRoMB5OT
 cFLkB6ZTCBKKhov0ADzLW6lDQ/mjm0w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-rdNxXbIzMUWeAp8i1maYDw-1; Wed,
 10 Sep 2025 08:15:07 -0400
X-MC-Unique: rdNxXbIzMUWeAp8i1maYDw-1
X-Mimecast-MFC-AGG-ID: rdNxXbIzMUWeAp8i1maYDw_1757506506
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D68C1800294; Wed, 10 Sep 2025 12:15:06 +0000 (UTC)
Received: from harajuku.usersys.redhat.com.homenet.telecomitalia.it (unknown
 [10.45.226.29])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDE981800452; Wed, 10 Sep 2025 12:15:04 +0000 (UTC)
From: Andrea Bolognani <abologna@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] docs/interop/firmware: Add riscv64 to FirmwareArchitecture
Date: Wed, 10 Sep 2025 14:15:01 +0200
Message-ID: <20250910121501.676219-1-abologna@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Descriptors using this value have been shipped for years
by distros, so we just need to update the spec to match
reality.

Signed-off-by: Andrea Bolognani <abologna@redhat.com>
---
 docs/interop/firmware.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 6bbe2cce0a..ccbfaf828d 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -85,12 +85,14 @@
 #
 # @loongarch64: 64-bit LoongArch. (since: 7.1)
 #
+# @riscv64: 64-bit RISC-V.
+#
 # @x86_64: 64-bit x86.
 #
 # Since: 3.0
 ##
 { 'enum' : 'FirmwareArchitecture',
-  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'x86_64' ] }
+  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'riscv64', 'x86_64' ] }
 
 ##
 # @FirmwareTarget:
-- 
2.51.0


