Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8C3CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 04:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvq3h-0006HC-E2; Tue, 09 Sep 2025 00:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uvq3d-0006GR-UJ; Tue, 09 Sep 2025 00:34:17 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uvq3X-0003Ee-3N; Tue, 09 Sep 2025 00:34:17 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7741991159bso4543417b3a.0; 
 Mon, 08 Sep 2025 21:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757392448; x=1757997248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RCukcbGa6ijcHuk+daD95SFwDIqdnmVomZ8mMo0axk=;
 b=BPACv1ddA5y6ZJpyq8na2sp0wEq1RQs8WkB5T0bQQkjHDTizaKkF9F4BfYACdWplJ1
 1xbrlQl/Bh3EiOvLi/MoTR7jPC0W9INVGCnGayMOCgGswOudd/WFeasGkGl9RQg8odMf
 on2eAAAiZ1BzeFQE2FzsYrBbB57HALOTTJ+00+DXso6t70gT7r4sCKXGcaOpNJVTdAZV
 Tl3MEMEe1tBKCIayP/OERKi2fbR7NO59ycoFbqDQ7LIb16G6ZoXRizXOKilBnUT4A8wv
 HU6M+ben95BJuz9Rf/i6rb4qK4ODSEPBZM8AmdPsjgXKYRu0WY3vHswWhadEoTyliiK8
 P3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757392448; x=1757997248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RCukcbGa6ijcHuk+daD95SFwDIqdnmVomZ8mMo0axk=;
 b=uCzowRiP8sH2pX2CuEaojnPKm9eOQT9IFN+OWDFFeTFoutO8t8E4I6gtOA0tZsGLi/
 S6xJaIPF1GeRuONqRntevVbe4eDyy8TfqjZbiNdVHbiYdi+eFoQdOqQgN5m7GwQnTT7W
 EbqNChjYdkWRg1BCXf8uZ5pE0U8csZHGJVed6b62FDqIm+39RBV252igopl1+2Mw0lgN
 5L19jxizxQ5QL7Gg+54O4mXN2uEGE+W8o8Tttprc7nyHI/gemOGZJjiKFMc35HLcV3sb
 EQAqAzT7r6r3SLQwrt28nOIivowbNhriv41xutTdcMJD8IHVwAk5itD7F62/n88W8SgX
 aEoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRZEbCilcIECLF01R5XbENYvFMzjVPE/waKCBMhDfm2Vzw5zSE/4Y/t28MIgv40hdHZ+3P0DRElZ62@nongnu.org
X-Gm-Message-State: AOJu0Yxpb04KRAVTt/tNginprfqwQDsv2On3Oufe9dTQVEt2Cdajr4jL
 rZPNCg6Sg6yDuDDBYUTIHgRejoYpAfcuWWVaq/6U8r6gGTGMQC/w+mha
X-Gm-Gg: ASbGncuKQP9aHj8QQe5UwudohhXKm4AcYv15LojNdH7P1yerdxi9RRJQagd3NtaMfc+
 rwFHfmgAEAXowvshGD4ahUWkCoAii4FLDJ/aztThnBzCWav8GrE2uJqZVqo+CwQoyMritxQKr3O
 Jz84TEq4iBkd5SAjRHKkupuQ9YWLB06mGyp5oDIbaCONsBrN81ec35SoGDFvQjCKI21s8+BTTJO
 WfavIzGVl1bmIfyYQbaU6PO6iDiZPNN8qlC80FfuL2XIeaFCQcFIzL9CLlP7ZulFUxTZyGVHuJC
 umVDdvdSBWUs+jmnUQ1+n4gctZQ4DkPbZj5O2C1X2mzAXRfXsLydX1W2t6/F+b3Z7B7NmwY/Hmx
 ZfgITstiWJrN42gzQ4/uZY8qkPETg1163VxKR+YPh9g==
X-Google-Smtp-Source: AGHT+IE/mFdJf6KWeDFqKhSRKNLktZ5BvviL5gE6yDHp7B9PO945Fqqa7D3jJ90I/o01YsoH1u93kA==
X-Received: by 2002:a05:6a20:4321:b0:24f:4c12:5fa5 with SMTP id
 adf61e73a8af0-25345578e96mr15885205637.42.1757392448255; 
 Mon, 08 Sep 2025 21:34:08 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-774661247cdsm606534b3a.33.2025.09.08.21.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 21:34:07 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v5 2/5] spdm: add spdm storage transport virtual header
Date: Tue,  9 Sep 2025 14:32:57 +1000
Message-ID: <20250909043259.93140-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909043259.93140-2-wilfred.opensource@gmail.com>
References: <20250909043259.93140-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

This header contains the transport encoding for an SPDM message that
uses the SPDM over Storage transport as defined by the DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 include/system/spdm-socket.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 29aa04fd52..c5f9f3611c 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -88,6 +88,18 @@ bool spdm_socket_send(const int socket, uint32_t socket_cmd,
  */
 void spdm_socket_close(const int socket, uint32_t transport_type);
 
+/**
+ * Defines the transport encoding for SPDM, this information shall be passed
+ * down to the SPDM server, when conforming to the SPDM over Storage standard
+ * as defined by DSP0286.
+ */
+typedef struct {
+    uint8_t security_protocol;              /* Must be 0xE8 for SPDM Commands */
+    uint16_t security_protocol_specific;    /* Bit[7:2] SPDM Operation
+                                               Bit[0:1] Connection ID */
+    uint32_t length;                        /* Length of the SPDM Message*/
+} QEMU_PACKED StorageSpdmTransportHeader;
+
 #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
 #define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
 #define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
-- 
2.51.0


