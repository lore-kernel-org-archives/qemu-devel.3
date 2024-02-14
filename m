Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEA3C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDE8-0003Fn-S5; Wed, 14 Feb 2024 06:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDE6-00033l-NV
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDE5-0006vu-8x
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MRWTVErun+rCrNj/knFfh+bLyvrCH3Pht/W9/VrpypY=;
 b=MrffwFmip9RcdKKgHB+QKdW3jq7Z2kNZQNsw4ePo9Z46m23K4VmJ4XB3cfwGaNwn7rtb+m
 l9wPrq+61/sRDVFNcSrhDJudjg/qncWDx5jHbGNwfGQEcChtIQLYl7zM2YlScSKCB3NpSY
 0e5M80jq0HQMuztJ8fPFsAALqdSZ5mY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-Qi6APLYqOv6X0vS4UyPzMA-1; Wed, 14 Feb 2024 06:14:51 -0500
X-MC-Unique: Qi6APLYqOv6X0vS4UyPzMA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a2c4e9cb449so364357366b.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909289; x=1708514089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRWTVErun+rCrNj/knFfh+bLyvrCH3Pht/W9/VrpypY=;
 b=FBaLpfvXdCHfvlCSu5sKCgMk9pTfeh07JIUHHOPJIbUg0Rqz313smHTdIizp0wnW+6
 vakfTLMQ9ePJFBN8l2y9aFxqBIzonhQXmKKzl83MU07IlTd387sMD7ukn/W0xYwA94WS
 YuxGqPVsE9G8QvFZbM/roe2OjyEoDUpS7NazjdijK+IuVUm+RAV5b+C62Yz0k616n5Iv
 6noO8Ca4FN27LBtKW0+8QTwL8YDWVakRZa4yHb1itbdNAHaHHJ6+Dopl8oSkuO2AcrS4
 C92TN1LwFQ5jOcSlQNPpyrlBHkwaTlTqdG428eO7YH/yfzHuqk+pU6r67NbpoRDrT2qY
 1mrw==
X-Gm-Message-State: AOJu0YzvfNcSBLqu75ffIlUCh46Jht7MG6KY7ZwMG4uAd04CqG5xSwI+
 3+RQ7nCw82ejsmcRHw1wL1o1BB4UrudkF7f63fpBPLnaymzKIAfGGPEeU5OMDTISrVHO/xWYiBJ
 HWAZ/6v0M1gGDpKsai8/v58sm6lVZzItLbv0YOUgksdpW9lcVzf6xjouL5q33e5oWWiUhyF0PmD
 VvjvDgyLIC7lVe0BKVsjAWespEBCzJBQ==
X-Received: by 2002:a17:906:3591:b0:a3c:ed94:7672 with SMTP id
 o17-20020a170906359100b00a3ced947672mr1643146ejb.64.1707909289428; 
 Wed, 14 Feb 2024 03:14:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfbWgdbIr7LA7h+6ZHBrUSSCOOU2nCxfE29VU3mbL40DK9LPkbmZ6R4HMBOgWV9uJSZcel2w==
X-Received: by 2002:a17:906:3591:b0:a3c:ed94:7672 with SMTP id
 o17-20020a170906359100b00a3ced947672mr1643128ejb.64.1707909289101; 
 Wed, 14 Feb 2024 03:14:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX2XO0sv708t8NJXtk5CCWXGRYHfOjjvQx41rLKPpYbPqkmg8Tu/t+55vQKErgkOTJVnSCB6PScPjTpqIN7iv922spauKlL4fHtLI69Iu1XuaxmFvQk9xkf/seQ83fc9SATL7/l4YpKTKSPtw2TydKimiUU
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 qo12-20020a170907874c00b00a3d061514a6sm1489319ejc.201.2024.02.14.03.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:48 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PULL 29/60] hw/char/serial-isa: Implement relocation and
 enabling/disabling for TYPE_ISA_SERIAL
Message-ID: <7812dbc54c72f71df2644d0cec52a1e8d6b19584.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Prepare for that by adding isa_serial_set_{enabled,iobase}.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240114123911.4877-9-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/char/serial.h |  2 ++
 hw/char/serial-isa.c     | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 8ba7eca3d6..6e14099ee7 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -112,5 +112,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
 
 #define TYPE_ISA_SERIAL "isa-serial"
 void serial_hds_isa_init(ISABus *bus, int from, int to);
+void isa_serial_set_iobase(ISADevice *serial, hwaddr iobase);
+void isa_serial_set_enabled(ISADevice *serial, bool enabled);
 
 #endif
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 1c793b20f7..329b352b9a 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -184,3 +184,17 @@ void serial_hds_isa_init(ISABus *bus, int from, int to)
         }
     }
 }
+
+void isa_serial_set_iobase(ISADevice *serial, hwaddr iobase)
+{
+    ISASerialState *s = ISA_SERIAL(serial);
+
+    serial->ioport_id = iobase;
+    s->iobase = iobase;
+    memory_region_set_address(&s->state.io, s->iobase);
+}
+
+void isa_serial_set_enabled(ISADevice *serial, bool enabled)
+{
+    memory_region_set_enabled(&ISA_SERIAL(serial)->state.io, enabled);
+}
-- 
MST


