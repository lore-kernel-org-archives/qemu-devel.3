Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB91CF319D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuXI-0002DA-IJ; Wed, 02 Oct 2024 04:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svuXD-0002Ak-Iq
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svuXC-0003Na-3M
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727856993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=rYSzMLOBDbK4xiiZMnTWN61Ub1XZ6GpP/VUM53Uqutc=;
 b=C6GVqjOGRGSGgDqjIYHxUACorWNP4xjth2NBaOKecvniGsvf9YI3tW/ISBzI+ML7xLKiwV
 Es3XyiXlDG5FWh0H273BkWh/PHQI8ywh/VvwzQ0zY5Qj+bRKWQmUtRcpameKOeYayLKSy6
 IPUUOzYrFTdzLK/byJ4s/FP6YDQHBkY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-_0EpANRAN8yIg-yKStShnQ-1; Wed,
 02 Oct 2024 04:16:30 -0400
X-MC-Unique: _0EpANRAN8yIg-yKStShnQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C82F1955F35; Wed,  2 Oct 2024 08:16:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA45A19560A2; Wed,  2 Oct 2024 08:16:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A43421E6A28; Wed,  2 Oct 2024 10:16:26 +0200 (CEST)
Resent-To: peter.maydell@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Wed, 02 Oct 2024 10:16:26 +0200
Resent-Message-ID: <87ploi6ht1.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Wed Oct  2 09:44:04 2024
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E3F6021E6891; Wed,  2 Oct 2024 09:44:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/10] qapi/rocker: Supply missing member documentation
Date: Wed,  2 Oct 2024 09:44:00 +0200
Message-ID: <20241002074404.1983368-7-armbru@redhat.com>
In-Reply-To: <20241002074404.1983368-1-armbru@redhat.com>
References: <20241002074404.1983368-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since we neglect to document the argument of query-rocker and
query-rocker-ports, their description in the QEMU QMP Reference manual
is "Not documented".  Fix that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240911112545.2248881-7-armbru@redhat.com>
---
 qapi/pragma.json | 4 +---
 qapi/rocker.json | 4 ++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/qapi/pragma.json b/qapi/pragma.json
index baeae5bf52..feb7981700 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -78,9 +78,7 @@
         'X86CPURegister32',
         'XDbgBlockGraph',
         'YankInstanceType',
-        'blockdev-reopen',
-        'query-rocker',
-        'query-rocker-ports' ],
+        'blockdev-reopen' ],
     # Externally visible types whose member names may use uppercase
     'member-name-exceptions': [     # visible in:
         'ACPISlotType',             # query-acpi-ospm-status
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 73c7363b16..51aa5b4930 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -26,6 +26,8 @@
 #
 # Return rocker switch information.
 #
+# @name: switch name
+#
 # Returns: @Rocker information
 #
 # Since: 2.4
@@ -94,6 +96,8 @@
 #
 # Return rocker switch port information.
 #
+# @name: port name
+#
 # Returns: a list of @RockerPort information
 #
 # Since: 2.4
-- 
2.46.0



