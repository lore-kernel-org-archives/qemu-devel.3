Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9931CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 07:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEN7X-0002xb-Mh; Thu, 30 Oct 2025 03:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1vEN7A-0002k8-LX
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 03:30:34 -0400
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1vEN72-00053C-HT
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 03:30:31 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 488051400186;
 Thu, 30 Oct 2025 03:30:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Thu, 30 Oct 2025 03:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1761809420; x=
 1761895820; bh=SYl82fCDZJcU+VsPevtjzlgUXnb+eBJwdu+nmoiLFJc=; b=b
 oYhgA43vdPkaYGvY2yJgpmMNeNAm4gfzppgA3woiDrXWqq0MP3i6rDX3vnpz+yj1
 7WCnRexQ2W1rYhiAs8JPgjY2Jv+gnO2nRbyNTMYnWOw3ikMnEECNup7fZTObiIC4
 82t0YLYYaov2VUfaXQ8pYpfUPlUo9MSEm4/JbxuvXiOy6sFfd4odwpPDKqcGPMk1
 o+WinToJ4XN0DPexMfB9uUi49INqTp1RAQBXVSePEt58OO7j3vJsun6taAZmAb2n
 00TE8D6Ki0mGmhCCvwBymUHpkOK8E/yhqatg05+OjovlrJqJpO4rJKIhwANkRO0n
 rOyOfQy8DB3CymVO8JEKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1761809420; x=1761895820; bh=S
 Yl82fCDZJcU+VsPevtjzlgUXnb+eBJwdu+nmoiLFJc=; b=T3I4FCDVOPtAgoxhK
 CUrwMIWpIT1NPOZr9PAQ4tmRb9Co00qKQTRVUsMPpXu0gL9RnTNMFa8653eBO3bl
 5Ry82H5ryXyrbe0yd6mQSmSy2nDIcnoV5Iqg/PSGdI/U2u9gfr1G3qO7hXfsnEdr
 yeYuHwy//K56+RlFFRsR/86V1Ck4aFwQ4VDggACL9SOj13K5t1OJFQZeLy5bGo5k
 osYotbJAaU9Df2AJhCkwmrzPtwW5yNfawwMNCk5+uQZCG68QxLluQwDLUH4rb3ML
 kTNkAvEUumcsSE814ySoTtT+bBnkRnFrr/pRU13JH5z+TtEyu6dMK6nXH9oktW4w
 5rV2A==
X-ME-Sender: <xms:DBQDadPijKDi3dBoWc3SY92io_FRkaV8Q1w2zY2hBcyiVpP6Qk8Qkg>
 <xme:DBQDaY5_RginHzEEpuYEvLCdZ9AuuDKISptA6ZmuImdtoxCIDsLaG5jfQgqKobVZ0
 kLsc_vd-XHiNNsOTZ6GL8o0wev6qYSxVsq1EQ1a-T4XKeqqm-xTQHQ>
X-ME-Received: <xmr:DBQDaX0rv-3rV1ENjNlY-u-9dEIZnghpokYhLRTBq01ApBdiClDunkU0p8O6kXMcaLvvQm5E7u_EK4M0Z8DlsuZYtNr34tqkSZ1DYy8L363EdiJkUwGnblJfi1oXUB78fOFT2j8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeitdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudejudeg
 necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprh
 gtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphht
 thhopeifihhlfhhrvggurdhmrghllhgrfigrseifuggtrdgtohhmpdhrtghpthhtoheprg
 hlihhsthgrihhrrdhfrhgrnhgtihhsseifuggtrdgtohhmpdhrtghpthhtohepjhhonhgr
 thhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehkrdhjvg
 hnshgvnhesshgrmhhsuhhnghdrtghomh
X-ME-Proxy: <xmx:DBQDaZwTJXAXQn1mfNAJJ0JTPuy8QjPh70x8HYlPae5kxtkMON3A1g>
 <xmx:DBQDaRvc-rPXmENfbeqUBUSSzfGOajqliHIxw20IweGP7g2KExJP0A>
 <xmx:DBQDaTxpYTpXSA0g1v4txnb4kpu7B-HAolChRrU5figg64LeslWFEA>
 <xmx:DBQDacCFy9H4QUCdc3zpbqVHLg8RQ4HvomNyC8DiAQj5j9ZcLoTQ4g>
 <xmx:DBQDaYzfLRrENo9-HPHgLmjTX3rkTWksv-fVAp8bLfJX_4puKPLuJvI->
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 03:30:19 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 2/7] spdm: add spdm storage transport virtual header
Date: Thu, 30 Oct 2025 08:29:50 +0100
Message-ID: <20251030072956.1194-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030072956.1194-1-its@irrelevant.dk>
References: <20251030072956.1194-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.152; envelope-from=its@irrelevant.dk;
 helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Note that in the StorageSpdmTransportHeader structure, security_protocol
field is defined in the SCSI Primary Commands 5 (SPC-5) specification.
The NVMe specification also refers to the SPC-5 for this definition.
The security_protocol_specific field is defined in DSP0286 and is
referred to as SP Specific for NVMe and ATA.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 include/system/spdm-socket.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 29aa04fd5211..8c07dc12d283 100644
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


