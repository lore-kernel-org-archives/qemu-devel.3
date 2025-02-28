Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0286AC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 05:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnsgf-0002xl-Ek; Fri, 28 Feb 2025 00:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1tnsXF-0008L4-30
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 00:03:43 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1tnsXB-0003g8-G3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 00:03:39 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2feb867849fso1411879a91.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 21:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740719014; x=1741323814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:to:references:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sCuL1Z28Y3V6+IfwtxZ4kgJUz5bCHywRY3uphPqrW8=;
 b=TqNxRZb2YXM5NfE7PAy6NsuwZANnSOH5FRw1jl8wNRaIEPXQ0lQsAT3kbaOMxjoNOp
 loBjKZIJQsdPbJhlXtfmZpVR2YDN31xQaFhxhW6gsPpiKhJW/fPh4oqniLfOr7+Zpo/U
 qWlqAk6d5fr7qOyb0AmoFrAYZtjRDCHN3jw6YwcA0M5z5Y2o8bLlWAVGHTkN/4cQLCs8
 CvTw7gSt67PDAnTBwxlKiyNd41NmhQ6NnHMqXInVKUFRCRR4oyzr4ns7+78UJNBbIcyj
 2YEB5DV/5YXKPoE1pnEWKdWDmNuN78RBqz7MVA8T+EvjK0qGJtd1QbP3gVplRl0pNwpd
 /Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740719014; x=1741323814;
 h=content-transfer-encoding:in-reply-to:cc:to:references:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0sCuL1Z28Y3V6+IfwtxZ4kgJUz5bCHywRY3uphPqrW8=;
 b=SLpFq2szYCbIa0AYERf5XdJkmKjXyP0DdMEAiaL2gegF18VNTvYaZ6YTWaBeraYnVI
 NLPl96Aal1mi1dspp1sBqHUbRQsulFJTi1HSbEQI5XorDP2hmVRdDJVtZ5YgDQFpumTg
 aVBxWQmSoXILEopCdUQoSvdK1TTuz5qPiwSKA29zcTWx3QX4bwRdYmHJUNba20lbUZAr
 /Ihqx+7lZDvkQtg2Kc6IPf9EewINDdx1wAYq6LhnGzMI31tJLweiDsMnorUVi+yWoKRR
 +cMiQKNWuUhkXJlhkvH2EoHCAc/qwm17axSqVnxQdKD1ALiIm2lsgFqV2h/xotG2EIG7
 BfqA==
X-Gm-Message-State: AOJu0Yz3fFzI9rsuDWIsr5jNlduL4UjTlcwPeZQYs7PUz2mtKjidDsZD
 TDPEDahI/oh+ipLnpf41dIu3251mBC5zG+tRxyJEeLxxQ7IrFOqt
X-Gm-Gg: ASbGncuqnSCyFgX0GIlplx6EL0i2havCXLhom5chDflpq8cWb639X+mb9XnLGk1pucP
 EJGRN5DdJYHTKV32uKT+4qo+IDsz1eMHSLtNooCpVO+I+Ck4kVTIkDZFBYeBJpQkWlba7GeC4b5
 mCgS+ONN0pGCsMb+Fy+JTWwqOofHMfLOZEeS/+xiVg9qJHQtQx/ZZBZQQNrRcBTxvIqK5lY46h9
 A8RGYhR1EHi1sLGED06UXTruL3HWD9aHske3V9nxrtKl6+Hh/AxrHqr0ViNF7tGuEk39oTsTVw0
 vTHEJ+HzjOyQ6hA6Ee4yFKjJRLkGlSCgLCJwzCs=
X-Google-Smtp-Source: AGHT+IG+83XxcFfI5rP/w9wNyqqnS4FrDT0rkc1bUTlQ5LFnmWZvJO9CFha2PRggXg1VFcI7cldKUA==
X-Received: by 2002:a17:90b:4f49:b0:2ea:3f34:f18f with SMTP id
 98e67ed59e1d1-2febab78d6fmr3032865a91.19.1740719013931; 
 Thu, 27 Feb 2025 21:03:33 -0800 (PST)
Received: from [101.5.21.88] ([101.5.21.88]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea696e37asm2997088a91.35.2025.02.27.21.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 21:03:33 -0800 (PST)
Message-ID: <69cb6f19-d87a-4ddf-9fca-612b30828679@gmail.com>
Date: Fri, 28 Feb 2025 13:03:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH] virtio-pci: fix memory leak from device realization failure
References: <7702b335-6e92-47c7-baf9-a384f75a0db3@gmail.com>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, hz1624917200@gmail.com
In-Reply-To: <7702b335-6e92-47c7-baf9-a384f75a0db3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=hz1624917200@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 28 Feb 2025 00:13:24 -0500
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

This commit adds failback routine for `virtio_pci_realize` to 
fix the memory leak of an address space and the virtio-net device object.
If the realization of the device failed, the address space should be 
destroyed too.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2845

Signed-off-by: Zheng Huang <hz1624917200@outlook.com>

---
 hw/virtio/virtio-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c773a9130c..4b0d8cd90a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2266,6 +2266,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
     virtio_pci_bus_new(&proxy->bus, sizeof(proxy->bus), proxy);
     if (k->realize) {
         k->realize(proxy, errp);
+        if (*errp) {
+            address_space_destroy(&proxy->modern_cfg_mem_as);
+        }
     }
 }
 
-- 
2.34.1



