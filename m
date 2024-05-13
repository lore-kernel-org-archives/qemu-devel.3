Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC0EC25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Sq5-0004Us-5m; Mon, 13 May 2024 06:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6Sq3-0004UU-2G
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6Sq1-0008Rt-Kf
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715595801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZzxxedEbfJGb19n2QRpwGsMhnAuycLrE0tba6VagJc=;
 b=cCI4BE7HQ/muLXiG5l1ix3Ex2zuooELjyUDMAQ041IJx7rlESgFk6ox/7xPZYNcP8+7aY5
 SgjxGdawd+1pywRiFqigbRyXWSX/P3v1UnRrZY0SSPnya/SdweI6yWXpboowuTXEH3Nj3C
 gayD2LAh0kLzJv7ER3GrDLqO0qojtPM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-GkAzbH9VNS2hQo7mlAeTxQ-1; Mon,
 13 May 2024 06:23:07 -0400
X-MC-Unique: GkAzbH9VNS2hQo7mlAeTxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DC8D3813BC8;
 Mon, 13 May 2024 10:23:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8142740C6CB6;
 Mon, 13 May 2024 10:23:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/4] tests/lcitool: Remove 'xfsprogs' from QEMU
Date: Mon, 13 May 2024 12:22:49 +0200
Message-ID: <20240513102252.48884-2-thuth@redhat.com>
In-Reply-To: <20240513102252.48884-1-thuth@redhat.com>
References: <20240513102252.48884-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

QEMU's commit a5730b8bd3 ("block/file-posix: Simplify the
XFS_IOC_DIOINFO handling") removed the need for the 'xfsprogs'
package.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[thuth: Adjusted the patch from the lcitools repo to QEMU's repo]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/lcitool/projects/qemu.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 149b15de57..9173d1e36e 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -121,7 +121,6 @@ packages:
  - vte
  - which
  - xen
- - xfsprogs
  - xorriso
  - zstdtools
  - zlib
-- 
2.45.0


