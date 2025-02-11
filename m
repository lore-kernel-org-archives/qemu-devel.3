Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CAFC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz6J-0005hx-HI; Tue, 11 Feb 2025 17:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6C-0005f2-Ij
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6A-000556-Br
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+h7PqMkjUYUL06lu6YiwfavWSql50PnNNQ3ntizUZY=;
 b=YkkxwqplHqNkSrxENlgHLYQf0AijefZapm1cUG10be6CqlaN9PwjuiPhRFpNu8/Jtx+M2A
 mh0Y+UChHOG4DUkvgscjS+LOcj4NQ182v1MK6lwhgEe8MNBZ8Sfu+RSxYB6gyvn1X7Pl3H
 FRLSBNVaC8hK9G79nidffTcUI4A7MpY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-4Em0lLJhM5GEe8RiejS8eg-1; Tue, 11 Feb 2025 17:51:19 -0500
X-MC-Unique: 4Em0lLJhM5GEe8RiejS8eg-1
X-Mimecast-MFC-AGG-ID: 4Em0lLJhM5GEe8RiejS8eg_1739314278
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-724d17262dfso712939a34.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314277; x=1739919077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+h7PqMkjUYUL06lu6YiwfavWSql50PnNNQ3ntizUZY=;
 b=TLgDtkzdcACbkns08fJpN+l3trr/oGhGV2jmFLh4xO1w9U8XyljcDn/AYmiUn1e8Tm
 PaKaBJb/Vg3h6axlY/UJPBaozJrN08c811GTY9Aqcg/9CW/+gV/KBn5HYMOZqRRCSagB
 n14C+qwr7QoTfQOiU3isuGRmDdXO+c8rS+g49uVIFYFbKJwA0Sn4XXF2BA5otuSscnI7
 0GITNjq+OHU7pPU6o0cTiPlOLA7U0XhVdfTMJhKVllaXiOOsTmbRmlN8kk6DkukoEc2y
 jaqhIvNauhDlp1sA7Hs9EV00dZ4SMU+2DrElzYxGl1UP86+rgLV03dy4/wxvQIogB2Py
 3N7Q==
X-Gm-Message-State: AOJu0Yyc+lRwfAOJoyQcexQyWYYiAwFeHcZ5IZlJiXfdSw2EtPKSy8C2
 5y9SU18rcWMWDMBab2/IjOzMgGzMrGKIzj/z6zILOO/W9mCsLzGq22ShLlaX3Zterdrvs++GlAr
 D8tVePeL+k0xXgGDisa/JTkWl04Kd7UCGpTi8s5dPTiUL5NDJwUT01KIsqVBT4+G+NonCX8dFee
 G/keHYz8qUw6H4s2VCSMIjDGk21/8pBfaeZg==
X-Gm-Gg: ASbGncsN4tha5wD5qeOirInd7wKZxRlrRiogSRSC8PXjxnIdYwRVauwyGAXSb658Q3t
 A8rQI2+SDfouCr3QP10sAvvZJoRyrK1tG/gPqPTaeB2Bg5Zmm9KLtsFzSw67wYyoKAxsZ6G4naV
 lZmxpSAFHpNOeaMslTX+M0KGBlBXovW7fejXMNvP5zWAbrzDULGrhbgqXQhvPS/1I0IjL59zyK9
 5dswRpdEwgqFDcEA+a/NBIBCJjkG3axCmpQpsOjhdRK+P814ig6hk7X
X-Received: by 2002:a05:6830:6dc3:b0:71d:5336:df80 with SMTP id
 46e09a7af769-726f1d158eamr924602a34.20.1739314277762; 
 Tue, 11 Feb 2025 14:51:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV+XBIrrNnTI9PUV3PLUrTZUR8P5pfM1YUE3TLx9Sr7ATKcIDOMXugWNd3Xo3fMfXqzMyt7g==
X-Received: by 2002:a05:6830:6dc3:b0:71d:5336:df80 with SMTP id
 46e09a7af769-726f1d158eamr924582a34.20.1739314277308; 
 Tue, 11 Feb 2025 14:51:17 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 08/14] physmem: factor out direct access check into
 memory_region_supports_direct_access()
Date: Tue, 11 Feb 2025 17:50:52 -0500
Message-ID: <20250211225059.182533-9-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211225059.182533-1-peterx@redhat.com>
References: <20250211225059.182533-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: David Hildenbrand <david@redhat.com>

Let's factor the complete "directly accessible" check independent of
the "write" condition out so we can reuse it next.

We can now split up the checks RAM and ROMD check, so we really only check
for RAM DEVICE in case of RAM -- ROM DEVICE is neither RAM not RAM DEVICE.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250210084648.33798-4-david@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index cb35c38402..4e2cf95ab6 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2995,10 +2995,13 @@ MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
 int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
 bool prepare_mmio_access(MemoryRegion *mr);
 
-static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
+static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
 {
     /* ROM DEVICE regions only allow direct access if in ROMD mode. */
-    if (!memory_region_is_ram(mr) && !memory_region_is_romd(mr)) {
+    if (memory_region_is_romd(mr)) {
+        return true;
+    }
+    if (!memory_region_is_ram(mr)) {
         return false;
     }
     /*
@@ -3006,7 +3009,12 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
      * be MMIO and access using mempy can be wrong (e.g., using instructions not
      * intended for MMIO access). So we treat this as IO.
      */
-    if (memory_region_is_ram_device(mr)) {
+    return !memory_region_is_ram_device(mr);
+}
+
+static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
+{
+    if (!memory_region_supports_direct_access(mr)) {
         return false;
     }
     if (is_write) {
-- 
2.47.0


