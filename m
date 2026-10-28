Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36BF606A339
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZIyfrqy;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Fkm08Rrz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HG-0002L1-68; Wed, 28 Oct 2026 13:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fl-0007GV-4i
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fj-0003pG-DE
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kXcDPwFzz5tqwuXL8cNsY97HkWgfQJeH6ndvvj/1t4U=;
 b=DZIyfrqy8XRhwmIYyvaogptcXIxayF+I53yDsAv32Bj6vg4ktulQHMys5uPCuh2KLGxKGf
 sJEBgWllUceSa7EqBv1+O4g7IVGG101mnpO/dIuRp6pnwrX279WdDiuFqvIuANV//yw30S
 tdYzWkGalNunN/iFWa6dqTu7yEND74U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-iUi93LWgPq2mtv1J2vRwJQ-1; Wed, 28 Oct 2026 13:15:53 -0400
X-MC-Unique: iUi93LWgPq2mtv1J2vRwJQ-1
X-Mimecast-MFC-AGG-ID: iUi93LWgPq2mtv1J2vRwJQ_1793207752
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1fdde384cso8416655e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207752; x=1793812552; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kXcDPwFzz5tqwuXL8cNsY97HkWgfQJeH6ndvvj/1t4U=;
 b=Fkm08Rrz5OCwrp91ly2YZKFmHf8MisB80L88a5EzWUKPnLYap9M52zbgPmGrBdoAOR
 4aml1T2jZthNl4yJEPmrC3xFrX09u+DoO4tUQx2woo7eatBNhOypICoFI9FCdyuB3jBi
 +jmeuuCktYjV29oyZaavNb5XCPJBT63i5eKCnWdCTWy5CfQbhKKiupUXYqpwUweKP4q0
 T1Flj3CqkpkDEScz4Ni4viixtIzUoJVWs8u9xw7d6HaYNPMV2PR03GT/jUbAlojchXvv
 zCInUOJXltAANHup8dOAnAIYYLQpZ3yOUUAFQ8WhdxBjbbU1HbzB8vgMa7qPv2iPjQrA
 xkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207752; x=1793812552;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kXcDPwFzz5tqwuXL8cNsY97HkWgfQJeH6ndvvj/1t4U=;
 b=YX1+ySYS+q5/G96LT0ieDJ9xxlfN7jbgpeorJpdg+mZrUjRoHf07pg+4YNWqWWvRlK
 iJMHSOZErZRtld7qE5m9e3GfR+OiKFiPIoDvTe0CZWghkU8uQBEC2N0ay6V/b6BMzcnl
 3f3d+jacOHk3YD0+Ow6uqJ4e5Ov0AlJmaX6ic7B5txep8OlyFDJFA/p4UrrjBItM5SCH
 rOI1u8fFEA7vpqowOhOux5rHwdMZrGjCf6fG8GThcLen2HHnhRatt20Djd8xhvn5Ke+/
 bl+lX2MBKvDIAUIQqHxBgAkhj8p/AzXdY+iKjtg1sKHgnenGkPXgvouJypfuPeorEUtv
 wiJQ==
X-Gm-Message-State: AFq9FYKxR9Q2bVkRudtHMTnBP6d1OVxeGkxp2g6UBjH1mDKZBkDJ+e0q
 X7BgRZrKvexwHRZh8bDHDHrIvAGmq/htYl75pc54o5JTLGfpChx3U9NqjX80Qg209TGhWOk8n/C
 3u8hGjUizBTDYdmr6z+oakaIHmkFW6EpJ7BhxBHvGLd0SdnX0zZq/CJ2dIS0A2lQntLh5BjRaOd
 YkeC9np4siP04Oukmitu0SgiXi6OeihnZHZA==
X-Gm-Gg: AYBFou2yoGO4zWZ2bRuB9m+3cu0T8iGhXZPRxJpJKIqL2r9PU4NxKtVQeXqPOW+gNI6
 tKDgff7k7eaKxeSnKuRtCb/wAgEavm7K3MGVVOOjyGhzxMZ1Cx97Y/xIUVrnUiaOV+mtihSUUt2
 XxGNR9YfSRL+G+yrDnp1lviTLl05yScLCJbxTKyQKL+p8ZWDZRP3CVZsvnMOlkv6UnB9IlkXJ4O
 V26DrZ3TghedEyhDEq1dkPyzPdT3bVc5xAJ0jQtTw1cidWcEvAA1gDZUa6Nc2I13ztkvggQ9YT8
 QdFjapGMQlnwJXUMvHIFT7dZyLHviwGvXkmX7dfVewQQp1sIIhFkRofS/Ln6DKjYc8t+QHvK/P7
 n6I/ftftlCP8iHUpUkx+cmPdCapjudiHtw1weqPX1
