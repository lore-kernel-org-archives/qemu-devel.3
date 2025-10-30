Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95193CCF9FA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 07:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEN7n-0003F8-EX; Thu, 30 Oct 2025 03:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1vEN7H-0002rY-3z
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 03:30:49 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1vEN77-00053a-0F
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 03:30:37 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id C813FEC01C0;
 Thu, 30 Oct 2025 03:30:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 30 Oct 2025 03:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1761809425; x=
 1761895825; bh=lahpd9GNodsj9jGZJq8wJPs5uzoaarEYXqYshrZLfxM=; b=r
 jK+DEBL8VsejJRqBKdartUnsidiHG6ylYCB8k35NSWHGtGsaHxL5HCnG2OdUAkl8
 9CiL/8ZZ+wJhnyrCVbc7y5Pb1tysmaS2ZJY3zPifEJjEqcYBWmxBB4MIO3Aret/F
 6MUixjLIXcp2uNVY2RO7XglfLszU3SQ/qBa18TCHQzru4hf2Tw9Bgib3RA7s2Zcp
 L2CHlk3ydljFlm8bqNzpFnfWqrWuRQ9tJloZX6m7rR+5jmrUaRQ+E94qOXUB7Q+o
 OReZwoP3k5dAXFEq6Y/qLj55tSm0ayULbxHGlGrjubycDXTOw9+pH6MTAeRPp9an
 xlXOOclAZ1ovl3xQZUBwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1761809425; x=1761895825; bh=l
 ahpd9GNodsj9jGZJq8wJPs5uzoaarEYXqYshrZLfxM=; b=Am8cHhFHYgH2spure
 /a2wVIpWVfp9faTtNeZptbjRqDb1SFLraWpSUvsQvmKwMAOYN6v256GIj7gYdzNz
 oZyZMicZPj4WOUtNFYIgGQaiHaTwiVdXzyKkTgpiLRoBppoetnt934JhqeJtrBc5
 dpWazPbr9+LylD7BS8bhXFwNQySeMwN0kUAIsqTC+DA/OITqaGeuCL3nh8sz5OeD
 obZxm5KSEOE9x7WCs6T0RLQUk/+s0dCLEx/f4+omilsSZH9xifoUK+Tbk3qufZ3A
 HMtKdKWyslVMTKzyNrwsBgjhriAUaWNvPTA6I5bTvzwfgYmwPyvCdxXiju//uCZ7
 wrvWw==
X-ME-Sender: <xms:ERQDaSIRkbqNxEbu54m_w7h0kEqGzoM2HOUXXTgy2xvIu-j4v2R7Vg>
 <xme:ERQDaTExfRBveGsMo6xTIIL_toaAB6tMFwn7s2CZ8LzcPjXgO7ylAnr87hsl6OqFM
 KigYe-Ftmp7FAzravhD3tINHFRxWAVonLOQ-knrJmABJl7Uc2pnJ4iy>
X-ME-Received: <xmr:ERQDaeQ_5az5B5T2BwfOneOGGQLzTVQ15k4ofTEiSjbFyoypvJh8lwVdbmuyVSIl30NLB67mximhHCtntxYt5zIoksjlby9MIvF1Pb4dxdLWNVH7GcM_ESlxDnIJ9_-Q0jCa2fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeitdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudejudeg
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprh
 gtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphht
 thhopeifihhlfhhrvggurdhmrghllhgrfigrseifuggtrdgtohhmpdhrtghpthhtohepjh
 honhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopegr
 lhhishhtrghirhdrfhhrrghntghishesfigutgdrtghomhdprhgtphhtthhopehkrdhjvg
 hnshgvnhesshgrmhhsuhhnghdrtghomh
X-ME-Proxy: <xmx:ERQDaXdNpCoZ_pJmKs6qpsmYW4fkI3tEPVpUCdIcMuuATeAAqa0a_g>
 <xmx:ERQDaVpABarmVa7WC4N9UTGKk8q6BTeauPsG8j66RinndouNT6hNMA>
 <xmx:ERQDaQ-y8l5F3WWVub9yQWcOnYT2BL-Fw_Bsw9Yr6SuRGFFAlDTzNQ>
 <xmx:ERQDaZcZmQdKQ1OL-qRB7HMaZEucDKrl5IS-rxzfoN9NIjiDDSFUdg>
 <xmx:ERQDaetEiRbNKpvs8fyUsJspTMn8HLOQ49oqyKIRS3-VHgom4w5kI7Zp>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 03:30:24 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 4/7] spdm: define SPDM transport enum types
Date: Thu, 30 Oct 2025 08:29:52 +0100
Message-ID: <20251030072956.1194-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030072956.1194-1-its@irrelevant.dk>
References: <20251030072956.1194-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
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

SPDM maybe used over different transports. This patch specifies the
trasnport types as an enum with a qdev property definition such that
a user input transport type (string) can be mapped directly into the
respective SPDM transportenum for internal use.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 backends/spdm-socket.c       | 23 +++++++++++++++++++++++
 include/system/spdm-socket.h | 19 +++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index ab74a02d9cf6..6d8f02d3b928 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -13,6 +13,9 @@
 #include "qemu/osdep.h"
 #include "system/spdm-socket.h"
 #include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-prop-internal.h"
 
 static bool read_bytes(const int socket, uint8_t *buffer,
                        size_t number_of_bytes)
@@ -246,3 +249,23 @@ void spdm_socket_close(const int socket, uint32_t transport_type)
     send_platform_data(socket, transport_type,
                        SPDM_SOCKET_COMMAND_SHUTDOWN, NULL, 0);
 }
+
+const QEnumLookup SpdmTransport_lookup = {
+    .array = (const char *const[]) {
+        [SPDM_SOCKET_TRANSPORT_TYPE_UNSPEC] = "unspecified",
+        [SPDM_SOCKET_TRANSPORT_TYPE_MCTP] = "mctp",
+        [SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE] = "doe",
+        [SPDM_SOCKET_TRANSPORT_TYPE_SCSI] = "scsi",
+        [SPDM_SOCKET_TRANSPORT_TYPE_NVME] = "nvme",
+    },
+    .size = SPDM_SOCKET_TRANSPORT_TYPE_MAX
+};
+
+const PropertyInfo qdev_prop_spdm_trans = {
+    .type = "SpdmTransportType",
+    .description = "Spdm Transport, doe/nvme/mctp/scsi/unspecified",
+    .enum_table = &SpdmTransport_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index e61163381251..00cb0e97f36e 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -112,11 +112,22 @@ typedef struct {
 #define SPDM_SOCKET_COMMAND_UNKOWN                0xFFFF
 #define SPDM_SOCKET_COMMAND_TEST                  0xDEAD
 
-#define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
-#define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
-#define SPDM_SOCKET_TRANSPORT_TYPE_NVME           0x04
-
 #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
 #define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02
 
+typedef enum SpdmTransportType {
+    SPDM_SOCKET_TRANSPORT_TYPE_UNSPEC = 0,
+    SPDM_SOCKET_TRANSPORT_TYPE_MCTP,
+    SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE,
+    SPDM_SOCKET_TRANSPORT_TYPE_SCSI,
+    SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+    SPDM_SOCKET_TRANSPORT_TYPE_MAX
+} SpdmTransportType;
+
+extern const PropertyInfo qdev_prop_spdm_trans;
+
+#define DEFINE_PROP_SPDM_TRANS(_name, _state, _field, _default) \
+    DEFINE_PROP_UNSIGNED(_name, _state, _field, _default, \
+                         qdev_prop_spdm_trans, SpdmTransportType)
+
 #endif
-- 
2.51.0


