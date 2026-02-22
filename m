Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8192BC636B2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASJ-00088z-AG; Sun, 22 Feb 2026 09:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARr-0007yr-2L
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARp-0006fz-3B
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b7jj4bO0BpZFDJlcU0gJFZM3UtLcehjzveNq1sniWtA=;
 b=T2w3YfxxtOLNZAFBdDhaePi3DdnuKy+0ZFjoDSHXwu3yHJcDKYxmuqBV812hjePtZghA2T
 v+Vj4wC73Pbji5JIZ+XCgjwiEL37bcuRf3DmQmbUUC5lW8Ys0qZtOlIcYIY4vUc47gjWoT
 UVQqA2XaCKOIdGbS6c4RtpGUM+M54rw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-9rBL1CbAOaCpCFzAABRvJQ-1; Sun, 22 Feb 2026 09:28:34 -0500
X-MC-Unique: 9rBL1CbAOaCpCFzAABRvJQ-1
X-Mimecast-MFC-AGG-ID: 9rBL1CbAOaCpCFzAABRvJQ_1771770513
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43771113b3bso2858258f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770513; x=1772375313; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b7jj4bO0BpZFDJlcU0gJFZM3UtLcehjzveNq1sniWtA=;
 b=i9MHyynbn3afcGRW4Xd6WrICe8PJ0WKNbvWs76z9+11baRC0sflBibwiEambmyj8Ci
 qOZCTgpr/qNNX+KVCur12RfK/056DbXVb9k751tpxF6zpyGQbo2OPJlH6OorCZctjQgG
 y/VYPZPZiefoRcwr27pek1IaPya5Y7i2uqZqVGS024j3pPpyA9th0gnUX6nQCmhAcedP
 ykqrtHTAopWLr+4jCiprlirXvq+eC+1JrtxNrexNmY3zpWWtpAjf7zhe39iC0X65WSum
 TMlqqHphQ1mqDuKlNJhP03uBItd1Eng45BeFYoWtIP/wh7xgxr8azZCcaRZ+tJBGzGLN
 /Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770513; x=1772375313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7jj4bO0BpZFDJlcU0gJFZM3UtLcehjzveNq1sniWtA=;
 b=j3ca2zLItpzTHZsousM/NfLXkvegOSU6nvJYKl+3IgKF+aCsIPfw/qDzMNgIxi68qN
 ctc5ZBi5YeMvsd4doeoW7QGNE2VOtRmOoNIwMqyPXmkz2FQgtzugXoqLgCfGV9t1qNfb
 zr7++CNaoQyWVqOFC9vvYBsyGNXK2UC3NJTOIRCKTeOUmus9B9WyDB1jQCeZRoPiI0JQ
 wz5sgvcQZeFyqdhEWesfTBHOcuCYPND4+h+d0FudbueJmMs0CakrL2LeyuKVkKfSjWU2
 CPG8xHOYelWHqgdzk/1+aO0iMCW8s4SHZBYodrbp0rb4kgg4AwoLIlsNQS6HtoNa0Go2
 B1KQ==
X-Gm-Message-State: AOJu0YwaePKlVOBfWIJcWxGGRJP55IzJLJ5QFmh46qAsEJx7HFBnM4mA
 t/RcoJ+eV9wExaCEW1U5CAXS6adDLyTtFnTxnHatkf0CAAbHX5TYByDl2T0eRVkznDN2H8gQ0Iv
 zD+BWBj7yblsgoiXC5Ifok97y3/k9al7dwChO+W3TIa4mhZDQpNmNoHTaeZq+1F3jAdesqRILeG
 UBqkPRIZoGMxMItwPEN1Wu9zwze+htOP22Sw==
X-Gm-Gg: AZuq6aKgQGLeQThWIHvM41KmMZYuxJA1CYakxBwaMdMxXqY+nhb2vs6xbFKEhF7KfNf
 6BAYSFeKOP4j2e1zziwPEUMl+2UqsaZGZLtaZVEqzCbXH7HJo0KZ4mbfzvaHAPSeZOZ+vF0ZbJS
 q5n5zJeSDqRpNNmVyiouU075I1/RgOh/irg9+0zz0Z+i4ajaBDSy4phDNmwkNfbO6nparhcrEQI
 0vOakk2CbR73q5mVb8Rz6UPzxBeOd4ctOhJcnMQiLNj25EpwMwFK6r4LBnhQmyrRmikFCfZWTov
 IyWTY3Jht2ADIqV97is/E1xXOoDGVT+VWzKq5CzFA6S9P67rxDeMCI98MZaLid/MZrdlIw9kgS5
 4JuyA3TlEXIPeEnDbYXVgvb3a3UL53XG0cBq2nYemgcbbSQ==
X-Received: by 2002:a5d:64e5:0:b0:435:e47b:e746 with SMTP id
 ffacd0b85a97d-4396f17a9c6mr10329178f8f.36.1771770513036; 
 Sun, 22 Feb 2026 06:28:33 -0800 (PST)
