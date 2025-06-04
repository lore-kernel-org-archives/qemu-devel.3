Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC444C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 20:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMuLO-0005uW-Va; Wed, 04 Jun 2025 16:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uMuLN-0005u2-42
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 16:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uMuLL-0008J6-J7
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 16:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749067450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8sSEigBL7p/evyVdd+xP8GV6W4BTwuO4t9tNrOTuxw=;
 b=iYWjWi4JZun/hXRAJvkf1tXmarlHgBwXOsXPO2L4Cobva03jME8fhD8nAV+uLV7UlH4pMQ
 /n8K8vCVyDCTdB2WUxFFZA2EOvGXDo3tv+EJDN79FhnkFlp1dljbEzbdaCqnTsyDe6X7K7
 oXgMkNf6soKiT7Jr3qG8taXrxlIG9eo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-qRRfFf6iOQiU40dMjM0X5g-1; Wed,
 04 Jun 2025 16:04:07 -0400
X-MC-Unique: qRRfFf6iOQiU40dMjM0X5g-1
X-Mimecast-MFC-AGG-ID: qRRfFf6iOQiU40dMjM0X5g_1749067446
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EBB01801A22; Wed,  4 Jun 2025 20:04:06 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40AA230002C3; Wed,  4 Jun 2025 20:04:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v5 6/6] qapi: delete un-needed python static analysis configs
Date: Wed,  4 Jun 2025 16:03:54 -0400
Message-ID: <20250604200354.459501-7-jsnow@redhat.com>
In-Reply-To: <20250604200354.459501-1-jsnow@redhat.com>
References: <20250604200354.459501-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

Since the previous commit, python/setup.cfg applies to scripts/qapi/ as
well.  Configuration files in scripts/qapi/ override python/setup.cfg.

scripts/qapi/.flake8 and scripts/qapi/.isort.cfg actually match
python/setup.cfg exactly, and can go.

The differences between scripts/qapi/mypy.ini and python/setup.cfg are
harmless: namespace_packages being set to True is a requirement for the
PEP420 nested package structure of QEMU but not for scripts/qapi, but
has no effect on type checking the QAPI code. warn_unused_ignores is
used in python/ to be able to target a wide variety of mypy versions;
some of which that have added new ignore categories that are not present
in older versions.

Ultimately, scripts/qapi/mypy.ini can be removed without any real change
in behavior to how mypy enforces type safety there.

The pylint config is being left in place because the settings differ
enough from the python/ directory settings that we need a chit-chat on
how to merge them O:-)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/.flake8    | 3 ---
 scripts/qapi/.isort.cfg | 7 -------
 scripts/qapi/mypy.ini   | 4 ----
 3 files changed, 14 deletions(-)
 delete mode 100644 scripts/qapi/.flake8
 delete mode 100644 scripts/qapi/.isort.cfg
 delete mode 100644 scripts/qapi/mypy.ini

diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8
deleted file mode 100644
index a873ff67309..00000000000
--- a/scripts/qapi/.flake8
+++ /dev/null
@@ -1,3 +0,0 @@
-[flake8]
-# Prefer pylint's bare-except checks to flake8's
-extend-ignore = E722
diff --git a/scripts/qapi/.isort.cfg b/scripts/qapi/.isort.cfg
deleted file mode 100644
index 643caa1fbd6..00000000000
--- a/scripts/qapi/.isort.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-[settings]
-force_grid_wrap=4
-force_sort_within_sections=True
-include_trailing_comma=True
-line_length=72
-lines_after_imports=2
-multi_line_output=3
diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
deleted file mode 100644
index c9dbcec2db0..00000000000
--- a/scripts/qapi/mypy.ini
+++ /dev/null
@@ -1,4 +0,0 @@
-[mypy]
-strict = True
-disallow_untyped_calls = False
-python_version = 3.9
-- 
2.48.1


