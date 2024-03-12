Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596B3C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAcA-0002qG-T4; Tue, 12 Mar 2024 18:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbj-0002Hc-5A
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbh-0004Xu-Iw
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RVo6YlMfVuw9z+NrVasJcWSQp6XiMZPaDOieWuMq5y8=;
 b=I3/S8yUMYuA+lxVFwulY6obp7sFmAjDYteSqSbM46epN8SHs5mjEFPKQbOfOeeE2IHznLA
 oUywls2Q30T6RFQYBT7yeUvbn3h46ZtiTIYxNdo59N8Hj1etfOJf0HqZqqZxHI6g0q66iI
 gPbBPdE2xf4GXmbv6Iynvi717DHWL7c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-bVqveck9PgWG6QTBjmO5lg-1; Tue, 12 Mar 2024 18:28:23 -0400
X-MC-Unique: bVqveck9PgWG6QTBjmO5lg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a448cfe2266so494050466b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282502; x=1710887302;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVo6YlMfVuw9z+NrVasJcWSQp6XiMZPaDOieWuMq5y8=;
 b=jWB9ljVGoV4yU3alW66FnwI+1CZhZdf1H3CKSqYZq/wj3UMqmjIqawBinxdO6s1Ddq
 FrSYqjevP29JmQK0uasmhcFSBW1oyvH/kaP4nvY/NUl0yNg1HdBsg36SE2bYwc6J39X7
 A+sSEBZFl0+bfENSXPHEPNZ+Q7TIPwWJD7tvO/UvQFgs7rBZL9J4fRvrIsD1xDWlRzal
 hwVauQgPrrnkk/qSvYwbNbtRs6fU2o9UbjHzwCyxvjnm4py56Fp8hFdpP9FCPz7zUgGq
 KWfjYgOc/GPVkfXp9VgEutrHSfK8krzXndnquPp9haPxJ/IOI2lxCdQbgyXxFUYEFKP9
 GBXQ==
X-Gm-Message-State: AOJu0Yz36V2y1ygEpn1ZjyVffzBnC/gUiIetfLkF1zvu+TLI7jcXhAbV
 0BLlj7pr4RWCZzSm+ddOr+9TOsUJpfTzn72E2eoN1GaG/0+xpw5LZviPoWImfXOzNTMMtBbk6aq
 x/dHIr8YWWmZoCMauNE7gs3wpt5Gzlde6IyO/EEPnp7R3HLep8XMPMw/UQsEUf0p/1IJclAItnJ
 EwEM8jbztcIm/sdBuU9MJwVPnecVuWs6ho
X-Received: by 2002:a17:907:a095:b0:a46:127a:61a7 with SMTP id
 hu21-20020a170907a09500b00a46127a61a7mr6829711ejc.72.1710282501626; 
 Tue, 12 Mar 2024 15:28:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKmhgE/ofZZ8UXO0d8b/a5qbMynNr/sGPXj4AU0/5oQEyY+6946rHDoK9dFWkAwQ5wl0+9dA==
X-Received: by 2002:a17:907:a095:b0:a46:127a:61a7 with SMTP id
 hu21-20020a170907a09500b00a46127a61a7mr6829692ejc.72.1710282500977; 
 Tue, 12 Mar 2024 15:28:20 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 s19-20020a170906501300b00a433f470cf1sm4252594ejj.138.2024.03.12.15.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:20 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 52/68] hw/i386/pc: Set "normal" boot device order in
 pc_basic_device_init()
Message-ID: <c5e2d74448433c3d800dca6160b5c8fbd76c67d8.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

The boot device order may change during the lifetime of a VM. Usually, the
"normal" order is set once during machine init(). However, if a user specifies
`-boot once=...`, the "normal" order is overwritten by the "once" order just
before machine_done, and a reset handler is registered which restores the
"normal" order during the next reset.

In the next patch, pc_cmos_init() will be inlined into pc_cmos_init_late() which
runs during machine_done. This means that the "once" boot order would be
overwritten again with the "normal" boot order -- which renders the user's
choice ineffective. Fix this by setting the "normal" boot order in
pc_basic_device_init() which already registers the boot_set() handler.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240303185332.1408-4-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4077d8162c..c614697ca6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -614,8 +614,6 @@ void pc_cmos_init(PCMachineState *pcms,
     mc146818rtc_set_cmos_data(s, 0x5c, val >> 8);
     mc146818rtc_set_cmos_data(s, 0x5d, val >> 16);
 
-    set_boot_dev(pcms, s, MACHINE(pcms)->boot_config.order, &error_fatal);
-
     val = 0;
     val |= 0x02; /* FPU is there */
     val |= 0x04; /* PS/2 mouse installed */
@@ -1254,6 +1252,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
 #endif
 
     qemu_register_boot_set(pc_boot_set, pcms);
+    set_boot_dev(pcms, MC146818_RTC(rtc_state),
+                 MACHINE(pcms)->boot_config.order, &error_fatal);
 
     if (!xen_enabled() &&
         (x86ms->pit == ON_OFF_AUTO_AUTO || x86ms->pit == ON_OFF_AUTO_ON)) {
-- 
MST


