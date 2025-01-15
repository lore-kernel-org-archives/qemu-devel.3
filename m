Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AEDC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7sF-0006rP-Ms; Wed, 15 Jan 2025 13:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qo-0008Is-4J
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qj-00072u-Ox
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AB4WiK8znpsIPslofkGRIt3WQYAc+EnhWGK/9uLoHcg=;
 b=ddAnRR/5OlrwviTHYTk4Tyg5Xj8i4hNmCHa2fttoUJrek6PBYZBf13uTGDj0kQlrtkcdL1
 o75G62kh3QA3Ew54MkvP3xqjQf3QFUfTsUtFn0VFcGgNT8My4S4U4y0OULZ4swYot6JFre
 6yhpQ6dLSHs57pzmQ68jbeZAJAKRUMs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-T_7bJPltN2GPQD2DyKWs2Q-1; Wed, 15 Jan 2025 13:10:39 -0500
X-MC-Unique: T_7bJPltN2GPQD2DyKWs2Q-1
X-Mimecast-MFC-AGG-ID: T_7bJPltN2GPQD2DyKWs2Q
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43582d49dacso47643635e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964638; x=1737569438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AB4WiK8znpsIPslofkGRIt3WQYAc+EnhWGK/9uLoHcg=;
 b=g0LB/5uFEiS7SQh1chHLrnwGiUOpGjcmIUWeYNbrhWJSq/LjHFqgJ15wV3Wk9r1+/6
 wGiPSoQFoqzwYacQJnods4yZ8X8cFeHUSRWnZZpExyMy+JlZaQ4Vp9cLY0w1czAA6SGd
 saTGk/T6/jw2JQvdAxoZm+ls09HZgN2MvI2NNsxTy6rvL+DNvVQa13o/I8DtIGPX0gcu
 Bo2xzMuUAsPW5nhBXwQIWuE4tdI6R9Jlz3U0FQA3irWjiaTFNToyLMdeZpoA/Tnp55DQ
 0OYh2SDiQvMyIQ4Ao9zNIzuEeunIs0R9exn9BYjOs4HPsv6/wPIWgw4meamjOaeiriQQ
 Kiug==
X-Gm-Message-State: AOJu0YzUNKGXu55WJsk4iWcRVhwPw5DeFWGRugC31aFwxFBQbIgBuz4r
 uf2sObiIbIr+z67lqJiT3yug42F/tNBELeH4VR38xAbrnwXK33IWSHjPwoG2AxrA9qstSGGAN+L
 1q0XSb9ah1NRjyCXT8tdvqQZvsqwC4l+qSPwaGsfzBF8xfLAwBwo+C2eS7BKFEGxhQ23kJB/RM6
 pzLROFq/D7juVn7kLpJOnNqUDJ4Zo1NA==
X-Gm-Gg: ASbGncu1F03DcJM6quUqV6EoGpax4XFxO0e30ma6iMWBTQhfEYxk1PiXnHnMfwWt6OC
 Rec84ePgO5stENop3rZANO/JkJfBypIS2CcitVzkjDrNK2BwaPsg+Vh4JILQWS3XcVFL/VWIEhH
 pxZ9nzUwZNgHoG0G1sHTCCr/AX5wq0Am+WwYdHaXg0SkOrh9WyFntMRB+fqRqoIrazYVXsLeAWO
 DhswdxM2oDzwjP13BD04bA1etoA2kS6BSTyIr3US3anjQJ8urY/
X-Received: by 2002:a05:600c:5491:b0:434:fddf:5bfa with SMTP id
 5b1f17b1804b1-436e268626emr263771115e9.2.1736964638063; 
 Wed, 15 Jan 2025 10:10:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnKVLGUGT2r6aoNW49z3WobAi9/w2xV1gGZW8fareqYGB0bqjNQsSWZfIy8rk7DQmgtbavwA==
X-Received: by 2002:a05:600c:5491:b0:434:fddf:5bfa with SMTP id
 5b1f17b1804b1-436e268626emr263770695e9.2.1736964637620; 
 Wed, 15 Jan 2025 10:10:37 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c5bb5sm32289855e9.22.2025.01.15.10.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:36 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 40/48] acpi/ghes: move offset calculus to a separate function
Message-ID: <1cd59b8981ce234c1d790111afce4a32218a88dd.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Currently, CPER address location is calculated as an offset of
the hardware_errors table. It is also badly named, as the
offset actually used is the address where the CPER data starts,
and not the beginning of the error source.

Move the logic which calculates such offset to a separate
function, in preparation for a patch that will be changing the
logic to calculate it from the HEST table.

While here, properly name the variable which stores the cper
address.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <60fdd1bf379ba1db3099710868802aa49a27febb.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/ghes.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 983e28505a..ddb576b940 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -364,10 +364,37 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
+static void get_hw_error_offsets(uint64_t ghes_addr,
+                                 uint64_t *cper_addr,
+                                 uint64_t *read_ack_register_addr)
+{
+    if (!ghes_addr) {
+        return;
+    }
+
+    /*
+     * non-HEST version supports only one source, so no need to change
+     * the start offset based on the source ID. Also, we can't validate
+     * the source ID, as it is stored inside the HEST table.
+     */
+
+    cpu_physical_memory_read(ghes_addr, cper_addr,
+                             sizeof(*cper_addr));
+
+    *cper_addr = le64_to_cpu(*cper_addr);
+
+    /*
+     * As the current version supports only one source, the ack offset is
+     * just sizeof(uint64_t).
+     */
+    *read_ack_register_addr = ghes_addr +
+                              ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
+}
+
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
-    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
+    uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
     uint64_t start_addr;
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
@@ -389,18 +416,13 @@ void ghes_record_cper_errors(const void *cper, size_t len,
 
     start_addr += source_id * sizeof(uint64_t);
 
-    cpu_physical_memory_read(start_addr, &error_block_addr,
-                             sizeof(error_block_addr));
+    get_hw_error_offsets(start_addr, &cper_addr, &read_ack_register_addr);
 
-    error_block_addr = le64_to_cpu(error_block_addr);
-    if (!error_block_addr) {
+    if (!cper_addr) {
         error_setg(errp, "can not find Generic Error Status Block");
         return;
     }
 
-    read_ack_register_addr = start_addr +
-                             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
-
     cpu_physical_memory_read(read_ack_register_addr,
                              &read_ack_register, sizeof(read_ack_register));
 
@@ -421,7 +443,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
                               &read_ack_register, sizeof(uint64_t));
 
     /* Write the generic error data entry into guest memory */
-    cpu_physical_memory_write(error_block_addr, cper, len);
+    cpu_physical_memory_write(cper_addr, cper, len);
 
     return;
 }
-- 
MST


