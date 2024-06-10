Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DD5C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGiao-0003zT-BF; Mon, 10 Jun 2024 13:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGiam-0003yu-6U
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGiak-000185-AH
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718039637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OP+/NofEHfriZHjVuD5xeoqav13ZMnkO9pmZ52xvGDY=;
 b=Xsx89PNJ5pvv36qxBqJZuAHSE1gOVDnLc8n5Y+NUZ3Dy6ETXwLS9tX5Ob+BjIqocoHPlj8
 vqoK2tqqdv6rS/NxvXjsvshKs398PDoZKLAexZd7jgLEeNuLvt0yvayPkqKRgERREInMkM
 zgiZ7IgdQwxkD9192bQXVfZRhpoHR7E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-y3nd2ZAlMmKeZfU0jzh2NQ-1; Mon,
 10 Jun 2024 13:13:54 -0400
X-MC-Unique: y3nd2ZAlMmKeZfU0jzh2NQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F0641955F30; Mon, 10 Jun 2024 17:13:51 +0000 (UTC)
Received: from localhost (unknown [10.39.195.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D7181956089; Mon, 10 Jun 2024 17:13:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Alex Williamson <alex.williamson@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 1/6] tracetool: Remove unused vcpu.py script
Date: Mon, 10 Jun 2024 13:13:10 -0400
Message-ID: <20240610171315.346143-2-stefanha@redhat.com>
In-Reply-To: <20240610171315.346143-1-stefanha@redhat.com>
References: <20240610171315.346143-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

vcpu.py is pointless since commit 89aafcf2a7 ("trace:
remove code that depends on setting vcpu"), remote it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-id: 20240606102631.78152-1-philmd@linaro.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 meson.build                   |  1 -
 scripts/tracetool/__init__.py |  8 +----
 scripts/tracetool/vcpu.py     | 59 -----------------------------------
 3 files changed, 1 insertion(+), 67 deletions(-)
 delete mode 100644 scripts/tracetool/vcpu.py

diff --git a/meson.build b/meson.build
index ec59effca2..91278667ea 100644
--- a/meson.build
+++ b/meson.build
@@ -3232,7 +3232,6 @@ tracetool_depends = files(
   'scripts/tracetool/format/log_stap.py',
   'scripts/tracetool/format/stap.py',
   'scripts/tracetool/__init__.py',
-  'scripts/tracetool/vcpu.py'
 )
 
 qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index b887540a55..7237abe0e8 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -306,13 +306,7 @@ def build(line_str, lineno, filename):
             fmt = [fmt_trans, fmt]
         args = Arguments.build(groups["args"])
 
-        event = Event(name, props, fmt, args, lineno, filename)
-
-        # add implicit arguments when using the 'vcpu' property
-        import tracetool.vcpu
-        event = tracetool.vcpu.transform_event(event)
-
-        return event
+        return Event(name, props, fmt, args, lineno, filename)
 
     def __repr__(self):
         """Evaluable string representation for this object."""
diff --git a/scripts/tracetool/vcpu.py b/scripts/tracetool/vcpu.py
deleted file mode 100644
index d232cb1d06..0000000000
--- a/scripts/tracetool/vcpu.py
+++ /dev/null
@@ -1,59 +0,0 @@
-# -*- coding: utf-8 -*-
-
-"""
-Generic management for the 'vcpu' property.
-
-"""
-
-__author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
-__copyright__  = "Copyright 2016, Lluís Vilanova <vilanova@ac.upc.edu>"
-__license__    = "GPL version 2 or (at your option) any later version"
-
-__maintainer__ = "Stefan Hajnoczi"
-__email__      = "stefanha@redhat.com"
-
-
-from tracetool import Arguments, try_import
-
-
-def transform_event(event):
-    """Transform event to comply with the 'vcpu' property (if present)."""
-    if "vcpu" in event.properties:
-        event.args = Arguments([("void *", "__cpu"), event.args])
-        fmt = "\"cpu=%p \""
-        event.fmt = fmt + event.fmt
-    return event
-
-
-def transform_args(format, event, *args, **kwargs):
-    """Transforms the arguments to suit the specified format.
-
-    The format module must implement function 'vcpu_args', which receives the
-    implicit arguments added by the 'vcpu' property, and must return suitable
-    arguments for the given format.
-
-    The function is only called for events with the 'vcpu' property.
-
-    Parameters
-    ==========
-    format : str
-        Format module name.
-    event : Event
-    args, kwargs
-        Passed to 'vcpu_transform_args'.
-
-    Returns
-    =======
-    Arguments
-        The transformed arguments, including the non-implicit ones.
-
-    """
-    if "vcpu" in event.properties:
-        ok, func = try_import("tracetool.format." + format,
-                              "vcpu_transform_args")
-        assert ok
-        assert func
-        return Arguments([func(event.args[:1], *args, **kwargs),
-                          event.args[1:]])
-    else:
-        return event.args
-- 
2.45.1


