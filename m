Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB01C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs3a-0001tV-B3; Mon, 06 Jul 2026 18:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3X-0001pt-TI; Mon, 06 Jul 2026 18:44:51 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3W-0000wZ-A5; Mon, 06 Jul 2026 18:44:51 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CB55D7A01E4;
 Mon,  6 Jul 2026 18:44:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 06 Jul 2026 18:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1783377888; x=
 1783464288; bh=LWbOE8SiKBTE7BDcBZIXw60DedsTrZ4otCCNMbHXrKQ=; b=l
 Tz7TNrnnKcyasUW9E1cITzj1RtSMx8kHL48Bk7HuJ0BZQtpMfcEiDUAQ8JzAyX/J
 DX7QKvy0T8ykFA/LSB5DsJVX2VnTGLKoirgDIkcoKfNv5rfP/HKB9u+m+/bPDSUp
 2jtRwQ5F3hb6QxYIL08b3bRsm0tJtbo/XR+An9PDQO8SXMa7BWe4r1aBtOL/LGfu
 yQwqetj+ZQ+5nuTQ99kp35FT8j6vH/C1HP5DombFhd907Efw3hh4kTOz10tZ2cDZ
 6MpAZHvkDRlE4ijRuPetzdSvz72kidj16TAHcySfDsBOjYR/9YBplwCuhzP7LvqW
 zmphcAVmE7vwPIeR4WteQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1783377888; x=1783464288; bh=L
 WbOE8SiKBTE7BDcBZIXw60DedsTrZ4otCCNMbHXrKQ=; b=aeSdOOEtdHhWdooMs
 TqTE4nv99540P/ImacjmZFf5GBRSLorZXUWogh5cCScDXayczO+2QHnKGodQVtZw
 4WSSBsOEcSdCC5muP4lCSwCQcmBO1EqP17cVAYj92aVchh2ochfGKWfxppBUlEAa
 3aXpjjJ5TYNkz2OWhHnHDIratPytPFby+4Oq0CsUX9xAQYFnmVHflEbfqd2WzVxi
 NtoC5F1CVw3X4TDIeCnXmyf5Iz8ecRNGWFaknMMfDmECxdD+R9WSQigajEFhXAEM
 gKs9azjZ/fbMgf/XhEAs9eZiLF07OqBgzmrTcNQGtdpJJTxLnrANop0eaJ6LH+EL
 VrHqg==
X-ME-Sender: <xms:4C9MavN7MoiBiG8pW7j9RyjdDR0c-zbJmZb9_9eZID2q9AfLjhACTg>
 <xme:4C9MaqbOgGhmVEoXaWBHIsUk90sLVdE3MFlKairgSqo2LGNpgesY-Yjl60yutsoWc
 Zor4gFvYM8gUPt00BYBj6euF_FTWJicHDywxWXsw_ZBML1WceYuU3Q>
X-ME-Received: <xmr:4C9Mau8ckHb_O279k99QRfdI2I5ub_fVUCTcNAD9IUCWxEIf07qRtZL1Z3N5VLgH0uxiQjwrwLmsXN7HSTyje744jep5mK2kN711Psz6cniGbbF_x64j2uY8yg>
X-ME-Proxy-Cause: dmFkZTGFBpywmipUNxqz7T25qNH2oFLWY3g2g2IYbd+a9NZ5PpDTzOXx5JVDMxv2l0k/rP
 Op8DOnueC7GUN1f+KdSrev4NwwyMoYqNOwq40rgiBIuAngiPnVcWGmD4iyZmLQQexgV30/
 AqGZVGLAhMshNTq3tK5SWUxKXqUvvJz6ST9lexsuPYigR1n/8VpuvdjBzoGXsJTB2VXzWk
 OMUszQP3oXhgh2d3zJFmqzGaKLeum1kObyrB8pjHEvd6sPFHvINGSxiUijAx/xjYnxdftn
 6ngxU68dld0btl9LKTMjBW9EkFIflcc2TLWmzEn0lttUhZM8u5JLx6ngc+Q/iURs3LZ+nL
 SQRYNA8yYb2QNvhbZiF2LcFjRH74/UEmHoSf3j2xMaSN0IO7wiVj0OTdIhcId3xOwDSlfn
 iyUfMZ2qZxz8UX0eSbH82eMURTH8OhKo7aizWP7NY3u1OJWxepfKASy+VZVm9wtOzdZQmE
 DQEtx6KrlLW6dphF27aBDtJ8zrrAFhlhYYl+Xye3Y71YxlTaccSQMLR9NedEUdCo29qyPJ
 mTLHuUVGtL2YBbu5HmjcFp1qUsYsJ7dB6rcNUCoRQ1OwrLojL1RYuaf3JQX3SgB0JZSyzr
 UYGy+K+6TfVMgEipcgsXE78AU3UqBxDwOgfl/xLLS9vl4OethBKtJlSZh+jA
X-ME-Proxy: <xmx:4C9MarTyelunGBiYobtKq4wwvM7kB-q6hlS5rtAjuyS0T9wkxbMaWw>
 <xmx:4C9MaodH_bL9HBtajsWoxT57_q4LM3vB6f9hbzI7S0Z9kjrqxb_D4g>
 <xmx:4C9MatS_A_c4-_YbkeVqAVF1G3Ms5MZ-NBv1j2ByD2OIbfbDKoWPIQ>
 <xmx:4C9MakL9fpYMmcURH2rZoD4MHplsRCKAI4YtRBy9eT95yeV3kXycvg>
 <xmx:4C9MakrLFy70b-esl33KvB1nOPo2IM-ripIgWs26IU7U8FOD4C5gz2w_>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:44:47 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Keith Busch <kbusch@kernel.org>,
 qemu-stable@nongnu.org, Feifan Qian <bea1e@proton.me>,
 boy juju <agx1657748706@gmail.com>, Klaus Jensen <k.jensen@samsung.com>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 02/11] hw/nvme: ensure sgl forward progress
Date: Tue,  7 Jul 2026 00:44:14 +0200
Message-ID: <20260706224426.14156-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706224426.14156-1-its@irrelevant.dk>
References: <20260706224426.14156-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Keith Busch <kbusch@kernel.org>

A degenerate host can create segment loops of zero-byte data descriptors
that the controller never breaks out of. While the spec allows zero
length segments, it provides no guidance on handling loops. It
makes no sense for a host to submit such a descriptor anyway since it
can and trivially should point to the next transfer segment, so don't
even try to work with such behavior. Just reject the command,
terminating the loop.

Cc: qemu-stable@nongnu.org
Reported-by: Feifan Qian <bea1e@proton.me>
Reported-by: boy juju <agx1657748706@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index d60a680dbc15..7845e59e4b08 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1090,6 +1090,8 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, NvmeSg *sg, NvmeSglDescriptor sgl,
     }
 
     for (;;) {
+        size_t prev_len = len;
+
         switch (NVME_SGL_TYPE(sgld->type)) {
         case NVME_SGL_DESCR_TYPE_SEGMENT:
         case NVME_SGL_DESCR_TYPE_LAST_SEGMENT:
@@ -1170,6 +1172,17 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, NvmeSg *sg, NvmeSglDescriptor sgl,
         if (status) {
             goto unmap;
         }
+
+        /*
+         * Reject if this segment made no forward progress. The host should
+         * have skipped linking an empty segment. While not strictly spec
+         * compliant, allowing this makes it easy for a pathological host to
+         * create an infinite loop.
+         */
+        if (len == prev_len) {
+            status = NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
+            goto unmap;
+        }
     }
 
 out:
-- 
2.53.0


