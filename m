Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E52C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFfr-0002PF-Kj; Mon, 18 Mar 2024 12:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfq-0002OQ-LK
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfp-0004rf-8r
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UeZ5d5rzVIIFteQdA/cbu9zu3ciyKvxSa3RVrtkb9L4=;
 b=bCvpnqFjD3khaVKUKv8QYbGRBeIVrGM2X3QWlJpnXFKb/URbDXisxBUL5eGriaSOfyYgnZ
 AFM1Coo0shv26gOzsc8D6XQODohBewnqBukkWzlraitmDxhC4i49rC40SvzUNdHlkhFqQM
 sld8Nj1YcEY7nhB4VHiB+rmG0zq8zMI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-bk3MCaTgMmC4njHIIivwMg-1; Mon, 18 Mar 2024 12:17:15 -0400
X-MC-Unique: bk3MCaTgMmC4njHIIivwMg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29c7932c5f5so3232638a91.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778631; x=1711383431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeZ5d5rzVIIFteQdA/cbu9zu3ciyKvxSa3RVrtkb9L4=;
 b=F90xzUmLuFq0igMpuroZA6DJGKOnxmtIkF9r6RoNrIrXhS8980ciyRxl7NPL8cNArv
 kmwdgM6l/s5Pi48pGa5TUEppZq1hXt+3opCX+tdSRbK/vVzkXH0U1yiEsRyL/SHyUDLf
 QA6nJf5AOydW6TTjcB0aeGp/C0X9kJ+aFUFpRK1vZNssuIYlu+YxF/053o2FS42qvt8K
 I8AYJJYkEbfJV0/9V/isoWSVscGeLXWtqf73ak83657wnp/p7bq16RzcBV+gte2GRLVZ
 ++VagMBOr73mBTAReo2vuOmqv3VyzswADIBFx5D1Y8kTGIXC8TuhtygAlVs72CtRBk4L
 5gIQ==
X-Gm-Message-State: AOJu0YwcZCLLrTrYKS1a7seesr1hxwpeCyMC7ROPvvpy1x9AIYf2GsQh
 bbcxP4WPQbHI9K2hezqaXKmY5B1E90P/RXJzbLM8SQee1jd2AAbPwiIAPdlfUmYMB/Vj9ClVj9h
 NzuKrWMjMcUcVdji3IcTLp2bw9Lk+imQRYGo9I+J9K1FJ3jIC+SROcxJ+v7G5K++wyruFeoBbyO
 5qDqeMp/QghzDU6/cPqBXq4VP36+m1+w==
X-Received: by 2002:a17:90a:d70f:b0:29f:76d4:306a with SMTP id
 y15-20020a17090ad70f00b0029f76d4306amr95136pju.24.1710778630841; 
 Mon, 18 Mar 2024 09:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF5MzdmXdTDIjt9SelZTOOy/8UTPKC7Mtw7+npeEpjgginsbYIssEdKu1ldBGXCEMzfMgLbQ==
X-Received: by 2002:a17:90a:d70f:b0:29f:76d4:306a with SMTP id
 y15-20020a17090ad70f00b0029f76d4306amr95087pju.24.1710778630185; 
 Mon, 18 Mar 2024 09:17:10 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 v10-20020a17090ac90a00b0029be7922b32sm7959526pjt.26.2024.03.18.09.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:17:09 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:17:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 24/24] smbios: add extra comments to smbios_get_table_legacy()
Message-ID: <bb949df637bdb6136a9acca55a2371fe1721e109.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240314152302.2324164-22-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


