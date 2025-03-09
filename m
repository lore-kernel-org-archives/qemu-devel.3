Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FB8C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDxM-0000U4-J0; Sun, 09 Mar 2025 06:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDx7-0008Pu-4F
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDx5-00045L-Mv
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQpu7Fg7nG7FJGPLBMD8H+r3cpml2kmQYbEDHrDsnBc=;
 b=Zy0ORAhguyXYke04nTbxWUypoqWinlXdM+VhQxhFO3RyRpY0qW768ACWb25rdq8H8VdPlI
 XHquvV0P8UQqb2XWiEg3jkZysSvK2pcdfZ/5p9cIZ01bOdLWCKXrSP6eBOt56QCh54CH4k
 TQOSjJGZsL8c2IQ+8WqRkNhPMYdZTxE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-iK4eyUm4P26WTE-5WeIblA-1; Sun, 09 Mar 2025 06:32:09 -0400
X-MC-Unique: iK4eyUm4P26WTE-5WeIblA-1
X-Mimecast-MFC-AGG-ID: iK4eyUm4P26WTE-5WeIblA_1741516328
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43bd0586b86so22431785e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516328; x=1742121128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQpu7Fg7nG7FJGPLBMD8H+r3cpml2kmQYbEDHrDsnBc=;
 b=JwjZdx9OF2l/hmBWI0BYufbdpHSnLWCO9WyuI81EgVEJl9D4y6MtIp6CfiZAgz0GIP
 VHYODTG97RnivhaX5kvNrsTsBaimWvZ6HoL6FH9nT6xZmOzZCwii47miCfu/kdD7xEOP
 td3OFVBH4GktkzUq52x86o6Zl9ChG++w8iAAHAMjmsob3t3g+ogjPdgNKjwBfDrMF3im
 sp9XdoUMHiHDPtWpg7uLusOFQ+khxahcWSrHHOsvVPu+WGlUPN7vnOdMqt+0V9IhTjiH
 D0Nl4d4UjYhsWTyjIN3uaMStHmVgYCshuJAKrE1h25JBPD61tUgpi0v+979QGZzPgyqO
 B7MQ==
X-Gm-Message-State: AOJu0Yx4IeMgo3y7vaaizRXoCGkxEpgJwUnbrCbZ+024dzlxDdnz8hgt
 ai/PclwYyH+S00sjVwxxDXIkdz787cZ7emHgccGxHDA/Xgi5vybCaZXDabmteojSJP6UPtHGW1h
 TUrAcHs5gIAn5coXiLWlP8GGlgtARZmbDyX5wVgLzBbrEyAjcKOBzwPhgKV1YWBqr3w+jVOeR9x
 CENeukQNni9mCVZZ68vtNxq1zW4J7B8REgFzK8iHY=
X-Gm-Gg: ASbGncumWpu8j8wb6T1XRxTm14QPu/W24bitGzBfu23uZtObBF9vCubzf1vDf677Rtx
 BvsMnChoH0qJ5/zORKrFUq7BIoP6HlMiUXMnNHwbJ0F2e2WuAvdhD69BD2EuS0gyhfPwW6GmVD5
 fdnxLdnLUBhq4ddY1hNcYIq+Rj1/D4UoBg3J0My5SWGvyZQsXq4SVYB3UXjE7A2eZ/rpl3WHhi/
 69D2Dtu5Vc7fbPqessS0Tbd1R4U+XScQWJhG/INNxZYtiXH7agJ4Xm0wKHwUrDhoEsA4H1nfG4O
 XrcoB9bpD2T5dPJpJcs2RA==
X-Received: by 2002:a05:600c:4fcc:b0:439:30bd:7df9 with SMTP id
 5b1f17b1804b1-43c601d93c7mr55904935e9.9.1741516327658; 
 Sun, 09 Mar 2025 03:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBE2IQ1lbtcKJtuXjuuudxHWBkQviq0iYHj/tJwtukJQTQWWbUGArhxys10lEYTpYyPVdP7Q==
X-Received: by 2002:a05:600c:4fcc:b0:439:30bd:7df9 with SMTP id
 5b1f17b1804b1-43c601d93c7mr55904845e9.9.1741516327174; 
 Sun, 09 Mar 2025 03:32:07 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce3d5a0e2sm58128765e9.12.2025.03.09.03.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:32:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 22/25] rust: cell: add full example of declaring a SysBusDevice
Date: Sun,  9 Mar 2025 11:31:16 +0100
Message-ID: <20250309103120.1116448-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/cell.rs | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 448638e8967..ab0785a2692 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -73,6 +73,34 @@
 //! QEMU device implementations is usually incorrect and can lead to
 //! thread-safety issues.
 //!
+//! ### Example
+//!
+//! ```
+//! # use qemu_api::prelude::*;
+//! # use qemu_api::{c_str, cell::BqlRefCell, irq::InterruptSource, irq::IRQState};
+//! # use qemu_api::{sysbus::SysBusDevice, qom::Owned, qom::ParentField};
+//! # const N_GPIOS: usize = 8;
+//! # struct PL061Registers { /* ... */ }
+//! # unsafe impl ObjectType for PL061State {
+//! #     type Class = <SysBusDevice as ObjectType>::Class;
+//! #     const TYPE_NAME: &'static std::ffi::CStr = c_str!("pl061");
+//! # }
+//! struct PL061State {
+//!     parent_obj: ParentField<SysBusDevice>,
+//!
+//!     // Configuration is read-only after initialization
+//!     pullups: u32,
+//!     pulldowns: u32,
+//!
+//!     // Single values shared with C code use BqlCell, in this case via InterruptSource
+//!     out: [InterruptSource; N_GPIOS],
+//!     interrupt: InterruptSource,
+//!
+//!     // Larger state accessed by device methods uses BqlRefCell or Mutex
+//!     registers: BqlRefCell<PL061Registers>,
+//! }
+//! ```
+//!
 //! ### `BqlCell<T>`
 //!
 //! [`BqlCell<T>`] implements interior mutability by moving values in and out of
-- 
2.48.1


