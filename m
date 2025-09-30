Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE6ECAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 07:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VEB-0001R3-Jc; Tue, 30 Sep 2025 03:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3VE7-0001Qm-PC
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3VE1-00007J-LW
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759218998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akIrrgqDU+mkq0aTbrDzlvUN4d+gVlBPTqawu7KagZQ=;
 b=Aw13ah3o2g6R+AwhNzq3c63s1gCuKucBvhk0NU3rp3fC7nV/o40mEX20Cw/YIGwVkV2aCJ
 aFoJ1JtUtdEmpSF1Zj36j9RVN7Dh2ooqfDKgc5D3Qmo+shjN4RDppa/We4Sv447t+vjiBV
 TKimXCzrIcYmR52Jm3TGeOnlPNGi7uo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-DRS6hBcxMu6gCbm3HXXa9g-1; Tue,
 30 Sep 2025 03:56:33 -0400
X-MC-Unique: DRS6hBcxMu6gCbm3HXXa9g-1
X-Mimecast-MFC-AGG-ID: DRS6hBcxMu6gCbm3HXXa9g_1759218993
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8EFB1956064; Tue, 30 Sep 2025 07:56:32 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED68D1800446; Tue, 30 Sep 2025 07:56:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 richard.henderson@linaro.org, Thomas Huth <thuth@redhat.com>
Subject: [PULL 5/5] ui/icons/qemu.svg: Add metadata information (author,
 license) to the logo
Date: Tue, 30 Sep 2025 11:55:59 +0400
Message-ID: <20250930075559.133650-6-marcandre.lureau@redhat.com>
In-Reply-To: <20250930075559.133650-1-marcandre.lureau@redhat.com>
References: <20250930075559.133650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

We've got two versions of the QEMU logo in the repository, one with
the whole word "QEMU" (pc-bios/qemu_logo.svg) and one that only contains
the letter "Q" (ui/icons/qemu.svg). While qemu_logo.svg contains the
proper metadata with license and author information, this is missing
from the ui/icons/qemu.svg file. Copy the meta data there so that
people have a chance to know the license of the file if they only
look at the qemu.svg file.

Closes: https://gitlab.com/qemu-project/qemu/-/issues/3139
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20250930071419.117592-1-thuth@redhat.com>
---
 ui/icons/qemu.svg | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/ui/icons/qemu.svg b/ui/icons/qemu.svg
index 24ca23a1e9..f2500de339 100644
--- a/ui/icons/qemu.svg
+++ b/ui/icons/qemu.svg
@@ -918,7 +918,26 @@
         <dc:format>image/svg+xml</dc:format>
         <dc:type
            rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
-        <dc:title />
+        <dc:title>Kew the Angry Emu</dc:title>
+        <dc:creator>
+          <cc:Agent>
+            <dc:title>Benoît Canet</dc:title>
+          </cc:Agent>
+        </dc:creator>
+        <dc:rights>
+          <cc:Agent>
+            <dc:title>CC BY 3.0</dc:title>
+          </cc:Agent>
+        </dc:rights>
+        <dc:publisher>
+          <cc:Agent>
+            <dc:title>QEMU Community</dc:title>
+          </cc:Agent>
+        </dc:publisher>
+        <dc:date>2012-02-15</dc:date>
+        <cc:license
+           rdf:resource="http://creativecommons.org/licenses/by/3.0/" />
+        <dc:source>https://lists.gnu.org/archive/html/qemu-devel/2012-02/msg02865.html</dc:source>
       </cc:Work>
     </rdf:RDF>
   </metadata>
-- 
2.51.0


