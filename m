Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978F2C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aT-0002hY-2n; Tue, 07 Jul 2026 07:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3aD-0002Or-MT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a7-00088f-EG
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M1DePmGvHRpFRILH0GPAvd7mNYuyam2hQmigwvRXN1o=;
 b=bMRzwfGUragD/PW3bTBRRSq03Jg26/h6rTdrH8j97MAv57XHZs2FjhLuBSlMoX88TttHTj
 iFVwu01ddpYspVYNHDfIp9PRB8qW3cYhmYwi8Y+zCBqOgAOFTmf5xHCvJad5cKy7svd2+9
 VKRuScf6Is8zfP5VMWaK9WFdAofg+yY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-IB2vqLIgPKGkQbGyUDkwBg-1; Tue,
 07 Jul 2026 07:03:13 -0400
X-MC-Unique: IB2vqLIgPKGkQbGyUDkwBg-1
X-Mimecast-MFC-AGG-ID: IB2vqLIgPKGkQbGyUDkwBg_1783422192
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DD0219540C1
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19FC01955F75
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F2CB21E6152; Tue, 07 Jul 2026 13:03:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PULL 35/35] docs: mark '-mon' as deprecated in favour of -object
Date: Tue,  7 Jul 2026 13:03:00 +0200
Message-ID: <20260707110300.1918153-36-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: Daniel P. Berrangé <berrange@redhat.com>

The high level `-qmp` and `-monitor` options can remain as convenience
wrappers, but the low level `-mon` is completed obsoleted by the new
`-object` support with 'monitor-qmp' and 'monitor-hmp' types.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-36-berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Editing accident fixed in qemu-options.hx]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/about/deprecated.rst               | 10 ++++++++++
 docs/devel/writing-monitor-commands.rst |  4 ++--
 docs/system/arm/xenpvh.rst              |  4 ++--
 docs/system/i386/xen.rst                |  3 ++-
 docs/system/i386/xenpvh.rst             |  4 ++--
 system/vl.c                             |  2 ++
 qemu-options.hx                         | 15 +++++++--------
 7 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ef1d7b9ea8..0c656a968f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -61,6 +61,16 @@ The ``debug-threads`` option of the ``-name`` argument is now
 ignored. Thread naming is unconditionally enabled for all platforms
 where it is supported.
 
