Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6698CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 14:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utoUi-00079J-Hx; Wed, 03 Sep 2025 10:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1utoUh-000793-D7
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1utoUa-00016Q-QP
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 10:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756909779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ntVDfuFQrn0Zt+l60khLVsQmuaNIn9T0GzOlkvDv2zM=;
 b=cNRUIKXH2ySPV4yVk2CsyUP3rTK5YWSfJVzO6yl2xa/RP/e2bceovvGsmTgbMXYg2vWYKl
 keT5u8V8a428hIKxepKs0zv47/59XH1taQEVGSo1PCdkC+c1K/dU0SA6omAU65eWIQybpw
 GBkaHG6ccCRCTWuBuMtUirOe/hL9lUY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-IZntmxJ7MUW5W1iZfl_T6A-1; Wed, 03 Sep 2025 10:29:38 -0400
X-MC-Unique: IZntmxJ7MUW5W1iZfl_T6A-1
X-Mimecast-MFC-AGG-ID: IZntmxJ7MUW5W1iZfl_T6A_1756909778
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b32d323297so70040581cf.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 07:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756909778; x=1757514578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ntVDfuFQrn0Zt+l60khLVsQmuaNIn9T0GzOlkvDv2zM=;
 b=r2UbYVsET5Rp2tbjWqSqAhx0tUtMwVpZq86CTtlBSd5p7KCKBoE6S/ZutnwkobeY9q
 5ggfVCv9nYDcSTABMqEnoCdfusiz5cBPZLBVEvPXiRgka/4PuRXskCmYt5OcBECmltzV
 H5uEpEX7ZiZCbhGvPKgDPJDUnd4CxK2slfm5HmhNJa0Gb9zQYjKYDeJ03oCrzaJEkpik
 Gv4t/tqfXaopaqQKAASoE+HaunUNAnZRtAgsdj4/ZHORzlbB29tvR+TAhIeh8EzUdV4d
 /V//WEqxAz5xgAOLt4hgmXt8R6HgncVOEzdtWMLpgO6SSUhAEH4eJfQobZInCMyha08T
 yv5A==
X-Gm-Message-State: AOJu0YzG6mq3UJXY1/9o50hkGtpXbaxT8F1wocP2cCRPCUy5446sn9hg
 DiJl9sqGCSUmGXsrEn1f02mnuA9oRcpPi+hMrR9m4RRcvsIlr5Y6u369aeJ1Rl1rVGx5AcBpIkF
 Xb9NQUzOOEZgPMf45on8hvr27KUR9CCOlc9zYt8bodYwFq2eHNGW17T7Lz+JM6xbYFFaeN9QF7W
 i1AH8jQTpT9Jk1Oc9iOkva96n8c53PAfE5DdtdXA==
X-Gm-Gg: ASbGncu1Ss+kg96HF32y/Q62cUH9PofJOAnJpkPNIsFMrK0bit0v8CVGMVgDvbsVfO5
 /p/WpvoCT9KSxg2bjcDVo+vktl0GZX1G5YMxobymcW6xuWmXChs7+PSKHANvpCXevxHWVVxNsJ4
 aISpOoAJ6TGErnVz8IJ5YybSSGl+HKG4OaKVUEqh8Ulgo3sPFb9+9YkFhWvqqhUICZwEJN4L24p
 j5V3U8otqLJne+5aYWUCUmmDPADuSOZXe7KNufGUCIkChiYGoXQswWUunQR62LL6mPPTzwI7LMG
 4RGr8JD8Gz5i5NvQ2VlcAB/rpRNA4fSq51LM5d9c41MeqqO6/dwUYzNFiOaEQtz1gYjaOv0A4at
 aSqTzrZBqf1cqHo1pSFY=
X-Received: by 2002:a05:622a:88:b0:4b2:9b6b:3e with SMTP id
 d75a77b69052e-4b31d87474amr175450811cf.36.1756909777623; 
 Wed, 03 Sep 2025 07:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9I24oatP0KK9PdanOfNNKlZHc9626N0828Ct5Xo1fbN003BqqNx25/lMcmZe9yMjt4tzhBQ==
X-Received: by 2002:a05:622a:88:b0:4b2:9b6b:3e with SMTP id
 d75a77b69052e-4b31d87474amr175450361cf.36.1756909777030; 
 Wed, 03 Sep 2025 07:29:37 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f77f212sm12212121cf.35.2025.09.03.07.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 07:29:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] memory: Fix addr/len for flatview_access_allowed()
Date: Wed,  3 Sep 2025 10:29:32 -0400
Message-ID: <20250903142932.1038765-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

flatview_access_allowed() should pass in the address offset of the memory
region, rather than the global address space. Shouldn't be a major issue
yet, since the addr is only used in an error log.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Fixes: 3ab6fdc91b ("softmmu/physmem: Introduce MemTxAttrs::memory field and MEMTX_ACCESS_ERROR")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- Fix len as well [Phil]
---
 system/physmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index f498572fc8..d1cd85abd4 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3027,7 +3027,7 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
 
     l = len;
     mr = flatview_translate(fv, addr, &mr_addr, &l, true, attrs);
-    if (!flatview_access_allowed(mr, attrs, addr, len)) {
+    if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_write_continue(fv, addr, attrs, buf, len,
@@ -3118,7 +3118,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
 
     l = len;
     mr = flatview_translate(fv, addr, &mr_addr, &l, false, attrs);
-    if (!flatview_access_allowed(mr, attrs, addr, len)) {
+    if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_read_continue(fv, addr, attrs, buf, len,
-- 
2.50.1


