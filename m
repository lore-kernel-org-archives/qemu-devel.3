Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31BAC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZQ-0004Ro-S8; Tue, 12 Mar 2024 18:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZO-0004QY-4U
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZM-0004ED-FC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=529XxwutIRv0EVLfrPXEt8NF5I7KrDY1qBpYH7/4N5E=;
 b=eT4l62XweRvZ5yEoIec3tjwhUovKv+WhSQ9gFgBqxqNn9f0eAB/fg5Ol7HD4QzNhR0/KYX
 ul2Sf4hQi3Je3N169N+hnyVq+bvH+dMv15gO2fQHY76M6qFwiqflMbm63A8d8Hw9OqiQWP
 jYCxGiZBoLD1qjTj7XkIGHFcwfQXUWk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-50D0yG17Ppap6KpG4-Ckeg-1; Tue, 12 Mar 2024 18:25:58 -0400
X-MC-Unique: 50D0yG17Ppap6KpG4-Ckeg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a45fb3a5430so220801266b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282356; x=1710887156;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=529XxwutIRv0EVLfrPXEt8NF5I7KrDY1qBpYH7/4N5E=;
 b=pudV+LT13LDUeduGByQ6XYoVXafxc9d1SIjIpSvNQf13XhQBBSfeIuViaWSyVm+KEW
 f82fZ38VDHWJyYOEZA+BnZOo1AQu6H083FM6l9L+DnfqvzODtArixYOyqP1rVnVrlIRP
 NPN9A/+/32Jsq7OdtnUazvWQTHeSjVqjwl5Kt6YjbzEc/uW7Mr+H2GUcN6nQedPVZeH/
 S2wB3k/a6/k7Ji+KHUNLQUbW+YHAdbUmqrdfja+0tKBak7JkAvjb1FWA9nZVYo8obna7
 YrOeG5pg3XkuAzd78TWSlXkDbXDktT6ex/P4tUbEe+ciWCoDtVEP/CHygHTEVhxvSmfm
 Aimw==
X-Gm-Message-State: AOJu0YzZ0xN6jhemB5BrSitdi10RLz9vSHAxuh5MIqK1lJmHFxr2jVTt
 IzN1U+Di4jkmsSoTpZkqdzIa1JBJUzwFtAHTz1dLfjYqOemHs9Rl8RHDca1y+pSDc/VOsxhhcV3
 wgkY4e6YtY5y3iFSQh/OTPJsgOXDvdb8QRDU8og0IugZ8Db7JcG/vYRxkjMRTQqefWCpzVn/cpg
 Ecdu5229gNu0UZA9IzsKLGkKR2y9wC2FSR
X-Received: by 2002:a17:907:c287:b0:a46:52f5:494c with SMTP id
 tk7-20020a170907c28700b00a4652f5494cmr272975ejc.70.1710282356667; 
 Tue, 12 Mar 2024 15:25:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYPlMKS9V+CM9++5Aja+vexRGnxVcAhBF9cNTTNOad7zvNlw8t9udKSnsfYgkN/6Rmo6bcEg==
X-Received: by 2002:a17:907:c287:b0:a46:52f5:494c with SMTP id
 tk7-20020a170907c28700b00a4652f5494cmr272963ejc.70.1710282356233; 
 Tue, 12 Mar 2024 15:25:56 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 gh16-20020a170906e09000b00a45380dfd09sm4216185ejb.105.2024.03.12.15.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:25:55 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:25:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 08/68] vdpa: add trace event for vhost_vdpa_net_load_mq
Message-ID: <1c4eab477fb0aa5a039513c26dac63d3460e1b08.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Message-Id: <1707910082-10243-10-git-send-email-si-wei.liu@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 2 ++
 net/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 2c95a98cc6..2254859dec 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -939,6 +939,8 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
         return 0;
     }
 
+    trace_vhost_vdpa_net_load_mq(s, n->curr_queue_pairs);
+
     mq.virtqueue_pairs = cpu_to_le16(n->curr_queue_pairs);
     const struct iovec data = {
         .iov_base = &mq,
diff --git a/net/trace-events b/net/trace-events
index 88f56f2428..cda960f42b 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -28,3 +28,4 @@ colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=%u"
 vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asid_num) "vhost_vdpa: %p vq_group: %u asid: %u"
 vhost_vdpa_net_load_cmd(void *s, uint8_t class, uint8_t cmd, int data_num, int data_size) "vdpa state: %p class: %u cmd: %u sg_num: %d size: %d"
 vhost_vdpa_net_load_cmd_retval(void *s, uint8_t class, uint8_t cmd, int r) "vdpa state: %p class: %u cmd: %u retval: %d"
+vhost_vdpa_net_load_mq(void *s, int ncurqps) "vdpa state: %p current_qpairs: %d"
-- 
MST


