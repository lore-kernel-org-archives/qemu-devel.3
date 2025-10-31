Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399BBCCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElk7-0000V6-Ut; Fri, 31 Oct 2025 05:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEljx-0000TG-3A
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEljo-0006hg-OV
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761904081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ravWWZiOxa4lutq++HRMkeIF4/f8evIpnDEuRs0+ME=;
 b=FguEO10CGAwzNACD9+OnmwrN7CL9NVMydZyv17EymWsxjDxI2MLbwpfS4RgGpU2KsnmbrU
 QiACP+g3aHW2gjLnS7ywhfSmYmYy1UWT5OPAaUoPLhhAXHpWVChSkxlkaMBY0Hma4R7+vc
 uw8xdrocc1uDcuHZWBSnxNQXWi4OIY4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-i1AgH3hUPdig-FdQ1bwQKw-1; Fri,
 31 Oct 2025 05:47:58 -0400
X-MC-Unique: i1AgH3hUPdig-FdQ1bwQKw-1
X-Mimecast-MFC-AGG-ID: i1AgH3hUPdig-FdQ1bwQKw_1761904077
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 606081953989; Fri, 31 Oct 2025 09:47:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12BCC1955BE3; Fri, 31 Oct 2025 09:47:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D2D821E6774; Fri, 31 Oct 2025 10:47:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, philmd@linaro.org,
 kchamart@redhat.com, mst@redhat.com, sgarzare@redhat.com
Subject: [PATCH 5/8] qga/qapi-schema: Clean up whitespace between definitions
Date: Fri, 31 Oct 2025 10:47:48 +0100
Message-ID: <20251031094751.2817932-6-armbru@redhat.com>
In-Reply-To: <20251031094751.2817932-1-armbru@redhat.com>
References: <20251031094751.2817932-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Consistently separate definitions with a single blank line.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index af75f12a28..5791b49dde 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -197,6 +197,7 @@
 { 'struct': 'GuestAgentInfo',
   'data': { 'version': 'str',
             'supported_commands': ['GuestAgentCommandInfo'] } }
+
 ##
 # @guest-info:
 #
@@ -322,7 +323,6 @@
   'data':    { 'handle': 'int', 'buf-b64': 'str', '*count': 'int' },
   'returns': 'GuestFileWrite' }
 
-
 ##
 # @GuestFileSeek:
 #
@@ -876,7 +876,6 @@
             'sas', 'mmc', 'virtual', 'file-backed-virtual', 'nvme' ],
   'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
-
 ##
 # @GuestPCIAddress:
 #
@@ -1276,6 +1275,7 @@
   'data': { 'exited': 'bool', '*exitcode': 'int', '*signal': 'int',
             '*out-data': 'str', '*err-data': 'str',
             '*out-truncated': 'bool', '*err-truncated': 'bool' }}
+
 ##
 # @guest-exec-status:
 #
@@ -1365,7 +1365,6 @@
                '*input-data': 'str', '*capture-output': 'GuestExecCaptureOutput' },
   'returns': 'GuestExec' }
 
-
 ##
 # @GuestHostName:
 #
@@ -1392,7 +1391,6 @@
 { 'command': 'guest-get-host-name',
   'returns': 'GuestHostName' }
 
-
 ##
 # @GuestUser:
 #
@@ -1763,7 +1761,6 @@
   'data': [ 'linux' ],
   'if': 'CONFIG_LINUX' }
 
-
 ##
 # @GuestLinuxCpuStats:
 #
@@ -1838,7 +1835,6 @@
   'if': 'CONFIG_LINUX'
 }
 
-
 ##
 # @GuestLoadAverage:
 #
@@ -1921,7 +1917,6 @@
 # @version: IP version (4 or 6)
 #
 # Since: 9.1
-
 ##
 { 'struct': 'GuestNetworkRoute',
   'data': {'iface': 'str',
-- 
2.49.0