X-Received: by 2002:a5d:64e5:0:b0:435:e47b:e746 with SMTP id
 ffacd0b85a97d-4396f17a9c6mr10329133f8f.36.1771770512396; 
 Sun, 22 Feb 2026 06:28:32 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bfa001sm13095460f8f.2.2026.02.22.06.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:31 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Eric Blake <eblake@redhat.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 07/33] qapi: cxl: Refactor CXL event injection for common
 commands arguments
Message-ID: <2fc064e23ecb1e83c26c7146aaa71ca5adec573e.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Shiju Jose <shiju.jose@huawei.com>

Refactor CXL event injection to use struct for common command
arguments.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260205112350.60681-2-Jonathan.Cameron@huawei.com>
---
 qapi/cxl.json | 89 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 31 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index eeddb58d1d..55a088586e 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -31,11 +31,10 @@
  }
 
 ##
-# @cxl-inject-general-media-event:
+# @CXLCommonEventBase:
 #
-# Inject an event record for a General Media Event (CXL r3.0
-# 8.2.9.2.1.1).  This event type is reported via one of the event logs
-# specified via the log parameter.
+# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
+# Table 8-42 Common Event Record Format).
 #
 # @path: CXL type 3 device canonical QOM path
 #
@@ -44,6 +43,16 @@
 # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
 #     Record Format, Event Record Flags for subfield definitions.
 #
+# Since: 8.1
+##
+{ 'struct': 'CXLCommonEventBase',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
+
+##
+# @CXLGeneralMediaEvent:
+#
+# Event record for a General Media Event (CXL r3.0 8.2.9.2.1.1).
+#
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
 #     Media Event Record, Physical Address.
@@ -74,26 +83,29 @@
 #
 # Since: 8.1
 ##
-{ 'command': 'cxl-inject-general-media-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
-            'dpa': 'uint64', 'descriptor': 'uint8',
+{ 'struct': 'CXLGeneralMediaEvent',
+  'base': 'CXLCommonEventBase',
+  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8',
             '*device': 'uint32', '*component-id': 'str' } }
 
 ##
-# @cxl-inject-dram-event:
+# @cxl-inject-general-media-event:
 #
-# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
-# This event type is reported via one of the event logs specified via
-# the log parameter.
+# Inject an event record for a General Media Event (CXL r3.0
+# 8.2.9.2.1.1).  This event type is reported via one of the event
+# logs specified via the log parameter.
 #
-# @path: CXL type 3 device canonical QOM path
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-general-media-event',
+  'data': 'CXLGeneralMediaEvent' }
+
+##
+# @CXLDRAMEvent:
 #
-# @log: Event log to add the event to
-#
-# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
-#     Record Format, Event Record Flags for subfield definitions.
+# Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
@@ -133,9 +145,9 @@
 #
 # Since: 8.1
 ##
-{ 'command': 'cxl-inject-dram-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
-            'dpa': 'uint64', 'descriptor': 'uint8',
+{ 'struct': 'CXLDRAMEvent',
+  'base': 'CXLCommonEventBase',
+  'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
             '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
@@ -143,18 +155,21 @@
            }}
 
 ##
-# @cxl-inject-memory-module-event:
+# @cxl-inject-dram-event:
 #
-# Inject an event record for a Memory Module Event (CXL r3.0
-# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
-# at the time of the event.
+# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
+# This event type is reported via one of the event logs
+# specified via the log parameter.
 #
-# @path: CXL type 3 device canonical QOM path
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-dram-event',
+  'data': 'CXLDRAMEvent' }
+
+##
+# @CXLMemModuleEvent:
 #
-# @log: Event Log to add the event to
-#
-# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
-#     Record Format, Event Record Flags for subfield definitions.
+# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
 #
 # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
 #     Event Record for bit definitions for bit definiions.
@@ -185,9 +200,9 @@
 #
 # Since: 8.1
 ##
-{ 'command': 'cxl-inject-memory-module-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
-            'type': 'uint8', 'health-status': 'uint8',
+{ 'struct': 'CXLMemModuleEvent',
+  'base': 'CXLCommonEventBase',
+  'data': { 'type': 'uint8', 'health-status': 'uint8',
             'media-status': 'uint8', 'additional-status': 'uint8',
             'life-used': 'uint8', 'temperature' : 'int16',
             'dirty-shutdown-count': 'uint32',
@@ -195,6 +210,18 @@
             'corrected-persistent-error-count': 'uint32'
             }}
 
+##
+# @cxl-inject-memory-module-event:
+#
+# Inject an event record for a Memory Module Event (CXL r3.0
+# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
+# at the time of the event.
+#
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-memory-module-event',
+  'data': 'CXLMemModuleEvent' }
+
 ##
 # @cxl-inject-poison:
 #
-- 
MST


