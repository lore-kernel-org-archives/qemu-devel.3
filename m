Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96841C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFe-00063W-I4; Wed, 14 Feb 2024 06:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFA-0005Dn-QL
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDF9-0007MJ-7c
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jXLu0fCpWfnRtLL6HbFiblf7I9UT0za8sM7v/5jTM+w=;
 b=XucYV0lbnaYTJeTdWOgZZRNWqJ3G0aUmvypUwFXrBBlYHD2ULukL44VgWtYXOpwkpB1KMi
 qoG6NrO3Hur/S8cCIzVr76s9KwDGmdLJDt2//EYJsITviTkzd3GQlXUEUQ8QZW1mnltMtP
 QzOpYAUD8rnJ45kkVsT0+f7FrhKxQcM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-Gk_A__JQO_udcFjFuh-f_g-1; Wed, 14 Feb 2024 06:15:57 -0500
X-MC-Unique: Gk_A__JQO_udcFjFuh-f_g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3d130eb757so78351566b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909355; x=1708514155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXLu0fCpWfnRtLL6HbFiblf7I9UT0za8sM7v/5jTM+w=;
 b=AH1sRf06jyXB77weEi5BD/ZoB50z6MhydfJxYytk8UD0ifL4BfeiX1FYye9YRDq6hM
 mkpdyLR0wJbT0SZCIpbHon8+1JUeM3wphyfMJt1jarRwycC6QrOO5fedrPFQMP6T5/xs
 JpDPaIBR1o3MVkGhxWwJksA/aBnCC1ypJlLfBmgQtcwj0CQtBZJC2tScqGr/P01Sr8q5
 2mb4Is9btu8zIR73jT3cR9nGm0IXGfPV/FSnsNe7bTV4qtrPAcHGZBWDyRjmMt13ToVQ
 /29z6G1G9I1L1L407vG47jWnPW5VVIOHdrbSHIcVkaWa/sMEYoq+ZvOlnM9lhUyyWeIF
 zW9Q==
X-Gm-Message-State: AOJu0YxtGWG+d816ITWTD9SAbJDcQsEodXfezKayVVHJYx4i0FbytOxz
 /ITptMp3GmbKjkTp//ilO6SklSFQuM7Y7KO+rX7oicmQP9nw9XpHFDsIPtMVsFnlllKp0NADKWD
 RUxtiyKhImSiBRqxA117gdHfAqNwDS2D/gVBCXXFxA1teIIW+5BsZjNPNCWV8+HoAYqSBAnzKpc
 49H06RL/P+INd0tkZ3Bc3ahsS+J9uNDQ==
X-Received: by 2002:a17:907:11dd:b0:a3d:14ce:9559 with SMTP id
 va29-20020a17090711dd00b00a3d14ce9559mr1731954ejb.47.1707909355657; 
 Wed, 14 Feb 2024 03:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMk3fGggdN7rV6DGx0uZNRADkZLIrHTBB0mcmPVTl2mUAj/ZHVdfPG8MkB+FIjZvHeqHWe7g==
X-Received: by 2002:a17:907:11dd:b0:a3d:14ce:9559 with SMTP id
 va29-20020a17090711dd00b00a3d14ce9559mr1731937ejb.47.1707909355377; 
 Wed, 14 Feb 2024 03:15:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWqF2qsjT5X+q6kX2hlufXVFjpV0Cy1G7bDvCZgUkXTfdvHobILCFv6pcLSwet0uEGw8QGnyOWdeYpsYTrTIVsXiJ1rtB7v24YA40nPJORS5JULWQXBfNYH6VXerzMLOQ==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 qb35-20020a1709077ea300b00a3840fbeef9sm2203879ejc.70.2024.02.14.03.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:54 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 50/60] hw/cxl: Update link register definitions.
Message-ID: <40ecac10c03aa74deada32a1ee7af1ad9750d483.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Not actually implemented, but we need to reserve more space for
the larger version of the structure in CXL r3.1.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126121636.24611-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_component.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 7d3edef1bf..2c7631bd1e 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -104,10 +104,10 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
     (CXL_RAS_REGISTERS_OFFSET + CXL_RAS_REGISTERS_SIZE)
 #define CXL_SEC_REGISTERS_SIZE   0 /* We don't implement 1.1 downstream ports */
 
-/* 8.2.5.11 - CXL Link Capability Structure */
+/* CXL r3.1 Section 8.2.4.19: CXL Link Capability Structure */
 #define CXL_LINK_REGISTERS_OFFSET \
     (CXL_SEC_REGISTERS_OFFSET + CXL_SEC_REGISTERS_SIZE)
-#define CXL_LINK_REGISTERS_SIZE   0x38
+#define CXL_LINK_REGISTERS_SIZE   0x50
 
 /* CXL r3.1 Section 8.2.4.20: CXL HDM Decoder Capability Structure */
 #define HDM_DECODE_MAX 10 /* Maximum decoders for Devices */
-- 
MST


