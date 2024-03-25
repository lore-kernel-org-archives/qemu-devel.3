Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453A5C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokwa-0000QP-Fl; Mon, 25 Mar 2024 10:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rokwP-0000Nq-Uj
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rokwN-00049m-5D
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711375482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E8yIDiCX/Ln3x0nNQdql3UK/HtqDf0IEIrOFJt+xFMY=;
 b=P4/WhYDARX33Z6oU/71eK4lawzREC2dwHJ79fRof+VFXRAZdp8FBQPHXFwaKtXRWxyFdmX
 RGSqlTw3e5HuZxFvUT7zOwN8+PgJ1NHNJZMj2912cKgoQ/SVsSGAk2wqbrQIPvSYEEc+eM
 DaHpknwHpiIQiD7TVHtYrx5ELiTziEk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-973qy01WMeSx0E-T5v3M-Q-1; Mon, 25 Mar 2024 10:04:41 -0400
X-MC-Unique: 973qy01WMeSx0E-T5v3M-Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a4943e972d1so108140966b.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 07:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711375479; x=1711980279;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E8yIDiCX/Ln3x0nNQdql3UK/HtqDf0IEIrOFJt+xFMY=;
 b=QJ3Ez3JhiS9x+V3zq17WhzqBX64zF+SEgjIez05WwJmDcnOJRvPrd1hyORxYYGZMH9
 gU7paPDHEpgHSqMwiskSD4eTGvBAHIWYD1xYgZgY6qeOiss7H5TuCiJGFj+Als4OeCBR
 RmNTbZ3NjHxlV1yez8h13WsAZwhOrgbMcKA1lt/PvBfi09cFKeVQKCNh8v+Wc/Q4MHcc
 qudvU934UuPKFHm2Z8QquYSfsYBtYD2vkNWB8FUjrrWkf40+Zx08sINimw9HYqKBWKuv
 yPEO7aIiD0uarRD3x0KqeUApclpvXny8lcgQQOlApvpAHijGqZPjWpFliiq7r3OlKCBx
 QywQ==
X-Gm-Message-State: AOJu0Yz+SGGy75Z51IVvVX3I+R1N9vyHYXLqeBWJShoCaCU0i6nwdQ1d
 tFxkXEaEtz5q5JwEQVTGYg6fQO7VTS1p4U+ZyDni7u6ToJ/tuRhoXh7PzL81vCDYUfi9wR1uxhU
 Qrbbaqf6eEOq36+SxFCbUFAufxd827reD1lK+eUk7Wn9AQnGvkmwO6FvmAVs4o2nT+RUcXLwA8z
 FFhI41H5E8IOPg0nMnWz6F/dfIy0JrHvtsUu8h
X-Received: by 2002:a17:906:fad6:b0:a46:d786:3672 with SMTP id
 lu22-20020a170906fad600b00a46d7863672mr5365532ejb.13.1711375479231; 
 Mon, 25 Mar 2024 07:04:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfYTr6OuCk/6v3QU15byJhL0L8cT/4I4AmmZTY/1GtMbcvwCx2BEmEoT9XsdMzudiN9MP2Iw==
X-Received: by 2002:a17:906:fad6:b0:a46:d786:3672 with SMTP id
 lu22-20020a170906fad600b00a46d7863672mr5365518ejb.13.1711375478776; 
 Mon, 25 Mar 2024 07:04:38 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a170906398700b00a473a28fa91sm3080996eje.0.2024.03.25.07.04.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 07:04:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] pc_q35: remove unnecessary m->alias assignment
Date: Mon, 25 Mar 2024 15:04:37 +0100
Message-ID: <20240325140437.1374224-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

The assignment is already inherited from pc-q35-8.2.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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