+``-mon`` option (since 11.1)
+''''''''''''''''''''''''''''
+
+The ``-mon`` option was the generic mechanism for creating monitor
+objects if the convenience ``-qmp`` or ``-monitor`` options were not
+flexible enough. The monitor objects have been converted to QOM, so
+``-mon mode=readline`` is replaced by ``-object monitor-hmp`` and
+``-mon mode=control`` is replaced by ``-object monitor-qmp``. The
+short convenience options are not deprecated, only ``-mon``.
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/docs/devel/writing-monitor-commands.rst b/docs/devel/writing-monitor-commands.rst
index 930da5cd06..7ae7efe327 100644
--- a/docs/devel/writing-monitor-commands.rst
+++ b/docs/devel/writing-monitor-commands.rst
@@ -52,8 +52,8 @@ shown here.
 First, QEMU should be started like this::
 
  # qemu-system-TARGET [...] \
-     -chardev socket,id=qmp,port=4444,host=localhost,server=on \
-     -mon chardev=qmp,mode=control,pretty=on
+     -chardev socket,id=chrqmp0,port=4444,host=localhost,server=on \
+     -object monitor-qmp,chardev=chrqmp0,pretty=on,id=qmp0
 
 Then, in a different terminal::
 
diff --git a/docs/system/arm/xenpvh.rst b/docs/system/arm/xenpvh.rst
index 430ac2c02e..511af63e3d 100644
--- a/docs/system/arm/xenpvh.rst
+++ b/docs/system/arm/xenpvh.rst
@@ -27,9 +27,9 @@ Sample QEMU xenpvh commands for running and connecting with Xen:
 
     qemu-system-aarch64 -xen-domid 1 \
       -chardev socket,id=libxl-cmd,path=qmp-libxl-1,server=on,wait=off \
-      -mon chardev=libxl-cmd,mode=control \
+      -object monitor-qmp,id=qmp0,chardev=libxl-cmd \
       -chardev socket,id=libxenstat-cmd,path=qmp-libxenstat-1,server=on,wait=off \
-      -mon chardev=libxenstat-cmd,mode=control \
+      -object monitor-qmp,id=qmp1,chardev=libxenstat-cmd \
       -xen-attach -name guest0 -vnc none -display none -nographic \
       -machine xenpvh -m 1301 \
       -chardev socket,id=chrtpm,path=tmp/vtpm2/swtpm-sock \
diff --git a/docs/system/i386/xen.rst b/docs/system/i386/xen.rst
index 46db5f34c1..6ff5cdb1e4 100644
--- a/docs/system/i386/xen.rst
+++ b/docs/system/i386/xen.rst
@@ -79,7 +79,8 @@ of type ``xen-console`` to connect to it. For the Xen console equivalent of
 the handy ``-serial mon:stdio`` option, for example:
 
 .. parsed-literal::
-   -chardev stdio,mux=on,id=char0,signal=off -mon char0 \\
+   -chardev stdio,mux=on,id=char0,signal=off \\
+   -object monitor-hmp,chardev=char0,id=hmp0 \\
    -device xen-console,chardev=char0
 
 The Xen network device is ``xen-net-device``, which becomes the default NIC
diff --git a/docs/system/i386/xenpvh.rst b/docs/system/i386/xenpvh.rst
index 354250f073..904778e3f5 100644
--- a/docs/system/i386/xenpvh.rst
+++ b/docs/system/i386/xenpvh.rst
@@ -33,9 +33,9 @@ case you need to construct one manually:
 
     qemu-system-i386 -xen-domid 3 -no-shutdown        \
       -chardev socket,id=libxl-cmd,path=/var/run/xen/qmp-libxl-3,server=on,wait=off \
-      -mon chardev=libxl-cmd,mode=control             \
+      -object monitor-qmp,id=qmp0,chardev=libxl-cmd   \
       -chardev socket,id=libxenstat-cmd,path=/var/run/xen/qmp-libxenstat-3,server=on,wait=off \
-      -mon chardev=libxenstat-cmd,mode=control        \
+      -object monitor-qmp,id=qmp1,chardev=libxenstat-cmd \
       -nodefaults                                     \
       -no-user-config                                 \
       -xen-attach -name g0                            \
diff --git a/system/vl.c b/system/vl.c
index 63bdd06dfa..061cbdf860 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3239,6 +3239,8 @@ void qemu_init(int argc, char **argv)
                 default_monitor = 0;
                 break;
             case QEMU_OPTION_mon:
+                warn_report_once("'-mon' is deprecated, use '-object' with "
+                                 "'monitor-hmp' or 'monitor-qmp' types instead");
                 if (!qemu_opts_parse_noisily(qemu_find_opts("mon"), optarg,
                                              true)) {
                     exit(1);
diff --git a/qemu-options.hx b/qemu-options.hx
index fe76c18c81..308864a185 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4154,7 +4154,7 @@ The general form of a character device option is:
     ::
 
         -chardev stdio,mux=on,id=char0 \
-        -mon chardev=char0,mode=readline \
+        -object monitor-hmp,id=hmp0,chardev=char0 \
         -serial chardev:char0 \
         -serial chardev:char0
 
@@ -4166,7 +4166,7 @@ The general form of a character device option is:
     ::
 
         -chardev stdio,mux=on,id=char0 \
-        -mon chardev=char0,mode=readline \
+        -object monitor-hmp,id=hmp0,chardev=char0 \
         -parallel chardev:char0 \
         -chardev tcp,...,mux=on,id=char1 \
         -serial chardev:char1 \
@@ -5004,12 +5004,12 @@ SRST
 
     enables the QMP monitor on localhost port 4444 with pretty-printing.
 
-    The use of ``-mon mode=readline`` is syntactic sugar
+    The use of ``-mon mode=readline`` is deprecated syntactic sugar
     for the new ``-object monitor-hmp`` option, each use of which
     creates an object with the ID ``compat_monitorNNN`` where ``NNN`` is
     a counter starting from 0.
 
-    The use of ``-mon mode=control`` is syntactic sugar
+    The use of ``-mon mode=control`` is deprecated syntactic sugar
     for the new ``-object monitor-qmp`` option, each use of which
     creates an object with the ID ``compat_monitorNNN`` where ``NNN`` is
     a counter starting from 0.
@@ -5771,8 +5771,7 @@ SRST
         to dynamically delete the monitor at runtime. Note
         that monitors created using the historical syntax
         will be allocated IDs following the pattern ``compat_monmitorNNN``.
-        Mixing ``-object`` with ``-monitor`` and ``-mon`` syntax is
-        discouraged.
+        Mixing ``-object`` with ``-monitor`` syntax is discouraged.
 
         The ``readline`` parameter, which defaults to ``on``,
         controls whether the monitor provides line editing.
@@ -5785,8 +5784,8 @@ SRST
         to dynamically delete the monitor at runtime. Note
         that monitors created using the historical syntax
         will be allocated IDs following the pattern ``compat_monitorNNN``.
-        Mixing ``-object`` with ``-qmp``, ``-qmp-pretty`` and
-        ``-mon`` syntax is discouraged.
+        Mixing ``-object`` with ``-qmp`` and ``-qmp-pretty``
+        syntax is discouraged.
 
         The ``pretty`` parameter, which defaults to ``off``,
         controls whether the monitor responses are pretty
-- 
2.54.0


