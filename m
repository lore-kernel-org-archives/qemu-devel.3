Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2183FC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuw25-0004RS-4e; Fri, 14 Aug 2026 13:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw23-0004QQ-Gb
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:27 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw22-0007z8-1p
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2d53197d8b5so5363185ad.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786729765; x=1787334565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=87zL/AEKdG58EHmwO5odqtOiVqOW3YATUIsTrJe0nJo=;
 b=TOthSXlNY2S+eDY5Ny3FIJ/3kLQU6jWF2EStRfYNf0Rit9YmpY2YyfV+BRutb76TNP
 ToH+uFFQR2g+DYYgr3sXQ4WGcjVG6BapUkE07E50zXKMQb2nz41/i+43dUgxhBYZnyWs
 PRyKKen0kqz5Z0TtbxU2754U48ZG5dskAiepfD5bAJ+FiXVRTXc5ChuOMzb/p1IZsWel
 uVVKhvzEhJuwEGIL7h5O5CmydxoNm4GIZ/qKhENHx8SMNMgkDU8nWh0fiSTCIZNmrrWS
 nB+MbFE9akYIvt2jM8XeNy9GWcOpVojJELynWwHz65vxbbpagTmXOALnE8rcz/iNoBRO
 DLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786729765; x=1787334565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=87zL/AEKdG58EHmwO5odqtOiVqOW3YATUIsTrJe0nJo=;
 b=Rxwgdqr6LJBfn4SZm5sbh5vkkgnB9WmPkpm2HOU4raL+S/Tl35m9E/wuNCZzTFzjr+
 r2mFZ/fNdcFZSnnsUoCBrC22YB6VXPn7a4yx+7WksSvuSKyMPh6Q15EtIYEnKwqZyT6F
 7RZkzDuHNxOt+gLt21byx5C7fkeypbRMvgKFiZGF25nJNEoS8Qqe5HDlPOc7NKDn6QOb
 2CmpQBItfxngTBPvnKQ6QPKDB9D+KqCvVMA8ltSkAv4MEFz8KvO+Kx+39yYuAeHE0aZN
 6IMHEPh8oBzRrzd0rA0MEY0Yjalg8allZT7HZ7YR6Z4oXq7jmHCYYkBu+tFBtwc3iKWJ
 9FqA==
X-Gm-Message-State: AOJu0Yy+KdAuVoBIkRU+PFxbkAmoBkz7Z9CRGew1FRD/D3U2XN3ezUw9
 gFOg9iXVryZsVgYYNDHmssGRLs5Ia897HPPAiFTPwwl8PANLEvzje5qXhper8P1kyjMphw==
X-Gm-Gg: AR+sD12odcqXc4vOhR7ZF7F7AncdERjcTV10PCm0FWJuE1nquw41mSFy9Knjhvm+OW2
 anf4D9BfmYgLz8fFPFoVShtEBFlai6ThSe/5RngV49yq6mE/tCqF0m6UG39+KdsFgl31Oo/G+nZ
 zGf0i1sF8bBHijNJez5JDpBrpnIr2Il7ACIbL+d6q3hbPzg2T1ncFwIUTTNUc6VQ8+qHdLUuE8q
 DLQVAvCuedLRI93LZjWNbdi4gzxhw+dsU2LM/htKZOR6aWl5jsEYsZU4yhNw5NSU9+4BXnkpNQD
 g5hqjBgeAqPgSw3CUAhMfJXZDp/cfikWO64xBiNobrfKy3wwwdoS+mOCZ4rcTDVGCLA5mfn214x
 c+itBZWEQZ2FLcM7GjFuNAwD/2dwZmkWdnMkhZMBpEfqi1G1CbUg83QIBtmpfCTerx8WhcY9Lqu
 gDYvkjTbtPQYNQ7R1dLnYpPdIm1l2lVV9uhSN8I5er2EYoqPMjRXVj9qgeOZX4BF6GUKI8xIjXb
 KIjnQirzgr5Yyf3rvM=
X-Received: by 2002:a17:902:cf07:b0:2cf:ba10:6d6 with SMTP id
 d9443c01a7336-2d3b07f77c0mr97977335ad.4.1786729764613; 
 Fri, 14 Aug 2026 10:49:24 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df03f9sm6708081eec.19.2026.08.14.10.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:49:24 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V12 12/15] xen-block: Update tracking iothread users with
 holder name
Date: Sat, 15 Aug 2026 01:48:26 +0800
Message-ID: <20260814174830.1691540-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814174830.1691540-1-zhangckid@gmail.com>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace raw object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/dataplane/xen-block.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..9dfe06e1be 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,15 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
         dataplane->iothread = iothread;
-        object_ref(OBJECT(dataplane->iothread));
-        dataplane->ctx = iothread_get_aio_context(dataplane->iothread);
+        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
+                                                          &io_holder);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
@@ -652,7 +658,14 @@ void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane)
 
     qemu_bh_delete(dataplane->bh);
     if (dataplane->iothread) {
-        object_unref(OBJECT(dataplane->iothread));
+        g_autofree char *path = object_get_canonical_path(
+                                        OBJECT(dataplane->xendev));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
+        iothread_unref_and_put_aio_context(dataplane->iothread, &io_holder);
     }
 
     g_free(dataplane);
-- 
2.54.0


