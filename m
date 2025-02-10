Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEF5C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQwh-0002P9-Qz; Mon, 10 Feb 2025 05:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwg-0002Ow-SR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwf-0000N7-D0
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739182996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZIZqG/E9D5i5Jo+tlmoRFu4ynuvOisUz6AS8Y0OYPXQ=;
 b=SNpxUiPYkyoZbynHnyflZdGEamUJpm4IeI0cNVV1azwuS+Ok/oKDUmCFQxc71T3AKLzx9l
 A+WASQaJkEhQ7UsMz2xD4e1ksLh8m/XsJ24q7e4HWss0C75xjq6VWxZIc4QiTC0bVb38bM
 LJJHoxHWSxGZJP1Uahv+g7gZwbLrfys=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-GFtZs3FAO8G7UiL31x_gxQ-1; Mon, 10 Feb 2025 05:23:15 -0500
X-MC-Unique: GFtZs3FAO8G7UiL31x_gxQ-1
X-Mimecast-MFC-AGG-ID: GFtZs3FAO8G7UiL31x_gxQ
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5de909cf05dso97995a12.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739182993; x=1739787793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZIZqG/E9D5i5Jo+tlmoRFu4ynuvOisUz6AS8Y0OYPXQ=;
 b=w3AFp4lT3qEtULmGAH+nc26RIwzG6tp/k/nOAGTs/PNp9RGJvnbQwqvdJvPMCBvB+p
 yDevWLHTE1V+h5VfTtIi6400AVX6TOp+jyXa3h1OKi8kETMVC0fvCUH/71Y+/5OpnXMS
 w+q6kD+S80Umf4kkyLNXZ0qQI/bA9WVID9ItLbLkJjhHvaKhPguDvExkr8kLl7vIYp6O
 hS3HGiKi2GhAzI6c6KV6JAIm/Df4vmivHqxdsbE8KdQAOXLW7+P9XPBja58fxfJoErsd
 Mvrho02wV/PgdqdbVM+4IPyULzBqKgYfhy2FLcDEphYXrf/ntmzWfaenZBtm7aI3lOFU
 fezA==
X-Gm-Message-State: AOJu0Yzzh36c/iHB2IBOTKkett3iVhREIUpbjNAfx2zFzPJ57tWaMbIl
 VKz9XhzdyI+B98pQovs4qXib3+jscjB+KtPVS90g5x1waxYulhlRd9rIK8j7T2VYdvSoyj0fgAj
 y/wnVxT5QnUwRg2VPgS7p3G0bwQwso+WsTddbVNboQ70xGWdX3Rv2n2YhdwuNrINqzLsQiFXmhS
 OLE3aDG7EFS2wHDppwZvqt1W3w3c0D+neaTR3AztI=
X-Gm-Gg: ASbGncuThhX/FfZeDttMOKNr/R9i02/yuuvnzgQhZcVF9xH6T4SQhEF5oFBo74OAZUR
 hNARQfQBmWSRPPJSZNPRFy9rYj0ZskSys9N+ng3PAfBymGBK+ZvnON+yIAvULRd8X5JR1NIAYs6
 Syl9uGO6tFekBoBiFjl5y9SssKgyvAPUylko5oWcA5vO3XlA+HS0wQs+jZE41IK7y5/wSuBzIuw
 PfmwE6M2guNZqKYhAxVdUyi3kUObUrBoCkrRj72Tk7KJJJfmakT+FWJofQoyqZPl10a0QsrLMgZ
 lTzSJg==
X-Received: by 2002:a05:6402:4416:b0:5dc:c9ce:b022 with SMTP id
 4fb4d7f45d1cf-5de45005a55mr14306442a12.9.1739182992868; 
 Mon, 10 Feb 2025 02:23:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy5fL0lT9GaNDmcNc/RBQwZNb5t6rRPxWWdmRPF8SPHBew+QLNoiuPT0PLbkOvDfBnI/N+Kw==
X-Received: by 2002:a05:6402:4416:b0:5dc:c9ce:b022 with SMTP id
 4fb4d7f45d1cf-5de45005a55mr14306425a12.9.1739182992438; 
 Mon, 10 Feb 2025 02:23:12 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de4c9b890dsm6032657a12.56.2025.02.10.02.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 02:23:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 8/9] rust: pl011: use default set of lints
Date: Mon, 10 Feb 2025 11:22:53 +0100
Message-ID: <20250210102255.2555097-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210102255.2555097-1-pbonzini@redhat.com>
References: <20250210102255.2555097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Being the first crate added to QEMU, pl011 has a rather restrictive
Clippy setup.  This can be sometimes a bit too heavy on its suggestions,
for example

error: this could be a `const fn`
   --> hw/char/pl011/src/device.rs:382:5
    |
382 | /     fn set_read_trigger(&mut self) {
383 | |         self.read_trigger = 1;
384 | |     }
    | |_____^

Just use the standard set that is present in rust/Cargo.toml, with
just a small adjustment to allow upper case acronyms which are used
for register names.

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/lib.rs | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index e704daf6e3e..3c72f1221ff 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -12,16 +12,7 @@
 //! See [`PL011State`](crate::device::PL011State) for the device model type and
 //! the [`registers`] module for register types.
 
-#![deny(
-    clippy::correctness,
-    clippy::suspicious,
-    clippy::complexity,
-    clippy::perf,
-    clippy::nursery,
-    clippy::style
-)]
 #![allow(clippy::upper_case_acronyms)]
-#![allow(clippy::result_unit_err)]
 
 use qemu_api::c_str;
 
-- 
2.48.1


