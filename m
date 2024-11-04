Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7187D1BDF5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84YQ-0007VT-Jc; Mon, 04 Nov 2024 16:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84YI-0007TL-20
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:23:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84YE-0006tR-TP
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730755434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+r0iRZPdNktKwi2B9jYiiQ07N21yewo/4zGpqb2N41I=;
 b=Q7BF/sfSO6CPR1jbKGMg02n6a2di5I0/qepr0XpMy4yC0oRwK/r7hScpU67SkbaLg2zCp+
 CFxk3Pf3Dw9QD2BHcdjnNiIrPw0YDLWPVDBf4NKI7/zBbSbJlX4QwG+ssSNHIONaVY69rO
 +fFaxUY/5NilpcYb9sMyy4iBjS1UJYU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-IcrsMmvyPS2p9mDPFNRnIg-1; Mon, 04 Nov 2024 16:23:53 -0500
X-MC-Unique: IcrsMmvyPS2p9mDPFNRnIg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4316655b2f1so33107735e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730755432; x=1731360232;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+r0iRZPdNktKwi2B9jYiiQ07N21yewo/4zGpqb2N41I=;
 b=sAt37GEwgwWdU36jdwr3fIlaDwGtF6Tu2y6maCDOzd1Is9UDkSy6A/kF0BdtlR1GJF
 tiWbPZP0w481PbG2WUVmngNljgHie6jBnxfG89f+4MIBawE1kLoTKOaJFJx1XIfjW/2a
 UMa0BcwuThqFnTUziE6H+eh4AlYewCrmEJnIX5d/Toevysz43SLV+TnPdwgJ+cdKLT6h
 IVuXHgvzMwBwODhvp9+/dbJUvM8D594DluHlDf/ZjOQsWhuLfruC59Y8lu0tPeiD1TSx
 3j/N+OZDnUNd31CbLnX4VOhdCZuPp8su8wV+NHF4uqdtKflXejqHlZHODYuXG6Xi2hFZ
 sZWQ==
X-Gm-Message-State: AOJu0YxKfm4hu/1a5ni9gD7LKXufFcIQ1p/BjgB51uIuRNfvuw3L0MXi
 0/xzZhlfbse2n7XH/QAM8cttL3q/rgBn0leESFjZYlxrqp21LQiIw1KJEx5w2Nvpdgsp+QIxD6s
 DiRpvQU+CdU60qHNWKRL6qICW3VFFTBWPiBjJIqtEEtPsDvWrBsyQCfH2iMQGrqDpapnZ2IPSIJ
 7Sfgyx5ZOxlIzJbb9AcV3xmh3WXhm1mA==
X-Received: by 2002:a05:600c:3587:b0:42c:c401:6d67 with SMTP id
 5b1f17b1804b1-4327b6f464amr138539415e9.6.1730755431748; 
 Mon, 04 Nov 2024 13:23:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKQzk30xivw4kVEmq/E8kN34n4o1SbMHvXX7lLl89HmdRKFSJWuCgVK03tghpMYinErG5RfA==
X-Received: by 2002:a05:600c:3587:b0:42c:c401:6d67 with SMTP id
 5b1f17b1804b1-4327b6f464amr138539275e9.6.1730755431357; 
 Mon, 04 Nov 2024 13:23:51 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a273afabsm1040145e9.1.2024.11.04.13.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:23:50 -0800 (PST)
Date: Mon, 4 Nov 2024 16:23:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 52/65] hw/cxl: Avoid accesses beyond the end of cel_log.
Message-ID: <a3de73c2a835efc30851f9e810e0cd355e1cd0cf.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add a check that the requested offset + length does not go beyond the end
of the cel_log.

Whilst the cci->cel_log is large enough to include all possible CEL
entries, the guest might still ask for entries beyond the end of it.
Move the comment to this new check rather than before the check on the
type of log requested.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241101133917.27634-7-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2aa7ffed84..5e571955b6 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -937,16 +937,6 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
 
     get_log = (void *)payload_in;
 
-    /*
-     * CXL r3.1 Section 8.2.9.5.2: Get Log (Opcode 0401h)
-     *   The device shall return Invalid Input if the Offset or Length
-     *   fields attempt to access beyond the size of the log as reported by Get
-     *   Supported Logs.
-     *
-     * The CEL buffer is large enough to fit all commands in the emulation, so
-     * the only possible failure would be if the mailbox itself isn't big
-     * enough.
-     */
     if (get_log->length > cci->payload_max) {
         return CXL_MBOX_INVALID_INPUT;
     }
@@ -955,6 +945,20 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_LOG;
     }
 
+    /*
+     * CXL r3.1 Section 8.2.9.5.2: Get Log (Opcode 0401h)
+     *   The device shall return Invalid Input if the Offset or Length
+     *   fields attempt to access beyond the size of the log as reported by Get
+     *   Supported Log.
+     *
+     * Only valid for there to be one entry per opcode, but the length + offset
+     * may still be greater than that if the inputs are not valid and so access
+     * beyond the end of cci->cel_log.
+     */
+    if ((uint64_t)get_log->offset + get_log->length >= sizeof(cci->cel_log)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
     /* Store off everything to local variables so we can wipe out the payload */
     *len_out = get_log->length;
 
-- 
MST


