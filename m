Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5601C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 22:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2KH-0004kR-VN; Tue, 27 May 2025 17:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2KD-0004j6-9v
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2KB-00087b-Uq
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748383147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6TUQBg817ppc4hwW9V6NKciCAGQ6MOuLEm1abHL7GjA=;
 b=Kr+lLx9tHDRwfW+7aUBpSw7c9uA5oIgcKuoG8389NCFbX+GYBAYaIT/8XHwJLVR8AJIlvE
 W7dS8F9Phn/HZLigrYrBBZOidIeHn1PA5eoa6Saum3Wcp285eSGi2PKBn0bpMhFQrsykZP
 XCVj+TYufFs+Ab51iJwP2sW7m0Gxqt0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-0vEhhQBlME2iLB6q7yTj2g-1; Tue, 27 May 2025 17:59:06 -0400
X-MC-Unique: 0vEhhQBlME2iLB6q7yTj2g-1
X-Mimecast-MFC-AGG-ID: 0vEhhQBlME2iLB6q7yTj2g_1748383146
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6f8cc1c047dso54346806d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 14:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748383145; x=1748987945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6TUQBg817ppc4hwW9V6NKciCAGQ6MOuLEm1abHL7GjA=;
 b=KtaHIs57I+ckEIMMmCU6AxWnJsNGwBjr6IRSANjUVgynndqQOqz0iGagwaS9NOajA2
 RnTInxhAOm/FH7U6kLDgPAGVFA1YIfYLwzcj0qL592pfOGNJXfKfI2MdchKKtaqlZrqQ
 YNwntv/EimPJDXOBCeA/5A6xe74mO1xEe33+Q/Z+8fLNjILoH59+zsIaf8ICzeMI7Gs4
 m3xffJwUPr14Dt3GJICoGcB8K74Nk3mH3dEkaar8TguMouBuV1vqzckmOW5t84FDTykk
 e7xjfaZn0RjU/gbU37YBcfe9YggxRfdA9jd34hr6zbw4N4hH6E+7y4ndnXgBzcqMF0C5
 acBA==
X-Gm-Message-State: AOJu0Yy5/WVmDtsbymHyPRe+T5PqDBkC2W5MMXNwqWNudUJI3j4Vql4x
 ZUbydWMHZ+LqrlzGt/nCrNi1ks/yaZyrzJUxNN5Gaxn2AxI6Nz8LkxlA1V3T74AVZuPlvYMbL+V
 cxEqqLZIe/ciesckV80PgptFAmJ8BHpKfMAIh0XDW6m65o02Nf8WKLDcMrjkTdti2VAPq4rWwau
 QOYS7DEdQLeNFVHMaKkqVheZiUQingCSFdN3X8rg==
X-Gm-Gg: ASbGncsldMSGH87rR2BInw+3J4sCf0kpNWXvGvFGDcdsWHoeO2wlt2kfs03CMrOMlmq
 WIPSlsy6BqJh3Qq5x469xvKWQEs2EL6WbiJKStlK01v+kB1z7x5OIhZHnFtVu2ZasLjzrNQg75S
 uzFjAueZd8WZbXQu325KWK+P0zj26RSvbWkK0EFy+CMOfU4rf6HlxdUG4PHfnQ9D95EMyIo+SDJ
 5A4okG5wr924/B+Ff1MM6brrwRdY/7J9rl9E7fw1HntA+k4vk9so7axrH5IGA1YcmI08LcHMSjy
X-Received: by 2002:ad4:5bad:0:b0:6f5:f6e:832a with SMTP id
 6a1803df08f44-6fa9d1435d5mr258021026d6.19.1748383145661; 
 Tue, 27 May 2025 14:59:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFypgnMHOX4jOU4YmiHsfZadLDtx0r6liB9kC9uf7mOCrKAoMH8U8WnLFreIzpEWO0NvldS+w==
X-Received: by 2002:ad4:5bad:0:b0:6f5:f6e:832a with SMTP id
 6a1803df08f44-6fa9d1435d5mr258020736d6.19.1748383145374; 
 Tue, 27 May 2025 14:59:05 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fabe4f27cdsm914516d6.49.2025.05.27.14.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:59:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 08/11] migration/ram: One less indent for
 ram_find_and_save_block()
Date: Tue, 27 May 2025 17:58:47 -0400
Message-ID: <20250527215850.1271072-9-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527215850.1271072-1-peterx@redhat.com>
References: <20250527215850.1271072-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

The check over PAGE_DIRTY_FOUND isn't necessary. We could indent one less
and assert that instead.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ed380ac86f..c66ad3cf8b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2285,16 +2285,18 @@ static int ram_find_and_save_block(RAMState *rs)
         if (!get_queued_page(rs, pss)) {
             /* priority queue empty, so just search for something dirty */
             int res = find_dirty_block(rs, pss);
-            if (res != PAGE_DIRTY_FOUND) {
-                if (res == PAGE_ALL_CLEAN) {
-                    break;
-                } else if (res == PAGE_TRY_AGAIN) {
-                    continue;
-                } else if (res < 0) {
-                    pages = res;
-                    break;
-                }
+
+            if (res == PAGE_ALL_CLEAN) {
+                break;
+            } else if (res == PAGE_TRY_AGAIN) {
+                continue;
+            } else if (res < 0) {
+                pages = res;
+                break;
             }
+
+            /* Otherwise we must have a dirty page to move */
+            assert(res == PAGE_DIRTY_FOUND);
         }
         pages = ram_save_host_page(rs, pss);
         if (pages) {
-- 
2.49.0


