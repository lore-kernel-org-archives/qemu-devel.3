Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE508C27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZWi-00024Q-Ua; Tue, 04 Jun 2024 15:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZWh-0001se-5K
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZWf-00014l-0w
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NEpjbSqv96acXddAF0b5elzpuXpH+2dtKbhhCEe0wtQ=;
 b=KlM8mKhtk2yxH+cb2goqT0wuEYQb/5APSw9WkiYTDi86oWkVvZ+DBngPIZJLfSTkjBHoeZ
 zACCVXmRasgYonlUVh+KWiV5YJGoLhDtETkbUSbyG0fpKIsNY4zbv3eWqWYSXf62iYazII
 uOE3cbxsHrfofvl+/1XnO/ZDT80cnRw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-8ZsILDqVOxOF1ZGJsRxwiQ-1; Tue, 04 Jun 2024 15:08:50 -0400
X-MC-Unique: 8ZsILDqVOxOF1ZGJsRxwiQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3580f213373so4020055f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528129; x=1718132929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEpjbSqv96acXddAF0b5elzpuXpH+2dtKbhhCEe0wtQ=;
 b=tNWa6xbazBJjKej1U5VrJzBBOmb3zTjZ3h9uHOGiZpBMk/uyMH4YEupFhzqVO4Jqel
 3ihO9qVsDCsKq9eHebDFbSxj3lo13dqYFlBg2AX+YFvo3bcvlmhKT7QixB0b2ORMpcc5
 BQSQqX4ByOHNx6cU5oB+uq0NoaJqwyfGFbeS/o2CYaPzMT6Fa21NivxnJ8O3tnEn17V1
 IXGI+1DmBL2jWkNhNDb5Q1w1W98cQUSkjjd8PThbT2X965F88pyeVNS+owxODxqDjRd8
 JCGIQF4H2HRb9sF0mDaHE6/4IfoWU6cQKVNC+ap7SIOoOJsvWRg9iPqQuY2/hlBf7ikn
 DEHw==
X-Gm-Message-State: AOJu0YwLn/8Y9ZQtJ7wIAj22DZcjzXmhcwvw0Gmes4R0R6B/Vu8QM7Ou
 0Wr8LFLW8ReK1C86YSBKNmcMCZm0PBWkc45N7Pfa7151GKqKLez2YxsyvnjkTUFRBjKlGr0r0M0
 UoxU2JBmOr2FakJ4dgvNRWHrsEO2tQDBIPE/OQy3qWk1bQwjiuHQ6zTn6jG+VP4MqbAV/U0S7CR
 a3uyl8tyQzK1Cz2sOEU7g4Xu0KGsxFEQ==
X-Received: by 2002:adf:ffc6:0:b0:35e:5b3c:b11f with SMTP id
 ffacd0b85a97d-35e8ef88604mr237889f8f.58.1717528128900; 
 Tue, 04 Jun 2024 12:08:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqaFhfQbrUrDlddkkqAJv2o2eqhwf4J8xkhEdAtGa1xSDl36wXfJBVOrnEHaJgDB5dM6S1iA==
X-Received: by 2002:adf:ffc6:0:b0:35e:5b3c:b11f with SMTP id
 ffacd0b85a97d-35e8ef88604mr237867f8f.58.1717528128446; 
 Tue, 04 Jun 2024 12:08:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04ca9b0sm12300744f8f.26.2024.06.04.12.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:08:47 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:08:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 46/46] hw/cxl: Fix read from bogus memory
Message-ID: <bfcacf81d63a3d95f128bce3faf3564e7f98ea8b.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ira Weiny <ira.weiny@intel.com>

Peter and coverity report:

	We've passed '&data' to address_space_write(), which means "read
	from the address on the stack where the function argument 'data'
	lives", so instead of writing 64 bytes of data to the guest ,
	we'll write 64 bytes which start with a host pointer value and
	then continue with whatever happens to be on the host stack
	after that.

Indeed the intention was to write 64 bytes of data at the address given.

Fix the parameter to address_space_write().

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/all/CAFEAcA-u4sytGwTKsb__Y+_+0O2-WwARntm3x8WNhvL1WfHOBg@mail.gmail.com/
Fixes: 6bda41a69bdc ("hw/cxl: Add clear poison mailbox command support.")
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Message-Id: <20240531-fix-poison-set-cacheline-v1-1-e3bc7e8f1158@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5d4a1276be..3274e5dcbb 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1292,7 +1292,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
         dpa_offset -= (vmr_size + pmr_size);
     }
 
-    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
+    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, data,
                         CXL_CACHE_LINE_SIZE);
     return true;
 }
-- 
MST


