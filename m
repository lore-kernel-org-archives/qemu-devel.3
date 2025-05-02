Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51D0C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtSV-0007eZ-8y; Fri, 02 May 2025 12:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtST-0007dx-MS
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSR-0006R8-U3
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YhEfo/crAEyxYhDSWP1l8LRwgjE5vzXQPMbrfXIzcrY=;
 b=VXGprtUjKCUuMavORY1AI60jA9wLegbTdhafOaydeTXQ6uBlQ2IwjZOVZbFtl+rnJQcCde
 VFqXmbdmpRS+6BnEJG+W3QPjOddlRNSei6fv1AKLXl3VUJJUu4PQ8OilSjeYlGuNXK/Vqi
 0a6WwRqxMGbaA8EPEdTgMgW/zMu4Ex0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-Ug5r5DfdMm2ROm0FPQIX7A-1; Fri, 02 May 2025 12:41:49 -0400
X-MC-Unique: Ug5r5DfdMm2ROm0FPQIX7A-1
X-Mimecast-MFC-AGG-ID: Ug5r5DfdMm2ROm0FPQIX7A_1746204109
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c3c8f8ab79so342584585a.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204108; x=1746808908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YhEfo/crAEyxYhDSWP1l8LRwgjE5vzXQPMbrfXIzcrY=;
 b=ZF5srgpPMOqRIvVjjSU8/3llFXrxMikWyCyPuL2BdgJn3eTPavDXo4MhZDRijiuwLu
 GeU8l3mSrw5tzxNHPes1o5olZ6ADQqA0IyofuGoHHiMUHfmTLDis8psHd8/hosfFiP4P
 5ExXpi6S/vNpXNrfqaUfD/KoJCxenVSbp9cPj4KtUqXS1Vdygi0MCn32+ZYq+StyUY2W
 pUtrG+cxtwLWJ6Kwp/RruCoxuClNVZFAas8nXUuGnwkHLIbeBx4Xtku/BKmXk1BTSWlK
 pB8ICCMnk4GGhdCuQH/rzeN0tZT/DYfa9ysduAyP0UJxEU96+wMg7Q9VosFv0CK1JHA4
 8v4w==
X-Gm-Message-State: AOJu0Yx1q2k5dtC2WJZzPeqNqeW1Y3k3jMdytfH1V4GCEzOe6KmKkhgL
 r0FNeMyeu1qJHwN386W/kU/mVzrCcmQqjB9cY7DU1iUom3ykf59645tTXcEwsiAoTwI2dFShw4E
 l9fFaQKvicEjGF17a3r/Dhzw8V2T/2+guFLxpGnqiGAwJPbzTPNH6LRCSJTymzcUst51R0L6BaO
 EO4zjP9wBEtQb/cvgXwr+2rU2PxWtxODiaFQ==
X-Gm-Gg: ASbGncti/j/UBJjsZgvAulNP6x9hbRx810gayS97CCUZVG+d/9V+sWLsMnQfrNCECke
 JVf8yHkkSSiaTQ4PYM6Djx9LzIFUFIf592TCqQ9vrjMiCQcTIzUS8QX2wjp0wGkxeFgOZsN7P6+
 NxkrDzRgW9KcOf9KwBETcUNAxSsz365sP8jkKBCBNecgGB+jK1ggOIgV9feI8dN8AYF/vWD/i2l
 00Osmh8DbWyFFO+Z4bNZprGQgqU4e3Am+fHE+IE30abbsM1d/SL+yZWoLQ/lOx3xf342uByUHhb
X-Received: by 2002:a05:620a:4111:b0:7c7:747f:89d0 with SMTP id
 af79cd13be357-7cad5b3e38cmr506280585a.18.1746204108477; 
 Fri, 02 May 2025 09:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs14xF8eu3NbGT/nPm0RNHfb80OXKRMVtgmQMULhElkPHy0CTxprx+fNpHHb2qr+h40WjWfw==
X-Received: by 2002:a05:620a:4111:b0:7c7:747f:89d0 with SMTP id
 af79cd13be357-7cad5b3e38cmr506277785a.18.1746204108152; 
 Fri, 02 May 2025 09:41:48 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:41:46 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 02/14] migration: disable RDMA + postcopy-ram
Date: Fri,  2 May 2025 12:41:29 -0400
Message-ID: <20250502164141.747202-3-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

From: Li Zhijian <lizhijian@fujitsu.com>

It's believed that RDMA + postcopy-ram has been broken for a while.
Rather than spending time re-enabling it, let's simply disable it as a
trade-off.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Message-ID: <20250305062825.772629-4-lizhijian@fujitsu.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 1f3602839d..4ba8fcb7dc 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -458,6 +458,10 @@ bool migrate_rdma_caps_check(bool *caps, Error **errp)
         error_setg(errp, "RDMA and multifd can't be used together");
         return false;
     }
+    if (caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+        error_setg(errp, "RDMA and postcopy-ram can't be used together");
+        return false;
+    }
 
     return true;
 }
-- 
2.48.1


