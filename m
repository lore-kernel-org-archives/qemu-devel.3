Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F5CC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSGj-00049O-LP; Mon, 14 Jul 2025 19:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGS-0003be-QM
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGP-0005Sz-SK
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nq46ULtCQdBYCwUYnfPbjV/Hw+qzSwlVVyuG3rjxrJQ=;
 b=GvvKOTIYQwwG8+2axyDJ9/gr2jyLKfbW1ZoYLMYMq+jq6KXGm1qfTNJKfvWRBk73MXBwUZ
 UpXGJGNdsvG7lxe5oIWu7GD3/KF7Po8a+JHEvfcmIEg8d4j4Eb6SHfwijRVk7DosrJElxr
 Zh5X1LIj8hbKYW4+pRWheI0ZtkqzwIA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-umamgG5oMcq6fIGP3NBCbA-1; Mon, 14 Jul 2025 19:07:10 -0400
X-MC-Unique: umamgG5oMcq6fIGP3NBCbA-1
X-Mimecast-MFC-AGG-ID: umamgG5oMcq6fIGP3NBCbA_1752534429
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a6d1394b07so3439760f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534429; x=1753139229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nq46ULtCQdBYCwUYnfPbjV/Hw+qzSwlVVyuG3rjxrJQ=;
 b=r6zHBzndXTnSzjXGkMJe0BpKz2l/A1E0oqGpUHmJuJg63r+jSxzXHFvWmZxJ/8zgvn
 8mlu1WJ2uYRocL9QGvxKJsKd09nv/jdKDB+v9R4awx+syxCm3YXaybzve7KWkEOysKGi
 zJROngoRM2NFyZgZesIAdUvE5B3Tp8ng+NauLgNTDYmJ04bBFGP7K107vtD5JXX+XnOX
 dtZ+g8lr889GfOV0nOJtCwcgPBDhyLQDgd3Du76pOfP4WDv4Synik4yy8iAeZW4AnzH9
 eIM+V+TDb2B1ZFe2XdBUT7ppWb1eKqCeEFx52Z4qC1PdBjHV3EbUxWbi04SdYChdjiKV
 JTlA==
X-Gm-Message-State: AOJu0YzPn51P9FtY39HU6V6nXeu39J9yc0NRyzwGzoS8EyCxEzdeWqHk
 +09PIJT8hRWzMQEpuQ0z1/sUeKT5Lba3FtGFHpEwI3zhYO9QkEVR1uwCQOOm53Na3GOWklhMqQz
 o1QEmNnxkN8GuFCRGwrm0yJ0iazjMgRfgyzpeM7lKFTD4XN+Anon4VV6BvDSOJX9O3ucbrKRlsH
 bG6QKKt6q1E0rkQ/m/mCeKRSJHMN2cEKmDSw==
X-Gm-Gg: ASbGnctgiFd0AqSk+WVfVB2RSYvunlHfUVmQWvlEZeftR6+TcUFk2bRbT5FQT9E6fCS
 c8dLMlNqkLjNtLfNPw8B6t+VLNSSD8Mp8bBfFGrHoTXmzPf/Mt6iTRBb9lxyStb8xI9YRxPjxXJ
 0Qc9uw5jDrgeILbeMt6FFFZigcYqQ7ORjeqHv/JhYv8bbJjPx9UAvn26PRM5uCTbTYRpeDpsCmZ
 BreYfqy072IJFM+TPUOGPJVpzilC4iKr4MdEjfujZrHTnVIbJmB0OWghJhhnrbN+EjoZSosq4Wt
 ziZ/7D265cgGDBvy6K9+63Nq0N7wW1zU
X-Received: by 2002:a05:6000:188e:b0:3a5:1241:c1a3 with SMTP id
 ffacd0b85a97d-3b60a1a8fbfmr225010f8f.50.1752534428704; 
 Mon, 14 Jul 2025 16:07:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVKT1LYUCqLY8RUD86Fvv4VgAUyjcpyXpoPs2jPZQKGncMVn5mwZAZ96CasGV91bfKfeDvwg==
X-Received: by 2002:a05:6000:188e:b0:3a5:1241:c1a3 with SMTP id
 ffacd0b85a97d-3b60a1a8fbfmr224985f8f.50.1752534428214; 
 Mon, 14 Jul 2025 16:07:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d70csm13771713f8f.62.2025.07.14.16.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:07 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-stable@nongnu.org, Vasant Hegde <vasant.hegde@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 21/97] amd_iommu: Fix mask to retrieve Interrupt Table Root
 Pointer from DTE
Message-ID: <123cf4bdd378f746dfa2f5415ba084148dded3e3.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Fix an off-by-one error in the definition of AMDVI_IR_PHYS_ADDR_MASK. The
current definition masks off the most significant bit of the Interrupt Table
Root ptr i.e. it only generates a mask with bits [50:6] set. See the AMD I/O
Virtualization Technology (IOMMU) Specification for the Interrupt Table
Root Pointer[51:6] field in the Device Table Entry format.

Cc: qemu-stable@nongnu.org
Fixes: b44159fe0078 ("x86_iommu/amd: Add interrupt remap support when VAPIC is not enabled")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250617150427.20585-6-alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 988a485f80..96fc5b621e 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -231,7 +231,7 @@
 #define AMDVI_IR_INTCTL_PASS            1
 #define AMDVI_IR_INTCTL_REMAP           2
 
-#define AMDVI_IR_PHYS_ADDR_MASK         (((1ULL << 45) - 1) << 6)
+#define AMDVI_IR_PHYS_ADDR_MASK         GENMASK64(51, 6)
 
 /* MSI data 10:0 bits (section 2.2.5.1 Fig 14) */
 #define AMDVI_IRTE_OFFSET               0x7ff
-- 
MST


