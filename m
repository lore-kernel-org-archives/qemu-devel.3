Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA39DC55838
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrDz3-0001DT-Mb; Tue, 04 Aug 2026 08:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1wrDz1-0001DD-Uq
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 08:10:59 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1wrDz0-0007lO-20
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 08:10:59 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 87932140016D;
 Tue,  4 Aug 2026 08:10:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 04 Aug 2026 08:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1785845455; x=1785931855; bh=kqMV2U+aXPZkkL6kbcU+B
 R4hJEc8wFObTvBfjtxpw04=; b=JZxkVsOK4zY2jmR7OY/9e7ram0PIiqgSosdVR
 l+3dc/T2er63qH3vaQmo2CAwGcOwRTitx8vfQkdy1pqdFzt4meMx/x6TfeDsaoSl
 gKLfYsloowyBZfUM3GIqtQVVdAfeSnOkdvnUo46tn6jfCVgsikd64Tj/URVxsHYk
 huCWh2FgfUZaFKeDT+B/d+qihAMzU8a7+2Hl7gB0kVKtIrFYAo1w8CYnkW2k4CUf
 0G2oVmYe1n3ThQv+/0cIJwKqlEzRi7nD19wRkBXZ3ldsZGuoE/OeL6MRib6ms7wY
 3nZhkKvFY+K5svHCFVH41BrtRi2MyYC7SFEI4VzMVKEBs6tKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1785845455; x=1785931855; bh=kqMV2U+aXPZkkL6kbcU+BR4hJEc8wFObTvB
 fjtxpw04=; b=UbBF/pQbh/HMtyFWOEijj5Njs6AKT6CmC8N1/50iMQou8g5bvBy
 Rx0bobpV26//VttOlpn/LAZs/usu+34YOJWgzcIbtwdMuyWC06L+uNjPSTxFIr0C
 H/ZGHgK+ab81pwIJTP35tdTCxDdxJe1iso8t5HR8vAgwDdiwoukV+UciRkykd1mu
 CieoZDVCZ1LBqMsOWdCTvhQbadRNn9vjmIznNYSekwiNcPTmiTV0jzEIHLKY2opQ
 ZgmjhnInCRwl3i5UgP78YAwU+N0p3AM55lkCRDlCgI/h7auq1zvzPEXckVt9bnaT
 r2SxC0A4hgaweNJqV92BghHeG3N1DkUOAjA==
X-ME-Sender: <xms:z9ZxahG-o8H5WGiH0-GTdaVw56A7xG41CcPxeQEfkj1bPRcDbgMp_A>
 <xme:z9ZxavSMI4lbHq6kG8wjzfncjtYCXW6WpezRzatXN4Op4cgO1YpI1XjZtRFwpkmQy
 lQbHDIxGF8dt-CrgXUmNVJkUhquctfxsUftdkRu2qlBr9FERaWSKaM>
X-ME-Received: <xmr:z9ZxauuD7zME1cgPvo-UXwIJczgjXAm1AhGYPLsRdehax1av6Yn4Mzdz-sDCZg>
X-ME-Proxy-Cause: dmFkZTFjTep2vUbEYw3MsmquzINpU6LGnQmzuZVQcpvpMVzI59C9kWoz6MZ7uUVdbjEMJi
 ZDQki24u2c1P+0erI6ofhT5W7WCewgVERwwRNdop+8e0lpfmMctH/DQDvZ4HFYqd9t4XSi
 KQxYei9CJ3wJ2EJSN9gWRlumtrCNNZHsAIrMhVYgo9dlTWIXhxn0ngwKcnOl3OEtgpG5AM
 GJ0jQQtFLG7ztFu0mWSHz3itNRFKp4y1OED20jXG62orfrIKRMJgGk9jzhG9AG3ma6XoKm
 SXdxKNrVGDQSn1qQeN3U76PxHpPlkJd0zFVcHN+b0Dl3yelnWU6UsdYR7ZjOKjkY+if1bm
 rWVRONPpSLTYj8U+qmcaKGx+hg2E2YSs7MsD/kBiEors3iFN7H6NkUzGqYQExKf+scvj7q
 cINioxGL0/4RsaXWRRy8NRtu9kT5eRpi8yy/BSnfgxrdSsrkMtTQ8bKxpn+8Bmqi0k/pT9
 MYO+S2ZxDpl35nUiTHtGjW2X8YHNdv5wHj10ZzwdqQmo/tTZyfhZx1fNe+/YRpJUg5H3VY
 EtBEv4EdhvuIPuHqgzdg++pRQVHEfaR+xc6vUSgZQcwTkP5TJbOtlQmBcd0dups3bYVJK/
 vJ+dzBGxBPiWi0yWqJJu4iRHJyIr7MyGvsXW02/efUjzSCyHFruwzQY2o4CQ
X-ME-Proxy: <xmx:z9ZxanKOlasSfUhBo6usXiptUJbaqD3zUqNEvINhQaaW9368HH6cBQ>
 <xmx:z9Zxajltg-KULpeVCD4ZWc3L_1GnHCKAy0QHekH-movRHg-BAJub5g>
 <xmx:z9ZxagInkIjsucfztm4MneBBdj3uSoZSKEPpBROTZaxftkH7VxTGyA>
 <xmx:z9Zxag43usACTsPwhw7Uk0EFVsBw3gZqSVNcUhgm1ZSnYLPAMTZUtg>
 <xmx:z9ZxarT4-9P3J8RpkCRp63EvcpSiIRY7D8dazTSrDuuGAh2ID_jJdbMe>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 08:10:54 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 708FC8B44F3A; Tue, 04 Aug 2026 14:10:53 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] vhost-user.rst: fix typo
Date: Tue,  4 Aug 2026 14:10:02 +0200
Message-ID: <20260804121000.444745-3-hi@alyssa.is>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=hi@alyssa.is;
 helo=fhigh-a7-smtp.messagingengine.com
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

The protocol feature is named SHMEM.  SHMEM_MAP is one of the
requests.

Fixes: 588acb45c2 ("vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
(Resending after accidentally not sending to the list the first time.)

 docs/interop/vhost-user.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index c83ae2accb..77fcc587af 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1123,7 +1123,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_DEVICE_STATE            19
   #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT 20
   #define VHOST_USER_PROTOCOL_F_GPA_ADDRESSES           21
-  #define VHOST_USER_PROTOCOL_F_SHMEM_MAP               22
+  #define VHOST_USER_PROTOCOL_F_SHMEM                   22
 
 Front-end message types
 -----------------------

base-commit: 4ee536fac748b70e6f3d8568ddd20cfbaa9cf7bf
-- 
2.55.0


