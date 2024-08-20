Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55908C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCf8-0006JT-2a; Mon, 19 Aug 2024 20:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCet-0005Rr-Im
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCer-0003ry-V5
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724113413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rWo2Tsdw7qt5kSlRzu/xbKB78mSUh/D6zkAbI38l4s=;
 b=BNax4JqFz8wqJe53gJBW5iUnJGF7+imIPhPuRCPK6rwxbnb6TcRFGSTbutc0HqvLXQeRFd
 p7WtkSSipCPsn+eNfzzsNLa1zMhjUdFbyJU4N37tfzP8hejji+E8s2EDX1VDltoHd6B9oQ
 +3JyRe1OmamzDrxP06BebHayumM+71Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-SLZIk3gnN26nbTu1MhNmzw-1; Mon,
 19 Aug 2024 20:23:29 -0400
X-MC-Unique: SLZIk3gnN26nbTu1MhNmzw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEBA419560B4; Tue, 20 Aug 2024 00:23:27 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.8.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E87E1956053; Tue, 20 Aug 2024 00:23:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] python/qapi: change "FIXME" to "TODO"
Date: Mon, 19 Aug 2024 20:23:11 -0400
Message-ID: <20240820002318.1380276-3-jsnow@redhat.com>
In-Reply-To: <20240820002318.1380276-1-jsnow@redhat.com>
References: <20240820002318.1380276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

qemu.git/python/setup.cfg disallows checking in any code with "XXX",
"FIXME" or "TODO" in the comments. Soften the restriction to only
prohibit "FIXME", and change the two occurrences of "FIXME" in qapi to
read "TODO" instead.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/setup.cfg         | 5 +++++
 scripts/qapi/commands.py | 2 +-
 scripts/qapi/events.py   | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/python/setup.cfg b/python/setup.cfg
index 3b4e2cc5501..72b58c98c99 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -169,6 +169,11 @@ ignore-signatures=yes
 # TODO: Remove after we opt in to Pylint 2.8.3. See commit msg.
 min-similarity-lines=6
 
+[pylint.miscellaneous]
+
+# forbid FIXME/XXX comments, allow TODO.
+notes=FIXME,
+      XXX,
 
 [isort]
 force_grid_wrap=4
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 79951a841f5..cffed6cd3ba 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -385,7 +385,7 @@ def visit_command(self,
                       coroutine: bool) -> None:
         if not gen:
             return
-        # FIXME: If T is a user-defined type, the user is responsible
+        # TODO: If T is a user-defined type, the user is responsible
         # for making this work, i.e. to make T's condition the
         # conjunction of the T-returning commands' conditions.  If T
         # is a built-in type, this isn't possible: the
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index d1f639981a9..36dc0c50c78 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -84,7 +84,7 @@ def gen_event_send(name: str,
                    boxed: bool,
                    event_enum_name: str,
                    event_emit: str) -> str:
-    # FIXME: Our declaration of local variables (and of 'errp' in the
+    # TODO: Our declaration of local variables (and of 'errp' in the
     # parameter list) can collide with exploded members of the event's
     # data type passed in as parameters.  If this collision ever hits in
     # practice, we can rename our local variables with a leading _ prefix,
-- 
2.45.0


