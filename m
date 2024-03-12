Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92D9C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZd-0004Y1-UY; Tue, 12 Mar 2024 18:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZO-0004QX-4T
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZM-0004E9-F3
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUCwppk0yqzd6oST72OHAmOacyZwa2NHyNO8Qzr3EqY=;
 b=F8WKF7MBlXQbv3TTZgTqRei/Px98r4b/01vzejKmB+sYnt1yvIOCsS5cNsR7LBGG1mofWm
 mlIPffyL96ZDG8VELybS/XabOG/wjXKxHTYMZoIa+IAwNevbwdx5XHFxu6lk5X0/93JF5l
 owYSDPBPyW1js5hw56gWfQBKcqvrhIA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-x_sbzPQ4N3KOd8s9hw6buQ-1; Tue, 12 Mar 2024 18:25:56 -0400
X-MC-Unique: x_sbzPQ4N3KOd8s9hw6buQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5687a5239f7so624138a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282354; x=1710887154;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dUCwppk0yqzd6oST72OHAmOacyZwa2NHyNO8Qzr3EqY=;
 b=Y+G341QIT+DNsCQR8RoBoaIl64qnWZMEjLDS/kqKiQ9ziuGewvbHzS8ZB15B+La5PW
 uCsUa1H28Kb9xIDWQgh01Pqa+K7bKznKGds5wGjIFF3KfD6pAS/Jv55jMmzIkn3Zk329
 b6GyT0lqvoIFnVbkgVa7Jm/Stx6gpRFTGO3aA9moPf6sgzTb1WklKntl6pRwx6SHcvWi
 F0fmqtLaUzC0ek/AIHO4SsIB+thckzoVtlOYUViEQYvvjqKJOKabV4HypAXp/oMHf9d9
 unNmaHhKpwUYIq61aGG7x0oLygtORKyiI0Q7g+2rTL6DJ5L55i3Sp+nbyS3whmhuUYxB
 ZspA==
X-Gm-Message-State: AOJu0YxhbNN5MV8YlxhuwOgqC21GUl0c5CuDLzZA6HxwnNrsJyBlGp6z
 H3Bn2dcnZOs0GvOZY6at+TYJTvGVZUultMrs1LgkurM6OxJxvRu0b7yQ8Bh4mzEz6SClrAIeZTt
 7JIrmoYHIhJlgfuvN+xOpLlA+pfbmt2TJigIWWn7kAn1hll/HTWYz0/lLYCqLQ/RC0bJoYlf7v7
 c0h+ApXHf7R8woMTliXKBSl+6nxVp+HhQA
X-Received: by 2002:a17:906:2812:b0:a45:c694:98ae with SMTP id
 r18-20020a170906281200b00a45c69498aemr1109305ejc.20.1710282354131; 
 Tue, 12 Mar 2024 15:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+EVH6nT8OqcAieFctqYsD5szHh6McmP6umIZU4jumA9WpoEykSZblEJ3bi1sUQ7CaTg994A==
X-Received: by 2002:a17:906:2812:b0:a45:c694:98ae with SMTP id
 r18-20020a170906281200b00a45c69498aemr1109289ejc.20.1710282353577; 
 Tue, 12 Mar 2024 15:25:53 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 t24-20020a1709063e5800b00a45bbeeea9asm4210716eji.167.2024.03.12.15.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:25:52 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:25:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 07/68] vdpa: add trace events for vhost_vdpa_net_load_cmd
Message-ID: <faed74468fe4ade9503025094f8a03673c8bd416.1710282274.git.mst@redhat.com>
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

Message-Id: <1707910082-10243-9-git-send-email-si-wei.liu@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 2 ++
 net/trace-events | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9e8aded41d..2c95a98cc6 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -715,6 +715,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
 
     assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl));
     cmd_size = sizeof(ctrl) + data_size;
+    trace_vhost_vdpa_net_load_cmd(s, class, cmd, data_num, data_size);
     if (vhost_svq_available_slots(svq) < 2 ||
         iov_size(out_cursor, 1) < cmd_size) {
         /*
@@ -746,6 +747,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
 
     r = vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
     if (unlikely(r < 0)) {
+        trace_vhost_vdpa_net_load_cmd_retval(s, class, cmd, r);
         return r;
     }
 
diff --git a/net/trace-events b/net/trace-events
index aab666a6a0..88f56f2428 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -26,3 +26,5 @@ colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=%u"
 
 # vhost-vdpa.c
 vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asid_num) "vhost_vdpa: %p vq_group: %u asid: %u"
+vhost_vdpa_net_load_cmd(void *s, uint8_t class, uint8_t cmd, int data_num, int data_size) "vdpa state: %p class: %u cmd: %u sg_num: %d size: %d"
+vhost_vdpa_net_load_cmd_retval(void *s, uint8_t class, uint8_t cmd, int r) "vdpa state: %p class: %u cmd: %u retval: %d"
-- 
MST


