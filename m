Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C822FCD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 14:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl7oi-0002Uf-Ss; Mon, 02 Sep 2024 10:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl7of-0002TI-7y
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl7od-0003ti-Mg
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725286438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y4DwS1BL1h2jrMAsCmucsldRngOw4DGs+ZC+A1Y+hKI=;
 b=R3ou53LvKm+8r6cQYv7/BDYD0Ydx9ZdP/Rn6kD0FI3LA9XQj8Iw63vQFrIE5NSR0ISh/pc
 L5ERF5R2D5rtaYUzi0rZDzFmtzaLx3GGyGkP25LPFG/WgnZDLJFRuuX7wzJS18jx6KP87o
 AmYqBIL5h7pWw+YeIifvJsbKun1SjFU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-6mDbTzH6O6WDhBtLlfYWBA-1; Mon, 02 Sep 2024 10:13:57 -0400
X-MC-Unique: 6mDbTzH6O6WDhBtLlfYWBA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42c7936e4ebso20499675e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 07:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725286436; x=1725891236;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4DwS1BL1h2jrMAsCmucsldRngOw4DGs+ZC+A1Y+hKI=;
 b=IpsX9eYkq2XndYURNpNn1HGkc8DfBf/AJw3miue7LhhPA4WFmdPnxCJVTPNzW5VDZ4
 jxCZfHF/blyIaIRqJOCniB0LYLEibNqvz0Hih5nN/JqG/k4CNzx8jxhN08XrCtQASSn5
 JyroKjboc/xZhD5M0M/eLciWr0m97igkOCHqrGn2mmXQZmo8ORTUV7D8H0e1zECVBwgG
 efEvJRMBj95flaxh14U2cSLEahQnAapka65wyD3KE2X1N2Wx4yxHvyBj5RKmPPJG5n6K
 I9L1249c1ErTsbJjVICT5kKIMJVYWMhBvMVWNWLsLadcohvD7t0+CzWMat+FtuULeUwG
 9VIw==
X-Gm-Message-State: AOJu0Yynem2G8LuKl7A7jhdq15e/OauHYIXH5xlOdNOq95Ey+Y8rtF+m
 UzifYWuRSoaTY38pqPxup+HQqF1KP4gVNg0LKJnNd8hrs69/F59ZBRLnVfuJTT17eBQyZyOEWW+
 7O5BWT650hKdYO2FhduWnYhShI08OZabPqOhSuH95XxddLuUKOwzp
X-Received: by 2002:a05:600c:3c8b:b0:426:5e91:391e with SMTP id
 5b1f17b1804b1-42bdc64e46dmr46961305e9.26.1725286435972; 
 Mon, 02 Sep 2024 07:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9SFvT8Su7Y1p+VVu9wokSREazoN+OO9U6oQsLWlsS4/+x/FC+vF9OHRjU0OmtvfHAudq4QA==
X-Received: by 2002:a05:600c:3c8b:b0:426:5e91:391e with SMTP id
 5b1f17b1804b1-42bdc64e46dmr46960845e9.26.1725286435110; 
 Mon, 02 Sep 2024 07:13:55 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.206.174])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6deb2f5sm139696665e9.2.2024.09.02.07.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 07:13:54 -0700 (PDT)
Date: Mon, 2 Sep 2024 16:13:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v5 05/16] i386/pc_sysfw: Ensure sysfw flash configuration
 does not conflict with IGVM
Message-ID: <k2ajnmyh7nyfbnxk6nnrhe3o33onsgwehcwf3isewlhxg3zxdd@sofco6pgjuks>
References: <cover.1723560001.git.roy.hopkins@suse.com>
 <f81b6f66d2145f76341ad055d15006fbbc042dd5.1723560001.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f81b6f66d2145f76341ad055d15006fbbc042dd5.1723560001.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Aug 13, 2024 at 04:01:07PM GMT, Roy Hopkins wrote:
>When using an IGVM file the configuration of the system firmware is
>defined by IGVM directives contained in the file. In this case the user
>should not configure any pflash devices.
>
>This commit skips initialization of the ROM mode when pflash0 is not set
>then checks to ensure no pflash devices have been configured when using
>IGVM, exiting with an error message if this is not the case.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>---
> hw/i386/pc_sysfw.c | 31 ++++++++++++++++++++++++++++---
> 1 file changed, 28 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>index ef80281d28..f5e40b3ef6 100644
>--- a/hw/i386/pc_sysfw.c
>+++ b/hw/i386/pc_sysfw.c
>@@ -219,7 +219,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
>     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>
>     if (!pcmc->pci_enabled) {
>-        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
>+        /*
>+         * If an IGVM file is specified then the firmware must be provided
>+         * in the IGVM file.
>+         */
>+        if (!X86_MACHINE(pcms)->igvm) {
>+            x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
>+        }
>         return;
>     }
>
>@@ -239,8 +245,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
>     }
>
>     if (!pflash_blk[0]) {
>-        /* Machine property pflash0 not set, use ROM mode */
>-        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
>+        /*
>+         * Machine property pflash0 not set, use ROM mode unless using IGVM,
>+         * in which case the firmware must be provided by the IGVM file.
>+         */
>+        if (!X86_MACHINE(pcms)->igvm) {
>+            x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
>+        }
>     } else {
>         if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
>             /*
>@@ -256,6 +267,20 @@ void pc_system_firmware_init(PCMachineState *pcms,
>     }
>
>     pc_system_flash_cleanup_unused(pcms);
>+
>+    /*
>+     * The user should not have specified any pflash devices when using IGVM
>+     * to configure the guest.
>+     */
>+    if (X86_MACHINE(pcms)->igvm) {
>+        for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
>+            if (pcms->flash[i]) {
>+                error_report("pflash devices cannot be configured when "
>+                             "using IGVM");
>+                exit(1);
>+            }
>+        }
>+    }
> }
>
> void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
>-- 
>2.43.0
>


