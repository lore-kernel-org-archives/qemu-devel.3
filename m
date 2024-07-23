Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9358C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDD0-0000dl-2C; Tue, 23 Jul 2024 06:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCo-0007b4-0P
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCm-0001pm-FI
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hq4UcO9VA6wUCWPh+nsmUKYS4qa8nT+9OsSYlXgNtFk=;
 b=BCNrajToRvOWZ/l/Hwu8v/qHwfMgopz5gMWf8Jdm31xMZeEjXeRbtIwW7VgsN2aruQIEU0
 IfuWr539+V/2c4dgNyxQ0XJyrOzB08mpEozI9c+6ovFSE6oAeXfW7pRe0Ci5d/J3yBxp88
 blu7a/zq3j5B9HyiKJKXcdKR22Fg7J4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-OFSDCSTcN1CoExorfHofUg-1; Tue, 23 Jul 2024 06:57:13 -0400
X-MC-Unique: OFSDCSTcN1CoExorfHofUg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a77c6ea022fso114972366b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732232; x=1722337032;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hq4UcO9VA6wUCWPh+nsmUKYS4qa8nT+9OsSYlXgNtFk=;
 b=rnxK8TnMhb4ttSzZ60NNaS7G33+YSXVz0cjMsseEUXQWJy1TVQRFJjed63Zt1rxFid
 hLVvDH3wJtZNpivmsc4mlHk57eDOW/txWI18ZPtUIvqlUrj/eA7xAXRsf48pZxyj4+oM
 SbwDcyWTfg6zH53cmTGPDHIcR+/epGhT5tHRyD7LD8njLTEVCOIZqWJngld/r332OJxd
 Jihsf5yE4iKHeUUIvYSRfa1j0c7rBuqdm6imnO5atP8ih3zgMgAzIlLwSoL3Pp9NptJE
 WcjE5zcUfZ7rF+dMoNbtFssLg6Ocg2gAp94P5xSQJTjBV2GzpVoRgDt/+2ucUhP1o3MS
 21LQ==
X-Gm-Message-State: AOJu0YzQShL15TekZy5HcKXHvbZtigaFIV2Kp8r6io6ZlTFzn+K9t8Zy
 BsEDlK7xVa0Ra7jbzaoe4FGDgoofHi7BCLvqdLEnh8pR2/lpW/OsyWwUdTj+mOY442DvQsBNLkZ
 g7s42oGx7HOk7e2cAHZR99YpqjmNgxEKMXdkJFAwLh2F7iGYH/OVvstlNhZkG5pMN3lk6D8p+Eq
 C9kWaGMTcBAIbPYS2C5pstiiNjPtsAww==
X-Received: by 2002:a17:906:794b:b0:a72:afd9:6109 with SMTP id
 a640c23a62f3a-a7a9427d9bemr179256466b.16.1721732232093; 
 Tue, 23 Jul 2024 03:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHL7jyIfDFXSQ/d72+GKtR9rBxX7yfG4N0kg9gOGRBb5nwyx8wO6MsdoEGs9Tbx5KlxG4MLQ==
X-Received: by 2002:a17:906:794b:b0:a72:afd9:6109 with SMTP id
 a640c23a62f3a-a7a9427d9bemr179254766b.16.1721732231623; 
 Tue, 23 Jul 2024 03:57:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7aa309243esm22425266b.151.2024.07.23.03.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:57:11 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:57:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL v2 22/61] virtio: Add bool to VirtQueueElement
Message-ID: <c303aa0942589427b42192ef7cff75a79ef8646b.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Add the boolean 'in_order_filled' member to the VirtQueueElement structure.
The use of this boolean will signify whether the element has been processed
and is ready to be flushed (so long as the element is in-order). This
boolean is used to support the VIRTIO_F_IN_ORDER feature.

Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240710125522.4168043-2-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7512afbc84..fdc827f82e 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -69,6 +69,8 @@ typedef struct VirtQueueElement
     unsigned int ndescs;
     unsigned int out_num;
     unsigned int in_num;
+    /* Element has been processed (VIRTIO_F_IN_ORDER) */
+    bool in_order_filled;
     hwaddr *in_addr;
     hwaddr *out_addr;
     struct iovec *in_sg;
-- 
MST


