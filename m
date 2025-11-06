Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674C0CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 19:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH5Xw-0007kt-Rj; Thu, 06 Nov 2025 14:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1vH5Xu-0007kh-Dx
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:21:22 -0500
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1vH5Xs-0004jM-Jk
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:21:22 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id AB5CF7A0070;
 Thu,  6 Nov 2025 14:21:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 06 Nov 2025 14:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1762456877; x=1762543277; bh=UbXNd4Ht3LrkAFOizDjyR
 Ssbi+eC2VASAyLRUbb+nPg=; b=X4EQZWhpJjeTJc8OJmp93LPRi8KpGr6Qe+v0J
 BlgTLMrlFswW0CYDMYHBk1MeAYRnFTpGQ8LlUO5g3Fr8YptC9CAgcHSoYr0MKd3X
 vbRECjivXn6W/Rr1i1NyNFxAWZT6mrd8lUR2tbu1/AUB9vaMdH4O0qntT99zttuq
 hJElhT8skKVbkuB0KWw5aQhUnrhNQGEhr0mZoB1qkLuH/5MZr/Pxzw3z+YbWZUuK
 arf/krex3QRUSmXtcG/Nsq7PoNDmL45h09hGJf3WCt8x0pn9lOyzXSbhGempLc6A
 ESpER0ToM254B/9ovdNf+jfaxFOTtMp/NDSZN6VySvSpnDXAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1762456877; x=1762543277; bh=UbXNd4Ht3LrkAFOizDjyRSsbi+eC2VASAyL
 RUbb+nPg=; b=aX9hkIB2vaDAXENbgeOqkLMxNaO8pd3ps/hYa0xTtFAEn/dMrqE
 5m0xmN3V/3FAvjI/6m9S9N0c/OoGFKstcRCgtfi+46EyxO+2adPfk3QBqKCdPGFp
 FgyROeGK9hAbCTx61wzBENmlGEZWeMOc7Y6/XAvh5hHckdBxl0mwiPG9Kd/6TWmG
 Ku2eyqJW3kR/u0uyAL5ZRgqwx63ol6KIld5uJSsX3Vzuu0W4McIRxBHEoEfPcWk7
 ybJK/e5t89I78q7uuid1+DJmToORrCmVL8JWRP48Hj0kJPqRgqz433KXE8/y5qml
 KiXty9rur5FJkbuxtubsNbuUPQnbKftLnjg==
X-ME-Sender: <xms:LPUMafbWuX4QDZ5prgXJp-JcGVPkRhmG15fNOP4mD5hePP7S0gvn_g>
 <xme:LPUMaegLm3W98GZtfXzFvj7gxNCiCCPP0saoNkcbnwZAeP4NplcIS484uKnKUDxLt
 RmRV4Uo6qUC1wUGw2bOrAgX2IWqzb0ZEhkrYY5B_CbVIHIgmrfl>
X-ME-Received: <xmr:LPUMaZ6LafdjwqiembF8ggAWF2iHB2tXWDT9gVKdb1HBaZaLnM6FLOa0wFTu0NPI-Fsiy6XmAJVdDFbz_zyTiwVx2M-sfobfR24wdx9b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejieduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlhihsshgrucft
 ohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepheekgfdtve
 ettdekuddugeeugfdujeehuefgleegtedthfffudfhheduhfduuefhnecuvehluhhsthgv
 rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrih
 hspdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeih
 uhhrvghkrgestgihsggvrhgthhgrohhsrdguvghvpdhrtghpthhtohepqhgvmhhuqdguvg
 hvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehmshhtsehrvgguhhgrthdrtgho
 mhdprhgtphhtthhopehsghgrrhiirghrvgesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:LfUMad4mN0hgYxsTjP8X7v1hLpjASBaZzBSiZSJCp-NvkSzYG56ksg>
 <xmx:LfUMaVcO-RI5EcyHwExJPMqECeg85OkzLhoS2gw7xGTXD6T6W0xDLA>
 <xmx:LfUMaRBTQVoPVjxIHQE5YUDMR7g4-2R-Bq1MhwJ5Om5pW7RsfqnrYw>
 <xmx:LfUMaY_zcT4VaIGk3kigJjUO8YIxPkiUqQ3q4cdwm2Sqz2kIxGBwyQ>
 <xmx:LfUMae12G8sar1U1Wx-HzXgfoRh_Lx3hnfbfJ7UJMllRq3DsrRliGUjX>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 14:21:16 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 268BA68079E9; Thu, 06 Nov 2025 20:21:15 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: qemu-devel@nongnu.org
Cc: Yureka Lilian <yureka@cyberchaos.dev>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost-user.rst: clarify when FDs can be sent
Date: Thu,  6 Nov 2025 20:21:05 +0100
Message-ID: <20251106192105.3456755-1-hi@alyssa.is>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.155; envelope-from=hi@alyssa.is;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Previously the spec did not say where in a message the FDs should be
sent.  As I understand it, FDs transferred in ancilliary data will
always be received along with the first byte of the data they were
sent with, so we should define which byte that is.  Going by both
libvhost-user in QEMU and the rust-vmm crate, that byte is the first
byte of the message header.  This is important to specify because it
would make back-end implementation significantly more complicated if
receiving file descriptors in the middle of a message had to be
handled.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 docs/interop/vhost-user.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 2e50f2ddfa..93a9c8df2b 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -411,6 +411,13 @@ in the ancillary data:
 * ``VHOST_USER_SET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
 * ``VHOST_USER_SET_DEVICE_STATE_FD``
 
+When sending file descriptors in ancilliary data, *front-end* should
+associate the ancilliary data with a ``sendmsg`` operation (or
+equivalent) that sends bytes starting with the first byte of the
+message header.  *back-end* can therefore expect that file descriptors
+will only be received in the first ``recvmsg`` operation for a message
+header.
+
 If *front-end* is unable to send the full message or receives a wrong
 reply it will close the connection. An optional reconnection mechanism
 can be implemented.

base-commit: 917ac07f9aef579b9538a81d45f45850aba42906
-- 
2.51.0


