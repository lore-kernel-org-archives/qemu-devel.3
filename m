Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CC9D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84IB-0007Rz-PC; Mon, 04 Nov 2024 16:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84I7-00071y-R2
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84I5-0005NF-PB
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0gWRq9tKfolk64MhOyIEOoiaX7xr3WJke6cvdMLK1uE=;
 b=Ce/Y5jsAYM3Q19fA3lxvCkIH4vdZ/rOO+oGi+Xlm+v+0OGtcm7fPx3oC3nuunZi22oNoXL
 Q70eLV8BTMRcbZDukqUlrkKvVnCJzT1C4z6AES5Z8wp5TvFXC7AbXyb6LfNhOhN36pyt9x
 aO/KILkpmHQjy/8ii3voyO9OUh3DUvM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-n2JBpFO1PFG2hkh3uW7_yA-1; Mon, 04 Nov 2024 16:07:11 -0500
X-MC-Unique: n2JBpFO1PFG2hkh3uW7_yA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316300bb15so29809965e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:07:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754430; x=1731359230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gWRq9tKfolk64MhOyIEOoiaX7xr3WJke6cvdMLK1uE=;
 b=eELvKrxfGFxoDhKddprSrRnKxnykqt5uyKPh9XzuBL/1+MTiroJ03YuAzyZzax5o46
 wsmFhd8OIH4yImmWBAf23QQTPg3wXgjhCJEjM1R6VkAuGwXl31wbKGwT7mV5Sev3PDcO
 AyhXGv8+bA9wNhrmaFv/t68emKouqxlveOgOgnoOGSupYZeZgj1Sy1sw61Pv3bVf8Xvz
 gktxjGakqdm++6huvQ1uVqvRgvkJ04+B4Lz+D+r8LmgEunnRk/9DUXTYCN2Zfiql91DJ
 QbSFSCk2SRdUtR4zq5a1vWXvfUpSv7oe84kuBRAnXsU71jIbS9fOveiRCqIlWIJt/4MF
 QWqQ==
X-Gm-Message-State: AOJu0Yy5aHULtXrfGeQ3UXlWp7hZh/bHl+U8CBQOBF2FeKTmcl1SS0w8
 3aIV7vc2XHEnuWsjMw4LZWbhsLsJJHlPftn+rGqELJlpjEoA2gJm2z4rb0tDKnxcDxVWLeeL3tq
 WugDqAj8jX69CmmDcdxx74i2xvfoMMvSl9BvlYqxjIhEmRlWodHn5g8eW3YA3F2NtEH8Z2hLOAn
 5kd8iGix0p2xk9YcMV5p3X0qmvyraUbw==
X-Received: by 2002:adf:cc8f:0:b0:37d:52b5:451e with SMTP id
 ffacd0b85a97d-3806118aa34mr24569599f8f.33.1730754430027; 
 Mon, 04 Nov 2024 13:07:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpEEvYRY7UEWHf80vONs7JSf6d3m5pY/1PNQSJIoyw2DYqAfwCELJtMCMjzAFz6xk0siW/8g==
X-Received: by 2002:adf:cc8f:0:b0:37d:52b5:451e with SMTP id
 ffacd0b85a97d-3806118aa34mr24569583f8f.33.1730754429494; 
 Mon, 04 Nov 2024 13:07:09 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116a7a6sm14152264f8f.92.2024.11.04.13.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:07:08 -0800 (PST)
Date: Mon, 4 Nov 2024 16:07:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 24/65] acpi/disassemle-aml.sh: fix up after dir reorg
Message-ID: <feb58e3b261db503ade94c5f43ccedeee4eac41f.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We moved expected files around, fix up the disassembler script.

Fixes: 7c08eefcaf ("tests/data/acpi: Move x86 ACPI tables under x86/${machine} path")
Fixes: 7434f90467 ("tests/data/acpi/virt: Move ARM64 ACPI tables under aarch64/${machine} path")
Cc: "Sunil V L" <sunilvl@ventanamicro.com>
Message-ID: <ce456091058734b7f765617ac5dfeebcb366d4a9.1730729695.git.mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/data/acpi/disassemle-aml.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/data/acpi/disassemle-aml.sh b/tests/data/acpi/disassemle-aml.sh
index 253b7620a0..89561d233d 100755
--- a/tests/data/acpi/disassemle-aml.sh
+++ b/tests/data/acpi/disassemle-aml.sh
@@ -14,7 +14,7 @@ while getopts "o:" arg; do
   esac
 done
 
-for machine in tests/data/acpi/*
+for machine in tests/data/acpi/*/*
 do
     if [[ ! -d "$machine" ]];
     then
-- 
MST


