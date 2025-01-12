Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF918E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 21:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX55V-0004Tr-6J; Sun, 12 Jan 2025 16:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55S-0004Rh-Om
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:34 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55N-0006Mt-LJ
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:34 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aab925654d9so708138666b.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1736715688; x=1737320488;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1AEBtla32qHIfczhWdQp7SwWsFBGmYq27EGiFppSeA=;
 b=DuGBLlgcHN1p3tOnz6b2oUICRN1Zk6bH5esgQcmg77Fyn2qhMF5OMIvaGfRzfOUpU9
 dX0ZSg0eYMw4zoYHYi4dbo/g7l78eDeBRm8qgphsNSE1RVhA72kMCriWfFO8SZ47Pcuj
 GluPZBmM1px8kyURViyTtXTz/prjMGIFCGs6Woc3cmvvE1A4bN4PfftSVYpyjjpkg1mj
 MRD1rFexrkDMLAK5xPchuXrSeSAZwVwTX3Hwg7QlXNAgbV/L+xkdPCouyi1aEYHlDNbT
 YdWN3SE00YiWKs3bVMzLkmfVo66B7xMxNodIq2hXwrfFEjQYLmoh/cxTOQFkKJ5AkvqC
 I31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736715688; x=1737320488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1AEBtla32qHIfczhWdQp7SwWsFBGmYq27EGiFppSeA=;
 b=Jbyg7tgVFNDiSHJZ8ZsN8JwrON4RYZWdGxes/Z1JEeWgJRzurjI6UlF4PuMfKjMIs0
 R+UrzKWga+81wpVbSNiw2VLpwZx1PMo+HfisO+N4cYYGBqUf4Olcw6KcZH+LuDDVkm+B
 ypyFgk+K6Adzmem6g9SsQhOzYXR93dojeGYOUYhhaDTxxanqo54wQv09KNJyih5n/nan
 BnDCblxtQudV6iqQBqyx3YVTOl4yvufUDAZOUfHFDDoPbzqFqPC4NsTGoG5oAHNFoKxk
 ccIHdL82RBTz5QTV9HKdX1MBAU68gV3JPuFfodyOxW/KjDvOK1ULKWVQsuEtCnq1ZPS5
 l3bQ==
X-Gm-Message-State: AOJu0Ywl3j7ndBzIbBBrSxl9MGF48SLgnitDy7Egfxp4ZrGOU5uRq+k9
 2WYV1vOkhUunulUNFgkR/YFyNWtFeyO1Iif3adsleeerYAFKST8DCQHkADddguYqmm9q1mH489V
 /7g==
X-Gm-Gg: ASbGncvH15LrGZ5dRwcTq0MqJk045hxtYdx5cCDy8OzYO3/P8enwVFXDNd8LXs7S0MX
 YczM52Krat/IuXR5JY8PyMb9/FFNe33Ju5PXBj2c8XcRH00lXvPcNk5j82X/uxwD4Pgp1qySvXS
 3/yvwopOC0XHn0THtcAWOya0JZaJVh1p0Mkm2XHPq+Dok5TLOTVZ3DmDYkH8btDmb6oy7PXqINm
 /bx7LVhxs8S5aAJo8ZhhmpW2Au1OaZ9qpC0R8s4CZ5s+BPa8DyAtK1Tc+mDcqOscJvdTlCOnxCs
 ij3I1MJtg1n2GnNm4gqFs3evL2DbIn9Z
X-Google-Smtp-Source: AGHT+IGtOslRPacgqn7vWd6oYJVnyMzESDSzif5I8Dy3Rs7pDdX4gtCSkAH8LHsDC2x0E5HYxkmmZg==
X-Received: by 2002:a17:907:3e24:b0:aa6:7737:199c with SMTP id
 a640c23a62f3a-ab2ab6fd036mr904373666b.15.1736715688210; 
 Sun, 12 Jan 2025 13:01:28 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905e283sm418276666b.31.2025.01.12.13.01.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:01:27 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@linaro.org,
 eblake@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org
Subject: [PATCH v17 02/11] hw/usb/hcd-xhci-pci: Use event ring 0 if mapping
 unsupported
Date: Sun, 12 Jan 2025 22:00:47 +0100
Message-Id: <20250112210056.16658-3-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112210056.16658-1-phil@philjordan.eu>
References: <20250112210056.16658-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62e;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

The XHCI specification, section 4.17.1 specifies that "If the
Number of Interrupters (MaxIntrs) field is greater than 1, then
Interrupter Mapping shall be supported." and "If Interrupter
Mapping is not supported, the Interrupter Target field shall be
ignored by the xHC and all Events targeted at Interrupter 0."

QEMU's XHCI device has so far not specially addressed this case,
so we add a check to xhci_event() to redirect to event ring and
interrupt 0 if mapping is disabled.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-xhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 7dc0994c89..00d5bc3779 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -644,6 +644,10 @@ static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
     dma_addr_t erdp;
     unsigned int dp_idx;
 
+    if (xhci->numintrs == 1) {
+        v = 0;
+    }
+
     if (v >= xhci->numintrs) {
         DPRINTF("intr nr out of range (%d >= %d)\n", v, xhci->numintrs);
         return;
-- 
2.39.5 (Apple Git-154)


