Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3F9C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjxm-0005OF-2q; Tue, 02 Jul 2024 16:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjx7-0004gv-00
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwq-00007I-Do
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jl4Qu4kLpM2wQ0qiu2Lf05x2qWhSbW1JbTTyjioPSc=;
 b=cEH5UZDXa4JLnp9tmixD6y3U1Z9uTw/7B5Py80sBEZFyxH2I/fUa2OdCG/V4QXFp8XyGQr
 EfnzYGyMBoRG6zTyF/mk4VE7MtT6isKRBzVW6oOrubXFdUjxR0ZNk10ou7wlDz8Z14r33I
 C3hp4HID/aH5DUWr5S7ycHJTwEwg8Nk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-AQmG2dZiPvSvuie1NwPVbA-1; Tue, 02 Jul 2024 16:17:54 -0400
X-MC-Unique: AQmG2dZiPvSvuie1NwPVbA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-425657ac234so31671225e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951467; x=1720556267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jl4Qu4kLpM2wQ0qiu2Lf05x2qWhSbW1JbTTyjioPSc=;
 b=KWfVnNcy58hMjF6/JMSTIUNBBeGwmMjTYCUzScBd995N0qpIf0jgJuSMz8OiYPgq2Q
 CZNN0wq1uS9IQC3bdXWeCTbtWYmAlypFRZse1GG4zviZtZzSGaZX3yvVRXMdLoKJOG+Y
 8yROiGstVEG3QnxxhxwbuR23mX4W5d2sT8Y9zv40cZ9NcdR8QscQvEgOe+MKduOapHAs
 LSJzYAfypGsm2kmfdmZxpULg/BtEO18JXOAOdUtcT+5z517IR+NN7h3bO2DXf/wbXMbS
 YYhcOv2C5U9j3yppCA+2JYZ1hCsSmd6F82hFyDx+FDv+wi9ahIic9jb0ajvAwMc4PRqI
 IEow==
X-Gm-Message-State: AOJu0Yy9l40ghsQ2/jeV1js2Hb9kRytoZlC+12I/62zzT2K64rg4esLa
 VoL1y9sZCA566HDvmjKuaN6QF69fbUy5AZ4oBi1/GqIlkmyLwvJYwpqaLwTsdi6yoFWf2axjYH1
 Q7zNHYeljkOODbAZEwkcUNjeYKplTDtrOtmvbXkWpGKa2rsJwVQcWTjr+AE1yalqpiihHBWPRHi
 hLdi+GOlVMfgQBU2tYInd5igHdtDnSmw==
X-Received: by 2002:a5d:47aa:0:b0:366:eb00:9dd6 with SMTP id
 ffacd0b85a97d-367756a3585mr9265107f8f.1.1719951467170; 
 Tue, 02 Jul 2024 13:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp14eLJ8dlhh1KHCfCwQQZcy5wYS3hrtHsPaI4ICLq0U5CTu7sYEGsfZuQEkbc+Q1X2hNvVA==
X-Received: by 2002:a5d:47aa:0:b0:366:eb00:9dd6 with SMTP id
 ffacd0b85a97d-367756a3585mr9265077f8f.1.1719951466528; 
 Tue, 02 Jul 2024 13:17:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1030dfsm14065950f8f.100.2024.07.02.13.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:17:45 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:17:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 38/88] hw/cxl: Fix read from bogus memory
Message-ID: <e6c9c9e7f46a9ecaf1d90a68595915d65cd9d72d.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


