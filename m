Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E347CCF9EB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnbQ-0006Ie-IZ; Tue, 28 Oct 2025 13:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbO-0006H5-NJ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbI-0004gY-FH
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/r4/WhWamLiV42a70Dke9pt2v46dYWhx3stMUl9WaU=;
 b=baaU9XwpdHR4tkxscLldiJYATZyFaV6NW8ol2nJs9xWPhDD6QqLqlIsYw2STGUCZXLYbG8
 0NnWhj1nkna0MUpFcQOoZR2WnFPj6/lMv15ZsxyBB4RCovHbVtqytdL6AJcur+qDtpSWmW
 nHbvbDYiyWnwwLoVFh4bl8MFxrbOBs8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-fZZk52f2PW2H4uVuUb4haA-1; Tue, 28 Oct 2025 13:35:13 -0400
X-MC-Unique: fZZk52f2PW2H4uVuUb4haA-1
X-Mimecast-MFC-AGG-ID: fZZk52f2PW2H4uVuUb4haA_1761672912
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-475e89435e0so10638155e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672911; x=1762277711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/r4/WhWamLiV42a70Dke9pt2v46dYWhx3stMUl9WaU=;
 b=h7zG8V0lF1xoqQGi1/VegU8tT2kgTdtuaHJN82bpAbfcho2+RNJI7ccBXj4wa93uxI
 GJ4y18WTdVoNhf1BeIerWvlajC4hVW2631FCyFqc4g8A2SE2stuqEdHUL/dX2e404PPu
 XpwD8mSYeR2ZlPgpetCzueAcy1JayJL33HfOllAmo5kBY+39tX5oyTMv2tMegMKC6bsg
 +nrv8rEU028fL99huDqiJ2SRg8/GzcNchHPHgSgavNddW7/nFidRkqvrv3cjDwzY5x4q
 3o1T73mlfSUIIwqfyqqH/1doqYhkgUAxa/LjMKrobaJVsVr2tqC4C4bjj5a9sxsRBcul
 E3rw==
X-Gm-Message-State: AOJu0YwB+1fI43nwoBGupkQCqRVSbAiLHx0vMhawPcm5kbVb9LJaVe1V
 16MRqmrPT/HceeiSRHZ2576fUQls/DuA3w8GYkmY9H0XDy4jUwWkWx2P5/NPgO0rBOPQj03guyq
 pMZnpf0djVPvzJ2IxfNGAvpCLRcMIvDdkAbhCJ3h5XvI/UdleqdLSX96sna94XG+mO/yd5zUJTm
 HnEiphfPaZ23bUGVbzkzj+IdruecicbKlISIqRvi5V
X-Gm-Gg: ASbGncsNhOXifo+1hqPbpiGFtoFsHm9nXkufQVE9cJLUuHWOhEvYzPwLbwCmw14ursH
 Xy0o1onZYgtmTXSqq5fleAbi1Hm+mNeeYq8qDO+ecKV3KBeSrfKlqw9kdTxtuEdc05FeoUfW2OO
 RYDxZrX9LoCPt6KGWg5XsPXcIF81L0TJ33vy7xSU38u9Pr2VogWWikPkIrfwbKIXLwX31RtKDCi
 00NjvXMoAG5K9RXGxHC7W1OECNZBGsLO2mLKP74/N5qMX0NaRO1HMfySmUhXwl/sL5uGXj9F3qV
 rGrWM4XgExF4q/5SNFeGlYXIVJs7sssc/6g9yYDB+PSKvzarXZivuy2c8XiAFdjp4j5a2svmRkO
 GQrTWQsRuB6ZiU03YsJ6sHDkeYaEPK4nBjhDj2uL7GwbuZMjd3Y0ClVt1Bg6Jsj7Wwz78xJyaYN
 6Z/vI=
X-Received: by 2002:a05:600c:620a:b0:477:bf0:b9da with SMTP id
 5b1f17b1804b1-4771e1cac54mr2725825e9.19.1761672911401; 
 Tue, 28 Oct 2025 10:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6laHfClOe2ffYNhva6Rk0eYXKnjczhODWpLWceuibr8QV4pMr7xhszGPluSwrYzJHGOExcQ==
X-Received: by 2002:a05:600c:620a:b0:477:bf0:b9da with SMTP id
 5b1f17b1804b1-4771e1cac54mr2725565e9.19.1761672910951; 
 Tue, 28 Oct 2025 10:35:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e3b9994sm1979945e9.16.2025.10.28.10.35.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:35:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/18] scsi: make SCSIRequest refcount atomic
Date: Tue, 28 Oct 2025 18:34:25 +0100
Message-ID: <20251028173430.2180057-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 9b12ee7f1c6..b9b115deedd 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -823,7 +823,6 @@ SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
 {
     SCSIRequest *req;
     SCSIBus *bus = scsi_bus_from_device(d);
-    BusState *qbus = BUS(bus);
     const int memset_off = offsetof(SCSIRequest, sense)
                            + sizeof(req->sense);
 
@@ -838,8 +837,6 @@ SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
     req->status = -1;
     req->host_status = -1;
     req->ops = reqops;
-    object_ref(OBJECT(d));
-    object_ref(OBJECT(qbus->parent));
     notifier_list_init(&req->cancel_notifiers);
 
     if (reqops->init_req) {
@@ -1496,15 +1493,15 @@ void scsi_device_report_change(SCSIDevice *dev, SCSISense sense)
 
 SCSIRequest *scsi_req_ref(SCSIRequest *req)
 {
-    assert(req->refcount > 0);
-    req->refcount++;
+    assert(qatomic_read(&req->refcount) > 0);
+    qatomic_inc(&req->refcount);
     return req;
 }
 
 void scsi_req_unref(SCSIRequest *req)
 {
-    assert(req->refcount > 0);
-    if (--req->refcount == 0) {
+    assert(qatomic_read(&req->refcount) > 0);
+    if (qatomic_fetch_dec(&req->refcount) == 1) {
         BusState *qbus = req->dev->qdev.parent_bus;
         SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, qbus);
 
@@ -1514,8 +1511,6 @@ void scsi_req_unref(SCSIRequest *req)
         if (req->ops->free_req) {
             req->ops->free_req(req);
         }
-        object_unref(OBJECT(req->dev));
-        object_unref(OBJECT(qbus->parent));
         g_free(req);
     }
 }
-- 
2.51.1


