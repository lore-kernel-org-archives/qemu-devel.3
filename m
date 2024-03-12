Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54574C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk64c-0002Bj-Lx; Tue, 12 Mar 2024 13:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk64U-0002AP-GP
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk64S-0007en-H9
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710265066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GMxyfUPTkwLMk4UHIQVI4jHKCYQHz5KGpUGPZqappI8=;
 b=TZQs0eNfv4pWyTatj2a1yZKN20LnIC/9xKmhEjuLFanAmd7tSfgIHNTGqojDcXdMiSM1Od
 QepAw4bOvnfjaOPoGEXFe6KvIalmyVthy2frB/h0nW7ibkPWslgr/xhCriAWW/E1oT1bEL
 1sn9DbV0iL9B70tbjhbgFMR9ghJizkY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-1fiJnHaUMwObkkeufDaj6g-1; Tue, 12 Mar 2024 13:37:45 -0400
X-MC-Unique: 1fiJnHaUMwObkkeufDaj6g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4131b4161dcso21099445e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 10:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710265063; x=1710869863;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMxyfUPTkwLMk4UHIQVI4jHKCYQHz5KGpUGPZqappI8=;
 b=IBK4hK3BCcaPErY4wh2XQMHTruf2PL8ynrvLb+JLr+Ku+CDZauFYrtLkScW72TwmdC
 ohc2/sN3nlpC/wv6E1LDJEeAectLOY5q6EIZzL0LF1jM9VhaAZCgy8L21DS99CxmgQo6
 JpQeQlAROAHhZKBBkPVmRICOhNCYIDw+ebNoolyHn5X+ZsoMtOToPkTKxSSpBM059MUM
 +V1jotu20C/blhL0t5KbT41obAZA6VxcjcyJkQsJ96bCY1T5t/jE4QYKlCrONYNN4R0n
 YVTFTjC5+48Xox0tUdUzmOHzdmRFns0M0mj0TMcJwx9pXJIFO+dVT+1heewi7SMDHyt0
 h7Fw==
X-Gm-Message-State: AOJu0YzgByslq+C9qU1OqQ/K1NY9aJ1sGua0rmJlpSvK+uGBA2sridSU
 S3kVU/wQ9q3iQF4goPFur59ZTLolMEBtkhe6mR7mCNzBf1Nz5CzOeh9BpPebkL3EcStvVIk+ON5
 iBpNcwgaKJq1UIoeelku+SyzzQl0YEDoUy0RUYCddxLF+U+6XoGtM5RF+6iZIokU=
X-Received: by 2002:a05:600c:4709:b0:412:8fef:7f with SMTP id
 v9-20020a05600c470900b004128fef007fmr8552596wmo.1.1710265063228; 
 Tue, 12 Mar 2024 10:37:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExojlzYXZGJ8NHT2Vlrz43+6jdl33jwBYIwLfProONydshwjBs/S17wriHq+e7PIleU6HChQ==
X-Received: by 2002:a05:600c:4709:b0:412:8fef:7f with SMTP id
 v9-20020a05600c470900b004128fef007fmr8552580wmo.1.1710265062709; 
 Tue, 12 Mar 2024 10:37:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a5d5291000000b0033d2ae84fafsm9500611wrv.52.2024.03.12.10.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:37:42 -0700 (PDT)
Date: Tue, 12 Mar 2024 13:37:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/20] Workaround Windows failing to find 64bit SMBIOS
 entry point with SeaBIOS
Message-ID: <20240312133702-mutt-send-email-mst@kernel.org>
References: <20240312161050.2248814-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312161050.2248814-1-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 12, 2024 at 05:10:30PM +0100, Igor Mammedov wrote:
> Changelog:
>  v3:
>    * whitespace missed by checkpatch
>    * fix idndent in QAPI
>    * reorder 17/20 before 1st 'auto' can be used
>    * pick up acks
>  v2:
>    * QAPI style fixes (Markus Armbruster <armbru@redhat.com>)
>    * squash 11/19 into 10/19 (Ani Sinha <anisinha@redhat.com>)
>    * split '[PATCH 09/19] smbios: build legacy mode code only for 'pc' machine'
>      in 3 smaller patches, to make it more readable
>        smbios: add smbios_add_usr_blob_size() helper                                  
>        smbios: rename/expose structures/bitmaps used by both legacy and modern code                                                                  
>        smbios: build legacy mode code only for 'pc' machine
>    * pick up acks

