Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD0CE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmtS-0006mu-80; Thu, 12 Dec 2024 12:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLmtK-0006m9-Rv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:22:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLmtG-0006mT-2V
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734024135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MpwabzURXwkWGeV9eBFMbfUWRyFiGXeK3DZtokPWu8Q=;
 b=Cp/cQV980EJxyjO+H2s5AUUbG1F2LE40UJ9xG8zNHkhpiC1FuwHOO9quNhynAvtYeWA3HI
 HKqp03DW8iCu4zDw5m72rRLmSv6MT8fesA/9iWq6FOkcxDVbUF14UUUGbf4KNBsSDQbxMZ
 wv1PCfLqSotXRyw3cutCRtRFh9PRxpk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-1C6jxO_FPBOXyGf-CamXwA-1; Thu, 12 Dec 2024 12:22:14 -0500
X-MC-Unique: 1C6jxO_FPBOXyGf-CamXwA-1
X-Mimecast-MFC-AGG-ID: 1C6jxO_FPBOXyGf-CamXwA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385dc37cb3eso512655f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 09:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734024133; x=1734628933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MpwabzURXwkWGeV9eBFMbfUWRyFiGXeK3DZtokPWu8Q=;
 b=SvUU7HhrRdv0OBz24AmtofcQVkKfcRCTZTybOlu5vFwpGeGT0NgFb8m1s7thwPdtVl
 oDM9uZgFh/fgOnCS4MoSZgR/n/qAWM9qGdOLOzM9yltcWqD+oRO/kOwmuaWwzn/Bxdsb
 qAji6JTr/k9aMsnkruM+6vnrbTWa9L5JJKGEI6ACQJmWc2WOI6Gp4nZmAdJ65x9kDsPs
 m+FJcwS0yfYnCfVn/b6IUgE+S618GrgDyQu6SFUXOnKMQwUg6XDnJn296VBBT97Omc5d
 cl6trH+8NqyW2cDaIYcCw6CkiEAaaecAq2YTIG6hgq22LSy1p07RhPWBsZxaQaLxmn5v
 riMQ==
X-Gm-Message-State: AOJu0Yz1sQ9xpNS5/fEXTFFugDRko/2UfYV9tHjR0VPfReWGLu8S2EVp
 iwR5WVK9YedsRxNjdvs8ppI5X4fTqdYAlNL4S/NuTjrdU0zUox4VE2Qjx/7B3Os9JdEvR+oD2wo
 VUhtoaXHvCSyx/QrFFR/N2nBJ0d2v1xUD8GXZ9Wz84FR+N4cW3QzcLO1P9hl6WrD0tHGnEt+ZCT
 Deurcq9hT3mh7JOjil0+48U0WmglqWm011kZyd
X-Gm-Gg: ASbGncvRcGnrRo7q7fUiDp3RNF2Qxj1EBJRFWmV42qGmXt6+vnCYbJvbJp4WzKpKWui
 3C3M6HhJPn9LhGyzXBBoE1uqOYCbdSAoclGj/XvbdZaF3uuaEJEW6PKGjXElhuBBu3XIWCpMvry
 fh3Uxwiu0G9zNtnYrXtXw1zJ/zNgKQ/K7pG6a7lnTEVmdaMovy5KlqURpsiU9pzjXGUtsaPkNkq
 6PCjB5ccsiA1sS2QOM6ZR7ynJMKhazooNnEu7km8N235ttudtNFhB0PyS2s
X-Received: by 2002:a05:6000:480c:b0:385:e1a8:e28e with SMTP id
 ffacd0b85a97d-38787688445mr4122461f8f.10.1734024132727; 
 Thu, 12 Dec 2024 09:22:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQdx4ErH/KJOgdQGGnnunsqKetXR8ZxPY5xNETUxdkG0mdeOX0Gum0+gKhI95gWCwg9kyWrg==
X-Received: by 2002:a05:6000:480c:b0:385:e1a8:e28e with SMTP id
 ffacd0b85a97d-38787688445mr4122409f8f.10.1734024131367; 
 Thu, 12 Dec 2024 09:22:11 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824bd45esm4620260f8f.43.2024.12.12.09.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 09:22:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH 0/7] rust: pl011: bug fixes
Date: Thu, 12 Dec 2024 18:21:57 +0100
Message-ID: <20241212172209.533779-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While preparing the comparison at
https://lists.nongnu.org/archive/html/qemu-rust/2024-12/msg00006.html,
I noticed some bugs in the code.  These are the corresponding fixes.

CCing Philippe because he expressed interest in bringing the Rust
version on par with the C version of the pl011 device.

Thanks,

Paolo

Paolo Bonzini (7):
  rust: pl011: fix declaration of LineControl bits
  rust: pl011: match break logic of C version
  rust: pl011: always use reset() method on registers
  rust: pl011: fix break errors and definition of Data struct
  rust: pl011: extend registers to 32 bits
  rust: pl011: fix migration stream
  rust: pl011: simplify handling of the FIFO enabled bit in LCR

 rust/hw/char/pl011/src/device.rs       | 119 +++++++++++-------
 rust/hw/char/pl011/src/device_class.rs |   8 +-
 rust/hw/char/pl011/src/lib.rs          | 161 +++++++++++++------------
 rust/qemu-api/src/vmstate.rs           |  22 ----
 4 files changed, 160 insertions(+), 150 deletions(-)

-- 
2.47.1


