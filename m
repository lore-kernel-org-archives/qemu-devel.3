Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AB7C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 13:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFYWB-0008MZ-AC; Thu, 15 May 2025 09:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFYW9-0008M5-IX
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFYW7-0003d3-Sq
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747315254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bnVivZM19jdzg1O8bSO3P81+CUwSDqL4m+zqp5qD/Rg=;
 b=AOK7ZfaAGUPaGhTbJORdJGyTS3MHil0gczT0TORDlALRcNbH2OfaeYqgew4Gs6eft9tors
 1Rr+kM734HgUq7gyHnbIYUUMMV7543P8nd8F/aVCcYh2tGKtmq+9FBvqclt3JmyF/eVxqc
 sgu5iaWhbkdQ8YcVfOzKI4WPg0jLrl0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-U1OdYs3wMWGd8y91hlAaOw-1; Thu,
 15 May 2025 09:20:49 -0400
X-MC-Unique: U1OdYs3wMWGd8y91hlAaOw-1
X-Mimecast-MFC-AGG-ID: U1OdYs3wMWGd8y91hlAaOw_1747315248
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42A1E18003FC; Thu, 15 May 2025 13:20:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5BBA1956094; Thu, 15 May 2025 13:20:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 4/4] docs: Deprecate the qemu-system-microblazeel binary
Date: Thu, 15 May 2025 15:20:19 +0200
Message-ID: <20250515132019.569365-5-thuth@redhat.com>
In-Reply-To: <20250515132019.569365-1-thuth@redhat.com>
References: <20250515132019.569365-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The (former big-endian only) binary qemu-system-microblaze can
handle both endiannesses nowadays, so we don't need the separate
qemu-system-microblazeel binary for little endian anymore. Let's
deprecate it to avoid unnecessary compilation and test time in
the future.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 8c5fe6fb274..0dfcad5d029 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -323,6 +323,19 @@ machine must ensure that they're setting the ``spike`` machine in the
 command line (``-M spike``).
 
 
+System emulator binaries
+------------------------
+
+``qemu-system-microblazeel`` (since 10.1)
+'''''''''''''''''''''''''''''''''''''''''
+
+The ``qemu-system-microblaze`` binary can emulate little-endian machines
+now, too, so the separate binary ``qemu-system-microblazeel`` (with the
+``el`` suffix) for little-endian targets is not required anymore. The
+``petalogix-s3adsp1800`` machine can now be switched to little endian by
+setting its ``endianness`` property to ``little``.
+
+
 Backend options
 ---------------
 
-- 
2.49.0


