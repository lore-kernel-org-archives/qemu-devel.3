Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBA0C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 11:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgMm0-0005Yg-H9; Fri, 07 Feb 2025 06:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgMlz-0005Y0-E7
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:43:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgMlx-0002O6-UQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738928628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nuIaoT6M7lupHC5lucR/rG7gkZTCViirD62qLmJam78=;
 b=T03rEh1FG2NIA/BNDm6USB92IY6diNZgfdVYQxZPUE1cdddzjAAnVO0ZD06+RAn2yLyApq
 wFzCw2X73i3XUzFtQ96mzmexd/MFUlsEbMfWGnflE1ZkNpPOy+8E/oG+XvGglwtcg9aOGU
 8g9TNMZ2NBNZefXiDa+sYZ7lkSFIfkI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-OI7DrTqhNnmtDPmxcdwjTQ-1; Fri,
 07 Feb 2025 06:43:45 -0500
X-MC-Unique: OI7DrTqhNnmtDPmxcdwjTQ-1
X-Mimecast-MFC-AGG-ID: OI7DrTqhNnmtDPmxcdwjTQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 806861800873; Fri,  7 Feb 2025 11:43:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59BB51800360; Fri,  7 Feb 2025 11:43:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DC01C21E6A28; Fri, 07 Feb 2025 12:43:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v4 3/4] qapi: rename 'special_features' to 'features'
In-Reply-To: <20250205123550.2754387-4-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 5 Feb 2025 12:35:49
 +0000")
References: <20250205123550.2754387-1-berrange@redhat.com>
 <20250205123550.2754387-4-berrange@redhat.com>
Date: Fri, 07 Feb 2025 12:43:40 +0100
Message-ID: <87a5ayj7yr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This updates the QAPI code generation to refer to 'features' instead
> of 'special_features', in preparation for generalizing their exposure.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

John pointed out that isort wants the appended fixup.  Not thrilled
about the additional churn, but let's not fight our tools.  Thanks,
John!


diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index ade6b7a3d7..e4a1bb9f85 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -16,11 +16,7 @@
 from typing import List, Optional
=20
 from .common import c_enum_const, c_name, mcgen
-from .gen import (
-    QAPISchemaModularCVisitor,
-    gen_features,
-    ifcontext,
-)
+from .gen import QAPISchemaModularCVisitor, gen_features, ifcontext
 from .schema import (
     QAPISchema,
     QAPISchemaAlternatives,
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 8dbf4ef1c3..928273b9bb 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -21,11 +21,7 @@
     indent,
     mcgen,
 )
-from .gen import (
-    QAPISchemaModularCVisitor,
-    gen_features,
-    ifcontext,
-)
+from .gen import QAPISchemaModularCVisitor, gen_features, ifcontext
 from .schema import (
     QAPISchema,
     QAPISchemaAlternatives,


