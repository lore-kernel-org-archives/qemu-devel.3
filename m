Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5633C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtyV-0005Lm-Tp; Fri, 30 May 2025 03:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxD-0003EX-LW
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxC-00071A-0H
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LreXCX5lf0B8e68ccMZZleAOkfyyuU+H/pIa6hQpwkY=;
 b=ZcUw3tX2OCY7vls0/e93GY7fcGWdsCIQ2xKwDG+FviBTAxIwYt/4KeGhCf1c91LtNjpta8
 ozjfD1FJz6kr+nWWlMu08LdKfi6D7A3VQ3wi4BJeB9NaboapXV7W5YGCiQDAH5Nupsjbd5
 sBQFDkCKLlfkTxZhiO8tglxc5HnO1wU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-LEKY_5MROqW-69yW3V9cVQ-1; Fri, 30 May 2025 03:14:56 -0400
X-MC-Unique: LEKY_5MROqW-69yW3V9cVQ-1
X-Mimecast-MFC-AGG-ID: LEKY_5MROqW-69yW3V9cVQ_1748589295
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-602e863492cso1828365a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589294; x=1749194094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LreXCX5lf0B8e68ccMZZleAOkfyyuU+H/pIa6hQpwkY=;
 b=I0W5vpZ6zwTnKDpZ98ogtB0oIX41axD/cE29jp8UQDf2fSK6+DrHhdrBSEF8EQI7RO
 Nn5H3VOBejN5kuBLx0xA95IIpznDLa6Majb30S9WvBm8duKgvyadMe2KnLpQF/M0cMpK
 vLghBeqZS4gtYlUHQjgmRz+Av78+Fv0o7S2G3YiPtnmKehPSLt+B8P3CyC9rv603ppUJ
 SQu+DETBiN2FUuWFctwI6et+xuM/c7g8sKmWVEiqH48dP340eq2TR9hPOE5GlTWi9bHK
 9hiRPVVWK53nA3CqYboRZA0W6bj6bLsaODdqq1VW8nFKCuGhORdBa87tDbi2yf95Vq/c
 QFmw==
X-Gm-Message-State: AOJu0Yx9Oqllvx8/htBlnPsUKgOoe4tKuib+7l/nFYFWRr3TX+YI53IS
 Ahum5HnqtyWsCskpZV/tS7BCteMjuGluVj4sC/HahJUdEbbnuyzUQ7kqPagLvj0gkPRQeXoU+gB
 yi+f1sMnKJfHbQRlR8YxAFenrOL4OFpV73gi8YzBlmmiz3pGWfG/dr20iaDOb5P0O4XfolQfkDo
 IhU2Iag5qrMoMn93xZnyel42BTogKzCZlFeznwiCH5
X-Gm-Gg: ASbGnctmTCTxNBzSdO4jYzqSX+IlSoOZWdmfaB62ah4iZaf9FCd/+ifiVh7jICpMJhX
 MsA0sL3ghqC4HxXMcZym4dchf2XlU3RyCRWVD8P+DU3eGX4v0GzS8Hgoo0uoPbWityIjP0ib9e0
 F4vgj/yM8R9TYJElRIuiWnI1tUY7o+D37EAiO+NgtCjK1Eety4p9FQVJOMj2EONGAdMHg7sm5tq
 5Z7gfcLcFjB0NqN1yCV6blRuUYu+MjseijqSKdPgrezEbTVcbFf8uzvz3JPdsrd+Nqu8kOxljrg
 f5U9FVSUYmY9TA==
X-Received: by 2002:a05:6402:518f:b0:602:1d01:2883 with SMTP id
 4fb4d7f45d1cf-6057c1a5032mr974069a12.1.1748589294363; 
 Fri, 30 May 2025 00:14:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHekAEAtg5DkGoaT0QOix2+QF3Od5JF+JwDssgHPaNKpXwMv7LU+1J3gkB3Z113ETz+ZKs4ZA==
X-Received: by 2002:a05:6402:518f:b0:602:1d01:2883 with SMTP id
 4fb4d7f45d1cf-6057c1a5032mr974052a12.1.1748589293887; 
 Fri, 30 May 2025 00:14:53 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60567169d14sm1167317a12.74.2025.05.30.00.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 49/77] i386/tdx: Disable PIC for TDX VMs
Date: Fri, 30 May 2025 09:12:19 +0200
Message-ID: <20250530071250.2050910-50-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Legacy PIC (8259) cannot be supported for TDX VMs since TDX module
doesn't allow directly interrupt injection.  Using posted interrupts
for the PIC is not a viable option as the guest BIOS/kernel will not
do EOI for PIC IRQs, i.e. will leave the vIRR bit set.

Hence disable PIC for TDX VMs and error out if user wants PIC.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-38-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 87c5bf04960..32c3f3795d0 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -381,6 +381,13 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -EINVAL;
     }
 
+    if (x86ms->pic == ON_OFF_AUTO_AUTO) {
+        x86ms->pic = ON_OFF_AUTO_OFF;
+    } else if (x86ms->pic == ON_OFF_AUTO_ON) {
+        error_setg(errp, "TDX VM doesn't support PIC");
+        return -EINVAL;
+    }
+
     if (!tdx_caps) {
         r = get_tdx_capabilities(errp);
         if (r) {
-- 
2.49.0


