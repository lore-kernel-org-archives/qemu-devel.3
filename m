Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5DCC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2024 07:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDIoP-00048T-0s; Sat, 01 Jun 2024 03:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sDIoL-000475-WC
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 03:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sDIoK-00004q-FA
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 03:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717225550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LzJgdHM/KzlJIAiYMmWDf0Cd8hr/6WF0zZsbshR0Zjc=;
 b=PM3AcIFyAEI4N6pacDsS1P9FUjKEdwA13IPp85WwofvQlEoedrD0IiM50Eogh02oGbXRHQ
 swa27hKP16E/jRnTsqAtaUk046eVAk4YJgZ/DAjDvXhtSk7faKSaqbDybbigsldV/zGopV
 SdfBz5BFLlwJ0UnLooiqjEHSVVZ48KY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-DjFGhS-MNCCUeHEuBv0Gmw-1; Sat, 01 Jun 2024 03:05:46 -0400
X-MC-Unique: DjFGhS-MNCCUeHEuBv0Gmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63185185A780;
 Sat,  1 Jun 2024 07:05:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90000208C6F2;
 Sat,  1 Jun 2024 07:05:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/5] tests/lcitool: Delete obsolete centos-stream-8.yml file
Date: Sat,  1 Jun 2024 09:05:39 +0200
Message-ID: <20240601070543.37786-2-thuth@redhat.com>
In-Reply-To: <20240601070543.37786-1-thuth@redhat.com>
References: <20240601070543.37786-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

We've missed to delete this file when removing support for CentOS 8.
Since the current upstream version of the lcitool removed support
for CentOS 8 now, too, we have to remove the file before updating.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/lcitool/targets/centos-stream-8.yml | 3 ---
 1 file changed, 3 deletions(-)
 delete mode 100644 tests/lcitool/targets/centos-stream-8.yml

diff --git a/tests/lcitool/targets/centos-stream-8.yml b/tests/lcitool/targets/centos-stream-8.yml
deleted file mode 100644
index 6b11160fd1..0000000000
--- a/tests/lcitool/targets/centos-stream-8.yml
+++ /dev/null
@@ -1,3 +0,0 @@
-paths:
-  pip3: /usr/bin/pip3.8
-  python: /usr/bin/python3.8
-- 
2.45.1


