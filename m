Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECDAC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEMM-0001o6-KJ; Tue, 09 Apr 2024 12:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ruEMD-0001mT-EA
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ruEMA-0005iE-HA
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712680197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lht0I9FTyuchQiffFzSmnnZQxt6e6TyKzv5EMLRn7XI=;
 b=hjy5mRkDHWbDdHOBxZNBSqDfQwP0hjRGmVdbRf0jw618RastaqsrwXpw7ZWhVxrwRgnyf9
 Z6nuXkYQNydTADI1RxQlFKnbtxBu7gBQZ9brVBoJJUe1K6LrrHH13bi6kGDLjP12ECPmPx
 SNGnUkk8APKZbQFjmbK3NrQ6LpshHPs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-L3yW_lfcMtq8jLIUL01cZg-1; Tue,
 09 Apr 2024 12:29:53 -0400
X-MC-Unique: L3yW_lfcMtq8jLIUL01cZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 881753C02453;
 Tue,  9 Apr 2024 16:29:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D6892026D06;
 Tue,  9 Apr 2024 16:29:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AEB1D1801A93; Tue,  9 Apr 2024 18:29:42 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/4] edk2: commit version info
Date: Tue,  9 Apr 2024 18:29:32 +0200
Message-ID: <20240409162942.454419-3-kraxel@redhat.com>
In-Reply-To: <20240409162942.454419-1-kraxel@redhat.com>
References: <20240409162942.454419-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20240327102448.61877-3-kraxel@redhat.com>
---
 roms/edk2-version | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 roms/edk2-version

diff --git a/roms/edk2-version b/roms/edk2-version
new file mode 100644
index 000000000000..1594ed8c4de9
--- /dev/null
+++ b/roms/edk2-version
@@ -0,0 +1,2 @@
+EDK2_STABLE = edk2-stable202402
+EDK2_DATE = 02/14/2024
-- 
2.44.0


