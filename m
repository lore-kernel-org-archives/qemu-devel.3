Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F6CC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmvo-0007kk-R0; Thu, 14 Mar 2024 11:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkmvf-0007Or-BU
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkmvd-0003pn-Vt
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710429813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/iWXzpJZUXtfLmGV6M1GFERR/EHeCy/7kY6x+sNACw=;
 b=KrBcpc7W5bHIt3RN5R3zqckkCOPKSGW6Hm9qOrq46AFRBdBXSd3Ro4jAxwTMGZmPIENna6
 iItO2hASi7Mlyz/LJFi5lil+vZncWNsManbR4ZqOVkOCurNdaSNqeoU0L5GNAooUZfNUAP
 IpTRxyoFc++IArzK8/Y32m8U38hZlHY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-Qo5NxH6GMOSUe8utAKX8gA-1; Thu, 14 Mar 2024 11:23:27 -0400
X-MC-Unique: Qo5NxH6GMOSUe8utAKX8gA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E08CA879848
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 15:23:26 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40D2917A8E;
 Thu, 14 Mar 2024 15:23:26 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com
Subject: [PATCH v4 21/21] smbios: add extra comments to
 smbios_get_table_legacy()
Date: Thu, 14 Mar 2024 16:23:02 +0100
Message-Id: <20240314152302.2324164-22-imammedo@redhat.com>
In-Reply-To: <20240314152302.2324164-1-imammedo@redhat.com>
References: <20240314152302.2324164-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/smbios/smbios_legacy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/smbios/smbios_legacy.c b/hw/smbios/smbios_legacy.c
index 06907cd16c..c37a8ee821 100644
--- a/hw/smbios/smbios_legacy.c
+++ b/hw/smbios/smbios_legacy.c
@@ -151,6 +151,9 @@ uint8_t *smbios_get_table_legacy(size_t *length, Error **errp)
     smbios_entries_len = sizeof(uint16_t);
     smbios_entries = g_malloc0(smbios_entries_len);
 
+    /*
+     * build a set of legacy smbios_table entries using user provided blobs
+     */
     for (i = 0, usr_offset = 0; usr_blobs_sizes && i < usr_blobs_sizes->len;
          i++)
     {
@@ -166,6 +169,10 @@ uint8_t *smbios_get_table_legacy(size_t *length, Error **errp)
         table->header.length = cpu_to_le16(sizeof(*table) + size);
         memcpy(table->data, header, size);
         smbios_entries_len += sizeof(*table) + size;
+        /*
+         * update number of entries in the blob,
+         * see SeaBIOS: qemu_cfg_legacy():QEMU_CFG_SMBIOS_ENTRIES
+         */
         (*(uint16_t *)smbios_entries) =
             cpu_to_le16(le16_to_cpu(*(uint16_t *)smbios_entries) + 1);
         usr_offset += size;
-- 
2.39.3


