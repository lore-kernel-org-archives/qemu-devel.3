Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D046FC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 10:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhS6K-0002KO-1s; Tue, 05 Mar 2024 05:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rhS6I-0002Jw-If
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rhS6F-0003PM-G1
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709634762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vDMOG858kwohsjaFQnfhqCCejlVxFcw1ADU0gyslJk=;
 b=PxJdcyebzLDOQBbb2It9sf1BPhRfKQPVpmPktxLOJfnqbuDSOGLdGk2XCG2E64KLGJBV3l
 PaAXaGoUNvfgameIKvcjJV5dHpyujHbuCCiDPD9XMbOZ/VURNYroyHMxLCjGllHDltYu67
 EIWj2BE6DGkVnY/Zldo1dMo4cSXM12E=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-AJpdIhm9OoaJ_DtdvMvStw-1; Tue, 05 Mar 2024 05:32:41 -0500
X-MC-Unique: AJpdIhm9OoaJ_DtdvMvStw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6e5d996a3dcso2372999b3a.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 02:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709634760; x=1710239560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vDMOG858kwohsjaFQnfhqCCejlVxFcw1ADU0gyslJk=;
 b=qZ0FdVelH+ggMYh/kiQ+XvmR9GTVrGPlxLHXrTD/GwCpV7WGxbIGlCdc5gvhvwhO3L
 Wx6uyRKzw3u2WufrZv3GYBn7CzHrXCZNE7GF8m7HEHMp4iZ8AN1pS7IHz9oVsafN6coB
 ZyHNKStC59liyjxC0i1dwsAu69HxBO/9PypaehLaL1qVNJdNu3+3gqOoVroDxT40BDIp
 LrQSmJH6i8N7Wyc8D8bVcBjZ//LJyIK8SEbUU9nn5jjxNbpSs4D9e9LkF46amp1yjASl
 shzkuvhbZVhBj6h4UzR7gOjzCpySyHpIKjvd76399KexuwO9Fs8TWKLlpbuxf2vnLIbU
 cLlw==
X-Gm-Message-State: AOJu0YwS1CYg9hQFk52lS20RHp68xiuS0fAzagfPpVwaGeszDIkvy9uo
 kdWm914/SXP+ba+3DCP1iZ56OltSjUqgsSC2TW8lFz1qNiA/U1YmU2u5mvLFPu+dkrcUtLkKiag
 69cQv/MkwCrL/UIBc9Hu4CJHMdzuA/GVBGELxjrTAmYmaAJib2bjF
X-Received: by 2002:a05:6a00:2288:b0:6e5:fb97:ed35 with SMTP id
 f8-20020a056a00228800b006e5fb97ed35mr8011353pfe.18.1709634759903; 
 Tue, 05 Mar 2024 02:32:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyz/i29xOvqC5LpAfkn519rkysFPw5L32Dxd2+STcTASTjwl2hw7012/AkBfNd5NZ95dSiwg==
X-Received: by 2002:a05:6a00:2288:b0:6e5:fb97:ed35 with SMTP id
 f8-20020a056a00228800b006e5fb97ed35mr8011331pfe.18.1709634759542; 
 Tue, 05 Mar 2024 02:32:39 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 le6-20020a056a004fc600b006e6150a5392sm3748585pfb.155.2024.03.05.02.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 02:32:38 -0800 (PST)
Date: Tue, 5 Mar 2024 11:32:32 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 gaosong@loongson.cn, alistair.francis@wdc.com, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, anisinha@redhat.com, philmd@linaro.org,
 wangyanan55@huawei.com, eblake@redhat.com, armbru@redhat.com,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, f.ebner@proxmox.com
Subject: Re: [PATCH 00/19] Workaround Windows failing to find 64bit SMBIOS
 entry point with SeaBIOS
Message-ID: <20240305113232.791c116e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240305050735-mutt-send-email-mst@kernel.org>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240305050735-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, 5 Mar 2024 05:08:05 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Feb 27, 2024 at 04:47:30PM +0100, Igor Mammedov wrote:
> > Windows (10) bootloader when running on top of SeaBIOS, fails to find            
> > SMBIOSv3 entry point. Tracing it shows that it looks for v2 anchor markers       
> > only and not v3. Tricking it into believing that entry point is found            
> > lets Windows successfully locate and parse SMBIOSv3 tables. Whether it           
> > will be fixed on Windows side is not clear so here goes a workaround.            
> >                                                                                  
> > Idea is to try build v2 tables if QEMU configuration permits,                    
> > and fallback to v3 tables otherwise. That will mask Windows issue                
> > form majority of users.                                                          
> > However if VM configuration can't be described (typically large VMs)             
> > by v2 tables, QEMU will use SMBIOSv3 and Windows will hit the issue              
> > again. In this case complain to Microsoft and/or use UEFI instead of             
> > SeaBIOS (requires reinstall).                                                      
> 
> Igor so you want to repost a version with a couple of patches squashed?

