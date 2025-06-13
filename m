Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DA6C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ54v-00048h-4f; Fri, 13 Jun 2025 10:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54q-00047Q-Nn
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54o-0001TR-HX
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDCSHE7UZto1NWz1vjWrhDSXJj9UdV9w/vzQlY4ASS0=;
 b=c423tSmlhXOS4yi/a+XtAG5Wswb8kjYZt4TPP/ykQ6pNTfMfNZdPEBVZMMYxF97r5KHNl/
 Xga2Vt0yUuu+qE9Ga58LZ4/N0i2T+VdGpdpm9ailL+kt+KaC9nVrWVay/2It05Oc0RAU6D
 7c8gMKimB0tivjWNOCPJQbimGuXZdhc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-M6q9PC8ANnybymwiTbCGog-1; Fri, 13 Jun 2025 10:08:10 -0400
X-MC-Unique: M6q9PC8ANnybymwiTbCGog-1
X-Mimecast-MFC-AGG-ID: M6q9PC8ANnybymwiTbCGog_1749823690
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a38007c7bdso47311221cf.3
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823690; x=1750428490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDCSHE7UZto1NWz1vjWrhDSXJj9UdV9w/vzQlY4ASS0=;
 b=cNFtX2UnBICA+fSmgAnjcdSHz91HHzKRyBgxKIvVYdnOvvaDBcgn5ySkLTb3Rr01/t
 Yl2Dhtmy5VTCBwSsox8KWReBBiy4EBnVDvdHFMMI8IKxajsV0wgobhtss/AZSPEsq6Kw
 cvPwyAKvnA2KAn4DDagwS4rCx8fkOernoYXwCFS/64f2LZwLKvNB5IoU/eYqiWrdkHnW
 4DMzr7zwqTSp0UggS6RPKKseyXtNnI6SzD7QPjDYWGyJqJGaZhppC9+f4G15ZRB+5Ec6
 2j8PkhZ83v+JmIYyQAuTWdd3e2QIDL1+MqfHJIDL34S13QmM4xB5tbPxbMWgcJ6TIFWw
 RZIA==
X-Gm-Message-State: AOJu0YzYc90XPbPDoD/vmRLg8L7cE1uLjAVZFiDpPOPfN2ikTZ8eZWcJ
 VGfRaTZCRcaz3/iVdQMdtyKC85XK2l+sJDoGBS8PCjURcDkzGS+mhdMMAm7gGZksfHoBTBW+CAt
 RfPgtDNDLPfiXu7HMe3jQk6b6cKA//2HJcJ16O1Rzc6aELlk8t071ATrSUf9ZEgQ5HeK8zj01Xd
 DUqGWAHgn0Se/yoQIoxlyFNWHa0Fv1vUeiXmQC/g==
X-Gm-Gg: ASbGncsuxbVKFJ9x8Gb6WV9DjbNrtIUF0tAXnEoG9ewwvI82ifLBX9gD8mYlOzmyLBM
 qn/Kb7IxVDmtno8whrrYXcyxG2SB2fLOMDybIFdB70hJPB2+KkoNBtfyTGKesz1cDoy+c04sc76
 rDiXu2sOQ9MFsp6qMhbiz5XJdgo5wKOiUl6Y9IWmoVbYNYNuH62g61HcxFS4MuomBJZtvsaw3RC
 u0Jusp9gKlsYibhiRvUrd4277uxuBbpvlEeRK36weB1dFrbQvR1YqQloGPZcP/QEBaAqE9PNpYk
 p/9BfJHXZ8w=
X-Received: by 2002:a05:622a:1b15:b0:4a7:2f49:7627 with SMTP id
 d75a77b69052e-4a72febfd10mr59473061cf.11.1749823689649; 
 Fri, 13 Jun 2025 07:08:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZRoM6yXHJtrSQqBO1L4FnmXXbP3si63rDmjvV0PuUBFknDWrIcohxTfozmq6qTfOODl4OmQ==
X-Received: by 2002:a05:622a:1b15:b0:4a7:2f49:7627 with SMTP id
 d75a77b69052e-4a72febfd10mr59472521cf.11.1749823689211; 
 Fri, 13 Jun 2025 07:08:09 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a52a1ddsm17384111cf.81.2025.06.13.07.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:08:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 04/11] migration/bg-snapshot: Do not check for SKIP in
 iterator
Date: Fri, 13 Jun 2025 10:07:54 -0400
Message-ID: <20250613140801.474264-5-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613140801.474264-1-peterx@redhat.com>
References: <20250613140801.474264-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

It's not possible to happen in bg-snapshot case.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4098870bce..e33e39ac74 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3887,9 +3887,8 @@ static void *bg_migration_thread(void *opaque)
 
     while (migration_is_active()) {
         MigIterateState iter_state = bg_migration_iteration_run(s);
-        if (iter_state == MIG_ITERATE_SKIP) {
-            continue;
-        } else if (iter_state == MIG_ITERATE_BREAK) {
+
+        if (iter_state == MIG_ITERATE_BREAK) {
             break;
         }
 
-- 
2.49.0


