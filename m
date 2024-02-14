Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAD5C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFW-0005rV-Mb; Wed, 14 Feb 2024 06:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDF9-0005DW-IE
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDF8-0007Lq-0X
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ggdbY/LPAEpu4bQnWL4QSYX6TO+5Q3+mttO5tostwE=;
 b=TTQeaM2V+B0NsPn9GYY/Yz+P0SMtjoijn0Cy9BbeUo3RKo1ZX2VJHMnOgUSZgFD23FrbmA
 VJ0ekf9vq5Mt6wiQnd0+tfh5/GWPz6O0tTENiZDP/yEPDm7O5TNlJSuyBlfyvudo3XQesS
 G6joYvDQ0ZEAqVO59+AFRZ9q8+nrEz4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-3h9edssKPGmvznQtXsHYIA-1; Wed, 14 Feb 2024 06:15:54 -0500
X-MC-Unique: 3h9edssKPGmvznQtXsHYIA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a3d481c7d8cso27693366b.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909353; x=1708514153;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ggdbY/LPAEpu4bQnWL4QSYX6TO+5Q3+mttO5tostwE=;
 b=j+VEyasWnrBVupl9oDFliFQYCYElwOiUbAdL1j277ZI665D/8kjxhaBdjcIOvWvy8r
 HBuicnisGyu0AC9fLgHr7hSWbir96YAmY02BRmtAUC91ODoZJFKOlW2ENS01ki1ob3JM
 icD3HIEYHgLeXwQXribYTi4yb7xvRh3UwjIaGXWuCVe5ZHG/GbmDEBpv7WjDxPDE/24S
 XEysGusLXeMxz3RG6jZcewMbQ9KujFRRpMRQiKQPBheJnEwp3Sdu9mxpevjzuOAsKGSR
 qCB4jBb7rFtC/J4r3gy+UmNQxVjb37aWN4EcPPzvpXu2qKVW/Nc69IPhQrCJzU2nYdZD
 VV1g==
X-Gm-Message-State: AOJu0YyaZj+mdVaeTqyrKc1BIbV8BPzM3+5mqWzhvQ+9Maw5KTkPSxeN
 fzHDlT+5OwnTTkVk6eMARKWohQ/8txnwbaDCd3hKUN2SNcztKmfbL9/8wyVoMxr1cKgSBmzInSW
 u8fcrFcmo8xWwF/KwHM3TVfW5d0yfKz2Rt8WOdn1XLwMmQx6GIAS9C4bVySBGQSULMXetQ95Ibl
 +PymU2rbhzmjw9KsQuZT9F3BFWANfsTA==
X-Received: by 2002:a17:906:bc59:b0:a38:916e:a4fe with SMTP id
 s25-20020a170906bc5900b00a38916ea4femr1588437ejv.39.1707909352960; 
 Wed, 14 Feb 2024 03:15:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBmqSqXj6AOCkWo4acFUHX1+O3Rkj5lOUDH2bVtG17TnOg1qkrOKN/t3AYiKdcX7Nbo/Y2/g==
X-Received: by 2002:a17:906:bc59:b0:a38:916e:a4fe with SMTP id
 s25-20020a170906bc5900b00a38916ea4femr1588424ejv.39.1707909352540; 
 Wed, 14 Feb 2024 03:15:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXStH8YTHn0bmCotcCK7lny7JbxAa/yARMP94HDxG5eHJIciRZJp6IlytLC4L6Pws+GQjGPfUOhwG9v7jauvDhGClJyMLuBNcPiDMCB7QI+vVbvOPt2e+wgCZRI0s3uUA==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 lj8-20020a170907188800b00a3d2e685ff2sm805230ejc.78.2024.02.14.03.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:52 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 49/60] hw/cxl: Update HDM Decoder capability to version 3
Message-ID: <ae243dbfc45eb6d91b34d0ecb73b104a9ee0d058.1707909001.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

Part of standardizing the QEMU code on CXL r3.1.
No fuctional changes as everything added is optional and
it is set as not implemented.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126121636.24611-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_component.h | 16 ++++++++++++++--
 hw/cxl/cxl-component-utils.c   | 10 +++++++++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 5227a8e833..7d3edef1bf 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -109,8 +109,9 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
     (CXL_SEC_REGISTERS_OFFSET + CXL_SEC_REGISTERS_SIZE)
 #define CXL_LINK_REGISTERS_SIZE   0x38
 
-/* 8.2.5.12 - CXL HDM Decoder Capability Structure */
-#define HDM_DECODE_MAX 10 /* 8.2.5.12.1 */
+/* CXL r3.1 Section 8.2.4.20: CXL HDM Decoder Capability Structure */
+#define HDM_DECODE_MAX 10 /* Maximum decoders for Devices */
+#define CXL_HDM_CAPABILITY_VERSION 3
 #define CXL_HDM_REGISTERS_OFFSET \
     (CXL_LINK_REGISTERS_OFFSET + CXL_LINK_REGISTERS_SIZE)
 #define CXL_HDM_REGISTERS_SIZE (0x10 + 0x20 * HDM_DECODE_MAX)
@@ -133,6 +134,11 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
             FIELD(CXL_HDM_DECODER##n##_CTRL, COMMITTED, 10, 1)                 \
             FIELD(CXL_HDM_DECODER##n##_CTRL, ERR, 11, 1)                       \
             FIELD(CXL_HDM_DECODER##n##_CTRL, TYPE, 12, 1)                      \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, BI, 13, 1)                        \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, UIO, 14, 1)                       \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, UIG, 16, 4)                       \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, UIW, 20, 4)                       \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, ISP, 24, 4)                       \
   REG32(CXL_HDM_DECODER##n##_TARGET_LIST_LO,                                   \
         CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                          \
   REG32(CXL_HDM_DECODER##n##_TARGET_LIST_HI,                                   \
@@ -148,6 +154,12 @@ REG32(CXL_HDM_DECODER_CAPABILITY, CXL_HDM_REGISTERS_OFFSET)
     FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 8, 1)
     FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 9, 1)
     FIELD(CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 10, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 11, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, 16_WAY, 12, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, UIO, 13, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, UIO_DECODER_COUNT, 16, 4)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 20, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, SUPPORTED_COHERENCY_MODEL, 21, 2)
 REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, POISON_ON_ERR_EN, 0, 1)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 5ddd47ed8d..a55cf5a036 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -243,6 +243,14 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
                      POISON_ON_ERR_CAP, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
+                     UIO_DECODER_COUNT, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
+                     SUPPORTED_COHERENCY_MODEL, 0); /* Unknown */
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
                      HDM_DECODER_ENABLE, 0);
     write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
@@ -326,7 +334,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
         return;
     }
 
-    init_cap_reg(HDM, 5, 1);
+    init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
     hdm_init_common(reg_state, write_msk, type);
 
     if (caps < 5) {
-- 
MST


