Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDDFC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7sK-0007Bo-Ox; Wed, 15 Jan 2025 13:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qz-0000Kd-Nx
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qw-00076O-9k
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+GU4R9++g+qf0tHlV9qLsyuoJZasMIvP+okqs4b+WU=;
 b=WuSIS4Gg6UHHF+PoFj/f3+Fcjgz/x5uVaqU3y/G5GVDypeIuJw6cYMOaE1U9+pLyTVSnxW
 vy7sSE16skhQrVlupRl5XPJOqxaw0IivUV6uUsgjWVhpbTKqK2YcYs7nbCaNGs4TIUpx2f
 a2+Bql3USloyPi6WCrxHxLrL3dW7ovw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-brGT_t7-PNyJME1K37h2fQ-1; Wed, 15 Jan 2025 13:10:51 -0500
X-MC-Unique: brGT_t7-PNyJME1K37h2fQ-1
X-Mimecast-MFC-AGG-ID: brGT_t7-PNyJME1K37h2fQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361c040ba8so39306115e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964650; x=1737569450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+GU4R9++g+qf0tHlV9qLsyuoJZasMIvP+okqs4b+WU=;
 b=vmbOgvrrZbQi54xztcMx4m6+YzOlpr+DnnsIma8kHOFWDiui/QBzqS8GOvW9f9qgG8
 bza5idcIWIx96y0E4sdIQQRZwU0+9hayvZKUsbV+B/KSv0CcY431IB6ZgrQzA//s+2/v
 4djrIX2uAOUXdZc5++hzHUWDLd4fjPI8rzTZB8U6yNGzZCnrAhtMHUlB0s1mDVfCae0D
 /nuCV4RkxwS43KkXi341V+lZgKk38smFW/kh/+4cjTyuwd4ZHP6OqnLZxB5nS7qBvMVg
 YHRKvfgxiO2u3+ObkhHwyllABShCXmKT4x9vguvRU7xzBguV7qrZPFfRAWqsF5l0b1L3
 kwPA==
X-Gm-Message-State: AOJu0Yy9OzVx1dQpin7gqyvLnWey9DsdHhroOou7Uy9hqCo+wzK9RgDr
 ZD40FzH/2L2sRXEcFdAjRzJuzrSl+b3SZpSyZd0LSHJOgjeTUcuvv4OKfUz3g4GCpFCLeg2DJV1
 G7o0mWfPn25iS0KCWm7WqEbE6kIPcTHcx+2eGz8JkR7NXYpoCpS2inlK8jxarO6FGsb6ZjdRo28
 INCCY4G5vtU5K8r4sLZA0a1/hSiB+S2Q==
X-Gm-Gg: ASbGncs+7a0U1QeXMXGWdzyZiDAWD0v+KECB4lalwnKCjRFrFgasYhOXr/Gf9YLADth
 wYNkDEQTmYo+oLy7OtQhq6Sfun/qjLHAWU8R8LwlmnsIIpbbRjl1TicNcsUmP2pxVBB4Ou6Ttp+
 8M1RaliZec0tQTBegpl7iIptHQw6tDakjj0OcKl62fwL8rixtPRiI4dESQD9PRbrHFKDHdV792u
 yHvwzMdiK8y5FHJfuU7IPtEbslBTqwa7df6kHDgAdKkbfUBm0bm
X-Received: by 2002:a05:600c:4eca:b0:434:ea21:e14f with SMTP id
 5b1f17b1804b1-436e26937afmr267364545e9.13.1736964649819; 
 Wed, 15 Jan 2025 10:10:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLQv6ChXKy+XMrZV9qU77ziEl5RcdrKgmd+vXTS336u5qXHslSMgOdTKfRJCryQlgK0drofw==
X-Received: by 2002:a05:600c:4eca:b0:434:ea21:e14f with SMTP id
 5b1f17b1804b1-436e26937afmr267364275e9.13.1736964649410; 
 Wed, 15 Jan 2025 10:10:49 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c475csm32230185e9.20.2025.01.15.10.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:47 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 43/48] tests: acpi: whitelist expected blobs
Message-ID: <1ad32644fe4c9fb25086be15a66dde1d55d3410f.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250115125342.3883374-2-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 40 +++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..085dfa9ff4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,41 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/q35/DSDT",
+"tests/data/acpi/x86/q35/DSDT.acpierst",
+"tests/data/acpi/x86/q35/DSDT.acpihmat",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
+"tests/data/acpi/x86/q35/DSDT.applesmc",
+"tests/data/acpi/x86/q35/DSDT.bridge",
+"tests/data/acpi/x86/q35/DSDT.core-count",
+"tests/data/acpi/x86/q35/DSDT.core-count2",
+"tests/data/acpi/x86/q35/DSDT.cphp",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.dimmpxm",
+"tests/data/acpi/x86/q35/DSDT.ipmibt",
+"tests/data/acpi/x86/q35/DSDT.ipmismbus",
+"tests/data/acpi/x86/q35/DSDT.ivrs",
+"tests/data/acpi/x86/q35/DSDT.memhp",
+"tests/data/acpi/x86/q35/DSDT.mmio64",
+"tests/data/acpi/x86/q35/DSDT.multi-bridge",
+"tests/data/acpi/x86/q35/DSDT.nohpet",
+"tests/data/acpi/x86/q35/DSDT.numamem",
+"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
+"tests/data/acpi/x86/q35/DSDT.thread-count",
+"tests/data/acpi/x86/q35/DSDT.thread-count2",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
+"tests/data/acpi/x86/q35/DSDT.type4-count",
+"tests/data/acpi/x86/q35/DSDT.viot",
+"tests/data/acpi/x86/q35/DSDT.xapic",
-- 
MST


