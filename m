Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E670D59F65
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8l86-0004FI-MT; Wed, 06 Nov 2024 13:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8l85-0004Em-1A
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:51:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8l82-0001mH-PS
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730919101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aWbcRlvcsSCaANOTCyprU0nkMdLErPbdZul48Z+M1PQ=;
 b=Vq6/4YO+saXTAqQXLM5KWWZbev43RFIdE/Dpgry3B3EmduDkwx4PFNLhbnsxVrSvep/r9E
 C1c5Z5uUIMBNmz2uyviyUPYXLrhUG0VERVlppfj2IXsGz4nEYWFgBp2xDGRL3z6tRRTNIm
 lkNrfi997bbZM0c7k+Gx+651cJsDEjA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-QbKFPgSgOxmMGUsomyrFIA-1; Wed, 06 Nov 2024 13:51:40 -0500
X-MC-Unique: QbKFPgSgOxmMGUsomyrFIA-1
X-Mimecast-MFC-AGG-ID: QbKFPgSgOxmMGUsomyrFIA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4327bd6bd60so763065e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730919098; x=1731523898;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aWbcRlvcsSCaANOTCyprU0nkMdLErPbdZul48Z+M1PQ=;
 b=gtgNbdfR2jvtabGXMJbVDh0DWJlSjZvVm64tPi0KN1ARTbf3zC4bpoZdFA8eFmvbzH
 MExcf3XCavS1wexFR0l4dNE7A+rL6x9kQY5X/g53lROhFK0v7lm3x8ZknhHcQ6LHdJQ8
 ehVNXjaZKvqufpHHTSfrYaMxTyn9JSLu2ywJppjXi28Ol2DkgieJTGU6tdvtM2TAY41R
 g64Dox3oto8ASrvR/tttyKrek+jPc952qT0SACbli57V3GJJEzSHOEI4qDwCzadiUZEd
 GzJjL1brgkG5ElnOxwGGI1j/E7YgKozNeZzWhviDp4FYGF1Aw2u1g6CVK+AxGOBM0/cQ
 pNnQ==
X-Gm-Message-State: AOJu0YxMiNSXymsyOtyq0982DYonsJllw/OjC1X8z8C2qe4KbSjQ7gqK
 ADMaVA9ib7GDZUeyQFiEST4YS83JPTiJcUs1cwKuGEUven1m03eTlLbJM+kqlbLRbe7dCBEw0wB
 d5mcYQqNpwDt/1Q0bW2Em7cbQCTaHZHj6QDQnUUIwaO68ZOMKWpgsrqN5t0PK3VTW1QRNCZf+Fk
 bMoL/KYXH2zNZxcOIsedIWoEHIzVLzpm5/VxoPLd0=
X-Received: by 2002:a05:600c:4f83:b0:42c:c28c:e477 with SMTP id
 5b1f17b1804b1-4319ad089b0mr320431765e9.23.1730919098329; 
 Wed, 06 Nov 2024 10:51:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECbc9TLWnQE3rBH5Hmb3hkfezInGqr1McJVamDLzJQ9VET0dyAPw2qwNnpwxLtKS2N/fX8Fw==
X-Received: by 2002:a05:600c:4f83:b0:42c:c28c:e477 with SMTP id
 5b1f17b1804b1-4319ad089b0mr320431505e9.23.1730919097928; 
 Wed, 06 Nov 2024 10:51:37 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a1f8sm35156835e9.30.2024.11.06.10.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 10:51:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH] rust: pl011: fix device id matching
Date: Wed,  6 Nov 2024 19:51:36 +0100
Message-ID: <20241106185136.582198-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The offset that is compared against 0x3f8..0x400 is not shifted right.
Adjust the pattern matching.

Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 2a85960b81f..6556865fc22 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -182,7 +182,7 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u
         use RegisterOffset::*;
 
         std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset) {
-            Err(v) if (0x3f8..0x400).contains(&v) => {
+            Err(v) if (0xfe0..=0xffc).contains(&v) => {
                 u64::from(self.device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
-- 
2.47.0


