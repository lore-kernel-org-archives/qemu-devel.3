Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC76C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDEC-0003fb-Md; Wed, 14 Feb 2024 06:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEA-0003XM-RH
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDE9-0006xy-7V
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FeqQbjEcpCbjayR7Mh9VjABD+SO9Cb44x6hEWH/bfvY=;
 b=Vkz5Hb5j31yTbAw1f8/oTcg4qN3j+0J3zi8bBVgCpcTj8KZBVw+r0n5FlG2qqhz5sofcfy
 L/fg6rVRz9T92XqhvmJbaeXu7RaQvr58joCHBPKz5LeO2foDiqTzKnff/lN0RZmMSqtgK1
 Fk+lKIQDh9hm44da3yrZDWKr584dpdk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-qX0cVYV0MYucatKqI55plg-1; Wed, 14 Feb 2024 06:14:54 -0500
X-MC-Unique: qX0cVYV0MYucatKqI55plg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a2f71c9f5d2so388469666b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909292; x=1708514092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FeqQbjEcpCbjayR7Mh9VjABD+SO9Cb44x6hEWH/bfvY=;
 b=Ofwd/osKIdS9dScK8ACV0cq1QYSY1pSriGQBV9qAkYko3oT+JFL6gGj9pKb15xrkkO
 3fZkhXUNpIh5t90yMXNmXcjlYhyQg8vAPd7BT/uOcFuMC0JcThQMDfrDGlACVL2TjqxV
 siVxDZN6fTEBwQ+4X+WTO4fmoTj20xWOYOgoaxk4dsFbcKYZcsedOTJa7rWaX+ix7Sgl
 7daEdC6mxlX1zwySygVdCRVCTjOjCxQzojqeFPMsW6gdFIs4+nP6bjsCOG9nIO4kT00u
 Sqh5m7SPkvutPmZ9dEWR4tI7kq1XcxDQt3yiucC/fEg0bg/9dix7FpNhRZRomaBgoJcQ
 QazQ==
X-Gm-Message-State: AOJu0Yxrla/cgt/wmBWET0AObJw3v5vJvse9LbJoc7GcSI3spvWvawdP
 pA76m6oyUzj3+l8OyT5HL84jkzDfN2S1YUJvLpLg3qUSlkFC8D9NAtxjSB2NnyVV1sHbOkkzfa4
 w57rKWVa6/0SkzN5vVogkTDuZA1BCujoZXSHFUNVYlA5kxQ2if03Y+3iO6g5x2dd/G/cIhsx+kF
 3MpCI2ygLQe/HkTlGrL9nMJexusDf43g==
X-Received: by 2002:a17:906:35c6:b0:a3d:232f:a4f6 with SMTP id
 p6-20020a17090635c600b00a3d232fa4f6mr1776018ejb.11.1707909292307; 
 Wed, 14 Feb 2024 03:14:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhb2V8CS78PyQAJ31vjUL9bYYGJFoRBw3QNnIEbXlTSxHvZhxulMGXEl0gBUC38UL7k6/ZKA==
X-Received: by 2002:a17:906:35c6:b0:a3d:232f:a4f6 with SMTP id
 p6-20020a17090635c600b00a3d232fa4f6mr1775998ejb.11.1707909291994; 
 Wed, 14 Feb 2024 03:14:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV2hKf72jdrAErus6+SZojSJlW8IYLH6VFNk5ZaP7bvWcBOLJqZEtiTpGvG0nTFpYefp2ED+sI3HqQpdsv8YS5D2aD8HFWyyBxgu1ptrmeFoQUChQbOh9Z/eJ2oj8NC/psG0ZOE9mjT8D4bllk193zPqZJy
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 qo12-20020a170907874c00b00a3d061514a6sm1489363ejc.201.2024.02.14.03.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:51 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PULL 30/60] hw/char/parallel-isa: Implement relocation and
 enabling/disabling for TYPE_ISA_PARALLEL
Message-ID: <1d1afd9ff7264c7ed35f3ca25cc4bf9dd82a6b06.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

The real SuperI/O chips emulated by QEMU allow for relocating and enabling or
disabling their SuperI/O functions via software. So far this is not implemented.
Prepare for that by adding isa_parallel_set_{enabled,iobase}.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240114123911.4877-10-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/char/parallel-isa.h |  3 +++
 hw/char/parallel-isa.c         | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/char/parallel-isa.h b/include/hw/char/parallel-isa.h
index 3b783bd08d..5284b2ffec 100644
--- a/include/hw/char/parallel-isa.h
+++ b/include/hw/char/parallel-isa.h
@@ -29,4 +29,7 @@ struct ISAParallelState {
     PortioList portio_list;
 };
 
+void isa_parallel_set_iobase(ISADevice *parallel, hwaddr iobase);
+void isa_parallel_set_enabled(ISADevice *parallel, bool enabled);
+
 #endif /* HW_PARALLEL_ISA_H */
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index ab0f879998..a5ce6ee13a 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -41,3 +41,17 @@ void parallel_hds_isa_init(ISABus *bus, int n)
         }
     }
 }
+
+void isa_parallel_set_iobase(ISADevice *parallel, hwaddr iobase)
+{
+    ISAParallelState *s = ISA_PARALLEL(parallel);
+
+    parallel->ioport_id = iobase;
+    s->iobase = iobase;
+    portio_list_set_address(&s->portio_list, s->iobase);
+}
+
+void isa_parallel_set_enabled(ISADevice *parallel, bool enabled)
+{
+    portio_list_set_enabled(&ISA_PARALLEL(parallel)->portio_list, enabled);
+}
-- 
MST


