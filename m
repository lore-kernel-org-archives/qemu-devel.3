Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C40C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNFw-0001ZE-QX; Mon, 24 Aug 2026 01:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyNFj-0001CL-Ot
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyNFi-0006n8-D2
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787549385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hEs5FEz2WGSi4iO3MtbQjI6pGXnjbXGTJo/QlNI5J20=;
 b=Xn+9KzBetU6e3JVORVjdmHpfLac9K1oAOUHSIzm4fhJ2E+hpiTJ32w1u6scD050zkNxcvS
 BGuOU4YhE23X3PgPvNtrjafO3+A5fpvStKU6E5Lp1DFWQ4hMUd91veJ6u2FO7k4tENoUgy
 UDEqCA+CpvTXztVjx4gJIQAK4+8QCrk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-lu46PNbbPJa6oRz9pDMEyw-1; Mon,
 24 Aug 2026 01:29:41 -0400
X-MC-Unique: lu46PNbbPJa6oRz9pDMEyw-1
X-Mimecast-MFC-AGG-ID: lu46PNbbPJa6oRz9pDMEyw_1787549380
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FE0D182A112; Mon, 24 Aug 2026 05:29:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.29])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E5A21800577; Mon, 24 Aug 2026 05:29:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 09/12] python: remove stale setup.cfg options
Date: Mon, 24 Aug 2026 01:28:55 -0400
Message-ID: <20260824052859.880475-10-jsnow@redhat.com>
In-Reply-To: <20260824052859.880475-1-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With the recent version bumps, we no longer need these directives.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/setup.cfg | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/python/setup.cfg b/python/setup.cfg
index f866f659574..ebb4230899c 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -65,7 +65,6 @@ exclude = __pycache__,
 [mypy]
 strict = True
 namespace_packages = True
-warn_unused_ignores = False
 
 [mypy-qemu.utils.qom_fuse]
 # fusepy has no type stubs:
@@ -76,12 +75,6 @@ allow_subclassing_any = True
 [mypy-fuse]
 ignore_missing_imports = True
 
-[mypy-tomli]
-ignore_missing_imports = True
-
-[mypy-tomllib]
-ignore_missing_imports = True
-
 [mypy-distlib]
 ignore_missing_imports = True
 
@@ -91,12 +84,6 @@ ignore_missing_imports = True
 [mypy-distlib.version]
 ignore_missing_imports = True
 
-[mypy-pip._vendor.distlib]
-ignore_missing_imports = True
-
-[mypy-pip._vendor.distlib.scripts]
-ignore_missing_imports = True
-
 [mypy-pip._vendor.distlib.version]
 ignore_missing_imports = True
 
-- 
2.55.0


