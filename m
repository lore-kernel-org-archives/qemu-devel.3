Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3C4C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGJ1-0008F6-Ge; Fri, 24 Jan 2025 04:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGa-0007tu-4c
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGX-00040f-6j
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jllJCe45+on6RBQLoaPv4sZe3uCPs/UzG77MtZEZeWI=;
 b=VBnlwWP4hri/atmw59ZS3v+OaKgoBJ8+pNrLVjVYRsW4BNo1G+UoHhcCpX5EWWPsdaqwpg
 Clh8KJ26KZLIY9iGV1KTGrsPJcWgTrB3IioPvTotYW5uO6nSPgcKM9oD0YYGzPo99jcpTY
 EFBZr4W/dnD6l8fzl2Bn7oC0YzDHfoE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-yGL0HQ7WNnab4xqo0HsLGg-1; Fri, 24 Jan 2025 04:46:14 -0500
X-MC-Unique: yGL0HQ7WNnab4xqo0HsLGg-1
X-Mimecast-MFC-AGG-ID: yGL0HQ7WNnab4xqo0HsLGg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4362f893bfaso10182205e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:46:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711973; x=1738316773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jllJCe45+on6RBQLoaPv4sZe3uCPs/UzG77MtZEZeWI=;
 b=uuOgkFKSgQoC6exybUXY5c+SACe6ERp+94nnSAKuhpSUvJ5oCZBDNQc3eqkL1G4t6k
 Ib+rpCkXtThokBbdBlY65ZAsn27XBVIWxznZEQ8eA/AKHnqJT29lminlz5sPpiIiqQxa
 WIydm7VnXS0e4jNyIu+HHLAphCMi4wTN2Bq3uoXiKjkidnjgmIMTX8y7u3y0W3w9bl0u
 suM9SUBzeREDUh017fTrds5110/dEQJoNzq5pIsY8XXWBGk64sGiU23VJovxypGOMAAo
 Iryu6HYh5Wq9fTMpHrZHkXXXArIJmolLAmFaOy02gqtcKaTLWloR0qRh7JO6RATa4qUV
 wyug==
X-Gm-Message-State: AOJu0YwUotcvn3TdSwdD98hjKvtKTHqfTvN05pXGrFbtqXz6T7zbX+mY
 RBYMCk4mqNkYrv6QMJSCJvrG+iAyGbJANAVtBtNjl5A0T0iTS8EdR1Sh7qrqMVW/tAhL9mhBMpV
 VbHyxLaaQQsM9/8Xo+fEM8sVlu1z/Cg9Nt8Ft9o24TOOE+axxlPE60I/B2Xq+a8XtgcPoQVgMGU
 EuqbBolxHoRasHRzBkHvsD+Z9WpPl19Inyj0Selms=
X-Gm-Gg: ASbGnctF3Pwpd3AvlCSGEB5qmLpjTkNAMHgk4yeIfTAKR2RUSIV2AqpxGPIz40MvZ9N
 q35aUnINFQpy2K9U7wfm97+MrAq0xjEbhByUHD7qVQnKpslPlhKJLIrN5V2FmUoToiWsWuZBc7v
 I2wmqXaOuUnUNuWHWa+gQt9TUyBVkU9W5sjzDBAkHamcxXc/yZZwB+TY4aMkQVUCeZb12IlrvkG
 Qo7Kvw/ihN+hIJ6JCRSyMbWGFFjHWeMRhK5OP+T5hFf/XKr6Dl6KnoDyeMdvLdI6/xYNMVX4Q==
X-Received: by 2002:a05:600c:1f86:b0:436:aaf:7eb9 with SMTP id
 5b1f17b1804b1-43891439d5fmr243292135e9.20.1737711973212; 
 Fri, 24 Jan 2025 01:46:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEn+6TE64XAJLPxZqRdqCYfhcGLvWfGj3Qbgx41WEvAuIx6sHzQULVETYsTgAD3O+Z9BSxNDg==
X-Received: by 2002:a05:600c:1f86:b0:436:aaf:7eb9 with SMTP id
 5b1f17b1804b1-43891439d5fmr243291955e9.20.1737711972713; 
 Fri, 24 Jan 2025 01:46:12 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48ae29sm20961865e9.22.2025.01.24.01.46.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:46:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 46/48] rust: qdev: make reset take a shared reference
Date: Fri, 24 Jan 2025 10:44:40 +0100
Message-ID: <20250124094442.13207-47-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

Because register reset is within a borrow_mut() call, reset
does not need anymore a mut reference to the PL011State.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 4 ++--
 rust/qemu-api/src/qdev.rs        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index e916ea11884..fad190a9133 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -172,7 +172,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&device_class::VMSTATE_PL011)
     }
     const REALIZE: Option<fn(&Self)> = Some(Self::realize);
-    const RESET: Option<fn(&mut Self)> = Some(Self::reset);
+    const RESET: Option<fn(&Self)> = Some(Self::reset);
 }
 
 impl PL011Registers {
@@ -621,7 +621,7 @@ pub fn realize(&self) {
         }
     }
 
-    pub fn reset(&mut self) {
+    pub fn reset(&self) {
         self.regs.borrow_mut().reset();
     }
 
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 42429903aae..f4c75c752f1 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -30,7 +30,7 @@ pub trait DeviceImpl {
     ///
     /// Rust does not yet support the three-phase reset protocol; this is
     /// usually okay for leaf classes.
-    const RESET: Option<fn(&mut Self)> = None;
+    const RESET: Option<fn(&Self)> = None;
 
     /// An array providing the properties that the user can set on the
     /// device.  Not a `const` because referencing statics in constants
-- 
2.48.1


