Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EFDC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8l7-0004pj-DL; Wed, 03 Jul 2024 18:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8l1-0004Va-Sl
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8l0-0001ao-6i
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jl4Qu4kLpM2wQ0qiu2Lf05x2qWhSbW1JbTTyjioPSc=;
 b=fWPd8LjsH3d1sKln/PUdIdxzuhAbAteGCXq2U7UCLTt5NkA3K6PnXRhObUXJVnnGTQE+Pk
 vfbZJaeJxGqJLX5cCPnO8DU5Ep/tcoP+P41yMcklEUMNcNvXcVzSaRxOnIrko6bqEqYZWq
 56ia9Rlr89Xuw9NB/NKudJo/FuOW+Ew=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-BmsJdodkM_esErekfvqRWw-1; Wed, 03 Jul 2024 18:47:19 -0400
X-MC-Unique: BmsJdodkM_esErekfvqRWw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7194d0fd53so2218166b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046837; x=1720651637;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jl4Qu4kLpM2wQ0qiu2Lf05x2qWhSbW1JbTTyjioPSc=;
 b=enHpUVKW1vw3Ac8gkVg7bhUXCy2qof4FpsHRV7nvMM/pV6m+f65H8h+BK+MlfC0UAO
 SjDJBvPyNcZSg73/Pjbk5SRGRDJN10u0JHyuX/rhpbh0HMSpXHht3T7PbAcGEQKRJ7IW
 ksOuxW0Uf1zNPijBeuxdX2c2et1EOTkz1YQiPVbf9KDX/HOyejfCt4ehtW/lYSg7fBUm
 h1ayidrqF8MTzv9bo7EAmY2fDFMoDSYSAWSang5oBxENTURtfU3Cy5DO4OEahMkInMVf
 D5oxKPu0ykjA+RR/OLB2qYYRzlxWDHLRm5pTdwAmAP35iLgLgbXSQfx8fibMOVGwSYFe
 /17w==
X-Gm-Message-State: AOJu0YxHTGaXHCNs6ylOJRldBS7Yf3xFOx0/a+YenqkLJDdjxv3auUWj
 DtngNVhRLe2bEyh/Y6bhxsWBOEr/9KNkTSZVYdm6UoRJ+Un7J+TrmpgSU6MxWSXn3FNXw11BLhP
 0G2VWtldFzl3xriR3rejLFTSdg2snYufNqDS5LphMgo0NNv6tqbT3h6YFQ5YkjeHgNtrT58+isS
 sMGZXU7FSfWvgb00Sq3XGxZsCVhV5YEA==
X-Received: by 2002:a17:906:782:b0:a72:75b1:2bf2 with SMTP id
 a640c23a62f3a-a7514498ab2mr733599366b.36.1720046837464; 
 Wed, 03 Jul 2024 15:47:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQC+9Xz5S/z4N2m/+2ZSYYlMZhXApoUf9RYtBIzxYEERcImlFtc3g7y/X7IVIQvK40oAL5yw==
X-Received: by 2002:a17:906:782:b0:a72:75b1:2bf2 with SMTP id
 a640c23a62f3a-a7514498ab2mr733598366b.36.1720046836794; 
 Wed, 03 Jul 2024 15:47:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf18493sm544775966b.7.2024.07.03.15.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:47:16 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:47:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v3 38/85] hw/cxl: Fix read from bogus memory
Message-ID: <e6c9c9e7f46a9ecaf1d90a68595915d65cd9d72d.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


