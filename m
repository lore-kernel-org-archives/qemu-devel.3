Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA7AC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfiI-0005Ku-S0; Tue, 04 Mar 2025 22:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfiH-0005KQ-U1
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfiG-00060J-CD
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EIxtKIfXAperan5ep4E1FQ8USyNb2fZLbeC2CWp4A+k=;
 b=RXpv9Ru5w/iVqXCNzugNFJDgHVDFyQLRLuKz5yRqVzqPbTplumElLiGCxnrB8S+EEDtDXq
 ICTP1WrAIk9ug/xOUp4NHKIUR/Ay8vRakzQo0WZ3WYmahgZ9EzJv5mJPBwQTEzcrbrwxgD
 nyA9h1nNanvkBA9kAyvmJNh+hwcnMIQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-7C41S4lHOHOsMFRH3qp0iw-1; Tue,
 04 Mar 2025 22:46:24 -0500
X-MC-Unique: 7C41S4lHOHOsMFRH3qp0iw-1
X-Mimecast-MFC-AGG-ID: 7C41S4lHOHOsMFRH3qp0iw_1741146383
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80C8F1955D66; Wed,  5 Mar 2025 03:46:23 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D8411956095; Wed,  5 Mar 2025 03:46:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 02/57] qapi: shush pylint up
Date: Tue,  4 Mar 2025 22:45:11 -0500
Message-ID: <20250305034610.960147-3-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

Shhhhh!

This patch is RFC quality, I wasn't in the mood to actually solve
problems so much as I was in the mood to continue working on the Sphinx
rework. Plus, I don't think the code I am patching has hit origin/master
yet ...

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/backend.py |  2 ++
 scripts/qapi/main.py    | 10 ++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
index 14e60aa67af..49ae6ecdd33 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -13,6 +13,7 @@
 
 
 class QAPIBackend(ABC):
+    # pylint: disable=too-few-public-methods
 
     @abstractmethod
     def generate(self,
@@ -36,6 +37,7 @@ def generate(self,
 
 
 class QAPICBackend(QAPIBackend):
+    # pylint: disable=too-few-public-methods
 
     def generate(self,
                  schema: QAPISchema,
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index ff42b43cd68..01155373bd0 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -31,15 +31,14 @@ def create_backend(path: str) -> QAPIBackend:
 
     module_path, dot, class_name = path.rpartition('.')
     if not dot:
-        print(f"argument of -B must be of the form MODULE.CLASS",
+        print("argument of -B must be of the form MODULE.CLASS",
               file=sys.stderr)
         sys.exit(1)
 
     try:
         mod = import_module(module_path)
     except Exception as ex:
-        print(f"unable to import '{module_path}': {ex}", file=sys.stderr)
-        sys.exit(1)
+        raise QAPIError(f"unable to import '{module_path}': {ex}") from ex
 
     try:
         klass = getattr(mod, class_name)
@@ -51,9 +50,8 @@ def create_backend(path: str) -> QAPIBackend:
     try:
         backend = klass()
     except Exception as ex:
-        print(f"backend '{path}' cannot be instantiated: {ex}",
-              file=sys.stderr)
-        sys.exit(1)
+        raise QAPIError(
+            f"backend '{path}' cannot be instantiated: {ex}") from ex
 
     if not isinstance(backend, QAPIBackend):
         print(f"backend '{path}' must be an instance of QAPIBackend",
-- 
2.48.1


