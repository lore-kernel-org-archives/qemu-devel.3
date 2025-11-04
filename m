Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45975CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGzJ-0000J4-VL; Tue, 04 Nov 2025 08:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGyg-0000Cw-G7
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGye-0001Ww-PQ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762262496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEjsiJUR3IW2fClyBWzINCX8K7QYD6PAV5LINe/Gku4=;
 b=Kml9GZ4q3vd5p2CHEScUgZ1e2EER52ynniHjhZd2z8gejzJcBgNNx4/RtOjiNo1dMGt557
 OZviyyMti6gwf9at8pw7kFNcO+f5t0NiKp22WZeJT3ZIXjzWcnFnvd0wukVIk/w6pjQa5i
 +S7UyExoZHah6OcBdKSLoyRXOGY0hjo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-A444AZ6WMyOn-25uWjK-0Q-1; Tue,
 04 Nov 2025 08:21:32 -0500
X-MC-Unique: A444AZ6WMyOn-25uWjK-0Q-1
X-Mimecast-MFC-AGG-ID: A444AZ6WMyOn-25uWjK-0Q_1762262491
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE31118002C9; Tue,  4 Nov 2025 13:21:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 323E7180044F; Tue,  4 Nov 2025 13:21:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 797F021E6775; Tue, 04 Nov 2025 14:21:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 07/12] qga/qapi-schema: Clean up whitespace between definitions
Date: Tue,  4 Nov 2025 14:21:20 +0100
Message-ID: <20251104132125.4134730-8-armbru@redhat.com>
In-Reply-To: <20251104132125.4134730-1-armbru@redhat.com>
References: <20251104132125.4134730-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20251103082354.3273027-6-armbru@redhat.com>
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


