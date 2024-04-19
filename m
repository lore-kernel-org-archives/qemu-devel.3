Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345ACC05023
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1Z-0007eZ-4c; Fri, 19 Apr 2024 00:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1P-0007W8-Vo
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1N-0004FC-C0
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h9ivFynH+DrIyxyCrgkjda0tH5zkdVzYPlc+LqwrpBU=;
 b=YQJhgU9r0EVfzxFvVgDMx25Cb2sboJA/Xo4aElzHw0+2gsreFYWnOcqBB/prtYCHuSN2yO
 9hOUx2XlFDW2rAAPKoUXYNN5y9Y5XmJ2UOf8ed63r4OiweOXPVjU0mS1R1QDn9HFViCzfE
 1dbgKtF9Y/nDJ69K9JUa6TSXBmaMIpI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-SWjDAIYJOgWopWUA_tmK-g-1; Fri,
 19 Apr 2024 00:38:41 -0400
X-MC-Unique: SWjDAIYJOgWopWUA_tmK-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EBD63CBDF61;
 Fri, 19 Apr 2024 04:38:41 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F8614011FF7;
 Fri, 19 Apr 2024 04:38:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 26/27] docs/qapi-domain: RFC patch - Add one last sample
 command
Date: Fri, 19 Apr 2024 00:38:14 -0400
Message-ID: <20240419043820.178731-27-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Just to have a bit more to look at in the generated doc, here's a fairly
complex command with a lot of bells and whistles.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst | 67 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index 6e85ea5280d..4562e755d21 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -267,6 +267,73 @@ Explicit cross-referencing syntax for QAPI modules is available with
       :memb str key-secret: ID of a QCryptoSecret object providing a
          passphrase for unlocking the encryption
 
+.. qapi:command:: blockdev-backup
+   :since: 4.2
+
+   Start a point-in-time copy of a block device to a new
+   destination. The status of ongoing blockdev-backup operations can be
+   checked with query-block-jobs where the BlockJobInfo.type field has
+   the value ‘backup’. The operation can be stopped before it has
+   completed using the block-job-cancel command.
+
+   :arg str target:
+      the device name or node-name of the backup target node.
+   :arg str? job-id:
+      identifier for the newly-created block job. If omitted, the device
+      name will be used. (Since 2.7)
+   :arg str device:
+      the device name or node-name of a root node which should be copied.
+   :arg MirrorSyncMode sync:
+      what parts of the disk image should be copied to the destination
+      (all the disk, only the sectors allocated in the topmost image,
+      from a dirty bitmap, or only new I/O).
+   :arg int? speed:
+      the maximum speed, in bytes per second. The default is 0, for unlimited.
+   :arg str? bitmap:
+      The name of a dirty bitmap to use. Must be present if sync is
+      ``bitmap`` or ``incremental``. Can be present if sync is ``full`` or
+      ``top``. Must not be present otherwise. (Since 2.4 (drive-backup),
+      3.1 (blockdev-backup))
+   :arg BitmapSyncMode? bitmap-mode:
+      Specifies the type of data the bitmap should contain after the
+      operation concludes. Must be present if a bitmap was provided,
+      Must NOT be present otherwise. (Since 4.2)
+   :arg bool? compress:
+      true to compress data, if the target format supports it. (default:
+      false) (since 2.8)
+   :arg BlockdevOnError? on-source-error:
+      the action to take on an error on the source, default
+      ``report``. ``stop`` and ``enospc`` can only be used if the block device
+      supports io-status (see BlockInfo).
+   :arg BlockdevOnError? on-target-error:
+      the action to take on an error on the target, default ``report`` (no
+      limitations, since this applies to a different block device than
+      device).
+   :arg bool? auto-finalize:
+      When false, this job will wait in a ``PENDING`` state after it has
+      finished its work, waiting for block-job-finalize before making
+      any block graph changes. When true, this job will automatically
+      perform its abort or commit actions. Defaults to true. (Since
+      2.12)
+   :arg bool? auto-dismiss:
+      When false, this job will wait in a ``CONCLUDED`` state after it has
+      completely ceased all work, and awaits block-job-dismiss. When
+      true, this job will automatically disappear from the query list
+      without user intervention. Defaults to true. (Since 2.12)
+   :arg str? filter-node-name:
+      the node name that should be assigned to the filter driver that
+      the backup job inserts into the graph above node specified by
+      drive. If this option is not given, a node name is
+      autogenerated. (Since: 4.2)
+   :arg BackupPerf? x-perf:
+      Performance options. (Since 6.0)
+   :feat unstable: Member ``x-perf`` is experimental.
+   :error DeviceNotFound: if ``device`` is not a valid block device.
+
+   .. note:: ``on-source-error`` and ``on-target-error only`` affect
+             background I/O. If an error occurs during a guest write
+             request, the device's rerror/werror actions will be used.
+
 .. qapi:command:: x-debug-query-block-graph
    :since: 4.0
    :unstable:
-- 
2.44.0