X-Received: by 2002:a05:600c:37c9:b0:4a5:26b8:4507 with SMTP id
 5b1f17b1804b1-4a9678c281fmr66971095e9.21.1793207751799; 
 Wed, 28 Oct 2026 10:15:51 -0700 (PDT)
X-Received: by 2002:a05:600c:37c9:b0:4a5:26b8:4507 with SMTP id
 5b1f17b1804b1-4a9678c281fmr66970365e9.21.1793207751318; 
 Wed, 28 Oct 2026 10:15:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee57589sm7104555e9.2.2026.10.28.10.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:49 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Vrabel <david.vrabel@nutanix.com>
Subject: [PULL 42/78] hw/pci-bridge: Make speed and width for PCIe ports
 non-experimental
Message-ID: <c827e3d2c5dad9964373361ad1b6a341cf2b841e.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Vrabel <david.vrabel@nutanix.com>

For guests with passthrough PCIe devices, in order to make the guest
PCIe topology have the same apparent bandwidth as the underlying
hardware we need to be able to set the capabilities (speed and width)
of the virtual root, upstream, and downstream ports.

Promote the existing experimental `x-speed` and `x-width` options to
non-experimental `speed` and `width`.

Signed-off-by: David Vrabel <david.vrabel@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260928152431.310363-3-david.vrabel@nutanix.com>
---
 hw/pci-bridge/gen_pcie_downstream_port.c | 4 ++--
 hw/pci-bridge/gen_pcie_root_port.c       | 4 ++--
 hw/pci-bridge/gen_pcie_upstream_port.c   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/pci-bridge/gen_pcie_downstream_port.c b/hw/pci-bridge/gen_pcie_downstream_port.c
index d9c182e881..d00bbd55f0 100644
--- a/hw/pci-bridge/gen_pcie_downstream_port.c
+++ b/hw/pci-bridge/gen_pcie_downstream_port.c
@@ -159,9 +159,9 @@ static const VMStateDescription vmstate_gen_pcie_downstream_port = {
 static const Property gen_pcie_downstream_port_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
-    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
+    DEFINE_PROP_PCIE_LINK_SPEED("speed", PCIESlot,
                                 speed, PCIE_LINK_SPEED_64),
-    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
+    DEFINE_PROP_PCIE_LINK_WIDTH("width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
 };
 
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 5434d693d9..d3ace7f0db 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -129,9 +129,9 @@ static const Property gen_rp_props[] = {
                      res_reserve.mem_pref_32, -1),
     DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort,
                      res_reserve.mem_pref_64, -1),
-    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
+    DEFINE_PROP_PCIE_LINK_SPEED("speed", PCIESlot,
                                 speed, PCIE_LINK_SPEED_16),
-    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
+    DEFINE_PROP_PCIE_LINK_WIDTH("width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
 };
 
diff --git a/hw/pci-bridge/gen_pcie_upstream_port.c b/hw/pci-bridge/gen_pcie_upstream_port.c
index e86eff099f..61ae3a294a 100644
--- a/hw/pci-bridge/gen_pcie_upstream_port.c
+++ b/hw/pci-bridge/gen_pcie_upstream_port.c
@@ -134,9 +134,9 @@ static const VMStateDescription vmstate_gen_pcie_upstream_port = {
 };
 
 static const Property gen_pcie_upstream_port_props[] = {
-    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", GenPCIEUpstreamPort,
+    DEFINE_PROP_PCIE_LINK_SPEED("speed", GenPCIEUpstreamPort,
                                 speed, PCIE_LINK_SPEED_64),
-    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", GenPCIEUpstreamPort,
+    DEFINE_PROP_PCIE_LINK_WIDTH("width", GenPCIEUpstreamPort,
                                 width, PCIE_LINK_WIDTH_32),
 };
 
-- 
MST


