Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD068CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 19:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtubG-0002n8-G1; Mon, 08 Apr 2024 15:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtubF-0002mv-Jf
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 15:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtubD-0002gL-Sr
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 15:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712604250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AItEfsV8+NEVMOr7/6QYGuQ5+UKInIqZ97RbUf9Y3as=;
 b=CbmG2+pn/x/0HmUkVGaSgOKrIYf7roDf/CN7Y40/0MGub37/j2JcdRhxnGp0nT+IGFyPV1
 n5mzdDfOtMW5Dg1TcOoDEb+3HMVTgAtShI3aTD3+2oPBivNXxxRUfTyrtkz5M3mpQTw/Sf
 ZR5csObTjaYZEnEy/MYmbj+ZZcC7mKk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-cLZb0JOMP0yhDeJMGnwPHw-1; Mon, 08 Apr 2024 15:24:07 -0400
X-MC-Unique: cLZb0JOMP0yhDeJMGnwPHw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4155db7b58cso24399865e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 12:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712604246; x=1713209046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AItEfsV8+NEVMOr7/6QYGuQ5+UKInIqZ97RbUf9Y3as=;
 b=nHY4pGvQZRKSCvZb08jPmbc33l5YXgOhoQiByfleRBa0hkK/LP2uPI2/m9jGaTeSL/
 bxfBjo7TeEIwG7TFNflBBCKUsROwLD8Fosaqfr9b+61DwwPSloYprcpp+nK62V0xGqns
 e2UqrDFaV1qtrULRYNnEBABy1Ve95J3kxT9Td7yxLXCliBrYU3SMDWu3tjxyw0HKAaf7
 jbVqMCXsCBxrNjHK4870jT/NvcDHcG6o2BEy+u3FjYPSuQIzwcqnsASLM43J6uBQS8ne
 aEJ85UbqxjDiDTHs9BhhVabJpROtDNwNnjJptlfvxNgXNIHozAwYPDsqMXRjgi+JMo1w
 0LqA==
X-Gm-Message-State: AOJu0Yx401bKLAJ2HZigB8NIVSn66aolPSWzY+/kLlUcBDj74j8CgGMK
 GUejfpokYJGkfhGEKfQZ6ZrmDAMB8tcboCktPn2Xo3O2m43F24cNAjyhZIorZ+HpjE6L9haSXdu
 HeNSKl2EI2vf/cA/SaIeT9Ss2woiYcWNUffVUEe+Mmeeg9IFke1pgbMsnNamrK7FVk2OwbMgDgq
 qNs+MMIXJazvh8RL6lfd3hO4PTaflp6NB7qf01
X-Received: by 2002:a05:600c:3108:b0:416:4923:1f2d with SMTP id
 g8-20020a05600c310800b0041649231f2dmr5065034wmo.30.1712604246420; 
 Mon, 08 Apr 2024 12:24:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG139vwZZ5BPYeGFivc5EVg8z+Lub9ArkjhdDfnfYbZRv4UaSMaIuqVrCOretq78zBQVGuT+Q==
X-Received: by 2002:a05:600c:3108:b0:416:4923:1f2d with SMTP id
 g8-20020a05600c310800b0041649231f2dmr5065023wmo.30.1712604246027; 
 Mon, 08 Apr 2024 12:24:06 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 n33-20020a05600c3ba100b0041669bfee03sm5326295wms.19.2024.04.08.12.24.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 12:24:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] 9.0 bugfixes for 2024-04-08
Date: Mon,  8 Apr 2024 21:24:01 +0200
Message-ID: <20240408192404.542506-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit ce64e6224affb8b4e4b019f76d2950270b391af5:

  Merge tag 'qemu-sparc-20240404' of https://github.com/mcayland/qemu into staging (2024-04-04 15:28:06 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to e34f4d87e8d47b0a65cb663aaf7bef60c2112d36:

  kvm: error out of kvm_irqchip_add_msi_route() in case of full route table (2024-04-08 21:22:00 +0200)

----------------------------------------------------------------
* fall back to non-ioeventfd notification if KVM routing table is full
* support kitware ninja with jobserver support
* nanomips: fix warnings with GCC 14

----------------------------------------------------------------
Igor Mammedov (1):
      kvm: error out of kvm_irqchip_add_msi_route() in case of full route table

Martin Hundebøll (1):
      Makefile: preserve --jobserver-auth argument when calling ninja

Paolo Bonzini (1):
      nanomips: fix warnings with GCC 14

 Makefile            |   2 +-
 accel/kvm/kvm-all.c |  15 ++--
 disas/nanomips.c    | 194 ++++++++++++++++++++++++++--------------------------
 3 files changed, 108 insertions(+), 103 deletions(-)
-- 
2.44.0


