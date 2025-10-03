Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78864CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 11:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4e9P-00030m-0N; Fri, 03 Oct 2025 07:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1v4e9M-0002zy-SC
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:40:36 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1v4e9C-0006cY-MP
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:40:36 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3306eb96da1so1860551a91.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759491619; x=1760096419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uo8ty6AVftk6YwJmhszAIju/0pYWbtW12RhyOAMulM=;
 b=nYzAspODQQHm1P44BTrfP60ro2H7YMEcux3eaZNWUmwoBjduUsOZAg0hAcEqj8nQK+
 Y6nVRJ0AjarXdLUAQVtrtj1XeF8IiEv4K7Y2gGMlHzr8KTphCLmGTRG/r4joHTelonZw
 HoQApsBetysPH1947GHkakp8DQ4jEcL2Y93bTk06O1ok3KhQjj5MHcF2DbZy7m+iCXPc
 uL5ul0D/N0OZaoD2y1L6lKdEXI3EfQS1lb4vTJmD5NtUip+zwqpqprQovmV1nlM7rOn6
 wYtvORwBfaCt/e+TFdE7SB9lGrbBXrgXkWuuULGNgDw2ZNmEpGZJXML0x3b45eU/MlM3
 VQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759491619; x=1760096419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/uo8ty6AVftk6YwJmhszAIju/0pYWbtW12RhyOAMulM=;
 b=mjniLyOv00DOpOp8ovjNQhscolqUuBUYmhmpW6dJPb6Od0j+L3kEcs7aEKJ5P9u6ew
 z+WQeIpED8TfTr9oVcsz41xYChT9hRiOdrHjO5swaAV52dGPCk7kZdcFx35lqdUiBp4R
 yubawCPHEN/j8DKZM9T3FjAiZMoIqyg/2XEXrOUrKSz4i6r/Sxq9QoHtlzNgjqS2agw4
 NqN9xFTvWq0tQtvFP/xaRkujgX/mSDeMwBKazt5HYHgZDHhyRFo5tDyVocTQpGHuvrRA
 HzxvClAF4UFdIREp50c22bfmhh9ffCKn4rx6jKrnjLzxA/cpSxPBZKEVZsZ1I3cTTVjo
 nWhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6eMlN3Bk6FTrS3yYspJ1llRPFod4Jc10tUkwHDwllkov3WyPUKPcA8yL4P4uzyl9R/OWU47oMIVg/@nongnu.org
X-Gm-Message-State: AOJu0Yx7243M3GhO5wr9/oQVH4J72WZxYoGy3ycs/iB7+auR7LiDey0j
 l+cgh6uXCRgYW/mKd4bUs3Ek9Qa9SxT42uuw46W9L8xMvD0i4oXlwXDw
X-Gm-Gg: ASbGncuEDbbuN9f46nfU94eXRgefWjAywQi0iovzKME2Q4QQXhxJMTCazFtdAbK5qn9
 XT7PM6tjMScd7j4JBoP8YI9/W2W7S9OhW+IrV0t37jZB7Kpa/Rtl6Qpy48iy7IC4ZkPqu6l5ATy
 1Hb4RkFiRj7pACmhnLeSpvDrI8oRSh8aplmW/xO81CDZYHqC6laemUy+5rJWs+ZTfm81nP0txdI
 2YR0zOUnZMyiyROgjqTNEeks9S/TxQCHjq0F0UQuUDrpTDhTOzv4j3+g5jxLcbiEddjMxjcyARk
 07OVnRO5w1ngKJ7gpW2cVX9QM76qsd4P7Fg35leGPuS5K3c7kXusd5W0KRgQm/bI3StnzMSUkqz
 3cj4v2WQyNMdJ31zKa7W9CaxELxzAES7sui68bGUk821AUFcdSTQ=
X-Google-Smtp-Source: AGHT+IGzbWXFHzX3Q5rmB5P33LGvoIPVYKzG6d8aOeeT4QhQbGdCTlHTxJZVCgeyb+BBc7GLt2UWRg==
X-Received: by 2002:a17:90b:38cb:b0:32e:dd8c:dd18 with SMTP id
 98e67ed59e1d1-339c27dad6emr3698885a91.17.1759491618893; 
 Fri, 03 Oct 2025 04:40:18 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a6ff26f8sm7804995a91.13.2025.10.03.04.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 04:40:18 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v8 2/5] spdm: add spdm storage transport virtual header
Date: Fri,  3 Oct 2025 21:39:43 +1000
Message-ID: <20251003113945.87962-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003113945.87962-2-wilfred.opensource@gmail.com>
References: <20251003113945.87962-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Note that in the StorageSpdmTransportHeader structure, security_protocol
field is defined in the SCSI Primary Commands 5 (SPC-5) specification.
The NVMe specification also refers to the SPC-5 for this definition.
The security_protocol_specific field is defined in DSP0286 and is
referred to as SP Specific for NVMe and ATA.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 include/system/spdm-socket.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 29aa04fd52..8c07dc12d2 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -88,6 +88,20 @@ bool spdm_socket_send(const int socket, uint32_t socket_cmd,
  */
 void spdm_socket_close(const int socket, uint32_t transport_type);
 
+/*
+ * Defines the transport encoding for SPDM, this information shall be passed
+ * down to the SPDM server, when conforming to the SPDM over Storage standard
+ * as defined by DSP0286.
+ */
+typedef struct {
+    uint8_t security_protocol;              /* Must be 0xE8 for SPDM Commands
+                                               as per SCSI Primary Commands 5 */
+    uint16_t security_protocol_specific;    /* Bit[7:2] SPDM Operation
+                                               Bit[0:1] Connection ID
+                                               per DSP0286 1.0: Section 7.2 */
+    uint32_t length;                        /* Length of the SPDM Message*/
+} QEMU_PACKED StorageSpdmTransportHeader;
+
 #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
 #define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
 #define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
-- 
2.51.0


