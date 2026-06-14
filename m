Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57673CD98DE
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDX-0000pK-MT; Sun, 14 Jun 2026 15:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDU-0000UB-Sb
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDT-0002lU-7l
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bem3v21HI3Dj2XGuqU+Zt2bWvI5Rs5lCN0w9V2Qfknw=;
 b=JuNqvZbSQZkwX6xWhDvJE9zxrvgkUSg7zTPRJa8TGjEIS6qvfdhxohSoFlFi1qNel5XN2A
 RpGlq1oA/gpqtMgr2ZrCZt1LH2QNjCrs2kY4sgx2rgBN5Tak2bcAE68NMwv3yzJEbJQNR6
 EiNFFSZWHkfOpOwjr/mfQDqk1I8Ffuw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-nRQMV8OMM56dpu1XhhZcMQ-1; Sun, 14 Jun 2026 15:09:53 -0400
X-MC-Unique: nRQMV8OMM56dpu1XhhZcMQ-1
X-Mimecast-MFC-AGG-ID: nRQMV8OMM56dpu1XhhZcMQ_1781464192
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef9437b7aso1475682f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464192; x=1782068992; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bem3v21HI3Dj2XGuqU+Zt2bWvI5Rs5lCN0w9V2Qfknw=;
 b=CHGoJwH3YB0V+INUkpZeqKA5EFtBSIFOTBuzc+FM8CSF+4fnPMe7ifMj7nTpocEnpB
 DE1HeqKR6Yy0MQITjmQ8xUJ114GQdfYMLDmCWRm8+jaCQmcJKocI8R/zfjqiRM1igBvO
 L3LlRyQS9t5ezUU3ASftO7+2/+ORWj20bbP2wqtCZtqvR21w6f0q2cywAEM0gm4CG8pa
 6XUWfcv8iG4ClVZw2YdTh2dmZxftJlI9Njf+oE/XjA4W44e3OxLHL66fwInaQ1Gqg62j
 Shvg73JeJLMu/878Gr9bJ27k+9whH9MFELDSHzmd6pA8m8Jl66RV46OhJue7ywcHf/Yc
 Bgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464192; x=1782068992;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bem3v21HI3Dj2XGuqU+Zt2bWvI5Rs5lCN0w9V2Qfknw=;
 b=DZI8QpX1wDdKRsWk35BZSFGBozu931XyPs5SKvoOOrxtsyZ0FnC9H1yMt2uaZGij0e
 HtrniJTPjO+ts1fG5Nt1K409CX5d/MG0E4HyMsNsbFDMY0W2xLxr0ww2898NArqC4trH
 uqQMMT/yHDcfRr/q4mvrxtgpB8imgpwlj32zSF8SG+NyHoVL2M/Q5FvKN2WbQJ7vaJFx
 kOYIOzGWvaDUQ/GwD79bE88zyygaKeepcjHlE/WNMEJ7WGNqO3nN9XpgzvA2i0e2Ayib
 Oh866A1B1S1sIUYsTMOyzHGOLB0QgV3PIxMrgcUvATvDN88Q9CuY4e93RHmR1LEULrEW
 V2HA==
X-Gm-Message-State: AOJu0Yy+7wqA+mj7q0blXjfvmqP9ynZiXm8qRqHe7P5U6raUmkkimSW+
 nqaQvRQP3S+qK/86ZWnVVc9uPeEmL3TPy9hr8iq3uBYp13tizISj/ppg1qIwNr/J1kNFWdGJAvZ
 S4r5pg40YU93BCSjqLqfQrIX/DYrYlK4kSTu17bPEGXN5l44rNuVBTVO9yopXJxPwKDtVV+Sm1N
 exVPlh45OhW7fEAMAOBZmbxPrY1GNSezmDzg==
