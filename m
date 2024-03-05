Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1F6C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 10:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhRic-00045T-Oi; Tue, 05 Mar 2024 05:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rhRib-00044y-BW
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:08:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rhRiZ-0007pG-LN
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709633293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vBFJjak2kPJbPumj6Klm0aRcNBGL6fk+t48daLXgxc4=;
 b=gFwIf56saiyo4gLO+NAOnbD5lhHspBUoUdKrSK1bBTypC00D1g4wwzUg4lL+QcFD4QmTGb
 JD8OUk33+we5g60iyj7PSi0w+/Ti/3NLlTs5kDXDOq2vORT1kA6zpxb6EeaA/7c5M9vq6B
 aTwasZqxGaG/PmFuf6qp+geK1rP+kCE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-1kKo8N-FPtGhggKoi8UQPQ-1; Tue, 05 Mar 2024 05:08:12 -0500
X-MC-Unique: 1kKo8N-FPtGhggKoi8UQPQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-412ae5704f7so35982345e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 02:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709633291; x=1710238091;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBFJjak2kPJbPumj6Klm0aRcNBGL6fk+t48daLXgxc4=;
 b=dNEmIvIOARQNr1eW1F/dvulkdKJe78psO3naH7ysipzSoKz62Ncyov4memVgHDZB2r
 fx+dbmVt2FJG1eaYNEe7kvZh2nP6cBwDR4tNuI6ETuk6/hWMt9GyHTMKQpcHAJgzsKyP
 SOKA9wq4e1TNuwK2+wbwYxmSyNB4dVNKZjmPWjn/46y5m4PKijGl5C6q36dQhsgriKyp
 YOMIZDT/bCj3ncNMEkt9UjFe5V4xC1lE+KEPUIfS7EUczYi/RrLujxFBU/R8KGaK966P
 SsGjSW42xvRhxKOoqd0WPwk651Wt53XqkHhhANS39gnPXSoqVPtf6u1zZQ0twidlwBL1
 BREA==
X-Gm-Message-State: AOJu0YxC2S4ygSf1y+dwOBI3YtpnlweA3FiLLroLTvd1hxkJjYYhYiOx
 Mr9VWMLichqaScQCuP0yDLyNF4OLcCLW3n/SJtvR8Bm4X44rwP4wZ2q6jNwhJTKdVSHCLuAb1Fd
 BGoAMMdGAJoB+3dx7HKaGsZdh7HQvDp9crqXwuviUIJUs/YMvvaLf
X-Received: by 2002:a05:600c:444c:b0:412:efe5:7fcb with SMTP id
 v12-20020a05600c444c00b00412efe57fcbmr156623wmn.39.1709633290944; 
 Tue, 05 Mar 2024 02:08:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYzCL4mG5M7+KIVv8xdqugBIWcbXjCA47hgErz6+RHKIS9fS4b+lQ0QidUoxxlDSjPV7BJgQ==
X-Received: by 2002:a05:600c:444c:b0:412:efe5:7fcb with SMTP id
 v12-20020a05600c444c00b00412efe57fcbmr156596wmn.39.1709633290565; 
 Tue, 05 Mar 2024 02:08:10 -0800 (PST)
Received: from redhat.com ([2.52.130.198]) by smtp.gmail.com with ESMTPSA id
 be10-20020a05600c1e8a00b00412ea14ff91sm2578048wmb.21.2024.03.05.02.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 02:08:10 -0800 (PST)
Date: Tue, 5 Mar 2024 05:08:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 gaosong@loongson.cn, alistair.francis@wdc.com, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 anisinha@redhat.com, philmd@linaro.org, wangyanan55@huawei.com,
 eblake@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, f.ebner@proxmox.com
Subject: Re: [PATCH 00/19] Workaround Windows failing to find 64bit SMBIOS
 entry point with SeaBIOS
Message-ID: <20240305050735-mutt-send-email-mst@kernel.org>
References: <20240227154749.1818189-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227154749.1818189-1-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 27, 2024 at 04:47:30PM +0100, Igor Mammedov wrote:
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

Igor so you want to repost a version with a couple of patches squashed?


> Default compat setting of smbios-entry-point-type after series                   
> for pc/q35 machines:                                                             
>   * 9.0-newer: 'auto'                                                            
>   * 8.1-8.2: '64'                                                                
>   * 8.0-older: '32'                                                              
>                                                                                  
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2008                        
> CC: peter.maydell@linaro.org                                                     
> CC: pbonzini@redhat.com                                                          
> CC: mst@redhat.com                                                               
> CC: gaosong@loongson.cn                                                          
> CC: alistair.francis@wdc.com                                                     
> CC: palmer@dabbelt.com                                                           
> CC: bin.meng@windriver.com                                                       
> CC: liwei1518@gmail.com                                                          
> CC: dbarboza@ventanamicro.com                                                    
> CC: zhiwei_liu@linux.alibaba.com                                                 
> CC: imammedo@redhat.com                                                          
> CC: anisinha@redhat.com                                                          
> CC: philmd@linaro.org                                                            
> CC: wangyanan55@huawei.com                                                       
> CC: eblake@redhat.com                                                            
> CC: armbru@redhat.com                                                            
> CC: qemu-arm@nongnu.org                                                          
> CC: qemu-riscv@nongnu.org                                                        
> CC: f.ebner@proxmox.com                                                          
>                           
> Igor Mammedov (19):
>   tests: smbios: make it possible to write SMBIOS only test
>   tests: smbios: add test for -smbios type=11 option
>   tests: smbios: add test for legacy mode CLI options
>   smbios: cleanup smbios_get_tables() from legacy handling
>   smbios: get rid of smbios_smp_sockets global
>   smbios: get rid of smbios_legacy global
>   smbios: avoid mangling user provided tables
>   smbios: don't check type4 structures in legacy mode
>   smbios: build legacy mode code only for 'pc' machine
>   smbios: handle errors consistently
>   smbios: clear smbios_tables pointer after freeing
>   get rid of global smbios_ep_type
>   smbios: extend smbios-entry-point-type with 'auto' value
>   smbios: in case of entry point is 'auto' try to build v2 tables 1st
>   smbios: error out when building type 4 table is not possible
>   smbios: clear smbios_type4_count before building tables
>   tests: acpi/smbios: whitelist expected blobs
>   pc/q35: set SMBIOS entry point type to 'auto' by default
>   tests: acpi: update expected SSDT.dimmpxm blob
> 
>  hw/i386/fw_cfg.h                     |   3 +-
>  include/hw/firmware/smbios.h         |  29 +-
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
>  hw/smbios/smbios_legacy_stub.c       |  16 +
>  qapi/machine.json                    |   5 +-
>  tests/data/acpi/q35/SSDT.dimmpxm     | Bin 1815 -> 1815 bytes
>  tests/data/smbios/type11_blob        | Bin 0 -> 11 bytes
>  tests/data/smbios/type11_blob.legacy | Bin 0 -> 10 bytes
>  tests/qtest/bios-tables-test.c       |  81 ++++-
>  20 files changed, 535 insertions(+), 316 deletions(-)
>  create mode 100644 hw/smbios/smbios_legacy.c
>  create mode 100644 hw/smbios/smbios_legacy_stub.c
>  create mode 100644 tests/data/smbios/type11_blob
>  create mode 100644 tests/data/smbios/type11_blob.legacy
> 
> -- 
> 2.39.3


