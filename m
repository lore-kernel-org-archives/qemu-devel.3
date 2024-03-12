Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660CAC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAdI-0005O2-5O; Tue, 12 Mar 2024 18:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcY-0002vl-OO
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcU-0004eN-F7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2oYq0iZXaQr5DMI6kVH19Up4p/ecK9SPws94ZnuK5Hw=;
 b=Wxlq23ngghDveUN5llanCGgTuJ40glV6WazUDlpNlyRloGyR0hLFsXSifN5H/chFlwmNwt
 nQIruKlT1pQGbJ8mOv3iaX+g3tW1B9aBBH9fVF3iOMJ+WLL03AwFBy5z/AoGo3L8SUYhjn
 Z6gGUflS5o4Zam4V/g+/Q+WxbizAm04=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-asIaeoxHNsqQv5wm1YCzMA-1; Tue, 12 Mar 2024 18:29:10 -0400
X-MC-Unique: asIaeoxHNsqQv5wm1YCzMA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a44143c8908so28013366b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282548; x=1710887348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oYq0iZXaQr5DMI6kVH19Up4p/ecK9SPws94ZnuK5Hw=;
 b=e4/5gVMN0ecta4M6klHfdVCCraMmVe2mzWIJaF+CWrWRfFGTeN9cYKGizOFuVIDw1B
 t/duJZo3ccDFLN8te7ciQrAJgfg+B1xv4mrGXe6yua5ebiaCfT9nQDOArhqG19lokyCQ
 3BbgW5NhKnzb35D+lhlHFXA1Ire4FCxS4UqT4u6qYeMWAgV9lYfXjmmfGCJphWpHjznT
 HhRQguyYp3tnGHNbYx23NmV94nRb70fnyYPgMpK7tJiOelVHg9oq4EToVhz3M/E0nIqQ
 KHEsAZoTXn66KmjPPWBxh5RWx6iqZpnlhW2bu+kZbG1O6mSAIcRT1IwI5St7FGYZeo0D
 /yTQ==
X-Gm-Message-State: AOJu0YyC+Ipq/jDddud5aQVLRf7Yql1umhlqmSsvT+BfmoJzgqvLrs1q
 6PvfWf4XaOTxNWnl5KK3aIL3azidLrpmBDBXLRtMtlY2dhZGSUZM1JymyIw1AwhmxpF2RQA3glL
 5gOo7KxntbFATmD2MoMdzECMREq4+bVpRF/PlE8BXIiD7NfPWGVoWqU+QM7ako5yQ1xiZr8z5p7
 LxPrLzOvlyifCUTq0Lj24WYM7K/rBGcU6I
X-Received: by 2002:a17:906:c00a:b0:a46:4fc1:c9fe with SMTP id
 e10-20020a170906c00a00b00a464fc1c9femr688800ejz.27.1710282548395; 
 Tue, 12 Mar 2024 15:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsCZTemK7QdO83y+cy6XCnKxRfZWuO0Db+MI2RJ4EjaTptmWAseH4bdsysjaZg3Xa0Jp441Q==
X-Received: by 2002:a17:906:c00a:b0:a46:4fc1:c9fe with SMTP id
 e10-20020a170906c00a00b00a464fc1c9femr688769ejz.27.1710282547683; 
 Tue, 12 Mar 2024 15:29:07 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 kn22-20020a170906aa5600b00a45200fe2b5sm4242271ejb.224.2024.03.12.15.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:29:07 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:29:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 66/68] hmat acpi: Fix out of bounds access due to missing use
 of indirection
Message-ID: <74e2845c5f95b0c139c79233ddb65bb17f2dd679.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

With a numa set up such as

-numa nodeid=0,cpus=0 \
-numa nodeid=1,memdev=mem \
-numa nodeid=2,cpus=1

and appropriate hmat_lb entries the initiator list is correctly
computed and writen to HMAT as 0,2 but then the LB data is accessed
using the node id (here 2), landing outside the entry_list array.

Stash the reverse lookup when writing the initiator list and use
it to get the correct array index index.

Fixes: 4586a2cb83 ("hmat acpi: Build System Locality Latency and Bandwidth Information Structure(s)")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240307160326.31570-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/hmat.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 8ea240878a..9b1662b6b8 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -78,6 +78,7 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
                           uint32_t *initiator_list)
 {
     int i, index;
+    uint32_t initiator_to_index[MAX_NODES] = {};
     HMAT_LB_Data *lb_data;
     uint16_t *entry_list;
     uint32_t base;
@@ -121,6 +122,8 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
     /* Initiator Proximity Domain List */
     for (i = 0; i < num_initiator; i++) {
         build_append_int_noprefix(table_data, initiator_list[i], 4);
+        /* Reverse mapping for array possitions */
+        initiator_to_index[initiator_list[i]] = i;
     }
 
     /* Target Proximity Domain List */
@@ -132,7 +135,8 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
     entry_list = g_new0(uint16_t, num_initiator * num_target);
     for (i = 0; i < hmat_lb->list->len; i++) {
         lb_data = &g_array_index(hmat_lb->list, HMAT_LB_Data, i);
-        index = lb_data->initiator * num_target + lb_data->target;
+        index = initiator_to_index[lb_data->initiator] * num_target +
+            lb_data->target;
 
         entry_list[index] = (uint16_t)(lb_data->data / hmat_lb->base);
     }
-- 
MST


