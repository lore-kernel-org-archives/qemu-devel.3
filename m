Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854B7F459EB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQm-0007vm-38; Fri, 10 Apr 2026 11:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQk-0007mb-37
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:58 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQi-0002a7-Jv
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:57 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35d971fb6f1so1965006a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833555; x=1776438355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bylwVIvheE4A13Mb11/ZHCJxDZDhKuXhRjY1sr2Fkk=;
 b=PmxZkZdS9fQUBYI/Q4aeeVpovfi1C+z/8ipsFvPhu6PxeYS+FDmsZsXJjYL4Fnqb5c
 EktAT2m0wpxyeWRTiYAXnIb6ar+0S/8CI7tnMsbUa3I2TXBCDa8mRBAmR/cUQZeMkAn9
 eem+dz6iZnAnifPjdSucm7CkWst1Lh1+cMf4B3SYecL30cEg/5Jv+xMPBIT9/5Mylp7h
 8tVqdz3DYLhXlZXkdTRFSrQGHD5eoFqYuM5F0Fb+WXQqTyx8W/rz3vb3CzhkPYoQZstu
 cOSXa5bKK3hiyrUtbBdVNQ+wtdZvaL+PFd7NUv2OdWUCpqMa5LnU5aUixhIxM3osH7Rv
 LkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833555; x=1776438355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2bylwVIvheE4A13Mb11/ZHCJxDZDhKuXhRjY1sr2Fkk=;
 b=d6kEkUuP2O4kls4gl883N9LEdQ2yC4yX0fBf5TYMfglXtNxS6jIp3PsdBfBnB8gDxD
 QsWkZRdCwrfjVi3wC6Wph99WFm0l2o6X4V35zj4s3pilB1BNmQPfjTGdB4zLVQQXQdFa
 idagOg59X4Wj1mCBpOpNiRkJJRtVDZGZ2501Pz1Y6n1B6jGhg5x65+PgUeD9Kb+kcOYb
 7QUohoat+1QSHqkn10/cJW5k8dTbh8PgQ8RqtBYMVVzq3PfTF4fszGhm0IO56dHKTiPg
 AKbV9A/KIHpb0IDCH874Pyshy6+meKqC1KAaDp33BLX01juko8jmglY4JaEWane0q9lW
 s/Eg==
X-Gm-Message-State: AOJu0YzfybSuBIFyacerwYp1e7bJGhi1LpY7f1/zstn23bMw/SCaEI5E
 1/dY9LHEHs3hgPGfh+dv7kqqX3mJWPGR2YusEzEZfkkqzQ8SqUxkU/GDaUbCr00V
X-Gm-Gg: AeBDievql9vNXoxxNNYhB9avCb8ukTwakWcIOOKKpAJJo+gexc2B+DjMQFluXiOCDnT
 3Q+9BzVDENmc8ayKfnIdX2p+zEsIk/LCRp2VDY1rrVx5VMq5NWAT9AvA30J0piNYGqVH8e9i0qL
 xk+R40wINuaa9lix8Z94fny/Gcc5LaGQenH8Q8YGDAzVFMnWvitWc9r1LfMM+vCreHqNSRS6TPY
 Qq1THANrhaEhxZwrB2eOCldU1M3MbjlxFPguv3kh0DSH7oauXwYySG2wOp8PbScB9g/DAT1ZTCP
 XBidt6DfOnzgozl8z7z+dLB6EArqFqlfyQrbjPbdtpL/zVOjeslalqp8PQud+C4B8aLFxVorFtf
 bMRqDfoi4+YqXUF/kIylFyVSCRgtUNfXu+VDslHa/yTxjmZ9IIBk+a6bI0Lr8yZAICmupG04Owh
 zbmDWcwHzOnkeZvx/6py+U9KRttEqexkhIFLpoq5bL8tJurFPjKaeT
X-Received: by 2002:a17:90b:5104:b0:34c:904a:d92 with SMTP id
 98e67ed59e1d1-35e42859e97mr3983969a91.26.1775833554755; 
 Fri, 10 Apr 2026 08:05:54 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:54 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 12/14] xen-block: Update tracking iothread users with
 holder name
Date: Fri, 10 Apr 2026 23:04:55 +0800
Message-ID: <20260410150457.85190-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace raw object_ref/unref calls with iothread_get/put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/dataplane/xen-block.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..552bd8b039 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,11 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
+
         dataplane->iothread = iothread;
-        object_ref(OBJECT(dataplane->iothread));
-        dataplane->ctx = iothread_get_aio_context(dataplane->iothread);
+        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
+                                                          path);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
@@ -652,7 +654,10 @@ void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane)
 
     qemu_bh_delete(dataplane->bh);
     if (dataplane->iothread) {
-        object_unref(OBJECT(dataplane->iothread));
+        g_autofree char *path = object_get_canonical_path(
+                                        OBJECT(dataplane->xendev));
+
+        iothread_put_aio_context(dataplane->iothread, path);
     }
 
     g_free(dataplane);
-- 
2.49.0