I think I'll do this after the freeze, it's a bugfix so ok to do then.
Will probably need a rebase, too.


> Windows (10) bootloader when running on top of SeaBIOS, fails to find            
> SMBIOSv3 entry point. Tracing it shows that it looks for v2 anchor markers       
> only and not v3. Tricking it into believing that entry point is found            
> lets Windows successfully locate and parse SMBIOSv3 tables. Whether it           
> will be fixed on Windows side is not clear so here goes a workaround.            
>                                                                                  
> Idea is to try build v2 tables if QEMU configuration permits,                    
> and fallback to v3 tables otherwise. That will mask Windows issue                
> form majority of users.                                                          
> However if VM configuration can't be described (typically large VMs)             
> by v2 tables, QEMU will use SMBIOSv3 and Windows will hit the issue              
> again. In this case complain to Microsoft and/or use UEFI instead of             
> SeaBIOS (requires reinstall).                                                    
>                                                                                  
> Default compat setting of smbios-entry-point-type after series                   
> for pc/q35 machines:                                                             
>   * 9.0-newer: 'auto'                                                            
>   * 8.1-8.2: '64'                                                                
>   * 8.0-older: '32'                                                              
>                                                                                  
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2008                        
> CC: imammedo@redhat.com                                                          
> CC: mst@redhat.com
> 
> Igor Mammedov (20):
>   tests: smbios: make it possible to write SMBIOS only test
>   tests: smbios: add test for -smbios type=11 option
>   tests: smbios: add test for legacy mode CLI options
>   smbios: cleanup smbios_get_tables() from legacy handling
>   smbios: get rid of smbios_smp_sockets global
>   smbios: get rid of smbios_legacy global
>   smbios: avoid mangling user provided tables
>   smbios: don't check type4 structures in legacy mode
>   smbios: add smbios_add_usr_blob_size() helper
>   smbios: rename/expose structures/bitmaps used by both legacy and
>     modern code
>   smbios: build legacy mode code only for 'pc' machine
>   smbios: handle errors consistently
>   smbios: get rid of global smbios_ep_type
>   smbios: clear smbios_type4_count before building tables
>   smbios: extend smbios-entry-point-type with 'auto' value
>   smbios: in case of entry point is 'auto' try to build v2 tables 1st
>   smbios: error out when building type 4 table is not possible
>   tests: acpi/smbios: whitelist expected blobs
>   pc/q35: set SMBIOS entry point type to 'auto' by default
>   tests: acpi: update expected SSDT.dimmpxm blob
> 
>  hw/i386/fw_cfg.h                     |   3 +-
>  include/hw/firmware/smbios.h         |  28 +-
>  hw/arm/virt.c                        |   6 +-
>  hw/i386/Kconfig                      |   1 +
>  hw/i386/fw_cfg.c                     |  14 +-
>  hw/i386/pc.c                         |   4 +-
>  hw/i386/pc_piix.c                    |   4 +
>  hw/i386/pc_q35.c                     |   3 +
>  hw/loongarch/virt.c                  |   7 +-
>  hw/riscv/virt.c                      |   6 +-
>  hw/smbios/Kconfig                    |   2 +
>  hw/smbios/meson.build                |   4 +
>  hw/smbios/smbios.c                   | 481 +++++++++++----------------
>  hw/smbios/smbios_legacy.c            | 185 +++++++++++
>  hw/smbios/smbios_legacy_stub.c       |  15 +
>  qapi/machine.json                    |   5 +-
>  tests/data/acpi/q35/SSDT.dimmpxm     | Bin 1815 -> 1815 bytes
>  tests/data/smbios/type11_blob        | Bin 0 -> 11 bytes
>  tests/data/smbios/type11_blob.legacy | Bin 0 -> 10 bytes
>  tests/qtest/bios-tables-test.c       |  81 ++++-
>  20 files changed, 533 insertions(+), 316 deletions(-)
>  create mode 100644 hw/smbios/smbios_legacy.c
>  create mode 100644 hw/smbios/smbios_legacy_stub.c
>  create mode 100644 tests/data/smbios/type11_blob
>  create mode 100644 tests/data/smbios/type11_blob.legacy
> 
> -- 
> 2.39.3


