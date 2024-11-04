Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593B7D1BDF5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Jf-0007O6-VN; Mon, 04 Nov 2024 16:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Jd-0007Gv-I6
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Jc-0005V8-0f
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lxMZ/W8THThOjbgDug1/PH8QPzyLrkb73sNiH2Rol0U=;
 b=P/yx5yRsgXjrwD5LM/qU95UcaBAGaahiqTD8BNWvMOwp74TFOdH3ZHnOgxf9NDwjWgspCP
 8V3afRcCB66GB0D+yWkOWqo+5KgK+u68OSdKdf3CbMvdsD9afYf/1T9ENqR8r0PdRWYfQs
 GBXhK2gCnL2bgkqRG+E81jYk86wbOi8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-53adzAwKMjW0nH66SXTERw-1; Mon, 04 Nov 2024 16:08:46 -0500
X-MC-Unique: 53adzAwKMjW0nH66SXTERw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539e91e12bbso3000229e87.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754524; x=1731359324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxMZ/W8THThOjbgDug1/PH8QPzyLrkb73sNiH2Rol0U=;
 b=U5VEW4RqRR5w0OXUmcTmEYEFjMahTe/VS5+NUrPRfpOlVkoyEe/uuyphrsPqJUUz9Y
 HOYqQ8OgwP7WGpaHWDS7IEyoqWnNvKOWia37VbCGaenAoIUv4ug7NupyDC5Ho0VL4pbG
 kcI1qkH0E/q6wuiHGwlLdVEkg9vYkLZTQI89U8Cwvhx1Bqc4hMk22b9Q2S5pVE40gX9i
 uHrgIEYShVfUf1bwqTr350nZ5uuP9lI/iVVcyotdUthIziLK9yJQXJnWYnwlX0ejJzlu
 0hdz2B6gU/n6Gj7Kol/Zr78j3tGaQLEkMaMvujPgtP5P5tlh+Dd7wd6jzG2VdTLI0Pda
 d4xA==
X-Gm-Message-State: AOJu0YyjU7wYfyBlC0woY9m/uZ2GkwMoYQTENE/wChwGofUmZoHF60DB
 0E6cumiJP1SGzelfoblJks07uulJUF1i1GK6FZ/2heau1f/jDItTNBkhRRwVdl80oacXqXZtyxM
 TyGp+mYffP3AFOC+c4dGt8z08Z+d380iN5O7NWUnpMTKbPIbqAv5VCDclENuuGMPHZLI/nVYE6g
 tAksqpUCI7AoxlDLLQvvVwb0SCXZcWaw==
X-Received: by 2002:ac2:5f87:0:b0:53d:6b50:f5f9 with SMTP id
 2adb3069b0e04-53d6b50fc78mr2974438e87.38.1730754524361; 
 Mon, 04 Nov 2024 13:08:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi+xKsxxOAGZXfM92I/OUJw6xP+bBRBhIgIzVkkTnvFy400Q6de84so7y8tldJqXaALuSJPg==
X-Received: by 2002:ac2:5f87:0:b0:53d:6b50:f5f9 with SMTP id
 2adb3069b0e04-53d6b50fc78mr2974423e87.38.1730754523820; 
 Mon, 04 Nov 2024 13:08:43 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e9145sm193342945e9.1.2024.11.04.13.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:43 -0800 (PST)
Date: Mon, 4 Nov 2024 16:08:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 47/65] hw/cxl: Check size of input data to dynamic capacity
 mailbox commands
Message-ID: <7edbbff5ee85dd28699c5acd6ea2f2c2e41c37d2.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

cxl_cmd_dcd_release_dyn_cap() and cmd_dcd_add_dyn_cap_rsp() are missing
input message size checks.  These must be done in the individual
commands when the command has a variable length input payload.

A buggy or malicious guest might send undersized messages via the mailbox.
As that size is used to take a copy of the mailbox content, each command
must check there is sufficient data. In this case the first check is that
there is enough data to read how many extents there are, and the second
that there is enough for those elements to be accessed.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241101133917.27634-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 97cb8bbcec..17924410dd 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2465,11 +2465,20 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     uint64_t dpa, len;
     CXLRetCode ret;
 
+    if (len_in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     if (in->num_entries_updated == 0) {
         cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
         return CXL_MBOX_SUCCESS;
     }
 
+    if (len_in <
+        sizeof(*in) + sizeof(*in->updated_entries) * in->num_entries_updated) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     /* Adding extents causes exceeding device's extent tracking ability. */
     if (in->num_entries_updated + ct3d->dc.total_extent_count >
         CXL_NUM_EXTENTS_SUPPORTED) {
@@ -2624,10 +2633,19 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     uint32_t updated_list_size;
     CXLRetCode ret;
 
+    if (len_in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     if (in->num_entries_updated == 0) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
+    if (len_in <
+        sizeof(*in) + sizeof(*in->updated_entries) * in->num_entries_updated) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     ret = cxl_detect_malformed_extent_list(ct3d, in);
     if (ret != CXL_MBOX_SUCCESS) {
         return ret;
-- 
MST


