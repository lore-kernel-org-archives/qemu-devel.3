Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3060CC7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnRh-0005zV-I0; Mon, 23 Jun 2025 16:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRf-0005zD-Rq
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRe-0003VJ-8z
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750709228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkEJjraRCepMoGaVxmMxS16KxsRSxOPvQtdhhkypr5k=;
 b=TXRVAtUhm7pcL0ATaICTwuAGxeGMQ/aNwT2Q78RgZSPsO/K/B+DGnytVryyy6bPMwLY8ge
 54i7xp85atSRBrHp7+HyXzvjbvyCSROyItCUBDfMsB25QFNXy7bwulpT33tYJHm6CjtFna
 orVqeHKIvBcKmdCWm4lF2+Xh4uQZhAA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-93JwXokYP1-sRec5D-kNkw-1; Mon, 23 Jun 2025 16:07:07 -0400
X-MC-Unique: 93JwXokYP1-sRec5D-kNkw-1
X-Mimecast-MFC-AGG-ID: 93JwXokYP1-sRec5D-kNkw_1750709227
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7ceb5b5140eso683163485a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 13:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709226; x=1751314026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gkEJjraRCepMoGaVxmMxS16KxsRSxOPvQtdhhkypr5k=;
 b=JH582AZdZrcHtr1gKIXyVuXbLZMZl7Valus3FinlJuVlOiWKPsWiZePjkVjDFMOgTx
 K1QiEA2v6ry/xT45zYXsC9/gQJxSIAXe7R6rRaX0JVCqVDsz3aHIzznNe9ebcBxqk8iu
 81ueAmnu8xQtU/0/g1Nfn5yFI1rwljXWh7wPZbl7s0R+ek5ydveOU7Lsz2xKe38hb0po
 U1D7p9YlWdNaEyRZhv3uwDonmRCXQGSelkQCxm5UmabHHkUjex+6DDVD1L64vSvh9wug
 H6a6xlWamwOyleO+YqLBZrLgUrEtW0GI66mdcg47SCveAzfTQAVj3vWq32wvoR1dnnwc
 gCvg==
X-Gm-Message-State: AOJu0YxMtS7aF9vdMxVqE1xa5ejAvngpjdYAvNtpAGqtK8JV2ffQfTwh
 lSnapwi5kVKkfV9NxyL6GMHmRODi2f95RRBXCTIz371FymqZvH3cxlTb2FZ5/AEpqfLLqvvJ03M
 hjFO7Ud6UmsdlsTCFhgILeithDNVFeMz0zZP4r4K6oZTWxBbx+fQjpUJujNQ2lRpANzcxEZTNyL
 6nbU69rzFJbD/NNTeT/g7arTsDig5MuVrBw3rAfw==
X-Gm-Gg: ASbGncsY4hplJf0BqXqn6mn3FjS5wp0xdiPlc6aDOZHdzFPKkxW8q2tCtoS0J7FshuL
 RWdx0cuDlxcdjsg+Iea9Y1GR9i0NwLPO1ganc2RZt8wYb8HPTNnZM025XnJQf8obWxkO5lOk57z
 gvHizn4adBfth6M6nWgPY+zgquEEzhRqI44pDZN2+OuHX8hRJhhAmut+O5PpciGbTcdRUkYVrTO
 nLKVWzsAnGAFbVoKBggdbAugS8uXx/bW1G9zpp8IbA8mHR5uS9WnGJpmM1OCfsy5KShX3pZT3d/
 hQRb+uV9Jx8=
X-Received: by 2002:a05:620a:171e:b0:7c5:49b7:237c with SMTP id
 af79cd13be357-7d3f992402cmr2069795185a.27.1750709226528; 
 Mon, 23 Jun 2025 13:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTfKa1IUadawlTW9uDTrfarIxoxeLKBJksU2SOYhPutnFjX7X0hdq7KO189bVVUHJm3J65ew==
X-Received: by 2002:a05:620a:171e:b0:7c5:49b7:237c with SMTP id
 af79cd13be357-7d3f992402cmr2069790685a.27.1750709226028; 
 Mon, 23 Jun 2025 13:07:06 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd095a775bsm48427976d6.112.2025.06.23.13.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:07:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Jaehoon Kim <jhkim@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 04/11] migration: Support fd-based socket address in
 cpr_transfer_input
Date: Mon, 23 Jun 2025 16:06:49 -0400
Message-ID: <20250623200656.1882674-5-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623200656.1882674-1-peterx@redhat.com>
References: <20250623200656.1882674-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jaehoon Kim <jhkim@linux.ibm.com>

Extend cpr_transfer_input to handle SOCKET_ADDRESS_TYPE_FD alongside
SOCKET_ADDRESS_TYPE_UNIX. This change supports the use of pre-listened
socket file descriptors for cpr migration channels.

This change is particularly useful in qtest environments, where the
socket may be created externally and passed via fd.

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Link: https://lore.kernel.org/r/20250611205610.147008-3-jhkim@linux.ibm.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/cpr-transfer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
index e1f140359c..00371d17c3 100644
--- a/migration/cpr-transfer.c
+++ b/migration/cpr-transfer.c
@@ -46,7 +46,8 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
     MigrationAddress *addr = channel->addr;
 
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
-        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
+        (addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ||
+            addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD)) {
 
         g_autoptr(QIOChannelSocket) sioc = NULL;
         SocketAddress *saddr = &addr->u.socket;
@@ -60,7 +61,9 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
 
         sioc = qio_net_listener_wait_client(listener);
         ioc = QIO_CHANNEL(sioc);
-        trace_cpr_transfer_input(addr->u.socket.u.q_unix.path);
+        trace_cpr_transfer_input(
+            addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ?
+            addr->u.socket.u.q_unix.path : addr->u.socket.u.fd.str);
         qio_channel_set_name(ioc, "cpr-in");
         return qemu_file_new_input(ioc);
 
-- 
2.49.0


