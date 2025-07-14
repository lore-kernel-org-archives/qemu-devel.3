Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB68DC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHZ-0006QI-NI; Mon, 14 Jul 2025 19:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGE-0003Cv-BB
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGC-0005QX-PA
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4CnxIUW7kVE0GjlDwzMxMW/1BUSPeNP58LvpQij6V/w=;
 b=DrF5jLJj8Aqy/P66mPTdHXpqi5VVMD0uQtt+8iw8hhktSLBs3NMYSSlSUGWJNRLo826mjS
 ZBeXL1yEpN0DuLwdmBIp+mYVvvbREWSUeaBw5cjKhsTsIuX8e/Wx+XvRYmbwglbMNdYgn+
 qHuP1eIH5N23oYzSH8pTCC09L7VPBnU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-THazAMQUMIKvc41pE2mVCw-1; Mon, 14 Jul 2025 19:06:58 -0400
X-MC-Unique: THazAMQUMIKvc41pE2mVCw-1
X-Mimecast-MFC-AGG-ID: THazAMQUMIKvc41pE2mVCw_1752534417
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4538f375e86so39559925e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534417; x=1753139217;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4CnxIUW7kVE0GjlDwzMxMW/1BUSPeNP58LvpQij6V/w=;
 b=ljIE0O5NUKosFwDYr2/NBa1b9yEA2gGv2WCX/b2puC47Ic5A6Mqoln9sJRTfnJzpLa
 GwBXekbJ3LwOTTXAuuViMf/qNB/239YcOrATRLL5YoqlnDqRbRptPhIAptgst3fYtQ7P
 wh18pZqOcIr+Zd5he2Wsb+EBVt2Ge5spRaG3MdlIlry641u2kpDIv63cjoEELKwvEpar
 +for+m9Rb3rEgLZyxWfhCMGYIeCl8D2ir49jVE8CCMi+AvzR+G0DoO98jx104+GblF/g
 NRPIZ2iYQvw7n2p96/R7LR3Hch4iEKJ0xAj0Y12CJnS/dypw/zR/ROzn55A8ZNopuPY7
 W22Q==
X-Gm-Message-State: AOJu0YxSWmAPNXdvqRF2yNRVuQF43lLOlGc+1bxzaeE9LU5DI2J7Z5po
 y1hAO8C8Y4bRtdfZuaIMDk43D2KaLL4oOBqhomlP+Gbuq2lPUNHwS+ei1FiWUd7kqLboGG1uNuO
 /pd7xip+zPPAe8bQD7BoUXgrcNSLi7skLfy9VvZLcrGa9ysZMKFXZ+DwGtZmLYFY6KmX4MihnrN
 X++8GwymrGOaFvTzNFRq6iXW3UNsRgEZ4aLA==
X-Gm-Gg: ASbGncvkEgO/W/i1YT9AURZ6/47po2xdifj8U2Nu/OgKHiF/pi6f3M7uAFAubPcKwlA
 XHj8dSvLrSlkjSSSmmBYa7aTg4DzB6DQyRPhWRGmsin035JyY0jnssfceY59Y6/QjcxGz9dGe32
 Y1VpkCmFzRjjqLkJHGA5ygQ0xRAd9TSwuziydIMex08fntki8+IlURQ7QsGP4Osx9ZQ6Q+Ohz+R
 tdHOPW+IiHXUEiFFAMxaLNThXddSplezNshewQ+gdnQZgLKstaSsfG9hGGRqOg8MPNb8pW8ZVHM
 hkgFFVXuGM2PhVsBBgu9rRG5oAfkGAO7
X-Received: by 2002:a5d:5f50:0:b0:3a5:5270:c38f with SMTP id
 ffacd0b85a97d-3b60a0dd825mr294252f8f.0.1752534417058; 
 Mon, 14 Jul 2025 16:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKkMQw45iVsa2Z2HX4ouQwGxF7oOjEyF4aMk5G3xI3oGCfGKqGiMu2rfEYYYWHdnKrY7m0Lw==
X-Received: by 2002:a5d:5f50:0:b0:3a5:5270:c38f with SMTP id
 ffacd0b85a97d-3b60a0dd825mr294234f8f.0.1752534416573; 
 Mon, 14 Jul 2025 16:06:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560733e736sm87742205e9.29.2025.07.14.16.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:55 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 16/97] hw/acpi: Fix GPtrArray memory leak in crs_range_merge
Message-ID: <d7fb5693d9ffbeb9b49c981e1f9774392f1d41e5.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Li Zhijian <lizhijian@fujitsu.com>

This leak was detected by the valgrind.

The crs_range_merge() function unconditionally allocated a GPtrArray
'even when range->len was zero, causing an early return without freeing
the allocated array. This resulted in a memory leak when an empty range
was processed.

Instead of moving the allocation after the check (as previously attempted),
use g_autoptr for automatic cleanup. This ensures the array is freed even
on early returns, and also removes the need for the explicit free at the
end of the function.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Message-Id: <20250613085110.111204-1-lizhijian@fujitsu.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/aml-build.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index f8f93a9f66..cb817a0f31 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -160,7 +160,7 @@ void crs_replace_with_free_ranges(GPtrArray *ranges,
  */
 static void crs_range_merge(GPtrArray *range)
 {
-    GPtrArray *tmp = g_ptr_array_new_with_free_func(crs_range_free);
+    g_autoptr(GPtrArray) tmp = g_ptr_array_new_with_free_func(crs_range_free);
     CrsRangeEntry *entry;
     uint64_t range_base, range_limit;
     int i;
@@ -191,7 +191,6 @@ static void crs_range_merge(GPtrArray *range)
         entry = g_ptr_array_index(tmp, i);
         crs_range_insert(range, entry->base, entry->limit);
     }
-    g_ptr_array_free(tmp, true);
 }
 
 static void
-- 
MST


