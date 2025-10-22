Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69340CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeUA-00032W-3W; Wed, 22 Oct 2025 15:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTr-0002uH-M5
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTp-0001al-Ca
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JW8aeNeh6Nu+nmUpwT9UAvg9KPt5UcYpUXSC4KDXYdA=;
 b=Yp0/A4dCKMKagzMBElLEkvV/0ttjONmLomM4GBx0deWqeni/KpW0WxBtjH1T6A16KT8ufz
 NdZhmCpCsCo/NJDbt26mfgGjaaQhxl68Ya0iUWdy2AAES3guZCHwEPXnOhhqF9cChHRxAI
 0kNAa1ms8jazsx6JLJ5SacomukGpdBQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-YYW8GBPZPOKRjDXDatLV7w-1; Wed, 22 Oct 2025 15:26:33 -0400
X-MC-Unique: YYW8GBPZPOKRjDXDatLV7w-1
X-Mimecast-MFC-AGG-ID: YYW8GBPZPOKRjDXDatLV7w_1761161193
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e884663b25so50268361cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161193; x=1761765993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JW8aeNeh6Nu+nmUpwT9UAvg9KPt5UcYpUXSC4KDXYdA=;
 b=Sv2SYNPaQ+N+SIT1wuWWPrtkpDkW6pHLrxxf3j+TBmtwBs9Oc+HiZWGLppEDP0pONA
 P1IvG9nZbbCWbrYKgBUTBksGnmeovo7wAia1RAm59FWNTEUp3oUNrAJvGxddrfM45aFa
 CZZCQGlNCoWjaC2E5hdFv4H90mXTU6QbyW/dVw02pDc3x7EwV3FfvPXup5e1ZpHlim5u
 wLxcwPTgXDbln4W1kQp6Wh15BQ3a9dNObWMm1yN5NNDsWGyFuKN+vQ0CtC/d8V1VQxE0
 woGpWCHMJwzWvNIvC45ciuGwP4ZL0tYS0roPjUjePE/FTg05lr4ap2gKNMk6cIFsp48b
 5uGw==
X-Gm-Message-State: AOJu0YzUYAcgBwsMwv8lPOsD8l1Q/6SLz+lr0BcDjtF/7J52wKVbw+uW
 UpeZ1+/MROJh9mX9nYMTDpM7n0g2v3LICWokuc3WrmcNRNbcQlOwvdAo0aW2V7SFro9uz3bjJR3
 VX8lYm4NoJTbl7zPKKP/z9jAqiZSA9F/T0vLHEGhHck06ln406VdqjBJnY1CBJxa8KQoXsTklzK
 3ct6UtsgsXFXkyIpjkeBrG5oHgtXAuPLY1n1Bg6A==
X-Gm-Gg: ASbGncsKOTXTyUlNiC58oERoYMLSt7dPENWtkczPqmoLayuU+bXzMjPJ4w2X2J/2LY7
 D49lvqKDKqBIrGeVvy3Wc3NoxS15QTbTwh79S+0SMwpwbb3lD/j+6aELkQG+sO4eFgqgYQZYleQ
 u3lEbAH+NhT4iRhj9/DLdASSoRGDvSpkBDIfuWQixJUA9PDodCkxK68mVhsQrw1P9gT6Efp0TtZ
 7oGlAtv5gRI2r8feK5ogGLjJU9NIs6Fm8pOjrBKWCQBAKFixaGU6Cn+2iXhfUbvseXDt7yZmFA2
 QRmqpWf1DXt6MpCTV/MRhplS3K8M7rScIxU3HRET5IWUP3U8n1K2xYJy/3POww15
X-Received: by 2002:a05:622a:1451:b0:4b3:4457:feca with SMTP id
 d75a77b69052e-4e89d1ff721mr252775541cf.6.1761161192561; 
 Wed, 22 Oct 2025 12:26:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9t7boqwotXXvEgahMzh123AgygpagLLvET1D2CLM1h99JEh40wGE+UKWXyI4kvz626sCciA==
X-Received: by 2002:a05:622a:1451:b0:4b3:4457:feca with SMTP id
 d75a77b69052e-4e89d1ff721mr252775071cf.6.1761161191927; 
 Wed, 22 Oct 2025 12:26:31 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:31 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 10/13] migration/postcopy: Remove workaround on wait preempt
 channel
Date: Wed, 22 Oct 2025 15:26:09 -0400
Message-ID: <20251022192612.2737648-11-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts commit 7afbdada7effbc2b97281bfbce0c6df351a3cf88.

Now after switching to a thread in loadvm process, the main thread should
be able to accept() even if loading the package could cause a page fault in
userfaultfd path.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 991f46593c..16fae635c0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2452,27 +2452,6 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis,
 
     QEMUFile *packf = qemu_file_new_input(QIO_CHANNEL(bioc));
 
-    /*
-     * Before loading the guest states, ensure that the preempt channel has
-     * been ready to use, as some of the states (e.g. via virtio_load) might
-     * trigger page faults that will be handled through the preempt channel.
-     * So yield to the main thread in the case that the channel create event
-     * hasn't been dispatched.
-     *
-     * TODO: if we can move migration loadvm out of main thread, then we
-     * won't block main thread from polling the accept() fds.  We can drop
-     * this as a whole when that is done.
-     */
-    do {
-        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
-            mis->postcopy_qemufile_dst) {
-            break;
-        }
-
-        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
-        qemu_coroutine_yield();
-    } while (1);
-
     ret = qemu_loadvm_state_main(packf, mis, bql_held, errp);
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
-- 
2.50.1


