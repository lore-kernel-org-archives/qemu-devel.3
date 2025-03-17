Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FF5C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGSG-0007ic-QO; Mon, 17 Mar 2025 15:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZ9-0003WY-89
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:44:01 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZ3-0001Dj-TZ
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:43:50 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-225e3002dffso45153105ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742229821; x=1742834621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rk6IJKvkiGFyR1sJ6s9cHj4os4KvgEvO+mrUOM2U7lM=;
 b=DryDuqnDO/lKsoZ5KCvGVpNX2Y5ObvBvei8DM1J9wYUM6fOsDPSyhgIy+4FO6nwaIx
 XNYENlPX6IwumK5ez5QOI83CBQdto68wM8eHJB5Pea+BN6VyE0sjBmEGGuLRDbMQrE4a
 GlEhxmdfDF4C+4HK4UGcFOs1ZN0rz8KVdn+esfV0erViPR+atySf/t0SC+Xg9ScLk95O
 H6yAxSFG92FL7sxEaRi8e6iQPI1ofE8TkhzgNS/F+Web1DzkUxnH/BBWUbdzGojMS+h4
 GH8cAJT6JqcEhAGA89WivzbxQ2PPMVQFKkySVJhUVXffX74ahTjC0DEthiFSEaaS+VmN
 qoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742229821; x=1742834621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rk6IJKvkiGFyR1sJ6s9cHj4os4KvgEvO+mrUOM2U7lM=;
 b=S44iM4+dvRyjD4N8jVlsPJr040gJohFsXg/32tl+FCEb/F6+06j6Stxah5QxeqXcNV
 yhvngwCsHYrzZalNlpGyUCavOShR6IVxhPN+6hewr2RHniVMFmfqjqhIgKwpCVEFMC2W
 1hgeG5yASe5UYxlbQpzezd8wArCNJfKtjC7H2DvzW3juRuGR8K5Ahl4DnTQ12Otzz9Nz
 Lvz8M6VThZKyijymwW6M9jOnr41aNT2JBTgF/qRK4V7o+BN9SafQ+b5SzHlU3TmY9zIM
 LchT8hW/HwW2IO01GWNnu2moIIQOnur+KhcOGUUW3rifY/lCqUJl0cAtynFPCyspNd6n
 kEzg==
X-Gm-Message-State: AOJu0YxhlvMLMB0rq0iCdlmDrcCX998vRW7yrhOporbDyE0zOV8f7cIr
 QTOoZHa0t7pN0tokw5yBLnz74KHxtqZCR8vhZ3rj3v2XKb9/aPCJjvF5Bw==
X-Gm-Gg: ASbGncsqtvxlPo9jT/khGZBgwiehk5fnLnZP5jVPPShxZIhwUNfq9uR6h0iVQgXPkSV
 sWR2uFGKBztBqRGtHqG9n3RADgH6udP1+843kcY94iBJOpQXeaCTbm3jeQiaECut1YWWVCLSKI9
 sPLFERqiP8wPmCJrWrYBIajCpTYwH+o1HcEl6iAw1THPmCAP5bGfC3DUMeeV3mp9Q/+zDyj+2U5
 lInUgNp7p49jjj6R+ctHNo4n/h9gjHrpga4DrIT1wOD/Da3JQsRBVPzBHUJ4DL897qUjeW/S7zb
 gB5saDG8Mm6ZWgccQ26CbAEtgw+R1Ftyia7l4VjWchyE/2jtxLWktupaSuSp7FztvQ==
X-Google-Smtp-Source: AGHT+IHJF7qFLM+Pmkm+5K3dO4fVWd4hfqjmxUtHCW9DjeicaQbB8loeNTkjtv4HsY3E1p8uNG/mgg==
X-Received: by 2002:a17:903:19cf:b0:223:3396:15e8 with SMTP id
 d9443c01a7336-2262c562623mr3466815ad.22.1742229821467; 
 Mon, 17 Mar 2025 09:43:41 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:43:41 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 3/9] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Date: Mon, 17 Mar 2025 16:31:30 +0000
Message-ID: <20250317164204.2299371-4-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Mar 2025 15:48:18 -0400
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

From: Anisa Su <anisa.su@samsung.com>

Add dsmas_flags field to DC Region struct in preparation for next
command, which returns the dsmas flags in the response.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 2 ++
 include/hw/cxl/cxl_device.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 731497ebda..452a0c101a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -237,6 +237,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
                                           ct3d->dc.regions[i].len,
                                           false, true, region_base);
             ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
+            CDATDsmas *dsmas = (CDATDsmas *) table[cur_ent + CT3_CDAT_DSMAS];
+            ct3d->dc.regions[i].dsmas_flags = dsmas->flags;
 
             cur_ent += CT3_CDAT_NUM_ENTRIES;
             region_base += ct3d->dc.regions[i].len;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index bebed04085..81b826f570 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -609,6 +609,7 @@ typedef struct CXLDCRegion {
     uint8_t flags;
     unsigned long *blk_bitmap;
     uint64_t supported_blk_size_bitmask;
+    uint8_t dsmas_flags;
 } CXLDCRegion;
 
 typedef struct CXLSetFeatureInfo {
-- 
2.47.2


