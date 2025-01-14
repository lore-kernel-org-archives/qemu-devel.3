Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231DBE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq0t-0001qC-W4; Tue, 14 Jan 2025 18:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq0r-0001nt-SR
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:07:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq0p-00042q-MW
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWccFfQ6jPbnEZLAIuZcotrIFjnbshq7v2GjTEBJen0=;
 b=BnF7f0HUAC07tAMHfOM8qZtD4b8/C5xn6szzxalfzPGVO3UlThg/TxwTzA2nVmQ2vFBgp9
 DZJhgmV3zJJN/SCv25ETKImFYHsWv2ykcnn/yyuLkJle2OF2bVCOk021Xo/MVBhL17KLdA
 BVd3FXcyJQe0Pw4w29gN8YjdnSWpza4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-QkFucm6kMdmQ9rQi1HAf1A-1; Tue, 14 Jan 2025 18:07:53 -0500
X-MC-Unique: QkFucm6kMdmQ9rQi1HAf1A-1
X-Mimecast-MFC-AGG-ID: QkFucm6kMdmQ9rQi1HAf1A
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467b19b5641so115641871cf.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896072; x=1737500872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWccFfQ6jPbnEZLAIuZcotrIFjnbshq7v2GjTEBJen0=;
 b=lKiMBoHlbXV1YfWb+bF6hkShj7UDhNOcu0YXFlAazdwvtXUes6daxPwTaN1TJS/iu9
 Wzt/ZXpUJwy2p6ukqWxG6rat/xHz4IcqmKYhdhim19wWKTMf2yW108c920nToirR89DM
 MhpHzU9oGV2CfsLRyjA3n6YeTfZAEUVxGNJ0mxZ+Yi5L9prgIXDm9Z+BoZtwkwMn4Cb8
 8VcGHr7E6Vd9FTlqklgzdTdH/nl+I1uv9EAKiEI3aom4YSgL0/kW30yCEWjZMHHO9wpq
 2FUGZugbjlh1Xr2sEBM5ULLiA5FkFvdEEliB+LcAWjHoMy7GxmCLvT09cv6t2d9eIZh5
 Ll+w==
X-Gm-Message-State: AOJu0YyF3cewYixU8gWnRF3e/20ZHYI4F9/kJRNpjoqsmgnEzcCHcPSU
 he2OusrP9XnSKKhrau4Ht9yzfrUNFPxgnzv44CaQH7z7oufY5s0EOV9TxWSSE33r/pqBs/yBJkr
 tLjA9bvGQhmoNZ0LDOuxDbb6SKc69XzgcIbEOHpeBzyfrPY8q3mp6vcZQkxxeHqn0HLVcMgyHW+
 OFBG9HvR1gkCZjOffpECyGXlJeIZzWUOkwJA==
X-Gm-Gg: ASbGncuIWetLjSAn6vF2mc/WZw3eKXzoLdSnXQtIrViTofLVcayfuw7UnNDHBNZQypM
 OkC4qLP7YiTjYDYY1jyu3sx3OD/JhODpdzauvJZu0qDhn3FbOtk+tC9j1ZdzVMP5JPcre+KSLHx
 cnk8VV9xP0lCtMnI+tcDf2n28kRpbm+hNr9zdz7mXuP9fCDvnYD65I087nyA2+rFhORrt8DQLlV
 6L5fqlHyBfx12qMVDnu2cmke/HTJLfRPSbPGHjcUzZmlPPLv5IIGrLjWmZ1NPO4caDRhhVZDayZ
 t9YQTsBqJQ60casTd+Zqmxe3PgLqLeIr
X-Received: by 2002:a05:622a:449:b0:461:169e:d2dc with SMTP id
 d75a77b69052e-46c7108ecd7mr391061761cf.49.1736896072037; 
 Tue, 14 Jan 2025 15:07:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtojTRAhDGDSwPJY5iBDa/Arl4FWEjX74yDiW4aLs+kKISTglcPLKisCor3PpdhJeWqj0KIw==
X-Received: by 2002:a05:622a:449:b0:461:169e:d2dc with SMTP id
 d75a77b69052e-46c7108ecd7mr391061461cf.49.1736896071669; 
 Tue, 14 Jan 2025 15:07:51 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:07:50 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 01/16] migration: Remove postcopy implications in
 should_send_vmdesc()
Date: Tue, 14 Jan 2025 18:07:31 -0500
Message-ID: <20250114230746.3268797-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

should_send_vmdesc() has a hack inside (which was not reflected in the
function name) in that it tries to detect global postcopy state and that
will affect the value to be returned.

It's easier to keep the helper simple by only check the suppress-vmdesc
property.  Then:

  - On the sender side of its usage, there's already in_postcopy variable
    that we can use: postcopy doesn't send vmdesc at all, so directly skip
    everything for postcopy.

  - On the recv side, when reaching vmdesc processing it must be precopy
    code already, hence that hack check never used to work anyway.

No functional change intended, except a trivial side effect that QEMU
source will start to avoid running some JSON helper in postcopy path, but
that would only reduce the postcopy blackout window a bit, rather than any
other bad side effect.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index c929da1ca5..0c4df27177 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1427,8 +1427,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
 static bool should_send_vmdesc(void)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
-    bool in_postcopy = migration_in_postcopy();
-    return !machine->suppress_vmdesc && !in_postcopy;
+
+    return !machine->suppress_vmdesc;
 }
 
 /*
@@ -1563,16 +1563,16 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
         qemu_put_byte(f, QEMU_VM_EOF);
-    }
 
-    json_writer_end_array(vmdesc);
-    json_writer_end_object(vmdesc);
-    vmdesc_len = strlen(json_writer_get(vmdesc));
+        json_writer_end_array(vmdesc);
+        json_writer_end_object(vmdesc);
+        vmdesc_len = strlen(json_writer_get(vmdesc));
 
-    if (should_send_vmdesc()) {
-        qemu_put_byte(f, QEMU_VM_VMDESCRIPTION);
-        qemu_put_be32(f, vmdesc_len);
-        qemu_put_buffer(f, (uint8_t *)json_writer_get(vmdesc), vmdesc_len);
+        if (should_send_vmdesc()) {
+            qemu_put_byte(f, QEMU_VM_VMDESCRIPTION);
+            qemu_put_be32(f, vmdesc_len);
+            qemu_put_buffer(f, (uint8_t *)json_writer_get(vmdesc), vmdesc_len);
+        }
     }
 
     /* Free it now to detect any inconsistencies. */
@@ -2965,6 +2965,7 @@ int qemu_loadvm_state(QEMUFile *f)
         return ret;
     }
 
+    /* When reaching here, it must be precopy */
     if (ret == 0) {
         ret = qemu_file_get_error(f);
     }
-- 
2.47.0


