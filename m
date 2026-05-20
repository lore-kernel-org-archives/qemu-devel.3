Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6FACD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPop4-0000b2-Tx; Wed, 20 May 2026 17:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPop3-0000YM-8H
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPop1-0004Se-FH
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjcl2dWy7e1z/2pEJNDQKBeV0ZyclpnFFu+cLOFkHro=;
 b=ezOPCW+0xUSZAYRyPl45iBR7L0TE26XxZAaLZNtWEibSpBSy592tCVxJ3cKHSdJBDEJVWN
 UxhiJEY87jVw/Km/eMF5xQdFi7yI/TKxDS4EcicaVARauzEV52LR3giDGJ24D7jxxl12qc
 z2FLa/KUd3TlEC8TzFQwMIOazA8c3Ns=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-7OdiUSK5Py2sA8n7W6glfQ-1; Wed,
 20 May 2026 17:51:20 -0400
X-MC-Unique: 7OdiUSK5Py2sA8n7W6glfQ-1
X-Mimecast-MFC-AGG-ID: 7OdiUSK5Py2sA8n7W6glfQ_1779313880
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5C401956046
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:51:19 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9800618004A3; Wed, 20 May 2026 21:51:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:13 +0400
Subject: [PATCH 12/40] tests: use x-query-usernet
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-12-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2929;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+P16oBsYld1xCUKsO57K6aS/d455wRba5dgXW09RuWc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyDdDRmH0csLE5tn4rA7HTqKlRN1qFANHmwU
 R/POELKAQGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5YbVD/97wv36fnrTz0REsCXxfadmCap6A6yu/3786aEJ5J7A0QDslVaPIubs78B0uG4WVr8ZBbM
 MACAYRXmq8lBHrZSShtJgHB+hJWcx9VrXlJr2nsq3+7Rws+xt9lNQMpmyftfP7sL+/zOYcPsQLD
 rb0VQN2JSrZkC3zgtHTbnjOMxXyQtgtXBD4EC3tyFBQNC4XMmAZ+gD7GLmumCa4Y+1tVpNeGdji
 DeJxGAGAURaCm7NxM3QQbiz+DAlzuR486k7j+owSIdInwj9m4hABJduU0+2vwGP2HN1wHWh/FgO
 opSqQYJXvY9cV/ZNvuUSC2EwGPvKWYVHP4OW8RG32WdQ2egfLGQ9qjpcHMJVLH8QkdnxIF5G3Dv
 /iqr3EXmo/1Bn6LSHr5Bn0vVifpgQnTN+L7V6yppKEqBDzz7xQolPVV9LvvUvmh93uYaoOcKAgZ
 2SZsjCR3P5kjZ+FlY1FD8cfGUFng4PbSUnfuWyNuVEk4iuhs629ba1X6WGs3kJgx7hv/x0n6sr1
 WKBBpCmyzAfG2VxjVFzGxXQKUp7kQIKfBScS3mb7MTX+JSzRMDCMG13y9xY0iFtQ24ZJQapWqlU
 wX3ybRPv1RO40fT0XD/+8wDySNbwpPCnzlUDzqFdKA4P1NpPdNRYbJMGBZBLu847amhtjCRG1zL
 n093sVX1fsO0mKA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 python/qemu/utils/__init__.py       |  5 +++--
 tests/functional/qemu_test/utils.py |  8 ++++++--
 tests/vm/basevm.py                  | 13 ++++++++-----
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/python/qemu/utils/__init__.py b/python/qemu/utils/__init__.py
index be5daa83634..e32911d4c6d 100644
--- a/python/qemu/utils/__init__.py
+++ b/python/qemu/utils/__init__.py
@@ -46,10 +46,11 @@ def get_info_usernet_hostfwd_port(info_usernet_output: str) -> Optional[int]:
     """
     Returns the port given to the hostfwd parameter via info usernet
 
-    :param info_usernet_output: output generated by hmp command "info usernet"
+    :param info_usernet_output: output generated by "info usernet" or
+        the "info" field from x-query-usernet
     :return: the port number allocated by the hostfwd option
     """
-    for line in info_usernet_output.split('\r\n'):
+    for line in info_usernet_output.splitlines():
         regex = r'TCP.HOST_FORWARD.*127\.0\.0\.1\s+(\d+)\s+10\.'
         match = re.search(regex, line)
         if match is not None:
diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index 826c267785b..0992db49ab2 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -14,8 +14,12 @@
 
 
 def get_usernet_hostfwd_port(vm):
-    res = vm.cmd('human-monitor-command', command_line='info usernet')
-    return get_info_usernet_hostfwd_port(res)
+    res = vm.cmd('x-query-usernet')
+    for entry in res:
+        port = get_info_usernet_hostfwd_port(entry['info'])
+        if port is not None:
+            return port
+    return None
 
 def pow2ceil(x):
     """
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 9e879e966a3..198b04e8c37 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -312,12 +312,15 @@ def boot(self, img, extra_args=[]):
         self._guest = guest
         # Init console so we can start consuming the chars.
         self.console_init()
-        usernet_info = guest.cmd("human-monitor-command",
-                                 command_line="info usernet")
-        self.ssh_port = get_info_usernet_hostfwd_port(usernet_info)
+        res = guest.cmd("x-query-usernet")
+        for entry in res:
+            port = get_info_usernet_hostfwd_port(entry['info'])
+            if port is not None:
+                self.ssh_port = port
+                break
         if not self.ssh_port:
-            raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
-                            usernet_info)
+            raise Exception("Cannot find ssh port from"
+                            " 'x-query-usernet': %s" % res)
 
     def console_init(self, timeout = None):
         if timeout == None:

-- 
2.54.0


