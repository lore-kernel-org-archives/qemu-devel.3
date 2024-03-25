Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098FDC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokrG-000625-2e; Mon, 25 Mar 2024 09:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rokr8-0005wT-Mk
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rokr6-0003GJ-IH
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711375154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i+FtpRhR0tCHuy+hIsXjL7/lnJGaWlhxJcKpm07Ievk=;
 b=aVm7dCR+C3BtmkK48oNMc7weSbaYiQ0vv0TdUOXKYpmGVJDw1B6fe/+/qhzTJTuPkrgwnh
 o8r0Qh/JF0H5Eub/goUD8tQ87Vk+p90jMq36opmFLkxidzcaFLtaa2ntFog3SyLfPnfTWI
 PQu8ZqhN2SO8IL+QfTdRDqUqNO3fOnc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-Q5FDXo3XOrqrUoAjxskzXA-1; Mon, 25 Mar 2024 09:59:12 -0400
X-MC-Unique: Q5FDXo3XOrqrUoAjxskzXA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1e0a4e28c06so11608685ad.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711375150; x=1711979950;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i+FtpRhR0tCHuy+hIsXjL7/lnJGaWlhxJcKpm07Ievk=;
 b=g47L8RuNmTx2LiPUpGw8lwaNcVli4BgzyxlK0S7IHdao172bZvHivYu6R0WGPFWmgw
 Dd8vQTKco8kTPUm0ZYMR3HaJDmEVXhWXet5LqRGlbMs98/yFGzxPDbuSZsuaCywZ5g4C
 q2Xr0snjBjKX0DvZ1np+fso0RcD73L96zSPJwlP0LoHT9nJKExQmuk6gZ+E5RnLGih31
 OScFP/JBXGo0Zj0drzC0gdBFih1yQroWBi0KRs4/E4pjUtQto4K9UFjAoaDX4uWJPfgJ
 Sc60NmzV9CLGsquTMuA3zx+LKcFWhMvAQ+RjhaYx4Vhihn/TqeAolKY7jL1jLH64kMqf
 r3YQ==
X-Gm-Message-State: AOJu0Yxe0TT5OdVbSFSIWdI54pXl5X5DvFp2Byzc3PAb/TMSLD781H38
 JclZMNJo3fFLDuzem5rfCk9D9PywY5GOwglM2x4ERC9f9WbPIVQMXKQDXZ6dWuKwfmpno2+6aKU
 dL/HGqGcvM3x20e3oDe4B9cCsQCfWimhVkadFFeJAS/NF0r2E8eRAJVQLdmuksLLKjiyRPZ/jrf
 suf3lPT3IzLHkaIvKCw6Bp25kry2luLIlHbzV6
X-Received: by 2002:a17:902:d212:b0:1dd:a134:5699 with SMTP id
 t18-20020a170902d21200b001dda1345699mr5511075ply.28.1711375150137; 
 Mon, 25 Mar 2024 06:59:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcPR8M5IucGTKMcDjU0cs/GQItQdQV1H/tIl/tHIzV7LO6dZARM91eFuyVCHiBFUnR0XttqQ==
X-Received: by 2002:a17:902:d212:b0:1dd:a134:5699 with SMTP id
 t18-20020a170902d21200b001dda1345699mr5511058ply.28.1711375149701; 
 Mon, 25 Mar 2024 06:59:09 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 r2-20020a170902c60200b001e02d9c05d8sm4691835plr.103.2024.03.25.06.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 06:59:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com
Subject: [PATCH] pc_q35: remove unnecessary m->alias assignment
Date: Mon, 25 Mar 2024 14:59:06 +0100
Message-ID: <20240325135906.1372946-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The assignment is already inherited from pc-q35-8.2. -s
---
 hw/i386/pc_q35.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b5922b44afa..c7bc8a2041f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -393,7 +393,6 @@ static void pc_q35_8_1_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_8_2_machine_options(m);
-    m->alias = NULL;
     pcmc->broken_32bit_mem_addr_check = true;
     compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
     compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
-- 
2.44.0


