Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC5606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AS4Bwgmz;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MyGRtq6u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HJ-0002fR-7U; Wed, 28 Oct 2026 13:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GB-0000il-Gm
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7G9-0003sp-UP
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q+bRAQtX4XauEOMurYgBrtffJ14p2XN3tBRrNFvqLGg=;
 b=AS4BwgmztyRJanzuEwH+fMpzSp21ntu2aoxBILQfvZPNHaBGm7GPX3hgY4Au2YjR2/1Us1
 Em4r2LgxAnmygmAW/B53eqH0B1m8Jub8Ph35CEcW8A7v3Ps/2kIV9fcvuerW/uxyEnSl7s
 j7AR0YuSi5fPO8teISjyB3VDUgEeEfE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-UO-qeiP7PUGyShP_241Pjg-1; Wed, 28 Oct 2026 13:16:19 -0400
X-MC-Unique: UO-qeiP7PUGyShP_241Pjg-1
X-Mimecast-MFC-AGG-ID: UO-qeiP7PUGyShP_241Pjg_1793207778
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e1ad3cb66so763123f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207778; x=1793812578; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q+bRAQtX4XauEOMurYgBrtffJ14p2XN3tBRrNFvqLGg=;
 b=MyGRtq6uUokpguPQ698FzCwdzWfeiVNrFEIqji2ZD7aS7Ue2CJMK2r3QmcudJLHign
 1myPuiLKBNVxHtNnAbiVlXR24wb4uFkx/wZ6037PhvuOEPkolyBaozQCcn5b539qU8tC
 t8WwOeT6SbD0WxtwKFnOaemtjw40dotJsAX4KpQ9SvkiCwFBee2mhSkHMUJtlETRWeHf
 Kx3pIZMwKMQOu5oJylPBnC2R8/3DCDMlB4z9LBak+Pl/pW5N+oTE4t6UmEuYyJ7PdcEs
 ulwa9WmuitTrs+2c3IeAg9hsDQUFVAQmh/cEMpIgxxWwC2z4Zd5yDQO/BxjhZpieThLH
 e5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207778; x=1793812578;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q+bRAQtX4XauEOMurYgBrtffJ14p2XN3tBRrNFvqLGg=;
 b=hGEZIrI82y89Uge5wRlysZC0/NbNZoVZ9CZhBNVBJDYXs8RkPeh/hqNv3sP9rRABMg
 U5DSKPcFZqtY1sBdDiE49y0z/4I7kNWFAz6qNs0z+g1R7fxWnqRBuyMTk0dwgSfcYbOK
 kDZKFk82Cq/Z5POziaZ0s2RK6ARBsinlrDB3KojW81BJgL14Joh5lOFvLTzSrr4wLILK
 9+vjileeFlDpRbmWoNjBezq04iKigrbvyc8otCKqDnops++15OpgFIsFBzyxILCJY6x+
 HWfA9pgoyLDJnp8c1zgthZMDMu0ZC9TAz2Olb7bGoeF2Re0ZUbpA27HbE0n/XpSctM5j
 dDDA==
X-Gm-Message-State: AFq9FYJyi9WJZBDGBC7RVKoNQCAF7u9V3k1DPteyDhJlv5unJ4nU98iY
 ps7ZXajzAxbAgx4cNitNPzwhadh0ghJRd4FncpMCxH/+W4OAm5f4RDiRJXKC1cKkXXWVpO6FAI5
 gVd4jTGu93lbuuKJnJs6V0FOg1na/A3veNZYL3ZrZJG6Y+Lry1jm2g7dPrK6kjwMkzkp3NKJQyL
 sAzyX6bOjQG3t7XVNIUsDecw58Ub5FpMTFng==
X-Gm-Gg: AYBFou3E1W8IHqEirdfH71iO6sHMK/HRzGmNve2+Ak60zVUtfjof5JAZLFKAEUHxQaA
 UWYkpdz//6nancO+bDXtDX/HqW1uXtCLjHY2AAXGJ5IEZDKrF2zaYBgOmJ8XUe+cY3Cr9mqJORm
 ENyA15Ey/vFTtisDNvKX/rSQa0WM7i5Pj3QKmggKnYkpMQQHwp2wTjiBtHjxgTjZsxrRUnSq7qh
 r7Ps0YM4Zwb2sfyV6GTEuQl/CerqVneFuWFpj7LWdJfWLpxxB4tcKDeRsOQ0UBNB3SxiRnv4Wfj
 XV77fWprpDDnzjBwnpCkmZDZxZa+um8r2ZfHxbOQ/MAG/NvYc5Lx18ggPqhNP+XJRU3ZYaPhNsG
 waawmy3ctA/FNRJJsB6h+id10OInBZMmfS1cZeTQ9
X-Received: by 2002:a05:600c:4f89:b0:4a1:ac66:6059 with SMTP id
 5b1f17b1804b1-4a967e8d598mr60601555e9.26.1793207778215; 
 Wed, 28 Oct 2026 10:16:18 -0700 (PDT)
X-Received: by 2002:a05:600c:4f89:b0:4a1:ac66:6059 with SMTP id
 5b1f17b1804b1-4a967e8d598mr60600875e9.26.1793207777764; 
 Wed, 28 Oct 2026 10:16:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa82516a45sm5951375e9.15.2026.10.28.10.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:17 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li RongQing <lirongqing@baidu.com>
Subject: [PULL 53/78] pcie_aer: fix pci_set_long overflow into PCI_EXP_LNKCAP
Message-ID: <17c8a60aed5560e482d56ae834e46563346212d5.1793207602.git.mst@redhat.com>
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

From: Li RongQing <lirongqing@baidu.com>

pcie_aer_inject_uncor_error() wrote inj->devsta (a uint16_t) into
PCI_EXP_DEVSTA using pci_set_long(), which writes 4 bytes. PCI_EXP_DEVSTA
is a 16-bit register at offset 0x0a; the extra 2 bytes written by
pci_set_long() land at offset 0x0c, the low half of PCI_EXP_LNKCAP,
zeroing the link speed/width capability fields on every uncorrectable
error injection.

Use pci_set_word() instead, matching the correctable error path in
pcie_aer_inject_cor_error().

Fixes: 34e65944c035 ("pcie/aer: helper functions for pcie aer capability")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260915072908.2197-1-lirongqing@baidu.com>
---
 hw/pci/pcie_aer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 22497b1fd6..43b14c1f22 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -589,7 +589,7 @@ static bool pcie_aer_inject_uncor_error(PCIEAERInject *inj, bool is_fatal)
     if (inj->unsupported_request) {
         inj->devsta |= PCI_EXP_DEVSTA_URD;
     }
-    pci_set_long(dev->config + dev->exp.exp_cap + PCI_EXP_DEVSTA, inj->devsta);
+    pci_set_word(dev->config + dev->exp.exp_cap + PCI_EXP_DEVSTA, inj->devsta);
 
     if (inj->aer_cap) {
         uint32_t mask = pci_get_long(inj->aer_cap + PCI_ERR_UNCOR_MASK);
-- 
MST


