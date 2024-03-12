Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACAFC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZO-0004QT-Gf; Tue, 12 Mar 2024 18:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZD-0004PT-KE
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZB-0004Cy-BE
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IhIYiGuhexxvR3Vz4hV/FS6E5xXXWvMe6jUtxyAzs0w=;
 b=Bwkq6lbbTwP+0NmI5VsQjIWFXUVuBcEJmD9OEQaStJWDT3oj4X7bA9JDMVjSp1ROBl0azF
 IaDej1MK8Zc/XdmV5a/ig5hGIFQY+cNPr2kUdG+9QGocxuEzwvNlhYKb9cemO8ph729EI2
 9UhxlXzhdZiHste2E+HFWQbhR6ZyKyU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-Gt2KAMLxOTOKLfX7MX7tDw-1; Tue, 12 Mar 2024 18:25:46 -0400
X-MC-Unique: Gt2KAMLxOTOKLfX7MX7tDw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5684c1abc33so2349660a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282345; x=1710887145;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IhIYiGuhexxvR3Vz4hV/FS6E5xXXWvMe6jUtxyAzs0w=;
 b=Yusaq9StvHxN2/WWOIXdvkmaLxmniTswjH2aeLPPtAu8n13VLlM+LDptYboffz38Uh
 /u84ZxOoHsaEbWCnr7mqF9zb0JwAXcCxCwibc3FDb4JiikpnDZTXgoNV5R1wNc7JxsUM
 NGw4L3tEvCKe+RAu34phHUqI6KvAvfFe34COLkOX/zptrJyw3ycJASBNfqh9TQO23PIp
 qEERjdAV+yOZvpg8sOvrtBrnBrzttukzRdVXPXAPbms5mXICCW+1h3xIqW0yk7MtBXNi
 F26ziQ5ZnQaks7TI+SdgX2TIJEoZZ6fJWeAIBIJ5GND0OnUQwU2ZwppQXO5aoA78V9t+
 JHqA==
X-Gm-Message-State: AOJu0YxZ3wbz4KUz3k7OxrJFjvHmKDI/gqdUrhz+tqU5I6fdz15dzIO2
 Giz3/vkF2k6xp0kNUaL5V5ZcH7N/2ctuGxssAcU5xvGpu4HrR4OZWWLQfEp42/f34Md18EqcN5C
 yGJtFW0eips0c66dJtBAHvzSvITIZF/NIUQBPf6jGeKfSzRTXJflpRizLErXQYWY+a2kJuDHqcv
 2c8sixSCYPf6Rl/dg81wWeC7CDpfP8snQa
X-Received: by 2002:a17:907:a0cc:b0:a46:3814:c3e6 with SMTP id
 hw12-20020a170907a0cc00b00a463814c3e6mr1862669ejc.60.1710282345060; 
 Tue, 12 Mar 2024 15:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES2M1dOcee666O2Fia2vWrwes+9oU14EnP00+flDUeVT10DfBrcD/fZACLoclnW3uK7afdWA==
X-Received: by 2002:a17:907:a0cc:b0:a46:3814:c3e6 with SMTP id
 hw12-20020a170907a0cc00b00a463814c3e6mr1862656ejc.60.1710282344640; 
 Tue, 12 Mar 2024 15:25:44 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 k13-20020a1709065fcd00b00a44f0d99d58sm4209000ejv.208.2024.03.12.15.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:25:44 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:25:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 04/68] vdpa: add vhost_vdpa_set_address_space_id trace
Message-ID: <62845d3296ab7565e66f6e1f7bcfedb877f6fe7b.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Si-Wei Liu <si-wei.liu@oracle.com>

For better debuggability and observability.

Message-Id: <1707910082-10243-6-git-send-email-si-wei.liu@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 3 +++
 net/trace-events | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 85efda9e67..9e8aded41d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -29,6 +29,7 @@
 #include "migration/migration.h"
 #include "migration/misc.h"
 #include "hw/virtio/vhost.h"
+#include "trace.h"
 
 /* Todo:need to add the multiqueue support here */
 typedef struct VhostVDPAState {
@@ -460,6 +461,8 @@ static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
     };
     int r;
 
+    trace_vhost_vdpa_set_address_space_id(v, vq_group, asid_num);
+
     r = ioctl(v->shared->device_fd, VHOST_VDPA_SET_GROUP_ASID, &asid);
     if (unlikely(r < 0)) {
         error_report("Can't set vq group %u asid %u, errno=%d (%s)",
diff --git a/net/trace-events b/net/trace-events
index 823a071bdc..aab666a6a0 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -23,3 +23,6 @@ colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int hdlen, in
 # filter-rewriter.c
 colo_filter_rewriter_pkt_info(const char *func, const char *src, const char *dst, uint32_t seq, uint32_t ack, uint32_t flag) "%s: src/dst: %s/%s p: seq/ack=%u/%u  flags=0x%x"
 colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=%u"
+
+# vhost-vdpa.c
+vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asid_num) "vhost_vdpa: %p vq_group: %u asid: %u"
-- 
MST