requested changes where in several patches
(style and making series easier to review),

I'll repost series with those changes today. 
 

> > Default compat setting of smbios-entry-point-type after series                   
> > for pc/q35 machines:                                                             
> >   * 9.0-newer: 'auto'                                                            
> >   * 8.1-8.2: '64'                                                                
> >   * 8.0-older: '32'                                                              
> >                                                                                  
> > Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2008                        
> > CC: peter.maydell@linaro.org                                                     
> > CC: pbonzini@redhat.com                                                          
> > CC: mst@redhat.com                                                               
> > CC: gaosong@loongson.cn                                                          
> > CC: alistair.francis@wdc.com                                                     
> > CC: palmer@dabbelt.com                                                           
> > CC: bin.meng@windriver.com                                                       
> > CC: liwei1518@gmail.com                                                          
> > CC: dbarboza@ventanamicro.com                                                    
> > CC: zhiwei_liu@linux.alibaba.com                                                 
> > CC: imammedo@redhat.com                                                          
> > CC: anisinha@redhat.com                                                          
> > CC: philmd@linaro.org                                                            
> > CC: wangyanan55@huawei.com                                                       
> > CC: eblake@redhat.com                                                            
> > CC: armbru@redhat.com                                                            
> > CC: qemu-arm@nongnu.org                                                          
> > CC: qemu-riscv@nongnu.org                                                        
> > CC: f.ebner@proxmox.com                                                          
> >                           
> > Igor Mammedov (19):
> >   tests: smbios: make it possible to write SMBIOS only test
> >   tests: smbios: add test for -smbios type=11 option
> >   tests: smbios: add test for legacy mode CLI options
> >   smbios: cleanup smbios_get_tables() from legacy handling
> >   smbios: get rid of smbios_smp_sockets global
> >   smbios: get rid of smbios_legacy global
> >   smbios: avoid mangling user provided tables
> >   smbios: don't check type4 structures in legacy mode
> >   smbios: build legacy mode code only for 'pc' machine
> >   smbios: handle errors consistently
> >   smbios: clear smbios_tables pointer after freeing
> >   get rid of global smbios_ep_type
> >   smbios: extend smbios-entry-point-type with 'auto' value
> >   smbios: in case of entry point is 'auto' try to build v2 tables 1st
> >   smbios: error out when building type 4 table is not possible
> >   smbios: clear smbios_type4_count before building tables
> >   tests: acpi/smbios: whitelist expected blobs
> >   pc/q35: set SMBIOS entry point type to 'auto' by default
> >   tests: acpi: update expected SSDT.dimmpxm blob
> > 
> >  hw/i386/fw_cfg.h                     |   3 +-
> >  include/hw/firmware/smbios.h         |  29 +-
> >  hw/arm/virt.c                        |   6 +-
> >  hw/i386/Kconfig                      |   1 +
> >  hw/i386/fw_cfg.c                     |  14 +-
> >  hw/i386/pc.c                         |   4 +-
> >  hw/i386/pc_piix.c                    |   4 +
> >  hw/i386/pc_q35.c                     |   3 +
> >  hw/loongarch/virt.c                  |   7 +-
> >  hw/riscv/virt.c                      |   6 +-
> >  hw/smbios/Kconfig                    |   2 +
> >  hw/smbios/meson.build                |   4 +
> >  hw/smbios/smbios.c                   | 481 +++++++++++----------------
> >  hw/smbios/smbios_legacy.c            | 185 +++++++++++
> >  hw/smbios/smbios_legacy_stub.c       |  16 +
> >  qapi/machine.json                    |   5 +-
> >  tests/data/acpi/q35/SSDT.dimmpxm     | Bin 1815 -> 1815 bytes
> >  tests/data/smbios/type11_blob        | Bin 0 -> 11 bytes
> >  tests/data/smbios/type11_blob.legacy | Bin 0 -> 10 bytes
> >  tests/qtest/bios-tables-test.c       |  81 ++++-
> >  20 files changed, 535 insertions(+), 316 deletions(-)
> >  create mode 100644 hw/smbios/smbios_legacy.c
> >  create mode 100644 hw/smbios/smbios_legacy_stub.c
> >  create mode 100644 tests/data/smbios/type11_blob
> >  create mode 100644 tests/data/smbios/type11_blob.legacy
> > 
> > -- 
> > 2.39.3  
> 