X-Gm-Gg: Acq92OHCwY+n0A5CeIpEoCXnLkds4GgagZimCVidIep8H7AcE5/Rncj1+Xgf+iZ4BRJ
 uWq9tW5L2KWTksyscL0Bf6gT2TbKZMO4a/OEZGJlAF683lUDFrZ4do6qnvdGPzcPV1Ggw/evklj
 aUyUdCRaWbV2TZXFa6tFB1TNf3vlTcfwMRHG8u04rGQCV+D2Rhq7MJJVlgx6vsuE4f0jFmXqHFK
 0vO2CRHRz3fZDZIMcLdfMkEBg/0Aq8rJ/6orttHrUFgQQ/3UfFTY5D1V1vWw4XXc9DLS83Oy/F9
 Y/yUIWz6zeXnAOBbMCFrISkjGF5jew/zWRe4PoPTk0P3FHLx3P0hLjFwZosYKxaV5gXjPa794fi
 aQDw0v2S9icpKPdpayBzmDd3XJpdDnrmiKya2Ls45m9w=
X-Received: by 2002:a5d:5f44:0:b0:460:1c5b:f25f with SMTP id
 ffacd0b85a97d-4606db96c29mr16507321f8f.20.1781464192015; 
 Sun, 14 Jun 2026 12:09:52 -0700 (PDT)
X-Received: by 2002:a5d:5f44:0:b0:460:1c5b:f25f with SMTP id
 ffacd0b85a97d-4606db96c29mr16507276f8f.20.1781464191434; 
 Sun, 14 Jun 2026 12:09:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b1056sm27207478f8f.18.2026.06.14.12.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:51 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 099/106] hw/cxl: Fix handling of component ID to not assume it
 is a string
Message-ID: <91beb27a4851fe47fe68a5f715af5db456b9d37d.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add following fixes,
1. Coverity reports a warning (CID 1645325) for use of strncpy() in
handling of component ID. In cxl_create_mem_sparing_event_records(),
fix handling of component ID to not assume it is a string by replacing
strncpy with memcpy to solve this warning and copy the entire component
ID data, which is 16 bytes.

2. In cxl_maintenance_insert(),
 - replace strncpy with memcpy to copy full data because component ID,
   which is 16 bytes data.
 - remove memset which is not required.

Closes ("https://lore.kernel.org/qemu-devel/CAFEAcA_CsVe4TUVm3o_-BA4hXvi2xAThGX5T97amgTQKW_kiYA@mail.gmail.com/")

Fixes: 5e5a86bab830("hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260306101423.986-2-shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 4 ++--
 hw/mem/cxl_type3.c         | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8ba7e8625..6b16cc206f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1994,8 +1994,8 @@ static void cxl_create_mem_sparing_event_records(CXLType3Dev *ct3d,
         stw_le_p(&event_rec.column, ent->column);
         event_rec.sub_channel = ent->sub_channel;
         if (ent->validity_flags & CXL_MSER_VALID_COMP_ID) {
-            strncpy((char *)event_rec.component_id, (char *)ent->component_id,
-                    sizeof(event_rec.component_id));
+            memcpy(event_rec.component_id, ent->component_id,
+                   sizeof(event_rec.component_id));
         }
     } else if (sparing_pi) {
         event_rec.flags = CXL_MSER_FLAGS_QUERY_RESOURCES;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4739239da3..3cb1096e16 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1767,7 +1767,6 @@ static void cxl_maintenance_insert(CXLType3Dev *ct3d, uint64_t dpa,
         }
     }
     m = g_new0(CXLMaintenance, 1);
-    memset(m, 0, sizeof(*m));
     m->dpa = dpa;
     m->validity_flags = 0;
 
@@ -1804,8 +1803,7 @@ static void cxl_maintenance_insert(CXLType3Dev *ct3d, uint64_t dpa,
         m->validity_flags |= CXL_MSER_VALID_SUB_CHANNEL;
     }
     if (component_id) {
-        strncpy((char *)m->component_id, component_id,
-                sizeof(m->component_id) - 1);
+        memcpy(m->component_id, component_id, sizeof(m->component_id));
         m->validity_flags |= CXL_MSER_VALID_COMP_ID;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             m->validity_flags |= CXL_MSER_VALID_COMP_ID_FORMAT;
-- 
MST


