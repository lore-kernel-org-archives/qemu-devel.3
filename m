Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6739DCD1292
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 18:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtXUr-0000Ps-Pb; Sun, 07 Apr 2024 14:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtXUp-0000Ou-IA
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 14:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtXUn-0003CK-Tt
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 14:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712515441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UECy0ZeCjhynC/cceH+RtzQmZ3i8j2zm9Thkg5Ae3p8=;
 b=DfOtU1RYw0oyt4Fvz9/MD2z4Mz2y6rUp/kCpfxeRribRx0WeJqEQDDTxQB4VxnXsIlkczG
 RtIByPZn/xd0pTECpZCAu3umavY0pXQciQoKFttxHLShLSFx8QLqFbMrc6TCRomhr2MQ38
 dLL1k5t1tNs5HysYO9BsIf3w/LbkQG4=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-fhAix1-CPGeO8F1OPjBXqA-1; Sun, 07 Apr 2024 14:43:58 -0400
X-MC-Unique: fhAix1-CPGeO8F1OPjBXqA-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-479d74a7adeso317328137.0
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 11:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712515438; x=1713120238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UECy0ZeCjhynC/cceH+RtzQmZ3i8j2zm9Thkg5Ae3p8=;
 b=dOLBSL+74DMMONC7A579+Ih+PxeB/o34dD+h2m0PbhamkdkCrNr464f87Xua54EhZJ
 gXKk+J0+uEnCG/+ZaTnLoDyjZs8DpCaUmBJ568wb2KIjoSeW+XyCsl/3/l69UJXaLm9d
 muZAzfq71KPXUUDvLhxUhq9NsuX7YDKPGl8tnWA8LYvAXNJ/btO3de6fMg8FhulNEDRD
 IokIEGCjmwsqjbm5SOW9FE3TeGA1meCL9MRBe2w3wjvRS9ZPMopwbAEmSPnnZo661q3y
 V1kyu4vxB+m94gVcw0V5lGU7YlMNhyLJM5BGOe019w9L0+j2DPgNJseBHNL/5/3uqVJ9
 Dh6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw+vZT2qkxPyC8c0FCFAh2PR7GzrJ1R9ZAR9M8jsdVsJGHhBkzBeAV34/cXrXRFCdlYEm3dSOMKHd1T61wboSM7AYhOHs=
X-Gm-Message-State: AOJu0YwvJMPPn7+Ka3xEvGD6pT06vk4LZxU/+cB3x+pQqtqVDCU5eR62
 LdLjuljCA11wwPgIf8fjMpkq5x5TI+DxU6+3ERmaH2Hz/g/JmOrFAKmX4sLyNdMco+OQ8Oqi8P0
 vDwzwuvMz1bbXrQbaBqbG0JRSWYmSmuXMisSyM0HbvS6g1XVBmyVI
X-Received: by 2002:a05:6122:c8a:b0:4d8:74f7:a280 with SMTP id
 ba10-20020a0561220c8a00b004d874f7a280mr3776761vkb.0.1712515438009; 
 Sun, 07 Apr 2024 11:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEncrWTRL9OQYlHj/oiaC0poeP8koQiLR+IGsB9uk8F8xg5rxHrVe1NcUnA2Oo3BYcG/gsMaQ==
X-Received: by 2002:a05:6122:c8a:b0:4d8:74f7:a280 with SMTP id
 ba10-20020a0561220c8a00b004d874f7a280mr3776738vkb.0.1712515437471; 
 Sun, 07 Apr 2024 11:43:57 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
 by smtp.gmail.com with ESMTPSA id
 cw12-20020ad44dcc000000b0069905863252sm2416842qvb.84.2024.04.07.11.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Apr 2024 11:43:56 -0700 (PDT)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>, Lei Wang <lei4.wang@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL 1/2] migration/postcopy: ensure preempt channel is ready before
 loading states
Date: Sun,  7 Apr 2024 14:43:53 -0400
Message-ID: <20240407184354.1839435-2-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240407184354.1839435-1-peterx@redhat.com>
References: <20240407184354.1839435-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Wei Wang <wei.w.wang@intel.com>

Before loading the guest states, ensure that the preempt channel has been
ready to use, as some of the states (e.g. via virtio_load) might trigger
page faults that will be handled through the preempt channel. So yield to
the main thread in the case that the channel create event hasn't been
dispatched.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: 9358982744 ("migration: Send requested page directly in rp-return thread")
Originally-by: Lei Wang <lei4.wang@intel.com>
Link: https://lore.kernel.org/all/9aa5d1be-7801-40dd-83fd-f7e041ced249@intel.com/T/
Signed-off-by: Lei Wang <lei4.wang@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Link: https://lore.kernel.org/r/20240405034056.23933-1-wei.w.wang@intel.com
[peterx: add a todo section, add Fixes and copy stable for 8.0+]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 388d7af7cd..e7c1215671 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2342,6 +2342,27 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
 
     QEMUFile *packf = qemu_file_new_input(QIO_CHANNEL(bioc));
 
+    /*
+     * Before loading the guest states, ensure that the preempt channel has
+     * been ready to use, as some of the states (e.g. via virtio_load) might
+     * trigger page faults that will be handled through the preempt channel.
+     * So yield to the main thread in the case that the channel create event
+     * hasn't been dispatched.
+     *
+     * TODO: if we can move migration loadvm out of main thread, then we
+     * won't block main thread from polling the accept() fds.  We can drop
+     * this as a whole when that is done.
+     */
+    do {
+        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
+            mis->postcopy_qemufile_dst) {
+            break;
+        }
+
+        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
+        qemu_coroutine_yield();
+    } while (1);
+
     ret = qemu_loadvm_state_main(packf, mis);
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
-- 
2.44.0


